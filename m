Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09F77B7EBE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjJDMIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbjJDMIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:08:04 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9F0C1;
        Wed,  4 Oct 2023 05:08:00 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 394C7onA033627;
        Wed, 4 Oct 2023 07:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696421270;
        bh=cTaWn7aOQQcRdP4FK4kIyAVEm6ejG7Aq4t2yBjw0M6c=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=SJjFbI9/XFAAuNHoRqqiHLiK8LyCtzbmLgmvgQw+EEX0W5WEkhj+MHi+xl5NJi+af
         mpN8NOoEkkXRAjmwGe4Quq/E0BWpPno3o48rYkjn4dW5cpSGt1oHfgsMG/daciaqU/
         hG057+ceCWCt14yN2I/qPB/oSsougrE+3xkzSzuY=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 394C7oaW022964
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Oct 2023 07:07:50 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Oct 2023 07:07:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Oct 2023 07:07:49 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 394C7nZF020338;
        Wed, 4 Oct 2023 07:07:49 -0500
Date:   Wed, 4 Oct 2023 07:07:49 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     Nitin Yadav <n-yadav@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] arm64: dts: ti: Add GPMC support for AM62x LP SK
Message-ID: <20231004120749.p253uqn43s47qjud@blend>
References: <20231004111238.3968984-1-n-yadav@ti.com>
 <20231004111238.3968984-2-n-yadav@ti.com>
 <34845445-91d7-1cb9-3a75-bc591c6c1560@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <34845445-91d7-1cb9-3a75-bc591c6c1560@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:27-20231004, Roger Quadros wrote:
> 
> 
> On 4.10.2023 14.12, Nitin Yadav wrote:
> > Add gpmc0 and elm0 nodes in k3-am62-main. Add GPMC0_CFG and
> > GPMC0_DATA entry in cbass_main node.
> > 
> > Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> > ---
> >   arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 29 ++++++++++++++++++++++++
> >   arch/arm64/boot/dts/ti/k3-am62.dtsi      |  2 ++
> >   2 files changed, 31 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> > index ac760d9b831d..f854369dfc27 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> > @@ -965,4 +965,33 @@ mcasp2: audio-controller@2b20000 {
> >   		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
> >   		status = "disabled";
> >   	};
> 
> Please add blank line here.
> 
> > +	gpmc0: memory-controller@3b000000 {
> > +		compatible = "ti,am64-gpmc";
> > +		reg = <0x00 0x03b000000 0x00 0x400>,
> > +		      <0x00 0x050000000 0x00 0x8000000>;
> > +		reg-names = "cfg", "data";
> > +		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> > +		clocks = <&k3_clks 80 0>;
> > +		clock-names = "fck";
> > +		power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
> > +		gpmc,num-cs = <3>;
> > +		gpmc,num-waitpins = <2>;
> > +		#address-cells = <2>;
> > +		#size-cells = <1>;
> > +		interrupt-controller;
> > +		#interrupt-cells = <2>;
> > +		gpio-controller;
> > +		#gpio-cells = <2>;
> > +		status = "disabled";

Document why disabled by default.

> > +	};
> > +
> > +	elm0: ecc@25010000 {
> > +		compatible = "ti,am3352-elm";
> > +		reg = <0x00 0x25010000 0x00 0x2000>;
> > +		interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
> > +		clocks = <&k3_clks 54 0>;
> > +		clock-names = "fck";
> > +		power-domains = <&k3_pds 54 TI_SCI_PD_EXCLUSIVE>;
> > +		status = "disabled";

Document why disabled by default.

> > +	};
> >   };
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
> > index f1e15206e1ce..b9b1e522d74c 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
> > @@ -77,6 +77,8 @@ cbass_main: bus@f0000 {
> >   			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00010000>, /* OCSRAM */
> >   			 <0x01 0x00000000 0x01 0x00000000 0x00 0x00310000>, /* A53 PERIPHBASE */
> >   			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS0 DAT3 */
> > +			 <0x00 0x3b000000 0x00 0x3b000000 0x00 0x00000400>, /* GPMC0 CFG */
> > +			 <0x00 0x50000000 0x00 0x50000000 0x00 0x08000000>, /* GPMC0 DATA */
> >   			 /* MCU Domain Range */
> >   			 <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>,
> 
> -- 
> cheers,
> -roger

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
