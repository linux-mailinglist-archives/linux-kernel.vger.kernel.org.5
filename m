Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DA27DB282
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 05:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjJ3EZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 00:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3EZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 00:25:33 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F99B4;
        Sun, 29 Oct 2023 21:25:31 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39U4PExv118926;
        Sun, 29 Oct 2023 23:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698639914;
        bh=pJHtx4858jF8F0juPTr6qGuaJv71D1jStfe1o6qefOM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=ghHo4V/P4o4V3p84bDveMKQ8I7zLleeeV0Qm1qGNwi7txmf57f+kBiF0vLJqTR1rT
         Zg31aeXt+cQXQuYpjULuK/YwIRFjrySkkyScmhgOnEJVNP0nF9BaGA2Orgup+2y2KY
         hVpD+VF9ejkMi0y6jXXki6QojE9n+HFO48FhITXI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39U4PE5J041585
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 29 Oct 2023 23:25:14 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 29
 Oct 2023 23:25:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 29 Oct 2023 23:25:13 -0500
Received: from [172.24.227.94] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39U4P9P3006062;
        Sun, 29 Oct 2023 23:25:10 -0500
Message-ID: <d4d79dea-2c7f-4160-9008-23f5bee1550a@ti.com>
Date:   Mon, 30 Oct 2023 09:55:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] arm64: dts: ti: k3-j721e: Use nvmem to model the
 efuses
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        "Vadapalli, Siddharth" <s-vadapalli@ti.com>,
        "Vardhan, Vibhore" <vibhore@ti.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20231025154339.1270246-1-afd@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20231025154339.1270246-1-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Siddharth for CSPW driver, + Vibhore of CPUFreq

On 25/10/23 21:13, Andrew Davis wrote:
> The nvmem subsystem is used to model efuse areas. Currently our efuse
> areas are described using raw syscon nodes and offsets into that. The
> use case for this efuse area is to store the SoC Ethernet MAC address.
> This is already such a commonly supported use case that both the nvmem
> and networking subsystem have built-in support for it. Use that here
> to get the following:
> 
> 1. More standard, complete, and accurate description of this hardware
>    efuse area.
> 
> 2. Remove the need for this custom 'ti,syscon-efuse' property (which
>    I'm surprised was accepted into the binding in the first place..)
> 
> 3. Allow the parent node to not have to be a syscon which fixes a DT
>    check warning.
> 

Sounds like a good plan to me.

> RFC for now as we don't have a simple generic compatible for memory
> mapped nvmem areas. For now we use the 'uniphier-efuse' compatible
> as it is essentially just a generic mmio nvmem area, which means any
> generic area is technically "compatible".
> 

Looking at drivers/nvmem/ its seems like each SoC arch seems to have
their own individual efuse driver?

For K3 SoCs (at least AM62), there are other properties in addition to
MAC address in the eFUSE which are useful for different drivers such as
Speed grades. Can this be extended for the same?

> If this all is acceptable I'll split this patch into three and do
> the same for all the other K3 devices still using this odd
> 'ti,syscon-efuse' pattern for v1.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 24 ++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> index 05d6ef127ba78..8f488d43d49df 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> @@ -34,13 +34,30 @@ k3_reset: reset-controller {
>  		};
>  	};
>  
> -	mcu_conf: syscon@40f00000 {
> -		compatible = "syscon", "simple-mfd";
> +	mcu_conf: bus@40f00000 {
> +		compatible = "simple-bus";
>  		reg = <0x0 0x40f00000 0x0 0x20000>;
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges = <0x0 0x0 0x40f00000 0x20000>;
>  
> +		efuse@200 {
> +			compatible = "socionext,uniphier-efuse";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x200 0x40>;
> +
> +			nvmem-layout {
> +				compatible = "fixed-layout";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +
> +				mac_address: mac@0 {
> +					reg = <0x0 0x6>;
> +				};
> +			};
> +		};
> +
>  		phy_gmii_sel: phy@4040 {
>  			compatible = "ti,am654-phy-gmii-sel";
>  			reg = <0x4040 0x4>;
> @@ -533,7 +550,8 @@ cpsw_port1: port@1 {
>  				reg = <1>;
>  				ti,mac-only;
>  				label = "port1";
> -				ti,syscon-efuse = <&mcu_conf 0x200>;
> +				nvmem-cells = <&mac_address>;
> +				nvmem-cell-names = "mac-address";
>  				phys = <&phy_gmii_sel 1>;
>  			};
>  		};

-- 
Regards
Vignesh
