Return-Path: <linux-kernel+bounces-44351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0616384209A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740BF1F2C883
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B50B60DD6;
	Tue, 30 Jan 2024 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="wEPrVcL1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7FF57867
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609105; cv=none; b=s6FP9c1WAzKlRc5dy4D5MuBGaQwbr9y3Y2/1mC+i85iksucjeGOB5iJjFSmTAjGE7GkbQ/CCS8QJAq4g+jRH6lvZtW//ijioykLJWhOv6lnJQo1K7uIzOk86zWwC/BNWkX0sefAtI6bF3e3JtdW5rUU1B6onvTyfr+vbV8E2cMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609105; c=relaxed/simple;
	bh=OlF6rYfzSLDc07Nix/XsJE3v1wpI2M+vC30AXD7tPx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=nHivquW7Wi/IfIDW1m2VClPCbgWO8BEpGL3/qTAg9jrSY3GQMEuwbrCe4NMZ1b3g61I9Ib365MvTXu4oWPNir2Yr0KmaoHHrtb87LadXACg2hFcTYvufRa+B0ZXKV8JYI4wBR/Ire3xESbDY8dlZLM/ivt3s818+G/HmV5r+HfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=wEPrVcL1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706609102;
	bh=OlF6rYfzSLDc07Nix/XsJE3v1wpI2M+vC30AXD7tPx8=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=wEPrVcL13eYKKd2hTvCFzEW2+o1GszHbxGVTwxTZOH5qLSZuXBT8ah8hb9D/nu4cJ
	 28IM6RvvT1owcV6fnNsjvFIV6W+CkGtsQWgHqgT1tg74qA/8d0mvQ99VDi6UndfUa0
	 xfME/koSHKPTkTKquOw0vVY1UvhnJOaE7VQJPfk6w+qA77yjmisW0NGf86ajEf3raN
	 DnSKCSecrMyHfbrxVXGfiEwPyczs8F9SrX7/lLw78dOi5aHCv9jZ5OOlayHFJaXxrq
	 XcPcr8hzDIp3Mt8yV45ZjE9Twxl1tLMmyseedue1uOU5ZgWVMnOvjygPLPf8KS4QkV
	 9Pb8olRw/A+/g==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 22FE437809D0;
	Tue, 30 Jan 2024 10:05:01 +0000 (UTC)
Message-ID: <12f365c7-6827-4960-bb6d-11b79c4bb328@collabora.com>
Date: Tue, 30 Jan 2024 13:04:58 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 22/30] drm/shmem-helper: Add common memory shrinker
Content-Language: en-US
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Daniel Vetter <daniel@ffwll.ch>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
 <20240105184624.508603-23-dmitry.osipenko@collabora.com>
 <20240125100703.76d802ad@collabora.com> <Zbi1pzY3CbQxnnBQ@phenom.ffwll.local>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
 Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
In-Reply-To: <Zbi1pzY3CbQxnnBQ@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/30/24 11:39, Daniel Vetter wrote:
> On Thu, Jan 25, 2024 at 10:07:03AM +0100, Boris Brezillon wrote:
>> On Fri,  5 Jan 2024 21:46:16 +0300
>> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
>>
>>>   *
>>>   * This function Increases the use count and allocates the backing pages if
>>>   * use-count equals to zero.
>>> + *
>>> + * Note that this function doesn't pin pages in memory. If your driver
>>> + * uses drm-shmem shrinker, then it's free to relocate pages to swap.
>>> + * Getting pages only guarantees that pages are allocated, and not that
>>> + * pages reside in memory. In order to pin pages use drm_gem_shmem_pin().
>>
>> I still find this explanation confusing, if pages are allocated, they
>> reside in memory. The only difference between drm_gem_shmem_get_pages()
>> and drm_gem_shmem_pin_pages() is that the former lets the system
>> reclaim the memory if the buffer is idle (no unsignalled fence attached
>> to the dma_resv).
>>
>> We also need to describe the workflow for GEM validation (that's the
>> TTM term for the swapin process happening when a GPU job is submitted).
>>
>> 1. Prepare the GPU job and initialize its fence
>> 2. Lock the GEM resv
>> 3. Add the GPU job fence to the resv object
>> 4. If the GEM is evicted
>>    a. call drm_gem_shmem_swapin_locked()
>>    b. get the new sgt with drm_gem_shmem_get_pages_sgt_locked()
>>    c. repopulate the MMU table (driver internals)
> 
> Might be good to explain where to call drm_sched_job_arm() here for
> drivers using drm/sched, since that also needs to be at a very specific
> point. Probably best to flesh out the details here by linking to the
> relevant drm/sched and gpuvm functions as examples.
> 
>> 5. Unlock the GEM dma_resv
>> 6. Submit the GPU job
>>
>> With this sequence, the GEM pages are guaranteed to stay around until
>> the GPU job is finished.
> 
> Yeah I think the comment needs to explain how this ties together with
> dma_resv locking and dma_resv fences, otherwise it just doesn't make much
> sense.
> 
> This holds even more so given that some of the earlier drivers derived
> from i915-gem code (and i915-gem itself) use _pin() both for these more
> permanent pinnings, and also to temporarily put the memory in place before
> it all gets fenced and then unpinned&unlocked.
> 
> So would be really good to have the sharpest possible nomeclatura here we
> can get, and link between all the related concepts and functions in the
> kerneldoc.
> 
> Some overview flow like Boris sketched above in a DOC: section would also
> be great.

Thank you all for the feedback! I'll add all this doc in the next version

-- 
Best regards,
Dmitry


