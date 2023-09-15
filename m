Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8DC7A1D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjIOLQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjIOLQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:16:51 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C444C189;
        Fri, 15 Sep 2023 04:16:45 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38FBGFs9004976;
        Fri, 15 Sep 2023 06:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694776575;
        bh=3iyqIz1bm5Ap2Jx3eiz+CK/eHKTJuDer271I8mtLQW4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=fySl1bYcuuZcNdtLhm3qG6VVnnfKnzPiwSsKR6xj/1Cb7tbQ4f1olro5Ywh/ZX8kL
         MbCo+BM1+iw70FeDNB3LULf0w22Wj9HPIjM3FMQGUZ0aZ9yN684MBUbs3Ah7GQniBD
         y3PTl88X5EDTqnwvwe5M1SJJQWihaIln7Pu4rWbg=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38FBGFcL013382
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Sep 2023 06:16:15 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Sep 2023 06:16:14 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Sep 2023 06:16:14 -0500
Received: from [10.250.135.44] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38FBG75X022097;
        Fri, 15 Sep 2023 06:16:08 -0500
Message-ID: <0994c10b-8805-7ce3-dc1b-13410b3a959c@ti.com>
Date:   Fri, 15 Sep 2023 14:16:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] arm64: dts: ti: Add GPMC NAND support
To:     Nitin Yadav <n-yadav@ti.com>, <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230913114711.2937844-1-n-yadav@ti.com>
 <20230913114711.2937844-2-n-yadav@ti.com>
Content-Language: en-US
From:   Roger Quadros <rogerq@ti.com>
In-Reply-To: <20230913114711.2937844-2-n-yadav@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nitin,

On 13.9.2023 14.47, Nitin Yadav wrote:
> Add support for AM62Q NAND card: X8 NAND EXPANSION
> BOARD card (PROC143E1) for AM62x LP SK board.

This patch is not adding NAND support but GPMC and ELM nodes.

> 
> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 29 ++++++++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-am62.dtsi      |  2 ++
>   2 files changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index 284b90c94da8..e93e79d8083f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -955,4 +955,33 @@ mcasp2: audio-controller@2b20000 {
>   		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
>   		status = "disabled";
>   	};
> +	gpmc0: memory-controller@3b000000 {
> +		status = "disabled";
> +		compatible = "ti,am64-gpmc";
> +		power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 80 0>;
> +		clock-names = "fck";
> +		reg = <0x00 0x03b000000 0x00 0x400>,
> +		      <0x00 0x050000000 0x00 0x8000000>;
> +		reg-names = "cfg", "data";
> +		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> +		gpmc,num-cs = <3>;
> +		gpmc,num-waitpins = <2>;
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +
> +	elm0: ecc@25010000 {
> +		status = "disabled";
> +		compatible = "ti,am3352-elm";
> +		reg = <0x00 0x25010000 0x00 0x2000>;
> +		interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 54 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 54 0>;
> +		clock-names = "fck";
> +	};
>   };
> diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
> index 11f14eef2d44..f7d8aad0a016 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
> @@ -76,6 +76,8 @@ cbass_main: bus@f0000 {
>   			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00010000>, /* OCSRAM */
>   			 <0x01 0x00000000 0x01 0x00000000 0x00 0x00310000>, /* A53 PERIPHBASE */
>   			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS0 DAT3 */
> +			 <0x00 0x3b000000 0x00 0x3b000000 0x00 0x00000400>, /* GPMC0_CFG */
> +			 <0x00 0x50000000 0x00 0x50000000 0x00 0x08000000>, /* GPMC0 DATA */
>   
>   			 /* MCU Domain Range */
>   			 <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>,

-- 
cheers,
-roger
