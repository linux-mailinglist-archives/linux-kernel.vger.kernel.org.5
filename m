Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A127FB0FD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 05:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343499AbjK1Eju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 23:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjK1Ejs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 23:39:48 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46AE1AA;
        Mon, 27 Nov 2023 20:39:54 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AS4dgkA059659;
        Mon, 27 Nov 2023 22:39:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701146382;
        bh=BNZOAwv/SFdsrT2BqbrYqFaB/sRl1v5LnNmh4JQIzAc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=qcY2SttznIS9s/Ck9ibmz/5A8z/3R2a71/E3uQujhJnkCM+TZnwuBvJKqs7WmEXDm
         JHPmrUDxANZN/xWJLvG2RM2kbSpkg1RkPMcRv7BdBaIogF3k6+D8vEqYPdYxIZBKnU
         Ig918gV6Kp7OHe657A0UtthtuZAcTQoWnf0MZ/DY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AS4dgBw092697
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Nov 2023 22:39:42 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Nov 2023 22:39:42 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Nov 2023 22:39:42 -0600
Received: from [10.250.148.120] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AS4daH4065850;
        Mon, 27 Nov 2023 22:39:37 -0600
Message-ID: <db70f42e-0296-4f36-ac97-2ecf38b84f51@ti.com>
Date:   Tue, 28 Nov 2023 10:09:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-am62a-main: Add sdhci0 instance
To:     Judith Mendez <jm@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231030063108.1242981-1-n-yadav@ti.com>
 <20231030063108.1242981-2-n-yadav@ti.com>
 <4953b4e5-0f9c-4a3a-ae69-40716750cb40@ti.com>
Content-Language: en-US
From:   Nitin Yadav <n-yadav@ti.com>
In-Reply-To: <4953b4e5-0f9c-4a3a-ae69-40716750cb40@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/2023 3:11 AM, Judith Mendez wrote:
> On 10/30/23 1:31 AM, Nitin Yadav wrote:
>> Add sdhci0 DT node in k3-am62a-main for eMMC support. Droping
>> ITAP values as they are NA in datasheet[0] for lower speed modes.
>>
>> [0]https://www.ti.com/lit/gpn/am62a3 Table: 7-79 (Page No. 179)
>>
> 
> Minor comment below. All else looks good to me.
> 
> Reviewed by: Judith Mendez <jm@ti.com>
> 
>> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
>> index de36abb243f1..89b8b7d302cd 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
>> @@ -488,6 +488,25 @@ main_gpio1: gpio@601000 {
>>           status = "disabled";
>>       };
>>   +    sdhci0: mmc@fa10000 {
>> +        compatible = "ti,am62-sdhci";
>> +        reg = <0x00 0xfa10000 0x00 0x260>, <0x00 0xfa18000 0x00 0x134>;
>> +        interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
>> +        power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
>> +        clocks = <&k3_clks 57 5>, <&k3_clks 57 6>;
>> +        clock-names = "clk_ahb", "clk_xin";
>> +        assigned-clocks = <&k3_clks 57 6>;
>> +        assigned-clock-parents = <&k3_clks 57 8>;
>> +        mmc-hs200-1_8v;
>> +        ti,trm-icp = <0x2>;
>> +        ti,otap-del-sel-legacy = <0x0>;
>> +        ti,otap-del-sel-mmc-hs = <0x0>;
>> +        ti,otap-del-sel-hs200 = <0x6>;
> 
> I am wondering why DDR52 speed mode was not added?
plz refer datasheet. No mention of DDR52 in this revised addition.
> 
>> +        bus-width = <8>;
>> +        ti,clkbuf-sel = <0x7>;
>> +        status = "disabled";
>> +    };
>> +
>>       sdhci1: mmc@fa00000 {
>>           compatible = "ti,am62-sdhci";
>>           reg = <0x00 0xfa00000 0x00 0x260>, <0x00 0xfa08000 0x00 0x134>;
> 
> ~ Judith
