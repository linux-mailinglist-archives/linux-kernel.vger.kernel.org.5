Return-Path: <linux-kernel+bounces-36849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AC083A7AA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FCE01F298C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978714F218;
	Wed, 24 Jan 2024 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aDyd8QDr"
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657BB3D3AE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095258; cv=none; b=PHY3/IK7sLTVxm2OEg3jMG7SWfaRgPxgm0B94KzOEXC80qq+62DDDrYXnQEEnj9dyPfAz8+/EFrjXtZRoZ4i2Ugdj9wtnYJUw5jF/X+ypM4qk/mfbASGg9zRnk7hsVfzyczI3/91z3VSBT+CcwsFYy2VQ8SS0zmOOH4V0UY2544=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095258; c=relaxed/simple;
	bh=N81WtFNSKMRQnbGYXHdbc93PTVhG91qfzypfB7FfqFo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dVAvJ90km0kUtEKvCxFzQgH1eWyOC4S1uZ2Z05y4SkTJJlzgF2AMmsZ1K4LQSg7dj1Z63XEqF76S8vCqivHt6lAmybOPTfdwKMPYTBGX9CyCDzMyER+GbF5/0yX7mmX2KsmKckHgHpt3E7ji3RJR0bxoQDwYV48YcroHnBZ9UiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aDyd8QDr; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-2cf21012d68so3459031fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706095254; x=1706700054; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nrRXgrslTecg1zPHQayAhfd4pFFDrfAYfBFQIHxLZuo=;
        b=aDyd8QDrUhdFZU2ZwJTY2X0e+37ERkuPGW+cch7xttIaKPAy2CQWrEZSq5pNvbOMDZ
         fSFzW32KDGlvWI5LY8yDCpmxjuw0iG2wOer9gQB02wodveY/jsyHjGBVIBl5/6FNKWC2
         rKGeGT3qc8gYhyDGLXxp4ujwd9OMsX0+KMPcm6Q9n166yfbPalaRYprNaE550PdTMJrd
         I4PzRMBJhnAhaNvZKk+izmYxcx/x/pwxqIxwSFAX5vfE5rpv/zxKtIg/G9Uqh1XTGYkA
         HwmxUdKIsfzAzA/zlacLCJQ/5ZfB+QprvFIAGXwBtbKrNXAZsm04RscAow2AcLzeFV3b
         z1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706095254; x=1706700054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nrRXgrslTecg1zPHQayAhfd4pFFDrfAYfBFQIHxLZuo=;
        b=IBE/B8QjjkaxRgwF1HYYjTPiqxIiqQJSEtDlD2uvF0cHQ0POp+0bjEQofqGJy+1S71
         vrcM+VhFov9YXxYL+fxs/Y2bovQM4rmdhGlJRUdjEwEs1kT0B0OLnuLj8smJlvdedxf3
         h1mnrRSpYRngm6LDK94kHCkm6+z2kA4GPyunKG73pE2jsiLR4BlTaRR7fcT/s76esdFJ
         sU7M4I3bDldtWYNaawtWV2ZA9a+KPSHcEPghCSE6cBcZ3SIqyD/g2+oL9Sb9uiEhoGpf
         BDeddBeh6JdRKme8Y7Mrs0sz1ug1Sed7hCKFC6MG/we4qHwDFrW+x5YZ4kKCBdsHEjT2
         iNmw==
X-Gm-Message-State: AOJu0Yxn/Xu389xKCr4ysyxGQludgMm/HNfRlzjFCeDSQtsiG4aZF8GV
	n9TxPqMGtkHjmDR9Ou3Bzy4SFZkakn+Bl/IJTGb3J1WXBxSVR6qU++1xVoAFqGtZ8pN39c9xTNx
	hMmeG1+9b60EpDg==
X-Google-Smtp-Source: AGHT+IFz9frXq/IIhNd/HhEZJVxc8Tq5uNg7IKRPCngg3LDmeiDJeDNzAUzhLqCkahqINQMfwt0C69cmE0H04Uk=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:bb90:0:b0:2cd:3985:eda1 with SMTP id
 y16-20020a2ebb90000000b002cd3985eda1mr2768lje.2.1706095254370; Wed, 24 Jan
 2024 03:20:54 -0800 (PST)
Date: Wed, 24 Jan 2024 11:20:23 +0000
In-Reply-To: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=11163; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=N81WtFNSKMRQnbGYXHdbc93PTVhG91qfzypfB7FfqFo=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlsPKK0JA8Zn/8fTWeul7MILwvqo4hqE5J1nIUM
 axDWW8fwGKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZbDyigAKCRAEWL7uWMY5
 Rm0kD/0aSmWKR0JUq7UIpj7N3VtpSj7KrkXZdy1amJr0u1avQQjFq9yE/PIj38sEdEE1suDOToU
 dRI9djXHUYa3Nh1omuaW/T142IK4B9+JN7HTLnGCIi4mTmPc16/EcNgLldkFxnmW3mAEfB6FNyX
 SVkN/B4txu6t5Z3qwC8ON3dnErm5qj6Yd0bM51mbJxITOmtvHE3JlRMS5Mz05cNGj6fRgJnaHNC
 /8WwfKDyaRUzo1P5anOxC1bzYH8+dYB56TMycgeD8IL3deDWGgc3ovtO4bQKkalQqmtM1B+y2af
 DTj+YLCQYkmaQQxY6XjSPyaHL9ta8Myz5T1EXkVCN9UCadPuJai9NGDIHFjKmpsZ0kzlKg2KoJm
 EW4CONBVL2c+WiJ9VTzMZtV3OccEd1HUWAsOOHrELChSIDcvSnmVIM6WFG9iTasYpSiLQO6umLa
 DmChChXddgMdofdcGox6ge6O+qV3YjYSwjfpcwmxs6jzsGd0r7Cvf4N+3763HAKLvsnbAKfS6n9
 wpvhKCYomus0rAeH0gL7aEzDUAbNn3ihEIHeUgAchMnyQpF9TeEhJT1t6XsN0OujjtBfKAB+zNO
 uPfVktRS/SNitORyjGF2i9fUAuCBBJ78T1nt0jctO6JOUfPMnV7nLAl1zN4GYMyspyHvL+1yFAc 0qDOIiO7uKOBrWA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240124-alice-mm-v1-3-d1abcec83c44@google.com>
Subject: [PATCH 3/3] rust: add abstraction for `struct page`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Kees Cook <keescook@chromium.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
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
`with_pointer_into_page` method. Finally, the struct can be renamed to
`Pages<ORDER>`, and the type alias `Page = Pages<0>` can be introduced.

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
support for higher-order pages, and by introducing the `with_*` helpers
to consolidate the bounds checking logic into a single place.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers.c                  |  20 +++++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/page.rs             | 176 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 198 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index c0cb4b05b918..7698f5b349d3 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -21,3 +21,4 @@
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL = GFP_KERNEL;
 const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
+const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM = ___GFP_HIGHMEM;
diff --git a/rust/helpers.c b/rust/helpers.c
index 187f445fbf19..e6541119160b 100644
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
@@ -127,6 +129,24 @@ int rust_helper_signal_pending(struct task_struct *t)
 }
 EXPORT_SYMBOL_GPL(rust_helper_signal_pending);
 
+struct page *rust_helper_alloc_pages(gfp_t gfp_mask, unsigned int order)
+{
+       return alloc_pages(gfp_mask, order);
+}
+EXPORT_SYMBOL_GPL(rust_helper_alloc_pages);
+
+void *rust_helper_kmap_local_page(struct page *page)
+{
+       return kmap_local_page(page);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kmap_local_page);
+
+void rust_helper_kunmap_local(const void *addr)
+{
+       kunmap_local(addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kunmap_local);
+
 refcount_t rust_helper_REFCOUNT_INIT(int n)
 {
 	return (refcount_t)REFCOUNT_INIT(n);
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 041233305fda..9f31faf88973 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -41,6 +41,7 @@
 pub mod kunit;
 #[cfg(CONFIG_NET)]
 pub mod net;
+pub mod page;
 pub mod prelude;
 pub mod print;
 mod static_assert;
diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
new file mode 100644
index 000000000000..f83c889d39e3
--- /dev/null
+++ b/rust/kernel/page.rs
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Kernel page allocation and management.
+
+use crate::{bindings, error::code::*, error::Result, user_ptr::UserSlicePtrReader};
+use core::{
+    alloc::AllocError,
+    ffi::c_void,
+    ptr::{self, NonNull},
+};
+
+/// A bitwise shift for the page size.
+pub const PAGE_SHIFT: usize = bindings::PAGE_SHIFT as usize;
+/// The number of bytes in a page.
+pub const PAGE_SIZE: usize = 1 << PAGE_SHIFT;
+/// A bitwise mask for the page size.
+pub const PAGE_MASK: usize = PAGE_SIZE - 1;
+
+/// A pointer to a page that owns the page allocation.
+///
+/// # Invariants
+///
+/// The pointer points at a page, and has ownership over the page.
+pub struct Page {
+    page: NonNull<bindings::page>,
+}
+
+// SAFETY: It is safe to transfer page allocations between threads.
+unsafe impl Send for Page {}
+
+// SAFETY: Calling `&self` methods on this type in parallel is safe. It might
+// allow you to perform a data race on bytes stored in the page, but we treat
+// this like data races on user pointers.
+unsafe impl Sync for Page {}
+
+impl Page {
+    /// Allocates a new set of contiguous pages.
+    pub fn new() -> Result<Self, AllocError> {
+        // SAFETY: These are the correct arguments to allocate a single page.
+        let page = unsafe {
+            bindings::alloc_pages(
+                bindings::GFP_KERNEL | bindings::__GFP_ZERO | bindings::__GFP_HIGHMEM,
+                0,
+            )
+        };
+
+        match NonNull::new(page) {
+            // INVARIANT: We checked that the allocation above succeeded.
+            Some(page) => Ok(Self { page }),
+            None => Err(AllocError),
+        }
+    }
+
+    /// Returns a raw pointer to the page.
+    pub fn as_ptr(&self) -> *mut bindings::page {
+        self.page.as_ptr()
+    }
+
+    /// Runs a piece of code with this page mapped to an address.
+    ///
+    /// It is up to the caller to use the provided raw pointer correctly.
+    pub fn with_page_mapped<T>(&self, f: impl FnOnce(*mut c_void) -> T) -> T {
+        // SAFETY: `page` is valid due to the type invariants on `Page`.
+        let mapped_addr = unsafe { bindings::kmap_local_page(self.as_ptr()) };
+
+        let res = f(mapped_addr);
+
+        // SAFETY: This unmaps the page mapped above.
+        //
+        // Since this API takes the user code as a closure, it can only be used
+        // in a manner where the pages are unmapped in reverse order. This is as
+        // required by `kunmap_local`.
+        //
+        // In other words, if this call to `kunmap_local` happens when a
+        // different page should be unmapped first, then there must necessarily
+        // be a call to `kmap_local_page` other than the call just above in
+        // `with_page_mapped` that made that possible. In this case, it is the
+        // unsafe block that wraps that other call that is incorrect.
+        unsafe { bindings::kunmap_local(mapped_addr) };
+
+        res
+    }
+
+    /// Runs a piece of code with a raw pointer to a slice of this page, with
+    /// bounds checking.
+    ///
+    /// If `f` is called, then it will be called with a pointer that points at
+    /// `off` bytes into the page, and the pointer will be valid for at least
+    /// `len` bytes. The pointer is only valid on this task, as this method uses
+    /// a local mapping.
+    ///
+    /// If `off` and `len` refers to a region outside of this page, then this
+    /// method returns `EINVAL` and does not call `f`.
+    pub fn with_pointer_into_page<T>(
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
+                f(unsafe { page_addr.cast::<u8>().add(off) })
+            })
+        } else {
+            Err(EINVAL)
+        }
+    }
+
+    /// Maps the page and reads from it into the given buffer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `dest` is valid for writing `len` bytes.
+    pub unsafe fn read(&self, dest: *mut u8, offset: usize, len: usize) -> Result {
+        self.with_pointer_into_page(offset, len, move |from_ptr| {
+            // SAFETY: If `with_pointer_into_page` calls into this closure, then
+            // it has performed a bounds check and guarantees that `from_ptr` is
+            // valid for `len` bytes.
+            unsafe { ptr::copy(from_ptr, dest, len) };
+            Ok(())
+        })
+    }
+
+    /// Maps the page and writes into it from the given buffer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `src` is valid for reading `len` bytes.
+    pub unsafe fn write(&self, src: *const u8, offset: usize, len: usize) -> Result {
+        self.with_pointer_into_page(offset, len, move |to_ptr| {
+            // SAFETY: If `with_pointer_into_page` calls into this closure, then
+            // it has performed a bounds check and guarantees that `to_ptr` is
+            // valid for `len` bytes.
+            unsafe { ptr::copy(src, to_ptr, len) };
+            Ok(())
+        })
+    }
+
+    /// Maps the page and zeroes the given slice.
+    pub fn fill_zero(&self, offset: usize, len: usize) -> Result {
+        self.with_pointer_into_page(offset, len, move |to_ptr| {
+            // SAFETY: If `with_pointer_into_page` calls into this closure, then
+            // it has performed a bounds check and guarantees that `to_ptr` is
+            // valid for `len` bytes.
+            unsafe { ptr::write_bytes(to_ptr, 0u8, len) };
+            Ok(())
+        })
+    }
+
+    /// Copies data from userspace into this page.
+    pub fn copy_into_page(
+        &self,
+        reader: &mut UserSlicePtrReader,
+        offset: usize,
+        len: usize,
+    ) -> Result {
+        self.with_pointer_into_page(offset, len, move |to_ptr| {
+            // SAFETY: If `with_pointer_into_page` calls into this closure, then
+            // it has performed a bounds check and guarantees that `to_ptr` is
+            // valid for `len` bytes.
+            unsafe { reader.read_raw(to_ptr, len) }
+        })
+    }
+}
+
+impl Drop for Page {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we have ownership of the page and can
+        // free it.
+        unsafe { bindings::__free_pages(self.page.as_ptr(), 0) };
+    }
+}

-- 
2.43.0.429.g432eaa2c6b-goog


