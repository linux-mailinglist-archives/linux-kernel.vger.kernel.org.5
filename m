Return-Path: <linux-kernel+bounces-122968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B429F890081
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695681F24263
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE0481AD2;
	Thu, 28 Mar 2024 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5fBy3uT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCA07D3F1;
	Thu, 28 Mar 2024 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633183; cv=none; b=uoTGRySc5sZGpOTo/pHKSsE2oc6T3SapEFIXQI/loB83AR3L36+c97bbd3OoOdusxlX1MNNkIuzARhC7FNZuBzrv45zKXVUGB5vuCnR8wAcHNQo18KyJkZlT4VyDjldPd/jCMoMYaBHSTEGjiAvDgiUtH/8HUFJvXvax3e23750=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633183; c=relaxed/simple;
	bh=oiJhaXMCcSk1SSRDKfA/NQgNG7kywPosk1xWJQ+Gz6I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QVNzRecDWQSEiy2lhhhSOSIKi8dXAn5gqP1U9z8d4YqG9yzoxLTcgblOZVjiixFzd8sYeaZwoJf5viGlWAg/JynN4WjmAF7SDi3oxIDNuJyZ6wVFQYnTN9yo2++mu1Tw5NSxl2ep8+OiatqOTOoqZwpF1hnaZbDYwCJYorgg/AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5fBy3uT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447EBC433C7;
	Thu, 28 Mar 2024 13:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711633183;
	bh=oiJhaXMCcSk1SSRDKfA/NQgNG7kywPosk1xWJQ+Gz6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m5fBy3uT2S7O4yVD4TaMmwGhXjT9q6Nqew5Ms3LaeXB93BGWXiO2RpMMeqYTmGxL7
	 YVAVacyRb/mkEPIWh1wUh3zCHrF+yG7t0Axdpd0vaOF+6ET5Pkuke+RiYU4Y0+pTzU
	 HCcCOz5SWXZlyGV5SeZf+ADsfSpxk58exb2mv/mKTSSHAXPgXfREEfMMwTYNXwzEnD
	 Ms1ibAMA65Worg4XerPjSjzFRmhm5/BWLeyZ6C0NXt6QQ41+J6sQbch9ncIdVMJppY
	 hZ8FYCwoQh/fxCIdmHdXNfnOyU8jx3HlIEusA1+1maH0VLgG+p4jTYo3bRfnCPrlYn
	 /ZnjwNqViDciw==
Date: Thu, 28 Mar 2024 13:39:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v5 7/7] iio: accel: adxl345: Add spi-3wire option
Message-ID: <20240328133927.7e49f3bf@jic23-huawei>
In-Reply-To: <20240327220320.15509-8-l.rubusch@gmail.com>
References: <20240327220320.15509-1-l.rubusch@gmail.com>
	<20240327220320.15509-8-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 22:03:20 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add a setup function implementation to the spi module to enable spi-3wire
> as option when specified in the device-tree.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345.h     |  2 ++
>  drivers/iio/accel/adxl345_spi.c | 12 +++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> index 4ea9341d4..e6bc3591c 100644
> --- a/drivers/iio/accel/adxl345.h
> +++ b/drivers/iio/accel/adxl345.h
> @@ -30,6 +30,8 @@
>  #define ADXL345_POWER_CTL_MEASURE	BIT(3)
>  #define ADXL345_POWER_CTL_STANDBY	0x00
>  
> +#define ADXL345_DATA_FORMAT_SPI_3WIRE	BIT(6) /* 3-wire SPI mode */
> +
>  #define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0) /* Set the g range */
>  #define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2) /* Left-justified (MSB) mode */
>  #define ADXL345_DATA_FORMAT_FULL_RES	BIT(3) /* Up to 13-bits resolution */
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
Your earlier patch carefully (I think) left one or two fields alone, then
this write just comes in and changes them. In particular INT_INVERT.

If it doesn't makes sense to write it there, either write that bit
every time here, or leave it alone every time.  Not decide on whether
to write the bit based on SPI_3WIRE or not.  As far as I know they
are unconnected features.

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


