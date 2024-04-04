Return-Path: <linux-kernel+bounces-132107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F6A898FC0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326B71C21ADD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF3913A247;
	Thu,  4 Apr 2024 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="f2cNO35/"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D801E868;
	Thu,  4 Apr 2024 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712263235; cv=none; b=NQ8C+zx3pjrFcb2EAmzD2CckFuITNqSLUswnZws29CZwpfe1iV83yPFIzanBFI2/A7Uzrl4o4AIkRUq5rls7p0bqF1Ya7WNcQJSGGJ7yxo45BIkij7UAjs3DhCheiXk7d05EhxgXBCm8SMOl/3XxBj3U08V4dnZatzCxD3kjWms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712263235; c=relaxed/simple;
	bh=yd3e8gE922eYsYs1vuWFayYKG3OJqH7isnN00dFQavQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TMuHLbdf3gx9L3WpAn7w1d3j9zLJr6l/NZyKaMUQH165v7xjl/KuBRZ6A5l1fqhVD32nbh/eJPnV6mWxswvXT8AwA0RaEJZDPx+RJHpWnioGSmXkfbCKIiAcVLOi4DmU6BoswfOo5fFo56hTWs0JBOcDrlpwjeG5ivIj5/cUzm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=f2cNO35/; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712263229; x=1712522429;
	bh=/r2dqqHabl6s0yl9bFd2ZPmBVmtjU4+UW6w3beXmG14=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=f2cNO35/R2nxiVhhEcnbzWuJBmvLAaPKSihWgXgw9Dx4EeXN1Tkn2Tq4Z9usRC5wr
	 ewf4R20al1GzRJoZwnVK7wzD5w+uHnpLlJdmFe+OgmvEgCYdST1V/DeScMqB9F1N8m
	 8NhAu8VHcp7rEpYi7wlYDFNbQfSk/ZwzO8D4q3aCJTO1HywnZPt4icfwQ/4EROBX/f
	 fMyHzaealHFwMNPb8Oi7iN5sCHkgVor5N2rTJ6wit6GAPgzr2lsFn17Qhe4YjVtqYy
	 SZgPBqdlP/0dB7c9IdjVdcwCq1szysQ9mnrf7LFews4x33uDN2WTND0k4WqxJFZd5H
	 yg/CclUuyGBxw==
Date: Thu, 04 Apr 2024 20:40:20 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 1/4] rust: uaccess: add userspace pointers
Message-ID: <d0558622-c287-4efd-8ed9-0b2cf15d7c1a@proton.me>
In-Reply-To: <20240404-alice-mm-v4-1-49a84242cf02@google.com>
References: <20240404-alice-mm-v4-0-49a84242cf02@google.com> <20240404-alice-mm-v4-1-49a84242cf02@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.04.24 14:31, Alice Ryhl wrote:
> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> new file mode 100644
> index 000000000000..3f8ad4dc13c4
> --- /dev/null
> +++ b/rust/kernel/uaccess.rs
> @@ -0,0 +1,311 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Slices to user space memory regions.
> +//!
> +//! C header: [`include/linux/uaccess.h`](srctree/include/linux/uaccess.=
h)
> +
> +use crate::{bindings, error::code::*, error::Result};
> +use alloc::vec::Vec;
> +use core::ffi::{c_ulong, c_void};
> +use core::mem::MaybeUninit;
> +
> +/// A pointer to an area in userspace memory, which can be either read-o=
nly or
> +/// read-write.
> +///
> +/// All methods on this struct are safe: attempting to read or write on =
bad
> +/// addresses (either out of the bound of the slice or unmapped addresse=
s) will
> +/// return `EFAULT`. Concurrent access, *including data races to/from us=
erspace
> +/// memory*, is permitted, because fundamentally another userspace
> +/// thread/process could always be modifying memory at the same time (in=
 the
> +/// same way that userspace Rust's [`std::io`] permits data races with t=
he
> +/// contents of files on disk). In the presence of a race, the exact byt=
e values
> +/// read/written are unspecified but the operation is well-defined. Kern=
elspace
> +/// code should validate its copy of data after completing a read, and n=
ot
> +/// expect that multiple reads of the same address will return the same =
value.
> +///
> +/// These APIs are designed to make it difficult to accidentally write T=
OCTOU
> +/// (time-of-check to time-of-use) bugs. Every time a memory location is=
 read,
> +/// the reader's position is advanced by the read length and the next re=
ad will
> +/// start from there. This helps prevent accidentally reading the same l=
ocation
> +/// twice and causing a TOCTOU bug.
> +///
> +/// Creating a [`UserSliceReader`] and/or [`UserSliceWriter`] consumes t=
he
> +/// `UserSlice`, helping ensure that there aren't multiple readers or wr=
iters to
> +/// the same location.
> +///
> +/// If double-fetching a memory location is necessary for some reason, t=
hen that
> +/// is done by creating multiple readers to the same memory location, e.=
g. using
> +/// [`clone_reader`].

I think we should have consistent 100 column formatting. And not
something less.

> +///
> +/// # Examples

[...]

> +    /// Reads raw data from the user slice into a kernel buffer.
> +    ///
> +    /// Fails with `EFAULT` if the read happens on a bad address.
> +    pub fn read_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> Result {
> +        let len =3D out.len();
> +        let out_ptr =3D out.as_mut_ptr().cast::<c_void>();
> +        if len > self.length {
> +            return Err(EFAULT);
> +        }
> +        let Ok(len_ulong) =3D c_ulong::try_from(len) else {
> +            return Err(EFAULT);
> +        };
> +        // SAFETY: The caller promises that `out` is valid for writing `=
len` bytes.

This comment needs updating.

> +        let res =3D unsafe { bindings::copy_from_user(out_ptr, self.ptr,=
 len_ulong) };
> +        if res !=3D 0 {
> +            return Err(EFAULT);
> +        }
> +        // Userspace pointers are not directly dereferencable by the ker=
nel, so
> +        // we cannot use `add`, which has C-style rules for defined beha=
vior.
> +        self.ptr =3D self.ptr.wrapping_byte_add(len);
> +        self.length -=3D len;
> +        Ok(())
> +    }
> +
> +    /// Reads raw data from the user slice into a kernel buffer.
> +    ///
> +    /// Fails with `EFAULT` if the read happens on a bad address.
> +    pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
> +        // SAFETY: The types are compatible and `read_raw` doesn't write
> +        // uninitialized bytes to `out`.

Can you add this as a guarantee to `read_raw`?

> +        let out =3D unsafe { &mut *(out as *mut [u8] as *mut [MaybeUnini=
t<u8>]) };
> +        self.read_raw(out)
> +    }
> +
> +    /// Reads the entirety of the user slice, appending it to the end of=
 the
> +    /// provided buffer.
> +    ///
> +    /// Fails with `EFAULT` if the read happens on a bad address.
> +    pub fn read_all(mut self, buf: &mut Vec<u8>) -> Result {
> +        let len =3D self.length;
> +        buf.try_reserve(len)?;
> +
> +        // The call to `try_reserve` was successful, so the spare capaci=
ty is at
> +        // least `len` bytes long.
> +        self.read_raw(&mut buf.spare_capacity_mut()[..len])?;
> +
> +        // SAFETY: Since the call to `read_raw` was successful, so the n=
ext
> +        // `len` bytes of the vector have been initialized.
> +        unsafe { buf.set_len(buf.len() + len) };
> +        Ok(())
> +    }
> +}
> +
> +/// A writer for [`UserSlice`].
> +///
> +/// Used to incrementally write into the user slice.
> +pub struct UserSliceWriter {
> +    ptr: *mut c_void,
> +    length: usize,
> +}
> +
> +impl UserSliceWriter {
> +    /// Returns the amount of space remaining in this buffer.
> +    ///
> +    /// Note that even writing less than this number of bytes may fail.
> +    pub fn len(&self) -> usize {
> +        self.length
> +    }
> +
> +    /// Returns `true` if no more data can be written to this buffer.
> +    pub fn is_empty(&self) -> bool {
> +        self.length =3D=3D 0
> +    }
> +
> +    /// Writes raw data to this user pointer from a kernel buffer.
> +    ///
> +    /// Fails with `EFAULT` if the write happens on a bad address.
> +    pub fn write_slice(&mut self, data: &[u8]) -> Result {
> +        let len =3D data.len();
> +        let data_ptr =3D data.as_ptr().cast::<c_void>();
> +        if len > self.length {
> +            return Err(EFAULT);
> +        }
> +        let Ok(len_ulong) =3D c_ulong::try_from(len) else {
> +            return Err(EFAULT);
> +        };
> +        let res =3D unsafe { bindings::copy_to_user(self.ptr, data_ptr, =
len_ulong) };

Missing SAFETY comment.

--=20
Cheers,
Benno

> +        if res !=3D 0 {
> +            return Err(EFAULT);
> +        }
> +        // Userspace pointers are not directly dereferencable by the ker=
nel, so
> +        // we cannot use `add`, which has C-style rules for defined beha=
vior.
> +        self.ptr =3D self.ptr.wrapping_byte_add(len);
> +        self.length -=3D len;
> +        Ok(())
> +    }
> +}
>=20
> --
> 2.44.0.478.gd926399ef9-goog
>=20


