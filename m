Return-Path: <linux-kernel+bounces-89760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6E386F530
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30BF1C2103E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3BA59B5C;
	Sun,  3 Mar 2024 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFq57xDL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A58F9E0;
	Sun,  3 Mar 2024 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709473453; cv=none; b=Bwkm0n3DrAwpH7L56dvd6o1TLVHRh4+Rg6WnmYfvr8fZ+NObmufZV7RT+h5hHBTP0/yYLfDu5ZGAeqhxLCngi/g7W26KD+nAm9Jxa9rVY3gz9ZG/+1kQiJsjOciMDbMe+1J0ijyVlzPAUvOCXUoEOc5lYifoxMriGYFAXbM9woY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709473453; c=relaxed/simple;
	bh=ugMvCw6zGRAzhtBt0eT9PK0o3WRLP6J3rcIwKvAF0Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PGlFKjxHQfXfEvE+WR/b2coVwNCcCx1xVTiXxEnTy+Z+GCRUjXcBvNMHv7K47SKgohsOEP/wNV+3Fo+hEzlZmdqegHb0IWo86u6JGYUdBddnh0UjaFhp4y0PAwlbVRHjEQlJDNEc5BmT36rt7Fn/of8U2NB0rbKmiEVgJgUAkJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFq57xDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF006C433C7;
	Sun,  3 Mar 2024 13:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709473453;
	bh=ugMvCw6zGRAzhtBt0eT9PK0o3WRLP6J3rcIwKvAF0Gc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DFq57xDLrYxOe9w7PzvF4LRKqHFPVjGbOopKrunvEi/wkXqToI6eChzOoVkMIgo9N
	 yTw2rdDy4sEZ5ApuLXgPwTuM6Db2ThzTt95x78Qj/5rsoEwpOiE/q3a6APeUhlHujU
	 tJdWQysTryZze1Ri1+ZPtYUT+hQOtRP+PSkpOM+zEVR9vDWoW9HGKY68tlDwcym4Rz
	 uxal08cSsvCkzvm6iUIbZx+Z8su5fqUosrHI5OO9g9zdmjQ7Vq0GovmxaTa8hH99kK
	 N5c71EatrVgfsDmChZjzR3fkJGwvVm1yam8qCYzQN5/e04KHSXj93eUYpO6yObTUM8
	 LWdlk0OJHlfOQ==
Date: Sun, 3 Mar 2024 13:43:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: ad7944: add driver for
 AD7944/AD7985/AD7986
Message-ID: <20240303134359.16d5e5f1@jic23-huawei>
In-Reply-To: <20240229-ad7944-mainline-v4-2-f88b5ec4baed@baylibre.com>
References: <20240229-ad7944-mainline-v4-0-f88b5ec4baed@baylibre.com>
	<20240229-ad7944-mainline-v4-2-f88b5ec4baed@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 10:25:51 -0600
David Lechner <dlechner@baylibre.com> wrote:

> This adds a driver for the Analog Devices Inc. AD7944, AD7985, and
> AD7986 ADCs. These are a family of pin-compatible ADCs that can sample
> at rates up to 2.5 MSPS.
> 
> The initial driver adds support for sampling at lower rates using the
> usual IIO triggered buffer and can handle all 3 possible reference
> voltage configurations.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> 
Hi David,

Fresh read through showed up a few more things.  They are all trivial except
for what I think is an inverted error condition which would break
cases where ref was not supplied in DT.

Jonathan


> ---
> v4 changes: none
> 
> v3 changes:
> - Replaced _sign with _diff in chip info struct to properly handle
>   pseudo-differential vs. true differential chips. Pseudo-differential chips
>   now just have a voltage0 channel instead of voltage0-voltage1.
> - Fixed not resetting the CNV gpio on error return.
> - Simplified check of adi,spi-mode property now that "multi" is no longer a
>   valid option.

> diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
> new file mode 100644
> index 000000000000..d0ba4ae409c4
> --- /dev/null
> +++ b/drivers/iio/adc/ad7944.c
> @@ -0,0 +1,413 @@

> +#define AD7944_INTERNAL_REF_MV		4096
> +
> +struct ad7944_timing_spec {
> +	/* Normal mode max conversion time (t_{CONV}) in nanoseconds. */
Trivial.
Name makes unit obvious (which is exactly how it should be!),
so can drop it from the comment.

> +	unsigned int conv_ns;
> +	/* TURBO mode max conversion time (t_{CONV}) in nanoseconds. */
> +	unsigned int turbo_conv_ns;
> +};
> +
> +struct ad7944_adc {
> +	struct spi_device *spi;
> +	/* Chip-specific timing specifications. */
> +	const struct ad7944_timing_spec *t;

As mentioned below, t is too succinct. Just pay the price in characters for
timing_spec or something along those lines.

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
> +static int ad7944_probe(struct spi_device *spi)
> +{
> +	const struct ad7944_chip_info *chip_info;
> +	struct iio_dev *indio_dev;
> +	struct ad7944_adc *adc;
> +	bool have_refin = false;
> +	struct regulator *ref;
> +	int ret;
> +
> +	/*
> +	 * driver currently only supports the conventional "4-wire" mode and
> +	 * not other special wiring configurations.
> +	 */
> +	if (device_property_present(&spi->dev, "adi,spi-mode"))
Trivial, so ignore if you like..

There are a lot of spi->dev in here, maybe it's wroth
a local variable
struct device *dev = &spi->dev;

> +		return dev_err_probe(&spi->dev, -EINVAL,
> +				     "adi,spi-mode is not currently supported\n");
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	adc = iio_priv(indio_dev);
> +	adc->spi = spi;
> +
> +	chip_info = spi_get_device_match_data(spi);
> +	if (!chip_info)
> +		return dev_err_probe(&spi->dev, -EINVAL, "no chip info\n");
> +
> +	adc->t = chip_info->t;

That might want a bit more informative a name. Even ts is better than t!

>
> +
> +	/*
> +	 * Sort out what is being used for the reference voltage. Options are:
> +	 * - internal reference: neither REF or REFIN is connected
> +	 * - internal reference with external buffer: REF not connected, REFIN
> +	 *   is connected
> +	 * - external reference: REF is connected, REFIN is not connected
> +	 */
> +
> +	ref = devm_regulator_get_optional(&spi->dev, "ref");
> +	if (IS_ERR(ref)) {
> +		if (PTR_ERR(ref) != -ENODEV)

Confused. Isn't this inverse of what we want?
return an error if we got anything other than -ENODEV.
		if (PTR_ERR(ref) |= -ENODEV)
			return dev_err_probe(&spi->dev, PTR_ERR(ref),
					     "failed to get REF supply\n");
		ref = NULL;
	}

> +			ref = NULL;
> +		else
> +			return dev_err_probe(&spi->dev, PTR_ERR(ref),
> +					     "failed to get REF supply\n");
> +	}
> +

> +
> +	adc->cnv = devm_gpiod_get(&spi->dev, "cnv", GPIOD_OUT_LOW);
> +	if (IS_ERR(adc->cnv))
> +		return dev_err_probe(&spi->dev, PTR_ERR(adc->cnv),
> +				     "failed to get CNV GPIO\n");

Is this optional?  If we don't yet support the case the dt binding talks
about worth a comment here to say we don't yet support XYZ so this
is not optional.  

> +
> +	adc->turbo = devm_gpiod_get_optional(&spi->dev, "turbo", GPIOD_OUT_LOW);
> +	if (IS_ERR(adc->turbo))
> +		return dev_err_probe(&spi->dev, PTR_ERR(adc->turbo),
> +				     "failed to get TURBO GPIO\n");
> +
> +	if (device_property_present(&spi->dev, "adi,always-turbo"))
> +		adc->always_turbo = true;
> +

Trivial, but maybe..
	adc->always_turbo = device_property_present(&spi->dev, "adi,always_turbo");

Jonathan


