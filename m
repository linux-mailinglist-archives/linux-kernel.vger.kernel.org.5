Return-Path: <linux-kernel+bounces-20706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA94A8283D0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3B91C2462C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CAB360AC;
	Tue,  9 Jan 2024 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nj/vhEfB"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A4235EE4;
	Tue,  9 Jan 2024 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5537dd673e5so2348511a12.0;
        Tue, 09 Jan 2024 02:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704795452; x=1705400252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TUx5YfOUHTwUc/o3z6EZn3jsreLu3xGXc2zzEZ5pNSk=;
        b=nj/vhEfBY1sfHAXr0vWcwvKyIX59dVixrbbdqC/qI/mOYSTuNMOQhkXRkRv5zqRHEc
         e33uw3tT6Yxzje7YWe3BN6ZGqMK6n4AdmcrRf7q/N+tYwUj1uSYhy0e3HGoYoaF7WIJh
         ydAZEjqKypXAGGT9QWN16ZZOBNO57lCV+LAzPR3esEUpBpMluUrMkyIAct17BQwviBUZ
         DLQmAUwC5lteMY7f1Obi7wvEnf9l/MHhiBFC432iEKG/0MMaac9fJ0llBlSebCplTdBT
         Wjh40xZ1SLukWJDktVm/1lcq+L59srJnh49UTF0MUdzODjr6FevNnUOkhpltdzjb9l7w
         M2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704795452; x=1705400252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TUx5YfOUHTwUc/o3z6EZn3jsreLu3xGXc2zzEZ5pNSk=;
        b=JF95Blydlex35+BCPZ2KaAdRMAJ+ERr/SDkG3+NZcetk3xKPvumH5XzbwfPv77Xg2E
         38V4Tl05SLXMgt8+uAiRg9n8YWbkHByR4cACt+fr31jBiPMp2F+hwrauS5+z7/9t/joS
         C+L4Txtt/vxJDRDdR3N2arL2njFFrJ76oUaVwLvoPgol7YO4IyRvZXAzLwVXdCjim4Ad
         gzpKToeXcZ30rERKbRH8PRI54FO+f0/FP0TuTTrqndOlAXDNMobig2MBGJ4HASMJKyVE
         YkVYLaqyc567EApkreMTsh/CJ9YKAvCVa5kLMdu099mAmooV65nRpuuDzCsMfm52p2T2
         QNrA==
X-Gm-Message-State: AOJu0YwpTHz3p7Btzwt9Lk0S0FFUGuOOggL0kOmjZ6lH/RA5aqV0aby+
	KbPMMmlQQghUMGNPGQIHvts=
X-Google-Smtp-Source: AGHT+IGrB+NzGjdHpyQpXmMe/xk2t2sEptEit2krxfTtmkP5A/+YAVfYYnWPBKqqNNpKZDZb7Bc6jg==
X-Received: by 2002:a50:d59a:0:b0:554:5ab4:85a0 with SMTP id v26-20020a50d59a000000b005545ab485a0mr3216311edi.81.1704795452141;
        Tue, 09 Jan 2024 02:17:32 -0800 (PST)
Received: from [192.168.3.32] (dh207-96-108.xnet.hr. [88.207.96.108])
        by smtp.gmail.com with ESMTPSA id n20-20020aa7db54000000b00557aa373d71sm781677edt.45.2024.01.09.02.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 02:17:31 -0800 (PST)
Message-ID: <ddc610d5-5047-4921-869b-47bdafb38d9a@gmail.com>
Date: Tue, 9 Jan 2024 11:17:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm64: dts: qcom: ipq6018: enable sdhci node
To: Chukun Pan <amadeus@jmu.edu.cn>, Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240107122822.21667-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Robert Marko <robimarko@gmail.com>
In-Reply-To: <20240107122822.21667-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 07. 01. 2024. 13:28, Chukun Pan wrote:
> Enable mmc device found on ipq6018 devices.
> This node supports both eMMC and SD cards.
>
> Tested with:
>    eMMC (HS200)
>    SD Card (SDR50/SDR104)
>
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
L2 LDO should be used as VQMMC supply, otherwise you cannot change 
between 3 and 1.8V.

Regards,
Robert
> ---
>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index 5e1277fea725..39fb38914a1e 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -436,6 +436,28 @@ dwc_1: usb@7000000 {
>   			};
>   		};
>   
> +		sdhc: mmc@7804000 {
> +			compatible = "qcom,ipq6018-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0x0 0x7804000 0x0 0x1000>,
> +			      <0x0 0x7805000 0x0 0x1000>;
> +			reg-names = "hc", "cqhci";
> +
> +			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> +				 <&gcc GCC_SDCC1_APPS_CLK>,
> +				 <&xo>;
> +			clock-names = "iface", "core", "xo";
> +			resets = <&gcc GCC_SDCC1_BCR>;
> +			max-frequency = <192000000>;
> +			mmc-ddr-1_8v;
> +			mmc-hs200-1_8v;
> +
> +			status = "disabled";
> +		};
> +
>   		blsp_dma: dma-controller@7884000 {
>   			compatible = "qcom,bam-v1.7.0";
>   			reg = <0x0 0x07884000 0x0 0x2b000>;

