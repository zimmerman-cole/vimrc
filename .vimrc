syntax on
colorscheme onedark

set nocompatible
filetype off 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdcommenter'

call vundle#end()
filetype plugin indent on

" SOURCE (for many of these things) -
" https://blog.petrzemek.net/2016/04/06/things-about-vim-i-wish-i-knew-earlier/

" =======================================================================================================
" Use relative numbers
set number
set relativenumber

" =======================================================================================================
" Disable arrow keys in Normal mode
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" =======================================================================================================
" Remap (j/k) to (gj/gk) to make j/k move by virtual lines instead of physical lines
" (NOT WORKING??)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" =======================================================================================================
" SOURCE - https://stackoverflow.com/questions/6527698/setting-to-skip-over-punctuation-when-moving-forwards-and-backwards-words
"
" <SPACE> 	: forward to next word beginning with alphanumeric char
" <S-SPACE>:	: backward to prev word beginning with alphanumeric char
" <C-SPACE>:	: same as above (as <S-SPACE>) not available in console Vim
" <BS>		: back to prev word ending with alphanumeric char
function! <SID>GotoPattern(pattern, dir) range
	let g:_saved_search_reg = @/
	let l:flags = "We"
	if a:dir == "b"
		let l:flags .= "b"
	endif
	for i in range(v:count1)
		call search(a:pattern, l:flags)
	endfor
	let @/ = g:_saved_search_reg
endfunction

nnoremap <silent> <SPACE> :<C-U>call <SID>GotoPattern('\(^\\|\<\)[A-Za-z0-9_]', 'f')<CR>
vnoremap <silent> <SPACE> :<C-U>let g:_saved_search_reg=@/<CR>gv/\(^\\|\<\)[A-Za-z0-9_]<CR>:<C-U>let @/=g:_saved_search_reg<CR>gv
nnoremap <silent> <S-SPACE> :<C-U>call <SID>GotoPattern('\(^\\|\<\)[A-Za-z0-9_]', 'b')<CR>
vnoremap <silent> <S-SPACE> :<C-U>let g:_saved_search_reg=@/<CR>gv?\(^\\|\<\)[A-Za-z0-9_]<CR>:<C-U>let @/=g:_saved_search_reg<CR>gv
nnoremap <silent> <BS> :call <SID>GotoPattern('[A-Za-z0-9_]\(\>\\|$\)', 'b')<CR>
vnoremap <silent> <BS> :<C-U>let g:_saved_search_reg=@/<CR>gv?[A-Za-z0-9_]\(\>\\|$\)<CR>:<C-U>let @/=g:_saved_search_reg<CR>gv

" Redundant mapping of <C-SPACE> to <S-SPACE> so that
" above mappings are available in console Vim.
noremap <C-@> <C-B>
if has("gui_running")
    map <silent> <C-Space> <S-SPACE>
else
    if has("unix")
        map <Nul> <S-SPACE>
    else
        map <C-@> <S-SPACE>
    endif
endif
