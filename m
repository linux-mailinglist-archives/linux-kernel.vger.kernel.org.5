Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29D57B3847
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbjI2RBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbjI2RBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:01:25 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEB81BE;
        Fri, 29 Sep 2023 10:01:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696006879; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ELcoQqitbuh5QdUYiVG8Rnt+JD6sXbYawK/KlsXip2upmaBl6b2xy04L3gdovRDLKz
    ZT6J1fa6WIN19YMYV00JMfRTeL5mb4W62ZMsd/bUzuwwYNYQfacQUZ3o1eIpomhWtHxF
    cfd34Mmxbw562wpKPoVmB8bP0ilBlgXRqPTvdjwljsMigJ8jEfJGZUThTGREEM4/zf+F
    fF+vmCz9PujyWCxT7Q9Cf5mo6YjakrYjvwyPHeGrUN261KHp/JybKkElkOA+kp0ECMCl
    nyf5y8rSYFMbAOMujDDcXZVaUIsN8JPNogHPQb8RzZsZ2S+j4enOwABhA8IRSbHjy6AA
    F3Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696006879;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=c1LZOAquz+98eoqb9/BPIKYFm1QoBh+bs+Yd6UWIzlw=;
    b=XYdv6GdZarmwMw8y8bVYrj7EodVZ9akDC+G8y8w8wAO4TWij3Ty3NDYO+8Qwku2Qlf
    q5aXZMjUAjaFxnqc9b5DjB8EeR91uMT9yI9a6cYUPjy9KiHzwouQawRLWbQgxGG0tUzr
    zHa9lcTTx6gjYiObqM7rESiSQHqoNaUae0jxZSKeeQnhGJZacGgJM1W51QxKcRouNzkB
    3ycCtdSmuqxUaErPWwcduUkDBDGrgEyThp5AZqc+UaJTsr0NTYeiDQHnwMy9GCKXtPmm
    P/IAOvrdQytFzMIzKBXCgmEseEmFNOXtwt8/5iJ/Xu+oLv8B7gd+rCkfEC5NcttM8lkw
    6UdQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696006879;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=c1LZOAquz+98eoqb9/BPIKYFm1QoBh+bs+Yd6UWIzlw=;
    b=jvlgKpP/uRc5xocd7MWVTfXUURRfsnJlHWhZqNDwnKHkzAM8QAR/bnNBMWhhoGVsq4
    R7qN5HQzw9MCAbtbopi0Rz1fhGhtCkLnaFpHm4RyzTzes+7MNmM80khZJCZIwRL61PoW
    WCmoU+6axKnyLKfEqQJkcQ2bUqwjSHP6jHSj0koXg6UFgR9gfRBFqCTuxqL+I/djAdHY
    HaRLcpL4w2rkfLg1o/YCgnk+bE4CBsksLpN5b7IpA6BHugsXXJH3enTzVw2Qt8olAGjC
    sCtJyxEwM7JSJK0kNyl5qCGmzJEQQHkSUu2niWnFXJt6OyPZeR9hJngmLXG8/+ks/2g6
    2HIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696006879;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=c1LZOAquz+98eoqb9/BPIKYFm1QoBh+bs+Yd6UWIzlw=;
    b=QnBR3urVd889J9a7/uaadrOTG9OqqN8fZn0KB/qwahXxXaIiYMVBUtG316jmYQwOqz
    px0jJXliBkw1Ek4xiyDA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA95vh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 SBL|AUTH)
    with ESMTPSA id R04c57z8TH1IrLK
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 29 Sep 2023 19:01:18 +0200 (CEST)
Date:   Fri, 29 Sep 2023 19:01:12 +0200
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
Message-ID: <ZRcC2IRRv6dtKY65@gerhold.net>
References: <20230912-msm8909-cpufreq-v1-0-767ce66b544b@kernkonzept.com>
 <20230912-msm8909-cpufreq-v1-1-767ce66b544b@kernkonzept.com>
 <CAPDyKFq6U-MR4Bd+GmixYseRECDh142RhydtKbiPd3NHV2g6aw@mail.gmail.com>
 <ZQGqfMigCFZP_HLA@gerhold.net>
 <CAPDyKFppdXe1AZo1jm2Bc_ZR18hw5Bmh1x+2P7Obhb_rJ2gc4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFppdXe1AZo1jm2Bc_ZR18hw5Bmh1x+2P7Obhb_rJ2gc4Q@mail.gmail.com>
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

On Fri, Sep 29, 2023 at 03:14:07PM +0200, Ulf Hansson wrote:
> On Wed, 13 Sept 2023 at 14:26, Stephan Gerhold <stephan@gerhold.net> wrote:
> > On Wed, Sep 13, 2023 at 12:56:16PM +0200, Ulf Hansson wrote:
> > > On Tue, 12 Sept 2023 at 11:40, Stephan Gerhold
> > > <stephan.gerhold@kernkonzept.com> wrote:
> > > > [...]
> > > > However, at the
> > > > moment nothing ever enables the virtual devices created in
> > > > qcom-cpufreq-nvmem for the cpufreq power domain scaling, so they are
> > > > permanently runtime-suspended.
> > > >
> > > > Fix this by enabling the devices after attaching them and use
> > > > dev_pm_syscore_device() to ensure the power domain also stays on when
> > > > going to suspend. Since it supplies the CPU we can never turn it off
> > > > from Linux. There are other mechanisms to turn it off when needed,
> > > > usually in the RPM firmware or the cpuidle path.
> > > >
> > > > Without this fix performance states votes are silently ignored, and the
> > > > CPU/CPR voltage is never adjusted. This has been broken since 5.14 but
> > > > for some reason no one noticed this on QCS404 so far.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 1cb8339ca225 ("cpufreq: qcom: Add support for qcs404 on nvmem driver")
> > > > Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> > > > ---
> > > >  drivers/cpufreq/qcom-cpufreq-nvmem.c | 21 ++++++++++++++++++++-
> > > >  1 file changed, 20 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > > > index 84d7033e5efe..17d6ab14c909 100644
> > > > --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > > > +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > > > @@ -25,6 +25,7 @@
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/pm_domain.h>
> > > >  #include <linux/pm_opp.h>
> > > > +#include <linux/pm_runtime.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/soc/qcom/smem.h>
> > > >
> > > > @@ -280,6 +281,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
> > > >         }
> > > >
> > > >         for_each_possible_cpu(cpu) {
> > > > +               struct device **virt_devs = NULL;
> > > >                 struct dev_pm_opp_config config = {
> > > >                         .supported_hw = NULL,
> > > >                 };
> > > > @@ -300,7 +302,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
> > > >
> > > >                 if (drv->data->genpd_names) {
> > > >                         config.genpd_names = drv->data->genpd_names;
> > > > -                       config.virt_devs = NULL;
> > > > +                       config.virt_devs = &virt_devs;
> > > >                 }
> > > >
> > > >                 if (config.supported_hw || config.genpd_names) {
> > > > @@ -311,6 +313,23 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
> > > >                                 goto free_opp;
> > > >                         }
> > > >                 }
> > > > +
> > > > +               if (virt_devs) {
> > > > +                       const char * const *name = config.genpd_names;
> > > > +                       int i;
> > > > +
> > > > +                       for (i = 0; *name; i++, name++) {
> > > > +                               ret = pm_runtime_resume_and_get(virt_devs[i]);
> > > > +                               if (ret) {
> > > > +                                       dev_err(cpu_dev, "failed to resume %s: %d\n",
> > > > +                                               *name, ret);
> > > > +                                       goto free_opp;
> > > > +                               }
> > >
> > > Shouldn't we restore the usage count at ->remove() too?
> > >
> > > > +
> > > > +                               /* Keep CPU power domain always-on */
> > > > +                               dev_pm_syscore_device(virt_devs[i], true);
> > >
> > > Is this really correct? cpufreq is suspended/resumed by the PM core
> > > during system wide suspend/resume. See dpm_suspend|resume(). Isn't
> > > that sufficient?
> > >
> > > Moreover, it looks like the cpr genpd provider supports genpd's
> > > ->power_on|off() callbacks. Is there something wrong with this, that I
> > > am missing?
> > >
> >
> > I think this question is a quite fundamental one. To explain this
> > properly I will need to delve a bit into the implementation details of
> > the two different GENPD providers that are applicable here:
> >
> > Fundamentally, we are describing the main power supply for the CPU here.
> > Consider a simple regulator with adjustable voltage. From the Linux
> > point of view this regulator should be marked as "regulator-always-on".
> > If we would turn off this regulator, the CPU would be immediately dead
> > without proper shutdown done by firmware or hardware.
> >
> > Representing the regulator as power domain does not change much, except
> > that we now have abstract "performance states" instead of actual voltages.
> > However, for power domains there is currently no generic mechanism like
> > "regulator-always-on" in the DT, only drivers can specify
> > GENPD_FLAG_ALWAYS_ON.
> 
> We have relied on genpd providers to act on their compatible strings
> to make the correct configuration. If that isn't sufficient, I don't
> see why we couldn't add a new DT property corresponding to
> GENPD_FLAG_ALWAYS_ON.
> 

Right. It's not completely trivial though, since a DT node may provide
many different power domains with #power-domain-cells = <N>. A regulator
on the other hand has a dedicated DT node where you can just add
"regulator-always-on". :')

> >
> > The special situation on MSM8909 is that there are two possible setups
> > for the CPU power supply depending on the PMIC that is used (see
> > "[PATCH 4/4] cpufreq: qcom-nvmem: Add MSM8909"): CPR or RPMPD. Both are
> > GENPD providers so in theory we can just have either
> >
> >   cpu@0 { power-domains = <&cpr>; }; // or
> >   cpu@0 { power-domains = <&rpmpd MSM8909_VDDCX_AO>; };
> >
> > in the DT, without handling this specifically on the cpufreq side.
> 
> Looks like it would be nice to get a patch for the MSM8909 DTS too, as
> part of the series, to get a better picture of how this is going to be
> used. Would that be possible for you to provide?
> 

Sure! Right now I cannot include it as working patch in this series
since I don't have the base SoC DT (msm8909.dtsi) upstream yet. It's
mostly a copy-paste of msm8916.dtsi so I was trying to finish up the
SoC-specific parts before sending it.

I'm happy to provide links to the full DT and my changes though. Does
that help? If you would like to comment inline I could copy paste the
diffs in a mail or include some kind of RFC patch. It just wouldn't be
possible to apply it successfully. :')

Here are the two commits with the my current DT changes (WIP):
  - MSM8909+PM8909 (RPMPD only):
    https://github.com/msm8916-mainline/linux/commit/791e0c5a3162372a0738bc7b0f4a5e87247923db
  - MSM8916 (CPR+RPMPD):
    https://github.com/msm8916-mainline/linux/commit/8880f39108206d7a60a0a8351c0373bddf58657c
  (- QCS404 (CPR only): already in mainline (see qcs404.dtsi))

> >
> > The two GENPD providers behave quite differently though:
> >
> >  - CPR: CPR is not really a power domain itself. It's more like a monitor
> >    on a power supply line coming from some other regulator. CPR provides
> >    suggestions how to adjust the voltage for best power/stability.
> >
> >    The GENPD .power_off() disables the CPR state machine and forwards
> >    this to the regulator with regulator_disable(). On QCS404 the
> >    regulator is marked regulator-always-on, so it will never be disabled
> >    from Linux. The SAW/SPM hardware component on Qualcomm SoCs will
> >    usually disable the regulator during deep cpuidle states.
> 
> Parts of this sound a bit odd to me. The CPR/CPUfreq shouldn't really
> need to vote for the CPU's power-rail(s) from a powered-on/off (CPU
> idle states) point of view, but only from a performance (voltage
> level) point of view.
> 
> If the enable/disable voting on the regulator really has an impact on
> some platforms, it sounds like it could prevent deeper CPU idle states
> too. That's probably not what we want, right?
> 

I think this heavily depends on what exactly this "regulator"
represents. Are we talking about a physical regulator with a binary
enable/disable signal or actually some hardware/firmware magic that
combines multiple independent "votes"?

If we are talking about a physical regulator then we can never disable
it from Linux. Not even during CPU idle states. It would just cut off
all power immediately and kill the CPU without proper shutdown. Instead,
the platform might have special hardware/firmware functionality that
will control the actual physical enable/disable signal of the regulator.

> I also had a look at the existing CPR genpd provider's probe
> function/path (cpr_probe()) - and it turns out there is no call to
> regulator_enable(). Whatever that means to us.

In most (all?) setups the CPR genpd provider will manage the actual
physical regulator. It could be part of the PMIC or even some
off-the-shelf regulator with I2C control. It doesn't matter. There is
nothing special about that regulator. You have the standard Linux
regulator driver, set up the DT node for it and hook it up to CPR.

Now, to prevent the regulator driver in Linux from touching the physical
enable signal (see above) we add "regulator-always-on". When Linux
requests deep CPU idle states via PSCI the hardware will toggle the
physical enable/disable signal of the regulator for us (after the CPU
has been shut down).

On some platforms CPR is also used for the GPU or other power rails that
are not critical for the CPU to run. In that case it's fine to disable
the regulator directly from Linux. Just not for the CPU.

> 
> >
> >  - RPMPD: This is the generic driver for all the SoC power domains
> >    managed by the RPM firmware. It's not CPU-specific. However, as
> >    special feature each power domain is exposed twice in Linux, e.g.
> >    "MSM8909_VDDCX" and "MSM8909_VDDCX_AO". The _AO ("active-only")
> >    variant tells the RPM firmware that the performance/enable vote only
> >    applies when the CPU is active (not in deep cpuidle state).
> >
> >    The GENPD .power_off() drops all performance state votes and also
> >    releases the "enable" vote for the power domain.
> >
> > Now, imagine what happens during system wide suspend/resume:
> >
> >  - CPR: The CPR state machine gets disabled. The voltage stays as-is.
> >      - With "regulator-always-on": The CPU keeps running until WFI.
> >      - Without: I would expect the CPU is dead immediately(?)
> 
> As I indicated above, I am starting to feel that this is a bit upside
> down. CPR/CPUfreq should vote on voltages to scale performance, but
> not for cpu idle states.
> 
> Perhaps what is missing is a synchronization point or a notification,
> to inform the CPR driver that its state machine (registers) needs to
> be saved/restored, when the power-rails get turned on/off. In fact, we
> have a couple mechanisms at hand to support this.
> 

I think we can ignore this part of CPR for now. AFAICT Qualcomm's vendor
driver does not explicitly disable the CPR state machine during CPU idle
when the power rails are potentially turned off. They only do it during
system wide suspend, for whatever reason. For that we don't need such a
notification mechanism.

> >
> >  - RPMPD: The performance/enable vote is dropped. The power domain might
> >    go to minimal voltage or even turn off completely. However, the CPU
> >    actually needs to keep running at the same frequency until WFI!
> >    Worst case, the CPU is dead immediately when the power domain votes
> >    get dropped.
> 
> Since RPMPD is managing the voting for both performance and low power
> states for different kinds of devices, this certainly gets a bit more
> complicated.
> 
> On the other hand, the CPUfreq driver should really only vote for
> performance states for the CPUs and not for low power states. The
> latter is a job for cpuidle and other consumers of the RPMPD to
> manage, I think.
> 
> So, while thinking of this, I just realized that it may not always be
> a good idea for genpd to cache a performance state request, for an
> attached device and for which pm_runtime_suspended() returns true for
> it. As this is the default behaviour in genpd, I am thinking that we
> need a way to make that behaviour configurable for an attached device.
> What do you think about that?
> 

Hm. This would be a bit of a special case of course. But I think this
would be fine to solve the regression for CPR on QCS404.

Then we "just" need to solve the fundamental question from a few years
ago: Who *will* actually vote for enabling the power domains/regulators
required by the CPU? :D

I agree that enabling/disabling power supplies feels closer to cpuidle.
But it's not a perfect fit either, given that we don't actually want to
change our vote while entering CPU idle states. I think on all platforms
I'm looking at here we need a permanent enable vote (effectively making
the regulator/power domains always-on from the Linux point of view).

We could solve this by adding a "regulator-always-on" mechanism in the
DT for power domains. This feels more like a workaround to me than an
actual solution. With this the CPU won't appear as always-on consumer of
the power domains in debugfs. There will just be a "suspended" consumer
attributed to the CPU (from CPUfreq, since we don't have a dedicated
device for CPUfreq).

While this patch is a bit strange from a conceptual perspective, on the
implementation side it effectively makes that CPU consumer appear as
active. So the end result is actually kind of the one we need. :'D

Thanks,
Stephan
