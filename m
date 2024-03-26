Return-Path: <linux-kernel+bounces-119952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5F988CF5A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14F51C67446
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DBB12B151;
	Tue, 26 Mar 2024 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oPDGCwdr"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E383E12AAF7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486027; cv=none; b=p29BPsGW8gbdYbJfxAS2OumfMxjmgTq2usXPScYfoA3fSo4E0alksaz9yeNk95pnMKqfPXm9+pFRHT9BuR63HCof8HzuGZPmi/4MBHkwcicve91HvYdcB8orruQTTZaTVxC8Q9JR2fhbWQpZgF3kpcnZUiXOQFTzpTfDfOd3PWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486027; c=relaxed/simple;
	bh=uNSS8OeKjTPm6oEJ3i7K+QOQIGEd2JgO4lb41gv8RNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HeHssxKghPST4yNirecnhBl0HPy4iTzdr7ZVHjTzvh/6DvkZeNR3CwKgPp7/FY0QZV9k2GGY/WhOqoIUUK0U5VLLZ+PT5ZlijKMJaP4SyN5UpVxt2DeYfPbPhd7kN2pX9vharP6K7K1BKprqe6MvrskWdqRplNuDFED6bc+tXOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oPDGCwdr; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-515a97846b5so3280851e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711486024; x=1712090824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dbNLbXj4wxFVMaesPfHoigxn1O2SIlJbMIzmZQ+voWs=;
        b=oPDGCwdraiitK3jVgpU5O9WVSVCt2H6JDH4Kgrh7sCBv6KxSfbCzS0AuwWT5gkFOkx
         K3BHQdMRCNFOChFqZijIHYlmededRqoVPRc9f76ZJOrPWHV49q1mfpFL58xyg1J/iCiC
         TumriEtvg+/Rr868jdsxokB/ZDAscLrGT4d0ArTiaCq/yFrvV00ennJDsxDFdMkhtVtO
         H8tWTmwpAvbeNGeY5VnBVTH/A9g0AlsRa2CyAIAEnXKV9GLun1vTqxoIMh3BmCrc3SHD
         x3Nt0+ufRAyNA8Wv/rFeITz6yfeDnhEEMF0aJvaff8VVn+GMCiCOQy1ubB56hIxOym3n
         lEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711486024; x=1712090824;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbNLbXj4wxFVMaesPfHoigxn1O2SIlJbMIzmZQ+voWs=;
        b=U+VGYb5lWnP8MYMkvDVG+FV4iHCrAGcKaBV/uY9CCPiAn0P1BAMijbZB2xI4jbnKW6
         vtoKnOyMAunbnOdqRaRzXRMlJDraxOF0uko8anp5Hf/4iuRDRGgEQRbDVXudKBLK1N0m
         odzcTBjXZCzsc0/h6DZusWCHBYxuzavcs4Y8r8X4B8Ey58vdk4aUCMsE7R6TayCUOAzg
         3PVo5iCWbZqUrTTIn09YByp5hIx3Jxh8D+UoXA75p/LWLEpapVbvD1cctrv5n/PWVr94
         ffAiAzLtaMvu8Tw6Ugcl/YEk2VLjG0S+rDRaouyFzu4Eg1yD0SKySJTg6e6/v+HI8jPr
         VAdA==
X-Forwarded-Encrypted: i=1; AJvYcCV/Yp/o5XzcvDFSqslI/drEe1CMdMH85VmP5le2tSpDhJdXmsEma8/fDtl5SwXBAc1d17SCVoYaj6QA4MKFMlSA7EzbqvqgUGwvD7/2
X-Gm-Message-State: AOJu0YwYZFIJgdimMaGBhTjmbVH5jDBtRhhhCeSHE/rhks3h0yVYJR8B
	QUdX9aJBbXiCcztORzoYDqvTvecV45lu4vf4rCeswWfJ/PmYznciGpFT988+gPY=
X-Google-Smtp-Source: AGHT+IEzjUp/vTYsBOQZTGKIY00DqKSbtiFFOUibMou6UOd++I1OcMA69m/hXjV13F70gJ/kBI3z3A==
X-Received: by 2002:a05:6512:456:b0:513:2b35:2520 with SMTP id y22-20020a056512045600b005132b352520mr7326424lfk.58.1711486023920;
        Tue, 26 Mar 2024 13:47:03 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id s10-20020a170906354a00b00a47a33b3aa2sm3082641eja.157.2024.03.26.13.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 13:47:03 -0700 (PDT)
Message-ID: <36864c25-4de8-4323-80b1-79e18918fd36@linaro.org>
Date: Tue, 26 Mar 2024 21:47:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Enable UFS
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240326-rb3gen2-ufs-v1-1-8c5c2dae1e64@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240326-rb3gen2-ufs-v1-1-8c5c2dae1e64@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.03.2024 7:02 PM, Bjorn Andersson wrote:
> The rb3gen2 has UFS memory, adjust the necessary supply voltage and add
> the controller and phy nodes to enable this.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 63ebe0774f1d..0177d93ecd1d 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -221,8 +221,8 @@ vreg_l6b_1p2: ldo6 {
>  
>  		vreg_l7b_2p952: ldo7 {
>  			regulator-name = "vreg_l7b_2p952";
> -			regulator-min-microvolt = <2400000>;
> -			regulator-max-microvolt = <3544000>;
> +			regulator-min-microvolt = <2952000>;
> +			regulator-max-microvolt = <2952000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
> @@ -508,6 +508,25 @@ &usb_1_qmpphy {
>  	status = "okay";
>  };
>  
> +&ufs_mem_hc {
> +	reset-gpios = <&tlmm 175 GPIO_ACTIVE_LOW>;
> +	vcc-supply = <&vreg_l7b_2p952>;
> +	vcc-max-microamp = <800000>;
> +	vccq-supply = <&vreg_l9b_1p2>;
> +	vccq-max-microamp = <900000>;
> +	vccq2-supply = <&vreg_l9b_1p2>;
> +	vccq2-max-microamp = <900000>;

This probably requires adding supported modes and allow-set-mode to
these regs


Konrad

