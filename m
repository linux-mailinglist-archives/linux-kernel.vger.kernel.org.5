Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9AC75FC90
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjGXQwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGXQw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:52:28 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5EFE54;
        Mon, 24 Jul 2023 09:52:27 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36OGqKo7016119;
        Mon, 24 Jul 2023 11:52:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690217540;
        bh=6sKluWMDVCAl9wXd9uzouBrl9+1xuYp1yE/vSDzWnJQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=R6/uGjH6vSOD+pMBKBfessTY5V4CLhdpFgBojU8Ipqi/F8foS2Nl3dl04wGSZugZN
         hMvWIb4jjXH2eL8bHGGc+Lpz8GtM8khWff9+OirggKfOMfm+JwSBqPmmn8qARwiCpg
         grL7Ww6/pt0KOIR9rgIaiVHHMUL7k0sT2AeODAgY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36OGqKIh108650
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Jul 2023 11:52:20 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Jul 2023 11:52:20 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Jul 2023 11:52:20 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36OGqKmN006460;
        Mon, 24 Jul 2023 11:52:20 -0500
Date:   Mon, 24 Jul 2023 11:52:20 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jayesh Choudhary <j-choudhary@ti.com>
CC:     <vigneshr@ti.com>, <afd@ti.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>, <a-bhatia1@ti.com>, <r-ravikumar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/5] arm64: dts: ti: k3-j784s4-main: Add system
 controller and SERDES lane mux
Message-ID: <20230724165220.kbjo7t5vthurqeuj@spokesman>
References: <20230721132029.123881-1-j-choudhary@ti.com>
 <20230721132029.123881-2-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230721132029.123881-2-j-choudhary@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:50-20230721, Jayesh Choudhary wrote:
> From: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> The system controller node manages the CTRL_MMR0 region.
> Add serdes_ln_ctrl node which is used for controlling the SERDES lane mux.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> [j-choudhary@ti.com: Fix serdes_ln_ctrl node]
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index 11f163e5cadf..5a4da4eb8d3d 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -5,6 +5,10 @@
>   * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
> +#include <dt-bindings/mux/mux.h>
> +
> +#include "k3-serdes.h"
> +
>  &cbass_main {
>  	msmc_ram: sram@70000000 {
>  		compatible = "mmio-sram";
> @@ -26,6 +30,42 @@ l3cache-sram@200000 {
>  		};
>  	};
>  
> +	scm_conf: syscon@100000 {
> +		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";

Would'nt a simple-bus work?
https://lore.kernel.org/all/20230605205220.rjmcsi5tjn4auqa7@arose/

> +		reg = <0x00 0x00100000 0x00 0x1c000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x00 0x00 0x00100000 0x1c000>;
> +
> +		serdes_ln_ctrl: mux-controller@4080 {
> +			compatible = "mmio-mux";
> +			reg = <0x00004080 0x30>;
> +			#mux-control-cells = <1>;
> +			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
> +					<0x4088 0x3>, <0x408c 0x3>, /* SERDES0 lane2/3 select */
> +					<0x4090 0x3>, <0x4094 0x3>, /* SERDES1 lane0/1 select */
> +					<0x4098 0x3>, <0x409c 0x3>, /* SERDES1 lane2/3 select */
> +					<0x40a0 0x3>, <0x40a4 0x3>, /* SERDES2 lane0/1 select */
> +					<0x40a8 0x3>, <0x40ac 0x3>; /* SERDES2 lane2/3 select */
> +			idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>,
> +				      <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
> +				      <J784S4_SERDES0_LANE2_IP3_UNUSED>,
> +				      <J784S4_SERDES0_LANE3_USB>,
> +				      <J784S4_SERDES1_LANE0_PCIE0_LANE0>,
> +				      <J784S4_SERDES1_LANE1_PCIE0_LANE1>,
> +				      <J784S4_SERDES1_LANE2_PCIE0_LANE2>,
> +				      <J784S4_SERDES1_LANE3_PCIE0_LANE3>,
> +				      <J784S4_SERDES2_LANE0_IP2_UNUSED>,
> +				      <J784S4_SERDES2_LANE1_IP2_UNUSED>,
> +				      <J784S4_SERDES2_LANE2_QSGMII_LANE1>,
> +				      <J784S4_SERDES2_LANE3_QSGMII_LANE2>,
> +				      <J784S4_SERDES4_LANE0_EDP_LANE0>,
> +				      <J784S4_SERDES4_LANE1_EDP_LANE1>,
> +				      <J784S4_SERDES4_LANE2_EDP_LANE2>,
> +				      <J784S4_SERDES4_LANE3_EDP_LANE3>;
> +		};
> +	};
> +
>  	gic500: interrupt-controller@1800000 {
>  		compatible = "arm,gic-v3";
>  		#address-cells = <2>;
> -- 
> 2.25.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
