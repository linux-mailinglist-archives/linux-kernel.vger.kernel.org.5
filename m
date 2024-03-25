Return-Path: <linux-kernel+bounces-117948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6422888B1AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2FD2E3985
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE7459B70;
	Mon, 25 Mar 2024 20:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuQiuik9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26317524DC;
	Mon, 25 Mar 2024 20:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399083; cv=none; b=MiKRTcShcbcjWTUTgBviaGFoYwtKxX/yabEd2xapAQ57XEZhjXw2Rb3xvgFhsFOwdTBpJssQb7SBLX0Zg+KWLxVn1qfYyi6EqlkwCO+jMyC/IYOczijP84mkzQWXZX1BLiXAGi7ymV/9kG7Szkb5WVMidCjfBk88kbuBfXAL0B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399083; c=relaxed/simple;
	bh=ZGe6Xs4141t4oUDmliNKaBZx4hbKcfvShq8EAjkgEDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/t2aXZep+kh6Ub5CrK3ghcd3sMNyr4ouAs3BgwVfT7TBcEs80pL561UksrIqkhyT68CS83grjytyHEtM2zee+g5/DGvnq5maCYeDGT3FvDUCkIirjmNIray9MjkwGEikAW5lODsF58lwVRaR4jRU05PpAEDM7hFhohyMcKQYyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuQiuik9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5BBC43390;
	Mon, 25 Mar 2024 20:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711399082;
	bh=ZGe6Xs4141t4oUDmliNKaBZx4hbKcfvShq8EAjkgEDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IuQiuik9FgDUG+61NoxGuXx1PE3g3FgiocqMLwVuV4qmySD/w6KWwiNMlUnRAObtm
	 +d2UZ39haAiK4PFeM5VLpJQzmr/IZe4JyrKxaX7quazNgUBqfwOpe7yOCECdIK3b3K
	 TDs137LY3Vn9P0KBRM76lnvWLQ7EUGbWRRdPdUiC9Dm0x8xttAb0gKzjtA8G4wk2wf
	 vwyWTwsaCDcoI9iN7/hgTY9P1oBzbgwBnNCdWrc1F8Qwrx2S0/bp66Z7xiTwYx/T21
	 1Q6+0dB7s1SFdxVsCQurJJS1RPKOF+QPxkHmT/+0NYmYaTDv+xpKuCAQacPK/n27RW
	 qRbX+0bH6wnPg==
Date: Mon, 25 Mar 2024 20:37:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v4 7/7] iio: accel: adxl345: Add spi-3wire option
Message-ID: <20240325203746.01e834e9@jic23-huawei>
In-Reply-To: <20240325153356.46112-8-l.rubusch@gmail.com>
References: <20240325153356.46112-1-l.rubusch@gmail.com>
	<20240325153356.46112-8-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 15:33:56 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add a setup function implementation to the spi module to enable
> spi-3wire as option when specified in the device-tree.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345.h     |  1 +
>  drivers/iio/accel/adxl345_spi.c | 12 +++++++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> index 620a2e0f0..55a72ca38 100644
> --- a/drivers/iio/accel/adxl345.h
> +++ b/drivers/iio/accel/adxl345.h
> @@ -36,6 +36,7 @@
>  #define ADXL345_DATA_FORMAT_8G		2
>  #define ADXL345_DATA_FORMAT_16G		3
>  #define ADXL345_DATA_FORMAT_MSK		~((u8) BIT(6)) /* ignore spi-3wire */
> +#define ADXL345_DATA_FORMAT_SPI_3WIRE	BIT(6)
If you argue in favour of keeping the MSK as negation of this bit, then
reorder these two and define FORMAT_MSK in terms of SPI_3WIRE.

Note the name of FORMAT_MASK is also an issue now you actually write the 3wire bit.
So I'd get rid of that define in favour of positive defines of all the fields that
make it up used inline as it's only accessed in one place anyway.
That avoids the need for a mask of 'not' something.

>  
>  #define ADXL345_DEVID			0xE5
>  
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


