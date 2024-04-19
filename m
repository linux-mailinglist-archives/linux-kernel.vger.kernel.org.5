Return-Path: <linux-kernel+bounces-151904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A21A8AB58B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72C26B21757
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9A513C904;
	Fri, 19 Apr 2024 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QU97x+Q+"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8827428374
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713554681; cv=none; b=QBW4EjyUtZkXfbHIWelGjfiO4rX0kwGKSE5ifjw/dT6rtd/Xsk5rzIPyDE5l+XYy6SlQ8O3LoGEWJMwxKDbpJMdRZ+LLssx/POaE/MvFDt5QugNZVnihxY0ffUEqCDJYlivfjPKb4YK//BSNrswvcyMCfLJP8XhfyHOZptCyBpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713554681; c=relaxed/simple;
	bh=KgdfRfZxHoDqdsAw65ukQuf/Dz7cxkXN/32luMZXWUU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DkHbB3Fk0DLZwYeobCH7t5nL1WJDKyGRMz7WH3SAmNySMRrBoCXk1SYpBuMYLbZ5KgvH8G1TZD6KkpQJ60ANQQalAXcPQlbeStGEJpcbm83TiniJz6qnqKf0W9A2YAxSi7+vFqgiyQNwWl8DbSm5shxXTnOHkcF4wQet+PlIBqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QU97x+Q+; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1713554676; x=1713813876;
	bh=vCvePluHAcwgBw7ggt1O7z9u1s71ZLFHHPwyUG7O1aA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QU97x+Q+uDPS0SdkO6EHo/RbHvPmEyCBeePZ9HCFVsz+d6ZrRGSMKl1sxvqgJkBbk
	 reD8jB2hChO4rck/EVbn0IoXWbMLDtr9/6a8trMM3uGa0zm0k6yMpEliBg+ZhyKJ9b
	 fy2WGKzcP28AAQzv2mzmTHCuabUlD/8AZZZh23GgYJfh3WnrjGCfOEnOkpVZdFEMz6
	 w5AVy6PV1yxwikPO6S81SBVeDXE13wEzeEVf1pV9QzekcZQFLasv1UAWENmtMoTDCM
	 xiSxsPW7++PhSAQvhJPQcKTtg1fPdA7/kxS67tENUIkJ/DwSTrVI8WxbSVesWTuKNt
	 ZijcbRKnfvXbQ==
Date: Fri, 19 Apr 2024 19:24:31 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v6 4/4] rust: add abstraction for `struct page`
Message-ID: <c500f9c6-8811-44c4-89a4-603a67d09e78@proton.me>
In-Reply-To: <ZiKooOjXh209i8je@boqun-archlinux>
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com> <20240418-alice-mm-v6-4-cb8f3e5d688f@google.com> <ZiFsCLb-BZWbBHsu@boqun-archlinux> <87dc4cdf-ccf6-4b08-8915-313aad313f93@proton.me> <ZiGlC5AtRRikE1AI@boqun-archlinux> <ZiGnFI7cz5v-cowt@boqun-archlinux> <079c88af-2e6d-45fe-bf58-afebbf7583b4@proton.me> <ZiKooOjXh209i8je@boqun-archlinux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 99067a81dd80b83b29b9214a862a2f3e3d937d32
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.04.24 19:23, Boqun Feng wrote:
> On Fri, Apr 19, 2024 at 08:36:11AM +0000, Benno Lossin wrote:
>> On 19.04.24 01:04, Boqun Feng wrote:
>>> On Thu, Apr 18, 2024 at 03:56:11PM -0700, Boqun Feng wrote:
>>>> On Thu, Apr 18, 2024 at 10:08:40PM +0000, Benno Lossin wrote:
>>>>> On 18.04.24 20:52, Boqun Feng wrote:
>>>>>> On Thu, Apr 18, 2024 at 08:59:20AM +0000, Alice Ryhl wrote:
>>>>>>> +    /// Runs a piece of code with a raw pointer to a slice of this=
 page, with bounds checking.
>>>>>>> +    ///
>>>>>>> +    /// If `f` is called, then it will be called with a pointer th=
at points at `off` bytes into the
>>>>>>> +    /// page, and the pointer will be valid for at least `len` byt=
es. The pointer is only valid on
>>>>>>> +    /// this task, as this method uses a local mapping.
>>>>>>> +    ///
>>>>>>> +    /// If `off` and `len` refers to a region outside of this page=
, then this method returns
>>>>>>> +    /// `EINVAL` and does not call `f`.
>>>>>>> +    ///
>>>>>>> +    /// # Using the raw pointer
>>>>>>> +    ///
>>>>>>> +    /// It is up to the caller to use the provided raw pointer cor=
rectly. The pointer is valid for
>>>>>>> +    /// `len` bytes and for the duration in which the closure is c=
alled. The pointer might only be
>>>>>>> +    /// mapped on the current thread, and when that is the case, d=
ereferencing it on other threads
>>>>>>> +    /// is UB. Other than that, the usual rules for dereferencing =
a raw pointer apply: don't cause
>>>>>>> +    /// data races, the memory may be uninitialized, and so on.
>>>>>>> +    ///
>>>>>>> +    /// If multiple threads map the same page at the same time, th=
en they may reference with
>>>>>>> +    /// different addresses. However, even if the addresses are di=
fferent, the underlying memory is
>>>>>>> +    /// still the same for these purposes (e.g., it's still a data=
 race if they both write to the
>>>>>>> +    /// same underlying byte at the same time).
>>>>>>> +    fn with_pointer_into_page<T>(
>>>>>>> +        &self,
>>>>>>> +        off: usize,
>>>>>>> +        len: usize,
>>>>>>> +        f: impl FnOnce(*mut u8) -> Result<T>,
>>>>>>
>>>>>> I wonder whether the way to go here is making this function signatur=
e:
>>>>>>
>>>>>>        fn with_slice_in_page<T> (
>>>>>>            &self,
>>>>>> =09       off: usize,
>>>>>> =09       len: usize,
>>>>>> =09       f: iml FnOnce(&UnsafeCell<[u8]>) -> Result<T>
>>>>>>        ) -> Result<T>
>>>>>>
>>>>>> , because in this way, it makes a bit more clear that what memory th=
at
>>>>>> `f` can access, in other words, the users are less likely to use the
>>>>>> pointer in a wrong way.
>>>>>>
>>>>>> But that depends on whether `&UnsafeCell<[u8]>` is the correct
>>>>>> abstraction and the ecosystem around it: for example, I feel like th=
ese
>>>>>> two functions:
>>>>>>
>>>>>> =09    fn len(slice: &UnsafeCell<[u8]>) -> usize
>>>>>> =09    fn as_ptr(slice: &UnsafeCell<[u8]>) -> *mut u8
>>>>>>
>>>>>> should be trivially safe, but I might be wrong. Again this is just f=
or
>>>>>> future discussion.
>>>>>
>>>>> I think the "better" type would be `&[UnsafeCell<u8>]`. Since there y=
ou
>>>>> can always access the length.
>>>>>
>>>>
>>>> Hmm.. here is the thing, having `&UnsafeCell<[u8]>` means having a `*m=
ut
>>>> [u8]>`, and it should always be safe to get a "length" of `*mut [u8]`,
>>>> right? I haven't found any method doing that, but the length should be
>>>> just a part of fat pointer, so I think getting that is a defined
>>>> behavior. But maybe I'm missing something.
>>
>> There is `to_raw_parts` [1], but that is unstable. (Note that
>> `<[T] as Pointee>::Metadata =3D usize`, see [2])
>>
>=20
> Oh, that's good to know, thank you! ;-)
>
>>> Hmm... but I guess one of the problems of this approach, is how to
>>> construct a `&UnsafeCell<[u8]>` from a pointer and length...
>>
>> We could use `from_raw_parts` [3]. But when making the slice the outer
>> type, we can use a stable function to convert a pointer and a length to
>> a slice [4].
>>
>=20
> Yes, but there appears no way to get a pointer with larger provenance
> from a `&[UnsafeCell<u8>]`, right?

What do you mean by "larger provenance"?

>>>>> Another question would be if page allows for uninitialized bits, in t=
hat
>>>>> case, we would need `&[Opaque<u8>]`.
>>>>>
>>>>
>>>> Yes, or `&Opaque<[u8>]`.
>>
>> I don't think that putting the slice on the inside is what we want. Also
>=20
> Hmm.. why? So in `&UnsafeCell<[u8]>` vs `&[UnsafeCell<u8>]` case, I
> think the former represent "a slice of u8 that can be modified in the
> same time" very well, and this is what a pointer-and-length pair usually
> represents in kernel, I think. But yes, the latter is OK to me as well,
> just hard to play the provenance game I guess?

Ultimately it again comes down to missing field projections :)

The type `&UnsafeCell<[u8]>` is less *useful*, since you cannot even get
the length of the slice. Also indexing into this type is not easily
possible. This is because the only way to get/change the inner value of
an `UnsafeCell` is via `get`.

Compare this with the slice type. It allows getting the length, indexing
into it (ie a form of field projections, if we consider slices as having
a variable amount of fields).

All those issues would be solved by (good) field projections.


Field projections also give a reason for why using `&[UnsafeCell<u8>]`
is not really different from `&UnsafeCell<[u8]>`: At any point in time
we ought to be able to project `&UnsafeCell<[u8]> -> &[UnsafeCell<u8>]`.

So it's fine to just use that from the get-go.

>> note that `Opaque<T>` requires that `T: Sized` and that is not the case
>> for `[u8]`.
>=20
> Oh, you're right. In case of MaybeUninit, it requires `T: Sized`, so
> `Opaque<[u8]>` doesn't quite work.
>=20
> Moving forward, maybe the first step is to see whether `&[Opaque<u8>]`
> and `&[UnsafeCell<u8>]` can have a good way to generate a pointer with
> proper provenance? Time to ping t-opsem maybe?

Good idea, do you want to do that, or should I do it?

--=20
Cheers,
Benno


