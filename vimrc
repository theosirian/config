execute pathogen#infect()

set nocompatible

set encoding=UTF-8

syntax on

" good themes
" blackbeauty; blacksea: chocolateliquor; earendel; freya; golden; inkpot; jellybeans; leo;
" lettuce; matrix; moss; motus; Mustang; neon; peachpuff; railscasts; solarized; synic; tabula;
"color inkpot
colorscheme tolerable
filetype on
filetype plugin indent on

set title
set mouse=a
set shortmess=at
set nrformats+=alpha

set modeline
set modelines=5

set number
set relativenumber
set numberwidth=8
set ruler
set colorcolumn=80
set cursorline

set backspace=2

set background=dark

set hidden
set confirm
set equalalways

set lazyredraw
set noshowmode

set tabstop=2
set expandtab
set shiftwidth=2

"map <F2> <ESC>:TSelectBuffer

set cinoptions+=j1
let java_comment_strings=1
let java_highlight_java_lang_ids=1
let java_mark_braces_in_parens_as_errors=1
let java_highlight_all=1
let java_highlight_debug=1
let java_ignore_javadoc=1
let java_highlight_java_lang_ids=1
let java_highlight_functions="style"
let java_minlines = 150

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1
let g:airline_theme='light'

let g:rustfmt_autosave = 1

let g:livepreview_previewer = "zathura"
let g:polyglot_disabled = ['latex']

let g:ale_linters_explicit = 1
let g:ale_linters = {'javascript': ['eslint'], 'rust': ['rls']}
let g:ale_fixers = {'javascript': ['prettier', 'eslint']}

let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_sign_column_always = 1
let g:ale_rust_rls_executable ="/usr/bin/rls"
let g:ale_rust_rls_toolchain = "stable"

let g:racer_cmd = '/home/xtheosirian/.cargo/bin/racer'
let g:racer_experimental_completer = 1
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)

fun! MyFormat()
  if &ft =~ 'javascript\|typescript\|jsx\|html\|css\|scss\|less\|graphql\|markdown\|vue\|json'
    Prettier
  elseif &ft =~ 'pug'
    echo "pug fuck you"
  elseif &ft != ''
    Autoformat
  else
    echo "No filetype!"
  endif
endfun

"au BufWrite * call MyFormat()

au! BufNewFile,BufRead *.glslv,*.glslf set ft=glsl

map <silent> <F3> <ESC>:w<CR>
map <silent> <F5> <ESC>:wa<CR>
map <silent> <F7> <ESC>:Autoformat<CR>
map <silent> <F10> <ESC>:mks!<CR>

set formatprg=par\ j1w80
"set formatprg=par\ P+\*P+\-P+\+P+$\ 80j
map <F6> <ESC>mkggVGgq`k

au FileType yaml,python,qaf let b:autoformat_autoindent = 0
au FileType yaml,python,qaf let b:autoformat_retab = 0
au FileType yaml,python,qaf let b:autoformat_remove_trailing_spaces = 0

nnoremap - :call bufferhint#Popup()<CR>
nnoremap \ :call bufferhint#LoadPrevious()<CR>

" Maps Alt-[h,j,k,l] to resizing a window split
map <silent> <A-h> <C-w><
map <silent> <A-j> <C-W>-
map <silent> <A-k> <C-W>+
map <silent> <A-l> <C-w>>

" Maps Alt-[s.v] to horizontal and vertical split respectively
map <silent> <A-s> :split<CR>
map <silent> <A-v> :vsplit<CR>

" Maps Alt-[n,p] for moving next and previous window respectively
map <silent> <A-n> <C-w><C-w>
map <silent> <A-p> <C-w><S-w>

map <C-n> :NERDTreeToggle<CR>
vnoremap <C-R> "hy:%s/<C-R>h//gc<left><left><left>

" Window resizing mappings /*{{{*/
function! Resize(dir)
  let this = winnr()
  if '+' == a:dir || '-' == a:dir
    execute "normal \<c-w>k"
    let up = winnr()
    if up != this
      execute "normal \<c-w>j"
      let x = 'bottom'
    else
      let x = 'top'
    endif
  elseif '>' == a:dir || '<' == a:dir
    execute "normal \<c-w>h"
    let left = winnr()
    if left != this
      execute "normal \<c-w>l"
      let x = 'right'
    else
      let x = 'left'
    endif
  endif
  if ('+' == a:dir && 'bottom' == x) || ('-' == a:dir && 'top' == x)
    return "5\<c-v>\<c-w>+"
  elseif ('-' == a:dir && 'bottom' == x) || ('+' == a:dir && 'top' == x)
    return "5\<c-v>\<c-w>-"
  elseif ('<' == a:dir && 'left' == x) || ('>' == a:dir && 'right' == x)
    return "5\<c-v>\<c-w><"
  elseif ('>' == a:dir && 'left' == x) || ('<' == a:dir && 'right' == x)
    return "5\<c-v>\<c-w>>"
  else
    echo "oops.  check your ~/.vimrc"
    return ""
  endif
endfunction

"nnoremap <S-Up> :normal <c-r>=Resize('+')<CR><CR>
"nnoremap <S-Down> :normal <c-r>=Resize('-')<CR><CR>
"nnoremap <S-Left> :normal <c-r>=Resize('<')<CR><CR>
"nnoremap <S-Right> :normal <c-r>=Resize('>')<CR><CR>

map <Up> <C-W>+
map <Down> <C-W>-
map <Left> <c-w><
map <Right> <c-w>>

" /*}}}*/

"Search in all currently opened buffers
function! ClearQuickfixList()
  call setqflist([])
endfunction
function! Vimgrepall(pattern)
  call ClearQuickfixList()
  exe 'bufdo vimgrepadd ' . a:pattern . ' %'
  cnext
endfunction
command! -nargs=1 Vim call Vimgrepall(<f-args>)

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

au BufRead,BufNewFile *.nani set syntax=nani
