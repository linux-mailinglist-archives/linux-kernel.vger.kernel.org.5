Return-Path: <linux-kernel+bounces-38254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D3883BD34
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA621C21E65
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392361BDC8;
	Thu, 25 Jan 2024 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="aamXmgNw"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16301B967
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706174826; cv=none; b=rHkHblp3rrAEbAYkARrR/W+/fzSkUCsX28lWdxPi4ywBeKUejPnvjr+2s65Oc1o2IMCws5BWBtV6FQSsIeEBig6bL9RVhl3myl/tjcYg9WMNB/UHdVr1YOeMVo3kLja6EDVEUCfaNrBwlXYW7j63fuN2ZunZo/PvpTA7UsnKNmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706174826; c=relaxed/simple;
	bh=488//va03Lc+B/1ZyVuMhHZy+u75yY7UHFrjzmg8sAw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BppcVuSMVdeDz8/73ykJBgz5xChdebDov/aK41MGf0gQssMAA98DnNw6VvnGVx3TAtcYws7n1gFqg6Pjo3tgTQvhpFzjk0e2hblJTbcyAU8qIsU84P7de5A+BRxJvZSrHc846iqATj6SXp/c8iDmna5/gAbBGcdT7Mk30UuCBSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=aamXmgNw; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1706174821; x=1706434021;
	bh=VXueD5sixGPDTa6BhUDnnsLagnOCQf9tNkKiKlaVKTY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aamXmgNwwKSW97xc2/lztAj/XZ+IpEf9YCkJzEPQSBQ/t+QV3TP1t/iDzLXjOM1jb
	 nAD+PCQjoglFNEwp6zs+OXw5VvPw7KFfSrZuIbgr1prXnZ4kAs31BR+N5Z2GhLW+Bz
	 XMLK2ifAfUy+ciRK7qzOHpl+x/tLH/8+1VaHh4gtzJt0b9+cNvqs2DLmSdUk4VRCHe
	 35K9zn/vLG5P6Pl0D6tdwY+eQiz8sP+Ho8ZEZjCeMtD/h8jgczNV7/pKV9Y3DSwkGv
	 ce8Z/telLXlvihEO18bufrzoFnncbx1CHRGrPYgv1aEQxzZKyrVN02ecQ2fAYwVfIL
	 VLAEudG8EbFzw==
Date: Thu, 25 Jan 2024 09:26:52 +0000
To: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, linux-kernel@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC PATCH 03/11] rust: block: introduce `kernel::block::mq` module
Message-ID: <59f007a0-bb30-4291-ab49-0e69112e2566@proton.me>
In-Reply-To: <874jf3kflx.fsf@metaspace.dk>
References: <20230503090708.2524310-1-nmi@metaspace.dk> <20230503090708.2524310-4-nmi@metaspace.dk> <iL2M45BoRlK6yS9y8uo0A5yUXcZWMkdk3vtH3LRFSWXfvPVagVZ-0YC7taIKOBFUcjJYA_2xNNFPoC4WL-_ulCHOLkbqvsZlIshE_LEeYtU=@proton.me> <87il3kjgk0.fsf@metaspace.dk> <104a22f7-a5bb-4fb6-9ce9-aa2d4e63417f@proton.me> <874jf3kflx.fsf@metaspace.dk>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.01.24 19:39, Andreas Hindborg (Samsung) wrote:
>>>>> +/// A generic block device
>>>>> +///
>>>>> +/// # Invariants
>>>>> +///
>>>>> +///  - `gendisk` must always point to an initialized and valid `stru=
ct gendisk`.
>>>>> +pub struct GenDisk<T: Operations> {
>>>>> +    _tagset: Arc<TagSet<T>>,
>>>>> +    gendisk: *mut bindings::gendisk,
>>>>
>>>> Why are these two fields not embedded? Shouldn't the user decide where
>>>> to allocate?
>>>
>>> The `TagSet` can be shared between multiple `GenDisk`. Using an `Arc`
>>> seems resonable?
>>>
>>> For the `gendisk` field, the allocation is done by C and the address
>>> must be stable. We are owning the pointee and must drop it when it goes=
 out
>>> of scope. I could do this:
>>>
>>> #[repr(transparent)]
>>> struct GenDisk(Opaque<bindings::gendisk>);
>>>
>>> struct UniqueGenDiskRef {
>>>       _tagset: Arc<TagSet<T>>,
>>>       gendisk: Pin<&'static mut GenDisk>,
>>>
>>> }
>>>
>>> but it seems pointless. `struct GenDisk` would not be pub in that case.=
 What do you think?
>>
>> Hmm, I am a bit confused as to how you usually use a `struct gendisk`.
>> You said that a `TagSet` might be shared between multiple `GenDisk`s,
>> but that is not facilitated by the C side?
>>
>> Is it the case that on the C side you create a struct containing a
>> tagset and a gendisk for every block device you want to represent?
>=20
> Yes, but the `struct tag_set` can be shared between multiple `struct
> gendisk`.
>=20
> Let me try to elaborate:
>=20
> In C you would first allocate a `struct tag_set` and partially
> initialize it. The allocation can be dynamic, static or part of existing
> allocation. You would then partially initialize the structure and finish
> the initialization by calling `blk_mq_alloc_tag_set()`. This populates
> the rest of the structure which includes more dynamic allocations.
>=20
> You then allocate a `struct gendisk` by calling `blk_mq_alloc_disk()`,
> passing in a pointer to the `struct tag_set` you just created. This
> function will return a pointer to a `struct gendisk` on success.
>=20
> In the Rust abstractions, we allocate the `TagSet`:
>=20
> #[pin_data(PinnedDrop)]
> #[repr(transparent)]
> pub struct TagSet<T: Operations> {
>      #[pin]
>      inner: Opaque<bindings::blk_mq_tag_set>,
>      _p: PhantomData<T>,
> }
>=20
> with `PinInit` [^1]. The initializer will partially initialize the struct=
 and
> finish the initialization like C does by calling
> `blk_mq_alloc_tag_set()`. We now need a place to point the initializer.
> `Arc::pin_init()` is that place for now. It allows us to pass the
> `TagSet` reference to multiple `GenDisk` if required. Maybe we could be
> generic over `Deref<TagSet>` in the future. Bottom line is that we need
> to hold on to that `TagSet` reference until the `GenDisk` is dropped.

I see, thanks for the elaborate explanation! I now think that using `Arc`
makes sense.

> `struct tag_set` is not reference counted on the C side. C
> implementations just take care to keep it alive, for instance by storing
> it next to a pointer to `struct gendisk` that it is servicing.

This is interesting, is this also done in the case where it is shared
among multiple `struct gendisk`s?
Does this have some deeper reason? Or am I right to assume that creating
`Gendisk`/`TagSet` is done rarely (i.e. only at initialization of the
driver)?

>> And you decided for the Rust abstractions that you want to have only a
>> single generic struct for any block device, distinguished by the generic
>> parameter?
>=20
> Yes, we have a single generic struct (`GenDisk`) representing the C
> `struct gendisk`, and a single generic struct (`TagSet`) representing
> the C `struct tag_set`. These are both generic over `T: Operations`.
> `Operations` represent a C vtable (`struct blk_mq_ops`) attached to the
> `struct tag_set`. This vtable is provided by the driver and holds
> function pointers that allow the kernel to perform actions such as queue
> IO requests with the driver. A C driver can instantiate multiple `struct
> gendisk` and service them with the same `struct tag_set` and thereby the
> same vtable. Or it can use separate tag sets and the same vtable. Or a
> separate tag_set and vtable for each gendisk.
>=20
>> I think these kinds of details would be nice to know. Not only for
>> reviewers, but also for veterans of the C APIs.
>=20
> I should write some module level documentation clarifying the use of
> these types. The null block driver is a simple example, but it is just
> code. I will include more docs in the next version.

Thanks a lot for explaining!

--=20
Cheers,
Benno



