Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF407A2D2A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 03:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbjIPBwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 21:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbjIPBvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 21:51:53 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDB6189
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 18:51:47 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d81b42a3108so1841454276.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 18:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694829107; x=1695433907; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eqNQwvCRvzhNFUM4Xk8w/poEBc9Vi+BUYPDpyIE14H8=;
        b=evwTPgVJ75kR22IL5iQ54QCiN4G2L9Ovz31MyDzjxNQpJr5zVyqNFhVghCW+kHT/bq
         WQD7B0DM4/K327tCJrhrGTEELvwv9LbiFSdLXN3lLMwbMmG/P6vpp6LUxuW4XEJ6nzAH
         KFjoAAIwmFoEy3AEXq171Q4O6WZKbRB8R4iEE6BmOWFFKTh2RQ/py++ivxZWVGf4Uxdf
         qQKZA4j9+phcWL28O4udwynsUI/vF1Ln6BT4+GhzPzkvxpB8wzSKWqBS4enVSiIv90Yl
         YZR0L6/MZjYTHtruYE3LlbSHgLH3NQRpNOIrnSFpPtCSXH110Zbjrg4f/8YeMcpw+ras
         UT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694829107; x=1695433907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqNQwvCRvzhNFUM4Xk8w/poEBc9Vi+BUYPDpyIE14H8=;
        b=DH4Fky+BQ6/Dxg178NcVmGrghFwzrJHVzx583Cpwx86S5eTAWh18M/xv5oRLnqOw3y
         nfGo+yYFiILzl4bBpxVLXqJ4uIlueUMf7PfpBSny4PDWCHQaOhZ5HL6kUjzb9QVyyqbd
         Nk/PM/EjyO17XWNQUakkrNqBMV12OC8m1YW5pj5MiII6CmxGePJOktej1vWFtKGT9GxX
         dIren4uQhKWP06b4eUU3MXQSouEeqFrzltRsK3GsC2QkUdVziFaUrauu8gVAg/6v2nnK
         R0Pj/UYYVGlDTlz380t70pIEP1NdP7M2wl9G/jRJehwAWX0+bZLlSXjrD9Qcp+MhTg9y
         3DYw==
X-Gm-Message-State: AOJu0YzhST//ZVRwe/RR19vFCHFxMUC3+dKu6m+viH1CyWgbtilGK7J/
        nLkCRBC4YPZ2ZLkzTSc8oos9JL21drvkLyg4h1PmBg==
X-Google-Smtp-Source: AGHT+IG71idRyutnZFqe2Q+EcTypw3iqJoSMsXZ5Cl3htTxCNf0SRBSzc4iZj/PuWdGVOHoBt8xeITM4p606svQV468=
X-Received: by 2002:a25:e644:0:b0:d0a:fbef:1590 with SMTP id
 d65-20020a25e644000000b00d0afbef1590mr2856112ybh.37.1694829106986; Fri, 15
 Sep 2023 18:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <1694813901-26952-1-git-send-email-quic_khsieh@quicinc.com> <1694813901-26952-3-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1694813901-26952-3-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 16 Sep 2023 04:51:36 +0300
Message-ID: <CAA8EJprRrTW3pqmjVbfKG5t8t_QNGvPboETNgaAUxg3PvkRjcA@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] drm/msm/dp: replace is_connected with link_ready
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
> The is_connected flag is set to true after DP mainlink successfully
> finish link training. Replace the is_connected flag with link_ready

finishes.
Also this is not a replace, this patch renames the flag.

> flag to avoid confusing.

confusing what with what?

>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 19 +++++++++----------
>  drivers/gpu/drm/msm/dp/dp_display.h |  2 +-
>  drivers/gpu/drm/msm/dp/dp_drm.c     | 14 +++++++-------
>  3 files changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index c217430..18d16c7 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -367,12 +367,11 @@ static void dp_display_send_hpd_event(struct msm_dp *dp_display)
>         drm_helper_hpd_irq_event(connector->dev);
>  }
>
> -
>  static int dp_display_send_hpd_notification(struct dp_display_private *dp,
>                                             bool hpd)
>  {
> -       if ((hpd && dp->dp_display.is_connected) ||
> -                       (!hpd && !dp->dp_display.is_connected)) {
> +       if ((hpd && dp->dp_display.link_ready) ||
> +                       (!hpd && !dp->dp_display.link_ready)) {
>                 drm_dbg_dp(dp->drm_dev, "HPD already %s\n",
>                                 (hpd ? "on" : "off"));
>                 return 0;
> @@ -382,7 +381,7 @@ static int dp_display_send_hpd_notification(struct dp_display_private *dp,
>         if (!hpd)
>                 dp->panel->video_test = false;
>
> -       dp->dp_display.is_connected = hpd;
> +       dp->dp_display.link_ready = hpd;
>
>         drm_dbg_dp(dp->drm_dev, "type=%d hpd=%d\n",
>                         dp->dp_display.connector_type, hpd);
> @@ -922,7 +921,7 @@ int dp_display_set_plugged_cb(struct msm_dp *dp_display,
>
>         dp_display->plugged_cb = fn;
>         dp_display->codec_dev = codec_dev;
> -       plugged = dp_display->is_connected;
> +       plugged = dp_display->link_ready;
>         dp_display_handle_plugged_change(dp_display, plugged);
>
>         return 0;
> @@ -1352,16 +1351,16 @@ static int dp_pm_resume(struct device *dev)
>          * also only signal audio when disconnected
>          */
>         if (dp->link->sink_count) {
> -               dp->dp_display.is_connected = true;
> +               dp->dp_display.link_ready = true;
>         } else {
> -               dp->dp_display.is_connected = false;
> +               dp->dp_display.link_ready = false;
>                 dp_display_handle_plugged_change(dp_display, false);
>         }
>
>         drm_dbg_dp(dp->drm_dev,
>                 "After, type=%d sink=%d conn=%d core_init=%d phy_init=%d power=%d\n",
>                 dp->dp_display.connector_type, dp->link->sink_count,
> -               dp->dp_display.is_connected, dp->core_initialized,
> +               dp->dp_display.link_ready, dp->core_initialized,
>                 dp->phy_initialized, dp_display->power_on);
>
>         mutex_unlock(&dp->event_mutex);
> @@ -1754,8 +1753,8 @@ void dp_bridge_hpd_notify(struct drm_bridge *bridge,
>                 return;
>         }
>
> -       if (!dp_display->is_connected && status == connector_status_connected)
> +       if (!dp_display->link_ready && status == connector_status_connected)
>                 dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
> -       else if (dp_display->is_connected && status == connector_status_disconnected)
> +       else if (dp_display->link_ready && status == connector_status_disconnected)
>                 dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
>  }
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index b3c08de..d65693e 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -16,7 +16,7 @@ struct msm_dp {
>         struct drm_bridge *bridge;
>         struct drm_connector *connector;
>         struct drm_bridge *next_bridge;
> -       bool is_connected;
> +       bool link_ready;
>         bool audio_enabled;
>         bool power_on;
>         unsigned int connector_type;
> diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
> index 785d766..ee945ca 100644
> --- a/drivers/gpu/drm/msm/dp/dp_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_drm.c
> @@ -24,10 +24,10 @@ static enum drm_connector_status dp_bridge_detect(struct drm_bridge *bridge)
>
>         dp = to_dp_bridge(bridge)->dp_display;
>
> -       drm_dbg_dp(dp->drm_dev, "is_connected = %s\n",
> -               (dp->is_connected) ? "true" : "false");
> +       drm_dbg_dp(dp->drm_dev, "link_ready = %s\n",
> +               (dp->link_ready) ? "true" : "false");
>
> -       return (dp->is_connected) ? connector_status_connected :
> +       return (dp->link_ready) ? connector_status_connected :
>                                         connector_status_disconnected;
>  }
>
> @@ -40,8 +40,8 @@ static int dp_bridge_atomic_check(struct drm_bridge *bridge,
>
>         dp = to_dp_bridge(bridge)->dp_display;
>
> -       drm_dbg_dp(dp->drm_dev, "is_connected = %s\n",
> -               (dp->is_connected) ? "true" : "false");
> +       drm_dbg_dp(dp->drm_dev, "link_ready = %s\n",
> +               (dp->link_ready) ? "true" : "false");
>
>         /*
>          * There is no protection in the DRM framework to check if the display
> @@ -55,7 +55,7 @@ static int dp_bridge_atomic_check(struct drm_bridge *bridge,
>          * After that this piece of code can be removed.
>          */
>         if (bridge->ops & DRM_BRIDGE_OP_HPD)
> -               return (dp->is_connected) ? 0 : -ENOTCONN;
> +               return (dp->link_ready) ? 0 : -ENOTCONN;
>
>         return 0;
>  }
> @@ -78,7 +78,7 @@ static int dp_bridge_get_modes(struct drm_bridge *bridge, struct drm_connector *
>         dp = to_dp_bridge(bridge)->dp_display;
>
>         /* pluggable case assumes EDID is read when HPD */
> -       if (dp->is_connected) {
> +       if (dp->link_ready) {
>                 rc = dp_display_get_modes(dp);
>                 if (rc <= 0) {
>                         DRM_ERROR("failed to get DP sink modes, rc=%d\n", rc);
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
