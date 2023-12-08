Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B807580A1E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjLHLMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjLHLMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:12:40 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B08122
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:12:46 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5d3758fdd2eso19083177b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 03:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702033966; x=1702638766; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i+qYeo0Zg18ZkL8tHwRVHyVmW1yjuK0YJmkuP1+ez/c=;
        b=C5rvc4BHWJSL3SGT5MyCEG2o4bJBjR2+WtmB8juRIbjiUjeqGYmPZ9+o69F8PMdhTh
         HSjxrVNxmsQChxkm4by//VFotLsiZWKdK/FuRTH/55NiBQnWBnyBo1KYufaIYgmmzdkI
         qbAzI3PBZTdiJXTxO3G8fNjpaNfQCP0PECx2lDLHJj7s+CIxSpRcv+GM/SGRjXpe0hc1
         ZPfcDL99uVl2EwMn8+IL0YiiHdYakbqEWHRgRbb0cYv4elDB4K9VChPf3Yld2RZRMR0F
         ahKPC/CJFRDOWdFeK2GlLaRHGKb0t5yf5EqkGxPFwQBeqoxcO9stwFWkGQmIQ5EAgrwD
         QsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702033966; x=1702638766;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+qYeo0Zg18ZkL8tHwRVHyVmW1yjuK0YJmkuP1+ez/c=;
        b=lZYVPsXyq3ujUFl5b68DnQX+ydEGM8IHiQ2U7DoGBhFJxCdCZ45YRbn1OIXM5Ufxh8
         +Eixw4eAlPs5GvMczdH0RGaH6eqANRFOWv5RjECwjHw6lCIoBQsuPizFEC/icaHtqS4e
         2I0Av89fE1kZtMkXgEyLqiSl1LEHTOgMfdm1hcS8pTAU84TfW2ZhiKzBzAaqiSSfoliC
         eNheNVHojfZs8CbItnO05pfep8Z3YiYqdB98GwtrlNaU0ko8xCH7AVBh8ZzJbdXblxcc
         Xml6PeeZFnR0jDX0fChZs1UQCB8Jw7bjhNfh5/xQMHduixUTyhmLD2s1r63YRRT5xyn0
         gZFA==
X-Gm-Message-State: AOJu0YyFEgxhnu1TVcBqWWk3TT3wZrVyQdZjy5wzPj+Y2ghdNFalYapl
        FJO7NJOEvp++8hXJt9ZBQO1S46wE+BPbvNJ9pJX2tQ==
X-Google-Smtp-Source: AGHT+IFEd/gn5hEzCbxLxfIC/8FuS6uu2Q507j4Tz4pk3f+QgtN+2ZSPr3fLpkDg6yXGFHVuUIcPBsjz2DLWTT2gx64=
X-Received: by 2002:a81:ad57:0:b0:5d7:1941:3558 with SMTP id
 l23-20020a81ad57000000b005d719413558mr3882129ywk.63.1702033966103; Fri, 08
 Dec 2023 03:12:46 -0800 (PST)
MIME-Version: 1.0
References: <20231208050641.32582-1-quic_abhinavk@quicinc.com> <20231208050641.32582-5-quic_abhinavk@quicinc.com>
In-Reply-To: <20231208050641.32582-5-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Dec 2023 13:12:35 +0200
Message-ID: <CAA8EJpro4ehwZ8Gs+ASUmrMJS0HbnDXd5pXwijs1jkDpR-kAOQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 at 07:07, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Since the type and usage of CSC matrices is spanning across DPU
> lets introduce a helper to the dpu_hw_util to return the CSC
> corresponding to the request type. This will help to add more
> supported CSC types such as the RGB to YUV one which is used in
> the case of CDM.
>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c | 54 +++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h |  7 +++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c   | 39 ++-------------
>  3 files changed, 64 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
> index 0b05061e3e62..59a153331194 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
> @@ -87,6 +87,60 @@ static u32 dpu_hw_util_log_mask = DPU_DBG_MASK_NONE;
>  #define QOS_QOS_CTRL_VBLANK_EN            BIT(16)
>  #define QOS_QOS_CTRL_CREQ_VBLANK_MASK     GENMASK(21, 20)
>
> +static const struct dpu_csc_cfg dpu_csc_YUV2RGB_601L = {
> +       {
> +               /* S15.16 format */
> +               0x00012A00, 0x00000000, 0x00019880,
> +               0x00012A00, 0xFFFF9B80, 0xFFFF3000,
> +               0x00012A00, 0x00020480, 0x00000000,
> +       },
> +       /* signed bias */
> +       { 0xfff0, 0xff80, 0xff80,},
> +       { 0x0, 0x0, 0x0,},
> +       /* unsigned clamp */
> +       { 0x10, 0xeb, 0x10, 0xf0, 0x10, 0xf0,},
> +       { 0x00, 0xff, 0x00, 0xff, 0x00, 0xff,},
> +};
> +
> +static const struct dpu_csc_cfg dpu_csc10_YUV2RGB_601L = {
> +       {
> +               /* S15.16 format */
> +               0x00012A00, 0x00000000, 0x00019880,
> +               0x00012A00, 0xFFFF9B80, 0xFFFF3000,
> +               0x00012A00, 0x00020480, 0x00000000,
> +       },
> +       /* signed bias */
> +       { 0xffc0, 0xfe00, 0xfe00,},
> +       { 0x0, 0x0, 0x0,},
> +       /* unsigned clamp */
> +       { 0x40, 0x3ac, 0x40, 0x3c0, 0x40, 0x3c0,},
> +       { 0x00, 0x3ff, 0x00, 0x3ff, 0x00, 0x3ff,},
> +};
> +
> +/**
> + * dpu_hw_get_csc_cfg - get the CSC matrix based on the request type
> + * @type:              type of the requested CSC matrix from caller
> + * Return: CSC matrix corresponding to the request type in DPU format
> + */
> +const struct dpu_csc_cfg *dpu_hw_get_csc_cfg(enum dpu_hw_csc_cfg_type type)
> +{
> +       const struct dpu_csc_cfg *csc_cfg = NULL;
> +
> +       switch (type) {
> +       case DPU_HW_YUV2RGB_601L:
> +               csc_cfg = &dpu_csc_YUV2RGB_601L;
> +               break;
> +       case DPU_HW_YUV2RGB_601L_10BIT:
> +               csc_cfg = &dpu_csc10_YUV2RGB_601L;
> +               break;
> +       default:
> +               DPU_ERROR("unknown csc_cfg type\n");
> +               break;
> +       }
> +
> +       return csc_cfg;
> +}
> +
>  void dpu_reg_write(struct dpu_hw_blk_reg_map *c,
>                 u32 reg_off,
>                 u32 val,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
> index fe083b2e5696..49f2bcf6de15 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
> @@ -19,6 +19,11 @@
>  #define MISR_CTRL_STATUS_CLEAR          BIT(10)
>  #define MISR_CTRL_FREE_RUN_MASK         BIT(31)
>
> +enum dpu_hw_csc_cfg_type {
> +       DPU_HW_YUV2RGB_601L,
> +       DPU_HW_YUV2RGB_601L_10BIT,
> +};
> +
>  /*
>   * This is the common struct maintained by each sub block
>   * for mapping the register offsets in this block to the
> @@ -368,4 +373,6 @@ bool dpu_hw_clk_force_ctrl(struct dpu_hw_blk_reg_map *c,
>                            const struct dpu_clk_ctrl_reg *clk_ctrl_reg,
>                            bool enable);
>
> +const struct dpu_csc_cfg *dpu_hw_get_csc_cfg(enum dpu_hw_csc_cfg_type type);

I don't think we need extra enum and wrapper. Just export const data
structures directly.

> +
>  #endif /* _DPU_HW_UTIL_H */
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index 3235ab132540..31641889b9f0 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -21,6 +21,7 @@
>  #include "dpu_kms.h"
>  #include "dpu_formats.h"
>  #include "dpu_hw_sspp.h"
> +#include "dpu_hw_util.h"
>  #include "dpu_trace.h"
>  #include "dpu_crtc.h"
>  #include "dpu_vbif.h"
> @@ -508,50 +509,16 @@ static void _dpu_plane_setup_pixel_ext(struct dpu_hw_scaler3_cfg *scale_cfg,
>         }
>  }
>
> -static const struct dpu_csc_cfg dpu_csc_YUV2RGB_601L = {
> -       {
> -               /* S15.16 format */
> -               0x00012A00, 0x00000000, 0x00019880,
> -               0x00012A00, 0xFFFF9B80, 0xFFFF3000,
> -               0x00012A00, 0x00020480, 0x00000000,
> -       },
> -       /* signed bias */
> -       { 0xfff0, 0xff80, 0xff80,},
> -       { 0x0, 0x0, 0x0,},
> -       /* unsigned clamp */
> -       { 0x10, 0xeb, 0x10, 0xf0, 0x10, 0xf0,},
> -       { 0x00, 0xff, 0x00, 0xff, 0x00, 0xff,},
> -};
> -
> -static const struct dpu_csc_cfg dpu_csc10_YUV2RGB_601L = {
> -       {
> -               /* S15.16 format */
> -               0x00012A00, 0x00000000, 0x00019880,
> -               0x00012A00, 0xFFFF9B80, 0xFFFF3000,
> -               0x00012A00, 0x00020480, 0x00000000,
> -               },
> -       /* signed bias */
> -       { 0xffc0, 0xfe00, 0xfe00,},
> -       { 0x0, 0x0, 0x0,},
> -       /* unsigned clamp */
> -       { 0x40, 0x3ac, 0x40, 0x3c0, 0x40, 0x3c0,},
> -       { 0x00, 0x3ff, 0x00, 0x3ff, 0x00, 0x3ff,},
> -};
> -
>  static const struct dpu_csc_cfg *_dpu_plane_get_csc(struct dpu_sw_pipe *pipe,
>                                                     const struct dpu_format *fmt)
>  {
> -       const struct dpu_csc_cfg *csc_ptr;
> -
>         if (!DPU_FORMAT_IS_YUV(fmt))
>                 return NULL;
>
>         if (BIT(DPU_SSPP_CSC_10BIT) & pipe->sspp->cap->features)
> -               csc_ptr = &dpu_csc10_YUV2RGB_601L;
> +               return dpu_hw_get_csc_cfg(DPU_HW_YUV2RGB_601L_10BIT);
>         else
> -               csc_ptr = &dpu_csc_YUV2RGB_601L;
> -
> -       return csc_ptr;
> +               return dpu_hw_get_csc_cfg(DPU_HW_YUV2RGB_601L);
>  }
>
>  static void _dpu_plane_setup_scaler(struct dpu_sw_pipe *pipe,
> --
> 2.40.1
>


-- 
With best wishes
Dmitry
