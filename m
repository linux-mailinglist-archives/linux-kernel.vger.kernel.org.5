Return-Path: <linux-kernel+bounces-130512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E3789791F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16F3FB26355
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7D3155398;
	Wed,  3 Apr 2024 19:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eRTf/YaV"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF101401C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 19:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712173074; cv=none; b=dE+/TCCj1dpUNpDZ7ahneZWRi7dZvcECaJqU+o6bvAEL/wYHoGXa4ChlNQMiOBWn+TGuGw17eWloBteNipEKAQUnNicdO5NgLenZIiKDfTFEJhOSzKRV61EmIxRRuW73RaUq+IqgFbZN5A2VgdszNIzk/vQWsz1KKo+h/s3wpJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712173074; c=relaxed/simple;
	bh=dXEOpxiE2RCJ9FBYM438Z1FVC+BmQcHQgxYhuc5OAqM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rMrWqSuapPKQpJPaXvLSU5IVw7MuDLDmZ7ls65pMN5H9Rtt0UY5/4weA0D61c9cBQ6QH022jMI2h03CaVZ7jbbTCnqrfOeWNN+40bvkeMdQArjTJZNYc71DrTALPzoC/NH/tei/DyfVvADF6IgRQ+7Vd4IvQpwFm48BU95ceiVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=eRTf/YaV; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712173069; x=1712432269;
	bh=vLw1EUqqXu0E0eV8EO0iY5ZyKumQlE4AJba1Jz1x2ok=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eRTf/YaVgrIkJNR0WTMp4U/nw7/iMQrP+XEuzQm95Y6Cbc0k5V8oyCBAXcj0uwPg2
	 JrZ2mrYoc8XBDwj9LyX3Ovhz9XVubhjCTrQZBXMMrPrLG+hOSxKqjBYODcxhwtBks6
	 PFCf3LWUNfdeWlv4+xxO0GZdsC6Zev7ge0xZZBzk5D+kYVjRx05iXRU4HGd1h/1RH0
	 qZ+Oa2anQp9jKemSCTS8RtOZ7JnZVVH0aZjGVsKHXBu+XEI9ytSajehXXIv+9SQhIq
	 Dy5WlMhBwmmY5/UlVzj+p0gRP5nmF0uRI0Jky7TMOrrNnshpAg6+mqEe1tJ5+E3jgT
	 nb7KeDofat4RQ==
Date: Wed, 03 Apr 2024 19:37:44 +0000
To: Andreas Hindborg <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Andreas Hindborg <a.hindborg@samsung.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>, =?utf-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, Joel Granados <j.granados@samsung.com>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez
	<da.gomez@samsung.com>, open list <linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [RFC PATCH 1/5] rust: block: introduce `kernel::block::mq` module
Message-ID: <f405ff55-fcb0-4592-ae4b-e1188eae9953@proton.me>
In-Reply-To: <87v84ysujo.fsf@metaspace.dk>
References: <86cd5566-5f1b-434a-9163-2b2d60a759d1@proton.me> <871q7o54el.fsf@metaspace.dk> <7ed2a8df-3088-42a1-b257-dba3c2c9fc92@proton.me> <87v84ysujo.fsf@metaspace.dk>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.04.24 10:46, Andreas Hindborg wrote:
> Benno Lossin <benno.lossin@proton.me> writes:
>=20
>> On 23.03.24 07:32, Andreas Hindborg wrote:
>>> Benno Lossin <benno.lossin@proton.me> writes:
>>>> On 3/13/24 12:05, Andreas Hindborg wrote:
>>>>> +//! implementations of the `Operations` trait.
>>>>> +//!
>>>>> +//! IO requests are passed to the driver as [`Request`] references. =
The
>>>>> +//! `Request` type is a wrapper around the C `struct request`. The d=
river must
>>>>> +//! mark start of request processing by calling [`Request::start`] a=
nd end of
>>>>> +//! processing by calling one of the [`Request::end`], methods. Fail=
ure to do so
>>>>> +//! can lead to IO failures.
>>>>
>>>> I am unfamiliar with this, what are "IO failures"?
>>>> Do you think that it might be better to change the API to use a
>>>> callback? So instead of calling start and end, you would do
>>>>
>>>>        request.handle(|req| {
>>>>            // do the stuff that would be done between start and end
>>>>        });
>>>>
>>>> I took a quick look at the rnull driver and there you are calling
>>>> `Request::end_ok` from a different function. So my suggestion might no=
t
>>>> be possible, since you really need the freedom.
>>>>
>>>> Do you think that a guard approach might work better? ie `start` retur=
ns
>>>> a guard that when dropped will call `end` and you need the guard to
>>>> operate on the request.
>>>
>>> I don't think that would fit, since the driver might not complete the
>>> request immediately. We might be able to call `start` on behalf of the
>>> driver.
>>>
>>> At any rate, since the request is reference counted now, we can
>>> automatically fail a request when the last reference is dropped and it
>>> was not marked successfully completed. I would need to measure the
>>> performance implications of such a feature.
>>
>> Are there cases where you still need access to the request after you
>> have called `end`?
>=20
> In general no, there is no need to handle the request after calling end.
> C drivers are not allowed to, because this transfers ownership of the
> request back to the block layer. This patch series defer the transfer of
> ownership to the point when the ARef<Request> refcount goes to zero, so
> there should be no danger associated with touching the `Request` after
> end.
>=20
>> If no, I think it would be better for the request to
>> be consumed by the `end` function.
>> This is a bit difficult with `ARef`, since the user can just clone it
>> though... Do you think that it might be necessary to clone requests?
>=20
> Looking into the details now I see that calling `Request::end` more than
> once will trigger UAF, because C code decrements the refcount on the
> request. When we have `ARef<Request>` around, that is a problem. It
> probably also messes with other things in C land. Good catch.
>=20
> I did implement `Request::end` to consume the request at one point
> before I fell back on reference counting. It works fine for simple
> drivers. However, most drivers will need to use the block layer tag set
> service, that allows conversion of an integer id to a request pointer.
> The abstraction for this feature is not part of this patch set. But the
> block layer manages a mapping of integer to request mapping, and drivers
> typically use this to identify the request that corresponds to
> completion messages that arrive from hardware. When drivers are able to
> turn integers into requests like this, consuming the request in the call
> to `end` makes little sense (because we can just construct more).

How do you ensure that this is fine?:

     let r1 =3D tagset.get(0);
     let r2 =3D tagset.get(0);
     r1.end_ok();
     r2.do_something_that_would_only_be_done_while_active();

One thing that comes to my mind would be to only give out `&Request`
from the tag set. And to destroy, you could have a separate operation
that also removes the request from the tag set. (I am thinking of a tag
set as a `HashMap<u64, Request>`.

>=20
> What I do now is issue the an `Option<ARef<Request>>` with
> `bindings::req_ref_inc_not_zero(rq_ptr)`, to make sure that the request
> is currently owned by the driver.
>=20
> I guess we can check the absolute value of the refcount, and only issue
> a request handle if the count matches what we expect. Then we can be cert=
ain
> that the handle is unique, and we can require transfer of ownership of
> the handle to `Request::end` to make sure it can never be called more
> than once.
>=20
> Another option is to error out in `Request::end` if the
> refcount is not what we expect.

I am a bit confused, why does the refcount matter in this case? Can't
the user just have multiple `ARef`s?

I think it would be weird to use `ARef<Request>` if you expect the
refcount to be 1. Maybe the API should be different?
As I understand it, a request has the following life cycle (please
correct me if I am wrong):
1. A new request is created, it is given to the driver via `queue_rq`.
2. The driver can now decide what to do with it (theoretically it can
    store it somewhere and later do something with it), but it should at
    some point call `Request::start`.
3. Work happens and eventually the driver calls `Request::end`.

To me this does not seem like something where we need a refcount (we
still might need one for safety, but it does not need to be exposed to
the user).

--=20
Cheers,
Benno


