Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFDE76E390
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbjHCIsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbjHCIsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:48:09 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA50FDA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:48:06 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe463420fbso1180534e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 01:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691052485; x=1691657285;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2/hdxh3xj6iR4Yykv7Dt+Q7h/174Nys/IxjYgXNUnVA=;
        b=raY2Go5vuMFc5/QctA0YSLUQfciPAf69VmtKHUgoDQgoDMgllytied97OkQyodbuFH
         WnuF5FtIu+mEvtDjgQOII/EPcaYPFO+DIpEIoOQf+tPB4ELKZK3KRffieZB7STmoID9J
         oaAobXQhjz3bhLHfh940OTRpowIEG1A9uUutgFIG60UoB3AYaijRERQ5si6ATqcz6yWY
         RLfxHfMladH/225xS2vBh/cuwkn00q5AJ5d7Cp64ZG6eZm2Dpdin76rBw22afBUFLqSQ
         myp8Dhf7pQbaRNjh24Se+Z/Kogxgeh0FFHSeEzuWatwJ1ngDyFlFx7JrD9fNO2dV4q29
         yfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691052485; x=1691657285;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/hdxh3xj6iR4Yykv7Dt+Q7h/174Nys/IxjYgXNUnVA=;
        b=Ir9mswMtTgmJ0yqdOelDPgPBF3PsXX/+dD+phZrvCr2JtyQvnojJClZ6z9VZbbctf4
         Ie2E2MbYwxyV53izO/G91UIs35fQUYOiY9j9st7ssLnG7bJnlCmLqUK3qOk9qvUFaTo3
         KZ4JdebLen81AJquAzAGQzfT77VTY/DFe2spYPYP5xmiD9sP6Mtj5Ec60LllrZMMJ7QS
         +x1OGf1lFLjrC6fiSLDOt28rpGprVDbHgXNCsPQdtFCID1lKBI3R75ljtSkdvWZ9ED82
         E5P4ZyPKSullBjZ9PMTn5K0aiDTNAi8utXCIe/b+hOznb+QWmi//lBNMXY4AGWeaePBL
         PQtA==
X-Gm-Message-State: ABy/qLaTDNVb6F8W7nZL8dCxFpYLEllAlxIsS/Caqb3th+hBboULYxyX
        mDKk6JuAy1Uwj6jzp+LlU3BvWQ==
X-Google-Smtp-Source: APBJJlG1TSXmbhUXV6vd3PGIBBYcghGyWllyDz062a86gUJzBx9qMnh2oD2yAfzL++WwiCd4hkhqKw==
X-Received: by 2002:ac2:518a:0:b0:4fb:9497:b2a5 with SMTP id u10-20020ac2518a000000b004fb9497b2a5mr5653512lfi.21.1691052485036;
        Thu, 03 Aug 2023 01:48:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8656:583:d034:d966? ([2a01:e0a:982:cbb0:8656:583:d034:d966])
        by smtp.gmail.com with ESMTPSA id i17-20020a5d55d1000000b003143be36d99sm21265332wrw.58.2023.08.03.01.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 01:48:04 -0700 (PDT)
Message-ID: <5aab1846-5d3c-7010-56ca-556db1f74e92@linaro.org>
Date:   Thu, 3 Aug 2023 10:48:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 00/14] A7xx support
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230628-topic-a7xx_drmmsm-v1-0-a7f4496e0c12@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2023 22:35, Konrad Dybcio wrote:
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
> 
> Best regards,

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
