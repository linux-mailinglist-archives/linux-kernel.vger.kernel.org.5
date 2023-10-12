Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894B17C761B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442046AbjJLSoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442133AbjJLSoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:44:00 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4E8C0;
        Thu, 12 Oct 2023 11:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1697136233; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mDMW5Rng54M0nWYyLXj0uQvtZgxZWkscj46wYH0mK4i0twlfk49kbK4bgpxjRR+8rq
    sxdehlo/Y0bbMg2YJiFFVjMhuA3Hm+SzisGzvgftb4nrn/nn5pUi9rn0POnSzLh06C72
    oNgkRRofvozYKVKnm5R6Me1tVd2zPrDl7gy5LSZocKFpo9D/2c+ImvN1R72il1lxlAnb
    tpr66LT9HLwdqLRGBBPWnyYApViHCTWNN9I2VJ0Y6B9bYL3gLs2EjwVA2S+LbKmpS11Q
    Yf1a0iAa7pfR3qfVM7H5PBlx6+Ue19jOiRMjAz9jMNRp4RhmGs4MoLVLduiVQqEHn2p8
    kBLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1697136233;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=0MnGwJ0SXIlnQRraPKukd+aG+VZtdheQqzL/b8r4kM8=;
    b=QG+G1G/+l1SRw1fTwF0WQAwUOyVIykDoi18dwkXh9ejvCOm8sq2coF/zcL/P/AZYdX
    TBCZwLub1/CARI4AnplxroEP99iKAc4nHs8eYOwqW0Jx+v3Lhj1WjGYnWVNgn09x9UYR
    En4tgqvEC1V2KRX75DZ8zFzNpoLFBLnrHYA1XuQyZSU9suXihTitpp2lhntTikwEg4d6
    UllPDa8ylFCQ35NzwbiyyhgFyF5a/SAdR7hAZejVYXrU+8OFNWXyZ4arf3+Lbox+RCAC
    br84xKBoRaAlAuJR1QsJs7q5ShoiOdUZq8j8k+okwZajuzWml7ajlSjrDa++QnIAccK5
    Z8WA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1697136233;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=0MnGwJ0SXIlnQRraPKukd+aG+VZtdheQqzL/b8r4kM8=;
    b=lG0jSPw4OOBQInrULG4fAowFI8XGuqrtN/8YgR0QaprCCja+d/Ga1JH8GTVcS9i12k
    EAcfTU2tIaaZnDuCFQqFCXAO9Oox8Sq9xcDnr9nhsYgkyI6MxiXqoobJeND40TkwTq3P
    hBp06MoOawH1GNkwjcnInvWZlHIeaJnUIKwBwWrQxR9CXj/b/aeE3XQLs/vHVQXivAgI
    xwhHd3tfH+/4ImhrDcG34q0ulJOFKR1vHKvK4HpbWEU2RlVg2ZOHrVluradmAAoKTnRu
    ap1b6a+KdtmiZeiizWA5WBgOidogY4+zrG3ubpANhVsZGLYxrdghNx3co2e6dJTcBT9r
    Tpyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1697136233;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=0MnGwJ0SXIlnQRraPKukd+aG+VZtdheQqzL/b8r4kM8=;
    b=lA6qtgnXeyanefJK+iSPpxQyVkHwZbXV4/Ta15THx8vyq61cl5sQ4rn4Z0kPeZKvns
    h26NKzUGrmAcr9EFldBQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z2L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z9CIhqcBG
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 12 Oct 2023 20:43:52 +0200 (CEST)
Date:   Thu, 12 Oct 2023 20:43:42 +0200
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
Message-ID: <ZSg-XtwMxg3_fWxc@gerhold.net>
References: <20230912-msm8909-cpufreq-v1-0-767ce66b544b@kernkonzept.com>
 <20230912-msm8909-cpufreq-v1-1-767ce66b544b@kernkonzept.com>
 <CAPDyKFq6U-MR4Bd+GmixYseRECDh142RhydtKbiPd3NHV2g6aw@mail.gmail.com>
 <ZQGqfMigCFZP_HLA@gerhold.net>
 <CAPDyKFppdXe1AZo1jm2Bc_ZR18hw5Bmh1x+2P7Obhb_rJ2gc4Q@mail.gmail.com>
 <ZRcC2IRRv6dtKY65@gerhold.net>
 <CAPDyKFoiup8KNv=1LFGKDdDLA1pHsdJUgTTWMdgxnikEmReXzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoiup8KNv=1LFGKDdDLA1pHsdJUgTTWMdgxnikEmReXzg@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 01:33:34PM +0200, Ulf Hansson wrote:
> On Fri, 29 Sept 2023 at 19:01, Stephan Gerhold <stephan@gerhold.net> wrote:
> > On Fri, Sep 29, 2023 at 03:14:07PM +0200, Ulf Hansson wrote:
> > > On Wed, 13 Sept 2023 at 14:26, Stephan Gerhold <stephan@gerhold.net> wrote:
> > > > On Wed, Sep 13, 2023 at 12:56:16PM +0200, Ulf Hansson wrote:
> > > > > On Tue, 12 Sept 2023 at 11:40, Stephan Gerhold
> > > > > <stephan.gerhold@kernkonzept.com> wrote:
> > > > > > [...]
> > > > > > However, at the
> > > > > > moment nothing ever enables the virtual devices created in
> > > > > > qcom-cpufreq-nvmem for the cpufreq power domain scaling, so they are
> > > > > > permanently runtime-suspended.
> > > > > >
> > > > > > Fix this by enabling the devices after attaching them and use
> > > > > > dev_pm_syscore_device() to ensure the power domain also stays on when
> > > > > > going to suspend. Since it supplies the CPU we can never turn it off
> > > > > > from Linux. There are other mechanisms to turn it off when needed,
> > > > > > usually in the RPM firmware or the cpuidle path.
> > > > > >
> > > > > > Without this fix performance states votes are silently ignored, and the
> > > > > > CPU/CPR voltage is never adjusted. This has been broken since 5.14 but
> > > > > > for some reason no one noticed this on QCS404 so far.
> > > > > >
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Fixes: 1cb8339ca225 ("cpufreq: qcom: Add support for qcs404 on nvmem driver")
> > > > > > Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> > > > > > ---
> > > > > >  drivers/cpufreq/qcom-cpufreq-nvmem.c | 21 ++++++++++++++++++++-
> > > > > >  1 file changed, 20 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > > > > > index 84d7033e5efe..17d6ab14c909 100644
> > > > > > --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > > > > > +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > > > > > @@ -25,6 +25,7 @@
> > > > > >  #include <linux/platform_device.h>
> > > > > >  #include <linux/pm_domain.h>
> > > > > >  #include <linux/pm_opp.h>
> > > > > > +#include <linux/pm_runtime.h>
> > > > > >  #include <linux/slab.h>
> > > > > >  #include <linux/soc/qcom/smem.h>
> > > > > >
> > > > > > @@ -280,6 +281,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
> > > > > >         }
> > > > > >
> > > > > >         for_each_possible_cpu(cpu) {
> > > > > > +               struct device **virt_devs = NULL;
> > > > > >                 struct dev_pm_opp_config config = {
> > > > > >                         .supported_hw = NULL,
> > > > > >                 };
> > > > > > @@ -300,7 +302,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
> > > > > >
> > > > > >                 if (drv->data->genpd_names) {
> > > > > >                         config.genpd_names = drv->data->genpd_names;
> > > > > > -                       config.virt_devs = NULL;
> > > > > > +                       config.virt_devs = &virt_devs;
> > > > > >                 }
> > > > > >
> > > > > >                 if (config.supported_hw || config.genpd_names) {
> > > > > > @@ -311,6 +313,23 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
> > > > > >                                 goto free_opp;
> > > > > >                         }
> > > > > >                 }
> > > > > > +
> > > > > > +               if (virt_devs) {
> > > > > > +                       const char * const *name = config.genpd_names;
> > > > > > +                       int i;
> > > > > > +
> > > > > > +                       for (i = 0; *name; i++, name++) {
> > > > > > +                               ret = pm_runtime_resume_and_get(virt_devs[i]);
> > > > > > +                               if (ret) {
> > > > > > +                                       dev_err(cpu_dev, "failed to resume %s: %d\n",
> > > > > > +                                               *name, ret);
> > > > > > +                                       goto free_opp;
> > > > > > +                               }
> > > > >
> > > > > Shouldn't we restore the usage count at ->remove() too?
> > > > >
> > > > > > +
> > > > > > +                               /* Keep CPU power domain always-on */
> > > > > > +                               dev_pm_syscore_device(virt_devs[i], true);
> > > > >
> > > > > Is this really correct? cpufreq is suspended/resumed by the PM core
> > > > > during system wide suspend/resume. See dpm_suspend|resume(). Isn't
> > > > > that sufficient?
> > > > >
> > > > > Moreover, it looks like the cpr genpd provider supports genpd's
> > > > > ->power_on|off() callbacks. Is there something wrong with this, that I
> > > > > am missing?
> > > > >
> > > >
> > > > I think this question is a quite fundamental one. To explain this
> > > > properly I will need to delve a bit into the implementation details of
> > > > the two different GENPD providers that are applicable here:
> > > >
> > > > Fundamentally, we are describing the main power supply for the CPU here.
> > > > Consider a simple regulator with adjustable voltage. From the Linux
> > > > point of view this regulator should be marked as "regulator-always-on".
> > > > If we would turn off this regulator, the CPU would be immediately dead
> > > > without proper shutdown done by firmware or hardware.
> > > >
> > > > Representing the regulator as power domain does not change much, except
> > > > that we now have abstract "performance states" instead of actual voltages.
> > > > However, for power domains there is currently no generic mechanism like
> > > > "regulator-always-on" in the DT, only drivers can specify
> > > > GENPD_FLAG_ALWAYS_ON.
> > >
> > > We have relied on genpd providers to act on their compatible strings
> > > to make the correct configuration. If that isn't sufficient, I don't
> > > see why we couldn't add a new DT property corresponding to
> > > GENPD_FLAG_ALWAYS_ON.
> > >
> >
> > Right. It's not completely trivial though, since a DT node may provide
> > many different power domains with #power-domain-cells = <N>. A regulator
> > on the other hand has a dedicated DT node where you can just add
> > "regulator-always-on". :')
> 
> Sure, it can get a bit messy, but we will work it out if we have too.
> 
> Perhaps looking for a specific compitbile string for the cpr can work
> instead? No?
> 

It's easy for CPR, but more complicated for RPMPD because it manages
multiple power domains from a single DT node. In general, only the ones
used by the CPU need to be always-on (see explanation at the end of the
mail).

> >
> > > >
> > > > The special situation on MSM8909 is that there are two possible setups
> > > > for the CPU power supply depending on the PMIC that is used (see
> > > > "[PATCH 4/4] cpufreq: qcom-nvmem: Add MSM8909"): CPR or RPMPD. Both are
> > > > GENPD providers so in theory we can just have either
> > > >
> > > >   cpu@0 { power-domains = <&cpr>; }; // or
> > > >   cpu@0 { power-domains = <&rpmpd MSM8909_VDDCX_AO>; };
> > > >
> > > > in the DT, without handling this specifically on the cpufreq side.
> > >
> > > Looks like it would be nice to get a patch for the MSM8909 DTS too, as
> > > part of the series, to get a better picture of how this is going to be
> > > used. Would that be possible for you to provide?
> > >
> >
> > Sure! Right now I cannot include it as working patch in this series
> > since I don't have the base SoC DT (msm8909.dtsi) upstream yet. It's
> > mostly a copy-paste of msm8916.dtsi so I was trying to finish up the
> > SoC-specific parts before sending it.
> >
> > I'm happy to provide links to the full DT and my changes though. Does
> > that help? If you would like to comment inline I could copy paste the
> > diffs in a mail or include some kind of RFC patch. It just wouldn't be
> > possible to apply it successfully. :')
> >
> > Here are the two commits with the my current DT changes (WIP):
> >   - MSM8909+PM8909 (RPMPD only):
> >     https://github.com/msm8916-mainline/linux/commit/791e0c5a3162372a0738bc7b0f4a5e87247923db
> 
> Okay, so this looks pretty straight forward. One thing though, it
> looks like we need to update the DT bindings for cpus.
> 
> I recently updated Documentation/devicetree/bindings/arm/cpus.yaml
> [1], to let "perf" be the common "power-domain-name" for a CPU's SCMI
> performance-domain. I look like we should extend the description to
> allow "perf" to be used for all types of performance domains.
> 

"perf" sounds fine for a single power domain, I just used "apc" here for
consistency with the MSM8916 changes (which scales this power domain and
several others, as you saw).

(BTW, I would appreciate such a generic name for the cpuidle case as
 well, so "idle" instead of "psci" vs "sbi". I have another WIP cpuidle
 driver and didn't want to invent another name there...)

> >   - MSM8916 (CPR+RPMPD):
> >     https://github.com/msm8916-mainline/linux/commit/8880f39108206d7a60a0a8351c0373bddf58657c
> 
> This looks a bit odd to me. Does a CPU really have four different
> power-domains, where three of them are performance-domains?
> 

Good question. I think we're largely entering "uncharted territory" with
these questions, I can just try to answer it the best I can from the
limited documentation and knowledge I have. :)

The CPU does indeed use four different power domains. There also seem to
be additional power switches that gate power for some components without
having to turn off the entire supply.

I'll list them twice from two points of view: Once mapping component ->
power domain, then again showing each power domain separately to make it
more clear. At the end I also want to make clear that MSM8909 (with the
"single" power domain) is actually exactly the same SoC design, just
with different regulators supplying the power domains.

It's totally fine if you just skim over it. I'm listing it in detail
also as reference for myself. :D

# Components
 - SoC
   - CPU subsystem ("APPS")
     - CPU cluster
       - 4x CPU core (logic and L1 cache) -> VDD_APC
       - Shared L2 cache
         - Logic -> VDD_APC
         - Memory -> VDD_MX
     - CPU clock controller (logic) -> VDD_CX
       - Provides CPU frequency from different clock sources
       - L2 cache runs at 1/2 of CPU frequency
       => Both VDD_APC and VDD_MX must be scaled based on frequency
     - CPU PLL clock source
       - Generates the higher (GHz) CPU frequencies
       - Logic (?, unsure) -> VDD_CX
       - ??? -> VDD_SR2_APPS_PLL
       => VDD_CX must be scaled based on PLL frequency

# Power Domains
## VDD_APC
 - dedicated for CPU
 - powered off completely in deepest cluster cpuidle state

 - per-core power switch (per-core cpuidle)
   - CPU logic
   - L1 cache controller/logic and maybe memory(?, unsure)
 - shared L2 cache controller/logic

 => must be scaled based on CPU frequency

## VDD_MX
 - global SoC power domain for "on-chip memories"
 - always on, reduced to minimal voltage when entire SoC is idle

 - power switch (controlled by deepest cluster cpuidle state?, unsure)
   - L2 cache memory

 => must be scaled based on L2 frequency (=> 1/2 CPU frequency)

## VDD_CX
 - global SoC power domain for "digital logic"
 - always on, reduced to minimal voltage when entire SoC is idle
 - voting for VDD_CX in the RPM firmware also affects VDD_MX performance
   state (firmware implicitly sets VDD_MX >= VDD_CX)

 - CPU clock controller logic, CPU PLL logic(?, unsure)

 => must be scaled based on CPU PLL frequency

## VDD_SR2_APPS_PLL
 - global SoC power domain for CPU clock PLLs
 - on MSM8916: always on with constant voltage

 => ignored in Linux at the moment

# Power Domain Regulators
These power domains are literally input pins on the SoC chip. In theory
one could connect any suitable regulator to each of those. In practice
there are just a couple of standard reference designs that everyone
uses:

## MSM8916 (SoC) + PM8916 (PMIC)
We need to scale 3 power domains together with cpufreq:

 - VDD_APC (CPU logic) = &pm8916_spmi_s2 (via CPR)
 - VDD_MX  (L2 memory) = &pm8916_l3 (via RPMPD: MSM8916_VDDMX)
 - VDD_CX  (CPU PLL)   = &pm8916_s1 (via RPMPD: MSM8916_VDDCX)

## MSM8909 (SoC) + PM8909 (PMIC)
We need to scale 1 power domain together with cpufreq:

 - VDD_APC = VDD_CX    = &pm8909_s1 (via RPMPD: MSM8909_VDDCX)
   (CPU logic, L2 logic and CPU PLL)
(- VDD_MX  (L2 memory) = &pm8909_l3 (RPM firmware enforces VDD_MX >= VDD_CX))

There is implicit magic in the RPM firmware here that saves us from
scaling VDD_MX. VDD_CX/APC are the same power rail.

## MSM8909 (SoC) + PM8916 (PMIC)
When MSM8909 is paired with PM8916 instead of PM8909, the setup is
identical to MSM8916+PM8916. We need to scale 3 power domains.

> In a way it sounds like an option could be to hook up the cpr to the
> rpmpd:s instead (possibly even set it as a child-domains to the
> rpmpd:s), assuming that is a better description of the HW, which it
> may not be, of course.

Hm. It's definitely an option. I must admit I haven't really looked
much at child-domains so far, so spontaneously I'm not sure about
the implications, for both the abstract hardware description and
the implementation.

There seems to be indeed some kind of relation between MX <=> CX/APC:

 - When voting for CX in the RPM firmware, it will always implicitly
   adjust the MX performance state to be MX >= CX.

 - When scaling APC up, we must increase MX before APC.
 - When scaling APC down, we must decrease MX after APC.
 => Clearly MX >= APC. Not in terms of raw voltage, but at least for the
    abstract performance state.

Is this some kind of parent-child relationship between MX <=> CX and
MX <=> APC?

If yes, maybe we could indeed bind MX to the CPR genpd somehow. They use
different performance state numbering, so we need some kind of
translation. I'm not entirely sure how that would be described.

Scaling VDD_CX for the PLL is more complicated. APC <=> CX feel more
like siblings, so I don't think it makes sense to vote for CX as part of
the CPR genpd. Spontaneously I would argue scaling CX belongs into the
CPU PLL driver (since that's what the vote is for). However, for some
reason it was decided to handle such votes on the consumer side (here =
cpufreq) on mainline [1].

[1]: https://lore.kernel.org/linux-arm-msm/20200910162610.GA7008@gerhold.net/

> When it comes to the regulator, vdd-apc-supply, it seems fine to me to
> set it as an always-on regulator. Maybe another option could simply be
> to leave it enabled when the cpr driver has probed.
> 

Agreed.

> >   (- QCS404 (CPR only): already in mainline (see qcs404.dtsi))
> >
> 
> Okay, so in this case it's solely the cpr that manages the performance
> scaling for the CPU.
> 

I'm not sure but I suspect there are also more power domains involved
here, just hidden behind other implicit magic that we don't need to
control ourselves.

> In regards to the vdd-apc-supply, it seems to be used in the similar
> way in the case above.
> 

Yep.

> > > >
> > > > The two GENPD providers behave quite differently though:
> > > >
> > > >  - CPR: CPR is not really a power domain itself. It's more like a monitor
> > > >    on a power supply line coming from some other regulator. CPR provides
> > > >    suggestions how to adjust the voltage for best power/stability.
> > > >
> > > >    The GENPD .power_off() disables the CPR state machine and forwards
> > > >    this to the regulator with regulator_disable(). On QCS404 the
> > > >    regulator is marked regulator-always-on, so it will never be disabled
> > > >    from Linux. The SAW/SPM hardware component on Qualcomm SoCs will
> > > >    usually disable the regulator during deep cpuidle states.
> > >
> > > Parts of this sound a bit odd to me. The CPR/CPUfreq shouldn't really
> > > need to vote for the CPU's power-rail(s) from a powered-on/off (CPU
> > > idle states) point of view, but only from a performance (voltage
> > > level) point of view.
> > >
> > > If the enable/disable voting on the regulator really has an impact on
> > > some platforms, it sounds like it could prevent deeper CPU idle states
> > > too. That's probably not what we want, right?
> > >
> >
> > I think this heavily depends on what exactly this "regulator"
> > represents. Are we talking about a physical regulator with a binary
> > enable/disable signal or actually some hardware/firmware magic that
> > combines multiple independent "votes"?
> >
> > If we are talking about a physical regulator then we can never disable
> > it from Linux. Not even during CPU idle states. It would just cut off
> > all power immediately and kill the CPU without proper shutdown. Instead,
> > the platform might have special hardware/firmware functionality that
> > will control the actual physical enable/disable signal of the regulator.
> >
> > > I also had a look at the existing CPR genpd provider's probe
> > > function/path (cpr_probe()) - and it turns out there is no call to
> > > regulator_enable(). Whatever that means to us.
> >
> > In most (all?) setups the CPR genpd provider will manage the actual
> > physical regulator. It could be part of the PMIC or even some
> > off-the-shelf regulator with I2C control. It doesn't matter. There is
> > nothing special about that regulator. You have the standard Linux
> > regulator driver, set up the DT node for it and hook it up to CPR.
> >
> > Now, to prevent the regulator driver in Linux from touching the physical
> > enable signal (see above) we add "regulator-always-on". When Linux
> > requests deep CPU idle states via PSCI the hardware will toggle the
> > physical enable/disable signal of the regulator for us (after the CPU
> > has been shut down).
> >
> > On some platforms CPR is also used for the GPU or other power rails that
> > are not critical for the CPU to run. In that case it's fine to disable
> > the regulator directly from Linux. Just not for the CPU.
> 
> Right. I get the point, thanks for clarifying!
> 
> Still, the CPR can't just disable the regulator for a GPU without
> using some kind of synchronization point for when to do it. The GPU
> may be running some use cases, etc. Although, let's leave that out of
> this discussion. :-)
> 

(Here I assumed that the Linux GPU driver (running on the CPU) is in
 full control of the GPU. So it explicitly turns the GPU power domain on
 when the GPU is needed and turns it off only when the GPU is idle.)

> >
> > >
> > > >
> > > >  - RPMPD: This is the generic driver for all the SoC power domains
> > > >    managed by the RPM firmware. It's not CPU-specific. However, as
> > > >    special feature each power domain is exposed twice in Linux, e.g.
> > > >    "MSM8909_VDDCX" and "MSM8909_VDDCX_AO". The _AO ("active-only")
> > > >    variant tells the RPM firmware that the performance/enable vote only
> > > >    applies when the CPU is active (not in deep cpuidle state).
> > > >
> > > >    The GENPD .power_off() drops all performance state votes and also
> > > >    releases the "enable" vote for the power domain.
> > > >
> > > > Now, imagine what happens during system wide suspend/resume:
> > > >
> > > >  - CPR: The CPR state machine gets disabled. The voltage stays as-is.
> > > >      - With "regulator-always-on": The CPU keeps running until WFI.
> > > >      - Without: I would expect the CPU is dead immediately(?)
> > >
> > > As I indicated above, I am starting to feel that this is a bit upside
> > > down. CPR/CPUfreq should vote on voltages to scale performance, but
> > > not for cpu idle states.
> > >
> > > Perhaps what is missing is a synchronization point or a notification,
> > > to inform the CPR driver that its state machine (registers) needs to
> > > be saved/restored, when the power-rails get turned on/off. In fact, we
> > > have a couple mechanisms at hand to support this.
> > >
> >
> > I think we can ignore this part of CPR for now. AFAICT Qualcomm's vendor
> > driver does not explicitly disable the CPR state machine during CPU idle
> > when the power rails are potentially turned off. They only do it during
> > system wide suspend, for whatever reason. For that we don't need such a
> > notification mechanism.
> 
> I see.
> 
> So, if I understand correctly, we could potentially use the regular
> system suspend/resume callbacks for the CPR genpd provider driver,
> rather than its genpd->power_on|off() callbacks?
> 

Exactly. At least that's what Qualcomm seems to do...

> >
> > > >
> > > >  - RPMPD: The performance/enable vote is dropped. The power domain might
> > > >    go to minimal voltage or even turn off completely. However, the CPU
> > > >    actually needs to keep running at the same frequency until WFI!
> > > >    Worst case, the CPU is dead immediately when the power domain votes
> > > >    get dropped.
> > >
> > > Since RPMPD is managing the voting for both performance and low power
> > > states for different kinds of devices, this certainly gets a bit more
> > > complicated.
> > >
> > > On the other hand, the CPUfreq driver should really only vote for
> > > performance states for the CPUs and not for low power states. The
> > > latter is a job for cpuidle and other consumers of the RPMPD to
> > > manage, I think.
> > >
> > > So, while thinking of this, I just realized that it may not always be
> > > a good idea for genpd to cache a performance state request, for an
> > > attached device and for which pm_runtime_suspended() returns true for
> > > it. As this is the default behaviour in genpd, I am thinking that we
> > > need a way to make that behaviour configurable for an attached device.
> > > What do you think about that?
> > >
> >
> > Hm. This would be a bit of a special case of course. But I think this
> > would be fine to solve the regression for CPR on QCS404.
> 
> Okay, I will try to propose and submit something for this shortly. I
> will keep you cc:ed.
> 

Thanks a lot!

> >
> > Then we "just" need to solve the fundamental question from a few years
> > ago: Who *will* actually vote for enabling the power domains/regulators
> > required by the CPU? :D
> >
> > I agree that enabling/disabling power supplies feels closer to cpuidle.
> > But it's not a perfect fit either, given that we don't actually want to
> > change our vote while entering CPU idle states. I think on all platforms
> > I'm looking at here we need a permanent enable vote (effectively making
> > the regulator/power domains always-on from the Linux point of view).
> >
> > We could solve this by adding a "regulator-always-on" mechanism in the
> > DT for power domains. This feels more like a workaround to me than an
> > actual solution.
> 
> From the discussions above, it sounded like it would be sufficient to
> use the regulator-always-on for the actual regulator supply.
> 
> In the case where there is no cpr being used on the platform, there
> also is no regulator that needs to stay enabled, right?
> 

Yes and no. There is no regulator we need to keep enabled. But we need
to keep the CPU-related RPMPDs always-on too.

> > With this the CPU won't appear as always-on consumer of
> > the power domains in debugfs. There will just be a "suspended" consumer
> > attributed to the CPU (from CPUfreq, since we don't have a dedicated
> > device for CPUfreq).
> 
> I didn't quite get this part.
> 
> The devices that we hook up to the genpd from cpufreq are used for
> performance scaling, not for power-on/off things. It shouldn't matter
> if these devices are "suspended" from debugfs/sysfs point of view,
> right?
> 
> Or did I fail to understand your point?
> 

My point here was: If we only set GENPD_FLAG_ALWAYS_ON for the RPMPDs
needed by the CPU, then it won't be obvious from debugfs that it's the
CPU that is keeping the power domains always-on. It's not a big problem.

> >
> > While this patch is a bit strange from a conceptual perspective, on the
> > implementation side it effectively makes that CPU consumer appear as
> > active. So the end result is actually kind of the one we need. :'D
> 
> Right. It looks like we are concluding on the way forward. :-)
> 
> *) The approach you have taken in the $subject patch with the call to
> pm_runtime_resume_and_get() works as a fix for QCS404, as there is
> only the CPR to attach to. The problem with it, is that it doesn't
> work for cases where the RPMPD is used for performance scaling, either
> separate or in combination with the CPR. It would keep the rpmpd:s
> powered-on, which would be wrong. In regards to the
> dev_pm_syscore_device() thingy, this should not be needed, as long as
> we keep the vdd-apc-supply enabled, right?
> 
> **) A more generic solution, that would work for all cases (even
> when/if hooking up the CPR to the rpmpd:s), consists of tweaking genpd
> to avoid "caching" performance states for these kinds of devices. And
> again, I don't see that we need dev_pm_syscore_device(), assuming we
> manage the vdd-apc-supply correctly.
> 
> Did I miss anything?
> 

We do need to keep the CPU-related RPMPDs always-on too.

Keeping the CPU-related RPMPDs always-on is a bit counter-intuitive, but
it's because of this:

> > > >  - RPMPD: This is the generic driver for all the SoC power domains
> > > >    managed by the RPM firmware. It's not CPU-specific. However, as
> > > >    special feature each power domain is exposed twice in Linux, e.g.
> > > >    "MSM8909_VDDCX" and "MSM8909_VDDCX_AO". The _AO ("active-only")
> > > >    variant tells the RPM firmware that the performance/enable vote only
> > > >    applies when the CPU is active (not in deep cpuidle state).

The CPU only uses the "_AO"/active-only variants in RPMPD. Keeping these
always-on effectively means "keep the power domain on as long as the CPU
is active".

I hope that clears up some of the confusion. :)

Thanks a lot for taking the time to discuss this!

Stephan
