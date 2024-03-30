Return-Path: <linux-kernel+bounces-125766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC442892BD9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879FC282C39
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 15:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBE039AF4;
	Sat, 30 Mar 2024 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lrj7TQ/m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B021AEBB;
	Sat, 30 Mar 2024 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711812604; cv=none; b=LwpXCpkXJ++9kldJ2gbZYIxa3DSUcxSk8lkMGjc5IfTpPCt/sm4Y/UFrTK4S5p9hNXRuklxOq0kD4l5ljrMRuP+/nwKtMMjTQDXk/5tIURgXPPn+yzoOSa/KDfO4SQWWwjCGuacIOFhhg7GWW0s9Wj2fxNA7rX0oAObBQ+Cxh2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711812604; c=relaxed/simple;
	bh=Pbmbq7nuZF3H9Ax34ZWnOo7CvSuQfF6wpVQhJF2egis=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQUG26/YfyIyilJH/7i29+CVrBKTsAZrAsg/ev1s0GZvKwCPRNTvVH4Iuv8Bk6wdaxysA/tkONoXfx2WeQ6tUomGv9K/2YIaHCoavYtikB7erMTVmdjbWqQ+48grpmndtjoEkas/leVpHDyoWoI/KrZGecFsCiOtJUjwLwhtf3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lrj7TQ/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E8CC433C7;
	Sat, 30 Mar 2024 15:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711812603;
	bh=Pbmbq7nuZF3H9Ax34ZWnOo7CvSuQfF6wpVQhJF2egis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lrj7TQ/mWOtTKEO7HXWRap81QLzCuJXGrzduzwDYUuKT7dBnPugagRgA9yyRJZKRq
	 1Vz9g9oi1AQefGVh2IlRneycGjFn2uYm2qTT7mQF1jFDEmgjtzsFwgj4Gw3fFcQ1zD
	 xdfbf+Vcmjac6uxQ74uT2mcvM4rnymr86+T/FNdN/tNj6MbwK35HIZF+84YLra298N
	 YemMIHgeFOJ3jNDZ6m3rmNmukVYMchWp/0hqU7z95DHt/9Zz+tUF/8hOAmaJgs3nvs
	 92jj0DS1S9LnEyzJp7dcoJHbNYWc1MfnVdpVsSTTt2hcqZYr520M0vMoVQcTPvkiT8
	 lTpssbNk7hgZA==
Date: Sat, 30 Mar 2024 15:29:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v6 7/7] iio: accel: adxl345: Add spi-3wire option
Message-ID: <20240330152949.7e10ebcc@jic23-huawei>
In-Reply-To: <20240329004030.16153-8-l.rubusch@gmail.com>
References: <20240329004030.16153-1-l.rubusch@gmail.com>
	<20240329004030.16153-8-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Mar 2024 00:40:30 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add a setup function implementation to the spi module to enable spi-3wire
> when specified in the device-tree.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345.h     |  1 +
>  drivers/iio/accel/adxl345_spi.c | 12 +++++++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> index e859c01d4..3d5c8719d 100644
> --- a/drivers/iio/accel/adxl345.h
> +++ b/drivers/iio/accel/adxl345.h
> @@ -31,6 +31,7 @@
>  #define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0)	/* Set the g range */
>  #define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2)	/* Left-justified (MSB) mode */
>  #define ADXL345_DATA_FORMAT_FULL_RES	BIT(3)	/* Up to 13-bits resolution */
> +#define ADXL345_DATA_FORMAT_SPI_3WIRE	BIT(6)	/* 3-wire SPI mode */
>  #define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)	/* Enable a self test */
>  
>  #define ADXL345_DATA_FORMAT_2G		0
> diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
> index 1c0513bd3..f145d5c1d 100644
> --- a/drivers/iio/accel/adxl345_spi.c
> +++ b/drivers/iio/accel/adxl345_spi.c
> @@ -20,6 +20,16 @@ static const struct regmap_config adxl345_spi_regmap_config = {
>  	.read_flag_mask = BIT(7) | BIT(6),
>  };
>  
> +static int adxl345_spi_setup(struct device *dev, struct regmap *regmap)
> +{
> +	struct spi_device *spi = container_of(dev, struct spi_device, dev);
> +
> +	if (spi->mode & SPI_3WIRE)
> +		return regmap_write(regmap, ADXL345_REG_DATA_FORMAT,
> +				    ADXL345_DATA_FORMAT_SPI_3WIRE);
My only remaining comment on this patch set is to add equivalent of
	else
		return regmap_write(regmap, ADXL345_REG_DATA_FORMAT, 0);

If the hardware had some sort of software reset, that was used,
this wouldn't be needed as the status of those other bits would be known.
If we leave them alone in the non 3wire path we may in the future have
subtle issues because some other code left this in an odd state and
we clear those other bits only for 3wire mode.

Jonathan

> +	return 0;
> +}
> +
>  static int adxl345_spi_probe(struct spi_device *spi)
>  {
>  	struct regmap *regmap;
> @@ -33,7 +43,7 @@ static int adxl345_spi_probe(struct spi_device *spi)
>  	if (IS_ERR(regmap))
>  		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
>  
> -	return adxl345_core_probe(&spi->dev, regmap, NULL);
> +	return adxl345_core_probe(&spi->dev, regmap, adxl345_spi_setup);
>  }
>  
>  static const struct adxl345_chip_info adxl345_spi_info = {


