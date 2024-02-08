Return-Path: <linux-kernel+bounces-57594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD3B84DB27
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7541F23701
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CB36A03A;
	Thu,  8 Feb 2024 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5Zn16f5"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E23767C71;
	Thu,  8 Feb 2024 08:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380067; cv=none; b=JVMSBf+dNHiUnu5w1dfzFqiB4sE9dNkVAO+sCKGmSV92d0b7l64N526RhPJ7TNNF/ZwoYYVymSIzDp7EO9GjuXxhLo+tdAxDqklBMUpOipQHeiTPBR+SY/oTQN4TGwMikRFytUKxhgTNRP2KrMxhzUjYKJbV3hdI5aiks4aMDRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380067; c=relaxed/simple;
	bh=62o2dBZHbqAMq32akAHix/p1/u6r4qC1zGY/vGD8laQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hy60jBLgXr4Wc2/wqgMX+Hhkpwt1z1KJlQQCVMh2a6tYqfoxex1t54PnFMNxpQ3JMr9N/NWhKHGTJBZyzldoVOLsq3My2Gl8d8Ena0auP9XxAY2uZSIYVw8QllS3ercj/jTt2rOXSN9jxjOam7fhqvhe0M9/FnbJwP4JcGoXlFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5Zn16f5; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a38291dbe65so176192666b.3;
        Thu, 08 Feb 2024 00:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707380064; x=1707984864; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=62o2dBZHbqAMq32akAHix/p1/u6r4qC1zGY/vGD8laQ=;
        b=h5Zn16f5xKvHJuUC22LwU2OUygNauG1mob/XnJlbuOwLgdyI6rqMI3/G8rYW+0Fe1K
         67z9z35uuwjJQThmZHzlworSWoLRTqgGH1OS/rvWvY3o2h70/YNaVw3RYoDQzvq4o7IS
         W6iWFOaDDdSw1KFeLh+b7TuSMF7nppVhcEbXmCPfuvWBrA52FsC1NxL5Yz+tFQYca+J9
         5/Iwjs/wcGPZoGun274M1Bwf0okppg7piBqPXxT/sXMaeknmtva6CEqNXInZy44vqGPR
         8hKLMFPH3vQYuGjnJ7Myzd9bX6u2SEYd9nfTAEj38Dilho+//FBaANgQXhiD7h0sw5Cr
         PXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707380064; x=1707984864;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=62o2dBZHbqAMq32akAHix/p1/u6r4qC1zGY/vGD8laQ=;
        b=KQIAw3WdpZxDRyo982arX7OCUoX5TS/C29ry3ziDk9DtBMhhrX5aFgZeS6JkYOazaT
         w8GwfceJpxKM+e/QZkPyjHFAWzGiNoAWJUKiP3ZCPWN7h6WYjCvNPPiIEIIKwxx+lJAl
         ylSARxzmsssWW88Xt5w60wdWZrpBEo3+gi6oBML3QgRbRFciezN9N0m4LKc1JHVL4N7v
         bM+0Ed9VsrdT9ycss7fXKyJ4zQbsu8g+V8cB0aJlakjMVmTnaEhylaR2z7OCzpVEqPlC
         kqzUfLZm6LNysa2XY0silE1Wy+x1M9IYcEQG5qgyjM5Co+7tmhmqoGYFgt/zg0QaQu5N
         TuyA==
X-Forwarded-Encrypted: i=1; AJvYcCUmopKRodrUmLVt8hjpzp0JuLp9uUMZ3ZPWGlo3b4Lb9AZdppAZC89tuf3NjK8pnxEurSnaF4iIcLcO+iYPm9uNYfjxeGInPT8ToSXXC6AX77jReNDhPoUhnB3YKd95TD7z19B8Dq4NRQ==
X-Gm-Message-State: AOJu0YzJEkGeE53W9/KJnwj59DJ3tkV3kJKmx2BJeuX6NEZRA4Oh4doP
	Ffa8tQKPM3NdEBd6gmGdjPSWHnarqbBcmb/jMhgZb/+LexP74bwR
X-Google-Smtp-Source: AGHT+IHPMF4HSoxEOvmq+3Rc2AG/MsbXnj2te2mgb4OUmjDCRQP/vQiXQeGpbfJyd3XCbcBjCEfsrA==
X-Received: by 2002:a17:906:2818:b0:a36:f314:d8be with SMTP id r24-20020a170906281800b00a36f314d8bemr5884785ejc.38.1707380063620;
        Thu, 08 Feb 2024 00:14:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWnuiOoR6c1CDu5qrjnN9LAM5AijxWb56rss2a81Aam8eAtV+QBVRHWmE3odZ56V2NO3TfH4UfiIV122g5tRH+RGjZBcKPGaR+d2JeHIdrUX1mMluvSu27peDQ8XXKP7Cxjsme3pjI74qO+rMTwdSBFmNYFzJ/k3LbGJw9eIJ/5xUhaxS/AlRvLcqibo0z3GijdApS28Y4Q5GPNsgSzsQ2bnGAHu4L26tP0rICvGP3Sny7IUAv79FMW6DdMFv9dFVKdfsoSkr6W5ZPHDcy4zYrVaxoBXlXoqoXot7U01ZuuFkKN65gIUThmgvSXXo+gfIUX1gQ8RGt/kEXWUn/R4Ts2xLkd1lYiQoFNyFQW2f0KJXU3tBx9vYBNx5XH9EqpYpa
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id lj24-20020a170906f9d800b00a38599ba2d1sm1630443ejb.118.2024.02.08.00.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 00:14:23 -0800 (PST)
Message-ID: <06a2a5618058909df52b685f461e668b259ff42a.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad7944: add driver for
 AD7944/AD7985/AD7986
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>,  Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Feb 2024 09:17:42 +0100
In-Reply-To: <CAMknhBHP40uXtviZ1KCQ3ZyruaLUVrjpp573u7QqMCT1tuoYjw@mail.gmail.com>
References: <20240206-ad7944-mainline-v1-0-bf115fa9474f@baylibre.com>
	 <20240206-ad7944-mainline-v1-2-bf115fa9474f@baylibre.com>
	 <5fd17b66eab1989b9cfb874445c18480a2282809.camel@gmail.com>
	 <CAMknhBHP40uXtviZ1KCQ3ZyruaLUVrjpp573u7QqMCT1tuoYjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-07 at 08:19 -0600, David Lechner wrote:
> On Wed, Feb 7, 2024 at 4:07=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.co=
m> wrote:
> >=20
> > Hi David,
> >=20
> > The driver It's in pretty good shape... Just some comments from me
> >=20
> > On Tue, 2024-02-06 at 11:26 -0600, David Lechner wrote:
> > > This adds a driver for the Analog Devices Inc. AD7944, AD7985, and
> > > AD7986 ADCs. These are a family of pin-compatible ADCs that can sampl=
e
> > > at rates up to 2.5 MSPS.
> > >=20
> > > The initial driver adds support for sampling at lower rates using the
> > > usual IIO triggered buffer and can handle all 3 possible reference
> > > voltage configurations.
> > >=20
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > ---
> > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0 10 ++
> > > =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0 1 +
> > > =C2=A0drivers/iio/adc/ad7944.c | 397
> > > +++++++++++++++++++++++++++++++++++++++++++++++
> > > =C2=A04 files changed, 409 insertions(+)
> > >=20
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 4f1e658e1e0d..83d8367595f1 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -458,6 +458,7 @@ R:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Davi=
d Lechner <dlechner@baylibre.com>
> > > =C2=A0S:=C2=A0=C2=A0 Supported
> > > =C2=A0W:=C2=A0=C2=A0 https://ez.analog.com/linux-software-drivers
> > > =C2=A0F:=C2=A0=C2=A0 Documentation/devicetree/bindings/iio/adc/adi,ad=
7944.yaml
> > > +F:=C2=A0=C2=A0 drivers/iio/adc/ad7944.c
> > >=20
> > > =C2=A0ADAFRUIT MINI I2C GAMEPAD
> > > =C2=A0M:=C2=A0=C2=A0 Anshul Dalal <anshulusr@gmail.com>
> > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > index 59ae1d17b50d..93fbe6f8e306 100644
> > > --- a/drivers/iio/adc/Kconfig
> > > +++ b/drivers/iio/adc/Kconfig
> > > @@ -280,6 +280,16 @@ config AD7923
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To compile this driver as =
a module, choose M here: the
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 module will be called ad79=
23.
> > >=20
> > > +config AD7944
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 tristate "Analog Devices AD7944 and similar=
 ADCs driver"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 depends on SPI
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 help
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Say yes here to build support f=
or Analog Devices
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD7944, AD7985, AD7986 ADCs.
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To compile this driver as a mod=
ule, choose M here: the
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 module will be called ad7944
> > > +
> > > =C2=A0config AD7949
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "Analog Devices AD7949 and si=
milar ADCs driver"
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on SPI
> > > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > > index 5a26ab6f1109..52d803b92cd7 100644
> > > --- a/drivers/iio/adc/Makefile
> > > +++ b/drivers/iio/adc/Makefile
> > > @@ -29,6 +29,7 @@ obj-$(CONFIG_AD7780) +=3D ad7780.o
> > > =C2=A0obj-$(CONFIG_AD7791) +=3D ad7791.o
> > > =C2=A0obj-$(CONFIG_AD7793) +=3D ad7793.o
> > > =C2=A0obj-$(CONFIG_AD7887) +=3D ad7887.o
> > > +obj-$(CONFIG_AD7944) +=3D ad7944.o
> > > =C2=A0obj-$(CONFIG_AD7949) +=3D ad7949.o
> > > =C2=A0obj-$(CONFIG_AD799X) +=3D ad799x.o
> > > =C2=A0obj-$(CONFIG_AD9467) +=3D ad9467.o
> > > diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
> > > new file mode 100644
> > > index 000000000000..67b525fb8e59
> > > --- /dev/null
> > > +++ b/drivers/iio/adc/ad7944.c
> > > @@ -0,0 +1,397 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Analog Devices AD7944/85/86 PulSAR ADC family driver.
> > > + *
> > > + * Copyright 2024 Analog Devices, Inc.
> > > + * Copyright 2024 Baylibre, SAS
> > > + */
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/bitops.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/device.h>
> > > +#include <linux/err.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/module.h>
> > > +#include <linux/property.h>
> > > +#include <linux/regulator/consumer.h>
> > > +#include <linux/spi/spi.h>
> > > +
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/iio/sysfs.h>
> > > +#include <linux/iio/trigger_consumer.h>
> > > +#include <linux/iio/triggered_buffer.h>
> > > +
> > > +#define AD7944_INTERNAL_REF_MV=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4096
> > > +
> > > +struct ad7944_timing_spec {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 /* Normal mode minimum CNV pulse width in n=
anoseconds. */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int cnv_ns;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 /* TURBO mode minimum CNV pulse width in na=
noseconds. */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int turbo_cnv_ns;
> > > +};
> > > +
> > >=20
> >=20
> > ...
> >=20
> > > +}
> > > +
> > > +static int ad7944_single_conversion(struct ad7944_adc *adc,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_s=
pec *chan,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *val)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ad7944_4_wire_mode_conversion(adc, =
chan);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (chan->scan_type.storagebits > 16)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 *val =3D adc->sample.raw.u32;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 else
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 *val =3D adc->sample.raw.u16;
> > > +
> >=20
> > Will this work both in big vs little endian archs? I don't think so but
> > maybe
> > I'm missing something. At a first glance, it seems we get big endian fr=
om
> > spi so
> > shouldn't we have __be16 and __be32?
>=20
> Yes, in Linux SPI words are always CPU-endian. It is the drivers that
> use 8-bit transfers to read 16 bits that need to handle big-endian
> swapping. But here we are using 14/16/18 bit transfers.
>=20

Right...

> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (chan->scan_type.sign =3D=3D 's')
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 *val =3D sign_extend32(*val, chan->scan_type.realbits - 1);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return IIO_VAL_INT;
> > > +}
> > > +
> > > +static int ad7944_read_raw(struct iio_dev *indio_dev,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
nst struct iio_chan_spec *chan,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
t *val, int *val2, long info)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct ad7944_adc *adc =3D iio_priv(indio_d=
ev);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 switch (info) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_RAW:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret =3D iio_device_claim_direct_mode(indio_dev);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > > +
> >=20
> > I'm not totally sure but I think Jonathan already merged his series for=
 the
> > cleanup stuff for the claim direct mode. Maybe take a look and use it? =
Not a
> > big
> > win in here but I guess we could still reduce some LOC.
>=20
> Yes, if it is merged already, happy to make use of it here.
>=20
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret =3D ad7944_single_conversion(adc, chan, val);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 iio_device_release_direct_mode(indio_dev);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_SCALE:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 switch (chan->type) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 case IIO_VOLTAGE:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val =3D adc->ref_mv=
;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val2 =3D chan->scan=
_type.realbits;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return IIO_VAL_FRACT=
IONAL_LOG2;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 default:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 default:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -EINVAL;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +}
> > > +
> > > +static const struct iio_info ad7944_iio_info =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 .read_raw =3D &ad7944_read_raw,
> > > +};
> > > +
> > > +static irqreturn_t ad7944_trigger_handler(int irq, void *p)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_poll_func *pf =3D p;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev =3D pf->indio_dev=
;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct ad7944_adc *adc =3D iio_priv(indio_d=
ev);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ad7944_4_wire_mode_conversion(adc, =
&indio_dev->channels[0]);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto out;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 iio_push_to_buffers_with_timestamp(indio_de=
v, &adc->sample.raw,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 indio_dev->scan_timestamp);
> > > +
> > > +out:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 iio_trigger_notify_done(indio_dev->trig);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return IRQ_HANDLED;
> > > +}
> > > +
> > > +static const char * const ad7944_power_supplies[] =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 "avdd", "dvdd", "bvdd", "vio"
> > > +};
> > > +
> > > +static void ad7944_ref_disable(void *ref)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disable(ref);
> > > +}
> > > +
> > > +static int ad7944_probe(struct spi_device *spi)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 const struct ad7944_chip_info *chip_info;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct ad7944_adc *adc;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct regulator *ref;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 const char *str_val;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 /* adi,spi-mode property defaults to "4-wir=
e" if not present */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (device_property_read_string(&spi->dev, =
"adi,spi-mode", &str_val)
> > > < 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 str_val =3D "4-wire";
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (strcmp(str_val, "4-wire"))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return dev_err_probe(&spi->dev, -EINVAL,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "only \"4-wire\" =
mode is currently
> > > supported\n");
> >=20
> > Did you looked at spi core? I guess the chain mode is not available but=
 IIRC
> > spi
> > already has spi-3wire. So maybe you could just have a boolean property =
for
> > the
> > chain mode and check both that and 3wire?
>=20
> I used the term "3-wire" because that is what the datasheet calls it,
> but it is not the same as what the SPI core calls SPI_3WIRE. The
> former is described in the DT bindings patch in this series and the
> latter means that SDI and SDO are on the same pin, which is not the
> case here.
>=20

Oh, I see... I could have looked at the bindings.

- Nuno S=C3=A1
>=20


