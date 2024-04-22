Return-Path: <linux-kernel+bounces-152953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE5D8AC691
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7612832FF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922F150281;
	Mon, 22 Apr 2024 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kQDUuizb"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2534E1CE;
	Mon, 22 Apr 2024 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773848; cv=none; b=CsSDM1EVp30al+iS0rszHziTjJKPAvFSIJVVVZmoijG8u1y1aYLTRTtXRiQstOxuAymmYGt9lAvi4Lyjr/g4CDeOfnvaAcysGjgmTP15iiV4Lvt6aocJ0AKPJFJtIeCfT5x2uUB1cx73nJGQnZkI1DM7YXCK7sLazTnNmtscBTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773848; c=relaxed/simple;
	bh=cMADH+A0BEOfb9WplRUCFQe3Bk4HECT83QRWAChad4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4V8MRvf6pLIOvT6AeNDY/ictaptQ0yZnCe+y4ue7xCuGG8hmZzo+uCYt6YVwOduHfHW/d/NO8cZly4Dim8w6T/nLK1D8PYGnF9OiEaQXsK4VUglg0bAwv+rULlImkQ0ou28r3BcOCU1d0YHqMBuRaONn8YNPFCHC8stThJAeZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kQDUuizb; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713773843;
	bh=cMADH+A0BEOfb9WplRUCFQe3Bk4HECT83QRWAChad4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kQDUuizbICE+dtRmPyWNhnQaQqWsly3CTdmXZmQrBbWqMvB4KYhIm9TjyFLQaQvv7
	 52gMxKdhvRxWOMgnu++PlsNC33neV4h4xV0XVSaCkTadM80fdgKRV+YQYA8/KzpWGc
	 W/i+SvV1PDMhdCk15lQ9M+ajjgJoShpWK4idgagBaoKvojfAPsp4MP5pmC8KoGEP1f
	 5qEgTCpION7rZaFrJQCfNLlYc/lrAjLDZIjYyv0gK2+cI7L9nLgn6q54Odohgl4KQ6
	 WlA6cTROjamnUl81P6OR1aKAinYlUxC9QDYjFF0/OKmdA4gzP8E8KvEQHSdqYq3xqh
	 ygokbn2sabT5Q==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A8F85378001E;
	Mon, 22 Apr 2024 08:17:21 +0000 (UTC)
Message-ID: <6066f6f0-49c6-4607-9c33-88e166ccae86@collabora.com>
Date: Mon, 22 Apr 2024 11:17:18 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panfrost: Fix dma_resv deadlock at drm object pin
 time
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Zack Rusin <zack.rusin@broadcom.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20240421163951.3398622-1-adrian.larumbe@collabora.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20240421163951.3398622-1-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/21/24 19:39, Adrián Larumbe wrote:
> When Panfrost must pin an object that is being prepared a dma-buf
> attachment for on behalf of another driver, the core drm gem object pinning
> code already takes a lock on the object's dma reservation.
> 
> However, Panfrost GEM object's pinning callback would eventually try taking
> the lock on the same dma reservation when delegating pinning of the object
> onto the shmem subsystem, which led to a deadlock.
> 
> This can be shown by enabling CONFIG_DEBUG_WW_MUTEX_SLOWPATH, which throws
> the following recursive locking situation:
> 
> weston/3440 is trying to acquire lock:
> ffff000000e235a0 (reservation_ww_class_mutex){+.+.}-{3:3}, at: drm_gem_shmem_pin+0x34/0xb8 [drm_shmem_helper]
> but task is already holding lock:
> ffff000000e235a0 (reservation_ww_class_mutex){+.+.}-{3:3}, at: drm_gem_pin+0x2c/0x80 [drm]
> 
> Fix it by assuming the object's reservation had already been locked by the
> time we reach panfrost_gem_pin.
> 
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Steven Price <steven.price@arm.com>
> Fixes: a78027847226 ("drm/gem: Acquire reservation lock in drm_gem_{pin/unpin}()")
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_gem.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> index d47b40b82b0b..6c26652d425d 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -192,7 +192,12 @@ static int panfrost_gem_pin(struct drm_gem_object *obj)
>  	if (bo->is_heap)
>  		return -EINVAL;
>  
> -	return drm_gem_shmem_pin(&bo->base);
> +	/*
> +	 * Pinning can only happen in response to a prime attachment request from
> +	 * another driver, but that's already being handled by drm_gem_pin
> +	 */
> +	drm_WARN_ON(obj->dev, obj->import_attach);
> +	return drm_gem_shmem_pin_locked(&bo->base);
>  }

Will be better to use drm_gem_shmem_object_pin() to avoid such problem
in future

Please also fix the Lima driver

-- 
Best regards,
Dmitry


