Return-Path: <linux-kernel+bounces-40366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B29F83DF11
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2951C23A21
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA511DFD1;
	Fri, 26 Jan 2024 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KeswJROh"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4701DDEC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287416; cv=none; b=P+vzovN7/dvz8hiCGD3ZdCne5b1pVgRhsl2E/U3j88irXG/U8ipKOGXQpyWIxp3mo034IuWOxHrzbtNXUS4FexFBCh1BnmQQfblxHIesgju9Q3ZWzHj8pw00yQTNr9HvLNillmtO6jHSrHrb/E/QXEUxun5+qpI9vfOlj4sj/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287416; c=relaxed/simple;
	bh=U6u3xgf4R+utqvmtwCD7pg1WXxuAovEW7noxe87GDmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYEFT73SKWOgerOq8zFB1pUR6XSnTgm2hG3DK4A82OHnGKYcW3mEr9tX6s6dnabXS+W9io3ZWdkk9NT5n9q/ihHNjv4fMgohRQEl7cODVx42VOv9angDTadGryfpce3OADvsQRkoLqPKUtFQcg7LWoj+64uZ5bg8FtelLPcf/qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KeswJROh; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706287413;
	bh=U6u3xgf4R+utqvmtwCD7pg1WXxuAovEW7noxe87GDmw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KeswJROhwGGRCE5tdZ1RC8zLadqOPmPE3UK2Yj5P5hgbG7FBPfNCxYkwMYNE+SKwd
	 DX6GBQiHWaaIhiby6QrQjjW1qb01imlJGar0H58w0ZXPj4Ig74w7iN/dBhp+rCJMfp
	 U1x8qHsm+S8XWiZe2bhGxGBqyOwVSlqtEjRf6THeYOgu8ceW/2h9FNH4SNQSYPgC2Q
	 vCcyVSZzLEGNQ9Kz0Z1aRA19OxbfqZAcasBM+kXiB2wYcSGMwQcTvSXkvwS+pTKH1R
	 Iove7Or8j6Dtwzb+a5PJc70/zZs8HnXriVfNq36SpeachhYK8w6V4KaLxjrNApzXXy
	 7oqzT/l5MaLNA==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0146F378201D;
	Fri, 26 Jan 2024 16:43:31 +0000 (UTC)
Message-ID: <d467e5a4-6b61-4cad-8e38-c4495836a0d6@collabora.com>
Date: Fri, 26 Jan 2024 19:43:29 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 09/30] drm/shmem-helper: Add and use lockless
 drm_gem_shmem_get_pages()
Content-Language: en-US
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
 Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
 <20240105184624.508603-10-dmitry.osipenko@collabora.com>
 <ZbKZNCbZoV4ovWTH@phenom.ffwll.local> <20240126111827.70f8726c@collabora.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20240126111827.70f8726c@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/26/24 13:18, Boris Brezillon wrote:
> On Thu, 25 Jan 2024 18:24:04 +0100
> Daniel Vetter <daniel@ffwll.ch> wrote:
> 
>> On Fri, Jan 05, 2024 at 09:46:03PM +0300, Dmitry Osipenko wrote:
>>> Add lockless drm_gem_shmem_get_pages() helper that skips taking reservation
>>> lock if pages_use_count is non-zero, leveraging from atomicity of the
>>> refcount_t. Make drm_gem_shmem_mmap() to utilize the new helper.
>>>
>>> Acked-by: Maxime Ripard <mripard@kernel.org>
>>> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
>>> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> ---
>>>  drivers/gpu/drm/drm_gem_shmem_helper.c | 19 +++++++++++++++----
>>>  1 file changed, 15 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
>>> index cacf0f8c42e2..1c032513abf1 100644
>>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
>>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
>>> @@ -226,6 +226,20 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
>>>  }
>>>  EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
>>>  
>>> +static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
>>> +{
>>> +	int ret;  
>>
>> Just random drive-by comment: a might_lock annotation here might be good,
>> or people could hit some really interesting bugs that are rather hard to
>> reproduce ...
> 
> Actually, being able to acquire a ref in a dma-signalling path on an
> object we know for sure already has refcount >= 1 (because we previously
> acquired a ref in a path where dma_resv_lock() was allowed), was the
> primary reason I suggested moving to this atomic-refcount approach.
> 
> In the meantime, drm_gpuvm has evolved in a way that allows me to not
> take the ref in the dma-signalling path (the gpuvm_bo object now holds
> the ref, and it's acquired/released outside the dma-signalling path).
> 
> Not saying we shouldn't add this might_lock(), but others might have
> good reasons to have this function called in a path where locking
> is not allowed.

For Panthor the might_lock indeed won't be a appropriate, thanks for
reminding about it. I'll add explanatory comment to the code.

-- 
Best regards,
Dmitry


