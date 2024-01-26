Return-Path: <linux-kernel+bounces-40665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0959083E3D4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897DE1F25550
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C011824A02;
	Fri, 26 Jan 2024 21:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tnDNMgYd"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E09249F5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 21:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706304054; cv=none; b=lrl+WeqkecE/L0VOttbGzzmfBWgd67L2rwuCuRel9NEQArx2wUjj2Md97RlSZl7QfK/vh/iYLSZ00O0FUY/p+OyYuq3fzXipiloMWiB7fYE4u3wlNuCTjZkW8YYET4oGcno/PSVs4ivBLUScmwjbB9Y85/Aa1afpTlrwnXYJLTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706304054; c=relaxed/simple;
	bh=li0J15xsdzoQMYSfgqZD+7xj6XkdotMlIQR8ht0mUpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SzcMZTfPuuOaK3AqMX3HLv7m84Tn1iQXXx28dgqSJymf8c/ulRvVB0U3c8TS2ikEnFsy7CTlW4fKGlvDcml5GyRlsBtOupUr9A/um6ztxYg65QNInHe8MhYlywAKl18+7+O6Dwyn2qBXz0RrF63xuKDIqlkSLP1sNXxs4k9VGpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tnDNMgYd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40eb033c1b0so13200995e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706304051; x=1706908851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ckLdbkYosqR4Batu5HIoSckjmeDoA5OjOfUTS7alHpg=;
        b=tnDNMgYdXyWh0MiP4DjYXiHERnfiVrBYaVy3DNE/8kbw4RV+QQE8CFzCjCQQuf9lgs
         2okP3Q8ZDUxpyXMps0qPhrfEaYdV/CNyf57DcF9noRKlNqT6OJJwa7ZA44xV2z0pd288
         DmLGuqxn++cEU1tNsoVoe/9ZnTVaPG6jLK7+sU8JCvKVPnc+FCqlenzqRtDzQaKx/mDh
         x9l7MGOHsBZdaiu/0yDRho8n3FQbVVevXlsAiHwltkHKl6ChIyT5CMAI3Wb2FEOnwCJC
         xaodCevnMkFQukMaqlos/ocX35ofNzapPEJohZ+Nd7vRLwD1Ljp3SKm67uB1qIQsJDp2
         EIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706304051; x=1706908851;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckLdbkYosqR4Batu5HIoSckjmeDoA5OjOfUTS7alHpg=;
        b=skvZSwGU5D69N63qxxFbo5G62TA0tb8HuP+YICfBBZRdUctKObhQKD0k8cWRU+EvRQ
         qOq2+37/lyx3drCeZif4jpKT//b4WR7vN8Ey94FaEwunDRXJvsQK5nxVRR4DWTKBQJqS
         Z0aQub0b4CRt3ZnLbjFkT+4CtVOGH+h9PYpAuCkwPGh90sjoArSwvBE2EjEER7xemzIr
         Sxzg68JUyiG+/pVhHDA/IQtTP+WaFKSg1GgivE9ND3qcnDjx7HRVKvKNJ3/dT4NGiyk3
         9jbMlrbwDdKDFeXMbsougCP4vfU46UZ+3CwnqnVkFVJlFIW/KXbG7L5jdFqhTCLxCY5x
         HWHg==
X-Gm-Message-State: AOJu0Yw/d19XBUO+ZTqARRXakytwi2oKAV5K3G8pfnbR6Lg2ReY/kvNf
	+u8Wu+lb5QjAQbjJrw7f80uTkRv0bX6XlHomJpwuXvDNbmDRrUMKF7L49b2zc9U=
X-Google-Smtp-Source: AGHT+IFWnVaV/VRp7Y5n09XhjbL3qsH+jvvcN81KHkbuPDQHoIiucel4O1eWjYMAYLhSs0rXQsy6Xg==
X-Received: by 2002:a05:600c:4f13:b0:40e:df1c:cf1 with SMTP id l19-20020a05600c4f1300b0040edf1c0cf1mr295035wmq.135.1706304051180;
        Fri, 26 Jan 2024 13:20:51 -0800 (PST)
Received: from [192.168.231.132] (178235179146.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.146])
        by smtp.gmail.com with ESMTPSA id ef14-20020a05640228ce00b0055d18d6a586sm972863edb.13.2024.01.26.13.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 13:20:50 -0800 (PST)
Message-ID: <566a10b0-a7dc-42f3-9b8c-f9acd8d3a22c@linaro.org>
Date: Fri, 26 Jan 2024 22:20:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: sc8280xp: Introduce additional tsens
 instances
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
References: <20240126-sc8280xp-tsens2_3-v2-1-8504d18828de@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240126-sc8280xp-tsens2_3-v2-1-8504d18828de@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.01.2024 16:12, Bjorn Andersson wrote:
> The SC8280XP contains two additional tsens instances, providing among
> other things thermal measurements for the GPU.
> 
> Add these and a GPU thermal-zone.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> Changes in v2:
> - Drop TM/SROT comments
> - Remove polling delays, rely on interrupts
> - Link to v1: https://lore.kernel.org/r/20240118-sc8280xp-tsens2_3-v1-1-e86bce14f6bf@quicinc.com
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 37 ++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index febf28356ff8..7bfbb1bd8f4a 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -4033,6 +4033,28 @@ tsens1: thermal-sensor@c265000 {
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> +		tsens2: thermal-sensor@c251000 {
> +			compatible = "qcom,sc8280xp-tsens", "qcom,tsens-v2";
> +			reg = <0 0x0c251000 0 0x1ff>,
> +			      <0 0x0c224000 0 0x8>;
> +			#qcom,sensors = <11>;
> +			interrupts-extended = <&pdc 122 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&pdc 124 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "uplow", "critical";
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens3: thermal-sensor@c252000 {
> +			compatible = "qcom,sc8280xp-tsens", "qcom,tsens-v2";
> +			reg = <0 0x0c252000 0 0x1ff>,
> +			      <0 0x0c225000 0 0x8>;
> +			#qcom,sensors = <5>;
> +			interrupts-extended = <&pdc 123 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&pdc 125 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "uplow", "critical";
> +			#thermal-sensor-cells = <1>;

With the sorting issue that Johan mentioned resolved:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

