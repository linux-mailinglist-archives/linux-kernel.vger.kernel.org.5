Return-Path: <linux-kernel+bounces-26277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE06182DDF4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8B11C219F6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F09017C95;
	Mon, 15 Jan 2024 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aoQZiULc"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9B717C79
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705337473;
	bh=N2J+yCfLHvASnDXe6HJERs+pwdEjhdNWb2qi423cmME=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aoQZiULcRs+1k6ZyWg8BytmcnPpKWMZd73pHhn7G0OUE+D+Z7KBECfYURJIGjDtWv
	 ou0GOqgE5N+/PZ1u9dD/3eoRQjBhbRqiddOLXD6Wg7991JUJO1ZL/o1WdDVSJP+Yek
	 AxeojDQ4dmjhvZ21sAByaVWn438Txtmzor9Gj8mn7tquCZLnU274a8Gy5vq7srVuE3
	 D1deClXyMm80+gMNMU/G+UvmWmpbazqt8T3rtSdILemxAGUwc9rDHmlYjiOXFq3B69
	 F1Laci3ZeRrArkuOYdbP7Bnq2IQfeaNZdnND7OOMITCkJE6jzlHzvxyCvPJAGOEUc7
	 3WoT7gHOSacKw==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2B55437802F2;
	Mon, 15 Jan 2024 16:51:08 +0000 (UTC)
Message-ID: <224ce329-581d-40f7-8142-be4db93da9c9@collabora.com>
Date: Mon, 15 Jan 2024 13:51:08 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/ci: uprev mesa version: fix kdl commit fetch
Content-Language: en-US
To: Vignesh Raman <vignesh.raman@collabora.com>,
 dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, daniel@ffwll.ch, daniels@collabora.com,
 david.heidelberg@collabora.com, sergi.blanch.torne@collabora.com,
 guilherme.gallo@collabora.com, emma@anholt.net, robdclark@gmail.com,
 dmitry.baryshkov@linaro.org, quic_abhinavk@quicinc.com,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20231222033434.1537761-1-vignesh.raman@collabora.com>
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20231222033434.1537761-1-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22/12/2023 00:34, Vignesh Raman wrote:
> build-kdl.sh was doing a `clone --depth 1` of the default branch,
> then checking out a commit that might not be the latest of that
> branch, resulting in container build error.
> 
> https://gitlab.freedesktop.org/mesa/mesa/-/commit/5efa4d56 fixes
> kdl commit fetch issue. Uprev mesa in drm-ci to fix this.
> 
> This commit updates the kernel tag and adds .never-post-merge-rules
> due to the mesa uprev. It also fixes an issue where the virtio-gpu
> pipeline was not getting created with the mesa uprev.
> 
> Reviewed-by: David Heidelberg <david.heidelberg@collabora.com>
> Acked-by: Helen Koike <helen.koike@collabora.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Tested-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>

Applied to drm-misc-next.

Thanks
Helen

> ---
> 
> v2:
>    - Fix an issue where the virtio-gpu pipeline was not getting created with the mesa uprev
>      https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1062221
> 
> ---
>   drivers/gpu/drm/ci/gitlab-ci.yml | 14 ++++++++++++--
>   drivers/gpu/drm/ci/test.yml      |  1 +
>   2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
> index dac92cc2777c..084e3ff8e3f4 100644
> --- a/drivers/gpu/drm/ci/gitlab-ci.yml
> +++ b/drivers/gpu/drm/ci/gitlab-ci.yml
> @@ -1,6 +1,6 @@
>   variables:
>     DRM_CI_PROJECT_PATH: &drm-ci-project-path mesa/mesa
> -  DRM_CI_COMMIT_SHA: &drm-ci-commit-sha edfbf74df1d4d6ce54ffe24566108be0e1a98c3d
> +  DRM_CI_COMMIT_SHA: &drm-ci-commit-sha 9d162de9a05155e1c4041857a5848842749164cf
>   
>     UPSTREAM_REPO: git://anongit.freedesktop.org/drm/drm
>     TARGET_BRANCH: drm-next
> @@ -25,7 +25,9 @@ variables:
>     # per-job artifact storage on MinIO
>     JOB_ARTIFACTS_BASE: ${PIPELINE_ARTIFACTS_BASE}/${CI_JOB_ID}
>     # default kernel for rootfs before injecting the current kernel tree
> -  KERNEL_IMAGE_BASE: https://${S3_HOST}/mesa-lava/gfx-ci/linux/v6.4.12-for-mesa-ci-f6b4ad45f48d
> +  KERNEL_REPO: "gfx-ci/linux"
> +  KERNEL_TAG: "v6.6.4-for-mesa-ci-e4f4c500f7fb"
> +  KERNEL_IMAGE_BASE: https://${S3_HOST}/mesa-lava/${KERNEL_REPO}/${KERNEL_TAG}
>     LAVA_TAGS: subset-1-gfx
>     LAVA_JOB_PRIORITY: 30
>   
> @@ -133,6 +135,11 @@ stages:
>       - if: &is-pre-merge-for-marge '$GITLAB_USER_LOGIN == "marge-bot" && $CI_PIPELINE_SOURCE == "merge_request_event"'
>         when: on_success
>   
> +.never-post-merge-rules:
> +  rules:
> +    - if: *is-post-merge
> +      when: never
> +
>   # Rule to filter for only scheduled pipelines.
>   .scheduled_pipeline-rules:
>     rules:
> @@ -150,6 +157,7 @@ stages:
>   .build-rules:
>     rules:
>       - !reference [.no_scheduled_pipelines-rules, rules]
> +    - !reference [.never-post-merge-rules, rules]
>       # Run automatically once all dependency jobs have passed
>       - when: on_success
>   
> @@ -157,6 +165,7 @@ stages:
>   .container+build-rules:
>     rules:
>       - !reference [.no_scheduled_pipelines-rules, rules]
> +    - !reference [.never-post-merge-rules, rules]
>       - when: manual
>   
>   .ci-deqp-artifacts:
> @@ -175,6 +184,7 @@ stages:
>   .container-rules:
>     rules:
>       - !reference [.no_scheduled_pipelines-rules, rules]
> +    - !reference [.never-post-merge-rules, rules]
>       # Run pipeline by default in the main project if any CI pipeline
>       # configuration files were changed, to ensure docker images are up to date
>       - if: *is-post-merge
> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
> index 2c9a1838e728..1705f268547a 100644
> --- a/drivers/gpu/drm/ci/test.yml
> +++ b/drivers/gpu/drm/ci/test.yml
> @@ -324,6 +324,7 @@ virtio_gpu:none:
>       GPU_VERSION: none
>     extends:
>       - .test-gl
> +    - .test-rules
>     tags:
>       - kvm
>     script:

