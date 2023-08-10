Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F5E77765D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbjHJK53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbjHJK50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:57:26 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A2F1704;
        Thu, 10 Aug 2023 03:57:25 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37A7foE3008014;
        Thu, 10 Aug 2023 12:57:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=Yhm0/CwbeZ+3TGRcWoO3L2e1JDXPY/xgDeY05lQwYYY=; b=sJ
        8cYy8ConmwDBQCvljl1mS7dc31mGcXcYy8q/k2OOtT8GLuj7ZktCyRULYWxENMgP
        T2sj5OrgtaCSaf9BRAZETuNRefGLOAyzPC+p+S1dDp++KorVHyAEt52h3OHCYTR5
        bQ+PZ0P+2D38jjTSmtZdtIerum2JdSLdzzl2iTut+2AhLQc7hTDeosRIb8pUh+Mh
        tr/v7L6NamCk2+Dg5KuASIzn6nrTvaZaco40P++Gsapbrwg3m7KGrZUJrhKbq36p
        DUtLv8glsfTFcR8Gmln7+3l2B8VkvgXrihK/bnnvvS0cZPyyQAnP8Se0xp21RM34
        0uXgbJ02M2wPQn04ddVg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3scdv7nhgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 12:57:04 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7DB39100053;
        Thu, 10 Aug 2023 12:56:59 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6671821683F;
        Thu, 10 Aug 2023 12:56:59 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 10 Aug
 2023 12:56:58 +0200
Message-ID: <969ebe6f-997b-7cb9-2bae-025f73a8a61e@foss.st.com>
Date:   Thu, 10 Aug 2023 12:56:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND PATCH v7 3/3] ARM: dts: stm32: support display on
 stm32f746-disco board
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>
CC:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        <michael@amarulasolutions.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230805093203.3988194-1-dario.binacchi@amarulasolutions.com>
 <20230805093203.3988194-4-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230805093203.3988194-4-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_10,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dario

Sorry for my late answer.

On 8/5/23 11:32, Dario Binacchi wrote:
> Add support to Rocktech RK043FN48H display on stm32f746-disco board.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Reviewed-by: Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com>
> 
> ---
> 
> Changes in v7:
> - Add 'Reviewed-by' tag I forgot in v6.
>    https://lore.kernel.org/linux-arm-kernel/20230629083726.84910-1-dario.binacchi@amarulasolutions.com/T/
> 
> Changes in v6:
> - Remove dma nodes from stm32f746-disco.dts, they are not used by LTDC,
>    so there is no need to enable them.
> 
> Changes in v5:
> I am confident that framebuffer sizing is a real requirement for STM32 boards,
> but I need some time to understand if and how to introduce this functionality.
> Therefore, I drop the following patches to allow the series to be fully merged:
>   - [4/6] dt-bindings: display: stm32-ltdc: add optional st,fb-bpp property
>   - [5/6] ARM: dts: stm32: set framebuffer bit depth on stm32f746-disco
>   - [6/6] drm/stm: set framebuffer bit depth through DTS property
> 
> Changes in v4:
> - Use DTS property instead of module parameter to set the framebuffer bit depth.
> 
> Changes in v3:
> - drop [4/6] dt-bindings: display: simple: add Rocktech RK043FN48H
>    Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next):
>    https://cgit.freedesktop.org/drm/drm-misc/commit/?id=c42a37a27c777d63961dd634a30f7c887949491a
> - drop [5/6] drm/panel: simple: add support for Rocktech RK043FN48H panel
>    Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)
>    https://cgit.freedesktop.org/drm/drm-misc/commit/?id=13cdd12a9f934158f4ec817cf048fcb4384aa9dc
> 
>   arch/arm/boot/dts/st/stm32f746-disco.dts | 43 ++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/st/stm32f746-disco.dts b/arch/arm/boot/dts/st/stm32f746-disco.dts
> index c11616ed5fc6..c00d34179e2e 100644
> --- a/arch/arm/boot/dts/st/stm32f746-disco.dts
> +++ b/arch/arm/boot/dts/st/stm32f746-disco.dts
> @@ -60,10 +60,41 @@ memory@c0000000 {
>   		reg = <0xC0000000 0x800000>;
>   	};
>   
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			no-map;
> +			size = <0x80000>;
> +			linux,dma-default;
> +		};
> +	};
> +
>   	aliases {
>   		serial0 = &usart1;
>   	};
>   
> +	backlight: backlight {
> +		compatible = "gpio-backlight";
> +		gpios = <&gpiok 3 GPIO_ACTIVE_HIGH>;
> +		status = "okay";
> +	};
> +
> +	panel_rgb: panel-rgb {
> +		compatible = "rocktech,rk043fn48h";
> +		backlight = <&backlight>;
> +		enable-gpios = <&gpioi 12 GPIO_ACTIVE_HIGH>;
> +		status = "okay";
> +		port {
> +			panel_in_rgb: endpoint {
> +				remote-endpoint = <&ltdc_out_rgb>;
> +			};
> +		};
> +	};
> +

I got this bindings issue:
../arch/arm/boot/dts/st/stm32f746-disco.dtb: panel-rgb: 'power-supply' 
is a required property
	from schema $id: 
http://devicetree.org/schemas/display/panel/panel-simple.yaml#

Do I miss a dt-bindings patch ?

regards
Alex


>   	usbotg_hs_phy: usb-phy {
>   		#phy-cells = <0>;
>   		compatible = "usb-nop-xceiv";
> @@ -99,6 +130,18 @@ &i2c1 {
>   	status = "okay";
>   };
>   
> +&ltdc {
> +	pinctrl-0 = <&ltdc_pins_a>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	port {
> +		ltdc_out_rgb: endpoint {
> +			remote-endpoint = <&panel_in_rgb>;
> +		};
> +	};
> +};
> +
>   &sdio1 {
>   	status = "okay";
>   	vmmc-supply = <&mmc_vcard>;

