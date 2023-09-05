Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058AE79315C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbjIEVww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244840AbjIEVwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:52:47 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A96185
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:52:40 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5008faf4456so4791217e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 14:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693950758; x=1694555558; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=poTEsy/DpCYMp8kn/k9olR9s+199uTi+MS4Yqzd7g30=;
        b=mTG3wbw0xt62lb8mbperOYv7MrMCkgrpxjaxFS5noI/n+Das8PokU+Me5CwQOkowS8
         a7nBUrDhzOCAA6LNH529YZndbghBJx1s3++TQL9Evs4BRuB1CY7ja2ERv/o7SKOtXie+
         V3BYb+pQfwv2WgNd1fekvv8iEdNEySYeNMQr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693950758; x=1694555558;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=poTEsy/DpCYMp8kn/k9olR9s+199uTi+MS4Yqzd7g30=;
        b=fXsywFP3iGjjAup1+R8H8XZzd7srQ70Z5uW2v4uh6N2tohVpaI0a4/b/kia0wqibyj
         4P/5gz0cTYep6Ca4+9pBYttxXXzFR6osa4A7KGnxw9Nfb5q0EHHw9V+IIGaq1XXYHKBR
         t5eAextVtvqi5rXJlqbVKyyRvdzgrnjYZrB1K1e1cluV4hAJA6y8gIw3WldiEHS6QmS7
         osGhs93j9zpu35+Ixgkvl7yEliekakbINpv0A6MZnjIqFCU5GhL5OukyTtfCeYGYDEhn
         q9UPMcnloUaE4XQrJ7bA9HlBdCOy4Lkm6XfY+x3fvPZhhMis6jbKacAfVn82jx8wxkw4
         +lRQ==
X-Gm-Message-State: AOJu0YwmiUOPjIb+euXwG+83cSYGbFbJGvZ9E8dXHNJXnHE9Sr9jozc7
        5KFXL0y0TObQrWdzftS8CIG3sW74kz5E0z4NdcMzyA==
X-Google-Smtp-Source: AGHT+IE3JWihciGf0rRrSsH9PjyDJ4bYAVgfmGDiVcDY3TEzyqBgkL1t/dLNdH5Gs/1zTaB+TQSko2czegvMLQZy5cI=
X-Received: by 2002:a19:671a:0:b0:4fe:1681:9378 with SMTP id
 b26-20020a19671a000000b004fe16819378mr706226lfc.66.1693950758130; Tue, 05 Sep
 2023 14:52:38 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Sep 2023 16:52:37 -0500
MIME-Version: 1.0
In-Reply-To: <726d4be5-d207-4176-bc0d-43492eb2c4e5@linaro.org>
References: <20230829184735.2841739-1-swboyd@chromium.org> <20230829184735.2841739-8-swboyd@chromium.org>
 <726d4be5-d207-4176-bc0d-43492eb2c4e5@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 5 Sep 2023 16:52:37 -0500
Message-ID: <CAE-0n50Ka++WMKey_Nqm1drkQZLj6gnPSf=P2NX9=diQ_qCgtg@mail.gmail.com>
Subject: Re: [PATCH 7/7] drm/msm/dp: Remove dp_display_is_ds_bridge()
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Baryshkov (2023-09-03 15:40:49)
> On 29/08/2023 21:47, Stephen Boyd wrote:
> > This function is simply drm_dp_is_branch() so use that instead of
> > open-coding it.
> >
> > Cc: Vinod Polimera <quic_vpolimer@quicinc.com>
> > Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >   drivers/gpu/drm/msm/dp/dp_display.c | 9 +--------
> >   1 file changed, 1 insertion(+), 8 deletions(-)
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Thanks.

>
> >
> > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > index 76f13954015b..96bbf6fec2f1 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > @@ -341,19 +341,12 @@ static const struct component_ops dp_display_comp_ops = {
> >       .unbind = dp_display_unbind,
> >   };
> >
> > -static bool dp_display_is_ds_bridge(struct dp_panel *panel)
> > -{
> > -     return (panel->dpcd[DP_DOWNSTREAMPORT_PRESENT] &
> > -             DP_DWN_STRM_PORT_PRESENT);
> > -}
> > -
> >   static bool dp_display_is_sink_count_zero(struct dp_display_private *dp)
>
> Nit: you might as well inline this function

Ok. I'll send a followup to this series with a patch for that. I found
that with an Apple dongle it always prints out a message to the kernel
log when I have HDMI disconnected that there isn't a sink connected,
which is annoying.

So at least two more patches are incoming.
