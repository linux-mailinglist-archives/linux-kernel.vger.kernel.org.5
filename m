Return-Path: <linux-kernel+bounces-112677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BD2887CDD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9291F2141E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70D017C67;
	Sun, 24 Mar 2024 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucYM9CXx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18162175A9;
	Sun, 24 Mar 2024 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711287174; cv=none; b=qyuR7C4VOVTzrygO2hNlgBS8/i1+s3Rh7IJ95+pnix55k1OnE6pfTwPxR0VpQfldc1UVt6j09bVkTiBv6wWEgEanMkgnitqiVQu8H7L8U/udY5kCX2YdWzHjvbJO+T3UXTTjxbrD+oDHiEjIqzZIDr+1sL7wiL5JbJjBZBXhYx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711287174; c=relaxed/simple;
	bh=lMpJbn0jMfVtJuDiKJdlLZCG8tJ+7rZ7q4TQYYYrzmM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSAG5rKP/SBr2g4Yl4PXLUKItJ9RLD4g1sA/FEF2dLjCJyNhAIJ37Mr+KhWUpreuev4pUCCR1K3JQx0Rwdkb3sio2G4UNOUizvmqWE4YBTmUJOxh0eXVt/C93bLgvTz4weLXObeZ6qOQKN0euAbsYOATWIpR7WX69SU0Zl17Fek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucYM9CXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714E7C433C7;
	Sun, 24 Mar 2024 13:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711287173;
	bh=lMpJbn0jMfVtJuDiKJdlLZCG8tJ+7rZ7q4TQYYYrzmM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ucYM9CXxmHNLriEvreHE4tDuaYB1bo6iRGaTdD/moadipVu1eKL9QxDVDu1QTXZ5x
	 JrHJIJWR2DRa3NPYpXS2lL5kpBe0Oo7iOR1SmXORk5/ZQ6RVs5MzSzQk7YhezrTKp0
	 9ml69IX2NPRJT9FfwkY5RRWN6ObiF5fvaZC5TbVfzAPeLeavq2x7kFqI6nqFCsNsiK
	 /EmVrL5OHnzNn/LY1v3q5+MTvbSMch1AJYYu+9Tul/NDSmPsd45NXvdiu8fFUEgdfa
	 YvDFBCEUzthpI5Xt5zFoym0z+ybRQgzObYvrQ1qwJWHNDsgST3QiBfS0iFpTGhqtaG
	 6wMetPZzOMT0Q==
Date: Sun, 24 Mar 2024 13:32:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v3 3/6] iio: accel: adxl345: Add spi-3wire option
Message-ID: <20240324133238.61d5f989@jic23-huawei>
In-Reply-To: <20240323122030.21800-4-l.rubusch@gmail.com>
References: <20240323122030.21800-1-l.rubusch@gmail.com>
	<20240323122030.21800-4-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Mar 2024 12:20:27 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add a setup function implementation to the spi module to enable
> spi-3wire as option when specified in the device-tree.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345.h     |  3 +++
>  drivers/iio/accel/adxl345_spi.c | 12 +++++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> index 3c1ded0c2..6b84a2cee 100644
> --- a/drivers/iio/accel/adxl345.h
> +++ b/drivers/iio/accel/adxl345.h
> @@ -8,6 +8,9 @@
>  #ifndef _ADXL345_H_
>  #define _ADXL345_H_
>  
> +#define ADXL345_REG_DATA_FORMAT		0x31
> +#define ADXL345_DATA_FORMAT_SPI         BIT(6) /* spi-3wire */
Name it that, rather than using a comment.   No need to precisely
match datasheet naming - you are naming the value not the field here.

ADXL345_DATA_FORMAT_SPI_3_WRITE perhaps?

> +
>  /*
>   * In full-resolution mode, scale factor is maintained at ~4 mg/LSB
>   * in all g ranges.
> diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
> index 1c0513bd3..1094396ac 100644
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
> +			    ADXL345_DATA_FORMAT_SPI);
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
> +	return adxl345_core_probe(&spi->dev, regmap, &adxl345_spi_setup);
>  }
>  
>  static const struct adxl345_chip_info adxl345_spi_info = {


