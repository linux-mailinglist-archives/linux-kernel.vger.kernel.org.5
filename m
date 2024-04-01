Return-Path: <linux-kernel+bounces-126843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46D3893EB8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19531C216A0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDF947A76;
	Mon,  1 Apr 2024 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYtYLQwz"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E251CA8F;
	Mon,  1 Apr 2024 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987623; cv=none; b=Gm7AMgr/SZbIhgzwyhDbOneixRWYrY6GKiKkan9JX7EHolvHAM+797t6MuEiVQpDGzeU4CMQkN4oCIWOW9TWOvKds1HGXCEyM9+85ZWRjUVmQgVtRBcHSHKWDxdRlavk/qMK8aVj3J9IEyOBTfqAY3oSvSdDw2D2+n7Wf9i9N9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987623; c=relaxed/simple;
	bh=75pLzrvTuDGI5dx5WohkbFjhSR2aCpPDejzDATL4oRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Chc9Ol4wVhrAHWjUj/P8YVA1nn4HIpf8DwCwEzZxEq+skCK+NaZSKK4EQlk1ODYgJG5EcQsQSlgUgh6gvg7XYvTn6igbcSlap3wMiZ6KEfyTlVsOjkXUYmD30lRln6ou2i/DQn+nBcq8vP8dF6ezLh2R5bffFiMcvgvif0ok1S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYtYLQwz; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dbed179f0faso3309291276.1;
        Mon, 01 Apr 2024 09:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711987620; x=1712592420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0tHN7TxG38kjHDZVWnDgVEj1Az1vXT85uVmni/sB1I=;
        b=IYtYLQwziNW8hMPtfxlcqHSeaVnR6x/zo53kj4+1/guD+kkghLxCAsWZmF3/U/jtFg
         ibGbYk2H/o5vvqReNh+Lot54dIjjHM6PQU13pq/NQGuOOeOPhbMvLOw+rRJtQzNbkfWf
         jVR9OD3Uswixt4VCWw0/OHLyTAQL76xec9sv4fwXT05YH39hyPld+lJQwjNxOnQi/fJC
         WaH2KlMSl9WDz6reIY0tkPQHChiyRyKuhR4+DhcSHvEAgc3ThHEHgWp5o52eiuu0c4C5
         F9/akGqVT7QIL9N4Fg8gxlD625eReNcDG80wVMLjE4/FlNQWIZ9OnD/da+Uy1UfDKgW5
         njOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711987620; x=1712592420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0tHN7TxG38kjHDZVWnDgVEj1Az1vXT85uVmni/sB1I=;
        b=k7B/KpHorw3QiPlesyE6hvLMn30IIWuuC1/yZ5Ij//2levZFz/rmDGCcQjcQnSmCVz
         XtMGZnPus4ifpeSiNRrmMq6vOTVBiS56wOCqA/7StUaBOSLlxpE3JdNzrRGSPp5oMtt1
         waccblPs3fNX4IP1Q1/OL6ciyc9cafl8ALGT6ArzGWwI3ORdhaJxYDtXQ8lilBDlTMKy
         nbigA2d0UQCPXT4FrSmgO8Y6FjuuWsuKQVUN1Cx/QrmNs3jvM9T9nQF2OsjXmz1dz75R
         iE5J37rjCAGSdQ8nO5h6+4qoULDFnBCAzqoADh8NPib/+PhizFHa4oExBX/nt1S+eW0h
         mpUA==
X-Forwarded-Encrypted: i=1; AJvYcCXjKLxy3wW5/RRIX/cQCi79ZiqKIf6MfMr7XumJdMasXIfwYSDovBQwR7dgCaetHjAr2F5j2BdrOQO8LRzatXw82DnS/uEGGNi/sIuGKDWklO9npPULAwXVqnEHwT34r8LOEZTfjQ0HvqyUC5+KLh8YUzAnTBUy4V3ZAhngYgmHBbtfBA==
X-Gm-Message-State: AOJu0Ywyky9TbmruZyD5hBog40oGm2S3xc2iFTsYEiyA03FwAmswPCsM
	wEieJDy6dzwS/B3B+hRt95EZ496D9RsI9fnzsPTN8/K8TZIv1r9KlJYv+UBeyU0MV4xAOyJp8pu
	Up/Or061HgYKxok0YUiAPDCaTz8c=
X-Google-Smtp-Source: AGHT+IHFC40eE5Z3E1NsJt0aSM5ri4j6lmmn9kFDd4CWvw9namBexhNLZ195ANzDIMoo8LD/jUo2Qm6YLJo9pQdW5Cc=
X-Received: by 2002:a25:bf82:0:b0:dc6:d1a9:d858 with SMTP id
 l2-20020a25bf82000000b00dc6d1a9d858mr6429732ybk.8.1711987620495; Mon, 01 Apr
 2024 09:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327220320.15509-1-l.rubusch@gmail.com> <20240327220320.15509-8-l.rubusch@gmail.com>
 <20240328133927.7e49f3bf@jic23-huawei> <CAFXKEHZva5AE=sinx_i0Gec2FbB4ZfyEu8mWg52omzGBvr5uXw@mail.gmail.com>
 <20240330152401.034aedad@jic23-huawei>
In-Reply-To: <20240330152401.034aedad@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Mon, 1 Apr 2024 18:06:24 +0200
Message-ID: <CAFXKEHZJZU69udvM86rDSNU1J9o=v62BJcJfTrB=Y9Tgsjm4fw@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] iio: accel: adxl345: Add spi-3wire option
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 4:24=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 29 Mar 2024 01:33:01 +0100
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > On Thu, Mar 28, 2024 at 2:39=E2=80=AFPM Jonathan Cameron <jic23@kernel.=
org> wrote:
> > >
> > > On Wed, 27 Mar 2024 22:03:20 +0000
> > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > >
> > > > Add a setup function implementation to the spi module to enable spi=
-3wire
> > > > as option when specified in the device-tree.
> > > >
> > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > > ---
> > > >  drivers/iio/accel/adxl345.h     |  2 ++
> > > >  drivers/iio/accel/adxl345_spi.c | 12 +++++++++++-
> > > >  2 files changed, 13 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl34=
5.h
> > > > index 4ea9341d4..e6bc3591c 100644
> > > > --- a/drivers/iio/accel/adxl345.h
> > > > +++ b/drivers/iio/accel/adxl345.h
> > > > @@ -30,6 +30,8 @@
> > > >  #define ADXL345_POWER_CTL_MEASURE    BIT(3)
> > > >  #define ADXL345_POWER_CTL_STANDBY    0x00
> > > >
> > > > +#define ADXL345_DATA_FORMAT_SPI_3WIRE        BIT(6) /* 3-wire SPI =
mode */
> > > > +
> > > >  #define ADXL345_DATA_FORMAT_RANGE    GENMASK(1, 0) /* Set the g ra=
nge */
> > > >  #define ADXL345_DATA_FORMAT_JUSTIFY  BIT(2) /* Left-justified (MSB=
) mode */
> > > >  #define ADXL345_DATA_FORMAT_FULL_RES BIT(3) /* Up to 13-bits resol=
ution */
> > > > diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/ad=
xl345_spi.c
> > > > index 1c0513bd3..f145d5c1d 100644
> > > > --- a/drivers/iio/accel/adxl345_spi.c
> > > > +++ b/drivers/iio/accel/adxl345_spi.c
> > > > @@ -20,6 +20,16 @@ static const struct regmap_config adxl345_spi_re=
gmap_config =3D {
> > > >       .read_flag_mask =3D BIT(7) | BIT(6),
> > > >  };
> > > >
> > > > +static int adxl345_spi_setup(struct device *dev, struct regmap *re=
gmap)
> > > > +{
> > > > +     struct spi_device *spi =3D container_of(dev, struct spi_devic=
e, dev);
> > > > +
> > > > +     if (spi->mode & SPI_3WIRE)
> > > > +             return regmap_write(regmap, ADXL345_REG_DATA_FORMAT,
> > > > +                                 ADXL345_DATA_FORMAT_SPI_3WIRE);
> > > Your earlier patch carefully (I think) left one or two fields alone, =
then
> > > this write just comes in and changes them. In particular INT_INVERT.
> > >
> > Why do you refer here to INT_INVERT? In this code above I try to set
> > SPI to 3 lines. Since this is a SPI configuration, i.e. bus specific,
> > it happens in adxl345_spi.c. Passing this function to the bus
> > independent adxl345_core.c file allows to configure the bus first.
> > Therefore, I'm using the update function in core masking out the SPI
> > filag.
>
> Ah. Ok.  It was only intended to mask out the SPI3-wire bit, not the
> other bits that you also masked out.  I thought intent was to leave
> them untouched for some reason.  Given they don't matter in the driver
> at the moment (no interrupt support) then no problem.
>
> >
> > My reason why I try to keep INT_INVERT out is different. There is
> > another driver for the same part in the kernel:
> > ./drivers/input/misc/adxl34x.c - This is a input driver, using the
> > interrupts of the adxl345 for the input device implementation. I
> > assumed, that in the iio implementation there won't be interrupt
> > handling for the adx345, since it is not an input device. Does this
> > make sense?
>
> No. You can't use these two drivers at the same time.  They will almost
> certainly trample over each other in actually reading channels etc.
>
> Their is some legacy of old drivers in input from a long time back.
> Given this driver clearly doesn't have full functionality yet in IIO ther=
e
> and the different userspace ABI, we've just left the input driver alone.
>
Going by the git history gave this impression, too. But it was still a
bit confusing to me.

The IIO driver so far does not handle any of the interrupt features.
The older driver also seems to support more of the chip's features.
Would it make sense to continue implement/port what's missing -
feature by feature - for the IIO driver in order to make the input
driver obsolete (one day)?

> >
> > > If it doesn't makes sense to write it there, either write that bit
> > > every time here, or leave it alone every time.  Not decide on whether
> > > to write the bit based on SPI_3WIRE or not.  As far as I know they
> > > are unconnected features.
> > >
> > I think I did not understand. Could you please specify a bit more?
> > When spi-3wire is configured in the DT it has to be parsed and handled
> > in the bus specific part, i.e. the adxl345_spi.c Therefore I configure
> > SPI_3WIRE there. I don't want to place SPI specific code in the core
> > file.
>
> My confusion was that you were deliberately not touching the other unused
> flags.  In reality you are touching the but only if you enable 3wire.
> I would write them register to 0 in the !3wire case so all other values
> are the same in both paths.
>
> >
> > > > +     return 0;
> > > > +}
> > > > +
> > > >  static int adxl345_spi_probe(struct spi_device *spi)
> > > >  {
> > > >       struct regmap *regmap;
> > > > @@ -33,7 +43,7 @@ static int adxl345_spi_probe(struct spi_device *s=
pi)
> > > >       if (IS_ERR(regmap))
> > > >               return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Err=
or initializing regmap\n");
> > > >
> > > > -     return adxl345_core_probe(&spi->dev, regmap, NULL);
> > > > +     return adxl345_core_probe(&spi->dev, regmap, adxl345_spi_setu=
p);
> > > >  }
> > > >
> > > >  static const struct adxl345_chip_info adxl345_spi_info =3D {
> > >
>

