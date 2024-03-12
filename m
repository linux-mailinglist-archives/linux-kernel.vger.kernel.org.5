Return-Path: <linux-kernel+bounces-100685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CF2879BD3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69C91C22691
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99F7142645;
	Tue, 12 Mar 2024 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HN1QAnTH"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBAA1419B0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710269117; cv=none; b=BE562RYC0fj2Zc/zv4P7TlbtibcC26oG8PQyCvEyewQqxFU27IP0ZnhHU6SP7Yiv4hCVCPVEbTpqpIn5hi9gZ1PjpHF9Kb/q6spMCuPhJolpuRwy8auRQQyLaol3X1jlCJb93KcoIFrD1MjG5Tl57lqywa4fL3dkPggzJQrTjHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710269117; c=relaxed/simple;
	bh=1zJnWv1hrjmsMywTXYDBfs8GRqOr++kEWNQG39++kCg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ogQHuQzjEg6S8/gZBnnxSzygxztbLNRtGQQ74mEUJMBNYuP+ujEVsh5MiqlRv8EzC1PY3wvjq391fkWQ0pZv5dbUaBLyd9wspTXNmsYU+pyXqspLy+QUtyZEAEPrG+w9Qi47V6wtyPVSSTYjh1rMLjOsaApW5PPNT5tJJD6n3cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HN1QAnTH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-413383969efso876495e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 11:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710269114; x=1710873914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEVFAngRvDl2zbSiDLqDrlc16GB0IzIQ5e1CSaj+FrM=;
        b=HN1QAnTHsJjHUsaQEJKNBD6wMRmov5z5Y+BM0AwLG/X1u0NycBQUn91yxFfXmaXb2l
         K/k+SMUm5oKoMv67NKnKXKh0EcjdKGvIBdyBzZABr0vXDExBuJKugyrGjNESFdRZ796m
         vbtY9cfaoT1dWXKTEcXndYMBnWbBz0hBQWKSe+JVYZx+pzo/hDsWi4/Scx4G+iBd8ucW
         ozJ0HXqH0zVi79IqLByVIATwe0JmONmh5XV7EEW6i23x4XhdhcARziroazAg3BWG/gTc
         0GRpQjiWGqdN4gveD/RGmaMgVy5PG2LqVF6mppwVFIXRbY/vX6Domqcj4HN0JH5ZSgey
         R+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710269114; x=1710873914;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bEVFAngRvDl2zbSiDLqDrlc16GB0IzIQ5e1CSaj+FrM=;
        b=QefOE/BVeMA0bsq4bliRpnK0QRGcq7zBASlV0sITwEVMO8VnwXfzfILqmv4J7vd7Z9
         +GMcH6ckobBTyQcYWjC1V+mFL/teUxgunJHKJHahmxNy88JB5PiS6XnxLNlaL+/jY3Ir
         wtYpe7dHvvK21Uh6BkZgB3cXzqO53h18sA/JnijcAwcOi2Ha9qghC0njEJDhSE6Y8+kO
         EemcfYFA1T5bvU9GbQYDIkM5dFIEsJG2HO2cf/7NN1uQeucJFhDF/tFzK3xMVK1YRhWr
         4VQly4AEPX+uD405t0Ize0O0RY/YSnPkSpRQNEDx0fLJ960qXuYxvJiSa73QtQjsh0Cj
         8gUA==
X-Forwarded-Encrypted: i=1; AJvYcCXcLtSoGa0edbnAu18t7Cq1d0bsK0VcZ9tkMXEFShnu8br6gxXgN+5ehLhT0gSoxlF9exst301/7BRHq+SxtC7rfFhJAWZlC7LR16ua
X-Gm-Message-State: AOJu0YxLQy+8aQjjVcsG5Km7n/yaZ4DL2gfqNES15S95ZIURt63TybGq
	2+xf/8aSTWLrKnbXGAa04xTHhNv9tZI55dKUJ+yPy6UDXUaY0Cf9OXg2MMUjX20=
X-Google-Smtp-Source: AGHT+IF3ZzVKFkGJ+VUtKrBndnmwatRZPL08zOH6RN9WnQdDr9Ls3ib+LipgfYO/ReGHycUqB83Dhg==
X-Received: by 2002:a05:600c:4f09:b0:413:2a42:8af5 with SMTP id l9-20020a05600c4f0900b004132a428af5mr354027wmq.15.1710269113447;
        Tue, 12 Mar 2024 11:45:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8238:61bd:7273:ad90? ([2a01:e0a:982:cbb0:8238:61bd:7273:ad90])
        by smtp.gmail.com with ESMTPSA id bh25-20020a05600c3d1900b004133365bbc6sm3142712wmb.19.2024.03.12.11.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 11:45:13 -0700 (PDT)
Message-ID: <65d60ed4-e52c-4f98-84e1-4d753e29adfc@linaro.org>
Date: Tue, 12 Mar 2024 19:45:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8650: add support for the
 SM8650-HDK board
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240223-topic-sm8650-upstream-hdk-v1-0-ccca645cd901@linaro.org>
 <20240223-topic-sm8650-upstream-hdk-v1-2-ccca645cd901@linaro.org>
 <8a1b08df-dc44-6f9f-c819-33491308699e@linaro.org>
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
Organization: Linaro Developer Services
In-Reply-To: <8a1b08df-dc44-6f9f-c819-33491308699e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/03/2024 00:26, Vladimir Zapolskiy wrote:
> Hi Neil,
> 
> On 2/23/24 10:52, Neil Armstrong wrote:
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
>>    - For Camera, Sensors and external Display cards
>>      - Compatible with the Linaro Debug board [2]
> 
> what are these [1] and [2] references? Probably there might be some links.

Indeed

> 
>>      - SIM Slot for Modem
>>      - Debug connectors
>>      - 6x On-Board LEDs
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile       |    1 +
>>   arch/arm64/boot/dts/qcom/sm8650-hdk.dts | 1259 +++++++++++++++++++++++++++++++
>>   2 files changed, 1260 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 7d40ec5e7d21..4f48c98451de 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -241,6 +241,7 @@ dtb-$(CONFIG_ARCH_QCOM)    += sm8450-sony-xperia-nagara-pdx224.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += sm8550-hdk.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += sm8550-mtp.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += sm8550-qrd.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)    += sm8650-hdk.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += sm8650-mtp.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += sm8650-qrd.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += x1e80100-crd.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
>> new file mode 100644
>> index 000000000000..cb1e0f569483
> 
> <snip>
> 
>> +
>> +&i2c6 {
>> +    clock-frequency = <400000>;
>> +    status = "okay";
>> +
> 
> <snip>
> 
>> +};
>> +
>> +&i2c3 {
>> +       status = "okay";
>> +
> 
> <snip>
> 
>> +};
> 
> Please change the order of i2c3 and i2c6.

Ack

> 
> <snip>
> 
>> +&pcie_1_phy_aux_clk {
>> +    clock-frequency = <1000>;
>> +};
>> +
> 
> May be put the clock above after &pcie1_phy like in the list of gcc
> source clocks?

Ack
> 
>> +&pcie0 {
>> +    wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
>> +    perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
>> +
>> +    pinctrl-0 = <&pcie0_default_state>;
>> +    pinctrl-names = "default";
>> +
>> +    status = "okay";
>> +};
>> +
>> +&pcie0_phy {
>> +    vdda-phy-supply = <&vreg_l1i_0p88>;
>> +    vdda-pll-supply = <&vreg_l3i_1p2>;
>> +
>> +    status = "okay";
>> +};
>> +
>> +&pcie1 {
>> +    wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
>> +    perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
>> +
>> +    pinctrl-0 = <&pcie1_default_state>;
>> +    pinctrl-names = "default";
>> +
>> +    status = "okay";
>> +};
>> +
>> +&pcie1_phy {
>> +    vdda-phy-supply = <&vreg_l3e_0p9>;
>> +    vdda-pll-supply = <&vreg_l3i_1p2>;
>> +    vdda-qref-supply = <&vreg_l1i_0p88>;
>> +
>> +    status = "okay";
>> +};
>> +
> 
> So I've found just these minor things, and I've successfully tested
> the dtb on the SM8650-HDK board.
> 
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> 
> -- 
> Best wishes,
> Vladimir

Thanks,
Neil

