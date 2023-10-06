Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8887BBE1C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjJFR4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbjJFR4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:56:47 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CEADE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 10:56:46 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59bf1dde73fso29144247b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 10:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696615003; x=1697219803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KSCSizx6FgkyRIW0X32uY+4ZXkb204qdp7z+rYedcrk=;
        b=MTcjX+Ke6n3HSn3oK09WFhilSMt4myjWE/DRirbQquDHxdiKquS1ir45OiaHI3nxzt
         zmdAcjuhRrVYlY4SmZnKzq4+NvDlm0QsDfwrT9kUlccAm9Pp7oXWoP0uPzDd1x4FKiI5
         Rfa4CnBCU6lEz9Vc7eDGWZ3MJ9ET8jKFvjzy/sJpdqD5ZNUB/zjj+oIfT3CikTQkHpyd
         cszn6kqKIVTFRsA13qcuyxnpnlwrVk1xxB3qbM0P2fYtltWg9apxjFAZKZK4SuX63Wca
         MEpbZeMSIOdMYqzGBEMOWJK3YyNen/Gu7ZsB3o25ZTTUuw9S7KkNWDGwa5+ltiubV0UL
         xjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696615003; x=1697219803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KSCSizx6FgkyRIW0X32uY+4ZXkb204qdp7z+rYedcrk=;
        b=X/2nvydJjYP67Gq808j/FT/Uwxx/8mu+cQPzX4+WqhIuiOxYR+V95hnRk1mWM+z93Q
         gqfmsH979kO1YgrQ+CdZ5S1/7RUY+G9nwzU+14xZe5DAkupfRs1FV21lgG10n8ShBwtv
         Wg3PCBF4aaTvmstL5NgkTHIgXF2CeaG0tBalV5U0ioWMk1/boQRMdqmvo/nE7ekMOh5n
         +CA50xfmg4El+m6a/8ijoAVWDe7MHPFbEL3pQKOIGJtXZFsQflcpXaXMRTwXnN7Iu7wf
         clWA9yNYDvKnNJo7newLSq60kJwIXWx/5NGK19BJOUw3ZIHTUx3dz9ozVW5WMMZMkR9d
         bvSQ==
X-Gm-Message-State: AOJu0Yy2BJc5q8XLMwUxhpu0PNiClhYOei+fg2tWGYQsyig4L+nn9oMw
        W01CDz/aam6odhh2yYIpittPx5cqL/hmjuySsqrjHg==
X-Google-Smtp-Source: AGHT+IFginRxo8IyMdo5XT8uPhfon+vST76i33p+mAlSB+loxSygqvparl4usE/bieB3hvzQ+T43mG/e0PrIrtMO1wU=
X-Received: by 2002:a0d:d611:0:b0:577:1560:9e17 with SMTP id
 y17-20020a0dd611000000b0057715609e17mr9380421ywd.35.1696615002833; Fri, 06
 Oct 2023 10:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <1696436821-14261-1-git-send-email-quic_khsieh@quicinc.com> <1696436821-14261-6-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1696436821-14261-6-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 6 Oct 2023 20:56:31 +0300
Message-ID: <CAA8EJprAQqNUvY8CMkKbUNEWo1vO1ZkgZzk4zhvAsuLc46KeXg@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] drm/msm/dp: incorporate pm_runtime framework into
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2023 at 19:27, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> Currently DP driver is executed independent of PM runtime framework.
> This leads msm eDP panel can not being detected by edp_panel driver during
> generic_edp_panel_probe() due to AUX DPCD read failed at edp panel driver.
> Incorporate PM runtime framework into DP driver so that host controller's
> power and clocks are enable/disable through PM runtime mechanism.
> Once PM runtime framework is incorporated into DP driver, waking up device
> from power up path is not necessary. Hence remove it.
>
> After incorporating pm_runtime framework into eDP/DP driver, dp_pm_suspend()
> to handle power off both DP phy and controller during suspend and
> dp_pm_resume() to handle power on both DP phy and controller during resume
> are not necessary. Therefore both dp_pm_suspend() and dp_pm_resume() are
> dropped and replace with dp_pm_runtime_suspend() and dp_pm_runtime_resume()
> respectively.
>
> Changes in v5:
> -- remove pm_runtime_put_autosuspend feature, use pm_runtime_put_sync() directly
> -- squash add pm_runtime_force_suspend()/resume() patch into this patch
>
> Changes in v4:
> -- reworded commit text to explain why pm_framework is required for edp panel
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
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_aux.c     |   5 ++
>  drivers/gpu/drm/msm/dp/dp_display.c | 166 ++++++++++++------------------------
>  drivers/gpu/drm/msm/dp/dp_power.c   |  16 ----
>  drivers/gpu/drm/msm/dp/dp_power.h   |  11 ---
>  4 files changed, 59 insertions(+), 139 deletions(-)

[skipped]

> @@ -1702,6 +1638,12 @@ void dp_bridge_hpd_enable(struct drm_bridge *bridge)
>         struct dp_display_private *dp = container_of(dp_display, struct dp_display_private, dp_display);
>
>         mutex_lock(&dp->event_mutex);
> +       if (pm_runtime_resume_and_get(&dp->pdev->dev)) {
> +               DRM_ERROR("failed to start power\n");

It was in the previous review comment:

"failed to resume".

> +               mutex_unlock(&dp->event_mutex);
> +               return;
> +       }
> +

-- 
With best wishes
Dmitry
