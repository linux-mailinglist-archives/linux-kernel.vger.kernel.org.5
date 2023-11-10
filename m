Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19D27E837D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345923AbjKJUIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjKJUII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:08:08 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F746D0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 12:08:04 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AAK7oWb033998;
        Fri, 10 Nov 2023 14:07:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699646870;
        bh=b7MJQpJ5rxFuCWQeiqWLBvUKl0xX/yz5CDcbHdoPv5g=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Rhbqk7HL0JHuR4/mOMegBQ20geO5avNRpB4vdOp+QH3t7eAnEOudoInxoOYcMQ8pW
         II96fVOahrcjN1+SQZ+MXS2DEimnsbX2HHEuQPgVo+JTCFskRK16U1D+fw9XDR/XYM
         8BPgO3AfJqs7bE7AyLXSPJApVHNUjB/YD2ZY0Jjg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AAK7orC051944
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Nov 2023 14:07:50 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 Nov 2023 14:07:50 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 Nov 2023 14:07:50 -0600
Received: from [10.250.36.246] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AAK7nW3002200;
        Fri, 10 Nov 2023 14:07:49 -0600
Message-ID: <da6a39c5-0f53-48db-99b0-e251cedfe230@ti.com>
Date:   Fri, 10 Nov 2023 14:07:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v1 0/3] TPS65224 PMIC driver
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Julien Panis <jpanis@baylibre.com>,
        Gairuboina Sirisha <sirisha.gairuboina@ltts.com>,
        <arnd@arndb.de>, <krzysztof.kozlowski+dt@linaro.org>,
        <lee@kernel.org>, <linux-kernel@vger.kernel.org>, <d-gole@ti.com>
References: <b9449689-73da-41a8-a94e-f82686ab0bb0@baylibre.com>
 <20231107113740.1034738-1-sirisha.gairuboina@Ltts.com>
 <2f467b0a-1d11-4ec7-8ca6-6c4ba66e5887@baylibre.com>
 <818ecf7b-cd91-45ca-bb92-65f10f1ca1f0@ti.com>
 <2023111007-siamese-crepe-9775@gregkh>
From:   Shree Ramamoorthy <s-ramamoorthy@ti.com>
In-Reply-To: <2023111007-siamese-crepe-9775@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 11/9/2023 10:26 PM, Greg KH wrote:
> On Thu, Nov 09, 2023 at 10:22:00AM -0600, Shree Ramamoorthy wrote:
>>> I compared 'tps65224.h' with 'tps6594.h', especially register mapping.
>>> There are less resources in TPS65224, but I don't see any incompatibility
>>> between both PMIC register mappings. Some registers are not used by
>>> your TPS65224, and some interrupts are not used either (that's not a
>>> problem, they will not trigger, so). Beyond that, I2C and PFSM drivers
>>> perform the same things for both PMICs. That's why according to me,
>>> nothing prevents from re-using TPS6594 drivers. Even for ADC, which is
>>> specific to your TPS65224 indeed, the register range does not overlap
>>> with any of TPS6594 registers. You could conditionally add this driver
>>> (that's what we did in  'tps6594-core.c' for RTC driver, which is not
>>> used
>>> for one of the compatibles: you can do something similar for ADC).
>>> You will probably add support for others TPS65224 drivers over the next
>>> weeks: SPI, ESM, RTC, GPIOs, regulators, watchdog, and ADC. Most of them
>>> should be compatible with both TPS6594 and TPS65224, I think (even
>>> watchdog driver, which was not developed for TPS6594). ADC will not,
>>> but as explained above you can easily deal with this one thanks to
>>> the compatible.
>>> For 'tps65224-core.c' only, a little bit of work might be necessary to
>>> handle your TPS65224 specific functionalities. By using a different DT
>>> compatible string, your driver can then select different options (or
>>> maybe
>>> even different register ranges) for some features based on the
>>> compatible.
>>> But except for 'tps65xx-core.c', there is "sufficient overlap" to justify
>>> sharing as much as possible between TPS65224 and TPS6594, in my
>>> opinion.
>>
>> TI is positioning TPS65224 as a separate family from TPS6594, but shared
>> software drivers for PMICs that have different use cases would lead to
>> confusion.
> Why?  No one cares what a driver's name is, only that it works for their
> hardware.  What different "use case" would cause problems here?
>
>> Re-scoping the project to accommodate these suggestions would
>> negatively affect the timeline we are trying to meet.
> There are no timelines/deadlines with kernel development, sorry, that's
> not our issue.
>
>> We want to include the
>> restructure that addresses the compatibility, register maps, and
>> functionality similarities, but it would best solved after the upcoming
>> deadline has been met.
> Again, no deadline here.  Please do the work properly, that's all we
> care about.
>
>> With the growth of PMIC software device drivers, we
>> would prefer to have a separate series with the suggested changes and proper
>> naming convention to address that while they overlap, the two PMICs devices
>> are not a subset.
> Why does the name matter?  Again, all that a user cares about is if
> their hardware device is supported, the name means nothing here.
>
> Please do the correct thing and add support for this device to the
> existing drivers, that's the correct thing to do.  You will save time
> and energy and code in the long-run, which is the important thing.
>
> There is a reason that Linux drivers are, on average, 1/3 smaller than
> other operating systems.  And that's because they share common code with
> other drivers.  You aren't allowed to just copy an existing one and add
> a few changes and make a whole new driver, you need to modify the
> current one.
>
> thanks,
>
> greg k-h


Those are all fair points to ensure minimal code repetition. It’s the right decision
long term, and we’ll do what is necessary to address this. We're working with
the 3rd party to accommodate all suggestions to ensure best software practices.

  

Thank you!

Shree Ramamoorthy

