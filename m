Return-Path: <linux-kernel+bounces-93734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2628733EA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7951C21710
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FB2604CD;
	Wed,  6 Mar 2024 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsSsKEQn"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CD35F57A;
	Wed,  6 Mar 2024 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720338; cv=none; b=NV1mofU4/JPlARVdaJvuHnE1o0+pmZfDIu3cBIFPPCrKl2p+GAvJ7ZmcHn2JN6ctu9aECeOlpdQiYN7b+dBNiRrIAoX+y9C/+mInMDJNmk3igNeu4JvsZ0Jj5egL9E1IkpPZCjM93smfq+4w3b0ASZ7oM+pjdN4xBfBg3mwaQvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720338; c=relaxed/simple;
	bh=XMN2ASLPgeYKjHsltUD5egzuzYq61GdgX1KnChl5caE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jHthkB2KgPQQwIUUmMQwI1DaCfVxX73/2VtWtfHh/tVEcMjmnOdG/q1VbS2eydY6TIzwnN8LnDheznTcfXhnrYalTaaVxqSZHl8jOPA/jsyx8mATm0JNuOcGZBvfExTq9ehi8Iotw/fcufNya2elM+k2G6Up8Rcx1yZjFKLL9ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsSsKEQn; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a452877ddcaso433669066b.3;
        Wed, 06 Mar 2024 02:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709720334; x=1710325134; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r2RnXTHq3Gog55ulKqP6SBmztwDFNMNi8Z69LCuOOVk=;
        b=QsSsKEQnreyr6pVLEdhFDiVgQDcIaDwq3uctPo7s5P52s0A8oczhUINU5fnQl7ZLnY
         u1w9x4gaVeWf5dVEIndm0tgffPHdKsJLpWh/3/Rx7GxwiUwCq3h9dXxFEjk+Q2MxOJT3
         XfcCzhPDSmSizNHk0LEIoUqA1MSWsiSc+tyW6MA30zfgUNKuP9Qj8PNj6CCwNNvZWkPN
         ehODmCTpZCxDFd1DBTkPYIGVUPeuA1PE1vLFzcyhTjIHywquGlotlhDF98GER+lw6Lqx
         5U8hc/9Olv/1ydZI14oBPduFXWSNa75uU9tl3d9cTksCF7FQvUjodjW+PQhFEattoYTF
         2x6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709720334; x=1710325134;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r2RnXTHq3Gog55ulKqP6SBmztwDFNMNi8Z69LCuOOVk=;
        b=LwbSbsrf02oUj+Wi5fXnM+cI27VftocX9EVGQyBnKym6kODfaPL+Ygo81wmUIK0d9H
         Au/YtEM62FGZC6k+qRrjYDoQsncPLJlPMHywx6i7UYL+UDsC6g/xBGRr+TamWQaC7djK
         dzHw/5SG0lV399GrSDUfdq6KqS35KKB8sxXvQ7KCiovMAsX6mwicGKHfvdWJmCoyrHar
         RwXDiRkbE1p5QDnINOubscjvpIPQokXmMEt+43/V3/XnNRENaWkTeHWv2DJYYXP62MSC
         OxbV3fBQglHhtcD/QLG+sYdTMMVTIOAnEW7SkXLMbzFzkV/TDBkHnP5sEuFhsCp94oya
         RABA==
X-Forwarded-Encrypted: i=1; AJvYcCWdL5xyu6oF2Gstf8/OuJK+gHOcCY/T445zjC/uhxYUNbUWxSJfG0tIdrUuw7AJwuzPAqAoQfAJ6ML6nA6tLdkVYcokikRAw4/sRulu4F4G0H4OP9SQMu6cABS9qHIZJAkVL/utPktP2Y/Z0WaMKFi25YiR0rYRUvkwblVPnxVVgOcHDg==
X-Gm-Message-State: AOJu0YxAsZyGMBHHDvUqe4xJyeEh3QKvkpo1wcf+ra7o4xgJ3mFykhSs
	BxtxmT+3T+O9FN9vQNefiBF6bG2Pye6Tv2525tvCI+wT812aqNw4
X-Google-Smtp-Source: AGHT+IEQtn8CDjF2xCBC1wH5peul3h6JiqslZcnp10igLfmToZdPLK+FgKiHTXdAMuajhpfXinmqAA==
X-Received: by 2002:a17:906:aa0e:b0:a45:4ba5:2917 with SMTP id ko14-20020a170906aa0e00b00a454ba52917mr5500314ejb.75.1709720333550;
        Wed, 06 Mar 2024 02:18:53 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm4919355ejb.97.2024.03.06.02.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:18:53 -0800 (PST)
Message-ID: <a2e3aa8ace198e339f8e3b00e299e4139d1b8861.camel@gmail.com>
Subject: Re: [PATCH v5 2/2] iio: adc: ad7944: add driver for
 AD7944/AD7985/AD7986
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 06 Mar 2024 11:22:18 +0100
In-Reply-To: <20240304-ad7944-mainline-v5-2-f0a38cea8901@baylibre.com>
References: <20240304-ad7944-mainline-v5-0-f0a38cea8901@baylibre.com>
	 <20240304-ad7944-mainline-v5-2-f0a38cea8901@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-04 at 13:48 -0600, David Lechner wrote:
> This adds a driver for the Analog Devices Inc. AD7944, AD7985, and
> AD7986 ADCs. These are a family of pin-compatible ADCs that can sample
> at rates up to 2.5 MSPS.
>=20
> The initial driver adds support for sampling at lower rates using the
> usual IIO triggered buffer and can handle all 3 possible reference
> voltage configurations.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

LGTM:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



> v5 changes:
> - Dropped "nanoseconds" from comments.
> - Renamed "t" to "timing_spec"
> - Replaced "&spi->dev" with "dev"
> - Fixed logic on optional "ref" regulator
> - Added comment explaining why "cnv" gpio is required
> - Simplified always_turbo assignment
>=20
> v4 changes: none
>=20
> v3 changes:
> - Replaced _sign with _diff in chip info struct to properly handle
> =C2=A0 pseudo-differential vs. true differential chips. Pseudo-differenti=
al chips
> =C2=A0 now just have a voltage0 channel instead of voltage0-voltage1.
> - Fixed not resetting the CNV gpio on error return.
> - Simplified check of adi,spi-mode property now that "multi" is no longer=
 a
> =C2=A0 valid option.
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0 10 ++
> =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/ad7944.c | 416
> +++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A04 files changed, 428 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 35f27504632d..7b1a6f2d0c9c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -448,6 +448,7 @@ R:	David Lechner <dlechner@baylibre.com>
> =C2=A0S:	Supported
> =C2=A0W:	https://ez.analog.com/linux-software-drivers
> =C2=A0F:	Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
> +F:	drivers/iio/adc/ad7944.c
> =C2=A0
> =C2=A0ADAFRUIT MINI I2C GAMEPAD
> =C2=A0M:	Anshul Dalal <anshulusr@gmail.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 0d9282fa67f5..555ac74889f3 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -264,6 +264,16 @@ config AD7923
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the
> =C2=A0	=C2=A0 module will be called ad7923.
> =C2=A0
> +config AD7944
> +	tristate "Analog Devices AD7944 and similar ADCs driver"
> +	depends on SPI
> +	help
> +	=C2=A0 Say yes here to build support for Analog Devices
> +	=C2=A0 AD7944, AD7985, AD7986 ADCs.
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the
> +	=C2=A0 module will be called ad7944
> +
> =C2=A0config AD7949
> =C2=A0	tristate "Analog Devices AD7949 and similar ADCs driver"
> =C2=A0	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index b3c434722364..a0d69b452cca 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_AD7780) +=3D ad7780.o
> =C2=A0obj-$(CONFIG_AD7791) +=3D ad7791.o
> =C2=A0obj-$(CONFIG_AD7793) +=3D ad7793.o
> =C2=A0obj-$(CONFIG_AD7887) +=3D ad7887.o
> +obj-$(CONFIG_AD7944) +=3D ad7944.o
> =C2=A0obj-$(CONFIG_AD7949) +=3D ad7949.o
> =C2=A0obj-$(CONFIG_AD799X) +=3D ad799x.o
> =C2=A0obj-$(CONFIG_AD9467) +=3D ad9467.o
> diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
> new file mode 100644
> index 000000000000..adb007cdd287
> --- /dev/null
> +++ b/drivers/iio/adc/ad7944.c
> @@ -0,0 +1,416 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD7944/85/86 PulSAR ADC family driver.
> + *
> + * Copyright 2024 Analog Devices, Inc.
> + * Copyright 2024 BayLibre, SAS
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/string_helpers.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#define AD7944_INTERNAL_REF_MV		4096
> +
> +struct ad7944_timing_spec {
> +	/* Normal mode max conversion time (t_{CONV}). */
> +	unsigned int conv_ns;
> +	/* TURBO mode max conversion time (t_{CONV}). */
> +	unsigned int turbo_conv_ns;
> +};
> +
> +struct ad7944_adc {
> +	struct spi_device *spi;
> +	/* Chip-specific timing specifications. */
> +	const struct ad7944_timing_spec *timing_spec;
> +	/* GPIO connected to CNV pin. */
> +	struct gpio_desc *cnv;
> +	/* Optional GPIO to enable turbo mode. */
> +	struct gpio_desc *turbo;
> +	/* Indicates TURBO is hard-wired to be always enabled. */
> +	bool always_turbo;
> +	/* Reference voltage (millivolts). */
> +	unsigned int ref_mv;
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	struct {
> +		union {
> +			u16 u16;
> +			u32 u32;
> +		} raw;
> +		u64 timestamp __aligned(8);
> +	 } sample __aligned(IIO_DMA_MINALIGN);
> +};
> +
> +static const struct ad7944_timing_spec ad7944_timing_spec =3D {
> +	.conv_ns =3D 420,
> +	.turbo_conv_ns =3D 320,
> +};
> +
> +static const struct ad7944_timing_spec ad7986_timing_spec =3D {
> +	.conv_ns =3D 500,
> +	.turbo_conv_ns =3D 400,
> +};
> +
> +struct ad7944_chip_info {
> +	const char *name;
> +	const struct ad7944_timing_spec *timing_spec;
> +	const struct iio_chan_spec channels[2];
> +};
> +
> +/*
> + * AD7944_DEFINE_CHIP_INFO - Define a chip info structure for a specific=
 chip
> + * @_name: The name of the chip
> + * @_ts: The timing specification for the chip
> + * @_bits: The number of bits in the conversion result
> + * @_diff: Whether the chip is true differential or not
> + */
> +#define AD7944_DEFINE_CHIP_INFO(_name, _ts, _bits, _diff)		\
> +static const struct ad7944_chip_info _name##_chip_info =3D {		\
> +	.name =3D
> #_name,							\
> +	.timing_spec =3D &_ts##_timing_spec,				\
> +	.channels =3D {							\
> +		{							\
> +			.type =3D IIO_VOLTAGE,				\
> +			.indexed =3D 1,					\
> +			.differential =3D _diff,				\
> +			.channel =3D 0,					\
> +			.channel2 =3D _diff ? 1 : 0,			\
> +			.scan_index =3D 0,				\
> +			.scan_type.sign =3D _diff ? 's' : 'u',		\
> +			.scan_type.realbits =3D _bits,			\
> +			.scan_type.storagebits =3D _bits > 16 ? 32 : 16,	\
> +			.scan_type.endianness =3D IIO_CPU,		\
> +			.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW)	\
> +					| BIT(IIO_CHAN_INFO_SCALE),	\
> +		},							\
> +		IIO_CHAN_SOFT_TIMESTAMP(1),				\
> +	},								\
> +}
> +
> +/* pseudo-differential with ground sense */
> +AD7944_DEFINE_CHIP_INFO(ad7944, ad7944, 14, 0);
> +AD7944_DEFINE_CHIP_INFO(ad7985, ad7944, 16, 0);
> +/* fully differential */
> +AD7944_DEFINE_CHIP_INFO(ad7986, ad7986, 18, 1);
> +
> +/*
> + * ad7944_4wire_mode_conversion - Perform a 4-wire mode conversion and
> acquisition
> + * @adc: The ADC device structure
> + * @chan: The channel specification
> + * Return: 0 on success, a negative error code on failure
> + *
> + * Upon successful return adc->sample.raw will contain the conversion re=
sult.
> + */
> +static int ad7944_4wire_mode_conversion(struct ad7944_adc *adc,
> +					const struct iio_chan_spec *chan)
> +{
> +	unsigned int t_conv_ns =3D adc->always_turbo ? adc->timing_spec-
> >turbo_conv_ns
> +						=C2=A0=C2=A0 : adc->timing_spec-
> >conv_ns;
> +	struct spi_transfer xfers[] =3D {
> +		{
> +			/*
> +			 * NB: can get better performance from some SPI
> +			 * controllers if we use the same bits_per_word
> +			 * in every transfer.
> +			 */
> +			.bits_per_word =3D chan->scan_type.realbits,
> +			/*
> +			 * CS has to be high for full conversion time to
> avoid
> +			 * triggering the busy indication.
> +			 */
> +			.cs_off =3D 1,
> +			.delay =3D {
> +				.value =3D t_conv_ns,
> +				.unit =3D SPI_DELAY_UNIT_NSECS,
> +			},
> +
> +		},
> +		{
> +			.rx_buf =3D &adc->sample.raw,
> +			.len =3D BITS_TO_BYTES(chan->scan_type.storagebits),
> +			.bits_per_word =3D chan->scan_type.realbits,
> +		},
> +	};
> +	int ret;
> +
> +	/*
> +	 * In 4-wire mode, the CNV line is held high for the entire
> conversion
> +	 * and acquisition process.
> +	 */
> +	gpiod_set_value_cansleep(adc->cnv, 1);
> +	ret =3D spi_sync_transfer(adc->spi, xfers, ARRAY_SIZE(xfers));
> +	gpiod_set_value_cansleep(adc->cnv, 0);
> +
> +	return ret;
> +}
> +
> +static int ad7944_single_conversion(struct ad7944_adc *adc,
> +				=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> +				=C2=A0=C2=A0=C2=A0 int *val)
> +{
> +	int ret;
> +
> +	ret =3D ad7944_4wire_mode_conversion(adc, chan);
> +	if (ret)
> +		return ret;
> +
> +	if (chan->scan_type.storagebits > 16)
> +		*val =3D adc->sample.raw.u32;
> +	else
> +		*val =3D adc->sample.raw.u16;
> +
> +	if (chan->scan_type.sign =3D=3D 's')
> +		*val =3D sign_extend32(*val, chan->scan_type.realbits - 1);
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad7944_read_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> +			=C2=A0=C2=A0 int *val, int *val2, long info)
> +{
> +	struct ad7944_adc *adc =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D ad7944_single_conversion(adc, chan, val);
> +		iio_device_release_direct_mode(indio_dev);
> +		return ret;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val =3D adc->ref_mv;
> +
> +			if (chan->scan_type.sign =3D=3D 's')
> +				*val2 =3D chan->scan_type.realbits - 1;
> +			else
> +				*val2 =3D chan->scan_type.realbits;
> +
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info ad7944_iio_info =3D {
> +	.read_raw =3D &ad7944_read_raw,
> +};
> +
> +static irqreturn_t ad7944_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf =3D p;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct ad7944_adc *adc =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D ad7944_4wire_mode_conversion(adc, &indio_dev->channels[0]);
> +	if (ret)
> +		goto out;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &adc->sample.raw,
> +					=C2=A0=C2=A0 pf->timestamp);
> +
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const char * const ad7944_power_supplies[] =3D {
> +	"avdd",	"dvdd",	"bvdd", "vio"
> +};
> +
> +static void ad7944_ref_disable(void *ref)
> +{
> +	regulator_disable(ref);
> +}
> +
> +static int ad7944_probe(struct spi_device *spi)
> +{
> +	const struct ad7944_chip_info *chip_info;
> +	struct device *dev =3D &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad7944_adc *adc;
> +	bool have_refin =3D false;
> +	struct regulator *ref;
> +	int ret;
> +
> +	/*
> +	 * driver currently only supports the conventional "4-wire" mode and
> +	 * not other special wiring configurations.
> +	 */
> +	if (device_property_present(dev, "adi,spi-mode"))
> +		return dev_err_probe(dev, -EINVAL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "adi,spi-mode is not currently
> supported\n");
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	adc =3D iio_priv(indio_dev);
> +	adc->spi =3D spi;
> +
> +	chip_info =3D spi_get_device_match_data(spi);
> +	if (!chip_info)
> +		return dev_err_probe(dev, -EINVAL, "no chip info\n");
> +
> +	adc->timing_spec =3D chip_info->timing_spec;
> +
> +	/*
> +	 * Some chips use unusual word sizes, so check now instead of waiting
> +	 * for the first xfer.
> +	 */
> +	if (!spi_is_bpw_supported(spi, chip_info-
> >channels[0].scan_type.realbits))
> +		return dev_err_probe(dev, -EINVAL,
> +				"SPI host does not support %d bits per
> word\n",
> +				chip_info->channels[0].scan_type.realbits);
> +
> +	ret =3D devm_regulator_bulk_get_enable(dev,
> +					=C2=A0=C2=A0=C2=A0=C2=A0
> ARRAY_SIZE(ad7944_power_supplies),
> +					=C2=A0=C2=A0=C2=A0=C2=A0 ad7944_power_supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get and enable supplies\n");
> +
> +	/*
> +	 * Sort out what is being used for the reference voltage. Options
> are:
> +	 * - internal reference: neither REF or REFIN is connected
> +	 * - internal reference with external buffer: REF not connected,
> REFIN
> +	 *=C2=A0=C2=A0 is connected
> +	 * - external reference: REF is connected, REFIN is not connected
> +	 */
> +
> +	ref =3D devm_regulator_get_optional(dev, "ref");
> +	if (IS_ERR(ref)) {
> +		if (PTR_ERR(ref) !=3D -ENODEV)
> +			return dev_err_probe(dev, PTR_ERR(ref),
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get REF supply\n");
> +
> +		ref =3D NULL;
> +	}
> +
> +	ret =3D devm_regulator_get_enable_optional(dev, "refin");
> +	if (ret =3D=3D 0)
> +		have_refin =3D true;
> +	else if (ret !=3D -ENODEV)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get and enable REFIN
> supply\n");
> +
> +	if (have_refin && ref)
> +		return dev_err_probe(dev, -EINVAL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "cannot have both refin and ref
> supplies\n");
> +
> +	if (ref) {
> +		ret =3D regulator_enable(ref);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "failed to enable REF
> supply\n");
> +
> +		ret =3D devm_add_action_or_reset(dev, ad7944_ref_disable, ref);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regulator_get_voltage(ref);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get REF voltage\n");
> +
> +		/* external reference */
> +		adc->ref_mv =3D ret / 1000;
> +	} else {
> +		/* internal reference */
> +		adc->ref_mv =3D AD7944_INTERNAL_REF_MV;
> +	}
> +
> +	/*
> +	 * CNV gpio is required in 4-wire mode which is the only currently
> +	 * supported mode.
> +	 */
> +	adc->cnv =3D devm_gpiod_get(dev, "cnv", GPIOD_OUT_LOW);
> +	if (IS_ERR(adc->cnv))
> +		return dev_err_probe(dev, PTR_ERR(adc->cnv),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get CNV GPIO\n");
> +
> +	adc->turbo =3D devm_gpiod_get_optional(dev, "turbo", GPIOD_OUT_LOW);
> +	if (IS_ERR(adc->turbo))
> +		return dev_err_probe(dev, PTR_ERR(adc->turbo),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get TURBO GPIO\n");
> +
> +	adc->always_turbo =3D device_property_present(dev, "adi,always-turbo");
> +
> +	if (adc->turbo && adc->always_turbo)
> +		return dev_err_probe(dev, -EINVAL,
> +			"cannot have both turbo-gpios and adi,always-
> turbo\n");
> +
> +	indio_dev->name =3D chip_info->name;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->info =3D &ad7944_iio_info;
> +	indio_dev->channels =3D chip_info->channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(chip_info->channels);
> +
> +	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_pollfunc_store_time,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad7944_trigger_handler, NULL);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id ad7944_of_match[] =3D {
> +	{ .compatible =3D "adi,ad7944", .data =3D &ad7944_chip_info },
> +	{ .compatible =3D "adi,ad7985", .data =3D &ad7985_chip_info },
> +	{ .compatible =3D "adi,ad7986", .data =3D &ad7986_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad7944_of_match);
> +
> +static const struct spi_device_id ad7944_spi_id[] =3D {
> +	{ "ad7944", (kernel_ulong_t)&ad7944_chip_info },
> +	{ "ad7985", (kernel_ulong_t)&ad7985_chip_info },
> +	{ "ad7986", (kernel_ulong_t)&ad7986_chip_info },
> +	{ }
> +
> +};
> +MODULE_DEVICE_TABLE(spi, ad7944_spi_id);
> +
> +static struct spi_driver ad7944_driver =3D {
> +	.driver =3D {
> +		.name =3D "ad7944",
> +		.of_match_table =3D ad7944_of_match,
> +	},
> +	.probe =3D ad7944_probe,
> +	.id_table =3D ad7944_spi_id,
> +};
> +module_spi_driver(ad7944_driver);
> +
> +MODULE_AUTHOR("David Lechner <dlechner@baylibre.com>");
> +MODULE_DESCRIPTION("Analog Devices AD7944 PulSAR ADC family driver");
> +MODULE_LICENSE("GPL");
>=20


