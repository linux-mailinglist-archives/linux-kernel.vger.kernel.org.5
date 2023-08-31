Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB13778EECB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245351AbjHaNlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345232AbjHaNkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:40:53 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAFBCFC;
        Thu, 31 Aug 2023 06:40:50 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37VDegh9069977;
        Thu, 31 Aug 2023 08:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693489242;
        bh=Yii6LMs6wT7p4qSHIW4Z8XGQhDDMggLDfmaJlZfJHDU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=R4hFAPYQdEEmSHJ7cqyQ4+8CyU+4/W0zp6vaMCjMbwML9rZlNHSop0bwOAbHWyQrS
         xQqx6sn+grvf739y1etxw8DoUDvI8sJl0Suj1l8YYXfDDMpf1ND+5XOguEVCPCcMAP
         oE4bHsX89k2LDvrBh9inGAN7ErSUnSars1qFh2yc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37VDegiR027712
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Aug 2023 08:40:42 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 31
 Aug 2023 08:40:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 31 Aug 2023 08:40:42 -0500
Received: from [10.250.64.187] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37VDecaD085497;
        Thu, 31 Aug 2023 08:40:39 -0500
Message-ID: <78431d87-ea56-138b-d2f7-6b27b7d83dc1@ti.com>
Date:   Thu, 31 Aug 2023 19:10:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 4/5] arm64: dts: ti: k3-j721s2-main: Add main domain
 watchdog entries
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <kristo@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230830072622.19539-1-j-keerthy@ti.com>
 <20230830072622.19539-5-j-keerthy@ti.com>
 <20230831114830.oenlyvwyxbi2uerq@deserving>
From:   "J, KEERTHY" <j-keerthy@ti.com>
In-Reply-To: <20230831114830.oenlyvwyxbi2uerq@deserving>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/2023 5:18 PM, Nishanth Menon wrote:
> On 12:56-20230830, Keerthy wrote:
>> Add DT entries for main domain watchdog instances.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>> index 87841bcc509d..33276d31faa1 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>> @@ -1513,4 +1513,22 @@
>>   		reg = <0x0 0x700000 0x0 0x1000>;
>>   		ti,esm-pins = <344>, <345>;
>>   	};
>> +
>> +	watchdog0: watchdog@2200000 {
>> +		compatible = "ti,j7-rti-wdt";
>> +		reg = <0x0 0x2200000 0x0 0x100>;
>> +		clocks = <&k3_clks 286 1>;
>> +		power-domains = <&k3_pds 286 TI_SCI_PD_EXCLUSIVE>;
>> +		assigned-clocks = <&k3_clks 286 1>;
>> +		assigned-clock-parents = <&k3_clks 286 5>;
>> +	};
>> +
>> +	watchdog1: watchdog@2210000 {
>> +		compatible = "ti,j7-rti-wdt";
>> +		reg = <0x0 0x2210000 0x0 0x100>;
>> +		clocks = <&k3_clks 287 1>;
>> +		power-domains = <&k3_pds 287 TI_SCI_PD_EXCLUSIVE>;
>> +		assigned-clocks = <&k3_clks 287 1>;
>> +		assigned-clock-parents = <&k3_clks 287 5>;
>> +	};
> 
> Are these all the wdts in main domain - do define and leave the other wdts
> disabled as they are tightly coupled to other processors (and must be
> enabled by the OS running on them), but defining them allows us to reuse
> the definitions in OSes running on R5s (for instance) to reuse the same
> device definitions.

Hello Nishanth,

Okay. I will add all the remaining ones & keep them disabled.

Thanks for the feedback.

Regards,
Keerthy

> 
>>   };
>> -- 
>> 2.17.1
>>
> 
