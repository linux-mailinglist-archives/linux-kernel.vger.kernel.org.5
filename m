Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB79276B720
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbjHAOTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbjHAOTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:19:42 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7160411D;
        Tue,  1 Aug 2023 07:19:41 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 371EJWmQ072148;
        Tue, 1 Aug 2023 09:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690899572;
        bh=nVWlI/HS4LwqCMoMcbge8wdIh1CPIS0KW/87fcPZJDo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=R1GgYvcHuT7tdeYC2cDN0auDBSVYztjmCMn8bH9NaSB21StonbJVSzP1VL8YeDQg2
         2mIh5X85lA/y/uHouYOPH81WAK4cvYMO9puaQQtQtDcmOG05g9gWT7Zo4zfZliUZWp
         on5dScsf5Rd4qvy9cN+TFL88fbUCAYXhU+Ue6z54=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 371EJVmb032458
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Aug 2023 09:19:31 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Aug 2023 09:19:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Aug 2023 09:19:31 -0500
Received: from [10.250.36.161] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 371EJUUM045671;
        Tue, 1 Aug 2023 09:19:30 -0500
Message-ID: <28f8ea2c-05bb-d293-22cc-93b22ff203cc@ti.com>
Date:   Tue, 1 Aug 2023 09:19:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 1/5] arm64: dts: ti: k3-j784s4-main: Add system
 controller and SERDES lane mux
To:     Jayesh Choudhary <j-choudhary@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>
CC:     <s-vadapalli@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>, <a-bhatia1@ti.com>, <r-ravikumar@ti.com>,
        <sabiya.d@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230801070019.219660-1-j-choudhary@ti.com>
 <20230801070019.219660-2-j-choudhary@ti.com>
Content-Language: en-US
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230801070019.219660-2-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/23 2:00 AM, Jayesh Choudhary wrote:
> From: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> The system controller node manages the CTRL_MMR0 region.
> Add serdes_ln_ctrl node which is used for controlling the SERDES lane mux.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> [j-choudhary@ti.com: Fix serdes_ln_ctrl node]
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 40 ++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index 11f163e5cadf..8a816563706b 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -5,6 +5,10 @@
>    * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
> +#include <dt-bindings/mux/mux.h>
> +
> +#include "k3-serdes.h"
> +
>   &cbass_main {
>   	msmc_ram: sram@70000000 {
>   		compatible = "mmio-sram";
> @@ -26,6 +30,42 @@ l3cache-sram@200000 {
>   		};
>   	};
>   
> +	scm_conf: bus@100000 {
> +		compatible = "simple-bus";
> +		reg = <0x00 0x00100000 0x00 0x1c000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x00 0x00 0x00100000 0x1c000>;
> +
> +		serdes_ln_ctrl: mux-controller@4080 {
> +			compatible = "mmio-mux";

The parent is not a syscon node, this should be "reg-mux".

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/mux/reg-mux.yaml#n19

Andrew

> +			reg = <0x00004080 0x30>;
> +			#mux-control-cells = <1>;
> +			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
> +					<0x4088 0x3>, <0x408c 0x3>, /* SERDES0 lane2/3 select */
> +					<0x4090 0x3>, <0x4094 0x3>, /* SERDES1 lane0/1 select */
> +					<0x4098 0x3>, <0x409c 0x3>, /* SERDES1 lane2/3 select */
> +					<0x40a0 0x3>, <0x40a4 0x3>, /* SERDES2 lane0/1 select */
> +					<0x40a8 0x3>, <0x40ac 0x3>; /* SERDES2 lane2/3 select */
> +			idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>,
> +				      <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
> +				      <J784S4_SERDES0_LANE2_IP3_UNUSED>,
> +				      <J784S4_SERDES0_LANE3_USB>,
> +				      <J784S4_SERDES1_LANE0_PCIE0_LANE0>,
> +				      <J784S4_SERDES1_LANE1_PCIE0_LANE1>,
> +				      <J784S4_SERDES1_LANE2_PCIE0_LANE2>,
> +				      <J784S4_SERDES1_LANE3_PCIE0_LANE3>,
> +				      <J784S4_SERDES2_LANE0_IP2_UNUSED>,
> +				      <J784S4_SERDES2_LANE1_IP2_UNUSED>,
> +				      <J784S4_SERDES2_LANE2_QSGMII_LANE1>,
> +				      <J784S4_SERDES2_LANE3_QSGMII_LANE2>,
> +				      <J784S4_SERDES4_LANE0_EDP_LANE0>,
> +				      <J784S4_SERDES4_LANE1_EDP_LANE1>,
> +				      <J784S4_SERDES4_LANE2_EDP_LANE2>,
> +				      <J784S4_SERDES4_LANE3_EDP_LANE3>;
> +		};
> +	};
> +
>   	gic500: interrupt-controller@1800000 {
>   		compatible = "arm,gic-v3";
>   		#address-cells = <2>;
