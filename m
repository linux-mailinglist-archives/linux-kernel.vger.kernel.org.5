Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71AB7728EA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjHGPTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjHGPTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:19:03 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F06010F6;
        Mon,  7 Aug 2023 08:19:02 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377FIqAV054763;
        Mon, 7 Aug 2023 10:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691421532;
        bh=Dz24on+wEQPpYN6Xa5J23UHkSkIVtlonN1jK6mdXl1U=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=aZ6cH+kLLO3iUkG3h0WaNDlO+IXT8BHHOfYn1YyAt4ArzSKLNVxHumvOffUIhNFCL
         Ard5U9FwfM6l6qkinxzHo2ps67N8WBoHHIdsgVt29diwn99wJHFI+0a4PD5uzGoqUb
         HQW9N0zVgI+Sti46hYTavBv3JAQFIY0YKQpyTHHQ=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377FIqoP110743
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 10:18:52 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 10:18:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 10:18:52 -0500
Received: from [10.250.36.243] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377FIp5v017993;
        Mon, 7 Aug 2023 10:18:51 -0500
Message-ID: <627ed411-a6f7-cbc9-d48f-2678bf63c609@ti.com>
Date:   Mon, 7 Aug 2023 10:18:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 04/13] arm64: dts: ti: k3-am65: Enable OSPI nodes at the
 board level
Content-Language: en-US
To:     Dhruva Gole <d-gole@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230802205309.257392-1-afd@ti.com>
 <20230802205309.257392-5-afd@ti.com>
 <bb87effc-00c3-7d97-08c9-68408f9c514c@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <bb87effc-00c3-7d97-08c9-68408f9c514c@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/23 1:16 AM, Dhruva Gole wrote:
> Hi Andrew,
> 
> On 03/08/23 02:23, Andrew Davis wrote:
>> OSPI nodes defined in the top-level AM65x SoC dtsi files are incomplete
>> and may not be functional unless they are extended with pinmux and
>> device information.
>>
>> As the attached OSPI device is only known about at the board integration
>> level, these nodes should only be enabled when provided with this
>> information.
>>
>> Disable the OSPI nodes in the dtsi files and only enable the ones that
>> are actually pinned out on a given board.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 1 +
>>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            | 2 ++
>>   arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 1 +
>>   3 files changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>> index e26bd988e5224..6041862d5aa75 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>> @@ -593,6 +593,7 @@ adc {
>>   };
>>   &ospi0 {
>> +    status = "okay";
> 
> Ok, so this k3-am65-iot2050 series of DT files seem to be structured in
> a bit different manner than our SKs and EVMs?
> 
> The terminologies like advanced, advanced-m2, basic, etc. are a little
> confusing to me. However, I am wondering if we don't do any status = ..
> here, and rather make ospi status okays from the iot2050 dts files?
> 
> Pardon me if I am making an invalid suggestion, I don't have much
> background on these boards.
> 

This is a valid question, and yes the IOT2050 DTS organization is
slightly different than the one we use with our SK/EVMs.

The way these DT files tend to work is layering more functionality
or information in each file, starting with the core/most common
in the base .dtsi, and ending with .dts that is specific to a given
board. (In that way I would consider instances of "/delete-node/"
to be an indicator of bad layering, but that is a different topic..)

Any node that is only partially defined in a layer should be marked
disabled, and then only enabled in the layer that finally completes
the node. That is often the pinmux info at the board level.

In this case, the OSPI nodes are complete after this point, there
is no additional information given in the DTS files, so we can
enable it here in this .dtsi file.

Andrew

>>       pinctrl-names = "default";
>>       pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
>> index 7b1f94a89eca8..2c9c20a9d9179 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
>> @@ -295,6 +295,7 @@ ospi0: spi@47040000 {
>>               power-domains = <&k3_pds 248 TI_SCI_PD_EXCLUSIVE>;
>>               #address-cells = <1>;
>>               #size-cells = <0>;
>> +            status = "disabled";
>>           };
>>           ospi1: spi@47050000 {
>> @@ -309,6 +310,7 @@ ospi1: spi@47050000 {
>>               power-domains = <&k3_pds 249 TI_SCI_PD_EXCLUSIVE>;
>>               #address-cells = <1>;
>>               #size-cells = <0>;
>> +            status = "disabled";
>>           };
>>       };
>> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>> index 973a89b04a22f..43de7c132d343 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>> @@ -530,6 +530,7 @@ &mcu_r5fss0_core1 {
>>   };
>>   &ospi0 {
>> +    status = "okay";
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
> 
