Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEAC7B7419
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 00:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjJCW34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 18:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjJCW3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 18:29:55 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7218DB0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 15:29:51 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b59e1ac70so21888777b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 15:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696372190; x=1696976990; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dAD+NyD8rwm68rv+KcO6kIHA2BI/1BAlT5OkmuE/mvM=;
        b=fZb6IBe5rRmR0jkZKZdQoc2lOLcUyNJeVJv6ov3fv8MSZ1hBDbV+eKcmXW/Re5aTOF
         BfpzDYe1DO1B63SKJJ6vKvCiRZjmM02KdQgYzQ7wgShFAGdnPXWmaj2kO/c9lH+Xl5dT
         EyLscf27lygnuqE7ugZ5NTXfRXti2O00V/MmFF0E09PveSgOhm9SrwjJCQx7LzZbaqwc
         mkQ+XY4TL3lkv07cFvl6EiWVi1JD5D6um28REq/WV78T5JYX6PvPrg6ESas0jzmCV7oL
         bgH8CteMSIXuvPeSIjpeTjkEGT1p8GTNZK3+mFPr0MAvtvXMkbG6L9s/Vztt6Om5xO14
         Z2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696372190; x=1696976990;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dAD+NyD8rwm68rv+KcO6kIHA2BI/1BAlT5OkmuE/mvM=;
        b=lat2ot4pxrXSzmOkrSeHCQbPuRB7imP66UnpnrUUZxGHsyPnSWx9Ji14grUhh9jl2z
         Ot4Wn9Q3wlzupnoD80JvRD0jkbCNsEoVFdo3A3B5hw8WDfBRsO5Iin8Fb+F6bcGlo4Ub
         wcFJtV+/ZbZqQLngCHpa79w8oQqsCNkh3PzV+9gBr/6MfLFgosB9gdqeEpY6vWRtzJon
         to9EQAWpzGn0++VQ5JmCy+9WrqpofLfiZlIlEBF7XNZ6BZxGNmU5s+zXRqJwty7qUACn
         xwAaUZCj4piR1JkCTmmPy1Vj70DkN6Iq6T9/LNk1X4pqauZPB+7IsAMdd8TUcOLgt+V7
         KgvQ==
X-Gm-Message-State: AOJu0YyhlgPXULHVQg9HokIkQkkg5gd2feZwtTjGt2vgk9I8A42R6Uea
        wfTk0o8r5hNC7Q4FX+Y/bIZ8QonedtjbxP8=
X-Google-Smtp-Source: AGHT+IEkB0IrCc6Hhu4Q5FKQXGRZYIEeC/u6PqBK0M9bMkwyR8qfAToV0+g3PXMwAURU6yARQ/hdo4TlOU5ndFY=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a25:248:0:b0:d8c:cc9b:81cc with SMTP id
 69-20020a250248000000b00d8ccc9b81ccmr8747ybc.3.1696372190665; Tue, 03 Oct
 2023 15:29:50 -0700 (PDT)
Date:   Tue,  3 Oct 2023 22:29:47 +0000
In-Reply-To: <CVZ2KU4KK5YH.2HVL1F6X93YLL@pogg>
Mime-Version: 1.0
References: <CVZ2KU4KK5YH.2HVL1F6X93YLL@pogg>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231003222947.374039-1-aliceryhl@google.com>
Subject: Re: [PATCH v4 7/7] rust: workqueue: add examples
From:   Alice Ryhl <aliceryhl@google.com>
To:     k.shelekhin@ftml.net
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, nmi@metaspace.dk, ojeda@kernel.org,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        tj@kernel.org, wedsonaf@gmail.com, yakoyoku@gmail.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 10:13PM Konstantin Shelekhin <k.shelekhin@ftml.net> wrote:
> +//! #[pin_data]
> +//! struct MyStruct {
> +//!     value: i32,
> +//!     #[pin]
> +//!     work: Work<MyStruct>,
> +//! }
> +//!
> +//! impl_has_work! {
> +//!     impl HasWork<Self> for MyStruct { self.work }
> +//! }
> +//!
> +//! impl MyStruct {
> +//!     fn new(value: i32) -> Result<Arc<Self>> {
> +//!         Arc::pin_init(pin_init!(MyStruct {
> +//!             value,
> +//!             work <- new_work!("MyStruct::work"),
> +//!         }))
> +//!     }
> +//! }
> +//!
> +//! impl WorkItem for MyStruct {
> +//!     type Pointer = Arc<MyStruct>;
> +//!
> +//!     fn run(this: Arc<MyStruct>) {
> +//!         pr_info!("The value is: {}", this.value);
> +//!     }
> +//! }
> +//!
> +//! /// This method will enqueue the struct for execution on the system workqueue, where its value
> +//! /// will be printed.
> +//! fn print_later(val: Arc<MyStruct>) {
> +//!     let _ = workqueue::system().enqueue(val);
> +//! }
>
> I understand that this is highly opionated, but is it possible to make
> the initialization less verbose?

The short answer is yes. There are safe alternatives that are much less
verbose. Unfortunately, those alternatives give up some of the features
that this design has. Specifically, they give up the feature that allows
you to embed the work_struct inside custom structs. I need to be able to
embed the work_struct inside of custom structs, so I did not go that
route.

There are also some parts of this (mainly `impl_has_work!`) that I am
unhappy with. I would be happy to see a solution that doesn't need it,
but I couldn't figure out how to avoid it.

> Because the C version looks much, much cleaner and easier to grasp:
>
>     struct my_struct {
>         i32 value;
>         struct work_struct work;
>     };
> 
>     void log_value(struct work_struct *work)
>     {
>         struct my_struct *s = container_of(work, struct my_struct, work);
>         pr_info("The value is: %d\n", s->value);
>     }
> 
>     void print_later(struct my_struct &s)
>     {
>         INIT_WORK(&s->work, log_value);
>         schedule_work(&s->work);
>     }

Although I think that a part of this is just whether you are familiar
with Rust syntax, there is definitely some truth to this. Your code is a
lot closer to the machine code of what actually happens here. Perhaps it
would be interesting to see what you get if you just unsafely do exactly
the same thing in Rust? It would look something like this:

    struct MyStruct {
        value: i32,
        work: bindings::work_struct,
    }

    unsafe fn log_value(work: *mut bindings::work_struct) {
        unsafe {
            let s = container_of!(work, MyStruct, work);
            pr_info!("The value is: {}", (*s).value);
        }
    }

    unsafe fn print_later(s: *mut bindings::work_struct) {
        unsafe {
            bindings::INIT_WORK(&mut (*s).work, log_value);
            bindings::schedule_work(&mut (*s).work);
        }
    }

(I didn't try to compile this.)

The problem with this approach is that it uses unsafe in driver code,
but the goal behind Rust abstractions is to isolate all of the related
unsafe code. The idea being that drivers using the workqueue do not need
any unsafe code to use it. This means that, assuming these workqueue
abstractions are correct, no driver can accidentally cause memory
unsafety by using the workqueue wrong.

The main difficult part of making this happen is the container_of
operation. We need to somehow verify *at compile time* that the
container_of in log_value really is given a pointer to the work field of
a MyStruct. Other than the things that are just how Rust looks, most of
the verbosity is necessary to make this compile-time check possible.

Another thing it does is handle proper transfer of ownership. In my
original example, MyStruct is reference counted (due to the use of Arc),
so the workqueue passes ownership of one refcount to the workqueue,
which eventually passes the refcount to run. When `this` goes out of
scope at the end of `run`, the refcount is decremented and the struct is
freed if the refcount dropped to zero.

If you wanted to just have exclusive ownership of my_struct, you could
do that by using Box instead of Arc. In either case, the ownership is
correctly passed to run, and you cannot accidentally forget to free it
at the end of log_value.

So, ultimately there's a tradeoff here. The code corresponds less
directly to what the machine code will be. On the other hand, it will be
*more* difficult to use incorrectly since incorrect uses will usually
result in compilation errors. The claim of Rust is that this tradeoff is
worth it.

Alice

