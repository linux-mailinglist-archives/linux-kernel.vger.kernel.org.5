Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9547FB707
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjK1KUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjK1KUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:20:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7635189
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:20:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8A7C433C7;
        Tue, 28 Nov 2023 10:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701166840;
        bh=RWQ4oqqgHJ3ICm2hpPKNYpjBIge+3p/xB+tOFDs5NMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eaHRUk0ehNhq8VY3cH77WL9LJEMIls02t0rLxqblsykoX2aLe0T7ldvP5f2UEmXQP
         LF0pjMGXvE8keZeRAIFmeGYuPLqK7ahQuamy1SbIQ0C5GK6eO4aNl3GQzazN0nDcse
         WCRfqTndclieY7vIq57jBdizycgeQsGPmGN+m7Byqhbpq4JocPN5cH/LfttH+NOn9B
         px9IHT9/1bIkKrJ/0rySpY1D8SYfH5JV+QKe3BPQQel4PXODhMGhQ0AEV2bWPY94IH
         BisfxqYWGRMAPmjDbQcUXQHsBoUwerbC1mmQ4/TmB5KC/HASaYFhbEWBKRPq7S0gZP
         zhSVeYPBRGVTQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r7vDI-0005YI-2G;
        Tue, 28 Nov 2023 11:21:08 +0100
Date:   Tue, 28 Nov 2023 11:21:08 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Subject: Re: [PATCH 1/6] dt-bindings: usb: dwc3: Clean up hs_phy_irq in
 bindings
Message-ID: <ZWW_FOAKp95Cf9vN@hovoldconsulting.com>
References: <20231122191335.3058-1-quic_kriskura@quicinc.com>
 <ZV9dYpTYRXn63tXe@hovoldconsulting.com>
 <1192d91f-11bf-44af-953a-14e08e2b6ca8@quicinc.com>
 <ZWCpGdJRexnk98IN@hovoldconsulting.com>
 <004ddc69-1566-4de4-b260-0fca96a9395f@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004ddc69-1566-4de4-b260-0fca96a9395f@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 11:09:04PM +0530, Krishna Kurapati PSSNV wrote:
> >> Yes. From whatever targets I was able to find, only one of them didn't
> >> have the power_event irq. Rest all of them had. I will recheck that
> >> particular one again.
> > 
> > Please do. The driver polls the corresponding status register on all
> > platforms currently, and perhaps this interrupt can one day be used to
> > get rid of the polling.
> >   
> 
> Ok, I just rechecked and case is, I am not able to get my hands on the 
> doc. I can't say for sure that the target is missing the pwr_event 
> interrupt. I say we can safely add the target assuming pwr_event is 
> present for ipq9574. Every target so far even on downstream has this IRQ 
> present in hw.

Ok, good.

> >>> Now if the HS interrupt is truly unusable, I guess we can consider
> >>> dropping it throughout and the above becomes just three permutations
> >>> instead, which can even be expressed along the lines of:
> >>
> >> Infact, I wanted to do this but since you mentioned before that if HW
> >> has it, we must describe it, I kept it in. But since this functionality
> >> is confirmed to be mutually exclusive of qusb2/{dp/dm}, I am aligned to
> >> skip it in bindings and drop it in DT.
> > 
> > As I mentioned elsewhere, it depends on whether it can be used at all.
> > Not simply whether there is some other mechanism that can be used in its
> > stead. Such a decision should be left up to the implementation.
> > 
> > That's why I said "truly unusable" above. It's still not clear to me
> > whether that is the case or not.
> 
> I looked at the code of  4.4, 4.14/ 4.19/ 5.4/ 5.10/ 5.15/ 6.1 and none 
> of them implement the hs_phy_irq.

But again, that is completely irrelevant. As I've said numerous times
now, this is about what the hardware is capable of, not which
functionality a particular OS chooses to use.
 
> My opinion would be to keep the power_event irq as mandatory and not to 
> include the hs_phy_irq.

Ok, but you still need to explain why dropping hs_phy_irq is correct.

Until there's a clear answer to that, it seems we need to include it.

Johan
