Return-Path: <linux-kernel+bounces-165130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A68808B886A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C261C23241
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0140553379;
	Wed,  1 May 2024 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a16CXjra"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E5C524D7
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714558462; cv=none; b=TUytDb4vMMTqsYisAfV3fsPrWQsLfVM2L2x0Iju7L7eoDejI94dSFUmShnqx8gPh9cYPwFYU9sUbfLu9O+bWkTliJ+BDGaT+Q98CY8dB5TpnTqWBh8kNeES4Hk8/q7FsGsLmUsgIyqyF9E4ZuHk24uZ7INiiTtthpKCEyijl+5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714558462; c=relaxed/simple;
	bh=Ng5tOItL9yq/Oyae3SGSSL7FnZWMWizfspIcGK1MlEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lDCg+BBXvBfCA4lALrU0uicIVupW2nNBnQP7VR0M5r0s/sdUhStwk0aaey6aJL1J5tzir54y9/jdCpLDjlGcDsGtJw8cHvD38QJmjXF/ldtLnkbh5Myeb2mZFGCnnudwnZhSeRdk5NkzzDhXbh/tONEuS/lwXrVXgmoDWll/Sok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a16CXjra; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34da35cd01cso1114176f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 03:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714558459; x=1715163259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zScdSa2ySIZ6rQgcDeS1BUCAXDX3v1qlFq/0opj/DmU=;
        b=a16CXjrauinJBBaZCkBlRskZL+5QGqfEoVCxJsGAmFYw21HAzv7dSaoTtwg9ReF3pj
         P6N1RU2LecWP3VAk3OSBQ41lTlzB8uGjBXyYNyYpQIzOppz4ygvEbMpiu4G/t37Vy+Fg
         19KEef3yJeeaNTXXFqt2Rxoe0ecvCtqcnORAIo5nR5KpkTkseJEJt06FEkapz5Zm+U1+
         c3tZNR/+49Ty00+pfqAu+OYe00MjEMlGZwjV3tr48LDPoQRbNOz+MUSaiWKG87jObgmp
         egBoIn4Ptm2N1Zunz95c+dK1ve1r5/0m+ZkPRz/wrQMlUPem26+JPWIGN7IwLoWNJB6i
         9Odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714558459; x=1715163259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zScdSa2ySIZ6rQgcDeS1BUCAXDX3v1qlFq/0opj/DmU=;
        b=RCxjrRn03mfkVRe/10QPV3HUxPr7pZDEACQzLjnKvuR87g+WPSB0vjuDn9snz7bvfa
         qiHYgcZ9DfK7WyPC5a83SGluiptO6Ih8unlD8Y8jG9tWG16dKxrXaDs6WPqHYabn+qIn
         r3u1bleXBbnMGO2csQRLDLbtp8248Xml4PxvPdbFVBiaoBthZRdEpdBa3mFUtHJ8L31B
         dvWyEstWDidunO0x0WnEUvE5ugLsvtMPV4YLwTDx1Gq7smFOvrCpja4gNff2RmBNi1WD
         lQztHsyXU3j0omdXDcppvVFMTKfHBH/Cf9sbloU4vvaPppEi5Vr8Bqp9bcKEGUqpgwY+
         dXvw==
X-Forwarded-Encrypted: i=1; AJvYcCUIlv62nSJlZsabxkdUtm05xSsIduyCVOwo1zh/RSBoKkAuFi/Ruh9XCdzKuLqsxWSOcRvWxE92c4CEMFKNEBGKeVvVaamVcmspOBAV
X-Gm-Message-State: AOJu0YwFTkp4zJyk5AGXBs4VqapWv5zwtCFZFNcocbKDk7FsgZTq27PK
	KKB5zPjXDrs3zoIPauKXg2cN7WhOS4u8TaU5MdXP9PVxisqB2FixBldAW63m27cok8C1anNQ0jd
	MarjXxg==
X-Google-Smtp-Source: AGHT+IEN48/nlgV4qk/IWlQgEEJUbZ9RROEnU3BpBkcpYNoPG0ExeAQDiRheCUWbeotT9/saLayqhQ==
X-Received: by 2002:adf:a2d0:0:b0:34c:fd73:55d with SMTP id t16-20020adfa2d0000000b0034cfd73055dmr1700109wra.70.1714558459094;
        Wed, 01 May 2024 03:14:19 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id i6-20020adffc06000000b0034cceee9051sm758971wrr.105.2024.05.01.03.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 03:14:18 -0700 (PDT)
Message-ID: <1c3ae48e-9030-41dc-a13d-b16462a63007@linaro.org>
Date: Wed, 1 May 2024 11:14:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcs404: fix bluetooth device address
To: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240501075201.4732-1-johan+linaro@kernel.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240501075201.4732-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/05/2024 08:52, Johan Hovold wrote:
> The 'local-bd-address' property is used to pass a unique Bluetooth
> device address from the boot firmware to the kernel and should otherwise
> be left unset so that the OS can prevent the controller from being used
> until a valid address has been provided through some other means (e.g.
> using btmgmt).
> 
> Fixes: 60f77ae7d1c1 ("arm64: dts: qcom: qcs404-evb: Enable uart3 and add Bluetooth")
> Cc: stable@vger.kernel.org	# 5.10
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> index 10655401528e..a22b4501ce1e 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> @@ -62,7 +62,7 @@ bluetooth {
>   		vddrf-supply = <&vreg_l1_1p3>;
>   		vddch0-supply = <&vdd_ch0_3p3>;
>   
> -		local-bd-address = [ 02 00 00 00 5a ad ];
> +		local-bd-address = [ 00 00 00 00 00 00 ];
>   
>   		max-speed = <3200000>;
>   	};

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

