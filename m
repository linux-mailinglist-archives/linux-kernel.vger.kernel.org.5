Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E637C76C1E5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjHBBH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjHBBHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:07:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F308273B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:07:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA5A9D75;
        Tue,  1 Aug 2023 18:08:33 -0700 (PDT)
Received: from [10.163.53.180] (unknown [10.163.53.180])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 439563F5A1;
        Tue,  1 Aug 2023 18:07:48 -0700 (PDT)
Message-ID: <505c6b25-d9e8-d7b3-1a0d-2b51e45fb66a@arm.com>
Date:   Wed, 2 Aug 2023 06:37:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 2/4] arm_pmu: acpi: Add a representative platform
 device for TRBE
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20230801094052.750416-1-anshuman.khandual@arm.com>
 <20230801094052.750416-3-anshuman.khandual@arm.com>
 <20230801145111.GF26253@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230801145111.GF26253@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/1/23 20:21, Will Deacon wrote:
> On Tue, Aug 01, 2023 at 03:10:50PM +0530, Anshuman Khandual wrote:
>> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
>> index a0801f68762b..7ec26d21303d 100644
>> --- a/include/linux/perf/arm_pmu.h
>> +++ b/include/linux/perf/arm_pmu.h
>> @@ -187,5 +187,6 @@ void armpmu_free_irq(int irq, int cpu);
>>  #endif /* CONFIG_ARM_PMU */
>>  
>>  #define ARMV8_SPE_PDEV_NAME "arm,spe-v1"
>> +#define ARMV8_TRBE_PDEV_NAME "arm-trbe-acpi"
> 
> Why is the TRBE name formatted differently to the SPE one?

Nothing specific, although "arm,spe-v1" seemed more like a DT naming
scheme. But could change the name as "arm,trbe-v1" to be in sync with
SPE here.
