Return-Path: <linux-kernel+bounces-144646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA608A48C6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 320F3B24BED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CDA25601;
	Mon, 15 Apr 2024 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yxF0SKOw"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371D32110F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165261; cv=none; b=b5TXrp5626OZMNaV0myeIgnHJ97hdwpjOCqvMTQPM2JX+g1H2QzfnUA/NjBXqz6/RADaCLBt2WTW4uyaz9mhhQrAFtDdpqcAS81tdQ/awvN7NKua9xxiuDndt1U7AAoSAYdJn/zVoZ3rAOEu6pumIM0GNRC0++4tqEcFPOpNykE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165261; c=relaxed/simple;
	bh=/Q6R4dNcsWIP61MVZvO/7imW4UEMZDsrtNDb3dueusk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ixl+zYcy68tM0BIDYFcDOUFZEmPfSKOU9l8tYCnV0pxpMpAFP6Jbv1ZS+bX+Spku1ofan/GcJuKNk9yrcLPHwDlUEHelJidF3DNzQCZmV8Q/lG53EsbDigMX/Gzi4f4W7vUUpvn+JSSKg7xkjviYaIxdH6Y0CDtKbSTmZJCuvPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yxF0SKOw; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so4685657276.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 00:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713165258; x=1713770058; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gPsi/82HDlElzGLDbKl3QsVxsZX8wiW1/rZTZrUN8mw=;
        b=yxF0SKOwkQ3ukEzRfrXp9/56NxRsdW2jLFyOZrRLvgp3hozxzzmBlNed33WxPyxNsi
         9rAWACYRaGSFcm44ISy+Isyq+Ib6XEM41Vau4ypG59dHyvWVE6Ndz1oV2l2KH++bJXD3
         8pdI8PzG6VX8ciCiOonHaQTdS2N3mnXikWwg4trIrStQp1YpZMAmVIh2ZxwX6m70E29y
         HikKOPHb6q/uJnj/EdNTO640qLazc5lI0hXw8ns8nyPdedBjlP+SbS4C1GCGG/TxFjRr
         j03yvwShQvbx4QJUZSOXjBKBvnOamcSOalmwywvhC4m0cUsWNeK2PPiwzPpdJVqvIe0R
         Kehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713165258; x=1713770058;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gPsi/82HDlElzGLDbKl3QsVxsZX8wiW1/rZTZrUN8mw=;
        b=J3ijHuNUIrfUotDQazMVWZ+ENMVVJbqenYXMtZ9+O9nNs7WpWKvLQzdzIYpGJHOCwt
         wbPcttBMX40YzyS9TwfcoxADmkW3KNe4iGt9UTkvuJEbCdB2u+eH49hlb3gROa9IQV41
         oBVEuaIUjBfr9qkHQ7RmPkhNtQJq8hhLJ9umHeL+cMuTVbKqNYRVugu6cjVLutUGsuW7
         7BcWzXWTiZz80oZfMFLSXQ5rLLweNJv0wiWkZOOmuFxEAqDt+7TlTXcQdNBf/72fqE7e
         b90EuP9pDxgObSxLAzYkerGg1at7TGIoYJkbmaZsQZP2PQ5gDLt/lObAYYR4BFceG3PU
         8WUg==
X-Forwarded-Encrypted: i=1; AJvYcCV08e1vuKp6l6KsXmTbyq1W3g9j3JG/f/DTJYGykhpxSY1pxOTVWfc30ounhAY6hKxWY7ReKveN9dVHc8j83KCSflE4QZo4bC/TK5aU
X-Gm-Message-State: AOJu0YwLrlQgmh6+IqQJvXUfFUvnLY7S1yAdx/XegZHqDFgbNJdHV+0w
	lJhLbrt1lqjzb3t5xVC8c8Bg6SLPbilCBfGQFLA4Zb69wPDK/OO0tuCkkL3LMwSgg9rSviIkZdh
	hmgKxcppfetPhzQ==
X-Google-Smtp-Source: AGHT+IHO1a/TIo+ODNueO5S/jTlindE5np/HbvfupAbQcKpEJq3V8CqBFgvXPRG//Zj7Vd3zjtFH6qla2qW3cT0=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:10c2:b0:dbd:73bd:e55a with SMTP
 id w2-20020a05690210c200b00dbd73bde55amr1133317ybu.4.1713165258199; Mon, 15
 Apr 2024 00:14:18 -0700 (PDT)
Date: Mon, 15 Apr 2024 07:13:53 +0000
In-Reply-To: <20240415-alice-mm-v5-0-6f55e4d8ef51@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415-alice-mm-v5-0-6f55e4d8ef51@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=15177; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=SoqPn2LPVb+BTP38IpB0LoymmpwLHXDbLBIRx2qwK8A=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmHNPBHO7WqwzbeKC9Qz1KbtF1FhT8jL8Hmg2gQ
 n91Fr4IeoOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZhzTwQAKCRAEWL7uWMY5
 RjWsEAC1nW29kfPewx8tCwQiy7+HkXLiviVtLhUxxUNufpUittkrOOP65Fra1jtpRO+yslVhCuk
 j7CsRdUQjzmLVscuHrIZybxw/MtKAKW5mTtE+olQID2W78hFeus0NNtAWvTszYMxX2rsCUY/EGH
 JcXLdfyxQYYPdqxpA9wbooEKhhwvD+THmC3otpEfAp8eWGmpXOVFh2C0HQnoBUQnCXW/K7J6G6K
 yTrEnoiJhsJsEEC7eB6W8+dSS7NldSM7z+AnY/TLie3FMxtTDhiAhMmjVRtu06kLzEugm2U3U0j
 UQ/HHYGrv/16pb9FZPgt/OwWSYXr3T3gR9bYBoR7pfpTk2bOYEotJeF1PrppuKpCZBAcYFkDrkW
 Nfnd8TUXgIt6SPq7PqGjVbKJ1Bd+Lg31/xp47ZcXDOl/VfUTdv/B0tt654Isn3NOIkjPrhFQEVX
 Ke47rtST9Hf7zpePx2p57C2IykFNfSllyjtGPA3cRDLH504dMI8rdioLue09U2mUdm0/kno87ss
 bJQv4218KT4oVFhxDvka6O+ItO1CzDtbgYVqKmijvH9AdVvHBJJQULal7rlA69iG/LGEuA5in/D
 QzZMxUgLiUJnHMNo9RJibboJ9siWBvzOKfzybv3VJ1YuQE0wVChFUQA1bycUfkSlmFfQMDoiJFA eWhuU2AKk4teOyw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240415-alice-mm-v5-1-6f55e4d8ef51@google.com>
Subject: [PATCH v5 1/4] rust: uaccess: add userspace pointers
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

From: Wedson Almeida Filho <wedsonaf@gmail.com>

A pointer to an area in userspace memory, which can be either read-only
or read-write.

All methods on this struct are safe: attempting to read or write on bad
addresses (either out of the bound of the slice or unmapped addresses)
will return `EFAULT`. Concurrent access, *including data races to/from
userspace memory*, is permitted, because fundamentally another userspace
thread/process could always be modifying memory at the same time (in the
same way that userspace Rust's `std::io` permits data races with the
contents of files on disk). In the presence of a race, the exact byte
values read/written are unspecified but the operation is well-defined.
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
`IoBufferReader` and `IoBufferWriter` traits, and various other changes.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers.c         |  14 +++
 rust/kernel/lib.rs     |   1 +
 rust/kernel/uaccess.rs | 304 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 319 insertions(+)

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
index be68d5e567b1..37f84223b83f 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -49,6 +49,7 @@
 pub mod task;
 pub mod time;
 pub mod types;
+pub mod uaccess;
 pub mod workqueue;
 
 #[doc(hidden)]
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
new file mode 100644
index 000000000000..c97029cdeba1
--- /dev/null
+++ b/rust/kernel/uaccess.rs
@@ -0,0 +1,304 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Slices to user space memory regions.
+//!
+//! C header: [`include/linux/uaccess.h`](srctree/include/linux/uaccess.h)
+
+use crate::{bindings, error::code::*, error::Result};
+use alloc::vec::Vec;
+use core::ffi::{c_ulong, c_void};
+use core::mem::MaybeUninit;
+
+/// A pointer to an area in userspace memory, which can be either read-only or read-write.
+///
+/// All methods on this struct are safe: attempting to read or write on bad addresses (either out of
+/// the bound of the slice or unmapped addresses) will return `EFAULT`. Concurrent access,
+/// *including data races to/from userspace memory*, is permitted, because fundamentally another
+/// userspace thread/process could always be modifying memory at the same time (in the same way that
+/// userspace Rust's [`std::io`] permits data races with the contents of files on disk). In the
+/// presence of a race, the exact byte values read/written are unspecified but the operation is
+/// well-defined. Kernelspace code should validate its copy of data after completing a read, and not
+/// expect that multiple reads of the same address will return the same value.
+///
+/// These APIs are designed to make it difficult to accidentally write TOCTOU (time-of-check to
+/// time-of-use) bugs. Every time a memory location is read, the reader's position is advanced by
+/// the read length and the next read will start from there. This helps prevent accidentally reading
+/// the same location twice and causing a TOCTOU bug.
+///
+/// Creating a [`UserSliceReader`] and/or [`UserSliceWriter`] consumes the `UserSlice`, helping
+/// ensure that there aren't multiple readers or writers to the same location.
+///
+/// If double-fetching a memory location is necessary for some reason, then that is done by creating
+/// multiple readers to the same memory location, e.g. using [`clone_reader`].
+///
+/// # Examples
+///
+/// Takes a region of userspace memory from the current process, and modify it by adding one to
+/// every byte in the region.
+///
+/// ```no_run
+/// use alloc::vec::Vec;
+/// use core::ffi::c_void;
+/// use kernel::error::Result;
+/// use kernel::uaccess::UserSlice;
+///
+/// fn bytes_add_one(uptr: *mut c_void, len: usize) -> Result<()> {
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
+/// fn get_bytes_if_valid(uptr: *mut c_void, len: usize) -> Result<Vec<u8>> {
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
+    /// Constructing a [`UserSlice`] performs no checks on the provided address and length, it can
+    /// safely be constructed inside a kernel thread with no current userspace process. Reads and
+    /// writes wrap the kernel APIs `copy_from_user` and `copy_to_user`, which check the memory map
+    /// of the current process and enforce that the address range is within the user range (no
+    /// additional calls to `access_ok` are needed).
+    ///
+    /// Callers must be careful to avoid time-of-check-time-of-use (TOCTOU) issues. The simplest way
+    /// is to create a single instance of [`UserSlice`] per user memory block as it reads each byte
+    /// at most once.
+    pub fn new(ptr: *mut c_void, length: usize) -> Self {
+        UserSlice { ptr, length }
+    }
+
+    /// Reads the entirety of the user slice, appending it to the end of the provided buffer.
+    ///
+    /// Fails with `EFAULT` if the read happens on a bad address.
+    pub fn read_all(self, buf: &mut Vec<u8>) -> Result {
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
+    /// Usually when this is used, you will first read the data, and then overwrite it afterwards.
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
+        // Update `self.length` first since that's the fallible part of this operation.
+        self.length = self.length.checked_sub(num_skip).ok_or(EFAULT)?;
+        self.ptr = self.ptr.wrapping_byte_add(num_skip);
+        Ok(())
+    }
+
+    /// Create a reader that can access the same range of data.
+    ///
+    /// Reading from the clone does not advance the current reader.
+    ///
+    /// The caller should take care to not introduce TOCTOU issues, as described in the
+    /// documentation for [`UserSlice`].
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
+    /// Reads raw data from the user slice into a kernel buffer.
+    ///
+    /// After a successful call to this method, all bytes in `out` are initialized.
+    ///
+    /// Fails with `EFAULT` if the read happens on a bad address.
+    pub fn read_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> Result {
+        let len = out.len();
+        let out_ptr = out.as_mut_ptr().cast::<c_void>();
+        if len > self.length {
+            return Err(EFAULT);
+        }
+        let Ok(len_ulong) = c_ulong::try_from(len) else {
+            return Err(EFAULT);
+        };
+        // SAFETY: `out_ptr` points into a mutable slice of length `len_ulong`, so we may write
+        // that many bytes to it.
+        let res = unsafe { bindings::copy_from_user(out_ptr, self.ptr, len_ulong) };
+        if res != 0 {
+            return Err(EFAULT);
+        }
+        // Userspace pointers are not directly dereferencable by the kernel, so we cannot use `add`,
+        // which has C-style rules for defined behavior.
+        self.ptr = self.ptr.wrapping_byte_add(len);
+        self.length -= len;
+        Ok(())
+    }
+
+    /// Reads raw data from the user slice into a kernel buffer.
+    ///
+    /// Fails with `EFAULT` if the read happens on a bad address.
+    pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
+        // SAFETY: The types are compatible and `read_raw` doesn't write uninitialized bytes to
+        // `out`.
+        let out = unsafe { &mut *(out as *mut [u8] as *mut [MaybeUninit<u8>]) };
+        self.read_raw(out)
+    }
+
+    /// Reads the entirety of the user slice, appending it to the end of the provided buffer.
+    ///
+    /// Fails with `EFAULT` if the read happens on a bad address.
+    pub fn read_all(mut self, buf: &mut Vec<u8>) -> Result {
+        let len = self.length;
+        buf.try_reserve(len)?;
+
+        // The call to `try_reserve` was successful, so the spare capacity is at least `len` bytes
+        // long.
+        self.read_raw(&mut buf.spare_capacity_mut()[..len])?;
+
+        // SAFETY: Since the call to `read_raw` was successful, so the next `len` bytes of the
+        // vector have been initialized.
+        unsafe { buf.set_len(buf.len() + len) };
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
+    /// Writes raw data to this user pointer from a kernel buffer.
+    ///
+    /// Fails with `EFAULT` if the write happens on a bad address.
+    pub fn write_slice(&mut self, data: &[u8]) -> Result {
+        let len = data.len();
+        let data_ptr = data.as_ptr().cast::<c_void>();
+        if len > self.length {
+            return Err(EFAULT);
+        }
+        let Ok(len_ulong) = c_ulong::try_from(len) else {
+            return Err(EFAULT);
+        };
+        // SAFETY: `data_ptr` points into an immutable slice of length `len_ulong`, so we may read
+        // that many bytes from it.
+        let res = unsafe { bindings::copy_to_user(self.ptr, data_ptr, len_ulong) };
+        if res != 0 {
+            return Err(EFAULT);
+        }
+        // Userspace pointers are not directly dereferencable by the kernel, so
+        // we cannot use `add`, which has C-style rules for defined behavior.
+        self.ptr = self.ptr.wrapping_byte_add(len);
+        self.length -= len;
+        Ok(())
+    }
+}

-- 
2.44.0.683.g7961c838ac-goog


