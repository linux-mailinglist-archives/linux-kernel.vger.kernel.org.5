Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0707BDCEC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376610AbjJIM5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376284AbjJIM5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:57:13 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC698F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:57:12 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3226cc3e324so4427451f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 05:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696856231; x=1697461031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZXoHEUdlaSpzaGNvl0KYK8jIguk5p4r9xc4kKWkyNI=;
        b=cQ8n5i8gBa6K5tN65CTo0SfyYm3lqrHYuM7Hjhg0fboo73ZIf1Vw5bs97nrGOcQ7R9
         NoxKEl+qPh+d6w+REN0VGQhYHWfMqwP/kVP/bocTd2hUsEsIRZ7TW23ZB6w1kG+zwE48
         hNAaMMYzNhqEQowpEIUuXXU1XbZDYfzh57B9kI5jUkbKbqWskkzp1SYICz5pU7G6B81e
         TgkKFhx3IqfJcIsbHg4hewVu8OaGps7maOVqowKiRIYQ7564GgokGVWaj498Z2OeAYXk
         voGrz9GBedmE/cJ2qQHtXCd0NvqY5KNTlZ959c288nh2hqIm/lb87VTepx3djB3I7RDx
         WGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696856231; x=1697461031;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EZXoHEUdlaSpzaGNvl0KYK8jIguk5p4r9xc4kKWkyNI=;
        b=wP2GkcNuFKa5V0droeMTmcgJFYRZtZR0dl0G7a++geKxEsyWoHTIoB3TwIb14e6V7F
         J3eGwubV21Umwf2fZioUF7fEcJ5TuD5/Oyh/Hg2u4muHtxthAXfy7xqjI0rZLg5j1PWe
         QWUCb21YyTmGknVgPdAmKNvfLt6FytOEUHMDKc5b7y0ogVWlz/tEsxFYA2lRQBQlh8wc
         /57ZzX5d+i/izNthHg1QU4cfdpLMNgD/bNXwlW4L5y4K5OoCcrXAc8daSg8oVMq3PxTA
         Y8jhWX+sWpAT7U2FizQarZUk8Ngf6tV2yfk3SfssHvahqMJFeaDKwPJ3d87l46SPg7vq
         tZqg==
X-Gm-Message-State: AOJu0YzkNxbjKr5o2oqWNblUvPMiUWu0H/aw4+SoNDbX3f9XoDU/wCMn
        207EUCa84lLPZhkfmYA3kkY0cQ==
X-Google-Smtp-Source: AGHT+IFCcZ9U4VKbmvYJqVAUH/X0Z49KpYeQVkB7vsetwEcUfdpmXdEvFY1+nTDw39WcIZKChcMilw==
X-Received: by 2002:adf:f641:0:b0:31f:b6ea:af48 with SMTP id x1-20020adff641000000b0031fb6eaaf48mr13186215wrp.49.1696856230815;
        Mon, 09 Oct 2023 05:57:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4406:fc3c:1c62:7b3e? ([2a01:e0a:982:cbb0:4406:fc3c:1c62:7b3e])
        by smtp.gmail.com with ESMTPSA id m8-20020a056000180800b00321773bb933sm9575321wrh.77.2023.10.09.05.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 05:57:10 -0700 (PDT)
Message-ID: <d25ce389-b18b-4c45-9c61-5a909b514699@linaro.org>
Date:   Mon, 9 Oct 2023 14:57:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] tty: serial: meson: Add a earlycon for the S4 SoC
Content-Language: en-US, fr
To:     Lucas Tanure <tanure@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20231009121151.4509-1-tanure@linux.com>
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
In-Reply-To: <20231009121151.4509-1-tanure@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2023 14:11, Lucas Tanure wrote:
> The new Amlogic S4 SoC does not have a always-on uart, so add
> OF_EARLYCON_DECLARE for it.
> Amlogic T7 will use this as fallback.
> 
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>   drivers/tty/serial/meson_uart.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 45cc23e9e399..de298bf75d9b 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -646,8 +646,8 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
>   	return 0;
>   }
>   
> -OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
> -		    meson_serial_early_console_setup);
> +OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart", meson_serial_early_console_setup);
> +OF_EARLYCON_DECLARE(meson, "amlogic,meson-s4-uart", meson_serial_early_console_setup);
>   
>   #define MESON_SERIAL_CONSOLE_PTR(_devname) (&meson_serial_console_##_devname)
>   #else

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
