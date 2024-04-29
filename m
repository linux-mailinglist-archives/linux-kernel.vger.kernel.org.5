Return-Path: <linux-kernel+bounces-162957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EDE8B62BB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D0A1C21882
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA80713C670;
	Mon, 29 Apr 2024 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8EOKwFJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6F51292CA;
	Mon, 29 Apr 2024 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419642; cv=none; b=Xo84fkZgiW6yzmQMTD35OFQzmOJwFEWO43iX9ntx4E9vwJltYiMYT5KTei5CqLNgIfx61l/Lda9pnnz4YZmtDr3YZu9qcB83WIS7xXWiIDTnOkJNo2TkSEEVXhbIjNBVR4jpm1qzrYCUeO95I6GVdLLQy1dEqIdsjE1mcwBYwkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419642; c=relaxed/simple;
	bh=ULuvvHNYTvbRfphoJuwlrdezz0qvdg3BcFmkYoUv1dU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORoDt9rMrM0gdxm8Wvezje+J2oCdgaN7hHn27SjUuklveb3HuIr5yBBIUtywanc6qKGgeTVpi2bkePk75MZX/ztEzxBi0qNDObAqvJZ7rDW2zwLFhSszPuhojVnEYzaVh9HLHx0YVE3hkU8Ht9dkOu/3zSsFfgK3leoDfudG5Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8EOKwFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B71C113CD;
	Mon, 29 Apr 2024 19:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714419641;
	bh=ULuvvHNYTvbRfphoJuwlrdezz0qvdg3BcFmkYoUv1dU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I8EOKwFJMeZfDlNOw897+opXzCVtAiP8j2JL/cuCRnAHVlYRvMn5iQAxdgoLzYjEr
	 ULE+4fYpBn/OogPErRCEFEGs8ET23cFo7k7kO9/VM8qFC2ED0pKcG+XoS+ONFoFuqB
	 eV4TIiE6lgoXEzAWRHrhwxAkgaEBkjz+1XGXMySSmkDHzC9/+JGsZlGLWARXc1Mif2
	 L1rRl+9f8Gyqn23hap1M8UgEV5RmYG58bLEH6lZ2mmI6Mh4DMJy5dQaryQv2H+6BR5
	 jtWytxo6qK+kcGwQHexYfl07+G7ucpserSaDklVGx04xMPab7H4jRfDKCVh7tFXC8A
	 d75hvBROnnPkg==
Date: Mon, 29 Apr 2024 20:40:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Gradinariu, Ramona" <Ramona.Gradinariu@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Ramona Gradinariu
 <ramona.bolboaca13@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "robh@kernel.org" <robh@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>
Subject: Re: [PATCH 4/5] iio: adis16480: add support for adis16545/7
 families
Message-ID: <20240429204027.3e47074a@jic23-huawei>
In-Reply-To: <BL1PR03MB5992DEBF82C0DB7BDC5EA0FF971B2@BL1PR03MB5992.namprd03.prod.outlook.com>
References: <20240423084210.191987-1-ramona.gradinariu@analog.com>
	<20240423084210.191987-5-ramona.gradinariu@analog.com>
	<20240428162555.3ddf31ea@jic23-huawei>
	<e62f8df4b06abc371b1e9fe3232cb593e468d54c.camel@gmail.com>
	<BL1PR03MB5992DEBF82C0DB7BDC5EA0FF971B2@BL1PR03MB5992.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Apr 2024 13:17:42 +0000
"Gradinariu, Ramona" <Ramona.Gradinariu@analog.com> wrote:

> > -----Original Message-----
> > From: Nuno S=C3=A1 <noname.nuno@gmail.com>
> > Sent: Monday, April 29, 2024 10:59 AM
> > To: Jonathan Cameron <jic23@kernel.org>; Ramona Gradinariu
> > <ramona.bolboaca13@gmail.com>
> > Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; linux-
> > doc@vger.kernel.org; devicetree@vger.kernel.org; corbet@lwn.net;
> > conor+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; robh@kernel.org;
> > Gradinariu, Ramona <Ramona.Gradinariu@analog.com>; Sa, Nuno
> > <Nuno.Sa@analog.com>
> > Subject: Re: [PATCH 4/5] iio: adis16480: add support for adis16545/7 fa=
milies
> >=20
> > [External]
> >=20
> > On Sun, 2024-04-28 at 16:25 +0100, Jonathan Cameron wrote: =20
> > > On Tue, 23 Apr 2024 11:42:09 +0300
> > > Ramona Gradinariu <ramona.bolboaca13@gmail.com> wrote:
> > > =20
> > > > The ADIS16545 and ADIS16547 are a complete inertial system that
> > > > includes a triaxis gyroscope and a triaxis accelerometer.
> > > > The serial peripheral interface (SPI) and register structure provid=
e a
> > > > simple interface for data collection and configuration control.
> > > >
> > > > These devices are similar to the ones already supported in the driv=
er,
> > > > with changes in the scales, timings and the max spi speed in burst
> > > > mode.
> > > > Also, they support delta angle and delta velocity readings in burst
> > > > mode, for which support was added in the trigger handler.
> > > >
> > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com> =20
> > >
> > > What is Nuno's relationship to this patch?=C2=A0 You are author and t=
he sender
> > > which is fine, but in that case you need to make Nuno's involvement e=
xplicit.
> > > Perhaps a Co-developed-by or similar is appropriate?
> > > =20
> > > > Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com> =20
> > > A few comments inline.=C2=A0 Biggest one is I'd like a clear statemen=
t of why you
> > > can't do a burst of one type, then a burst of other.=C2=A0 My guess i=
s that the
> > > transition is very time consuming?=C2=A0 If so, that is fine, but you=
 should be
> > > able
> > > to let available_scan_masks handle the disjoint channel sets. =20
> >=20
> > Yeah, the burst message is a special spi transfer that brings you all o=
f the
> > channels data at once but for the accel/gyro you need to explicitly con=
figure
> > the chip to either give you the "normal vs "delta" readings. Re-configu=
ring the
> > chip and then do another burst would destroy performance I think. We co=
uld
> > do
> > the manual readings as we do in adis16475 for chips not supporting burs=
t32.
> > But
> > in the burst32 case those manual readings should be minimal while in he=
re we
> > could have to do 6 of them which could also be very time consuming...
> >=20
> > Now, why we don't use available_scan_masks is something I can't really
> > remember
> > but this implementation goes in line with what we have in the adis16475
> > driver.
> >=20
> > - Nuno S=C3=A1
> >  =20
>=20
> Thank you Nuno for all the additional explanations.
> Regarding the use of available_scan_masks, the idea is to have any possib=
le
> combination for accel, gyro, temp and timestamp channels or delta angle, =
delta=20
> velocity, temp and  timestamp channels. There are a lot of combinations f=
or=20
> this and it does not seem like a good idea to write them all manually. Th=
at is=20
> why adis16480_update_scan_mode is used for checking the correct channels=
=20
> selection.

If you are using bursts, the data is getting read anyway - which is the main
cost here. The real question becomes what are you actually saving by suppor=
ting all
the combinations of the the two subsets of channels in the pollfunc?
Currently you have to pick the channels out and repack them, if pushing the=
m all
looks to me like a mempcy and a single value being set (unconditionally).

Then it's a question of what the overhead of the channel demux in the core =
is.
What you pass out of the driver via iio_push_to_buffers*()
is not what ends up in the buffer if you allow the IIO core to do data demu=
xing
for you - that is enabled by providing available_scan_masks.  At buffer
start up the demux code computes a fairly optimal set of copies to repack
the incoming data to match with what channels the consumer (here probably
the kfifo on the way to userspace) is expecting.

That demux adds a small overhead but it should be small as long
as the channels wanted aren't pathological (i.e. every other one).

Advantage is the driver ends up simpler and in the common case of turn
on all the channels (why else did you buy a device with those measurements
if you didn't want them!) the demux is zerocopy so effectively free which
is not going to be the case for the bitmap walk and element copy in the
driver.

Jonathan

>=20
> Ramona G.


