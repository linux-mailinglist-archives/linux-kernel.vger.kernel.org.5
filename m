Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEA1772C78
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjHGRPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjHGRPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:15:05 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283571FC0;
        Mon,  7 Aug 2023 10:14:48 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377HDvnr009045;
        Mon, 7 Aug 2023 12:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691428437;
        bh=ppChU5GGh+9pajuOgru8V0/YEUN3szFluORsPcZfL+0=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=ZlcV7ZGFc2iHOuZrU+XIO0ECAP64myprpC+9mYkPjDzZS3N6TMqq9qf0Q6IpPmQU6
         sINcBXipgaAy6rKs31hnNJgQVHajZ+gye80t0ks9ZZvrYwbWt7TvjwgBYnLWyw/RNg
         Q72C7/74HASa8n/o0rCc8IbpsAjn3djcQ+ndRisc=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377HDvAw052999
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 12:13:57 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 12:13:57 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 12:13:57 -0500
Received: from [10.24.69.34] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377HDrAV044001;
        Mon, 7 Aug 2023 12:13:54 -0500
Message-ID: <ef834d0b-b13a-5c3d-6c1d-088006fdfa32@ti.com>
Date:   Mon, 7 Aug 2023 22:43:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-j784s4-mcu-wakeup: Add
 bootph-pre-ram property for SPL nodes
Content-Language: en-US
To:     "Kumar, Udit" <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hari Nagalla <hnagalla@ti.com>
References: <20230806164838.18088-1-a-nandan@ti.com>
 <20230806164838.18088-3-a-nandan@ti.com>
 <3a2d1880-10aa-ac19-24e1-b2f697bc1a73@ti.com>
From:   Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <3a2d1880-10aa-ac19-24e1-b2f697bc1a73@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/08/23 10:01, Kumar, Udit wrote:
> Hi Apurva
>
> On 8/6/2023 10:18 PM, Apurva Nandan wrote:
>> Add bootph-pre-ram property for all the nodes used in SPL stage,
>> for syncing it later to u-boot j784s4 dts.
>>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
>> index 740ee794d7b9..57bf0261c343 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
>> @@ -6,7 +6,9 @@
>>    */
>>     &cbass_mcu_wakeup {
>> +    bootph-pre-ram;
>>       sms: system-controller@44083000 {
>> +        bootph-pre-ram;
>>           compatible = "ti,k2g-sci";
>>           ti,host-id = <12>;
>>   @@ -19,22 +21,26 @@ sms: system-controller@44083000 {
>>           reg = <0x00 0x44083000 0x00 0x1000>;
>>             k3_pds: power-controller {
>> +            bootph-pre-ram;
>>               compatible = "ti,sci-pm-domain";
>>               #power-domain-cells = <2>;
>>           };
>>             k3_clks: clock-controller {
>> +            bootph-pre-ram;
>>               compatible = "ti,k2g-sci-clk";
>>               #clock-cells = <2>;
>>           };
>>             k3_reset: reset-controller {
>> +            bootph-pre-ram;
>>               compatible = "ti,sci-reset";
>>               #reset-cells = <2>;
>>           };
>>       };
>>         chipid@43000014 {
>> +        bootph-pre-ram;
>>           compatible = "ti,am654-chipid";
>>           reg = <0x00 0x43000014 0x00 0x4>;
>>       };
>> @@ -442,6 +448,7 @@ mcu_spi2: spi@40320000 {
>>       };
>
>
> mcu_timer0: timer@40400000 should be part of your list.
Maybe you are referring to mcu_timer1. mcu_timer1 will be a part of 
u-boot.dtsi as we need to edit
the node for removing k3_clks and power-domains properties from it. So 
we should add bootph-pre-ram
there itself in uboot.dtsi as the node will be already there.
>
>>         mcu_navss: bus@28380000 {
>> +        bootph-pre-ram;
>>           compatible = "simple-bus";
>>           #address-cells = <2>;
>>           #size-cells = <2>;
>> @@ -451,6 +458,7 @@ mcu_navss: bus@28380000 {
>>           dma-ranges;
>>             mcu_ringacc: ringacc@2b800000 {
>> +            bootph-pre-ram;
>>               compatible = "ti,am654-navss-ringacc";
>>               reg = <0x00 0x2b800000 0x00 0x400000>,
>>                     <0x00 0x2b000000 0x00 0x400000>,
>> @@ -465,6 +473,7 @@ mcu_ringacc: ringacc@2b800000 {
>>           };
>>             mcu_udmap: dma-controller@285c0000 {
>> +            bootph-pre-ram;
>>               compatible = "ti,j721e-navss-mcu-udmap";
>>               reg = <0x00 0x285c0000 0x00 0x100>,
>>                     <0x00 0x2a800000 0x00 0x40000>,
