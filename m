Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C5D805DB7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345889AbjLESQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLESQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:16:34 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBC7AC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:16:40 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3580b94ac2eso34477215ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701800199; x=1702404999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvDZn7sftBIir4+u2Hr7XA8t0/oswoazuSS+rk054aU=;
        b=4jU46IEwm58jeuZBmdGpCc7GnkqmjRNtToApSmtmvVBXGvmrRsIXPJHzid/NRkBED2
         PjtYHX+F/QMG0hmvo93Y7DEvnvsEhwPju3HF7JyJNvkg8b3Ytz5L8yvg/g3ZYnIFCKbx
         1v3WBBeQdysTnFF8nju/MoRHCfiVZeGH7Rnl6v3gdqb5T4uyQyxknpSQS3aBdUlka/OU
         ZxQdjs7vgTWO3xRhgMzHnPtnkqCo7Durp2wjpVlE8whxi2hZfnJqIqdvjlVV5imn+E7f
         6uRfFcUukota4SBxQXaQd6gibwzeEL0lBkl7U8l0mVfZgcDCymY6j2mTxUvBRHrAtIOy
         sWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701800199; x=1702404999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvDZn7sftBIir4+u2Hr7XA8t0/oswoazuSS+rk054aU=;
        b=EVNfRED6Jmz/BrpIS0hlI0NytmY8Xwxntv/cilZfD4ll4yzqXFXXVa8Blw0dtXDF9W
         AD3amKZJkdbsnE/JecURtM2OsputoSyNWaKdw5YuhjjgCJdUs5U8NCUZE35yAlDlw0qp
         kMjfjK41vqMzScgVwshf14WwaMYJw0C1YnSVJrXlhJyMb1ZpxurkfMutBVojtKuMPgqX
         7nIUNrls0hTt9MxRSaxv0QXLQJqwU5Gs59q0vgPta4MonE22oKx2+WIjsZm37Lja2KmR
         dAa+tIwi3Rj7hmQmGFCckiHZG6tv0XgA7w2QGtJZD60EZ4eB8FLnW9hsHcYJDSfR/c9K
         JxBg==
X-Gm-Message-State: AOJu0Yy3ONTqW9WjfsWm7ojhOyfrHBdxsES/yicWLZj+ogH42DKDg9W3
        yIH2nzipdeiIeWlYwSqX0LHwuo0U2FH+v4zw1/d07g==
X-Google-Smtp-Source: AGHT+IEa4EYgTTnLdOrl0nl6mQB3fbLx+1/3UykRuzI0tX+uoBZQQfbPf5J+lEfqYnGJLMqZyqY2Y8NN5ztw4bjxDu4=
X-Received: by 2002:a92:ddce:0:b0:35d:59a2:2bc with SMTP id
 d14-20020a92ddce000000b0035d59a202bcmr6710657ilr.92.1701800199414; Tue, 05
 Dec 2023 10:16:39 -0800 (PST)
MIME-Version: 1.0
References: <bUU6jGtJ7KdkuVp8UPORb0cmDoU6sRjc1iVRMfgO34u5ySo44Z5MXrnYgE6pfQDFu4-V5CBAuhS8uZDoEA6CsIiLUiWJedNZ2CTf9cRATfQ=@proton.me>
 <20231205144345.308820-1-aliceryhl@google.com>
In-Reply-To: <20231205144345.308820-1-aliceryhl@google.com>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Tue, 5 Dec 2023 19:16:27 +0100
Message-ID: <CAH5fLggz5ArqX076OgBaqFF57-f9h1E_hGOeiXfhcfe-neW_jQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] rust: file: add `DeferredFdCloser`
To:     benno.lossin@proton.me, brauner@kernel.org
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
        cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz,
        gary@garyguo.net, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@android.com, ojeda@kernel.org, peterz@infradead.org,
        rust-for-linux@vger.kernel.org, surenb@google.com,
        tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk,
        wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 3:43=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> Benno Lossin <benno.lossin@proton.me> writes:
> > On 12/1/23 12:35, Alice Ryhl wrote:
> >> Benno Lossin <benno.lossin@proton.me> writes:
> >>>> +        // SAFETY: The `inner` pointer points at a valid and fully =
initialized task work that is
> >>>> +        // ready to be scheduled.
> >>>> +        unsafe { bindings::task_work_add(current, inner, TWA_RESUME=
) };
> >>>
> >>> I am a bit confused, when does `do_close_fd` actually run? Does
> >>> `TWA_RESUME` mean that `inner` is scheduled to run after the current
> >>> task has been completed?
> >>
> >> When the current syscall returns to userspace.
> >
> > What happens when I use `DeferredFdCloser` outside of a syscall? Will
> > it never run? Maybe add some documentation about that?
>
> Christian Brauner, I think I need your help here.
>
> I spent a bunch of time today trying to understand the correct way of
> closing an fd held with fdget, and I'm unsure what the best way is.
>
> So, first, `task_work_add` only really works when we're called from a
> syscall. For one, it's fallible, and for another, you shouldn't even
> attempt to use it from a kthread. (See e.g., the implementation of
> `fput` in `fs/file_table.c`.)
>
> To handle the above, we could fall back to the workqueue and schedule
> the `fput` there when we are on a kthread or `task_work_add` fails. And
> since I don't really care about the performance of this utility, let's
> say we just unconditionally use the workqueue to simplify the
> implementation.
>
> However, it's not clear to me that this is okay. Consider this
> execution: (please compare to `binder_deferred_fd_close`)
>
>     Thread A                Thread B (workqueue)
>     fdget()
>     close_fd_get_file()
>     get_file()
>     filp_close()
>     schedule_work(do_close_fd)
>     // we are preempted
>                             fput()
>     fdput()
>
> And now, since the workqueue can run before thread A returns to
> userspace, we are in trouble again, right? Unless I missed an upgrade
> to shared file descriptor somewhere that somehow makes this okay? I
> looked around the C code and couldn't find one and I guess such an
> upgrade has to happen before the call to `fdget` anyway?
>
> In Binder, the above is perfectly fine since it closes the fd from a
> context where `task_work_add` will always work, and a task work
> definitely runs after the `fdput`. But I added this as a utility in the
> shared kernel crate, and I want to avoid the situation where someone
> comes along later and uses it from a kthread, gets the fallback to
> workqueue, and then has an UAF due to the previously mentioned
> execution...
>
> What do you advise that I do?
>
> Maybe the answer is just that, if you're in a context where it makes
> sense to talk about an fd of the current task, then task_work_add will
> also definitely work? So if `task_work_add` won't work, then
> `close_fd_get_file` will return a null pointer and we never reach the
> `task_work_add`. This seems fragile though.
>
> Alice

Ah! I realized that there's another option: Report an error if we
can't schedule the task work.

I didn't suggest this originally because I didn't want to leak the
file in the error path, and I couldn't think of anything else sane to
do.

But! We can schedule the task work *first*, then attempt to close the
file. This way, the file doesn't get closed in the error path. And
there's no race condition since the task work is guaranteed to get
scheduled later on the same thread, so there's no way for it to get
executed in between us scheduling it and closing the file.

Thoughts?

Alice
