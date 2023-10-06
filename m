Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963C27BB825
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjJFMyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjJFMyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:54:15 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B98C6;
        Fri,  6 Oct 2023 05:54:13 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 396Cs4Up083145;
        Fri, 6 Oct 2023 07:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696596844;
        bh=YU8W7O6+hD1MPnohczPpS2RQ1VLiwjTIGoWac3B88ms=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=aJrWXAAoo9KpVXdVRtv1qvrNDTtFNpxpYmGy2YwfuqeO0H3UmrGX1+EnUW8wfEKBG
         zn14yqYde/dYjm+yFz4kSDeFL+GL9+wFnA8ATpaD9p9h/E7/VXEHJ1opA29jQt+v1w
         5MuqgGjqpyOwSXzLux2WqEKjDDeaBrBHcLuSIFJA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 396Cs351063225
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Oct 2023 07:54:03 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Oct 2023 07:54:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Oct 2023 07:54:02 -0500
Received: from [10.249.131.134] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 396CrxLM116352;
        Fri, 6 Oct 2023 07:54:00 -0500
Message-ID: <d108104e-3ecd-43a9-b27f-4acd1c9e3c86@ti.com>
Date:   Fri, 6 Oct 2023 18:23:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/7] arm64: dts: ti: k3-j784s4-mcu: Add the mcu domain
 watchdog instances
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     <robh+dt@kernel.org>, <vigneshr@ti.com>, <conor+dt@kernel.org>,
        <kristo@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <u-kumar1@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231006042901.6474-1-j-keerthy@ti.com>
 <20231006042901.6474-6-j-keerthy@ti.com>
 <20231006113410.tibvxxkeuujqnbv4@evolution>
 <9e3489f0-98f4-48ac-89a8-ea4ad3ee115c@ti.com>
 <20231006120122.qkohphk6uq6kmxgm@pueblo>
From:   "J, KEERTHY" <j-keerthy@ti.com>
In-Reply-To: <20231006120122.qkohphk6uq6kmxgm@pueblo>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/2023 5:31 PM, Nishanth Menon wrote:
> On 17:22-20231006, J, KEERTHY wrote:
>>
>>
>> On 10/6/2023 5:04 PM, Nishanth Menon wrote:
>>> On 09:58-20231006, Keerthy wrote:
>>>> There are totally 2 instances of watchdog module in MCU domain.
>>>> These instances are coupled with the MCU domain R5F instances.
>>>
>>>> Disabling them as they are not used by Linux.
>>> Device tree is hardware description - not tied to how Linux uses it.
>>>
>>> Reason these wdts are disabled by default is because they are tightly
>>> coupled with R5Fs.
>>>
>>>>
>>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>>> ---
>>>>    .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     | 24 +++++++++++++++++++
>>>>    1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
>>>> index a7b5c4cb7d3e..809a0b1cf038 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
>>>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
>>>> @@ -714,4 +714,28 @@
>>>>    		ti,esm-pins = <63>;
>>>>    		bootph-pre-ram;
>>>>    	};
>>>> +
>>
>> Nishanth,
>>
>> Below i have addressed the coupling with R5Fs & MCU domains watcdogs.
>>
>>>> +	/*
>>>> +	 * The 2 RTI instances are couple with MCU R5Fs so keeping them
>>>> +	 * disabled as these will be used by their respective firmware
> 
> This description is best in the commit message
> 
>>>> +	 */
>>>> +	mcu_watchdog0: watchdog@40600000 {
>>>> +		compatible = "ti,j7-rti-wdt";
>>>> +		reg = <0x00 0x40600000 0x00 0x100>;
>>>> +		clocks = <&k3_clks 367 1>;
>>>> +		power-domains = <&k3_pds 367 TI_SCI_PD_EXCLUSIVE>;
>>>> +		assigned-clocks = <&k3_clks 367 0>;
>>>> +		assigned-clock-parents = <&k3_clks 367 4>;
>>>> +		status = "disabled";
>>>> +	};
>>>> +
>>>> +	mcu_watchdog1: watchdog@40610000 {
>>>> +		compatible = "ti,j7-rti-wdt";
>>>> +		reg = <0x00 0x40610000 0x00 0x100>;
>>>> +		clocks = <&k3_clks 368 1>;
>>>> +		power-domains = <&k3_pds 368 TI_SCI_PD_EXCLUSIVE>;
>>>> +		assigned-clocks = <&k3_clks 368 0>;
>>>> +		assigned-clock-parents = <&k3_clks 368 4>;
>>>
>>> Please DONOT ignore the review comments - I did ask the documentation in
>>> dts as well. reason being that this is what people will see rather than
>>> dig up the commit log. it should be intutive when reading the dts why
>>> nodes are disabled by default Vs the standard of leaving it enabled by
>>> default. Given esp that these peripherals do not have anything to do
>>> with board semantics (pinmux or something similar) to be complete.
>>
>> As mentioned above. I added single comment for addressing both the
>> watchdogs.
> 
> I missed it completely. Now that I think of it, I seem to have missed
> having seen it in previous rev reviews as well, and there is a reason
> for it: See [1] clarifying comment - nodes reserved for firmware usage
> have convention of "reserved" as status and documentation immediately
> above the status to help clarify the reason in-context. That is more
> readable than having to scroll up to find the rationale.
> 
> [1] https://lore.kernel.org/all/20231006114422.avymeap7h5ocs6zq@dreadlock/

Thanks Nishanth. I agree reserved is better and I will add a comment 
something like below:

/* Tightly coupled to R5F */
status = "reserved";

- Keerthy
> 
