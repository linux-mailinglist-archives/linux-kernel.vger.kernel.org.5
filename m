Return-Path: <linux-kernel+bounces-151176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB6D8AAAA7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2A261C21F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5FD64CE8;
	Fri, 19 Apr 2024 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="b+hIFPUz"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C4C1E491;
	Fri, 19 Apr 2024 08:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515786; cv=none; b=b0gOOmGR0uAjw5PNZYrl0u+58E8i6o3yFeFan3XJy66kgfsK1t2yGhnA3nIZIDtqWMTK3sRIUX4h22EyXwYx6+c45cNb9FaoMr9L6L46z+ASKFEsp+RihPb6uH00ugPtUSyNsEpwZsIXKzVDvj1Lu6W2WWjpO6LISbWtepb/GVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515786; c=relaxed/simple;
	bh=cHrXCKoKJLnXn3cGgKmUX7l9FKAPRGU8deld9SgpXQk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzIr/yjxt3anxFwdqDsaCeFXRLEiWfTJCD3OjUzLjGZaurT0KNvTNM7idDnieyr2KJy8yuCqgygF5cpzDT6Cb0nFwkn7yuDyADNDrfuP0gfP/6EUABm0Qj6ZL7Jy/EVt9fEW5KwSqPCFmNazd+PusWLb/Up+2zRY35JijULGbjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=b+hIFPUz; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1713515779; x=1713774979;
	bh=GNZayvSmS5HRg6gaz/dtwX1+NRrHmVzmTZGPE4Ro8Bk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=b+hIFPUz3QO4BSP9l86BymyS8jeeT04gztsZSJOjK+Mn1kc8SR+n7jWsZ/faaBHGS
	 I5YqzIgHAoRZxNNFmLiPMmXzy4z2vSH8V6aHuol9+m29n9SFvJDUdCN+G1hVR5XMPA
	 2Hw7XBupHcL5hDPTGqv9B/o7rO1NyF6kX/3MbRt4IMsrKdqxan4Q6yDTURIkppSBfa
	 r2t8rPUEuaoJNmN3MZZLmrdXZNthFXpD1A06i3k0R5G0rIxn1DiWXMcCxx+BU+babv
	 bKNTwmWqpEnYlCQm4LFRLAIBUOlmL89HV8nnkpgVvxftNqQx9Os63DmbxGGGttriml
	 2/QqAv3dP8dgw==
Date: Fri, 19 Apr 2024 08:36:11 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v6 4/4] rust: add abstraction for `struct page`
Message-ID: <079c88af-2e6d-45fe-bf58-afebbf7583b4@proton.me>
In-Reply-To: <ZiGnFI7cz5v-cowt@boqun-archlinux>
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com> <20240418-alice-mm-v6-4-cb8f3e5d688f@google.com> <ZiFsCLb-BZWbBHsu@boqun-archlinux> <87dc4cdf-ccf6-4b08-8915-313aad313f93@proton.me> <ZiGlC5AtRRikE1AI@boqun-archlinux> <ZiGnFI7cz5v-cowt@boqun-archlinux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: ad15b522de4b58dd3101eb7a34f97ddc12b90f13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.04.24 01:04, Boqun Feng wrote:
> On Thu, Apr 18, 2024 at 03:56:11PM -0700, Boqun Feng wrote:
>> On Thu, Apr 18, 2024 at 10:08:40PM +0000, Benno Lossin wrote:
>>> On 18.04.24 20:52, Boqun Feng wrote:
>>>> On Thu, Apr 18, 2024 at 08:59:20AM +0000, Alice Ryhl wrote:
>>>>> +    /// Runs a piece of code with a raw pointer to a slice of this p=
age, with bounds checking.
>>>>> +    ///
>>>>> +    /// If `f` is called, then it will be called with a pointer that=
 points at `off` bytes into the
>>>>> +    /// page, and the pointer will be valid for at least `len` bytes=
 The pointer is only valid on
>>>>> +    /// this task, as this method uses a local mapping.
>>>>> +    ///
>>>>> +    /// If `off` and `len` refers to a region outside of this page, =
then this method returns
>>>>> +    /// `EINVAL` and does not call `f`.
>>>>> +    ///
>>>>> +    /// # Using the raw pointer
>>>>> +    ///
>>>>> +    /// It is up to the caller to use the provided raw pointer corre=
ctly. The pointer is valid for
>>>>> +    /// `len` bytes and for the duration in which the closure is cal=
led. The pointer might only be
>>>>> +    /// mapped on the current thread, and when that is the case, der=
eferencing it on other threads
>>>>> +    /// is UB. Other than that, the usual rules for dereferencing a =
raw pointer apply: don't cause
>>>>> +    /// data races, the memory may be uninitialized, and so on.
>>>>> +    ///
>>>>> +    /// If multiple threads map the same page at the same time, then=
 they may reference with
>>>>> +    /// different addresses. However, even if the addresses are diff=
erent, the underlying memory is
>>>>> +    /// still the same for these purposes (e.g., it's still a data r=
ace if they both write to the
>>>>> +    /// same underlying byte at the same time).
>>>>> +    fn with_pointer_into_page<T>(
>>>>> +        &self,
>>>>> +        off: usize,
>>>>> +        len: usize,
>>>>> +        f: impl FnOnce(*mut u8) -> Result<T>,
>>>>
>>>> I wonder whether the way to go here is making this function signature:
>>>>
>>>>       fn with_slice_in_page<T> (
>>>>           &self,
>>>> =09       off: usize,
>>>> =09       len: usize,
>>>> =09       f: iml FnOnce(&UnsafeCell<[u8]>) -> Result<T>
>>>>       ) -> Result<T>
>>>>
>>>> , because in this way, it makes a bit more clear that what memory that
>>>> `f` can access, in other words, the users are less likely to use the
>>>> pointer in a wrong way.
>>>>
>>>> But that depends on whether `&UnsafeCell<[u8]>` is the correct
>>>> abstraction and the ecosystem around it: for example, I feel like thes=
e
>>>> two functions:
>>>>
>>>> =09    fn len(slice: &UnsafeCell<[u8]>) -> usize
>>>> =09    fn as_ptr(slice: &UnsafeCell<[u8]>) -> *mut u8
>>>>
>>>> should be trivially safe, but I might be wrong. Again this is just for
>>>> future discussion.
>>>
>>> I think the "better" type would be `&[UnsafeCell<u8>]`. Since there you
>>> can always access the length.
>>>
>>
>> Hmm.. here is the thing, having `&UnsafeCell<[u8]>` means having a `*mut
>> [u8]>`, and it should always be safe to get a "length" of `*mut [u8]`,
>> right? I haven't found any method doing that, but the length should be
>> just a part of fat pointer, so I think getting that is a defined
>> behavior. But maybe I'm missing something.

There is `to_raw_parts` [1], but that is unstable. (Note that
`<[T] as Pointee>::Metadata =3D usize`, see [2])

>>
>=20
> Hmm... but I guess one of the problems of this approach, is how to
> construct a `&UnsafeCell<[u8]>` from a pointer and length...

We could use `from_raw_parts` [3]. But when making the slice the outer
type, we can use a stable function to convert a pointer and a length to
a slice [4].

>=20
> Regards,
> Boqun
>=20
>>> Another question would be if page allows for uninitialized bits, in tha=
t
>>> case, we would need `&[Opaque<u8>]`.
>>>
>>
>> Yes, or `&Opaque<[u8>]`.

I don't think that putting the slice on the inside is what we want. Also
note that `Opaque<T>` requires that `T: Sized` and that is not the case
for `[u8]`.

[1]: https://doc.rust-lang.org/nightly/core/primitive.pointer.html#method.t=
o_raw_parts
[2]: https://doc.rust-lang.org/nightly/core/ptr/trait.Pointee.html#pointer-=
metadata
[3]: https://doc.rust-lang.org/nightly/core/ptr/fn.from_raw_parts.html
[4]: https://doc.rust-lang.org/nightly/core/slice/fn.from_raw_parts.html

--=20
Cheers,
Benno


