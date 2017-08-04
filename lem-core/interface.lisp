(in-package :lem-interface)

(defvar *interface-functions* '())

(defmacro define-interface (name args &body body)
  `(progn
     (defun ,name ,args
       (let ((f (get ',name 'implementation)))
         (cond (f (funcall f ,@args))
               (t ,@body))))
     (pushnew ',name *interface-functions*)
     ',name))

(defmacro define-implementation (name args &body body)
  `(progn
     (setf (get ',name 'implementation)
           (flet ((,name ,args ,@body)) #',name))
     ',name))

(define-interface set-foreground (name))
(define-interface set-background (name))
(define-interface display-background-mode ())
(define-interface set-display-background-mode (mode))
(define-interface call-with-screen (function) (funcall function))
(define-interface make-screen (x y width height use-modeline-p))
(define-interface screen-delete (screen))
(define-interface screen-modify (screen))
(define-interface screen-set-size (screen width height))
(define-interface screen-set-pos (screen x y))
(define-interface screen-clear (screen))
(define-interface display-width ())
(define-interface display-height ())
(define-interface screen-print-string (screen x y string attribute))
(define-interface redraw-display-window (window force))
(define-interface update-display ())
(define-interface print-echoarea (string doupdate-p))
(define-interface input-loop (editor-thread))
