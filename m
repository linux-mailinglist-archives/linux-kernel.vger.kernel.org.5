Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6CB774A01
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbjHHUKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjHHUJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:09:54 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8200527210;
        Tue,  8 Aug 2023 11:32:21 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378IW6xp062836;
        Tue, 8 Aug 2023 13:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691519526;
        bh=fX/sNFKyF1sSp1B1BKJh2rtMZvIKLQqD4XqA88vsY9U=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=YJaBGPe2w4HqYMMUmjND+adsatrfKGsYsQOR1riOE7Yy21KL725zdN0KbqQzQM2QL
         L5jtbtZ79upaz2dSKVFMYGRrA05Pohx/WgOo1zsHbpggmPXPsSUJGgOucvTsX8woCq
         /QgsVwS5Zq6s6OlQEa/uKCQAjBxOZdGNgzdvQe80=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378IW6pu083697
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 13:32:06 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 13:32:04 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 13:32:05 -0500
Received: from [10.24.69.34] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378IW11r128141;
        Tue, 8 Aug 2023 13:32:01 -0500
Message-ID: <feb5d534-1e1b-2b3d-6eff-22a362df08db@ti.com>
Date:   Wed, 9 Aug 2023 00:02:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/4] arm64: dts: ti: k3-j784s4-main: Add bootph-pre-ram
 property for SPL nodes
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar <u-kumar1@ti.com>, Hari Nagalla <hnagalla@ti.com>,
        Dasnavis Sabiya <sabiya.d@mistralsolutions.com>,
        Tom Rini <trini@konsulko.com>
References: <20230807185645.128751-1-a-nandan@ti.com>
 <20230807185645.128751-2-a-nandan@ti.com>
 <20230807190739.a33f5piskapfphxh@blatantly>
From:   Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <20230807190739.a33f5piskapfphxh@blatantly>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 08/08/23 00:37, Nishanth Menon wrote:
> On 00:26-20230808, Apurva Nandan wrote:
>> Add bootph-pre-ram property for all the nodes used in SPL stage,
>> for syncing it later to u-boot j784s4 dts.
>>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> ---
> We need to rework this a little more:
>
> The approach taken in this series is enable pre-ram for everything. I am
> not sure that is the right direction.
These patches only enable bootph-pre-ram for the nodes, that already had 
bootph-pre-ram property in u-boot dts
patches for j784s4. And these are selected after removing unnecessary 
nodes that had this property, so not added for
everything. Are there a nodes which seem to have unnecessary 
bootph-pre-ram property according to you, need to remove?
> https://github.com/devicetree-org/dt-schema/blob/e87ba2f515392c2a4694642063efb43023331ff6/dtschema/schemas/bootph.yaml#L70
>
> patch #1: board generic changes: patch #1
> patch #2-: board specific change (per board)
>
> Make sure you use the correct property and document why this is needed
> in the section added as well - esp for board generic changes introduced
> into SoC.dtsi files.
>
I am little unclear about what nodes you refer with board generic vs 
board specific bootph-pre-ram.
I have currently added bootph-pre-ram in board EVM dts files if the node 
is disabled in SoC dtsi and enabled
in EVM dts (no point adding bootph-pre-ram in disabled node), or for 
pinmuxes, etc. What is the segregation
you want in the patch, do you want some bootph-pre-ram to be moved from 
where they are?
>>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> index 2ea0adae6832..aaec569fe91a 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> @@ -6,6 +6,7 @@
>>    */
>>   
>>   &cbass_main {
>> +	bootph-pre-ram;
> Is this better done where the node is defined?
Okay, this I will fix.
>
>>   	msmc_ram: sram@70000000 {
>>   		compatible = "mmio-sram";
>>   		reg = <0x00 0x70000000 0x00 0x800000>;
>> @@ -670,6 +671,7 @@ main_sdhci1: mmc@4fb0000 {
>>   	};
>>   
>>   	main_navss: bus@30000000 {
>> +		bootph-pre-ram;
>>   		compatible = "simple-bus";
>>   		#address-cells = <2>;
>>   		#size-cells = <2>;
>> @@ -705,6 +707,7 @@ main_udmass_inta: msi-controller@33d00000 {
>>   		};
>>   
>>   		secure_proxy_main: mailbox@32c00000 {
>> +			bootph-pre-ram;
>>   			compatible = "ti,am654-secure-proxy";
>>   			#mbox-cells = <1>;
>>   			reg-names = "target_data", "rt", "scfg";
>> -- 
>> 2.34.1
>>
