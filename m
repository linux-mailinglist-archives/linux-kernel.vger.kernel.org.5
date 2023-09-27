Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EA27B0EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjI0WBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjI0WBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:01:44 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9789710A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:01:42 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59e88a28b98so170793627b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695852102; x=1696456902; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DK2//dAy5K7j90PyspmllW/O9Qk44y8OxCULgT1tmAM=;
        b=JeJq7CMIUKLS4Y5iGQl72hJ6UaLMpBGUm2dGNiYRAD9xm2XArgxgwj05TfqMzZR7wb
         EV0u2MuBnIuEEhoEIyBrG3q1jBAbyDz1sE/lgBG7mndP4IQOzn9yYAa2kfqbDJf2PBuq
         MHxRkZoynikU+UpeKLxbV94ZUv9UmEGyoJNrUNyODy04nXxGAAlVUNOR4E4aA5EiMwdd
         6/EqqpsBAOWH8eXtBEoNqzAZCJ+aeLB1fGjxV2LjKLTi0acx6LYMwgGWzMr6GTzWmqwM
         gTIASpXEw6ultnudiXdh+5wLL4IugLxZQpMKvoaeYkvCWcw4dnv55bDYlcEBvhYthdCR
         fCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695852102; x=1696456902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DK2//dAy5K7j90PyspmllW/O9Qk44y8OxCULgT1tmAM=;
        b=vTpspDoRm2Pj+2PVwbExLH3wblZ41GFKjhiHEe2EjWSZYEKU3p4RznP/IM/r8SR4nx
         SiDmLuAS/APuxH1oNjFhYFEIruZxO7ZPCYVakZtS1epXWqHMG/YyliU6fKqkSb6QMVHm
         RmaXGTzg8hJED5fCZkKxA7CgBvRdf6NFMYIpRcZAlpW5cYVONX9mSiWU4crPVeMwATK4
         Ztl97Q0xOe+GrCWO78uO8rxlqvq9wfyUqgh3DpTntqvw7s/j+0ukm1nE3Rx3liCa6W/N
         O7FKwQcc2bSMxuC/oEOn8XothwupACmPYDIKvl4NGgooQi1qz/VYu1XPOzAo2FTxlBFp
         0whA==
X-Gm-Message-State: AOJu0YxZ5+I55atdoc7fKypZW76HeXeA1SajH6BMRw3ol+8tf7ehN3ri
        0q9GZhWEMvC3rz97+ulQvRqN8PIG/CD1A6jzZH7msQ==
X-Google-Smtp-Source: AGHT+IGjs7bRV3ZmI7Hf2ZEtwAj4BnVrYRotu4/pK3M8QHQkiZIQevkBsKFMThogOqhGaijWSkFEIVI4Ek97lZGZcEc=
X-Received: by 2002:a81:49cb:0:b0:59f:d01:779f with SMTP id
 w194-20020a8149cb000000b0059f0d01779fmr2770858ywa.23.1695852101790; Wed, 27
 Sep 2023 15:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <1695848028-18023-1-git-send-email-quic_khsieh@quicinc.com> <1695848028-18023-8-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1695848028-18023-8-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 28 Sep 2023 01:00:32 +0300
Message-ID: <CAA8EJpor3WEYmN=hQJQPFyjZGdr4j8F-XAB=2BDVRFCTNioEiA@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] drm/msm/dp: add pm_runtime_force_suspend()/resume()
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
> After incorporated pm_runtime framework into eDP/DP driver, the

incorporating


> original dp_pm_suspend() to handle power off both DP phy and
> controller during suspend and dp_pm_resume() to handle power on
> both DP phy and controller during resume are not necessary since
> those function are replaced by dp_pm_runtime_suspend() and
> dp_pm_runtime_resume() through pm runtime framework.
> Therefore add pm framework provides functions,
> pm_runtime_force_suspend()/resume() to complete incorporating pm
> runtime framework into DP driver.
>
> Changes in v4:
> -- drop both dp_pm_prepare() and dp_pm_compete() from this change
> -- delete ST_SUSPENDED state
> -- rewording commit text to add more details regrading the purpose
>    of this change
>
> Changes in v3:
> -- replace dp_pm_suspend() with pm_runtime_force_suspend()
> -- replace dp_pm_resume() with pm_runtime_force_resume()
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 113 ++----------------------------------
>  1 file changed, 5 insertions(+), 108 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 9158a2c..711d262 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -49,7 +49,6 @@ enum {
>         ST_CONNECTED,
>         ST_DISCONNECT_PENDING,
>         ST_DISPLAY_OFF,
> -       ST_SUSPENDED,
>  };
>
>  enum {
> @@ -560,7 +559,7 @@ static int dp_hpd_plug_handle(struct dp_display_private *dp, u32 data)
>         drm_dbg_dp(dp->drm_dev, "Before, type=%d hpd_state=%d\n",
>                         dp->dp_display.connector_type, state);
>
> -       if (state == ST_DISPLAY_OFF || state == ST_SUSPENDED) {
> +       if (state == ST_DISPLAY_OFF) {
>                 mutex_unlock(&dp->event_mutex);
>                 return 0;
>         }
> @@ -674,7 +673,7 @@ static int dp_irq_hpd_handle(struct dp_display_private *dp, u32 data)
>         drm_dbg_dp(dp->drm_dev, "Before, type=%d hpd_state=%d\n",
>                         dp->dp_display.connector_type, state);
>
> -       if (state == ST_DISPLAY_OFF || state == ST_SUSPENDED) {
> +       if (state == ST_DISPLAY_OFF) {
>                 mutex_unlock(&dp->event_mutex);
>                 return 0;
>         }
> @@ -1321,110 +1320,10 @@ static int dp_pm_runtime_resume(struct device *dev)
>         return 0;
>  }
>
> -static int dp_pm_resume(struct device *dev)
> -{
> -       struct platform_device *pdev = to_platform_device(dev);
> -       struct msm_dp *dp_display = platform_get_drvdata(pdev);
> -       struct dp_display_private *dp;
> -       int sink_count = 0;
> -
> -       dp = container_of(dp_display, struct dp_display_private, dp_display);
> -
> -       mutex_lock(&dp->event_mutex);
> -
> -       drm_dbg_dp(dp->drm_dev,
> -               "Before, type=%d core_inited=%d phy_inited=%d power_on=%d\n",
> -               dp->dp_display.connector_type, dp->core_initialized,
> -               dp->phy_initialized, dp_display->power_on);
> -
> -       /* start from disconnected state */
> -       dp->hpd_state = ST_DISCONNECTED;
> -
> -       /* turn on dp ctrl/phy */
> -       dp_display_host_init(dp);
> -
> -       if (dp_display->is_edp)
> -               dp_catalog_ctrl_hpd_enable(dp->catalog);
> -
> -       if (dp_catalog_link_is_connected(dp->catalog)) {
> -               /*
> -                * set sink to normal operation mode -- D0
> -                * before dpcd read
> -                */
> -               dp_display_host_phy_init(dp);
> -               dp_link_psm_config(dp->link, &dp->panel->link_info, false);
> -               sink_count = drm_dp_read_sink_count(dp->aux);
> -               if (sink_count < 0)
> -                       sink_count = 0;
> -
> -               dp_display_host_phy_exit(dp);
> -       }
> -
> -       dp->link->sink_count = sink_count;
> -       /*
> -        * can not declared display is connected unless
> -        * HDMI cable is plugged in and sink_count of
> -        * dongle become 1
> -        * also only signal audio when disconnected
> -        */
> -       if (dp->link->sink_count) {
> -               dp->dp_display.link_ready = true;
> -       } else {
> -               dp->dp_display.link_ready = false;
> -               dp_display_handle_plugged_change(dp_display, false);
> -       }
> -
> -       drm_dbg_dp(dp->drm_dev,
> -               "After, type=%d sink=%d conn=%d core_init=%d phy_init=%d power=%d\n",
> -               dp->dp_display.connector_type, dp->link->sink_count,
> -               dp->dp_display.link_ready, dp->core_initialized,
> -               dp->phy_initialized, dp_display->power_on);
> -
> -       mutex_unlock(&dp->event_mutex);
> -
> -       return 0;
> -}
> -
> -static int dp_pm_suspend(struct device *dev)
> -{
> -       struct platform_device *pdev = to_platform_device(dev);
> -       struct msm_dp *dp_display = platform_get_drvdata(pdev);
> -       struct dp_display_private *dp;
> -
> -       dp = container_of(dp_display, struct dp_display_private, dp_display);
> -
> -       mutex_lock(&dp->event_mutex);
> -
> -       drm_dbg_dp(dp->drm_dev,
> -               "Before, type=%d core_inited=%d  phy_inited=%d power_on=%d\n",
> -               dp->dp_display.connector_type, dp->core_initialized,
> -               dp->phy_initialized, dp_display->power_on);
> -
> -       /* mainlink enabled */
> -       if (dp_power_clk_status(dp->power, DP_CTRL_PM))
> -               dp_ctrl_off_link_stream(dp->ctrl);
> -
> -       dp_display_host_phy_exit(dp);

I was under the impression that dp_pm_runtime_suspend / _resume
functions perform phy init/exit only in eDP cases. Can we really drop
the main suspend/resume functions?

> -
> -       /* host_init will be called at pm_resume */
> -       dp_display_host_deinit(dp);
> -
> -       dp->hpd_state = ST_SUSPENDED;
> -
> -       drm_dbg_dp(dp->drm_dev,
> -               "After, type=%d core_inited=%d phy_inited=%d power_on=%d\n",
> -               dp->dp_display.connector_type, dp->core_initialized,
> -               dp->phy_initialized, dp_display->power_on);
> -
> -       mutex_unlock(&dp->event_mutex);
> -
> -       return 0;
> -}
> -
>  static const struct dev_pm_ops dp_pm_ops = {
>         SET_RUNTIME_PM_OPS(dp_pm_runtime_suspend, dp_pm_runtime_resume, NULL)
> -       .suspend = dp_pm_suspend,
> -       .resume =  dp_pm_resume,
> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +                                pm_runtime_force_resume)
>  };
>
>  static struct platform_driver dp_display_driver = {
> @@ -1658,9 +1557,6 @@ void dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
>
>         dp_display = container_of(dp, struct dp_display_private, dp_display);
>
> -       if (dp->is_edp)
> -               dp_hpd_unplug_handle(dp_display, 0);

Why?

> -
>         mutex_lock(&dp_display->event_mutex);
>
>         state = dp_display->hpd_state;
> @@ -1748,6 +1644,7 @@ void dp_bridge_hpd_disable(struct drm_bridge *bridge)
>         dp_catalog_ctrl_hpd_disable(dp->catalog);
>
>         dp_display->internal_hpd = false;
> +       dp->hpd_state = ST_DISCONNECTED;

Why? We have only disabled sending of the HPD events. The dongle might
still be connected.

>
>         pm_runtime_mark_last_busy(&dp->pdev->dev);
>         pm_runtime_put_autosuspend(&dp->pdev->dev);
> --
> 2.7.4
>


--
With best wishes

Dmitry
