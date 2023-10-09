Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7073C7BEB66
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378572AbjJIUQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378520AbjJIUP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:15:59 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FC3B0;
        Mon,  9 Oct 2023 13:15:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696882555; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Qg+dZpi+/R1E4e4+pVxCWQsb3XD+L7ATn7IyaRI9b7KJo/coaIeKdZ+9v1NweIiCow
    zaaLwEQz6FJtwdZE0VlUccn1u5OhMaC410YbVtx11hwPE3kLDMWgXl0eBAc3YXnls0xF
    b4wZgpu7ngM6WJRzTZYME87DcS4wXy5BX7e4H7qnCFfq3GrxQ7BfWsHLq3s2pk+NMKIF
    4Yoiyv7dkDfqUN/fWCexhmOdB1kRJVKEJ3nq6apz/TLatTXg9KiQjmNzeBSgS78yJWar
    f9gifxW6dpXfWEK2Ka9HQtba+RSBcZujCqArfRu8+4PSGBzLbpZCrPcgTJntDe67agMP
    /e3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696882555;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=AYYFuvbioLJ/DNuT39655GA/XjuNrzG4+t4D6P7ZPxM=;
    b=bmIZqvCYezw3FgevxhjbBIAZGTRiYzWF9CpZ9pnC0IkM8a3GumW2xiJrzbkhQl/u1O
    ppFHKl8vIZsOToN3voj+AZHqAbmWpHDGFhkTNHnZXRWiNBMv1WHZqmTHPgMA2FeQ+dVA
    lro31YNnPa5UVrMxqV+yA90qT/vg5e/ymuZZmP6EFRrlVtz/6pGLOWIw0cP6O+2xGVA+
    Bw8DoG51zPC1LBOzZNmEnZHoYOeK4bHGuTVprsE/TR9U3rmWFTA1qugnBFvpkbh15BR1
    BW6lg2wm6E6ARIxZ6xbdA4wmrrkrPnJSGgOnHepurC0Ld9sYlI1X4JCqwvRyskFu85/U
    HSpA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696882555;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=AYYFuvbioLJ/DNuT39655GA/XjuNrzG4+t4D6P7ZPxM=;
    b=kemEecyB9igwhkxSNvuSZAWzJhyu/PlpE6TZnQP9oAPGADrnscYoBIfON49nj/ItcN
    sG62cdOITay1iDblYPpZuQP0Zab7JAfx90PMosr236VSHvo1gATG//CBuW1prvcds6ll
    mlfibzIHvzFqNOIp/O6sq8v7ScOmincmtNItfghyu+63EjTWIk3Y4J/ERaWsmhSe69C4
    6hE1NZqVTOdmsVjtyQAclsEYBzlCrjfK34ipv4DplhioCVfqLAXLhmgcVKS0DjK65Cl7
    uzoz1cjSNE70NqiUQk2yDQXc2FwFvr7xXartLN2IDngIi427QlDZ4kRTxM6zJ1lya6BH
    UXrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696882555;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=AYYFuvbioLJ/DNuT39655GA/XjuNrzG4+t4D6P7ZPxM=;
    b=9onSfLjRRRFSwCg4g4dOQ5szZ8bPhdei4mUguXpDJTrchNm3lAIINhjz2xAI0rK8Zw
    t7L+4gh7Tw+hS1E7czBQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA+p3h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z99KFsQBY
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 9 Oct 2023 22:15:54 +0200 (CEST)
Date:   Mon, 9 Oct 2023 22:15:47 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: qcom: smd: Disable unused clocks
Message-ID: <ZSRfc_w19h-55Bib@gerhold.net>
References: <20231004-clk-qcom-smd-rpm-unused-v2-1-9a5281f324dc@kernkonzept.com>
 <bc8fa799-aa64-4b69-97ce-8f1872c8eb11@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc8fa799-aa64-4b69-97ce-8f1872c8eb11@linaro.org>
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

On Fri, Oct 06, 2023 at 11:08:39PM +0200, Konrad Dybcio wrote:
> On 4.10.2023 14:10, Stephan Gerhold wrote:
> > At the moment, clk-smd-rpm forces all clocks on at probe time (for
> > "handoff"). However, it does not make the clk core aware of that.
> > 
> > This means that the clocks stay enabled forever if they are not used
> > by anything. We can easily disable them again after bootup has been
> > completed, by making the clk core aware of the state. This is
> > implemented by returning the current state of the clock in
> > is_prepared().
> > 
> > Checking the SPMI clock registers reveals that this allows the RPM to
> > disable unused BB/RF clocks. This reduces the power consumption quite
> > significantly and is also needed to allow entering low-power states.
> > 
> > As of commit d6edc31f3a68 ("clk: qcom: smd-rpm: Separate out
> > interconnect bus clocks") the interconnect-related clocks are no longer
> > managed/exposed by clk-smd-rpm. Also the BI_TCXO_AO clock is now
> > critical (and never disabled).
> > 
> > There is still a slight chance that this change will break boot on some
> > devices. However, this will be most likely caused by actual mistakes in
> > the device tree (where required clocks were not actually specified).
> Precisely this, and solely as a consequence of the interconnect driver
> not covering all the required clocks (usually named GCC_SOME_NOC_XYZ_CLK,
> but there's quite a lot more).
> 
> For platforms without an interconnect driver, breaking stuff this **MOST
> LIKELY** means that Linux uses some hw that isn't voted for (e.g. missing
> crypto clock under scm or something).
> 
> For those with an interconnect driver, this will uncover issues that were
> previously hidden because of the smd-rpm interconnect being essentially
> broken for most of its existence. I can smell 660 breaking from however
> many miles you are away from me, but it's "good", as we were relying on
> (board specific) magic..
> 
> I've been carrying an equivalent patch in my tree for over half a year now
> and IIRC 8996 was mostly fine. It's also a good idea to test suspend
> (echo mem > /sys/power/state) and wakeup.
> 

I didn't notice any problems on 8916 and 8909 either. :-)

> For reasons that I don't fully recall, I do have both .is_prepared and
> .is_enabled though..
> 

clk-smd-rpm doesn't have any .enable()/.disable() ops (only .prepare()
and .unprepare()) so I don't think is_enabled is needed. For the unused
clock cleanup in drivers/clk/clk.c (clk_disable_unused()) we just care
about the clk_unprepare_unused_subtree() part. That part is run when the
clock reports true in .is_prepared(). The equivalent for .is_enabled()
would just be a no-op because there are no .enable()/.disable() ops.

Thanks,
Stephan
