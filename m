Return-Path: <linux-kernel+bounces-109828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DB688562F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BA82B21A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BD63A8EF;
	Thu, 21 Mar 2024 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="goNJS3Wn"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AAE2E41A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711011939; cv=none; b=UhO2kATY69EdzCjQo8JW5Bil80d0RaXzMDeW2cRAoWVb6GJLQHYTwd5NrvmF6xea33eSIZ6tg+5CSt+igis3z4uxyXepBnIvOdZMNQNjed3BZHgrXWGKSopd1hK6PgWgzogwARGmxbQ+hOrnLV7ZE7aLwLaw/MiyH+DneGi0kek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711011939; c=relaxed/simple;
	bh=P7V6XrgrAvBiW0OBljHuvrds54kBtngXw5oTsR9kvH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGMxW0xGUEzlaRTe5ueHak73dvM/8tV60KN+fm0/wcvK4DxFudngLTBluOdxNPQpLx+EmyQ1XVSkPY9nSCIPOVp+lECQRMeoL+qf+cFsLxf0lZ4AjHNybJcEFnpFUHBLmSU1yBszwJ51ZhSqegcyWUy+UZ/vR7SthcsR7HuuJA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=goNJS3Wn; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711011935;
	bh=P7V6XrgrAvBiW0OBljHuvrds54kBtngXw5oTsR9kvH8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=goNJS3Wn3dSJV2hDjj9YbzzI1Jm+6I/kMWzCxNY/Wck4qeIcAYbE56BW3QkgcCiMx
	 3D9VOn/bwj3fN71Eb/zuMV5s0ayp5ptj7AYLZBs05pi7yyrkgV26x/iZt2k/yqSBRm
	 PDGdiJa0rGltJaoEf1t9gttrhV6FEuPuOih2qNuAWhw6sl5YyGI7FNfCBCZIEGQVS/
	 xOBC0YGUOzuHFNt/njecwHdOYoh+q2kUgHiSzsE/jFwLVSLnxMbynP9lLb5K8K14tE
	 jJN3iVa0oYLdQ9Q/hq9eYBCp+wNjOH2UQJ369KWnIlhc/xZ8pvjy9RWyf1ApQFyuJz
	 sjVHBtPWUZx/Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 55B0737813E1;
	Thu, 21 Mar 2024 09:05:34 +0000 (UTC)
Message-ID: <b1ff4130-8e84-478a-a6b3-1cac677d8cbd@collabora.com>
Date: Thu, 21 Mar 2024 10:05:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] drm/mediatek: Fixes for DDP component search/destroy
Content-Language: en-US
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
 matthias.bgg@gmail.com, ck.hu@mediatek.com, nancy.lin@mediatek.com,
 nathan.lu@mediatek.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 wenst@chromium.org
References: <20240201125304.218467-1-angelogioacchino.delregno@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240201125304.218467-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 01/02/24 13:53, AngeloGioacchino Del Regno ha scritto:
> This series performs some cleanups for DDP component CRTC search and
> correctly iounmaps the previously of_iomap() calls from drm_ddp_comp.
> 
> Tested on MT8195 Cherry Tomato
> 

Hello CK,
gentle ping for this series.

Cheers,
Angelo

> AngeloGioacchino Del Regno (3):
>    drm/mediatek: drm_ddp_comp: Fix and cleanup DDP component CRTC search
>    drm/mediatek: Perform iounmap on simple DDP component destruction
>    drm/mediatek: drm_ddp_comp: Add mtk_ddp_is_simple_comp() internal
>      helper
> 
>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 113 +++++++++++++-------
>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   1 +
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   4 +-
>   3 files changed, 80 insertions(+), 38 deletions(-)
> 


