Return-Path: <linux-kernel+bounces-126879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E20C8942C6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054BC283727
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E10487BE;
	Mon,  1 Apr 2024 16:55:59 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF598BA3F;
	Mon,  1 Apr 2024 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990558; cv=none; b=cElYWVBtsEMgSgM0zLRwr8GSwoOXKOvvTvLA4ggeGpayV9ylZ7QjM/Nup+4uRuCaG/3TUeMBO1PjCVHeWxc2Gsq8DDimkVXjDM0FtmLE9TciI185qJzP/uBy42LmNf5e5GK1SzPKVw/xytoBpNThIDVPS+n6p2cyxy7iRp6/WpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990558; c=relaxed/simple;
	bh=0IFv5Z+CJ6jUa1t6RTaoeD6OQp8Vpndpg9+lGa18fEI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EdtbaGls/U/JcZIWByR30vXsplqBCYMhCmdlTPEMcuB7o3I/PKFXXMparwWHt24cQ5yHtOU+jPIfAVMKA9qM4KN/KedGu9xt33cUN3XKRjW5EGaOxcUS6DF2eI0B3SlBe96hf6vzI8fqTz1yu4l1g2HuuK+DogVLHAZFzyXU/tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V7cYv5X0qz6K6T1;
	Tue,  2 Apr 2024 00:54:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5482A1400D1;
	Tue,  2 Apr 2024 00:55:54 +0800 (CST)
Received: from localhost (10.48.156.172) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 1 Apr
 2024 17:55:53 +0100
Date: Mon, 1 Apr 2024 17:55:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <lars@metafoo.de>,
	<Michael.Hennerich@analog.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eraretuya@gmail.com>
Subject: Re: [PATCH v6 7/7] iio: accel: adxl345: Add spi-3wire option
Message-ID: <20240401175552.00003665@Huawei.com>
In-Reply-To: <CAFXKEHbM5kcSvfqHmfetzy8Gp_jOK0ZMbOjBK8USkNdxyNAT5w@mail.gmail.com>
References: <20240329004030.16153-1-l.rubusch@gmail.com>
	<20240329004030.16153-8-l.rubusch@gmail.com>
	<20240330152949.7e10ebcc@jic23-huawei>
	<CAFXKEHbM5kcSvfqHmfetzy8Gp_jOK0ZMbOjBK8USkNdxyNAT5w@mail.gmail.com>
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

On Mon, 1 Apr 2024 17:44:22 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Sat, Mar 30, 2024 at 4:30=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Fri, 29 Mar 2024 00:40:30 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Add a setup function implementation to the spi module to enable spi-3=
wire
> > > when specified in the device-tree.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > ---
> > >  drivers/iio/accel/adxl345.h     |  1 +
> > >  drivers/iio/accel/adxl345_spi.c | 12 +++++++++++-
> > >  2 files changed, 12 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> > > index e859c01d4..3d5c8719d 100644
> > > --- a/drivers/iio/accel/adxl345.h
> > > +++ b/drivers/iio/accel/adxl345.h
> > > @@ -31,6 +31,7 @@
> > >  #define ADXL345_DATA_FORMAT_RANGE    GENMASK(1, 0)   /* Set the g ra=
nge */
> > >  #define ADXL345_DATA_FORMAT_JUSTIFY  BIT(2)  /* Left-justified (MSB)=
 mode */
> > >  #define ADXL345_DATA_FORMAT_FULL_RES BIT(3)  /* Up to 13-bits resolu=
tion */
> > > +#define ADXL345_DATA_FORMAT_SPI_3WIRE        BIT(6)  /* 3-wire SPI m=
ode */
> > >  #define ADXL345_DATA_FORMAT_SELF_TEST        BIT(7)  /* Enable a sel=
f test */
> > >
> > >  #define ADXL345_DATA_FORMAT_2G               0
> > > diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl=
345_spi.c
> > > index 1c0513bd3..f145d5c1d 100644
> > > --- a/drivers/iio/accel/adxl345_spi.c
> > > +++ b/drivers/iio/accel/adxl345_spi.c
> > > @@ -20,6 +20,16 @@ static const struct regmap_config adxl345_spi_regm=
ap_config =3D {
> > >       .read_flag_mask =3D BIT(7) | BIT(6),
> > >  };
> > >
> > > +static int adxl345_spi_setup(struct device *dev, struct regmap *regm=
ap)
> > > +{
> > > +     struct spi_device *spi =3D container_of(dev, struct spi_device,=
 dev);
> > > +
> > > +     if (spi->mode & SPI_3WIRE)
> > > +             return regmap_write(regmap, ADXL345_REG_DATA_FORMAT,
> > > +                                 ADXL345_DATA_FORMAT_SPI_3WIRE); =20
> > My only remaining comment on this patch set is to add equivalent of
> >         else
> >                 return regmap_write(regmap, ADXL345_REG_DATA_FORMAT, 0);
> >
> > If the hardware had some sort of software reset, that was used,
> > this wouldn't be needed as the status of those other bits would be know=
n.
> > If we leave them alone in the non 3wire path we may in the future have
> > subtle issues because some other code left this in an odd state and
> > we clear those other bits only for 3wire mode.
> > =20
>=20
> I see your point. Thinking over it, I came to the following: Given the
> spi-3wire case, if I did a regmap_write(spi-3wire), else I did
> regmap_write(0), in the i2c case I still passed NULL as setup()
> function. So there would still be just a regmap_update() only in the
> core module. Furthermore I see three cases: spi_setup() passed w/
> 3wire, spi_setu() passed w/o 3wire or NULL passed. This means there is
> the same issue and more complexity. Hence, I will not do this. I think
> I found something else.

Good point. I'd forgotten the call was in an optional callback.

>=20
> What do you think about the following approach: If there is a
> spi-3wire set in the device-tree, I pass the setup() function, else I
> pass NULL. Then in the core module, if the setup() function is valid,
> I do a regmap_update(), else the first option will be set with

regmap_update()?

> regmap_write(). This makes up only two cases: setup() passed, or not -
> and in either case the first call will be a regmap_write(). Thus all
> bits are initialized to a defined state. I will update the patchset
> later today, that you can see.
That sounds like a good solution.

Jonathan

>=20
> Happy Easter!
> Lothar
>=20
> > Jonathan
> > =20
> > > +     return 0;
> > > +}
> > > +
> > >  static int adxl345_spi_probe(struct spi_device *spi)
> > >  {
> > >       struct regmap *regmap;
> > > @@ -33,7 +43,7 @@ static int adxl345_spi_probe(struct spi_device *spi)
> > >       if (IS_ERR(regmap))
> > >               return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error=
 initializing regmap\n");
> > >
> > > -     return adxl345_core_probe(&spi->dev, regmap, NULL);
> > > +     return adxl345_core_probe(&spi->dev, regmap, adxl345_spi_setup);
> > >  }
> > >
> > >  static const struct adxl345_chip_info adxl345_spi_info =3D { =20
> > =20
>=20


