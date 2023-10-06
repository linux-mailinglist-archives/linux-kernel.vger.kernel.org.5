Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8F67BB668
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjJFL1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjJFL1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:27:43 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5445C5
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 04:27:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3231dff4343so1249615f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 04:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696591658; x=1697196458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlbCnY4MLwcqo8rUOxy0cqAEhYPqbqUwZkA+t5HQ5ME=;
        b=Kh63fpbOgWDwHcfxQel3iOCGyarRWKWIQGsVK719Hq3YIf2wBYHxpNymi7U9WG9izk
         c+6ITyP1evxrWp+54Bvkb4Se+8u/KsiipY9kiIdLv6LEvjQwWtX6MAtYX7Sri1aLzz0D
         fNDc/n/VUG43xlNBpGcklULNBTL4n/us4iA0nGvLMvKKGysuxOCss4u6EBkLG3zneQUz
         1ZhAWMslJlUbKpayTaIIp/TrsIRHXzLhTi3B7FoZkfggtN1sS85rBV+jjwHXuAjBWlsR
         T4d6fEC8H9yjUtsxpVhOlrnmRQUW6AcCsqceJ1aHJTqilXALRjaYIOmA8RfAS4FV2aNK
         IBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696591658; x=1697196458;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vlbCnY4MLwcqo8rUOxy0cqAEhYPqbqUwZkA+t5HQ5ME=;
        b=LX5MtwOUsC7XwxZEmwJ2aNVopbvQoZm1kyw8cRE0xyT7s72H6FtxsugKXr3rI/Z4sh
         lC1ZtbepHEbpahk16HKEJeKk9Pi38eWkqDVqQJu+cGrKLwD7NSVFKqLbj+VDC6WCaGw0
         tQCGdUqm/kZEVjQWlBkEmJTy1BbU6CaAzKfAbJTjGYJGYMW0ijwl7mOAk+n1KcWdZhir
         3BBK+X8GJdbtJOu+CK+7384RMmlIFBkG8sCEr+1KCd6o8TN1tkYJA/bBOITFk1gAIveL
         caiXMsUapDaJLGVwKkBvrsuCNEmP2V+jkjRb66tEeuLgMIxOUSVmwOCfFoh7w02heu7Q
         RdfA==
X-Gm-Message-State: AOJu0Ywa57LLj+UgVUcnnhzVJF6jp0Pp1uWWJJtvAYUV/OuE8Mvns06R
        MdtmTmNdlYMoP1Or1/OJM0Jlwg==
X-Google-Smtp-Source: AGHT+IFSQBvoznp1/QZWrn/l+1xk/diVq124fo1ApzjM3c8Zx3vEg60eDDnpzv8GYQxcFuClKMQulg==
X-Received: by 2002:a5d:6b4b:0:b0:323:1ded:311f with SMTP id x11-20020a5d6b4b000000b003231ded311fmr3586433wrw.25.1696591658068;
        Fri, 06 Oct 2023 04:27:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c8f7:4bc7:2e11:c133? ([2a01:e0a:982:cbb0:c8f7:4bc7:2e11:c133])
        by smtp.gmail.com with ESMTPSA id a8-20020a5d4568000000b00327bf4f2f16sm1427603wrc.30.2023.10.06.04.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 04:27:37 -0700 (PDT)
Message-ID: <be8130b1-3d19-4b5e-8a9d-a1e376619a69@linaro.org>
Date:   Fri, 6 Oct 2023 13:27:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/2] arm64: dts: amlogic: add libretech cottonwood
 support
Content-Language: en-US, fr
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>, Da Xue <da.xue@libretech.co>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <20231006103500.2015183-1-jbrunet@baylibre.com>
 <20231006103500.2015183-3-jbrunet@baylibre.com>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20231006103500.2015183-3-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2023 12:35, Jerome Brunet wrote:
> Add support for the Libretech cottonwood board family.
> These 2 boards are based on the same PCB, with an RPi B form factor.
> 
> The "Alta" board uses an a311d while the "Solitude" variant uses an s905d3.
> 
> Co-developed-by: Da Xue <da.xue@libretech.co>
> Signed-off-by: Da Xue <da.xue@libretech.co>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   arch/arm64/boot/dts/amlogic/Makefile          |   2 +
>   .../amlogic/meson-g12b-a311d-libretech-cc.dts | 121 ++++
>   .../amlogic/meson-libretech-cottonwood.dtsi   | 614 ++++++++++++++++++
>   .../amlogic/meson-sm1-s905d3-libretech-cc.dts |  89 +++
>   4 files changed, 826 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-a311d-libretech-cc.dts
>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi
>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-s905d3-libretech-cc.dts
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index 4ce401d17b63..cc8b34bd583d 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -18,6 +18,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-g12b-bananapi-cm4-cm4io.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gsking-x.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking-pro.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-libretech-cc.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-go-ultra.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2-plus.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
> @@ -73,6 +74,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-sm1-bananapi-m2-pro.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-bananapi-m5.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-h96-max.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-sm1-s905d3-libretech-cc.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-c4.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-libretech-cc.dts
> new file mode 100644
> index 000000000000..65b963d794cd
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-libretech-cc.dts
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2023 BayLibre, SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/clock/g12a-clkc.h>
> +#include "meson-g12b-a311d.dtsi"
> +#include "meson-libretech-cottonwood.dtsi"
> +
> +/ {
> +	compatible = "libretech,aml-a311d-cc", "amlogic,a311d", "amlogic,g12b";
> +	model = "Libre Computer AML-A311D-CC Alta";
> +
> +	vddcpu_a: regulator-vddcpu-a {
> +		compatible = "pwm-regulator";
> +		regulator-name = "VDDCPU_A";
> +		regulator-min-microvolt = <730000>;
> +		regulator-max-microvolt = <1011000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +		pwm-supply = <&dc_in>;
> +		pwms = <&pwm_ab 0 1250 0>;
> +		pwm-dutycycle-range = <100 0>;
> +	};
> +
> +	sound {
> +		model = "LC-ALTA";
> +		audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
> +				"TDMOUT_A IN 1", "FRDDR_B OUT 0",
> +				"TDMOUT_A IN 2", "FRDDR_C OUT 0",
> +				"TDM_A Playback", "TDMOUT_A OUT",
> +				"TDMOUT_B IN 0", "FRDDR_A OUT 1",
> +				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
> +				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
> +				"TDM_B Playback", "TDMOUT_B OUT",
> +				"TDMOUT_C IN 0", "FRDDR_A OUT 2",
> +				"TDMOUT_C IN 1", "FRDDR_B OUT 2",
> +				"TDMOUT_C IN 2", "FRDDR_C OUT 2",
> +				"TDM_C Playback", "TDMOUT_C OUT",
> +				"TDMIN_A IN 0", "TDM_A Capture",
> +				"TDMIN_B IN 0", "TDM_A Capture",
> +				"TDMIN_C IN 0", "TDM_A Capture",
> +				"TDMIN_A IN 3", "TDM_A Loopback",
> +				"TDMIN_B IN 3", "TDM_A Loopback",
> +				"TDMIN_C IN 3", "TDM_A Loopback",
> +				"TDMIN_A IN 1", "TDM_B Capture",
> +				"TDMIN_B IN 1", "TDM_B Capture",
> +				"TDMIN_C IN 1", "TDM_B Capture",
> +				"TDMIN_A IN 4", "TDM_B Loopback",
> +				"TDMIN_B IN 4", "TDM_B Loopback",
> +				"TDMIN_C IN 4", "TDM_B Loopback",
> +				"TDMIN_A IN 2", "TDM_C Capture",
> +				"TDMIN_B IN 2", "TDM_C Capture",
> +				"TDMIN_C IN 2", "TDM_C Capture",
> +				"TDMIN_A IN 5", "TDM_C Loopback",
> +				"TDMIN_B IN 5", "TDM_C Loopback",
> +				"TDMIN_C IN 5", "TDM_C Loopback",
> +				"TODDR_A IN 0", "TDMIN_A OUT",
> +				"TODDR_B IN 0", "TDMIN_A OUT",
> +				"TODDR_C IN 0", "TDMIN_A OUT",
> +				"TODDR_A IN 1", "TDMIN_B OUT",
> +				"TODDR_B IN 1", "TDMIN_B OUT",
> +				"TODDR_C IN 1", "TDMIN_B OUT",
> +				"TODDR_A IN 2", "TDMIN_C OUT",
> +				"TODDR_B IN 2", "TDMIN_C OUT",
> +				"TODDR_C IN 2", "TDMIN_C OUT",
> +				"Lineout", "ACODEC LOLP",
> +				"Lineout", "ACODEC LORP";
> +	};
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&vddcpu_b>;
> +	operating-points-v2 = <&cpu_opp_table_0>;
> +	clocks = <&clkc CLKID_CPU_CLK>;
> +	clock-latency = <50000>;
> +};
> +
> +&cpu1 {
> +	cpu-supply = <&vddcpu_b>;
> +	operating-points-v2 = <&cpu_opp_table_0>;
> +	clocks = <&clkc CLKID_CPU_CLK>;
> +	clock-latency = <50000>;
> +};
> +
> +&cpu100 {
> +	cpu-supply = <&vddcpu_a>;
> +	operating-points-v2 = <&cpub_opp_table_1>;
> +	clocks = <&clkc CLKID_CPUB_CLK>;
> +	clock-latency = <50000>;
> +};
> +
> +&cpu101 {
> +	cpu-supply = <&vddcpu_a>;
> +	operating-points-v2 = <&cpub_opp_table_1>;
> +	clocks = <&clkc CLKID_CPUB_CLK>;
> +	clock-latency = <50000>;
> +};
> +
> +&cpu102 {
> +	cpu-supply = <&vddcpu_a>;
> +	operating-points-v2 = <&cpub_opp_table_1>;
> +	clocks = <&clkc CLKID_CPUB_CLK>;
> +	clock-latency = <50000>;
> +};
> +
> +&cpu103 {
> +	cpu-supply = <&vddcpu_a>;
> +	operating-points-v2 = <&cpub_opp_table_1>;
> +	clocks = <&clkc CLKID_CPUB_CLK>;
> +	clock-latency = <50000>;
> +};
> +
> +&pwm_ab {
> +	pinctrl-0 = <&pwm_a_e_pins>, <&pwm_b_x7_pins>;
> +	clocks = <&xtal>, <&xtal>;
> +	clock-names = "clkin0", "clkin1";
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi b/arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi
> new file mode 100644
> index 000000000000..ed826f673349
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi
> @@ -0,0 +1,614 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2023 BayLibre, SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + */
> +
> +#include <dt-bindings/clock/g12a-clkc.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/gpio/meson-g12a-gpio.h>
> +#include <dt-bindings/sound/meson-g12a-toacodec.h>
> +#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
> +
> +/ {
> +	aliases {
> +		serial0 = &uart_AO;
> +		ethernet0 = &ethmac;
> +		spi0 = &spifc;
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x80000000>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	dioo2133: audio-amplifier-0 {
> +		compatible = "simple-audio-amplifier";
> +		enable-gpios = <&gpio GPIOX_0 GPIO_ACTIVE_HIGH>;
> +		VCC-supply = <&vcc_5v>;
> +		sound-name-prefix = "10U2";
> +	};
> +
> +	/* TOFIX: handle CVBS_DET on SARADC channel 0 */
> +	cvbs-connector {
> +		compatible = "composite-video-connector";
> +
> +		port {
> +			cvbs_connector_in: endpoint {
> +				remote-endpoint = <&cvbs_vdac_out>;
> +			};
> +		};
> +	};
> +
> +	emmc_pwrseq: emmc-pwrseq {
> +		compatible = "mmc-pwrseq-emmc";
> +		reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&hdmi_tx_tmds_out>;
> +			};
> +		};
> +	};
> +
> +	led-blue {
> +		compatible = "pwm-leds";
> +
> +		led {
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_ACTIVITY;
> +			linux,default-trigger = "heartbeat";
> +			max-brightness = <255>;
> +			pwms = <&pwm_cd 1 1250 0>;
> +			active-low;
> +		};
> +	};
> +
> +	led-green {
> +		compatible = "pwm-leds";
> +
> +		led {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_STATUS;
> +			linux,default-trigger = "default-on";
> +			max-brightness = <255>;
> +			pwms = <&pwm_ab 1 1250 0>;
> +			active-low;
> +		};
> +	};
> +
> +	led-orange {
> +		compatible = "gpio-leds";
> +
> +		led {
> +			color = <LED_COLOR_ID_AMBER>;
> +			function = LED_FUNCTION_STANDBY;
> +			gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
> +			panic-indicator;
> +		};
> +	};
> +
> +	dc_in: regulator-dc-in {
> +		compatible = "regulator-fixed";
> +		regulator-name = "5V_IN";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	flash_1v8: regulator-flash-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "FLASH_1V8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +		vin-supply = <&vcc_3v3>;
> +	};
> +
> +	vcc_card: regulator-vcc-card {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_CARD";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vddao_3v3>;
> +		gpio = <&gpio GPIOX_2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		enable-active-high;
> +		gpio-open-drain;
> +	};
> +
> +	vcc_3v3: regulator-vcc-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		vin-supply = <&vddao_3v3>;
> +
> +		/* FIXME: controlled by TEST_N */
> +	};
> +
> +	vcc_5v: regulator-vcc-5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_5V";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		vin-supply = <&dc_in>;
> +		gpio = <&gpio GPIOH_8 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		enable-active-high;
> +		gpio-open-drain;
> +	};
> +
> +	vddao_3v3: regulator-vddao_3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDAO_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		vin-supply = <&dc_in>;
> +	};
> +
> +	vddcpu_b: regulator-vddcpu-b {
> +		compatible = "pwm-regulator";
> +		regulator-name = "VDDCPU_B";
> +		regulator-min-microvolt = <730000>;
> +		regulator-max-microvolt = <1011000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +		pwm-supply = <&dc_in>;
> +		pwms = <&pwm_AO_cd 1 1250 0>;
> +		pwm-dutycycle-range = <100 0>;
> +	};
> +
> +	vddio_ao18: regulator-vddio_ao18 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDIO_AO18";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +		vin-supply = <&vddao_3v3>;
> +	};
> +
> +	vddio_c: regulator-vddio_c {
> +		compatible = "regulator-gpio";
> +		regulator-name = "VDDIO_C";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-settling-time-up-us = <200>;
> +		regulator-settling-time-down-us = <50000>;
> +		vin-supply = <&vddao_3v3>;
> +		gpios = <&gpio GPIOX_4 GPIO_ACTIVE_HIGH>;
> +		states = <3300000 0>,
> +			 <1800000 1>;
> +	};
> +
> +	sound {
> +		compatible = "amlogic,axg-sound-card";
> +		audio-widgets = "Line", "Lineout";
> +		audio-aux-devs = <&tdmout_a>, <&tdmout_b>, <&tdmout_c>,
> +				 <&tdmin_a>, <&tdmin_b>, <&tdmin_c>,
> +				 <&dioo2133>;
> +
> +		assigned-clocks = <&clkc CLKID_MPLL2>,
> +				  <&clkc CLKID_MPLL0>,
> +				  <&clkc CLKID_MPLL1>;
> +		assigned-clock-parents = <0>, <0>, <0>;
> +		assigned-clock-rates = <294912000>,
> +				       <270950400>,
> +				       <393216000>;
> +
> +		dai-link-0 {
> +			sound-dai = <&frddr_a>;
> +		};
> +
> +		dai-link-1 {
> +			sound-dai = <&frddr_b>;
> +		};
> +
> +		dai-link-2 {
> +			sound-dai = <&frddr_c>;
> +		};
> +
> +		dai-link-3 {
> +			sound-dai = <&toddr_a>;
> +		};
> +
> +		dai-link-4 {
> +			sound-dai = <&toddr_b>;
> +		};
> +
> +		dai-link-5 {
> +			sound-dai = <&toddr_c>;
> +		};
> +
> +		/*
> +		 * Audio setup: The 40 pins header provides access to 2 TDMs,
> +		 * SPDIF In/Out and PDM inputs.
> +		 * - TDM A: 2 lanes
> +		 *    D0:    40/X9
> +		 *    D1:    38/X8
> +		 *    BCLK:  12/X11
> +		 *    FS:    35/X10
> +		 * - TDM B: 4 lanes
> +		 *    D0:    37/A3
> +		 *    D1:    16/A4
> +		 *    D2:    18/A5 or 7/AO6
> +		 *    D3:    22/A6 or 21/H5
> +		 *    BCLK:  29/A1 or 8/AO8
> +		 *    FS:    31/A2 or 11/AO7
> +		 * - 2 Master Clocks:
> +		 *    MCLK0: 15/A0 or 10/AO9
> +		 *    MCLK1: 33/X15
> +		 * - SPDIF:
> +		 *    OUT:   32/A11
> +		 *    IN:    21/H5
> +		 * - PDM Input:
> +		 *    DO:    13/A8
> +		 *    D1:    26/A9
> +		 *    D2:    22/A6
> +		 *    D3:    18/A5
> +		 *    DCLK:  36/A7
> +		 *
> +		 * TDM C is not usable on the 40 pins connector so it is
> +		 * setup for the HDMI 4 lanes i2s.
> +		 *
> +		 * No pinctrl is enabled by default to preserve the
> +		 * genericity of the 40 pins header. Many configurations are
> +		 * possible based on the desired use case. Please adjust TDM
> +		 * masks, clock setups and pinctrl accordingly.
> +		 */
> +
> +		dai-link-6 {
> +			sound-dai = <&tdmif_a>;
> +			dai-format = "dsp_a";
> +			dai-tdm-slot-tx-mask-0 = <1 1>;
> +			mclk-fs = <256>;
> +
> +			codec-0 {
> +				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_A>;
> +			};
> +
> +			codec-1 {
> +				sound-dai = <&toacodec TOACODEC_IN_A>;
> +			};
> +		};
> +
> +		dai-link-7 {
> +			sound-dai = <&tdmif_b>;
> +			dai-format = "i2s";
> +			dai-tdm-slot-tx-mask-0 = <1 1>;
> +			dai-tdm-slot-rx-mask-1 = <1 1>;
> +			mclk-fs = <256>;
> +
> +			codec-0 {
> +				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
> +			};
> +
> +			codec-1 {
> +				sound-dai = <&toacodec TOACODEC_IN_B>;
> +			};
> +		};
> +
> +		dai-link-8 {
> +			sound-dai = <&tdmif_c>;
> +			dai-format = "i2s";
> +			dai-tdm-slot-tx-mask-0 = <1 1>;
> +			dai-tdm-slot-tx-mask-1 = <1 1>;
> +			dai-tdm-slot-tx-mask-2 = <1 1>;
> +			dai-tdm-slot-tx-mask-3 = <1 1>;
> +			mclk-fs = <256>;
> +
> +			codec-0 {
> +				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_C>;
> +			};
> +
> +			codec-1 {
> +				sound-dai = <&toacodec TOACODEC_IN_C>;
> +			};
> +		};
> +
> +		dai-link-9 {
> +			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
> +
> +			codec {
> +				sound-dai = <&hdmi_tx>;
> +			};
> +		};
> +
> +		dai-link-10 {
> +			sound-dai = <&toacodec TOACODEC_OUT>;
> +
> +			codec {
> +				sound-dai = <&acodec>;
> +			};
> +		};
> +	};
> +};
> +
> +&acodec {
> +	status = "okay";
> +	AVDD-supply = <&vddio_ao18>;
> +};
> +
> +&arb {
> +	status = "okay";
> +};
> +
> +&cecb_AO {
> +	status = "okay";
> +	pinctrl-0 = <&cec_ao_b_h_pins>;
> +	pinctrl-names = "default";
> +	hdmi-phandle = <&hdmi_tx>;
> +};
> +
> +&clkc_audio {
> +	status = "okay";
> +};
> +
> +&cvbs_vdac_port {
> +	cvbs_vdac_out: endpoint {
> +		remote-endpoint = <&cvbs_connector_in>;
> +	};
> +};
> +
> +&dwc3 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	hub: hub@1 {
> +		compatible = "usb5e3,626";
> +		reg = <1>;
> +		reset-gpios = <&gpio GPIOC_7 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
> +		vdd-supply = <&vcc_5v>;
> +	};
> +};
> +
> +&ethmac {
> +	pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>, <&eth_phy_irq_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +	phy-mode = "rgmii";
> +	phy-handle = <&external_phy>;
> +	amlogic,tx-delay-ns = <2>;
> +};
> +
> +&ext_mdio {
> +	external_phy: ethernet-phy@0 {
> +		/* Realtek RTL8211F (0x001cc916) */
> +		reg = <0>;
> +		max-speed = <1000>;
> +
> +		reset-assert-us = <100000>;
> +		reset-deassert-us = <100000>;
> +		reset-gpios = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
> +
> +		interrupt-parent = <&gpio_intc>;
> +		/* MAC_INTR on GPIOZ_14 */
> +		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&frddr_a {
> +	status = "okay";
> +};
> +
> +&frddr_b {
> +	status = "okay";
> +};
> +
> +&frddr_c {
> +	status = "okay";
> +};
> +
> +&hdmi_tx {
> +	status = "okay";
> +	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
> +	pinctrl-names = "default";
> +	hdmi-supply = <&vcc_5v>;
> +};
> +
> +&hdmi_tx_tmds_port {
> +	hdmi_tx_tmds_out: endpoint {
> +		remote-endpoint = <&hdmi_connector_in>;
> +	};
> +};
> +
> +&ir {
> +	status = "okay";
> +	pinctrl-0 = <&remote_input_ao_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&periphs_pinctrl {
> +	spi_cs_disable_pins: spi-cs-disable {
> +		mux {
> +			groups = "BOOT_14";
> +			function = "gpio_periphs";
> +			bias-disable;
> +			output-high;
> +		};
> +	};
> +
> +	eth_phy_irq_pins: eth-phy-irq {
> +		mux {
> +			groups = "GPIOZ_14";
> +			function = "gpio_periphs";
> +			bias-pull-up;
> +			output-disable;
> +		};
> +	};
> +};
> +
> +&pwm_AO_cd {
> +	status = "okay";
> +	pinctrl-0 = <&pwm_ao_d_e_pins>;
> +	pinctrl-names = "default";
> +	clocks = <&xtal>;
> +	clock-names = "clkin1";
> +};
> +
> +&pwm_ab {
> +	status = "okay";
> +	pinctrl-0 = <&pwm_b_x7_pins>;
> +	pinctrl-names = "default";
> +	clocks = <&xtal>;
> +	clock-names = "clkin1";
> +};
> +
> +&pwm_cd {
> +	status = "okay";
> +	pinctrl-0 = <&pwm_d_x3_pins>;
> +	pinctrl-names = "default";
> +	clocks = <&xtal>;
> +	clock-names = "clkin1";
> +};
> +
> +&saradc {
> +	status = "okay";
> +	vref-supply = <&vddio_ao18>;
> +};
> +
> +/* SD card */
> +&sd_emmc_b {
> +	status = "okay";
> +	pinctrl-0 = <&sdcard_c_pins>;
> +	pinctrl-1 = <&sdcard_clk_gate_c_pins>;
> +	pinctrl-names = "default", "clk-gate";
> +
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	max-frequency = <200000000>;
> +	disable-wp;
> +
> +	cd-gpios = <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
> +	vmmc-supply = <&vcc_card>;
> +	vqmmc-supply = <&vddio_c>;
> +};
> +
> +/*
> + * EMMC_D4, EMMC_D5, EMMC_D6 and EMMC_D7 pins are shared between SPI NOR CS
> + * and eMMC Data 4 to 7 pins.
> + * Replace emmc_data_8b_pins to emmc_data_4b_pins from sd_emmc_c pinctrl-0,
> + * and change bus-width to 4 then spifc can be enabled.
> + */
> +&sd_emmc_c {
> +	status = "okay";
> +	pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_8b_pins>, <&emmc_ds_pins>,
> +		    <&spi_cs_disable_pins>;
> +	pinctrl-1 = <&emmc_clk_gate_pins>;
> +	pinctrl-names = "default", "clk-gate";
> +
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +	max-frequency = <200000000>;
> +	disable-wp;
> +
> +	mmc-pwrseq = <&emmc_pwrseq>;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&flash_1v8>;
> +};
> +
> +&spifc {
> +	status = "disabled";
> +	pinctrl-0 = <&nor_pins>;
> +	pinctrl-names = "default";
> +	cs-gpios = <&gpio BOOT_14 GPIO_ACTIVE_LOW>;
> +
> +	w25lq128d: flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <80000000>;
> +	};
> +};
> +
> +&tdmif_a {
> +	status = "okay";
> +};
> +
> +&tdmif_b {
> +	status = "okay";
> +};
> +
> +&tdmif_c {
> +	status = "okay";
> +};
> +
> +&tdmin_a {
> +	status = "okay";
> +};
> +
> +&tdmin_b {
> +	status = "okay";
> +};
> +
> +&tdmin_c {
> +	status = "okay";
> +};
> +
> +&tdmout_a {
> +	status = "okay";
> +};
> +
> +&tdmout_b {
> +	status = "okay";
> +};
> +
> +&tdmout_c {
> +	status = "okay";
> +};
> +
> +&toacodec {
> +	status = "okay";
> +};
> +
> +&toddr_a {
> +	status = "okay";
> +};
> +
> +&toddr_b {
> +	status = "okay";
> +};
> +
> +&toddr_c {
> +	status = "okay";
> +};
> +
> +&tohdmitx {
> +	status = "okay";
> +};
> +
> +&uart_AO {
> +	status = "okay";
> +	pinctrl-0 = <&uart_ao_a_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&usb2_phy1 {
> +	phy-supply = <&dc_in>;
> +};
> +
> +&usb3_pcie_phy {
> +	phy-supply = <&vcc_5v>;
> +};
> +
> +&usb {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-s905d3-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-s905d3-libretech-cc.dts
> new file mode 100644
> index 000000000000..537370db360f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-s905d3-libretech-cc.dts
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2023 BayLibre, SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/clock/g12a-clkc.h>
> +#include "meson-sm1.dtsi"
> +#include "meson-libretech-cottonwood.dtsi"
> +
> +/ {
> +	compatible = "libretech,aml-s905d3-cc", "amlogic,sm1";
> +	model = "Libre Computer AML-S905D3-CC Solitude";
> +
> +	sound {
> +		model = "LC-SOLITUDE";
> +		audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
> +				"TDMOUT_A IN 1", "FRDDR_B OUT 0",
> +				"TDMOUT_A IN 2", "FRDDR_C OUT 0",
> +				"TDM_A Playback", "TDMOUT_A OUT",
> +				"TDMOUT_B IN 0", "FRDDR_A OUT 1",
> +				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
> +				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
> +				"TDM_B Playback", "TDMOUT_B OUT",
> +				"TDMOUT_C IN 0", "FRDDR_A OUT 2",
> +				"TDMOUT_C IN 1", "FRDDR_B OUT 2",
> +				"TDMOUT_C IN 2", "FRDDR_C OUT 2",
> +				"TDM_C Playback", "TDMOUT_C OUT",
> +				"TDMIN_A IN 0", "TDM_A Capture",
> +				"TDMIN_B IN 0", "TDM_A Capture",
> +				"TDMIN_C IN 0", "TDM_A Capture",
> +				"TDMIN_A IN 13", "TDM_A Loopback",
> +				"TDMIN_B IN 13", "TDM_A Loopback",
> +				"TDMIN_C IN 13", "TDM_A Loopback",
> +				"TDMIN_A IN 1", "TDM_B Capture",
> +				"TDMIN_B IN 1", "TDM_B Capture",
> +				"TDMIN_C IN 1", "TDM_B Capture",
> +				"TDMIN_A IN 14", "TDM_B Loopback",
> +				"TDMIN_B IN 14", "TDM_B Loopback",
> +				"TDMIN_C IN 14", "TDM_B Loopback",
> +				"TDMIN_A IN 2", "TDM_C Capture",
> +				"TDMIN_B IN 2", "TDM_C Capture",
> +				"TDMIN_C IN 2", "TDM_C Capture",
> +				"TDMIN_A IN 15", "TDM_C Loopback",
> +				"TDMIN_B IN 15", "TDM_C Loopback",
> +				"TDMIN_C IN 15", "TDM_C Loopback",
> +				"TODDR_A IN 0", "TDMIN_A OUT",
> +				"TODDR_B IN 0", "TDMIN_A OUT",
> +				"TODDR_C IN 0", "TDMIN_A OUT",
> +				"TODDR_A IN 1", "TDMIN_B OUT",
> +				"TODDR_B IN 1", "TDMIN_B OUT",
> +				"TODDR_C IN 1", "TDMIN_B OUT",
> +				"TODDR_A IN 2", "TDMIN_C OUT",
> +				"TODDR_B IN 2", "TDMIN_C OUT",
> +				"TODDR_C IN 2", "TDMIN_C OUT",
> +				"Lineout", "ACODEC LOLP",
> +				"Lineout", "ACODEC LORP";
> +	};
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&vddcpu_b>;
> +	operating-points-v2 = <&cpu_opp_table>;
> +	clocks = <&clkc CLKID_CPU_CLK>;
> +	clock-latency = <50000>;
> +};
> +
> +&cpu1 {
> +	cpu-supply = <&vddcpu_b>;
> +	operating-points-v2 = <&cpu_opp_table>;
> +	clocks = <&clkc CLKID_CPU1_CLK>;
> +	clock-latency = <50000>;
> +};
> +
> +&cpu2 {
> +	cpu-supply = <&vddcpu_b>;
> +	operating-points-v2 = <&cpu_opp_table>;
> +	clocks = <&clkc CLKID_CPU2_CLK>;
> +	clock-latency = <50000>;
> +};
> +
> +&cpu3 {
> +	cpu-supply = <&vddcpu_b>;
> +	operating-points-v2 = <&cpu_opp_table>;
> +	clocks = <&clkc CLKID_CPU3_CLK>;
> +	clock-latency = <50000>;
> +};

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
