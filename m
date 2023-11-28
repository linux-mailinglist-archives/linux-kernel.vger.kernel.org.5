Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C147FC482
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbjK1T6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjK1T6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:58:36 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7C41988;
        Tue, 28 Nov 2023 11:58:42 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ASJwXmp110777;
        Tue, 28 Nov 2023 13:58:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701201513;
        bh=LWN6v5FKtTG8d7oiQpM3iasrj1YmTLn/Pg9INJ+EZ4E=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=qUqZ/7WieKe0EnqYvIVtJNPGokjrWQl0BOKLx/EYZzKQnXLV3uaxYiIJFmWzUrPvH
         9kgpQRWYcqFWsRAmSfYaJ9CXvNUr0PN162LjGNSzOd7xdbuLd84vuytuQsdeRWvIzB
         FBSOqWOfKHotWx97ak94cYTX+qHw3Ad95bfY5Qw8=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ASJwXNU036315
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Nov 2023 13:58:33 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 Nov 2023 13:58:33 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 Nov 2023 13:58:33 -0600
Received: from [128.247.81.105] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ASJwXIi031771;
        Tue, 28 Nov 2023 13:58:33 -0600
Message-ID: <6eab794f-a5cf-455a-9b49-bc73259bd58e@ti.com>
Date:   Tue, 28 Nov 2023 13:58:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-am62a-main: Add sdhci0 instance
To:     Nitin Yadav <n-yadav@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231030063108.1242981-1-n-yadav@ti.com>
 <20231030063108.1242981-2-n-yadav@ti.com>
 <4953b4e5-0f9c-4a3a-ae69-40716750cb40@ti.com>
 <db70f42e-0296-4f36-ac97-2ecf38b84f51@ti.com>
Content-Language: en-US
From:   Judith Mendez <jm@ti.com>
In-Reply-To: <db70f42e-0296-4f36-ac97-2ecf38b84f51@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nitin,

On 11/27/23 10:39 PM, Nitin Yadav wrote:
> 
> 
> On 11/28/2023 3:11 AM, Judith Mendez wrote:
>> On 10/30/23 1:31 AM, Nitin Yadav wrote:
>>> Add sdhci0 DT node in k3-am62a-main for eMMC support. Droping
>>> ITAP values as they are NA in datasheet[0] for lower speed modes.
>>>
>>> [0]https://www.ti.com/lit/gpn/am62a3 Table: 7-79 (Page No. 179)
>>>
>>
>> Minor comment below. All else looks good to me.
>>
>> Reviewed by: Judith Mendez <jm@ti.com>
>>
>>> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
>>> ---
>>>    arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 19 +++++++++++++++++++
>>>    1 file changed, 19 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
>>> index de36abb243f1..89b8b7d302cd 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
>>> @@ -488,6 +488,25 @@ main_gpio1: gpio@601000 {
>>>            status = "disabled";
>>>        };
>>>    +    sdhci0: mmc@fa10000 {
>>> +        compatible = "ti,am62-sdhci";
>>> +        reg = <0x00 0xfa10000 0x00 0x260>, <0x00 0xfa18000 0x00 0x134>;
>>> +        interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
>>> +        power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
>>> +        clocks = <&k3_clks 57 5>, <&k3_clks 57 6>;
>>> +        clock-names = "clk_ahb", "clk_xin";
>>> +        assigned-clocks = <&k3_clks 57 6>;
>>> +        assigned-clock-parents = <&k3_clks 57 8>;
>>> +        mmc-hs200-1_8v;
>>> +        ti,trm-icp = <0x2>;
>>> +        ti,otap-del-sel-legacy = <0x0>;
>>> +        ti,otap-del-sel-mmc-hs = <0x0>;
>>> +        ti,otap-del-sel-hs200 = <0x6>;
>>
>> I am wondering why DDR52 speed mode was not added?
> plz refer datasheet. No mention of DDR52 in this revised addition.
I believe it is mentioned in the RIOT, not datasheet.

>>
>>> +        bus-width = <8>;
>>> +        ti,clkbuf-sel = <0x7>;
>>> +        status = "disabled";
>>> +    };
>>> +
>>>        sdhci1: mmc@fa00000 {
>>>            compatible = "ti,am62-sdhci";
>>>            reg = <0x00 0xfa00000 0x00 0x260>, <0x00 0xfa08000 0x00 0x134>;
>>
>> ~ Judith

