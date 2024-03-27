Return-Path: <linux-kernel+bounces-120231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D7588D49F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299A11F305FC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F7A28DAB;
	Wed, 27 Mar 2024 02:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuGXho7T"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FD32C18F;
	Wed, 27 Mar 2024 02:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711506995; cv=none; b=s3pe3AocUQFRSlOzFlmw2Oq7SSTxBvYvjqoOg3eTAP8b72RNIqxcFEcpi70W5m51UIa8Oya5HU2AteiaAehQvt6nAKdAyxX95x74PhuDUTz6HxY4L//jXCCld+ZfggmCXgmvhN+NI1BRPCHtYWW3f/vwuP5x+u05sqarumFfFMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711506995; c=relaxed/simple;
	bh=/MFiKpIHCX/TkC4eO2Idl1URX2vUkxWYKlY4WkmGVbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tw7pqh24Z8+/QPFp7DEbOx6TI1aLGI7XWmLKGMRQx5Cem8V6iVC0U43vekHJr6zmxQG0gDRZY3VdGmH1h49Oz4RG1lUNDic8a5X7AJKjokuZ+S5frQsUCxO+z412wUl/hfWmdqQ0i7F4ES/B7qMWCTcdWp4kJmNOsumAvd4HFPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuGXho7T; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso3732303a12.0;
        Tue, 26 Mar 2024 19:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711506993; x=1712111793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Su9TUxcyqp7E1w4G+ImqP9H/NVO5bEAfpZ37dB62GOI=;
        b=QuGXho7TMarZkBnf5ZgEumtUTWgXKI6YQI7VoLAcJxmhgqyrhaVhkKEqyR0d2aog9P
         FYSmznPLQoyteXxwrSMZU4Op5DWaZ6T3EOzD2xwlkIO8DcxRJWsyMRhe+tHFp3zEzpN5
         Ni97CMGAiPVeNd8okIpXVBl3ju0hdBLcMHIb28hCgyFsQ3GQddbclAn7RUqxsPt4ak0t
         wHQKXHz+q/7s1fy9L/pxP1eQizxJXjRUkMLowXr+qazE6yCjiNWedAFaTXpt+1iKYljK
         RGN3Cr8c3QG+RhLVyECy6p5yFzT9NSjUmXA8PKvKL0c4KnorRq7B7eC7vP+BiXc6a27T
         Zv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711506993; x=1712111793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Su9TUxcyqp7E1w4G+ImqP9H/NVO5bEAfpZ37dB62GOI=;
        b=p1t/tAXQ20EmXIqTh0e0r7WxiQWab256oPcEajV7ra5wQvZrSfLk98XFtoQoPeFLtK
         z+fjYY0grvOWCUnyFZMhD8LMYpFqtgTvCDPyW+LmZqT3ShxwXy3bXL4ggB3hdJjFnXel
         +HMuG85Qz3+WrVY1BmtQrfk+2N5vfovQqWx2v8C69JyKTPE1DZVnYwgm3dhzyQtRYd4u
         EZ6ZsKcl05DkDkPzovD5v+cu46j6LyGqAfzzJg717JW4ycl2MeZLjwdWZ8Qj5QCaKDAK
         lz9823o86MvraZGFAt9eflbRsEnkf4+UJWKqjh6c9kJjmsBFGiR5U2IewhII2/P/nfpz
         UR6g==
X-Forwarded-Encrypted: i=1; AJvYcCX69a+micJMTutlgn1qv/FRtfzgx/OhDq4VqPri1ddfaufhbaLnPUttKAA04SuiV2A0CTH76sJFI/YQ8V1I5gNEbBQHbNq+uJw6vaY0
X-Gm-Message-State: AOJu0Yzv7f8D/LHDTgLh17+0NidT66bQIlgIDZJSSEfYEKT6Vc2qnPcu
	wX7HuJjpzwLDtgjACPwRxmjMQjY67wOQruVYyUc4nyWCSd+5IGpC8iXBvrgv
X-Google-Smtp-Source: AGHT+IFPGnalkjt3Eo31tDVBROAL6FTPPNvqSU1vfmb+ndT88rEQxfjrp3qgOYaTQr2xmA6ArM1t4Q==
X-Received: by 2002:a05:6a20:1587:b0:1a3:7285:a63 with SMTP id h7-20020a056a20158700b001a372850a63mr1624045pzj.55.1711506993031;
        Tue, 26 Mar 2024 19:36:33 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id l20-20020a17090a409400b0029b2e5bc1b9sm347441pjg.23.2024.03.26.19.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 19:36:32 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH v2 09/10] rust: init: update `init` module to take allocation flags
Date: Tue, 26 Mar 2024 23:35:30 -0300
Message-Id: <20240327023531.187880-10-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327023531.187880-1-wedsonaf@gmail.com>
References: <20240327023531.187880-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

This is the last component in the conversion for allocators to take
allocation flags as parameters.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/init.rs               | 49 ++++++++++++++++---------------
 rust/kernel/sync/arc.rs           | 23 ++++++++-------
 rust/kernel/sync/condvar.rs       |  2 +-
 rust/kernel/sync/lock/mutex.rs    |  2 +-
 rust/kernel/sync/lock/spinlock.rs |  2 +-
 rust/kernel/workqueue.rs          | 13 +++++---
 6 files changed, 50 insertions(+), 41 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index a5911fec428b..fec47b274ec3 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -68,7 +68,7 @@
 //! #     a <- new_mutex!(42, "Foo::a"),
 //! #     b: 24,
 //! # });
-//! let foo: Result<Pin<Box<Foo>>> = Box::pin_init(foo);
+//! let foo: Result<Pin<Box<Foo>>> = Box::pin_init(foo, GFP_KERNEL);
 //! ```
 //!
 //! For more information see the [`pin_init!`] macro.
@@ -80,7 +80,8 @@
 //!
 //! ```rust
 //! # use kernel::sync::{new_mutex, Arc, Mutex};
-//! let mtx: Result<Arc<Mutex<usize>>> = Arc::pin_init(new_mutex!(42, "example::mtx"));
+//! let mtx: Result<Arc<Mutex<usize>>> =
+//!     Arc::pin_init(new_mutex!(42, "example::mtx"), GFP_KERNEL);
 //! ```
 //!
 //! To declare an init macro/function you just return an [`impl PinInit<T, E>`]:
@@ -99,7 +100,7 @@
 //!     fn new() -> impl PinInit<Self, Error> {
 //!         try_pin_init!(Self {
 //!             status <- new_mutex!(0, "DriverData::status"),
-//!             buffer: Box::init(kernel::init::zeroed())?,
+//!             buffer: Box::init(kernel::init::zeroed(), GFP_KERNEL)?,
 //!         })
 //!     }
 //! }
@@ -210,7 +211,7 @@
 //! [`pin_init!`]: crate::pin_init!
 
 use crate::{
-    alloc::{box_ext::BoxExt, flags::*},
+    alloc::{box_ext::BoxExt, Flags},
     error::{self, Error},
     sync::UniqueArc,
     types::{Opaque, ScopeGuard},
@@ -391,7 +392,7 @@ macro_rules! stack_try_pin_init {
 ///     },
 /// });
 /// # initializer }
-/// # Box::pin_init(demo()).unwrap();
+/// # Box::pin_init(demo(), GFP_KERNEL).unwrap();
 /// ```
 ///
 /// Arbitrary Rust expressions can be used to set the value of a variable.
@@ -461,7 +462,7 @@ macro_rules! stack_try_pin_init {
 /// #         })
 /// #     }
 /// # }
-/// let foo = Box::pin_init(Foo::new());
+/// let foo = Box::pin_init(Foo::new(), GFP_KERNEL);
 /// ```
 ///
 /// They can also easily embed it into their own `struct`s:
@@ -601,7 +602,7 @@ macro_rules! pin_init {
 /// impl BigBuf {
 ///     fn new() -> impl PinInit<Self, Error> {
 ///         try_pin_init!(Self {
-///             big: Box::init(init::zeroed())?,
+///             big: Box::init(init::zeroed(), GFP_KERNEL)?,
 ///             small: [0; 1024 * 1024],
 ///             ptr: core::ptr::null_mut(),
 ///         }? Error)
@@ -702,7 +703,7 @@ macro_rules! init {
 /// impl BigBuf {
 ///     fn new() -> impl Init<Self, Error> {
 ///         try_init!(Self {
-///             big: Box::init(zeroed())?,
+///             big: Box::init(zeroed(), GFP_KERNEL)?,
 ///             small: [0; 1024 * 1024],
 ///         }? Error)
 ///     }
@@ -1014,7 +1015,7 @@ pub fn uninit<T, E>() -> impl Init<MaybeUninit<T>, E> {
 ///
 /// ```rust
 /// use kernel::{error::Error, init::init_array_from_fn};
-/// let array: Box<[usize; 1_000]> = Box::init::<Error>(init_array_from_fn(|i| i)).unwrap();
+/// let array: Box<[usize; 1_000]> = Box::init::<Error>(init_array_from_fn(|i| i), GFP_KERNEL).unwrap();
 /// assert_eq!(array.len(), 1_000);
 /// ```
 pub fn init_array_from_fn<I, const N: usize, T, E>(
@@ -1058,7 +1059,7 @@ pub fn init_array_from_fn<I, const N: usize, T, E>(
 /// ```rust
 /// use kernel::{sync::{Arc, Mutex}, init::pin_init_array_from_fn, new_mutex};
 /// let array: Arc<[Mutex<usize>; 1_000]> =
-///     Arc::pin_init(pin_init_array_from_fn(|i| new_mutex!(i))).unwrap();
+///     Arc::pin_init(pin_init_array_from_fn(|i| new_mutex!(i)), GFP_KERNEL).unwrap();
 /// assert_eq!(array.len(), 1_000);
 /// ```
 pub fn pin_init_array_from_fn<I, const N: usize, T, E>(
@@ -1116,7 +1117,7 @@ pub trait InPlaceInit<T>: Sized {
     /// type.
     ///
     /// If `T: !Unpin` it will not be able to move afterwards.
-    fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
+    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
     where
         E: From<AllocError>;
 
@@ -1124,7 +1125,7 @@ fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
     /// type.
     ///
     /// If `T: !Unpin` it will not be able to move afterwards.
-    fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
+    fn pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> error::Result<Pin<Self>>
     where
         Error: From<E>,
     {
@@ -1132,16 +1133,16 @@ fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
         let init = unsafe {
             pin_init_from_closure(|slot| init.__pinned_init(slot).map_err(|e| Error::from(e)))
         };
-        Self::try_pin_init(init)
+        Self::try_pin_init(init, flags)
     }
 
     /// Use the given initializer to in-place initialize a `T`.
-    fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
+    fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
     where
         E: From<AllocError>;
 
     /// Use the given initializer to in-place initialize a `T`.
-    fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
+    fn init<E>(init: impl Init<T, E>, flags: Flags) -> error::Result<Self>
     where
         Error: From<E>,
     {
@@ -1149,17 +1150,17 @@ fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
         let init = unsafe {
             init_from_closure(|slot| init.__pinned_init(slot).map_err(|e| Error::from(e)))
         };
-        Self::try_init(init)
+        Self::try_init(init, flags)
     }
 }
 
 impl<T> InPlaceInit<T> for Box<T> {
     #[inline]
-    fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
+    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
     where
         E: From<AllocError>,
     {
-        let mut this = <Box<_> as BoxExt<_>>::new_uninit(GFP_KERNEL)?;
+        let mut this = <Box<_> as BoxExt<_>>::new_uninit(flags)?;
         let slot = this.as_mut_ptr();
         // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
         // slot is valid and will not be moved, because we pin it later.
@@ -1169,11 +1170,11 @@ fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
     }
 
     #[inline]
-    fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
+    fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
     where
         E: From<AllocError>,
     {
-        let mut this = <Box<_> as BoxExt<_>>::new_uninit(GFP_KERNEL)?;
+        let mut this = <Box<_> as BoxExt<_>>::new_uninit(flags)?;
         let slot = this.as_mut_ptr();
         // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
         // slot is valid.
@@ -1185,11 +1186,11 @@ fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
 
 impl<T> InPlaceInit<T> for UniqueArc<T> {
     #[inline]
-    fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
+    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
     where
         E: From<AllocError>,
     {
-        let mut this = UniqueArc::new_uninit(GFP_KERNEL)?;
+        let mut this = UniqueArc::new_uninit(flags)?;
         let slot = this.as_mut_ptr();
         // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
         // slot is valid and will not be moved, because we pin it later.
@@ -1199,11 +1200,11 @@ fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
     }
 
     #[inline]
-    fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
+    fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
     where
         E: From<AllocError>,
     {
-        let mut this = UniqueArc::new_uninit(GFP_KERNEL)?;
+        let mut this = UniqueArc::new_uninit(flags)?;
         let slot = this.as_mut_ptr();
         // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
         // slot is valid.
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index b67bb876ddf7..0866378f1360 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -182,22 +182,22 @@ pub fn new(contents: T, flags: Flags) -> Result<Self, AllocError> {
     ///
     /// If `T: !Unpin` it will not be able to move afterwards.
     #[inline]
-    pub fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Self>
+    pub fn pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> error::Result<Self>
     where
         Error: From<E>,
     {
-        UniqueArc::pin_init(init).map(|u| u.into())
+        UniqueArc::pin_init(init, flags).map(|u| u.into())
     }
 
     /// Use the given initializer to in-place initialize a `T`.
     ///
     /// This is equivalent to [`Arc<T>::pin_init`], since an [`Arc`] is always pinned.
     #[inline]
-    pub fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
+    pub fn init<E>(init: impl Init<T, E>, flags: Flags) -> error::Result<Self>
     where
         Error: From<E>,
     {
-        UniqueArc::init(init).map(|u| u.into())
+        UniqueArc::init(init, flags).map(|u| u.into())
     }
 }
 
@@ -565,13 +565,16 @@ pub fn new(value: T, flags: Flags) -> Result<Self, AllocError> {
     }
 
     /// Tries to allocate a new [`UniqueArc`] instance whose contents are not initialised yet.
-    pub fn new_uninit(_flags: Flags) -> Result<UniqueArc<MaybeUninit<T>>, AllocError> {
+    pub fn new_uninit(flags: Flags) -> Result<UniqueArc<MaybeUninit<T>>, AllocError> {
         // INVARIANT: The refcount is initialised to a non-zero value.
-        let inner = Box::try_init::<AllocError>(try_init!(ArcInner {
-            // SAFETY: There are no safety requirements for this FFI call.
-            refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
-            data <- init::uninit::<T, AllocError>(),
-        }? AllocError))?;
+        let inner = Box::try_init::<AllocError>(
+            try_init!(ArcInner {
+                // SAFETY: There are no safety requirements for this FFI call.
+                refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
+                data <- init::uninit::<T, AllocError>(),
+            }? AllocError),
+            flags,
+        )?;
         Ok(UniqueArc {
             // INVARIANT: The newly-created object has a refcount of 1.
             // SAFETY: The pointer from the `Box` is valid.
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 0c3671caffeb..ef6ffef0aa88 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -75,7 +75,7 @@ macro_rules! new_condvar {
 ///     Box::pin_init(pin_init!(Example {
 ///         value <- new_mutex!(0),
 ///         value_changed <- new_condvar!(),
-///     }))
+///     }), GFP_KERNEL)
 /// }
 /// ```
 ///
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index ef4c4634d294..93e1c982facf 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -60,7 +60,7 @@ macro_rules! new_mutex {
 /// }
 ///
 /// // Allocate a boxed `Example`.
-/// let e = Box::pin_init(Example::new())?;
+/// let e = Box::pin_init(Example::new(), GFP_KERNEL)?;
 /// assert_eq!(e.c, 10);
 /// assert_eq!(e.d.lock().a, 20);
 /// assert_eq!(e.d.lock().b, 30);
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index 0b22c635634f..6e900807d3b7 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -58,7 +58,7 @@ macro_rules! new_spinlock {
 /// }
 ///
 /// // Allocate a boxed `Example`.
-/// let e = Box::pin_init(Example::new())?;
+/// let e = Box::pin_init(Example::new(), GFP_KERNEL)?;
 /// assert_eq!(e.c, 10);
 /// assert_eq!(e.d.lock().a, 20);
 /// assert_eq!(e.d.lock().b, 30);
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 544f0c51f1b7..09a0f158ff1b 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -53,7 +53,7 @@
 //!         Arc::pin_init(pin_init!(MyStruct {
 //!             value,
 //!             work <- new_work!("MyStruct::work"),
-//!         }))
+//!         }), GFP_KERNEL)
 //!     }
 //! }
 //!
@@ -101,7 +101,7 @@
 //!             value_2,
 //!             work_1 <- new_work!("MyStruct::work_1"),
 //!             work_2 <- new_work!("MyStruct::work_2"),
-//!         }))
+//!         }), GFP_KERNEL)
 //!     }
 //! }
 //!
@@ -132,6 +132,7 @@
 //!
 //! C header: [`include/linux/workqueue.h`](srctree/include/linux/workqueue.h)
 
+use crate::alloc::Flags;
 use crate::{bindings, prelude::*, sync::Arc, sync::LockClassKey, types::Opaque};
 use alloc::alloc::AllocError;
 use alloc::boxed::Box;
@@ -206,13 +207,17 @@ pub fn enqueue<W, const ID: u64>(&self, w: W) -> W::EnqueueOutput
     /// Tries to spawn the given function or closure as a work item.
     ///
     /// This method can fail because it allocates memory to store the work item.
-    pub fn try_spawn<T: 'static + Send + FnOnce()>(&self, func: T) -> Result<(), AllocError> {
+    pub fn try_spawn<T: 'static + Send + FnOnce()>(
+        &self,
+        flags: Flags,
+        func: T,
+    ) -> Result<(), AllocError> {
         let init = pin_init!(ClosureWork {
             work <- new_work!("Queue::try_spawn"),
             func: Some(func),
         });
 
-        self.enqueue(Box::pin_init(init).map_err(|_| AllocError)?);
+        self.enqueue(Box::pin_init(init, flags).map_err(|_| AllocError)?);
         Ok(())
     }
 }
-- 
2.34.1


