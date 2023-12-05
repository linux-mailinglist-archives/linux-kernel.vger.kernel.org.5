Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4431D805C0A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345994AbjLER0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbjLER0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:26:02 -0500
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54051A1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1701797162; x=1704389162;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LYYTLO6Sh4+IUIm2LAGszv/f3IENIM+6WU7U5kxRJ1o=;
        b=IhW1N+WZf5uhyvT3FREO/MTFzVwXWdHc2HiY8Be74JJQABtSgIExF059RIj1jHMx
        xoB+pdbgjHpBX8g2RQGlN3HS6DSMW+IrZr2XA29dqle/NsES6qAsSPSg3DeTV5H8
        8m+Dl7TfVKeCL+WiMGCCb25PmhpB0rZ4Z9inKQq4x7g=;
X-AuditID: ac14000a-fadff7000000290d-4a-656f5d2aca27
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 87.41.10509.A2D5F656; Tue,  5 Dec 2023 18:26:02 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Florix.phytec.de (172.25.0.13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 5 Dec 2023
 18:26:01 +0100
Message-ID: <136b3721-2ea7-488a-89cc-cc74f631f5fc@phytec.de>
Date:   Tue, 5 Dec 2023 18:26:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: phycore-am64: Add R5F DMA Region and
 Mailboxes
Content-Language: en-US
To:     Garrett Giordano <ggiordano@phytec.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <r-gunasekaran@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <upstream@lists.phytec.de>
References: <20231204212304.1736306-1-ggiordano@phytec.com>
From:   Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20231204212304.1736306-1-ggiordano@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Florix.phytec.de
 (172.25.0.13)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWyRpKBV1crNj/VYNlMM4s1e88xWcw/co7V
        Yv2W32wWyz/PZrfoe/GQ2WLT42usFpd3zWGzePPjLJNF1+t2dovWvUfYLbrfqVv8P/uB3YHH
        Y9OqTjaPO9f2sHlsXlLv0d/dwurx5+I7Vo/jN7YzeXzeJBfAHsVlk5Kak1mWWqRvl8CVce3G
        DraCPuWKk2u3MzcwXpfuYuTkkBAwkbi1rYuxi5GLQ0hgMZPEiekz2SCcO4wStz6cZQWp4hWw
        kTgzYz8jiM0ioCIx/fJ/doi4oMTJmU9YQGxRAXmJ+7dmgMWFBUIlDsxaARZnFhCXuPVkPhPI
        UBGBC4wSdw/1g21gFmhjlHjy8AAzSJWQgLXE11d7wDawCahL3NnwDWwzJ9DmKTM3sUNMspBY
        /OYglC0vsf3tHKheeYkXl5azQPwjLzHt3GtmCDtUYv6a7+wTGIVnITl2FpKjZiEZOwvJ2AWM
        LKsYhXIzk7NTizKz9QoyKktSk/VSUjcxguJQhIFrB2PfHI9DjEwcjIcYJTiYlUR4593KThXi
        TUmsrEotyo8vKs1JLT7EKM3BoiTOu7ojOFVIID2xJDU7NbUgtQgmy8TBKdXAGHT5+YcvVoHz
        Z7Ce0HR487TT3N4h5OH3snVNezZ9zv91iDk/JHF/TeGpQvYDrrNUj7st5dihVbjx23y+PwJz
        88o+dAm7RnJsZ4xvPvXVfvu8VKOOmByrvCvcu99VcZXzWbFOtD2/9DerBF/wU8vqM2faWR+9
        L36997xl2+uPE849Wn2L50XAViWW4oxEQy3mouJEAEUTIPyxAgAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 04.12.23 um 22:23 schrieb Garrett Giordano:
> Communication between the R5F subsystem and Linux takes place using DMA
> memory regions and mailboxes. Here we add DT nodes for the memory
> regions and mailboxes to facilitate communication between the R5
> clusters and Linux as remoteproc will fail to start if no memory
> regions or mailboxes are provided.
>
> Fixes: c48ac0efe6d7 ("arm64: dts: ti: Add support for phyBOARD-Electra-AM642")
> Signed-off-by: Garrett Giordano <ggiordano@phytec.com>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>


> ---
>   .../boot/dts/ti/k3-am64-phycore-som.dtsi      | 102 +++++++++++++++++-
>   1 file changed, 101 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> index 1c2c8f0daca9..37a33006c1fc 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> @@ -29,7 +29,7 @@ memory@80000000 {
>   		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
>   	};
>   
> -	reserved-memory {
> +	reserved_memory: reserved-memory {
>   		#address-cells = <2>;
>   		#size-cells = <2>;
>   		ranges;
> @@ -39,6 +39,54 @@ secure_ddr: optee@9e800000 {
>   			alignment = <0x1000>;
>   			no-map;
>   		};
> +
> +		main_r5fss0_core0_dma_memory_region: r5f-dma-memory@a0000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa0000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		main_r5fss0_core0_memory_region: r5f-memory@a0100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa0100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa1000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		main_r5fss0_core1_memory_region: r5f-memory@a1100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa1100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a2000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa2000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		main_r5fss1_core0_memory_region: r5f-memory@a2100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa2100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a3000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa3000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa3100000 0x00 0xf00000>;
> +			no-map;
> +		};
>   	};
>   
>   	leds {
> @@ -160,6 +208,34 @@ &cpsw_port2 {
>   	status = "disabled";
>   };
>   
> +&mailbox0_cluster2 {
> +	status = "okay";
> +
> +	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
> +		ti,mbox-rx = <0 0 2>;
> +		ti,mbox-tx = <1 0 2>;
> +	};
> +
> +	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
> +		ti,mbox-rx = <2 0 2>;
> +		ti,mbox-tx = <3 0 2>;
> +	};
> +};
> +
> +&mailbox0_cluster4 {
> +	status = "okay";
> +
> +	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
> +		ti,mbox-rx = <0 0 2>;
> +		ti,mbox-tx = <1 0 2>;
> +	};
> +
> +	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
> +		ti,mbox-rx = <2 0 2>;
> +		ti,mbox-tx = <3 0 2>;
> +	};
> +};
> +
>   &main_i2c0 {
>   	status = "okay";
>   	pinctrl-names = "default";
> @@ -180,6 +256,30 @@ i2c_som_rtc: rtc@52 {
>   	};
>   };
>   
> +&main_r5fss0_core0 {
> +	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
> +	memory-region = <&main_r5fss0_core0_dma_memory_region>,
> +			<&main_r5fss0_core0_memory_region>;
> +};
> +
> +&main_r5fss0_core1 {
> +	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
> +	memory-region = <&main_r5fss0_core1_dma_memory_region>,
> +			<&main_r5fss0_core1_memory_region>;
> +};
> +
> +&main_r5fss1_core0 {
> +	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
> +	memory-region = <&main_r5fss1_core0_dma_memory_region>,
> +			<&main_r5fss1_core0_memory_region>;
> +};
> +
> +&main_r5fss1_core1 {
> +	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
> +	memory-region = <&main_r5fss1_core1_dma_memory_region>,
> +			<&main_r5fss1_core1_memory_region>;
> +};
> +
>   &ospi0 {
>   	status = "okay";
>   	pinctrl-names = "default";
