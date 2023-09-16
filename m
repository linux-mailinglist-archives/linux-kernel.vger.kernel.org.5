Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C347A2C04
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 02:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbjIPAbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 20:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbjIPAbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:31:25 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5C9E78
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:30:06 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d7f0048b042so2633719276.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694824205; x=1695429005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UKG1f2vWtn3rxoFyylQkmHI05xPy2LbsMYzfeNRbE94=;
        b=dI7t50bSxp84h7CzuUwA9fhTb4D46V57Vk91JhHBGnNhpYobTJGZPEnTtYAR4JG2UT
         2FkS/9xJ0AXM/YeR0mnI8i8YsTq1RTmd3adPpsFaEkoc2/T7BG+OMvFoRVCN1C5nKnqk
         2u2zQ8NtTMAvLbtwVaWFJMqW8tSmKbKdtwbd9WfR9fQk5bHxsDxMIp2BpB+SwBNurdzn
         C6KzHjHsIhBqnRu4VcdTTGibVhevQdM3LIERpngjwXa9DMxNT/v7wu5HKmeLUEzQim8r
         O7oKUMqhjQsA7y4p2gejJ9a7FK0pbzoBrAxk+kVUOT2EEHo4nOSn/YtX1okNYp4/EzIw
         uGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694824205; x=1695429005;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKG1f2vWtn3rxoFyylQkmHI05xPy2LbsMYzfeNRbE94=;
        b=CRRt7w/D+EyBLBII//HkmDUsHCTfD0tEGdiLjHnGS+k35wZOYEyJUtBfDdUVDIT7Lb
         ZN/T32GBYJd6G8oh7p0/4TvSHk4CwhczQnHF4ko+Fdpei8MDK3uvH9VW6Fdcul+asMNK
         0n3E4TlW0DaXyAlhzF+NDuVl8M/QGW/+D82V/UsEVP26f0nCDKRcSQ19xY9Hqw4lVch4
         jLB+3NCPCcPf26+eqaWrkjWB1+Ly5lCKAKkzLzf3MBozWINJ5yAQkeS9db1P8czZ31fn
         s3I6DmR6tMK5vtwBV3vcJ6NY14PGRIh/xPwX/7GgFRQu25IfXVYWXHLudIUNViL3fs3i
         YZ0Q==
X-Gm-Message-State: AOJu0YxifOJ1xnJAK9laCtv9uUlVQWbBD2Bw2rQVLb0yrMNfOEsMrT2J
        OFeYs6PmRs24N5YJACVsIPqrQo0HTY2bMlkj5E5wsA==
X-Google-Smtp-Source: AGHT+IHhX/JKjbZ7l2rDepEtwshKF9tSkcCpppE/UlOx5xZD7LfakyNxo9z3pYuUtsI9K2yh4+/L5L/0ntvja0Xr3xI=
X-Received: by 2002:a25:b30f:0:b0:d7b:9f03:20cc with SMTP id
 l15-20020a25b30f000000b00d7b9f0320ccmr3240208ybj.32.1694824205419; Fri, 15
 Sep 2023 17:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <1694813901-26952-1-git-send-email-quic_khsieh@quicinc.com> <1694813901-26952-2-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1694813901-26952-2-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 16 Sep 2023 03:29:54 +0300
Message-ID: <CAA8EJprRFYMF-6yxcL75rftfii0kt7hmg_+TeOMJw+BRyDYdeg@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] drm/msm/dp: tie dp_display_irq_handler() with dp driver
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Sept 2023 at 00:38, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> Currently the dp_display_irq_handler() is executed at msm_dp_modeset_init()
> which ties irq registration to the DPU device's life cycle, while depending on
> resources that are released as the DP device is torn down. Move register DP
> driver irq handler at dp_display_probe() to have dp_display_irq_handler()
> is tied with DP device.
>
> Changes in v3:
> -- move calling dp_display_irq_handler() to probe

Was there a changelog for the previous reivions? What is the
difference between v1 and v2?

>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 35 +++++++++++++----------------------
>  drivers/gpu/drm/msm/dp/dp_display.h |  1 -
>  2 files changed, 13 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 76f1395..c217430 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1193,30 +1193,23 @@ static irqreturn_t dp_display_irq_handler(int irq, void *dev_id)
>         return ret;
>  }
>
> -int dp_display_request_irq(struct msm_dp *dp_display)
> +static int dp_display_request_irq(struct dp_display_private *dp)
>  {
>         int rc = 0;
> -       struct dp_display_private *dp;
> -
> -       if (!dp_display) {
> -               DRM_ERROR("invalid input\n");
> -               return -EINVAL;
> -       }
> -
> -       dp = container_of(dp_display, struct dp_display_private, dp_display);
> +       struct device *dev = &dp->pdev->dev;
>
> -       dp->irq = irq_of_parse_and_map(dp->pdev->dev.of_node, 0);
>         if (!dp->irq) {

What is the point in this check?

> -               DRM_ERROR("failed to get irq\n");
> -               return -EINVAL;
> +               dp->irq = platform_get_irq(dp->pdev, 0);
> +               if (!dp->irq) {
> +                       DRM_ERROR("failed to get irq\n");
> +                       return -EINVAL;
> +               }
>         }
>
> -       rc = devm_request_irq(dp_display->drm_dev->dev, dp->irq,
> -                       dp_display_irq_handler,
> +       rc = devm_request_irq(dev, dp->irq, dp_display_irq_handler,
>                         IRQF_TRIGGER_HIGH, "dp_display_isr", dp);
>         if (rc < 0) {
> -               DRM_ERROR("failed to request IRQ%u: %d\n",
> -                               dp->irq, rc);
> +               DRM_ERROR("failed to request IRQ%u: %d\n", dp->irq, rc);
>                 return rc;
>         }
>
> @@ -1287,6 +1280,10 @@ static int dp_display_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, &dp->dp_display);
>
> +       rc = dp_display_request_irq(dp);
> +       if (rc)
> +               return rc;

This way the IRQ ends up being enabled in _probe. Are we ready to
handle it here? Is the DP device fully setup at this moment?

> +
>         rc = component_add(&pdev->dev, &dp_display_comp_ops);
>         if (rc) {
>                 DRM_ERROR("component add failed, rc=%d\n", rc);
> @@ -1549,12 +1546,6 @@ int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
>
>         dp_priv = container_of(dp_display, struct dp_display_private, dp_display);
>
> -       ret = dp_display_request_irq(dp_display);
> -       if (ret) {
> -               DRM_ERROR("request_irq failed, ret=%d\n", ret);
> -               return ret;
> -       }
> -
>         ret = dp_display_get_next_bridge(dp_display);
>         if (ret)
>                 return ret;
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index 1e9415a..b3c08de 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -35,7 +35,6 @@ struct msm_dp {
>  int dp_display_set_plugged_cb(struct msm_dp *dp_display,
>                 hdmi_codec_plugged_cb fn, struct device *codec_dev);
>  int dp_display_get_modes(struct msm_dp *dp_display);
> -int dp_display_request_irq(struct msm_dp *dp_display);
>  bool dp_display_check_video_test(struct msm_dp *dp_display);
>  int dp_display_get_test_bpp(struct msm_dp *dp_display);
>  void dp_display_signal_audio_start(struct msm_dp *dp_display);
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
