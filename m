Return-Path: <linux-kernel+bounces-95679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD021875133
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42B1BB2656C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA55D12EBEA;
	Thu,  7 Mar 2024 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="caoii48l"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7BB12E1FA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820180; cv=none; b=MNJxa4TpsEjTf6jnIWa2BuhMvBpzdoIHx3iW7U1t1Du/nEKWyevL68/eZtQN3gBfHw2C6G6Cb1I0UX6fcaMwW5IPGK3ijxs8aA3hevc3j5yzA0K6Dd99lAQev558RuIPHFJyOIXVk3CqPpoEFU5iT/ZDXHgJWhQEqCGHXpfVwBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820180; c=relaxed/simple;
	bh=d5ZrSPOMf8VZYJPnucyZwra5gETQB13G5oByO6C2mU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/QlCcQmMT/0WLutWxRqS9Tzt8bwKh8247GyD1ZHcOTYnpKXuCg/I1Np9JkpyzX9DwrD0sccA0PMFZrccMktrO/OPOGg4YwnQpY1DurP9RJ9iBY6yWNELd6PiDR03RSVMGcbj8RQDqvQ10NSnWXb9S64h5zFGdoDaRU4sMPM5Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=caoii48l; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709820177;
	bh=d5ZrSPOMf8VZYJPnucyZwra5gETQB13G5oByO6C2mU8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=caoii48lwHcK1xcG+TAPUzL/eS5HeSb/LsgWexTktJAixdiQI16cuK6nevouFsAZ8
	 pEXTZJAW7btyAXaakdrdUJI2WL/ah3ATANAeGsM/YkG6EdyitYXV1u8jmzWXzNsTac
	 lpnIIoCajGPywjQDOqbvDiHN8GXUCsgvw80NHYV8tHSg3uLOdG7hqKonus1cHB9Ugn
	 KEj2XZZBxf6ryRhOSysQDbxypgoaC+PeEzGxXYn9ZY+uD2yyZXAJ8eZwZI8mkeq2Oh
	 +U918b9ptRJR989V6LeSKmktnIjN5//YsNQS77nY9rR7mZ9JhEy0I68pJf88D4JnSO
	 q//F4HvUnGNnw==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CBABB3780624;
	Thu,  7 Mar 2024 14:02:51 +0000 (UTC)
Message-ID: <5559672d-4f62-4ad1-95b7-94f69b8bb9ac@collabora.com>
Date: Thu, 7 Mar 2024 11:02:51 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] drm/ci: Add support for GPU and display testing
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
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20240306030649.60269-1-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/03/2024 00:06, Vignesh Raman wrote:
> Some ARM SOCs have a separate display controller and GPU, each with
> different drivers. For mediatek mt8173, the GPU driver is powervr,
> and the display driver is mediatek. In the case of mediatek mt8183,
> the GPU driver is panfrost, and the display driver is mediatek.
> With rockchip rk3288/rk3399, the GPU driver is panfrost, while the
> display driver is rockchip. For amlogic meson, the GPU driver is
> panfrost, and the display driver is meson.
> 
> IGT tests run various tests with different xfails and can test both
> GPU devices and KMS/display devices. Currently, in drm-ci for MediaTek,
> Rockchip, and Amlogic Meson platforms, only the GPU driver is tested.
> This leads to incomplete coverage since the display is never tested on
> these platforms. This commit series adds support in drm-ci to run tests
> for both GPU and display drivers for MediaTek, Rockchip, and Amlogic
> Meson platforms.
> 
> Uprev mesa and IGT in drm-ci and add amd, v3d, vc4 and vgem specific
> tests to testlist. Have testlist.txt per driver and include a base
> testlist so that the driver specific tests will run only on those hardware
> and add testlists to the MAINTAINERS file.
> 
> This series also includes patch to add vkms testing to drm-ci.
> 
> Working pipeline link,
> https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1119859

Hi Vignesh, thanks for this patchset.

Just to confirm, the new convention is:

stages are named per DRIVER_NAME

jobs are named DRIVER_NAME:GPU_VERSION

xfails files and testlist files are named DRIVER_NAME-<xfails-suffix>.txt

Looks good.

I just have some minor comments/questions in the series, please check.

Regards,
Helen

> 
> Vignesh Raman (11):
>    drm/ci: arm64.config: Enable CONFIG_DRM_ANALOGIX_ANX7625
>    drm/ci: uprev mesa version
>    drm/ci: uprev IGT and update testlist
>    drm/ci: amdgpu: update xfails
>    drm/ci: mediatek: Refactor existing mediatek jobs
>    drm/ci: mediatek: Add job to test panfrost and powervr GPU driver
>    drm/ci: meson: Refactor existing meson jobs
>    drm/ci: meson: Add job to test panfrost GPU driver
>    drm/ci: rockchip: Refactor existing rockchip jobs
>    drm/ci: rockchip: Add job to test panfrost GPU driver
>    drm/ci: add tests on vkms
> 
>   MAINTAINERS                                   |  14 ++
>   drivers/gpu/drm/ci/arm64.config               |   1 +
>   drivers/gpu/drm/ci/build.sh                   |   1 -
>   drivers/gpu/drm/ci/container.yml              |   6 +-
>   drivers/gpu/drm/ci/gitlab-ci.yml              |  13 +-
>   drivers/gpu/drm/ci/igt_runner.sh              |  28 ++--
>   drivers/gpu/drm/ci/image-tags.yml             |   5 +-
>   drivers/gpu/drm/ci/test.yml                   | 136 +++++++++++++---
>   drivers/gpu/drm/ci/testlist-amdgpu.txt        | 151 ++++++++++++++++++
>   drivers/gpu/drm/ci/testlist-msm.txt           |  50 ++++++
>   drivers/gpu/drm/ci/testlist-panfrost.txt      |  17 ++
>   drivers/gpu/drm/ci/testlist-v3d.txt           |  73 +++++++++
>   drivers/gpu/drm/ci/testlist-vc4.txt           |  49 ++++++
>   drivers/gpu/drm/ci/testlist.txt               |  84 ++++------
>   drivers/gpu/drm/ci/x86_64.config              |   1 +
>   .../gpu/drm/ci/xfails/amdgpu-stoney-fails.txt |  26 ++-
>   .../drm/ci/xfails/amdgpu-stoney-flakes.txt    |  10 +-
>   .../gpu/drm/ci/xfails/amdgpu-stoney-skips.txt |  17 +-
>   .../drm/ci/xfails/mediatek-mt8173-fails.txt   |  15 --
>   .../drm/ci/xfails/mediatek-mt8173-flakes.txt  |  13 ++
>   .../drm/ci/xfails/mediatek-mt8183-fails.txt   |  21 ++-
>   .../drm/ci/xfails/mediatek-mt8183-flakes.txt  |   8 +
>   .../gpu/drm/ci/xfails/meson-g12b-fails.txt    |   5 -
>   .../gpu/drm/ci/xfails/panfrost-g12b-fails.txt |   1 +
>   .../gpu/drm/ci/xfails/panfrost-g12b-skips.txt |   2 +
>   .../drm/ci/xfails/panfrost-mt8183-fails.txt   |   1 +
>   .../drm/ci/xfails/panfrost-mt8183-skips.txt   |   2 +
>   .../drm/ci/xfails/panfrost-rk3288-fails.txt   |   1 +
>   .../drm/ci/xfails/panfrost-rk3288-skips.txt   |   2 +
>   .../drm/ci/xfails/panfrost-rk3399-fails.txt   |   1 +
>   .../drm/ci/xfails/panfrost-rk3399-skips.txt   |   2 +
>   .../drm/ci/xfails/rockchip-rk3288-fails.txt   |  58 ++-----
>   .../drm/ci/xfails/rockchip-rk3288-flakes.txt  |  20 +++
>   .../drm/ci/xfails/rockchip-rk3288-skips.txt   |  54 +------
>   .../drm/ci/xfails/rockchip-rk3399-fails.txt   |  38 +++--
>   .../drm/ci/xfails/rockchip-rk3399-flakes.txt  |  28 +++-
>   .../drm/ci/xfails/rockchip-rk3399-skips.txt   |   5 +-
>   .../drm/ci/xfails/virtio_gpu-none-fails.txt   |   1 -
>   drivers/gpu/drm/ci/xfails/vkms-none-fails.txt |  33 ++++
>   .../gpu/drm/ci/xfails/vkms-none-flakes.txt    |  20 +++
>   drivers/gpu/drm/ci/xfails/vkms-none-skips.txt |  16 ++
>   41 files changed, 784 insertions(+), 245 deletions(-)
>   create mode 100644 drivers/gpu/drm/ci/testlist-amdgpu.txt
>   create mode 100644 drivers/gpu/drm/ci/testlist-msm.txt
>   create mode 100644 drivers/gpu/drm/ci/testlist-panfrost.txt
>   create mode 100644 drivers/gpu/drm/ci/testlist-v3d.txt
>   create mode 100644 drivers/gpu/drm/ci/testlist-vc4.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-flakes.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-g12b-fails.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-g12b-skips.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-mt8183-fails.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-mt8183-skips.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3288-fails.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3288-skips.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3399-fails.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3399-skips.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3288-flakes.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/vkms-none-fails.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/vkms-none-flakes.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/vkms-none-skips.txt
> 

