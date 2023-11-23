Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087767F58E6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjKWHMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKWHMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:12:47 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A68B91;
        Wed, 22 Nov 2023 23:12:53 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AN7CZuJ119516;
        Thu, 23 Nov 2023 01:12:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700723555;
        bh=cERezhvzHjdKon4CHCgC/GCE6511lNZNhj3Wy0LCFRw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=HLHEvWE4XNeB7HeJXs3DXeToH/9yiIqJ5Am9/2DQ8BqdW420GQXN5214LzAkRZIU/
         v88FK1fsvCNMvCUnGp/f6N8VcYLbvNVc8G5bG+RiS17eaO8NqU4lFwMhVH4p0F/m65
         DK56AzGIQm75mNvTSlBYoP515dxARhbGA+sc/FjA=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AN7CZeS077691
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Nov 2023 01:12:35 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 Nov 2023 01:12:35 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 Nov 2023 01:12:35 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AN7CZpj100335;
        Thu, 23 Nov 2023 01:12:35 -0600
Date:   Thu, 23 Nov 2023 01:12:35 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Parth Pancholi <parth105105@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Parth Pancholi <parth.pancholi@toradex.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v1] arm64: dts: k3-am625-verdin: enable Verdin UART2
Message-ID: <20231123071235.omgxs3ixnojpkfvu@greeter>
References: <20231121160436.1032364-1-parth105105@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231121160436.1032364-1-parth105105@gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:04-20231121, Parth Pancholi wrote:
> From: Parth Pancholi <parth.pancholi@toradex.com>
> 
> Enable UART2 for AM62 based SOM's Verdin carrier boards Dahlia,
> Development and Yavia.
> Earlier Verdin UART2 was reserved by R5 DM firmware which can be now
> configured using boardcfg during U-boot compilation in the latest TI
> SDKs. In a default config, no one writes to this UART.
> 
> Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> 
> ---
> 
>  arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi | 3 +--
>  arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi    | 3 +--
>  arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi  | 3 +--
>  3 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
> index 013357d17d48..bf6d27e70bc4 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
> @@ -214,6 +214,5 @@ &verdin_gpio_keys {
>  
>  /* Verdin UART_2 */
>  &wkup_uart0 {
> -	/* FIXME: WKUP UART0 is used by DM firmware */
> -	status = "reserved";
> +	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
> index 6701cb8974bb..680071688dcb 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
> @@ -235,6 +235,5 @@ &verdin_gpio_keys {
>  
>  /* Verdin UART_2 */
>  &wkup_uart0 {
> -	/* FIXME: WKUP UART0 is used by DM firmware */
> -	status = "reserved";
> +	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi
> index c685df7deaee..997dfafd27eb 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi
> @@ -207,6 +207,5 @@ &verdin_gpio_keys {
>  
>  /* Verdin UART_2 */
>  &wkup_uart0 {
> -	/* FIXME: WKUP UART0 is used by DM firmware */
> -	status = "reserved";
> +	status = "okay";
>  };
> -- 
> 2.34.1
> 

Do the &pinctrl_wkup_uart0 in verdin.dtsi hold good through these
variants?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
