Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F9C772E7D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjHGTHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHGTHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:07:49 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70481701;
        Mon,  7 Aug 2023 12:07:48 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377J7dFs098704;
        Mon, 7 Aug 2023 14:07:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691435259;
        bh=KxazVsFzy03RD30/1KgFYKMblJSqL3Mk1P2zfXt/Zzk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=jZAYllSvkSKt9QkIrwVZn/LtZUjqz+5O6qOC1joDD1BQWzDQRoJUNfUAGlQ//hiv5
         EzrVAXHhksso9HhM9/YZWSgaDyRjqvO44KSfwfxk1qe+DnqZuAJxv8dbVUBrsd4DBn
         BDlLOpa9ADhmL9Wa47rNp7K2DiS96NrNEWYdwlBY=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377J7dfZ118355
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 14:07:39 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 14:07:39 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 14:07:39 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377J7d7j092863;
        Mon, 7 Aug 2023 14:07:39 -0500
Date:   Mon, 7 Aug 2023 14:07:39 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Apurva Nandan <a-nandan@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar <u-kumar1@ti.com>, Hari Nagalla <hnagalla@ti.com>,
        Dasnavis Sabiya <sabiya.d@mistralsolutions.com>,
        Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 1/4] arm64: dts: ti: k3-j784s4-main: Add
 bootph-pre-ram property for SPL nodes
Message-ID: <20230807190739.a33f5piskapfphxh@blatantly>
References: <20230807185645.128751-1-a-nandan@ti.com>
 <20230807185645.128751-2-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230807185645.128751-2-a-nandan@ti.com>
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

On 00:26-20230808, Apurva Nandan wrote:
> Add bootph-pre-ram property for all the nodes used in SPL stage,
> for syncing it later to u-boot j784s4 dts.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---

We need to rework this a little more:

The approach taken in this series is enable pre-ram for everything. I am
not sure that is the right direction.

https://github.com/devicetree-org/dt-schema/blob/e87ba2f515392c2a4694642063efb43023331ff6/dtschema/schemas/bootph.yaml#L70

patch #1: board generic changes: patch #1
patch #2-: board specific change (per board)

Make sure you use the correct property and document why this is needed
in the section added as well - esp for board generic changes introduced
into SoC.dtsi files.


>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index 2ea0adae6832..aaec569fe91a 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -6,6 +6,7 @@
>   */
>  
>  &cbass_main {
> +	bootph-pre-ram;

Is this better done where the node is defined?

>  	msmc_ram: sram@70000000 {
>  		compatible = "mmio-sram";
>  		reg = <0x00 0x70000000 0x00 0x800000>;
> @@ -670,6 +671,7 @@ main_sdhci1: mmc@4fb0000 {
>  	};
>  
>  	main_navss: bus@30000000 {
> +		bootph-pre-ram;
>  		compatible = "simple-bus";
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -705,6 +707,7 @@ main_udmass_inta: msi-controller@33d00000 {
>  		};
>  
>  		secure_proxy_main: mailbox@32c00000 {
> +			bootph-pre-ram;
>  			compatible = "ti,am654-secure-proxy";
>  			#mbox-cells = <1>;
>  			reg-names = "target_data", "rt", "scfg";
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
