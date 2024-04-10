Return-Path: <linux-kernel+bounces-138305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CC989EF94
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3EE1F23B40
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEEC158A24;
	Wed, 10 Apr 2024 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="zDaaLyvD"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2D013D606;
	Wed, 10 Apr 2024 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743655; cv=none; b=RKTzAe4i8YOoLg8+7HZrU3TGCxTrbg3NXggsvuyB/3HRDJAUCUymdqmotsR6K9t2WkGfZdGxpIZLqdVFq+zbK2UaVT7c45NMiuqCC7i9kRWt8BqjuY+b75oVa8RuyuSgI12cxhR8JINcqBE0C0KivUVtMcfVfHkK3Tvy8zogqOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743655; c=relaxed/simple;
	bh=L7YBVL+XZ2VzkgoJkD+hlJcRUOM0nGUw0aD6v+UvR1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XmVb1A2VYeJZBOH/3KtazMnBmAnABTjYbBtdVsffRnDyT4a1Gk8chf+inDLuFRDdf7+Qt0ajQ3JhdT1u58ESM0Qci1dloSS9jbkkGfu/1VJsR/uTML8r7Kj4UntPDW1LGTPTVOViikn4+y9iS3yOgpSsJya4J3GtyyJG9kZUgbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=zDaaLyvD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712743650;
	bh=L7YBVL+XZ2VzkgoJkD+hlJcRUOM0nGUw0aD6v+UvR1I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=zDaaLyvDnhGU8YvyVvaBf45X06tNM3lZGjEFYYBIDpNMabnM0jTsZhCK8AflDmL4c
	 yHIeqDvSrbvbTfqfKXBmGKi0FSHVCbipEoHLpFibLeZQHOij6FlNssiGUkc9ZPz7J/
	 A4zZfAakrVAHUiy3LG0M+vkQMLw5eHGJ3EVF50CVmwlmxPHJl7Gv8Dhw3XYpRGBz2O
	 lU10xT6RCwXVL6p0KwOQiCntzwh0CqueNZj1ZByppKOXx8Cs3WcANhKvanylO1MaDA
	 WXclW8oNrSmIJP3rkYtqfNbIYp+klkM8PxWHYDgHVO40inPr0YkgxiDpIJ4JjhCtvF
	 PKni27OE4To2w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AE18D37820E2;
	Wed, 10 Apr 2024 10:07:29 +0000 (UTC)
Message-ID: <30499665-4182-4241-86cd-1ec88c719072@collabora.com>
Date: Wed, 10 Apr 2024 12:07:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Add coeff for
 mt8192
To: Hsin-Te Yuan <yuanhsinte@chromium.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?=
 <nfraprado@collabora.com>, =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?=
 <bero@baylibre.com>, Balsam CHIHI <bchihi@baylibre.com>
Cc: Alexandre Mergnat <amergnat@baylibre.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240410-lvts_thermal-v1-1-ee50b29c1756@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240410-lvts_thermal-v1-1-ee50b29c1756@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 10/04/24 12:06, Hsin-Te Yuan ha scritto:
> In order for lvts_raw_to_temp to function properly on mt8192,
> temperature coefficients for mt8192 need to be added.
> 
> Fixes: 288732242db4 ("thermal/drivers/mediatek/lvts_thermal: Add mt8192 support")
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index fd4bd650c77a6..6d226c3e135ca 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -80,6 +80,8 @@
>   #define LVTS_SENSOR_MAX				4
>   #define LVTS_GOLDEN_TEMP_MAX		62
>   #define LVTS_GOLDEN_TEMP_DEFAULT	50
> +#define LVTS_COEFF_A_MT8192			-250460
> +#define LVTS_COEFF_B_MT8192			250460

This is the same as LVTS_COEFF_{A,B}_MT8195, please just assign that to both
7988 and 8192's lvts_ap_data.

No need to create duplicate definitions.

Cheers,
Angelo

>   #define LVTS_COEFF_A_MT8195			-250460
>   #define LVTS_COEFF_B_MT8195			250460
>   #define LVTS_COEFF_A_MT7988			-204650
> @@ -1530,11 +1532,15 @@ static const struct lvts_data mt7988_lvts_ap_data = {
>   static const struct lvts_data mt8192_lvts_mcu_data = {
>   	.lvts_ctrl	= mt8192_lvts_mcu_data_ctrl,
>   	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
> +	.temp_factor	= LVTS_COEFF_A_MT8192,
> +	.temp_offset	= LVTS_COEFF_B_MT8192,
>   };
>   
>   static const struct lvts_data mt8192_lvts_ap_data = {
>   	.lvts_ctrl	= mt8192_lvts_ap_data_ctrl,
>   	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_ap_data_ctrl),
> +	.temp_factor	= LVTS_COEFF_A_MT8192,
> +	.temp_offset	= LVTS_COEFF_B_MT8192,
>   };
>   
>   static const struct lvts_data mt8195_lvts_mcu_data = {
> 
> ---
> base-commit: 20cb38a7af88dc40095da7c2c9094da3873fea23
> change-id: 20240410-lvts_thermal-3d365847acff
> 
> Best regards,


