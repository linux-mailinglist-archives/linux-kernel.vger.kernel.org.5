Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2027D0D02
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376720AbjJTKUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376596AbjJTKUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:20:51 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B460D53
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:20:48 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a8ee23f043so6790117b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697797247; x=1698402047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W79U9iklHwLSbhR/94JhGNefp7ntZs362QatUfI3IfI=;
        b=nfxlTP0z3z6L6PAXEscyKxYpQTRCM9o0adr1SrnQ9q7CTPZqHv+abj+1QI+m0iKr2+
         BBcWd5APgf9VIUg6OVry26MMWPBCNMIkeM3nzriOyFD6/q+KgwZohtWaGScP0H2GohMw
         eM3dEx+RI6vZdgKAuJXQqLppBga08jWW/11ebkjXAqF5MRBprg1hXmfMcPX2PC9LFN8c
         wideoaqq7CUToxKN310zNTGaXduLInkr2lJ9+W6obY+h/ynKuDoHRnLKLgwEoD85vP5b
         NBXLAhzvJnAkR/oQxFosT3LkLycnau5bKrBvF6CWmlKPfhygvnwPUAvv+rROVDedtnpf
         SebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697797247; x=1698402047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W79U9iklHwLSbhR/94JhGNefp7ntZs362QatUfI3IfI=;
        b=Rg+9AnzCDPxeIK4gyL0EETjF+eaY15Qn8RjaJ/TLYt4vsTs/1TsKDuozB/M2rYqCxH
         DEjzTQZkrr0/94pEYW3UJqcgIokYgQmSSZ/fxXNFY1u5+e7zpiJUSb4yoJCM+jDGthG4
         sC1krB4/r/BD1GuG3/x+32uVWsoevLx6DJm6faR5YJtXlkGjPGkSIvu5durA8CL1sAP0
         TF8rSu0SU3JRrNJabdqtpvjA71nJbMnZiUtKb2HYztqIZHPZhUq73uF8Lg9RZV0wx2pb
         e9vRzG0RDPo7ZHeL8lK93ueHUBxvDpGrVQY+w4NpucEUBtR6omMeY72g5H3IjfoUi9MN
         Zisg==
X-Gm-Message-State: AOJu0Yyr8FGdEnyUurKXh4bN04g7/nmmjh9nJx9H6RmxzJWJ0WU5wIDL
        Rq9wsQl38sSiv5xhbiDIJFoCkNm1Al+xpoH4W2YpVhV2M8GXJVGU4bQ=
X-Google-Smtp-Source: AGHT+IFppxZveglONFPIGli2rJYFfP862ng1fj8gvWuwqd6m5OzeXOk1StoswlMPW+jNGU8qSha8o4+c/CfPZy2DJjA=
X-Received: by 2002:a5b:f4c:0:b0:d9a:3bf1:35e9 with SMTP id
 y12-20020a5b0f4c000000b00d9a3bf135e9mr1288441ybr.3.1697797247740; Fri, 20 Oct
 2023 03:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
 <20231018-msm8909-cpufreq-v2-2-0962df95f654@kernkonzept.com>
 <CAPDyKFot9=M1ooP_Q1AOgG5o_4DTQ2qsyai1ZdXAzBwf89W4uA@mail.gmail.com>
 <CAPDyKFr5A-P=UhWs4rUMBWup3pH75WAhcZ56Y2_Sfk3=WfxRCQ@mail.gmail.com>
 <ZTEph19CAvbgbN_E@gerhold.net> <CAPDyKFo1PVZYsdW_=92EtMmTT9hmkm-mBR69N_WvPh4f-Hw=NA@mail.gmail.com>
 <ZTFBzjLAaaUHux4O@gerhold.net> <CAPDyKFruYqngQoW21Ra+hm4ybjS7LoD4casYbo8bP4J+hLUnaA@mail.gmail.com>
 <ZTFiXJ2XO4WQN_gu@gerhold.net>
In-Reply-To: <ZTFiXJ2XO4WQN_gu@gerhold.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 20 Oct 2023 12:20:11 +0200
Message-ID: <CAPDyKFoRhDnx7SOiT1czcyteMJ=2KMOwZvn7ynDJsYtePthnxA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] cpufreq: qcom-nvmem: Enable virtual power domain devices
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 at 19:08, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Thu, Oct 19, 2023 at 05:19:53PM +0200, Ulf Hansson wrote:
> > On Thu, 19 Oct 2023 at 16:49, Stephan Gerhold <stephan@gerhold.net> wrote:
> > > On Thu, Oct 19, 2023 at 04:12:56PM +0200, Ulf Hansson wrote:
> > > > On Thu, 19 Oct 2023 at 15:05, Stephan Gerhold <stephan@gerhold.net> wrote:
> > > > > On Thu, Oct 19, 2023 at 01:26:19PM +0200, Ulf Hansson wrote:
> > > > > > BTW, if you really need something like the above, the proper way to do
> > > > > > it would instead be to call device_set_awake_path() for the device.
> > > > > >
> > > > > > This informs genpd that the device needs to stay powered-on during
> > > > > > system suspend (assuming that GENPD_FLAG_ACTIVE_WAKEUP has been set
> > > > > > for it), hence it will keep the corresponding PM domain powered-on
> > > > > > too.
> > > > >
> > > > > Thanks, I can try if this works as alternative to the
> > > > > dev_pm_syscore_device()!
> > > >
> > > > Yes, please. We don't want to abuse the dev_pm_syscore_device() thingy.
> > >
> > > Could you clarify the idea behind GENPD_FLAG_ACTIVE_WAKEUP? Would I set
> > > it conditionally for all RPMPDs or just the ones consumed by the CPU?
> > > How does the genpd *provider* know if one of its *consumer* devices
> > > needs to have its power domain kept on for wakeup?
> >
> > We are thinking of the GENPD_FLAG_ACTIVE_WAKEUP as a platform
> > configuration type of flag for the genpd in question. The consumer
> > driver shouldn't need to know about the details of what is happening
> > on the PM domain level - only whether it needs its device to remain
> > powered-on during system suspend or not.
> >
>
> Thanks! I will test if this works for RPMPD and post new versions of the
> patches. By coincidence I think this flag might actually be useful as
> temporary solution for CPR. If I:
>
>  1. Change $subject patch to use device_set_awake_path() instead, and
>  2. Set GENPD_FLAG_ACTIVE_WAKEUP for the RPMPD genpds, but
>  3. Do *not* set GENPD_FLAG_ACTIVE_WAKEUP for the CPR genpd.
>
> Then the genpd ->power_on|off() callbacks should still be called
> for CPR during system suspend, right? :D

Yes, correct, that should work fine!

>
> > I suspect that the GENPD_FLAG_ACTIVE_WAKEUP is probably okay to set
> > for most genpds, but there may be some exceptions.
> >
>
> Out of curiosity, do you have an example for such an exception where
> GENPD_FLAG_ACTIVE_WAKEUP shouldn't be set, aside from workarounds like
> I just described?
>
> As you said, the consumer device should just say that it wants to stay
> powered for wakeup during suspend. But if its power domains get powered
> off, I would expect that to break. How could a genpd driver still
> provide power without being powered on? Wouldn't that rather be a low
> performance state?

I think this boils down to how the power-rail that the genpd manages,
is handled by the platform during system suspend.

In principle there could be some other separate logic that helps a
FW/PMIC to understand whether it needs to keep the power-rail on or
not - no matter whether the genpd releases its vote for it during
system suspend.

This becomes mostly hypothetical, but clearly there are a lot of
genpd/platforms that don't use GENPD_FLAG_ACTIVE_WAKEUP too. If those
are just mistakes or just not needed, I don't actually know.

Kind regards
Uffe
