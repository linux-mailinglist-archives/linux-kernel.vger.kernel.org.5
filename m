Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E54805C32
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjLEQNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLEQNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:13:17 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A8D9E;
        Tue,  5 Dec 2023 08:13:22 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B5GD8oE130667;
        Tue, 5 Dec 2023 10:13:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701792788;
        bh=hV74SP8aQqHLR+Ir12KG2Sb61JQrmfg9au5Yy62/M9w=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=MBmWascIjkIHdrKUhqfCF6gZLtJ2f3gKGzd0rAo+Xgo1xYBDOPvBoirlfrXSaA0uN
         +DMXBMazbuufvrdcVPWo5NEuZh6n6eog8VXkySSKHJ4B0893VJAVlRhJXcrtZcC1Wk
         esnh7+M+UvhoADPMAJNuqUzaIaspVQfps1qtVUjY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B5GD8OQ091013
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Dec 2023 10:13:08 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Dec 2023 10:13:08 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Dec 2023 10:13:07 -0600
Received: from [10.249.36.163] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B5GD7Me104930;
        Tue, 5 Dec 2023 10:13:07 -0600
Message-ID: <c50f5dc2-8ab8-4213-a809-fcd4cd18589d@ti.com>
Date:   Tue, 5 Dec 2023 10:13:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-j721e-evm: Add overlay for
 PCIE0 Endpoint Mode
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>
References: <20231115085204.3578616-1-s-vadapalli@ti.com>
 <20231115085204.3578616-2-s-vadapalli@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20231115085204.3578616-2-s-vadapalli@ti.com>
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

On 11/15/23 2:52 AM, Siddharth Vadapalli wrote:
> Add overlay to enable the PCIE0 instance of PCIe on J721E-EVM in
> Endpoint mode of operation.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>   arch/arm64/boot/dts/ti/Makefile               |  3 ++
>   .../boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso    | 53 +++++++++++++++++++
>   2 files changed, 56 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 77a347f9f47d..5620db44d4dc 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -66,6 +66,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-j7200-evm.dtb
>   k3-j721e-evm-dtbs := k3-j721e-common-proc-board.dtb k3-j721e-evm-quad-port-eth-exp.dtbo
>   dtb-$(CONFIG_ARCH_K3) += k3-j721e-beagleboneai64.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm.dtb
> +k3-j721e-evm-pcie0-ep-dtbs := k3-j721e-evm.dtb k3-j721e-evm-pcie0-ep.dtbo
> +dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-pcie0-ep.dtb

Do you really need to produce this pre-combined DTB file? If you would rather
just the overlay produced which could be applied at load-time (I prefer this),
then you should do as Jai has done[0]. Add just the overlay, and test its
application using a dummy target.

Andrew

[0] https://www.spinics.net/lists/kernel/msg5015247.html

>   dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-gesi-exp-board.dtbo
>   dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
>   
> @@ -85,4 +87,5 @@ DTC_FLAGS_k3-am625-sk += -@
>   DTC_FLAGS_k3-am62-lp-sk += -@
>   DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
>   DTC_FLAGS_k3-j721e-common-proc-board += -@
> +DTC_FLAGS_k3-j721e-evm += -@
>   DTC_FLAGS_k3-j721s2-common-proc-board += -@
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
