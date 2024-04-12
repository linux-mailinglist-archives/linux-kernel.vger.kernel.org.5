Return-Path: <linux-kernel+bounces-142682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED788A2ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164C8285687
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128085B694;
	Fri, 12 Apr 2024 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yIjE59sR"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE3656443
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927124; cv=none; b=TKt+ZIFb2d4noodlvEwLIvCLsRLiKhp652nA1hw6bQdJcijXPR0wJZ1JOP0lOY5Idjy2TK7KJIL7Hu6K4528zAH+2r477rm2karbIrV88H/flP+2MjpKvYIAKvbvdQfW0Np6is6MAXD9FHltLHOs4/my03zL0sE9+3chuTlbwGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927124; c=relaxed/simple;
	bh=wiFlkB+eE3v2d6qF88dWKYMFmze3O8S+7MdMRMGoClE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KOFnak+//4Raq21x/9ZjW2sZQkSaafSf75VPtehZ2k2esSbB7ltF/uy0XewPVd7WpogBQ4Syuow//58dOBLodqSwyr4xakj/aju3VHDuyxKL3KpMwiSyO4u7BITkTNPs0/HLoNN48F4QLSrxH8b1ssCyegzdm91W/k9AL/O8XqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yIjE59sR; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3442f4e098bso1101250f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712927118; x=1713531918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xOcTNt5ByY5dfitA7rAX7DzfF2K3DjcIDFUSulbTkvM=;
        b=yIjE59sRcyldxdw1rtqAycp4aMOvHaTXkhM0gSfDC3W/41Gb2WrydtGgAQJmKLgKt8
         3Ykv6EFHIazKGTHpfjSaxbvzBPEjzO6l1UGV2Hiih2z1aJb/k7LTnRjjo9Yh4Xo++juN
         UwzswAfI05+GVHXxfVRAYilswmRqDzzjzPF8GdYAD4DSj4ChKKqkZ6V0mPdJDr29eNwE
         QZecqgzWBxxy7OzwMKwgtE4ygtRAbotxVkG74nEtd1hcOvCgcADHcF5kN+pTBPtNF6QI
         fq/gEbCv0t76wuqQn+vZrG2lX3lkXfy1BgNY+zKEjjU7zw3tubtSwK32n7/ngjuLerPF
         pNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712927118; x=1713531918;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xOcTNt5ByY5dfitA7rAX7DzfF2K3DjcIDFUSulbTkvM=;
        b=SD7w84/xBckG8xMD7aLJspZzHWndEBKtAVyJie2afvzArqDCFGXtT8IPY2lCFSWVvD
         k+egQO39tzRclYja3+A2WCdaJzi0/Yhwz8AaukyER9z0gyZIigMB+slNRDpw8/6Gs7/I
         WnIfz6VtD7S8soott6vmH/lCV94UTyGCiqjurWALMBaexgKjMtmMVPptnYx9TFnMMIdu
         Oc/N7XmzsEOEIaKX6xfAsf8SqDpSVAWD36ArzVzhmM+8EygDhs+n1sv9vo3DBuiLZpLy
         WzA3YEzAn+YvoFteRh8TLOBCcKb8MUVKFdkvxS22igywJonG0gReUYnIfmj2Fsqi4aTc
         MFTw==
X-Forwarded-Encrypted: i=1; AJvYcCXJQx2D9O+jSzEpn9y75vLImD0B7r6KLn2v4TJ8b2l7XKtu+UQaoS04JM7iyhHbV8L34P5WmJLkLgfr1lBw9xiBXDfNz8yH4bzo91d2
X-Gm-Message-State: AOJu0Yw8UBJqEWriC9mrZ7lzG35lh0zzNgOyWzSRaMnnFZvakDb5pthx
	MHQ/lzA7rJIHj4Ajl8h9htlKyRCQ8o/cjRE+IEaUxjRAbhhuVg5LoO+2kvHChUs=
X-Google-Smtp-Source: AGHT+IFiR9h8j51gi72vNffX3hceH0q+iH5LXTWgHiNHNmQPVUHiRpuRwEL/hhoSi7c6hrWzj0BB+A==
X-Received: by 2002:a5d:6542:0:b0:343:d23a:c977 with SMTP id z2-20020a5d6542000000b00343d23ac977mr4802161wrv.1.1712927118429;
        Fri, 12 Apr 2024 06:05:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:986c:54c:12ce:a121? ([2a01:e0a:982:cbb0:986c:54c:12ce:a121])
        by smtp.gmail.com with ESMTPSA id k12-20020a5d6d4c000000b00343e392829dsm4215174wri.97.2024.04.12.06.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 06:05:18 -0700 (PDT)
Message-ID: <bb32ccd8-cc94-43ea-b5e8-09162cf56179@linaro.org>
Date: Fri, 12 Apr 2024 15:05:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] arm64: dts: meson: fix S4 power-controller node
To: xianwei.zhao@amlogic.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240412-fix-secpwr-s4-v2-1-3802fd936d77@amlogic.com>
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
In-Reply-To: <20240412-fix-secpwr-s4-v2-1-3802fd936d77@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/04/2024 10:42, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> The power-controller module works well by adding its parent
> node secure-monitor.
> 
> Fixes: 085f7a298a14 ("arm64: dts: add support for S4 power domain controller")
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> Changes in v2:
> - Add fixes tags in commit message.
> - Add firmware node to adapt documentation.
> - Link to v1: https://lore.kernel.org/r/20240408-fix-secpwr-s4-v1-1-01aa7ee72c52@amlogic.com
> ---
>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> index ce90b35686a2..10896f9df682 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> @@ -65,10 +65,15 @@ xtal: xtal-clk {
>   		#clock-cells = <0>;
>   	};
>   
> -	pwrc: power-controller {
> -		compatible = "amlogic,meson-s4-pwrc";
> -		#power-domain-cells = <1>;
> -		status = "okay";
> +	firmware {
> +		sm: secure-monitor {
> +			compatible = "amlogic,meson-gxbb-sm";
> +
> +			pwrc: power-controller {
> +				compatible = "amlogic,meson-s4-pwrc";
> +				#power-domain-cells = <1>;
> +			};
> +		};
>   	};
>   
>   	soc {
> 
> ---
> base-commit: 4cece764965020c22cff7665b18a012006359095
> change-id: 20240408-fix-secpwr-s4-a99ff960d0ae
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

