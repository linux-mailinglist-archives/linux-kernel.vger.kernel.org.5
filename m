Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7637D0DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377064AbjJTKtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376882AbjJTKtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:49:40 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBACDE8;
        Fri, 20 Oct 2023 03:49:34 -0700 (PDT)
X-UUID: 51551fcc6f3611ee8051498923ad61e6-20231020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=Zyd475ssYsPxQShAGIohPguj5OOfgEaTiaD2JflHHjc=;
        b=O3u89FFVA5BSATNev1auP473LnKkZgJn99sNVAu3q7Sm2QCuMxpbrRWlY1vJXhDUCpLZUEdfNE/Z3r9pICbqPoDC5YpyaOZWq2WuiWsizFNe1uCzvfQmWPSy7ezS3iH6gl2c34JbhUVzysnqQmRXrPNfxCKwAcIZm5DuhnwhTfA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:e798e126-739a-4449-8f2f-342cd4b69e1f,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:5f78ec9,CLOUDID:825492fb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 51551fcc6f3611ee8051498923ad61e6-20231020
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1413993312; Fri, 20 Oct 2023 18:49:17 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 20 Oct 2023 18:49:14 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 20 Oct 2023 18:49:14 +0800
Message-ID: <704fbd2c-620e-cc62-319e-45c536149cfd@mediatek.com>
Date:   Fri, 20 Oct 2023 18:49:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 4/4] arm64: dts: Add MediaTek MT8188 dts and evaluation
 board and Makefile
Content-Language: en-US
To:     =?UTF-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "eugen.hristev@collabora.com" <eugen.hristev@collabora.com>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>
References: <20231019075458.28290-1-jason-ch.chen@mediatek.com>
 <20231019075458.28290-5-jason-ch.chen@mediatek.com>
 <69a0bd5c-58ef-4fb2-a8c8-35f6e277f76b@collabora.com>
 <27917c82b6e2c9541e185e49c8b403ba65b31ef9.camel@mediatek.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <27917c82b6e2c9541e185e49c8b403ba65b31ef9.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--23.688700-8.000000
X-TMASE-MatchedRID: 8HTFlOrbAtFjbyiFvYNuKCa1MaKuob8PofZV/2Xa0cJbKBBN5zqG8Jk+
        8pFjO9Akzqd6D1YL6RU/1OCEFU7zHOrVjATjwK5bi/b+LxU2p44raL2mh8ZVK+9Jtzyqge7RaUX
        s6FguVy2cPcDHCp4L+uSWVqW5qzmO7nG4806h/GwVglQa/gMvfFV+08YFNHSuFLXUWU5hGiGoqq
        MjKO9ydgi3k+bj/10njiZmQ7Z6f/KfgYw5AuFyU3TnOygHVQpO0w14HFJQjaObcemyPxDuGkYl1
        xs+tftjbp7SvcO16QG7GagSoVuHi0X6gFtaKja3hrs6JAEL1u6Z2scyRQcery5hVkDKEqeB2CTV
        52hxEMCxQhSFSHmxbi4ePiERtUn8LcB0OzMXnmNNa4UOfkJSNL/MqlpyYVLBGQX5pc9akfsd+aQ
        yn7+idX3fqZX0bey3TuOy1YZ2l2QORiI6OZoAdtcjCbPZgQnFUcH09qBGmHStj24Xqh0yXOYfP2
        DxCABaIooVLaUryu2iPAa/fggDpdFpWCk/W2tm2OSj4qJA9QaRPtwwl97om6fnINz0/CVcqM8PY
        JGuHYrrEtdW+FNbxP0IWmEDBz+A7MjuhxjKgEYmZusHWPhfCteI0HiAZse4M7L377C/hcQHZF1A
        BlLN0NTQ4YoTvo3oYbcNRQhc2JwiTMmg/YMPl0KcYi5Qw/RVPllq4+7Psp9o5YsPsbyLXXbkpdD
        hAgYmFNDaXAz6z7zaciOwKg6GDFlOqKNI2QkGma6DzXaohvOVZfG8cr6tXlpbYq2f4jz+Z1Hcpl
        u19kgQ2TsKZmZguDvme0BlAfRnDQDsaNzyDSSeAiCmPx4NwFkMvWAuahr8ylNXFsiN4FpJKW4mD
        lJsMbxAi7jPoeEQftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.688700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: B7017DD3F29636588FD9A75A30A560B3268935CF6612D4ED5165C6B2586CAA6D2000:8
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/23 16:37, Jason-ch Chen (陳建豪) wrote:
> Hi Angelo,
> 
> On Thu, 2023-10-19 at 11:47 +0200, AngeloGioacchino Del Regno wrote:
>> Il 19/10/23 09:54, Jason-ch Chen ha scritto:
>>> From: jason-ch chen <Jason-ch.Chen@mediatek.com>
>>>
>>> MT8188 is a SoC based on 64bit ARMv8 architecture. It contains 6
>>> CA55
>>> and 2 CA78 cores. MT8188 share many HW IP with MT65xx series.
>>>
>>> We add basic chip support for MediaTek MT8188 on evaluation board.
>>>
>>> Signed-off-by: jason-ch chen <Jason-ch.Chen@mediatek.com>
>>> ---
>>>    arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>>>    arch/arm64/boot/dts/mediatek/mt8188-evb.dts | 388 ++++++++
>>>    arch/arm64/boot/dts/mediatek/mt8188.dtsi    | 949
>>> ++++++++++++++++++++
>>>    3 files changed, 1338 insertions(+)
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-evb.dts
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8188.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile
>>> b/arch/arm64/boot/dts/mediatek/Makefile
>>> index e6e7592a3645..8900b939ed52 100644
>>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>>> @@ -44,6 +44,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-
>>> krane-sku0.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-evb.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r5-sku2.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r0.dtb
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8188-evb.dts
>>> b/arch/arm64/boot/dts/mediatek/mt8188-evb.dts
>>> new file mode 100644
>>> index 000000000000..773bf84cfb94
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8188-evb.dts
>>> @@ -0,0 +1,388 @@
>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>> +/*
>>> + * Copyright (C) 2023 MediaTek Inc.
>>> + */
>>> +/dts-v1/;
>>> +#include "mt8188.dtsi"
>>> +#include "mt6359.dtsi"
>>> +
>>> +/ {
>>> +	model = "MediaTek MT8188 evaluation board";
>>> +	compatible = "mediatek,mt8188-evb", "mediatek,mt8188";
>>> +
>>> +	aliases {
>>> +		serial0 = &uart0;
>>> +		i2c0 = &i2c0;
>>> +		i2c1 = &i2c1;
>>> +		i2c2 = &i2c2;
>>> +		i2c3 = &i2c3;
>>> +		i2c4 = &i2c4;
>>> +		i2c5 = &i2c5;
>>> +		i2c6 = &i2c6;
>>> +		mmc0 = &mmc0;
>>> +	};
>>> +
>>> +	chosen: chosen {
>>> +		stdout-path = "serial0:115200n8";
>>> +	};
>>> +
>>> +	memory@40000000 {
>>> +		device_type = "memory";
>>> +		reg = <0 0x40000000 0 0x80000000>;
>>> +	};
>>> +
>>> +	reserved_memory: reserved-memory {
>>> +		#address-cells = <2>;
>>> +		#size-cells = <2>;
>>> +		ranges;
>>> +
>>> +		scp_mem_reserved: memory@50000000 {
>>> +			compatible = "shared-dma-pool";
>>> +			reg = <0 0x50000000 0 0x2900000>;
>>> +			no-map;
>>> +		};
>>> +	};
>>> +};
>>> +
>>> +&auxadc {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&i2c0 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&i2c0_pins>;
>>> +	clock-frequency = <400000>;
>>> +	status = "okay";
>>> +};
>>> +
>>> +&i2c1 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&i2c1_pins>;
>>> +	clock-frequency = <400000>;
>>> +	status = "okay";
>>> +};
>>> +
>>> +&i2c2 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&i2c2_pins>;
>>> +	clock-frequency = <400000>;
>>> +	status = "okay";
>>> +};
>>> +
>>> +&i2c3 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&i2c3_pins>;
>>> +	clock-frequency = <400000>;
>>> +	status = "okay";
>>> +};
>>> +
>>> +&i2c4 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&i2c4_pins>;
>>> +	clock-frequency = <400000>;
>>> +	status = "okay";
>>> +};
>>> +
>>> +&i2c5 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&i2c5_pins>;
>>> +	clock-frequency = <400000>;
>>> +	status = "okay";
>>> +};
>>> +
>>> +&i2c6 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&i2c6_pins>;
>>> +	clock-frequency = <400000>;
>>> +	status = "okay";
>>> +};
>>> +
>>> +&mmc0 {
>>> +	status = "okay";
>>> +	pinctrl-names = "default", "state_uhs";
>>> +	pinctrl-0 = <&mmc0_default_pins>;
>>> +	pinctrl-1 = <&mmc0_uhs_pins>;
>>> +	bus-width = <8>;
>>> +	max-frequency = <200000000>;
>>
>> ...that's how it should be ordered:
>>
>> &mmc0 {
>> 	bus-width = <8>;
>> 	hs400-ds-delay = <0x1481b>;
>> 	max-frequency = <200000000>;
>>
>> 	cap-mmc-highspeed;
>> 	cap-mmc-hw-reset;
>> 	mmc-hs200-1_8v;
>> 	mmc-hs400-1_8v;
>> 	no-sdio;
>> 	no-sd;
>> 	non-removable;
>>
>> 	vmmc-supply = ...
>> 	vqmmc-supply = ...
>>
>> 	pinctrl-0 ...
>> 	pinctrl-1 ...
>> 	pinctrl-names ...
>>
>> 	status = "okay";
>> };
>>
>>> +	cap-mmc-highspeed;
>>> +	mmc-hs200-1_8v;
>>> +	mmc-hs400-1_8v;
>>> +	supports-cqe;
>>> +	cap-mmc-hw-reset;
>>> +	no-sdio;
>>> +	no-sd;
>>> +	hs400-ds-delay = <0x1481b>;
>>> +	vmmc-supply = <&mt6359_vemc_1_ldo_reg>;
>>> +	vqmmc-supply = <&mt6359_vufs_ldo_reg>;
>>> +	non-removable;
>>> +};
>>> +
>>> +&mt6359_vcore_buck_reg {
>>> +	regulator-always-on;
>>> +};
>>> +
>>> +&mt6359_vgpu11_buck_reg {
>>> +	regulator-always-on;
>>> +};
>>> +
>>> +&mt6359_vpu_buck_reg {
>>> +	regulator-always-on;
>>> +};
>>> +
>>> +&mt6359_vrf12_ldo_reg {
>>> +	regulator-always-on;
>>> +};
>>> +
>>> +&nor_flash {
>>> +	status = "okay";
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&nor_pins_default>;
>>> +	#address-cells = <1>;
>>> +	#size-cells = <0>;
>>> +
>>> +	flash@0 {
>>> +		compatible = "jedec,spi-nor";
>>> +		reg = <0>;
>>> +		spi-max-frequency = <52000000>;
>>> +	};
>>> +};
>>> +
>>> +&pio {
>>> +	adsp_uart_pins: adsp-uart-pins {
>>> +		pins-adsp-uart {
>>
>> pins-tx-rx {
>>
>>> +			pinmux = <PINMUX_GPIO35__FUNC_O_ADSP_UTXD0>,
>>> +				 <PINMUX_GPIO36__FUNC_I1_ADSP_URXD0>;
>>> +		};
>>> +	};
>>> +
>>
>> ..snip..
>>
>>> +
>>> +	mmc0_uhs_pins: mmc0-uhs-pins {
>>> +		pins-cmd-dat {
>>> +			pinmux = <PINMUX_GPIO161__FUNC_B1_MSDC0_DAT0>,
>>> +				 <PINMUX_GPIO160__FUNC_B1_MSDC0_DAT1>,
>>> +				 <PINMUX_GPIO159__FUNC_B1_MSDC0_DAT2>,
>>> +				 <PINMUX_GPIO158__FUNC_B1_MSDC0_DAT3>,
>>> +				 <PINMUX_GPIO154__FUNC_B1_MSDC0_DAT4>,
>>> +				 <PINMUX_GPIO153__FUNC_B1_MSDC0_DAT5>,
>>> +				 <PINMUX_GPIO152__FUNC_B1_MSDC0_DAT6>,
>>> +				 <PINMUX_GPIO151__FUNC_B1_MSDC0_DAT7>,
>>> +				 <PINMUX_GPIO156__FUNC_B1_MSDC0_CMD>;
>>> +			input-enable;
>>> +			drive-strength = <8>;
>>> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
>>> +		};
>>> +
>>> +		pins-clk {
>>
>> pins-clk-ds {
>> 	pinmux = <PINMUX_GPIO157__FUNC_B1_MSDC0_CLK>,
>> 		 <PINMUX_GPIO162__FUNC_B0_MSDC0_DSL>;
>> 	drive-strength = <8>;
>> 	bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
>> };
>>
>> ...that's shorter: both pins are anyway sharing the same drive
>> strength and bias.
>>
>>> +			pinmux = <PINMUX_GPIO157__FUNC_B1_MSDC0_CLK>;
>>> +			drive-strength = <8>;
>>> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
>>> +		};
>>> +
>>> +		pins-ds {
>>> +			pinmux = <PINMUX_GPIO162__FUNC_B0_MSDC0_DSL>;
>>> +			drive-strength = <8>;
>>> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
>>> +		};
>>> +
>>> +		pins-rst {
>>> +			pinmux = <PINMUX_GPIO155__FUNC_O_MSDC0_RSTB>;
>>> +			drive-strength = <8>;
>>> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
>>> +		};
>>> +	};
>>> +
>>> +	nor_pins_default: nor-pins {
>>> +		pins0 {
>>
>> pins-io-ck {
>>
>>> +			pinmux = <PINMUX_GPIO127__FUNC_B0_SPINOR_IO0>,
>>> +				 <PINMUX_GPIO125__FUNC_O_SPINOR_CK>,
>>> +				 <PINMUX_GPIO128__FUNC_B0_SPINOR_IO1>;
>>> +			bias-pull-down;
>>> +		};
>>> +
>>> +		pins1 {
>>
>> pins-io-cs {
>>
>>> +			pinmux = <PINMUX_GPIO126__FUNC_O_SPINOR_CS>,
>>> +				 <PINMUX_GPIO129__FUNC_B0_SPINOR_IO2>,
>>> +				 <PINMUX_GPIO130__FUNC_B0_SPINOR_IO3>;
>>> +			bias-pull-up;
>>> +		};
>>> +	};
>>> +
>>> +	spi0_pins: spi0-pins {
>>> +		pins-spi {
>>> +			pinmux = <PINMUX_GPIO69__FUNC_O_SPIM0_CSB>,
>>> +				 <PINMUX_GPIO70__FUNC_O_SPIM0_CLK>,
>>> +				 <PINMUX_GPIO71__FUNC_B0_SPIM0_MOSI>,
>>> +				 <PINMUX_GPIO72__FUNC_B0_SPIM0_MISO>;
>>> +			bias-disable;
>>> +		};
>>> +	};
>>> +
>>> +	spi1_pins: spi1-pins {
>>> +		pins-spi {
>>> +			pinmux = <PINMUX_GPIO75__FUNC_O_SPIM1_CSB>,
>>> +				 <PINMUX_GPIO76__FUNC_O_SPIM1_CLK>,
>>> +				 <PINMUX_GPIO77__FUNC_B0_SPIM1_MOSI>,
>>> +				 <PINMUX_GPIO78__FUNC_B0_SPIM1_MISO>;
>>> +			bias-disable;
>>> +		};
>>> +	};
>>> +
>>> +	spi2_pins: spi2-pins {
>>> +		pins-spi {
>>> +			pinmux = <PINMUX_GPIO79__FUNC_O_SPIM2_CSB>,
>>> +				 <PINMUX_GPIO80__FUNC_O_SPIM2_CLK>,
>>> +				 <PINMUX_GPIO81__FUNC_B0_SPIM2_MOSI>,
>>> +				 <PINMUX_GPIO82__FUNC_B0_SPIM2_MISO>;
>>> +			bias-disable;
>>> +		};
>>> +	};
>>> +
>>> +	uart0_pins: uart0-pins {
>>> +		pins-uart0 {
>>
>> pins-rx-tx {
>>
>>> +			pinmux = <PINMUX_GPIO31__FUNC_O_UTXD0>,
>>> +				 <PINMUX_GPIO32__FUNC_I1_URXD0>;
>>> +			bias-pull-up;
>>> +		};
>>> +	};
>>> +};
>>> +
>>
>> ..snip..
>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
>>> b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
>>> new file mode 100644
>>> index 000000000000..c5af32fb7e85
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
>>> @@ -0,0 +1,949 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright (c) 2023 MediaTek Inc.
>>> + *
>>> + */
>>> +
>>> +/dts-v1/;
>>> +#include <dt-bindings/clock/mediatek,mt8188-clk.h>
>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>> +#include <dt-bindings/phy/phy.h>
>>> +#include <dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h>
>>> +#include <dt-bindings/power/mediatek,mt8188-power.h>
>>> +
>>> +/ {
>>> +	compatible = "mediatek,mt8188";
>>> +	interrupt-parent = <&gic>;
>>> +	#address-cells = <2>;
>>> +	#size-cells = <2>;
>>> +
>>> +	cpus {
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +
>>> +		cpu0: cpu@0 {
>>> +			device_type = "cpu";
>>> +			compatible = "arm,cortex-a55";
>>> +			reg = <0x000>;
>>> +			enable-method = "psci";
>>> +			clock-frequency = <2000000000>;
>>> +			capacity-dmips-mhz = <282>;
>>> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
>>> +			i-cache-size = <32768>;
>>> +			i-cache-line-size = <64>;
>>> +			i-cache-sets = <128>;
>>> +			d-cache-size = <32768>;
>>> +			d-cache-line-size = <64>;
>>> +			d-cache-sets = <128>;
>>> +			next-level-cache = <&l2_0>;
>>> +			#cooling-cells = <2>;
>>> +		};
>>> +
>>> +		cpu1: cpu@100 {
>>> +			device_type = "cpu";
>>> +			compatible = "arm,cortex-a55";
>>> +			reg = <0x100>;
>>> +			enable-method = "psci";
>>> +			clock-frequency = <2000000000>;
>>> +			capacity-dmips-mhz = <282>;
>>> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
>>> +			i-cache-size = <32768>;
>>> +			i-cache-line-size = <64>;
>>> +			i-cache-sets = <128>;
>>> +			d-cache-size = <32768>;
>>> +			d-cache-line-size = <64>;
>>> +			d-cache-sets = <128>;
>>> +			next-level-cache = <&l2_0>;
>>> +			#cooling-cells = <2>;
>>> +		};
>>> +
>>> +		cpu2: cpu@200 {
>>> +			device_type = "cpu";
>>> +			compatible = "arm,cortex-a55";
>>> +			reg = <0x200>;
>>> +			enable-method = "psci";
>>> +			clock-frequency = <2000000000>;
>>> +			capacity-dmips-mhz = <282>;
>>> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
>>> +			i-cache-size = <32768>;
>>> +			i-cache-line-size = <64>;
>>> +			i-cache-sets = <128>;
>>> +			d-cache-size = <32768>;
>>> +			d-cache-line-size = <64>;
>>> +			d-cache-sets = <128>;
>>> +			next-level-cache = <&l2_0>;
>>> +			#cooling-cells = <2>;
>>> +		};
>>> +
>>> +		cpu3: cpu@300 {
>>> +			device_type = "cpu";
>>> +			compatible = "arm,cortex-a55";
>>> +			reg = <0x300>;
>>> +			enable-method = "psci";
>>> +			clock-frequency = <2000000000>;
>>> +			capacity-dmips-mhz = <282>;
>>> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
>>> +			i-cache-size = <32768>;
>>> +			i-cache-line-size = <64>;
>>> +			i-cache-sets = <128>;
>>> +			d-cache-size = <32768>;
>>> +			d-cache-line-size = <64>;
>>> +			d-cache-sets = <128>;
>>> +			next-level-cache = <&l2_0>;
>>> +			#cooling-cells = <2>;
>>> +		};
>>> +
>>> +		cpu4: cpu@400 {
>>> +			device_type = "cpu";
>>> +			compatible = "arm,cortex-a55";
>>> +			reg = <0x400>;
>>> +			enable-method = "psci";
>>> +			clock-frequency = <2000000000>;
>>> +			capacity-dmips-mhz = <282>;
>>> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
>>> +			i-cache-size = <32768>;
>>> +			i-cache-line-size = <64>;
>>> +			i-cache-sets = <128>;
>>> +			d-cache-size = <32768>;
>>> +			d-cache-line-size = <64>;
>>> +			d-cache-sets = <128>;
>>> +			next-level-cache = <&l2_0>;
>>> +			#cooling-cells = <2>;
>>> +		};
>>> +
>>> +		cpu5: cpu@500 {
>>> +			device_type = "cpu";
>>> +			compatible = "arm,cortex-a55";
>>> +			reg = <0x500>;
>>> +			enable-method = "psci";
>>> +			clock-frequency = <2000000000>;
>>> +			capacity-dmips-mhz = <282>;
>>> +			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
>>> +			i-cache-size = <32768>;
>>> +			i-cache-line-size = <64>;
>>> +			i-cache-sets = <128>;
>>> +			d-cache-size = <32768>;
>>> +			d-cache-line-size = <64>;
>>> +			d-cache-sets = <128>;
>>> +			next-level-cache = <&l2_0>;
>>> +			#cooling-cells = <2>;
>>> +		};
>>> +
>>> +		cpu6: cpu@600 {
>>> +			device_type = "cpu";
>>> +			compatible = "arm,cortex-a78";
>>> +			reg = <0x600>;
>>> +			enable-method = "psci";
>>> +			clock-frequency = <2600000000>;
>>> +			capacity-dmips-mhz = <1024>;
>>> +			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
>>> +			i-cache-size = <65536>;
>>> +			i-cache-line-size = <64>;
>>> +			i-cache-sets = <256>;
>>> +			d-cache-size = <65536>;
>>> +			d-cache-line-size = <64>;
>>> +			d-cache-sets = <256>;
>>> +			next-level-cache = <&l2_1>;
>>> +			#cooling-cells = <2>;
>>> +		};
>>> +
>>> +		cpu7: cpu@700 {
>>> +			device_type = "cpu";
>>> +			compatible = "arm,cortex-a78";
>>> +			reg = <0x700>;
>>> +			enable-method = "psci";
>>> +			clock-frequency = <2600000000>;
>>> +			capacity-dmips-mhz = <1024>;
>>> +			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
>>> +			i-cache-size = <65536>;
>>> +			i-cache-line-size = <64>;
>>> +			i-cache-sets = <256>;
>>> +			d-cache-size = <65536>;
>>> +			d-cache-line-size = <64>;
>>> +			d-cache-sets = <256>;
>>> +			next-level-cache = <&l2_1>;
>>> +			#cooling-cells = <2>;
>>> +		};
>>> +
>>> +		cpu-map {
>>> +			cluster0 {
>>> +				core0 {
>>> +					cpu = <&cpu0>;
>>> +				};
>>> +
>>> +				core1 {
>>> +					cpu = <&cpu1>;
>>> +				};
>>> +
>>> +				core2 {
>>> +					cpu = <&cpu2>;
>>> +				};
>>> +
>>> +				core3 {
>>> +					cpu = <&cpu3>;
>>> +				};
>>> +
>>> +				core4 {
>>> +					cpu = <&cpu4>;
>>> +				};
>>> +
>>> +				core5 {
>>> +					cpu = <&cpu5>;
>>> +				};
>>> +
>>> +				core6 {
>>> +					cpu = <&cpu6>;
>>> +				};
>>> +
>>> +				core7 {
>>> +					cpu = <&cpu7>;
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		idle-states {
>>> +			entry-method = "psci";
>>> +
>>> +			cpu_off_l: cpu-off-l {
>>> +				compatible = "arm,idle-state";
>>> +				arm,psci-suspend-param = <0x00010000>;
>>> +				local-timer-stop;
>>> +				entry-latency-us = <50>;
>>> +				exit-latency-us = <95>;
>>> +				min-residency-us = <580>;
>>> +			};
>>> +
>>> +			cpu_off_b: cpu-off-b {
>>> +				compatible = "arm,idle-state";
>>> +				arm,psci-suspend-param = <0x00010000>;
>>> +				local-timer-stop;
>>> +				entry-latency-us = <45>;
>>> +				exit-latency-us = <140>;
>>> +				min-residency-us = <740>;
>>> +			};
>>> +
>>> +			cluster_off_l: cluster-off-l {
>>> +				compatible = "arm,idle-state";
>>> +				arm,psci-suspend-param = <0x01010010>;
>>> +				local-timer-stop;
>>> +				entry-latency-us = <55>;
>>> +				exit-latency-us = <155>;
>>> +				min-residency-us = <840>;
>>> +			};
>>> +
>>> +			cluster_off_b: cluster-off-b {
>>> +				compatible = "arm,idle-state";
>>> +				arm,psci-suspend-param = <0x01010010>;
>>> +				local-timer-stop;
>>> +				entry-latency-us = <50>;
>>> +				exit-latency-us = <200>;
>>> +				min-residency-us = <1000>;
>>> +			};
>>> +		};
>>> +
>>> +		l2_0: l2-cache0 {
>>> +			compatible = "cache";
>>> +			cache-level = <2>;
>>
>> NACK. You're not specifying the L2 cache correctly.
>>
>> Hint: the missing properties are
>> cache-size
>> cache-line-size
>> cache-sets
>>
>>> +			next-level-cache = <&l3_0>;
>>> +			cache-unified;
>>> +		};
>>> +
>>> +		l2_1: l2-cache1 {
>>> +			compatible = "cache";
>>> +			cache-level = <2>;
>>
>> Same here. Please properly define the L2 cache.
>>
>>> +			next-level-cache = <&l3_0>;
>>> +			cache-unified;
>>> +		};
>>> +
>>> +		l3_0: l3-cache {
>>> +			compatible = "cache";
>>
>> And again.
>>
>> This SoC has 256KB L2 shared between the two A78 cores, 128KB L2
>> shared
>> between the A55 cores, and 2MB of L3 cache shared across all.
>>
>>> +			cache-level = <3>;
>>> +			cache-unified;
>>> +		};
>>> +	};
>>> +
>>> +	clk13m: oscillator-13m {
>>> +		compatible = "fixed-clock";
>>> +		#clock-cells = <0>;
>>> +		clock-frequency = <13000000>;
>>> +		clock-output-names = "clk13m";
>>> +	};
>>> +
>>> +	clk26m: oscillator-26m {
>>> +		compatible = "fixed-clock";
>>> +		#clock-cells = <0>;
>>> +		clock-frequency = <26000000>;
>>> +		clock-output-names = "clk26m";
>>> +	};
>>> +
>>> +	clk32k: oscillator-32k {
>>> +		compatible = "fixed-clock";
>>> +		#clock-cells = <0>;
>>> +		clock-frequency = <32768>;
>>> +		clock-output-names = "clk32k";
>>> +	};
>>> +
>>> +	pmu-a55 {
>>> +		compatible = "arm,cortex-a55-pmu";
>>> +		interrupt-parent = <&gic>;
>>> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH
>>> &ppi_cluster0>;
>>> +	};
>>> +
>>> +	pmu-a78 {
>>> +		compatible = "arm,cortex-a78-pmu";
>>> +		interrupt-parent = <&gic>;
>>> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH
>>> &ppi_cluster1>;
>>> +	};
>>
>> Question: Is the ARM DSU PMU broken also on this SoC's TZ firmware?!
> 
> Because of security concerns, the default configuration of the ARM
> trusted firmware does not include enabling the ARM DSU PMU.
> 
> However, it is possible to add a patch to enable this feature. The
> patch https://crrev.com/c/4885752 has not been merged into TF-A yet.
> We are currently considering upstreaming it.
>

MediaTek IOT is working on the very latest Ubuntu and Suse installation
but encountered this problem, too.

I've tested this patch 'https://crrev.com/c/4885752' but it seems just
not working and we still encounter the same problem before we disable
arm_dsu_pmu module. IOT uses trusted-firmware a v2.6 currently, however 
I think this solution is the very common code should be able to applied 
to v2.6~v2.8.

After tested the patch, we still got the same error log with repeated 
msdc request timeout.
[   27.998999][   T52] mtk-msdc 11230000.mmc: msdc_request_timeout: 
aborting cmd/data/mrq
[   28.000003][   T52] mtk-msdc 11230000.mmc: msdc_request_timeout: 
aborting mrq=(____ptrval____) cmd=12
[   28.001164][   T52] mtk-msdc 11230000.mmc: msdc_request_timeout: 
aborting cmd=1

Then sometimes we got these logs maybe caused by arm_dsu_pmu.

[   32.016701][    C5] Modules linked in: arm_dsu_pmu(+) tee 
uio_pdrv_genirq uio fuse efi_pstore dmi_sysfs ip_tables x_tables 
mmc_block mt6360_regulator mt6360_charger mt6359_regulator mt6360_core 
rtc_mt6397 clk_mt8195_vdo1 clk_mt8195_vdo0 clk_mt8195_vpp1 
clk_mt8195_vpp0 mt6397 aes_ce_blk aes_ce_cipher crct10dif_ce polyval_ce 
polyval_generic ghash_ce gf128mul sm4 sha2_ce sha256_arm64 sha1_ce 
phy_mtk_tphy xhci_mtk_hcd xhci_hcd mediatek_drm clk_mt8195_apusys_pll 
clk_mt8195_venc clk_mt8195_vdec clk_mt8195_ccu clk_mt8195_cam mtk_sd 
usbcore clk_mt8195_ipe nvmem_mtk_efuse mtk_mutex cqhci mtk_mmsys 
clk_mt8195_wpe clk_mt8195_img usb_common mtk_cmdq_helper mmc_core 
mtk_cmdq_mailbox clk_mt8195_mfg clk_mt8195_imp_iic_wrap i2c_mt65xx 
clk_mt8195_scp_adsp mtk_adsp_mailbox mtk_pmic_wrap mtk_wdt gpio_keys 
btrfs blake2b_generic libcrc32c xor xor_neon zlib_deflate raid6_pq sg 
dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua scsi_mod 
scsi_common efivarfs
[   32.027269][    C5] CPU: 5 PID: 568 Comm: (udev-worker) Tainted: G 
    D            6.5.6-1-default #1 openSUSE Tumbleweed 
38b4d9532851795bcba8386ef05b62c1f3d07352
[   32.029120][    C5] Hardware name: Unknown Unknown Product/Unknown 
Product, BIOS 2022.10 10/01/2022
[   32.030258][    C5] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT 
-SSBS BTYPE=--)
[   32.031224][    C5] pc : smp_call_function_many_cond+0x164/0x5e8
[   32.031989][    C5] lr : smp_call_function_many_cond+0x124/0x5e8
[   32.032747][    C5] sp : ffff80008399b9d0
[   32.033254][    C5] x29: ffff80008399b9d0 x28: 0000000000000000 x27: 
0000000000000005
[   32.034246][    C5] x26: ffff0001fef735c0 x25: 0000000000000008 x24: 
ffff80008284edc0
[   32.035236][    C5] x23: 0000000000000000 x22: ffff80008021e010 x21: 
ffff800082852f68
[   32.036225][    C5] x20: ffff0001fef2e780 x19: ffff0001fef2e788 x18: 
0000000000000000
[   32.037213][    C5] x17: 65645f6166660000 x16: 7265747369676572 x15: 
65675f6363636d73
[   32.038202][    C5] x14: 1b124f16170a1e12 x13: 0000000000000003 x12: 
4444334144323643
[   32.039191][    C5] x11: 0101010101010101 x10: 00000000023ff788 x9 : 
ffff800080763918
[   32.040181][    C5] x8 : ffff0001fef2e7d0 x7 : 0000000000000007 x6 : 
00000000000000ff
[   32.041169][    C5] x5 : ffff80008284e000 x4 : 0000000000000000 x3 : 
ffff0001fee935c8
[   32.042159][    C5] x2 : 0000000000000000 x1 : 0000000000000011 x0 : 
0000000000000000
[   32.043148][    C5] Call trace:
[   32.043548][    C5]  smp_call_function_many_cond+0x164/0x5e8
[   32.044264][    C5]  kick_all_cpus_sync+0x4c/0x80
[   32.044859][    C5]  load_module+0x1e64/0x25c8
[   32.045427][    C5]  __do_sys_init_module+0x324/0x388
[   32.046069][    C5]  __arm64_sys_init_module+0x24/0x38
[   32.046722][    C5]  invoke_syscall+0x78/0x100
[   32.047286][    C5]  el0_svc_common.constprop.0+0x100/0x130
[   32.047989][    C5]  do_el0_svc+0x40/0xa8
[   32.048497][    C5]  el0_svc+0x34/0x138
[   32.048986][    C5]  el0t_64_sync_handler+0x120/0x130
[   32.049626][    C5]  el0t_64_sync+0x1a8/0x1b0

The only solution I've tested working is which I've posted before when 
discussion set 'arm_dsu_pmu' to 'fail' in mt8195.dtsi.
https://lore.kernel.org/linux-arm-kernel/1c639f51-a444-c8c8-8585-2e413243c3a6@collabora.com/T/#md1556b50c2fea38e5d0163decfd0768b331737b0

Hope this test result will help.

> In the next version, I will rectify the issues mentioned in the other
> comments. Thank you for your review.
> 
>>> +
>>> +	psci {
>>> +		compatible = "arm,psci-1.0";
>>> +		method = "smc";
>>> +	};
>>> +
>>> +	timer: timer {
>>> +		compatible = "arm,armv8-timer";
>>> +		interrupt-parent = <&gic>;
>>> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
>>> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH 0>,
>>> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH 0>,
>>> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH 0>;
>>> +		clock-frequency = <13000000>;
>>> +	};
>>> +
>>> +	soc {
>>> +		#address-cells = <2>;
>>> +		#size-cells = <2>;
>>> +		compatible = "simple-bus";
>>> +		ranges;
>>> +
>>> +		gic: interrupt-controller@c000000 {
>>> +			compatible = "arm,gic-v3";
>>> +			#interrupt-cells = <4>;
>>> +			#redistributor-regions = <1>;
>>> +			interrupt-parent = <&gic>;
>>> +			interrupt-controller;
>>> +			reg = <0 0x0c000000 0 0x40000>,
>>> +			      <0 0x0c040000 0 0x200000>;
>>> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
>>> +
>>> +			ppi-partitions {
>>> +				ppi_cluster0: interrupt-partition-0 {
>>> +					affinity = <&cpu0 &cpu1 &cpu2
>>> &cpu3 &cpu4 &cpu5>;
>>> +				};
>>> +
>>> +				ppi_cluster1: interrupt-partition-1 {
>>> +					affinity = <&cpu6 &cpu7>;
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		topckgen: syscon@10000000 {
>>> +			compatible = "mediatek,mt8188-topckgen",
>>> "syscon";
>>> +			reg = <0 0x10000000 0 0x1000>;
>>> +			#clock-cells = <1>;
>>> +		};
>>> +
>>> +		infracfg_ao: syscon@10001000 {
>>> +			compatible = "mediatek,mt8188-infracfg-ao",
>>> "syscon";
>>> +			reg = <0 0x10001000 0 0x1000>;
>>> +			#clock-cells = <1>;
>>> +		};
>>> +
>>> +		pericfg: syscon@10003000 {
>>> +			compatible = "mediatek,mt8188-pericfg",
>>> "syscon";
>>> +			reg = <0 0x10003000 0 0x1000>;
>>> +			#clock-cells = <1>;
>>> +		};
>>> +
>>> +		pio: pinctrl@10005000 {
>>> +			compatible = "mediatek,mt8188-pinctrl";
>>> +			reg = <0 0x10005000 0 0x1000>,
>>> +			      <0 0x11c00000 0 0x1000>,
>>> +			      <0 0x11e10000 0 0x1000>,
>>> +			      <0 0x11e20000 0 0x1000>,
>>> +			      <0 0x11ea0000 0 0x1000>,
>>> +			      <0 0x1000b000 0 0x1000>;
>>> +			reg-names = "iocfg0", "iocfg_rm",
>>> +				    "iocfg_lt", "iocfg_lm", "iocfg_rt",
>>> +				    "eint";
>>
>> 			reg-names = "iocfg0", "iocfg_rm", "iocfg_lt",
>> 				    "iocfg_lm", "iocfg_rt", "eint";
>>
>> one less line :-)
>>
>>> +			gpio-controller;
>>> +			#gpio-cells = <2>;
>>> +			gpio-ranges = <&pio 0 0 176>;
>>> +			interrupt-controller;
>>> +			interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH
>>> 0>;
>>> +			#interrupt-cells = <2>;
>>> +		};
>>> +
>>> +		watchdog: watchdog@10007000 {
>>> +			compatible = "mediatek,mt8188-wdt";
>>> +			mediatek,disable-extrst;
>>> +			reg = <0 0x10007000 0 0x100>;
>>
>> mediatek,disable-extrst goes here.
>>
>>> +			#reset-cells = <1>;
>>> +		};
>>> +
>>> +		apmixedsys: syscon@1000c000 {
>>> +			compatible = "mediatek,mt8188-apmixedsys",
>>> "syscon";
>>> +			reg = <0 0x1000c000 0 0x1000>;
>>> +			#clock-cells = <1>;
>>> +		};
>>> +
>>> +		systimer: timer@10017000 {
>>> +			compatible = "mediatek,mt8188-timer",
>>> "mediatek,mt6765-timer";
>>> +			reg = <0 0x10017000 0 0x1000>;
>>> +			reg-names = "sys_timer_base";
>>
>> You don't need reg-names here but anyway, if you really want to keep
>> that, please
>> no underscores when possible.
>>
>>> +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH
>>> 0>;
>>> +			clocks = <&clk13m>;
>>> +		};
>>> +
>>
>> Regards,
>> Angelo
> 
> Regards,
> Jason

There's an another issue.

Could you help to upstream USB port with mtu3 enabled.
I've heard that the limitation for mtu3 and xhci port has be resolved 
for MT8188. If you could upstream mtu3 nodes in MT8188.dtsi that will 
help for testing mtu3 on all Chromebook platforms. Otherwise MediaTek 
IOT will need to upstream mtu3 nodes to MT8188.dtsi later but we have no 
Chromebook platforms to test.

Thanks
Macpaul Lin
