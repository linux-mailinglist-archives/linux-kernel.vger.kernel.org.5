Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB7A7CFDB3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346243AbjJSPUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235435AbjJSPUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:20:32 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCB212A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:20:30 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9a6399cf78so824033276.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697728829; x=1698333629; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UzuYGgMfB2IgWrd3JwAlKJRMS7S7gxXt4VNaKRPI+4c=;
        b=Xo2wMcj8QD+bl4VrwjB91/Y2C0ZxMO3I8l4MCmCc0ZErUV7GovJg/LcsghTu56ZlDW
         hU5OkzcYNXgXmu3HSyLp7hUrkEf9fPpEC5EP0n+k0/W9z77xSMLgMbPZV2xjOM1b3v95
         qhA4xXntYA3wdrl57jkNo3i+rOEuHSqzBp6wj2TecnDLampUM9+ZwUXtCSj/M/xCUfzU
         IoFfYH+4E9sbizTjT6y7OJmzbGWKYbiAKmaA+jg5QYvp+/cZgdttfitbyuNr3JztiSA+
         yh80o4ZjsiBF5clgX+BbOo9HRmvPSKKapxInUjlnGPJxyZ/wdWA2chJTrcgPtLUthhGE
         CWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697728829; x=1698333629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UzuYGgMfB2IgWrd3JwAlKJRMS7S7gxXt4VNaKRPI+4c=;
        b=DalopOdjW/fzM6ufMCh5ADau1gt8KX1PJCf+dgoQmPb/I6ugjJheUH9JBFQSAtL5sX
         DiGAPyBchnMpE1m+8y+Rrb94fkwj7R/bIScqv6yUY3aiqn4K6L1jewElapyzcZrx4uet
         tTFXEpIxZVWOcbi5WkD03Vxr9QaOry3hSLX0R6Sogzz7/8cJ8MYij4bAgp/ahC/8mXgs
         ObqvUY1hWncdRzcsMzHO4ZsLO8IcvLnmsCxN5wJIfMbkjHEQ6lQ6eMKohU9Pq1zfutjM
         5IuqIYN2fdzVje4P25uFadmdvMQicV1MSVUZHem5oqwmX0THNeVJlSURpP0b3XYI4vHQ
         FPUw==
X-Gm-Message-State: AOJu0YzKDfqzvT3nMR62KoIcaU7JGPHM8CWtR+YZdbI8/FJPOW/SozbV
        7DCFQs2FAqy5V7dE1DQYHr5MUqAxXRGhOTkbTmW1tw==
X-Google-Smtp-Source: AGHT+IGKbBoO/lWa/SG+c0KZzQWamY/96muNTJtMojdvtqQZPMShMcdRxDx8yzNIvpa501Ncxd01tIwIdamKiVS0ogc=
X-Received: by 2002:a25:8e08:0:b0:d81:91b2:62ea with SMTP id
 p8-20020a258e08000000b00d8191b262eamr1909318ybl.1.1697728829022; Thu, 19 Oct
 2023 08:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
 <20231018-msm8909-cpufreq-v2-2-0962df95f654@kernkonzept.com>
 <CAPDyKFot9=M1ooP_Q1AOgG5o_4DTQ2qsyai1ZdXAzBwf89W4uA@mail.gmail.com>
 <CAPDyKFr5A-P=UhWs4rUMBWup3pH75WAhcZ56Y2_Sfk3=WfxRCQ@mail.gmail.com>
 <ZTEph19CAvbgbN_E@gerhold.net> <CAPDyKFo1PVZYsdW_=92EtMmTT9hmkm-mBR69N_WvPh4f-Hw=NA@mail.gmail.com>
 <ZTFBzjLAaaUHux4O@gerhold.net>
In-Reply-To: <ZTFBzjLAaaUHux4O@gerhold.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Oct 2023 17:19:53 +0200
Message-ID: <CAPDyKFruYqngQoW21Ra+hm4ybjS7LoD4casYbo8bP4J+hLUnaA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 at 16:49, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Thu, Oct 19, 2023 at 04:12:56PM +0200, Ulf Hansson wrote:
> > On Thu, 19 Oct 2023 at 15:05, Stephan Gerhold <stephan@gerhold.net> wrote:
> > > On Thu, Oct 19, 2023 at 01:26:19PM +0200, Ulf Hansson wrote:
> > > > On Thu, 19 Oct 2023 at 12:24, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > On Wed, 18 Oct 2023 at 10:06, Stephan Gerhold
> > > > > <stephan.gerhold@kernkonzept.com> wrote:
> > > > > >
> > > > > > The genpd core caches performance state votes from devices that are
> > > > > > runtime suspended as of commit 3c5a272202c2 ("PM: domains: Improve
> > > > > > runtime PM performance state handling"). They get applied once the
> > > > > > device becomes active again.
> > > > > >
> > > > > > To attach the power domains needed by qcom-cpufreq-nvmem the OPP core
> > > > > > calls genpd_dev_pm_attach_by_id(). This results in "virtual" dummy
> > > > > > devices that use runtime PM only to control the enable and performance
> > > > > > state for the attached power domain.
> > > > > >
> > > > > > However, at the moment nothing ever resumes the virtual devices created
> > > > > > for qcom-cpufreq-nvmem. They remain permanently runtime suspended. This
> > > > > > means that performance state votes made during cpufreq scaling get
> > > > > > always cached and never applied to the hardware.
> > > > > >
> > > > > > Fix this by enabling the devices after attaching them and use
> > > > > > dev_pm_syscore_device() to ensure the power domains also stay on when
> > > > > > going to suspend. Since it supplies the CPU we can never turn it off
> > > > > > from Linux. There are other mechanisms to turn it off when needed,
> > > > > > usually in the RPM firmware (RPMPD) or the cpuidle path (CPR genpd).
> > > > >
> > > > > I believe we discussed using dev_pm_syscore_device() for the previous
> > > > > version. It's not intended to be used for things like the above.
> > > > >
> > >
> > > Sorry, looks like we still had a misunderstanding in the conclusion of
> > > the previous discussion. :')
> > >
> > > > > Moreover, I was under the impression that it wasn't really needed. In
> > > > > fact, I would think that this actually breaks things for system
> > > > > suspend/resume, as in this case the cpr driver's genpd
> > > > > ->power_on|off() callbacks are no longer getting called due this,
> > > > > which means that the cpr state machine isn't going to be restored
> > > > > properly. Or did I get this wrong?
> > > >
> > >
> > > We strictly need the RPMPDs to be always-on, also across system suspend
> > > [1]. The RPM firmware will drop the votes internally as soon as the
> > > CPU(s) have entered deep cpuidle. We can't do this from Linux, because
> > > we need the CPU to continue running until it was shut down cleanly.
> > >
> > > For CPR, we strictly need the backing regulator to be always-on, also
> > > across system suspend. Typically the hardware will turn off the
> > > regulator as soon as the CPU(s) enter deep cpuidle. Similarly, we can't
> > > do this from Linux, because we need the CPU to continue running until it
> > > was shut down cleanly.
> > >
> > > My understanding was that we're going to pause the CPR state machine
> > > using the system suspend/resume callbacks on the driver, instead of
> > > using the genpd->power_on|off() callbacks [2]. I can submit a separate
> > > patch for this.
> >
> > If we are going to do 1) as described below, this looks to me that
> > it's going to be needed.
> >
>
> Yep.
>
> > How will otherwise the cpr state machine be saved/restored during
> > system suspend/resume? Note that, beyond 1), the genpd's
> > ->power_on|off() callbacks are no longer going to be called during
> > system suspend/resume.
> >
>
> (Side note: I think "save/restore" might be the wrong words for
>  suspend/resume of CPR. Looking at the code most of the configuration
>  appears to be preserved across suspend/resume. Nothing is saved, it
>  literally just disables the state machine during suspend and re-enables
>  it during resume.
>
>  I'm not entirely sure what's the reason for doing this. Perhaps the
>  main goal is just to prevent the CPR state machine from getting stuck
>  or sending pointless IRQs that won't be handled while Linux is
>  suspended.)

If only the latter, that is a very good reason too. Drivers should
take care of their devices to make sure they are not triggering
spurious irqs during system suspend.

>
> > In a way this also means that the cpr genpd provider might as well
> > also have GENPD_FLAG_ALWAYS_ON set for it.
>
> Conceptually I would consider CPR to be a generic power domain provider
> that could supply any kind of device. I know at least of CPUs and GPUs.
> We need "always-on" only for the CPU, but not necessarily for other
> devices.
>
> For a GPU, the Linux driver (running on the CPU) can stop the GPU, wait
> for completion and then invoke the ->power_off() callback of CPR. In
> that case it is also safe to disable the backing regulator from Linux.
> (I briefly mentioned this already in the previous discussion I think.)
>
> We could set GENPD_FLAG_ALWAYS_ON for the CPR compatibles where we know
> that they are only used to supply CPUs, but if we're going to do (1)
> anyway there might not be much of an advantage for the extra complexity.

Okay, fair enough. Let's just stick with 1) and skip using
GENPD_FLAG_ALWAYS_ON bit for the cpr genpd provider.

>
> >
> > >
> > > I didn't prioritize this because QCS404 (as the only current user of
> > > CPR) doesn't have proper deep cpuidle/power management set up yet. It's
> > > not entirely clear to me if there is any advantage (or perhaps even
> > > disadvantage) if we pause the CPR state machine while the shared L2
> > > cache is still being actively powered by the CPR power rail during
> > > system suspend. I suspect this is a configuration that was never
> > > considered in the hardware design.
> >
> > I see.
> >
> > >
> > > Given the strict requirement for the RPMPDs, I only see two options:
> > >
> > >  1. Have an always-on consumer that prevents the power domains to be
> > >     powered off during system suspend. This is what this patch tries to
> > >     achieve.
> > >
> > > Or:
> > >
> > >  2. Come up with a way to register the RPMPDs used by the CPU with
> > >     GENPD_FLAG_ALWAYS_ON. This would also be doable, but isn't as
> > >     straightfoward as "regulator-always-on" in the DT because the rpmpd
> > >     DT node represents multiple genpds in a single DT node [3].
> >
> > Yes, it sounds like it may be easier to do 1).
> >
> > >
> > > What do you think? Do you see some other solution perhaps? I hope we can
> > > clear up the misunderstanding. :-)
> >
> > Yes, thanks!
> >
> > >
> > > [1]: https://lore.kernel.org/linux-arm-msm/ZQGqfMigCFZP_HLA@gerhold.net/
> > > [2]: https://lore.kernel.org/linux-arm-msm/CAPDyKFoiup8KNv=1LFGKDdDLA1pHsdJUgTTWMdgxnikEmReXzg@mail.gmail.com/
> > > [3]: https://lore.kernel.org/linux-arm-msm/ZSg-XtwMxg3_fWxc@gerhold.net/
> > >
> > > > BTW, if you really need something like the above, the proper way to do
> > > > it would instead be to call device_set_awake_path() for the device.
> > > >
> > > > This informs genpd that the device needs to stay powered-on during
> > > > system suspend (assuming that GENPD_FLAG_ACTIVE_WAKEUP has been set
> > > > for it), hence it will keep the corresponding PM domain powered-on
> > > > too.
> > > >
> > >
> > > Thanks, I can try if this works as alternative to the
> > > dev_pm_syscore_device()!
> >
> > Yes, please. We don't want to abuse the dev_pm_syscore_device() thingy.
> >
>
> Could you clarify the idea behind GENPD_FLAG_ACTIVE_WAKEUP? Would I set
> it conditionally for all RPMPDs or just the ones consumed by the CPU?
> How does the genpd *provider* know if one of its *consumer* devices
> needs to have its power domain kept on for wakeup?

We are thinking of the GENPD_FLAG_ACTIVE_WAKEUP as a platform
configuration type of flag for the genpd in question. The consumer
driver shouldn't need to know about the details of what is happening
on the PM domain level - only whether it needs its device to remain
powered-on during system suspend or not.

I suspect that the GENPD_FLAG_ACTIVE_WAKEUP is probably okay to set
for most genpds, but there may be some exceptions.

Kind regards
Uffe
