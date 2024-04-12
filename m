Return-Path: <linux-kernel+bounces-142697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CCD8A2F14
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46F81C21293
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303BB5FB85;
	Fri, 12 Apr 2024 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MfBBk16M"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6345B209
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927591; cv=none; b=WJNt0Pw+iIXnWfqNEX5vn2wFVT67ADrtp0eodn9EWM8f2V7VdM1BslR05YZArBnOGVKqDm6whJGGNmrLiDAsmSviF8WIFP3bOYiF6Kz24JFa9FrVYMBHCKz/xb+PeB1RDAvVyO8nzhDd+dXJZAkd3XupNy1hmkFVwgbPFv1Qu+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927591; c=relaxed/simple;
	bh=p3ky+7dAO45rb/FyCr6/aqWqDoYrTnw+E6TUzd9Jsns=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kR3Ochc8jN71lmHbZD212Rv9+uIz3yOk1ZVfrU+VM6ZLlnUBcUoteto3X4g5Uj35/aI/O0P2F4IQEbBMyRyUa7yEqt/Fzby+7dqyGrbdUofAwddnbhEkAaeOHx0ms1ogqJX7yfLa1iu7Puy37wkHYxe6ZZ9RlC/VfgJTPrBooic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MfBBk16M; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d485886545so13315111fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712927588; x=1713532388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtuLBfdgT9O7IxnW5LngiuzSdf1ZJSvc18BOhG86MJk=;
        b=MfBBk16Mz3rbKb0BtAPNPYTlQUGvghti/i6Vd+OEDbY2pHbnAEgeeFv1XTr1esEucB
         QT6mc7MbI5g7E+GLSC8Gd4i2gbCxgYWrveouilopHMVvvQBdZqi/Dg7buY8jMaF6kcKV
         HFRJu/I6lF/4SbLeM3tRjwEstjEar3pYEZ3ys5WAy9FOg9M4MQNkfijILoxpdzSeli+T
         1rHUAurNO2LA9z0SiouN9ipSEOcPBzcaLOhw3i7xr+RkquxjKBXlcgoGe8HzU667+K2J
         tPPOPnDT7LZzYcQDPhcOghBx9dZ4ZnJiHCdZkAi0Vg8F+8iW0hHefW9bc3js2N7fPVvg
         zycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712927588; x=1713532388;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xtuLBfdgT9O7IxnW5LngiuzSdf1ZJSvc18BOhG86MJk=;
        b=V6gjL6DEOuMzm7ismjzPYVX1vLr8xiVOysbbYnOs1cAOZv3ZVGNg3Q/l72ss6oSGl4
         39m9DEJ0Xm5wV6HCZRgk6AqIYS26NN9cC1a3M5rlapgriQoL6vhUdNRF2iBomSzdheBr
         HcMqIGfx3VY5/wGMFrzadc2VPc02qfK1t6WQvuTRLSf2MHJ4ClaFQCDY9HHzWHuXMSTv
         f6aj4iMS2fTNWYh0gV7VJVJi5c5OcxHVRtI59K2BRLcttssRPX3bSe3SPJP03NRg5D5w
         p5+yX4Tc9Z0lleELCt2vw938e9/rO+uhzj8CPRJePeXupI+0eoKtI5DEtM6YDHIdiBrS
         DRig==
X-Forwarded-Encrypted: i=1; AJvYcCWPz9AXck2unxJvkg1YSJDWfIIAKMhqajy1yTdowhYh14c2lzQBICpU1YNAh3F0siHcEuScUD3euk9WbKA93L3y/+08U8rPrcwyBTTK
X-Gm-Message-State: AOJu0Yzzq3YvspKhUAmP8mkSVtjhWojS9jsZ+Tekl6wYk7zILVpWpM2v
	ESxWr8RK4Auc/hX9V9uECH3oRp/c+K6X0tpuB/WY5fa848kEypGXum+XaXoKfP8=
X-Google-Smtp-Source: AGHT+IHFNhjOs9W6uuEXESacXfBAgAM2gqmrbmOS0xKW8DUuzebaRbsNb1d/ydZOoh78gSJFpe63/g==
X-Received: by 2002:a05:651c:19a7:b0:2da:6b4:8b19 with SMTP id bx39-20020a05651c19a700b002da06b48b19mr1887093ljb.36.1712927587790;
        Fri, 12 Apr 2024 06:13:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:986c:54c:12ce:a121? ([2a01:e0a:982:cbb0:986c:54c:12ce:a121])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c4fc400b004170e0aff7asm8460789wmq.35.2024.04.12.06.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 06:13:07 -0700 (PDT)
Message-ID: <1a94a14d-cdcd-4764-a5f5-3224258165a6@linaro.org>
Date: Fri, 12 Apr 2024 15:13:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/3] Add support for Amlogic T7 Reset
To: kelvin.zhang@amlogic.com, Philipp Zabel <p.zabel@pengutronix.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 Zelong Dong <zelong.dong@amlogic.com>
References: <20240329-t7-reset-v1-0-4c6e2e68359e@amlogic.com>
Content-Language: en-US, fr
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
Organization: Linaro
In-Reply-To: <20240329-t7-reset-v1-0-4c6e2e68359e@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Philipp,

On 29/03/2024 10:17, Kelvin Zhang via B4 Relay wrote:
> Add a new compatible and device node for Amlogic T7 Reset.
> 
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
> ---
> Zelong Dong (3):
>        dt-bindings: reset: Add Amlogic T7 Reset Controller
>        reset: reset-meson: add support for Amlogic T7 SoC Reset Controller
>        arm64: dts: amlogic: add reset controller for Amlogic T7 SoC

If you could apply patches 1 & 2 and prepare me an immutable branch, I could
merge the DT part for v6.10.

Thanks,
Neil

> 
>   .../bindings/reset/amlogic,meson-reset.yaml        |   1 +
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi        |   7 +
>   drivers/reset/reset-meson.c                        |   6 +
>   include/dt-bindings/reset/amlogic,t7-reset.h       | 197 +++++++++++++++++++++
>   4 files changed, 211 insertions(+)
> ---
> base-commit: a6bd6c9333397f5a0e2667d4d82fef8c970108f2
> change-id: 20240329-t7-reset-f87e8346fadb
> 
> Best regards,


