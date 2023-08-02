Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBA876CA8A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjHBKLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjHBKLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:11:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2829F11F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 03:11:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEB35113E;
        Wed,  2 Aug 2023 03:11:57 -0700 (PDT)
Received: from [10.57.89.109] (unknown [10.57.89.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67A013F6C4;
        Wed,  2 Aug 2023 03:11:13 -0700 (PDT)
Message-ID: <2c1894c4-c0e3-ea90-d5f6-24c3ed8c0e4f@arm.com>
Date:   Wed, 2 Aug 2023 11:11:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH V2 2/4] arm_pmu: acpi: Add a representative platform
 device for TRBE
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20230801094052.750416-1-anshuman.khandual@arm.com>
 <20230801094052.750416-3-anshuman.khandual@arm.com>
 <20230801145111.GF26253@willie-the-truck>
 <505c6b25-d9e8-d7b3-1a0d-2b51e45fb66a@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <505c6b25-d9e8-d7b3-1a0d-2b51e45fb66a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2023 02:07, Anshuman Khandual wrote:
> 
> 
> On 8/1/23 20:21, Will Deacon wrote:
>> On Tue, Aug 01, 2023 at 03:10:50PM +0530, Anshuman Khandual wrote:
>>> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
>>> index a0801f68762b..7ec26d21303d 100644
>>> --- a/include/linux/perf/arm_pmu.h
>>> +++ b/include/linux/perf/arm_pmu.h
>>> @@ -187,5 +187,6 @@ void armpmu_free_irq(int irq, int cpu);
>>>   #endif /* CONFIG_ARM_PMU */
>>>   
>>>   #define ARMV8_SPE_PDEV_NAME "arm,spe-v1"
>>> +#define ARMV8_TRBE_PDEV_NAME "arm-trbe-acpi"
>>
>> Why is the TRBE name formatted differently to the SPE one?
> 
> Nothing specific, although "arm,spe-v1" seemed more like a DT naming
> scheme. But could change the name as "arm,trbe-v1" to be in sync with
> SPE here.

Do we really need v1 ? I would leave it as arm,trbe

Suzuki

