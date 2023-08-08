Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D576777416E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbjHHRUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbjHHRUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:20:00 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3492E2D79;
        Tue,  8 Aug 2023 09:08:01 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378C87DW006713;
        Tue, 8 Aug 2023 07:08:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691496487;
        bh=VnOCs6UaJwX+cbaWHIHII7/eUBileZ4AqfuZy1fwOkg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=eEfKxtcvjyIfdPz0HYNI2Ssmg9LVHvS8gqZze2WwerEu1JStcoUk9LTBsrBuFtFmF
         SNTAogfdzvcPqZFVKVvg6TXhLT/FaiHk3qpUjbfpLQwa7irSloT6XfIp+jYiAk9/zh
         VnpsDviloZnI/q6pO3eaD6nxTjAssanI+hGJHR6k=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378C87e3080374
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 07:08:07 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 07:08:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 07:08:06 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378C86CT032757;
        Tue, 8 Aug 2023 07:08:06 -0500
Date:   Tue, 8 Aug 2023 07:08:06 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Hari Nagalla <hnagalla@ti.com>
CC:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <p.zabel@pengutronix.de>, <martyn.welch@collabora.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 3/5] arm64: dts: ti: k3-am64 : Add M4F remote proc node
Message-ID: <20230808120806.5ymcvsqgg2kv65qq@arson>
References: <20230808044529.25925-1-hnagalla@ti.com>
 <20230808044529.25925-4-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230808044529.25925-4-hnagalla@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23:45-20230807, Hari Nagalla wrote:
> The AM64x SoCs of the TI K3 family have a Cortex M4F core in the MCU
> domain. This core can be used by non safety applications as a remote
> processor. When used as a remote processor with virtio/rpmessage IPC,
> two carveout reserved memory nodes are needed. The first region is used
> as a DMA pool for the rproc device, and the second region will furnish
> the static carveout regions for the firmware memory.
> 
> The current carveout addresses and sizes are defined statically for
> each rproc device. The M4F processor do not have an MMU, and as such
> require the exact memory used by the firmware to be set-aside.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
> Changes in v5:
>  - Add M4F device node patches to the patch list

This will need to be reviewed after driver changes are complete and
should go through the SoC tree.

> 
>  arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi | 12 ++++++++++++
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts | 18 ++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts  | 18 ++++++++++++++++++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
> index 686d49790721..4151d0057bc8 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
> @@ -158,4 +158,16 @@ mcu_esm: esm@4100000 {
>  		reg = <0x00 0x4100000 0x00 0x1000>;
>  		ti,esm-pins = <0>, <1>;
>  	};
> +
> +	mcu_m4fss: m4fss@5000000 {
> +		compatible = "ti,am64-m4fss";
> +		reg = <0x00 0x5000000 0x00 0x30000>,
> +		<0x00 0x5040000 0x00 0x10000>;
> +		reg-names = "iram", "dram";
> +		ti,sci = <&dmsc>;
> +		ti,sci-dev-id = <9>;
> +		ti,sci-proc-ids = <0x18 0xff>;
> +		resets = <&k3_reset 9 1>;
> +		firmware-name = "am64-mcu-m4f0_0-fw";
> +	};
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> index d84e7ee16032..4fd1dc162534 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> @@ -99,6 +99,18 @@ main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
>  			no-map;
>  		};
>  
> +		mcu_m4fss_dma_memory_region: m4f-dma-memory@a4000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa4000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		mcu_m4fss_memory_region: m4f-memory@a4100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa4100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
>  		rtos_ipc_memory_region: ipc-memories@a5000000 {
>  			reg = <0x00 0xa5000000 0x00 0x00800000>;
>  			alignment = <0x1000>;
> @@ -639,6 +651,12 @@ &main_r5fss1_core1 {
>  			<&main_r5fss1_core1_memory_region>;
>  };
>  
> +&mcu_m4fss {
> +	mboxes = <&mailbox0_cluster6>, <&mbox_m4_0>;
> +	memory-region = <&mcu_m4fss_dma_memory_region>,
> +			<&mcu_m4fss_memory_region>;
> +};
> +
>  &serdes_ln_ctrl {
>  	idle-states = <AM64_SERDES0_LANE0_PCIE0>;
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> index 963d796a3a97..f919dd5ba9ba 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> @@ -98,6 +98,18 @@ main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
>  			no-map;
>  		};
>  
> +		mcu_m4fss_dma_memory_region: m4f-dma-memory@a4000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa4000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		mcu_m4fss_memory_region: m4f-memory@a4100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa4100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
>  		rtos_ipc_memory_region: ipc-memories@a5000000 {
>  			reg = <0x00 0xa5000000 0x00 0x00800000>;
>  			alignment = <0x1000>;
> @@ -637,6 +649,12 @@ &main_r5fss1_core1 {
>  			<&main_r5fss1_core1_memory_region>;
>  };
>  
> +&mcu_m4fss {
> +	mboxes = <&mailbox0_cluster6>, <&mbox_m4_0>;
> +	memory-region = <&mcu_m4fss_dma_memory_region>,
> +			<&mcu_m4fss_memory_region>;
> +};
> +
>  &ecap0 {
>  	status = "okay";
>  	/* PWM is available on Pin 1 of header J3 */
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
