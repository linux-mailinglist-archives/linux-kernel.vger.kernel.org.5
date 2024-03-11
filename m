Return-Path: <linux-kernel+bounces-99292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 764B1878615
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16ED4B21113
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378914D9E8;
	Mon, 11 Mar 2024 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KH/wP4q0"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A944AEC5;
	Mon, 11 Mar 2024 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710177066; cv=none; b=U5gvDZ4Odk6emqiyMJFEqiSfdSW9oaRqbEsD8BJ87NjoeShL4ctLSp7w3Hco22CCzrekm9C7bFpXhGu5Ssr3ziNHrpM4X5FSd6zgB5WTud4FPrCTZ4RJ3B487tzsG/1EjAXzp7k3xSa76dsHp2pRCn87UAEp5egvO//DrCwcT1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710177066; c=relaxed/simple;
	bh=+lBe23s/WG6muqa4DBbIpUBMBeF/WOWUU+ZtlFupPx8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mjBJW9M5isj6Nh+ftFoMt/GD/1hVZaWA2AU63Z6RePY/wU3IpvPrw+L5Y31zMewZfp+Hmo97HWGINMZOGb6s6A+GWMetx4SDfwMIk1Dc+zPei8g/wcGPTasD6Ug3nzUE0VlEHstMv+EVt4Den1hkWT5OEsy4V+Ke6YCY/Xf2Q4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KH/wP4q0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710177063;
	bh=+lBe23s/WG6muqa4DBbIpUBMBeF/WOWUU+ZtlFupPx8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=KH/wP4q03T8xPtqjrF1mQDBjJ7uFFF0tAoSP37d4ex4ee2AYE6fmE2A3EBPxWr5uH
	 i2ESweQDRMRO7DXqpnEwoNkQKnwkkbB8MwCg8bnYvuZoZMw5A3x6q00ykvCW37WrE2
	 L5zl/kHumRmGSP8qJlieiffr/Y27P4cI8gEZjIKf6R9dNsWQplboZpeNShG719gheL
	 ptCfxdmTPN572sl8mGhosZXLIwhFUL6RwudnHWPr4JBx97YrAonrRYl3TCyyNTulXz
	 vC9Z9LRHZTspNnyMVjLUICm+veAY/4sTCedd3Xr1guQ6G8u5yoERpzwkC2WE6Ea5zE
	 yWxz3+vwzWByg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5A4C9378200D;
	Mon, 11 Mar 2024 17:10:59 +0000 (UTC)
Message-ID: <865fc24b-ae27-4084-893b-c5c389480a09@collabora.com>
Date: Mon, 11 Mar 2024 22:11:33 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 kernel-janitors@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spi-nor: core: correct type of i
Content-Language: en-US
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <20240304090103.818092-1-usama.anjum@collabora.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240304090103.818092-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Soft reminder

On 3/4/24 2:01 PM, Muhammad Usama Anjum wrote:
> The i should be signed to find out the end of the loop. Otherwise,
> i >= 0 is always true and loop becomes infinite. Make its type to be
> int.
> 
> Fixes: 6a9eda34418f ("mtd: spi-nor: core: set mtd->eraseregions for non-uniform erase map")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Make i int instead of u8
> ---
>  drivers/mtd/spi-nor/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 65b32ea59afc6..3e1f1913536bf 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3373,7 +3373,7 @@ static u32
>  spi_nor_get_region_erasesize(const struct spi_nor_erase_region *region,
>  			     const struct spi_nor_erase_type *erase_type)
>  {
> -	u8 i;
> +	int i;
>  
>  	if (region->overlaid)
>  		return region->size;

-- 
BR,
Muhammad Usama Anjum

