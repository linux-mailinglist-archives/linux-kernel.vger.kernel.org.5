Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7235979FF36
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbjINI5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236665AbjINI5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:57:30 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A0F1BF4;
        Thu, 14 Sep 2023 01:57:25 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E6Xcu0002603;
        Thu, 14 Sep 2023 10:57:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=ZQBqEG8x2ZR1d+czt7xEBbqZ15WBaeXC2ws3BWPlTeY=; b=J2
        6+AsEY3NpbRiy4wM6dNzH5nil45JumT2fvDUylodSuOIVvOfr2NeH1Y96I/HaDBj
        UWF0HKA1i7N7LBEB7kSE59fb8mp2XQrZhq6oCo36WpNHlk4RSk8vaSNOdizhESpC
        HorJZ7SjIRO0S5tViSuBoWMmCT3PpjtVoCcYJ+Lp5aP072oAFPzbtxgtyy/OLY3a
        2amlmXmAe8ZzzTg1h2bJ2+hMm8eycODZSre7PLDlgYjFbHTO8ujhZn7yBiMaBjUt
        x9oOAryCNPtJ0zd+E/pgN0+Zp76Vc+TYp8VWhfTdtMSV+vFu4x2QJjaCTKVTFZEW
        yv6zORHdfvnga7V39/BQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t2y7nyfgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 10:57:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 18302100065;
        Thu, 14 Sep 2023 10:57:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0834C228A20;
        Thu, 14 Sep 2023 10:57:01 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 10:57:00 +0200
Message-ID: <5e75b5fd-c351-1f42-94ed-b6dc1d3f030e@foss.st.com>
Date:   Thu, 14 Sep 2023 10:56:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] ARM: dts: stm32f469-disco: use the same 3v3 for SD
 and DSI nodes
Content-Language: en-US
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-amarula@amarulasolutions.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230904180635.923506-1-dario.binacchi@amarulasolutions.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230904180635.923506-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_07,2023-09-13_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/23 20:06, Dario Binacchi wrote:
> In the board schematic, the power supply for the SD card is the same 3.3
> volts used to power the LCD panel and other peripherals. By generalizing
> the name of the voltage regulator, it simplifies the device tree and makes
> it more readable.
> 

It makes sens as it is the same discret regulator (no pmic involved).

regards
Alex

> Link: https://www.st.com/en/evaluation-tools/32f469idiscovery.html#cad-resources
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
>   arch/arm/boot/dts/st/stm32f469-disco.dts | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/st/stm32f469-disco.dts b/arch/arm/boot/dts/st/stm32f469-disco.dts
> index cbbd521bf010..8a4f8ddd083d 100644
> --- a/arch/arm/boot/dts/st/stm32f469-disco.dts
> +++ b/arch/arm/boot/dts/st/stm32f469-disco.dts
> @@ -69,16 +69,9 @@ aliases {
>   		serial0 = &usart3;
>   	};
>   
> -	mmc_vcard: mmc_vcard {
> +	vcc_3v3: vcc-3v3 {
>   		compatible = "regulator-fixed";
> -		regulator-name = "mmc_vcard";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -	};
> -
> -	vdd_dsi: vdd-dsi {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vdd_dsi";
> +		regulator-name = "vcc_3v3";
>   		regulator-min-microvolt = <3300000>;
>   		regulator-max-microvolt = <3300000>;
>   	};
> @@ -164,7 +157,7 @@ panel@0 {
>   		compatible = "orisetech,otm8009a";
>   		reg = <0>; /* dsi virtual channel (0..3) */
>   		reset-gpios = <&gpioh 7 GPIO_ACTIVE_LOW>;
> -		power-supply = <&vdd_dsi>;
> +		power-supply = <&vcc_3v3>;
>   		status = "okay";
>   
>   		port {
> @@ -219,7 +212,7 @@ timer@2 {
>   
>   &sdio {
>   	status = "okay";
> -	vmmc-supply = <&mmc_vcard>;
> +	vmmc-supply = <&vcc_3v3>;
>   	cd-gpios = <&gpiog 2 GPIO_ACTIVE_LOW>;
>   	broken-cd;
>   	pinctrl-names = "default", "opendrain";

