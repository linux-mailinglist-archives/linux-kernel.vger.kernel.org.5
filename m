Return-Path: <linux-kernel+bounces-152229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0887E8ABB08
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 12:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88C1AB219C2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 10:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219C81805A;
	Sat, 20 Apr 2024 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6GYzugA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4422563;
	Sat, 20 Apr 2024 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713609748; cv=none; b=IQ3/NOSaTutNZKQbdW7w8z1K5HMdYIRI0LGCHw//IvBQcyFfQsFa6ukjkstTcd0wqTG+LqcDa78F8fLtHfzxYm8+iUo/k2aXyQjqcqirO8wKzT7TujxDYket3naE8fTqY+J5IyjIABIzuly7DsCYpHFiv8f7EK4YfnQuKp7XLTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713609748; c=relaxed/simple;
	bh=5L1xgUBudmjOD4Io0oeVDwwfciZkDudOjZawUJrPhOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=az4U4qt2mXpSwzXyZQKFq+0AhYjXyhvow+kVBTCuXyAUKC6sUbGeZbJ+Ojd1wFc3/L2OafEbPm/hIqRQyxqEvhnKsFUWSIYQCeNc1X2ON/0ph4GHJEJVK6Hko2H31xXh4/DK2u30JdPTNEOgQshM4LMDa5JlNyIvd8yhB74Nfec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6GYzugA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC58C072AA;
	Sat, 20 Apr 2024 10:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713609747;
	bh=5L1xgUBudmjOD4Io0oeVDwwfciZkDudOjZawUJrPhOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g6GYzugAVZv4zZqkgcFQBy/d3P8EIS+G3fo7g9IM3zj4QLIYo6fxC3OeAu9LQKC7u
	 5M/cScdmWm5w9dGZ3XeB99YipdjZSKk1fVv2+ucE5MEf82P/uOQb6jy0+n73lwuloR
	 koZuhU2IqWcCLfZ+pf/QxkkmIaqf9Be4pZjLMNEstjFvuEalqdUu6ClP7mSCHnrY54
	 442ItyIfVFUpQLojubL8dWNWQbMnKd8csHYMcqK7dMXHh2eU7dJBaZTOaNOAZGIavh
	 5824ec3UJHrcyokKykCv7Esm0xxgHKqMjnVghl93H5G2M694YFtep8r8JrTtj48d/2
	 KNirC4lve4kWQ==
Date: Sat, 20 Apr 2024 11:42:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alexandru.tachici@analog.com, lars@metafoo.de, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt@analog.com, bigunclemax@gmail.com,
 dlechner@baylibre.com, okan.sahin@analog.com, fr0st61te@gmail.com,
 alisa.roman@analog.com, marcus.folkesson@gmail.com, schnelle@linux.ibm.com,
 liambeguin@gmail.com
Subject: Re: [PATCH v6 3/5] iio: adc: ad7192: Add aincom supply
Message-ID: <20240420114212.4f40fb89@jic23-huawei>
In-Reply-To: <20240417170054.140587-4-alisa.roman@analog.com>
References: <20240417170054.140587-1-alisa.roman@analog.com>
	<20240417170054.140587-4-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Apr 2024 20:00:52 +0300
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> AINCOM should actually be a supply. AINx inputs are referenced to AINCOM
> in pseduo-differential operation mode. AINCOM voltage represets the
> offset of corresponding channels.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
One request inline to make my life easier :)

Otherwise, I noticed a subset of what Andy picked up on so won't
repeat his comments!

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7192.c | 37 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index fe8dbb68a8ba..8d56cf889973 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -186,6 +186,7 @@ struct ad7192_state {
>  	struct regulator		*vref;
>  	struct clk			*mclk;
>  	u16				int_vref_mv;
> +	u32				aincom_mv;
>  	u32				fclk;
>  	u32				mode;
>  	u32				conf;
> @@ -742,10 +743,19 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
>  			*val = -(1 << (chan->scan_type.realbits - 1));
>  		else
>  			*val = 0;
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			if (st->aincom_mv && !chan->differential)
> +				*val += DIV_ROUND_CLOSEST_ULL((u64)st->aincom_mv * 1000000000,
> +							      st->scale_avail[gain][1]);
> +			return IIO_VAL_INT;
>  		/* Kelvin to Celsius */
> -		if (chan->type == IIO_TEMP)
> +		case IIO_TEMP:
>  			*val -= 273 * ad7192_get_temp_scale(unipolar);
> -		return IIO_VAL_INT;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		*val = DIV_ROUND_CLOSEST(ad7192_get_f_adc(st), 1024);
>  		return IIO_VAL_INT;
> @@ -1052,6 +1062,7 @@ static int ad7192_probe(struct spi_device *spi)
>  {
>  	struct ad7192_state *st;
>  	struct iio_dev *indio_dev;
> +	struct regulator *aincom;
>  	int ret;
>  
>  	if (!spi->irq) {
> @@ -1067,6 +1078,27 @@ static int ad7192_probe(struct spi_device *spi)
>  
>  	mutex_init(&st->lock);
>  
As we are going around again, could you do me a favour and add a comment
here along the lines of.

	/*
	 * aincom is optional to maintain compatibility with older DT.
	 * Newer firmware should provide a zero volt fixed supply if
	 * this is wired to ground.	 
	 */

Aim being to discourage this getting cut and paste into other drivers
that support the common voltage from the start!


> +	aincom = devm_regulator_get_optional(&spi->dev, "aincom");
> +	if (!IS_ERR(aincom)) {
> +		ret = regulator_enable(aincom);
> +		if (ret) {
> +			dev_err(&spi->dev, "Failed to enable specified AINCOM supply\n");
> +			return ret;
> +		}
> +
> +		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, aincom);
> +		if (ret)
> +			return ret;
> +
> +		ret = regulator_get_voltage(aincom);
> +		if (ret < 0)
> +			return dev_err_probe(&spi->dev, ret,
> +					     "Device tree error, AINCOM voltage undefined\n");
> +		st->aincom_mv = ret / 1000;
> +	} else {
> +		st->aincom_mv = 0;
> +	}
> +
>  	st->avdd = devm_regulator_get(&spi->dev, "avdd");
>  	if (IS_ERR(st->avdd))
>  		return PTR_ERR(st->avdd);
> @@ -1113,6 +1145,7 @@ static int ad7192_probe(struct spi_device *spi)
>  	st->int_vref_mv = ret / 1000;
>  
>  	st->chip_info = spi_get_device_match_data(spi);
> +
>  	indio_dev->name = st->chip_info->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = st->chip_info->channels;


