Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7327F9B43
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjK0IFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjK0IFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:05:30 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4349B138
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:05:36 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50aab3bf71fso5279429e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701072334; x=1701677134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0DQAQJOHK+3bLecRM4vP3aZdjFFClzdARCL+RSt+yY=;
        b=u8lTbhgDLJjTGjOc6AoRSjnD6DP9426VIorH3xJ1yXacCNmNTvob7c3cbk48l0EdCb
         drIbghg85maNLx82UQjUw6c1tYTtaXukUph6x/JGT+4VWRfs9OrEDfHd93q3zri+zOTH
         sZk/hbz710WK3lfgqcqBc9FHgB7T92XpAkaeSddrOMms6EYxATBL+hd14y9tcjN39aLM
         RMdzhGD7+fm3YyJWSbazPT13wEMHQGd9eHxmpxueyXNPhOh2Yr8zpNQ88He6GYRmsMWY
         +hGZGcTOvo6/d6jQvBhIbJnmf6mxtC8b21Ff8GVM/IMS3vGpljjMa7KFRosm5aPMDZhT
         7y6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701072334; x=1701677134;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i0DQAQJOHK+3bLecRM4vP3aZdjFFClzdARCL+RSt+yY=;
        b=ByJM35XiH7yJgQg/B12X6cB99nDK8ngmCcdgGT1zw39PVclSVmQ9SyuQ89XZy56N8b
         qsst3I74lcdG34T+IunLMgRMuY0s9IeVwJnns8/YQFAKgyAVY/NOhiKGKdkhqK8Nt7XM
         2JnNpdo49e92ZXkPiG8QwULmcpUTGQoi/MgIeZ/8qGPkAzLYwgJm1iBp9dmBFp3ZCoqV
         jvpUAwtbW5ft7DoYuURgSbOZVR/zNYdaPuv0VgBp2tKdPjvc3eL/sIWuGYjnSth4YNJD
         E940iCqKXTqdAbUWvC94fEM8q1zl8qn6m/q0617a6IJgeVGHKFI9BPGTBVWIMwfKMEwv
         ih0g==
X-Gm-Message-State: AOJu0YzUkL2NgEnP24qVFkoGbzyO1rx8OjGf19yKSoOeEOwJSwyUWHb9
        O+O7Uky3YVfkVI2O0Un9fYy4+il0ZWULt99tCp//gsLh
X-Google-Smtp-Source: AGHT+IFkdw6Gl3b465RRwdllGajS2LeTjfmKWlo/ZzirKLeykVN8prF08yfXFLM/2fXpl6fa8KzO3A==
X-Received: by 2002:a05:6512:31c3:b0:509:377a:26d9 with SMTP id j3-20020a05651231c300b00509377a26d9mr8908687lfe.8.1701072334462;
        Mon, 27 Nov 2023 00:05:34 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5a15:ac68:b4a4:85ff? ([2a01:e0a:982:cbb0:5a15:ac68:b4a4:85ff])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b0040b30be6244sm12939987wmq.24.2023.11.27.00.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 00:05:34 -0800 (PST)
Message-ID: <bcf1cc27-cdba-40c2-b578-b4514f92df7c@linaro.org>
Date:   Mon, 27 Nov 2023 09:05:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: meson-axg: jethub-jxx add support for EEPROM
Content-Language: en-US, fr
To:     Viacheslav Bocharov <adeep@lexina.in>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20231102061233.3113249-1-adeep@lexina.in>
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
In-Reply-To: <20231102061233.3113249-1-adeep@lexina.in>
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

On 02/11/2023 07:12, Viacheslav Bocharov wrote:
> Add dts node for EEPROM placed on baseboard in JetHub D1+ devices.
> 
> Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
> ---
>   .../amlogic/meson-axg-jethome-jethub-j110-rev-2.dts  | 12 ++++++++++++
>   .../amlogic/meson-axg-jethome-jethub-j110-rev-3.dts  | 12 ++++++++++++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-2.dts b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-2.dts
> index 0062667c4f65..2c684f0ca99a 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-2.dts
> @@ -35,3 +35,15 @@ bluetooth {
>   		device-wake-gpios = <&gpio GPIOZ_6 GPIO_ACTIVE_HIGH>;
>   	};
>   };
> +
> +&i2c_AO {
> +	/* EEPROM on base board */
> +	eeprompd: eeprom@56 {
> +		compatible = "atmel,24c64";
> +		reg = <0x56>;
> +		pagesize = <0x20>;
> +		label = "eeprompd";
> +		address-width = <0x10>;
> +		vcc-supply = <&vddao_3v3>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-3.dts b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-3.dts
> index c2d22b00c1cd..c356bd2cc63a 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-3.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-3.dts
> @@ -25,3 +25,15 @@ memory@0 {
>   &sd_emmc_b {
>   	broken-cd;/* cd-gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_LOW>;*/
>   };
> +
> +&i2c_AO {
> +	/* EEPROM on base board */
> +	eeprompd: eeprom@56 {
> +		compatible = "atmel,24c64";
> +		reg = <0x56>;
> +		pagesize = <0x20>;
> +		label = "eeprompd";
> +		address-width = <0x10>;
> +		vcc-supply = <&vddao_3v3>;
> +	};
> +};

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
