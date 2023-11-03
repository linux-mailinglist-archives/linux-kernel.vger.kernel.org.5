Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522E77E05A8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbjKCPhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjKCPhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:37:15 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B39112;
        Fri,  3 Nov 2023 08:37:10 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A3FatBx065864;
        Fri, 3 Nov 2023 10:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699025815;
        bh=Q7S2kxjniZff6GVxTh70DqyyUmdLrEpZMOjPB9erdF0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=knE/w82G7OPRQ6A8aEf2IkZH3Hs+CoG7rx+egEJWcUfr1Vc3tuZdnfrYbQfToWiWR
         XENrRe+7S4G/95LM4Jif7x7IXbkHUWa4lTwojU/xnWBSZ8CLmMmHDeXSmKQQlrmR8Q
         EcoNgEsl2qknuecEv+pjZk+yZZSfU1LOHDDXD7+E=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A3Fatr0030283
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Nov 2023 10:36:55 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 Nov 2023 10:36:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 Nov 2023 10:36:55 -0500
Received: from [10.250.33.210] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A3FasIU075856;
        Fri, 3 Nov 2023 10:36:54 -0500
Message-ID: <41489c26-75ae-4810-9668-47ab170836ea@ti.com>
Date:   Fri, 3 Nov 2023 10:36:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] arm64: dts: ti: k3-j721e: Use nvmem to model the
 efuses
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        "Vadapalli, Siddharth" <s-vadapalli@ti.com>,
        "Vardhan, Vibhore" <vibhore@ti.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20231025154339.1270246-1-afd@ti.com>
 <d4d79dea-2c7f-4160-9008-23f5bee1550a@ti.com>
Content-Language: en-US
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <d4d79dea-2c7f-4160-9008-23f5bee1550a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/23 11:25 PM, Vignesh Raghavendra wrote:
> + Siddharth for CSPW driver, + Vibhore of CPUFreq
> 
> On 25/10/23 21:13, Andrew Davis wrote:
>> The nvmem subsystem is used to model efuse areas. Currently our efuse
>> areas are described using raw syscon nodes and offsets into that. The
>> use case for this efuse area is to store the SoC Ethernet MAC address.
>> This is already such a commonly supported use case that both the nvmem
>> and networking subsystem have built-in support for it. Use that here
>> to get the following:
>>
>> 1. More standard, complete, and accurate description of this hardware
>>     efuse area.
>>
>> 2. Remove the need for this custom 'ti,syscon-efuse' property (which
>>     I'm surprised was accepted into the binding in the first place..)
>>
>> 3. Allow the parent node to not have to be a syscon which fixes a DT
>>     check warning.
>>
> 
> Sounds like a good plan to me.
> 
>> RFC for now as we don't have a simple generic compatible for memory
>> mapped nvmem areas. For now we use the 'uniphier-efuse' compatible
>> as it is essentially just a generic mmio nvmem area, which means any
>> generic area is technically "compatible".
>>
> 
> Looking at drivers/nvmem/ its seems like each SoC arch seems to have
> their own individual efuse driver?
> 

Yes, but I'm not sure I see the need for a whole new driver/compatible
for every simple MMIO-based efuse ranges. Would be nice to have a
generic one.

> For K3 SoCs (at least AM62), there are other properties in addition to
> MAC address in the eFUSE which are useful for different drivers such as
> Speed grades. Can this be extended for the same?
> 

Yes, with the "nvmem-layout" being worked on right now by the nvmem
folks I see a clear path to extend this over the rest of our efuse
area and replace the remaining "syscon" hacks we have been using.

Andrew

>> If this all is acceptable I'll split this patch into three and do
>> the same for all the other K3 devices still using this odd
>> 'ti,syscon-efuse' pattern for v1.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 24 ++++++++++++++++---
>>   1 file changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
>> index 05d6ef127ba78..8f488d43d49df 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
>> @@ -34,13 +34,30 @@ k3_reset: reset-controller {
>>   		};
>>   	};
>>   
>> -	mcu_conf: syscon@40f00000 {
>> -		compatible = "syscon", "simple-mfd";
>> +	mcu_conf: bus@40f00000 {
>> +		compatible = "simple-bus";
>>   		reg = <0x0 0x40f00000 0x0 0x20000>;
>>   		#address-cells = <1>;
>>   		#size-cells = <1>;
>>   		ranges = <0x0 0x0 0x40f00000 0x20000>;
>>   
>> +		efuse@200 {
>> +			compatible = "socionext,uniphier-efuse";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			reg = <0x200 0x40>;
>> +
>> +			nvmem-layout {
>> +				compatible = "fixed-layout";
>> +				#address-cells = <1>;
>> +				#size-cells = <1>;
>> +
>> +				mac_address: mac@0 {
>> +					reg = <0x0 0x6>;
>> +				};
>> +			};
>> +		};
>> +
>>   		phy_gmii_sel: phy@4040 {
>>   			compatible = "ti,am654-phy-gmii-sel";
>>   			reg = <0x4040 0x4>;
>> @@ -533,7 +550,8 @@ cpsw_port1: port@1 {
>>   				reg = <1>;
>>   				ti,mac-only;
>>   				label = "port1";
>> -				ti,syscon-efuse = <&mcu_conf 0x200>;
>> +				nvmem-cells = <&mac_address>;
>> +				nvmem-cell-names = "mac-address";
>>   				phys = <&phy_gmii_sel 1>;
>>   			};
>>   		};
> 
