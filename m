Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC197CDE45
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjJROGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjJROGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:06:00 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0F295;
        Wed, 18 Oct 2023 07:05:57 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39IE5kkX047446;
        Wed, 18 Oct 2023 09:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697637946;
        bh=0cgq4tlGMBHPbVCZjASqpvgrRBo11N6rFFPniLtEIYE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=ut+vgWmAqucDsthcLqXaS3Io9rRmxBdvJWrwX8wmhy5n84p0NZ5yKb43TB7QkR6yC
         A7Lt9aSb8mPSRnp/ya4Q8hhFiH1uDCUIIu8Mg3Uv/iVRrIchnSq5Gw2mrBvZDQkK49
         lToj3gBtNWtVKx8Z+FZWICzvZNDToJO9/xmzfUNo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39IE5kmc074754
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Oct 2023 09:05:46 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Oct 2023 09:05:46 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Oct 2023 09:05:46 -0500
Received: from [128.247.81.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39IE5kGk007446;
        Wed, 18 Oct 2023 09:05:46 -0500
Message-ID: <edb9361c-e100-450f-a4f6-10bc9eff2fe1@ti.com>
Date:   Wed, 18 Oct 2023 09:05:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: dts: omap: Apply am57xx-idk overlays to base dtbs
To:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>
CC:     =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231010211925.1629653-1-robh@kernel.org>
 <20231018052059.GJ34982@atomide.com>
Content-Language: en-US
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20231018052059.GJ34982@atomide.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/23 12:20 AM, Tony Lindgren wrote:
> * Rob Herring <robh@kernel.org> [231011 00:19]:
>> DT overlays in tree need to be applied to a base DTB to validate they
>> apply, to run schema checks on them, and to catch any errors at compile
>> time.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>> v2:
>>   - Only test applying overlays when building all DTBs
> 
> Andrew, any comments or care to ack?

As before, this is a valid combination, but it is only one of
many more. For now this is a reasonable start though,

Acked-by: Andrew Davis <afd@ti.com>

> 
> Regards,
> 
> Tony
> 
>> ---
>>   arch/arm/boot/dts/ti/omap/Makefile | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/ti/omap/Makefile b/arch/arm/boot/dts/ti/omap/Makefile
>> index d2b590004fed..d6ee4a247100 100644
>> --- a/arch/arm/boot/dts/ti/omap/Makefile
>> +++ b/arch/arm/boot/dts/ti/omap/Makefile
>> @@ -129,6 +129,16 @@ dtb-$(CONFIG_SOC_AM43XX) += \
>>   am57xx-evm-dtbs := am57xx-beagle-x15.dtb am57xx-evm.dtbo
>>   am57xx-evm-reva3-dtbs := am57xx-beagle-x15-revc.dtb am57xx-evm.dtbo
>>   
>> +am571x-idk-overlays-dtbs := am571x-idk.dtb \
>> +	am571x-idk-touchscreen.dtbo am57xx-idk-lcd-osd101t2587.dtbo
>> +am572x-idk-overlays-dtbs := am572x-idk.dtb \
>> +	am572x-idk-touchscreen.dtbo am57xx-idk-lcd-osd101t2045.dtbo
>> +
>> +# Build time test only, enabled by CONFIG_OF_ALL_DTBS
>> +dtb- += \
>> +	am571x-idk-overlays.dtb \
>> +	am572x-idk-overlays.dtb
>> +
>>   dtb-$(CONFIG_SOC_DRA7XX) += \
>>   	am57xx-beagle-x15.dtb \
>>   	am57xx-beagle-x15-revb1.dtb \
>> -- 
>> 2.42.0
>>
