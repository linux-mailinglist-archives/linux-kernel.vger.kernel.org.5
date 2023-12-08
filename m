Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C406380A8DD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbjLHQ1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjLHQ1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:27:36 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062CF1986
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:27:42 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-da819902678so2264264276.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 08:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702052861; x=1702657661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rJStT6nX4mO5hjyH4xRXtt9A8r2hKkI8m3jfKIRUv7Y=;
        b=sxXqZ++JSQy6G1VO8yDgBE+5XpI8XsAjbi3GZ9z5KjK3Kxm+JvrQMwVWSv0lZthDjc
         WHHLKFL4POvSq64fXM6skIw5gMlhlSL+wmY9OPiPKkrkAJZHPR73I5hnqaLwJLY4OSn8
         dElm9FfrxLv/XFdp5PAm3YqRq9piDBDCrtKDWM6RAxtA+BU11nilqtlq+K6bsTO7qgRE
         /4iwrp3/u8U2dKekvNUL7vFBuljVmHcLQsU24nsLibuYNOtly/mFDx3Mvkiv4XNcyc0n
         ewcCmRIsrJEdij9UqlFO9x+qgEgOqGwjxWcphGHrWPo35E1p02HC8ufN+exns56Yobf/
         DXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702052861; x=1702657661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJStT6nX4mO5hjyH4xRXtt9A8r2hKkI8m3jfKIRUv7Y=;
        b=RPDVCyrQlfF3bwG/w6nddSKHbWwRmu29K1hkEOhuY9VXnF8+oR5M4WtWd+jPpwbfFV
         xwcf8Pepx0tsrbdqoVcD1x1QuAl5vpMxL5SFL4LaU8uuBko1h5kKiQl5M1s0A96XrzaF
         SPn4piyG6PaUSRERNWzpjPfypzTTc7dPqJhJ7LQFgTorB/HRix7pFPNidSB+37G3icLy
         cx+FYq9MJW9ED7DvHOHZQQvc2XUrLKfWD6W8AyAhS5AHPg3oZYAaKaYdHxV82alJGpue
         50AeRB/6L30+3gEF4jAmP+hGcFZtjKPyEwGcdLSfClWIJllcPiXx9inF+gJtFygpodXh
         qhiA==
X-Gm-Message-State: AOJu0YwXueD79ExgHjDIs4zvqG870QV0eYrsdTkYKLjeN6fSh4/WmwZs
        L/Nq9M0mXHkTEVfcp8Z/skwUosTTunkY+iA594j6ZA==
X-Google-Smtp-Source: AGHT+IGpqi97XRA0fudntL1YW0ETMQ5wmZEIdl2tT/xY+xHIq9kt+O/sOogXu6b9DHtOlesiNBJCmOrTa8ETyFv0ewc=
X-Received: by 2002:a0d:d884:0:b0:5d7:a9d5:62f with SMTP id
 a126-20020a0dd884000000b005d7a9d5062fmr222751ywe.26.1702052861173; Fri, 08
 Dec 2023 08:27:41 -0800 (PST)
MIME-Version: 1.0
References: <20231208050641.32582-1-quic_abhinavk@quicinc.com>
 <20231208050641.32582-5-quic_abhinavk@quicinc.com> <CAA8EJpro4ehwZ8Gs+ASUmrMJS0HbnDXd5pXwijs1jkDpR-kAOQ@mail.gmail.com>
 <ceb7e736-22f3-0cf3-3d65-7ec33e7c9d95@quicinc.com>
In-Reply-To: <ceb7e736-22f3-0cf3-3d65-7ec33e7c9d95@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Dec 2023 18:27:30 +0200
Message-ID: <CAA8EJprr=T1cNst_dTNSToW_fVOM3mo-yRmWuK=8BU5rDNd54Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] drm/msm/dpu: move csc matrices to dpu_hw_util
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, linux-arm-msm@vger.kernel.org,
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

On Fri, 8 Dec 2023 at 18:24, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 12/8/2023 3:12 AM, Dmitry Baryshkov wrote:
> > On Fri, 8 Dec 2023 at 07:07, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >> Since the type and usage of CSC matrices is spanning across DPU
> >> lets introduce a helper to the dpu_hw_util to return the CSC
> >> corresponding to the request type. This will help to add more
> >> supported CSC types such as the RGB to YUV one which is used in
> >> the case of CDM.
> >>
> >> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >> ---
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c | 54 +++++++++++++++++++++
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h |  7 +++
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c   | 39 ++-------------
> >>   3 files changed, 64 insertions(+), 36 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
> >> index 0b05061e3e62..59a153331194 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
> >> @@ -87,6 +87,60 @@ static u32 dpu_hw_util_log_mask = DPU_DBG_MASK_NONE;
> >>   #define QOS_QOS_CTRL_VBLANK_EN            BIT(16)
> >>   #define QOS_QOS_CTRL_CREQ_VBLANK_MASK     GENMASK(21, 20)
> >>
> >> +static const struct dpu_csc_cfg dpu_csc_YUV2RGB_601L = {
> >> +       {
> >> +               /* S15.16 format */
> >> +               0x00012A00, 0x00000000, 0x00019880,
> >> +               0x00012A00, 0xFFFF9B80, 0xFFFF3000,
> >> +               0x00012A00, 0x00020480, 0x00000000,
> >> +       },
> >> +       /* signed bias */
> >> +       { 0xfff0, 0xff80, 0xff80,},
> >> +       { 0x0, 0x0, 0x0,},
> >> +       /* unsigned clamp */
> >> +       { 0x10, 0xeb, 0x10, 0xf0, 0x10, 0xf0,},
> >> +       { 0x00, 0xff, 0x00, 0xff, 0x00, 0xff,},
> >> +};
> >> +
> >> +static const struct dpu_csc_cfg dpu_csc10_YUV2RGB_601L = {
> >> +       {
> >> +               /* S15.16 format */
> >> +               0x00012A00, 0x00000000, 0x00019880,
> >> +               0x00012A00, 0xFFFF9B80, 0xFFFF3000,
> >> +               0x00012A00, 0x00020480, 0x00000000,
> >> +       },
> >> +       /* signed bias */
> >> +       { 0xffc0, 0xfe00, 0xfe00,},
> >> +       { 0x0, 0x0, 0x0,},
> >> +       /* unsigned clamp */
> >> +       { 0x40, 0x3ac, 0x40, 0x3c0, 0x40, 0x3c0,},
> >> +       { 0x00, 0x3ff, 0x00, 0x3ff, 0x00, 0x3ff,},
> >> +};
> >> +
> >> +/**
> >> + * dpu_hw_get_csc_cfg - get the CSC matrix based on the request type
> >> + * @type:              type of the requested CSC matrix from caller
> >> + * Return: CSC matrix corresponding to the request type in DPU format
> >> + */
> >> +const struct dpu_csc_cfg *dpu_hw_get_csc_cfg(enum dpu_hw_csc_cfg_type type)
> >> +{
> >> +       const struct dpu_csc_cfg *csc_cfg = NULL;
> >> +
> >> +       switch (type) {
> >> +       case DPU_HW_YUV2RGB_601L:
> >> +               csc_cfg = &dpu_csc_YUV2RGB_601L;
> >> +               break;
> >> +       case DPU_HW_YUV2RGB_601L_10BIT:
> >> +               csc_cfg = &dpu_csc10_YUV2RGB_601L;
> >> +               break;
> >> +       default:
> >> +               DPU_ERROR("unknown csc_cfg type\n");
> >> +               break;
> >> +       }
> >> +
> >> +       return csc_cfg;
> >> +}
> >> +
> >>   void dpu_reg_write(struct dpu_hw_blk_reg_map *c,
> >>                  u32 reg_off,
> >>                  u32 val,
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
> >> index fe083b2e5696..49f2bcf6de15 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
> >> @@ -19,6 +19,11 @@
> >>   #define MISR_CTRL_STATUS_CLEAR          BIT(10)
> >>   #define MISR_CTRL_FREE_RUN_MASK         BIT(31)
> >>
> >> +enum dpu_hw_csc_cfg_type {
> >> +       DPU_HW_YUV2RGB_601L,
> >> +       DPU_HW_YUV2RGB_601L_10BIT,
> >> +};
> >> +
> >>   /*
> >>    * This is the common struct maintained by each sub block
> >>    * for mapping the register offsets in this block to the
> >> @@ -368,4 +373,6 @@ bool dpu_hw_clk_force_ctrl(struct dpu_hw_blk_reg_map *c,
> >>                             const struct dpu_clk_ctrl_reg *clk_ctrl_reg,
> >>                             bool enable);
> >>
> >> +const struct dpu_csc_cfg *dpu_hw_get_csc_cfg(enum dpu_hw_csc_cfg_type type);
> >
> > I don't think we need extra enum and wrapper. Just export const data
> > structures directly.
> >
>
> I liked this approach because the blocks of DPU such as plane and CDM
> are clients to the dpu_hw_util and just request the type and the util
> handles their request of returning the correct csc matrix.
>
> Do you see any issue with this?

Not an issue, but I don't see anything that requires an extra
abstraction. We perfectly know which CSC config we would like to get.

>
> >> +
> >>   #endif /* _DPU_HW_UTIL_H */
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> >> index 3235ab132540..31641889b9f0 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> >> @@ -21,6 +21,7 @@
> >>   #include "dpu_kms.h"
> >>   #include "dpu_formats.h"
> >>   #include "dpu_hw_sspp.h"
> >> +#include "dpu_hw_util.h"
> >>   #include "dpu_trace.h"
> >>   #include "dpu_crtc.h"
> >>   #include "dpu_vbif.h"
> >> @@ -508,50 +509,16 @@ static void _dpu_plane_setup_pixel_ext(struct dpu_hw_scaler3_cfg *scale_cfg,
> >>          }
> >>   }
> >>
> >> -static const struct dpu_csc_cfg dpu_csc_YUV2RGB_601L = {
> >> -       {
> >> -               /* S15.16 format */
> >> -               0x00012A00, 0x00000000, 0x00019880,
> >> -               0x00012A00, 0xFFFF9B80, 0xFFFF3000,
> >> -               0x00012A00, 0x00020480, 0x00000000,
> >> -       },
> >> -       /* signed bias */
> >> -       { 0xfff0, 0xff80, 0xff80,},
> >> -       { 0x0, 0x0, 0x0,},
> >> -       /* unsigned clamp */
> >> -       { 0x10, 0xeb, 0x10, 0xf0, 0x10, 0xf0,},
> >> -       { 0x00, 0xff, 0x00, 0xff, 0x00, 0xff,},
> >> -};
> >> -
> >> -static const struct dpu_csc_cfg dpu_csc10_YUV2RGB_601L = {
> >> -       {
> >> -               /* S15.16 format */
> >> -               0x00012A00, 0x00000000, 0x00019880,
> >> -               0x00012A00, 0xFFFF9B80, 0xFFFF3000,
> >> -               0x00012A00, 0x00020480, 0x00000000,
> >> -               },
> >> -       /* signed bias */
> >> -       { 0xffc0, 0xfe00, 0xfe00,},
> >> -       { 0x0, 0x0, 0x0,},
> >> -       /* unsigned clamp */
> >> -       { 0x40, 0x3ac, 0x40, 0x3c0, 0x40, 0x3c0,},
> >> -       { 0x00, 0x3ff, 0x00, 0x3ff, 0x00, 0x3ff,},
> >> -};
> >> -
> >>   static const struct dpu_csc_cfg *_dpu_plane_get_csc(struct dpu_sw_pipe *pipe,
> >>                                                      const struct dpu_format *fmt)
> >>   {
> >> -       const struct dpu_csc_cfg *csc_ptr;
> >> -
> >>          if (!DPU_FORMAT_IS_YUV(fmt))
> >>                  return NULL;
> >>
> >>          if (BIT(DPU_SSPP_CSC_10BIT) & pipe->sspp->cap->features)
> >> -               csc_ptr = &dpu_csc10_YUV2RGB_601L;
> >> +               return dpu_hw_get_csc_cfg(DPU_HW_YUV2RGB_601L_10BIT);
> >>          else
> >> -               csc_ptr = &dpu_csc_YUV2RGB_601L;
> >> -
> >> -       return csc_ptr;
> >> +               return dpu_hw_get_csc_cfg(DPU_HW_YUV2RGB_601L);
> >>   }
> >>
> >>   static void _dpu_plane_setup_scaler(struct dpu_sw_pipe *pipe,
> >> --
> >> 2.40.1
> >>
> >
> >



-- 
With best wishes
Dmitry
