Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7787B6FA5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjJCRYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240045AbjJCRYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:24:16 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67694AF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 10:24:12 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59f6492b415so463827b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 10:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696353851; x=1696958651; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=thG43+UboCLsh1Q91ZvIyopFQTEYZrf70FwL33ZjCMU=;
        b=QYzlmEwg1cl2xgv8eA4kBEEoF95sNcClBA9WQVh1mvCbedevX1/XPaBwDBerkXtGAZ
         TscQjxQfIGgqzTBK5yHj53AlDYCRN4irJk2ozNqmQKz+mSMHuGk/GMbInfOnRgpJaF1s
         oOerLJT5vtVrslncn+MYIqrVBnn6XqJaKv4noR1VpzB0PdH7Ufwa5Qnb1ItDY0JNMOCH
         tCBHvruYPzsyXXybJ+Qst9yctVPkjpDKMtJSUsbAPT5Onek7ix7qz6azmX6rEUiLLq6u
         QeCS5ZbFCaMtsBszGIwkgHwqjA98MqLxJFmTpneyWu5O7gR9a6nyaell54QqxA/Dcfft
         j6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696353851; x=1696958651;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thG43+UboCLsh1Q91ZvIyopFQTEYZrf70FwL33ZjCMU=;
        b=abosyUeXQVzbZYtkZByzhiBHb2tP7XA9SElgoEqfQ+a+Vi7EZmQzFj+6wH2TExU+O0
         /yBMuaLKU3RKWES3BSHjY8U/+sUHMyFne+Lu5ecpTpue6nG7OgWkPx1Ps139jM2lOxdX
         stpj1ZFLs7qTphdD8w7tiTNhFfNUV+JZn1GojFizy6UBtk1xO4jr3dxv9ieUpW1UvCri
         /YrzRyh83DgYfQC2kGR7SgSmXQNJDgk471XKTxMy1Z2cRnzdvXeGwK2Mn/J2DX+m1uK0
         FanMvrThV9AiRpskY1QOGeyn/T10MzxvrZZCLe0j/vva5aq+ts7Wo6Aq0amOT9TwMAd8
         WBmA==
X-Gm-Message-State: AOJu0YwQDb624SfSg4fUVlNDgREmwyJsdQJ8j3WPuMwCAehNoKoskXbY
        hYgxJOq4ehax5itlvKmebevCeF8QAJspIQ/pGYB+ng==
X-Google-Smtp-Source: AGHT+IH5j0fbG7NgjzWevuE/HObPmlPu9noPzeMJCjDPQNUhLIUyFJgh+GLeEaZJSWodaBgSINVEcmZWOm2carpu1Fs=
X-Received: by 2002:a81:a1d3:0:b0:59b:e743:630 with SMTP id
 y202-20020a81a1d3000000b0059be7430630mr2726908ywg.22.1696353851538; Tue, 03
 Oct 2023 10:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <1695848028-18023-1-git-send-email-quic_khsieh@quicinc.com>
 <1695848028-18023-9-git-send-email-quic_khsieh@quicinc.com>
 <CAA8EJprfjt7w+3YJAieBabuMso=-obRXss7-9Jrif23WmOJw5w@mail.gmail.com> <456136f5-1e4d-3866-603f-16f308f06028@quicinc.com>
In-Reply-To: <456136f5-1e4d-3866-603f-16f308f06028@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 3 Oct 2023 20:24:00 +0300
Message-ID: <CAA8EJprW72+oDL4vsQp9RKcAv9iAz2m0vfT1X3OLGxGNmJ=Y8Q@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] drm/msm/dp: move of_dp_aux_populate_bus() to eDP probe()
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

On Tue, 3 Oct 2023 at 20:16, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
>
> On 9/27/2023 2:57 PM, Dmitry Baryshkov wrote:
> > On Wed, 27 Sept 2023 at 23:54, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
> >> Currently eDP population is done at msm_dp_modeset_init() which happen
> >> at binding time. Move eDP population to be done at display probe time
> >> so that probe deferral cases can be handled effectively.
> >> wait_for_hpd_asserted callback is added during drm_dp_aux_init()
> >> to ensure eDP's HPD is up before proceeding eDP population.
> >>
> >> Changes in v4:
> >> -- delete duplicate initialize code to dp_aux before drm_dp_aux_register()
> >> -- delete of_get_child_by_name(dev->of_node, "aux-bus") and inline the function
> >> -- not initialize rc = 0
> >>
> >> Changes in v3:
> >> -- add done_probing callback into devm_of_dp_aux_populate_bus()
> >>
> >> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> >> ---
> >>   drivers/gpu/drm/msm/dp/dp_aux.c     | 34 ++++++++++++++----
> >>   drivers/gpu/drm/msm/dp/dp_display.c | 69 ++++++++++++++++++-------------------
> >>   2 files changed, 60 insertions(+), 43 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
> >> index 22eb774..425b5c5 100644
> >> --- a/drivers/gpu/drm/msm/dp/dp_aux.c
> >> +++ b/drivers/gpu/drm/msm/dp/dp_aux.c
> >> @@ -480,7 +480,6 @@ void dp_aux_deinit(struct drm_dp_aux *dp_aux)
> >>
> >>   int dp_aux_register(struct drm_dp_aux *dp_aux)
> >>   {
> >> -       struct dp_aux_private *aux;
> >>          int ret;
> >>
> >>          if (!dp_aux) {
> >> @@ -488,12 +487,7 @@ int dp_aux_register(struct drm_dp_aux *dp_aux)
> >>                  return -EINVAL;
> >>          }
> >>
> >> -       aux = container_of(dp_aux, struct dp_aux_private, dp_aux);
> >> -
> >> -       aux->dp_aux.name = "dpu_dp_aux";
> >> -       aux->dp_aux.dev = aux->dev;
> >> -       aux->dp_aux.transfer = dp_aux_transfer;
> >> -       ret = drm_dp_aux_register(&aux->dp_aux);
> >> +       ret = drm_dp_aux_register(dp_aux);
> >>          if (ret) {
> >>                  DRM_ERROR("%s: failed to register drm aux: %d\n", __func__,
> >>                                  ret);
> >> @@ -508,6 +502,21 @@ void dp_aux_unregister(struct drm_dp_aux *dp_aux)
> >>          drm_dp_aux_unregister(dp_aux);
> >>   }
> >>
> >> +static int dp_wait_hpd_asserted(struct drm_dp_aux *dp_aux,
> >> +                                unsigned long wait_us)
> >> +{
> >> +       int ret;
> >> +       struct dp_aux_private *aux;
> >> +
> >> +       aux = container_of(dp_aux, struct dp_aux_private, dp_aux);
> >> +
> >> +       pm_runtime_get_sync(aux->dev);
> >> +       ret = dp_catalog_aux_wait_for_hpd_connect_state(aux->catalog);
> >> +       pm_runtime_put_sync(aux->dev);
> > Ok, so here you have used put_sync instead of autosuspend. Can we have
> > some uniformity? (I'd prefer to see put_sync or just put everywhere)
> >
> >> +
> >> +       return ret;
> >> +}
> >> +
> >>   struct drm_dp_aux *dp_aux_get(struct device *dev, struct dp_catalog *catalog,
> >>                                bool is_edp)
> >>   {
> >> @@ -531,6 +540,17 @@ struct drm_dp_aux *dp_aux_get(struct device *dev, struct dp_catalog *catalog,
> >>          aux->catalog = catalog;
> >>          aux->retry_cnt = 0;
> >>
> >> +       /*
> >> +        * Use the drm_dp_aux_init() to use the aux adapter
> >> +        * before registering aux with the DRM device so that
> >> +        * msm edp panel can be detected by generic_dep_panel_probe().
> > eDP, AUX, generic_edp_panel_probe().
> >
> >> +        */
> >> +       aux->dp_aux.name = "dpu_dp_aux";
> >> +       aux->dp_aux.dev = dev;
> >> +       aux->dp_aux.transfer = dp_aux_transfer;
> >> +       aux->dp_aux.wait_hpd_asserted = dp_wait_hpd_asserted;
> >> +       drm_dp_aux_init(&aux->dp_aux);
> >> +
> >>          return &aux->dp_aux;
> >>   }
> >>
> >> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> >> index 711d262..9a2b403 100644
> >> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> >> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> >> @@ -1203,6 +1203,28 @@ static const struct msm_dp_desc *dp_display_get_desc(struct platform_device *pde
> >>          return NULL;
> >>   }
> >>
> >> +static int dp_auxbus_done_probe(struct drm_dp_aux *aux)
> >> +{
> >> +       int rc;
> >> +
> >> +       rc = component_add(aux->dev, &dp_display_comp_ops);
> >> +       if (rc)
> >> +               DRM_ERROR("eDP component add failed, rc=%d\n", rc);
> > drop.
> are you mean dropping this line?
> >> +
> >> +       return rc;
> >> +}
> >> +
> >> +static inline int dp_display_auxbus_population(struct dp_display_private *dp)
> > It's not `population`. It is just `populate`.
> >
> > Also please inline this function.
> Are you means moving this function to header file?

No. I mean inlining this function.

-- 
With best wishes
Dmitry
