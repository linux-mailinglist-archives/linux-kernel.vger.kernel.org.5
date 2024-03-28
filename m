Return-Path: <linux-kernel+bounces-123034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B853A89014C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D8CBB23837
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030F812FB36;
	Thu, 28 Mar 2024 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="teyg8IDT"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BDC12FB0D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634927; cv=none; b=abH7DIY5ozTn9VCGc19lFyazgBUyI0PnJdSwPKNpt/0ZveWSNBYFRhGl0ul8sarQqiKjtI4jl1Bu0nX+O3y28rnuxAAxGrEeTZ99yLFktElaou75FWEv7lKxPwtwZXz3M58SgGM4gAHfvFJAJpFMeagVKtram+vATIjw3lY5KaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634927; c=relaxed/simple;
	bh=gy+79Ap55O5yFgH4vL0r2LFOc+Gja/OVumf4JwlTh5M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CKeK/py71bfvxe/WJ8ApW1Mqf8P0ZuII6e8VEqONNdihefQQYu3JrkF3dCq0HIiBPDV9JNg7y9lDVwfa+cnxbk37ld+/p04+RLfSQDO1sTqcMx/duLtYL60IWeVEbOT+hd5tReERJQGgQ52CnwjD3+fIaiTUjPH1YTBQ3WGJFOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=teyg8IDT; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso537771f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711634924; x=1712239724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YqEn6nGpQ+ZQnytWZdjBha5P7xeBVM99EE9tBd3Qr0=;
        b=teyg8IDT8y8GzuNfTdoz9d1Ijo/XRt67t8eSm7IpNrRbj0Pv3qOCu0/oNDYSPUk+Gd
         tf5JFTa0Buxwt1zyZhvbZRLzizaKJwVt1PU+RWJnkLCmWG3ez0MgZpJWpuSL78wNU6Ff
         Pqet8VX6NLOD9f8lBm9U7AmnAuFHanoKw+RMSAZz+83lbVwVLZahxBtP4Mc7sBFv+ChX
         lKpynoIp3wCXyLOgwjEG0wWNwLDKE7JJCumSkbtjEdAJfFCKpl7Y/cvUnsfsUQ/CDBlD
         y7vtnvjrPG8BV06SsCniSsjg30M9Jhj0V+ZovJLsPtdVcPH7tzR5oPsazQWoB7MwK+xR
         k0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711634924; x=1712239724;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3YqEn6nGpQ+ZQnytWZdjBha5P7xeBVM99EE9tBd3Qr0=;
        b=M2zUzpUisDmGi6km1h8Yi1hn8t1HPsCQ00E5ooFW/0858h2GDjg39GNFAFOSQKiBuo
         vgotHjlfyj4jCoq03gwLGdUIfQ5U+l2f5+eFIHRlg7BsbXpFvNQSwfBaWygprS/aJqEA
         Bi2GzxajLdREoyQHq0BM4ZsiBS3H7Jt9p1aXO12fC4/v9OHPY3RxIqHDoq2ptyk77Cip
         O3nToZJmLYvlKafX9og4zJjZZTDMC5PW+dD+yGJVB/rSzvnQHk//mQaDlSBgLbVT1Q4E
         3kvWMgWEATJsdI15vsOIWkAz6EJ3sG0OgG5pqx/62C1GmrsiDJWtE8bKisOvEOglVsCa
         RzCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuqc64KSM613auU/mzsc5JfHNepbJZeqzCCWp/FNeXuABkKJdqMKs+41PCkzTwZ21qNWIWuNszLHOG1Ak1sqfaeYUI8jwSMtHrNh2o
X-Gm-Message-State: AOJu0YySs5A/J1XWiUbXKm7DFJfF7VZmKS/mjdQADEhjCxjUhCAe38di
	mbElkZLwhnDj8mqpOhtms15HzXQVmReECQv4Y2+KaP6yXtQcSLl92eDOdU7dSWY=
X-Google-Smtp-Source: AGHT+IEC/GG3oRm4e7tBnbj5LOOMmvI8qJFpOtXQq9ZDhffYLQtVrVE6USAKpfkizGiK660to9vDdA==
X-Received: by 2002:a5d:44cf:0:b0:33e:c68d:d536 with SMTP id z15-20020a5d44cf000000b0033ec68dd536mr1904760wrr.15.1711634923800;
        Thu, 28 Mar 2024 07:08:43 -0700 (PDT)
Received: from [192.168.7.190] (82-64-249-211.subs.proxad.net. [82.64.249.211])
        by smtp.gmail.com with ESMTPSA id du9-20020a0560000d4900b00341bdd87fcasm1824861wrb.103.2024.03.28.07.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 07:08:43 -0700 (PDT)
Message-ID: <b893fe72-d315-4069-9e57-17e797121639@linaro.org>
Date: Thu, 28 Mar 2024 15:08:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/3] arm64: dts: amlogic: a1: add cooling-cells for
 DVFS feature
To: Dmitry Rokosov <ddrokosov@salutedevices.com>, jbrunet@baylibre.com,
 mturquette@baylibre.com, khilman@baylibre.com,
 martin.blumenstingl@googlemail.com, glaroque@baylibre.com,
 rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org
Cc: kernel@salutedevices.com, rockosov@gmail.com,
 linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240328134459.18446-1-ddrokosov@salutedevices.com>
 <20240328134459.18446-2-ddrokosov@salutedevices.com>
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
In-Reply-To: <20240328134459.18446-2-ddrokosov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/03/2024 14:44, Dmitry Rokosov wrote:
> It's used for CPU with DVFS feature to specify minimum and maximum
> cooling state used in the reference.
> Without these values DVFS will not work and dtbs_check will raise the
> error.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> index fbee986421f1..f65d4a77ee52 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> @@ -32,6 +32,7 @@ cpu0: cpu@0 {
>   			reg = <0x0 0x0>;
>   			enable-method = "psci";
>   			next-level-cache = <&l2>;
> +			#cooling-cells = <2>;
>   		};
>   
>   		cpu1: cpu@1 {
> @@ -40,6 +41,7 @@ cpu1: cpu@1 {
>   			reg = <0x0 0x1>;
>   			enable-method = "psci";
>   			next-level-cache = <&l2>;
> +			#cooling-cells = <2>;
>   		};
>   
>   		l2: l2-cache0 {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

