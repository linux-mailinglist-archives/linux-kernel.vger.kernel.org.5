Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77AB7B0DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 23:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjI0VQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 17:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0VQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:16:55 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283B9122
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 14:16:54 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59c26aa19b7so148764977b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 14:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695849413; x=1696454213; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Egs/0a9obKo4OfCKrbX3EcZMRe8x/y6shojMDmUEqA=;
        b=gRECJSkTVjSOni0ZSLw+1dRD7hn4qtm8PSEty/o72krOagDguiM6p9NPOuSLSemNjx
         XcMxSZLiJp2hYRl7SOoll4r5ojDqNxY2n0766+s6SIH66G1/lE9OUEp+KNfr+ofq1Nvi
         JZ5VaqAoeT/01bDXmB6dqfHVKmcNQ7mhTGmbyPIo0KJLyoxLyelKdH28OcxrApaqiqxI
         OU0/7SsDoXfH0EArKsyYypBvKFC/spGGE9fegOEi+uia7YZ4vJGwRC1G5H507QKGO1Fe
         IN3PRojAeYbRgCRhoK0ZMNA3VUi8Q5G93HOqOLHellSTlpIa9SB/BbswNE9bsowZSFdA
         OR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695849413; x=1696454213;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Egs/0a9obKo4OfCKrbX3EcZMRe8x/y6shojMDmUEqA=;
        b=pzHrUkSqKCvm1XcQNd8thMsezPvK6pKatcCYN2z8/YHTdAdgHAyvLfOZefSMCRbwR7
         jwJZDoBHO2urErHLBWm2X77aOiPsthV4yfAEoJgcYkSu7tZ6DAyyNMqiWqtJ8W1+Fv54
         jk1KuHyx3VX5Z08lHftNu57IUHE+rwE1GaOpJkoaNepI3vXZniGrL0Q3tmabqE/BP9Ed
         57y5WPYFOaSRPmZssi+JH9zHvnlPB8Nrln0WkcQb6RFSwRe0kcJhi5xBfRBzCYCwpuFs
         5dGCy+eGk5goU0tAjSjhQWRFlUBwSOnyHUB6FazfuZ6IImv0gf/YkL7WGxQv5Dd67PPD
         mX1Q==
X-Gm-Message-State: AOJu0YxkE0vCdZeliT3iqUEnRW9dYXCwG3Nas22ydOeAeSkoMeAye02P
        G5jDfPV8e5b+sxyNtQF7YvrgUQQF/5mLhcrgctc1hw==
X-Google-Smtp-Source: AGHT+IGO1KiVE2bI8blvCLR/sjY97K/2QcJne6dK+EgiphioOMUo1x3UAeM4EbLQnYd1r63pwHNusKznnhSsSR1nJT0=
X-Received: by 2002:a0d:fa82:0:b0:59f:5361:d18c with SMTP id
 k124-20020a0dfa82000000b0059f5361d18cmr3552091ywf.41.1695849413286; Wed, 27
 Sep 2023 14:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <1695848028-18023-1-git-send-email-quic_khsieh@quicinc.com> <1695848028-18023-5-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1695848028-18023-5-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 28 Sep 2023 00:15:46 +0300
Message-ID: <CAA8EJprubda19zW=XBRp-ORQwEB1YYrmkUiqmy5gH5TzCM8bhQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] drm/msm/dp: move parser->parse() and
 dp_power_client_init() to probe
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
> Move parser->parse() and dp_power_client_init() from dp_display_bind()
> to dp_display_probe() in preparation of adding pm_runtime framework
> at next patch.

This describes what the patch does, not why it is done. Could you
please rewrite it to describe the reason for the change?

>
> Changes in v4:
> -- split this patch out of "incorporate pm_runtime framework into DP driver" patch
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 7ae3b8b..3ef141c 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -276,11 +276,6 @@ static int dp_display_bind(struct device *dev, struct device *master,
>         dp->dp_display.drm_dev = drm;
>         priv->dp[dp->id] = &dp->dp_display;
>
> -       rc = dp->parser->parse(dp->parser);
> -       if (rc) {
> -               DRM_ERROR("device tree parsing failed\n");
> -               goto end;
> -       }
>
>
>         dp->drm_dev = drm;
> @@ -291,11 +286,6 @@ static int dp_display_bind(struct device *dev, struct device *master,
>                 goto end;
>         }
>
> -       rc = dp_power_client_init(dp->power);
> -       if (rc) {
> -               DRM_ERROR("Power client create failed\n");
> -               goto end;
> -       }
>
>         rc = dp_register_audio_driver(dev, dp->audio);
>         if (rc) {
> @@ -1249,6 +1239,18 @@ static int dp_display_probe(struct platform_device *pdev)
>                 return -EPROBE_DEFER;
>         }
>
> +       rc = dp->parser->parse(dp->parser);
> +       if (rc) {
> +               DRM_ERROR("device tree parsing failed\n");
> +               return -EPROBE_DEFER;
> +       }
> +
> +       rc = dp_power_client_init(dp->power);
> +       if (rc) {
> +               DRM_ERROR("Power client create failed\n");
> +               return -EPROBE_DEFER;
> +       }
> +
>         /* setup event q */
>         mutex_init(&dp->event_mutex);
>         init_waitqueue_head(&dp->event_q);
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
