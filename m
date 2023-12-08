Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9031080A95B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbjLHQij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjLHQii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:38:38 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49B9122
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:38:41 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-daf7ed42ea6so2425944276.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 08:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702053521; x=1702658321; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ji4v7G4p0p7zJuYWPDTvhXpo4RLr1EyE104kr2B7NEU=;
        b=Y2Xplz8cGAvN3xVfCf5cifvpXOe3rliMAXwYIXSwxTcCopavONuRthbP3iqw9XRXdq
         IXkpf2PdlQ7QNWJOZiNYDsdkv4JcoH/KrFfCHkSCIGdLsdg24S9WEif0cKd7UYfhTyFo
         ryMZ6361dcF84nMTxHfS9MEHf7xCS9i+ZThwfZEHbk/znhCRVZbsFp33ykwvazYveM7T
         7XvesMASbeXoKyO6TYAnXZR9WC06hQ/PR40NO6uXJAQFaYnU2V/yZbelzXv6KqJ48WEY
         rx3f+vQ7pl1Q/lOL7+or6jQreTM/rOIE1UXO/iBCA7fiqpR799xDfPdsSMsWzxEU9xIm
         Z7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702053521; x=1702658321;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ji4v7G4p0p7zJuYWPDTvhXpo4RLr1EyE104kr2B7NEU=;
        b=Mj37sUn/bZyxgTBDivQMGCxH5iPGDP+mOJo79xPXC6IEFqzbEWHYqik0qbTrzH6u4L
         vkRfF5/58B/JcyIhWsNmzHpD4u/KS+axAjKDvQx94m/4XJ0fXm9hGBznLVpc0xFNZlc5
         J0ZJMWJsNrO5xIfUu5pCbo8Pit4g9oo5e1eMcpQFtb7Z1JDb2eur1ks0UWLPfD9OiIUo
         rHSKHSNgDpijeOO9u1SH0Q4wsWgzFLDd9U06ZP+n+noRMoPqFR2MVKXncj3yy8IGGHQ7
         EUNp2mDv0pj+H+wOnfuUz2d4scJ+9O3KgA63ZKEBlfjJeMI1vtXWy6Q7hUHKf7oQeubu
         /oyA==
X-Gm-Message-State: AOJu0YyGSzxSuI1ANnzwjsFlQlMBGeDJxJguUeL/W2SdvaQy6r5uQOOB
        USZaFlhBWEihae4hy1zaTFpdugyuetc1owTXZQd9xw==
X-Google-Smtp-Source: AGHT+IEvYbq7K1eeqmyuZnnDkuzmbkh66toRMLSzb8ok2h+sAB1ZVWMOBC1b8B8acmgDXqymCAogc6DISZj4odbbYrc=
X-Received: by 2002:a25:b904:0:b0:d9b:2ca7:4cd8 with SMTP id
 x4-20020a25b904000000b00d9b2ca74cd8mr257694ybj.31.1702053520888; Fri, 08 Dec
 2023 08:38:40 -0800 (PST)
MIME-Version: 1.0
References: <20231208050641.32582-1-quic_abhinavk@quicinc.com>
 <20231208050641.32582-15-quic_abhinavk@quicinc.com> <CAA8EJpo4XVMJ7RqsZZ6Eh_PjoPeWiMmAW3P1a4dkZ_EHqz7GkQ@mail.gmail.com>
 <188e0168-a45b-6e38-ac49-8b0fd41e9110@quicinc.com>
In-Reply-To: <188e0168-a45b-6e38-ac49-8b0fd41e9110@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Dec 2023 18:38:30 +0200
Message-ID: <CAA8EJpoVfuybVPddKy2Sn-YsovkbiWmoNa48jKjdpKg4HiJaAg@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 at 18:34, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 12/8/2023 3:54 AM, Dmitry Baryshkov wrote:
> > On Fri, 8 Dec 2023 at 07:07, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >> Reserve CDM blocks for writeback if the format of the output fb
> >> is YUV. At the moment, the reservation is done only for writeback
> >> but can easily be extended by relaxing the checks once other
> >> interfaces are ready to output YUV.
> >>
> >> changes in v2:
> >>          - use needs_cdm from topology struct
> >>          - drop fb related checks from atomic_mode_set()
> >
> > It looks like this should be squashed with the patch 11. The 'unbind
> > CDM' doesn't really make sense without this patch. We need to allocate
> > it first,  before touching it.
> >
>
> The way I was thinking was that patch just completes the
> dpu_encoder_phys_cleanup() and yes it was intentionally kept ahead
> because that will not kick in till hw_cdm is assigned.
>
> Then, this patch only handles reserving/assignment of hw_cdm when needed.
>
> That was the motivation behind this split.

It leaves a leaf code that is not used at all. There is no need to
cleanup anything if it was not allocated. Please remove the split and
squash it with allocation.

>
> >>
> >> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >> ---
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 27 +++++++++++++++++++++
> >>   1 file changed, 27 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> >> index 862912727925..a576e3e62429 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> >> @@ -16,6 +16,7 @@
> >>   #include <drm/drm_crtc.h>
> >>   #include <drm/drm_file.h>
> >>   #include <drm/drm_probe_helper.h>
> >> +#include <drm/drm_framebuffer.h>
> >>
> >>   #include "msm_drv.h"
> >>   #include "dpu_kms.h"
> >> @@ -583,6 +584,7 @@ static int dpu_encoder_virt_atomic_check(
> >>          struct drm_display_mode *adj_mode;
> >>          struct msm_display_topology topology;
> >>          struct dpu_global_state *global_state;
> >> +       struct drm_framebuffer *fb;
> >>          struct drm_dsc_config *dsc;
> >>          int i = 0;
> >>          int ret = 0;
> >> @@ -623,6 +625,22 @@ static int dpu_encoder_virt_atomic_check(
> >>
> >>          topology = dpu_encoder_get_topology(dpu_enc, dpu_kms, adj_mode, crtc_state, dsc);
> >>
> >> +       /*
> >> +        * Use CDM only for writeback at the moment as other interfaces cannot handle it.
> >> +        * if writeback itself cannot handle cdm for some reason it will fail in its atomic_check()
> >> +        * earlier.
> >> +        */
> >> +       if (dpu_enc->disp_info.intf_type == INTF_WB && conn_state->writeback_job) {
> >> +               fb = conn_state->writeback_job->fb;
> >> +
> >> +               if (fb && DPU_FORMAT_IS_YUV(to_dpu_format(msm_framebuffer_format(fb))))
> >> +                       topology.needs_cdm = true;
> >> +               if (topology.needs_cdm && !dpu_enc->cur_master->hw_cdm)
> >> +                       crtc_state->mode_changed = true;
> >> +               else if (!topology.needs_cdm && dpu_enc->cur_master->hw_cdm)
> >> +                       crtc_state->mode_changed = true;
> >> +       }
> >> +
> >>          /*
> >>           * Release and Allocate resources on every modeset
> >>           * Dont allocate when active is false.
> >> @@ -1063,6 +1081,15 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
> >>
> >>          dpu_enc->dsc_mask = dsc_mask;
> >>
> >> +       if (dpu_enc->disp_info.intf_type == INTF_WB && conn_state->writeback_job) {
> >> +               struct dpu_hw_blk *hw_cdm = NULL;
> >> +
> >> +               dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
> >> +                                             drm_enc->base.id, DPU_HW_BLK_CDM,
> >> +                                             &hw_cdm, 1);
> >> +               dpu_enc->cur_master->hw_cdm = hw_cdm ? to_dpu_hw_cdm(hw_cdm) : NULL;
> >> +       }
> >> +
> >>          cstate = to_dpu_crtc_state(crtc_state);
> >>
> >>          for (i = 0; i < num_lm; i++) {
> >> --
> >> 2.40.1
> >>
> >
> >
> > --
> > With best wishes
> >
> > Dmitry



-- 
With best wishes
Dmitry
