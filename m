Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495EA7ADB85
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjIYPd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjIYPdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:33:52 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07D9120;
        Mon, 25 Sep 2023 08:33:45 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38PFXYRL088922;
        Mon, 25 Sep 2023 10:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695656014;
        bh=y45AVwdDr5vtzGfrRn85cJEZKPFbiBDw/Asq7anb5zM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=mwJveN+fmjRWlCdOxO2s/MCZheTtFo3FACQ20+Y5wc7J6TUvdPSKFFundYFy1EXdh
         BtinGb9tvYjX9Ytw+wbEgC5cOHWQjAVUim+JUjbFXHWmfi2qd9rhx2PeBIbgCuDYmN
         es1uvpSWaeWV3VkSAquCE6umgulnosDunrKTXtYM=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38PFXYb8016758
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Sep 2023 10:33:34 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Sep 2023 10:33:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Sep 2023 10:33:34 -0500
Received: from [10.249.131.134] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38PFXUmK044595;
        Mon, 25 Sep 2023 10:33:31 -0500
Message-ID: <9fef2589-c864-bcb9-be9d-435d6abd470c@ti.com>
Date:   Mon, 25 Sep 2023 21:03:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 5/7] arm64: dts: ti: k3-j784s4-mcu: Add the main domain
 watchdog instances
To:     Nishanth Menon <nm@ti.com>
CC:     <robh+dt@kernel.org>, <vigneshr@ti.com>, <conor+dt@kernel.org>,
        <kristo@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <u-kumar1@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230925081332.15906-1-j-keerthy@ti.com>
 <20230925081332.15906-6-j-keerthy@ti.com>
 <20230925131927.f7ff2u2ip3jxejyg@dreadful>
Content-Language: en-US
From:   "J, KEERTHY" <j-keerthy@ti.com>
In-Reply-To: <20230925131927.f7ff2u2ip3jxejyg@dreadful>
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



On 9/25/2023 6:49 PM, Nishanth Menon wrote:
> On 13:43-20230925, Keerthy wrote:
>> There are totally 2 instances of watchdog module in MCU domain.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     | 20 +++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
>> index a7b5c4cb7d3e..0b7cc277a567 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
>> @@ -714,4 +714,24 @@
>>   		ti,esm-pins = <63>;
>>   		bootph-pre-ram;
>>   	};
>> +
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
>> +		status = "disabled";
> 
> Explain in commit message as to why these are disabled. I believe it is
> because this RTI instances are tightly coupled to the micro
> controllers. but that information needs to be documented.

Sure. I will add that to the commit message.

>> +	};
>>   };
>> -- 
>> 2.17.1
>>
> 
