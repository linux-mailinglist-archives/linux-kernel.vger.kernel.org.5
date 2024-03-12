Return-Path: <linux-kernel+bounces-99694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BC0878BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E2E1F22763
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFA1A48;
	Tue, 12 Mar 2024 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XLDSB4Fd"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB93365
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710202829; cv=none; b=cFh4pYQowb1xsdIi54YEO0hBSW5zMD6WJHbEuodK5vEaXSXcAXllOG3Zt4XoE7PoccVFYSWpI52inE5RiiirVFPD4LcGNBoIk41b2+t+iG2d9m32Xp1LCrIC6jTY0Rp8iwG9ifdwKHcN+nwvceulQvf1cHDSnDvd+o7QsJyukqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710202829; c=relaxed/simple;
	bh=qOWrAr6bPBzvoLLPTAz0C9dXtVXWGeptHGJUKAp80jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ee/NofHZsGGRUQ17ParfIyoZ8PFg+f+kSCPT4OzgaJt4LIsDv/gMLTQcjhOwHdpwl7cyFd5ktd2eEg2OWSiINJBhcv7pxBlwtM62lID6RZvvTZsUXqIF43oq4kGS/ni9yQdLNQkZg8wGe5MLINAUue0fZHRtQi4z7OvRVr9R83U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XLDSB4Fd; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5131c0691feso6421202e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710202825; x=1710807625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y6Qj+d193V6vAwzUIxkG37xPPAUPTTqW49/CnKjXQd8=;
        b=XLDSB4FdBk/bUYUOETupj4Y9F7zCzjMPvV3v8EdyrilZD1mNzOzS9XPj+E9ana7BB0
         wokXsul0lFauejKPy7Px0ZeYW758jQIslw5+GbugZ8M6XtT8Z5AGkw6d4CMaB9i9jIoa
         C1Y/Ds9ldqCHum1VxLVkvlt5fPFZqfQlAjPHwozHdXviHimKMd3no2Rpz4n2EJ099ZaW
         4UBCIdbm+O0eWvsC6kXN4hhmDybKeorC0HA20WRUvyygaHPyB34KocfIXiZFxTEalnKc
         YryT21aUl6tUmoAjiyIEyYrv4VdDbVlxXpcKCCEP6D44ZWruZkomyhjlX1f5Iom676jl
         wb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710202825; x=1710807625;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6Qj+d193V6vAwzUIxkG37xPPAUPTTqW49/CnKjXQd8=;
        b=YmY/jWxI6q3r2qV75NXiNgYDh7uEw1rZMenEGdIfzUKYfQlJ3LsTXX9OVecSiX6ZNo
         JODX0wWAv8BkLiqSVJw094rFTtdm06kG/mTAT5YnLBh2QbfiUcsOk9M9eI7VeGGbZ0/0
         33WknZkATMJ2xUwt0W1lg4Iuu88h+vFqyYsq19aY/IXMI5Is3fuSAPS7mIyvi6dYGh7V
         hlFZpQ1WXDmMymbXzQ4vcc3lXyPQag+oeBpjRq8PrKyHs3eQw191MvPnJMPmV9ma/auy
         W2aDhvExkKAk9HvS0/o5VLJfB3pcC/+vsSdlKN/ii62Q5fL1g8tbf2zBGSNS9oT+9rJO
         onUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwc9ASXJjfW3EMa8z8vYrmXG3kJ2/AqQN8LqAw49X2lfx1A6Hz5vwBuwsDE7rnczw6txtZMjNqKZ2Ip0K3GajiOV28kYzw/Vzrohbd
X-Gm-Message-State: AOJu0YwRiiuq7cAuQ1W2+WHGoAnlAK7eACuPj1eO3pCubDweB/b38G9a
	AzzrwNEDKPVsP03Jx97VdGKzQSM25gtjNekWaML6osidUqlowa/LIvbLkES1nP4=
X-Google-Smtp-Source: AGHT+IECykpsirV8o3fAnfpG+ZqnLDETPl8qxRjl1ccJmT0u7F6lmAy4sP57NbpxufW8iWZ12UsN4w==
X-Received: by 2002:ac2:485c:0:b0:513:c3:1d94 with SMTP id 28-20020ac2485c000000b0051300c31d94mr4909736lfy.52.1710202825462;
        Mon, 11 Mar 2024 17:20:25 -0700 (PDT)
Received: from [172.30.205.61] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id h18-20020a056512221200b0051354f006b9sm1316460lfu.56.2024.03.11.17.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 17:20:25 -0700 (PDT)
Message-ID: <58d5b209-94f6-43be-89e0-b14f5e30fd8c@linaro.org>
Date: Tue, 12 Mar 2024 01:20:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] arm64: dts: qcom: sm8650: add GPU nodes
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240216-topic-sm8650-gpu-v3-0-eb1f4b86d8d3@linaro.org>
 <20240216-topic-sm8650-gpu-v3-6-eb1f4b86d8d3@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240216-topic-sm8650-gpu-v3-6-eb1f4b86d8d3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/16/24 12:03, Neil Armstrong wrote:
> Add GPU nodes for the SM8650 platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8650.dtsi | 166 +++++++++++++++++++++++++++++++++++
>   1 file changed, 166 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 62e6ae93a9a8..27dcef27b6ad 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -2589,6 +2589,128 @@ tcsr: clock-controller@1fc0000 {
>   			#reset-cells = <1>;
>   		};
>   
> +		gpu: gpu@3d00000 {
> +			compatible = "qcom,adreno-43051401", "qcom,adreno";
> +			reg = <0x0 0x03d00000 0x0 0x40000>,
> +			      <0x0 0x03d9e000 0x0 0x1000>,
> +			      <0x0 0x03d61000 0x0 0x800>;
> +			reg-names = "kgsl_3d0_reg_memory",
> +				    "cx_mem",
> +				    "cx_dbgc";
> +
> +			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			iommus = <&adreno_smmu 0 0x0>,
> +				 <&adreno_smmu 1 0x0>;
> +
> +			operating-points-v2 = <&gpu_opp_table>;
> +
> +			qcom,gmu = <&gmu>;
> +
> +			status = "disabled";
> +
> +			zap-shader {
> +				memory-region = <&gpu_micro_code_mem>;
> +			};
> +
> +			/* Speedbin needs more work on A740+, keep only lower freqs */
> +			gpu_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-680000000 {
> +					opp-hz = /bits/ 64 <680000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +				};

I got a memo from krzk that we should be sorting OPPs low-to-high,
could you please reorder these (and under gmu)?

Otherwise lgtm

Konrad

