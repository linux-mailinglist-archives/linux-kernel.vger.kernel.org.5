Return-Path: <linux-kernel+bounces-117869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C0688B2DE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1340BE4051
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6675F3EA7B;
	Mon, 25 Mar 2024 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrX0Ykgh"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A043758AA9;
	Mon, 25 Mar 2024 19:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396530; cv=none; b=t5l7iya5Ssim9HuUQy/toggQ654LHo6x6z7B+TRZoTrxBdL/CDr6mzWyZyTXwGd7hMCifsrJBCMfxxCt+4m6nh+oyh0tB/UF8Po6PXHiYBaExDJKcYn5kz9hlcAgp9I018N1n3gw5TGutt1I1by/bMvV0iMYas5iPhL3zXvWaH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396530; c=relaxed/simple;
	bh=4IrKKSKtiozNgd98UpWJR5xewJfO+Hu/zi9nHVNZzlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FBJmsXecO+HSXLndrjMt7mk9tJKSdIUDrjxrfsNTzYJWNURx/yk8sAlpgyDTCtQJgdB25HGSPEX3B3QG+UwGs9kYwu7NGCH0HE42Us9fexFOGIwjQGDIEGS/0OzIu48dberQ2o79oeUSonczfgeIXD0cc+pK+SlR9VxRDkWhJqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrX0Ykgh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e0ae065d24so14569645ad.1;
        Mon, 25 Mar 2024 12:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711396528; x=1712001328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xj2xWepv2M8X4xt2BulvEacjlpsCTBac7QzvQX5RaT8=;
        b=lrX0Ykgh7t64RHdgsyVVyZYqqHrFUxMslP0j0GhQ0nWMQSSd8ugTA2Er4nOGgWBFrz
         gaRg1Z7GXwinf45kGOGRxhbIokchXRvfp7DoFrqPfu+X28ETlRHPGZ7bXNplkNS3D2YM
         Gyu0GLgm0VO7oGzKUPz0s3mY3QNe9BYfVuZH91tGDe8eNV+LTM1w6ae+IOInQrR7me4z
         dyoeQYJQ9T47JJJdD3NfjZT0QCtlc5nRlElmUhUWdqZ/Px7Wvn835Mi7M3ukZmAuGv43
         ZhM95w4THoTZusojC4PCHbxgwvoyVItGI4EvDkJYBqRzCS2bpowxd6UurfZ8XxMfyWY9
         3vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711396528; x=1712001328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xj2xWepv2M8X4xt2BulvEacjlpsCTBac7QzvQX5RaT8=;
        b=NquSulVJQpGqIezaAjJoc9IqsMR4TCTnAgF2N3BX7P5db0GMoy2ha4Kcx5ImSikeYb
         qgbUh/r8MF3p1Fo7Zw2IiXEJrSW4GSSX7yYCqokyQPXgatbt+LJl+LOzXqpcOCpxZ083
         XqQGNcZa4sQO+EWFdIKDfAfro7/munTSZPbr67VlBb1gAuXqnMyh71SSK8DvbPkkifmq
         xmUfjLciGCrnoWtKALDSQ7erHa165RqzjcvsrJLJxhf/fMrf3DBZy0WYZKg5C4pxgjBK
         4jLIe3gM9+E0XGAswffqtvE0CyUEKf8degzrOY3t9M3Sij3lnqOTfrYmHv46UnmH2rjB
         VL3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWY87jPYaHzmaxQiyKGk8+jBN1qjUoT5Oau6uirHTU4rWv6xQUIAequ6u3+GeXJDKjKHr+SrSzHjkmZs4kUxt/OLJtAKShUwybsrDYO
X-Gm-Message-State: AOJu0Yz97Qzzs/AyG82Pvsm80Df/Z3tThzMLHgDNXlNsEbjaejjXaIZi
	TLW1+KJVIZqokhmAV2fE/C8R/Bh/jKgOpZ4U5UupBy2JfFi0wMLlOoxn+dJC
X-Google-Smtp-Source: AGHT+IG2RZsN1L2TaPKNlpHhRz4u38sKTCwngUiUn2zhZNjUmG54rhouFw1Y6iTLZlg/zfo4UEm3bg==
X-Received: by 2002:a17:902:d489:b0:1e0:c37d:cfb5 with SMTP id c9-20020a170902d48900b001e0c37dcfb5mr3207780plg.22.1711396527942;
        Mon, 25 Mar 2024 12:55:27 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id q1-20020a170902dac100b001e06c1eee22sm5099585plx.74.2024.03.25.12.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:55:27 -0700 (PDT)
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
Subject: [PATCH 07/10] rust: alloc: update `VecExt` to take allocation flags
Date: Mon, 25 Mar 2024 16:54:15 -0300
Message-Id: <20240325195418.166013-8-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325195418.166013-1-wedsonaf@gmail.com>
References: <20240325195418.166013-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

We also rename the methods by removing the `try_` prefix since the names
are available due to our usage of the `no_global_oom_handling` config
when building the `alloc` crate.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/alloc/vecext.rs  | 106 ++++++++++++++++++++++++++++-------
 rust/kernel/lib.rs           |   1 -
 rust/kernel/str.rs           |   6 +-
 rust/kernel/types.rs         |   4 +-
 samples/rust/rust_minimal.rs |   6 +-
 5 files changed, 95 insertions(+), 28 deletions(-)

diff --git a/rust/kernel/alloc/vecext.rs b/rust/kernel/alloc/vecext.rs
index 59e92bab534e..1d4d51b45a49 100644
--- a/rust/kernel/alloc/vecext.rs
+++ b/rust/kernel/alloc/vecext.rs
@@ -2,51 +2,119 @@
 
 //! Extensions to [`Vec`] for fallible allocations.
 
-use alloc::{collections::TryReserveError, vec::Vec};
-use core::result::Result;
+use super::Flags;
+use alloc::{alloc::AllocError, vec::Vec};
+use core::{mem::ManuallyDrop, result::Result};
 
 /// Extensions to [`Vec`].
 pub trait VecExt<T>: Sized {
     /// Creates a new [`Vec`] instance with at least the given capacity.
-    fn try_with_capacity(capacity: usize) -> Result<Self, TryReserveError>;
+    fn with_capacity(capacity: usize, flags: Flags) -> Result<Self, AllocError>;
 
     /// Appends an element to the back of the [`Vec`] instance.
-    fn try_push(&mut self, v: T) -> Result<(), TryReserveError>;
+    fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError>;
 
     /// Pushes clones of the elements of slice into the [`Vec`] instance.
-    fn try_extend_from_slice(&mut self, other: &[T]) -> Result<(), TryReserveError>
+    fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Result<(), AllocError>
     where
         T: Clone;
+
+    /// Ensures that the capacity exceeds the length by at least `additional` elements.
+    fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocError>;
 }
 
 impl<T> VecExt<T> for Vec<T> {
-    fn try_with_capacity(capacity: usize) -> Result<Self, TryReserveError> {
+    fn with_capacity(capacity: usize, flags: Flags) -> Result<Self, AllocError> {
         let mut v = Vec::new();
-        v.try_reserve(capacity)?;
+        <Self as VecExt<_>>::reserve(&mut v, capacity, flags)?;
         Ok(v)
     }
 
-    fn try_push(&mut self, v: T) -> Result<(), TryReserveError> {
-        if let Err(retry) = self.push_within_capacity(v) {
-            self.try_reserve(1)?;
-            let _ = self.push_within_capacity(retry);
-        }
+    fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
+        <Self as VecExt<_>>::reserve(self, 1, flags)?;
+        let (ptr, len, cap) = destructure(self);
+        // SAFETY: ptr is valid for `cap` elements. And `cap` is greater (by at least 1) than
+        // `len` because of the call to `reserve` above. So the pointer after offsetting by `len`
+        // elements is valid for write.
+        unsafe { ptr.wrapping_add(len).write(v) };
+
+        // SAFETY: The only difference from the values returned by `destructure` is that `length`
+        // is incremented by 1, which is fine because we have just initialised the element at
+        // offset `length`.
+        unsafe { rebuild(self, ptr, len + 1, cap) };
         Ok(())
     }
 
-    fn try_extend_from_slice(&mut self, other: &[T]) -> Result<(), TryReserveError>
+    fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Result<(), AllocError>
     where
         T: Clone,
     {
-        let extra_cap = self.capacity() - self.len();
-        if extra_cap > 0 {
-            self.try_reserve(extra_cap)?;
-        }
-
+        <Self as VecExt<_>>::reserve(self, other.len(), flags)?;
         for item in other {
-            self.try_push(item.clone())?;
+            <Self as VecExt<_>>::push(self, item.clone(), flags)?;
         }
+        Ok(())
+    }
 
+    #[cfg(any(test, testlib))]
+    fn reserve(&mut self, additional: usize, _flags: Flags) -> Result<(), AllocError> {
+        Vec::reserve(self, additional);
         Ok(())
     }
+
+    #[cfg(not(any(test, testlib)))]
+    fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocError> {
+        let len = self.len();
+        let cap = self.capacity();
+
+        if cap - len >= additional {
+            return Ok(());
+        }
+
+        if core::mem::size_of::<T>() == 0 {
+            // The capacity is already `usize::MAX` for SZTs, we can't go higher.
+            return Err(AllocError);
+        }
+
+        // We know cap is <= `isize::MAX` because `Layout::array` fails if the resulting byte size
+        // is greater than `isize::MAX`. So the multiplication by two won't overflow.
+        let new_cap = core::cmp::max(cap * 2, len.checked_add(additional).ok_or(AllocError)?);
+        let layout = core::alloc::Layout::array::<T>(new_cap).map_err(|_| AllocError)?;
+
+        let (ptr, len, cap) = destructure(self);
+
+        // SAFETY: `ptr` is valid because it's either NULL or comes from a previous call to
+        // `krealloc_aligned`. We also verified that the type is not a ZST.
+        let new_ptr = unsafe { super::allocator::krealloc_aligned(ptr.cast(), layout, flags.0) };
+        if new_ptr.is_null() {
+            // SAFETY: We are just rebuilding the existing `Vec` with no changes.
+            unsafe { rebuild(self, ptr, len, cap) };
+            Err(AllocError)
+        } else {
+            // SAFETY: `ptr` has been reallocated with the layout for `new_cap` elements. New cap
+            // is greater than `cap`, so it continues to be >= `len`.
+            unsafe { rebuild(self, new_ptr.cast::<T>(), len, new_cap) };
+            Ok(())
+        }
+    }
+}
+
+fn destructure<T>(v: &mut Vec<T>) -> (*mut T, usize, usize) {
+    let mut tmp = Vec::new();
+    core::mem::swap(&mut tmp, v);
+    let mut tmp = ManuallyDrop::new(tmp);
+    let len = tmp.len();
+    let cap = tmp.capacity();
+    (tmp.as_mut_ptr(), len, cap)
+}
+
+/// Rebuilds a `Vec` from a pointer, length, and capacity.
+///
+/// # Safety
+///
+/// The same as [`Vec::from_raw_parts`].
+unsafe fn rebuild<T>(v: &mut Vec<T>, ptr: *mut T, len: usize, cap: usize) {
+    // SAFETY: The safety requirements from this function satisfy those of `from_raw_parts`.
+    let mut tmp = unsafe { Vec::from_raw_parts(ptr, len, cap) };
+    core::mem::swap(&mut tmp, v);
 }
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 7f2841a18d05..51f30e55bd00 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -19,7 +19,6 @@
 #![feature(offset_of)]
 #![feature(receiver_trait)]
 #![feature(unsize)]
-#![feature(vec_push_within_capacity)]
 
 // Ensure conditional compilation based on the kernel configuration works;
 // otherwise we may silently break things like initcall handling.
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 183748328d43..34dbc85b5220 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -2,7 +2,7 @@
 
 //! String representations.
 
-use crate::alloc::vecext::VecExt;
+use crate::alloc::{flags::*, vecext::VecExt};
 use alloc::alloc::AllocError;
 use alloc::vec::Vec;
 use core::fmt::{self, Write};
@@ -730,7 +730,7 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
         let size = f.bytes_written();
 
         // Allocate a vector with the required number of bytes, and write to it.
-        let mut buf = Vec::try_with_capacity(size)?;
+        let mut buf = <Vec<_> as VecExt<_>>::with_capacity(size, GFP_KERNEL)?;
         // SAFETY: The buffer stored in `buf` is at least of size `size` and is valid for writes.
         let mut f = unsafe { Formatter::from_buffer(buf.as_mut_ptr(), size) };
         f.write_fmt(args)?;
@@ -771,7 +771,7 @@ impl<'a> TryFrom<&'a CStr> for CString {
     fn try_from(cstr: &'a CStr) -> Result<CString, AllocError> {
         let mut buf = Vec::new();
 
-        buf.try_extend_from_slice(cstr.as_bytes_with_nul())
+        <Vec<_> as VecExt<_>>::extend_from_slice(&mut buf, cstr.as_bytes_with_nul(), GFP_KERNEL)
             .map_err(|_| AllocError)?;
 
         // INVARIANT: The `CStr` and `CString` types have the same invariants for
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index aa77bad9bce4..8fad61268465 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -157,11 +157,11 @@ unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
 ///     let mut vec =
 ///         ScopeGuard::new_with_data(Vec::new(), |v| pr_info!("vec had {} elements\n", v.len()));
 ///
-///     vec.try_push(10u8)?;
+///     vec.push(10u8, GFP_KERNEL)?;
 ///     if arg {
 ///         return Ok(());
 ///     }
-///     vec.try_push(20u8)?;
+///     vec.push(20u8, GFP_KERNEL)?;
 ///     Ok(())
 /// }
 ///
diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
index dc05f4bbe27e..2a9eaab62d1c 100644
--- a/samples/rust/rust_minimal.rs
+++ b/samples/rust/rust_minimal.rs
@@ -22,9 +22,9 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
         pr_info!("Am I built-in? {}\n", !cfg!(MODULE));
 
         let mut numbers = Vec::new();
-        numbers.try_push(72)?;
-        numbers.try_push(108)?;
-        numbers.try_push(200)?;
+        numbers.push(72, GFP_KERNEL)?;
+        numbers.push(108, GFP_KERNEL)?;
+        numbers.push(200, GFP_KERNEL)?;
 
         Ok(RustMinimal { numbers })
     }
-- 
2.34.1


