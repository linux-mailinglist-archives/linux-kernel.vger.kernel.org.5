Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E79766375
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 06:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjG1E5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 00:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjG1E5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 00:57:39 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8A8272D;
        Thu, 27 Jul 2023 21:57:37 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36S4vBPw086367;
        Thu, 27 Jul 2023 23:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690520231;
        bh=7KfPzMctoM1hKbd1VRwbrfziLtIrdywYRquiBCsn8Zg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=OWadtPn/Mcbv/38l7p59UIxxBKhu1m4PJ+rSJma2TEbYwOaW8gKjVHCueup0OBG3p
         +T+/90u+rB441yaIWEJZYlHbPWrCpecPId6qRawvyqF5dh/L/JnH5IlKgVroAhoeQd
         +Met5tMw+WT1BoUexae90mvgm8yxYCXzo+egv5Ok=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36S4vAsD125711
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jul 2023 23:57:10 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jul 2023 23:57:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jul 2023 23:57:11 -0500
Received: from [172.24.227.112] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36S4v610004933;
        Thu, 27 Jul 2023 23:57:06 -0500
Message-ID: <dd50f1a2-bd64-ca08-bfb7-ef907291eee1@ti.com>
Date:   Fri, 28 Jul 2023 10:27:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 2/5] arm64: dts: ti: k3-j784s4: Add Main CPSW2G node
To:     Tony Lindgren <tony@atomide.com>, <s-vadapalli@ti.com>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>, <rogerq@kernel.org>,
        <a-bhatia1@ti.com>, <r-ravikumar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230721132029.123881-1-j-choudhary@ti.com>
 <20230721132029.123881-3-j-choudhary@ti.com>
 <20230724045032.GU5194@atomide.com>
Content-Language: en-US
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20230724045032.GU5194@atomide.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tony,

On 24/07/23 10:20, Tony Lindgren wrote:
> Hi,
> 
> * Jayesh Choudhary <j-choudhary@ti.com> [230721 13:21]:
>> From: Siddharth Vadapalli <s-vadapalli@ti.com>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> index 7ad152a1b90f..1e2a26ac9c65 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> @@ -252,6 +252,30 @@ vdd_sd_dv: regulator-TLV71033 {
>>   };
>>   
>>   &main_pmx0 {
>> +	main_cpsw2g_pins_default: main-cpsw2g-pins-default {
>> +		pinctrl-single,pins = <
>> +			J784S4_IOPAD(0x0b8, PIN_INPUT, 6) /* (AC34) MCASP1_ACLKX.RGMII1_RD0 */
>> +			J784S4_IOPAD(0x0a0, PIN_INPUT, 6) /* (AD34) MCASP0_AXR12.RGMII1_RD1 */
>> +			J784S4_IOPAD(0x0a4, PIN_INPUT, 6) /* (AJ36) MCASP0_AXR13.RGMII1_RD2 */
>> +			J784S4_IOPAD(0x0a8, PIN_INPUT, 6) /* (AF34) MCASP0_AXR14.RGMII1_RD3 */
>> +			J784S4_IOPAD(0x0b0, PIN_INPUT, 6) /* (AL33) MCASP1_AXR3.RGMII1_RXC */
>> +			J784S4_IOPAD(0x0ac, PIN_INPUT, 6) /* (AE34) MCASP0_AXR15.RGMII1_RX_CTL */
>> +			J784S4_IOPAD(0x08c, PIN_INPUT, 6) /* (AE35) MCASP0_AXR7.RGMII1_TD0 */
>> +			J784S4_IOPAD(0x090, PIN_INPUT, 6) /* (AC35) MCASP0_AXR8.RGMII1_TD1 */
>> +			J784S4_IOPAD(0x094, PIN_INPUT, 6) /* (AG35) MCASP0_AXR9.RGMII1_TD2 */
>> +			J784S4_IOPAD(0x098, PIN_INPUT, 6) /* (AH36) MCASP0_AXR10.RGMII1_TD3 */
>> +			J784S4_IOPAD(0x0b4, PIN_INPUT, 6) /* (AL34) MCASP1_AXR4.RGMII1_TXC */
>> +			J784S4_IOPAD(0x09c, PIN_INPUT, 6) /* (AF35) MCASP0_AXR11.RGMII1_TX_CTL */
>> +		>;
>> +	};
> 
> We are standardizing pinctrl-single to use pin group node naming with -pins
> suffix, so in this case main-cpsw2g-default-pins. The same applies for all
> pin group node names. And please use -pins also for a single pin groups as
> new pins may need to be added later on in some cases.
> 
> These changes are to make dtbs checks work for pinctrl-single yaml binding
> as we mostly use a generic compatible and don't want to add all kind of
> custom node name matches.
> 

Thanks for the review.

I am dropping this patch (2/5) based on the comments in [1].
But we will address your comments when we will add this node.

[1]: 
<https://lore.kernel.org/all/5f5269dd-3cff-6fff-909d-355c190001d2@ti.com/>

Warm Regards,
Jayesh
