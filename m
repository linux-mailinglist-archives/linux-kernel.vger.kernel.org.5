Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2E57B5AF8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbjJBTMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjJBTMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:12:43 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEC6B0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 12:12:38 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4053c6f0db8so1028885e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 12:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696273957; x=1696878757; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHVeSx31xaVBrYfr/e6WkvZEFNn1CFrL818kKLc+PM8=;
        b=NtXgKrcfzmaumIHKiBaY4lkMXYp4zVWumScai2PD6x8tbg2x6UVm3xKdm2tWGnocjK
         mRKMqKLOR4nxyMiw+c5RL4KOZ+61hwGSZGgg03ROocgl/mdn+4ndffywcl4R87uLG1LH
         Xy6insKNugiI1QOeMNSqbPAz/KIEATzCQMEw4rhAgxDTrDqJEPyfMkbTIhY2rQ6Vf2S0
         Jn7ogL1Zz+kpf3F5XzZRIGfShZBCdf5q6C4WjHy/V6vlGSuvEBRAiodyBS4eqcpPNFlo
         6FnnBEvy5sY5WRbeeLl7gEYMDDuVdvaZgV5lCdh962k0O6lJNawzPsoFEa4B/8Phd+ld
         p34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696273957; x=1696878757;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHVeSx31xaVBrYfr/e6WkvZEFNn1CFrL818kKLc+PM8=;
        b=QTmz65DoDvV6UlGO9V47/4qM7q+2djOL/Y45/OSxnHXKiZjf7AJ3ImxEtNtqjjGNOY
         FDPLyojLZ3aGoXiLvwD7/aABOCe4v8Qo8UdalIEJrK5rMbQ4dMs4hSUoe/gH2b+Bx5gX
         jOC03qRzBt4kOeAqG8N/u1NY4pBiAUlAb6EKkGfdlb6wOtLkbEjX7sJ74r3htnVCDPP0
         nclbJRUGLWOEIMcOysQWSqbldbnfegAY2EyR5aae5LRUscDHtKMsoEvamR2yL7+8sY6W
         6i1z9aSGXhuPfo/aEYn5jN53nVzkIhkKN4ZS+kmjjumzBqucgGI97HV3okHmqRy1qEU5
         oGkQ==
X-Gm-Message-State: AOJu0YztOEYS4jgV8ehyWJgoZO5wbthM4P1G5TbFAiCpoNfvW0mjWj90
        I5JHuCK/Zkuh3z1+HFw25eIMDw==
X-Google-Smtp-Source: AGHT+IGGJVWJNO6Ojhnq89ltEhmujQK55MDPYwEnJoPfYogeYnC3fUWU1M1wxFzVdtz3yl3hbwaMwg==
X-Received: by 2002:a05:600c:2904:b0:406:517f:ac79 with SMTP id i4-20020a05600c290400b00406517fac79mr10788291wmd.39.1696273956860;
        Mon, 02 Oct 2023 12:12:36 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:d00c:5f38:6504:396d])
        by smtp.gmail.com with ESMTPSA id n9-20020a7bcbc9000000b004060f0a0fdbsm7842127wmi.41.2023.10.02.12.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 12:12:36 -0700 (PDT)
References: <20231002141020.2403652-1-jbrunet@baylibre.com>
 <20231002141020.2403652-3-jbrunet@baylibre.com>
 <b81a296d-0640-4b2e-aab6-c9de37d10206@linaro.org>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>, Da Xue <da.xue@libretech.co>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: amlogic: add libretech cottonwood support
Date:   Mon, 02 Oct 2023 20:57:01 +0200
In-reply-to: <b81a296d-0640-4b2e-aab6-c9de37d10206@linaro.org>
Message-ID: <1j5y3ozvmk.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 02 Oct 2023 at 18:45, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Hi,
>
> On 02/10/2023 16:10, Jerome Brunet wrote:
>> Add support for the Libretech cottonwood board family.
>> These 2 boards are based on the same PCB, with an RPi B form factor.
>> The "Alta" board uses an a311d while the "Solitude" variant uses an
>> s905d3.
>> Co-developed-by: Da Xue <da.xue@libretech.co>
>> Signed-off-by: Da Xue <da.xue@libretech.co>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>   arch/arm64/boot/dts/amlogic/Makefile          |   2 +
>>   .../amlogic/meson-g12b-a311d-libretech-cc.dts | 133 ++++
>>   .../amlogic/meson-libretech-cottonwood.dtsi   | 610 ++++++++++++++++++
>>   .../amlogic/meson-sm1-s905d3-libretech-cc.dts |  89 +++
>>   4 files changed, 834 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-a311d-libretech-cc.dts
>>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi
>>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-s905d3-libretech-cc.dts
>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile
>> b/arch/arm64/boot/dts/amlogic/Makefile
>> index 4ce401d17b63..cc8b34bd583d 100644
>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>> @@ -18,6 +18,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-g12b-bananapi-cm4-cm4io.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gsking-x.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking-pro.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking.dtb
>> +dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-libretech-cc.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-go-ultra.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2-plus.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
>> @@ -73,6 +74,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-sm1-bananapi-m2-pro.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-bananapi-m5.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-h96-max.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l.dtb
>> +dtb-$(CONFIG_ARCH_MESON) += meson-sm1-s905d3-libretech-cc.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-c4.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-libretech-cc.dts
>> new file mode 100644
>> index 000000000000..fc890e235dbd
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-libretech-cc.dts
>> @@ -0,0 +1,133 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2023 BayLibre, SAS.
>> + * Author: Jerome Brunet <jbrunet@baylibre.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/clock/g12a-clkc.h>
>> +#include "meson-g12b-a311d.dtsi"
>> +#include "meson-libretech-cottonwood.dtsi"
>> +
>> +/ {
>> +	compatible = "libretech,aml-a311d-cc", "amlogic,a311d", "amlogic,g12b";
>> +	model = "Libre Computer AML-A311D-CC Alta";
>> +
>> +	vddcpu_a: regulator-vddcpu-a {
>> +		compatible = "pwm-regulator";
>> +		regulator-name = "VDDCPU_A";
>> +		regulator-min-microvolt = <730000>;
>> +		regulator-max-microvolt = <1011000>;
>> +		regulator-boot-on;
>> +		regulator-always-on;
>> +		pwm-supply = <&dc_in>;
>> +		pwms = <&pwm_ab 0 1250 0>;
>> +		pwm-dutycycle-range = <100 0>;
>> +	};
>> +
>> +	sound {
>> +		model = "Alta";
>
> I think those sound model properties should be coherent with the
> other Libre Computer boards:
> arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi:         model = "LIBRETECH-PC";
> arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts:           model = "LIBRETECH-AC";
> arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts:                model = "LIBRETECH-CC-V2";
> arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts:           model = "LIBRETECH-CC";

"LIBRETECH-CC-" leave very little room to play with
That's not really something that could have been anticipated 5+ years ago

>
> It's ok to change the scheme since it's tried to keep the name under the 15 characters limit,
> will the next board keep this naming ?

I don't know what the next board will be so I can hardly make any prediction
I'm open to suggestion if you prefer something else

>
>
>> +		audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
>> +				"TDMOUT_A IN 1", "FRDDR_B OUT 0",
>> +				"TDMOUT_A IN 2", "FRDDR_C OUT 0",
>> +				"TDM_A Playback", "TDMOUT_A OUT",
>> +				"TDMOUT_B IN 0", "FRDDR_A OUT 1",
>> +				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
>> +				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
>> +				"TDM_B Playback", "TDMOUT_B OUT",
>> +				"TDMOUT_C IN 0", "FRDDR_A OUT 2",
>> +				"TDMOUT_C IN 1", "FRDDR_B OUT 2",
>> +				"TDMOUT_C IN 2", "FRDDR_C OUT 2",
>> +				"TDM_C Playback", "TDMOUT_C OUT",
>> +				"TDMIN_A IN 0", "TDM_A Capture",
>> +				"TDMIN_B IN 0", "TDM_A Capture",
>> +				"TDMIN_C IN 0", "TDM_A Capture",
>> +				"TDMIN_A IN 3", "TDM_A Loopback",
>> +				"TDMIN_B IN 3", "TDM_A Loopback",
>> +				"TDMIN_C IN 3", "TDM_A Loopback",
>> +				"TDMIN_A IN 1", "TDM_B Capture",
>> +				"TDMIN_B IN 1", "TDM_B Capture",
>> +				"TDMIN_C IN 1", "TDM_B Capture",
>> +				"TDMIN_A IN 4", "TDM_B Loopback",
>> +				"TDMIN_B IN 4", "TDM_B Loopback",
>> +				"TDMIN_C IN 4", "TDM_B Loopback",
>> +				"TDMIN_A IN 2", "TDM_C Capture",
>> +				"TDMIN_B IN 2", "TDM_C Capture",
>> +				"TDMIN_C IN 2", "TDM_C Capture",
>> +				"TDMIN_A IN 5", "TDM_C Loopback",
>> +				"TDMIN_B IN 5", "TDM_C Loopback",
>> +				"TDMIN_C IN 5", "TDM_C Loopback",
>> +				"TODDR_A IN 0", "TDMIN_A OUT",
>> +				"TODDR_B IN 0", "TDMIN_A OUT",
>> +				"TODDR_C IN 0", "TDMIN_A OUT",
>> +				"TODDR_A IN 1", "TDMIN_B OUT",
>> +				"TODDR_B IN 1", "TDMIN_B OUT",
>> +				"TODDR_C IN 1", "TDMIN_B OUT",
>> +				"TODDR_A IN 2", "TDMIN_C OUT",
>> +				"TODDR_B IN 2", "TDMIN_C OUT",
>> +				"TODDR_C IN 2", "TDMIN_C OUT",
>> +				"Lineout", "ACODEC LOLP",
>> +				"Lineout", "ACODEC LORP";
>> +	};
>> +};
>> +
>> +&cpu_opp_table_0 {
>> +		opp-1800000000 {
>> +			opp-hz = /bits/ 64 <1800000000>;
>> +			opp-microvolt = <1001000>;
>> +		};
>> +
>> +		opp-2016000000 {
>> +			opp-hz = /bits/ 64 <2016000000>;
>> +			opp-microvolt = <1011000>;
>> +		};
>> +};
>> +
>> +&cpu0 {
>> +	cpu-supply = <&vddcpu_b>;
>> +	operating-points-v2 = <&cpu_opp_table_0>;
>> +	clocks = <&clkc CLKID_CPU_CLK>;
>> +	clock-latency = <50000>;
>> +};
>> +
>> +&cpu1 {
>> +	cpu-supply = <&vddcpu_b>;
>> +	operating-points-v2 = <&cpu_opp_table_0>;
>> +	clocks = <&clkc CLKID_CPU_CLK>;
>> +	clock-latency = <50000>;
>> +};
>> +
>> +&cpu100 {
>> +	cpu-supply = <&vddcpu_a>;
>> +	operating-points-v2 = <&cpub_opp_table_1>;
>> +	clocks = <&clkc CLKID_CPUB_CLK>;
>> +	clock-latency = <50000>;
>> +};
>> +
>> +&cpu101 {
>> +	cpu-supply = <&vddcpu_a>;
>> +	operating-points-v2 = <&cpub_opp_table_1>;
>> +	clocks = <&clkc CLKID_CPUB_CLK>;
>> +	clock-latency = <50000>;
>> +};
>> +
>> +&cpu102 {
>> +	cpu-supply = <&vddcpu_a>;
>> +	operating-points-v2 = <&cpub_opp_table_1>;
>> +	clocks = <&clkc CLKID_CPUB_CLK>;
>> +	clock-latency = <50000>;
>> +};
>> +
>> +&cpu103 {
>> +	cpu-supply = <&vddcpu_a>;
>> +	operating-points-v2 = <&cpub_opp_table_1>;
>> +	clocks = <&clkc CLKID_CPUB_CLK>;
>> +	clock-latency = <50000>;
>> +};
>> +
>> +&pwm_ab {
>> +	pinctrl-0 = <&pwm_a_e_pins>, <&pwm_b_x7_pins>;
>> +	clocks = <&xtal>, <&xtal>;
>> +	clock-names = "clkin0", "clkin1";
>> +};
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi b/arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi
>> new file mode 100644
>> index 000000000000..a7fc8963ff54
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi
>> @@ -0,0 +1,610 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2023 BayLibre, SAS.
>> + * Author: Jerome Brunet <jbrunet@baylibre.com>
>> + */
>> +
>> +#include <dt-bindings/clock/g12a-clkc.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/leds/common.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/gpio/meson-g12a-gpio.h>
>> +#include <dt-bindings/sound/meson-g12a-toacodec.h>
>> +#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>> +
>> +/ {
>> +	aliases {
>> +		serial0 = &uart_AO;
>> +		ethernet0 = &ethmac;
>> +		spi0 = &spifc;
>> +	};
>> +
>> +	memory@0 {
>> +		device_type = "memory";
>> +		reg = <0x0 0x0 0x0 0x80000000>;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	dioo2133: audio-amplifier-0 {
>> +		compatible = "simple-audio-amplifier";
>> +		enable-gpios = <&gpio GPIOX_0 GPIO_ACTIVE_HIGH>;
>> +		VCC-supply = <&vcc_5v>;
>> +		sound-name-prefix = "10U2";
>> +	};
>> +
>> +	/* TOFIX: handle CVBS_DET on SARADC channel 0 */
>> +	cvbs-connector {
>> +		compatible = "composite-video-connector";
>> +
>> +		port {
>> +			cvbs_connector_in: endpoint {
>> +				remote-endpoint = <&cvbs_vdac_out>;
>> +			};
>> +		};
>> +	};
>> +
>> +	emmc_pwrseq: emmc-pwrseq {
>> +		compatible = "mmc-pwrseq-emmc";
>> +		reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
>> +	};
>> +
>> +	hdmi-connector {
>> +		compatible = "hdmi-connector";
>> +		type = "a";
>> +
>> +		port {
>> +			hdmi_connector_in: endpoint {
>> +				remote-endpoint = <&hdmi_tx_tmds_out>;
>> +			};
>> +		};
>> +	};
>> +
>> +	leds-pwm {
>> +		compatible = "pwm-leds";
>> +
>> +		led-green {
>> +			color = <LED_COLOR_ID_GREEN>;
>> +			function = LED_FUNCTION_STATUS;
>> +			linux,default-trigger = "default-on";
>> +			panic-indicator;
>> +			max-brightness = <255>;
>> +			pwms = <&pwm_cd 1 1250 0>;
>> +			active-low;
>> +		};
>> +
>> +		led-blue {
>> +			color = <LED_COLOR_ID_BLUE>;
>> +			function = LED_FUNCTION_ACTIVITY;
>> +			linux,default-trigger = "activity";
>> +			max-brightness = <255>;
>> +			pwms = <&pwm_ab 1 1250 0>;
>> +			active-low;
>> +		};
>> +	};
>> +
>> +	leds-gpio {
>> +		compatible = "gpio-leds";
>> +
>> +		led-orange {
>> +			color = <LED_COLOR_ID_AMBER>;
>> +			function = LED_FUNCTION_STANDBY;
>> +			gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
>> +		};
>> +	};
>> +
>> +	dc_in: regulator-dc-in {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "5V_IN";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		regulator-always-on;
>> +	};
>> +
>> +	flash_1v8: regulator-flash-1v8 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "FLASH_1V8";
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +		regulator-always-on;
>> +		vin-supply = <&vcc_3v3>;
>> +	};
>> +
>> +	vcc_card: regulator-vcc-card {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "VCC_CARD";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		vin-supply = <&vddao_3v3>;
>> +		gpio = <&gpio GPIOX_2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>> +		enable-active-high;
>> +		gpio-open-drain;
>> +	};
>> +
>> +	vcc_3v3: regulator-vcc-3v3 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "VCC_3V3";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-always-on;
>> +		vin-supply = <&vddao_3v3>;
>> +
>> +		/* FIXME: controlled by TEST_N */
>> +	};
>> +
>> +	vcc_5v: regulator-vcc-5v {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "VCC_5V";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		regulator-always-on;
>> +		vin-supply = <&dc_in>;
>> +		gpio = <&gpio GPIOH_8 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>> +		enable-active-high;
>> +		gpio-open-drain;
>> +	};
>> +
>> +	vddao_3v3: regulator-vddao_3v3 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "VDDAO_3V3";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-always-on;
>> +		vin-supply = <&dc_in>;
>> +	};
>> +
>> +	vddcpu_b: regulator-vddcpu-b {
>> +		compatible = "pwm-regulator";
>> +		regulator-name = "VDDCPU_B";
>> +		regulator-min-microvolt = <730000>;
>> +		regulator-max-microvolt = <1011000>;
>> +		regulator-boot-on;
>> +		regulator-always-on;
>> +		pwm-supply = <&dc_in>;
>> +		pwms = <&pwm_AO_cd 1 1250 0>;
>> +		pwm-dutycycle-range = <100 0>;
>> +	};
>> +
>> +	vddio_ao18: regulator-vddio_ao18 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "VDDIO_AO18";
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +		regulator-always-on;
>> +		vin-supply = <&vddao_3v3>;
>> +	};
>> +
>> +	vddio_c: regulator-vddio_c {
>> +		compatible = "regulator-gpio";
>> +		regulator-name = "VDDIO_C";
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-settling-time-up-us = <200>;
>> +		regulator-settling-time-down-us = <50000>;
>> +		vin-supply = <&vddao_3v3>;
>> +		gpios = <&gpio GPIOX_4 GPIO_ACTIVE_HIGH>;
>> +		states = <3300000 0>,
>> +			 <1800000 1>;
>> +	};
>> +
>> +	sound {
>> +		compatible = "amlogic,axg-sound-card";
>> +		audio-widgets = "Line", "Lineout";
>> +		audio-aux-devs = <&tdmout_a>, <&tdmout_b>, <&tdmout_c>,
>> +				 <&tdmin_a>, <&tdmin_b>, <&tdmin_c>,
>> +				 <&dioo2133>;
>> +
>> +		assigned-clocks = <&clkc CLKID_MPLL2>,
>> +				  <&clkc CLKID_MPLL0>,
>> +				  <&clkc CLKID_MPLL1>;
>> +		assigned-clock-parents = <0>, <0>, <0>;
>> +		assigned-clock-rates = <294912000>,
>> +				       <270950400>,
>> +				       <393216000>;
>> +
>> +		dai-link-0 {
>> +			sound-dai = <&frddr_a>;
>> +		};
>> +
>> +		dai-link-1 {
>> +			sound-dai = <&frddr_b>;
>> +		};
>> +
>> +		dai-link-2 {
>> +			sound-dai = <&frddr_c>;
>> +		};
>> +
>> +		dai-link-3 {
>> +			sound-dai = <&toddr_a>;
>> +		};
>> +
>> +		dai-link-4 {
>> +			sound-dai = <&toddr_b>;
>> +		};
>> +
>> +		dai-link-5 {
>> +			sound-dai = <&toddr_c>;
>> +		};
>> +
>> +		/*
>> +		 * Audio setup: The 40 pins header provides access to 2 TDMs,
>> +		 * SPDIF In/Out and PDM inputs.
>> +		 * - TDM A: 2 lanes
>> +		 *    D0:    40/X9
>> +		 *    D1:    38/X8
>> +		 *    BCLK:  12/X11
>> +		 *    FS:    35/X10
>> +		 * - TDM B: 4 lanes
>> +		 *    D0:    37/A3
>> +		 *    D1:    16/A4
>> +		 *    D2:    18/A5 or 7/AO6
>> +		 *    D3:    22/A6 or 21/H5
>> +		 *    BCLK:  29/A1 or 8/AO8
>> +		 *    FS:    31/A2 or 11/AO7
>> +		 * - 2 Master Clocks:
>> +		 *    MCLK0: 15/A0 or 10/AO9
>> +		 *    MCLK1: 33/X15
>> +		 * - SPDIF:
>> +		 *    OUT:   32/A11
>> +		 *    IN:    21/H5
>> +		 * - PDM Input:
>> +		 *    DO:    13/A8
>> +		 *    D1:    26/A9
>> +		 *    D2:    22/A6
>> +		 *    D3:    18/A5
>> +		 *    DCLK:  36/A7
>> +		 *
>> +		 * TDM C is not usable on the 40 pins connector so it is
>> +		 * setup for the HDMI 4 lanes i2s.
>> +		 *
>> +		 * No pinctrl is enabled by default to preserve the
>> +		 * genericity of the 40 pins header. Many configurations are
>> +		 * possible based on the desired use case. Please adjust TDM
>> +		 * masks, clock setups and pinctrl accordingly.
>> +		 */
>> +
>> +		dai-link-6 {
>> +			sound-dai = <&tdmif_a>;
>> +			dai-format = "dsp_a";
>> +			dai-tdm-slot-tx-mask-0 = <1 1>;
>> +			mclk-fs = <256>;
>> +
>> +			codec-0 {
>> +				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_A>;
>> +			};
>> +
>> +			codec-1 {
>> +				sound-dai = <&toacodec TOACODEC_IN_A>;
>> +			};
>> +		};
>> +
>> +		dai-link-7 {
>> +			sound-dai = <&tdmif_b>;
>> +			dai-format = "i2s";
>> +			dai-tdm-slot-tx-mask-0 = <1 1>;
>> +			dai-tdm-slot-rx-mask-1 = <1 1>;
>> +			mclk-fs = <256>;
>> +
>> +			codec-0 {
>> +				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
>> +			};
>> +
>> +			codec-1 {
>> +				sound-dai = <&toacodec TOACODEC_IN_B>;
>> +			};
>> +		};
>> +
>> +		dai-link-8 {
>> +			sound-dai = <&tdmif_c>;
>> +			dai-format = "i2s";
>> +			dai-tdm-slot-tx-mask-0 = <1 1>;
>> +			dai-tdm-slot-tx-mask-1 = <1 1>;
>> +			dai-tdm-slot-tx-mask-2 = <1 1>;
>> +			dai-tdm-slot-tx-mask-3 = <1 1>;
>> +			mclk-fs = <256>;
>> +
>> +			codec-0 {
>> +				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_C>;
>> +			};
>> +
>> +			codec-1 {
>> +				sound-dai = <&toacodec TOACODEC_IN_C>;
>> +			};
>> +		};
>> +
>> +		dai-link-9 {
>> +			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
>> +
>> +			codec {
>> +				sound-dai = <&hdmi_tx>;
>> +			};
>> +		};
>> +
>> +		dai-link-10 {
>> +			sound-dai = <&toacodec TOACODEC_OUT>;
>> +
>> +			codec {
>> +				sound-dai = <&acodec>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&acodec {
>> +	status = "okay";
>> +	AVDD-supply = <&vddio_ao18>;
>> +};
>> +
>> +&arb {
>> +	status = "okay";
>> +};
>> +
>> +&cecb_AO {
>> +	status = "okay";
>> +	pinctrl-0 = <&cec_ao_b_h_pins>;
>> +	pinctrl-names = "default";
>> +	hdmi-phandle = <&hdmi_tx>;
>> +};
>> +
>> +&clkc_audio {
>> +	status = "okay";
>> +};
>> +
>> +&cvbs_vdac_port {
>> +	cvbs_vdac_out: endpoint {
>> +		remote-endpoint = <&cvbs_connector_in>;
>> +	};
>> +};
>> +
>> +&ethmac {
>> +	pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>, <&eth_phy_irq_pins>;
>> +	pinctrl-names = "default";
>> +	status = "okay";
>> +	phy-mode = "rgmii";
>> +	phy-handle = <&external_phy>;
>> +	amlogic,tx-delay-ns = <2>;
>> +};
>> +
>> +&ext_mdio {
>> +	external_phy: ethernet-phy@0 {
>> +		/* Realtek RTL8211F (0x001cc916) */
>> +		reg = <0>;
>> +		max-speed = <1000>;
>> +
>> +		reset-assert-us = <100000>;
>> +		reset-deassert-us = <100000>;
>> +		reset-gpios = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
>> +
>> +		interrupt-parent = <&gpio_intc>;
>> +		/* MAC_INTR on GPIOZ_14 */
>> +		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
>> +	};
>> +};
>> +
>> +&frddr_a {
>> +	status = "okay";
>> +};
>> +
>> +&frddr_b {
>> +	status = "okay";
>> +};
>> +
>> +&frddr_c {
>> +	status = "okay";
>> +};
>> +
>> +&hdmi_tx {
>> +	status = "okay";
>> +	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
>> +	pinctrl-names = "default";
>> +	hdmi-supply = <&vcc_5v>;
>> +};
>> +
>> +&hdmi_tx_tmds_port {
>> +	hdmi_tx_tmds_out: endpoint {
>> +		remote-endpoint = <&hdmi_connector_in>;
>> +	};
>> +};
>> +
>> +&ir {
>> +	status = "okay";
>> +	pinctrl-0 = <&remote_input_ao_pins>;
>> +	pinctrl-names = "default";
>> +};
>> +
>> +&npu {
>> +	status = "okay";
>> +};
>
> Are you sure you want this enabled ?
> AFAIK if etnaviv is enabled, it will be used first as a render node by mesa and fail.
>

AFAIK, it is enabled in the pre-flashed bootloader that is running
debian, fedora and opensuse ... but etnaviv is blacklisted there

It should indeed be removed.


>> +
>> +&periphs_pinctrl {
>> +	spi_cs_disable_pins: spi-cs-disable {
>> +		mux {
>> +			groups = "BOOT_14";
>> +			function = "gpio_periphs";
>> +			bias-disable;
>> +			output-high;
>> +		};
>> +	};
>> +
>> +	eth_phy_irq_pins: eth-phy-irq {
>> +		mux {
>> +			groups = "GPIOZ_14";
>> +			function = "gpio_periphs";
>> +			bias-pull-up;
>> +			output-disable;
>> +		};
>> +	};
>> +};
>> +
>> +&pwm_AO_cd {
>> +	status = "okay";
>> +	pinctrl-0 = <&pwm_ao_d_e_pins>;
>> +	pinctrl-names = "default";
>> +	clocks = <&xtal>;
>> +	clock-names = "clkin1";
>> +};
>> +
>> +&pwm_ab {
>> +	status = "okay";
>> +	pinctrl-0 = <&pwm_b_x7_pins>;
>> +	pinctrl-names = "default";
>> +	clocks = <&xtal>;
>> +	clock-names = "clkin1";
>> +};
>> +
>> +&pwm_cd {
>> +	status = "okay";
>> +	pinctrl-0 = <&pwm_d_x3_pins>;
>> +	pinctrl-names = "default";
>> +	clocks = <&xtal>;
>> +	clock-names = "clkin1";
>> +};
>> +
>> +&saradc {
>> +	status = "okay";
>> +	vref-supply = <&vddio_ao18>;
>> +};
>> +
>> +/* SD card */
>> +&sd_emmc_b {
>> +	status = "okay";
>> +	pinctrl-0 = <&sdcard_c_pins>;
>> +	pinctrl-1 = <&sdcard_clk_gate_c_pins>;
>> +	pinctrl-names = "default", "clk-gate";
>> +
>> +	bus-width = <4>;
>> +	cap-sd-highspeed;
>> +	sd-uhs-sdr12;
>> +	sd-uhs-sdr25;
>> +	sd-uhs-sdr50;
>> +	sd-uhs-sdr104;
>> +	max-frequency = <200000000>;
>> +	disable-wp;
>> +
>> +	cd-gpios = <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
>> +	vmmc-supply = <&vcc_card>;
>> +	vqmmc-supply = <&vddio_c>;
>> +};
>> +
>> +/*
>> + * EMMC_D4, EMMC_D5, EMMC_D6 and EMMC_D7 pins are shared between SPI NOR CS
>> + * and eMMC Data 4 to 7 pins.
>> + * Replace emmc_data_8b_pins to emmc_data_4b_pins from sd_emmc_c pinctrl-0,
>> + * and change bus-width to 4 then spifc can be enabled.
>> + */
>> +&sd_emmc_c {
>> +	status = "okay";
>> +	pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_8b_pins>, <&emmc_ds_pins>,
>> +		    <&spi_cs_disable_pins>;
>> +	pinctrl-1 = <&emmc_clk_gate_pins>;
>> +	pinctrl-names = "default", "clk-gate";
>> +
>> +	bus-width = <8>;
>> +	cap-mmc-highspeed;
>> +	mmc-hs200-1_8v;
>> +	max-frequency = <200000000>;
>> +	disable-wp;
>> +
>> +	mmc-pwrseq = <&emmc_pwrseq>;
>> +	vmmc-supply = <&vcc_3v3>;
>> +	vqmmc-supply = <&flash_1v8>;
>> +};
>> +
>> +&spifc {
>> +	status = "disabled";
>> +	pinctrl-0 = <&nor_pins>;
>> +	pinctrl-names = "default";
>> +	cs-gpios = <&gpio BOOT_14 GPIO_ACTIVE_LOW>;
>> +
>> +	w25lq128d: flash@0 {
>> +		compatible = "jedec,spi-nor";
>> +		reg = <0>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		spi-max-frequency = <80000000>;
>> +	};
>> +};
>> +
>> +&tdmif_a {
>> +	status = "okay";
>> +};
>> +
>> +&tdmif_b {
>> +	status = "okay";
>> +};
>> +
>> +&tdmif_c {
>> +	status = "okay";
>> +};
>> +
>> +&tdmin_a {
>> +	status = "okay";
>> +};
>> +
>> +&tdmin_b {
>> +	status = "okay";
>> +};
>> +
>> +&tdmin_c {
>> +	status = "okay";
>> +};
>> +
>> +&tdmout_a {
>> +	status = "okay";
>> +};
>> +
>> +&tdmout_b {
>> +	status = "okay";
>> +};
>> +
>> +&tdmout_c {
>> +	status = "okay";
>> +};
>> +
>> +&toacodec {
>> +	status = "okay";
>> +};
>> +
>> +&toddr_a {
>> +	status = "okay";
>> +};
>> +
>> +&toddr_b {
>> +	status = "okay";
>> +};
>> +
>> +&toddr_c {
>> +	status = "okay";
>> +};
>> +
>> +&tohdmitx {
>> +	status = "okay";
>> +};
>> +
>> +&uart_AO {
>> +	status = "okay";
>> +	pinctrl-0 = <&uart_ao_a_pins>;
>> +	pinctrl-names = "default";
>> +};
>> +
>> +&usb2_phy1 {
>> +	phy-supply = <&dc_in>;
>> +};
>> +
>> +&usb3_pcie_phy {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	phy-supply = <&vcc_5v>;
>> +
>> +	hub: hub@1 {
>> +		compatible = "usb5e3,626";
>> +		reg = <1>;
>> +		reset-gpios = <&gpio GPIOC_7 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
>> +	};
>
> Not sure the PHY is the right place to put the USB HUB,
> and it's probable the HUB is connected to both the USB2 and USB3 lines

It is connected to the USB3.0 only

> so you should have both USB IDs in DT like it'd done for the Odroid-C4:
>
> / {
> ...
>          /* USB hub supports both USB 2.0 and USB 3.0 root hub */
>          usb-hub {
>                  dr_mode = "host";
>                  #address-cells = <1>;
>                  #size-cells = <0>;
>
>                  /* 2.0 hub on port 1 */
>                  hub_2_0: hub@1 {
>                          compatible = "usb2109,2817";
>                          reg = <1>;
>                          peer-hub = <&hub_3_0>;
>                          reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
>                          vdd-supply = <&vcc_5v>;
>                  };
>
>                  /* 3.1 hub on port 4 */
>                  hub_3_0: hub@2 {
>                          compatible = "usb2109,817";
>                          reg = <2>;
>                          peer-hub = <&hub_2_0>;
>                          reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
>                          vdd-supply = <&vcc_5v>;
>                  };
>          };
> ...
> };
>
> if it only has a single USB ID, then it should go under the dwc3 node.

The usb controller is connected to the PHY and what's coming out of the PHY
goes to the hub. It seems logical to hub the hub under it.

Why bypass the PHY ?

>
>> +};
>> +
>> +&usb {
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-s905d3-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-s905d3-libretech-cc.dts
>> new file mode 100644
>> index 000000000000..077e7506ce4f
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-s905d3-libretech-cc.dts
>> @@ -0,0 +1,89 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2023 BayLibre, SAS.
>> + * Author: Jerome Brunet <jbrunet@baylibre.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/clock/g12a-clkc.h>
>> +#include "meson-sm1.dtsi"
>> +#include "meson-libretech-cottonwood.dtsi"
>> +
>> +/ {
>> +	compatible = "libretech,aml-s905d3-cc", "amlogic,sm1";
>> +	model = "Libre Computer AML-S905D3-CC Solitude";
>> +
>> +	sound {
>> +		model = "Solitude";
>> +		audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
>> +				"TDMOUT_A IN 1", "FRDDR_B OUT 0",
>> +				"TDMOUT_A IN 2", "FRDDR_C OUT 0",
>> +				"TDM_A Playback", "TDMOUT_A OUT",
>> +				"TDMOUT_B IN 0", "FRDDR_A OUT 1",
>> +				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
>> +				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
>> +				"TDM_B Playback", "TDMOUT_B OUT",
>> +				"TDMOUT_C IN 0", "FRDDR_A OUT 2",
>> +				"TDMOUT_C IN 1", "FRDDR_B OUT 2",
>> +				"TDMOUT_C IN 2", "FRDDR_C OUT 2",
>> +				"TDM_C Playback", "TDMOUT_C OUT",
>> +				"TDMIN_A IN 0", "TDM_A Capture",
>> +				"TDMIN_B IN 0", "TDM_A Capture",
>> +				"TDMIN_C IN 0", "TDM_A Capture",
>> +				"TDMIN_A IN 13", "TDM_A Loopback",
>> +				"TDMIN_B IN 13", "TDM_A Loopback",
>> +				"TDMIN_C IN 13", "TDM_A Loopback",
>> +				"TDMIN_A IN 1", "TDM_B Capture",
>> +				"TDMIN_B IN 1", "TDM_B Capture",
>> +				"TDMIN_C IN 1", "TDM_B Capture",
>> +				"TDMIN_A IN 14", "TDM_B Loopback",
>> +				"TDMIN_B IN 14", "TDM_B Loopback",
>> +				"TDMIN_C IN 14", "TDM_B Loopback",
>> +				"TDMIN_A IN 2", "TDM_C Capture",
>> +				"TDMIN_B IN 2", "TDM_C Capture",
>> +				"TDMIN_C IN 2", "TDM_C Capture",
>> +				"TDMIN_A IN 15", "TDM_C Loopback",
>> +				"TDMIN_B IN 15", "TDM_C Loopback",
>> +				"TDMIN_C IN 15", "TDM_C Loopback",
>> +				"TODDR_A IN 0", "TDMIN_A OUT",
>> +				"TODDR_B IN 0", "TDMIN_A OUT",
>> +				"TODDR_C IN 0", "TDMIN_A OUT",
>> +				"TODDR_A IN 1", "TDMIN_B OUT",
>> +				"TODDR_B IN 1", "TDMIN_B OUT",
>> +				"TODDR_C IN 1", "TDMIN_B OUT",
>> +				"TODDR_A IN 2", "TDMIN_C OUT",
>> +				"TODDR_B IN 2", "TDMIN_C OUT",
>> +				"TODDR_C IN 2", "TDMIN_C OUT",
>> +				"Lineout", "ACODEC LOLP",
>> +				"Lineout", "ACODEC LORP";
>> +	};
>> +};
>> +
>> +&cpu0 {
>> +	cpu-supply = <&vddcpu_b>;
>> +	operating-points-v2 = <&cpu_opp_table>;
>> +	clocks = <&clkc CLKID_CPU_CLK>;
>> +	clock-latency = <50000>;
>> +};
>> +
>> +&cpu1 {
>> +	cpu-supply = <&vddcpu_b>;
>> +	operating-points-v2 = <&cpu_opp_table>;
>> +	clocks = <&clkc CLKID_CPU1_CLK>;
>> +	clock-latency = <50000>;
>> +};
>> +
>> +&cpu2 {
>> +	cpu-supply = <&vddcpu_b>;
>> +	operating-points-v2 = <&cpu_opp_table>;
>> +	clocks = <&clkc CLKID_CPU2_CLK>;
>> +	clock-latency = <50000>;
>> +};
>> +
>> +&cpu3 {
>> +	cpu-supply = <&vddcpu_b>;
>> +	operating-points-v2 = <&cpu_opp_table>;
>> +	clocks = <&clkc CLKID_CPU3_CLK>;
>> +	clock-latency = <50000>;
>> +};
>
> Apart that, it looks fine,
>
>
> Thanks,
> Neil

