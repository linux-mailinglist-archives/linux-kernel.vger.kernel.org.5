Return-Path: <linux-kernel+bounces-58301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D1384E446
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA19B28A07
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB337C6C0;
	Thu,  8 Feb 2024 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bV+HvPX6"
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9B67CF3A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407327; cv=none; b=J2XO6xGcXeVrpK7mCZRYwHTbm5qmKTqMyAPsa5HVB+hm3SCJkAOO16ZGL1vzBs5RNeJ37L261rCp0528B+FGMhSj8gIYjKvnbglgdE2MQo4yIfRO6fdqOqymZP3Hdl03VRkNBtJWdWtx5VCI63eskl+AE78Kst+t7dghW1Mw2BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407327; c=relaxed/simple;
	bh=lCrEJt6bdZ+xsdxDuwJzlgiCY22jzIDidvo8o/5TupA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ipi5NwYYO6LaChWz+3sRJ78I7bCrAQoUAYhWfic89xlxRIWmx1iNgd5G8NAE4KqAw5Qnmd9kWvipEh8jUnlIJUMJHMTw+tJHGzN6gBD4wfoimlHBcyOGwN1E9+8yZ8gpezY2tkMAABiLhH/59RiUHW5YLWyi3OgrAW8ILeqCLvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bV+HvPX6; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2d0a7ab562eso184001fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 07:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707407323; x=1708012123; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MZxfREqmJLVb5yZOS5o3jZQJUZjkOkdbEVLWBie4ZLY=;
        b=bV+HvPX602v+XWX0jHAUl1yV5lAbHP5vSMOVt6ru4GeWnZp7uYomMsPu2byR0ivNLZ
         64XKbUSIPlZTXiSD/wo3clgQHJCzcLn/CVNoPZPUUB4eXVnl5k98qUWVMqrHWP1iCyk9
         I4KLytDtT/NkjIhHZXQovz77DvMSopT3IpV91hLYrxVr9hC47f9pnns4WqmKOOeA4BBa
         FHukAofC5J/1g4zdOfyHy7YE/KG8BR+TfIQEnjznSsomi5C/wYu6g3CvuWQmrS2TDYsb
         njyFE9jJMvaEHl8q62GQH5n7qF8PnuKPyCa74uBp5/AJrxIKVrQ69BO27sQ/Uk+72IYx
         XJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707407323; x=1708012123;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZxfREqmJLVb5yZOS5o3jZQJUZjkOkdbEVLWBie4ZLY=;
        b=bCW6s5cgAKQrVUvtmfaAo8xms8RG/yahBOczezOopRI7KUnTTbhZIuT9NSSWmAhS5r
         OTilS5H8a3A+tDiUy7DMMxkSluSa1+zIltLooWuKx+W2ZtpcPqGofgfuneKH6JpSzEpI
         Eu5u82IMKZtcW4BB9H8ahm6aEP/lxo2BDbolAYnwFxmb2e58Tuv7rddRWvPr7eIDJYro
         m1po3Xhb0ONdBgTn9WjrQIRU+zgOEobuUToI6aW0XF7bKUqNtycSWZEnQHsnt08/kti/
         5if26X0TYIruj5Cp4mUmkLYuv2eAEV3AE4W3zI5jLYs42ry0bQPIJBvvh6xf2UYcfqrk
         smgA==
X-Gm-Message-State: AOJu0Yy1hOEXhAboKQdxpdIOLzeLmJXLKVLso91Qs4h+dEEecbw+CWRW
	s8yKGkwreD1buTf25u1mHwL84wA9IW4hnIOspUzVIoB8vvufhsHlDi8HOuU7Ef9AY834KijOBT1
	xluFE+kO+6b2aZA==
X-Google-Smtp-Source: AGHT+IHoGrfQzs+9yE0464QzK+HqTUKqSxG8JmHBnPR1HAtK83lpXzvLfwmFqpdg5OICpSu+CEBC8v6oauXpx0A=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:651c:542:b0:2d0:9072:e938 with SMTP
 id q2-20020a05651c054200b002d09072e938mr5249ljp.0.1707407322927; Thu, 08 Feb
 2024 07:48:42 -0800 (PST)
Date: Thu, 08 Feb 2024 15:47:51 +0000
In-Reply-To: <20240208-alice-mm-v2-0-d821250204a6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208-alice-mm-v2-0-d821250204a6@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=15018; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=9c+X+VCQkxS1WdW6d5i+iI8c8KAsrHFSOj7xqDOlk7Q=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlxPfSev0FxgN6ijmdsQvYOv+UnwaPgSq7w41oD
 9TKOdwIkJOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZcT30gAKCRAEWL7uWMY5
 RkD0D/9h4bQNWcQlVOexF5lW5P/AI5hzsNTtH8Hr3J45XHedWS8SEIyplKt5EgQsvWIyGObonCL
 qcFbtebNXaiTSayagTAtB7xc+ny4V7zKFPTI48Sac9Lls3gXzwbgc0udsb8tifotCF+1azMqb9P
 du2OXQ5UqzgBaLexCpjuPn0jTcgRw/zJwKwGR40+KnLON4ZYNtkt7Xo7K3Y60tbD4RU2k1btkNW
 qIV7VOwxmKg/80a/t2JHXkukZriX8j4Bo7vT2RWhRT18yybsn1nxLE8EPyj7gfyygf3tvxwHDkp
 ovt+SWNhO6KT8wo+IaYg8hDYpf9WNPlQf40A3ruWsn2Vfw9QwZCoJW/upYvvGqtTxJ65AWpTiUX
 GGNfpJcm0qLrCHa5DvMY20zQNw+yukGhF0+Bl6BJPXaAtMz5wq0guQDXNAxtYLBukKPOa47Skad
 jxTWuO45co3cDY0EqSA4r3Ve4il9NCetzpkDWUVISRU2s6OB56VC6fWbK1getbVrkDuMnSfY7xC
 S6mrQ7kj5a5MZkKFqcxeAnESQWcid/GqtfrERlzo22tFebTmst8e61T7uwEgBxeAfBwmwyE4p/1
 qwitm1RdHnmKppq30Fq/bNdqNdTQHKt7SKqV3VnGtVol/zujHw4RUpNi4bfeCBLD7JzWVtdGCGG xoAGwzviOliOB0g==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240208-alice-mm-v2-1-d821250204a6@google.com>
Subject: [PATCH v2 1/4] rust: uaccess: add userspace pointers
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
 rust/helpers.c         |  14 +++
 rust/kernel/lib.rs     |   1 +
 rust/kernel/uaccess.rs | 314 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 329 insertions(+)

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
index b89ecf4e97a0..5a03aafcbb69 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -50,6 +50,7 @@
 pub mod task;
 pub mod time;
 pub mod types;
+pub mod uaccess;
 pub mod workqueue;
 
 #[doc(hidden)]
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
new file mode 100644
index 000000000000..f07821184bd6
--- /dev/null
+++ b/rust/kernel/uaccess.rs
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! User pointers.
+//!
+//! C header: [`include/linux/uaccess.h`](srctree/include/linux/uaccess.h)
+
+use crate::{bindings, error::code::*, error::Result};
+use alloc::vec::Vec;
+use core::ffi::{c_ulong, c_void};
+
+/// A pointer to an area in userspace memory, which can be either read-only or
+/// read-write.
+///
+/// All methods on this struct are safe: attempting to read or write invalid
+/// pointers will return `EFAULT`. Concurrent access, *including data races
+/// to/from userspace memory*, is permitted, because fundamentally another
+/// userspace thread/process could always be modifying memory at the same time
+/// (in the same way that userspace Rust's [`std::io`] permits data races with
+/// the contents of files on disk). In the presence of a race, the exact byte
+/// values read/written are unspecified but the operation is well-defined.
+/// Kernelspace code should validate its copy of data after completing a read,
+/// and not expect that multiple reads of the same address will return the same
+/// value.
+///
+/// These APIs are designed to make it difficult to accidentally write TOCTOU
+/// (time-of-check to time-of-use) bugs. Every time a memory location is read,
+/// the reader's position is advanced by the read length and the next read will
+/// start from there. This helps prevent accidentally reading the same location
+/// twice and causing a TOCTOU bug.
+///
+/// Creating a [`UserSliceReader`] and/or [`UserSliceWriter`] consumes the
+/// `UserSlice`, helping ensure that there aren't multiple readers or writers to
+/// the same location.
+///
+/// If double-fetching a memory location is necessary for some reason, then that
+/// is done by creating multiple readers to the same memory location, e.g. using
+/// [`clone_reader`].
+///
+/// # Examples
+///
+/// Takes a region of userspace memory from the current process, and modify it
+/// by adding one to every byte in the region.
+///
+/// ```no_run
+/// use alloc::vec::Vec;
+/// use core::ffi::c_void;
+/// use kernel::error::Result;
+/// use kernel::uaccess::UserSlice;
+///
+/// pub fn bytes_add_one(uptr: *mut c_void, len: usize) -> Result<()> {
+///     let (read, mut write) = UserSlice::new(uptr, len).reader_writer();
+///
+///     let mut buf = Vec::new();
+///     read.read_all(&mut buf)?;
+///
+///     for b in &mut buf {
+///         *b = b.wrapping_add(1);
+///     }
+///
+///     write.write_slice(&buf)?;
+///     Ok(())
+/// }
+/// ```
+///
+/// Example illustrating a TOCTOU (time-of-check to time-of-use) bug.
+///
+/// ```no_run
+/// use alloc::vec::Vec;
+/// use core::ffi::c_void;
+/// use kernel::error::{code::EINVAL, Result};
+/// use kernel::uaccess::UserSlice;
+///
+/// /// Returns whether the data in this region is valid.
+/// fn is_valid(uptr: *mut c_void, len: usize) -> Result<bool> {
+///     let read = UserSlice::new(uptr, len).reader();
+///
+///     let mut buf = Vec::new();
+///     read.read_all(&mut buf)?;
+///
+///     todo!()
+/// }
+///
+/// /// Returns the bytes behind this user pointer if they are valid.
+/// pub fn get_bytes_if_valid(uptr: *mut c_void, len: usize) -> Result<Vec<u8>> {
+///     if !is_valid(uptr, len)? {
+///         return Err(EINVAL);
+///     }
+///
+///     let read = UserSlice::new(uptr, len).reader();
+///
+///     let mut buf = Vec::new();
+///     read.read_all(&mut buf)?;
+///
+///     // THIS IS A BUG! The bytes could have changed since we checked them.
+///     //
+///     // To avoid this kind of bug, don't call `UserSlice::new` multiple
+///     // times with the same address.
+///     Ok(buf)
+/// }
+/// ```
+///
+/// [`std::io`]: https://doc.rust-lang.org/std/io/index.html
+/// [`clone_reader`]: UserSliceReader::clone_reader
+pub struct UserSlice {
+    ptr: *mut c_void,
+    length: usize,
+}
+
+impl UserSlice {
+    /// Constructs a user slice from a raw pointer and a length in bytes.
+    ///
+    /// Constructing a [`UserSlice`] performs no checks on the provided address
+    /// and length, it can safely be constructed inside a kernel thread with no
+    /// current userspace process. Reads and writes wrap the kernel APIs
+    /// `copy_from_user` and `copy_to_user`, which check the memory map of the
+    /// current process and enforce that the address range is within the user
+    /// range (no additional calls to `access_ok` are needed).
+    ///
+    /// Callers must be careful to avoid time-of-check-time-of-use
+    /// (TOCTOU) issues. The simplest way is to create a single instance of
+    /// [`UserSlice`] per user memory block as it reads each byte at
+    /// most once.
+    pub fn new(ptr: *mut c_void, length: usize) -> Self {
+        UserSlice { ptr, length }
+    }
+
+    /// Reads the entirety of the user slice, appending it to the end of the
+    /// provided buffer.
+    ///
+    /// Fails with `EFAULT` if the read encounters a page fault.
+    pub fn read_all(self, buf: &mut Vec<u8>) -> Result<()> {
+        self.reader().read_all(buf)
+    }
+
+    /// Constructs a [`UserSliceReader`].
+    pub fn reader(self) -> UserSliceReader {
+        UserSliceReader {
+            ptr: self.ptr,
+            length: self.length,
+        }
+    }
+
+    /// Constructs a [`UserSliceWriter`].
+    pub fn writer(self) -> UserSliceWriter {
+        UserSliceWriter {
+            ptr: self.ptr,
+            length: self.length,
+        }
+    }
+
+    /// Constructs both a [`UserSliceReader`] and a [`UserSliceWriter`].
+    ///
+    /// Usually when this is used, you will first read the data, and then
+    /// overwrite it afterwards.
+    pub fn reader_writer(self) -> (UserSliceReader, UserSliceWriter) {
+        (
+            UserSliceReader {
+                ptr: self.ptr,
+                length: self.length,
+            },
+            UserSliceWriter {
+                ptr: self.ptr,
+                length: self.length,
+            },
+        )
+    }
+}
+
+/// A reader for [`UserSlice`].
+///
+/// Used to incrementally read from the user slice.
+pub struct UserSliceReader {
+    ptr: *mut c_void,
+    length: usize,
+}
+
+impl UserSliceReader {
+    /// Skip the provided number of bytes.
+    ///
+    /// Returns an error if skipping more than the length of the buffer.
+    pub fn skip(&mut self, num_skip: usize) -> Result {
+        // Update `self.length` first since that's the fallible part of this
+        // operation.
+        self.length = self.length.checked_sub(num_skip).ok_or(EFAULT)?;
+        self.ptr = self.ptr.wrapping_byte_add(num_skip);
+        Ok(())
+    }
+
+    /// Create a reader that can access the same range of data.
+    ///
+    /// Reading from the clone does not advance the current reader.
+    ///
+    /// The caller should take care to not introduce TOCTOU issues, as described
+    /// in the documentation for [`UserSlice`].
+    pub fn clone_reader(&self) -> UserSliceReader {
+        UserSliceReader {
+            ptr: self.ptr,
+            length: self.length,
+        }
+    }
+
+    /// Returns the number of bytes left to be read from this reader.
+    ///
+    /// Note that even reading less than this number of bytes may fail.
+    pub fn len(&self) -> usize {
+        self.length
+    }
+
+    /// Returns `true` if no data is available in the io buffer.
+    pub fn is_empty(&self) -> bool {
+        self.length == 0
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
+        if len > self.length {
+            return Err(EFAULT);
+        }
+        let Ok(len_ulong) = c_ulong::try_from(len) else {
+            return Err(EFAULT);
+        };
+        // SAFETY: The caller promises that `out` is valid for writing `len` bytes.
+        let res = unsafe { bindings::copy_from_user(out.cast::<c_void>(), self.ptr, len_ulong) };
+        if res != 0 {
+            return Err(EFAULT);
+        }
+        // Userspace pointers are not directly dereferencable by the kernel, so
+        // we cannot use `add`, which has C-style rules for defined behavior.
+        self.ptr = self.ptr.wrapping_byte_add(len);
+        self.length -= len;
+        Ok(())
+    }
+
+    /// Reads the entirety of the user slice, appending it to the end of the
+    /// provided buffer.
+    ///
+    /// Fails with `EFAULT` if the read encounters a page fault.
+    pub fn read_all(mut self, buf: &mut Vec<u8>) -> Result<()> {
+        buf.try_reserve(self.length)?;
+
+        // SAFETY: The call to `try_reserve` was successful, so the spare
+        // capacity is at least `self.length` bytes long.
+        unsafe { self.read_raw(buf.spare_capacity_mut().as_mut_ptr().cast(), self.length)? };
+
+        // SAFETY: Since the call to `read_raw` was successful, so the next
+        // `len` bytes of the vector have been initialized.
+        unsafe { buf.set_len(buf.len() + self.length) };
+        Ok(())
+    }
+}
+
+/// A writer for [`UserSlice`].
+///
+/// Used to incrementally write into the user slice.
+pub struct UserSliceWriter {
+    ptr: *mut c_void,
+    length: usize,
+}
+
+impl UserSliceWriter {
+    /// Returns the amount of space remaining in this buffer.
+    ///
+    /// Note that even writing less than this number of bytes may fail.
+    pub fn len(&self) -> usize {
+        self.length
+    }
+
+    /// Returns `true` if no more data can be written to this buffer.
+    pub fn is_empty(&self) -> bool {
+        self.length == 0
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
+        if len > self.length {
+            return Err(EFAULT);
+        }
+        let Ok(len_ulong) = c_ulong::try_from(len) else {
+            return Err(EFAULT);
+        };
+        let res = unsafe { bindings::copy_to_user(self.ptr, data.cast::<c_void>(), len_ulong) };
+        if res != 0 {
+            return Err(EFAULT);
+        }
+        // Userspace pointers are not directly dereferencable by the kernel, so
+        // we cannot use `add`, which has C-style rules for defined behavior.
+        self.ptr = self.ptr.wrapping_byte_add(len);
+        self.length -= len;
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
2.43.0.594.gd9cf4e227d-goog


