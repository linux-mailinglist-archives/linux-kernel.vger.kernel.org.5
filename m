Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0137E018B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346820AbjKCJA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 05:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbjKCJA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 05:00:27 -0400
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1448E187
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 02:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1699002013; x=1701594013;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wPaIaKEwhq9fF5yJIn7fquUjgqFfNUfDP0ZOFvXkcsk=;
        b=Hp4iMuMv9WqcWgZuJGWfMK+NNXJeB367h8YbTnM0i8U/REsfKv4EST3cCoLCQqt5
        Lep3aP/+iQnbvkJok7KdFkAkxEDJS4NOeUy+pozas1qivj6IH1xz1Y34oIlhg6mO
        tHeTPHu0s4jQIgUNkfpOMvProUuyQ8pK9IEbGxHC/kU=;
X-AuditID: ac14000a-b234a700000074e4-ea-6544b69da743
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 19.D5.29924.D96B4456; Fri,  3 Nov 2023 10:00:13 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 3 Nov 2023
 10:00:12 +0100
Message-ID: <5effa700-480b-4030-8335-304ebc4444b7@phytec.de>
Date:   Fri, 3 Nov 2023 10:00:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: phycore-am64: Add R5F DMA Region and
 Mailboxes
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Garrett Giordano <ggiordano@phytec.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <r-gunasekaran@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <upstream@lists.phytec.de>
References: <20231102201216.3771589-1-ggiordano@phytec.com>
 <20231103001707.2ktwfgtqegpfiijy@subpanel>
From:   Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20231103001707.2ktwfgtqegpfiijy@subpanel>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWyRpKBR3fuNpdUg0uzVSzW7D3HZDH/yDlW
        i/VbfrNZLP88m92i78VDZotNj6+xWlzeNYfN4s2Ps0wWXa/b2S1a9x5ht+h+p27x/+wHdgce
        j02rOtk87lzbw+axeUm9R393C6vHn4vvWD2O39jO5PF5k1wAexSXTUpqTmZZapG+XQJXxoZf
        y1gKXqpXfPng3cB4TL6LkZNDQsBE4nbXJcYuRi4OIYHFTBI9X/6xQDh3GCUeL/zFCFLFK2Aj
        0bfsMVCCnYNFQEWiVw0iKihxcuYTFhBbVEBe4v6tGewgtrBAqMSBWSvA4swC4hK3nsxn6mLk
        4BARcJdouiEDMp1ZYB6TxN1bR8CmCwlkSHR8g+hlE1CXuLPhGyuIzSlgLvHl2C52iDkWEovf
        HISy5SWat85mhuiVl3hxaTkLxC/yEtPOvWaGsEMljmxazTSBUXgWklNnITlpFpKxs5CMXcDI
        sopRKDczOTu1KDNbryCjsiQ1WS8ldRMjKPpEGLh2MPbN8TjEyMTBeIhRgoNZSYTX0dslVYg3
        JbGyKrUoP76oNCe1+BCjNAeLkjjv/R6mRCGB9MSS1OzU1ILUIpgsEwenVAPjeomg3qbaTxHb
        el9oBLNmK7/aFNK+6ZddaGZQ7qHXbG4vzEuT69blXDrwYIeSSOfFF45Wd6aVSmg7ZD9ley3v
        uUTH+deZY0vWdb/bNHvNPAd7p2fOfW27DTKvdt5pmhlv/tFsT1CV7aOJFeJ8a/033TqRf6jk
        c/nVbVP4ozz9ZHrEyvpsEs4qsRRnJBpqMRcVJwIA9Nc5DKwCAAA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

Am 03.11.23 um 01:17 schrieb Nishanth Menon:
> On 13:12-20231102, Garrett Giordano wrote:
>> Communication between the R5F subsystem and Linux takes place using DMA
>> memory regions and mailboxes. Here we add DT nodes for the memory
>> regions and mailboxes to facilitate communication between the R5
>> clusters and Linux as remoteproc will fail to start if no memory
>> regions or mailboxes are provided.
>>
>> Fixes: c48ac0efe6d7 ("arm64: dts: ti: Add support for phyBOARD-Electra-AM642")
> is this fixes? Sounds more or less like rproc support is added in?

I would say it is also a fix, as the R5 cores are enabled by default at 
the SoC level devicetree and also require mboxes & memory regions to be 
configured. The docs mention both as mandatory.

Otherwise, we will encounter errors such as

   platform 78000000.r5f: device does not have reserved memory regions, 
ret = -22

Regards,
Wadim

>
>> Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
>> ---
>>   .../boot/dts/ti/k3-am64-phycore-som.dtsi      | 102 +++++++++++++++++-
>>   1 file changed, 101 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
>> index 1c2c8f0daca9..37a33006c1fc 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
>> @@ -29,7 +29,7 @@ memory@80000000 {
>>   		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
>>   	};
>>   
>> -	reserved-memory {
>> +	reserved_memory: reserved-memory {
>>   		#address-cells = <2>;
>>   		#size-cells = <2>;
>>   		ranges;
>> @@ -39,6 +39,54 @@ secure_ddr: optee@9e800000 {
>>   			alignment = <0x1000>;
>>   			no-map;
>>   		};
>> +
>> +		main_r5fss0_core0_dma_memory_region: r5f-dma-memory@a0000000 {
>> +			compatible = "shared-dma-pool";
>> +			reg = <0x00 0xa0000000 0x00 0x100000>;
>> +			no-map;
>> +		};
>> +
>> +		main_r5fss0_core0_memory_region: r5f-memory@a0100000 {
>> +			compatible = "shared-dma-pool";
>> +			reg = <0x00 0xa0100000 0x00 0xf00000>;
>> +			no-map;
>> +		};
>> +
>> +		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
>> +			compatible = "shared-dma-pool";
>> +			reg = <0x00 0xa1000000 0x00 0x100000>;
>> +			no-map;
>> +		};
>> +
>> +		main_r5fss0_core1_memory_region: r5f-memory@a1100000 {
>> +			compatible = "shared-dma-pool";
>> +			reg = <0x00 0xa1100000 0x00 0xf00000>;
>> +			no-map;
>> +		};
>> +
>> +		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a2000000 {
>> +			compatible = "shared-dma-pool";
>> +			reg = <0x00 0xa2000000 0x00 0x100000>;
>> +			no-map;
>> +		};
>> +
>> +		main_r5fss1_core0_memory_region: r5f-memory@a2100000 {
>> +			compatible = "shared-dma-pool";
>> +			reg = <0x00 0xa2100000 0x00 0xf00000>;
>> +			no-map;
>> +		};
>> +
>> +		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a3000000 {
>> +			compatible = "shared-dma-pool";
>> +			reg = <0x00 0xa3000000 0x00 0x100000>;
>> +			no-map;
>> +		};
>> +
>> +		main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
>> +			compatible = "shared-dma-pool";
>> +			reg = <0x00 0xa3100000 0x00 0xf00000>;
>> +			no-map;
>> +		};
>>   	};
>>   
>>   	leds {
>> @@ -160,6 +208,34 @@ &cpsw_port2 {
>>   	status = "disabled";
>>   };
>>   
>> +&mailbox0_cluster2 {
>> +	status = "okay";
>> +
>> +	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
>> +		ti,mbox-rx = <0 0 2>;
>> +		ti,mbox-tx = <1 0 2>;
>> +	};
>> +
>> +	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
>> +		ti,mbox-rx = <2 0 2>;
>> +		ti,mbox-tx = <3 0 2>;
>> +	};
>> +};
>> +
>> +&mailbox0_cluster4 {
>> +	status = "okay";
>> +
>> +	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
>> +		ti,mbox-rx = <0 0 2>;
>> +		ti,mbox-tx = <1 0 2>;
>> +	};
>> +
>> +	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
>> +		ti,mbox-rx = <2 0 2>;
>> +		ti,mbox-tx = <3 0 2>;
>> +	};
>> +};
>> +
>>   &main_i2c0 {
>>   	status = "okay";
>>   	pinctrl-names = "default";
>> @@ -180,6 +256,30 @@ i2c_som_rtc: rtc@52 {
>>   	};
>>   };
>>   
>> +&main_r5fss0_core0 {
>> +	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
>> +	memory-region = <&main_r5fss0_core0_dma_memory_region>,
>> +			<&main_r5fss0_core0_memory_region>;
>> +};
>> +
>> +&main_r5fss0_core1 {
>> +	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
>> +	memory-region = <&main_r5fss0_core1_dma_memory_region>,
>> +			<&main_r5fss0_core1_memory_region>;
>> +};
>> +
>> +&main_r5fss1_core0 {
>> +	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
>> +	memory-region = <&main_r5fss1_core0_dma_memory_region>,
>> +			<&main_r5fss1_core0_memory_region>;
>> +};
>> +
>> +&main_r5fss1_core1 {
>> +	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
>> +	memory-region = <&main_r5fss1_core1_dma_memory_region>,
>> +			<&main_r5fss1_core1_memory_region>;
>> +};
>> +
>>   &ospi0 {
>>   	status = "okay";
>>   	pinctrl-names = "default";
>> -- 
>> 2.25.1
>>
