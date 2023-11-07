Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6507E3368
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 04:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjKGDCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 22:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjKGDCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 22:02:32 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F532184
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 19:02:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oY5wZGo5ieoaQ11CNUDAunKIuwEetIX/+p89vLBJ4o22/8sSOySq1ds0KBrFY8lZQ8cOdbts3fUmg3v9iIR3tS73NATCfx59eKB+C8wxNZbD6YAMgRUQJP8zY4KD4t8Aa17MXCkocff3cCgagZKDF3PI61uGR+fYQ3qOt8vRxKmQYMszD5UIj5k76jDFQwMKi+HxrfiMVRWR31Mr49sH8JlR6lm7rZWcnG/on969aZ5cf46u+wJai6O5pRHuXnKUwmfJxg/NF7es3/gO/wjuJlo7EUINvuUvgHUEQaBjzI6/HHRqwlw4/QiKyh7uKRidYevaT39uW/+DmzwjK+FQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEuAFoOb9MWz6KVtHz/hEVmPSIBgK07BCTZOXF31eZI=;
 b=ac08qe0Rw3CAIa4lDHnfRlXfgMk5qno8Wb9AXNIRhW48EJeWR/0hyc/ir4yH/6gcRyVA0IdoAx4EbhsTFFkHGgGGR4qITgK1KetbBphf9M8iQ8SUHoPc7hKGuXX5ZMt5sdwgiOdGMp4SuvyAoxOBVRuKQR2Y3as+70e34+aTIbDNNGbFo8xMRJlVo8u6iRd3uPE8B7fnJmJAEIaSKgwfq94jeemQks1y7QmUa2qDfwudndnxv3BtnlNktAEpBBEewidny/w52Y53T06pXke/yl7pEjC/h8uKC0EPo2XPiNjr7ablbBKHsD8q8aVYaw05Wsyze+jCDZv2U78Nu9XGtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEuAFoOb9MWz6KVtHz/hEVmPSIBgK07BCTZOXF31eZI=;
 b=c9qoGjQl2/S6JoF5fEE+pa5lVIjqLU8jMT6WddbxAq+3yI0xju+LQjeQeKzza4MwfSIxMT3p9B786uWu7GXHh6krU1r28zJliMa8jZexhr+Z69tPIsctqGzLN+1YvGO+VC8RmZVw8KZ+JUCL0ShLIWCLJ2nGD7SLAGzRgfQtZns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 03:02:26 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::90ac:49b0:329:8bc8]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::90ac:49b0:329:8bc8%6]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 03:02:25 +0000
Message-ID: <2e8462be-48f6-9134-9d3f-bb0868f25788@amd.com>
Date:   Tue, 7 Nov 2023 08:32:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH v2 0/2] sched/fair migration reduction features
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, Tim Chen <tim.c.chen@intel.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org
References: <20231019160523.1582101-1-mathieu.desnoyers@efficios.com>
 <85b710a9-5b26-b0df-8c21-c2768a21e182@amd.com>
 <ZUh/LK4iy3ukVaCn@chenyu5-mobl2.ccr.corp.intel.com>
 <a95bab2c-7f7a-18a2-6307-ffcdef4e2726@amd.com>
 <b7f25858-ab0e-41aa-90a9-35d8348fc206@efficios.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <b7f25858-ab0e-41aa-90a9-35d8348fc206@efficios.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::20) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|MN2PR12MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: f1be0c52-8268-4d24-cf16-08dbdf3df80c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ppo5Waw/giykiEiikgoEohN05Alq/R9C+Rst7MvXkQwE+XjhtNdDHOfRFlRq042Pi80Ih+EWXcVDigCd5FqcbCGd08RLodmXi4BB/xD6UG/uWsvJmLGrD5Q/gQA/39PkJX56H5P/JUWYOTTG4QUjdIApIHmgPm9S8oMfeF4Qq0KFUAtsKMh3gLOZqPzb1K459PoIir3hHdmyZVO0pN+Ttb/Gko/o6y5SA+rVGRKpRcD16yk/ycyttMJu3zxkAhlMfTTD4EJO+NfCg+Ov651fX5/QEA4ketnxNXxoK4zrJtONMw5cFOfXhs4rukVrMAlq+Rqmkc0jUtuZHspV70KLKjPliBHK1R+vvB4bp/ZD9yqKLYPhwJXEWxTmgpSRvcrwe+BO7Gdx0p9RgfMX6td0t5SgnOjHL29F68GT0YevyONT8oI6lDRp7htQPc06farDnsboDLzWLkDDbDBRI2bSKf89/UnAAOhn9lA7yCu+oWN+oVgRBO6YIppOce55qpBkrLJEyPo76/EUGrFiQmID3qnC0Nn8e3I9z0nyH4aD3RCzk6TSzRPr99h6wUJDPzMNDYb0Trr/ENfiTdNBXU2bgafIyvPX5Ghjw2tFs9PYhh/mgSxm++8OfxUNSjpk1X955RVsw5BzGUeG8rIiLuaATg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(2906002)(83380400001)(66899024)(4001150100001)(38100700002)(86362001)(31696002)(36756003)(26005)(6666004)(6506007)(53546011)(110136005)(8676002)(8936002)(4326008)(41300700001)(66556008)(6512007)(6486002)(966005)(478600001)(54906003)(316002)(66476007)(66946007)(31686004)(7416002)(5660300002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXkvdWhvLzVOOXFOV1F4UXpQL1dIQmswdGVUcEpEY2w0dlhOWWhYdmFpMFQx?=
 =?utf-8?B?VWQyNzBLV0xjRDM3S255ajV2dXhYa3VoNjJGRTc3bkh1Uk9OemFnL1JOVW9H?=
 =?utf-8?B?S3M1c3ppbWN4YUhtUkhxSnNEZE1ISXpQeVZlZ08wckpxcEt3YkVhVkZwSlpv?=
 =?utf-8?B?QjBCdU41YkU3d2tpVXZ1bmtNSldWWVFsVDllS0g5TnY4ZVNldVh2MXRYaVZE?=
 =?utf-8?B?YWZMWjlzNkp6Qkp3ek5GbENRUUJRYUhmRDRkOC9PczlIUnNoTEN4QU4yS3lw?=
 =?utf-8?B?OFRhS2hZSklSRFNSdHVpL3dNOGdYbjVlWHI5azFLbHdDNlRyZ3Nvb2RVbGhl?=
 =?utf-8?B?dmFJVkF5SHFxbm00SVh3RUdVME5LOGxrTE5Rc01McnNVZzZYUGhVQ0JoTmRT?=
 =?utf-8?B?VWNkSTJWSExCT2JUTUNPOUszd2d2YU1XbWdFTTMwUVVOUnZWWWJwVmphSGpo?=
 =?utf-8?B?dkdzTDV0MXhpRmJKQkZaWkRhZVdJaGY0TE12cGFxTFEyek9PUURVVTBjL0lx?=
 =?utf-8?B?aHhSUlhMQkQ3YlNzdStXRTUwU0UxYmNnU01tT3BsNnp1N2F5ZklTUWhLc0p6?=
 =?utf-8?B?VDhrbDdMVW9FRXJkTVQrSUZhMWp1Q05TNDhrQ1FBOHIwZmVkNm5MTFFjZnpS?=
 =?utf-8?B?cTVaSHNaSjlLeFduM2Q1MDN2TTkwYWdlNTM2bjNXWHhNaVk4dUc1MnZ4RWpt?=
 =?utf-8?B?ZEVZU3M5NGZsMjh0VXB2ZDRtZzdhSFFNVEZxekpVK0E5MlpXRVN5MllCcWJN?=
 =?utf-8?B?Q2FRZmZWaFlZajB6YUIxSkZqSnZQMG85citkdHRITmplWlQyY0UzNmZaamhu?=
 =?utf-8?B?bkZDWm9XeEQyb2l2STdHOVo1Qngzek5DOUlFUFUwemdLbTBMMUZYTFY2ZWZ5?=
 =?utf-8?B?aktraTNIR0VpV1QzcHhmZHRXTWwrcnVwSVd2UDBWbjJ3TkJXNE8yaXVKeUpV?=
 =?utf-8?B?SkN3ODAwVVFCajE0MGlkOEEyeFA5K3pyMHJxeGdRNjRiVDE2T2N3TWk5dXhw?=
 =?utf-8?B?OGlJWlppZ3cyblVZQWRQM2dLR2FrQTdHK3ZFZkJ5OW5ZMjA2SFFwTXpEeDFO?=
 =?utf-8?B?Q21aVEF3SG5YZWRpbVExUnJ5YnFuSnlCZzQ5bHNxaTRJbTRHYmU1UDZXSXhy?=
 =?utf-8?B?STkrbnRzZElxdVh0T1R3Um9IOWRxV1pGMEZMeDk1MmhHRzhlMExmZGUxUVVF?=
 =?utf-8?B?cjgvbFRlcURGaW5ZSk5pQis0NUp4Y29najg3VkZXeEk5c3VTRHViaHkyUllJ?=
 =?utf-8?B?YlFocmd0MEFTSEcxTWc1SFA0Zlp5dGI1KzUwamVyZGw0Vkp1ZHp0Y0pmUitE?=
 =?utf-8?B?SUVCaHpyOUFlU2lhdGlaOXMwT2plVHFlTFBTbTFOcVZtanhUYTFyeXE4cEly?=
 =?utf-8?B?cGh2SG0wbGdKUDBVS1crZDQwWDBGd01Xb3BsWjFGWlBlcy9JZGVpNVRXbklT?=
 =?utf-8?B?L3FRZ0FHdW9zS0gwM1ZVMnk5dTBHRzJjTGl0MmZwZkRxTkcvUHJBTUVmcjd2?=
 =?utf-8?B?eldJbUQ2elFNVTcvRnZ4aHQ5bEN2MGlLS2g5Z1Q3cURHVnZKZkh1M25XSVF4?=
 =?utf-8?B?SkEvMEwxWXg3bmFDcW4vSTV6NktMY3ljclM4dm4za0d6Tml6eE1mR0lCWldF?=
 =?utf-8?B?bXVFcFFpbzBhNGR3UkRzTjR6ZXFEeEdMSFhsYjdGd05MSDY1bUNES3JXYm1r?=
 =?utf-8?B?Yko5YytUMk5BZnlkcFpNOU5xNmdUbHk2MUF1cUtuRC9CaHJJOWR1VTVNTElE?=
 =?utf-8?B?Ky9zUkpKckxaS09NSW9zQXViTjdLMS9CS241V21lajBDQ2dkY2lMTzZWS3gx?=
 =?utf-8?B?YlRQL2pYWHlRS0VjQmRwUzIxcFYyeElMSkh4Z0tlUnp2SlVpbUw4eEtQcFVn?=
 =?utf-8?B?UGdDc0o3b1dJVmVIcDIvTjd6NHphS3l5S0Y2YnM0ZFc2VnJxU0JaU0NoM3g1?=
 =?utf-8?B?Z0VIcjBxM0I3ZHhyYmJkRWZZakthNHhlUjBQOHVMN1gwR1AySzZFZWpNU2ZG?=
 =?utf-8?B?WnpUK3d2ditpM2haMXZBQnJkTnY0SlhnbFV4ZHJ4Z3dQV2ROZDM2N0E1N3pv?=
 =?utf-8?B?cDBBTEdMQlJML2ZRczdRcmxsMUlackxsVENxWGY5Tmd2UDhPK3h3SlFlOWM4?=
 =?utf-8?Q?xBT5GyvoGwnnJIxzlQK8gcIZ4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1be0c52-8268-4d24-cf16-08dbdf3df80c
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 03:02:25.4319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6I+U6AvVfFQcFdyCDX0euCyi2JLv8mZRi41I0c4/JVA3FCM49ASw2SqaDv6MmTT5pRjjSFSvqCUop2Xr+RCygA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mathieu,

On 11/6/2023 10:48 PM, Mathieu Desnoyers wrote:
> On 2023-11-06 02:06, K Prateek Nayak wrote:
>> Hello Chenyu,
>>
>> On 11/6/2023 11:22 AM, Chen Yu wrote:
>>> On 2023-10-27 at 08:57:00 +0530, K Prateek Nayak wrote:
>>>> Hello Mathieu,
>>>>
>>>> On 10/19/2023 9:35 PM, Mathieu Desnoyers wrote:
>>>>> Hi,
>>>>>
>>>>> This series introduces two new scheduler features: UTIL_FITS_CAPACITY
>>>>> and SELECT_BIAS_PREV. When used together, they achieve a 41% speedup of
>>>>> a hackbench workload which leaves some idle CPU time on a 192-core AMD
>>>>> EPYC.
>>>>>
>>>>> The main metrics which are significantly improved are:
>>>>>
>>>>> - cpu-migrations are reduced by 80%,
>>>>> - CPU utilization is increased by 17%.
>>>>>
>>>>> Feedback is welcome. I am especially interested to learn whether this
>>>>> series has positive or detrimental effects on performance of other
>>>>> workloads.
>>>>
>>>> I got a chance to test this series on a dual socket 3rd Generation EPYC
>>>> System (2 x 64C/128T). Following is a quick summary:
>>>>
>>>> - stream and ycsb-mongodb don't see any changes.
>>>>
>>>> - hackbench and DeathStarBench see a major improvement. Both are high
>>>>    utilization workloads with CPUs being overloaded most of the time.
>>>>    DeathStarBench is known to benefit from lower migration count. It was
>>>>    discussed by Gautham at OSPM '23.
>>>>
>>>> - tbench, netperf, and sch bench regresses. The former two when the
>>>>    system is near fully loaded, and the latter for most cases.
>>>
>>> Does it mean hackbench gets benefits when the system is overloaded, while
>>> tbench/netperf do not get benefit when the system is underloaded?
>>
>> Yup! Seems like that from the results. From what I have seen so far,
>> there seems to be a work conservation aspect to hackbench where if we
>> reduce the time spent in the kernel (by reducing time to decide on the
>> target which Mathieu's patch [this one] achieves,
> 
> I am confused by this comment.
> 
> Quoting Daniel Bristot, "work conserving" is defined as "in a system with M processor, the M "higest priority" must be running (in real-time)". This should apply to other scheduling classes as well. This definition fits with this paper's definition [1]: "The Linux scheduler is work-conserving, meaning that it should never leave cores idle if there is work to do."
> 
> Do you mean something different by "work conservation" ?

Sorry for the confusion. My interpretation of the term "work
conservation" was when there are multiple runnable tasks in the system,
each task more or less get same amount of CPU time. In case of hackbench
specifically, it is time in the userspace.

> 
> Just in case, I've made the following experiment to figure out if my patches benefit from having less time spent in select_task_rq_fair(). I have copied the original "select_idle_sibling()" into a separate function "select_idle_sibling_orig()", which I call at the beginning of the new "biased" select_idle_sibling. I use its result in an empty asm volatile, which ensures that the code is not optimized away. Then the biased function selects the runqueue with the new biased approach.

So in a way you are doing two calls to "select_idle_sibling()" each
time? Or is it more like:

	select_idle_sibling(...) {
		int cpu = select_idle_sibling_orig();

		/*
		 * Take full cost of select_idle_sibling_orig()
		 * but return prev_cpu if it is still optimal
		 * target for wakeup with the biases.
		 */
		if (sched_feat(SELECT_BIAS_PREV) && prev_cpu_still_optimal(p))
			return prev_cpu;

		return cpu;
	}			

> 
> The result with hackbench is that the speed up is still pretty much the same with or without the added "select_idle_sibling_orig()" call.
> 
> Based on this, my understanding is that the speed up comes from minimizing the amount of migrations (and the side effects caused by those migrations such as runqueue locks and cache misses), rather than by making select_idle_sibling faster.
> 
> So based on this, I suspect that we could add some overhead to select_task_runqueue_fair if it means we do a better task placement decision and minimize migrations, and that would still provide an overall benefit performance-wise.

Some of my older experiments when SIS_NODE was proposed suggested the
opposite but things might have changed now :)

I'll get back to you on this. 

> 
>> there is also a
>> second order effect from another one of Mathieu's Patches that uses
>> wakelist but indirectly curbs the SIS_UTIL limits based on Aaron's
>> observation [1] thus reducing time spent in select_idle_cpu())
>> hackbench results seem to improve.
> 
> It's possible that an indirect effect of bias towards prev runqueue is to affect the metrics used by select_idle_cpu() as well and make it return early.
> 
> I've tried adding a 1000 iteration barrier() loop within select_idle_sibling_orig(), and indeed the hackbench time goes from 29s to 31s. Therefore, slowing down the task rq selection does have some impact.
> 
>>
>> [1] https://lore.kernel.org/lkml/20230905072141.GA253439@ziqianlu-dell/
>>
>> schbench, tbench, and netperf see that wakeups are faster when the
>> client and server are on same LLC so consolidation as long as there is
>> one task per run queue for under loaded case is better than just keeping
>> them on separate LLCs.
> 
> What is faster for the 1:1 client/server ping-pong scenario: having the client and server on the same LLC, but different runqueues, or having them share a single runqueue ?

Client and Server on same LLC, but on different cores give the best
result. 

> If they wait for each other, then I suspect it's better to place them on the same runqueue as long as there is capacity left.

Yup, that is correct.

> 
>>
>>>
>>>>    All these benchmarks are client-server / messenger-worker oriented and is
>>>>    known to perform better when client-server / messenger-worker are on
>>>>    same CCX (LLC domain).
>>>
>>> I thought hackbench should also be of client-server mode, because hackbench has
>>> socket/pipe mode and exchanges datas between sender/receiver.
>>
>> Yes but its N:M nature makes it slightly complicated to understand where
>> the cache benefits disappear and the work conservation benefits become
>> more prominent.
> 
> The N:M nature of hackbench AFAIU causes N-server *and* M-client tasks to pull each other pretty much randomly, therefore trashing cache locality.
> 
> I'm still unclear about the definition of "work conservation" in this discussion.

In my previous observations, if you can minimize time spent scheduling
the wakee and return back to userspace faster, the benchmark benefited
overall. But then the MM_CID observation goes against this ¯\_(ツ)_/¯
or maybe there is a higher order effect that I might be missing.

> 
>>
>>>
>>> This reminds me of your proposal to provide user hint to the scheduler
>>> to whether do task consolidation vs task spreading, and could this also
>>> be applied to Mathieu's case? For task or task group with "consolidate"
>>> flag set, tasks prefer to be woken up on target/previous CPU if the wakee
>>> fits into that CPU. In this way we could bring benefit and not introduce
>>> regress.
>>
>> I think even a simple WF_SYNC check will help tbench and netperf case.
>> Let me get back to you with some data on different variants of hackbench
>> wit the latest tip.
> 
> AFAIU (to be double-checked) the hackbench workload also has WF_SYNC, which prevents us from using this flag to distinguish between 1:1 server/client and N:M scenarios. Or am I missing something ?

Yup! You are right. My bad.

> 
> Thanks,
> 
> Mathieu
> 
> [1] https://people.ece.ubc.ca/sasha/papers/eurosys16-final29.pdf
> 
 
--
Thanks and Regards,
Prateek
