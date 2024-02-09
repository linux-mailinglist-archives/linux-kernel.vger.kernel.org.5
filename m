Return-Path: <linux-kernel+bounces-60038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFA284FEFD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60583281917
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A021B268;
	Fri,  9 Feb 2024 21:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PCUiHT+P"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E51617BD3
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707514516; cv=none; b=dm8LsGnsiEkNTZ9Y8UcHmIvqfHwoBwVV77BdBBGozGv/YMEdMNF1t9fsj5hXTuV+0eRU5Do78OIiYiynzn3cIUx4i9oE18L6AYlwLFipNwlhIcJzAUSoFGq/+iV3BX9cFcvO8ckeRTSfctepvnCctSY0TECnmQo1O0kf8P/kZ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707514516; c=relaxed/simple;
	bh=idgggaJrz7FBh61yrBEcRGTKUzjFSjzTEE9ymk86Qsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Apt/w9CRnu+rxBp82VoMSgvmEnDn+qH8mol5p16+Y1DSwv+HqG9sxcEo8Q86vLTEdhCe8X6M3y35blUpbSUDmxWCjGEd61JNPOgA9/n6KaAPFvSw9HUnajJZdNXu4xLszY1fPIavFs8AWYkzDEMAFC3xnuERHDDtmgyShHwIcD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PCUiHT+P; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-511612e0c57so2431198e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707514512; x=1708119312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yfHe8mbNDA8s5cfdUox3lpQULmJ6ZmrxM53dDWhPDSw=;
        b=PCUiHT+PjROQk4Zu6rtU4AQmA0ahOTR/YfvQiAbfXmFhO1oZ8BGsuspofDhJSWH9hA
         x6H/gizQu5P2tpxy7GMYFuKya4S2M93EzYd9ATPAsAM+dbJdtNz40fy+mqWqehyVYJYJ
         znlDNzhwG/GBNLPE9MUI47dNtEjQk4CUGJ0wR7pR10jjAIxY5D858P2RHmtO4fQWTJVL
         mMtGaKe/ksU3gH+VrVSy+QYtPqCnsOdJAF2xFmLBvz0NGfRDmekdD1RuOyN86KpyTUqN
         kA3J1M2Gmvmb+qOGgRGUS95+8N4McpG+A2u1rZ+eiHmY+aIqy75OxMTOJTPb1ZebvsYe
         H5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707514512; x=1708119312;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfHe8mbNDA8s5cfdUox3lpQULmJ6ZmrxM53dDWhPDSw=;
        b=UoiX3hmlKZ1OY7rQW5LfETytEQhBKKAvjiWtXlKXjDbRk83Qstb12yxkMFP7WxCdkh
         MpFjjoA+22Uc6HecvEUgEPKqVXdOcZ0QuyhNCZOOel47GePGCTRbpyT+g+0Pdl7g4jJ+
         hC929sOT3y8w+cKM+7PIJ/J9pRRvjADhkhzzvrQ6AiqCoUirSrsS3lOD5WM6U87Ioeuc
         4biCdRlL5S1qVZSIEa2XA6+8DC6amBVBknXnEsoi6r9prtWE3fUhsBuEIgWuDJ3eU/kM
         RqcL8lKWT7cqkKnPFFPnnyZ5UN/wS0/NKfooJ/lkWqkImP8NYBZhNz20FyfK74rLGgyK
         xUUg==
X-Forwarded-Encrypted: i=1; AJvYcCXi4BhOy7hV5WdJK+M19DNAplKsB/ADMPDVRI/nhhuUqDbHGz7YHJaBHUY6++YlEen/6Z1S1o3AkAZJ9xQKF+DrywVONLNFhkDsFPbp
X-Gm-Message-State: AOJu0YynfCrajJHObjjFyi2cq3eMEGOwuvctfKcwCwxRSf4OtEs4yDbd
	jmFNrXjwtVJqV8y1jUV337lIO49zDbhtBFTOvAGK3SF3DLnqKxL3jUSOnn5L9Pg=
X-Google-Smtp-Source: AGHT+IFoLT3SfKBWP8DyRy9ygf90NUq3shRSmJFHWLt+ApMVgCHxdRF8plbApwaQxguTqvJl75K9ag==
X-Received: by 2002:a19:ca15:0:b0:511:76ea:78f2 with SMTP id a21-20020a19ca15000000b0051176ea78f2mr120461lfg.34.1707514512396;
        Fri, 09 Feb 2024 13:35:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPYW8gPmD+ywhowQ/XytPbE4fBCdWa/I6pv+TgnsO1QFWmAWleRFdI6/MRWrhcHgpebUP5bjJXSTOQa25XdL1vB4i9ByCBx+1AtEMRZl5TkDLTmdEaOFDj39hgDY8GOccqHPNHD4zCRTE+Oqo3kWla0JJtUQTaPYm4J2opikuZRMyse7XgbTNQk3JrGg/vxy766Z/zDgOk+d8oRyA4F51npNu7JPlTE1oJCyQsa48YhArwZ+/DID8Ohq8w0mIbgs9M27CycxC2G1wOkSbO57idbMChrmAF0ArxO5xk33g1KhVyCCHg+qk9o43FB76pGcYpdLIbNUPpFWxg3kF7HTtzbl2ifWCsDv5oiYLoEytp8/POrpekFZWZw+O3vx7QPI/uN01VKRUFFQtBakAFkWxVI1dEzPgOeLQVYp5LjXQ7XPRlSFoDZeqk+3i/W2LskbMvszjt7o4MwebUqXWjRtr2X2PNACq+80PC5yz0v4RpJBGL/JxpSucXzS4RhEorsjd4QdK8MsqemvkWfN1pJEoyQRmNCvkGi6VAOaWc8KM3rov/4oaVYzniNuy+q/XoBIe1i+rxRgaRSVaapfE1VefSAJmWSnUu0plMaFZVLYLmuRuGoEI5TEoPjP8yp6U8l1/GUviJNNJIEeyDpI514zCekt/mJZM3+R2JHxy3/v2y7TXcsLyEXFh4BFpJLi95fGc69/iAOwfDJ70fyAS0GHzx
Received: from [192.168.192.207] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id fj7-20020a1709069c8700b00a3875804883sm1123512ejc.124.2024.02.09.13.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 13:35:11 -0800 (PST)
Message-ID: <0b8921f0-e4da-4b41-a032-1df54750fd9d@linaro.org>
Date: Fri, 9 Feb 2024 22:35:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] arm64: dts: qcom: msm8976: Add WCNSS node
Content-Language: en-US
To: Adam Skladowski <a39.skl@gmail.com>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240121194221.13513-1-a39.skl@gmail.com>
 <20240121194221.13513-9-a39.skl@gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240121194221.13513-9-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.01.2024 20:41, Adam Skladowski wrote:
> Add node describing wireless connectivity subsystem.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8976.dtsi | 96 +++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> index 5a7be93a0115..73ddfaecd3ad 100644
> --- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> @@ -861,6 +861,36 @@ data-pins {
>  					bias-pull-up;
>  				};
>  			};
> +
> +			wcss_wlan_default: wcss-wlan-default-state  {
> +				wcss_wlan2-pins {

No underscores in node names

> +					pins = "gpio40";
> +					function = "wcss_wlan2";
> +					drive-strength = <6>;
> +					bias-pull-up;
> +				};
> +
> +				wcss_wlan1-pins {
> +					pins = "gpio41";
> +					function = "wcss_wlan1";
> +					drive-strength = <6>;
> +					bias-pull-up;
> +				};
> +
> +				wcss_wlan0-pins {
> +					pins = "gpio42";
> +					function = "wcss_wlan0";
> +					drive-strength = <6>;
> +					bias-pull-up;
> +				};
> +
> +				wcss_wlan-pins {
> +					pins = "gpio43", "gpio44";
> +					function = "wcss_wlan";
> +					drive-strength = <6>;
> +					bias-pull-up;
> +				};
> +			};
>  		};
>  
>  		gcc: clock-controller@1800000 {
> @@ -1540,6 +1570,72 @@ blsp2_i2c4: i2c@7af8000 {
>  			status = "disabled";
>  		};
>  
> +		wcnss: remoteproc@a204000 {
> +			compatible = "qcom,pronto-v3-pil", "qcom,pronto";
> +			reg = <0xa204000 0x2000>, <0xa202000 0x1000>, <0xa21b000 0x3000>;
> +			reg-names = "ccu", "dxe", "pmu";

One a line, please

> +
> +			memory-region = <&wcnss_fw_mem>;
> +
> +			interrupts-extended = <&intc GIC_SPI 149 IRQ_TYPE_EDGE_RISING>,
> +					      <&wcnss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&wcnss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +					      <&wcnss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +					      <&wcnss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";

And here too

> +
> +			power-domains = <&rpmpd MSM8976_VDDCX>,
> +					<&rpmpd MSM8976_VDDMX>;
> +			power-domain-names = "cx", "mx";
> +
> +			qcom,smem-states = <&wcnss_smp2p_out 0>;
> +			qcom,smem-state-names = "stop";
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&wcss_wlan_default>;

rev order

Konrad

