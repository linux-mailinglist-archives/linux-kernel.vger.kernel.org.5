Return-Path: <linux-kernel+bounces-158233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AC58B1D4C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8089D281FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4167A84D25;
	Thu, 25 Apr 2024 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="rC6bMU6s"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99527F7F5;
	Thu, 25 Apr 2024 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035770; cv=none; b=NYu+O5LP7VejKHMEuG0DTUGR6GvyYfjjqvqQy0fRehJJYIxaZQrvFSEt140crN1AY5RdHkqmkR/xGix3xQHqBr+2iSGWPZn9S/2MFJg3hLtUphae3jB+d8cfx/36u1QTzQFEBe4sQLZe2KX+WY6TW6KjSOHxcq9pjTK2ckyJHaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035770; c=relaxed/simple;
	bh=YbYC2WcT7XL6K8L3b9t2NrSqmTGHYMSUhmP7UMHpaq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UH8XRZ9tuDKrFNAfmj+y4Kwbvo/ZqJYoQYHq7O7IArmP/6JAd9J9/apmjp3SxWEGWG5dB291xFpkuzaH/LC4tTcCyNzyi2iCmd27Gfz6TbIEBDildGWfHRegx5u3Dkc+0FCATX2RCgEleF81YTCxhh7q2rEhbKMFhVADfeWPB0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=rC6bMU6s; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P7j7b9021437;
	Thu, 25 Apr 2024 11:02:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=r1ywst7LmHOnYaZwIPJ1djb4oIlKtBFwHRQjCkXMxNg=; b=rC
	6bMU6s9O14XtLRBbCQ+no3+xP+0AT2n5uU8O96Qrgc8WUu8GN4aTvdeXTGw2hYUH
	jZYFk2npsHF1iDyPMmPoNfMd2WeBfgkrt4LhS+hIZy+GVx6dwMX77mmD76OpmmmN
	LriNdsYKIaIV8XQLxBmB3PthbtyuTbmBiMrysKNwllSDHPROtt/51bBwhgeIMjRW
	rLsLXmEJ0e8ujvIlptlgk3ifXpvoB0fBNR5da23gtY4reP3I3fmzRzDG3wRG9+4e
	BEpMAT+oY5Tim5FUJQkCgSI9j7tP/RWapWZSpNSsL65C+rf28N7Bh2lA+3AMYVYc
	9CtTSn/7CekuXf6wX3VQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm51wd3gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 11:02:35 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D41E440044;
	Thu, 25 Apr 2024 11:02:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E8FA82165EB;
	Thu, 25 Apr 2024 11:01:56 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 11:01:56 +0200
Message-ID: <138ac6aa-a633-459b-9315-db255e26053b@foss.st.com>
Date: Thu, 25 Apr 2024 11:01:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: st: correct masks for GIC PPI interrupts on
 stm32mp25
To: Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20240424185329.1.I0e240ebf31af03c7c5b932e36d1d34a5fad576d2@changeid>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240424185329.1.I0e240ebf31af03c7c5b932e36d1d34a5fad576d2@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_09,2024-04-25_01,2023-05-22_02



On 4/24/24 18:53, Patrick Delaunay wrote:
> Using GIC_CPU_MASK_SIMPLE(x), x should reflect the number of CPUs.
> STM32MP251 is a single core Cortex A35, STM32MP253 is a dual core CA35.
> 
> Fixes: 5d30d03aaf78 ("arm64: dts: st: introduce stm32mp25 SoCs family")
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
>   arch/arm64/boot/dts/st/stm32mp251.dtsi | 8 ++++----
>   arch/arm64/boot/dts/st/stm32mp253.dtsi | 7 +++++++
>   2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> index af1444bf9442..ee29c838900b 100644
> --- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
> +++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> @@ -109,10 +109,10 @@ psci {
>   	timer {
>   		compatible = "arm,armv8-timer";
>   		interrupt-parent = <&intc>;
> -		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> -			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> -			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> -			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
>   		always-on;
>   	};
>   
> diff --git a/arch/arm64/boot/dts/st/stm32mp253.dtsi b/arch/arm64/boot/dts/st/stm32mp253.dtsi
> index af48e82efe8a..029f88981961 100644
> --- a/arch/arm64/boot/dts/st/stm32mp253.dtsi
> +++ b/arch/arm64/boot/dts/st/stm32mp253.dtsi
> @@ -20,4 +20,11 @@ arm-pmu {
>   			     <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>;
>   		interrupt-affinity = <&cpu0>, <&cpu1>;
>   	};
> +
> +	timer {
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
>   };

Applied on stm32-next.

thanks.
Alex

