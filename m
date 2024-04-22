Return-Path: <linux-kernel+bounces-153675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E32F08AD182
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E5F1C21018
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF48153593;
	Mon, 22 Apr 2024 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lIuTCyVp"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFA415357B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801909; cv=none; b=u4Oj1IdEp14cQUEpBGP34TFCSxWR2/KDsDjPk79oFdzBBS3lXHogkOklw2s5It/5cBotV1GivZ4x4vb0HggBhhfbzzMsMnneuoCSrHpneOJZA19k8FICrBtHMdB1ZTiPQk43kMsBnvIVan3j6K3gzzBjBxdkC8ImP8LoLJM3PmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801909; c=relaxed/simple;
	bh=uMrqfXtK6k+O5vJvYEYy/TACHxRsqtS+As5XBUxjJb8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=be/6cvQuCBj11zmdEhC+R9D7ieyTumEtONqym0q7cEXekW5pPov8TD4iVoloypVxkzuZBauCQUdSboQHKilTpSGgGwLFyPU3kHjJ7Ej9pk7hQzS88/0U2LgiqJU/IMU35kL+ThstQ1yzKWBg+w9vFJweVAIYIH1HmmGrqHG/RJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lIuTCyVp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41a5b68ed85so6710645e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713801906; x=1714406706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWwGyt3dTm+Wuf9S+gzlWNOA5yNIL5XlLbZV/xMCQ0E=;
        b=lIuTCyVp45AAyZUf6x54pVz1T4s0mTi1gOa1YwZAowlM8AydlhXXfNvGUuZ4O//fuU
         nQ0KJafisMVL4fwYJ9Z5x/P4KF2+W9yse8cqKLaOtzZ/i0QRhxVoT7xmmfE4zK8ywFe9
         ebL6YfUwxNGct0FddjHzyL2jSwnvl8JdzrXaIJOqT5rTIhNbe0V8SMSRVzCRF3MoD/6b
         AJiSYtMTWJMQIRQ/WQLxRh4jSJpaAvlhKcgvQcVAJUShMYyuHfIpJaYB264TiLtgaRNJ
         DpvkVTsUwVF0tlVIiaJQ7toZYR6HC517po1OpoET1PTJ3YnNjZ61U2bMgxkykN9yknjR
         a2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713801906; x=1714406706;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dWwGyt3dTm+Wuf9S+gzlWNOA5yNIL5XlLbZV/xMCQ0E=;
        b=T67sVrKJmXyOQU9WwNCSYVMxMAE+TYhk3YgYJLV6I/PJBu6A0LW162v4iM8HnNkhXx
         /L/rAEmDBe4FYK61QLgaVcsz+IWxr9+3q9Y5CLuyLwXFb0EptPsRnEl2ezIStBHrvrdO
         1T/FLpFgOjOakPZMZvjXnDSptZ+vY9R2eDyNExNdJ/UqOLMg4fV9fwk5qPrjnMr7itmj
         pKnQU+id1xt0QGSsIY7/LLn3uX3dcZPNaOk+wuGKfjIB3isVY5vcXdAXhld7637iPhfS
         67OvpR8YIZUUsP36IyX/uyJBNzTZJLau4UQ3VcjcpetFeMN+kO5CyCW4jSyQ95NoW5sO
         Ys2g==
X-Forwarded-Encrypted: i=1; AJvYcCWVSzAiBQHB7pGjcYYHM+mMnWhoxs3UGl0cw2BUVlKNsSIsprqWE1TOxPhCE4+Y6fnvitZI77K1Ulg+P9k1oOukG+Tzt5hUtFX5wNrz
X-Gm-Message-State: AOJu0YxIydGu0utg6d2fbS1YWZqgU3wzoUbyxPHpWbIXKVkfdwHQi2pl
	dDnSD09zfzJTUJpKYdsdhnegUtSrI47MV2powq+sfW1TJCUglVCvbTrvl+sbq3I=
X-Google-Smtp-Source: AGHT+IE/nftNT+d/dSVZ6a3LU5UwbsOra6VLe9tpF78RFTwys+yB9GNv7ju2pzg5L6PKopNHp9RnJA==
X-Received: by 2002:a05:600c:4f51:b0:418:5ef3:4a04 with SMTP id m17-20020a05600c4f5100b004185ef34a04mr72995wmq.18.1713801905239;
        Mon, 22 Apr 2024 09:05:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e5e5:892f:e81f:7cad? ([2a01:e0a:982:cbb0:e5e5:892f:e81f:7cad])
        by smtp.gmail.com with ESMTPSA id j10-20020a05600c190a00b00418a9961c47sm17130734wmq.47.2024.04.22.09.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 09:05:04 -0700 (PDT)
Message-ID: <9c83bd1e-8753-4f25-a1d9-97f106db4bb2@linaro.org>
Date: Mon, 22 Apr 2024 18:05:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 0/3] arm64: qcom: sm8650: add support for the
 SM8650-HDK board
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20240422-topic-sm8650-upstream-hdk-v4-0-b33993eaa2e8@linaro.org>
 <171378646269.749144.3843772037586831461.robh@kernel.org>
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
In-Reply-To: <171378646269.749144.3843772037586831461.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/04/2024 13:50, Rob Herring wrote:
> 
> On Mon, 22 Apr 2024 10:48:11 +0200, Neil Armstrong wrote:
>> The SM8650-HDK is an embedded development platforms for the
>> Snapdragon 8 Gen 3 SoC aka SM8650, with the following features:
>> - Qualcomm SM8650 SoC
>> - 16GiB On-board LPDDR5
>> - On-board WiFi 7 + Bluetooth 5.3/BLE
>> - On-board UFS4.0
>> - M.2 Key B+M Gen3x2 PCIe Slot
>> - HDMI Output
>> - USB-C Connector with DP Almode & Audio Accessory mode
>> - Micro-SDCard Slot
>> - Audio Jack with Playback and Microphone
>> - 2 On-board Analog microphones
>> - 2 On-board Speakers
>> - 96Boards Compatible Low-Speed and High-Speed connectors [1]
>> - For Camera, Sensors and external Display cards
>> - Compatible with the Linaro Debug board [2]
>> - SIM Slot for Modem
>> - Debug connectors
>> - 6x On-Board LEDs
>>
>> An optional Display Card kit can be connected on top,
>> an overlay is handled to add support for the DSI Display
>> and Touch Controller.
>>
>> Product Page: [3]
>>
>> Build Dependencies: None
>>
>> Functional Dependencies:
>> - PCIe 1 PHY AUX Clock: https://lore.kernel.org/all/20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-0-3ec0a966d52f@linaro.org/
>> - PCI-MSI Fix: https://lore.kernel.org/all/20240318-pci-bdf-sid-fix-v1-3-acca6c5d9cf1@linaro.org/
>> - UCSI Fix: https://lore.kernel.org/all/20240315171836.343830-1-jthies@google.com/
>> - USB IRQs DT check fix: https://lore.kernel.org/all/20240314-topic-sm8650-upstream-usb-dt-irq-fix-v1-1-ea8ab2051869@linaro.org/
>>
>> [1] https://www.96boards.org/specifications/
>> [2] https://git.codelinaro.org/linaro/qcomlt/debugboard
>> [3] https://www.lantronix.com/products/snapdragon-8-gen-3-mobile-hardware-development-kit/
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> Changes in v4:
>> - Rebased on next and fixed the apply failures
>> - Link to v3: https://lore.kernel.org/r/20240325-topic-sm8650-upstream-hdk-v3-0-4f365d7932af@linaro.org
>>
>> Changes in v3:
>> - fixed regulator node name to fix ordering
>> - deleted pcie_1_phy_aux clock
>> - removed undeeded mdss_mdp status okay
>> - collected revied & tested tags
>> - Link to v2: https://lore.kernel.org/r/20240318-topic-sm8650-upstream-hdk-v2-0-b63a5d45a784@linaro.org
>>
>> Changes in v2:
>> - Fixed commit messages with links, and recently added product page URL
>> - Swapped i2c3/i2c6 nodes
>> - Moved pcie_1_phy_aux_clk under pcie1_phy
>> - Removed duplicate mdp_vsync pinctrl state
>> - Collected review & tested tags
>> - Link to v1: https://lore.kernel.org/r/20240223-topic-sm8650-upstream-hdk-v1-0-ccca645cd901@linaro.org
>>
>> ---
>> Neil Armstrong (3):
>>        dt-bindings: arm: qcom: Document the HDK8650 board
>>        arm64: dts: qcom: sm8650: add support for the SM8650-HDK board
>>        arch: arm64: dts: sm8650-hdk: add support for the Display Card overlay
>>
>>   Documentation/devicetree/bindings/arm/qcom.yaml    |    1 +
>>   arch/arm64/boot/dts/qcom/Makefile                  |    5 +
>>   .../boot/dts/qcom/sm8650-hdk-display-card.dtso     |  144 +++
>>   arch/arm64/boot/dts/qcom/sm8650-hdk.dts            | 1251 ++++++++++++++++++++
>>   4 files changed, 1401 insertions(+)
>> ---
>> base-commit: a8e1147ee205e7b8dfe18094ed39552a982857f1
>> change-id: 20240223-topic-sm8650-upstream-hdk-e21cfd6f1de8
>>
>> Best regards,
>> --
>> Neil Armstrong <neil.armstrong@linaro.org>
>>
>>
>>
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>    pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y qcom/sm8650-hdk.dtb' for 20240422-topic-sm8650-upstream-hdk-v4-0-b33993eaa2e8@linaro.org:
> 
> arch/arm64/boot/dts/qcom/sm8650-hdk.dtb: pcie-1-phy-aux-clk: 'clock-frequency' is a required property
> 	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
> arch/arm64/boot/dts/qcom/sm8650-hdk.dtb: phy@1c0e000: clock-output-names: ['pcie1_pipe_clk'] is too short
> 	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
> arch/arm64/boot/dts/qcom/sm8650-hdk.dtb: phy@1c0e000: #clock-cells:0:0: 1 was expected
> 	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#

Thx, this is fixed by https://lore.kernel.org/all/20240422-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v3-0-799475a27cce@linaro.org/

Neil

> 
> 
> 
> 
> 


