Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4423777355
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbjHJIu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbjHJIu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:50:56 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD6C1BFA;
        Thu, 10 Aug 2023 01:50:53 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37A8ok8G128275;
        Thu, 10 Aug 2023 03:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691657446;
        bh=AzLw+SP4ZFWnoyRGCB0Quzt/PCUuPmKW8aZqzcIQz4o=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=SJ3yJh8QuasnBXs0qgwSD++x6s+Nn8ybYdqO60+4VBv70rcmIJKO0rmy/H5uYQqGH
         QoE+3Uoly5GfqeZhEMCH2ISdrobAcxI2XxZjk2S+wJlFmDXyl36sWQRi8Jw/I3nTcp
         5O0/oObTjtuePHsbewLV+6CF2TecQSS/kHU7XlLw=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37A8okvO015544
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 03:50:46 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 03:50:45 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 03:50:45 -0500
Received: from [10.249.141.75] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37A8oeeM028140;
        Thu, 10 Aug 2023 03:50:41 -0500
Message-ID: <5ec8b817-e63f-3d76-894d-8af4f4e880db@ti.com>
Date:   Thu, 10 Aug 2023 14:20:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-j721e: Enable C7x DSP nodes at the
 board level
To:     Andrew Davis <afd@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230809180145.53158-1-afd@ti.com>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230809180145.53158-1-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andrew

On 8/9/2023 11:31 PM, Andrew Davis wrote:
> C7x DSP nodes defined in the top-level J721e SoC dtsi files are incomplete
> and will not be functional unless they are extended with both mboxes and
> memory-region information.
>
> As theses only known about at the board integration level, these nodes
> should only be enabled when provided with this information.
>
> Disable the C7x DSP nodes in the dtsi files and only enable the ones that
> are given the required mboxes and memory-region on a given board.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts | 1 +
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          | 1 +
>   arch/arm64/boot/dts/ti/k3-j721e-sk.dts             | 1 +
>   arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi        | 1 +
>   4 files changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> index 66aac145e7530..d1235e7c786d6 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> @@ -1024,6 +1024,7 @@ &c66_1 {
>   };
>   
>   &c71_0 {
> +	status = "okay";
>   	mboxes = <&mailbox0_cluster4>, <&mbox_c71_0>;
>   	memory-region = <&c71_0_dma_memory_region>,
>   			<&c71_0_memory_region>;

Series tested on J721E, J784S4 platforms

However I need to apply 
https://lore.kernel.org/linux-iommu/0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com/ 
patch


Tested-by: Udit Kumar <u-kumar1@ti.com>

https://gist.github.com/uditkumarti/b6320a06fadaaaf174fc0431949f11e1



> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index 3acd55ffd4ffc..1aeb97b42b34b 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -2134,6 +2134,7 @@ c71_0: dsp@64800000 {
>   		ti,sci-proc-ids = <0x30 0xff>;
>   		resets = <&k3_reset 15 1>;
>   		firmware-name = "j7-c71_0-fw";
> +		status = "disabled";
>   	};
>   
>   	icssg0: icssg@b000000 {
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> index 0ee4f38ec8f03..377588ba30998 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> @@ -1110,6 +1110,7 @@ &c66_1 {
>   };
>   
>   &c71_0 {
> +	status = "okay";
>   	mboxes = <&mailbox0_cluster4>, <&mbox_c71_0>;
>   	memory-region = <&c71_0_dma_memory_region>,
>   			<&c71_0_memory_region>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
> index e90e43202546e..3c31ab57e959c 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
> @@ -436,6 +436,7 @@ &c66_1 {
>   };
>   
>   &c71_0 {
> +	status = "okay";
>   	mboxes = <&mailbox0_cluster4>, <&mbox_c71_0>;
>   	memory-region = <&c71_0_dma_memory_region>,
>   			<&c71_0_memory_region>;
