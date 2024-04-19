Return-Path: <linux-kernel+bounces-151140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9BA8AA9A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FEF1F22C5C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7823C4D5A2;
	Fri, 19 Apr 2024 08:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="M/JB5bjQ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A1946453;
	Fri, 19 Apr 2024 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713513669; cv=none; b=HglBOiJbSxeEVkbaremrqzaNtEuzqbPzMJPJGYooBThvA6cMKKD9YM7lDJ6r5f8sS2ordNf02KFEdZFtjivKBPXaXIWv+52mBAnoa1f1TS3AinJiJsYj42DzTWu1iCrRmf710KAVzzqo9ilAc5itGbcMsF2m8BgBJAgofMeDkKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713513669; c=relaxed/simple;
	bh=bmmrpG9twzfl+7I9bjJ8i79tB8/NSeisn+ds2RBa2jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8r005nmfGOZ4GUN4ZcXPr44RQzLVjmuYx4Srxv8GhjFO6qeTllK8J5hHgSXgGxJbo4oOuBEkqu9Sm/AkyJmkuOyhDRPdMuTjdSn/cqDFoB7oIqDbeaWtCWjn3ptRiw8i6TaiUvcmonko2Nx5WaVD6m50YgZWRKPSNhj7U2KGwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=M/JB5bjQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713513663;
	bh=bmmrpG9twzfl+7I9bjJ8i79tB8/NSeisn+ds2RBa2jc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M/JB5bjQ9tMmBy/2sL9FqxKtsvP0vRNp1Dip2qCJGzQp1mXq/TtcKSmfrt8NCxqX9
	 1C95N632nY+EA35Ny0jSzfyOcnkdKsn6O4LcSiNmYUbMmQTvVviP/DYSRDIYMEK4oK
	 CBAJ4tyuZHbTx59JXDEgqnsA/h5lTqr3xEXThitNy4iguMgnwFH8YGZ83nAxnuz0uX
	 tzw5ZGWf0gcg+nHzPehvGmhqG42uH7nX/4WtFfnAniRLzparrTnMGV4uKQoCkceKyu
	 nCWrJc1fVwgk9sFLVgRud+YA7lXx2yKulGRcXi4gj2iEf8liLZIc5RgTji8UfW65rc
	 g39BSWODH7vXw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7449E3781116;
	Fri, 19 Apr 2024 08:01:01 +0000 (UTC)
Message-ID: <9ef43fff-ee2a-4b2c-a595-30f5bf7588c2@collabora.com>
Date: Fri, 19 Apr 2024 10:01:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/17] drm/mediatek: add MT8365 SoC support
To: amergnat@baylibre.com, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Jitao Shi <jitao.shi@mediatek.com>,
 CK Hu <ck.hu@mediatek.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Fabien Parent <fparent@baylibre.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20231023-display-support-v3-0-53388f3ed34b@baylibre.com>
 <20231023-display-support-v3-14-53388f3ed34b@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231023-display-support-v3-14-53388f3ed34b@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/04/24 16:17, amergnat@baylibre.com ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add DRM support for MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

There are two things that I want to point out. Please check below.

The series that I've sent for adding OF Graphs [1] support to MediaTek DRM is
not going to be picked in time for v6.10, but I think neither your MT8365 support
series is, and that's why I'm telling you this.

If your work was based off my series, you would not need to add the MT8365 ddp
MAIN and EXT paths to mtk_drm_drv: you'd just add it to the bindings and then
you would declare the paths in devicetree.


[1]: 
https://lore.kernel.org/r/20240409120211.321153-1-angelogioacchino.delregno@collabora.com

There's also one more comment....

> ---
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 74832c213092..427b601309c4 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c

.snip..

> @@ -793,6 +821,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
>   	  .data = (void *)MTK_DSI },
>   	{ .compatible = "mediatek,mt8188-dsi",
>   	  .data = (void *)MTK_DSI },
> +	{ .compatible = "mediatek,mt8365-dpi",

You removed the mt8365 specific compatible from the DPI driver - why did you keep
it here?! that's not needed! :-)

Cheers,
Angelo

> +	  .data = (void *)MTK_DPI },
>   	{ }
>   };
>   
> 


