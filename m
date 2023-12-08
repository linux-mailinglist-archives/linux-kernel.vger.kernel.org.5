Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3D780A2AD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573676AbjLHLxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjLHLxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:53:06 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166EA173F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:53:11 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5d7b1a8ec90so16588927b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 03:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702036390; x=1702641190; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8i54RGr1RVvLQqMhbxbcJTSb8J4fDgdykssHyv9XSuk=;
        b=ymHKrBa5lL+xD10DVkSFb9+y6O/7+o9HfRlYxPTpbzUtwyR98UnGRkbDse5v3kc6O/
         zP/Bek90Q7UQFRcO68bpbaeAdZV2Aq15ylA3vUYWw1qRn+/5l/xEowPUvbj/T87VsoUw
         sAysczVRbxCHEEpclxZbDmvOzwjSslPw9XPjK5h+Qnsx8NME0VxD2+f40hyMk6zl0cB+
         uizGv9ozNtlb18snmnUT4kzxAEfoAcoGrbitxeQDeGTFnzQdcs8mtOnuzpd+0eike2I+
         2kokzUaajm3Qmv91GZEaK76dkS9kamQEz/1/YmBPGAM7kzAfdrEVqWg9iAGC9P91+Xvy
         k9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702036390; x=1702641190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8i54RGr1RVvLQqMhbxbcJTSb8J4fDgdykssHyv9XSuk=;
        b=IB4EzbI+IwVp+kDf1SUAptw6KambgvdvMYPFWYC8uxOukq/KLiNvdpu7F1BI3mNlY5
         8i8aspWm6Zff6BoByfpicGtiDxa+luwa3h6fORYh3AyK6e/nN5jQ1Lg6AqhnsY3D4HI9
         rF4R+WEVWjrzWhGZVtVIR+QWD82OQ7AdLs5F+YnQSoC62t+te8iI3GlmQTD1MiB3rigW
         rGvX755+EL+zk87kFOHIO7NNcP79K/4lg4D6L6E3SYhTyOT3IP6DOQBGlyYhL2dGhHZ9
         Fu/TeBsr+n+06K69l5wdwVFg4eTjPI10Ls5BnRtNnIs8donIcVqYS8m0I161T2gFKhqg
         T0og==
X-Gm-Message-State: AOJu0Yx8N1DcZZHfaDfaXtIDYPHT8FZeWR1gmm1hIxEiODSTq7KZasw9
        XB0TsPU+t6M13xmyawtKeVKS+NkBJyWMBlAxR9USwA==
X-Google-Smtp-Source: AGHT+IEg4poe6gaw0ORBZi/F7BU2bI6GuBFeX3z/AbbUF8HE/jVjtrqz6nmYvJTHXebkJqB3As93aV5yZXxT7YrMmtA=
X-Received: by 2002:a0d:e6d0:0:b0:59e:7f14:4b48 with SMTP id
 p199-20020a0de6d0000000b0059e7f144b48mr3185834ywe.41.1702036390198; Fri, 08
 Dec 2023 03:53:10 -0800 (PST)
MIME-Version: 1.0
References: <20231208050641.32582-1-quic_abhinavk@quicinc.com> <20231208050641.32582-13-quic_abhinavk@quicinc.com>
In-Reply-To: <20231208050641.32582-13-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Dec 2023 13:52:59 +0200
Message-ID: <CAA8EJpr5FyYaGQpQX_MBK6y9kLz_UHsLmsKrV2tF6ukz6sU8YQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/16] drm/msm/dpu: add an API to setup the CDM block
 for writeback
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

On Fri, 8 Dec 2023 at 07:07, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Add an API dpu_encoder_helper_phys_setup_cdm() which can be used by
> the writeback encoder to setup the CDM block.
>
> Currently, this is defined and used within the writeback's physical
> encoder layer however, the function can be modified to be used to setup
> the CDM block even for non-writeback interfaces.
>
> Until those modifications are planned and made, keep it local to
> writeback.
>
> changes in v2:
>         - add the RGB2YUV CSC matrix to dpu util as needed by CDM
>         - use dpu_hw_get_csc_cfg() to get and program CSC
>         - drop usage of setup_csc_data() and setup_cdwn() cdm ops
>           as they both have been merged into enable()
>         - drop reduntant hw_cdm and hw_pp checks
>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h  |  3 +
>  .../drm/msm/disp/dpu1/dpu_encoder_phys_wb.c   | 96 ++++++++++++++++++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c   | 17 ++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h   |  1 +
>  4 files changed, 116 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> index 410f6225789c..1d6d1eb642b9 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> @@ -16,6 +16,7 @@
>  #include "dpu_hw_pingpong.h"
>  #include "dpu_hw_ctl.h"
>  #include "dpu_hw_top.h"
> +#include "dpu_hw_cdm.h"
>  #include "dpu_encoder.h"
>  #include "dpu_crtc.h"
>
> @@ -210,6 +211,7 @@ static inline int dpu_encoder_phys_inc_pending(struct dpu_encoder_phys *phys)
>   * @wbirq_refcount:     Reference count of writeback interrupt
>   * @wb_done_timeout_cnt: number of wb done irq timeout errors
>   * @wb_cfg:  writeback block config to store fb related details
> + * @cdm_cfg: cdm block config needed to store writeback block's CDM configuration
>   * @wb_conn: backpointer to writeback connector
>   * @wb_job: backpointer to current writeback job
>   * @dest:   dpu buffer layout for current writeback output buffer
> @@ -219,6 +221,7 @@ struct dpu_encoder_phys_wb {
>         atomic_t wbirq_refcount;
>         int wb_done_timeout_cnt;
>         struct dpu_hw_wb_cfg wb_cfg;
> +       struct dpu_hw_cdm_cfg cdm_cfg;
>         struct drm_writeback_connector *wb_conn;
>         struct drm_writeback_job *wb_job;
>         struct dpu_hw_fmt_layout dest;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> index 4665367cf14f..85429c62d727 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> @@ -259,6 +259,99 @@ static void dpu_encoder_phys_wb_setup_ctl(struct dpu_encoder_phys *phys_enc)
>         }
>  }
>
> +/**
> + * dpu_encoder_phys_wb_setup_cdp - setup chroma down sampling block
> + * @phys_enc:Pointer to physical encoder
> + */
> +static void dpu_encoder_helper_phys_setup_cdm(struct dpu_encoder_phys *phys_enc)
> +{
> +       struct dpu_hw_cdm *hw_cdm;
> +       struct dpu_hw_cdm_cfg *cdm_cfg;
> +       struct dpu_hw_pingpong *hw_pp;
> +       struct dpu_encoder_phys_wb *wb_enc;
> +       const struct msm_format *format;
> +       const struct dpu_format *dpu_fmt;
> +       struct drm_writeback_job *wb_job;
> +       int ret;
> +
> +       if (!phys_enc)
> +               return;
> +
> +       wb_enc = to_dpu_encoder_phys_wb(phys_enc);
> +       cdm_cfg = &wb_enc->cdm_cfg;
> +       hw_pp = phys_enc->hw_pp;
> +       hw_cdm = phys_enc->hw_cdm;
> +       wb_job = wb_enc->wb_job;
> +
> +       format = msm_framebuffer_format(wb_enc->wb_job->fb);
> +       dpu_fmt = dpu_get_dpu_format_ext(format->pixel_format, wb_job->fb->modifier);
> +
> +       if (!hw_cdm)
> +               return;
> +
> +       if (!DPU_FORMAT_IS_YUV(dpu_fmt)) {
> +               DPU_DEBUG("[enc:%d] cdm_disable fmt:%x\n", DRMID(phys_enc->parent),
> +                         dpu_fmt->base.pixel_format);
> +               if (hw_cdm->ops.disable)
> +                       hw_cdm->ops.disable(hw_cdm);
> +
> +               return;
> +       }
> +
> +       memset(cdm_cfg, 0, sizeof(struct dpu_hw_cdm_cfg));
> +
> +       cdm_cfg->output_width = wb_job->fb->width;
> +       cdm_cfg->output_height = wb_job->fb->height;
> +       cdm_cfg->output_fmt = dpu_fmt;
> +       cdm_cfg->output_type = CDM_CDWN_OUTPUT_WB;
> +       cdm_cfg->output_bit_depth = DPU_FORMAT_IS_DX(dpu_fmt) ?
> +                       CDM_CDWN_OUTPUT_10BIT : CDM_CDWN_OUTPUT_8BIT;
> +       cdm_cfg->csc_cfg = dpu_hw_get_csc_cfg(DPU_HW_RGB2YUV_601L_10BIT);
> +       if (!cdm_cfg->csc_cfg) {
> +               DPU_ERROR("valid csc not found\n");
> +               return;
> +       }
> +
> +       /* enable 10 bit logic */
> +       switch (cdm_cfg->output_fmt->chroma_sample) {
> +       case DPU_CHROMA_RGB:
> +               cdm_cfg->h_cdwn_type = CDM_CDWN_DISABLE;
> +               cdm_cfg->v_cdwn_type = CDM_CDWN_DISABLE;
> +               break;
> +       case DPU_CHROMA_H2V1:
> +               cdm_cfg->h_cdwn_type = CDM_CDWN_COSITE;
> +               cdm_cfg->v_cdwn_type = CDM_CDWN_DISABLE;
> +               break;
> +       case DPU_CHROMA_420:
> +               cdm_cfg->h_cdwn_type = CDM_CDWN_COSITE;
> +               cdm_cfg->v_cdwn_type = CDM_CDWN_OFFSITE;
> +               break;
> +       case DPU_CHROMA_H1V2:
> +       default:
> +               DPU_ERROR("[enc:%d] unsupported chroma sampling type\n",
> +                         DRMID(phys_enc->parent));
> +               cdm_cfg->h_cdwn_type = CDM_CDWN_DISABLE;
> +               cdm_cfg->v_cdwn_type = CDM_CDWN_DISABLE;

If it is unsupported, we should return an error here.

> +               break;
> +       }
> +
> +       DPU_DEBUG("[enc:%d] cdm_enable:%d,%d,%X,%d,%d,%d,%d]\n",
> +                 DRMID(phys_enc->parent), cdm_cfg->output_width,
> +                 cdm_cfg->output_height, cdm_cfg->output_fmt->base.pixel_format,
> +                 cdm_cfg->output_type, cdm_cfg->output_bit_depth,
> +                 cdm_cfg->h_cdwn_type, cdm_cfg->v_cdwn_type);
> +
> +       if (hw_cdm->ops.enable) {
> +               cdm_cfg->pp_id = hw_pp->idx;
> +               ret = hw_cdm->ops.enable(hw_cdm, cdm_cfg);
> +               if (ret < 0) {
> +                       DPU_ERROR("[enc:%d] failed to enable CDM; ret:%d\n",
> +                                 DRMID(phys_enc->parent), ret);
> +                       return;
> +               }
> +       }
> +}
> +
>  /**
>   * dpu_encoder_phys_wb_atomic_check - verify and fixup given atomic states
>   * @phys_enc:  Pointer to physical encoder
> @@ -382,8 +475,9 @@ static void dpu_encoder_phys_wb_setup(
>
>         dpu_encoder_phys_wb_setup_fb(phys_enc, fb);
>
> -       dpu_encoder_phys_wb_setup_ctl(phys_enc);
> +       dpu_encoder_helper_phys_setup_cdm(phys_enc);
>
> +       dpu_encoder_phys_wb_setup_ctl(phys_enc);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
> index 59a153331194..34143491aba2 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
> @@ -87,6 +87,8 @@ static u32 dpu_hw_util_log_mask = DPU_DBG_MASK_NONE;
>  #define QOS_QOS_CTRL_VBLANK_EN            BIT(16)
>  #define QOS_QOS_CTRL_CREQ_VBLANK_MASK     GENMASK(21, 20)
>
> +#define TO_S15D16(_x_)((_x_) << 7)

Huh? I don't understand why it is shifted by 7. If you have data in
S8.9 format, I'd say that it makes things less obvious compared to
S15.16 (where you can perform division on the fly).

> +
>  static const struct dpu_csc_cfg dpu_csc_YUV2RGB_601L = {
>         {
>                 /* S15.16 format */
> @@ -117,6 +119,18 @@ static const struct dpu_csc_cfg dpu_csc10_YUV2RGB_601L = {
>         { 0x00, 0x3ff, 0x00, 0x3ff, 0x00, 0x3ff,},
>  };
>
> +static const struct dpu_csc_cfg dpu_csc10_rgb2yuv_601l = {
> +       {
> +               TO_S15D16(0x0083), TO_S15D16(0x0102), TO_S15D16(0x0032),
> +               TO_S15D16(0x1fb5), TO_S15D16(0x1f6c), TO_S15D16(0x00e1),
> +               TO_S15D16(0x00e1), TO_S15D16(0x1f45), TO_S15D16(0x1fdc)
> +       },
> +       { 0x00, 0x00, 0x00 },
> +       { 0x0040, 0x0200, 0x0200 },
> +       { 0x000, 0x3ff, 0x000, 0x3ff, 0x000, 0x3ff },
> +       { 0x040, 0x3ac, 0x040, 0x3c0, 0x040, 0x3c0 },
> +};
> +
>  /**
>   * dpu_hw_get_csc_cfg - get the CSC matrix based on the request type
>   * @type:              type of the requested CSC matrix from caller
> @@ -133,6 +147,9 @@ const struct dpu_csc_cfg *dpu_hw_get_csc_cfg(enum dpu_hw_csc_cfg_type type)
>         case DPU_HW_YUV2RGB_601L_10BIT:
>                 csc_cfg = &dpu_csc10_YUV2RGB_601L;
>                 break;
> +       case DPU_HW_RGB2YUV_601L_10BIT:
> +               csc_cfg = &dpu_csc10_rgb2yuv_601l;
> +               break;
>         default:
>                 DPU_ERROR("unknown csc_cfg type\n");
>                 break;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
> index 49f2bcf6de15..ed153d66f660 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
> @@ -22,6 +22,7 @@
>  enum dpu_hw_csc_cfg_type {
>         DPU_HW_YUV2RGB_601L,
>         DPU_HW_YUV2RGB_601L_10BIT,
> +       DPU_HW_RGB2YUV_601L_10BIT,
>  };
>
>  /*
> --
> 2.40.1
>


-- 
With best wishes
Dmitry
