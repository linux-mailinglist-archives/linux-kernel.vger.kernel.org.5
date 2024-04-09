Return-Path: <linux-kernel+bounces-136158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1693789D0A1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E771C22381
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B9A548ED;
	Tue,  9 Apr 2024 03:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Uyi3ujr1"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134AC54743
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712631927; cv=none; b=UhQ7JluiBkHqeB99CN4R1WJpChyyDanPnOVnOUgyrA2LSJxzHWODh5WrbhzPOUUwyWUNdZusjBbprSELd/u/gaxwLak0Z0YrhT6Sg86PtM8kHax3LdtgdfdZXKSvefVl45hNhSSJmF/OWOeeByWD/lNOUlUn4bI8WkN6PBpiBr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712631927; c=relaxed/simple;
	bh=7p91e61qfqDSDFNlP2EtlFTpVZhxxiLUptMZeWzrghw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFQeTZIEVMmxzgqKtKO7bzfGY/5TIseI6t9luzQaIx+X8in+SE6P+L1IO+AYrcRSpaNspMM+a9OixP8KNnptavxjnA393bkQEmzTu2sULnOsbGyDGwA6HYhpZC+JjWQdeIvj2AOhvgMgp61651qK3bAfz8zRGAEZ2IdGcAFUlLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Uyi3ujr1; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d47ce662so6329588e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 20:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712631922; x=1713236722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drZwixEdVnnL7KdFdj4XI/MLI8C2dRSaWzVVBv9osco=;
        b=Uyi3ujr1esXFdQ4ENEC4i9ODT2noPwwpcgFNQ4n0O/DdQV5BPnBo8CF1ivs7UNE3az
         GRUnN4b5FKTBK226T45INF+ldVi3Nk0Qj4UvVlBCLgoCklFKlxwxV4SJFF/o2UfXsShg
         kTVgVNkXvmdwO4802G47BqIY3CxzjYYKXcznj7YtA2xKMYiCcmh3G5JBGFd+MnnUqXgk
         wpSCOkwgVJymUq7JxoAl0bA9kS04qkRiqHHpNGV+ozC595b2O+sCU5emBiLLd3HpVAca
         Poba8p+fyhLisaUj7GxEOGGpZBBS9p97x7UyZtMSy1U9ayH/LY3Qzh1KkyEII7TdwbJy
         kR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712631922; x=1713236722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drZwixEdVnnL7KdFdj4XI/MLI8C2dRSaWzVVBv9osco=;
        b=fGhlxDgpNnkUjXZL3IWZuWLfDgyDyxHfekb46rxBA9PLKpFpwkH7+xm4+gOiCqAoJo
         3XP4xMYlmYeIHfQuOqt59jTgVEr9TiVbzIOzQ3loGxoFXeDJoFkwFiJKIdGZwONbw1f/
         wteW1tWfzuEnWmILoxItLUzZvUHP0QHfNDvZWCxaC/ZY3+JWr12aFIMtCmNg/UsMs+/Q
         AILgr6ho/GtKgHhVPHdDv+1D1Wc96n+dhmmSG/QndlWHuO6JpEFcnBqLPCSIEMXj/1Fj
         dp68rpe88ogr36E7dtCvyMyKZyx9s/WMAzLeYtlFgi+4ej8rziBwbGBgyOHgksjYYXkw
         m4LA==
X-Forwarded-Encrypted: i=1; AJvYcCUuIq0qiO500XQtiAMtMjCNy/9OZxu1stR4XhmBS6gb0Syck2tz7xvWLNCwsIB5WQ/hIhbLK+WsGukHnBxUH4BSdL/p0eq3fuiio3Mi
X-Gm-Message-State: AOJu0Yx+qFuph8E3abz3LWsFVj8o22cW4KDUlbofWvzbA5+AinHsY39J
	E8juFA+13z3t0oXujWlkhIBplAsaGeuITqvnNZ473jFkHp5bmwg5IuT7FoR6Vhl8nCOzEl6PX9V
	n2JO6+AAvmp4ntn0TcinvCU7sDIxLvggf2MX/ZQ==
X-Google-Smtp-Source: AGHT+IEa1xg+BADqc47cnfmKUdZr7M2UsCF6uMN6pAyIDAKO7fmzFZRHBku0uJLWYgVwERBCoI0F9v5lw/8H1mZL2qs=
X-Received: by 2002:a2e:be11:0:b0:2d6:e148:2463 with SMTP id
 z17-20020a2ebe11000000b002d6e1482463mr11650236ljq.24.1712631922051; Mon, 08
 Apr 2024 20:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712585500.git.marcelo.schmitt@analog.com> <1d95d7d023dad69b894a2d0e7b0bad9d569ae382.1712585500.git.marcelo.schmitt@analog.com>
In-Reply-To: <1d95d7d023dad69b894a2d0e7b0bad9d569ae382.1712585500.git.marcelo.schmitt@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 8 Apr 2024 22:05:10 -0500
Message-ID: <CAMknhBEMDg3YF5pvoKJ-6y0Y5OJpmBthWfogCjy90B=F84SvzA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add support for AD4000
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 9:32=E2=80=AFAM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> Add support for AD4000 family of low noise, low power, high speed,
> successive aproximation register (SAR) ADCs.
>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  MAINTAINERS              |   1 +
>  drivers/iio/adc/Kconfig  |  12 +
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad4000.c | 649 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 663 insertions(+)
>  create mode 100644 drivers/iio/adc/ad4000.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5dfe118a5dd3..86aa96115f5a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1165,6 +1165,7 @@ L:        linux-iio@vger.kernel.org
>  S:     Supported
>  W:     https://ez.analog.com/linux-software-drivers
>  F:     Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> +F:     drivers/iio/adc/ad4000.c
>
>  ANALOG DEVICES INC AD4130 DRIVER
>  M:     Cosmin Tanislav <cosmin.tanislav@analog.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 8db68b80b391..9c9d13d4b74f 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -21,6 +21,18 @@ config AD_SIGMA_DELTA
>         select IIO_BUFFER
>         select IIO_TRIGGERED_BUFFER
>
> +config AD4000
> +       tristate "Analog Devices AD4000 ADC Driver"
> +       depends on SPI
> +       select IIO_BUFFER
> +       select IIO_TRIGGERED_BUFFER
> +       help
> +         Say yes here to build support for Analog Devices AD4000 high sp=
eed
> +         SPI analog to digital converters (ADC).
> +
> +         To compile this driver as a module, choose M here: the module w=
ill be
> +         called ad4000.
> +
>  config AD4130
>         tristate "Analog Device AD4130 ADC Driver"
>         depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index edb32ce2af02..aa52068d864b 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -6,6 +6,7 @@
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AB8500_GPADC) +=3D ab8500-gpadc.o
>  obj-$(CONFIG_AD_SIGMA_DELTA) +=3D ad_sigma_delta.o
> +obj-$(CONFIG_AD4000) +=3D ad4000.o
>  obj-$(CONFIG_AD4130) +=3D ad4130.o
>  obj-$(CONFIG_AD7091R) +=3D ad7091r-base.o
>  obj-$(CONFIG_AD7091R5) +=3D ad7091r5.o
> diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> new file mode 100644
> index 000000000000..7997d9d98743
> --- /dev/null
> +++ b/drivers/iio/adc/ad4000.c
> @@ -0,0 +1,649 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AD4000 SPI ADC driver
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +#include <asm/unaligned.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/sysfs.h>
> +#include <linux/units.h>
> +#include <linux/util_macros.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +
> +#define AD400X_READ_COMMAND    0x54
> +#define AD400X_WRITE_COMMAND   0x14
> +
> +/* AD4000 Configuration Register programmable bits */
> +#define AD4000_STATUS          BIT(4) /* Status bits output */
> +#define AD4000_SPAN_COMP       BIT(3) /* Input span compression  */
> +#define AD4000_HIGHZ           BIT(2) /* High impedance mode  */
> +#define AD4000_TURBO           BIT(1) /* Turbo mode */

Usually bits of the same register share a similar prefix, e.g.
AD4000_CFG_TURBO, AD4000_CFG_HIGHZ, etc.

> +
> +#define AD4000_TQUIET2_NS              60
> +
> +#define AD4000_18BIT_MSK       GENMASK(31, 14)
> +#define AD4000_20BIT_MSK       GENMASK(31, 12)
> +
> +#define AD4000_DIFF_CHANNEL(_sign, _real_bits)                         \
> +       {                                                               \
> +               .type =3D IIO_VOLTAGE,                                   =
 \
> +               .indexed =3D 1,                                          =
 \
> +               .differential =3D 1,                                     =
 \
> +               .channel =3D 0,                                          =
 \
> +               .channel2 =3D 1,                                         =
 \
> +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |         =
 \
> +                                     BIT(IIO_CHAN_INFO_SCALE),         \
> +               .info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE=
),\
> +               .scan_type =3D {                                         =
 \
> +                       .sign =3D _sign,                                 =
 \
> +                       .realbits =3D _real_bits,                        =
 \
> +                       .storagebits =3D _real_bits > 16 ? 32 : 16,      =
 \
> +                       .shift =3D _real_bits > 16 ? 32 - _real_bits : 0,=
 \
> +                       .endianness =3D IIO_BE,                          =
 \
> +               },                                                      \
> +       }                                                               \
> +
> +#define AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits)                  \
> +       {                                                               \
> +               .type =3D IIO_VOLTAGE,                                   =
 \
> +               .indexed =3D 1,                                          =
 \
> +               .channel =3D 0,                                          =
 \
> +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |         =
 \
> +                                     BIT(IIO_CHAN_INFO_SCALE) |        \
> +                                     BIT(IIO_CHAN_INFO_OFFSET),        \
> +               .info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE=
),\
> +               .scan_type =3D {                                         =
 \
> +                       .sign =3D _sign,                                 =
 \
> +                       .realbits =3D _real_bits,                        =
 \
> +                       .storagebits =3D _real_bits > 16 ? 32 : 16,      =
 \
> +                       .shift =3D _real_bits > 16 ? 32 - _real_bits : 0,=
 \
> +                       .endianness =3D IIO_BE,                          =
 \
> +               },                                                      \
> +       }                                                               \

It looks like all differential chips are signed and all
pseduo-differential chips are unsigned, so I don't think we need the
_sign parameter in these macros.

I also still have doubts about using IIO_BE and 8-bit xfers when it
comes to adding support later to achieve max sample rate with a SPI
offload. For example to get 2MSPS with an 18-bit chip, it will require
an approx 33% faster SPI clock than the actual slowest clock possible
because it will have to read 6 extra bits per sample. I didn't check
the specs, but this may not even be physically possible without
exceeding the datasheet max SPI clock rate. Also errors could be
reduced if we could actually use the slowest allowable SPI clock rate.
Furthermore, the offload hardware would have to be capable of adding
an extra byte per sample for 18 and 20-bit chips when piping the data
to DMA in order to get the 32-bit alignment in the buffer required by
IIO scan_type and the natural alignment requirements of IIO buffers in
general.

> +
> +enum ad4000_ids {
> +       ID_AD4000,
> +       ID_AD4001,
> +       ID_AD4002,
> +       ID_AD4003,
> +       ID_AD4004,
> +       ID_AD4005,
> +       ID_AD4006,
> +       ID_AD4007,
> +       ID_AD4008,
> +       ID_AD4010,
> +       ID_AD4011,
> +       ID_AD4020,
> +       ID_AD4021,
> +       ID_AD4022,
> +       ID_ADAQ4001,
> +       ID_ADAQ4003,
> +};
> +
> +struct ad4000_chip_info {
> +       const char *dev_name;
> +       struct iio_chan_spec chan_spec;
> +};
> +
> +static const struct ad4000_chip_info ad4000_chips[] =3D {
> +       [ID_AD4000] =3D {
> +               .dev_name =3D "ad4000",
> +               .chan_spec =3D AD4000_PSEUDO_DIFF_CHANNEL('u', 16),
> +       },
> +       [ID_AD4001] =3D {
> +               .dev_name =3D "ad4001",
> +               .chan_spec =3D AD4000_DIFF_CHANNEL('s', 16),
> +       },
> +       [ID_AD4002] =3D {
> +               .dev_name =3D "ad4002",
> +               .chan_spec =3D AD4000_PSEUDO_DIFF_CHANNEL('u', 18),
> +       },
> +       [ID_AD4003] =3D {
> +               .dev_name =3D "ad4003",
> +               .chan_spec =3D AD4000_DIFF_CHANNEL('s', 18),
> +       },
> +       [ID_AD4004] =3D {
> +               .dev_name =3D "ad4004",
> +               .chan_spec =3D AD4000_PSEUDO_DIFF_CHANNEL('u', 16),
> +       },
> +       [ID_AD4005] =3D {
> +               .dev_name =3D "ad4005",
> +               .chan_spec =3D AD4000_DIFF_CHANNEL('s', 16),
> +       },
> +       [ID_AD4006] =3D {
> +               .dev_name =3D "ad4006",
> +               .chan_spec =3D AD4000_PSEUDO_DIFF_CHANNEL('u', 18),
> +       },
> +       [ID_AD4007] =3D {
> +               .dev_name =3D "ad4007",
> +               .chan_spec =3D AD4000_DIFF_CHANNEL('s', 18),
> +       },
> +       [ID_AD4008] =3D {
> +               .dev_name =3D "ad4008",
> +               .chan_spec =3D AD4000_PSEUDO_DIFF_CHANNEL('u', 16),
> +       },
> +       [ID_AD4010] =3D {
> +               .dev_name =3D "ad4010",
> +               .chan_spec =3D AD4000_PSEUDO_DIFF_CHANNEL('u', 18),
> +       },
> +       [ID_AD4011] =3D {
> +               .dev_name =3D "ad4011",
> +               .chan_spec =3D AD4000_DIFF_CHANNEL('s', 18),
> +       },
> +       [ID_AD4020] =3D {
> +               .dev_name =3D "ad4020",
> +               .chan_spec =3D AD4000_DIFF_CHANNEL('s', 20),
> +       },
> +       [ID_AD4021] =3D {
> +               .dev_name =3D "ad4021",
> +               .chan_spec =3D AD4000_DIFF_CHANNEL('s', 20),
> +       },
> +       [ID_AD4022] =3D {
> +               .dev_name =3D "ad4022",
> +               .chan_spec =3D AD4000_DIFF_CHANNEL('s', 20),
> +       },
> +       [ID_ADAQ4001] =3D {
> +               .dev_name =3D "adaq4001",
> +               .chan_spec =3D AD4000_DIFF_CHANNEL('s', 16),
> +       },
> +       [ID_ADAQ4003] =3D {
> +               .dev_name =3D "adaq4003",
> +               .chan_spec =3D AD4000_DIFF_CHANNEL('s', 18),
> +       },
> +};
> +
> +enum ad4000_gains {
> +       AD4000_0454_GAIN =3D 0,
> +       AD4000_0909_GAIN =3D 1,
> +       AD4000_1_GAIN =3D 2,

AD4000_1000_GAIN would be more consistent with the others.

> +       AD4000_1900_GAIN =3D 3,
> +       AD4000_GAIN_LEN
> +};
> +
> +/*
> + * Gains stored and computed as fractions to avoid introducing rounding =
errors.
> + */
> +static const int ad4000_gains_frac[AD4000_GAIN_LEN][2] =3D {
> +       [AD4000_0454_GAIN] =3D { 227, 500 },
> +       [AD4000_0909_GAIN] =3D { 909, 1000 },
> +       [AD4000_1_GAIN] =3D { 1, 1 },
> +       [AD4000_1900_GAIN] =3D { 19, 10 },
> +};

Why not just store the numerator in milli units and always use 1000
for the denominator? It seems like it would simplify the code and make
it easier to read and understand. Also, these values are coming from
the adi,gain-milli property already, so we could avoid the enum and
the lookup table entirely and simplify things even more.

> +
> +struct ad4000_state {
> +       struct spi_device *spi;
> +       struct gpio_desc *cnv_gpio;
> +       int vref;
> +       bool status_bits;
> +       bool span_comp;
> +       bool turbo_mode;
> +       bool high_z_mode;
> +
> +       enum ad4000_gains pin_gain;
> +       int scale_tbl[AD4000_GAIN_LEN][2][2];
> +
> +       /*
> +        * DMA (thus cache coherency maintenance) requires the
> +        * transfer buffers to live in their own cache lines.
> +        */
> +       struct {
> +               union {
> +                       u16 sample_buf16;
> +                       u32 sample_buf32;

Technically, these are holding big-endian data, so __be16 and __be32
would be more correct.

> +               } data;
> +               s64 timestamp __aligned(8);
> +       } scan;
> +       __be16 tx_buf __aligned(IIO_DMA_MINALIGN);
> +       __be16 rx_buf;
> +};

scan.data is used as SPI rx_buf so __aligned(IIO_DMA_MINALIGN); needs
to be moved to the scan field.

> +
> +static void ad4000_fill_scale_tbl(struct ad4000_state *st, int scale_bit=
s,
> +                                 const struct ad4000_chip_info *chip)
> +{
> +       int diff =3D chip->chan_spec.differential;
> +       int val, val2, tmp0, tmp1, i;
> +       u64 tmp2;
> +
> +       val2 =3D scale_bits;
> +       for (i =3D 0; i < AD4000_GAIN_LEN; i++) {

Only one gain is selected by the devicetree, so why do we need to do
this for all 4 gains?

> +               val =3D st->vref / 1000;
> +               /* Multiply by MILLI here to avoid losing precision */
> +               val =3D mult_frac(val, ad4000_gains_frac[i][1] * MILLI,
> +                               ad4000_gains_frac[i][0]);
> +               /* Would multiply by NANO here but we already multiplied =
by MILLI */
> +               tmp2 =3D shift_right((u64)val * MICRO, val2);
> +               tmp0 =3D (int)div_s64_rem(tmp2, NANO, &tmp1);
> +               /* Store scale for when span compression is disabled */
> +               st->scale_tbl[i][0][0] =3D tmp0; /* Integer part */
> +               st->scale_tbl[i][0][1] =3D abs(tmp1); /* Fractional part =
*/
> +               /* Store scale for when span compression is enabled */
> +               st->scale_tbl[i][1][0] =3D tmp0;
> +               if (diff)
> +                       st->scale_tbl[i][1][1] =3D DIV_ROUND_CLOSEST(abs(=
tmp1) * 4, 5);
> +               else
> +                       st->scale_tbl[i][1][1] =3D DIV_ROUND_CLOSEST(abs(=
tmp1) * 9, 10);
> +       }
> +}
> +
> +static int ad4000_write_reg(struct ad4000_state *st, uint8_t val)
> +{
> +       put_unaligned_be16(AD400X_WRITE_COMMAND << BITS_PER_BYTE | val,
> +                          &st->tx_buf);
> +       return spi_write(st->spi, &st->tx_buf, 2);
> +}
> +
> +static int ad4000_read_reg(struct ad4000_state *st, unsigned int *val)
> +{
> +       struct spi_transfer t[] =3D {
> +               {
> +                       .tx_buf =3D &st->tx_buf,
> +                       .rx_buf =3D &st->rx_buf,
> +                       .len =3D 2,
> +               },
> +       };
> +       int ret;
> +
> +       put_unaligned_be16(AD400X_READ_COMMAND << BITS_PER_BYTE, &st->tx_=
buf);
> +       ret =3D spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
> +       if (ret < 0)
> +               return ret;
> +
> +       *val =3D get_unaligned_be16(&st->rx_buf);
> +
> +       return ret;
> +}
> +

It would be very helpful to have comments here explaining the exact
expected wiring configuration and signal timing here since there are
so many possibilities for this chip.

> +static int ad4000_read_sample(struct ad4000_state *st,
> +                             const struct iio_chan_spec *chan)
> +{
> +       struct spi_transfer t[] =3D {

Don't really need [] here since there is only one xfer.

> +               {
> +                       .rx_buf =3D &st->scan.data,
> +                       .len =3D BITS_TO_BYTES(chan->scan_type.storagebit=
s),
> +                       .delay =3D {
> +                               .value =3D AD4000_TQUIET2_NS,
> +                               .unit =3D SPI_DELAY_UNIT_NSECS,
> +                       },
> +               },
> +       };
> +       int ret;
> +
> +       ret =3D spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static int ad4000_single_conversion(struct iio_dev *indio_dev,
> +                                   const struct iio_chan_spec *chan, int=
 *val)
> +{
> +       struct ad4000_state *st =3D iio_priv(indio_dev);
> +       u32 sample;
> +       int ret;
> +
> +       if (st->cnv_gpio)
> +               gpiod_set_value_cansleep(st->cnv_gpio, GPIOD_OUT_HIGH);

It would make more sense and be less redundant to move the gpio code
into ad4000_read_sample().

Also, gpiod_set_value_cansleep() checks for NULL, so the if () is redundant=
.

> +
> +       ret =3D ad4000_read_sample(st, chan);
> +       if (ret)
> +               return ret;
> +
> +       if (st->cnv_gpio)
> +               gpiod_set_value_cansleep(st->cnv_gpio, GPIOD_OUT_LOW);
> +
> +       if (chan->scan_type.storagebits > 16)
> +               sample =3D get_unaligned_be32(&st->scan.data);
> +       else
> +               sample =3D get_unaligned_be16(&st->scan.data);

data is aligned, so be32/16_to_cpu() should be fine. Also, Jonathan
will suggest to use &st->scan.data.sample_b32/16 here too. :-)

> +
> +       switch (chan->scan_type.realbits) {
> +       case 16:
> +               break;
> +       case 18:
> +               sample =3D FIELD_GET(AD4000_18BIT_MSK, sample);
> +               break;
> +       case 20:
> +               sample =3D FIELD_GET(AD4000_20BIT_MSK, sample);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       if (chan->scan_type.sign =3D=3D 's')
> +               *val =3D sign_extend32(sample, chan->scan_type.realbits -=
 1);
> +
> +       return IIO_VAL_INT;
> +}
> +
> +static int ad4000_read_raw(struct iio_dev *indio_dev,
> +                          struct iio_chan_spec const *chan, int *val,
> +                          int *val2, long info)
> +{
> +       struct ad4000_state *st =3D iio_priv(indio_dev);
> +
> +       switch (info) {
> +       case IIO_CHAN_INFO_RAW:
> +               iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> +                       return ad4000_single_conversion(indio_dev, chan, =
val);
> +               unreachable();
> +       case IIO_CHAN_INFO_SCALE:
> +               *val =3D st->scale_tbl[st->pin_gain][st->span_comp][0];
> +               *val2 =3D st->scale_tbl[st->pin_gain][st->span_comp][1];
> +               return IIO_VAL_INT_PLUS_NANO;
> +       case IIO_CHAN_INFO_OFFSET:
> +               *val =3D 0;
> +               if (st->span_comp)
> +                       *val =3D mult_frac(st->vref / 1000, 1, 10);
> +
> +               return IIO_VAL_INT;
> +       default:
> +               break;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int ad4000_read_avail(struct iio_dev *indio_dev,
> +                            struct iio_chan_spec const *chan,
> +                            const int **vals, int *type, int *length,
> +                            long info)
> +{
> +       struct ad4000_state *st =3D iio_priv(indio_dev);
> +
> +       switch (info) {
> +       case IIO_CHAN_INFO_SCALE:
> +               *vals =3D (int *)st->scale_tbl[st->pin_gain];
> +               *length =3D 2 * 2;
> +               *type =3D IIO_VAL_INT_PLUS_NANO;
> +               return IIO_AVAIL_LIST;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int ad4000_write_raw_get_fmt(struct iio_dev *indio_dev,
> +                                   struct iio_chan_spec const *chan, lon=
g mask)
> +{
> +       switch (mask) {
> +       case IIO_CHAN_INFO_SCALE:
> +               return IIO_VAL_INT_PLUS_NANO;
> +       default:
> +               return IIO_VAL_INT_PLUS_MICRO;
> +       }
> +       return -EINVAL;

not reachable because of default, so can be left out

> +}
> +
> +static int ad4000_write_raw(struct iio_dev *indio_dev,
> +                           struct iio_chan_spec const *chan, int val, in=
t val2,
> +                           long mask)
> +{
> +       struct ad4000_state *st =3D iio_priv(indio_dev);
> +       unsigned int reg_val;
> +       bool span_comp_en;
> +       int ret;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_SCALE:
> +               iio_device_claim_direct_scoped(return -EBUSY, indio_dev) =
{
> +                       ret =3D ad4000_read_reg(st, &reg_val);
> +                       if (ret < 0)
> +                               return ret;
> +
> +                       span_comp_en =3D (val2 =3D=3D st->scale_tbl[st->p=
in_gain][1][1]);
> +                       reg_val &=3D ~AD4000_SPAN_COMP;
> +                       reg_val |=3D FIELD_PREP(AD4000_SPAN_COMP, span_co=
mp_en);
> +
> +                       ret =3D ad4000_write_reg(st, reg_val);
> +                       if (ret < 0)
> +                               return ret;
> +
> +                       st->span_comp =3D span_comp_en;
> +                       return 0;
> +               }
> +               unreachable();

Can bring out the return 0 to avoid unreachable.

> +       default:
> +               break;

Can return -EINVAL to avoid break;

> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static irqreturn_t ad4000_trigger_handler(int irq, void *p)
> +{
> +       struct iio_poll_func *pf =3D p;
> +       struct iio_dev *indio_dev =3D pf->indio_dev;
> +       struct ad4000_state *st =3D iio_priv(indio_dev);
> +       int ret;
> +
> +       if (st->cnv_gpio)
> +               gpiod_set_value(st->cnv_gpio, GPIOD_OUT_HIGH);
> +
> +       ret =3D ad4000_read_sample(st, &indio_dev->channels[0]);
> +       if (ret < 0)
> +               goto err_out;
> +
> +       if (st->cnv_gpio)
> +               gpiod_set_value(st->cnv_gpio, GPIOD_OUT_LOW);
> +
> +       iio_push_to_buffers_with_timestamp(indio_dev, &st->scan,
> +                                          iio_get_time_ns(indio_dev));
> +
> +err_out:
> +       iio_trigger_notify_done(indio_dev->trig);
> +       return IRQ_HANDLED;
> +}
> +
> +static const struct iio_info ad4000_info =3D {
> +       .read_raw =3D &ad4000_read_raw,
> +       .read_avail =3D &ad4000_read_avail,
> +       .write_raw =3D &ad4000_write_raw,
> +       .write_raw_get_fmt =3D &ad4000_write_raw_get_fmt,
> +};
> +
> +static void ad4000_config(struct ad4000_state *st)
> +{
> +       unsigned int reg_val;
> +       int ret;
> +
> +       reg_val =3D FIELD_PREP(AD4000_TURBO, 1);

Since the driver in it's current state can get anywhere near the max
sample rate of ~1MSPS, I don't think it makes sense to enable turbo at
this point.

> +
> +       if (device_property_present(&st->spi->dev, "adi,high-z-input"))
> +               reg_val |=3D FIELD_PREP(AD4000_HIGHZ, 1);
> +
> +       /*
> +        * The ADC SDI pin might be connected to controller CS line in wh=
ich
> +        * case the write might fail. This, however, does not prevent the=
 device
> +        * from functioning even though in a configuration other than the
> +        * requested one.
> +        */
> +       ret =3D ad4000_write_reg(st, reg_val);
> +       if (ret < 0)
> +               dev_dbg(&st->spi->dev, "Failed to config device\n");

If writing fails because there is no CS line wired up, we won't get an
error returned here. The SPI controller has no way of knowing this
happened, so it can only assume the write was successful and return 0.
So this should return ret.

Ideally, the devicetree should tell us if CS is wired up or not.

> +}
> +
> +static void ad4000_regulator_disable(void *reg)
> +{
> +       regulator_disable(reg);
> +}
> +
> +static int ad4000_probe(struct spi_device *spi)
> +{
> +       const struct ad4000_chip_info *chip;
> +       struct regulator *vref_reg;
> +       struct iio_dev *indio_dev;
> +       struct ad4000_state *st;
> +       int ret;

We need a check somewhere in here to make sure that adi,spi-mode is in
a supported configuration. E.g. chain mode is not currently
implemented.

> +
> +       indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       chip =3D spi_get_device_match_data(spi);
> +       if (!chip)
> +               return -EINVAL;
> +
> +       st =3D iio_priv(indio_dev);
> +       st->spi =3D spi;
> +
> +       ret =3D devm_regulator_get_enable(&spi->dev, "vdd");
> +       if (ret)
> +               return dev_err_probe(&spi->dev, ret, "Failed to enable VD=
D supply\n");
> +
> +       ret =3D devm_regulator_get_enable(&spi->dev, "vio");
> +       if (ret)
> +               return dev_err_probe(&spi->dev, ret, "Failed to enable VI=
O supply\n");
> +
> +       vref_reg =3D devm_regulator_get(&spi->dev, "ref");
> +       if (IS_ERR(vref_reg))
> +               return dev_err_probe(&spi->dev, PTR_ERR(vref_reg),
> +                                    "Failed to get vref regulator\n");
> +
> +       ret =3D regulator_enable(vref_reg);
> +       if (ret < 0)
> +               return dev_err_probe(&spi->dev, ret,
> +                                    "Failed to enable voltage regulator\=
n");
> +
> +       ret =3D devm_add_action_or_reset(&spi->dev, ad4000_regulator_disa=
ble, vref_reg);
> +       if (ret)
> +               return dev_err_probe(&spi->dev, ret,
> +                                    "Failed to add regulator disable act=
ion\n");
> +
> +       st->vref =3D regulator_get_voltage(vref_reg);
> +       if (st->vref < 0)
> +               return dev_err_probe(&spi->dev, st->vref, "Failed to get =
vref\n");
> +
> +       st->cnv_gpio =3D devm_gpiod_get_optional(&spi->dev, "cnv", GPIOD_=
OUT_HIGH);
> +       if (IS_ERR(st->cnv_gpio)) {
> +               if (PTR_ERR(st->cnv_gpio) =3D=3D -EPROBE_DEFER)
> +                       return -EPROBE_DEFER;

EPROBE_DEFER check is not needed with dev_err_probe();, it already does tha=
t.


> +
> +               return dev_err_probe(&spi->dev, PTR_ERR(st->cnv_gpio),
> +                                    "Failed to get CNV GPIO");
> +       }
> +
> +       ad4000_config(st);
> +
> +       indio_dev->name =3D chip->dev_name;
> +       indio_dev->info =3D &ad4000_info;
> +       indio_dev->channels =3D &chip->chan_spec;
> +       indio_dev->num_channels =3D 1;
> +
> +       st->pin_gain =3D AD4000_1_GAIN;
> +       if (device_property_present(&spi->dev, "adi,gain-milli")) {
> +               u32 val;

Should it be an error if adi,gain-milli is set on non-adaq chips?

> +
> +               ret =3D device_property_read_u32(&spi->dev, "adi,gain-mil=
li", &val);
> +               if (ret)
> +                       return ret;
> +
> +               switch (val) {
> +               case 454:
> +                       st->pin_gain =3D AD4000_0454_GAIN;
> +                       break;
> +               case 909:
> +                       st->pin_gain =3D AD4000_0909_GAIN;
> +                       break;
> +               case 1000:
> +                       st->pin_gain =3D AD4000_1_GAIN;
> +                       break;
> +               case 1900:
> +                       st->pin_gain =3D AD4000_1900_GAIN;
> +                       break;
> +               default:
> +                       return dev_err_probe(&spi->dev, -EINVAL,
> +                                            "Invalid firmware provided g=
ain\n");

Could help debugging if val is included in the error message.


> +               }
> +       }
> +
> +       /*
> +        * ADCs that output twos complement code have one less bit to exp=
ress
> +        * voltage magnitude.
> +        */
> +       if (chip->chan_spec.scan_type.sign =3D=3D 's')
> +               ad4000_fill_scale_tbl(st, chip->chan_spec.scan_type.realb=
its - 1,
> +                                     chip);
> +       else
> +               ad4000_fill_scale_tbl(st, chip->chan_spec.scan_type.realb=
its,
> +                                     chip);
> +
> +       ret =3D devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +                                             &iio_pollfunc_store_time,
> +                                             &ad4000_trigger_handler, NU=
LL);
> +       if (ret)
> +               return ret;
> +
> +       return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct spi_device_id ad4000_id[] =3D {
> +       { "ad4000", (kernel_ulong_t)&ad4000_chips[ID_AD4000] },
> +       { "ad4001", (kernel_ulong_t)&ad4000_chips[ID_AD4001] },
> +       { "ad4002", (kernel_ulong_t)&ad4000_chips[ID_AD4002] },
> +       { "ad4003", (kernel_ulong_t)&ad4000_chips[ID_AD4003] },
> +       { "ad4004", (kernel_ulong_t)&ad4000_chips[ID_AD4004] },
> +       { "ad4005", (kernel_ulong_t)&ad4000_chips[ID_AD4005] },
> +       { "ad4006", (kernel_ulong_t)&ad4000_chips[ID_AD4006] },
> +       { "ad4007", (kernel_ulong_t)&ad4000_chips[ID_AD4007] },
> +       { "ad4008", (kernel_ulong_t)&ad4000_chips[ID_AD4008] },
> +       { "ad4010", (kernel_ulong_t)&ad4000_chips[ID_AD4010] },
> +       { "ad4011", (kernel_ulong_t)&ad4000_chips[ID_AD4011] },
> +       { "ad4020", (kernel_ulong_t)&ad4000_chips[ID_AD4020] },
> +       { "ad4021", (kernel_ulong_t)&ad4000_chips[ID_AD4021] },
> +       { "ad4022", (kernel_ulong_t)&ad4000_chips[ID_AD4022] },
> +       { "adaq4001", (kernel_ulong_t)&ad4000_chips[ID_ADAQ4001] },
> +       { "adaq4003", (kernel_ulong_t)&ad4000_chips[ID_ADAQ4003] },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(spi, ad4000_id);
> +
> +static const struct of_device_id ad4000_of_match[] =3D {
> +       { .compatible =3D "adi,ad4000", .data =3D &ad4000_chips[ID_AD4000=
] },
> +       { .compatible =3D "adi,ad4001", .data =3D &ad4000_chips[ID_AD4001=
] },
> +       { .compatible =3D "adi,ad4002", .data =3D &ad4000_chips[ID_AD4002=
] },
> +       { .compatible =3D "adi,ad4003", .data =3D &ad4000_chips[ID_AD4003=
] },
> +       { .compatible =3D "adi,ad4004", .data =3D &ad4000_chips[ID_AD4004=
] },
> +       { .compatible =3D "adi,ad4005", .data =3D &ad4000_chips[ID_AD4005=
] },
> +       { .compatible =3D "adi,ad4006", .data =3D &ad4000_chips[ID_AD4006=
] },
> +       { .compatible =3D "adi,ad4007", .data =3D &ad4000_chips[ID_AD4007=
] },
> +       { .compatible =3D "adi,ad4008", .data =3D &ad4000_chips[ID_AD4008=
] },
> +       { .compatible =3D "adi,ad4010", .data =3D &ad4000_chips[ID_AD4010=
] },
> +       { .compatible =3D "adi,ad4011", .data =3D &ad4000_chips[ID_AD4011=
] },
> +       { .compatible =3D "adi,ad4020", .data =3D &ad4000_chips[ID_AD4020=
] },
> +       { .compatible =3D "adi,ad4021", .data =3D &ad4000_chips[ID_AD4021=
] },
> +       { .compatible =3D "adi,ad4022", .data =3D &ad4000_chips[ID_AD4022=
] },
> +       { .compatible =3D "adi,adaq4001", .data =3D &ad4000_chips[ID_ADAQ=
4001] },
> +       { .compatible =3D "adi,adaq4003", .data =3D &ad4000_chips[ID_ADAQ=
4003] },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, ad4000_of_match);
> +
> +static struct spi_driver ad4000_driver =3D {
> +       .driver =3D {
> +               .name   =3D "ad4000",
> +               .of_match_table =3D ad4000_of_match,
> +       },
> +       .probe          =3D ad4000_probe,
> +       .id_table       =3D ad4000_id,
> +};
> +module_spi_driver(ad4000_driver);
> +
> +MODULE_AUTHOR("Mircea Caprioru <mircea.caprioru@analog.com>");
> +MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD4000 ADC driver");
> +MODULE_LICENSE("GPL");
> --
> 2.43.0
>
>

