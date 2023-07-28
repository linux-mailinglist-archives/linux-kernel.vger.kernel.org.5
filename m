Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39704766536
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbjG1HYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjG1HYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:24:08 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C9E2738
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:24:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98e39784a85so652764166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690529045; x=1691133845;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ylqFWXB1rfa4ekZeOmWjSZhJufiEsrgCcDb7+OfY36I=;
        b=Qq8P3+WZ5MxIuo+NUS9hFgdeQdI0plvCmMiPpj0i1OaGLtR483lJCBumrDFM/SA7bt
         0PmVzGC/RYp9sl2wI+g0zmn2Z4Vi5pCODpilgzoM6wXPPlinUbCz7S6CRb4LKC9JDgIN
         Eo4vdV1Vgt/SRBdx241LL8X5C80ThB3jssZ/ImrN/ilQRI4o1QweGzfejIxwUp1Cgbag
         6jTWEGMRU/N6s3Nbu9wg4AP3PKNQFYC1ahXzWrcWEqLg9uNf6yfvOTl4L5+QNDyDZDG4
         Pgp2KX+C6b4y3Ql3iJ6aNKbCXEAzfEq+/KmkgLtDisNAW8oGV4dBuzYloW9Scao96RWy
         OUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690529045; x=1691133845;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ylqFWXB1rfa4ekZeOmWjSZhJufiEsrgCcDb7+OfY36I=;
        b=AWGsYYyApdJw3dQ/Yb46lGlH4fEldAu3kmu4BkC3Yt1t4gF7WqvV0lTdDIDk5Oy2fs
         XGU9diwmKtnW6u1Ih8uDgOAxIAWtzA5B8Ozf69zph5q206054qiPZ/TCsSTxEuHJPr19
         zIGyzYaoHzmIOgGxVzs4N0PE9uuSdQkhJXGYDXbOn/9TSgHqBGkbpiIVo3RodnIE41Ha
         NrxHpwT26uThMSwOeUWzIS1YZ3cIjdY8tSzFajmaTwcSR3Wu8CO07X6rOCzFxf0oNgdR
         2o/6iRWqG3MKKoF44qu7qofCzZoY8j+cl0+IRIkdDOC62lNWCC4DaK5a8OyrUiB47Per
         vbuQ==
X-Gm-Message-State: ABy/qLZUGDpOTbRho6Qh2pPtAkyXG6aLzvJytUksxhZl2GIrhF1W4WTo
        +d3qH20/PfoImonXaT6u442NYw==
X-Google-Smtp-Source: APBJJlGIoa4HpI0EcNBu0u0r1n7uQm+9exnSU9drvy7dCi2NN82V+a22/XCiaSMwdqM+RvtyiUx2Pw==
X-Received: by 2002:a17:906:de:b0:99b:65fa:fc24 with SMTP id 30-20020a17090600de00b0099b65fafc24mr1642466eji.36.1690529045490;
        Fri, 28 Jul 2023 00:24:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n7-20020a170906688700b0099bc2d1429csm1722780ejr.72.2023.07.28.00.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 00:24:05 -0700 (PDT)
Message-ID: <0374b5b4-abc8-9aed-e49c-21287f415734@linaro.org>
Date:   Fri, 28 Jul 2023 09:24:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 12/14] ARM: dts: sti: addition of display nodes for
 stih418 platform
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230727215141.53910-1-avolmat@me.com>
 <20230727215141.53910-13-avolmat@me.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230727215141.53910-13-avolmat@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 23:51, Alain Volmat wrote:
> Addition of a first set of nodes (compositor/tvout/hdmi/dvo) in order
> to allow graphic plane usage via HDMI or DVO on the stih418 based boards.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  arch/arm/boot/dts/st/stih418-clock.dtsi |   2 +-
>  arch/arm/boot/dts/st/stih418.dtsi       | 154 ++++++++++++++++++++++++
>  2 files changed, 155 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/st/stih418-clock.dtsi b/arch/arm/boot/dts/st/stih418-clock.dtsi
> index e1749e92a2e7..93641df58bf2 100644
> --- a/arch/arm/boot/dts/st/stih418-clock.dtsi
> +++ b/arch/arm/boot/dts/st/stih418-clock.dtsi
> @@ -17,7 +17,7 @@ clk_sysin: clk-sysin {
>  	clk_tmdsout_hdmi: clk-tmdsout-hdmi {
>  		#clock-cells = <0>;
>  		compatible = "fixed-clock";
> -		clock-frequency = <0>;
> +		clock-frequency = <594000000>;
>  	};
>  
>  	clocks {
> diff --git a/arch/arm/boot/dts/st/stih418.dtsi b/arch/arm/boot/dts/st/stih418.dtsi
> index b35b9b7a7ccc..b41de235fffa 100644
> --- a/arch/arm/boot/dts/st/stih418.dtsi
> +++ b/arch/arm/boot/dts/st/stih418.dtsi
> @@ -6,6 +6,7 @@
>  #include "stih418-clock.dtsi"
>  #include "stih407-family.dtsi"
>  #include "stih410-pinctrl.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
>  / {
>  	cpus {
>  		#address-cells = <1>;
> @@ -114,5 +115,158 @@ thermal@91a0000 {
>  			clocks = <&clk_sysin>;
>  			interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
>  		};
> +
> +		sti-display-subsystem@0 {

display-subsystem@
or display-controller@

Although 0 is a bit weird address... are you sure this is correct?

> +			compatible = "st,sti-display-subsystem";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			reg = <0 0>;
> +			assigned-clocks = <&clk_s_d2_quadfs 0>,
> +					  <&clk_s_d2_quadfs 1>,
> +					  <&clk_s_d2_flexgen CLK_TMDS_HDMI_DIV2>,
> +					  <&clk_s_d2_flexgen CLK_TMDS_HDMI>,
> +					  <&clk_s_d2_flexgen CLK_PIX_MAIN_DISP>,
> +					  <&clk_s_d2_flexgen CLK_PIX_AUX_DISP>,
> +					  <&clk_s_c0_flexgen CLK_MAIN_DISP>,
> +					  <&clk_s_c0_flexgen CLK_AUX_DISP>,
> +					  <&clk_s_c0_flexgen CLK_COMPO_DVP>,
> +					  <&clk_s_c0_flexgen CLK_PROC_MIXER>;
> +
> +			assigned-clock-parents = <0>,
> +						 <0>,
> +						 <&clk_tmdsout_hdmi>,
> +						 <&clk_tmdsout_hdmi>,
> +						 <&clk_s_d2_quadfs 0>,
> +						 <&clk_s_d2_quadfs 1>,
> +						 <&clk_s_c0_pll1 0>,
> +						 <&clk_s_c0_pll1 0>,
> +						 <&clk_s_c0_pll0 0>,
> +						 <&clk_s_c0_pll0 0>;
> +
> +			assigned-clock-rates = <297000000>,
> +					       <108000000>,
> +					       <297000000>,
> +					       <0>,
> +					       <74250000>,
> +					       <13500000>,
> +					       <400000000>,
> +					       <400000000>,
> +					       <355000000>,
> +					       <355000000>;
> +
> +			ranges;
> +
> +			sti_compo: sti-compositor@a600000 {

compositor@

> +				compatible = "st,stih418-compositor";
> +				reg = <0xa600000 0x200000>;
> +
> +				clock-names = "compo_main",
> +					      "compo_aux",
> +					      "pix_main",
> +					      "pix_aux",
> +					      "proc_mixer";
> +
> +				clocks = <&clk_s_c0_flexgen CLK_COMPO_DVP>,
> +					 <&clk_s_c0_flexgen CLK_COMPO_DVP>,
> +					 <&clk_s_d2_flexgen CLK_PIX_MAIN_DISP>,
> +					 <&clk_s_d2_flexgen CLK_PIX_AUX_DISP>,
> +					 <&clk_s_c0_flexgen CLK_PROC_MIXER>;
> +
> +				reset-names = "compo-main", "compo-aux";
> +				resets = <&softreset STIH407_COMPO_SOFTRESET>,
> +					 <&softreset STIH407_COMPO_SOFTRESET>;
> +				st,vtg = <&vtg_main>, <&vtg_aux>;
> +
> +				status = "disabled";
> +			};
> +
> +			sti_tvout: sti-tvout@a900000 {

hdmi@
or something else

> +				compatible = "st,stih418-tvout";
> +				reg = <0xa900000 0x1000>;
> +				reg-names = "tvout-reg";
> +				reset-names = "tvout";
> +				resets = <&softreset STIH407_HDTVOUT_SOFTRESET>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				assigned-clocks = <&clk_s_d2_flexgen CLK_PIX_HDMI>,
> +						  <&clk_s_d2_flexgen CLK_TMDS_HDMI>,
> +						  <&clk_s_d2_flexgen CLK_REF_HDMIPHY>,
> +						  <&clk_s_d0_flexgen CLK_PCM_0>,
> +						  <&clk_s_d2_flexgen CLK_PIX_HDDAC>,
> +						  <&clk_s_d2_flexgen CLK_HDDAC>;
> +
> +				assigned-clock-parents = <&clk_s_d2_quadfs 0>,
> +							 <&clk_tmdsout_hdmi>,
> +							 <&clk_s_d2_quadfs 0>,
> +							 <&clk_s_d0_quadfs 0>,
> +							 <&clk_s_d2_quadfs 0>,
> +							 <&clk_s_d2_quadfs 0>;
> +				assigned-clock-rates = <74250000>,
> +						       <0>,
> +						       <74250000>,
> +						       <0>,
> +						       <74250000>,
> +						       <148500000>;
> +
> +				status = "disabled";
> +			};
> +
> +			sti_dvo: sti-dvo@a800400 {

I don't know, but definitely sti is not a generic name.

> +				compatible = "st,stih407-dvo";
> +				reg = <0xa800400 0x200>;
> +				reg-names = "dvo-reg";
> +				clock-names = "dvo_pix", "dvo",
> +					      "main_parent", "aux_parent";
> +				clocks = <&clk_s_d2_flexgen CLK_PIX_DVO>,
> +					 <&clk_s_d2_flexgen CLK_DVO>,
> +					 <&clk_s_d2_quadfs 0>, <&clk_s_d2_quadfs 1>;
> +				status = "disabled";
> +			};
> +
> +			sti_hdmi: sti-hdmi@a804000 {

hdmi@

> +				compatible = "st,stih418-hdmi";
> +				reg = <0xa804000 0x1000>;
> +				reg-names = "hdmi-reg";
> +				#sound-dai-cells = <0>;
> +				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-names = "irq";
> +				clock-names = "pix",
> +					      "tmds",
> +					      "phy",
> +					      "audio",
> +					      "main_parent",
> +					      "aux_parent";
> +
> +				clocks = <&clk_s_d2_flexgen CLK_PIX_HDMI>,
> +					 <&clk_s_d2_flexgen CLK_TMDS_HDMI>,
> +					 <&clk_s_d2_flexgen CLK_REF_HDMIPHY>,
> +					 <&clk_s_d0_flexgen CLK_PCM_0>,
> +					 <&clk_s_d2_quadfs 0>,
> +					 <&clk_s_d2_quadfs 1>;
> +
> +				hdmi,hpd-gpio = <&pio5 3 GPIO_ACTIVE_LOW>;
> +				reset-names = "hdmi";
> +				resets = <&softreset STIH407_HDMI_TX_PHY_SOFTRESET>;
> +
> +				status = "disabled";
> +			};
> +		};
Best regards,
Krzysztof

