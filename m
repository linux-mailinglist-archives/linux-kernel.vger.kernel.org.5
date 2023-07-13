Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66C6752906
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbjGMQse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbjGMQs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:48:29 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD25A2D53;
        Thu, 13 Jul 2023 09:48:22 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36DGm8Y2125572;
        Thu, 13 Jul 2023 11:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689266888;
        bh=IZ1z4iyYzGM/RJ4vujD2mbVNTMgRjDvDU6q7GxxY7Is=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ayMQNfvcr/4/41kHpW5pHR1GWHDE6+c9N5XF0QRSEoqBaJkpTcS4zuANBXh0Sngim
         C2LPAQstZShWpJ/qeztypKcKZht1laU1SO0jo5n2q3Ol3V5MSMDknv29G1NSgWrl0X
         VaGN5Wl9HwxK20DbZn9Mva2EOiT9vl21892wG8dY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36DGm8N8077775
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jul 2023 11:48:08 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jul 2023 11:48:08 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jul 2023 11:48:08 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36DGm8uE103174;
        Thu, 13 Jul 2023 11:48:08 -0500
Date:   Thu, 13 Jul 2023 11:48:08 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2-main: Add dts nodes for EHRPWMs
Message-ID: <20230713164808.24m46mdwnh6h2dy5@unwed>
References: <20230713114021.28450-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230713114021.28450-1-sinthu.raja@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:10-20230713, Sinthu Raja wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> Add dts nodes for 6 EHRPWM instances on SoC. Disable EHRPWM nodes in the
> dtsi files and only enable the ones that are actually pinned out on a
> given board in the board dts file.
> 
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 66 ++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index ed79ab3a3271..0d3a965f764f 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -58,6 +58,72 @@ serdes_ln_ctrl: mux-controller@80 {
>  			mux-reg-masks = <0x80 0x3>, <0x84 0x3>, /* SERDES0 lane0/1 select */
>  					<0x88 0x3>, <0x8c 0x3>; /* SERDES0 lane2/3 select */
>  		};
> +
> +		ehrpwm_tbclk: clock-controller@140 {
> +			compatible = "ti,am654-ehrpwm-tbclk", "syscon";

NAK - Please run dtbs_check prior to posting.
	See Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml

> +			reg = <0x140 0x18>;
> +			#clock-cells = <1>;
> +		};
> +	};
> +
> +	main_ehrpwm0: pwm@3000000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x00 0x3000000 0x00 0x100>;
> +		power-domains = <&k3_pds 160 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&ehrpwm_tbclk 0>, <&k3_clks 160 0>;
> +		clock-names = "tbclk", "fck";
> +		status = "disabled";
> +	};
> +
> +	main_ehrpwm1: pwm@3010000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x00 0x3010000 0x00 0x100>;
> +		power-domains = <&k3_pds 161 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&ehrpwm_tbclk 1>, <&k3_clks 161 0>;
> +		clock-names = "tbclk", "fck";
> +		status = "disabled";
> +	};
> +
> +	main_ehrpwm2: pwm@3020000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x00 0x3020000 0x00 0x100>;
> +		power-domains = <&k3_pds 162 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&ehrpwm_tbclk 2>, <&k3_clks 162 0>;
> +		clock-names = "tbclk", "fck";
> +		status = "disabled";
> +	};
> +
> +	main_ehrpwm3: pwm@3030000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x00 0x3030000 0x00 0x100>;
> +		power-domains = <&k3_pds 163 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&ehrpwm_tbclk 3>, <&k3_clks 163 0>;
> +		clock-names = "tbclk", "fck";
> +		status = "disabled";
> +	};
> +
> +	main_ehrpwm4: pwm@3040000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x00 0x3040000 0x00 0x100>;
> +		power-domains = <&k3_pds 164 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&ehrpwm_tbclk 4>, <&k3_clks 164 0>;
> +		clock-names = "tbclk", "fck";
> +		status = "disabled";
> +	};
> +
> +	main_ehrpwm5: pwm@3050000 {
> +		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
> +		#pwm-cells = <3>;
> +		reg = <0x00 0x3050000 0x00 0x100>;
> +		power-domains = <&k3_pds 165 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&ehrpwm_tbclk 5>, <&k3_clks 165 0>;
> +		clock-names = "tbclk", "fck";
> +		status = "disabled";
>  	};
>  
>  	gic500: interrupt-controller@1800000 {
> -- 
> 2.36.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
