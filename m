Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9157E1E25
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjKFKVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFKVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:21:11 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B112A2;
        Mon,  6 Nov 2023 02:21:08 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A6AKtEc078827;
        Mon, 6 Nov 2023 04:20:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699266055;
        bh=fNKQxmrOUUS2uoYEBNzjyteFpbF5gUm6Ln8d+KkaMlk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=gzuFufSy2OTXN1otSdg4DxM9zMZQiCXixfmnOve8eyS6Sov3ibN61rBIePW3GWXfd
         bw8xroKxm6iTbEF4hAdOr4BerOdI1phsXEnH42AXjU/rEuKb8Z4Y8M3/efL6CegNIK
         Yy3OIyENvxnmE2Nk8zvwcUoTNBiL/Eu1ZOg7/lpY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A6AKtZw023817
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Nov 2023 04:20:55 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Nov 2023 04:20:54 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Nov 2023 04:20:54 -0600
Received: from [172.24.18.150] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A6AKn2I031173;
        Mon, 6 Nov 2023 04:20:50 -0600
Message-ID: <3cbb70e4-12e9-4124-8287-2c636a0e75e5@ti.com>
Date:   Mon, 6 Nov 2023 15:50:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am65-main: Fix DSS irq trigger type
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231106-am65-dss-clk-edge-v1-1-4a959fec0e1e@ideasonboard.com>
Content-Language: en-US
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20231106-am65-dss-clk-edge-v1-1-4a959fec0e1e@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06-Nov-23 15:27, Tomi Valkeinen wrote:
> DSS irq trigger type is set to IRQ_TYPE_EDGE_RISING in the DT file, but
> the TRM says it is level triggered.
> 
> For some reason triggering on rising edge results in double the amount
> of expected interrupts, e.g. for normal page flipping test the number of
> interrupts per second is 2 * fps. It is as if the IRQ triggers on both
> edges. There are no other side effects to this issue than slightly
> increased CPU & power consumption due to the extra interrupt.
> 
> Switching to IRQ_TYPE_LEVEL_HIGH is correct and fixes the issue, so
> let's do that.
> 
> Fixes: fc539b90eda2 ("arm64: dts: ti: am654: Add DSS node")
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---

Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>

Regards
Aradhya

>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index bc460033a37a..c98068b6c122 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -1034,7 +1034,7 @@ dss: dss@4a00000 {
>  		assigned-clocks = <&k3_clks 67 2>;
>  		assigned-clock-parents = <&k3_clks 67 5>;
>  
> -		interrupts = <GIC_SPI 166 IRQ_TYPE_EDGE_RISING>;
> +		interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
>  
>  		dma-coherent;
>  
> 
> ---
> base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
> change-id: 20231106-am65-dss-clk-edge-7d1bdd7c0f58
> 
> Best regards,

