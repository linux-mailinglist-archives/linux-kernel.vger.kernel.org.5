Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F129B7AF194
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjIZRMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjIZRMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:12:33 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3890D10A;
        Tue, 26 Sep 2023 10:12:25 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38QHCE7r126724;
        Tue, 26 Sep 2023 12:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695748334;
        bh=4MkNpGyLiBJ9crT8nZ12KRW3ncuDsPFpvIGinhR/a90=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=zNaZuNGlZDG9DVU0v4M9BQt5xBQ1QK9IxkIMZb83CU6iGf/gPJqW4Bz3/lNFE0+Nb
         T16+PU1g1U2un6lye2Pz9HZC7dKsHnABF8g3DPdi0jXzBQZwTdWG4q7/ETAvv4+ybB
         IBzESfsmrMbjci31cGZBiLxjgEdCstLDaKfovdpg=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38QHCEKL128726
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Sep 2023 12:12:14 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 12:12:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 12:12:13 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38QHCDSX035221;
        Tue, 26 Sep 2023 12:12:13 -0500
Date:   Tue, 26 Sep 2023 12:12:13 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Keerthy <j-keerthy@ti.com>
CC:     <robh+dt@kernel.org>, <vigneshr@ti.com>, <conor+dt@kernel.org>,
        <kristo@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <u-kumar1@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/7] arm64: dts: ti: k3-j784s4-main: Add the main
 domain watchdog instances
Message-ID: <20230926171213.nihjj2nsnnvnxhel@gradation>
References: <20230926132805.6518-1-j-keerthy@ti.com>
 <20230926132805.6518-5-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230926132805.6518-5-j-keerthy@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:58-20230926, Keerthy wrote:
> There are totally 19 instances of watchdog module. One each for the
> 8 A72 cores, one each for the 4 C7x cores, 1 for the GPU, 1 each
> for the 6 R5F cores in the main domain. Keeping only the A72 instances
> enabled and disabling the rest by default.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 182 +++++++++++++++++++++
>  1 file changed, 182 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index 26dc3776f911..8c3efe066803 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -1576,4 +1576,186 @@
>  			      <695>;
>  		bootph-pre-ram;
>  	};
> +
> +	watchdog0: watchdog@2200000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2200000 0x00 0x100>;
> +		clocks = <&k3_clks 348 1>;
> +		power-domains = <&k3_pds 348 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 348 0>;
> +		assigned-clock-parents = <&k3_clks 348 4>;
> +	};
> +
> +	watchdog1: watchdog@2210000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2210000 0x00 0x100>;
> +		clocks = <&k3_clks 349 1>;
> +		power-domains = <&k3_pds 349 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 349 0>;
> +		assigned-clock-parents = <&k3_clks 349 4>;
> +	};
> +
> +	watchdog2: watchdog@2220000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2220000 0x00 0x100>;
> +		clocks = <&k3_clks 350 1>;
> +		power-domains = <&k3_pds 350 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 350 0>;
> +		assigned-clock-parents = <&k3_clks 350 4>;
> +	};
> +
> +	watchdog3: watchdog@2230000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2230000 0x00 0x100>;
> +		clocks = <&k3_clks 351 1>;
> +		power-domains = <&k3_pds 351 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 351 0>;
> +		assigned-clock-parents = <&k3_clks 351 4>;
> +	};
> +
> +	watchdog4: watchdog@2240000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2240000 0x00 0x100>;
> +		clocks = <&k3_clks 352 1>;
> +		power-domains = <&k3_pds 352 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 352 0>;
> +		assigned-clock-parents = <&k3_clks 352 4>;
> +	};
> +
> +	watchdog5: watchdog@2250000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2250000 0x00 0x100>;
> +		clocks = <&k3_clks 353 1>;
> +		power-domains = <&k3_pds 353 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 353 0>;
> +		assigned-clock-parents = <&k3_clks 353 4>;
> +	};
> +
> +	watchdog6: watchdog@2260000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2260000 0x00 0x100>;
> +		clocks = <&k3_clks 354 1>;
> +		power-domains = <&k3_pds 354 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 354 0>;
> +		assigned-clock-parents = <&k3_clks 354 4>;
> +	};
> +
> +	watchdog7: watchdog@2270000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2270000 0x00 0x100>;
> +		clocks = <&k3_clks 355 1>;
> +		power-domains = <&k3_pds 355 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 355 0>;
> +		assigned-clock-parents = <&k3_clks 355 4>;
> +	};
> +
> +	watchdog16: watchdog@2300000 {
> +		status = "disabled";

wow.. lots of watchdogs.. but you seem to have missed the document why
disabled comment here AND missed the comment about using status
as the last property.
https://lore.kernel.org/all/5187c590-ee9a-4c46-b326-655f4c371aaf@linaro.org/

> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2300000 0x00 0x100>;
> +		clocks = <&k3_clks 356 1>;
> +		power-domains = <&k3_pds 356 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 356 0>;
> +		assigned-clock-parents = <&k3_clks 356 4>;
> +	};
> +
> +	watchdog17: watchdog@2310000 {
> +		status = "disabled";
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2310000 0x00 0x100>;
> +		clocks = <&k3_clks 357 1>;
> +		power-domains = <&k3_pds 357 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 357 0>;
> +		assigned-clock-parents = <&k3_clks 357 4>;
> +	};
> +
> +	watchdog18: watchdog@2320000 {
> +		status = "disabled";
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2320000 0x00 0x100>;
> +		clocks = <&k3_clks 358 1>;
> +		power-domains = <&k3_pds 358 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 358 0>;
> +		assigned-clock-parents = <&k3_clks 358 4>;
> +	};
> +
> +	watchdog19: watchdog@2330000 {
> +		status = "disabled";
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2330000 0x00 0x100>;
> +		clocks = <&k3_clks 359 1>;
> +		power-domains = <&k3_pds 359 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 359 0>;
> +		assigned-clock-parents = <&k3_clks 359 4>;
> +	};
> +
> +	watchdog15: watchdog@22f0000 {
> +		status = "disabled";
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x22f0000 0x00 0x100>;
> +		clocks = <&k3_clks 360 1>;
> +		power-domains = <&k3_pds 360 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 360 0>;
> +		assigned-clock-parents = <&k3_clks 360 4>;
> +	};
> +
> +	watchdog28: watchdog@23c0000 {
> +		status = "disabled";
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x23c0000 0x00 0x100>;
> +		clocks = <&k3_clks 361 1>;
> +		power-domains = <&k3_pds 361 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 361 0>;
> +		assigned-clock-parents = <&k3_clks 361 4>;
> +	};
> +
> +	watchdog29: watchdog@23d0000 {
> +		status = "disabled";
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x23d0000 0x00 0x100>;
> +		clocks = <&k3_clks 362 1>;
> +		power-domains = <&k3_pds 362 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 362 0>;
> +		assigned-clock-parents = <&k3_clks 362 4>;
> +	};
> +
> +	watchdog30: watchdog@23e0000 {
> +		status = "disabled";
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x23e0000 0x00 0x100>;
> +		clocks = <&k3_clks 363 1>;
> +		power-domains = <&k3_pds 363 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 363 0>;
> +		assigned-clock-parents = <&k3_clks 363 4>;
> +	};
> +
> +	watchdog31: watchdog@23f0000 {
> +		status = "disabled";
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x23f0000 0x00 0x100>;
> +		clocks = <&k3_clks 364 1>;
> +		power-domains = <&k3_pds 364 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 364 0>;
> +		assigned-clock-parents = <&k3_clks 364 4>;
> +	};
> +
> +	watchdog32: watchdog@2540000 {
> +		status = "disabled";
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2540000 0x00 0x100>;
> +		clocks = <&k3_clks 365 1>;
> +		power-domains = <&k3_pds 365 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 365 0>;
> +		assigned-clock-parents = <&k3_clks 366 4>;
> +	};
> +
> +	watchdog33: watchdog@2550000 {
> +		status = "disabled";
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2550000 0x00 0x100>;
> +		clocks = <&k3_clks 366 1>;
> +		power-domains = <&k3_pds 366 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 366 0>;
> +		assigned-clock-parents = <&k3_clks 366 4>;
> +	};
>  };
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
