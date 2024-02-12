Return-Path: <linux-kernel+bounces-62066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F398B851AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23BE01C22713
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C63645BE6;
	Mon, 12 Feb 2024 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PE23QV8/"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0CF45BE1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757849; cv=none; b=pI4fzhJVSRzO/97KE5knCx+Ww+7C/Iz6VMZOfTo8BIwQVkjKRcNt8WQvYDzbbMT6Iwp4fcQG85Hi82l1xdkFX9tJUEFskn9Q9lrxpBHR7kLtlDxcYvcPGpooHV9UCxzDTTKH/d/CWRihxB8hl+IbodyCOFfMYjDtBtnmu4FTPgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757849; c=relaxed/simple;
	bh=ACgWgiARc/AvHlxGkph6QCWkNli6hCa9jPNldi9bgR0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y4tXGuRMyqkxQTcrNaCsgZ4lHSiWuCUr7pRnmTx3pB1oDt/WJFM2LqIBS2m0VDJvQBdB+T1hTNzCCG4wrvhyIVuBf7Mq3LeyMZsezehouePbo4pyK7FzuMFSFQkle6AwgFDAJnDJzTiwrkdJ5/+BKVo2z5xXOOcS4z54kXm5TWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PE23QV8/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40efcb37373so27710655e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707757846; x=1708362646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aGvoruSq5+YyVDp5RLm++NC4frHeOZ73PUQlBpNiOaA=;
        b=PE23QV8/u5zztxWzhIusX7L+19ENs1xpw/rGGOi8HkO5Cp0UbCgCkX8wDWRNTnKCXS
         hhuNWA5YmMHdGlydxYHWRdKPPuK2R1uEbo+vEHk3Si7lZ9WXV14Qd9P2nkPo8zuFLtIl
         yZ6Vlj67ZBmXOKFAjMZBtvW4zOq9IsmHiS4++wj73rRMRK4CfhUpavFIRrPvM6nFf6Ku
         XSue307QRNc4ZaqqGBxt9uJIr94d60xBDHBj6s0THtVy2mo9b5b20vfRr1zlH6lzq+wJ
         UYJWJuf3cqxrDg0cLTvfvRBJmffQiL7xDe3J+rP3ODveL48sSu18n9xeROAb8vC7EULM
         7mCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757846; x=1708362646;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aGvoruSq5+YyVDp5RLm++NC4frHeOZ73PUQlBpNiOaA=;
        b=M3tfXYpneMiiyU/9YmhpS7gU2Rp0Qzw7VhcN9tPJWP43vtoDDoUaJd0OrohzANSXep
         HuG84yW7bYk3UE2elgUOhZN1NrNchKLj4jpaCB+zermbFTu1WWMEhDPKbENc3mwMZc9H
         +dD5pRaZfUjG1cECXmaLCOH56u+XL2G2hkaaN23Y5XtTPO2GfPzthi3PKXRDU4cODgq3
         /iW0I/ZIkz7oUciyQgJWiHEBayyDfMxEeBZjDnLwxC0udqg/DA60ThJt2sYZdjokIiVL
         VxUHt0y4lg7JzOUGJiL30R0XV4mdZKmQXJIVGVbQ8fXrFX4SrnXPHcdpEf7ZbiUCOuRV
         ek1w==
X-Gm-Message-State: AOJu0Yw4EDiCNKyFAU+99563SSM4ielqQxeScg6sK9ihD/LaPPX1lbDY
	oLXs8Z87I2Niz6xfjtGyT7UT0xAYharYT3brpH8fTwudSnBtJNDuxKoze+NoNcI=
X-Google-Smtp-Source: AGHT+IHv8Iv2oon4/pAefr7VSRrspM+Uy/4mCCVPMigXDwU/+OPple5+0vJd3k1xTpdbpcl05kjDoA==
X-Received: by 2002:a05:6000:1a85:b0:33b:bf2:a2f6 with SMTP id f5-20020a0560001a8500b0033b0bf2a2f6mr6873205wry.65.1707757845739;
        Mon, 12 Feb 2024 09:10:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXGOIgfTzE63pZ6poBPoQYRrQlvVwEwgtFQ+YK2UaU8T2eS9CeG28pbIHi+I8xotMsaeO3OPyIbociF8Wof2kfkAt8yGaWYrXiW8GnBLcLTes1nEb/O8IGLYN1nBklT1iq3wcHAvx+1tnr2Pc9Q1JLzlWJ1Rh9dFpkQFxnLArfd8vRKB/4/NTbNhhX6r0Y9POLcQk9ekot8P7fID8VC6HxuwC9rbaTBsAtNkJTrLRjUq5FfINzb8esuVZMr1Bn2A9hNr/e5ds93o6sOu7rexooG5O+RmrOBX8LoGrbatEmwBVaZs6KzmqnWE1XbLAgks1Y+30K5ucOskmjXwmIDMWSMDv6Fy9JuHH1YX0MAR1ezBmwiK+kFtGOw7SoH0HqxLlIPl0a2l7gTEgt965qCmQN6nWa5LQ8Y564VmHh9Zdf5A/QA9KkovdPXAkax3/TYodICl7Ag+LoL4ZOueyK5ycH3x++fgyCYqdAulRPAVv3dxlEoZvYcaFFaTedk/qkcCR49wxqJsiCZWqgR17GngaVM8tTMboj+m7IcBqRdfojq0m6kqmyaU8iE9rVLCSNwRsH2e7OA5jfxnDkSWU3IziAjPgF8ROvUvzug
Received: from ?IPV6:2a01:e0a:982:cbb0:fcee:f026:296d:135f? ([2a01:e0a:982:cbb0:fcee:f026:296d:135f])
        by smtp.gmail.com with ESMTPSA id ck13-20020a5d5e8d000000b0033b684d6d5csm7440536wrb.20.2024.02.12.09.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 09:10:45 -0800 (PST)
Message-ID: <0ccbe65c-4a68-472e-8de0-79e88691d364@linaro.org>
Date: Mon, 12 Feb 2024 18:10:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 03/20] drivers: crypto: meson: make CLK controller
 optional
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, clabbe@baylibre.com,
 herbert@gondor.apana.org.au, davem@davemloft.net, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, vadim.fedorenko@linux.dev
Cc: linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@salutedevices.com
References: <20240212135108.549755-1-avromanov@salutedevices.com>
 <20240212135108.549755-4-avromanov@salutedevices.com>
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
In-Reply-To: <20240212135108.549755-4-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/02/2024 14:50, Alexey Romanov wrote:
> Amlogic crypto IP doesn't take a clock input on some
> SoCs: AXG / A1 / S4 / G12. So make it optional.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/crypto/amlogic/amlogic-gxl-core.c | 21 ++++++++-------------
>   drivers/crypto/amlogic/amlogic-gxl.h      |  2 ++
>   2 files changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
> index 4d1b1d5b7a54..54113c524ec5 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-core.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
> @@ -250,6 +250,7 @@ static void meson_unregister_algs(struct meson_dev *mc)
>   static const struct meson_pdata meson_gxl_pdata = {
>   	.descs_reg = 0x0,
>   	.status_reg = 0x4,
> +	.need_clk = true,
>   };
>   
>   static const struct of_device_id meson_crypto_of_match_table[] = {
> @@ -285,17 +286,14 @@ static int meson_crypto_probe(struct platform_device *pdev)
>   		dev_err(&pdev->dev, "Cannot request MMIO err=%d\n", err);
>   		return err;
>   	}
> -	mc->busclk = devm_clk_get(&pdev->dev, "blkmv");
> -	if (IS_ERR(mc->busclk)) {
> -		err = PTR_ERR(mc->busclk);
> -		dev_err(&pdev->dev, "Cannot get core clock err=%d\n", err);
> -		return err;
> -	}
>   
> -	err = clk_prepare_enable(mc->busclk);
> -	if (err != 0) {
> -		dev_err(&pdev->dev, "Cannot prepare_enable busclk\n");
> -		return err;
> +	if (mc->pdata->need_clk) {
> +		mc->busclk = devm_clk_get_enabled(&pdev->dev, "blkmv");
> +		if (IS_ERR(mc->busclk)) {
> +			err = PTR_ERR(mc->busclk);
> +			dev_err(&pdev->dev, "Cannot get and enable core clock err=%d\n", err);
> +			return err;
> +		}
>   	}
>   
>   	err = meson_allocate_chanlist(mc);
> @@ -322,7 +320,6 @@ static int meson_crypto_probe(struct platform_device *pdev)
>   	meson_unregister_algs(mc);
>   error_flow:
>   	meson_free_chanlist(mc, mc->flow_cnt - 1);
> -	clk_disable_unprepare(mc->busclk);
>   	return err;
>   }
>   
> @@ -337,8 +334,6 @@ static void meson_crypto_remove(struct platform_device *pdev)
>   	meson_unregister_algs(mc);
>   
>   	meson_free_chanlist(mc, mc->flow_cnt - 1);
> -
> -	clk_disable_unprepare(mc->busclk);
>   }
>   
>   static struct platform_driver meson_crypto_driver = {
> diff --git a/drivers/crypto/amlogic/amlogic-gxl.h b/drivers/crypto/amlogic/amlogic-gxl.h
> index 9ad75da214ff..a36b9bac63a0 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl.h
> +++ b/drivers/crypto/amlogic/amlogic-gxl.h
> @@ -82,10 +82,12 @@ struct meson_flow {
>    * struct meson_pdata - SoC series dependent data.
>    * @reg_descs:	offset to descriptors register
>    * @reg_status:	offset to status register
> + * @need_clk:	clock input is needed
>    */
>   struct meson_pdata {
>   	u32 descs_reg;
>   	u32 status_reg;
> +	bool need_clk;
>   };
>   
>   /*

You may use devm_clk_get_optional_enabled() instead, bindings will ensure
clock is provided when needed.

With this you can also drop the clk_disable_unprepare() in meson_crypto_remove().

Neil


