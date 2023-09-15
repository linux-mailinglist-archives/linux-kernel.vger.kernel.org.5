Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305577A2340
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbjIOQHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbjIOQGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:06:54 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA891713;
        Fri, 15 Sep 2023 09:06:46 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38FG6Y7u129337;
        Fri, 15 Sep 2023 11:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694793994;
        bh=Di4g5ZMmzLpziKu6zXU+9iSn7viE+1WA24GPxVPgDns=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=oioKmun/Bk6lWEvH468e5h183DqwW79IB/ANV2a0gDswEjQbr6rn5lJPgB9S+0D0+
         NzjnUiMGv/90yXT69l9IIYuA44BFfNNk3ySpc4rs3Rr08A61cnUeVlK7jRma7fD9yL
         aPJx4HN9j8IZrpX+TmYBcEBPqG6dJjFCrUWef/NM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38FG6YWo027758
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Sep 2023 11:06:34 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Sep 2023 11:06:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Sep 2023 11:06:33 -0500
Received: from [10.250.38.120] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38FG6WOV024172;
        Fri, 15 Sep 2023 11:06:33 -0500
Message-ID: <5bbf0a9b-edd0-e591-0a1f-36016bd3f2a0@ti.com>
Date:   Fri, 15 Sep 2023 11:06:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/3] arm64: dts: ti: am654-base-board: add ICSSG2 Ethernet
 support
Content-Language: en-US
To:     MD Danish Anwar <danishanwar@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>
References: <20230911071245.2173520-1-danishanwar@ti.com>
 <20230911071245.2173520-3-danishanwar@ti.com>
 <1e1577a5-fb01-c84b-ede0-38058387ec23@ti.com>
 <6503ca2b-c55a-ab26-6e0c-121aeb5c1c66@ti.com>
 <6cb40b09-8154-5ef4-cbbc-9dfc5994a031@ti.com>
 <cf9f8d95-0f52-b37e-bb97-0382fed01b6a@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <cf9f8d95-0f52-b37e-bb97-0382fed01b6a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

On 9/13/23 1:05 AM, MD Danish Anwar wrote:
> On 12/09/23 20:28, Andrew Davis wrote:
>> On 9/12/23 3:29 AM, MD Danish Anwar wrote:
>>> Hi Andrew,
>>>
>>> On 11/09/23 18:35, Andrew Davis wrote:
>>>> On 9/11/23 2:12 AM, MD Danish Anwar wrote:
>>>>> ICSSG2 provides dual Gigabit Ethernet support.
>>>>>
>>>>> For support SR2.0 ICSSG Ethernet firmware:
>>>>> - provide different firmware blobs and use TX_PRU.
>>>>> - IEP0 is used as PTP Hardware Clock and can only be used for one port.
>>>>> - TX timestamp notification comes via INTC interrupt.
>>>>>
>>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>>> ---
>>>>>     .../arm64/boot/dts/ti/k3-am654-base-board.dts | 123
>>>>> ++++++++++++++++++
>>>>
>>>> Adding this to the base dts? What if I want to use my PRUs for something
>>>> else? These "application nodes" define a single usecase out of many
>>>> possible, and should IMHO always be in overlays so users can select
>>>> which
>>>> they want easily.
>>>>
>>>
>>> The base board (AM654x-EVM) has two Ethernet ports dedicated for ICSSG.
>>> The expectation is that when a user boots up AM654x-EVM, ICSSG is
>>> supported on those two ports by default. If the icssg nodes are not
>>> added to base dts then by default the two Ethernet ports will have no
>>> functionality.
>>>
>>
>> This is *your* default use-case for these PRUs, mine might be different.
>> I can agree that most might want this use-case too and this is the one
>> intended as the demo for these ports on this board. What I am saying is
>> that when one wants to use these PRUs for something else, having this
>> one application baked into the base DTB makes it very difficult to switch.
>>
> 
> This is the intended use case. The base board has two ICSSG Ethernet
> ports. My understanding is that device trees describe the hardware.
> 

Correct, but you are not describing hardware here, you are describing
software. Yes it is software that uses hardware so you are listing a
bunch of hardware too, but the core is a firmware.

> The base board dts should describe the base board hardware which has the
> two ICSSG ports. So the base board dts should contain nodes to enable
> those two ports.
> 
> Any hardware component that is not present in the base board should be
> applied as an overlay.
> 

Correct again, the firmware is not baked into the base board, that is
loaded by U-Boot/Linux at runtime and can be selected.

> For example in the AM654x-IDK, we have extra IDK card applied on the
> base board. This IDK card contains 4 ICSSG Ethernet ports. The nodes for
> these 4 ICSSG port should go in an overlay i.e. k3-am654-idk.dtso which
> I am doing as part of the patch 3 of this series.
> 
> My understanding is that any hardware component that is part of the base
> board should be described in base-board.dts. Any hardware component that
> is not part of the base board and is added by extra cards should be
> described in overlays.
> 
>>> The primary use case is that ICSSG should support on those two ports in
>>> AM654x-EVM by default. The user should not need to apply any overlay to
>>> get the two ports working. So In order to achieve that I think it is OK
>>> to add the ICSSG nodes in the base board dts file.
>>>
>>
>> A user does not need to apply an overlay to use these, this application
>> node overlay can be applied at build time. You can even rename the base
>> .dtb to be the one that has this overlay applied by default.
>>
>> Take a look at k3-am654-gp-evm.dtb, it is a composite DTB built from
>> the "base-board" DTB and the "rocktech-rk101-panel" DTBO applied on top.
>> This combination is what we call and sell as the "GP EVM", and you
>> can use it by booting the "k3-am654-gp-evm.dtb". Now let's say you
>> want to use a different panel, all you need to do is take the base-
>> board and apply a different panel overlay. Had we hard-coded the
>> "default" panel into the base-board DTS then a user with a different
>> panel would have to go and edit the DTS to remove all the rk101-panel
>> bits.
>>
> 
> This is one way to do it. But I still think the best way to do this is
> to have the ICSSG nodes in base board dts as the ICSSG hardware is
> present on the base board.
> 

So again, you are not describing the hardware, you are describing a
*use of* the hardware. This node describes what firmware to load and
what bits of hardware that firmware should use to get some end result,
but I could just as easily use a different firmware and give it different
links to different hardware bits and make it into something else. No
physical changes to the hardware needed.

>>> If user wants to use PRUs for something else, we can have overlay for
>>> those. But we should not need to apply any overlay to achieve the
>>> primary functionality i.e. ICSSG working in the two dedicated ICSSG
>>> Ethernet ports.
>>>
>>
>> They could *not* simply add a different overlay for their usecase as
>> you have baked your usecase into the base DTB. Their overlay would
>> have to have a bunch of /delete-node/ junk to remove your "defaults".
>>
> 
> This patch adds one node "icssg2-eth" which uses six PRUs. If user wants
> to use PRUs for something else they can add "/delete-node/ &icssg2_eth"
> in the overlay.
> 

/delete-node/ is usually an indication some layering was done wrong,
it shouldn't be needed in most cases to delete nodes. And that is
my point here, I don't want to have to delete your use-case in
every overlay file that uses the PRUs differently than you. Your
use-case should simply be an overlay too, then all I have to do is
apply my overlay instead of yours without deletes.

Andrew

>> As above, if this is the "primary functionality" then have this
>> overlay applied by default:
>>
>> --- a/arch/arm64/boot/dts/ti/Makefile
>> +++ b/arch/arm64/boot/dts/ti/Makefile
>> @@ -42,7 +42,7 @@ dtb-$(CONFIG_ARCH_K3) +=
>> k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb
>>   dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl-wlan.dtb
>>   
>>   # Boards with AM65x SoC
>> -k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb
>> k3-am654-base-board-rocktech-rk101-panel.dtbo
>> +k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb
>> k3-am654-base-board-rocktech-rk101-panel.dtbo
>> k3-am654-base-board-prueth.dtbo
>>   dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic.dtb
>>   dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
>>   dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
>>
>> Andrew
>>
>>>
>>>> Andrew
>>>>
>>>>>     1 file changed, 123 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>>>>> b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>>>>> index f5c26e9fba98..5cf9546ff9f7 100644
>>>>> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>>>>> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>>>>> @@ -25,6 +25,8 @@ aliases {
>>>>>             ethernet0 = &cpsw_port1;
>>>>>             mmc0 = &sdhci0;
>>>>>             mmc1 = &sdhci1;
>>>>> +        ethernet1 = &icssg2_emac0;
>>>>> +        ethernet2 = &icssg2_emac1;
>>>>>         };
>>>>>           chosen {
>>>>> @@ -144,6 +146,72 @@ vtt_supply: regulator-3 {
>>>>>             vin-supply = <&vcc3v3_io>;
>>>>>             gpio = <&wkup_gpio0 28 GPIO_ACTIVE_HIGH>;
>>>>>         };
>>>>> +
>>>>> +    /* Dual Ethernet application node on PRU-ICSSG2 */
>>>>> +    icssg2_eth: icssg2-eth {
>>>>> +        compatible = "ti,am654-icssg-prueth";
>>>>> +        pinctrl-names = "default";
>>>>> +        pinctrl-0 = <&icssg2_rgmii_pins_default>;
>>>>> +        sram = <&msmc_ram>;
>>>>> +        ti,prus = <&pru2_0>, <&rtu2_0>, <&tx_pru2_0>,
>>>>> +            <&pru2_1>, <&rtu2_1>, <&tx_pru2_1>;
>>>>> +        firmware-name = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
>>>>> +                "ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
>>>>> +                "ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
>>>>> +                "ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
>>>>> +                "ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
>>>>> +                "ti-pruss/am65x-sr2-txpru1-prueth-fw.elf";
>>>>> +
>>>>> +        ti,pruss-gp-mux-sel = <2>,      /* MII mode */
>>>>> +                      <2>,
>>>>> +                      <2>,
>>>>> +                      <2>,    /* MII mode */
>>>>> +                      <2>,
>>>>> +                      <2>;
>>>>> +
>>>>> +        ti,mii-g-rt = <&icssg2_mii_g_rt>;
>>>>> +        ti,mii-rt = <&icssg2_mii_rt>;
>>>>> +        ti,iep = <&icssg2_iep0>, <&icssg2_iep1>;
>>>>> +
>>>>> +        interrupt-parent = <&icssg2_intc>;
>>>>> +        interrupts = <24 0 2>, <25 1 3>;
>>>>> +        interrupt-names = "tx_ts0", "tx_ts1";
>>>>> +
>>>>> +        dmas = <&main_udmap 0xc300>, /* egress slice 0 */
>>>>> +               <&main_udmap 0xc301>, /* egress slice 0 */
>>>>> +               <&main_udmap 0xc302>, /* egress slice 0 */
>>>>> +               <&main_udmap 0xc303>, /* egress slice 0 */
>>>>> +               <&main_udmap 0xc304>, /* egress slice 1 */
>>>>> +               <&main_udmap 0xc305>, /* egress slice 1 */
>>>>> +               <&main_udmap 0xc306>, /* egress slice 1 */
>>>>> +               <&main_udmap 0xc307>, /* egress slice 1 */
>>>>> +               <&main_udmap 0x4300>, /* ingress slice 0 */
>>>>> +               <&main_udmap 0x4301>; /* ingress slice 1 */
>>>>> +
>>>>> +        dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
>>>>> +                "tx1-0", "tx1-1", "tx1-2", "tx1-3",
>>>>> +                "rx0", "rx1";
>>>>> +        ethernet-ports {
>>>>> +            #address-cells = <1>;
>>>>> +            #size-cells = <0>;
>>>>> +            icssg2_emac0: port@0 {
>>>>> +                reg = <0>;
>>>>> +                phy-handle = <&icssg2_phy0>;
>>>>> +                phy-mode = "rgmii-id";
>>>>> +                ti,syscon-rgmii-delay = <&scm_conf 0x4120>;
>>>>> +                /* Filled in by bootloader */
>>>>> +                local-mac-address = [00 00 00 00 00 00];
>>>>> +            };
>>>>> +            icssg2_emac1: port@1 {
>>>>> +                reg = <1>;
>>>>> +                phy-handle = <&icssg2_phy1>;
>>>>> +                phy-mode = "rgmii-id";
>>>>> +                ti,syscon-rgmii-delay = <&scm_conf 0x4124>;
>>>>> +                /* Filled in by bootloader */
>>>>> +                local-mac-address = [00 00 00 00 00 00];
>>>>> +            };
>>>>> +        };
>>>>> +    };
>>>>>     };
>>>>>       &wkup_pmx0 {
>>>>> @@ -300,6 +368,43 @@ usb1_pins_default: usb1-default-pins {
>>>>>                 AM65X_IOPAD(0x02c0, PIN_OUTPUT, 0) /* (AC8)
>>>>> USB1_DRVVBUS */
>>>>>             >;
>>>>>         };
>>>>> +
>>>>> +    icssg2_mdio_pins_default: icssg2-mdio-default-pins {
>>>>> +        pinctrl-single,pins = <
>>>>> +            AM65X_IOPAD(0x0094, PIN_INPUT, 2) /* (AC19)
>>>>> PRG2_PRU0_GPO7.PRG2_MDIO0_MDIO */
>>>>> +            AM65X_IOPAD(0x00c8, PIN_OUTPUT, 2) /* (AE15)
>>>>> PRG2_PRU1_GPO7.PRG2_MDIO0_MDC */
>>>>> +        >;
>>>>> +    };
>>>>> +
>>>>> +    icssg2_rgmii_pins_default: icssg2-rgmii-default-pins {
>>>>> +        pinctrl-single,pins = <
>>>>> +            AM65X_IOPAD(0x00ac, PIN_INPUT, 2) /* (AH15)
>>>>> PRG2_PRU1_GPO0.PRG2_RGMII2_RD0 */
>>>>> +            AM65X_IOPAD(0x00b0, PIN_INPUT, 2) /* (AC16)
>>>>> PRG2_PRU1_GPO1.PRG2_RGMII2_RD1 */
>>>>> +            AM65X_IOPAD(0x00b4, PIN_INPUT, 2) /* (AD17)
>>>>> PRG2_PRU1_GPO2.PRG2_RGMII2_RD2 */
>>>>> +            AM65X_IOPAD(0x00b8, PIN_INPUT, 2) /* (AH14)
>>>>> PRG2_PRU1_GPO3.PRG2_RGMII2_RD3 */
>>>>> +            AM65X_IOPAD(0x00cc, PIN_OUTPUT, 2) /* (AD15)
>>>>> PRG2_PRU1_GPO8.PRG2_RGMII2_TD0 */
>>>>> +            AM65X_IOPAD(0x00d0, PIN_OUTPUT, 2) /* (AF14)
>>>>> PRG2_PRU1_GPO9.PRG2_RGMII2_TD1 */
>>>>> +            AM65X_IOPAD(0x00d4, PIN_OUTPUT, 2) /* (AC15)
>>>>> PRG2_PRU1_GPO10.PRG2_RGMII2_TD2 */
>>>>> +            AM65X_IOPAD(0x00d8, PIN_OUTPUT, 2) /* (AD14)
>>>>> PRG2_PRU1_GPO11.PRG2_RGMII2_TD3 */
>>>>> +            AM65X_IOPAD(0x00dc, PIN_INPUT, 2) /* (AE14)
>>>>> PRG2_PRU1_GPO16.PRG2_RGMII2_TXC */
>>>>> +            AM65X_IOPAD(0x00c4, PIN_OUTPUT, 2) /* (AC17)
>>>>> PRG2_PRU1_GPO6.PRG2_RGMII2_TX_CTL */
>>>>> +            AM65X_IOPAD(0x00c0, PIN_INPUT, 2) /* (AG15)
>>>>> PRG2_PRU1_GPO5.PRG2_RGMII2_RXC */
>>>>> +            AM65X_IOPAD(0x00bc, PIN_INPUT, 2) /* (AG14)
>>>>> PRG2_PRU1_GPO4.PRG2_RGMII2_RX_CTL */
>>>>> +
>>>>> +            AM65X_IOPAD(0x0078, PIN_INPUT, 2) /* (AF18)
>>>>> PRG2_PRU0_GPO0.PRG2_RGMII1_RD0 */
>>>>> +            AM65X_IOPAD(0x007c, PIN_INPUT, 2) /* (AE18)
>>>>> PRG2_PRU0_GPO1.PRG2_RGMII1_RD1 */
>>>>> +            AM65X_IOPAD(0x0080, PIN_INPUT, 2) /* (AH17)
>>>>> PRG2_PRU0_GPO2.PRG2_RGMII1_RD2 */
>>>>> +            AM65X_IOPAD(0x0084, PIN_INPUT, 2) /* (AG18)
>>>>> PRG2_PRU0_GPO3.PRG2_RGMII1_RD3 */
>>>>> +            AM65X_IOPAD(0x0098, PIN_OUTPUT, 2) /* (AH16)
>>>>> PRG2_PRU0_GPO8.PRG2_RGMII1_TD0 */
>>>>> +            AM65X_IOPAD(0x009c, PIN_OUTPUT, 2) /* (AG16)
>>>>> PRG2_PRU0_GPO9.PRG2_RGMII1_TD1 */
>>>>> +            AM65X_IOPAD(0x00a0, PIN_OUTPUT, 2) /* (AF16)
>>>>> PRG2_PRU0_GPO10.PRG2_RGMII1_TD2 */
>>>>> +            AM65X_IOPAD(0x00a4, PIN_OUTPUT, 2) /* (AE16)
>>>>> PRG2_PRU0_GPO11.PRG2_RGMII1_TD3 */
>>>>> +            AM65X_IOPAD(0x00a8, PIN_INPUT, 2) /* (AD16)
>>>>> PRG2_PRU0_GPO16.PRG2_RGMII1_TXC */
>>>>> +            AM65X_IOPAD(0x0090, PIN_OUTPUT, 2) /* (AE17)
>>>>> PRG2_PRU0_GPO6.PRG2_RGMII1_TX_CTL */
>>>>> +            AM65X_IOPAD(0x008c, PIN_INPUT, 2) /* (AF17)
>>>>> PRG2_PRU0_GPO5.PRG2_RGMII1_RXC */
>>>>> +            AM65X_IOPAD(0x0088, PIN_INPUT, 2) /* (AG17)
>>>>> PRG2_PRU0_GPO4.PRG2_RGMII1_RX_CTL */
>>>>> +        >;
>>>>> +    };
>>>>>     };
>>>>>       &main_pmx1 {
>>>>> @@ -621,3 +726,21 @@ &cpsw_port1 {
>>>>>     &dss {
>>>>>         status = "disabled";
>>>>>     };
>>>>> +
>>>>> +&icssg2_mdio {
>>>>> +    status = "okay";
>>>>> +    pinctrl-names = "default";
>>>>> +    pinctrl-0 = <&icssg2_mdio_pins_default>;
>>>>> +
>>>>> +    icssg2_phy0: ethernet-phy@0 {
>>>>> +        reg = <0>;
>>>>> +        ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
>>>>> +        ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
>>>>> +    };
>>>>> +
>>>>> +    icssg2_phy1: ethernet-phy@3 {
>>>>> +        reg = <3>;
>>>>> +        ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
>>>>> +        ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
>>>>> +    };
>>>>> +};
>>>
> 
