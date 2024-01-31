Return-Path: <linux-kernel+bounces-46012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CC8843936
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74804B21CE7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A702460B9A;
	Wed, 31 Jan 2024 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JIhxhFEv"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56646605AE;
	Wed, 31 Jan 2024 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690339; cv=none; b=JhYK1jQXn+Vc/60kH+HcFcI11r9/fvYzKjFmBlhjBV7OTm6eAB0OfUsYd6Wp8NUtRjhn8TWJPsFcfR661CpebuQCQNm6nbv2tbIeTPGkJDivhVrsv77BcXD0bTSlDebwBJ/1JKL+45Uw4dWVHy1QPazpPKZ+AmVRwWv3ck/IrxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690339; c=relaxed/simple;
	bh=2ZBAflDXD3zJXqpjp+crMkG8/SPmbN2N4SU1DhttT0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lyN1aGNWXnZRuVrKbN/oyoP0XxVAfpN5WIOx5VobbSkozIK8qT97xe07hWeGfqtY3m7raAA5s/4tVr2jbn1zL0ljcTGHlYj2B2vffKOr0Iepkct6FxQy7BvJtK9Qr0O4nS+sZiC4SUpKlRVXaw5yUPrd8vP84cQsdD9TP4cfMM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JIhxhFEv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706690329;
	bh=2ZBAflDXD3zJXqpjp+crMkG8/SPmbN2N4SU1DhttT0c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JIhxhFEve28QOybjkrgd6475Ry0AThAhxYNPmxNdIA0aF0YKe+vANGHhTCjnzj3Et
	 o3SLESKxHEl40PGpvPZnjaMueno8mKiWOL4QDP7wBGhcGRsss407F80oWxm2P7EJn/
	 AMs+A5c05xo/q12gwzIVDjsvU/08BwjyMOZjcVnvv7YmBbPW9kPcd82F5yDtC9PJyT
	 5Qlc7hgpZYSi+hyR8VhTqQf1zLAnrb7vogRkZA3l/UKNCjYg0RZ9aK2UW/4QaDOSZz
	 LfqmxbKFb0ylBAr1fZNv8gYalLBkvSnZ3SN1IzIG2D26R4wy+MJi8FLlK+E1pFgTU7
	 KOFb5xI3tDBmg==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E35B937803EE;
	Wed, 31 Jan 2024 08:38:48 +0000 (UTC)
Message-ID: <ee039551-ffb0-4ebe-88d1-5953f347cde0@collabora.com>
Date: Wed, 31 Jan 2024 11:38:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm/gem: Fix double resv lock aquire
Content-Language: en-US
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robdclark@chromium.org>, Abhinav Kumar
 <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20240131011537.31049-1-robdclark@gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20240131011537.31049-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/24 04:15, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Since commit 56e5abba8c3e ("dma-buf: Add unlocked variant of vmapping
> functions"), the resv lock is already held in the prime vmap path, so
> don't try to grab it again.
> 
> v2: This applies to vunmap path as well
> 
> Fixes: 56e5abba8c3e ("dma-buf: Add unlocked variant of vmapping functions")
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Nit: the offending commit should be 79e2cf2e7a19 ("drm/gem: Take
reservation lock for vmap/vunmap operations")

> ---
>  drivers/gpu/drm/msm/msm_gem_prime.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gem_prime.c b/drivers/gpu/drm/msm/msm_gem_prime.c
> index 5f68e31a3e4e..0915f3b68752 100644
> --- a/drivers/gpu/drm/msm/msm_gem_prime.c
> +++ b/drivers/gpu/drm/msm/msm_gem_prime.c
> @@ -26,7 +26,7 @@ int msm_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
>  {
>  	void *vaddr;
>  
> -	vaddr = msm_gem_get_vaddr(obj);
> +	vaddr = msm_gem_get_vaddr_locked(obj);
>  	if (IS_ERR(vaddr))
>  		return PTR_ERR(vaddr);
>  	iosys_map_set_vaddr(map, vaddr);
> @@ -36,7 +36,7 @@ int msm_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
>  
>  void msm_gem_prime_vunmap(struct drm_gem_object *obj, struct iosys_map *map)
>  {
> -	msm_gem_put_vaddr(obj);
> +	msm_gem_put_vaddr_locked(obj);
>  }
>  
>  struct drm_gem_object *msm_gem_prime_import_sg_table(struct drm_device *dev,

Looks good otherwise

-- 
Best regards,
Dmitry


