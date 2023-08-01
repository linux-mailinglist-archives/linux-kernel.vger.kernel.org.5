Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB7276BE90
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjHAUiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjHAUip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:38:45 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A102122;
        Tue,  1 Aug 2023 13:38:42 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 371KcZhJ030414;
        Tue, 1 Aug 2023 15:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690922315;
        bh=acKsWicC/063sA6Vjz99L74RVEC0X48cDQU5y9gOy9U=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=r/EynYSRe1iU+yWZ5Taf2Vjr/OfpW7VBY4PQe8SeSe7YkUUfe0DYwVTWAMIy3j+M1
         FI83QRz81xK+9U7BEsr2atYuLBmt23zMYNwu5F8Fllfs+ghvbySNOJKVvKGy8/FEwE
         PCRQBST3BB/O1l6HyiGLFkZtje3EUEcX0J0e+X4M=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 371KcZKW085220
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Aug 2023 15:38:35 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Aug 2023 15:38:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Aug 2023 15:38:34 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 371KcYdl027208;
        Tue, 1 Aug 2023 15:38:34 -0500
Date:   Tue, 1 Aug 2023 15:38:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Udit Kumar <u-kumar1@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <sinthu.raja@ti.com>, <t-konduru@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2-som-p0: Correct pinmux offset
 for ospi0
Message-ID: <20230801203834.kpshdyiml4vysgi4@swaddling>
References: <20230801125626.3287306-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230801125626.3287306-1-u-kumar1@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:26-20230801, Udit Kumar wrote:
> Due to non-addressable regions in J721S2 SOC wkup_pmx was split
> into four regions from wkup_pmx0 to wkup_pmx3.
> 
> After split while updating the pin mux references to newly defined
> four wkup_pmx, pin mux for OSPI0 was left.
> 
> Pin mux for OSPI0 is spread over two range wkup_pmx0
> and wkup_pmx1, along with correcting pin mux for ospi
> adding correct pin mux setting within ospi node.
> 
> Fixes: 6bc829ceea41 ("arm64: dts: ti: k3-j721s2: Fix wkup pinmux range")
> 
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
> Test log without patch
> https://gist.github.com/uditkumarti/41d3d7ccf278d4e00e6da349478e58aa
> (line 1192) reports pin mux is out of range for ospi
> 
> Test log with patch
> https://gist.github.com/uditkumarti/46999c99911c9ff3777493fbaea243c6
> 
>  arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
> index d57dd43da0ef..1a9d13237c2d 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
> @@ -45,8 +45,6 @@ mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
>  			J721S2_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (D19) MCU_OSPI0_CLK */
>  			J721S2_WKUP_IOPAD(0x02c, PIN_OUTPUT, 0) /* (F15) MCU_OSPI0_CSn0 */
>  			J721S2_WKUP_IOPAD(0x030, PIN_OUTPUT, 0) /* (G17) MCU_OSPI0_CSn1 */
> -			J721S2_WKUP_IOPAD(0x038, PIN_OUTPUT, 0) /* (F14) MCU_OSPI0_CSn2 */
> -			J721S2_WKUP_IOPAD(0x03c, PIN_OUTPUT, 0) /* (F17) MCU_OSPI0_CSn3 */
>  			J721S2_WKUP_IOPAD(0x00c, PIN_INPUT, 0) /* (C19) MCU_OSPI0_D0 */
>  			J721S2_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (F16) MCU_OSPI0_D1 */
>  			J721S2_WKUP_IOPAD(0x014, PIN_INPUT, 0) /* (G15) MCU_OSPI0_D2 */
> @@ -61,6 +59,15 @@ J721S2_WKUP_IOPAD(0x004, PIN_INPUT, 0) /* (E20) MCU_OSPI0_LBCLKO */
>  	};
>  };
>  
> +&wkup_pmx1 {
> +	mcu_fss0_ospi0_pins1_default: mcu-fss0-ospi0-default-pins1 {
patternProperties:
  '-pins(-[0-9]+)?$|-pin$':

Unless we have a strong reason, I'd leave it as
mcu-fss0-ospi0-1-default-pins or something

But, please ensure we dont get warnings with:
https://lore.kernel.org/all/20230721082654.27036-1-tony@atomide.com/

(Side note: Linus W is on vacation, so it might be a few days for this
 to hit next)
> +		pinctrl-single,pins = <
> +			J721S2_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (F14) MCU_OSPI0_CSn2 */
> +			J721S2_WKUP_IOPAD(0x004, PIN_OUTPUT, 0) /* (F17) MCU_OSPI0_CSn3 */
> +		>;
> +	};
> +};
> +
>  &wkup_pmx2 {
>  	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
>  		pinctrl-single,pins = <
> @@ -127,7 +134,7 @@ &main_mcan16 {
>  &ospi0 {
>  	status = "okay";
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
> +	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>, <&mcu_fss0_ospi0_pins1_default>;
>  
>  	flash@0 {
>  		compatible = "jedec,spi-nor";
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
