Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1727A5E6F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjISJpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjISJo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:44:56 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0900FF1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:44:50 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-59ed7094255so2933187b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695116689; x=1695721489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kJo8D8JWanSKhtAvp3wVew9z7mMntNBF78rt2N3S95c=;
        b=lFWBcpxIUP2fSTBlbTrIPi5hiymBIi5amdRAdE17kX2Ib2P4cDhNwn/ph5ZvIgsJtM
         CmbUd543Ot/90OicYer6Jy16CjgtFUUdWJJ3oj4VhK/0oRho6T6y8vKEQwRo/ggrnyNo
         ja9h/3KWGm8AT6ZTAVJwX0CqYvHi8xTONzd8mUBexfQU0Sr8ebUEeRT6oXys2omUpyYA
         Xh+BChx8IP0dH0YypXy9ACdQB+FpTMLPAVgUoxo1nLbJj4hbllOtJfQHD62QOlNEE476
         OErKa3nb4OcYBx09BWYUApTJNejS2OgVN4jmC5M4eX38dRsyyuiWl3poBxVF2q4pbj/6
         TMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695116689; x=1695721489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJo8D8JWanSKhtAvp3wVew9z7mMntNBF78rt2N3S95c=;
        b=IaToYR1fQxAAGC1bepi0gCQlqEXWN4nC0l8PRnHNLpGL9s4EdB7ilEO4UVEqkWmGWq
         fkaDwwINlliDNusYXP7Mz1LRAy4MncRbCUoX9Z0CL1im55SWKEDtx5K8q16Ff7ijzg0y
         ij5q28wiQfgGems6W/a9CmpDEXjREwGzK2CZhfflTx4TxSFT4fbi6jwWWqN0tXlCFW+3
         7kgNjqrQFDeQ9btb7HDRZ8rGEK1lLz81cxU0TcpmrSQEN2iLdWFYkOiljN4Tpxe6r16o
         zk+k6FODytaT89ag+x/SWndjTy9TZPhcPupe+p4VimY5Kuw9nENQyqtN2Rn9SQLTs7Vu
         KhEw==
X-Gm-Message-State: AOJu0YxWwsCNUVpYeVh6jkBAbin8ET99k14E7iL0zvKUxfVGtn1w1zpW
        mn1mxlTy5s+ItoAZhd0jynHZGUpIZOtUkDPY1uac1Q==
X-Google-Smtp-Source: AGHT+IENyn8VI3VAOno3vVbJ1bNqVaui83jdYwUQMKt0LOgHNtl5eLnB0nSX0Nl6ZAz1VNxEww1ovp95wTFVdQ2s8hs=
X-Received: by 2002:a0d:df43:0:b0:59a:b7b2:5f02 with SMTP id
 i64-20020a0ddf43000000b0059ab7b25f02mr13131931ywe.18.1695116689106; Tue, 19
 Sep 2023 02:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <1694813901-26952-1-git-send-email-quic_khsieh@quicinc.com>
 <1694813901-26952-3-git-send-email-quic_khsieh@quicinc.com>
 <CAA8EJprRrTW3pqmjVbfKG5t8t_QNGvPboETNgaAUxg3PvkRjcA@mail.gmail.com> <c1b816bc-4fee-338b-d066-6e6c528b5e3c@quicinc.com>
In-Reply-To: <c1b816bc-4fee-338b-d066-6e6c528b5e3c@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 19 Sep 2023 12:44:38 +0300
Message-ID: <CAA8EJppEJ_0JwVqRv+ue9kJRZhOdxXVnHe5G_ey-8eKZ9H23TQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sept 2023 at 20:09, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
>
> On 9/15/2023 6:51 PM, Dmitry Baryshkov wrote:
> > On Sat, 16 Sept 2023 at 00:38, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
> >> The is_connected flag is set to true after DP mainlink successfully
> >> finish link training. Replace the is_connected flag with link_ready
> > finishes.
> > Also this is not a replace, this patch renames the flag.
> yes, it is rename.
> >
> >> flag to avoid confusing.
> > confusing what with what?
>
> we have ST_MAINLINK_RAEDY state which means mainlink had finished link
> training and ready for video.
>
> Therefore I think link_ready is more meaningful than is_connected.

Guess, all this should have been in the commit message.

>
>
> >
> >> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> >> ---
> >>   drivers/gpu/drm/msm/dp/dp_display.c | 19 +++++++++----------
> >>   drivers/gpu/drm/msm/dp/dp_display.h |  2 +-
> >>   drivers/gpu/drm/msm/dp/dp_drm.c     | 14 +++++++-------
> >>   3 files changed, 17 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> >> index c217430..18d16c7 100644
> >> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> >> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> >> @@ -367,12 +367,11 @@ static void dp_display_send_hpd_event(struct msm_dp *dp_display)
> >>          drm_helper_hpd_irq_event(connector->dev);
> >>   }
> >>
> >> -
> >>   static int dp_display_send_hpd_notification(struct dp_display_private *dp,
> >>                                              bool hpd)
> >>   {
> >> -       if ((hpd && dp->dp_display.is_connected) ||
> >> -                       (!hpd && !dp->dp_display.is_connected)) {
> >> +       if ((hpd && dp->dp_display.link_ready) ||
> >> +                       (!hpd && !dp->dp_display.link_ready)) {
> >>                  drm_dbg_dp(dp->drm_dev, "HPD already %s\n",
> >>                                  (hpd ? "on" : "off"));
> >>                  return 0;
> >> @@ -382,7 +381,7 @@ static int dp_display_send_hpd_notification(struct dp_display_private *dp,
> >>          if (!hpd)
> >>                  dp->panel->video_test = false;
> >>
> >> -       dp->dp_display.is_connected = hpd;
> >> +       dp->dp_display.link_ready = hpd;
> >>
> >>          drm_dbg_dp(dp->drm_dev, "type=%d hpd=%d\n",
> >>                          dp->dp_display.connector_type, hpd);
> >> @@ -922,7 +921,7 @@ int dp_display_set_plugged_cb(struct msm_dp *dp_display,
> >>
> >>          dp_display->plugged_cb = fn;
> >>          dp_display->codec_dev = codec_dev;
> >> -       plugged = dp_display->is_connected;
> >> +       plugged = dp_display->link_ready;
> >>          dp_display_handle_plugged_change(dp_display, plugged);
> >>
> >>          return 0;
> >> @@ -1352,16 +1351,16 @@ static int dp_pm_resume(struct device *dev)
> >>           * also only signal audio when disconnected
> >>           */
> >>          if (dp->link->sink_count) {
> >> -               dp->dp_display.is_connected = true;
> >> +               dp->dp_display.link_ready = true;
> >>          } else {
> >> -               dp->dp_display.is_connected = false;
> >> +               dp->dp_display.link_ready = false;
> >>                  dp_display_handle_plugged_change(dp_display, false);
> >>          }
> >>
> >>          drm_dbg_dp(dp->drm_dev,
> >>                  "After, type=%d sink=%d conn=%d core_init=%d phy_init=%d power=%d\n",
> >>                  dp->dp_display.connector_type, dp->link->sink_count,
> >> -               dp->dp_display.is_connected, dp->core_initialized,
> >> +               dp->dp_display.link_ready, dp->core_initialized,
> >>                  dp->phy_initialized, dp_display->power_on);
> >>
> >>          mutex_unlock(&dp->event_mutex);
> >> @@ -1754,8 +1753,8 @@ void dp_bridge_hpd_notify(struct drm_bridge *bridge,
> >>                  return;
> >>          }
> >>
> >> -       if (!dp_display->is_connected && status == connector_status_connected)
> >> +       if (!dp_display->link_ready && status == connector_status_connected)
> >>                  dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
> >> -       else if (dp_display->is_connected && status == connector_status_disconnected)
> >> +       else if (dp_display->link_ready && status == connector_status_disconnected)
> >>                  dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
> >>   }
> >> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> >> index b3c08de..d65693e 100644
> >> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> >> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> >> @@ -16,7 +16,7 @@ struct msm_dp {
> >>          struct drm_bridge *bridge;
> >>          struct drm_connector *connector;
> >>          struct drm_bridge *next_bridge;
> >> -       bool is_connected;
> >> +       bool link_ready;
> >>          bool audio_enabled;
> >>          bool power_on;
> >>          unsigned int connector_type;
> >> diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
> >> index 785d766..ee945ca 100644
> >> --- a/drivers/gpu/drm/msm/dp/dp_drm.c
> >> +++ b/drivers/gpu/drm/msm/dp/dp_drm.c
> >> @@ -24,10 +24,10 @@ static enum drm_connector_status dp_bridge_detect(struct drm_bridge *bridge)
> >>
> >>          dp = to_dp_bridge(bridge)->dp_display;
> >>
> >> -       drm_dbg_dp(dp->drm_dev, "is_connected = %s\n",
> >> -               (dp->is_connected) ? "true" : "false");
> >> +       drm_dbg_dp(dp->drm_dev, "link_ready = %s\n",
> >> +               (dp->link_ready) ? "true" : "false");
> >>
> >> -       return (dp->is_connected) ? connector_status_connected :
> >> +       return (dp->link_ready) ? connector_status_connected :
> >>                                          connector_status_disconnected;
> >>   }
> >>
> >> @@ -40,8 +40,8 @@ static int dp_bridge_atomic_check(struct drm_bridge *bridge,
> >>
> >>          dp = to_dp_bridge(bridge)->dp_display;
> >>
> >> -       drm_dbg_dp(dp->drm_dev, "is_connected = %s\n",
> >> -               (dp->is_connected) ? "true" : "false");
> >> +       drm_dbg_dp(dp->drm_dev, "link_ready = %s\n",
> >> +               (dp->link_ready) ? "true" : "false");
> >>
> >>          /*
> >>           * There is no protection in the DRM framework to check if the display
> >> @@ -55,7 +55,7 @@ static int dp_bridge_atomic_check(struct drm_bridge *bridge,
> >>           * After that this piece of code can be removed.
> >>           */
> >>          if (bridge->ops & DRM_BRIDGE_OP_HPD)
> >> -               return (dp->is_connected) ? 0 : -ENOTCONN;
> >> +               return (dp->link_ready) ? 0 : -ENOTCONN;
> >>
> >>          return 0;
> >>   }
> >> @@ -78,7 +78,7 @@ static int dp_bridge_get_modes(struct drm_bridge *bridge, struct drm_connector *
> >>          dp = to_dp_bridge(bridge)->dp_display;
> >>
> >>          /* pluggable case assumes EDID is read when HPD */
> >> -       if (dp->is_connected) {
> >> +       if (dp->link_ready) {
> >>                  rc = dp_display_get_modes(dp);
> >>                  if (rc <= 0) {
> >>                          DRM_ERROR("failed to get DP sink modes, rc=%d\n", rc);
> >> --
> >> 2.7.4
> >>
> >



-- 
With best wishes
Dmitry
