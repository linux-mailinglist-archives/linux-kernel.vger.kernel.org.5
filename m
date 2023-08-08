Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D96E774477
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbjHHSTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbjHHSTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:19:18 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6965C7A80;
        Tue,  8 Aug 2023 10:27:29 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3786Js4k115343;
        Tue, 8 Aug 2023 01:19:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691475594;
        bh=qXeLXv9cwggeGLFsKH3cSDIDy3dkXj2bDmKM6h5St+s=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=DDZzCaYaqRkjdWM0xzqwaAaRK8LeAPfJPBfS/5Vsx0iOqQgqvbLbD9iNpy/mZBVSH
         rXVScs2Nu1vMXC/OPbjF9S0yuKSYhn781oqBlyHEDyofsBlwucQODNnZrTTcE0hWgv
         U1uZCv/ToDnSqICYTZNNrNUKMAXKPxoSd0T86paY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3786Jspe112979
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 01:19:54 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 01:19:53 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 01:19:53 -0500
Received: from [172.24.227.112] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3786JmDV053446;
        Tue, 8 Aug 2023 01:19:49 -0500
Message-ID: <c17f84f6-2c9a-a211-3323-f639d64e1d98@ti.com>
Date:   Tue, 8 Aug 2023 11:49:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/6] arm64: dts: ti: k3-am62-main: Add node for DSS
To:     Aradhya Bhatia <a-bhatia1@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>
CC:     Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>, Jai Luthra <j-luthra@ti.com>
References: <20230807153307.22174-1-a-bhatia1@ti.com>
 <20230807153307.22174-3-a-bhatia1@ti.com>
Content-Language: en-US
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20230807153307.22174-3-a-bhatia1@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Aradhya,

On 07/08/23 21:03, Aradhya Bhatia wrote:
> Add Display SubSystem (DSS) DT node for the AM625 SoC.
> 
> The DSS supports one each of video pipeline (vid) and video-lite
> pipeline (vidl1). It outputs OLDI signals on one video port (VP1) and
> DPI signals on another (VP2). The video ports are connected to the
> pipelines via 2 identical overlay managers (ovr1 and ovr2).
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 25 ++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index ef90b2bc81eb..6cdca8df1091 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -717,6 +717,31 @@ cpts@3d000 {
>   		};
>   	};
>   
> +	dss: dss@30200000 {
> +		compatible = "ti,am625-dss";
> +		reg = <0x00 0x30200000 0x00 0x1000>, /* common */
> +		      <0x00 0x30202000 0x00 0x1000>, /* vidl1 */
> +		      <0x00 0x30206000 0x00 0x1000>, /* vid */
> +		      <0x00 0x30207000 0x00 0x1000>, /* ovr1 */
> +		      <0x00 0x30208000 0x00 0x1000>, /* ovr2 */
> +		      <0x00 0x3020a000 0x00 0x1000>, /* vp1: Used for OLDI */
> +		      <0x00 0x3020b000 0x00 0x1000>; /* vp2: Used as DPI Out */
> +		reg-names = "common", "vidl1", "vid",
> +			"ovr1", "ovr2", "vp1", "vp2";

Indentation is off here.

> +		power-domains = <&k3_pds 186 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 186 6>,
> +			 <&k3_clks 186 0>,
> +			 <&k3_clks 186 2>;
> +		clock-names = "fck", "vp1", "vp2";
> +		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> +		status = "disabled";
> +
> +		dss_ports: ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +
>   	hwspinlock: spinlock@2a000000 {
>   		compatible = "ti,am64-hwspinlock";
>   		reg = <0x00 0x2a000000 0x00 0x1000>;
