Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2C27D6B18
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343804AbjJYMRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343753AbjJYMRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:17:42 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE42D12A;
        Wed, 25 Oct 2023 05:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698236254; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=l8oV9U79W/ECdVdQvlN/ZTes9afrEburporBnVR14I85yo0yxXgfJRLIivJorFwA2q
    LRqfszg2SGN3UdlhpG8oiUF5pFYAGl8eTr3Pvzabkx7EvPN1aljvQ8iQlqVM7POIa8YM
    lnlDWP1Xm2Vf5odfGRDREY9nfDQDslYmB5fIEdBOw846terGUU21jeWkksMlw5bjUjfd
    JH+gKwpm6sJGhFN88YPtc8QgvvzcqND49RoNxp3xx0v1HUimgp9gq3RwLRY8KM6v2tsS
    7YEXJBBartz+mofnaEiGwKysB0+IBtMeSY0ujzmUvZvqiEGgvv6uoLqBl1Pjl2ooOrPe
    Kc7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698236254;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=73L4Ms4PMOWw/xFVar8dsW7N6HIPL8Fr9oWUdcyuZFM=;
    b=n9+zyEaOeEgc+vxdh4/50AvHWDoxk5YjfX9TGv37zqOA9dN5y9sZ2USr+JIRulaOLA
    jgiDj3OEJx1Di7e4/O6zq0eQB94BoB3o7xLsMCUR3nbTHcCyuSS1YDmVZIjtaIonEWGq
    zUl8BkYN09pScvu31wEytBas11bG7xUj5hbxdez4Yb1Uq9tOgJxfhIY6gDsBBn4Z7+I2
    9EuuBcR21+4nyc5dpxXOR6BMsxM+sP1XY65igZG0dZmTe3JBlsOYc0q/eRHl15r7JUVG
    ujfL9mIAUqivNjM/gRk8DlrjlqwjwOj0YVHOaOzqQkY1dqCqQ8fwkns27aj6tQkJojwv
    iT0w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698236253;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=73L4Ms4PMOWw/xFVar8dsW7N6HIPL8Fr9oWUdcyuZFM=;
    b=KZKUiUuMmMPxLbcVz+D2IO/y8dysPta1LFKbWeTHyWj9YsHO9KUH2LRZiWPmniRTKc
    5+to2VPav5JN0BTbtxskO9afB84JeNyu3YXdL6v4E2vSJWvLqfKBuNn3QzAyIvGgsGRD
    LH0GEWVj3Rlf4weQcT6pbmGGrzS7nMqjQqJLTK9qcDYh+X4RHA9cv/fqEBI/BWU7VsXZ
    D3YefA+8ntb2mXjSeRaCXQt+wixFu1O0NCryML3cxzAFHyEcbyg6rOjH+QYYQxfIBtyo
    MfDAerasJEyFvQzjVdMLo4LIrkyFmwS8jHgkxX5BkWd9z7bfkLgl8xRkXvPZA+8PaOvY
    Pl6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698236253;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=73L4Ms4PMOWw/xFVar8dsW7N6HIPL8Fr9oWUdcyuZFM=;
    b=Td96tNRy0OgPhl1ClTdYVJzh6OSI/TGttpiiL8lunIaGxaAd0scITXFjxT73l+mEi6
    93T9gxIkUKAOLZZyeaAQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z2L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.9.0 DYNA|AUTH)
    with ESMTPSA id j34a49z9PCHXUte
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 25 Oct 2023 14:17:33 +0200 (CEST)
Date:   Wed, 25 Oct 2023 14:17:25 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP: Call dev_pm_opp_set_opp() for required OPPs
Message-ID: <ZTkHVVq61lrpRUOv@gerhold.net>
References: <cover.1697710527.git.viresh.kumar@linaro.org>
 <6de4fcb5bb943a131d0cdf0a858bd35af02a2f88.1697710527.git.viresh.kumar@linaro.org>
 <ZTeoGiMQZ-OoYJBG@kernkonzept.com>
 <20231025073634.4et5epfog25o2pxf@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025073634.4et5epfog25o2pxf@vireshk-i7>
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

On Wed, Oct 25, 2023 at 01:06:34PM +0530, Viresh Kumar wrote:
> Thanks a lot for taking this up, really appreciate it Stephan.
> 
> On 24-10-23, 13:18, Stephan Gerhold wrote:
> > Unfortunately this patch breaks scaling the performance state of the
> > virtual genpd devices completely. As far as I can tell it just keeps
> > setting level = 0 for every OPP switch (this is on MSM8909 with [1],
> > a single "perf" power domain attached to the CPU):
> > 
> > [  457.252255] cpu cpu0: _set_opp: switching OPP: Freq 998400000 -> 799999804 Hz, Level 0 -> 0, Bw 3200000 -> 1600000
> > [  457.253739] genpd genpd:1:cpu0: _set_opp: switching OPP: Freq 998400000 -> 799999804 Hz, Level 0 -> 0, Bw 3200000 -> 1600000
> 
> The thing I was more worried about worked fine it seems (recursively calling
> dev_pm_opp_set_opp() i.e.).
> 
> > [  457.304581] cpu cpu0: _set_opp: switching OPP: Freq 799999804 -> 533333202 Hz, Level 0 -> 0, Bw 1600000 -> 1600000
> > [  457.306091] genpd genpd:1:cpu0: _set_opp: switching OPP: Freq 799999804 -> 533333202 Hz, Level 0 -> 0, Bw 1600000 -> 1600000
> > [  457.323489] cpu cpu0: _set_opp: switching OPP: Freq 533333202 -> 399999902 Hz, Level 0 -> 0, Bw 1600000 -> 800000
> > [  457.352792] genpd genpd:1:cpu0: _set_opp: switching OPP: Freq 533333202 -> 399999902 Hz, Level 0 -> 0, Bw 1600000 -> 800000
> > [  457.353056] cpu cpu0: _set_opp: switching OPP: Freq 399999902 -> 199999951 Hz, Level 0 -> 0, Bw 800000 -> 800000
> > [  457.355285] genpd genpd:1:cpu0: _set_opp: switching OPP: Freq 399999902 -> 199999951 Hz, Level 0 -> 0, Bw 800000 -> 800000
> > 
> > Where do you handle setting the pstate specified in the "required-opps"
> > of the OPP table with this patch? I've looked at your changes for some
> > time but must admit I haven't really understood how it is supposed to
> > work. :-)
> 
> Thanks for the debug print, they helped me find the issue.
> 
> > [  457.304581] cpu cpu0: _set_opp: switching OPP: Freq 799999804 -> 533333202 Hz, Level 0 -> 0, Bw 1600000 -> 1600000
> > [  457.306091] genpd genpd:1:cpu0: _set_opp: switching OPP: Freq 799999804 -> 533333202 Hz, Level 0 -> 0, Bw 1600000 -> 1600000
> 
> The second line shouldn't have had freq/bw/etc, but just level. Hopefully this
> will fix it. Pushed to my branch too. Thanks. Please try again.
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 056b51abc501..cb2b353129c6 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1070,7 +1070,7 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
> 
>         while (index != target) {
>                 if (devs[index]) {
> -                       ret = dev_pm_opp_set_opp(devs[index], opp);
> +                       ret = dev_pm_opp_set_opp(devs[index], opp->required_opps[index]);
>                         if (ret)
>                                 return ret;
>                 }
> 

Thanks, this seems to work fine.

I found another small problem: In my OPP setup for MSM8916, some of the
required-opps point to an OPP with "opp-level = <0>" (see [1], the
<&rpmpd_opp_none> in the cpu-opp-table). This is because the vote for
the "CX" domain is for the CPU PLL clock source, which is only used for
the higher CPU frequencies (>= 998.4 MHz). With the previous code you
made it possible for me to vote for opp-level = <0> in commit
a5663c9b1e31 ("opp: Allow opp-level to be set to 0", discussion in [2]).
I think now it's broken because the _set_opp_level() added by Uffe
checks for if (!opp->level) as a sign that there is no opp-level defined
at all.

Based on my longer discussion with Uffe recently [3] it's not entirely
clear yet if I will still have the reference to &rpmpd_opp_none in the
future. Alternatively, we discussed describing this differently, e.g. as
a parent power domain (which would bypass most of the OPP code), or
moving it directly to an OPP table of CPU PLL device node (which would
only describe the actual "active" required-opps).

I'm not sure if anyone else has a reasonable use case for pointing to a
required-opp with opp-level = <0>, so we could potentially also postpone
solving this to later.

Thanks,
Stephan

[1]: https://github.com/msm8916-mainline/linux/commit/8880f39108206d7a60a0a8351c0373bddf58657c
[2]: https://lore.kernel.org/linux-pm/20200911092538.jexqm6joww67d4yv@vireshk-i7/
[3]: https://lore.kernel.org/linux-arm-msm/ZQGqfMigCFZP_HLA@gerhold.net/
