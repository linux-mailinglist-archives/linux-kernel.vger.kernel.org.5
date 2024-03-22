Return-Path: <linux-kernel+bounces-111153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DC388686C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F354284EEB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA4218EB9;
	Fri, 22 Mar 2024 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jy/XB7tw"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30AD1863B;
	Fri, 22 Mar 2024 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711097198; cv=none; b=alzHD9Ju2BxKtNL+SYuJqghSfWMHajz/MKt+eUx88JJ7odycK9LQ02Ecs7M8NrG/Oej4VnCk0ntvnQdANjb3vAaF+7iud4zt0Dsrs/VkvG1+RW9nM5QDFjCG9Ar0r4hgzVgjnJBEKWxdHK0MCywVdBeXOPTwwQ6+c2EY3cl5EHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711097198; c=relaxed/simple;
	bh=Gs2UAC9Hy8VFwByHDlNC06xdCiz4QDNtsopwA8NrO4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9kCMFeSsRap/E2BTik+yORpXjXnPf/GG1jrT/EyBX68r36ifuOtZQpxOGYRRsgEBIsqH1R9ZPDmpgvCR0SHkbJWHijBt7sw2DXxJwk1dLSKdlPhv85XTkdf7opwG36Pc4l/ovTYdk8kcatFGwUkEpXVoQ06NmOZQfqpImkopZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jy/XB7tw; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711097194;
	bh=Gs2UAC9Hy8VFwByHDlNC06xdCiz4QDNtsopwA8NrO4Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jy/XB7tw0FGS5tI0FcWpWhUzIrqIIeYInUM84WS16IpPsOCwNS4R96cgPgJzhUVRP
	 Eepi17JezOVmbuiLp8Fo5BbSCnDCvXiKAqbunTeSngJxLdItvJYUkrYmITlEBD7ps3
	 F4jlmQq41YUwav4f/MtGeRjSei/PyzDY7n7ADwI3IfGRczolHLEROndp7Qx5y2QuBp
	 S6cPVl1uX0msVhBDSiIuDoagk225ecXPhX9509482xD1yeNasazvucrvYRIr56j6vl
	 IWi9vY7VIbrrTD2Ws0ro9toDee2MVS91LpJ+Eu3ofSM7Q8jIyqwIiRTfC84vANaswp
	 Vqx4X6Y/NL5cA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E90AF37809D1;
	Fri, 22 Mar 2024 08:46:33 +0000 (UTC)
Message-ID: <e1d5d349-c9e3-4af9-a9b6-d563027a5974@collabora.com>
Date: Fri, 22 Mar 2024 09:46:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/14] drm/mediatek: Rename "mtk_drm_plane" to
 "mtk_plane"
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
References: <20240322012808.26234-1-shawn.sung@mediatek.com>
 <20240322012808.26234-4-shawn.sung@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240322012808.26234-4-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 22/03/24 02:27, Shawn Sung ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
> 
> Rename all "mtk_drm_plane" to "mtk_plane":
> - To align the naming rule
> - To reduce the code size
> 
> Reviewed-by: AngeloGiaocchino Del Regno <angelogioacchino.delregno@collabora.com>

Shawn - please - can you fix my typo'ed name also here and on all of the
patches of this series?

Thanks.

> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_drm_plane.c | 6 +++---
>   drivers/gpu/drm/mediatek/mtk_drm_plane.h | 4 ++--
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> index cbdb70677d305..43137c46fc148 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> @@ -93,8 +93,8 @@ static bool mtk_plane_format_mod_supported(struct drm_plane *plane,
>   	return true;
>   }
>   
> -static void mtk_drm_plane_destroy_state(struct drm_plane *plane,
> -					struct drm_plane_state *state)
> +static void mtk_plane_destroy_state(struct drm_plane *plane,
> +				    struct drm_plane_state *state)
>   {
>   	__drm_atomic_helper_plane_destroy_state(state);
>   	kfree(to_mtk_plane_state(state));
> @@ -241,7 +241,7 @@ static const struct drm_plane_funcs mtk_plane_funcs = {
>   	.destroy = drm_plane_cleanup,
>   	.reset = mtk_plane_reset,
>   	.atomic_duplicate_state = mtk_plane_duplicate_state,
> -	.atomic_destroy_state = mtk_drm_plane_destroy_state,
> +	.atomic_destroy_state = mtk_plane_destroy_state,
>   	.format_mod_supported = mtk_plane_format_mod_supported,
>   };
>   
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.h b/drivers/gpu/drm/mediatek/mtk_drm_plane.h
> index 99aff7da0831d..231bb7aac9473 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_plane.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.h
> @@ -4,8 +4,8 @@
>    * Author: CK Hu <ck.hu@mediatek.com>
>    */
>   
> -#ifndef _MTK_DRM_PLANE_H_
> -#define _MTK_DRM_PLANE_H_
> +#ifndef _MTK_PLANE_H_
> +#define _MTK_PLANE_H_
>   
>   #include <drm/drm_crtc.h>
>   #include <linux/types.h>



