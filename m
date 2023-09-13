Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0B479DFF9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 08:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238246AbjIMGYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 02:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjIMGYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 02:24:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4D6172E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 23:24:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUvF7lJM3SrOOnvrM8IoVUHFH6mlFoIs9rmRffcFUX9L5YR4bqQRpLFe5wQlFaBFPEk9SgEhNQ44NjTV/EwjL7EcLWqKCPVg61x2ImP2eIKyE3L8WMZXc6udHM9P2i8/VWoXxNCnu9fU8wa5UxMKyhbKIS02k0rnVv2nrFBVSy3hUyPPxnpLzG5eChq4aCd9J27vUJcUaRBTMzduFcCFb3W2S0DhPY78xpjNtYTLFCn8RRVrlV4oko72uWutsMN0+nYbFsd9qUldzfhjknksfZOujVi6WXIwz9EbhS/gxHoccIcAy6WdhJmHiDqpIqda+CE//yrG8SsVd5NWmchraA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zR98Sjq0O7IMbPd17GboZW0TjmU2lxhx5GnWXkcJmg=;
 b=eKysn+xvcUR+YiqgJ8T1iN1Ik8oBsquHMCPeo35nim2Wqotgig0f8veEuj16CkzaELXjdmFMDa/ejYnahExRGkxZj8RDxM8AkRRUZthjAOooe5mpsWRprL9xpY01FIrHKYj5ADf5UruA6kfLAgd/ZKCRKR1vIjscNCYiycQEt13qsV3rg/NLpaW+i701YDxJlSyIa8S+QkvKwBGI5RzWD3vPtylJ7rNyNqCTz2aIuzpcRA0FD0iknsGVhTgoAEA+AZlP0wgFSK6OBICrYBqvPANKZDrgelYLC62L6iGfMB8qbWf6sGplenDBtRTMHIwgvYw64AGMEmG2yPC9GnQdmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zR98Sjq0O7IMbPd17GboZW0TjmU2lxhx5GnWXkcJmg=;
 b=khwHht6IkRY2GN5mlhNU9hUT4e1sBROjlDiFlyrgiIvdqPx3AjZ3/H9MQTZC/H7haop16l/EVJ9SV8Aqr7IwQtVQa/9DEWjlBpkmApHzRzhBPtG/eH3sQU78SFPgImQzD0Gku4XkNZ8RwaCBN4D/jzTffbimyIZ+LiLVAwGyKII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 06:24:36 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::74d4:ad6f:f00:8187]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::74d4:ad6f:f00:8187%3]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 06:24:36 +0000
Message-ID: <a249f3ea-7663-d906-b69f-2ea0e3a99a55@amd.com>
Date:   Wed, 13 Sep 2023 11:54:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH V1 0/6] sched/numa: Enhance disjoint VMA scanning
Content-Language: en-US
To:     Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Aithal Srikanth <sraithal@amd.com>,
        kernel test robot <oliver.sang@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
References: <cover.1693287931.git.raghavendra.kt@amd.com>
 <54fa32a9-36a8-f296-9be8-d2b28770f82e@amd.com>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <54fa32a9-36a8-f296-9be8-d2b28770f82e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::17) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|SA0PR12MB4512:EE_
X-MS-Office365-Filtering-Correlation-Id: 033b5ba6-2258-4b78-7922-08dbb4221a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVHB6LRutS+fZU1K78nis+oXa79PTEicQThXMKt2sTOSKhcRUUVmXUG6pdECTif9cDoFHToMdwWpK4xBy0XVlve12DqkEzaJxPMg61bo8OFc/a3X9nzFPzSkAXCe0vsVec0IArs0itK9etUxDShF6Dj00dlSnltry6mnPNqBloVgMUB+78SuXWVm8wiqbCcr5nl0TAOQxez4z48fQn7cwivhK/RtPhaiZj7V27S+cjWY3PbWT0Bx3YMuAr9SCeZxfPFBGvesnOeD8VYQ80IKVjttrJSAVsvzOun/5lqfszmrJQEf0zAJTkjZSpKUV5G5CW99GIGd5BnTrUpotvq800rg6KchqcGjUF/25xMj+gPkGIre0/ctSkgexVPSq9hESo0A5xP3FN2ZmQ5pOQOFmwXOxXN3dXxgvCSUResPFmUmbN6IHfpDNwWZR0yqAeB6zinm3DACrYUksZ1TLWqcWUY2GihDfl2gk/UMuu/zhSrQXMSraxyqCB4kwwXanDnrItwjQ42xynsmsYTiAxYgsuZe6egtuCWgri3fW0BtJmj9NLsDo2OL9QKRSMb0mpe1CfNC2ULC6pOxXrHNK0dDaXlIL1tlWH2glAVZXvO+KxrbRM5+1tID7YGItR9WiOhJhmUslutSY05rZR+6AZoDIHXFst8FmFbAsa27amm+hwd+GfxF49YpK1TZYfCfYAwz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(1800799009)(186009)(451199024)(31686004)(6666004)(6506007)(53546011)(6486002)(36756003)(31696002)(38100700002)(2616005)(26005)(2906002)(6512007)(966005)(478600001)(83380400001)(4326008)(5660300002)(8676002)(41300700001)(8936002)(7416002)(66476007)(316002)(54906003)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2J2bTVCSU0xYm1adHJvczIzWHB1YlhzZzlLSkw5SGcyaEE0SFJFclZFb0ZE?=
 =?utf-8?B?b3JiVWpmQlRucnVsczBIaGE3TlIrMDluTDlBSit3dHkzYU5qWlJMUG5lMUt1?=
 =?utf-8?B?aHZNM1ZQWnMzTDB0MHdCNjFyRS8zeUM4dUw4UkVzYnN1eHRZNC9nMHZ5Nkcw?=
 =?utf-8?B?Z1Q2cnlud2tXM1pEK3RRMkVpeEIxZy9WR3EwdVQxbjlxZzZwTGIza2cyak9w?=
 =?utf-8?B?dXdndVYxQzczSGdzMHo0Z3NrV25Qc0FhMElDcVdjd2RiTGNUUVdEUEQxSkRP?=
 =?utf-8?B?Y00wTXdtTy8vdmxQbmYzYlpsbzJpRmdoN2NyZDltQm0zVW5tbG11dThWVVJ5?=
 =?utf-8?B?c1ptbGh0QjU3YU50OGR6YkR3NC9vdUp1QjBMbjZ5T3ZDU2RtYVZHbXAxS1Ns?=
 =?utf-8?B?T3huQ2xyYWd6dHA4RHBkL2tqdlJkT3hOS3RmR0x3MmpWZk1xMHFUOEluTDNy?=
 =?utf-8?B?UFQ2eVFMYVQySmxSRW9OWEhSVFRhWmhGZlFUVTNudWtpait1K09xa0RUZEpk?=
 =?utf-8?B?SWpTYUI4MmZ3TlJ3SzFESGpGTmlFQWs3VTIyZE9tZlNJb2lUVkNOb3BEalVX?=
 =?utf-8?B?TUswUE9DUXlob2o1OGo5RWpwK081dHRkekJyT3NMWW8rR1FBbmx0bG94Q2FJ?=
 =?utf-8?B?K2EyNHdtR2ZXWnJmSG5ScWE2cGFqbFNNNnBPc3FISklORlNBNG1jNkRlZCtq?=
 =?utf-8?B?WllEUGNaOFg1M3g3VDZvQWJEaXpvcXk5U2lFdmQ1NDNWdFpsaDZ2dFloSEJq?=
 =?utf-8?B?dm9BUHEwbXdvUys3cEtMRTBPa24yRTVVc3RJUHUrMnIrNEFLZzMrdjFVR1By?=
 =?utf-8?B?Q1FaVG1NV3VyR3V2YzQrMVFpUlBlUjhWbHQ3anA1TWkzWWNpNXJUTDdDUnhP?=
 =?utf-8?B?YmlNK0hWNFRGbzUvdGM0Z2ZvbHlidmdyN01rZ2tua0crQXFZVS8xTU5xY3JJ?=
 =?utf-8?B?dG83YmdGcU9Ub0trWHRtSXdCVFZsUVFEL21NelNVdGpQUEVxNi9na3V3TWpi?=
 =?utf-8?B?SUVrUEU2VkM0UGxwNExJdTdSMjY1b2JjTHBwSXJaY2trQzVFRXhMVHkzKzE3?=
 =?utf-8?B?VXFUSzMrRG9CcE81MXNmakNoK01WZ0ttU0ZtcERLVHJyRFlsRjJWOXY1MWZD?=
 =?utf-8?B?RDNKZTlWdHkwVVNEQ0dhRlpFYUJXOU1YN0lYNEd2N1ZxNlFGTXkrUnE1VTZO?=
 =?utf-8?B?aTJSaEVOc3BPOFhwdzFjS3RTUjJGS0hjNFc5cXlMRmZVM21RaTJsbWhwUkYz?=
 =?utf-8?B?TjdYbU1CbWxqQkpZQUh6dGhNeXRKZFBmd0llZ1JaUHRLTXhReStrVWI1ZWp3?=
 =?utf-8?B?N1lQcG1OZUV1M2o3QUJIamNaWGc1OVNsQ3BpWnJYK0g3emIraCsrZVZ3VlFh?=
 =?utf-8?B?OEM3NjZUTjRUNGd3MHV3bXFsSk5POVRuQ2lnaUc2bm1HaFowSCtDSi9EQm9S?=
 =?utf-8?B?TjRoVnJOWXFPTENVckU0dmttaSt0V0xDWGhLOXNhQlhtdWo5VXc1aWlsL2Vz?=
 =?utf-8?B?TzMxUjNlQy9WZFlXRlEzUDhkMVZBY0ZGbUxldll0NG1TcDhZMVYzS1pKMks1?=
 =?utf-8?B?WkdQSzAvQUYvdXZGaFcrZ3RaQzZXakFYbFJUeE8vNy9SUW84eFpPUVZEV05O?=
 =?utf-8?B?Mm02RkEvbXNsN0R1U2UyYVhSdUdUMUVmMGVudlJJWTZNcnllWSsxc0preHBJ?=
 =?utf-8?B?dVlCTU03MFdEWTBzamhSRmhGREtMNW5HLzhNNmRVRmJRZlpwL3FIWDdubHh1?=
 =?utf-8?B?U01UR3NrM0hmZWdaZ2tFSXVGejF6emhWUkhqY3k0NnN2Nm1WWEsyQnBoQk9q?=
 =?utf-8?B?R1Z1RkMvMlNqWEZabmx2YTBaV245R1VLNDZWeDVLU2tzbjU2Y1ZLNFVqTWpB?=
 =?utf-8?B?QS9DR0VTRmtackFRZ1pxOFRsRnZWMERVM0I5aVJJcDJtZXFVVjRsc1dHWHJv?=
 =?utf-8?B?akFqOG1EbnB6R3NVajlWeldiU0tJVkV2dnliWGJLRkc3V0VqazZ3L3kzQnM0?=
 =?utf-8?B?MHQrU3h1WHRRamdoWUg2TDZ1QW1iWWtnZXJoa0lkT0tsQVpaSW1jUXQ5dDl0?=
 =?utf-8?B?dkRQTmRUWEk3QUlWQmFHSXpOa21EanpidUZ3cW9nUzRjWElrYzdOTWU1NHBz?=
 =?utf-8?Q?rvRnXfuPDJFUmJq+b1RhOtL+z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033b5ba6-2258-4b78-7922-08dbb4221a04
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 06:24:36.5074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifU0FRSMCszqVmmSXE2vJgymCWwaEaTt2dkYuaLpuObi+PCnLdzIH3qIj1upDg8hhv4MycU4oVJwPUponISvKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/2023 10:58 AM, Swapnil Sapkal wrote:
> Hello Raghu,
> 
> On 8/29/2023 11:36 AM, Raghavendra K T wrote:
>> Since commit fc137c0ddab2 ("sched/numa: enhance vma scanning logic") [1]
>> VMA scanning is allowed if:
>> 1) The task had accessed the VMA.
>>   Rationale: Reduce overhead for the tasks that had not
>> touched VMA. Also filter out unnecessary scanning.
>>
>> 2) Early phase of the VMA scan where mm->numa_scan_seq is less than 2.
>>   Rationale: Understanding initial characteristics of VMAs and also
>>   prevent VMA scanning unfairness.
>>
>> While that works for most of the times to reduce scanning overhead,
>>   there are some corner cases associated with it.
>>
>> This was found in an internal LKP run and also reported by [2]. There was
>> an attempt to fix.
>>
>> Link: 
>> https://lore.kernel.org/linux-mm/cover.1685506205.git.raghavendra.kt@amd.com/T/ 
>>
>>
>> This is a fully different series after Mel's feedback to address the 
>> issue
>>   and also a continuation of enhancing VMA scanning for NUMA balancing.
>>
>> Problem statement (Disjoint VMA set):
>> ======================================
>> Let's look at some of the corner cases with a below example of tasks 
>> and their
>> access pattern.
>>
>> Consider N tasks (threads) of a process.
>> Set1 tasks accessing vma_x (group of VMAs)
>> Set2 tasks accessing vma_y (group of VMAs)
>>
>>               Set1                      Set2
>>          -------------------         --------------------
>>          | task_1..task_n/2 |       | task_n/2+1..task_n |
>>          -------------------         --------------------
>>                   |                             |
>>                   V                             V
>>          -------------------         --------------------
>>          |     vma_x       |         |     vma_y         |
>>          -------------------         --------------------
>>
>> Corner cases:
>> (a) Out of N tasks, not all of them gets fair opportunity to scan. 
>> (PeterZ).
>> suppose Set1 tasks gets more opportunity to scan (May be because of the
>> activity pattern of tasks or other reasons in current design) in the 
>> above
>> example, then vma_x gets scanned more number of times than vma_y.
>>
>> some experiment is also done here which illustrates this unfairness:
>> Link: 
>> https://lore.kernel.org/lkml/c730dee0-a711-8a8e-3eb1-1bfdd21e6add@amd.com/ 
>>
>>
>> (b) Sizes of vmas can differ.
>> Suppose size of vma_y is far greater than the size of vma_x, then a 
>> bigger
>> portion of vma_y can potentially be left unscanned since scanning is 
>> bounded
>> by scan_size of 256MB (default) for each iteration.
>>
>> (c) Highly active threads trap a few VMAs frequently, and some of the 
>> VMAs not
>> accessed for long time can potentially get starved of scanning 
>> indefinitely
>> (Mel). There is a possibility of lack of enough hints/details about 
>> VMAs if it
>> is needed later for migration.
>>
>> (d) Allocation of memory in some specific manner (Mel).
>> One example could be, Suppose a main thread allocates memory and it is 
>> not
>> active. When other threads tries to act upon it, they may not have much
>> hints about it, if the corresponding VMA was not scanned.
>>
>> (e) VMAs that are created after two full scans of mm 
>> (mm->numa_scan_seq > 2)
>> will never get scanned. (Observed rarely but very much possible 
>> depending on
>> workload behaviour).
>>
>> Above this, a combination of some of the above (e.g., (a) and (b)) can
>> potentially amplifyi/worsen the side effect.
>>
>> This patchset, tries to address the above issues by enhancing 
>> unconditional
>> VMA scanning logic.
>>
>> High level ideas:
>> =================
>> Idea-1) Depending on vma_size, populate a per vma_scan_select value, 
>> decrement it
>> and when it hits zero do force scan (Mel).
>> vma_scan_select value is again repopulated when it hits zero.
>>
>> This is how VMA scanning phases looks like after implementation:
>>
>> |<---p1--->|<-----p2----->|<-----p2----->|...
>>
>> Algorithm:
>> p1: New VMA, initial phase do not scan till scan_delay.
>>
>> p2: Allow scanning if the task has accessed VMA or vma_scan_select hit 
>> zero.
>>
>> Reinitialize vma_scan_select and repeat p2.
>>
>> pros/cons:
>> +  : Ratelimiting is inbuilt to the approach
>> +  : vma_size is taken into account for scanning
>> +/-: Scanning continues forever
>> -  : Changes in vma size is taken care after force scan. i.e.,
>>     vma_scan_select is repopulated only after vma_scan_select hits zero.
>>
>> Idea-1 can potentially cover all the issues mentioned above.
>>
>> Idea-2) Take bitmask_weight of latest access_pids value (suggested by 
>> Bharata).
>> If number of tasks accessing vma is >= 1, unconditionally allow scanning.
>>
>> Idea-3 ) Take bitmask_weight of access_pid history of VMA. If number 
>> of tasks
>> accessing VMA is > THRESHOLD (=3), unconditionally allow scanning.
>>
>> Rationale (Idea-2,3): Do not miss out scanning of critical VMAs.
>>
>> Idea-4) Have a per vma_scan_seq. allow the unconditional scan till 
>> vma_scan_seq
>> reaches a value proportional (or equal) to vma_size/scan_size.
>> This a complimentary to Idea-1.
>>
>> this is how VMA scanning phases looks like after implementation:
>>
>> |<--p1--->|<-----p2----->|<-----p3----->|<-----p4----->...||<-----p2----->|<-----p3----->|<-----p4-----> 
>> ...||
>>                                                          
>> RESET                                               RESET
>> Algorithm:
>> p1: New VMA, initial phase do not scan till scan_delay.
>>
>> p2: Allow scanning if task has accessed VMA or vma_scan_seq has 
>> reached till
>>   f(vma_size)/scan_size) for e.g., f = 1/2 * vma_size/scan_size.
>>
>> p3: Allow scanning if task has accessed VMA or vma_scan_seq has 
>> reached till
>>   f(vma_size)/scan_size in a rate limited manner. This is an optional 
>> phase.
>>
>> p4: Allow scanning iff task has accessed VMA.
>>
>> Reset after p4 (optional).
>>
>> Repeat p2, p3 p4
>>
>> Motivation: Allow agressive scanning in the beginning followed by a rate
>> limited scanning. And then completely disallow scanning to avoid 
>> unnecessary
>> scanning. Reset time could be a function of scan_delay and chosen long 
>> enough
>> to aid long running task to forget history and start afresh.
>>
>> +  : Ratelimiting need to be taken care separately if needed.
>> +/-: Scanning continues only if RESET of vma_scan_seq is implemented.
>> +  : changes in vma size is taken care in every scan.
>>
>>   Current patch series implements Ideas 1, 2, 3 + extension of access 
>> PID history
>> idea from PeterZ.
>>
>> Results:
>> ======
>> Base: 6.5.0-rc6+ (4853c74bd7ab)
>> SUT: Milan w/ 2 numa nodes 256 cpus
>>
>> mmtest        numa01_THREAD_ALLOC manual run:
>>
>>         base        patched
>> real        1m22.758s    1m9.200s
>> user        249m49.540s    229m30.039s
>> sys        0m25.040s    3m10.451s
>>
>> numa_pte_updates     6985    1573363
>> numa_hint_faults     2705    1022623
>> numa_hint_faults_local     2279    389633
>> numa_pages_migrated     426    632990
>>
>> kernbench
>>             base            patched
>> Amean     user-256    21989.09 (   0.00%)    21677.36 *   1.42%*
>> Amean     syst-256    10171.34 (   0.00%)    10818.28 *  -6.36%*
>> Amean     elsp-256      166.81 (   0.00%)      168.40 *  -0.95%*
>>
>> Duration User       65973.18    65038.00
>> Duration System     30538.92    32478.59
>> Duration Elapsed      529.52      533.09
>>
>> Ops NUMA PTE updates                  976844.00      962680.00
>> Ops NUMA hint faults                  226763.00      245620.00
>> Ops NUMA pages migrated               220146.00      207025.00
>> Ops AutoNUMA cost                       1144.84        1238.77
>>
>> Improvements in other benchmarks I have tested.
>> Time based:
>> Hashjoin    4.21%
>> Btree         2.04%
>> XSbench        0.36%
>>
>> Throughput based:
>> Graph500     -3.62%
>> Nas.bt        3.69%
>> Nas.ft        21.91%
>>
>> Note: VMA scanning improvements [1] has refined scanning so much that
>> system overhead we re-introduce with additional scan look glaringly
>> high. But If we consider the difference between before [1] and current
>> series, overall scanning overhead is considerably reduced.
>>
>> 1. Link: 
>> https://lore.kernel.org/lkml/cover.1677672277.git.raghavendra.kt@amd.com/T/#t 
>>
>> 2. Link: 
>> https://lore.kernel.org/lkml/cover.1683033105.git.raghavendra.kt@amd.com/
>>
>> Note: Patch description is again repeated in some patches to avoid any
>> need to copy from cover letter again.
>>
>> Peter Zijlstra (1):
>>    sched/numa: Increase tasks' access history
>>
>> Raghavendra K T (5):
>>    sched/numa: Move up the access pid reset logic
>>    sched/numa: Add disjoint vma unconditional scan logic
>>    sched/numa: Remove unconditional scan logic using mm numa_scan_seq
>>    sched/numa: Allow recently accessed VMAs to be scanned
>>    sched/numa: Allow scanning of shared VMAs
>>
>>   include/linux/mm.h       |  12 +++--
>>   include/linux/mm_types.h |   5 +-
>>   kernel/sched/fair.c      | 109 ++++++++++++++++++++++++++++++++-------
>>   3 files changed, 102 insertions(+), 24 deletions(-)
>>
> 
> I have tested this series on 4th generation EPYC processor. I am seeing 
> improvement in autonuma-benchmark with the series.
> 
> o System Details
> 
> - 4th Generation EPYC System
> - 2 x 128C/256T
> - NPS1 mode
> 
> o Kernels
> 
> base:   4853c74bd7ab Merge tag 'parisc-for-6.5-rc7' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
> 
> 
> ==================================================================
> Test          : autonuma-benchmark
> Units         : Time in seconds
> Interpretation: Lower is better
> Statistic     : AMean
> ==================================================================
> commit:
>    base (4853c74bd7ab)
>    base + this_series
> 
>    base (4853c74bd7ab)         base + this_series
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>      522.58           -11.2%     464.23        
> autonuma-benchmark.numa01.seconds
>      273.93            -1.2%     270.75        
> autonuma-benchmark.numa01_THREAD_ALLOC.seconds
>        0.60            +0.0%       0.60        
> autonuma-benchmark.numa02.seconds
>      102.68            +3.7%     106.50        
> autonuma-benchmark.numa02_SMT.seconds
> 
> Tested-by: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
> 


Thank you Swapnil.

Regards
- Raghu
