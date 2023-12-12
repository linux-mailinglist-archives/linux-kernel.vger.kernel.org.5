Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6866980EFDB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376505AbjLLPQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376469AbjLLPQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:16:49 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988F0CA;
        Tue, 12 Dec 2023 07:16:54 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40b5155e154so67372105e9.3;
        Tue, 12 Dec 2023 07:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702394213; x=1702999013; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Puomzrjt5SUW5WOIbHx2z4P43aqw9YO10Gcjn/mwTFU=;
        b=aYUyreq7AnDYnOEQo002RNK4tVWnjMpElzIUUVrPIcnjmkuotJRkNcP270yn9cbrYZ
         o4wh01ZSSs7f/Z8aBQpfI6YIS7tqpA9EzyxjueyReapnFoWMJbaESvOJvkyaFMaF1xvg
         6PFteJMXl2N4pHCcGPzCN1viU2roH3myDW2K5Rsr4Mq+PXfr61Wobvh2ZPgeB3Ieeq0I
         BcheSHkG3XswAlRAvPUVz2U8aqWRFHCwVGWakPqyVAPy1u4pzRv0aN8OJ9jlw74DXmmQ
         90mI1nm43eEM5Swr/A7of2vOCy2K4AtLMY7mFthOMhgjyqNV+qP8jHpTKOPclzXLEiiU
         saoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702394213; x=1702999013;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Puomzrjt5SUW5WOIbHx2z4P43aqw9YO10Gcjn/mwTFU=;
        b=Uqwgy2wV2zl66HmNQKqXqVkgkQOvevOehGd4Wj8Qxi0vdFiMRKHl8dL2dwzE29t20P
         tdCoPHHu8C2OiZkBsFdET+f/9pMZOTrid/jQOU6OckaXnZ+hO7OX+mSsFL6OH6pA7HTD
         KiKtr0UxUux8PZxDQZpip4ig57l0vKJ0PLoJPKYx0zOr15uV7TOj53ssxB2WLLb+dedD
         KbsVfLUUt9zA33H1wlHoGH87qtOu4OVul4KtquQM79W525LHV2hKKYoSPU2rTQMWqF9j
         8zfXtM8hVpdaXw2mY32TTGEXDe0zfc4cpK517zYhF+yt7t6U4zn0tVVfclx1YCG0pLAq
         y+lA==
X-Gm-Message-State: AOJu0Yw1ziniMVqJmGNNQjtAWaie/GJ5anJmgmQbgH6esELjztFauQOR
        3OTfa/LS49nOzeyd8pHKeAQ=
X-Google-Smtp-Source: AGHT+IGlE0Fq6BbAEeOu6lKLZtxzcjQv99zNrO+z5y0JuNw3rcAs90ZaReQEUxtLM4cBKsDFaA379w==
X-Received: by 2002:a05:600c:4f4d:b0:40b:5e4a:408a with SMTP id m13-20020a05600c4f4d00b0040b5e4a408amr2991203wmq.170.1702394212695;
        Tue, 12 Dec 2023 07:16:52 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c311100b0040c4535f1a2sm8960220wmo.39.2023.12.12.07.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 07:16:52 -0800 (PST)
Message-ID: <c21634252fec82dadd27b1bff69b24d3384acf00.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad7380: new driver for AD7380 ADCs
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Stefan Popa <stefan.popa@analog.com>
Date:   Tue, 12 Dec 2023 16:19:56 +0100
In-Reply-To: <20231208-ad7380-mainline-v1-2-2b33fe2f44ae@baylibre.com>
References: <20231208-ad7380-mainline-v1-0-2b33fe2f44ae@baylibre.com>
         <20231208-ad7380-mainline-v1-2-2b33fe2f44ae@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

minor stuff from me...

On Fri, 2023-12-08 at 09:51 -0600, David Lechner wrote:
> This adds a new driver for the AD7380 family ADCs.
>=20
> The driver currently implements basic support for the AD7380, AD7381,
> AD7383, and AD7384 2-channel differential ADCs. Support for additional
> single-ended and 4-channel chips that use the same register map as well
> as additional features of the chip will be added in future patches.
>=20
> Co-developed-by: Stefan Popa <stefan.popa@analog.com>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0 16 ++
> =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/ad7380.c | 467
> +++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A04 files changed, 485 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e2a998be5879..5a54620a31b8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -438,6 +438,7 @@ S:	Supported
> =C2=A0W:=09
> https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/ad=
738x
> =C2=A0W:	https://ez.analog.com/linux-software-drivers
> =C2=A0F:	Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> +F:	drivers/iio/adc/ad7380.c
> =C2=A0
> =C2=A0AD7877 TOUCHSCREEN DRIVER
> =C2=A0M:	Michael Hennerich <michael.hennerich@analog.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 35f9867da12c..cbfd626712e3 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -122,6 +122,22 @@ config AD7298
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the
> =C2=A0	=C2=A0 module will be called ad7298.
> =C2=A0
> +config AD7380
> +	tristate "Analog Devices AD7380 ADC driver"
> +	depends on SPI_MASTER
> +	select IIO_BUFFER
> +	select IIO_TRIGGER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	=C2=A0 AD7380 is a family of simultaneous sampling ADCs that share the
> same
> +	=C2=A0 SPI register map and have similar pinouts.
> +
> +	=C2=A0 Say yes here to build support for Analog Devices AD7380 ADC and
> +	=C2=A0 similar chips.
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the module wi=
ll
> be
> +	=C2=A0 called ad7380.
> +
> =C2=A0config AD7476
> =C2=A0	tristate "Analog Devices AD7476 1-channel ADCs driver and other
> similar devices from AD and TI"
> =C2=A0	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index bee11d442af4..e046d8004f41 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_AD7291) +=3D ad7291.o
> =C2=A0obj-$(CONFIG_AD7292) +=3D ad7292.o
> =C2=A0obj-$(CONFIG_AD7298) +=3D ad7298.o
> =C2=A0obj-$(CONFIG_AD7923) +=3D ad7923.o
> +obj-$(CONFIG_AD7476) +=3D ad7380.o
> =C2=A0obj-$(CONFIG_AD7476) +=3D ad7476.o
> =C2=A0obj-$(CONFIG_AD7606_IFACE_PARALLEL) +=3D ad7606_par.o
> =C2=A0obj-$(CONFIG_AD7606_IFACE_SPI) +=3D ad7606_spi.o
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> new file mode 100644
> index 000000000000..6a5ec59bd1fd
> --- /dev/null
> +++ b/drivers/iio/adc/ad7380.c
> @@ -0,0 +1,467 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD738x Simultaneous Sampling SAR ADCs
> + *
> + * Copyright 2017 Analog Devices Inc.
> + * Copyright 2023 BayLibre, SAS
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/sysfs.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
>=20

...

> +
> +static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 u32 writeval, u32 *readval)
> +{
> +	struct ad7380_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +

potential controversial take: do we really need locking in here? regmap alr=
eady
has it's own lock (I think you're not disabling it) and if someone plays wi=
th
registers it shouldn't while buffering, well... This is a debug interface s=
o I
would probably not worry much. One could anyways for write stuff by going
directly to regmap :)

That said, fine to be as-is from my side (just wanted to take it out of my
system :))...

> +	if (readval)
> +		ret =3D regmap_read(st->regmap, reg, readval);
> +	else
> +		ret =3D regmap_write(st->regmap, reg, writeval);
> +
> +	iio_device_release_direct_mode(indio_dev);
> +
> +	return ret;
> +}
> +
> +static irqreturn_t ad7380_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf =3D p;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct ad7380_state *st =3D iio_priv(indio_dev);
> +	struct spi_transfer xfer =3D {
> +		.bits_per_word =3D st->chip_info-
> >channels[0].scan_type.realbits,
> +		.len =3D 4,
> +		.rx_buf =3D &st->scan_data,
> +	};
> +	int ret;
> +
> +	ret =3D spi_sync_transfer(st->spi, &xfer, 1);
> +
> +	if (ret =3D=3D 0)
> +		iio_push_to_buffers_with_timestamp(indio_dev, &st->scan_data,
> +						=C2=A0=C2=A0 pf->timestamp);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ad7380_read_direct(struct ad7380_state *st,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, int =
*val)
> +{
> +	struct spi_transfer xfers[] =3D {
> +		/* toggle CS (no data xfer) to trigger a conversion */
> +		{
> +			.speed_hz =3D AD7380_REG_WR_SPEED_HZ,
> +			.bits_per_word =3D chan->scan_type.realbits,
> +			.delay =3D {
> +				.value =3D 190, /* t[CONVERT] */
> +				.unit =3D SPI_DELAY_UNIT_NSECS,
> +			},
> +			.cs_change =3D 1,
> +			.cs_change_delay =3D {
> +				.value =3D 10, /* t[CSH] */
> +				.unit =3D SPI_DELAY_UNIT_NSECS,
> +			},
> +		},
> +		/* then read both channels */
> +		{
> +			.speed_hz =3D AD7380_REG_WR_SPEED_HZ,
> +			.bits_per_word =3D chan->scan_type.realbits,
> +			.rx_buf =3D &st->rx[0],
> +			.len =3D 4,
> +		},
> +	};
> +	int ret;
> +
> +	ret =3D spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	*val =3D sign_extend32(st->rx[chan->scan_index],
> +			=C2=A0=C2=A0=C2=A0=C2=A0 chan->scan_type.realbits - 1);
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad7380_read_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0 int *val, int *val2, long info)
> +{
> +	struct ad7380_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D ad7380_read_direct(st, chan, val);
> +		iio_device_release_direct_mode(indio_dev);
> +
> +		return ret;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (st->vref) {
> +			ret =3D regulator_get_voltage(st->vref);

nit: I wonder how likely it is for vref to change at runtime...

> +			if (ret < 0)
> +				return ret;
> +
> +			*val =3D ret / 1000;
> +		} else {
> +			*val =3D AD7380_INTERNAL_REF_MV;
> +		}
> +
> +		*val2 =3D chan->scan_type.realbits;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info ad7380_info =3D {
> +	.read_raw =3D &ad7380_read_raw,
> +	.debugfs_reg_access =3D &ad7380_debugfs_reg_access,
> +};
> +
> +static int ad7380_init(struct ad7380_state *st)
> +{
> +	int ret;
> +
> +	/* perform hard reset */
> +	ret =3D regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
> +				 AD7380_CONFIG2_RESET,
> +				 FIELD_PREP(AD7380_CONFIG2_RESET,
> +					=C2=A0=C2=A0=C2=A0 AD7380_CONFIG2_RESET_HARD));
> +	if (ret < 0)
> +		return ret;
> +
> +
> +	/* select internal or external reference voltage */
> +	ret =3D regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
> +				 AD7380_CONFIG1_REFSEL,
> +				 FIELD_PREP(AD7380_CONFIG1_REFSEL, !!st-
> >vref));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* SPI 1-wire mode */
> +	return regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
> +				=C2=A0 AD7380_CONFIG2_SDO,
> +				=C2=A0 FIELD_PREP(AD7380_CONFIG2_SDO, 1));
> +}
> +
> +static void ad7380_release_regulator(void *p)
> +{
> +	struct regulator *reg =3D p;
> +
> +	regulator_disable(reg);
> +}
> +
> +static int ad7380_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ad7380_state *st;
> +	const char *str_val;
> +	int ret;
> +
> +	ret =3D device_property_read_string(&spi->dev, "adi,sdo-mode",
> &str_val);
> +	if (ret < 0)
> +		return dev_err_probe(&spi->dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to read adi,sdo-mode
> property\n");
> +
> +	if (strcmp(str_val, "1-wire"))
> +		return dev_err_probe(&spi->dev, -EINVAL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Only 1-wire SDO is supported\n");
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +	st->spi =3D spi;
> +	st->chip_info =3D spi_get_device_match_data(spi);
> +

if (!st->chip_info) ?

> +	st->vref =3D devm_regulator_get_optional(&spi->dev, "refio");
> +	if (IS_ERR(st->vref)) {
> +		/*
> +		 * If there is no REFIO supply, then it means that we are
> using
> +		 * the internal 2.5V reference.
> +		 */
> +		if (PTR_ERR(st->vref) =3D=3D -ENODEV)
> +			st->vref =3D NULL;
> +		else
> +			return dev_err_probe(&spi->dev, PTR_ERR(st->vref),
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get refio
> regulator\n");
> +	}
> +
> +	if (st->vref) {
> +		ret =3D regulator_enable(st->vref);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D devm_add_action_or_reset(&spi->dev,
> ad7380_release_regulator,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->vref);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	st->regmap =3D devm_regmap_init(&spi->dev, NULL, st,
> &ad7380_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to allocate register map\n");
> +

Could we instead have a custom regmap_bus instead of bypass regmap with
reg_read() and reg_write()?
> +
> +	indio_dev->channels =3D st->chip_info->channels;
> +	indio_dev->num_channels =3D st->chip_info->num_channels;
> +	indio_dev->dev.parent =3D &spi->dev;

no need to assign parent (the core does it for you)...

- Nuno S=C3=A1

