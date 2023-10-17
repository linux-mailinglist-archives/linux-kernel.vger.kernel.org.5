Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C9C7CCF87
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjJQVvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjJQVvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:51:02 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB4BFC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:50:58 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9ace5370a0so6101635276.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697579457; x=1698184257; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BfSq4fUe022kDtkFJa2azWpgcNmqdZxJ8fBh51QJEV8=;
        b=tUifuL9+/C4O6RqXx9beMS8lhbBgG42woTccPBBbhbPVUNIm8zDKUDe/JU42ywRYQH
         ALtxXdQjdzeMNzrWD0TbMDqBl83CSGjRy2yQzrBYyztrdkOh4zB2dwYsFuoStdIYevI6
         bpSQ4/NnbpitUQP6O4NVmq3dwIaRGdab6sWrrQ0nb3uhkQLEKITy4c+5gZ06pDICEHvN
         nJW9R2/7PRgNlIUUUf2yHSeTlVqKcYZZfU8GoYdXUENWiHZAz9kLf5CgW/1ji9P9GNQa
         BA5rVV9uyiw6flCSONyeuSiA3mF4Md2pb/j+FdWcOMZ2mWmi9i7/18NQdfMIVT4tdDpC
         /kPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697579457; x=1698184257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfSq4fUe022kDtkFJa2azWpgcNmqdZxJ8fBh51QJEV8=;
        b=DLK5GbFSJ+EGaZxfaGoxR/veQNOHQ5syIvt9oRiDYkJ+5RumKi0h5CW3MIMiVlpRIs
         Zr8OZ82tCzRqUQtkZ+yVsLglxxR00OfrygqaZBove70fDOjKPTwVmusu+R3x8iHqoCxZ
         wkfhCATHEYu1VRl54mZjfDb4ieR3EBrtMz6Adii6ZaX0sHC6rRxQYRiChkZfJSTWmDzi
         BADvKdWDbO/7wBfH48HjMxhNoU9VH3yE41DEmboM36m7/NdRV/UXvA2ha2GP7FdY21uO
         LqreaXyePUlUyuSjAqPQKMEgRfqHKk1zKJETaA0Bm2owvHbGxfj1gBoZwlXHl5cF1DP8
         yDGg==
X-Gm-Message-State: AOJu0Yz5s7eiiB0neY03M/AMmNShvoeZqUOvUjpa8EyxH4cp3xqpMSgX
        4B7UtWTT/7d6rDHS1tBPXrKiY3texccaabBX0HeuHtjYld+chK8ABeI=
X-Google-Smtp-Source: AGHT+IH4mYBk2x6zSCe/oj9jgMckIfEgIIlbaCnHdu+xq/07HUwai6hGnMdCcSxiF6naVzSWPbRy3VdGUHd2529Uuiw=
X-Received: by 2002:a25:254:0:b0:d9b:6264:b79e with SMTP id
 81-20020a250254000000b00d9b6264b79emr3129729ybc.53.1697579457419; Tue, 17 Oct
 2023 14:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230912-msm8909-cpufreq-v1-0-767ce66b544b@kernkonzept.com>
 <20230912-msm8909-cpufreq-v1-1-767ce66b544b@kernkonzept.com>
 <CAPDyKFq6U-MR4Bd+GmixYseRECDh142RhydtKbiPd3NHV2g6aw@mail.gmail.com>
 <ZQGqfMigCFZP_HLA@gerhold.net> <CAPDyKFppdXe1AZo1jm2Bc_ZR18hw5Bmh1x+2P7Obhb_rJ2gc4Q@mail.gmail.com>
 <ZRcC2IRRv6dtKY65@gerhold.net> <CAPDyKFoiup8KNv=1LFGKDdDLA1pHsdJUgTTWMdgxnikEmReXzg@mail.gmail.com>
 <ZSg-XtwMxg3_fWxc@gerhold.net> <CAPDyKFoH5EOvRRKy-Bgp_B9B3rf=PUKK5N45s5PNgfBi55PaOQ@mail.gmail.com>
 <ZS70aZbP33fkf9dP@gerhold.net>
In-Reply-To: <ZS70aZbP33fkf9dP@gerhold.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Oct 2023 23:50:21 +0200
Message-ID: <CAPDyKFpwZdx=vyuAZSv1WGYCyiohfnt87LM1jw=fhKsF5Ks1Yw@mail.gmail.com>
Subject: Re: [PATCH 1/4] cpufreq: qcom-nvmem: Enable virtual power domain devices
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> >
> > *) The pm_runtime_resume_and_get() works for QCS404 as a fix. It also
> > works fine when there is only one RPMPD that manages the performance
> > scaling.
> >
>
> Agreed.
>
> > **) In cases where we have multiple PM domains to scale performance
> > for, using pm_runtime_resume_and_get() would work fine too. Possibly
> > we want to use device_link_add() to set up suppliers, to avoid calling
> > pm_runtime_resume_and_get() for each and every device.
> >
>
> Hm. What would you use as "supplied" device? The CPU device I guess?

The consumer would be the device that is used to probe the cpureq
driver and the supplier(s) the virtual devices returned from genpd
when attaching.

>
> I'm looking again at my old patch from 2020 where I implemented this
> with device links in the OPP core. Seems like you suggested this back
> then too :)
>
>   https://lore.kernel.org/linux-pm/20200826093328.88268-1-stephan@gerhold.net/
>
> However, for the special case of the CPU I think we don't gain any code
> simplification from using device links. There will just be a single
> resume of each virtual genpd device, as well as one put during remove().
> Exactly the same applies when using device links, we need to set up the
> device links once for each virtual genpd device, and clean them up again
> during remove().
>
> Or can you think of another advantage of using device links?

No, not at this point.

So, in this particular case it may not matter that much. But when the
number of PM domains starts to vary between platforms it could be a
nice way to abstract some logic. I guess starting without using
device-links and seeing how it evolves could be a way forward too.

>
> > ***) Due to the above, we don't need a new mechanism to avoid
> > "caching" performance states for genpd. At least for the time being.
> >
>
> Right. Given *) and **) I'll prepare a v2 of $subject patch with the
> remove() cleanup fixed and an improved commit description.
>
> I'll wait for a bit in case you have more thoughts about the device
> links.

One more thing though that crossed my mind. In the rpmpd case, is
there anything we need to care about during system suspend/resume that
isn't already taken care of correctly?

Kind regards
Uffe
