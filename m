Return-Path: <linux-kernel+bounces-122292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3955688F4C9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C86D1C2C8B7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC96250E0;
	Thu, 28 Mar 2024 01:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcA7fAsM"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E3F208B0;
	Thu, 28 Mar 2024 01:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589804; cv=none; b=IuIYM8K0iIjC1dUszAWYTdvbn2Vo/AZrCmWC0PYnrc39Uxi3ZFd+y4ewc7ypOAvqAq0bD9tZD1nkGJVIOdHMOgJiggX62id5JkEk9akt1c9+Kf9pCzTRDyNGPVVjWU0yFiHf9D4i72N0prvBVPwXwbcqhGndNPwB+C9FzekRIYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589804; c=relaxed/simple;
	bh=5TzxslOk7k/ueqi1BRUMsDd4lnGNc0lj1kTXkLQn7Pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rziXanDJedQXaCqR+2HFebNxpXVVirWfcXWNysw3doeLKD+bXI1F7EYqF26GEX7/PqP5ZjLYjmE0nz0hlgSnyv+CtY9BbU5E4kQBoJB4fyO/yyLh1x4qZWBxyOE/xADNNiPpCNkl79sQ++SuxeessRfk0MABRHZCIKRYgajzVws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcA7fAsM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e034607879so4031505ad.0;
        Wed, 27 Mar 2024 18:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711589802; x=1712194602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/iHlPgZFt8p7ImeylC613n7ZZfQzJs0bp6ooy2Tu5c=;
        b=KcA7fAsMWiOrAU61y16xdyJTABvH6ZmDgyWyYZjjrxMNCpFWBzbik/L/rhMkbAU2I6
         nNnhxbSJfDX2lyQ6VP+gWRRAZ3VVkZAZjxCpGxe2LsmBKUTQ18VxIz9y3QQqApjvIp7S
         RUXlUAQBnINazRbYmfgBnihSeTtehcTVvOpiDpGY6UXXTUyhTUqpaw2IDYS2OB1cwf8X
         UN3w6laG4PLDsokX/9cIIzV/HDR8qyhsvB6xpkRdYE5JhJCF7zDtgZT1zlvMdIq7sFPU
         T6zbyg4R3kijEYCCxNV+CRgrCMVDZBkuJfuhvVeOKCtpAoP0+LKI1rSXfhPujsfjBmLD
         Z0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711589802; x=1712194602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/iHlPgZFt8p7ImeylC613n7ZZfQzJs0bp6ooy2Tu5c=;
        b=q10RwFxH/YwSBux+hgfIeV6z00ImMSg+iTcy7iN6RE7twk5m2n47JcMniwIEPkLhJo
         mRDjnbGOmTnlv+KJK6GTOlZRD5svB6t/rWyfj6uZIOkyPqb7qU0zYvImXPU6dr82fvHE
         dMTeDLSn3A4m8wKfQavu21tM4HqVgwLKimuyWO2mggoMcYUL4A8qdrhu2wTMeBiyc42U
         OodWke9oth3vkgVq9Dxn7lDeeOVN1Jq/nsJcL3Ynp/2Bd/YP2HphoYCun70LUkXDXCgr
         7Wxz1QyOdjCD1ob7zt+PlBxxHIyIQcL03p9wm+YfW/xlgugaofB7rYf0YG2jwHRVY/+I
         2BRw==
X-Forwarded-Encrypted: i=1; AJvYcCX9n5vzfam4BBBqk5NIBe3x5NjMcUzsbn5I2+RdGyW+wMeIoFYO7X0/XXYSbVIhtSbxOO/zVB+shOYQg32jD5Y3O2PQzslmD3D5eu5a
X-Gm-Message-State: AOJu0YzicQPT73PMvMJuk5vbZQEylMT/D+OJMBUefSvqEV8AqnNO5Kh2
	Nux8+bUiUr8I3XNMPfbfslJlgLyjEpePV4F5ulnnryWvdZbb8BxTAYmN32Qb
X-Google-Smtp-Source: AGHT+IG+PicSrV34Z4P/D0n0E54W9kvsdkhGclsJCJ3d1sxDxa0E4zVuAweXaigI0lF0qm/uRB7N9Q==
X-Received: by 2002:a17:902:ce8c:b0:1e0:2a19:e635 with SMTP id f12-20020a170902ce8c00b001e02a19e635mr1606042plg.9.1711589801907;
        Wed, 27 Mar 2024 18:36:41 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id p16-20020a170902e75000b001dd7a97a266sm189144plf.282.2024.03.27.18.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 18:36:41 -0700 (PDT)
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
Subject: [PATCH v3 05/10] rust: alloc: introduce allocation flags
Date: Wed, 27 Mar 2024 22:35:58 -0300
Message-Id: <20240328013603.206764-6-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328013603.206764-1-wedsonaf@gmail.com>
References: <20240328013603.206764-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

We'll use them when allocating `Box`, `Arc`, and `UniqueArc` instances,
as well as when allocating memory for `Vec` elements. These changes will
come in subsequent patches.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/bindings/bindings_helper.h |  3 ++
 rust/kernel/alloc.rs            | 61 +++++++++++++++++++++++++++++++++
 rust/kernel/alloc/allocator.rs  | 17 ++++-----
 rust/kernel/prelude.rs          |  2 +-
 4 files changed, 71 insertions(+), 12 deletions(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 65b98831b975..ddb5644d4fd9 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -20,5 +20,8 @@
 
 /* `bindgen` gets confused at certain things. */
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
+const gfp_t RUST_CONST_HELPER_GFP_ATOMIC = GFP_ATOMIC;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL = GFP_KERNEL;
+const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT = GFP_KERNEL_ACCOUNT;
+const gfp_t RUST_CONST_HELPER_GFP_NOWAIT = GFP_NOWAIT;
 const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 2c99635f9fd3..fd5541991a22 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -6,3 +6,64 @@
 #[cfg(not(testlib))]
 mod allocator;
 pub mod vec_ext;
+
+/// Flags to be used when allocating memory.
+///
+/// They can be combined with the operators `|`, `&`, and `!`.
+///
+/// Values can be used from the [`flags`] module.
+#[derive(Clone, Copy)]
+pub struct Flags(u32);
+
+impl core::ops::BitOr for Flags {
+    type Output = Self;
+    fn bitor(self, rhs: Self) -> Self::Output {
+        Self(self.0 | rhs.0)
+    }
+}
+
+impl core::ops::BitAnd for Flags {
+    type Output = Self;
+    fn bitand(self, rhs: Self) -> Self::Output {
+        Self(self.0 & rhs.0)
+    }
+}
+
+impl core::ops::Not for Flags {
+    type Output = Self;
+    fn not(self) -> Self::Output {
+        Self(!self.0)
+    }
+}
+
+/// Allocation flags.
+///
+/// These are meant to be used in functions that can allocate memory.
+pub mod flags {
+    use super::Flags;
+    use crate::bindings;
+
+    /// Zeroes out the allocated memory.
+    ///
+    /// This is normally or'd with other flags.
+    pub const __GFP_ZERO: Flags = Flags(bindings::__GFP_ZERO);
+
+    /// Users can not sleep and need the allocation to succeed.
+    ///
+    /// A lower watermark is applied to allow access to "atomic reserves". The current
+    /// implementation doesn't support NMI and few other strict non-preemptive contexts (e.g.
+    /// raw_spin_lock). The same applies to [`GFP_NOWAIT`].
+    pub const GFP_ATOMIC: Flags = Flags(bindings::GFP_ATOMIC);
+
+    /// Typical for kernel-internal allocations. The caller requires ZONE_NORMAL or a lower zone
+    /// for direct access but can direct reclaim.
+    pub const GFP_KERNEL: Flags = Flags(bindings::GFP_KERNEL);
+
+    /// The same as [`GFP_KERNEL`], except the allocation is accounted to kmemcg.
+    pub const GFP_KERNEL_ACCOUNT: Flags = Flags(bindings::GFP_KERNEL_ACCOUNT);
+
+    /// Ror kernel allocations that should not stall for direct reclaim, start physical IO or
+    /// use any filesystem callback.  It is very likely to fail to allocate memory, even for very
+    /// small allocations.
+    pub const GFP_NOWAIT: Flags = Flags(bindings::GFP_NOWAIT);
+}
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index 01ad139e19bc..8cc7099d6ae1 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -2,6 +2,7 @@
 
 //! Allocator support.
 
+use super::{flags::*, Flags};
 use core::alloc::{GlobalAlloc, Layout};
 use core::ptr;
 
@@ -15,7 +16,7 @@
 ///
 /// - `ptr` can be either null or a pointer which has been allocated by this allocator.
 /// - `new_layout` must have a non-zero size.
-unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: bindings::gfp_t) -> *mut u8 {
+unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: Flags) -> *mut u8 {
     // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
     let layout = new_layout.pad_to_align();
 
@@ -36,14 +37,14 @@ unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: bindings::gf
     //   function safety requirement.
     // - `size` is greater than 0 since it's either a `layout.size()` (which cannot be zero
     //   according to the function safety requirement) or a result from `next_power_of_two()`.
-    unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, size, flags) as *mut u8 }
+    unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, size, flags.0) as *mut u8 }
 }
 
 unsafe impl GlobalAlloc for KernelAllocator {
     unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
         // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
         // requirement.
-        unsafe { krealloc_aligned(ptr::null_mut(), layout, bindings::GFP_KERNEL) }
+        unsafe { krealloc_aligned(ptr::null_mut(), layout, GFP_KERNEL) }
     }
 
     unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
@@ -64,19 +65,13 @@ unsafe fn realloc(&self, ptr: *mut u8, layout: Layout, new_size: usize) -> *mut
         //   requirement.
         // - the size of `layout` is not zero because `new_size` is not zero by the function safety
         //   requirement.
-        unsafe { krealloc_aligned(ptr, layout, bindings::GFP_KERNEL) }
+        unsafe { krealloc_aligned(ptr, layout, GFP_KERNEL) }
     }
 
     unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
         // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
         // requirement.
-        unsafe {
-            krealloc_aligned(
-                ptr::null_mut(),
-                layout,
-                bindings::GFP_KERNEL | bindings::__GFP_ZERO,
-            )
-        }
+        unsafe { krealloc_aligned(ptr::null_mut(), layout, GFP_KERNEL | __GFP_ZERO) }
     }
 }
 
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index c85b5972c0d3..827e4dfd77df 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -14,7 +14,7 @@
 #[doc(no_inline)]
 pub use core::pin::Pin;
 
-pub use crate::alloc::vec_ext::VecExt;
+pub use crate::alloc::{flags::*, vec_ext::VecExt};
 
 #[doc(no_inline)]
 pub use alloc::{boxed::Box, vec::Vec};
-- 
2.34.1


