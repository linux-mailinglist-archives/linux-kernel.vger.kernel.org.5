Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22407B0DD1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 23:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjI0VF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 17:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI0VF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:05:57 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD8F11F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 14:05:55 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a200028437so24440357b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 14:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695848755; x=1696453555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uStOTeDx0/Ukuzu0JJvG25AFIJvkKa932ouE8HZ3uLs=;
        b=z0sshQMWAqSeBB03ZNcweIEs2rEq1Qvb/zopT+0FjYOhr0/wZTnl/PGUgd82+5ZyPx
         U/RRBKv0g2K5e9oXX1Bb3E81pf8+wUmOfrKHbb0SlZoPDZ2+h4ycWG4O89shi86574UM
         RL3E1qdCA55JlTqNSK1FwftnC90PubdrjbFGJ4gZtXwovAJb/9xzMJN8fzLtPCfrUBoH
         PhuRtk2irR0peB/dh9gHN/65RhSvE1/6Jgq9o844+Ucw+dcstU121uCuvmZtGS1IvQTI
         WjDPlSYqgkJt66EEjQZXiWJ2SFf0pLE+11yGLTdt1YPvaAk0e3hIHXA6gMB84QHXl6vO
         C9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695848755; x=1696453555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uStOTeDx0/Ukuzu0JJvG25AFIJvkKa932ouE8HZ3uLs=;
        b=YPh8ZNVxyidxmLKcmz1w0lxdn+Fq0Bm5uo91fqpv7Z0DyELd/z2ZAZs6hcuwpUjZwA
         zEDsNjvhNhgeI+vbGgz9tsUQwU/9/YtAZqdFEJQ4qWF7VmmkUVV4bnU+8R8K3Q6fyY/Q
         7gtrfN3yZIEEvfDaxjoelEhCQlYsJOQ4326w6E0ubSlAWvvYN9y0ZRCJIFKUhEsGr9/T
         4KZkyF3dHaqxUqxm0whmSrwPDXfYICV5mogTfv/szFcp0ckW9Mt6bTUA2Z+4OPNDEjYq
         DFKj3pcU6J+BCEItKcnnyTH8kuJWZRoMESI+u+za5Xpe9ZtEog1AO2/e7bcS9MnD/BAq
         kKYQ==
X-Gm-Message-State: AOJu0YwAh92UU8crq2fgE8HsvUeDUfauuyjNitJ0Snw9PyV1kH/1QjW0
        bR76/40aPi1kmXGjj83rNwt0c8xvo23AABbBU+oEsw==
X-Google-Smtp-Source: AGHT+IE0km6y8O5Y6e29Gn2cDaSHvokzeKWCzYSEz0u70AbH6xc5f8kdSMkaI9/l/srJYZ/TK7N++QbvgI4+vUtVqkk=
X-Received: by 2002:a0d:e684:0:b0:576:93f1:d118 with SMTP id
 p126-20020a0de684000000b0057693f1d118mr3624518ywe.2.1695848754752; Wed, 27
 Sep 2023 14:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <1695848028-18023-1-git-send-email-quic_khsieh@quicinc.com> <1695848028-18023-2-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1695848028-18023-2-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 28 Sep 2023 00:04:47 +0300
Message-ID: <CAA8EJpqB-sDsQiWmqQS+cxnupTeGBv4G9RcV8vJT3CnWqEbP8g@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] drm/msm/dp: tie dp_display_irq_handler() with dp driver
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
> Currently the dp_display_irq_handler() is executed at msm_dp_modeset_init()

dp_display_request_irq()

> which ties irq registration to the DPU device's life cycle, while depending on
> resources that are released as the DP device is torn down. Move register DP

`registering` or `registration of`

> driver irq handler at dp_display_probe() to have dp_display_irq_handler()

IRQ, s/at/to/

> is tied with DP device.

s/is //

Moreover, your commit does more that you have described in the commit
message. It also e.g. switches to platform_get_irq().

>
> Changes in v4:
> -- delete dp->irq check at dp_display_request_irq()
>
> Changes in v3:
> -- move calling dp_display_irq_handler() to probe
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 29 +++++++++--------------------
>  drivers/gpu/drm/msm/dp/dp_display.h |  1 -
>  2 files changed, 9 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 76f1395..5645178 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1193,30 +1193,21 @@ static irqreturn_t dp_display_irq_handler(int irq, void *dev_id)
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
> +       dp->irq = platform_get_irq(dp->pdev, 0);
>         if (!dp->irq) {
>                 DRM_ERROR("failed to get irq\n");
>                 return -EINVAL;
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

Please don't mix functional changes with code reformatting.

>                 return rc;
>         }
>
> @@ -1287,6 +1278,10 @@ static int dp_display_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, &dp->dp_display);
>
> +       rc = dp_display_request_irq(dp);
> +       if (rc)
> +               return rc;

Who will perform component teardown for you if the driver just returns
an error here?

> +
>         rc = component_add(&pdev->dev, &dp_display_comp_ops);
>         if (rc) {
>                 DRM_ERROR("component add failed, rc=%d\n", rc);
> @@ -1549,12 +1544,6 @@ int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
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
