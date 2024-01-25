Return-Path: <linux-kernel+bounces-39326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F41483CEC9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099262884FB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ECE13A26E;
	Thu, 25 Jan 2024 21:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="zH4YsQQ1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7E21292EA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 21:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219082; cv=none; b=n8oUQjdKsDB8t5U92uZl2uo0J5J9eyTsIcAO8jpRV0uaxvVcp/fPqHa+lm9sehweOJgJSKsBepgEgmGZxfcc1cRqWhdnyFj6KUKsXK9v0WvAY9DTvRbsNENhN5m7FiRX48HujahoL+03Sb4xDsmHdgKF6tpJwefBwmm+x9ba0eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219082; c=relaxed/simple;
	bh=VKagnVmAZwzDPUwQEySN1O/dZJAvWl37niOmwVB/dyA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eEzGXHZPJ8lpNlyYuEWic/n2tZZZSqoV8sJeo9vNtQll52foblPZWSuTJf7Syy2rjrOevje7cSeAlXVbzApAeugUjwcm8QH+JuvMaKF7h+vlIVZ0rDPG8bJBpOC8Pvu6kH1iVWu9jRRHrxXI6lcIMLBqsoRDXg0s0kNUGMg856I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=zH4YsQQ1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706219078;
	bh=VKagnVmAZwzDPUwQEySN1O/dZJAvWl37niOmwVB/dyA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=zH4YsQQ1l9xhDsaiFEXIwuiTiRpBtb9WAEHZF0IB1pCL1ARKClVhCLvtpJyejW385
	 MlZFZt3zOuBKgPCaCvbQqBeL7/fr1NdvMzbmvLXwOHAiMiLpf+t7BMzs0FN3Tp1x75
	 IZKk9/Q3MJ7nS/GfTLDHT1p0P+VEXeTEgosFRqNr4pNPdD9UedKbdo4BIXNQJ6hlOO
	 ekPlOo1/mAejbQgzUJQP9o0hPQi/9EPAkzgxCWYjhuKgpCjvBaUXJkafrEzi0znmNU
	 pr1RO2ZHuCXoiznbl/hNxf05pxnDwTd4ruetDWaCJCayfu7El6UbOZpD0cmK746ct3
	 yAH/351PiykNA==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 647DE37813DA;
	Thu, 25 Jan 2024 21:44:37 +0000 (UTC)
Message-ID: <dd49d49d-7ead-4b66-8ddf-07e4012b10d6@collabora.com>
Date: Fri, 26 Jan 2024 00:44:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 17/30] drm/panfrost: Fix the error path in
 panfrost_mmu_map_fault_addr()
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org,
 David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Qiang Yu <yuq825@gmail.com>, Emma Anholt <emma@anholt.net>,
 Melissa Wen <mwen@igalia.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
 <20240105184624.508603-18-dmitry.osipenko@collabora.com>
 <f5d94271-9b6a-4a8d-9cb7-dac055dda92c@collabora.com>
In-Reply-To: <f5d94271-9b6a-4a8d-9cb7-dac055dda92c@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/26/24 00:41, Dmitry Osipenko wrote:
> On 1/5/24 21:46, Dmitry Osipenko wrote:
>>  	for (i = page_offset; i < page_offset + NUM_FAULT_PAGES; i++) {
>> +		/* Can happen if the last fault only partially filled this
>> +		 * section of the pages array before failing. In that case
>> +		 * we skip already filled pages.
>> +		 */
>> +		if (pages[i])
>> +			continue;
>> +
>>  		pages[i] = shmem_read_mapping_page(mapping, i);
> 
> Although, the shmem_read_mapping_page() should return same page if it
> was already allocated, isn't it? I.e. there was no bug here and the
> fixes/stable tags not needed.

Scratch that, I forgot that the patch is about the unbalanced
get/put_pages

-- 
Best regards,
Dmitry


