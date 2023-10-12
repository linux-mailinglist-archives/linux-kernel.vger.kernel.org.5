Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49437C6201
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 03:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjJLBCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 21:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbjJLBCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 21:02:10 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CCDA9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 18:02:06 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5044dd5b561so593324e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 18:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697072524; x=1697677324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sBUfxydwH59AB7jn1gEz+qzjLhyE4iPqxxBUNPPiln0=;
        b=ATMjF619SYiAm5A4oDztn4ezuWEpc6k/T7nIHMRY/V4qCzdMm8V2jjob/7AHlt5ygd
         vrlZ39yjF3Fi7MNDB7L1kS5p6Z0cS2U9hbm+vSdAKjt7wr3PWbMLJ1V4hP9V3+PACPVK
         1SyR+ZSdyhFt1CS8lWe9SgNi8W+k/9NiSa0sTby2ZKIOk4uwR1lExg3kjN8g59khzQTA
         Dhjc/RtRCQVpuy9HNFe0i5UBOq1gUbb3KuS5BZSEeUNWpBNew6iU+zTxIlAgr0Js/4AJ
         WtR4ceZ1krgwLcZDG+oDIqSxGmq/Vc6S9KvyQFOwwdID0B6az+iFZy5vvSpkFaPegk/F
         QJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697072524; x=1697677324;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBUfxydwH59AB7jn1gEz+qzjLhyE4iPqxxBUNPPiln0=;
        b=TPdt64nCmaApfZORNxkTXxj/x0Q0NUJlJqZsSkdMFTSaYvS/9dJ5mMpKBXA9ELR+dC
         gGa15VdN2ZaERjI88UnMGpKwwzL37A93GPERultm6hgq++wVHPmJIHTg1Jv0f4X/pgfg
         d4DmU5hxbqRuCwwtag67Baqndkx6ehR3pguYL4suepugfczLwerSAcZrakQQ6UMoASoy
         urpL4Jr2HQ7wMZMooE6a6c3cuk1UtB3HbZYDejeu8+wCIXQeRJ/4X6XHiNKDYer/YQUV
         vZajti3z9LYnHRyc4C1J7L2KTEwo9a10d+q6/jlBggvOJy+tBovmPs0UEg2Y7UDID6PY
         2oaw==
X-Gm-Message-State: AOJu0YyLiddeaqGAOfS7uxBzUGeMKdTmY8kRQIrSDT8stKqR4r3p2O4B
        QWO4uXpvkwb/woBdOqJ8/jFX/g==
X-Google-Smtp-Source: AGHT+IEsBFPHHzjPBXENCv+Ra61Yrmd7vJ6WW5b43AjW47oQ0rR447fMVDjpRa6B5xix85CmMdCzSg==
X-Received: by 2002:ac2:5de4:0:b0:4ff:a02e:a53f with SMTP id z4-20020ac25de4000000b004ffa02ea53fmr16577875lfq.52.1697072524107;
        Wed, 11 Oct 2023 18:02:04 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id k17-20020ac24571000000b004fb738796casm2520627lfm.40.2023.10.11.18.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 18:02:03 -0700 (PDT)
Message-ID: <d411e042-e719-44c9-a5c4-bbd42bb46dd2@linaro.org>
Date:   Thu, 12 Oct 2023 04:02:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/7] drm/msm/dp: incorporate pm_runtime framework into
 DP driver
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1696632910-21942-1-git-send-email-quic_khsieh@quicinc.com>
 <1696632910-21942-6-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1696632910-21942-6-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2023 01:55, Kuogee Hsieh wrote:
> Currently DP driver is executed independent of PM runtime framework.
> This leads msm eDP panel can not being detected by edp_panel driver
> during generic_edp_panel_probe() due to AUX DPCD read failed at
> edp panel driver. Incorporate PM runtime framework into DP driver so
> that host controller's power and clocks are enable/disable through
> PM runtime mechanism.  Once PM runtime framework is incorporated into
> DP driver, waking up device from power up path is not necessary. Hence
> remove it.
> 
> After incorporating pm_runtime framework into eDP/DP driver,
> dp_pm_suspend() to handle power off both DP phy and controller during
> suspend and dp_pm_resume() to handle power on both DP phy and controller
> during resume are not necessary. Therefore both dp_pm_suspend() and
> dp_pm_resume() are dropped and replace with dp_pm_runtime_suspend() and
> dp_pm_runtime_resume() respectively.
> 
> Changes in v7:
> -- add comments to dp_pm_runtime_resume()
> -- add comments to dp_bridge_hpd_enable()
> -- delete dp->hpd_state = ST_DISCONNECTED from dp_bridge_hpd_notify()
> 
> Changes in v6:
> -- delete dp_power_client_deinit(dp->power);
> -- remove if (!dp->dp_display.is_edp) condition checkout at plug_handle()
> -- remove if (!dp->dp_display.is_edp) condition checkout at unplug_handle()
> -- add IRQF_NO_AUTOEN to devm_request_irq()
> -- add enable_irq() and disable_irq() to pm_runtime_resume()/suspend()
> -- del dp->hpd_state = ST_DISCONNECTED from dp_bridge_hpd_disable()
> 
> Changes in v5:
> -- remove pm_runtime_put_autosuspend feature, use pm_runtime_put_sync()
> -- squash add pm_runtime_force_suspend()/resume() patch into this patch
> 
> Changes in v4:
> -- reworded commit text to explain why pm_framework is required for
>     edp panel
> -- reworded commit text to explain autosuspend is choiced
> -- delete EV_POWER_PM_GET and PM_EV_POWER_PUT from changes #3
> -- delete dp_display_pm_get() and dp_display_pm_Put() from changes #3
> -- return value from pm_runtime_resume_and_get() directly
> -- check return value of devm_pm_runtime_enable()
> -- delete pm_runtime_xxx from dp_display_remove()
> -- drop dp_display_host_init() from EV_HPD_INIT_SETUP
> -- drop both dp_pm_prepare() and dp_pm_compete() from this change
> -- delete ST_SUSPENDED state
> -- rewording commit text to add more details regrading the purpose
>     of this change
> 
> Changes in v3:
> -- incorporate removing pm_runtime_xx() from dp_pwer.c to this patch
> -- use pm_runtime_resume_and_get() instead of pm_runtime_get()
> -- error checking pm_runtime_resume_and_get() return value
> -- add EV_POWER_PM_GET and PM_EV_POWER_PUT to handle HPD_GPIO case
> -- replace dp_pm_suspend() with pm_runtime_force_suspend()
> -- replace dp_pm_resume() with pm_runtime_force_resume()
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_aux.c     |   5 +
>   drivers/gpu/drm/msm/dp/dp_display.c | 177 ++++++++++++++----------------------
>   drivers/gpu/drm/msm/dp/dp_power.c   |  16 ----
>   drivers/gpu/drm/msm/dp/dp_power.h   |  11 ---
>   4 files changed, 72 insertions(+), 137 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
> index 8e3b677..10b6eeb 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.c
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.c
> @@ -291,6 +291,10 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *dp_aux,
>   		return -EINVAL;
>   	}
>   
> +	ret = pm_runtime_resume_and_get(dp_aux->dev);
> +	if (ret)
> +		return  ret;
> +
>   	mutex_lock(&aux->mutex);
>   	if (!aux->initted) {
>   		ret = -EIO;
> @@ -364,6 +368,7 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *dp_aux,
>   
>   exit:
>   	mutex_unlock(&aux->mutex);
> +	pm_runtime_put_sync(dp_aux->dev);
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 89fad67..acda544 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -49,7 +49,6 @@ enum {
>   	ST_CONNECTED,
>   	ST_DISCONNECT_PENDING,
>   	ST_DISPLAY_OFF,
> -	ST_SUSPENDED,
>   };
>   
>   enum {
> @@ -310,10 +309,6 @@ static void dp_display_unbind(struct device *dev, struct device *master,
>   	struct dp_display_private *dp = dev_get_dp_display_private(dev);
>   	struct msm_drm_private *priv = dev_get_drvdata(master);
>   
> -	/* disable all HPD interrupts */
> -	if (dp->core_initialized)
> -		dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_INT_MASK, false);
> -
>   	kthread_stop(dp->ev_tsk);
>   
>   	of_dp_aux_depopulate_bus(dp->aux);
> @@ -558,7 +553,7 @@ static int dp_hpd_plug_handle(struct dp_display_private *dp, u32 data)
>   	drm_dbg_dp(dp->drm_dev, "Before, type=%d hpd_state=%d\n",
>   			dp->dp_display.connector_type, state);
>   
> -	if (state == ST_DISPLAY_OFF || state == ST_SUSPENDED) {
> +	if (state == ST_DISPLAY_OFF) {
>   		mutex_unlock(&dp->event_mutex);
>   		return 0;
>   	}
> @@ -575,6 +570,12 @@ static int dp_hpd_plug_handle(struct dp_display_private *dp, u32 data)
>   		return 0;
>   	}
>   
> +	ret = pm_runtime_resume_and_get(&dp->pdev->dev);
> +	if (ret) {
> +		DRM_ERROR("failed to pm_runtime_resume\n");
> +		return ret;
> +	}
> +
>   	ret = dp_display_usbpd_configure_cb(&dp->pdev->dev);
>   	if (ret) {	/* link train failed */
>   		dp->hpd_state = ST_DISCONNECTED;
> @@ -657,6 +658,7 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
>   			dp->dp_display.connector_type, state);
>   
>   	/* uevent will complete disconnection part */
> +	pm_runtime_put_sync(&dp->pdev->dev);
>   	mutex_unlock(&dp->event_mutex);
>   	return 0;
>   }
> @@ -672,7 +674,7 @@ static int dp_irq_hpd_handle(struct dp_display_private *dp, u32 data)
>   	drm_dbg_dp(dp->drm_dev, "Before, type=%d hpd_state=%d\n",
>   			dp->dp_display.connector_type, state);
>   
> -	if (state == ST_DISPLAY_OFF || state == ST_SUSPENDED) {
> +	if (state == ST_DISPLAY_OFF) {
>   		mutex_unlock(&dp->event_mutex);
>   		return 0;
>   	}
> @@ -1085,7 +1087,6 @@ static int hpd_event_thread(void *data)
>   
>   		switch (todo->event_id) {
>   		case EV_HPD_INIT_SETUP:
> -			dp_display_host_init(dp_priv);
>   			break;
>   		case EV_HPD_PLUG_INT:
>   			dp_hpd_plug_handle(dp_priv, todo->data);
> @@ -1177,7 +1178,9 @@ static int dp_display_request_irq(struct dp_display_private *dp)
>   	}
>   
>   	rc = devm_request_irq(dev, dp->irq, dp_display_irq_handler,
> -			IRQF_TRIGGER_HIGH, "dp_display_isr", dp);
> +			      IRQF_TRIGGER_HIGH|IRQF_NO_AUTOEN,
> +			      "dp_display_isr", dp);
> +
>   	if (rc < 0) {
>   		DRM_ERROR("failed to request IRQ%u: %d\n",
>   				dp->irq, rc);
> @@ -1263,6 +1266,10 @@ static int dp_display_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, &dp->dp_display);
>   
> +	rc = devm_pm_runtime_enable(&pdev->dev);
> +	if (rc)
> +		goto err;
> +
>   	rc = dp_display_request_irq(dp);
>   	if (rc)
>   		goto err;
> @@ -1285,7 +1292,6 @@ static int dp_display_remove(struct platform_device *pdev)
>   	struct dp_display_private *dp = dev_get_dp_display_private(&pdev->dev);
>   
>   	component_del(&pdev->dev, &dp_display_comp_ops);
> -	dp_power_client_deinit(dp->power);
>   	dp_display_deinit_sub_modules(dp);
>   
>   	platform_set_drvdata(pdev, NULL);
> @@ -1293,109 +1299,47 @@ static int dp_display_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> -static int dp_pm_resume(struct device *dev)
> +static int dp_pm_runtime_suspend(struct device *dev)
>   {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct msm_dp *dp_display = platform_get_drvdata(pdev);
> -	struct dp_display_private *dp;
> -	int sink_count = 0;
> -
> -	dp = container_of(dp_display, struct dp_display_private, dp_display);
> -
> -	mutex_lock(&dp->event_mutex);
> -
> -	drm_dbg_dp(dp->drm_dev,
> -		"Before, type=%d core_inited=%d phy_inited=%d power_on=%d\n",
> -		dp->dp_display.connector_type, dp->core_initialized,
> -		dp->phy_initialized, dp_display->power_on);
> -
> -	/* start from disconnected state */
> -	dp->hpd_state = ST_DISCONNECTED;
> -
> -	/* turn on dp ctrl/phy */
> -	dp_display_host_init(dp);
> -
> -	if (dp_display->is_edp)
> -		dp_catalog_ctrl_hpd_enable(dp->catalog);
> +	struct dp_display_private *dp = dev_get_dp_display_private(dev);
>   
> -	if (dp_catalog_link_is_connected(dp->catalog)) {
> -		/*
> -		 * set sink to normal operation mode -- D0
> -		 * before dpcd read
> -		 */
> -		dp_display_host_phy_init(dp);
> -		dp_link_psm_config(dp->link, &dp->panel->link_info, false);
> -		sink_count = drm_dp_read_sink_count(dp->aux);
> -		if (sink_count < 0)
> -			sink_count = 0;
> +	disable_irq(dp->irq);
>   
> +	if (dp->dp_display.is_edp) {
>   		dp_display_host_phy_exit(dp);
> +		dp_catalog_ctrl_hpd_disable(dp->catalog);
>   	}
> -
> -	dp->link->sink_count = sink_count;
> -	/*
> -	 * can not declared display is connected unless
> -	 * HDMI cable is plugged in and sink_count of
> -	 * dongle become 1
> -	 * also only signal audio when disconnected
> -	 */
> -	if (dp->link->sink_count) {
> -		dp->dp_display.link_ready = true;
> -	} else {
> -		dp->dp_display.link_ready = false;
> -		dp_display_handle_plugged_change(dp_display, false);
> -	}
> -
> -	drm_dbg_dp(dp->drm_dev,
> -		"After, type=%d sink=%d conn=%d core_init=%d phy_init=%d power=%d\n",
> -		dp->dp_display.connector_type, dp->link->sink_count,
> -		dp->dp_display.link_ready, dp->core_initialized,
> -		dp->phy_initialized, dp_display->power_on);
> -
> -	mutex_unlock(&dp->event_mutex);
> +	dp_display_host_deinit(dp);
>   
>   	return 0;
>   }
>   
> -static int dp_pm_suspend(struct device *dev)
> +static int dp_pm_runtime_resume(struct device *dev)
>   {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct msm_dp *dp_display = platform_get_drvdata(pdev);
> -	struct dp_display_private *dp;
> -
> -	dp = container_of(dp_display, struct dp_display_private, dp_display);
> -
> -	mutex_lock(&dp->event_mutex);
> -
> -	drm_dbg_dp(dp->drm_dev,
> -		"Before, type=%d core_inited=%d  phy_inited=%d power_on=%d\n",
> -		dp->dp_display.connector_type, dp->core_initialized,
> -		dp->phy_initialized, dp_display->power_on);
> -
> -	/* mainlink enabled */
> -	if (dp_power_clk_status(dp->power, DP_CTRL_PM))
> -		dp_ctrl_off_link_stream(dp->ctrl);
> -
> -	dp_display_host_phy_exit(dp);
> -
> -	/* host_init will be called at pm_resume */
> -	dp_display_host_deinit(dp);
> -
> -	dp->hpd_state = ST_SUSPENDED;
> -
> -	drm_dbg_dp(dp->drm_dev,
> -		"After, type=%d core_inited=%d phy_inited=%d power_on=%d\n",
> -		dp->dp_display.connector_type, dp->core_initialized,
> -		dp->phy_initialized, dp_display->power_on);
> +	struct dp_display_private *dp = dev_get_dp_display_private(dev);
>   
> -	mutex_unlock(&dp->event_mutex);
> +	/*
> +	 * for eDP, host cotroller, HPD block and PHY are enabled here
> +	 * but with HPD irq disabled
> +	 *
> +	 * for DP, only host controller is enabled here.
> +	 * HPD block is enabled at dp_bridge_hpd_enable()
> +	 * PHY will be enabled at plugin handler later
> +	 */
> +	dp_display_host_init(dp);
> +	if (dp->dp_display.is_edp) {
> +		dp_catalog_ctrl_hpd_enable(dp->catalog);
> +		dp_display_host_phy_init(dp);
> +	}
>   
> +	enable_irq(dp->irq);
>   	return 0;
>   }
>   
>   static const struct dev_pm_ops dp_pm_ops = {
> -	.suspend = dp_pm_suspend,
> -	.resume =  dp_pm_resume,
> +	SET_RUNTIME_PM_OPS(dp_pm_runtime_suspend, dp_pm_runtime_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
>   };
>   
>   static struct platform_driver dp_display_driver = {
> @@ -1478,10 +1422,6 @@ static int dp_display_get_next_bridge(struct msm_dp *dp)
>   	aux_bus = of_get_child_by_name(dev->of_node, "aux-bus");
>   
>   	if (aux_bus && dp->is_edp) {
> -		dp_display_host_init(dp_priv);
> -		dp_catalog_ctrl_hpd_enable(dp_priv->catalog);
> -		dp_display_host_phy_init(dp_priv);
> -
>   		/*
>   		 * The code below assumes that the panel will finish probing
>   		 * by the time devm_of_dp_aux_populate_ep_devices() returns.
> @@ -1583,6 +1523,11 @@ void dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>   		dp_hpd_plug_handle(dp_display, 0);
>   
>   	mutex_lock(&dp_display->event_mutex);
> +	if (pm_runtime_resume_and_get(&dp_display->pdev->dev)) {
> +		DRM_ERROR("failed to pm_runtime_resume\n");
> +		mutex_unlock(&dp_display->event_mutex);
> +		return;
> +	}
>   
>   	state = dp_display->hpd_state;
>   	if (state != ST_DISPLAY_OFF && state != ST_MAINLINK_READY) {
> @@ -1647,10 +1592,9 @@ void dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
>   	mutex_lock(&dp_display->event_mutex);
>   
>   	state = dp_display->hpd_state;
> -	if (state != ST_DISCONNECT_PENDING && state != ST_CONNECTED) {
> -		mutex_unlock(&dp_display->event_mutex);
> -		return;
> -	}
> +	if (state != ST_DISCONNECT_PENDING && state != ST_CONNECTED)
> +		drm_dbg_dp(dp->drm_dev, "type=%d wrong hpd_state=%d\n",
> +			   dp->connector_type, state);
>   
>   	dp_display_disable(dp_display);
>   
> @@ -1663,6 +1607,8 @@ void dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
>   	}
>   
>   	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", dp->connector_type);
> +
> +	pm_runtime_put_sync(&dp_display->pdev->dev);
>   	mutex_unlock(&dp_display->event_mutex);
>   }
>   
> @@ -1701,7 +1647,21 @@ void dp_bridge_hpd_enable(struct drm_bridge *bridge)
>   	struct msm_dp *dp_display = dp_bridge->dp_display;
>   	struct dp_display_private *dp = container_of(dp_display, struct dp_display_private, dp_display);
>   
> +	/*
> +	 * this is for external DP with hpd irq enabled case,
> +	 * step-1: dp_pm_runtime_resume() enable dp host only
> +	 * step-2: enable hdp block and have hpd irq enabled here
> +	 * step-3: waiting for plugin irq while phy is not initialized
> +	 * step-4: DP PHY is initialized at plugin handler before link training
> +	 *
> +	 */
>   	mutex_lock(&dp->event_mutex);
> +	if (pm_runtime_resume_and_get(&dp->pdev->dev)) {
> +		DRM_ERROR("failed to resume power\n");
> +		mutex_unlock(&dp->event_mutex);
> +		return;
> +	}
> +
>   	dp_catalog_ctrl_hpd_enable(dp->catalog);
>   
>   	/* enable HDP interrupts */
> @@ -1723,6 +1683,8 @@ void dp_bridge_hpd_disable(struct drm_bridge *bridge)
>   	dp_catalog_ctrl_hpd_disable(dp->catalog);
>   
>   	dp_display->internal_hpd = false;
> +
> +	pm_runtime_put_sync(&dp->pdev->dev);
>   	mutex_unlock(&dp->event_mutex);
>   }
>   
> @@ -1737,11 +1699,6 @@ void dp_bridge_hpd_notify(struct drm_bridge *bridge,
>   	if (dp_display->internal_hpd)
>   		return;
>   
> -	if (!dp->core_initialized) {
> -		drm_dbg_dp(dp->drm_dev, "not initialized\n");
> -		return;
> -	}
> -
>   	if (!dp_display->link_ready && status == connector_status_connected)
>   		dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
>   	else if (dp_display->link_ready && status == connector_status_disconnected)
> diff --git a/drivers/gpu/drm/msm/dp/dp_power.c b/drivers/gpu/drm/msm/dp/dp_power.c
> index 5cb84ca..863c766 100644
> --- a/drivers/gpu/drm/msm/dp/dp_power.c
> +++ b/drivers/gpu/drm/msm/dp/dp_power.c
> @@ -152,20 +152,9 @@ int dp_power_client_init(struct dp_power *dp_power)
>   
>   	power = container_of(dp_power, struct dp_power_private, dp_power);
>   
> -	pm_runtime_enable(power->dev);
> -
>   	return dp_power_clk_init(power);
>   }
>   
> -void dp_power_client_deinit(struct dp_power *dp_power)
> -{
> -	struct dp_power_private *power;
> -
> -	power = container_of(dp_power, struct dp_power_private, dp_power);
> -
> -	pm_runtime_disable(power->dev);
> -}
> -
>   int dp_power_init(struct dp_power *dp_power)
>   {
>   	int rc = 0;
> @@ -173,11 +162,7 @@ int dp_power_init(struct dp_power *dp_power)
>   
>   	power = container_of(dp_power, struct dp_power_private, dp_power);
>   
> -	pm_runtime_get_sync(power->dev); 

With W=1 I'm getting the following warnings:

drivers/gpu/drm/msm/dp/dp_power.c: In function ‘dp_power_init’:
drivers/gpu/drm/msm/dp/dp_power.c:161:34: warning: variable ‘power’ set 
but not used [-Wunused-but-set-variable]

> -
>   	rc = dp_power_clk_enable(dp_power, DP_CORE_PM, true);
> -	if (rc)
> -		pm_runtime_put_sync(power->dev);
>   
>   	return rc;
>   }
> @@ -189,7 +174,6 @@ int dp_power_deinit(struct dp_power *dp_power)
>   	power = container_of(dp_power, struct dp_power_private, dp_power);
>   
>   	dp_power_clk_enable(dp_power, DP_CORE_PM, false);
> -	pm_runtime_put_sync(power->dev);

drivers/gpu/drm/msm/dp/dp_power.c: In function ‘dp_power_deinit’:
drivers/gpu/drm/msm/dp/dp_power.c:172:34: warning: variable ‘power’ set 
but not used [-Wunused-but-set-variable]


>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/msm/dp/dp_power.h b/drivers/gpu/drm/msm/dp/dp_power.h
> index a3dec20..55ada51 100644
> --- a/drivers/gpu/drm/msm/dp/dp_power.h
> +++ b/drivers/gpu/drm/msm/dp/dp_power.h
> @@ -81,17 +81,6 @@ int dp_power_clk_enable(struct dp_power *power, enum dp_pm_type pm_type,
>   int dp_power_client_init(struct dp_power *power);
>   
>   /**
> - * dp_power_clinet_deinit() - de-initialize clock and regulator modules
> - *
> - * @power: instance of power module
> - * return: 0 for success, error for failure.
> - *
> - * This API will de-initialize the DisplayPort's clocks and regulator
> - * modules.
> - */
> -void dp_power_client_deinit(struct dp_power *power);
> -
> -/**
>    * dp_power_get() - configure and get the DisplayPort power module data
>    *
>    * @parser: instance of parser module

-- 
With best wishes
Dmitry

