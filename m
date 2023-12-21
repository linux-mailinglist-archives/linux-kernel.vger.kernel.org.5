Return-Path: <linux-kernel+bounces-8844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813CF81BD1E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21591B22891
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459F959935;
	Thu, 21 Dec 2023 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mGEwm/RV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BBF5990D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d352c826eso12948085e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703179388; x=1703784188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i22B3No0hKDRA2thnA354sXFfxYXFz/BCzzibXQZGP0=;
        b=mGEwm/RVwyGSZ+VKJw7bYLi0ossOtil9D99f+twe43hejpV3a2GF+lNiQdWqjSRuhO
         iLAnXXuAEODpBBVb42AsiAkcVcjRkSRhZhPGtiJT2AV9jWO3J34erJvcpUnf36MP6gHG
         YbG1wN6NimLGTL3YOd/WnTu+z77xS9GK/gR5zT+1CVG+oZgnZjaME+5FjcBfnMhdkb9Y
         rNTBMxtBrgGWZTsW3PtodBWh2to0y/ft3FB6U0vshxD+GnZzxBalAE+Pino7M1SAwDJO
         nbGh1rRmhK63SUgdplnOEW18ZGkzVG0bEeQ0SNMssuI9p6/vLJZRXAn86nAN4YDlQjqY
         bg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703179388; x=1703784188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i22B3No0hKDRA2thnA354sXFfxYXFz/BCzzibXQZGP0=;
        b=LQ+fYM9CuNictdmvo7HWvWbkYPLZ7pAqq22NFIu7mde1nIvRntBCVpzhiadYg95R1w
         97Y1M0/XQZXzI9+O1698teP6A/zzDLT+QxKDMaxQydsFEdEp2VqoMywHVedChihp9cEi
         E5P/9fe7cxyfVFjrS18ZsL9hsVTx569D7EGnCIOFSUibexy4qC9DLCQcupORtS71XTwx
         EK3AFSK7vlYitrQCRw4Q3MW7EUu1gCsslZG1UCVq//rCBdo8TT2e6xtT4a+UXUFa/rEj
         NYnRx7VhAKToOmj5pd4z9WhEwFfNF0x50Bkqe9Bw/8MDoGL7zK92Yd7DV+e/wN0uUpS6
         maEA==
X-Gm-Message-State: AOJu0Yxwct3N7hlm8gNrFEK6m47qzH+5sUUdo0JAb0ITn7oxUbl0lL4p
	eYgo/C7DDPCfIDK1TUYoGMk8+JRvKTw+jg==
X-Google-Smtp-Source: AGHT+IEyA/eutUuLn/2fpEnt5+MBO2+vSa7TMv0Yb6eb/xpmHBxKuneGty6Us6DZGh9oY/b17V9gog==
X-Received: by 2002:a05:600c:44c:b0:40c:6e37:3869 with SMTP id s12-20020a05600c044c00b0040c6e373869mr47559wmb.30.1703179388487;
        Thu, 21 Dec 2023 09:23:08 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id fj8-20020a05600c0c8800b004094e565e71sm4046723wmb.23.2023.12.21.09.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 09:23:08 -0800 (PST)
Message-ID: <c6cc6e74-6c3d-439b-8dc1-bc50a88a3d8f@linaro.org>
Date: Thu, 21 Dec 2023 17:23:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: exynos: gs101: comply with the new
 cmu_misc clock names
Content-Language: en-US
To: peter.griffin@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org
Cc: conor+dt@kernel.org, mturquette@baylibre.com, alim.akhtar@samsung.com,
 semen.protsenko@linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@android.com, Rob Herring <robh@kernel.org>
References: <20231221090046.1486195-1-tudor.ambarus@linaro.org>
 <20231221090046.1486195-2-tudor.ambarus@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20231221090046.1486195-2-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/21/23 09:00, Tudor Ambarus wrote:
> The cmu_misc clock-names were renamed to just "bus" and "sss" because
> naming is local to the module, so cmu_misc is implied. As the bindings
> and the device tree have not made a release yet, comply with the
> renamed clocks.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> index 9747cb3fa03a..d838e3a7af6e 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> @@ -289,7 +289,7 @@ cmu_misc: clock-controller@10010000 {
>  			#clock-cells = <1>;
>  			clocks = <&cmu_top CLK_DOUT_CMU_MISC_BUS>,
>  				 <&cmu_top CLK_DOUT_CMU_MISC_SSS>;
> -			clock-names = "dout_cmu_misc_bus", "dout_cmu_misc_sss";
> +			clock-names = "bus", "sss";
>  		};
>  
>  		watchdog_cl0: watchdog@10060000 {

argh, please ignore the patch set. It seems that the clock driver has to
be updated as well:

[    0.050947] exynos_arm64_register_cmu: could not enable bus clock
dout_cmu_misc_bus; err = -2
[    0.052385] exynos_arm64_register_cmu: could not enable bus clock
dout_cmu_peric0_bus; err = -2

