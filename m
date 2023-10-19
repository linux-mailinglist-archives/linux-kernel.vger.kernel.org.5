Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A067CEF71
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjJSFzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSFzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:55:48 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2B1B6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 22:55:46 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39J5tZGa093021;
        Thu, 19 Oct 2023 00:55:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697694935;
        bh=ArJauoiS4c+Rg2OUYmcejneHBpY4dxB+JR4rD3rs5so=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=XWoYvYOoAzHMQMkeREZLFeJDqw+gmzH9lA+qMza6sEzskVcRLuxx6U49Ip71lEiC/
         TXvmNhgWPxWiEEDUUTBCDOs8Vwe9bzt1oFd38asGbgJM/Ee3hxIhGktMPA91jbOXF0
         Sl7Sqfh/iNsHqFr4Jl+mZKhk3T3ANyPsWsQ+8ozA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39J5tZqM092947
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Oct 2023 00:55:35 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Oct 2023 00:55:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Oct 2023 00:55:35 -0500
Received: from [172.24.227.94] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39J5tVTs034032;
        Thu, 19 Oct 2023 00:55:32 -0500
Message-ID: <e35d333a-7f24-4a3f-90e3-87bc859a18e3@ti.com>
Date:   Thu, 19 Oct 2023 11:25:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-am62p: Add nodes for more IPs
Content-Language: en-US
To:     Bryan Brattlof <bb@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20231018194839.2689377-1-bb@ti.com>
 <20231018194839.2689377-2-bb@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20231018194839.2689377-2-bb@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> index aaf4b793b58e7..e37f19f7e58ea 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> @@ -6,17 +6,35 @@
>  
>  &cbass_wakeup {
>  	wkup_conf: bus@43000000 {
> -		bootph-all;
>  		compatible = "simple-bus";
>  		reg = <0x00 0x43000000 0x00 0x20000>;
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges = <0x00 0x00 0x43000000 0x20000>;
> +		bootph-all;
>  
>  		chipid: chipid@14 {
> -			bootph-all;
>  			compatible = "ti,am654-chipid";
>  			reg = <0x14 0x4>;
> +			bootph-all;
> +		};
> +
> +		cpsw_efuse: syscon@200 {
> +			compatible = "syscon", "simple-mfd";
> +			reg = <0x200 0x4>;

This holds mac-address which is at least 48bits long

> +			bootph-all;
> +		};
> +
> +		usb0_phy_pll_refclk: syscon@4008 {
> +			compatible = "syscon", "simple-mfd";
> +			reg = <0x4008 0x10>;
> +			bootph-all;
> +		};
> +
> +		usb1_phy_pll_refclk: syscon@4018 {
> +			compatible = "syscon", "simple-mfd";
> +			reg = <0x4018 0x10>;
> +			bootph-all;

This adds new dtbs_check warnings:

+/workdir/arch/arm64/boot/dts/ti/k3-am62p5-sk.dtb: syscon@100000: $nodename:0: 'syscon@100000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
+/workdir/arch/arm64/boot/dts/ti/k3-am62p5-sk.dtb: syscon@200: compatible: ['syscon', 'simple-mfd'] is too short
+/workdir/arch/arm64/boot/dts/ti/k3-am62p5-sk.dtb: syscon@4008: compatible: ['syscon', 'simple-mfd'] is too short
+/workdir/arch/arm64/boot/dts/ti/k3-am62p5-sk.dtb: syscon@4018: compatible: ['syscon', 'simple-mfd'] is too short


I suggest to drop them for now.

Please add a new yamls for these nodes or single yaml for top level wkup_conf to 
cover am62/62a/62p SoCs and then introduce the nodes accordingly

Regards
Vignesh
