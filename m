Return-Path: <linux-kernel+bounces-117775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B338988AF78
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD22F1C6197D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AE4125D5;
	Mon, 25 Mar 2024 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1ROJjS2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2233F10940;
	Mon, 25 Mar 2024 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393856; cv=none; b=OwioBDKHJfchDZTqzt25utYXXdlCskUwTEmhVDeBRn17wxX2PTahMASFM/7CCh9PcpWZ/Ta22paX2GLCuYUxEMCuSJ8eZ/acB6Kp0s4mpFyuqNjbM+5xMojuh7V6ilJDAwtx64DqsWw+8hehlK3EL2Q/Pd3K1500ZYtGVWuHy58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393856; c=relaxed/simple;
	bh=Acg0P6AHCvwEDQelG6mbWObj6GUgihKlFCeUtBlOkuw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4pEORIWtRrHmxDIkCFpEOSccCtDi+lPsOA5GOQEW8CJCB4l0BFwX/WrCYxWVVgMpDaH7QM2EHHj+Sn+n8IEWQtbzC9CycBj+sg54E3GpKCFdpo5/A4N1zvDvLYrQ1KOsYlIinhojJGFYt6u4rKJPPbFav+B0UPjTc0iz1yjK4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1ROJjS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B701C433F1;
	Mon, 25 Mar 2024 19:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711393855;
	bh=Acg0P6AHCvwEDQelG6mbWObj6GUgihKlFCeUtBlOkuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z1ROJjS2wfitCIoVCEDPjtOEzHQJT0uiW4XAkfhJGVsq0eIJPR3HFqfqxRBSEQQrE
	 ot6UYgldEy44NAtGF25VtzyH+Rp9hr0E1dJwYo7yOHh3qyyKfyl+HIzi4lIKqQdsDk
	 ztNbvHxwbB0f5hvdCfce/KM+gtfpUKuiIYoRSJsRfDaY8aogS/I0KFw2ukxSMrz0cW
	 5GJ9fSIe3JSyaIK2HTd+8sMZlDq/UB9mmNTtd+obfbhn430C/1XFSpegURmurrM7Ek
	 J9c+YsNRpOq23e6+R1Sa2c/eNd/RqwvFqGaH8q612iyzRASCPzF9Meq1v/ygCadU9M
	 f6ctZt892CJ5Q==
Date: Mon, 25 Mar 2024 19:10:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Harald Geyer <harald@ccbib.org>
Cc: George Stark <gnstark@salutedevices.com>, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@salutedevices.com
Subject: Re: [PATCH] iio: dht11: set debug log level for parsing error
 messages
Message-ID: <20240325191043.4acd6532@jic23-huawei>
In-Reply-To: <c2fb93a5b2e6f437e2c92d0d797509c619cb63a8.camel@ccbib.org>
References: <20240325165406.226916-1-gnstark@salutedevices.com>
	<c2fb93a5b2e6f437e2c92d0d797509c619cb63a8.camel@ccbib.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Mar 2024 19:48:00 +0100
Harald Geyer <harald@ccbib.org> wrote:

> Hi George!
>=20
> I'm torn on this:
>=20
> Am Montag, dem 25.03.2024 um 19:54 +0300 schrieb George Stark:
> > Protocol parsing errors could happen due to several reasons like
> > noise
> > environment, heavy load on system etc. If to poll the sensor
> > frequently
> > and/or for a long period kernel log will become polluted with error
> > messages if their log level is err (i.e. on by default). =20
>=20
> Yes, these error are often recoverable. (As are many other HW errors,
> that typically are logged. Eg USB bus resets due to EMI)
>=20
> However they are still genuine errors of the HW.
>=20
> >  Also some types
> > of those messages already have dbg level so use unified log level for
> > all such cases. =20
>=20
> My take so far has been: Debug level messages are for debugging the
> code (ie adding/testing support of new device variants etc). Users
> aren't expected to know about or enable debug output. OTOH anything
> actually going wrong is an error and should be logged as such.
>=20
> The idea is, that these messages help users understand issues with
> their HW (like too long cables, broken cables etc). But it is true,
> that they will slowly accumulate in many real world scenarios without
> anything being truly wrong.
>=20
> I don't consider the dmesg buffer being rotated after a month or two a
> bug. But I suppose this is a corner case. I'll happily accept whatever
> Jonathan thinks is reasonable.
My take:

If the errors are eaten with no user visibility then they should
be logged (errors in interrupt handlers etc) but for errors in
code that returns an error code to the userspace read or similar there
is info that 'something went wrong' available via that then it's fine
to use dev_dbg() with expectation anyone who is looking into issues
can turn them on.  However, I defer to driver maintainers on whether
they prefer dev_err() or dev_dbg() for these sorts of cases. Far
as I'm concerned either choice is fine and it's a judgement on
the expected rates of error and impact.

Jonathan

>=20
> Best regards,
> Harald
>=20
>=20
> > Signed-off-by: George Stark <gnstark@salutedevices.com>
> > ---
> > I use DHT22 sensor with Raspberry Pi Zero W as a simple home meteo
> > station.
> > Even if to poll the sensor once per tens of seconds after month or
> > two dmesg
> > may become full of useless parsing error messages. Anyway those
> > errors are caught
> > in the user software thru return values.
> >=20
> > =C2=A0drivers/iio/humidity/dht11.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/humidity/dht11.c
> > b/drivers/iio/humidity/dht11.c
> > index c97e25448772..e2cbc442177b 100644
> > --- a/drivers/iio/humidity/dht11.c
> > +++ b/drivers/iio/humidity/dht11.c
> > @@ -156,7 +156,7 @@ static int dht11_decode(struct dht11 *dht11, int
> > offset)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0dht11->temperature =3D temp_int * 1000;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0dht11->humidity =3D hum_int * 1000;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0dev_err(dht11->dev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0dev_dbg(dht11->dev,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
"Don't know how to decode data: %d %d %d
> > %d\n",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
hum_int, hum_dec, temp_int, temp_dec);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EIO;
> > @@ -239,7 +239,7 @@ static int dht11_read_raw(struct iio_dev
> > *iio_dev,
> > =C2=A0#endif
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret =3D=3D 0 && dht11->num_edges <
> > DHT11_EDGES_PER_READ - 1) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_er=
r(dht11->dev, "Only %d signal edges
> > detected\n",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_db=
g(dht11->dev, "Only %d signal edges
> > detected\n",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dht11->num_edges);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
ret =3D -ETIMEDOUT;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > --
> > 2.25.1
> >  =20
>=20


