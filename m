Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A6079F977
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 06:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbjINEOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 00:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjINEOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 00:14:11 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF80FA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 21:14:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfAYnDlU6xz1+JUI/x0lReOBaJBczcwcTJxAQmSPmg+GdTVQWKMhJYWLStO09LmBGxeygdsN7V9JtSqkTymgFLW4QVYkHbYO75anz+nulWbi0zMIaHm49J5lqQ1ac8eJMEu2i+Q/YFa2eXBzzsDZ6wujOWVjTbJQkWOu9jFt8rrpzmNoecrWdpxsjYtILtQZ1k0SPqUCXajnIO0664eDbcgoi7E8MJneFW51SwkxQaYCBL11JSvj3nXc8n1n+KJ56hEk74f4mYqJQrMXRZjV6Z3JtHjSJMyBqoprKfkZVaoZ9U8AC7+Ahs73DI02YlX18SsDSij+12HKtl/JarHn5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16VqBKhadZ9GwbQBij2s/seC/bse7y4+a14O3366p4c=;
 b=E46qT9O1B2PvYthueNtNt90C/OwdTOw6BC4HqAQOd/FIYQNUzEREbBw6Hs0lIfEmsiOGyPBtJoBx/v/o8wlA+/sVVJVeiXaA4mFu+pG37TM0puyJ9stcOAYNbsldO15M3T1X1UYVNAdrtYS74v7GkKS4QeVMKT1v+xtVX8Pi956xoQM/SiGaHU76K6s6SOJtAzFd0UJrvZ57kHKQ/tJeiMZNVgSz1bWtqcpP/MmJ/a8cPYLtECQyFj7PCGjWy5XrS9VK/ae6jwellSpm6ffvNwyNtNss/4ZcYQiHuPNtVzxcv74LYZR9gzXruqqRTjeQ+lvCw66Ar+o6bvHCFJaLgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16VqBKhadZ9GwbQBij2s/seC/bse7y4+a14O3366p4c=;
 b=yvDpfeUwi4UPvR8nNSBSEniQDIKr0hY40spGjMb24noQegWYAtXql1P5vT4yUG2hebgVvMEQPOdYBcDV83TsVMB9wGLuIjZc9vtsDDiz09mXToLcGGzDnKFDI7fFdJ6hYcgLv/kD2S1laaRPDQiq0sIH/7jnIZyhbMejQctkVKU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by CY8PR12MB8315.namprd12.prod.outlook.com (2603:10b6:930:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 04:14:04 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6768.036; Thu, 14 Sep 2023
 04:14:04 +0000
Message-ID: <86f761a4-9805-c704-9c23-ec96065fa389@amd.com>
Date:   Thu, 14 Sep 2023 09:43:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH 2/2] sched/fair: skip the cache hot CPU in
 select_idle_cpu()
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
 <31c910c2-717d-b86c-4e08-5c94383682e8@amd.com>
 <ZP7ptt70uF10wxlg@chenyu5-mobl2>
 <5b35ae2b-a401-2489-4b3a-a03e8284d138@amd.com>
 <ZQBaWRCmMOvIGmem@chenyu5-mobl2.ccr.corp.intel.com>
 <229069c1-3d61-53bb-fff7-691942c48d21@amd.com>
 <ZQElEM5GAn/Vq0tM@chenyu5-mobl2.ccr.corp.intel.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZQElEM5GAn/Vq0tM@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::17) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|CY8PR12MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: 75171c80-53e1-49cd-b807-08dbb4d907d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vbOTjqBJIwloTSvN4DixM6i8zoNzAA+iAUry8QFN0T9Zi9Bfo2e4rOx8Chci6G+ssngWWOTiTAAA1TTTwPCKIIGgGgSAd0dyeRhNktQN/ODtgo3FMs4YE3XwGrgnbhHI3ykNwYIt9BNSFSjdafr1D4g6f7hHsB2NlMNWrQ7NpLkZVuIQAYP08eU7m+jcmi9ZZXbrQioZ/jJVA7Au94jmXS1SVEjAN3G8ljNG2WBWS484AbiY8ZguuQPvM89GjNdvsiZyk4VFtv00pa7jKBleQk3Geh3rMZNEbMwRISOTYQ4JFTeKlUgOhGeFSNmybXCAB3KI1ACtPyW1csuQ9fwQZtm/8Mq8DF9tPeW7HoDF8fQ+aYbqPfGt5ULTFCLGMG6ljMWSqagMb0UgP4Pr9uItvUd4xFMgrcv9ZrLfd3TdCklJuqW7gBfJAXn7cpYaFQTvn9ItfTM4N+9vLU28pvedMXeuuqXDopVog3f/O3qXl9ilVFihUSATZxYfBSV4GXYxVYl+xVqqCkRZji/+QaVsQagJflCNhxSjb2N2CEeSnMbbbq0bLCkNXIX/f0fYZVregBgCVi8/nGgSrVyWrQVlChvUyOYchnNWwUBpIqLjn5ZAb89OXnm+dvLV3zuq6X0KD5J+PbjIEirtQtPtTe02Sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(186009)(1800799009)(451199024)(6506007)(66946007)(66476007)(54906003)(6486002)(66556008)(316002)(31686004)(6916009)(53546011)(6512007)(6666004)(41300700001)(478600001)(8936002)(2616005)(8676002)(4326008)(86362001)(26005)(5660300002)(38100700002)(36756003)(2906002)(83380400001)(7416002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1dLd1p1MFgrbzB4NjdFeUlDa25SOWpWRUI1ckhWSTNmTTdyMVhYUzFSUmNK?=
 =?utf-8?B?bDU0Vlo3SmM0TnZ6a1lEVE05RWx5TWpVRjhSUFRaRy9XamxSakJBZWN3Zzds?=
 =?utf-8?B?NEtDY0IrQ2gxamRxQTJkVDF6Yi9qK2szMDY1dFJkVWw2MGMycW0veVNWam8x?=
 =?utf-8?B?TWdPeWpMRTd1NnE4SXJ4R3k4S2JwN2FVL3YyUHBjNjBtaHY2elFXWGJZemhN?=
 =?utf-8?B?UmVLeGVMOXZueEx1dDYwc3lJVXZQdHVyc2VXMEo3cEUyN2FsMUtHVzZqMkpw?=
 =?utf-8?B?NXVxcVJxbUNwUjQ2Z3BGTDBxMERsYUxRaXRlMmo4dnllL0Qzbkc0QWx6U2gr?=
 =?utf-8?B?YjJDSm56SktyQkNJK0ZTTDYzNjNEVVFOZlFNU3pFZnZCRE9qTy83R3hWWjZn?=
 =?utf-8?B?QW91dHpGeDBHNmhHZmNLZEFOc1RnS1RKZERDckgvb0szdFl4SGlvSlYwTTI1?=
 =?utf-8?B?TUlMN0hucEhIczVxZFJZdjVMeTRKaUxjenlRMHMzUlp6T1orQkJVMWxyeVJD?=
 =?utf-8?B?cFFCYWhSbFV6VXR1M05UMU1YTDduMkhIdjJuRFpHZmEyS3dzbDg0a2czb0N4?=
 =?utf-8?B?bkdpVDVQdUlLbG9VelhuSCtUcURiMEUxRkJid01uM1dHbTBtUE9ZWUM5SW9s?=
 =?utf-8?B?V2k4MFFrcHVUaTNvNDUzem1CVm53dmpTSzFIQmRqZXVNcGczYkZ6UVdmcjRQ?=
 =?utf-8?B?SnhIUHoyYnhBVnpmT01ZK3laaWk3V3ZudGRuc3pyU1hKTEcyVWlXV3BIMzJQ?=
 =?utf-8?B?dFd5WnZTemJwUElINm41S1pkRVdJU2pPWmNOZDBCSWdCODJnU1hsZGZJQ1VF?=
 =?utf-8?B?TndZSUgrcEYrYVBvK0YvVFJKd3hUZ0ZwY2FOQytxK3lmWnhzUHc3Tk1CQnd1?=
 =?utf-8?B?UFpyZ3o3ekNkWVp0TkpzRStaV2lNZGNaTXdQcy93bHFYaUg3RmxEZzZFQzhL?=
 =?utf-8?B?NHVBeThDQlRkUzZnS1dmRUpPVEttcFFBR0VBd0ZjOW04dGxNT0VnVmlDcDZH?=
 =?utf-8?B?b1dzUTl2Vk9QZm54Q29BZHRaNnBrYXVOQzJHVkw1VmFYRUk4bXJLRytSMzEx?=
 =?utf-8?B?bDVBMlZvZi9zSGFtMFE3N0hReEt1SWdqNmZtOFU0eFRZY2tINkZSNWx3YVNq?=
 =?utf-8?B?WURyK2hMb251OHIyNzY2biszVTkxeUY3RVgyMUFFamNhUzdhNGF1M1p4VHcw?=
 =?utf-8?B?UHZ4REJFT2xmSVEyZk1wNHpaWkZCNkZVT21NbGZCZWU3UmJqdHc5N09VZkd3?=
 =?utf-8?B?eE82VzcvV3EzWEd0TWFzdzJHdlhPN3h3VkR5SlpCajhhakxiTHRIbEMwVnZz?=
 =?utf-8?B?NE1FclJJUC9RbVIvKys4RUEyeVJ0TCtnNVkySThFVng0WWFQWDhjQ1ZNNEQ4?=
 =?utf-8?B?L3FaeEdyMVNCdjFlckdEZzFHOCtiMllNaWtTOWh1dm84TkZFTkZuWG4xSUlZ?=
 =?utf-8?B?L1U0bWNobG1IZWNuVlo3K2RnZ0lXeWpWNjhLR21YcVR2TXJocnRwajJVVlRi?=
 =?utf-8?B?N0RKTW5iVmRXY2tzZ0pWbHoxVXpLNU81Uy9LaWFSQTNGelBRYmk0TWtaelFG?=
 =?utf-8?B?NkNkSGJnY2ZZbDY2TCs1VmN5ZTQrVFNYd0k5LzMxZGlqTU9scTNCa2ZxY2Zs?=
 =?utf-8?B?azRVQU4rQ3Z5Z3RsUmhGbHkxN2RrTklMWnBvS29wWnU2T3A0T1ViZ3pyWFRj?=
 =?utf-8?B?Zms3SlBvUktHVmFlRS92UUJOK3MzOWJYUzU5T29CYnVVcnpOUHBCUmNJZlVG?=
 =?utf-8?B?YnBkZi9tY3FGZTJGemJiUkt5Ukw0ZWo3MjdsUmVqeVY2ZVdDUS9ldFlOV282?=
 =?utf-8?B?UWhFZDU5b1BRNm1Rc3RLNEo3Zlk0eXFtdnRLM2JnS3lZd243ZzY2ZUJUa3k3?=
 =?utf-8?B?SE9NN2Q0Y3ZNcFNidEtaNEhuanF5dVpBZnJ5RXpUWldQdW0wcDB0ci9KejdD?=
 =?utf-8?B?QzZTZElWRjBMWEIrNDAwb2pBYzdMWXR3ZGxwVEVUWEs4MTJNYUIrMVgydEFk?=
 =?utf-8?B?TkU0TDg1KzVaSWs0b0RhVkZHNlpVWnF6TEdWK0xPeTlGaklxblROMEtLSVQ4?=
 =?utf-8?B?RUlEU0RlUG8vNXpEa3psSENOaXhTeXRzQk8zSFVlaG1EdGExbTlMTDlTWTVV?=
 =?utf-8?Q?1c+keaPEhT87Xb87GJ+vMC5eG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75171c80-53e1-49cd-b807-08dbb4d907d5
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 04:14:03.9344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5uB6ViC2vUqHvAFLeJInyvevw4ERioap3RkDxjUCtSiv0XrXjxT1LMlnOJpD+jvFRw7AZExSWROvGxK2ByCRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8315
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

On 9/13/2023 8:27 AM, Chen Yu wrote:
> On 2023-09-12 at 19:56:37 +0530, K Prateek Nayak wrote:
>> Hello Chenyu,
>>
>> On 9/12/2023 6:02 PM, Chen Yu wrote:
>>> [..snip..]
>>>
>>>>> If I understand correctly, WF_SYNC is to let the wakee to woken up
>>>>> on the waker's CPU, rather than the wakee's previous CPU, because
>>>>> the waker goes to sleep after wakeup. SIS_CACHE mainly cares about
>>>>> wakee's previous CPU. We can only restrict that other wakee does not
>>>>> occupy the previous CPU, but do not enhance the possibility that
>>>>> wake_affine_idle() chooses the previous CPU.
>>>>
>>>> Correct me if I'm wrong here,
>>>>
>>>> Say a short sleeper, is always woken up using WF_SYNC flag. When the
>>>> task is dequeued, we mark the previous  CPU where it ran as "cache-hot"
>>>> and restrict any wakeup happening until the "cache_hot_timeout" is
>>>> crossed. Let us assume a perfect world where the task wakes up before
>>>> the "cache_hot_timeout" expires. Logically this CPU was reserved all
>>>> this while for the short sleeper but since the wakeup bears WF_SYNC
>>>> flag, the whole reservation is ignored and waker's LLC is explored.
>>>>
>>>
>>> Ah, I see your point. Do you mean, because the waker has a WF_SYNC, wake_affine_idle()
>>> forces the short sleeping wakee to be woken up on waker's CPU rather the
>>> wakee's previous CPU, but wakee's previous has been marked as cache hot
>>> for nothing?
>>
>> Precisely :)
>>
>>>
>>>> Should the timeout be cleared if the wakeup decides to not target the
>>>> previous CPU? (The default "sysctl_sched_migration_cost" is probably
>>>> small enough to curb any side effect that could possibly show here but
>>>> if a genuine use-case warrants setting "sysctl_sched_migration_cost" to
>>>> a larger value, the wakeup path might be affected where lot of idle
>>>> targets are overlooked since the CPUs are marked cache-hot forr longer
>>>> duration)
>>>>
>>>> Let me know what you think.
>>>>
>>>
>>> This makes sense. In theory the above logic can be added in
>>> select_idle_sibling(), if target CPU is chosen rather than
>>> the previous CPU, the previous CPU's cache hot flag should be
>>> cleared.
>>>
>>> But this might bring overhead. Because we need to grab the rq
>>> lock and write to other CPU's rq, which could be costly. It
>>> seems to be a trade-off of current implementation.
>>
>> I agree, it will not be pretty. Maybe the other way is to have a
>> history of the type of wakeup the task experiences (similar to
>> wakee_flips but for sync and non-syn wakeups) and only reserve
>> the CPU if the task wakes up more via non-sync wakeups? Thinking
>> out loud here.
>>
> 
> This looks good to consider the task's attribute, or maybe something
> like this:
> 
> new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
> if (new_cpu != prev_cpu)
> 	p->burst_sleep_avg >>= 1;
> So the duration of reservation could be shrinked.

That seems like a good approach.

Meanwhile, here is result for the current series without any
modifications:

tl;dr

- There seems to be a noticeable increase in hackbench runtime with a
  single group but big gains beyond that. The regression could possibly
  be because of added searching but let me do some digging to confirm
  that. 

- Small regressions (~2%) noticed in ycsb-mongodb (medium utilization)
  and DeathStarBench (High Utilization)

- Other benchmarks are more of less perf neutral with the changes.

More information below:

o System information

  - Dual socket 3rd Generation EPYC System (2 x 64C/128T)
  - NPS1 mode (each socket is a NUMA node)
  - Boost Enabled
  - C2 disabled (MWAIT based C1 is still enabled)


o Kernel information

base		:   tip:sched/core at commit b41bbb33cf75 ("Merge branch
		    'sched/eevdf' into sched/core")
		  + cheery-pick commit 63304558ba5d ("sched/eevdf: Curb
		    wakeup-preemption")

SIS_CACHE	:   base
		  + this series as is


o Benchmark results

==================================================================
Test          : hackbench
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:          base[pct imp](CV)     SIS_CACHE[pct imp](CV)
 1-groups     1.00 [ -0.00]( 1.89)     1.10 [-10.28]( 2.03)
 2-groups     1.00 [ -0.00]( 2.04)     0.98 [  1.57]( 2.04)
 4-groups     1.00 [ -0.00]( 2.38)     0.95 [  4.70]( 0.88)
 8-groups     1.00 [ -0.00]( 1.52)     0.93 [  7.18]( 0.76)
16-groups     1.00 [ -0.00]( 3.44)     0.90 [  9.76]( 1.04)


==================================================================
Test          : tbench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:          base[pct imp](CV)     SIS_CACHE[pct imp](CV)
    1     1.00 [  0.00]( 0.18)     0.98 [ -1.61]( 0.27)
    2     1.00 [  0.00]( 0.63)     0.98 [ -1.58]( 0.09)
    4     1.00 [  0.00]( 0.86)     0.99 [ -0.52]( 0.42)
    8     1.00 [  0.00]( 0.22)     0.98 [ -1.77]( 0.65)
   16     1.00 [  0.00]( 1.99)     1.00 [ -0.10]( 1.55)
   32     1.00 [  0.00]( 4.29)     0.98 [ -1.73]( 1.55)
   64     1.00 [  0.00]( 1.71)     0.97 [ -2.77]( 3.74)
  128     1.00 [  0.00]( 0.65)     1.00 [ -0.14]( 0.88)
  256     1.00 [  0.00]( 0.19)     0.97 [ -2.65]( 0.49)
  512     1.00 [  0.00]( 0.20)     0.99 [ -1.10]( 0.33)
 1024     1.00 [  0.00]( 0.29)     0.99 [ -0.70]( 0.16)


==================================================================
Test          : stream-10
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:          base[pct imp](CV)     SIS_CACHE[pct imp](CV)
 Copy     1.00 [  0.00]( 4.32)     0.90 [ -9.82](10.72)
Scale     1.00 [  0.00]( 5.21)     1.01 [  0.59]( 1.83)
  Add     1.00 [  0.00]( 6.25)     0.99 [ -0.91]( 4.49)
Triad     1.00 [  0.00](10.74)     1.02 [  2.28]( 6.07)


==================================================================
Test          : stream-100
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:          base[pct imp](CV)     SIS_CACHE[pct imp](CV)
 Copy     1.00 [  0.00]( 0.70)     0.98 [ -1.79]( 2.26)
Scale     1.00 [  0.00]( 6.55)     1.03 [  2.80]( 0.74)
  Add     1.00 [  0.00]( 6.53)     1.02 [  2.05]( 1.82)
Triad     1.00 [  0.00]( 6.66)     1.04 [  3.54]( 1.04)


==================================================================
Test          : netperf
Units         : Normalized Througput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:          base[pct imp](CV)     SIS_CACHE[pct imp](CV)
 1-clients     1.00 [  0.00]( 0.46)     0.99 [ -0.55]( 0.49)
 2-clients     1.00 [  0.00]( 0.38)     0.99 [ -1.23]( 1.19)
 4-clients     1.00 [  0.00]( 0.72)     0.98 [ -1.91]( 1.21)
 8-clients     1.00 [  0.00]( 0.98)     0.98 [ -1.61]( 1.08)
16-clients     1.00 [  0.00]( 0.70)     0.98 [ -1.80]( 1.04)
32-clients     1.00 [  0.00]( 0.74)     0.98 [ -1.55]( 1.20)
64-clients     1.00 [  0.00]( 2.24)     1.00 [ -0.04]( 2.77)
128-clients    1.00 [  0.00]( 1.72)     1.03 [  3.22]( 1.99)
256-clients    1.00 [  0.00]( 4.44)     0.99 [ -1.33]( 4.71)
512-clients    1.00 [  0.00](52.42)     0.98 [ -1.61](52.72)


==================================================================
Test          : schbench (old)
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers:          base[pct imp](CV)     SIS_CACHE[pct imp](CV)
  1     1.00 [ -0.00]( 2.28)     0.96 [  4.00](15.68)
  2     1.00 [ -0.00]( 6.42)     1.00 [ -0.00](10.96)
  4     1.00 [ -0.00]( 3.77)     0.97 [  3.33]( 7.61)
  8     1.00 [ -0.00](13.83)     1.08 [ -7.89]( 2.86)
 16     1.00 [ -0.00]( 4.37)     1.00 [ -0.00]( 2.13)
 32     1.00 [ -0.00]( 8.69)     0.95 [  4.94]( 2.73)
 64     1.00 [ -0.00]( 2.30)     1.05 [ -5.13]( 1.26)
128     1.00 [ -0.00](12.12)     1.03 [ -3.41]( 5.08)
256     1.00 [ -0.00](26.04)     0.91 [  8.88]( 2.59)
512     1.00 [ -0.00]( 5.62)     0.97 [  3.32]( 0.37)


==================================================================
Test          : Unixbench
Units         : Various, Throughput
Interpretation: Higher is better
Statistic     : AMean, Hmean (Specified)
==================================================================
Metric		variant                      base		     SIS_CACHE
Hmean     unixbench-dhry2reg-1            41248390.97 (   0.00%)    41485503.82 (   0.57%)
Hmean     unixbench-dhry2reg-512        6239969914.15 (   0.00%)  6233919689.40 (  -0.10%)
Amean     unixbench-syscall-1              2968518.27 (   0.00%)     2841236.43 *   4.29%*
Amean     unixbench-syscall-512            7790656.20 (   0.00%)     7631558.00 *   2.04%*
Hmean     unixbench-pipe-1                 2535689.01 (   0.00%)     2598208.16 *   2.47%*
Hmean     unixbench-pipe-512             361385055.25 (   0.00%)   368566373.76 *   1.99%*
Hmean     unixbench-spawn-1                   4506.26 (   0.00%)        4551.67 (   1.01%)
Hmean     unixbench-spawn-512                69380.09 (   0.00%)       69264.30 (  -0.17%)
Hmean     unixbench-execl-1                   3824.57 (   0.00%)        3822.67 (  -0.05%)
Hmean     unixbench-execl-512                12288.64 (   0.00%)       11728.12 (  -4.56%)


==================================================================
Test          : ycsb-mongodb
Units         : Throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
base            : 309589.33 (var: 1.41%) 
SIS_CACHE       : 304931.33 (var: 1.29%) [diff: -1.50%]


==================================================================
Test          : DeathStarBench
Units         : Normalized Throughput, relative to base
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Pinning         base     SIS_CACHE
1 CCD           100%      99.18% [%diff: -0.82%]
2 CCD           100%      97.46% [%diff: -2.54%]
4 CCD           100%      97.22% [%diff: -2.78%]
8 CCD           100%      99.01% [%diff: -0.99%]

--

Regression observed could either be because of the larger search time to
find a non cache-hot idle CPU, or perhaps just the larger search time in
general adding to utilization and curbing the SIS_UTIL limits further.
I'll go gather some stats to back my suspicion (particularly for
hackbench).

> 
> [..snip..]
 
--
Thanks and Regards,
Prateek
