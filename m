Return-Path: <linux-kernel+bounces-26275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A3182DDEB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F45281600
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B2618030;
	Mon, 15 Jan 2024 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MJsYa+LC"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D08F18021;
	Mon, 15 Jan 2024 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705337450;
	bh=BkFW2G0ilqYl7fEHWFVQAT92CotbM1jOziNavrwL/7A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MJsYa+LCPEFEIO4wH5DviLeVKIJqK0Hf5VblJJaU8OaP744v1cbbTj9iVLu+VlD9J
	 JgUeKuVHrSEMeglmK4zceHdnSElAlyIIUywJ1o1IMmjHx00K7quAbOL41Zwu0Eo4hm
	 VLEMjGYMrRXX+IcaFrDGSH1ZlYutnbDvoMKmdvXxDs/QbNa8sNfG+3aeQ5QSQhJ88x
	 KKLsq+/GwSWX8ONd9k7TTVFXQ0ka0Xlm2RkVykNnK/CBqFeQ6oNg5D89OdS7uSKf0e
	 FuaM4dyDSLDA5HYGWEL9go6BDs0IAMN6tz5iLGh5bltLq6NELE5CtwFzXsLJOzTUSO
	 yLzrXDsG4acZw==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EC84237813E4;
	Mon, 15 Jan 2024 16:50:46 +0000 (UTC)
Message-ID: <06ce130f-f1ae-48b9-91ab-18a87368c6a4@collabora.com>
Date: Mon, 15 Jan 2024 13:50:44 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ci: Add msm tests
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Rob Clark <robdclark@chromium.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20240108195016.156583-1-robdclark@gmail.com>
Content-Language: en-US
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20240108195016.156583-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/01/2024 16:50, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> The msm tests should skip on non-msm hw, so I think it should be safe to
> enable everywhere.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Applied to drm-misc-next.

Thanks
Helen

> ---
>   drivers/gpu/drm/ci/testlist.txt | 49 +++++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/gpu/drm/ci/testlist.txt b/drivers/gpu/drm/ci/testlist.txt
> index f82cd90372f4..eaeb751bb0ad 100644
> --- a/drivers/gpu/drm/ci/testlist.txt
> +++ b/drivers/gpu/drm/ci/testlist.txt
> @@ -2910,3 +2910,52 @@ kms_writeback@writeback-invalid-parameters
>   kms_writeback@writeback-fb-id
>   kms_writeback@writeback-check-output
>   prime_mmap_kms@buffer-sharing
> +msm_shrink@copy-gpu-sanitycheck-8
> +msm_shrink@copy-gpu-sanitycheck-32
> +msm_shrink@copy-gpu-8
> +msm_shrink@copy-gpu-32
> +msm_shrink@copy-gpu-madvise-8
> +msm_shrink@copy-gpu-madvise-32
> +msm_shrink@copy-gpu-oom-8
> +msm_shrink@copy-gpu-oom-32
> +msm_shrink@copy-mmap-sanitycheck-8
> +msm_shrink@copy-mmap-sanitycheck-32
> +msm_shrink@copy-mmap-8
> +msm_shrink@copy-mmap-32
> +msm_shrink@copy-mmap-madvise-8
> +msm_shrink@copy-mmap-madvise-32
> +msm_shrink@copy-mmap-oom-8
> +msm_shrink@copy-mmap-oom-32
> +msm_shrink@copy-mmap-dmabuf-sanitycheck-8
> +msm_shrink@copy-mmap-dmabuf-sanitycheck-32
> +msm_shrink@copy-mmap-dmabuf-8
> +msm_shrink@copy-mmap-dmabuf-32
> +msm_shrink@copy-mmap-dmabuf-madvise-8
> +msm_shrink@copy-mmap-dmabuf-madvise-32
> +msm_shrink@copy-mmap-dmabuf-oom-8
> +msm_shrink@copy-mmap-dmabuf-oom-32
> +msm_mapping@ring
> +msm_mapping@sqefw
> +msm_mapping@shadow
> +msm_submitoverhead@submitbench-10-bos
> +msm_submitoverhead@submitbench-10-bos-no-implicit-sync
> +msm_submitoverhead@submitbench-100-bos
> +msm_submitoverhead@submitbench-100-bos-no-implicit-sync
> +msm_submitoverhead@submitbench-250-bos
> +msm_submitoverhead@submitbench-250-bos-no-implicit-sync
> +msm_submitoverhead@submitbench-500-bos
> +msm_submitoverhead@submitbench-500-bos-no-implicit-sync
> +msm_submitoverhead@submitbench-1000-bos
> +msm_submitoverhead@submitbench-1000-bos-no-implicit-sync
> +msm_recovery@hangcheck
> +msm_recovery@gpu-fault
> +msm_recovery@gpu-fault-parallel
> +msm_recovery@iova-fault
> +msm_submit@empty-submit
> +msm_submit@invalid-queue-submit
> +msm_submit@invalid-flags-submit
> +msm_submit@invalid-in-fence-submit
> +msm_submit@invalid-duplicate-bo-submit
> +msm_submit@invalid-cmd-idx-submit
> +msm_submit@invalid-cmd-type-submit
> +msm_submit@valid-submit

