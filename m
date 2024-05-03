Return-Path: <linux-kernel+bounces-167402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42F58BA910
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FDC5B22F62
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791E514F122;
	Fri,  3 May 2024 08:42:16 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0281D79CD;
	Fri,  3 May 2024 08:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714725735; cv=none; b=jmTFQ/JsdPYChFdYjzXzcvccAR9OOaQGUXdej/ZFZg65VodsOs1+hAgO8ckuN7riXy0UO2XTBpLlASt9ugOhdYSo6def79f3fQ6XB4SrCxThqZCaNpL2KezVGPjCETRDE99tR4Rh5lYkaQGi2uDrS9bPA1QxTDr0shZI2Rgwrbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714725735; c=relaxed/simple;
	bh=GAQA8Cu8wAmIH1FlpBdN4xQZnDpLEk4jb5x6+/XVmE8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kL48SU07buPiYhLIgx9n08+quxyEZKcpJPCNuspIFuKUgvNyNp/Tu8Mtb1bGD4vren4khSu/Vy+n3Ve2qAVT71ZkoVC3/7mLAz2CrY3gEoYMl/8ZSzCfMtbrRGiklT/hsyjNyjqzFZP919ab+rP34jhn/IhEa9Re0m9DMlxW8hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VW43d2t8Tz6GD6Y;
	Fri,  3 May 2024 16:39:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 803C0140B33;
	Fri,  3 May 2024 16:42:10 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 3 May
 2024 09:42:10 +0100
Date: Fri, 3 May 2024 09:42:09 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <noname.nuno@gmail.com>
CC: <jic23@kernel.org>, <Ramona.Gradinariu@analog.com>,
	<ramona.bolboaca13@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <corbet@lwn.net>, <conor+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <robh@kernel.org>, <Nuno.Sa@analog.com>
Subject: Re: [PATCH 4/5] iio: adis16480: add support for adis16545/7
 families
Message-ID: <20240503094113.00001879@Huawei.com>
In-Reply-To: <0df8386e74cbdfaaaf35a4bc59326151b863ae4c.camel@gmail.com>
References: <20240423084210.191987-1-ramona.gradinariu@analog.com>
 <20240423084210.191987-5-ramona.gradinariu@analog.com>
 <20240428162555.3ddf31ea@jic23-huawei>
 <e62f8df4b06abc371b1e9fe3232cb593e468d54c.camel@gmail.com>
 <BL1PR03MB5992DEBF82C0DB7BDC5EA0FF971B2@BL1PR03MB5992.namprd03.prod.outlook.com>
 <20240429204027.3e47074a@jic23-huawei>
 <0e13f8b643bb7afcc7c4f0d62741cf9fda66c1e0.camel@gmail.com>
 <20240502201408.216575e4@jic23-huawei>
 <0df8386e74cbdfaaaf35a4bc59326151b863ae4c.camel@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 03 May 2024 08:09:29 +0200
Nuno S=E1 <noname.nuno@gmail.com> wrote:

Resend as the to / cc entries were garbled. No idea why!

> On Thu, 2024-05-02 at 20:14 +0100, Jonathan Cameron wrote:
> > On Thu, 02 May 2024 13:31:55 +0200
> > Nuno S=E1 <noname.nuno@gmail.com> wrote:
> >  =20
> > > On Mon, 2024-04-29 at 20:40 +0100, Jonathan Cameron wrote: =20
> > > > On Mon, 29 Apr 2024 13:17:42 +0000
> > > > "Gradinariu, Ramona" <Ramona.Gradinariu@analog.com> wrote:
> > > > =A0  =20
> > > > > > -----Original Message-----
> > > > > > From: Nuno S=E1 <noname.nuno@gmail.com>
> > > > > > Sent: Monday, April 29, 2024 10:59 AM
> > > > > > To: Jonathan Cameron <jic23@kernel.org>; Ramona Gradinariu
> > > > > > <ramona.bolboaca13@gmail.com>
> > > > > > Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; li=
nux-
> > > > > > doc@vger.kernel.org; devicetree@vger.kernel.org; corbet@lwn.net;
> > > > > > conor+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > > > > > robh@kernel.org;
> > > > > > Gradinariu, Ramona <Ramona.Gradinariu@analog.com>; Sa, Nuno
> > > > > > <Nuno.Sa@analog.com>
> > > > > > Subject: Re: [PATCH 4/5] iio: adis16480: add support for adis16=
545/7
> > > > > > families
> > > > > >=20
> > > > > > [External]
> > > > > >=20
> > > > > > On Sun, 2024-04-28 at 16:25 +0100, Jonathan Cameron wrote:=A0=
=A0=A0  =20
> > > > > > > On Tue, 23 Apr 2024 11:42:09 +0300
> > > > > > > Ramona Gradinariu <ramona.bolboaca13@gmail.com> wrote:
> > > > > > > =A0=A0  =20
> > > > > > > > The ADIS16545 and ADIS16547 are a complete inertial system =
that
> > > > > > > > includes a triaxis gyroscope and a triaxis accelerometer.
> > > > > > > > The serial peripheral interface (SPI) and register structure
> > > > > > > > provide a
> > > > > > > > simple interface for data collection and configuration cont=
rol.
> > > > > > > >=20
> > > > > > > > These devices are similar to the ones already supported in =
the
> > > > > > > > driver,
> > > > > > > > with changes in the scales, timings and the max spi speed i=
n burst
> > > > > > > > mode.
> > > > > > > > Also, they support delta angle and delta velocity readings =
in
> > > > > > > > burst
> > > > > > > > mode, for which support was added in the trigger handler.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Nuno S=E1 <nuno.sa@analog.com>=A0=A0=A0  =20
> > > > > > >=20
> > > > > > > What is Nuno's relationship to this patch?=A0 You are author =
and the
> > > > > > > sender
> > > > > > > which is fine, but in that case you need to make Nuno's invol=
vement
> > > > > > > explicit.
> > > > > > > Perhaps a Co-developed-by or similar is appropriate?
> > > > > > > =A0=A0  =20
> > > > > > > > Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.=
com>=A0=A0=A0 =20
> > > > > > > A few comments inline.=A0 Biggest one is I'd like a clear sta=
tement of
> > > > > > > why you
> > > > > > > can't do a burst of one type, then a burst of other.=A0 My gu=
ess is
> > > > > > > that the
> > > > > > > transition is very time consuming?=A0 If so, that is fine, bu=
t you
> > > > > > > should be
> > > > > > > able
> > > > > > > to let available_scan_masks handle the disjoint channel sets.=
=A0=A0=A0  =20
> > > > > >=20
> > > > > > Yeah, the burst message is a special spi transfer that brings y=
ou all
> > > > > > of the
> > > > > > channels data at once but for the accel/gyro you need to explic=
itly
> > > > > > configure
> > > > > > the chip to either give you the "normal vs "delta" readings. Re-
> > > > > > configuring the
> > > > > > chip and then do another burst would destroy performance I thin=
k. We
> > > > > > could
> > > > > > do
> > > > > > the manual readings as we do in adis16475 for chips not support=
ing
> > > > > > burst32.
> > > > > > But
> > > > > > in the burst32 case those manual readings should be minimal whi=
le in
> > > > > > here we
> > > > > > could have to do 6 of them which could also be very time consum=
ing...
> > > > > >=20
> > > > > > Now, why we don't use available_scan_masks is something I can't=
 really
> > > > > > remember
> > > > > > but this implementation goes in line with what we have in the
> > > > > > adis16475
> > > > > > driver.
> > > > > >=20
> > > > > > - Nuno S=E1
> > > > > > =A0=A0=A0  =20
> > > > >=20
> > > > > Thank you Nuno for all the additional explanations.
> > > > > Regarding the use of available_scan_masks, the idea is to have any
> > > > > possible
> > > > > combination for accel, gyro, temp and timestamp channels or delta=
 angle,
> > > > > delta=20
> > > > > velocity, temp and=A0 timestamp channels. There are a lot of comb=
inations
> > > > > for=20
> > > > > this and it does not seem like a good idea to write them all manu=
ally.
> > > > > That is=20
> > > > > why adis16480_update_scan_mode is used for checking the correct c=
hannels
> > > > > selection.=A0  =20
> > > >=20
> > > > If you are using bursts, the data is getting read anyway - which is=
 the
> > > > main
> > > > cost here. The real question becomes what are you actually saving by
> > > > supporting all
> > > > the combinations of the the two subsets of channels in the pollfunc?
> > > > Currently you have to pick the channels out and repack them, if pus=
hing
> > > > them all
> > > > looks to me like a mempcy and a single value being set (uncondition=
ally).=A0 =20
> > >  =20
> > > > Then it's a question of what the overhead of the channel demux in t=
he core
> > > > is.
> > > > What you pass out of the driver via iio_push_to_buffers*()
> > > > is not what ends up in the buffer if you allow the IIO core to do d=
ata
> > > > demuxing
> > > > for you - that is enabled by providing available_scan_masks.=A0 At =
buffer
> > > > start up the demux code computes a fairly optimal set of copies to =
repack
> > > > the incoming data to match with what channels the consumer (here pr=
obably
> > > > the kfifo on the way to userspace) is expecting.
> > > >=20
> > > > That demux adds a small overhead but it should be small as long
> > > > as the channels wanted aren't pathological (i.e. every other one).
> > > >=20
> > > > Advantage is the driver ends up simpler and in the common case of t=
urn
> > > > on all the channels (why else did you buy a device with those measu=
rements
> > > > if you didn't want them!) the demux is zerocopy so effectively free=
 which
> > > > is not going to be the case for the bitmap walk and element copy in=
 the
> > > > driver.
> > > > =A0  =20
> > >=20
> > > Maybe my younger me was smarter but reading again the validation of t=
he scan
> > > mask
> > > code (when available_scan_masks is available), I'm not sure why we're=
 not
> > > using them.
> > > I think that having one mask with delta values + temperature and anot=
her one
> > > with
> > > normal + temperature would be enough for what we want in here. The co=
de in
> > > adis16480_update_scan_mode() could then be simpler I think.
> > >=20
> > > Now, what I'm still not following is the straight memcpy(). I may be =
missing
> > > something but the demux code only appears to kick in when we have com=
pound
> > > masks
> > > resulting of multiple buffers being enabled. So I'm not seeing how we=
 can
> > > get away
> > > without picking the channels and place them correctly in the buffer p=
assed
> > > to IIO? =20
> >=20
> > It runs whenever the enabled mask requested (the channels that are enab=
led) is
> > different from the active_scan_mask. It only sends channels in one
> > direction if there is only one user but it only sends the ones enabled =
by that
> > consumer.
> > It's called unconditionally from iio_enable_buffers()
> >=20
> > That iterates over all enabled buffers (often there is only 1)
> >=20
> > and then checks if the active scan mask is the same as the one for this
> > buffer.
> > https://elixir.bootlin.com/linux/v6.9-rc6/source/drivers/iio/industrial=
io-buffer.c#L1006
> >=20
> > The setup for whether to find a superset from available_scan_masks is h=
ere
> > https://elixir.bootlin.com/linux/v6.9-rc6/source/drivers/iio/industrial=
io-buffer.c#L928
> >=20
> > Key is that if it happens to match, then we don't actually do anything =
in the
> > demux.
> > It just gets passed straight on through.=A0 That does the fast path you=
 mention
> > below. =20
>=20
> Ahh got it... May failure was not realizing that iio_scan_mask_match() re=
turns
> the available masks so I was assuming that the bitmap_equal() check would=
 only
> differ when multiple buffers are enabled.
>=20
> Oh well, I think then this should work... I'm not sure it will be more
> performant for the case where we don't enable all the channels because th=
e demux
> is a linked list which is far from being a performance friend (maybe we c=
an do
> some trials with something like xarray...). Still, for this to work the b=
uffer
> we pass into IIO has to be bigger than it needs to be (so bigger memset())
> because, AFAIU, we will have to pass on all the scan elements and, as I s=
aid,
> the burst data will either have delta or normal measurements (not both). =
I guess
> the code will still look simpler so if there's no visible difference in
> performance I'm fine with the change. I guess Ramona can give it a try to=
 see
> how it looks like.

Would be interesting to look at the performance of that code, but the
real question is what channels do users typically enabled. If they enabled
a full set (and I suspect most do) then that code doesn't nothing at all.

Original thinking was that the non common case didn't really matter much.
If it is worth optimizing I'd suggest a double pass (or cheat - see later)
1st pass works out number of elements, 2nd just saves them in a nice
linear array.  It's typically small however, so maybe just allocate a linear
array big enough for the worst case.

Jonathan

>=20
> - Nuno S=E1
> >  =20
>=20
>=20


