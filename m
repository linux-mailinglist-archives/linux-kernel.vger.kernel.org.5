Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9669876EE4B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbjHCPh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbjHCPhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:37:25 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A8530FD
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biqu3d.com;
        s=tfld2305; t=1691077029;
        bh=9gR8EfRLLcyMeGWly5/HvK67+JY7FOtNotS0puIr8oA=;
        h=Message-ID:Date:MIME-Version:From:Subject:To;
        b=rYQeU9qAMB/wDHZofn0B6D24ZISnqkiLVjKKJMkDonoMaeqD39fWbixBG53eCqDx1
         9cOkG72MPyR1Izt5eUDdzabJzVDtlF9SsY5Lw/gEYZTe/nm+ynHtcmSTMr0Tz4rfGw
         xU95OY37vRZzYgJxwCrQZr6HTnVhC7LZSjpn9gRE=
X-QQ-mid: bizesmtp70t1691076970tkfqopq0
Received: from [192.168.2.144] ( [178.41.211.221])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Aug 2023 23:35:58 +0800 (CST)
X-QQ-SSF: 01400000000000402000000A0000000
X-QQ-FEAT: ILHsT53NKPhExMrQTtHRWeqBpigyiLp84nd9C0uTJ3ht3uZ9y7oWMiZAQa+HG
        VvPU3W43PhPxPEI2Ce100EEDeHhJwyqoI9H+b+M3m3ZcgkdLXa2GXtQ2FOBftGMHIPP7F+D
        Ahpj8gCjRRfxh5uTbiLuOEXNTOMnEF7NrECFcUMSFbbRr5uNzZGlaoLCb1OGAlVjYTbRUsy
        MHpRPOhce4FjQqfeVVtHJtvVpUYSAVBUJuh79w8tQnvtf3AcGeqQkONgrUUqlM9Pyr6eKtD
        3tzKupoG+DXzfVPPstO6l6b/pZZFdEOJlDv88jZcKyiK2ujjzXOfgXUyIjXxgZ4JKS+gNTX
        eXfJ6zei6YieoqJCp12zzH9cQ1wb+BHLIqWsxmva5AYmXZjsKjTxvG45ESgJAFW8jQ2wEKW
        /u3LE262wUs=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13249128308258952451
Message-ID: <4272045580294B4A+21851d6a-9a8f-8141-bc31-8398a03663c9@biqu3d.com>
Date:   Thu, 3 Aug 2023 17:35:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Martin Botka <martin@biqu3d.com>
Subject: Re: [PATCH v1 5/6] arm64: dts: allwinner: h616: Add BigTreeTech CB1
 SoM & boards support
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <uwu@icenowy.me>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Andrew Lunn <andrew@lunn.ch>, Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230802220309.163804-1-martin@biqu3d.com>
 <85E425AED000D34C+20230802220309.163804-6-martin@biqu3d.com>
 <20230803133746.20cd7b04@donnerap.manchester.arm.com>
Content-Language: en-US
In-Reply-To: <20230803133746.20cd7b04@donnerap.manchester.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:biqu3d.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/23 2:37 PM, Andre Przywara wrote:
> On Thu,  3 Aug 2023 00:02:38 +0200
> Martin Botka <martin@biqu3d.com> wrote:
> 
> Hi Martin,
> 
> thanks for sending this!
> There are some whitespace errors in here, some leading tabs in the first
> section. "git show" should print them in red.
> 
>> From: Martin Botka <martin.botka@somainline.org>
>>
>> CB1 is Compute Module style board that plugs into Rpi board style adapter or
>> Manta 3D printer boards (M4P/M8P).
>>
>> The SoM features:
>>    - H616 SoC
>>    - 1GiB of RAM
>>    - AXP313A PMIC
>>    - RTL8189FTV WiFi
>>
>> Boards feature:
>>    - 4x USB via USB2 hub (usb1 on SoM).
>>    - SDcard slot for loading images.
>>    - Ethernet port wired to the internal PHY. (100M)
>>    - 2x HDMI 2.0. (Only 1 usable on CB1)
>>    - Power and Status LEDs. (Only Status LED usable on CB1)
>>    - 40 pin GPIO header
>>
>> Currently working:
>>    - Booting
>>    - USB
>>    - UART
>>    - MMC
>>    - Status LED
>>    - WiFi (RTL8189FS via out of tree driver)
>>
>> I didnt want to duplicate things so the manta DTS can also be used on BTT pi4b adapter.
>> CB1 SoM has its own DTSI file in case other boards shows up that accept this SoM.
>>
>> Signed-off-by: Martin Botka <martin.botka@somainline.org>
>> ---
>>   arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>>   .../sun50i-h616-bigtreetech-cb1-manta.dts     |  20 +++
>>   .../sun50i-h616-bigtreetech-cb1.dtsi          | 164 ++++++++++++++++++
>>   3 files changed, 185 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
>>   create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
>> index 6a96494a2e0a..7b386428510b 100644
>> --- a/arch/arm64/boot/dts/allwinner/Makefile
>> +++ b/arch/arm64/boot/dts/allwinner/Makefile
>> @@ -38,5 +38,6 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
>>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
>>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
>>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
>> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-cb1-manta.dtb
>>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
>>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
>> new file mode 100644
>> index 000000000000..dff5b592a97a
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
>> @@ -0,0 +1,20 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
>> +/*
>> + * Copyright (C) 2023 Martin Botka <martin.botka@somainline.org>.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "sun50i-h616-bigtreetech-cb1.dtsi"
>> +
>> +/ {
>> +	compatible = "bigtreetech,cb1-manta", "bigtreetech,cb1", "allwinner,sun50i-h616";
>> +};
>> +
>> +&ehci1 {
>> +	status = "okay";
>> +};
>> +
>> +&ohci1 {
>> +	status = "okay";
>> +};
> 
> So how is the STM32 connected? Via SPI? If yes, you should activate the SPI
> node and specify the pinctrl.
> Even if this requires a patch cable to connect the SPI header coming from
> the CB1 to the SPI pins on the STM (does it?), it might be worth stating
> the pins used. I don't know for sure if we enable interfaces that are
> routed to fixed function header pins, but it might be worth doing so here,
> since this is some very obvious use case (I guess you wouldn't buy the M8P
> if you don't plan to use all of its goodies).
So the STM32 chip is connected directly via USB. There is USB hub on 
Manta boards and Pi adapter (Not on BTT Pi. That one doesnt use USB hub)
that uses this USB port and STM32 connects via that. Then on manta 
boards there are 2 USB ports and 1 USB port with just pins exposed on
XH2.54 4 pin connector. Bit weird but it is what it is :)
> 
> And what's the USB-C connector doing? Is that an alternative power supply?
> Ann does it connect the port0 D-/D+ pins, so can be used for OTG? If yes,
> please enable the usb_otg node here.
> 
It is indeed an alternative power supply. Or well primary supply in the 
case of Pi adapter board.

It should be connected yes. Tho i never really had much luck getting it 
to work. Tho i will check again and if i get it to work i will enable it 
in V2 :)
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
>> new file mode 100644
>> index 000000000000..e630114f0ce4
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
>> @@ -0,0 +1,164 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
>> +/*
>> + * Copyright (C) 2023 Martin Botka <martin.botka@somainline.org>.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "sun50i-h616.dtsi"
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/leds/common.h>
>> +
>> +/ {
>> +	model = "BigTreeTech CB1";
>> +	compatible = "bigtreetech,cb1", "allwinner,sun50i-h616";
>> +
>> +	aliases {
>> +		serial0 = &uart0;
>> +		ethernet0 = &rtl8189ftv;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
> 
> I think stdout-path belongs into the board .dts.
>

Got it

>> +	
>> +	leds {
>> +		compatible = "gpio-leds";
>> +
>> +		led-0 {
>> +			function = LED_FUNCTION_STATUS;
>> +			color = <LED_COLOR_ID_GREEN>;
>> +			gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
>> +		};
>> +	};
>> +
>> +	reg_vcc5v: regulator-vcc5v {
>> +		/* board wide 5V supply directly from the USB-C socket */
> 
> I guess this "regulator" is still valid, but please adjust the comment,
> since there is certainly no USB-C socket on the SoM. I guess it's multiple
> pins on the SoM connector that supply the incoming base voltage?
Correct. Its just pins that get the 5V power. My fault for saying 
directly from USB-C since it can be from somewhere else :)
> 
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc-5v";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		regulator-always-on;
>> +	};
>> +
>> +	reg_usb1_vbus: regulator-usb1-vbus {
> 
> So is this regulator really on the SoM? Or is it just PC16 on the SoM
> connector, and the actual regulator chip is on the respective carrier
> boards?
> 

This is my bad. This is completely wrong. The actual regulator is the 5V 
one thats turned on when 5V comes in. Its bit weird but i suppose its 
done that way for USB-OTG. This will be removed in next revision of this 
DTS :)
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "usb1-vbus";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		vin-supply = <&reg_vcc5v>;
>> +		enable-active-high;
>> +		gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>; /* PC16 */
>> +	};
>> +	
>> +	reg_vcc33_wifi: vcc33-wifi {
>> +		/* Always on 3.3V regulator for WiFi and BT */
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc33-wifi";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-always-on;
>> +		vin-supply = <&reg_vcc5v>;
>> +	};
>> +	
>> +	reg_vcc_wifi_io: vcc-wifi-io {
>> +		/* Always on 1.8V/300mA regulator for WiFi and BT IO */
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc-wifi-io";
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +		regulator-always-on;
>> +		vin-supply = <&reg_vcc33_wifi>;
>> +	};
>> +
>> +	wifi_pwrseq: wifi-pwrseq {
>> +		compatible = "mmc-pwrseq-simple";
>> +		clocks = <&rtc 1>;
>> +		clock-names = "ext_clock";
>> +		reset-gpios = <&pio 6 18 GPIO_ACTIVE_LOW>;  /* PG18 */
>> +		post-power-on-delay-ms = <200>;
>> +	};
>> +};
>> +
>> +&mmc0 {
>> +	vmmc-supply = <&reg_dldo1>;
>> +	broken-cd;
> 
> Is there no card detect switch or is it not wired up, or is it really
> "broken"? Might be good to have a comment explaining that.
> And yeah, I also forgot to do this in my Orange Pi Zero3 .dts ;-)
> 
Its just straight up not connected. And since documentation specifies 
that this should be set when no card detection is available i set it.

Will add a comment specifying that this is due to the pin not being 
connected.
>> +	bus-width = <4>;
>> +	status = "okay";
>> +};
>> +
>> +&mmc1 {
>> +	vmmc-supply = <&reg_vcc33_wifi>;
>> +	vqmmc-supply = <&reg_vcc_wifi_io>;
>> +	mmc-pwrseq = <&wifi_pwrseq>;
>> +	bus-width = <4>;
>> +	non-removable;
>> +	mmc-ddr-1_8v;
>> +	status = "okay";
>> +
>> +	rtl8189ftv: sdio_wifi@1 {
>> +		reg = <1>;
>> +	};
>> +};
>> +
>> +&r_i2c {
>> +	status = "okay";
>> +
>> +	axp313a: pmic@36 {
>> +		compatible = "x-powers,axp313a";
>> +		reg = <0x36>;
>> +		interrupt-controller;
>> +		#interrupt-cells = <1>;
>> +
>> +		regulators{
>> +			reg_dcdc1: dcdc1 {
>> +				regulator-name = "vdd-gpu";
>> +				regulator-min-microvolt = <500000>;
>> +				regulator-max-microvolt = <3400000>;
> 
> So those are the ranges of the PMIC rail, but if this is really connected
> to VDD_GPU on the H616, you should limit it to between 0.81V and 0.99V, as
> described in the H616 datasheet. Otherwise this risks frying the SoC, I
> guess.

The range here should be correct. It is also the sys rail. Since AXP313a 
lacks many rails this was chosen as the sys rail as well.
> 
>> +				regulator-always-on;
> 
> So is this connected to something else as well, like VDD_SYS? Please
> either mention this as a comment, to justify the always-on, or name the
> regulator accordingly, like "vdd-gpu-sys".
Will rename to vdd-gpu-sys.
>   
>> +			};
>> +
>> +			reg_dcdc2: dcdc2 {
>> +				regulator-name = "vdd-cpu";
>> +				regulator-min-microvolt = <500000>;
>> +				regulator-max-microvolt = <1540000>;
> 
> Same limit problem here, VDD_CPU must be between 0.81V and 1.1V.
That is indeed right. I will test it on the range you provided with OPP 
(WIP) and stress test it :)
> 
>> +				regulator-ramp-delay = <200>;
>> +				regulator-always-on;
>> +			};
>> +
>> +			reg_dcdc3: dcdc3 {
>> +				regulator-name = "vcc-dram";
>> +				regulator-min-microvolt = <500000>;
>> +				regulator-max-microvolt = <1840000>;
> 
> Is that DDR3 or DDR3L DRAM here? I don't think there is any runtime
> adjustments here, so just specify the respective voltage required, with the
> same value for both min and max.
it uses Kingston D2516ECMDXGJD so DDR3. I will specify the direct voltage.
> 
>> +				regulator-always-on;
>> +			};
>> +
>> +			reg_aldo1: aldo1 {
>> +				regulator-name = "vcc-1v8";
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-always-on;
> 
> Please mention what this supplies that justifies always-on.
ALDO1 1.8V gets also converted to 1.8V for DRAM. Thus needs to be on always.
> 
>> +			};
>> +
>> +			reg_dldo1: dldo1 {
>> +				regulator-name = "vcc-3v3";
>> +				regulator-min-microvolt = <3300000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-always-on;
> 
> Please mention what this supplies that justifies always-on.
SDcard that serves as storage for system. Will add comments for both :)
> 
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&uart0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart0_ph_pins>;
>> +	status = "okay";
>> +};
> 
> This belongs into the board .dts, since the connector/UART bridge is
> there.
Actually the SoM has exposed pads to connect UART (Which is what i have 
done to get UART) but also the boards get the exact pins wired to GPIO.

But since most users would use the GPIO UART i will specify it in 
carrier boards and in BTT Pi boards separately.

Cheers,
Martin
> 
> Cheers,
> Andre
> 
>> +
>> +&usbphy {
>> +	usb1_vbus-supply = <&reg_usb1_vbus>;
>> +	status = "okay";
>> +};
> 
> 


