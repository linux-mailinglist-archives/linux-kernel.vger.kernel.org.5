Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9837D7D04
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 08:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbjJZGrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 02:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZGrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 02:47:37 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC79810E;
        Wed, 25 Oct 2023 23:47:34 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39Q6lLEP103335;
        Thu, 26 Oct 2023 01:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698302841;
        bh=/vlzh3Yc/MucFOUR1SOQLgHkbnNGyX3rEQeGRfo0TiQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=UtbE3rnCXfJF2e4QegRDfHH4myXrP4lORPqqf4UxgmlU2J52OY9v8U8Iz2mf5Tssy
         y/0oo3tnhTe6sDMHJhTftjYZ8Q98olP1KMPcrDnd5LDamDScLDoUdPalVJ+qYiN3Rv
         O6D7jA+cfvkJSr4Sepz7cLBD/VeqXw/rR0gICCWs=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39Q6lLCd007285
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Oct 2023 01:47:21 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 26
 Oct 2023 01:47:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 26 Oct 2023 01:47:21 -0500
Received: from [10.24.69.29] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39Q6lH6Q006204;
        Thu, 26 Oct 2023 01:47:18 -0500
Message-ID: <e8271648-e29f-80d2-4896-2d0d5c951c6f@ti.com>
Date:   Thu, 26 Oct 2023 12:17:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm64: boot: dts: ti: k3-am62a-main: Fix GPIO pin count
 in DT nodes.
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231025110252.1089979-1-n-yadav@ti.com>
 <20231025155743.nk7un6pvib7swtxg@decorator>
From:   Nitin Yadav <n-yadav@ti.com>
In-Reply-To: <20231025155743.nk7un6pvib7swtxg@decorator>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/10/23 21:27, Nishanth Menon wrote:
> On 16:32-20231025, Nitin Yadav wrote:
>> Fix number of gpio pins in main_gpio0 & main_gpio1 DT nodes according
>> to AM62a SK datasheet. The Link of datasheet is in the following line:
> 
> SK? line?
> 
> Please rephrase above and just mention the section of the data sheet to
> refer to.
> 
>>
>> https://www.ti.com/lit/gpn/am62a3
>>
>> Section: 6.3.10 GPIO (Page No. 52-55)
> 
>>
>> Fixes: '5fc6b1b62639c ("arm64: dts: ti: Introduce AM62A7 family of SoCs")'
> 
> What is the single quote for?
> Also note the additional comment in the list to drop the extra EoL.
> 
> 
> Did you check the MCU and WKUP GPIO count as well? if there are bugs
> around it, fix it in a single commit please.
yes, checked they are good.
> 
>>
>> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
>> index 3198af08fb9f..de36abb243f1 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
>> @@ -462,7 +462,7 @@ main_gpio0: gpio@600000 {
>>  			     <193>, <194>, <195>;
>>  		interrupt-controller;
>>  		#interrupt-cells = <2>;
>> -		ti,ngpio = <87>;
>> +		ti,ngpio = <92>;
>>  		ti,davinci-gpio-unbanked = <0>;
>>  		power-domains = <&k3_pds 77 TI_SCI_PD_EXCLUSIVE>;
>>  		clocks = <&k3_clks 77 0>;
>> @@ -480,7 +480,7 @@ main_gpio1: gpio@601000 {
>>  			     <183>, <184>, <185>;
>>  		interrupt-controller;
>>  		#interrupt-cells = <2>;
>> -		ti,ngpio = <88>;
>> +		ti,ngpio = <52>;
>>  		ti,davinci-gpio-unbanked = <0>;
>>  		power-domains = <&k3_pds 78 TI_SCI_PD_EXCLUSIVE>;
>>  		clocks = <&k3_clks 78 0>;
>> -- 
>> 2.25.1
>>
> 

-- 
Regards,
Nitin
