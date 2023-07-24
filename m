Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECAD75FB75
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGXQGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjGXQGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:06:47 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF3510FE;
        Mon, 24 Jul 2023 09:06:45 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36OG6OYD006619;
        Mon, 24 Jul 2023 11:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690214784;
        bh=/8LPWB3kQV4mGYDKYtFwRQpGZ7Mous9zY+TNmmeBuA8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=HXXIiZEQnlIRM+suZm6DtCv7qpwUAqbVK0NByqb091SRdLWYfl7U3i7vmPuqASkxk
         QygXmoCxDjG/9iRjvSIy4aHREI6lRaqPvN0HcPApdkuICjWkzuSCCxYtIMNFMWm80A
         kQQf1tVmEnpZXR5iBJqvxlK6FYqX4AFQ76UJlP5Y=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36OG6O5L004146
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Jul 2023 11:06:24 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Jul 2023 11:06:24 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Jul 2023 11:06:24 -0500
Received: from [128.247.81.105] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36OG6O5s067251;
        Mon, 24 Jul 2023 11:06:24 -0500
Message-ID: <42044653-cc22-131a-bf1b-e68ddfa0ff9d@ti.com>
Date:   Mon, 24 Jul 2023 11:06:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/2] arm64: dts: ti: k3-am62: Add MCU MCAN nodes
To:     Francesco Dolcini <francesco@dolcini.it>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
References: <20230724133612.37366-1-francesco@dolcini.it>
 <20230724133612.37366-2-francesco@dolcini.it>
Content-Language: en-US
From:   Judith Mendez <jm@ti.com>
In-Reply-To: <20230724133612.37366-2-francesco@dolcini.it>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francesco,

On 7/24/23 8:36 AM, Francesco Dolcini wrote:
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
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> [fd: fixed labels to match datasheet numbering, revised commit message,
>       fixed reg/reg-names order]
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
> index 19fc38157d94..fed50666d95b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
> @@ -147,4 +147,28 @@ mcu_rti0: watchdog@4880000 {
>   		/* Tightly coupled to M4F */
>   		status = "reserved";
>   	};
> +
> +	mcu_mcan0: can@4e00000 {
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
>   };

Thanks for sending this patch, will also send for AM62ax.

~ Judith
