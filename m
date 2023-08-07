Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD650772934
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjHGP3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjHGP3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:29:04 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC9B9D;
        Mon,  7 Aug 2023 08:29:02 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377FSu8D049976;
        Mon, 7 Aug 2023 10:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691422136;
        bh=cDkjyFTapz98Il0vkG1+oyxSF8oLcD+se6NR5t7MO/4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=ICIzdmkE1Q/sPjuY7xkF3qfZQZGkLWb8APvw6MIF1C7aT9YOoWmfW7XxYF0k8oRyJ
         XFw89h6RLgMpA0af+Rq+bveTxpuRFNoHV6fAUycgb8Dlrefz5wKuxVewSFLWmC/Lib
         lSYcqRTAm+7lUjNc4EeEl4/LOFfY0MOEmXBs7zto=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377FSu6O027288
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 10:28:56 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 10:28:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 10:28:54 -0500
Received: from [10.250.36.243] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377FSsPV079433;
        Mon, 7 Aug 2023 10:28:54 -0500
Message-ID: <1b3366b0-e3a4-3609-9e25-7b880d2fe656@ti.com>
Date:   Mon, 7 Aug 2023 10:28:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/13] arm64: dts: ti: k3-j7200: Enable GPIO nodes at the
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
 <20230802205309.257392-11-afd@ti.com>
 <ea932535-b69c-ec57-0dfe-31a891b6df5c@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <ea932535-b69c-ec57-0dfe-31a891b6df5c@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/23 12:38 AM, Dhruva Gole wrote:
> Andrew,
> 
> On 03/08/23 02:23, Andrew Davis wrote:
>> GPIO nodes defined in the top-level J7200 SoC dtsi files are incomplete
>> and may not be functional unless they are extended with pinmux and
>> device information.
>>
>> Disable the GPIO nodes in the dtsi files and only enable the ones that
>> are actually pinned out on a given board.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   .../boot/dts/ti/k3-j7200-common-proc-board.dts | 18 ++++--------------
>>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi      |  4 ++++
>>   .../arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi |  2 ++
>>   3 files changed, 10 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> index dee9056f56051..4a5c4f36baeec 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> @@ -240,27 +240,17 @@ &main_uart3 {
>>       pinctrl-0 = <&main_uart3_pins_default>;
>>   };
>> -&main_gpio2 {
>> -    status = "disabled";
>> -};
>> -
>> -&main_gpio4 {
>> -    status = "disabled";
>> -};
>> -
>> -&main_gpio6 {
>> -    status = "disabled";
>> +&main_gpio0 {
>> +    status = "okay";
>> +    /* default pins */
> 
> Small question, where is the pmx for main_gpio0? What does "default pins"
> refer to here? Where are they pinmuxed?
> 

Good question, where is the pmx for main_gpio0? I don't know, it was
never defined before either, we only are noticing this now as we are
disabling by default instead of leaving an unfinished node enabled
by default. (another benefit of this disabled by default scheme).

What is really happening is GPIO nodes we tend to pinmux differently
than normal device nodes. Their pinmux selections tends to be spread
out in all the nodes that make use of these GPIO pins, not all together
here in this node.

For instance in this device we use one of the main_gpio0 pins as a
GPIO toggled regulator, and we define the pinmux for it in that node
(see vdd-sd-dv-default-pins).

We can either define the rest of the pins not used elsewhere
here, or we can consider GPIO an exception to the rule, I'd say
the latter is fine for now.

Andrew

>>   };
>>   &wkup_gpio0 {
>> +    status = "okay";
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&wkup_gpio_pins_default>;
>>   };
>> -&wkup_gpio1 {
>> -    status = "disabled";
>> -};
>> -
>>   &mcu_cpsw {
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&mcu_cpsw_pins_default>, <&mcu_mdio_pins_default>;
>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>> index 5d7542ba41b93..6a776f3bbcb19 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>> @@ -832,6 +832,7 @@ main_gpio0: gpio@600000 {
>>           power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
>>           clocks = <&k3_clks 105 0>;
>>           clock-names = "gpio";
>> +        status = "disabled";
>>       };
>>       main_gpio2: gpio@610000 {
>> @@ -849,6 +850,7 @@ main_gpio2: gpio@610000 {
>>           power-domains = <&k3_pds 107 TI_SCI_PD_EXCLUSIVE>;
>>           clocks = <&k3_clks 107 0>;
>>           clock-names = "gpio";
>> +        status = "disabled";
>>       };
>>       main_gpio4: gpio@620000 {
>> @@ -866,6 +868,7 @@ main_gpio4: gpio@620000 {
>>           power-domains = <&k3_pds 109 TI_SCI_PD_EXCLUSIVE>;
>>           clocks = <&k3_clks 109 0>;
>>           clock-names = "gpio";
>> +        status = "disabled";
>>       };
>>       main_gpio6: gpio@630000 {
>> @@ -883,6 +886,7 @@ main_gpio6: gpio@630000 {
>>           power-domains = <&k3_pds 111 TI_SCI_PD_EXCLUSIVE>;
>>           clocks = <&k3_clks 111 0>;
>>           clock-names = "gpio";
>> +        status = "disabled";
>>       };
>>       main_spi0: spi@2100000 {
>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
>> index 571eb0e2eac92..5ae7320efad7b 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
>> @@ -297,6 +297,7 @@ wkup_gpio0: gpio@42110000 {
>>           power-domains = <&k3_pds 113 TI_SCI_PD_EXCLUSIVE>;
>>           clocks = <&k3_clks 113 0>;
>>           clock-names = "gpio";
>> +        status = "disabled";
>>       };
>>       wkup_gpio1: gpio@42100000 {
>> @@ -313,6 +314,7 @@ wkup_gpio1: gpio@42100000 {
>>           power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
>>           clocks = <&k3_clks 114 0>;
>>           clock-names = "gpio";
>> +        status = "disabled";
>>       };
>>       mcu_navss: bus@28380000 {
> 
