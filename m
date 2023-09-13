Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E402679E7DF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbjIMM0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240320AbjIMM0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:26:50 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B31819A8;
        Wed, 13 Sep 2023 05:26:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694608003; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JTSmR/6ETpbi0uwjyDU97x1BjHLQso5BodTIIkziKs/BELGtBVqA4GOrL3h9e0351S
    cwkjAebGYQgm1ezPtlpHy0OYveFtwgURKFZlOnQsdWLms5UuSQz4eCT5UUK+Odc2g5MP
    XqNvY7vHkKmwEbK5ciO1kO3vqlEm356+AyaAfxUwkhDSxtF3g6okMHXEpOh5xAhGRUyn
    Dfqge6qektsUrZj+IleEOPl6ejiDKAnxKWI4FgWlG8lXSvuTa/jINMwtmtAduFsy0qbz
    xCpORXyXIWVZ+jgN0Do/CzDg8WdFLS4572G9EzIyOBRePjyirGQzNT2MrFNNb0E2r0Hg
    aW2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694608003;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=zhdv2FQe74GDYo6+S9T5NhlkCfIw7X/kW3Qtxk4kjH4=;
    b=iE7mB2CP2NATK32oV+viiPzSe/lhQwHgYalz0SkYwhdMClTQ8n0sKnUXSaSiqMRnog
    eG38frZ6RbeiTDkFCDPwggskCBTKzx4FxLC90ApnXnaTZq6CyGs3IUAPK91rCobzo1UF
    JCQ3cYAYidAjWwhbuF+n1nlb0v5IrFmNCKLRgeLQXNmTX4hBbjPLB7Jba8VBwsMVqZM+
    7doOXDZpe0eUFIUJXHzHaDWmRZUfB+BhSerSzF/f1XJrDPFxdcBTeCHQUrs+L5ipJFYS
    X9Rp1Kk1JKh4ntCn/3YehF+YDBqgiwSQWw8P3c0dXNZTUmGR5iyBzDcs9ZQjt56eRGse
    OZww==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694608003;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=zhdv2FQe74GDYo6+S9T5NhlkCfIw7X/kW3Qtxk4kjH4=;
    b=pQqZLsnR5ruF9UUMsuzglnSh2RJQQSzieMLd13p91f8cU/Vv5aFdYFQOIgIsrEXInF
    KpQYkfIPquP3/w0xDOLZiuNDBLZrXnjBWIFleP9fjx7sCeHSSgbjgKcmxuRgsDNLIYDV
    a9Xk5oBthvR9VgI0DfRtXNafr8976/jgNy5gpHmN01KwelxZIJFIGqMfduScVw9ZYBzF
    c05zd4HH0geiHTXW7/mb8Uy8WrFP0HwjLeCQA2GSW1EyVDHIHa3IDdH+q4qYwVKZkosO
    LNZUuzAgLEaVhpdFcciNTRSiBq2wrSgzaXkcq4pIB0Tzfr2YCGL0oK1kK8kMMVhWSDT2
    2VeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694608003;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=zhdv2FQe74GDYo6+S9T5NhlkCfIw7X/kW3Qtxk4kjH4=;
    b=S63ltOhMHN80NiyrOQKiTl6lt9vygvAshpVYnE7NSFbUFYjoV2Y4HQeV6BSJAM2HmI
    PzxfWJKY8TwdZPw8C/Dw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id xb560bz8DCQgtpe
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 13 Sep 2023 14:26:42 +0200 (CEST)
Date:   Wed, 13 Sep 2023 14:26:36 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
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
Subject: Re: [PATCH 1/4] cpufreq: qcom-nvmem: Enable virtual power domain
 devices
Message-ID: <ZQGqfMigCFZP_HLA@gerhold.net>
References: <20230912-msm8909-cpufreq-v1-0-767ce66b544b@kernkonzept.com>
 <20230912-msm8909-cpufreq-v1-1-767ce66b544b@kernkonzept.com>
 <CAPDyKFq6U-MR4Bd+GmixYseRECDh142RhydtKbiPd3NHV2g6aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq6U-MR4Bd+GmixYseRECDh142RhydtKbiPd3NHV2g6aw@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 12:56:16PM +0200, Ulf Hansson wrote:
> On Tue, 12 Sept 2023 at 11:40, Stephan Gerhold
> <stephan.gerhold@kernkonzept.com> wrote:
> >
> > The genpd core ignores performance state votes from devices that are
> > runtime suspended as of commit 5937c3ce2122 ("PM: domains: Drop/restore
> > performance state votes for devices at runtime PM").
> 
> I think you are referring to the wrong commit above. Please have a
> look at commit 3c5a272202c2 ("PM: domains: Improve runtime PM
> performance state handling"), instead.
> 
> I also suggest rephrasing the above into saying that the performance
> state vote for a device is cached rather than carried out, if
> pm_runtime_suspended() returns true for it.
> 
> Another relevant information in the commit message would be to add
> that during device-attach (genpd_dev_pm_attach_by_id()), calls
> pm_runtime_enable() the device.
> 

Thanks, I will try to clarify this a bit! I was actually looking at that
commit originally but decided to reference the commit that "started the
change", since the this commit is marked as fix of the one I referenced.
But I think you're right, it would be more clear to reference "PM:
domains: Improve runtime PM performance state handling" directly.

> > However, at the
> > moment nothing ever enables the virtual devices created in
> > qcom-cpufreq-nvmem for the cpufreq power domain scaling, so they are
> > permanently runtime-suspended.
> >
> > Fix this by enabling the devices after attaching them and use
> > dev_pm_syscore_device() to ensure the power domain also stays on when
> > going to suspend. Since it supplies the CPU we can never turn it off
> > from Linux. There are other mechanisms to turn it off when needed,
> > usually in the RPM firmware or the cpuidle path.
> >
> > Without this fix performance states votes are silently ignored, and the
> > CPU/CPR voltage is never adjusted. This has been broken since 5.14 but
> > for some reason no one noticed this on QCS404 so far.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 1cb8339ca225 ("cpufreq: qcom: Add support for qcs404 on nvmem driver")
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> > ---
> >  drivers/cpufreq/qcom-cpufreq-nvmem.c | 21 ++++++++++++++++++++-
> >  1 file changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > index 84d7033e5efe..17d6ab14c909 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_domain.h>
> >  #include <linux/pm_opp.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/slab.h>
> >  #include <linux/soc/qcom/smem.h>
> >
> > @@ -280,6 +281,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
> >         }
> >
> >         for_each_possible_cpu(cpu) {
> > +               struct device **virt_devs = NULL;
> >                 struct dev_pm_opp_config config = {
> >                         .supported_hw = NULL,
> >                 };
> > @@ -300,7 +302,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
> >
> >                 if (drv->data->genpd_names) {
> >                         config.genpd_names = drv->data->genpd_names;
> > -                       config.virt_devs = NULL;
> > +                       config.virt_devs = &virt_devs;
> >                 }
> >
> >                 if (config.supported_hw || config.genpd_names) {
> > @@ -311,6 +313,23 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
> >                                 goto free_opp;
> >                         }
> >                 }
> > +
> > +               if (virt_devs) {
> > +                       const char * const *name = config.genpd_names;
> > +                       int i;
> > +
> > +                       for (i = 0; *name; i++, name++) {
> > +                               ret = pm_runtime_resume_and_get(virt_devs[i]);
> > +                               if (ret) {
> > +                                       dev_err(cpu_dev, "failed to resume %s: %d\n",
> > +                                               *name, ret);
> > +                                       goto free_opp;
> > +                               }
> 
> Shouldn't we restore the usage count at ->remove() too?
> 
> > +
> > +                               /* Keep CPU power domain always-on */
> > +                               dev_pm_syscore_device(virt_devs[i], true);
> 
> Is this really correct? cpufreq is suspended/resumed by the PM core
> during system wide suspend/resume. See dpm_suspend|resume(). Isn't
> that sufficient?
> 
> Moreover, it looks like the cpr genpd provider supports genpd's
> ->power_on|off() callbacks. Is there something wrong with this, that I
> am missing?
> 

I think this question is a quite fundamental one. To explain this
properly I will need to delve a bit into the implementation details of
the two different GENPD providers that are applicable here:

Fundamentally, we are describing the main power supply for the CPU here.
Consider a simple regulator with adjustable voltage. From the Linux
point of view this regulator should be marked as "regulator-always-on".
If we would turn off this regulator, the CPU would be immediately dead
without proper shutdown done by firmware or hardware.

Representing the regulator as power domain does not change much, except
that we now have abstract "performance states" instead of actual voltages.
However, for power domains there is currently no generic mechanism like
"regulator-always-on" in the DT, only drivers can specify
GENPD_FLAG_ALWAYS_ON.

The special situation on MSM8909 is that there are two possible setups
for the CPU power supply depending on the PMIC that is used (see
"[PATCH 4/4] cpufreq: qcom-nvmem: Add MSM8909"): CPR or RPMPD. Both are
GENPD providers so in theory we can just have either

  cpu@0 { power-domains = <&cpr>; }; // or
  cpu@0 { power-domains = <&rpmpd MSM8909_VDDCX_AO>; };

in the DT, without handling this specifically on the cpufreq side.

The two GENPD providers behave quite differently though:

 - CPR: CPR is not really a power domain itself. It's more like a monitor
   on a power supply line coming from some other regulator. CPR provides
   suggestions how to adjust the voltage for best power/stability.

   The GENPD .power_off() disables the CPR state machine and forwards
   this to the regulator with regulator_disable(). On QCS404 the
   regulator is marked regulator-always-on, so it will never be disabled
   from Linux. The SAW/SPM hardware component on Qualcomm SoCs will
   usually disable the regulator during deep cpuidle states.

 - RPMPD: This is the generic driver for all the SoC power domains
   managed by the RPM firmware. It's not CPU-specific. However, as
   special feature each power domain is exposed twice in Linux, e.g.
   "MSM8909_VDDCX" and "MSM8909_VDDCX_AO". The _AO ("active-only")
   variant tells the RPM firmware that the performance/enable vote only
   applies when the CPU is active (not in deep cpuidle state).

   The GENPD .power_off() drops all performance state votes and also
   releases the "enable" vote for the power domain.

Now, imagine what happens during system wide suspend/resume:

 - CPR: The CPR state machine gets disabled. The voltage stays as-is.
     - With "regulator-always-on": The CPU keeps running until WFI.
     - Without: I would expect the CPU is dead immediately(?)

 - RPMPD: The performance/enable vote is dropped. The power domain might
   go to minimal voltage or even turn off completely. However, the CPU
   actually needs to keep running at the same frequency until WFI!
   Worst case, the CPU is dead immediately when the power domain votes
   get dropped.

In case of RPMPD, the votes must remain even during system wide suspend.
The special _AO variant of the power domain tells the firmware to
release the votes once the CPU has been shut down cleanly. It will also
restore them once the CPU wakes up (long before the resume handlers run).

My conclusion was that in both cases we want to keep the "power domain"
enabled, since the CPU must keep running for a short while even after
the system suspend handlers have been called.

Does this help with understanding the problem? It's a bit complicated. :D

Thanks!
Stephan

PS: This is essentially just another manifestation of a discussion we
had a few times already over the years about where to enable power
domains used by cpufreq, e.g. [1, 2, 3, 4]. Apparently I already
mentioned back in 2021 already that QCS404 is broken [5] (I forgot
about that :')).

[1]: https://lore.kernel.org/linux-pm/YLi5N06Qs+gYHgYg@gerhold.net/
[2]: https://lore.kernel.org/linux-pm/20200826093328.88268-1-stephan@gerhold.net/
[3]: https://lore.kernel.org/linux-pm/20200730080146.25185-1-stephan@gerhold.net/
[4]: https://lore.kernel.org/linux-arm-msm/20200426123140.GA190483@gerhold.net/
[5]: https://lore.kernel.org/linux-pm/YLoTl7MfMfq2g10h@gerhold.net/
