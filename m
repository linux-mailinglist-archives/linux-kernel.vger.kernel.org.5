Return-Path: <linux-kernel+bounces-158324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5058B1E56
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5EE1C21D52
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBF384FBF;
	Thu, 25 Apr 2024 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="k6zgdYNM"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D9E7FBA3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038412; cv=none; b=EZa8VwczqnGI16Ny5kFwFMSZUpYtUVfN534saflm8o4MQmWdqifDNqmlkCsjvSE/nfC2wFkwOszYwf67V5DSklGF4wgo1D/uWEVAWCtLjfWcjHP/+JqhUulBAnm6b0SjkNEO/4HkaZwpanfUrWTJ8FcKVLC0IaHTXqO2ZV5jnnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038412; c=relaxed/simple;
	bh=XNiX59yyogpNk83JFHRFXm+QLl0yTAoKYYq8VyPozu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Os/BmwfG1hpwNtAJ58lgFatj4RiBzwU2A7SMS2ezdiuDFXkXQUWzYYaXL67uNd3lEiq2VHG+qQwq1KzzqtGuEIaM+2z+IE98PODgPGUBGOvD0d7sx13kJfQPP09TBEg7I6Ky6Bm9mzqWO2xw2L3gNy87e1qDthnZtpdfTmiXp4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=k6zgdYNM; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso1086897e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 02:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1714038408; x=1714643208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eRa9kc42TXW2jUhWRVQQ1tURo8DR/aWzs48K8hurW1Q=;
        b=k6zgdYNMhcPQLQ+qXMoUv2eaP9Xuv5DIWjpcG3DEF+tE2n/EUqWU2ZNDTKDPU2hZlr
         KaELsGhojUkdxoHNo1MAe/f41rQ84fzBUpt6vCVk2hKCVbTX3mArAYL8Etg5T6tefWj6
         LYGvGQL4xJ2+L+m7J+1G9MZuQ5elmHT2hTsh8Tr0xNqkKkxvcpOrDHuaMxGxfV2kUiSO
         97We8BnGEnjK74L8/4Hxqd3cUhdHjPvT6fxYA4xCzB01CuWOlgSM8BZtF+sAo2xmSB+e
         12se8Th3typ86vR7nL5DlD5qej6eZJR84Bwog2n0iYXl4rI3tmg9qMTnlpIVmbBue0qG
         pXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714038408; x=1714643208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRa9kc42TXW2jUhWRVQQ1tURo8DR/aWzs48K8hurW1Q=;
        b=dDC1eofPUxNfIcEXxc++LpuULvcz3ypuSRlP6f1lJ7MAJYZWZgSrm7es2rY6zAD3Dd
         GR6Dv3odS3IjVXiJPa+g4oKh5FN4TkCPsRa214vJpoj5hXiVa5e7hdM+VIus6MubAuXz
         SpME+IgWC2Vu6TEN47EoaFHP4GSe+zuoKLJp3jvW8tOuheJv8OD5oduX2EdYCQhL3LDj
         +SpVZZTGCA58B3JzUPpX4FLd/UwfnrkusDcbAk1kvyx2WIeX17nunXBXIrzH1T2d1n8T
         Ipi7Udb0zRt2BOghPwTj4miFNam7IRt2sOpfeyle2mLX60zcXrG+JxX7OCeADYetR3lU
         9uxA==
X-Forwarded-Encrypted: i=1; AJvYcCVFpMFYf6ZvxkTBHHiFPssg5dh+U7UeRB87CaRJFH+i/misrafGd9oVgOiLf/2wDgxB0e7RaEWRKKVYHl5j4+c7afoINcSp+w3hJ+Ts
X-Gm-Message-State: AOJu0YzqEM+qjPsLFDonPPY2tMWs77WkL9+IvJEX8/KxIifMk9uzWxID
	89hX+50/29yjAPxc7OQSvbJNyLK/6m3sqIaSRmMR+v+OWqWLYvoCs22itvDe8uw=
X-Google-Smtp-Source: AGHT+IFb6YOs42tL3kDjXpTMn7lXKRSN5eY7r2volOJ713wMQTpsvjCN6bk9rb8+2G6B0Fn5JT2L9g==
X-Received: by 2002:a05:6512:793:b0:51a:affe:252e with SMTP id x19-20020a056512079300b0051aaffe252emr4303240lfr.37.1714038407646;
        Thu, 25 Apr 2024 02:46:47 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id dk21-20020a170907941500b00a55aee4bf74sm5432387ejc.79.2024.04.25.02.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 02:46:47 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: hrtimer: introduce hrtimer support
Date: Thu, 25 Apr 2024 11:46:34 +0200
Message-ID: <20240425094634.262674-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

This patch adds support for intrusive use of the hrtimer system. For now, only
one timer can be embedded in a Rust struct.

The hrtimer Rust API is based on the intrusive style pattern introduced by the
Rust workqueue API.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>

---

This patch is a dependency for the Rust null block driver [1].

Link: https://lore.kernel.org/rust-for-linux/20240313110515.70088-1-nmi@metaspace.dk/T/#me0990150b9ba9f5b3d00293ec9a473c7bc3cc506 [1]

 rust/kernel/hrtimer.rs | 283 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |   1 +
 2 files changed, 284 insertions(+)
 create mode 100644 rust/kernel/hrtimer.rs

diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
new file mode 100644
index 000000000000..1e282608e70c
--- /dev/null
+++ b/rust/kernel/hrtimer.rs
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Intrusive high resolution timers.
+//!
+//! Allows scheduling timer callbacks without doing allocations at the time of
+//! scheduling. For now, only one timer per type is allowed.
+//!
+//! # Example
+//!
+//! ```rust
+//! use kernel::{
+//!     sync::Arc, hrtimer::{RawTimer, Timer, TimerCallback},
+//!     impl_has_timer, prelude::*, stack_pin_init
+//! };
+//! use core::sync::atomic::AtomicBool;
+//! use core::sync::atomic::Ordering;
+//!
+//! #[pin_data]
+//! struct IntrusiveTimer {
+//!     #[pin]
+//!     timer: Timer<Self>,
+//!     flag: AtomicBool,
+//! }
+//!
+//! impl IntrusiveTimer {
+//!     fn new() -> impl PinInit<Self> {
+//!         pin_init!(Self {
+//!             timer <- Timer::new(),
+//!             flag: AtomicBool::new(false),
+//!         })
+//!     }
+//! }
+//!
+//! impl TimerCallback for IntrusiveTimer {
+//!     type Receiver = Arc<IntrusiveTimer>;
+//!
+//!     fn run(this: Self::Receiver) {
+//!         pr_info!("Timer called\n");
+//!         this.flag.store(true, Ordering::Relaxed);
+//!     }
+//! }
+//!
+//! impl_has_timer! {
+//!     impl HasTimer<Self> for IntrusiveTimer { self.timer }
+//! }
+//!
+//! let has_timer = Arc::pin_init(IntrusiveTimer::new())?;
+//! has_timer.clone().schedule(200_000_000);
+//! while !has_timer.flag.load(Ordering::Relaxed) { core::hint::spin_loop() }
+//!
+//! pr_info!("Flag raised\n");
+//!
+//! # Ok::<(), kernel::error::Error>(())
+//! ```
+//!
+//! C header: [`include/linux/hrtimer.h`](srctree/include/linux/hrtimer.h)
+
+use core::{marker::PhantomData, pin::Pin};
+
+use crate::{init::PinInit, prelude::*, sync::Arc, types::Opaque};
+
+/// A timer backed by a C `struct hrtimer`
+///
+/// # Invariants
+///
+/// * `self.timer` is initialized by `bindings::hrtimer_init`.
+#[repr(transparent)]
+#[pin_data(PinnedDrop)]
+pub struct Timer<T> {
+    #[pin]
+    timer: Opaque<bindings::hrtimer>,
+    _t: PhantomData<T>,
+}
+
+// SAFETY: A `Timer` can be moved to other threads and used from there.
+unsafe impl<T> Send for Timer<T> {}
+
+// SAFETY: Timer operations are locked on C side, so it is safe to operate on a
+// timer from multiple threads
+unsafe impl<T> Sync for Timer<T> {}
+
+impl<T: TimerCallback> Timer<T> {
+    /// Return an initializer for a new timer instance.
+    pub fn new() -> impl PinInit<Self> {
+        crate::pin_init!( Self {
+            timer <- Opaque::ffi_init(move |place: *mut bindings::hrtimer| {
+                // SAFETY: By design of `pin_init!`, `place` is a pointer live
+                // allocation. hrtimer_init will initialize `place` and does not
+                // require `place` to be initialized prior to the call.
+                unsafe {
+                    bindings::hrtimer_init(
+                        place,
+                        bindings::CLOCK_MONOTONIC as i32,
+                        bindings::hrtimer_mode_HRTIMER_MODE_REL,
+                    );
+                }
+
+                // SAFETY: `place` is pointing to a live allocation, so the deref
+                // is safe. The `function` field might not be initialized, but
+                // `addr_of_mut` does not create a reference to the field.
+                let function: *mut Option<_> = unsafe { core::ptr::addr_of_mut!((*place).function) };
+
+                // SAFETY: `function` points to a valid allocation.
+                unsafe { core::ptr::write(function, Some(T::Receiver::run)) };
+            }),
+            _t: PhantomData,
+        })
+    }
+}
+
+#[pinned_drop]
+impl<T> PinnedDrop for Timer<T> {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: By struct invariant `self.timer` was initialized by
+        // `hrtimer_init` so by C API contract it is safe to call
+        // `hrtimer_cancel`.
+        unsafe {
+            bindings::hrtimer_cancel(self.timer.get());
+        }
+    }
+}
+
+/// Implemented by pointer types to structs that embed a [`Timer`]. This trait
+/// facilitates queueing the timer through the pointer that implements the
+/// trait.
+///
+/// Typical implementers would be [`Box<T>`], [`Arc<T>`], [`ARef<T>`] where `T`
+/// has a field of type `Timer`.
+///
+/// Target must be [`Sync`] because timer callbacks happen in another thread of
+/// execution.
+///
+/// [`Box<T>`]: Box
+/// [`Arc<T>`]: Arc
+/// [`ARef<T>`]: crate::types::ARef
+pub trait RawTimer: Sync {
+    /// Schedule the timer after `expires` time units
+    fn schedule(self, expires: u64);
+}
+
+/// Implemented by structs that contain timer nodes.
+///
+/// Clients of the timer API would usually safely implement this trait by using
+/// the [`impl_has_timer`] macro.
+///
+/// # Safety
+///
+/// Implementers of this trait must ensure that the implementer has a [`Timer`]
+/// field at the offset specified by `OFFSET` and that all trait methods are
+/// implemented according to their documentation.
+///
+/// [`impl_has_timer`]: crate::impl_has_timer
+pub unsafe trait HasTimer<T> {
+    /// Offset of the [`Timer`] field within `Self`
+    const OFFSET: usize;
+
+    /// Return a pointer to the [`Timer`] within `Self`.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must point to a valid struct of type `Self`.
+    unsafe fn raw_get_timer(ptr: *const Self) -> *const Timer<T> {
+        // SAFETY: By the safety requirement of this trait, the trait
+        // implementor will have a `Timer` field at the specified offset.
+        unsafe { ptr.cast::<u8>().add(Self::OFFSET).cast::<Timer<T>>() }
+    }
+
+    /// Return a pointer to the struct that is embedding the [`Timer`] pointed
+    /// to by `ptr`.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must point to a [`Timer<T>`] field in a struct of type `Self`.
+    unsafe fn timer_container_of(ptr: *mut Timer<T>) -> *mut Self
+    where
+        Self: Sized,
+    {
+        // SAFETY: By the safety requirement of this trait, the trait
+        // implementor will have a `Timer` field at the specified offset.
+        unsafe { ptr.cast::<u8>().sub(Self::OFFSET).cast::<Self>() }
+    }
+}
+
+/// Implemented by pointer types that can be the target of a C timer callback.
+pub trait RawTimerCallback: RawTimer {
+    /// Callback to be called from C.
+    ///
+    /// # Safety
+    ///
+    /// Only to be called by C code in `hrtimer`subsystem.
+    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart;
+}
+
+/// Implemented by pointers to structs that can the target of a timer callback
+pub trait TimerCallback {
+    /// Type of `this` argument for `run()`.
+    type Receiver: RawTimerCallback;
+
+    /// Called by the timer logic when the timer fires
+    fn run(this: Self::Receiver);
+}
+
+impl<T> RawTimer for Arc<T>
+where
+    T: Send + Sync,
+    T: HasTimer<T>,
+{
+    fn schedule(self, expires: u64) {
+        let self_ptr = Arc::into_raw(self);
+
+        // SAFETY: `self_ptr` is a valid pointer to a `T`
+        let timer_ptr = unsafe { T::raw_get_timer(self_ptr) };
+
+        // `Timer` is `repr(transparent)`
+        let c_timer_ptr = timer_ptr.cast::<bindings::hrtimer>();
+
+        // Schedule the timer - if it is already scheduled it is removed and
+        // inserted
+
+        // SAFETY: c_timer_ptr points to a valid hrtimer instance that was
+        // initialized by `hrtimer_init`
+        unsafe {
+            bindings::hrtimer_start_range_ns(
+                c_timer_ptr.cast_mut(),
+                expires as i64,
+                0,
+                bindings::hrtimer_mode_HRTIMER_MODE_REL,
+            );
+        }
+    }
+}
+
+impl<T> kernel::hrtimer::RawTimerCallback for Arc<T>
+where
+    T: Send + Sync,
+    T: HasTimer<T>,
+    T: TimerCallback<Receiver = Self>,
+{
+    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
+        // `Timer` is `repr(transparent)`
+        let timer_ptr = ptr.cast::<kernel::hrtimer::Timer<T>>();
+
+        // SAFETY: By C API contract `ptr` is the pointer we passed when
+        // enqueing the timer, so it is a `Timer<T>` embedded in a `T`
+        let data_ptr = unsafe { T::timer_container_of(timer_ptr) };
+
+        // SAFETY: This `Arc` comes from a call to `Arc::into_raw()`
+        let receiver = unsafe { Arc::from_raw(data_ptr) };
+
+        T::run(receiver);
+
+        bindings::hrtimer_restart_HRTIMER_NORESTART
+    }
+}
+
+/// Use to implement the [`HasTimer<T>`] trait.
+///
+/// See [`module`] documentation for an example.
+///
+/// [`module`]: crate::hrtimer
+#[macro_export]
+macro_rules! impl_has_timer {
+    ($(impl$(<$($implarg:ident),*>)?
+       HasTimer<$timer_type:ty $(, $id:tt)?>
+       for $self:ident $(<$($selfarg:ident),*>)?
+       { self.$field:ident }
+    )*) => {$(
+        // SAFETY: This implementation of `raw_get_timer` only compiles if the
+        // field has the right type.
+        unsafe impl$(<$($implarg),*>)? $crate::hrtimer::HasTimer<$timer_type> for $self $(<$($selfarg),*>)? {
+            const OFFSET: usize = ::core::mem::offset_of!(Self, $field) as usize;
+
+            #[inline]
+            unsafe fn raw_get_timer(ptr: *const Self) -> *const $crate::hrtimer::Timer<$timer_type $(, $id)?> {
+                // SAFETY: The caller promises that the pointer is not dangling.
+                unsafe {
+                    ::core::ptr::addr_of!((*ptr).$field)
+                }
+            }
+
+        }
+    )*};
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index be68d5e567b1..7af3ca601167 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -33,6 +33,7 @@
 mod allocator;
 mod build_assert;
 pub mod error;
+pub mod hrtimer;
 pub mod init;
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]

base-commit: ed30a4a51bb196781c8058073ea720133a65596f
-- 
2.44.0


