call plug#begin('~/.vim/plugged')
Plug 'kyazdani42/nvim-web-devicons'
Plug 'https://github.com/sainnhe/gruvbox-material'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'https://github.com/windwp/nvim-autopairs'
Plug 'luochen1990/rainbow'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'ur4ltz/surround.nvim'
Plug 'djoshea/vim-autoread'
Plug 'https://github.com/tpope/vim-obsession'
Plug 'https://github.com/joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'EdenEast/nightfox.nvim'
Plug 'akinsho/bufferline.nvim'
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'akinsho/toggleterm.nvim'
Plug 'wellle/context.vim'
Plug 'wadackel/vim-dogrun'
Plug 'szebniok/tree-sitter-wgsl'
Plug 'elixir-editors/vim-elixir'
call plug#end()

colorscheme dogrun
set number " Line numbers
set noshowmode " Remove mode from under status bar
set relativenumber " Turns on relative line numbers by default
set laststatus=3 " One global status line for all windows in buffer instead of 1 for each
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set termguicolors
set hidden

" Highlight current line in active buffer only
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

augroup NumberToggleInsert
    " Disables relative line numbers in insert mode
    autocmd InsertEnter * set norelativenumber|set number
    autocmd InsertLeave * set relativenumber|set nonumber
augroup END

augroup NumberToggleCmd
    " Disables relative line numbers in command mode
    autocmd CmdlineEnter * if &l:number != "number" || &l:relativenumber != "relativenumber" | set norelativenumber|set number|redraw | endif
    autocmd CmdlineLeave * if &l:number != "number" || &l:relativenumber != "relativenumber" | set relativenumber|set nonumber|redraw | endif
augroup END

let mapleader = "!" " The leader used for Telescope commands and barbar bindings
let g:rainbow_active = 1
let g:rainbow_conf = {
            \    'guifgs': ['#F1E8B8', '#2EC4B6', '#7067CF', '#F25F5C'],
            \}

let g:context_add_mappings = 0

set shm+=I

let g:neoformat_try_node_exe = 1 
let &shell='/opt/homebrew/bin/bash --rcfile /Users/uglyluigi/.bashrc'
" barbar stuff

noremap <silent> L :BufferLineCycleNext<cr>
noremap <silent> H :BufferLineCyclePrev<cr>

" Telescope commands
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope file_browser<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader><Up> <C-w><Up>
nnoremap <leader><Down> <C-w><Down>
nnoremap <leader><Left> <C-w><Left>
nnoremap <leader><Right> <C-w><Right>
nnoremap <silent> <leader>pb :BufferLineTogglePin<cr>
nnoremap <leader>= <C-w>=
nnoremap <C-`> :ToggleTerm<cr>
nnoremap <leader>cb :BufferLinePickClose<cr>
nnoremap <leader>cl :BufferLineCloseLeft<cr>
nnoremap <leader>cr :BufferLineCloseRight<cr>

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <s-cr> <Esc>o

map J 5j
map K 5k
map E ea
map Q A;<Esc>

tnoremap <Esc> <C-\><C-n>
" Push escape to remove highlighting after search, substitution, etc.
map <silent> <Esc> :noh<CR>

" Lualine config
lua << END
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
    },

    sections = {
        lualine_a = {'mode'},
        lualine_b = {'filename'}, 
        lualine_c = {''},
        lualine_x = {'encoding'},
        lualine_y = {'branch', 'diff', {'diagnostics', sources = {'coc'}}},
        lualine_z = {'%l of %L'},
    },
}

telescope = require('telescope')
telescope.load_extension("live_grep_args")
telescope.load_extension("file_browser")
telescope.setup{ 
    defaults = { 
        file_ignore_patterns = {"node_modules", "target"},
        layout_strategy = 'vertical',
        layout_config = {
            vertical = {width = 0.5}
        },
        initial_mode = 'normal',
    },
}

require('colorizer').setup {}

require('surround').setup {}

require('bufferline').setup {
    options = {
        separator_style = 'slant',
        close_icon = '',
        buffer_close_icon = '',
    }
}

require("toggleterm").setup {
    direction = 'float',
    shell = vim.o.shell,
    persist_mode = false,

    float_opts = {
        border = 'curved',
        width = 85,
        height = 25,
        winblend = 3,
    }
}


END


function OpenConfig()
    e ~/.config/nvim/init.vim
endfunction

" COC STUFF
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes:1

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


function! CheckBackspace() abort 
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> <C-Space> :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd TermOpen * setlocal nonumber norelativenumber scl=no

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-cursor)
nmap <leader>a  <Plug>(coc-codeaction-cursor)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


function! Terminal_cd()
        if &buftype == 'terminal'
                call chansend(b:terminal_job_id, 'NVIM_LISTEN_ADDRESS= cd "' . getcwd() . "\"\<cr>")
        endif
endfunction

function! Terminal_restore()
        let curtab = tabpagenr()
        let curwin = winnr()
        tabdo windo call Terminal_cd()
        exec curtab . 'tabn'
        exec curwin . 'wincmd w'
endfunction
