Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2163E7E1839
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 01:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjKFA6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 19:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFA6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 19:58:54 -0500
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Nov 2023 16:58:49 PST
Received: from devico.uberspace.de (devico.uberspace.de [185.26.156.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5539FE6
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 16:58:49 -0800 (PST)
Received: (qmail 5941 invoked by uid 990); 6 Nov 2023 00:52:06 -0000
Authentication-Results: devico.uberspace.de;
        auth=pass (plain)
Message-ID: <06d6a503-7770-4e99-a4be-9a2870678d56@lausen.nl>
Date:   Sun, 5 Nov 2023 19:51:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Freedreno] [PATCH v7 0/7] incorporate pm runtime framework and
 eDP clean up
Content-Language: en-US
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org
Cc:     quic_sbillaka@quicinc.com, linux-arm-msm@vger.kernel.org,
        quic_abhinavk@quicinc.com, marijn.suijten@somainline.org,
        quic_jesszhan@quicinc.com, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1696632910-21942-1-git-send-email-quic_khsieh@quicinc.com>
From:   Leonard Lausen <leonard@lausen.nl>
In-Reply-To: <1696632910-21942-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Bar: -
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-2.678521) XM_UA_NO_VERSION(0.01) MIME_GOOD(-0.1)
X-Rspamd-Score: -1.268521
Received: from unknown (HELO unkown) (::1)
        by devico.uberspace.de (Haraka/3.0.1) with ESMTPSA; Mon, 06 Nov 2023 01:52:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=lausen.nl; s=uberspace;
        h=from;
        bh=Ikukj+p56W9fQ+/M9OzNzKR+W0ErNk+42/TcUwyRmz0=;
        b=R2auO9p68OArumCmabX5uYYT0C0H3wZauRF9PztKLs7FLVT6uxoqb02hZYFFVaNqoB+gvazJ9X
        43YA6vm+ky8XGD6kfG1QMfcTWCjsrIPNNt59r9NNmonQhvZXSGi/GYO+JIujTn0vfFgM3HGEnNPF
        q35YswdGLjiGLPEDb27r/WfezTmV2GzNhtFvXWDpT4CcSfbyTSc05nBJreSjpgnL/kgRfBHjuomM
        dLNSewaBYEW4ac09AZJeKQMET2gSHHWXevgjTU3zwZaK254fE15xr6F0bJ6LpIuz2IK5+ya9NWjp
        g5CyRNhuZ/89Pe/jxhm3phufaAvB0ItHmsqzB+eSryCtd2/FbhZmzZ7eiRGvuXBGnnlx5AOZuXPA
        qbXifh/Dc4Z5xsQY5w48uLecsLgd0tNPYruHkR073iWS1hQ/ACf5RVn5ZItdhUyFcxLzXyMgXKzL
        4MJkwDleW5c15mAbLRk2+uYk+mHqGhnR6ZU5TeS/tq3ai3RqvNO13TdoI3FGMvwiGXqNbLxqavTN
        Zh7MKFEycnKQ7QqTxuizVNDglIp2WgrBV2C4wqUH+oHOjT3cc+atYiG9IkirZUF4u9vgVAnECm2/
        XpwzOSHbTiE9wX4o+n3kQ3tgabMXGw2R6rjsi/obMgTO3d2yUvuFh3mR64rgkVksQlDRbUfgEWYR
        w=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Verified this fixes the "[drm:drm_mode_config_helper_resume] *ERROR* Failed to
resume (-107)" issue https://gitlab.freedesktop.org/drm/msm/-/issues/25

Tested-by: Leonard Lausen <leonard@lausen.nl> # on sc7180 lazor

On 10/6/23 18:55, Kuogee Hsieh wrote:
> The purpose of this patch series is to incorporate pm runtime framework
> into MSM eDP/DP driver so that eDP panel can be detected by DRM eDP panel
> driver during system probe time. During incorporating procedure, original
> customized pm realted fucntions, such as dp_pm_prepare(), dp_pm_suspend(),
> dp_pm_resume() and dp_pm_prepare(), are removed and replaced with functions
> provided by pm runtiem framework such as pm_runtime_force_suspend() and
> pm_runtime_force_resume(). In addition, both eDP aux-bus and irq handler
> are bound at system probe time too.
> 
> Kuogee Hsieh (7):
>   drm/msm/dp: tie dp_display_irq_handler() with dp driver
>   drm/msm/dp: rename is_connected with link_ready
>   drm/msm/dp: use drm_bridge_hpd_notify() to report HPD status changes
>   drm/msm/dp: move parser->parse() and dp_power_client_init() to probe
>   drm/msm/dp: incorporate pm_runtime framework into DP driver
>   drm/msm/dp: delete EV_HPD_INIT_SETUP
>   drm/msm/dp: move of_dp_aux_populate_bus() to eDP probe()
> 
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c |   4 -
>  drivers/gpu/drm/msm/dp/dp_aux.c         |  39 +++-
>  drivers/gpu/drm/msm/dp/dp_display.c     | 333 ++++++++++++--------------------
>  drivers/gpu/drm/msm/dp/dp_display.h     |   3 +-
>  drivers/gpu/drm/msm/dp/dp_drm.c         |  14 +-
>  drivers/gpu/drm/msm/dp/dp_power.c       |  16 --
>  drivers/gpu/drm/msm/dp/dp_power.h       |  11 --
>  drivers/gpu/drm/msm/msm_drv.h           |   5 -
>  8 files changed, 161 insertions(+), 264 deletions(-)
> 
