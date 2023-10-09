Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550977BD194
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 02:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344597AbjJIA6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 20:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjJIA6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 20:58:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211A7C5
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 17:58:20 -0700 (PDT)
Received: from [192.168.0.206] (unknown [179.221.49.143])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AD2D7660708F;
        Mon,  9 Oct 2023 01:58:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696813098;
        bh=iyqhwDnwF7AwvV3O9cDzUHraQOQU1oAC4hzX35F7zQM=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=MN47zg4+4104956De6zL8c1SNn/B7MmIE738bjzkHbD6edynqU4Dtgc7mgLlFrSsw
         XJFX7lSNM99wAvI8KNPfCXKiP9hGKWjhrlVdYbr/wMVlV1Ci0aE5KOcpekJi3wKsdT
         ZHamkq/tirA/TZUMCYWVPa+km7wVDykZvoWLzx5maXwGQ9y52ORmSlLUSJc/mVjG9s
         kUTLR/z0JjuizfKbnJ2BVpbb9ftA25FuCMdmcqBRg13+2X/YlxZ58ThowL5OTTwC33
         W0+Ab6S1S1PUfw1DDHHJqlERBBnqyn3nZpz2qbPsn4OX5pAbeWn3u943yzbRJqRLD1
         BdEUW+HHC1bHQ==
Message-ID: <b29d0a17-b7cb-4b41-b23c-7e26e363ca5f@collabora.com>
Date:   Sun, 8 Oct 2023 21:58:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/ci: uprev mesa version - fix container build
Content-Language: en-US
From:   Helen Koike <helen.koike@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     mripard@kernel.org, rodrigosiqueiramelo@gmail.com,
        michel.daenzer@mailbox.org, vignesh.raman@collabora.com,
        linux-kernel@vger.kernel.org, quic_abhinavk@quicinc.com,
        melissa.srw@gmail.com, mairacanal@riseup.net,
        quic_jesszhan@quicinc.com
References: <20230922171237.550762-1-helen.koike@collabora.com>
 <20230922171237.550762-2-helen.koike@collabora.com>
In-Reply-To: <20230922171237.550762-2-helen.koike@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear maintainers,

Do not pick this patch, I re-sent it as part of the series
	[PATCH 0/9] drm/ci: fixes and improvements

https://lists.freedesktop.org/archives/dri-devel/2023-October/425909.html

Thanks
Regards,
Helen

On 22/09/2023 14:12, Helen Koike wrote:
> When building containers, some rust packages were installed without
> locking the dependencies version, which got updated and started giving
> errors like:
> 
> error: failed to compile `bindgen-cli v0.62.0`, intermediate artifacts can be found at `/tmp/cargo-installkNKRwf`
> Caused by:
>    package `rustix v0.38.13` cannot be built because it requires rustc 1.63 or newer, while the currently active rustc version is 1.60.0
> 
> A patch to Mesa was recently added fixing this error, so update it.
> 
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> 
> ---
> 
> v2:
> - point to upstream mesa/mesa (solved the TODO and removed RFC tag)
> ---
>   drivers/gpu/drm/ci/gitlab-ci.yml  | 15 ++++++++++++++-
>   drivers/gpu/drm/ci/lava-submit.sh |  2 +-
>   2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
> index 2c4df53f5dfe..522f83db1a07 100644
> --- a/drivers/gpu/drm/ci/gitlab-ci.yml
> +++ b/drivers/gpu/drm/ci/gitlab-ci.yml
> @@ -1,6 +1,6 @@
>   variables:
>     DRM_CI_PROJECT_PATH: &drm-ci-project-path mesa/mesa
> -  DRM_CI_COMMIT_SHA: &drm-ci-commit-sha 0dc961645c4f0241f8512cb0ec3ad59635842072
> +  DRM_CI_COMMIT_SHA: &drm-ci-commit-sha 1cdc4be14b66108ae0e8069686ac3efe52bef3cb
>   
>     UPSTREAM_REPO: git://anongit.freedesktop.org/drm/drm
>     TARGET_BRANCH: drm-next
> @@ -24,6 +24,8 @@ variables:
>     PIPELINE_ARTIFACTS_BASE: ${S3_HOST}/artifacts/${CI_PROJECT_PATH}/${CI_PIPELINE_ID}
>     # per-job artifact storage on MinIO
>     JOB_ARTIFACTS_BASE: ${PIPELINE_ARTIFACTS_BASE}/${CI_JOB_ID}
> +  # default kernel for rootfs before injecting the current kernel tree
> +  KERNEL_IMAGE_BASE: https://${S3_HOST}/mesa-lava/gfx-ci/linux/v6.4.12-for-mesa-ci-f6b4ad45f48d
>   
>     LAVA_JOB_PRIORITY: 30
>   
> @@ -86,6 +88,17 @@ include:
>         - '/.gitlab-ci/container/gitlab-ci.yml'
>         - '/.gitlab-ci/test/gitlab-ci.yml'
>         - '/.gitlab-ci/lava/lava-gitlab-ci.yml'
> +      - '/src/microsoft/ci/gitlab-ci-inc.yml'
> +      - '/src/gallium/drivers/zink/ci/gitlab-ci-inc.yml'
> +      - '/src/gallium/drivers/crocus/ci/gitlab-ci-inc.yml'
> +      - '/src/gallium/drivers/softpipe/ci/gitlab-ci-inc.yml'
> +      - '/src/gallium/drivers/llvmpipe/ci/gitlab-ci-inc.yml'
> +      - '/src/gallium/drivers/virgl/ci/gitlab-ci-inc.yml'
> +      - '/src/gallium/drivers/nouveau/ci/gitlab-ci-inc.yml'
> +      - '/src/gallium/frontends/lavapipe/ci/gitlab-ci-inc.yml'
> +      - '/src/intel/ci/gitlab-ci-inc.yml'
> +      - '/src/freedreno/ci/gitlab-ci-inc.yml'
> +      - '/src/amd/ci/gitlab-ci-inc.yml'
>     - drivers/gpu/drm/ci/image-tags.yml
>     - drivers/gpu/drm/ci/container.yml
>     - drivers/gpu/drm/ci/static-checks.yml
> diff --git a/drivers/gpu/drm/ci/lava-submit.sh b/drivers/gpu/drm/ci/lava-submit.sh
> index 0c4456b21b0f..379f26ea87cc 100755
> --- a/drivers/gpu/drm/ci/lava-submit.sh
> +++ b/drivers/gpu/drm/ci/lava-submit.sh
> @@ -22,7 +22,7 @@ cp "$SCRIPTS_DIR"/setup-test-env.sh results/job-rootfs-overlay/
>   
>   # Prepare env vars for upload.
>   section_start variables "Variables passed through:"
> -KERNEL_IMAGE_BASE_URL="https://${BASE_SYSTEM_HOST_PATH}" \
> +KERNEL_IMAGE_BASE="https://${BASE_SYSTEM_HOST_PATH}" \
>   	artifacts/ci-common/generate-env.sh | tee results/job-rootfs-overlay/set-job-env-vars.sh
>   section_end variables
>   
