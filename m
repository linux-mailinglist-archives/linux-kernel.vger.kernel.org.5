Return-Path: <linux-kernel+bounces-80747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42056866BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4791C22E66
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614FA1CA8A;
	Mon, 26 Feb 2024 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LAvxh/NO"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2BD1CA83
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935631; cv=none; b=nVMTxjlcJWNwmFZCjyIcpbwKVQa8cHNBcO13FkAOnmv4YW7aLxxQog9d3oV//iyCHkreQIW+3suZez/eN6JU5IYzaV3EdO/K/H2rZ4iVMygrn0TDAIaEHCkh9KO93B2luUuQPps4tMJBwEmL1fPve3IF/LvVfhZi5iOML123zt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935631; c=relaxed/simple;
	bh=rda25I74d0cyzEa3A25w37ff+HES+JQrWdLDCDoLpug=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=Pkd0gmBpDouOnIz2Okrte1kkGKksDJNL2hfoFufCPJ+aLLJpSZ2uKbMFTZasfEXgok8KZKK4ZCCfB8qV2BuWtUuNNz3PWSp1JjbymKlpxQtnfHewjcu/y+kF/BgznQZoc3oVsMV4hczeHC7e16Wx2ZRY/jNth52HAgqTRTxejIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LAvxh/NO; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d22fa5c822so40730321fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 00:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708935628; x=1709540428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7X/qTLWbPKPd/JiUEePzNNSXCZV2RpnxgxvQjOuEvCY=;
        b=LAvxh/NOmkruNex4cpMeAw70QuxMlpdubsA5V3hA9n5x7GOVMJnXfsD32IeHoGSv+Z
         P++6e/5vkaDjfMnZ+kB162IvA0QO8JnfQy28mLmNpmJCALD349JHmTl54eFwAcPgYIkw
         0lPMd88EV856aqpcttb8giWgHtwHdbnXKTB15jgrqTTjvPPGnd23EhZ4ypqt39Fj38yC
         tX2DiroQhgdF/CvggK6lkZNgjX5WXW7vbponoSVYy8xzop8GxM6vOt0Pu3Suc0hQuJc0
         cEIrxKA4OkOft/7ZBb9ayCCXUKiiCd4mdLFn4rMp0zogG5jOqskG4fAoyMbXTTMI3qtj
         KNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708935628; x=1709540428;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7X/qTLWbPKPd/JiUEePzNNSXCZV2RpnxgxvQjOuEvCY=;
        b=ZmhHR58fUebFbE+GjwrJbw7IDlVYhKqJLjcuMIhnxZlJkLVgwNj4gIJMSmod1Y+RPF
         6MGlMZwkaYMvX8MZKupFVaoz3QBvfINjuTLbXPMOTjeomq72MoUoB8plQmUi5rp6GETp
         dK5jFJ7G8mEn5Wiu9Kbkz3O8ndYdOzU+sJojc9E2Am6AHTH83naOMfRlr1MKdfbuxPeN
         qyk7e42ngGz+9f5708NHhhhS9jSoXhdccN63ULjdA3MsQqZ4SyNZiuHyqOBYkR8wDUAI
         XBjvqQD0DrFsUaBc0zFsD/4mcVOOIPeJTD/+hbik4DExveigbUVFdZy66sPomjLoQomm
         AajA==
X-Forwarded-Encrypted: i=1; AJvYcCWtgKilF2/cYs413ElXF3eB1VR7DVgKU3d11DRmt6GFAyST2SGHNUxtLGZ+LeSyyxMVuiGUJtzFS/4bK7iLKCDQoMupIBehtxLGOege
X-Gm-Message-State: AOJu0YyTsDBb7G6mRPN0fLlFpukO0U0LvpXdYoZ4EcBRxXUDrhPSFx7/
	HzISJQhTvnImxgWLNB3K/XVJqdyzTzxsmtDH17/fBpWwLLu4bNVHmFqRCDMC5HM=
X-Google-Smtp-Source: AGHT+IG9QcEM3HJrnvTNIfRhHpLmlDOTNhe4OLoEc9FT9CEH84AmgKuofVTjDOdF9TjKJLwzZybwbw==
X-Received: by 2002:a05:6512:928:b0:512:a980:719f with SMTP id f8-20020a056512092800b00512a980719fmr3375500lft.69.1708935627817;
        Mon, 26 Feb 2024 00:20:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:6109:4c61:11d9:ed64? ([2a01:e0a:982:cbb0:6109:4c61:11d9:ed64])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c249300b00411e1574f7fsm10999475wms.44.2024.02.26.00.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 00:20:27 -0800 (PST)
Message-ID: <7d9221e0-8165-422b-abbb-e1566a7a733e@linaro.org>
Date: Mon, 26 Feb 2024 09:20:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: amlogic: remove unstable remark
Content-Language: en-US, fr
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>
References: <20240224084030.5867-1-krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20240224084030.5867-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+ linux-amlogic@lists.infradead.org

On 24/02/2024 09:40, Krzysztof Kozlowski wrote:
> Amlogic bindings were marked as work-in-progress / unstable in 2017 in
> commit 7e8634e821e1 ("dt-bindings: amlogic: add unstable statement").
> Almost seven years is enough, so drop the "unstable" remark and expect
> usual ABI rules.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   Documentation/devicetree/bindings/arm/amlogic.yaml | 11 -----------
>   1 file changed, 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
> index ce0ea36de0c0..edbc21159588 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic.yaml
> +++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
> @@ -9,17 +9,6 @@ title: Amlogic SoC based Platforms
>   maintainers:
>     - Kevin Hilman <khilman@baylibre.com>
>   
> -description: |+
> -  Work in progress statement:
> -
> -  Device tree files and bindings applying to Amlogic SoCs and boards are
> -  considered "unstable". Any Amlogic device tree binding may change at
> -  any time. Be sure to use a device tree binary and a kernel image
> -  generated from the same source tree.
> -
> -  Please refer to Documentation/devicetree/bindings/ABI.rst for a definition of a
> -  stable binding/ABI.
> -
>   properties:
>     $nodename:
>       const: '/'

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

