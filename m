Return-Path: <linux-kernel+bounces-110082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 874808859D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F05BAB21945
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C3D84A31;
	Thu, 21 Mar 2024 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IWFqDMYP"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDFA8405B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 13:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026986; cv=none; b=lX0S1GvG3NGLzryDkM0sBZN7E0bezWc0FOCNSTWWNVKhb9zUVnAKE5uP9kag0573dmdn0JjHz1/wsj5G+Uhgzxy0D778Qirv+FbtCLqwYKI2di36Oco7OxJqiomwM291keMHkEw5S+LClJO0eb75tE+4s6PgwkBgPyqsByCly70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026986; c=relaxed/simple;
	bh=Nk9b5oqwgKE06yFCMJlcUgDcBJvztR/AqGsXmLiNX+E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Azb/nX33jSdl2noHaZzqJmygQoKhgfPiP3Qmjj+W5s76s7XM/JLwPCfx1sLCGnH3XiSzZtxtznIT0Et/SqAA0rpPYY7iAM7DCM4bRMYuA6QbxBMStuZSFNZmdSD295NOYbiNbjV7/04aFBCXK2xZAI5vFQi5PWtnewaEwSRPWPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IWFqDMYP; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711026975; x=1711286175;
	bh=0/ojodZuZWU9umhLIhWLYR7XmIcfv7rcwjbeCgN2brI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IWFqDMYPUsqeZgQ45aFrjE6/9xYtmwZFoQ9z4oTPMSbsr2ZeDE4Dj/4L3pPLQ6yIc
	 DQbn7Q//kH4L8bqOOZScCu09j3nawzYCm8I3obNH1gjVi2JPF6HLC6wCCb4RM9B0U6
	 K9ZB15K5Z6YXMXo7P49PIdoqer+fZqAu/+6HXYQmzu1sFY0AKlQE+43Ap0snIcszG0
	 nfFaWVWe7xYJQcmSWrcFUmy/evESXDYDBxmAXxnP4LhZOqaVv3DlGvT1+cgYhoqcD6
	 juCz+O2Hv9mM1MXbITepHM1DpoIOScpW9kk3QCC/DyYWusCB+HXUYePpdSySvhX94z
	 BwayFaWfAl7Qg==
Date: Thu, 21 Mar 2024 13:15:58 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: a.hindborg@samsung.com, akpm@linux-foundation.org, alex.gaynor@gmail.com, arnd@arndb.de, arve@android.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org, cmllamas@google.com, gary@garyguo.net, gregkh@linuxfoundation.org, joel@joelfernandes.org, keescook@chromium.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, maco@android.com, ojeda@kernel.org, rust-for-linux@vger.kernel.org, surenb@google.com, tkjos@android.com, viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Subject: Re: [PATCH v3 4/4] rust: add abstraction for `struct page`
Message-ID: <9ed03148-5ceb-40f2-9c2d-31e2b8918888@proton.me>
In-Reply-To: <20240320084630.2727355-1-aliceryhl@google.com>
References: <baee63d9-273a-48aa-b3cc-f15e3782156b@proton.me> <20240320084630.2727355-1-aliceryhl@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/20/24 09:46, Alice Ryhl wrote:
>> On 3/11/24 11:47, Alice Ryhl wrote:
>>> +/// A pointer to a page that owns the page allocation.
>>> +///
>>> +/// # Invariants
>>> +///
>>> +/// The pointer points at a page, and has ownership over the page.
>>
>> Why not "`page` is valid"?
>> Do you mean by ownership of the page that `page` has ownership of the
>> allocation, or does that entail any other property/privilege?
>=20
> I can add "at a valid page".

I don't think that helps, what you need as an invariant is that the
pointer is valid.

> By ownership I mean that we are allowed to pass it to __free_page and
> that until we do, we can access the page. If you want me to reword this,
> please tell me what you want it to say.

I see, no need to change it.

>>> +// SAFETY: It is safe to transfer page allocations between threads.
>>
>> Why?
>>
>>> +unsafe impl Send for Page {}
>=20
> How about:
>=20
> // SAFETY: Pages have no logic that relies on them staying on a given
> // thread, so moving them across threads is safe.

Sounds good.

>>> +// SAFETY: As long as the safety requirements for `&self` methods on t=
his type
>>> +// are followed, there is no problem with calling them in parallel.
>>
>> Why?
>>
>>> +unsafe impl Sync for Page {}
>=20
> How about:
>=20
> // SAFETY: Pages have no logic that relies on them not being accessed
> // concurrently, so accessing them concurrently is safe.

Sounds good.

>>> +        // SAFETY: The specified order is zero and we want one page.
>>
>> This doesn't explain why it is sound to call the function. I expect that
>> it is always sound to call this function with valid arguments.
>>
>>> +        let page =3D unsafe { bindings::alloc_pages(gfp_flags, 0) };
>=20
> How about:
>=20
> // SAFETY: Depending on the value of `gfp_flags`, this call may sleep.
> // Other than that, it is always safe to call this method.

Sounds good.

>>> +        // INVARIANT: We checked that the allocation succeeded.
>>
>> Doesn't mention ownership.
>>
>>> +        Ok(Self { page })
>=20
> How about:
>=20
> // INVARIANT: We just successfully allocated a page, so we now have
> // ownership of the newly allocated page. We transfer that ownership to
> // the new `Page` object.

Sounds good.

>>> +    /// Runs a piece of code with this page mapped to an address.
>>> +    ///
>>> +    /// The page is unmapped when this call returns.
>>> +    ///
>>> +    /// It is up to the caller to use the provided raw pointer correct=
ly.
>>
>> This says nothing about what 'correctly' means. What I gathered from the
>> implementation is that the supplied pointer is valid for the execution
>> of `f` for `PAGE_SIZE` bytes.
>> What other things are you allowed to rely upon?
>>
>> Is it really OK for this function to be called from multiple threads?
>> Could that not result in the same page being mapped multiple times? If
>> that is fine, what about potential data races when two threads write to
>> the pointer given to `f`?
>>
>>> +    pub fn with_page_mapped<T>(&self, f: impl FnOnce(*mut u8) -> T) ->=
 T {
>=20
> I will say:
>=20
> /// It is up to the caller to use the provided raw pointer correctly.
> /// The pointer is valid for `PAGE_SIZE` bytes and for the duration in
> /// which the closure is called. Depending on the gfp flags and kernel
> /// configuration, the pointer may only be mapped on the current thread,
> /// and in those cases, dereferencing it on other threads is UB. Other
> /// than that, the usual rules for dereferencing a raw pointer apply.
> /// (E.g., don't cause data races, the memory may be uninitialized, and
> /// so on.)

I would simplify and drop "depending on the gfp flags and kernel..." and
just say that the pointer is only valid on the current thread.

Also would it make sense to make the pointer type *mut [u8; PAGE_SIZE]?

> It's okay to map it multiple times from different threads.

Do you still need to take care of data races?
So would it be fine to execute this code on two threads in parallel?

     static PAGE: Page =3D ...; // assume we have a page accessible by both=
 threads
    =20
     PAGE.with_page_mapped(|ptr| {
         loop {
             unsafe { ptr.write(0) };
             pr_info!("{}", unsafe { ptr.read() });
         }
     });

If this is not allowed, I don't really like the API. As a raw version it
would be fine, but I think we should have a safer version (eg by taking
`&mut self`).

>>> +        // SAFETY: This unmaps the page mapped above.
>>
>> This doesn't explain why it is sound.
>>
>>> +        //
>>> +        // Since this API takes the user code as a closure, it can onl=
y be used
>>> +        // in a manner where the pages are unmapped in reverse order. =
This is as
>>> +        // required by `kunmap_local`.
>>> +        //
>>> +        // In other words, if this call to `kunmap_local` happens when=
 a
>>> +        // different page should be unmapped first, then there must ne=
cessarily
>>> +        // be a call to `kmap_local_page` other than the call just abo=
ve in
>>> +        // `with_page_mapped` that made that possible. In this case, i=
t is the
>>> +        // unsafe block that wraps that other call that is incorrect.
>>> +        unsafe { bindings::kunmap_local(mapped_addr) };
>=20
> Why do you say that? The kunmap_local method requires that the address
> being unmapped is currently mapped, and that pages are unmapped in
> reverse order. The safety comment explains that the page is currently
> mapped and that this method cannot be used to unmap them in anything
> other than reverse order.

Sorry it seems I thought that the safety comment ended after the first
sentence. Can you (re)move that first sentence, since it is not part of
a justification?
The rest is fine.

>>> +    /// Runs a piece of code with a raw pointer to a slice of this pag=
e, with
>>> +    /// bounds checking.
>>> +    ///
>>> +    /// If `f` is called, then it will be called with a pointer that p=
oints at
>>> +    /// `off` bytes into the page, and the pointer will be valid for a=
t least
>>> +    /// `len` bytes. The pointer is only valid on this task, as this m=
ethod uses
>>> +    /// a local mapping.
>>
>> This information about the pointer only being valid on this task should
>> also apply to `with_page_mapped`, right?
>>
>>> +    ///
>>> +    /// If `off` and `len` refers to a region outside of this page, th=
en this
>>> +    /// method returns `EINVAL` and does not call `f`.
>>> +    ///
>>> +    /// It is up to the caller to use the provided raw pointer correct=
ly.
>>
>> Again, please specify what 'correctly' means.
>=20
> I will remove the "The pointer is only valid on this task, as this
> method uses a local mapping." sentence and copy the same paragraph as
> previously (without the `PAGE_SIZE` remark).

Sounds good.

--=20
Cheers,
Benno


