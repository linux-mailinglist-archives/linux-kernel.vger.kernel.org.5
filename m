Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2CE78F38A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344995AbjHaTro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjHaTrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:47:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D8C1BF
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmGV+7hDJxMKXeUevvURyQ9Msgzutdgrvng3rGxBTHqzFLXgG00dqNTXfkg8vlE3MPBwrOOuvdctop1F3Pw/eviTuuiCG+7Ht5ugTpODMgAHJxwdtbijCZqX4bKNRc6kd3d20YHJI9Jr6wwSuenmY7xsMKef+iYNBEok/0WkAtgSp/qMH49dU1cZR8nkOONGrZXdusCMi7SWNNP3aqZHsv/qbiLyBaC607fK20F5QQoiQjYTsJwLPrcjPKKbRqC60nXVaE0Squve7ZbneJZJWss8R+ns25Llygwnt1K+KiRCIlBAKY4TaFuJuZJ+UBpsUR1QYX/kjw5mtnirg91BhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbZMI847UsNhvjJ2lX1a4LslEiO4Vkzodqygc0iPyME=;
 b=WDgj/j+pbgxoJfJ1p+ERQaPjPVAiiH65Qp957HGb5wWTvL0T1QOn+ajZr3L7kGW2fj5JFKadkY9Qc2kcNUTOn73t+krxY9+7/hTa77L+AFzeqpiiTWqeKfIxuXfCJw5emuN0Yz53IX3QU+QEvI+GW2xqIzpkb9AcGw411PquDmfb7LPfAWuMa848h+5pQZ7GFMuBQstX+ehqmniM+tcLimh/aHlF/ZN6GXUKRbWr2FMc76Fsi+Ri3xNDDUcQToMTWp0z9IEuY8ZvIXkqWg1t7J6zC187j9LP+f48B/H/WA4yBMKLFembpRZw9wi+ImpnmuqV4nUYDEqT6bB1bYeE2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbZMI847UsNhvjJ2lX1a4LslEiO4Vkzodqygc0iPyME=;
 b=x2nUwbzPpkp/v2IQ7sv0WsA+igJU67ZNKliQVocZiWrX6zZ5JIqmfiDOZ8RlP/dgSOGg+NZUSuBUHyP+i8TZ502e1aqU6DkWuBA5rucaUDt0+YBKl7qr3WjjEvzRwBdanC9xhzEFXdwYEtWfq6Ale7DNBWuExnerBePrcuIjMyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 19:47:36 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 19:47:36 +0000
Message-ID: <eb953751-0691-c932-4d53-0e8ab7653bb2@amd.com>
Date:   Fri, 1 Sep 2023 01:17:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH 2/3] sched/fair: Improve integration of SHARED_RUNQ
 feature within newidle_balance
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
 <20230831104508.7619-3-kprateek.nayak@amd.com>
 <20230831184554.GB531917@maniforge>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230831184554.GB531917@maniforge>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::7) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|CYXPR12MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: e47c505a-e9c9-4c68-217e-08dbaa5b2007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: toqDpPc5p8xHj7XihUdUuspyOR9+qLmF0frcRbhivvw6bp1uJ4P/0e7tPpnKSiHWp5twZTKfBesabpHCsulWbqDqLUc3OZ+FI82eO2ONozdwNilzoiVz7hpdCdYVd4I1HSzgMZ/whOenu9PCYPamoRIUquY53L1kZ7YuTZrYfppj/7zqBnORpcjddq2CKNyO+LCiS7tXossux1OjtSkEuaJBm1s4Q1nOGNIITuneOtX10a7UuQWyJGYLyavAsOd1TulcWE6HIa+lnyvcsAQ3gi9Vev2qLxP205IyZ6EI7BvPW4wDPjegk0fnxw/TBZBWvkRXoG4YSdjud402JaQ/7+xIg88DGvsWzHjnHtH2mbODA58Eg4ldT8JHVUQ4CrCp/Y+Pta6cv/dQgsYDQKYzaqnkvS45InObfLveNDK8H+liK/M7S1id9icweVRa3JWIccTK4sNtGCEjjTW533VYoyg4IlY/eRpraNFyVZ8Cbo/atpcQDR9zRwOnVs737mS8Zmil+ItMHj9+UmUeVmwsMRORRmZkVqYboONDBeKNey3FWuTH/y215safh5n5pZdHrmFzE5GzAtswFOppUUe/1cMcOJwQ5KtzxwbhmSSUgRTLpkfXi01MZsI1qX9TwSPAPCkld/zprNIbrnFeE1nEX9C62GQe2IuoXLVGbwEliRZWCo1aI7o1QgELWM6vtGgu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(1800799009)(451199024)(186009)(478600001)(36756003)(31686004)(7416002)(8676002)(83380400001)(86362001)(41300700001)(8936002)(5660300002)(31696002)(4326008)(2616005)(6666004)(53546011)(6486002)(6506007)(26005)(6512007)(66899024)(2906002)(6916009)(966005)(38100700002)(66556008)(66946007)(30864003)(316002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REdDbHowUlFYR1FlTGFoSGxrTkhlZ3N4YTU1MlFaTEllTFZ6WnJJbjFZY0Vl?=
 =?utf-8?B?ejgrZlNaYjYxQzNneitqV3ZheitDOFRTOUwwcS9MZVNjVDZZM25LYXh2eFE0?=
 =?utf-8?B?dWN3dHAyalRDeGJpZ1A5c2JzYVFvNncrbkFVVGRZSUN1aFlBa3l5azBUdTJl?=
 =?utf-8?B?aWs2eWZ1S3dML0xZMG5VQ2RtZ2pibHhiakRidnJ4WnFKRTJVN2QxWDFZTWEy?=
 =?utf-8?B?R0J4alR3YXEwVUNPOVljS1pmbXYxY1dMd3Z6TVJ3RXowZDJTNmJXUzNHeTMv?=
 =?utf-8?B?akxCTUpWUGRoL1ZKNDRvZkU0REhjVS9nTmk0Z3NWTFExdng0TmJxSlVDNm9R?=
 =?utf-8?B?TEgzc3ZuRG8zUlZRNEt0S3VUK3RqNGJ6ZUlwRWw3YVZIN0UyVnBDY0dMazZP?=
 =?utf-8?B?R0wrWGdPcjRNNTJIcm1PS245L2ZwaWwzSmRMYXp4VUhhZjVwcnRseHBuL1da?=
 =?utf-8?B?OTVHT3ZibFdJUmtIMXJTUWVmYnludXQrUXg2UDZXZCtMZ1BmbUsrTjJtOHBO?=
 =?utf-8?B?RHN5a1dSRDV5UFVIQ0pNa28wZmxOdytpNFNSMjdsT3VoTTA2cG1LQ3Jpc2x6?=
 =?utf-8?B?VnkwcEVGTVdiTTlESEpucjUyS09aTDBkbGNUSGs0QjdOTW5TeFEwTVRUb3cy?=
 =?utf-8?B?NGpUeWs1M3hnMzd6UVNSaW53SkJXNmtLbDA4Z3A0Z2hKS3FERW9ETUJPZktU?=
 =?utf-8?B?ZkJaOHo2RVpEVEF1dWQ0a3d1RWZ3UlRTZlNrcUpIYXM0N0h2bVhId04zM0hz?=
 =?utf-8?B?UDViK0w5UGc5dmxmdkhoWmNxeks5d0E4QU45dVBHd2VRYW9FL1ZYVnJESjVz?=
 =?utf-8?B?d1RZZW5MQVI5bUYvbFF3MVdiVVNxMlB5ZVdMaUtSc2VhaUNnWkNVVGJyaXVY?=
 =?utf-8?B?OSs3dzJwdVFuVGFIbzgrSVEydjVJUWI0dTgxZ3JBcVpjYzNlN2VvT2lLUGRC?=
 =?utf-8?B?UzZzTCsrOXZ4cGsxY1JFdzI5YXBRcWRCeGJ4clBqNW44SnJ0Y1I2KzhlR2g2?=
 =?utf-8?B?M0xJRVFKaFNtd0VQUUtZMEZvRk5HQVNja0JjN0hYeUF1Nm9SOHdKNFovZTdN?=
 =?utf-8?B?aTRxMENqYVYxWmtzTkdLeFlEZmxzZ28zNFgxTmFiTnVkSmVXbTU3L1BxRFVn?=
 =?utf-8?B?LzVHNUY5bzJtMTdUd3I2WGNJZkw3Nm1qTnY3MWpNM3owME0rVWh5YmRyOGhj?=
 =?utf-8?B?c1dVQVNqcFpOUWtibGRVZUoxYjBSdGVMeGFGTnNTbE1wQVFRaFpsZ1RtdWtH?=
 =?utf-8?B?a2JRaVFOb3g5WUNIVllBeWJsUzlaZUxoVXJ0RU4rUy9TNGtWSmRJci90a1A1?=
 =?utf-8?B?RDM0UEZ4WjQ1Y2RtMUtVbHpmU1NmQURneEhMeDZnN1JWWmFMN1NIRjNwdXRP?=
 =?utf-8?B?bkhTdi9nWXQ3ZHVBRk1vSG9DVjZiS054SWd4cnBkMzhGWUljRkhhb3BIUTht?=
 =?utf-8?B?VXYrWTh0Z2N6SWxTYzdXMjVza2hCWTJjcVlqbUp1Nlo0Tmc1WUpMRGxscHZG?=
 =?utf-8?B?Sld5SmRsaVkzMDNza0ljSWNUSmdFbCt2KzNMTDVMbmhtVTQvQXhCQk0rZkxZ?=
 =?utf-8?B?WENnRGVsZlZVVU9vcTF3bHh2ODFQUEpEZ2o5ZWI2ZkhrMk9QYVRUSW1VVU5i?=
 =?utf-8?B?UFNUWEphZ3psS29WOVBacW8rbVU2SW56RjVRY3d2MTQ1eGNKMlBwNVRON0Ra?=
 =?utf-8?B?dmRZVVA5TDNzTjhSbi8zYmpHTjYxNy92YThaZmNHZHp4MHp2SExveFdvaUFK?=
 =?utf-8?B?TnhPUmMwWTFLTU9mSjVmQ2RFOWtrcFYzRENGRkhwK0Y1eWxEeHRoQW5WZ2VJ?=
 =?utf-8?B?T01ZKzQyZm56V2s2ODQvVkJtK3lPc0w0MHlMSEo1OUFNWXVPalFTVjFyT01L?=
 =?utf-8?B?UHJ6bEdNbVBFd094cy9KV2h3SDJnLzVKYmIwQU82Q01ZcEJlNTI5L0xWZXo1?=
 =?utf-8?B?RHlRRlJFR0FHSkgwNnJ4eDlYRnFoMTBsciswVWdEVTlUSHV6aU9qSzk5Mk5E?=
 =?utf-8?B?VytQS0NXQkZMdERzMzVJb2JxOHIySVdoNWpmd3hIY01qYnNVSit4cnZ3SWsv?=
 =?utf-8?B?cWJiNjJVbmhqcndDYm5qb1VyWDRBdTBjQTl6OHp5U0pnZWVJeTM4aDVFSVND?=
 =?utf-8?Q?B7A0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47c505a-e9c9-4c68-217e-08dbaa5b2007
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 19:47:36.2830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4Ywjpd8aYazhLXTIl1zHIYfqpxphgKtQd7RQWb9/YIU3fQetu7eMoL4586LKtG6JOhq2jSiuzM5gWn9dROZZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9385
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

Thank you for taking a look at this despite being on vacation.

On 9/1/2023 12:15 AM, David Vernet wrote:
> On Thu, Aug 31, 2023 at 04:15:07PM +0530, K Prateek Nayak wrote:
>> This patch takes the relevant optimizations from [1] in
>> newidle_balance(). Following is the breakdown:
> 
> Thanks for working on this. I think the fix you added for skipping <=
> LLC domains makes sense. The others possibly as well

I too am in doubt with some of them but I left them in since I was
building on top of the cumulative diff.

> -- left some
> comments below!
> 
>>
>> - Check "rq->rd->overload" before jumping into newidle_balance, even
>>   with SHARED_RQ feat enabled.
> 
> Out of curiosity -- did you observe this making a material difference in
> your tests? After thinking about it some more, though I see the argument
> for why it would be logical to check if we're overloaded, I'm still
> thinking that it's more ideal to just always check the SHARED_RUNQ.
> rd->overload is only set in find_busiest_group() when we load balance,
> so I worry that having SHARED_RUNQ follow rd->overload may just end up
> making it redundant with normal load balancing in many cases.
> 
> So yeah, while I certainly understand the idea (and would like to better
> understand what kind of difference it made in your tests), I still feel
> pretty strongly that SHARED_RUNQ makes the most sense as a feature when
> it ignores all of these heuristics and just tries to maximize work
> conservation.
> 
> What do you think?

Actually, as it turns out, it was probably a combination of the
rq->avg_idle check + updating of cost that got the performance back
during experimenting. In Patch 3, I've give the results with this patch
alone and it makes no difference, for tbench 128-client at least. There
is the same rq lock contention I mentioned previously which is why the
per-shard "overload" flag.

Based on Anna-Maria's observation in [1], we have a short idling, spread
across the system with tbench. Now it is possible we are doing a
newidle_balance() when it would have been better off to let the CPU idle
for that short duration without and not cause a contention for the rq
lock.

[1] https://lore.kernel.org/lkml/80956e8f-761e-b74-1c7a-3966f9e8d934@linutronix.de/

> 
>> - Call update_next_balance() for all the domains till MC Domain in
>>   when SHARED_RQ path is taken.
> 
> I _think_ this makes sense. Though even in this case, I feel that it may
> be slightly confusing and/or incorrect to push back the balance time
> just because we didn't find a task in our current CCX's shared_runq.
> Maybe we should avoid mucking with load balancing? Not sure, but I am
> leaning towards what you're proposing here as a better approach.

This requires a deeper look and more testing yes.

> 
>> - Account cost from shared_runq_pick_next_task() and update
>>   curr_cost and sd->max_newidle_lb_cost accordingly.
> 
> Yep, I think this is the correct thing to do.
> 
>>
>> - Move the initial rq_unpin_lock() logic around. Also, the caller of
>>   shared_runq_pick_next_task() is responsible for calling
>>   rq_repin_lock() if the return value is non zero. (Needs to be verified
>>   everything is right with LOCKDEP)
> 
> Still need to think more about this, but it's purely just tactical and
> can easily be fixed it we need.

I agree. I'll leave the full picture of this below in
[Locking code movement clarifications] since we seem to keep coming back
to this and it would be good to have more eyes on what is going on in my
mind :)

> 
>>
>> - Includes a fix to skip directly above the LLC domain when calling the
>>   load_balance() in newidle_balance()
> 
> Big fix, thanks again for noticing it.
> 
>> All other surgery from [1] has been removed.
>>
>> Link: https://lore.kernel.org/all/31aeb639-1d66-2d12-1673-c19fed0ab33a@amd.com/ [1]
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> ---
>>  kernel/sched/fair.c | 94 ++++++++++++++++++++++++++++++++-------------
>>  1 file changed, 67 insertions(+), 27 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index bf844ffa79c2..446ffdad49e1 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -337,7 +337,6 @@ static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
>>  		rq_unpin_lock(rq, &src_rf);
>>  		raw_spin_unlock_irqrestore(&p->pi_lock, src_rf.flags);
>>  	}
>> -	rq_repin_lock(rq, rf);
>>  
>>  	return ret;
>>  }
>> @@ -12276,50 +12275,83 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>>  	if (!cpu_active(this_cpu))
>>  		return 0;
>>  
>> -	if (sched_feat(SHARED_RUNQ)) {
>> -		pulled_task = shared_runq_pick_next_task(this_rq, rf);
>> -		if (pulled_task)
>> -			return pulled_task;
>> -	}
>> -
>>  	/*
>>  	 * We must set idle_stamp _before_ calling idle_balance(), such that we
>>  	 * measure the duration of idle_balance() as idle time.
>>  	 */
>>  	this_rq->idle_stamp = rq_clock(this_rq);
>>  
>> -	/*
>> -	 * This is OK, because current is on_cpu, which avoids it being picked
>> -	 * for load-balance and preemption/IRQs are still disabled avoiding
>> -	 * further scheduler activity on it and we're being very careful to
>> -	 * re-start the picking loop.
>> -	 */
>> -	rq_unpin_lock(this_rq, rf);
>> -
>>  	rcu_read_lock();
>> -	sd = rcu_dereference_check_sched_domain(this_rq->sd);
>> -
>> -	/*
>> -	 * Skip <= LLC domains as they likely won't have any tasks if the
>> -	 * shared runq is empty.
>> -	 */
>> -	if (sched_feat(SHARED_RUNQ)) {
>> +	if (sched_feat(SHARED_RUNQ))
>>  		sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>> -		if (likely(sd))
>> -			sd = sd->parent;
>> -	}
>> +	else
>> +		sd = rcu_dereference_check_sched_domain(this_rq->sd);
>>  
>>  	if (!READ_ONCE(this_rq->rd->overload) ||
>> -	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
>> +	    /* Look at rq->avg_idle iff SHARED_RUNQ is disabled */
>> +	    (!sched_feat(SHARED_RUNQ) && sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
>>  
>> -		if (sd)
>> +		while (sd) {
>>  			update_next_balance(sd, &next_balance);
>> +			sd = sd->child;
>> +		}
>> +
>>  		rcu_read_unlock();
>>  
>>  		goto out;
>>  	}
>> +
>> +	if (sched_feat(SHARED_RUNQ)) {
>> +		struct sched_domain *tmp = sd;
>> +
>> +		t0 = sched_clock_cpu(this_cpu);
>> +
>> +		/* Do update_next_balance() for all domains within LLC */
>> +		while (tmp) {
>> +			update_next_balance(tmp, &next_balance);
>> +			tmp = tmp->child;
>> +		}
>> +
>> +		pulled_task = shared_runq_pick_next_task(this_rq, rf);
>> +		if (pulled_task) {
>> +			if (sd) {
>> +				curr_cost = sched_clock_cpu(this_cpu) - t0;
>> +				/*
>> +				 * Will help bail out of scans of higer domains
>> +				 * slightly earlier.
>> +				 */
>> +				update_newidle_cost(sd, curr_cost);
>> +			}
>> +
>> +			rcu_read_unlock();
>> +			goto out_swq;
>> +		}
>> +
>> +		if (sd) {
>> +			t1 = sched_clock_cpu(this_cpu);
>> +			curr_cost += t1 - t0;
>> +			update_newidle_cost(sd, curr_cost);
>> +		}
>> +
>> +		/*
>> +		 * Since shared_runq_pick_next_task() can take a while
>> +		 * check if the CPU was targetted for a wakeup in the
>> +		 * meantime.
>> +		 */
>> +		if (this_rq->ttwu_pending) {
>> +			rcu_read_unlock();
>> +			return 0;
>> +		}
> 
> At first I was wondering whether we should do this above
> update_newidle_cost(), but I think it makes sense to always call
> update_newidle_cost() after we've failed to get a task from
> shared_runq_pick_next_task().

Indeed. I think the cost might be useful to be accounted for.

> 
>> +	}
>>  	rcu_read_unlock();
>>  
>> +	/*
>> +	 * This is OK, because current is on_cpu, which avoids it being picked
>> +	 * for load-balance and preemption/IRQs are still disabled avoiding
>> +	 * further scheduler activity on it and we're being very careful to
>> +	 * re-start the picking loop.
>> +	 */
>> +	rq_unpin_lock(this_rq, rf);
> 
> Don't you need to do this before you exit on the rq->ttwu_pending path?

[Locking code movement clarifications]

Okay this is where I'll put all the locking bits I have in my head:

o First, the removal of rq_repin_lock() in shared_runq_pick_next_task()

  Since this is only called from newidle_balance(), it is easy to
  isolate the changes. shared_runq_pick_next_task() can return either
  0, 1 or -1. The interpretation is same as return value of
  newidle_balance():

   0: Unsuccessful at pulling task but the rq lock was never released
      and reacquired - it was held all the time.

   1: Task was pulled successfully. The rq lock was released and
      reacquired in the process but now, with the above changes, it is
      not pinned.

  -1: Unsuccessful at pulling task but the rq lock was released and
      reacquired in the process and now, with the above changes, it is
      not pinned.

  Now the following block:

	pulled_task = shared_runq_pick_next_task(this_rq, rf);
	if (pulled_task) {
		...
		goto out_swq;
	}

  takes care of the case where return values are -1, or 1. The "out_swq"
  label is almost towards the end of newidle_balance() and just before
  returning, the newidle_balance() does:

	rq_repin_lock(this_rq, rf);

  So this path will repin the lock.

  Now for the case where shared_runq_pick_next_task() return 0.

o Which brings us to the question you asked above

  newidle_balance() is called with the rq lock held and pinned, and it
  expects the same when newidle_balance() reruns. The very first bailout
  check in newidle_balance() is:

	if (this_rq->ttwu_pending)
		return 0;

  so we return without doing any changed to the state of rq lock.

  Coming to the above changes, if we have to hit the ttwu_pending
  bailout you pointed at, shared_runq_pick_next_task() should return 0,
  signifying no modification to state of the lock or pinning. Then we
  update the cost, and come to ttwu_pending check. We still have the
  lock held, and it is pinned. Thus we do not need to unpin the lock
  since we newidle_balance() is expected to return with lock held and
  it being pinned.

Please let me know if I've missed something.

> 
>>  	raw_spin_rq_unlock(this_rq);
>>  
>>  	t0 = sched_clock_cpu(this_cpu);
>> @@ -12335,6 +12367,13 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>>  		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
>>  			break;
>>  
>> +		/*
>> +		 * Skip <= LLC domains as they likely won't have any tasks if the
>> +		 * shared runq is empty.
>> +		 */
>> +		if (sched_feat(SHARED_RUNQ) && (sd->flags & SD_SHARE_PKG_RESOURCES))
>> +			continue;
>> +
>>  		if (sd->flags & SD_BALANCE_NEWIDLE) {
>>  
>>  			pulled_task = load_balance(this_cpu, this_rq,
>> @@ -12361,6 +12400,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>>  
>>  	raw_spin_rq_lock(this_rq);
>>  
>> +out_swq:
>>  	if (curr_cost > this_rq->max_idle_balance_cost)
>>  		this_rq->max_idle_balance_cost = curr_cost;
>>  
> 
> 
> Thanks,
> David
 
--
Thanks and Regards,
Prateek
