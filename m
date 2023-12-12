Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D6180E4E9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjLLHVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLLHVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:21:39 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AAFBC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 23:21:45 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d3c7ef7b31so51864597b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 23:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702365704; x=1702970504; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+hNGSAL4RNt6mo4iqM3CGVKIw9oVYy2WifrU+6CWjMM=;
        b=uHcnGbjUjA9b701VrskapEt+UVKfiPS8i2XJAIgTgDqs4BYXs6stOMxN23BlNavIEm
         1ikPrwTuHLPVhokJSRZaT+RPwvIXbwTJiUHbmnTsQS1Ck4UsIDNUuzO9jiQIhHpk4QqV
         +2uAW6EmmFKCUAXWUdnFUxiwT2YRSgf3fQWNYNPlP+KJ7OdeVrVBB+GoG0aieqkONa/b
         ThxcINqpTOT+EmQzi8boqii1bFmAPEhbsJH3cqTgD2FrB2bAUF6tGVQFXndFmR8WX1GS
         LJ7O7Ss+mIgHX5qVVYEMdioWZcf54f6zxgpAiExAOY96nq6eMm3Uw/CH836dkM1JudNG
         GXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702365704; x=1702970504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hNGSAL4RNt6mo4iqM3CGVKIw9oVYy2WifrU+6CWjMM=;
        b=B7cIVpOAik/RvgGRU7+FY1Av+Ws32cDIr7DT47iSmaPTuPZjGLG8isANUdb5W5uKlD
         bkhZmn9IMZAxA0kMNc95MJ7IthdsBZ8l7ijwb4AeSaxeHUDFG2ykYfWu752Dds6HPDoe
         1R86VkuigY0Pp56DzDV9lLgqdHTc0bYaZSvUWpNNbbMIq8Fm1vAnYDA/aulKCJaq4AIM
         HuLQwzC1SaWBKW133ILqafMqWcpkwn8gJEuCQADpaCpvugNB0JhnAWvv/2HCYUlThzXR
         smw4ySjtzKT3P1EGbNrkKln4HZwzR6TyD9Olg2n9pLxEH5Y4D8kEuPnget3b4Eb2sTm9
         0OAw==
X-Gm-Message-State: AOJu0YxEUc21h6H8dCyA1lQC9O09eBGpktVSdqWWoUnovbOHh9qC6id3
        jirLhaCxp2hbjH1ihvjyKXiG+7W5ikFilIvHlZKKtw==
X-Google-Smtp-Source: AGHT+IFa6zjT3OqIwi1hdiZ+G3kxAzDemjxb1B5hXWZ5mNcVTg3D2puvnshMyfcmW7JoTMA7CchGxUvXJa7nWrEfYqI=
X-Received: by 2002:a0d:d7cc:0:b0:5e1:9e32:2ab3 with SMTP id
 z195-20020a0dd7cc000000b005e19e322ab3mr1108823ywd.38.1702365704154; Mon, 11
 Dec 2023 23:21:44 -0800 (PST)
MIME-Version: 1.0
References: <20231212002245.23715-1-quic_abhinavk@quicinc.com> <20231212002245.23715-14-quic_abhinavk@quicinc.com>
In-Reply-To: <20231212002245.23715-14-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 12 Dec 2023 09:21:33 +0200
Message-ID: <CAA8EJprpMR20itGZU4Uu4j92UuWW+=X+pOj73YSpedn8kB7qSw@mail.gmail.com>
Subject: Re: [PATCH v3 13/15] drm/msm/dpu: reserve cdm blocks for writeback in
 case of YUV output
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, seanpaul@chromium.org,
        quic_jesszhan@quicinc.com, linux-arm-msm@vger.kernel.org,
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

On Tue, 12 Dec 2023 at 02:23, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Reserve CDM blocks for writeback if the format of the output fb
> is YUV. At the moment, the reservation is done only for writeback
> but can easily be extended by relaxing the checks once other
> interfaces are ready to output YUV.
>
> changes in v3:
>         - squash CDM disable during encoder cleanup into this change
>
> changes in v2:
>         - use needs_cdm from topology struct
>         - drop fb related checks from atomic_mode_set()
>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Minor nit below which I should probably handle while applying the patch.

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 37 +++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 889e9bb42715..989ee8c0e5b4 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -16,6 +16,7 @@
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_file.h>
>  #include <drm/drm_probe_helper.h>
> +#include <drm/drm_framebuffer.h>
>
>  #include "msm_drv.h"
>  #include "dpu_kms.h"
> @@ -26,6 +27,7 @@
>  #include "dpu_hw_dspp.h"
>  #include "dpu_hw_dsc.h"
>  #include "dpu_hw_merge3d.h"
> +#include "dpu_hw_cdm.h"
>  #include "dpu_formats.h"
>  #include "dpu_encoder_phys.h"
>  #include "dpu_crtc.h"
> @@ -582,6 +584,7 @@ static int dpu_encoder_virt_atomic_check(
>         struct drm_display_mode *adj_mode;
>         struct msm_display_topology topology;
>         struct dpu_global_state *global_state;
> +       struct drm_framebuffer *fb;
>         struct drm_dsc_config *dsc;
>         int i = 0;
>         int ret = 0;
> @@ -622,6 +625,22 @@ static int dpu_encoder_virt_atomic_check(
>
>         topology = dpu_encoder_get_topology(dpu_enc, dpu_kms, adj_mode, crtc_state, dsc);
>
> +       /*
> +        * Use CDM only for writeback at the moment as other interfaces cannot handle it.
> +        * if writeback itself cannot handle cdm for some reason it will fail in its atomic_check()
> +        * earlier.

What about s/handle/use/ ?

> +        */
> +       if (dpu_enc->disp_info.intf_type == INTF_WB && conn_state->writeback_job) {
> +               fb = conn_state->writeback_job->fb;
> +
> +               if (fb && DPU_FORMAT_IS_YUV(to_dpu_format(msm_framebuffer_format(fb))))
> +                       topology.needs_cdm = true;
> +               if (topology.needs_cdm && !dpu_enc->cur_master->hw_cdm)
> +                       crtc_state->mode_changed = true;
> +               else if (!topology.needs_cdm && dpu_enc->cur_master->hw_cdm)
> +                       crtc_state->mode_changed = true;
> +       }
> +
>         /*
>          * Release and Allocate resources on every modeset
>          * Dont allocate when active is false.
> @@ -1062,6 +1081,15 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
>
>         dpu_enc->dsc_mask = dsc_mask;
>
> +       if (dpu_enc->disp_info.intf_type == INTF_WB && conn_state->writeback_job) {
> +               struct dpu_hw_blk *hw_cdm = NULL;
> +
> +               dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
> +                                             drm_enc->base.id, DPU_HW_BLK_CDM,
> +                                             &hw_cdm, 1);
> +               dpu_enc->cur_master->hw_cdm = hw_cdm ? to_dpu_hw_cdm(hw_cdm) : NULL;
> +       }
> +
>         cstate = to_dpu_crtc_state(crtc_state);
>
>         for (i = 0; i < num_lm; i++) {
> @@ -2050,6 +2078,15 @@ void dpu_encoder_helper_phys_cleanup(struct dpu_encoder_phys *phys_enc)
>                                         phys_enc->hw_pp->merge_3d->idx);
>         }
>
> +       if (phys_enc->hw_cdm) {
> +               if (phys_enc->hw_cdm->ops.bind_pingpong_blk && phys_enc->hw_pp)
> +                       phys_enc->hw_cdm->ops.bind_pingpong_blk(phys_enc->hw_cdm,
> +                                                               PINGPONG_NONE);
> +               if (phys_enc->hw_ctl->ops.update_pending_flush_cdm)
> +                       phys_enc->hw_ctl->ops.update_pending_flush_cdm(phys_enc->hw_ctl,
> +                                                                      phys_enc->hw_cdm->idx);
> +       }
> +
>         if (dpu_enc->dsc) {
>                 dpu_encoder_unprep_dsc(dpu_enc);
>                 dpu_enc->dsc = NULL;
> --
> 2.40.1
>


-- 
With best wishes
Dmitry
