Return-Path: <linux-kernel+bounces-56282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9CC84C848
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B8B1F24E86
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4B024B2A;
	Wed,  7 Feb 2024 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKFKh2K1"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FDE28DB3;
	Wed,  7 Feb 2024 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707300449; cv=none; b=GHbCOhrQHC0Dg46a/FEgolsO3Bg+Lt9gPCVeqbRTC3Pqt4ttt74LXgYqU4BVAkmg4Tab7EJdBIKDPU3U5BtJwDYF2LHcDtN3faNJ2A+i+RKqxIdW6V6QagqiBAydGn3EI+i3q5qfdXuo+TXKx7Z1EkbMP9hm4FRUMxc717GInUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707300449; c=relaxed/simple;
	bh=YU4n9ZID1r/Mh8EPIjWaqePEReRmpswBCgTPXNg96T8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tmhYNws/FEgV5VUU9qiTDnmbAh6fgAerm9gRRmW2+EMPbAN5tS9WvGZ6fNI4Jn3OYClnhsUIJSCLRyYACu4jecNMzQn5KrmDx2hQHfWM2SUjKekinJ09gX8j1QDkDufvnCPWr0td9MdnOJuLXVcvk2LLaJzI0VGH37p96z2brL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKFKh2K1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so56489066b.1;
        Wed, 07 Feb 2024 02:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707300446; x=1707905246; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qtFJspFDeXXLXa8scsO4YdjHmItQbAvcjZq/GbcC1VM=;
        b=NKFKh2K1221wplJ1m/VXbmEBcQ4NTjI8ly4qMY7vPHE1k1TN+Eq6FqZ0nJKtZG72cw
         82+/SU8NqT4TCNRhh5zMxP0WYM+NLoGtgxnkGnAvouiNBhH6bjI8EaZ3cM0w6ZWThvLV
         Uv03CThM9DlmfpiXT3HBOtH/RmJNCK5JTZz0a582KAZSN8o0pFigGZoK75tfX6EYvGnC
         sCPhSR4zfEH+CNmupSBJMDnVmxfKYBn01oL9CImmnWgXoktjO5A+1dJLXWBXx8FMNSVV
         GXveGWvN2k2Egqr9P/2XXZGktC9qkUzj/5ZzawvPseE6B40kJkvQfpkqpiTJppK/2XcP
         UbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707300446; x=1707905246;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qtFJspFDeXXLXa8scsO4YdjHmItQbAvcjZq/GbcC1VM=;
        b=ib61IhFrbCCrguH23R9oCVe12Ld5UbRYo4ZOFxMMg2ZE05Q2HNw5LwD01elVsBXJhm
         9C3opFWfXumKV0wcCxTl6x7rACHq2LlYBmyRrtUxpStzUnOFShjT72gYbIegD40rk9/n
         0Uy6aruPUkVMgJMzo5tay0E8J/9WSSyllqTmXc6zLk+bCE+qj3BV+E2v/KfOeKXHUVLg
         kmXWTEDouKV1qh5ROHdD+bbqM/gG20mscU+Gy9JnRxoo8k/9KxGQp10+aFPi5m8wmkly
         NBFxd/jncL3HiukZjDdS0IRxuFaqU5DZRmbLIBl4H5pkNzIo05ovzwUbnmV4D01ebhtN
         NPzQ==
X-Gm-Message-State: AOJu0Yxj6GXEBYKBMksjJVGe4X2pjl7xq7SPpTWr19WcTOBRf/WTXxV1
	M0a+76nb5PouLMbrNQLecNMzQoG5q3L6ciCO09P6XNNbVHuuxwAi
X-Google-Smtp-Source: AGHT+IHMl/UPTHa4mVeLcTCzXQ+AmZdTD8+M+8f+hv0XChV/FRAqeQeB51pKChqHX4+oTdCMFtdWbg==
X-Received: by 2002:a17:906:6d4e:b0:a31:805b:4172 with SMTP id a14-20020a1709066d4e00b00a31805b4172mr3559951ejt.9.1707300445937;
        Wed, 07 Feb 2024 02:07:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXo+W5KxMp0Kab+jBDX0/COO+302oPsMS8drIsnuZ5ziUCuunBIXkcfStDzmEp4PfEpnrt5AN5GI9U5/T0IfGX5VVZuF8tyEZZv2a9pSBRJNYWi3/seZxZ6u4HbTXu5OKP8cgRwRcfsI1pjGeTkRluuL8/aEWf1yyhi3RcXV4j7JqE89i6fnRF1IHThOWaumKARphdN4pp2lLD8cI4zwjarwtnwGP1nY5z8BwfDdKr7n/41ObIJakMOJjhJkstsTMCNmp4gjkCA3xZ19sfpXwEGdzt1FYy0zBV77ISKD2NUq6bK3a38H4h+zXMOazHTpMwNX0rYxWd5yCAfAsNw/n9Aw5HJbXS4vi8zwJXGo2XVeBnKSbfmmXOGdDdf9/A9
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id un1-20020a170907cb8100b00a3758a1ca48sm569530ejc.218.2024.02.07.02.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 02:07:25 -0800 (PST)
Message-ID: <5fd17b66eab1989b9cfb874445c18480a2282809.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad7944: add driver for
 AD7944/AD7985/AD7986
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 07 Feb 2024 11:10:44 +0100
In-Reply-To: <20240206-ad7944-mainline-v1-2-bf115fa9474f@baylibre.com>
References: <20240206-ad7944-mainline-v1-0-bf115fa9474f@baylibre.com>
	 <20240206-ad7944-mainline-v1-2-bf115fa9474f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi David,

The driver It's in pretty good shape... Just some comments from me
=20
On Tue, 2024-02-06 at 11:26 -0600, David Lechner wrote:
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
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0 10 ++
> =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/ad7944.c | 397
> +++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A04 files changed, 409 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4f1e658e1e0d..83d8367595f1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -458,6 +458,7 @@ R:	David Lechner <dlechner@baylibre.com>
> =C2=A0S:	Supported
> =C2=A0W:	https://ez.analog.com/linux-software-drivers
> =C2=A0F:	Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
> +F:	drivers/iio/adc/ad7944.c
> =C2=A0
> =C2=A0ADAFRUIT MINI I2C GAMEPAD
> =C2=A0M:	Anshul Dalal <anshulusr@gmail.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 59ae1d17b50d..93fbe6f8e306 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -280,6 +280,16 @@ config AD7923
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
> index 5a26ab6f1109..52d803b92cd7 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_AD7780) +=3D ad7780.o
> =C2=A0obj-$(CONFIG_AD7791) +=3D ad7791.o
> =C2=A0obj-$(CONFIG_AD7793) +=3D ad7793.o
> =C2=A0obj-$(CONFIG_AD7887) +=3D ad7887.o
> +obj-$(CONFIG_AD7944) +=3D ad7944.o
> =C2=A0obj-$(CONFIG_AD7949) +=3D ad7949.o
> =C2=A0obj-$(CONFIG_AD799X) +=3D ad799x.o
> =C2=A0obj-$(CONFIG_AD9467) +=3D ad9467.o
> diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
> new file mode 100644
> index 000000000000..67b525fb8e59
> --- /dev/null
> +++ b/drivers/iio/adc/ad7944.c
> @@ -0,0 +1,397 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD7944/85/86 PulSAR ADC family driver.
> + *
> + * Copyright 2024 Analog Devices, Inc.
> + * Copyright 2024 Baylibre, SAS
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
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#define AD7944_INTERNAL_REF_MV		4096
> +
> +struct ad7944_timing_spec {
> +	/* Normal mode minimum CNV pulse width in nanoseconds. */
> +	unsigned int cnv_ns;
> +	/* TURBO mode minimum CNV pulse width in nanoseconds. */
> +	unsigned int turbo_cnv_ns;
> +};
> +
>=20

..

> +}
> +
> +static int ad7944_single_conversion(struct ad7944_adc *adc,
> +				=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> +				=C2=A0=C2=A0=C2=A0 int *val)
> +{
> +	int ret;
> +
> +	ret =3D ad7944_4_wire_mode_conversion(adc, chan);
> +	if (ret)
> +		return ret;
> +
> +	if (chan->scan_type.storagebits > 16)
> +		*val =3D adc->sample.raw.u32;
> +	else
> +		*val =3D adc->sample.raw.u16;
> +

Will this work both in big vs little endian archs? I don't think so but may=
be
I'm missing something. At a first glance, it seems we get big endian from s=
pi so
shouldn't we have __be16 and __be32?
=20
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

I'm not totally sure but I think Jonathan already merged his series for the
cleanup stuff for the claim direct mode. Maybe take a look and use it? Not =
a big
win in here but I guess we could still reduce some LOC.

> +		ret =3D ad7944_single_conversion(adc, chan, val);
> +		iio_device_release_direct_mode(indio_dev);
> +		return ret;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val =3D adc->ref_mv;
> +			*val2 =3D chan->scan_type.realbits;
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
> +	ret =3D ad7944_4_wire_mode_conversion(adc, &indio_dev->channels[0]);
> +	if (ret)
> +		goto out;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &adc->sample.raw,
> +					=C2=A0=C2=A0 indio_dev->scan_timestamp);
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
> +	struct iio_dev *indio_dev;
> +	struct ad7944_adc *adc;
> +	struct regulator *ref;
> +	const char *str_val;
> +	int ret;
> +
> +	/* adi,spi-mode property defaults to "4-wire" if not present */
> +	if (device_property_read_string(&spi->dev, "adi,spi-mode", &str_val)
> < 0)
> +		str_val =3D "4-wire";
> +
> +	if (strcmp(str_val, "4-wire"))
> +		return dev_err_probe(&spi->dev, -EINVAL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "only \"4-wire\" mode is currently
> supported\n");

Did you looked at spi core? I guess the chain mode is not available but IIR=
C spi
already has spi-3wire. So maybe you could just have a boolean property for =
the
chain mode and check both that and 3wire?

> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	adc =3D iio_priv(indio_dev);
> +	adc->spi =3D spi;
> +
> +	chip_info =3D spi_get_device_match_data(spi);
> +	if (!chip_info)
> +		return dev_err_probe(&spi->dev, -EINVAL, "no chip info\n");
> +
> +	adc->t =3D chip_info->t;
> +
> +	/*
> +	 * Some chips use unusual word sizes, so check now instead of waiting
> +	 * for the first xfer.
> +	 */
> +	if (!spi_is_bpw_supported(spi, chip_info-
> >channels[0].scan_type.realbits))
> +		return dev_err_probe(&spi->dev, -EINVAL,
> +				"SPI host does not support %d bits per
> word\n",
> +				chip_info->channels[0].scan_type.realbits);
> +
> +	ret =3D devm_regulator_bulk_get_enable(&spi->dev,
> +					=C2=A0=C2=A0=C2=A0=C2=A0
> ARRAY_SIZE(ad7944_power_supplies),
> +					=C2=A0=C2=A0=C2=A0=C2=A0 ad7944_power_supplies);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get and enable supplies\n");
> +
> +	/* adi,reference property defaults to "internal" if not present */
> +	if (device_property_read_string(&spi->dev, "adi,reference", &str_val)
> < 0)
> +		str_val =3D "internal";
> +
> +	/* sort out what is being used for the reference voltage */
> +	if (strcmp(str_val, "internal") =3D=3D 0) {

Maybe you can make the code neater with match_string() and some enum...

- Nuno S=C3=A1


