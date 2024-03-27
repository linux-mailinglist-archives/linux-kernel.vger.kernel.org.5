Return-Path: <linux-kernel+bounces-120229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2694B88D49D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9442E896B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C427028DA5;
	Wed, 27 Mar 2024 02:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkODSVOr"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F5D25630;
	Wed, 27 Mar 2024 02:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711506987; cv=none; b=UlkpLzcJjMQSgwqbiWYMKMGwTQOMlyS20gRC9a0mGEQKheaaVrf7uMBUwUpTyEcZeCCqDU6rgxDBMPONEefXGBMySZeTEv+AYqJ72jAPQFR2+NlLXCmVYuk+s2bQLK2hApH9PbbGIlzvYr5DnCEn8mDodDTrPFMXxVIKcT056Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711506987; c=relaxed/simple;
	bh=0M4ppCPUwtz16eZhrPWe5yLXkPkDNAmVPGzlAvCJotc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QueHWrnoYodzyzI6/LbXztiherOtbZW/VRv8owDo8klrpsM4sq73R/+5MOzJJ2UcARA513V2tJnqh9bTg2MdNyRfVgigpJfGdox/PxSh0jRhcK2pAjZrGwiF61LJZn8tND8eRihSVq2Da+nDfjCfONR0erV8FdgQOdTz2bpxF/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkODSVOr; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso4539691a12.3;
        Tue, 26 Mar 2024 19:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711506985; x=1712111785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=435GQ6m0tr/HQyJUi6qsfFFlxdcC37v/LHKOTsBj2jE=;
        b=RkODSVOrevQ0uXedak9b6MZGEwEbNrLTMme03Gi0V9cWpRbxe2XNM9OTatgn6ok7gH
         4QwSL8cmYMoUESMtagPf0tdcFxLSnxarrRlxdvHIaz5bSs/wO+MdzfFBNj804keo/2iZ
         MMAsEtDyW7emrc5e99sB3dpY5bj5dvBvxvFwQn3HfmzZaC4DJuWeUw3D14aBbJmbKFsS
         AraGAofL6Y6QvVR63YY7nGUE1XdGRAqtmxLpUHyvo6ZmY8WscXSPhCXpEkRedUTs1GOz
         Q6K0lL48ffealAyCpkIKfts6La5p5SvpBUeImQUQrNbzFe5yIY0NfsYlmusE3H+iFmJb
         cEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711506985; x=1712111785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=435GQ6m0tr/HQyJUi6qsfFFlxdcC37v/LHKOTsBj2jE=;
        b=mXM80I4RqyH/dayYBOaJTMlFNEOjV4UNzr4FZm/YCnKYDIYcDU4ddfS9xv4QuBnxqs
         4Btyzk707T/1vbn5LyP53AWPsWat1EY1Vzo+CAMwNqb/OHsCjm1/JHCL4x2IC6Lyv6+y
         xHf6jWzjyc0abdjd/qSokN4n3MN6ihyKho+nSDEt4Da4zVGWMbVszjSSFJnEa3aWruRX
         vhcWREJai6UsO5ccwhR0wq6YxXUNuwdI+Zm3eNPJUW6jc07UeDM0ogb9NezdrrZyH6uB
         Q7XR0+xpTt/PXPWjryxyRd8ZUNKcTX/YSDRe0Tnif+WxrjYD6SPO+LflRYFZzhLFy+JN
         c7CA==
X-Forwarded-Encrypted: i=1; AJvYcCUAb3SEEEZD9+epVbjABbVEUYZGk49zDelkAQXlfdm9HYU8pJHSMXh+8PrgwfKsHOPI2uRQSdObbCteOjAQTAPjLFFyckj5XlhDin/s
X-Gm-Message-State: AOJu0YzXFfBDDX/PSdRU/YS2gjJVIppCMKr++BujscISn8xGQYZvollz
	ZFoI1W50fGfIn4dh2CYw1xg0esFqNb2cwvjNVfkmpGZBwWqxxVYMCUhlpicK
X-Google-Smtp-Source: AGHT+IHlC7IN/HbcRU25f86+8d45EQJIX5I1ESqZbfxED600vb9obrVZgJnJnGZSsHhx9/RzwYolQw==
X-Received: by 2002:a05:6a21:33a0:b0:1a3:c3d9:fd15 with SMTP id yy32-20020a056a2133a000b001a3c3d9fd15mr3312675pzb.38.1711506985130;
        Tue, 26 Mar 2024 19:36:25 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id l20-20020a17090a409400b0029b2e5bc1b9sm347441pjg.23.2024.03.26.19.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 19:36:24 -0700 (PDT)
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
Subject: [PATCH v2 07/10] rust: alloc: update `VecExt` to take allocation flags
Date: Tue, 26 Mar 2024 23:35:28 -0300
Message-Id: <20240327023531.187880-8-wedsonaf@gmail.com>
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

We also rename the methods by removing the `try_` prefix since the names
are available due to our usage of the `no_global_oom_handling` config
when building the `alloc` crate.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/alloc/vec_ext.rs | 106 ++++++++++++++++++++++++++++++-----
 rust/kernel/error.rs         |  11 +---
 rust/kernel/lib.rs           |   1 -
 rust/kernel/str.rs           |   6 +-
 rust/kernel/types.rs         |   4 +-
 samples/rust/rust_minimal.rs |   6 +-
 6 files changed, 100 insertions(+), 34 deletions(-)

diff --git a/rust/kernel/alloc/vec_ext.rs b/rust/kernel/alloc/vec_ext.rs
index 311e62cc5784..bb6cb1c4ea67 100644
--- a/rust/kernel/alloc/vec_ext.rs
+++ b/rust/kernel/alloc/vec_ext.rs
@@ -2,47 +2,123 @@
 
 //! Extensions to [`Vec`] for fallible allocations.
 
-use alloc::{collections::TryReserveError, vec::Vec};
+use super::Flags;
+use alloc::{alloc::AllocError, vec::Vec};
 use core::result::Result;
 
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
+        let s = self.spare_capacity_mut();
+        s[0].write(v);
+
+        // SAFETY: We just initialised the first spare entry, so it is safe to increase the length
+        // by 1. We also know that the new length is <= capacity because of the previous call to
+        // `reserve` above.
+        unsafe { self.set_len(self.len() + 1) };
         Ok(())
     }
 
-    fn try_extend_from_slice(&mut self, other: &[T]) -> Result<(), TryReserveError>
+    fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Result<(), AllocError>
     where
         T: Clone,
     {
-        self.try_reserve(other.len())?;
-        for item in other {
-            self.try_push(item.clone())?;
+        <Self as VecExt<_>>::reserve(self, other.len(), flags)?;
+        for (slot, item) in core::iter::zip(self.spare_capacity_mut(), other) {
+            slot.write(item.clone());
         }
 
+        // SAFETY: We just initialised the `other.len()` spare entries, so it is safe to increase
+        // the length by the same amount. We also know that the new length is <= capacity because
+        // of the previous call to `reserve` above.
+        unsafe { self.set_len(self.len() + 1) };
+        Ok(())
+    }
+
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
+#[cfg(not(any(test, testlib)))]
+fn destructure<T>(v: &mut Vec<T>) -> (*mut T, usize, usize) {
+    let mut tmp = Vec::new();
+    core::mem::swap(&mut tmp, v);
+    let mut tmp = core::mem::ManuallyDrop::new(tmp);
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
+#[cfg(not(any(test, testlib)))]
+unsafe fn rebuild<T>(v: &mut Vec<T>, ptr: *mut T, len: usize, cap: usize) {
+    // SAFETY: The safety requirements from this function satisfy those of `from_raw_parts`.
+    let mut tmp = unsafe { Vec::from_raw_parts(ptr, len, cap) };
+    core::mem::swap(&mut tmp, v);
 }
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 4786d3ee1e92..e53466937796 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -6,10 +6,7 @@
 
 use crate::str::CStr;
 
-use alloc::{
-    alloc::{AllocError, LayoutError},
-    collections::TryReserveError,
-};
+use alloc::alloc::{AllocError, LayoutError};
 
 use core::convert::From;
 use core::fmt;
@@ -192,12 +189,6 @@ fn from(_: Utf8Error) -> Error {
     }
 }
 
-impl From<TryReserveError> for Error {
-    fn from(_: TryReserveError) -> Error {
-        code::ENOMEM
-    }
-}
-
 impl From<LayoutError> for Error {
     fn from(_: LayoutError) -> Error {
         code::ENOMEM
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
index e1be6c5e72a9..58f2ddafb326 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -2,7 +2,7 @@
 
 //! String representations.
 
-use crate::alloc::vec_ext::VecExt;
+use crate::alloc::{flags::*, vec_ext::VecExt};
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


