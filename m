Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D537C4250
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343967AbjJJVVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343941AbjJJVVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:21:52 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CBDB6;
        Tue, 10 Oct 2023 14:21:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696972906; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Eju3DnedOvjzO+IZFalmsUPv3tvWnt8xuyPFJwyoZ4iXCRsfiqUbBKLKvqWwM/xS/u
    V/JaHPdwwf0zGr9X394ArruXuV/oNloYOOzIDJ7EVEy/fDQ1Pc7/+VuXVxPX6vGcnYUW
    jGfRrdcCREaRWle0kX8pZhssqD3vDZRT/WWXTMjTrHFn2/p5qDSlw7PLT+zwZYgmJp8y
    1+5OwXJdU4ValNa/WAOSiWzSb+zINVFU9FmpZGC1dWyVeGHhTnoHO3QRQC/ZBjqU527k
    UYAEM22r+EalUmnc7xNeYhi+qW9ZFE6VzA4ts5NTPBFR758skb06upiuoNw2+81Obo7I
    YI3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696972906;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Z0G7YFn68zpzzYW7nv1TpWBAXKa19eE/oq08c+ZlOB4=;
    b=kzcN4r5vQGD1k9HaVrJGPvyVmlMuXVL+69ScaN6kb2Nzcvn82K44u5nBmnfmrpOHxi
    yYU+7buEX006dQZ3av+34ZSbkRtfZmyqrJh/EtmmUf67TMWfyO7PFFMS9+OUf/kd9wEZ
    Wy9VD5AI6xzRjg4OsXOUSzch+65NchzDnx/E/RYBLx3O/RCkmx8q1OUBVoTZ9l6VaQTz
    UteRTTJdoV0ln4dLXXqcdjgfddX2UB6z3Y3N+B+yd7HObjOTxsiSQYLjLhHnjR0T0Py/
    ZlJgZJTdFQ60gorvtrJEPa6Bm5Kufq+RtBMQGnwCaVuBx2O25xXfiQFYD1DThVQQDZKL
    rwYw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696972906;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Z0G7YFn68zpzzYW7nv1TpWBAXKa19eE/oq08c+ZlOB4=;
    b=UuOq2SteI9kK3+9DBADQAf9U2wX63qGdkmJohA7ijGqzrBPMdk+sTvHxHzcmE4VRrJ
    uxnR0BPIG508IP1p+bGEzEQTzyBDgBFkvlQfxjRKS8rD15XJk7vie6mVyu7aMw4KE+N0
    QQd4iIu8MMj7P7wX+Xkicb7Yo+xbnB7MLq5Pq4tS02xCekfkUokvFulQCgmnAcvzSGNW
    v+p/JImgYXxONUYdSRhSQlJtKg3ASWpneYpZKSou2UW+e33gxjpKedsEbXe0h9M6/V3L
    jU3YwHXlmwi9EGINeXYdnAjr6Si4R7vXAANYE69KsKwNne94jRSbPNU5NGWoE8U7qtE0
    GD+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696972906;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Z0G7YFn68zpzzYW7nv1TpWBAXKa19eE/oq08c+ZlOB4=;
    b=hGBP2fezXiO3V3EC57uKl/kXj2m9AD0GB4CnJlfWZpqk4mxGZRO6d2i75LpGB04YCS
    cE0JY8cGrBwRTa+aPrAA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z2L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z9ALLjUye
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 10 Oct 2023 23:21:45 +0200 (CEST)
Date:   Tue, 10 Oct 2023 23:21:39 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: qcom: smd: Disable unused clocks
Message-ID: <ZSXAY5mbXB7Gbz2x@gerhold.net>
References: <20231004-clk-qcom-smd-rpm-unused-v2-1-9a5281f324dc@kernkonzept.com>
 <bc8fa799-aa64-4b69-97ce-8f1872c8eb11@linaro.org>
 <ZSRfc_w19h-55Bib@gerhold.net>
 <da02414c-a151-464b-8976-d353c6da7b8e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da02414c-a151-464b-8976-d353c6da7b8e@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:45:15PM +0200, Konrad Dybcio wrote:
> On 10/9/23 22:15, Stephan Gerhold wrote:
> > On Fri, Oct 06, 2023 at 11:08:39PM +0200, Konrad Dybcio wrote:
> > > On 4.10.2023 14:10, Stephan Gerhold wrote:
> > > > At the moment, clk-smd-rpm forces all clocks on at probe time (for
> > > > "handoff"). However, it does not make the clk core aware of that.
> > > > 
> > > > This means that the clocks stay enabled forever if they are not used
> > > > by anything. We can easily disable them again after bootup has been
> > > > completed, by making the clk core aware of the state. This is
> > > > implemented by returning the current state of the clock in
> > > > is_prepared().
> > > > 
> > > > Checking the SPMI clock registers reveals that this allows the RPM to
> > > > disable unused BB/RF clocks. This reduces the power consumption quite
> > > > significantly and is also needed to allow entering low-power states.
> > > > 
> > > > As of commit d6edc31f3a68 ("clk: qcom: smd-rpm: Separate out
> > > > interconnect bus clocks") the interconnect-related clocks are no longer
> > > > managed/exposed by clk-smd-rpm. Also the BI_TCXO_AO clock is now
> > > > critical (and never disabled).
> > > > 
> > > > There is still a slight chance that this change will break boot on some
> > > > devices. However, this will be most likely caused by actual mistakes in
> > > > the device tree (where required clocks were not actually specified).
> > > Precisely this, and solely as a consequence of the interconnect driver
> > > not covering all the required clocks (usually named GCC_SOME_NOC_XYZ_CLK,
> > > but there's quite a lot more).
> > > 
> > > For platforms without an interconnect driver, breaking stuff this **MOST
> > > LIKELY** means that Linux uses some hw that isn't voted for (e.g. missing
> > > crypto clock under scm or something).
> > > 
> > > For those with an interconnect driver, this will uncover issues that were
> > > previously hidden because of the smd-rpm interconnect being essentially
> > > broken for most of its existence. I can smell 660 breaking from however
> > > many miles you are away from me, but it's "good", as we were relying on
> > > (board specific) magic..
> > > 
> > > I've been carrying an equivalent patch in my tree for over half a year now
> > > and IIRC 8996 was mostly fine. It's also a good idea to test suspend
> > > (echo mem > /sys/power/state) and wakeup.
> > > 
> > 
> > I didn't notice any problems on 8916 and 8909 either. :-)
> > 
> > > For reasons that I don't fully recall, I do have both .is_prepared and
> > > .is_enabled though..
> > > 
> > 
> > clk-smd-rpm doesn't have any .enable()/.disable() ops (only .prepare()
> > and .unprepare()) so I don't think is_enabled is needed. For the unused
> > clock cleanup in drivers/clk/clk.c (clk_disable_unused()) we just care
> > about the clk_unprepare_unused_subtree() part. That part is run when the
> > clock reports true in .is_prepared(). The equivalent for .is_enabled()
> > would just be a no-op because there are no .enable()/.disable() ops.
> Oh I found out why :D
> 
> """
> The RPM clock enabling state can be found with 'enabled' in struct
> clk_smd_rpm. Add .is_enabled hook so that clk_summary in debugfs
> can a correct enabling state for RPM clocks.
> """
> 

I see, thanks! I think you should see at least the "prepared" state with
this patch. I'm not entirely convinced we should implement .is_enabled()
if we don't actually do anything on .enable()/.disable().

Anyway, given that the debugfs state is not directly related to the main
objective of disabling unused clocks I think that would be better
discussed in a separate patch later. :)

Thanks,
Stephan
