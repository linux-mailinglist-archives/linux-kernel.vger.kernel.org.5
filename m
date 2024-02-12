Return-Path: <linux-kernel+bounces-61858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E056585177D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B06DB214F1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7213BB35;
	Mon, 12 Feb 2024 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P0F+OPX3"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B433B282
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750174; cv=none; b=bEL2mkCZSA6+nxAYUFjZGZvPZ2vR0uWEv3dOR0rtif6nHL38jtz3t6TI2PLlzsqJ690cRQ+FgpqCXU9neSZU/FhXqzEA/T+1aFAjdlvKWifb0c3WIZ4K4s4VQA8xVSQEdf6QBI5vDXNgo+jSFY+Eod1C8SzRqX1vid7uQyBjNVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750174; c=relaxed/simple;
	bh=zcJnISncWc0lol6NWfWUz+RXZL98nm6ftE77+aGLYWk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Fez2rZsxlv8A/2VQJlrAIuHGCn1L1n0V35HVELyi9MU2DJtOLUQ8o4/AVxhm3JCazEQTpQ/m8WjWZStbZe7NyPDY2oL2pqfoWiIWbresZcNq49OzN0pNr+GR7aVk0Kwwlq9KstdvUAtrAF44pkbZFeiTGdAqZAmom5nhbGrBmI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P0F+OPX3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-410cd2c7f27so8267915e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 07:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707750170; x=1708354970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mIRWEDm6h5i0aEXk2izLz4ROYQAZ1PoRscFJzI24z3c=;
        b=P0F+OPX3XMjgtw04M9SM1e2GulZZowbrqszY9y5ouhcPkOr8NzN6BQmcB/+G/y9Yxo
         fytrXpYwPmEpcpPk4fDpiWU0nNt9QNBFEUMl/Colk6zHaKkScAlgkTPEQ8ps7YS9O35h
         XF+WMgzk+4WwTzPjMziKayQzzR4krL/wbbPhyvkrVp+KVYVu8bpz4mBaUHS+eENMxaiw
         IYmMdceOfSHKlF9AWK7hIqwWe+i83g2D1X7lcQXXB4pJK29GHIluuW4eaHUjzBrYYEcQ
         XHb4BZZCdjuFMThIPljp43KbP2IJaNaqeCq6qLSMzhfFSe8ffkOvT1N3nBrCN4YQAaEC
         +v6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707750170; x=1708354970;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mIRWEDm6h5i0aEXk2izLz4ROYQAZ1PoRscFJzI24z3c=;
        b=cdwLtlVcOO1XWrqUgh3STbXworKlDuJqRanvDMjTMSU/INp74OOF/P8oWsZ/Ayo1LM
         Rkk+1qCNbVChqvQ1xR3ruLRej9ylLPd1qeizDIgr2OZX0MF/toHpbhDd//NW3hYmZ8x1
         JDvyOQ1tbchwaUxNsp6Wp1lABkJTvzZqSDtmrZCnDLXF5ZOaPrV4eQVrjps9x9iZ7gQd
         hggClBqHnNvot3+rOZKaNvGXWHj23v0e2ajEx8lYazrOok7JW0BzablP64Is9VhsKTWL
         OYPL/Y8d4yRnF9R6PaUgqKL6WLFSyqn1tltcySF77PP765xzxtYH10OGpjSyUp4kywff
         HnTw==
X-Forwarded-Encrypted: i=1; AJvYcCXhsMJcvOGr3BpQtV6tICtgpwHe/7LzxdqTNvNZll3xl/IOHhwLmOpNBx8V3MlTlpLaStscoaVxeHs3rLcIfQ6QyKRARVuXjQqhxo0g
X-Gm-Message-State: AOJu0YxQ3wRQgAJHsm7OoSNxx2vnkHob4JMJ8GcZqevJhelnZHOWHLRq
	Y1wQbwXLT3CGEcr0wrVsszg1ao/YE7fRuR7ksvQiZSN6ttB21/IB4HGoBIifZt8=
X-Google-Smtp-Source: AGHT+IFh+pVFPAbvo6g79lrwPbn+/Zl7HOPoCDqM/zZ00e/CgPffec7sh8ISXxyHAMIWJdvNSSlz9w==
X-Received: by 2002:a05:600c:5117:b0:40f:df31:6cac with SMTP id o23-20020a05600c511700b0040fdf316cacmr6697375wms.4.1707750170486;
        Mon, 12 Feb 2024 07:02:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUAvmhDqvYFlu6It9fZlStTBc8BRZBjdwuj34Z/s8MjeDVpwFU/bsg2EF4KGtARGSM3WmB1yc8nf1Dz4Ej9coe7ptGP9SLbh022GBRPDE6BE1N55JbpD48skceIYaaa1Gz2OS4l9kryXMupHZttgIewiLdFlsXCbxpKWxdXx0qeZ6vTbm0iSJPumtvorGTq43KtV6ChNx7W4EX9BKBcHpd7sx4vpaKo2+8at1ztXR2QDpBMe5sDAQlgkTxyBbj/JJcyAab2sqRyibW1nXJ2GizTba9F9cxSSidDBcURv4K1hBy6KWuIuddwLdxX7dpWhZ1HKT7qiHUKlF/xSO+im+G4PVzu9Q1bd88GpWsn8JzBRz8Ff527u6ehbS9bWF1D9hBgQgHmkj2ZhSuy9PYNU1yNyyVPqYsmRoNJJh2xKUNBVqzP4xMeQWFfBnUFIUEeegDt2blvn4TqR4DwHL9rrXOuZXNKTtmwpUySS3GLO3J0LdNXHj9hOUEsPLdYYFWgY7+z/KwYcS0UOIZG6vJsRy6Sod72xBc9Ts0R1Ylfic/m2c5sZtJ20eD0X1TIDQ==
Received: from ?IPV6:2a01:e0a:982:cbb0:fcee:f026:296d:135f? ([2a01:e0a:982:cbb0:fcee:f026:296d:135f])
        by smtp.gmail.com with ESMTPSA id fm8-20020a05600c0c0800b0040ef718cf81sm9146044wmb.28.2024.02.12.07.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 07:02:50 -0800 (PST)
Message-ID: <34ee9676-567f-4c07-83b0-f3b8b1e08db9@linaro.org>
Date: Mon, 12 Feb 2024 16:02:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 2/2] arm64: dts: amlogic: axg: initialize default SoC
 capacitance
Content-Language: en-US, fr
To: Dmitry Rokosov <ddrokosov@salutedevices.com>, jbrunet@baylibre.com,
 mturquette@baylibre.com, adeep@lexina.in, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
 martin.blumenstingl@googlemail.com, conor+dt@kernel.org
Cc: kernel@sberdevices.ru, sdfw_system_team@sberdevices.ru,
 rockosov@gmail.com, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240209212816.11187-1-ddrokosov@salutedevices.com>
 <20240209212816.11187-3-ddrokosov@salutedevices.com>
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
In-Reply-To: <20240209212816.11187-3-ddrokosov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/02/2024 22:28, Dmitry Rokosov wrote:
> The capacitance value is required for the usage of the cpufreq cooling
> device and power_allocator thermal governor in the appropriate energy
> model.
> 
> It helps to compute the power estimated by the SoC at the appropriate
> frequency. If it is the frequency of an existing OPP, or at the
> frequency of the first OPP above the requested value otherwise.
> 
> The power is estimated as P = C * V^2 * f, with C being the SoC's
> capacitance and V and f respectively representing the voltage and
> frequency of the OPP.
> 
> Since AXG SoC doesn't have SCMI protocol support, we need to initialize
> capacitance using the 'dynamic-power-coefficient' DT entry. Its value is
> retrieved from the vendor kernel, and it gives us the following
> freq2power mapping:
>      +-----------+--------+
>      | frequency,| power, |
>      |    MHz    |   uW   |
>      +-----------+--------+
>      |     100   |  10354 |
>      +-----------+--------+
>      |     250   |  27104 |
>      +-----------+--------+
>      |     500   |  55447 |
>      +-----------+--------+
>      |     667   |  77327 |
>      +-----------+--------+
>      |    1000   | 129024 |
>      +-----------+--------+
>      |    1200   | 164656 |
>      +-----------+--------+
>      |    1296   | 192489 |
>      +-----------+--------+
>      |    1416   | 239870 |
>      +-----------+--------+
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index ea96fef328e8..6d12b760b90f 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -74,6 +74,7 @@ cpu0: cpu@0 {
>   			enable-method = "psci";
>   			next-level-cache = <&l2>;
>   			clocks = <&scpi_dvfs 0>;
> +			dynamic-power-coefficient = <140>;
>   			#cooling-cells = <2>;
>   		};
>   
> @@ -84,6 +85,7 @@ cpu1: cpu@1 {
>   			enable-method = "psci";
>   			next-level-cache = <&l2>;
>   			clocks = <&scpi_dvfs 0>;
> +			dynamic-power-coefficient = <140>;
>   			#cooling-cells = <2>;
>   		};
>   
> @@ -94,6 +96,7 @@ cpu2: cpu@2 {
>   			enable-method = "psci";
>   			next-level-cache = <&l2>;
>   			clocks = <&scpi_dvfs 0>;
> +			dynamic-power-coefficient = <140>;
>   			#cooling-cells = <2>;
>   		};
>   
> @@ -104,6 +107,7 @@ cpu3: cpu@3 {
>   			enable-method = "psci";
>   			next-level-cache = <&l2>;
>   			clocks = <&scpi_dvfs 0>;
> +			dynamic-power-coefficient = <140>;
>   			#cooling-cells = <2>;
>   		};
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

