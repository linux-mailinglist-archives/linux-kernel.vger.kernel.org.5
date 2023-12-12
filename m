Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA2380F95E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377437AbjLLV32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377307AbjLLV30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:29:26 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02632AF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:29:31 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-dbcb1d23163so1820770276.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702416570; x=1703021370; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FyzguBCkXPT3UDptz/Ehn+27LUw4ablyB92iJocAzyM=;
        b=tAu8HNMlv/OqSs6EkdoA13/2vrla0+jBuP75y46yRoy9KypgARjZ0OMXv/9Eljjk9B
         KMWthrucSGikcuBINr4NOd8EVGYId5p2hLbvbefq5zNll6fTgKppavHy9Oyx09b0Nay9
         7YrffqAViNU2beSerj2ehjhfF3MGmIk/h5RVxtdhntnMzK6ZV6S8JsWYMk2FiqYwm+3I
         fjx5ZR/LVLE08cauExfjDtr3YIX6saG0iuQaXnIdLoKzIiaOdHHWMG0WxEWKBvtUwr58
         8IXpWRE5bA7+gozXlTRsmUbyZLdDdt3xVq+JhRBUoCbahgy4dJYA05i8/PK4YQXn6xIo
         wGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702416570; x=1703021370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FyzguBCkXPT3UDptz/Ehn+27LUw4ablyB92iJocAzyM=;
        b=KJqvrSUeparsit/6Ul3RBtcaB8CG1s8Tyd0hz3tVAph8s1sk3ZwyFca0unN+m5JrKU
         epTTnrVBYAVc9UM0n66UBaL1HncYCIp8PN3XM37y/z5Vm+Ov1LZ6Ix5ffE7fK/xuEHox
         3ADZ5k3F918TTJKKGY6nLzmrRp0FLqmwvFZ7uoWKmL2ejcVriicbj6TD93SG6jIghlgH
         a4j6RNyikwzwMM7iM9ZdBoYKzlNEcWGp128bKerk/PLkATxP8wXTkpgInRnCUpRdo1vE
         8Pl7M9iryPnmdM1weAvlShKIOX8JIVnPNuRFpkG85aW0R06mwu85OKLJ4pzaxZHQKQKb
         l3NA==
X-Gm-Message-State: AOJu0YzQiWHyDJbzVL3i+zbOB3Vivl60aG5L36BZ3M3xsnOoPIt34m9i
        VbHCGHl/k1nc4w5ZikMP7hw9QZCcZuGfk3+a37rWOA==
X-Google-Smtp-Source: AGHT+IF3vRFQvOJZVDwuIU6YjrO4gN2QR7jTY6iRPg0AS1sQTv+4XkMhwvcTvOVPBw21lxMhM/jRS4WEn5Lajo2FB+o=
X-Received: by 2002:a05:6902:1b83:b0:db5:47c3:e5b9 with SMTP id
 ei3-20020a0569021b8300b00db547c3e5b9mr5764832ybb.9.1702416569915; Tue, 12 Dec
 2023 13:29:29 -0800 (PST)
MIME-Version: 1.0
References: <20231212002245.23715-1-quic_abhinavk@quicinc.com>
 <20231212002245.23715-8-quic_abhinavk@quicinc.com> <CAA8EJpq6VqF51RMdk5x3nULMSpZ8GN4HDGDLkGJuuF+abnQ=Hw@mail.gmail.com>
 <6d3a29e3-5f24-010e-483e-282ef93735aa@quicinc.com>
In-Reply-To: <6d3a29e3-5f24-010e-483e-282ef93735aa@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 12 Dec 2023 23:29:19 +0200
Message-ID: <CAA8EJpobOVF=yU_r0QybAbphZTjCAUrDpB4XA+pJbzuuLos_hA@mail.gmail.com>
Subject: Re: [PATCH v3 07/15] drm/msm/dpu: add dpu_hw_cdm abstraction for CDM block
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, seanpaul@chromium.org,
        quic_jesszhan@quicinc.com, linux-arm-msm@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
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

On Tue, 12 Dec 2023 at 19:51, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 12/12/2023 1:40 AM, Dmitry Baryshkov wrote:
> > On Tue, 12 Dec 2023 at 02:23, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >> CDM block comes with its own set of registers and operations
> >> which can be done. In-line with other hardware blocks, this
> >> change adds the dpu_hw_cdm abstraction for the CDM block.
> >>
> >> changes in v3:
> >>          - fix commit text from sub-blk to blk for CDM
> >>          - fix kbot issue for missing static for dpu_hw_cdm_enable()
> >>          - fix kbot issue for incorrect documentation style
> >>          - add more documentation for enums and struct in dpu_hw_cdm.h
> >>          - drop "enable" parameter from bind_pingpong_blk() as we can
> >>            just use PINGPONG_NONE for disable cases
> >>          - drop unnecessary bit operation for zero value of cdm_cfg
> >>
> >> changes in v2:
> >>          - replace bit magic with relevant defines
> >>          - use drmm_kzalloc instead of kzalloc/free
> >>          - some formatting fixes
> >>          - inline _setup_cdm_ops()
> >>          - protect bind_pingpong_blk with core_rev check
> >>          - drop setup_csc_data() and setup_cdwn() ops as they
> >>            are merged into enable()
> >>
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Closes: https://lore.kernel.org/oe-kbuild-all/202312101815.B3ZH7Pfy-lkp@intel.com/
> >> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >> ---
> >>   drivers/gpu/drm/msm/Makefile                |   1 +
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c  | 263 ++++++++++++++++++++
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.h  | 130 ++++++++++
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |   1 +
> >>   4 files changed, 395 insertions(+)
> >>   create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c
> >>   create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.h
> >>
> >> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> >> index 49671364fdcf..b1173128b5b9 100644
> >> --- a/drivers/gpu/drm/msm/Makefile
> >> +++ b/drivers/gpu/drm/msm/Makefile
> >> @@ -63,6 +63,7 @@ msm-$(CONFIG_DRM_MSM_DPU) += \
> >>          disp/dpu1/dpu_encoder_phys_wb.o \
> >>          disp/dpu1/dpu_formats.o \
> >>          disp/dpu1/dpu_hw_catalog.o \
> >> +       disp/dpu1/dpu_hw_cdm.o \
> >>          disp/dpu1/dpu_hw_ctl.o \
> >>          disp/dpu1/dpu_hw_dsc.o \
> >>          disp/dpu1/dpu_hw_dsc_1_2.o \
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c
> >> new file mode 100644
> >> index 000000000000..4976f8a05ce7
> >> --- /dev/null
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c
> >> @@ -0,0 +1,263 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Copyright (c) 2023, The Linux Foundation. All rights reserved.
> >> + */
> >> +
> >> +#include <drm/drm_managed.h>
> >> +
> >> +#include "dpu_hw_mdss.h"
> >> +#include "dpu_hw_util.h"
> >> +#include "dpu_hw_catalog.h"
> >> +#include "dpu_hw_cdm.h"
> >> +#include "dpu_kms.h"
> >> +
> >> +#define CDM_CSC_10_OPMODE                  0x000
> >> +#define CDM_CSC_10_BASE                    0x004
> >> +
> >> +#define CDM_CDWN2_OP_MODE                  0x100
> >> +#define CDM_CDWN2_CLAMP_OUT                0x104
> >> +#define CDM_CDWN2_PARAMS_3D_0              0x108
> >> +#define CDM_CDWN2_PARAMS_3D_1              0x10C
> >> +#define CDM_CDWN2_COEFF_COSITE_H_0         0x110
> >> +#define CDM_CDWN2_COEFF_COSITE_H_1         0x114
> >> +#define CDM_CDWN2_COEFF_COSITE_H_2         0x118
> >> +#define CDM_CDWN2_COEFF_OFFSITE_H_0        0x11C
> >> +#define CDM_CDWN2_COEFF_OFFSITE_H_1        0x120
> >> +#define CDM_CDWN2_COEFF_OFFSITE_H_2        0x124
> >> +#define CDM_CDWN2_COEFF_COSITE_V           0x128
> >> +#define CDM_CDWN2_COEFF_OFFSITE_V          0x12C
> >> +#define CDM_CDWN2_OUT_SIZE                 0x130
> >> +
> >> +#define CDM_HDMI_PACK_OP_MODE              0x200
> >> +#define CDM_CSC_10_MATRIX_COEFF_0          0x004
> >> +
> >> +#define CDM_MUX                            0x224
> >> +
> >> +/* CDM CDWN2 sub-block bit definitions */
> >> +#define CDM_CDWN2_OP_MODE_EN                  BIT(0)
> >> +#define CDM_CDWN2_OP_MODE_ENABLE_H            BIT(1)
> >> +#define CDM_CDWN2_OP_MODE_ENABLE_V            BIT(2)
> >> +#define CDM_CDWN2_OP_MODE_METHOD_H_AVG        BIT(3)
> >> +#define CDM_CDWN2_OP_MODE_METHOD_H_COSITE     BIT(4)
> >> +#define CDM_CDWN2_OP_MODE_METHOD_V_AVG        BIT(5)
> >> +#define CDM_CDWN2_OP_MODE_METHOD_V_COSITE     BIT(6)
> >> +#define CDM_CDWN2_OP_MODE_BITS_OUT_8BIT       BIT(7)
> >> +#define CDM_CDWN2_OP_MODE_METHOD_H_OFFSITE    GENMASK(4, 3)
> >> +#define CDM_CDWN2_OP_MODE_METHOD_V_OFFSITE    GENMASK(6, 5)
> >
> > I think it might be easier to define
> >
> > enum {
> >    CDM_CDWN2_METHOD_DROP_PIXEL = 0,
> >    CDM_CDWN2_METHOD_AVG = 1,
> >    CDM_CDWN2_METHOD_ = 2,
> >    CDM_CDWN2_METHOD_DROP_PIXEL = 3,
> > };
> >
> > then use FIELD_PREP()
> >
>
> Ok, let me explore that option.
>
> We already have below enum in dpu_hw_cdm.h, we can re-use that
>
> +enum dpu_hw_cdwn_type {
> +       CDM_CDWN_DISABLE,
> +       CDM_CDWN_PIXEL_DROP,
> +       CDM_CDWN_AVG,
> +       CDM_CDWN_COSITE,
> +       CDM_CDWN_OFFSITE,
> +};
>
> >> +#define CDM_CDWN2_V_PIXEL_DROP_MASK           GENMASK(6, 5)
> >> +#define CDM_CDWN2_H_PIXEL_DROP_MASK           GENMASK(4, 3)
> >
> > Why are they called foo_DROP_bar?
> >
>
> Because they are always used with ~
>
> And as per the documentation 0 for this field is pixel drop.
>
> If we are dropping the clearing altogether, then these masks will go
> away too.
>
> >> +
> >> +/* CDM CSC10 sub-block bit definitions */
> >> +#define CDM_CSC10_OP_MODE_EN               BIT(0)
> >> +#define CDM_CSC10_OP_MODE_SRC_FMT_YUV      BIT(1)
> >> +#define CDM_CSC10_OP_MODE_DST_FMT_YUV      BIT(2)
> >> +
> >> +/* CDM HDMI pack sub-block bit definitions */
> >> +#define CDM_HDMI_PACK_OP_MODE_EN           BIT(0)
> >> +
> >> +/*
> >> + * Horizontal coefficients for cosite chroma downscale
> >> + * s13 representation of coefficients
> >> + */
> >> +static u32 cosite_h_coeff[] = {0x00000016, 0x000001cc, 0x0100009e};
> >> +
> >> +/*
> >> + * Horizontal coefficients for offsite chroma downscale
> >> + */
> >> +static u32 offsite_h_coeff[] = {0x000b0005, 0x01db01eb, 0x00e40046};
> >> +
> >> +/*
> >> + * Vertical coefficients for cosite chroma downscale
> >> + */
> >> +static u32 cosite_v_coeff[] = {0x00080004};
> >> +/*
> >> + * Vertical coefficients for offsite chroma downscale
> >> + */
> >> +static u32 offsite_v_coeff[] = {0x00060002};
> >> +
> >> +static int dpu_hw_cdm_setup_cdwn(struct dpu_hw_cdm *ctx, struct dpu_hw_cdm_cfg *cfg)
> >> +{
> >> +       struct dpu_hw_blk_reg_map *c = &ctx->hw;
> >> +       u32 opmode = 0;
> >> +       u32 out_size = 0;
> >
> > No need to init it, please drop.
> >
>
> alright.
>
> >> +
> >> +       if (cfg->output_bit_depth != CDM_CDWN_OUTPUT_10BIT)
> >> +               opmode |= CDM_CDWN2_OP_MODE_BITS_OUT_8BIT;
> >> +
> >> +       /* ENABLE DWNS_H bit */
> >> +       opmode |= CDM_CDWN2_OP_MODE_ENABLE_H;
> >> +
> >> +       switch (cfg->h_cdwn_type) {
> >> +       case CDM_CDWN_DISABLE:
> >> +               /* CLEAR METHOD_H field */
> >> +               opmode &= ~CDM_CDWN2_H_PIXEL_DROP_MASK;
> >> +               /* CLEAR DWNS_H bit */
> >> +               opmode &= ~CDM_CDWN2_OP_MODE_ENABLE_H;
> >
> > Please, can we get rid of clears for the zero-initialised variable? If
> > you move the 10bit/8bit check after this switch, you can drop the = 0
> > from the variable definition and instead have:
> >
>
> Ok, will refine further.
>
> > switch (type) {
> > case DISABLE:
> >      opmode = 0;
> >      break;
> > case PIXEL_DROP:
> >      opmode = CDM_CDWN2_OP_MODE_ENABLE_H |
> >                       FIELD_PREP(CDM_CDWM2_OP_MODE_METHOD_H,
> > CDM_CDWN2_METHOD_DROP_PIXEL);
> >      break;
> > case AVG:
> >      opmode = CDM_CDWN2_OP_MODE_ENABLE_H |
> >                       FIELD_PREP(CDM_CDWM2_OP_MODE_METHOD_H,
> > CDM_CDWN2_METHOD_AVG);
> >     break;
> > // etc.
> > }
> >
> > Same for the v_type.
> >
>
> > Also could you please drop useless comments which repeat what is being
> > done in the next line?
> >
>
> ack :)
>
> >> +               break;
> >> +       case CDM_CDWN_PIXEL_DROP:
> >> +               /* Clear METHOD_H field (pixel drop is 0) */
> >> +               opmode &= ~CDM_CDWN2_H_PIXEL_DROP_MASK;
> >> +               break;
> >> +       case CDM_CDWN_AVG:
> >> +               /* Clear METHOD_H field (Average is 0x1) */
> >> +               opmode &= ~CDM_CDWN2_H_PIXEL_DROP_MASK;
> >> +               opmode |= CDM_CDWN2_OP_MODE_METHOD_H_AVG;
> >> +               break;
> >> +       case CDM_CDWN_COSITE:
> >> +               /* Clear METHOD_H field (Average is 0x2) */
> >
> > So, is Average 0x1 or 0x2? Or 0x3 as written below?
> >
>
> The comment is wrong. It should say Co-Site is 0x2, Off-Site is 0x3.
>
> And for the record, average is 0x1 :)
>
>
> >> +               opmode &= ~CDM_CDWN2_H_PIXEL_DROP_MASK;
> >> +               opmode |= CDM_CDWN2_OP_MODE_METHOD_H_COSITE;
> >> +               /* Co-site horizontal coefficients */
> >> +               DPU_REG_WRITE(c, CDM_CDWN2_COEFF_COSITE_H_0,
> >> +                             cosite_h_coeff[0]);
> >> +               DPU_REG_WRITE(c, CDM_CDWN2_COEFF_COSITE_H_1,
> >> +                             cosite_h_coeff[1]);
> >> +               DPU_REG_WRITE(c, CDM_CDWN2_COEFF_COSITE_H_2,
> >> +                             cosite_h_coeff[2]);
> >> +               break;
> >> +       case CDM_CDWN_OFFSITE:
> >> +               /* Clear METHOD_H field (Average is 0x3) */
> >> +               opmode &= ~CDM_CDWN2_H_PIXEL_DROP_MASK;
> >> +               opmode |= CDM_CDWN2_OP_MODE_METHOD_H_OFFSITE;
> >> +
> >> +               /* Off-site horizontal coefficients */
> >> +               DPU_REG_WRITE(c, CDM_CDWN2_COEFF_OFFSITE_H_0,
> >> +                             offsite_h_coeff[0]);
> >> +               DPU_REG_WRITE(c, CDM_CDWN2_COEFF_OFFSITE_H_1,
> >> +                             offsite_h_coeff[1]);
> >> +               DPU_REG_WRITE(c, CDM_CDWN2_COEFF_OFFSITE_H_2,
> >> +                             offsite_h_coeff[2]);
> >> +               break;
> >> +       default:
> >> +               DPU_ERROR("%s invalid horz down sampling type\n", __func__);
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       /* ENABLE DWNS_V bit */
> >> +       opmode |= CDM_CDWN2_OP_MODE_ENABLE_V;
> >> +
> >> +       switch (cfg->v_cdwn_type) {
> >> +       case CDM_CDWN_DISABLE:
> >> +               /* CLEAR METHOD_V field */
> >> +               opmode &= ~CDM_CDWN2_V_PIXEL_DROP_MASK;
> >> +               /* CLEAR DWNS_V bit */
> >> +               opmode &= ~CDM_CDWN2_OP_MODE_ENABLE_V;
> >> +               break;
> >> +       case CDM_CDWN_PIXEL_DROP:
> >> +               /* Clear METHOD_V field (pixel drop is 0) */
> >> +               opmode &= ~CDM_CDWN2_V_PIXEL_DROP_MASK;
> >> +               break;
> >> +       case CDM_CDWN_AVG:
> >> +               /* Clear METHOD_V field (Average is 0x1) */
> >> +               opmode &= ~CDM_CDWN2_V_PIXEL_DROP_MASK;
> >> +               opmode |= CDM_CDWN2_OP_MODE_METHOD_V_AVG;
> >> +               break;
> >> +       case CDM_CDWN_COSITE:
> >> +               /* Clear METHOD_V field (Average is 0x2) */
> >> +               opmode &= ~CDM_CDWN2_V_PIXEL_DROP_MASK;
> >> +               opmode |= CDM_CDWN2_OP_MODE_METHOD_V_COSITE;
> >> +               /* Co-site vertical coefficients */
> >> +               DPU_REG_WRITE(c,
> >> +                             CDM_CDWN2_COEFF_COSITE_V,
> >> +                             cosite_v_coeff[0]);
> >> +               break;
> >> +       case CDM_CDWN_OFFSITE:
> >> +               /* Clear METHOD_V field (Average is 0x3) */
> >> +               opmode &= ~CDM_CDWN2_V_PIXEL_DROP_MASK;
> >> +               opmode |= CDM_CDWN2_OP_MODE_METHOD_V_OFFSITE;
> >> +
> >> +               /* Off-site vertical coefficients */
> >> +               DPU_REG_WRITE(c,
> >> +                             CDM_CDWN2_COEFF_OFFSITE_V,
> >> +                             offsite_v_coeff[0]);
> >> +               break;
> >> +       default:
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       if (cfg->v_cdwn_type || cfg->h_cdwn_type)
> >> +               opmode |= CDM_CDWN2_OP_MODE_EN; /* EN CDWN module */
> >> +       else
> >> +               opmode &= ~CDM_CDWN2_OP_MODE_EN;
> >> +
> >> +       out_size = (cfg->output_width & 0xFFFF) | ((cfg->output_height & 0xFFFF) << 16);
> >> +       DPU_REG_WRITE(c, CDM_CDWN2_OUT_SIZE, out_size);
> >> +       DPU_REG_WRITE(c, CDM_CDWN2_OP_MODE, opmode);
> >> +       DPU_REG_WRITE(c, CDM_CDWN2_CLAMP_OUT, ((0x3FF << 16) | 0x0));
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int dpu_hw_cdm_enable(struct dpu_hw_cdm *ctx, struct dpu_hw_cdm_cfg *cdm)
> >> +{
> >> +       struct dpu_hw_blk_reg_map *c = &ctx->hw;
> >> +       const struct dpu_format *fmt;
> >> +       u32 opmode = 0;
> >> +       u32 csc = 0;
> >> +
> >> +       if (!ctx || !cdm)
> >> +               return -EINVAL;
> >> +
> >> +       fmt = cdm->output_fmt;
> >> +
> >> +       if (!DPU_FORMAT_IS_YUV(fmt))
> >> +               return -EINVAL;
> >> +
> >> +       dpu_hw_csc_setup(&ctx->hw, CDM_CSC_10_MATRIX_COEFF_0, cdm->csc_cfg, true);
> >> +       dpu_hw_cdm_setup_cdwn(ctx, cdm);
> >> +
> >> +       if (cdm->output_type == CDM_CDWN_OUTPUT_HDMI) {
> >> +               if (fmt->chroma_sample != DPU_CHROMA_H1V2)
> >> +                       return -EINVAL; /*unsupported format */
> >> +               opmode = CDM_HDMI_PACK_OP_MODE_EN;
> >> +               opmode |= (fmt->chroma_sample << 1);
> >> +       }
> >> +
> >> +       csc |= CDM_CSC10_OP_MODE_DST_FMT_YUV;
> >> +       csc &= ~CDM_CSC10_OP_MODE_SRC_FMT_YUV;
> >> +       csc |= CDM_CSC10_OP_MODE_EN;
> >> +
> >> +       if (ctx && ctx->ops.bind_pingpong_blk)
> >> +               ctx->ops.bind_pingpong_blk(ctx, cdm->pp_id);
> >> +
> >> +       DPU_REG_WRITE(c, CDM_CSC_10_OPMODE, csc);
> >> +       DPU_REG_WRITE(c, CDM_HDMI_PACK_OP_MODE, opmode);
> >> +       return 0;
> >> +}
> >> +
> >> +static void dpu_hw_cdm_bind_pingpong_blk(struct dpu_hw_cdm *ctx, const enum dpu_pingpong pp)
> >> +{
> >> +       struct dpu_hw_blk_reg_map *c;
> >> +       int mux_cfg = 0xF; /* Disabled */
> >
> > lowercase hex. And it is easier to move it to the if (pp) condition,
> > like it was done for INTF or WB.
> >
>
> ack for the lowercase hex.
>
> hmm, i followed the dpu_hw_dsc_1_2 model, so basically for 0
> (PINGPONG_NONE) cases it will stay at 0xf.

My preference was towards more explicit code, like INTF or WB.

>
> >> +
> >> +       c = &ctx->hw;
> >> +
> >> +       if (pp)
> >> +               mux_cfg = (pp - PINGPONG_0) & 0x7;
> >> +
> >> +       DPU_REG_WRITE(c, CDM_MUX, mux_cfg);
> >> +}
> >> +
> >> +struct dpu_hw_cdm *dpu_hw_cdm_init(struct drm_device *dev,
> >> +                                  const struct dpu_cdm_cfg *cfg, void __iomem *addr,
> >> +                                  const struct dpu_mdss_version *mdss_rev)
> >> +{
> >> +       struct dpu_hw_cdm *c;
> >> +
> >> +       c = drmm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
> >> +       if (!c)
> >> +               return ERR_PTR(-ENOMEM);
> >> +
> >> +       c->hw.blk_addr = addr + cfg->base;
> >> +       c->hw.log_mask = DPU_DBG_MASK_CDM;
> >> +
> >> +       /* Assign ops */
> >> +       c->idx = cfg->id;
> >> +       c->caps = cfg;
> >> +
> >> +       c->ops.enable = dpu_hw_cdm_enable;
> >> +       if (mdss_rev->core_major_ver >= 5)
> >> +               c->ops.bind_pingpong_blk = dpu_hw_cdm_bind_pingpong_blk;
> >> +
> >> +       return c;
> >> +}
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.h
> >> new file mode 100644
> >> index 000000000000..e7d57dbd6103
> >> --- /dev/null
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.h
> >> @@ -0,0 +1,130 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only */
> >> +/*
> >> + * Copyright (c) 2023, The Linux Foundation. All rights reserved.
> >> + */
> >> +
> >> +#ifndef _DPU_HW_CDM_H
> >> +#define _DPU_HW_CDM_H
> >> +
> >> +#include "dpu_hw_mdss.h"
> >> +#include "dpu_hw_top.h"
> >> +
> >> +struct dpu_hw_cdm;
> >> +
> >> +/**
> >> + * struct dpu_hw_cdm_cfg : current configuration of CDM block
> >> + *
> >> + *  @output_width:         output ROI width of CDM block
> >> + *  @output_height:        output ROI height of CDM block
> >> + *  @output_bit_depth:     output bit-depth of CDM block
> >> + *  @h_cdwn_type:          downsample type used for horizontal pixels
> >> + *  @v_cdwn_type:          downsample type used for vertical pixels
> >> + *  @output_fmt:           handle to dpu_format of CDM block
> >> + *  @csc_cfg:              handle to CSC matrix programmed for CDM block
> >> + *  @output_type:          interface to which CDM is paired (HDMI/WB)
> >> + *  @pp_id:                ping-pong block to which CDM is bound to
> >> + */
> >> +struct dpu_hw_cdm_cfg {
> >> +       u32 output_width;
> >> +       u32 output_height;
> >> +       u32 output_bit_depth;
> >> +       u32 h_cdwn_type;
> >> +       u32 v_cdwn_type;
> >> +       const struct dpu_format *output_fmt;
> >> +       const struct dpu_csc_cfg *csc_cfg;
> >> +       u32 output_type;
> >> +       int pp_id;
> >> +};
> >> +
> >> +/*
> >> + * These values are used indicate which type of downsample is used
> >> + * in the horizontal/vertical direction for the CDM block.
> >> + */
> >> +enum dpu_hw_cdwn_type {
> >> +       CDM_CDWN_DISABLE,
> >> +       CDM_CDWN_PIXEL_DROP,
> >> +       CDM_CDWN_AVG,
> >> +       CDM_CDWN_COSITE,
> >> +       CDM_CDWN_OFFSITE,
> >> +};
> >> +
> >> +/*
> >> + * CDM block can be paired with WB or HDMI block. These values match
> >> + * the input with which the CDM block is paired.
> >> + */
> >> +enum dpu_hw_cdwn_output_type {
> >> +       CDM_CDWN_OUTPUT_HDMI,
> >> +       CDM_CDWN_OUTPUT_WB,
> >> +};
> >> +
> >> +/*
> >> + * CDM block can give an 8-bit or 10-bit output. These values
> >> + * are used to indicate the output bit depth of CDM block
> >> + */
> >> +enum dpu_hw_cdwn_output_bit_depth {
> >> +       CDM_CDWN_OUTPUT_8BIT,
> >> +       CDM_CDWN_OUTPUT_10BIT,
> >> +};
> >> +
> >> +/**
> >> + * struct dpu_hw_cdm_ops : Interface to the chroma down Hw driver functions
> >> + *                         Assumption is these functions will be called after
> >> + *                         clocks are enabled
> >> + *  @enable:               Enables the output to interface and programs the
> >> + *                         output packer
> >> + *  @bind_pingpong_blk:    enable/disable the connection with pingpong which
> >> + *                         will feed pixels to this cdm
> >> + */
> >> +struct dpu_hw_cdm_ops {
> >> +       /**
> >> +        * Enable the CDM module
> >> +        * @cdm         Pointer to chroma down context
> >> +        */
> >> +       int (*enable)(struct dpu_hw_cdm *cdm, struct dpu_hw_cdm_cfg *cfg);
> >> +
> >> +       /**
> >> +        * Enable/disable the connection with pingpong
> >> +        * @cdm         Pointer to chroma down context
> >> +        * @pp          pingpong block id.
> >> +        */
> >> +       void (*bind_pingpong_blk)(struct dpu_hw_cdm *cdm, const enum dpu_pingpong pp);
> >> +};
> >> +
> >> +/**
> >> + * struct dpu_hw_cdm - cdm description
> >> + * @base: Hardware block base structure
> >> + * @hw: Block hardware details
> >> + * @idx: CDM index
> >> + * @caps: Pointer to cdm_cfg
> >> + * @ops: handle to operations possible for this CDM
> >> + */
> >> +struct dpu_hw_cdm {
> >> +       struct dpu_hw_blk base;
> >> +       struct dpu_hw_blk_reg_map hw;
> >> +
> >> +       /* chroma down */
> >> +       const struct dpu_cdm_cfg *caps;
> >> +       enum  dpu_cdm  idx;
> >> +
> >> +       /* ops */
> >> +       struct dpu_hw_cdm_ops ops;
> >> +};
> >> +
> >> +/**
> >> + * dpu_hw_cdm_init - initializes the cdm hw driver object.
> >> + * should be called once before accessing every cdm.
> >> + * @dev: DRM device handle
> >> + * @cdm: CDM catalog entry for which driver object is required
> >> + * @addr :   mapped register io address of MDSS
> >> + * @mdss_rev: mdss hw core revision
> >> + */
> >> +struct dpu_hw_cdm *dpu_hw_cdm_init(struct drm_device *dev,
> >> +                                  const struct dpu_cdm_cfg *cdm, void __iomem *addr,
> >> +                                  const struct dpu_mdss_version *mdss_rev);
> >> +
> >> +static inline struct dpu_hw_cdm *to_dpu_hw_cdm(struct dpu_hw_blk *hw)
> >> +{
> >> +       return container_of(hw, struct dpu_hw_cdm, base);
> >> +}
> >> +
> >> +#endif /*_DPU_HW_CDM_H */
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> >> index f319c8232ea5..9db4cf61bd29 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> >> @@ -466,6 +466,7 @@ struct dpu_mdss_color {
> >>   #define DPU_DBG_MASK_ROT      (1 << 9)
> >>   #define DPU_DBG_MASK_DSPP     (1 << 10)
> >>   #define DPU_DBG_MASK_DSC      (1 << 11)
> >> +#define DPU_DBG_MASK_CDM      (1 << 12)
> >>
> >>   /**
> >>    * struct dpu_hw_tear_check - Struct contains parameters to configure
> >> --
> >> 2.40.1
> >>
> >
> >



-- 
With best wishes
Dmitry
