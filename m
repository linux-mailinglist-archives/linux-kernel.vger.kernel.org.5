Return-Path: <linux-kernel+bounces-74721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F12485D837
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3564C2832CD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7596A8D6;
	Wed, 21 Feb 2024 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ENwD+qif"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D720E69E00
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519618; cv=none; b=ee8uZuIUtXPNEfxV+qD+OwYn1ICRBTmyds5k0P3IAe7UaG3vsmfihwIPw7I4Cl4Wnu0qJOWuXDV/7d2I6BBAMgb2bQf6iLN2LjDWIWVgaQJRBUWh5Zk5cdywnR/B3zqeyHda6UFGqyOV1AS/LJNNqEJg2GNkLSLToUd9aRlGUv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519618; c=relaxed/simple;
	bh=C+qHTE/kUwa5Ov25oiEYLHT4061re5xSbJ7Y0ykBMro=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EElbVrSONFvOYlzwhNOLsmNFdbChuWNqTiC8wkDuvnh+vkLudr5Sh/xXNBHgHQvfeuFhSVxydCBUW/7Dzon1quLdFcoN5yPwGVUvZx8+1zZiB7YVViql3yOAXqmHVzSpghoV1rQjmTTPO9zVHNM+oLGyzx4Croobf4hyCEM5JYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ENwD+qif; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412730e5b95so7419475e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 04:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708519615; x=1709124415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gkh71+m5Vihy0uM/MvTxrgi7TFtnMZn2RZ+Ics2kzLw=;
        b=ENwD+qiftGyRKGK5rmPZy6tzQbZwF4aefE63b6cCCh5GZgLLlzKjfLZ03rPbzUDI05
         Dzwf8tjX+60j0vJJgUAbimoJ03/UkJIlfWyhfpy4OB2eqGjE2B8jlYGIK/c+Y6WsDAMW
         ie8slVGSCs9pkOc7x0eIX+T9Dg7BHBqrbKFpApyGcBS21Y7ELCuhslE22Fok+X4U/eci
         bPNaXXwo0WxZpn+Z/X/oMt1OcUTIPFCNW6b1vg5v2UPLRdoYftHgy2KbATPYvZ6sXVCw
         D2h/CgJOBa06JMM2SFKq6e5quh/IPLT0Nk2L8RCKeKpwR8HOeey4XgTFqAN6HQSqdctb
         fPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708519615; x=1709124415;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gkh71+m5Vihy0uM/MvTxrgi7TFtnMZn2RZ+Ics2kzLw=;
        b=t2tbDejQF43icOEfZdfXqC9UpEcF9horu/kwnYz2rgGMrvzbHkZQiRMIIYOfnWyQFV
         LpLqgaggpfWv2W5iBzSU0ahK/vEEmXPvEZZJDA0U8KQMaxEOhISA8qeMdqYUyJWZZ9DX
         nof4V5R4Wh7VnIUmM4ofbmKzIq0bjlXmAjhMopUvVVRgb5KdUBprR3T84oqa25FmPvzo
         7FJTMXTtNcRbQ9nUHRhFfAujwiicU15DvQdkkPA04Qo4vOg4rse4l/f41Dd7fbjAAexd
         KOfHqVqlbk3jGze5LyUuJvun/3pW9xrosahArEmwEZg0Xt5L5rZk8iKpdA4GPWsgB5P3
         b+Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUUUJ89s6Ia6Myv1l/AIRQ1s/BxsWfgVU8TAjF7NY48T04nddrvx+x086efgJ9FbZ2gAxAyVv17UNW/0/CV986JLi0NleHO1ig5ndSe
X-Gm-Message-State: AOJu0Yw2ReyygKCEqxPvAbnPJKCr6CM9xpHZYHgjilW0JvufHutJWVIU
	gPXEr8pEajpcMf49dr56Az+J7zlcmptvfCuUZegHSUzrJFe5bTh6rSkUsJeOugE=
X-Google-Smtp-Source: AGHT+IHcHp5sk7A3bj3G965spGGsd2AaYtv85k/ipjfaVQGAR0F1tHbg3IfPgWstGGpYwAIlKk3w4Q==
X-Received: by 2002:a05:600c:314b:b0:412:71fb:7732 with SMTP id h11-20020a05600c314b00b0041271fb7732mr2262112wmo.38.1708519615146;
        Wed, 21 Feb 2024 04:46:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:83fc:439c:6f36:ce5c? ([2a01:e0a:982:cbb0:83fc:439c:6f36:ce5c])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c459100b004124907f43fsm17468735wmo.12.2024.02.21.04.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 04:46:54 -0800 (PST)
Message-ID: <e3425067-5e55-4f32-8183-c79617c17d3d@linaro.org>
Date: Wed, 21 Feb 2024 13:46:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 05/21] arm64: dts: qcom: sm8450: Add PCIe bridge node
Content-Language: en-US, fr
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240221-pcie-qcom-bridge-dts-v1-0-6c6df0f9450d@linaro.org>
 <20240221-pcie-qcom-bridge-dts-v1-5-6c6df0f9450d@linaro.org>
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
In-Reply-To: <20240221-pcie-qcom-bridge-dts-v1-5-6c6df0f9450d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/02/2024 04:41, Manivannan Sadhasivam wrote:
> On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
> for each controller instance. Hence, add a node to represent the bridge.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 01e4dfc4babd..e874cc4f8e6f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -1824,6 +1824,16 @@ pcie0: pcie@1c00000 {
>   			pinctrl-0 = <&pcie0_default_state>;
>   
>   			status = "disabled";
> +
> +			pcie@0 {
> +				device_type = "pci";
> +				reg = <0x0 0x0 0x0 0x0 0x0>;
> +				bus-range = <0x01 0xff>;
> +
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				ranges;
> +			};
>   		};
>   
>   		pcie0_phy: phy@1c06000 {
> @@ -1931,6 +1941,16 @@ pcie1: pcie@1c08000 {
>   			pinctrl-0 = <&pcie1_default_state>;
>   
>   			status = "disabled";
> +
> +			pcie@0 {
> +				device_type = "pci";
> +				reg = <0x0 0x0 0x0 0x0 0x0>;
> +				bus-range = <0x01 0xff>;
> +
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				ranges;
> +			};
>   		};
>   
>   		pcie1_phy: phy@1c0e000 {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

