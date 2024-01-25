Return-Path: <linux-kernel+bounces-39343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D308483CF04
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7C8BB283A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C582413AA5C;
	Thu, 25 Jan 2024 21:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="39qnnPbd"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D07713AA3C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 21:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219815; cv=none; b=C4PH7YzZXZYmRGcAKqvZaWMBkfi4iHuxhFmMYw/MGbJr8DwysbJoqOBYJz9EsjmxucW6OPOq/1SxKWiaynroH8WqGpIBrYazSJdsWAkBqEfAUzBMROs+VIpgLWc1sD2BEUU+b7DEzV0k24jXEfI+dW/hfibJQKSzZOavVJz1a94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219815; c=relaxed/simple;
	bh=a8hfMqHEGvH+hPCINRceKqJZjJJ3zaZm6oEEjXubXRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lwHfPxG2fJ1+xeLpc+cUgV1aId6Gz3JrIanSXdfMnNFFUI6zvvXIo3W3CkvYhYvm8GDbNIkULqRa9u6twpsxv2yN+cs6ibl9FFeZr6fWrEkfMig9Wv5yjxvMTC88k2CTpwkNDMwUfb4u3UOq1dYFGLmT0K37cMOfwwaWjkWlNtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=39qnnPbd; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706219811;
	bh=a8hfMqHEGvH+hPCINRceKqJZjJJ3zaZm6oEEjXubXRo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=39qnnPbdvuaxnc0JNHB37AqfHZ2dDcwUCODaMGK3NDGhG3Z1pwywzkSb4/dk4w+RO
	 oa2tf+XNJLuYgc+yPLAlmMzEyIupgjUqQGGLhAYl4pxNyXK2/+uVG8G+tjuRlSfjjs
	 uar3dsg+Zi+i4HsOUXTDQoNS99T9wr/YXMH9g+jUxhHjrCzyr6SLyKcTY2HlvaL2pV
	 RcC8tY53zLvW8a6WaYbhMc4y0aMSYDAk1X8IHSQT0G5sRdwSObfNvAJtvIpCrZcz0C
	 0q+PBIp4FH4P4i+hpiD4Adr1/oVdXKBy1p5FEugk/ALABkPNqKqIB3kR14S2/DBpKY
	 lpGTII6la0koQ==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5803137813DA;
	Thu, 25 Jan 2024 21:56:50 +0000 (UTC)
Message-ID: <f4870543-e7f8-4ee6-924a-68ec7c25b293@collabora.com>
Date: Fri, 26 Jan 2024 00:56:47 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 22/30] drm/shmem-helper: Add common memory shrinker
Content-Language: en-US
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
 Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
 <20240105184624.508603-23-dmitry.osipenko@collabora.com>
 <20240125111946.797a1e1e@collabora.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20240125111946.797a1e1e@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/24 13:19, Boris Brezillon wrote:
> On Fri,  5 Jan 2024 21:46:16 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
>> +static bool drm_gem_shmem_is_evictable(struct drm_gem_shmem_object *shmem)
>> +{
>> +	return (shmem->madv >= 0) && shmem->base.funcs->evict &&
>> +		refcount_read(&shmem->pages_use_count) &&
>> +		!refcount_read(&shmem->pages_pin_count) &&
>> +		!shmem->base.dma_buf && !shmem->base.import_attach &&
>> +		!shmem->evicted;
> 
> Are we missing
> 
>                 && dma_resv_test_signaled(shmem->base.resv,
> 					  DMA_RESV_USAGE_BOOKKEEP)
> 
> to make sure the GPU is done using the BO?
> The same applies to drm_gem_shmem_is_purgeable() BTW.
> 
> If you don't want to do this test here, we need a way to let drivers
> provide a custom is_{evictable,purgeable}() test.
> 
> I guess we should also expose drm_gem_shmem_shrinker_update_lru_locked()
> to let drivers move the GEMs that were used most recently (those
> referenced by a GPU job) at the end of the evictable LRU.

We have the signaled-check in the common drm_gem_evict() helper:

https://elixir.bootlin.com/linux/v6.8-rc1/source/drivers/gpu/drm/drm_gem.c#L1496

-- 
Best regards,
Dmitry


