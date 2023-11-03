Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E887DFD86
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 01:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjKCARj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 20:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjKCARh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 20:17:37 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB1018B;
        Thu,  2 Nov 2023 17:17:31 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A30H7I7092746;
        Thu, 2 Nov 2023 19:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698970627;
        bh=RgzIT9OB6Zeq4JHzbfNAKMnpLwUj791MZhEp6sdxjTQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=YMx2G7c9HGs0NqnCm/+reyBAluxZYmi8fuSzvSuhW26gV43TxKPrzq6oc/+xV37MP
         5YPQxjw/oUAqcxVgleCecwcNy9GWi7Z5aU7Pbk9sPnqagTLJgFerWHXHqIPzDZ0Qz5
         +dRuQ/5obIpR1uSMCgAjzirReeRU2EnV+1r+9SBw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A30H76U009629
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Nov 2023 19:17:07 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 Nov 2023 19:17:07 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 Nov 2023 19:17:07 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A30H7Bd013139;
        Thu, 2 Nov 2023 19:17:07 -0500
Date:   Thu, 2 Nov 2023 19:17:07 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Garrett Giordano <ggiordano@phytec.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <r-gunasekaran@ti.com>, <w.egorov@phytec.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <upstream@ls-patchwork.phytec.de>
Subject: Re: [PATCH] arm64: dts: ti: phycore-am64: Add R5F DMA Region and
 Mailboxes
Message-ID: <20231103001707.2ktwfgtqegpfiijy@subpanel>
References: <20231102201216.3771589-1-ggiordano@phytec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231102201216.3771589-1-ggiordano@phytec.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:12-20231102, Garrett Giordano wrote:
> Communication between the R5F subsystem and Linux takes place using DMA
> memory regions and mailboxes. Here we add DT nodes for the memory
> regions and mailboxes to facilitate communication between the R5
> clusters and Linux as remoteproc will fail to start if no memory
> regions or mailboxes are provided.
> 
> Fixes: c48ac0efe6d7 ("arm64: dts: ti: Add support for phyBOARD-Electra-AM642")

is this fixes? Sounds more or less like rproc support is added in?

> Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
> ---
>  .../boot/dts/ti/k3-am64-phycore-som.dtsi      | 102 +++++++++++++++++-
>  1 file changed, 101 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> index 1c2c8f0daca9..37a33006c1fc 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> @@ -29,7 +29,7 @@ memory@80000000 {
>  		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
>  	};
>  
> -	reserved-memory {
> +	reserved_memory: reserved-memory {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
>  		ranges;
> @@ -39,6 +39,54 @@ secure_ddr: optee@9e800000 {
>  			alignment = <0x1000>;
>  			no-map;
>  		};
> +
> +		main_r5fss0_core0_dma_memory_region: r5f-dma-memory@a0000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa0000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		main_r5fss0_core0_memory_region: r5f-memory@a0100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa0100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa1000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		main_r5fss0_core1_memory_region: r5f-memory@a1100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa1100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a2000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa2000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		main_r5fss1_core0_memory_region: r5f-memory@a2100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa2100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a3000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa3000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa3100000 0x00 0xf00000>;
> +			no-map;
> +		};
>  	};
>  
>  	leds {
> @@ -160,6 +208,34 @@ &cpsw_port2 {
>  	status = "disabled";
>  };
>  
> +&mailbox0_cluster2 {
> +	status = "okay";
> +
> +	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
> +		ti,mbox-rx = <0 0 2>;
> +		ti,mbox-tx = <1 0 2>;
> +	};
> +
> +	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
> +		ti,mbox-rx = <2 0 2>;
> +		ti,mbox-tx = <3 0 2>;
> +	};
> +};
> +
> +&mailbox0_cluster4 {
> +	status = "okay";
> +
> +	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
> +		ti,mbox-rx = <0 0 2>;
> +		ti,mbox-tx = <1 0 2>;
> +	};
> +
> +	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
> +		ti,mbox-rx = <2 0 2>;
> +		ti,mbox-tx = <3 0 2>;
> +	};
> +};
> +
>  &main_i2c0 {
>  	status = "okay";
>  	pinctrl-names = "default";
> @@ -180,6 +256,30 @@ i2c_som_rtc: rtc@52 {
>  	};
>  };
>  
> +&main_r5fss0_core0 {
> +	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
> +	memory-region = <&main_r5fss0_core0_dma_memory_region>,
> +			<&main_r5fss0_core0_memory_region>;
> +};
> +
> +&main_r5fss0_core1 {
> +	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
> +	memory-region = <&main_r5fss0_core1_dma_memory_region>,
> +			<&main_r5fss0_core1_memory_region>;
> +};
> +
> +&main_r5fss1_core0 {
> +	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
> +	memory-region = <&main_r5fss1_core0_dma_memory_region>,
> +			<&main_r5fss1_core0_memory_region>;
> +};
> +
> +&main_r5fss1_core1 {
> +	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
> +	memory-region = <&main_r5fss1_core1_dma_memory_region>,
> +			<&main_r5fss1_core1_memory_region>;
> +};
> +
>  &ospi0 {
>  	status = "okay";
>  	pinctrl-names = "default";
> -- 
> 2.25.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
