Return-Path: <linux-kernel+bounces-135088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9004489BAF5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F3D1C21580
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277573AC10;
	Mon,  8 Apr 2024 08:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="vb710pVK"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B07182C5;
	Mon,  8 Apr 2024 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566546; cv=none; b=PFBVPhpqM18K5DyN0gX2gtTjujCXZ6NLhmUjx/yTXQHrRtFJivJjCVTgF2OuzxI4WKpPYum5QToUocaO8bDLD1ny7lpGFCLRG7wunwaSqT4c0OpLMpwFD7arH/8qERXF1Haqrn+gDveL7rr7XQviOWIVPu1ceQE3fjzAfB/UOBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566546; c=relaxed/simple;
	bh=IPFP5xc9/pxOtHa7dx37HFwUJ4eOs/7aF+oBG2Aleu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HjOJ7xdo54F+i6epRYGrGYfTBKpDoCVP9yCd5FIlHydq4xpVCoSjAGHswIO8LwIDDQWUTNeGp8FNhhAe4Pj1loNc95z6BYp/PQXbmoKOkCKmXuRQTbpzFligk/kWcXPhIN+qiS7cbvL9SWkWws0qGxfFHgGAjsUKpM5wGeV6+SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=vb710pVK; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4387LkXm002802;
	Mon, 8 Apr 2024 10:55:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=vqeMlJil1d4Uvh5eSb07G55oP9mOJmKI1taWJJHq3pw=; b=vb
	710pVKG1Jh6EgSswSo4VjZWMn32r8sHQPTp48FWW06zwjdYcrg7Rp140C+WMC6oM
	46YpR7zGQ6vZh1mC07vMmkq7HZcK3E7JvDvaxdrWvzUBtJmKABtxJAihwIcUwVwF
	XX07/T/nUdzErbsa4srelH6Zj6DEecqWnLF52CCAYSjoe3UziIkd0zGyCII2c+p6
	KJs7e9XGYasxi4E36+72yslTqO910vTCBahW2JUaFXOkV3brxOGfXIlOcckr2UCy
	wE+gHn2CbT9+UpBvRBRcec5ZP5/TOmJ67BoGi2OKXJkSB8nRoBYro+dA2rz8fBWs
	c0UXGWgvW1N1jXAmbUqg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xbfy0ku7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 10:55:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9C67440045;
	Mon,  8 Apr 2024 10:55:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B70A32138C6;
	Mon,  8 Apr 2024 10:54:51 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 8 Apr
 2024 10:54:51 +0200
Message-ID: <79ec72ab-5451-4743-8cf9-229b8edb2b54@foss.st.com>
Date: Mon, 8 Apr 2024 10:54:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM: dts: stm32: add heartbeat led for stm32mp157c-ed1
To: <patrice.chotard@foss.st.com>, <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20240326075438.2891335-1-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240326075438.2891335-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_07,2024-04-05_02,2023-05-22_02

Hi Patrice

On 3/26/24 08:54, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Add heartbeat led for stm32mp157c-ed1.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> 
> V2 changes :
>    _ add color and function properties.
> 
>   arch/arm/boot/dts/st/stm32mp157c-ed1.dts | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp157c-ed1.dts b/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
> index 66ed5f9921ba..525d9ca7d576 100644
> --- a/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
> +++ b/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
> @@ -10,6 +10,7 @@
>   #include "stm32mp15-pinctrl.dtsi"
>   #include "stm32mp15xxaa-pinctrl.dtsi"
>   #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
>   #include <dt-bindings/mfd/st,stpmic1.h>
>   
>   / {
> @@ -24,6 +25,17 @@ chosen {
>   		stdout-path = "serial0:115200n8";
>   	};
>   
> +	led {
> +		compatible = "gpio-leds";
> +		led-blue {
> +			gpios = <&gpiod 9 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +			default-state = "off";
> +			function = LED_FUNCTION_HEARTBEAT;
> +			color = <LED_COLOR_ID_BLUE>;
> +		};
> +	};
> +
>   	memory@c0000000 {
>   		device_type = "memory";
>   		reg = <0xC0000000 0x40000000>;

Applied on stm32-next.

thanks
Alex

