Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD69676C3A5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 05:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjHBDmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 23:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjHBDlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 23:41:53 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395FF173A;
        Tue,  1 Aug 2023 20:41:51 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3723fWjP085292;
        Tue, 1 Aug 2023 22:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690947692;
        bh=9UgweaCuZWYVCgmgViLTwRNEVAIxTMWqGNWmFfAnE/Y=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=EZ6SUjl06iSLYt8s3QtmMp2slVad8c/3LVgPXBluINySlf+nxG6YchM17owH/BKkw
         oP4Pm51mNe/EEQk5h+SvnBuVAWkkyY2Y82guJDhFcuYbIW0BPy2uu0DPfKirJBvf5P
         dKMexQkb6u3YH8cKWmxJmazkJPtKR72JV8w1B04s=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3723fWkD127251
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Aug 2023 22:41:32 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Aug 2023 22:41:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Aug 2023 22:41:31 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3723fViw095150;
        Tue, 1 Aug 2023 22:41:31 -0500
Date:   Tue, 1 Aug 2023 22:41:31 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Judith Mendez <jm@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 1/2] arm64: dts: ti: k3-am62: Add MCU MCAN nodes
Message-ID: <20230802034131.ja53ksr24rhcks3c@justifier>
References: <20230724133612.37366-1-francesco@dolcini.it>
 <20230724133612.37366-2-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230724133612.37366-2-francesco@dolcini.it>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:36-20230724, Francesco Dolcini wrote:
> From: Judith Mendez <jm@ti.com>
> 
> On AM62x there are no hardware interrupts routed to A53 GIC
> interrupt controller for MCU MCAN IPs, so MCU MCAN nodes were
> omitted from MCU dtsi.
> 
> Timer polling was introduced in commits [1][2] so now add MCU MCAN nodes
> to the MCU dtsi for the Cortex A53.
> 
> [1] b382380c0d2d ("can: m_can: Add hrtimer to generate software interrupt")
> [2] bb410c03b999 ("dt-bindings: net: can: Remove interrupt properties for MCAN")

Check patch complains:
 +[2] bb410c03b999 ("dt-bindings: net: can: Remove interrupt properties for MCAN")
 +ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit bb410c03b999 ("dt-bindings: net: can: Remove interrupt properties for MCAN")'

Either use commit sha ("title") or just drop the para.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> [fd: fixed labels to match datasheet numbering, revised commit message,
>      fixed reg/reg-names order]
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
> index 19fc38157d94..fed50666d95b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
> @@ -147,4 +147,28 @@ mcu_rti0: watchdog@4880000 {
>  		/* Tightly coupled to M4F */
>  		status = "reserved";
>  	};
> +
> +	mcu_mcan0: can@4e00000 {
/bus@f0000/bus@4000000/can@4e00000: simple-bus unit address format error, expected "4e08000"

can@4e08000

> +		compatible = "bosch,m_can";
> +		reg = <0x00 0x4e08000 0x00 0x200>,
> +		      <0x00 0x4e00000 0x00 0x8000>;
> +		reg-names = "m_can", "message_ram";
> +		power-domains = <&k3_pds 188 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 188 6>, <&k3_clks 188 1>;
> +		clock-names = "hclk", "cclk";
> +		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
> +		status = "disabled";
> +	};
> +
> +	mcu_mcan1: can@4e10000 {

same: can@4e18000

> +		compatible = "bosch,m_can";
> +		reg = <0x00 0x4e18000 0x00 0x200>,
> +		      <0x00 0x4e10000 0x00 0x8000>;
> +		reg-names = "m_can", "message_ram";
> +		power-domains = <&k3_pds 189 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 189 6>, <&k3_clks 189 1>;
> +		clock-names = "hclk", "cclk";
> +		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
> +		status = "disabled";
> +	};
>  };
> -- 
> 2.25.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
