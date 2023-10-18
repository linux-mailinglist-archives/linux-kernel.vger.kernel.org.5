Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF7C7CD55E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344559AbjJRHNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjJRHNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:13:31 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7A7BA;
        Wed, 18 Oct 2023 00:13:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1697613207; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YVEdEd+44bqyCaMa0ZwcpYPN05TNXqtKJmkgcXf8d1s0rB5y8IJABHC/SFGIhnBrWx
    P2AQPou+c7blTkw4dctvljfiAHy+0UbqLbzj1r0cMSXd112hX1svx8qW+tksUt0ioq1O
    gl1BBIv4byXkLyhElJ74uR8HJEwVyxQCPtYvpJlLW3KlfX9rh/q7ys9lSZVlmH6GCZwh
    +T4xJbUC8yFbj/gkmoK/9SJL0y4lcwGZS6yp0G+OeH9hH8CXvwZ6fHmusm6WCzFV5r+F
    w8CBApdg2V986J36+ALVSdb99X2VpriqY3JURWxInQvB/L52n8zktPlIq55Zb04fNM2D
    v/Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1697613207;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=a0tv/jXdlJYYydvKci7q39RV+zMHykUxsafimd8rhKc=;
    b=W8B1QyGTNGQuEoVTeKHZMTd51/kyyHE42FVV5kcCBzUNVTUGObZDa+TTB8X00XD3fL
    fx+bPqf0Yt7+NW98z6sHhh+pjcnKO7Zfbpi7GW76HNpsbszKfp9yLhAIlySPgDRspgOr
    pFTu6OZ+JJ5oI+yEnvSuV6/g5mUPTGxa9YQPC86D9pIlSpFg0SpJe0RUw9k2TX1uIqYJ
    XWfQyzc0Mv/IUEGfy55s6hXBeKJGXAEmICsarMC6J+7nI3Gq8r7BkpvVyHWbZiS4GUgT
    5jn9qD7gZMmyjcmwZyn1qMjhuifz76uTOzNsanKeHIEqRoxUJyROEREOhKNEjI1kQIyR
    rqpg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1697613207;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=a0tv/jXdlJYYydvKci7q39RV+zMHykUxsafimd8rhKc=;
    b=fhZjx0VCRuCKmrPK/CZR16ebZEfIwfEUPHVnZfUVV67VdjUiCWHft3498orR681iCq
    tzl9wvZRymx3gxovj7zUeeMrwgahlFzENRbFxbZjV0NRr3E3xr964ANA0gpCOZN5JUnX
    q+qRQG1lsKFeqAe/R5jSovW0mcO48541A9ER6pmmSdaQY+ZZ2pTQwvIjdnj6hOMEG3Dg
    YVF9c5e9vkK6jq5I2JwJr/5kS6hY0wFTNN91eJ5uYp37N4XIG767tPrWVT3YeJ8en42o
    2asiOWR0j3SEZbVkf/G+zlgkkY/I0Ly9xyjYap3FpQ4EC3f3j7H1QeiCLbYsxrjD08uJ
    TTlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1697613207;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=a0tv/jXdlJYYydvKci7q39RV+zMHykUxsafimd8rhKc=;
    b=9ngWWFvNgop0xqTFoBm8e19FIv/0otce8CLSzVntPzaazdOQr2s4yii0lSyi7i/ra7
    Z405IM7xnKU755E9SwAQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA+p3h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.9.0 DYNA|AUTH)
    with ESMTPSA id j34a49z9I7DQ7o8
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 18 Oct 2023 09:13:26 +0200 (CEST)
Date:   Wed, 18 Oct 2023 09:13:18 +0200
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
Message-ID: <ZS-FjhUU12TssGhy@gerhold.net>
References: <20230912-msm8909-cpufreq-v1-1-767ce66b544b@kernkonzept.com>
 <CAPDyKFq6U-MR4Bd+GmixYseRECDh142RhydtKbiPd3NHV2g6aw@mail.gmail.com>
 <ZQGqfMigCFZP_HLA@gerhold.net>
 <CAPDyKFppdXe1AZo1jm2Bc_ZR18hw5Bmh1x+2P7Obhb_rJ2gc4Q@mail.gmail.com>
 <ZRcC2IRRv6dtKY65@gerhold.net>
 <CAPDyKFoiup8KNv=1LFGKDdDLA1pHsdJUgTTWMdgxnikEmReXzg@mail.gmail.com>
 <ZSg-XtwMxg3_fWxc@gerhold.net>
 <CAPDyKFoH5EOvRRKy-Bgp_B9B3rf=PUKK5N45s5PNgfBi55PaOQ@mail.gmail.com>
 <ZS70aZbP33fkf9dP@gerhold.net>
 <CAPDyKFpwZdx=vyuAZSv1WGYCyiohfnt87LM1jw=fhKsF5Ks1Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpwZdx=vyuAZSv1WGYCyiohfnt87LM1jw=fhKsF5Ks1Yw@mail.gmail.com>
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

On Tue, Oct 17, 2023 at 11:50:21PM +0200, Ulf Hansson wrote:
> [...]
> > >
> > > *) The pm_runtime_resume_and_get() works for QCS404 as a fix. It also
> > > works fine when there is only one RPMPD that manages the performance
> > > scaling.
> > >
> >
> > Agreed.
> >
> > > **) In cases where we have multiple PM domains to scale performance
> > > for, using pm_runtime_resume_and_get() would work fine too. Possibly
> > > we want to use device_link_add() to set up suppliers, to avoid calling
> > > pm_runtime_resume_and_get() for each and every device.
> > >
> >
> > Hm. What would you use as "supplied" device? The CPU device I guess?
> 
> The consumer would be the device that is used to probe the cpureq
> driver and the supplier(s) the virtual devices returned from genpd
> when attaching.
> 
> >
> > I'm looking again at my old patch from 2020 where I implemented this
> > with device links in the OPP core. Seems like you suggested this back
> > then too :)
> >
> >   https://lore.kernel.org/linux-pm/20200826093328.88268-1-stephan@gerhold.net/
> >
> > However, for the special case of the CPU I think we don't gain any code
> > simplification from using device links. There will just be a single
> > resume of each virtual genpd device, as well as one put during remove().
> > Exactly the same applies when using device links, we need to set up the
> > device links once for each virtual genpd device, and clean them up again
> > during remove().
> >
> > Or can you think of another advantage of using device links?
> 
> No, not at this point.
> 
> So, in this particular case it may not matter that much. But when the
> number of PM domains starts to vary between platforms it could be a
> nice way to abstract some logic. I guess starting without using
> device-links and seeing how it evolves could be a way forward too.
> 

Sounds good :)

> >
> > > ***) Due to the above, we don't need a new mechanism to avoid
> > > "caching" performance states for genpd. At least for the time being.
> > >
> >
> > Right. Given *) and **) I'll prepare a v2 of $subject patch with the
> > remove() cleanup fixed and an improved commit description.
> >
> > I'll wait for a bit in case you have more thoughts about the device
> > links.
> 
> One more thing though that crossed my mind. In the rpmpd case, is
> there anything we need to care about during system suspend/resume that
> isn't already taken care of correctly?
> 

No, I don't think so. The RPM firmware makes no difference between deep
cpuidle and system suspend. As long as we properly enter deep cpuidle as
part of s2idle, it will automatically release our votes for the
"active-only" (_AO) variant of the RPMPDs.

I'll send the adjusted v2 shortly for you to look at. :)

Thanks,
Stephan
