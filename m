Return-Path: <linux-kernel+bounces-95675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1F287512B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A07C6B24746
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B408512D778;
	Thu,  7 Mar 2024 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LgINMicX"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FCC12D1F8
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820165; cv=none; b=Vli3bWxYb2qPGAyZ6oRZVhKY6u8oNA32ILvtdIYEFq/C/SBFuAFvMAqIGUyEvuE+qJfJ989wH92G0hkuasXTieDHZW6TdUnbxyC13jpWb1zoA60DAafnhwCA2y4A7z06ibnv/ZJOfDdXwbJFytW+GcCMMVysml3hUNJA95hm/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820165; c=relaxed/simple;
	bh=el7Xx44TkO/oXmS7mAYy5b9cHRg71LxMpmK1H3GipkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdEfdfU2VKFzXDXVy1eySA0fx82tx2AQXNhi53CexwXvJfN8FSM5F3ZBHO+pnGCH0eon08gBBwM3taWpmi1rroD2IheoPQvr9yskKYSYMs595fI6eGDSznb/EZM+mp0jJjxaFfj6iIC2N+WbpXoqO4VEZP//9HI35a4KUmj7uQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LgINMicX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709820161;
	bh=el7Xx44TkO/oXmS7mAYy5b9cHRg71LxMpmK1H3GipkM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LgINMicX/QDKggUxWPkJvRxWF13oZJKjSsojQ11dzqmJXn8xvc3PfRb/LAEueBomL
	 bOLcDaOCNMELJxW67wfidD1O+CuIRcm5FdMu3XUMUg9LT7VpRgZsMrYqsg7my6TJR2
	 drptsKePCY742KS0WK29YgJjGbI8SbhyVNS496McXt3GRx2EYxKXWFTzvy3camtYu0
	 k20ysDUaz0kl0cx6CeLcEC3wFtAbOFXVDu1MGXZMe6sdvctnbdL3/BN8s5GhGQ5OBY
	 KSqg4jAoV8n+5+2mAi53pqkPbTxEoU9WGBPW9Rlhk6gYjhv2GwVTzEWqRTnTyNkRwQ
	 jenrk05jpsWFA==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1226937820DA;
	Thu,  7 Mar 2024 14:02:35 +0000 (UTC)
Message-ID: <f6c1ced6-7f33-455d-9e7a-f26608241372@collabora.com>
Date: Thu, 7 Mar 2024 11:02:33 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/11] drm/ci: meson: Refactor existing meson jobs
Content-Language: en-US
To: Vignesh Raman <vignesh.raman@collabora.com>,
 dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
 emma@anholt.net, robdclark@gmail.com, david.heidelberg@collabora.com,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 hamohammed.sa@gmail.com, rodrigosiqueiramelo@gmail.com,
 melissa.srw@gmail.com, mairacanal@riseup.net, mcanal@igalia.com,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240306030649.60269-1-vignesh.raman@collabora.com>
 <20240306030649.60269-8-vignesh.raman@collabora.com>
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20240306030649.60269-8-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/03/2024 00:06, Vignesh Raman wrote:
> For Amlogic Meson SOC the display driver is meson. Currently,
> in drm-ci for meson, only the display driver is tested.
> Refactor the existing meson jobs so that gpu driver testing
> jobs can be added later and update xfails accordingly.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v2:
>    - Refactor the patch to rename job to indicate display driver testing,
>      rename the existing xfail files.
> 
> v3:
>    - Add the job name in GPU_VERSION and use it for xfail file names instead
>      of using DRIVER_NAME.
> 
> v4:
>    - Remove the display suffix in job and rename xfails accordingly.
>      Remove the change adding job name in GPU_VERSION.
> 
> ---
>   drivers/gpu/drm/ci/test.yml                    | 11 ++++++++---
>   drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt |  5 -----
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
> index 99fd101ce2fe..951a44bf9d19 100644
> --- a/drivers/gpu/drm/ci/test.yml
> +++ b/drivers/gpu/drm/ci/test.yml
> @@ -351,20 +351,25 @@ panfrost:mt8183:
>       - .lava-igt:arm64
>     stage: meson
>     variables:
> -    DRIVER_NAME: meson
>       DTB: ${DEVICE_TYPE}
>       BOOT_METHOD: u-boot
>       KERNEL_IMAGE_TYPE: "image"
>   
> -meson:g12b:
> +.g12b:
>     extends:
>       - .meson
>     parallel: 3
>     variables:
>       DEVICE_TYPE: meson-g12b-a311d-khadas-vim3
> -    GPU_VERSION: g12b

Looks like it make sense to keep GPU_VERSION here, no?

Regards,
Helen

>       RUNNER_TAG: mesa-ci-x86-64-lava-meson-g12b-a311d-khadas-vim3
>   
> +meson:g12b:
> +  extends:
> +    - .g12b
> +  variables:
> +    GPU_VERSION: g12b
> +    DRIVER_NAME: meson
> +
>   virtio_gpu:none:
>     stage: virtio-gpu
>     variables:
> diff --git a/drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt b/drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt
> index 56a2ae7047b4..029b4ade21f6 100644
> --- a/drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt
> +++ b/drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt
> @@ -5,11 +5,6 @@ kms_cursor_legacy@single-bo,Fail
>   kms_cursor_legacy@single-move,Fail
>   kms_cursor_legacy@torture-bo,Fail
>   kms_cursor_legacy@torture-move,Fail
> -kms_force_connector_basic@force-edid,Fail
> -kms_hdmi_inject@inject-4k,Fail
> -kms_plane_cursor@overlay,Fail
> -kms_plane_cursor@primary,Fail
> -kms_plane_cursor@viewport,Fail
>   kms_properties@connector-properties-atomic,Fail
>   kms_properties@connector-properties-legacy,Fail
>   kms_properties@get_properties-sanity-atomic,Fail

