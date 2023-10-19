Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1307B7D0253
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346449AbjJSTPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjJSTPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:15:30 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07B3CA;
        Thu, 19 Oct 2023 12:15:27 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39JJFJg5028819;
        Thu, 19 Oct 2023 14:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697742919;
        bh=8nEpaNhdO0hr7HNZnd9/TJlw9Tmo4Ygz+3FhR0f/YRc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ef6jZKsfM92FeInDWOuShd2QIdoJoWMYpuAVKnPkyYPNZMK3Nvm1h4PEVAu1HTG8T
         ES+PZOZpFqc4RFkNN5iLzzDsHIsiqDDN/W5xpmQ8/JDfCYSdiMfdAVEoX5jJJ8qrp9
         NqpiWIV5yii8uFHGsBsKxOQrsVQdc+onF4cnvRL0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39JJFJKC065298
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Oct 2023 14:15:19 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Oct 2023 14:15:19 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Oct 2023 14:15:19 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39JJFJTE113698;
        Thu, 19 Oct 2023 14:15:19 -0500
Date:   Thu, 19 Oct 2023 14:15:19 -0500
From:   reidt <reidt@ti.com>
To:     Vaishnav Achath <vaishnav.a@ti.com>
CC:     <vigneshr@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <u-kumar1@ti.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: ti: k3-j7200-mcu-wakeup: Update fss
 node and hbmc_mux
Message-ID: <20231019191519.jksgyzv6gcrtltbs@reidt-HP-Z2>
References: <20231009082452.30684-1-vaishnav.a@ti.com>
 <20231009082452.30684-3-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231009082452.30684-3-vaishnav.a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:54-20231009, Vaishnav Achath wrote:
> From: Nishanth Menon <nm@ti.com>
> 
> FSS node claims to be a syscon node, while it actually is a simple bus
> where OSPI, HBMC peripherals are located and a mux for path select
> between OSPI and Hyperbus which can be modelled as a reg-mux. So model
> it accordingly and use reg-mux to describe the hbmc_mux.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
> 
> V2->V3:
>  * Keep register regions unchanged as it is correct according to memory
>   map.
>  * Update commit messages as per Vignesh's suggestion.
> 
> V1->V2:
>  * Address feedback from Udit to limit the FSS register region size as
>  per TRM.
>  * Use reg-mux changes to simplify the hbmc-mux modelling.
>  * Update commit message to reflect changes.
> 
> Depends on:
>  https://lore.kernel.org/all/20230911151030.71100-1-afd@ti.com/
> 
>  arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index 2ee6215e38a6..4f98ea685d33 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -507,15 +507,16 @@
>  		status = "disabled";
>  	};
>  
> -	fss: syscon@47000000 {
> -		compatible = "syscon", "simple-mfd";
> +	fss: bus@47000000 {
> +		compatible = "simple-bus";
>  		reg = <0x00 0x47000000 0x00 0x100>;
>  		#address-cells = <2>;
>  		#size-cells = <2>;
>  		ranges;
>  
> -		hbmc_mux: hbmc-mux {
> -			compatible = "mmio-mux";
> +		hbmc_mux: mux-controller@47000004 {
> +			compatible = "reg-mux";
> +			reg = <0x00 0x47000004 0x00 0x2>;
>  			#mux-control-cells = <1>;
>  			mux-reg-masks = <0x4 0x2>; /* HBMC select */
>  		};
> -- 
> 2.17.1
> 
> 

Reviewed-by: Reid Tonking <reidt@ti.com>
