Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FECB7AC47C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 20:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjIWSpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 14:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjIWSpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 14:45:42 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66442192
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:45:36 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-59f6492b415so3729437b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695494735; x=1696099535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GmaXvBuWa7AvubraK1rqvA0Y3W4i4RTGV9iuI7F73tQ=;
        b=jIvXCGKo9I1DQzZMHANuPcidttZEFYKbH/Fs5bpACAdICj6XTU5iYe7bcB/iVdvg3e
         uraJIygLe5U2USFilIvToGOql/J4hVFmsTtzF/5TKuQ0LFrh7blQMcLRYAtHhJFizF25
         xd3JSSN46jjSSS3fYJhlhrm0w9Y9AYMMZrXwNRGwlxJPQ3clkH16DYGDBTxCgiY5YiEg
         0eQ11KATPn+Iu1Z7rK1eqfvX3kqa2AxYTxFuQv3Iw7KcmKzZa1uZcxAbtwSlWR/vEHrP
         Scwuv/xVRp8xHccMBgOpgOwxHTNOW5f/exrYVYVnt5FBuIx+e4iz9WFYet2M/Miotq/G
         VeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695494735; x=1696099535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GmaXvBuWa7AvubraK1rqvA0Y3W4i4RTGV9iuI7F73tQ=;
        b=ReHO2og6DBbzUU03WL0AHBqTZo+z9ebDLpD/aHH2x4ygKKrT/S9VJS7umxWhpgHW0i
         sZP5EwhpEqn8wtM5mVILqrS//bpU0ygI+5Iw8D9i4UNe4cQmQGEzWr9LBF5z0TTkeseq
         wU32s85bf1W2dQCOhrrhsVaW9A04U2HRJfcoqZFZV3bBu72lODYYgrswenxhv2GXYxUI
         8gZjRnlL9cnrW+xLwRH+hhKJcfDn0utGy5d5PJ6mhcX9OrQSxQTrEIG7QibZMJbHxhiO
         9+Oot3Sj+yhekCnmO9rdnq4sXLmlkUTxYGfKGJTuTVOJP6YEpiNjs3jZk+t8lOHPgN6A
         e8pg==
X-Gm-Message-State: AOJu0Yy0soBez/XT+DqFXUMMycElAwGd8FBCEi/strnqXVa571MpwpsX
        5WZeKhHH9CrLUjZ0iVLSUx5eaPhoNELFMdeFVbI/Dg==
X-Google-Smtp-Source: AGHT+IHUX/HpZOHnPohy3vbcV4DvnRkwtBEzkQ60I21JGnwItYErq9DaNssYhIBNS9II39Q3/GLOrpeU1DuEsvI6y4A=
X-Received: by 2002:a81:bc0c:0:b0:59f:3343:951b with SMTP id
 a12-20020a81bc0c000000b0059f3343951bmr3528849ywi.4.1695494735537; Sat, 23 Sep
 2023 11:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <1694813901-26952-1-git-send-email-quic_khsieh@quicinc.com>
 <1694813901-26952-2-git-send-email-quic_khsieh@quicinc.com>
 <CAA8EJprRFYMF-6yxcL75rftfii0kt7hmg_+TeOMJw+BRyDYdeg@mail.gmail.com> <1c82a0a6-d85f-9800-bdc4-2a4892b4239b@quicinc.com>
In-Reply-To: <1c82a0a6-d85f-9800-bdc4-2a4892b4239b@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 23 Sep 2023 21:45:23 +0300
Message-ID: <CAA8EJpoW8COZD7+yg9oZ=k=x36+XQKaJgvhab=XZPwTVuixh2A@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sept 2023 at 02:03, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
>
> On 9/15/2023 5:29 PM, Dmitry Baryshkov wrote:
> > On Sat, 16 Sept 2023 at 00:38, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
> >> Currently the dp_display_irq_handler() is executed at msm_dp_modeset_init()
> >> which ties irq registration to the DPU device's life cycle, while depending on
> >> resources that are released as the DP device is torn down. Move register DP
> >> driver irq handler at dp_display_probe() to have dp_display_irq_handler()
> >> is tied with DP device.
> >>
> >> Changes in v3:
> >> -- move calling dp_display_irq_handler() to probe
> > Was there a changelog for the previous reivions? What is the
> > difference between v1 and v2?
> >
> >> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> >> ---
> >>   drivers/gpu/drm/msm/dp/dp_display.c | 35 +++++++++++++----------------------
> >>   drivers/gpu/drm/msm/dp/dp_display.h |  1 -
> >>   2 files changed, 13 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> >> index 76f1395..c217430 100644
> >> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> >> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> >> @@ -1193,30 +1193,23 @@ static irqreturn_t dp_display_irq_handler(int irq, void *dev_id)
> >>          return ret;
> >>   }
> >>
> >> -int dp_display_request_irq(struct msm_dp *dp_display)
> >> +static int dp_display_request_irq(struct dp_display_private *dp)
> >>   {
> >>          int rc = 0;
> >> -       struct dp_display_private *dp;
> >> -
> >> -       if (!dp_display) {
> >> -               DRM_ERROR("invalid input\n");
> >> -               return -EINVAL;
> >> -       }
> >> -
> >> -       dp = container_of(dp_display, struct dp_display_private, dp_display);
> >> +       struct device *dev = &dp->pdev->dev;
> >>
> >> -       dp->irq = irq_of_parse_and_map(dp->pdev->dev.of_node, 0);
> >>          if (!dp->irq) {
> > What is the point in this check?
> >
> >> -               DRM_ERROR("failed to get irq\n");
> >> -               return -EINVAL;
> >> +               dp->irq = platform_get_irq(dp->pdev, 0);
> >> +               if (!dp->irq) {
> >> +                       DRM_ERROR("failed to get irq\n");
> >> +                       return -EINVAL;
> >> +               }
> >>          }
> >>
> >> -       rc = devm_request_irq(dp_display->drm_dev->dev, dp->irq,
> >> -                       dp_display_irq_handler,
> >> +       rc = devm_request_irq(dev, dp->irq, dp_display_irq_handler,
> >>                          IRQF_TRIGGER_HIGH, "dp_display_isr", dp);
> >>          if (rc < 0) {
> >> -               DRM_ERROR("failed to request IRQ%u: %d\n",
> >> -                               dp->irq, rc);
> >> +               DRM_ERROR("failed to request IRQ%u: %d\n", dp->irq, rc);
> >>                  return rc;
> >>          }
> >>
> >> @@ -1287,6 +1280,10 @@ static int dp_display_probe(struct platform_device *pdev)
> >>
> >>          platform_set_drvdata(pdev, &dp->dp_display);
> >>
> >> +       rc = dp_display_request_irq(dp);
> >> +       if (rc)
> >> +               return rc;
> > This way the IRQ ends up being enabled in _probe. Are we ready to
> > handle it here? Is the DP device fully setup at this moment?
>
> The irq is enabled here.
>
> but DP driver hpd hardware block has not yet be enabled. this means no
> irq will be delivered.

There are other IRQ kinds, not only just HPD ones.

>
>   .hpd_enable() will call pm_runtime_resume_and_get() and
> dp_catalog_ctrl_hpd_enable().
>
> after .hpd_enable() irq will be delivered and handled properly.
>
>
>
> >> +
> >>          rc = component_add(&pdev->dev, &dp_display_comp_ops);
> >>          if (rc) {
> >>                  DRM_ERROR("component add failed, rc=%d\n", rc);
> >> @@ -1549,12 +1546,6 @@ int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
> >>
> >>          dp_priv = container_of(dp_display, struct dp_display_private, dp_display);
> >>
> >> -       ret = dp_display_request_irq(dp_display);
> >> -       if (ret) {
> >> -               DRM_ERROR("request_irq failed, ret=%d\n", ret);
> >> -               return ret;
> >> -       }
> >> -
> >>          ret = dp_display_get_next_bridge(dp_display);
> >>          if (ret)
> >>                  return ret;
> >> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> >> index 1e9415a..b3c08de 100644
> >> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> >> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> >> @@ -35,7 +35,6 @@ struct msm_dp {
> >>   int dp_display_set_plugged_cb(struct msm_dp *dp_display,
> >>                  hdmi_codec_plugged_cb fn, struct device *codec_dev);
> >>   int dp_display_get_modes(struct msm_dp *dp_display);
> >> -int dp_display_request_irq(struct msm_dp *dp_display);
> >>   bool dp_display_check_video_test(struct msm_dp *dp_display);
> >>   int dp_display_get_test_bpp(struct msm_dp *dp_display);
> >>   void dp_display_signal_audio_start(struct msm_dp *dp_display);
> >> --
> >> 2.7.4
> >>
> >



-- 
With best wishes
Dmitry
