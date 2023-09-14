Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB757A0311
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjINLvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbjINLvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:51:22 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2776CC3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:51:17 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-402d0eda361so9440745e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694692276; x=1695297076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1mqJPJDpys3PXut3MF0xg/8K+gdK10b2MkZh7aNYlm0=;
        b=DZCqTrZ+o+GUXCwWzh8qrKRoc4tKWMPc6Ifr4myI7wxLp0YK87IZ9Ctg0IJQngvUbp
         zvcB7dbSNPiYO1MNeyLdkZGFxOr5uAQ4rZMCkEEuO6oOFPvGBOOtAla4ongtzRqUYhEI
         XIn1FizF11WjDU3tWMLbPqRcM3TtL4FXl7LRPkwojBE5CQFM6fPYkDitB4vVAtFaF+Fp
         LtbmuCisqx1qLJSz1s8V4wGmFFBTWCj0+S1foQi2hV2a4TjwFCK9bOcXoL7PNEGf7PPu
         799zswYbYPXE4Kczbx/mhr+MyndXT8DqBjWHOvGE8s5+NyGH7OCJvH51z2JAZcVH7U4m
         n77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694692276; x=1695297076;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1mqJPJDpys3PXut3MF0xg/8K+gdK10b2MkZh7aNYlm0=;
        b=UmnYGzJNnTRTbPQ8S9vbk+ffhuwpUzcH4yduytC1W5HG33tquROt3u8KHGKHk+VAn5
         tG7WwwLzvbfrplt2DL//ukVSHoj8eSuQikjvsC2W67MNLeSWEkIvIF3Ulygh03TJQgbk
         BB0gzxceSK3lqYa+iMRtpENVPxAqdKdyi0LSTMRjD/O4BYbTOYsVOB/XN+c66TyqPqSh
         1S+64iHdT3uMNjR+68c7OU8EV0XUQiM/58wVImN8Wx7D3JfgRgvUnS7swgYWsLYjjEx1
         dLV5y4HX6Sy5e6BjNh8Y/NBcr0/KsZJMf/AXTX7ijUcKhAY7RIH2siLs9/j0sjCqHGOb
         wXOw==
X-Gm-Message-State: AOJu0YykfBh/Xb5i7xG2TKuKc+CYhZPQdSVRDQp9F7ioj7cllutRHCLd
        35UoQ6N6cYCvUUq3kU6UhTlNVA==
X-Google-Smtp-Source: AGHT+IFhiLSyyl4rWajoECxKPRXZ7SGT5X6B80cq1J5IpphvEE2zx+AAn5qstiTw0pJGSRf9KFzTOQ==
X-Received: by 2002:a7b:ce0d:0:b0:401:daf2:2737 with SMTP id m13-20020a7bce0d000000b00401daf22737mr4998074wmc.30.1694692276302;
        Thu, 14 Sep 2023 04:51:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c61:ffb9:3ed9:c494? ([2a01:e0a:982:cbb0:c61:ffb9:3ed9:c494])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c294c00b003ff3b964a9asm4640351wmd.39.2023.09.14.04.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 04:51:15 -0700 (PDT)
Message-ID: <85947a27-cae5-4466-b2dc-b12d63bd8e4d@linaro.org>
Date:   Thu, 14 Sep 2023 13:51:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 03/17] pmdomain: amlogic: Move Kconfig options to the
 pmdomain subsystem
Content-Language: en-US, fr
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
References: <20230914111702.586501-1-ulf.hansson@linaro.org>
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
In-Reply-To: <20230914111702.586501-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 13:17, Ulf Hansson wrote:
> The Kconfig options belongs closer to the corresponding implementations,
> hence let's move them from the soc subsystem to the pmdomain subsystem.
> 
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: <linux-amlogic@lists.infradead.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/pmdomain/Kconfig         |  1 +
>   drivers/pmdomain/amlogic/Kconfig | 39 ++++++++++++++++++++++++++++++++
>   drivers/soc/amlogic/Kconfig      | 35 ----------------------------
>   3 files changed, 40 insertions(+), 35 deletions(-)
>   create mode 100644 drivers/pmdomain/amlogic/Kconfig
> 
> diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
> index 8acb10bcdec9..07d2f8165abe 100644
> --- a/drivers/pmdomain/Kconfig
> +++ b/drivers/pmdomain/Kconfig
> @@ -2,5 +2,6 @@
>   menu "Power Domains Support"
>   
>   source "drivers/pmdomain/actions/Kconfig"
> +source "drivers/pmdomain/amlogic/Kconfig"
>   
>   endmenu
> diff --git a/drivers/pmdomain/amlogic/Kconfig b/drivers/pmdomain/amlogic/Kconfig
> new file mode 100644
> index 000000000000..ee1affffbce6
> --- /dev/null
> +++ b/drivers/pmdomain/amlogic/Kconfig
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menu "Amlogic Power Domains"
> +
> +config MESON_GX_PM_DOMAINS
> +	tristate "Amlogic Meson GX Power Domains driver"
> +	depends on ARCH_MESON || COMPILE_TEST
> +	depends on PM && OF
> +	default ARCH_MESON
> +	select PM_GENERIC_DOMAINS
> +	select PM_GENERIC_DOMAINS_OF
> +	help
> +	  Say yes to expose Amlogic Meson GX Power Domains as
> +	  Generic Power Domains.
> +
> +config MESON_EE_PM_DOMAINS
> +	tristate "Amlogic Meson Everything-Else Power Domains driver"
> +	depends on ARCH_MESON || COMPILE_TEST
> +	depends on PM && OF
> +	default ARCH_MESON
> +	select PM_GENERIC_DOMAINS
> +	select PM_GENERIC_DOMAINS_OF
> +	help
> +	  Say yes to expose Amlogic Meson Everything-Else Power Domains as
> +	  Generic Power Domains.
> +
> +config MESON_SECURE_PM_DOMAINS
> +	tristate "Amlogic Meson Secure Power Domains driver"
> +	depends on (ARCH_MESON || COMPILE_TEST) && MESON_SM
> +	depends on PM && OF
> +	depends on HAVE_ARM_SMCCC
> +	default ARCH_MESON
> +	select PM_GENERIC_DOMAINS
> +	select PM_GENERIC_DOMAINS_OF
> +	help
> +	  Support for the power controller on Amlogic A1/C1 series.
> +	  Say yes to expose Amlogic Meson Secure Power Domains as Generic
> +	  Power Domains.
> +
> +endmenu
> diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
> index 174a9b011461..d08e398bdad4 100644
> --- a/drivers/soc/amlogic/Kconfig
> +++ b/drivers/soc/amlogic/Kconfig
> @@ -26,41 +26,6 @@ config MESON_GX_SOCINFO
>   	  Say yes to support decoding of Amlogic Meson GX SoC family
>   	  information about the type, package and version.
>   
> -config MESON_GX_PM_DOMAINS
> -	tristate "Amlogic Meson GX Power Domains driver"
> -	depends on ARCH_MESON || COMPILE_TEST
> -	depends on PM && OF
> -	default ARCH_MESON
> -	select PM_GENERIC_DOMAINS
> -	select PM_GENERIC_DOMAINS_OF
> -	help
> -	  Say yes to expose Amlogic Meson GX Power Domains as
> -	  Generic Power Domains.
> -
> -config MESON_EE_PM_DOMAINS
> -	tristate "Amlogic Meson Everything-Else Power Domains driver"
> -	depends on ARCH_MESON || COMPILE_TEST
> -	depends on PM && OF
> -	default ARCH_MESON
> -	select PM_GENERIC_DOMAINS
> -	select PM_GENERIC_DOMAINS_OF
> -	help
> -	  Say yes to expose Amlogic Meson Everything-Else Power Domains as
> -	  Generic Power Domains.
> -
> -config MESON_SECURE_PM_DOMAINS
> -	tristate "Amlogic Meson Secure Power Domains driver"
> -	depends on (ARCH_MESON || COMPILE_TEST) && MESON_SM
> -	depends on PM && OF
> -	depends on HAVE_ARM_SMCCC
> -	default ARCH_MESON
> -	select PM_GENERIC_DOMAINS
> -	select PM_GENERIC_DOMAINS_OF
> -	help
> -	  Support for the power controller on Amlogic A1/C1 series.
> -	  Say yes to expose Amlogic Meson Secure Power Domains as Generic
> -	  Power Domains.
> -
>   config MESON_MX_SOCINFO
>   	bool "Amlogic Meson MX SoC Information driver"
>   	depends on (ARM && ARCH_MESON) || COMPILE_TEST

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
