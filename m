Return-Path: <linux-kernel+bounces-106305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7894387EC31
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1A02809E0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BF54F5EC;
	Mon, 18 Mar 2024 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cLXsB8H4"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A904F1FE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775829; cv=none; b=mAvNdFVU9X2K3KfsLM3rVz8aL+qmLeKIUWRozkEHvcfeH0czaA+uAMKEeyf9m7OfFF/83JB8h3RHN/CgzwS95najpX6T9PLUBAOkkqtNuMBc+kwwZNNA5Tf1S/g5MhfBPXkVZjnjEtcee2TMY+ITCmhCvDw2pD5t0mIplT5MRAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775829; c=relaxed/simple;
	bh=9ttNpHLNHVB5SH+295amwQekMvFSDrUFuqdRogaB4hU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FBtx/7WDK7ftUOME+5ISB9szR7yM3JyHp7/gInI0yzAZmvGdcPEhfLEwMCR7IMShICq0PzH3yUmrtMOrLIuI5PD6Fwt9Ptsv2FfRrVC5Z4rcgekKrA4irFxPxbrVNl/segzvUoqgnJ7zz314vb/3/At67tW0hZkdtG6VW90BXnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cLXsB8H4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41460512c25so2920685e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710775826; x=1711380626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hvkZMpuU/BxP5fokIc7kS/rTPDyW8R0hs8/rMgw1XDM=;
        b=cLXsB8H4xIao+yQZ0sbt+6KpiTGehUnVD1XZ2D310ImvBV8sCq9KoNlckKbZkyHJOS
         jMTFL3EIekzlaq9nHyNg5Q8nGLhmvT4ov/l2t7ZATyoqlXgmv521JNCMR1YGOotVfUp+
         urHT87XXsrcrcUwhthQM5/bFuuIDELQrv0dkHcLpYylSdZ64uTQ/8Q1rafr53VF/UyXC
         pXulnsvoT1WUOZsYo5Z5R8fhxefzUzmzxsbdm2BFThCLWs884xEy+b1Z+IwCYMVbTFsV
         2LYdWzkRK0+N/2seshMDuEVx+2dszn2GwAJxpxhX4qJGw+tLruk/LUt3Dw1xlYBUV+Y0
         l57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710775826; x=1711380626;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hvkZMpuU/BxP5fokIc7kS/rTPDyW8R0hs8/rMgw1XDM=;
        b=R4M+VRMqX4lBFK+U82GYT8K6d3RyP4oUnli5kjvtw/zbxt8JptgrnkeLZ8CM6lyWUb
         jEOVsjaLZeJD3OLrvCqysHNOk3pwUS378k6datE1b6RsUe36JHcpgqDsFvVDk5H9fZ9p
         n/4Cj1cEdyxgUQoE+NfxNaZ2HKvOqrgi85z9rzGPd2nedsMPBEn/sxIi3sCeq5WXqgaC
         Kwh+m4hkC/nbKVa0oXLuBtELOv07sjTRCEBTRljeF9c5i99h2P01ceuG+3JeF/2wySuQ
         zFnjsMeF/bgdxaKKGVB9EvNSRXKzCJ7y7FrEGPPzy1wCH0594j9KebHIDW8ok8ocFDtl
         J2HA==
X-Forwarded-Encrypted: i=1; AJvYcCUPLgPWacrSY8apgPJWaTfE4y8EAyiQg+kBdbcxoE/KtmZs8rCitP/mibdZoW7NqJ319rAuvTRMAPxl/D8ndR+o+vftAGmME2DQ8RaQ
X-Gm-Message-State: AOJu0YyN1lMMsApcDbFK2RWNhT64r7IQgczHB5OpoRdPTGLhSlX0xlzQ
	njjSI1B5hvhukJdOXg11pekEH1Bj/5ueKt/nk8+jMshqGTkU69z93mP0PcT9QJUiSc3LIyilZg5
	JbH4=
X-Google-Smtp-Source: AGHT+IG65Iiy+t7CKXPc9JmLj5cwjFxDw7a7LwVVfZZIKCacwhyyxjQIoSpC43mpT0Ju+4J6mdd9DA==
X-Received: by 2002:a05:600c:3556:b0:412:beee:36b3 with SMTP id i22-20020a05600c355600b00412beee36b3mr7825440wmq.7.1710775825906;
        Mon, 18 Mar 2024 08:30:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ad2b:a316:59d9:3dbc? ([2a01:e0a:982:cbb0:ad2b:a316:59d9:3dbc])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c450600b004133365bbc6sm18280915wmo.19.2024.03.18.08.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 08:30:25 -0700 (PDT)
Message-ID: <11cecb76-dbbe-417c-824b-85cff556f304@linaro.org>
Date: Mon, 18 Mar 2024 16:30:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm8650: add support for the
 SM8650-HDK board
Content-Language: en-US, fr
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
References: <20240318-topic-sm8650-upstream-hdk-v2-0-b63a5d45a784@linaro.org>
 <20240318-topic-sm8650-upstream-hdk-v2-2-b63a5d45a784@linaro.org>
 <aylnxuyqkf2ikotqwqylpvuojiwkkxgnjrjx3d2ocoo6vqngih@bfpkmov5cdg6>
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
In-Reply-To: <aylnxuyqkf2ikotqwqylpvuojiwkkxgnjrjx3d2ocoo6vqngih@bfpkmov5cdg6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/03/2024 15:43, Bjorn Andersson wrote:
> On Mon, Mar 18, 2024 at 10:51:54AM +0100, Neil Armstrong wrote:
> [..]
>> diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
> [..]
>> +	vph_pwr: vph-pwr-regulator {
>> +		compatible = "regulator-fixed";
>> +
>> +		regulator-name = "vph_pwr";
>> +		regulator-min-microvolt = <3700000>;
>> +		regulator-max-microvolt = <3700000>;
>> +
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
>> +
>> +	vreg_bob_3v3: regulator-vreg-bob-3v3 {
> 
> It would be nice if these nodes where sorted alphabetically.

damn, ok

> 
>> +		compatible = "regulator-fixed";
>> +
>> +		regulator-name = "VREG_BOB_3P3";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +
>> +		vin-supply = <&vph_pwr>;
>> +	};
>> +
>> +	wcd939x: audio-codec {
>> +		compatible = "qcom,wcd9395-codec", "qcom,wcd9390-codec";
>> +
>> +		pinctrl-0 = <&wcd_default>;
>> +		pinctrl-names = "default";
>> +
>> +		qcom,micbias1-microvolt = <1800000>;
>> +		qcom,micbias2-microvolt = <1800000>;
>> +		qcom,micbias3-microvolt = <1800000>;
>> +		qcom,micbias4-microvolt = <1800000>;
>> +		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
>> +		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
>> +		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
>> +		qcom,rx-device = <&wcd_rx>;
>> +		qcom,tx-device = <&wcd_tx>;
>> +
>> +		reset-gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
>> +
>> +		vdd-buck-supply = <&vreg_l15b_1p8>;
>> +		vdd-rxtx-supply = <&vreg_l15b_1p8>;
>> +		vdd-io-supply = <&vreg_l15b_1p8>;
>> +		vdd-mic-bias-supply = <&vreg_bob1>;
>> +
>> +		#sound-dai-cells = <1>;
>> +	};
>> +};
> [..]
>> +&mdss_mdp {
>> +	status = "okay";
> 
> On other platforms we left status = okay on the mdp child node, as it's
> pretty rare that you want mdss okay, but mdp disabled...

Sure, but this is quite unrelated to HDK

> 
>> +};
>> +
>> +&pcie0 {
>> +	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
>> +	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
>> +
>> +	pinctrl-0 = <&pcie0_default_state>;
>> +	pinctrl-names = "default";
>> +
>> +	status = "okay";
>> +};
>> +
>> +&pcie0_phy {
>> +	vdda-phy-supply = <&vreg_l1i_0p88>;
>> +	vdda-pll-supply = <&vreg_l3i_1p2>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&pcie1 {
>> +	wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
>> +	perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
>> +
>> +	pinctrl-0 = <&pcie1_default_state>;
>> +	pinctrl-names = "default";
>> +
>> +	status = "okay";
>> +};
>> +
>> +&pcie1_phy {
>> +	vdda-phy-supply = <&vreg_l3e_0p9>;
>> +	vdda-pll-supply = <&vreg_l3i_1p2>;
>> +	vdda-qref-supply = <&vreg_l1i_0p88>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&pcie_1_phy_aux_clk {
>> +	clock-frequency = <1000>;
> 
> Is that so?

This is how the pcie_1_phy_aux_clk was documented on SM8550 and SM8650
and downstream uses the same clock-frequency.

Neil
> 
>> +};
>> +
> 
> Regards,
> Bjorn


