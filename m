Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CD678AFDD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjH1MQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjH1MQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:16:49 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C73811A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 05:16:47 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31aeef88a55so2555257f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 05:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693225006; x=1693829806;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZuizckw45998AR6QtCXfw5DbbirqliA6Qj9SYukWNQ=;
        b=gr5jBlzwmGC61xdjqkCu/QVUKM7ZVSaWqd6e/NXmUeuuFik5LKbE4RIKoMiGPG7LIk
         z6Tz2YleQV8fVnPoGSCNEFF2RLQ0BUMcUGDrZiQEDojwA8bBJZ+vI1gYtWl3ZQLJg3gh
         UpZdWT+N98Yt4Dm/H4NNRa1Xm5R6YyI1zRz3uG3ZQbf5qKlm4uOdjh0P/hjXzXYjKDvA
         b6b1X+hOc5y38yM74Crp7xRt+B71Xulq5UlixMQNdlOjc3iy+54hsM00H89YVoBEu3vU
         gtZRJy+rzFTxbMKwNOrXGj3DMxexWd5MLimqFSaRN++dUz786iVjbs1uXQG9/3Wu6KAu
         Zxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693225006; x=1693829806;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sZuizckw45998AR6QtCXfw5DbbirqliA6Qj9SYukWNQ=;
        b=VjV3E/pC/zixJNZR7SwRcQDjSXFvtVw0TFqcOcBZcG0G2DtsFvEotEUQ27zr0u12M5
         m98QYYr0jhDcGfxHN8PeO1S/phHXvv95WQbSmc3R5c1G0a+pP2Z7kQRRXaH22+c1EcZA
         5WOKQyoVHsLt6FlA+aC5DR7gQayUDAVAGbZk7oFGrQYvqsNtLdwxkYa5e8d5X1xNaoVv
         lP+4JLCZpjM71y1gCwjmcxgqQkEkDLeH68C3uOQJ2GCVXwIhNnPEYb/468u6MVjXkjhY
         YoKfdPVikJuMGT6h6jlkYi/eKsggfSJ0kA/lnhU+BNfak92KRSRW9ROddA+oDJ7KMQ9k
         TynA==
X-Gm-Message-State: AOJu0YwFFYXRd6IYVlJHM97w7edChrUH16fCctWQMGn/DbFOOdq39xUr
        IAaFiwiC04lPX90NWknWz8QOSQ==
X-Google-Smtp-Source: AGHT+IFIf+QuOGUqCwGjbKIFDIcOjlq3Nu/TaeRktQH/Z1Og89+EJ/bldN1jMS69WdKWg+aSp+7aiw==
X-Received: by 2002:a5d:5242:0:b0:31a:d4e1:ea30 with SMTP id k2-20020a5d5242000000b0031ad4e1ea30mr22248819wrc.17.1693225005693;
        Mon, 28 Aug 2023 05:16:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5e59:c27b:747a:3f52? ([2a01:e0a:982:cbb0:5e59:c27b:747a:3f52])
        by smtp.gmail.com with ESMTPSA id bs19-20020a056000071300b0031c855d52efsm7798804wrb.87.2023.08.28.05.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 05:16:45 -0700 (PDT)
Message-ID: <7720b990-c9cf-4c3d-8bb2-928b3b17f089@linaro.org>
Date:   Mon, 28 Aug 2023 14:16:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] tty: serial: meson: Add a earlycon for the S4 SoC
Content-Language: en-US, fr
To:     Lucas Tanure <tanure@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20230828121053.60838-1-tanure@linux.com>
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
In-Reply-To: <20230828121053.60838-1-tanure@linux.com>
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

Hi,

On 28/08/2023 14:10, Lucas Tanure wrote:
> The new Amlogic S4 SoC does not have a always-on uart, so add
> OF_EARLYCON_DECLARE for it.
> 
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>   drivers/tty/serial/meson_uart.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 790d910dafa5..8dfaa260e545 100644
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

Not sure why you would change both lines, and where's the t7 entry ?

Neil

>   
>   #define MESON_SERIAL_CONSOLE_PTR(_devname) (&meson_serial_console_##_devname)
>   #else

