Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35243774044
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbjHHRBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbjHHRA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:00:58 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5CC83F1;
        Tue,  8 Aug 2023 09:00:43 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378EDKQ9034915;
        Tue, 8 Aug 2023 09:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691504000;
        bh=F7UZ/fMAD6M4sdl2XLNfRMGW6ViVA4wUx4rXB9inTws=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=uhDC7fw+J18r4IVQI6J89Ac0vetM3uQIjwfp6z3XsYs79iTd2Q96umAD6ZC3KzTiC
         dPCZNyBdhWNlqkcC1/HYOMEPVeY88Pr5Z3WhvBz70H25v+Q2VvGToHZY8czHxszE+y
         zuIuaAF3RaAuiTx4/4HjsoQeRQXfHU1L+RErJilo=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378EDKa2028372
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 09:13:20 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 09:13:19 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 09:13:19 -0500
Received: from [10.250.36.243] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378EDI3A091111;
        Tue, 8 Aug 2023 09:13:19 -0500
Message-ID: <58daf644-7b16-4768-8885-bd60aa6c014f@ti.com>
Date:   Tue, 8 Aug 2023 09:13:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 07/13] arm64: dts: ti: k3-am64: Enable OSPI nodes at
 the board level
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Dhruva Gole <d-gole@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230808133457.25060-1-afd@ti.com>
 <20230808133457.25060-8-afd@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230808133457.25060-8-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/23 8:34 AM, Andrew Davis wrote:
> OSPI nodes defined in the top-level AM64 SoC dtsi files are incomplete
> and may not be functional unless they are extended with pinmux and
> device information.
> 
> As the attached OSPI device is only known about at the board integration
> level, these nodes should only be enabled when provided with this
> information.
> 
> Disable the OSPI nodes in the dtsi files and only enable the ones that
> are actually pinned out on a given board.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> ---

Oops, I see we have a new AM64 board in -next (tqma64xxl), I can either
rebase this again and enable the nodes in there. Or you can skip this
and the other AM64 patch in this series and I'll resend them next cycle
when that new board is settled.

Andrew

>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi        | 1 +
>   arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi | 1 +
>   arch/arm64/boot/dts/ti/k3-am642-evm.dts         | 1 +
>   arch/arm64/boot/dts/ti/k3-am642-sk.dts          | 1 +
>   4 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index 4e3e450e4e4c8..ed1b63b9c1c5f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -794,6 +794,7 @@ ospi0: spi@fc40000 {
>   			assigned-clock-parents = <&k3_clks 75 7>;
>   			assigned-clock-rates = <166666666>;
>   			power-domains = <&k3_pds 75 TI_SCI_PD_EXCLUSIVE>;
> +			status = "disabled";
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> index 5606d775153d4..1c2c8f0daca9f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> @@ -181,6 +181,7 @@ i2c_som_rtc: rtc@52 {
>   };
>   
>   &ospi0 {
> +	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&ospi0_pins_default>;
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> index d84e7ee160328..b4a1f73d4fb17 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> @@ -520,6 +520,7 @@ &tscadc0 {
>   };
>   
>   &ospi0 {
> +	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&ospi0_pins_default>;
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> index 963d796a3a970..af06ccd466802 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> @@ -518,6 +518,7 @@ &tscadc0 {
>   };
>   
>   &ospi0 {
> +	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&ospi0_pins_default>;
>   
