Return-Path: <linux-kernel+bounces-44353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8618E84209E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF04F1F2D00A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671E3664C6;
	Tue, 30 Jan 2024 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="wlMvbztG"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200ED664A2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609148; cv=none; b=EKdpiLIWnvMoKm8fxBFrgwf2KuBj2P2ZfqUjoDHqzc1d7lcREVD3+G+FXJMnYmDgIl26HzFFnjW4LA4GXvEu7KxUKD3guxC7y7AcKyqMwZMD7mJ+g1ylt9LNdES1FdzL9vYohjuWpaOsBWk21xIHaFrRIlwm+UnNIoXMGD3E648=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609148; c=relaxed/simple;
	bh=D+HHg4Wbbhz/mbS+lLu+znnL2uXDODc+rW4Ur5A3ss0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=qiQMtSIpeiwg8eqnDMn77mk56wtD7fO3zKjmI0BH6k2Dr28IfA19n5fA2lxc3dYkED4YMb+z1hnP74uEprT3hxCQDVJ6i6r/ZheUgWzyiX98cUViwHTKmGyUZUq4oum/d/c2WLBpwcInMfvjRuFTDmguq8dA5t91nkXfaF2DVmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=wlMvbztG; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706609145;
	bh=D+HHg4Wbbhz/mbS+lLu+znnL2uXDODc+rW4Ur5A3ss0=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=wlMvbztGA0yA512ZlKIRcB6nX3f7p5ByeRR8ZKN+eBh2AixDxN3QzbFDOPyla6deg
	 glnDFEENKA5QsselWolE9MYhuP1Qj+RwLtmnTxtVNZPdPEXxcr8UvCFI1K3s6Su80t
	 TAiCRT6ybMXGiOKjNIBRDIHxOyXYMpxKq+RQ6j5kZNescOUzIGu45GpLxLh3eO6btZ
	 kagAZmX+p6yCW+om2i8uZL3Z+eUBWY43f1xd81QM5i6EchBV773GHaMhRnoFORPjPn
	 rVAEC5ZsunT5LVdbOkhr0VEo9yGS1SLZtSAwRo4QddYkNZcodEDgOyTKN0FfKYFxmd
	 QGw1T3YvU+kfA==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2B04437809D0;
	Tue, 30 Jan 2024 10:05:44 +0000 (UTC)
Message-ID: <7b284de7-f8e9-4b5a-96c5-a4e26193cd90@collabora.com>
Date: Tue, 30 Jan 2024 13:05:44 +0300
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
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
 <20240105184624.508603-10-dmitry.osipenko@collabora.com>
 <ZbKZNCbZoV4ovWTH@phenom.ffwll.local> <20240126111827.70f8726c@collabora.com>
 <d467e5a4-6b61-4cad-8e38-c4495836a0d6@collabora.com>
 <Zbi0lQG15vz6iHJK@phenom.ffwll.local>
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
In-Reply-To: <Zbi0lQG15vz6iHJK@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/30/24 11:34, Daniel Vetter wrote:
> On Fri, Jan 26, 2024 at 07:43:29PM +0300, Dmitry Osipenko wrote:
>> On 1/26/24 13:18, Boris Brezillon wrote:
>>> On Thu, 25 Jan 2024 18:24:04 +0100
>>> Daniel Vetter <daniel@ffwll.ch> wrote:
>>>
>>>> On Fri, Jan 05, 2024 at 09:46:03PM +0300, Dmitry Osipenko wrote:
>>>>> Add lockless drm_gem_shmem_get_pages() helper that skips taking reservation
>>>>> lock if pages_use_count is non-zero, leveraging from atomicity of the
>>>>> refcount_t. Make drm_gem_shmem_mmap() to utilize the new helper.
>>>>>
>>>>> Acked-by: Maxime Ripard <mripard@kernel.org>
>>>>> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
>>>>> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
>>>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>>> ---
>>>>>  drivers/gpu/drm/drm_gem_shmem_helper.c | 19 +++++++++++++++----
>>>>>  1 file changed, 15 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
>>>>> index cacf0f8c42e2..1c032513abf1 100644
>>>>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
>>>>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
>>>>> @@ -226,6 +226,20 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
>>>>>  }
>>>>>  EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
>>>>>  
>>>>> +static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
>>>>> +{
>>>>> +	int ret;  
>>>>
>>>> Just random drive-by comment: a might_lock annotation here might be good,
>>>> or people could hit some really interesting bugs that are rather hard to
>>>> reproduce ...
>>>
>>> Actually, being able to acquire a ref in a dma-signalling path on an
>>> object we know for sure already has refcount >= 1 (because we previously
>>> acquired a ref in a path where dma_resv_lock() was allowed), was the
>>> primary reason I suggested moving to this atomic-refcount approach.
>>>
>>> In the meantime, drm_gpuvm has evolved in a way that allows me to not
>>> take the ref in the dma-signalling path (the gpuvm_bo object now holds
>>> the ref, and it's acquired/released outside the dma-signalling path).
>>>
>>> Not saying we shouldn't add this might_lock(), but others might have
>>> good reasons to have this function called in a path where locking
>>> is not allowed.
>>
>> For Panthor the might_lock indeed won't be a appropriate, thanks for
>> reminding about it. I'll add explanatory comment to the code.
> 
> Hm these kind of tricks feel very dangerous to me. I think it would be
> good to split up the two cases into two functions:
> 
> 1. first one does only the atomic_inc and splats if the refcount is zero.
> I think something in the name that denotes that we're incrementing a
> borrowed pages reference would be good here, so like get_borrowed_pages
> (there's not really a naming convention for these in the kernel).
> Unfortunately no rust so we can't enforce that you provide the right kind
> of borrowed reference at compile time.
> 
> 2. second one has the might_lock.
> 
> This way you force callers to think what they're doing and ideally
> document where the borrowed reference is from, and ideally document that
> in the code. Otherwise we'll end up with way too much "works in testing,
> but is a nice CVE" code :-/

We indeed can have both variants of the borrowed/non-borrowed functions.
Thanks again for the suggestions

-- 
Best regards,
Dmitry


