Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717A17BC72A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 13:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343879AbjJGLef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 07:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343873AbjJGLed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 07:34:33 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE571B6
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 04:34:31 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59f1dff5298so36640227b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 04:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696678471; x=1697283271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BUL9y8tZlO44flYbnwVHExhq5hSpJ5SL0h4EKu3o8eg=;
        b=AvYSkdEmvb7wNAaXpP39ClBhIPQCFsQdhUoi4STBjpqic9DaPo2XToXOTnrrUBNYEE
         a0zF9J1V/xBTtoopgQ1f5YOkvLqGev66LuFLAMe6CbbSBn7Cpolu/Vp+msWJss5yyeRQ
         ouKAcbLSDdI5qcWvx8T2eDVRC/XMzlOCOcGJpxm/gsApP03EQpsnOya6jTu1SaLBAI88
         cHHdOC+SWjB1B319EWFDftBDsYkqRN9AheuEjFYnF7rvd/E9iA1nPf63dIA0PTC9IG9A
         oTpwY9rd19ZuMpwTNFLHrlJtxzlmdvQfmwI9ZoTLCvxUd8es9w+VqV183MEH+2K96EXH
         wX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696678471; x=1697283271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUL9y8tZlO44flYbnwVHExhq5hSpJ5SL0h4EKu3o8eg=;
        b=aH4jAAH6BE2XrFboLHPLaeKU9hSFw97mFZwynx+rlwykBH1QDnNY2HMgoPTAKPON++
         YXpE+l7PZ5AnBL8/cF8w8IGt2omM4ftK6d7sqzYlgeAaPWv1DI97Iljr8V+zep6pwHs4
         pG1EjdHKW2azB773hLx8dOgmyJuZBB+fLLTnNFh02cMWquPPO7GdarySft3XtKVHXDRR
         zcroi251BrAyHNig0UxYK0icSTjDf6KO7i8JONGh5IQeQ+7KNs4zqHs/0I+nskUh4jsX
         4+DJYrWKqj4zqbHcOFXl4jviioztnUIEgPyLnEKObZBNWWRamGi0y5+6LuBueGM4fHS/
         Sj3w==
X-Gm-Message-State: AOJu0YwFHVPcr4+eJzesN4U558YkWNGBclHH7uADQ0JU9sOOJZ1gcBfY
        V11uTs0FdubevjRAzbznvneC7gLckUS/PkwyYN/JZw==
X-Google-Smtp-Source: AGHT+IED+W2CNRXknXxq1mbD1Zkyw3ORxCtJvNCcoL7lGlHItYDcn2L3EFqtw8GT5LNES0wEU6OG7NRtCXEl27Tj7+Q=
X-Received: by 2002:a81:c24a:0:b0:589:f995:eb9f with SMTP id
 t10-20020a81c24a000000b00589f995eb9fmr11364646ywg.45.1696678471076; Sat, 07
 Oct 2023 04:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <1696632910-21942-1-git-send-email-quic_khsieh@quicinc.com> <1696632910-21942-6-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1696632910-21942-6-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 7 Oct 2023 14:34:18 +0300
Message-ID: <CAA8EJpq=hCfPv0VgOYm5jXL98ncqwuwrTG7jBB2EgXYrY2C6qw@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] drm/msm/dp: incorporate pm_runtime framework into
 DP driver
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

On Sat, 7 Oct 2023 at 01:55, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
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
>    edp panel
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
>    of this change
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/dp/dp_aux.c     |   5 +
>  drivers/gpu/drm/msm/dp/dp_display.c | 177 ++++++++++++++----------------------
>  drivers/gpu/drm/msm/dp/dp_power.c   |  16 ----
>  drivers/gpu/drm/msm/dp/dp_power.h   |  11 ---
>  4 files changed, 72 insertions(+), 137 deletions(-)


-- 
With best wishes
Dmitry
