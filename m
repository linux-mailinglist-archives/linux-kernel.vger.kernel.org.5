Return-Path: <linux-kernel+bounces-98718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5C5877E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7745F1F211BA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD3E3CF6A;
	Mon, 11 Mar 2024 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KxXm+C1z"
Received: from mail-lf1-f74.google.com (mail-lf1-f74.google.com [209.85.167.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15153BB4D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154054; cv=none; b=QFtBXrcOG5BJyiUP31lM9TpZNJ6HymSggdKFvYLgrojWA2HyxckHa+Xyzvma9LvqfXwCHiGtNPKvt5tguLPfm0hHCwrkCefAYytjLP9T+Ba97t9amtP4zvc+wp24a/J4UpdKrynvEnQaVOleD3wdiLXfFZNSepJeLqYZbUOmfkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154054; c=relaxed/simple;
	bh=O8zC2lgk3iljbnvk5ax/PRPoOoGfwC7mnB92Tq28bps=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=usyCx+8tbnuhpcdyfKKU5/OGQ7TRQo+hIejGXI8Y89GniEj3bC73Rw4dqIpOH5CCecmrDPD1xHLZDe/TbMtMBoty7PemLoRhwOQiUdYf0qCwTsRWfipl0qx1QwbfVg45vm2ZMdl5s6zfRKaA+78LPrfGuGWYhw5TDBf8IKv89Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KxXm+C1z; arc=none smtp.client-ip=209.85.167.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f74.google.com with SMTP id 2adb3069b0e04-5133f5243d7so3018223e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 03:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710154050; x=1710758850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2c6bMPArnt8D9kdvoHKALHQQ9grE3IbZuTFkAk5bFxs=;
        b=KxXm+C1zM+BJT24yPUqSUojR+UA9ZCvpjFyG/1GA7rYor1F12HKR3s0kUOfEh76NZr
         Ka+97OdnYgZ0kXIb7c/rWetIv/QAuaiE+NyiiWmWoFhKw8gL3W6E9JDxjBoPO2/aE3Q2
         EmAZCnC5n4WTRHSo7NrH1hwBKmMZ4ByHvADwyLtbjPDfWUVr0E0fyD6WnfAAhyt+HgPz
         4WRbhTcyeaxa+6gwP2l/BbcUQ0INf3qF4rQ9wXmdjzgUMkUHOKPOtowAsR+kGjJdsTxr
         v/Gm14Qg80MNS8/lDb6ur3alLk8F50s3jvQUoq1bWaCsyCNOO6liB2i0ifAAa+i3mzSO
         nhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710154050; x=1710758850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2c6bMPArnt8D9kdvoHKALHQQ9grE3IbZuTFkAk5bFxs=;
        b=rZuiie9cbbmkTtjkIRW/uEbmQs1NQ2i2FTz00lu3KdilHG1lmitxoXN5W6DfG+apjV
         WpeKi1FrLFN4YAPNw+HaZ1VoCxpkV50tzibNarSRw4tCpVdCDdNEerW5dnmFFShPBrI6
         Y0egKaWJ6Dq6O4VNNVK4hsnXg1v0JQsSHwedrHFSHQeb9Lipssyv0ej5mPQ1OocqNSIi
         YY+A7qDpil18b9H60Gk0tS0eHTlrLFahwx1tPV1SsHV4SAH9cd+qVKvpwR5hAniPDTyO
         Fdc5BLolgYHCY7dRt9NlRMq5FdVfOgFKtqfWhuKFa20a1MLRztVM4DPkc1hSGQTeAJSV
         7wYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCia2EvsCVLnDgYpQwZcPZcCUPbF8UL2Qf5AdvOGglfMO5TB2X2g0wC7TRWfo/pxFl2OzFl11mZcz0lB7LnAD5KFuvwB1HCenOupRP
X-Gm-Message-State: AOJu0Yy1C5fyfbtPMVZOL8BGlwoJR0+Tt6SKNGLzsClXOS4KAZv9iuNK
	aSh1jegzC/SIsl+qntwiRfRKkgVFsB/2vhCYPkijzi3c7rxHINZYN9KHM2FrJiR2bZjqMKDTGXD
	narYgG7cM1nTQwA==
X-Google-Smtp-Source: AGHT+IF2Vt5V8eujOxNumBXozXKhQ/7eLs0zX0F5tRH0T9iuVNAdf86I2d84KVYWqXVZsAGntbB8mh+8UU6oXgA=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:251e:b0:513:b15a:c2b7 with SMTP
 id be30-20020a056512251e00b00513b15ac2b7mr610lfb.6.1710154049688; Mon, 11 Mar
 2024 03:47:29 -0700 (PDT)
Date: Mon, 11 Mar 2024 10:47:15 +0000
In-Reply-To: <20240311-alice-mm-v3-0-cdf7b3a2049c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240311-alice-mm-v3-0-cdf7b3a2049c@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8715; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=O8zC2lgk3iljbnvk5ax/PRPoOoGfwC7mnB92Tq28bps=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBl7uE0gI7mwBhBKAktav0IYVr2x44RfFVlQeCJ/
 r5KHT4GM4SJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZe7hNAAKCRAEWL7uWMY5
 RgDaD/9CIQWLbBRhAR+VU/Z4XfgkfK+S6xaMQ0IxoLJqhiaETkwMy/uyjInFXb6u7diGVZTH+9k
 du+csjmxKR4IFkHrC+1NSlR83gaONd+HvAsrt6cZLrmXvGkT0DssMzwlW0RG6o/cFPaQ+OaEl8K
 kWsSiIv9CkYMGvG93ScxhlagwGgyLrWQ6AYxuDr3W9Fvfqtuf2NIQ2K72VXUk2EmBE2b696F5h7
 /M3NUihppcd/bjMJDlq7vxRZ/1msuLZTucpotKSoRYdGKhgLMetCWmZDWRDZFKXCFHqoxwOZ88e
 0ChUkKfBrmf+XbhsNE2vO6cYbGElVfaVT+URBjbP4o876YOg8VAJIN7stWYWJA744W1dlQxi+9H
 Uf/5U2FIf3R4wwSFXfw9EjUFQyTrRio9xzEHgiFWg1USMdFmNXf7UTYyOmyPr3EHjxu5IW4V0S+
 75CFlA6FeNtV1opclUn/2ScgG7h2BeFPKTlur/eyYkEzGO/fturmuluG35NO+gOFe0STlw8HELK
 b1DpVGvIzBBzmymt4nOjuFiYlgZMjFYzn4nwL5l8UJn8j1j1OtCl1xZoZh1gtk1CV00GrcuEpq8
 Qp68iEbRP8iBY8W5U1kNYAh2VgX5kmri2Sch7c6W3pp7GWgoGZ0DP/G7aPhQb86ZU6HEbEpoiue nrg/PIkXQyJQnvQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240311-alice-mm-v3-3-cdf7b3a2049c@google.com>
Subject: [PATCH v3 3/4] rust: uaccess: add typed accessors for userspace pointers
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

Add safe methods for reading and writing Rust values to and from
userspace pointers.

The C methods for copying to/from userspace use a function called
`check_object_size` to verify that the kernel pointer is not dangling.
However, this check is skipped when the length is a compile-time
constant, with the assumption that such cases trivially have a correct
kernel pointer.

In this patch, we apply the same optimization to the typed accessors.
For both methods, the size of the operation is known at compile time to
be size_of of the type being read or written. Since the C side doesn't
provide a variant that skips only this check, we create custom helpers
for this purpose.

The majority of reads and writes to userspace pointers in the Rust
Binder driver uses these accessor methods. Benchmarking has found that
skipping the `check_object_size` check makes a big difference for the
cases being skipped here. (And that the check doesn't make a difference
for the cases that use the raw read/write methods.)

This code is based on something that was originally written by Wedson on
the old rust branch. It was modified by Alice to skip the
`check_object_size` check, and to update various comments, including the
notes about kernel pointers in `WritableToBytes`.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/types.rs   | 67 ++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/uaccess.rs | 75 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index aa77bad9bce4..f72b82efdbfa 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -409,3 +409,70 @@ pub enum Either<L, R> {
     /// Constructs an instance of [`Either`] containing a value of type `R`.
     Right(R),
 }
+
+/// Types for which any bit pattern is valid.
+///
+/// Not all types are valid for all values. For example, a `bool` must be either
+/// zero or one, so reading arbitrary bytes into something that contains a
+/// `bool` is not okay.
+///
+/// It's okay for the type to have padding, as initializing those bytes has no
+/// effect.
+///
+/// # Safety
+///
+/// All bit-patterns must be valid for this type.
+pub unsafe trait FromBytes {}
+
+// SAFETY: All bit patterns are acceptable values of the types below.
+unsafe impl FromBytes for u8 {}
+unsafe impl FromBytes for u16 {}
+unsafe impl FromBytes for u32 {}
+unsafe impl FromBytes for u64 {}
+unsafe impl FromBytes for usize {}
+unsafe impl FromBytes for i8 {}
+unsafe impl FromBytes for i16 {}
+unsafe impl FromBytes for i32 {}
+unsafe impl FromBytes for i64 {}
+unsafe impl FromBytes for isize {}
+// SAFETY: If all bit patterns are acceptable for individual values in an array,
+// then all bit patterns are also acceptable for arrays of that type.
+unsafe impl<T: FromBytes> FromBytes for [T] {}
+unsafe impl<T: FromBytes, const N: usize> FromBytes for [T; N] {}
+
+/// Types that can be viewed as an immutable slice of initialized bytes.
+///
+/// If a struct implements this trait, then it is okay to copy it byte-for-byte
+/// to userspace. This means that it should not have any padding, as padding
+/// bytes are uninitialized. Reading uninitialized memory is not just undefined
+/// behavior, it may even lead to leaking sensitive information on the stack to
+/// userspace.
+///
+/// The struct should also not hold kernel pointers, as kernel pointer addresses
+/// are also considered sensitive. However, leaking kernel pointers is not
+/// considered undefined behavior by Rust, so this is a correctness requirement,
+/// but not a safety requirement.
+///
+/// # Safety
+///
+/// Values of this type may not contain any uninitialized bytes.
+pub unsafe trait AsBytes {}
+
+// SAFETY: Instances of the following types have no uninitialized portions.
+unsafe impl AsBytes for u8 {}
+unsafe impl AsBytes for u16 {}
+unsafe impl AsBytes for u32 {}
+unsafe impl AsBytes for u64 {}
+unsafe impl AsBytes for usize {}
+unsafe impl AsBytes for i8 {}
+unsafe impl AsBytes for i16 {}
+unsafe impl AsBytes for i32 {}
+unsafe impl AsBytes for i64 {}
+unsafe impl AsBytes for isize {}
+unsafe impl AsBytes for bool {}
+unsafe impl AsBytes for char {}
+unsafe impl AsBytes for str {}
+// SAFETY: If individual values in an array have no uninitialized portions, then
+// the array itself does not have any uninitialized portions either.
+unsafe impl<T: AsBytes> AsBytes for [T] {}
+unsafe impl<T: AsBytes, const N: usize> AsBytes for [T; N] {}
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 020f3847683f..72d55b2b33c9 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -4,9 +4,15 @@
 //!
 //! C header: [`include/linux/uaccess.h`](srctree/include/linux/uaccess.h)
 
-use crate::{bindings, error::code::*, error::Result};
+use crate::{
+    bindings,
+    error::code::*,
+    error::Result,
+    types::{AsBytes, FromBytes},
+};
 use alloc::vec::Vec;
 use core::ffi::{c_ulong, c_void};
+use core::mem::{size_of, MaybeUninit};
 
 /// A pointer to an area in userspace memory, which can be either read-only or
 /// read-write.
@@ -237,6 +243,41 @@ pub unsafe fn read_raw(&mut self, out: *mut u8, len: usize) -> Result {
         Ok(())
     }
 
+    /// Reads a value of the specified type.
+    ///
+    /// Fails with `EFAULT` if the read encounters a page fault.
+    pub fn read<T: FromBytes>(&mut self) -> Result<T> {
+        let len = size_of::<T>();
+        if len > self.length {
+            return Err(EFAULT);
+        }
+        let Ok(len_ulong) = c_ulong::try_from(len) else {
+            return Err(EFAULT);
+        };
+        let mut out: MaybeUninit<T> = MaybeUninit::uninit();
+        // SAFETY: The local variable `out` is valid for writing `size_of::<T>()` bytes.
+        //
+        // By using the _copy_from_user variant, we skip the check_object_size
+        // check that verifies the kernel pointer. This mirrors the logic on the
+        // C side that skips the check when the length is a compile-time
+        // constant.
+        let res = unsafe {
+            bindings::_copy_from_user(out.as_mut_ptr().cast::<c_void>(), self.ptr, len_ulong)
+        };
+        if res != 0 {
+            return Err(EFAULT);
+        }
+        // Since this is not a pointer to a valid object in our program,
+        // we cannot use `add`, which has C-style rules for defined
+        // behavior.
+        self.ptr = self.ptr.wrapping_byte_add(len);
+        self.length -= len;
+        // SAFETY: The read above has initialized all bytes in `out`, and since
+        // `T` implements `FromBytes`, any bit-pattern is a valid value for this
+        // type.
+        Ok(unsafe { out.assume_init() })
+    }
+
     /// Reads the entirety of the user slice, appending it to the end of the
     /// provided buffer.
     ///
@@ -312,4 +353,36 @@ pub fn write_slice(&mut self, data: &[u8]) -> Result {
         // `len`, so the pointer is valid for reading `len` bytes.
         unsafe { self.write_raw(ptr, len) }
     }
+
+    /// Writes the provided Rust value to this userspace pointer.
+    ///
+    /// Fails with `EFAULT` if the write encounters a page fault.
+    pub fn write<T: AsBytes>(&mut self, value: &T) -> Result {
+        let len = size_of::<T>();
+        if len > self.length {
+            return Err(EFAULT);
+        }
+        let Ok(len_ulong) = c_ulong::try_from(len) else {
+            return Err(EFAULT);
+        };
+        // SAFETY: The reference points to a value of type `T`, so it is valid
+        // for reading `size_of::<T>()` bytes.
+        //
+        // By using the _copy_to_user variant, we skip the check_object_size
+        // check that verifies the kernel pointer. This mirrors the logic on the
+        // C side that skips the check when the length is a compile-time
+        // constant.
+        let res = unsafe {
+            bindings::_copy_to_user(self.ptr, (value as *const T).cast::<c_void>(), len_ulong)
+        };
+        if res != 0 {
+            return Err(EFAULT);
+        }
+        // Since this is not a pointer to a valid object in our program,
+        // we cannot use `add`, which has C-style rules for defined
+        // behavior.
+        self.ptr = self.ptr.wrapping_byte_add(len);
+        self.length -= len;
+        Ok(())
+    }
 }

-- 
2.44.0.278.ge034bb2e1d-goog


