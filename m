Return-Path: <linux-kernel+bounces-152797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F00D18AC46B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CCF282E54
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D2B48CDD;
	Mon, 22 Apr 2024 06:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ToPa2XSz"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AF2482DD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713768074; cv=none; b=FB74wCVPdLspdvhZXqEg/QWN/7BGhuvnn7jYfjX774tGeQ/wxsmrQYWAffahV1Rnwo86+DJZ+J3o1B2ouQ7Df5o/pBtOMvMw1++Ixdk1ZeZgL9AAdqz47xTcl2ZyujWXxLSINJqURvZhH2GRouZonJHsPxIIO3MGytWnbY9Bt6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713768074; c=relaxed/simple;
	bh=2kiy9wKYCMJpfEz60az6FgPJ48nJ1mHZTsoofiAFxwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KldK8jqbHs4GPR400GmmSZ2ssnJxdMC5AEM0bPI0EMsZBXsJEC9aQJiiBeLPuFZeI7zl/GnCg1I4pno9rVqLXodXAFXafDJyHsgo8ri0FdN03A9ftRWVx0AUjcGapag0q/eKgix0uDNTIaWztEmgJ6d81rOvf99uHzq37Mlauro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ToPa2XSz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41a70466b77so2016975e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 23:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713768071; x=1714372871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+IHMmWa7PCm5h8KXXIvVWID6BVHToSqTvpYZtQwLUQk=;
        b=ToPa2XSzBK46oq/e41jfJlvKDsW8NjKaf/esunPLY7fDsunm2twY6PShm/lNi5jL1x
         WtEQxCbMMlZMluhvCSJeO+2hd/cEGRSCXauJ1ECB3s5tyQcOWKn1uRMRrHKcYEaNWGAF
         QkqpgvmxlDLSF+vyEIHO3FaHSSC9Baye1UDPag/CSeBfkB6yJV+hEoVTDTEdSBCfOFaU
         W0OXUKcbpO8dzXuZtvZ16lB3P6YSN6zTEKE6USeAYo5fxEHd4Epqg2bNJndyKWsUt+hD
         WSzUivssP/4/EKM0U14XL71C8vZYRas+JhTfzHrkR13PEKy/mtBqfcCwsKP3bR8Huw5g
         zk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713768071; x=1714372871;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+IHMmWa7PCm5h8KXXIvVWID6BVHToSqTvpYZtQwLUQk=;
        b=JeIF1ir7yq2uKxu0+DSHkuXbT1KJ/86zDgVQafl4MqbRbSMJP5evoMLPhtVNSt7BQ6
         FD6thy4W+Xr2rwOatpjIQvEoUAM+ih74em9D+YBpBqu4kELS1LVwUvk/Hvxbk3T2lUhl
         cO5BOLuTnVa1sjQDkGAyoq1AokAC01EgOYma502k20ltyjOMp0Y2Y06ug+TkIH+xYgfC
         NkoWBiEqbKmCTReqwH6Mvlocn6bO4Knyu4M4amH6Ot7yVnTJb1HACtWOU0Uwn4o1cp7Y
         /JXv4npFRqU8tl2IrFYFlco2uzU6HZd/ReDSYe8hBOlLWT+cK9zJknrrUD2kynbym4lW
         nRuA==
X-Forwarded-Encrypted: i=1; AJvYcCW+DG4T57FF38hZGu5Osf7YoIbOKQiYtJTIAoXor4Y0HTs1U/mbg3mbnz+nMx059qM0wfTjPfrF+dbyOrh8A9RT6QrQS4AhMOM0vqeg
X-Gm-Message-State: AOJu0YyEUcLpVHI2ZustX6j8ncK4YUwUfYiWxqJB1PTLWJphXsdi1smV
	xIeE/jnPC9NEKRu47J/11pF2MuH7ZPaOGAcejdFtkvGbKl+UDV6VtQGD+dIFLa4=
X-Google-Smtp-Source: AGHT+IEW9O3L/i7BiWlbcsSQolNhambRTqEe1b8s9RDn7Ue11cH9c0q2wutS4BoKQT65qaxLYC8MWQ==
X-Received: by 2002:a05:600c:4587:b0:417:e00c:fdb8 with SMTP id r7-20020a05600c458700b00417e00cfdb8mr9055250wmo.1.1713768070878;
        Sun, 21 Apr 2024 23:41:10 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.100])
        by smtp.gmail.com with ESMTPSA id be7-20020a05600c1e8700b0041a5b68ea32sm2186473wmb.27.2024.04.21.23.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 23:41:10 -0700 (PDT)
Message-ID: <ea3b32a8-7a1c-4a32-beb5-acc6f6435954@linaro.org>
Date: Mon, 22 Apr 2024 07:41:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] mtd: spi-nor: simplify spi_nor_get_flash_info()
To: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Ricardo Ribalda <ribalda@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20240419141249.609534-1-mwalle@kernel.org>
 <20240419141249.609534-6-mwalle@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240419141249.609534-6-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/19/24 15:12, Michael Walle wrote:
> Rework spi_nor_get_flash_info() to make it look more straight forward
> and esp. don't return early. The latter is a preparation to check for
> deprecated flashes.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> ---
>  drivers/mtd/spi-nor/core.c | 45 ++++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 4e2ae6642d4c..8e4ae1317870 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3294,39 +3294,36 @@ static const struct flash_info *spi_nor_match_name(struct spi_nor *nor,
>  static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
>  						       const char *name)
>  {
> -	const struct flash_info *info = NULL;
> +	const struct flash_info *jinfo = NULL, *info = NULL;
>  
>  	if (name)
>  		info = spi_nor_match_name(nor, name);
> -	/* Try to auto-detect if chip name wasn't specified or not found */
> -	if (!info)
> -		return spi_nor_detect(nor);
> -
>  	/*
> -	 * If caller has specified name of flash model that can normally be
> -	 * detected using JEDEC, let's verify it.
> +	 * Auto-detect if chip name wasn't specified or not found, or the chip
> +	 * has an ID. If the chip supposedly has an ID, we also do an
> +	 * auto-detection to compare it later.
>  	 */
> -	if (name && info->id) {
> -		const struct flash_info *jinfo;
> -
> +	if (!info || info->id) {
>  		jinfo = spi_nor_detect(nor);
> -		if (IS_ERR(jinfo)) {
> +		if (IS_ERR(jinfo))
>  			return jinfo;
> -		} else if (jinfo != info) {

you can remove else if with if (jinfo != info)

> -			/*
> -			 * JEDEC knows better, so overwrite platform ID. We
> -			 * can't trust partitions any longer, but we'll let
> -			 * mtd apply them anyway, since some partitions may be
> -			 * marked read-only, and we don't want to loose that
> -			 * information, even if it's not 100% accurate.
> -			 */
> -			dev_warn(nor->dev, "found %s, expected %s\n",
> -				 jinfo->name, info->name);

keep the warning where it was
> -			info = jinfo;

move this so that it belongs to if (!info || info->id)
> -		}
>  	}
>

and then return info. Does it work?


	if (name)
		info = spi_nor_match_name(nor, name);

	if (!info || info->id) {
		jinfo = spi_nor_detect(nor);
		if (IS_ERR(jinfo))
			return jinfo;
		
		if (jinfo != info)
			dev_warn(();
		info = jinfo;
	}

	return info;

> -	return info;
> +	/*
> +	 * If caller has specified name of flash model that can normally be
> +	 * detected using JEDEC, let's verify it.
> +	 */
> +	if (info && jinfo && jinfo != info)> +		dev_warn(nor->dev, "found %s, expected %s\n",
> +			 jinfo->name, info->name);
> +
> +	/*
> +	 * JEDEC knows better, so overwrite platform ID. We can't trust
> +	 * partitions any longer, but we'll let mtd apply them anyway, since
> +	 * some partitions may be marked read-only, and we don't want to loose
> +	 * that information, even if it's not 100% accurate.
> +	 */
> +	return jinfo ?: info;

