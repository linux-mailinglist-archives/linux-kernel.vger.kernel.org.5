Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C97E807650
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378635AbjLFRRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378558AbjLFRRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:17:20 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88366D3;
        Wed,  6 Dec 2023 09:17:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQSIjCAXOPsazSjvzrTsU1EC7lNoqSARx7enAOCvRXZ12+O1wgH/QOo+dVX2LIqHPGLgX6pHoZ63SmITxQmCzu6agOkvILmlAL8brfiFjEqgARFwapERU/qqiplr5HUPCzlwmx38M/rKO+VO6YfQEhpnVo019UvYbPiR/TT33imFYoR+PaYq9frvcdoLKRs/fotqT/La2uuRUsHgdQmwIY4j/JPglLABVNrQqHb6A1C1250MHC9ejFsvmKh/yLFvFGA1BQTCkMf8w4DmDCOPIFpevhH+W+iP9EgVOLM82ZSnYZZd1S3352pnsR8aIW88La0gFZlYAZGjFDPfVoUwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L236ejkXgCGL6tPPCveqabRTEnX2VuXH1PfIV+oq98E=;
 b=AZo9M76MKQE9Gz3CoQQVXhBh7G7K1NIPlzVQXGfQGrhwI95Y3MPwec6rIV2v7oYzUAYDnFxpySoDvUQmFiGnA8fmSBQPBwnnHaQXGvcuDcQKA4PA8bd8lJmd5u1AiPqPJykIhoxnJwyEM24HguzVALDT/TTrvd4fmy5Kl1pgwEMpVItxUOA4AwFzsC4bQFJX/Ck+lmFUC+0bwtJPMMrAg0Oa1qYasGbQZnI2vEMULIDJQmUK4MiAXP9q0cOcWaW/zjma289wEVI+nYb/Z2KW8vSA29FAMU3vDc2f0Mgb7avFNyAJHJ8cQhgWbifytbScDuaHPmv7xexv5vxh4CdjpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L236ejkXgCGL6tPPCveqabRTEnX2VuXH1PfIV+oq98E=;
 b=3PzQ8NWmQBZ/SQlCQXUHQwzwhNo3yA9O35/kj6f5Ogwo3QopBT7tgPM9/tFHelhOp+CT7An+9d+pDMK8tBqLo1CIHX615c9ih+OAH8FeamawLO+eccjdv8cENhRx6wHBfUaPy2fFFTa1d4w3BbnHoLySsqlksahv9NH5ATEhgKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB8117.namprd12.prod.outlook.com (2603:10b6:806:334::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 17:17:23 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 17:17:23 +0000
Message-ID: <22add4c6-332c-45e4-ae0c-f287d6bff341@amd.com>
Date:   Wed, 6 Dec 2023 11:17:19 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 02/15] x86/resctrl: Remove hard-coded memory bandwidth
 event configuration
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com
Cc:     x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
        rdunlap@infradead.org, tj@kernel.org, peterz@infradead.org,
        seanjc@google.com, kim.phillips@amd.com, jmattson@google.com,
        ilpo.jarvinen@linux.intel.com, jithu.joseph@intel.com,
        kan.liang@linux.intel.com, nikunj@amd.com,
        daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
        rick.p.edgecombe@intel.com, rppt@kernel.org,
        maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        peternewman@google.com, dhagiani@amd.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <20231201005720.235639-3-babu.moger@amd.com>
 <47f870e0-ad1a-4a4d-9d9e-4c05bf431858@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <47f870e0-ad1a-4a4d-9d9e-4c05bf431858@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0054.namprd04.prod.outlook.com
 (2603:10b6:806:120::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: d68573d8-442c-4c2c-14fe-08dbf67f3610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /KUNegvZrKSQ8sHH7U673ehTTS9AW/UdMqym4mOz3wpeDOQw6LbR8+37AbsH22hc99Vn9woTR7c6fSfRyuG3BkI2EnGmo4Lc9YwlCZ8lJTiMEH9ZuNcT6NaGoa6gALSKzqJ16oMxlnDL7sx+Cz1PZWuNomboeXxKx09py6+W6GDfkBzGZ/cN0WlegJmEhvwOLb+Dxq8lIWymarn4nkOPa1bLXzAuVamX3toCe+s6f75mnrET/HMTd45gj9PI6oTpTsnc06LZQsiAwZpcPX77SwVhEQH/JkG2bkrxOMPS7owo7JyfHnl2hWROnFncn99L4emUQUB3yDiEPgZ9QFYBIV3oAgmwZFN6pOmmI4OXG4TiKpTfpQYXr4okZMu2nUdbzXq7gbRx/qwvXWyt+1FRY+hE3uKd6lqXWETTCY65WYimKI1KabTZ7OLCrqFdKjRPYdTPhWHX1VzFZoww9d7ZLjyN3pV7PBZyNnQj9sLvlLMpArIZj+0bVzK1xcliOH9sPXQdYpL04RjljwJHJWs50hTzXQb2L1Tmlvddx/2dxcYmHDARqklUbEHRif6l8rFkIzaTy80dPEE+X36VRGBPw2KYGaaeImSGmNNBdqb8WL660MueBIUkzf7cIiW8hY82T2FyUfo/YSbo+2B5k2zvpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(31686004)(7416002)(3450700001)(38100700002)(2906002)(5660300002)(83380400001)(6512007)(53546011)(6666004)(6506007)(2616005)(26005)(316002)(478600001)(966005)(6486002)(36756003)(41300700001)(66476007)(8936002)(4326008)(66556008)(31696002)(86362001)(66946007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clpiRzRUTTY4ZHZaMkRrNWZlbzJIcFdwRVVDVy9DUnNoYytLWWZuWU9pMXdQ?=
 =?utf-8?B?NUp3Qy85NHFOY3Z5YWJWYlE1a3pBejhJWFBLWjhJdVRlSGtndDFEUTlMY2Y0?=
 =?utf-8?B?ZVE2SjNRS1V1QitzWkRSVzBBQzdjK1d0b1YxY1o4bzF4VWZIZ3JHMTgwd2I1?=
 =?utf-8?B?RWVYdS9NWnRRZXArWWpETThWZkM1bEhQZ2ZpM1FJSUt2bGJ6Rm9RTy9oNDVR?=
 =?utf-8?B?TUlzZTZTMTI1OUt0VVpRaUlCeUNLZjBnc0hySzJEaDlxbGM3M0RxS0p0dCtU?=
 =?utf-8?B?Nnd0Z1pNM0FnaHkwemRHbk1ycjR5dlA1b25tdFdWdUFhdVJpYk9sdWJORHdR?=
 =?utf-8?B?d0pCM2ZqRzhUUXVpQ2JiZU4vKzZsZEtpYUlMZG1PZ3BmVXVTRldhN1pNRFpw?=
 =?utf-8?B?N0ZoK1ZudU5Ec29CNGQ2cnZMZmlua0RiUkVrZDFjditLc2M0M0ZWZjBpTHZx?=
 =?utf-8?B?VVZtYUNObW84Qy9mSmdkT2FTM1R4c05rU0x1VmdhNUVpUDRHTmRnaE1sUGY2?=
 =?utf-8?B?UHdwMnloL2NtbDRiaWdvNlI5azVCOWZMeDZRV2VMM0tOalVRc3Nnb2hLU3Nx?=
 =?utf-8?B?cVRPWlZnVWd5QWt3cEFMMUZET0xGQllEQThyc04ralJERkltTm5YRGpZeU9u?=
 =?utf-8?B?SkJIWTJlWHZXS1pWODRVOXVndHRWYkdPbS93aVZIVTYxYkJMcEhURlBxUXRS?=
 =?utf-8?B?cFZyOEhHL3kra21tWnkwSmxxRm9iRURJSi9LWnJycGtVY25iZ1NxVlYxUjU2?=
 =?utf-8?B?dUFvWVFhSUJ1bU1NRkxGR3VNcW0zbndkMGdkNG44R0ZidmpBWkdrS3FlU01D?=
 =?utf-8?B?eWZrSnF6RnpxeExCWW9zRkxpRHl0bzRiZlpvRzlCOGczWkVGSzZSVFYvVU1j?=
 =?utf-8?B?cGhRb2JXQnFYbTNjVDY0bWlOdFNDZVdjaGZlNlljYU5QWmhHV3BSb2lPbHEv?=
 =?utf-8?B?a1lVbWlpa2tweDNiWTBnbkcxZ1oyTUw3K211RGJDRTNhVVQ1eTBNbjVRS0lm?=
 =?utf-8?B?Y3phdHRmSlJrNVF4TFRvWFIwNjJjWit3QXQ4dUlMamsySXhYcTBDUVVNQUo1?=
 =?utf-8?B?RkZ0SFNMVlFMZ05YL3h0V1FaTDJPbWwrNlJJaXBDS2JydldJaWFJWElCT291?=
 =?utf-8?B?dXB2cEttRHc3MEdnUGhuVC9aSmRMREd2Nm42bUNOVUpWRjZXeEhXMG0wcUxv?=
 =?utf-8?B?bEZiODJ3RXlkcVZtN21wbit2MmZWSDdzMFBIOC9SQWJ6RjMzdVpZRFpBamFP?=
 =?utf-8?B?TlE4bHVQOGhhSDJPQXhmUWNJTUVaaDYxREdEb0FyN2c2bEZBTnJLSGhVZjZs?=
 =?utf-8?B?US94SWpIb2FiNFN2eU0yVUc3RGJ0clZ5TThQQ09CYWtyQUVLU29XTVNNMEpx?=
 =?utf-8?B?Qm02aVZXUUNyN2c3Mk1rUXl5UE9hRzNjR2dLbWRIZ0VtdkI3Mms1TTVHM29O?=
 =?utf-8?B?Wi9Ic0NFeE5JUXVyRzVhNVJubFBnWmNYY1h1S1FEYlpyZEtZOVQvaVlGTWw5?=
 =?utf-8?B?RksvbGVpQlpkbGJMQmk3cUd1YTJjR1dSSUlCZ0hidjM1cVVNQy9CU0hxRUxC?=
 =?utf-8?B?SjZCUVBpZkxOaWtCSFl1RmFVbHFPazR3cE1teDZPNGNvWXUvTzBNVzRKSDBE?=
 =?utf-8?B?RWN3WDJwdkFOcklkQU5nWUs2MnRLQUhNN1VXUG04ZEw0L0NZME5XS2lORHpY?=
 =?utf-8?B?OHpDbEo5eHJBYTZ6RHJNWDVsZFNBUW42WmpobzgvM2hnZGlsaDVQRFFJbDBQ?=
 =?utf-8?B?U3NDdDJ4TVdEL1dhV2N2NEF5aHlZQ0xCdHhpQmhNamhFL1gwZHhrenBUVzlD?=
 =?utf-8?B?UW9ITUU4NWdVbDl1SVlsRFN4UG9BcGFDd1hzU1VSLzJnb3NNYmxGdzkvRXdK?=
 =?utf-8?B?RStkOWJlOGhFVmh3ZTNNTlV4bVZESzQvN1owZTRMVjJpRVRoSmNPekZybXd4?=
 =?utf-8?B?bGc4MnZQVUlHTXc2N3ZxNTVMNUx0MGZTem5IZGRObFlOc0puZk93bWx6cW5r?=
 =?utf-8?B?MG5ZRHRGSkZ6TGFFSVd0ZVlZYUgzUVBoVTdyenFBUThXYklYelBmaFAxWnpv?=
 =?utf-8?B?QThMRlgycC9VcnEvb0Z5TUhwRHY4cVl2VzBhSUhpb3YvTmNnZnVYZGs0U0dv?=
 =?utf-8?Q?gTmg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68573d8-442c-4c2c-14fe-08dbf67f3610
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 17:17:23.2966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9CJ9oVffl43QjveSn/mOCEcnGRxqE+Og3jFJOkvtDFLE+UowAWmxxc0mzl9Pl7O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 12/5/23 17:21, Reinette Chatre wrote:
> Hi Babu,
> 
> On 11/30/2023 4:57 PM, Babu Moger wrote:
>> If the BMEC (Bandwidth Monitoring Event Configuration) feature is
>> supported, the bandwidth events can be configured. Currently, the maximum
>> supported event bitmask is hard-coded. This information can be detected by
>> the CPUID_Fn80000020_ECX_x03.
> 
> Be careful here ... the original meaning is the maximum length of the bitmask
> and the new meaning is the maximum valid bitmask. Looking at the AMD spec
> it looks to me that the original meaning is still valid, the number of
> bits available in register to configure the bandwidth types is still the same.
> 
> There is additional information about which of those bits are actually supported
> by the hardware.

There is no change in the definition. Definition is still the same. I just
wanted to remove hard-coding.

Will make that clear.

> 
>>
>> CPUID_Fn80000020_ECX_x03 [Platform QoS Monitoring Bandwidth Event
>> Configuration] Read-only. Reset: 0000_007Fh.
>> Bits	Description
>> 31:7	Reserved
>>  6:0	Identifies the bandwidth sources that can be tracked.
> 
> So above means that only bits 0 to 6 can be used for config of event type? This
> is done in current implementation and I do not think this should change.
> Learning and using the supported events from hardware is new.

That is correct. Right now bits 0 to 6 are only used. New hardware can add
more bits here to count new type of event.

> 
>>
>> Remove the hardcoded value and detect using CPUID command.
>>
>> The CPUID details are documentation in the PPR listed below [1].
>> [1] Processor Programming Reference (PPR) Vol 1.1 for AMD Family 19h Model
>> 11h B1 - 55901 Rev 0.25.
>>
>> Fixes: dc2a3e857981 ("x86/resctrl: Add interface to read mbm_total_bytes_config")
> 
> Please highlight the impact here to understand if this is

This is just to make sure not to change code for new hardware adds new
event. There is not much impact currently.


> stable material. This also does not seem part of this series.

Agree. This is not specific to this series.

> 
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> ---
>>  arch/x86/kernel/cpu/resctrl/internal.h |  4 +---
>>  arch/x86/kernel/cpu/resctrl/monitor.c  | 11 +++++++++++
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 ++--
>>  3 files changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index d2979748fae4..524d8bec1439 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -50,9 +50,6 @@
>>  /* Dirty Victims to All Types of Memory */
>>  #define DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)
>>  
>> -/* Max event bits supported */
>> -#define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
>> -
>>  struct rdt_fs_context {
>>  	struct kernfs_fs_context	kfc;
>>  	bool				enable_cdpl2;
>> @@ -117,6 +114,7 @@ extern bool rdt_alloc_capable;
>>  extern bool rdt_mon_capable;
>>  extern unsigned int rdt_mon_features;
>>  extern struct list_head resctrl_schema_all;
>> +extern unsigned int resctrl_max_evt_bitmask;
>>  
> 
> Why is this global and not resource specific like other monitoring
> properties?

It does not have to be global. I can add it part rdt_hw_resource.

> 
>>  enum rdt_group_type {
>>  	RDTCTRL_GROUP = 0,
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index f136ac046851..c611b16ba259 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -127,6 +127,11 @@ static const struct mbm_correction_factor_table {
>>  static u32 mbm_cf_rmidthreshold __read_mostly = UINT_MAX;
>>  static u64 mbm_cf __read_mostly;
>>  
>> +/*
>> + * Identifies the list of QoS Bandwidth Sources to track
>> + */
>> +unsigned int resctrl_max_evt_bitmask;
>> +
>>  static inline u64 get_corrected_mbm_count(u32 rmid, unsigned long val)
>>  {
>>  	/* Correct MBM value. */
>> @@ -813,6 +818,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>  		return ret;
>>  
>>  	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
>> +		u32 eax, ebx, ecx, edx;
>> +
>> +		/* Detect list of bandwidth sources that can be tracked */
>> +		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
>> +		resctrl_max_evt_bitmask = ecx;
>> +
>>  		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
>>  			mbm_total_event.configurable = true;
>>  			mbm_config_rftype_init("mbm_total_bytes_config");
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 69a1de92384a..6c22718dbaa2 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1547,7 +1547,7 @@ static void mon_event_config_read(void *info)
>>  	rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
>>  
>>  	/* Report only the valid event configuration bits */
>> -	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
>> +	mon_info->mon_config = msrval & resctrl_max_evt_bitmask;
> 
> Original code still looks correct to me. Just like before the first seven
> bits of  MSR_IA32_EVT_CFG_BASE contains the event configuration.

Original code still works.

> 
> Comparing with supported bits would be an additional check, but what does
> that imply? Would it be possible for hardware to have a bit set that is
> not supported? Would that mean it is actually supported or a hardware bug?

No. Hardware supports all the bits reported here. Like i said before
wanted to remove the hard-coded value.

> 
>>  }
>>  
>>  static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
>> @@ -1621,7 +1621,7 @@ static int mbm_config_write_domain(struct rdt_resource *r,
>>  	int ret = 0;
>>  
>>  	/* mon_config cannot be more than the supported set of events */
>> -	if (val > MAX_EVT_CONFIG_BITS) {
>> +	if (val > resctrl_max_evt_bitmask) {
>>  		rdt_last_cmd_puts("Invalid event configuration\n");
>>  		return -EINVAL;
>>  	}
> 
> This does not look right. resctrl_max_evt_bitmask contains the supported
> types. A user may set a value that is less than resctrl_max_evt_bitmask but
> yet have an unsupported bit set, no?

I think I have to make this clear in the patch. There is no difference in
the definition. Hardware supports all the events reported by the cpuid.
-- 
Thanks
Babu Moger
