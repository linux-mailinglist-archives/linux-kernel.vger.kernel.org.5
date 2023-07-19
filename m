Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1F57591D6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjGSJnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjGSJml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:42:41 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6164D10D4;
        Wed, 19 Jul 2023 02:42:39 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36J9gTHx076518;
        Wed, 19 Jul 2023 04:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689759749;
        bh=s3JqLfrdGx1x8y1Vva++v2wD+YNm6mj7IFwgXaDdy/0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=F/zcQ59V/vYP/7vJSl4/K+2ewiNhSUhaZAAOp5Sptry9+dTj+yzeJaM1hjaWwmZo9
         7uHuPQZ5lk00XW+xlwhTFxMYrINRFwEA6KYw9btBNtCKRzPYd9iY+xiekjArNmB5WU
         Yv5691lqT9/yxN5YW4Xhs/E8uzWY56sY7g/gt/DQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36J9gTV8017464
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Jul 2023 04:42:29 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Jul 2023 04:42:28 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Jul 2023 04:42:28 -0500
Received: from [172.24.227.83] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36J9gOlJ038474;
        Wed, 19 Jul 2023 04:42:25 -0500
Message-ID: <cc1c4212-df44-61ca-2e34-2c3cd3a565cf@ti.com>
Date:   Wed, 19 Jul 2023 15:12:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-j721s2-main: Add main CPSW2G
 devicetree node
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <afd@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>
References: <20230710094328.1359377-1-s-vadapalli@ti.com>
 <20230710094328.1359377-2-s-vadapalli@ti.com>
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20230710094328.1359377-2-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/23 3:13 PM, Siddharth Vadapalli wrote:
> From: Kishon Vijay Abraham I <kishon@ti.com>
> 
> TI's J721S2 SoC has a MAIN CPSW2G instance of the CPSW Ethernet Switch.
> Add devicetree node for it.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 69 ++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index ed79ab3a3271..4d0d27e7ca1b 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -51,6 +51,12 @@ usb_serdes_mux: mux-controller@0 {
>                         mux-reg-masks = <0x0 0x8000000>; /* USB0 to SERDES0 lane 1/3 mux */
>                 };
>  
> +               phy_gmii_sel_cpsw: phy@34 {
> +                       compatible = "ti,am654-phy-gmii-sel";
> +                       reg = <0x34 0x4>;
> +                       #phy-cells = <1>;
> +               };
> +
>                 serdes_ln_ctrl: mux-controller@80 {
>                         compatible = "mmio-mux";
>                         reg = <0x80 0x10>;
> @@ -1039,6 +1045,69 @@ cpts@310d0000 {
>                 };
>         };
>  
> +       main_cpsw: ethernet@c200000 {
> +               compatible = "ti,j721e-cpsw-nuss";
> +               reg = <0x00 0xc200000 0x00 0x200000>;
> +               reg-names = "cpsw_nuss";
> +               ranges = <0x0 0x0 0x0 0xc200000 0x0 0x200000>;
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               dma-coherent;
> +               clocks = <&k3_clks 28 28>;
> +               clock-names = "fck";
> +               power-domains = <&k3_pds 28 TI_SCI_PD_EXCLUSIVE>;
> +
> +               dmas = <&main_udmap 0xc640>,
> +                      <&main_udmap 0xc641>,
> +                      <&main_udmap 0xc642>,
> +                      <&main_udmap 0xc643>,
> +                      <&main_udmap 0xc644>,
> +                      <&main_udmap 0xc645>,
> +                      <&main_udmap 0xc646>,
> +                      <&main_udmap 0xc647>,
> +                      <&main_udmap 0x4640>;
> +               dma-names = "tx0", "tx1", "tx2", "tx3",
> +                           "tx4", "tx5", "tx6", "tx7",
> +                           "rx";
> +
> +               status = "disabled";
> +
> +               ethernet-ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       main_cpsw_port1: port@1 {
> +                               reg = <1>;
> +                               ti,mac-only;
> +                               label = "port1";
> +                               phys = <&phy_gmii_sel_cpsw 1>;
> +                               status = "disabled";
> +                       };
> +               };
> +
> +               main_cpsw_mdio: mdio@f00 {
> +                       compatible = "ti,cpsw-mdio","ti,davinci_mdio";
> +                       reg = <0x00 0xf00 0x00 0x100>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       clocks = <&k3_clks 28 28>;
> +                       clock-names = "fck";
> +                       bus_freq = <1000000>;
> +                       status = "disabled";
> +               };
> +
> +               cpts@3d000 {
> +                       compatible = "ti,am65-cpts";
> +                       reg = <0x00 0x3d000 0x00 0x400>;
> +                       clocks = <&k3_clks 28 3>;
> +                       clock-names = "cpts";
> +                       interrupts-extended = <&gic500 GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "cpts";
> +                       ti,cpts-ext-ts-inputs = <4>;
> +                       ti,cpts-periodic-outputs = <2>;
> +               };
> +       };
> +
>         usbss0: cdns-usb@4104000 {
>                 compatible = "ti,j721e-usb";
>                 reg = <0x00 0x04104000 0x00 0x100>;


Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

-- 
Regards,
Ravi
