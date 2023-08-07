Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FCA771999
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 07:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjHGFvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 01:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjHGFvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 01:51:39 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A19C170A;
        Sun,  6 Aug 2023 22:51:37 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3775pURT113852;
        Mon, 7 Aug 2023 00:51:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691387490;
        bh=VVvXG4usFMA56iZDBBDrmBYaECLOyytzA7J6NLmibwA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=aoNGwu1224OEQj1EoXPoY/I5Dwqcn99QbcXaGH/WsV0JYE3erCz2MccZ/8lssQ3Oq
         232a4Gsvr7ssTFVORVVgmKzd8PVdOgJczKmcH0i7T+nH25hvx4ieV2gtNou6FgYLl1
         osL4TEIeQsbddhRHHFUIc/emytlv3X9MJ6zECjbY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3775pUjK015377
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 00:51:30 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 00:51:30 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 00:51:30 -0500
Received: from [172.24.227.68] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3775pQ4q023895;
        Mon, 7 Aug 2023 00:51:27 -0500
Message-ID: <cd8352a9-6ab4-dbcc-1bee-8ad76e6b3004@ti.com>
Date:   Mon, 7 Aug 2023 11:21:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 12/13] arm64: dts: ti: k3-am65: Enable TSCADC nodes at the
 board level
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230802205309.257392-1-afd@ti.com>
 <20230802205309.257392-13-afd@ti.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20230802205309.257392-13-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On 03/08/23 02:23, Andrew Davis wrote:
> TSCADC nodes defined in the top-level AM65 SoC dtsi files are incomplete
> and may not be functional unless they are extended with pinmux and/or
> device information.
> 
> Disable the TSCADC nodes in the dtsi files and only enable the ones that
> are actually pinned out on a given board.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 5 +----
>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            | 2 ++
>   arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 2 ++
>   3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> index 6041862d5aa75..ba1c14a54acf4 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> @@ -582,11 +582,8 @@ &mcu_spi0 {
>   	ti,pindir-d0-out-d1-in;
>   };
>   
> -&tscadc0 {
> -	status = "disabled";
> -};
> -
>   &tscadc1 {
> +	status = "okay";

The commit body says,
"Disable the TSCADC nodes in the dtsi files"

Please can we also provide some explanation on why
tscadc1 was left as okay here in a dtsi file?

>   	adc {
>   		ti,adc-channels = <0 1 2 3 4 5>;
>   	};
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> index 2c9c20a9d9179..4defde540fe0b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> @@ -112,6 +112,7 @@ tscadc0: tscadc@40200000 {
>   		dmas = <&mcu_udmap 0x7100>,
>   			<&mcu_udmap 0x7101 >;
>   		dma-names = "fifo0", "fifo1";
> +		status = "disabled";
>   
>   		adc {
>   			#io-channel-cells = <1>;
> @@ -130,6 +131,7 @@ tscadc1: tscadc@40210000 {
>   		dmas = <&mcu_udmap 0x7102>,
>   			<&mcu_udmap 0x7103>;
>   		dma-names = "fifo0", "fifo1";
> +		status = "disabled";
>   
>   		adc {
>   			#io-channel-cells = <1>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> index 43de7c132d343..17f45a9f7b146 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> @@ -478,12 +478,14 @@ &usb0_phy {
>   };
>   
>   &tscadc0 {
> +	status = "okay";
>   	adc {
>   		ti,adc-channels = <0 1 2 3 4 5 6 7>;
>   	};
>   };
>   
>   &tscadc1 {
> +	status = "okay";
>   	adc {
>   		ti,adc-channels = <0 1 2 3 4 5 6 7>;
>   	};

-- 
Thanks and Regards,
Dhruva Gole
