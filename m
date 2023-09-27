Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C527B0DEA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 23:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjI0VMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 17:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0VMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:12:05 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2832811D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 14:12:03 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a1d0fee86aso78358367b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 14:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695849122; x=1696453922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2ulr/ud2ZR8TkPsZLrQkGRmXjkB0ruhgSgUZ4OJtSCM=;
        b=BbzTF8oSVE4N3/ztZngkpCng/FOm85b5IkeZ3x6OKpPHzQtsRtr0dfxSXxKNaNHNSn
         kp0L2jw78nxs8s/7zqRqPFoGsfA+rcGWMXDjRNyw+6m148snxIvEuIgk7lhNjaPAkH+p
         0IFHbM4TZhcHtXOeQNWTn8oo+Jg0/sa2AytuqMMrxXl/IcuOUYWGXWQtZIvfSqVWJWNM
         YmaO4awCRTO/jdsWpmzcxJSHW40yVBjuqwuQeESo6t0xIPRoOjDlegds2hIW/ACGJAGQ
         4tB6PTTYQlIUd/3Wxy/XXLZsn6gXO+ss6oYkp9YU3kgsjFLLUVneIs1ZxLHfQa1hwngC
         oeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695849122; x=1696453922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ulr/ud2ZR8TkPsZLrQkGRmXjkB0ruhgSgUZ4OJtSCM=;
        b=T/EyM5uDGLPwM5Vdl+ZVYSlT2Xu1eM78WHDLPyy8A0XSmzAH91M6Wzl96kqOna4XLP
         r4R0/u9Km/hbUyCVhhrl4wB7NDbXyI7oNBZ9ueTw5SxNyB5bJB8a9OR0/52E7BcHVnph
         kLOJYp5hPQa9Ib35NgNOOcyY5OYzjNivJtg2qsuzrYIbl1ubqWwdC/6aFR2V71lFmz7e
         BeieKMHcfOhGSg68ujsCWY+d+0QN5Dx6hB4pZj54e0c4mpGv6dwBva8NpxN//Afn72/X
         jErtTAlE5s0pmI2tfKZPwqCz0JkcPM0IGuBc7OWKCwKnUM7aX1beZor2sDKnTaYSw/k+
         AyZQ==
X-Gm-Message-State: AOJu0YywbPEUKsHsHl9QGa7NySaR7fXzK9cdA8vHlu+sytJEO7WUoZ6D
        OOS6Zl/Zp7m1Ybr6zEHJoE/8FBYUCJMIV8mXXMzgvA==
X-Google-Smtp-Source: AGHT+IFkoMgUwQA2ZaZOyNbJ0CTWZNjy/+dyqZUFOASnyQ/ixE3wdi6NP8eNzP/wzzUJRC5Yiv7Dp8dLvMuHHv9yRNc=
X-Received: by 2002:a81:52cf:0:b0:59f:52a1:254d with SMTP id
 g198-20020a8152cf000000b0059f52a1254dmr3526927ywb.2.1695849122335; Wed, 27
 Sep 2023 14:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <1695848028-18023-1-git-send-email-quic_khsieh@quicinc.com> <1695848028-18023-3-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1695848028-18023-3-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 28 Sep 2023 00:10:55 +0300
Message-ID: <CAA8EJprWiERuEbo9XHs9MSYa653E2cMf-cdFey0tZmyo3nFbMQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] drm/msm/dp: rename is_connected with link_ready
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sept 2023 at 23:54, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> The is_connected flag is set to true after DP mainlink successfully
> finishes link training to enter into ST_MAINLINK_READY state.

... rather than being set after the DP dongle is connected.

> Rename
> the is_connected flag with link_ready flag to match the state of DP
> driver's state machine.
>
> Changes in v4:
> -- reworded commit etxt

s/etxt/text/

>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 19 +++++++++----------
>  drivers/gpu/drm/msm/dp/dp_display.h |  2 +-
>  drivers/gpu/drm/msm/dp/dp_drm.c     | 14 +++++++-------
>  3 files changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 5645178..9cb5a5b 100644
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
> @@ -1350,16 +1349,16 @@ static int dp_pm_resume(struct device *dev)
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
> @@ -1752,8 +1751,8 @@ void dp_bridge_hpd_notify(struct drm_bridge *bridge,
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
