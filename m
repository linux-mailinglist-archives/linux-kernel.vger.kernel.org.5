Return-Path: <linux-kernel+bounces-4786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F94818207
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B02281F96
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2522412B7B;
	Tue, 19 Dec 2023 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TEgNLDR9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3E612B60
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2339262835so291320866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 23:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702969987; x=1703574787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qRC50i6Kn0uikvj38jxTFjty7ifSrHDgFyqKdl1ZFk4=;
        b=TEgNLDR9NKtIk6Yd1RMv+Hdd8XD5Iq/zuF2ATMZjhVfDrS4lRpi9Kg3enerQ3NHCrA
         EWcKYj9Fgy+VNYV5l3Y2LD7Yr5xXY+u3+DkIqnKVTAUDjv0hQQMeZCkW/T4YvNJFfTU5
         AAFR+JVvCGgPYUzL9QTzgK9y1BC/xSpLo4cp7X3G8Wq1ImoVcT3Rbe1tw83xQPUbFCJk
         GmlTWhs1W0Qk5TNcpoQ1n4OaJBGvmcEw1oyO2B/PqR8mZhhbX4PDvuNLR/BW0cQnFNlW
         jRSAY5fBKkf7bDzNDz6r0ZlMeNXOhWjS9dYUD9IimJ1HAaVfBrKkjUhXcdEJGQEfvP1g
         4L6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702969987; x=1703574787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRC50i6Kn0uikvj38jxTFjty7ifSrHDgFyqKdl1ZFk4=;
        b=ADGKgh2mAsK4D28QX0pygmXN/GhsSjZS3RlNg8gQjiDIJawevV6AlITXYeG3/FUGxe
         h+oQFPbk7sb+fSVIK/VOnw9CBy9vQnwcD6Yd2CNCyYIRLSOYwb+6/2u7rL5T1zos4STw
         QXlbgqQCqzA2u/R/QoM2p/7MUfeggkP3WmnHV22hYFhB/mjcLWivf6kLvxM+kK4IXnjY
         T6kcBBWVNBEgYdCGF8+GNq1gbDaK9Kq2ypq/4XMhC6k1WgSylH3Q84GDOOkEZwLUXzuc
         Z1s5CfDy8yCKdakve8w98vtlgPO19NYdcxGU5k6EgAaWmu3jKEHRa9+2CdhUW70fIoWY
         CDNg==
X-Gm-Message-State: AOJu0YwJkLp8xC8bBOG90Sj2OsHHCHUhj7um4GwnNgvL2ZtwDZUC5gxB
	E1xTiLincTzYwDuMr14cM6Lx5w==
X-Google-Smtp-Source: AGHT+IEKW001oe/JGLFAdiZgdl7f9q2Vdjz8NNG49eD4PKXHcI6HNgH0GoDBGfHOovPcD9txId29kQ==
X-Received: by 2002:a17:906:2803:b0:9fc:3a70:4430 with SMTP id r3-20020a170906280300b009fc3a704430mr7869843ejc.70.1702969987072;
        Mon, 18 Dec 2023 23:13:07 -0800 (PST)
Received: from linaro.org ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id o18-20020a17090611d200b00a2362ef4387sm1450499eja.49.2023.12.18.23.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 23:13:06 -0800 (PST)
Date: Tue, 19 Dec 2023 09:13:05 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: align mem timer size cells
 with bindings
Message-ID: <ZYFCgVlrQ5rlcjm0@linaro.org>
References: <20231218150656.72892-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218150656.72892-1-krzysztof.kozlowski@linaro.org>

On 23-12-18 16:06:56, Krzysztof Kozlowski wrote:
> The ARMv7 memory mapped architected timer bindings expect MMIO sizes up
> to 32-bit.  Keep 64-bit addressing but change the size of memory mapping
> to 32-bit (size-cells=1) and adjust the ranges to match this.
> 
> This fixes dtbs_check warnings like:
> 
>   x1e80100-qcp.dtb: timer@17800000: #size-cells:0:0: 1 was expected
> 
> Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index fd09fbc7d8e7..be1285d9919e 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -3417,12 +3417,12 @@ timer@17800000 {
>  			reg = <0 0x17800000 0 0x1000>;
>  
>  			#address-cells = <2>;
> -			#size-cells = <2>;
> -			ranges;
> +			#size-cells = <1>;
> +			ranges = <0 0 0 0 0x20000000>;
>  
>  			frame@17801000 {
> -				reg = <0 0x17801000 0 0x1000>,
> -				      <0 0x17802000 0 0x1000>;
> +				reg = <0 0x17801000 0x1000>,
> +				      <0 0x17802000 0x1000>;
>  
>  				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> @@ -3431,7 +3431,7 @@ frame@17801000 {
>  			};
>  
>  			frame@17803000 {
> -				reg = <0 0x17803000 0 0x1000>;
> +				reg = <0 0x17803000 0x1000>;
>  
>  				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
>  
> @@ -3441,7 +3441,7 @@ frame@17803000 {
>  			};
>  
>  			frame@17805000 {
> -				reg = <0 0x17805000 0 0x1000>;
> +				reg = <0 0x17805000 0x1000>;
>  
>  				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>  
> @@ -3451,7 +3451,7 @@ frame@17805000 {
>  			};
>  
>  			frame@17807000 {
> -				reg = <0 0x17807000 0 0x1000>;
> +				reg = <0 0x17807000 0x1000>;
>  
>  				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>  
> @@ -3461,7 +3461,7 @@ frame@17807000 {
>  			};
>  
>  			frame@17809000 {
> -				reg = <0 0x17809000 0 0x1000>;
> +				reg = <0 0x17809000 0x1000>;
>  
>  				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
>  
> @@ -3471,7 +3471,7 @@ frame@17809000 {
>  			};
>  
>  			frame@1780b000 {
> -				reg = <0 0x1780b000 0 0x1000>;
> +				reg = <0 0x1780b000 0x1000>;
>  
>  				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>  
> @@ -3481,7 +3481,7 @@ frame@1780b000 {
>  			};
>  
>  			frame@1780d000 {
> -				reg = <0 0x1780d000 0 0x1000>;
> +				reg = <0 0x1780d000 0x1000>;
>  
>  				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
>  
> -- 
> 2.34.1
> 

