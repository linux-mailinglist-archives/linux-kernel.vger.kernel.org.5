Return-Path: <linux-kernel+bounces-34893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E23BF8388E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9362F282D01
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0AC58124;
	Tue, 23 Jan 2024 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HcJaLV5R"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6F857327
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998423; cv=none; b=GyZ6QN4KIp93fgbQDBSCjufh7Yh+ALDi7r3HpoA733A7s4CrDJvZ+3dCnryN3b45eEsPu5ZLc8Y58xApBuDCXbmRWY5+j8nsnTf1IOju0+JzhKGP12NLinrtOZJlzo2l2vJkyphRz00DNV2IBRsXKi1AdjKMNT/NDuucfk8zXWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998423; c=relaxed/simple;
	bh=hOzajdIbPUvogAB4a+NHcHPIBtoNpA8D53bdCFuXjwk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=t40AS6fKreS0RjNsLwUev86/OKs6rGCT2LstX6D0AfzE9OXnxPheEQfIc5KNP8aK2K2T6up3IMBPqrlZtuJ2A6wTyrlFM6WnxH/jqDrKZi9+h6bHMqakDHaG+XnzFmgp7uZkdkP+h4u14sZZkXm/ScVzeAQxuXw5ubKgGkbpwZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HcJaLV5R; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3392b045e0aso2404515f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705998420; x=1706603220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAph0qO9sNSpveQZgrpubslobSSKkmBrDs3KCa8HQ+M=;
        b=HcJaLV5RFg/kSXXu29GaD8VXODAQ58mMlMla20t26OJhF4q7XCHrb8034zdjQcarr1
         8j21TTjSpNkaw47/nWDcm/WvdUeuYL/0CModBOYptnrJZwn7zJpEqKB3wtmHzWs3GFEM
         4Z29HF/kmVoKBzlVahUZd0IGhNHc5P7YONysYF6q5M8ndubc4Nju6S2RxSRgf1qSemI7
         Z63aj+L0ywHpkqUWO/zsrROdel5vG2U3GMxqnIju7JRTmqb0TJb1G4tXlUiyHEnF2J3s
         C7PLUiFktNw4UKt3SXWMRRNKs28vJTAnc8nX+p/gBMzTYjdDEckMkyAH1nVS0FNfSQ0+
         xPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705998420; x=1706603220;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EAph0qO9sNSpveQZgrpubslobSSKkmBrDs3KCa8HQ+M=;
        b=sDkaOPTUHZeAgCKOILVGIvFfsL0LHxmJ+ceO1uBUnQnJoO9NusWhIyssWpAcji+CZz
         3lVxqNR8s32YtsqQTDUTMFTLajrkF5tQ5Plb0SwBsTlnPkXaJAjjUEVM0y/ukv5VQ3hm
         8ZE/ZzFfI9t6J57qYg6cSa27f62ri9ABno2oTQtdTxt3SJitI5cL87F+RhXAvavgw8Jo
         vxIb5TtSfMxjYx9Hl8ehAQzpNN5vuqJWFKVh6wF7RW1wx0F4VlTvqubNlUijme1doetm
         ukBxDDNaoALk956iNcOau3Tnei1rtoQTNxJ12/FB/gtusi1HC1zfeV/6KStKgNbl49nJ
         XFLw==
X-Gm-Message-State: AOJu0Yy+ietg8zxsvExTSkktLjWmwVArR9hF2mKiL+G7IHvQActzKZPQ
	rg4EiVN1IK7K+zlXbe9MOr7bLc75/iJjAMbKlTO3buziB/zSX6devdWyndQ7y2A=
X-Google-Smtp-Source: AGHT+IGaXeK8SOUX6knHj2BfjvB4E5Y7g/FV3ibLaVxRfSPNAUqt0fIOvo+HheGFEQJaw1OyGoXhBg==
X-Received: by 2002:adf:ffcd:0:b0:337:be0b:766e with SMTP id x13-20020adfffcd000000b00337be0b766emr3211904wrs.63.1705998419968;
        Tue, 23 Jan 2024 00:26:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:e70d:72be:6c73:25c2? ([2a01:e0a:982:cbb0:e70d:72be:6c73:25c2])
        by smtp.gmail.com with ESMTPSA id f10-20020adfe90a000000b003392c3141a8sm7016192wrm.11.2024.01.23.00.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 00:26:59 -0800 (PST)
Message-ID: <5a4b3712-2af4-491e-8a64-2916d87071fc@linaro.org>
Date: Tue, 23 Jan 2024 09:26:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8650-mtp: add PM8010 regulators
Content-Language: en-US, fr
To: quic_fenglinw@quicinc.com, kernel@quicinc.com,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com
References: <20240123-sm8650_pm8010_support-v1-0-dec2224d5740@quicinc.com>
 <20240123-sm8650_pm8010_support-v1-1-dec2224d5740@quicinc.com>
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
In-Reply-To: <20240123-sm8650_pm8010_support-v1-1-dec2224d5740@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/01/2024 07:42, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <quic_fenglinw@quicinc.com>
> 
> Add PM8010 regulator device nodes for sm8650-mtp board.
> 
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sm8650-mtp.dts | 118 ++++++++++++++++++++++++++++++++
>   1 file changed, 118 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
> index 9d916edb1c73..3791971efee6 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
> @@ -428,6 +428,124 @@ vreg_l3i_1p2: ldo3 {
>   						   RPMH_REGULATOR_MODE_HPM>;
>   		};
>   	};
> +
> +	regulators-6 {
> +		compatible = "qcom,pm8010-rpmh-regulators";
> +		qcom,pmic-id = "m";
> +
> +		vdd-l1-l2-supply = <&vreg_s1c_1p2>;
> +		vdd-l3-l4-supply = <&vreg_bob2>;
> +		vdd-l5-supply = <&vreg_s6c_1p8>;
> +		vdd-l6-l7-supply = <&vreg_bob1>;
> +
> +		vreg_l1m_1p1: ldo1 {
> +			regulator-name = "vreg_l1m_1p1";
> +			regulator-min-microvolt = <1104000>;
> +			regulator-max-microvolt = <1104000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2m_1p056: ldo2 {
> +			regulator-name = "vreg_l2m_1p056";
> +			regulator-min-microvolt = <1056000>;
> +			regulator-max-microvolt = <1056000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3m_2p8: ldo3 {
> +			regulator-name = "vreg_l3m_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4m_2p8: ldo4 {
> +			regulator-name = "vreg_l4m_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l5m_1p8: ldo5 {
> +			regulator-name = "vreg_l5m_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6m_2p8: ldo6 {
> +			regulator-name = "vreg_l6m_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7m_2p96: ldo7 {
> +			regulator-name = "vreg_l7m_2p96";
> +			regulator-min-microvolt = <2960000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-7 {
> +		compatible = "qcom,pm8010-rpmh-regulators";
> +		qcom,pmic-id = "n";
> +
> +		vdd-l1-l2-supply = <&vreg_s1c_1p2>;
> +		vdd-l3-l4-supply = <&vreg_s6c_1p8>;
> +		vdd-l5-l6-supply = <&vreg_bob2>;
> +		vdd-l7-supply = <&vreg_bob1>;
> +
> +		vreg_l1n_1p1: ldo1 {
> +			regulator-name = "vreg_l1n_1p1";
> +			regulator-min-microvolt = <1104000>;
> +			regulator-max-microvolt = <1104000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2n_1p056: ldo2 {
> +			regulator-name = "vreg_l2n_1p056";
> +			regulator-min-microvolt = <1056000>;
> +			regulator-max-microvolt = <1056000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3n_1p8: ldo3 {
> +			regulator-name = "vreg_l3n_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4n_1p8: ldo4 {
> +			regulator-name = "vreg_l4n_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l5n_2p8: ldo5 {
> +			regulator-name = "vreg_l5n_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6n_2p8: ldo6 {
> +			regulator-name = "vreg_l6n_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7n_3p3: ldo7 {
> +			regulator-name = "vreg_l7n_3p3";
> +			regulator-min-microvolt = <3304000>;
> +			regulator-max-microvolt = <3304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
>   };
>   
>   &dispcc {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

