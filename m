Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850CC80EEE9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376839AbjLLOgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376799AbjLLOgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:36:46 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4993BED;
        Tue, 12 Dec 2023 06:36:51 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BCEaeNx103930;
        Tue, 12 Dec 2023 08:36:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702391800;
        bh=cACDINKX/NHaJbO2EEIFjsKsxwauenGaOvSIM4XU+YI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=GHScZKdA1s4vcjIOBkAsB8Dz5SOs6uRPGA2J+b94vsI21fDtpG3UgzmNhGR2bLCDv
         GvZIGWKvpIDiuLMDJfVXKNPib5B8YSlK/cqZXgDqKRbEJrlEN0yPc5qSp3h1eAoQSu
         XmaKRLAcVJkq3LBzGyloS+ZbBr+PkgL7oFJ1DUOI=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BCEaee8017392
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Dec 2023 08:36:40 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Dec 2023 08:36:40 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Dec 2023 08:36:40 -0600
Received: from [10.247.16.251] (ula0226330.dhcp.ti.com [10.247.16.251])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BCEad2B063051;
        Tue, 12 Dec 2023 08:36:39 -0600
Message-ID: <5c92ae04-f8c3-40b4-a727-ac7ea5df4295@ti.com>
Date:   Tue, 12 Dec 2023 08:36:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64: dts: ti: k3-j721e-evm: Add overlay for
 PCIE0 Endpoint Mode
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>
References: <20231211115535.1264353-1-s-vadapalli@ti.com>
 <20231211115535.1264353-2-s-vadapalli@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20231211115535.1264353-2-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 5:55 AM, Siddharth Vadapalli wrote:
> Add overlay to enable the PCIE0 instance of PCIe on J721E-EVM in
> Endpoint mode of operation.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>   arch/arm64/boot/dts/ti/Makefile               |  6 ++-
>   .../boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso    | 53 +++++++++++++++++++
>   2 files changed, 58 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 1ac47876bc99..c6606b7678a3 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -67,6 +67,7 @@ k3-j721e-evm-dtbs := k3-j721e-common-proc-board.dtb k3-j721e-evm-quad-port-eth-e
>   dtb-$(CONFIG_ARCH_K3) += k3-j721e-beagleboneai64.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-gesi-exp-board.dtbo
> +dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-pcie0-ep.dtbo

See, much easier :)

Reviewed-by: Andrew Davis <afd@ti.com>

>   dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
>   
>   # Boards with J721s2 SoC
> @@ -103,6 +104,8 @@ k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
>   	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
>   k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs := \
>   	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
> +k3-j721e-evm-pcie0-ep-dtbs := k3-j721e-common-proc-board.dtb \
> +	k3-j721e-evm-pcie0-ep.dtbo
>   dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
>   	k3-am625-beagleplay-csi2-tevi-ov5640.dtb \
>   	k3-am625-sk-csi2-imx219.dtb \
> @@ -113,7 +116,8 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
>   	k3-am62a7-sk-csi2-imx219.dtb \
>   	k3-am62a7-sk-csi2-ov5640.dtb \
>   	k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb \
> -	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb
> +	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
> +	k3-j721e-evm-pcie0-ep.dtb
>   
>   # Enable support for device-tree overlays
>   DTC_FLAGS_k3-am625-beagleplay += -@
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso b/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso
> new file mode 100644
> index 000000000000..0c82a13b65a4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * DT Overlay for enabling PCIE0 instance in Endpoint Configuration with the
> + * J7 common processor board.
> + *
> + * J7 Common Processor Board Product Link: https://www.ti.com/tool/J721EXCPXEVM
> + *
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/soc/ti,sci_pm_domain.h>
> +
> +#include "k3-pinctrl.h"
> +
> +/*
> + * Since Root Complex and Endpoint modes are mutually exclusive
> + * disable Root Complex mode.
> + */
> +&pcie0_rc {
> +	status = "disabled";
> +};
> +
> +&cbass_main {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	interrupt-parent = <&gic500>;
> +
> +	pcie0_ep: pcie-ep@2900000 {
> +		compatible = "ti,j721e-pcie-ep";
> +		reg = <0x00 0x02900000 0x00 0x1000>,
> +		      <0x00 0x02907000 0x00 0x400>,
> +		      <0x00 0x0d000000 0x00 0x00800000>,
> +		      <0x00 0x10000000 0x00 0x08000000>;
> +		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
> +		interrupt-names = "link_state";
> +		interrupts = <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
> +		ti,syscon-pcie-ctrl = <&scm_conf 0x4070>;
> +		max-link-speed = <3>;
> +		num-lanes = <1>;
> +		power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 239 1>;
> +		clock-names = "fck";
> +		max-functions = /bits/ 8 <6>;
> +		max-virtual-functions = /bits/ 8 <4 4 4 4 0 0>;
> +		dma-coherent;
> +		phys = <&serdes0_pcie_link>;
> +		phy-names = "pcie-phy";
> +	};
> +};
