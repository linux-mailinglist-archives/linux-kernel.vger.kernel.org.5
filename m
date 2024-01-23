Return-Path: <linux-kernel+bounces-35646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9494A8394AF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C24C283491
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CE37F7C1;
	Tue, 23 Jan 2024 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="04v/CNfD"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BA97F7D4;
	Tue, 23 Jan 2024 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027521; cv=none; b=kj3sMzSF/dwdi4kdb7Uw2d3K8QwL/CvQuWErNB4y/YMWVdwyS2NQtogVfXXQZQ+OeWjoucBhaOf4wGfIGrEb9JK7SGNS60OTrgMqXQPnlPzXSsCBM4rOqrekMontBWHIk4a4tlOSjmRxtHBeN8gsWJPhENxfafBpPvUYVdVn89s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027521; c=relaxed/simple;
	bh=x5Gz6/ukYLg16AqjOP9f3+OkLECvXGXvOENH1UDgQLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Crxq+7VuzP4U01XrkCE5N7TAFuXkdPyjTANlv12KO598q3qH1pXouDJMzJ9OhYHkkD25vZjeXY8ZguzYPbjDvYSXY9xwD3//iVIHMCP4CUq/8uaUtrz1a+OqIRAF3QL9dMhVijZOfgD1KNJpcR+YVGStyG3Fe9yypxGjU5bNzMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=04v/CNfD; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40NDERUa032149;
	Tue, 23 Jan 2024 17:31:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=dX6v7UYfiZShBbWqoHEeZ6rhQnZ9QgWlD+c9mgtirsw=; b=04
	v/CNfDZskEgmcnuLhCnIlpMiuO6tEfzwCfFNemp3FqpaZSpmOBMs4fkwKzEFTRUL
	rSQSafcNGQymQbgiRNLQVwN7b8n0qq2g0fJhR8mKMtgXtnoohTXq9XznUl2xGGhf
	NJGPVc6PoX5wmUx3PX3nSLEwdkuMxRD6OLF46+0OpsLFtTzqsSUu3N5YTvvQ9fBa
	3Ox0yuZInid2LGnyCTvXLWCvT/JIb8qjhHIjYFwO1J/+zPLX9oQFA3/BWcleD37U
	evMlSW8OW/82z93nftbSQqcKwjRzp/XbU1msjzBDeMsem4eDijO0AndQplGUB68H
	k+5tYyhmvhdAjPNttgTw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vsrxpxapd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 17:31:28 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 35ACD100056;
	Tue, 23 Jan 2024 17:31:26 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1BD94232FEE;
	Tue, 23 Jan 2024 17:31:26 +0100 (CET)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 23 Jan
 2024 17:31:25 +0100
Message-ID: <f38e8afb-bf08-401e-a747-612a68b96414@foss.st.com>
Date: Tue, 23 Jan 2024 17:31:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/5] ARM: dts: stm32: rename mmc_vcard to vcc-3v3 on
 stm32f769-disco
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>
CC: <linux-amarula@amarulasolutions.com>, Lee Jones <lee@kernel.org>,
        Raphael
 Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20240112144902.40044-1-dario.binacchi@amarulasolutions.com>
 <20240112144902.40044-4-dario.binacchi@amarulasolutions.com>
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240112144902.40044-4-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_09,2024-01-23_02,2023-05-22_02

Hi Dario

On 1/12/24 15:48, Dario Binacchi wrote:
> In the schematics of document UM2033, the power supply for the micro SD
> card is the same 3v3 voltage that is used to power other devices on the
> board. By generalizing the name of the voltage regulator, it can be
> referenced by other nodes in the device tree without creating
> misunderstandings.
> 
> This patch is preparatory for future developments.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Reviewed-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> 
> ---
> 
> Changes in v8:
> - Add Reviewed-by tag of Raphael Gallais-Pou
> 
>   arch/arm/boot/dts/st/stm32f769-disco.dts | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/st/stm32f769-disco.dts b/arch/arm/boot/dts/st/stm32f769-disco.dts
> index 5d12ae25b327..8632bd866272 100644
> --- a/arch/arm/boot/dts/st/stm32f769-disco.dts
> +++ b/arch/arm/boot/dts/st/stm32f769-disco.dts
> @@ -92,9 +92,9 @@ usbotg_hs_phy: usb-phy {
>   		clock-names = "main_clk";
>   	};
>   
> -	mmc_vcard: mmc_vcard {
> +	vcc_3v3: vcc_3v3 {

Replace node name by vcc-3v3. If no v9 sent, I'll do it directly.

>   		compatible = "regulator-fixed";
> -		regulator-name = "mmc_vcard";
> +		regulator-name = "vcc_3v3";
>   		regulator-min-microvolt = <3300000>;
>   		regulator-max-microvolt = <3300000>;
>   	};
> @@ -128,7 +128,7 @@ &rtc {
>   
>   &sdio2 {
>   	status = "okay";
> -	vmmc-supply = <&mmc_vcard>;
> +	vmmc-supply = <&vcc_3v3>;
>   	cd-gpios = <&gpioi 15 GPIO_ACTIVE_LOW>;
>   	broken-cd;
>   	pinctrl-names = "default", "opendrain", "sleep";

