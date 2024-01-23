Return-Path: <linux-kernel+bounces-34890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E728388E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5308282E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF7756B8F;
	Tue, 23 Jan 2024 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQv+7Y4h"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B79D56B6E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998418; cv=none; b=TS38hCcjmqWrepST9d1AXmdfeqRz+WxhemeGsRxIBg/XoJLm5UwvjVYSiUYlYcEHWvxX/086wJXnMI2cTShmeBI0m8E7LIMedLE2J5060ncvLaey/dwO6gpVzB7XonZ20acdIDWJifc1pTSWgIIlVWGQrRuQBiJGjllFUNv87OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998418; c=relaxed/simple;
	bh=gyBjskUUgyqNv8rwW6zx0rQrf2+nhvIWFtqh6AsHQc4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c0wv1WPA3W2YLYXeH3qCT2dStGoieK9/MFW3ukFNQBZIIjEEnYLLVg/56rD0zeYKlmAF3g5HXNBHfztzNqvyXWGFK9DXLdZ/Ke4/0DGe4xfDepXUyd5vXpmmUKcrXTkLi+UYek3Oo5rUPYWjFLa9OTOtQuXcMbiNUTH5rIzL1eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RQv+7Y4h; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-337cc8e72f5so3705852f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705998415; x=1706603215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1sSwGWy/QrnduCPAoeBshLrsXwnSCbH111QA86hYtAM=;
        b=RQv+7Y4hQHpXKpbWn9pkEM4XC2+4GyD9HEEYDgZTBKUv+f52jlP356dC8+7lzeuPX8
         q54lULGeVyHgPqudsqEmck/u78rK9t/dYcLtxKUdH1UaWu52kS//Rk3lgKzrL6NsNf27
         776zMwzwXrOVRO2elFPLICzuXb2BmgBYlXhfI1gljoB8x1S9TEn5e1z9mnwPt4LS57Dt
         6PtqF/CtmEMi4mu0FFc7WOAxkSvKVZ7VSDFFxYGa8cp0A7oPUFupVUF0lAlNC/9v1GhP
         Wkk3i8pMPNK/REzwW2O49uDU2HpuFfYzFqJ/OEEE9uwP5uJ4X4ucXr8UA+P1o5JcwLzJ
         dhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705998415; x=1706603215;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1sSwGWy/QrnduCPAoeBshLrsXwnSCbH111QA86hYtAM=;
        b=ElJdw8e4PMgN3s+yPHvS847X6lwNydWf1xi/Hsp0dfpOLdnRsxCU0CE5zCJPZVGiAp
         3UX8A1EoPQNqXILniHMtAo/XW7LlupCo0hmeJz1eZOCTTu6BlIrj5AjSxcXhABZD2eBz
         vxmDaLeBSGeQicFPZ3dnqUE3YMja0waU97oBDCahjwBzbKWe8VB32N5hd1KLYabZqtf4
         qMQnHNlrrtrDGjkjBoFq1wR0JYY+IGuPKvZyXfWUPtjbFwum4yFEr+GUIEqCifpjfPUg
         r6cvbd6SK98G/otVb/1KwQ+XnnKZgjxLxQGxrCH5F2JQ0Cldc3MI13mfqsItXAGfx34f
         4AZg==
X-Gm-Message-State: AOJu0YxdotbUC/P9cePX5xJLCkKYb0i4BqG6l/4ooFgfgQTD4WAzvPSy
	zR6TygSRI/Znp9s5jdYCYDoPcZk1CK5dZcDU7hALD9851aI7ZR/3r+ItP1cNY54=
X-Google-Smtp-Source: AGHT+IHKgXV6S+D78FrKjV8f0OQsntHrIAkMRhmBXOvdwwbZanoY848HGqooBbcBwwzIRXDneJXe9Q==
X-Received: by 2002:a5d:6751:0:b0:337:989c:15c with SMTP id l17-20020a5d6751000000b00337989c015cmr3002451wrw.90.1705998414761;
        Tue, 23 Jan 2024 00:26:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:e70d:72be:6c73:25c2? ([2a01:e0a:982:cbb0:e70d:72be:6c73:25c2])
        by smtp.gmail.com with ESMTPSA id f10-20020adfe90a000000b003392c3141a8sm7016192wrm.11.2024.01.23.00.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 00:26:54 -0800 (PST)
Message-ID: <ac81dba8-e58c-45ad-a512-f7af17c1462b@linaro.org>
Date: Tue, 23 Jan 2024 09:26:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8650-qrd: add PM8010 regulators
Content-Language: en-US, fr
To: quic_fenglinw@quicinc.com, kernel@quicinc.com,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com
References: <20240123-sm8650_pm8010_support-v1-0-dec2224d5740@quicinc.com>
 <20240123-sm8650_pm8010_support-v1-2-dec2224d5740@quicinc.com>
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
In-Reply-To: <20240123-sm8650_pm8010_support-v1-2-dec2224d5740@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/01/2024 07:42, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <quic_fenglinw@quicinc.com>
> 
> Add PM8010 regulator device nodes for sm8650-qrd board.
> 
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 118 ++++++++++++++++++++++++++++++++
>   1 file changed, 118 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
> index 592a67a47c78..361894fa201a 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
> @@ -436,6 +436,124 @@ vreg_l3i_1p2: ldo3 {
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

[    2.847268] vreg_l2m_1p056: Setting 1056000-1056000uV
[    2.852186] vreg_l2n_1p056: Setting 1056000-1056000uV
[    2.858879] vreg_l3m_2p8: Setting 2800000-2800000uV
[    2.863483] vreg_l3n_1p8: Setting 1800000-1800000uV
[    2.866798] vreg_l4m_2p8: Setting 2800000-2800000uV
[    2.870018] vreg_l4n_1p8: Setting 1800000-1800000uV
[    2.876182] vreg_l5m_1p8: Setting 1800000-1800000uV
[    2.881297] vreg_l5n_2p8: Setting 2800000-2800000uV
[    2.886532] vreg_l6m_2p8: Setting 2800000-2800000uV
[    2.891332] vreg_l6n_2p8: Setting 2800000-2800000uV
[    2.896519] vreg_l7m_2p96: Setting 2960000-2960000uV
[    2.900919] vreg_l7n_3p3: Setting 3304000-3304000uV


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD

