Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D577A5E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjISJqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjISJqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:46:13 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFB2F1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:46:07 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-59bfb0825efso47994917b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695116766; x=1695721566; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5QwnMEr9g+UV2zSClp4LdEyAkoPr5XRWwAzh3mE4dxo=;
        b=mBvslSxQphJKG9udkoY1d+G6n/bMqlZjYqXJvpx03D6+YEqRJGGWO2CbkQABTlLpCc
         cg7e/7DMALHfA/zI5/L98My1CmB4ORJOxkx73FoKKYeIxPDbd2YYF2P0w3+Zq10+trIn
         CbRSRKh1H+g1xeZwQCkiGTfnCY3kF/Qs6BIXsEA8azCu+hhDYicozQrOXHS/38yBB7VC
         Pw7fm8IUILwV2w0kAMIcqpG1asegS1vl2Vj+8yn/Tv5P+WpQHUiHl2UUPbz/JT2kDw0A
         UhSPRcvdHjqVRzY7lYi1qivplECh9BiRxZrAglsrQ9zuKvvbWGvSBIXZIYKnIQZ4bgHK
         lrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695116766; x=1695721566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5QwnMEr9g+UV2zSClp4LdEyAkoPr5XRWwAzh3mE4dxo=;
        b=gKUoMzrUc8Or4M7B+rxWLom4c5qXA9fB4AG9LF8JRgAnwKyF44pYrHXNi9ZgtZ1SqV
         rdMQi+yS+97+/x3IeI3SnlcC9HUlUZf2ZqILuMxZGK2evlLCnnpv4AXie0qlrt+ncSvw
         TYREB9QdNcqA0xgQ9mEdepCfKQWrK3dJw4dhHxMSaY8PENWxksbtlcnaIXGKTpNaBsfL
         eJxJEzMJAcBENy6mJypskoM53rV00Rkp47Cj5HIf6AFWmH5uLdDLhBxZ5qj661gnupwe
         kot6ci9iEsZ2P9roPn6qitMCojnrD61mKMRvpfk5bpxnkUpNfPVAB+LhZGjjEDXl1W1M
         3UWA==
X-Gm-Message-State: AOJu0Yw/V5kh2emzc9zes7FwokdvPmoDOeA9Xv6MlP0x6mX5EqDBWLGU
        deyWTY6i6lk/l/zdHmCwsmGw0pFtjbPtgeaHV2fVqg==
X-Google-Smtp-Source: AGHT+IEPLhKcEQ8VnPqTGkwZWPQeCGEa8pbJIGsJUn9x4bl87n6z2UlZ8WodvmGmXYRjZe6EBVmQQgOm6zqwAoRaqB8=
X-Received: by 2002:a81:a208:0:b0:583:d722:9ae9 with SMTP id
 w8-20020a81a208000000b00583d7229ae9mr12169719ywg.41.1695116766554; Tue, 19
 Sep 2023 02:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <1694813901-26952-1-git-send-email-quic_khsieh@quicinc.com>
 <1694813901-26952-4-git-send-email-quic_khsieh@quicinc.com>
 <CAA8EJprG8HuhDHV9k5_4+vkejnYmwmg61isZXT7EsBCbGP0pJA@mail.gmail.com> <f855b3db-2754-5f66-9fc2-061a517814ef@quicinc.com>
In-Reply-To: <f855b3db-2754-5f66-9fc2-061a517814ef@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 19 Sep 2023 12:45:55 +0300
Message-ID: <CAA8EJpof+dp_d_5-oADuA7RNU7ut=TKLY5Fw12EjxaSa2S+=rg@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] drm/msm/dp: use drm_bridge_hpd_notify() to report
 HPD status changes
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

On Mon, 18 Sept 2023 at 23:16, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
>
> On 9/15/2023 5:41 PM, Dmitry Baryshkov wrote:
> > On Sat, 16 Sept 2023 at 00:38, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
> >> Currently DP driver use drm_helper_hpd_irq_event(), bypassing drm bridge
> >> framework, to report HPD status changes to user space frame work.
> >> Replace it with drm_bridge_hpd_notify() since DP driver is part of drm
> >> bridge.
> >>
> >> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> > Also see the comment below.
> >
> >> ---
> >>   drivers/gpu/drm/msm/dp/dp_display.c | 20 ++------------------
> >>   1 file changed, 2 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> >> index 18d16c7..59f9d85 100644
> >> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> >> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> >> @@ -356,26 +356,10 @@ static bool dp_display_is_sink_count_zero(struct dp_display_private *dp)
> >>                  (dp->link->sink_count == 0);
> >>   }
> >>
> >> -static void dp_display_send_hpd_event(struct msm_dp *dp_display)
> >> -{
> >> -       struct dp_display_private *dp;
> >> -       struct drm_connector *connector;
> >> -
> >> -       dp = container_of(dp_display, struct dp_display_private, dp_display);
> >> -
> >> -       connector = dp->dp_display.connector;
> >> -       drm_helper_hpd_irq_event(connector->dev);
> >> -}
> >> -
> >>   static int dp_display_send_hpd_notification(struct dp_display_private *dp,
> >>                                              bool hpd)
> >>   {
> >> -       if ((hpd && dp->dp_display.link_ready) ||
> >> -                       (!hpd && !dp->dp_display.link_ready)) {
> >> -               drm_dbg_dp(dp->drm_dev, "HPD already %s\n",
> >> -                               (hpd ? "on" : "off"));
> >> -               return 0;
> >> -       }
> >> +       struct drm_bridge *bridge = dp->dp_display.bridge;
> >>
> >>          /* reset video pattern flag on disconnect */
> >>          if (!hpd)
> > Note, this part (resetting the video_test and setting of is_connected)
> > should be moved to the dp_bridge_hpd_notify() too. Please ignore this
> > comment if this is handled later in the series.
>
> I think keep them here is better since eDP does not populate hpd_enable,
> hpd_disable and hpd_notify at edp_bridge_ops at drm_bridge_attach().
>
> Keep them here will work for both eDP and DP.

Having them here doesn't work for DP-with-external-bridges, which will
not use dp_display_send_hpd_notification.

>
>
> >
> >
> >> @@ -385,7 +369,7 @@ static int dp_display_send_hpd_notification(struct dp_display_private *dp,
> >>
> >>          drm_dbg_dp(dp->drm_dev, "type=%d hpd=%d\n",
> >>                          dp->dp_display.connector_type, hpd);
> >> -       dp_display_send_hpd_event(&dp->dp_display);
> >> +       drm_bridge_hpd_notify(bridge, dp->dp_display.link_ready);
> >>
> >>          return 0;
> >>   }
> >> --
> >> 2.7.4
> >>
> >



-- 
With best wishes
Dmitry
