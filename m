Return-Path: <linux-kernel+bounces-144649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3358A48C9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2571C215C6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25BE374F9;
	Mon, 15 Apr 2024 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CIaPXdzu"
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D534545
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165270; cv=none; b=KuZWeoq2LJXmyj1M2WaCQ8ZGqlkvOQxckUIMytZS4PCFPl+5CPuAcZFepnu+4GXTbfmfC09nmgsV+bQffsn4h6i9858wWthIRGxPUoaOxlgB2/D0gvVrBAavo5vkO8P4Of8r7k31fr2GmJNZdWYAKpncMG8vcbwFyOobLv4YPAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165270; c=relaxed/simple;
	bh=8G034x9QLKwhszhfSOV4sRo/vOkKD0+Y6xZHnepJVr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M2tlmtWn9g+gBB5D09dYNJ2fGwP/y8jSeMjcK2ptc6WUjLut+j7nbFtFB/XNr+xdX8dzic5HodZAd8XDz0k/NTB6eW1Wg8XddN0W2zHLmt4EUnu/Zo2LShrYLpnrC7LQvBurHKDQ6gIHuljIjn+tq2EhiaDgEjBAzbpth6Ej5Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CIaPXdzu; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-2d87f4226b3so19600401fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 00:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713165266; x=1713770066; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dQnBVtrhJpUgOHcm+nS3apY4eRmi29T+h46zYZ5XaoI=;
        b=CIaPXdzum6Ug5WSFn0YPamfKgmQE8jn+upw/FR6S+BKnfPNIQXk46BQZp1e+IGHwSe
         gjBaBQX1TyJSnz8o/43GvOeY5T1qdhOstd8MVwS8dEk4K7a3M6CfY7OveR7ZAUuLri2P
         uPUY2ahGNhMYfL9qIkFTfUd60CHRL/tXkBpyIE/JioLqKkhaqPNcNXUg2GibZZHZvhY0
         mrnCNqIsqymEkDMzxNA5mdEN6uNWQMEG8kwz0U3oCxKSTHHWlfVc4CZBfOS60K+bN6fo
         7LkXa+fTXPHSpCoEDxNhgSC60ucgqZ/wOyM+EzP+lQizasAgvAzPK44ghTR6PgafTVXA
         NdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713165266; x=1713770066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQnBVtrhJpUgOHcm+nS3apY4eRmi29T+h46zYZ5XaoI=;
        b=bRlloaTR8RSkzLzt8tOJ6gYpdOmR+XJWPdyiClvvHeg3TkEBlGxvkcK1kDHo0NngYC
         xU9OY/Bd4Qk5QtV7pXcwC8ClOspsBsVXDEpTuQWrP+JsoMS196bk5Qka5iHVrQOm1+zW
         vRfbmPeTSXDC3Lk7qcft25Tmrd9+d8V44q/VTRqI0cBBmplFt4ZX10ar92E6icsAKXCE
         aADBu5hosLBbutIqW3OWX/77fo44K/Lj1mBstCmnJ4nsrylTf0kM3fBlWjbyBEZ6vpP/
         yiUUZEp/qy93UNDtWxLVIQxNqUT+DIw5NwzLyT5HlKoYbuVtE1NT3pXDFv7UrHEiD5F8
         14aA==
X-Forwarded-Encrypted: i=1; AJvYcCUyB6iU3pgqwmumPJE40VKUQY1VRtJJq455dEbJJT0x7xZ6mqm/QYP/gXOPGZzczgSv1bY5KvSJx8SwWiCRe5pCpIymgGquSfAhVHLV
X-Gm-Message-State: AOJu0Yy288AeODmHW1GNTPwiCIEDWCL+Lhvot3C3IilltUre8h0DuMEs
	XGk88emlgBNh/25lZASpKfO8u4gS94yTyttvYk0tpaCniYe1Hpt8T0RoEtrsehTQIp1zLTiUm2j
	HxRHLuIntr/YjSg==
X-Google-Smtp-Source: AGHT+IGj4s5XcuUlnHXAqbbbB0vr64kBb3ewtMkKntnALdO/9Wx+FqLH+bIRcaQ7/jFxocSOccqLI8Do0Wig5+w=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:2c8c:b0:518:c9cc:f169 with SMTP
 id dw12-20020a0565122c8c00b00518c9ccf169mr2703lfb.9.1713165266687; Mon, 15
 Apr 2024 00:14:26 -0700 (PDT)
Date: Mon, 15 Apr 2024 07:13:56 +0000
In-Reply-To: <20240415-alice-mm-v5-0-6f55e4d8ef51@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415-alice-mm-v5-0-6f55e4d8ef51@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=15423; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=8G034x9QLKwhszhfSOV4sRo/vOkKD0+Y6xZHnepJVr8=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmHNPDsrivyGBAl1qNxYjiDLbuOvR9BBC9GJHRV
 SrTL5tsTTKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZhzTwwAKCRAEWL7uWMY5
 RgbyEAC8Hby5pqtDLGHCfFHFUfA2ZVFgjQRHb7wotVVMNsB+JBI+okpEmkq1hVQ9IKfIqJhp3M4
 1x4USMZMPWhgRqW5axodDBKLmyTHx25xMXZzs30QZWBlAzdQoTDCd7/kg2ifWL65XKzq/zwCa23
 URd08TKx9DxT4rrtzz351hEQiGHMqHAdv90PkVjpi2WciRbuJhezN1chFIQBfHaA3wjc9wOkCvP
 TnUiM0yfI8FtWa45XFjHzIFXfb8Ol+m+HlQaBRs5pLrnceju1Fx6gK3yTLZcEE4vYBDaN60EsZJ
 IgPy9KcygbA9eD+qC/62oP+6+fjRUcWsaJWbxXiW+4j143NnHBMVuABzAJjv2plFjG9cLXF9H+L
 7o7TJv8jRtFy9pJ3PMDk1sIv8P5az9x1ZLvopcCb42By5FyIOTVONzU/lP+7VN/rNGaRRm3dyij
 0p9KtomDU9I4AvMG+RVOKpcGCEr4vraHoXjKqvu+VMwIj8q9ZCkdP+2HHZOHKWBnoWeZYItXExR
 mk195VQK4ICe14p7mz9yVNkC6CJ9ddk0OU2HXugUrBS3Rvr9td5Vf+mtdRua8sptmOq4/nta/uC
 NyXMM2Kwvtz76AFraOwujbgfAsmlAYAcIVsoAYy9n5oI6mef2PQIQ15or4w89JHnLrBMygqRoCP nSz+HTDGgKd+Ndw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240415-alice-mm-v5-4-6f55e4d8ef51@google.com>
Subject: [PATCH v5 4/4] rust: add abstraction for `struct page`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"

Adds a new struct called `Page` that wraps a pointer to `struct page`.
This struct is assumed to hold ownership over the page, so that Rust
code can allocate and manage pages directly.

The page type has various methods for reading and writing into the page.
These methods will temporarily map the page to allow the operation. All
of these methods use a helper that takes an offset and length, performs
bounds checks, and returns a pointer to the given offset in the page.

This patch only adds support for pages of order zero, as that is all
Rust Binder needs. However, it is written to make it easy to add support
for higher-order pages in the future. To do that, you would add a const
generic parameter to `Page` that specifies the order. Most of the
methods do not need to be adjusted, as the logic for dealing with
mapping multiple pages at once can be isolated to just the
`with_pointer_into_page` method.

Rust Binder needs to manage pages directly as that is how transactions
are delivered: Each process has an mmap'd region for incoming
transactions. When an incoming transaction arrives, the Binder driver
will choose a region in the mmap, allocate and map the relevant pages
manually, and copy the incoming transaction directly into the page. This
architecture allows the driver to copy transactions directly from the
address space of one process to another, without an intermediate copy
to a kernel buffer.

This code is based on Wedson's page abstractions from the old rust
branch, but it has been modified by Alice by removing the incomplete
support for higher-order pages, by introducing the `with_*` helpers
to consolidate the bounds checking logic into a single place, and by
introducing gfp flags.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |   2 +
 rust/helpers.c                  |  20 ++++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/page.rs             | 240 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 263 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 65b98831b975..da1e97871419 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -20,5 +20,7 @@
 
 /* `bindgen` gets confused at certain things. */
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
+const size_t RUST_CONST_HELPER_PAGE_SIZE = PAGE_SIZE;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL = GFP_KERNEL;
 const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
+const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM = ___GFP_HIGHMEM;
diff --git a/rust/helpers.c b/rust/helpers.c
index 312b6fcb49d5..72361003ba91 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -25,6 +25,8 @@
 #include <linux/build_bug.h>
 #include <linux/err.h>
 #include <linux/errname.h>
+#include <linux/gfp.h>
+#include <linux/highmem.h>
 #include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <linux/sched/signal.h>
@@ -93,6 +95,24 @@ int rust_helper_signal_pending(struct task_struct *t)
 }
 EXPORT_SYMBOL_GPL(rust_helper_signal_pending);
 
+struct page *rust_helper_alloc_pages(gfp_t gfp_mask, unsigned int order)
+{
+	return alloc_pages(gfp_mask, order);
+}
+EXPORT_SYMBOL_GPL(rust_helper_alloc_pages);
+
+void *rust_helper_kmap_local_page(struct page *page)
+{
+	return kmap_local_page(page);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kmap_local_page);
+
+void rust_helper_kunmap_local(const void *addr)
+{
+	kunmap_local(addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kunmap_local);
+
 refcount_t rust_helper_REFCOUNT_INIT(int n)
 {
 	return (refcount_t)REFCOUNT_INIT(n);
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 37f84223b83f..667fc67fa24f 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -39,6 +39,7 @@
 pub mod kunit;
 #[cfg(CONFIG_NET)]
 pub mod net;
+pub mod page;
 pub mod prelude;
 pub mod print;
 mod static_assert;
diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
new file mode 100644
index 000000000000..f7f8870ddb66
--- /dev/null
+++ b/rust/kernel/page.rs
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Kernel page allocation and management.
+
+use crate::{bindings, error::code::*, error::Result, uaccess::UserSliceReader};
+use core::{
+    alloc::AllocError,
+    ptr::{self, NonNull},
+};
+
+/// A bitwise shift for the page size.
+pub const PAGE_SHIFT: usize = bindings::PAGE_SHIFT as usize;
+
+/// The number of bytes in a page.
+pub const PAGE_SIZE: usize = bindings::PAGE_SIZE;
+
+/// A bitmask that gives the page containing a given address.
+pub const PAGE_MASK: usize = !(PAGE_SIZE - 1);
+
+/// Flags for the "get free page" function that underlies all memory allocations.
+pub mod flags {
+    /// gfp flags.
+    #[allow(non_camel_case_types)]
+    pub type gfp_t = bindings::gfp_t;
+
+    /// `GFP_KERNEL` is typical for kernel-internal allocations. The caller requires `ZONE_NORMAL`
+    /// or a lower zone for direct access but can direct reclaim.
+    pub const GFP_KERNEL: gfp_t = bindings::GFP_KERNEL;
+    /// `GFP_ZERO` returns a zeroed page on success.
+    pub const __GFP_ZERO: gfp_t = bindings::__GFP_ZERO;
+    /// `GFP_HIGHMEM` indicates that the allocated memory may be located in high memory.
+    pub const __GFP_HIGHMEM: gfp_t = bindings::__GFP_HIGHMEM;
+}
+
+/// A pointer to a page that owns the page allocation.
+///
+/// # Invariants
+///
+/// The pointer is valid, and has ownership over the page.
+pub struct Page {
+    page: NonNull<bindings::page>,
+}
+
+// SAFETY: Pages have no logic that relies on them staying on a given thread, so moving them across
+// threads is safe.
+unsafe impl Send for Page {}
+
+// SAFETY: Pages have no logic that relies on them not being accessed concurrently, so accessing
+// them concurrently is safe.
+unsafe impl Sync for Page {}
+
+impl Page {
+    /// Allocates a new page.
+    pub fn alloc_page(gfp_flags: flags::gfp_t) -> Result<Self, AllocError> {
+        // SAFETY: Depending on the value of `gfp_flags`, this call may sleep. Other than that, it
+        // is always safe to call this method.
+        let page = unsafe { bindings::alloc_pages(gfp_flags, 0) };
+        let page = NonNull::new(page).ok_or(AllocError)?;
+        // INVARIANT: We just successfully allocated a page, so we now have ownership of the newly
+        // allocated page. We transfer that ownership to the new `Page` object.
+        Ok(Self { page })
+    }
+
+    /// Returns a raw pointer to the page.
+    pub fn as_ptr(&self) -> *mut bindings::page {
+        self.page.as_ptr()
+    }
+
+    /// Runs a piece of code with this page mapped to an address.
+    ///
+    /// The page is unmapped when this call returns.
+    ///
+    /// # Using the raw pointer
+    ///
+    /// It is up to the caller to use the provided raw pointer correctly. The pointer is valid for
+    /// `PAGE_SIZE` bytes and for the duration in which the closure is called. The pointer might
+    /// only be mapped on the current thread, and when that is the case, dereferencing it on other
+    /// threads is UB. Other than that, the usual rules for dereferencing a raw pointer apply: don't
+    /// cause data races, the memory may be uninitialized, and so on.
+    ///
+    /// If multiple threads map the same page at the same time, then they may reference with
+    /// different addresses. However, even if the addresses are different, the underlying memory is
+    /// still the same for these purposes (e.g., it's still a data race if they both write to the
+    /// same underlying byte at the same time).
+    fn with_page_mapped<T>(&self, f: impl FnOnce(*mut u8) -> T) -> T {
+        // SAFETY: `page` is valid due to the type invariants on `Page`.
+        let mapped_addr = unsafe { bindings::kmap_local_page(self.as_ptr()) };
+
+        let res = f(mapped_addr.cast());
+
+        // This unmaps the page mapped above.
+        //
+        // SAFETY: Since this API takes the user code as a closure, it can only be used in a manner
+        // where the pages are unmapped in reverse order. This is as required by `kunmap_local`.
+        //
+        // In other words, if this call to `kunmap_local` happens when a different page should be
+        // unmapped first, then there must necessarily be a call to `kmap_local_page` other than the
+        // call just above in `with_page_mapped` that made that possible. In this case, it is the
+        // unsafe block that wraps that other call that is incorrect.
+        unsafe { bindings::kunmap_local(mapped_addr) };
+
+        res
+    }
+
+    /// Runs a piece of code with a raw pointer to a slice of this page, with bounds checking.
+    ///
+    /// If `f` is called, then it will be called with a pointer that points at `off` bytes into the
+    /// page, and the pointer will be valid for at least `len` bytes. The pointer is only valid on
+    /// this task, as this method uses a local mapping.
+    ///
+    /// If `off` and `len` refers to a region outside of this page, then this method returns
+    /// `EINVAL` and does not call `f`.
+    ///
+    /// # Using the raw pointer
+    ///
+    /// It is up to the caller to use the provided raw pointer correctly. The pointer is valid for
+    /// `len` bytes and for the duration in which the closure is called. The pointer might only be
+    /// mapped on the current thread, and when that is the case, dereferencing it on other threads
+    /// is UB. Other than that, the usual rules for dereferencing a raw pointer apply: don't cause
+    /// data races, the memory may be uninitialized, and so on.
+    ///
+    /// If multiple threads map the same page at the same time, then they may reference with
+    /// different addresses. However, even if the addresses are different, the underlying memory is
+    /// still the same for these purposes (e.g., it's still a data race if they both write to the
+    /// same underlying byte at the same time).
+    fn with_pointer_into_page<T>(
+        &self,
+        off: usize,
+        len: usize,
+        f: impl FnOnce(*mut u8) -> Result<T>,
+    ) -> Result<T> {
+        let bounds_ok = off <= PAGE_SIZE && len <= PAGE_SIZE && (off + len) <= PAGE_SIZE;
+
+        if bounds_ok {
+            self.with_page_mapped(move |page_addr| {
+                // SAFETY: The `off` integer is at most `PAGE_SIZE`, so this pointer offset will
+                // result in a pointer that is in bounds or one off the end of the page.
+                f(unsafe { page_addr.add(off) })
+            })
+        } else {
+            Err(EINVAL)
+        }
+    }
+
+    /// Maps the page and reads from it into the given buffer.
+    ///
+    /// This method will perform bounds checks on the page offset. If `offset .. offset+len` goes
+    /// outside ot the page, then this call returns `EINVAL`.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that `dst` is valid for writing `len` bytes.
+    /// * Callers must ensure that this call does not race with a write to the same page that
+    ///   overlaps with this read.
+    pub unsafe fn read_raw(&self, dst: *mut u8, offset: usize, len: usize) -> Result {
+        self.with_pointer_into_page(offset, len, move |src| {
+            // SAFETY: If `with_pointer_into_page` calls into this closure, then
+            // it has performed a bounds check and guarantees that `src` is
+            // valid for `len` bytes.
+            //
+            // There caller guarantees that there is no data race.
+            unsafe { ptr::copy_nonoverlapping(src, dst, len) };
+            Ok(())
+        })
+    }
+
+    /// Maps the page and writes into it from the given buffer.
+    ///
+    /// This method will perform bounds checks on the page offset. If `offset .. offset+len` goes
+    /// outside ot the page, then this call returns `EINVAL`.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that `src` is valid for reading `len` bytes.
+    /// * Callers must ensure that this call does not race with a read or write to the same page
+    ///   that overlaps with this write.
+    pub unsafe fn write_raw(&self, src: *const u8, offset: usize, len: usize) -> Result {
+        self.with_pointer_into_page(offset, len, move |dst| {
+            // SAFETY: If `with_pointer_into_page` calls into this closure, then it has performed a
+            // bounds check and guarantees that `dst` is valid for `len` bytes.
+            //
+            // There caller guarantees that there is no data race.
+            unsafe { ptr::copy_nonoverlapping(src, dst, len) };
+            Ok(())
+        })
+    }
+
+    /// Maps the page and zeroes the given slice.
+    ///
+    /// This method will perform bounds checks on the page offset. If `offset .. offset+len` goes
+    /// outside ot the page, then this call returns `EINVAL`.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that this call does not race with a read or write to the same page that
+    /// overlaps with this write.
+    pub unsafe fn fill_zero(&self, offset: usize, len: usize) -> Result {
+        self.with_pointer_into_page(offset, len, move |dst| {
+            // SAFETY: If `with_pointer_into_page` calls into this closure, then it has performed a
+            // bounds check and guarantees that `dst` is valid for `len` bytes.
+            //
+            // There caller guarantees that there is no data race.
+            unsafe { ptr::write_bytes(dst, 0u8, len) };
+            Ok(())
+        })
+    }
+
+    /// Copies data from userspace into this page.
+    ///
+    /// This method will perform bounds checks on the page offset. If `offset .. offset+len` goes
+    /// outside ot the page, then this call returns `EINVAL`.
+    ///
+    /// Like the other `UserSliceReader` methods, data races are allowed on the userspace address.
+    /// However, they are not allowed on the page you are copying into.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that this call does not race with a read or write to the same page that
+    /// overlaps with this write.
+    pub unsafe fn copy_from_user_slice(
+        &self,
+        reader: &mut UserSliceReader,
+        offset: usize,
+        len: usize,
+    ) -> Result {
+        self.with_pointer_into_page(offset, len, move |dst| {
+            // SAFETY: If `with_pointer_into_page` calls into this closure, then it has performed a
+            // bounds check and guarantees that `dst` is valid for `len` bytes. Furthermore, we have
+            // exclusive access to the slice since the caller guarantees that there are no races.
+            reader.read_raw(unsafe { core::slice::from_raw_parts_mut(dst.cast(), len) })
+        })
+    }
+}
+
+impl Drop for Page {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we have ownership of the page and can free it.
+        unsafe { bindings::__free_pages(self.page.as_ptr(), 0) };
+    }
+}

-- 
2.44.0.683.g7961c838ac-goog


