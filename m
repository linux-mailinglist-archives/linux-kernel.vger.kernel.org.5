Return-Path: <linux-kernel+bounces-126863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F22B8941A0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F34282FCB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1590482EF;
	Mon,  1 Apr 2024 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="w7NlItC3"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B86D3F8F4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 16:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989842; cv=none; b=atWpHyNR5Y88EYFinuFj28dGxtDdftiAFPQXJq5hAQ3UIM4jseFEzGdvzVTLa8L7TsXRk82WXpMZ1oNXgdsQVya/aeYmVuVakMeDkys0wOZpia+BNAuwf5cGG8/oQQC59hYiU8owvd+bDSCubBrfaqO+L7GHHha953RIcRivTCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989842; c=relaxed/simple;
	bh=gemtcSPoT1AOg9qcgv0H1qrD2L5TyuQQo6IjQ8duTxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c8o7DZzI9an0xzViosnh0iGdQ9bxaC7dCKVUXBOmTqBwYEtVCASGQtWDrbE+G9wtVSgMOAAIdOfidY32gZeE7ggwAXO5LjWq3S81BnbvJ9uY8H64iKRJ60oC2edsH0Othq7AjWLrMnzZRaHldESU7fVD9ehWrFDLtQySG/bH3+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=w7NlItC3; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711989839;
	bh=gemtcSPoT1AOg9qcgv0H1qrD2L5TyuQQo6IjQ8duTxI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=w7NlItC3G35ZlxXYh8cqCdynoHv5E85wypQcqH7nLrWU3dmgxiJ5LgyHe35Qkxhqc
	 q6EwpBFhB4qT3HGdhKbVnWagW+4IlHhfWfh6By5GnnXXwp/WdBgB2mjgL7Vw+l7BZE
	 3/eY1lia/GPznzIVxUx1Zs78k7/MduzzhQwxt+tgciIJbnfQaYw+Q6qA70/Wa9ol1M
	 birMgz/Z3ZApp3fb3gqJYd3USGjRnZ3O/OoBodu/YT3jijdITgVd0SdoXjEdVutV6Y
	 mquzBDf+P/CcpC4+IQ/DmF0xe0nb3qksLC3UeACMW4vKV8kH33vn07KGaw/v5bkUw8
	 AzBBaWKjV5j5Q==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 772213781144;
	Mon,  1 Apr 2024 16:43:53 +0000 (UTC)
Message-ID: <17c5f479-8d25-411a-816f-506320359ab5@collabora.com>
Date: Mon, 1 Apr 2024 13:43:51 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] drm/ci: rockchip: Add job to test panfrost GPU
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
 <20240401061235.192713-10-vignesh.raman@collabora.com>
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20240401061235.192713-10-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/04/2024 03:12, Vignesh Raman wrote:
> For rockchip rk3288 and rk3399, the GPU driver is panfrost.
> So add support in drm-ci to test panfrost driver for rockchip
> SOC and update xfails. Skip KMS tests for panfrost driver
> since it is not a not a KMS driver and skip driver-specific tests.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>

Btw, just a nit, I would squash this with the previous commit, so we 
don't have a point in history with panfrost tests, than without them, 
than with them again. But with or without this change:

Acked-by: Helen Koike <helen.koike@collabora.com>

Thanks
Helen

> ---
> 
> v2:
>    - Add panfrost GPU jobs for rockchip SOC with new xfails.
> 
> v3:
>    - Skip KMS tests for panfrost driver since it is not a not
>      a KMS driver and update xfails. Add the job name in GPU_VERSION
>      and use it for xfail file names instead of using DRIVER_NAME.
> 
> v4:
>    - Remove the gpu suffix in job and rename xfails accordingly.
> 
> v5:
>    - Skip driver-specific tests.
> 
> ---
>   drivers/gpu/drm/ci/test.yml                         | 10 ++++++++++
>   drivers/gpu/drm/ci/xfails/panfrost-rk3288-fails.txt |  1 +
>   drivers/gpu/drm/ci/xfails/panfrost-rk3288-skips.txt |  8 ++++++++
>   drivers/gpu/drm/ci/xfails/panfrost-rk3399-fails.txt |  1 +
>   drivers/gpu/drm/ci/xfails/panfrost-rk3399-skips.txt |  8 ++++++++
>   5 files changed, 28 insertions(+)
>   create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3288-fails.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3288-skips.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3399-fails.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3399-skips.txt
> 
> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
> index 96b299c32c07..8c90ae5a51e6 100644
> --- a/drivers/gpu/drm/ci/test.yml
> +++ b/drivers/gpu/drm/ci/test.yml
> @@ -191,11 +191,21 @@ rockchip:rk3288:
>       - .rk3288
>       - .rockchip-display
>   
> +panfrost:rk3288:
> +  extends:
> +    - .rk3288
> +    - .panfrost-gpu
> +
>   rockchip:rk3399:
>     extends:
>       - .rk3399
>       - .rockchip-display
>   
> +panfrost:rk3399:
> +  extends:
> +    - .rk3399
> +    - .panfrost-gpu
> +
>   .i915:
>     extends:
>       - .lava-igt:x86_64
> diff --git a/drivers/gpu/drm/ci/xfails/panfrost-rk3288-fails.txt b/drivers/gpu/drm/ci/xfails/panfrost-rk3288-fails.txt
> new file mode 100644
> index 000000000000..abd35a8ef6f4
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/xfails/panfrost-rk3288-fails.txt
> @@ -0,0 +1 @@
> +panfrost_prime@gem-prime-import,Crash
> diff --git a/drivers/gpu/drm/ci/xfails/panfrost-rk3288-skips.txt b/drivers/gpu/drm/ci/xfails/panfrost-rk3288-skips.txt
> new file mode 100644
> index 000000000000..41a846a59644
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/xfails/panfrost-rk3288-skips.txt
> @@ -0,0 +1,8 @@
> +# Panfrost is not a KMS driver, so skip the KMS tests
> +kms_.*
> +
> +# Skip driver specific tests
> +msm_.*
> +^amdgpu.*
> +v3d_.*
> +vc4_.*
> diff --git a/drivers/gpu/drm/ci/xfails/panfrost-rk3399-fails.txt b/drivers/gpu/drm/ci/xfails/panfrost-rk3399-fails.txt
> new file mode 100644
> index 000000000000..6f5e760d5ec0
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/xfails/panfrost-rk3399-fails.txt
> @@ -0,0 +1 @@
> +panfrost_prime@gem-prime-import,Fail
> diff --git a/drivers/gpu/drm/ci/xfails/panfrost-rk3399-skips.txt b/drivers/gpu/drm/ci/xfails/panfrost-rk3399-skips.txt
> new file mode 100644
> index 000000000000..41a846a59644
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/xfails/panfrost-rk3399-skips.txt
> @@ -0,0 +1,8 @@
> +# Panfrost is not a KMS driver, so skip the KMS tests
> +kms_.*
> +
> +# Skip driver specific tests
> +msm_.*
> +^amdgpu.*
> +v3d_.*
> +vc4_.*

