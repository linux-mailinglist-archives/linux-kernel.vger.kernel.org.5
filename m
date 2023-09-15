Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F977A1477
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 05:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjIODhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 23:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjIODht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 23:37:49 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E968270C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:37:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUgSRu+yejJjpKdQXgD4loBRu+31HeNZvjRVTZYqEA4kJtGyWqtEO/lBLRbaODTYpU4KDwJXMl39T2ObxICbDmK7KfxHr6rcVExNvpP90Kc9JrbYBEHMyvfERYYo4N2x2PzaJHnrtQR9FVG4eQWfqmTEFBWi0eiZ+NszxQCzc4j1BrWkdZ2hH3Kt7f1JVqY7fmAhbKKVRftuJMmTppFihxbbugoBGXNz/Vy2Ld3mq2O1IWBXxPMKcxfQdGHz1EJXh13uLF7CrmkAv78Q2kMJylHSCSMygRDBo153bEuGu/EiKw6CAILfHqPyu+aluBuFpoUIjQ5NXf9G1fv7i2fPWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsMiaopSk97AAP9ssKnPDBSjDQzfJAaOKx1k41gQ8L8=;
 b=MTPStgJx47Tti4lmIFxp/S2MsmCFrBhGlUHEZjPt3zmEtkEh+/Izf93K/LWCXV/QMT4WZsj3PLZxWztIDGMTjef3s8wVDGKcmWb2lxA+QS56obodnVLcIo+1+NS6CgrMG4xzOEyOdTty6a4EFxSU/u+IHLUor5CQjyRx1wBrQbmpOX7/BZ+vzSmYw3f1j30Sx4AFFRlJftPSZwSGLYHLHKY4856LUroPmNwp+6hnzKmpqzaaN2cKIYLEzV9WXm5b47l9y+hnZtK6kkDKdhMKo36jmoUsV5BsaBMwmLOC7ds0tyK0n214HDfdsN0SoSz/55zbgyx31ouyACuGwecWUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsMiaopSk97AAP9ssKnPDBSjDQzfJAaOKx1k41gQ8L8=;
 b=fViuAHYp+GIIqSVSaF7db4xqvZ+5WA3AW7tnbeQbMfW8rBLolCrKPoGAfwg169cm6w5y7AdRFjmkXeYvbW0G8W/e5IarjQoQYosdbAnterd1Gr5PWLc4fReRmYuv+0q7864HXsCqAfWg3mzzwWiN3WU1phKrLOGfv8+pUVbDIYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 15 Sep
 2023 03:37:40 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6768.036; Fri, 15 Sep 2023
 03:37:40 +0000
Message-ID: <ef708d06-5fa5-9931-59ed-924caf3148c8@amd.com>
Date:   Fri, 15 Sep 2023 09:07:24 +0530
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
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
 <09a7a5cb-dde5-122e-a086-5802df993433@amd.com>
 <ZQLjtV9TbM2KFGsF@chenyu5-mobl2.ccr.corp.intel.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZQLjtV9TbM2KFGsF@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::19) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|PH8PR12MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bdb99a2-0f09-4525-6184-08dbb59d1c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rIJK0wW5l+0hAHws8bEDtLF0+yjtODajbpcRMEy0qRg73RuBAZwuqhNZMfouGc2wg643hCxP9XSQBcc94UYdvQ72sLfu/fiD0Gd9cw/GmWbpJUZk4SZFwZoJ7fBRaWn1KhNCqqIV/xl/Yn/xAH4v9gUCFdwKq7N5esbePh6f+Q6UOidB8I44wfOIIUqPkqosfslXNSs0mgRvbi657iLka6orsrs0L9nAEGv1+YCT9dDPQ0CcSLr7JwnP8MMaIXw9nt26EMWGzi3EBa/Hd53bY0pPEtTlchcOjoGhfp5nJ6q/DcvmQjL8vXJVCTgCYBYcFzqCOrcb+sApNzE3Udi7H9uwKpl0mov1NM+4sD2R7gCgdu4Z3bIdrbgscyXrf9w7AuNvz19SWxAimQGtw4PZDv8oq80f6uSzF1cOzczCjejcmgwr9twoNZFOVCV4bv0KDVBpI0T+MDCDJPFxjCO0TaL6Yb+VEwsncQFTt3oaQ631+nVOJgqYPVInoEkIPSlZ3c4ZrZyzC/odqGu6ZZP9JBJFPy8pWLOhBjVgKr9YFZir1JqhzjWgBCkzNUN6AUqRdU8up57n/GOHb2Wu8Pqtsl1+wqpofBkJ2LQ6KKFkHoTvBe+AOkfGJeTIMB53QauFx4AucCWk2oo8ZpzNuJhPHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(376002)(39860400002)(186009)(451199024)(1800799009)(5660300002)(478600001)(38100700002)(6666004)(6506007)(8676002)(6486002)(66476007)(41300700001)(66556008)(54906003)(6916009)(53546011)(8936002)(316002)(4326008)(36756003)(83380400001)(2906002)(31696002)(86362001)(66946007)(7416002)(2616005)(26005)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWdEbFhJYUJnU3Q2ZFpDRWNZcmJ3Vi9EclpkWU82djBWUDVNQ3M5bGIvamhm?=
 =?utf-8?B?MGgrNGFuVnFBZ3pONmUvS1FyMnNpeWVjNzNhTVJhcDgybXJqVXJYMnBZcCtK?=
 =?utf-8?B?ZVhwZ2YyUEtMZmpmMEkyNEtVUEp6U2Q0K1UrVDBNT3oxMnQ3bFZKR3FMUkw4?=
 =?utf-8?B?UVhPNG0yYXIzQ1BtbDRDeDZTaTlHWnZrQ2daWXRZczExUjJPLzZDaVVhOUNS?=
 =?utf-8?B?V0xEd3NCRHh4S01Ic2RlRG13ZnZGU01keWJDZVE2ZDl2NzNRYW5HQ3p6Rmox?=
 =?utf-8?B?SU1QTElDWk9SdmFld1d4N3cxckRRZmZDdzhwUjQ4dmJiak8vRzA2K052Wk1G?=
 =?utf-8?B?R2ovQVVSbEZNbFJxYXpZRVcvcHMzNzZrVktJOTMxeUJNc3VHdGRVYzlTcEhv?=
 =?utf-8?B?aFRLb0VYYjk0OGxUQXg2MTRyV3R1MHNtSEtJT3ZFb1RpTktscGhlSk01b2dP?=
 =?utf-8?B?OEY3aGN2UCsvY28zMURsenk4bDhkZ2RVdTdybEJsMVlLc1hubHpTdlJxaWcr?=
 =?utf-8?B?ZHhVNVVWYmNKMzFmbTUvSG53WENOSXpmSTdZUGRiMHdFT01MK1dDcnRCb1Yz?=
 =?utf-8?B?RjRPVFcxN01ScDI3a0hJL25WUGk3WDBoVTBlcU9HZVA4K0ZJRDZxQVovVUN2?=
 =?utf-8?B?RXdhTmh0K3ZqRUhOL1VFTTcrZTBVQ1MzYjQwZ0w0UTgrQXdwM2lRVFptQmhL?=
 =?utf-8?B?YzFzSU9YSFVNaUhSN3JORnNWZHRldUNiUFBjcENMS1pEMGM4YWsvWC8wZVFl?=
 =?utf-8?B?eEdXWmZPVHEyZ0Z6YmNWOGdBbUdkdEJxbDZmZDRtVU50WEVkM3dLSzZMa1Fi?=
 =?utf-8?B?UmJRZFh5Mjd5ZytHNXBBV0NIb1NERGRDcUF2ZW1nUXBReEtRRk1GOHFQWmFx?=
 =?utf-8?B?UUJTcGt1bjA5RE4vT2JZYXNMYXE0RTBtQ2NoRXh0eWFKcG1PcEhkVHp2alEz?=
 =?utf-8?B?S1FjM00vTHhvK3ptRno0ZVFJRHU2MjRVL3VBVWRNZEZOaUg2Ujl2c0lRUnlY?=
 =?utf-8?B?TEtWTjZHUXhhRWg1RTBhQ2ZFNFFZNTVPSkpSZ3hoOTVaemF4dXB1eEtHYlJB?=
 =?utf-8?B?cVF3YXNqZXE0ZldHYUZha3QyVlBWeEJwTjJTb3RtODN2c0I5cjlvYjR0RXV2?=
 =?utf-8?B?TnBWQ1RkT1BnMlRhNWtwZnh3QStqbmU1U0RZSm9yZlMwWW1TTVRnYzA4U01p?=
 =?utf-8?B?TnlCQXVvZHlWZXczUndZekFLVmdHQ3kzSGVHWHp3dXdoVjY0U3lCY1U1cjd3?=
 =?utf-8?B?TExITTZETTJONWIzclR6U3JERjFrczE1QStOOGFEL1JYY01NL090emFFYW5y?=
 =?utf-8?B?a0Z0R21UU3pBZDJxVjFJUmhZajhiVk9BMVJ6dXZIY2pueGh0clNSMHgwU1pP?=
 =?utf-8?B?YzVNV2ZORTJLSG5sdFB0VCtZOWFaaTh5MHBGWS9Cd1J0L2dhRnBxMlpULzdF?=
 =?utf-8?B?OTJnUVFhOXZzZ3pXc0dxRGxlQk9LNzlDRzNxRkJpandmQzVUeDI0Zk91UjhM?=
 =?utf-8?B?RHFlaVRpdjRGZVUwdGg3aHNIazJrYVQzbWdyekUydVBpTkswd0ZwOStLVjlt?=
 =?utf-8?B?WDlSciswekxKQjB1V29ZdDZzWXdNbEtDQ205a3BWYTlmeUJpWTR2SWgxMmla?=
 =?utf-8?B?dEpMWHlMb05tN0dkWjJOaFBDV2pVRDFuTm9VQjQyckd4WXhmc3lEUEtRWUd2?=
 =?utf-8?B?RTVVNzZzZCtxNWg0MUlDNjBxVDdZRGpGYk1TWU9zcmphMUxMVmVRdGVIeERP?=
 =?utf-8?B?L3NkMEJwWlBBWG5ITWlGNUlrci84TTZkaVR2RVc1S0ZGbWY1U1pEeHd0d2dG?=
 =?utf-8?B?K0hNajdZWnpRTHVsZVF6YUp5b2xxK2RSNEoxTUtpUE5FeVlNZTBoY25ncG4x?=
 =?utf-8?B?WkZ4ZzZhR0NoWUJBZjU2c0V6dUNMZkFBOUV6dWduTFBzeDQ1Tmk5bEZNdHNT?=
 =?utf-8?B?NUhJTDRPNlRrQkFFbFFSTmpyTXBTRzN4MW5TZS9Ydm9PZll6c1hnbnZ1N2ha?=
 =?utf-8?B?MkVEZFFnSldRQjRqRDA5ZWViYzRQNHZxdDZGS1VrR3EvYkN5TnVCU3JpaG9z?=
 =?utf-8?B?ejJqR0Y3UU53WkF2bGRSa0lUL3VxQUhjZU15WTJtcnZBb1pxWU9MeElzTCt2?=
 =?utf-8?Q?qh11+0ekFrXuRQR7/NObdGFPo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdb99a2-0f09-4525-6184-08dbb59d1c60
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 03:37:40.2112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fSB9kkLAV8djOO29SN4nvMst3VGzbuO5aSPzdziXx+TN8NOtilO0e0xnsWH6cbpi1xNJ1yV7SheIUySogH3bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

On 9/14/2023 4:13 PM, Chen Yu wrote:
> Hi Prateek,
> 
> On 2023-09-14 at 11:00:02 +0530, K Prateek Nayak wrote:
>> Hello Chenyu,
>>
>> One question ...
>>
>> On 9/11/2023 8:20 AM, Chen Yu wrote:
>>> [..snip..]
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index e20f50726ab8..fe3b760c9654 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> [..more snip..]
>>> @@ -7052,10 +7072,14 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
>>>  	int cpu;
>>>  
>>>  	for_each_cpu(cpu, cpu_smt_mask(core)) {
>>> -		if (!available_idle_cpu(cpu)) {
>>> +		bool cache_hot = sched_feat(SIS_CACHE) ?
>>> +			sched_clock_cpu(cpu) < cpu_rq(cpu)->cache_hot_timeout : false;
>>> +
>>> +		if (!available_idle_cpu(cpu) || cache_hot) {
>>>  			idle = false;
>>>  			if (*idle_cpu == -1) {
>>> -				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
>>> +				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr) &&
>>> +				    !cache_hot) {
>>
>> Here, the CPU is running a SCHED_IDLE task ...
>>
>>>  					*idle_cpu = cpu;
>>>  					break;
>>>  				}
>>
>> ... but just below this, there are following lines to cache the idle_cpu:
>>
>> 		}
>> 		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
>> 			*idle_cpu = cpu;
>>
>> Would it make sense to also add the same "cache_hot" check here when we
>> come across an idle CPU during the search for an idle core? Something
>> like:
>>
>> -		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
> 
> When we reached above code, the following condition should be true:
>  (available_idle_cpu(cpu) && !cache_hot)
> because the previous 'if' statement is false. So I guess we already
> has !cache_hot ?

Ah! You are right. I missed the break at end of the if block. Thank you
for pointing it out to me :)

> 
>> +		if (*idle_cpu == -1 && !cache_hot && cpumask_test_cpu(cpu, p->cpus_ptr))
>> 			*idle_cpu = cpu;
>>
>> Implications with the above change:
>>
>> If the entire core is idle, "select_idle_core()" will return the core
>> and the search will bail out in "select_idle_cpu()". Otherwise, the
>> cache-hot idle CPUs encountered during the search for idle core will be
>> ignored now and if "idle_cpu" is not -1, it contains an idle CPU that is
>> not cache-hot.
>>
>> Thoughts?
>>
> 
> Yes, agree, we want to skip the cache-hot idle CPU if that entire core is not idle
> in your case.
> 
> thanks,
> Chenyu
 
--
Thanks and Regards,
Prateek
