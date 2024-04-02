Return-Path: <linux-kernel+bounces-127700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6949F894FAA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ADC01C20D0F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05EE5A4CF;
	Tue,  2 Apr 2024 10:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4jH8k2u"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172DC59151;
	Tue,  2 Apr 2024 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052742; cv=none; b=LKtWaZaQuPaqBmCbLPwe+C70uB3ncAS6wq4AbHVX53O9sO7dNcpZMF0F6s4kcUmdyqGz0nUmTSzrGWFdu3Mlz9ABB9WM31TKiRvAlD4qNRhFfBbHyVxkG7OotctqeiuxKNk8cvGCw9hy1wVRYJRGwwXjtNmlx/TSiAWb4zlGs1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052742; c=relaxed/simple;
	bh=mKSFc6n/JiYsinC/ofRpA2VZGHdbV2ldjiX/sYtEI6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cbcNHah6KQvze9XR8r97YdqNWR/oKDJJcGYjAl4bK/hh2//BYDKdRAlsuVah76DSqLPdf2bVrxzIf38N2iHZQMPpGOqJZfUZy51pm4BkI6uIA0c3Y4TexYId3SkicYgDNx8V/l5yiu1274e20+E6N779Z30dFdxkyg2H3zslD4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4jH8k2u; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61448d00c59so24843337b3.0;
        Tue, 02 Apr 2024 03:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712052740; x=1712657540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCfPr7OgZf9uP49di2tEZcJnki5yiPQqsVQPfZqM+9U=;
        b=l4jH8k2ubD0aSTklWyoD4Cru/MrxP/TLKDl7pMYb2VrVJikDbwu8XAmDWUxWZOCcPp
         Z6+1awwsEfCgODeItWwoeSMrwWDnduTIQ/H61g37OMY3dIZiGtttChVO2lLpD7l3weCe
         7kitRF/T/TwZwm/VUlvJ4jJ6FnLPbIUhtkWpLy+NL6Q+iX2/AhXv++QylLHLUhBhS3N5
         GaXzNlozDZLBS+JHKQQRk/zPGSXPS3dsWFyey3cw9D21vLh/uRuq5LhgSUxQdWTBrUTp
         uw9cWKLr1s1YN0qBPDQBm251pEvMt+y+/d8Nur3gHln+yzLigqpj2nQLHEKx7E5mSU9y
         QzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712052740; x=1712657540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCfPr7OgZf9uP49di2tEZcJnki5yiPQqsVQPfZqM+9U=;
        b=AZjx86v5z6k12zhevJH0hKcTBThCehNlBH3bz1njXJw7Su87Sc6RS/CI1UFy0mYHTz
         GIXdxHCEQV9iev6lYOilGAmaR2zVO3ucObc3SWPkSRvePOy/zIAG7X11mV5M3Via1I4L
         fXPI9iM8dxIpkhOv31wuPzRguG6G80wkLC273lvB1A2CQ6HBLXxIa5UkA1+WbC0QhKO9
         xGe7IeeNVDqf5KfVmVQNBXcxSntYHlvSAG6jU/cWfBa6B9nHlKk92vHMUdkQAV+4JTEE
         LhOiKqM2n3vGoA/Vujl5hUgoZhBJmUWRL0P3PlSHWWy/x+D7NLjRLNQ6phkGr5TIflx1
         5rUA==
X-Forwarded-Encrypted: i=1; AJvYcCV8vnmsaWivX/up6kvyeLhScwPBJnE4XRYQMxC+4L8k0kvA55G1PDiPhcxhDFiaZfujXAhQNu2ZAypgUosjfTGbxXGqUYgjwB9XaCsbRhMPWJdM7khP5+LpazeREL16deKF2v8ESUSQXGjcTrN5dvUxshLyijBvLzLvBVsfKrBTO2gBtQ==
X-Gm-Message-State: AOJu0Yy13htc+twx5cRuKvCiU62rZb1bSLSxDFujnEsGPy/rMTYAaXyE
	i2adenhiPnkySEGxUanH3dOW6qOYnHaCZoHpIFPr/Uk2Px5vZtxIfgzx4H4Tnj3Msih8XjDssOr
	GBkf+VgpDfr+uGy9LagEyLiehoZ8=
X-Google-Smtp-Source: AGHT+IHWWxw3EVJaMYd5HLS/1c+ZJLxr4KXYPYqy+h3D86Y/l2858g2V7nbugjK26BSWwmS7BGwKM74d+/kKuwjE5BE=
X-Received: by 2002:a25:d0d7:0:b0:dcc:efa2:93fb with SMTP id
 h206-20020a25d0d7000000b00dccefa293fbmr10688485ybg.45.1712052739884; Tue, 02
 Apr 2024 03:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327220320.15509-1-l.rubusch@gmail.com> <20240327220320.15509-8-l.rubusch@gmail.com>
 <20240328133927.7e49f3bf@jic23-huawei> <CAFXKEHZva5AE=sinx_i0Gec2FbB4ZfyEu8mWg52omzGBvr5uXw@mail.gmail.com>
 <20240330152401.034aedad@jic23-huawei> <CAFXKEHZJZU69udvM86rDSNU1J9o=v62BJcJfTrB=Y9Tgsjm4fw@mail.gmail.com>
 <20240401175304.000022ed@Huawei.com>
In-Reply-To: <20240401175304.000022ed@Huawei.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 2 Apr 2024 12:11:43 +0200
Message-ID: <CAFXKEHYrqA2iaQJeMqPbQJYEu10xiRt92c-ySGcfH76MSriufw@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] iio: accel: adxl345: Add spi-3wire option
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de, Michael.Hennerich@analog.com, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 6:53=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 1 Apr 2024 18:06:24 +0200
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > On Sat, Mar 30, 2024 at 4:24=E2=80=AFPM Jonathan Cameron <jic23@kernel.=
org> wrote:
> > >
> > > On Fri, 29 Mar 2024 01:33:01 +0100
> > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > >
> > > > On Thu, Mar 28, 2024 at 2:39=E2=80=AFPM Jonathan Cameron <jic23@ker=
nel.org> wrote:
> > > > >
> > > > > On Wed, 27 Mar 2024 22:03:20 +0000
> > > > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > > > >
> > > > > > Add a setup function implementation to the spi module to enable=
 spi-3wire
> > > > > > as option when specified in the device-tree.
> > > > > >
> > > > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > > > > ---
> > > > > >  drivers/iio/accel/adxl345.h     |  2 ++
> > > > > >  drivers/iio/accel/adxl345_spi.c | 12 +++++++++++-
> > > > > >  2 files changed, 13 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/ad=
xl345.h
> > > > > > index 4ea9341d4..e6bc3591c 100644
> > > > > > --- a/drivers/iio/accel/adxl345.h
> > > > > > +++ b/drivers/iio/accel/adxl345.h
> > > > > > @@ -30,6 +30,8 @@
> > > > > >  #define ADXL345_POWER_CTL_MEASURE    BIT(3)
> > > > > >  #define ADXL345_POWER_CTL_STANDBY    0x00
> > > > > >
> > > > > > +#define ADXL345_DATA_FORMAT_SPI_3WIRE        BIT(6) /* 3-wire =
SPI mode */
> > > > > > +
> > > > > >  #define ADXL345_DATA_FORMAT_RANGE    GENMASK(1, 0) /* Set the =
g range */
> > > > > >  #define ADXL345_DATA_FORMAT_JUSTIFY  BIT(2) /* Left-justified =
(MSB) mode */
> > > > > >  #define ADXL345_DATA_FORMAT_FULL_RES BIT(3) /* Up to 13-bits r=
esolution */
> > > > > > diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/acce=
l/adxl345_spi.c
> > > > > > index 1c0513bd3..f145d5c1d 100644
> > > > > > --- a/drivers/iio/accel/adxl345_spi.c
> > > > > > +++ b/drivers/iio/accel/adxl345_spi.c
> > > > > > @@ -20,6 +20,16 @@ static const struct regmap_config adxl345_sp=
i_regmap_config =3D {
> > > > > >       .read_flag_mask =3D BIT(7) | BIT(6),
> > > > > >  };
> > > > > >
> > > > > > +static int adxl345_spi_setup(struct device *dev, struct regmap=
 *regmap)
> > > > > > +{
> > > > > > +     struct spi_device *spi =3D container_of(dev, struct spi_d=
evice, dev);
> > > > > > +
> > > > > > +     if (spi->mode & SPI_3WIRE)
> > > > > > +             return regmap_write(regmap, ADXL345_REG_DATA_FORM=
AT,
> > > > > > +                                 ADXL345_DATA_FORMAT_SPI_3WIRE=
);
> > > > > Your earlier patch carefully (I think) left one or two fields alo=
ne, then
> > > > > this write just comes in and changes them. In particular INT_INVE=
RT.
> > > > >
> > > > Why do you refer here to INT_INVERT? In this code above I try to se=
t
> > > > SPI to 3 lines. Since this is a SPI configuration, i.e. bus specifi=
c,
> > > > it happens in adxl345_spi.c. Passing this function to the bus
> > > > independent adxl345_core.c file allows to configure the bus first.
> > > > Therefore, I'm using the update function in core masking out the SP=
I
> > > > filag.
> > >
> > > Ah. Ok.  It was only intended to mask out the SPI3-wire bit, not the
> > > other bits that you also masked out.  I thought intent was to leave
> > > them untouched for some reason.  Given they don't matter in the drive=
r
> > > at the moment (no interrupt support) then no problem.
> > >
> > > >
> > > > My reason why I try to keep INT_INVERT out is different. There is
> > > > another driver for the same part in the kernel:
> > > > ./drivers/input/misc/adxl34x.c - This is a input driver, using the
> > > > interrupts of the adxl345 for the input device implementation. I
> > > > assumed, that in the iio implementation there won't be interrupt
> > > > handling for the adx345, since it is not an input device. Does this
> > > > make sense?
> > >
> > > No. You can't use these two drivers at the same time.  They will almo=
st
> > > certainly trample over each other in actually reading channels etc.
> > >
> > > Their is some legacy of old drivers in input from a long time back.
> > > Given this driver clearly doesn't have full functionality yet in IIO =
there
> > > and the different userspace ABI, we've just left the input driver alo=
ne.
> > >
> > Going by the git history gave this impression, too. But it was still a
> > bit confusing to me.
> >
> > The IIO driver so far does not handle any of the interrupt features.
> > The older driver also seems to support more of the chip's features.
> > Would it make sense to continue implement/port what's missing -
> > feature by feature - for the IIO driver in order to make the input
> > driver obsolete (one day)?
>
> Yes, though it will be challenging because of the ABI differences.
> We do have a few cross subsystem bridge drivers, but the few goes we've
> had at an accel bridge driver haven't made it into the kernel.  In partic=
ular
> we don't have an in kernel interface for threshold events and similar in =
IIO.
> It would be easy enough to add one, but no one has ever cared enough to
> do the work. :(
>
Perhaps there are easier things (precision, power saving measures,
etc) of that particular accelerometer to port first. Open issues which
even I could give a try here. Sounds really exciting to me, though,
but before I definitely need a bit more experience with community and
APIs.

What do you mean with cross subsystem bridge drivers, or this accel
bridge driver? I mean, can you provide me with a link to that driver
to have a look into what direction that is going to?

Anyway, I really appreciate already your patience with my patches, the
direct and helpful answers! I appreciate the support. Thinking and
re-thinking over every particular line of code is really an
experience. I don't want to go too much into off-topic discussions
here, if this is not the forum for that, please let me know :)

> Jonathan
>
>
> >
> > > >
> > > > > If it doesn't makes sense to write it there, either write that bi=
t
> > > > > every time here, or leave it alone every time.  Not decide on whe=
ther
> > > > > to write the bit based on SPI_3WIRE or not.  As far as I know the=
y
> > > > > are unconnected features.
> > > > >
> > > > I think I did not understand. Could you please specify a bit more?
> > > > When spi-3wire is configured in the DT it has to be parsed and hand=
led
> > > > in the bus specific part, i.e. the adxl345_spi.c Therefore I config=
ure
> > > > SPI_3WIRE there. I don't want to place SPI specific code in the cor=
e
> > > > file.
> > >
> > > My confusion was that you were deliberately not touching the other un=
used
> > > flags.  In reality you are touching the but only if you enable 3wire.
> > > I would write them register to 0 in the !3wire case so all other valu=
es
> > > are the same in both paths.
> > >
> > > >
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +
> > > > > >  static int adxl345_spi_probe(struct spi_device *spi)
> > > > > >  {
> > > > > >       struct regmap *regmap;
> > > > > > @@ -33,7 +43,7 @@ static int adxl345_spi_probe(struct spi_devic=
e *spi)
> > > > > >       if (IS_ERR(regmap))
> > > > > >               return dev_err_probe(&spi->dev, PTR_ERR(regmap), =
"Error initializing regmap\n");
> > > > > >
> > > > > > -     return adxl345_core_probe(&spi->dev, regmap, NULL);
> > > > > > +     return adxl345_core_probe(&spi->dev, regmap, adxl345_spi_=
setup);
> > > > > >  }
> > > > > >
> > > > > >  static const struct adxl345_chip_info adxl345_spi_info =3D {
> > > > >
> > >
> >
>

