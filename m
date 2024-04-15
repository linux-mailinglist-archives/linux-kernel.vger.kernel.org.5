Return-Path: <linux-kernel+bounces-144868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476568A4BFC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2FC82889F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAD245959;
	Mon, 15 Apr 2024 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="H4m/cOlC"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692B14E1A0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174753; cv=none; b=lQm7lDfBp31cC93I1PhQVok0ZFdAKIUruxmZohqFlswSrKopkrCJ1TD5uRShEKhmd88d6X40vhGAxo2KsHZv2caiSPMw4ovm9DPHHk/msISrg2fPWOzwcAZJJtxx2Rbmsqz3KpgS7yL6W3o+n8OeUnnzDqVprnQqJzNKcST6RvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174753; c=relaxed/simple;
	bh=wRVTJ0UbYbZDQRp6UEkosuQ5Xv/tRLFqmEIuhSEGVu4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/GCWmwUfw++Xybri/j0LHXsYgK6K78xiRLfVT2ehvyBl3quqPoqqSHG1SZnuTMtRJUo20ebtjcGRtlIxfjJC4QRDiOdRB1IiuyPlQ6ifHxrgcKXZ2Dl1bbajuMS+JOQ3k1I31zB1w0dvk/lbx9wI4zqaTP9p1K+HXtKSDQp8/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=H4m/cOlC; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1713174736; x=1713433936;
	bh=c6ckz4hhAbktVZkF1RuxUbUmw/jaVAkQ7dsloKnHX8M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=H4m/cOlCahXLO+0GLUL9cXxPqoObTqJqbMgZaX0TOJbG4YwQf5PO4XUDPkJ7/d85Y
	 1z6MlUat8q+X7wyjRBLEpLI86mo77Iir0TCVWoiiyaVSK7GTVSITXAhnpFYJrx5G9L
	 5VwJ7e2Vecmjew40OzAOwZ3W/RLVqQAbhRISYnsBhDpt+i91x37qze+C/S8arERy2v
	 NARZhDhUhivIqHZ+LHnxFbfWJsXvzgWoNrEDFfHZF66n8uxgU1Um0Kg/G3c0ULZCQr
	 dJds5xaHflmkLw+dKiWj2w/RIBKaJegRspfuavfuEWEshLTJNpskEsxbQAECMBfV3Y
	 QNOmEt1kDxQRg==
Date: Mon, 15 Apr 2024 09:51:47 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v5 1/4] rust: uaccess: add userspace pointers
Message-ID: <36c22716-ba41-46e0-8e18-991f1a14b208@proton.me>
In-Reply-To: <CAH5fLgjT3hAdtdNeb7FgX491UhvMGa-JHevz_EqC=N4zVViBjw@mail.gmail.com>
References: <20240415-alice-mm-v5-0-6f55e4d8ef51@google.com> <20240415-alice-mm-v5-1-6f55e4d8ef51@google.com> <2cae6fd4-906c-44ad-88be-0dfed090d07c@proton.me> <CAH5fLgjT3hAdtdNeb7FgX491UhvMGa-JHevz_EqC=N4zVViBjw@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.04.24 11:44, Alice Ryhl wrote:
> On Mon, Apr 15, 2024 at 11:37=E2=80=AFAM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>>
>> On 15.04.24 09:13, Alice Ryhl wrote:
>>> +impl UserSlice {
>>> +    /// Constructs a user slice from a raw pointer and a length in byt=
es.
>>> +    ///
>>> +    /// Constructing a [`UserSlice`] performs no checks on the provide=
d address and length, it can
>>> +    /// safely be constructed inside a kernel thread with no current u=
serspace process. Reads and
>>> +    /// writes wrap the kernel APIs `copy_from_user` and `copy_to_user=
`, which check the memory map
>>> +    /// of the current process and enforce that the address range is w=
ithin the user range (no
>>> +    /// additional calls to `access_ok` are needed).
>>> +    ///
>>> +    /// Callers must be careful to avoid time-of-check-time-of-use (TO=
CTOU) issues. The simplest way
>>> +    /// is to create a single instance of [`UserSlice`] per user memor=
y block as it reads each byte
>>> +    /// at most once.
>>> +    pub fn new(ptr: *mut c_void, length: usize) -> Self {
>>
>> What would happen if I call this with a kernel pointer and then
>> read/write to it? For example
>>
>>       let mut arr =3D [MaybeUninit::uninit(); 64];
>>       let ptr: *mut [MaybeUninit<u8>] =3D &mut arr;
>>       let ptr =3D ptr.cast::<c_void>();
>>
>>       let slice =3D UserSlice::new(ptr, 64);
>>       let (mut r, mut w) =3D slice.reader_writer();
>>
>>       r.read_raw(&mut arr)?;
>>       // SAFETY: `arr` was initialized above.
>>       w.write_slice(unsafe { MaybeUninit::slice_assume_init_ref(&arr) })=
?;
>>
>> I think this would violate the exclusivity of `&mut` without any
>> `unsafe` code. (the `unsafe` block at the end cannot possibly be wrong)
>=20
> This will fail with an EFAULT error. There is a check on the C side
> that verifies that the address is in userspace. (The access_ok call.)

I see, that makes a lot of sense.

Regardless of whether you fix the nit about the guarantees section:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno


