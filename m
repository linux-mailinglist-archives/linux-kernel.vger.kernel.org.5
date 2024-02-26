Return-Path: <linux-kernel+bounces-81393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBAC867552
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91751F27D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF3512A143;
	Mon, 26 Feb 2024 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hruwiW9p"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447547F7C7;
	Mon, 26 Feb 2024 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951172; cv=none; b=rrANa59KOUvxExc/d4b5+w1vU/L7BGtz7TDoYmP2anDffvsdqArT89xrv47M5PW0smFaSmjDZH1dKQkMbJG03g2NHdfxL5Sm/mFOxjeWeZYK8FfsVK8eJ9vmYs4DZDd+D/Lac6QZfg/27D+opdS1R2wGsTgVWdeoVGzBEq5a9DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951172; c=relaxed/simple;
	bh=WuE4kCD97wZ9bNjHBG7YNNj1l3uPwjiVFXgZ1NInp4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mWaNiFy35a2Ks4KfS/a9Av3OpwU6o6jcjdjEABU592eaIjgPjACJmZYhZGyn+/5hcGNplJcF7aLJQUAVz0rsH5/g3HVB9KSZxCR5dYULPLIRov8AnxLYQxf5TW4wFm2QTR9Xfk3KyISgMyP0zGtDkjTBqun4fm6xtaItfqQMStQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hruwiW9p; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708951169;
	bh=WuE4kCD97wZ9bNjHBG7YNNj1l3uPwjiVFXgZ1NInp4w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hruwiW9pNWUrPMI0AD9IZzA/Y9miBS1AqGYeG1A93mG9LQcQ10Ia9jew8ZNEcDawX
	 z2OBZElqRRK3DCorbhKBZoyHyjBIwBA/RxUar/Yj3jUrxr5yPQTsqVoA9ZJsyqBCfO
	 ZZHSzru6f0uYG+SaC3GO+7DoPUxMliKkt+/iWBNtLejHWATUq1lIpomysLNwyhKKQC
	 EIDI/5VBBFNI/7V17e1FzY0YgdFt2y4Vn8VxTTuE0glp/eUpn4mzPFVqSaOyu0XgQq
	 COC7lTErNp+kg4igLcu882DuuMGyfXjVUNGZPxRgNh+yjGuhSWHNC9clYphHHXteDs
	 hmtw0XcRhVcJQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DD07B37820CF;
	Mon, 26 Feb 2024 12:39:28 +0000 (UTC)
Message-ID: <e2f901aa-9d1b-4de9-ac18-7cfb57adb587@collabora.com>
Date: Mon, 26 Feb 2024 13:39:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] drm/mediatek: Rename "pending_needs_vblank" to
 "needs_vblank"
Content-Language: en-US
To: Shawn Sung <shawn.sung@mediatek.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
References: <20240226085059.26850-1-shawn.sung@mediatek.com>
 <20240226085059.26850-12-shawn.sung@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240226085059.26850-12-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/02/24 09:50, Shawn Sung ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
> 
> Rename "pending_needs_vblank" to "needs_vblank" to reduce the code size.
> 

This decreases human readability though, so I would prefer that we omit this one.

Regards,
Angelo

> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_crtc.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
> index 7fe234de83a3..a1fb6c67681d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
> @@ -42,7 +42,7 @@ struct mtk_crtc {
>   	struct drm_crtc			base;
>   	bool				enabled;
>   
> -	bool				pending_needs_vblank;
> +	bool				needs_vblank;
>   	struct drm_pending_vblank_event	*event;
>   
>   	struct drm_plane		*planes;
> @@ -105,9 +105,9 @@ static void mtk_crtc_finish_page_flip(struct mtk_crtc *mtk_crtc)
>   static void mtk_drm_finish_page_flip(struct mtk_crtc *mtk_crtc)
>   {
>   	drm_crtc_handle_vblank(&mtk_crtc->base);
> -	if (!mtk_crtc->config_updating && mtk_crtc->pending_needs_vblank) {
> +	if (!mtk_crtc->config_updating && mtk_crtc->needs_vblank) {
>   		mtk_crtc_finish_page_flip(mtk_crtc);
> -		mtk_crtc->pending_needs_vblank = false;
> +		mtk_crtc->needs_vblank = false;
>   	}
>   }
>   
> @@ -571,7 +571,7 @@ static void mtk_crtc_update_config(struct mtk_crtc *mtk_crtc, bool needs_vblank)
>   	mutex_lock(&mtk_crtc->hw_lock);
>   	mtk_crtc->config_updating = true;
>   	if (needs_vblank)
> -		mtk_crtc->pending_needs_vblank = true;
> +		mtk_crtc->needs_vblank = true;
>   
>   	for (i = 0; i < mtk_crtc->layer_nr; i++) {
>   		struct drm_plane *plane = &mtk_crtc->planes[i];



