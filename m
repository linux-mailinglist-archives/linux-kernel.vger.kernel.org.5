Return-Path: <linux-kernel+bounces-117957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF8B88B1C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4661FA099E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3190A5A103;
	Mon, 25 Mar 2024 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vc4FsdRa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5871D12E55;
	Mon, 25 Mar 2024 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399335; cv=none; b=ddqgT/b4xzdhPimW5wrRLeUs897x1H6PIDPxIOgoyKrYZZKfq7WWgIsEU0qy5evObbbHatlS0B24pJNdB6P0hZ51hXxPfARBlDZ0e/o23bbjf6Hd39FUILRNOieAzP7a0RfXeq/4Rkqf67re9Il1nCx7gvoWQegOj+DFqBnz0tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399335; c=relaxed/simple;
	bh=AjuVlS8tHlrZ6H8T3W+PPsoKeY8DgVuue/TCrjp0oDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8dGDZkp/8OGyOdRmQI7PxGCXsIyQIkkHBEsxcV2dWBUq4OOiSTRyXubQUKJky0qwkxTnYHB5LSxoctIIwNT1eL4jsBwuseMzzSSeYwCs1vOKogi5+Qcdud1avtiUEFrikuYyJa1mPrVVB5VAJxZb7S6ZVO02fYVEy0kvJC3Tdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vc4FsdRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312B9C433F1;
	Mon, 25 Mar 2024 20:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711399334;
	bh=AjuVlS8tHlrZ6H8T3W+PPsoKeY8DgVuue/TCrjp0oDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vc4FsdRa6VxpKY8TH1xTCXyQ0Z6a5su1BES/BH9VU4okz6PHMM1CS4cdgTo8Gp0P0
	 D9igYEcpttdH0Wl08EFCCifIagBnizhJklyh/WII1Y/HL65zJWEqmF+X0QMAUWf5Uv
	 Mqh2GW2VC0aow06KZcV7lUR8pEYHlUumJgskuORGc7rVY+8l/z1To37GBA+fh1gJHk
	 uWDM9O4iFlUVPPriMElCb/ty9p9nS0hBiBNhsoVj8EXKKrs+jbscyeaKTXjb6zOD0P
	 pG4vPzbBFM6k1b4DuyLe16B26drQecc54Y/DPI8FTf7KaghBTCDKjhm30M3/ixeWhr
	 ccRlvLrMKT71A==
Date: Mon, 25 Mar 2024 20:42:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: George Stark <gnstark@salutedevices.com>
Cc: Harald Geyer <harald@ccbib.org>, <lars@metafoo.de>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel@salutedevices.com>
Subject: Re: [PATCH] iio: dht11: set debug log level for parsing error
 messages
Message-ID: <20240325204200.466ff642@jic23-huawei>
In-Reply-To: <01ed720d-a990-40dd-8a59-a95ea960ecec@salutedevices.com>
References: <20240325165406.226916-1-gnstark@salutedevices.com>
	<c2fb93a5b2e6f437e2c92d0d797509c619cb63a8.camel@ccbib.org>
	<01ed720d-a990-40dd-8a59-a95ea960ecec@salutedevices.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Mar 2024 23:18:32 +0300
George Stark <gnstark@salutedevices.com> wrote:

> Hello Harald
>=20
> Thanks for the review.
>=20
>=20
> On 3/25/24 21:48, Harald Geyer wrote:
> > Hi George!
> >=20
> > I'm torn on this:
> >=20
> > Am Montag, dem 25.03.2024 um 19:54 +0300 schrieb George Stark: =20
> >> Protocol parsing errors could happen due to several reasons like
> >> noise
> >> environment, heavy load on system etc. If to poll the sensor
> >> frequently
> >> and/or for a long period kernel log will become polluted with error
> >> messages if their log level is err (i.e. on by default). =20
> >=20
> > Yes, these error are often recoverable. (As are many other HW errors,
> > that typically are logged. Eg USB bus resets due to EMI)
> >=20
> > However they are still genuine errors of the HW.
> >  =20
> >>   Also some types
> >> of those messages already have dbg level so use unified log level for
> >> all such cases. =20
> >=20
> > My take so far has been: Debug level messages are for debugging the
> > code (ie adding/testing support of new device variants etc). Users
> > aren't expected to know about or enable debug output. OTOH anything
> > actually going wrong is an error and should be logged as such.
> >=20
> > The idea is, that these messages help users understand issues with
> > their HW (like too long cables, broken cables etc). But it is true,
> > that they will slowly accumulate in many real world scenarios without
> > anything being truly wrong. =20
>=20
> I agree with you that it's very convenient to just take a look to dmesg
> and see device connection problems at once. But unlike e.g. usb user has
> to actually start reading sensor to perform communication and read
> errors will be propagated to the userspace and could be noticed \
> handled.
>=20
> Anyway I believe we should use uniform approach for read errors -
> currently in the driver there're already dbg messages:
>=20
> "lost synchronisation at edge %d\n"
> "invalid checksum\n"
>=20
> I changed log level from err to dbg for the messages:
>=20
> "Only %d signal edges detected\n"
> "Don't know how to decode data: %d %d %d %d\n"
>=20
> They all are from a single callback and say the same thing -
> communication problem.
>=20
> If we make all those messages as errors it'd be great to have mechanism
> to disable them e.g. thru module parameter or somehow without rebuilding
> kernel. Those errors can be bypassed by increasing read rate.

Don't use a parameter for this.  dev_dbg and dynamic debug is the
way to go if this is the choice available.

If Harald is comfortable with the change given this discussion, I'll pick
up this patch.

Jonathan

>=20
> >=20
> > I don't consider the dmesg buffer being rotated after a month or two a
> > bug. But I suppose this is a corner case. I'll happily accept whatever
> > Jonathan thinks is reasonable.
> >=20
> > Best regards,
> > Harald
> >=20
> >  =20
> >> Signed-off-by: George Stark <gnstark@salutedevices.com>
> >> ---
> >> I use DHT22 sensor with Raspberry Pi Zero W as a simple home meteo
> >> station.
> >> Even if to poll the sensor once per tens of seconds after month or
> >> two dmesg
> >> may become full of useless parsing error messages. Anyway those
> >> errors are caught
> >> in the user software thru return values.
> >>
> >>  =C2=A0drivers/iio/humidity/dht11.c | 4 ++--
> >>  =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/iio/humidity/dht11.c
> >> b/drivers/iio/humidity/dht11.c
> >> index c97e25448772..e2cbc442177b 100644
> >> --- a/drivers/iio/humidity/dht11.c
> >> +++ b/drivers/iio/humidity/dht11.c
> >> @@ -156,7 +156,7 @@ static int dht11_decode(struct dht11 *dht11, int
> >> offset)
> >>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0dht11->temperature =3D temp_int * 1000;
> >>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0dht11->humidity =3D hum_int * 1000;
> >>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0dev_err(dht11->dev,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0dev_dbg(dht11->dev,
> >>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"Don't know how to decode data: %d %d %d
> >> %d\n",
> >>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
hum_int, hum_dec, temp_int, temp_dec);
> >>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EIO;
> >> @@ -239,7 +239,7 @@ static int dht11_read_raw(struct iio_dev
> >> *iio_dev,
> >>  =C2=A0#endif
> >>
> >>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret =3D=3D 0 && dht11->num_edges <
> >> DHT11_EDGES_PER_READ - 1) {
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_er=
r(dht11->dev, "Only %d signal edges
> >> detected\n",
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_db=
g(dht11->dev, "Only %d signal edges
> >> detected\n",
> >>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dht11->num_edges);
> >>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
ret =3D -ETIMEDOUT;
> >>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> >> --
> >> 2.25.1
> >> =20
> >  =20
>=20


