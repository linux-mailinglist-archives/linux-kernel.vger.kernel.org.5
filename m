Return-Path: <linux-kernel+bounces-36847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CD283A7A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3321F26C31
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53702C69E;
	Wed, 24 Jan 2024 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gAkllVF3"
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FB92BAF8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095252; cv=none; b=L40tRThrZd8Vy8nBk7GtvAGjTgpK039X2tEjiaHzsdemYAdLkSlieMwfEi0hVU8vG55CrnCVWBLUrzUCZOTKdNk8D1+S30h+y/Sp/FbUKbxs4lcgidQ+OKp5P01OpWrFQhAhy1/Subq1t7wfFAc5qsyD+JrrRQyKeO8JtqJSobY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095252; c=relaxed/simple;
	bh=dpRiqVbP/yxEvKWMFYnNhrBiX8KbP9cWEfpbbU44E8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VRI2fGVIsqqvMTsOSsfpam2WXiGuITGZ8cojtN6Vq1auRrwIz7bRK49/cv7TmtzCG47SpeLE5NHXbSC25raBr7E1rrACEgq/GzITmGFOymG37qarM6A4OkzsvSDgYaAJh9UL2Brqhu7TELlShqAmj46zXa0XMBu3KkDO1dEeJh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gAkllVF3; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-2cf085e1c31so11171781fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706095248; x=1706700048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sOlUnGTFxhN3Wh+HyLrepLimkn/9swyxf47U8+mQUyU=;
        b=gAkllVF3ZxUzCRXBMrwzw2y8s3AlxHKrCNsuCIJq+SFfutvpBecfDfhkkCvYLd5D9z
         KNY/hLqfv/IdnLfIWvWlBNw6Q+3yDd4rtyd9DyCPgEgqCRkluW2qZmXWR/zDRlvH/WyZ
         z7x90ulhQw+U0WgQ/HfEuA22sEJt5IsORMJdIeCBt8X8LsSeIvUKzw+Qlxkd91wMjNZw
         B5Ji163S78dfld69pWk7B94o9SpdLuee/6IPy/Q0TG56hYIqLXkn555L6SCPmGhlfleh
         Y532aZ9R4kMH7Vz6qhoy0AwHgsFpVOlnKokQFQdDhPSUI7TI8JDmzUQq546uW/BrKS2q
         NGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706095248; x=1706700048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sOlUnGTFxhN3Wh+HyLrepLimkn/9swyxf47U8+mQUyU=;
        b=tylOHN8coRjzARpIysnjn3kTd4fmn9BC7WTlD64H+hdXCGe1FOL7G1uIrK/mgcrcRV
         2cXLWuk2cIKDTokeTDfyiEOAT2LZByvU03vbBbCyTZKY6K4uJ3Ovb24DB9/OXxi+MgAy
         QHbhyF3qKzOaXfv9GrTn2nl5clTYZ88A5yAa93nS6I5fpainfGt56eoFKM0LMEEBdgwk
         1HLGUmrOk1BfeQuA7FdD82vzf7tt9QOdYYCw/N7B09KbU6HVQSJzZekcOJzelO7/Emqs
         NHd8RjZTR3t+llwz3CG061T2F372W5hau8iQgRDZvBtzPfMNitMZnuQh/bJ7VCL8+FeY
         W0sg==
X-Gm-Message-State: AOJu0YwaKRxOiDonmf0iyoCWIO1uuPZSRvnLnqNGIvY1IWmGxBdHaQRO
	Vd6S56XQgGc7c6ScZqMrOJ9yAAoFxdXoyvs7x2zhIWKHM08OhnyIMb45KohndZ11MON6iz+lYzP
	l46/UbykEpO/+eQ==
X-Google-Smtp-Source: AGHT+IFUYMF+5aVolcJmSgvYFnzvo3J5rdE3577wOO1E14UnlXcw+yKrbQDZV1pCgDhSzd5JSUABWHV4PUCu0xY=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:651c:b10:b0:2cd:eb48:b13a with SMTP
 id b16-20020a05651c0b1000b002cdeb48b13amr2362ljr.0.1706095248056; Wed, 24 Jan
 2024 03:20:48 -0800 (PST)
Date: Wed, 24 Jan 2024 11:20:21 +0000
In-Reply-To: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=12466; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=bddQOIHpQkNTHq5sjTLF1voN+vRIKosROer1IBiKH5A=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlsPKIRQHGdOXUpFINztbIBSV3FRotWlg2iJOOs
 JAtY6uLI4CJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZbDyiAAKCRAEWL7uWMY5
 RoEfD/91wS6JPiDUWmveLCNNVfA6anIc+FlQsNYh5zlWLLaxe+paLhsR0TrGWOogLdJ0IEH0jMU
 IJsgpxyuIHJ2gU5Wv5XJ/6T652mp+neY7FLhbDy1AwyaDjOtyZe9YG+lleVY+cCb6JfpCjaxQ4P
 OAVNBrtDzv/q7RDe3hJBJmc/qi1UJW7CaM0N7AkAHqVopOdi0JV3NUvYYJhsPtOSaWVNdHjw3Rc
 /xkUIhvoMY7HUz4660SIcOVUBgPQ+N4jwsZlX04QD+FjKi0ZPRchMCJOf622yKI8c41wmdO3df1
 JnbwGrCqZ+0OJkDowIjxUddGR/jm98odkcYtso9gCXCuW36zQv/E9Aqlbi0qg0G1oM1msuV2B7C
 JZPkTcmL26OQXZe4H3N1wZblu6NK8NJmtZz+3uBhALhRAKwr2lzNLRdmlfKwUU0uqIpFREk6hLZ
 jNQOzCCe1nDDxMaexOZbX8TNzih7O6/k928AQFtMyzzAZDPlUysnD+MosOPxFxdV5HM0lfpL/9W
 nz2hVF8znvzWDXkB9Rt2J2uVFdJLkH6FKbXEPXkM/aeRQQVE3QMZmVDvuNj6b1RliB551Mm/ljQ
 LHlblg1e2PzRKPE09USqjXaol+QbwGQO4Of/MO8jkDxLXA/xE0vBkCLIk0zXRcK6rzE3V6CKHR6 FOwnyPzNQkC5n6g==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240124-alice-mm-v1-1-d1abcec83c44@google.com>
Subject: [PATCH 1/3] rust: add userspace pointers
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

From: Wedson Almeida Filho <wedsonaf@gmail.com>

A pointer to an area in userspace memory, which can be either read-only
or read-write.

All methods on this struct are safe: invalid pointers return `EFAULT`.
Concurrent access, *including data races to/from userspace memory*, is
permitted, because fundamentally another userspace thread/process could
always be modifying memory at the same time (in the same way that
userspace Rust's `std::io` permits data races with the contents of
files on disk). In the presence of a race, the exact byte values
read/written are unspecified but the operation is well-defined.
Kernelspace code should validate its copy of data after completing a
read, and not expect that multiple reads of the same address will return
the same value.

These APIs are designed to make it difficult to accidentally write
TOCTOU bugs. Every time you read from a memory location, the pointer is
advanced by the length so that you cannot use that reader to read the
same memory location twice. Preventing double-fetches avoids TOCTOU
bugs. This is accomplished by taking `self` by value to prevent
obtaining multiple readers on a given `UserSlicePtr`, and the readers
only permitting forward reads. If double-fetching a memory location is
necessary for some reason, then that is done by creating multiple
readers to the same memory location.

Constructing a `UserSlicePtr` performs no checks on the provided
address and length, it can safely be constructed inside a kernel thread
with no current userspace process. Reads and writes wrap the kernel APIs
`copy_from_user` and `copy_to_user`, which check the memory map of the
current process and enforce that the address range is within the user
range (no additional calls to `access_ok` are needed).

This code is based on something that was originally written by Wedson on
the old rust branch. It was modified by Alice by removing the
`IoBufferReader` and `IoBufferWriter` traits, introducing the
`MAX_USER_OP_LEN` constant, and various changes to the comments and
documentation.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers.c          |  14 +++
 rust/kernel/lib.rs      |   1 +
 rust/kernel/user_ptr.rs | 222 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 237 insertions(+)

diff --git a/rust/helpers.c b/rust/helpers.c
index 70e59efd92bc..312b6fcb49d5 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -38,6 +38,20 @@ __noreturn void rust_helper_BUG(void)
 }
 EXPORT_SYMBOL_GPL(rust_helper_BUG);
 
+unsigned long rust_helper_copy_from_user(void *to, const void __user *from,
+					 unsigned long n)
+{
+	return copy_from_user(to, from, n);
+}
+EXPORT_SYMBOL_GPL(rust_helper_copy_from_user);
+
+unsigned long rust_helper_copy_to_user(void __user *to, const void *from,
+				       unsigned long n)
+{
+	return copy_to_user(to, from, n);
+}
+EXPORT_SYMBOL_GPL(rust_helper_copy_to_user);
+
 void rust_helper_mutex_lock(struct mutex *lock)
 {
 	mutex_lock(lock);
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 7ac39874aeac..041233305fda 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -50,6 +50,7 @@
 pub mod sync;
 pub mod task;
 pub mod types;
+pub mod user_ptr;
 pub mod workqueue;
 
 #[doc(hidden)]
diff --git a/rust/kernel/user_ptr.rs b/rust/kernel/user_ptr.rs
new file mode 100644
index 000000000000..00aa26aa6a83
--- /dev/null
+++ b/rust/kernel/user_ptr.rs
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! User pointers.
+//!
+//! C header: [`include/linux/uaccess.h`](../../../../include/linux/uaccess.h)
+
+// Comparison with MAX_USER_OP_LEN triggers this lint on platforms
+// where `c_ulong == usize`.
+#![allow(clippy::absurd_extreme_comparisons)]
+
+use crate::{bindings, error::code::*, error::Result};
+use alloc::vec::Vec;
+use core::ffi::{c_ulong, c_void};
+
+/// The maximum length of a operation using `copy_[from|to]_user`.
+///
+/// If a usize is not greater than this constant, then casting it to `c_ulong`
+/// is guaranteed to be lossless.
+const MAX_USER_OP_LEN: usize = c_ulong::MAX as usize;
+
+/// A pointer to an area in userspace memory, which can be either read-only or
+/// read-write.
+///
+/// All methods on this struct are safe: invalid pointers return `EFAULT`.
+/// Concurrent access, *including data races to/from userspace memory*, is
+/// permitted, because fundamentally another userspace thread/process could
+/// always be modifying memory at the same time (in the same way that userspace
+/// Rust's [`std::io`] permits data races with the contents of files on disk).
+/// In the presence of a race, the exact byte values read/written are
+/// unspecified but the operation is well-defined. Kernelspace code should
+/// validate its copy of data after completing a read, and not expect that
+/// multiple reads of the same address will return the same value.
+///
+/// These APIs are designed to make it difficult to accidentally write TOCTOU
+/// bugs. Every time you read from a memory location, the pointer is advanced by
+/// the length so that you cannot use that reader to read the same memory
+/// location twice. Preventing double-fetches avoids TOCTOU bugs. This is
+/// accomplished by taking `self` by value to prevent obtaining multiple readers
+/// on a given [`UserSlicePtr`], and the readers only permitting forward reads.
+/// If double-fetching a memory location is necessary for some reason, then that
+/// is done by creating multiple readers to the same memory location, e.g. using
+/// [`clone_reader`].
+///
+/// Constructing a [`UserSlicePtr`] performs no checks on the provided address
+/// and length, it can safely be constructed inside a kernel thread with no
+/// current userspace process. Reads and writes wrap the kernel APIs
+/// `copy_from_user` and `copy_to_user`, which check the memory map of the
+/// current process and enforce that the address range is within the user range
+/// (no additional calls to `access_ok` are needed).
+///
+/// [`std::io`]: https://doc.rust-lang.org/std/io/index.html
+/// [`clone_reader`]: UserSlicePtrReader::clone_reader
+pub struct UserSlicePtr(*mut c_void, usize);
+
+impl UserSlicePtr {
+    /// Constructs a user slice from a raw pointer and a length in bytes.
+    ///
+    /// Callers must be careful to avoid time-of-check-time-of-use
+    /// (TOCTOU) issues. The simplest way is to create a single instance of
+    /// [`UserSlicePtr`] per user memory block as it reads each byte at
+    /// most once.
+    pub fn new(ptr: *mut c_void, length: usize) -> Self {
+        UserSlicePtr(ptr, length)
+    }
+
+    /// Reads the entirety of the user slice.
+    ///
+    /// Returns `EFAULT` if the address does not currently point to
+    /// mapped, readable memory.
+    pub fn read_all(self) -> Result<Vec<u8>> {
+        self.reader().read_all()
+    }
+
+    /// Constructs a [`UserSlicePtrReader`].
+    pub fn reader(self) -> UserSlicePtrReader {
+        UserSlicePtrReader(self.0, self.1)
+    }
+
+    /// Constructs a [`UserSlicePtrWriter`].
+    pub fn writer(self) -> UserSlicePtrWriter {
+        UserSlicePtrWriter(self.0, self.1)
+    }
+
+    /// Constructs both a [`UserSlicePtrReader`] and a [`UserSlicePtrWriter`].
+    pub fn reader_writer(self) -> (UserSlicePtrReader, UserSlicePtrWriter) {
+        (
+            UserSlicePtrReader(self.0, self.1),
+            UserSlicePtrWriter(self.0, self.1),
+        )
+    }
+}
+
+/// A reader for [`UserSlicePtr`].
+///
+/// Used to incrementally read from the user slice.
+pub struct UserSlicePtrReader(*mut c_void, usize);
+
+impl UserSlicePtrReader {
+    /// Skip the provided number of bytes.
+    ///
+    /// Returns an error if skipping more than the length of the buffer.
+    pub fn skip(&mut self, num_skip: usize) -> Result {
+        // Update `self.1` first since that's the fallible one.
+        self.1 = self.1.checked_sub(num_skip).ok_or(EFAULT)?;
+        self.0 = self.0.wrapping_add(num_skip);
+        Ok(())
+    }
+
+    /// Create a reader that can access the same range of data.
+    ///
+    /// Reading from the clone does not advance the current reader.
+    ///
+    /// The caller should take care to not introduce TOCTOU issues.
+    pub fn clone_reader(&self) -> UserSlicePtrReader {
+        UserSlicePtrReader(self.0, self.1)
+    }
+
+    /// Returns the number of bytes left to be read from this.
+    ///
+    /// Note that even reading less than this number of bytes may fail.
+    pub fn len(&self) -> usize {
+        self.1
+    }
+
+    /// Returns `true` if no data is available in the io buffer.
+    pub fn is_empty(&self) -> bool {
+        self.1 == 0
+    }
+
+    /// Reads raw data from the user slice into a raw kernel buffer.
+    ///
+    /// Fails with `EFAULT` if the read encounters a page fault.
+    ///
+    /// # Safety
+    ///
+    /// The `out` pointer must be valid for writing `len` bytes.
+    pub unsafe fn read_raw(&mut self, out: *mut u8, len: usize) -> Result {
+        if len > self.1 || len > MAX_USER_OP_LEN {
+            return Err(EFAULT);
+        }
+        // SAFETY: The caller promises that `out` is valid for writing `len` bytes.
+        let res = unsafe { bindings::copy_from_user(out.cast::<c_void>(), self.0, len as c_ulong) };
+        if res != 0 {
+            return Err(EFAULT);
+        }
+        // Since this is not a pointer to a valid object in our program,
+        // we cannot use `add`, which has C-style rules for defined
+        // behavior.
+        self.0 = self.0.wrapping_add(len);
+        self.1 -= len;
+        Ok(())
+    }
+
+    /// Reads all remaining data in the buffer into a vector.
+    ///
+    /// Fails with `EFAULT` if the read encounters a page fault.
+    pub fn read_all(&mut self) -> Result<Vec<u8>> {
+        let len = self.len();
+        let mut data = Vec::<u8>::try_with_capacity(len)?;
+
+        // SAFETY: The output buffer is valid for `len` bytes as we just allocated that much space.
+        unsafe { self.read_raw(data.as_mut_ptr(), len)? };
+
+        // SAFETY: Since the call to `read_raw` was successful, the first `len` bytes of the vector
+        // have been initialized.
+        unsafe { data.set_len(len) };
+        Ok(data)
+    }
+}
+
+/// A writer for [`UserSlicePtr`].
+///
+/// Used to incrementally write into the user slice.
+pub struct UserSlicePtrWriter(*mut c_void, usize);
+
+impl UserSlicePtrWriter {
+    /// Returns the amount of space remaining in this buffer.
+    ///
+    /// Note that even writing less than this number of bytes may fail.
+    pub fn len(&self) -> usize {
+        self.1
+    }
+
+    /// Returns `true` if no more data can be written to this buffer.
+    pub fn is_empty(&self) -> bool {
+        self.1 == 0
+    }
+
+    /// Writes raw data to this user pointer from a raw kernel buffer.
+    ///
+    /// Fails with `EFAULT` if the write encounters a page fault.
+    ///
+    /// # Safety
+    ///
+    /// The `data` pointer must be valid for reading `len` bytes.
+    pub unsafe fn write_raw(&mut self, data: *const u8, len: usize) -> Result {
+        if len > self.1 || len > MAX_USER_OP_LEN {
+            return Err(EFAULT);
+        }
+        let res = unsafe { bindings::copy_to_user(self.0, data.cast::<c_void>(), len as c_ulong) };
+        if res != 0 {
+            return Err(EFAULT);
+        }
+        // Since this is not a pointer to a valid object in our program,
+        // we cannot use `add`, which has C-style rules for defined
+        // behavior.
+        self.0 = self.0.wrapping_add(len);
+        self.1 -= len;
+        Ok(())
+    }
+
+    /// Writes the provided slice to this user pointer.
+    ///
+    /// Fails with `EFAULT` if the write encounters a page fault.
+    pub fn write_slice(&mut self, data: &[u8]) -> Result {
+        let len = data.len();
+        let ptr = data.as_ptr();
+        // SAFETY: The pointer originates from a reference to a slice of length
+        // `len`, so the pointer is valid for reading `len` bytes.
+        unsafe { self.write_raw(ptr, len) }
+    }
+}

-- 
2.43.0.429.g432eaa2c6b-goog


