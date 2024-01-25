Return-Path: <linux-kernel+bounces-38561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B2E83C199
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA3D288747
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A54374F5;
	Thu, 25 Jan 2024 12:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dSTgrFVZ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048EA4501B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184291; cv=none; b=m/9GgNOrLLrX9smqkuG9nEChGOZqVoAxeAPGysljS83AFafQ+0/1oNxp/LOsyehBEfhWN013elQoyZKgoUqqQeRthPs+4ti1u1mKp6JfC65Wj3GqIV+sjwE+HsgmtNukZBsgfTggYRvfUrGvPkr6/dr9F/2riXAYzL38j6oDQCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184291; c=relaxed/simple;
	bh=8sTLlfRLG1bLpm/xwyAPsioSxNa/NVfF9kum8TH3Cnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4K1jAyStqo8ZWPTbW/EZwu2eh40Zai5+sR+4mBS/pR1gwczSGKTNeNoiP/XoEDOAio9Z6WgjZx4wZMBagZHdVJD4C3dnElHKzuCt4axKlU/1HO8jgxUkA4jaIRwRuOjBOk6sht75izv84K5fcJEpS/V4beVjl+foW6fXokoVRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dSTgrFVZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706184288;
	bh=8sTLlfRLG1bLpm/xwyAPsioSxNa/NVfF9kum8TH3Cnk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dSTgrFVZ9Mgn6xrnSplLE02RSuySI6ta/n6N5lSsDjUqu8PCR05/4WwDn+SSX54PR
	 ZJgpm5bqzcKILySJzL62P7ZSqdsqvvifoqfRTdV3cUWNLuGvmYwnE1EAzy7yZiI8DM
	 P7uJrhzg7fE2E/TqqrvleB4TY2Dz/8TWYPBEsqnmWvfsWAO/3utjsWpcBR3absxtp1
	 bEJmcRs8tKkYfGmdjm/OQtplxKA8pmSpfcf0g4KuzZW3cMmoP5Q00Vq0GuG73vzYwV
	 pSHir30+r5Pzo1xFslRlF/4dwsL1SjaUOmkSd5pOutZiWPIOw8qPeCxyf9Pn9maKki
	 OpAB+HS6B7Kvw==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F26E637820AF;
	Thu, 25 Jan 2024 12:04:44 +0000 (UTC)
Message-ID: <1cf2b45f-d41b-4b2c-80c8-0b78203f4467@collabora.com>
Date: Thu, 25 Jan 2024 15:04:41 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 30/30] drm/panfrost: Switch to generic memory shrinker
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
 <20240105184624.508603-31-dmitry.osipenko@collabora.com>
 <20240125104932.478fa5bd@collabora.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20240125104932.478fa5bd@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/24 12:49, Boris Brezillon wrote:
> On Fri,  5 Jan 2024 21:46:24 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
>> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> @@ -328,6 +328,7 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
>>  	struct panfrost_device *pfdev = to_panfrost_device(obj->dev);
>>  	struct sg_table *sgt;
>>  	int prot = IOMMU_READ | IOMMU_WRITE;
>> +	int ret = 0;
>>  
>>  	if (WARN_ON(mapping->active))
>>  		return 0;
>> @@ -335,15 +336,32 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
>>  	if (bo->noexec)
>>  		prot |= IOMMU_NOEXEC;
>>  
>> +	if (!obj->import_attach) {
>> +		/*
>> +		 * Don't allow shrinker to move pages while pages are mapped.
>> +		 * It's fine to move pages afterwards because shrinker will
>> +		 * take care of unmapping pages during eviction.
>> +		 */
> 
> That's not exactly what this shmem_pin() is about, is it? I think it's
> here to meet the drm_gem_shmem_get_pages_sgt() rule stating that pages
> must be pinned while the sgt returned by drm_gem_shmem_get_pages_sgt()
> is manipulated. You actually unpin the GEM just after the mmu_map_sg()
> call, which means pages could very well be reclaimed while the MMU
> still has a mapping referencing those physical pages. And that's fine,
> because what's supposed to protect against that is the fence we
> register to the GEM resv at job submission time.

The comment indeed needs to be improved, thanks.

s/are mapped/in process of mapping creation/

-- 
Best regards,
Dmitry


