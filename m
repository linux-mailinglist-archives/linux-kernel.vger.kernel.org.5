Return-Path: <linux-kernel+bounces-120227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E1988D49C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 243112E810D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FABA23765;
	Wed, 27 Mar 2024 02:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGvyb41W"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD50424B5B;
	Wed, 27 Mar 2024 02:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711506983; cv=none; b=V3JUDvMbANOtevTcemQsiOzBHkGfVK6yNPbdI5EQS6og1OEfThgbqxLKq7zf9N9eh+qvpF8D1cq/KWWwi6/cLAR87ptKck7QYAwgreIvnvUxNr5I6qvT+Uw2g4rAKYb80qgFNHFnKB87lJ77kz/EIcqFJM8gauhQMfgFiM789xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711506983; c=relaxed/simple;
	bh=17ik0Ul2gPKK8aUlxS+AElFknDr9P8MWNuwiq1vhq+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WZhBQz86G62Xv2CB5EPDx9fSQkS+KMX9lva1NNvRR6NjCTLPTKvnG19lLt0LykcRdO4V47qXNcgsQKiToeiC8CfpThWIX6b0RVxC1b6+iK+ISpbxHr1GzkTeNBiCUR9hgtJYjfBtIbkzjTPdk0ogNjB0BHk8K5hQxsykk9gUV18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGvyb41W; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d3907ff128so4694344a12.3;
        Tue, 26 Mar 2024 19:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711506981; x=1712111781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HHQeIoqMo2CZOYcEbyAnPxdtILQe9NcGBVh9oiIIeA=;
        b=QGvyb41WE4bHkWCAixzXlEX6gunz0ILP4HWloKkkvQ9Vy70RbRuQ344VmcQ7gqA3Uk
         o0ChVxDNtdlO3Ve1Exq4oJP2y8RDXZiX26en5hy45FfUyeNUXQY5QQgBG+rWuE9xiLrK
         3DQZo28sibiy6u1n8I9opXkX3dSjZZSk0ykjLq/7WmtFEVEuv3uOSxKostHLEdQNWEKL
         weZziQim/fW8OMfOuzb8isngATyuhWQK1EcjqiKQkUxfm89xxXsYKkMXTS34fRnCSaRp
         YlzEdJCxIBY+CrK6noFlujjegD1Pg8StTEgb3TZYzxACi/jUEZGHf/s4mORpzaIzeBZC
         1UAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711506981; x=1712111781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HHQeIoqMo2CZOYcEbyAnPxdtILQe9NcGBVh9oiIIeA=;
        b=sM8rbJGdb9IAui9Ihzb38OQ/yqCl3mD9KZZHOLm8PVevGI0HIkeo38IPt2UsFNFpk9
         UXoMOs7BPILE+hlFy/YWBXPWLzDRCgEVW6TAbaMrFqqoS0hKgT4hc6BVeoYiXrxjaGbH
         g6uwTCaPIEmYDryvmwg8sl1cBrcgNjpJZFPhv72h1hbN82n+Uq1281e6V0qVWxCgME0v
         MNQNh7jgKJFaj1ewzUqrwRs68US2V5IiMVdyHzcrD9V7xiFAg0LT/evOjqJOa/HI/dIh
         QljB/M2OhZKBtJk53qEoHJ9SmXb+ZF80dcjcDQ2dl778eewZPWW3M0hx+kJMRvozRz9B
         eG4A==
X-Forwarded-Encrypted: i=1; AJvYcCUjBvYWasynLvkduEaHKg4Jopf7mQgLGL4NHgcWnkajnVng+/Pa5m3Kc2LRgJetzf+61Kzh2ktY+/lmjfwG+cbxSFPhGbjVAbHX27vg
X-Gm-Message-State: AOJu0YxXg4v0/pyArmd2tlr/YleQs6RPXtuiIhbHZAbQIvp+3MddE5b1
	jWmQgFRertJnTX+pfFJOEYTsvAMMN+i9NQ7I5Lhf+FZFF0TFl6OKzkQ0wGPl
X-Google-Smtp-Source: AGHT+IGQDsKjcKuyDURBUBz2PqgK/gvpzGoPM9zjK4nSWJIL+hN6jJasAB7nKlBRx2zHEJZLAUCIqw==
X-Received: by 2002:a05:6a21:150d:b0:1a3:da69:8eeb with SMTP id nq13-20020a056a21150d00b001a3da698eebmr4086556pzb.52.1711506981166;
        Tue, 26 Mar 2024 19:36:21 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id l20-20020a17090a409400b0029b2e5bc1b9sm347441pjg.23.2024.03.26.19.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 19:36:20 -0700 (PDT)
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
Subject: [PATCH v2 06/10] rust: alloc: introduce the `BoxExt` trait
Date: Tue, 26 Mar 2024 23:35:27 -0300
Message-Id: <20240327023531.187880-7-wedsonaf@gmail.com>
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

Make fallible versions of `new` and `new_uninit` methods available in
`Box` even though it doesn't implement them because we build `alloc`
with the `no_global_oom_handling` config.

They also have an extra `flags` parameter that allows callers to pass
flags to the allocator.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/alloc.rs           |  1 +
 rust/kernel/alloc/allocator.rs |  6 +++-
 rust/kernel/alloc/box_ext.rs   | 62 ++++++++++++++++++++++++++++++++++
 rust/kernel/init.rs            | 13 +++----
 rust/kernel/prelude.rs         |  2 +-
 rust/kernel/sync/arc.rs        |  3 +-
 6 files changed, 78 insertions(+), 9 deletions(-)
 create mode 100644 rust/kernel/alloc/box_ext.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 0502bcf00bce..a4c4b1f79bc9 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -5,6 +5,7 @@
 #[cfg(not(test))]
 #[cfg(not(testlib))]
 mod allocator;
+pub mod box_ext;
 pub mod vec_ext;
 
 /// Flags to be used when allocating memory.
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index 01ad139e19bc..fc0439455faa 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -15,7 +15,11 @@
 ///
 /// - `ptr` can be either null or a pointer which has been allocated by this allocator.
 /// - `new_layout` must have a non-zero size.
-unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: bindings::gfp_t) -> *mut u8 {
+pub(crate) unsafe fn krealloc_aligned(
+    ptr: *mut u8,
+    new_layout: Layout,
+    flags: bindings::gfp_t,
+) -> *mut u8 {
     // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
     let layout = new_layout.pad_to_align();
 
diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.rs
new file mode 100644
index 000000000000..aaa6a20d12b6
--- /dev/null
+++ b/rust/kernel/alloc/box_ext.rs
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Extensions to [`Box`] for fallible allocations.
+
+use super::Flags;
+use alloc::boxed::Box;
+use core::alloc::AllocError;
+use core::mem::MaybeUninit;
+use core::result::Result;
+
+/// Extensions to [`Box`].
+pub trait BoxExt<T>: Sized {
+    /// Allocates a new box.
+    ///
+    /// The allocation may fail, in which case an error is returned.
+    fn new(x: T, flags: Flags) -> Result<Self, AllocError>;
+
+    /// Allocates a new uninitialised box.
+    ///
+    /// The allocation may fail, in which case an error is returned.
+    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError>;
+}
+
+impl<T> BoxExt<T> for Box<T> {
+    #[cfg(any(test, testlib))]
+    fn new(x: T, _flags: Flags) -> Result<Self, AllocError> {
+        Ok(Box::new(x))
+    }
+
+    #[cfg(not(any(test, testlib)))]
+    fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
+        let ptr = if core::mem::size_of::<T>() == 0 {
+            core::ptr::NonNull::<T>::dangling().as_ptr()
+        } else {
+            let layout = core::alloc::Layout::new::<T>();
+
+            // SAFETY: Memory is being allocated (first arg is null). The only other source of
+            // safety issues is sleeping on atomic context, which is addressed by klint. Lastly,
+            // the type is not a SZT (checked above).
+            let ptr = unsafe {
+                super::allocator::krealloc_aligned(core::ptr::null_mut(), layout, flags.0)
+            };
+            if ptr.is_null() {
+                return Err(AllocError);
+            }
+
+            let ptr = ptr.cast::<T>();
+
+            // SAFETY: We just allocated the memory above, it is valid for write.
+            unsafe { ptr.write(x) };
+            ptr
+        };
+
+        // SAFETY: For non-zero-sized types, we allocate above using the global allocator. For
+        // zero-sized types, we use `NonNull::dangling`.
+        Ok(unsafe { Box::from_raw(ptr) })
+    }
+
+    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError> {
+        <Box<_> as BoxExt<_>>::new(MaybeUninit::<T>::uninit(), flags)
+    }
+}
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 424257284d16..9c798cffc8e4 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -210,6 +210,7 @@
 //! [`pin_init!`]: crate::pin_init!
 
 use crate::{
+    alloc::{box_ext::BoxExt, flags::*},
     error::{self, Error},
     sync::UniqueArc,
     types::{Opaque, ScopeGuard},
@@ -305,9 +306,9 @@ macro_rules! stack_pin_init {
 ///
 /// stack_try_pin_init!(let foo: Result<Pin<&mut Foo>, AllocError> = pin_init!(Foo {
 ///     a <- new_mutex!(42),
-///     b: Box::try_new(Bar {
+///     b: Box::new(Bar {
 ///         x: 64,
-///     })?,
+///     }, GFP_KERNEL)?,
 /// }));
 /// let foo = foo.unwrap();
 /// pr_info!("a: {}", &*foo.a.lock());
@@ -331,9 +332,9 @@ macro_rules! stack_pin_init {
 ///
 /// stack_try_pin_init!(let foo: Pin<&mut Foo> =? pin_init!(Foo {
 ///     a <- new_mutex!(42),
-///     b: Box::try_new(Bar {
+///     b: Box::new(Bar {
 ///         x: 64,
-///     })?,
+///     }, GFP_KERNEL)?,
 /// }));
 /// pr_info!("a: {}", &*foo.a.lock());
 /// # Ok::<_, AllocError>(())
@@ -1158,7 +1159,7 @@ fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
     where
         E: From<AllocError>,
     {
-        let mut this = Box::try_new_uninit()?;
+        let mut this = <Box<_> as BoxExt<_>>::new_uninit(GFP_KERNEL)?;
         let slot = this.as_mut_ptr();
         // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
         // slot is valid and will not be moved, because we pin it later.
@@ -1172,7 +1173,7 @@ fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
     where
         E: From<AllocError>,
     {
-        let mut this = Box::try_new_uninit()?;
+        let mut this = <Box<_> as BoxExt<_>>::new_uninit(GFP_KERNEL)?;
         let slot = this.as_mut_ptr();
         // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
         // slot is valid.
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 827e4dfd77df..b37a0b3180fb 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -14,7 +14,7 @@
 #[doc(no_inline)]
 pub use core::pin::Pin;
 
-pub use crate::alloc::{flags::*, vec_ext::VecExt};
+pub use crate::alloc::{box_ext::BoxExt, flags::*, vec_ext::VecExt};
 
 #[doc(no_inline)]
 pub use alloc::{boxed::Box, vec::Vec};
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 7d4c4bf58388..1252a1b630ed 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -16,6 +16,7 @@
 //! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
 
 use crate::{
+    alloc::{box_ext::BoxExt, flags::*},
     bindings,
     error::{self, Error},
     init::{self, InPlaceInit, Init, PinInit},
@@ -170,7 +171,7 @@ pub fn try_new(contents: T) -> Result<Self, AllocError> {
             data: contents,
         };
 
-        let inner = Box::try_new(value)?;
+        let inner = <Box<_> as BoxExt<_>>::new(value, GFP_KERNEL)?;
 
         // SAFETY: We just created `inner` with a reference count of 1, which is owned by the new
         // `Arc` object.
-- 
2.34.1


