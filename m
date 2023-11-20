Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD087F19C2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjKTRW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjKTRW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:22:58 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A652BA;
        Mon, 20 Nov 2023 09:22:54 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AKDD7BM009802;
        Mon, 20 Nov 2023 18:22:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=GN+TExBADZIgD/6fW2Y2dX8Ze6V3absRQgZQuZSO66A=; b=Wi
        2mTdrnU5J4QtQYCFnnmOm/644ZerzdbnFih4XOSa4ig9pICayO0iOd0iOQjIqyN1
        xEythqEmHxFNwpTY38FVNDUJZ72f0iO7/u4M01me5DEgbFu5T01NFAaGgHYv3bpG
        YvClUV9iRld04M5FpUnwx+itlcUw2FzDWd6nZLIIyqUHLV7m10opAmBQkntrv+cu
        qh5nCAaDVzfXdmzCvx6RozkYeQef8Kike0WgsFdIEgLo/P1rYqZ5sTIDXMgN25N6
        yECgAAv4Wl1C5TqvxxL9ObFiSDFiCz+zvxD6TTEEfDbr2AJQvzMZrEUENlU2JN+6
        8mHeW8/T0i+y1B5sWf/Q==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ueng2fup8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 18:22:43 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 26C0C10002A;
        Mon, 20 Nov 2023 18:22:43 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1716723BE0A;
        Mon, 20 Nov 2023 18:22:43 +0100 (CET)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 20 Nov
 2023 18:22:42 +0100
Message-ID: <e0c92ad2-8ca5-4f38-bfca-c1811ba6fd16@foss.st.com>
Date:   Mon, 20 Nov 2023 18:22:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] ARM: dts: stm32f469-disco: use the same 3v3 for SD
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
References: <20231108134426.4174699-1-dario.binacchi@amarulasolutions.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20231108134426.4174699-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_17,2023-11-20_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dario

On 11/8/23 14:44, Dario Binacchi wrote:
> In the board schematic, the power supply for the SD card is the same 3.3
> volts used to power the LCD panel and other peripherals. By generalizing
> the name of the voltage regulator, it simplifies the device tree and makes
> it more readable.
> 
> Link: https://www.st.com/en/evaluation-tools/32f469idiscovery.html#cad-resources
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---

Applied on stm32-next.

Thanks for this clean-up.

Alex


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
