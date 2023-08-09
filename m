Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93CB7767F8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjHITKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHITKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:10:18 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAC010E7;
        Wed,  9 Aug 2023 12:10:17 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379J9iRF077946;
        Wed, 9 Aug 2023 14:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691608184;
        bh=n8EqHLLIiKuqByJvrEsdeUk/ia1nskmW4zniSdjK4XQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=UTuthB7x0YwcqbWsiBaq6hudntjgCtJOseB2+NBPxY9wNqx2Hb5Zp22SExyU8ikqU
         P9JNQf9UPT48sRyBJZn5iGDCjWyPLB0HsNNUysfAC/PiGmjDg9ufT8c4VMqvZNC5rv
         pflX3B/+csIHIm6jWdUqv8vOtGsNT/zYxu5E6u+c=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379J9iud003769
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 14:09:44 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 14:09:44 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 14:09:44 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379J9hkM018665;
        Wed, 9 Aug 2023 14:09:43 -0500
Date:   Wed, 9 Aug 2023 14:09:43 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Apurva Nandan <a-nandan@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Keerthy J <j-keerthy@ti.com>
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-j7200: Add the supported
 frequencies for A72
Message-ID: <20230809190943.unpcbrinyn5ppei7@hydrated>
References: <20230809173905.1844132-1-a-nandan@ti.com>
 <20230809173905.1844132-3-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809173905.1844132-3-a-nandan@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23:09-20230809, Apurva Nandan wrote:
> From: Keerthy <j-keerthy@ti.com>
> 
> Add 750M, 1G, 1.5G & 2G as the supported frequencies for A72.
> This enables support for Dynamic Frequency Scaling(DFS)
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j7200.dtsi | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200.dtsi b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
> index ef73e6d7e858..7222c453096f 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
> @@ -48,6 +48,10 @@ cpu0: cpu@0 {
>  			d-cache-line-size = <64>;
>  			d-cache-sets = <256>;
>  			next-level-cache = <&L2_0>;
> +			clocks = <&k3_clks 202 2>;
> +			clock-names = "cpu";
> +			operating-points-v2 = <&cpu0_opp_table>;
> +			#cooling-cells = <2>; /* min followed by max */
>  		};
>  
>  		cpu1: cpu@1 {
> @@ -62,6 +66,30 @@ cpu1: cpu@1 {
>  			d-cache-line-size = <64>;
>  			d-cache-sets = <256>;
>  			next-level-cache = <&L2_0>;
> +			clocks = <&k3_clks 203 0>;
> +			clock-names = "cpu";
> +			operating-points-v2 = <&cpu0_opp_table>;
> +			#cooling-cells = <2>; /* min followed by max */
> +		};
> +	};
> +
> +	cpu0_opp_table: opp-table {
> +		compatible = "operating-points-v2";
> +
> +		opp4-2000000000 {
> +			opp-hz = /bits/ 64 <2000000000>;
> +		};
> +
> +		opp3-1500000000 {
> +			opp-hz = /bits/ 64 <1500000000>;
> +		};
> +
> +		opp2-1000000000 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +		};
> +
> +		opp1-750000000 {
> +			opp-hz = /bits/ 64 <750000000>;
>  		};
>  	};
>  
> -- 
> 2.34.1
> 

Are you sure this is correct to enable all OPPs without efuse bit checks?

https://www.ti.com/lit/ds/symlink/dra821u-q1.pdf
7.5 Operating Performance Points
DRA821xC operates only upto 750MHz
DRA821xE at 1GHz
DRA821xL upto 1.5GHz and
DRA821xT upto 2GHz

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
