Return-Path: <linux-kernel+bounces-1344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58971814DBE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE4D1C23D98
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C403EA73;
	Fri, 15 Dec 2023 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UGfEXITT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2033EA74
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id EBR6rmv31emNIEBR6rInmB; Fri, 15 Dec 2023 17:53:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1702659197;
	bh=yYjHwcm5ONKKp2t/E2nQ5jgkSu+ukJ4Ae0Z81VV/l5U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UGfEXITTxE+pPRmAIu4Gbf5iCKKwO9WC9yJDTyvNy1c8Trpi3n/Cod/yWv3CZLx0q
	 AJ9N0QRSrW3JAN8Az4HbSI8H+WFAyOFgjdR0gbuVHiiul17M/98TmXDgIidX+z4zF/
	 TP2t0gk7J/JKSUsoehFD+MMQsDwCgz/tNH0TzCoAiKzVxGz6ClX4wKa3iRINQEjgK4
	 OudbrKVOcg58kNynTqM/Wy97jwahCKZapZHCn/LyqYct+orJM8NRM5ew+ndtvD4MRv
	 8/rf6AuYeDSctx7feQC0fi0/Ob7Y1JyY+nct8hOpX+yitz4oklMvQAHutxVc4E+aZt
	 /KPbT6UKIzqJQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 15 Dec 2023 17:53:17 +0100
X-ME-IP: 92.140.202.140
Message-ID: <66e9fe7a-927b-465f-aafe-8aea0e5998a4@wanadoo.fr>
Date: Fri, 15 Dec 2023 17:53:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] iio: adc: ad7380: new driver for AD7380 ADCs
To: dlechner@baylibre.com
Cc: broonie@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
 robh+dt@kernel.org, stefan.popa@analog.com
References: <20231215-ad7380-mainline-v3-0-7a11ebf642b9@baylibre.com>
 <20231215-ad7380-mainline-v3-3-7a11ebf642b9@baylibre.com>
Content-Language: fr
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231215-ad7380-mainline-v3-3-7a11ebf642b9@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 15/12/2023 à 11:32, David Lechner a écrit :
> This adds a new driver for the AD7380 family ADCs.
> 
> The driver currently implements basic support for the AD7380, AD7381,
> AD7383, and AD7384 2-channel differential ADCs. Support for additional
> single-ended and 4-channel chips that use the same register map as well
> as additional features of the chip will be added in future patches.
> 
> Co-developed-by: Stefan Popa <stefan.popa-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Stefan Popa <stefan.popa-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> Reviewed-by: Nuno Sa <nuno.sa-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: David Lechner <dlechner-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---

...

> +static void ad7380_regulator_disable(void *p)
> +{
> +	regulator_disable(p);
> +}
> +
> +static int ad7380_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ad7380_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +	st->chip_info = spi_get_device_match_data(spi);
> +	if (!st->chip_info)
> +		return dev_err_probe(&spi->dev, -EINVAL, "missing match data\n");
> +
> +	st->vref = devm_regulator_get_optional(&spi->dev, "refio");

Hi,

devm_regulator_get_enable_optional()?
to save some LoC below and ad7380_regulator_disable()

CJ

> +	if (IS_ERR(st->vref)) {
> +		/*
> +		 * If there is no REFIO supply, then it means that we are using
> +		 * the internal 2.5V reference.
> +		 */
> +		if (PTR_ERR(st->vref) == -ENODEV)
> +			st->vref = NULL;
> +		else
> +			return dev_err_probe(&spi->dev, PTR_ERR(st->vref),
> +					     "Failed to get refio regulator\n");
> +	}
> +
> +	if (st->vref) {
> +		ret = regulator_enable(st->vref);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_add_action_or_reset(&spi->dev, ad7380_regulator_disable,
> +					       st->vref);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	st->regmap = devm_regmap_init(&spi->dev, NULL, st, &ad7380_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
> +				     "failed to allocate register map\n");
> +
> +	indio_dev->channels = st->chip_info->channels;
> +	indio_dev->num_channels = st->chip_info->num_channels;
> +	indio_dev->name = st->chip_info->name;
> +	indio_dev->info = &ad7380_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->available_scan_masks = ad7380_2_channel_scan_masks;
> +
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +					      iio_pollfunc_store_time,
> +					      ad7380_trigger_handler, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7380_init(st);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}

...


