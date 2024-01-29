Return-Path: <linux-kernel+bounces-42444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F38C684016A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAEB21F259D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6848755E72;
	Mon, 29 Jan 2024 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3dWWHEru"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C0455E59
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520333; cv=none; b=d56/yPv/wW0QxaLgd8oRsjsWOChUcoAY0LgdqbK1CMy+eI60Xh1MYUJwIKb8Q24F8OBnn82BmySlJKm8b3CzOtbYAnlDeoH3pRl+ScYFXEf294PLf0IMOCS1lYCEySl7hnuNecRb2gwxCaHshpME3LfzO2NElbYM2qTaPwrkJx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520333; c=relaxed/simple;
	bh=ZeASRK9OQU0zk9iDytgg8kPkaNP8KWri+NPgrypJ/KY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MnQBtUIn6hCKP8Ud5hqPMiPCpSGLtSQbR92KzHZR4HLGbeEvIuraidsg4jMtI7afjNmk+krMicJbpPRNCMROEmFOO66lqD+ny9hWBJ61E5Nlg+DAAdP6RlE49b4zozM65PoHll8ONONryrUdEyNa7ACKtoDF7eme0LlQONIT4vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3dWWHEru; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706520330;
	bh=ZeASRK9OQU0zk9iDytgg8kPkaNP8KWri+NPgrypJ/KY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=3dWWHEruMWT62ux6ztq3I+1FA3TnZsmeUjbKb2HiRI0njatR9x1yAbwn/KxQWFt7k
	 /AeGxYmbZrVqoJiIe1vjWJsqLE/JlGMVOFYf/OSHvPss28vYYzXZnZolLhO9FvOcMB
	 KBXvUakaOBVZrsKRDNOwnEdLuparFW0i/sY/VunFzjieWBUS2yYeCo+uJRDH+wDi1l
	 FiK5M/UfeAPPF9xxbZSbdLfzq8Lh8PcePRQzUA52HHrpyxOGlmj/0eB09+0IDod8tl
	 bY0hZJ11+DMmefPVR1vuuh/iBfz6iFtvkUrGDUx2u8gdJBrYl+e8dK9zK2upo24F+P
	 yUJ5U4Oll2QOA==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C647F37814B0;
	Mon, 29 Jan 2024 09:25:28 +0000 (UTC)
Message-ID: <e062b0dc-6630-42f9-b3ca-ac4bc0597190@collabora.com>
Date: Mon, 29 Jan 2024 12:25:26 +0300
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
 <20240129100112.35c73f18@collabora.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20240129100112.35c73f18@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/24 12:01, Boris Brezillon wrote:
> On Fri,  5 Jan 2024 21:46:16 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
>> +/**
>> + * drm_gem_shmem_swapin_locked() - Moves shmem GEM back to memory and enables
>> + *                                 hardware access to the memory.
>> + * @shmem: shmem GEM object
>> + *
>> + * This function moves shmem GEM back to memory if it was previously evicted
>> + * by the memory shrinker. The GEM is ready to use on success.
>> + *
>> + * Returns:
>> + * 0 on success or a negative error code on failure.
>> + */
>> +int drm_gem_shmem_swapin_locked(struct drm_gem_shmem_object *shmem)
>> +{
>> +	int err;
>> +
>> +	dma_resv_assert_held(shmem->base.resv);
>> +
>> +	if (!shmem->evicted)
>> +		return 0;
> 
> Shouldn't we have a drm_gem_shmem_shrinker_update_lru_locked() even if
> the object wasn't evicted, such that idle->busy transition moves the BO
> to the list tail?

Seems so, good catch. I'll double-check and remove it in the next version.

-- 
Best regards,
Dmitry


