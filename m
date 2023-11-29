Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3112E7FD489
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjK2Km5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2Kmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:42:54 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A42D54
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:42:59 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40b5155e154so6514835e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701254578; x=1701859378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAGMwpCTT08jkZqZy29WSJA+xhUiymWdrdPOJu7zw7c=;
        b=QvdeghZxfMdMU1fOQbc4LPvvPxp2TiZKFapdM3+c9XLuw9ygVUIXXBdIEkypettjV9
         0DZJ4t0w++QD0AjK18OUamwTgYqbo9vY2B5AAr3KqIjRrmYvwWUNzYBM19Oim5IYpO//
         X5ESNvv1KskkYGRcAwDauwZC8ezk0lAGndpoQMGN2SRQgP+87sUMHaIF4trIpP9tAaYg
         f6YVJxowVx4bDSjDXS6d2Agv1ET9hMI0o3wafnQs5LR5NnbZ1iBFhgrpqvCKqwaOKI3d
         jSz8QK+aMCEyrM0qTlRua1/V5Abi1mOXqytl0WPxosrTm8Z5PZVXIaxnfEWmKMMKoDfd
         O/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701254578; x=1701859378;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KAGMwpCTT08jkZqZy29WSJA+xhUiymWdrdPOJu7zw7c=;
        b=NPBlUrkT2wo+GMUsV9ofKsIcG/7A/pQByn7WYMxwM0MLipvsfTL1hqedtf+zimfI1W
         08NgBjxxkRgR95U15Vrl5ehdo0PrPYplSZjMK5xVf6CUd3RgfCsDc26IwlsnooGtd2Ix
         z5+Ypkz4R9IYm5G4XVvJoddAgQm4qdS0X04K6/XH1qB0SKRppCS6IWYHNQWSfCkhuxVb
         JM55E+mZSTZC5FxkeASdPUyS7dJTTCTSNzPWZdR4V07uuzh2eT5gBmDX0rpjyyNmQRGd
         M8jDS5sAHb7ckKvweImhkJEPqc1olIjDcdtPPgt5EEuqe7xKML93Qc4aGad0eX5qxNSw
         ZPoA==
X-Gm-Message-State: AOJu0Yxkx2phqCIdRmRShmeh6brpioQABYO586Xi6GwHvKAZS5Fn6f5H
        ulXRt07wJMoj0VaRLcrfmiR2Ug==
X-Google-Smtp-Source: AGHT+IGTGdNenP/FD0riRfcc3jBLgFnLhg+XJGdCnMbQgeW/JQcCQ23vrLqa6sLDGQbkgAVnCmKhjw==
X-Received: by 2002:a05:600c:138e:b0:40b:3605:acda with SMTP id u14-20020a05600c138e00b0040b3605acdamr14018883wmf.25.1701254578112;
        Wed, 29 Nov 2023 02:42:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:31d3:eea3:8f97:6a2c? ([2a01:e0a:982:cbb0:31d3:eea3:8f97:6a2c])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c4f1200b0040b3829eb50sm1728822wmq.20.2023.11.29.02.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 02:42:57 -0800 (PST)
Message-ID: <be7501ce-d1b3-45aa-8415-a56cef662d83@linaro.org>
Date:   Wed, 29 Nov 2023 11:42:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: amlogic: s4: add some device nodes
Content-Language: en-US, fr
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20231129092949.2103338-1-xianwei.zhao@amlogic.com>
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
In-Reply-To: <20231129092949.2103338-1-xianwei.zhao@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/11/2023 10:29, Xianwei Zhao wrote:
> Add some device nodes for board AQ222,
> including clock,I2C,SPICC,nand and ethernet.

Could you reformat a little bit the commit message, it's a little bit scarce
and the style is weird.

> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   .../dts/amlogic/meson-s4-s805x2-aq222.dts     |  55 +++
>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi     | 350 +++++++++++++++++-
>   2 files changed, 404 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> index c1f322c73982..fd349c49ebf5 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts

Please move the meson-s4-s805x2-aq222.dts changes in a separate commit

> @@ -23,6 +23,16 @@ memory@0 {
>   		reg = <0x0 0x0 0x0 0x40000000>;
>   	};
>   
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		secmon_reserved: secmon@5000000 {
> +			reg = <0x0 0x05000000 0x0 0x4000000>;
> +			no-map;
> +		};

Please add a comment before the node explaining what needs this memory

> +	};
>   };
>   
>   &uart_B {
> @@ -34,3 +44,48 @@ &ir {
>   	pinctrl-0 = <&remote_pins>;
>   	pinctrl-names = "default";
>   };
> +
> +&nand {
> +	status = "okay";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	pinctrl-0 = <&nand_pins>;
> +	pinctrl-names = "default";
> +
> +	nand@0 {
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		nand-on-flash-bbt;
> +
> +		partition@0 {
> +			label = "boot";
> +			reg = <0x0 0x00200000>;
> +		};
> +		partition@200000 {
> +			label = "env";
> +			reg = <0x00200000 0x00400000>;
> +		};
> +		partition@600000 {
> +			label = "system";
> +			reg = <0x00600000 0x00a00000>;
> +		};
> +		partition@1000000 {
> +			label = "rootfs";
> +			reg = <0x01000000 0x03000000>;
> +		};
> +		partition@4000000 {
> +			label = "media";
> +			reg = <0x04000000 0x8000000>;
> +		};
> +	};
> +};
> +
> +&spicc0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spicc0_pins_x>;
> +	cs-gpios = <&gpio GPIOX_10 GPIO_ACTIVE_LOW>;
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> index 2344b2d741c3..022aba0f9ef7 100644
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
> +				i2c0_pins1:i2c0-pins1 {

Please add a space after ":"

> +					mux {
> +						groups = "i2c0_sda",
> +						       "i2c0_scl";
> +						function = "i2c0";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				i2c1_pins1:i2c1-pins1 {

Ditto

> +					mux {
> +						groups = "i2c1_sda_c",
> +						       "i2c1_scl_c";
> +						function = "i2c1";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				i2c1_pins2:i2c1-pins2 {
Ditto

> +					mux {
> +						groups = "i2c1_sda_d",
> +						       "i2c1_scl_d";
> +						function = "i2c1";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				i2c1_pins3:i2c1-pins3 {
Ditto

> +					mux {
> +						groups = "i2c1_sda_h",
> +						       "i2c1_scl_h";
> +						function = "i2c1";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				i2c1_pins4:i2c1-pins4 {
Ditto

> +					mux {
> +						groups = "i2c1_sda_x",
> +						       "i2c1_scl_x";
> +						function = "i2c1";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				i2c2_pins1:i2c2-pins1 {
> +					mux {
> +						groups = "i2c2_sda_d",
> +						       "i2c2_scl_d";
> +						function = "i2c2";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				i2c2_pins2:i2c2-pins2 {
> +					mux {
> +						groups = "i2c2_sda_h8",
> +						       "i2c2_scl_h9";
> +						function = "i2c2";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				i2c2_pins3:i2c2-pins3 {
Ditto

> +					mux {
> +						groups = "i2c2_sda_h0",
> +						       "i2c2_scl_h1";
> +						function = "i2c2";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				i2c3_pins1:i2c3-pins1 {
Ditto

> +					mux {
> +						groups = "i2c3_sda_x",
> +						       "i2c3_scl_x";
> +						function = "i2c3";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				i2c3_pins2:i2c3-pins2 {
Ditto

> +					mux {
> +						groups = "i2c3_sda_z",
> +						       "i2c3_scl_z";
> +						function = "i2c3";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				i2c4_pins1:i2c4-pins1 {
Ditto

> +					mux {
> +						groups = "i2c4_sda_c",
> +						       "i2c4_scl_c";
> +						function = "i2c4";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				i2c4_pins2:i2c4-pins2 {
Ditto

> +					mux {
> +						groups = "i2c4_sda_d",
> +						       "i2c4_scl_d";
> +						function = "i2c4";
> +						drive-strength-microamp = <3000>;
> +						bias-disable;
> +					};
> +				};
> +
> +				i2c4_pins3:i2c4-pins3 {
Ditto

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
> base-commit: 3a5038e9c0556e51db96c2f7149d853efb886c95

Thanks,
Neil
