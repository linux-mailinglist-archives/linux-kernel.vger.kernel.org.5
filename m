Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E090807609
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442683AbjLFRFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379722AbjLFRFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:05:21 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00361C9;
        Wed,  6 Dec 2023 09:05:26 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40bd5eaa66cso65204405e9.2;
        Wed, 06 Dec 2023 09:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701882325; x=1702487125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aon+6SW66H5qGZ8mIlaW3RBTmDxAICJs/LJzma2pM+k=;
        b=YNvk4UG/TAxQOxVVyjGZE+/eiqjFkWh6gwpzxCL0caANPm88kFqEoCwAJiwlajGdCQ
         tWvc0WXKdZtPIsVJ/BakBWXwnJjk3igwDWZrcjpSBmbnomMG7eDx8ur3Weiy3DBCnrPi
         Oq699L9Rtof+udCcIwUmdMxWbdJvchwFtRGb6DlcNCZe4Jhwa0EEa0mIw4w23NioTM7m
         xMIZV/4jZZn8Klq2paj+hY+tG7+/hV0wWYlwR5kW+Dfq8kAXNwNpGDVfJ9o4EwttSbdf
         ZgzcNNF5bUyNXRZON/djhndo/9XifbGN4/c5Js4KnORsbpg+Sc6aE4/qfkD6ohs2EizQ
         rpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701882325; x=1702487125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aon+6SW66H5qGZ8mIlaW3RBTmDxAICJs/LJzma2pM+k=;
        b=IvlbkWHThWDCv16nwsvTs0kO6netK9RYicsh6EhEcoZtV4LBLwn0De4ca+7JrThH23
         E1qotahGXFmYBE0y+tpgCaFf8ySNJsZCvzpgW/X/4mBwsVzBuV+q6cybhMZCMCvl5Uup
         VSLUuvZShKSjXXFhhzg7Au/6li0anGZKHy6pn8th1/MHZVluQNfD/WOWkV6RLGIQ2S8L
         CN9w80b2v1jbz16eiJzOFqGXgwirLHnx8zq/kFf0Qx0au6oZB413aoBaiQJRXAdaz+MP
         jvG4hnS2oFeRlul6CiPNp0A0z5An9ufMnrR0t3l6aM17/0SI9/Zft79X5amAPREx7DI/
         1mhQ==
X-Gm-Message-State: AOJu0Yxd3J/EtDkmH4Le3GCycY8bcisHrzIYW3bWs8RVKHzwvV+RX4ud
        q33c6+S/7u631boDPExkiA==
X-Google-Smtp-Source: AGHT+IF8nfluIdoHOUHC5Q4HldcNCvJolp8T2hVisdNH1rvL+quoedypu4kSo6tcHw28QVAub1EH4Q==
X-Received: by 2002:a05:600c:29a:b0:40c:237a:2446 with SMTP id 26-20020a05600c029a00b0040c237a2446mr583915wmk.143.1701882325114;
        Wed, 06 Dec 2023 09:05:25 -0800 (PST)
Received: from [192.168.1.148] (15.69.114.89.rev.vodafone.pt. [89.114.69.15])
        by smtp.googlemail.com with ESMTPSA id g14-20020a05600c4ece00b004090798d29csm201326wmq.15.2023.12.06.09.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 09:05:24 -0800 (PST)
Message-ID: <1dd1a3e8-ef9a-4e89-891f-b49d82acc5f8@gmail.com>
Date:   Wed, 6 Dec 2023 17:05:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rust: sync: add `CondVar::wait_timeout`
To:     Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231206-rb-new-condvar-methods-v1-0-33a4cab7fdaa@google.com>
 <20231206-rb-new-condvar-methods-v1-2-33a4cab7fdaa@google.com>
Content-Language: en-GB
From:   Tiago Lam <tiagolam@gmail.com>
In-Reply-To: <20231206-rb-new-condvar-methods-v1-2-33a4cab7fdaa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/12/2023 10:09, Alice Ryhl wrote:
[...]
> diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
> index 9861c6749ad0..a6a6b6ab0c39 100644
> --- a/rust/kernel/sync/condvar.rs
> +++ b/rust/kernel/sync/condvar.rs
> @@ -120,6 +120,63 @@ fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guard: &mut Guar
>           unsafe { bindings::finish_wait(self.wait_list.get(), wait.get()) };
>       }
>   
> +    /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
> +    /// thread to sleep. It wakes up when notified by [`CondVar::notify_one`] or
> +    /// [`CondVar::notify_all`], or when the thread receives a signal.
> +    ///
> +    /// Returns whether there is a signal pending.
> +    fn wait_internal_timeout<T, B>(
> +        &self,
> +        wait_state: u32,
> +        guard: &mut Guard<'_, T, B>,
> +        timeout: u64,
> +    ) -> u64
> +    where
> +        T: ?Sized,
> +        B: Backend,
> +    {
> +        let wait = Opaque::<bindings::wait_queue_entry>::uninit();
> +
> +        // SAFETY: `wait` points to valid memory.
> +        unsafe { bindings::init_wait(wait.get()) };
> +
> +        // SAFETY: Both `wait` and `wait_list` point to valid memory.
> +        unsafe {
> +            bindings::prepare_to_wait_exclusive(self.wait_list.get(), wait.get(), wait_state as _)
> +        };
> +
> +        // SAFETY: Switches to another thread.
> +        let timeout =
> +            guard.do_unlocked(|| unsafe { bindings::schedule_timeout(timeout as _) as _ });

It looks like `schedule_timeout()` simply calls `schedule()` when the 
timeout passed is `MAX_SCHEDULE_TIMEOUT`, so `wait_internal_timeout()` 
could be merged together with the already existing `wait_internal()`, 
where `wait_internal()` would always call `schedule_timeout()`? I may be 
missing something, so just wondering why you decided to introduce 
another method.

> +
> +        // SAFETY: Both `wait` and `wait_list` point to valid memory.
> +        unsafe { bindings::finish_wait(self.wait_list.get(), wait.get()) };
> +
> +        timeout
> +    }
> +
> +    /// Releases the lock and waits for a notification in interruptible mode.
> +    ///
> +    /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
> +    /// thread to sleep. It wakes up when notified by [`CondVar::notify_one`] or
> +    /// [`CondVar::notify_all`], or when a timeout occurs, or when the thread receives a signal.
> +    ///
> +    /// Returns whether there is a signal pending.
> +    #[must_use = "wait_timeout returns if a signal is pending, so the caller must check the return value"]
> +    pub fn wait_timeout<T: ?Sized, B: Backend>(
> +        &self,
> +        guard: &mut Guard<'_, T, B>,
> +        jiffies: u64,
> +    ) -> CondVarTimeoutResult {

Should this be called `wait_timeout_interruptable` instead, so that if 
we need to add one using the `TASK_INTERRUPTIBLE` state later we don't 
need to modfy it again? It also matches the 
`schedule_timeout_interruptible` one in the kernel (although that's not 
a reason to change it just in itself).

> +        let res = self.wait_internal_timeout(bindings::TASK_INTERRUPTIBLE, guard, jiffies);
> +
> +        match (res as _, crate::current!().signal_pending()) {
> +            (jiffies, true) => CondVarTimeoutResult::Signal { jiffies },
> +            (0, false) => CondVarTimeoutResult::Timeout,
> +            (jiffies, false) => CondVarTimeoutResult::Woken { jiffies },
> +        }
> +    }
> +
>       /// Releases the lock and waits for a notification in interruptible mode.
>       ///
>       /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
> @@ -177,3 +234,19 @@ pub fn notify_all(&self) {
>           self.notify(0, 0);
>       }
>   }
> +
> +/// The return type of `wait_timeout`.
> +pub enum CondVarTimeoutResult {
> +    /// The timeout was reached.
> +    Timeout,
> +    /// Somebody woke us up.
> +    Woken {
> +        /// Remaining sleep duration.
> +        jiffies: u64,
> +    },
> +    /// A signal occurred.
> +    Signal {
> +        /// Remaining sleep duration.
> +        jiffies: u64,
> +    },
> +}


Is `Signal` and `Woken` only going to hold a single value? Would it be 
best represented as a tuple struct instead, like so?

     pub enum CondVarTimeoutResult {
         /// The timeout was reached.
         Timeout,
         /// Somebody woke us up.
         Woken (u64),
         /// A signal occurred.
         Signal (u64),
     }

Regard,
Tiago.
