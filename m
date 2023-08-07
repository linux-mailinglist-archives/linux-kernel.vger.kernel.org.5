Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05905772959
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjHGPfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjHGPfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:35:06 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E2510DC;
        Mon,  7 Aug 2023 08:34:48 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377FYfBp116844;
        Mon, 7 Aug 2023 10:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691422481;
        bh=KxkRZVvkaOMB00+/618y31KCBukKv9oMUkIzzPXhLME=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=SVyvjv96vDdP7jSZQUbv+JxTaEUSvEsiM4XCsUPLdqlaK0mX0Xz/MOerzWkhkSA8Q
         8Zuu0NlBldlu6EiZL5IThULON8AI7jCD+oYCMABkjHA1dxF0eWO7yFhTSHUGmk56rc
         nLORk+sO8zbky2b9X0O3M4Moml3m+XUOa1kv+JJI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377FYfsZ031141
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 10:34:41 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 10:34:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 10:34:41 -0500
Received: from [10.250.36.243] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377FYeW8026454;
        Mon, 7 Aug 2023 10:34:40 -0500
Message-ID: <ca0a7c5c-d098-743b-eee4-fa341b10c6a8@ti.com>
Date:   Mon, 7 Aug 2023 10:34:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 12/13] arm64: dts: ti: k3-am65: Enable TSCADC nodes at the
 board level
Content-Language: en-US
To:     Dhruva Gole <d-gole@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230802205309.257392-1-afd@ti.com>
 <20230802205309.257392-13-afd@ti.com>
 <cd8352a9-6ab4-dbcc-1bee-8ad76e6b3004@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <cd8352a9-6ab4-dbcc-1bee-8ad76e6b3004@ti.com>
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

On 8/7/23 12:51 AM, Dhruva Gole wrote:
> Andrew,
> 
> On 03/08/23 02:23, Andrew Davis wrote:
>> TSCADC nodes defined in the top-level AM65 SoC dtsi files are incomplete
>> and may not be functional unless they are extended with pinmux and/or
>> device information.
>>
>> Disable the TSCADC nodes in the dtsi files and only enable the ones that
>> are actually pinned out on a given board.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 5 +----
>>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            | 2 ++
>>   arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 2 ++
>>   3 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>> index 6041862d5aa75..ba1c14a54acf4 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>> @@ -582,11 +582,8 @@ &mcu_spi0 {
>>       ti,pindir-d0-out-d1-in;
>>   };
>> -&tscadc0 {
>> -    status = "disabled";
>> -};
>> -
>>   &tscadc1 {
>> +    status = "okay";
> 
> The commit body says,
> "Disable the TSCADC nodes in the dtsi files"
> 
> Please can we also provide some explanation on why
> tscadc1 was left as okay here in a dtsi file?
> 

Same reasoning as in my response for patch [4/13], the node
is complete at this point, so we enable it here.

The commit message is a bit off given these boards do their
pinmuxing in the .dtsi files, not at the last level .dts files
like most boards, but I kept the commit message consistent for
the whole series as this is a rare exception case. I can change
the message wording if you would like.

Andrew

>>       adc {
>>           ti,adc-channels = <0 1 2 3 4 5>;
>>       };
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
>> index 2c9c20a9d9179..4defde540fe0b 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
>> @@ -112,6 +112,7 @@ tscadc0: tscadc@40200000 {
>>           dmas = <&mcu_udmap 0x7100>,
>>               <&mcu_udmap 0x7101 >;
>>           dma-names = "fifo0", "fifo1";
>> +        status = "disabled";
>>           adc {
>>               #io-channel-cells = <1>;
>> @@ -130,6 +131,7 @@ tscadc1: tscadc@40210000 {
>>           dmas = <&mcu_udmap 0x7102>,
>>               <&mcu_udmap 0x7103>;
>>           dma-names = "fifo0", "fifo1";
>> +        status = "disabled";
>>           adc {
>>               #io-channel-cells = <1>;
>> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>> index 43de7c132d343..17f45a9f7b146 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>> @@ -478,12 +478,14 @@ &usb0_phy {
>>   };
>>   &tscadc0 {
>> +    status = "okay";
>>       adc {
>>           ti,adc-channels = <0 1 2 3 4 5 6 7>;
>>       };
>>   };
>>   &tscadc1 {
>> +    status = "okay";
>>       adc {
>>           ti,adc-channels = <0 1 2 3 4 5 6 7>;
>>       };
> 
