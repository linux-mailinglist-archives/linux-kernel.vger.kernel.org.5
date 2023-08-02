Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C795C76D6D1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjHBSZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjHBSZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:25:18 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F8F1717
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 11:25:17 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d167393b95aso1833809276.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 11:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691000716; x=1691605516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5rqnhpukvnuroNpgIhuZ9KfllzGzBjkAWHO7GNn33Zk=;
        b=tdRmHORtrVoProVKvDSNsGAlMh6mwrIM4BGH/OGo+JVYBufe7LKoaKZCOFd71mVztY
         6xkHD5yCeVF6KBSYOy+BWCcf72ACYn40XNHI/oZocmLWnrgaKX9IDmQNicEhOdZO4vTJ
         QXM6flWto7fGK8mbbKG1CuYY9hDOcIBiGyVkqMopus0PR+4p7NzhIKat8qPeepBJIkfA
         oBSOD1LnxQ4uoN/TkOL+IgLy/I8OyZClvbmizvM+c1wrUm2/IIz2THu9ca4L94pByOcO
         NtXJcb2FxwGlBF4c4Z+QSlS/saM30gG2XtmZhBdp0kCH8l+SviR2gVLCkSg6s+RuMIxX
         fSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691000716; x=1691605516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5rqnhpukvnuroNpgIhuZ9KfllzGzBjkAWHO7GNn33Zk=;
        b=QoQEwkRN1KpZueqbLkoVYLy8bXFp9CCtPmT/WNzVDRXuI/OI9ZTgLdUrp2MRSvjjWL
         wm00QXalfvlJDG4DqFPnhVyUGNIw+1ikT3GGl7isnABd87fPgCED0AK4ShYfalR5IpAz
         rFk1kOFgCSCg8ukDaiT1VgY7+X0FUbwa3qH9OQ86SYH3D4Rw6FkqvaJ4wbRh6GFtgF/l
         I1eTq6Kj+47qUDNBLL7LjOD0rsfAN3sk1qOCJNyynHwbeGssFmM4vBOjNoN0SkE6lTeq
         QbBeOhxZZpnGY+x1kC7vcObjNa/LMxe0h2XGZ8CLwhgB8RRPmZbH6Dv08fp53EGw9eOu
         9L4g==
X-Gm-Message-State: ABy/qLaCkt5S43TYMLwDArIp6d3MHV7CdjjVKc+Qo86/jkbuuh7o5YYX
        UdQQMWeWF/rdU0gguyibcO3yTYWoewHXSrNNwSEYmg==
X-Google-Smtp-Source: APBJJlGURMqux6vjsKCyEZh5uiiRc2JPbZFyh118s++aogxKu7iUDz2oUe6gsb+DYPZiJrvV3yPjpFvKrpB5WxbFELI=
X-Received: by 2002:a25:d3d0:0:b0:d0e:3831:fa26 with SMTP id
 e199-20020a25d3d0000000b00d0e3831fa26mr21044770ybf.9.1691000716085; Wed, 02
 Aug 2023 11:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230802-add-widebus-support-v3-0-2661706be001@quicinc.com> <20230802-add-widebus-support-v3-4-2661706be001@quicinc.com>
In-Reply-To: <20230802-add-widebus-support-v3-4-2661706be001@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 2 Aug 2023 21:25:05 +0300
Message-ID: <CAA8EJpoodqcWXsvjjpfMhMxmmvjNfYu5KUM6iOxqxYRH6wxsRA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/msm/dsi: Enable widebus for DSI
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, quic_abhinavk@quicinc.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023 at 21:09, Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
>
> DSI 6G v2.5.x+ supports a data-bus widen mode that allows DSI to send
> 48 bits of compressed data instead of 24.
>
> Enable this mode whenever DSC is enabled for supported chipsets.
>
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi.c      |  5 +++++
>  drivers/gpu/drm/msm/dsi/dsi.h      |  1 +
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 30 ++++++++++++++++++++++++++----
>  3 files changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
> index baab79ab6e74..4fa738dea680 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi.c
> @@ -17,6 +17,11 @@ struct drm_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi)
>         return msm_dsi_host_get_dsc_config(msm_dsi->host);
>  }
>
> +bool msm_dsi_is_widebus_enabled(struct msm_dsi *msm_dsi)
> +{
> +       return msm_dsi_host_is_widebus_enabled(msm_dsi->host);
> +}

If this function is not provided at the time of the previous patch,
compilation will break. I'd suggest to provide a stub first and then
change it in this patch.

> +
>  static int dsi_get_phy(struct msm_dsi *msm_dsi)
>  {
>         struct platform_device *pdev = msm_dsi->pdev;
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
> index bd3763a5d723..a557d2c1aaff 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi.h
> @@ -134,6 +134,7 @@ int dsi_calc_clk_rate_6g(struct msm_dsi_host *msm_host, bool is_bonded_dsi);
>  void msm_dsi_host_snapshot(struct msm_disp_state *disp_state, struct mipi_dsi_host *host);
>  void msm_dsi_host_test_pattern_en(struct mipi_dsi_host *host);
>  struct drm_dsc_config *msm_dsi_host_get_dsc_config(struct mipi_dsi_host *host);
> +bool msm_dsi_host_is_widebus_enabled(struct mipi_dsi_host *host);
>
>  /* dsi phy */
>  struct msm_dsi_phy;
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 645927214871..231b02e5ab6e 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -710,6 +710,14 @@ static void dsi_ctrl_disable(struct msm_dsi_host *msm_host)
>         dsi_write(msm_host, REG_DSI_CTRL, 0);
>  }
>
> +bool msm_dsi_host_is_widebus_enabled(struct mipi_dsi_host *host)
> +{
> +       struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
> +
> +       return msm_host->dsc && (msm_host->cfg_hnd->major == MSM_DSI_VER_MAJOR_6G &&

Please add a line break after the first &&. Compare two following statements:

> +                       msm_host->cfg_hnd->minor >= MSM_DSI_6G_VER_MINOR_V2_5_0);
> +}
> +
>  static void dsi_ctrl_enable(struct msm_dsi_host *msm_host,
>                         struct msm_dsi_phy_shared_timings *phy_shared_timings, struct msm_dsi_phy *phy)
>  {
> @@ -753,10 +761,16 @@ static void dsi_ctrl_enable(struct msm_dsi_host *msm_host,
>                 data |= DSI_CMD_CFG1_INSERT_DCS_COMMAND;
>                 dsi_write(msm_host, REG_DSI_CMD_CFG1, data);
>
> -               if (msm_host->cfg_hnd->major == MSM_DSI_VER_MAJOR_6G &&
> -                   msm_host->cfg_hnd->minor >= MSM_DSI_6G_VER_MINOR_V1_3) {
> +               if (cfg_hnd->major == MSM_DSI_VER_MAJOR_6G) {
>                         data = dsi_read(msm_host, REG_DSI_CMD_MODE_MDP_CTRL2);
> -                       data |= DSI_CMD_MODE_MDP_CTRL2_BURST_MODE;
> +
> +                       if (cfg_hnd->minor >= MSM_DSI_6G_VER_MINOR_V1_3)
> +                               data |= DSI_CMD_MODE_MDP_CTRL2_BURST_MODE;
> +
> +                       /* TODO: Allow for video-mode support once tested/fixed */
> +                       if (msm_dsi_host_is_widebus_enabled(&msm_host->base))
> +                               data |= DSI_CMD_MODE_MDP_CTRL2_DATABUS_WIDEN;
> +
>                         dsi_write(msm_host, REG_DSI_CMD_MODE_MDP_CTRL2, data);
>                 }
>         }
> @@ -894,6 +908,7 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>         u32 hdisplay = mode->hdisplay;
>         u32 wc;
>         int ret;
> +       bool widebus_enabled = msm_dsi_host_is_widebus_enabled(&msm_host->base);
>
>         DBG("");
>
> @@ -914,6 +929,7 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>
>         if (msm_host->dsc) {
>                 struct drm_dsc_config *dsc = msm_host->dsc;
> +               u32 bytes_per_pclk;
>
>                 /* update dsc params with timing params */
>                 if (!dsc || !mode->hdisplay || !mode->vdisplay) {
> @@ -937,7 +953,13 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>                  * pulse width same
>                  */
>                 h_total -= hdisplay;
> -               hdisplay = DIV_ROUND_UP(msm_dsc_get_bytes_per_line(msm_host->dsc), 3);
> +               if (widebus_enabled && !(msm_host->mode_flags & MIPI_DSI_MODE_VIDEO))
> +                       bytes_per_pclk = 6;
> +               else
> +                       bytes_per_pclk = 3;
> +
> +               hdisplay = DIV_ROUND_UP(msm_dsc_get_bytes_per_line(msm_host->dsc), bytes_per_pclk);
> +
>                 h_total += hdisplay;
>                 ha_end = ha_start + hdisplay;
>         }
>
> --
> 2.41.0
>


-- 
With best wishes
Dmitry
