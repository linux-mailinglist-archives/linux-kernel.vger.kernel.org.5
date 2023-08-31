Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3725A78E3CF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 02:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345187AbjHaAOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 20:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345179AbjHaAOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 20:14:18 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97183CCF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:14:14 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d7260fae148so101665276.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693440854; x=1694045654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D0pDWt1SD7esxzH2zdhQyj7VibwqVSChN3krVpzS/9U=;
        b=IS6VpTMsruPxkECD3lP+JdoS3GTq7WRIJvkYVeUANjwVL5v81Kad6V5daVb+8dXub/
         lpKpnJCT7fUiIRgLQIKKfqpIKvjxg6fVqe0NOr1Xv4KOQPQ2xV+xrgAK/9N/Ak2Lv1b0
         YIgLrieSCs9tYWTWPywB0LhT/T6A9seSmT+8kZc0tGV6xFbG1Al9Y02LP4BTlF2Ui2TU
         H6QDMGX7Je4oYLUan9zdMi+Rsyk3mOLb6oGdi8OokAp9d6pt12NDSLE7UDKOQ2y7or4g
         Q6EwWRibHV434xCod+K4rnN1+xje8P1WwCdZomKRrciIs3W5tNVESOnXzkfUXp/6Vk3T
         JxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693440854; x=1694045654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0pDWt1SD7esxzH2zdhQyj7VibwqVSChN3krVpzS/9U=;
        b=CTfRae7lJL2WE2/rK3dEXcxgVhnMxb2/6lxxQvuwXhUxAM6kpcz6nTTXX4tfBTLsAK
         6BPkXBTVfezXtUIMPlJuPAHcpwED2kzBqJt9tiAfyvGHzXPs3Xao1dtvY2GSpudxMhRR
         FePggcr2N6xMSWfZxVPypDM/KXRT50jPl5bZ4pvL/Pm22578vSwWf8GEoJmNsCUpZCbO
         hMl29m7L1RO7qkz7pYcEbS5kc7j3a8CKcV95yYA1WWZvIufCn6WgxguwTJxlfjVYaud8
         GsQAS4TtxQlYf5AY2K2QDR+Ylsp+ejB1M1HkKgUNI2lpna6sAUkw7CXYyfkA5R4rTV4W
         g8IQ==
X-Gm-Message-State: AOJu0YxhkV3ROjYEIA1mEXf+9HoPPQpZSIg1183qOalzzKUkLW2glUv2
        bWkg4kHf8NLzKV9TclJ1zsNS7XoJHnjgQuHBcoR05g==
X-Google-Smtp-Source: AGHT+IGjdg7tdadLV979AxMh54I/iLzF7k+QaRxwagpvUswfd7y+PPMFv8JDlUgmVjXJDF1nrooGR2Tl0iBl51S6ohs=
X-Received: by 2002:a05:6902:562:b0:d15:e204:a7be with SMTP id
 a2-20020a056902056200b00d15e204a7bemr3876141ybt.8.1693440853738; Wed, 30 Aug
 2023 17:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230830224910.8091-1-quic_abhinavk@quicinc.com> <20230830224910.8091-11-quic_abhinavk@quicinc.com>
In-Reply-To: <20230830224910.8091-11-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 31 Aug 2023 03:14:02 +0300
Message-ID: <CAA8EJpoUDjTEytGnx0NUKD_grY=azoXgm_sqwNBJVTD7LwCe0g@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 01:50, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> In preparation of setting up CDM block, add the logic to disable it
> properly during encoder cleanup.
>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c      | 8 ++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h | 2 ++
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 582680804016..1b1e07292a9e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -26,6 +26,7 @@
>  #include "dpu_hw_dspp.h"
>  #include "dpu_hw_dsc.h"
>  #include "dpu_hw_merge3d.h"
> +#include "dpu_hw_cdm.h"
>  #include "dpu_formats.h"
>  #include "dpu_encoder_phys.h"
>  #include "dpu_crtc.h"
> @@ -2097,6 +2098,13 @@ void dpu_encoder_helper_phys_cleanup(struct dpu_encoder_phys *phys_enc)
>                                         phys_enc->hw_pp->merge_3d->idx);
>         }
>
> +       if (phys_enc->hw_cdm && phys_enc->hw_cdm->ops.bind_pingpong_blk && phys_enc->hw_pp) {
> +               phys_enc->hw_cdm->ops.bind_pingpong_blk(phys_enc->hw_cdm,
> +                                                       false, phys_enc->hw_pp->idx);

But it was already bound in the cdm->enable, wasn't it?

Also the update_pending_flush_cdm should be called even for DPU < 5.0,
where there should be no bind_pingpong_blk callback.

> +               if (phys_enc->hw_ctl->ops.update_pending_flush_cdm)
> +                       phys_enc->hw_ctl->ops.update_pending_flush_cdm(phys_enc->hw_ctl);
> +       }
> +
>         if (dpu_enc->dsc) {
>                 dpu_encoder_unprep_dsc(dpu_enc);
>                 dpu_enc->dsc = NULL;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> index 24dbc28be4f8..510c1c41ddbc 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> @@ -150,6 +150,7 @@ enum dpu_intr_idx {
>   * @hw_pp:             Hardware interface to the ping pong registers
>   * @hw_intf:           Hardware interface to the intf registers
>   * @hw_wb:             Hardware interface to the wb registers
> + * @hw_cdm:            Hardware interface to the CDM registers
>   * @dpu_kms:           Pointer to the dpu_kms top level
>   * @cached_mode:       DRM mode cached at mode_set time, acted on in enable
>   * @enabled:           Whether the encoder has enabled and running a mode
> @@ -178,6 +179,7 @@ struct dpu_encoder_phys {
>         struct dpu_hw_pingpong *hw_pp;
>         struct dpu_hw_intf *hw_intf;
>         struct dpu_hw_wb *hw_wb;
> +       struct dpu_hw_cdm *hw_cdm;
>         struct dpu_kms *dpu_kms;
>         struct drm_display_mode cached_mode;
>         enum dpu_enc_split_role split_role;
> --
> 2.40.1
>


-- 
With best wishes
Dmitry
