Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB7B7AD8E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjIYNTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjIYNTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:19:44 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAA610A;
        Mon, 25 Sep 2023 06:19:38 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38PDJRiN042525;
        Mon, 25 Sep 2023 08:19:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695647967;
        bh=rEHOTTuQUm/6EqbiYbx4/pn0I3WBPULrrSYiunXnvr4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=oLKVabkoBqDwaipdlLM00NlK+Z53VHKprZxuFxDTQsHakCJVEdtbZpUxRu7owMNwV
         YTgIMrWKdsp0vysKOlyG30rH1RnW0OnHWu4MQv08Ch6+kEgJs9klJ+b/FY/duHanQd
         R7gLPJaSojyEGOENxuhiwQ37Yd4Vy5bXZ/Hy+wLQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38PDJRNq017726
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Sep 2023 08:19:27 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Sep 2023 08:19:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Sep 2023 08:19:27 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38PDJRx8065676;
        Mon, 25 Sep 2023 08:19:27 -0500
Date:   Mon, 25 Sep 2023 08:19:27 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Keerthy <j-keerthy@ti.com>
CC:     <robh+dt@kernel.org>, <vigneshr@ti.com>, <conor+dt@kernel.org>,
        <kristo@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <u-kumar1@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/7] arm64: dts: ti: k3-j784s4-mcu: Add the main
 domain watchdog instances
Message-ID: <20230925131927.f7ff2u2ip3jxejyg@dreadful>
References: <20230925081332.15906-1-j-keerthy@ti.com>
 <20230925081332.15906-6-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230925081332.15906-6-j-keerthy@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:43-20230925, Keerthy wrote:
> There are totally 2 instances of watchdog module in MCU domain.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> index a7b5c4cb7d3e..0b7cc277a567 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> @@ -714,4 +714,24 @@
>  		ti,esm-pins = <63>;
>  		bootph-pre-ram;
>  	};
> +
> +	mcu_watchdog0: watchdog@40600000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x40600000 0x00 0x100>;
> +		clocks = <&k3_clks 367 1>;
> +		power-domains = <&k3_pds 367 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 367 0>;
> +		assigned-clock-parents = <&k3_clks 367 4>;
> +		status = "disabled";
> +	};
> +
> +	mcu_watchdog1: watchdog@40610000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x40610000 0x00 0x100>;
> +		clocks = <&k3_clks 368 1>;
> +		power-domains = <&k3_pds 368 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 368 0>;
> +		assigned-clock-parents = <&k3_clks 368 4>;
> +		status = "disabled";

Explain in commit message as to why these are disabled. I believe it is
because this RTI instances are tightly coupled to the micro
controllers. but that information needs to be documented.
> +	};
>  };
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
