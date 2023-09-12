Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AF179C416
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbjILDZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237274AbjILDZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:25:03 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2E319053
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 20:05:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkxE9TrSH5NjWQwWP7VDCMaVqsa311ZjoB1I3QwBWlGK8RZ4ge4N5aIYlyxbBhcacpa07iQ1HC/vOkvM073+7GYkesBecDB6+7BOJyatdhU1PjMKf3VIw0ZR5h0gAsjYrhRJOib0xJbZMUth03G3oqiFD0oKz7eJEcdV0gkUn+8hRtG8so42LJefKFCmPxphxW3/wx/AMMN00+QTfc7zbtlurMxyx/L9l57keTiQ8UOdDqSujN4mRk5qkqayUagnUg6DSNgVKvSEDCbf42ephZGB0t7oXOY3FUKGPPHvbFB20SRipBx47Fyf07ei4hOElisIS6WAvUq2RKk0WGF8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+XweZ2w5+clAsnS+lbRRQQl8Hi3I4kSikecZQWfqb0=;
 b=dBShJgB7Q7sBjuQSPQznIQVI2GQO+lrGdsFeHTQ5Z4gBCb+bTO9Dt4Q7u4vG0luJdQ645gr7/+vFtwPLqAZYIQla1GS5vLaY0Yk0y54kLwCHACwUUNIAJ2PpquAYJjkdwzLNVFIEJF8rQIsLyMvFBawm3LzfRMy645zIJ7DjUarnWKww29oMJBcuOLu7viAneMKXIpR6pbpnc5jubwQN4jUP0t+PR8n1ktOivWiFwbez7DSMJSxJdRVG7gRxQdMSjYY1WwKThihyBT1TsKOFC1oMAKC15PL/9QI7C0bMHvgAaYa5Ln7qM5VAKXcgw7Xwo7JksH+aABQAS9LCEYWEYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+XweZ2w5+clAsnS+lbRRQQl8Hi3I4kSikecZQWfqb0=;
 b=e9VoEhHCxn/MoBIrk7JJ35Fy3BwlpiYWdIxDPN2GGSCaJtlU9NgKy426Jf7YWplOK7qssHcwh7POkakP5ZsRMrv5HT+SDFwVZ1FsrOXis09o7ee0FeKyRCPesmfGfB+yO/sj3pchSAs8iRw1EWDVSLqQVFkO004aQ0CIWJyT0zw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 03:05:26 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 03:05:26 +0000
Message-ID: <5b35ae2b-a401-2489-4b3a-a03e8284d138@amd.com>
Date:   Tue, 12 Sep 2023 08:35:12 +0530
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
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZP7ptt70uF10wxlg@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::10) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|PH0PR12MB5420:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5730f9-78fc-48a3-1c39-08dbb33d1ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ewGwdOsFYFBpdTF5EvvdmHcoLG6oBEQU24FmF/vl1ZYU7IpilTA0QczWcl4+eKBZyQxU/299ITC5tKdTPhjnIOTy4/6Ijl3f3gofqzZgj17JHWJk5EmrepSx0U8zquhaj1DE0cTPXc9yCr6QVwf0cnz/oqGY+44iPeFXUNa2WQzkYTkOjj8jO/bqeJb/dh6Qcf4E6H2pRML4vCvSfq+vqd3vEcbJCTvuADdylVUAHAKhsWHTDrmthSaehl09HMDXwOeQs1gaPFV8ErYat4n1Igjllfa8W22Wo6HRlJm8nb1P+kXWaZbJ4XLxk2M+HTlhcBOqI0UuV9ms3QeJF77gTNYtwr+qDXMmUJRtncZ406PsbkY7I+9rGSBdE6jlyCwrk2JnlASqOhRt8VSneS97eMpoV0pFtUkZHKf5d4AlT+76aYnm+4v3O2EiGD1IDlBxM035Hf3GNKP39AhOP/Rs8Ik1bk7xq1gVQpw3xUGnL31GsjXKFNLDKcvVUktB9+TxAO65zbbeG+qEVoW8JSEcdMox4jFUSFEA2/QEzWlyQZCMLtm7n2A/TGj29bHVp5kH7hAMuSHSbypMXjlKWaoOY7xNPHoM4ccFHysRWiJxABw5/k6CrR7xhVNQjAiUM8Gb3B17JXmHZxxPb0065yNuxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(186009)(451199024)(1800799009)(4326008)(8676002)(36756003)(8936002)(31686004)(26005)(6666004)(6506007)(53546011)(6486002)(31696002)(86362001)(5660300002)(38100700002)(2906002)(83380400001)(66476007)(2616005)(41300700001)(7416002)(6512007)(66556008)(54906003)(6916009)(316002)(478600001)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elY5cTdpTVZ5MVlPVEZ6aU12N1VRcjJaRUt6YjViN3BwVUhQd1R3WlR3N1hy?=
 =?utf-8?B?WHZYUS82WUtCZHdJN2IyWGxva21WSmVwWkM0bFo2QTNMT2dxZ2x2NG92ejNV?=
 =?utf-8?B?RHNuZE5nQlhQM2p0Vm84TldaekQ4b2xqNFhaYVh6dGN2Z2JNdENUK2s2M09o?=
 =?utf-8?B?WXJhYW9JZDdkanRQWjR5cVY0K0pvb1ViWE5mWUVtSVpOdk1LNHVkZG5QaHBM?=
 =?utf-8?B?T2lNK2g4YjFYMC9OcHFwTTVFL0ZhdE8xMEpoRTdmZ0VvN2JIaStNUzRwNm1S?=
 =?utf-8?B?RzFqUEhFWStxVVpqTFpCSW0rK2lEa1lvNVo5OVFXbmQ3UnhkRjVBZUk5UTRU?=
 =?utf-8?B?RmdwRGlPMkNXT1kxTTU5RTVDS1JXM050bjlnVnNZa2hKWnJINzBZaG1vTU5C?=
 =?utf-8?B?QXhIbXpnSHdobEtqK05kemxmMFRFSlJHQnFzY2J4Sm5JVGs2cEowNFVRQjdW?=
 =?utf-8?B?K2tqUXJWeGVOOE5ScXJVZ1AzY2M0RE52UHU4WUN0VGNRS0NvM0pxL1pCSDIz?=
 =?utf-8?B?UHhWRkg3VlRrVEJHT1RqYmFiUzM5ekp4YmllMTZ3YS9mTXNrU1NBUWhlbEtm?=
 =?utf-8?B?UUJLNiswNDJZZWxvWFZ3cXQzM1dJUENiOStvUnh0T2V0ckJybTZhcllxNkZx?=
 =?utf-8?B?YnFtUDRqQkl5em9TWXZtaHp5am9yTXovd1JJZ3FpVEFOaWEvNGFqa0s4QjE1?=
 =?utf-8?B?ejBHUGxvNkowZ3IwMHpCMXY1Q01ySmRlVFoyaEVqNFJiU1hJTnM2YnZsYjJS?=
 =?utf-8?B?cndUVjRTU1gvYVNPNjFZT2pJaWhETTlTNC94SEt1S2pMbnVYdGMxZXVmREV3?=
 =?utf-8?B?b2F4WVIwaXVneG9uTGwxcHJ6Z2pyamd1N1Vva0hwL0lxVXNHTkRITWRaUWdp?=
 =?utf-8?B?S3dNZFR2Z0dPSjJacHR6V043UFd6bDFKK0NkU2ZITThVaGduRnV6YThlVG1R?=
 =?utf-8?B?R0FxODRJRjF0NjdYYlhibjZ0UXkreHJLV0c3Q1AxQ1h6b0dFRTlnSG9MR3c0?=
 =?utf-8?B?dkFGUGkxeGNYUVZVMmlkSXBTYkQ1T3VPNWxRNk1qUzJTUURZcy9GU3A4cGpx?=
 =?utf-8?B?L3BENFM0WklJWHNvK2VITGwxOUduRTJTdjFZZk0vcENJRTNWdFN1dm9lVW1W?=
 =?utf-8?B?VzZUVWRJQWdiNitYK3RRTmFTQmFkWkNxNE9JZXBucjBJa25YN1pEdlI2WkZr?=
 =?utf-8?B?Y0QvSmFKWUJISnVOZldNWlJRVWI3NldGbjllazdybVF2QkE2NW4yRXNUQW44?=
 =?utf-8?B?cDdtVUtiZTdYNS9PU1hsZkthQjk0dzZlSnBDemFBajZ1TExIMzVlNkkzWlFr?=
 =?utf-8?B?d0RITllSUWZuOFh6VnpXQUpsRXJGWFNxWlJzVko5aTlqaXNCTm44WEdNYzgx?=
 =?utf-8?B?SWI3ai9ZbUhrRVNPUlZJY1VFQ2dIem9CeGVBQWM0V2JxZGl1TWEvNFBCZUI0?=
 =?utf-8?B?eWxnY2tmcnJ6aEFSWW1vaVFkaitWUWkxUzZMMmRZdnFVQmxBSlk5WkFzSkg2?=
 =?utf-8?B?dWgxMXVReSthU01HVkNwUUFGcmMxUjZWeEw5QUs3K3l3Z0NrRFNWUkFEWjVZ?=
 =?utf-8?B?YStKbFRUM2R6d0Q1Y2t4K25NOWwwOWh3ekVPdUJBWXZSa0dTa2JLVDd1alhy?=
 =?utf-8?B?dWNxL1RDWXJtNlV2UFc0NitNSkxJZytGR3htR2hsTVF6MklvNVRmS3pLRlZG?=
 =?utf-8?B?VDBwcGdDTk5ocTE3d01oejV2T0RwSWdnSmc2UFgzK0VJMHpnMlIxNndodzY2?=
 =?utf-8?B?Qk1IS25xVm9wRndieWFhck5ickw5SGczelRDQkRrK0Y5Mkd3MForUXFmRVhC?=
 =?utf-8?B?VktnWTlGSHBHbXdnRk1VU0xTUjhGb25ycnBjR2lUSHNoSGtnSEdFVnY4dmg1?=
 =?utf-8?B?aXJ3clp0QTBQbjQ4RU82NGUvUUt5ZWJ5Njhlckt3bGdBeURQd2NBTVZ2Q0ZW?=
 =?utf-8?B?SFc4U3NKNTRyK00wcXlpWkhUVmtxcXV0eDBsekRXZFFaTUoydVpmamNQWkJI?=
 =?utf-8?B?MDNsa2VYaVppYlpIU3ZZbWJUclZWNnF3MXowbkd1Zk1RUnR2Nm01Qk82Smhn?=
 =?utf-8?B?UDBRMW5uYlFjR21PVjlJbEFVNlU4RUpuTDhPQ0dqTThabnJqZFIzSlhiTUFX?=
 =?utf-8?Q?4K8K6Ia84gke4qMUbYQEDyKf+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5730f9-78fc-48a3-1c39-08dbb33d1ca8
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 03:05:26.1889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2Xn4aHZlXL6GwULSSj0ab6KqO381ac6goqt43g8s5edNmnLv985zfGEasBdQCxj7STZW+15huF/RxIJJiCsrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5420
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

On 9/11/2023 3:49 PM, Chen Yu wrote:
> Hi Prateek,
> 
> thanks for your review,
> 
> On 2023-09-11 at 13:59:10 +0530, K Prateek Nayak wrote:
>> Hello Chenyu,
>>
>> On 9/11/2023 8:20 AM, Chen Yu wrote:
>>>  [..snip..]
>>>  kernel/sched/fair.c     | 30 +++++++++++++++++++++++++++---
>>>  kernel/sched/features.h |  1 +
>>>  kernel/sched/sched.h    |  1 +
>>>  3 files changed, 29 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index e20f50726ab8..fe3b760c9654 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -6629,6 +6629,21 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>>  	hrtick_update(rq);
>>>  	now = sched_clock_cpu(cpu_of(rq));
>>>  	p->se.prev_sleep_time = task_sleep ? now : 0;
>>> +#ifdef CONFIG_SMP
>>> +	/*
>>> +	 * If this rq will become idle, and dequeued task is
>>> +	 * a short sleeping one, check if we can reserve
>>> +	 * this idle CPU for that task for a short while.
>>> +	 * During this reservation period, other wakees will
>>> +	 * skip this 'idle' CPU in select_idle_cpu(), and this
>>> +	 * short sleeping task can pick its previous CPU in
>>> +	 * select_idle_sibling(), which brings better cache
>>> +	 * locality.
>>> +	 */
>>> +	if (sched_feat(SIS_CACHE) && task_sleep && !rq->nr_running &&
>>> +	    p->se.sleep_avg && p->se.sleep_avg < sysctl_sched_migration_cost)
>>> +		rq->cache_hot_timeout = now + p->se.sleep_avg;
>>> +#endif
>>>  }
>>>  
>>>  #ifdef CONFIG_SMP
>>> @@ -6982,8 +6997,13 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
>>>  static inline int __select_idle_cpu(int cpu, struct task_struct *p)
>>>  {
>>>  	if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
>>> -	    sched_cpu_cookie_match(cpu_rq(cpu), p))
>>> +	    sched_cpu_cookie_match(cpu_rq(cpu), p)) {
>>> +		if (sched_feat(SIS_CACHE) &&
>>> +		    sched_clock_cpu(cpu) < cpu_rq(cpu)->cache_hot_timeout)
>>> +			return -1;
>>
>> Just wondering,
>>
>> Similar to how select_idle_core() caches the "idle_cpu" if it ends up
>> finding one in its search for an idle core, would returning a "cache-hot
>> idle CPU" be better than returning previous CPU / current CPU if all
>> idle CPUs found during the search in select_idle_cpu() are marked
>> cache-hot?
>>
> 
> This is a good point, we can optimize this further. Currently I only
> send a simple version to desmonstrate how we can leverage the task's
> sleep time.
> 
>> Speaking of cache-hot idle CPU, is netperf actually more happy with
>> piling on current CPU?
> 
> Yes. Per my previous test, netperf of TCP_RR/UDP_RR really likes to
> put the waker and wakee together.
> 
>> I ask this because the logic seems to be
>> reserving the previous CPU for a task that dislikes migration but I
>> do not see anything in the wake_affine_idle() path that would make the
>> short sleeper proactively choose the previous CPU when the wakeup is
>> marked with the WF_SYNC flag. Let me know if I'm missing something?
>>
> 
> If I understand correctly, WF_SYNC is to let the wakee to woken up
> on the waker's CPU, rather than the wakee's previous CPU, because
> the waker goes to sleep after wakeup. SIS_CACHE mainly cares about
> wakee's previous CPU. We can only restrict that other wakee does not
> occupy the previous CPU, but do not enhance the possibility that
> wake_affine_idle() chooses the previous CPU.

Correct me if I'm wrong here,

Say a short sleeper, is always woken up using WF_SYNC flag. When the
task is dequeued, we mark the previous  CPU where it ran as "cache-hot"
and restrict any wakeup happening until the "cache_hot_timeout" is
crossed. Let us assume a perfect world where the task wakes up before
the "cache_hot_timeout" expires. Logically this CPU was reserved all
this while for the short sleeper but since the wakeup bears WF_SYNC
flag, the whole reservation is ignored and waker's LLC is explored.

Should the timeout be cleared if the wakeup decides to not target the
previous CPU? (The default "sysctl_sched_migration_cost" is probably
small enough to curb any side effect that could possibly show here but
if a genuine use-case warrants setting "sysctl_sched_migration_cost" to
a larger value, the wakeup path might be affected where lot of idle
targets are overlooked since the CPUs are marked cache-hot forr longer
duration)

Let me know what you think.

> 
> Say, there are two tasks t1, t2. t1's previous CPU is p1.
> We don't enhance that when t1 is woken up, wake_affine_idle() will
> choose p1 or not, but we makes sure t2 will not choose p1.
> 
>> To confirm this can you look at the trend in migration count with and
>> without the series? Also the ratio of cache-hot idle CPUs to number
>> of CPUs searched can help estimate overheads of additional search - I
>> presume SIS_UTIL is efficient at curbing the additional search in
>> a busy system.
> 
> OK, I'll collect these statistics.

Thank you :)

> 
> [..snip..]
> 

--
Thanks and Regards,
Prateek
