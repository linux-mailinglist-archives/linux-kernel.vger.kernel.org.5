Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB1A770915
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjHDTdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjHDTdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:33:19 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8587B1BF;
        Fri,  4 Aug 2023 12:33:16 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 374JX9x3046270;
        Fri, 4 Aug 2023 14:33:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691177589;
        bh=mQDQFqa0n+H60Oqqvk7momwKMAfsiO5YEfswGwzqRk4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=kFBy5faYyBY/j02HXvvb+R4dMFQjiEapyNabpX6rHUYycvd22c6p0tVq5C0TFAsB+
         psEwKeVU9+HVT7bvUlxSyNR6NCN0vqlmiwpMw9UjfKUOOnNOO0rTDNdJt6bPjU2c8H
         /ZaW89p3N2lfaZqHRd83bt/Kqr5LzGb9n+lRzteg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 374JX9NQ003385
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Aug 2023 14:33:09 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Aug 2023 14:33:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Aug 2023 14:33:08 -0500
Received: from [10.249.132.69] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 374JX38u034091;
        Fri, 4 Aug 2023 14:33:04 -0500
Message-ID: <db05ca30-c31e-1c4a-95b5-ae15b85ce3bc@ti.com>
Date:   Sat, 5 Aug 2023 01:03:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v9 3/5] arm64: dts: ti: k3-j784s4-main: Add DSS and
 DP-bridge node
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <afd@ti.com>, <rogerq@kernel.org>
CC:     <s-vadapalli@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <r-ravikumar@ti.com>, <sabiya.d@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230803080441.367341-1-j-choudhary@ti.com>
 <20230803080441.367341-4-j-choudhary@ti.com>
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20230803080441.367341-4-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03-Aug-23 13:34, Jayesh Choudhary wrote:
> From: Rahul T R <r-ravikumar@ti.com>
> 
> Add DSS and DP-bridge node for J784S4 SoC. DSS IP in J784S4 is
> same as DSS IP in J721E, so same compatible is being used.
> The DP is Cadence MHDP8546.
DP-bridge

> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> [j-choudhary@ti.com: move dss & mhdp node together in main, fix dss node]
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>

Given that you make appropriate changes with properties in this patch,
wrt patches 4/5 and 5/5,

Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>

> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index 446d7efa715f..824312b9ef9f 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -1741,4 +1741,67 @@ c71_3: dsp@67800000 {
>  		resets = <&k3_reset 40 1>;
>  		firmware-name = "j784s4-c71_3-fw";
>  	};
> +
> +	mhdp: bridge@a000000 {
> +		compatible = "ti,j721e-mhdp8546";
> +		reg = <0x0 0xa000000 0x0 0x30a00>,
> +		      <0x0 0x4f40000 0x0 0x20>;
> +		reg-names = "mhdptx", "j721e-intg";
> +		clocks = <&k3_clks 217 11>;
> +		interrupt-parent = <&gic500>;
> +		interrupts = <GIC_SPI 614 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 217 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
> +
> +		dp0_ports: ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +
> +	dss: dss@4a00000 {
> +		compatible = "ti,j721e-dss";
> +		reg = <0x00 0x04a00000 0x00 0x10000>, /* common_m */
> +		      <0x00 0x04a10000 0x00 0x10000>, /* common_s0*/
> +		      <0x00 0x04b00000 0x00 0x10000>, /* common_s1*/
> +		      <0x00 0x04b10000 0x00 0x10000>, /* common_s2*/
> +		      <0x00 0x04a20000 0x00 0x10000>, /* vidl1 */
> +		      <0x00 0x04a30000 0x00 0x10000>, /* vidl2 */
> +		      <0x00 0x04a50000 0x00 0x10000>, /* vid1 */
> +		      <0x00 0x04a60000 0x00 0x10000>, /* vid2 */
> +		      <0x00 0x04a70000 0x00 0x10000>, /* ovr1 */
> +		      <0x00 0x04a90000 0x00 0x10000>, /* ovr2 */
> +		      <0x00 0x04ab0000 0x00 0x10000>, /* ovr3 */
> +		      <0x00 0x04ad0000 0x00 0x10000>, /* ovr4 */
> +		      <0x00 0x04a80000 0x00 0x10000>, /* vp1 */
> +		      <0x00 0x04aa0000 0x00 0x10000>, /* vp1 */
> +		      <0x00 0x04ac0000 0x00 0x10000>, /* vp1 */
> +		      <0x00 0x04ae0000 0x00 0x10000>, /* vp4 */
> +		      <0x00 0x04af0000 0x00 0x10000>; /* wb */
> +		reg-names = "common_m", "common_s0",
> +			    "common_s1", "common_s2",
> +			    "vidl1", "vidl2","vid1","vid2",
> +			    "ovr1", "ovr2", "ovr3", "ovr4",
> +			    "vp1", "vp2", "vp3", "vp4",
> +			    "wb";
> +		clocks = <&k3_clks 218 0>,
> +			 <&k3_clks 218 2>,
> +			 <&k3_clks 218 5>,
> +			 <&k3_clks 218 14>,
> +			 <&k3_clks 218 18>;
> +		clock-names = "fck", "vp1", "vp2", "vp3", "vp4";
> +		power-domains = <&k3_pds 218 TI_SCI_PD_EXCLUSIVE>;
> +		interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "common_m",
> +				  "common_s0",
> +				  "common_s1",
> +				  "common_s2";
> +		status = "disabled";
> +
> +		dss_ports: ports {
> +		};
> +	};
>  };
