Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EAE776D61
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 03:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjHJBKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 21:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHJBKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 21:10:55 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65191982;
        Wed,  9 Aug 2023 18:10:53 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37A1AldD082872;
        Wed, 9 Aug 2023 20:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691629847;
        bh=GLGVkQ3eydnNvDjnh135yFo5OF+sOgcx4T8S6JpmskE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=hxUr8eZod7Cp2MFBMVIpiYjeLhD3VDoDOfQycLdfHzAC/JXFP0/wvzvC1A2BDZGEs
         mVZmythzNVdOTLinnHOi0PWEa7obY/yYTRAPkYpbg9s1U+MXYgQ/vbUviQPjjiQtBE
         NSKIffI/FUH94Xk6vUOBSwo7Kf5afocc1Upi9nS8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37A1AlmE102488
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 20:10:47 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 20:10:46 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 20:10:46 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37A1AkLq057651;
        Wed, 9 Aug 2023 20:10:46 -0500
Date:   Wed, 9 Aug 2023 20:10:46 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Hari Nagalla <hnagalla@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-main: disable remote proc nodes
Message-ID: <20230810011046.ta3qapj3oj2oqs7o@value>
References: <20230810005629.21738-1-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230810005629.21738-1-hnagalla@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19:56-20230809, Hari Nagalla wrote:
> Disable the dsp and r5f subsystem nodes by default. Proper functioning
> of remote processors with ipc need mailbox configurations which can
> vary between board configurations and applications. Hence move enabling
> the remote processor device nodes to where the required configurations
> are complete.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
> This patch fixes the remote proc yamllint errors for am69-sk board

Fixes tag?
> 
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index a04c44708a09..e7b54338b220 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -1402,6 +1402,7 @@ main_r5fss0: r5fss@5c00000 {
>  		ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
>  			 <0x5d00000 0x00 0x5d00000 0x20000>;
>  		power-domains = <&k3_pds 336 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
>  
>  		main_r5fss0_core0: r5f@5c00000 {
>  			compatible = "ti,j721s2-r5f";
> @@ -1442,6 +1443,7 @@ main_r5fss1: r5fss@5e00000 {
>  		ranges = <0x5e00000 0x00 0x5e00000 0x20000>,
>  			 <0x5f00000 0x00 0x5f00000 0x20000>;
>  		power-domains = <&k3_pds 337 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
>  
>  		main_r5fss1_core0: r5f@5e00000 {
>  			compatible = "ti,j721s2-r5f";
> @@ -1482,6 +1484,7 @@ main_r5fss2: r5fss@5900000 {
>  		ranges = <0x5900000 0x00 0x5900000 0x20000>,
>  			 <0x5a00000 0x00 0x5a00000 0x20000>;
>  		power-domains = <&k3_pds 338 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
>  
>  		main_r5fss2_core0: r5f@5900000 {
>  			compatible = "ti,j721s2-r5f";
> @@ -1524,6 +1527,7 @@ c71_0: dsp@64800000 {
>  		ti,sci-proc-ids = <0x30 0xff>;
>  		resets = <&k3_reset 30 1>;
>  		firmware-name = "j784s4-c71_0-fw";
> +		status = "disabled";
>  	};
>  
>  	c71_1: dsp@65800000 {
> @@ -1536,6 +1540,7 @@ c71_1: dsp@65800000 {
>  		ti,sci-proc-ids = <0x31 0xff>;
>  		resets = <&k3_reset 33 1>;
>  		firmware-name = "j784s4-c71_1-fw";
> +		status = "disabled";
>  	};
>  
>  	c71_2: dsp@66800000 {
> @@ -1548,6 +1553,7 @@ c71_2: dsp@66800000 {
>  		ti,sci-proc-ids = <0x32 0xff>;
>  		resets = <&k3_reset 37 1>;
>  		firmware-name = "j784s4-c71_2-fw";
> +		status = "disabled";
>  	};
>  
>  	c71_3: dsp@67800000 {
> @@ -1560,5 +1566,6 @@ c71_3: dsp@67800000 {
>  		ti,sci-proc-ids = <0x33 0xff>;
>  		resets = <&k3_reset 40 1>;
>  		firmware-name = "j784s4-c71_3-fw";
> +		status = "disabled";
>  	};
>  };
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
