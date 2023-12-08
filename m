Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9956980A2E3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 13:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjLHMPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 07:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbjLHMO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 07:14:57 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1433D198D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 04:15:03 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c09f5a7cfso23029675e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 04:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702037701; x=1702642501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WcN2/CNkPLaayIVBp54DXaFo5UapmHmmRcKwrvSPI0Q=;
        b=x8M5CbBcCYTaMr2lHRPLognPTiA7zDzQTL/oquyUhQFhhkIRxpwxFkDkqRcXPiNbRU
         5vYsVGYjzejzEv71cnRhLERK0P32efTfkjBLmDJ5U5E60eBCisTA+o+mgxXkLiZ5y2zD
         j4LzPPmVEQiN3oSBzkybrg0pVrG+ZM6S22FQowXB2p2zEQbECTxhUK7LN4qDq3PYukks
         eMAP4HYxkKVQvpjHFQxjKPVKqKy2Hg06aTYld4dNlQkjcEJc03/cz/0PRmLKCA+rByc0
         fMVz73sZ+hMLmUFxYbW88ivASdDTIrrG9RPScO3yaSoj9TlB2qFVRej8XIuxb+sNLA5z
         DSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702037701; x=1702642501;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WcN2/CNkPLaayIVBp54DXaFo5UapmHmmRcKwrvSPI0Q=;
        b=WdLhuknsaHXhDWQe06wpQi5fx6EV8UdMMkQsxHh/XVoyvHXwiXOrWeuNerP4KUTrBH
         yAp4b2K8DoJ4R7QaufkscrCv1p7IrRnOcgHHy+0NXacxFhG38vRMNzbeB2z0AevRl/A0
         qTxdY57Og4eUpEno9yBubm1Dr5BHZU5YggGdLqiXwSUvuzpVANkw9oMnIcqwdTM6mfzx
         ovl3WaasCoz4bhOp90+eVJVcSgJZBCCTl4d0zRYyK/q4H8R5QeYSKy4tTGTitjtNzPgU
         btbtdSWaoeOqte6kiJqTWshfNHe8rdoJt5poBvNklR7yZZEv0u/gHNKVb2uNGa7LDt+T
         Q1GA==
X-Gm-Message-State: AOJu0YwNujVd6RnISoB084nJKtMK0muHjGZBaKRn2igysrASui7rtOay
        l7FqX/V73IeYhVXNfbVsij/WKg==
X-Google-Smtp-Source: AGHT+IEkgLxpeFB8kwBjyxn4vVKWtb5JJQWKeakCth+fbGZOcTVD/w1HksEIOL6TEGyrevflf8A7mA==
X-Received: by 2002:a7b:c856:0:b0:40c:32fe:e123 with SMTP id c22-20020a7bc856000000b0040c32fee123mr505489wml.167.1702037701295;
        Fri, 08 Dec 2023 04:15:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8ada:86ec:5358:ef2a? ([2a01:e0a:982:cbb0:8ada:86ec:5358:ef2a])
        by smtp.gmail.com with ESMTPSA id bd19-20020a05600c1f1300b0040839fcb217sm2754513wmb.8.2023.12.08.04.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 04:15:00 -0800 (PST)
Message-ID: <ee82eefc-d979-4183-b679-cb4f79b559fa@linaro.org>
Date:   Fri, 8 Dec 2023 13:14:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/2] arm64: dts: amlogic: enable some nodes for board
 AQ222
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
 <20231208-s4-dts-v2-2-5a93fa356c5d@amlogic.com>
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
In-Reply-To: <20231208-s4-dts-v2-2-5a93fa356c5d@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2023 08:16, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Add reserved memory for board AQ222 which is used by ATF.
> Enable NAND, SPICC nodes for board AQ222.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   .../boot/dts/amlogic/meson-s4-s805x2-aq222.dts     | 56 ++++++++++++++++++++++
>   1 file changed, 56 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> index c1f322c73982..18789242f05f 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> @@ -23,6 +23,17 @@ memory@0 {
>   		reg = <0x0 0x0 0x0 0x40000000>;
>   	};
>   
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* 52 MiB reserved for ARM Trusted Firmware */
> +		secmon_reserved: secmon@5000000 {
> +			reg = <0x0 0x05000000 0x0 0x3400000>;
> +			no-map;
> +		};
> +	};
>   };
>   
>   &uart_B {
> @@ -34,3 +45,48 @@ &ir {
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
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
