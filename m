Return-Path: <linux-kernel+bounces-62349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D687E851ECB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437541F22F14
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF944644F;
	Mon, 12 Feb 2024 20:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="XCpJ7ZjC"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CE82AEF1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 20:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707770488; cv=none; b=pVUYeP8bLVSXgpGAV9vv8cWULyvoZWiwI+VmdG3L4XqgkFuziRfshagTyHmO8Si4BjqFa6Q97FQ82WzDbdiCgwwUHp96kq4U1qT1rnvp8PlFxse7RN4lZLFjWX5VyLH6NBETtmODFEcKHmVD9By/s8rww74QxDbiTa7iMJ0YTdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707770488; c=relaxed/simple;
	bh=hdhLudHYo5bMj33n3Yyh9anyqdYEL/SsIr/1AeSObis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3kGxktmBznaqOEqT3+viIyuDy9FvJGQj1Fnj6dEnilORYm+jSlgcUn3sRIzg3gz2zy9gunhIomRTehNgie/OSPpMVoELzqkKbee3tgiDWqvqsRpIr35jmtZxoIj24CwnVwpVUfcyMTErZBhqsGTkyQXRUf9z3JCaMiI/lU+cT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=XCpJ7ZjC; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id Zb1LrRJoc8uLRZd7ArgU1N; Mon, 12 Feb 2024 20:41:20 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Zd78rckywfaGzZd79rRpU0; Mon, 12 Feb 2024 20:41:19 +0000
X-Authority-Analysis: v=2.4 cv=d9BWygjE c=1 sm=1 tr=0 ts=65ca826f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=7YfXLusrAAAA:8 a=ZyVk2ItIS7mYbqNWDTwA:9 a=QEXdDO2ut3YA:10
 a=9cHFzqQdt-sA:10 a=PUnBvhIW4WwA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=SLz71HocmBbuEhFRYD3r:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bw54feNBMSUAWt9H1kUwQT6TtWMrX6VS0KfO9CyJw9E=; b=XCpJ7ZjCAG/KP/VTwD4kYXi1K6
	/TbC0ueZTpwPte6x1WspBWfomnu9CbJKxBlg8AEJUb6bYruRsKh3OO2vXtRvNlWkDxzDo2VFlYy3f
	qSYbkP4Dq87K/EzMIfjT8nCoZF+MVL6JAojreH7zGZIG0ouO7a0Dcvr/liR1UWwMaOCAoExudUqpA
	THXkXJWEjbVSnKGcXxVcmR6wQkBei74Dpwno4G8U4P1oRPOAZygKG7GlOwYpoL35YVeM6gy8CnNFF
	HFNjBkxUkew9YfwsXFMbDVMdrqTG8mBK/rG56ejxDeAgvDakcbig5I9eWSpbucLebhmNuNIMOlBP+
	cTZ2GOzg==;
Received: from [201.172.172.225] (port=34544 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rZd77-000F5z-0a;
	Mon, 12 Feb 2024 14:41:17 -0600
Message-ID: <0f3213d3-9010-45d5-8852-f0ab3ffc8f8b@embeddedor.com>
Date: Mon, 12 Feb 2024 14:41:11 -0600
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
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kees Cook <keescook@chromium.org>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hardening@vger.kernel.org
References: <20240211182250.12656-1-erick.archer@gmx.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240211182250.12656-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.172.225
X-Source-L: No
X-Exim-ID: 1rZd77-000F5z-0a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.172.225]:34544
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfG8qEgi8JtnbL2eCm3ZPlmw2QVu9S/VGzJGzsduzvjetV6j1ELB3Ayx8S7TzwQF8W+KDNq6GTGXYjcM3b00j3JI3lNa64IBt/flcvZuu+ACsGDgiiMb0
 a8EYCBtADZZRKbFN5xalTynhq7T7AlFXtaouhLdOoWHx6FWlGrhAROX1eFxPoZlFzj7QeTc0Uxja8IsM56RoMhgjsR78+nff5Kk3Wb9LUxbG/0NHB9Ivrgwz



On 2/11/24 12:22, Erick Archer wrote:
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

LGTM:

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

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
> 

