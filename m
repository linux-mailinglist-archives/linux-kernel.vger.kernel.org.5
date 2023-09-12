Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A5679D6BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbjILQuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbjILQuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:50:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5A8115;
        Tue, 12 Sep 2023 09:50:17 -0700 (PDT)
Received: from [192.168.0.106] (unknown [186.235.7.101])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 61A08660716C;
        Tue, 12 Sep 2023 17:50:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694537415;
        bh=b3Pjb5sxufyfJz4YTfjIpaTwu6GqQK/gK7r+UI5k7ik=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IC9XweikCd8wdErjDdbQJM9Njzz31wFTIAhGgOAzdnnoYQbU1AUs+Pa5veanwx2A0
         gLLM2cy4TlTjTQk7gPqHVr6yclTb2wKyv/uos04WCaDGVZDGRIkGwx5wseNTvXb5ta
         bvOUi9N3zM8Pn0T66BaMTWLsVvPk3gqqS5hoRlbWBnRoIJ4B4UHtVFQ2S8TUqo5NWC
         3gwc4F9mg1yp5NZ1QSLgG0WpgL7XqH0+4f2AWkODos/y7qgBvM/L51HdqtIydeqjP7
         r8Y/i0H2Ups3oRZm3knp/sGrKMJEf/RoyLdD4Ct38HA6vceS+yqCVNzuerEg0an/Db
         Dz8ha0wHIjCjg==
Message-ID: <113c0ae6-d7f1-b4d5-dc1a-2264cc815644@collabora.com>
Date:   Tue, 12 Sep 2023 13:50:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 1/9] drm: ci: igt_runner: Remove todo
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
 <20230908152225.432139-2-vignesh.raman@collabora.com>
Content-Language: en-US
From:   Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20230908152225.432139-2-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/09/2023 12:22, Vignesh Raman wrote:
> /sys/kernel/debug/dri/*/state exist for every atomic KMS driver.
> We do not test non-atomic drivers, so remove the todo.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>

Acked-by: Helen Koike <helen.koike@collabora.com>

> ---
> 
> v2:
>    - No changes
> 
> v3:
>    - No changes
>    
> ---
>   drivers/gpu/drm/ci/igt_runner.sh | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_runner.sh
> index 2bb759165063..5bf130ac57c9 100755
> --- a/drivers/gpu/drm/ci/igt_runner.sh
> +++ b/drivers/gpu/drm/ci/igt_runner.sh
> @@ -15,7 +15,6 @@ cat /sys/kernel/debug/device_component/*
>   '
>   
>   # Dump drm state to confirm that kernel was able to find a connected display:
> -# TODO this path might not exist for all drivers.. maybe run modetest instead?
>   set +e
>   cat /sys/kernel/debug/dri/*/state
>   set -e
