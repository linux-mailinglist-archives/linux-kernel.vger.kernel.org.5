Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07877650C9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjG0KT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbjG0KT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:19:26 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCF12685;
        Thu, 27 Jul 2023 03:19:13 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36RAIsd7071743;
        Thu, 27 Jul 2023 05:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690453134;
        bh=ooeccyvsVXfCMQ9wq+972jkA4kcsgxRzj3C2kH4HnLI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=D7ipi7EDOT4B9vmDtI/LDKiue8UuupiqqtCkb8UPHUJs7MZqfPowt7OqiBLauwK+d
         ANe+ZcqkfUOhcAEH1B0SdRgzOjf2xIdi7VKc0c/MI7qm3hTJY530it1NZaQ1SxN8Vs
         5WCHou2pUmr2wNX8BWST+G8sPwAgTs+IvmnhSDyM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36RAIsU7111544
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jul 2023 05:18:54 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jul 2023 05:18:53 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jul 2023 05:18:53 -0500
Received: from [172.24.227.112] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36RAImSJ012133;
        Thu, 27 Jul 2023 05:18:49 -0500
Message-ID: <5f5269dd-3cff-6fff-909d-355c190001d2@ti.com>
Date:   Thu, 27 Jul 2023 15:48:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 1/5] arm64: dts: ti: k3-j784s4-main: Add system
 controller and SERDES lane mux
To:     Nishanth Menon <nm@ti.com>, <s-vadapalli@ti.com>, <afd@ti.com>
CC:     <vigneshr@ti.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <kristo@kernel.org>, <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>, <a-bhatia1@ti.com>, <r-ravikumar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230721132029.123881-1-j-choudhary@ti.com>
 <20230721132029.123881-2-j-choudhary@ti.com>
 <20230724165220.kbjo7t5vthurqeuj@spokesman>
Content-Language: en-US
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20230724165220.kbjo7t5vthurqeuj@spokesman>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/07/23 22:22, Nishanth Menon wrote:
> On 18:50-20230721, Jayesh Choudhary wrote:
>> From: Siddharth Vadapalli <s-vadapalli@ti.com>
>>
>> The system controller node manages the CTRL_MMR0 region.
>> Add serdes_ln_ctrl node which is used for controlling the SERDES lane mux.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> [j-choudhary@ti.com: Fix serdes_ln_ctrl node]
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 40 ++++++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> index 11f163e5cadf..5a4da4eb8d3d 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> @@ -5,6 +5,10 @@
>>    * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
>>    */
>>   
>> +#include <dt-bindings/mux/mux.h>
>> +
>> +#include "k3-serdes.h"
>> +
>>   &cbass_main {
>>   	msmc_ram: sram@70000000 {
>>   		compatible = "mmio-sram";
>> @@ -26,6 +30,42 @@ l3cache-sram@200000 {
>>   		};
>>   	};
>>   
>> +	scm_conf: syscon@100000 {
>> +		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
> 
> Would'nt a simple-bus work?
> https://lore.kernel.org/all/20230605205220.rjmcsi5tjn4auqa7@arose/

For serdes_ln_ctrl it will be okay but for phy_gmii_sel,
we have dependency on [1].

So I will drop main_cpsw node (patch 2/5) and then re-spin it with
"simple-bus" compatible.
CPSW node can be taken up later on when the driver changes are in.


[1]: 
https://lore.kernel.org/all/b16568ec-0428-981b-01ca-571cc5d52704@ti.com/


Warm Regards,
Jayesh

