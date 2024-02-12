Return-Path: <linux-kernel+bounces-62037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47339851AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F512850E9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ACA3DB81;
	Mon, 12 Feb 2024 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MhipbDlV"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0154A3EA8A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757473; cv=none; b=pVRH8urwoTjcg9r2CrgDOuENwDYbNXDvrNWbTIIhHY427Kt5fWCKVn8TR+KMtA9hYkiZCK1FMTZjpTRZ3FjHdodhzgv12Y3DwaqOzUOoJdqlK7Ph0qOiX5fILzm2aSnbpc8BS3GO0AIfXMzIyTXwSztWJUHU23dQE21LlUn6kB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757473; c=relaxed/simple;
	bh=U0IjrUj3hP5ej0fN7cVm31FUQvJxef3o9BaoZuCmQH4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bU15af2QeQD9UbBT71zbCDadoy0kNDKtYMz6o5tXst6Vdf02OG1AuuT8atfoHMXSSB95xxXNSzNM36e6bAVB3HPB22N195KVewQe1h7oziAq2gyulw5faAcHvLtGJCo4rYxzIv5JYcJIwNYM4cHO9/DSXNaAy26pS3/P7V/LkmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MhipbDlV; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51182f8590bso2305214e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707757470; x=1708362270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UpVBBewFGDwGECMyf6BaQS8jCWBfVHOl54L6nH1QITE=;
        b=MhipbDlVyFnBVkQSxd2lwsXyWRwBeny9CdUu7zLzSLLUTRNZdrgtogvwg1Y9RfJK6J
         cUR7BYjDBHEz/cQUSGNBQOjb434uHOGDjMwx8P0beJMIF7gqbNCjQllf7pdAWMjJCgQZ
         q7f8aGzlDTLdazk3g9uEZQ90MQxkbjV8IQHGOUps5yV7OcUysjz9eH3t+kPgxTLw40E5
         kwTgELZsY24p8XnzuOQ5Sny9lMqgizyJq5b9CFHQk30qzAQ2UorD3nTMvpebVUwGeBma
         0R7GOxd0eNna0hWWH+e+YIngKbiEYt6PvwlQU1Lk95yw9gfrbg/Rr8WbqNZDW80LdHMA
         D9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757470; x=1708362270;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UpVBBewFGDwGECMyf6BaQS8jCWBfVHOl54L6nH1QITE=;
        b=lEDyz63UiS2qLBbQVbI/aoPlD8bEppgIVNXLuTjJ6jpRT3NF3I44Oq8wafZxKh7Gxp
         OxceFPaxJwkokJcd0dfa2Gz35z6orL+Cjo6uMDBUiBkX9aGGJz7rSsdRyRDmJs1UE7P2
         t4FOnhTbj3Cg3P+0x3BSD+6VCB5Lv3A9YM4SmiVXMQQmusKxtFGYdWeGNC2/XftEGhcF
         i3XhpMLTTdCwqkpQhf0WfH8eWN/gcZYd74DV3djnS+MQpvtWlKcpbEUNnD7bVvdoUX5w
         +FRllt/KJzwiWTzs2udM8QXCZ0q+jG4wvFhmW+bqbneRpp1gExXeqaxWWSjc79+rigOp
         LWLw==
X-Forwarded-Encrypted: i=1; AJvYcCU26T7BgSZvd/7ycqk8yYYJ1yD9w+FpFl/hLuh80sBA4Ravl7pMzRDRBSf4H04IabhLA2+t6sXqPDmbmK7vkq7BflmuOOM354OObuT/
X-Gm-Message-State: AOJu0YzHUyodHYWozTqctY92u2NQoz4astSXZ2Hl280Yk1eh3Ko8HZc0
	P4GYVGJy//JaGTvDVy8zMxJBOCvAmbkLE1DOyeIKKWl8EqPU+lBYxH1rIgUZPJM=
X-Google-Smtp-Source: AGHT+IGlghCkGSZTmo15kiwjITVtJrGjlps+XopVZRYEn4/YxL/osIRuW77BmDM+FKpARmsxQAYtsw==
X-Received: by 2002:a05:6512:238b:b0:511:5e79:87bc with SMTP id c11-20020a056512238b00b005115e7987bcmr5203859lfv.64.1707757469763;
        Mon, 12 Feb 2024 09:04:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCePMc5ao1q2hliW7LqNDgMrdc0qpPSK+w/9j3cXxQRj2atj19TVtvTbtRPTmecwP0Zqt2RdUC+isVTF3PNCM/8V9/MPLIYCpUVC6e9yHArEcySV05aC5lJbngcTTzwyiR5XwP3KFTOW7W5nh3jrIiGA4MY08u508tpkOet5ONUOI+GgJIR0yqEZOs+T1CZGsbZg96KfZht6vKpT2sMOcsxRWMsfMlGp4P78ILJcKjk7nQTNG5oE1Cvx8mgA2q8MrVqeatZrSg0RR6dVVJFSmN3HeOtKsJvSevQmDTLgtfNnv1qH/sFrZxmHBMv02OmombzYcpub0oTLR5cWcjLRZxFJhXvNU6+FS85J6XtRtbErJenguRJzb9wKdcPwH5wxnN3k1LhifpEeiy0+sc8Uw20WNtbNsWCJw+R/W+iEZy2VFQTbkdFyzU/GToGfVRKyY6hO5QY6xCWI7iNqlKuMRyKEI+nzwAZ9TGnh5ypk+psaVRXLf7DgywkBM8RaxjdD27ug3/96SUisRMiZJjJKjWyIPtsTMWGy7fba+BbaCVXCaDluEP267WppMiVe8HXKGI78G4Q/Pyf+DacbfcjneeXVV/o+ZduGn4
Received: from ?IPV6:2a01:e0a:982:cbb0:fcee:f026:296d:135f? ([2a01:e0a:982:cbb0:fcee:f026:296d:135f])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c351000b00410e6a6403esm2462229wmq.34.2024.02.12.09.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 09:04:29 -0800 (PST)
Message-ID: <6e7c9f54-1a75-46fd-867b-ce952417a903@linaro.org>
Date: Mon, 12 Feb 2024 18:04:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 00/20] Support more Amlogic SoC families in crypto
 driver
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
In-Reply-To: <20240212135108.549755-1-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 12/02/2024 14:50, Alexey Romanov wrote:
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
> custom tests [1] and tcrypt module.
> 
> ---
> 
> Changes V1 -> V2 [2]:
> 
> - Rebased over linux-next.
> - Adjusted device tree bindings description.
> - A1 and S4 dts use their own compatible, which is a G12 fallback.
> 
> Changes V2 -> V3 [3]:
> 
> - Fix errors in dt-bindings and device tree.
> - Add new field in platform data, which determines
> whether clock controller should be used for crypto IP.
> - Place back MODULE_DEVICE_TABLE.
> - Correct commit messages.
> 
> Changes V3 -> V4 [4]:
> 
> - Update dt-bindings as per Krzysztof Kozlowski comments.
> - Fix bisection: get rid of compiler errors in some patches.
> 
> Links:
>    - [1] https://gist.github.com/mRrvz/3fb8943a7487ab7b943ec140706995e7
>    - [2] https://lore.kernel.org/all/20240110201216.18016-1-avromanov@salutedevices.com/
>    - [3] https://lore.kernel.org/all/20240123165831.970023-1-avromanov@salutedevices.com/
>    - [4] https://lore.kernel.org/all/20240205155521.1795552-1-avromanov@salutedevices.com/
> 
> Alexey Romanov (20):
>    drivers: crypto: meson: don't hardcode IRQ count
>    drviers: crypto: meson: add platform data
>    drivers: crypto: meson: make CLK controller optional
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
>    dt-bindings: crypto: meson: support new SoC's
>    arch: arm64: dts: meson: a1: add crypto node
>    arch: arm64: dts: meson: s4: add crypto node
>    arch: arm64: dts: meson: g12: add crypto node
>    arch: arm64: dts: meson: axg: add crypto node
> 
>   .../bindings/crypto/amlogic,gxl-crypto.yaml   |  43 +-
>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |   7 +
>   arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |   6 +
>   .../boot/dts/amlogic/meson-g12-common.dtsi    |   6 +
>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi     |   6 +
>   drivers/crypto/amlogic/Makefile               |   2 +-
>   drivers/crypto/amlogic/amlogic-gxl-cipher.c   | 602 ++++++++++++------
>   drivers/crypto/amlogic/amlogic-gxl-core.c     | 290 +++++----
>   drivers/crypto/amlogic/amlogic-gxl-hasher.c   | 452 +++++++++++++
>   drivers/crypto/amlogic/amlogic-gxl.h          | 117 +++-
>   10 files changed, 1183 insertions(+), 348 deletions(-)
>   create mode 100644 drivers/crypto/amlogic/amlogic-gxl-hasher.c
> 

The overall looks fine, I'll wait for further comments on the code,
but the DT looks ok and I didn't find any issues code building
or DT bindings check.

Neil

