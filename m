Return-Path: <linux-kernel+bounces-61860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA41B851781
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32DDAB24ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7220A3C07B;
	Mon, 12 Feb 2024 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uAUm4db6"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FB13C485
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750194; cv=none; b=D5wZ1tJ43NQOnTQjlXf6BStOy/uzZr8K0x2noFzSSDA/3BrmPwCzKkZbV9jOKvCsJTCbwbPWXQ11n45mmOLnza8BMFFTv+Q9OaatEcOxTfefRxKykJVq/PnxEFOWZJPfuy2bymMsJdsnAXyIMj4gw78PAf7tX0W9Pi6oiHpdIfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750194; c=relaxed/simple;
	bh=zteHufWKoOYQiROn70WGZVZpD1rgaCYmF5LeK+1zGqs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=lt3ceJlTJsJuaRSA+uhDWDtsl3Sm0uVvS3Tuez0wsube0R+neqJLCodU51R0p0XcHH/soJ6JFWxbK73oSt5QeddBKuk/86SBjawfnjAh4qp5lJKXqAt+On7P+/0/pIAXyHkRY5thxM5Idyx7tuNg3ANkHKyLXm43F2IYFO3j0HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uAUm4db6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-411ab6dbcb5so340275e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 07:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707750191; x=1708354991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gGTRmgzCEblYT2wFMD0YKSqg8Cojz0DyNkeKTFhBxkE=;
        b=uAUm4db6Xgb1NtNqAnVSY2CX2to1Mek+zN6JSdMWh6b/FOctujBhqKowiadokmdu3V
         cLDWQRRyR8KCrhchMCiGbyHJ3xXYTU8jERbeZ/6T3V2NXgAMiIj2SIqB9lxjLTpEoymi
         F2Z1dkl9CflmleouJ0kCfoLhgVSP+u+Qd+1NCnhvB7+Vs5uI28dHlovETPtIJ3QdRBJ2
         sK90kx9Se7/RHSYPx19sAEyeE2S4R5k5olRFLXY3g+CSW4A8cEllbO4TFZubIvQiHcKh
         Gi3SzRvmATWKvts/taf8BXBpKgnMXdjxpl0Dfw44a4WA4i0eD1s9xnOR4Ix2ljXg1n31
         /GAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707750191; x=1708354991;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gGTRmgzCEblYT2wFMD0YKSqg8Cojz0DyNkeKTFhBxkE=;
        b=UVN8x+W6DKepTM2ht/zwJbxd3s6/lOnyCwc9j5hWnKKFC5vtlvsrHWywAlSnlMiHhP
         7nIC4GQSK5fbI83vnXAKNCLXcqMdC+G4giJcOdleE173E1pTm8h82jdEajsivs3iOegA
         b5NKOFsbyYUG7XhOjuVb7a6WebYmlkpZFreayT89hB0zfeD68Yh4u8Sot0g01lR1nomu
         6tjGJXSVzPne20Slucpb1ki8nbi9DGgmAV8GqmBek8UMS5eEK7QqGjUqsgtMxkJnvrSr
         VqdXWGD/oy5DSPnjt7Qyftsq+PYPPhLVAC0IcBDyFPtn1JAGeLJonqvAEHy4/GoR31L1
         z/PA==
X-Gm-Message-State: AOJu0YzeYd/627ecPfz1V1pOLq9zxWLDP4Vy9zsUU1MAOm8/RKN1AtxV
	VPXAtt2AyHfEE6jDXPxlDsJ8TUThN42z8aTUcKUfeUYC7dp2+RfdUq22Z18CrcA=
X-Google-Smtp-Source: AGHT+IHA1UCG/ZKTQDxhTv2/ZdMRnGA0SzA/uhQLD1cvW016suIRlCYJ8WpJt/Uw8yYV9wQ+hTL9zg==
X-Received: by 2002:a05:600c:3553:b0:410:e1c0:7f9f with SMTP id i19-20020a05600c355300b00410e1c07f9fmr1844057wmq.13.1707750191345;
        Mon, 12 Feb 2024 07:03:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqbUhdjeRd3+eDi82KiEJfyaTc1NlRHfTeXx8eqck9pPTwemYnPemYwHGjho4Rint6aXa4gIteX27NSVmPjHBFuGGUfKA9H37ouOp8SmyFErLvoxbwKQghhVechkKnY9ZJRvtw3PEmlmLUJYf7XA+3Q1BY/Y6g6HNy0R2RDGkRTH6EBct57NsHbSopYPl4b95fTr3Ly7EgyXxeyaiJtl5pT1HgFG/sa0kvNImXYMp6edRe4koYUKj1GmpCKPAPowyfM838AAyFn8lJVhZFWiqINOk7omFPTbBQ+fhkmksoROJMzPRSISvtq3YAPOMsp5iparQCdWfJp3vKJq63HXuRAmkkCrMobW4t3+F1Ea8nhSL83cnoG+8JbKFncPOnOwr3FPQyDjW1
Received: from ?IPV6:2a01:e0a:982:cbb0:fcee:f026:296d:135f? ([2a01:e0a:982:cbb0:fcee:f026:296d:135f])
        by smtp.gmail.com with ESMTPSA id fm8-20020a05600c0c0800b0040ef718cf81sm9146044wmb.28.2024.02.12.07.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 07:03:11 -0800 (PST)
Message-ID: <7aade7aa-68eb-4585-94c1-6bec11ff296d@linaro.org>
Date: Mon, 12 Feb 2024 16:03:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: amlogic: t7: minor whitespace cleanup
Content-Language: en-US, fr
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240208105252.128940-1-krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20240208105252.128940-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/02/2024 11:52, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space before '{'
> character.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> index a03c7667d2b6..ad1cac42e9d8 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> @@ -54,7 +54,7 @@ cpu100: cpu@100 {
>   			enable-method = "psci";
>   		};
>   
> -		cpu101: cpu@101{
> +		cpu101: cpu@101 {
>   			device_type = "cpu";
>   			compatible = "arm,cortex-a53";
>   			reg = <0x0 0x101>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

