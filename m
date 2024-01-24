Return-Path: <linux-kernel+bounces-36522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0751F83A24B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3F21C221B9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0849A101C8;
	Wed, 24 Jan 2024 06:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VKMTJvYE"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC142FBFC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706078985; cv=none; b=FdmJuoicG1up0HG98I/3WQwpWqxB4CXKqvq8wj1CQK4/zKpBY1qDZ/XYemJfydKwRSkgLcNb4h3ogpGAXrBCmfEJVDAq47R8N7c18GLWsWT9NMFW5AT7e/hUmLdwUVczvCopsxzyfYO1+j34ZZk7ixFk6aciLWkEZOSV0K7jeH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706078985; c=relaxed/simple;
	bh=HZo5RMjXLjr+Hr00WaHd+Kw9PPwgu+PbXlckjybNqS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I58bI2/ZASaBZUfScaYdFB3DJ3CGkQIralANtxePCemAGd9mPB7w4MSXdRoyI4euJ4fybT7HZfK64A0+3VQWfX4WaLoAsxLKlV7sdTwdMm6TP4j6IOuITIeDA3yNyWPuUkgClWjw/fo8xJudfOOSG99giTZ+2OTxFp515VJ1dkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VKMTJvYE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e8d3b29f2so60862675e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 22:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706078982; x=1706683782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+5dC6oObRCfj9XMiE47OTM/dpbI8m3Cq3OPFmsenlcE=;
        b=VKMTJvYEP8J3pY298liCUQGPPwPR9O9CwaDkpkwS5+86WFYYaTK/p8XgGJ8O+bpJnD
         mHdVaCB4FmhKQaVLxDR3p5e+MxmOANzRVIlwGPXLyOphberWslRjBUL9T2ZSHaBrHLq+
         8X6lTqGhofbrTov7IQYFybgxyPccQhG0GVSEoNJ6Ps42zI2zKU7PcH96UE5I/wNRaycz
         anz1epuU7hk9CaHlKDHOo+t+7BDnvSrNmHiLNQUzyK5Ipp92YRacwbOtJSZo/Ej5Lv9D
         JF2Z4AmJ7ODd5joP9R+z69UqM0D5INpg45VcSn5kQohbIxNo9zILyEloFR3lH0BwdS8o
         GRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706078982; x=1706683782;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5dC6oObRCfj9XMiE47OTM/dpbI8m3Cq3OPFmsenlcE=;
        b=dHwimNLfBIrYSaLSTwqGaFwNKT8x8B3omlrqUZ7myaMhzbQEzYaiiAb8AXpBe1ZzFZ
         L5QzZBeV5ciLGGC2mvNfYbQuj8fu+DvEEl9YheB84koAt/HiVLLswZVbqDFm0MqSkLQz
         WAvUgOnf0Ruc76H/BgGziPjoJPhglZlpJ4svOwhGA+SG4UjBEPkr0v/Jd6ok7rNxmQbs
         PuyjhMVLT7bStLnbSUU7qIXCzmgxbI/Yds0oMwtD9ifWpZ/dVqJcKQ6GscKMx3YdjPUM
         tvEga6XOHFAzKbGgNwyYi44yYMBgOKgd/sM35Xk/DKLfQEcvWyvOM215U5j4XF9pr3ce
         CZ2g==
X-Gm-Message-State: AOJu0YzjcnSjovaXrHx2dDQ6GiT1djUodj6u/I6JCjanKTHxTL/0YCby
	+nXdB7rC4+2E+WYTdJFHqPxbjL+ib+SHsdpySHIUBhM1jwXcfC9nEGYbeo4tQAQ=
X-Google-Smtp-Source: AGHT+IHNOznaWmaenlaG6fZZlWedy3D7fCmkfQzXiVINibSDkgDN0MBf8opIdRA8Lg+U9/J2NB1cvg==
X-Received: by 2002:a05:600c:2152:b0:40d:6af2:f965 with SMTP id v18-20020a05600c215200b0040d6af2f965mr548979wml.106.1706078982058;
        Tue, 23 Jan 2024 22:49:42 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id jg1-20020a05600ca00100b0040d4e1393dcsm47998178wmb.20.2024.01.23.22.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 22:49:41 -0800 (PST)
Message-ID: <9c9e71ff-42ab-4753-80cf-09b34a97b28c@linaro.org>
Date: Wed, 24 Jan 2024 06:49:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] spi: s3c64xx: Add Exynos850 support
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Andi Shyti <andi.shyti@kernel.org>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
References: <20240120012948.8836-1-semen.protsenko@linaro.org>
 <20240120012948.8836-6-semen.protsenko@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240120012948.8836-6-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/20/24 01:29, Sam Protsenko wrote:
> Add SPI port configuration for Exynos850 SoC. It has 3 USI blocks which
> can be configured in SPI mode:
> 
>   * spi_0: BLK_PERI_SPI_0 (0x13940000)
>   * spi_1: BLK_ALIVE_USI_CMGP00 (0x11d00000)
>   * spi_2: BLK_ALIVE_USI_CMGP01 (0x11d20000)
> 
> SPI FIFO depth is 64 bytes for all those SPI blocks, so the
> .fifo_lvl_mask value is set to 0x7f. All blocks have DIV_4 as the
> default internal clock divider, and an internal loopback mode to run
> a loopback test.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/spi/spi-s3c64xx.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 0e48ffd499b9..f7d623ad6ac3 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1461,6 +1461,17 @@ static const struct s3c64xx_spi_port_config exynos5433_spi_port_config = {
>  	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
>  };
>  
> +static const struct s3c64xx_spi_port_config exynos850_spi_port_config = {
> +	.fifo_lvl_mask	= { 0x7f, 0x7f, 0x7f },

I'll come with a follow up patch on top of this. Having the dt alias
used as an index in the fifo_lvl_mask to determine the FIFO depth is
wrong. Not only because of the dependency on the alias, but also because
the fifo_lvl_mask value does not reflect the FIFO level reg field.
Playing with what we have now is ok by me, I find the patch good.

> +	.rx_lvl_offset	= 15,
> +	.tx_st_done	= 25,
> +	.clk_div	= 4,
> +	.high_speed	= true,
> +	.clk_from_cmu	= true,
> +	.has_loopback	= true,
> +	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
> +};
> +
>  static const struct s3c64xx_spi_port_config exynosautov9_spi_port_config = {
>  	.fifo_lvl_mask	= { 0x1ff, 0x1ff, 0x7f, 0x7f, 0x7f, 0x7f, 0x1ff, 0x7f,
>  			    0x7f, 0x7f, 0x7f, 0x7f},
> @@ -1515,6 +1526,9 @@ static const struct of_device_id s3c64xx_spi_dt_match[] = {
>  	{ .compatible = "samsung,exynos5433-spi",
>  			.data = (void *)&exynos5433_spi_port_config,
>  	},
> +	{ .compatible = "samsung,exynos850-spi",
> +			.data = (void *)&exynos850_spi_port_config,
> +	},
>  	{ .compatible = "samsung,exynosautov9-spi",
>  			.data = (void *)&exynosautov9_spi_port_config,
>  	},

