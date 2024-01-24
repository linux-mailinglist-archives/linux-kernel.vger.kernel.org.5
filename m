Return-Path: <linux-kernel+bounces-36974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C66383A9B0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE8E1F2C404
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398A163125;
	Wed, 24 Jan 2024 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PKp1+q5E"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55698CA69
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099202; cv=none; b=dWbRHzpZI/o2SKx8YgtgyUUx3F0DDeC8ZMGuW5tZcaVxwUrgO+a0fmi4S6H0TJRDkGnbODoA799XPLmiBFbp3C6ZAvjEa9A4QEXwQoW4k7E26jBNQArZMKENaTA0j/yhCNHzEK3bUrime3iIuezqH4SQdZ/26zGf/vL4SNXxs3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099202; c=relaxed/simple;
	bh=Xe9QImb25vctXjuR9M9SP1j7VHWxYeFa28Qhb2bu6ss=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FatCMtIFO4tRU+9lImTTB0lO9MOQY6zEc/phrJQZ28mV1YZoyTip/LxMEx0ZLb9dVjPlsyeF/CC9xN6pVE4WTKfd15JIJYThzY6SvSsv95SB2kMtSwn1rpUsOrFvpW/ku1lWALOIDOxqYOUDtJqmX0yKVPIZn7Z/yaZ/uH++sLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PKp1+q5E; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3394dc2ae23so533928f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 04:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706099198; x=1706703998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tFDRjvoN8YUq/pq6hUZ63ynjSng3YxXBPPeOWs+bSxE=;
        b=PKp1+q5EhrT2QETn8+ZSNc8cTH9JG0QN2rHSQ7vKahOsv/covyuw5/O+UTgwi4F7tl
         sw9nwtBebkLoiE/XxhbuP/tEREGc7duG8SFR30M0Ky7+iglaFin0QUwi9SqM9Wc8VVEa
         t6z4bpt9xK1cDeR8WBnrkJEctdTzpN6fES0eN1EmUmxdiVYl50eKZWVH/5eqsvyMdaGp
         AvHT5O2TigGTcTBxhJbH1/4a/9asDWzOPoun05coteDEkoj7yxfCfkIetu/8O2LmdMIP
         8uqe8RPx2aR3bM5LeQCRsOMCNW4kmzSslE6z2PbzFu/fIwSOMPbUZ//PMnAYN7bIUOsU
         aJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706099198; x=1706703998;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tFDRjvoN8YUq/pq6hUZ63ynjSng3YxXBPPeOWs+bSxE=;
        b=DkEHGNuI8jIiKrlKGOJu06s4L3OJ77gWbn0c9zZ+C3Tn2VwF5U33ruHfteUOOv3w1k
         MGp9AoZXBdzT5Tq1UhKfU100vNy+oJGYboziljLz/gyVEiZgT1bbRBMtSsAr1cCsnbjb
         sH3J95HiuUExQckEewVSHnbgV2s9wgu5VVNFyiyxCMYGmDPzNdZrPPM4yKJJ0rkWjBj/
         bGAGZ14BboTRLEpcebqaFLSGKfmpoTgLt42GcGIJ34z04P8b8gkB9vXrJUz/DIAc+ZtC
         5DKmrfKFNPnGJ6wuiBGtYi+KWR6wEoZwz55QY9f8COViScLgY5yFZiI9E8U4x+aQzsvy
         tR+A==
X-Gm-Message-State: AOJu0YyzduQnTn/FAdcwplbTZBw+5wxxfSAsvSGAQLugu1MoR//JY2bJ
	SSrxnSmcyLTztM5AWzW9TZ566GDwWNUZesl/yHFErkmxCnwZZ6s/KeiKSdYMWIA=
X-Google-Smtp-Source: AGHT+IE2Wk5jwnLRHwiM16HLhu2l98agOIICE42oHDb18g+iN9MYGcHSnQcG19pFbjpFAhCugnWtEg==
X-Received: by 2002:a5d:6750:0:b0:337:bdae:c557 with SMTP id l16-20020a5d6750000000b00337bdaec557mr332892wrw.10.1706099198620;
        Wed, 24 Jan 2024 04:26:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:fd4f:fd82:e4fb:1654? ([2a01:e0a:982:cbb0:fd4f:fd82:e4fb:1654])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d6ac9000000b00337d392c6c3sm15889124wrw.13.2024.01.24.04.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 04:26:38 -0800 (PST)
Message-ID: <047a59f6-7c6b-4854-8985-2306abbaa0a8@linaro.org>
Date: Wed, 24 Jan 2024 13:26:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 12/14] arm64: dts: qcom: sm8550: Drop PCIE_AUX_CLK from
 pcie_phy node
Content-Language: en-US, fr
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240124-pcie-aux-clk-fix-v1-0-d8a4852b6ba6@linaro.org>
 <20240124-pcie-aux-clk-fix-v1-12-d8a4852b6ba6@linaro.org>
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
In-Reply-To: <20240124-pcie-aux-clk-fix-v1-12-d8a4852b6ba6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/01/2024 08:36, Manivannan Sadhasivam wrote:
> PCIe PHY hw doesn't require PCIE_AUX_CLK for functioning. This clock is
> only required by the PCIe controller. Hence drop it from pcie_phy node.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index ee1ba5a8c8fc..f074683f7940 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -1760,13 +1760,11 @@ pcie0_phy: phy@1c06000 {
>   			compatible = "qcom,sm8550-qmp-gen3x2-pcie-phy";
>   			reg = <0 0x01c06000 0 0x2000>;
>   
> -			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
> -				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +			clocks = <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
>   				 <&tcsr TCSR_PCIE_0_CLKREF_EN>,
>   				 <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>,
>   				 <&gcc GCC_PCIE_0_PIPE_CLK>;
> -			clock-names = "aux", "cfg_ahb", "ref", "rchng",
> -				      "pipe";
> +			clock-names = "cfg_ahb", "ref", "rchng", "pipe";
>   
>   			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
>   			reset-names = "phy";
> 


Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-HDK

