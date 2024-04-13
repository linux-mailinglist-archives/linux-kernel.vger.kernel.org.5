Return-Path: <linux-kernel+bounces-143855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FD78A3E49
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 22:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161BE1C20AFF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 20:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48FA53E16;
	Sat, 13 Apr 2024 20:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iFokChrM"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166701CD0C
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713038756; cv=none; b=St+jpE3+7XTaITnoOX23B3jZhmeZ36KqzxvuDgYNmxONdkCWhQvilzlVTMjEW5Ey9iBIHGxN31Ro+wVndieOXxzc0bdvFXSS/xjFVJAiq7mcRgx2NdZirdqkZI1lgLhsKwFEtEwFSkRhNRfn0vI874m1IVVNYGt0YcRsB1hbYlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713038756; c=relaxed/simple;
	bh=G5KyVytV//vNjdLRl1XvHHCAToStbzy2uRg8qGFTybs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tI8IdMtRQagjTPoTzffq6gAfRqoBzpfFzx6G3VGSB5rzHJua9nNrpSIvxWg8cY/NQBgDWo6v2d567vZro7BgWzyDWVGFykMqGMs5OVM58cINVPQbsyjHQovyWJ8h23yyI0eaNozE8ruskleptJYAxa9B0mvaNqCPaEFuxl0+tcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iFokChrM; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso21916351fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 13:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713038752; x=1713643552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlGD+qdCOiEZc9bytwKuo7IS7+QuzfujJRMSsaN5K3I=;
        b=iFokChrMBjRscjurnpHvSOGpso5snfreJLckXE3nWt+v4zV9+4Yn2Sok5qu93RE3xQ
         wbphat+obYuUtjb+XLzxQFAFnq3/YhA+gOS5k9uNOjzm+uEHsxeXHqehWtPuS9hEiEfy
         Is2CTckM+CBMpd05vmEydFvP77ihvMiLcRtN0Fesw/FK5F0fr4VrP3QkJWb+WBt3w174
         xnG54FXHQzhUmyJxHJHIypDPdNtR+Gss+b0O+ou3TUdUvxJs47vifjcw0+FPbe9ocgpu
         0ADDMmoRCZV/86QyJYTxJIBWw8rlVt4n/mkEL/Ra4y5aQX+cId1WBVZAhHp8dckpURAZ
         xmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713038752; x=1713643552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlGD+qdCOiEZc9bytwKuo7IS7+QuzfujJRMSsaN5K3I=;
        b=h2kvez7kn4CZ30u2WLqlu+XIIxuc78iYmacxQWz+uwNblexzHSRtwG3xbLkA3iz1x+
         KyypT5vJtyv8rSgLkPjb/pi2pt9TzPiDjDcrIpbPesc5cCL/s/JUPTdCUnVbjobGWr2a
         AEMlZRih/0oMFl02e/1K7equ1Qnxc6fjbI+BFT7r7Pyly+LPvMIpyjudkKd0fQAJu1+X
         aQZGT+MVpBHlYt5OqVO0fhnOH+nOvrUFCYWG/aQT3yWl1T2l3J522+bkMUxwsegKCWme
         eJWqtY0Ph45dGqYEzCRuytG1LNdgX+cYHvfhvhV5ZOPPj8lb0F2GJcgZC2yoJD93fx8w
         YRFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb5/mtUMEKaqBdbymdSXappx7eli/1pLUkUcZpq9sOzS3zC5kyO91Z/jEe9pLNAPGcjAodYAX0FUY3CnjcQTQPjYMRE9S4Twb7EaCP
X-Gm-Message-State: AOJu0Ywmgu8wExlw90Hr7EIWlANZW+gr4Df14tdI1onGaOEzEF+jkGvv
	jGPf34xybsBBobYjVF6+SZfg1hbGR/1rV0T2sPcHvIsUuiOVHtKeOMBHrHolAEe7hZ0/3SU9KdF
	wlw/jGz1EUlsyl0X1U8YKkC7R5gOaSlidGBiOPA==
X-Google-Smtp-Source: AGHT+IHdj4RXGAiLDEWiRQg8fQCONsSW/SLIaSMHnBuczdmm80HYmxVvr4Bkj7VB6XblcZNd4Yhay0HNzkgoZ0x3mi8=
X-Received: by 2002:a2e:9cd5:0:b0:2d9:fde0:86e2 with SMTP id
 g21-20020a2e9cd5000000b002d9fde086e2mr4334962ljj.15.1713038752033; Sat, 13
 Apr 2024 13:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240413151152.165682-1-alisa.roman@analog.com> <20240413151152.165682-6-alisa.roman@analog.com>
In-Reply-To: <20240413151152.165682-6-alisa.roman@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 13 Apr 2024 15:05:40 -0500
Message-ID: <CAMknhBFzUeW5+rs_GgCZCiit=eW04VHyCnt-__jXLnO3Z29ksA@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] iio: adc: ad7192: Add AD7194 support
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alexandru.tachici@analog.com, lars@metafoo.de, jic23@kernel.org, 
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org, nuno.sa@analog.com, 
	marcelo.schmitt@analog.com, bigunclemax@gmail.com, okan.sahin@analog.com, 
	fr0st61te@gmail.com, alisa.roman@analog.com, marcus.folkesson@gmail.com, 
	schnelle@linux.ibm.com, liambeguin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 10:13=E2=80=AFAM Alisa-Dariana Roman
<alisadariana@gmail.com> wrote:
>
> Unlike the other AD719Xs, AD7194 has configurable differential
> channels. The user can dynamically configure them in the devicetree.
>
> Also modify config AD7192 description for better scaling.
>
> Moved ad7192_chip_info struct definition to allow use of callback
> function parse_channels().

It looks like this no longer needs to be moved in this revision.

>
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  drivers/iio/adc/Kconfig  |  11 ++-
>  drivers/iio/adc/ad7192.c | 140 ++++++++++++++++++++++++++++++++++++---
>  2 files changed, 138 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 8db68b80b391..74fecc284f1a 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -88,12 +88,17 @@ config AD7173
>           called ad7173.
>
>  config AD7192
> -       tristate "Analog Devices AD7190 AD7192 AD7193 AD7195 ADC driver"
> +       tristate "Analog Devices AD7192 and similar ADC driver"
>         depends on SPI
>         select AD_SIGMA_DELTA
>         help
> -         Say yes here to build support for Analog Devices AD7190,
> -         AD7192, AD7193 or AD7195 SPI analog to digital converters (ADC)=
.
> +         Say yes here to build support for Analog Devices SPI analog to =
digital
> +         converters (ADC):
> +         - AD7190
> +         - AD7192
> +         - AD7193
> +         - AD7194
> +         - AD7195
>           If unsure, say N (but it's safe to say "Y").
>
>           To compile this driver as a module, choose M here: the
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index a9eb4fab39ca..646ab56b87e3 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * AD7190 AD7192 AD7193 AD7195 SPI ADC driver
> + * AD7192 and similar SPI ADC driver
>   *
>   * Copyright 2011-2015 Analog Devices Inc.
>   */
> @@ -128,10 +128,21 @@
>  #define AD7193_CH_AIN8         0x480 /* AIN7 - AINCOM */
>  #define AD7193_CH_AINCOM       0x600 /* AINCOM - AINCOM */
>
> +#define AD7194_CH_POS(x)       (((x) - 1) << 4)
> +#define AD7194_CH_NEG(x)       ((x) - 1)
> +#define AD7194_CH_DIFF(pos, neg) \
> +               (((neg) =3D=3D 0 ? BIT(10) : AD7194_CH_NEG(neg)) | AD7194=
_CH_POS(pos))
> +#define AD7194_CH_TEMP         0x100 /* Temp sensor */
> +#define AD7194_CH_BASE_NR      18
> +#define AD7194_CH_AIN_START    1
> +#define AD7194_CH_AIN_NR       16
> +#define AD7194_CH_DIFF_NR_MAX  256
> +
>  /* ID Register Bit Designations (AD7192_REG_ID) */
>  #define CHIPID_AD7190          0x4
>  #define CHIPID_AD7192          0x0
>  #define CHIPID_AD7193          0x2
> +#define CHIPID_AD7194          0x3
>  #define CHIPID_AD7195          0x6
>  #define AD7192_ID_MASK         GENMASK(3, 0)
>
> @@ -169,17 +180,10 @@ enum {
>         ID_AD7190,
>         ID_AD7192,
>         ID_AD7193,
> +       ID_AD7194,
>         ID_AD7195,
>  };
>
> -struct ad7192_chip_info {
> -       unsigned int                    chip_id;
> -       const char                      *name;
> -       struct iio_chan_spec            *channels;
> -       u8                              num_channels;
> -       const struct iio_info           *info;
> -};
> -
>  struct ad7192_state {
>         const struct ad7192_chip_info   *chip_info;
>         struct regulator                *avdd;
> @@ -201,6 +205,15 @@ struct ad7192_state {
>         struct ad_sigma_delta           sd;
>  };
>
> +struct ad7192_chip_info {
> +       unsigned int                    chip_id;
> +       const char                      *name;
> +       struct iio_chan_spec            *channels;
> +       u8                              num_channels;
> +       const struct iio_info           *info;
> +       int (*parse_channels)(struct iio_dev *indio_dev);
> +};
> +
>  static const char * const ad7192_syscalib_modes[] =3D {
>         [AD7192_SYSCALIB_ZERO_SCALE] =3D "zero_scale",
>         [AD7192_SYSCALIB_FULL_SCALE] =3D "full_scale",
> @@ -925,6 +938,15 @@ static const struct iio_info ad7192_info =3D {
>         .update_scan_mode =3D ad7192_update_scan_mode,
>  };
>
> +static const struct iio_info ad7194_info =3D {
> +       .read_raw =3D ad7192_read_raw,
> +       .write_raw =3D ad7192_write_raw,
> +       .write_raw_get_fmt =3D ad7192_write_raw_get_fmt,
> +       .read_avail =3D ad7192_read_avail,
> +       .validate_trigger =3D ad_sd_validate_trigger,
> +       .update_scan_mode =3D ad7192_update_scan_mode,
> +};
> +
>  static const struct iio_info ad7195_info =3D {
>         .read_raw =3D ad7192_read_raw,
>         .write_raw =3D ad7192_write_raw,
> @@ -1016,6 +1038,90 @@ static struct iio_chan_spec ad7193_channels[] =3D =
{
>         IIO_CHAN_SOFT_TIMESTAMP(14),
>  };
>
> +static int ad7192_parse_channel(struct fwnode_handle *child,
> +                               struct iio_chan_spec *ad7194_channels)

nit: this is only requiring one "channel" and is not used as
"channels" array, so I would leave out the "s".

> +{
> +       u32 ain[2];
> +       int ret;
> +
> +       ret =3D fwnode_property_read_u32_array(child, "diff-channels", ai=
n,
> +                                            ARRAY_SIZE(ain));
> +       if (ret)
> +               return ret;
> +
> +       if (!in_range(ain[0], AD7194_CH_AIN_START, AD7194_CH_AIN_NR) ||
> +           !in_range(ain[1], AD7194_CH_AIN_START, AD7194_CH_AIN_NR))
> +               return -EINVAL;
> +
> +       ad7194_channels->channel =3D ain[0];
> +       ad7194_channels->channel2 =3D ain[1];
> +       ad7194_channels->address =3D AD7194_CH_DIFF(ain[0], ain[1]);
> +
> +       return 0;
> +}
> +
> +static int ad7192_parse_channels(struct iio_dev *indio_dev)

Better name might be ad7194_parse_channels() or
ad7192_parse_ad7194_channels() since this is specific to the ad7194
chip.

> +{
> +       struct ad7192_state *st =3D iio_priv(indio_dev);
> +       struct device *dev =3D indio_dev->dev.parent;
> +       struct iio_chan_spec *ad7194_channels;
> +       struct fwnode_handle *child;
> +       struct iio_chan_spec ad7194_chan =3D AD7193_CHANNEL(0, 0, 0);
> +       struct iio_chan_spec ad7194_chan_diff =3D AD7193_DIFF_CHANNEL(0, =
0, 0, 0);
> +       struct iio_chan_spec ad7194_chan_temp =3D AD719x_TEMP_CHANNEL(0, =
0);
> +       struct iio_chan_spec ad7194_chan_timestamp =3D IIO_CHAN_SOFT_TIME=
STAMP(0);
> +       unsigned int num_channels, index =3D 0, ain_chan;
> +       int ret;
> +
> +       num_channels =3D device_get_child_node_count(dev);
> +       if (num_channels > AD7194_CH_DIFF_NR_MAX)
> +               return -EINVAL;
> +
> +       num_channels +=3D AD7194_CH_BASE_NR;
> +
> +       ad7194_channels =3D devm_kcalloc(dev, sizeof(*ad7194_channels),
> +                                      num_channels, GFP_KERNEL);

nit: technically, the argument order is supposed to be count then size

> +       if (!ad7194_channels)
> +               return -ENOMEM;
> +
> +       indio_dev->channels =3D ad7194_channels;
> +       indio_dev->num_channels =3D num_channels;
> +
> +       device_for_each_child_node(dev, child) {
> +               *ad7194_channels =3D ad7194_chan_diff;
> +               ad7194_channels->scan_index =3D index++;
> +               ret =3D ad7192_parse_channel(child, ad7194_channels);
> +               if (ret) {
> +                       fwnode_handle_put(child);
> +                       return ret;
> +               }
> +               ad7194_channels++;
> +       }
> +
> +       *ad7194_channels =3D ad7194_chan_temp;
> +       ad7194_channels->scan_index =3D index++;
> +       ad7194_channels->address =3D AD7194_CH_TEMP;
> +       ad7194_channels++;

nit: It would seem more natural to have all voltage channels
altogether rather than having the temperature channel in between.

> +
> +       for (ain_chan =3D 1; ain_chan <=3D 16; ain_chan++) {
> +               if (st->aincom_mv) {
> +                       *ad7194_channels =3D ad7194_chan;
> +               } else {
> +                       *ad7194_channels =3D ad7194_chan_diff;
> +                       ad7194_channels->channel2 =3D 0;
> +               }

Same comment as on [PATCH 3/5] pseudo-differential channels have
differential =3D 0 and so nothing should depend on st->aincom_mv being 0
or not.

> +               ad7194_channels->scan_index =3D index++;
> +               ad7194_channels->channel =3D ain_chan;
> +               ad7194_channels->address =3D AD7194_CH_DIFF(ain_chan, 0);
> +               ad7194_channels++;
> +       }
> +
> +       *ad7194_channels =3D ad7194_chan_timestamp;
> +       ad7194_channels->scan_index =3D index;
> +
> +       return 0;
> +}
> +
>  static const struct ad7192_chip_info ad7192_chip_info_tbl[] =3D {
>         [ID_AD7190] =3D {
>                 .chip_id =3D CHIPID_AD7190,
> @@ -1038,6 +1144,12 @@ static const struct ad7192_chip_info ad7192_chip_i=
nfo_tbl[] =3D {
>                 .num_channels =3D ARRAY_SIZE(ad7193_channels),
>                 .info =3D &ad7192_info,
>         },
> +       [ID_AD7194] =3D {
> +               .chip_id =3D CHIPID_AD7194,
> +               .name =3D "ad7194",
> +               .info =3D &ad7194_info,
> +               .parse_channels =3D ad7192_parse_channels,
> +       },
>         [ID_AD7195] =3D {
>                 .chip_id =3D CHIPID_AD7195,
>                 .name =3D "ad7195",
> @@ -1164,6 +1276,12 @@ static int ad7192_probe(struct spi_device *spi)
>         indio_dev->num_channels =3D st->chip_info->num_channels;
>         indio_dev->info =3D st->chip_info->info;
>
> +       if (st->chip_info->parse_channels) {
> +               ret =3D st->chip_info->parse_channels(indio_dev);
> +               if (ret)
> +                       return ret;
> +       }

Take it or leave it, but I think it would be nice to move

    indio_dev->channels =3D st->chip_info->channels;
    indio_dev->num_channels =3D st->chip_info->num_channels;

into an else { } here to make it clear what parse_channels is doing.

> +
>         ret =3D ad_sd_init(&st->sd, indio_dev, spi, &ad7192_sigma_delta_i=
nfo);
>         if (ret)
>                 return ret;
> @@ -1201,6 +1319,7 @@ static const struct of_device_id ad7192_of_match[] =
=3D {
>         { .compatible =3D "adi,ad7190", .data =3D &ad7192_chip_info_tbl[I=
D_AD7190] },
>         { .compatible =3D "adi,ad7192", .data =3D &ad7192_chip_info_tbl[I=
D_AD7192] },
>         { .compatible =3D "adi,ad7193", .data =3D &ad7192_chip_info_tbl[I=
D_AD7193] },
> +       { .compatible =3D "adi,ad7194", .data =3D &ad7192_chip_info_tbl[I=
D_AD7194] },
>         { .compatible =3D "adi,ad7195", .data =3D &ad7192_chip_info_tbl[I=
D_AD7195] },
>         {}
>  };
> @@ -1210,6 +1329,7 @@ static const struct spi_device_id ad7192_ids[] =3D =
{
>         { "ad7190", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7190] },
>         { "ad7192", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7192] },
>         { "ad7193", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7193] },
> +       { "ad7194", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7194] },
>         { "ad7195", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7195] },
>         {}
>  };
> @@ -1226,6 +1346,6 @@ static struct spi_driver ad7192_driver =3D {
>  module_spi_driver(ad7192_driver);
>
>  MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> -MODULE_DESCRIPTION("Analog Devices AD7190, AD7192, AD7193, AD7195 ADC");
> +MODULE_DESCRIPTION("Analog Devices AD7192 and similar ADC");
>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
> --
> 2.34.1
>

