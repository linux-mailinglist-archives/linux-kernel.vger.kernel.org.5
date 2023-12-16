Return-Path: <linux-kernel+bounces-1962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90C381566F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186661C238F5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4692F1C32;
	Sat, 16 Dec 2023 02:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZQI4qUQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35492812;
	Sat, 16 Dec 2023 02:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-67f16446498so8727046d6.1;
        Fri, 15 Dec 2023 18:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702694097; x=1703298897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lNlfUS9v3pfkTO0w/8Oq2nDjf4pESr7zqgOW0Dmjp2E=;
        b=SZQI4qUQtIxHAcM/o3HztmRkqM5MtREMSsm1DbnndvaHeqxd+nxPAjVleZ1vuq5n0I
         IZaDmqlNF+kV96+cf//yGvUdWKiZAZF149DEZAiC675zFOOoCu9InH2P3KUXYFBW2yPT
         lPu27embmUiaU3u9tp+7Cj/SjXOtEIU8zo3MGwIeq8FrdBjkEP5rFds7rRzdFK5ZkM6b
         7spBX2AyfUm9KGQxhchhXp+/P87QPPXoWzhJ4bTbQ8e901slEak2VLCgGKh39TOSrInw
         YO6qWCASrT5aJdNE1a5IngyPrcwBF11+QRIt1D7F/IhSDiAg/9xPmQa9Xp4777Ggwa08
         9BwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702694097; x=1703298897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNlfUS9v3pfkTO0w/8Oq2nDjf4pESr7zqgOW0Dmjp2E=;
        b=SiSGoiNbbPjgAOp5mA0nCO93Yir5N3IrcvB2NtJkM6n6eIc6pdPXsEhl3Sl3qGgTDQ
         KrpzUHQetGPOuQRrZw+2F9ey7FAl3eU4qTIDT6scPFzHSaB1w/q7OGdJ7KE3M/523Uiu
         zfAXVemht+Ksd/CB0PBthx+8hVsAxR5nno86aSOebvbyAXLGrIrA8mOSzfidCZIo9qlX
         H0HTSr+NGBznyRa05VJHk0gxICao4hnHA5v9GxNoVcw6Z86CIxSd9ubBKEYb6J5E6Gu5
         nRIDubADDJI01yBQKm+C8OT8Nv8PqgObUwwnDIVVE0nS5tnmrSkWbwF2V8KFvn61Lrw+
         69kg==
X-Gm-Message-State: AOJu0Yz/JtdRmuBIB5GojZqGwiN3eGz+kGkHqNsqAYZxEoDl2O42ywiY
	SdSkmQPN3v6kPSMkU9hfqCw=
X-Google-Smtp-Source: AGHT+IE+UUMI/+B/RdPUlDebfLff6Bo0TPgbhcY5nw7DhwN6KqQx9zmak9JXsj5B2YgpwxCNu1MZYA==
X-Received: by 2002:ad4:5c6f:0:b0:67f:86b:72f5 with SMTP id i15-20020ad45c6f000000b0067f086b72f5mr5480739qvh.102.1702694097079;
        Fri, 15 Dec 2023 18:34:57 -0800 (PST)
Received: from localhost ([2607:fea8:529e:7800::a768])
        by smtp.gmail.com with ESMTPSA id q2-20020a0ce202000000b0067a93291d3dsm7340689qvl.78.2023.12.15.18.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 18:34:56 -0800 (PST)
Date: Fri, 15 Dec 2023 21:34:53 -0500
From: Richard Acayan <mailingradian@gmail.com>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm670: fix USB DP/DM HS PHY
 interrupts
Message-ID: <ZX0MzT5jX_s_m_1Y@radian>
References: <20231214074319.11023-1-johan+linaro@kernel.org>
 <20231214074319.11023-2-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214074319.11023-2-johan+linaro@kernel.org>

On Thu, Dec 14, 2023 at 08:43:17AM +0100, Johan Hovold wrote:
> The USB DP/DM HS PHY interrupts need to be provided by the PDC interrupt
> controller in order to be able to wake the system up from low-power
> states and to be able to detect disconnect events, which requires
> triggering on falling edges.
>
> A recent commit updated the trigger type but failed to change the
> interrupt provider as required. This leads to the current Linux driver
> failing to probe instead of printing an error during suspend and USB
> wakeup not working as intended.
>
> Fixes: de3b3de30999 ("arm64: dts: qcom: sdm670: fix USB wakeup interrupt types")
> Fixes: 07c8ded6e373 ("arm64: dts: qcom: add sdm670 and pixel 3a device trees")
> Cc: stable@vger.kernel.org      # 6.2

I almost forgot to mention, both SDM670 patches seem to depend on
b51ee205dc4f ("arm64: dts: qcom: sdm670: Add PDC") in 6.6 to compile
properly.

> Cc: Richard Acayan <mailingradian@gmail.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm670.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
> index c873560ae9d5..fe4067c012a0 100644
> --- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
> @@ -1295,10 +1295,10 @@ usb_1: usb@a6f8800 {
>  					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
>  			assigned-clock-rates = <19200000>, <150000000>;
>  
> -			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 488 IRQ_TYPE_EDGE_BOTH>,
> -				     <GIC_SPI 489 IRQ_TYPE_EDGE_BOTH>;
> +			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&pdc 8 IRQ_TYPE_EDGE_BOTH>,
> +					      <&pdc 9 IRQ_TYPE_EDGE_BOTH>;
>  			interrupt-names = "hs_phy_irq", "ss_phy_irq",
>  					  "dm_hs_phy_irq", "dp_hs_phy_irq";
>  
> -- 
> 2.41.0
>

