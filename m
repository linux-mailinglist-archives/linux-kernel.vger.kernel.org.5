Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E277B0DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 23:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjI0VTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 17:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjI0VS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:18:59 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAB111D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 14:18:57 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59f1dff5298so139452147b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 14:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695849536; x=1696454336; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UiA24Vnoe9mDlXFXQmDQoe2D01RtP5rHlDPFXWiZnis=;
        b=ttM3Al7pUoQkeKdTct1F1IMNr2Ar5gNr0ttE6KExq7MQzOIjjLUSSiCW+GJrnQZ67O
         nXDk8tBDX4JHLiaiKyGOCq4582bTakP0IvT6mNCFAXy9QQr9Ya71bpeh9N4dm5MoNJdf
         lLBqkYvjaqjFhL2hHBUxYZ32Dp1GWzdMbPk6TSWjxYOf4YGQ3KoSssImO7SzvOb3t63e
         1BwsN4kya3jzJ2VbYZ880ysNutgNGeIS9JYOAILtcdzmxrf6PFEoQlrRzXfLLrwLsV3P
         ZR8hQsUBZy25yqEut61VEzLIxHXjcXwaivUCgS0DdSfwWsgXm1dKIpo6Uw0378QL9LMh
         eCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695849536; x=1696454336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UiA24Vnoe9mDlXFXQmDQoe2D01RtP5rHlDPFXWiZnis=;
        b=k8lVaZfgSfVSp5W/pYLl/T7y5KCECAMSeaX2FCZqK2g2PKsJ6kcevpuXCm/MzO4H4J
         DGxPrZt7aqB1xWDLL2R1D77Kp+NXleSyD17gU6bt0WLS40Q7dr1y4SjdCcvpNtvBMOcA
         meUHz4WvQiL1QgZBgLvFAaXEJS8fuBO+YFXB3RaBaiIkshJVgmglgk17zA2qj8AYhG+8
         elNIoy4XIqDewLQ62Mkp3LfDugDm8/HP83dkmBDJlpUus9fp68NPpDqZ+K4k3Dv+Jbto
         7uAyZPNtvOHe5GlhMx7CMdPzz3u7pIWJ3Osg4XkPpM2CPYR/xci9tGHiqh/EtSd2LVGI
         50EQ==
X-Gm-Message-State: AOJu0YwuM/eBofZ/xgrR2vHBA64mHQk0oMQKJFOWin3yhxowXlhKfCnm
        36BQfG/Dpg74EOkLQdXiNNhsiREGflkVJOZvcXWHJg==
X-Google-Smtp-Source: AGHT+IG1QuRlqd5WUg5LSq9Sa+2WG3+pH9aEWm6KmPW4M8nLweQkVnYD51xD/qDJ9L+z4gIuMfCpNnkLCGu0v7Z3tZY=
X-Received: by 2002:a81:6f03:0:b0:59f:773a:b14c with SMTP id
 k3-20020a816f03000000b0059f773ab14cmr3251803ywc.37.1695849536678; Wed, 27 Sep
 2023 14:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <1695848028-18023-1-git-send-email-quic_khsieh@quicinc.com> <1695848028-18023-5-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1695848028-18023-5-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 28 Sep 2023 00:17:50 +0300
Message-ID: <CAA8EJpqwDOPD3dkWO1ap2pjMVnP1r2giUE0bAjTYzPBiz1aewA@mail.gmail.com>
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

Hit enter too soon. No submodules teardown, so NAK.

Also please propagate returned error codes instead of inventing
EPROBE_DEFER on your own.

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
