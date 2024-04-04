Return-Path: <linux-kernel+bounces-131127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BA5898364
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261981F2303A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D395D71B58;
	Thu,  4 Apr 2024 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="iuUGggj5"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968FC7175E;
	Thu,  4 Apr 2024 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712220428; cv=none; b=a3Bb+6FvneOfd0hv/cyDPfLZBBxVAN4AeTE9JNp9Dr9yAnw4Psf4bcSgMUcIpN5JkDvctlSz9dmbiIWTr5aoI07cNVPOFiqj2PTX6SUL3DcoZ67yZ1+AxBcrUp4KvRWAKIrTsloc7Hb+wGD5bM+7Odq9eEw73fZDVB3B+MnwcFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712220428; c=relaxed/simple;
	bh=dTtYCaA88jy1yxVN3Bo2zdVxAyBtmja3Ix2xgLkI2q4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jw/O5BmzzctCkLxbzrD2/Hr7bg8q6rcQZ6xKJpdYBfu8Ql0KUdJje6YSFZ0AjtIb6UVIESsR3Bt1sKyaV8u9oPL2r56eRxUfLcnJ6G2JDuaYfAuUnfxdhINteJpYR9tEHRS0PH3to349/IP9XPqa/UuRKRnkX8Ez+0CgNtnbRCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=iuUGggj5; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712220418; x=1712479618;
	bh=jdijZk8d4uuXnvdJJa2bllkyRHxcvx5fC5fcDsEwyek=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iuUGggj5XhOMUgyGMEGGhCcxTaQcQ2yVm+ZU7xjZ98uXs1H18o7oAoVZXMkOuZMu/
	 4iVKvbeHUdwGk1YxvCUPQ+PZhXPckYifRtcP4iIsB1lfs+11TzLQ+H3JLM8RsZUrep
	 AujgmfEaJlRwnAZwVvAddSWzbnabvTWTbcacn0s6QcD1fX7O4efO+GIthSzTb10e9R
	 8VTrFZSfsUS8Ul8pbnRpzwlrsbRbwW8ZadMY7YEEHfQi4MBZldM7yenqGUKbvPIzN8
	 Zj2NP2CNNldjwX30KQBNqUhQyRrat6Nc18QwNNnhOS+tisNyADmiKLKiCzTfi06RAJ
	 DQoqC6/UUzGwg==
Date: Thu, 04 Apr 2024 08:46:52 +0000
To: Andreas Hindborg <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Andreas Hindborg <a.hindborg@samsung.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>, =?utf-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, Joel Granados <j.granados@samsung.com>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez
	<da.gomez@samsung.com>, open list <linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [RFC PATCH 1/5] rust: block: introduce `kernel::block::mq` module
Message-ID: <3478efc2-7e81-4688-a115-5d33c70a24aa@proton.me>
In-Reply-To: <87zfu9r8be.fsf@metaspace.dk>
References: <86cd5566-5f1b-434a-9163-2b2d60a759d1@proton.me> <871q7o54el.fsf@metaspace.dk> <7ed2a8df-3088-42a1-b257-dba3c2c9fc92@proton.me> <87v84ysujo.fsf@metaspace.dk> <f405ff55-fcb0-4592-ae4b-e1188eae9953@proton.me> <87zfu9r8be.fsf@metaspace.dk>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.04.24 07:44, Andreas Hindborg wrote:
> Benno Lossin <benno.lossin@proton.me> writes:
>=20
>> On 03.04.24 10:46, Andreas Hindborg wrote:
>>> Benno Lossin <benno.lossin@proton.me> writes:
>>>
>>>> On 23.03.24 07:32, Andreas Hindborg wrote:
>>>>> Benno Lossin <benno.lossin@proton.me> writes:
>>>>>> On 3/13/24 12:05, Andreas Hindborg wrote:
>>>>>>> +//! implementations of the `Operations` trait.
>>>>>>> +//!
>>>>>>> +//! IO requests are passed to the driver as [`Request`] references=
 The
>>>>>>> +//! `Request` type is a wrapper around the C `struct request`. The=
 driver must
>>>>>>> +//! mark start of request processing by calling [`Request::start`]=
 and end of
>>>>>>> +//! processing by calling one of the [`Request::end`], methods. Fa=
ilure to do so
>>>>>>> +//! can lead to IO failures.
>>>>>>
>>>>>> I am unfamiliar with this, what are "IO failures"?
>>>>>> Do you think that it might be better to change the API to use a
>>>>>> callback? So instead of calling start and end, you would do
>>>>>>
>>>>>>         request.handle(|req| {
>>>>>>             // do the stuff that would be done between start and end
>>>>>>         });
>>>>>>
>>>>>> I took a quick look at the rnull driver and there you are calling
>>>>>> `Request::end_ok` from a different function. So my suggestion might =
not
>>>>>> be possible, since you really need the freedom.
>>>>>>
>>>>>> Do you think that a guard approach might work better? ie `start` ret=
urns
>>>>>> a guard that when dropped will call `end` and you need the guard to
>>>>>> operate on the request.
>>>>>
>>>>> I don't think that would fit, since the driver might not complete the
>>>>> request immediately. We might be able to call `start` on behalf of th=
e
>>>>> driver.
>>>>>
>>>>> At any rate, since the request is reference counted now, we can
>>>>> automatically fail a request when the last reference is dropped and i=
t
>>>>> was not marked successfully completed. I would need to measure the
>>>>> performance implications of such a feature.
>>>>
>>>> Are there cases where you still need access to the request after you
>>>> have called `end`?
>>>
>>> In general no, there is no need to handle the request after calling end=
.
>>> C drivers are not allowed to, because this transfers ownership of the
>>> request back to the block layer. This patch series defer the transfer o=
f
>>> ownership to the point when the ARef<Request> refcount goes to zero, so
>>> there should be no danger associated with touching the `Request` after
>>> end.
>>>
>>>> If no, I think it would be better for the request to
>>>> be consumed by the `end` function.
>>>> This is a bit difficult with `ARef`, since the user can just clone it
>>>> though... Do you think that it might be necessary to clone requests?
>>>
>>> Looking into the details now I see that calling `Request::end` more tha=
n
>>> once will trigger UAF, because C code decrements the refcount on the
>>> request. When we have `ARef<Request>` around, that is a problem. It
>>> probably also messes with other things in C land. Good catch.
>>>
>>> I did implement `Request::end` to consume the request at one point
>>> before I fell back on reference counting. It works fine for simple
>>> drivers. However, most drivers will need to use the block layer tag set
>>> service, that allows conversion of an integer id to a request pointer.
>>> The abstraction for this feature is not part of this patch set. But the
>>> block layer manages a mapping of integer to request mapping, and driver=
s
>>> typically use this to identify the request that corresponds to
>>> completion messages that arrive from hardware. When drivers are able to
>>> turn integers into requests like this, consuming the request in the cal=
l
>>> to `end` makes little sense (because we can just construct more).
>>
>> How do you ensure that this is fine?:
>>
>>       let r1 =3D tagset.get(0);
>>       let r2 =3D tagset.get(0);
>>       r1.end_ok();
>>       r2.do_something_that_would_only_be_done_while_active();
>>
>> One thing that comes to my mind would be to only give out `&Request`
>> from the tag set. And to destroy, you could have a separate operation
>> that also removes the request from the tag set. (I am thinking of a tag
>> set as a `HashMap<u64, Request>`.
>=20
> This would be similar to
>=20
>    let r1 =3D tagset.get(0)?;
>    ler r2 =3D r1.clone();
>    r1.end_ok();
>    r2.do_something_requires_active();
>=20
> but it is not a problem because we do not implement any actions that are
> illegal in that position (outside of `end` - that _is_ a problem).

Makes sense, but I think it's a bit weird to still be able to access it
after `end`ing.

>=20
>=20
>>>
>>> What I do now is issue the an `Option<ARef<Request>>` with
>>> `bindings::req_ref_inc_not_zero(rq_ptr)`, to make sure that the request
>>> is currently owned by the driver.
>>>
>>> I guess we can check the absolute value of the refcount, and only issue
>>> a request handle if the count matches what we expect. Then we can be ce=
rtain
>>> that the handle is unique, and we can require transfer of ownership of
>>> the handle to `Request::end` to make sure it can never be called more
>>> than once.
>>>
>>> Another option is to error out in `Request::end` if the
>>> refcount is not what we expect.
>>
>> I am a bit confused, why does the refcount matter in this case? Can't
>> the user just have multiple `ARef`s?
>=20
> Because we want to assert that we are consuming the last handle to the
> request. After we do that, the user cannot call `Request::end` again.
> `TagSet::get` will not issue a request reference if the request is not
> in flight. Although there might be a race condition to watch out for.
>=20
> When the block layer hands over ownership to Rust, the reference count
> is 1. The first `ARef<Request>` we create increments the count to 2. To
> complete the request, we must have ownership of all reference counts
> above 1. The block layer takes the last reference count when it takes
> back ownership of the request.
>=20
>> I think it would be weird to use `ARef<Request>` if you expect the
>> refcount to be 1.
>=20
> Yes, that would require a custom smart pointer with a `try_into_unique`
> method that succeeds when the refcount is exactly 2. It would consume
> the instance and decrement the refcount to 1. But as I said, there is a
> potential race with `TagSet::get` when the refcount is 1 that needs to
> be handled.
>=20
>> Maybe the API should be different?
>=20
> I needs to change a little, yes.
>=20
>> As I understand it, a request has the following life cycle (please
>> correct me if I am wrong):
>> 1. A new request is created, it is given to the driver via `queue_rq`.
>> 2. The driver can now decide what to do with it (theoretically it can
>>      store it somewhere and later do something with it), but it should a=
t
>>      some point call `Request::start`.
>> 3. Work happens and eventually the driver calls `Request::end`.
>>
>> To me this does not seem like something where we need a refcount (we
>> still might need one for safety, but it does not need to be exposed to
>> the user).
>=20
> It would not need to be exposed to the user, other than a) ending a reque=
st
> can fail OR b) `TagSet::get` can fail.
>=20
> a) would require that ending a request must be done with a unique
> reference. This could be done by the user by the user calling
> `try_into_unique` or by making the `end` method fallible.
>=20
> b) would make the reference handle `!Clone` and add a failure mode to
> `TagSet::get`, so it fails to construct a `Request` handle if there are
> already one in existence.
>=20
> I gravitate towards a) because it allows the user to clone the Request
> reference without adding an additional `Arc`.

This confuses me a little, since I thought that `TagSet::get` returns
`Option<ARef<Request>>`. (I tried to find the abstractions in your
github, but I did not find them)

I think that this could work: `queue_rq` takes a `OwnedRequest`, which
the user can store in a `TagSet`, transferring ownership. `TagSet::get`
returns `Option<&Request>` and you can call `TagSet::remove` to get
`Option<OwnedRequest>`. `OwnedRequest::end` consumes `self`.
With this pattern we also do not need to take an additional refcount.

--=20
Cheers,
Benno


