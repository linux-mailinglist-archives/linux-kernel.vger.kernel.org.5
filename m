Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C014C7D9673
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345726AbjJ0LWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbjJ0LWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:22:22 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830349C;
        Fri, 27 Oct 2023 04:22:19 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39RBM4l5114884;
        Fri, 27 Oct 2023 06:22:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698405724;
        bh=xGwd4KsESQmxFHYv9r6OarCWMJIIIUBV9EueATH+2jI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=gYRODK/DXIEHVOttGrWUaFntGccu7H9tgQvM4QfHEOnnq7FAmjqyolH0h8/CV5geO
         WfYOqt61HBwjZQjpE/0XKlUeFW0FpTsGVsS04dgFvvvmrlVQEqv9kTKwLL+TCmye9M
         ItjWHYBOXFwlSfEdOBVgzLLNLfhn7tXSZqj39NLM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39RBM4WS107679
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Oct 2023 06:22:04 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 27
 Oct 2023 06:22:03 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 27 Oct 2023 06:22:03 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39RBM3T0052202;
        Fri, 27 Oct 2023 06:22:03 -0500
Date:   Fri, 27 Oct 2023 06:22:03 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Nitin Yadav <n-yadav@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am62a-main: Add sdhci0 instance
Message-ID: <20231027112203.wynnevanyqe7xxw7@lapel>
References: <20231027093950.1202549-1-n-yadav@ti.com>
 <20231027093950.1202549-2-n-yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231027093950.1202549-2-n-yadav@ti.com>
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

On 15:09-20231027, Nitin Yadav wrote:
> Add sdhci0 DT node in k3-am62a-main for eMMC support. Droping
> ITAP values as they are NA in datasheet[0] for lower speed modes.
> Add mmc0 alias for sdhci0 in k3-am62a7-sk.dts.
> 
> [0]https://www.ti.com/lit/gpn/am62a3 Table: 7-79 (Page No. 179)
> 
> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 19 +++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts   |  1 +
>  2 files changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> index de36abb243f1..89b8b7d302cd 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> @@ -488,6 +488,25 @@ main_gpio1: gpio@601000 {
>  		status = "disabled";
>  	};
>  
> +	sdhci0: mmc@fa10000 {
> +		compatible = "ti,am62-sdhci";
> +		reg = <0x00 0xfa10000 0x00 0x260>, <0x00 0xfa18000 0x00 0x134>;
> +		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 57 5>, <&k3_clks 57 6>;
> +		clock-names = "clk_ahb", "clk_xin";
> +		assigned-clocks = <&k3_clks 57 6>;
> +		assigned-clock-parents = <&k3_clks 57 8>;
> +		mmc-hs200-1_8v;
> +		ti,trm-icp = <0x2>;
> +		ti,otap-del-sel-legacy = <0x0>;
> +		ti,otap-del-sel-mmc-hs = <0x0>;
> +		ti,otap-del-sel-hs200 = <0x6>;
> +		bus-width = <8>;
> +		ti,clkbuf-sel = <0x7>;
> +		status = "disabled";
> +	};
> +
>  	sdhci1: mmc@fa00000 {
>  		compatible = "ti,am62-sdhci";
>  		reg = <0x00 0xfa00000 0x00 0x260>, <0x00 0xfa08000 0x00 0x134>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> index cff283c75f8e..5d28c390b28e 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> @@ -20,6 +20,7 @@ aliases {
>  		serial0 = &wkup_uart0;
>  		serial2 = &main_uart0;
>  		serial3 = &main_uart1;
> +		mmc0 = &sdhci0;

Bring this in on your second patch in the series.

>  		mmc1 = &sdhci1;
>  	};
>  
> -- 
> 2.25.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
