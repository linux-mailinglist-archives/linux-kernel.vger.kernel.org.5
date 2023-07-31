Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F39A769D02
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjGaQnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjGaQm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:42:56 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F461721
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:42:48 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9cdbf682eso50391631fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690821767; x=1691426567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n51bPqc2FOBF1O8Pkof/cmIv3X6J8j8NcKC/rdlzbnc=;
        b=UCCLI6lYVK5fuTzhHD3N56NIKzLuA01wA85/5Q8I4Ub0cr6qqgsAAtXdP7f7Xmp0Jd
         sQK6/5iKpNoPUmH2oef4zU5tjExKgHDB6YwchfmARkClFn0UBmLD3K5CLjzLWBrb9neu
         EEsI5iD6t5rVTNISfrLokXvSTd0A8Iy2FXD434yebYtUal5CQrpQWkdWm70L6iRcdLRX
         mJAfDVrbkpJsG7hGv53EZbMuQv2+hDOhOnp9iHLuE2Xajm0WJOGUQMtBwlEuYp2Be1EZ
         bAMT9QbaPgLqoKzaYlngIi++D964Yi0YXjACBk+l8mXsLb1n9d94aYZ8Kme5PTstL40o
         HSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690821767; x=1691426567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n51bPqc2FOBF1O8Pkof/cmIv3X6J8j8NcKC/rdlzbnc=;
        b=Hs7/cDZ7T3Lu12mI80HN2PRfjTHHJZ0toBaT3qU0nq8B6tNzwPxEf90IM99rggcDUp
         a/Lymc0MXWWKpltSJRDZLfAjLFGB3vTlIgEBeuOCufHZJKDGGbc8ERmoCnp2l9FHE9pf
         E5/eB45QztkuIWy1qVpHcV9+HS98zIzZb3yfjRU5rMuUxv4FSeJQPbApWmrr1ctLnenB
         mZcuLUGa3cY6fI0ZLN4nGBRjdgneaD9XbAnfFgdsHwBIkovtQKbpx4okX1Fu1Hmog5vb
         iVffGqhn4aiSq+W4iAVcexMbJDxRcutLd83WyESeRRJeG/bzlNfG9kstziCktQFx8gaO
         imAQ==
X-Gm-Message-State: ABy/qLa91z8zgKr84IFrpfYmn9VkXGsD4ACVKy3I3Ies1ejkuYyHtln8
        ArSob5/JK50voj8EccTU9MCM2Q/SLlRWj85Hd5I=
X-Google-Smtp-Source: APBJJlGnlmc0CiNX0uQgMywmw8gDWUm9ZXVzpNexqQqWwE6fS3vBXiSmuhs0v1sT3xheNqqp6aCo5A==
X-Received: by 2002:a2e:7e04:0:b0:2b6:d576:a25b with SMTP id z4-20020a2e7e04000000b002b6d576a25bmr376516ljc.28.1690821767059;
        Mon, 31 Jul 2023 09:42:47 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id k15-20020a2e240f000000b002b70a8478ddsm2629932ljk.44.2023.07.31.09.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 09:42:46 -0700 (PDT)
Message-ID: <c68358a7-ee21-2d0a-71ab-cd1f9a3e1afe@linaro.org>
Date:   Mon, 31 Jul 2023 19:42:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/14] A7xx support
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230628-topic-a7xx_drmmsm-v1-0-a7f4496e0c12@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230628-topic-a7xx_drmmsm-v1-0-a7f4496e0c12@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2023 23:35, Konrad Dybcio wrote:
> This series attempts to introduce Adreno 700 support (with A730 and A740
> found on SM8450 and SM8550 respectively), reusing much of the existing
> A6xx code. This submission largely lays the groundwork for expansion and
> more or less gives us feature parity (on the kernel side, that is) with
> existing A6xx parts.
> 
> On top of introducing a very messy set of three (!) separate and
> obfuscated deivce identifiers for each 7xx part, this generation
> introduces very sophisticated hardware multi-threading and (on some SKUs)
> hardware ray-tracing (not supported yet).
> 
> After this series, a long-overdue cleanup of drm/msm/adreno is planned
> in preparation for adding more features and removing some hardcoding.
> 
> The last patch is a hack that may or may not be necessary depending
> on your board's humour.. eh.. :/
> 
> Developed atop (and hence depends on) [1]
> 
> The corresponding devicetree patches are initially available at [2] and
> will be posted after this series gets merged. To test it, you'll also need
> firmware that you need to obtain from your board (there's none with a
> redistributable license, sorry..). Most likely it will be in one of
> these directories on your stock android installation:
> 
> * /vendor/firmware
> * /vendor/firmware_mnt
> * /system
> 
> ..but some vendors make it hard and you have to do some grepping ;)
> 
> Requires [3] to work on the userspace side. You'll almost cerainly want
> to test it alongside Zink with a lot of debug flags (early impl), like:
> 
> TU_DEBUG=sysmem,nolrz,flushall,noubwc MESA_LOADER_DRIVER_OVERRIDE=zink kmscube
> 
> [1] https://lore.kernel.org/linux-arm-msm/20230517-topic-a7xx_prep-v4-0-b16f273a91d4@linaro.org/
> [2] https://github.com/SoMainline/linux/commits/topic/a7xx_dt
> [3] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/23217
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Konrad Dybcio (14):
>        dt-bindings: display/msm/gmu: Add Adreno 7[34]0 GMU
>        dt-bindings: display/msm/gmu: Allow passing QMP handle
>        dt-bindings: display/msm/gpu: Allow A7xx SKUs
>        drm/msm/a6xx: Add missing regs for A7XX
>        drm/msm/a6xx: Introduce a6xx_llc_read
>        drm/msm/a6xx: Move LLC accessors to the common header
>        drm/msm/a6xx: Bail out early if setting GPU OOB fails
>        drm/msm/a6xx: Add skeleton A7xx support
>        drm/msm/a6xx: Send ACD state to QMP at GMU resume
>        drm/msm/a6xx: Mostly implement A7xx gpu_state
>        drm/msm/a6xx: Add A730 support
>        drm/msm/a6xx: Add A740 support
>        drm/msm/a6xx: Vastly increase HFI timeout
>        [RFC] drm/msm/a6xx: Poll for GBIF unhalt status in hw_init
> 
>   .../devicetree/bindings/display/msm/gmu.yaml       |  47 +-
>   .../devicetree/bindings/display/msm/gpu.yaml       |   4 +-
>   drivers/gpu/drm/msm/adreno/a6xx.xml.h              |   9 +
>   drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 188 ++++--
>   drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |   3 +
>   drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h          |   8 +
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c              | 658 ++++++++++++++++++---
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |  15 +
>   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c        |  52 +-
>   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |  61 +-
>   drivers/gpu/drm/msm/adreno/a6xx_hfi.c              |  90 ++-
>   drivers/gpu/drm/msm/adreno/adreno_device.c         |  26 +
>   drivers/gpu/drm/msm/adreno/adreno_gpu.c            |   7 +-
>   drivers/gpu/drm/msm/adreno/adreno_gpu.h            |  24 +-
>   drivers/gpu/drm/msm/msm_ringbuffer.h               |   2 +
>   15 files changed, 1070 insertions(+), 124 deletions(-)
> ---
> base-commit: 6f9b660e9cbb30669fcfec83288d527c0844717d
> change-id: 20230628-topic-a7xx_drmmsm-123f30d76cf7

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # sm8450

-- 
With best wishes
Dmitry

