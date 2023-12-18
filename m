Return-Path: <linux-kernel+bounces-2889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9538163CF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 01:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0DD41C21344
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620FB1119;
	Mon, 18 Dec 2023 00:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fQIwRHTn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA46810
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 00:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cc6863d43aso8273051fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 16:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702859445; x=1703464245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2IWIBXQVE1xIV7+qhqQmmn3peQ6tcaW9YYepMXaAic=;
        b=fQIwRHTnFM+iihbCZha04bswiCYewC4rgyxlu2VupZJcY1paPZriSbgCNLE+KKDGXi
         116fEdvYhXT1wNXPtl//Fs5J9SMtZryPKg9fdlpTRvTzS2Woulr5IobNXhSM+Cs6dJo6
         pGk3nq5Kq4qtM3IgkPQ81hcw4T8kztJrLy4DKZZ3+oqL3NWovZkCpvMpnSbyVnVyB/js
         r0thxsh37fVQAbagxEENmPtwzvISW6k8Z3kQGCoeKn504mPDdeiJsp9Tdh0qgzZrnrd2
         5JR0m/DB1K0wwITzJKFwcZXv2uVtdeubrXoVDCibemgcrgvBiOhsOxYcFG6/oGNmPISN
         d10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702859445; x=1703464245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2IWIBXQVE1xIV7+qhqQmmn3peQ6tcaW9YYepMXaAic=;
        b=C5xt8wB3YqIgPeWsiFBvbflD9I4A+zRHetfwTrUrF9hm11miNNuRyE96AbDmzLpgft
         5DNGI/p3pYa5tHPrijrULaIbPJNIDEMXflCy+WMel9G2DT6bcOuX2XBuxjByrCtHr+/f
         fGGf594TD4MCe/RrDoIbEQVgyNOI2OPsBFWs1mxq8VuIwt61mICADRaUaH28VD25NnMh
         1xdHkSw/u9NAlUQioVYRVaTlWkuK39hTJMBYDRX9HKIx9mILylUAQB76Fs4eqgG4u6KF
         kPK6oXROM8ZI8R/ALEyIcT6AThBrJSyJaENffXhp8aIzhpt1UrObNTsVizUPEiIcRdyS
         xODA==
X-Gm-Message-State: AOJu0Yz+L0A7JjmHb+9c9+nwdFOs1sArBVlPdAvZIgJvIsLVuMj+T5kr
	YaZhc8xrog+8UAlcxCHPi2mkdC7eyMP9QJcr/R/+Gw==
X-Google-Smtp-Source: AGHT+IGdKJkxus7eb0DK+8oDw/+yvaTv74BsqAy33DQNIQcKSkPOzS3SZ6VQpDK71DYsfmqqQFYbm+tCpyD+T17AwF4=
X-Received: by 2002:a05:651c:554:b0:2cb:4e98:2641 with SMTP id
 q20-20020a05651c055400b002cb4e982641mr6300660ljp.74.1702859445331; Sun, 17
 Dec 2023 16:30:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1702746240.git.marcelo.schmitt1@gmail.com> <24a9f1bb721e66df65e36797b0c3fd2ca1f95227.1702746240.git.marcelo.schmitt1@gmail.com>
In-Reply-To: <24a9f1bb721e66df65e36797b0c3fd2ca1f95227.1702746240.git.marcelo.schmitt1@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 17 Dec 2023 18:30:34 -0600
Message-ID: <CAMknhBFzsRnroXrrb84ruZctdMnMn3g3h6RavhFPhFN_JonDJw@mail.gmail.com>
Subject: Re: [PATCH v4 15/15] iio: adc: ad7091r: Allow users to configure
 device events
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com, 
	lukas.bulwahn@gmail.com, paul.cercueil@analog.com, 
	Michael.Hennerich@analog.com, lars@metafoo.de, jic23@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	dan.carpenter@linaro.org, marcelo.schmitt1@gmail.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 11:52=E2=80=AFAM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> Implement event configuration callbacks allowing users to read/write
> event thresholds and enable/disable event generation.
>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> This is from a review suggestion David made on v3 [1].
>
> Is this the case for a Suggested-by tag?
>
> [1]: https://lore.kernel.org/linux-iio/CAMknhBFPbAqp4-AQdmbp+VRW-Ksk1PxaL=
CG+3n=3DZk4gyStqhgw@mail.gmail.com/#t
>
>  drivers/iio/adc/ad7091r-base.c | 117 +++++++++++++++++++++++++++++++--
>  1 file changed, 113 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-bas=
e.c
> index 57355ca157a1..64e8baeff258 100644
> --- a/drivers/iio/adc/ad7091r-base.c
> +++ b/drivers/iio/adc/ad7091r-base.c
> @@ -20,19 +20,18 @@ const struct iio_event_spec ad7091r_events[] =3D {
>         {
>                 .type =3D IIO_EV_TYPE_THRESH,
>                 .dir =3D IIO_EV_DIR_RISING,
> -               .mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
> -                                BIT(IIO_EV_INFO_ENABLE),
> +               .mask_separate =3D BIT(IIO_EV_INFO_VALUE),
>         },
>         {
>                 .type =3D IIO_EV_TYPE_THRESH,
>                 .dir =3D IIO_EV_DIR_FALLING,
> -               .mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
> -                                BIT(IIO_EV_INFO_ENABLE),
> +               .mask_separate =3D BIT(IIO_EV_INFO_VALUE),
>         },
>         {
>                 .type =3D IIO_EV_TYPE_THRESH,
>                 .dir =3D IIO_EV_DIR_EITHER,
>                 .mask_separate =3D BIT(IIO_EV_INFO_HYSTERESIS),
> +               .mask_shared_by_all =3D BIT(IIO_EV_INFO_ENABLE),
>         },
>  };
>  EXPORT_SYMBOL_NS_GPL(ad7091r_events, IIO_AD7091R);
> @@ -128,8 +127,118 @@ static int ad7091r_read_raw(struct iio_dev *iio_dev=
,
>         return ret;
>  }
>
> +static int ad7091r_read_event_config(struct iio_dev *indio_dev,
> +                                    const struct iio_chan_spec *chan,
> +                                    enum iio_event_type type,
> +                                    enum iio_event_direction dir)
> +{
> +       struct ad7091r_state *st =3D iio_priv(indio_dev);
> +       unsigned int alert;
> +       int ret;
> +
> +       ret =3D regmap_read(st->map, AD7091R_REG_CONF, &alert);
> +       if (ret)
> +               return ret;
> +
> +       return !!(FIELD_GET(AD7091R_REG_CONF_ALERT_EN, alert));
> +}

According to the datasheet, bit 4 of the config register is for
selecting the function of the ALERT/BUSY/GPO0 pin as either ALERT/BUSY
or GPIO, so this sounds like a pinmux function rather than an event
enable function.

context: `#define AD7091R_REG_CONF_ALERT_EN   BIT(4)` in a previous patch


> +
> +static int ad7091r_write_event_config(struct iio_dev *indio_dev,
> +                                     const struct iio_chan_spec *chan,
> +                                     enum iio_event_type type,
> +                                     enum iio_event_direction dir, int s=
tate)
> +{
> +       struct ad7091r_state *st =3D iio_priv(indio_dev);
> +
> +       /*
> +        * Whenever alerts are enabled, every ADC conversion will generat=
e
> +        * an alert if the conversion result for a particular channel fal=
ls
> +        * bellow the respective low limit register or above the respecti=
ve
> +        * high limit register.
> +        * We can enable or disable all alerts by writing to the config r=
eg.
> +        */
> +       return regmap_update_bits(st->map, AD7091R_REG_CONF,
> +                                 AD7091R_REG_CONF_ALERT_EN, state << 4);
> +}
> +
> +static int ad7091r_read_event_value(struct iio_dev *indio_dev,
> +                                   const struct iio_chan_spec *chan,
> +                                   enum iio_event_type type,
> +                                   enum iio_event_direction dir,
> +                                   enum iio_event_info info, int *val, i=
nt *val2)
> +{
> +       struct ad7091r_state *st =3D iio_priv(indio_dev);
> +       int ret;
> +
> +       switch (info) {
> +       case IIO_EV_INFO_VALUE:
> +               switch (dir) {
> +               case IIO_EV_DIR_RISING:
> +                       ret =3D regmap_read(st->map,
> +                                         AD7091R_REG_CH_HIGH_LIMIT(chan-=
>channel),
> +                                         val);
> +                       if (ret)
> +                               return ret;
> +                       return IIO_VAL_INT;
> +               case IIO_EV_DIR_FALLING:
> +                       ret =3D regmap_read(st->map,
> +                                         AD7091R_REG_CH_LOW_LIMIT(chan->=
channel),
> +                                         val);
> +                       if (ret)
> +                               return ret;
> +                       return IIO_VAL_INT;
> +               default:
> +                       return -EINVAL;
> +               }
> +       case IIO_EV_INFO_HYSTERESIS:
> +               ret =3D regmap_read(st->map,
> +                                 AD7091R_REG_CH_HYSTERESIS(chan->channel=
),
> +                                 val);
> +               if (ret)
> +                       return ret;
> +               return IIO_VAL_INT;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int ad7091r_write_event_value(struct iio_dev *indio_dev,
> +                                    const struct iio_chan_spec *chan,
> +                                    enum iio_event_type type,
> +                                    enum iio_event_direction dir,
> +                                    enum iio_event_info info, int val, i=
nt val2)
> +{
> +       struct ad7091r_state *st =3D iio_priv(indio_dev);
> +
> +       switch (info) {
> +       case IIO_EV_INFO_VALUE:
> +               switch (dir) {
> +               case IIO_EV_DIR_RISING:
> +                       return regmap_write(st->map,
> +                                           AD7091R_REG_CH_HIGH_LIMIT(cha=
n->channel),
> +                                           val);
> +               case IIO_EV_DIR_FALLING:
> +                       return regmap_write(st->map,
> +                                           AD7091R_REG_CH_LOW_LIMIT(chan=
->channel),
> +                                           val);

These registers are limited to 12-bit values. Do we need to check val
first and return -EINVAL if out of range?

> +               default:
> +                       return -EINVAL;
> +               }
> +       case IIO_EV_INFO_HYSTERESIS:
> +               return regmap_write(st->map,
> +                                   AD7091R_REG_CH_HYSTERESIS(chan->chann=
el),
> +                                   val);
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
>  static const struct iio_info ad7091r_info =3D {
>         .read_raw =3D ad7091r_read_raw,
> +       .read_event_config =3D &ad7091r_read_event_config,
> +       .write_event_config =3D &ad7091r_write_event_config,
> +       .read_event_value =3D &ad7091r_read_event_value,
> +       .write_event_value =3D &ad7091r_write_event_value,
>  };
>
>  static irqreturn_t ad7091r_event_handler(int irq, void *private)
> --
> 2.42.0
>

