Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474727D7153
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344432AbjJYP57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344062AbjJYP55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:57:57 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D731012F;
        Wed, 25 Oct 2023 08:57:54 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39PFvhET013312;
        Wed, 25 Oct 2023 10:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698249463;
        bh=EeIvSdJTPv70yRQJz4urS0T172AtomQUKqKng0i1Tq8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=SPXkLk8T0knwJiZAGrH0ZM3/o0HwCMlCbli8aNfJZMMM6BDAwrLAZyBXmjgItr+Zf
         DYD/s+FXMTwblSj60kv8XpdOnJKyxDM50ID70wle81G+4KxH5FEwYLKwnUdFPb+cm5
         Fz5YTtSCwXZOgckiCn+RFrIQrLZ82VrDyqrcZUkw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39PFvhpC114580
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Oct 2023 10:57:43 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 25
 Oct 2023 10:57:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 25 Oct 2023 10:57:43 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39PFvhfV100334;
        Wed, 25 Oct 2023 10:57:43 -0500
Date:   Wed, 25 Oct 2023 10:57:43 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Nitin Yadav <n-yadav@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: boot: dts: ti: k3-am62a-main: Fix GPIO pin count
 in DT nodes.
Message-ID: <20231025155743.nk7un6pvib7swtxg@decorator>
References: <20231025110252.1089979-1-n-yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231025110252.1089979-1-n-yadav@ti.com>
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

On 16:32-20231025, Nitin Yadav wrote:
> Fix number of gpio pins in main_gpio0 & main_gpio1 DT nodes according
> to AM62a SK datasheet. The Link of datasheet is in the following line:

SK? line?

Please rephrase above and just mention the section of the data sheet to
refer to.

> 
> https://www.ti.com/lit/gpn/am62a3
> 
> Section: 6.3.10 GPIO (Page No. 52-55)

> 
> Fixes: '5fc6b1b62639c ("arm64: dts: ti: Introduce AM62A7 family of SoCs")'

What is the single quote for?
Also note the additional comment in the list to drop the extra EoL.


Did you check the MCU and WKUP GPIO count as well? if there are bugs
around it, fix it in a single commit please.

> 
> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> index 3198af08fb9f..de36abb243f1 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> @@ -462,7 +462,7 @@ main_gpio0: gpio@600000 {
>  			     <193>, <194>, <195>;
>  		interrupt-controller;
>  		#interrupt-cells = <2>;
> -		ti,ngpio = <87>;
> +		ti,ngpio = <92>;
>  		ti,davinci-gpio-unbanked = <0>;
>  		power-domains = <&k3_pds 77 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 77 0>;
> @@ -480,7 +480,7 @@ main_gpio1: gpio@601000 {
>  			     <183>, <184>, <185>;
>  		interrupt-controller;
>  		#interrupt-cells = <2>;
> -		ti,ngpio = <88>;
> +		ti,ngpio = <52>;
>  		ti,davinci-gpio-unbanked = <0>;
>  		power-domains = <&k3_pds 78 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 78 0>;
> -- 
> 2.25.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
