Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D00E7B9DD9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 15:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjJEN4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244005AbjJENut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:50:49 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on20617.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::617])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094ED1BC5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 20:50:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsZVmX+CitgMChDlikZGnNb236ZecygXso5xZpsWqxFrlWVd0ic78HH+qb0URBDYNxF9jl5OiJyRPwhktejdP1mZqRkwBqXdM2z3J4A9gdFtyc+yzWltjcKm/uYzDhA88exuhuusrbch6MIfCCyNPFGdUzYlWnwzafmfH0IkP7ECE0HuEqY9CKxw5eSP2PUmUSLqpDYvxfFr4RbvEES6SO1n75lCQEjvvk17HSFi/jcYP/N2/Tep3ykB+nL8vQya6TKk6UciQCLtwrmvyTlhiE/5ZohO7x2GVUSKPrU/y8a0a//PuQ90F4e+tow112CNEDbthoat3uj89OXy83AxPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDnaFtgm5xuDbTkXekkG1Ux+/ScW1QHccRWoImz/DHE=;
 b=fdkcuYwWDFnsD3SU2qQKCmWrI2N0C7w9GfRT2kCpjeRVyY1JwS/jcJkWcp0uWMA3I+3KbP22kCOwU50rKwkYGTDMv3eR+J3EvhHdA2zUjF2Jzq7mmDaR5zr09acuymO74lra0JfRJXky90MzyIro6PmvDDDlsACUCvYofZBKRn6acQ92niSSWZjd6GcYPcK6maZxLNS/wE016k5UM3YZ0vG537D5fHxWAm6MraWdQzkWjU9ZGC4oB7sMEvp9eqUFTjAYOhgcVHJhTGiyZi02m1/Z0hX9TDkfyrgAoXpDxiULYBX1pniwcyvbAqjjvozwDcnw4pmTepGNBEs5+/vfUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDnaFtgm5xuDbTkXekkG1Ux+/ScW1QHccRWoImz/DHE=;
 b=S3cVcOcBzIMbLIdGe5LGlof6BCWVQk81s0gQdt9vV2t5OLQmQcZ9LnAUUnO6sSy3qdcNoF0Ga6Bc9rb7ob8FSq83Bs++QeMJxtKlvmaLZ3vyBNgbaFgH+/OzubMj3yEUCkph/Z9XNz4Y6IvmSayIdaS0MUcIvmRA7cbadii+4fU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by SA3PR12MB7829.namprd12.prod.outlook.com (2603:10b6:806:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Thu, 5 Oct
 2023 03:50:20 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::2cf7:49ea:e95c:31b8]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::2cf7:49ea:e95c:31b8%6]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 03:50:20 +0000
Message-ID: <6fef325c-4415-c3c8-8254-531b2883b8e3@amd.com>
Date:   Thu, 5 Oct 2023 09:20:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH 3/3] sched/fair: Add a per-shard overload flag
Content-Language: en-US
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        aaron.lu@intel.com, wuyun.abel@bytedance.com, kernel-team@meta.com
References: <31aeb639-1d66-2d12-1673-c19fed0ab33a@amd.com>
 <20230831104508.7619-1-kprateek.nayak@amd.com>
 <20230831104508.7619-4-kprateek.nayak@amd.com>
 <20230831191103.GC531917@maniforge>
 <350639fb-a428-7d94-b13b-7a33e68b7b09@amd.com>
 <20230929170104.GA78641@maniforge>
 <925f13cd-b020-a799-3505-b3df46a51ffe@amd.com>
 <20231004172036.GC30978@maniforge>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20231004172036.GC30978@maniforge>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0128.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::13) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|SA3PR12MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f402d1f-52f8-4fae-ed3e-08dbc55631c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qNP9DQJL23m3ybH7MtFYk4TnBqDeN6GMbo517Gw/2Msxip2pHg3gggjy0QYxHd/8WBW+Pi+zitZXs4TZ9sm+HzmDhYx09JyjbGBu9unFbY+ONHr5YJp21l8RSQ1BOPm2Ucv+TcVFpfX+EOFaGIjifDtyRE83U1TbDMVVCClIu0yYaoEDTw5e8x1lrKA9RTKRTX9QaZGaEJ0Pkvpbb8kQFkWD9QZ7d5p2NtzAVvVs0SgfcFfWpstIr4PACoEbyUWbISqESMzBJmP18/VM04RIF8OY7y5Zfs5uzMwQBJjYJEhPWupZk1Z0BermYjL4yKA7lTartMsuEIHO4TyDyF6EwMLtHdMGSNBSY5D3hGEgyJeugUoPbgsMX0GI040cSUupiQrGw/KZp9ThU7DDhmP95UuZ0w68WR2ng+K7brZJBT+UT+cY/ouB6/hB4PuEEa51kxVDJlHpnleEk+tF+bbNk66I8RY1RlFd5FV0TTEQryLO2305Ko6wWgzshgNXft9tYW6EnXp8E11zGWkHu8VMfVj2UTu/YvggC7bOJEFqlIoQtsDUMwQ2LSOmyWVzxGuKpgbpJiON4vlwVOiDNttAQy96l/+ZPvyBBa84Uaw5UujyAJPxSJoRGdZ55arPs6zaJnSeM2QdJXzGZ4D+w/nW6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(31686004)(66899024)(2616005)(6512007)(53546011)(6506007)(6486002)(31696002)(86362001)(38100700002)(36756003)(30864003)(7416002)(2906002)(8676002)(6666004)(478600001)(83380400001)(8936002)(4326008)(316002)(26005)(41300700001)(66946007)(5660300002)(6916009)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnpPcG84Z1RtNjJXUUFiUGdvSzZKSHJ5WWZaRkh1dXhLQWlneFg2a0tMcGFE?=
 =?utf-8?B?NGZWYWtKNUZVUThzcHhsWUZIcm9qb0ZhMFNnK1lSSzNJNzQrT29zSFo5VXRl?=
 =?utf-8?B?UklBdmlzRVZSZi9qVDM2MFN5SlUwYmZXc3VsVkZuSlRWY2ZPMlJRZ2ZtSlhx?=
 =?utf-8?B?SWpaMXUvWHRZb1lIZUZQMGNpbmJ1MU04SkZNUU5FRzRkL00wV2o4TkdtdzIx?=
 =?utf-8?B?R0RJcC9zUFVWTXAzMHVRdmJjalQ1TzNlWmtNWWtHWjdWaGx2QW1mRWxiazVn?=
 =?utf-8?B?WEZ1TEg2Wk9PeXg4S1Jsa3VxYWR2SzVKbWJLTDduMlF3NzczeUVwbTMzaUox?=
 =?utf-8?B?N1N2RGs2VUVuMXIwZ0dPc1g1NWd3aWNzM0d0b05SSWNoaFYvYldjcUZoa2NM?=
 =?utf-8?B?SWZKY2NpZCs2TDNVckR3eWU2L3dJaGd2U2Z3TXJmR1NrTHFEN2hJTitJUXR6?=
 =?utf-8?B?cmM5UFd6K0ZvNXZRdVBOemNzYU5WRGhBbHQxcTdKcjhqTWtkTUV5WlRtR2NC?=
 =?utf-8?B?emlKejZDVUxBNGpTYmpuRStORFRRaGFuand3TXlpZ2oyQ3BRMUhSTmlZREY3?=
 =?utf-8?B?N243Tk9lK0dicWwwTmVvRXFoZFRuczdvaUtKbCtkRjhZMUI0ek13dHVRcjY4?=
 =?utf-8?B?UENoMFRZSkpyWmNEc2dhYUhsNDk0SVE4T3Y1MGl5OWI1Q1JxM0hZNlJaS3Vs?=
 =?utf-8?B?VHNBcGpKeHE3c2QwOTZMM0hQRUtlS2hzQW1YT0dWdXR3UHR1VFpOV3dwVE4y?=
 =?utf-8?B?N0dNTlk5UWQyUFB4c0xLN0xuYkRaRHpsck5UZXhnWHVuWVpQdDM2MUZQbFdp?=
 =?utf-8?B?cTUwejZmczhZYW05enI1RTFvVTAzdks2bmhvRlFkK3diV0NIelB2OHZzVkdC?=
 =?utf-8?B?bmhJb2M4RXdhUTRYMWI2UzdUR0dCZHdvZXk0L05kWk93WFFuR3MxWFJCbVN4?=
 =?utf-8?B?QStDV2hQcWQvMWRoU0luQTBZZ1RkOFVUODVnSkczem9raTk0cG4rcXJuQWtW?=
 =?utf-8?B?TGdYV2xWdlNEVEx6UHdVcisxNXhrU1VmZkRscmlXd3JDclBDR2MzT25TdWg0?=
 =?utf-8?B?YTBKQ3ZwR3JaSzdXM25VNGdnZTJJV3lQWnMrbUtmUFZqRjhtMTd3dFgwQ1Rl?=
 =?utf-8?B?c25tcXlUenNVYStzOXRDUm95QllzVnFiSzRIdVRiOGVsU1AzaEhzMWdXL3Rl?=
 =?utf-8?B?SEhHbGV4TWJJRElGbTg2VGg2WEpJZkYvc0dNTXNuUU5wT1hpajhjdEdYT1hT?=
 =?utf-8?B?NjZCWWs4TTM5QkkzOGwwMFJ3NmNVUmkzcHorbXA2VlJHYThFV2p2WE4yek9X?=
 =?utf-8?B?OWRtdmgrYjNxOXJxd3l6NzlFc0xoM0w1c0VLUVRUL0M4Y3FtTjVxVFliRFdz?=
 =?utf-8?B?TUx2SnY1dXpCMk5LT0p0RzU1SXpkNGd3ZVJHTWllTGNuMnBLNkJEaUhTUE5P?=
 =?utf-8?B?L2FmZy9PUGdwQSswQ09DOWlxakxuc0I3SzIybGZxVXk1TUErUmEzMzdsWUoz?=
 =?utf-8?B?YXpEQnhwZGtPbHpWRlBoNHc1dURib3VpNm9sU1pZQkJHOHdrRWJIekZMaGlo?=
 =?utf-8?B?S3h6NmFrbVF3ZXJqL250N01MQjZiTEpnSnM3dWlobDhGc3lUQUY2M2FqbWRB?=
 =?utf-8?B?KzhLQ3NSKzJ3VDlIdk5PK2tOcmhFMVdiMWpQRnlkZ0ErUzcvR0dYY3liSm84?=
 =?utf-8?B?SnVUL0RCa2hSOS9pTU5GSE5ZbEZFVGg5ZE5aenFNYm1JdTd6ODZHdGtjZzM0?=
 =?utf-8?B?cTRYTVcwWGpRZWNGbnoyTk5BeHBjcHFpODh3Z0NnVEYxeEF1RSswNlhrNDhq?=
 =?utf-8?B?RTRpZ1NMbjREUmxJOVBoZlBMVjhwamJFS3V4U0x1Z0cxb3puR0tkcWRWc0lr?=
 =?utf-8?B?THhGMXJQdUpRV0lsOFZoVGo1Z0Znb2Y2cEdWakg2b1JuQjhONDZwNXFKUGN0?=
 =?utf-8?B?SVEvamdDSmZmVzVoMlVzYndFZWpsa1ZGU3c3Y2FNalYxSWtFZkdUOXE0ZDZ3?=
 =?utf-8?B?Y0hCODZHQkUrdVI4VTliQ1hEeEx5VkJjem9rcHN6dkVIbWt3bVdvbUVRMEs0?=
 =?utf-8?B?S0VEWUZNZTFTNkwvNXk5NkNMVHBVc2Q2UFVrOGM3RXJiOUhGUHNjL0VaYUdq?=
 =?utf-8?Q?L8TKjDpBBpyUSNkrBFJ4nGoqK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f402d1f-52f8-4fae-ed3e-08dbc55631c7
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 03:50:20.1844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ob8vODz7Lp1fGbSgTu31k+rlo5j4nO/aab4Y3p2nmIcGoo8XgXibGv6K5kLcIltXj4PxQKY2kRCfjm1xR4fjtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7829
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On 10/4/2023 10:50 PM, David Vernet wrote:
> On Wed, Oct 04, 2023 at 09:51:18AM +0530, K Prateek Nayak wrote:
>> Hello David,
> 
> Hello Prateek,
> 
>>
>> Thank you for answering my queries, I'll leave some data below to
>> answer yours.
>>
>> On 9/29/2023 10:31 PM, David Vernet wrote:
>>> On Fri, Sep 01, 2023 at 01:53:12AM +0530, K Prateek Nayak wrote:
>>>> Hello David,
>>>>
>>>> On 9/1/2023 12:41 AM, David Vernet wrote:
>>>>> On Thu, Aug 31, 2023 at 04:15:08PM +0530, K Prateek Nayak wrote:
>>>>>
>>>>> Hi Prateek,
>>>>>
>>>>>> Even with the two patches, I still observe the following lock
>>>>>> contention when profiling the tbench 128-clients run with IBS:
>>>>>>
>>>>>>   -   12.61%  swapper          [kernel.vmlinux]         [k] native_queued_spin_lock_slowpath
>>>>>>      - 10.94% native_queued_spin_lock_slowpath
>>>>>>         - 10.73% _raw_spin_lock
>>>>>>            - 9.57% __schedule
>>>>>>                 schedule_idle
>>>>>>                 do_idle
>>>>>>               + cpu_startup_entry
>>>>>>            - 0.82% task_rq_lock
>>>>>>                 newidle_balance
>>>>>>                 pick_next_task_fair
>>>>>>                 __schedule
>>>>>>                 schedule_idle
>>>>>>                 do_idle
>>>>>>               + cpu_startup_entry
>>>>>>
>>>>>> Since David mentioned rq->avg_idle check is probably not the right step
>>>>>> towards the solution, this experiment introduces a per-shard
>>>>>> "overload" flag. Similar to "rq->rd->overload", per-shard overload flag
>>>>>> notifies of the possibility of one or more rq covered in the shard's
>>>>>> domain having a queued task. shard's overload flag is set at the same
>>>>>> time as "rq->rd->overload", and is cleared when shard's list is found
>>>>>> to be empty.
>>>>>
>>>>> I think this is an interesting idea, but I feel that it's still working
>>>>> against the core proposition of SHARED_RUNQ, which is to enable work
>>>>> conservation.
>>>>
>>>> I don't think so! Work conservation is possible if there is an
>>>> imbalance. Consider the case where we 15 tasks in the shared_runq but we
>>>> have 16 CPUs, 15 of which are running these 15 tasks, and one going
>>>
>>> I'm not sure I'm fully following. Those 15 tasks would not be enqueued
>>> in the shared runq if they were being run. They would be dequeued from
>>> the shared_runq in __dequeue_entity(), which would be called from
>>> set_next_entity() before they were run. In this case, the
>>> shard->overload check should be equivalent to the
>>> !list_empty(&shard->list) check.
>>>
>>> Oh, or is the idea that we're not bothering to pull them from the
>>> shared_runq if they're being woken up and enqueued on an idle core that
>>> will immediately run them on the next resched path? If so, I wonder if
>>> we would instead just want to not enqueue the task in the shared_runq at
>>> all? Consider that if another task comes in on an rq with
>>> rq->nr_running >= 2, that we still wouldn't want to pull the tasks that
>>> were being woken up on idle cores (nor take the overhead of inserting
>>> and then immediately removing them from the shared_runq).
> 
> Friendly ping on this point. This is the only scenario where I could see
> the overload check helping, so I want to make sure I'm understanding it
> and am correct in that just avoiding enqueueing the task in the shard in
> this scenario would give us the same benefit.

Woops! Missed answering this. So the original motivation for
'shard->overload' was that there is a rq lock contention, very likely as
a result of shared_runq_pick_next_task() trying to grab a remote rq's
lock. Looking at shared_runq_pick_next_task(), the criteria
"!task_on_cpu(src_rq, p)" led me to believe we might end up enqueuing a
task that is running on the CPU but now that I take a look at
shared_runq_enqueue_task() being called from __enqueue_entity(), this
should be a very rare scenario. 

However, if a running task was enqueued often into a shared_runq, the
'shard->overload' is an indication that all the runqueues covered by
the shard are not overloaded and hence, peeking into the shard can be
skipped. Let me see if I can grab some more stats to verify what
exactly is happening.

> 
>> So this is the breakdown of outcomes after peeking into the shared_runq
>> during newidle_balance:
>>
>>                                                 SHARED_RUNQ                     SHARED_RUNQ
>>                                         + correct cost accounting       + correct cost accounting
>>                                                                         + rq->avg_idle early bail
>>
>> tbench throughput (normalized)		:	     1.00			2.47	       (146.84%)
>>
>> attempts                                :       6,560,413                  2,273,334           (-65.35%)
>> shared_runq was empty                   :       2,276,307 [34.70%]         1,379,071 [60.66%]  (-39.42%)
>> successful at pulling task              :       2,557,158 [38/98%]           342,839 [15.08%]  (-86.59%)
>> unsuccessful despite fetching task      :       1,726,948 [26.32%]           551,424 [24.26%]  (-68.06%)
>>
>> As you can see, there are more attempts and a greater chance of success
>> in the case without the rq->avg_idle check upfront. Where the problem
>> lies (at least what I believe is) a task is waiting to be enqueued / has
>> been enqueued while we are trying to migrate a task fetched from the
>> shared_runq. Thus, instead of just being idle for a short duration and
>> running the task, we are now making it wait till we fetch another task
>> onto the CPU.
>>
>> I think the scenario changes as follows with shared_runq:
>>
>> - Current
>>
>>
>>       [Short Idling]	[2 tasks]                        [1 task]	[2 tasks]
>> 	+-------+	+-------+                       +-------+	+-------+
>> 	|	|	|	|        wakeup         |	|	|	|
>> 	| CPU 0 |	| CPU 1 |	 on CPU0        | CPU 0 |	| CPU 1 |
>> 	|	|	|	|       -------->       |	|	|	|
>> 	+-------+	+-------+                       +-------+	+-------+
>>
>> - With shared_runq
>>
>>       [pull from CPU1]	[2 tasks]                       [2 tasks]	[1 task]
>> 	+-------+	+-------+                       +-------+	+-------+
>> 	|	|	|	|        wakeup         |	|	|	|
>> 	| CPU 0 |	| CPU 1 |	 on CPU0        | CPU 0 |	| CPU 1 |
>> 	|	|	|	|       -------->       |	|	|	|
>> 	+-------+	+-------+                       +-------+	+-------+
>>
>> We reach a similar final state but with shared_runq we've paid a price
>> for task migration. Worst case, the following timeline can happen:
>>
>>         |
>>   CPU0  | [T0 R, T1 Q] [       T0 R      ] [newidle_balance] [T4 R ...
>>         |
>>         |                  pull T1 \             pull T4 /
>>         |
>>   CPU1  | [T3 R] [newidle_balance] [T1 R, T4 Q] [       T1 R      ]
>>         |            [T4 TTWU]
>>         |
>>
>> With the rq->avg_idle bailout, it might end up looking like:
>>
>>         |
>>   CPU0  | [          T0 R, T1 Q          ] [T1 R ...
>>         |
>>         |
>>   CPU1  | [T3 R] [ I ] [T4 R ...
>>         |            
>>         |
> 
> This certainly seems possible, and wouldn't be terribly surprising or
> unexpected. Taking a step back here, I want to be clear that I do
> understand the motivation for including the rq->avg_idle check for
> SHARED_RUNQ; even just conceptually, and regardless of the numbers you
> and others have observed for workloads that do these short sleeps. The
> whole idea behind that check is that we want to avoid doing
> newidle_balance() if the overhead of doing newidle_balance() would
> exceed the amount of time that a task was blocked. Makes sense. Why
> would you take the overhead of balancing if you have reason to believe
> that a task is likely to be idle for less time than it takes to do a
> migration?
> 
> There's certainly a reasonable argument for why that should also apply
> to SHARED_RUNQ. If the overhead of doing a SHARED_RUNQ migration is
> greater than the amount of time that an sd is expected to be idle, then
> it's not worth bothering with SHARED_RUNQ either. On the other hand, the
> claim of SHARED_RUNQ is that it's faster than doing a regular balance
> pass, because we're doing an O(# shards) iteration to find tasks (before
> sharding it was O(1)), rather than O(# CPUs). So if we also do the
> rq->avg_idle check, that basically means that SHARED_RUNQ becomes a
> cache for a full load_balance() call.
> 
> Maybe that makes sense and is ultimately the correct design /
> implementation for the feature. I'm not fundamentally opposed to that,
> but I think we should be cognizant of the tradeoff we're making. If we
> don't include this rq->avg_idle check, then some workloads will regress
> because we're doing excessive migrations, but if we do check it, then
> others will also regress because we're doing insufficient migrations due
> to incorrectly assuming that an rq won't be idle for long. On yet
> another hand, maybe it's fine to allow users to work around that by
> setting sysctl_sched_migration_cost_ns = 0? That only sort of works,
> because we ignore that and set rq->max_idle_balance_cost = curr_cost in
> newidle_balance() if we end up doing a balance pass. I also know that
> Peter and others discourage the use of these debugfs knobs, so I'm not
> sure it's even applicable to point that out as a workaround.
> 
> And so hopefully the problem starts to become clear. It doesn't take
> long for for us to get mired in heuristics that make it difficult to
> reason about the expected behavior of the feature, and also difficult to
> reason about future changes as these heuristics have now all crossed
> streams. Maybe that's OK, and is preferable to the alternative. My
> personal opinion, however, is that it's preferable to provide users with
> knobs that do straightforward things that are independent from existing
> heuristics and knobs which were added for other circumstances. I'd
> rather have confidence that I understand how a feature is supposed to
> work, and can easily reason about when it's stupid (or not) to use it,
> vs. have an expectation for it to not regress workloads in any scenario.
> 
> Note that this doesn't mean we can't make my patches less dumb. I think
> your suggestions to e.g. check the overload flag (or possibly even
> better to just not enqueue in a shard if the rq isn't overloaded),
> re-check ttwu->pending after failing to find a task in the shard, etc
> make complete sense. There's no downside -- we're just avoiding
> pointless work. It's the heuristics like checking rq->avg_idle that
> really worry me.

I agree since avg_idle is merely a prediction that may or may not be
true.

> 
> Peter -- I think it would be helpful if you could weigh in here just to
> provide your thoughts on this more "philosophical" question.
> 
>> If possible, can you check how long is the avg_idle running your
>> workload? Meanwhile, I believe there are a few workloads that
>> exhibit same behavior as tbench (large scale idling for short
>> duration) Let me go check if I can see tbench like issue there.
> 
> Sure thing, in the meantime I'll test this out on HHVM. I've actually
> been working on getting a build + testbed ready for a few days, so
> hopefully it won't take much longer to get some results. Even if it
> turns out that this works great for HHVM, I'd ideally like to get
> Peter's and others' thoughts on the above.

I'll gather some more data too in the meantime :)

> 
> Thanks,
> David
 
--
Thanks and Regards,
Prateek
