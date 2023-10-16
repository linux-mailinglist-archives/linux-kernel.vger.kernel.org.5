Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019357CAC02
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjJPOsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjJPOsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:48:33 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B462EB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 07:48:30 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a2536adaf3so62516327b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 07:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697467710; x=1698072510; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GxypX+GEfUXKbSOzwP0/C/E3Z4J92Eo/3dLzh/Ra8sE=;
        b=MDcKJvjoXcB8n0XH+nX/HCQCvKEIcbKdUTyyPGZPqWQYYWTu7wkVAU2/7pEPcqs3Nc
         KvqnTXDtFs+UnWTNce8o1MU6XVPrs1QvyhJ/T2yttZwblBLVXgce3l0RSeWmlM3d4lRm
         jyUle3M7pw8GXjpZTJQWRIJ6FZx95OPf3kYCrbNM92KeZQOAM3zhlwBUuHJFAJOh+/sr
         jT7uA9ZxTVP8Jm03/XqJr7X6H0hOu6WkpTOTfh429GbPI/qMaJCsO0M/sSbVBbZBts8l
         G8pnLnpPP/7nrxWqPZwxEIWq5jmiM7UBK6ZEdmnfWP3dCBjVX1uKvqiD2vJ78FRffZrS
         UKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697467710; x=1698072510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxypX+GEfUXKbSOzwP0/C/E3Z4J92Eo/3dLzh/Ra8sE=;
        b=eX9wn6dx7OIzlAP1htSX1qcpx40NurnYVqg0TYStOqvgx0mnOEyQ2KNzz9kNGQxIpm
         lgB2lEQz0rXXy10JPHkJE0nI3D2LRtLPsPSX4aXpuJMfMr2U70ZQp/pJBCw9iSZk0ING
         7/6B8Ln0E26j0FA0ormLa/wvsiD5Pbdgqa7tT3dCKlL8rhjKX1RV0a07Sj1tc6xCnr6T
         JZ3VW+KgAV9Z3qhXJJvxmfpvrVf7xTiJ08yE01o57D81DIoq5E/mW7DXY6Uq6PHJGusb
         2MR8qrLkQk3HMBNl8bv8Qr81WLBh31ItiFso8QUf55RFsLqt07CSielkiIhicWhDy//z
         +yXA==
X-Gm-Message-State: AOJu0YyCCm5Rnk174BMTT+buylObede0Vqc2u7TlCbOAeF2vEfxpjhX+
        enrttnIbKBldjF5dwUqtwnbPF7cRPZn/QhVbML9dtg==
X-Google-Smtp-Source: AGHT+IFydC4JiwFHumykEit+4bc15qpX+YfvV1l4iiaVG8PNsPGn4dovyuswKlpyIeP4zBTlngKF3aJXGed59EMhMvI=
X-Received: by 2002:a25:2d15:0:b0:d9a:c4df:cd8e with SMTP id
 t21-20020a252d15000000b00d9ac4dfcd8emr10401524ybt.33.1697467709642; Mon, 16
 Oct 2023 07:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230912-msm8909-cpufreq-v1-0-767ce66b544b@kernkonzept.com>
 <20230912-msm8909-cpufreq-v1-1-767ce66b544b@kernkonzept.com>
 <CAPDyKFq6U-MR4Bd+GmixYseRECDh142RhydtKbiPd3NHV2g6aw@mail.gmail.com>
 <ZQGqfMigCFZP_HLA@gerhold.net> <CAPDyKFppdXe1AZo1jm2Bc_ZR18hw5Bmh1x+2P7Obhb_rJ2gc4Q@mail.gmail.com>
 <ZRcC2IRRv6dtKY65@gerhold.net> <CAPDyKFoiup8KNv=1LFGKDdDLA1pHsdJUgTTWMdgxnikEmReXzg@mail.gmail.com>
 <ZSg-XtwMxg3_fWxc@gerhold.net>
In-Reply-To: <ZSg-XtwMxg3_fWxc@gerhold.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Oct 2023 16:47:52 +0200
Message-ID: <CAPDyKFoH5EOvRRKy-Bgp_B9B3rf=PUKK5N45s5PNgfBi55PaOQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > >
> > > Here are the two commits with the my current DT changes (WIP):
> > >   - MSM8909+PM8909 (RPMPD only):
> > >     https://github.com/msm8916-mainline/linux/commit/791e0c5a3162372a0738bc7b0f4a5e87247923db
> >
> > Okay, so this looks pretty straight forward. One thing though, it
> > looks like we need to update the DT bindings for cpus.
> >
> > I recently updated Documentation/devicetree/bindings/arm/cpus.yaml
> > [1], to let "perf" be the common "power-domain-name" for a CPU's SCMI
> > performance-domain. I look like we should extend the description to
> > allow "perf" to be used for all types of performance domains.
> >
>
> "perf" sounds fine for a single power domain, I just used "apc" here for
> consistency with the MSM8916 changes (which scales this power domain and
> several others, as you saw).
>
> (BTW, I would appreciate such a generic name for the cpuidle case as
>  well, so "idle" instead of "psci" vs "sbi". I have another WIP cpuidle
>  driver and didn't want to invent another name there...)

Whether it's "idle" or "power" or something else, we should certainly
avoid a provider specific (psci) name, as has been pointed out earlier
by Rob too.

I will try to get some time to update the DT docs as soon as I can.
Unless you get to it first, feel free to do it.

>
> > >   - MSM8916 (CPR+RPMPD):
> > >     https://github.com/msm8916-mainline/linux/commit/8880f39108206d7a60a0a8351c0373bddf58657c
> >
> > This looks a bit odd to me. Does a CPU really have four different
> > power-domains, where three of them are performance-domains?
> >
>
> Good question. I think we're largely entering "uncharted territory" with
> these questions, I can just try to answer it the best I can from the
> limited documentation and knowledge I have. :)
>
> The CPU does indeed use four different power domains. There also seem to
> be additional power switches that gate power for some components without
> having to turn off the entire supply.
>
> I'll list them twice from two points of view: Once mapping component ->
> power domain, then again showing each power domain separately to make it
> more clear. At the end I also want to make clear that MSM8909 (with the
> "single" power domain) is actually exactly the same SoC design, just
> with different regulators supplying the power domains.
>
> It's totally fine if you just skim over it. I'm listing it in detail
> also as reference for myself. :D
>
> # Components
>  - SoC
>    - CPU subsystem ("APPS")
>      - CPU cluster
>        - 4x CPU core (logic and L1 cache) -> VDD_APC
>        - Shared L2 cache
>          - Logic -> VDD_APC
>          - Memory -> VDD_MX
>      - CPU clock controller (logic) -> VDD_CX
>        - Provides CPU frequency from different clock sources
>        - L2 cache runs at 1/2 of CPU frequency
>        => Both VDD_APC and VDD_MX must be scaled based on frequency
>      - CPU PLL clock source
>        - Generates the higher (GHz) CPU frequencies
>        - Logic (?, unsure) -> VDD_CX
>        - ??? -> VDD_SR2_APPS_PLL
>        => VDD_CX must be scaled based on PLL frequency
>
> # Power Domains
> ## VDD_APC
>  - dedicated for CPU
>  - powered off completely in deepest cluster cpuidle state
>
>  - per-core power switch (per-core cpuidle)
>    - CPU logic
>    - L1 cache controller/logic and maybe memory(?, unsure)
>  - shared L2 cache controller/logic
>
>  => must be scaled based on CPU frequency
>
> ## VDD_MX
>  - global SoC power domain for "on-chip memories"
>  - always on, reduced to minimal voltage when entire SoC is idle
>
>  - power switch (controlled by deepest cluster cpuidle state?, unsure)
>    - L2 cache memory
>
>  => must be scaled based on L2 frequency (=> 1/2 CPU frequency)
>
> ## VDD_CX
>  - global SoC power domain for "digital logic"
>  - always on, reduced to minimal voltage when entire SoC is idle
>  - voting for VDD_CX in the RPM firmware also affects VDD_MX performance
>    state (firmware implicitly sets VDD_MX >= VDD_CX)
>
>  - CPU clock controller logic, CPU PLL logic(?, unsure)
>
>  => must be scaled based on CPU PLL frequency
>
> ## VDD_SR2_APPS_PLL
>  - global SoC power domain for CPU clock PLLs
>  - on MSM8916: always on with constant voltage
>
>  => ignored in Linux at the moment
>
> # Power Domain Regulators
> These power domains are literally input pins on the SoC chip. In theory
> one could connect any suitable regulator to each of those. In practice
> there are just a couple of standard reference designs that everyone
> uses:
>
> ## MSM8916 (SoC) + PM8916 (PMIC)
> We need to scale 3 power domains together with cpufreq:
>
>  - VDD_APC (CPU logic) = &pm8916_spmi_s2 (via CPR)
>  - VDD_MX  (L2 memory) = &pm8916_l3 (via RPMPD: MSM8916_VDDMX)
>  - VDD_CX  (CPU PLL)   = &pm8916_s1 (via RPMPD: MSM8916_VDDCX)
>
> ## MSM8909 (SoC) + PM8909 (PMIC)
> We need to scale 1 power domain together with cpufreq:
>
>  - VDD_APC = VDD_CX    = &pm8909_s1 (via RPMPD: MSM8909_VDDCX)
>    (CPU logic, L2 logic and CPU PLL)
> (- VDD_MX  (L2 memory) = &pm8909_l3 (RPM firmware enforces VDD_MX >= VDD_CX))
>
> There is implicit magic in the RPM firmware here that saves us from
> scaling VDD_MX. VDD_CX/APC are the same power rail.
>
> ## MSM8909 (SoC) + PM8916 (PMIC)
> When MSM8909 is paired with PM8916 instead of PM8909, the setup is
> identical to MSM8916+PM8916. We need to scale 3 power domains.
>
> > In a way it sounds like an option could be to hook up the cpr to the
> > rpmpd:s instead (possibly even set it as a child-domains to the
> > rpmpd:s), assuming that is a better description of the HW, which it
> > may not be, of course.
>
> Hm. It's definitely an option. I must admit I haven't really looked
> much at child-domains so far, so spontaneously I'm not sure about
> the implications, for both the abstract hardware description and
> the implementation.
>
> There seems to be indeed some kind of relation between MX <=> CX/APC:
>
>  - When voting for CX in the RPM firmware, it will always implicitly
>    adjust the MX performance state to be MX >= CX.
>
>  - When scaling APC up, we must increase MX before APC.
>  - When scaling APC down, we must decrease MX after APC.
>  => Clearly MX >= APC. Not in terms of raw voltage, but at least for the
>     abstract performance state.
>
> Is this some kind of parent-child relationship between MX <=> CX and
> MX <=> APC?

Thanks for sharing the above. Yes, to me, it looks like there is a
parent/child-domain relationship that could be worth describing/using.

>
> If yes, maybe we could indeed bind MX to the CPR genpd somehow. They use
> different performance state numbering, so we need some kind of
> translation. I'm not entirely sure how that would be described.

Both the power-domain and the required-opps DT bindings
(Documentation/devicetree/bindings/opp/opp-v2-base.yaml) are already
allowing us to describe these kinds of hierarchical
dependencies/layouts.

In other words, to scale performance for a child domain, the child may
rely on that we scale performance for the parent domain too. This is
already supported by genpd and through the opp library - so it should
just work. :-)

>
> Scaling VDD_CX for the PLL is more complicated. APC <=> CX feel more
> like siblings, so I don't think it makes sense to vote for CX as part of
> the CPR genpd. Spontaneously I would argue scaling CX belongs into the
> CPU PLL driver (since that's what the vote is for). However, for some
> reason it was decided to handle such votes on the consumer side (here =
> cpufreq) on mainline [1].
>
> [1]: https://lore.kernel.org/linux-arm-msm/20200910162610.GA7008@gerhold.net/

Right. I assume the above works just fine, so probably best to stick
to that for this case too.

[...]

> >
> > *) The approach you have taken in the $subject patch with the call to
> > pm_runtime_resume_and_get() works as a fix for QCS404, as there is
> > only the CPR to attach to. The problem with it, is that it doesn't
> > work for cases where the RPMPD is used for performance scaling, either
> > separate or in combination with the CPR. It would keep the rpmpd:s
> > powered-on, which would be wrong. In regards to the
> > dev_pm_syscore_device() thingy, this should not be needed, as long as
> > we keep the vdd-apc-supply enabled, right?
> >
> > **) A more generic solution, that would work for all cases (even
> > when/if hooking up the CPR to the rpmpd:s), consists of tweaking genpd
> > to avoid "caching" performance states for these kinds of devices. And
> > again, I don't see that we need dev_pm_syscore_device(), assuming we
> > manage the vdd-apc-supply correctly.
> >
> > Did I miss anything?
> >
>
> We do need to keep the CPU-related RPMPDs always-on too.
>
> Keeping the CPU-related RPMPDs always-on is a bit counter-intuitive, but
> it's because of this:
>
> > > > >  - RPMPD: This is the generic driver for all the SoC power domains
> > > > >    managed by the RPM firmware. It's not CPU-specific. However, as
> > > > >    special feature each power domain is exposed twice in Linux, e.g.
> > > > >    "MSM8909_VDDCX" and "MSM8909_VDDCX_AO". The _AO ("active-only")
> > > > >    variant tells the RPM firmware that the performance/enable vote only
> > > > >    applies when the CPU is active (not in deep cpuidle state).
>
> The CPU only uses the "_AO"/active-only variants in RPMPD. Keeping these
> always-on effectively means "keep the power domain on as long as the CPU
> is active".
>
> I hope that clears up some of the confusion. :)

Yes, it does, thanks! Is the below the correct conclusion for how we
could move forward then?

*) The pm_runtime_resume_and_get() works for QCS404 as a fix. It also
works fine when there is only one RPMPD that manages the performance
scaling.

**) In cases where we have multiple PM domains to scale performance
for, using pm_runtime_resume_and_get() would work fine too. Possibly
we want to use device_link_add() to set up suppliers, to avoid calling
pm_runtime_resume_and_get() for each and every device.

***) Due to the above, we don't need a new mechanism to avoid
"caching" performance states for genpd. At least for the time being.

Kind regards
Uffe
