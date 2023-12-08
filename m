Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7165C80A2B8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573675AbjLHLyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbjLHLyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:54:21 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814861733
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:54:26 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5d34f8f211fso19037287b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 03:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702036465; x=1702641265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Y3Se1GcDGIbYUefqj6qyxR6DT7anpk4KRXh007rVt4=;
        b=ZWD0I1xhda3bgZeVhO5DkHJ5fqoBhorwYw8teZeGTVGf8DGUCY7PBUVyWDpLisb25k
         LJOrH3AbWyl7pv/lGDh+flelvSFCZfeReD718R4JRafpb0KWun+FIJ1r/eypXJn1mWz5
         MmKbMoxrG5+TVVqtDqj9kVACIk6FbYDELkWytL/Qibb0ymO1Pt/W6HN3o6Lpj47oRkv3
         wstfMLvYa+16dlSnmAh2r0HD8m7IwpWSUzpd38GYeUJfStynRcjbnu/ebeQ/9tgWIxAi
         5WvefV1W9IplrW+xuHyCwadTZYMhCzFYffzZtxUdhwq23fDy2Z2FGGNUMwAME52Vjlzq
         eVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702036465; x=1702641265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Y3Se1GcDGIbYUefqj6qyxR6DT7anpk4KRXh007rVt4=;
        b=gcLekD3T3T0QmGQujSsARvOdYaAwBZYEN8Si0pZJMxcPBjM/BBEN4Seek36W/D58Nv
         pbZc1ZrM0TJeAAdjWX6qZHgurR3l5PqjFEow1ALw0HL3ZXzQPqV0k7mVOsVhrc6eTnSk
         sqRxPXR5x+9ZReNTozn13fcTDEO9FYCw2gayKSx4pZmF23zzcedN0drVjhv/O952z69t
         jiHwTv/DU3YTtcSwAZEeRh5nBDMQsJ4imc88svtqtqPy+e6oMdYGS4sWtY1wdLdVbRUY
         cICYw3K/DF7m3eCAEH8ONN3a3mM9NFzVuTP6ITgSmU+nddrTzu+p934s1LEVRJNIv8KY
         8dfg==
X-Gm-Message-State: AOJu0Yws5sdNrgFy3YNWk1Zs8Z4CAwewc3bDsVdPqCe0WVhAiWrIFIJY
        dgMrnJ//+7Fx3nWN7aLZXfoUWxowjIieuP/Xq75J8w==
X-Google-Smtp-Source: AGHT+IEho6li6mBQtcvkKv7dl+SZrnSSWaZwoy9kNhdxT/+JJRDfIAUab3CIjuSQnHHcGRdbsl9H5uqFhk2EHSNzRws=
X-Received: by 2002:a81:4c86:0:b0:5d6:c21a:de9e with SMTP id
 z128-20020a814c86000000b005d6c21ade9emr3630952ywa.37.1702036465703; Fri, 08
 Dec 2023 03:54:25 -0800 (PST)
MIME-Version: 1.0
References: <20231208050641.32582-1-quic_abhinavk@quicinc.com> <20231208050641.32582-15-quic_abhinavk@quicinc.com>
In-Reply-To: <20231208050641.32582-15-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Dec 2023 13:54:13 +0200
Message-ID: <CAA8EJpo4XVMJ7RqsZZ6Eh_PjoPeWiMmAW3P1a4dkZ_EHqz7GkQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/16] drm/msm/dpu: reserve cdm blocks for writeback in
 case of YUV output
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
> Reserve CDM blocks for writeback if the format of the output fb
> is YUV. At the moment, the reservation is done only for writeback
> but can easily be extended by relaxing the checks once other
> interfaces are ready to output YUV.
>
> changes in v2:
>         - use needs_cdm from topology struct
>         - drop fb related checks from atomic_mode_set()

It looks like this should be squashed with the patch 11. The 'unbind
CDM' doesn't really make sense without this patch. We need to allocate
it first,  before touching it.

>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 27 +++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 862912727925..a576e3e62429 100644
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
> @@ -583,6 +584,7 @@ static int dpu_encoder_virt_atomic_check(
>         struct drm_display_mode *adj_mode;
>         struct msm_display_topology topology;
>         struct dpu_global_state *global_state;
> +       struct drm_framebuffer *fb;
>         struct drm_dsc_config *dsc;
>         int i = 0;
>         int ret = 0;
> @@ -623,6 +625,22 @@ static int dpu_encoder_virt_atomic_check(
>
>         topology = dpu_encoder_get_topology(dpu_enc, dpu_kms, adj_mode, crtc_state, dsc);
>
> +       /*
> +        * Use CDM only for writeback at the moment as other interfaces cannot handle it.
> +        * if writeback itself cannot handle cdm for some reason it will fail in its atomic_check()
> +        * earlier.
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
> @@ -1063,6 +1081,15 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
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
> --
> 2.40.1
>


--
With best wishes

Dmitry
