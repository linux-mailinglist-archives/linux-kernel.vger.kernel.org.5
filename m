Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2802976DFCC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 07:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjHCFiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 01:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjHCFiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 01:38:10 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC191FF0;
        Wed,  2 Aug 2023 22:38:09 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3735bxdK024645;
        Thu, 3 Aug 2023 00:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691041079;
        bh=IOCqh9FyVxVhLGP96v4mKGC01bgIYtpBTvxSqSJ4/+o=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=XtCsRD5P3K+GJn+fSDNq0hQOir1haPH4L97G17H2G8okuTca1dhrVMjSQPji1QQ9a
         axyfofmA93ml2tGP05P8vzNSpvXib1yAlriVz1WlG+338mtaYEeesQBg1p+AXNFcHL
         qh8Szn5zpZbxhuWk5ShFB8kGNnLD8QeZd5HWthik=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3735bxGb094700
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 00:37:59 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 00:37:58 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 00:37:58 -0500
Received: from [172.24.227.112] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3735brsL128347;
        Thu, 3 Aug 2023 00:37:54 -0500
Message-ID: <24c8071f-3ec8-c0e5-8a18-7783cf7af092@ti.com>
Date:   Thu, 3 Aug 2023 11:07:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 2/5] arm64: dts: ti: k3-j784s4-main: Add WIZ and SERDES
 PHY nodes
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>
CC:     <s-vadapalli@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <a-bhatia1@ti.com>, <r-ravikumar@ti.com>,
        <sabiya.d@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230801070019.219660-1-j-choudhary@ti.com>
 <20230801070019.219660-3-j-choudhary@ti.com>
 <64ae76ef-a85a-7cc7-6bc3-a8ea46621d73@kernel.org>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <64ae76ef-a85a-7cc7-6bc3-a8ea46621d73@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Roger,

On 01/08/23 22:26, Roger Quadros wrote:
> 
> 
> On 01/08/2023 10:00, Jayesh Choudhary wrote:
>> From: Siddharth Vadapalli <s-vadapalli@ti.com>
>>
>> J784S4 SoC has 4 Serdes instances along with their respective WIZ
>> instances. Add device-tree nodes for them and disable them by default.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> [j-choudhary@ti.com: fix serdes_wiz clock order & disable serdes refclk]
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 172 +++++++++++++++++++++
>>   1 file changed, 172 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> index 8a816563706b..fbf5ab94d785 100644
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
>> +	serdes_refclk: serdes-refclk {
> 
> standard name should begin with clock
> 
>> +		#clock-cells = <0>;
>> +		compatible = "fixed-clock";
>> +		status = "disabled";
>> +	};
>> +};
>> +
>>   &cbass_main {
>>   	msmc_ram: sram@70000000 {
>>   		compatible = "mmio-sram";
>> @@ -709,6 +719,168 @@ main_sdhci1: mmc@4fb0000 {
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
>> +> +		status = "disabled";
>> +
> drop blank lines here and rest of this file where you set status to "disabled".
> 
>> +		serdes0: serdes@5060000 {
> 
> phy@5060000

According to the bindings, serdes is valid.
(./Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml)
It would throw dtbs_check errors with phy@.
If its a binding change that you are suggesting, then it can be picked
up later on for all platform at once.

So keeping it as serdes@50*0000 on all the suggested places.

> 
>> +			compatible = "ti,j721e-serdes-10g";
>> +			reg = <0x05060000 0x010000>;

[...]

>> +
>> +		serdes1: serdes@5070000 {
> 
> phy@5070000
>> +			compatible = "ti,j721e-serdes-10g";
>> +			reg = <0x05070000 0x010000>;
>> +			reg-names = "torrent_phy";

[...]

>> +
>> +		status = "disabled";
>> +
>> +		serdes2: serdes@5020000 {
> 
> phy@5020000
> 
>> +			compatible = "ti,j721e-serdes-10g";
>> +			reg = <0x05020000 0x010000>;

[...]

>> +		status = "disabled";
>> +
>> +		serdes4: serdes@5050000 {
> 
> phy@5050000
> 
>> +			/*

[...]
