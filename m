Return-Path: <linux-kernel+bounces-36683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2F683A4F6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278D51F22E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A4417BD9;
	Wed, 24 Jan 2024 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uiax9v3Q"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D653D17BC5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087624; cv=none; b=WQKVUPbXghRoDEggnTb68YuV4a8Qbn57SIIJSH9nz9H2QOuyn1BZ/nkC++KEz6p1uTlW52X6P43y2+SKH5t5OuaWZrtLTCX62gxymBdGIdfEGjNG0bn7ME5gtFjnFvSoF1Fen0aIyXMHQzY6lt3L5Q0ONMLkOqiGGCq8ly0ZgAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087624; c=relaxed/simple;
	bh=uxEEQtkZ4BRVlpQbFUGBbFwTBUmJAeCEsEOm8tdKsXA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JixNTXKA2vAwRnaEDBB7HLbzwIXjcOWk0wzufo+1gC9BxSop2J35JWh53eIdIwO4kTgZBaN13Zma/o66XlfwPRotClVfr0yQfkV21b4l1rO1P7ZD+VM9muoeffrGn+FYfMr7+wxS87cx861kdjUeLzrlivKi36Vz5pdhktfcZLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uiax9v3Q; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-337b8da1f49so4645015f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 01:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706087621; x=1706692421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fGaFNTm0rKDhMzJZfCGf3yauwaFWWjKUfBj6ngaz/vY=;
        b=uiax9v3QUpxGCcCFHqNJxdBmDJSULnueiqMFYSOH24446QwFTppg8AE20dzNQ2cojv
         AgJBHNIdJhzIbh677ZWyW8Q3F/ZJvWDO0HN3+mYla+ouQFl3KhwsfVvBYCRYBFtUHMFM
         hUWX0vyE7EE5u0UYiRaOg9Gyk4WdGx9iLLc/bv5VyoRcNns1ZuQW0ielL0QpfGzx/ZzB
         mw2HvfqwPkewXHhEh9qKHvCisADbA+0nJizS3IrhTN3iKsB6m7OaFlzghQZk0ofXriBL
         fctHl5VFrz4NDFjngRDwKcyodssj9rxUlViLs8Funf4cZ/O2aX1/9IgXuZAkMJtwG6rw
         8ooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706087621; x=1706692421;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fGaFNTm0rKDhMzJZfCGf3yauwaFWWjKUfBj6ngaz/vY=;
        b=kw5wiq8tl8oP+9wZPWLvS87owpn8aHuIg2XXE/Xb4Bx6OmEOuYI9lg6Xh6pLNzvhT6
         K4k+Lcj4eUwmyJESzxJKWVhTRH3dm14gDcEl6NIlHaAzEMgWVrrbn5oy+eXFO6z5RSWZ
         tk9Om58Ji8Xc+thHo0VDYwdNvGuROUox6H8qhoAG6i9w3mkxARmA0cZpUU0mzlZraJOT
         nHu6vcpeeqtpaHIzVs2l4W7W40Y8/Xdcb1fGyppaUAlieuJckG5rNXSA+PX6PGI7Bd/q
         qWvsQxVFUTMGgHwxfxBdcCqIQ0wMOc4Ll5TMvZCrFaUMZu44zq955p8+LntqFNVhqd/L
         m8Eg==
X-Gm-Message-State: AOJu0YyYxPAswyD+73W23xlyWj2sPXt7o31qY1sHH4YyaJ9pEeUcsymm
	LUsOR1Dsiw+B4PXWpn5BePzDbxD+NUmPKnGshQT/PWnJ+757gw57MRnV0xqwmL4=
X-Google-Smtp-Source: AGHT+IGb3UlcnEsZFUqNVOVjeSwNjuzYXVL9pU/Vo6NgRusnbHMDF8VTnpV/xhK9NafXCoXsbiaQeQ==
X-Received: by 2002:a5d:49c7:0:b0:337:c829:9838 with SMTP id t7-20020a5d49c7000000b00337c8299838mr207429wrs.69.1706087621095;
        Wed, 24 Jan 2024 01:13:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:fd4f:fd82:e4fb:1654? ([2a01:e0a:982:cbb0:fd4f:fd82:e4fb:1654])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d6341000000b0033930b9a2b1sm8329301wrw.26.2024.01.24.01.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 01:13:40 -0800 (PST)
Message-ID: <5f54f139-7710-4276-b31c-3b6cfa319f16@linaro.org>
Date: Wed, 24 Jan 2024 10:13:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 00/20] Support more Amlogic SoC families in crypto
 driver
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, clabbe@baylibre.com,
 herbert@gondor.apana.org.au, davem@davemloft.net, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com
Cc: linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@salutedevices.com
References: <20240123165831.970023-1-avromanov@salutedevices.com>
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
In-Reply-To: <20240123165831.970023-1-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 23/01/2024 17:58, Alexey Romanov wrote:
> Hello!
> 
> This patchset expand the funcionality of the Amlogic
> crypto driver by adding support for more SoC families:
> AXG, G12A, G12B, SM1, A1, S4.
> 
> Also specify and enable crypto node in device tree
> for reference Amlogic devices.
> 
> Tested on AXG, G12A/B, SM1, A1 and S4 devices via
> custom tests and trcypt module.

Please describe which tests you ran for next version.

Neil

> 
> ---
> 
> Changes V1 -> V2:
> 
> - Rebased over linux-next.
> - Adjusted device tree bindings description.
> - A1 and S4 dts use their own compatible, which is a G12 fallback.

This is not what I meant by fallback, I was meaning having:
compatible = "amlogic,a1-crypto", "amlogic,g12a-crypto";

and them only add "amlogic,g12a-crypto" in the driver.

Same for S4.

Neil

> 
> V1: https://lore.kernel.org/all/20240110201216.18016-1-avromanov@salutedevices.com/
> 
> Alexey Romanov (20):
>    drivers: crypto: meson: don't hardcode IRQ count
>    drivers: crypto: meson: make CLK controller optional
>    drviers: crypto: meson: add platform data
>    drivers: crypto: meson: add MMIO helpers
>    drivers: crypto: meson: move get_engine_number()
>    drivers: crypto: meson: drop status field from meson_flow
>    drivers: crypto: meson: move algs definition and cipher API to
>      cipher.c
>    drivers: crypto: meson: cleanup defines
>    drivers: crypto: meson: process more than MAXDESCS descriptors
>    drivers: crypto: meson: avoid kzalloc in engine thread
>    drivers: crypto: meson: introduce hasher
>    drivers: crypto: meson: add support for AES-CTR
>    drivers: crypto: meson: use fallback for 192-bit keys
>    drivers: crypto: meson: add support for G12-series
>    drivers: crypto: meson: add support for AXG-series
>    dt-bindings: crypto: meson: add new compatibles
>    arch: arm64: dts: meson: a1: add crypto node
>    arch: arm64: dts: meson: s4: add crypto node
>    arch: arm64: dts: meson: g12: add crypto node
>    arch: arm64: dts: meson: axg: add crypto node
> 
>   .../bindings/crypto/amlogic,gxl-crypto.yaml   |  31 +-
>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |   7 +
>   arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |   6 +
>   .../boot/dts/amlogic/meson-g12-common.dtsi    |   6 +
>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi     |   6 +
>   drivers/crypto/amlogic/Makefile               |   2 +-
>   drivers/crypto/amlogic/amlogic-gxl-cipher.c   | 602 ++++++++++++------
>   drivers/crypto/amlogic/amlogic-gxl-core.c     | 281 ++++----
>   drivers/crypto/amlogic/amlogic-gxl-hasher.c   | 452 +++++++++++++
>   drivers/crypto/amlogic/amlogic-gxl.h          | 115 +++-
>   10 files changed, 1165 insertions(+), 343 deletions(-)
>   create mode 100644 drivers/crypto/amlogic/amlogic-gxl-hasher.c
> 


