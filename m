Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344B97C6D83
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378506AbjJLL6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378664AbjJLL5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:57:47 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C741647B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 04:55:24 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3232be274a0so1302615f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 04:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697111723; x=1697716523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JFbVPfHjsB3vzxjqb/xRtojs+Qso4nPkleZZB9zp81k=;
        b=cDWyK6u2hr1v717wVrsM8fzuWJ5vSGyj5k7Y75IlnIJA48FclCxPSCfE1CoMbB56Mn
         1jVQ3VwhN37nmGpA8aNcoTGzAZITr8PfDr7FBwXMuZ/wsVgtydZa9PiA3HIsk4x7gh0H
         Op/UChZGrhi2sMa0bdzG3MkBf2YIeoYQpoLMw7rSeCQ5OvJ69HOYm+XUQvqO73yVatZ0
         3RRrAEONfzNKYJxlTSz5xqO116KDx1jOOW8h2fu29kozqLT6CznnzZeXs9HoNjVCVogU
         8890XtzFutHn6EZvQI93NQUOS3jo1zNQsBhL56KKOBHU0TE2XOU8uQS7PIfNYpncNs2z
         Bo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697111723; x=1697716523;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JFbVPfHjsB3vzxjqb/xRtojs+Qso4nPkleZZB9zp81k=;
        b=LtH5oo/EsZRGYADc2qs08pSSwreNUw5F140FKEDnaJncTtoOmneVImGlz6LTpEJDNn
         9qwTztnHTy5hMASECrM8BCZh6xCweBKA7a4V752OjkdA1Wdt78LgC2xL2jt+1+x0sau1
         p9bIa7zbQUAlkCTc5/8vOX2WUeLpmxTeEE4NKOCkouv8rECAVmJj/IAhoIfa+sHppIDQ
         U3W30Tehzl4gB+B8Bq8hPBl+eWdwHtbUkAJLd9z6+Iogmt2IBq1t5xC4mY1V8kB40XAB
         WpBzL3ihdIiHKn1pE865IZ2JL1FBte6TwOXy34OqsfYJKqUE4/GYxiFqZ1iowDTQGCld
         9b0g==
X-Gm-Message-State: AOJu0YxStY5Mq50ysHbxjKSjdoLHnQoH+mFdpG+7X58sER1VgQj2ExZZ
        af39F3jRQtL9PeDq3abtEf8JNvJ8jwre3f+baFmL5aW3
X-Google-Smtp-Source: AGHT+IE/7JaYYTpaCa0pzSDfEePxgjUQ8+G7hQLcClFja80Bllm+9gSZbArRRuY3pNZPwr9i0Y1RAQ==
X-Received: by 2002:adf:ab0f:0:b0:32d:8113:eda3 with SMTP id q15-20020adfab0f000000b0032d8113eda3mr5313197wrc.10.1697111723296;
        Thu, 12 Oct 2023 04:55:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:d423:df8b:7f17:7909? ([2a01:e0a:982:cbb0:d423:df8b:7f17:7909])
        by smtp.gmail.com with ESMTPSA id p5-20020a1c7405000000b004064e3b94afsm21802128wmc.4.2023.10.12.04.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 04:55:22 -0700 (PDT)
Message-ID: <ec4951ba-abf6-4461-9e54-8ecbf9fc6cf0@linaro.org>
Date:   Thu, 12 Oct 2023 13:55:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: defconfig: add various drivers for Amlogic based
 boards
Content-Language: en-US, fr
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <CGME20231012103636eucas1p21eec119a94d1f2adfe8d1c2602bd4012@eucas1p2.samsung.com>
 <20231012103600.3381340-1-m.szyprowski@samsung.com>
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
In-Reply-To: <20231012103600.3381340-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2023 12:36, Marek Szyprowski wrote:
> Enable drivers for the hardware blocks present on the Amlogic Meson SoC
> based boards: Khadas VIM3 and Hardkernel Odroid N2 to increase testing
> coverage.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   arch/arm64/configs/defconfig | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 07011114eef8..d3849aae5925 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -423,6 +423,7 @@ CONFIG_MHI_WWAN_MBIM=m
>   CONFIG_INPUT_EVDEV=y
>   CONFIG_KEYBOARD_ADC=m
>   CONFIG_KEYBOARD_GPIO=y
> +CONFIG_KEYBOARD_GPIO_POLLED=m
>   CONFIG_KEYBOARD_SNVS_PWRKEY=m
>   CONFIG_KEYBOARD_IMX_SC_KEY=m
>   CONFIG_KEYBOARD_CROS_EC=y
> @@ -686,6 +687,7 @@ CONFIG_QCOM_SPMI_ADC_TM5=m
>   CONFIG_QCOM_SPMI_TEMP_ALARM=m
>   CONFIG_QCOM_LMH=m
>   CONFIG_UNIPHIER_THERMAL=y
> +CONFIG_KHADAS_MCU_FAN_THERMAL=m
>   CONFIG_WATCHDOG=y
>   CONFIG_SL28CPLD_WATCHDOG=m
>   CONFIG_ARM_SP805_WATCHDOG=y
> @@ -728,6 +730,7 @@ CONFIG_MFD_TPS65219=y
>   CONFIG_MFD_TI_AM335X_TSCADC=m
>   CONFIG_MFD_ROHM_BD718XX=y
>   CONFIG_MFD_WCD934X=m
> +CONFIG_MFD_KHADAS_MCU=m
>   CONFIG_REGULATOR_FIXED_VOLTAGE=y
>   CONFIG_REGULATOR_AXP20X=y
>   CONFIG_REGULATOR_BD718XX=y
> @@ -765,6 +768,8 @@ CONFIG_RC_DEVICES=y
>   CONFIG_IR_GPIO_CIR=m
>   CONFIG_IR_MESON=m
>   CONFIG_IR_SUNXI=m
> +CONFIG_MEDIA_CEC_SUPPORT=y
> +CONFIG_CEC_MESON_G12A_AO=m
>   CONFIG_MEDIA_SUPPORT=m
>   CONFIG_MEDIA_CAMERA_SUPPORT=y
>   CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
> @@ -1112,6 +1117,7 @@ CONFIG_RTC_DRV_RK808=m
>   CONFIG_RTC_DRV_ISL1208=m
>   CONFIG_RTC_DRV_PCF85063=m
>   CONFIG_RTC_DRV_PCF85363=m
> +CONFIG_RTC_DRV_PCF8563=m
>   CONFIG_RTC_DRV_M41T80=m
>   CONFIG_RTC_DRV_BQ32K=m
>   CONFIG_RTC_DRV_RX8581=m
> @@ -1167,6 +1173,7 @@ CONFIG_XEN_GRANT_DEV_ALLOC=y
>   CONFIG_STAGING=y
>   CONFIG_STAGING_MEDIA=y
>   CONFIG_VIDEO_MAX96712=m
> +CONFIG_VIDEO_MESON_VDEC=m
>   CONFIG_CHROME_PLATFORMS=y
>   CONFIG_CROS_EC=y
>   CONFIG_CROS_EC_I2C=y
> @@ -1460,6 +1467,7 @@ CONFIG_QCOM_L3_PMU=y
>   CONFIG_ARM_SPE_PMU=m
>   CONFIG_ARM_DMC620_PMU=m
>   CONFIG_HISI_PMU=y
> +CONFIG_MESON_DDR_PMU=m
>   CONFIG_NVMEM_LAYOUT_SL28_VPD=m
>   CONFIG_NVMEM_IMX_OCOTP=y
>   CONFIG_NVMEM_IMX_OCOTP_ELE=m

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
