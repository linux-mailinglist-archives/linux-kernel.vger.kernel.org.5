Return-Path: <linux-kernel+bounces-129235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 971E0896772
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873B01C22B85
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BE567A0D;
	Wed,  3 Apr 2024 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BntT/jyM"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD9C5FB85
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131239; cv=none; b=ms3h55OwXce1EnL6g6hFxl9YJ/FbfHEzTDfISIc4sjligCwxef8hWXZ7xKIP4GhKOak1bEknoKYdePRyN26HA3K4Z+hkDDMXAADdAoFmH6s5j2HRnB17SBtdxl+QMHMVSkV2leETARkI6V0mqL3xhCbAMithjEL11pcsEd+SLcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131239; c=relaxed/simple;
	bh=fkNGNWTAQirXKU/jczzoFhcobOjEN0fJgGwQLfOloP8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IjmI5sxouwwuf6RAHD8yj/vQDPtCVzen9uPHO3wdaebG64Y8tCqpTXrY9XSFwginirVia7mN1jc3APViNO/gujXBAjxwqudHbjuqv2nZjXTiYapv25ewUGBtDgdXzIeu8B8PmurH7HvmcNTu+yhECOavVZlacIYj2DGzG3L7FCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BntT/jyM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-416244fd0a2so1523645e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 01:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712131235; x=1712736035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BRwLTWf4O0ybWAD/Yvp36S8PIHxeBq72kloZfVZMNH4=;
        b=BntT/jyM4u6+yzc5mEsv22pAhd4Q8SNYL5WcDRhnjGWOdlEyG2atrc2bu8I5KAERgK
         iYj0JGHhvqxYR8Jf36KpKJvt1+O7SwZBScHoQ4eV/RyhAiMv4Kz0urBLtKKaR8DVY+Yy
         4rJ8vQH0l90Bv2UcOm9RMbXkJLkQtMD6wOA7lZZYTRESG5QN4HiDbnhgIV1xha28GA+j
         QkhLymqPCzZTN/c5isQcQOjWd7v7hGkyRDq+szSXuFQEVzzPZUqfcAUPOXS9vRs9tjrP
         mw6LbQVt0oNm7GTYJ4O0OvxqhEWwDiRavCvCOsrFmA5PEPLSYpLWI6Fi0PBxj+ZLVFwH
         4TVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131235; x=1712736035;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BRwLTWf4O0ybWAD/Yvp36S8PIHxeBq72kloZfVZMNH4=;
        b=L57pTwtqADAyVPNpvaO7+UK6kFqjJWTSLBRuUkA+QerQ/P6q4sZL+NFDCpEeAzD1ZR
         sE+yoPRujrzeLYwrRRJhy/UEr+/TuI2h1F9HUU2h7HdCytLWwOWnUw46U5EFIHhqEgCM
         64F9SiyG6h/vy5NqAMqVxp/E6z6m5BMihxUWelk28Ogx10mJtBoAeBnfWLuq5LfdMt0O
         seaA43fvlzTO3B+jfjU5auCmGOan5fi3IPS9O2iqwMjvnhuQ4Ctr9uVQ9UAXiHBQitOZ
         UFnOUzsF84dYUidC2TuK9bIyEBfUctand06NR8K2HHH3Ta/VhcVWuxMtsFuZiOS8fu1o
         X0pA==
X-Forwarded-Encrypted: i=1; AJvYcCWunH8zRmcCyytFbdtj3DHMpUZvnYDfFiYBCHaR8ISOIH6DGMa3cnghPpMR4bQG5QK55FIQXlzYPy8w0otnD7oRw9OBxiv+Dmkko5rf
X-Gm-Message-State: AOJu0YxfwCiUHz2vNhHW1VQxzMqTDIvUaGJ/yuGJ4YUyIOZj4PRqa15W
	0DCacd7oIdo1+kHkaPrc4XLMSpV0xnyl7C+l8Wd6pl+VKJjbIwgZGEypiLfSSMo=
X-Google-Smtp-Source: AGHT+IGHdBKRpoLrE20kpQBFVV59xVPT7GyQbCz/fwetW1mY726vnogBStKOLQs3zs/jLCY2CvHKTg==
X-Received: by 2002:a7b:ca46:0:b0:414:9072:98dc with SMTP id m6-20020a7bca46000000b00414907298dcmr14260876wml.41.1712131235129;
        Wed, 03 Apr 2024 01:00:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:d6d:8d9b:bb47:c974? ([2a01:e0a:982:cbb0:d6d:8d9b:bb47:c974])
        by smtp.gmail.com with ESMTPSA id k4-20020a05600c1c8400b00414807ef8dfsm20864581wms.5.2024.04.03.01.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 01:00:34 -0700 (PDT)
Message-ID: <8fea7f0e-ae45-4000-994e-6cf9170fbd32@linaro.org>
Date: Wed, 3 Apr 2024 10:00:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sm8550: Add support for Samsung
 Galaxy Z Fold5
To: serdeliuk@yahoo.com, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240331-samsung-galaxy-zfold5-q5q-v3-0-17ae8d0a9fba@yahoo.com>
 <20240331-samsung-galaxy-zfold5-q5q-v3-2-17ae8d0a9fba@yahoo.com>
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
In-Reply-To: <20240331-samsung-galaxy-zfold5-q5q-v3-2-17ae8d0a9fba@yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 31/03/2024 12:56, Alexandru Marc Serdeliuc via B4 Relay wrote:
> From: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
> 
> Add support for Samsung Galaxy Z Fold5 (q5q) foldable phone based on sm8550
> 
> Currently working features:
> - Framebuffer
> - UFS
> - i2c
> - Buttons
> 
> Signed-off-by: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
> ---
>   arch/arm64/boot/dts/qcom/Makefile               |   1 +
>   arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts | 582 ++++++++++++++++++++++++
>   2 files changed, 583 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 7d40ec5e7d21..a7503fd35b6c 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -241,6 +241,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx224.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-hdk.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-mtp.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-qrd.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-samsung-q5q.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-mtp.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-qrd.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-crd.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts b/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
> new file mode 100644
> index 000000000000..6619ed00c350
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
> @@ -0,0 +1,582 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2024, Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
> + * Copyright (c) 2024, David Wronek <david@mainlining.org>
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "sm8550.dtsi"
> +#include "pm8550.dtsi"
> +#include "pm8550vs.dtsi"
> +#include "pmk8550.dtsi"
> +
> +/ {
> +	model = "Samsung Galaxy Z Fold5";
> +	compatible = "samsung,q5q", "qcom,sm8550";
> +	chassis-type = "handset";
> +
> +	aliases {
> +		serial0 = &uart7;
> +	};
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer: framebuffer@b8000000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0x0 0xb8000000 0x0 0x2b00000>;
> +			width = <2176>;
> +			height = <1812>;
> +			stride = <(2176 * 4)>;
> +			format = "a8r8g8b8";
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&volume_up_n>;
> +		pinctrl-names = "default";
> +
> +		key-volume-up {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			gpios = <&pm8550_gpios 6 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +			wakeup-source;
> +		};
> +	};
> +
> +	vph_pwr: vph-pwr-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	reserved-memory {
> +		/*
> +		 * The bootloader will only keep display hardware enabled
> +		 * if this memory region is named exactly 'splash_region'
> +		 */
> +		splash_region@b8000000 {
> +			reg = <0x0 0xb8000000 0x0 0x2b00000>;
> +			no-map;
> +		};
> +	};
> +};
> +
> +&apps_rsc {
> +	regulators-0 {
> +		compatible = "qcom,pm8550-rpmh-regulators";
> +		qcom,pmic-id = "b";
> +
> +		vreg_bob1: bob1 {
> +			regulator-name = "vreg_bob1";
> +			regulator-min-microvolt = <3296000>;
> +			regulator-max-microvolt = <3960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_bob2: bob2 {
> +			regulator-name = "vreg_bob2";
> +			regulator-min-microvolt = <2720000>;
> +			regulator-max-microvolt = <3960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1b_1p8: ldo1 {
> +			regulator-name = "vreg_l1b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2b_3p0: ldo2 {
> +			regulator-name = "vreg_l2b_3p0";
> +			regulator-min-microvolt = <3008000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l5b_3p1: ldo5 {
> +			regulator-name = "vreg_l5b_3p1";
> +			regulator-min-microvolt = <3104000>;
> +			regulator-max-microvolt = <3104000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6b_1p8: ldo6 {
> +			regulator-name = "vreg_l6b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7b_1p8: ldo7 {
> +			regulator-name = "vreg_l7b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l8b_1p8: ldo8 {
> +			regulator-name = "vreg_l8b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l9b_2p9: ldo9 {
> +			regulator-name = "vreg_l9b_2p9";
> +			regulator-min-microvolt = <2960000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l11b_1p2: ldo11 {
> +			regulator-name = "vreg_l11b_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1504000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l12b_1p8: ldo12 {
> +			regulator-name = "vreg_l12b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l13b_3p0: ldo13 {
> +			regulator-name = "vreg_l13b_3p0";
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l14b_3p2: ldo14 {
> +			regulator-name = "vreg_l14b_3p2";
> +			regulator-min-microvolt = <3200000>;
> +			regulator-max-microvolt = <3200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l15b_1p8: ldo15 {
> +			regulator-name = "vreg_l15b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +			regulator-always-on;
> +		};
> +
> +		vreg_l16b_2p8: ldo16 {
> +			regulator-name = "vreg_l16b_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l17b_2p5: ldo17 {
> +			regulator-name = "vreg_l17b_2p5";
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <2504000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-1 {
> +		compatible = "qcom,pm8550vs-rpmh-regulators";
> +		qcom,pmic-id = "c";
> +
> +		vreg_l3c_0p91: ldo3 {
> +			regulator-name = "vreg_l3c_0p9";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-2 {
> +		compatible = "qcom,pm8550vs-rpmh-regulators";
> +		qcom,pmic-id = "d";
> +
> +		vreg_l1d_0p88: ldo1 {
> +			regulator-name = "vreg_l1d_0p88";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-3 {
> +		compatible = "qcom,pm8550vs-rpmh-regulators";
> +		qcom,pmic-id = "e";
> +
> +		vreg_s4e_0p9: smps4 {
> +			regulator-name = "vreg_s4e_0p9";
> +			regulator-min-microvolt = <904000>;
> +			regulator-max-microvolt = <984000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s5e_1p1: smps5 {
> +			regulator-name = "vreg_s5e_1p1";
> +			regulator-min-microvolt = <1080000>;
> +			regulator-max-microvolt = <1120000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1e_0p88: ldo1 {
> +			regulator-name = "vreg_l1e_0p88";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2e_0p9: ldo2 {
> +			regulator-name = "vreg_l2e_0p9";
> +			regulator-min-microvolt = <904000>;
> +			regulator-max-microvolt = <970000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3e_1p2: ldo3 {
> +			regulator-name = "vreg_l3e_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-4 {
> +		compatible = "qcom,pm8550ve-rpmh-regulators";
> +		qcom,pmic-id = "f";
> +
> +		vreg_s4f_0p5: smps4 {
> +			regulator-name = "vreg_s4f_0p5";
> +			regulator-min-microvolt = <500000>;
> +			regulator-max-microvolt = <700000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1f_0p9: ldo1 {
> +			regulator-name = "vreg_l1f_0p9";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2f_0p88: ldo2 {
> +			regulator-name = "vreg_l2f_0p88";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3f_0p91: ldo3 {
> +			regulator-name = "vreg_l3f_0p91";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-5 {
> +		compatible = "qcom,pm8550vs-rpmh-regulators";
> +		qcom,pmic-id = "g";
> +
> +		vreg_s1g_1p2: smps1 {
> +			regulator-name = "vreg_s1g_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1300000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s2g_0p8: smps2 {
> +			regulator-name = "vreg_s2g_0p8";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <1000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s3g_0p7: smps3 {
> +			regulator-name = "vreg_s3g_0p7";
> +			regulator-min-microvolt = <300000>;
> +			regulator-max-microvolt = <1004000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s4g_1p3: smps4 {
> +			regulator-name = "vreg_s4g_1p3";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1352000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s5g_0p8: smps5 {
> +			regulator-name = "vreg_s5g_0p8";
> +			regulator-min-microvolt = <500000>;
> +			regulator-max-microvolt = <1004000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s6g_1p8: smps6 {
> +			regulator-name = "vreg_s6g_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1g_1p2: ldo1 {
> +			regulator-name = "vreg_l1g_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2g_1p2: ldo2 {
> +			regulator-name = "vreg_l2g_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3g_1p2: ldo3 {
> +			regulator-name = "vreg_l3g_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-6 {
> +		compatible = "qcom,pm8010-rpmh-regulators";
> +		qcom,pmic-id = "m";
> +
> +		vreg_l1m_1p056: ldo1 {
> +			regulator-name = "vreg_l1m_1p056";
> +			regulator-min-microvolt = <1056000>;
> +			regulator-max-microvolt = <1056000>;
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
> +		vreg_l6m_1p8: ldo6 {
> +			regulator-name = "vreg_l6m_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7m_2p9: ldo7 {
> +			regulator-name = "vreg_l7m_2p9";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2904000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-7 {
> +		compatible = "qcom,pm8010-rpmh-regulators";
> +		qcom,pmic-id = "n";
> +
> +		vreg_l1n_1p1: ldo1 {
> +			regulator-name = "vreg_l1n_1p1";
> +			regulator-min-microvolt = <1104000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2n_1p1: ldo2 {
> +			regulator-name = "vreg_l2n_1p1";
> +			regulator-min-microvolt = <1104000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3n_2p8: ldo3 {
> +			regulator-name = "vreg_l3n_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <3000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4n_2p8: ldo4 {
> +			regulator-name = "vreg_l4n_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l5n_1p8: ldo5 {
> +			regulator-name = "vreg_l5n_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6n_3p3: ldo6 {
> +			regulator-name = "vreg_l6n_3p3";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <3304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7n_2p96: ldo7 {
> +			regulator-name = "vreg_l7n_2p96";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +};
> +
> +

Spurious blank line

> +&dispcc {
> +	status = "disabled";
> +};
> +
> +&i2c_master_hub_0 {
> +	status = "okay";
> +};
> +
> +&pcie_1_phy_aux_clk {
> +	clock-frequency = <1000>;
> +};
> +

Please rebase on https://lore.kernel.org/all/20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-6-3ec0a966d52f@linaro.org/ and drop this

> +&pcie0 {
> +	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
> +	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
> +	pinctrl-0 = <&pcie0_default_state>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&pcie0_phy {
> +	vdda-phy-supply = <&vreg_l1e_0p88>;
> +	vdda-pll-supply = <&vreg_l3e_1p2>;
> +	status = "okay";
> +};
> +
> +&pcie1 {
> +	wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
> +	perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
> +	pinctrl-0 = <&pcie1_default_state>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&pcie1_phy {
> +	vdda-phy-supply = <&vreg_l3c_0p91>;
> +	vdda-pll-supply = <&vreg_l3e_1p2>;
> +	vdda-qref-supply = <&vreg_l1e_0p88>;
> +	status = "okay";
> +};

Is the second PCIe bus really used ?

> +
> +&pm8550_gpios {
> +	volume_up_n: volume-up-n-state {
> +		pins = "gpio6";
> +		function = "normal";
> +		power-source = <1>;
> +		bias-pull-up;
> +		input-enable;
> +	};
> +};
> +
> +&pon_pwrkey {
> +	status = "okay";
> +};
> +
> +&pon_resin {
> +	status = "okay";
> +	linux,code = <KEY_VOLUMEDOWN>;
> +};
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&remoteproc_adsp {
> +	firmware-name = "qcom/sm8550/adsp.mbn",
> +			"qcom/sm8550/adsp_dtb.mbn";
> +	status = "okay";
> +};
> +
> +&remoteproc_cdsp {
> +	firmware-name = "qcom/sm8550/cdsp.mbn",
> +			"qcom/sm8550/cdsp_dtb.mbn";
> +	status = "okay";
> +};
> +
> +&remoteproc_mpss {
> +	firmware-name = "qcom/sm8550/modem.mbn",
> +			"qcom/sm8550/modem_dtb.mbn";
> +	status = "okay";
> +};
> +
> +&sleep_clk {
> +	clock-frequency = <32000>;
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <36 4>, <50 2>;
> +};
> +
> +&ufs_mem_hc {
> +	reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
> +	vcc-supply = <&vreg_l17b_2p5>;
> +	vcc-max-microamp = <1300000>;
> +	vccq-supply = <&vreg_l1g_1p2>;
> +	vccq-max-microamp = <1200000>;
> +	vdd-hba-supply = <&vreg_l3g_1p2>;
> +	status = "okay";
> +};
> +
> +&ufs_mem_phy {
> +	vdda-phy-supply = <&vreg_l1d_0p88>;
> +	vdda-pll-supply = <&vreg_l3e_1p2>;
> +	status = "okay";
> +};
> +
> +&xo_board {
> +	clock-frequency = <76800000>;
> +};
> 

Thanks,
Neil

