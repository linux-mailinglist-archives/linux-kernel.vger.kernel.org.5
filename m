Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD627D0034
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345620AbjJSRH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbjJSRHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:07:54 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F1B9E;
        Thu, 19 Oct 2023 10:07:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1697735268; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gL+OYJWOZsBK8wjUer7YzfA6lu2/OAmILo7rXbMEpIo6Q5vpMyC7mSWdbhANMzl7q+
    Yu5Sz+ZybFahk9W7740bmh3r2LQT5BzJ9GIa8FZy0cXEABKXDEY8LS0fzGz4GNwzzAo2
    7PIAaqu2cgWNqw5JgtFO/ghcduIJuqL9WtdsO3ZItYiXxK8iFxT9KrozvKRvEojXiUCn
    1hXv6cMNAJGsvhVYq7ntP5eZ+xrumKheqlDvHcyuDN3ITzSmXHIDuPkDxaiznH/Fz83I
    8wDGnOGbV1esiSODY+sD3w13uc8ia4t1qetiLpxsB0ucKa/Z9Vlf5cBXMHaZcdvp/nIG
    a5Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1697735268;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ggdAcZ8XFp1hnFIstd7n2G5k77VgwuMSI/PGdGGtmZ8=;
    b=T8uEwk7akEKn3bWwEfLVQY5L3xK5W0hJHI2EdktHjkdNySOpoSZpJ8sl9eAXEtVwnz
    P+J2UNQb7RmFnrgApP98u3q24kXUIGQgDv2hlwZfEZzuAgvZp7VCxYq+DTqaNlkjZGbV
    N+oOEWGaIwpKMKxPUTq3xZPtv+2rrajpsOE1E/VHbjRX9d1eCi9HB8IUyAWLea4U5XSq
    sVSFQ/EiFq6GfBWeDAD/QVfMyUHbQf2HSc9jqiYy/SDfh7rM5/xzBnqknx/lVFMItKvk
    wWh2Uw9zNJAWmPqap08exwrIK/zGkyqopS+SAZBHzYJR/DFMa8Ud9FHaZR4QoDdwMFGw
    Pb4g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1697735268;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ggdAcZ8XFp1hnFIstd7n2G5k77VgwuMSI/PGdGGtmZ8=;
    b=SUmf/7em3PDqqlxJi6XO0HJImqy824rDa1rYbI+jD1uANy/YAqLOaFom9WYb+THzPZ
    iaDWgRpAtIZSJQvVGyRk2U+/KctdVGTBXKNcZrPV+Za6kbIflE60hn7QCoJQYVocVtrQ
    cjTrSfj26muuvN1xwmWY02Iz7g/mdToTG6efrS0AzAmyLDhLkVUhCQRHIO5/360bsFkP
    opF4nVSAQIjPPCf2FVhDW6k6n4rUtOwlLdD+CiaAFvOJ++oqgz5PrgTCAgYa2s0hxef3
    twDk4RrWo/nWEMlDOQciApA6kKkejkZEpp5rSsfDC5PuIIbknlslSR/ptr6wpsH7262n
    jFzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1697735268;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ggdAcZ8XFp1hnFIstd7n2G5k77VgwuMSI/PGdGGtmZ8=;
    b=9jhv3SStOE/B1Ma3imgq1ohB5nXLSIXSN7EHHaG3zof6i2DaDRzyTci5sZfrlo/LQN
    J8uF5e3y68hG2BkmleCw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA95vh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.9.0 DYNA|AUTH)
    with ESMTPSA id j34a49z9JH7lEPB
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 19 Oct 2023 19:07:47 +0200 (CEST)
Date:   Thu, 19 Oct 2023 19:07:40 +0200
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
Message-ID: <ZTFiXJ2XO4WQN_gu@gerhold.net>
References: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
 <20231018-msm8909-cpufreq-v2-2-0962df95f654@kernkonzept.com>
 <CAPDyKFot9=M1ooP_Q1AOgG5o_4DTQ2qsyai1ZdXAzBwf89W4uA@mail.gmail.com>
 <CAPDyKFr5A-P=UhWs4rUMBWup3pH75WAhcZ56Y2_Sfk3=WfxRCQ@mail.gmail.com>
 <ZTEph19CAvbgbN_E@gerhold.net>
 <CAPDyKFo1PVZYsdW_=92EtMmTT9hmkm-mBR69N_WvPh4f-Hw=NA@mail.gmail.com>
 <ZTFBzjLAaaUHux4O@gerhold.net>
 <CAPDyKFruYqngQoW21Ra+hm4ybjS7LoD4casYbo8bP4J+hLUnaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFruYqngQoW21Ra+hm4ybjS7LoD4casYbo8bP4J+hLUnaA@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 05:19:53PM +0200, Ulf Hansson wrote:
> On Thu, 19 Oct 2023 at 16:49, Stephan Gerhold <stephan@gerhold.net> wrote:
> > On Thu, Oct 19, 2023 at 04:12:56PM +0200, Ulf Hansson wrote:
> > > On Thu, 19 Oct 2023 at 15:05, Stephan Gerhold <stephan@gerhold.net> wrote:
> > > > On Thu, Oct 19, 2023 at 01:26:19PM +0200, Ulf Hansson wrote:
> > > > > BTW, if you really need something like the above, the proper way to do
> > > > > it would instead be to call device_set_awake_path() for the device.
> > > > >
> > > > > This informs genpd that the device needs to stay powered-on during
> > > > > system suspend (assuming that GENPD_FLAG_ACTIVE_WAKEUP has been set
> > > > > for it), hence it will keep the corresponding PM domain powered-on
> > > > > too.
> > > >
> > > > Thanks, I can try if this works as alternative to the
> > > > dev_pm_syscore_device()!
> > >
> > > Yes, please. We don't want to abuse the dev_pm_syscore_device() thingy.
> >
> > Could you clarify the idea behind GENPD_FLAG_ACTIVE_WAKEUP? Would I set
> > it conditionally for all RPMPDs or just the ones consumed by the CPU?
> > How does the genpd *provider* know if one of its *consumer* devices
> > needs to have its power domain kept on for wakeup?
> 
> We are thinking of the GENPD_FLAG_ACTIVE_WAKEUP as a platform
> configuration type of flag for the genpd in question. The consumer
> driver shouldn't need to know about the details of what is happening
> on the PM domain level - only whether it needs its device to remain
> powered-on during system suspend or not.
> 

Thanks! I will test if this works for RPMPD and post new versions of the
patches. By coincidence I think this flag might actually be useful as
temporary solution for CPR. If I:

 1. Change $subject patch to use device_set_awake_path() instead, and
 2. Set GENPD_FLAG_ACTIVE_WAKEUP for the RPMPD genpds, but
 3. Do *not* set GENPD_FLAG_ACTIVE_WAKEUP for the CPR genpd.

Then the genpd ->power_on|off() callbacks should still be called
for CPR during system suspend, right? :D

> I suspect that the GENPD_FLAG_ACTIVE_WAKEUP is probably okay to set
> for most genpds, but there may be some exceptions.
> 

Out of curiosity, do you have an example for such an exception where
GENPD_FLAG_ACTIVE_WAKEUP shouldn't be set, aside from workarounds like
I just described?

As you said, the consumer device should just say that it wants to stay
powered for wakeup during suspend. But if its power domains get powered
off, I would expect that to break. How could a genpd driver still
provide power without being powered on? Wouldn't that rather be a low
performance state?

Thanks,
Stephan
