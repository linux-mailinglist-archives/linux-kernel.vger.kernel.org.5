Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6100F79D6D1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237098AbjILQwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237084AbjILQwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:52:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D161C10E9;
        Tue, 12 Sep 2023 09:52:32 -0700 (PDT)
Received: from [192.168.0.106] (unknown [186.235.7.101])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F1221660716C;
        Tue, 12 Sep 2023 17:52:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694537551;
        bh=igS9u76vL2oPeSqObcVgUtmTOkkby+Pw+fIrRSQSDjw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UpeqNcvSWdUCXowwhN7YAh4SQxCJ4z3gCql/zXkdJ8kJu7G8lnp1IyPSKTWiPWjEE
         eBkh0Xej143eLTLObrQqfDBjEwmCJF3LspuubwXbss9yuWoIkVyxZIBEtLAxzxwaol
         83pHxtG8BjSUwQx6iKbkfAGuZibLCXcbyy+NSwwWtILVj81biyqQ8gPgYfu28h4hc0
         nCk/nWv68wpF9ZqrdoirBO8J3IIBrFB2o210wI6jGKxgNVNvshsKGcW890+fJNg6hP
         D1pxCSEyZQjRNokWQgLmT5+Bbg2j81pGo7LOsZhwRUh+YcOOqZ34qU92Y+Q8+G60DJ
         kj6gWE5vKpgCA==
Message-ID: <3f28b185-07bf-3bc8-05bb-0af2e65d1677@collabora.com>
Date:   Tue, 12 Sep 2023 13:52:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 3/9] drm: ci: Force db410c to host mode
Content-Language: en-US
To:     Vignesh Raman <vignesh.raman@collabora.com>,
        dri-devel@lists.freedesktop.org
Cc:     guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
        david.heidelberg@collabora.com, daniels@collabora.com,
        gustavo.padovan@collabora.com,
        angelogioacchino.delregno@collabora.com, emma@anholt.net,
        robclark@freedesktop.org, robdclark@google.com, anholt@google.com,
        robdclark@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, mripard@kernel.org,
        dmitry.baryshkov@linaro.org, matthias.bgg@gmail.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org
References: <20230908152225.432139-1-vignesh.raman@collabora.com>
 <20230908152225.432139-4-vignesh.raman@collabora.com>
From:   Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20230908152225.432139-4-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/09/2023 12:22, Vignesh Raman wrote:
> Force db410c to host mode to fix network issue which results in failure
> to mount root fs via NFS.
> See https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/cb72a629b8c15c80a54dda510743cefd1c4b65b8
> 
> Compile the base device tree with overlay support and use fdtoverlay
> command to merge base device tree with an overlay which contains the
> fix for USB controllers to work in host mode. [suggested by Maxime Ripard]
> 
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>

Acked-by: Helen Koike <helen.koike@collabora.com>

> ---
> 
> v2:
>    - Use fdtoverlay command to merge overlay dtbo with the base dtb instead of modifying the kernel sources
> 
> v3:
>    - drm-ci scripts to use device tree overlay from arch/arm64/boot/dts/qcom and compile base device tree with overlay support
> 
> ---
>   drivers/gpu/drm/ci/build.sh | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
> index 7b014287a041..092c195af242 100644
> --- a/drivers/gpu/drm/ci/build.sh
> +++ b/drivers/gpu/drm/ci/build.sh
> @@ -91,7 +91,12 @@ for image in ${KERNEL_IMAGE_NAME}; do
>   done
>   
>   if [[ -n ${DEVICE_TREES} ]]; then
> -    make dtbs
> +    make DTC_FLAGS=-@ dtbs
> +    if [[ -e arch/arm64/boot/dts/qcom/apq8016-sbc.dtb ]]; then
> +        dtc -@ -I dts -O dtb -o arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtbo arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtso
> +        fdtoverlay -i arch/arm64/boot/dts/qcom/apq8016-sbc.dtb -o arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtb arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtbo
> +        mv arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtb arch/arm64/boot/dts/qcom/apq8016-sbc.dtb
> +    fi
>       cp ${DEVICE_TREES} /lava-files/.
>   fi
>   
