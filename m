Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E9F80A2DC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 13:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjLHMOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 07:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjLHMOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 07:14:44 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD080173A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 04:14:49 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c07ed92fdso21091615e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 04:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702037688; x=1702642488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCLaMZcy/7gacoFTL7NICPH2jCqMFgwVuVhqxSeS5gw=;
        b=gUQpBBTX0zbK+fkybvkp4o10rcUgYVSf+9NTPpsVQj9ipOqQjKCRXneunC1TXeddfF
         FyLHkpOLhJSnzGhcwfzpWsqQeTP3qRZueuais6JvUPQf+SxM5HpugQwsPfIlOJOYjF5x
         d2k6golm4El9yR2tL/WGVa45i4ayhG6ASyzPULITlgz5OQyvRCZMym6tejppvqb2o06T
         fmBQEsvZLvr7OkiL1CEEvodkNIOWOoZR4gHNek+y4tkn6N0l4dK5Py8EX77n5lkt5sJ7
         sKKBti8l6RTPBcnEhlWSZznvz8Gp+hn4qA4U9bsTA2mYY+T9kLodZ/h/q/9WqeuUrXWf
         21Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702037688; x=1702642488;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bCLaMZcy/7gacoFTL7NICPH2jCqMFgwVuVhqxSeS5gw=;
        b=NjY2ozhOS02/Ru+EmFhA1TRnfhWecQM1kPV8Fn/8zT2d9TmWmbqmA8XiaXYUB9MFQU
         wv9VdW6ZyG0hd+Y3hJDWjnvdHUsl7mHCgWRAV8CAQUS3EOhdVcsDngj4f1D1kHDldn9y
         89cjgwPQ3fG7H43dLbRpctojJpFZ0bXbWm6TT8b/YIM7NLgBAWFTI0KCvtJQJkdjS3eq
         LDh/L3HH695TvXDUYalfZdg9qRlPdsLFDwovw38ZBafqMaQSZ3i/T4Ga0TQtem8ICvwu
         2oKxgSaZAK/fgmnglmo+FNuEqEbamqXLkWQotC9I+vLSCwYnHquQHKFoK/iRjjioP5sY
         2YGw==
X-Gm-Message-State: AOJu0YwpGTDtpjtj4K/8EMMCFtaIFNGRyjKobOp4y/5hrp9c6T81hR6a
        mdWI3RSuhUDgPRBZ8gB+KWkQuA==
X-Google-Smtp-Source: AGHT+IF2sRCtNVnwJg117bzGXPRqR7RR38Wy6sWnCkFLIoubhk9MPiEOzyeeYAOdamLFr3F11szPaQ==
X-Received: by 2002:a05:600c:2199:b0:40b:5e21:cc49 with SMTP id e25-20020a05600c219900b0040b5e21cc49mr2373001wme.116.1702037688002;
        Fri, 08 Dec 2023 04:14:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8ada:86ec:5358:ef2a? ([2a01:e0a:982:cbb0:8ada:86ec:5358:ef2a])
        by smtp.gmail.com with ESMTPSA id bd19-20020a05600c1f1300b0040839fcb217sm2754513wmb.8.2023.12.08.04.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 04:14:47 -0800 (PST)
Message-ID: <5b03c354-2582-46c0-8574-8a5d59cb6cfc@linaro.org>
Date:   Fri, 8 Dec 2023 13:14:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/2] arm64: dts: amlogic: add some device nodes for S4
Content-Language: en-US, fr
To:     xianwei.zhao@amlogic.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231208-s4-dts-v2-0-5a93fa356c5d@amlogic.com>
 <20231208-s4-dts-v2-1-5a93fa356c5d@amlogic.com>
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
In-Reply-To: <20231208-s4-dts-v2-1-5a93fa356c5d@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2023 08:16, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Add some device nodes for SoC S4, including periphs clock controller
> node, PLL clock controller node, I2C nodes, SPICC node, NAND
> controller node, Ethernet MAC and PHY node.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 350 +++++++++++++++++++++++++++++-
>   1 file changed, 349 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> index 2344b2d741c3..c6b524e1a1ee 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> @@ -6,6 +6,10 @@
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/gpio/meson-s4-gpio.h>
> +#include <dt-bindings/clock/amlogic,s4-pll-clkc.h>
> +#include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
> +#include <dt-bindings/power/meson-s4-power.h>
>   
>   / {
>   	cpus {
> @@ -92,6 +96,38 @@ apb4: bus@fe000000 {
>   			#size-cells = <2>;
>   			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>   
> +			clkc_periphs: clock-controller@0 {
> +				compatible = "amlogic,s4-peripherals-clkc";
> +				reg = <0x0 0x0 0x0 0x49c>;
> +				clocks = <&clkc_pll CLKID_FCLK_DIV2>,
> +					<&clkc_pll CLKID_FCLK_DIV2P5>,
> +					<&clkc_pll CLKID_FCLK_DIV3>,
> +					<&clkc_pll CLKID_FCLK_DIV4>,
> +					<&clkc_pll CLKID_FCLK_DIV5>,
> +					<&clkc_pll CLKID_FCLK_DIV7>,
> +					<&clkc_pll CLKID_HIFI_PLL>,
> +					<&clkc_pll CLKID_GP0_PLL>,
> +					<&clkc_pll CLKID_MPLL0>,
> +					<&clkc_pll CLKID_MPLL1>,
> +					<&clkc_pll CLKID_MPLL2>,
> +					<&clkc_pll CLKID_MPLL3>,
> +					<&clkc_pll CLKID_HDMI_PLL>,
> +					<&xtal>;
> +				clock-names = "fclk_div2", "fclk_div2p5", "fclk_div3",
> +						"fclk_div4", "fclk_div5", "fclk_div7",
> +						"hifi_pll", "gp0_pll", "mpll0", "mpll1",
> +						"mpll2", "mpll3", "hdmi_pll", "xtal";
> +				#clock-cells = <1>;
> +			};
> +
> +			clkc_pll: clock-controller@8000 {
> +				compatible = "amlogic,s4-pll-clkc";
> +				reg = <0x0 0x8000 0x0 0x1e8>;
> +				clocks = <&xtal>;
> +				clock-names = "xtal";
> +				#clock-cells = <1>;
> +			};
> +
>   			watchdog@2100 {
>   				compatible = "amlogic,s4-wdt", "amlogic,t7-wdt";
>   				reg = <0x0 0x2100 0x0 0x10>;
> @@ -120,6 +156,187 @@ mux {
>   						bias-disable;
>   					};
>   				};
> +
> +				i2c0_pins1: i2c0-pins1 {
> +					mux {
> +						groups = "i2c0_sda",
> +						       "i2c0_scl";
> +						function = "i2c0";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				i2c1_pins1: i2c1-pins1 {
> +					mux {
> +						groups = "i2c1_sda_c",
> +						       "i2c1_scl_c";
> +						function = "i2c1";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				i2c1_pins2: i2c1-pins2 {
> +					mux {
> +						groups = "i2c1_sda_d",
> +						       "i2c1_scl_d";
> +						function = "i2c1";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				i2c1_pins3: i2c1-pins3 {
> +					mux {
> +						groups = "i2c1_sda_h",
> +						       "i2c1_scl_h";
> +						function = "i2c1";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				i2c1_pins4: i2c1-pins4 {
> +					mux {
> +						groups = "i2c1_sda_x",
> +						       "i2c1_scl_x";
> +						function = "i2c1";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				i2c2_pins1: i2c2-pins1 {
> +					mux {
> +						groups = "i2c2_sda_d",
> +						       "i2c2_scl_d";
> +						function = "i2c2";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				i2c2_pins2: i2c2-pins2 {
> +					mux {
> +						groups = "i2c2_sda_h8",
> +						       "i2c2_scl_h9";
> +						function = "i2c2";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				i2c2_pins3: i2c2-pins3 {
> +					mux {
> +						groups = "i2c2_sda_h0",
> +						       "i2c2_scl_h1";
> +						function = "i2c2";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				i2c3_pins1: i2c3-pins1 {
> +					mux {
> +						groups = "i2c3_sda_x",
> +						       "i2c3_scl_x";
> +						function = "i2c3";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				i2c3_pins2: i2c3-pins2 {
> +					mux {
> +						groups = "i2c3_sda_z",
> +						       "i2c3_scl_z";
> +						function = "i2c3";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				i2c4_pins1: i2c4-pins1 {
> +					mux {
> +						groups = "i2c4_sda_c",
> +						       "i2c4_scl_c";
> +						function = "i2c4";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				i2c4_pins2: i2c4-pins2 {
> +					mux {
> +						groups = "i2c4_sda_d",
> +						       "i2c4_scl_d";
> +						function = "i2c4";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				i2c4_pins3: i2c4-pins3 {
> +					mux {
> +						groups = "i2c4_sda_z",
> +						       "i2c4_scl_z";
> +						function = "i2c4";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				nand_pins: nand-pins {
> +					mux {
> +						groups = "emmc_nand_d0",
> +						       "emmc_nand_d1",
> +						       "emmc_nand_d2",
> +						       "emmc_nand_d3",
> +						       "emmc_nand_d4",
> +						       "emmc_nand_d5",
> +						       "emmc_nand_d6",
> +						       "emmc_nand_d7",
> +						       "nand_ce0",
> +						       "nand_ale",
> +						       "nand_cle",
> +						       "nand_wen_clk",
> +						       "nand_ren_wr";
> +						function = "nand";
> +						input-enable;
> +					};
> +				};
> +
> +				spicc0_pins_x: spicc0-pins_x {
> +					mux {
> +						groups = "spi_a_mosi_x",
> +						       "spi_a_miso_x",
> +						       "spi_a_clk_x";
> +						function = "spi_a";
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				spicc0_pins_h: spicc0-pins-h {
> +					mux {
> +						groups = "spi_a_mosi_h",
> +						       "spi_a_miso_h",
> +						       "spi_a_clk_h";
> +						function = "spi_a";
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				spicc0_pins_z: spicc0-pins-z {
> +					mux {
> +						groups = "spi_a_mosi_z",
> +						       "spi_a_miso_z",
> +						       "spi_a_clk_z";
> +						function = "spi_a";
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
>   			};
>   
>   			gpio_intc: interrupt-controller@4080 {
> @@ -132,13 +349,119 @@ gpio_intc: interrupt-controller@4080 {
>   					<10 11 12 13 14 15 16 17 18 19 20 21>;
>   			};
>   
> +			eth_phy: mdio-multiplexer@28000 {
> +				compatible = "amlogic,g12a-mdio-mux";
> +				reg = <0x0 0x28000 0x0 0xa4>;
> +
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&clkc_periphs CLKID_ETHPHY>,
> +					 <&xtal>,
> +					 <&clkc_pll CLKID_MPLL_50M>;
> +				clock-names = "pclk", "clkin0", "clkin1";
> +				mdio-parent-bus = <&mdio0>;
> +
> +				ext_mdio: mdio@0 {
> +					reg = <0>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +				};
> +
> +				int_mdio: mdio@1 {
> +					reg = <1>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					internal_ephy: ethernet-phy@8 {
> +						compatible = "ethernet-phy-id0180.3301",
> +							     "ethernet-phy-ieee802.3-c22";
> +						interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> +						reg = <8>;
> +						max-speed = <100>;
> +					};
> +				};
> +			};
> +
> +			spicc0: spi@50000 {
> +				compatible = "amlogic,meson-g12a-spicc";
> +				reg = <0x0 0x50000 0x0 0x44>;
> +				interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clkc_periphs CLKID_SPICC0>,
> +					 <&clkc_periphs CLKID_SPICC0_EN>;
> +				clock-names = "core", "pclk";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c0: i2c@66000 {
> +				compatible = "amlogic,meson-axg-i2c";
> +				reg = <0x0 0x66000 0x0 0x20>;
> +				interrupts = <GIC_SPI 160 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&clkc_periphs CLKID_I2C_M_A>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c1: i2c@68000 {
> +				compatible = "amlogic,meson-axg-i2c";
> +				reg = <0x0 0x68000 0x0 0x20>;
> +				interrupts = <GIC_SPI 161 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&clkc_periphs CLKID_I2C_M_B>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c2: i2c@6a000 {
> +				compatible = "amlogic,meson-axg-i2c";
> +				reg = <0x0 0x6a000 0x0 0x20>;
> +				interrupts = <GIC_SPI 162 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&clkc_periphs CLKID_I2C_M_C>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c3: i2c@6c000 {
> +				compatible = "amlogic,meson-axg-i2c";
> +				reg = <0x0 0x6c000 0x0 0x20>;
> +				interrupts = <GIC_SPI 163 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&clkc_periphs CLKID_I2C_M_D>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c4: i2c@6e000 {
> +				compatible = "amlogic,meson-axg-i2c";
> +				reg = <0x0 0x6e000 0x0 0x20>;
> +				interrupts = <GIC_SPI 164 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&clkc_periphs CLKID_I2C_M_E>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			nand: nand-controller@8c800 {
> +				compatible = "amlogic,meson-axg-nfc";
> +				reg = <0x0 0x8c800 0x0 0x100>, <0x0 0x8c000 0x0 0x4>;
> +				reg-names = "nfc", "emmc";
> +				interrupts = <GIC_SPI 175 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&clkc_periphs CLKID_SD_EMMC_C>,
> +					<&clkc_pll CLKID_FCLK_DIV2>;
> +				clock-names = "core", "device";
> +				status = "disabled";
> +			};
> +
>   			uart_B: serial@7a000 {
>   				compatible = "amlogic,meson-s4-uart",
>   					     "amlogic,meson-ao-uart";
>   				reg = <0x0 0x7a000 0x0 0x18>;
>   				interrupts = <GIC_SPI 169 IRQ_TYPE_EDGE_RISING>;
>   				status = "disabled";
> -				clocks = <&xtal>, <&xtal>, <&xtal>;
> +				clocks = <&xtal>, <&clkc_periphs CLKID_UART_B>, <&xtal>;
>   				clock-names = "xtal", "pclk", "baud";
>   			};
>   
> @@ -160,5 +483,30 @@ hwrng: rng@440788 {
>   				reg = <0x0 0x440788 0x0 0x0c>;
>   			};
>   		};
> +
> +		ethmac: ethernet@fdc00000 {
> +			compatible = "amlogic,meson-axg-dwmac",
> +				     "snps,dwmac-3.70a",
> +				     "snps,dwmac";
> +			reg = <0x0 0xfdc00000 0x0 0x10000>,
> +			      <0x0 0xfe024000 0x0 0x8>;
> +
> +			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq";
> +			power-domains = <&pwrc PWRC_S4_ETH_ID>;
> +			clocks = <&clkc_periphs CLKID_ETH>,
> +				 <&clkc_pll CLKID_FCLK_DIV2>,
> +				 <&clkc_pll CLKID_MPLL2>;
> +			clock-names = "stmmaceth", "clkin0", "clkin1";
> +			rx-fifo-depth = <4096>;
> +			tx-fifo-depth = <2048>;
> +			status = "disabled";
> +
> +			mdio0: mdio {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "snps,dwmac-mdio";
> +			};
> +		};
>   	};
>   };
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
