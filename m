Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21A0772D34
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjHGRnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjHGRnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:43:22 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BB8E74;
        Mon,  7 Aug 2023 10:43:21 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377Hh68T079283;
        Mon, 7 Aug 2023 12:43:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691430186;
        bh=SQQATHkSd0WDfLMY5G4qxzGCUq7LPTaOJfwdFJFhXK4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=BGdfnK4l186WK3Mm4/TaVa1XS55dJaZ1a+PIZT3V2wTwpo4I8KU+5Iwpt947UmTVF
         nRNYEPhUcIxzWsgx3ljB89S9NYQL6Hs8Z1QJwKfrjRh5l3FvyfjVlTf8Ef6CHLxf0M
         OIZF5d0A66aeqQlh/E58qWzbrwDA+cj4UkWbkhRY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377Hh6iw050612
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 12:43:06 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 12:43:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 12:43:06 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377Hh6i2013679;
        Mon, 7 Aug 2023 12:43:06 -0500
Date:   Mon, 7 Aug 2023 12:43:06 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jai Luthra <j-luthra@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 1/4] arm64: dts: ti: k3-am62x: Enable AUDIO_REFCLKx
Message-ID: <20230807174306.yktrky7f6w3gqph7@sensually>
References: <20230806085113.15373-1-francesco@dolcini.it>
 <20230806085113.15373-2-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230806085113.15373-2-francesco@dolcini.it>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:51-20230806, Francesco Dolcini wrote:
> From: Jai Luthra <j-luthra@ti.com>
> 
> On AM62-based SoCs the AUDIO_REFCLKx clocks can be used as an input to
> external peripherals when configured through CTRL_MMR, so add the
> clock nodes.
> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> v2:
>  - s/clock/clock-controller/ on audio refclk nodes name.
> ---
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi  | 18 ++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 18 ++++++++++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index ef90b2bc81eb..5f19ef46d44c 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -60,6 +60,24 @@ epwm_tbclk: clock-controller@4130 {
>  			reg = <0x4130 0x4>;
>  			#clock-cells = <1>;
>  		};
> +
> +		audio_refclk0: clock-controller@82e0 {
> +			compatible = "ti,am62-audio-refclk";
> +			reg = <0x82e0 0x4>;
> +			clocks = <&k3_clks 157 0>;
> +			assigned-clocks = <&k3_clks 157 0>;
> +			assigned-clock-parents = <&k3_clks 157 8>;
> +			#clock-cells = <0>;
> +		};
> +
> +		audio_refclk1: clock-controller@82e4 {
> +			compatible = "ti,am62-audio-refclk";
> +			reg = <0x82e4 0x4>;
> +			clocks = <&k3_clks 157 10>;
> +			assigned-clocks = <&k3_clks 157 10>;
> +			assigned-clock-parents = <&k3_clks 157 18>;
> +			#clock-cells = <0>;
> +		};
>  	};
>  
>  	dmss: bus@48000000 {
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> index 3198af08fb9f..75ea7202e071 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> @@ -60,6 +60,24 @@ epwm_tbclk: clock-controller@4130 {
>  			reg = <0x4130 0x4>;
>  			#clock-cells = <1>;
>  		};
> +
> +		audio_refclk0: clock-controller@82e0 {
> +			compatible = "ti,am62-audio-refclk";
> +			reg = <0x82e0 0x4>;
> +			clocks = <&k3_clks 157 0>;
> +			assigned-clocks = <&k3_clks 157 0>;
> +			assigned-clock-parents = <&k3_clks 157 8>;
> +			#clock-cells = <0>;
> +		};
> +
> +		audio_refclk1: clock-controller@82e4 {
> +			compatible = "ti,am62-audio-refclk";
> +			reg = <0x82e4 0x4>;
> +			clocks = <&k3_clks 157 10>;
> +			assigned-clocks = <&k3_clks 157 10>;
> +			assigned-clock-parents = <&k3_clks 157 18>;
> +			#clock-cells = <0>;
> +		};
>  	};
>  
>  	dmss: bus@48000000 {
> -- 
> 2.25.1
> 


Jeez what a bit of a mess here - looks like I will have to punt this
series.

a) main_conf in arch/arm64/boot/dts/ti/k3-am62-main.dtsi is still
  syscon, simple-mfd -> I had thought we have converted these already, but
  apparently not.
b) we then have the yaml itself. Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
   it picks up clock-controller as ti,am654-ehrpwm-tbclk.yaml
   but the actual binding is Documentation/devicetree/bindings/clock/ti,am62-audio-refclk.yaml
   which is not enforced.

Jai: please sort this out before I can look at any of these audio
enablement patches involving refclk.


ALSO: please DONOT ignore dtbs_check warnings folks. it does show some
real issues in either bindings or dts.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
