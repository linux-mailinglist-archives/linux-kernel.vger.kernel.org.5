Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3630E776BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjHIWIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjHIWId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:08:33 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D23B9;
        Wed,  9 Aug 2023 15:08:32 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so340252e87.3;
        Wed, 09 Aug 2023 15:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691618910; x=1692223710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHUgxVkqPfvJcpFnmASPtTtiWfAEUFEf5591PAmgwtU=;
        b=otZY1vS90mHUsvPz8IrtugIg5QTo1OpPKJNGpraZXaMZ8v82qd9vfoBqfMuq6giujN
         GjK/PP3fiT3D3rCe45IEhrzQw4jeg7bTHqUvj65o7HfXs6fQaABae/aJ2sGy8g4bAbTf
         7fFHPnlUoLj5hJAMDkgixaSNq1BrkhXEpIqa3p9toiREAFbpenjcL9y7neXqBlKqt1Tw
         3xJEpfQFkfCJJNzbOFuw51g9JLJGlyX1Jg/jTbV/EgwA+3/+rhbj30wyRcTfvOYUmgL/
         qJPovVVU195Crf3dXI4Hm0EtQsS5wl1DbDRVa1YVCIO297S82dvNpr0MWr/NPKbIcfnT
         4gqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691618910; x=1692223710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHUgxVkqPfvJcpFnmASPtTtiWfAEUFEf5591PAmgwtU=;
        b=bnN0dD6WAbCSTo09O/8AGUuEJAuVfNR9JRhI4HUSLs0PHFIaNBRy/aQ3FMjnv87I/H
         ZdxGx30KP3gRwB3YQMb7YxhIUKFoCjrSTE6wZ+f1/i3pfBHl+xRJZ+wG3OVtgjyHTbnh
         FduZ5t/pKGzfgH9Mmq6blbg2sR9UChf3v+2fLjeSNs43jUTpW71Awcr8d5zHNwKXlVNC
         EzHnI0OVwYQF4u2Oe2aExICEPzBC8ZnH0gEUos0AEGe4EmjhjWiAdSNAVPH+Wj+pvWqU
         jHDStkbXr8K8vponqPbZO1QO9zW5oexwwn0OdiAvU4ZeHAzRrEbuDGgN1W51P4DeDbnA
         71UA==
X-Gm-Message-State: AOJu0YwH/NNe9dOVzQm1smOegfsP7XIJOlhKDLok0rnVoeZo+wd7WBYw
        0d14R95tNpvRJXr0aaODELIVVOxKt/CRdk+bQug=
X-Google-Smtp-Source: AGHT+IH2b8kGczwJAoBo0Ln7jT0JTZMlZ2Z6w3uTsJYmieQUqA/VkAOaqXy5yXCemw3g99vGQCU3jel+VmIM5J7Ti+c=
X-Received: by 2002:ac2:5f5b:0:b0:4fe:5a4b:911d with SMTP id
 27-20020ac25f5b000000b004fe5a4b911dmr317491lfz.64.1691618910125; Wed, 09 Aug
 2023 15:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230628-topic-a7xx_drmmsm-v2-0-1439e1b2343f@linaro.org>
In-Reply-To: <20230628-topic-a7xx_drmmsm-v2-0-1439e1b2343f@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 9 Aug 2023 15:08:18 -0700
Message-ID: <CAF6AEGuDK7DAu_0_6nDkkv0FNkY6rxrdtp3sJB_WviH-whWuDA@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] A7xx support
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 2:02=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linaro.=
org> wrote:
>
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

tbf most of this para above is describing choices kgsl made, and not
really relevant upstream.. really the only thing that matters for the
upstream kernel is that chip-id becomes "just a number" ;-)

If you want to mention why we align chip-id with kgsl, it is (a) mesa
needs to deal with both upstream and kgsl, and (b) future things we'll
read this from hw/fw

BR,
-R

> After this series, a long-overdue cleanup of drm/msm/adreno is planned
> in preparation for adding more features and removing some hardcoding.
>
> The last patch is a hack that may or may not be necessary depending
> on your board's humour.. eh.. :/
>
> Developed atop (and hence depends on) [1]
>
> The corresponding devicetree patches are initially available at [2] and
> will be posted after this series gets merged. To test it, you'll also nee=
d
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
> TU_DEBUG=3Dsysmem,nolrz,flushall,noubwc MESA_LOADER_DRIVER_OVERRIDE=3Dzin=
k kmscube
>
> [1] https://lore.kernel.org/linux-arm-msm/20230517-topic-a7xx_prep-v4-0-b=
16f273a91d4@linaro.org/
> [2] https://github.com/SoMainline/linux/commits/topic/a7xx_dt
> [3] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/23217
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Changes in v2:
> - Rebase on chipid changes
> - Reuse existing description for qcom,aoss in patch 2
> - Pick up tags
> - Link to v1: https://lore.kernel.org/r/20230628-topic-a7xx_drmmsm-v1-0-a=
7f4496e0c12@linaro.org
>
> ---
> Konrad Dybcio (14):
>       dt-bindings: display/msm/gmu: Add Adreno 7[34]0 GMU
>       dt-bindings: display/msm/gmu: Allow passing QMP handle
>       dt-bindings: display/msm/gpu: Allow A7xx SKUs
>       drm/msm/a6xx: Add missing regs for A7XX
>       drm/msm/a6xx: Introduce a6xx_llc_read
>       drm/msm/a6xx: Move LLC accessors to the common header
>       drm/msm/a6xx: Bail out early if setting GPU OOB fails
>       drm/msm/a6xx: Add skeleton A7xx support
>       drm/msm/a6xx: Send ACD state to QMP at GMU resume
>       drm/msm/a6xx: Mostly implement A7xx gpu_state
>       drm/msm/a6xx: Add A730 support
>       drm/msm/a6xx: Add A740 support
>       drm/msm/a6xx: Vastly increase HFI timeout
>       drm/msm/a6xx: Poll for GBIF unhalt status in hw_init
>
>  .../devicetree/bindings/display/msm/gmu.yaml       |  47 +-
>  .../devicetree/bindings/display/msm/gpu.yaml       |   4 +-
>  drivers/gpu/drm/msm/adreno/a6xx.xml.h              |   9 +
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 204 +++++--
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |   3 +
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h          |   8 +
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c              | 667 +++++++++++++++=
+++---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |  15 +
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c        |  52 +-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |  61 +-
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c              |  90 ++-
>  drivers/gpu/drm/msm/adreno/adreno_device.c         |  30 +
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c            |   7 +-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h            |  28 +-
>  drivers/gpu/drm/msm/msm_ringbuffer.h               |   2 +
>  15 files changed, 1094 insertions(+), 133 deletions(-)
> ---
> base-commit: b30de2c05cf2166f4e2c68850efc8dcea1c89780
> change-id: 20230628-topic-a7xx_drmmsm-123f30d76cf7
>
> Best regards,
> --
> Konrad Dybcio <konrad.dybcio@linaro.org>
>
