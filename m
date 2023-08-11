Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2327477890D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjHKIgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjHKIgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:36:49 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C486130C0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:36:48 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-583b3aa4f41so18822017b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691743008; x=1692347808;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7RiLDVzYfGeq/75nyVMCH9Ez1G1IWtk1jFuILLki9h4=;
        b=s9umU4UDjsz9zz7+kZXT8kRxjdfXSfhncTHhwGN6CIw8099q+qBHWeZE0nKnuhIN3p
         3GT+SvePUoUzRc84ZD9O3yLvVTZI1ONEaaujIQwpju9x7hJBFuMFc4BaO/2GK4G4o8MQ
         ylVK0GDbdg5ND0zjw4e6yxU+V1mZAv4ayVvehZPyflqkjBusPpzLkAsUQ4Ln64Pjuwxb
         NdC/A7wRlJFdjkQsazjbZV8YXqYtaus2gkxiaLSrc+otTyAoSlxSypgMJ/yIY5tXq/nB
         xaAy8Fm4TOmUS7iFxvTvqs4YrZ3T3VuU5FXPRde7ZJz/OCs3zMPXnLygsnCQs7FylG+B
         KWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691743008; x=1692347808;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7RiLDVzYfGeq/75nyVMCH9Ez1G1IWtk1jFuILLki9h4=;
        b=QH+zS7KyGriHqBXhXmq5UF5OGlW8Uhui+qyM+DOQG4BT69FqlAD6i4z3EcLgkEGgxw
         vMUSzXdUtnpfj6QVSi8rgFEh8FtV+6b66NNG3fCXgGQUxp67piY4UJaOth59dgYKsYjI
         5ro9gP03TYhggAV5pWY1/dftYgZCsiCdj41fJ4X0jh6eDftjhbwsVUWsUIRzTwCxr0G3
         T1sNRFdBE5EEmzAiXh1YLcMhqm74Gn+VVJOwf+MUG3mtGcOXopm2z62Xx3WqAbp7HNxz
         64IJ4qiQRU1UENCVVcfEywFIU5NSBWMQ9J56mKTYjGu9FpFNfnBoC6AC0SrIqny+pu44
         F7pQ==
X-Gm-Message-State: AOJu0YxzqrWRSqHr2VF4rWAtVPVayjrVUaoOaawSlr+dkMSB84NlfDYZ
        RHQ8m8+Nkui/BMjl62ebrVcjZwhMbiEQsoyl4kvwHg==
X-Google-Smtp-Source: AGHT+IHjPrn41TM+VD7foXzUhoO6Hm7Zhr6d52b3zQ7MweHxSV1adAo5kdJGyasrHxXgEgFI/ETVXe8jrmKhCKMrDsM=
X-Received: by 2002:a0d:eb83:0:b0:586:a00f:717d with SMTP id
 u125-20020a0deb83000000b00586a00f717dmr1102637ywe.6.1691743007992; Fri, 11
 Aug 2023 01:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230808202319.191434-1-limings@nvidia.com> <16047c7a-5bd1-868c-e6eb-e5f415e77fdd@intel.com>
 <CAPDyKFp28mmbRAGf14u8KTO3v7H=SFAYbwcz7xeb1m4tD_G2vQ@mail.gmail.com>
 <a2f6cd0e-8429-3468-9dcf-a5022717e2ae@intel.com> <CAPDyKFqTWMghEAsBdLUF+K4QNEWBozNi3_a7w0+KuuO3x+wkTQ@mail.gmail.com>
 <e561174e-a5cf-9503-f47a-d6c3fc7a1719@intel.com>
In-Reply-To: <e561174e-a5cf-9503-f47a-d6c3fc7a1719@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 11 Aug 2023 10:36:12 +0200
Message-ID: <CAPDyKFrZawSORUG6wAJoCGFJABXvadivarNJ7_3V-ajeULLitw@mail.gmail.com>
Subject: Re: [PATCH v7] mmc: sdhci-of-dwcmshc: Add runtime PM operations
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Liming Sun <limings@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 at 07:57, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 10/08/23 19:34, Ulf Hansson wrote:
> > On Thu, 10 Aug 2023 at 14:44, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 10/08/23 13:21, Ulf Hansson wrote:
> >>> On Thu, 10 Aug 2023 at 10:13, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>>
> >>>> On 8/08/23 23:23, Liming Sun wrote:
> >>>>> This commit implements the runtime PM operations to disable eMMC
> >>>>> card clock when idle.
> >>>>>
> >>>>> Reviewed-by: David Thompson <davthompson@nvidia.com>
> >>>>> Signed-off-by: Liming Sun <limings@nvidia.com>
> >>>>> ---
> >>>>> v6->v7:
> >>>>>     - Address Ulf's comment;
> >>>>> v5->v6:
> >>>>>     - Address Adrian's more comments and add coordination between
> >>>>>       runtime PM and system PM;
> >>>>> v4->v5:
> >>>>>     - Address Adrian's comment to move the pm_enable to the end to
> >>>>>       avoid race;
> >>>>> v3->v4:
> >>>>>     - Fix compiling reported by 'kernel test robot';
> >>>>> v2->v3:
> >>>>>     - Revise the commit message;
> >>>>> v1->v2:
> >>>>>     Updates for comments from Ulf:
> >>>>>     - Make the runtime PM logic generic for sdhci-of-dwcmshc;
> >>>>> v1: Initial version.
> >>>>> ---
> >>>>>  drivers/mmc/host/sdhci-of-dwcmshc.c | 72 ++++++++++++++++++++++++++++-
> >>>>>  1 file changed, 70 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> >>>>> index e68cd87998c8..c8e145031429 100644
> >>>>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> >>>>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> >>>>> @@ -15,6 +15,7 @@
> >>>>>  #include <linux/module.h>
> >>>>>  #include <linux/of.h>
> >>>>>  #include <linux/of_device.h>
> >>>>> +#include <linux/pm_runtime.h>
> >>>>>  #include <linux/reset.h>
> >>>>>  #include <linux/sizes.h>
> >>>>>
> >>>>> @@ -548,9 +549,13 @@ static int dwcmshc_probe(struct platform_device *pdev)
> >>>>>
> >>>>>       host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> >>>>>
> >>>>> +     pm_runtime_get_noresume(dev);
> >>>>> +     pm_runtime_set_active(dev);
> >>>>> +     pm_runtime_enable(dev);
> >>>>> +
> >>>>>       err = sdhci_setup_host(host);
> >>>>>       if (err)
> >>>>> -             goto err_clk;
> >>>>> +             goto err_rpm;
> >>>>>
> >>>>>       if (rk_priv)
> >>>>>               dwcmshc_rk35xx_postinit(host, priv);
> >>>>> @@ -559,10 +564,15 @@ static int dwcmshc_probe(struct platform_device *pdev)
> >>>>>       if (err)
> >>>>>               goto err_setup_host;
> >>>>>
> >>>>> +     pm_runtime_put(dev);
> >>>>> +
> >>>>>       return 0;
> >>>>>
> >>>>>  err_setup_host:
> >>>>>       sdhci_cleanup_host(host);
> >>>>> +err_rpm:
> >>>>> +     pm_runtime_disable(dev);
> >>>>> +     pm_runtime_put_noidle(dev);
> >>>>>  err_clk:
> >>>>>       clk_disable_unprepare(pltfm_host->clk);
> >>>>>       clk_disable_unprepare(priv->bus_clk);
> >>>>> @@ -606,6 +616,12 @@ static int dwcmshc_suspend(struct device *dev)
> >>>>>       if (ret)
> >>>>>               return ret;
> >>>>>
> >>>>> +     ret = pm_runtime_force_suspend(dev);
> >>>>> +     if (ret) {
> >>>>> +             sdhci_resume_host(host);
> >>>>> +             return ret;
> >>>>> +     }
> >>>>
> >>>> Since you are only using the runtime PM callbacks to turn off the card
> >>>> clock via SDHCI_CLOCK_CONTROL, pm_runtime_force_suspend() and
> >>>> pm_runtime_force_resume() are not needed at all.
> >>>
> >>> Right, it can be done without these too.
> >>>
> >>>>
> >>>> sdhci_suspend_host() does not care if SDHCI_CLOCK_CARD_EN is on or off.
> >>>> (And you are disabling pltfm_host->clk and priv->bus_clk, so presumably
> >>>> the result is no clock either way)
> >>>>
> >>>> sdhci_resume_host() does not restore state unless
> >>>> SDHCI_QUIRK2_HOST_OFF_CARD_ON is used, it just resets, so the internal clock
> >>>> SDHCI_CLOCK_INT_EN is off which is consistent with either runtime suspended
> >>>> or runtime resumed.
> >>>
> >>> Even if this may work, to me, it doesn't look like good practice for
> >>> how to use runtime PM in combination with system wide suspend/resume.
> >>>
> >>> The point is, sdhci_suspend|resume_host() may end up reading/writing
> >>> to sdhci registers - and we should *not* allow that (because it may
> >>> not always work), unless the sdhci controller has been runtime resumed
> >>> first, right?
> >>
> >> I am OK with drivers that just want to use runtime PM to turn off a
> >> functional clock.  sdhci-tegra.c is also doing that although using the
> >> clock framework.
> >
> > Yes, I agree. At least this works for SoC specific drivers.
> >
> >>
> >> Certainly that approach assumes that the host controller's power state
> >> is not changed due to runtime PM.
> >>
> >> To ensure that the host controller is runtime resumed before calling
> >> sdhci_suspend_host(), we can just call pm_runtime_resume() I think.
> >
> > Yes, that was kind of what I proposed in the other thread as option 1)
> > (except for the replacement of pm_runtime_force_suspend|resume).
> >
> > Although, to be clear I would probably use pm_runtime_get_sync()
> > instead, to make sure the usage count is incremented too.
>
> In that case, a matching pm_runtime_put() is needed also at the
> end of the resume callback.

Yes, of course. Or depending if we are using the force_suspend|resume
helper, a pm_runtime_put_noidle is sufficient after
pm_runtime_force_suspend() has been called.

[...]

Kind regards
Uffe
