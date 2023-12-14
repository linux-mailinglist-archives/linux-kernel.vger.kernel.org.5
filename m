Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694BD812E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443960AbjLNLap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443921AbjLNLan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:30:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3194B7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:30:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7E6C433C7;
        Thu, 14 Dec 2023 11:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702553449;
        bh=Fk0lWlyniz2h5a3rEQxROF0ImdCpeMxK4CdTL7O7dQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V4XPPGfs7RCX22aO8nbSp3XIZux1Lb2jKnmSf9SHDPgFiZMu5zgYkzmzL4PgIOH4t
         QuZ0eCyXprrpyBJQQgTMltqZ8ZVyWj4uTJDAphoVJ8oFckdNACOC0WGNKn9r04t2oq
         xltWlehbXiB67ZMAQWnrQoVj+DiZFHN+NBfjuvU1NjyfB2Ddu2aM8iXCgFRBLDoYay
         g16QEPXF4AC9zWT9gmFiFBsI33WYK0hPLPOcUfOEHPmaactnayJJez1VEVBtwiNR9Y
         JXNF0ItDpZyc3IIfSo37+EWJEtomFXaWoVDWCwsbw7IKpOoNzZjlXdqVxDxK0o7E4d
         aB6mka1O0ln2A==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rDjvR-0008HE-0v;
        Thu, 14 Dec 2023 12:30:46 +0100
Date:   Thu, 14 Dec 2023 12:30:45 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org,
        konrad.dybcio@linaro.org, vkoul@kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        quic_cang@quicinc.com
Subject: Re: [PATCH 00/16] Fix Qcom UFS PHY clocks
Message-ID: <ZXrnZeDYOsteY5zT@hovoldconsulting.com>
References: <20231214091101.45713-1-manivannan.sadhasivam@linaro.org>
 <ZXrVxmxY6wZprbBa@hovoldconsulting.com>
 <20231214103907.GL2938@thinkpad>
 <ZXrgWK5wZz6dAkKP@hovoldconsulting.com>
 <20231214111409.GB48078@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214111409.GB48078@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 04:44:09PM +0530, Manivannan Sadhasivam wrote:
> + Can
> 
> On Thu, Dec 14, 2023 at 12:00:40PM +0100, Johan Hovold wrote:
> > [ +CC: Shazad ]
> > 
> > On Thu, Dec 14, 2023 at 04:09:07PM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, Dec 14, 2023 at 11:15:34AM +0100, Johan Hovold wrote:
> > > > On Thu, Dec 14, 2023 at 02:40:45PM +0530, Manivannan Sadhasivam wrote:

> > Unless the PHY consumes CXO directly, it should not be included in the
> > binding as you are suggesting here.
> 
> PHY is indeed directly consuming CXO. That's why I included it in the binding.

Ok, good. It's a bit frustrating that people can even seem to agree on
answers to direct questions about that.
 
> > We discussed this at some length at the time with Bjorn and Shazad who
> > had access to the documentation and the conclusion was that, at least on
> > sc8280xp, the PHY does not use CXO directly and instead it should be
> > described as a parent to the UFS refclocks in the clock driver:
> > 
> > 	https://lore.kernel.org/lkml/Y2OEjNAPXg5BfOxH@hovoldconsulting.com/
> > 
> > The downstream devicetrees have a bad habit of including parent clocks
> > directly in the consumer node instead of modelling this in clock driver
> > also for other peripherals.
> >  
> 
> No, I can assure that you got the wrong info. UFS PHY consumes the clock
> directly from RPMh. It took me several days to dig through the UFS and PHY docs
> and special thanks to Can Guo from UFS team, who provided much valuable
> information about these clocks.

Sounds like you've done your research.

> > What exactly is wrong with those commits? We know that the controller
> > does not consume GCC_UFS_REF_CLKREF_CLK directly, but describing that as
> > such for now was a deliberate choice:
> > 
> > 	GCC_UFS_REF_CLKREF_CLK is the clock to the devices, but as we
> > 	don't represent the memory device explicitly it seems suitable
> > 	to use as "ref_clk" in the ufshc nodes - which would then match
> > 	the special handling of the "link clock" in the UFS driver.
> >  
> 
> No, GCC_UFS_REF_CLKREF_CLK is _not_ the clock to UFS devices. I haven't found
> information about this specific register in GCC. Initially I thought this is for
> enabling QREF clocks for the UFS MEM phy, but I haven't found the answer yet.

Just quoting Bjorn.

> But as I said earlier, reference clock to UFS devices comes directly from the
> controller and there is a specfic register for controlling that. Starting from
> SM8550, reference clock comes from RPMh.

Sure, but that was only part of what those commits did or claimed. Bjorn
also explicitly stated that those refclocks were sourced from CXO, even
though I now see a claim from Shazad in that thread claiming the
opposite:

	https://lore.kernel.org/all/Y2Imnf1+v5j5CH9r@hovoldconsulting.com/

Without access to docs I can only ask questions and try to do tedious
inferences from incomplete open sources (e.g. downstream devicetrees).

Johan
