Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442EA79DF63
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 07:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbjIMF2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 01:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIMF2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 01:28:47 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D45C172A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 22:28:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AH1ShOKNWsXt4WSKZbccxGOMOnLiBU4aekiBMexDJlFm+8tvVLbVXPIVkb1+fCtpFEA3n5guKDH1aq4nlf/EiqGKPQbBZJC9JxmdU0bMAiTDKeX9Cet6iaGw6gduO2Ep+3vhNqHSt+8qMiNTpdqFxfjIilMEp+ZwpAsDHAFBzYkLD5yUDMDaU4xBOA6Ixx1hV+0mH/lTRBSvJc6CJDg4ATOHKqf2l6GFycKghjkJt+3CG8SE0Ny5Uo8Vjui0KBTaRDw2j5TU+SnUSwd9UUeLFEo7JdqNU6Pk0443WH2Q8E8bB5mNhU3kNL1tt853qaCnMtHMmeG+1EANMvji9KWJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2au59qRqjaMSUUkSSLw943aW3hNabK+k4Sajg2bgzc=;
 b=gkOPl70DrCU3+Zz6KBdjnRixu1zYwXN2es9M/xsVt9/KO8rAgzK1d/63OV0vJVnRbXMea/KdyGVUq6WvFQQG9OSlF8Fl4yr3jt+jxYQxGizz/C/fJstCEHqE5omISs1u7zd7Ta6FX/NPYN9WTdx/hjUqJSDJkGWEtmDOsjSG+ZQxCv/s++nS+QY6GmTSNhP/8EiXEyZvtKZp2vNbz7OVAcwM3605pobUbvCa2Gd0WesEdW+zagwP+Jj7GTx214gdQB42Nekg8AiHsV7Q8kW9yNwcj4XNlFLJCnaJQS+LiS12GzOAkgHFVPz2T44+HBvtnIivVNXwHuT5EomLgcCS7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2au59qRqjaMSUUkSSLw943aW3hNabK+k4Sajg2bgzc=;
 b=P/UActJxpQzmLS7gh1MkA/zhgisA91GutDuMrUyFeiIBv5O8xpZ8ZnCFG72ZOkCPyC9OdNUQKY5z44uECejp0MQVj1cZxeW6+/3oifsDpT8SsPijLX3ahtn4a/h3SQqUI9C7xSfw+wOiKCi9xu4QELPr+HKY6cCdGvHxgOb3BTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) by
 SA3PR12MB7784.namprd12.prod.outlook.com (2603:10b6:806:317::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Wed, 13 Sep
 2023 05:28:38 +0000
Received: from DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::208c:3910:f2d8:e43a]) by DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::208c:3910:f2d8:e43a%2]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 05:28:38 +0000
Message-ID: <54fa32a9-36a8-f296-9be8-d2b28770f82e@amd.com>
Date:   Wed, 13 Sep 2023 10:58:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH V1 0/6] sched/numa: Enhance disjoint VMA scanning
To:     Raghavendra K T <raghavendra.kt@amd.com>,
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
Content-Language: en-US
From:   Swapnil Sapkal <Swapnil.Sapkal@amd.com>
In-Reply-To: <cover.1693287931.git.raghavendra.kt@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::25) To DS7PR12MB6165.namprd12.prod.outlook.com
 (2603:10b6:8:9a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6165:EE_|SA3PR12MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7328f3-1ac4-45d8-b7a6-08dbb41a4852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +45aiZHUPDhXItNAwd8kcbMLL0YTXkXxq3k7TJJF7rM3MurLPRI49a7uJ0bugljaX7PnMnaOQR5S04odyd9dXrdEWz7zs/XEvLlyVPme9rXyIbmUtpLm8ghi05Tyr7sFlChV1NAjV1dpnnMQJ6B/pLeFbrhAG4sMToV9sGYUYcAyqoUyUWywN7wGaw6x8K6qy721c3y+If9dpzXLt0I4fbKE7n3zh5ifo5SvsT59tXb4ZZ/zoHR7DOy5/q6QuHUbV/vXpy2BncZxsjD8+62r7L/Q2b+Sx6rjngN8Po9lTch99D3F1KAY/IYRMWlrrOGMdRYw20/GlhoUrzW1UGYjOzrh5SIUabDMCFyFHsUXanFfGLEf39yY8PwmkooEicdj5j1uolm8iKJ3vYjOo3yt7+yH3PgiVxVRXzLmgSpN7kpT03KX3yovPKjs3iTbQrZA4NPe+MbUHNpHpqS4yBTxfXkO7DT/rOg6aMPo5X7+Ns/0v5anitQyzEiXSlGPYB7kxzLNp9FDCnQbtgAG7mJH4a3NfG1cV/1O1cNmtFmjoTR0tgcsmaqfPPrCklijWwZcuXS+TJjptD6JZpGE0VlqS7A7l96lha6MwKicaIoYzYA8F/lFrUaJfebJ7rCIuEc3c2FkEg0iY+wkTmHDomDjRzPXWZCKTLh1LU1adk7wlqQZXrYLEIsCrabZ78bhPK0t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6165.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(136003)(39860400002)(1800799009)(186009)(451199024)(31686004)(6486002)(6666004)(53546011)(6506007)(86362001)(36756003)(38100700002)(4326008)(31696002)(41300700001)(2616005)(83380400001)(966005)(478600001)(6512007)(66946007)(26005)(316002)(5660300002)(8936002)(8676002)(7416002)(2906002)(66556008)(66476007)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnlmeEQ5QWd1ZmhIUEtiUzhXQlNPTUJjRXpMQ3FqN2NkL2t3SnNHTk54bEtV?=
 =?utf-8?B?VE9TZDllb2NvZWxuVFd1QW1TcjFXc1R4WlpFc2xIZUxKb3pLcHJISnBMYTNs?=
 =?utf-8?B?NFNCdDR0eDA2RGI0TTFjM3VwVHRCYVFsRnNWa0tKVHFqMThPbGRmVXdPekNa?=
 =?utf-8?B?S0tlT1gyMk91SktDSEFpUmhRQkd2MitwbWk0MWQ2SnVGSHlPbFF1dHZ4UWdj?=
 =?utf-8?B?dDQ0aXViSE42ZVFhZHJ2WU5qZENIVHBOd2svZ1FObjZDYVQvMHg4ZS9UcTJz?=
 =?utf-8?B?RW1mY2I3cDFvVmhZY2l0K2gzc0c4SEsxRkJJTDNJMEMyZjlVcU9GNXN6czRS?=
 =?utf-8?B?eHN3bFlmN0kzek5zaHJDekt5V0xxdU5LRS9QUSt3a3IwVVh5UVFaeXIrampp?=
 =?utf-8?B?L1AvUTVKVWxlWDBQQTBOSmNFUjNSMGNQMTRXNlk3UGJBQitIS29DNm0vSU0y?=
 =?utf-8?B?aC9rVGFjeVBuYy8rWFd0cWE3UEpnc0ZxbVVZK3FsUWNjWTVRVTd3all0ZHpt?=
 =?utf-8?B?RE95elZqWSs5ckhMOXg4YWdvWGpyQmZCU1BibWtDTEFjd1M2ekx6OU1BTHA0?=
 =?utf-8?B?eC9rOENubWNnWTRHL0QxNm1tUjRGcThiSFArTHpXelNnUFZ3SnRqaG01TEl3?=
 =?utf-8?B?NTh5d0hXaFpYVHdlYVpmRndxTjR0WENaVEVFNGVvVFZHVmtQNjFmNVFaSlBx?=
 =?utf-8?B?aVpCUlAwUzFFcUZXSFBsVGFPYmcyTldGVWdrdFIwRzBjTVBnN3RTamlnN0g3?=
 =?utf-8?B?bk51V2pPaGxSbXphSEZvSUsyOERmZ3U1dSt3QTFDM3ZBTVZodnYweHZnTC9P?=
 =?utf-8?B?MmpHc3NUeEE4b3ZGbnlyOGQyQWQvalRKWFVHeEJqUlNaTUJwa0tGdjBzeEw2?=
 =?utf-8?B?VG8xaXA4Z01kTGkyRlFnWCtPbnlOL1V0WHJEa1dWMmNOL0ZXSkhqTERoN1lN?=
 =?utf-8?B?V21YUFBEK3N3WE5KVExhQXd0ei9QZlBPYi9VY1NJZCtZRnVsMmthUGt0UU1B?=
 =?utf-8?B?TWFJaFBGVEZBTFQ0QkprV0tTOEFFaGlPbEZTVUl4djdEQjB1dmx6OGlrWmND?=
 =?utf-8?B?a0RQMDB2ZS9VTGdDOFV2YWh5S1FWRTBUUWdtQTJ3dkRMRStxWnE1Skk0TEsw?=
 =?utf-8?B?S0xiNnB2K2RSTUJGWnF2cHBpaFRUU2VIbUtreERlR2RmYXhkUnpvUHNOWjNK?=
 =?utf-8?B?eUJUd25YSzhrM3NUdFUrSUFSNTRYVkhwK1JWbGtoaEN1Q3BtTFZxMUF5SnVM?=
 =?utf-8?B?S0RTRFMvWTlHRGsvRHd3Q3NTeDVieGIwckUzT29jVjhKQVJqUDV4RlM2V21j?=
 =?utf-8?B?TWdNYmdlV1p3TDFORWdBM0prY0FsbFord0VuQUczbXM2bWFlcllYQW5SaTky?=
 =?utf-8?B?RkFCNkFzOUFkZk1Ec1hkcjZXMFozWmVkZVkvb2RGOExhaDBBOWVEVVBoaXdv?=
 =?utf-8?B?NWtVeU5pTm1wOHVDdDRtWHFKRnBLVUxhVzNYQ0pkN1NybEtZcFBRZmJ3OFNX?=
 =?utf-8?B?N29nSFY2ZE02eStKZTMwVE41T21jSTZ0V2FoZm1uc2dNNTNwRlYvSzl0ZGNp?=
 =?utf-8?B?RHErbWhHYzhVcGVSYmRDT25xN2dFS0w0ZVJTOFNhQUUyUnNJY2tHUXdxUHo4?=
 =?utf-8?B?Mk5NOCtXbUozZ1AxaC9ycWJRMDNzZ0d2NVVDSjV1UXpMT1lNMW5JcFJtU2FF?=
 =?utf-8?B?V21pTFlJZnBOZEtJbmxVRHpGUUI4akt3Z3QvR0pXQ2ZJWGtTbVJZWXd2Zzl6?=
 =?utf-8?B?NkxLQXExejhRY3YzeFpremVDYktPV0pNNXQ0bWwxZzJHYWpLcjh1dTdMWWpl?=
 =?utf-8?B?a3hPZ1ZDbEhCMHlpeVpDV25IV2ZtbnRLZ1VPSHhaK1hVWjI2eWpFMEUwSXVL?=
 =?utf-8?B?bTZlWkh0SDRQcHlCQjFNdnYrMUd6MFNlSUZWSmY5MzVmSWdqYlBsUjV5WjFN?=
 =?utf-8?B?clRNTHpzRzdjRlgvV0tCZlRpQTJ1OU1IOVRoaVdFYndId1VuMFE5RGRBaC9W?=
 =?utf-8?B?cVFBWkNBUVRWN0FKTnpXNTRNOVIrQ2FYNmY1Wjd1U1lHaWpaUVcrNTVBS0w5?=
 =?utf-8?B?ZWFMUmE5N0RTUndzMFFNeHppWGNZWWtPOHlPU25EdkN4TmRLMmxKbEppbHdh?=
 =?utf-8?Q?4mmOYUn/GjDQ0a6ZLFV0id5I8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7328f3-1ac4-45d8-b7a6-08dbb41a4852
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 05:28:38.2669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvXBBF39CC7FM0S5am0SGz4qGVQ0WhJEq/T9yyr4vwjHbEAZO3NabXxubgKzRhVHtC7oeghe/U+qIckbwhnUJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7784
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Raghu,

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

I have tested this series on 4th generation EPYC processor. I am seeing improvement in autonuma-benchmark with the series.

o System Details

- 4th Generation EPYC System
- 2 x 128C/256T
- NPS1 mode

o Kernels

base:   4853c74bd7ab Merge tag 'parisc-for-6.5-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux


==================================================================
Test          : autonuma-benchmark
Units         : Time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
commit:
   base (4853c74bd7ab)
   base + this_series

   base (4853c74bd7ab)         base + this_series
---------------- ---------------------------
          %stddev     %change         %stddev
              \          |                \
     522.58           -11.2%     464.23        autonuma-benchmark.numa01.seconds
     273.93            -1.2%     270.75        autonuma-benchmark.numa01_THREAD_ALLOC.seconds
       0.60            +0.0%       0.60        autonuma-benchmark.numa02.seconds
     102.68            +3.7%     106.50        autonuma-benchmark.numa02_SMT.seconds

Tested-by: Swapnil Sapkal <Swapnil.Sapkal@amd.com>

--
Thanks and Regards,
Swapnil
