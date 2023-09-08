Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6A4798714
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 14:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243237AbjIHMeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 08:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239933AbjIHMec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:34:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763351BF4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 05:34:26 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401da71b83cso22415645e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 05:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694176465; x=1694781265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwlYp2Ret+PHUOy/+lpD5lWplu3GLSy3wqa3Tr7W/eM=;
        b=vNx9Y3158MV+bbxaQ4yJIDiPWcBJXzcjKm0dqJrD6l6M0CcmxUk/NQcxD9FQIKWCyc
         HqTm4aYH30j/qe+q5rrCKeZ/upLTK62+693y7tlEKLHG7IPRzQBxnZZPhNQeCDyXR7Ow
         DHFM3nq3c1VwxJtSvqzgc73Kc+snxop46ab8ROz3Wbiir8CInqo+V9cAfKGeDu3w8H3b
         QLgm1nciuKkVhdXOHucwqfXMr2Uw53HZFUc9joq+gLNlz4lGNlIp2o/V3Bz/pJIUn9LT
         0lL9jK6NV3+pfxitAu2UwkLeBhWZ4MqPq2sRp0Z4/8u/AUWlqf37Qbjsz60Y/x6myliP
         sY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694176465; x=1694781265;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gwlYp2Ret+PHUOy/+lpD5lWplu3GLSy3wqa3Tr7W/eM=;
        b=GWSnip3zx0kxf3Tp7QE5A8EjasVpZNkf8tBfg928CuwKzhK/uB35xRaT2AnVe22PCA
         jUJWR2WYtF0OAFJDaVkLr0sJ5FemAPt/Esr4CUZRjLcb4//5U1oNoETuDl+9Ha1rUGOH
         c0ehzlpRaW6UX72gRdSXj8Tc3/sQl5aEvHLgi9oVCWD0B2zgMviNLkpfj41UjkxzsPcP
         HqvqidPq28KmSgCPYxjcvfCKZeDJiK8Ur0+Bvt48F3fS6/CYf0f6GcV8Ug4V0lihhcHZ
         OpD9ptaD2R8adZqA/1l7H7Ea+NBj8uytId+N3HuQl+XFXcAosmIERoAWj9ib7KsuH24Y
         qjpw==
X-Gm-Message-State: AOJu0YwIJY6U9MBONTWhh5y87sU2ot3as8TU19HJ/bk0vLtJLV4jHwTb
        XIkD84UnaxxhvL8SR6Oqk5rUxA==
X-Google-Smtp-Source: AGHT+IHAIoDqQVvm/1vJfqGAmJ4KhDdS1U6swBfoIErsJPNuBVgp4MAMC1y77kixIzj4YFLKwzkv+Q==
X-Received: by 2002:a7b:ce14:0:b0:3ff:233f:2cfb with SMTP id m20-20020a7bce14000000b003ff233f2cfbmr1944897wmc.23.1694176464796;
        Fri, 08 Sep 2023 05:34:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5f1a:ed04:d131:cda4? ([2a01:e0a:982:cbb0:5f1a:ed04:d131:cda4])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c294400b003fbdbd0a7desm5097730wmd.27.2023.09.08.05.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 05:34:24 -0700 (PDT)
Message-ID: <83819915-d957-4c8f-927a-d32f7963c532@linaro.org>
Date:   Fri, 8 Sep 2023 14:34:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 00/15] arm64: dts: meson: a1: introduce several
 peripheral IPs
Content-Language: en-US, fr
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, conor+dt@kernel.org
Cc:     kernel@sberdevices.ru, sdfw_system_team@sberdevices.ru,
        rockosov@gmail.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230823213630.12936-1-ddrokosov@sberdevices.ru>
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
In-Reply-To: <20230823213630.12936-1-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 23:36, Dmitry Rokosov wrote:
> This patch series introduces device tree declarations for various
> peripheral IPs of the A1 SoC family, including clock controllers, EFUSE,
> USB, SPI Flash Controller, SDIO, and UART_AO:
>      - CLK: A1 SoC has four types on the board, namely PLL, Peripherals,
>        CPU, and Audio, but only Amlogic A1 PLL and Peripherals clock
>        controllers are currently supported.
>      - EFUSE: consists of a 4k bit One Time Programmable (OTP) memory
>        divided into 32 128-bit blocks, and data is accessed using the APB
>        bus through software or the Key-ladder integrated with the EFUSE
>        block.
>      - USB: only one USB 2.0 high-speed port is available in the A1 SoC,
>        supporting both HOST and DEVICE modes for OTG.
>      - SPI Flash Controller: 4-bit QPI/SPI NOR Flash or NAND FLASH
>        controller.
>      - SDIO: for WiFi/IEEE802.11 connection.
>      - UART_AO: for Bluetooth connection.
>      - HWRNG: hardware random generator integrated into SoC.
>      - AO SECURE: board info registers.
> 
> The above peripherals are integrated to new AD402 board device tree.
> 
> Changes v2 since v1 at [1]:
>      - reorder meson-a1 dtsi includes to keep them sorted
>      - remove extra empty lines
>      - purge the unnecessary 'okay' status
>      - reorder all device tree nodes (existing and new) sorted by 'reg'
>        values
>      - introduce new saradc definition
>      - add hwrng dts node
>      - provide ao secure dts node with board info registers
>      - include all changes to new AD402 board device tree
>      - add AD402 board to bindings
> 
> Links:
>      [1] https://lore.kernel.org/all/20230607201641.20982-1-ddrokosov@sberdevices.ru/
> 
> Alexey Romanov (3):
>    arm64: dts: meson: a1: enable efuse controller and setup its clk
>    arm64: dts: meson: a1: add hw rng node
>    arm64: dts: meson: a1: add ao secure node
> 
> Dmitry Rokosov (8):
>    arm64: dts: meson: a1: reorder includes to keep them sorted
>    arm64: dts: meson: a1: remove extra empty line before reset node
>    arm64: dts: meson: a1: remove the unnecessary 'okay' status pwrc value
>    arm64: dts: meson: a1: reorder gpio_intc node definition
>    arm64: dts: meson: a1: introduce PLL and Peripherals clk controllers
>    arm64: dts: meson: a1: support USB controller in OTG mode
>    arm64: dts: introduce Amlogic AD402 reference board based on A113L SoC
>    dt-bindings: arm: amlogic: add Amlogic AD402 bindings
> 
> George Stark (1):
>    arm64: dts: meson: a1: add saradc definition
> 
> Jan Dakinevich (1):
>    arm64: dts: meson: a1: add eMMC controller and its pins
> 
> Martin Kurbanov (1):
>    arm64: dts: meson: a1: introduce SPI Flash Controller
> 
> Oleg Lyovin (1):
>    arm64: dts: meson: a1: introduce UART_AO mux definitions
> 
>   .../devicetree/bindings/arm/amlogic.yaml      |   1 +
>   arch/arm64/boot/dts/amlogic/Makefile          |   1 +
>   .../arm64/boot/dts/amlogic/meson-a1-ad402.dts | 145 ++++++++++++
>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi     | 213 +++++++++++++++++-
>   4 files changed, 348 insertions(+), 12 deletions(-)
>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts
> 

For the whole serie:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks !

Neil
