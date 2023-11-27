Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5288B7F9B54
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjK0IJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjK0IJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:09:24 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1F1136
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:09:30 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50baa3e5c00so2129669e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701072568; x=1701677368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rn+UYaLR9UVBQ3OHWhJmg5Nn5FxMaUWGGdZVxwhJ9eE=;
        b=et0sWe7R+5ZJXnzHreC+NEOBMWnlLbBU8GmqymlaMcO3DUuMF5kg+fj6rQ0ljCeYhM
         yqkw6eVM9EldU5hf68pCCnfLBP0rhXOh9HCALfOuTz4crXPe66Xs6zHa9PnQl+2krhh9
         vbjpT8huHBvK9/t/EBE8/Z42wsm6vw9658ejrxv0/7zN8BvO4QiP5JM0mbH//KsF6ztv
         XXyHJ7SvT7XmATaNTQRgAh2P54Tf6xNIL0M3E3GmGmRsQhwIZOzxYyP0EUj+VGo2GxYa
         s//Zepju8Bw0WYHLUs0qq36npoGt5QNsgKWF+1Q8RCFpWL7q9e68LrIkAxZTox/fMFIG
         HONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701072568; x=1701677368;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rn+UYaLR9UVBQ3OHWhJmg5Nn5FxMaUWGGdZVxwhJ9eE=;
        b=o8O2UkadxIiErHgZhzFldyReRP/mnTE79QIlKJOkeyhDwY7je+K7UYOSFfC+OAnT13
         PS7rowqVabQMEJUFdVluWzsiLLLJBnI0kKtcZUJq3dbKXObnywdyeIyWapInydfd/ZAN
         mm9I9QTtjjqKSxGruLWB0qlWcVZoJFT9qCq/te6jza8rrYwo/0fh4aCqLImjIoSm5fb/
         uu/x205EktWmPTjSEWjpWzD/qPKubaUhirH953kri6axKDdOenkLxen5iTlft4tzQ+3u
         bLQHz2MXJVHYsl0S11D66hA54wTqO1+2nbsuGV70iHOzs8R5RZBnXrvcV3clolfoDwLN
         eCWg==
X-Gm-Message-State: AOJu0Yyno6l7evHDIDFOYQZlJAs+IeCCtXf+ROWt5LdAO5QkMqYxafi/
        SKiU8w4XP7fphGGwoHgDEg81jg==
X-Google-Smtp-Source: AGHT+IFrYeQJFDL7FWcFShdrCH4BBQIFmmfj0xNDZKBRQ2tGG+FCLSghCsphxVaO5/hi0/LcfJ/t9Q==
X-Received: by 2002:ac2:44ca:0:b0:50b:aa9a:6691 with SMTP id d10-20020ac244ca000000b0050baa9a6691mr3902883lfm.51.1701072568408;
        Mon, 27 Nov 2023 00:09:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5a15:ac68:b4a4:85ff? ([2a01:e0a:982:cbb0:5a15:ac68:b4a4:85ff])
        by smtp.gmail.com with ESMTPSA id z11-20020adff74b000000b00332f74ffdd9sm5200377wrp.30.2023.11.27.00.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 00:09:27 -0800 (PST)
Message-ID: <1dd87851-25d3-4f85-99ca-5c072675efec@linaro.org>
Date:   Mon, 27 Nov 2023 09:09:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] arm64: dts: amlogic: meson-axg: pinctrl node for NAND
Content-Language: en-US, fr
To:     Arseniy Krasnov <avkrasnov@salutedevices.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     oxffffaa@gmail.com, kernel@sberdevices.ru,
        Liang Yang <liang.yang@amlogic.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231109094504.131265-1-avkrasnov@salutedevices.com>
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
In-Reply-To: <20231109094504.131265-1-avkrasnov@salutedevices.com>
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

On 09/11/2023 10:45, Arseniy Krasnov wrote:
> Add pinctrl node for the Meson NAND controller.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>   Changelog:
>   v1 -> v2:
>    * Rename node name 'nand_all_pins' -> 'nand-all-pins'.
> 
>   arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 23 ++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index a49aa62e3f9f..7e5ac9db93f8 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -432,6 +432,27 @@ mux-1 {
>   					};
>   				};
>   
> +				nand_all_pins: nand-all-pins {
> +					mux {
> +						groups = "emmc_nand_d0",
> +							 "emmc_nand_d1",
> +							 "emmc_nand_d2",
> +							 "emmc_nand_d3",
> +							 "emmc_nand_d4",
> +							 "emmc_nand_d5",
> +							 "emmc_nand_d6",
> +							 "emmc_nand_d7",
> +							 "nand_ce0",
> +							 "nand_ale",
> +							 "nand_cle",
> +							 "nand_wen_clk",
> +							 "nand_ren_wr";
> +						function = "nand";
> +						input-enable;
> +						bias-pull-up;
> +					};
> +				};
> +
>   				emmc_ds_pins: emmc_ds {
>   					mux {
>   						groups = "emmc_ds";
> @@ -1913,6 +1934,8 @@ nfc: nand-controller@7800 {
>   				reg = <0x0 0x7800 0x0 0x100>,
>   				      <0x0 0x7000 0x0 0x800>;
>   				reg-names = "nfc", "emmc";
> +				pinctrl-0 = <&nand_all_pins>;
> +				pinctrl-names = "default";
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   				interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
