Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175C57A59F2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjISGa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjISGa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:30:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB7C100
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 23:30:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/Ezf6u31Dmeb60KLw7pRt6zSkU9sZf0ZvD/wYHbVNa4KSaxShjuLuX2KedwzucgKd3YBt2c9lJVchquRxdJ/fwNZCYLnFVNSdnyGFJ2XONkM68VdNgHbeIlYACJqXVJ0zhn7KEph2K2pEYGqGMlHwmrgTHHpnDMG3tbi70//yjeB+QXqDCi2oVdwlii1D/PTuIjVSqEPBtAmDhzCwRyY75n0qFwRMHaepiNyIj+2Wu7O4hRueGS2QUOmB+aickWAyci/udcOIAeWrl5NHowfo0wI8Auevg3c9Ptd8Ga3JyniSBM/QRijLXeQmGiaCMWOjJrgE/frr7DbNQl92Vlyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecAXhuo5D/rognVU6wKgDONkc+U/OgyCvLD0pAd0uNM=;
 b=PmiMrtton14yEewXUmNNIBX8m4sqACfoldazrtJILvKJD/fHMGWvkG11jbT3TDUN9a+QXrIkAl58Y8YqMCintA0ndIFA/Bh69mNEFpFOuB1xT0qEziT79QLLdXmbBtbulKcmG/9+VO6/qZJ50IOynfKXHmYCnTtzSdnBsOpUcxGkXe+rk10O6f8/JbNMIk+akiFfRjEs85qMtVyYgpv9RdF+zD2b9JItVC0a9CY7foThgWSfo8nInnRj78l/Em8PUjR4wz/OXce3y1Sk0RDEcv6a7C5ddi2Ub6oPxEMSIQMcMML6IKFR3mAaI21rA5h80rTUBJSWLKtdqQYbMll4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecAXhuo5D/rognVU6wKgDONkc+U/OgyCvLD0pAd0uNM=;
 b=ZbQ1Lv8TRIRClBDGe9vS7/VhCxAyROX8VkvMoqXYLCtVvuTMC9UvroYuJ5m3qUN8n0BYYR5byYKjKkuo3u9uSZlKf7Fyr/Hv4KZP2+Y/MOARPU1WbAPl4pwdOjug0DFL4AWc0IK/F2iv3uJpNsl7nP+bwteeCHeUMPc8PtrFrI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by DS0PR12MB6488.namprd12.prod.outlook.com (2603:10b6:8:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Tue, 19 Sep
 2023 06:30:14 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::74d4:ad6f:f00:8187]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::74d4:ad6f:f00:8187%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 06:30:14 +0000
Message-ID: <719f0729-d28f-d12f-cff4-ab8115861d30@amd.com>
Date:   Tue, 19 Sep 2023 12:00:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH V1 0/6] sched/numa: Enhance disjoint VMA scanning
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
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
        Sapkal Swapnil <Swapnil.Sapkal@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
References: <cover.1693287931.git.raghavendra.kt@amd.com>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <cover.1693287931.git.raghavendra.kt@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::27) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|DS0PR12MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: d7907e18-5f6c-4b70-c6b7-08dbb8d9e1a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJbUh/Nm0ZUkE3JQHUwt4rxJVr17CG/tVf7hmEhCDBM2jpY6V7m0PsWuhAIDa5xs6zH4pGXgCq4iZ/Lj/IkMKY8Yy2Efy4PYBsu8PFRoNJZs85ouafspcr8iT2E+vPpbwiIFMNQrsZqKR5pr8hWr5yK2fkzkdskkRhQSMOQc/Rp6CUqzO/zUVXKL7yLilx7Jmb9RJjoRz42K5KgyznwvUUJ831sdyaenQqWjVLiVtST8rOzbZkQ3OHv8UHeIFAc11SO/0wqy8bQ/kkc4e8A64B/Y7YK7fxwYE0XLg57SOgvoCNo/gpzP2WcKdQyresuUHL1f4KxfGWXHVwQ//RgHub6N4tLm0RaJa37cw4YpGhkclsy7VARTz6PodwXuH4r+ugj6OKC4bOichf6nJs2tP79d1j9t3g4eMYLWpZHDLU3tWwzvHWSIQq25hGk7HZoB98C39MG9mbG7R6vynBP+hm3XOnyghhn2jsoLfw3eOyaYrgMMRuGylKz4ElsDvKBhUal7cDEciUkK6ADwMtt3uabJsYfV9UESpV8JRJvoiovxZVH86miD9N3orAssurLQbEhOFQeIamJahKM/tWDUtpQ9EeaqUXb+yeTNRl6cwAdPckn3lB24tMLLvfTfP3z2/qBD8PcngDrn1xDcGdQJ6vlJk0v0E9k05/dclhtWCS6FYT0ZVY8JPyeKk9NnYIEL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199024)(186009)(1800799009)(53546011)(41300700001)(31686004)(8936002)(4326008)(8676002)(7416002)(5660300002)(66946007)(54906003)(66476007)(66556008)(316002)(2906002)(83380400001)(38100700002)(2616005)(26005)(966005)(478600001)(36756003)(6512007)(6506007)(6486002)(6666004)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnhaT2l4YVlyT281cHVaUEdHdHFoUFBtSnpQQzEySE0wb0I3anNpTGN6LzRB?=
 =?utf-8?B?TjRIbHFlNkN2c1RXUmtaRVVyc05QSjZISE5peXNvK2VmUktkN0V6cmxieDJo?=
 =?utf-8?B?UTYybTYweHZnODR2SWVRUWJxMTZXTFh2NG53Z1RrSnBaMElhejlYdzZHT05U?=
 =?utf-8?B?bGt2MW83RytkQnExMk5jQnNZTll5VUd6Ymh3RUhLN1dRclFtVlBHMk94Z253?=
 =?utf-8?B?alJ0ZFJIZVNzRWlKelVyTHAydVpFbkgwNXEwMHVwWjJnQk9tMVpSa2UzYllj?=
 =?utf-8?B?NnBNY0psUDR3Z1o3WWY1V1VCbEpCS2RGT01LVk1oUlZUYmU3VlBrbmRHRklY?=
 =?utf-8?B?a2lHQUdhbDhoSnd2VGlhQkJUUDlRY1Rsc0ZLeEdUMlBFNEo0MFhNK0I3ZDQx?=
 =?utf-8?B?NXVaYWEvTytGR2lOT1NaN3dvSmRRZ0RBVDQ4M3NwK3JncU55K0tFVlhTa0Fz?=
 =?utf-8?B?dHF1MDFsbXBXblJuMERPNzZsdWZvaDZITWpCYmlrMUMwVWdieG9nSzJHcjlV?=
 =?utf-8?B?bFhjV0F6YjVzWjJ3Wm9OSHRDcmk1ZmQwU2szeTBLTytYZUhudUJsYVRzWklZ?=
 =?utf-8?B?aDE5VU5pTExxSHMzbmtwRmo5UUdreCtyZkVGQnFmSkdmV2dTa2Fad1JIeFI5?=
 =?utf-8?B?U2tnMkFTVG5oVEdxdzIzbFh1cWNUS3ZYQ3NmblJ5ajBYQUpMcVJ4c0RMaS9G?=
 =?utf-8?B?ZUh0K1hSRFpJZ0hPVHR2WTNNcFFpNXRQT2E0UlV1UGdSblovU2RValNtc25u?=
 =?utf-8?B?eXV2Q2daNzZaQlhCT0pYb0hHbTh0TituWG9VRUIwZnRPeHZUQ00yQVg2T3Nr?=
 =?utf-8?B?eXh4aU90a3BLaTN0elYxRkwrZG5pRjFldzhGNHJ5bDEveFNpNGlhZUhWUER3?=
 =?utf-8?B?RVNjRXhHUzRxRGI4WmpqU096dEU0NStrV1RZRStaYzF0Vlh5TWdmOFNpYXNE?=
 =?utf-8?B?eW9oVmJ3V2lKVzFiRFlmL2xSci81WS9wQWM5UFA5c0hhdks1MFBXZWpodFd0?=
 =?utf-8?B?N0dZdEZBTytwUU9vTFdJUmlDTHZBSjRTUVNxNFhSWUpYenNHRGxzZ0hCZ3Qv?=
 =?utf-8?B?a1VhRDc1Yk5pUVNjamxCMkRxR3c2Ui81TlByYXpnNnRxb3QrK0ZBUWxVeUdj?=
 =?utf-8?B?aStjUEc2bGVFaGJlemc1bG9UTy92OUUrR3Vtd0RSRkZ6MWUwWGM4SzZxZHp2?=
 =?utf-8?B?Z0N0UjNPbldPUDFiOUdURVUxMFpwa05oNWpySlZMSnRXTFFyM0hyUElBNHdm?=
 =?utf-8?B?ZVFvOU5KWFdqYkZESHdlNVh5M2t5MWhMU0o4Z0pyNGI5YXJ1c0xTWWJ2VzNo?=
 =?utf-8?B?bVBjWjdhUGoyL1lTanRSamJJOEF1ZmVIak9qMzl0eUQyeG10eTgvSlliaHVS?=
 =?utf-8?B?cUltNC9TeGhlQmRRcDUrdW0xdjlGTm0vTlU2TVhIbWgzNHNCQW5TcFE1RWxs?=
 =?utf-8?B?emtLVUIyR0JuWm1MME9ZTDJGbzVRVlEyV3BQYmNzK2NsV0Zna2hhcTU1UEpG?=
 =?utf-8?B?dnNqakFSeUE4bGpJc0E4N012NHVxck43MEEyZ1lSZSsvZXRDQm9raTZYdjNP?=
 =?utf-8?B?Nk9rYlRTemtyT3lYTWtzeGVMTEpoSTA5RlBmUHlFYVhpYWFNK0RqRUNteTB2?=
 =?utf-8?B?TmpQcGFkc29rRk0wRUNLVmNZTndsdk8yOVpJODZtWEYzTjYrQnppZ2xFYSsr?=
 =?utf-8?B?ODB5Y2pERWdXdEZnQ2tHZjFGZnJGOGxXVHMyYmxqOW5mU1ZubUUvS2p4TG1m?=
 =?utf-8?B?M3lnL3BrOXA5OXBJS0g2QlpTQWhlVmdlRkV5dXNnaGgrV0RJODFpaWVDS1Y1?=
 =?utf-8?B?b1JmTlRHZVpLR2Y2a3VCZU1LS1BtNzdYem1RWEhoT0VBakVRSEJSS0RaY2Ix?=
 =?utf-8?B?eHJsSk03YzQ0UmZLSCtJdXN1d1FaQStjcDdDaW5RTWRCL2lWU21NaVFra0R4?=
 =?utf-8?B?djlwVTZORUc3b0dHajNyR0YzMzZTd1h4K3V6VUVvaFU5QmkrdGVRVFEzK3dq?=
 =?utf-8?B?TXNqaVVrQjNleDh3SGZpYWpTYmd2YWo1STI3TnNXZlFXV1ZPZ25qdW1TSkNG?=
 =?utf-8?B?UmNwRzJkaUdHYlNvMi9iMEsyditOZFZCZE9meVB0RlhWY0lVdFBMYUEvMkM5?=
 =?utf-8?Q?TGgIs+qBroNrIutk8/0Fk4Kfr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7907e18-5f6c-4b70-c6b7-08dbb8d9e1a3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 06:30:14.0353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elBpBLaXi5O6mpxAFqF6qMgVuQcCNz2Q/zAC7Nurmc0LxGFysWXmjO5iQyumZxvGZHXqU4uPyXfvoOxle+D9IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6488
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/2023 11:36 AM, Raghavendra K T wrote:
> Since commit fc137c0ddab2 ("sched/numa: enhance vma scanning logic") [1]
> VMA scanning is allowed if:
> 1) The task had accessed the VMA.
>   Rationale: Reduce overhead for the tasks that had not
> touched VMA. Also filter out unnecessary scanning.
> 
> 2) Early phase of the VMA scan where mm->numa_scan_seq is less than 2.
>   Rationale: Understanding initial characteristics of VMAs and also
>   prevent VMA scanning unfairness.
> 
> While that works for most of the times to reduce scanning overhead,
>   there are some corner cases associated with it.
> 
> This was found in an internal LKP run and also reported by [2]. There was
> an attempt to fix.
> 
> Link: https://lore.kernel.org/linux-mm/cover.1685506205.git.raghavendra.kt@amd.com/T/
> 
> This is a fully different series after Mel's feedback to address the issue
>   and also a continuation of enhancing VMA scanning for NUMA balancing.
> 
> Problem statement (Disjoint VMA set):
> ======================================
> Let's look at some of the corner cases with a below example of tasks and their
> access pattern.
> 
> Consider N tasks (threads) of a process.
> Set1 tasks accessing vma_x (group of VMAs)
> Set2 tasks accessing vma_y (group of VMAs)
> 
>               Set1                      Set2
>          -------------------         --------------------
>          | task_1..task_n/2 |       | task_n/2+1..task_n |
>          -------------------         --------------------	
>                   |                             |
>                   V                             V
>          -------------------         --------------------
>          |     vma_x       |         |     vma_y         |
>          -------------------         --------------------	
> 
> Corner cases:
> (a) Out of N tasks, not all of them gets fair opportunity to scan. (PeterZ).
> suppose Set1 tasks gets more opportunity to scan (May be because of the
> activity pattern of tasks or other reasons in current design) in the above
> example, then vma_x gets scanned more number of times than vma_y.
> 
> some experiment is also done here which illustrates this unfairness:
> Link: https://lore.kernel.org/lkml/c730dee0-a711-8a8e-3eb1-1bfdd21e6add@amd.com/
> 
> (b) Sizes of vmas can differ.
> Suppose size of vma_y is far greater than the size of vma_x, then a bigger
> portion of vma_y can potentially be left unscanned since scanning is bounded
> by scan_size of 256MB (default) for each iteration.
> 
> (c) Highly active threads trap a few VMAs frequently, and some of the VMAs not
> accessed for long time can potentially get starved of scanning indefinitely
> (Mel). There is a possibility of lack of enough hints/details about VMAs if it
> is needed later for migration.
> 
> (d) Allocation of memory in some specific manner (Mel).
> One example could be, Suppose a main thread allocates memory and it is not
> active. When other threads tries to act upon it, they may not have much
> hints about it, if the corresponding VMA was not scanned.
> 
> (e) VMAs that are created after two full scans of mm (mm->numa_scan_seq > 2)
> will never get scanned. (Observed rarely but very much possible depending on
> workload behaviour).
> 
> Above this, a combination of some of the above (e.g., (a) and (b)) can
> potentially amplifyi/worsen the side effect.
> 
> This patchset, tries to address the above issues by enhancing unconditional
> VMA scanning logic.
> 
> High level ideas:
> =================
> Idea-1) Depending on vma_size, populate a per vma_scan_select value, decrement it
> and when it hits zero do force scan (Mel).
> vma_scan_select value is again repopulated when it hits zero.
> 
> This is how VMA scanning phases looks like after implementation:
> 
> |<---p1--->|<-----p2----->|<-----p2----->|...
> 
> Algorithm:
> p1: New VMA, initial phase do not scan till scan_delay.
> 
> p2: Allow scanning if the task has accessed VMA or vma_scan_select hit zero.
> 
> Reinitialize vma_scan_select and repeat p2.
> 
> pros/cons:
> +  : Ratelimiting is inbuilt to the approach
> +  : vma_size is taken into account for scanning
> +/-: Scanning continues forever
> -  : Changes in vma size is taken care after force scan. i.e.,
>     vma_scan_select is repopulated only after vma_scan_select hits zero.
> 
> Idea-1 can potentially cover all the issues mentioned above.
> 
> Idea-2) Take bitmask_weight of latest access_pids value (suggested by Bharata).
> If number of tasks accessing vma is >= 1, unconditionally allow scanning.
> 
> Idea-3 ) Take bitmask_weight of access_pid history of VMA. If number of tasks
> accessing VMA is > THRESHOLD (=3), unconditionally allow scanning.
> 
> Rationale (Idea-2,3): Do not miss out scanning of critical VMAs.
> 
> Idea-4) Have a per vma_scan_seq. allow the unconditional scan till vma_scan_seq
> reaches a value proportional (or equal) to vma_size/scan_size.
> This a complimentary to Idea-1.
> 
> this is how VMA scanning phases looks like after implementation:
> 
> |<--p1--->|<-----p2----->|<-----p3----->|<-----p4----->...||<-----p2----->|<-----p3----->|<-----p4-----> ...||
>                                                          RESET                                               RESET
> Algorithm:
> p1: New VMA, initial phase do not scan till scan_delay.
> 
> p2: Allow scanning if task has accessed VMA or vma_scan_seq has reached till
>   f(vma_size)/scan_size) for e.g., f = 1/2 * vma_size/scan_size.
> 
> p3: Allow scanning if task has accessed VMA or vma_scan_seq has reached till
>   f(vma_size)/scan_size in a rate limited manner. This is an optional phase.
> 
> p4: Allow scanning iff task has accessed VMA.
> 
> Reset after p4 (optional).
> 
> Repeat p2, p3 p4
> 
> Motivation: Allow agressive scanning in the beginning followed by a rate
> limited scanning. And then completely disallow scanning to avoid unnecessary
> scanning. Reset time could be a function of scan_delay and chosen long enough
> to aid long running task to forget history and start afresh.
> 
> +  : Ratelimiting need to be taken care separately if needed.
> +/-: Scanning continues only if RESET of vma_scan_seq is implemented.
> +  : changes in vma size is taken care in every scan.
> 
>   Current patch series implements Ideas 1, 2, 3 + extension of access PID history
> idea from PeterZ.
> 
> Results:
> ======
> Base: 6.5.0-rc6+ (4853c74bd7ab)
> SUT: Milan w/ 2 numa nodes 256 cpus
> 
> mmtest		numa01_THREAD_ALLOC manual run:
> 
> 		base		patched
> real		1m22.758s	1m9.200s
> user		249m49.540s	229m30.039s
> sys		0m25.040s	3m10.451s
> 	
> numa_pte_updates 	6985	1573363
> numa_hint_faults 	2705	1022623
> numa_hint_faults_local 	2279	389633
> numa_pages_migrated 	426	632990
> 
> kernbench
> 			base			patched
> Amean     user-256    21989.09 (   0.00%)    21677.36 *   1.42%*
> Amean     syst-256    10171.34 (   0.00%)    10818.28 *  -6.36%*
> Amean     elsp-256      166.81 (   0.00%)      168.40 *  -0.95%*
> 
> Duration User       65973.18    65038.00
> Duration System     30538.92    32478.59
> Duration Elapsed      529.52      533.09
> 
> Ops NUMA PTE updates                  976844.00      962680.00
> Ops NUMA hint faults                  226763.00      245620.00
> Ops NUMA pages migrated               220146.00      207025.00
> Ops AutoNUMA cost                       1144.84        1238.77
> 
> Improvements in other benchmarks I have tested.
> Time based:
> Hashjoin	4.21%
> Btree	 	2.04%
> XSbench		0.36%
> 
> Throughput based:
> Graph500 	-3.62%
> Nas.bt		3.69%
> Nas.ft		21.91%
> 
> Note: VMA scanning improvements [1] has refined scanning so much that
> system overhead we re-introduce with additional scan look glaringly
> high. But If we consider the difference between before [1] and current
> series, overall scanning overhead is considerably reduced.
> 
> 1. Link: https://lore.kernel.org/lkml/cover.1677672277.git.raghavendra.kt@amd.com/T/#t
> 2. Link: https://lore.kernel.org/lkml/cover.1683033105.git.raghavendra.kt@amd.com/
> 
> Note: Patch description is again repeated in some patches to avoid any
> need to copy from cover letter again.
> 
> Peter Zijlstra (1):
>    sched/numa: Increase tasks' access history
> 
> Raghavendra K T (5):
>    sched/numa: Move up the access pid reset logic
>    sched/numa: Add disjoint vma unconditional scan logic
>    sched/numa: Remove unconditional scan logic using mm numa_scan_seq
>    sched/numa: Allow recently accessed VMAs to be scanned
>    sched/numa: Allow scanning of shared VMAs
> 
>   include/linux/mm.h       |  12 +++--
>   include/linux/mm_types.h |   5 +-
>   kernel/sched/fair.c      | 109 ++++++++++++++++++++++++++++++++-------
>   3 files changed, 102 insertions(+), 24 deletions(-)
> 

Hello Andrew,

I am Resending patch rebasing to mm-unstable, adding results from Oliver
and Swapnil.

(so that it is ready to merge once we get go ahead/ no objection from
Mel, Peter ... Okay to work any further suggestions if any).

Hope that is Okay.

Thanks and Regards
- Raghu
