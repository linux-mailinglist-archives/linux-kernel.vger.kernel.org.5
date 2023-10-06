Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC36A7BB6FA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbjJFLwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjJFLwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:52:50 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A783C5;
        Fri,  6 Oct 2023 04:52:48 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 396Bqf8s103787;
        Fri, 6 Oct 2023 06:52:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696593161;
        bh=tr9c/rUYC9mgA9/TX+5lWnVnFOuxhCvAshbr7tR4Pfw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=cMevrau7Cn7zoVIiXLjxat/qxpGboqYR18QPkPVI0p5EGPV+TnsnPtV6rBTxyJxGJ
         FJJtoC1vzqw+ktTNS7dieka8UJ3mNQooUh4okE1dahmrleCOGah7Xqgbc9V/RxnU2X
         +JwCDy+QPv+hV9p8vUExtMMvSMlwdx9ZMrGjgGWU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 396BqfZW120393
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Oct 2023 06:52:41 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Oct 2023 06:52:41 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Oct 2023 06:52:41 -0500
Received: from [10.249.131.134] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 396Bqb8D083191;
        Fri, 6 Oct 2023 06:52:38 -0500
Message-ID: <9e3489f0-98f4-48ac-89a8-ea4ad3ee115c@ti.com>
Date:   Fri, 6 Oct 2023 17:22:35 +0530
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
From:   "J, KEERTHY" <j-keerthy@ti.com>
In-Reply-To: <20231006113410.tibvxxkeuujqnbv4@evolution>
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



On 10/6/2023 5:04 PM, Nishanth Menon wrote:
> On 09:58-20231006, Keerthy wrote:
>> There are totally 2 instances of watchdog module in MCU domain.
>> These instances are coupled with the MCU domain R5F instances.
> 
>> Disabling them as they are not used by Linux.
> Device tree is hardware description - not tied to how Linux uses it.
> 
> Reason these wdts are disabled by default is because they are tightly
> coupled with R5Fs.
> 
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     | 24 +++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
>> index a7b5c4cb7d3e..809a0b1cf038 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
>> @@ -714,4 +714,28 @@
>>   		ti,esm-pins = <63>;
>>   		bootph-pre-ram;
>>   	};
>> +

Nishanth,

Below i have addressed the coupling with R5Fs & MCU domains watcdogs.

>> +	/*
>> +	 * The 2 RTI instances are couple with MCU R5Fs so keeping them
>> +	 * disabled as these will be used by their respective firmware
>> +	 */
>> +	mcu_watchdog0: watchdog@40600000 {
>> +		compatible = "ti,j7-rti-wdt";
>> +		reg = <0x00 0x40600000 0x00 0x100>;
>> +		clocks = <&k3_clks 367 1>;
>> +		power-domains = <&k3_pds 367 TI_SCI_PD_EXCLUSIVE>;
>> +		assigned-clocks = <&k3_clks 367 0>;
>> +		assigned-clock-parents = <&k3_clks 367 4>;
>> +		status = "disabled";
>> +	};
>> +
>> +	mcu_watchdog1: watchdog@40610000 {
>> +		compatible = "ti,j7-rti-wdt";
>> +		reg = <0x00 0x40610000 0x00 0x100>;
>> +		clocks = <&k3_clks 368 1>;
>> +		power-domains = <&k3_pds 368 TI_SCI_PD_EXCLUSIVE>;
>> +		assigned-clocks = <&k3_clks 368 0>;
>> +		assigned-clock-parents = <&k3_clks 368 4>;
> 
> Please DONOT ignore the review comments - I did ask the documentation in
> dts as well. reason being that this is what people will see rather than
> dig up the commit log. it should be intutive when reading the dts why
> nodes are disabled by default Vs the standard of leaving it enabled by
> default. Given esp that these peripherals do not have anything to do
> with board semantics (pinmux or something similar) to be complete.

As mentioned above. I added single comment for addressing both the 
watchdogs.

- Keerthy
> 
>> +		status = "disabled";
>> +	};
>>   };
>> -- 
>> 2.17.1
>>
> 
