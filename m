Return-Path: <linux-kernel+bounces-62054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B933F851AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE04A1C226CF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9064D9FB;
	Mon, 12 Feb 2024 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rv2JMEVp"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957FD481DE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757497; cv=none; b=j7Lj0ktH8tcOnYRj3IRB0tk9BZPbYfaITG0HjNv4Hp2fJA33/EAu6yZhk8li74wy/PRlZoSZp402zMjmme8guJ0hKYnhiYgVAN2va3XO5u89oDHePZJVWWT+WqEuRIMO+ChGimbCIbG/dAUsNAkmBl6AjBY5WkF0o/iT+y6iDYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757497; c=relaxed/simple;
	bh=NGOQEuPyRJgDWg76Dul8KF5cVzOQ1HMWLMT4O4ylqH4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=shl4ULocIVA8iNyeeB2cQfbgTF59Q3xK1CkilXXNwk4U6JJddKJJE5gSS7jiHT8SbDRQ3v7On5CYlM4jnuVwObBLr7PtZb3bLwT35pxRD7UpFJdm9w4nzPCSObPjztcSR7oe1rEiOy0TQ2u4bdWzGbZzBUny+Cwh9ym8TCN+ydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rv2JMEVp; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-410c804e933so10205235e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707757494; x=1708362294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tnlFcYYxV+8xVptqetGlSMvuarTqWvNDzjxOKjAUqOg=;
        b=rv2JMEVpeX+0qGVPyd3gvIW/tNEI+iB3akjFAJmD1n5hbfnlxKlR5+A2jS75NZcJ7A
         HjkvaX4igTvefrDsz2w+/E3//y+SQZsSXs3b7UhR3qMNJ54nxuGEL83FFJcHgQzYycAC
         zBloGuzLswcOly3LVebm6hlAuRPxPmHBl5ikcwiep4XZ0SoGf+gOXKHeOlvzMpyvPH8N
         gCOloq7+P/gO7DCOI6tcNcRC1kHkPLUCo0HUAnNIzKRrsYSx36WFJ3lq0TgzHmRdAMb0
         ftJkGV5rg5NB5tfyrMMHn4zKtAbRsYQ+90beUjFLo4WEtMlf2GIsisxAKVdfkuYhqcSA
         ePaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757494; x=1708362294;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tnlFcYYxV+8xVptqetGlSMvuarTqWvNDzjxOKjAUqOg=;
        b=vVn23pgtOz8pB07BlDWkiyxcHyrGYfs/44kQL/5UruZARbBRpWQzickhs7p6UpqesE
         8drVhgfEZWTW416C9Zdc8ZB2hIHyTojlb3V42h6O8i30gcmmhljV7A3Ai4QUgM8k2KqL
         WfgvmIKpfgRjusv93YG8TWEvS9CdkFq++WLWwC7jOt4eBqUR+vucVCR6XwX8KNdbSZfx
         zUF6VEJT9p5OUWgTq59qcIF0PNKCjkpqcWtzQHCzKw2ULATXKBQpVySnys3aJXy+81mC
         DvDUsB0uv0/cidqMbmdUf9sdllyh1wRTzvJ6o6gg8HcBq08909nbTdQYYVF6yz6pt/zI
         SGuQ==
X-Gm-Message-State: AOJu0YyKRqvQyUvS3D2NXOMlFY7EDnbdygwredWTPqzQL1buFbTAQSFS
	eAdEI6Te7bwUhl/xyiFHr+GW42+cYS3Vk6x0It08r6D4GgBp4ZAiw74vqN3JRJM=
X-Google-Smtp-Source: AGHT+IH9qGmw9nwphxghFf7cRSEenHYCVSiFyoQOsKn8U3/wxIxpBARqwzxrILU0T+G/X8nzi8kAcA==
X-Received: by 2002:a05:600c:a386:b0:410:c148:2a4b with SMTP id hn6-20020a05600ca38600b00410c1482a4bmr3682640wmb.37.1707757493845;
        Mon, 12 Feb 2024 09:04:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUbhtiBWLx71foFqG/Mrmg/AENgTBrjlVZ+U5sFZ7wJ7UWRYzAVg+dLvpvbtXgr2kTvNVY9NWwSKWheJjknZ0joEq0Syyr+s0NKjU4ZGFzscd7wgIjMLzzVo8TSarRChYloisONs/iAnOYYi8IwMqoqRg1HmesUfJy57mr62lqEGaMXXdmqm4SEkNBbVBP3KHF2qPEWvPnpDwZLfXkVvjFci4rAgCUC0/jWNIQt518bNJ9eVxKOwJD5aBvZ5DyAHP36ClLFak1a9lpNWDsrpFBnhJsO66PgohmT58dW2S+lE8LGmqQ4BcbTPuWKJOoONZH+jRCHdEqJv9MGGLk9cBKrZPFgntPZO1JZZudgkVuh5vkBfttYgGbnWIHCTnHhba1WqXFKyaVFwfyj3++DcLzgEiPDS47Rg8A0tDAovOURSg74/WAI7ZNmmKKcN4SMTmmaGP5ulJLAH/sOVfWUXtWvAU78GqvV1zb45mjwzvjg87l9gG8QZI46Ih7THA/zO4UQFjKXk6aZR4BYDzEkb+xxZDIcg5+wQDmeDOGYnIZfp0jeHRYCIgwL8Y8JU1K4GjkeX5rsEtCcR8LlXNrlzHAGtViJiLz3XdNj
Received: from ?IPV6:2a01:e0a:982:cbb0:fcee:f026:296d:135f? ([2a01:e0a:982:cbb0:fcee:f026:296d:135f])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c351000b00410e6a6403esm2462229wmq.34.2024.02.12.09.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 09:04:53 -0800 (PST)
Message-ID: <ecf86b35-a53a-4570-8ef1-377759422dcf@linaro.org>
Date: Mon, 12 Feb 2024 18:04:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 20/20] arch: arm64: dts: meson: axg: add crypto node
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
 <20240212135108.549755-21-avromanov@salutedevices.com>
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
In-Reply-To: <20240212135108.549755-21-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/02/2024 14:51, Alexey Romanov wrote:
> This patch adds a crypto node declaration. With the
> Amlogic crypto driver we can use HW implementation
> of SHA1/224/256 and AES algo.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 6d12b760b90f..b19be72abdd6 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -294,6 +294,12 @@ ethmac: ethernet@ff3f0000 {
>   			status = "disabled";
>   		};
>   
> +		crypto: crypto@ff63e000 {
> +			compatible = "amlogic,axg-crypto";
> +			reg = <0x0 0xff63e000 0x0 0x48>;
> +			interrupts = <GIC_SPI 180 IRQ_TYPE_EDGE_RISING>;
> +		};
> +
>   		pcie_phy: phy@ff644000 {
>   			compatible = "amlogic,axg-pcie-phy";
>   			reg = <0x0 0xff644000 0x0 0x1c>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

