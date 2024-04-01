Return-Path: <linux-kernel+bounces-126877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA42894282
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599A32808DD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CDF4C601;
	Mon,  1 Apr 2024 16:53:14 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDBF63E;
	Mon,  1 Apr 2024 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990393; cv=none; b=tQL7WbU25LfIwOmp6xQbGStgSNjEYUFSC3DSLa3s/XGfst4w6Noxkbk7EtpdvKvfs39ohsIKCZzvgEtYjeJDYfI4t8Jiyg2ffUYMcSxeSUVUXcpudjiKEoHfNelfhVa18MLP0kxARlzzgZv/V+qM/NRr1urlDzMqcxmdt+kauME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990393; c=relaxed/simple;
	bh=1zQVlZWPnZ2OEuwReJO9yrNBHzqfUfkWUxaXLzm/pFk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cb28BYtZWwHNqP4D5QfKGnOyL++gVaQMwChBaDj16yTMi/YbV6gLrIqN9hLCmNlsRetSAGnAUKDpdDpvtpwDuIuXFCRIYUsOMAwdRVHnuq+VEMpHJ8XgB+kpz8QvHfbsATrpq2YG+tvjyFYrUkv86j7JoRG2igY7SEONZfm4fqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V7cVd6s40z6J9pj;
	Tue,  2 Apr 2024 00:51:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F5891400D9;
	Tue,  2 Apr 2024 00:53:08 +0800 (CST)
Received: from localhost (10.48.156.172) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 1 Apr
 2024 17:53:07 +0100
Date: Mon, 1 Apr 2024 17:53:04 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <lars@metafoo.de>,
	<Michael.Hennerich@analog.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eraretuya@gmail.com>
Subject: Re: [PATCH v5 7/7] iio: accel: adxl345: Add spi-3wire option
Message-ID: <20240401175304.000022ed@Huawei.com>
In-Reply-To: <CAFXKEHZJZU69udvM86rDSNU1J9o=v62BJcJfTrB=Y9Tgsjm4fw@mail.gmail.com>
References: <20240327220320.15509-1-l.rubusch@gmail.com>
	<20240327220320.15509-8-l.rubusch@gmail.com>
	<20240328133927.7e49f3bf@jic23-huawei>
	<CAFXKEHZva5AE=sinx_i0Gec2FbB4ZfyEu8mWg52omzGBvr5uXw@mail.gmail.com>
	<20240330152401.034aedad@jic23-huawei>
	<CAFXKEHZJZU69udvM86rDSNU1J9o=v62BJcJfTrB=Y9Tgsjm4fw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 1 Apr 2024 18:06:24 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Sat, Mar 30, 2024 at 4:24=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Fri, 29 Mar 2024 01:33:01 +0100
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > On Thu, Mar 28, 2024 at 2:39=E2=80=AFPM Jonathan Cameron <jic23@kerne=
l.org> wrote: =20
> > > >
> > > > On Wed, 27 Mar 2024 22:03:20 +0000
> > > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > > > =20
> > > > > Add a setup function implementation to the spi module to enable s=
pi-3wire
> > > > > as option when specified in the device-tree.
> > > > >
> > > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > > > ---
> > > > >  drivers/iio/accel/adxl345.h     |  2 ++
> > > > >  drivers/iio/accel/adxl345_spi.c | 12 +++++++++++-
> > > > >  2 files changed, 13 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl=
345.h
> > > > > index 4ea9341d4..e6bc3591c 100644
> > > > > --- a/drivers/iio/accel/adxl345.h
> > > > > +++ b/drivers/iio/accel/adxl345.h
> > > > > @@ -30,6 +30,8 @@
> > > > >  #define ADXL345_POWER_CTL_MEASURE    BIT(3)
> > > > >  #define ADXL345_POWER_CTL_STANDBY    0x00
> > > > >
> > > > > +#define ADXL345_DATA_FORMAT_SPI_3WIRE        BIT(6) /* 3-wire SP=
I mode */
> > > > > +
> > > > >  #define ADXL345_DATA_FORMAT_RANGE    GENMASK(1, 0) /* Set the g =
range */
> > > > >  #define ADXL345_DATA_FORMAT_JUSTIFY  BIT(2) /* Left-justified (M=
SB) mode */
> > > > >  #define ADXL345_DATA_FORMAT_FULL_RES BIT(3) /* Up to 13-bits res=
olution */
> > > > > diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/=
adxl345_spi.c
> > > > > index 1c0513bd3..f145d5c1d 100644
> > > > > --- a/drivers/iio/accel/adxl345_spi.c
> > > > > +++ b/drivers/iio/accel/adxl345_spi.c
> > > > > @@ -20,6 +20,16 @@ static const struct regmap_config adxl345_spi_=
regmap_config =3D {
> > > > >       .read_flag_mask =3D BIT(7) | BIT(6),
> > > > >  };
> > > > >
> > > > > +static int adxl345_spi_setup(struct device *dev, struct regmap *=
regmap)
> > > > > +{
> > > > > +     struct spi_device *spi =3D container_of(dev, struct spi_dev=
ice, dev);
> > > > > +
> > > > > +     if (spi->mode & SPI_3WIRE)
> > > > > +             return regmap_write(regmap, ADXL345_REG_DATA_FORMAT,
> > > > > +                                 ADXL345_DATA_FORMAT_SPI_3WIRE);=
 =20
> > > > Your earlier patch carefully (I think) left one or two fields alone=
, then
> > > > this write just comes in and changes them. In particular INT_INVERT.
> > > > =20
> > > Why do you refer here to INT_INVERT? In this code above I try to set
> > > SPI to 3 lines. Since this is a SPI configuration, i.e. bus specific,
> > > it happens in adxl345_spi.c. Passing this function to the bus
> > > independent adxl345_core.c file allows to configure the bus first.
> > > Therefore, I'm using the update function in core masking out the SPI
> > > filag. =20
> >
> > Ah. Ok.  It was only intended to mask out the SPI3-wire bit, not the
> > other bits that you also masked out.  I thought intent was to leave
> > them untouched for some reason.  Given they don't matter in the driver
> > at the moment (no interrupt support) then no problem.
> > =20
> > >
> > > My reason why I try to keep INT_INVERT out is different. There is
> > > another driver for the same part in the kernel:
> > > ./drivers/input/misc/adxl34x.c - This is a input driver, using the
> > > interrupts of the adxl345 for the input device implementation. I
> > > assumed, that in the iio implementation there won't be interrupt
> > > handling for the adx345, since it is not an input device. Does this
> > > make sense? =20
> >
> > No. You can't use these two drivers at the same time.  They will almost
> > certainly trample over each other in actually reading channels etc.
> >
> > Their is some legacy of old drivers in input from a long time back.
> > Given this driver clearly doesn't have full functionality yet in IIO th=
ere
> > and the different userspace ABI, we've just left the input driver alone.
> > =20
> Going by the git history gave this impression, too. But it was still a
> bit confusing to me.
>=20
> The IIO driver so far does not handle any of the interrupt features.
> The older driver also seems to support more of the chip's features.
> Would it make sense to continue implement/port what's missing -
> feature by feature - for the IIO driver in order to make the input
> driver obsolete (one day)?

Yes, though it will be challenging because of the ABI differences.
We do have a few cross subsystem bridge drivers, but the few goes we've
had at an accel bridge driver haven't made it into the kernel.  In particul=
ar
we don't have an in kernel interface for threshold events and similar in II=
O.
It would be easy enough to add one, but no one has ever cared enough to
do the work. :(

Jonathan


>=20
> > > =20
> > > > If it doesn't makes sense to write it there, either write that bit
> > > > every time here, or leave it alone every time.  Not decide on wheth=
er
> > > > to write the bit based on SPI_3WIRE or not.  As far as I know they
> > > > are unconnected features.
> > > > =20
> > > I think I did not understand. Could you please specify a bit more?
> > > When spi-3wire is configured in the DT it has to be parsed and handled
> > > in the bus specific part, i.e. the adxl345_spi.c Therefore I configure
> > > SPI_3WIRE there. I don't want to place SPI specific code in the core
> > > file. =20
> >
> > My confusion was that you were deliberately not touching the other unus=
ed
> > flags.  In reality you are touching the but only if you enable 3wire.
> > I would write them register to 0 in the !3wire case so all other values
> > are the same in both paths.
> > =20
> > > =20
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > >  static int adxl345_spi_probe(struct spi_device *spi)
> > > > >  {
> > > > >       struct regmap *regmap;
> > > > > @@ -33,7 +43,7 @@ static int adxl345_spi_probe(struct spi_device =
*spi)
> > > > >       if (IS_ERR(regmap))
> > > > >               return dev_err_probe(&spi->dev, PTR_ERR(regmap), "E=
rror initializing regmap\n");
> > > > >
> > > > > -     return adxl345_core_probe(&spi->dev, regmap, NULL);
> > > > > +     return adxl345_core_probe(&spi->dev, regmap, adxl345_spi_se=
tup);
> > > > >  }
> > > > >
> > > > >  static const struct adxl345_chip_info adxl345_spi_info =3D { =20
> > > > =20
> > =20
>=20


