Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419B07E6E86
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343735AbjKIQWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjKIQWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:22:14 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C45F35A9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 08:22:12 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A9GM1qt121875;
        Thu, 9 Nov 2023 10:22:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699546921;
        bh=0DXlK9jkYi+xTd8pNsA36YrecrZqWKGiiQ8Jt8rU4GI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=VoytLGJ9hw8yfy4H1sevIb3CKL2h1GyihoVnoegLtHQzMaplVQL5+IBjNUX0RgZI3
         YZFI1KJt+jiDDbv7KolTaCAMBEVhY0BJTgOifz2vBfQi8ORMpwLQv3B9S5YCkCQ/BN
         tDLfTMETEfNs565JVgY1zEaFPB9NBP7qjnmtydyM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A9GM1U7000797
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Nov 2023 10:22:01 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 Nov 2023 10:22:00 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 Nov 2023 10:22:00 -0600
Received: from [10.247.30.236] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A9GM0tD119660;
        Thu, 9 Nov 2023 10:22:00 -0600
Message-ID: <818ecf7b-cd91-45ca-bb92-65f10f1ca1f0@ti.com>
Date:   Thu, 9 Nov 2023 10:22:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] TPS65224 PMIC driver
Content-Language: en-US
To:     Julien Panis <jpanis@baylibre.com>,
        Gairuboina Sirisha <sirisha.gairuboina@Ltts.com>
CC:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <linux-kernel@vger.kernel.org>, <d-gole@ti.com>
References: <b9449689-73da-41a8-a94e-f82686ab0bb0@baylibre.com>
 <20231107113740.1034738-1-sirisha.gairuboina@Ltts.com>
 <2f467b0a-1d11-4ec7-8ca6-6c4ba66e5887@baylibre.com>
From:   Shree Ramamoorthy <s-ramamoorthy@ti.com>
In-Reply-To: <2f467b0a-1d11-4ec7-8ca6-6c4ba66e5887@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On 11/8/2023 3:19 AM, Julien Panis wrote:
> On 11/7/23 12:37, Gairuboina Sirisha wrote:
>> From: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
>>
>>> On 10/26/23 15:32, Gairuboina Sirisha wrote:
>>>> Added support for TPS65224 PMIC in linux.
>>>> This patch set includes driver for core, i2c and pfsm.
>>>> The driver was tested on TI's custom AM62A EVM.
>>>>
>>>> Gairuboina Sirisha (3):
>>>>     drivers: mfd: Add support for TPS65224
>>>>     drivers: mfd: Add support for TPS65224 i2c driver
>>>>     drivers: misc: Add support for TPS65224 pfsm driver
>>>>
>>>>    drivers/mfd/Kconfig                |  19 +
>>>>    drivers/mfd/Makefile               |   2 +
>>>>    drivers/mfd/tps65224-core.c        | 291 ++++++++++++
>>>>    drivers/mfd/tps65224-i2c.c         | 245 ++++++++++
>>>>    drivers/misc/Kconfig               |  12 +
>>>>    drivers/misc/Makefile              |   1 +
>>>>    drivers/misc/tps65224-pfsm.c       | 290 ++++++++++++
>>>>    include/linux/mfd/tps65224.h       | 735 
>>>> +++++++++++++++++++++++++++++
>>>>    include/uapi/linux/tps65224_pfsm.h |  36 ++
>>>>    9 files changed, 1631 insertions(+)
>>>>    create mode 100644 drivers/mfd/tps65224-core.c
>>>>    create mode 100644 drivers/mfd/tps65224-i2c.c
>>>>    create mode 100644 drivers/misc/tps65224-pfsm.c
>>>>    create mode 100644 include/linux/mfd/tps65224.h
>>>>    create mode 100644 include/uapi/linux/tps65224_pfsm.h
>>> Hi Sirisha,
>>>
>>> These drivers strongly look like TPS6594 drivers.
>>>
>>> Instead of submitting new drivers, you should consider reusing and
>>> modifying the existing ones for TPS6594. You might add your new 
>>> 'compatible'
>>> entry ("ti,tps65224-q1") in TPS6594 dt-bindings (see 
>>> 'ti,tps6594.yaml' file)
>>> to identify your TPS65224 PMIC. This new 'compatible' would also be 
>>> added
>>> in the existing 'tps6594_i2c_of_match_table'. You can have a look at
>>> 'tps->chip_id' in 'tps6594-core.c' and see how we use it to deal 
>>> with slight
>>> differences between different PMIC IDs.
>> Thanks for the response. While the TPS65224 drivers follow the format 
>> and
>> structure of TPS6594, the register maps, masks, and ADC feature differ.
>> The two PMICs have overlapping features but TPS65224 is not treated 
>> as a subset.
>> TPS65224 is treated as a separate and independent driver instead of 
>> adding
>> compatibility to the existing TPS6594 driver that would then support 
>> 3 PMICS.
>> This separation will better support our differing PMICs.
>>
>> Thanks & Regards,
>> Sirisha G.
>
> I compared 'tps65224.h' with 'tps6594.h', especially register mapping.
> There are less resources in TPS65224, but I don't see any incompatibility
> between both PMIC register mappings. Some registers are not used by
> your TPS65224, and some interrupts are not used either (that's not a
> problem, they will not trigger, so). Beyond that, I2C and PFSM drivers
> perform the same things for both PMICs. That's why according to me,
> nothing prevents from re-using TPS6594 drivers. Even for ADC, which is
> specific to your TPS65224 indeed, the register range does not overlap
> with any of TPS6594 registers. You could conditionally add this driver
> (that's what we did in  'tps6594-core.c' for RTC driver, which is not 
> used
> for one of the compatibles: you can do something similar for ADC).
> You will probably add support for others TPS65224 drivers over the next
> weeks: SPI, ESM, RTC, GPIOs, regulators, watchdog, and ADC. Most of them
> should be compatible with both TPS6594 and TPS65224, I think (even
> watchdog driver, which was not developed for TPS6594). ADC will not,
> but as explained above you can easily deal with this one thanks to
> the compatible.
> For 'tps65224-core.c' only, a little bit of work might be necessary to
> handle your TPS65224 specific functionalities. By using a different DT
> compatible string, your driver can then select different options (or 
> maybe
> even different register ranges) for some features based on the 
> compatible.
> But except for 'tps65xx-core.c', there is "sufficient overlap" to justify
> sharing as much as possible between TPS65224 and TPS6594, in my
> opinion.


TI is positioning TPS65224 as a separate family from TPS6594, but shared 
software drivers for PMICs that have different use cases would lead to 
confusion. Re-scoping the project to accommodate these suggestions would 
negatively affect the timeline we are trying to meet. We want to include 
the restructure that addresses the compatibility, register maps, and 
functionality similarities, but it would best solved after the upcoming 
deadline has been met. With the growth of PMIC software device drivers, 
we would prefer to have a separate series with the suggested changes and 
proper naming convention to address that while they overlap, the two 
PMICs devices are not a subset.


Best,

Shree Ramamoorthy

