Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE58E76C4A9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 07:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjHBFOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 01:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjHBFOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 01:14:12 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDD91736;
        Tue,  1 Aug 2023 22:14:11 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3725E3Io018420;
        Wed, 2 Aug 2023 00:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690953243;
        bh=n4aigKabrSs75QcXiNTIKIjgLT6W4FsnITVc3fjQhhE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=QlaksAkPQ/uwx0Umhp4FNNJzOaDCWxjnVePM9l8qqb0npxqyM2FGGP13jlqZnFES7
         BElXI59abYvB1RNMRmwHk2CLL0puJU8HBUNsLIrfAPTSsQz2MS0XzCF+4TatP21EUA
         LpG7Qhqx0VrxqEuZ9hjTDHTjc5N2TR3mKMntm5nM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3725E3CE012656
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 00:14:03 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 00:14:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 00:14:03 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3725E2AN043159;
        Wed, 2 Aug 2023 00:14:02 -0500
Date:   Wed, 2 Aug 2023 00:14:02 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Judith Mendez <jm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  arm64: dts: ti: k3-am62a7: Add MCU MCAN nodes
Message-ID: <20230802051402.totwmtw2oadqrai7@herself>
References: <20230724183844.635319-1-jm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230724183844.635319-1-jm@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:38-20230724, Judith Mendez wrote:
> On AM62ax there are no hardware interrupts routed to A53 GIC
> interrupt controller for MCU MCAN IPs, so MCU MCAN nodes were
> omitted from MCU dtsi.
> 
> Timer polling was introduced in commits [1][2] enabling 3x MCAN
> on AM62ax, so now add MCU MCAN nodes to the mcu dtsi for the Cortex A53.
> 
> [1] commit b382380c0d2d ("can: m_can: Add hrtimer to generate software interrupt")
> [2] commit bb410c03b999 ("dt-bindings: net: can: Remove interrupt properties for MCAN")
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
> index 04599762c2b7..3fca702e7f2d 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
> @@ -143,4 +143,28 @@ mcu_rti0: watchdog@4880000 {
>  		/* Tightly coupled to M4F */
>  		status = "reserved";
>  	};
> +
> +	mcu_mcan0: can@4e00000 {

s/4e00000/4e08000

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

s/4e10000/4e18000

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
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
