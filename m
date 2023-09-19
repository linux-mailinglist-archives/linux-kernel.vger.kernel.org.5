Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8DC7A5E67
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjISJob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjISJoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:44:30 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB274E8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:44:24 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59c07cf02ebso41729407b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695116664; x=1695721464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ysPzsxoFUrEsYdw65gOzDGE5dn8Oinp+8joKldVVKSw=;
        b=q6fFo60PabHPLZuA8h87idm3N0ItrtPB9b6z1MtlWDXOc0/ZH3ryyzl2BoAhgmTXpr
         qSHe5ZWIZ170ZWHRk2lw3wjpQr+Vx3iDAMEFP5vHqP7NleIpqMLtuzwALCq4454phPdr
         eGQoizFQV55FeRlagANENi6KE68OOziyG5G4JXbhmRwhb9HqQdQGlKxYMO9cTXxipYDB
         0ETP0i2SFGLqZMDmyzgAiIYjgrkx0A5O7rWTJzubYJF/hkQHv4OhpEGqbpA8ZqRKf0ks
         gfhVb7u6bYn6wxLBupIRX6kCU0RThfTOSnz+FCxJALD+JkKavMcOeAahJukztc15xatN
         ahQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695116664; x=1695721464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysPzsxoFUrEsYdw65gOzDGE5dn8Oinp+8joKldVVKSw=;
        b=dBDkvYT1gwnYCTWO9NlYli7PgEhGM59Naujqbbpiu2hc2ma/HXGUh0HDqUEJ1LFb0v
         PlB9I+AYckd68mhXRguDsUGL0KsZ2COQAY4zicq+nDJJ6E01/6xWyT/jFmIcbnIpl3/W
         Tv59aFy33ze15uMXeg0oJRNfDipQj06rXgHzSaYSpvpt0oKh2FTdE8XdtX8MGvnL4EkG
         zOSdypfqPZuJia19CgYz+MC0d0RwT7cR4AUlYOhH/oxyI9H95hmT8mF2SFS36Mbxq+aT
         oRZPq4KMz/e6EB87UNKPXURpzjbrfjv33wxi8GNwHMQta3WT2Yle0NtmH19Ych1l4NP6
         xADg==
X-Gm-Message-State: AOJu0YztZ0jWLdN8gZD5CLy4pFBTB0YvvnIGnkk8G208QB+7q1KKsK8q
        WkKG5JUiI6G90NYFskAwcTmtuOYiyPSIy8zrMDaIXA==
X-Google-Smtp-Source: AGHT+IFDoHCMQ5h63cC088FeLRoLD59RSptUQufYrG2ZNSumbv3kjymGxXEH332h+NW8JmWZ7HwRSrR2GmVTVtko5os=
X-Received: by 2002:a81:48cb:0:b0:58c:b5d2:bbd8 with SMTP id
 v194-20020a8148cb000000b0058cb5d2bbd8mr11777166ywa.28.1695116663916; Tue, 19
 Sep 2023 02:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <1694813901-26952-1-git-send-email-quic_khsieh@quicinc.com>
 <1694813901-26952-2-git-send-email-quic_khsieh@quicinc.com>
 <CAA8EJprRFYMF-6yxcL75rftfii0kt7hmg_+TeOMJw+BRyDYdeg@mail.gmail.com> <4634ca79-e12b-0608-a123-6ed123f4a03c@quicinc.com>
In-Reply-To: <4634ca79-e12b-0608-a123-6ed123f4a03c@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 19 Sep 2023 12:44:12 +0300
Message-ID: <CAA8EJppuxn94o01Us-xdJAP4dVeH3Gp=bSrKrJPtJ4N=72G2fA@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sept 2023 at 20:03, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
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
>
> Sorry, v2 is same as v3.
>
> I submitted v2 first but found i forget to add change logs from review
> comments of v1.
>
> Therefore i submit v3 to add changes logs which missing at v2.

This doesn't consist of a change. It should have been a RESEND or just
responding with the changelog. V3 means new revision.

>
>
>
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
> >
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
