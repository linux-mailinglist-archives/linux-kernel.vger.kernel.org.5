Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD64C76F440
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjHCUvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjHCUvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:51:11 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1A911F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 13:51:08 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d075a831636so1618519276.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 13:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691095868; x=1691700668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lle3BF+qljfXzm4QfhcLwY60F8Zaf6zozvJKdONuFT8=;
        b=My6Rkj04n6n6T06NCr2vgPgVcqH4THV2yLBKdOugWmZ4SEAxuoGZ3BKRP6qfIUIcVU
         gK15I84PqvbU8iL1uLBnFzoM4PelaWNZm6CaJMTtYyij3dYzQrP/GfqX9DtOF3uLA8Zk
         qrf7ZCJInxy0Itoe2nA49o7LmlifbdCKt9/6vtP3EUpaJ0wUP2aaxtk3GCzyJ1SS6cjs
         llSosyIdiqqjiDJS3jsNHSqTyEu0zFAbOB7Fb9OYyP51JzQ+oItqhKMmVWdPCu651oD2
         +K1gtgCBNB7AvrGycyQO2iA1IOZcd0zeY0IgKCH9XhFPNQrOit3XiJm0HwBQQG+MgkBU
         Sosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691095868; x=1691700668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lle3BF+qljfXzm4QfhcLwY60F8Zaf6zozvJKdONuFT8=;
        b=WEPfVUAAumSX2ZvKIrR1lhFgxvNbSsnI0OfsGcXSNprThi1VRh7MbMl4ySqjU6vnhf
         BAvF9A8ceD+5NVLxJwQUuu12nhVZ+tpfecVuwpFaArcFixvG+2emgV125ytPPerD6/+v
         DGHHVG95oe3TdG1rwXuHlFpb3ktS+ljXuADNlVdrogVl8GSR3DO7X//a6hg21gJ2Ij2t
         m6cZqvo9mF7BGvZ4pdkA3n1u79cIN+2PxPGr39+g2tdM4dyxbdH9axrZtdEBkcT+1qlx
         3q1JCCSLdQsN8ER6aqcZoymQNDxoSsdegsvYQVNOX9O5q0sWz/M0V64sRaeYWpsz+3PC
         AlGw==
X-Gm-Message-State: ABy/qLbYOhdZIN0hJv26WYctiuHhWQHQlYVrY8d5zkuc+vyO5JO5s1Dq
        P3RalvD03kP9OQHkmxWtPHv90SPnXBdt1MoqYbpgpA==
X-Google-Smtp-Source: APBJJlFAwqPxGuWnAbWFsKaxQB3e6si3AlKys7bn9vfTjD+Wsshf717lNeNSUAwOCQHBVn1zoq+6xKnDErOGMltFAgU=
X-Received: by 2002:a25:e653:0:b0:c14:68fd:6e30 with SMTP id
 d80-20020a25e653000000b00c1468fd6e30mr17517773ybh.16.1691095867957; Thu, 03
 Aug 2023 13:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230803194724.154591-1-danila@jiaxyga.com> <20230803194724.154591-3-danila@jiaxyga.com>
In-Reply-To: <20230803194724.154591-3-danila@jiaxyga.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 3 Aug 2023 23:50:57 +0300
Message-ID: <CAA8EJpoBZBLYQ5RUW7nGo+wsma2XiON9+rK8N-gjnfWTkb-7rA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/msm/dpu: Add SM7150 support
To:     Danila Tikhonov <danila@jiaxyga.com>
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        neil.armstrong@linaro.org, rfoss@kernel.org, andersson@kernel.org,
        quic_khsieh@quicinc.com, quic_vpolimer@quicinc.com,
        quic_rmccann@quicinc.com, quic_jesszhan@quicinc.com,
        liushixin2@huawei.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        davidwronek@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2023 at 22:47, Danila Tikhonov <danila@jiaxyga.com> wrote:
>
> Add definitions for the display hardware used on the Qualcomm SM7150
> platform.
>
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  .../msm/disp/dpu1/catalog/dpu_5_2_sm7150.h    | 277 ++++++++++++++++++
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    |   1 +
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |   1 +
>  4 files changed, 280 insertions(+)
>  create mode 100644 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h
> new file mode 100644
> index 000000000000..5823879a705a
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h
> @@ -0,0 +1,277 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023, Danila Tikhonov <danila@jiaxyga.com>
> + */
> +
> +#ifndef _DPU_5_2_SM7150_H
> +#define _DPU_5_2_SM7150_H
> +
> +static const struct dpu_caps sm7150_dpu_caps = {
> +       .max_mixer_width = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
> +       .max_mixer_blendstages = 0xb,
> +       .qseed_type = DPU_SSPP_SCALER_QSEED4,

v3lite

> +       .has_src_split = true,
> +       .has_dim_layer = true,
> +       .has_idle_pc = true,
> +       .has_3d_merge = true,
> +       .max_linewidth = 4096,

2880 according to the vendor DTS file.

> +       .pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
> +       .max_hdeci_exp = MAX_HORZ_DECIMATION,
> +       .max_vdeci_exp = MAX_VERT_DECIMATION,
> +};
> +
> +static const struct dpu_mdp_cfg sm7150_mdp[] = {
> +       {
> +       .name = "top_0",
> +       .base = 0x0, .len = 0x45c,
> +       .features = BIT(DPU_MDP_AUDIO_SELECT),
> +       .clk_ctrls[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0 },
> +       .clk_ctrls[DPU_CLK_CTRL_VIG1] = { .reg_off = 0x2b4, .bit_off = 0 },
> +       .clk_ctrls[DPU_CLK_CTRL_DMA0] = { .reg_off = 0x2ac, .bit_off = 8 },
> +       .clk_ctrls[DPU_CLK_CTRL_DMA1] = { .reg_off = 0x2b4, .bit_off = 8 },
> +       .clk_ctrls[DPU_CLK_CTRL_DMA2] = { .reg_off = 0x2bc, .bit_off = 8 },
> +       .clk_ctrls[DPU_CLK_CTRL_WB2] = { .reg_off = 0x3b8, .bit_off = 24 },
> +       },
> +};
> +
> +static const struct dpu_sspp_cfg sm7150_sspp[] = {
> +       {
> +               .name = "sspp_0", .id = SSPP_VIG0,
> +               .base = 0x4000, .len = 0x1f0,
> +               .features = VIG_SDM845_MASK,
> +               .sblk = &sm8250_vig_sblk_0,
> +               .xin_id = 0,
> +               .type = SSPP_TYPE_VIG,
> +               .clk_ctrl = DPU_CLK_CTRL_VIG0,
> +       }, {
> +               .name = "sspp_1", .id = SSPP_VIG1,
> +               .base = 0x6000, .len = 0x1f0,
> +               .features = VIG_SDM845_MASK,
> +               .sblk = &sm8250_vig_sblk_1,
> +               .xin_id = 4,
> +               .type = SSPP_TYPE_VIG,
> +               .clk_ctrl = DPU_CLK_CTRL_VIG1,
> +       }, {
> +               .name = "sspp_2", .id = SSPP_DMA0,
> +               .base = 0x24000, .len = 0x1f0,
> +               .features = DMA_SDM845_MASK,
> +               .sblk = &sdm845_dma_sblk_0,
> +               .xin_id = 1,
> +               .type = SSPP_TYPE_DMA,
> +               .clk_ctrl = DPU_CLK_CTRL_DMA0,
> +       }, {
> +               .name = "sspp_9", .id = SSPP_DMA1,
> +               .base = 0x26000, .len = 0x1f0,
> +               .features = DMA_SDM845_MASK,
> +               .sblk = &sdm845_dma_sblk_1,
> +               .xin_id = 5,
> +               .type = SSPP_TYPE_DMA,
> +               .clk_ctrl = DPU_CLK_CTRL_DMA1,
> +       }, {
> +               .name = "sspp_10", .id = SSPP_DMA2,
> +               .base = 0x28000, .len = 0x1f0,
> +               .features = DMA_CURSOR_SDM845_MASK,
> +               .sblk = &sdm845_dma_sblk_2,
> +               .xin_id = 9,
> +               .type = SSPP_TYPE_DMA,
> +               .clk_ctrl = DPU_CLK_CTRL_DMA2,
> +       },
> +};
> +
> +static const struct dpu_lm_cfg sm7150_lm[] = {
> +       {
> +               .name = "lm_0", .id = LM_0,
> +               .base = 0x44000, .len = 0x320,
> +               .features = MIXER_SDM845_MASK,
> +               .sblk = &sdm845_lm_sblk,
> +               .lm_pair = LM_1,
> +               .pingpong = PINGPONG_0,
> +               .dspp = DSPP_0,
> +       }, {
> +               .name = "lm_1", .id = LM_1,
> +               .base = 0x45000, .len = 0x320,
> +               .features = MIXER_SDM845_MASK,
> +               .sblk = &sdm845_lm_sblk,
> +               .lm_pair = LM_0,
> +               .pingpong = PINGPONG_1,
> +               .dspp = DSPP_1,
> +       }, {
> +               .name = "lm_2", .id = LM_2,
> +               .base = 0x46000, .len = 0x320,
> +               .features = MIXER_SDM845_MASK,
> +               .sblk = &sdm845_lm_sblk,
> +               .lm_pair = LM_3,
> +               .pingpong = PINGPONG_2,
> +       }, {
> +               .name = "lm_3", .id = LM_3,
> +               .base = 0x47000, .len = 0x320,
> +               .features = MIXER_SDM845_MASK,
> +               .sblk = &sdm845_lm_sblk,
> +               .lm_pair = LM_2,
> +               .pingpong = PINGPONG_3,
> +       }, {
> +               .name = "lm_4", .id = LM_4,
> +               .base = 0x0, .len = 0x320,
> +               .features = MIXER_SDM845_MASK,
> +               .sblk = &sdm845_lm_sblk,
> +               .lm_pair = 0,
> +               .pingpong = PINGPONG_4,
> +       }, {
> +               .name = "lm_5", .id = LM_5,
> +               .base = 0x0, .len = 0x320,
> +               .features = MIXER_SDM845_MASK,
> +               .sblk = &sdm845_lm_sblk,
> +               .lm_pair = 0,
> +               .pingpong = PINGPONG_5,
> +       },
> +};
> +
> +static const struct dpu_dspp_cfg sm7150_dspp[] = {
> +       {
> +               .name = "dspp_0", .id = DSPP_0,
> +               .base = 0x54000, .len = 0x1800,
> +               .features = DSPP_SC7180_MASK,
> +               .sblk = &sdm845_dspp_sblk,
> +       }, {
> +               .name = "dspp_1", .id = DSPP_1,
> +               .base = 0x56000, .len = 0x1800,
> +               .features = DSPP_SC7180_MASK,
> +               .sblk = &sdm845_dspp_sblk,
> +       },
> +};
> +
> +static const struct dpu_pingpong_cfg sm7150_pp[] = {
> +       {
> +               .name = "pingpong_0", .id = PINGPONG_0,
> +               .base = 0x70000, .len = 0xd4,
> +               .features = PINGPONG_SM8150_MASK,
> +               .sblk = &sdm845_pp_sblk,
> +               .merge_3d = MERGE_3D_0,
> +               .intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
> +               .intr_rdptr = -1,
> +       }, {
> +               .name = "pingpong_1", .id = PINGPONG_1,
> +               .base = 0x70800, .len = 0xd4,
> +               .features = PINGPONG_SM8150_MASK,
> +               .sblk = &sdm845_pp_sblk,
> +               .merge_3d = MERGE_3D_0,
> +               .intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
> +               .intr_rdptr = -1,
> +       }, {
> +               .name = "pingpong_2", .id = PINGPONG_2,
> +               .base = 0x71000, .len = 0xd4,
> +               .features = PINGPONG_SM8150_MASK,
> +               .sblk = &sdm845_pp_sblk,
> +               .merge_3d = MERGE_3D_1,
> +               .intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
> +               .intr_rdptr = -1,
> +       }, {
> +               .name = "pingpong_3", .id = PINGPONG_3,
> +               .base = 0x71800, .len = 0xd4,
> +               .features = PINGPONG_SM8150_MASK,
> +               .sblk = &sdm845_pp_sblk,
> +               .merge_3d = MERGE_3D_1,
> +               .intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
> +               .intr_rdptr = -1,
> +       },
> +};
> +
> +static const struct dpu_merge_3d_cfg sm7150_merge_3d[] = {
> +       {
> +               .name = "merge_3d_0", .id = MERGE_3D_0,
> +               .base = 0x83000, .len = 0x8,
> +       }, {
> +               .name = "merge_3d_1", .id = MERGE_3D_1,
> +               .base = 0x83100, .len = 0x8,
> +       },
> +};
> +
> +static const struct dpu_dsc_cfg sm7150_dsc[] = {
> +       {
> +               .name = "dsc_0", .id = DSC_0,
> +               .base = 0x80000, .len = 0x140,
> +               .features = BIT(DPU_DSC_OUTPUT_CTRL),
> +       }, {
> +               .name = "dsc_1", .id = DSC_1,
> +               .base = 0x80400, .len = 0x140,
> +               .features = BIT(DPU_DSC_OUTPUT_CTRL),
> +       },
> +};
> +
> +static const struct dpu_wb_cfg sm7150_wb[] = {
> +       {
> +               .name = "wb_2", .id = WB_2,
> +               .base = 0x65000, .len = 0x2c8,
> +               .features = WB_SM8250_MASK,
> +               .format_list = wb2_formats,
> +               .num_formats = ARRAY_SIZE(wb2_formats),
> +               .clk_ctrl = DPU_CLK_CTRL_WB2,
> +               .xin_id = 6,
> +               .vbif_idx = VBIF_RT,
> +               .maxlinewidth = 4096,
> +               .intr_wb_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 4),
> +       },
> +};
> +
> +static const struct dpu_perf_cfg sm7150_perf_data = {
> +       .max_bw_low = 7100000,
> +       .max_bw_high = 7100000,
> +       .min_core_ib = 2400000,
> +       .min_llcc_ib = 800000,
> +       .min_dram_ib = 800000,
> +       .min_prefill_lines = 24,
> +       .danger_lut_tbl = {0xff, 0xffff, 0x0},

IIUC, first value should be 0xf

> +       .safe_lut_tbl = {0xfff8, 0xf000, 0xffff},
> +       .qos_lut_tbl = {
> +               {.nentry = ARRAY_SIZE(sm8150_qos_linear),
> +               .entries = sm8150_qos_linear
> +               },
> +               {.nentry = ARRAY_SIZE(sc7180_qos_macrotile),
> +               .entries = sc7180_qos_macrotile
> +               },
> +               {.nentry = ARRAY_SIZE(sc7180_qos_nrt),
> +               .entries = sc7180_qos_nrt
> +               },
> +       },
> +       .cdp_cfg = {
> +               {.rd_enable = 1, .wr_enable = 1},
> +               {.rd_enable = 1, .wr_enable = 0}
> +       },
> +       .clk_inefficiency_factor = 105,
> +       .bw_inefficiency_factor = 120,
> +};
> +
> +static const struct dpu_mdss_version sm7150_mdss_ver = {
> +       .core_major_ver = 5,
> +       .core_minor_ver = 2,
> +};
> +
> +const struct dpu_mdss_cfg dpu_sm7150_cfg = {
> +       .mdss_ver = &sm7150_mdss_ver,
> +       .caps = &sm7150_dpu_caps,
> +       .mdp = sm7150_mdp,
> +       .ctl_count = ARRAY_SIZE(sm8150_ctl),
> +       .ctl = sm8150_ctl,

sm7150_ctl, please add it even if it duplicates sm8150_ctl.

The plan is to review duplication between platforms a few majors
later, when we have more data on SoC similarities and differences.

> +       .sspp_count = ARRAY_SIZE(sm7150_sspp),
> +       .sspp = sm7150_sspp,
> +       .mixer_count = ARRAY_SIZE(sm7150_lm),
> +       .mixer = sm7150_lm,
> +       .dspp_count = ARRAY_SIZE(sm7150_dspp),
> +       .dspp = sm7150_dspp,
> +       .pingpong_count = ARRAY_SIZE(sm7150_pp),
> +       .pingpong = sm7150_pp,
> +       .merge_3d_count = ARRAY_SIZE(sm7150_merge_3d),
> +       .merge_3d = sm7150_merge_3d,
> +       .dsc_count = ARRAY_SIZE(sm7150_dsc),
> +       .dsc = sm7150_dsc,
> +       .intf_count = ARRAY_SIZE(sm8150_intf),
> +       .intf = sm8150_intf,

sm7150_intf. Also, please add it.


> +       .wb_count = ARRAY_SIZE(sm7150_wb),
> +       .wb = sm7150_wb,
> +       .vbif_count = ARRAY_SIZE(sdm845_vbif),
> +       .vbif = sdm845_vbif,
> +       .perf = &sm7150_perf_data,
> +};
> +
> +#endif
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index ce369eeffa7d..fea1253cab0a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -658,6 +658,7 @@ static const struct dpu_qos_lut_entry sc7180_qos_nrt[] = {
>
>  #include "catalog/dpu_5_0_sm8150.h"
>  #include "catalog/dpu_5_1_sc8180x.h"
> +#include "catalog/dpu_5_2_sm7150.h"
>  #include "catalog/dpu_5_4_sm6125.h"
>
>  #include "catalog/dpu_6_0_sm8250.h"
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index 6c9634209e9f..86b354ef45e6 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -833,6 +833,7 @@ extern const struct dpu_mdss_cfg dpu_msm8998_cfg;
>  extern const struct dpu_mdss_cfg dpu_sdm845_cfg;
>  extern const struct dpu_mdss_cfg dpu_sm8150_cfg;
>  extern const struct dpu_mdss_cfg dpu_sc8180x_cfg;
> +extern const struct dpu_mdss_cfg dpu_sm7150_cfg;
>  extern const struct dpu_mdss_cfg dpu_sm8250_cfg;
>  extern const struct dpu_mdss_cfg dpu_sc7180_cfg;
>  extern const struct dpu_mdss_cfg dpu_sm6115_cfg;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index aa6ba2cf4b84..50ec008b7d56 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -1371,6 +1371,7 @@ static const struct of_device_id dpu_dt_match[] = {
>         { .compatible = "qcom,sm6125-dpu", .data = &dpu_sm6125_cfg, },
>         { .compatible = "qcom,sm6350-dpu", .data = &dpu_sm6350_cfg, },
>         { .compatible = "qcom,sm6375-dpu", .data = &dpu_sm6375_cfg, },
> +       { .compatible = "qcom,sm7150-dpu", .data = &dpu_sm7150_cfg, },
>         { .compatible = "qcom,sm8150-dpu", .data = &dpu_sm8150_cfg, },
>         { .compatible = "qcom,sm8250-dpu", .data = &dpu_sm8250_cfg, },
>         { .compatible = "qcom,sm8350-dpu", .data = &dpu_sm8350_cfg, },
> --
> 2.41.0
>


--
With best wishes
Dmitry
