Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7557CC211
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbjJQLyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjJQLyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:54:00 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34855B0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 04:53:59 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d84c24a810dso6527157276.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 04:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697543638; x=1698148438; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gRHWuH+/WXKEnLl3V7UXIEiqd4FVRVva5dZnGflFJOs=;
        b=WibYCdr1ui+CxY3WgYue3+unNQVW53YdTjd9COHWwcNZ/Qjio7+VKh09mS6VzbeH+N
         FFvZTst352gdaf8JxT0jdTz2zmw9VcH8KuYqGNXuCpqAIGqNi/Jh/8US+oCoYNeLnl2t
         HSi2HfSE/L/8R5IcpuzmMMXFtdM0nZ6kzctmeeuQRwsCHWtLvwosAT5ot8sPyfQU4zKx
         azKTrqD3CWN/OaTwpErq3VAjiqcw6DC81RUj0YvVZbQ3ABwliV8F6/Cu0zo+Eo4W0cfw
         2IGIYmOlIHJLP7aZP3CrYW/WGcZkOz8BMKyhtP1HSnzLSapUTmzsINczwiZBBfdOfiaF
         r/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697543638; x=1698148438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRHWuH+/WXKEnLl3V7UXIEiqd4FVRVva5dZnGflFJOs=;
        b=CevPp0aZajrOQnY/ESWUmTzS2W1Qk0uDJEfibKhTQd93sg5uDQR3ATTaAV2dt13bj6
         N/IIowHYhqQPhDvJ2dLCDv63ce0SA9CzrYHrIMCxISI1Uf534HTcQHMTbjp5glde15FA
         bAuwA95InTWw/44rSCG5l0BCOfenkidJXG8vWSuUk36GXigd4AwrKjLG58HaL32cyByo
         NIV6TOj4mHOmRtuPgU6QZjL3YWdnj2gDsSuSCLxnoLyukR7UIM2nq94M7/Ij0VMdCXZ5
         sncL4KUb+mT+TwOkJz0h9Pc/Dc2nwrhJRGf87xf8N88XutSKz2vZSSQF18CQP0wDvIzp
         +FEQ==
X-Gm-Message-State: AOJu0Ywx/gMeEVkmEP9Yv7NFBVMXhPbWEgYFz6zRn+tDTBogKBi17nHG
        IWKq39YTyOpRxWVsUH1vSLl8/HnKFfEOwvrsU9YePQ==
X-Google-Smtp-Source: AGHT+IG7VrpcqV+J9Ymhq3tlhL4g+lB/bRUE2i5WhXSa6m1eZvyClYY2A0YNsGRnbwg99Yrin/GImtpCg62fHwpZZmk=
X-Received: by 2002:a25:cf10:0:b0:d9c:2953:bde1 with SMTP id
 f16-20020a25cf10000000b00d9c2953bde1mr1960729ybg.38.1697543638329; Tue, 17
 Oct 2023 04:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231012152108.101270-1-ulf.hansson@linaro.org>
 <169719833142.3828427.5236534342833939623.b4-ty@nvidia.com> <CAPDyKFpa4Wb2fXRS52cYa4=hs-K63y_Re52tS2VJsO9A31eZeA@mail.gmail.com>
In-Reply-To: <CAPDyKFpa4Wb2fXRS52cYa4=hs-K63y_Re52tS2VJsO9A31eZeA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Oct 2023 13:53:22 +0200
Message-ID: <CAPDyKFo6+QEA_C5HHs7pckqx=MRTKxmUWh+Pfar0E2Ve+1BWsw@mail.gmail.com>
Subject: Re: (subset) [PATCH 0/5] PM: domains: Drop pm_genpd_opp_to_performance_state()
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 at 11:57, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 13 Oct 2023 at 13:59, Thierry Reding <thierry.reding@gmail.com> wrote:
> >
> > From: Thierry Reding <treding@nvidia.com>
> >
> >
> > On Thu, 12 Oct 2023 17:21:08 +0200, Ulf Hansson wrote:
> > > Since commit 7c41cdcd3bbe ("OPP: Simplify the over-designed pstate <-> level
> > > dance"), there is no longer any users of the
> > > pm_genpd_opp_to_performance_state() API, while a few genpd providers are still
> > > assigning the redundant ->opp_to_performance_state() callback.
> > >
> > > Let's clean this up so we can drop pm_genpd_opp_to_performance_state() and the
> > > callback too.
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/5] soc/tegra: pmc: Drop the ->opp_to_performance_state() callback
> >       commit: cda263907a6f88c75fb97cf7adecffaafb6237ec
>
> Thierry, I was planning to queue up the complete series through my
> pmdomain tree, my apologies if that wasn't clear. I want to get rid of
> the actual genpd API and the genpd callback altogether (patch5).
>
> Would it be possible for you to drop the above patch from your tree
> and provide an ack instead?

I just noticed that the above went has also been pulled into the soc
tree from your pull-request. So nevermind, I can do the final cleanup
later on.

Kind regards
Uffe
