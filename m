Return-Path: <linux-kernel+bounces-26276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3343482DDF1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD863282CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E14017BCF;
	Mon, 15 Jan 2024 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ch86deD0"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2118218021;
	Mon, 15 Jan 2024 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705337462;
	bh=DC9Jh9pFmu5k4BQ6l1Qg7eBJ0jpNnFf4vqw9arXi75M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ch86deD0SaZHhovNVqSRXjmOsjq++0KTZ/8tjTs+wZ7CxgoDqdhxqeqqv0gJY3rfE
	 B3fRcsBdKU15iR2lvNYqwGiV7dxJS9V83sVvinZAY7H8sW5yp0oFZBK4FdO7efVA7H
	 xDazYp8X+Xf6f2W9aoG6FBMTcSapiNLgS0lzkTHhNL3Y3HzucZjfgQOh4xChSZnAzw
	 dOGtJzOPMXTT+U5k7Plr+0PCe3tKWV66pOg0tbLYRdVhPlZamWMGktyU7YVSd1I435
	 hBrk5yHyaBSjAtHeQauLcQQl/RvrYgFcjErEmg0ncf4JDU4BIayl58acKx7YqrCkHk
	 ojeiP3bktz4Vw==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 758B437802F2;
	Mon, 15 Jan 2024 16:50:58 +0000 (UTC)
Message-ID: <f00d1e58-4399-4192-a8c6-0485fa97486f@collabora.com>
Date: Mon, 15 Jan 2024 13:50:58 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/ci: Update xfails for newly added msm tests
Content-Language: en-US
To: Vignesh Raman <vignesh.raman@collabora.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
Cc: daniels@collabora.com, sean@poorly.run, guilherme.gallo@collabora.com,
 sergi.blanch.torne@collabora.com, quic_abhinavk@quicinc.com,
 david.heidelberg@collabora.com, dmitry.baryshkov@linaro.org,
 marijn.suijten@somainline.org, airlied@gmail.com,
 linux-kernel@vger.kernel.org
References: <20240115101750.27077-1-vignesh.raman@collabora.com>
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20240115101750.27077-1-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/01/2024 07:17, Vignesh Raman wrote:
> msm tests are added to testlist.txt, so update the xfails
> for jobs in msm stage.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>

Applied to drm-misc-next.

Thanks
Helen

> ---
> 
> Depends on https://patchwork.kernel.org/project/linux-arm-msm/patch/20240108195016.156583-1-robdclark@gmail.com/
> 
> ---
>   .../gpu/drm/ci/xfails/msm-apq8016-fails.txt   |  3 +-
>   .../gpu/drm/ci/xfails/msm-sdm845-fails.txt    |  5 +---
>   .../gpu/drm/ci/xfails/msm-sdm845-flakes.txt   | 28 +++++++++++++------
>   .../gpu/drm/ci/xfails/msm-sdm845-skips.txt    |  7 ++++-
>   4 files changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt b/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
> index d39d254c935e..44a5c62dedad 100644
> --- a/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
> +++ b/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
> @@ -6,8 +6,6 @@ kms_cursor_legacy@all-pipes-single-bo,Fail
>   kms_cursor_legacy@all-pipes-single-move,Fail
>   kms_cursor_legacy@all-pipes-torture-bo,Fail
>   kms_cursor_legacy@all-pipes-torture-move,Fail
> -kms_cursor_legacy@forked-bo,Fail
> -kms_cursor_legacy@forked-move,Fail
>   kms_cursor_legacy@pipe-A-forked-bo,Fail
>   kms_cursor_legacy@pipe-A-forked-move,Fail
>   kms_cursor_legacy@pipe-A-single-bo,Fail
> @@ -18,3 +16,4 @@ kms_force_connector_basic@force-edid,Fail
>   kms_hdmi_inject@inject-4k,Fail
>   kms_selftest@drm_format,Timeout
>   kms_selftest@drm_format_helper,Timeout
> +msm_mapping@ring,Fail
> diff --git a/drivers/gpu/drm/ci/xfails/msm-sdm845-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sdm845-fails.txt
> index c55baa2d18c1..e9043a00383e 100644
> --- a/drivers/gpu/drm/ci/xfails/msm-sdm845-fails.txt
> +++ b/drivers/gpu/drm/ci/xfails/msm-sdm845-fails.txt
> @@ -15,7 +15,7 @@ kms_color@pipe-A-ctm-max,Fail
>   kms_color@pipe-A-ctm-negative,Fail
>   kms_color@pipe-A-ctm-red-to-blue,Fail
>   kms_color@pipe-A-legacy-gamma,Fail
> -kms_cursor_legacy@basic-flip-after-cursor-legacy,Fail
> +kms_cursor_legacy@basic-flip-after-cursor-atomic,Fail
>   kms_cursor_legacy@basic-flip-after-cursor-varying-size,Fail
>   kms_cursor_legacy@basic-flip-before-cursor-atomic,Fail
>   kms_cursor_legacy@basic-flip-before-cursor-legacy,Fail
> @@ -29,9 +29,6 @@ kms_cursor_legacy@flip-vs-cursor-atomic,Fail
>   kms_cursor_legacy@flip-vs-cursor-crc-atomic,Fail
>   kms_cursor_legacy@flip-vs-cursor-crc-legacy,Fail
>   kms_cursor_legacy@flip-vs-cursor-legacy,Fail
> -kms_cursor_legacy@short-flip-after-cursor-atomic-transitions,Fail
> -kms_cursor_legacy@short-flip-after-cursor-atomic-transitions-varying-size,Fail
> -kms_cursor_legacy@short-flip-after-cursor-toggle,Fail
>   kms_flip@flip-vs-modeset-vs-hang,Fail
>   kms_flip@flip-vs-panning-vs-hang,Fail
>   kms_pipe_crc_basic@compare-crc-sanitycheck-nv12,Fail
> diff --git a/drivers/gpu/drm/ci/xfails/msm-sdm845-flakes.txt b/drivers/gpu/drm/ci/xfails/msm-sdm845-flakes.txt
> index 16d205c04cbb..8a492f01eaa4 100644
> --- a/drivers/gpu/drm/ci/xfails/msm-sdm845-flakes.txt
> +++ b/drivers/gpu/drm/ci/xfails/msm-sdm845-flakes.txt
> @@ -1,12 +1,22 @@
> -kms_cursor_legacy@basic-flip-after-cursor-atomic
> -kms_cursor_legacy@basic-flip-before-cursor-varying-size
> -kms_cursor_legacy@cursorA-vs-flipA-toggle
> -kms_cursor_legacy@flip-vs-cursor-atomic-transitions
> +# Board Name: msm:sdm845
> +# Bug Report: https://lore.kernel.org/dri-devel/46287831-edfa-78e8-6055-d7a08831c445@collabora.com/T/#u
> +# Failure Rate: 50
> +# IGT Version: 1.28-gd2af13d9f
> +# Linux Version: 6.7.0-rc3
> +
> +# Reported by deqp-runner
> +kms_cursor_legacy@basic-flip-after-cursor-legacy
>   kms_cursor_legacy@flip-vs-cursor-toggle
>   kms_cursor_legacy@flip-vs-cursor-varying-size
> +kms_cursor_legacy@short-flip-after-cursor-toggle
>   kms_cursor_legacy@short-flip-before-cursor-atomic-transitions
> -kms_cursor_legacy@short-flip-before-cursor-toggle
> -kms_flip@flip-vs-modeset-vs-hang
> -kms_flip@flip-vs-panning-vs-hang
> -kms_plane@pixel-format
> -kms_plane@pixel-format-source-clamping
> +kms_cursor_legacy@short-flip-before-cursor-atomic-transitions-varying-size
> +msm_shrink@copy-gpu-32
> +msm_shrink@copy-gpu-oom-32
> +
> +# The below test shows inconsistency across multiple runs, giving
> +# results of Pass and Fail alternately.
> +kms_cursor_legacy@basic-flip-before-cursor-varying-size
> +kms_cursor_legacy@flip-vs-cursor-atomic-transitions
> +kms_cursor_legacy@short-flip-after-cursor-atomic-transitions
> +kms_cursor_legacy@short-flip-after-cursor-atomic-transitions-varying-size
> diff --git a/drivers/gpu/drm/ci/xfails/msm-sdm845-skips.txt b/drivers/gpu/drm/ci/xfails/msm-sdm845-skips.txt
> index 42675f1c6d76..618e3a3a7277 100644
> --- a/drivers/gpu/drm/ci/xfails/msm-sdm845-skips.txt
> +++ b/drivers/gpu/drm/ci/xfails/msm-sdm845-skips.txt
> @@ -1,2 +1,7 @@
>   # Hangs machine
> -kms_bw.*
> \ No newline at end of file
> +kms_bw.*
> +
> +# Failing due to a bootloader/fw issue. The workaround in mesa CI involves these two patches
> +# https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/4b49f902ec6f2bb382cbbf489870573f4b43371e
> +# https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/38cdf4c5559771e2474ae0fecef8469f65147bc1
> +msm_mapping@*

