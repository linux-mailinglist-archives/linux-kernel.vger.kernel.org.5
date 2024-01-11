Return-Path: <linux-kernel+bounces-23213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9839682A903
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD44282D56
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6738E572;
	Thu, 11 Jan 2024 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZS1OmduY"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D5314F7A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cd2f472665so54587041fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 00:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704961255; x=1705566055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d8H8nLABIrRnbxfnMrbAUP0DbCSuPWhYrIfqcQ3RIvA=;
        b=ZS1OmduYEkt0hjV0F4lF/uVpcmcUH5Viug7Zo3DZ/z/QruqatBbUn+3iLwXdIy2U4c
         LFK5RukWXRzIlMzZRG+o+Ry2/GY960VKJTPeb/ED/0+UrsJhsfA09ala2yhrxgZcZ/rY
         whEsOp/Fuxflfggl/EC3ky2veC6JB2RlFMjmCq3apMOfPso0nMEdgK9MPcjUPDk9Xgt3
         QCMOC8dlyQNuH8H5xhRchROJ/9eliOpf0Hx2w5uqLW2yf8kWA67HyftZRg2Ve2AwAHwT
         rEUTI+ohR5Zkvsevh4BklP5r8Ztm/80bO1uzE7u+7YPgkZwiSV9lQrlh1DGE34ubltU9
         ISRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704961255; x=1705566055;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d8H8nLABIrRnbxfnMrbAUP0DbCSuPWhYrIfqcQ3RIvA=;
        b=t6zSEj03v+ZoWka5ET5u18ylCfmZ5Dmt3F8w+VaBn41V/unWqvOeJCFsV7k+Mpr94U
         HY/4dW0ZoW483GfeLVjqRF4Wh9uxApIRObZ+5MF3B4XuBMak5qZbZqj4F3fUtdyXSCxz
         vZO9iDLVKYyRxC+A2OfiuI0OOoYN/Q0WzoD5VlHvvyoZr7LxeatOAnFS0UKc80DdM40T
         PSgj3M5JCnJqIICO/1/bzVVOfd1skk1/W9ZeadGUhWO4F2+hWIj4LWMegyoU3rUOY7YZ
         P+NlqC1uz0d7qArSu34Gr90c/vxQm8mRNTi2IE0ZPlCnM6LRKLPoRLe6s5NHLyB7DR4r
         czBA==
X-Gm-Message-State: AOJu0YyEDm3eYH7lSS5GE1k/qlTwOLVxqqNS1IoBGPqjjbz8lraYi7El
	VHbO+TS4WKxjqOOcFyiGcPvAtEo/O0mBmA==
X-Google-Smtp-Source: AGHT+IHFIdzzA8pDHnJscKixDdClY522jcwFHATS2Aupj39MBfjX5t+c8qexSW8CJXjpE5qrRmvjLw==
X-Received: by 2002:a2e:9209:0:b0:2cc:daca:2e81 with SMTP id k9-20020a2e9209000000b002ccdaca2e81mr138241ljg.15.1704961255185;
        Thu, 11 Jan 2024 00:20:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a5aa:e466:ae57:5a26? ([2a01:e0a:982:cbb0:a5aa:e466:ae57:5a26])
        by smtp.gmail.com with ESMTPSA id j27-20020adfb31b000000b00336e32338f3sm550474wrd.70.2024.01.11.00.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 00:20:54 -0800 (PST)
Message-ID: <8bc3b9e3-3623-41fa-a269-c0f439aee1b5@linaro.org>
Date: Thu, 11 Jan 2024 09:20:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 02/24] drivers: crypto: meson: make CLK controller
 optional
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com,
 clabbe@baylibre.com, herbert@gondor.apana.org.au, davem@davemloft.net,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 khilman@baylibre.com, jbrunet@baylibre.com, artin.blumenstingl@googlemail.com
Cc: linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@salutedevices.com,
 Jan Dakinevich <yvdakinevich@salutedevices.com>
References: <20240110201216.18016-1-avromanov@salutedevices.com>
 <20240110201216.18016-3-avromanov@salutedevices.com>
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
In-Reply-To: <20240110201216.18016-3-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/01/2024 21:11, Alexey Romanov wrote:
> Not all Amlogic SoC's uses CLK controller.

In this case you must make clocks not required for the new platforms in the bindings.

Neil

> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> Signed-off-by: Jan Dakinevich <yvdakinevich@salutedevices.com>
> ---
>   drivers/crypto/amlogic/amlogic-gxl-core.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
> index a5df061f9890..e5f504fb477e 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-core.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
> @@ -248,16 +248,10 @@ static int meson_crypto_probe(struct platform_device *pdev)
>   		dev_err(&pdev->dev, "Cannot request MMIO err=%d\n", err);
>   		return err;
>   	}
> -	mc->busclk = devm_clk_get(&pdev->dev, "blkmv");
> +	mc->busclk = devm_clk_get_optional_enabled(&pdev->dev, "blkmv");
>   	if (IS_ERR(mc->busclk)) {
>   		err = PTR_ERR(mc->busclk);
> -		dev_err(&pdev->dev, "Cannot get core clock err=%d\n", err);
> -		return err;
> -	}
> -
> -	err = clk_prepare_enable(mc->busclk);
> -	if (err != 0) {
> -		dev_err(&pdev->dev, "Cannot prepare_enable busclk\n");
> +		dev_err(&pdev->dev, "Cannot get and enable core clock err=%d\n", err);
>   		return err;
>   	}
>   
> @@ -279,7 +273,6 @@ static int meson_crypto_probe(struct platform_device *pdev)
>   	meson_unregister_algs(mc);
>   error_flow:
>   	meson_free_chanlist(mc, mc->flow_cnt - 1);
> -	clk_disable_unprepare(mc->busclk);
>   	return err;
>   }
>   
> @@ -295,7 +288,6 @@ static int meson_crypto_remove(struct platform_device *pdev)
>   
>   	meson_free_chanlist(mc, mc->flow_cnt - 1);
>   
> -	clk_disable_unprepare(mc->busclk);
>   	return 0;
>   }
>   


