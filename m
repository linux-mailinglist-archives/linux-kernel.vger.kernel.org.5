Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010ED7B770F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 06:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbjJDEVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 00:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjJDEVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 00:21:41 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD12AC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 21:21:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbZHr8eun4DvqYircKA9fzx44DgvfBwAYpSAelCVTGPFByJvPolhOqMXJpeeUr9UScibhSMONSPGZMCtCtkDcLvYTWjEUCQkI4FPeExEdG3zfuLAwwRgVdpmQH6LNXBLicz87sUOlZDhi+u6rUYsSOJCAFS6zxLkjdLlUBC4vtck0JB4ZTj4wcMUXhX9WC1c8a00M3w5UsOmgxUjcUYa8honpYMXFS1zHzr6SIrB3uPK4kzEMAB4L2n3xjuuOeQwCVIJCRYycuFYxgrn+oO4FuY6kb0XJtRiKy+JGL9eS5t/+W+/LcPindVPuIgrUSBgyCuU35YHvh4cVGMrGOXT1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ujTs2yiqdnmZRsxAPm8raQqFD1bj7gdK/afjsWhs9w=;
 b=gzO3pILzYVpZaYroX2+BojDi1TdcuJDEW5+tWDEBLdpc47pqnIdYprteum8SAgIjR1jjp+8d8a2u/2TnixDV0s1KELpoj/iLRrW28xYya0R87kA8PJEPMvj03V6alT1LphixoAYpCJhwGV9ox8dOIo8whwGwSTkWsw9iwVIcMw9vBCSz/36VJuXJRHYiv851dfb/lfcVi05ylisLmpoT/Ge4yYn+qUYSFN3e6QkNKAcu3cAnQNx3QHxmuwWUu8JhcEtQASKcBDMw6cMp2NcW+LTSrSZ3Hcv7PZCHZwjC53juJhpDqQcoduM0fw8nNqLrnjRrRHxL1j5jdchA4YPkiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ujTs2yiqdnmZRsxAPm8raQqFD1bj7gdK/afjsWhs9w=;
 b=30pxhLSMUYyJYNQRypwF9dWlu1eOpipjKfVUKqjrgFaKGXKXIKpuZHPkAa83Ppo6u8wOcL4Xd0USiRP9AjPxo4FiqVdtp6nKXvd5VIl2a49oH6PniCiwhH79bN9GnliWLlvUnq3/GBJpO+ls8CXA0gnXUR1cxxjg3Jyh1cC1TLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by IA1PR12MB8221.namprd12.prod.outlook.com (2603:10b6:208:3f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Wed, 4 Oct
 2023 04:21:33 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::2cf7:49ea:e95c:31b8]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::2cf7:49ea:e95c:31b8%6]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 04:21:33 +0000
Message-ID: <925f13cd-b020-a799-3505-b3df46a51ffe@amd.com>
Date:   Wed, 4 Oct 2023 09:51:18 +0530
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
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230929170104.GA78641@maniforge>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::6) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|IA1PR12MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: 12eb7f68-c4f3-4d36-af10-08dbc49163be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kg/hzZh7sUK7aBAnynJFelqSoy7gRUaBOjQwxRXIm5V5R/ArQ35Z7KOLDoGquk5O93RgZycwYd6fL+xB/2JDCqnRAg9St5Ca3tZw/o+R3+8fGNnFJH3LSDDlCUSPD5HMSh4KY2TJXhTBVeey/iELXvoRj9QZyiqY4IwZo0JAvzJGazOzr9wYyz1T1Yw63jH61aQSbeYC7IKsXiBl65xr290wvLJI5e3vfPUsdPPaCINLbeEeqlfFgUOEF51ZQ5jg4ilXEIwBf7uDdJbtIpny8qEDkcOmJkBLD50scxs24s9QwUX/29ckCCq3/87yS0RO2e1a8JdZpGGEkmgHMWckOU83CVe382gEyGHwK6y95fI6b70Q3zdS7KrbuyFHwcPe3Pv0M4GuWqCRdwRtvS7AimI/uR2ogxa7FjQV9O77JAf7c8yHnklXHPUnVgrE5A/0drxMFZETxMXdmPwaqqzs7WipLmUPwy9c8x91B4W71yEYCP8f6JMqqfAL7MX6+fBFTWBcr8SEi5tAOHCQ+M3A8HaFvf5xKOtxS/TeLymYzdHC/qiBs+16MZRfCnmqmBVWpU4EJnDtzrgkfawnNwMOW/AE1EVZQ4vMFqXyO1raNy82dIRR+Wn1JO2T6ABybIg4s1BC5rrL1tNr6+NNtRmuIFcpyTOgU40ntD8wp69ocTbqSoAUpeUBsvDmg1/V3euw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(5660300002)(86362001)(53546011)(31696002)(6506007)(6512007)(6666004)(66476007)(66556008)(478600001)(26005)(66946007)(6916009)(2616005)(966005)(6486002)(36756003)(316002)(38100700002)(83380400001)(41300700001)(4326008)(8676002)(8936002)(7416002)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHBlQUdGaUtKUjl4d2JkMDdkajhwcEZsMThjVFFIeHFRN2RPaFZGbTU2Mkhx?=
 =?utf-8?B?VTdaMG4rNzRtZnc2QXF1Y1NRQ3h5bE1qWERDMHFMYzZ1ZGZaNGJxQ3dTdFly?=
 =?utf-8?B?MXpJcXhqbFNlcVppemRwOFY3Skh0Smg4S0FWT1lWRzAvaE9yNnRBWUd6Y2Vh?=
 =?utf-8?B?NjJhMHE4QmZITWhRSjRDa2ZlZU1GdzJ2QU1TdXhwTXBKajFtY2M4SktOUDFr?=
 =?utf-8?B?K3dMdE1ZaERnMy96MEswRFZYYk1lcmRkWmpzc1BXUmxaYlVJQVpwV0NGc0Nu?=
 =?utf-8?B?Q2lzbjVydFM4NTBJS2hmSnJWU1lpQTYyelZSNWFmemswY0p0QjFVU3JYSWg5?=
 =?utf-8?B?N1hWc3RSQzArMVA4WnlEajU0UFVIWlVCa3ZsMEs5ZU9Ga1laUXBpcWpQOUZG?=
 =?utf-8?B?aVJ4ZDFLQXhWcEdyZmMyaFNUa3JaUzV4REdiQzBWQ2U4UWEzVXhadlY0c2c5?=
 =?utf-8?B?MlBTSUFqY1RzUWRoUjJMaC9LTi91YmtEVmgwUDEyYTZsSE1mZXpDeEFraDJ5?=
 =?utf-8?B?ZDFmSWgvdEI1aldPL25henFWd2xqZXJWa1VRcE1jN3lPMkNsV2t0Rmk2VHVk?=
 =?utf-8?B?U21tMEtNYlFIMDlmeE53SDZvQ0ZNWW1wRDljZnVwdjVFNlh0T21QYTI0V0tK?=
 =?utf-8?B?aVlsSWJLVTVmV05RcjMxWjVyb1lmUndFdmR3L1g1UjUyckErMHdtQ0F6ZjZ6?=
 =?utf-8?B?RXAwS0tzZWQwb3FWci9IT1RZWFhEeUMrQ3Y3VllGRk1VdzVkSTM5Ryt0dGFj?=
 =?utf-8?B?N3BpaDBSeE5CeGpjNGZhM1A1OXlhMWpHckJ0NTR5NG11S2psQWVyTWsvOVJv?=
 =?utf-8?B?WWoxcjh1S3c3Rk4wZE9SSWFpc2NtUm1PT25XaXFDWEFsZEJ6Q1VaNllseGtr?=
 =?utf-8?B?MG9FSGFpSVNYVkJWNmczTGpLUnBReWFySUFNbU9GRzVJenF2ZWd5dmp0MnQz?=
 =?utf-8?B?MW9kQlp1QWFXdUlhTTFWaFVlRm95dkJaenNvajRncENYWXIyaGhWSS9Scno4?=
 =?utf-8?B?TnIzd3JBUEVpQVVnRW5pYzJmTGZzVGxIS0lEY3BxY3UvNDdkRGN0eUp5QWJS?=
 =?utf-8?B?UlhadEZoelNHMG9RMTUzUWJ1aHg4UHRyK3JxVUlNOWoyR2xJY1pId3ExTTIx?=
 =?utf-8?B?NnFqVTZiSVV1N0V0MFZIK2NFV0tWNkk1dEtET01iVFNrWjlrVTZob3JlenNG?=
 =?utf-8?B?Y0s5TEVoczAwbnR6cW1rTEJDRUxNQVV5Vk4wUW5rTXRRQjQ4Z20xcjlVWUpS?=
 =?utf-8?B?aDFpYWQ2Q2VxZFdETXVXTEg2UEp6bDFMYzJ2cWV5M21WQUtUSFZoSURvVTJ2?=
 =?utf-8?B?UlpSaE84MDREbXErMVBsV0VKZlpsMTJkTCtwbks0WWJ2VnlrdlM2YVpCVHlF?=
 =?utf-8?B?T0ZvMWl1Y3c0QVhYaXlweE0xdFlkYW9RVDluV2p4K3gwalBpTkdrSktETUxh?=
 =?utf-8?B?RVU4RWFHMG5KbGpVSG55clRBakVKdWtaUXB5MnFkL0EvSE43VldvRUEwZDJ2?=
 =?utf-8?B?U2lVYnJ0TGVkMFRpRWMrY0tnM1hndnJBTnV0YWNleHZHZUFuT1RTUEVwOHZm?=
 =?utf-8?B?SkZUMEFQaVlsb1EzT0xMcmdvK29KS0N0YVpQSWtzSCttUXpCV3hBVmtwT3g1?=
 =?utf-8?B?Z2QrRjU4TCsveDkxU0pMWTZrQUhBRENsZGt6R3BjeVJSMnJnVS9CYWpvN052?=
 =?utf-8?B?UWIzQTVvYnR3b3V5YXdTaDZMZW5FVFFDeTQ5SEZlN2U1dzdUYTFPclBuYVhh?=
 =?utf-8?B?aUhMalNxVlNiN2JOYUN3a2VvRW9jOXFqbS92T3dURkpFNkJaeTJ2dU9kSEwx?=
 =?utf-8?B?L3ZFNmorNm5meWNGcHNRM2xLYVV4a29tNXpubkdHMGpWa0pLNXZhRWhkNHp0?=
 =?utf-8?B?SVRMeCtsRWtSWXRQdVFBRFZNdXA4SDJJZVQ4WnhxUGJLWjQ0Q3VtM1EzRXo0?=
 =?utf-8?B?VW50Tk4rK2RiTzBUazhqQU52UWhLWGh3bEk1bWtrSnFRaDY4VUMwWmh5cGFn?=
 =?utf-8?B?blJZSFJ4M0hjaEpsQU1QK1JPSklBK0pNUEJoU2NqcTFXaVdYVCtQdEhqUlVh?=
 =?utf-8?B?aFRVM3VRWDhWNWVNdTliNTVjK2VuU2xtSzB6TnA4WW1qd3Z4aXFGbWo1NW1Y?=
 =?utf-8?Q?ieyiJdYJzjM4AvV00moywifZ3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12eb7f68-c4f3-4d36-af10-08dbc49163be
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 04:21:33.0098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZX3lntg3bP1d2KEBI6KSDG7JjfuRN9V4Q269V9hYf8FBKWhtNG7IhkpCp7pw21mKKAI61L2TMsCERZV0H5jhMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8221
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

Thank you for answering my queries, I'll leave some data below to
answer yours.

On 9/29/2023 10:31 PM, David Vernet wrote:
> On Fri, Sep 01, 2023 at 01:53:12AM +0530, K Prateek Nayak wrote:
>> Hello David,
>>
>> On 9/1/2023 12:41 AM, David Vernet wrote:
>>> On Thu, Aug 31, 2023 at 04:15:08PM +0530, K Prateek Nayak wrote:
>>>
>>> Hi Prateek,
>>>
>>>> Even with the two patches, I still observe the following lock
>>>> contention when profiling the tbench 128-clients run with IBS:
>>>>
>>>>   -   12.61%  swapper          [kernel.vmlinux]         [k] native_queued_spin_lock_slowpath
>>>>      - 10.94% native_queued_spin_lock_slowpath
>>>>         - 10.73% _raw_spin_lock
>>>>            - 9.57% __schedule
>>>>                 schedule_idle
>>>>                 do_idle
>>>>               + cpu_startup_entry
>>>>            - 0.82% task_rq_lock
>>>>                 newidle_balance
>>>>                 pick_next_task_fair
>>>>                 __schedule
>>>>                 schedule_idle
>>>>                 do_idle
>>>>               + cpu_startup_entry
>>>>
>>>> Since David mentioned rq->avg_idle check is probably not the right step
>>>> towards the solution, this experiment introduces a per-shard
>>>> "overload" flag. Similar to "rq->rd->overload", per-shard overload flag
>>>> notifies of the possibility of one or more rq covered in the shard's
>>>> domain having a queued task. shard's overload flag is set at the same
>>>> time as "rq->rd->overload", and is cleared when shard's list is found
>>>> to be empty.
>>>
>>> I think this is an interesting idea, but I feel that it's still working
>>> against the core proposition of SHARED_RUNQ, which is to enable work
>>> conservation.
>>
>> I don't think so! Work conservation is possible if there is an
>> imbalance. Consider the case where we 15 tasks in the shared_runq but we
>> have 16 CPUs, 15 of which are running these 15 tasks, and one going
> 
> I'm not sure I'm fully following. Those 15 tasks would not be enqueued
> in the shared runq if they were being run. They would be dequeued from
> the shared_runq in __dequeue_entity(), which would be called from
> set_next_entity() before they were run. In this case, the
> shard->overload check should be equivalent to the
> !list_empty(&shard->list) check.
> 
> Oh, or is the idea that we're not bothering to pull them from the
> shared_runq if they're being woken up and enqueued on an idle core that
> will immediately run them on the next resched path? If so, I wonder if
> we would instead just want to not enqueue the task in the shared_runq at
> all? Consider that if another task comes in on an rq with
> rq->nr_running >= 2, that we still wouldn't want to pull the tasks that
> were being woken up on idle cores (nor take the overhead of inserting
> and then immediately removing them from the shared_runq).

So this is the breakdown of outcomes after peeking into the shared_runq
during newidle_balance:

                                                SHARED_RUNQ                     SHARED_RUNQ
                                        + correct cost accounting       + correct cost accounting
                                                                        + rq->avg_idle early bail

tbench throughput (normalized)		:	     1.00			2.47	       (146.84%)

attempts                                :       6,560,413                  2,273,334           (-65.35%)
shared_runq was empty                   :       2,276,307 [34.70%]         1,379,071 [60.66%]  (-39.42%)
successful at pulling task              :       2,557,158 [38/98%]           342,839 [15.08%]  (-86.59%)
unsuccessful despite fetching task      :       1,726,948 [26.32%]           551,424 [24.26%]  (-68.06%)

As you can see, there are more attempts and a greater chance of success
in the case without the rq->avg_idle check upfront. Where the problem
lies (at least what I believe is) a task is waiting to be enqueued / has
been enqueued while we are trying to migrate a task fetched from the
shared_runq. Thus, instead of just being idle for a short duration and
running the task, we are now making it wait till we fetch another task
onto the CPU.

I think the scenario changes as follows with shared_runq:

- Current


      [Short Idling]	[2 tasks]                        [1 task]	[2 tasks]
	+-------+	+-------+                       +-------+	+-------+
	|	|	|	|        wakeup         |	|	|	|
	| CPU 0 |	| CPU 1 |	 on CPU0        | CPU 0 |	| CPU 1 |
	|	|	|	|       -------->       |	|	|	|
	+-------+	+-------+                       +-------+	+-------+

- With shared_runq

      [pull from CPU1]	[2 tasks]                       [2 tasks]	[1 task]
	+-------+	+-------+                       +-------+	+-------+
	|	|	|	|        wakeup         |	|	|	|
	| CPU 0 |	| CPU 1 |	 on CPU0        | CPU 0 |	| CPU 1 |
	|	|	|	|       -------->       |	|	|	|
	+-------+	+-------+                       +-------+	+-------+

We reach a similar final state but with shared_runq we've paid a price
for task migration. Worst case, the following timeline can happen:

        |
  CPU0  | [T0 R, T1 Q] [       T0 R      ] [newidle_balance] [T4 R ...
        |
        |                  pull T1 \             pull T4 /
        |
  CPU1  | [T3 R] [newidle_balance] [T1 R, T4 Q] [       T1 R      ]
        |            [T4 TTWU]
        |

With the rq->avg_idle bailout, it might end up looking like:

        |
  CPU0  | [          T0 R, T1 Q          ] [T1 R ...
        |
        |
  CPU1  | [T3 R] [ I ] [T4 R ...
        |            
        |

If possible, can you check how long is the avg_idle running your
workload? Meanwhile, I believe there are a few workloads that
exhibit same behavior as tbench (large scale idling for short
duration) Let me go check if I can see tbench like issue there.

> 
>> idle. Work is conserved. What we need to worry about is tasks being in
>> the shared_runq that are queued on their respective CPU. This can only
>> happen if any one of the rq has nr_running >= 2, which is also the point
>> we are setting "shard->overload".
> 
> Assuming this is about the "wakeup / enqueue to idle core" case, ok,
> this makes sense. I still think it probably makes more sense to just not
> enqueue in the shared_runq for this case though, which would allow us to
> instead just rely on list_empty(&shard->list).
> 
>> Now situation can change later and all tasks in the shared_runq might be
>> running on respective CPUs but "shard->overload" is only cleared when
>> the shared_runq becomes empty. If this is too late, maybe we can clear
>> it if periodic load balancing finds no queuing (somewhere around the
>> time we update nr_idle_scan).
>>
>> So the window where we do not go ahead with popping a task from the
>> shared_runq_shard->list is between the list being empty and at least one
>> of the CPU associated with the shard reporting nr_running >= 2, which is
>> when work conservation is needed.
> 
> So, I misread your patch the first time I reviewed it, and for some
> reason thought you were only setting shard->overload on the
> load_balance(). That's obviously not the case, and I now understand it
> better, modulo my points above being clarified.
> 
>>>
>>>> With these changes, following are the results for tbench 128-clients:
>>>
>>> Just to make sure I understand, this is to address the contention we're
>>> observing on tbench with 64 - 256 clients, right?  That's my
>>> understanding from Gautham's reply in [0].
>>>
>>> [0]: https://lore.kernel.org/all/ZOc7i7wM0x4hF4vL@BLR-5CG11610CF.amd.com/
>>
>> I'm not sure if Gautham saw a contention with IBS but he did see an
>> abnormal blowup in newidle_balance() counts which he suspected were the
>> cause for the regression. I noticed the rq lock contention after doing a
>> fair bit of surgery. Let me go check if that was the case with vanilla
>> v3 too.
>>
>>>
>>> If so, are we sure this change won't regress other workloads that would
>>> have benefited from the work conservation?
>>
>> I don't think we'll regress any workloads as I explained above because
>> the "overload" flag being 0 almost (since update/access is not atomic)
>> always indicate a case where the tasks cannot be pulled. However, that
>> needs to be tested since there is a small behavior change in
>> shared_runq_pick_next_task(). Where previously if the task is running
>> on CPU, we would have popped it from shared_runq, did some lock
>> fiddling before finding out it is running, some more lock fiddling
>> before the function returned "-1", now with the changes here, it'll
>> simply return a "0" and although that is correct, we have seen some
>> interesting cases in past [1] where a random lock contention actually
>> helps certain benchmarks ¯\_(ツ)_/¯
> 
> I don't think we need to worry about less lock contention possibly
> hurting benchmarks :-)

Yup :)

> 
>> [1] https://lore.kernel.org/all/44428f1e-ca2c-466f-952f-d5ad33f12073@amd.com/ 
>>
>>>
>>> Also, I assume that you don't see the improved contention without this,
>>> even if you include your fix to the newidle_balance() that has us skip
>>> over the <= LLC domain?
>>
>> No improvements! The lock is still very much contended for. I wonder if
>> it could be because of the unlocking and locking the rq again in
>> shared_runq_pick_next_task() even when task is on CPU. Also since it
>> return -1 for this case, pick_next_task_fair() will return RETRY_TASK
>> which can have further implications.
> 
> Yeah, I could see it being an issue if we're essentially thrashing tasks
> in the shared_runq that are just temporarily enqueued in the shared_runq
> between activate and doing a resched pass on an idle core.
> 
> Unfortunately, I don't think we have any choice but to drop and
> reacquire the rq lock. It's not safe to look at task_cpu(p) without
> pi_lock, and we can't safely acquire that without dropping the rq lock.

True that. We wouldn't want to run into a deadlock scenario or cause
more lock contention with double locking :(

> 
> Thanks,
> David

--
Thanks and Regards,
Prateek
