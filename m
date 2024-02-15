Return-Path: <linux-kernel+bounces-66705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BF385606E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2CAE1F2107A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24FA12B144;
	Thu, 15 Feb 2024 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tCDSnKve"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D0A12A171
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993960; cv=none; b=i1DPDXkPVn3jtZe+FT3hNlpjalkQF/R/r/5eLdai6lHcg5btbRyzozG9Bd6GA5orf8eVxtwwyro0ZdSXFobQgOl+rl/oAlgjauv3oE6+JJ8/M+jRsE/WlBz+fFHxAyqN+2C/3YFvKl64dJRNUMQPBxCGQzLBuOjB4TF1Mhl2voY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993960; c=relaxed/simple;
	bh=wuxysMNMqCk725hkpLxM7t6pHbp0NDW7ymjHD5cQXRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+lv6Ty4VYDyunM7s0TW7GYzIDmf5nQEm4XTogp1dYxt3a+GwMQMVsvng9oAzE5l4j9XkekQgtsWQUCG2xRPGR41oeins8LDRPBrPh8bP8F/beZZnipNyX9D54fmMZTDO/78PWSMpnMulZ1vdL7ndEGsXttSnxGKC8yNcEWtHfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=tCDSnKve; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707993956;
	bh=wuxysMNMqCk725hkpLxM7t6pHbp0NDW7ymjHD5cQXRI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tCDSnKveaq5j/GLl1+L0oFpMDQgbIQ4NMt/FmFS8WugixvZe9Ca7nobUxropZiPHj
	 8/1+UaHZg3GK+4Y1zbP7J3z2QTF61t+UES2J59VDtFVVDNFzUcoD8c29/qqIN7FB6v
	 6Wh4nvjRgff92JXI3pyhNyk9ZhrHuyE4rowP5v/jt6Lo8Zhf/sKbboxkk0kby0nrdZ
	 D4MGUcnBXn1tD87uY36SsuivaK79yi+QVYTl3behqlYMoBcgx5YqlTeV8zgE5ZCJkM
	 9H0R2PeS5Q+i6tKSPdEP+IHw/llXSoy6vkGTwLBvH4IO58v/VZ7SpT+J0oGVkq+uvv
	 Upa/r6mNPmr3g==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7FC843780FC7;
	Thu, 15 Feb 2024 10:45:55 +0000 (UTC)
Message-ID: <1fdf2c07-8240-4711-a708-b555932dabc6@collabora.com>
Date: Thu, 15 Feb 2024 11:45:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/13] drm/mediatek: Turn off the layers with zero
 width or height
Content-Language: en-US
To: Hsiao Chien Sung <shawn.sung@mediatek.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Bibby Hsieh <bibby.hsieh@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
 Sean Paul <seanpaul@chromium.org>, Fei Shao <fshao@chromium.org>,
 Jason Chen <jason-ch.chen@mediatek.corp-partner.google.com>,
 "Nancy . Lin" <nancy.lin@mediatek.com>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240215101119.12629-1-shawn.sung@mediatek.com>
 <20240215101119.12629-7-shawn.sung@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240215101119.12629-7-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/02/24 11:11, Hsiao Chien Sung ha scritto:
> We found that IGT (Intel GPU Tool) will try to commit layers with
> zero width or height and lead to undefined behaviors in hardware.
> Disable the layers in such a situation.
> 
> Fixes: 777b7bc86a0a3 ("drm/mediatek: Add ovl_adaptor support for MT8195")
> Fixes: fa97fe71f6f93 ("drm/mediatek: Add ETHDR support for MT8195")
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

This commit should be sent separately from this series, as it is fixing things
that are not related just to IGT, but also to corner cases in regular non-testing
usecases.

In any case, it's not mandatory as that depends on what the maintainer prefers,
so it's CK's call anyway.

Besides that,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c | 2 +-
>   drivers/gpu/drm/mediatek/mtk_ethdr.c            | 7 ++++++-
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> index d4a13a1402148..68a20312ac6f1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> @@ -157,7 +157,7 @@ void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
>   	merge = ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_MERGE0 + idx];
>   	ethdr = ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_ETHDR0];
>   
> -	if (!pending->enable) {
> +	if (!pending->enable || !pending->width || !pending->height) {
>   		mtk_merge_stop_cmdq(merge, cmdq_pkt);
>   		mtk_mdp_rdma_stop(rdma_l, cmdq_pkt);
>   		mtk_mdp_rdma_stop(rdma_r, cmdq_pkt);
> diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.c b/drivers/gpu/drm/mediatek/mtk_ethdr.c
> index 73dc4da3ba3bd..69872b77922eb 100644
> --- a/drivers/gpu/drm/mediatek/mtk_ethdr.c
> +++ b/drivers/gpu/drm/mediatek/mtk_ethdr.c
> @@ -160,7 +160,12 @@ void mtk_ethdr_layer_config(struct device *dev, unsigned int idx,
>   	if (idx >= 4)
>   		return;
>   
> -	if (!pending->enable) {
> +	if (!pending->enable || !pending->width || !pending->height) {
> +		/*
> +		 * instead of disabling layer with MIX_SRC_CON directly
> +		 * set the size to 0 to avoid screen shift due to mixer
> +		 * mode switch (hardware behavior)
> +		 */
>   		mtk_ddp_write(cmdq_pkt, 0, &mixer->cmdq_base, mixer->regs, MIX_L_SRC_SIZE(idx));
>   		return;
>   	}


