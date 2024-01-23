Return-Path: <linux-kernel+bounces-35637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459BB839472
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02EFD1C22928
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE85E63518;
	Tue, 23 Jan 2024 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Ux+KWEpn"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02886166E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026520; cv=none; b=DA2lz6k+O58Zovei551o3ep3GDuvqRflwtd+bJ3iGqHkwwFEsLvzWek8GF5kTyqfKc/ouhKo25l+S828vgr6aib5loRIte5D+6Nw8s4OdRluMQtFfA/czetoN7thTbfjhDANDD8mp2l/HmuTYmhUUaaA7t5C8ZWL0jWHkHhg7fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026520; c=relaxed/simple;
	bh=1ENQhjPmqQqDuRq4QiAjxPKkdrMTPT16721GC13SkRI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElGBgksE5yQCCyjq1FlqQCWN7A++nMMv0EWZtpJG+LyEBnkhp6uJnVkQrsN8lRRBzdRYC6fVxdQ+xTyEvRlcfPLTFffGuOqbgQ0uPws+DqkXycVLjpfvIzQglmjFFwY8vCp5wnhlm30HxOclxuTwBmSj8r4bfgMizofQyWOGfZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Ux+KWEpn; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=oivkfmluazbg5k63zstr4jyxyy.protonmail; t=1706026515; x=1706285715;
	bh=lFmPnlDhdUF+oK3pA8hGDyEbiO46BnuhG9DGtH2Rdyo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ux+KWEpnI8Dx8i/G7/kvFMHgnv6uPzBujikGY55tXrWjrmqnG6M8wQLWlqXRBD7Wc
	 MUlhB1dkjr+emcMlqpSxlP6bhr2k+MofZPCxaWVUko11mro4oIPwFvZ6TMC0i2fpwL
	 Szed1TwzSkrDTOphiTbtzCVhWfo1nckoIOJVL8mI328f/zzhrCQNz02qJjsgLjGco6
	 iv7rQ4TuZp9/IOO7T3XLtKJGvV0JFYLvxMIXUhkRXYewQmvsy8dowGofwTLE0D1AtL
	 dbOr19rRoulYuXfelPXhwLC5D2yhHubsJ0+jjREsKv3UIWLut/OCVKYHFqWiV8+KFY
	 1OXvUbRfK1lVw==
Date: Tue, 23 Jan 2024 16:14:58 +0000
To: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, linux-kernel@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC PATCH 03/11] rust: block: introduce `kernel::block::mq` module
Message-ID: <104a22f7-a5bb-4fb6-9ce9-aa2d4e63417f@proton.me>
In-Reply-To: <87il3kjgk0.fsf@metaspace.dk>
References: <20230503090708.2524310-1-nmi@metaspace.dk> <20230503090708.2524310-4-nmi@metaspace.dk> <iL2M45BoRlK6yS9y8uo0A5yUXcZWMkdk3vtH3LRFSWXfvPVagVZ-0YC7taIKOBFUcjJYA_2xNNFPoC4WL-_ulCHOLkbqvsZlIshE_LEeYtU=@proton.me> <87il3kjgk0.fsf@metaspace.dk>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

just so you know, I received this email today, so it was very late,
since the send date is January 12.

On 12.01.24 10:18, Andreas Hindborg (Samsung) wrote:
>=20
> Hi Benno,
>=20
> Benno Lossin <benno.lossin@proton.me> writes:
>=20
> <...>
>=20
>>> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/ge=
n_disk.rs
>>> new file mode 100644
>>> index 000000000000..50496af15bbf
>>> --- /dev/null
>>> +++ b/rust/kernel/block/mq/gen_disk.rs
>>> @@ -0,0 +1,133 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +//! GenDisk abstraction
>>> +//!
>>> +//! C header: [`include/linux/blkdev.h`](../../include/linux/blkdev.h)
>>> +//! C header: [`include/linux/blk_mq.h`](../../include/linux/blk_mq.h)
>>> +
>>> +use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
>>> +use crate::{
>>> +    bindings, error::from_err_ptr, error::Result, sync::Arc, types::Fo=
reignOwnable,
>>> +    types::ScopeGuard,
>>> +};
>>> +use core::fmt::{self, Write};
>>> +
>>> +/// A generic block device
>>> +///
>>> +/// # Invariants
>>> +///
>>> +///  - `gendisk` must always point to an initialized and valid `struct=
 gendisk`.
>>> +pub struct GenDisk<T: Operations> {
>>> +    _tagset: Arc<TagSet<T>>,
>>> +    gendisk: *mut bindings::gendisk,
>>
>> Why are these two fields not embedded? Shouldn't the user decide where
>> to allocate?
>=20
> The `TagSet` can be shared between multiple `GenDisk`. Using an `Arc`
> seems resonable?
>=20
> For the `gendisk` field, the allocation is done by C and the address
> must be stable. We are owning the pointee and must drop it when it goes o=
ut
> of scope. I could do this:
>=20
> #[repr(transparent)]
> struct GenDisk(Opaque<bindings::gendisk>);
>=20
> struct UniqueGenDiskRef {
>      _tagset: Arc<TagSet<T>>,
>      gendisk: Pin<&'static mut GenDisk>,
>=20
> }
>=20
> but it seems pointless. `struct GenDisk` would not be pub in that case. W=
hat do you think?

Hmm, I am a bit confused as to how you usually use a `struct gendisk`.
You said that a `TagSet` might be shared between multiple `GenDisk`s,
but that is not facilitated by the C side?

Is it the case that on the C side you create a struct containing a
tagset and a gendisk for every block device you want to represent?
And you decided for the Rust abstractions that you want to have only a
single generic struct for any block device, distinguished by the generic
parameter?
I think these kinds of details would be nice to know. Not only for
reviewers, but also for veterans of the C APIs.

--=20
Cheers,
Benno


