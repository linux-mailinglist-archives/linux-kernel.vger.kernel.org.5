Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57D67B7ECE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242322AbjJDMMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjJDMMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:12:17 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C555A9;
        Wed,  4 Oct 2023 05:12:13 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 394CC2Ha058447;
        Wed, 4 Oct 2023 07:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696421522;
        bh=2U6X4ob8Upv4VW4rnfSzUjHvNGpb82svTBKA67ZIUPw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=n7N3Du2uuoeDUrp36mBcNPMVmZZ1Kz2i2cLdpjW7/2IzG97cBZzXzpJ2ShOeWAG3e
         k48ZhXxwtN+B31HOG9kYxZy9CqVXUupyVBdO8CfvzUcIPVsX+XXud0Y/74JeGvlfik
         mDd8/b8sdFWQjLeNvT4W89AaK1KJtay3YjwtufTM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 394CC2VO025067
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Oct 2023 07:12:02 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Oct 2023 07:12:02 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Oct 2023 07:12:02 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 394CC2I8061790;
        Wed, 4 Oct 2023 07:12:02 -0500
Date:   Wed, 4 Oct 2023 07:12:02 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Nitin Yadav <n-yadav@ti.com>
CC:     <vigneshr@ti.com>, <rogerq@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] arm64: dts: ti: Add GPMC support for AM62x LP SK
Message-ID: <20231004121202.rqrpp6izwcpdggm5@obtrusive>
References: <20231004111238.3968984-1-n-yadav@ti.com>
 <20231004111238.3968984-2-n-yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231004111238.3968984-2-n-yadav@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:42-20231004, Nitin Yadav wrote:
> Add gpmc0 and elm0 nodes in k3-am62-main. Add GPMC0_CFG and

s/gpmc0/GPMC and elm0/ELM
Also a oneliner as to what GPMC and ELM are will be helpful.

> GPMC0_DATA entry in cbass_main node.
> 
> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 29 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62.dtsi      |  2 ++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index ac760d9b831d..f854369dfc27 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -965,4 +965,33 @@ mcasp2: audio-controller@2b20000 {
>  		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
>  		status = "disabled";
>  	};
> +	gpmc0: memory-controller@3b000000 {
> +		compatible = "ti,am64-gpmc";
> +		reg = <0x00 0x03b000000 0x00 0x400>,
> +		      <0x00 0x050000000 0x00 0x8000000>;
> +		reg-names = "cfg", "data";
> +		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&k3_clks 80 0>;
> +		clock-names = "fck";
> +		power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
> +		gpmc,num-cs = <3>;
> +		gpmc,num-waitpins = <2>;
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		status = "disabled";

As mentioned - document why disabled by default.

> +	};
> +
> +	elm0: ecc@25010000 {
> +		compatible = "ti,am3352-elm";
> +		reg = <0x00 0x25010000 0x00 0x2000>;
> +		interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&k3_clks 54 0>;
> +		clock-names = "fck";
> +		power-domains = <&k3_pds 54 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";

As mentioned - document why disabled by default.
> +	};
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
> index f1e15206e1ce..b9b1e522d74c 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
> @@ -77,6 +77,8 @@ cbass_main: bus@f0000 {
>  			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00010000>, /* OCSRAM */
>  			 <0x01 0x00000000 0x01 0x00000000 0x00 0x00310000>, /* A53 PERIPHBASE */
>  			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS0 DAT3 */
> +			 <0x00 0x3b000000 0x00 0x3b000000 0x00 0x00000400>, /* GPMC0 CFG */
> +			 <0x00 0x50000000 0x00 0x50000000 0x00 0x08000000>, /* GPMC0 DATA */

Why not keep it sorted?
>  
>  			 /* MCU Domain Range */
>  			 <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>,
> -- 
> 2.25.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
