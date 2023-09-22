Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA547AB3CB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjIVOia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjIVOi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:38:28 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908CCC6;
        Fri, 22 Sep 2023 07:38:21 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38MEcFVt008143;
        Fri, 22 Sep 2023 09:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695393495;
        bh=Eee8a+E2/jFWUh8wC5+yOkHEwssjC3CMYXAC/DK7r4E=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=mGDfkeOeGpehapirML7OM4iwVrmzav33rGsiadIVmXRXxsjSyQnvTD9vFKfaK31L0
         PLYiIBqGXZV0UuJ0AGMgaCznjUsYDj2Az9IvGMxZLxy6w14dXy1nZVWDIgq3DBfMNO
         7OfMMLGDTmpxPyom6KfIQNRpAefMw/Dm6Tg3NfEA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38MEcFCa088172
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Sep 2023 09:38:15 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Sep 2023 09:38:14 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Sep 2023 09:38:14 -0500
Received: from [10.250.38.120] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38MEcEZj062901;
        Fri, 22 Sep 2023 09:38:14 -0500
Message-ID: <28c862d9-ca39-2dda-86dd-9ccc206c3a1d@ti.com>
Date:   Fri, 22 Sep 2023 09:38:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] arm: dts: omap: Apply am57xx-idk overlays to base dtbs
To:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>
CC:     =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230911214609.2201040-1-robh@kernel.org>
 <20230912065946.GC5285@atomide.com>
Content-Language: en-US
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230912065946.GC5285@atomide.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/23 1:59 AM, Tony Lindgren wrote:
> * Rob Herring <robh@kernel.org> [230911 21:46]:
>> DT overlays in tree need to be applied to a base DTB to validate they
>> apply, to run schema checks on them, and to catch any errors at compile
>> time.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>> Note that I have no idea if this combination of overlays makes sense.
> 

It does make sense, but it is only one of many valid combinations. I'm
guessing the goal here is just to make sure they all get applied in
at least one way so the scheme check runs. In that case this is fine
other than it might give the impression this is the only valid combinations.

Also now we end up with these odd `am57{1,2}x-idk-overlays.dtb` files
which also might confuse folks, I wonder if there is some way to
apply and check, but not ship/install these..

Andrew

> Adding Andrew to review this.
> 
> Regards,
> 
> Tony
> 
> ---
>>   arch/arm/boot/dts/ti/omap/Makefile | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/ti/omap/Makefile b/arch/arm/boot/dts/ti/omap/Makefile
>> index d2b590004fed..d0c76d09fe70 100644
>> --- a/arch/arm/boot/dts/ti/omap/Makefile
>> +++ b/arch/arm/boot/dts/ti/omap/Makefile
>> @@ -129,6 +129,11 @@ dtb-$(CONFIG_SOC_AM43XX) += \
>>   am57xx-evm-dtbs := am57xx-beagle-x15.dtb am57xx-evm.dtbo
>>   am57xx-evm-reva3-dtbs := am57xx-beagle-x15-revc.dtb am57xx-evm.dtbo
>>   
>> +am571x-idk-overlays-dtbs := am571x-idk.dtb \
>> +	am571x-idk-touchscreen.dtbo am57xx-idk-lcd-osd101t2587.dtbo
>> +am572x-idk-overlays-dtbs := am572x-idk.dtb \
>> +	am572x-idk-touchscreen.dtbo am57xx-idk-lcd-osd101t2045.dtbo
>> +
>>   dtb-$(CONFIG_SOC_DRA7XX) += \
>>   	am57xx-beagle-x15.dtb \
>>   	am57xx-beagle-x15-revb1.dtb \
>> @@ -145,6 +150,8 @@ dtb-$(CONFIG_SOC_DRA7XX) += \
>>   	am574x-idk.dtb \
>>   	am57xx-idk-lcd-osd101t2045.dtbo \
>>   	am57xx-idk-lcd-osd101t2587.dtbo \
>> +	am571x-idk-overlays.dtb \
>> +	am572x-idk-overlays.dtb \
>>   	dra7-evm.dtb \
>>   	dra72-evm.dtb \
>>   	dra72-evm-revc.dtb \
>> -- 
>> 2.40.1
>>
