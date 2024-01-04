Return-Path: <linux-kernel+bounces-17280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 239C7824ACC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C441C20310
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853FC2D03B;
	Thu,  4 Jan 2024 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Li830Kao"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B1D2C85F;
	Thu,  4 Jan 2024 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42782601608so4527341cf.2;
        Thu, 04 Jan 2024 14:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704406792; x=1705011592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H30Ea/7n+Kca5VxufaG3WS56g0npATZySdngobj9tDE=;
        b=Li830KaoKGj49A8fY8ORhjh2iypmRgZ+2GXqLCaXbstveV+P1SwDaVK3Ga+2f4RrhQ
         +2AsB3tlw1v0IUQNLbQb+Hk4YOiCi5bHpRnqfNtyvAAvw0BN6muPD0GNr0E+lMhvvTiR
         d/YaGhJgC5CJfIv51G47kzIIvKzL08aDKeoQl7PR+olY3dt4QjxgFMAaMjEk3331ABF+
         BchT6td1sl7aTCOh+mQbkakJwmUjSyNqz13M+XSsxc7ebXsBxZCyhvhg2A4AYqKwtlHe
         AtH2ZwGlRxqxNDuVdoGf2dDiWH1Gj+pQOUsDa7SHAdcbK+xorbgYzULCdMPSGBZlpf6K
         PYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704406792; x=1705011592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H30Ea/7n+Kca5VxufaG3WS56g0npATZySdngobj9tDE=;
        b=oGE/G+LO2VG4d+2rpj+eTVZm1gLxh/UiaHHPgF3Pd84o7HLx5XMu8fNltwzbPqJye0
         v9jnRrdyXj6aK9EPfE6B4cre/Xdhw3l3Q6iqG+Nalk5G1t7QsU0VL903iuy5cA9wuMRh
         n8Z3J7ObOK+zvTHx3gV/GCYAJUt5aHYUfX9GhtuEcH3mApc4rqAEshEnNiplRVax88qI
         MbWXNtXMhEPa4oe4J8GSaU61Tt+HyzQrWAYZy3disU91b5jNiFW7RSqBqmBydzHCfZqg
         qzniyshPWohiCpo6KQLasSMOA3QaSeDjUlODSx1X3Cl/dL0xt76fPHwBYy16LIi1nPXo
         dNVw==
X-Gm-Message-State: AOJu0Ywv0jrEh7494ykjJnvBGhwKmlMCPS4e81hc/sLjm420BAVy1ElO
	lB9uVCp/+2veq0wQ05D/ljA=
X-Google-Smtp-Source: AGHT+IFZH+gjAasGQslVIi/QB9MHV41tLuwt2j2HwCzeOlQfV2ZmsVk97cJP6Ky2gReFWIWCg7Qwbg==
X-Received: by 2002:ac8:59d6:0:b0:425:4043:8d38 with SMTP id f22-20020ac859d6000000b0042540438d38mr1441031qtf.83.1704406791981;
        Thu, 04 Jan 2024 14:19:51 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id kr10-20020ac861ca000000b00428319369aasm177715qtb.12.2024.01.04.14.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 14:19:51 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id D14D227C0064;
	Thu,  4 Jan 2024 17:19:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 04 Jan 2024 17:19:50 -0500
X-ME-Sender: <xms:Bi-XZRvv4u1ncqSb2Xc8JRA_JQG1moiD8BH2_VUX_C42hKXKkJV5OQ>
    <xme:Bi-XZacsTEshqDlRGZwhiR85nHdOyPrR26XG_Ix2MvEI-U1Km3Lpedln48puhlYr2
    -oyKPBfNQfYC4T3lA>
X-ME-Received: <xmr:Bi-XZUxl4XI6WL6xF5oFkbqmO77AhtqrnqJEhyJ6MtD3LVhofOTHlFqJPu8TCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegjedgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepjeeihfdtuedvgedvtddufffggeefhefgtdeivdevveelvefhkeehffdt
    keeihedvnecuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhp
    rghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsg
    hoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Bi-XZYPV7fnI2hRpwPtW9iZ8w7vDmsZRVb0b1lHW-DHQD-YJX-0MmA>
    <xmx:Bi-XZR9fH8Pd_gfVmuzBC1WQS1UlrJyFmyMCjYcLn0pmeTYM-R8t3Q>
    <xmx:Bi-XZYX2S1exSRi5Xi9yHC2agGVvLFD-1N6i60dIt-zjzu5VVd0O2w>
    <xmx:Bi-XZZNpQdQhO8OclXc6Xz38fyrzToIHSPb7yqmyn_KBpJjf8UlYHA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jan 2024 17:19:50 -0500 (EST)
Date: Thu, 4 Jan 2024 14:18:42 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Tiago Lam <tiagolam@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] rust: sync: add `CondVar::wait_timeout`
Message-ID: <ZZcuwkBsvSs6bzXF@boqun-archlinux>
References: <20240104-rb-new-condvar-methods-v3-0-70b514fcbe52@google.com>
 <20240104-rb-new-condvar-methods-v3-3-70b514fcbe52@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104-rb-new-condvar-methods-v3-3-70b514fcbe52@google.com>

On Thu, Jan 04, 2024 at 02:02:43PM +0000, Alice Ryhl wrote:
> Sleep on a condition variable with a timeout.
> 
> This is used by Rust Binder for process freezing. There, we want to
> sleep until the freeze operation completes, but we want to be able to
> abort the process freezing if it doesn't complete within some timeout.
> 
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Tiago Lam <tiagolam@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

That said, I want to hear from Thomas on the usage of jiffies, see
below:

> ---
[...]
> -    fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guard: &mut Guard<'_, T, B>) {
> +    fn wait_internal<T: ?Sized, B: Backend>(
> +        &self,
> +        wait_state: u32,
> +        guard: &mut Guard<'_, T, B>,
> +        timeout_in_jiffies: c_long,

This is an internal function, and it makes sense we use the same type
for durations as the C function we rely on.

> +    ) -> c_long {
>          let wait = Opaque::<bindings::wait_queue_entry>::uninit();
>  
>          // SAFETY: `wait` points to valid memory.
> @@ -113,11 +122,13 @@ fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guard: &mut Guar
>              bindings::prepare_to_wait_exclusive(self.wait_list.get(), wait.get(), wait_state as _)
>          };
>  
> -        // SAFETY: No arguments, switches to another thread.
> -        guard.do_unlocked(|| unsafe { bindings::schedule() });
> +        // SAFETY: Switches to another thread. The timeout can be any number.
> +        let ret = guard.do_unlocked(|| unsafe { bindings::schedule_timeout(timeout_in_jiffies) });
>  
>          // SAFETY: Both `wait` and `wait_list` point to valid memory.
>          unsafe { bindings::finish_wait(self.wait_list.get(), wait.get()) };
> +
> +        ret
>      }
>  

[...]

> +    /// Releases the lock and waits for a notification in interruptible mode.
> +    ///
> +    /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
> +    /// thread to sleep. It wakes up when notified by [`CondVar::notify_one`] or
> +    /// [`CondVar::notify_all`], or when a timeout occurs, or when the thread receives a signal.
> +    #[must_use = "wait_interruptible_timeout returns if a signal is pending, so the caller must check the return value"]
> +    pub fn wait_interruptible_timeout<T: ?Sized, B: Backend>(
> +        &self,
> +        guard: &mut Guard<'_, T, B>,
> +        jiffies: Jiffies,

This is a public interface, so it may make sense use a HZ-independent
type for durations, e.g. core::time::Duration:

	https://doc.rust-lang.org/core/time/struct.Duration.html	

but we don't have enough users to see whether there would be a need for
HZ-dependent durations, so I think it's fine that we stick with a simple
solution in Alice's patchset to get the ball rolling, we can always
remove a public interface with HZ-dependent durations whenever we want.

Thoughts?

Regards,
Boqun

> +    ) -> CondVarTimeoutResult {
> +        let jiffies = jiffies.try_into().unwrap_or(MAX_SCHEDULE_TIMEOUT);
> +        let res = self.wait_internal(bindings::TASK_INTERRUPTIBLE, guard, jiffies);
> +
> +        match (res as Jiffies, crate::current!().signal_pending()) {
> +            (jiffies, true) => CondVarTimeoutResult::Signal { jiffies },
> +            (0, false) => CondVarTimeoutResult::Timeout,
> +            (jiffies, false) => CondVarTimeoutResult::Woken { jiffies },
> +        }
> +    }
> +
[...]
> +
> +/// The return type of `wait_timeout`.
> +pub enum CondVarTimeoutResult {
> +    /// The timeout was reached.
> +    Timeout,
> +    /// Somebody woke us up.
> +    Woken {
> +        /// Remaining sleep duration.
> +        jiffies: Jiffies,
> +    },
> +    /// A signal occurred.
> +    Signal {
> +        /// Remaining sleep duration.
> +        jiffies: Jiffies,
> +    },
> +}
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index f12a684bc957..149a5259d431 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -139,7 +139,7 @@ pub struct Guard<'a, T: ?Sized, B: Backend> {
>  unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
>  
>  impl<T: ?Sized, B: Backend> Guard<'_, T, B> {
> -    pub(crate) fn do_unlocked(&mut self, cb: impl FnOnce()) {
> +    pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
>          // SAFETY: The caller owns the lock, so it is safe to unlock it.
>          unsafe { B::unlock(self.lock.state.get(), &self.state) };
>  
> @@ -147,7 +147,7 @@ pub(crate) fn do_unlocked(&mut self, cb: impl FnOnce()) {
>          let _relock =
>              ScopeGuard::new(|| unsafe { B::relock(self.lock.state.get(), &mut self.state) });
>  
> -        cb();
> +        cb()
>      }
>  }
>  
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 9451932d5d86..ffb4a51eb898 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -7,6 +7,9 @@
>  use crate::{bindings, types::Opaque};
>  use core::{marker::PhantomData, ops::Deref, ptr};
>  
> +/// A sentinal value used for infinite timeouts.
> +pub const MAX_SCHEDULE_TIMEOUT: c_long = c_long::MAX;
> +
>  /// Returns the currently running task.
>  #[macro_export]
>  macro_rules! current {
> 
> -- 
> 2.43.0.472.g3155946c3a-goog
> 

