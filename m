Return-Path: <linux-kernel+bounces-122840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F0188FE39
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28BF6B217A6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E627E774;
	Thu, 28 Mar 2024 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7uMJjyR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1C7374F9;
	Thu, 28 Mar 2024 11:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711625852; cv=none; b=CRWn6pskGkRZugffrCI+9a6dQMNkh6xDlZpybe+t31xly7Sy7vQDLKvCjEOUDfTC34kk2CwB3wcB9+IVrItkkZUWjmP9Qmxro5tl8IVKbIEmxwhX+EZ0nVYYq6Am84OhoQmn/tp5O6PomhSPakgM4WXcsgVoMtQPNKcrei5p+3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711625852; c=relaxed/simple;
	bh=PVbCQcBD9CWn/gNAbIGipQTz8wnyniImrlBgL0zkhjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfFrn9ZK28RrjQ/fWbiWPbnlLCrRnOiRzoWhS9kqkatJKuvxnSbcZKlBzJYcSaHIHlLcGsGNEcH75x038S8E2mdmSc29iZRH4k8VED5sIM/xyJ694PjWW5kk9QJlGfLWxrjo+cjhEVHuzVfsbRDX8m8IirCdnQ8/5vdjhjm++fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7uMJjyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2206EC433C7;
	Thu, 28 Mar 2024 11:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711625851;
	bh=PVbCQcBD9CWn/gNAbIGipQTz8wnyniImrlBgL0zkhjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J7uMJjyRckdKZmMRdYNjQ7wUziTu9fqjJYx9lm0PzzjjqYb3/imPJtrkbwmxHidrs
	 2pqpPaAvH/1mJ22XEtyQxLKt/GJyZd+tuOHleveFBqrp5wUEdZVpYfnTt9iXDkUBBj
	 P+WXZaWVYJOlR0qVK5RZPP1KH3SY8dAzLpZxROH9gRFr0ZqPf7yBj43v6qoAyqU5Pw
	 K8TXc6il04eknWpAT7jnwaYHAi3qTXBEnAOWIyzzUGHK3I7w0bVKU93UVzNU82DPKu
	 yizSp53bq538s9z6mUtDCFCuk/83Tu7T8qeVzN73hYU5B9jvFgvtHRQAeUW9uIeGVz
	 DV+8ZifBpt+DQ==
Date: Thu, 28 Mar 2024 11:37:25 +0000
From: Lee Jones <lee@kernel.org>
To: Bhargav Raviprakash <bhargav.r@ltts.com>
Cc: linux-kernel@vger.kernel.org, m.nirmaladevi@ltts.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jpanis@baylibre.com,
	devicetree@vger.kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, lgirdwood@gmail.com, broonie@kernel.org,
	linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nm@ti.com, vigneshr@ti.com,
	kristo@kernel.org, eblanc@baylibre.com
Subject: Re: [PATCH v4 03/11] mfd: tps6594: add regmap config in match data
Message-ID: <20240328113725.GA13211@google.com>
References: <20240320102559.464981-1-bhargav.r@ltts.com>
 <20240320102559.464981-4-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240320102559.464981-4-bhargav.r@ltts.com>

On Wed, 20 Mar 2024, Bhargav Raviprakash wrote:

> Introduces a new struct tps6594_match_data. This struct holds fields for
> chip id and regmap config. Using this struct in of_device_id data field.
> This helps in adding support for TPS65224 PMIC.
> 
> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> Acked-by: Julien Panis <jpanis@baylibre.com>
> ---
>  drivers/mfd/tps6594-i2c.c   | 24 ++++++++++++++++--------
>  drivers/mfd/tps6594-spi.c   | 24 ++++++++++++++++--------
>  include/linux/mfd/tps6594.h | 11 +++++++++++
>  3 files changed, 43 insertions(+), 16 deletions(-)

Mostly fine, just a couple of nits.

Firstly the subject lines for the entire set are inconsistent.

Please use the style set by the subsystem:

  `git log --oneline -- <subsystem>` is your friend.

> diff --git a/drivers/mfd/tps6594-i2c.c b/drivers/mfd/tps6594-i2c.c
> index c125b474b..9e2ed48b7 100644
> --- a/drivers/mfd/tps6594-i2c.c
> +++ b/drivers/mfd/tps6594-i2c.c
> @@ -192,10 +192,16 @@ static const struct regmap_config tps6594_i2c_regmap_config = {
>  	.write = tps6594_i2c_write,
>  };
>  
> +static const struct tps6594_match_data match_data[] = {
> +	[TPS6594] = {TPS6594, &tps6594_i2c_regmap_config},
> +	[TPS6593] = {TPS6593, &tps6594_i2c_regmap_config},
> +	[LP8764] = {LP8764, &tps6594_i2c_regmap_config},

Spaces after the '{' and before the '}' please.
> +};
> +
>  static const struct of_device_id tps6594_i2c_of_match_table[] = {
> -	{ .compatible = "ti,tps6594-q1", .data = (void *)TPS6594, },
> -	{ .compatible = "ti,tps6593-q1", .data = (void *)TPS6593, },
> -	{ .compatible = "ti,lp8764-q1",  .data = (void *)LP8764,  },
> +	{ .compatible = "ti,tps6594-q1", .data = &match_data[TPS6594], },
> +	{ .compatible = "ti,tps6593-q1", .data = &match_data[TPS6593], },
> +	{ .compatible = "ti,lp8764-q1",  .data = &match_data[LP8764], },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, tps6594_i2c_of_match_table);
> @@ -205,6 +211,7 @@ static int tps6594_i2c_probe(struct i2c_client *client)
>  	struct device *dev = &client->dev;
>  	struct tps6594 *tps;
>  	const struct of_device_id *match;
> +	const struct tps6594_match_data *mdata;
>  
>  	tps = devm_kzalloc(dev, sizeof(*tps), GFP_KERNEL);
>  	if (!tps)
> @@ -216,14 +223,15 @@ static int tps6594_i2c_probe(struct i2c_client *client)
>  	tps->reg = client->addr;
>  	tps->irq = client->irq;
>  
> -	tps->regmap = devm_regmap_init(dev, NULL, client, &tps6594_i2c_regmap_config);
> -	if (IS_ERR(tps->regmap))
> -		return dev_err_probe(dev, PTR_ERR(tps->regmap), "Failed to init regmap\n");
> -
>  	match = of_match_device(tps6594_i2c_of_match_table, dev);
>  	if (!match)
>  		return dev_err_probe(dev, -EINVAL, "Failed to find matching chip ID\n");
> -	tps->chip_id = (unsigned long)match->data;
> +	mdata = (struct tps6594_match_data *)match->data;

What happens when you drop this case?

I was under the impression this was not required when casting from (void *)

> +	tps->chip_id = mdata->chip_id;
> +
> +	tps->regmap = devm_regmap_init(dev, NULL, client, mdata->config);
> +	if (IS_ERR(tps->regmap))
> +		return dev_err_probe(dev, PTR_ERR(tps->regmap), "Failed to init regmap\n");

"initialise"

>  
>  	crc8_populate_msb(tps6594_i2c_crc_table, TPS6594_CRC8_POLYNOMIAL);
>  
> diff --git a/drivers/mfd/tps6594-spi.c b/drivers/mfd/tps6594-spi.c
> index 5afb1736f..82a1c02e3 100644
> --- a/drivers/mfd/tps6594-spi.c
> +++ b/drivers/mfd/tps6594-spi.c
> @@ -77,10 +77,16 @@ static const struct regmap_config tps6594_spi_regmap_config = {
>  	.use_single_write = true,
>  };
>  
> +static const struct tps6594_match_data match_data[] = {
> +	[TPS6594] = {TPS6594, &tps6594_spi_regmap_config},
> +	[TPS6593] = {TPS6593, &tps6594_spi_regmap_config},
> +	[LP8764] = {LP8764, &tps6594_spi_regmap_config},

As above.

> +};
> +
>  static const struct of_device_id tps6594_spi_of_match_table[] = {
> -	{ .compatible = "ti,tps6594-q1", .data = (void *)TPS6594, },
> -	{ .compatible = "ti,tps6593-q1", .data = (void *)TPS6593, },
> -	{ .compatible = "ti,lp8764-q1",  .data = (void *)LP8764,  },
> +	{ .compatible = "ti,tps6594-q1", .data = &match_data[TPS6594], },
> +	{ .compatible = "ti,tps6593-q1", .data = &match_data[TPS6593], },
> +	{ .compatible = "ti,lp8764-q1",  .data = &match_data[LP8764], },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, tps6594_spi_of_match_table);
> @@ -90,6 +96,7 @@ static int tps6594_spi_probe(struct spi_device *spi)
>  	struct device *dev = &spi->dev;
>  	struct tps6594 *tps;
>  	const struct of_device_id *match;
> +	const struct tps6594_match_data *mdata;
>  
>  	tps = devm_kzalloc(dev, sizeof(*tps), GFP_KERNEL);
>  	if (!tps)
> @@ -101,14 +108,15 @@ static int tps6594_spi_probe(struct spi_device *spi)
>  	tps->reg = spi_get_chipselect(spi, 0);
>  	tps->irq = spi->irq;
>  
> -	tps->regmap = devm_regmap_init(dev, NULL, spi, &tps6594_spi_regmap_config);
> -	if (IS_ERR(tps->regmap))
> -		return dev_err_probe(dev, PTR_ERR(tps->regmap), "Failed to init regmap\n");
> -
>  	match = of_match_device(tps6594_spi_of_match_table, dev);
>  	if (!match)
>  		return dev_err_probe(dev, -EINVAL, "Failed to find matching chip ID\n");
> -	tps->chip_id = (unsigned long)match->data;
> +	mdata = (struct tps6594_match_data *)match->data;
> +	tps->chip_id = mdata->chip_id;
> +
> +	tps->regmap = devm_regmap_init(dev, NULL, spi, mdata->config);
> +	if (IS_ERR(tps->regmap))
> +		return dev_err_probe(dev, PTR_ERR(tps->regmap), "Failed to init regmap\n");
>  
>  	crc8_populate_msb(tps6594_spi_crc_table, TPS6594_CRC8_POLYNOMIAL);
>  
> diff --git a/include/linux/mfd/tps6594.h b/include/linux/mfd/tps6594.h
> index 16543fd4d..d781e0fe3 100644
> --- a/include/linux/mfd/tps6594.h
> +++ b/include/linux/mfd/tps6594.h
> @@ -1337,6 +1337,17 @@ struct tps6594 {
>  	struct regmap_irq_chip_data *irq_data;
>  };
>  
> +/**
> + * struct tps6594_match_data - of match data of PMIC
> + *
> + * @chip_id: chip ID of PMIC
> + * @config: regmap config of PMIC
> + */
> +struct tps6594_match_data {
> +	unsigned long chip_id;
> +	const struct regmap_config *config;
> +};
> +
>  extern const struct regmap_access_table tps6594_volatile_table;
>  extern const struct regmap_access_table tps65224_volatile_table;
>  
> -- 
> 2.25.1
> 

-- 
Lee Jones [李琼斯]

