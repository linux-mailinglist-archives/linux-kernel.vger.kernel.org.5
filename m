Return-Path: <linux-kernel+bounces-110141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8061D885A8E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50B81F22658
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D668526B;
	Thu, 21 Mar 2024 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="InaLxO/o"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91FC8526C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711030810; cv=none; b=Hu0D5tQY6Zo+rLD9KM9R42B1lNQsTiSRAKYY/fzR/5S5nugnaEWXL0+n2scb/atzPOTu4hCFDfgzSypHYsUA5+p5YPMvHl0cI0UH8EVuzJftNyAy/R5QAw7B/M64KOPKHiiybzFPnH6ToE/cnYebxFf1Z3Ln2D2dOqIxaGsOugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711030810; c=relaxed/simple;
	bh=6xyeLUgAwxmqGgmY+Lxx+AP/kDtnBc74/itYOT89GNM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oCue+5MyyCi9oM5tnavrgCfBXjIEBFKbjwot3uyu6NjKtQunPzL+nWaiut32sH7U10xDvTx+zZxQNmbqi8Iy1Zk2tgjVy7pQc9R4YPXbXPL2aE7zvJ5+vKhU5Z3TuRbeYK2FQKqoXk3//fLPwUnJwkgQTXpBFwaPLg2UuslW/r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=InaLxO/o; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=rz63pa25ejeqzkhf77wqfydujq.protonmail; t=1711030803; x=1711290003;
	bh=NiTFkvVVIBt3Zp4d7bg0Q/59Q6CidDiKN7ppRU78CAw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=InaLxO/o6NGTLercgTkCaaGLUifhedx7egjA4JUq0AH/FATkjVUxf0CCPLiFbwGGa
	 T+NwtBfwQOPrJChIfXCvJVFx1WmDhDjJOpt57nHQSbE9orwx+TJgq02S9JiKDTmqg3
	 ucDDPWXR9gLHQRsvZGLU7ynjWmsYmN1DC+eOPRMwIvNZfhiHclxw19COQMK+kzK3Z5
	 tz/xRwUOBXa6fBQguKESxk0M3rJHdDIXhksKEtFWKt1/P5TaseaZ5NpVLm+WQOSZPO
	 ogf7fcdC/+qCI5QgrW1mghPY6JfPkElUmSd5i0BSA1+PYTTsYAdD15/REEX/EmIPKK
	 DE1n0eqx8LQvg==
Date: Thu, 21 Mar 2024 14:19:48 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: a.hindborg@samsung.com, akpm@linux-foundation.org, alex.gaynor@gmail.com, arnd@arndb.de, arve@android.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org, cmllamas@google.com, gary@garyguo.net, gregkh@linuxfoundation.org, joel@joelfernandes.org, keescook@chromium.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, maco@android.com, ojeda@kernel.org, rust-for-linux@vger.kernel.org, surenb@google.com, tkjos@android.com, viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Subject: Re: [PATCH v3 4/4] rust: add abstraction for `struct page`
Message-ID: <504d1e4e-97f6-425b-98a2-a2a32dff1313@proton.me>
In-Reply-To: <CAH5fLggy1ci+gu2eVzjo0nHtNzT=+NgaaU5WAwq8qHrhu1QCYw@mail.gmail.com>
References: <baee63d9-273a-48aa-b3cc-f15e3782156b@proton.me> <20240320084630.2727355-1-aliceryhl@google.com> <9ed03148-5ceb-40f2-9c2d-31e2b8918888@proton.me> <CAH5fLgj_vmhCV-Ptfbjbq=FZOuVSLOEsatELaPmz=BuDuemghw@mail.gmail.com> <e088f9a2-c0aa-41b6-993b-01adb5fba929@proton.me> <CAH5fLggy1ci+gu2eVzjo0nHtNzT=+NgaaU5WAwq8qHrhu1QCYw@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/21/24 15:11, Alice Ryhl wrote:
> On Thu, Mar 21, 2024 at 2:56=E2=80=AFPM Benno Lossin <benno.lossin@proton=
me> wrote:
>>
>> On 3/21/24 14:42, Alice Ryhl wrote:
>>> On Thu, Mar 21, 2024 at 2:16=E2=80=AFPM Benno Lossin <benno.lossin@prot=
on.me> wrote:
>>>>
>>>> On 3/20/24 09:46, Alice Ryhl wrote:
>>>>>> On 3/11/24 11:47, Alice Ryhl wrote:
>>>>>>> +/// A pointer to a page that owns the page allocation.
>>>>>>> +///
>>>>>>> +/// # Invariants
>>>>>>> +///
>>>>>>> +/// The pointer points at a page, and has ownership over the page.
>>>>>>
>>>>>> Why not "`page` is valid"?
>>>>>> Do you mean by ownership of the page that `page` has ownership of th=
e
>>>>>> allocation, or does that entail any other property/privilege?
>>>>>
>>>>> I can add "at a valid page".
>>>>
>>>> I don't think that helps, what you need as an invariant is that the
>>>> pointer is valid.
>>>
>>> To me "points at a page" implies that the pointer is valid. I mean, if
>>> it was dangling, it would not point at a page?
>>>
>>> But I can reword to something else if you have a preferred phrasing.
>>
>> I would just say "`page` is valid" or "`self.page` is valid".
>>
>>>>>>> +    /// Runs a piece of code with this page mapped to an address.
>>>>>>> +    ///
>>>>>>> +    /// The page is unmapped when this call returns.
>>>>>>> +    ///
>>>>>>> +    /// It is up to the caller to use the provided raw pointer cor=
rectly.
>>>>>>
>>>>>> This says nothing about what 'correctly' means. What I gathered from=
 the
>>>>>> implementation is that the supplied pointer is valid for the executi=
on
>>>>>> of `f` for `PAGE_SIZE` bytes.
>>>>>> What other things are you allowed to rely upon?
>>>>>>
>>>>>> Is it really OK for this function to be called from multiple threads=
?
>>>>>> Could that not result in the same page being mapped multiple times? =
If
>>>>>> that is fine, what about potential data races when two threads write=
 to
>>>>>> the pointer given to `f`?
>>>>>>
>>>>>>> +    pub fn with_page_mapped<T>(&self, f: impl FnOnce(*mut u8) -> T=
) -> T {
>>>>>
>>>>> I will say:
>>>>>
>>>>> /// It is up to the caller to use the provided raw pointer correctly.
>>>>> /// The pointer is valid for `PAGE_SIZE` bytes and for the duration i=
n
>>>>> /// which the closure is called. Depending on the gfp flags and kerne=
l
>>>>> /// configuration, the pointer may only be mapped on the current thre=
ad,
>>>>> /// and in those cases, dereferencing it on other threads is UB. Othe=
r
>>>>> /// than that, the usual rules for dereferencing a raw pointer apply.
>>>>> /// (E.g., don't cause data races, the memory may be uninitialized, a=
nd
>>>>> /// so on.)
>>>>
>>>> I would simplify and drop "depending on the gfp flags and kernel..." a=
nd
>>>> just say that the pointer is only valid on the current thread.
>>>
>>> Sure, that works for me.
>>>
>>>> Also would it make sense to make the pointer type *mut [u8; PAGE_SIZE]=
?
>>>
>>> I think it's a trade-off. That makes the code more error-prone, since
>>> `pointer::add` now doesn't move by a number of bytes, but a number of
>>> pages.
>>
>> Yeah. As long as you document that the pointer is valid for r/w with
>> offsets in `0..PAGE_SIZE` bytes, leaving the type as is, is fine by me.
>>
>>
>>>>> It's okay to map it multiple times from different threads.
>>>>
>>>> Do you still need to take care of data races?
>>>> So would it be fine to execute this code on two threads in parallel?
>>>>
>>>>        static PAGE: Page =3D ...; // assume we have a page accessible =
by both threads
>>>>
>>>>        PAGE.with_page_mapped(|ptr| {
>>>>            loop {
>>>>                unsafe { ptr.write(0) };
>>>>                pr_info!("{}", unsafe { ptr.read() });
>>>>            }
>>>>        });
>>>
>>> Like I said, the usual pointer rules apply. Two threads can access it
>>> in parallel as long as one of the following are satisfied:
>>>
>>> * Both accesses are reads.
>>> * Both accesses are atomic.
>>> * They access disjoint byte ranges.
>>>
>>> Other than the fact that it uses a thread-local mapping on machines
>>> that can't address all of their memory at the same time, it's
>>> completely normal memory. It's literally just a PAGE_SIZE-aligned
>>> allocation of PAGE_SIZE bytes.
>>
>> Thanks for the info, what do you think of this?:
>>
>> /// It is up to the caller to use the provided raw pointer correctly. Th=
e pointer is valid for reads
>> /// and writes for `PAGE_SIZE` bytes and for the duration in which the c=
losure is called. The
>> /// pointer must only be used on the current thread. The caller must als=
o ensure that no data races
>> /// occur: when mapping the same page on two threads accesses to memory =
with the same offset must be
>> /// synchronized.
>=20
> I would much rather phrase it in terms of "the usual pointer" rules. I
> mean, the memory could also be uninitialized if you don't pass
> __GFP_ZERO when you create it, so you also have to make sure to follow
> the rules about uninitialized memory. I don't want to be in the
> business of listing all requirements for accessing memory here.

Sure you can add that part again, I just want to highlight that mapping
the same page multiple times means that the caller has to synchronize
accesses to those pointers even if the pointers do not have the same
address value. That is not normally something you need to take care of,
ie normally if `ptr1.addr() !=3D ptr2.addr()` then you can access them
without synchronization.

>>>> If this is not allowed, I don't really like the API. As a raw version =
it
>>>> would be fine, but I think we should have a safer version (eg by takin=
g
>>>> `&mut self`).
>>>
>>> I don't understand what you mean. It is the *most* raw API that `Page`
>>> has. I can make them private if you want me to. The API cannot take
>>> `&mut self` because I need to be able to unsafely perform concurrent
>>> writes to disjoint byte ranges.
>>
>> If you don't need these functions to be public, I think we should
>> definitely make them private.
>> Also we could add a `raw` suffix to the functions to make it clear that
>> it is a primitive API. If you think that it is highly unlikely that we
>> get a safer version, then I don't think there is value in adding the
>> suffix.
>=20
> The old code on the Rust branch didn't have these functions, but
> that's because the old `read_raw` and `write_raw` methods did all of
> these things directly in their implementation:
>=20
> * Map the memory so we can get a pointer.
> * Get a pointer to a subslice (with bounds checks!)
> * Do the actual read/write.
>=20
> I thought that doing this many things in a single function was
> convoluted, so I decided to refactor the code by extracting the "get a
> pointer to the page" logic into `with_page_mapped` and the "point to
> subslice with bounds check" logic into `with_pointer_into_page`. That
> way, each function has only one responsibility, instead of mixing
> three responsibilities into one.

I think that design decision is good.

> So even if we get a safer version, I would not want to get rid of this
> method. I don't want to inline its implementation into more
> complicated functions. The safer method would call the raw method, and
> then do whatever additional logic it wants to do on top of that.

I was not suggesting removing this method, rather renaming it to reflect
that it is a primitive API that should be avoided if possible.

--=20
Cheers,
Benno


