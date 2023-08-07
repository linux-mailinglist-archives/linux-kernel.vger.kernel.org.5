Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED24771A16
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjHGGRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjHGGRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:17:08 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443D6172A;
        Sun,  6 Aug 2023 23:17:06 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3776Gx4F059873;
        Mon, 7 Aug 2023 01:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691389019;
        bh=oG8X3ad8rmvOIWctLGiDzBRZ5BDbNlSLIHd97eM+bws=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=AxjaLlgv3lAXkg20LRxenxN09Y+XLjjwUGeo0JFdlBE/EaPDCDMLU2jZNjo0+nJUY
         vus45xAhB5kjB9g6kusUBjcEo7GeayeQBv5z7sWFu2wjSWEdcEyNe5tTxOpmPF8IoI
         SeTBKplEy9eTjc1HxR7lPk49iG0en8x7ZXJS+lU0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3776Gxm1030080
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 01:16:59 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 01:16:59 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 01:16:58 -0500
Received: from [172.24.227.68] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3776GtHN015928;
        Mon, 7 Aug 2023 01:16:55 -0500
Message-ID: <bb87effc-00c3-7d97-08c9-68408f9c514c@ti.com>
Date:   Mon, 7 Aug 2023 11:46:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 04/13] arm64: dts: ti: k3-am65: Enable OSPI nodes at the
 board level
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230802205309.257392-1-afd@ti.com>
 <20230802205309.257392-5-afd@ti.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20230802205309.257392-5-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 03/08/23 02:23, Andrew Davis wrote:
> OSPI nodes defined in the top-level AM65x SoC dtsi files are incomplete
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
> ---
>   arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 1 +
>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            | 2 ++
>   arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 1 +
>   3 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> index e26bd988e5224..6041862d5aa75 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> @@ -593,6 +593,7 @@ adc {
>   };
>   
>   &ospi0 {
> +	status = "okay";

Ok, so this k3-am65-iot2050 series of DT files seem to be structured in
a bit different manner than our SKs and EVMs?

The terminologies like advanced, advanced-m2, basic, etc. are a little
confusing to me. However, I am wondering if we don't do any status = ..
here, and rather make ospi status okays from the iot2050 dts files?

Pardon me if I am making an invalid suggestion, I don't have much
background on these boards.

>   	pinctrl-names = "default";
>   	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> index 7b1f94a89eca8..2c9c20a9d9179 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> @@ -295,6 +295,7 @@ ospi0: spi@47040000 {
>   			power-domains = <&k3_pds 248 TI_SCI_PD_EXCLUSIVE>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> +			status = "disabled";
>   		};
>   
>   		ospi1: spi@47050000 {
> @@ -309,6 +310,7 @@ ospi1: spi@47050000 {
>   			power-domains = <&k3_pds 249 TI_SCI_PD_EXCLUSIVE>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> +			status = "disabled";
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> index 973a89b04a22f..43de7c132d343 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> @@ -530,6 +530,7 @@ &mcu_r5fss0_core1 {
>   };
>   
>   &ospi0 {
> +	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
>   

-- 
Thanks and Regards,
Dhruva Gole
