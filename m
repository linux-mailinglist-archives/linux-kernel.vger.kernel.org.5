Return-Path: <linux-kernel+bounces-112678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C83887CE0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9EE21F213E7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D684F17C69;
	Sun, 24 Mar 2024 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rielj8q0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E424CA64;
	Sun, 24 Mar 2024 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711287352; cv=none; b=mDQfzaeJXR+n+cVLvQDFdNelOU5Xki43OGjvkkQ7fVXdTnSCgBc+WvVZC29CqRYIQMWE5uKH1k4qlLBhuAff6Q6AuD+K2QOO7/kNAxlrJ6AgdxHPBgDqwBhDYxGvjxS7q+G02wD79PS2UlVX2D/m1LnnAT/lsRkxrZblJnDc1Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711287352; c=relaxed/simple;
	bh=OkxuCRwTUyfG7O9E8DB3iGOMcj/7xSlVhqkGY+Ozj4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDx0iS6+VarVMC/XoKnC+ZnkBv4j5UF0ARPvMmOmCOdsV3BoX3MB5OQCIrc/e35dozDz5TG/dvncTVEkl8Ilajm5Lsk44Hka56k6UJespxaLLC1vMoUG7f+rXiTWl+83kEYap+EwxzINXs27HVJNcs6+2CKfuNRT2Mq1uvC8XKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rielj8q0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81D8C433C7;
	Sun, 24 Mar 2024 13:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711287351;
	bh=OkxuCRwTUyfG7O9E8DB3iGOMcj/7xSlVhqkGY+Ozj4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rielj8q0mCnEby5eS02HxFl1YtyQgh+X20gfLxbLAxP0jPysUco4gBsCeJIp8uOoP
	 uU3npM8G8C6Gdxckchw8L8m0n5+hKvLiZuu4DhtUKXkkcjW81T3GSNoYLnJ3rndNPJ
	 qALlqSN9sOZ+lQyFq/pcNg9UaCVQXi4NZ4MpFIT4Usg+7MGrtx++NvX1JuN9OVgqIU
	 Di+rEcUZFAYI2IEOSFqK0jZSfroQgZsLGIvKPnv39GxSXoXLJkZASEqMw2E8VRsLd9
	 8yrWZqSRTHn0gO6wvnImuHXgLG5C8OhpRWmH1eXJV/FXmfFUN4hFxpRVCE+tMEplrn
	 rU04S0JwCrhRg==
Date: Sun, 24 Mar 2024 13:35:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v3 4/6] iio: accel: adxl345: Remove single info
 instances
Message-ID: <20240324133536.01067770@jic23-huawei>
In-Reply-To: <20240323122030.21800-5-l.rubusch@gmail.com>
References: <20240323122030.21800-1-l.rubusch@gmail.com>
	<20240323122030.21800-5-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Mar 2024 12:20:28 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add a common array adxl3x5_chip_info and an enum for
> indexing. This allows to remove local redundantly
> initialized code in the bus specific modules.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345.h      |  7 +++++++
>  drivers/iio/accel/adxl345_core.c | 12 ++++++++++++
>  drivers/iio/accel/adxl345_i2c.c  | 20 +++++---------------
>  drivers/iio/accel/adxl345_spi.c  | 20 +++++---------------
>  4 files changed, 29 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> index 6b84a2cee..de6b1767d 100644
> --- a/drivers/iio/accel/adxl345.h
> +++ b/drivers/iio/accel/adxl345.h
> @@ -26,11 +26,18 @@
>   */
>  #define ADXL375_USCALE	480000
>  
> +enum adxl345_device_type {
> +	ADXL345,
> +	ADXL375,
> +};
> +
>  struct adxl345_chip_info {
>  	const char *name;
>  	int uscale;
>  };
>  
> +extern const struct adxl345_chip_info adxl3x5_chip_info[];
> +
>  int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  		       int (*setup)(struct device*, struct regmap*));
>  
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 33424edca..e3718d0dd 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -62,6 +62,18 @@ struct adxl345_data {
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
>  }
>  
> +const struct adxl345_chip_info adxl3x5_chip_info[] = {
> +	[ADXL345] = {
> +		.name = "adxl345",
> +		.uscale = ADXL345_USCALE,
> +	},
> +	[ADXL375] = {
> +		.name = "adxl375",
> +		.uscale = ADXL375_USCALE,
> +	},
> +};
> +EXPORT_SYMBOL_NS_GPL(adxl3x5_chip_info, IIO_ADXL345);

There is little advantage here form using an array.  I'd just have
two exported structures.   Then the name alone is enough in the
id tables.  And probably no need for the enum definition.

This use of arrays is an old pattern that makes little sense if the
IDs have no actual meaning and you aren't supporting lots of different
parts.  For 2 parts I'd argue definitely not worth it.

> +
>  static const struct iio_chan_spec adxl345_channels[] = {
>  	ADXL345_CHANNEL(0, X),
>  	ADXL345_CHANNEL(1, Y),
> diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
> index 4065b8f7c..afb2d0b79 100644
> --- a/drivers/iio/accel/adxl345_i2c.c
> +++ b/drivers/iio/accel/adxl345_i2c.c
> @@ -30,32 +30,22 @@ static int adxl345_i2c_probe(struct i2c_client *client)
>  	return adxl345_core_probe(&client->dev, regmap, NULL);
>  }
>  
> -static const struct adxl345_chip_info adxl345_i2c_info = {
> -	.name = "adxl345",
> -	.uscale = ADXL345_USCALE,
> -};
> -
> -static const struct adxl345_chip_info adxl375_i2c_info = {
> -	.name = "adxl375",
> -	.uscale = ADXL375_USCALE,
> -};
> -
>  static const struct i2c_device_id adxl345_i2c_id[] = {
> -	{ "adxl345", (kernel_ulong_t)&adxl345_i2c_info },
> -	{ "adxl375", (kernel_ulong_t)&adxl375_i2c_info },
> +	{ "adxl345", (kernel_ulong_t)&adxl3x5_chip_info[ADXL345] },
> +	{ "adxl375", (kernel_ulong_t)&adxl3x5_chip_info[ADXL375] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
>  
>  static const struct of_device_id adxl345_of_match[] = {
> -	{ .compatible = "adi,adxl345", .data = &adxl345_i2c_info },
> -	{ .compatible = "adi,adxl375", .data = &adxl375_i2c_info },
> +	{ .compatible = "adi,adxl345", .data = &adxl3x5_chip_info[ADXL345] },
> +	{ .compatible = "adi,adxl375", .data = &adxl3x5_chip_info[ADXL375] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, adxl345_of_match);
>  
>  static const struct acpi_device_id adxl345_acpi_match[] = {
> -	{ "ADS0345", (kernel_ulong_t)&adxl345_i2c_info },
> +	{ "ADS0345", (kernel_ulong_t)&adxl3x5_chip_info[ADXL345] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, adxl345_acpi_match);
> diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
> index 1094396ac..5c1109136 100644
> --- a/drivers/iio/accel/adxl345_spi.c
> +++ b/drivers/iio/accel/adxl345_spi.c
> @@ -46,32 +46,22 @@ static int adxl345_spi_probe(struct spi_device *spi)
>  	return adxl345_core_probe(&spi->dev, regmap, &adxl345_spi_setup);
>  }
>  
> -static const struct adxl345_chip_info adxl345_spi_info = {
> -	.name = "adxl345",
> -	.uscale = ADXL345_USCALE,
> -};
> -
> -static const struct adxl345_chip_info adxl375_spi_info = {
> -	.name = "adxl375",
> -	.uscale = ADXL375_USCALE,
> -};
> -
>  static const struct spi_device_id adxl345_spi_id[] = {
> -	{ "adxl345", (kernel_ulong_t)&adxl345_spi_info },
> -	{ "adxl375", (kernel_ulong_t)&adxl375_spi_info },
> +	{ "adxl345", (kernel_ulong_t)&adxl3x5_chip_info[ADXL345] },
> +	{ "adxl375", (kernel_ulong_t)&adxl3x5_chip_info[ADXL375] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, adxl345_spi_id);
>  
>  static const struct of_device_id adxl345_of_match[] = {
> -	{ .compatible = "adi,adxl345", .data = &adxl345_spi_info },
> -	{ .compatible = "adi,adxl375", .data = &adxl375_spi_info },
> +	{ .compatible = "adi,adxl345", .data = &adxl3x5_chip_info[ADXL345] },
> +	{ .compatible = "adi,adxl375", .data = &adxl3x5_chip_info[ADXL375] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, adxl345_of_match);
>  
>  static const struct acpi_device_id adxl345_acpi_match[] = {
> -	{ "ADS0345", (kernel_ulong_t)&adxl345_spi_info },
> +	{ "ADS0345", (kernel_ulong_t)&adxl3x5_chip_info[ADXL345] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, adxl345_acpi_match);


