Return-Path: <linux-kernel+bounces-38795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E9183C61A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14C48B22364
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CC66EB52;
	Thu, 25 Jan 2024 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="D7TTtkal"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8666E2C9;
	Thu, 25 Jan 2024 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195317; cv=none; b=WemzSriQ6nlC1A0TCgL6mUersBz9Lw6CiPJAc5w3jLpyD0cUzWs2eQThOe3A3f71Dc7I4nfVRA7dW1zptfwIMfa5yMpxV2INf/99xhEyK1emJrm/uxSgiIy7cs629WRsjmeYYB/ZUWJv4q31oSlCyx/wSBihr98ykKehEaVWBuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195317; c=relaxed/simple;
	bh=WFXDkOS/OnKi994NNr2coWV0TpGZJ5rUTIVscdy0NVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qTtd9HMrOqUtucokelKAPUAs26X8pyYCd2caHuqPCidAlysw2bgwRewwjoAR63Mj4XWp39x5VEVC7NIWRgkA0zeQZ7rXeFkqwXEDxFA8mKPvhrAo2AFla7Gp8tz1Cy9EG/Ef/rt6ovo3qkdJPfqO8c0Je3Peldo7ttBHPljh788=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=D7TTtkal; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40PF6dnU032526;
	Thu, 25 Jan 2024 16:08:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=8rJa20GotSKJ5iYLJMiNzR9xpxHOsQ8NoAB1sa07s0g=; b=D7
	TTtkalkFoqSjrmtTbzqkEYWf0T9ZV2gREaUJrJBA6R89gghKylLEWavUGl/yhfUW
	LsgT5tRu2FGKkxLV1YcVYsM5qdum550LZMRIjjN6PVF0GH59+luVtlAwZVYlLyQk
	C/Lh5MyAQbLXsHzvuGtWWFUrMsJSCP/H96EhyIAQdPywk6mPj6PJ7h+xrjKFvRHO
	HEE2ccs/0GVK33P/2T81jub7vFEW+mBGdeEBMkU7HeFUcoz4YU6xvi0nTzmnABgg
	W7hJ+DOKNnajkVafpjnInEiAIRNaTEehwt0TUZVVX/aEiwBvJamIQOf9JadE4lFW
	Wb0fmGr/Ojqv837nFzYQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vtmf9gpa3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 16:08:11 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8B2EF10005D;
	Thu, 25 Jan 2024 16:08:10 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 54B5429D7EE;
	Thu, 25 Jan 2024 16:08:10 +0100 (CET)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 25 Jan
 2024 16:08:09 +0100
Message-ID: <bf49f4c9-9e81-4c91-972d-13782d996aaa@foss.st.com>
Date: Thu, 25 Jan 2024 16:08:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm: dts: st: fix DSI peripheral clock on
 stm32mp15 boards
Content-Language: en-US
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Yannick Fertre
	<yannick.fertre@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
References: <20240104134434.744497-1-raphael.gallais-pou@foss.st.com>
 <20240104134434.744497-5-raphael.gallais-pou@foss.st.com>
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240104134434.744497-5-raphael.gallais-pou@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_08,2024-01-25_01,2023-05-22_02

Hi

On 1/4/24 14:44, Raphael Gallais-Pou wrote:
> In RCC driver, 'DSI_K' is a kernel clock while 'DSI' has pclk4 as parent
> clock, which means that it is an APB peripheral clock. Swap the clocks
> in the DSI peripheral clock reference.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---

After updating commit title:

Applied on stm32-next.

Thanks
Alex

>   arch/arm/boot/dts/st/stm32mp157.dtsi          | 2 +-
>   arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts | 2 +-
>   arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts | 2 +-
>   arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts | 2 +-
>   arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp157.dtsi b/arch/arm/boot/dts/st/stm32mp157.dtsi
> index 6197d878894d..97cd24227cef 100644
> --- a/arch/arm/boot/dts/st/stm32mp157.dtsi
> +++ b/arch/arm/boot/dts/st/stm32mp157.dtsi
> @@ -20,7 +20,7 @@ gpu: gpu@59000000 {
>   		dsi: dsi@5a000000 {
>   			compatible = "st,stm32-dsi";
>   			reg = <0x5a000000 0x800>;
> -			clocks = <&rcc DSI_K>, <&clk_hse>, <&rcc DSI_PX>;
> +			clocks = <&rcc DSI>, <&clk_hse>, <&rcc DSI_PX>;
>   			clock-names = "pclk", "ref", "px_clk";
>   			phy-dsi-supply = <&reg18>;
>   			resets = <&rcc DSI_R>;
> diff --git a/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts b/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts
> index afcd6285890c..8634699cc65e 100644
> --- a/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts
> +++ b/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts
> @@ -30,7 +30,7 @@ &cpu1 {
>   };
>   
>   &dsi {
> -	clocks = <&rcc DSI_K>, <&scmi_clk CK_SCMI_HSE>, <&rcc DSI_PX>;
> +	clocks = <&rcc DSI>, <&scmi_clk CK_SCMI_HSE>, <&rcc DSI_PX>;
>   };
>   
>   &gpioz {
> diff --git a/arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts b/arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts
> index 39358d902000..3a897fa7e167 100644
> --- a/arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts
> +++ b/arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts
> @@ -36,7 +36,7 @@ &cryp1 {
>   
>   &dsi {
>   	phy-dsi-supply = <&scmi_reg18>;
> -	clocks = <&rcc DSI_K>, <&scmi_clk CK_SCMI_HSE>, <&rcc DSI_PX>;
> +	clocks = <&rcc DSI>, <&scmi_clk CK_SCMI_HSE>, <&rcc DSI_PX>;
>   };
>   
>   &gpioz {
> diff --git a/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts b/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts
> index 07ea765a4553..29d6465b1fe6 100644
> --- a/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts
> +++ b/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts
> @@ -35,7 +35,7 @@ &cryp1 {
>   };
>   
>   &dsi {
> -	clocks = <&rcc DSI_K>, <&scmi_clk CK_SCMI_HSE>, <&rcc DSI_PX>;
> +	clocks = <&rcc DSI>, <&scmi_clk CK_SCMI_HSE>, <&rcc DSI_PX>;
>   };
>   
>   &gpioz {
> diff --git a/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts b/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts
> index 813086ec2489..5acb78f0a084 100644
> --- a/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts
> +++ b/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts
> @@ -37,7 +37,7 @@ &cryp1 {
>   
>   &dsi {
>   	phy-dsi-supply = <&scmi_reg18>;
> -	clocks = <&rcc DSI_K>, <&scmi_clk CK_SCMI_HSE>, <&rcc DSI_PX>;
> +	clocks = <&rcc DSI>, <&scmi_clk CK_SCMI_HSE>, <&rcc DSI_PX>;
>   };
>   
>   &gpioz {

