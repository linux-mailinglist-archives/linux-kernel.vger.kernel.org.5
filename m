Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A397FEEAB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345360AbjK3MKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345361AbjK3MKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:10:12 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3093C10F2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 04:10:16 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d064f9e2a1so13149857b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 04:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701346215; x=1701951015; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MpC0qbPCJ3yCkzqZmHvjb+j6E99/8etcnMaQGxE98xo=;
        b=DauTORjdSDyxQtj+qiiDb77b8RnHJnJIteI5c5uNh0A2d2yX3qioZQcqPjT/A9Slyg
         xItc14+OiF8pZIHGxa9AJyxGnFBF1CJhFt5EIYucVBMfd9f/ybSoYSuRe4qtpxBXTB8n
         YDg3HfBncegdPfJQcDvGdNTKT7avSitiK8qOjYtRtWDJrWsAW2JH7ZipVY4Mb7MfOdVr
         kZO4M+bzTCaHQkqSkkmbM7fViY9g8ifo7fIEEaDCr73dfNqmiyZvfpStYumXinSeYRO6
         dJ039K/GVq/whYpEtsc2ps81RMg10mSrWIIHNyCMTTTFFvPdOaQP/eIxy5B+RIZE/3RX
         pb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701346215; x=1701951015;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpC0qbPCJ3yCkzqZmHvjb+j6E99/8etcnMaQGxE98xo=;
        b=XbeqWjOiKWLXMAnOsJAk+mN29wjfrLxvBL/JFLTZVWmKR9tmlJWuhLU4Iq9FwGi1Ut
         /HxMrKuOH4TWBM6JDeWIWqpzTdXPEIvnuX04fAi56u0Ss7XOi6zz8q60QPDSPFRkexZk
         PP8aWNtJ/J9+jULJPTVUEEjNxJNwFIr3UIGWf3kXvylk16jS/musCMWGEF7ONT0i9OTe
         fImjoHPRV728AkS7+ewAjBNhG/MO+6mShX0IQCLgkBT229YGEID1OfaK2HB2YOJExK74
         sS41l7e/2azpzB7V8uaynegOOimIQhEmTpJc8uBM98HYfHzBLNNrL6X0ImEiAKtkG9vI
         FM7Q==
X-Gm-Message-State: AOJu0YzoGcK6CovaWKRRngeumkuYEXYjd1xN2k47BGsd69ENNUiASgry
        8/EYvG4Mf81fp9oEStyN5WFAOBYrHbZFWbo=
X-Google-Smtp-Source: AGHT+IHkruZpynxgNrnzwalbW6zRZDy4mTm8VClbDHLx2F8vWgb3ZReA4zvBoILLpWV35FvGD9AUBn92jc8MH9g=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:844:b0:5ca:8462:670f with SMTP
 id bz4-20020a05690c084400b005ca8462670fmr667597ywb.0.1701346215441; Thu, 30
 Nov 2023 04:10:15 -0800 (PST)
Date:   Thu, 30 Nov 2023 12:10:12 +0000
In-Reply-To: <20231130-sackgasse-abdichtung-62c23edd9a9f@brauner>
Mime-Version: 1.0
References: <20231130-sackgasse-abdichtung-62c23edd9a9f@brauner>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231130121013.140671-1-aliceryhl@google.com>
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
From:   Alice Ryhl <aliceryhl@google.com>
To:     brauner@kernel.org
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        aliceryhl@google.com, arve@android.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
        cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz,
        gary@garyguo.net, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@android.com, ojeda@kernel.org, peterz@infradead.org,
        rust-for-linux@vger.kernel.org, surenb@google.com,
        tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk,
        wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <brauner@kernel.org> writes:
>> This is the backdoor. You use it when *you* know that the file is okay
> 
> And a huge one.
> 
>> to access, but Rust doesn't. It's unsafe because it's not checked by
>> Rust.
>> 
>> For example you could do this:
>> 
>> 	let ptr = unsafe { bindings::fdget(fd) };
>> 
>> 	// SAFETY: We just called `fdget`.
>> 	let file = unsafe { File::from_ptr(ptr) };
>> 	use_file(file);
>> 
>> 	// SAFETY: We're not using `file` after this call.
>> 	unsafe { bindings::fdput(ptr) };
>> 
>> It's used in Binder here:
>> https://github.com/Darksonn/linux/blob/dca45e6c7848e024709b165a306cdbe88e5b086a/drivers/android/rust_binder.rs#L331-L332
>> 
>> Basically, I use it to say "C code has called fdget for us so it's okay
>> to access the file", whenever userspace uses a syscall to call into the
>> driver.
> 
> Yeah, ok, because the fd you're operating on may be coming from fdget(). Iirc,
> binder is almost by default used multi-threaded with a shared file descriptor
> table? But while that means fdget() will usually bump the reference count you
> can't be sure. Hmkay.

Even if the syscall used `fget` instead of `fdget`, I would still be
using `from_ptr` here. The `ARef` type only really makes sense when *we*
have ownership of the ref-count, but in this case we don't own it. We're
just given a promise that the caller is keeping it alive for us using
some mechanism or another.

>>>> +// SAFETY: It's OK to access `File` through shared references from other threads because we're
>>>> +// either accessing properties that don't change or that are properly synchronised by C code.
>>> 
>>> Uhm, what guarantees are you talking about specifically, please?
>>> Examples would help.
>>> 
>>>> +unsafe impl Sync for File {}
>> 
>> The Sync trait defines whether a value may be accessed from several
>> threads in parallel (using shared/immutable references). In our case,
> 
> So let me put this into my own words and you correct me, please:
> 
> So, this really just means that if I have two processes both with their own
> fdtable and they happen to hold fds that refer to the same @file:
> 
> P1				P2
> struct fd fd1 = fdget(1234);
>                                  struct fd fd2 = fdget(5678);
> if (!fd1.file)                   if (!fd2.file)
> 	return -EBADF;                 return -EBADF;
> 
> // fd1.file == fd2.file
> 
> the only if the Sync trait is implemented both P1 and P2 can in parallel call
> file->f_op->poll(@file)?
> 
> So if the Sync trait isn't implemented then the compiler will prohibit that P1
> and P2 at the same time call file->f_op->poll(@file)? And that's all that's
> meant by a shared reference? It's really about sharing the pointer.

Yeah, what you're saying sounds correct. For a type that is not Sync,
you would need a lock around the call to `poll` before the compiler
would accept the call.

(Or some other mechanism to convince the compiler that no other thread
is looking at the file at the same time. Of course, a lock is just one
way to do that.)

> The thing is that "shared reference" gets a bit in our way here:
> 
> (1) If you have SCM_RIGHTs in the mix then P1 can open fd1 to @file and then
>     send that @file to P2 which now has fd2 refering to @file as well. The
>     @file->f_count is bumped in that process. So @file->f_count is now 2.
> 
>     Now both P1 and P2 call fdget(). Since they don't have a shared fdtable
>     none of them take an additional reference to @file. IOW, @file->f_count
>     may remain 2 all throughout the @file->f_op->*() operation.
> 
>     So they share a reference to that file and elide both the
>     atomic_inc_not_zero() and the atomic_dec_not_zero().
> 
> (2) io_uring has fixed files whose reference count always stays at 1.
>     So all io_uring operations on such fixed files share a single reference.
> 
> So that's why this is a bit confusing at first to read "shared reference".
> 
> Please add a comment on top of unsafe impl Sync for File {}
> explaining/clarifying this a little that it's about calling methods on the same
> file.

Yeah, I agree, the terminology gets a bit mixed up here because we both
use the word "reference" for different things.

How about this comment?

/// All methods defined on `File` that take `&self` are safe to call even if
/// other threads are concurrently accessing the same `struct file`, because
/// those methods either access immutable properties or have proper
/// synchronization to ensure that such accesses are safe.

Note: Here, I say "take &self" to refer to methods with &self in the
signature. This signature means that you pass a &File to the method when
you call it.

Alice

