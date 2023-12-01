Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20AE8005C3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377859AbjLAIgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377871AbjLAIgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:36:07 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354101713
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 00:36:13 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5d35a952943so15894107b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 00:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701419772; x=1702024572; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MtZ5IdIBvkCmVfZiZm9xTlVCWifoa/NZ8bzDIOX3Xng=;
        b=xSwQCRC7PH8wFmk/UNhjZkE8PNx2np2UEe7CzCaKnnAfOoQehaiA/Hk8V1XWWlV0Du
         TnRWR4jRf+FHaqr+dAajnJRiTdMNwoR9uFayO2gOZSLfp8bIm4z7dCU+uVEsN1VbHsIT
         FOFenQgaj8H2u/EmyhopciloKEPqm10zGWc3SwUCpg068xb3slTHjf+6oxM1/D+8o9fo
         EUE5bAeYmqukUj0IDnvjrNUHioFBs/AKO1QYwkKppsBR8fW67KHdTpQbeExu/8gZvLvU
         xXvIOWQ/VIy0P71mZmdcZAq7JDCgDWCqt1cYGqoor+NzMOJaM+4aNbl0hr7PeYAxG0Wd
         M91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701419772; x=1702024572;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MtZ5IdIBvkCmVfZiZm9xTlVCWifoa/NZ8bzDIOX3Xng=;
        b=lvpR/jyO41C9FzHaiTSH3yXaMz08D/ZI4or3Sm7seTCQNvSyOFjI6WFO6KOuTW9/Bh
         7gkxS/aed+2DDpeQ4bZRk1judVzeak1cARh3qi4IZlKZ3aZgOkiDf9k9aguz1M/fUTnB
         eW2jspdjTju956g2CmTh4cPpfIorgQ/NUrkbuQJ2Pogab6yM7i5hYN9iWfStFzD0/Bcb
         p87hLA/B/yeGoI0MUx3dplZ50cEhUmmNIwo1QAI0MRC8oIOk/TsdiEcEaqXXoY+CyhfZ
         CJ3Cg4c55yuP8SZ5vph6B9KsZep0UM4vn6gZ9XyaCtGTar9QeAUmTZNm1xXucFCvHbFN
         Vnaw==
X-Gm-Message-State: AOJu0YwWhUlXI+YSSBf6tfnrXKOMnk92te5ROCGOE1hvfMNjLhc/siQT
        q0/ie7joGpX3INoSTwEuekcf6rG/YOoW/LlEOnyYtw==
X-Google-Smtp-Source: AGHT+IFMKwL0EhOV6pMJyoqRG37zW+mNZpW1h9u5bFubBHrQFVO1YAmlDYEKlF7TviFe0+hAEAjElbTHB1G3GbvZyuA=
X-Received: by 2002:a81:4e86:0:b0:5d3:ba75:758d with SMTP id
 c128-20020a814e86000000b005d3ba75758dmr3335760ywb.2.1701419772391; Fri, 01
 Dec 2023 00:36:12 -0800 (PST)
MIME-Version: 1.0
References: <20230830224910.8091-1-quic_abhinavk@quicinc.com>
 <20230830224910.8091-11-quic_abhinavk@quicinc.com> <CAA8EJpoUDjTEytGnx0NUKD_grY=azoXgm_sqwNBJVTD7LwCe0g@mail.gmail.com>
 <5c16e398-4010-718b-d91d-5fc3781b9c0a@quicinc.com>
In-Reply-To: <5c16e398-4010-718b-d91d-5fc3781b9c0a@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 1 Dec 2023 10:36:01 +0200
Message-ID: <CAA8EJpob=mmo1LsyOydMV8RTChYA5P41s1H4xfxkqjRLBWscwQ@mail.gmail.com>
Subject: Re: [PATCH 10/16] drm/msm/dpu: add support to disable CDM block
 during encoder cleanup
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, quic_khsieh@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, 1 Dec 2023 at 01:58, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 8/30/2023 5:14 PM, Dmitry Baryshkov wrote:
> > On Thu, 31 Aug 2023 at 01:50, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >> In preparation of setting up CDM block, add the logic to disable it
> >> properly during encoder cleanup.
> >>
> >> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >> ---
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c      | 8 ++++++++
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h | 2 ++
> >>   2 files changed, 10 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> >> index 582680804016..1b1e07292a9e 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> >> @@ -26,6 +26,7 @@
> >>   #include "dpu_hw_dspp.h"
> >>   #include "dpu_hw_dsc.h"
> >>   #include "dpu_hw_merge3d.h"
> >> +#include "dpu_hw_cdm.h"
> >>   #include "dpu_formats.h"
> >>   #include "dpu_encoder_phys.h"
> >>   #include "dpu_crtc.h"
> >> @@ -2097,6 +2098,13 @@ void dpu_encoder_helper_phys_cleanup(struct dpu_encoder_phys *phys_enc)
> >>                                          phys_enc->hw_pp->merge_3d->idx);
> >>          }
> >>
> >> +       if (phys_enc->hw_cdm && phys_enc->hw_cdm->ops.bind_pingpong_blk && phys_enc->hw_pp) {
> >> +               phys_enc->hw_cdm->ops.bind_pingpong_blk(phys_enc->hw_cdm,
> >> +                                                       false, phys_enc->hw_pp->idx);
> >
> > But it was already bound in the cdm->enable, wasn't it?

Yes :-(

> >
>
> This is disable. I think you missed the "false" parameter.
>
> > Also the update_pending_flush_cdm should be called even for DPU < 5.0,
> > where there should be no bind_pingpong_blk callback.
> >
>
> Ack. This is a good catch!
>
> >> +               if (phys_enc->hw_ctl->ops.update_pending_flush_cdm)
> >> +                       phys_enc->hw_ctl->ops.update_pending_flush_cdm(phys_enc->hw_ctl);
> >> +       }
> >> +
> >>          if (dpu_enc->dsc) {
> >>                  dpu_encoder_unprep_dsc(dpu_enc);
> >>                  dpu_enc->dsc = NULL;
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> >> index 24dbc28be4f8..510c1c41ddbc 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> >> @@ -150,6 +150,7 @@ enum dpu_intr_idx {
> >>    * @hw_pp:             Hardware interface to the ping pong registers
> >>    * @hw_intf:           Hardware interface to the intf registers
> >>    * @hw_wb:             Hardware interface to the wb registers
> >> + * @hw_cdm:            Hardware interface to the CDM registers
> >>    * @dpu_kms:           Pointer to the dpu_kms top level
> >>    * @cached_mode:       DRM mode cached at mode_set time, acted on in enable
> >>    * @enabled:           Whether the encoder has enabled and running a mode
> >> @@ -178,6 +179,7 @@ struct dpu_encoder_phys {
> >>          struct dpu_hw_pingpong *hw_pp;
> >>          struct dpu_hw_intf *hw_intf;
> >>          struct dpu_hw_wb *hw_wb;
> >> +       struct dpu_hw_cdm *hw_cdm;
> >>          struct dpu_kms *dpu_kms;
> >>          struct drm_display_mode cached_mode;
> >>          enum dpu_enc_split_role split_role;
> >> --
> >> 2.40.1
> >>
> >
> >



-- 
With best wishes
Dmitry
