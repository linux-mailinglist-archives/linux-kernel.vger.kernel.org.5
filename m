Return-Path: <linux-kernel+bounces-32107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D014835690
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8F21C210E0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD79D3770C;
	Sun, 21 Jan 2024 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvi1A9fv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF4E376F6;
	Sun, 21 Jan 2024 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705853354; cv=none; b=H9VsBCk4oU+PducnhtwJil3Te2Ke1xgCV5tty06WKMPodWXiDletIj/Eyni7H9k12MbnmkBKoJRmbOWf4B1TmdJP05LWXW3mU1lxExivf6cqRjIEPisiAoSSABJnOfMKOFtMfiVNDQjywV4eZVgC13L2V3Ib4mP1Az3gnyuN7q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705853354; c=relaxed/simple;
	bh=a4b5GGGgma7M5QOtpEFImXDW5Z1+UvUNUmRj57uUPWo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVA5AeffI30vice1qnYnqJzEFDxIB1umlXKiPauD+LS6tyzx+O+56mavnat5GdtmZqKRss7nTjqeKpwP6eULdw1EKxyrqOqrp5MrDcjLayLCasv1sYL9LctJuK0v9LVvFtIcmeHhtRnijrSSZ9HE0aYagXSx24cGHuWl06unUbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvi1A9fv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F778C433F1;
	Sun, 21 Jan 2024 16:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705853354;
	bh=a4b5GGGgma7M5QOtpEFImXDW5Z1+UvUNUmRj57uUPWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mvi1A9fvr4Ec9Pw8DtOs307vxgvhY0onfUd+hqYMLqbFRJf7I5WiYR3BCKwn0MNqe
	 f6ujQKBvYNzZrYmmMMn2PRAO+LDoyGh5M6DwaRhSbHT0yAA7GL/UdeL4zBqSXj5qUB
	 aWH7l3vjJIZpjp0FD9d6w7o7IHXvKGeVQLMh91e18W/wgzZXbqQ/TwyTj3UBSC0avx
	 uTXtU4egng+IUs+72kI2iFEnZIAAp9+Tdz7bcmvYsuiNf16kHuA/0hJbEXSvkzqEWm
	 wA1qMh72ZYjTg4AvUyfmoLIDVZB7WWdJHNdhUu050RcRWV/gzbRmvk18TcmPNlUIEx
	 13VkcSmWZZ05g==
Date: Sun, 21 Jan 2024 16:09:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Crt Mori <cmo@melexis.com>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v6 2/2] iio: frequency: admfm2000: New driver
Message-ID: <20240121160900.308055c7@jic23-huawei>
In-Reply-To: <20240118085856.70758-3-kimseer.paller@analog.com>
References: <20240118085856.70758-1-kimseer.paller@analog.com>
	<20240118085856.70758-3-kimseer.paller@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jan 2024 16:58:56 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> Dual microwave down converter module with input RF and LO frequency
> ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
> 8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
> for each down conversion path.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
Hi.

A few comments inline.  Mainly about reducing some code duplication.
The note about autocleanup of fwnode_handle_put is a reference to:

https://lore.kernel.org/linux-iio/Za0NxrgBb0ve233b@smile.fi.intel.com/T/

Though I'm not sure that will land exactly as currently implemented, so
don't base anything on it yet.

> ---
> V5 -> V6: Used devm_fwnode_gpiod_get_index for getting array of gpios.
> V4 -> V5: Added missing return -ENODEV in setup function. Reordered variable
> 	  declarations in probe function.
> V1 -> V4: No changes.
> 
>  MAINTAINERS                       |   1 +
>  drivers/iio/frequency/Kconfig     |  10 +
>  drivers/iio/frequency/Makefile    |   1 +
>  drivers/iio/frequency/admfm2000.c | 307 ++++++++++++++++++++++++++++++
>  4 files changed, 319 insertions(+)
>  create mode 100644 drivers/iio/frequency/admfm2000.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a86f9d6cb98..49d320535105 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1266,6 +1266,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> +F:	drivers/iio/frequency/admfm2000.c
>  
>  ANALOG DEVICES INC ADMV1013 DRIVER
>  M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
> index 9e85dfa58508..c455be7d4a1c 100644
> --- a/drivers/iio/frequency/Kconfig
> +++ b/drivers/iio/frequency/Kconfig
> @@ -60,6 +60,16 @@ config ADF4377
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called adf4377.
>  
> +config ADMFM2000
> +	tristate "Analog Devices ADMFM2000 Dual Microwave Down Converter"
> +	depends on GPIOLIB
> +	help
> +	  Say yes here to build support for Analog Devices ADMFM2000 Dual
> +	  Microwave Down Converter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called admfm2000.
> +
>  config ADMV1013
>  	tristate "Analog Devices ADMV1013 Microwave Upconverter"
>  	depends on SPI && COMMON_CLK
> diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
> index b616c29b4a08..70d0e0b70e80 100644
> --- a/drivers/iio/frequency/Makefile
> +++ b/drivers/iio/frequency/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_AD9523) += ad9523.o
>  obj-$(CONFIG_ADF4350) += adf4350.o
>  obj-$(CONFIG_ADF4371) += adf4371.o
>  obj-$(CONFIG_ADF4377) += adf4377.o
> +obj-$(CONFIG_ADMFM2000) += admfm2000.o
>  obj-$(CONFIG_ADMV1013) += admv1013.o
>  obj-$(CONFIG_ADMV1014) += admv1014.o
>  obj-$(CONFIG_ADMV4420) += admv4420.o
> diff --git a/drivers/iio/frequency/admfm2000.c b/drivers/iio/frequency/admfm2000.c
> new file mode 100644
> index 000000000000..a09ec38fad22
> --- /dev/null
> +++ b/drivers/iio/frequency/admfm2000.c
> @@ -0,0 +1,307 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ADMFM2000 Dual Microwave Down Converter
> + *
> + * Copyright 2023 Analog Devices Inc.
As you are updating in 2024, this might want an update to include this year.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>

Why this include?
You are using stuff from property.h not the of specific stuff.
You should have mod_devicetable.h for the of_device_id definition though.

> +#include <linux/platform_device.h>


> +
> +static int admfm2000_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int *val,
> +			      int *val2, long mask)
> +{
> +	struct admfm2000_state *st = iio_priv(indio_dev);
> +	int gain;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		mutex_lock(&st->lock);
> +		gain = ~(st->gain[chan->channel]) * -1000;
> +		*val = gain / 1000;
> +		*val2 = (gain % 1000) * 1000;
> +		mutex_unlock(&st->lock);
> +
> +		return  IIO_VAL_INT_PLUS_MICRO_DB;

Odd extra space after return.

> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int admfm2000_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct admfm2000_state *st = iio_priv(indio_dev);
> +	int gain, ret;
> +
> +	if (val < 0)
> +		gain = (val * 1000) - (val2 / 1000);
> +	else
> +		gain = (val * 1000) + (val2 / 1000);
> +
> +	if (gain > ADMFM2000_MAX_GAIN || gain < ADMFM2000_MIN_GAIN)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		mutex_lock(&st->lock);
> +		st->gain[chan->channel] = ~((abs(gain) / 1000) & 0x1F);
> +
> +		ret = admfm2000_attenuation(indio_dev, chan->channel,
> +					     st->gain[chan->channel]);
> +		mutex_unlock(&st->lock);
> +		break;
		return ret;

> +	default:
> +		ret = -EINVAL;
		return -EINVAL;

> +	}
> +
> +	return ret;

Not needed with direct returns above.  Returning early reduces the code
a reviewer needs to consider for a given flow, which is nice to do!

> +}

> +
> +static int admfm2000_channel_config(struct admfm2000_state *st,
> +				    struct iio_dev *indio_dev)
> +{
> +	struct platform_device *pdev = to_platform_device(indio_dev->dev.parent);
> +	struct device *dev = &pdev->dev;
> +	struct fwnode_handle *child;
> +	u32 reg, mode;
> +	int ret, i;
> +
> +	device_for_each_child_node(dev, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret) {
> +			fwnode_handle_put(child);

Once a proposed auto cleanup solution for fwnode_handle_put() lands
we an tidy this up a lot as then we can get rid of all these manual
reference drops.

> +			return dev_err_probe(dev, ret,
> +					     "Failed to get reg property\n");
> +		}
> +
> +		if (reg >= indio_dev->num_channels) {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(dev, -EINVAL, "reg bigger than: %d\n",
> +					     indio_dev->num_channels);
> +		}
> +
> +		ret = fwnode_property_read_u32(child, "adi,mode", &mode);
> +		if (ret) {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(dev, ret,
> +					     "Failed to get mode property\n");
> +		}
> +
> +		if (mode >= 2) {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(dev, -EINVAL, "mode bigger than: 1\n");
> +		}
> +
> +		switch (reg) {
> +		case 0:

Use a couple of local variables to avoid the code duplication.

		struct gpio_desc *sw;
		struct gpio_desc *dsa;
		switch (ret) {
		case 0:
			sw = st->sw1_ch;
			dsa = st->dsa1_gpios;
			break;
		case 1:
			sw = st->sw2_ch;
			dsa = st->dsa2_gpios; /* or maybe make these arrays of pointers */
			break;
		default:
			fwnode_handle_put()
			return;
		}

		for (i = 0; i < ADMFM2000_MODE_GPIOS; i++) {
			sw[i] = devm_fdnode...
etc



> +			for (i = 0; i < ADMFM2000_MODE_GPIOS; i++) {
> +				st->sw1_ch[i] = devm_fwnode_gpiod_get_index(dev, child,
> +									    "switch", i,
> +									    GPIOD_OUT_LOW,
> +									    NULL);
> +				if (IS_ERR(st->sw1_ch[i])) {
> +					fwnode_handle_put(child);
> +					return dev_err_probe(dev, PTR_ERR(st->sw1_ch[i]),
> +							     "Failed to get gpios\n");
> +				}
> +			}
> +
> +			for (i = 0; i < ADMFM2000_DSA_GPIOS; i++) {
> +				st->dsa1_gpios[i] = devm_fwnode_gpiod_get_index(dev, child,
> +										"attenuation", i,
> +										GPIOD_OUT_LOW,
> +										NULL);
> +				if (IS_ERR(st->dsa1_gpios[i])) {
> +					fwnode_handle_put(child);
> +					return dev_err_probe(dev, PTR_ERR(st->dsa1_gpios[i]),
> +							     "Failed to get gpios\n");
> +				}
> +			}
> +			break;
> +		case 1:
> +			for (i = 0; i < ADMFM2000_MODE_GPIOS; i++) {
> +				st->sw2_ch[i] = devm_fwnode_gpiod_get_index(dev, child,
> +									    "switch", i,
> +									    GPIOD_OUT_LOW,
> +									    NULL);
> +				if (IS_ERR(st->sw2_ch[i])) {
> +					fwnode_handle_put(child);
> +					return dev_err_probe(dev, PTR_ERR(st->sw2_ch[i]),
> +							     "Failed to get gpios\n");
> +				}
> +			}
> +
> +			for (i = 0; i < ADMFM2000_DSA_GPIOS; i++) {
> +				st->dsa2_gpios[i] = devm_fwnode_gpiod_get_index(dev, child,
> +										"attenuation", i,
> +										GPIOD_OUT_LOW,
> +										NULL);
> +				if (IS_ERR(st->dsa2_gpios[i])) {
> +					fwnode_handle_put(child);
> +					return dev_err_probe(dev, PTR_ERR(st->dsa2_gpios[i]),
> +							     "Failed to get gpios\n");
> +				}
> +			}
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		ret = admfm2000_mode(indio_dev, reg, mode);
> +		if (ret) {
> +			fwnode_handle_put(child);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}

