Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1C4809BD4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbjLHFkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbjLHFkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:40:05 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD451739;
        Thu,  7 Dec 2023 21:40:09 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B85dqqQ039463;
        Thu, 7 Dec 2023 23:39:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702013992;
        bh=+K65KvLFzHz/Rc30X2Bw0hmp4C+0eRKqc0nOFVLfWQM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=cHoayyKjK1GD8uydxmKGyCH4AEeS8nD837fDfnF8UCvzoZBtu8UFCBMljJF+7k2VG
         5royKeGk2YdqWEA22ZGmbtSCIZTjhHCC71h21XggG+d2XnSgbFVfvdUv28ReRSorbi
         h0NkKuM90x3hN0Fl1rewQjK6SDdNvVGjia3kFLHk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B85dqHV053524
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Dec 2023 23:39:52 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Dec 2023 23:39:52 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Dec 2023 23:39:52 -0600
Received: from [172.24.227.36] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B85dkwA050119;
        Thu, 7 Dec 2023 23:39:47 -0600
Message-ID: <35402c39-a089-404c-a1da-5b398ede793a@ti.com>
Date:   Fri, 8 Dec 2023 11:09:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/7] arm64: dts: ti: k3-j721e-sk: Add TPS6594 family
 PMICs
To:     Nishanth Menon <nm@ti.com>
CC:     "Kumar, Udit" <u-kumar1@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <a-nandan@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <eblanc@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <jpanis@baylibre.com>, <j-luthra@ti.com>,
        <vaishnav.a@ti.com>, <hnagalla@ti.com>, <devarsht@ti.com>,
        <sjg@chromium.org>, <trini@konsulko.com>
References: <20231205093439.2298296-1-n-francis@ti.com>
 <20231205093439.2298296-7-n-francis@ti.com>
 <20231205151647.vh6rlhro7qlwoerc@knelt>
 <5e22f8cb-1004-4bcc-9bd0-2c30180ba10e@ti.com>
 <cc2c3e97-e2c6-487b-91a5-c5f5fbe2c3bc@ti.com>
 <20231207134912.olfhmcz5kkbx47wo@landmine>
Content-Language: en-US
From:   Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20231207134912.olfhmcz5kkbx47wo@landmine>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth

On 07/12/23 19:19, Nishanth Menon wrote:
> On 11:01-20231207, Neha Malcom Francis wrote:
>> Hi Nishanth, Udit,
>>
>> On 07/12/23 10:12, Kumar, Udit wrote:
>>>
>>> On 12/5/2023 8:46 PM, Nishanth Menon wrote:
>>>> On 15:04-20231205, Neha Malcom Francis wrote:
>>>>> This patch adds support for TPS6594 PMIC family on wakeup I2C0 bus.
>>>>> These devices provide regulators (bucks and LDOs), but also GPIOs, a
>>>>> RTC, a watchdog, an ESM (Error Signal Monitor) which monitors the SoC
>>>>> error output signal, and a PFSM (Pre-configurable Finite State Machine)
>>>>> which manages the operational modes of the PMIC.
>>>>>
>>>>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>>>>> ---
>>>>>    arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 158 +++++++++++++++++++++++++
>>>>>    1 file changed, 158 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
>>>>> b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
>>>>> index 42fe8eee9ec8..e600825f7e78 100644
>>>>> --- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
>>>>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
>>>>> @@ -459,6 +459,13 @@ J721E_IOPAD(0x234, PIN_INPUT, 7) /* (U3)
>>>>> EXT_REFCLK1.GPIO1_12 */
>>>>>    };
>>>>>    &wkup_pmx0 {
>>>>> +    pmic_irq_pins_default: pmic-irq-default-pins {
>>>>> +        bootph-pre-ram;
>>>>> +        pinctrl-single,pins = <
>>>>> +            J721E_WKUP_IOPAD(0x0cc, PIN_INPUT, 7) /* (G28) WKUP_GPIO0_7 */
>>>>> +        >;
>>>>> +    };
>>>>> +
>>>>>        mcu_cpsw_pins_default: mcu-cpsw-default-pins {
>>>>>            pinctrl-single,pins = <
>>>>>                J721E_WKUP_IOPAD(0x84, PIN_INPUT, 0) /* (B24) MCU_RGMII1_RD0 */
>>>>> @@ -560,6 +567,157 @@ eeprom@51 {
>>>>>            compatible = "atmel,24c512";
>>>>>            reg = <0x51>;
>>>>>        };
>>>>> +
>>>>> +    tps659413: pmic@48 {
>>>>> +        bootph-pre-ram;
>>>> only for the leaf nodes. See
>>>> https://libera.irclog.whitequark.org/armlinux/2023-10-19
>>>
>>>
>>> AFAIK, please correct me, u-boot still needs in all nodes ?
>>>
>>
>> That's what I believe as well, is it better to have only the leaf nodes in
>> kernel and have U-Boot DTSI handle the parent bootph properties? If so I'll
>> send out v10 making change accordingly.
>>
> 
> Yes, u-boot today needs it in all nodes. BUT, u-boot needs to be fixed in
> line to obey the rules of the schema convention that Rob clarified in
> the discussion above.
> 
> The other choice is NOT to introduce new bootph properties till u-boot
> is fixed up (this is also why I haven't sent out further updates for
> bootph properties for kernel in this cycle).
> 

I think we can have it following kernel convention here and fix up in the U-Boot 
DTSI for this series since PMIC nodes are needed. Thanks!

-- 
Thanking You
Neha Malcom Francis
