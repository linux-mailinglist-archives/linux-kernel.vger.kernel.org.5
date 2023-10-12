Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4CC7C654A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377305AbjJLGSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377264AbjJLGSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:18:52 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB95B7;
        Wed, 11 Oct 2023 23:18:50 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39C6IaxS111659;
        Thu, 12 Oct 2023 01:18:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697091516;
        bh=Qu3wEWyuX7nDdKEKE1MIhDbOjLDVkMGD93r0dJlKF9M=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=NE/XhMeVqpPKNU8AhSs6+tU0aXrINiYIOlgJgfRnXrAi2TUYB2zJ66uk2GJZBDbwd
         wEgEgNW1gCQwL8qwK6Fwf7gecbfprz202vJce/dsrkJ+cuU0+Zv5tow6McJhvVPzXJ
         vJYpqBrTm1E6vYoODDdvVyX3n8t1tkv8y7Ml1bhY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39C6Iak2107349
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Oct 2023 01:18:36 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Oct 2023 01:18:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Oct 2023 01:18:36 -0500
Received: from [172.24.227.112] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39C6IWk6014732;
        Thu, 12 Oct 2023 01:18:33 -0500
Message-ID: <8924b1b8-82ac-4d6d-8063-71ee3ce839c6@ti.com>
Date:   Thu, 12 Oct 2023 11:48:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-j721s2-main: Add BCDMA instance
 for CSI2RX
Content-Language: en-US
To:     Vaishnav Achath <vaishnav.a@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>
References: <20231010111723.17524-1-vaishnav.a@ti.com>
 <20231010111723.17524-2-vaishnav.a@ti.com>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20231010111723.17524-2-vaishnav.a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/23 16:47, Vaishnav Achath wrote:
> J721S2 has a dedicated BCDMA controller for the Camera Serial Interface.
> Events from the BCDMA controller instance are routed through the
> main UDMA interrupt aggregator as unmapped events. Add the node for
> the DMA controller and keep it disabled by default.
> 
> See J721S2 Technical Reference Manual (SPRUJ28)
> for further details: http://www.ti.com/lit/pdf/spruj28
> 
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
> 
> V1->V2:
>      * Fix indentation for the reg entries.
> 
>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index 6d32544c8881..d5d13d61ade3 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -807,6 +807,7 @@
>   			ti,sci = <&sms>;
>   			ti,sci-dev-id = <265>;
>   			ti,interrupt-ranges = <0 0 256>;
> +			ti,unmapped-event-sources = <&main_bcdma_csi>;
>   		};
>   
>   		secure_proxy_main: mailbox@32c00000 {
> @@ -1103,6 +1104,22 @@
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
> +			ti,sci-dev-id = <225>;
> +			ti,sci-rm-range-rchan = <0x21>;
> +			ti,sci-rm-range-tchan = <0x22>;
> +			status = "disabled";
> +		};
> +

Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>

Warm Regards.


>   		cpts@310d0000 {
>   			compatible = "ti,j721e-cpts";
>   			reg = <0x0 0x310d0000 0x0 0x400>;
