Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654BB78E522
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 05:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343815AbjHaDsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 23:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjHaDsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 23:48:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57573CC2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 20:48:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnyWRy1nXJRkJRcBLtYGcFc2bRu10Pfrz5SJUYY6o50JakaZ3jwAYl+ePGZVWa7ULxFVOMaxBDtocK9oqhV9V/o2XpGEAG8X/qLklX8z94CHjuojrNcN7t4GEB+6NFDdosxQaNbhEOzQwBtUToTfhNcTJL6krXfIr4ECkBY2Ysl9A9DYmcxEKhnKa8AZyywIrAeE+p+6oNOUzS0kgQjTw1E2UVOvU7h3usqP83gvDdy0+QmLnqs4kXWXIt2oOs8UF07lO1vkKYv9HFvliNKHYjCTZVTKLNZ07gjEqRMP7rUcw8heAHcnU2ox6IKVMajJVGqt2HhmJdq4LlOs6PknRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUZ4IwY5nlgJ8DYXGd56h+ZrAyr36faz5JWZmzL7LhI=;
 b=gTv7oKthHyBreRvZYWf96r2eXGTlTF/Nf6Kq3za5241xTKiqDH7C2uTaJRD56rlAmqgwrJ/Mo+JYBoxae543x3VEPZFvJ8fR58On77dd6NcA8/X6h3QH0bROa0e5QzWvI/iwdcfZJNvWIac0nd/sUtgTHz7It8O4pjE/kaNqF7i8lB0qwtW1WgV8Qtnvv0qszXsQUNmUN92/z49z3XaxcsiE7exPKCXj9r0nSOs52qQzhOzGIyqyZ2XylMFD4oZ2sFCDWXQJUP40g7Ly9X7uGe5PfRVrglODx1YAjEgn0TBRcCQ0zp35kOnIsLhkb0HT1K7Zbz05RSLfUpBAjLkVpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUZ4IwY5nlgJ8DYXGd56h+ZrAyr36faz5JWZmzL7LhI=;
 b=hJKtYO7QVM8vjB+WUP5g6DV1LFZd4yoji65v7HZaPD8GMXxLDrXcePds7f3Q3tbdR66GDSsr5t1rssjMwr8a+CW8C3S7RujXSOdDeRrPfbVhJbn1CDcc6MMKfXhEmbOqXUM9xVqpxt0GvJNKJDQi3IltP0tkXOQj7OdSvtFqKn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by IA1PR12MB8310.namprd12.prod.outlook.com (2603:10b6:208:3ff::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 03:48:09 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 03:48:09 +0000
Message-ID: <a3710be8-c896-f997-c856-38966459edc2@amd.com>
Date:   Thu, 31 Aug 2023 09:17:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 6/7] sched: Implement shared runqueue in CFS
Content-Language: en-US
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        aaron.lu@intel.com, wuyun.abel@bytedance.com, kernel-team@meta.com
References: <20230809221218.163894-1-void@manifault.com>
 <20230809221218.163894-7-void@manifault.com>
 <3e32bec6-5e59-c66a-7676-7d15df2c961c@amd.com>
 <20230831013435.GB506447@maniforge>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230831013435.GB506447@maniforge>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::15) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|IA1PR12MB8310:EE_
X-MS-Office365-Filtering-Correlation-Id: a328eb76-e8ea-45d7-382b-08dba9d516e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H6iVdfdAFFtHvRikoc0qx6jSq5RYdrj1xLitcr81PnCA02or3fsW2RtcBQZXB6V0exIC8x9OnGYJxVXbkGBNnxBNVcJfXN7JIkkX6dAL1ezJx6jZl5pfC2u93WbZFwR6tpqzLiwkee5F6y1ka9RCTUvWpJlfao1smYEeZYCuv9ipFtzST/4t1ccECIiDYp44XZSVT2+YI8vYENPxbJ0zR/bw28zMQKvPpO95tGk64UcVpI3uzCdDidxYItIVxKP5XUKxPfs2A+mV40OKuJWdXfOkl/XE/QAzerX+T2heJWOSJ+o0zk7YT5L5nTL36opAm2/zTx6/oXrZgS4XDv9+SGncHnlI7HstX4AWKCwI/OZJPuoDtE6yyCBhflQUiBiM8NGR6MVCB+UG6siXCCjwNARhl7YPKv8HrgM+ZFu8BDDuAhzquqbrlYFkA66+I06BNd5JkM6k8jD4DL/VUNwf8cI/lAQ5AkMuCcnUMNl31TO6IzaMV6AQGQCLb3hB2AgcPWYoh8JbUidfXXrrKFlNwV/5U2VySXH2Q+zNFhnbAFW3l9UZUAES9vPK+KoouI6+F5EvAPkM9ivK1Axved+d+4ofKGqD6m5K2S/6iASyiMzeny2D5SVOi6Xg1cryN8/sgWNddSfIcPdrapdjf1wKMEdfzX5B7NOzl+A+9nvUK7zbtMXFclvlGOLbgive/qqS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(39860400002)(366004)(186009)(451199024)(1800799009)(36756003)(31686004)(4326008)(83380400001)(41300700001)(86362001)(31696002)(7416002)(8676002)(8936002)(5660300002)(53546011)(26005)(6506007)(6486002)(6666004)(6512007)(2616005)(966005)(478600001)(38100700002)(66556008)(2906002)(66476007)(66946007)(6916009)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzJXbkhtSWQ0b1FQQ2ZrR2lWNWJCamdJTGo0WlcwaDM2OWlyeGY3NzVQd2hh?=
 =?utf-8?B?Y3FLNjAyYTdiUDNRV1QzRDdEMEx6akM2SUs4R1kyQ1ArUlJ1aDlVaDc4ZGdq?=
 =?utf-8?B?VllHUGlLYnNoU25Sb3I0UHhNRFJFVVZFQm1zVkJjMHg1cjdsazh5cFRzdkFL?=
 =?utf-8?B?NDBDOGw4UVhCT0FwTmRNSWloY0RKdXRZWlNhT29XYUFha0grZXd2MVJ5WjBn?=
 =?utf-8?B?NnFFWi9XK3haL0NwQ3V1M3c4Tm9MSzZzc2J0djVLZUJaR3VkQmtPVWwrb2lw?=
 =?utf-8?B?Nit2UjJlOEtTWjZYUThBVHpXbWJQMGcrc2dicnh4WXBmUUxJc0c3aEwyV3Y4?=
 =?utf-8?B?TElUUm1FSnhua01HdTMwYzdCZTJCblhWRWxNUk5NQlNhSFdTWFN4TkgvR1J0?=
 =?utf-8?B?QmdDVHk4RFJzTFJEZmhjVlNhQXRuVEZvTDJuQ0RNYnE2SHpkdDU4bU9aOEdF?=
 =?utf-8?B?OW1RS2FqTWticE5VZVE2QnphU3NrZ3B4bFFDYng5bk1CTStudTFMTmk5S3dF?=
 =?utf-8?B?Z1B6NDhDOHhjQmZIV2ZKU3RMMjZxVi9OUlhnUUk4T1MxQ0RTVGw2b2I2UUxi?=
 =?utf-8?B?eXNNT2lvNVBnUGt2WWd4ancrZ1EwTlh2U1B1ZG16WVpXN1o3N0J5TkpRTlpM?=
 =?utf-8?B?SnF2MUhPYm9HRmRlR01UcTJURllzc3oyMDJtcUlKcTI4Z3hmcEYxSUVJckVV?=
 =?utf-8?B?NlhxaE1FcnlhV3VUMllVK1J4dTZwM09PdEFCdjBwd1lGNjBId2JrTWg5aXNq?=
 =?utf-8?B?UDkvRk96V29FSDlBK1ZhTVFaTllrb0R0S1lCY3grM2JuSGwyelJkUEs2anZ2?=
 =?utf-8?B?L01mdDNicHpIdENMZkVzREI3QmpVelpoS1lJK2J0RWtDYVlCTHJRTW5mQ3BF?=
 =?utf-8?B?TWtUWUo1ZmhNaStTMWl6NnRKVGRYQjJhYWRwanpLdElJSE91TGlTRWoxY25r?=
 =?utf-8?B?MnB6b3FLSEtzaTJ0NHNJaXZFWk8yN3cxN2dpUzdLbVdOSFpwN1ZmU01BZ0p0?=
 =?utf-8?B?c1RVaWNSZ1ZmdGNwSUUwNWM4c1dPZzN2VlpreWpsR2piaUE4TkpJQ3ZNYjB6?=
 =?utf-8?B?eHNvMXVoNS9KZ2hqcjBLWGRYUUJxWkwxdUFUN1k0V0JiOThvUEVZbnJjVWN5?=
 =?utf-8?B?VVZSZDdCN0YwbWw2UTJJZExqakd1MGxxODVad1dUcGdxaUdYd3FMZFFQNkhr?=
 =?utf-8?B?NkVLTFFsOTJHZXEzUUk4N2JCZGJ3ODhOUmYwcU95R2pBdXFXdlVTK2VCdUND?=
 =?utf-8?B?ZHNCNkRnZkxJYnJsRExDYldBWjJaMTU1R29yallVa3AzMTZibWpzT21YdExW?=
 =?utf-8?B?akJxWVpHcXJiRTFsSys4cVNWYko2UzZiN3VGVTJJT3BINTlSWTJ0VmZYaHNJ?=
 =?utf-8?B?bjJPWWJaY2dDTUdLZlVNR296M1I0aUo1aVpOalFOR0lQOVZUdTNjQVorVXpq?=
 =?utf-8?B?eCtuOHA1ZU5sZjFnSkhUOFhzWlFvZVRlZXNOTThTWk83bjlNODZTRHIzd20v?=
 =?utf-8?B?bWdtckd3TkVtMmVadzZCcmN2QTN6ZFlPWTlPbVdpME95WlVxKzBuK3drdVgz?=
 =?utf-8?B?UnpFK0xaeTJCSFhnREowWWFBdjNFdThKRnZXeCsrSndOakdKL290VVYzWmYx?=
 =?utf-8?B?eWM2SEJRcXNhLzN0eVI5NGtEUUJwdHY0TWJmZ2J2YlBxRFlENXByckcxVTVy?=
 =?utf-8?B?a1JtNm04UXYwcFZ4TzFIS0Z0TlJ1RmJIYjlMc1hPOXRZTVFUa2hydGFnYmdj?=
 =?utf-8?B?eVdGanVzSWZ1R3ZodzJBTTJZRXpCTjZUdTRmcWg5MjV2KzloS0czRERhdFVm?=
 =?utf-8?B?SFU5aE9PVURsTVpYSnNWWWFhTkhuSHNybzE5Z1ZQU0VJNzhNa21lUnpXUDIz?=
 =?utf-8?B?RElMWTk4Tmh5KzFuUW1rZlg3b3NDZndyWjF5S0dqWTQvV0JIT3F3L3UybHRm?=
 =?utf-8?B?djdvTkZha1lWMkxkUHQ4bTVLdExYYVVWNnhUUlBGN2NadzRIZHZsTUtlYTBF?=
 =?utf-8?B?L3NHNXpkdkZBUmxNRnpFcmJjZjE2L241c0tNMGpVWnh4Y1RTVGVOclBxQTZC?=
 =?utf-8?B?YmFFYnFVa0RER3BhTFQ0SnFVTXJ2T0JRUFhJNG9CQTB3aWs5Mk5yRFlNS2VZ?=
 =?utf-8?Q?HrNlO0eu0TIeQJB9jAlA9ZZwz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a328eb76-e8ea-45d7-382b-08dba9d516e2
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 03:48:08.9878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGbjQvgBRBKxrvouwUvIHxaKdKRG9w/7qChWiHvDp+bFa3PmSKAPboduRg7cXJ0Q7ym7QRdpqndn2KVRbYgatw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8310
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        LOTS_OF_MONEY,MONEY_NOHTML,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On 8/31/2023 7:04 AM, David Vernet wrote:
> On Wed, Aug 30, 2023 at 12:16:17PM +0530, K Prateek Nayak wrote:
>> Hello David,
> 
> Hello Prateek,
> 
>>
>> On 8/10/2023 3:42 AM, David Vernet wrote:
>>> [..snip..]
>>> +	if (p && is_cpu_allowed(p, cpu_of(rq)))
>>> +		list_del_init(&p->shared_runq_node);
>>
>> I wonder if we should remove the task from the list if
>> "is_cpu_allowed()" return false.
>>
>> Consider the following scenario: A task that does not sleep, is pinned
>> to single CPU. Since this is now at the head of the list, and cannot be
>> moved, we leave it there, but since the task also never sleeps, it'll
>> stay there, thus preventing the queue from doing its job.
> 
> Hmm, sorry, I may not be understanding your suggestion. If a task was
> pinned to a single CPU, it would be dequeued from the shared_runq before
> being pinned (see __set_cpus_allowed_ptr_locked()), and then would not
> be added back to the shard in shared_runq_enqueue_task() because of
> p->nr_cpus_allowed == 1. The task would also be dequeued from the shard
> before it started running (unless I'm misunderstanding what you mean by
> "a task that does not sleep"). Please let me know if I'm missing
> something.

Ah! My bad. Completely missed that. Thank you for clarifying.

> 
>> Further implication ...  
>>
>>> +	else
>>> +		p = NULL;
>>> +	raw_spin_unlock(&shared_runq->lock);
>>> +
>>> +	return p;
>>> +}
>>> +
>>> +static void shared_runq_push_task(struct rq *rq, struct task_struct *p)
>>> +{
>>> +	struct shared_runq *shared_runq;
>>> +
>>> +	shared_runq = rq_shared_runq(rq);
>>> +	raw_spin_lock(&shared_runq->lock);
>>> +	list_add_tail(&p->shared_runq_node, &shared_runq->list);
>>> +	raw_spin_unlock(&shared_runq->lock);
>>> +}
>>>  
>>>  static void shared_runq_enqueue_task(struct rq *rq, struct task_struct *p)
>>> -{}
>>> +{
>>> +	/*
>>> +	 * Only enqueue the task in the shared runqueue if:
>>> +	 *
>>> +	 * - SHARED_RUNQ is enabled
>>> +	 * - The task isn't pinned to a specific CPU
>>> +	 */
>>> +	if (p->nr_cpus_allowed == 1)
>>> +		return;
>>> +
>>> +	shared_runq_push_task(rq, p);
>>> +}
>>>  
>>>  static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
>>>  {
>>> -	return 0;
>>> +	struct task_struct *p = NULL;
>>> +	struct rq *src_rq;
>>> +	struct rq_flags src_rf;
>>> +	int ret = -1;
>>> +
>>> +	p = shared_runq_pop_task(rq);
>>> +	if (!p)
>>> +		return 0;
>>
>> ...
>>
>> Since we return 0 here in such a scenario, we'll take the old
>> newidle_balance() path but ...
>>
>>> +
>>> +	rq_unpin_lock(rq, rf);
>>> +	raw_spin_rq_unlock(rq);
>>> +
>>> +	src_rq = task_rq_lock(p, &src_rf);
>>> +
>>> +	if (task_on_rq_queued(p) && !task_on_cpu(src_rq, p)) {
>>> +		update_rq_clock(src_rq);
>>> +		src_rq = move_queued_task(src_rq, &src_rf, p, cpu_of(rq));
>>> +		ret = 1;
>>> +	}
>>> +
>>> +	if (src_rq != rq) {
>>> +		task_rq_unlock(src_rq, p, &src_rf);
>>> +		raw_spin_rq_lock(rq);
>>> +	} else {
>>> +		rq_unpin_lock(rq, &src_rf);
>>> +		raw_spin_unlock_irqrestore(&p->pi_lock, src_rf.flags);
>>> +	}
>>> +	rq_repin_lock(rq, rf);
>>> +
>>> +	return ret;
>>>  }
>>>  
>>>  static void shared_runq_dequeue_task(struct task_struct *p)
>>> -{}
>>> +{
>>> +	struct shared_runq *shared_runq;
>>> +
>>> +	if (!list_empty(&p->shared_runq_node)) {
>>> +		shared_runq = rq_shared_runq(task_rq(p));
>>> +		raw_spin_lock(&shared_runq->lock);
>>> +		/*
>>> +		 * Need to double-check for the list being empty to avoid
>>> +		 * racing with the list being drained on the domain recreation
>>> +		 * or SHARED_RUNQ feature enable / disable path.
>>> +		 */
>>> +		if (likely(!list_empty(&p->shared_runq_node)))
>>> +			list_del_init(&p->shared_runq_node);
>>> +		raw_spin_unlock(&shared_runq->lock);
>>> +	}
>>> +}
>>>  
>>>  /*
>>>   * For asym packing, by default the lower numbered CPU has higher priority.
>>> @@ -12093,6 +12308,16 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>>>  	rcu_read_lock();
>>>  	sd = rcu_dereference_check_sched_domain(this_rq->sd);
>>>  
>>> +	/*
>>> +	 * Skip <= LLC domains as they likely won't have any tasks if the
>>> +	 * shared runq is empty.
>>> +	 */
>>
>> ... now we skip all the way ahead of MC domain, overlooking any
>> imbalance that might still exist within the SMT and MC groups
>> since shared runq is not exactly empty.
>>
>> Let me know if I've got something wrong!
> 
> Yep, I mentioned this to Gautham as well in [0].
> 
> [0]: https://lore.kernel.org/all/20230818050355.GA5718@maniforge/
> 
> I agree that I think we should remove this heuristic from v4. Either
> that, or add logic to iterate over the shared_runq until a viable task
> is found.
> 
>>
>>> +	if (sched_feat(SHARED_RUNQ)) {
>>> +		sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>>> +		if (likely(sd))
>>> +			sd = sd->parent;
>>> +	}
>>
>> Speaking of skipping ahead of MC domain, I don't think this actually
>> works since the domain traversal uses the "for_each_domain" macro
>> which is defined as:
> 
> *blinks*
> 
> Uhhh, yeah, wow. Good catch!
> 
>> #define for_each_domain(cpu, __sd) \
>> 	for (__sd = rcu_dereference_check_sched_domain(cpu_rq(cpu)->sd); \
>> 			__sd; __sd = __sd->parent)
>>
>> The traversal starts from rq->sd overwriting your initialized value
>> here. This is why we see "load_balance count on cpu newly idle" in
>> Gautham's first report
>> (https://lore.kernel.org/lkml/ZN3dW5Gvcb0LFWjs@BLR-5CG11610CF.amd.com/)
>> to be non-zero.
>>
>> One way to do this would be as follows:
>>
>> static int newidle_balance() {
>>
>> 	...
>> 	for_each_domain(this_cpu, sd) {
>>
>> 		...
>> 		/* Skip balancing until LLc domain */
>> 		if (sched_feat(SHARED_RUNQ) &&
>> 		    (sd->flags & SD_SHARE_PKG_RESOURCES))
>> 			continue;
>>
>> 		...
>> 	}
>> 	...
>> }
> 
> Yep, I think this makes sense to do.
> 
>> With this I see the newidle balance count for SMT and MC domain
>> to be zero:
> 
> And indeed, I think this was the intention. Thanks again for catching
> this. I'm excited to try this out when running benchmarks for v4.
> 
>> < ----------------------------------------  Category:  newidle (SMT)  ---------------------------------------- >
>> load_balance cnt on cpu newly idle                         :          0    $      0.000 $    [    0.00000 ]
>> --
>> < ----------------------------------------  Category:  newidle (MC)   ---------------------------------------- >
>> load_balance cnt on cpu newly idle                         :          0    $      0.000 $    [    0.00000 ]
>> --
>> < ----------------------------------------  Category:  newidle (DIE)  ---------------------------------------- >
>> load_balance cnt on cpu newly idle                         :       2170    $      9.319 $    [   17.42832 ]
>> --
>> < ----------------------------------------  Category:  newidle (NUMA) ---------------------------------------- >
>> load_balance cnt on cpu newly idle                         :         30    $    674.067 $    [    0.24094 ]
>> --
>>
>> Let me know if I'm missing something here :)
> 
> No, I think you're correct, we should be doing this. Assuming we want to
> keep this heuristic, I think the block above is also correct so that we
> properly account sd->max_newidle_lb_cost and rq->next_balance. Does that
> make sense to you too?

Yup, that makes sense!

> 
>>
>> Note: The lb counts for DIE and NUMA are down since I'm experimenting
>> with the implementation currently. I'll update of any new findings on
>> the thread.
> 
> Ack, thank you for doing that.
> 
> Just FYI, I'll be on vacation for about 1.5 weeks starting tomorrow
> afternoon. If I'm slow to respond, that's why.

Enjoy your vacation :)

I'll keep experimenting meanwhile and update the report in the
parallel thread.

> 
> Thanks,
> David

--
Thanks and Regards,
Prateek
