Return-Path: <linux-kernel+bounces-38670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A302983C3E9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F341C24092
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C69556758;
	Thu, 25 Jan 2024 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mAB9krfD"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D346655E57
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190187; cv=none; b=gbdZm1WmeWM8FsxImqt49YeDL2PureyBnmE+E/FT/fjTDwbzAbtu0os9IGNPVk4bTYE6B7XyjnQsmRmUSkBFlmmGPP72gnYNMy4aHSoXVvp4+cmiao3wLCeev5hkoMh+J9tyDAmgU5m+/qH6i7nuJOx4wSOIDurpB8ELmxbFDC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190187; c=relaxed/simple;
	bh=CLMiGZb99qiGs0po0LQ2ck2GX30OXK41bHI/SHAhM1Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=aEYumcYqSlwXiEHrutIFOGVbYfiQ2mx/cF/VDgWPeh6bv6aOVhQtn9vPD/GWdCmUHCVinbF+v5NdkKBahLiyrBVR8crb4OUPB/03+OX/79Ju+odncbCxtaBwNStBLxTdAqIMlQ2HLjYbH7T9hVCaTPvMbH8oJsf360D2ZbsywWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mAB9krfD; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-337d5480a6aso6010853f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 05:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706190184; x=1706794984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RiqoviQXGM/czPfXIjMxujYMnPmJeDkpHzRHL7FpUdI=;
        b=mAB9krfD2SrV+bPdo+0QsMvwyGRBBzmGsYR9pNCgVwNGIdsLCh2W39xFZIg2WnXhNb
         gjMJtN2TTAXCV73zGa0bP7XDfPTUba9XmbEz8krItyNs23cgVjmKoZv7VTm3gyMr1Wz2
         LDw6Cp1MNJBxJl4hn+lovGT2E0diniCudLt0nuAlwT5ghASesRNFv2+zKG/cKGf+Z9vL
         fT4dCU1HPywLET+BGZu7nsuJcVxc80W+uGeNJh2Ss8GQP0KXyF+R71HDPPAWbhINBqi9
         pP6tVraSln1jI5GHlohVPcylGebNSpBlg0LrZxmH6HyG4WZWSwN+soYhp16tp3fgoPWd
         gIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706190184; x=1706794984;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RiqoviQXGM/czPfXIjMxujYMnPmJeDkpHzRHL7FpUdI=;
        b=SJ7Sw95n0IZn2B9uHf+ZfJOiPL1lZb39IWEZna5+lkz69TAnC8Pe26Mni4Sdysv5H0
         Mftc3eIvK6s/XO+1ucnBARMA43M908MNPpQn6/UlG+ma9Z58klLov8c8PImqEwe0Mepq
         vb9nafuXAZwmWaUqptjKhhxB1sq1N3ptfFqVy8iUE5ekYTge5wTzfYPenS8+NpSYAPPf
         maxJHt1SJ857cwc/E3fFj+Nvx+hoRi2vysqYmowEXFMJ9WBJXmYjuL4OYVgm77A3rUUo
         XcV43yM5H+SVw+Sv7+HJZOvWAsAIQQupiQMbBDAQQAjrWsnn/Bg7mnjpnWCU4WdSwlv1
         9E7g==
X-Gm-Message-State: AOJu0YwXtOnK4d39R3NQu/VfPKmKVKUyu8tb5wKGGp8hYrVpLxk1rB8Q
	t3xKlQxt+46N4wJa1G2Cy27m81kLvcKZDgu/somuBkNQyuVCdBadrtaQ7ex8cQE=
X-Google-Smtp-Source: AGHT+IElvR+L8tozYGzsd7mvdLxlUMTooJMXJNqiSCYmS/kXO1pBEAc6rKhiqik6jajBUIaLpDpQwQ==
X-Received: by 2002:adf:efd2:0:b0:339:3968:65a5 with SMTP id i18-20020adfefd2000000b00339396865a5mr557214wrp.41.1706190184014;
        Thu, 25 Jan 2024 05:43:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:1a7d:7b36:3842:9bc3? ([2a01:e0a:982:cbb0:1a7d:7b36:3842:9bc3])
        by smtp.gmail.com with ESMTPSA id x16-20020adfcc10000000b00337b47ae539sm10652410wrh.42.2024.01.25.05.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 05:43:03 -0800 (PST)
Message-ID: <59ea1ace-7505-4275-bcfa-766e25e621b4@linaro.org>
Date: Thu, 25 Jan 2024 14:43:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 6/6] arm64: dts: qcom: sm8650: describe all PCI MSI
 interrupts
Content-Language: en-US, fr
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240125130626.390850-1-krzysztof.kozlowski@linaro.org>
 <20240125130626.390850-6-krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20240125130626.390850-6-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/01/2024 14:06, Krzysztof Kozlowski wrote:
> Each group of MSI interrupts is mapped to the separate host interrupt.
> Describe each of interrupts in the device tree for PCIe hosts.  Not
> tested on hardware.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8650.dtsi | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 2df77123a8c7..9fc4f3e37a8c 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -2213,8 +2213,16 @@ pcie0: pci@1c00000 {
>   			      <0 0x60100000 0 0x100000>;
>   			reg-names = "parf", "dbi", "elbi", "atu", "config";
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
>   			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
>   				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> @@ -2317,8 +2325,16 @@ pcie1: pci@1c08000 {
>   				    "atu",
>   				    "config";
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
>   			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
>   				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,

175:          4          0          0          0          0          0          0          0   PCI-MSI 524288 Edge      bhi
176:          5          0          0          0          0          0          0          0   PCI-MSI 524289 Edge      mhi
177:         34          0          0          0          0          0          0          0   PCI-MSI 524290 Edge      mhi
178:          3          0          0          0          0          0          0          0   PCI-MSI 524291 Edge      ce0
179:          2          0          0          0          0          0          0          0   PCI-MSI 524292 Edge      ce1
180:         42          0          0          0          0          0          0          0   PCI-MSI 524293 Edge      ce2
181:         29          0          0          0          0          0          0          0   PCI-MSI 524294 Edge      ce3
182:          0          0          0          0          0          0          0          0   PCI-MSI 524295 Edge      ce5
183:          0          0          0          0          0          0          0          0   PCI-MSI 524296 Edge      DP_EXT_IRQ
184:          0          0          0          0          0          0          0          0   PCI-MSI 524297 Edge      DP_EXT_IRQ
185:          0          0          0          0          0          0          0          0   PCI-MSI 524298 Edge      DP_EXT_IRQ
186:          0          0          0          0          0          0          0          0   PCI-MSI 524299 Edge      DP_EXT_IRQ
187:          0          0          0          0          0          0          0          0   PCI-MSI 524300 Edge      DP_EXT_IRQ
188:          0          0          0          0          0          0          0          0   PCI-MSI 524301 Edge      DP_EXT_IRQ
189:          0          0          0          0          0          0          0          0   PCI-MSI 524302 Edge      DP_EXT_IRQ

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD

