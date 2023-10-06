Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E907BBAA9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjJFOqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjJFOqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:46:10 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BCCEB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:46:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4066241289bso20072445e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 07:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696603566; x=1697208366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TsQDvBQyiI7S1j64qZjOzMp7n6CvTcSWgBEdZ94b3pE=;
        b=bRXfTrLSjKGobiGJKEruRiApYfVSYeSnO4KGvU4fxgXg5CAJmrjQGCvFp/BtHWj4pM
         rkoqDs82XMSDAsVfkemOrJY6QcbIa1t3Sfr9OLS0XeJ5XN8QjxB1C+qhmf3RoQc37sef
         TyAhuO3F5COXb7TvYFFmF8KwORkrQHmFYJJppPQlOWDXYXWOwJYFdo3HenP2CcZNawod
         aktGaIwY8mt9CizylzaTWo5wWcFJpl2yNMBgkiPkLzIa96LQvfY7vZPZNj3ztcBskrpG
         Xl32n3vfB4yxRv8+DajscHNib1iTG3A4iBeG5fpnRyRrwi4aRI1DDJfORt8VFc0xPFA2
         Jn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696603566; x=1697208366;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TsQDvBQyiI7S1j64qZjOzMp7n6CvTcSWgBEdZ94b3pE=;
        b=TZ/SGEWhNmnmtYaeUN4KcO/adyGe9dj1ZRBvFeYTYR4GEtDjZbBb11+QRaJW9Yid83
         F6Nscef9mhsHB0rDrZz0HBjSF03kCB4nXxk8NihE3bzap9SMcPe1tXT5NMMf2pWc19ug
         g0mcN8DUHHHBYFMbsyGd5xEQF8kfqsC3RfysCTCvuyueU+HWXkFyBR91nfFNqCOM006F
         mI3XBW469x9Et5zfCs1NJpFQu4XAm2V/FyPCSh8J4/O4VXaUP19H8U3xFwM7NVH4PCB6
         4XyQQsrWF5oWuwVGrV0xzlmoTesKPVSX+60CtS/ZW3YQ/v2Jl6Gbrl2N/Xy7W/+BhyA5
         2riQ==
X-Gm-Message-State: AOJu0Ywt5X9bITvweaoGI1OBl6dZkYsrPk8ULOeJfu587gzvcbWVHFqY
        Se1h0Woi0qivY/RsLNCdLOT9pw==
X-Google-Smtp-Source: AGHT+IHOEx8hnq/2d9DKkAgq6eUQMbDQ/kXB5aALk4KT7MHdLPXMvo4kgKcbMjARb2k4mqu/vhasFQ==
X-Received: by 2002:a1c:720c:0:b0:3fe:5501:d293 with SMTP id n12-20020a1c720c000000b003fe5501d293mr7513137wmc.30.1696603566357;
        Fri, 06 Oct 2023 07:46:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c8f7:4bc7:2e11:c133? ([2a01:e0a:982:cbb0:c8f7:4bc7:2e11:c133])
        by smtp.gmail.com with ESMTPSA id m7-20020a7bce07000000b003fc16ee2864sm3896804wmc.48.2023.10.06.07.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 07:46:05 -0700 (PDT)
Message-ID: <bf5e3789-8ca3-4347-95c3-278aa1e65be5@linaro.org>
Date:   Fri, 6 Oct 2023 16:46:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: amlogic: cottonwood: fix blue/green led
 inversion
Content-Language: en-US, fr
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>, Da Xue <da.xue@libretech.co>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <20231006141915.3623097-1-jbrunet@baylibre.com>
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
In-Reply-To: <20231006141915.3623097-1-jbrunet@baylibre.com>
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

On 06/10/2023 16:19, Jerome Brunet wrote:
> While making the v2, blue and green LED pwms got inverted
> This change fixes the problem
> 
> Fixes: 9f841514c9c2 ("arm64: dts: amlogic: add libretech cottonwood support")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi b/arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi
> index ed826f673349..35e8f5bae990 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi
> @@ -70,7 +70,7 @@ led {
>   			function = LED_FUNCTION_ACTIVITY;
>   			linux,default-trigger = "heartbeat";
>   			max-brightness = <255>;
> -			pwms = <&pwm_cd 1 1250 0>;
> +			pwms = <&pwm_ab 1 1250 0>;
>   			active-low;
>   		};
>   	};
> @@ -83,7 +83,7 @@ led {
>   			function = LED_FUNCTION_STATUS;
>   			linux,default-trigger = "default-on";
>   			max-brightness = <255>;
> -			pwms = <&pwm_ab 1 1250 0>;
> +			pwms = <&pwm_cd 1 1250 0>;
>   			active-low;
>   		};
>   	};

Squashed into 9f841514c9c2 ("arm64: dts: amlogic: add libretech cottonwood support")

Thanks,
Neil
