Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B387711C6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 21:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjHETeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 15:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjHETeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 15:34:14 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5702D199;
        Sat,  5 Aug 2023 12:34:12 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 375JXuWE053982;
        Sat, 5 Aug 2023 14:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691264036;
        bh=ywGf2VNoOdqAsNkHO77gnWJr1RqaF8o7AFI63z26nj8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=YtrE2N3QmtSL2poYFvurWUJonYkeIETqbk6dYSzfB9zr4kOAA8UqV+sD4mrgn40ko
         ZRvUJRwGb7+nwTu1+NOBFSbMU8CVxe5WAkZG1BCqeaCselDJNAfRb+b9V3Pnrlgm67
         vtuU4HVsoHIyEYP0s2NBBkljrE/oN0LtSRpvZrJk=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 375JXuYU012469
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 5 Aug 2023 14:33:56 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 5
 Aug 2023 14:33:55 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 5 Aug 2023 14:33:55 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 375JXtUa003708;
        Sat, 5 Aug 2023 14:33:55 -0500
Date:   Sat, 5 Aug 2023 14:33:55 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Devarsh Thakkar <devarsht@ti.com>, <afd@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <a-bhatia1@ti.com>, <j-luthra@ti.com>, <praneeth@ti.com>,
        <j-choudhary@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62x-sk-common: Reserve 128MiB of
 global CMA
Message-ID: <20230805193355.o657pwbq2w3tciui@vehicular>
References: <20230803111455.811339-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230803111455.811339-1-devarsht@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:44-20230803, Devarsh Thakkar wrote:
> Reserve 128MiB of global CMA which is also marked as re-usable
> so that OS can also use the same if peripheral drivers are not using the
> same.
> 
> AM62x supports multimedia components such as GPU, dual Display and Camera.
> Assuming the worst-case scenario where all 3 are run in parallel below
> is the calculation :
> 
> 1) OV5640 camera sensor supports 1920x1080 resolution
> -> 1920 width x 1080 height x 2 bytesperpixel x 8 buffers
>    (default in yavta) : 32MiB
> 
> 2) 1920x1200 Microtips LVDS panel supported
> -> 1920 width x 1080 height x 4 bytesperpixel x 2 buffers :
>    16 MiB
> 
> 3) 1920x1080 HDMI display supported
> -> 1920 width x 1080 height x 4 bytesperpixel x 2 buffers :
>    15.82 MiB which is ~16 MiB
> 
> 4) IMG GPU shares with display allocated buffers while rendering
>    but in case some dedicated operation viz color conversion,
>    keeping same window of ~16 MiB for GPU too.
> 
> Total is 80 MiB and adding 32 MiB for other peripherals and extra
> 16 MiB to keep as buffer for fragmentation thus rounding total to 128
> MiB.
> 
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> Acked-by: Darren Etheridge <detheridge@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---

I don't think this is right approach. There are other techniques
than having to do this (Andrew: please comment) and require drivers to
behave properly. I am esp concerned since there are platforms based on
am62x and just 256MB DDR.

>  arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> index 34c8ffc553ec..9dd6e23ca9ca 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> @@ -47,6 +47,14 @@ ramoops@9ca00000 {
>  			pmsg-size = <0x8000>;
>  		};
>  
> +		/* global cma region */
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			size = <0x00 0x8000000>;
> +			linux,cma-default;
> +		};
> +
>  		secure_tfa_ddr: tfa@9e780000 {
>  			reg = <0x00 0x9e780000 0x00 0x80000>;
>  			alignment = <0x1000>;
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
