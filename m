Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C0479FE5C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbjINI2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236446AbjINI2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:28:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F4F1FD5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:28:30 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31ad9155414so569249f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694680109; x=1695284909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hJvi7Qukr4KTmm3HO3pBuqIIqV4p0lbOZT5NLNK++Y=;
        b=lVOQto6AnRozD+pOr0QIRTPE7Azmmm+mOfTRpPjTQEKvbNiuorE/zvITXFi4+6Oilm
         6sdcOtKXgwYPHi2YShKqpggUkyQG/wG4fm/+t3DW0fXVjVyN5VJz2rsYiF1+5fdBqghu
         xip1EM1tPsCEueldco9mYMetBKqbB/H7d5w/HH3+xkKLvhmuTqB8RB6Lpo4KszyfLyg/
         WZFLcY6IGuL/SLXz016oV3WGfo705dDsU8sPQpxFMlzaxUREYooUpgl0q754y71X/+02
         /Sc1w3/pxLfgpeESaDYbkKf/Gh84ufIp8Wpd2yut/P6EW4wYqBPcRuPC07fNMUp14nTk
         jDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694680109; x=1695284909;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9hJvi7Qukr4KTmm3HO3pBuqIIqV4p0lbOZT5NLNK++Y=;
        b=elB/qAJ0Dn5A6tTI81/GnEDFBkslNZbLcHXHwTb2ELaRpnjqMr0P8gygdI1MYQTE8d
         yDH2/qspZeL37O0u4gOrW1NGp79WHkO4jlTPk4MfMj1q7z64O6bDfFsENaFbEgy0r7z1
         dBM4uv5LOm+lm7HMWiuG9YrB4nPwVJu6mUfFW1Z1fxgI5XWXT1bSFGHrWw+bOyhB/Pzi
         4HkpNiXCQzJ+DA2RHw0+tvpAYa752h96FZYx/zHKfQVR8JicF7Va/xn5pP0xjpJFzeav
         Jj3TT5nWmSjpzFaj/uRsVfC4XXquo3Xo4HBlpUenKkpunGnbFILlpjSkWwQXhL/5ykQl
         XclQ==
X-Gm-Message-State: AOJu0Yx/h7lFdEDTJt3072d8WWlDF/0T0rhLmKRfb0vlkp5NUDrQ9jL/
        TKIuyez5rCxUi8Exxq2m9W85sQ==
X-Google-Smtp-Source: AGHT+IGzqPPfsCJ9P27YSwn8o4MzKsLD9Do+N7Gae6EQlc1D9zP+DatFOySiIeT5E3Ix3L182ClUzQ==
X-Received: by 2002:a5d:6184:0:b0:319:7428:9caa with SMTP id j4-20020a5d6184000000b0031974289caamr4201788wru.38.1694680109062;
        Thu, 14 Sep 2023 01:28:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c61:ffb9:3ed9:c494? ([2a01:e0a:982:cbb0:c61:ffb9:3ed9:c494])
        by smtp.gmail.com with ESMTPSA id w16-20020adfec50000000b003141a3c4353sm1091493wrn.30.2023.09.14.01.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 01:28:28 -0700 (PDT)
Message-ID: <b0d234a5-62fc-45bb-98b3-bf55523a76cc@linaro.org>
Date:   Thu, 14 Sep 2023 10:28:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 1/3] dt-bindings: reset: Add compatible and DT bindings
 for Amlogic C3 Reset Controller
Content-Language: en-US, fr
To:     zelong dong <zelong.dong@amlogic.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        yonghui.yu@amlogic.com, kelvin.zhang@amlogic.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Rob Herring <robh@kernel.org>
References: <20230914064018.18790-1-zelong.dong@amlogic.com>
 <20230914064018.18790-2-zelong.dong@amlogic.com>
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
In-Reply-To: <20230914064018.18790-2-zelong.dong@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 08:40, zelong dong wrote:
> From: Zelong Dong <zelong.dong@amlogic.com>
> 
> Add new compatible and DT bindings for Amlogic C3 Reset Controller
> 
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   .../bindings/reset/amlogic,meson-reset.yaml   |   1 +
>   include/dt-bindings/reset/amlogic,c3-reset.h  | 119 ++++++++++++++++++
>   2 files changed, 120 insertions(+)
>   create mode 100644 include/dt-bindings/reset/amlogic,c3-reset.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
> index d3fdee89d4f8..f0c6c0df0ce3 100644
> --- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
> +++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
> @@ -18,6 +18,7 @@ properties:
>         - amlogic,meson-axg-reset # Reset Controller on AXG and compatible SoCs
>         - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
>         - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
> +      - amlogic,c3-reset # Reset Controller on C3 and compatible SoCs
>   
>     reg:
>       maxItems: 1
> diff --git a/include/dt-bindings/reset/amlogic,c3-reset.h b/include/dt-bindings/reset/amlogic,c3-reset.h
> new file mode 100644
> index 000000000000..d9127863f603
> --- /dev/null
> +++ b/include/dt-bindings/reset/amlogic,c3-reset.h
> @@ -0,0 +1,119 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> +/*
> + * Copyright (c) 2023 Amlogic, Inc. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_AMLOGIC_C3_RESET_H
> +#define _DT_BINDINGS_AMLOGIC_C3_RESET_H
> +
> +/* RESET0 */
> +/*						0-3 */
> +#define RESET_USBCTRL				4
> +/*						5-7 */
> +#define RESET_USBPHY20				8
> +/*						9 */
> +#define RESET_USB2DRD				10
> +#define RESET_MIPI_DSI_HOST			11
> +#define RESET_MIPI_DSI_PHY			12
> +/*						13-20 */
> +#define RESET_GE2D				21
> +#define RESET_DWAP				22
> +/*						23-31 */
> +
> +/* RESET1 */
> +#define RESET_AUDIO				32
> +/*						33-34 */
> +#define RESET_DDRAPB				35
> +#define RESET_DDR				36
> +#define RESET_DOS_CAPB3				37
> +#define RESET_DOS				38
> +/*						39-46 */
> +#define RESET_NNA				47
> +#define RESET_ETHERNET				48
> +#define RESET_ISP				49
> +#define RESET_VC9000E_APB			50
> +#define RESET_VC9000E_A				51
> +/*						52 */
> +#define RESET_VC9000E_CORE			53
> +/*						54-63 */
> +
> +/* RESET2 */
> +#define RESET_ABUS_ARB				64
> +#define RESET_IRCTRL				65
> +/*						66 */
> +#define RESET_TEMP_PII				67
> +/*						68-72 */
> +#define RESET_SPICC_0				73
> +#define RESET_SPICC_1				74
> +#define RESET_RSA				75
> +
> +/*						76-79 */
> +#define RESET_MSR_CLK				80
> +#define RESET_SPIFC				81
> +#define RESET_SAR_ADC				82
> +/*						83-87 */
> +#define RESET_ACODEC				88
> +/*						89-90 */
> +#define RESET_WATCHDOG				91
> +/*						92-95 */
> +
> +/* RESET3 */
> +#define RESET_ISP_NIC_GPV			96
> +#define RESET_ISP_NIC_MAIN			97
> +#define RESET_ISP_NIC_VCLK			98
> +#define RESET_ISP_NIC_VOUT			99
> +#define RESET_ISP_NIC_ALL			100
> +#define RESET_VOUT				101
> +#define RESET_VOUT_VENC				102
> +/*						103 */
> +#define RESET_CVE_NIC_GPV			104
> +#define RESET_CVE_NIC_MAIN			105
> +#define RESET_CVE_NIC_GE2D			106
> +#define RESET_CVE_NIC_DW			106
> +#define RESET_CVE_NIC_CVE			108
> +#define RESET_CVE_NIC_ALL			109
> +#define RESET_CVE				110
> +/*						112-127 */
> +
> +/* RESET4 */
> +#define RESET_RTC				128
> +#define RESET_PWM_AB				129
> +#define RESET_PWM_CD				130
> +#define RESET_PWM_EF				131
> +#define RESET_PWM_GH				132
> +#define RESET_PWM_IJ				133
> +#define RESET_PWM_KL				134
> +#define RESET_PWM_MN				135
> +/*						136-137 */
> +#define RESET_UART_A				138
> +#define RESET_UART_B				139
> +#define RESET_UART_C				140
> +#define RESET_UART_D				141
> +#define RESET_UART_E				142
> +#define RESET_UART_F				143
> +#define RESET_I2C_S_A				144
> +#define RESET_I2C_M_A				145
> +#define RESET_I2C_M_B				146
> +#define RESET_I2C_M_C				147
> +#define RESET_I2C_M_D				148
> +/*						149-151 */
> +#define RESET_SD_EMMC_A				152
> +#define RESET_SD_EMMC_B				153
> +#define RESET_SD_EMMC_C				154
> +
> +/* RESET5 */
> +/*						160-172 */
> +#define RESET_BRG_NIC_NNA			173
> +#define RESET_BRG_MUX_NIC_MAIN			174
> +#define RESET_BRG_AO_NIC_ALL			175
> +/*						176-183 */
> +#define RESET_BRG_NIC_VAPB			184
> +#define RESET_BRG_NIC_SDIO_B			185
> +#define RESET_BRG_NIC_SDIO_A			186
> +#define RESET_BRG_NIC_EMMC			187
> +#define RESET_BRG_NIC_DSU			188
> +#define RESET_BRG_NIC_SYSCLK			189
> +#define RESET_BRG_NIC_MAIN			190
> +#define RESET_BRG_NIC_ALL			191
> +
> +#endif

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
