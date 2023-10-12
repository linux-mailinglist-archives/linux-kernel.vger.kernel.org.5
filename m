Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113177C6207
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 03:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbjJLBEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 21:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjJLBEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 21:04:12 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9CCB6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 18:04:10 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5068692b0d9so591036e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 18:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697072649; x=1697677449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cT2LvUtpeUGiSyAgace36wLACMbz8k4swUVY/0XIdR4=;
        b=SMcs6iTlqjrdBSqCK1v1Xq3kdw8F/RMx1bQ6JjzZj+HHhlx9kPxnGA/HaKtG3baLg6
         QayvRP5n8ab3F1HBnUQEygZQK0RmkBzPYgHiMf3GH88eul6WLLI69YjXRgtiPtdqzNcG
         Pq+Qflu/NJ3RH54h4vdgo0g7E42pG+4FT+qI7hQrDb2nSgvhdqK1hQ5lq9oFlnst/TAE
         xPgM5lO15yxTrSRo9gk8i344YJi31PYzpHu9ZCXGqZPP73oXWOjo4a/eK8LXq2+LDuHo
         Y2Z0d2vnAJBCLxknacGMXQMludyA8Rm7lfkdbDMCDn3jvPuvk8NYEJGpdnwc+g9Q1Tsi
         nXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697072649; x=1697677449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cT2LvUtpeUGiSyAgace36wLACMbz8k4swUVY/0XIdR4=;
        b=nTmK3vLPWhtBwI/IVKIUG/2l6qMobDGtUJj3fe6npZ+3PodRqqRlwsx2pz1Kk50y6g
         mPwBN/+7tCYtwYmBI2s8ixOrKruXEOXQ1UDchrOsgfXgH0HAuETFLjXnWM/4GjLx/Tge
         ZMX32jpPwFIXOk/yyBsxjvaoW0qNjm6FTmE/7Jni2wfnMgUaAMCxTuBw+oXZ4L4j47+k
         Daf1eJ7urvGqfUqTUz9prDWhpGnEzUemh20HUjRQVf66NTAOcXMrmVvhL3tsSPquxd+U
         YwqeZrdPX4jfG+Q9genJDICcANTDuYJ03PUelbSocRmdNI50hesiBUSxnMhDZu7eBplN
         FBOA==
X-Gm-Message-State: AOJu0YzfwbAa+YoBv0b+2FkrDRS5gVg8kV3t+bL/NoJkL2h9jGRn4plZ
        uZsCx4fwCvmtbNlhqAQL9z2Uuw==
X-Google-Smtp-Source: AGHT+IGSAu+eKUIXsF6dkBUn9j2AAUPMBTfKhJbCHRbAEys0dyVfEobQLZa2SxiiI3uhWGT0+ZG/Zg==
X-Received: by 2002:a19:ad04:0:b0:503:eac:747 with SMTP id t4-20020a19ad04000000b005030eac0747mr17643177lfc.47.1697072648996;
        Wed, 11 Oct 2023 18:04:08 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id c20-20020ac25314000000b004fdba93b92asm2526936lfh.252.2023.10.11.18.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 18:04:08 -0700 (PDT)
Message-ID: <c7e8d791-c8d5-440c-804d-4aa29be40f13@linaro.org>
Date:   Thu, 12 Oct 2023 04:04:07 +0300
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
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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


[skipped the rest]

> @@ -173,11 +162,7 @@ int dp_power_init(struct dp_power *dp_power)
>   
>   	power = container_of(dp_power, struct dp_power_private, dp_power);
>   
> -	pm_runtime_get_sync(power->dev);
> -
>   	rc = dp_power_clk_enable(dp_power, DP_CORE_PM, true);
> -	if (rc)
> -		pm_runtime_put_sync(power->dev);
>   
>   	return rc;

Also this can not be as simple as:

int dp_power_init(struct dp_power *dp_power)
{
   	return dp_power_clk_enable(dp_power, DP_CORE_PM, true);
}


>   }-- 
With best wishes
Dmitry

