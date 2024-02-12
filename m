Return-Path: <linux-kernel+bounces-62039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F9D851AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED0B1C20DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9653F9FD;
	Mon, 12 Feb 2024 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uby9yQAG"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4B23F9E1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757485; cv=none; b=MrS0iSC1+o73H8kf2XjRnxJP0IfudS0z5/YaBRynItk6vuazsP6eIaG8NDImfS4ePanfT8B0n8OCalSM2IB7Clrs81aKxiejSnouaojbsd18ruy53KnHX6U4xmcBi8aIL+JN6iMKGQ8VQ6DXvWF06CvdF2YT2pJvDKqPxqXvqJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757485; c=relaxed/simple;
	bh=BbEdsxK7XSRfrCAiFcFzzaZA/8aILFJ60H9jEaxWpZo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aeYYDVduTGLRJpW+tYDZ/pYJ7GstQofW8fKbNH1CgjgaNnVPBhnFh/8SlGg8c2X1KKOTOr7htRCbcBHG3N4+VN8sqOnAseeGIL9swDDhTHf0GddJa69Q7pIgLAbBoBZBbqqoKFu0ZFI1SHVhoy9YgU2GyeSnMeLZk95I0dmloUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uby9yQAG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3394b892691so2282332f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707757482; x=1708362282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bY+FezK6qfZor6Fgr7NiCYHO1vkYOiYYWeDX1ETBgvU=;
        b=uby9yQAGHCBXayVq1tKLlmtQuSFnGmMsXhlOCTQtxT4zFxgPXqHDX9ShMSaxAqfbDN
         ZKVQuzoopRc2quD03ZRzWuH5vFMJqZKRUxDq8L5vc7UbJdhz36Sb42eGwAZDD3myBVka
         vdykwfAYuVzSdsXKexAZQox0pGT7egr/63LOdlbm49e7cYqrA1bKZnOhtaUcU7OesNN3
         oWMG37ZXu6wXshUdb/r5FWvKHjbWYs+6ZvuL6fQp9HsqoaYTSqQTXDXx14CRVV2/0Wi6
         qrwqHySEG705OfYnaYfFD43gu9f+ScagPqpeD5KhWKllgKSqZysRS/fW7k+tK5XHFySY
         Y3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757482; x=1708362282;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bY+FezK6qfZor6Fgr7NiCYHO1vkYOiYYWeDX1ETBgvU=;
        b=qEMLyMFqRAi2os52I32uxNuWJRbkSxO4UR2EwFeRQUMy/mfxeCRDGHrdZ1x/H+AczY
         9PNq0/fkZLfyLmk8kyFDjfe9avro5lSHJ2j67pOtES07QYeOY7yQE/TC0qmURy/xYKCe
         j/0XTLH8WIFoVWqUmzd0vyfCGwETq8+Vgi7eKJypTdJg9ldpRTDjIZ36Cs1h0G1M/2AV
         D90GP/JS2OKZlf1es2oaxNYPyqspzeBfZMIxz3JWx1EGTnTHrZlh7eOF/XzvZGRYTtRk
         mHj7leiwl4stF8IyYiogbH7kLoD2rFWnMMJAjFxDR+cwgPmxETQ3FeIB2X6z0N8XsyGC
         SArg==
X-Gm-Message-State: AOJu0YxSkubOS818U+CfdnUnZAgiDfB4O2QkLLKY0jokRIq5w8Qh871N
	dgnyZ2ee1GxI9tKqlnWgHFx0VKu6g1y62rE5Qlhkt2xs+hou7+0nWI5Q808fYn8=
X-Google-Smtp-Source: AGHT+IH917SO5FmEX3J35E6xRhi+8kOsae4nQDGp7E5RuPWECrPya44xdXwKllEUNrt5OEkqyOkvuw==
X-Received: by 2002:a5d:4683:0:b0:33b:5979:8fd5 with SMTP id u3-20020a5d4683000000b0033b59798fd5mr94653wrq.15.1707757481779;
        Mon, 12 Feb 2024 09:04:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUrJEP0LYpi7JlYkopZBWm45VVZPsm7mXjm0XbJQIm3CiOLr6k8PXLU6cxtWR1X6GfR3oFWsS42pF9Uoea/WSI6Vm6jqZiH4YRhstN72JTpi61GS7Tsw2fyi3iqiU4DGYr1PuxWXnjvlyFUh847D07ydpbGA+3MXTntQQbeazOrOLNVtR4LENSJ1X18Krfnakm1a+50Icv3P06ZI3+o2CrsCJ5TniXBU/Dp8m83u0PKYnntfv+UEBzP/fNgeKHsTFKlWU0V6r9mqHzW5qxFmj7RAm02G5eHuEXMq8qlpUW0OiuzTiz26cywDzkBsh44STfame2HLIWuceTGOphLkRRMLR91CosMksbfPZZmPpGV13CQm9Zuv8qDe7eVGfYoTD+yWh86dSN9Yxg4UgMIXn6sM5c9sj5BNf9OjH2S0CS+FmZKI0gC5U/9Zzl85c/AFqWjYGm1P0AdUU7lO86kce3/LI0+YkEDldUXBfYtE7ieSmBjEmcnds00YiitwUIoP6GqP11UIgtn2w4/IqPIMF0lv83ntnIGUwJ6lwZu6jX3kKhOzSMxSU6kQNdri2khZn+1IBBEShNaFLw5ObiHU47eyLFt6SvW9nGh
Received: from ?IPV6:2a01:e0a:982:cbb0:fcee:f026:296d:135f? ([2a01:e0a:982:cbb0:fcee:f026:296d:135f])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c351000b00410e6a6403esm2462229wmq.34.2024.02.12.09.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 09:04:41 -0800 (PST)
Message-ID: <e490c717-338e-4b43-a9b2-17d5358c4dd1@linaro.org>
Date: Mon, 12 Feb 2024 18:04:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 18/20] arch: arm64: dts: meson: s4: add crypto node
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
 <20240212135108.549755-19-avromanov@salutedevices.com>
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
In-Reply-To: <20240212135108.549755-19-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/02/2024 14:51, Alexey Romanov wrote:
> This patch adds a crypto node declaration for Amlogic S4-series.
> With the Amlogic crypto driver we can use HW implementation
> of SHA1/224/256 and AES algo.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> index ce90b35686a2..dc05e2c5da3b 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> @@ -339,6 +339,12 @@ mux {
>   
>   			};
>   
> +			crypto: crypto@440400 {
> +				compatible = "amlogic,s4-crypto", "amlogic,g12a-crypto";
> +				reg = <0x0 0x440400 0x0 0x48>;
> +				interrupts = <GIC_SPI 24 IRQ_TYPE_EDGE_RISING>;
> +			};
> +
>   			gpio_intc: interrupt-controller@4080 {
>   				compatible = "amlogic,meson-s4-gpio-intc",
>   					     "amlogic,meson-gpio-intc";

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

