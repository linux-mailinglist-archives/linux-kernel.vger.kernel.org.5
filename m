Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96CC7FB8B2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344168AbjK1K5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343778AbjK1K5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:57:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52556189
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:57:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8033C433C7;
        Tue, 28 Nov 2023 10:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701169043;
        bh=YneTLXB1mmfGNl3d0q1JaknL6gIyvE7m5Usmdw11fFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AD6s+RD+HhYX03u/xLI9X4ZvmMgS7DysGh94q+tZS3O1cAf+OBIcDcpYBkIiwr53Y
         EVosBvet6LVHec5YJbCJHj6TjLkISwR64UUZHY5DGWLvU6UmbP75XfBvyCpJeC86tP
         UjJTzPU8atfgF0MRQNDTRY2GoqpUGc+B7197fW3MtQEoi5ELJYg+R36Xd8rg075hPo
         1wFeEgfjh2L/KmdVr8uNtrPYuF78BwN0I1lnqoZocOYReov7Le4/gtEzelwIKcQDoq
         vY4rpwYWwcfiZQFQ1z0EgxF0xz5GNFoS8xetv+l/QEwPod/iNzgf6tvqUz+I10VQX9
         NKQe2+aV88aNA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r7vmo-0005v9-2v;
        Tue, 28 Nov 2023 11:57:51 +0100
Date:   Tue, 28 Nov 2023 11:57:50 +0100
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
Message-ID: <ZWXHrvUDnF2dMk6r@hovoldconsulting.com>
References: <20231122191335.3058-1-quic_kriskura@quicinc.com>
 <ZV9dYpTYRXn63tXe@hovoldconsulting.com>
 <1192d91f-11bf-44af-953a-14e08e2b6ca8@quicinc.com>
 <ZWCpGdJRexnk98IN@hovoldconsulting.com>
 <004ddc69-1566-4de4-b260-0fca96a9395f@quicinc.com>
 <ZWW_FOAKp95Cf9vN@hovoldconsulting.com>
 <18965bb9-7afa-4892-8b71-981ba29d2cd4@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18965bb9-7afa-4892-8b71-981ba29d2cd4@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 04:02:53PM +0530, Krishna Kurapati PSSNV wrote:

> >    >> My opinion would be to keep the power_event irq as mandatory and not to
> >> include the hs_phy_irq.
> > 
> > Ok, but you still need to explain why dropping hs_phy_irq is correct.
> > 
> > Until there's a clear answer to that, it seems we need to include it.
> 
> Sure, I agree with you. It should describe what hardware is capable of, 
> not what we choose to add in driver code. In that sense we can add the 
> hs_phy_irq to all targets.
> 
> In my next revision, I can do the following:
> 
> 	- anyOf:
> 	  - items:
> 	    - const: qusb2_phy
> 	  - items:
> 	    - const: dp_hs_phy_irq
> 	    - const: dm_hs_phy_irq
> 	- const: hs_phy_irq
> 	- const: pwr_event
> 	- const: ss_phy_irq	(optional)
> 
> A modified version of your suggestion should help cover all cases and 
> describe all DT's perfectly.

It may be better to spell out the permutations. Especially since there
are no platforms with both qusb2_phy and dp/dm as I thought when
mentioning the above. Using anyOf also makes it hard to specify
min/maxItems as you'll need to do.

So back to my initial proposal, with a slight modification moving
pwr_event first (e.g. as it is not a wakeup interrupt):

qusb2-:

	- const: pwr_event
	- const: qusb2_phy
	- const: ss_phy_irq	(optional)

qusb2:

	- const: pwr_event
	- const: hs_phy_irq
	- const: qusb2_phy
	- const: ss_phy_irq	(optional)

femto-:
	- const: pwr_event
	- const: dp_hs_phy_irq
	- const: dm_hs_phy_irq
	- const: ss_phy_irq	(optional)

femto:
	- const: pwr_event
	- const: hs_phy_irq
	- const: dp_hs_phy_irq
	- const: dm_hs_phy_irq
	- const: ss_phy_irq	(optional)

That ss_phy_irq is optional would be expressed as minItems being one
less than maxItems for each permutation.

Johan
