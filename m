Return-Path: <linux-kernel+bounces-126860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BF2894184
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 424DCB22736
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF4C4778C;
	Mon,  1 Apr 2024 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UM1YiwuO"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896CA4AED7
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989770; cv=none; b=YRhLNerzslyf8OBlCrxe9Jk4M6I8cNEZS1FuvCz4kUbjK+i5Qs26DQTRx0XuXEqrRHSGZYYkccKA3ykPdw3Ds6bXhRYhSVhfF3wjUuJJxKxmOozsINkoXBAZuKRgCahUqxAJn2jPJ8uyVMfvwsUlxFhAFhmzbUZrW5BbjX/2q9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989770; c=relaxed/simple;
	bh=rf+9gU+rgHvHJUsWo+FAi96Dw6JhGte2wcuY71kOctM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YIG+PI4Qwv0zpcuOcmT9/w2o62n06UsoS3qh7BYQUZjhulAweO71Xi0KkFXNXNivGAjK8Dh1BL/FHmPmugujuKsWKxThs0Z0fI7cw9M1NzCUTsNa4TwBhUZHPdd9rSV0lxOFnFNZF3S4/Y5z1Nm0Zw1y2LG3RGMnXJluTcEwzOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UM1YiwuO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711989766;
	bh=rf+9gU+rgHvHJUsWo+FAi96Dw6JhGte2wcuY71kOctM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UM1YiwuO/tuhCuB5c/VEVrEptNQ+rQcuebpqijmIAG2FZX47Sls8Kj4uW3ZwGvbQE
	 gCai4P1sUwVp7UfE11xWid0dFsS9GR7AT++1J/hNqqTUqzzulfmekUxBQp6IpihQPB
	 VyRHg751/LoL0zWPYUYq04cV7ZRxeamt+OzdU9U4rI6+82xOaeKd4ZTnzZj8O/vkpC
	 b7kZDzIwxjnfLwNM95ihROmVGfBLvFxMu3N9Wr0qnf3gm3Vug+5ay25aFLaemf7Ddr
	 c9SG7JnA4IfeqVHJFvVwILZIrUoc3yJUBMcCy1FV2Kk3/AnoBxW8JoPCGl8J/J9P9o
	 m54faGdoPsS/g==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0AFE0378143B;
	Mon,  1 Apr 2024 16:42:40 +0000 (UTC)
Message-ID: <9133098c-dbfa-4be6-815d-d2cd5ea4b9f3@collabora.com>
Date: Mon, 1 Apr 2024 13:42:40 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/10] drm/ci: meson: Refactor existing meson jobs
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
References: <20240401061235.192713-1-vignesh.raman@collabora.com>
 <20240401061235.192713-7-vignesh.raman@collabora.com>
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20240401061235.192713-7-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/04/2024 03:12, Vignesh Raman wrote:
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
> v5:
>    - Add meson-display job.
> 
> ---
>   drivers/gpu/drm/ci/test.yml                    | 14 +++++++++++---
>   drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt |  5 -----
>   2 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
> index adeb05bdb440..505733069995 100644
> --- a/drivers/gpu/drm/ci/test.yml
> +++ b/drivers/gpu/drm/ci/test.yml
> @@ -357,14 +357,17 @@ panfrost:mt8183:
>   .meson:

I also would rename this to .meson-device, so we don't confuse with the 
driver name, what do you think?

With or without this change:

Acked-by: Helen Koike <helen.koike@collabora.com>

Thanks
Helen

>     extends:
>       - .lava-igt:arm64
> -  stage: meson
>     variables:
> -    DRIVER_NAME: meson
>       DTB: ${DEVICE_TYPE}
>       BOOT_METHOD: u-boot
>       KERNEL_IMAGE_TYPE: "image"
>   
> -meson:g12b:
> +.meson-display:
> +  stage: meson
> +  variables:
> +    DRIVER_NAME: meson
> +
> +.g12b:
>     extends:
>       - .meson
>     parallel: 3
> @@ -373,6 +376,11 @@ meson:g12b:
>       GPU_VERSION: g12b
>       RUNNER_TAG: mesa-ci-x86-64-lava-meson-g12b-a311d-khadas-vim3
>   
> +meson:g12b:
> +  extends:
> +    - .g12b
> +    - .meson-display
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

