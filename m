Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2FC80CFA7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344338AbjLKPet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344149AbjLKPej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:34:39 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F0F113
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:34:43 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5cb6271b225so55220827b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702308883; x=1702913683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=94KRbEOaeqxQm3SgYKPsnMsADDWoAca3HEStnoYGEas=;
        b=AvS8ayPRtHF2EhKQsPDSinFvOX/P+YAt+3RM43OCGrnIjgNjI9epR+d8un2tIUyWoa
         Onw7+EEEsbSPWtAMKQFn1cq/Ytf1m1kIwkZolr88aG6RzWwUUMuAk6lhjwtqmUJYoKS5
         XF7LSZePjbpNCQEsq+8oMPsy4MB1R8aOD2HoW7luBkQppNZjxLuAfXn8ujy0KMAKhNo7
         +PXjteIjrOs+TlMGXzCgMvVdpNObzpSU1QrXPjeFBCYgejo+p9jD8L4COldZcx1puNnq
         DoyhxH+2kfTOLReHNovoz91C8PPIvVt4ltxAzUMysw1aAODo3WBKcc4HvhYoWZ5X0Hgu
         Y57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308883; x=1702913683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94KRbEOaeqxQm3SgYKPsnMsADDWoAca3HEStnoYGEas=;
        b=DRH2Rst+nwJA1BMvx7dVe0SQlIC3m9V+kCvDJ0/s3F1j6EuOEd+F2eLVlabKzYSKxW
         kgtqDj+HnSh4WHiFThkjpVyBcOT79yvZ4W0qn9kSO0Q6lDJfoSNRFl0s8DLZsJxdNZ7P
         PoaY7KJDQRyCQHUhArl52LnZZbkFarlSIZpLIvQhfPFhdCmaoZSboKUhawrL6j0+WeNQ
         CBL2GcbO22NKYO5Xq3KI0kbq95WKWGnDssNnmFZEpOEerzJa2JN67Fi/obCtvFSOhKsT
         sIFkvzCm1FcfZbFkMNyGD1JySKfwzklZp/RnpxSDF9oSGGXy6MlXD/msnSdvPquibvjD
         QHyw==
X-Gm-Message-State: AOJu0YwPWfvh7j98LD6xI6S0Ob12eebkkS87qBJSPWspRoYFE0aC3eQu
        A7vrhNzThqWUVrtoyYCk2l0z2JM9Q3m+iP0=
X-Google-Smtp-Source: AGHT+IEBnuwnY4Zf82RfAkC+XY+vbHKvcI+MlUUtIpfL03LFb5VzvzSE1el2F4S4HulQyFNsFPUFB1YYtI+AunI=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:c07:b0:5d8:95b:af79 with SMTP
 id cl7-20020a05690c0c0700b005d8095baf79mr44110ywb.6.1702308883025; Mon, 11
 Dec 2023 07:34:43 -0800 (PST)
Date:   Mon, 11 Dec 2023 15:34:40 +0000
In-Reply-To: <MjDmZBGV04fVI1qzhceEjQgcmoBuo3YoVuiQdANKj9F1Ux5JFKud8hQpfeyLXI0O5HG6qicKFaYYzM7JAgR_kVQfMCeVdN6t7PjbPaz0D0U=@proton.me>
Mime-Version: 1.0
References: <MjDmZBGV04fVI1qzhceEjQgcmoBuo3YoVuiQdANKj9F1Ux5JFKud8hQpfeyLXI0O5HG6qicKFaYYzM7JAgR_kVQfMCeVdN6t7PjbPaz0D0U=@proton.me>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231211153440.4162899-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 6/7] rust: file: add `DeferredFdCloser`
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        aliceryhl@google.com, arve@android.com, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, brauner@kernel.org, cmllamas@google.com,
        dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org,
        peterz@infradead.org, rust-for-linux@vger.kernel.org,
        surenb@google.com, tglx@linutronix.de, tkjos@android.com,
        viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benno Lossin <benno.lossin@proton.me> writes:
> On 12/6/23 12:59, Alice Ryhl wrote:
> > +    /// Schedule a task work that closes the file descriptor when this task returns to userspace.
> > +    ///
> > +    /// Fails if this is called from a context where we cannot run work when returning to
> > +    /// userspace. (E.g., from a kthread.)
> > +    pub fn close_fd(self, fd: u32) -> Result<(), DeferredFdCloseError> {
> > +        use bindings::task_work_notify_mode_TWA_RESUME as TWA_RESUME;
> > +
> > +        // In this method, we schedule the task work before closing the file. This is because
> > +        // scheduling a task work is fallible, and we need to know whether it will fail before we
> > +        // attempt to close the file.
> > +
> > +        // SAFETY: Getting a pointer to current is always safe.
> > +        let current = unsafe { bindings::get_current() };
> > +
> > +        // SAFETY: Accessing the `flags` field of `current` is always safe.
> > +        let is_kthread = (unsafe { (*current).flags } & bindings::PF_KTHREAD) != 0;
> 
> Since Boqun brought to my attention that we already have a wrapper for
> `get_current()`, how about you use it here as well?

I can use the wrapper, but it seems simpler to not go through a
reference when we just need a raw pointer.

Perhaps we should have a safe `Task::current_raw` function that just
returns a raw pointer? It can still be safe.

> > +        if is_kthread {
> > +            return Err(DeferredFdCloseError::TaskWorkUnavailable);
> > +        }
> > +
> > +        // This disables the destructor of the box, so the allocation is not cleaned up
> > +        // automatically below.
> > +        let inner = Box::into_raw(self.inner);
> 
> Importantly this also lifts the uniqueness requirement (maybe add this
> to the comment?).

I can update the comment.

> > +
> > +        // The `callback_head` field is first in the struct, so this cast correctly gives us a
> > +        // pointer to the field.
> > +        let callback_head = inner.cast::<bindings::callback_head>();
> > +        // SAFETY: This pointer offset operation does not go out-of-bounds.
> > +        let file_field = unsafe { core::ptr::addr_of_mut!((*inner).file) };
> > +
> > +        // SAFETY: The `callback_head` pointer is compatible with the `do_close_fd` method.
> 
> Also, `callback_head` is valid, since it is derived from...

I can update the comment.

> > +        unsafe { bindings::init_task_work(callback_head, Some(Self::do_close_fd)) };
> > +        // SAFETY: The `callback_head` pointer points at a valid and fully initialized task work
> > +        // that is ready to be scheduled.
> > +        //
> > +        // If the task work gets scheduled as-is, then it will be a no-op. However, we will update
> > +        // the file pointer below to tell it which file to fput.
> > +        let res = unsafe { bindings::task_work_add(current, callback_head, TWA_RESUME) };
> > +
> > +        if res != 0 {
> > +            // SAFETY: Scheduling the task work failed, so we still have ownership of the box, so
> > +            // we may destroy it.
> > +            unsafe { drop(Box::from_raw(inner)) };
> > +
> > +            return Err(DeferredFdCloseError::TaskWorkUnavailable);
> 
> Just curious, what could make the `task_work_add` call fail? I imagine
> an OOM situation, but is that all?

Actually, no, this doesn't fail in OOM situations since we pass it an
allocation for its linked list. It fails only when the current task is
exiting and wont run task work again.

> > +        }
> > +
> > +        // SAFETY: Just an FFI call. This is safe no matter what `fd` is.
> 
> I took a look at the C code and there I found this comment:
> 
>     /*
>      * variant of close_fd that gets a ref on the file for later fput.
>      * The caller must ensure that filp_close() called on the file.
>      */
> 
> And while you do call `filp_close` later, this seems like a safety
> requirement to me.

I'll mention this.

> Also, you do not call it when `file` is null, which I imagine to be
> fine, but I do not know that since the C comment does not cover that
> case.

Null pointer means that the fd doesn't exist, and it's correct to do
nothing in that case.

> > +        let file = unsafe { bindings::close_fd_get_file(fd) };
> > +        if file.is_null() {
> > +            // We don't clean up the task work since that might be expensive if the task work queue
> > +            // is long. Just let it execute and let it clean up for itself.
> > +            return Err(DeferredFdCloseError::BadFd);
> > +        }
> > +
> > +        // SAFETY: The `file` pointer points at a valid file.
> > +        unsafe { bindings::get_file(file) };
> > +
> > +        // SAFETY: Due to the above `get_file`, even if the current task holds an `fdget` to
> > +        // this file right now, the refcount will not drop to zero until after it is released
> > +        // with `fdput`. This is because when using `fdget`, you must always use `fdput` before
> 
> Shouldn't this be "the refcount will not drop to zero until after it is
> released with `fput`."?
> 
> Why is this the SAFETY comment for `filp_close`? I am not understanding
> the requirement on that function that needs this. This seems more a
> justification for accessing `file` inside `do_close_fd`. In which case I
> think it would be better to make it a type invariant of
> `DeferredFdCloserInner`.

It's because `filp_close` decreases the refcount for the file, and doing
that is not always safe even if you have a refcount to the file. To drop
the refcount, at least one of the two following must be the case:

* If the refcount decreases to a non-zero value, then it is okay.
* If there are no users of `fdget` on the file, then it is okay.

In this case, we are in the first case, as we own two refcounts.

I'll clarify the safety comment in v3.

> > +        // returning to userspace, and our task work runs after any `fdget` users have returned
> > +        // to userspace.
> > +        //
> > +        // Note: fl_owner_t is currently a void pointer.
> > +        unsafe { bindings::filp_close(file, (*current).files as bindings::fl_owner_t) };
> > +
> > +        // We update the file pointer that the task work is supposed to fput.
> > +        //
> > +        // SAFETY: Task works are executed on the current thread once we return to userspace, so
> > +        // this write is guaranteed to happen before `do_close_fd` is called, which means that a
> > +        // race is not possible here.
> > +        //
> > +        // It's okay to pass this pointer to the task work, since we just acquired a refcount with
> > +        // the previous call to `get_file`. Furthermore, the refcount will not drop to zero during
> > +        // an `fdget` call, since we defer the `fput` until after returning to userspace.
> > +        unsafe { *file_field = file };
> 
> A synchronization question: who guarantees that this write is actually
> available to the cpu that executes `do_close_fd`? Is there some
> synchronization run when returning to userspace?

It's on the same thread, so it's just a sequenced-before relation.

It's not like an interrupt. It runs after the syscall invocation has
exited, but before it does the actual return-to-userspace stuff.

> > +
> > +        Ok(())
> > +    }
> > +
> > +    // SAFETY: This function is an implementation detail of `close_fd`, so its safety comments
> > +    // should be read in extension of that method.
> 
> Why not use this?:
> - `inner` is a valid pointer to the `callback_head` field of a valid
>   `DeferredFdCloserInner`.
> - `inner` has exclusive access to the pointee and owns the allocation.
> - `inner` originates from a call to `Box::into_raw`.

I'll update this together with the clarification of `filp_close`.

> > +    unsafe extern "C" fn do_close_fd(inner: *mut bindings::callback_head) {
> > +        // SAFETY: In `close_fd` we use this method together with a pointer that originates from a
> > +        // `Box<DeferredFdCloserInner>`, and we have just been given ownership of that allocation.
> > +        let inner = unsafe { Box::from_raw(inner as *mut DeferredFdCloserInner) };
> 
> Use `.cast()`.

Ok.

> > +        if !inner.file.is_null() {
> > +            // SAFETY: This drops a refcount we acquired in `close_fd`. Since this callback runs in
> > +            // a task work after we return to userspace, it is guaranteed that the current thread
> > +            // doesn't hold this file with `fdget`, as `fdget` must be released before returning to
> > +            // userspace.
> > +            unsafe { bindings::fput(inner.file) };
> > +        }
> > +        // Free the allocation.
> > +        drop(inner);
> > +    }
> > +}
> > +
> > +/// Represents a failure to close an fd in a deferred manner.
> > +#[derive(Copy, Clone, Eq, PartialEq)]
> > +pub enum DeferredFdCloseError {
> > +    /// Closing the fd failed because we were unable to schedule a task work.
> > +    TaskWorkUnavailable,
> > +    /// Closing the fd failed because the fd does not exist.
> > +    BadFd,
> > +}
> > +
> > +impl From<DeferredFdCloseError> for Error {
> > +    fn from(err: DeferredFdCloseError) -> Error {
> > +        match err {
> > +            DeferredFdCloseError::TaskWorkUnavailable => ESRCH,
> 
> This error reads "No such process", I am not sure if that is the best
> way to express the problem in that situation. I took a quick look at the
> other error codes, but could not find a better fit. Do you have any
> better ideas? Or is this the error that C binder uses?

This is the error code that task_work_add returns. (It can't happen in
Binder.)

And I do think that it is a reasonable choice, because the error only
happens if you're calling the method from a context that has no
userspace process associated with it.

Alice
