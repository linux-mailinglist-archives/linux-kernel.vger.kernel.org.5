Return-Path: <linux-kernel+bounces-39325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7128283CEC5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C8B28781C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5A713A26E;
	Thu, 25 Jan 2024 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I5KffNlJ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CE4130E52
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706218924; cv=none; b=jVYsbiwFccwavjKLeor0yE7quxNfjQv4mydN6xS2YVxxTFZZDt2UEzEFL926Q0WcmJHKG0dN4kn3E3ef6H5YUEqEqWi9I/EvWqUynt/fDpruaWxImKFadVEjLePjS0tv+R9nfETfnuHg9yWJNABkwCbeqhoMvThns2P/xQpOfYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706218924; c=relaxed/simple;
	bh=6qkcZYWngfmRTvoOwp5UnpiufJBrssnD1F59vptg1wY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=a80AobHJ9xohWHWLb+Yjg54KxsGpctBceMYKOfgr/Ambjax9nZtAfYnnwJ6k1hrC6j0JSqGnooLv7po/FiPy9lu/Rtv1uVZm7vW0lGsERPiIprrtV1dSVmktbHTgyhMxZEpGAUiKbf8MA68vFpgHZqTYUv2UqSDIGqPR6UXWGiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I5KffNlJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706218920;
	bh=6qkcZYWngfmRTvoOwp5UnpiufJBrssnD1F59vptg1wY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=I5KffNlJy4qUnAehVXlDMpPEWTV7OGsIeSJlAox5l7zB9E2csGaYrZXUiTt9xEjRu
	 1wSHngLecv9nUrZZn4lK8E3BaQyzHkupXZ+00Y9dp2nxCDeYOlM2bxcNKNl1v50hKl
	 vbw2F9hUDKfA51s87p4ygh9gU02b6CINPP2ILYS9lAYc+gG8dCnqpEFQqSKq9FGiT7
	 hH4JAu0etmynZD1NexRS/bBPKzSMpU+qNoYBO5CjfYxTK/XtVlTCwvqwMpd1nCNvFu
	 mmmESnUNfoNGGwGFyIrYq2t3Ko4TX+LE7pYVe8mcLAEoMGpy7Lm5aZKCYu5VFr2M4J
	 evd9vc0KwWfRA==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2C1A037813DA;
	Thu, 25 Jan 2024 21:41:59 +0000 (UTC)
Message-ID: <f5d94271-9b6a-4a8d-9cb7-dac055dda92c@collabora.com>
Date: Fri, 26 Jan 2024 00:41:56 +0300
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
In-Reply-To: <20240105184624.508603-18-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/24 21:46, Dmitry Osipenko wrote:
>  	for (i = page_offset; i < page_offset + NUM_FAULT_PAGES; i++) {
> +		/* Can happen if the last fault only partially filled this
> +		 * section of the pages array before failing. In that case
> +		 * we skip already filled pages.
> +		 */
> +		if (pages[i])
> +			continue;
> +
>  		pages[i] = shmem_read_mapping_page(mapping, i);

Although, the shmem_read_mapping_page() should return same page if it
was already allocated, isn't it? I.e. there was no bug here and the
fixes/stable tags not needed.

-- 
Best regards,
Dmitry


