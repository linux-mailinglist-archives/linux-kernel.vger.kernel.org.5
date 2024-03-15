Return-Path: <linux-kernel+bounces-104192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBDD87CA7B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248ED28278B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3855F17732;
	Fri, 15 Mar 2024 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="j7CQdFq4"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E931B17736
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710494127; cv=none; b=Pv8UvGXKV0s7O7VGQtdyXhrHDrtb84QCoo8X0lGEPE4qbjDq1zyugaVdsUjNbL5Kd/DPfeieUIZ3pYIzHcZ16LWVuqdGs7oF0s9jcYRPA3rYkczDJkuJxIMAsCLSnyE16SxsZ+adSIakbHHeqFBzK9YtMXg++sXwZkrBSQvJF50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710494127; c=relaxed/simple;
	bh=acrQ5oOzFvIptP0m55ggct7J15MBntUB7Hgt+FmRFRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7hbgdOwF5xI3+S8t/Qop51CMhSRkR2HTl0Ck3C94DunAAIvClGHhPZaKIbV20XUu/LYGozxKXBVHZIpEwZHZ89T4MAOuHySnProtVbDmMKfvISooFVnl0hSsDKSz2gKHwq0Dr8ps5cUxnqYIQKRAdYPO6eNfDzuVpZbayrBvj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=j7CQdFq4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710494124;
	bh=acrQ5oOzFvIptP0m55ggct7J15MBntUB7Hgt+FmRFRg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j7CQdFq496EcdadWXv01UmcL6cPMnEne0Ve8NgUX6EIsZfO28poLm/zYFElsRmg8r
	 L02tS8PomCFcYDO2g/Fpm6YlBqVX/p3IqIaxspuWPkGOYg1N1bGS+r6vAxDsKVKg+e
	 xiDOpoNn6GD1INtI2opCCnng8fin2PPXPROdpsqeOZhWLzYqRG/i+eHB+mYljXN4CE
	 sBKniqwVIkFU3vB2+zdfX0ICiRTuEItOr+lnz/V2pFkMZrcCk4q5rvTxNqt5uvNxXJ
	 AewYrKTKhrLaqm9vCBSfDpgEFOzbsvh9u3hyfcFeMqChvHglqGLhJr0cKE8r+7M/1i
	 pTRd13IOCOfWg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 36ED137820FD;
	Fri, 15 Mar 2024 09:15:23 +0000 (UTC)
Message-ID: <d295a448-1b50-47be-92a2-770501c83e18@collabora.com>
Date: Fri, 15 Mar 2024 10:15:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mediatek: dsi: Correct calculation formula of PHY Timing
To: Shuijing Li <shuijing.li@mediatek.com>, chunkuang.hu@kernel.org,
 p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
 matthias.bgg@gmail.com, jitao.shi@mediatek.com
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20240315072945.19502-1-shuijing.li@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240315072945.19502-1-shuijing.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/03/24 08:29, Shuijing Li ha scritto:
> This patch correct calculation formula of PHY timing.
> Make actual phy timing more accurate.
> 

More accurate in which cases? By how much? On which SoC(s)?

I agree about those changes if those are improving the PHY timing, but
can you please document what's going on?

Thanks,
Angelo

> Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_dsi.c | 33 +++++++++++++++---------------
>   1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index a2fdfc8ddb15..d1bd7d671880 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -235,22 +235,23 @@ static void mtk_dsi_phy_timconfig(struct mtk_dsi *dsi)
>   	u32 data_rate_mhz = DIV_ROUND_UP(dsi->data_rate, 1000000);
>   	struct mtk_phy_timing *timing = &dsi->phy_timing;
>   
> -	timing->lpx = (60 * data_rate_mhz / (8 * 1000)) + 1;
> -	timing->da_hs_prepare = (80 * data_rate_mhz + 4 * 1000) / 8000;
> -	timing->da_hs_zero = (170 * data_rate_mhz + 10 * 1000) / 8000 + 1 -
> -			     timing->da_hs_prepare;
> -	timing->da_hs_trail = timing->da_hs_prepare + 1;
> -
> -	timing->ta_go = 4 * timing->lpx - 2;
> -	timing->ta_sure = timing->lpx + 2;
> -	timing->ta_get = 4 * timing->lpx;
> -	timing->da_hs_exit = 2 * timing->lpx + 1;
> -
> -	timing->clk_hs_prepare = 70 * data_rate_mhz / (8 * 1000);
> -	timing->clk_hs_post = timing->clk_hs_prepare + 8;
> -	timing->clk_hs_trail = timing->clk_hs_prepare;
> -	timing->clk_hs_zero = timing->clk_hs_trail * 4;
> -	timing->clk_hs_exit = 2 * timing->clk_hs_trail;
> +	timing->lpx = (80 * data_rate_mhz / (8 * 1000)) + 1;
> +	timing->da_hs_prepare = (59 * data_rate_mhz + 4 * 1000) / 8000 + 1;
> +	timing->da_hs_zero = (163 * data_rate_mhz + 11 * 1000) / 8000 + 1 -
> +		timing->da_hs_prepare;
> +	timing->da_hs_trail = (78 * data_rate_mhz + 7 * 1000) / 8000 + 1;
> +
> +	timing->ta_go = 4 * timing->lpx;
> +	timing->ta_sure = 3 * timing->lpx / 2;
> +	timing->ta_get = 5 * timing->lpx;
> +	timing->da_hs_exit = (118 * data_rate_mhz / (8 * 1000)) + 1;
> +
> +	timing->clk_hs_prepare = (57 * data_rate_mhz / (8 * 1000)) + 1;
> +	timing->clk_hs_post = (65 * data_rate_mhz + 53 * 1000) / 8000 + 1;
> +	timing->clk_hs_trail = (78 * data_rate_mhz + 7 * 1000) / 8000 + 1;
> +	timing->clk_hs_zero = (330 * data_rate_mhz / (8 * 1000)) + 1 -
> +		timing->clk_hs_prepare;
> +	timing->clk_hs_exit = (118 * data_rate_mhz / (8 * 1000)) + 1;
>   
>   	timcon0 = timing->lpx | timing->da_hs_prepare << 8 |
>   		  timing->da_hs_zero << 16 | timing->da_hs_trail << 24;




