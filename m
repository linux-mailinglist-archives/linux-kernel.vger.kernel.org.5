Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A0176C72E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjHBHmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbjHBHle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:41:34 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CBF4226;
        Wed,  2 Aug 2023 00:39:15 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3727cmdx053458;
        Wed, 2 Aug 2023 02:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690961928;
        bh=fUearYK9MZBu1+qGnEld1Z2JFYEpFegJs6KzET29hIg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=QNlTuq18v8DDhO6IRaqLqegW7iyCXLXuk6H0HSpl1WdyW25pRXYNpSGN/wyNZWKy0
         jArHpq94wLlKnt/+V5zy+7hFRNBtx73KYXDOK0dkUZuU6DygMPmusZW2oK/UqECG25
         zL+PXxwIhqszZrgBvfCLsAMJ11BUiwQtnwKillIg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3727cmvw004849
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 02:38:48 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 02:38:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 02:38:48 -0500
Received: from [172.24.227.6] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3727ciWJ022039;
        Wed, 2 Aug 2023 02:38:45 -0500
Message-ID: <f69b95ce-f285-1f2b-aca9-29bfbb6231af@ti.com>
Date:   Wed, 2 Aug 2023 13:08:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/5] arm64: dts: ti: k3-am62a-main: Add nodes for McASP
Content-Language: en-US
To:     Jai Luthra <j-luthra@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230731-mcasp_am62a-v1-0-8bd137ffa8f1@ti.com>
 <20230731-mcasp_am62a-v1-1-8bd137ffa8f1@ti.com>
From:   Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20230731-mcasp_am62a-v1-1-8bd137ffa8f1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/07/23 18:14, Jai Luthra wrote:
> Same as AM62, AM62A has three instances of McASP which can be used for
> transmitting or receiving digital audio in various formats.
> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

> ---
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 60 +++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> index 8397cb80f559..e4ced2cc790b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> @@ -816,4 +816,64 @@ ecap2: pwm@23120000 {
>  		clock-names = "fck";
>  		status = "disabled";
>  	};
> +
> +	mcasp0: audio-controller@2b00000 {
> +		compatible = "ti,am33xx-mcasp-audio";
> +		reg = <0x00 0x02b00000 0x00 0x2000>,
> +		      <0x00 0x02b08000 0x00 0x400>;
> +		reg-names = "mpu", "dat";
> +		interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "tx", "rx";
> +
> +		dmas = <&main_bcdma 0 0xc500 0>, <&main_bcdma 0 0x4500 0>;
> +		dma-names = "tx", "rx";
> +
> +		clocks = <&k3_clks 190 0>;
> +		clock-names = "fck";
> +		assigned-clocks = <&k3_clks 190 0>;
> +		assigned-clock-parents = <&k3_clks 190 2>;
> +		power-domains = <&k3_pds 190 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
> +	};
> +
> +	mcasp1: audio-controller@2b10000 {
> +		compatible = "ti,am33xx-mcasp-audio";
> +		reg = <0x00 0x02b10000 0x00 0x2000>,
> +		      <0x00 0x02b18000 0x00 0x400>;
> +		reg-names = "mpu", "dat";
> +		interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "tx", "rx";
> +
> +		dmas = <&main_bcdma 0 0xc501 0>, <&main_bcdma 0 0x4501 0>;
> +		dma-names = "tx", "rx";
> +
> +		clocks = <&k3_clks 191 0>;
> +		clock-names = "fck";
> +		assigned-clocks = <&k3_clks 191 0>;
> +		assigned-clock-parents = <&k3_clks 191 2>;
> +		power-domains = <&k3_pds 191 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
> +	};
> +
> +	mcasp2: audio-controller@2b20000 {
> +		compatible = "ti,am33xx-mcasp-audio";
> +		reg = <0x00 0x02b20000 0x00 0x2000>,
> +		      <0x00 0x02b28000 0x00 0x400>;
> +		reg-names = "mpu", "dat";
> +		interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "tx", "rx";
> +
> +		dmas = <&main_bcdma 0 0xc502 0>, <&main_bcdma 0 0x4502 0>;
> +		dma-names = "tx", "rx";
> +
> +		clocks = <&k3_clks 192 0>;
> +		clock-names = "fck";
> +		assigned-clocks = <&k3_clks 192 0>;
> +		assigned-clock-parents = <&k3_clks 192 2>;
> +		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
> +	};
>  };
