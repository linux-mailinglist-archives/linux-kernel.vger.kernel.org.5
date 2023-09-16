Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178307A2CE0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 03:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbjIPBK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 21:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238612AbjIPBKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 21:10:04 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F6899
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 18:09:59 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6c232d36da8so1429036a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 18:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694826599; x=1695431399; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g9WSRgTaw/6et2RmeGdNg8ZMy5I67EliZD9RP5+ifD0=;
        b=a5D/60narxBsKlknjap8GOTlEcsmg6KD4XxEtgqpK+FGOa4Odhz2ZvmlxTe0/k9e02
         TSjf5wMgbGrHhGAIgImd2rddpawYylbNMMi+1FuxToXbpZXxJ+MuwD87vNNpxeqc72iI
         iKGeVUtmApQ1cDjCl2PIqciI7bPjbPcY0rA9hNfCQ5VcIwBcxa1VTkWxesMyeTMfYX2p
         S1mOJcUrydy4DbPdPNAl5pCuBkQSZmMDZPEr9cn/J0Xfuf8+PvCd5SH9avwtSL2GnfYT
         MPl5HrCI2q+Ux9iABUfyyMzb/iRr4ehefNMyDH99LtPaeRa6AouUa7O+xM7RhXxqP6U/
         fLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694826599; x=1695431399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9WSRgTaw/6et2RmeGdNg8ZMy5I67EliZD9RP5+ifD0=;
        b=rcWQmzf1i5+hP1MkwpANBtqxrH6QCUDkxK7q7d2sXLtfE19O8MwKMTQ3zvSLx+sbzv
         qNm3NhkBFrHQN9gLirzWBoZ2xm+96DFMzQxnvLGFdnsS3AnUEjkDPL/6IXyegoXYkwsH
         hdpd9nf50+BMpqMNRtj7jDaeLFxebxCiy6IGWW5/vOcgpC/nT9TBIm9HDvY8oJbFiIb+
         KK6++6+TJOYjokKFlovkImiGsj9o/uEu2UZJxKuDczUvOgICoLLQRSWFB9q0WXplKAXA
         qHGXK/+Q+3FAOsZhfK4M9greMgXsfj7FxLrhhNyA7G5VHhXVVXQ6CQxrTXnzROJkM+N7
         teUQ==
X-Gm-Message-State: AOJu0Yzs48D+wC7GB030G0sPqgSl5CPkeZw0epDmYFoJ523e3gZ5LbvT
        aKKED71jkPiutFO5lzbtE/2KQrmSszTEMIuduRZvWw==
X-Google-Smtp-Source: AGHT+IGG3Egk3rmGcPDco6agP7soG2wHCQVK3RvI3bQXRv1/5cgN8gQV27Ug0GnSJl1EGWa4AgX6HemkpKSXYIpKq4s=
X-Received: by 2002:a05:6830:2008:b0:6b9:4d79:e08a with SMTP id
 e8-20020a056830200800b006b94d79e08amr3653815otp.32.1694826598950; Fri, 15 Sep
 2023 18:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <1694813901-26952-1-git-send-email-quic_khsieh@quicinc.com> <1694813901-26952-6-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1694813901-26952-6-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 16 Sep 2023 04:09:48 +0300
Message-ID: <CAA8EJprKA=H0iFOPKiotqQB-b5r4NYdEDdudzJeDU0qBxMkF_A@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] drm/msm/dp: delete EV_HPD_INIT_SETUP
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Sept 2023 at 00:38, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> EV_HPD_INIT_SETUP flag is used to trigger the initialization of external
> DP host controller. Since external DP host controller initialization had
> been incorporated into pm_runtime_resume(), this flag become obsolete.

became

> Lets get rid of it.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> Changes in v3:
> -- drop EV_HPD_INIT_SETUP and msm_dp_irq_postinstall()

This is not a changelog of the patch. It is a short description of the
patch itself. Please describe changes.

>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c |  4 ----
>  drivers/gpu/drm/msm/dp/dp_display.c     | 16 ----------------
>  drivers/gpu/drm/msm/msm_drv.h           |  5 -----
>  3 files changed, 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index aa8499d..71d0670 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -870,7 +870,6 @@ static int dpu_irq_postinstall(struct msm_kms *kms)
>  {
>         struct msm_drm_private *priv;
>         struct dpu_kms *dpu_kms = to_dpu_kms(kms);
> -       int i;
>
>         if (!dpu_kms || !dpu_kms->dev)
>                 return -EINVAL;
> @@ -879,9 +878,6 @@ static int dpu_irq_postinstall(struct msm_kms *kms)
>         if (!priv)
>                 return -EINVAL;
>
> -       for (i = 0; i < ARRAY_SIZE(priv->dp); i++)
> -               msm_dp_irq_postinstall(priv->dp[i]);
> -
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index e7af7f7..b6992202 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -55,7 +55,6 @@ enum {
>  enum {
>         EV_NO_EVENT,
>         /* hpd events */
> -       EV_HPD_INIT_SETUP,
>         EV_HPD_PLUG_INT,
>         EV_IRQ_HPD_INT,
>         EV_HPD_UNPLUG_INT,
> @@ -1092,8 +1091,6 @@ static int hpd_event_thread(void *data)
>                 spin_unlock_irqrestore(&dp_priv->event_lock, flag);
>
>                 switch (todo->event_id) {
> -               case EV_HPD_INIT_SETUP:
> -                       break;
>                 case EV_HPD_PLUG_INT:
>                         dp_hpd_plug_handle(dp_priv, todo->data);
>                         break;
> @@ -1469,19 +1466,6 @@ void __exit msm_dp_unregister(void)
>         platform_driver_unregister(&dp_display_driver);
>  }
>
> -void msm_dp_irq_postinstall(struct msm_dp *dp_display)
> -{
> -       struct dp_display_private *dp;
> -
> -       if (!dp_display)
> -               return;
> -
> -       dp = container_of(dp_display, struct dp_display_private, dp_display);
> -
> -       if (!dp_display->is_edp)
> -               dp_add_event(dp, EV_HPD_INIT_SETUP, 0, 0);
> -}
> -
>  bool msm_dp_wide_bus_available(const struct msm_dp *dp_display)
>  {
>         struct dp_display_private *dp;
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index e13a8cb..ff8be59 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -381,7 +381,6 @@ int __init msm_dp_register(void);
>  void __exit msm_dp_unregister(void);
>  int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
>                          struct drm_encoder *encoder);
> -void msm_dp_irq_postinstall(struct msm_dp *dp_display);
>  void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display);
>
>  void msm_dp_debugfs_init(struct msm_dp *dp_display, struct drm_minor *minor);
> @@ -402,10 +401,6 @@ static inline int msm_dp_modeset_init(struct msm_dp *dp_display,
>         return -EINVAL;
>  }
>
> -static inline void msm_dp_irq_postinstall(struct msm_dp *dp_display)
> -{
> -}
> -
>  static inline void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display)
>  {
>  }
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
