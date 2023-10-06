Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FA17BB721
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjJFMBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjJFMBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:01:31 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC97BE4;
        Fri,  6 Oct 2023 05:01:29 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 396C1MdI105328;
        Fri, 6 Oct 2023 07:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696593682;
        bh=lpD2epWNlmiS8XYq+aJ7VOLQ2+oJck78368nfWClxjI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=pwuld3sXHg6btu5ribAn9L4pEvYqbAA6wkP2e1Zimg9ZRuWjlCbNLGeII1WhmAnAd
         42/SI6FvGoKbpvZMJja090NvkC/jxi/f8LKJQ9x0HFvTIjvZafStlhCiHNgHKUtdef
         tFACG0/6JM1/wtHdzI+/lTdFgf6HrIEA7l0kgdjc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 396C1MPV125837
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Oct 2023 07:01:22 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Oct 2023 07:01:22 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Oct 2023 07:01:22 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 396C1MHN032309;
        Fri, 6 Oct 2023 07:01:22 -0500
Date:   Fri, 6 Oct 2023 07:01:22 -0500
From:   Nishanth Menon <nm@ti.com>
To:     "J, KEERTHY" <j-keerthy@ti.com>
CC:     <robh+dt@kernel.org>, <vigneshr@ti.com>, <conor+dt@kernel.org>,
        <kristo@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <u-kumar1@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 5/7] arm64: dts: ti: k3-j784s4-mcu: Add the mcu domain
 watchdog instances
Message-ID: <20231006120122.qkohphk6uq6kmxgm@pueblo>
References: <20231006042901.6474-1-j-keerthy@ti.com>
 <20231006042901.6474-6-j-keerthy@ti.com>
 <20231006113410.tibvxxkeuujqnbv4@evolution>
 <9e3489f0-98f4-48ac-89a8-ea4ad3ee115c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9e3489f0-98f4-48ac-89a8-ea4ad3ee115c@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:22-20231006, J, KEERTHY wrote:
> 
> 
> On 10/6/2023 5:04 PM, Nishanth Menon wrote:
> > On 09:58-20231006, Keerthy wrote:
> > > There are totally 2 instances of watchdog module in MCU domain.
> > > These instances are coupled with the MCU domain R5F instances.
> > 
> > > Disabling them as they are not used by Linux.
> > Device tree is hardware description - not tied to how Linux uses it.
> > 
> > Reason these wdts are disabled by default is because they are tightly
> > coupled with R5Fs.
> > 
> > > 
> > > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > > ---
> > >   .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     | 24 +++++++++++++++++++
> > >   1 file changed, 24 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> > > index a7b5c4cb7d3e..809a0b1cf038 100644
> > > --- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> > > +++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> > > @@ -714,4 +714,28 @@
> > >   		ti,esm-pins = <63>;
> > >   		bootph-pre-ram;
> > >   	};
> > > +
> 
> Nishanth,
> 
> Below i have addressed the coupling with R5Fs & MCU domains watcdogs.
> 
> > > +	/*
> > > +	 * The 2 RTI instances are couple with MCU R5Fs so keeping them
> > > +	 * disabled as these will be used by their respective firmware

This description is best in the commit message

> > > +	 */
> > > +	mcu_watchdog0: watchdog@40600000 {
> > > +		compatible = "ti,j7-rti-wdt";
> > > +		reg = <0x00 0x40600000 0x00 0x100>;
> > > +		clocks = <&k3_clks 367 1>;
> > > +		power-domains = <&k3_pds 367 TI_SCI_PD_EXCLUSIVE>;
> > > +		assigned-clocks = <&k3_clks 367 0>;
> > > +		assigned-clock-parents = <&k3_clks 367 4>;
> > > +		status = "disabled";
> > > +	};
> > > +
> > > +	mcu_watchdog1: watchdog@40610000 {
> > > +		compatible = "ti,j7-rti-wdt";
> > > +		reg = <0x00 0x40610000 0x00 0x100>;
> > > +		clocks = <&k3_clks 368 1>;
> > > +		power-domains = <&k3_pds 368 TI_SCI_PD_EXCLUSIVE>;
> > > +		assigned-clocks = <&k3_clks 368 0>;
> > > +		assigned-clock-parents = <&k3_clks 368 4>;
> > 
> > Please DONOT ignore the review comments - I did ask the documentation in
> > dts as well. reason being that this is what people will see rather than
> > dig up the commit log. it should be intutive when reading the dts why
> > nodes are disabled by default Vs the standard of leaving it enabled by
> > default. Given esp that these peripherals do not have anything to do
> > with board semantics (pinmux or something similar) to be complete.
> 
> As mentioned above. I added single comment for addressing both the
> watchdogs.

I missed it completely. Now that I think of it, I seem to have missed
having seen it in previous rev reviews as well, and there is a reason
for it: See [1] clarifying comment - nodes reserved for firmware usage
have convention of "reserved" as status and documentation immediately
above the status to help clarify the reason in-context. That is more
readable than having to scroll up to find the rationale.

[1] https://lore.kernel.org/all/20231006114422.avymeap7h5ocs6zq@dreadlock/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
