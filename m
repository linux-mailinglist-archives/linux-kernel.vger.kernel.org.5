Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5787CCECD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343908AbjJQUyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjJQUyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:54:13 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DDD92;
        Tue, 17 Oct 2023 13:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1697576047; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KAdHQ5f5dnpSzMaJeFOJrirDMTXeZ3w3mXDeTbOlUxtEbmV6h09rIUC4xiX6FaY27Q
    SthuMuFVpLt8FXYZshAEnX1N9D4P5TYgJX4ApXTVxLNnkCNP9SQbMmDfOMTrFa3heQ8z
    hj3bo+dr8/4eNMw9/QumBaGqqRWZEc3lad5ke8QLqs9x/6sCFoX8WvzxTORcBQcQruMv
    RgMXXR2/hN7trAuIx0rhan9ffKLJqf22g+K0ObeplqpCNTs/WOcP3tJeBO8QB5/47eJX
    yWCTlIrtyxlPG66olJIYaA8SH1qaXGQ5jurazWeG7Tp+DU/EIdhJ+CBN1je4fNDCmaEn
    5vsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1697576047;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4JlDr7zKR8MBrZdwPJEuuTOPV5Uy20E9QavT7xqZqsI=;
    b=pNhZNpd/gL3cqfe09e9GaPVhGnl/P7LMeD8V78Ahjz9zhHJN3ABKv1ci0LxStia8jO
    2iZjzqIYM7OrrM5dNpobxUsRIacFcv8tQ0XypWnohtAnGzwQIKtT3hBXNobcDo5ONWP/
    dRzWFjTcAid9x8SfeK4ZWlNdREaUbFIsl9ZI475zDB9jZD4CThrrsSXYukIdQIw7O69p
    rTupeD3GnuAa12tnfO2MtGRaB4zElFG3mXXQrmcXxlZ6+GnHKfhHIjXbjIbt9p8NTaxt
    k9QVtj7AZa5YE0vKy0qc2o08UQRIy+nrODJhHtN8u7qR9v8O/NO/lz/l3/if4ESTU4r4
    ZTXQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1697576047;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4JlDr7zKR8MBrZdwPJEuuTOPV5Uy20E9QavT7xqZqsI=;
    b=aw8C9ILt/0v7DBZnWM9fWgvUq2ViKa5PL+468owtC49IaqslCZS8K1SlZdi3IeWyBA
    qlJDQIuFbYqPkQ2IdHCXv4QnfiJGDZx0yLcdxwSjFksrEScWYnXYXk7Rsr8sYWpcK7t9
    iavQSZozH6BY+1zmV3Q/MhxrDRQ4e3eWB2hSXL6zPBVCdf/hzwzJKDBCfkg29RgKTV+J
    X5daBKuV3xAKlisM82YgWVpThygaspARETK+t7/lGFKl0HBoBNzqyf7VR3abTvnFAxVn
    EQsuj1kEqSVqVETAiu1ROKNkcrkx4sR5ZhVZBrucvqUM3uDrvSAe0rkkcvLZDX0B/QeM
    yEUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1697576047;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4JlDr7zKR8MBrZdwPJEuuTOPV5Uy20E9QavT7xqZqsI=;
    b=EVy7Ai4v54ojE55/6MVFJMUcy23BNv+6vqGvstuU2OTxzSPNCaMN7q09/D0yCzQsp2
    X5X1om0G18Swc2B9ldBA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA+p3h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.9.0 DYNA|AUTH)
    with ESMTPSA id j34a49z9HKs66tQ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 17 Oct 2023 22:54:06 +0200 (CEST)
Date:   Tue, 17 Oct 2023 22:54:01 +0200
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
Message-ID: <ZS70aZbP33fkf9dP@gerhold.net>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 04:47:52PM +0200, Ulf Hansson wrote:
> [...]
> > > >
> > > > Here are the two commits with the my current DT changes (WIP):
> > > >   - MSM8909+PM8909 (RPMPD only):
> > > >     https://github.com/msm8916-mainline/linux/commit/791e0c5a3162372a0738bc7b0f4a5e87247923db
> > >
> > > Okay, so this looks pretty straight forward. One thing though, it
> > > looks like we need to update the DT bindings for cpus.
> > >
> > > I recently updated Documentation/devicetree/bindings/arm/cpus.yaml
> > > [1], to let "perf" be the common "power-domain-name" for a CPU's SCMI
> > > performance-domain. I look like we should extend the description to
> > > allow "perf" to be used for all types of performance domains.
> > >
> >
> > "perf" sounds fine for a single power domain, I just used "apc" here for
> > consistency with the MSM8916 changes (which scales this power domain and
> > several others, as you saw).
> >
> > (BTW, I would appreciate such a generic name for the cpuidle case as
> >  well, so "idle" instead of "psci" vs "sbi". I have another WIP cpuidle
> >  driver and didn't want to invent another name there...)
> 
> Whether it's "idle" or "power" or something else, we should certainly
> avoid a provider specific (psci) name, as has been pointed out earlier
> by Rob too.
> 
> I will try to get some time to update the DT docs as soon as I can.
> Unless you get to it first, feel free to do it.
> 

Thanks! I'm not sure either when I will have time to get back to the
cpuidle driver, so let's just see who finds time first. :D

> > [MSM8916 setup with multiple power domains...]
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

Oh! I have looked at that code in the genpd core already a few times but
until now I never understood how it works. That's great, thanks!

I will test this and get back to you separately.

Seems like we reached a conclusion for enabling the power domains at
least, which will already help me a lot with MSM8909. :-)

> [...]
> 
> > >
> > > *) The approach you have taken in the $subject patch with the call to
> > > pm_runtime_resume_and_get() works as a fix for QCS404, as there is
> > > only the CPR to attach to. The problem with it, is that it doesn't
> > > work for cases where the RPMPD is used for performance scaling, either
> > > separate or in combination with the CPR. It would keep the rpmpd:s
> > > powered-on, which would be wrong. In regards to the
> > > dev_pm_syscore_device() thingy, this should not be needed, as long as
> > > we keep the vdd-apc-supply enabled, right?
> > >
> > > **) A more generic solution, that would work for all cases (even
> > > when/if hooking up the CPR to the rpmpd:s), consists of tweaking genpd
> > > to avoid "caching" performance states for these kinds of devices. And
> > > again, I don't see that we need dev_pm_syscore_device(), assuming we
> > > manage the vdd-apc-supply correctly.
> > >
> > > Did I miss anything?
> > >
> >
> > We do need to keep the CPU-related RPMPDs always-on too.
> >
> > Keeping the CPU-related RPMPDs always-on is a bit counter-intuitive, but
> > it's because of this:
> >
> > > > > >  - RPMPD: This is the generic driver for all the SoC power domains
> > > > > >    managed by the RPM firmware. It's not CPU-specific. However, as
> > > > > >    special feature each power domain is exposed twice in Linux, e.g.
> > > > > >    "MSM8909_VDDCX" and "MSM8909_VDDCX_AO". The _AO ("active-only")
> > > > > >    variant tells the RPM firmware that the performance/enable vote only
> > > > > >    applies when the CPU is active (not in deep cpuidle state).
> >
> > The CPU only uses the "_AO"/active-only variants in RPMPD. Keeping these
> > always-on effectively means "keep the power domain on as long as the CPU
> > is active".
> >
> > I hope that clears up some of the confusion. :)
> 
> Yes, it does, thanks! Is the below the correct conclusion for how we
> could move forward then?
> 
> *) The pm_runtime_resume_and_get() works for QCS404 as a fix. It also
> works fine when there is only one RPMPD that manages the performance
> scaling.
> 

Agreed.

> **) In cases where we have multiple PM domains to scale performance
> for, using pm_runtime_resume_and_get() would work fine too. Possibly
> we want to use device_link_add() to set up suppliers, to avoid calling
> pm_runtime_resume_and_get() for each and every device.
> 

Hm. What would you use as "supplied" device? The CPU device I guess?

I'm looking again at my old patch from 2020 where I implemented this
with device links in the OPP core. Seems like you suggested this back
then too :)

  https://lore.kernel.org/linux-pm/20200826093328.88268-1-stephan@gerhold.net/

However, for the special case of the CPU I think we don't gain any code
simplification from using device links. There will just be a single
resume of each virtual genpd device, as well as one put during remove().
Exactly the same applies when using device links, we need to set up the
device links once for each virtual genpd device, and clean them up again
during remove().

Or can you think of another advantage of using device links?

> ***) Due to the above, we don't need a new mechanism to avoid
> "caching" performance states for genpd. At least for the time being.
> 

Right. Given *) and **) I'll prepare a v2 of $subject patch with the
remove() cleanup fixed and an improved commit description.

I'll wait for a bit in case you have more thoughts about the device
links.

Thanks!
Stephan
