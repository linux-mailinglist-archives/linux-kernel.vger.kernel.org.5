Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C63B77DAEF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242278AbjHPHJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242176AbjHPHIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:08:30 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790CB1FD0;
        Wed, 16 Aug 2023 00:08:29 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37G4gLe5026359;
        Wed, 16 Aug 2023 09:08:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=RaYPDLEoelhT36rM0Qalo57lF3pm2rKNxHSOf1i6FBg=; b=s0
        lAMWb6l0ps7kFFkUbCX6OBN//9UwR2sGl/gx/7bxcb6pQiX5S6tlk0s9VJ2pNNx0
        lNkWUewLBALLWDyJs3U6boFg3qfTpF4VCO0KJXty3vnJ2Y/1VbqTmpiplx7TF8h3
        K8+tUov1+CmEBEEWKBwjGglmBr25nhmGIaF4nXI5K3ocEJU3t4ph0ug8TuMj1zco
        O0nrznk6vwRiRWUySwvZPma+3ygrxRztuSXO0UEq0FIhiFGf9teW080mWs9BmaQ+
        psAoQIb0bx2fE+EvgnCz6YJJ6yLlm8iUrZtkrPs6dpurUh4R8ADR5BoaAyAMqAhW
        p9ek1rDetU3Px3fGbSEw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sgqnt8ng5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 09:08:13 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 74B3810005D;
        Wed, 16 Aug 2023 09:08:12 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6DAD52171DF;
        Wed, 16 Aug 2023 09:08:12 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 16 Aug
 2023 09:08:11 +0200
Message-ID: <0e965fe6-138c-74b2-3b62-24d02055716d@foss.st.com>
Date:   Wed, 16 Aug 2023 09:08:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] ARM: dts: st: move leds out of soc in
 stih418-b2264.dts
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230702161936.134429-1-avolmat@me.com>
 <20230702161936.134429-3-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230702161936.134429-3-avolmat@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_05,2023-08-15_02,2023-05-22_02
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/2/23 18:19, Alain Volmat wrote:
> Move the leds node out of the soc section
> and correct the following warning:
> Warning (simple_bus_reg): /soc/leds: missing or empty reg/ranges property
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  arch/arm/boot/dts/st/stih418-b2264.dts | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/st/stih418-b2264.dts b/arch/arm/boot/dts/st/stih418-b2264.dts
> index f496ca28850d..d4874282cfba 100644
> --- a/arch/arm/boot/dts/st/stih418-b2264.dts
> +++ b/arch/arm/boot/dts/st/stih418-b2264.dts
> @@ -73,15 +73,15 @@ aliases {
>  		ethernet0 = &ethernet0;
>  	};
>  
> -	soc {
> -		leds {
> -			compatible = "gpio-leds";
> -			led-green {
> -				gpios = <&pio1 3 GPIO_ACTIVE_HIGH>;
> -				default-state = "off";
> -			};
> +	leds {
> +		compatible = "gpio-leds";
> +		led-green {
> +			gpios = <&pio1 3 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
>  		};
> +	};
>  
> +	soc {
>  		pin-controller-sbc@961f080 {
>  			gmac1 {
>  				rgmii1-0 {

Acked-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
PAtrice
