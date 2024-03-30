Return-Path: <linux-kernel+bounces-125764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9799892BD4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493691F21D8E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 15:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407A5381CC;
	Sat, 30 Mar 2024 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1BQWKmV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6180F1C0DEF;
	Sat, 30 Mar 2024 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711812256; cv=none; b=X5tG8w4nUNqY6NE/v78FLLDpGa3AhZxhIBYi5nV/UzBFswmSQ9ysDDITuglDsZ44FopJ+E9AEiitDVl/6VZXwH+RuWnib2L9MB4v1TUKn7IJ08zOv1Z8A+jHCwtFbRigMRk6SMMdzzPznPQDl5IqAv9iVFPfIjIRnaL9IKTSFDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711812256; c=relaxed/simple;
	bh=xwVgPuNbq26KNzM76i0ExTuIRKP4D/YIk/CCLg8HDEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJzH1AnM/WLEk1x2PtVsKydYSqIMjl/otnfOvodl/OrSHZpvd9oSBiHjLyrc0gWI1eCJWFts13hDSD5UEM8YPavXfYlrPFrU/wBvu4FZl7UTMZDLNtGGXdFFcx9XQle6InQf7GUI2uiXMgsHIY4nDS3HzdekMIrCpvG5wg+ZwE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1BQWKmV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B30AC433C7;
	Sat, 30 Mar 2024 15:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711812256;
	bh=xwVgPuNbq26KNzM76i0ExTuIRKP4D/YIk/CCLg8HDEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y1BQWKmVo280xcb4gAhSzfJPYgFjnRnW+EMeDtcx+alHMA9mP373askE8jPtJ0/9+
	 P5xCyjuzK/IZ78LgYSfzJNlaijeEzbck4RolGgIKOPYJVqrKGqwy0/ngOQzkIte1pX
	 15BB4qo/4K6DzqSuu3e/h0CvSsrznGnxGwoDsp7clYG87M9u93U5JgKs7/3cGgNDXa
	 dsvTRiays3nYFabD6ha3fQU4YPo6gjbTXx3Ph/G5P7J4pUBP6UXb4EIS6/PxE6zkoC
	 yge9XFAMubLHRNQ+X7zPT83NO/oCtndy1aqLYUhfSmVOGh02chklqgiVuHvIOhrBV5
	 d1R8P1K/sZzrw==
Date: Sat, 30 Mar 2024 15:24:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v5 7/7] iio: accel: adxl345: Add spi-3wire option
Message-ID: <20240330152401.034aedad@jic23-huawei>
In-Reply-To: <CAFXKEHZva5AE=sinx_i0Gec2FbB4ZfyEu8mWg52omzGBvr5uXw@mail.gmail.com>
References: <20240327220320.15509-1-l.rubusch@gmail.com>
	<20240327220320.15509-8-l.rubusch@gmail.com>
	<20240328133927.7e49f3bf@jic23-huawei>
	<CAFXKEHZva5AE=sinx_i0Gec2FbB4ZfyEu8mWg52omzGBvr5uXw@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Mar 2024 01:33:01 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Thu, Mar 28, 2024 at 2:39=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Wed, 27 Mar 2024 22:03:20 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Add a setup function implementation to the spi module to enable spi-3=
wire
> > > as option when specified in the device-tree.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > ---
> > >  drivers/iio/accel/adxl345.h     |  2 ++
> > >  drivers/iio/accel/adxl345_spi.c | 12 +++++++++++-
> > >  2 files changed, 13 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> > > index 4ea9341d4..e6bc3591c 100644
> > > --- a/drivers/iio/accel/adxl345.h
> > > +++ b/drivers/iio/accel/adxl345.h
> > > @@ -30,6 +30,8 @@
> > >  #define ADXL345_POWER_CTL_MEASURE    BIT(3)
> > >  #define ADXL345_POWER_CTL_STANDBY    0x00
> > >
> > > +#define ADXL345_DATA_FORMAT_SPI_3WIRE        BIT(6) /* 3-wire SPI mo=
de */
> > > +
> > >  #define ADXL345_DATA_FORMAT_RANGE    GENMASK(1, 0) /* Set the g rang=
e */
> > >  #define ADXL345_DATA_FORMAT_JUSTIFY  BIT(2) /* Left-justified (MSB) =
mode */
> > >  #define ADXL345_DATA_FORMAT_FULL_RES BIT(3) /* Up to 13-bits resolut=
ion */
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
> > Your earlier patch carefully (I think) left one or two fields alone, th=
en
> > this write just comes in and changes them. In particular INT_INVERT.
> > =20
> Why do you refer here to INT_INVERT? In this code above I try to set
> SPI to 3 lines. Since this is a SPI configuration, i.e. bus specific,
> it happens in adxl345_spi.c. Passing this function to the bus
> independent adxl345_core.c file allows to configure the bus first.
> Therefore, I'm using the update function in core masking out the SPI
> filag.

Ah. Ok.  It was only intended to mask out the SPI3-wire bit, not the
other bits that you also masked out.  I thought intent was to leave
them untouched for some reason.  Given they don't matter in the driver
at the moment (no interrupt support) then no problem.

>=20
> My reason why I try to keep INT_INVERT out is different. There is
> another driver for the same part in the kernel:
> ./drivers/input/misc/adxl34x.c - This is a input driver, using the
> interrupts of the adxl345 for the input device implementation. I
> assumed, that in the iio implementation there won't be interrupt
> handling for the adx345, since it is not an input device. Does this
> make sense?

No. You can't use these two drivers at the same time.  They will almost
certainly trample over each other in actually reading channels etc.

Their is some legacy of old drivers in input from a long time back.
Given this driver clearly doesn't have full functionality yet in IIO there
and the different userspace ABI, we've just left the input driver alone.

>=20
> > If it doesn't makes sense to write it there, either write that bit
> > every time here, or leave it alone every time.  Not decide on whether
> > to write the bit based on SPI_3WIRE or not.  As far as I know they
> > are unconnected features.
> > =20
> I think I did not understand. Could you please specify a bit more?
> When spi-3wire is configured in the DT it has to be parsed and handled
> in the bus specific part, i.e. the adxl345_spi.c Therefore I configure
> SPI_3WIRE there. I don't want to place SPI specific code in the core
> file.

My confusion was that you were deliberately not touching the other unused
flags.  In reality you are touching the but only if you enable 3wire.
I would write them register to 0 in the !3wire case so all other values
are the same in both paths.

>=20
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


