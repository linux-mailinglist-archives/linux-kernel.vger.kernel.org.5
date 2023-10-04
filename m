Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98E17B7DC2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbjJDLEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241830AbjJDLEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:04:39 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED4ACE;
        Wed,  4 Oct 2023 04:04:35 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 394B4IFs011799;
        Wed, 4 Oct 2023 06:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696417458;
        bh=ZuhTM4eIuKAH9nVuWPonCXaxsjUYIfHKZ3Pl97CJrpY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=FW/WtSnpc8S8R888JYkbixZbu7QnJd8h6WpdBcHHg+m2KTlVQdFTqBmlcz7P3UIuw
         CZeMYMCtBSND/NDRsLdYLFG6bwelNinV5nF8pOTZetO71aqCm5wAd0XTG+SiCliSbj
         3jKPVme9JaA5V+YFm6ahl9vTAHfpH98aX0QBxdNs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 394B4IXV051881
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Oct 2023 06:04:18 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Oct 2023 06:04:17 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Oct 2023 06:04:17 -0500
Received: from [172.24.227.112] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 394B4DCX016288;
        Wed, 4 Oct 2023 06:04:13 -0500
Message-ID: <fdc21c4d-1465-4642-8fe3-d0fd97885cd0@ti.com>
Date:   Wed, 4 Oct 2023 16:34:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/5] arm64: dts: ti: k3-j784s4-main: Add WIZ and
 SERDES PHY nodes
To:     Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <a-bhatia1@ti.com>, <afd@ti.com>,
        <rogerq@kernel.org>, <s-vadapalli@ti.com>, <conor+dt@kernel.org>,
        <r-ravikumar@ti.com>, <sabiya.d@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230927121157.278592-1-j-choudhary@ti.com>
 <20230927121157.278592-3-j-choudhary@ti.com>
 <20230927122503.cskdfnair5jtprdl@pennant>
Content-Language: en-US
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20230927122503.cskdfnair5jtprdl@pennant>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello Nishanth,

On 27/09/23 17:55, Nishanth Menon wrote:
> On 17:41-20230927, Jayesh Choudhary wrote:
>> From: Siddharth Vadapalli <s-vadapalli@ti.com>
>>
>> J784S4 SoC has 4 Serdes instances along with their respective WIZ
>> instances. Add device-tree nodes for them and disable them by default.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> [j-choudhary@ti.com: fix serdes_wiz clock order & disable serdes refclk]
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 164 +++++++++++++++++++++
>>   1 file changed, 164 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> index 6d9a5a91fa75..a0e4d8808693 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> @@ -6,9 +6,19 @@
>>    */
>>   
>>   #include <dt-bindings/mux/mux.h>
>> +#include <dt-bindings/phy/phy.h>
>> +#include <dt-bindings/phy/phy-ti.h>
>>   
>>   #include "k3-serdes.h"
>>   
>> +/ {
>> +	serdes_refclk: clock-serdes {
>> +		#clock-cells = <0>;
>> +		compatible = "fixed-clock";
>> +		status = "disabled";
> 
> Document why disabled. - same for rest of default disabled nodes.

Okay I will add a comment here that the clock is coming from the board
but required here by serdes-wiz node. So keeping it disabled by default.

For serdes and serdes-wiz node, since there are multiple instances,
I will mention in the commit message that the nodes are incomplete
and phy link is added in the board file. Hence disabled by default.

Thanks,
-Jayesh

> 
>> +	};
>> +};
>> +
>>   &cbass_main {
>>   	msmc_ram: sram@70000000 {
>>   		compatible = "mmio-sram";
>> @@ -709,6 +719,160 @@ main_sdhci1: mmc@4fb0000 {
>>   		status = "disabled";
>>   	};
>>   
>> +	serdes_wiz0: wiz@5060000 {
>> +		compatible = "ti,j784s4-wiz-10g";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		power-domains = <&k3_pds 404 TI_SCI_PD_EXCLUSIVE>;
>> +		clocks = <&k3_clks 404 2>, <&k3_clks 404 6>, <&serdes_refclk>, <&k3_clks 404 5>;
>> +		clock-names = "fck", "core_ref_clk", "ext_ref_clk", "core_ref1_clk";
>> +		assigned-clocks = <&k3_clks 404 6>;
>> +		assigned-clock-parents = <&k3_clks 404 10>;
>> +		num-lanes = <4>;
>> +		#reset-cells = <1>;
>> +		#clock-cells = <1>;
>> +		ranges = <0x5060000 0x00 0x5060000 0x10000>;
>> +		status = "disabled";
>> +
>> +		serdes0: serdes@5060000 {
>> +			compatible = "ti,j721e-serdes-10g";
>> +			reg = <0x05060000 0x010000>;
>> +			reg-names = "torrent_phy";
>> +			resets = <&serdes_wiz0 0>;
>> +			reset-names = "torrent_reset";
>> +			clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
>> +				 <&serdes_wiz0 TI_WIZ_PHY_EN_REFCLK>;
>> +			clock-names = "refclk", "phy_en_refclk";
>> +			assigned-clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
>> +					  <&serdes_wiz0 TI_WIZ_PLL1_REFCLK>,
>> +					  <&serdes_wiz0 TI_WIZ_REFCLK_DIG>;
>> +			assigned-clock-parents = <&k3_clks 404 6>,
>> +						 <&k3_clks 404 6>,
>> +						 <&k3_clks 404 6>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			#clock-cells = <1>;
>> +			status = "disabled";
>> +		};
>> +	};
>> +
>> +	serdes_wiz1: wiz@5070000 {
>> +



> 
