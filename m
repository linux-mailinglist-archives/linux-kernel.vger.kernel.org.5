Return-Path: <linux-kernel+bounces-127083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6024894683
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5B52832A2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D2956B6C;
	Mon,  1 Apr 2024 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Za6EP7nx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1E656473;
	Mon,  1 Apr 2024 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712006630; cv=none; b=KtVmXoa2zHVsOgI21or5eKdqtEVg+YKalH5qzsKVCy4UmYUE02sajloVKoRygkJCLWBEpRPEnc2R9pz51qut1NT/Sq7E/uqAZhRHHaMeiZ+Qnvj3lsfboBMorXd3ZveFVVolm+Ac41sb15hFigHdylwWPyyZ6K6RFW4PvYidjlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712006630; c=relaxed/simple;
	bh=NXcj/8dsRD58TFA744BRfD8DOeSkOsft9AfKZD+4sGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0z8RdRqNf4pKd5afWq951CpN8y9hBMBcCa4zS/15BYgNAKfA6RCFZEMp42GJzYAJX3ZWwFa3F2Olx4d9501lbnrBnmY37VnynFb+dy3My/oUzGc+C3auwPWaOiBLDOzSmJy5VCPP+NtglUEWOwveTwPj+5x8WoYPXpe+Zavkp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Za6EP7nx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5FDC433F1;
	Mon,  1 Apr 2024 21:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712006629;
	bh=NXcj/8dsRD58TFA744BRfD8DOeSkOsft9AfKZD+4sGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Za6EP7nxi04r7XYkFQQF4dfJQtHJXxhtjDA9G+GyRZvRWEQ4BpICkA3fItqoQ1rcd
	 n0W9Ojs2N19u4JGTMF0jvzawt2tiUgYm7ny5R17sP/0p13vOWOGkv5AfP6ZZ1GXGg2
	 ew5QKjFW25YQdiBIhOO2esa+HS0/7xDLkm2b6QRSJEF6Tc4KMoyxL00cr5ed5wRnDQ
	 c53GvkdhaU9b18K/jLf6H3f6/FTkpJXG0eBCPGyANnaYy5dGJSOMB0z/3o5RZ9ovEe
	 RG+SVhEQb95/4BuSFvTx6c0LHdCtdNjVZefzJi5KYE8Z5vKhuIYQ6XcnKiiiek+Mo4
	 0wRoHV15BniKg==
From: Miguel Ojeda <ojeda@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH 2/3] rust: kernel: remove redundant imports
Date: Mon,  1 Apr 2024 23:23:02 +0200
Message-ID: <20240401212303.537355-3-ojeda@kernel.org>
In-Reply-To: <20240401212303.537355-1-ojeda@kernel.org>
References: <20240401212303.537355-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rust's `unused_imports` lint covers both unused and redundant imports.
In the upcoming 1.78.0, the lint detects more cases of redundant imports
[1], e.g.:

    error: the item `bindings` is imported redundantly
      --> rust/kernel/print.rs:38:9
       |
    38 |     use crate::bindings;
       |         ^^^^^^^^^^^^^^^ the item `bindings` is already defined by prelude

Most cases are `use crate::bindings`, plus a few other items like `Box`.
Thus clean them up.

Note that, in the `bindings` case, the message "defined by prelude"
above means the extern prelude, i.e. the `--extern` flags we pass.

Link: https://github.com/rust-lang/rust/pull/117772 [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/alloc.rs              | 1 -
 rust/kernel/alloc/allocator.rs    | 2 --
 rust/kernel/alloc/box_ext.rs      | 1 -
 rust/kernel/alloc/vec_ext.rs      | 1 -
 rust/kernel/error.rs              | 1 -
 rust/kernel/net/phy.rs            | 2 +-
 rust/kernel/print.rs              | 5 -----
 rust/kernel/str.rs                | 5 +----
 rust/kernel/sync/arc.rs           | 1 -
 rust/kernel/sync/condvar.rs       | 1 -
 rust/kernel/sync/lock.rs          | 2 +-
 rust/kernel/sync/lock/mutex.rs    | 2 --
 rust/kernel/sync/lock/spinlock.rs | 2 --
 rust/kernel/task.rs               | 2 +-
 rust/kernel/workqueue.rs          | 4 +---
 15 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index f1c2c4aa22d2..531b5e471cb1 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -46,7 +46,6 @@ fn not(self) -> Self::Output {
 /// These are meant to be used in functions that can allocate memory.
 pub mod flags {
     use super::Flags;
-    use crate::bindings;
 
     /// Zeroes out the allocated memory.
     ///
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index ff88bce04fd4..229642960cd1 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -6,8 +6,6 @@
 use core::alloc::{GlobalAlloc, Layout};
 use core::ptr;
 
-use crate::bindings;
-
 struct KernelAllocator;
 
 /// Calls `krealloc` with a proper size to alloc a new object aligned to `new_layout`'s alignment.
diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.rs
index 3b48cfc70deb..2d7254219957 100644
--- a/rust/kernel/alloc/box_ext.rs
+++ b/rust/kernel/alloc/box_ext.rs
@@ -5,7 +5,6 @@
 use super::{AllocError, Flags};
 use alloc::boxed::Box;
 use core::mem::MaybeUninit;
-use core::result::Result;
 
 /// Extensions to [`Box`].
 pub trait BoxExt<T>: Sized {
diff --git a/rust/kernel/alloc/vec_ext.rs b/rust/kernel/alloc/vec_ext.rs
index 6a916fcf8bf1..25025a36e250 100644
--- a/rust/kernel/alloc/vec_ext.rs
+++ b/rust/kernel/alloc/vec_ext.rs
@@ -4,7 +4,6 @@
 
 use super::{AllocError, Flags};
 use alloc::vec::Vec;
-use core::result::Result;
 
 /// Extensions to [`Vec`].
 pub trait VecExt<T>: Sized {
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index fc986bc24c6d..55280ae9fe40 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -8,7 +8,6 @@
 
 use alloc::alloc::LayoutError;
 
-use core::convert::From;
 use core::fmt;
 use core::num::TryFromIntError;
 use core::str::Utf8Error;
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 96e09c6e8530..fba19165aa64 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -6,7 +6,7 @@
 //!
 //! C headers: [`include/linux/phy.h`](srctree/include/linux/phy.h).
 
-use crate::{bindings, error::*, prelude::*, str::CStr, types::Opaque};
+use crate::{error::*, prelude::*, types::Opaque};
 
 use core::marker::PhantomData;
 
diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
index 9b13aca832c2..a78aa3514a0a 100644
--- a/rust/kernel/print.rs
+++ b/rust/kernel/print.rs
@@ -13,9 +13,6 @@
 
 use crate::str::RawFormatter;
 
-#[cfg(CONFIG_PRINTK)]
-use crate::bindings;
-
 // Called from `vsprintf` with format specifier `%pA`.
 #[no_mangle]
 unsafe extern "C" fn rust_fmt_argument(
@@ -35,8 +32,6 @@
 /// Public but hidden since it should only be used from public macros.
 #[doc(hidden)]
 pub mod format_strings {
-    use crate::bindings;
-
     /// The length we copy from the `KERN_*` kernel prefixes.
     const LENGTH_PREFIX: usize = 2;
 
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 27641c3e4df8..bb8d4f41475b 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -7,10 +7,7 @@
 use core::fmt::{self, Write};
 use core::ops::{self, Deref, DerefMut, Index};
 
-use crate::{
-    bindings,
-    error::{code::*, Error},
-};
+use crate::error::{code::*, Error};
 
 /// Byte string without UTF-8 validity guarantee.
 #[repr(transparent)]
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index c2a3a2c7cbc5..b19645f93f16 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -17,7 +17,6 @@
 
 use crate::{
     alloc::{box_ext::BoxExt, AllocError, Flags},
-    bindings,
     error::{self, Error},
     init::{self, InPlaceInit, Init, PinInit},
     try_init,
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index ef6ffef0aa88..2b306afbe56d 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -7,7 +7,6 @@
 
 use super::{lock::Backend, lock::Guard, LockClassKey};
 use crate::{
-    bindings,
     init::PinInit,
     pin_init,
     str::CStr,
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 5b5c8efe427a..f6c34ca4d819 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -6,7 +6,7 @@
 //! spinlocks, raw spinlocks) to be provided with minimal effort.
 
 use super::LockClassKey;
-use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaque, types::ScopeGuard};
+use crate::{init::PinInit, pin_init, str::CStr, types::Opaque, types::ScopeGuard};
 use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
 use macros::pin_data;
 
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index 93e1c982facf..30632070ee67 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -4,8 +4,6 @@
 //!
 //! This module allows Rust code to use the kernel's `struct mutex`.
 
-use crate::bindings;
-
 /// Creates a [`Mutex`] initialiser with the given name and a newly-created lock class.
 ///
 /// It uses the name if one is given, otherwise it generates one based on the file name and line
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index 6e900807d3b7..ea5c5bc1ce12 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -4,8 +4,6 @@
 //!
 //! This module allows Rust code to use the kernel's `spinlock_t`.
 
-use crate::bindings;
-
 /// Creates a [`SpinLock`] initialiser with the given name and a newly-created lock class.
 ///
 /// It uses the name if one is given, otherwise it generates one based on the file name and line
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index ca6e7e31d71c..55dff7e088bf 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -4,7 +4,7 @@
 //!
 //! C header: [`include/linux/sched.h`](srctree/include/linux/sched.h).
 
-use crate::{bindings, types::Opaque};
+use crate::types::Opaque;
 use core::{
     ffi::{c_int, c_long, c_uint},
     marker::PhantomData,
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index dfbf1080ccec..403801324172 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -133,10 +133,8 @@
 //! C header: [`include/linux/workqueue.h`](srctree/include/linux/workqueue.h)
 
 use crate::alloc::{AllocError, Flags};
-use crate::{bindings, prelude::*, sync::Arc, sync::LockClassKey, types::Opaque};
-use alloc::boxed::Box;
+use crate::{prelude::*, sync::Arc, sync::LockClassKey, types::Opaque};
 use core::marker::PhantomData;
-use core::pin::Pin;
 
 /// Creates a [`Work`] initialiser with the given name and a newly-created lock class.
 #[macro_export]
-- 
2.44.0


