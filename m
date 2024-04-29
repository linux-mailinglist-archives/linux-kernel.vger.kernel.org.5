Return-Path: <linux-kernel+bounces-162758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC028B602C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD811F22D09
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1A6126F2F;
	Mon, 29 Apr 2024 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUodrGqC"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1C885C62;
	Mon, 29 Apr 2024 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411914; cv=none; b=IKIN4hg3CNMW0dO+8M/N3ME47WiV6Pmk9N5n4Sr5Q+mS+kMk4QnDNgIXplglJL4nkCRlgRz5oUGQM+smthaVQApMxT8ycI4FthPtudC5IBb8EcrsKbxNUY4RwRzGvJl4rozRq5NkxtH20V8gIWPKn8WSD11wEHu0/ik0K3ILwmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411914; c=relaxed/simple;
	bh=K3ATwvq5HFcUUsm/gl2ao6EjE1FHwuTdDYMqye/sYeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpDw8ZPRyC3uCJJgYq+V3r2pRDHqgAsAY8sd20F1Gye+iBiUB04Ia1jNP5RG9gYeRt+1fWaO27iORzNcAvvPk+SmNnAUpFTOLKMxyXRbYq+kueV8pGoloKB1IqY+zEugOwlFqLYcb+Ct9pEi1rXYHQgP/Bo83RPtcVfLCPUQbAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUodrGqC; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78f056f928eso374224985a.0;
        Mon, 29 Apr 2024 10:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714411912; x=1715016712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVh4RSvptlAvqshUUQeoOTRuVSSPh7POUa2NrURx6xA=;
        b=PUodrGqCvIO2AhI3yHX2+IUL7MeATTazd6aSVRVUhgPl920Y1nHBJ1m/Ft5ijyGdAl
         BKjii1KKSLUnabKqbRKrYoRxYAKU6LlktUj9MDWmOQvcl8GNPAq382Gy+ijE99IRTpph
         Wv45FnCMDiAhE/v7r7KBr6WKFwcEiDwZuA1kBt57APPBVUjmiSdhrgwUdk+bM9lhIvud
         IqgOLrNl9YVQKyI0OXlhs7sebRndP1gg8JU76KaIAfHIaC7Ybw2QYK+qUERQaIoRYm4W
         ZzR1IEuDUCxewjdIOvVoFNt3xIL9TGCkHxo4CAN9IhUBy9aFTUgQnsRAFM3MexrddymU
         K8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714411912; x=1715016712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVh4RSvptlAvqshUUQeoOTRuVSSPh7POUa2NrURx6xA=;
        b=PxV/ozGmqTjXsVcoLgWxIW/9IM1EtlQpyFZVtb3KrtYXvU8pMp3tX1j8f7Os9Dn/z0
         Je0jFxSPwI11gflzzn7NCcOMAUI1OGTx1BtgpwJ3Ig20i/6/O5Y5XdpeS7FlOqmu1ZQP
         YRTMeSuYrsv6/dlhtIrbtG8yfqDjqAFZMJjFHR3M4KSR2/hX3gL5o3w3AjNbHK+ot19z
         9hEe23+m1EH1BEW60Q/JGp+gtvpBmUms5tsVs5//6Wvl0+AAW+gSQ2rW9mosgy73nPNa
         0BYRiZppPgc2ypS9Hidl+BVVvWvjUlfwHhefOx6APqgk9sO3pBr8wWB2c1H4Lmysd1Ae
         UDfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVliV+UgkK8HPN/1mNdD8bl5uvgmXnWhUjw3kCo4722NyQ/TZBHPlb/xxWzgSNVZ+LIb2I3VC57UQpRerpATiBLkWNKVGYqRt2smWdhjDtF8+ytvhxuo3M6LLuprXaU/ZXyHztf6vw6EQogoXc=
X-Gm-Message-State: AOJu0Yzoc/NxtR89w6GZCBxPfTVyd/SdLtSFrEaKFF1lFjTk4Q94DM2a
	O9wsVKsZX7guDA3KSAiMzHxBhzYh1xyASU8GRgrT7ndZ4woPwSiY
X-Google-Smtp-Source: AGHT+IE1XF92jrxPh0NTs0Ksj0r9ZKGJOZT4w8nqpREDra/9iVyqq35+KaHA/3aNkEv9epvRxrHhgg==
X-Received: by 2002:a05:620a:4305:b0:790:98cc:b4d0 with SMTP id u5-20020a05620a430500b0079098ccb4d0mr12828708qko.7.1714411911850;
        Mon, 29 Apr 2024 10:31:51 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id os24-20020a05620a811800b0078ec439a9a7sm10674203qkn.62.2024.04.29.10.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 10:31:51 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 37EAB120006C;
	Mon, 29 Apr 2024 13:31:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 29 Apr 2024 13:31:50 -0400
X-ME-Sender: <xms:hdkvZsqB5gpn8PEY9zY7WngVdZ3ZZ9XbtCGmdLkK2WI0vZBlAZVZVA>
    <xme:hdkvZirb7tbdZcHpRXU-6vgvy-zFpTf48qzKQHRQAXy6sOoyAGPeqCV3CLtMy1Yjd
    6ozdiQMTOV9FMKVVw>
X-ME-Received: <xmr:hdkvZhNls4rokv6yULuSUR-bn0rDBNXe8cM1XeK9PwqQDFkZpXeycII11w6OyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduuddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepleetvdfhffdtgfefgefggfekieeuteekgeelvdeukeegleefveeivdef
    leevkedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpfhhlrghgrdhsthhorhgvpd
    hgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:hdkvZj6HmCcGDg70ziikuxB6yLxKwj6k_lTZxlUBHUlV8Yh0Uhs_qA>
    <xmx:hdkvZr4N35L_YUnm_Im6jEcNZB9Zu6lvJ2Ii0OT737dOz_psVXNusA>
    <xmx:hdkvZjgqYN9s_WWNKRhXh-WxGrvJqSgE0P3RKoiFr94jAJpDYGYfpw>
    <xmx:hdkvZl7bHXBFS7bMGTLfOyxDxHwptubv0sj12WnR2xYbm5BGeYBGxw>
    <xmx:hdkvZuKnJVcuGVw34RGTBzG72CuOBd_hsomksZ0pv6DCOaCQM4V9EeJE>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 13:31:48 -0400 (EDT)
Date: Mon, 29 Apr 2024 10:31:27 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: hrtimer: introduce hrtimer support
Message-ID: <Zi_Zb1lBOBBUFJFV@boqun-archlinux>
References: <20240425094634.262674-1-nmi@metaspace.dk>
 <a7a560c7-fb8c-4adf-9f46-2e272f24b335@proton.me>
 <87v844lbhm.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v844lbhm.fsf@metaspace.dk>

On Fri, Apr 26, 2024 at 11:27:49AM +0200, Andreas Hindborg wrote:
> Benno Lossin <benno.lossin@proton.me> writes:
> 
> > On 25.04.24 11:46, Andreas Hindborg wrote:
> >> From: Andreas Hindborg <a.hindborg@samsung.com>
> >> 
> >> This patch adds support for intrusive use of the hrtimer system. For now, only
> >> one timer can be embedded in a Rust struct.
> >> 
> >> The hrtimer Rust API is based on the intrusive style pattern introduced by the
> >> Rust workqueue API.
> >> 
> >> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> >> 
> >> ---
> >> 
> >> This patch is a dependency for the Rust null block driver [1].
> >> 
> >> Link: https://lore.kernel.org/rust-for-linux/20240313110515.70088-1-nmi@metaspace.dk/T/#me0990150b9ba9f5b3d00293ec9a473c7bc3cc506 [1]
> >> 
> >>  rust/kernel/hrtimer.rs | 283 +++++++++++++++++++++++++++++++++++++++++
> >>  rust/kernel/lib.rs     |   1 +
> >>  2 files changed, 284 insertions(+)
> >>  create mode 100644 rust/kernel/hrtimer.rs
> >> 
> >> diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
> >
> > Hmm is this the right place? I imagine there are other timers, does this
> > fit better into the `time` module (ie make `hrtimer` a submodule of
> > `time`) or should we later introduce a `timer` parent module?
> 
> We can always move it. We will move stuff anyway when the kernel crate
> is split.
> 
> We can also take it to `kernel::time::hrtimer` now, either way is fine.
> 

I think `kernel::time::hrtimer` makes more sense, since ideally
schedule() function should take a time delta type as the input instead
of `u64`. So hrtimer has some logical connection to timekeeping module.

> >
> >> new file mode 100644
> >> index 000000000000..1e282608e70c
> >> --- /dev/null
> >> +++ b/rust/kernel/hrtimer.rs
> >> @@ -0,0 +1,283 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +
> >> +//! Intrusive high resolution timers.
> >> +//!
> >> +//! Allows scheduling timer callbacks without doing allocations at the time of
> >> +//! scheduling. For now, only one timer per type is allowed.
> >> +//!
> >> +//! # Example
> >> +//!
> >> +//! ```rust
> >> +//! use kernel::{
> >> +//!     sync::Arc, hrtimer::{RawTimer, Timer, TimerCallback},
> >> +//!     impl_has_timer, prelude::*, stack_pin_init
> >> +//! };
> >> +//! use core::sync::atomic::AtomicBool;
> >> +//! use core::sync::atomic::Ordering;
> >> +//!
> >> +//! #[pin_data]
> >> +//! struct IntrusiveTimer {
> >> +//!     #[pin]
> >> +//!     timer: Timer<Self>,
> >> +//!     flag: AtomicBool,

Could you see if you can replace this with a `SpinLock<bool>` +
`CondVar`? We shouldn't use Rust atomic in kernel now. I know it's
unfortunate that LKMM atomics are still work in process, but in real
world, you won't do busy waiting for a timer to fire, so a
`CondVar::wait` is better for example purpose.

> >> +//! }
> >> +//!
> >> +//! impl IntrusiveTimer {
> >> +//!     fn new() -> impl PinInit<Self> {
> >> +//!         pin_init!(Self {
> >> +//!             timer <- Timer::new(),
> >> +//!             flag: AtomicBool::new(false),
> >> +//!         })
> >> +//!     }
> >> +//! }
> >> +//!
> >> +//! impl TimerCallback for IntrusiveTimer {
> >> +//!     type Receiver = Arc<IntrusiveTimer>;
> >> +//!
> >> +//!     fn run(this: Self::Receiver) {
> >> +//!         pr_info!("Timer called\n");
> >> +//!         this.flag.store(true, Ordering::Relaxed);
> >> +//!     }
> >> +//! }
> >> +//!
> >> +//! impl_has_timer! {
> >> +//!     impl HasTimer<Self> for IntrusiveTimer { self.timer }
> >> +//! }
> >> +//!
> >> +//! let has_timer = Arc::pin_init(IntrusiveTimer::new())?;
> >
> > I would not name this variable `has_timer`. Maybe `my_timer` is better?
> 
> Right, thanks.
> 
> >
> >> +//! has_timer.clone().schedule(200_000_000);
> >> +//! while !has_timer.flag.load(Ordering::Relaxed) { core::hint::spin_loop() }
> >
> > Weird formatting, we should also use `rustfmt` in examples.
> 
> `format_code_in_doc_comments` is a nightly `rustfmt` feature. I tried
> enabling it in `.rustfmt.toml` and running `rustfmt +nightly
> hrtimer.rs`. It did not have any effect. There is some discussion here:
> https://github.com/rust-lang/rustfmt/issues/3348
> 
> >
[...]
> >> +#[pinned_drop]
> >> +impl<T> PinnedDrop for Timer<T> {
> >> +    fn drop(self: Pin<&mut Self>) {
> >> +        // SAFETY: By struct invariant `self.timer` was initialized by
> >> +        // `hrtimer_init` so by C API contract it is safe to call
> >> +        // `hrtimer_cancel`.
> >> +        unsafe {
> >> +            bindings::hrtimer_cancel(self.timer.get());
> >> +        }
> >> +    }
> >> +}
> >
> > Why is this needed? The only way to schedule a timer using this API is
> > by having an `Arc` with a timer-containing struct inside. But to
> > schedule the `Arc`, you consume one refcount which is then sent to the
> > timer subsystem. So it is impossible for the refcount to drop below zero
> > while the timer is scheduled, but not yet running.
> > Do you need to call `hrtimer_cancel` after/while a timer is running?
> 
> This is not required any longer. It is a leftover from an earlier
> revision where timers could be stack allocated. I will remove it.
> 

So the plan is to add Arc<HasTimer> support first and stack allocated
timer later? If so, please do add a paragraph in the module level doc
describing the limition (e.g. stack allocated timers are not supported).

> > Also is it ok to call `hrtimer_cancel` inside the timer callback? Since
> > that can happen when the timer callback owns the last refcount.
> 
> That should be fine, `self` is still valid when the drop method is run?
> 
> >
> >> +
> >> +/// Implemented by pointer types to structs that embed a [`Timer`]. This trait
> >> +/// facilitates queueing the timer through the pointer that implements the
> >> +/// trait.
> >> +///
> >> +/// Typical implementers would be [`Box<T>`], [`Arc<T>`], [`ARef<T>`] where `T`
> >> +/// has a field of type `Timer`.
> >> +///
> >> +/// Target must be [`Sync`] because timer callbacks happen in another thread of
> >> +/// execution.
> >> +///
> >> +/// [`Box<T>`]: Box
> >> +/// [`Arc<T>`]: Arc
> >> +/// [`ARef<T>`]: crate::types::ARef
> >> +pub trait RawTimer: Sync {
> >> +    /// Schedule the timer after `expires` time units
> >> +    fn schedule(self, expires: u64);

This function should have a return value, see below:

> >> +}
[...]
> >> +impl<T> RawTimer for Arc<T>
> >> +where
> >> +    T: Send + Sync,
> >> +    T: HasTimer<T>,
> >> +{
> >> +    fn schedule(self, expires: u64) {
> >> +        let self_ptr = Arc::into_raw(self);
> >> +

so if the timer is already scheduled, re-scheduling will leak it, e.g.

	let timer: Arc<SomeTimer> = ...;

	let reschedule_handle = timer.clone(); // refcount == 2
	timer.schedule(...);

	...

	// later on, a reschedule is needed
	reschedule_handle.schedule(...); // refcount == 2

	// <timer callback invoked>
	Arc::drop();
	// refcount == 1, the Arc is leaked.

Looks to me `schedule()` should return the `Arc` back if it's already
in the queue.

TBH, if you don't need the re-schedule and cancel functionality, maybe
start with `impl<T> RawTimer for Pin<Box<T>>` first.

Regards,
Boqun

> >> +        // SAFETY: `self_ptr` is a valid pointer to a `T`
> >> +        let timer_ptr = unsafe { T::raw_get_timer(self_ptr) };
> >> +
> >> +        // `Timer` is `repr(transparent)`
> >> +        let c_timer_ptr = timer_ptr.cast::<bindings::hrtimer>();
> >> +
> >> +        // Schedule the timer - if it is already scheduled it is removed and
> >> +        // inserted
> >> +
> >> +        // SAFETY: c_timer_ptr points to a valid hrtimer instance that was
> >> +        // initialized by `hrtimer_init`
> >> +        unsafe {
> >> +            bindings::hrtimer_start_range_ns(
> >> +                c_timer_ptr.cast_mut(),
> >> +                expires as i64,
> >> +                0,
> >> +                bindings::hrtimer_mode_HRTIMER_MODE_REL,
> >> +            );
> >> +        }
> >> +    }
> >> +}
> >> +
[...]

