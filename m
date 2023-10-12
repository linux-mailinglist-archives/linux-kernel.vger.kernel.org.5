Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821D07C654E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377382AbjJLGTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377344AbjJLGTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:19:18 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF24C0;
        Wed, 11 Oct 2023 23:19:16 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39C6J852071256;
        Thu, 12 Oct 2023 01:19:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697091548;
        bh=miQX8MTzUqeSwHMeb3B/7LuIb3yBTO+3PxYQ/SssQ5I=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=t+TADjJaAOngkmYqdkeAxSmMKmOfJp3rwXuZ4SgK/k+OX709lf4NLtzmKUDj7mZXD
         Y6ekHdSQjcTinM63CosDJh4W1QI/RLlbvFcEEZ6xW4Rp1HeWPBtynImw6wwg4oTm+o
         QFJCQk0Hq2zZlcqBaAHDy+iBTX0INXEfw1NnkPDo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39C6J8AG095800
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Oct 2023 01:19:08 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Oct 2023 01:19:08 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Oct 2023 01:19:07 -0500
Received: from [172.24.227.112] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39C6IWk7014732;
        Thu, 12 Oct 2023 01:19:05 -0500
Message-ID: <064c1623-13ec-455f-bc21-6484048d9e89@ti.com>
Date:   Thu, 12 Oct 2023 11:49:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-j784s4-main: Add BCDMA instance
 for CSI2RX
Content-Language: en-US
To:     Vaishnav Achath <vaishnav.a@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>
References: <20231010111723.17524-1-vaishnav.a@ti.com>
 <20231010111723.17524-3-vaishnav.a@ti.com>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20231010111723.17524-3-vaishnav.a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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



On 10/10/23 16:47, Vaishnav Achath wrote:
> J784S4 has a dedicated BCDMA controller for the Camera Serial Interface.
> Events from the BCDMA controller instance are routed through the
> main UDMA interrupt aggregator as unmapped events. Add the node for
> the DMA controller and keep it disabled by default.
> 
> See J784S4 Technical Reference Manual (SPRUJ52)
> for further details: http://www.ti.com/lit/zip/spruj52
> 
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
> 
> V1->V2:
>      * Fix indentation for the reg entries.
> 
>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index efed2d683f63..3123413e2140 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -703,6 +703,7 @@
>   			ti,sci = <&sms>;
>   			ti,sci-dev-id = <321>;
>   			ti,interrupt-ranges = <0 0 256>;
> +			ti,unmapped-event-sources = <&main_bcdma_csi>;
>   		};
>   
>   		secure_proxy_main: mailbox@32c00000 {
> @@ -1000,6 +1001,22 @@
>   			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
>   		};
>   
> +		main_bcdma_csi: dma-controller@311a0000 {
> +			compatible = "ti,j721s2-dmss-bcdma-csi";
> +			reg = <0x00 0x311a0000 0x00 0x100>,
> +			      <0x00 0x35d00000 0x00 0x20000>,
> +			      <0x00 0x35c00000 0x00 0x10000>,
> +			      <0x00 0x35e00000 0x00 0x80000>;
> +			reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt";
> +			msi-parent = <&main_udmass_inta>;
> +			#dma-cells = <3>;
> +			ti,sci = <&sms>;
> +			ti,sci-dev-id = <281>;
> +			ti,sci-rm-range-rchan = <0x21>;
> +			ti,sci-rm-range-tchan = <0x22>;
> +			status = "disabled";
> +		};
> +

Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>

>   		cpts@310d0000 {
>   			compatible = "ti,j721e-cpts";
>   			reg = <0x00 0x310d0000 0x00 0x400>;
