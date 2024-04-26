Return-Path: <linux-kernel+bounces-159783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD128B33EF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6419B284AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CE513F006;
	Fri, 26 Apr 2024 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="Vi30l222"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E27913E043
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123680; cv=none; b=c23flLDNvvJMTIi5Otg3lCHdskt6aS02aYYh/pUEE0LEOxnwuEYdDFDNxHgAiX1i6ONrZNl8ZTZgr4tjXh9uHm+Ofr25+D8bAXGZHTntCEOJ/8s4e3CbC37wf2XmUt/qVUm+WiDJ8ag6PmVTvUxTw7G9aOJqJrXF7+PMpoeZkPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123680; c=relaxed/simple;
	bh=GJRp7B64ijouM9ef62ewp+J58Xr8/bJESc8OgA9KjdI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=omKlyHT70mj0VjkGDs4Kg/fqS1JkosOxLiVNE0l4SdIlm9qMIJQFfjjrmFRRiLIATMJnt8/MmxcLtmeBJCUHjkHVeP5OSF+TRSHoHYaycfcb4/DPnJrZ7TeA+mVDmgfH2jvQTyFULj3BkppEypaW3y9HblOksDwh17g/PgnmxPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=Vi30l222; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41a1d2a7b81so16888955e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 02:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1714123675; x=1714728475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCe41W3Evb5yqneAyZnfwTlHPmLnU46Aybvr70CrSOw=;
        b=Vi30l222861+n613JcdwZMCRBthYANn6djYVAX4J0IiKwk7pTGy6DlevI9Tly5isMu
         wBidz4/ulaHOM+qe+WXEkjpiL4pzRh3IVnva4ycoAkgpKhGUJEE8bpagYYC501YGxEXq
         uklvrU3QJNnwDvyVJPYVX9As9XhINMm4Qx5+8J1tKuYMKkJDIT/PxN8/mgaWWFsvh6N/
         w8zL1+c0BhFSpds7n+p31rm940yuRufo4dJ9/HoLyhMnloFFlf+tBW9AMWbd3V/G7LX7
         hM+1NnrQzWWpxYbdBjEbAybr8nZcAz8FlyV3174njQSi7jn6s/jtdaki77ILk/XSgYjv
         E4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714123675; x=1714728475;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lCe41W3Evb5yqneAyZnfwTlHPmLnU46Aybvr70CrSOw=;
        b=Ppx+7J0d4pe0L0HfIjR0vO8dmg8oml1zyrDaOXWsLwYnCpZAr4zWZLxtorMCeEKbTM
         94nH96AmgQTSq3VLJu+9OPH0Y7IuGgLxlWz84WpxCewqhYCVagJJQvO1hFF3j/c0RlRA
         jplBGz6RAaqQO2FTIOD2zpyv/etaX9qHdRRsj+pR3qaJXcbek02kWNbJMH74NzPWeP7N
         nKG3OcTG7EBMPChgBvkT4VAs7HsZRQLlvuXEi2u25/EjA71oBQ3/DY6Vcs/Xms7tAbZc
         F0y30XGo3YkgxkVIdXetY4ibx3bETNhpzSMXcwgq5p2+NnW6zl4oJrY5AaKEF/eDzwAl
         oosA==
X-Forwarded-Encrypted: i=1; AJvYcCVSmvAv/pIkCWuaRTuZqd9OrloWLszIeaN/8B8VenSJKwnSw/bVV6V8g0SYgs9W63Wdn7ha/6OujD3VfkeIjMIzgKJzULiYMf2GJkAG
X-Gm-Message-State: AOJu0YxMkgpN27V683tKjYAJ2m73RST7z2pYhcyyxTgqx6L0b1mIGR5w
	/wvDxh9S23DOe8oKCzN1orBQFzeNl+ZDJ4f8gvUHEOdVRWqMdQY7xqdrqqOa/To=
X-Google-Smtp-Source: AGHT+IGz3SdIG6gpyiO8sUV9JSAfWGHLksH7Gz1ozAlSah+R3bRJKm6HvzoytZLw36FT5IPsdh3HzA==
X-Received: by 2002:adf:fc82:0:b0:346:47a6:e77e with SMTP id g2-20020adffc82000000b0034647a6e77emr4303669wrr.27.1714123674702;
        Fri, 26 Apr 2024 02:27:54 -0700 (PDT)
Received: from localhost ([147.161.155.113])
        by smtp.gmail.com with ESMTPSA id v2-20020adfe282000000b00346ceb9e060sm21795111wri.103.2024.04.26.02.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 02:27:54 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Wedson Almeida Filho <wedsonaf@gmail.com>,  Anna-Maria Behnsen
 <anna-maria@linutronix.de>,  Frederic Weisbecker <frederic@kernel.org>,
  Thomas Gleixner <tglx@linutronix.de>,  Andreas Hindborg
 <a.hindborg@samsung.com>,  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Alice
 Ryhl <aliceryhl@google.com>,  rust-for-linux@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: hrtimer: introduce hrtimer support
In-Reply-To: <a7a560c7-fb8c-4adf-9f46-2e272f24b335@proton.me> (Benno Lossin's
	message of "Fri, 26 Apr 2024 07:52:41 +0000")
References: <20240425094634.262674-1-nmi@metaspace.dk>
	<a7a560c7-fb8c-4adf-9f46-2e272f24b335@proton.me>
User-Agent: mu4e 1.12.4; emacs 29.3
Date: Fri, 26 Apr 2024 11:27:49 +0200
Message-ID: <87v844lbhm.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Benno Lossin <benno.lossin@proton.me> writes:

> On 25.04.24 11:46, Andreas Hindborg wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>>=20
>> This patch adds support for intrusive use of the hrtimer system. For now=
, only
>> one timer can be embedded in a Rust struct.
>>=20
>> The hrtimer Rust API is based on the intrusive style pattern introduced =
by the
>> Rust workqueue API.
>>=20
>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>>=20
>> ---
>>=20
>> This patch is a dependency for the Rust null block driver [1].
>>=20
>> Link: https://lore.kernel.org/rust-for-linux/20240313110515.70088-1-nmi@=
metaspace.dk/T/#me0990150b9ba9f5b3d00293ec9a473c7bc3cc506 [1]
>>=20
>>  rust/kernel/hrtimer.rs | 283 +++++++++++++++++++++++++++++++++++++++++
>>  rust/kernel/lib.rs     |   1 +
>>  2 files changed, 284 insertions(+)
>>  create mode 100644 rust/kernel/hrtimer.rs
>>=20
>> diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
>
> Hmm is this the right place? I imagine there are other timers, does this
> fit better into the `time` module (ie make `hrtimer` a submodule of
> `time`) or should we later introduce a `timer` parent module?

We can always move it. We will move stuff anyway when the kernel crate
is split.

We can also take it to `kernel::time::hrtimer` now, either way is fine.

>
>> new file mode 100644
>> index 000000000000..1e282608e70c
>> --- /dev/null
>> +++ b/rust/kernel/hrtimer.rs
>> @@ -0,0 +1,283 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Intrusive high resolution timers.
>> +//!
>> +//! Allows scheduling timer callbacks without doing allocations at the =
time of
>> +//! scheduling. For now, only one timer per type is allowed.
>> +//!
>> +//! # Example
>> +//!
>> +//! ```rust
>> +//! use kernel::{
>> +//!     sync::Arc, hrtimer::{RawTimer, Timer, TimerCallback},
>> +//!     impl_has_timer, prelude::*, stack_pin_init
>> +//! };
>> +//! use core::sync::atomic::AtomicBool;
>> +//! use core::sync::atomic::Ordering;
>> +//!
>> +//! #[pin_data]
>> +//! struct IntrusiveTimer {
>> +//!     #[pin]
>> +//!     timer: Timer<Self>,
>> +//!     flag: AtomicBool,
>> +//! }
>> +//!
>> +//! impl IntrusiveTimer {
>> +//!     fn new() -> impl PinInit<Self> {
>> +//!         pin_init!(Self {
>> +//!             timer <- Timer::new(),
>> +//!             flag: AtomicBool::new(false),
>> +//!         })
>> +//!     }
>> +//! }
>> +//!
>> +//! impl TimerCallback for IntrusiveTimer {
>> +//!     type Receiver =3D Arc<IntrusiveTimer>;
>> +//!
>> +//!     fn run(this: Self::Receiver) {
>> +//!         pr_info!("Timer called\n");
>> +//!         this.flag.store(true, Ordering::Relaxed);
>> +//!     }
>> +//! }
>> +//!
>> +//! impl_has_timer! {
>> +//!     impl HasTimer<Self> for IntrusiveTimer { self.timer }
>> +//! }
>> +//!
>> +//! let has_timer =3D Arc::pin_init(IntrusiveTimer::new())?;
>
> I would not name this variable `has_timer`. Maybe `my_timer` is better?

Right, thanks.

>
>> +//! has_timer.clone().schedule(200_000_000);
>> +//! while !has_timer.flag.load(Ordering::Relaxed) { core::hint::spin_lo=
op() }
>
> Weird formatting, we should also use `rustfmt` in examples.

`format_code_in_doc_comments` is a nightly `rustfmt` feature. I tried
enabling it in `.rustfmt.toml` and running `rustfmt +nightly
hrtimer.rs`. It did not have any effect. There is some discussion here:
https://github.com/rust-lang/rustfmt/issues/3348

>
>> +//!
>> +//! pr_info!("Flag raised\n");
>> +//!
>> +//! # Ok::<(), kernel::error::Error>(())
>> +//! ```
>> +//!
>> +//! C header: [`include/linux/hrtimer.h`](srctree/include/linux/hrtimer=
h)
>> +
>> +use core::{marker::PhantomData, pin::Pin};
>> +
>> +use crate::{init::PinInit, prelude::*, sync::Arc, types::Opaque};
>> +
>> +/// A timer backed by a C `struct hrtimer`
>
> Missing `.` at the end, this also occurs below.

=F0=9F=91=8D

>
>> +///
>> +/// # Invariants
>> +///
>> +/// * `self.timer` is initialized by `bindings::hrtimer_init`.
>> +#[repr(transparent)]
>> +#[pin_data(PinnedDrop)]
>> +pub struct Timer<T> {
>> +    #[pin]
>> +    timer: Opaque<bindings::hrtimer>,
>> +    _t: PhantomData<T>,
>> +}
>> +
>> +// SAFETY: A `Timer` can be moved to other threads and used from there.
>> +unsafe impl<T> Send for Timer<T> {}
>> +
>> +// SAFETY: Timer operations are locked on C side, so it is safe to oper=
ate on a
>> +// timer from multiple threads
>> +unsafe impl<T> Sync for Timer<T> {}
>> +
>> +impl<T: TimerCallback> Timer<T> {
>> +    /// Return an initializer for a new timer instance.
>> +    pub fn new() -> impl PinInit<Self> {
>> +        crate::pin_init!( Self {
>
> `pin_init!` is in the prelude, no need to prefix with `crate`.

=F0=9F=91=8D

>
>> +            timer <- Opaque::ffi_init(move |place: *mut bindings::hrtim=
er| {
>> +                // SAFETY: By design of `pin_init!`, `place` is a point=
er live
>> +                // allocation. hrtimer_init will initialize `place` and=
 does not
>> +                // require `place` to be initialized prior to the call.
>> +                unsafe {
>> +                    bindings::hrtimer_init(
>> +                        place,
>> +                        bindings::CLOCK_MONOTONIC as i32,
>> +                        bindings::hrtimer_mode_HRTIMER_MODE_REL,
>> +                    );
>> +                }
>> +
>> +                // SAFETY: `place` is pointing to a live allocation, so=
 the deref
>> +                // is safe. The `function` field might not be initializ=
ed, but
>> +                // `addr_of_mut` does not create a reference to the fie=
ld.
>> +                let function: *mut Option<_> =3D unsafe { core::ptr::ad=
dr_of_mut!((*place).function) };
>> +
>> +                // SAFETY: `function` points to a valid allocation.
>> +                unsafe { core::ptr::write(function, Some(T::Receiver::r=
un)) };
>> +            }),
>> +            _t: PhantomData,
>> +        })
>> +    }
>> +}
>> +
>> +#[pinned_drop]
>> +impl<T> PinnedDrop for Timer<T> {
>> +    fn drop(self: Pin<&mut Self>) {
>> +        // SAFETY: By struct invariant `self.timer` was initialized by
>> +        // `hrtimer_init` so by C API contract it is safe to call
>> +        // `hrtimer_cancel`.
>> +        unsafe {
>> +            bindings::hrtimer_cancel(self.timer.get());
>> +        }
>> +    }
>> +}
>
> Why is this needed? The only way to schedule a timer using this API is
> by having an `Arc` with a timer-containing struct inside. But to
> schedule the `Arc`, you consume one refcount which is then sent to the
> timer subsystem. So it is impossible for the refcount to drop below zero
> while the timer is scheduled, but not yet running.
> Do you need to call `hrtimer_cancel` after/while a timer is running?

This is not required any longer. It is a leftover from an earlier
revision where timers could be stack allocated. I will remove it.

> Also is it ok to call `hrtimer_cancel` inside the timer callback? Since
> that can happen when the timer callback owns the last refcount.

That should be fine, `self` is still valid when the drop method is run?

>
>> +
>> +/// Implemented by pointer types to structs that embed a [`Timer`]. Thi=
s trait
>> +/// facilitates queueing the timer through the pointer that implements =
the
>> +/// trait.
>> +///
>> +/// Typical implementers would be [`Box<T>`], [`Arc<T>`], [`ARef<T>`] w=
here `T`
>> +/// has a field of type `Timer`.
>> +///
>> +/// Target must be [`Sync`] because timer callbacks happen in another t=
hread of
>> +/// execution.
>> +///
>> +/// [`Box<T>`]: Box
>> +/// [`Arc<T>`]: Arc
>> +/// [`ARef<T>`]: crate::types::ARef
>> +pub trait RawTimer: Sync {
>> +    /// Schedule the timer after `expires` time units
>> +    fn schedule(self, expires: u64);
>> +}
>> +
>> +/// Implemented by structs that contain timer nodes.
>> +///
>> +/// Clients of the timer API would usually safely implement this trait =
by using
>> +/// the [`impl_has_timer`] macro.
>> +///
>> +/// # Safety
>> +///
>> +/// Implementers of this trait must ensure that the implementer has a [=
`Timer`]
>> +/// field at the offset specified by `OFFSET` and that all trait method=
s are
>> +/// implemented according to their documentation.
>> +///
>> +/// [`impl_has_timer`]: crate::impl_has_timer
>> +pub unsafe trait HasTimer<T> {
>> +    /// Offset of the [`Timer`] field within `Self`
>> +    const OFFSET: usize;
>> +
>> +    /// Return a pointer to the [`Timer`] within `Self`.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `ptr` must point to a valid struct of type `Self`.
>> +    unsafe fn raw_get_timer(ptr: *const Self) -> *const Timer<T> {
>> +        // SAFETY: By the safety requirement of this trait, the trait
>> +        // implementor will have a `Timer` field at the specified offse=
t.
>> +        unsafe { ptr.cast::<u8>().add(Self::OFFSET).cast::<Timer<T>>() }
>> +    }
>> +
>> +    /// Return a pointer to the struct that is embedding the [`Timer`] =
pointed
>> +    /// to by `ptr`.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `ptr` must point to a [`Timer<T>`] field in a struct of type `S=
elf`.
>> +    unsafe fn timer_container_of(ptr: *mut Timer<T>) -> *mut Self
>> +    where
>> +        Self: Sized,
>> +    {
>> +        // SAFETY: By the safety requirement of this trait, the trait
>> +        // implementor will have a `Timer` field at the specified offse=
t.
>> +        unsafe { ptr.cast::<u8>().sub(Self::OFFSET).cast::<Self>() }
>> +    }
>> +}
>> +
>> +/// Implemented by pointer types that can be the target of a C timer ca=
llback.
>> +pub trait RawTimerCallback: RawTimer {
>
> Do you really need two different traits? Can't we have a single
> `TimerPointer` trait that does both `RawTimerCallback` and `RawTimer`?
> (I am also wondering why we did this for workqueue)

Let me try to merge them and see what happens.

>
>> +    /// Callback to be called from C.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Only to be called by C code in `hrtimer`subsystem.
>> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::=
hrtimer_restart;
>> +}
>> +
>> +/// Implemented by pointers to structs that can the target of a timer c=
allback
>> +pub trait TimerCallback {
>> +    /// Type of `this` argument for `run()`.
>> +    type Receiver: RawTimerCallback;
>> +
>> +    /// Called by the timer logic when the timer fires
>> +    fn run(this: Self::Receiver);
>> +}
>> +
>> +impl<T> RawTimer for Arc<T>
>> +where
>> +    T: Send + Sync,
>> +    T: HasTimer<T>,
>> +{
>> +    fn schedule(self, expires: u64) {
>> +        let self_ptr =3D Arc::into_raw(self);
>> +
>> +        // SAFETY: `self_ptr` is a valid pointer to a `T`
>> +        let timer_ptr =3D unsafe { T::raw_get_timer(self_ptr) };
>> +
>> +        // `Timer` is `repr(transparent)`
>> +        let c_timer_ptr =3D timer_ptr.cast::<bindings::hrtimer>();
>> +
>> +        // Schedule the timer - if it is already scheduled it is remove=
d and
>> +        // inserted
>> +
>> +        // SAFETY: c_timer_ptr points to a valid hrtimer instance that =
was
>> +        // initialized by `hrtimer_init`
>> +        unsafe {
>> +            bindings::hrtimer_start_range_ns(
>> +                c_timer_ptr.cast_mut(),
>> +                expires as i64,
>> +                0,
>> +                bindings::hrtimer_mode_HRTIMER_MODE_REL,
>> +            );
>> +        }
>> +    }
>> +}
>> +
>> +impl<T> kernel::hrtimer::RawTimerCallback for Arc<T>
>
> Why are you spelling out the whole path?

The real question to ask is why does rustfmt or the compiler not suggest
that I remove the explicit path?

>
>> +where
>> +    T: Send + Sync,
>> +    T: HasTimer<T>,
>> +    T: TimerCallback<Receiver =3D Self>,
>> +{
>> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::=
hrtimer_restart {
>> +        // `Timer` is `repr(transparent)`
>> +        let timer_ptr =3D ptr.cast::<kernel::hrtimer::Timer<T>>();
>> +
>> +        // SAFETY: By C API contract `ptr` is the pointer we passed when
>> +        // enqueing the timer, so it is a `Timer<T>` embedded in a `T`
>> +        let data_ptr =3D unsafe { T::timer_container_of(timer_ptr) };
>> +
>> +        // SAFETY: This `Arc` comes from a call to `Arc::into_raw()`
>> +        let receiver =3D unsafe { Arc::from_raw(data_ptr) };
>> +
>> +        T::run(receiver);
>> +
>> +        bindings::hrtimer_restart_HRTIMER_NORESTART
>> +    }
>> +}
>> +
>> +/// Use to implement the [`HasTimer<T>`] trait.
>> +///
>> +/// See [`module`] documentation for an example.
>> +///
>> +/// [`module`]: crate::hrtimer
>> +#[macro_export]
>> +macro_rules! impl_has_timer {
>> +    ($(impl$(<$($implarg:ident),*>)?
>
> Doing it this way makes it impossible to use more complex types with eg
> lifetimes or const generic arguments. There is a workaround, see Alice's
> linked list patch [1]:
>
>      macro_rules! impl_list_item {
>          (
>              impl$({$($generics:tt)*})? ListItem<$num:tt> for $t:ty {
>                  using ListLinks;
>              } $($rest:tt)*
>          ) =3D> {
>
> [1]: https://lore.kernel.org/rust-for-linux/20240402-linked-list-v1-4-b1c=
59ba7ae3b@google.com/

Thanks, I will take a look.

>
>> +       HasTimer<$timer_type:ty $(, $id:tt)?>
>
> `HasTimer` currently doesn't have an `id`, so the macro also shouldn't
> have it.

Thanks, I guess inheritance of this macro is very evident :)

Thanks for the comments!

BR Andreas


