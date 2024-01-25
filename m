Return-Path: <linux-kernel+bounces-39337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B78E83CEE9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EADD6B275FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134CD1CA89;
	Thu, 25 Jan 2024 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DjKPBOn5"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11B83173A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219546; cv=none; b=i1taoC4aEzIEGApIBljSq5nV1ZZyQg5dNLh7wM71WIqIFY6yKUn+ftTu2l6kM/DKpfJd5FaegChgbi4a8eC66H8761H82VTvbuSbkzx4NoaorsF6k0xewM/P65R6UrfPvbANTBVs3xHOjn5WPshazKE+4crvWfnUrMtWjH3kT3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219546; c=relaxed/simple;
	bh=HmHb/1j56mYypkJHtCxMuyE8iJQuLLhZ2r3pRbNJ0Ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o7S9Yqqbu2NokAYvfWdWFz34tdOcSFViSsFqHVF9+17NpBdqhPpwfpFd3zV2jhc+pu60fDh8cn8eKt3BSajqzyEN55w13nyPxf9KSnu2+iG2PyI2iN4b9TClRvtaZstTt8BP75sB4Jz47LWf0sTcFqJDL489c9ARHj/D7jhKwqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DjKPBOn5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706219543;
	bh=HmHb/1j56mYypkJHtCxMuyE8iJQuLLhZ2r3pRbNJ0Ek=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=DjKPBOn5DkLFgqwP0WrFz5zmWSBPLMUa00i2AzL5gujzFWsxBQJZtLk7yLL4Fk3mw
	 qmf8pOZT2aIxEOOBFymm2cbk1Njwpow9/hYB9Dk8zf/mhLP307VzkWdqq4xBJF8wLf
	 tlsvHel51nr4LS9KByd5zZvHCDSOwM61iCe7TAo8h0bWYUdSRNwZixl4i54JTwVIm6
	 yFQaOuEc9iAfV7ZRTQ4jdqHSm1HsPVgPgqP/FIYD2UOvIMWRoFH4wpvvrVhztuII52
	 DN7YkZbkTJfLwGjonrp80UCfEH/C+yzfA/rfDazDfJeZw/6PzT2FLOrO2Mlo4WEFVO
	 a/Iznos2DQfjg==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C958D37813DA;
	Thu, 25 Jan 2024 21:52:21 +0000 (UTC)
Message-ID: <ddcae9fe-6155-4542-898c-bfb06e8721b8@collabora.com>
Date: Fri, 26 Jan 2024 00:52:19 +0300
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
To: David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
 <20240105184624.508603-10-dmitry.osipenko@collabora.com>
 <ZbKZNCbZoV4ovWTH@phenom.ffwll.local>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <ZbKZNCbZoV4ovWTH@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/24 20:24, Daniel Vetter wrote:
> On Fri, Jan 05, 2024 at 09:46:03PM +0300, Dmitry Osipenko wrote:
>> Add lockless drm_gem_shmem_get_pages() helper that skips taking reservation
>> lock if pages_use_count is non-zero, leveraging from atomicity of the
>> refcount_t. Make drm_gem_shmem_mmap() to utilize the new helper.
>>
>> Acked-by: Maxime Ripard <mripard@kernel.org>
>> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
>> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>  drivers/gpu/drm/drm_gem_shmem_helper.c | 19 +++++++++++++++----
>>  1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
>> index cacf0f8c42e2..1c032513abf1 100644
>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
>> @@ -226,6 +226,20 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
>>  }
>>  EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
>>  
>> +static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
>> +{
>> +	int ret;
> 
> Just random drive-by comment: a might_lock annotation here might be good,
> or people could hit some really interesting bugs that are rather hard to
> reproduce ...
> -Sima

Thanks for the suggestion!

-- 
Best regards,
Dmitry


