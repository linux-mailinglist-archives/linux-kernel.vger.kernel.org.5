Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A734F7A687D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjISQAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjISQAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:00:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C476D93;
        Tue, 19 Sep 2023 09:00:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486CCC433C7;
        Tue, 19 Sep 2023 16:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695139202;
        bh=j+je6EwFfbrHn1KR+5qoIrxDj3ULQFaOMs2skufPBAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g5+YhxppFl6dvjbZSF4bFhD5v4Y0CEJZVqUV5jORmTYmswjX4vrY8resqsJekLw7T
         APp14MZcwyJoH4/8rCrH1CqDpkfk4myHnwOtP6y0tqhGvoh+QNZJHdju84GKNWbX2/
         Vic5cByP31d/V9MbMedBWyh8qEeTX86TGB8AIZ4fG5ioDVXWO0Q+yWcI+HXpXfh9/i
         dL+H9hatLi20JaanCXREKHKcuVuQRXpmUpT9tH+ZQjpY3yY1WKZ+r1u0JoxzAu3ws6
         oMtK4T/LfoC7aRGYfaY6zpRnDumzmulMTLvS5J25ivRFAs4A4rd5aqQ6yYylIUEaH3
         dn0/4BNPh6RqA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qid95-00013m-2H;
        Tue, 19 Sep 2023 18:00:16 +0200
Date:   Tue, 19 Sep 2023 18:00:15 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.5 30/36] arm64: dts: qcom: sc8280xp-x13s: Add
 camera activity LED
Message-ID: <ZQnFj6g4pbwMz69C@hovoldconsulting.com>
References: <20230908192848.3462476-1-sashal@kernel.org>
 <20230908192848.3462476-30-sashal@kernel.org>
 <ZP60ngCV3hhNZiX5@hovoldconsulting.com>
 <ZQjEEt7sB2M5EO53@sashalap>
 <ZQk8aJx268Soy4yH@hovoldconsulting.com>
 <ZQmc7hznPpIh6iwP@sashalap>
 <ZQmh-DaBTwMuOLHe@hovoldconsulting.com>
 <ZQm5woD5zwRIG9cf@sashalap>
 <ZQnA4o7G4A3YC-pe@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQnA4o7G4A3YC-pe@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 05:40:18PM +0200, Johan Hovold wrote:
> On Tue, Sep 19, 2023 at 11:09:54AM -0400, Sasha Levin wrote:
> > On Tue, Sep 19, 2023 at 03:28:24PM +0200, Johan Hovold wrote:
> > >On Tue, Sep 19, 2023 at 09:06:54AM -0400, Sasha Levin wrote:
> > >> On Tue, Sep 19, 2023 at 08:15:04AM +0200, Johan Hovold wrote:
> 
> > >> >Call it what you will, but please drop it. Otherwise by that logic you'd
> > >> >need to backport all devicetree patches (as well as most driver changes)
> > >> >since they ultimately aim at enabling hardware.
> > >>
> > >> Not all, only ones that re-use existing kernel driver but enable it for
> > >> new hardware (i.e. adding a new pci-id/usb-id/dts entries).
> > >
> > >Again, that's basically all our device-tree patches. And that can break
> > >in all sorts of ways. So again, please drop. This does not belong in
> > >stable.
> > 
> > This is part of the criteria we use to select patches, yes? If you have
> > an objection around this particular patch then please let me know, or if
> > you have an objection around hardware enablement patches in stable then
> > we can have a bigger discussion around that one.
> > 
> > However, just dropping this one for no particular reasonisn't the right
> > approach: we've been using this selection criteria for quite a few years
> > now.
> 
> This patch makes zero sense to backport. It's a place holder for a
> camera led that we may one day need. No one marked it for stable, no
> one wants it in stable, no one needs it in stable, yet you repeatedly
> refuse to drop it and keep wasting my time.
> 
> Backports, and especially your autosel ones, always come with a risk.
> And here there is ZERO upsides to that. Next time the feature you try to
> retroactively enable may not be as trivial and could cause real
> regressions.
> 
> We're on our knees dealing with development and review of stuff that
> people do want and need. And you keep pushing silly things like and
> spamming us with backports that no one asked for. I'm just baffled.

You also seem to have made up new stable kernel rules as adding device
tree nodes clearly doesn't fit the description in
stable-kernel-rules.rst:

	It must either fix a real bug that bothers people or just add a
	device ID.

(This used to say "New device IDs and quirks are also accepted.")

Johan
