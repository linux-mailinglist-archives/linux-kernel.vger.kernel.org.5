Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0C98009FB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378574AbjLALfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378541AbjLALfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:35:36 -0500
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CE0FF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 03:35:42 -0800 (PST)
Received: by mail-lj1-x249.google.com with SMTP id 38308e7fff4ca-2c9c05fe6c0so14421021fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 03:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701430541; x=1702035341; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qEkAP1I3qkXnBXX51BCMUCkxCSmzCgvaSA2DFugwU0k=;
        b=RSyiSAttj6AD0qcDKZRtFj4CyqlYT8YxZ7cw64/dQXoKu9MmAKHyBRsLnrcKqd6g3j
         Vx1XIZdXNzihq2Y6fQmgNey96WlGv9CO0vqY2U1c2e+lyledj1LNHnUPIEXIzyzMhPW0
         tx/MLqRbsI0Vlwdcqz/One6ot1LRfUG6ymJtm7WkFHgqi5aJCZjF3MGA4iuwWyizXgO4
         w7l9FULQE6l0e7DCJLFNzp0k6gGATb8jUuZ9wJEsujmiHbE1XfVbrazkrAwwu0X/eaHj
         b1gg4/OucszMKoRTHKxFdHV3VU9MZpoPq3mBSXx+L5eHO42cNlr+8kc5L5oYfKVE/mML
         C6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701430541; x=1702035341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qEkAP1I3qkXnBXX51BCMUCkxCSmzCgvaSA2DFugwU0k=;
        b=PJoDO01pj6VrYnaH8CdYVzPVSRJr8ST4Gdz9oa9rVpOGZaFunvYoU8igmn9GV8TGIy
         E0C7hBk5VtB+K5IeZ110TVCbh0y5/uJVYh8dvmgql+JUie31kakc5CKjTfMm+Yjj3m5P
         9vevXNJOAF5SBG5d4NvDfa2Gaj9P7JNtI196DJWdItT8BzkJULr2A03scZYBVZQgSF/a
         Pwux+qeSFMs0UOTZ0+aTs+P6hHU9L7lt0QeAB48kY6MYFKCftMWKIlFcWpojPzsUbQIc
         G476FrqWJUm2N7COkWZsbNQjR2zPsmcrPuGn9t1BxX7WiaAdcdCmxOUxbslHM+M/bbom
         PZvw==
X-Gm-Message-State: AOJu0Yy1Kvn1V2Zq7uUg8MDa3kFkCt+f1T6VgncHKwFWkaq6lV0PvTXZ
        IzDqcebOrszuxFWRLoa+mlnM8w/mQl7pZCY=
X-Google-Smtp-Source: AGHT+IFeTcBN1rZeBuZXq6yiD1BS3gZazpYc5NDt39EiWjUlJlgLZM3L2VCrcBV0qyu1cAqEZnjYwmFr2+yoba0=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:86cd:0:b0:2c9:aecd:306 with SMTP id
 n13-20020a2e86cd000000b002c9aecd0306mr53095ljj.0.1701430541098; Fri, 01 Dec
 2023 03:35:41 -0800 (PST)
Date:   Fri,  1 Dec 2023 11:35:38 +0000
In-Reply-To: <LNSA8EeuwLGDBzY1W8GaP1L6gucAPE_34myHWuyg3ziYuheiFLk3WfVBPppzwDZwoGVTCqL8EBjAaxsNshTY6AQq_sNtK9hmea7FeaNJuCo=@proton.me>
Mime-Version: 1.0
References: <LNSA8EeuwLGDBzY1W8GaP1L6gucAPE_34myHWuyg3ziYuheiFLk3WfVBPppzwDZwoGVTCqL8EBjAaxsNshTY6AQq_sNtK9hmea7FeaNJuCo=@proton.me>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201113538.2202170-1-aliceryhl@google.com>
Subject: Re: [PATCH 6/7] rust: file: add `DeferredFdCloser`
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benno Lossin <benno.lossin@proton.me> writes:
>> +        // SAFETY: The `inner` pointer points at a valid and fully initialized task work that is
>> +        // ready to be scheduled.
>> +        unsafe { bindings::task_work_add(current, inner, TWA_RESUME) };
> 
> I am a bit confused, when does `do_close_fd` actually run? Does
> `TWA_RESUME` mean that `inner` is scheduled to run after the current
> task has been completed?

When the current syscall returns to userspace.

>> +    // SAFETY: This function is an implementation detail of `close_fd`, so its safety comments
>> +    // should be read in extension of that method.
>> +    unsafe extern "C" fn do_close_fd(inner: *mut bindings::callback_head) {
>> +        // SAFETY: In `close_fd` we use this method together with a pointer that originates from a
>> +        // `Box<DeferredFdCloserInner>`, and we have just been given ownership of that allocation.
>> +        let inner = unsafe { Box::from_raw(inner as *mut DeferredFdCloserInner) };
> 
> In order for this call to be sound, `inner` must be an exclusive
> pointer (including any possible references into the `callback_head`).
> Is this the case?

Yes, when this is called, it's been removed from the linked list of task
work. That's why we can kfree it.

>> +        // SAFETY: Since `DeferredFdCloserInner` is `#[repr(C)]`, casting the pointers gives a
>> +        // pointer to the `twork` field.
>> +        let inner = Box::into_raw(self.inner) as *mut bindings::callback_head;
> 
> Here you can just use `.cast::<...>()`.

Will do.

Alice
