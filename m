Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90257665C9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjG1Hwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjG1Hwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:52:33 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3027D30DE;
        Fri, 28 Jul 2023 00:52:30 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36S7qAeh002657;
        Fri, 28 Jul 2023 02:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690530730;
        bh=nc8KBo+A+yGg4YPvea8E08cBNrlaDLVAEKoWjqzpHQo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=JC5SEk678iYaBKz00sJPnXUFLLNc42G3+bhyGRgFcCDdhRrChBewkLgGJXyhLvqfY
         n0ODUoipMors3+lVzMxHSXci+reTIKmp0Wd0AmzfZcT3ZDx05g8slq7l5Eg35TJOJ/
         XYPwbCiFqDpg88Q4q8u03IgrvJub4gXiekNYKdv8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36S7qA0W026383
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Jul 2023 02:52:10 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jul 2023 02:52:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jul 2023 02:52:09 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36S7q96f007829;
        Fri, 28 Jul 2023 02:52:09 -0500
Date:   Fri, 28 Jul 2023 13:22:08 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     Tony Lindgren <tony@atomide.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/5] arm: dts: ti: omap: omap36xx: Rename opp_supply
 nodename
Message-ID: <20230728075208.p2qxaoi5w5odt5nk@dhruva>
References: <20230724153911.1376830-1-nm@ti.com>
 <20230724153911.1376830-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230724153911.1376830-2-nm@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 24, 2023 at 10:39:07 -0500, Nishanth Menon wrote:
> Use opp-supply as the proper node name.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Should probably go via Tony's tree.
> 
>  arch/arm/boot/dts/ti/omap/omap36xx.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/ti/omap/omap36xx.dtsi b/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
> index fff9c3d34193..50e640a32b5c 100644
> --- a/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
> @@ -71,7 +71,7 @@ opp1g-1000000000 {
>  		};
>  	};
>  
> -	opp_supply_mpu_iva: opp_supply {
> +	opp_supply_mpu_iva: opp-supply {

Reviewed-by: Dhruva Gole <d-gole@ti.com>

>  		compatible = "ti,omap-opp-supply";
>  		ti,absolute-max-voltage-uv = <1375000>;
>  	};
> -- 
> 2.40.0
> 

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
