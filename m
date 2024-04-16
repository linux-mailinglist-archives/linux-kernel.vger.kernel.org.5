Return-Path: <linux-kernel+bounces-146575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F758A677A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0E01C20835
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABA086AC9;
	Tue, 16 Apr 2024 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h5dBHs6r"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62DC86250
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261212; cv=none; b=P78OyCcQH7LyIT/KLGCTIDzb4jDGxYJmIsiQ362c2WlcYHEUVJL9/tTUnxHFOKcZsU74NWCIdqbDdktU9fwJ02mrxxAedC6UhVaB+iVj8SIQM+kHX36aAqq3SnKaNETXrZUydkXQn/cnD9XKj0r1i03JHRBs61ShffZ7Xx3xcVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261212; c=relaxed/simple;
	bh=h9NheVEue+JhBG0K4QwzVbjRCyq3GkoQD2nhq+68u6M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eMlBy3j/7y3ljfIsbE7ku5JLT8pM9IfuyOWlUNuwIw31BgiZcmqVnZj8OG7fI/tPiULJonun3RZnQKuVWogYPWa7Y6VUM5ZNLTs6Z9klru5UtbSQDtYQ0QjIVtTYYl5olgSsu5yZo2s5dDi5UFX+09r7ioh+f7MXPgS9bm7rHlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h5dBHs6r; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6167463c60cso49947597b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 02:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713261210; x=1713866010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+zM/toovgZChd6lSt17rRhWXRLFcTgeeFTkR1bkDyE=;
        b=h5dBHs6rdtWaRGbFBsgLtqhEhJAQVR4V2Lop3tdO1XgC5SeO9aPeTzIjlwiMTGJsuw
         UknSYv6jwDa3j+plvmtZ01MXgloWOJxn0q8HGdzXy4kIQKYYC3K7rHP/RwF2b+tKDbsP
         lFanxKaac9/FVNcfb+0ZfAs7AtCzOmA2/gZnRo/mK8iIVMD+kB5o6tUfm5WYWGCXlxFg
         HIfoxgHHEM5Jv4NfUS1OQ++dXlYWlpvcCyt3BG3N2UjIUaT43a9wcZ+Bri7qqR6XoME3
         GXjaJhFRrt6iF4X8iXm8ql8DIsF7ZmuWadsk/725tVeMZLp1qVeZWDG9+a3QaEQjpUc2
         jYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713261210; x=1713866010;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T+zM/toovgZChd6lSt17rRhWXRLFcTgeeFTkR1bkDyE=;
        b=CPb4D4dY+zBDwPLO5IWvtpw3vJwkyIFobujTCK8aWNzqizSB+Tx4XLcsVslTUxuskA
         +BLGurwoS6zILp5gGTzfT8uc8PqH0l2K363Ehygt/puj4Ab7F8CyQMfbCd0p/9FlU/Bf
         1NUJgIzehHrRtC5WaNL8xT+/LntY/C9rxz8P+/kFFqeE+YvbzMcj/rlO3b9KBYh9rzR1
         Uet02eFqSn3+OyPg7+8DnQzs/aYvExF3jyLROTkefZ4eb7lewAUkTLpXZu0796sbR2JP
         1fleMzuw2mPWxnVzKJCL9YSaT6pOjnuCZOs1XSJBhQBGwSKwdv67CeDE4BppG1PUvfpY
         SkXw==
X-Forwarded-Encrypted: i=1; AJvYcCV08M/jIawCOUpnXi8EpEJpJVXd62/MBEMeUTviVzcUkQaHUKshRbMXJp79ymBmZCECCGqBqqJCjMu85lEGLRHf819fJ3gi//wsJowH
X-Gm-Message-State: AOJu0YyhixwgEzDSDLdTTLvzN+3KhtlNa1DM/yBk6T1IW35IUpsEKYfA
	XUTOHuJp7dMMUj6mEJbZLJeCIWX04gZCPtctvZ/U3tgnkldeb1aElGBgoEzXK2SKBPu2ooVdk3k
	eajNBjLsI2xf6Pw==
X-Google-Smtp-Source: AGHT+IHqpiuhJ/B/pAW+yzXL6D9AWrgYwUHawkxp0orSfwtiF7ApZ+7li+Co9gqRhQKL/XN+D4nrEDtdSip48zs=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a0d:d850:0:b0:618:62d9:5dbb with SMTP id
 a77-20020a0dd850000000b0061862d95dbbmr578543ywe.0.1713261209871; Tue, 16 Apr
 2024 02:53:29 -0700 (PDT)
Date: Tue, 16 Apr 2024 09:53:27 +0000
In-Reply-To: <CALNs47vRk0cKKDkpkhy2XUkxcjtPW-CABUexAZfGZ6PHT=wKng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CALNs47vRk0cKKDkpkhy2XUkxcjtPW-CABUexAZfGZ6PHT=wKng@mail.gmail.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240416095327.1108227-1-aliceryhl@google.com>
Subject: Re: [PATCH v5 1/4] rust: uaccess: add userspace pointers
From: Alice Ryhl <aliceryhl@google.com>
To: tmgross@umich.edu
Cc: a.hindborg@samsung.com, akpm@linux-foundation.org, alex.gaynor@gmail.com, 
	aliceryhl@google.com, arnd@arndb.de, arve@android.com, benno.lossin@proton.me, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org, 
	cmllamas@google.com, gary@garyguo.net, gregkh@linuxfoundation.org, 
	joel@joelfernandes.org, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, maco@android.com, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, surenb@google.com, tkjos@android.com, 
	viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Trevor Gross <tmgross@umich.edu> writes:
> On Mon, Apr 15, 2024 at 3:14=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
>>
>> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>>
>> A pointer to an area in userspace memory, which can be either read-only
>> or read-write.
>>
>> All methods on this struct are safe: attempting to read or write on bad
>> addresses (either out of the bound of the slice or unmapped addresses)
>> will return `EFAULT`. Concurrent access, *including data races to/from
>> userspace memory*, is permitted, because fundamentally another userspace
>> thread/process could always be modifying memory at the same time (in the
>> same way that userspace Rust's `std::io` permits data races with the
>> contents of files on disk). In the presence of a race, the exact byte
>> values read/written are unspecified but the operation is well-defined.
>> Kernelspace code should validate its copy of data after completing a
>> read, and not expect that multiple reads of the same address will return
>> the same value.
>>
>> These APIs are designed to make it difficult to accidentally write
>> TOCTOU bugs. Every time you read from a memory location, the pointer is
>> advanced by the length so that you cannot use that reader to read the
>> same memory location twice. Preventing double-fetches avoids TOCTOU
>> bugs. This is accomplished by taking `self` by value to prevent
>> obtaining multiple readers on a given `UserSlicePtr`, and the readers
>> only permitting forward reads. If double-fetching a memory location is
>> necessary for some reason, then that is done by creating multiple
>> readers to the same memory location.
>>
>> Constructing a `UserSlicePtr` performs no checks on the provided
>> address and length, it can safely be constructed inside a kernel thread
>> with no current userspace process. Reads and writes wrap the kernel APIs
>> `copy_from_user` and `copy_to_user`, which check the memory map of the
>> current process and enforce that the address range is within the user
>> range (no additional calls to `access_ok` are needed).
>>
>> This code is based on something that was originally written by Wedson on
>> the old rust branch. It was modified by Alice by removing the
>> `IoBufferReader` and `IoBufferWriter` traits, and various other changes.
>>
>> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
>> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>=20
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
>=20
> I left some suggestions for documentation improvements and one
> question, but mostly LGTM.

Thanks for taking a look!

>> +impl UserSlice {
>> +    /// Constructs a user slice from a raw pointer and a length in byte=
s.
>> +    ///
>> +    /// Constructing a [`UserSlice`] performs no checks on the provided=
 address and length, it can
>> +    /// safely be constructed inside a kernel thread with no current us=
erspace process. Reads and
>> +    /// writes wrap the kernel APIs `copy_from_user` and `copy_to_user`=
, which check the memory map
>> +    /// of the current process and enforce that the address range is wi=
thin the user range (no
>> +    /// additional calls to `access_ok` are needed).
>=20
> I would just add a note that pointer should be a valid userspace
> pointer, but that gets checked at read/write time

Will do.

>> +    /// Callers must be careful to avoid time-of-check-time-of-use (TOC=
TOU) issues. The simplest way
>> +    /// is to create a single instance of [`UserSlice`] per user memory=
 block as it reads each byte
>> +    /// at most once.
>> +    pub fn new(ptr: *mut c_void, length: usize) -> Self {
>> +        UserSlice { ptr, length }
>> +    }
>=20
>> +impl UserSliceReader {
>> [...]
>> +    /// Reads raw data from the user slice into a kernel buffer.
>> +    ///
>> +    /// After a successful call to this method, all bytes in `out` are =
initialized.
>=20
> If this is guaranteed, could it return `Result<&mut [u8]>`? So the
> caller doesn't need to unsafely `assume_init` anything.

It could, but I don't think it's that useful. All existing callers will
want to record it somewhere with something like `Vec::set_len`, which
this doesn't help with. There are ways to do something like that, but it
complicates the API further which I am not interested in.

>> +    /// Fails with `EFAULT` if the read happens on a bad address.
>=20
> This should also mention that the slice cannot be bigger than the
> reader's length.

I can add a note.
=20
>> +    pub fn read_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> Result {
>> +        let len =3D out.len();
>> +        let out_ptr =3D out.as_mut_ptr().cast::<c_void>();
>> +        if len > self.length {
>> +            return Err(EFAULT);
>> +        }
>> +        let Ok(len_ulong) =3D c_ulong::try_from(len) else {
>> +            return Err(EFAULT);
>> +        };
>> +        // SAFETY: `out_ptr` points into a mutable slice of length `len=
_ulong`, so we may write
>> +        // that many bytes to it.
>> +        let res =3D unsafe { bindings::copy_from_user(out_ptr, self.ptr=
, len_ulong) };
>> +        if res !=3D 0 {
>> +            return Err(EFAULT);
>> +        }
>> +        // Userspace pointers are not directly dereferencable by the ke=
rnel, so we cannot use `add`,
>> +        // which has C-style rules for defined behavior.
>> +        self.ptr =3D self.ptr.wrapping_byte_add(len);
>> +        self.length -=3D len;
>> +        Ok(())
>> +    }
>> +
>> +    /// Reads raw data from the user slice into a kernel buffer.
>> +    ///
>> +    /// Fails with `EFAULT` if the read happens on a bad address.
>> +    pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
>> +        // SAFETY: The types are compatible and `read_raw` doesn't writ=
e uninitialized bytes to
>> +        // `out`.
>> +        let out =3D unsafe { &mut *(out as *mut [u8] as *mut [MaybeUnin=
it<u8>]) };
>> +        self.read_raw(out)
>> +    }
>=20
> If this is just a safe version of read_raw, could you crosslink the docs?

Okay.

>> +impl UserSliceWriter {
>> +
>> +    /// Writes raw data to this user pointer from a kernel buffer.
>> +    ///
>> +    /// Fails with `EFAULT` if the write happens on a bad address.
>> +    pub fn write_slice(&mut self, data: &[u8]) -> Result {
>>   [...]
>> +    }
>=20
> Could use a note about length like `read_raw`.

Okay.

Alice

