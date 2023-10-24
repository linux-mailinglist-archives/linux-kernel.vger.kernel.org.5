Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709DC7D5827
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343879AbjJXQZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343557AbjJXQZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:25:39 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1AD111;
        Tue, 24 Oct 2023 09:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698164734; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jFmsKgTNZAZIwUdugGKnmrcnP5auvCuXcRINXCifCaqO2Rxwwh5aTPGR4MBASQ81d/
    OHlOQkIEDiM2VJHDCJ0Ar0qRHDGH9jE1tRnCbVRhOL/jkIstiQlwCetHNgbOu46MRfhS
    nQeYXi4AdGH3sdVqPZN/jL5PeTLM2j7nbVxpFvUeC3tp5VvZy/dec1W9X3TcR2mJPW90
    f0gPLZ8R2ZQOb3hcK40vs19NtQhp9nLVsk7gnRTa2KD1uLZ/fafHXOApviEHp8NzM/lC
    Q6iQdRn4HSFiduvyayKDLraMPVDFDW2Igbbt/lToO01oJ+Hq9xlHwiotzuZZJVsSlh/B
    nhPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698164734;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=BKuCBeuwdGgUeRuNCbFHWtHrgHiZpvFPcgBdLz2whR4=;
    b=MKjshxKL2XMbugW1bLA9mN8A0RKMg2KLCu19ikbDuOfgDnchzw7UgMWFUd+C3Skj1/
    5DX/m2puY2yTWVHIMc07WyMuk4JV4aynmNyWZz05eXfkWse/zd86SWqjln2NYNU3Icjk
    tGyFMIbbJDPuX65tu1o/ba4qjQWiok7CAFYG/M8fgwOjObX4KomI0N+1IU25xDPkIkTY
    8jSvz/giiiN6pDAY1cam5yuSt4/q4PpvnZ2y6xL5rUPP/s23Sr/wCxRysvpbu4E2RBEh
    B9gPEgcD+xi2z+9kYgcMzjwhHt5ElfRoUJq0iXkupIkuf0DG7qyg0xTmIRUGdfK3vbT8
    8HYw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698164734;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=BKuCBeuwdGgUeRuNCbFHWtHrgHiZpvFPcgBdLz2whR4=;
    b=MxgKkMraIPXFbPtFfYbpgzo7AyE6t3/6XtN08BPqKzB4dIDWiByfjTXj4o71jchFO4
    xp2PjzC3Ar/4zr1/NugLN+v+LX+lhZ0Rk739Fd0hmD/CGWirt1MQptRjN8mlS/aunEJP
    YDbDiOtoTZZx41cLh6zYmAL8HMCcLXV5cHqUGt2jDIJKHaOd+oKT8X6nxHJEzGJ2pG5J
    06+hUg0ZDoZHt4xZXxU4L8mZp7kiJOwvYUjRbGqe5yeWmFjLN9tH4xt6NE0T39xIx8vA
    QV2WzNaM0WlSnrqoB9Xy2CCV58Im4HF74ks/GAroHmbWg3jyGlIEoWTjXVKZZrTqvLkz
    5WXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698164734;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=BKuCBeuwdGgUeRuNCbFHWtHrgHiZpvFPcgBdLz2whR4=;
    b=2PCEAStkBVaZjcLABSrDuFH8+MKtswPuHybD8FIetqU3T5XlT5mm0KXJESzGBYuJNM
    1wOSuHbnT4QEpu196ZCA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z+P1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.9.0 DYNA|AUTH)
    with ESMTPSA id j34a49z9OGPXRmV
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 24 Oct 2023 18:25:33 +0200 (CEST)
Date:   Tue, 24 Oct 2023 18:25:28 +0200
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
Message-ID: <ZTfv-Dea693UqLXB@gerhold.net>
References: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
 <20231018-msm8909-cpufreq-v2-2-0962df95f654@kernkonzept.com>
 <CAPDyKFot9=M1ooP_Q1AOgG5o_4DTQ2qsyai1ZdXAzBwf89W4uA@mail.gmail.com>
 <CAPDyKFr5A-P=UhWs4rUMBWup3pH75WAhcZ56Y2_Sfk3=WfxRCQ@mail.gmail.com>
 <ZTeyhR7YY7VgWQlU@kernkonzept.com>
 <CAPDyKFrcV8iJnJ904j1jkx0E8PaOLmiTZ7CKk7EV8qQ71AZdbA@mail.gmail.com>
 <ZTfBZqBwqskhFydZ@kernkonzept.com>
 <CAPDyKFooPLCmJeqjhiMm7HRdW5UrEw0yHvGF9fgLvOigsgbWxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFooPLCmJeqjhiMm7HRdW5UrEw0yHvGF9fgLvOigsgbWxg@mail.gmail.com>
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

On Tue, Oct 24, 2023 at 06:11:34PM +0200, Ulf Hansson wrote:
> On Tue, 24 Oct 2023 at 15:07, Stephan Gerhold
> <stephan.gerhold@kernkonzept.com> wrote:
> >
> > On Tue, Oct 24, 2023 at 02:49:32PM +0200, Ulf Hansson wrote:
> > > On Tue, 24 Oct 2023 at 14:03, Stephan Gerhold
> > > <stephan.gerhold@kernkonzept.com> wrote:
> > > >
> > > > On Thu, Oct 19, 2023 at 01:26:19PM +0200, Ulf Hansson wrote:
> > > > > On Thu, 19 Oct 2023 at 12:24, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > >
> > > > > > On Wed, 18 Oct 2023 at 10:06, Stephan Gerhold
> > > > > > <stephan.gerhold@kernkonzept.com> wrote:
> > > > > > >
> > > > > > > The genpd core caches performance state votes from devices that are
> > > > > > > runtime suspended as of commit 3c5a272202c2 ("PM: domains: Improve
> > > > > > > runtime PM performance state handling"). They get applied once the
> > > > > > > device becomes active again.
> > > > > > >
> > > > > > > To attach the power domains needed by qcom-cpufreq-nvmem the OPP core
> > > > > > > calls genpd_dev_pm_attach_by_id(). This results in "virtual" dummy
> > > > > > > devices that use runtime PM only to control the enable and performance
> > > > > > > state for the attached power domain.
> > > > > > >
> > > > > > > However, at the moment nothing ever resumes the virtual devices created
> > > > > > > for qcom-cpufreq-nvmem. They remain permanently runtime suspended. This
> > > > > > > means that performance state votes made during cpufreq scaling get
> > > > > > > always cached and never applied to the hardware.
> > > > > > >
> > > > > > > Fix this by enabling the devices after attaching them and use
> > > > > > > dev_pm_syscore_device() to ensure the power domains also stay on when
> > > > > > > going to suspend. Since it supplies the CPU we can never turn it off
> > > > > > > from Linux. There are other mechanisms to turn it off when needed,
> > > > > > > usually in the RPM firmware (RPMPD) or the cpuidle path (CPR genpd).
> > > > > >
> > > > > > I believe we discussed using dev_pm_syscore_device() for the previous
> > > > > > version. It's not intended to be used for things like the above.
> > > > > >
> > > > > > Moreover, I was under the impression that it wasn't really needed. In
> > > > > > fact, I would think that this actually breaks things for system
> > > > > > suspend/resume, as in this case the cpr driver's genpd
> > > > > > ->power_on|off() callbacks are no longer getting called due this,
> > > > > > which means that the cpr state machine isn't going to be restored
> > > > > > properly. Or did I get this wrong?
> > > > >
> > > > > BTW, if you really need something like the above, the proper way to do
> > > > > it would instead be to call device_set_awake_path() for the device.
> > > > >
> > > >
> > > > Unfortunately this does not work correctly. When I use
> > > > device_set_awake_path() it does set dev->power.wakeup_path = true.
> > > > However, this flag is cleared again in device_prepare() when entering
> > > > suspend. To me it looks a bit like wakeup_path is not supposed to be set
> > > > directly by drivers? Before and after your commit 8512220c5782 ("PM /
> > > > core: Assign the wakeup_path status flag in __device_prepare()") it
> > > > seems to be internally bound to device_may_wakeup().
> > > >
> > > > It works if I make device_may_wakeup() return true, with
> > > >
> > > >         device_set_wakeup_capable(dev, true);
> > > >         device_wakeup_enable(dev);
> > > >
> > > > but that also allows *disabling* the wakeup from sysfs which doesn't
> > > > really make sense for the CPU.
> > > >
> > > > Any ideas?
> > >
> > > The device_set_awake_path() should be called from a system suspend
> > > callback. So you need to add that callback for the cpufreq driver.
> > >
> > > Sorry, if that wasn't clear.
> > >
> >
> > Hmm, but at the moment I'm calling this on the virtual genpd devices.
> > How would it work for them? I don't have a suspend callback for them.
> >
> > I guess could loop over the virtual devices in the cpufreq driver
> > suspend callback, but is my driver suspend callback really guaranteed to
> > run before the device_prepare() that clears "wakeup_path" on the virtual
> > devices?
> 
> Yes, that's guaranteed. dpm_prepare() (which calls device_prepare())
> is always being executed before dpm_suspend().
> 

Thanks, I think I understand. Maybe. :-)

Just to confirm, I should call device_set_awake_path() for the virtual
genpd devices as part of the PM ->suspend() callback? And this will be
guaranteed to run after the "prepare" phase but before the
"suspend_noirq" phase where the genpd core will check the wakeup flag?

Thanks,
Stepan
