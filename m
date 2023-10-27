Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257867D8EED
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345123AbjJ0Gtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0Gtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:49:31 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E301A1;
        Thu, 26 Oct 2023 23:49:28 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39R6nCns098288;
        Fri, 27 Oct 2023 01:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698389352;
        bh=psfOJgM1N9Kdx7TFXRYbjR43AtXKlFrDFTccUJHBzkM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=XWlzjriIm1RdExjRuP9OE0NdFVJxoWTgKOjc72zS0705WbD2D6dZAPBUXPL0WopI5
         Sl7rrfT8sg5cgvb7Nas62ZKgHzfVlkGK8mV3onsOp2zngKVLSwDU0ZLzLnmaEHdEQX
         fPTIwG7m0PeiTHcN9WYG1NAy6NzWrrQ6TVwlmrVc=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39R6nC5a069544
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Oct 2023 01:49:12 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 27
 Oct 2023 01:49:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 27 Oct 2023 01:49:11 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39R6nB3G127815;
        Fri, 27 Oct 2023 01:49:11 -0500
Date:   Fri, 27 Oct 2023 01:49:11 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Nitin Yadav <n-yadav@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: boot: dts: ti: k3-am62a-main: Fix GPIO pin
 count in DT nodes.
Message-ID: <20231027064911.tn7nillbelz463fu@manlike>
References: <20231027061833.1185703-1-n-yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231027061833.1185703-1-n-yadav@ti.com>
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

On 11:48-20231027, Nitin Yadav wrote:
> Fix number of gpio pins in main_gpio0 & main_gpio1 DT nodes according
> to AM62A SK datasheet[0].

Looks like you didn't get the hint from my review comment in v1.. so
here goes:

AM62A is a SoC and AM62A SK is a board. datasheet is for AM62A. Drop the "SK"

btw, Use AM62A7 as it the specific device (as used in the buggy
commit).

> 
> [0]https://www.ti.com/lit/gpn/am62a3 Section: 6.3.10 GPIO (Page No. 52-55)
> 
> Fixes: 5fc6b1b62639c ("arm64: dts: ti: Introduce AM62A7 family of SoCs")
> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> ---
> 
> v2:
>  - Updated commit msge to include links.
>  - Updated fixes tag
> 
> v1: https://lore.kernel.org/all/20231025110252.1089979-1-n-yadav@ti.com/
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
