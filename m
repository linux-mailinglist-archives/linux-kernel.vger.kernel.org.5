Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DC6797692
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbjIGQNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240130AbjIGQM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:12:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192201BF;
        Thu,  7 Sep 2023 08:50:53 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0B1786607317;
        Thu,  7 Sep 2023 14:05:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694091903;
        bh=OnCahLWIBH60/+Vh8X0NY58i8EDneaAfBCa1blG+m4Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BfYg7IZ58fzkvnOIj2rPDBWHHsfb7+JOxB31ho55k5vUVhp6zq5YQHVaHeT0lgj/n
         0wYOHSAOpX1+28mEbJJ9Vm326ieHKiFvLcn1vbn8J9lO1ZCSrqvmNpjTLh/+vrIApo
         rJ2IbEkpL7YYicz4YcSrEpJ4G61Z+SbAFQM9DTE6Ch7HZDZ8A4Q2hY35mwV2fygxAb
         lsDmsrYVbxh4hji6kPS4TODd04h+aI9QsoonxVaDAfWAVfVoN1jBlhxyUeXn9X8Hcc
         afLwNGPGqX0BvtCZw+UK5mFq32RA00bSNpIk1h4E9wfYXIW05Q7kTl+OI8Lz6+V+QA
         IaWX/1/BXA+Lw==
Message-ID: <78f8cb96-3f55-a209-e76c-c3a0fe8ea7d7@collabora.com>
Date:   Thu, 7 Sep 2023 15:05:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 2/2] arm64: dts: mediatek: add device-tree for Genio
 1200 EVK board
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>, Ben Lok <ben.lok@mediatek.com>
References: <20230906114425.31187-1-macpaul.lin@mediatek.com>
 <20230906114425.31187-2-macpaul.lin@mediatek.com>
 <f9b97807-f0e1-8122-ae33-18a38ad7f195@collabora.com>
 <248153d5-2c43-2f02-cc2e-cd49fd524f89@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <248153d5-2c43-2f02-cc2e-cd49fd524f89@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/09/23 15:00, Macpaul Lin ha scritto:
> 
> 
> On 9/7/23 16:48, AngeloGioacchino Del Regno wrote:
>> Il 06/09/23 13:44, Macpaul Lin ha scritto:
>>> Add basic device-tree for the Genio 1200 EVK board. The
>>> Demo board is made by MediaTek and has a MT8395 SoC (MT8195 family),
>>> associated with the MT6359 and MT6360 PMICs, and
>>> the MT7921 connectivity chip.
>>>
>>> The IOs available on that board are:
>>> * 1 USB Type-C connector with DP aux mode support
>>> * 2 USB Type-A connector with a USB hub
>>> * 1 micro-USB port for gadget or OTG support
>>> * 1 full size HDMI RX and 1 full size HDMI TX connector
>>> * 1 micro SD slot
>>> * 40 pins header
>>> * SPI interface header
>>> * 1 M.2 slot
>>> * 1 audio jack
>>> * 1 micro-USB port for serial debug
>>> * 2 connectors for DSI displays, 1 of the DSI panel is installed
>>> * 3 connectors for CSI cameras
>>> * 1 connector for a eDP panel
>>> * 1 MMC storage
>>> * 1 Touch Panel (installed DSI display)
>>> * 1 M.2 slot for 5G dongle
>>>
>>> This commit adds basic support in order to be able to boot.
>>>
>>> Signed-off-by: Ben Lok <ben.lok@mediatek.com>
>>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>>> ---
>>>   arch/arm64/boot/dts/mediatek/Makefile         |   1 +
>>>   .../boot/dts/mediatek/genio-1200-evk.dts      | 916 ++++++++++++++++++
>>>   2 files changed, 917 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/mediatek/genio-1200-evk.dts
>>>
>>> Changes for v2:
>>>   - correct SOC binding to "mediatek,mt8395".
>>>   - Fix a Linux coding style comments for optee node.
>>>   - Fix wifi fixed 3.3v power's node with "wifi-3v3-regulator".
>>>   - Fix node name of mt6360 and mt6517 to generic dts name as "pmic".
>>>   - Remove unecessary blank line.
>>>   - Reording usb node as the order of "phy" then "host".
>>>
>>> Changes for v3:
>>>   - Add back bindings for "mediatek,mt8195".
>>>   - Fix wifi fixed 3.3v power's node with "regulator-2"
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile 
>>> b/arch/arm64/boot/dts/mediatek/Makefile
>>> index c99c3372a4b5..5bf29581f08b 100644
>>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>>> @@ -1,4 +1,5 @@
>>>   # SPDX-License-Identifier: GPL-2.0
>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += genio-1200-evk.dtb
>>
>> Please follow the current naming in dts/mediatek/.
>>
>> This should be `mt8395-genio-1200-evk.dtb`
> 
> Fixed.
> 
>>
>>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
>>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
>>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt6779-evb.dtb
>>> diff --git a/arch/arm64/boot/dts/mediatek/genio-1200-evk.dts 
>>> b/arch/arm64/boot/dts/mediatek/genio-1200-evk.dts
>>> new file mode 100644
>>> index 000000000000..dd7518784aaf
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/mediatek/genio-1200-evk.dts
>>
>> `mt8195-genio-1200-evk.dts` please
> 
> Is this a typo?
> I'll get build error if I've actually rename the file name to 
> 'mt8195-genio-1200-evk.dts' which isn't match mt8395-genio-1200-evk.dtb.
> (I've tested it to make sure every thing okay.)
> 

Eh sorry yes I meant to write mt8395, not 8195!! :-)

>>> @@ -0,0 +1,916 @@
>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>> +/*
>>> + * Copyright (C) 2023 MediaTek Inc.
>>> + * Author: Ben Lok <ben.lok@mediatek.com>
>>> + *       Macpaul Lin <macpaul.lin@mediatek.com>
>>> + */
>>> +/dts-v1/;
>>> +
>>> +#include "mt8195.dtsi"
>>> +#include "mt6359.dtsi"
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/input/input.h>
>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>> +#include <dt-bindings/pinctrl/mt8195-pinfunc.h>
>>> +#include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
>>> +#include <dt-bindings/spmi/spmi.h>
>>> +#include <dt-bindings/usb/pd.h>
>>> +
>>> +/ {
>>> +    model = "MediaTek Genio 1200 EVK-P1V2-EMMC";
>>> +    compatible = "mediatek,mt8395-evk", "mediatek,mt8395",
>>> +             "mediatek,mt8195";
>>> +
>>
>> ..snip..
>>
>>> +
>>> +&eth {
>>> +    phy-mode ="rgmii-rxid";
>>> +    phy-handle = <&eth_phy0>;
>>> +    snps,reset-gpio = <&pio 93 GPIO_ACTIVE_HIGH>;
>>> +    snps,reset-delays-us = <0 10000 10000>;
>>> +    mediatek,tx-delay-ps = <2030>;
>>> +    mediatek,mac-wol;
>>> +    pinctrl-names = "default", "sleep";
>>> +    pinctrl-0 = <&eth_default_pins>;
>>> +    pinctrl-1 = <&eth_sleep_pins>;
>>> +    status = "okay";
>>> +
>>> +    mdio {
>>> +        compatible = "snps,dwmac-mdio";
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +        eth_phy0: eth-phy0@1 {
>>> +            compatible = "ethernet-phy-id001c.c916";
>>> +            reg = <0x1>;
>>> +        };
>>> +    };
>>> +};
>>> +
>>> +&uart0 {
>>> +    pinctrl-0 = <&uart0_pins>;
>>> +    pinctrl-names = "default";
>>> +    status = "okay";
>>> +};
>>> +
>>> +&uart1 {
>>> +    pinctrl-0 = <&uart1_pins>;
>>> +    pinctrl-names = "default";
>>> +    status = "okay";
>>> +};
>>> +
>>> +&scp {
>>> +    status = "okay";
>>> +};
>>> +
>>> +&mmc0 {
>>> +    status = "okay";
>>> +    pinctrl-names = "default", "state_uhs";
>>> +    pinctrl-0 = <&mmc0_default_pins>;
>>> +    pinctrl-1 = <&mmc0_uhs_pins>;
>>> +    bus-width = <8>;
>>> +    max-frequency = <200000000>;
>>> +    cap-mmc-highspeed;
>>> +    mmc-hs200-1_8v;
>>> +    mmc-hs400-1_8v;
>>> +    cap-mmc-hw-reset;
>>> +    no-sdio;
>>> +    no-sd;
>>> +    hs400-ds-delay = <0x14c11>;
>>> +    vmmc-supply = <&mt6359_vemc_1_ldo_reg>;
>>> +    vqmmc-supply = <&mt6359_vufs_ldo_reg>;
>>> +    non-removable;
>>> +};
>>> +
>>> +&mmc1 {
>>> +    pinctrl-names = "default", "state_uhs";
>>> +    pinctrl-0 = <&mmc1_default_pins>;
>>> +    pinctrl-1 = <&mmc1_uhs_pins>;
>>> +    bus-width = <4>;
>>> +    max-frequency = <200000000>;
>>> +    cap-sd-highspeed;
>>> +    sd-uhs-sdr50;
>>> +    sd-uhs-sdr104;
>>> +    no-mmc;
>>> +    no-sdio;
>>> +    vmmc-supply = <&mt6360_ldo5>;
>>> +    vqmmc-supply = <&mt6360_ldo3>;
>>> +    status = "okay";
>>> +    non-removable;
>>> +};
>>> +
>>> +
>>> +&ufsphy {
>>> +    status = "disabled";
>>> +};
>>> +
>>> +&pmic {
>>
>> Please order nodes by name. pmic goes before ufsphy.
>>
>>> +    interrupt-parent = <&pio>;
>>> +    interrupts = <222 IRQ_TYPE_LEVEL_HIGH>;
>>> +};
>>> +
>>> +&scp {
>>> +    memory-region = <&scp_mem>;
>>> +    status = "okay";
>>> +};
>>> +
>>> +&i2c0 {
>>
>> ...and `i` comes before 'mmc` as well...
>>
>>> +    clock-frequency = <400000>;
>>> +    pinctrl-0 = <&i2c0_pins>;
>>> +    pinctrl-names = "default";
>>> +    status = "okay";
>>> +};
>>> +
>>
>> ..snip..
>>
>>> +
>>> +&mt6359_vgpu11_buck_reg {
>>> +    regulator-always-on;
>>> +};
>>> +
>>> +&mt6359_vpu_buck_reg {
>>> +    regulator-always-on;
>>> +};
>>> +
>>> +&mt6359_vcore_buck_reg {
>>> +    regulator-always-on;
>>> +};
>>> +
>>> +&mt6359_vbbck_ldo_reg {
>>> +    regulator-always-on;
>>> +};
>>> +
>>> +&mt6359_vaud18_ldo_reg {
>>> +    regulator-always-on;
>>> +};
>>> +
>>> +&mt6359_vrf12_ldo_reg {
>>> +    regulator-always-on;
>>> +};
>>> +
>>> +&mt6359_vcn33_2_bt_ldo_reg {
>>> +    regulator-min-microvolt = <3300000>;
>>> +    regulator-max-microvolt = <3300000>;
>>> +};
>>> +
>>> +/* DEBUG: to remove */
>>
>> ...then remove it? :-)
> 
> Fixed.
> 
>>> +&mt6359_vibr_ldo_reg {
>>> +    regulator-always-on;
>>> +};
>>> +
>>> +/* For USB Hub */
>>> +&mt6359_vcamio_ldo_reg {
>>> +    regulator-always-on;
>>> +};
>>> +
>>> +&spmi {
>>
>> spmi goes after pciephy.... and please fix all of the other instances
>> of wrong ordering across this entire file.
>>
>> Regards,
>> Angelo
>>
>>
> 
> I've reordered these node according to alphabet order as could as possible. I'll 
> send version v4 for reviewing. Thanks
> 

Eager to see your v4!

Cheers,
Angelo

> Best regards,
> Macpaul Lin


