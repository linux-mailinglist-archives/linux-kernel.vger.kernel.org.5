Return-Path: <linux-kernel+bounces-131495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0098988AB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6A2287710
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB549127B46;
	Thu,  4 Apr 2024 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lf765HlK"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ECA2E401;
	Thu,  4 Apr 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712236831; cv=none; b=oJW9Oj4t4PUnAYGSSpUFfEQK8rOfWl8fiBhWVA80RCn3mbGthCis33s9Er8x0sYLH0TFhx94kowlE5kHGkCBDmzmsLbz+9LKX7hNYvzjB5ZvQxEqhOggOJvjKuxoEO8rF9LBc4EndPmLC8L2XhZmniZMuzNno4ElMsf6r0e9NI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712236831; c=relaxed/simple;
	bh=57w9upBLD/w1bCdmZ7Gy2UAo+147YcfI++FU5OhZJmM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uEG9MUT5pUZIcyjTxdSfNYOvcBnZWG5chQ4YOS3RsEwUgG3Wat6lhOKavl0kGcuyOguKH4eTQ+I8Or406bXFLlZ45Xo7g2sRd9z5o2tcZpfLCMQHdrXNwJNuoz2baZunKV8AKmBPQZksfG2rkWgP924psJ4dMX0RTBlYsn1D/Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lf765HlK; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712236825; x=1712496025;
	bh=/TsecV+IUNKa15+U1QH6Z/NWD1nKrQANvo4sIBQMwK0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lf765HlKv6leEQxUKkgDm3P5IeeqTCIAMvyG8ehExfS6BFelrzWL2bNXO7QBGPA+3
	 RFqe7x83GolE8f+05Y7D8k7aoIO06CZtFeswJ+BOdJxfqvmhIjsxBz+gIuwwsdONCt
	 M63JeyLXktEWdaRFweyMjqEdY01ll5q239Z7L4RH0ksqsKHwd8p0edXg0M+7x/mNTm
	 WMel9NUj/AcUQdas9zent2Nb6Y0Gr4k5xMSZT4plceTzWIWOxpqrUoxFDn2lsdoofx
	 +56iULiHMYT3/VLt8ZJvZI8hxafGVHSB1Iv2FbtSkmouzch3A3DK+06rPALsI84k35
	 Q4Jy80sKGVBKw==
Date: Thu, 04 Apr 2024 13:20:17 +0000
To: Andreas Hindborg <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Andreas Hindborg <a.hindborg@samsung.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>, =?utf-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, Joel Granados <j.granados@samsung.com>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez
	<da.gomez@samsung.com>, open list <linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [RFC PATCH 1/5] rust: block: introduce `kernel::block::mq` module
Message-ID: <7d64cb7b-0957-4acc-914a-3c950660ad07@proton.me>
In-Reply-To: <87frw1qxuv.fsf@metaspace.dk>
References: <86cd5566-5f1b-434a-9163-2b2d60a759d1@proton.me> <871q7o54el.fsf@metaspace.dk> <7ed2a8df-3088-42a1-b257-dba3c2c9fc92@proton.me> <87v84ysujo.fsf@metaspace.dk> <f405ff55-fcb0-4592-ae4b-e1188eae9953@proton.me> <87zfu9r8be.fsf@metaspace.dk> <3478efc2-7e81-4688-a115-5d33c70a24aa@proton.me> <87frw1qxuv.fsf@metaspace.dk>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.04.24 11:30, Andreas Hindborg wrote:
> Benno Lossin <benno.lossin@proton.me> writes:
>=20
>> On 04.04.24 07:44, Andreas Hindborg wrote:
>>> Benno Lossin <benno.lossin@proton.me> writes:
>>>
>>>> On 03.04.24 10:46, Andreas Hindborg wrote:
>>>>> Benno Lossin <benno.lossin@proton.me> writes:
>>>>>
>>>>>> On 23.03.24 07:32, Andreas Hindborg wrote:
>>>>>>> Benno Lossin <benno.lossin@proton.me> writes:
>>>>>>>> On 3/13/24 12:05, Andreas Hindborg wrote:
>>>>>>>>> +//! implementations of the `Operations` trait.
>>>>>>>>> +//!
>>>>>>>>> +//! IO requests are passed to the driver as [`Request`] referenc=
es. The
>>>>>>>>> +//! `Request` type is a wrapper around the C `struct request`. T=
he driver must
>>>>>>>>> +//! mark start of request processing by calling [`Request::start=
`] and end of
>>>>>>>>> +//! processing by calling one of the [`Request::end`], methods. =
Failure to do so
>>>>>>>>> +//! can lead to IO failures.
>>>>>>>>
>>>>>>>> I am unfamiliar with this, what are "IO failures"?
>>>>>>>> Do you think that it might be better to change the API to use a
>>>>>>>> callback? So instead of calling start and end, you would do
>>>>>>>>
>>>>>>>>          request.handle(|req| {
>>>>>>>>              // do the stuff that would be done between start and =
end
>>>>>>>>          });
>>>>>>>>
>>>>>>>> I took a quick look at the rnull driver and there you are calling
>>>>>>>> `Request::end_ok` from a different function. So my suggestion migh=
t not
>>>>>>>> be possible, since you really need the freedom.
>>>>>>>>
>>>>>>>> Do you think that a guard approach might work better? ie `start` r=
eturns
>>>>>>>> a guard that when dropped will call `end` and you need the guard t=
o
>>>>>>>> operate on the request.
>>>>>>>
>>>>>>> I don't think that would fit, since the driver might not complete t=
he
>>>>>>> request immediately. We might be able to call `start` on behalf of =
the
>>>>>>> driver.
>>>>>>>
>>>>>>> At any rate, since the request is reference counted now, we can
>>>>>>> automatically fail a request when the last reference is dropped and=
 it
>>>>>>> was not marked successfully completed. I would need to measure the
>>>>>>> performance implications of such a feature.
>>>>>>
>>>>>> Are there cases where you still need access to the request after you
>>>>>> have called `end`?
>>>>>
>>>>> In general no, there is no need to handle the request after calling e=
nd.
>>>>> C drivers are not allowed to, because this transfers ownership of the
>>>>> request back to the block layer. This patch series defer the transfer=
 of
>>>>> ownership to the point when the ARef<Request> refcount goes to zero, =
so
>>>>> there should be no danger associated with touching the `Request` afte=
r
>>>>> end.
>>>>>
>>>>>> If no, I think it would be better for the request to
>>>>>> be consumed by the `end` function.
>>>>>> This is a bit difficult with `ARef`, since the user can just clone i=
t
>>>>>> though... Do you think that it might be necessary to clone requests?
>>>>>
>>>>> Looking into the details now I see that calling `Request::end` more t=
han
>>>>> once will trigger UAF, because C code decrements the refcount on the
>>>>> request. When we have `ARef<Request>` around, that is a problem. It
>>>>> probably also messes with other things in C land. Good catch.
>>>>>
>>>>> I did implement `Request::end` to consume the request at one point
>>>>> before I fell back on reference counting. It works fine for simple
>>>>> drivers. However, most drivers will need to use the block layer tag s=
et
>>>>> service, that allows conversion of an integer id to a request pointer=
.
>>>>> The abstraction for this feature is not part of this patch set. But t=
he
>>>>> block layer manages a mapping of integer to request mapping, and driv=
ers
>>>>> typically use this to identify the request that corresponds to
>>>>> completion messages that arrive from hardware. When drivers are able =
to
>>>>> turn integers into requests like this, consuming the request in the c=
all
>>>>> to `end` makes little sense (because we can just construct more).
>>>>
>>>> How do you ensure that this is fine?:
>>>>
>>>>        let r1 =3D tagset.get(0);
>>>>        let r2 =3D tagset.get(0);
>>>>        r1.end_ok();
>>>>        r2.do_something_that_would_only_be_done_while_active();
>>>>
>>>> One thing that comes to my mind would be to only give out `&Request`
>>>> from the tag set. And to destroy, you could have a separate operation
>>>> that also removes the request from the tag set. (I am thinking of a ta=
g
>>>> set as a `HashMap<u64, Request>`.
>>>
>>> This would be similar to
>>>
>>>     let r1 =3D tagset.get(0)?;
>>>     ler r2 =3D r1.clone();
>>>     r1.end_ok();
>>>     r2.do_something_requires_active();
>>>
>>> but it is not a problem because we do not implement any actions that ar=
e
>>> illegal in that position (outside of `end` - that _is_ a problem).
>>
>> Makes sense, but I think it's a bit weird to still be able to access it
>> after `end`ing.
>=20
> Yes, that is true.
>=20
>>
>>>
>>>
>>>>>
>>>>> What I do now is issue the an `Option<ARef<Request>>` with
>>>>> `bindings::req_ref_inc_not_zero(rq_ptr)`, to make sure that the reque=
st
>>>>> is currently owned by the driver.
>>>>>
>>>>> I guess we can check the absolute value of the refcount, and only iss=
ue
>>>>> a request handle if the count matches what we expect. Then we can be =
certain
>>>>> that the handle is unique, and we can require transfer of ownership o=
f
>>>>> the handle to `Request::end` to make sure it can never be called more
>>>>> than once.
>>>>>
>>>>> Another option is to error out in `Request::end` if the
>>>>> refcount is not what we expect.
>>>>
>>>> I am a bit confused, why does the refcount matter in this case? Can't
>>>> the user just have multiple `ARef`s?
>>>
>>> Because we want to assert that we are consuming the last handle to the
>>> request. After we do that, the user cannot call `Request::end` again.
>>> `TagSet::get` will not issue a request reference if the request is not
>>> in flight. Although there might be a race condition to watch out for.
>>>
>>> When the block layer hands over ownership to Rust, the reference count
>>> is 1. The first `ARef<Request>` we create increments the count to 2. To
>>> complete the request, we must have ownership of all reference counts
>>> above 1. The block layer takes the last reference count when it takes
>>> back ownership of the request.
>>>
>>>> I think it would be weird to use `ARef<Request>` if you expect the
>>>> refcount to be 1.
>>>
>>> Yes, that would require a custom smart pointer with a `try_into_unique`
>>> method that succeeds when the refcount is exactly 2. It would consume
>>> the instance and decrement the refcount to 1. But as I said, there is a
>>> potential race with `TagSet::get` when the refcount is 1 that needs to
>>> be handled.
>>>
>>>> Maybe the API should be different?
>>>
>>> I needs to change a little, yes.
>>>
>>>> As I understand it, a request has the following life cycle (please
>>>> correct me if I am wrong):
>>>> 1. A new request is created, it is given to the driver via `queue_rq`.
>>>> 2. The driver can now decide what to do with it (theoretically it can
>>>>       store it somewhere and later do something with it), but it shoul=
d at
>>>>       some point call `Request::start`.
>>>> 3. Work happens and eventually the driver calls `Request::end`.
>>>>
>>>> To me this does not seem like something where we need a refcount (we
>>>> still might need one for safety, but it does not need to be exposed to
>>>> the user).
>>>
>>> It would not need to be exposed to the user, other than a) ending a req=
uest
>>> can fail OR b) `TagSet::get` can fail.
>>>
>>> a) would require that ending a request must be done with a unique
>>> reference. This could be done by the user by the user calling
>>> `try_into_unique` or by making the `end` method fallible.
>>>
>>> b) would make the reference handle `!Clone` and add a failure mode to
>>> `TagSet::get`, so it fails to construct a `Request` handle if there are
>>> already one in existence.
>>>
>>> I gravitate towards a) because it allows the user to clone the Request
>>> reference without adding an additional `Arc`.
>>
>> This confuses me a little, since I thought that `TagSet::get` returns
>> `Option<ARef<Request>>`.
>=20
> It does, but in the current implementation the failure mode returning
> `None` is triggered when the refcount is zero, meaning that the request
> corresponding to that tag is not currently owned by the driver. For
> solution b) we would change the type to be
> `Option<CustomSmartPointerHandleThing<Request>>`.
>=20
>> (I tried to find the abstractions in your
>> github, but I did not find them)
>=20
> It's here [1]. It was introduced in the `rnvme-v6.8` branch.

Thanks for the pointer.

>> I think that this could work: `queue_rq` takes a `OwnedRequest`, which
>> the user can store in a `TagSet`, transferring ownership. `TagSet::get`
>> returns `Option<&Request>` and you can call `TagSet::remove` to get
>> `Option<OwnedRequest>`. `OwnedRequest::end` consumes `self`.
>> With this pattern we also do not need to take an additional refcount.
>=20
> It would, but the `TagSet` is just a wrapper for the C block layer
> `strugt blk_mq_tag_set`. This is a highly optimized data structure and
> tag mapping is done before the driver sees the request. I would like to
> reuse that logic.
>=20
> We could implement what you suggest anyhow, but I would not want to that
> additional logic to the hot path.

I overlooked an important detail: the `TagSet` is always stored in an
`Arc` (IIRC since you want to be able to share it between different
`Gendisk`s). This probably makes my suggestion impossible, since you
can't mutably borrow the `TagSet` for removal of `Request`s.
Depending on how `Request`s are associated to a `TagSet`, there might be
a way around this: I saw the `qid` parameter to the `tag_to_rq`
function, is that a unique identifier for a queue? Because in that case
we might be able to have a unique `QueueTagSetRef` with

     fn remove(&mut self, tag: u32) -> OwnedRequest;

     fn get(&self, tag: u32) -> Option<&Request>;

The `TagSet` would still be shared, only the ability to "remove" (I
don't know if you do that manually in C, if not, then this would just
remove it in the abstraction, but keep it on the C side) is unique to
the `QueueTagSetRef` struct.

But feel free to use your proposed option a), it is simpler and we can
try to make this work when you send the `TagSet` abstractions.
I just think that we should try a bit harder to make it even better.

--=20
Cheers,
Benno


