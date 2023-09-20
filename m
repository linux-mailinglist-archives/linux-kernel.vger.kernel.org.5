Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FB87A717D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 06:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjITERv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 00:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjITERt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 00:17:49 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021DA9C;
        Tue, 19 Sep 2023 21:17:41 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38K4HVxN044462;
        Tue, 19 Sep 2023 23:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695183451;
        bh=GUwHqxc3onQ7spFD8fjjdf2+aoWcY9FPLtzhvEFhHII=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=zT5WxjV4mqSn75di28081wd7911Dbwpa070x0Mmg9zwJSs/+Cgg6XKJRZWmTen6Em
         vEdlj+O/C89ZuX+gLYNCNmIMWoGNv6DMQGV0ZKtkkhpMEy1iXWKAHL/rP1y8ehPBK9
         RR9j4sByeJc9HVAyerIlAD1aYvqVAOhDTOTZZldI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38K4HV4X010186
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Sep 2023 23:17:31 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 23:17:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 23:17:31 -0500
Received: from [172.24.227.83] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38K4HRcY026403;
        Tue, 19 Sep 2023 23:17:28 -0500
Message-ID: <d5d98e74-97cf-62fc-c72c-9081073708d2@ti.com>
Date:   Wed, 20 Sep 2023 09:47:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: ti: k3-am654-base-board: Add I2C I/O expander
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230919050340.16156-1-r-gunasekaran@ti.com>
 <3e4fb573-3439-5d5c-866d-75bc20732d92@ti.com>
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <3e4fb573-3439-5d5c-866d-75bc20732d92@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/19/23 5:51 PM, Andrew Davis wrote:
> On 9/19/23 12:03 AM, Ravi Gunasekaran wrote:
>> AM654 baseboard has two TCA9554 I/O expander on the WKUP_I2C0 bus.
>> The expander at address 0x38 is used to detect daughter cards.
>> Add a node for this I/O expander.
>>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>> index f5c26e9fba98..035b20386ef3 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>> @@ -381,6 +381,13 @@
>>           interrupt-controller;
>>           #interrupt-cells = <2>;
>>       };
>> +
>> +    pca9554_1: gpio@38 {
> 
> As this is at a lower address than the other expander(39), why
> not put it before that one to keep these in order?

Sure. I will reorder the placement of nodes.

> 
> Also, do you need the label(pca9554_1:) for anything, if not
> drop it for now.

The label is not needed at the moment. I will drop the label.

Thanks for reviewing the patch. I will make the changes and post v2.

> 
> Andrew
> 
>> +        compatible = "nxp,pca9554";
>> +        reg = <0x38>;
>> +        gpio-controller;
>> +        #gpio-cells = <2>;
>> +    };
>>   };
>>     &mcu_i2c0 {
>>
>> base-commit: dfa449a58323de195773cf928d99db4130702bf7

-- 
Regards,
Ravi
