Return-Path: <linux-kernel+bounces-166858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8CC8BA0E9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB4E1F21BF0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C44817A93F;
	Thu,  2 May 2024 19:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Onw5PGyv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBD315FD0B;
	Thu,  2 May 2024 19:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714677286; cv=none; b=Zp4bCxAv1be/W7kqC6aq1URE3V2AeDqVLjAioiMiDiCoog1k92uaotzxzp8ufkqso5B2ElPOahxc2CZWtpDDQfBnbLsijSjFEgm4ec5I7dHHPvCLaBuhqZ0UMrbeWZuat6FLFYu/I9bwyLvnz463Cp5v+wB1zbCk7d5wOIke/uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714677286; c=relaxed/simple;
	bh=BBlkb84hHXVG3Ve5x+ET9a7uN2YIwLDnxgmQ6QkN5ys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4plhTOKuBOmm4tC9fdnVtLC2M/wrKuyZi5EJA7L65P943PrULEkSLGAvGTBBMqCAG6JMgxnkI8HXxUMlArD9d8yRds/ffW/rr4zePTeRvQfnu88HLcJeYLPilDRogeWck7n8reDb9khUpccZxUiCziPwjAOg/svQh+O4JTZ6Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Onw5PGyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA05C113CC;
	Thu,  2 May 2024 19:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714677286;
	bh=BBlkb84hHXVG3Ve5x+ET9a7uN2YIwLDnxgmQ6QkN5ys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Onw5PGyvJgNNN6dD0D6icj1zLOV0ySF1y6PuCPIQIQBlgjwiHXzEcGkW2I8o1urj+
	 +naEqlyP7dxBIPVw+06Nsl1E5cg5L8K6z1RI3wy3kl5QLS1hWwn+ZyLXP9CAj+Fhz1
	 kI+lZI0RWz2W5wRGTpJoviUsiWnOd5U3w42jJo+HI1t2lNXyEZc67nkwlljPy4njwB
	 yVyh9m9YsT+W3PjLulRGh1mBZ4NoYv8fOjQ2ririNZ2PVzeXvjYor2RJp3kobNN2qE
	 o2Dtl3XuOCBLjzW49Uk4XNr2WQ37VKb1NwFgZN2MdesVsKdPpHp0JW9xA/JoMG2cfX
	 p8mUczVQfFw5Q==
Date: Thu, 2 May 2024 20:14:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: "Gradinariu, Ramona"  <Ramona.Gradinariu@analog.com>, Ramona Gradinariu
 <ramona.bolboaca13@gmail.com>, "linux-kernel@vger.kernel.org" 
 <linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org" 
 <linux-iio@vger.kernel.org>, "linux-doc@vger.kernel.org" 
 <linux-doc@vger.kernel.org>, "devicetree@vger.kernel.org" 
 <devicetree@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
 "conor+dt@kernel.org"  <conor+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org"  <krzysztof.kozlowski+dt@linaro.org>,
 "robh@kernel.org" <robh@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>
Subject: Re: [PATCH 4/5] iio: adis16480: add support for adis16545/7
 families
Message-ID: <20240502201408.216575e4@jic23-huawei>
In-Reply-To: <0e13f8b643bb7afcc7c4f0d62741cf9fda66c1e0.camel@gmail.com>
References: <20240423084210.191987-1-ramona.gradinariu@analog.com>
	<20240423084210.191987-5-ramona.gradinariu@analog.com>
	<20240428162555.3ddf31ea@jic23-huawei>
	<e62f8df4b06abc371b1e9fe3232cb593e468d54c.camel@gmail.com>
	<BL1PR03MB5992DEBF82C0DB7BDC5EA0FF971B2@BL1PR03MB5992.namprd03.prod.outlook.com>
	<20240429204027.3e47074a@jic23-huawei>
	<0e13f8b643bb7afcc7c4f0d62741cf9fda66c1e0.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 02 May 2024 13:31:55 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2024-04-29 at 20:40 +0100, Jonathan Cameron wrote:
> > On Mon, 29 Apr 2024 13:17:42 +0000
> > "Gradinariu, Ramona" <Ramona.Gradinariu@analog.com> wrote:
> >  =20
> > > > -----Original Message-----
> > > > From: Nuno S=C3=A1 <noname.nuno@gmail.com>
> > > > Sent: Monday, April 29, 2024 10:59 AM
> > > > To: Jonathan Cameron <jic23@kernel.org>; Ramona Gradinariu
> > > > <ramona.bolboaca13@gmail.com>
> > > > Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; linux-
> > > > doc@vger.kernel.org; devicetree@vger.kernel.org; corbet@lwn.net;
> > > > conor+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; robh@kernel=
org;
> > > > Gradinariu, Ramona <Ramona.Gradinariu@analog.com>; Sa, Nuno
> > > > <Nuno.Sa@analog.com>
> > > > Subject: Re: [PATCH 4/5] iio: adis16480: add support for adis16545/=
7 families
> > > >=20
> > > > [External]
> > > >=20
> > > > On Sun, 2024-04-28 at 16:25 +0100, Jonathan Cameron wrote:=C2=A0  =
=20
> > > > > On Tue, 23 Apr 2024 11:42:09 +0300
> > > > > Ramona Gradinariu <ramona.bolboaca13@gmail.com> wrote:
> > > > > =C2=A0 =20
> > > > > > The ADIS16545 and ADIS16547 are a complete inertial system that
> > > > > > includes a triaxis gyroscope and a triaxis accelerometer.
> > > > > > The serial peripheral interface (SPI) and register structure pr=
ovide a
> > > > > > simple interface for data collection and configuration control.
> > > > > >=20
> > > > > > These devices are similar to the ones already supported in the =
driver,
> > > > > > with changes in the scales, timings and the max spi speed in bu=
rst
> > > > > > mode.
> > > > > > Also, they support delta angle and delta velocity readings in b=
urst
> > > > > > mode, for which support was added in the trigger handler.
> > > > > >=20
> > > > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>=C2=A0  =20
> > > > >=20
> > > > > What is Nuno's relationship to this patch?=C2=A0 You are author a=
nd the sender
> > > > > which is fine, but in that case you need to make Nuno's involveme=
nt explicit.
> > > > > Perhaps a Co-developed-by or similar is appropriate?
> > > > > =C2=A0 =20
> > > > > > Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>=
=C2=A0  =20
> > > > > A few comments inline.=C2=A0 Biggest one is I'd like a clear stat=
ement of why you
> > > > > can't do a burst of one type, then a burst of other.=C2=A0 My gue=
ss is that the
> > > > > transition is very time consuming?=C2=A0 If so, that is fine, but=
 you should be
> > > > > able
> > > > > to let available_scan_masks handle the disjoint channel sets.=C2=
=A0  =20
> > > >=20
> > > > Yeah, the burst message is a special spi transfer that brings you a=
ll of the
> > > > channels data at once but for the accel/gyro you need to explicitly=
 configure
> > > > the chip to either give you the "normal vs "delta" readings. Re-con=
figuring the
> > > > chip and then do another burst would destroy performance I think. W=
e could
> > > > do
> > > > the manual readings as we do in adis16475 for chips not supporting =
burst32.
> > > > But
> > > > in the burst32 case those manual readings should be minimal while i=
n here we
> > > > could have to do 6 of them which could also be very time consuming.=
.
> > > >=20
> > > > Now, why we don't use available_scan_masks is something I can't rea=
lly
> > > > remember
> > > > but this implementation goes in line with what we have in the adis1=
6475
> > > > driver.
> > > >=20
> > > > - Nuno S=C3=A1
> > > > =C2=A0  =20
> > >=20
> > > Thank you Nuno for all the additional explanations.
> > > Regarding the use of available_scan_masks, the idea is to have any po=
ssible
> > > combination for accel, gyro, temp and timestamp channels or delta ang=
le, delta=20
> > > velocity, temp and=C2=A0 timestamp channels. There are a lot of combi=
nations for=20
> > > this and it does not seem like a good idea to write them all manually=
 That is=20
> > > why adis16480_update_scan_mode is used for checking the correct chann=
els=20
> > > selection. =20
> >=20
> > If you are using bursts, the data is getting read anyway - which is the=
 main
> > cost here. The real question becomes what are you actually saving by su=
pporting all
> > the combinations of the the two subsets of channels in the pollfunc?
> > Currently you have to pick the channels out and repack them, if pushing=
 them all
> > looks to me like a mempcy and a single value being set (unconditionally=
). =20
>=20
> > Then it's a question of what the overhead of the channel demux in the c=
ore is.
> > What you pass out of the driver via iio_push_to_buffers*()
> > is not what ends up in the buffer if you allow the IIO core to do data =
demuxing
> > for you - that is enabled by providing available_scan_masks.=C2=A0 At b=
uffer
> > start up the demux code computes a fairly optimal set of copies to repa=
ck
> > the incoming data to match with what channels the consumer (here probab=
ly
> > the kfifo on the way to userspace) is expecting.
> >=20
> > That demux adds a small overhead but it should be small as long
> > as the channels wanted aren't pathological (i.e. every other one).
> >=20
> > Advantage is the driver ends up simpler and in the common case of turn
> > on all the channels (why else did you buy a device with those measureme=
nts
> > if you didn't want them!) the demux is zerocopy so effectively free whi=
ch
> > is not going to be the case for the bitmap walk and element copy in the
> > driver.
> >  =20
>=20
> Maybe my younger me was smarter but reading again the validation of the s=
can mask
> code (when available_scan_masks is available), I'm not sure why we're not=
 using them.
> I think that having one mask with delta values + temperature and another =
one with
> normal + temperature would be enough for what we want in here. The code in
> adis16480_update_scan_mode() could then be simpler I think.
>=20
> Now, what I'm still not following is the straight memcpy(). I may be miss=
ing
> something but the demux code only appears to kick in when we have compoun=
d masks
> resulting of multiple buffers being enabled. So I'm not seeing how we can=
 get away
> without picking the channels and place them correctly in the buffer passe=
d to IIO?

It runs whenever the enabled mask requested (the channels that are enabled)=
 is
different from the active_scan_mask. It only sends channels in one
direction if there is only one user but it only sends the ones enabled by t=
hat consumer.
It's called unconditionally from iio_enable_buffers()

That iterates over all enabled buffers (often there is only 1)

and then checks if the active scan mask is the same as the one for this buf=
fer.
https://elixir.bootlin.com/linux/v6.9-rc6/source/drivers/iio/industrialio-b=
uffer.c#L1006

The setup for whether to find a superset from available_scan_masks is here
https://elixir.bootlin.com/linux/v6.9-rc6/source/drivers/iio/industrialio-b=
uffer.c#L928

Key is that if it happens to match, then we don't actually do anything in t=
he demux.
It just gets passed straight on through.  That does the fast path you menti=
on below.

> What we could do in the future (for a similar device) is to maybe have a =
fastpath in
> the handler. Something like:
>=20
> if (bitmap_full(scan_mask, masklength)) {
> 	memcpy(iio_buff, burst + data_off, size);
> 	goto push_to_iio;
> }
>=20
> Right now we would always have to do some "manual" work as the temperatur=
e scan index
> does not match the position on the received burst data.

Agreed -that one is needed to shuffle the temperature to the right place.


>=20
> Some devices with the burst32 (which I think do not exist in this driver)=
 would also
> make the plain memcpy() harder.
>=20
> - Nuno S=C3=A1
>=20


