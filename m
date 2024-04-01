Return-Path: <linux-kernel+bounces-126861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDA7894192
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 504E1B21FCA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB824AEC3;
	Mon,  1 Apr 2024 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="h9xlKKWy"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D8E3F8F4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989806; cv=none; b=s1B2rwdBRnrGy16rUu8wk+Kun/ETkqfkgNtS1Luqq1bblbmLF3NZ4sRycaJrSk8y1tOlimf6t4fRHcSJ+uzhoTY8gQAB2yUlm5luzZFtgvlI1jPm2+SfkInIbtM/sMOVZIRNre0eDDovbaBT127/y/WbOtebNgyxoHxrKkYKciA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989806; c=relaxed/simple;
	bh=jj/7JBEtwmOllBv+V+90Ub0Tp6aGpKsq0JrqIiVbE5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZplhR5IdntQYRneb4qM2n6KH8QThkunk4qRKf4O/V8cVqgiBxwsjOKyx5Wf5JAjpbMokcKiFE0PjH6zLVvkBgi6A10kBouy9DyAhiFfDj/g3LrVFBDIO2U9Zo1yMlyApOKL9+mkjerEJnR70Td+sPFIVTnzG58sNnxvlc/ydR2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=h9xlKKWy; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711989803;
	bh=jj/7JBEtwmOllBv+V+90Ub0Tp6aGpKsq0JrqIiVbE5I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h9xlKKWyIwllQPpM8f6+Y5/WphYZoXQfOLS6XWg0Uleb9GaZuPBov4eBYJY9bYmz2
	 DLDzL7pItuSboJs3hA4CGcbnahRoRp8E1bhEatXhMzhcF5Fwd0aBKFEPgyjf6X9cHz
	 le0sb8OPhfDZ4BTUOzjp+E5bhPeMrLZ0MpPUaZuewWIHPvDE4jaAVvilALNm96GonT
	 ksvs9C1RguUVPhcrplQ4eYd0CMqHpjyudl2hmzywqn8ql1G77WL8Mxd/lHyY5UAr6X
	 bLwtpaVLIM/+g6jP2uNz39xSrtDLZaGC6OVNYMYwWtBgxGXGRykLGI2Mr1SH2zdz5Y
	 WG6+b61r1Z6wg==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 557AA378143B;
	Mon,  1 Apr 2024 16:43:17 +0000 (UTC)
Message-ID: <c0d9a271-7454-4e5d-8f53-f3b3cd0830ef@collabora.com>
Date: Mon, 1 Apr 2024 13:43:17 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/10] drm/ci: meson: Add job to test panfrost GPU
 driver
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
 <20240401061235.192713-8-vignesh.raman@collabora.com>
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20240401061235.192713-8-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/04/2024 03:12, Vignesh Raman wrote:
> For amlogic meson SOC the GPU driver is panfrost. So add
> support in drm-ci to test panfrost driver for amlogic meson
> SOC and update xfails. Skip KMS tests for panfrost driver since
> it is not a not a KMS driver and skip driver-specific tests.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>

Nit: Maybe squash this with previous commit.

With or without this change:

Acked-by: Helen Koike <helen.koike@collabora.com>

Thanks
Helen

> ---
> 
> v2:
>    - Add panfrost GPU jobs for amlogic meson SOC with new xfails.
> 
> v3:
>    - Skip KMS tests for panfrost driver since it is not a not a KMS
>      driver and update xfails. Add the job name in GPU_VERSION and use
>      it for xfail file names instead of using DRIVER_NAME.
> 
> v4:
>    - Remove the gpu suffix in job and rename xfails accordingly.
> 
> v5:
>    - Use panfrost-gpu job and skip driver-specific tests.
> 
> ---
>   drivers/gpu/drm/ci/test.yml                       | 5 +++++
>   drivers/gpu/drm/ci/xfails/panfrost-g12b-fails.txt | 1 +
>   drivers/gpu/drm/ci/xfails/panfrost-g12b-skips.txt | 8 ++++++++
>   3 files changed, 14 insertions(+)
>   create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-g12b-fails.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-g12b-skips.txt
> 
> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
> index 505733069995..d1d42ff7df2d 100644
> --- a/drivers/gpu/drm/ci/test.yml
> +++ b/drivers/gpu/drm/ci/test.yml
> @@ -381,6 +381,11 @@ meson:g12b:
>       - .g12b
>       - .meson-display
>   
> +panfrost:g12b:
> +  extends:
> +    - .g12b
> +    - .panfrost-gpu
> +
>   virtio_gpu:none:
>     stage: virtio-gpu
>     variables:
> diff --git a/drivers/gpu/drm/ci/xfails/panfrost-g12b-fails.txt b/drivers/gpu/drm/ci/xfails/panfrost-g12b-fails.txt
> new file mode 100644
> index 000000000000..6f5e760d5ec0
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/xfails/panfrost-g12b-fails.txt
> @@ -0,0 +1 @@
> +panfrost_prime@gem-prime-import,Fail
> diff --git a/drivers/gpu/drm/ci/xfails/panfrost-g12b-skips.txt b/drivers/gpu/drm/ci/xfails/panfrost-g12b-skips.txt
> new file mode 100644
> index 000000000000..41a846a59644
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/xfails/panfrost-g12b-skips.txt
> @@ -0,0 +1,8 @@
> +# Panfrost is not a KMS driver, so skip the KMS tests
> +kms_.*
> +
> +# Skip driver specific tests
> +msm_.*
> +^amdgpu.*
> +v3d_.*
> +vc4_.*

