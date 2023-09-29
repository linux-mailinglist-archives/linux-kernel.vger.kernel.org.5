Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18537B3330
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbjI2NOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbjI2NOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:14:47 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C511AA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 06:14:44 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d857c8a1d50so15858520276.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 06:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695993283; x=1696598083; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4yKiuvsvBXQ2k6MWMGjaOCkpUxNJ6ntJ4mxt0PicsU8=;
        b=peCPbDy1pK6ss4mLp+k4npKlBtgGpvrPDAF50GO7Wn8Ag9hfKG/NFqqlff039CnTWK
         fNG1/yUeR+3Yt7aJ2+H8OOuOyTITNDFH6njrJTi5oY/uCVQsMSo4BfXJ00K9ZqXYi99s
         zo+qdJHR+RFPtYVQSAX/mOJvzWOazXMdo0QyAIbdDDQ4ZDPJf+zzkHanDk8CqOP5/00e
         Z1GzMR89nUJj+Dwatw/nWeLD9cWVnU0HRF2E7Ai2vIamD4JqeitpsuocmvCkVXsdAk02
         nETyjSmhY67+LcfKnvPV7jx8pdUYrQvaCmScE88q48r8ley/ii6DySh3AJL32/E8PYju
         9jWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695993283; x=1696598083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4yKiuvsvBXQ2k6MWMGjaOCkpUxNJ6ntJ4mxt0PicsU8=;
        b=prsFD9FeNxPHhwXGPeAHY3bnE7um7SIl33ALH2orgwtW7aFJQJtwEL3HQAzk2dExCq
         es1lNdLgBKAalaeOFblDlSDsku2HswZHfLUn3OEcnUfVWnnbsZJ9FdX/mNicj2HNjCJZ
         DluPTB1NiPc25odCiypuZVeZtVW4lbGg8tgp0jK1WI1y3q6CKKJfRkyaHG/EwV/xtqxq
         YgO7/N2NFPn8LLop3dAi/PGoh0hNkeoaToBPzBvlBicDIwa1LshsbtBWXHk8Ix8z0OvN
         xQS/Q8C8Wm71Gz3gBif2CccqntpUkKSG3oq4UX1tJNKVSWdZHhagm1pbm6RE6wVR5iQt
         hcmQ==
X-Gm-Message-State: AOJu0YxAdSPtqp/+83Enp1Q0rhl9qGC4BTzEAse2lWAfX1PJH4Se75M8
        jUTJC6u4AwMAezHcziEfML6eP4Is/jN/QzhQkkiTHg==
X-Google-Smtp-Source: AGHT+IGkI0wYi0tK5BnEKfL29yL1UDl78zPwmCcvGx57ym6BKX5A0lSIf7zCcgsIbiFEqKGq5SpAkJfy3C12SBm/Rok=
X-Received: by 2002:a25:b290:0:b0:d81:2fd4:367e with SMTP id
 k16-20020a25b290000000b00d812fd4367emr3797524ybj.43.1695993283602; Fri, 29
 Sep 2023 06:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230912-msm8909-cpufreq-v1-0-767ce66b544b@kernkonzept.com>
 <20230912-msm8909-cpufreq-v1-1-767ce66b544b@kernkonzept.com>
 <CAPDyKFq6U-MR4Bd+GmixYseRECDh142RhydtKbiPd3NHV2g6aw@mail.gmail.com> <ZQGqfMigCFZP_HLA@gerhold.net>
In-Reply-To: <ZQGqfMigCFZP_HLA@gerhold.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 29 Sep 2023 15:14:07 +0200
Message-ID: <CAPDyKFppdXe1AZo1jm2Bc_ZR18hw5Bmh1x+2P7Obhb_rJ2gc4Q@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sept 2023 at 14:26, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Wed, Sep 13, 2023 at 12:56:16PM +0200, Ulf Hansson wrote:
> > On Tue, 12 Sept 2023 at 11:40, Stephan Gerhold
> > <stephan.gerhold@kernkonzept.com> wrote:
> > >
> > > The genpd core ignores performance state votes from devices that are
> > > runtime suspended as of commit 5937c3ce2122 ("PM: domains: Drop/restore
> > > performance state votes for devices at runtime PM").
> >
> > I think you are referring to the wrong commit above. Please have a
> > look at commit 3c5a272202c2 ("PM: domains: Improve runtime PM
> > performance state handling"), instead.
> >
> > I also suggest rephrasing the above into saying that the performance
> > state vote for a device is cached rather than carried out, if
> > pm_runtime_suspended() returns true for it.
> >
> > Another relevant information in the commit message would be to add
> > that during device-attach (genpd_dev_pm_attach_by_id()), calls
> > pm_runtime_enable() the device.
> >
>
> Thanks, I will try to clarify this a bit! I was actually looking at that
> commit originally but decided to reference the commit that "started the
> change", since the this commit is marked as fix of the one I referenced.
> But I think you're right, it would be more clear to reference "PM:
> domains: Improve runtime PM performance state handling" directly.
>
> > > However, at the
> > > moment nothing ever enables the virtual devices created in
> > > qcom-cpufreq-nvmem for the cpufreq power domain scaling, so they are
> > > permanently runtime-suspended.
> > >
> > > Fix this by enabling the devices after attaching them and use
> > > dev_pm_syscore_device() to ensure the power domain also stays on when
> > > going to suspend. Since it supplies the CPU we can never turn it off
> > > from Linux. There are other mechanisms to turn it off when needed,
> > > usually in the RPM firmware or the cpuidle path.
> > >
> > > Without this fix performance states votes are silently ignored, and the
> > > CPU/CPR voltage is never adjusted. This has been broken since 5.14 but
> > > for some reason no one noticed this on QCS404 so far.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 1cb8339ca225 ("cpufreq: qcom: Add support for qcs404 on nvmem driver")
> > > Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> > > ---
> > >  drivers/cpufreq/qcom-cpufreq-nvmem.c | 21 ++++++++++++++++++++-
> > >  1 file changed, 20 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > > index 84d7033e5efe..17d6ab14c909 100644
> > > --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > > +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > > @@ -25,6 +25,7 @@
> > >  #include <linux/platform_device.h>
> > >  #include <linux/pm_domain.h>
> > >  #include <linux/pm_opp.h>
> > > +#include <linux/pm_runtime.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/soc/qcom/smem.h>
> > >
> > > @@ -280,6 +281,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
> > >         }
> > >
> > >         for_each_possible_cpu(cpu) {
> > > +               struct device **virt_devs = NULL;
> > >                 struct dev_pm_opp_config config = {
> > >                         .supported_hw = NULL,
> > >                 };
> > > @@ -300,7 +302,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
> > >
> > >                 if (drv->data->genpd_names) {
> > >                         config.genpd_names = drv->data->genpd_names;
> > > -                       config.virt_devs = NULL;
> > > +                       config.virt_devs = &virt_devs;
> > >                 }
> > >
> > >                 if (config.supported_hw || config.genpd_names) {
> > > @@ -311,6 +313,23 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
> > >                                 goto free_opp;
> > >                         }
> > >                 }
> > > +
> > > +               if (virt_devs) {
> > > +                       const char * const *name = config.genpd_names;
> > > +                       int i;
> > > +
> > > +                       for (i = 0; *name; i++, name++) {
> > > +                               ret = pm_runtime_resume_and_get(virt_devs[i]);
> > > +                               if (ret) {
> > > +                                       dev_err(cpu_dev, "failed to resume %s: %d\n",
> > > +                                               *name, ret);
> > > +                                       goto free_opp;
> > > +                               }
> >
> > Shouldn't we restore the usage count at ->remove() too?
> >
> > > +
> > > +                               /* Keep CPU power domain always-on */
> > > +                               dev_pm_syscore_device(virt_devs[i], true);
> >
> > Is this really correct? cpufreq is suspended/resumed by the PM core
> > during system wide suspend/resume. See dpm_suspend|resume(). Isn't
> > that sufficient?
> >
> > Moreover, it looks like the cpr genpd provider supports genpd's
> > ->power_on|off() callbacks. Is there something wrong with this, that I
> > am missing?
> >
>
> I think this question is a quite fundamental one. To explain this
> properly I will need to delve a bit into the implementation details of
> the two different GENPD providers that are applicable here:
>
> Fundamentally, we are describing the main power supply for the CPU here.
> Consider a simple regulator with adjustable voltage. From the Linux
> point of view this regulator should be marked as "regulator-always-on".
> If we would turn off this regulator, the CPU would be immediately dead
> without proper shutdown done by firmware or hardware.
>
> Representing the regulator as power domain does not change much, except
> that we now have abstract "performance states" instead of actual voltages.
> However, for power domains there is currently no generic mechanism like
> "regulator-always-on" in the DT, only drivers can specify
> GENPD_FLAG_ALWAYS_ON.

We have relied on genpd providers to act on their compatible strings
to make the correct configuration. If that isn't sufficient, I don't
see why we couldn't add a new DT property corresponding to
GENPD_FLAG_ALWAYS_ON.

>
> The special situation on MSM8909 is that there are two possible setups
> for the CPU power supply depending on the PMIC that is used (see
> "[PATCH 4/4] cpufreq: qcom-nvmem: Add MSM8909"): CPR or RPMPD. Both are
> GENPD providers so in theory we can just have either
>
>   cpu@0 { power-domains = <&cpr>; }; // or
>   cpu@0 { power-domains = <&rpmpd MSM8909_VDDCX_AO>; };
>
> in the DT, without handling this specifically on the cpufreq side.

Looks like it would be nice to get a patch for the MSM8909 DTS too, as
part of the series, to get a better picture of how this is going to be
used. Would that be possible for you to provide?

>
> The two GENPD providers behave quite differently though:
>
>  - CPR: CPR is not really a power domain itself. It's more like a monitor
>    on a power supply line coming from some other regulator. CPR provides
>    suggestions how to adjust the voltage for best power/stability.
>
>    The GENPD .power_off() disables the CPR state machine and forwards
>    this to the regulator with regulator_disable(). On QCS404 the
>    regulator is marked regulator-always-on, so it will never be disabled
>    from Linux. The SAW/SPM hardware component on Qualcomm SoCs will
>    usually disable the regulator during deep cpuidle states.

Parts of this sound a bit odd to me. The CPR/CPUfreq shouldn't really
need to vote for the CPU's power-rail(s) from a powered-on/off (CPU
idle states) point of view, but only from a performance (voltage
level) point of view.

If the enable/disable voting on the regulator really has an impact on
some platforms, it sounds like it could prevent deeper CPU idle states
too. That's probably not what we want, right?

I also had a look at the existing CPR genpd provider's probe
function/path (cpr_probe()) - and it turns out there is no call to
regulator_enable(). Whatever that means to us.

>
>  - RPMPD: This is the generic driver for all the SoC power domains
>    managed by the RPM firmware. It's not CPU-specific. However, as
>    special feature each power domain is exposed twice in Linux, e.g.
>    "MSM8909_VDDCX" and "MSM8909_VDDCX_AO". The _AO ("active-only")
>    variant tells the RPM firmware that the performance/enable vote only
>    applies when the CPU is active (not in deep cpuidle state).
>
>    The GENPD .power_off() drops all performance state votes and also
>    releases the "enable" vote for the power domain.
>
> Now, imagine what happens during system wide suspend/resume:
>
>  - CPR: The CPR state machine gets disabled. The voltage stays as-is.
>      - With "regulator-always-on": The CPU keeps running until WFI.
>      - Without: I would expect the CPU is dead immediately(?)

As I indicated above, I am starting to feel that this is a bit upside
down. CPR/CPUfreq should vote on voltages to scale performance, but
not for cpu idle states.

Perhaps what is missing is a synchronization point or a notification,
to inform the CPR driver that its state machine (registers) needs to
be saved/restored, when the power-rails get turned on/off. In fact, we
have a couple mechanisms at hand to support this.

>
>  - RPMPD: The performance/enable vote is dropped. The power domain might
>    go to minimal voltage or even turn off completely. However, the CPU
>    actually needs to keep running at the same frequency until WFI!
>    Worst case, the CPU is dead immediately when the power domain votes
>    get dropped.

Since RPMPD is managing the voting for both performance and low power
states for different kinds of devices, this certainly gets a bit more
complicated.

On the other hand, the CPUfreq driver should really only vote for
performance states for the CPUs and not for low power states. The
latter is a job for cpuidle and other consumers of the RPMPD to
manage, I think.

So, while thinking of this, I just realized that it may not always be
a good idea for genpd to cache a performance state request, for an
attached device and for which pm_runtime_suspended() returns true for
it. As this is the default behaviour in genpd, I am thinking that we
need a way to make that behaviour configurable for an attached device.
What do you think about that?

>
> In case of RPMPD, the votes must remain even during system wide suspend.
> The special _AO variant of the power domain tells the firmware to
> release the votes once the CPU has been shut down cleanly. It will also
> restore them once the CPU wakes up (long before the resume handlers run).
>
> My conclusion was that in both cases we want to keep the "power domain"
> enabled, since the CPU must keep running for a short while even after
> the system suspend handlers have been called.

It looks to me that the system wide suspend/resume case isn't really
much different from the runtime suspend/resume case.

It's not CPUfreq's role (by calling pm_runtime_resume_and_get(), for
example) to prevent the RPMPD from entering a low power state.

>
> Does this help with understanding the problem? It's a bit complicated. :D

Yes, I think so, thanks!

Although, I am afraid my response made this even more complicated. :-)

>
> Thanks!
> Stephan
>
> PS: This is essentially just another manifestation of a discussion we
> had a few times already over the years about where to enable power
> domains used by cpufreq, e.g. [1, 2, 3, 4]. Apparently I already
> mentioned back in 2021 already that QCS404 is broken [5] (I forgot
> about that :')).

Right, I recall these discussions now, thanks for the pointers.

Let's try to get to the bottom of this and figure out a proper solution.

>
> [1]: https://lore.kernel.org/linux-pm/YLi5N06Qs+gYHgYg@gerhold.net/
> [2]: https://lore.kernel.org/linux-pm/20200826093328.88268-1-stephan@gerhold.net/
> [3]: https://lore.kernel.org/linux-pm/20200730080146.25185-1-stephan@gerhold.net/
> [4]: https://lore.kernel.org/linux-arm-msm/20200426123140.GA190483@gerhold.net/
> [5]: https://lore.kernel.org/linux-pm/YLoTl7MfMfq2g10h@gerhold.net/

Kind regards
Uffe
