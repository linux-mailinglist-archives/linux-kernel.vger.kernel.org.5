Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363037FBA5A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbjK1MmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbjK1Ml7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:41:59 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A00D59;
        Tue, 28 Nov 2023 04:42:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701175322; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oAvSZlvrEVIFs9exHkMFKW3+YoVO7gKmlBuHFpcNlEYCkX8wijvmUZ6aq12dEMxX3v
    NoCrZkl8asmN0fmCMXalhhEK8NROcPAIIlybnUkAmEmogZMhrQZSboXHXDRUbEr4Nhxg
    KO2BAom4A+6hhtG9Rzy9E1iFaZBeDOM+XkZY0PY34IDu6KA+QJIoGActSU2bMxCkvAvO
    1u00QefNwyafrSgoWQrjlWxVHueUdn4CLFuq8WlyLjIZ+CENqBrDIELTym02Ho5XA1iV
    s+sdwH1oRZ9x0IzTaYbIBUCT2a4IMOlq+3CzlHeUlorxSEFNyqBd5q4N8QM0HCoU79XC
    2m8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1701175322;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=TS8/WXeqr+m6rKcDo8NKgNdTMbcPnyKqnODnr8gI8hs=;
    b=Q/gfLd4L4xzjF91QdYPUPNqocXqvunJdg0rPc6CGdR4QHAk6lK13LNbUEs30P5UljZ
    uqMP0xqu8kNAAsbjud2bppeY+OiRyzvFXyp/xoH8WBeiq9CAFFroU131wUeVnioI/3sU
    JW3EGTpFTqwRozdUuuDMf+LWeto4maffmGJDcHr5NFQTeGsQRGOKCf3vXBoab2GXhbw/
    frYcQ1R9zxQrFLvy9ReG/r9oDdawP2YVJRsg0Y9HLWo82uveDMihRKR/sxVeB1rFExSZ
    yEt0zrzQkvTIRmcEVh09m4BNoNkBJDu3k3htMkvXUiY1CLyrRSxzKHXGqYZbC1XrRKxK
    Zo7w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1701175322;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=TS8/WXeqr+m6rKcDo8NKgNdTMbcPnyKqnODnr8gI8hs=;
    b=BoO+G5sWWQNmY/5dRxdbHlFH9pxjZj/RYZ+xf6VhQtMHgqcbFe/9c9gPyYE3FSRSE6
    A8eiahSXghyaNtt7r+MuCCsvUpskPODuvMlhNYVHD8oHqJWX+yFbaYeYODXe+nDxsZ3B
    k1/pJO3FnDZNzqM/V4th58pz2ndK2JKLGsW5dPNB+EHfO/1Efhn9JGVG+0dXY0N+VRVY
    7okcarziiU+RFwm2Wb9xiS1HB0Pnh3/kL0hRS3YhUMumJRXd7eJExn/ePak+73LnJm/y
    U3+KX8iscb7leQ6/euMwW3vTEWYF0UmmJXHHNPa/T8r0/KNrI24n2sKB44xpf0ewzD4k
    83ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1701175322;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=TS8/WXeqr+m6rKcDo8NKgNdTMbcPnyKqnODnr8gI8hs=;
    b=IzmrX3mfqfsZT9NHUBJSSsUiqhdkaXvkf/Rj4TM1Kqski1PWl9IFsvBLubhdi5REoE
    Wl7Ma/qr7iuT6izExVBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8paF1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id t3efe7zASCg2mDV
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 28 Nov 2023 13:42:02 +0100 (CET)
Date:   Tue, 28 Nov 2023 13:41:56 +0100
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
Subject: Re: [PATCH 1/4] cpufreq: qcom-nvmem: Handling multiple power domains
Message-ID: <ZWXgFNKgm9QaFuzx@gerhold.net>
References: <20230912-msm8909-cpufreq-v1-0-767ce66b544b@kernkonzept.com>
 <20230912-msm8909-cpufreq-v1-1-767ce66b544b@kernkonzept.com>
 <CAPDyKFq6U-MR4Bd+GmixYseRECDh142RhydtKbiPd3NHV2g6aw@mail.gmail.com>
 <ZQGqfMigCFZP_HLA@gerhold.net>
 <CAPDyKFppdXe1AZo1jm2Bc_ZR18hw5Bmh1x+2P7Obhb_rJ2gc4Q@mail.gmail.com>
 <ZRcC2IRRv6dtKY65@gerhold.net>
 <CAPDyKFoiup8KNv=1LFGKDdDLA1pHsdJUgTTWMdgxnikEmReXzg@mail.gmail.com>
 <ZSg-XtwMxg3_fWxc@gerhold.net>
 <CAPDyKFoH5EOvRRKy-Bgp_B9B3rf=PUKK5N45s5PNgfBi55PaOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoH5EOvRRKy-Bgp_B9B3rf=PUKK5N45s5PNgfBi55PaOQ@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uffe,

On Mon, Oct 16, 2023 at 04:47:52PM +0200, Ulf Hansson wrote:
> [...]
> > > >   - MSM8916 (CPR+RPMPD):
> > > >     https://github.com/msm8916-mainline/linux/commit/8880f39108206d7a60a0a8351c0373bddf58657c
> > >
> > > This looks a bit odd to me. Does a CPU really have four different
> > > power-domains, where three of them are performance-domains?
> > >
> >
> > Good question. I think we're largely entering "uncharted territory" with
> > these questions, I can just try to answer it the best I can from the
> > limited documentation and knowledge I have. :)
> >
> > The CPU does indeed use four different power domains. There also seem to
> > be additional power switches that gate power for some components without
> > having to turn off the entire supply.
> >
> > I'll list them twice from two points of view: Once mapping component ->
> > power domain, then again showing each power domain separately to make it
> > more clear. At the end I also want to make clear that MSM8909 (with the
> > "single" power domain) is actually exactly the same SoC design, just
> > with different regulators supplying the power domains.
> >
> > It's totally fine if you just skim over it. I'm listing it in detail
> > also as reference for myself. :D
> >
> > # Components
> >  - SoC
> >    - CPU subsystem ("APPS")
> >      - CPU cluster
> >        - 4x CPU core (logic and L1 cache) -> VDD_APC
> >        - Shared L2 cache
> >          - Logic -> VDD_APC
> >          - Memory -> VDD_MX
> >      - CPU clock controller (logic) -> VDD_CX
> >        - Provides CPU frequency from different clock sources
> >        - L2 cache runs at 1/2 of CPU frequency
> >        => Both VDD_APC and VDD_MX must be scaled based on frequency
> >      - CPU PLL clock source
> >        - Generates the higher (GHz) CPU frequencies
> >        - Logic (?, unsure) -> VDD_CX
> >        - ??? -> VDD_SR2_APPS_PLL
> >        => VDD_CX must be scaled based on PLL frequency
> >
> > # Power Domains
> > ## VDD_APC
> >  - dedicated for CPU
> >  - powered off completely in deepest cluster cpuidle state
> >
> >  - per-core power switch (per-core cpuidle)
> >    - CPU logic
> >    - L1 cache controller/logic and maybe memory(?, unsure)
> >  - shared L2 cache controller/logic
> >
> >  => must be scaled based on CPU frequency
> >
> > ## VDD_MX
> >  - global SoC power domain for "on-chip memories"
> >  - always on, reduced to minimal voltage when entire SoC is idle
> >
> >  - power switch (controlled by deepest cluster cpuidle state?, unsure)
> >    - L2 cache memory
> >
> >  => must be scaled based on L2 frequency (=> 1/2 CPU frequency)
> >
> > ## VDD_CX
> >  - global SoC power domain for "digital logic"
> >  - always on, reduced to minimal voltage when entire SoC is idle
> >  - voting for VDD_CX in the RPM firmware also affects VDD_MX performance
> >    state (firmware implicitly sets VDD_MX >= VDD_CX)
> >
> >  - CPU clock controller logic, CPU PLL logic(?, unsure)
> >
> >  => must be scaled based on CPU PLL frequency
> >
> > ## VDD_SR2_APPS_PLL
> >  - global SoC power domain for CPU clock PLLs
> >  - on MSM8916: always on with constant voltage
> >
> >  => ignored in Linux at the moment
> >
> > # Power Domain Regulators
> > These power domains are literally input pins on the SoC chip. In theory
> > one could connect any suitable regulator to each of those. In practice
> > there are just a couple of standard reference designs that everyone
> > uses:
> >
> > ## MSM8916 (SoC) + PM8916 (PMIC)
> > We need to scale 3 power domains together with cpufreq:
> >
> >  - VDD_APC (CPU logic) = &pm8916_spmi_s2 (via CPR)
> >  - VDD_MX  (L2 memory) = &pm8916_l3 (via RPMPD: MSM8916_VDDMX)
> >  - VDD_CX  (CPU PLL)   = &pm8916_s1 (via RPMPD: MSM8916_VDDCX)
> >
> > ## MSM8909 (SoC) + PM8909 (PMIC)
> > We need to scale 1 power domain together with cpufreq:
> >
> >  - VDD_APC = VDD_CX    = &pm8909_s1 (via RPMPD: MSM8909_VDDCX)
> >    (CPU logic, L2 logic and CPU PLL)
> > (- VDD_MX  (L2 memory) = &pm8909_l3 (RPM firmware enforces VDD_MX >= VDD_CX))
> >
> > There is implicit magic in the RPM firmware here that saves us from
> > scaling VDD_MX. VDD_CX/APC are the same power rail.
> >
> > ## MSM8909 (SoC) + PM8916 (PMIC)
> > When MSM8909 is paired with PM8916 instead of PM8909, the setup is
> > identical to MSM8916+PM8916. We need to scale 3 power domains.
> >
> > > In a way it sounds like an option could be to hook up the cpr to the
> > > rpmpd:s instead (possibly even set it as a child-domains to the
> > > rpmpd:s), assuming that is a better description of the HW, which it
> > > may not be, of course.
> >
> > Hm. It's definitely an option. I must admit I haven't really looked
> > much at child-domains so far, so spontaneously I'm not sure about
> > the implications, for both the abstract hardware description and
> > the implementation.
> >
> > There seems to be indeed some kind of relation between MX <=> CX/APC:
> >
> >  - When voting for CX in the RPM firmware, it will always implicitly
> >    adjust the MX performance state to be MX >= CX.
> >
> >  - When scaling APC up, we must increase MX before APC.
> >  - When scaling APC down, we must decrease MX after APC.
> >  => Clearly MX >= APC. Not in terms of raw voltage, but at least for the
> >     abstract performance state.
> >
> > Is this some kind of parent-child relationship between MX <=> CX and
> > MX <=> APC?
> 
> Thanks for sharing the above. Yes, to me, it looks like there is a
> parent/child-domain relationship that could be worth describing/using.
> 
> >
> > If yes, maybe we could indeed bind MX to the CPR genpd somehow. They use
> > different performance state numbering, so we need some kind of
> > translation. I'm not entirely sure how that would be described.
> 
> Both the power-domain and the required-opps DT bindings
> (Documentation/devicetree/bindings/opp/opp-v2-base.yaml) are already
> allowing us to describe these kinds of hierarchical
> dependencies/layouts.
> 
> In other words, to scale performance for a child domain, the child may
> rely on that we scale performance for the parent domain too. This is
> already supported by genpd and through the opp library - so it should
> just work. :-)
> 

I'm getting back to the "multiple power domains" case of MSM8916 now, as
discussed above. I've tried modelling MX as parent genpd of CPR, to
avoid having to scale multiple power domains as part of cpufreq.

Basically, it looks like the following:

	cpr: power-controller@b018000 {
		compatible = "qcom,msm8916-cpr", "qcom,cpr";
		reg = <0x0b018000 0x1000>;
		/* ... */
		#power-domain-cells = <0>;
		operating-points-v2 = <&cpr_opp_table>;
		/* Supposed to be parent domain, not consumer */
		power-domains = <&rpmpd MSM8916_VDDMX_AO>;

		cpr_opp_table: opp-table {
			compatible = "operating-points-v2-qcom-level";

			cpr_opp1: opp1 {
				opp-level = <1>;
				qcom,opp-fuse-level = <1>;
				required-opps = <&rpmpd_opp_svs_soc>;
			};
			cpr_opp2: opp2 {
				opp-level = <2>;
				qcom,opp-fuse-level = <2>;
				required-opps = <&rpmpd_opp_nom>;
			};
			cpr_opp3: opp3 {
				opp-level = <3>;
				qcom,opp-fuse-level = <3>;
				required-opps = <&rpmpd_opp_super_turbo>;
			};
		};
	};

As already discussed [1] it's a bit annoying that the genpd core
attaches the power domain as consumer by default, but I work around this
by calling of_genpd_add_subdomain() followed by dev_pm_domain_detach()
in the CPR driver.

The actual scaling works fine, performance states of the MX power domain
are updated when CPR performance state. I added some debug prints and it
looks e.g. as follows (CPR is the power-controller@):

    [   24.498218] PM: mx_ao set performance state 6
    [   24.498788] PM: power-controller@b018000 set performance state 3
    [   24.511025] PM: mx_ao set performance state 3
    [   24.511526] PM: power-controller@b018000 set performance state 1
    [   24.521189] PM: mx_ao set performance state 4
    [   24.521660] PM: power-controller@b018000 set performance state 2
    [   24.533183] PM: mx_ao set performance state 6
    [   24.533535] PM: power-controller@b018000 set performance state 3

There is one remaining problem here: Consider e.g. the switch from CPR
performance state 3 -> 1. In both cases the parent genpd state is set
*before* the child genpd. When scaling down, the parent genpd state must
be reduced *after* the child genpd. Otherwise, we can't guarantee that
the parent genpd state is always >= of the child state.

In the OPP core, the order of such operations is always chosen based on
whether we are scaling up or down. When scaling up, power domain states
are set before the frequency is changed, and the other way around for
scaling down.

Is this something you could imagine changing in the GENPD core, either
unconditionally for everyone, or as an option?

I tried to hack this in for a quick test and came up with the following
(the diff is unreadable so I'll just post the entire changed
(_genpd_set_performance_state() function). Admittedly it's a bit ugly.

With these changes the sequence from above looks more like:

    [   22.374555] PM: mx_ao set performance state 6
    [   22.375175] PM: power-controller@b018000 set performance state 3
    [   22.424661] PM: power-controller@b018000 set performance state 1
    [   22.425169] PM: mx_ao set performance state 3
    [   22.434932] PM: mx_ao set performance state 4
    [   22.435331] PM: power-controller@b018000 set performance state 2
    [   22.461197] PM: mx_ao set performance state 6
    [   22.461968] PM: power-controller@b018000 set performance state 3

Which is correct now.

Let me know if you have any thoughts about this. :-)

Thanks for taking the time to discuss this!
Stephan

[1]: https://lore.kernel.org/linux-pm/CAPDyKFq+zsoeF-4h5TfT4Z+S46a501_pUq8y2c1x==Tt6EKBGA@mail.gmail.com/

static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
					unsigned int state, int depth);

static void _genpd_rollback_parent_state(struct gpd_link *link, int depth)
{
	struct generic_pm_domain *parent = link->parent;
	int parent_state;

	genpd_lock_nested(parent, depth + 1);

	parent_state = link->prev_performance_state;
	link->performance_state = parent_state;

	parent_state = _genpd_reeval_performance_state(parent, parent_state);
	if (_genpd_set_performance_state(parent, parent_state, depth + 1)) {
		pr_err("%s: Failed to roll back to %d performance state\n",
		       parent->name, parent_state);
	}

	genpd_unlock(parent);
}

static int _genpd_set_parent_state(struct generic_pm_domain *genpd,
				   struct gpd_link *link,
				   unsigned int state, int depth)
{
	struct generic_pm_domain *parent = link->parent;
	int parent_state, ret;

	/* Find parent's performance state */
	ret = genpd_xlate_performance_state(genpd, parent, state);
	if (unlikely(ret < 0))
		return ret;

	parent_state = ret;

	genpd_lock_nested(parent, depth + 1);

	link->prev_performance_state = link->performance_state;
	link->performance_state = parent_state;
	parent_state = _genpd_reeval_performance_state(parent,
						parent_state);
	ret = _genpd_set_performance_state(parent, parent_state, depth + 1);
	if (ret)
		link->performance_state = link->prev_performance_state;

	genpd_unlock(parent);

	return ret;
}

static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
					unsigned int state, int depth)
{
	struct gpd_link *link = NULL;
	int ret;

	if (state == genpd->performance_state)
		return 0;

	/* When scaling up, propagate to parents first in normal order */
	if (state > genpd->performance_state) {
		list_for_each_entry(link, &genpd->child_links, child_node) {
			ret = _genpd_set_parent_state(genpd, link, state, depth);
			if (ret)
				goto rollback_parents_up;
		}
	}

	if (genpd->set_performance_state) {
		pr_err("%s set performance state %d\n", genpd->name, state);
		ret = genpd->set_performance_state(genpd, state);
		if (ret) {
			if (link)
				goto rollback_parents_up;
			return ret;
		}
	}

	/* When scaling down, propagate to parents after in reverse order */
	if (state < genpd->performance_state) {
		list_for_each_entry_reverse(link, &genpd->child_links, child_node) {
			ret = _genpd_set_parent_state(genpd, link, state, depth);
			if (ret)
				goto rollback_parents_down;
		}
	}

	genpd->performance_state = state;
	return 0;

rollback_parents_up:
	list_for_each_entry_continue_reverse(link, &genpd->child_links, child_node)
		_genpd_rollback_parent_state(link, depth);
	return ret;
rollback_parents_down:
	list_for_each_entry_continue(link, &genpd->child_links, child_node)
		_genpd_rollback_parent_state(link, depth);
	return ret;
}

