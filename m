Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0797A18F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjIOIef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjIOIea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:34:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949FCEB;
        Fri, 15 Sep 2023 01:34:24 -0700 (PDT)
X-UUID: 261b03f053a011eea33bb35ae8d461a2-20230915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=YqF0GmXW7u/0GMyc/k7hirQHe/I8GeaepW/dVu/If4I=;
        b=NRlUpoN/dAcBVWAT4ykIIf6TKuvyGpdvwk7QektWns6fbhiAMoJ13JVfjfJ/c9lS+Br3mCIMncapVmJz0ofp6mU0ASKIhLNRYXifp2D4UxNBf2tbr8ykYT1iWVZYGPTNWObuHPEeYRnI0YlH1WyoIy98t9HQxhsx/HtRYwMgFcc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:40004a28-fa81-4d41-83cc-050a6c8edf33,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:047210c3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 261b03f053a011eea33bb35ae8d461a2-20230915
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2025219946; Fri, 15 Sep 2023 16:16:19 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Sep 2023 16:16:18 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 15 Sep 2023 16:16:17 +0800
Message-ID: <0f34d997-5464-f924-5f8a-b158ab13e7da@mediatek.com>
Date:   Fri, 15 Sep 2023 16:16:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/2] arm64: dts: mediatek: add device-tree for Genio
 700 EVK board
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>,
        Chris-QJ Chen <chris-qj.chen@mediatek.com>
References: <20230914061833.32288-1-macpaul.lin@mediatek.com>
 <20230914061833.32288-2-macpaul.lin@mediatek.com>
 <8596fd5e-035b-b7be-3588-c07f27d1f38f@collabora.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <8596fd5e-035b-b7be-3588-c07f27d1f38f@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/23 18:02, AngeloGioacchino Del Regno wrote:
> Il 14/09/23 08:18, Macpaul Lin ha scritto:
>> Add basic device-tree for the Genio 700 EVK board. The
>> Genio 700 EVK is based on MediaTek MT8390 SoC.
>> MT8390 hardware register maps are identical to MT8188.
>>
>> The Genio 700 EVK has following features:
>>
>> - MT8390 SoC
>> - MT6365 PMIC
>> - MT6319 Buck IC
>> - 12V DC Jack
>> - 2x4GB LPDDR4X
>> - 64GB eMMC 5.1
>> - 64Mb SPI NOR
>> - M.2 Key A-E slot with PCIe Gen2 and USB 2.0
>> - 2x DSI LCM ports
>> - 2x touch sensor ports
>> - 2x MIPI-CSI, as camera daughter board slots
>> - USB 2 micro USB connector
>> - USB 3 with 1 to 2 hub:
>>    - M.2 Key B slot
>>    - Type-C connector, with DisplayPort over Type-C
>> - HDMI 2.0 TX port with Type A HDMI connector
>> - eDP port
>> - Gigabit Ethernet with RJ45 connector
>> - SD card slot
>> - Earphone Jack
>> - Analog Microphone
>> - 2x Digital Microphone
>> - 3x UART with serial-to-usb converters and micro USB connectors
>>
>> Signed-off-by: Chris-QJ Chen <chris-qj.chen@mediatek.com>
>> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/Makefile         |   1 +
>>   .../dts/mediatek/mt8390-genio-700-evk.dts     | 880 ++++++++++++++++++
>>   2 files changed, 881 insertions(+)
>>   create mode 100644 
>> arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
>>
>> dependencies for v1:
>>   - This patch should be applied after the following patch set
>>    - mt8365-gneio-350-evk's dts change (v4)
>>     - 
>> https://lore.kernel.org/linux-arm-kernel/20230912092444.31635-1-macpaul.lin@mediatek.com/T/ 
>>
>>    - mt8395-genio-1200-evk's dts basic support (v6)
>>     - 
>> https://lore.kernel.org/lkml/20230911115717.26184-1-macpaul.lin@mediatek.com/T/ 
>>
>>    - mt8188 platform's basic support
>>     - 
>> https://lore.kernel.org/lkml/a4e1a80ebd19896410f50b0297e05dce06fb47cc.camel@mediatek.com/T/ 
>>
>>
>> changes for v2:
>>   - Fix gpio defines '0' to 'GPIO_ACTIVE_HIGH'.
>>   - Drop duplicate name: 'default' for I2C4.
>>   - Update dependencies
>>    - mt8365-gneio-350-evk's dts change (v5)
>>     - 
>> https://lore.kernel.org/lkml/20230913032226.4092-1-macpaul.lin@mediatek.com/ 
>>
>>    - mt8395-genio-1200-evk's dts basic support (v7)
>>     - 
>> https://lore.kernel.org/linux-arm-kernel/20230913032057.3197-1-macpaul.lin@mediatek.com/T/ 
>>
>>    - mt8188 platform's basic support (v4)
>>     - 
>> https://lore.kernel.org/lkml/a4e1a80ebd19896410f50b0297e05dce06fb47cc.camel@mediatek.com/T/ 
>>
>>
>> changes for v3:
>>   - No change.
>>   - Update dependencies
>>    - mt8365-gneio-350-evk's dts change (v5)
>>     - 
>> https://lore.kernel.org/lkml/20230913032226.4092-1-macpaul.lin@mediatek.com/ 
>>
>>    - mt8395-genio-1200-evk's dts basic support (v8)
>>     - 
>> https://lore.kernel.org/lkml/20230914055145.16801-1-macpaul.lin@mediatek.com/T/ 
>>
>>    - mt8188 platform's basic support (v4)
>>     - 
>> https://lore.kernel.org/lkml/a4e1a80ebd19896410f50b0297e05dce06fb47cc.camel@mediatek.com/T/ 
>>
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile 
>> b/arch/arm64/boot/dts/mediatek/Makefile
>> index 22f362bbbdac..3262849c0f6b 100644
>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>> @@ -54,5 +54,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += 
>> mt8195-cherry-tomato-r3.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-demo.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-genio-350-evk.dtb
>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-genio-700-evk.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-genio-1200-evk.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts 
>> b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
>> new file mode 100644
>> index 000000000000..ed6bbf0c15cc
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
>> @@ -0,0 +1,880 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> +/*
>> + * Copyright (C) 2023 MediaTek Inc.
>> + * Author: Chris Chen <chris-qj.chen@mediatek.com>
>> + *       Pablo Sun <pablo.sun@mediatek.com>
>> + *       Macpaul Lin <macpaul.lin@mediatek.com>
>> + */
>> +/dts-v1/;
>> +
>> +#include "mt8188.dtsi"
>> +#include "mt6359.dtsi"
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h>
>> +#include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
>> +#include <dt-bindings/spmi/spmi.h>
>> +#include <dt-bindings/usb/pd.h>
>> +
>> +/ {
>> +    model = "MediaTek Genio-700 EVK";
>> +    compatible = "mediatek,mt8390-evk", "mediatek,mt8390",
>> +             "mediatek,mt8188";
>> +
> 
> ..snip..
> 
>> +
>> +&i2c0 {
>> +    pinctrl-names = "default";
>> +    pinctrl-0 = <&i2c0_pins>;
>> +    clock-frequency = <400000>;
>> +    status = "okay";
>> +
>> +    touchscreen@5d {
>> +        compatible = "goodix,gt9271";
>> +        reg = <0x5d>;
>> +        interrupt-parent = <&pio>;
>> +        interrupts = <6 IRQ_TYPE_EDGE_RISING>;
> 
> interrupts-extended = <&pio 7 IRQ_TYPE_EDGE_RISING>;
> 
> after which:
> 
> Reviewed-by: AngeloGioacchino Del Regno 
> <angelogioacchino.delregno@collabora.com>
> 

Line 'interrupts-extended = <&pio 6 IRQ_TYPE_EDGE_RISING>;'
has been fixed in v4 patch.

Thanks!
Macpaul Lin
