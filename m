Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849A477416A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjHHRTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjHHRTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:19:22 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDF391E310;
        Tue,  8 Aug 2023 09:07:49 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378C7mkK006666;
        Tue, 8 Aug 2023 07:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691496468;
        bh=mTrgJHTKlbCPA9bSNBGepGmQ7pNiH5KTgWDq1iuqoEU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=yhiiPJgk+N3G402Uevmgp/EmJc4g08M1bU7MLksoNn29VARTr2mG7du2c31Iw2PVy
         g60wSJA/6pzj2VnZ50AakgV11TnwtA9KzPWkpHQmqfMOLLVkvAEkBGzAB/278pmIeN
         rhs6ekRH1thPTqM9O7B/BYVjxYrKCaq4GnkC0gBQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378C7mZh001544
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 07:07:48 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 07:07:48 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 07:07:48 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378C7mvp111857;
        Tue, 8 Aug 2023 07:07:48 -0500
Date:   Tue, 8 Aug 2023 07:07:48 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Hari Nagalla <hnagalla@ti.com>
CC:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <p.zabel@pengutronix.de>, <martyn.welch@collabora.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 2/5] arm64: dts: ti: k3-am62 : Add M4F remote proc node
Message-ID: <20230808120748.se3fdsja5ow5hqnc@trustless>
References: <20230808044529.25925-1-hnagalla@ti.com>
 <20230808044529.25925-3-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230808044529.25925-3-hnagalla@ti.com>
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
> The AM62x SoCs of the TI K3 family have a Cortex M4F core in the MCU
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
>  - Add the M4F device tree node patches to the patch list 

This will need to be reviewed after driver changes are complete and
should go through the SoC tree.

> 
>  arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi       | 12 ++++++++++++
>  .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 19 +++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
> index 80a3e1db26a9..4b55df1da751 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
> @@ -171,4 +171,16 @@ mcu_mcan1: can@4e18000 {
>  		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
>  		status = "disabled";
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
> +		firmware-name = "am62-mcu-m4f0_0-fw";
> +	};
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> index 34c8ffc553ec..ffca61fcf9ba 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> @@ -47,6 +47,18 @@ ramoops@9ca00000 {
>  			pmsg-size = <0x8000>;
>  		};
>  
> +		mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9cb00000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		mcu_m4fss_memory_region: m4f-memory@9cc00000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9cc00000 0x00 0xe00000>;
> +			no-map;
> +		};
> +
>  		secure_tfa_ddr: tfa@9e780000 {
>  			reg = <0x00 0x9e780000 0x00 0x80000>;
>  			alignment = <0x1000>;
> @@ -362,6 +374,13 @@ mbox_m4_0: mbox-m4-0 {
>  	};
>  };
>  
> +&mcu_m4fss {
> +	mboxes = <&mailbox0_cluster0>, <&mbox_m4_0>;
> +	memory-region = <&mcu_m4fss_dma_memory_region>,
> +			<&mcu_m4fss_memory_region>;
> +	sram = <&oc_sram>;
> +};
> +
>  &usbss0 {
>  	status = "okay";
>  	ti,vbus-divider;
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
