Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD157519F7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbjGMHbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbjGMHbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:31:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B50D9E77;
        Thu, 13 Jul 2023 00:31:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4E821570;
        Thu, 13 Jul 2023 00:31:46 -0700 (PDT)
Received: from [10.163.49.144] (unknown [10.163.49.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44FD03F73F;
        Thu, 13 Jul 2023 00:30:57 -0700 (PDT)
Message-ID: <ca559765-0f07-b187-bdcd-826dcd99a312@arm.com>
Date:   Thu, 13 Jul 2023 13:00:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] perf: Remove unused PERF_PMU_CAP_HETEROGENEOUS_CPUS
 capability
Content-Language: en-US
To:     James Clark <james.clark@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, irogers@google.com
References: <20230710122138.1450930-1-james.clark@arm.com>
 <20230710122138.1450930-5-james.clark@arm.com>
 <96a3d12a-71d8-1779-28a3-316e1838292e@arm.com>
 <6143e1cd-4db7-d980-a189-b9b06f99d7c4@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <6143e1cd-4db7-d980-a189-b9b06f99d7c4@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/23 19:45, James Clark wrote:
> 
> 
> On 11/07/2023 13:10, Anshuman Khandual wrote:
>>
>>
>> On 7/10/23 17:51, James Clark wrote:
>>> Since commit bd2756811766 ("perf: Rewrite core context handling") the
>>> relationship between perf_event_context and PMUs has changed so that
>>> the error scenario that PERF_PMU_CAP_HETEROGENEOUS_CPUS originally
>>> silenced no longer exists.
>>>
>>> Remove the capability to avoid confusion that it actually influences
>>> any perf core behavior. This change should be a no-op.
>>>
>>> Signed-off-by: James Clark <james.clark@arm.com>
>>> ---
>>>  include/linux/perf_event.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>>> index d5628a7b5eaa..3f4d941fd6c5 100644
>>> --- a/include/linux/perf_event.h
>>> +++ b/include/linux/perf_event.h
>>> @@ -288,7 +288,7 @@ struct perf_event_pmu_context;
>>>  #define PERF_PMU_CAP_EXTENDED_REGS		0x0008
>>>  #define PERF_PMU_CAP_EXCLUSIVE			0x0010
>>>  #define PERF_PMU_CAP_ITRACE			0x0020
>>> -#define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x0040
>>> +/* Unused					0x0040 */
>>
>> Small nit, "Unused" marking might not be required here.
>>
> 
> But then it would be very easy to miss that there is a free bit if I
> don't leave the comment. Is it really better without it?
> 
> I could shift all the following ones down by one bit, but it would be a

Sounds as a better option IMHO.

> lot of work to make sure that nobody has hard coded some check for one
> of the bits instead of using the define somewhere.

These are not user visible ABI and hence defined in include/linux/perf_event.h
to be used by drivers registering a PMU for capability enumeration. I am just
wondering why they might have been hard coded any where ?

> 
>>>  #define PERF_PMU_CAP_NO_EXCLUDE			0x0080
>>>  #define PERF_PMU_CAP_AUX_OUTPUT			0x0100
>>>  #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0200
