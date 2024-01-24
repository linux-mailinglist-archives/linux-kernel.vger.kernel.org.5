Return-Path: <linux-kernel+bounces-36990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE26283A9E1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F390282824
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4EC77F11;
	Wed, 24 Jan 2024 12:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xkqbvsGc"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D45177F04
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099646; cv=none; b=LAidxTQz60+pO5CrMHbKCcPYIpQKYS9DNOUruB23NBcQXAeYEMuoin67G8G9e0KCaJVYT1FojVjx5zGni/hkrtfA/wXwTm66ZGm8xREtA7mn6gyqP7Hx4kRT+XSNL1GjLaJlqCwmpdU95lzc6v4wAA3zwXvLaNGl0saACdyiy8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099646; c=relaxed/simple;
	bh=y1OAzso9p+5ssFJXzvM0wjYbXQHZ5vKrOzRa+X3JbF8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=C/NM3KIxTXvGYTcKxRvCM7xkabwMVV1nqnCH4L2Hcv+NDzxDeQP7wezvWP2Kt+rok59AlwQijPTq3eGxdQkSZBalRSoOuvPpEvCPb2vQQuCA7j2Bwmj/m96R0kOJvSmxz7zQb1c7gaVOLMSmUIDFsyRXiGynOInncv9FrFSHnsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xkqbvsGc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e7065b692so58748165e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 04:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706099642; x=1706704442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4CyEqfj2/BL4C+FmAytidCDy1VCKLDY8HAXokTWCiA=;
        b=xkqbvsGcZOEv7j+gLkf67i/wAdkY+uy34es1DfyPmlo9IZ56SJcjiINpa7BCB2Ejnl
         pf/11aULcHlRW3wG5eqkrn/LeX4mhYGs354mr2PZcWNZBBmJetq4rP6vVE0Khe3vZxVQ
         X2C0vsnYYZBUAMLLrLN2MESltKCHsXKkNftDqWYbeovJ3/Wgm4UsCPl1XecfpSZQMgtx
         KAmqt1WtAbRtsYlsuo30JfHXFtMZMEwjeSBrQ7NihxPppTf1tOlEs7CmIeL6TNYzJE7V
         WD6ZuwoxPiAx0Tciyd8Nz6HlkaBHarS0WCsivnqbc8Ds7yR1wuo6xMsDkECis9Tugb7E
         6XXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706099642; x=1706704442;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j4CyEqfj2/BL4C+FmAytidCDy1VCKLDY8HAXokTWCiA=;
        b=QarB64UkAqZz7GbfJRCXyCw6x74fWK1AgO5wbk3ZhTpqJZ0L/8D8BfLZzvl/4gdbwz
         recVUuZNt/EIRsDXL+kXUh4K1zO6b0W3ozanhTyOc/X2XHO5socpGDIZY8GqYtwz1lN5
         XKUOaS0hJzypd+IYqS/X61UGHLkfmV55HWLplP43uwVLm9a1278XqshjBRhWi4fS69od
         aUX2sflixnB798eK1dippHiACOgqQD1rT/2JVPHDcHUe+rpqDr/KKYlMOp5NxS7qPpGV
         5oGtsdkXSJqkBcq8CZVnWaeG+8TQQJ0lPUvql/PD02BpNoqbjIF8ROtLreh4KEcfsdem
         1VUw==
X-Gm-Message-State: AOJu0YwyOFbHJ9BsVS54llSj9xLjviAsmbZg/XghJDPBFdxiI7m6v4Ln
	O+mXiWi6Tzf4MBn7iWg9Rm2jVBu704lgobEXlkagshEPdgVsT5uGCcbk+Kv7XDg=
X-Google-Smtp-Source: AGHT+IEWrgPv43WEZDqGpGl2eARernH5yVyaeMrqaYve22L/yssZp7FrqxPycO+LGfkpDFcmEJim8g==
X-Received: by 2002:a7b:ce13:0:b0:40e:596a:985b with SMTP id m19-20020a7bce13000000b0040e596a985bmr1155942wmc.160.1706099642464;
        Wed, 24 Jan 2024 04:34:02 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:fd4f:fd82:e4fb:1654? ([2a01:e0a:982:cbb0:fd4f:fd82:e4fb:1654])
        by smtp.gmail.com with ESMTPSA id ay2-20020a05600c1e0200b0040ead97f70dsm10083247wmb.24.2024.01.24.04.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 04:34:02 -0800 (PST)
Message-ID: <e8d061fd-151f-4f8d-9199-2c1225bb2278@linaro.org>
Date: Wed, 24 Jan 2024 13:34:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 13/14] arm64: dts: qcom: sm8650: Drop PCIE_AUX_CLK from
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
 <20240124-pcie-aux-clk-fix-v1-13-d8a4852b6ba6@linaro.org>
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
In-Reply-To: <20240124-pcie-aux-clk-fix-v1-13-d8a4852b6ba6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/01/2024 08:36, Manivannan Sadhasivam wrote:
> PCIe PHY hw doesn't require PCIE_AUX_CLK for functioning. This clock is
> only required by the PCIe controller. Hence drop it from pcie_phy node.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8650.dtsi | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 2df77123a8c7..b31e60599891 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -2276,13 +2276,11 @@ pcie0_phy: phy@1c06000 {
>   			compatible = "qcom,sm8650-qmp-gen3x2-pcie-phy";
>   			reg = <0 0x01c06000 0 0x2000>;
>   
> -			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
> -				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +			clocks = <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
>   				 <&tcsr TCSR_PCIE_0_CLKREF_EN>,
>   				 <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>,
>   				 <&gcc GCC_PCIE_0_PIPE_CLK>;
> -			clock-names = "aux",
> -				      "cfg_ahb",
> +			clock-names = "cfg_ahb",
>   				      "ref",
>   				      "rchng",
>   				      "pipe";
> 

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD

