Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6F57CFD36
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346222AbjJSOtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346280AbjJSOs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:48:59 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFE3114;
        Thu, 19 Oct 2023 07:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1697726933; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FN9OpOocMTgJiz/Lo2ho4Xcff50OoGOqTC7RCDLu72EqgEE6ydz69eINTOF4f0Vz3j
    vpQJjVlF61TJGlPtJ0XKlfsJQuAtm5jgalVPUDdgKfjCXwlmn8/2UxFeJ/kFlyPeFmya
    6zMdcCq71+jlg7PPS4mpYaPhaAOKQpf5NoHiou8NyJT5JU5u5rK/qWsZSca62zt9xDdC
    9z9PLmxU/AJ73z7WrQfIP/DmggOcLLo1xJeGb5zgWGhfr1nhno0VZ3L1MZmxDNikd0Wj
    vu1PAtGgj958vIdDlXxUb5iYfZF+XHYa0oLCKgVIRh0mrNB16XWMshIACGv+1n8xLYQU
    6Sxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1697726933;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=7cuD1QOpe7Y7Z0gNct5qHlFiCYXpc9cJzhz/dPK12RM=;
    b=OPpaKVeoThjHhKC+6IqWZrlOs47B/afs9wb4Jvby3nQp/ieIVpZUqwV27Ghd399HqS
    LSgmEqnY9JwQuMuY54NXE25i1sUp51FQ2vB59wzt6wE5TCbS+vQzUVKtg++8crHIN10V
    VOtwocuafExzdj0VVxI4H5BXhzrE9efMD5bw9o47a3rJrgoHLct3VGNAobYBnly9O+VZ
    5m5yYJsiBNP4jdP6uafPiqls7tOtEzmqHZU1ZhlwcMzbnfGy6akP8VJCyFhBsnJnj7Qt
    JmvYTV8FKezobhP0E1A+H+MQFi/S7LuT+IVv20jlimIRHXAWJXRm+e4RliFKKuk4rSOd
    cWxg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1697726933;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=7cuD1QOpe7Y7Z0gNct5qHlFiCYXpc9cJzhz/dPK12RM=;
    b=bzAmkUvDoHIXo9AIg0D+wMfnSEqg4e0qRra25EbaRbwGzYg0tHQf28A3Hrv1VBDCcL
    9RmeUP32UNKDJQ6JDm31RKosW0EKULpH3gHebNCA5/SNvySgGNrr6uZ1PXiYEXVSxaFh
    mrNHVSox/F6m45uWQU5HmOmhcAUEzRXRxhBKLDRgZw+EbD6hgptbBeQ4mU0/xc0ArVO2
    gMNSjJVn60GnB/b808iXQ7m41PxrHSykqm+joQkVMw7a1Veut7hMMvNKOyDwh8MP5Won
    NVmeCki+AwrAMJyuUF7EIJTJ/MVcGw1DVSM0svLbJOPsmDZMZwwa1V/9gVU4zq5pf2fN
    Xb+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1697726932;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=7cuD1QOpe7Y7Z0gNct5qHlFiCYXpc9cJzhz/dPK12RM=;
    b=gXO+qnKOAFEgRc8tWyDjUEoMxLBLb7JyEEV4vg+xVNH0qKV1OamKOPV2AeH3Ls9Vvp
    EXhnGmv4A7f8wSG4tdDQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA95vh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.9.0 DYNA|AUTH)
    with ESMTPSA id j34a49z9JEmqE5Z
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 19 Oct 2023 16:48:52 +0200 (CEST)
Date:   Thu, 19 Oct 2023 16:48:46 +0200
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
Subject: Re: [PATCH v2 2/3] cpufreq: qcom-nvmem: Enable virtual power domain
 devices
Message-ID: <ZTFBzjLAaaUHux4O@gerhold.net>
References: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
 <20231018-msm8909-cpufreq-v2-2-0962df95f654@kernkonzept.com>
 <CAPDyKFot9=M1ooP_Q1AOgG5o_4DTQ2qsyai1ZdXAzBwf89W4uA@mail.gmail.com>
 <CAPDyKFr5A-P=UhWs4rUMBWup3pH75WAhcZ56Y2_Sfk3=WfxRCQ@mail.gmail.com>
 <ZTEph19CAvbgbN_E@gerhold.net>
 <CAPDyKFo1PVZYsdW_=92EtMmTT9hmkm-mBR69N_WvPh4f-Hw=NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFo1PVZYsdW_=92EtMmTT9hmkm-mBR69N_WvPh4f-Hw=NA@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 04:12:56PM +0200, Ulf Hansson wrote:
> On Thu, 19 Oct 2023 at 15:05, Stephan Gerhold <stephan@gerhold.net> wrote:
> > On Thu, Oct 19, 2023 at 01:26:19PM +0200, Ulf Hansson wrote:
> > > On Thu, 19 Oct 2023 at 12:24, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > On Wed, 18 Oct 2023 at 10:06, Stephan Gerhold
> > > > <stephan.gerhold@kernkonzept.com> wrote:
> > > > >
> > > > > The genpd core caches performance state votes from devices that are
> > > > > runtime suspended as of commit 3c5a272202c2 ("PM: domains: Improve
> > > > > runtime PM performance state handling"). They get applied once the
> > > > > device becomes active again.
> > > > >
> > > > > To attach the power domains needed by qcom-cpufreq-nvmem the OPP core
> > > > > calls genpd_dev_pm_attach_by_id(). This results in "virtual" dummy
> > > > > devices that use runtime PM only to control the enable and performance
> > > > > state for the attached power domain.
> > > > >
> > > > > However, at the moment nothing ever resumes the virtual devices created
> > > > > for qcom-cpufreq-nvmem. They remain permanently runtime suspended. This
> > > > > means that performance state votes made during cpufreq scaling get
> > > > > always cached and never applied to the hardware.
> > > > >
> > > > > Fix this by enabling the devices after attaching them and use
> > > > > dev_pm_syscore_device() to ensure the power domains also stay on when
> > > > > going to suspend. Since it supplies the CPU we can never turn it off
> > > > > from Linux. There are other mechanisms to turn it off when needed,
> > > > > usually in the RPM firmware (RPMPD) or the cpuidle path (CPR genpd).
> > > >
> > > > I believe we discussed using dev_pm_syscore_device() for the previous
> > > > version. It's not intended to be used for things like the above.
> > > >
> >
> > Sorry, looks like we still had a misunderstanding in the conclusion of
> > the previous discussion. :')
> >
> > > > Moreover, I was under the impression that it wasn't really needed. In
> > > > fact, I would think that this actually breaks things for system
> > > > suspend/resume, as in this case the cpr driver's genpd
> > > > ->power_on|off() callbacks are no longer getting called due this,
> > > > which means that the cpr state machine isn't going to be restored
> > > > properly. Or did I get this wrong?
> > >
> >
> > We strictly need the RPMPDs to be always-on, also across system suspend
> > [1]. The RPM firmware will drop the votes internally as soon as the
> > CPU(s) have entered deep cpuidle. We can't do this from Linux, because
> > we need the CPU to continue running until it was shut down cleanly.
> >
> > For CPR, we strictly need the backing regulator to be always-on, also
> > across system suspend. Typically the hardware will turn off the
> > regulator as soon as the CPU(s) enter deep cpuidle. Similarly, we can't
> > do this from Linux, because we need the CPU to continue running until it
> > was shut down cleanly.
> >
> > My understanding was that we're going to pause the CPR state machine
> > using the system suspend/resume callbacks on the driver, instead of
> > using the genpd->power_on|off() callbacks [2]. I can submit a separate
> > patch for this.
> 
> If we are going to do 1) as described below, this looks to me that
> it's going to be needed.
> 

Yep.

> How will otherwise the cpr state machine be saved/restored during
> system suspend/resume? Note that, beyond 1), the genpd's
> ->power_on|off() callbacks are no longer going to be called during
> system suspend/resume.
> 

(Side note: I think "save/restore" might be the wrong words for
 suspend/resume of CPR. Looking at the code most of the configuration
 appears to be preserved across suspend/resume. Nothing is saved, it
 literally just disables the state machine during suspend and re-enables
 it during resume.

 I'm not entirely sure what's the reason for doing this. Perhaps the
 main goal is just to prevent the CPR state machine from getting stuck
 or sending pointless IRQs that won't be handled while Linux is
 suspended.)

> In a way this also means that the cpr genpd provider might as well
> also have GENPD_FLAG_ALWAYS_ON set for it.

Conceptually I would consider CPR to be a generic power domain provider
that could supply any kind of device. I know at least of CPUs and GPUs.
We need "always-on" only for the CPU, but not necessarily for other
devices.

For a GPU, the Linux driver (running on the CPU) can stop the GPU, wait
for completion and then invoke the ->power_off() callback of CPR. In
that case it is also safe to disable the backing regulator from Linux.
(I briefly mentioned this already in the previous discussion I think.)

We could set GENPD_FLAG_ALWAYS_ON for the CPR compatibles where we know
that they are only used to supply CPUs, but if we're going to do (1)
anyway there might not be much of an advantage for the extra complexity.

> 
> >
> > I didn't prioritize this because QCS404 (as the only current user of
> > CPR) doesn't have proper deep cpuidle/power management set up yet. It's
> > not entirely clear to me if there is any advantage (or perhaps even
> > disadvantage) if we pause the CPR state machine while the shared L2
> > cache is still being actively powered by the CPR power rail during
> > system suspend. I suspect this is a configuration that was never
> > considered in the hardware design.
> 
> I see.
> 
> >
> > Given the strict requirement for the RPMPDs, I only see two options:
> >
> >  1. Have an always-on consumer that prevents the power domains to be
> >     powered off during system suspend. This is what this patch tries to
> >     achieve.
> >
> > Or:
> >
> >  2. Come up with a way to register the RPMPDs used by the CPU with
> >     GENPD_FLAG_ALWAYS_ON. This would also be doable, but isn't as
> >     straightfoward as "regulator-always-on" in the DT because the rpmpd
> >     DT node represents multiple genpds in a single DT node [3].
> 
> Yes, it sounds like it may be easier to do 1).
> 
> >
> > What do you think? Do you see some other solution perhaps? I hope we can
> > clear up the misunderstanding. :-)
> 
> Yes, thanks!
> 
> >
> > [1]: https://lore.kernel.org/linux-arm-msm/ZQGqfMigCFZP_HLA@gerhold.net/
> > [2]: https://lore.kernel.org/linux-arm-msm/CAPDyKFoiup8KNv=1LFGKDdDLA1pHsdJUgTTWMdgxnikEmReXzg@mail.gmail.com/
> > [3]: https://lore.kernel.org/linux-arm-msm/ZSg-XtwMxg3_fWxc@gerhold.net/
> >
> > > BTW, if you really need something like the above, the proper way to do
> > > it would instead be to call device_set_awake_path() for the device.
> > >
> > > This informs genpd that the device needs to stay powered-on during
> > > system suspend (assuming that GENPD_FLAG_ACTIVE_WAKEUP has been set
> > > for it), hence it will keep the corresponding PM domain powered-on
> > > too.
> > >
> >
> > Thanks, I can try if this works as alternative to the
> > dev_pm_syscore_device()!
> 
> Yes, please. We don't want to abuse the dev_pm_syscore_device() thingy.
> 

Could you clarify the idea behind GENPD_FLAG_ACTIVE_WAKEUP? Would I set
it conditionally for all RPMPDs or just the ones consumed by the CPU?
How does the genpd *provider* know if one of its *consumer* devices
needs to have its power domain kept on for wakeup?

Thanks!
Stephan
