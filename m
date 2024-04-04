Return-Path: <linux-kernel+bounces-131651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEFD898A6D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C1D1F28552
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98771C694;
	Thu,  4 Apr 2024 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="HiyOn/bU"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE7315EA6;
	Thu,  4 Apr 2024 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242284; cv=none; b=L/JVzS+0Nf4fvW6oq9OqAh6n0RhufX59Y9tRAYzhsVD21BY1U4mG8jKqOJRCZE9Za6xiUKT3fQedEirHDlctR6YMs7/h6qpfHgT86MPMe1X0Dj3NLgoEqjgih91Z8kCEd0uYwUQi0H/ArM0e0uKare8EGLLCRwH2+uwzJiYMDvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242284; c=relaxed/simple;
	bh=9F4bE6RFEhkRy0ov/bMHMaKCv6iNYmCPVd5GJvpQkj0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YzMI+XpQriKwsPWiZp7EQu1D02WL1rsjozJVuLbPvNTIdgjkdbggN+liy/rFy5nuhYhCbqQP+v+zfP5J408X2tjeOCHoJr9wTmVCj7PAxKPF8RJrcaAqYsQ8sGCmCzuRvBleaErZriwg1XbaISzqFhSWys1u8rdVyazo+haPNkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=HiyOn/bU; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=46r6zabnkjcrdj3jci6p6oyzwa.protonmail; t=1712242280; x=1712501480;
	bh=0Jzi1SJxdrZbAiksLrRC8eagzCOdwlYfNKWFhLLRZ30=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=HiyOn/bUh/O0/cUk95114wulc/Dt1gYbWDYi+OG0mACzWIchMlHepzmIIHH/kFuWW
	 cMz9PxPSkdOJv6xNO6KW2oSpJXUGUrPGAZMGfxihyjZherYPP+eF6xxPg1qTNb5Y6X
	 6X7KZ2uklWfx/tkvBlLcHk/GMwQ4SRJpPE3rEIzbjtRPp6TWTX/dUQMKIsOU2Mcd3g
	 7kpGojHWNE5mFVCeCO1mGEvfVbMx+vTpYSYjiMA+pqmIhrXMv2IFvwo0dc6u+forkG
	 l6qaEFe2nfSL53SsxW8N4cjnRGv1HkveWidTMaZ+MzogxIkYLH3C7ZyWF7G2mnnq6n
	 65nstalLpIEGA==
Date: Thu, 04 Apr 2024 14:51:16 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 5/9] rust: list: add List
Message-ID: <3f3cf5ae-30df-4032-b752-77126035784c@proton.me>
In-Reply-To: <CAH5fLgiN3jcd_HMgmP7H-026daMw0xkMk=CGaGc9AM7uHkFXFA@mail.gmail.com>
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com> <20240402-linked-list-v1-5-b1c59ba7ae3b@google.com> <d896a813-3081-40b4-985b-ef257d55cec2@proton.me> <CAH5fLgiN3jcd_HMgmP7H-026daMw0xkMk=CGaGc9AM7uHkFXFA@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.04.24 16:12, Alice Ryhl wrote:
> On Thu, Apr 4, 2024 at 4:03=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>> On 02.04.24 14:17, Alice Ryhl wrote:
>>> +
>>> +        if self.first.is_null() {
>>> +            self.first =3D item;
>>> +            // SAFETY: The caller just gave us ownership of these fiel=
ds.
>>> +            // INVARIANT: A linked list with one item should be cyclic=
.
>>> +            unsafe {
>>> +                (*item).next =3D item;
>>> +                (*item).prev =3D item;
>>> +            }
>>> +        } else {
>>> +            let next =3D self.first;
>>> +            // SAFETY: We just checked that `next` is non-null.
>>
>> Missing mention of the type invariant.
>=20
> SAFETY: By the type invariant, this pointer is valid or null. We just
> checked that it's not null, so it must be valid.

Sounds good.

[...]

>>> +    /// Removes the first item from this list.
>>> +    pub fn pop_front(&mut self) -> Option<ListArc<T, ID>> {
>>> +        if self.first.is_null() {
>>> +            return None;
>>> +        }
>>> +
>>> +        // SAFETY: The first item of this list is in this list.
>>> +        Some(unsafe { self.remove_internal(self.first) })
>>> +    }
>>> +
>>> +    /// Removes the provided item from this list and returns it.
>>> +    ///
>>> +    /// This returns `None` if the item is not in the list.
>>
>> I think this should say "Returns `None` if the item is not in a list.".
>> (Technically it should be "is not in a `List<T, ID>`", since it *can* be
>> in another list with a different ID.)
>=20
> I'm not really convinced. The phrases "the list" and "a list" are
> equivalent given the safety requirement for this method, but "the
> list" seems more natural to me. The `remove` method of any other
> collection would say "the list" too.

They are equivalent, but saying "the list" has the potential for this
confusion: "If the function returns `None` if the item is not in the
list, then why do I need to ensure that it is not in a different list?".
>=20
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// The provided item must not be in a different linked list.
>>> +    pub unsafe fn remove(&mut self, item: &T) -> Option<ListArc<T, ID>=
> {
>>> +        let mut item =3D unsafe { ListLinks::fields(T::view_links(item=
)) };
>>> +        // SAFETY: The user provided a reference, and reference are ne=
ver dangling.
>>> +        //
>>> +        // As for why this is not a data race, there are two cases:
>>> +        //
>>> +        //  * If `item` is not in any list, then these fields are read=
-only and null.
>>> +        //  * If `item` is in this list, then we have exclusive access=
 to these fields since we
>>> +        //    have a mutable reference to the list.
>>> +        //
>>> +        // In either case, there's no race.
>>> +        let ListLinksFields { next, prev } =3D unsafe { *item };
>>> +
>>> +        debug_assert_eq!(next.is_null(), prev.is_null());
>>> +        if !next.is_null() {
>>> +            // This is really a no-op, but this ensures that `item` is=
 a raw pointer that was
>>> +            // obtained without going through a pointer->reference->po=
inter conversion rountrip.
>>> +            // This ensures that the list is valid under the more rest=
rictive strict provenance
>>> +            // ruleset.
>>> +            //
>>> +            // SAFETY: We just checked that `next` is not null, and it=
's not dangling by the
>>> +            // list invariants.
>>> +            unsafe {
>>> +                debug_assert_eq!(item, (*next).prev);
>>> +                item =3D (*next).prev;
>>> +            }
>>> +
>>> +            // SAFETY: We just checked that `item` is in a list, so th=
e caller guarantees that it
>>> +            // is in this list. The pointers are in the right order.
>>> +            Some(unsafe { self.remove_internal_inner(item, next, prev)=
 })
>>> +        } else {
>>> +            None
>>> +        }
>>> +    }
>>> +
>>> +    /// Removes the provided item from the list.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// The pointer must point at an item in this list.
>>> +    unsafe fn remove_internal(&mut self, item: *mut ListLinksFields) -=
> ListArc<T, ID> {
>>> +        // SAFETY: The caller promises that this pointer is not dangli=
ng, and there's no data race
>>> +        // since we have a mutable reference to the list containing `i=
tem`.
>>> +        let ListLinksFields { next, prev } =3D unsafe { *item };
>>> +        // SAFETY: The pointers are ok and in the right order.
>>> +        unsafe { self.remove_internal_inner(item, next, prev) }
>>> +    }
>>> +
>>> +    /// Removes the provided item from the list.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// The `item` pointer must point at an item in this list, and we =
must have `(*item).next =3D=3D
>>> +    /// next` and `(*item).prev =3D=3D prev`.
>>> +    unsafe fn remove_internal_inner(
>>> +        &mut self,
>>> +        item: *mut ListLinksFields,
>>> +        next: *mut ListLinksFields,
>>> +        prev: *mut ListLinksFields,
>>> +    ) -> ListArc<T, ID> {
>>> +        // SAFETY: We have exclusive access to items in the list, and =
prev/next pointers are
>>
>> I think you mean that you have exclusive access to the prev/next fields
>> of the `ListLinks` associated with `ID`... But that is rather long.
>> Does anyone have any idea to shorten this?
>=20
> SAFETY: We have exclusive access to the pointers of items in the list,
> and the prev/next pointers are never null for items in a list.

I would say that they are valid instead of never null, since you
dereference them below. Otherwise sounds good.

>=20
>>> +        // never null for items in a list.
>>> +        //
>>> +        // INVARIANT: There are three cases:
>>> +        //  * If the list has at least three items, then after removin=
g the item, `prev` and `next`
>>> +        //    will be next to each other.
>>> +        //  * If the list has two items, then the remaining item will =
point at itself.
>>> +        //  * If the list has one item, then `next =3D=3D prev =3D=3D =
item`, so these writes have no effect
>>> +        //    due to the writes to `item` below.
>>
>> I think the writes do not have an effect. (no need to reference the
>> writes to `item` below)
>=20
> ?

The first write is

     (*next).prev =3D prev;

Using the fact that `next =3D=3D prev =3D=3D item` we have

     (*item).prev =3D prev;

But that is already true, since the function requirement is that
`(*item).prev =3D=3D prev`. So the write has no effect.
The same should hold for `(*prev).next =3D next`.

>=20
>>> +        unsafe {
>>> +            (*next).prev =3D prev;
>>> +            (*prev).next =3D next;
>>> +        }
>>> +        // SAFETY: We have exclusive access to items in the list.
>>> +        // INVARIANT: The item is no longer in a list, so the pointers=
 should be null.
>>> +        unsafe {
>>> +            (*item).prev =3D ptr::null_mut();
>>> +            (*item).next =3D ptr::null_mut();
>>> +        }
>>> +        // INVARIANT: There are three cases:
>>> +        //  * If `item` was not the first item, then `self.first` shou=
ld remain unchanged.
>>> +        //  * If `item` was the first item and there is another item, =
then we just updated
>>> +        //    `prev->next` to `next`, which is the new first item, and=
 setting `item->next` to null
>>> +        //    did not modify `prev->next`.
>>> +        //  * If `item` was the only item in the list, then `prev =3D=
=3D item`, and we just set
>>> +        //    `item->next` to null, so this correctly sets `first` to =
null now that the list is
>>> +        //    empty.
>>> +        if self.first =3D=3D item {
>>> +            // SAFETY: The `prev` field of an item in a list is never =
dangling.
>>
>> I don't think this SAFETY comment makes sense.
>>
>>> +            self.first =3D unsafe { (*prev).next };
>=20
> SAFETY: `prev` is the `prev` pointer from a `ListLinks` in a `List`,
> so the pointer is valid. There's no race, since we have exclusive
> access to the list.

Sounds good.

--=20
Cheers,
Benno


