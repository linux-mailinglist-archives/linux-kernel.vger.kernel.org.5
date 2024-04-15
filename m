Return-Path: <linux-kernel+bounces-144648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3978A48C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515201F234AE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5D72E84E;
	Mon, 15 Apr 2024 07:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2zL+CSXi"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E892C1B6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165266; cv=none; b=N4onpB4yMUsyuQPFALcpJIfoTN11YCfN1M05BxMGpH8RdGya9OqjVlvu4WfS3vUUv2Xa6atVTVtmXL/btFs6938ymY5sZPfSIWjGppTJHBIPyKg94uSyHDGcC6SP1s5amXqvY8RxlOgQcrcK8taDr5AMdLHgum325AUGcESO894=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165266; c=relaxed/simple;
	bh=BPvxCnQU8QVu2tTG/MzhVBESR9s1ykEepxIFWcgj764=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LFG3ZqUiHEiLIDnEvLe3Jr1IV2qQAjyK6sgwBGFhw75zEA2PTEr1u7dooKw9985JywO6c8weZ19I6zp0gsnoIavbQVy0D7WBUX0etnTyzr5HuULP50Hk9t0thOyItQT93T+HeVYUtcDRIxnxSed44p5cVEr6QGeNJcOjRvAVUUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2zL+CSXi; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6187588d2a7so57446897b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 00:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713165264; x=1713770064; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MhdlP5JlKNtstcGdifj2bRw8BnPpw/8WvVvi1+ODuPA=;
        b=2zL+CSXiiPi9mWI5T76GGUcKzcDRjhAgDcdfB6JYXDiU5MYNwthHmEzghkHlRxCUpp
         9a9hN6wpuNabLa9lRD5Z/h1+GIRya4bYSRv3L1rTkyuGWCzyfalYzyAyJhlUlw+Zsqmn
         lW4B0iu8/0vKj65y+ZyleYKLiYVNIKoAp24n1XFJEnxfkKMSWFDMq6LE/d9HSYVeNF9A
         HWOT1MOFbtiGeTPp3j+wdGkgo1Kj4PS7NmESSqYieD8cnhfQIZQqsdORp+Lc06FYIZ2K
         qqGK1UN0EuZRSaV0vJfDM/RqgaqD1975FUAlYxyxhUBeQo7S4fd3U9O88m74UYwpbiIy
         Y+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713165264; x=1713770064;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MhdlP5JlKNtstcGdifj2bRw8BnPpw/8WvVvi1+ODuPA=;
        b=lGb6uaVAclE4Z80fz2iBDqTh2/wGxn4yK+z8BZVhIDaBe4j6tv9F51JKL5zIFopQrf
         E3m+AVVvShRus+txNT8AEOmUQoGROpbXdSaM5eQnqgUgCgZ0G9ae5PGCDwo6LAj528FR
         DiOWQsnx1OFXexLHIuYmRy4uHQdBSv8glTzWE44pf2o7ZexM48jJyWSt352Fb6v0NlBH
         88RW1X/HSiF/VQiH3LBkKA/dBaBTRVjz5ZebV3S81qBjAIhy2oLNo+IFY87kP5Zodve2
         KUpQHWmjSxIlsYxNdri3qCTRzB6N50BgSdMLxjbCSxYcPNPeB3SaHIfjUxQZEj5sGbxM
         2nvg==
X-Forwarded-Encrypted: i=1; AJvYcCV+wszhEGBQSYAZ0RY4V+W5kK4r1KfH6tN+dwFIW4fuk288BrLTR87tGXd3jxIVhrUt/9zzf9ISJWg9WR8xrStcDVseL5rJnX6SdPA+
X-Gm-Message-State: AOJu0YzLPQ4iRzSO9/etL7SFUano6V2i/uAaAaGOm6t1BREXJW2b8RxI
	dbEtSvwZOSZG2/8zA/eISIGzMcMvqQb/2ARl4Jn+tYRMlaMvellPa5SVOfxMq03Uoq/dAGi+Yg6
	8mzquOt95hceOHA==
X-Google-Smtp-Source: AGHT+IHwi6w0lDXo5tZreR0tVkBy1RTj7mLjFE+yjLToXnPFfw726W8T3Ei3bLcl/Sjj7d4uVRnPuHJYNVD4lW0=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1502:b0:dc7:49a9:6666 with SMTP
 id q2-20020a056902150200b00dc749a96666mr3155257ybu.3.1713165264142; Mon, 15
 Apr 2024 00:14:24 -0700 (PDT)
Date: Mon, 15 Apr 2024 07:13:55 +0000
In-Reply-To: <20240415-alice-mm-v5-0-6f55e4d8ef51@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415-alice-mm-v5-0-6f55e4d8ef51@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8745; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=BPvxCnQU8QVu2tTG/MzhVBESR9s1ykEepxIFWcgj764=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmHNPCpIenedGq5y7NqOIo3z3RQyWrBzGEt1gNy
 6aXpXjCwQWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZhzTwgAKCRAEWL7uWMY5
 Rk10D/9rglwh8dFgKcRzxbw+8GX1BZNX08YZpvZd/17rL32smdZiZTKPJd75K2m/Uw2pN+V6Zmd
 UvNUMMkIUcPwF8PpoPJcm0hhQQ2sj1A2yS6Kcr2CXrGkj9E4xdH3I+2hY+6UQqiKXYHS13XwenS
 rSQ5sgsLOkGh3CgtKyd+52Dptr5ZdGAjugEmG5uP/m2ZwBX+JecqZcTCROMyO/mgZvD0EoMoy29
 wLiOeA1yWDMq0+Tnm0xmUIgX3wmgm7kHxa0rnK1CMapZ7o/fwXC7BsDTiQTOlR9jgei0FBGeMVo
 wUbt7E9pHZMGIY3y8lIUxcrsu8fOvAr3FVAGazwWYIUCp5dB1JMZFQd3FWdMSFA+Ivbz//PS/XG
 sI/GrjEhtjJKAnmaoV5KlkXr0EvIZFEdFp+LU3T35weYFXrkaVM2Wz/HuTKoW6e+R7m2EZyRsks
 LF1s5nNZMpli7Aae4sXdVvkRrHtJP9adKd8cr7v9WtK7+VLE/K8uqbu264A/KUskT9wkFduxdbO
 3SV3bWG6uARUGmgJLvJYoaCuQl3wS36vsQVeBlV/EJiYZvo7bm7I20ejyJuXFjH8cpNw6lrBL68
 +JDQthtx6tOI8tOa2+Q6fZgRVERlT8kyZ5cYmtwEyTPq+Bvi2odqaqrtdV4Wn6ikMAcXyTI9RyK oSV1ESaJlxi79Jg==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240415-alice-mm-v5-3-6f55e4d8ef51@google.com>
Subject: [PATCH v5 3/4] rust: uaccess: add typed accessors for userspace pointers
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
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/types.rs   | 63 ++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/uaccess.rs | 71 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 132 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index aa77bad9bce4..414ba602fc5b 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -409,3 +409,66 @@ pub enum Either<L, R> {
     /// Constructs an instance of [`Either`] containing a value of type `R`.
     Right(R),
 }
+
+/// Types for which any bit pattern is valid.
+///
+/// Not all types are valid for all values. For example, a `bool` must be either zero or one, so
+/// reading arbitrary bytes into something that contains a `bool` is not okay.
+///
+/// It's okay for the type to have padding, as initializing those bytes has no effect.
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
+// SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
+// patterns are also acceptable for arrays of that type.
+unsafe impl<T: FromBytes> FromBytes for [T] {}
+unsafe impl<T: FromBytes, const N: usize> FromBytes for [T; N] {}
+
+/// Types that can be viewed as an immutable slice of initialized bytes.
+///
+/// If a struct implements this trait, then it is okay to copy it byte-for-byte to userspace. This
+/// means that it should not have any padding, as padding bytes are uninitialized. Reading
+/// uninitialized memory is not just undefined behavior, it may even lead to leaking sensitive
+/// information on the stack to userspace.
+///
+/// The struct should also not hold kernel pointers, as kernel pointer addresses are also considered
+/// sensitive. However, leaking kernel pointers is not considered undefined behavior by Rust, so
+/// this is a correctness requirement, but not a safety requirement.
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
+// SAFETY: If individual values in an array have no uninitialized portions, then the array itself
+// does not have any uninitialized portions either.
+unsafe impl<T: AsBytes> AsBytes for [T] {}
+unsafe impl<T: AsBytes, const N: usize> AsBytes for [T; N] {}
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index c97029cdeba1..e3953eec61a3 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -4,10 +4,15 @@
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
-use core::mem::MaybeUninit;
+use core::mem::{size_of, MaybeUninit};
 
 /// A pointer to an area in userspace memory, which can be either read-only or read-write.
 ///
@@ -238,6 +243,38 @@ pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
         self.read_raw(out)
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
+        // By using the _copy_from_user variant, we skip the check_object_size check that verifies
+        // the kernel pointer. This mirrors the logic on the C side that skips the check when the
+        // length is a compile-time constant.
+        let res = unsafe {
+            bindings::_copy_from_user(out.as_mut_ptr().cast::<c_void>(), self.ptr, len_ulong)
+        };
+        if res != 0 {
+            return Err(EFAULT);
+        }
+        // Since this is not a pointer to a valid object in our program, we cannot use `add`, which
+        // has C-style rules for defined behavior.
+        self.ptr = self.ptr.wrapping_byte_add(len);
+        self.length -= len;
+        // SAFETY: The read above has initialized all bytes in `out`, and since `T` implements
+        // `FromBytes`, any bit-pattern is a valid value for this type.
+        Ok(unsafe { out.assume_init() })
+    }
+
     /// Reads the entirety of the user slice, appending it to the end of the provided buffer.
     ///
     /// Fails with `EFAULT` if the read happens on a bad address.
@@ -301,4 +338,34 @@ pub fn write_slice(&mut self, data: &[u8]) -> Result {
         self.length -= len;
         Ok(())
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
+        // SAFETY: The reference points to a value of type `T`, so it is valid for reading
+        // `size_of::<T>()` bytes.
+        //
+        // By using the _copy_to_user variant, we skip the check_object_size check that verifies the
+        // kernel pointer. This mirrors the logic on the C side that skips the check when the length
+        // is a compile-time constant.
+        let res = unsafe {
+            bindings::_copy_to_user(self.ptr, (value as *const T).cast::<c_void>(), len_ulong)
+        };
+        if res != 0 {
+            return Err(EFAULT);
+        }
+        // Since this is not a pointer to a valid object in our program, we cannot use `add`, which
+        // has C-style rules for defined behavior.
+        self.ptr = self.ptr.wrapping_byte_add(len);
+        self.length -= len;
+        Ok(())
+    }
 }

-- 
2.44.0.683.g7961c838ac-goog


