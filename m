Return-Path: <linux-kernel+bounces-126819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E950C893D09
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DBC6B20ED2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6264778C;
	Mon,  1 Apr 2024 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7qHEaK3"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24387446B6;
	Mon,  1 Apr 2024 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711986301; cv=none; b=dRmunztnkr1vaSO8IYOqMjhfupDLCvEHsgy7qtmFtKn1YeH/Mx76MMUAEAs0bk6bBzXf9gGdARSDp+fctlg1vfsBubf6SVmVinuT/JXvwo1y3SNETEobwx79SMCLElgfyigPJMkANiUHeQDNYxxLjjZVypu5Vi5LlGlUoHbq0Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711986301; c=relaxed/simple;
	bh=TVnIiBfRuXf05cZDygK1TzpZFyCzKg6s72f2ZYhxfc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oihYcAZBRSfBUmzz13wghkP/jc4pidIrSHE7yi3dFH8VJBLFroYNTc7KPLHyUlbTNSfz2NsBDg3O7/TGC/i6lwlfcH+GEtoiXQI9ey6HQOkGhsCbrIznRTub2YD0lguYy7559BbvKUojMcQfPyhJzkcZcPV+yg0SNxN/kdYeYpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7qHEaK3; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso3668856276.0;
        Mon, 01 Apr 2024 08:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711986299; x=1712591099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdxtEUD5/kUujQDK5LhJx6OZiX2ZQBhA3d2uRGfJTdk=;
        b=A7qHEaK39eaLOa7BlUNYKagDFnCnr1iVCNt+Mj9LtG8PiA3Ig9oSNuE9xremX5X/Oc
         Iotr2RpnkkGpsi06c6GCN683D1utLWioaPJ73kG529BEYD2FfiR9WO9wq3ZXU6wfOLEn
         So4xoeD4sYD0NfYcDGO1QIMDIQxnAyPMbqV4D+IStd989i98b+s/uo9QVI9TW1WyDaL+
         jtud4WIlmZwr1D7JXLkhLCwghQ2xKcv7gDr8J5CB7BcCylXs9dgNzvv/at0ybvon4VR8
         PrBM1ThtYxNbUO0kjOMiJWCDBI5vzsmmIzJeDXAaUNdeIBLRoJoXdGkTEtWMiL9P9P6H
         hwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711986299; x=1712591099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdxtEUD5/kUujQDK5LhJx6OZiX2ZQBhA3d2uRGfJTdk=;
        b=dvvcbfyMuFTVuaos/f1E90xCFAjsR61LLb0alUFLQBnK0qlzOy1+FVxINYdXuJBjRp
         7aYYOn1JK6rOhlfhlBfIqjXTxO7YK1Nx+3LOky/10sE3NQBKDEhz2B4sQ+3P2L3PICzc
         aZkSZUPBnWf2JJEp3z/bzrtJ1P0FleBa6Q+4/NCQmAhdZMS0fUtb5hcK0SEbJKkwB7vX
         mqzTsOW0R4aGWWwbNDs1VzDm2/yV46BC9gsZXo28ERNtmws0oxtq+sRvFmhTdpj4oJZ+
         P2QQcgkzCWfUEJtr/e/Hjer+Evq5+XsFcXorHehalPRAGRm0gFZgMBEBX7bGDeyWaYs8
         S4Yg==
X-Forwarded-Encrypted: i=1; AJvYcCW6Z9RMovFf8GoVtBbNSku8tdPg8LpsIMYFmGor5r0rx3E2bsozUYJnnUN6HpyiQVwZJZ2NkAKOiHFuHBTRlSgSQ+jVwqsigUxXctP12vfLq8Wv7S19qmSuqEzvkHVeGOZ13PJGs4fjB6Fnc54G0Bn8vAHQ5pjl7EGjhZr0HfRQ4K+b1w==
X-Gm-Message-State: AOJu0Yz+6cCiXu/FVJFLL4LV+sQkoc6HZ8L4e6jwHcPPyfi5xN+rDgwr
	ot/aSCV70HoB5wCcsfszm5WotH2FVIY5uBofRabwQS4DQWK4b8ZvcStQbh66/gYctWinQULqnKt
	qiROHv+yXy9RK0dMAIaQbPirjURY=
X-Google-Smtp-Source: AGHT+IFGTDjX8gEXE22sNRba4623yiwylKLEw3CcqAQ1OrJbY5/YW3Aiwly72XzmsVtQLwUdxm3Go+zgnIjnNwBUFSg=
X-Received: by 2002:a25:9183:0:b0:dcc:8aaa:3ed3 with SMTP id
 w3-20020a259183000000b00dcc8aaa3ed3mr7391649ybl.16.1711986298958; Mon, 01 Apr
 2024 08:44:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329004030.16153-1-l.rubusch@gmail.com> <20240329004030.16153-8-l.rubusch@gmail.com>
 <20240330152949.7e10ebcc@jic23-huawei>
In-Reply-To: <20240330152949.7e10ebcc@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Mon, 1 Apr 2024 17:44:22 +0200
Message-ID: <CAFXKEHbM5kcSvfqHmfetzy8Gp_jOK0ZMbOjBK8USkNdxyNAT5w@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] iio: accel: adxl345: Add spi-3wire option
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 4:30=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 29 Mar 2024 00:40:30 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add a setup function implementation to the spi module to enable spi-3wi=
re
> > when specified in the device-tree.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  drivers/iio/accel/adxl345.h     |  1 +
> >  drivers/iio/accel/adxl345_spi.c | 12 +++++++++++-
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> > index e859c01d4..3d5c8719d 100644
> > --- a/drivers/iio/accel/adxl345.h
> > +++ b/drivers/iio/accel/adxl345.h
> > @@ -31,6 +31,7 @@
> >  #define ADXL345_DATA_FORMAT_RANGE    GENMASK(1, 0)   /* Set the g rang=
e */
> >  #define ADXL345_DATA_FORMAT_JUSTIFY  BIT(2)  /* Left-justified (MSB) m=
ode */
> >  #define ADXL345_DATA_FORMAT_FULL_RES BIT(3)  /* Up to 13-bits resoluti=
on */
> > +#define ADXL345_DATA_FORMAT_SPI_3WIRE        BIT(6)  /* 3-wire SPI mod=
e */
> >  #define ADXL345_DATA_FORMAT_SELF_TEST        BIT(7)  /* Enable a self =
test */
> >
> >  #define ADXL345_DATA_FORMAT_2G               0
> > diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl34=
5_spi.c
> > index 1c0513bd3..f145d5c1d 100644
> > --- a/drivers/iio/accel/adxl345_spi.c
> > +++ b/drivers/iio/accel/adxl345_spi.c
> > @@ -20,6 +20,16 @@ static const struct regmap_config adxl345_spi_regmap=
_config =3D {
> >       .read_flag_mask =3D BIT(7) | BIT(6),
> >  };
> >
> > +static int adxl345_spi_setup(struct device *dev, struct regmap *regmap=
)
> > +{
> > +     struct spi_device *spi =3D container_of(dev, struct spi_device, d=
ev);
> > +
> > +     if (spi->mode & SPI_3WIRE)
> > +             return regmap_write(regmap, ADXL345_REG_DATA_FORMAT,
> > +                                 ADXL345_DATA_FORMAT_SPI_3WIRE);
> My only remaining comment on this patch set is to add equivalent of
>         else
>                 return regmap_write(regmap, ADXL345_REG_DATA_FORMAT, 0);
>
> If the hardware had some sort of software reset, that was used,
> this wouldn't be needed as the status of those other bits would be known.
> If we leave them alone in the non 3wire path we may in the future have
> subtle issues because some other code left this in an odd state and
> we clear those other bits only for 3wire mode.
>

I see your point. Thinking over it, I came to the following: Given the
spi-3wire case, if I did a regmap_write(spi-3wire), else I did
regmap_write(0), in the i2c case I still passed NULL as setup()
function. So there would still be just a regmap_update() only in the
core module. Furthermore I see three cases: spi_setup() passed w/
3wire, spi_setu() passed w/o 3wire or NULL passed. This means there is
the same issue and more complexity. Hence, I will not do this. I think
I found something else.

What do you think about the following approach: If there is a
spi-3wire set in the device-tree, I pass the setup() function, else I
pass NULL. Then in the core module, if the setup() function is valid,
I do a regmap_update(), else the first option will be set with
regmap_write(). This makes up only two cases: setup() passed, or not -
and in either case the first call will be a regmap_write(). Thus all
bits are initialized to a defined state. I will update the patchset
later today, that you can see.

Happy Easter!
Lothar

> Jonathan
>
> > +     return 0;
> > +}
> > +
> >  static int adxl345_spi_probe(struct spi_device *spi)
> >  {
> >       struct regmap *regmap;
> > @@ -33,7 +43,7 @@ static int adxl345_spi_probe(struct spi_device *spi)
> >       if (IS_ERR(regmap))
> >               return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error i=
nitializing regmap\n");
> >
> > -     return adxl345_core_probe(&spi->dev, regmap, NULL);
> > +     return adxl345_core_probe(&spi->dev, regmap, adxl345_spi_setup);
> >  }
> >
> >  static const struct adxl345_chip_info adxl345_spi_info =3D {
>

