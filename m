Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3786480A96F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574073AbjLHQk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjLHQkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:40:24 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354ED10DE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:40:30 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5d4f71f7e9fso21758877b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 08:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702053629; x=1702658429; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CtIjztq82Ng605c+NcEssJ2cJtY62a3iRKW7Z12Ri0I=;
        b=naZ0UD32vkgdwS3juwSbkqqHMsJb5TIxHik/nleneYYU0WNbUBz7MiFO9mDf2URv0e
         PMN5GXPNxqClzpXdAgKOyUfF8PP5ccQ6vCpIBFslOOmGSugru3YCu24QmHdLNCtb9v/Y
         y+MMXs28FcD159Ki3Bhxt/61orQqo8ty4ri2lZDKMODPO/z8rGx7wCVoYZlxGO5xLaGx
         Wzc13+ARNgTy7ZFEgvr4ILsl1RUc+IvFKZPPtLF18iHPnL2gf7aa4LnNwXZbjqXRGmFC
         BqNZFUja3Qz7zGoDhclpgl94yzvum+iDibXNo+hZz2Eg6RTjEfHTuM3RtsSV1zujHL4f
         Vvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702053629; x=1702658429;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CtIjztq82Ng605c+NcEssJ2cJtY62a3iRKW7Z12Ri0I=;
        b=wI7T8uo04RrnTKCBWMRF4sY92T345WKUyed5FjjsQxOqYM5VZ8PNhGDEuqw2mT/59K
         aLMAwGWzjjFQS9lwfO6/GQx4d8hQQ7QO2Q80fxaBRAkQifRGpnzsvQBIxDS9VcWQEYSb
         2OODQgnvwRTrtRxsk9JaGShDeFU2i35R+jrk7iZhr2iaLFoaLHu5f9TSbbX23zsZ2jW1
         w85eHeowhTa7K1jYYJJbf7S/IrvzPhOMi273RuejYnWfoFmXy3A0u1nyAcd11cOM58TH
         rpGrFvp/T2bjvd+Tjufghi2Otye4skGP0BtPSSX1faf1UmpkUl1t8KsHcqaaeu/BEYG6
         KcKA==
X-Gm-Message-State: AOJu0YyDPA6Mu+6rrmf9I50Rkx7UKAZlyqsjo09pGqnGcy1NUp6xRKX3
        pjXWX1qq6iNRpwGkz3ji687iA4BP2DnZwJWtxHkOkw==
X-Google-Smtp-Source: AGHT+IHvTBdkl+EMYls7dvGnTWOsuUM1VpIOdfLz7rVspnKaURICzUDPvLEdtBIUgsSqTefjgUvEZwF1pXlTXS5RX5M=
X-Received: by 2002:a81:4a45:0:b0:5d8:5727:80fa with SMTP id
 x66-20020a814a45000000b005d8572780famr254821ywa.98.1702053629351; Fri, 08 Dec
 2023 08:40:29 -0800 (PST)
MIME-Version: 1.0
References: <20231208050641.32582-1-quic_abhinavk@quicinc.com>
 <20231208050641.32582-5-quic_abhinavk@quicinc.com> <CAA8EJpro4ehwZ8Gs+ASUmrMJS0HbnDXd5pXwijs1jkDpR-kAOQ@mail.gmail.com>
 <ceb7e736-22f3-0cf3-3d65-7ec33e7c9d95@quicinc.com> <CAA8EJprr=T1cNst_dTNSToW_fVOM3mo-yRmWuK=8BU5rDNd54Q@mail.gmail.com>
 <5d4104ae-8737-6576-79ab-e68126bd826a@quicinc.com>
In-Reply-To: <5d4104ae-8737-6576-79ab-e68126bd826a@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Dec 2023 18:40:18 +0200
Message-ID: <CAA8EJpq=XTeRM59qvLuxPLatpbBdeqq1MHtx3PuKgb_HeN+PfA@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] drm/msm/dpu: move csc matrices to dpu_hw_util
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        quic_parellan@quicinc.com, quic_jesszhan@quicinc.com,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 at 18:35, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 12/8/2023 8:27 AM, Dmitry Baryshkov wrote:
> > On Fri, 8 Dec 2023 at 18:24, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 12/8/2023 3:12 AM, Dmitry Baryshkov wrote:
> >>> On Fri, 8 Dec 2023 at 07:07, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>>>
> >>>> Since the type and usage of CSC matrices is spanning across DPU
> >>>> lets introduce a helper to the dpu_hw_util to return the CSC
> >>>> corresponding to the request type. This will help to add more
> >>>> supported CSC types such as the RGB to YUV one which is used in
> >>>> the case of CDM.
> >>>>
> >>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >>>> ---
> >>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c | 54 +++++++++++++++++++++
> >>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h |  7 +++
> >>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c   | 39 ++-------------
> >>>>    3 files changed, 64 insertions(+), 36 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
> >>>> index 0b05061e3e62..59a153331194 100644
> >>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
> >>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
> >>>> @@ -87,6 +87,60 @@ static u32 dpu_hw_util_log_mask = DPU_DBG_MASK_NONE;
> >>>>    #define QOS_QOS_CTRL_VBLANK_EN            BIT(16)
> >>>>    #define QOS_QOS_CTRL_CREQ_VBLANK_MASK     GENMASK(21, 20)
> >>>>
> >>>> +static const struct dpu_csc_cfg dpu_csc_YUV2RGB_601L = {
> >>>> +       {
> >>>> +               /* S15.16 format */
> >>>> +               0x00012A00, 0x00000000, 0x00019880,
> >>>> +               0x00012A00, 0xFFFF9B80, 0xFFFF3000,
> >>>> +               0x00012A00, 0x00020480, 0x00000000,
> >>>> +       },
> >>>> +       /* signed bias */
> >>>> +       { 0xfff0, 0xff80, 0xff80,},
> >>>> +       { 0x0, 0x0, 0x0,},
> >>>> +       /* unsigned clamp */
> >>>> +       { 0x10, 0xeb, 0x10, 0xf0, 0x10, 0xf0,},
> >>>> +       { 0x00, 0xff, 0x00, 0xff, 0x00, 0xff,},
> >>>> +};
> >>>> +
> >>>> +static const struct dpu_csc_cfg dpu_csc10_YUV2RGB_601L = {
> >>>> +       {
> >>>> +               /* S15.16 format */
> >>>> +               0x00012A00, 0x00000000, 0x00019880,
> >>>> +               0x00012A00, 0xFFFF9B80, 0xFFFF3000,
> >>>> +               0x00012A00, 0x00020480, 0x00000000,
> >>>> +       },
> >>>> +       /* signed bias */
> >>>> +       { 0xffc0, 0xfe00, 0xfe00,},
> >>>> +       { 0x0, 0x0, 0x0,},
> >>>> +       /* unsigned clamp */
> >>>> +       { 0x40, 0x3ac, 0x40, 0x3c0, 0x40, 0x3c0,},
> >>>> +       { 0x00, 0x3ff, 0x00, 0x3ff, 0x00, 0x3ff,},
> >>>> +};
> >>>> +
> >>>> +/**
> >>>> + * dpu_hw_get_csc_cfg - get the CSC matrix based on the request type
> >>>> + * @type:              type of the requested CSC matrix from caller
> >>>> + * Return: CSC matrix corresponding to the request type in DPU format
> >>>> + */
> >>>> +const struct dpu_csc_cfg *dpu_hw_get_csc_cfg(enum dpu_hw_csc_cfg_type type)
> >>>> +{
> >>>> +       const struct dpu_csc_cfg *csc_cfg = NULL;
> >>>> +
> >>>> +       switch (type) {
> >>>> +       case DPU_HW_YUV2RGB_601L:
> >>>> +               csc_cfg = &dpu_csc_YUV2RGB_601L;
> >>>> +               break;
> >>>> +       case DPU_HW_YUV2RGB_601L_10BIT:
> >>>> +               csc_cfg = &dpu_csc10_YUV2RGB_601L;
> >>>> +               break;
> >>>> +       default:
> >>>> +               DPU_ERROR("unknown csc_cfg type\n");
> >>>> +               break;
> >>>> +       }
> >>>> +
> >>>> +       return csc_cfg;
> >>>> +}
> >>>> +
> >>>>    void dpu_reg_write(struct dpu_hw_blk_reg_map *c,
> >>>>                   u32 reg_off,
> >>>>                   u32 val,
> >>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
> >>>> index fe083b2e5696..49f2bcf6de15 100644
> >>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
> >>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
> >>>> @@ -19,6 +19,11 @@
> >>>>    #define MISR_CTRL_STATUS_CLEAR          BIT(10)
> >>>>    #define MISR_CTRL_FREE_RUN_MASK         BIT(31)
> >>>>
> >>>> +enum dpu_hw_csc_cfg_type {
> >>>> +       DPU_HW_YUV2RGB_601L,
> >>>> +       DPU_HW_YUV2RGB_601L_10BIT,
> >>>> +};
> >>>> +
> >>>>    /*
> >>>>     * This is the common struct maintained by each sub block
> >>>>     * for mapping the register offsets in this block to the
> >>>> @@ -368,4 +373,6 @@ bool dpu_hw_clk_force_ctrl(struct dpu_hw_blk_reg_map *c,
> >>>>                              const struct dpu_clk_ctrl_reg *clk_ctrl_reg,
> >>>>                              bool enable);
> >>>>
> >>>> +const struct dpu_csc_cfg *dpu_hw_get_csc_cfg(enum dpu_hw_csc_cfg_type type);
> >>>
> >>> I don't think we need extra enum and wrapper. Just export const data
> >>> structures directly.
> >>>
> >>
> >> I liked this approach because the blocks of DPU such as plane and CDM
> >> are clients to the dpu_hw_util and just request the type and the util
> >> handles their request of returning the correct csc matrix.
> >>
> >> Do you see any issue with this?
> >
> > Not an issue, but I don't see anything that requires an extra
> > abstraction. We perfectly know which CSC config we would like to get.
> >
>
> Correct, so the clients know which "type" of matrix they need and not
> the matrix itself. That was the idea behind this.

I consider this to be an unnecessary abstraction. In our case, knowing
the type = knowing the address of the matrix. I don't foresee any
additional logic there.

>
> >>
> >>>> +
> >>>>    #endif /* _DPU_HW_UTIL_H */
> >>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> >>>> index 3235ab132540..31641889b9f0 100644
> >>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> >>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> >>>> @@ -21,6 +21,7 @@
> >>>>    #include "dpu_kms.h"
> >>>>    #include "dpu_formats.h"
> >>>>    #include "dpu_hw_sspp.h"
> >>>> +#include "dpu_hw_util.h"
> >>>>    #include "dpu_trace.h"
> >>>>    #include "dpu_crtc.h"
> >>>>    #include "dpu_vbif.h"
> >>>> @@ -508,50 +509,16 @@ static void _dpu_plane_setup_pixel_ext(struct dpu_hw_scaler3_cfg *scale_cfg,
> >>>>           }
> >>>>    }
> >>>>
> >>>> -static const struct dpu_csc_cfg dpu_csc_YUV2RGB_601L = {
> >>>> -       {
> >>>> -               /* S15.16 format */
> >>>> -               0x00012A00, 0x00000000, 0x00019880,
> >>>> -               0x00012A00, 0xFFFF9B80, 0xFFFF3000,
> >>>> -               0x00012A00, 0x00020480, 0x00000000,
> >>>> -       },
> >>>> -       /* signed bias */
> >>>> -       { 0xfff0, 0xff80, 0xff80,},
> >>>> -       { 0x0, 0x0, 0x0,},
> >>>> -       /* unsigned clamp */
> >>>> -       { 0x10, 0xeb, 0x10, 0xf0, 0x10, 0xf0,},
> >>>> -       { 0x00, 0xff, 0x00, 0xff, 0x00, 0xff,},
> >>>> -};
> >>>> -
> >>>> -static const struct dpu_csc_cfg dpu_csc10_YUV2RGB_601L = {
> >>>> -       {
> >>>> -               /* S15.16 format */
> >>>> -               0x00012A00, 0x00000000, 0x00019880,
> >>>> -               0x00012A00, 0xFFFF9B80, 0xFFFF3000,
> >>>> -               0x00012A00, 0x00020480, 0x00000000,
> >>>> -               },
> >>>> -       /* signed bias */
> >>>> -       { 0xffc0, 0xfe00, 0xfe00,},
> >>>> -       { 0x0, 0x0, 0x0,},
> >>>> -       /* unsigned clamp */
> >>>> -       { 0x40, 0x3ac, 0x40, 0x3c0, 0x40, 0x3c0,},
> >>>> -       { 0x00, 0x3ff, 0x00, 0x3ff, 0x00, 0x3ff,},
> >>>> -};
> >>>> -
> >>>>    static const struct dpu_csc_cfg *_dpu_plane_get_csc(struct dpu_sw_pipe *pipe,
> >>>>                                                       const struct dpu_format *fmt)
> >>>>    {
> >>>> -       const struct dpu_csc_cfg *csc_ptr;
> >>>> -
> >>>>           if (!DPU_FORMAT_IS_YUV(fmt))
> >>>>                   return NULL;
> >>>>
> >>>>           if (BIT(DPU_SSPP_CSC_10BIT) & pipe->sspp->cap->features)
> >>>> -               csc_ptr = &dpu_csc10_YUV2RGB_601L;
> >>>> +               return dpu_hw_get_csc_cfg(DPU_HW_YUV2RGB_601L_10BIT);
> >>>>           else
> >>>> -               csc_ptr = &dpu_csc_YUV2RGB_601L;
> >>>> -
> >>>> -       return csc_ptr;
> >>>> +               return dpu_hw_get_csc_cfg(DPU_HW_YUV2RGB_601L);
> >>>>    }
> >>>>
> >>>>    static void _dpu_plane_setup_scaler(struct dpu_sw_pipe *pipe,
> >>>> --
> >>>> 2.40.1
> >>>>
> >>>
> >>>
> >
> >
> >



--
With best wishes
Dmitry
