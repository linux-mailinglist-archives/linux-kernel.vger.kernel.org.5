Return-Path: <linux-kernel+bounces-61219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF93850F13
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE511C216CA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DCEF9F6;
	Mon, 12 Feb 2024 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z+blcmK+"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB30F51F;
	Mon, 12 Feb 2024 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707727766; cv=none; b=NCPOHg0UYrVtCIQxukjOu+GYO4/1GiA73U9GABwMnuG+i6WIo09RUjE68eAjM3xvJ3tqsgnnpyEuZlEGVQ6CPTaq4oU3ImAZyOnaeDqSsKAmGPNnyWwDgvAgv3baKfW2trxFKcs6Qia1A5+0mmSRIrW0uurwKUYY3lP/fo3aDlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707727766; c=relaxed/simple;
	bh=1VsQ4z1r3dEamcItynYxqF1YB4jf1wiMOZfZh4BLL7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SrrTh+A7pxpeqkTyaiE26OuOyqywy7E7fIMmq8UZEWDeTXEz20a0CmOb5bTxwQEOuZlpAAxMvh2ORLd9RCiPuIvZlDbNknmGyowrbOknt2Ufy/eRslWPjqACbH3iGBQjhQkg71qtkDcmsTNnPyYVFjIYdDTNJPgPIPBi3DL4MV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Z+blcmK+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707727763;
	bh=1VsQ4z1r3dEamcItynYxqF1YB4jf1wiMOZfZh4BLL7o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z+blcmK+YbesX4oSXgB0nnDs8q8tMFP62tHS9wmWzqmGkKKXHuMZSWX7Z8yIdrc4p
	 M/JFWMrusIALQ6IB+F3V0TjmS8i+tNF2PN2BGVPyGAiBmV7gWLAXNnp499/LPTD6mP
	 OAJ8HA1guaUgHOvm4M521hJpIg3WlL+SPdOQiXMWeVSStXXyCA8hlbJRqH6XZsAn8B
	 /7TwojQIIPzAjm/v5MzpRc5UqricuAvpMtjqtRsPO46vcyrXQTU4V76ntzaicutipQ
	 txstS5dQuLzVmFRUX0WHrnQFDLeaQqcIk6XEwWoJYbKWkNMXZA3RJAnktzJrgdy28d
	 LW1y3zRvkX5hw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 27262378203F;
	Mon, 12 Feb 2024 08:49:22 +0000 (UTC)
Message-ID: <25e10072-30eb-4272-8a89-2c5240d53a1c@collabora.com>
Date: Mon, 12 Feb 2024 09:49:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/mtk_iommu: Use devm_kcalloc() instead of
 devm_kzalloc()
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kees Cook <keescook@chromium.org>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hardening@vger.kernel.org
References: <20240211182250.12656-1-erick.archer@gmx.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240211182250.12656-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/02/24 19:22, Erick Archer ha scritto:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1].
> 
> Here the multiplication is obviously safe because MTK_PROTECT_PA_ALIGN
> is defined as a literal value of 256 or 128.
> 
> For the "mtk_iommu.c" file: 256
> For the "mtk_iommu_v1.c" file: 128
> 
> However, using devm_kcalloc() is more appropriate [2] and improves
> readability. This patch has no effect on runtime behavior.
> 
> Link: https://github.com/KSPP/linux/issues/162 [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/iommu/mtk_iommu.c    | 2 +-
>   drivers/iommu/mtk_iommu_v1.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 7abe9e85a570..9aae6eb604b1 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1264,7 +1264,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   	data->plat_data = of_device_get_match_data(dev);
> 
>   	/* Protect memory. HW will access here while translation fault.*/
> -	protect = devm_kzalloc(dev, MTK_PROTECT_PA_ALIGN * 2, GFP_KERNEL);
> +	protect = devm_kcalloc(dev, 2, MTK_PROTECT_PA_ALIGN, GFP_KERNEL);
>   	if (!protect)
>   		return -ENOMEM;
>   	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index 25b41222abae..45cd845d153f 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -621,8 +621,8 @@ static int mtk_iommu_v1_probe(struct platform_device *pdev)
>   	data->dev = dev;
> 
>   	/* Protect memory. HW will access here while translation fault.*/
> -	protect = devm_kzalloc(dev, MTK_PROTECT_PA_ALIGN * 2,
> -			GFP_KERNEL | GFP_DMA);
> +	protect = devm_kcalloc(dev, 2, MTK_PROTECT_PA_ALIGN,
> +			       GFP_KERNEL | GFP_DMA);
>   	if (!protect)
>   		return -ENOMEM;
>   	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
> --
> 2.25.1
> 



