Return-Path: <linux-kernel+bounces-122713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A968388FBEE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601C61F2C249
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4DB651B6;
	Thu, 28 Mar 2024 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="3xQDVLEf"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586272C857;
	Thu, 28 Mar 2024 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619135; cv=none; b=jsm27rUecAlFECeD+KjAa+UmGNyfGpOPcBB57x3mZAciYDFW9UvkgYy//mt0zqlRBx41hccGoobTgqWpXT9mCGBJIcSTWBO/+Y8aR6jdgFrM+g2AfFgaYmuXL58L0L4xV6v3KntfwMU3Cdoz4fGAi+2LpHQ87Ri73JNdlVRUqNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619135; c=relaxed/simple;
	bh=5tBKdNjgA112C6yUADCH8f/d5+zC1lfyCJEurrd4pX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ajr9dIgxr5UKplE+s9Qu/7wIaQt5DdsNzFY+Zdbas43lJgVA6REm9116dO7bZrN/ULgSVl38+x7W3kbICDmVTHtJWfqN0wDrf40kOwiuwtVZlU0QfOfPxwskXNF9kjnCHqwQPGw1wy0ER6+wAXsrfNleBI76vKvO76efYJF/GxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=3xQDVLEf; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S8gi6q019082;
	Thu, 28 Mar 2024 10:45:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=fBvwDKAkM/EeDqB/A8FS0TYlA1qn2SCYEb8fk+04rLI=; b=3x
	QDVLEf3zvQOUUQrewTSp+3ruCIBkLXn2JR9ohG/+e0SLYSfHUKHXKWRgZieWwSqk
	75iiX0gC5Dki3UY2ldzxlxv403K71mH3MzRYQD24LB4n26q9X/VLMyafvE79G80n
	XwMFRqsHMs6qawlqmCpdL5Owd6YisWWGQpGHyeiRFkbXqk0SSfD1pLlWF8WcQL6V
	6H/TUCn1xTGikl6anbSTFKtYuxmM89bMFVzzH+Eu3GG11liIf/VsmfY9COSr7Ipl
	iVNewF9Kogco1rHLQQ1zR1/Q6WGfiCw+4lMnMDmwCcmF6XX7N7i9JR8ZbTRx0rsJ
	5BkAkt+S8B7M8Hl9/z5A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x1ncm9d0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 10:45:08 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7560140044;
	Thu, 28 Mar 2024 10:45:04 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 88813214D23;
	Thu, 28 Mar 2024 10:44:41 +0100 (CET)
Received: from [10.201.20.71] (10.201.20.71) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Mar
 2024 10:44:41 +0100
Message-ID: <361a9874-2a41-4b8e-9910-67dff9daad14@foss.st.com>
Date: Thu, 28 Mar 2024 10:44:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ARM: dts: stm32: Update button on stm32mp135f-dk
Content-Language: en-US
To: <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.torgue@foss.st.com>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20240328080105.3910099-1-patrice.chotard@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240328080105.3910099-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_09,2024-03-27_01,2023-05-22_02

This patch must be dropped, i made a mistake.

Sorry
Patrice

On 3/28/24 09:01, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> On schematics, 2 buttons are available on stm32mp135-dk board:
>   _ button "user1" connected to GPIOA14
>   _ button "user2" connected to GPIOA13
> 
> Reflect that on device tree.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  arch/arm/boot/dts/st/stm32mp135f-dk.dts | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
> index 52171214a308..f7e03bc7eccb 100644
> --- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
> +++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
> @@ -48,9 +48,15 @@ optee@dd000000 {
>  	gpio-keys {
>  		compatible = "gpio-keys";
>  
> -		button-user {
> -			label = "User-PA13";
> +		button-user-1 {
> +			label = "User-1";
>  			linux,code = <BTN_1>;
> +			gpios = <&gpioa 14 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> +		};
> +
> +		button-user-2 {
> +			label = "User-2";
> +			linux,code = <BTN_2>;
>  			gpios = <&gpioa 13 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
>  		};
>  	};

