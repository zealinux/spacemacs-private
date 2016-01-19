;;; packages.el --- wqn-code Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq wqn-code-packages
    '(
      ;; package names go here
      ;; editorconfig
      org
      org-mac-link
      evil-vimish-fold
      ))

;; List of packages to exclude.
(setq wqn-code-excluded-packages '())

;; For each package, define a function wqn-code/init-<package-name>
;;
;; (defun wqn-code/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package

(defun wqn-code/init-org-mac-link ()
  (use-package org-mac-link
    :init
    (add-hook 'org-mode-hook (lambda ()
                               (define-key org-mode-map (kbd "C-c g") 'org-mac-grab-link)))))

(defun wqn-code/post-init-org ()
  (progn
    ;; https://github.com/zilongshanren/spacemacs-private/blob/develop/layers/zilongshanren/packages.el#L958
    (use-package org-crypt)
    (org-crypt-use-before-save-magic)
    (setq org-crypt-tag-matcher "secret")
    (setq org-tags-exclude-from-inheritance (quote ("secret")))
    (setq org-crypt-key nil)
    (setq auto-save-default nil)
    ;; To turn it off only locally
    ;; # -*- buffer-auto-save-file-name: nil; -*-
    (setq org-todo-keywords
          (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
                  (sequence "WAITING(w@/!)" "SOMEDAY(S)"  "|" "CANCELLED(c@/!)" "MEETING(m)" "PHONE(p)"))))
    ;; org-agenda
    (setq org-tags-match-list-sublevels nil)
    (setq org-agenda-custom-commands
          '(
            ("w" . "任务安排")
            ("wa" "重要且紧急的任务" tags-todo "+PRIORITY=\"A\"")
            ("wb" "重要且不紧急的任务" tags-todo "+PRIORITY=\"B\"")
            ("b" "Blog" tags-todo "BLOG")
            ("p" . "项目安排")
            ("pw" tags-todo "PROJECT+WORK+CATEGORY=\"cocos2d-x\"")
            ("pl" tags-todo "PROJECT+DREAM+CATEGORY=\"zilongshanren\"")
            ("W" "Weekly Review"
             ((stuck "")            ;; review stuck projects as designated by org-stuck-projects
              (tags-todo "PROJECT") ;; review all projects (assuming you use todo keywords to designate projects)
              ))))
    (spacemacs//set-monospaced-font   "Source Code Pro" "Hiragino Sans GB" 14 16)
    ))

(defun wqn-code/init-evil-vimish-fold ()
  (use-package evil-vimish-fold
    :init
    (vimish-fold-global-mode 1)))
