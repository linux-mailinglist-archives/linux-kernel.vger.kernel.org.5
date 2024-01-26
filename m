Return-Path: <linux-kernel+bounces-40337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2818E83DEB2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E3528B96F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE2D1DFE8;
	Fri, 26 Jan 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="sCBvO4UI"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B365C1DDD5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286483; cv=none; b=QYyIm5+CrModG2slUnVGhbsuSLeVktbbk5x1c0BCOJh/vX8Ir+OlQqMu9mh/CXOddDBTLltBJV/TvSalwpePyCo4yTSEbfQ6Y6JbC5dQS58S1veDcfBT5LTvf1ioUfmHXmBVmZQ5diXTy44kDXcgD6eFRUVBS9ug8SvVKq9x1rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286483; c=relaxed/simple;
	bh=bfATvgFGy1C+UULaXubImPOXGtd8BvEu9bs2VEk+/Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFjairWMImU6XmwrFq0UKTxLNYG10idy18AYJA1fEHJaqg5OeU7IhE9A1jk/n3KJWLQzdq2au/s9jLGI+vWweygJYvrcecXHJ3WC3nWbQTXPAT799hfi1L5JklV7p/cIRUaqNqyQ+aQOMFGGiBh+WAeEPf48G9HRWTHiddZ/cAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=sCBvO4UI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706286473;
	bh=bfATvgFGy1C+UULaXubImPOXGtd8BvEu9bs2VEk+/Dw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sCBvO4UIouCEmJXzxqhm0SshcENzhxQdzX0Ocvo34m24MIWT1NPDpdD8VvY6p0fy0
	 hX9gcK9H2vZArf3s2YTSQDD35NhF3W+dJJX66Jr4xNCsb2yyHujIzRw+8u1iMqHydj
	 MYXEo3txYBnr2zSxMgLextGneTBTMta24DazKJLef/lU05FoJ3FGXEsU1K9I9kRwrb
	 UE7DOoB/eP3bW6+HrZgT6rVfw9Uj/sMVVhXIMemG7R2sKwrg+G4RC9bpoLOOzkUjc8
	 r/eppjQtRE0/C3od/3tcmkeiNkjDwNLut4TejaqdnPhosvebrZH50F69DQA+EVnGMa
	 vQzB+px0U5RVA==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2322A378107C;
	Fri, 26 Jan 2024 16:27:52 +0000 (UTC)
Message-ID: <fab38fed-635c-4dbe-aa13-dcdf8f267988@collabora.com>
Date: Fri, 26 Jan 2024 19:27:49 +0300
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
 <f4870543-e7f8-4ee6-924a-68ec7c25b293@collabora.com>
 <20240126105537.67b1613e@collabora.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20240126105537.67b1613e@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/26/24 12:55, Boris Brezillon wrote:
> On Fri, 26 Jan 2024 00:56:47 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
>> On 1/25/24 13:19, Boris Brezillon wrote:
>>> On Fri,  5 Jan 2024 21:46:16 +0300
>>> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
>>>   
>>>> +static bool drm_gem_shmem_is_evictable(struct drm_gem_shmem_object *shmem)
>>>> +{
>>>> +	return (shmem->madv >= 0) && shmem->base.funcs->evict &&
>>>> +		refcount_read(&shmem->pages_use_count) &&
>>>> +		!refcount_read(&shmem->pages_pin_count) &&
>>>> +		!shmem->base.dma_buf && !shmem->base.import_attach &&
>>>> +		!shmem->evicted;  
>>>
>>> Are we missing
>>>
>>>                 && dma_resv_test_signaled(shmem->base.resv,
>>> 					  DMA_RESV_USAGE_BOOKKEEP)
>>>
>>> to make sure the GPU is done using the BO?
>>> The same applies to drm_gem_shmem_is_purgeable() BTW.
>>>
>>> If you don't want to do this test here, we need a way to let drivers
>>> provide a custom is_{evictable,purgeable}() test.
>>>
>>> I guess we should also expose drm_gem_shmem_shrinker_update_lru_locked()
>>> to let drivers move the GEMs that were used most recently (those
>>> referenced by a GPU job) at the end of the evictable LRU.  
>>
>> We have the signaled-check in the common drm_gem_evict() helper:
>>
>> https://elixir.bootlin.com/linux/v6.8-rc1/source/drivers/gpu/drm/drm_gem.c#L1496
> 
> Ah, indeed. I'll need DMA_RESV_USAGE_BOOKKEEP instead of
> DMA_RESV_USAGE_READ in panthor, but I can add it in the driver specific
> ->evict() hook (though that means calling dma_resv_test_signaled()
> twice, which is not great, oh well).

Maybe we should change drm_gem_evict() to use BOOKKEEP. The
test_signaled(BOOKKEEP) should be a "stronger" check than
test_signaled(READ)?

> The problem about the evictable LRU remains though: we need a way to let
> drivers put their BOs at the end of the list when the BO has been used
> by the GPU, don't we?

If BO is use, then it won't be evicted, while idling BOs will be
evicted. Hence, the used BOs will be naturally moved down the LRU list
each time shrinker is invoked.

-- 
Best regards,
Dmitry


