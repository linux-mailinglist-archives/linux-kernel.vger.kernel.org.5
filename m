Return-Path: <linux-kernel+bounces-38668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA3483C3E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10891C215F4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D05A56478;
	Thu, 25 Jan 2024 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ur51TMm7"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2F45786F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190084; cv=none; b=eXhtUvPiOz5AZCVwZWVj8sbPkjbAzcqeARyYv2PmH4lPzyl1dJsFmekLfPjKGX6rj1nq1tqA8zwBBVQt46aLtjSeWJmmvlRgtfawyNJ+B/sfxtqbJWtqCWgrBdoQmbsdS+Inuc/Y0opnATuqI70pnbOKp1h82qXoRO2II3dnmcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190084; c=relaxed/simple;
	bh=+PDHWeDWYawPP7KdfMCSUCIRoZJrKe3T9QQFG92CHuE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=kZf8hjAPd06QEBQyp1aIIEj//+OrYc8WL6/CKBEDmPI/zmlXHIshd+6kR4Y9ElMaOV9e5xRYDX1HK8qnl/XpwRNmVVDTtNhtDDCMAO7+7E04+J6AAhq0vc1/tD/kmycRhvz+QJuKNfO9X92SGf4ht7igavz1qCqRwBMtUiTzcjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ur51TMm7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e7065b7bdso79047555e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 05:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706190079; x=1706794879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gft2BW9y4/GZdP3gPjIqF6R/WNLiCwDjr+fDFTTpeqY=;
        b=ur51TMm7cOVQNlGLl4JuDQU+wHKWDZzwsdbkpkwUYel12Ec1+bKfPt/YPhBYScAWkI
         RJo3fUB0NvF6VbnZNLvYiBQv8aRGPd0PCgemADrBJ+sHxjOREnYDmaB648tlEqHEVF4Y
         lw+tDR8/2GRl81wbx/G/xYqKTe93y96QE6ZQ3FeOK4svzUNi79Q3z648zFWwe7WpnSM+
         /bsrx0h2yUO5S+w0rTzluvFKAnP0kWptPHKymxU9oHGUfw5nGi3ZJZ2EW3EwJJsjc9x6
         9NRqxZVcCa4UGyy48IcbCwXfz05zwgXceIOcY/UEbmqP1WF6C7/ReBVX3+F9Q8OSdyGm
         DHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706190079; x=1706794879;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gft2BW9y4/GZdP3gPjIqF6R/WNLiCwDjr+fDFTTpeqY=;
        b=cHRZhGrwcSk9+B1yWWP3UFwhOOQRVaa3mOBmlg4RzL4L2cLyYJAi934xl+CaEHtLKr
         v39xOXGJySquY3I8uRMDP0wBRlFZ6qdt4cbN6kd1APKwPmDBm7OElvZ+n7T28pZmtCPY
         Mgp9Rj3rbGggYCLP1ItkNMwjOPTeboZmDlYgRP4vrNCHO/pdEPriBGWDuTb+X8E0oFWa
         czZtHx+2m3dKmLtfzoYGs0aoXRkl5AgC+JFUrcwm0BSt19uAVF8S5K0RpsoWBuUHC5kV
         XdaDm+vySKg47Xq53nN0ei6P8gV9oyVBGskimrrblyzkc5tphR/L90y/INDgCcTwqUsF
         AtPw==
X-Gm-Message-State: AOJu0YxwoY07yIgU0dO5iOGyAAxJtCJn5jOtGL/IdOS8gyy+BiGIsT5I
	S42v3x8ywsUpeFYXyoIGkuTura+aiHI/bv38/oLy3l0fMoEkbu2HPrGhsNeU/Cg=
X-Google-Smtp-Source: AGHT+IF3HQcfgulmL4rbE0PhVuEQH3aTlmyJc/upFGPE/d1Azu5qJp0oAoLPwtr4g9akkEm8Fa4OQg==
X-Received: by 2002:a1c:740d:0:b0:40d:5a9f:5281 with SMTP id p13-20020a1c740d000000b0040d5a9f5281mr396381wmc.200.1706190079332;
        Thu, 25 Jan 2024 05:41:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:1a7d:7b36:3842:9bc3? ([2a01:e0a:982:cbb0:1a7d:7b36:3842:9bc3])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b0040e86fbd772sm2663887wmq.38.2024.01.25.05.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 05:41:18 -0800 (PST)
Message-ID: <c001bc36-5abc-4246-af54-f6ed04465cfd@linaro.org>
Date: Thu, 25 Jan 2024 14:41:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sm8550: describe all PCI MSI
 interrupts
Content-Language: en-US, fr
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240125130626.390850-1-krzysztof.kozlowski@linaro.org>
 <20240125130626.390850-5-krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20240125130626.390850-5-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/01/2024 14:06, Krzysztof Kozlowski wrote:
> Each group of MSI interrupts is mapped to the separate host interrupt.
> Describe each of interrupts in the device tree for PCIe hosts.  Only
> boot tested on hardware.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index ee1ba5a8c8fc..80e31fb21055 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -1713,8 +1713,16 @@ pcie0: pcie@1c00000 {
>   			linux,pci-domain = <0>;
>   			num-lanes = <2>;
>   
> -			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "msi";
> +			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi0", "msi1", "msi2", "msi3",
> +					  "msi4", "msi5", "msi6", "msi7";
>   
>   			#interrupt-cells = <1>;
>   			interrupt-map-mask = <0 0 0 0x7>;
> @@ -1804,8 +1812,16 @@ pcie1: pcie@1c08000 {
>   			linux,pci-domain = <1>;
>   			num-lanes = <2>;
>   
> -			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "msi";
> +			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi0", "msi1", "msi2", "msi3",
> +					  "msi4", "msi5", "msi6", "msi7";
>   
>   			#interrupt-cells = <1>;
>   			interrupt-map-mask = <0 0 0 0x7>;

230:         22          0          0          0          0          0          0          0   PCI-MSI 134742016 Edge      nvme0q0
232:          0          0          0          0          0          0          0          0   PCI-MSI 134742017 Edge      nvme0q1
233:          1          0          0          0          0          0          0          0   PCI-MSI 134742018 Edge      nvme0q2
234:          0          0          0          0          0          0          0          0   PCI-MSI 134742019 Edge      nvme0q3
235:          1          0          0          0          0          0          0          0   PCI-MSI 134742020 Edge      nvme0q4
236:          1          0          0          0          0          0          0          0   PCI-MSI 134742021 Edge      nvme0q5
237:         23          0          0          0          0          0          0          0   PCI-MSI 134742022 Edge      nvme0q6
238:         18          0          0          0          0          0          0          0   PCI-MSI 134742023 Edge      nvme0q7
239:          0          0          0          0          0          0          0          0   PCI-MSI 134742024 Edge      nvme0q8
258:          4          0          0          0          0          0          0          0   PCI-MSI 524288 Edge      bhi
259:          5          0          0          0          0          0          0          0   PCI-MSI 524289 Edge      mhi
260:         33          0          0          0          0          0          0          0   PCI-MSI 524290 Edge      mhi
261:          3          0          0          0          0          0          0          0   PCI-MSI 524291 Edge      ce0
262:          2          0          0          0          0          0          0          0   PCI-MSI 524292 Edge      ce1
263:         41          0          0          0          0          0          0          0   PCI-MSI 524293 Edge      ce2
264:         28          0          0          0          0          0          0          0   PCI-MSI 524294 Edge      ce3
265:          0          0          0          0          0          0          0          0   PCI-MSI 524295 Edge      ce5
266:          0          0          0          0          0          0          0          0   PCI-MSI 524296 Edge      DP_EXT_IRQ
267:          0          0          0          0          0          0          0          0   PCI-MSI 524297 Edge      DP_EXT_IRQ
268:          0          0          0          0          0          0          0          0   PCI-MSI 524298 Edge      DP_EXT_IRQ
269:          0          0          0          0          0          0          0          0   PCI-MSI 524299 Edge      DP_EXT_IRQ
270:          0          0          0          0          0          0          0          0   PCI-MSI 524300 Edge      DP_EXT_IRQ
271:          0          0          0          0          0          0          0          0   PCI-MSI 524301 Edge      DP_EXT_IRQ
272:          0          0          0          0          0          0          0          0   PCI-MSI 524302 Edge      DP_EXT_IRQ

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-HDK

235:          4          0          0          0          0          0          0          0   PCI-MSI 524288 Edge      bhi
236:          5          0          0          0          0          0          0          0   PCI-MSI 524289 Edge      mhi
237:         33          0          0          0          0          0          0          0   PCI-MSI 524290 Edge      mhi
238:          3          0          0          0          0          0          0          0   PCI-MSI 524291 Edge      ce0
239:          2          0          0          0          0          0          0          0   PCI-MSI 524292 Edge      ce1
240:         40          0          0          0          0          0          0          0   PCI-MSI 524293 Edge      ce2
241:         29          0          0          0          0          0          0          0   PCI-MSI 524294 Edge      ce3
242:          0          0          0          0          0          0          0          0   PCI-MSI 524295 Edge      ce5
243:          0          0          0          0          0          0          0          0   PCI-MSI 524296 Edge      DP_EXT_IRQ
244:          0          0          0          0          0          0          0          0   PCI-MSI 524297 Edge      DP_EXT_IRQ
245:          0          0          0          0          0          0          0          0   PCI-MSI 524298 Edge      DP_EXT_IRQ
246:          0          0          0          0          0          0          0          0   PCI-MSI 524299 Edge      DP_EXT_IRQ
247:          0          0          0          0          0          0          0          0   PCI-MSI 524300 Edge      DP_EXT_IRQ
248:          0          0          0          0          0          0          0          0   PCI-MSI 524301 Edge      DP_EXT_IRQ
249:          0          0          0          0          0          0          0          0   PCI-MSI 524302 Edge      DP_EXT_IRQ


Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD

