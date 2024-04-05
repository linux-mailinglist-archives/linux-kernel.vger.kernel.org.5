Return-Path: <linux-kernel+bounces-132755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53C58999C0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9ACA1C2149D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2978160794;
	Fri,  5 Apr 2024 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Jb+Hv4lg"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB0215FA9C;
	Fri,  5 Apr 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310030; cv=none; b=tSIKSiQ/Kg/N0bIm/Vr+MC4kSI6yl4yCllyxIjiqw7+VMnIvFdptWQF9szaWs3N2KTPi4Y5xja7YDt6uD/8RlgjrPIXZb8ImGM6woTsudYy63azQXdJ7naBk0hd5PUETWdpIg6v1ghqZZgNii/rJ7b6i0H6EwYuw216eV1nExT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310030; c=relaxed/simple;
	bh=8drT0GLOZkPmACYruwMyCFQj0gkFYEO5agjMHKeluLk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aOTO9xJyGNgftQkpXzrA2cao4mb0AqdXMn+0fVXKVI/YBRHNPqWZ+CG/lpIozTZBV1/xSJnZLDRyTsTENEYoLySgB7BrSHCe3OO863nZESab1f8Hn2uWzKBh62BL3gEQIGlPq70J/a4n5SiITZ9ShKGGij+fqLrThl/DRGT1wtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Jb+Hv4lg; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712310020; x=1712569220;
	bh=qclyYZ6klEPqLb0X2h9dxn3Q7kyRZ7Hcf+UoavLCo40=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Jb+Hv4lgt4s3YrTO5E+FyCqMgSdfdc+85PaJRc8gpRKpMvhE5HnegnA5E1jsePn4S
	 jpgqfozjlQE9XwL8tgECa7mo76//yA+PpS+ht2/rGpQiCZ5ootvTU72tV4kk0O8ul7
	 a0iUEFf7VeEaS9LFV1WGI/PO8SfsOrqXRc6DIJgYyqBNRpRvDDWtw4WKDYhDg/VuQ9
	 f+PqdYm9hN/eBbMYSPTAaoyOeuCJ8G8qi5RBtwlVFlIHUPx2F7/0w+DzXoeW3w7QS4
	 kMqwxdUpz9okOAmoVjXDRkaa1IysgOHyDpVt8GAAWFCvdACry0N/HxYADL5YYZRn/6
	 5XhxgNswW2cRg==
Date: Fri, 05 Apr 2024 09:40:16 +0000
To: Andreas Hindborg <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Andreas Hindborg <a.hindborg@samsung.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>, =?utf-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, Joel Granados <j.granados@samsung.com>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez
	<da.gomez@samsung.com>, open list <linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [RFC PATCH 1/5] rust: block: introduce `kernel::block::mq` module
Message-ID: <ab496a96-b9a2-4fc2-94ad-1691a9f133fd@proton.me>
In-Reply-To: <875xwwmc78.fsf@metaspace.dk>
References: <86cd5566-5f1b-434a-9163-2b2d60a759d1@proton.me> <871q7o54el.fsf@metaspace.dk> <7ed2a8df-3088-42a1-b257-dba3c2c9fc92@proton.me> <87v84ysujo.fsf@metaspace.dk> <f405ff55-fcb0-4592-ae4b-e1188eae9953@proton.me> <87zfu9r8be.fsf@metaspace.dk> <3478efc2-7e81-4688-a115-5d33c70a24aa@proton.me> <87frw1qxuv.fsf@metaspace.dk> <7d64cb7b-0957-4acc-914a-3c950660ad07@proton.me> <875xwwmc78.fsf@metaspace.dk>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.04.24 10:43, Andreas Hindborg wrote:
> Benno Lossin <benno.lossin@proton.me> writes:
>=20
>> On 04.04.24 11:30, Andreas Hindborg wrote:
>>> Benno Lossin <benno.lossin@proton.me> writes:
>>>
>>>> On 04.04.24 07:44, Andreas Hindborg wrote:
>>>>> Benno Lossin <benno.lossin@proton.me> writes:
>>>>>
>>>>>> On 03.04.24 10:46, Andreas Hindborg wrote:
>>>>>>> Benno Lossin <benno.lossin@proton.me> writes:
>>>>>>>
>>>>>>>> On 23.03.24 07:32, Andreas Hindborg wrote:
>>>>>>>>> Benno Lossin <benno.lossin@proton.me> writes:
>>>>>>>>>> On 3/13/24 12:05, Andreas Hindborg wrote:
>>>>>>>>>>> +//! implementations of the `Operations` trait.
>>>>>>>>>>> +//!
>>>>>>>>>>> +//! IO requests are passed to the driver as [`Request`] refere=
nces. The
>>>>>>>>>>> +//! `Request` type is a wrapper around the C `struct request`.=
 The driver must
>>>>>>>>>>> +//! mark start of request processing by calling [`Request::sta=
rt`] and end of
>>>>>>>>>>> +//! processing by calling one of the [`Request::end`], methods=
 Failure to do so
>>>>>>>>>>> +//! can lead to IO failures.
>>>>>>>>>>
>>>>>>>>>> I am unfamiliar with this, what are "IO failures"?
>>>>>>>>>> Do you think that it might be better to change the API to use a
>>>>>>>>>> callback? So instead of calling start and end, you would do
>>>>>>>>>>
>>>>>>>>>>           request.handle(|req| {
>>>>>>>>>>               // do the stuff that would be done between start a=
nd end
>>>>>>>>>>           });
>>>>>>>>>>
>>>>>>>>>> I took a quick look at the rnull driver and there you are callin=
g
>>>>>>>>>> `Request::end_ok` from a different function. So my suggestion mi=
ght not
>>>>>>>>>> be possible, since you really need the freedom.
>>>>>>>>>>
>>>>>>>>>> Do you think that a guard approach might work better? ie `start`=
 returns
>>>>>>>>>> a guard that when dropped will call `end` and you need the guard=
 to
>>>>>>>>>> operate on the request.
>>>>>>>>>
>>>>>>>>> I don't think that would fit, since the driver might not complete=
 the
>>>>>>>>> request immediately. We might be able to call `start` on behalf o=
f the
>>>>>>>>> driver.
>>>>>>>>>
>>>>>>>>> At any rate, since the request is reference counted now, we can
>>>>>>>>> automatically fail a request when the last reference is dropped a=
nd it
>>>>>>>>> was not marked successfully completed. I would need to measure th=
e
>>>>>>>>> performance implications of such a feature.
>>>>>>>>
>>>>>>>> Are there cases where you still need access to the request after y=
ou
>>>>>>>> have called `end`?
>>>>>>>
>>>>>>> In general no, there is no need to handle the request after calling=
 end.
>>>>>>> C drivers are not allowed to, because this transfers ownership of t=
he
>>>>>>> request back to the block layer. This patch series defer the transf=
er of
>>>>>>> ownership to the point when the ARef<Request> refcount goes to zero=
, so
>>>>>>> there should be no danger associated with touching the `Request` af=
ter
>>>>>>> end.
>>>>>>>
>>>>>>>> If no, I think it would be better for the request to
>>>>>>>> be consumed by the `end` function.
>>>>>>>> This is a bit difficult with `ARef`, since the user can just clone=
 it
>>>>>>>> though... Do you think that it might be necessary to clone request=
s?
>>>>>>>
>>>>>>> Looking into the details now I see that calling `Request::end` more=
 than
>>>>>>> once will trigger UAF, because C code decrements the refcount on th=
e
>>>>>>> request. When we have `ARef<Request>` around, that is a problem. It
>>>>>>> probably also messes with other things in C land. Good catch.
>>>>>>>
>>>>>>> I did implement `Request::end` to consume the request at one point
>>>>>>> before I fell back on reference counting. It works fine for simple
>>>>>>> drivers. However, most drivers will need to use the block layer tag=
 set
>>>>>>> service, that allows conversion of an integer id to a request point=
er.
>>>>>>> The abstraction for this feature is not part of this patch set. But=
 the
>>>>>>> block layer manages a mapping of integer to request mapping, and dr=
ivers
>>>>>>> typically use this to identify the request that corresponds to
>>>>>>> completion messages that arrive from hardware. When drivers are abl=
e to
>>>>>>> turn integers into requests like this, consuming the request in the=
 call
>>>>>>> to `end` makes little sense (because we can just construct more).
>>>>>>
>>>>>> How do you ensure that this is fine?:
>>>>>>
>>>>>>         let r1 =3D tagset.get(0);
>>>>>>         let r2 =3D tagset.get(0);
>>>>>>         r1.end_ok();
>>>>>>         r2.do_something_that_would_only_be_done_while_active();
>>>>>>
>>>>>> One thing that comes to my mind would be to only give out `&Request`
>>>>>> from the tag set. And to destroy, you could have a separate operatio=
n
>>>>>> that also removes the request from the tag set. (I am thinking of a =
tag
>>>>>> set as a `HashMap<u64, Request>`.
>>>>>
>>>>> This would be similar to
>>>>>
>>>>>      let r1 =3D tagset.get(0)?;
>>>>>      ler r2 =3D r1.clone();
>>>>>      r1.end_ok();
>>>>>      r2.do_something_requires_active();
>>>>>
>>>>> but it is not a problem because we do not implement any actions that =
are
>>>>> illegal in that position (outside of `end` - that _is_ a problem).
>>>>
>>>> Makes sense, but I think it's a bit weird to still be able to access i=
t
>>>> after `end`ing.
>>>
>>> Yes, that is true.
>>>
>>>>
>>>>>
>>>>>
>>>>>>>
>>>>>>> What I do now is issue the an `Option<ARef<Request>>` with
>>>>>>> `bindings::req_ref_inc_not_zero(rq_ptr)`, to make sure that the req=
uest
>>>>>>> is currently owned by the driver.
>>>>>>>
>>>>>>> I guess we can check the absolute value of the refcount, and only i=
ssue
>>>>>>> a request handle if the count matches what we expect. Then we can b=
e certain
>>>>>>> that the handle is unique, and we can require transfer of ownership=
 of
>>>>>>> the handle to `Request::end` to make sure it can never be called mo=
re
>>>>>>> than once.
>>>>>>>
>>>>>>> Another option is to error out in `Request::end` if the
>>>>>>> refcount is not what we expect.
>>>>>>
>>>>>> I am a bit confused, why does the refcount matter in this case? Can'=
t
>>>>>> the user just have multiple `ARef`s?
>>>>>
>>>>> Because we want to assert that we are consuming the last handle to th=
e
>>>>> request. After we do that, the user cannot call `Request::end` again.
>>>>> `TagSet::get` will not issue a request reference if the request is no=
t
>>>>> in flight. Although there might be a race condition to watch out for.
>>>>>
>>>>> When the block layer hands over ownership to Rust, the reference coun=
t
>>>>> is 1. The first `ARef<Request>` we create increments the count to 2. =
To
>>>>> complete the request, we must have ownership of all reference counts
>>>>> above 1. The block layer takes the last reference count when it takes
>>>>> back ownership of the request.
>>>>>
>>>>>> I think it would be weird to use `ARef<Request>` if you expect the
>>>>>> refcount to be 1.
>>>>>
>>>>> Yes, that would require a custom smart pointer with a `try_into_uniqu=
e`
>>>>> method that succeeds when the refcount is exactly 2. It would consume
>>>>> the instance and decrement the refcount to 1. But as I said, there is=
 a
>>>>> potential race with `TagSet::get` when the refcount is 1 that needs t=
o
>>>>> be handled.
>>>>>
>>>>>> Maybe the API should be different?
>>>>>
>>>>> I needs to change a little, yes.
>>>>>
>>>>>> As I understand it, a request has the following life cycle (please
>>>>>> correct me if I am wrong):
>>>>>> 1. A new request is created, it is given to the driver via `queue_rq=
`.
>>>>>> 2. The driver can now decide what to do with it (theoretically it ca=
n
>>>>>>        store it somewhere and later do something with it), but it sh=
ould at
>>>>>>        some point call `Request::start`.
>>>>>> 3. Work happens and eventually the driver calls `Request::end`.
>>>>>>
>>>>>> To me this does not seem like something where we need a refcount (we
>>>>>> still might need one for safety, but it does not need to be exposed =
to
>>>>>> the user).
>>>>>
>>>>> It would not need to be exposed to the user, other than a) ending a r=
equest
>>>>> can fail OR b) `TagSet::get` can fail.
>>>>>
>>>>> a) would require that ending a request must be done with a unique
>>>>> reference. This could be done by the user by the user calling
>>>>> `try_into_unique` or by making the `end` method fallible.
>>>>>
>>>>> b) would make the reference handle `!Clone` and add a failure mode to
>>>>> `TagSet::get`, so it fails to construct a `Request` handle if there a=
re
>>>>> already one in existence.
>>>>>
>>>>> I gravitate towards a) because it allows the user to clone the Reques=
t
>>>>> reference without adding an additional `Arc`.
>>>>
>>>> This confuses me a little, since I thought that `TagSet::get` returns
>>>> `Option<ARef<Request>>`.
>>>
>>> It does, but in the current implementation the failure mode returning
>>> `None` is triggered when the refcount is zero, meaning that the request
>>> corresponding to that tag is not currently owned by the driver. For
>>> solution b) we would change the type to be
>>> `Option<CustomSmartPointerHandleThing<Request>>`.
>>>
>>>> (I tried to find the abstractions in your
>>>> github, but I did not find them)
>>>
>>> It's here [1]. It was introduced in the `rnvme-v6.8` branch.
>>
>> Thanks for the pointer.
>>
>>>> I think that this could work: `queue_rq` takes a `OwnedRequest`, which
>>>> the user can store in a `TagSet`, transferring ownership. `TagSet::get=
`
>>>> returns `Option<&Request>` and you can call `TagSet::remove` to get
>>>> `Option<OwnedRequest>`. `OwnedRequest::end` consumes `self`.
>>>> With this pattern we also do not need to take an additional refcount.
>>>
>>> It would, but the `TagSet` is just a wrapper for the C block layer
>>> `strugt blk_mq_tag_set`. This is a highly optimized data structure and
>>> tag mapping is done before the driver sees the request. I would like to
>>> reuse that logic.
>>>
>>> We could implement what you suggest anyhow, but I would not want to tha=
t
>>> additional logic to the hot path.
>>
>> I overlooked an important detail: the `TagSet` is always stored in an
>> `Arc` (IIRC since you want to be able to share it between different
>> `Gendisk`s). This probably makes my suggestion impossible, since you
>> can't mutably borrow the `TagSet` for removal of `Request`s.
>> Depending on how `Request`s are associated to a `TagSet`, there might be
>> a way around this: I saw the `qid` parameter to the `tag_to_rq`
>> function, is that a unique identifier for a queue?
>=20
> A tag set services a number of request queues. Each queue has a number
> used to identify it within the tag set. It is unique within the tag set.
>=20
>> Because in that case
>> we might be able to have a unique `QueueTagSetRef` with
>>
>>       fn remove(&mut self, tag: u32) -> OwnedRequest;
>=20
> We would not need exclusive access. The tag set remove are synchronized
> internally with some fancy atomic bit flipping [1].

If we bind the ability to call `Request::end` to `OwnedRequest` and
require exclusive access to the `QueueTagSetRef`, then we could ensure
that the `end` function is only called once.

>>
>>       fn get(&self, tag: u32) -> Option<&Request>;
>>
>> The `TagSet` would still be shared, only the ability to "remove" (I
>> don't know if you do that manually in C, if not, then this would just
>> remove it in the abstraction, but keep it on the C side) is unique to
>> the `QueueTagSetRef` struct.
>=20
> I would not advice removing tag->request associations from the driver. I
> understand your point and from the perspective of these patches it makes
> sense. But it would be a major layer violation of the current block
> layer architecture, as far as I can tell.

Ah I should have specified this better: we don't remove the request from
the C side, only from the `TagSet` Rust abstraction. Maybe a better name
would be `end_request` (the function would then return bool to indicate
if there was a request with that tag).

> I am having trouble enough trying to justify deferred free of the
> request structure as it is.

Using this approach, there also would not be a deferred free, as we
would call `end` immediately, right?

>> But feel free to use your proposed option a), it is simpler and we can
>> try to make this work when you send the `TagSet` abstractions.
>> I just think that we should try a bit harder to make it even better.
>=20
> I'll code it up a) and see how it looks (and what it costs in
> performance) =F0=9F=91=8D

Sure.

We can also speak about this in the meeting, I have the feeling that
that would be easier than trying via mail :)

--=20
Cheers,
Benno


