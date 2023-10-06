Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57737BBAB0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjJFOqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjJFOqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:46:53 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6795A6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:46:51 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so21447365e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696603610; x=1697208410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMY6Oywu9+xD9eu/3FX3tlRBq0A2AjLLPkWOIrzo07w=;
        b=KYTzsdMvCT7lTijZ0+RyL25Dd7z9DVlC+kJhgS4+Gl8G0DjQE+SyyME8NRFwi3DsnQ
         5aI4zXdmqWc+aVM0s5EXbfYt9BRMfdEsmDT1Vkm3Z2EpeZCb4Gzwe3X17Vx5ISrFUdpY
         JDzQG3jBG4zOidgrVzew4I473DDwutUc9MDBn0BmnjeH8GgvPdD+6Op7hGBxRVKCLXK/
         IE5jzJrCBHaEtpTC+3dW9PJFNZQDAbKLH10/Wzq0hpDaCCUF/xLj4QnCAISEbuvM9En8
         u5FPrCso1/bUqPVkj6t9AjIq7cH50zb9x2D2a2HJma8EsuHTk3FI440BKvEVBEWm2OYY
         mhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696603610; x=1697208410;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zMY6Oywu9+xD9eu/3FX3tlRBq0A2AjLLPkWOIrzo07w=;
        b=JpY+ApOAn2CwLdCIRsDxqU20iCKlfK6TzjkzkJAwi4Gd0ULv2MQj6x+jXBr3BLkkPM
         LGLWsedK4LwUp/yYVEOP8OjoKtidurwlmKP1eiq5EBNap+NztMEpSykZVXCNUKwTN71i
         A2lx2TsxRqiPSErmoHILcAFPruXmCDISmF5lqYeCP+m6nA/kILbFZ+SLHzvnLDTnmXNI
         MzRda4eH9+x8WPWwDkmv4Ps1jlpg+sPv8ozlbGkuIjJX85Rh4ctIRTxB1fJoCr1peTSl
         pLceP0uUdYl/rGxfThZRGfUPsSnKx9zYJDfzxqUG1GBbc24Il5YhQBB1iqRJhJF9XlS4
         xTkg==
X-Gm-Message-State: AOJu0YxmBawbQc8MN36MncGlhHSU/2FADOusMayB42Q8U5LVRaGq7dyl
        3X0wC0jv1QKp96/uYWx3jORqyw==
X-Google-Smtp-Source: AGHT+IEs8p5YrMMkbRPAukUwPzYqqFBywIqnknUGZ1/mKgg5n7mfYi2FPs0LeWV2gUT14L7JIx8BSg==
X-Received: by 2002:a05:600c:22d5:b0:406:52e4:cd23 with SMTP id 21-20020a05600c22d500b0040652e4cd23mr7724633wmg.0.1696603610039;
        Fri, 06 Oct 2023 07:46:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c8f7:4bc7:2e11:c133? ([2a01:e0a:982:cbb0:c8f7:4bc7:2e11:c133])
        by smtp.gmail.com with ESMTPSA id m7-20020a7bce07000000b003fc16ee2864sm3896804wmc.48.2023.10.06.07.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 07:46:49 -0700 (PDT)
Message-ID: <00bb552d-be6f-464f-9ca9-03a6d4ea26b7@linaro.org>
Date:   Fri, 6 Oct 2023 16:46:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] arm64: dts: amlogic: a1: support all i2c masters and
 their muxes
Content-Language: en-US, fr
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>, jbrunet@baylibre.com,
        mturquette@baylibre.com, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        George Stark <gnstark@salutedevices.com>
References: <20231006114145.18718-1-ddrokosov@salutedevices.com>
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
In-Reply-To: <20231006114145.18718-1-ddrokosov@salutedevices.com>
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

On 06/10/2023 13:41, Dmitry Rokosov wrote:
> A1 SoC family has four i2c masters: i2c0 (I2CM_A), i2c1 (I2CM_B), i2c2
> (I2CM_C) and i2c3 (I2CM_D).
> 
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 144 ++++++++++++++++++++++
>   1 file changed, 144 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> index 823714bcb7a0..f53000a5d0cc 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> @@ -126,6 +126,106 @@ gpio: bank@400 {
>   					gpio-ranges = <&periphs_pinctrl 0 0 62>;
>   				};
>   
> +				i2c0_f11_pins: i2c0-f11 {
> +					mux {
> +						groups = "i2c0_sck_f11",
> +							 "i2c0_sda_f12";
> +						function = "i2c0";
> +						bias-pull-up;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c0_f9_pins: i2c0-f9 {
> +					mux {
> +						groups = "i2c0_sck_f9",
> +							 "i2c0_sda_f10";
> +						function = "i2c0";
> +						bias-pull-up;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c1_x_pins: i2c1-x {
> +					mux {
> +						groups = "i2c1_sck_x",
> +							 "i2c1_sda_x";
> +						function = "i2c1";
> +						bias-pull-up;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c1_a_pins: i2c1-a {
> +					mux {
> +						groups = "i2c1_sck_a",
> +							 "i2c1_sda_a";
> +						function = "i2c1";
> +						bias-pull-up;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c2_x0_pins: i2c2-x0 {
> +					mux {
> +						groups = "i2c2_sck_x0",
> +							 "i2c2_sda_x1";
> +						function = "i2c2";
> +						bias-pull-up;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c2_x15_pins: i2c2-x15 {
> +					mux {
> +						groups = "i2c2_sck_x15",
> +							 "i2c2_sda_x16";
> +						function = "i2c2";
> +						bias-pull-up;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c2_a4_pins: i2c2-a4 {
> +					mux {
> +						groups = "i2c2_sck_a4",
> +							 "i2c2_sda_a5";
> +						function = "i2c2";
> +						bias-pull-up;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c2_a8_pins: i2c2-a8 {
> +					mux {
> +						groups = "i2c2_sck_a8",
> +							 "i2c2_sda_a9";
> +						function = "i2c2";
> +						bias-pull-up;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c3_x_pins: i2c3-x {
> +					mux {
> +						groups = "i2c3_sck_x",
> +							 "i2c3_sda_x";
> +						function = "i2c3";
> +						bias-pull-up;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
> +				i2c3_f_pins: i2c3-f {
> +					mux {
> +						groups = "i2c3_sck_f",
> +							 "i2c3_sda_f";
> +						function = "i2c3";
> +						bias-pull-up;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
>   				uart_a_pins: uart-a {
>   					mux {
>   						groups = "uart_a_tx",
> @@ -377,6 +477,17 @@ clkc_periphs: clock-controller@800 {
>   					      "hifi_pll", "xtal";
>   			};
>   
> +			i2c0: i2c@1400 {
> +				compatible = "amlogic,meson-axg-i2c";
> +				status = "disabled";
> +				reg = <0x0 0x1400 0x0 0x20>;
> +				interrupts = <GIC_SPI 32 IRQ_TYPE_EDGE_RISING>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&clkc_periphs CLKID_I2C_M_A>;
> +				power-domains = <&pwrc PWRC_I2C_ID>;
> +			};
> +
>   			uart_AO: serial@1c00 {
>   				compatible = "amlogic,meson-a1-uart",
>   					     "amlogic,meson-ao-uart";
> @@ -437,6 +548,39 @@ saradc: adc@2c00 {
>   				status = "disabled";
>   			};
>   
> +			i2c1: i2c@5c00 {
> +				compatible = "amlogic,meson-axg-i2c";
> +				status = "disabled";
> +				reg = <0x0 0x5c00 0x0 0x20>;
> +				interrupts = <GIC_SPI 68 IRQ_TYPE_EDGE_RISING>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&clkc_periphs CLKID_I2C_M_B>;
> +				power-domains = <&pwrc PWRC_I2C_ID>;
> +			};
> +
> +			i2c2: i2c@6800 {
> +				compatible = "amlogic,meson-axg-i2c";
> +				status = "disabled";
> +				reg = <0x0 0x6800 0x0 0x20>;
> +				interrupts = <GIC_SPI 76 IRQ_TYPE_EDGE_RISING>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&clkc_periphs CLKID_I2C_M_C>;
> +				power-domains = <&pwrc PWRC_I2C_ID>;
> +			};
> +
> +			i2c3: i2c@6c00 {
> +				compatible = "amlogic,meson-axg-i2c";
> +				status = "disabled";
> +				reg = <0x0 0x6c00 0x0 0x20>;
> +				interrupts = <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&clkc_periphs CLKID_I2C_M_D>;
> +				power-domains = <&pwrc PWRC_I2C_ID>;
> +			};
> +
>   			usb2_phy1: phy@4000 {
>   				compatible = "amlogic,a1-usb2-phy";
>   				clocks = <&clkc_periphs CLKID_USB_PHY_IN>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
