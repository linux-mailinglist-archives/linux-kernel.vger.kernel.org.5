Return-Path: <linux-kernel+bounces-116691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26EB88A18E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB552C4B93
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EB21586E2;
	Mon, 25 Mar 2024 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KPQTl6b7"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662CF18E0D3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711354822; cv=none; b=BcCTfjBB13ukNpG50cfjoFu+SohMm/RowF0qu5VVhaQ4Rs35OGzRLERLjyPw5sO5yB2f3iZB9bLVKjyQTbfas18UMJbUkqBItGZZRnNWDJE7E3nlFo0EXKb5CNmRyrOnIkHHCFHS5fEhVvVEjodvFFlZcoxb44dVOutjVoKb6Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711354822; c=relaxed/simple;
	bh=EOuiWs8du4z/j7Ah6vYpJvGj8hoJqJ0Goki/wN9yEK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nKPI4NBDVAIyVia2CFxEldBRDEoG7SkpJWiHJPZRMdj1F0DdvCqjhRKTBd4bK4RT57aOahnFjsPFKxG8A5yLm07o/qrfY3XEy4kV9/bhibivWfUptOS9EY/TDEtyNTrNWwuj+Mz7LLY9LFgDhw5SU5idEsFUcEWGhRiomr9PET0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KPQTl6b7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711354818;
	bh=EOuiWs8du4z/j7Ah6vYpJvGj8hoJqJ0Goki/wN9yEK8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=KPQTl6b7ci0hQ7vi0vQviWzjm9nl7bFBMvlPosICqpMG+lV4FPIlcLU1i49nF8Ot6
	 //jOVs17GnLk2NA3HMrcuE8XjJ9dxEm0hKhRFgcDzRTyrM/NyniUog6xLA0z1ZMn9A
	 IW4Gr/5cGk5efv0R0rd7eqO0tjtwCYGcSD1gn1mQJfN3rpIwDG5+nG+uuSE0856J2a
	 GkSJGs40VnmRocBRxZytgIKaecMFRRkEq6bwxwr0cKgbYtl6Bdi+WhltTrDMihTRcP
	 f0r6Z98V/xdXTXcZE+bIAraxbz/7B+MeoqcbbvDSidAYkLhnWuNPBJpyo84yTAxJue
	 0VBP2vfoels2A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 047A637813B7;
	Mon, 25 Mar 2024 08:20:17 +0000 (UTC)
Message-ID: <45ef7d6e-d029-4b02-be9e-736dff3724af@collabora.com>
Date: Mon, 25 Mar 2024 09:20:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panfrost: fix power transition timeout warnings
To: Christian Hewitt <christianshewitt@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240322164525.2617508-1-christianshewitt@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240322164525.2617508-1-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 22/03/24 17:45, Christian Hewitt ha scritto:
> Increase the timeout value to prevent system logs on Amlogic boards flooding
> with power transition warnings:
> 
> [   13.047638] panfrost ffe40000.gpu: shader power transition timeout
> [   13.048674] panfrost ffe40000.gpu: l2 power transition timeout
> [   13.937324] panfrost ffe40000.gpu: shader power transition timeout
> [   13.938351] panfrost ffe40000.gpu: l2 power transition timeout
> ...
> [39829.506904] panfrost ffe40000.gpu: shader power transition timeout
> [39829.507938] panfrost ffe40000.gpu: l2 power transition timeout
> [39949.508369] panfrost ffe40000.gpu: shader power transition timeout
> [39949.509405] panfrost ffe40000.gpu: l2 power transition timeout
> 
> The 2000 value has been found through trial and error testing with devices
> using G52 and G31 GPUs.
> 
> Fixes: 22aa1a209018 ("drm/panfrost: Really power off GPU cores in panfrost_gpu_power_off()")
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   drivers/gpu/drm/panfrost/panfrost_gpu.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> index 9063ce254642..fd8e44992184 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -441,19 +441,19 @@ void panfrost_gpu_power_off(struct panfrost_device *pfdev)
>   
>   	gpu_write(pfdev, SHADER_PWROFF_LO, pfdev->features.shader_present);
>   	ret = readl_relaxed_poll_timeout(pfdev->iomem + SHADER_PWRTRANS_LO,
> -					 val, !val, 1, 1000);
> +					 val, !val, 1, 2000);
>   	if (ret)
>   		dev_err(pfdev->dev, "shader power transition timeout");
>   
>   	gpu_write(pfdev, TILER_PWROFF_LO, pfdev->features.tiler_present);
>   	ret = readl_relaxed_poll_timeout(pfdev->iomem + TILER_PWRTRANS_LO,
> -					 val, !val, 1, 1000);
> +					 val, !val, 1, 2000);

Are you sure that you need to raise the timeout for TILER as well?

Cheers,
Angelo

>   	if (ret)
>   		dev_err(pfdev->dev, "tiler power transition timeout");
>   
>   	gpu_write(pfdev, L2_PWROFF_LO, pfdev->features.l2_present);
>   	ret = readl_poll_timeout(pfdev->iomem + L2_PWRTRANS_LO,
> -				 val, !val, 0, 1000);
> +				 val, !val, 0, 2000);
>   	if (ret)
>   		dev_err(pfdev->dev, "l2 power transition timeout");
>   }



