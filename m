Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD317A2D05
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 03:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbjIPBWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 21:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbjIPBWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 21:22:02 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA907115
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 18:21:56 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59c0442a359so19231507b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 18:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694827316; x=1695432116; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m8BKz5UCMmU/bXzuDaUcle9qWzHdZ3DqG5/pm4LxWZc=;
        b=KlEjKBrPppqnWtyLLkOD62rpAM77rpqBq/8al+S94M18r0xiqxH/MfCCOxhwPNRb5F
         MnJKQ/Z4dneKX5YmMWyaBdkR0yr4RgmoLFDdaa+Xo3fbPm9BHnD9Ls+XN75ks/Luew1x
         r34OUsz1BgBRYyJrMHXFNQTrclZXEeo40zfQ3V9/dH86qL/GLBCFhjVYd+8aXpx/wSfw
         W+wybrLcO7f3AYngsqjBoEsl60HnvzuNo29QkUlesr+jQwoqxktKYnZCS+guJ6xrGwDk
         Jl6Oh05cqCyosL0qxUxJl3MAaSZGxA/dBJiNhHjGZdFietqXc5JLgsSJ79/xzNB18jLR
         cSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694827316; x=1695432116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m8BKz5UCMmU/bXzuDaUcle9qWzHdZ3DqG5/pm4LxWZc=;
        b=wYrshoTZGlkuvsTGsWB+uGsWAzq/tt1kvA2xkZnBxicXWHySNcysxpRuMVuRGLVdyt
         KKfP3yl38jWk/5uENaZDXOztNn5OSWTeMS2bJFlzrW9YMsDOODAeFcyOyRwjYsSpxvWi
         x3cJSbddgaprfW7E5ZkDp84yGGf7qNCjTvvAGAN9GPt386jmRoFiL+KbChxhE1RUaQoP
         sBH4MkkJ4P3UKC6jaNYWrOXJDqkFb8uyrZHLYLrAMGW/q7oKanYc1CcRtumLmQ+yA7/O
         PXiQphYk9izoGjRSkl4IdeaTbYQyy9ijsM89cwyYT/8jvDwBKidMsUjYPF8OJf1UBUvv
         GHog==
X-Gm-Message-State: AOJu0YxNG/ka8YViraHy7QWKQ9/ceY8xsrYJXxA1EHHqsIz/9U8l0lDf
        HbbSI+gJmybwBvZ/L/udahgXHNJG844WP4YV67mKhg==
X-Google-Smtp-Source: AGHT+IGirGUvVmFPjV1cL+A1J69fNhmFXvjIP8Zn0NDxSV0Q4j7kEjWfjiCMmV5s1uEqTsShPsx9NphwFc9WmDZ13ck=
X-Received: by 2002:a81:914d:0:b0:570:65df:21dc with SMTP id
 i74-20020a81914d000000b0057065df21dcmr3509921ywg.3.1694827316007; Fri, 15 Sep
 2023 18:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <1694813901-26952-1-git-send-email-quic_khsieh@quicinc.com> <1694813901-26952-7-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1694813901-26952-7-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 16 Sep 2023 04:21:44 +0300
Message-ID: <CAA8EJpqPXoFX4LXyXYgfh07Vpxg-KgD8VBR6x5bXf4GOJmbOtw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] drm/msm/dp: add pm_runtime_force_suspend()/resume()
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
> Add pm_runtime_force_suspend()/resume() to complete incorporating pm
> runtime framework into DP driver. Both dp_pm_prepare() and dp_pm_complete()
> are added to set hpd_state to correct state. After resume, DP driver will
> re training its main link after .hpd_enable() callback enabled HPD
> interrupts and bring up display accordingly.

How will it re-train the main link? What is the code path for that?

I think this is a misuse for prepare/complete callbacks, at least
judging from their documentation.

>
> Changes in v3:
> -- replace dp_pm_suspend() with pm_runtime_force_suspend()
> -- replace dp_pm_resume() with pm_runtime_force_resume()
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 87 +++++--------------------------------
>  1 file changed, 10 insertions(+), 77 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index b6992202..b58cb02 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1333,101 +1333,35 @@ static int dp_pm_runtime_resume(struct device *dev)
>         return 0;
>  }
>
> -static int dp_pm_resume(struct device *dev)
> +static void dp_pm_complete(struct device *dev)
>  {
> -       struct platform_device *pdev = to_platform_device(dev);
> -       struct msm_dp *dp_display = platform_get_drvdata(pdev);
> -       struct dp_display_private *dp;
> -       int sink_count = 0;
> -
> -       dp = container_of(dp_display, struct dp_display_private, dp_display);
> +       struct dp_display_private *dp = dev_get_dp_display_private(dev);
>
>         mutex_lock(&dp->event_mutex);
>
>         drm_dbg_dp(dp->drm_dev,
> -               "Before, type=%d core_inited=%d phy_inited=%d power_on=%d\n",
> +               "type=%d core_inited=%d phy_inited=%d power_on=%d\n",
>                 dp->dp_display.connector_type, dp->core_initialized,
> -               dp->phy_initialized, dp_display->power_on);
> +               dp->phy_initialized, dp->dp_display.power_on);
>
>         /* start from disconnected state */
>         dp->hpd_state = ST_DISCONNECTED;
>
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
>         mutex_unlock(&dp->event_mutex);
> -
> -       return 0;
>  }
>
> -static int dp_pm_suspend(struct device *dev)
> +static int dp_pm_prepare(struct device *dev)
>  {
> -       struct platform_device *pdev = to_platform_device(dev);
> -       struct msm_dp *dp_display = platform_get_drvdata(pdev);
> -       struct dp_display_private *dp;
> -
> -       dp = container_of(dp_display, struct dp_display_private, dp_display);
> +       struct dp_display_private *dp = dev_get_dp_display_private(dev);
>
>         mutex_lock(&dp->event_mutex);
>
> -       drm_dbg_dp(dp->drm_dev,
> -               "Before, type=%d core_inited=%d  phy_inited=%d power_on=%d\n",
> -               dp->dp_display.connector_type, dp->core_initialized,
> -               dp->phy_initialized, dp_display->power_on);
> -
>         /* mainlink enabled */
>         if (dp_power_clk_status(dp->power, DP_CTRL_PM))
>                 dp_ctrl_off_link_stream(dp->ctrl);
>
> -       dp_display_host_phy_exit(dp);
> -
> -       /* host_init will be called at pm_resume */
> -       dp_display_host_deinit(dp);
> -
>         dp->hpd_state = ST_SUSPENDED;
>
> -       drm_dbg_dp(dp->drm_dev,
> -               "After, type=%d core_inited=%d phy_inited=%d power_on=%d\n",
> -               dp->dp_display.connector_type, dp->core_initialized,
> -               dp->phy_initialized, dp_display->power_on);
> -
>         mutex_unlock(&dp->event_mutex);
>
>         return 0;
> @@ -1435,8 +1369,10 @@ static int dp_pm_suspend(struct device *dev)
>
>  static const struct dev_pm_ops dp_pm_ops = {
>         SET_RUNTIME_PM_OPS(dp_pm_runtime_suspend, dp_pm_runtime_resume, NULL)
> -       .suspend = dp_pm_suspend,
> -       .resume =  dp_pm_resume,
> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +                                pm_runtime_force_resume)
> +       .prepare = dp_pm_prepare,
> +       .complete = dp_pm_complete,
>  };
>
>  static struct platform_driver dp_display_driver = {
> @@ -1670,9 +1606,6 @@ void dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
>
>         dp_display = container_of(dp, struct dp_display_private, dp_display);
>
> -       if (dp->is_edp)
> -               dp_hpd_unplug_handle(dp_display, 0);
> -
>         mutex_lock(&dp_display->event_mutex);
>
>         state = dp_display->hpd_state;
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
