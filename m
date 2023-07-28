Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D7E766FA3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbjG1Ok7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237171AbjG1Ok5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:40:57 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8085E3C29
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:40:55 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d08658c7713so2062707276.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690555254; x=1691160054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sERIbIsoa27U7tLUKzRHxHjjan6MTrTpQeERoAPEVqw=;
        b=ii8/gXRyTwbuFGCUlX210GU0DE8pNLjcjn3vjwPaFv9KdrBca8eikdAmXuN+GY0jc9
         QPBV4slFT2RcfRIwhALDMSqVbYE92SF6Q6MUExW3Dq7JmLMesRqZZP1AeZ5yI/6HBIQn
         +ww//XKWiEL/ZtJGDG3Xbt8+DVu5l03INnKV0kykLt1H7AON7GSsqnRDUqU0TBDDCTFQ
         8nlCxfMdDkmCvrOn1T6wUCoTOSRVYGxYdTbPJjX1NETQTTdY61+QF0eTOa+cay7WwXSa
         ja/+PnAHGWb1n4SehoMjvnT3wrKk/GZfSs6jfXQFfjX4Wk6awwr5kEoe+PDI9uv9BHUx
         X0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690555254; x=1691160054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sERIbIsoa27U7tLUKzRHxHjjan6MTrTpQeERoAPEVqw=;
        b=FVIsoBRN/OR4oeJWww8jG1Af0g11cG/PhnF+E/Xpe1suP7P/jNs07ZmqH4BLWvRLku
         kK0WyaKwOEMXoZcRolzRdbbzOc1S1z/InDWvjfPBPfGXZGty++OqbLBrVWobMdAeTbjN
         x1wm/d31E2JBtlHPZIUCOtgnfejJ3+QO3UkTbsFClAnP659xhNgVEnwCfDnH8Lu+j33B
         Cytspqc//KwJI0XqEpRlpoxptRiPTEh0YjshQ6FqJxFgPcuuYYPpW612xCZk9EA2XJrT
         TDxsH2xuKhH0fFqPGPTdog45C021hMdXdhb1oi3ovXMNWLyq2qTDxSo+JpB16MAZ1ihe
         NwZg==
X-Gm-Message-State: ABy/qLbcoNYGXWrXnNgOOd1t6wB/fAcTjlrsLxKh3hRq6xp5IWjYEpM7
        S5ht4cLIv2SB0Hix2gfhot19i/3fHd59yE6ImJ/2hQ==
X-Google-Smtp-Source: APBJJlFlCqhvIbqLQ8v5jXOX7eba+Y3bAB4ZHk7FZyJJxQQ+oWIHj2gevaS3HagVnPpyZL9SH3T55xc+twhIh8HL0sA=
X-Received: by 2002:a25:455:0:b0:cad:347e:2c8f with SMTP id
 82-20020a250455000000b00cad347e2c8fmr1922407ybe.39.1690555254663; Fri, 28 Jul
 2023 07:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com> <1690550624-14642-34-git-send-email-quic_vgarodia@quicinc.com>
In-Reply-To: <1690550624-14642-34-git-send-email-quic_vgarodia@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 28 Jul 2023 17:40:43 +0300
Message-ID: <CAA8EJpoDrhBtU=xyFEeuUwWnpvG8mjGQRY_T0jZ-9UmvmSZH+A@mail.gmail.com>
Subject: Re: [PATCH 33/33] iris: enable building of iris video driver
To:     Vikash Garodia <quic_vgarodia@quicinc.com>
Cc:     stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_dikshita@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 at 17:28, Vikash Garodia <quic_vgarodia@quicinc.com> wrote:
>
> From: Dikshita Agarwal <quic_dikshita@quicinc.com>
>
> This adds iris driver Makefile and Kconfig, also changes
> v4l2 platform/qcom Makefile/Kconfig in order to
> enable compilation of the driver.
>
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>  drivers/media/platform/qcom/Kconfig       |  1 +
>  drivers/media/platform/qcom/Makefile      |  1 +
>  drivers/media/platform/qcom/iris/Kconfig  | 15 ++++++++++
>  drivers/media/platform/qcom/iris/Makefile | 46 +++++++++++++++++++++++++++++++
>  4 files changed, 63 insertions(+)
>  create mode 100644 drivers/media/platform/qcom/iris/Kconfig
>  create mode 100644 drivers/media/platform/qcom/iris/Makefile
>
> diff --git a/drivers/media/platform/qcom/Kconfig b/drivers/media/platform/qcom/Kconfig
> index cc5799b..b86bebd 100644
> --- a/drivers/media/platform/qcom/Kconfig
> +++ b/drivers/media/platform/qcom/Kconfig
> @@ -4,3 +4,4 @@ comment "Qualcomm media platform drivers"
>
>  source "drivers/media/platform/qcom/camss/Kconfig"
>  source "drivers/media/platform/qcom/venus/Kconfig"
> +source "drivers/media/platform/qcom/iris/Kconfig"
> diff --git a/drivers/media/platform/qcom/Makefile b/drivers/media/platform/qcom/Makefile
> index 4f055c3..83eea29 100644
> --- a/drivers/media/platform/qcom/Makefile
> +++ b/drivers/media/platform/qcom/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-y += camss/
>  obj-y += venus/
> +obj-y += iris/
> diff --git a/drivers/media/platform/qcom/iris/Kconfig b/drivers/media/platform/qcom/iris/Kconfig
> new file mode 100644
> index 0000000..d434c31
> --- /dev/null
> +++ b/drivers/media/platform/qcom/iris/Kconfig
> @@ -0,0 +1,15 @@
> +config VIDEO_QCOM_IRIS
> +       tristate "Qualcomm Iris V4L2 encoder/decoder driver"
> +       depends on V4L_MEM2MEM_DRIVERS
> +       depends on VIDEO_DEV && QCOM_SMEM
> +       depends on (ARCH_QCOM && IOMMU_DMA) || COMPILE_TEST
> +       select QCOM_MDT_LOADER if ARCH_QCOM
> +       select QCOM_SCM
> +       select VIDEOBUF2_DMA_CONTIG
> +       select V4L2_MEM2MEM_DEV
> +       select DMABUF_HEAPS
> +       help
> +         This is a V4L2 driver for Qualcomm Iris video accelerator
> +         hardware. It accelerates encoding and decoding operations
> +         on various Qualcomm SoCs.
> +         To compile this driver as a module choose m here.
> diff --git a/drivers/media/platform/qcom/iris/Makefile b/drivers/media/platform/qcom/iris/Makefile
> new file mode 100644
> index 0000000..e681c4f
> --- /dev/null
> +++ b/drivers/media/platform/qcom/iris/Makefile
> @@ -0,0 +1,46 @@
> +KBUILD_OPTIONS+= VIDEO_ROOT=$(KERNEL_SRC)/$(M)
> +
> +VIDEO_COMPILE_TIME = $(shell date)
> +VIDEO_COMPILE_BY = $(shell whoami | sed 's/\\/\\\\/')
> +VIDEO_COMPILE_HOST = $(shell uname -n)
> +VIDEO_GEN_PATH = $(srctree)/$(src)/vidc/inc/video_generated_h
> +
> +$(shell echo '#define VIDEO_COMPILE_TIME "$(VIDEO_COMPILE_TIME)"' > $(VIDEO_GEN_PATH))
> +$(shell echo '#define VIDEO_COMPILE_BY "$(VIDEO_COMPILE_BY)"' >> $(VIDEO_GEN_PATH))
> +$(shell echo '#define VIDEO_COMPILE_HOST "$(VIDEO_COMPILE_HOST)"' >> $(VIDEO_GEN_PATH))

Why do you need this at all?

> +
> +iris-objs += vidc/src/msm_vidc_v4l2.o \
> +                  vidc/src/msm_vidc_vb2.o \
> +                  vidc/src/msm_vidc.o \
> +                  vidc/src/msm_vdec.o \
> +                  vidc/src/msm_venc.o \
> +                  vidc/src/msm_vidc_driver.o \
> +                  vidc/src/msm_vidc_control.o \
> +                  vidc/src/msm_vidc_buffer.o \
> +                  vidc/src/msm_vidc_power.o \
> +                  vidc/src/msm_vidc_probe.o \
> +                  vidc/src/resources.o \
> +                  vidc/src/firmware.o \
> +                  vidc/src/msm_vidc_debug.o \
> +                  vidc/src/msm_vidc_memory.o \
> +                  vidc/src/venus_hfi.o \
> +                  vidc/src/venus_hfi_queue.o \
> +                  vidc/src/hfi_packet.o \
> +                  vidc/src/venus_hfi_response.o \
> +                  vidc/src/msm_vidc_state.o \
> +                  platform/common/src/msm_vidc_platform.o \
> +                  platform/sm8550/src/msm_vidc_sm8550.o \
> +                  variant/common/src/msm_vidc_variant.o \
> +                  variant/iris3/src/msm_vidc_buffer_iris3.o \
> +                  variant/iris3/src/msm_vidc_iris3.o \
> +                  variant/iris3/src/msm_vidc_power_iris3.o \
> +                  variant/iris3/src/msm_vidc_bus_iris3.o \
> +                  variant/iris3/src/msm_vidc_clock_iris3.o
> +
> +obj-$(CONFIG_VIDEO_QCOM_IRIS) += iris.o
> +
> +ccflags-y += -I$(srctree)/$(src)/vidc/inc
> +ccflags-y += -I$(srctree)/$(src)/platform/common/inc
> +ccflags-y += -I$(srctree)/$(src)/platform/sm8550/inc
> +ccflags-y += -I$(srctree)/$(src)/variant/common/inc
> +ccflags-y += -I$(srctree)/$(src)/variant/iris3/inc

For me this is a sign of the bad structure of the include files.
Please define proper interfaces between submodules. The parts of the
driver usually should include files from the top-level dir only (and
from the local subdirectory of course).

> --
> 2.7.4
>


-- 
With best wishes
Dmitry
