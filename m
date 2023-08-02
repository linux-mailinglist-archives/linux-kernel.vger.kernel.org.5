Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E21176D6B7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjHBSVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjHBSU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:20:59 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0417219A8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 11:20:58 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-c5f98fc4237so89345276.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691000457; x=1691605257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Homk9fjzMS9bRt7+JLpaV1MTVogVxSAQQC2/ioeMDYs=;
        b=cglIoM6sjH+zBmascjr/gM8vL+7gGGCZUdjV7mtnF4yV93Ty1l53erEyXgHv12bEbu
         pGBzH8Vc+EfShQRn+4dhoS9n8u3BWsfRj1iPSR1StLh7wfqj9zBS2BxrpS159whlJxnS
         7igu1uBdIQZmyX5FUSm95WTDBuA+DQdQzA88TLo0kFBaqvp/39CX+1885MQbkKmumIyj
         N+bjctQEtPoHBBKONrWT37KN+X0+n3X47G50DXRFIbP+oEZLc2mQeBeDdEjcL1DcqUE7
         /HUW1SKIx1jsTQnc2UrbYAq2Q55WP63D25gB0VeIzPVYByqE1SPvhEodu0WjfvK94SiF
         SbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691000457; x=1691605257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Homk9fjzMS9bRt7+JLpaV1MTVogVxSAQQC2/ioeMDYs=;
        b=P7ZhSk3SlzrxvR2urR7SkNJTxdVJr0Vwj/QpUAY8MQJF+XR94lKrmtdGSGgW0dnLKn
         Yvpeg5oRfyJV0bpyO6AM06cdVrTjgmujUHvS5eUMvIRArwknTZUTEKo8B+vREwxWOA1q
         RTTiwqWX4k56A608rAdr9tYfkfserCMvb6IkqPHOczwb85I+qjxbJQCF/Satm4IGdOcT
         dAbEJOvDjWwzyy9mzGIPUNDKkUeGa8YVUF0Xy9XPRF47BSXpF/ZUjOzZLHD4lhintZv0
         NwC8TsZh4zwLTnI2Db5l9FeXADtw8qpFZ0BvqdsbdIQhctExB47+L0h33mSGEhVLPNvJ
         OQ6w==
X-Gm-Message-State: ABy/qLb0je7N8z2EoRmduBz2U3hOceXJWYw4x+gpEMqpDg3HX2pqLsho
        QiDA5irDU6y9ToX/Vku/EuuUDjlGucnbevdUIdr59w==
X-Google-Smtp-Source: APBJJlGdRkk9ZTw77IAlIa2EQ5+EbP7+f/MNQsqxMuzb2A7BYiWokn6e+q+V79qBOo+lQb7f/hDZkW2TA/vLhi6yLSY=
X-Received: by 2002:a25:4d87:0:b0:d35:7c2a:e912 with SMTP id
 a129-20020a254d87000000b00d357c2ae912mr6332121ybb.3.1691000457217; Wed, 02
 Aug 2023 11:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230802-add-widebus-support-v3-0-2661706be001@quicinc.com> <20230802-add-widebus-support-v3-2-2661706be001@quicinc.com>
In-Reply-To: <20230802-add-widebus-support-v3-2-2661706be001@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 2 Aug 2023 21:20:46 +0300
Message-ID: <CAA8EJpoPd_T+vLVrJ6RpCrYY6H1xLF4eFYVGV4N-wS3g+5cR-w@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] drm/msm/dpu: Enable widebus for DSI INTF
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, quic_abhinavk@quicinc.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023 at 21:09, Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
>
> DPU supports a data-bus widen mode for DSI INTF.
>
> Enable this mode for all supported chipsets if widebus is enabled for DSI.
>
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c          | 11 ++++++++---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c |  4 +++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c          |  3 +++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h          |  1 +
>  drivers/gpu/drm/msm/msm_drv.h                        |  6 +++++-
>  5 files changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 3dcd37c48aac..de08aad39e15 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -1196,15 +1196,20 @@ static void dpu_encoder_virt_atomic_enable(struct drm_encoder *drm_enc,
>         struct drm_display_mode *cur_mode = NULL;
>         struct msm_drm_private *priv = drm_enc->dev->dev_private;
>         struct msm_display_info *disp_info;
> +       int index;
>
>         dpu_enc = to_dpu_encoder_virt(drm_enc);
>         disp_info = &dpu_enc->disp_info;
>
> +       disp_info = &dpu_enc->disp_info;
> +       index = disp_info->h_tile_instance[0];
> +
>         dpu_enc->dsc = dpu_encoder_get_dsc_config(drm_enc);
>
> -       if (disp_info->intf_type == INTF_DP)
> -               dpu_enc->wide_bus_en = msm_dp_wide_bus_available(
> -                               priv->dp[disp_info->h_tile_instance[0]]);
> +       if (disp_info->intf_type == INTF_DSI)
> +               dpu_enc->wide_bus_en = msm_dsi_is_widebus_enabled(priv->dsi[index]);
> +       else if (disp_info->intf_type == INTF_DP)
> +               dpu_enc->wide_bus_en = msm_dp_wide_bus_available(priv->dp[index]);

If you change the order, you won't have to touch DP lines.

>
>         mutex_lock(&dpu_enc->enc_lock);
>         cur_mode = &dpu_enc->base.crtc->state->adjusted_mode;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> index df88358e7037..dace6168be2d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> @@ -69,8 +69,10 @@ static void _dpu_encoder_phys_cmd_update_intf_cfg(
>                                 phys_enc->hw_intf,
>                                 phys_enc->hw_pp->idx);
>
> -       if (intf_cfg.dsc != 0)
> +       if (intf_cfg.dsc != 0) {
>                 cmd_mode_cfg.data_compress = true;
> +               cmd_mode_cfg.wide_bus_en = dpu_encoder_is_widebus_enabled(phys_enc->parent);
> +       }

This embeds the knowledge that a wide bus can only be enabled when DSC
is in use. Please move the wide_bus_en assignment out of conditional
code.

>
>         if (phys_enc->hw_intf->ops.program_intf_cmd_cfg)
>                 phys_enc->hw_intf->ops.program_intf_cmd_cfg(phys_enc->hw_intf, &cmd_mode_cfg);
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> index 8ec6505d9e78..dc6f3febb574 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> @@ -521,6 +521,9 @@ static void dpu_hw_intf_program_intf_cmd_cfg(struct dpu_hw_intf *ctx,

This function is only enabled for DPU >= 7.0, while IIRC wide bus can
be enabled even for some of the earlier chipsets.

>         if (cmd_mode_cfg->data_compress)
>                 intf_cfg2 |= INTF_CFG2_DCE_DATA_COMPRESS;
>
> +       if (cmd_mode_cfg->wide_bus_en)
> +               intf_cfg2 |= INTF_CFG2_DATABUS_WIDEN;
> +
>         DPU_REG_WRITE(&ctx->hw, INTF_CONFIG2, intf_cfg2);
>  }
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> index 77f80531782b..c539025c418b 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> @@ -50,6 +50,7 @@ struct dpu_hw_intf_status {
>
>  struct dpu_hw_intf_cmd_mode_cfg {
>         u8 data_compress;       /* enable data compress between dpu and dsi */
> +       u8 wide_bus_en;         /* enable databus widen mode */
>  };
>
>  /**
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index 9d9d5e009163..e4f706b16aad 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -344,6 +344,7 @@ void msm_dsi_snapshot(struct msm_disp_state *disp_state, struct msm_dsi *msm_dsi
>  bool msm_dsi_is_cmd_mode(struct msm_dsi *msm_dsi);
>  bool msm_dsi_is_bonded_dsi(struct msm_dsi *msm_dsi);
>  bool msm_dsi_is_master_dsi(struct msm_dsi *msm_dsi);
> +bool msm_dsi_is_widebus_enabled(struct msm_dsi *msm_dsi);
>  struct drm_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi);
>  #else
>  static inline void __init msm_dsi_register(void)
> @@ -373,7 +374,10 @@ static inline bool msm_dsi_is_master_dsi(struct msm_dsi *msm_dsi)
>  {
>         return false;
>  }
> -
> +static inline bool msm_dsi_is_widebus_enabled(struct msm_dsi *msm_dsi)
> +{
> +       return false;
> +}

Empty line, please.

>  static inline struct drm_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi)
>  {
>         return NULL;
>
> --
> 2.41.0
>


-- 
With best wishes
Dmitry
