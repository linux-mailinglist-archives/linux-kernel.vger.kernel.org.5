Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60D07516D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjGMDnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjGMDnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:43:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6A11FDA;
        Wed, 12 Jul 2023 20:43:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiEoLjFJqGNL/4jupsYPpVf7VFhWhZqf2e+tttETPM8RDDrfmhi1kNA2YrfFN7AmaG8uffY/P5VD0GlK0KeYdIn+CWf2bF9qsY4y2Wu0z9e91B0No2iFfQ1ygKR71qVPjua4+jJ8gRfBYe3IbuYtQkmOuBJ3XIEydDIhJkCLRBpN2LTarmhCKbw/BDEglSvc0EzGfZl0s4yjjB3hRjJG9imOU1GJfZ76nExGbyyMH1aL6MJ+5in3Jfuo6uWUVOZBKyzkWKJdX/XD8qiu1RBkelJWqhm1Ir8FeqZgEQyrGeq8VNEpOn4jEH70B8asnTkIC7rMuwvpUMe86BuytDYXrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9gACOMAoJef8yHTf9r3vVdR31JPKO1IPDC38yb0iMA=;
 b=RhQCIPGQRENOB5YMc5pEwYPvb3kgaZRLIGhLVUjy3pgyP11MrTIaTEGVJ8YPJrDpspj7xg946gAfm8rQYbz3frUhKyXCPvR520JeDpsIYR8DBTj4gfN5uR7ro7MptbH70vca9Rn4PFQUuu9XoA8PwurrpJPlBsArHsGS6z9jwof2q7zbfYkdUND4qm8+UOZ4wwAnZIgzL++IJbe5BJXeTOIwbIVjKT0LZwhlE1TxCoPJ0jbQd5XWV5NEffjMhixkz2S2vizow8HGmMKjKGaxIZ17tRnNzYjBZpFWkwJdXe54mPoyQeVRnfjSPJ11VFNlRrgvN4b/AjSgpK9nFvyvrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9gACOMAoJef8yHTf9r3vVdR31JPKO1IPDC38yb0iMA=;
 b=lZoy0WmMzw1yod6QM1/gcitEKevsKlEDOkCuUG1r/y54HAF5/IN21f7dxNz0YZEO0yylYA6JAFhXWGjz6UALd2Nfx/spN10ESghMZ7GI7oTLShbLEsaHeu0dMLaDHEwxFKXO64iOBCNFxkC4G/uClcMHiPmAWjsblaRHoT00mp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by SJ0PR12MB5675.namprd12.prod.outlook.com (2603:10b6:a03:42d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Thu, 13 Jul
 2023 03:43:41 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::88b4:a667:a7e7:1b2c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::88b4:a667:a7e7:1b2c%2]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 03:43:40 +0000
Message-ID: <8702a92f-317e-c38f-48ec-5ac373ba5072@amd.com>
Date:   Thu, 13 Jul 2023 09:13:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Tim Chen <tim.c.chen@intel.com>,
        x86@kernel.org, Gautham Shenoy <gautham.shenoy@amd.com>
References: <20230601115643.GX4253@hirez.programming.kicks-ass.net>
 <20230601120001.GJ38236@hirez.programming.kicks-ass.net>
 <20230601144706.GA559454@hirez.programming.kicks-ass.net>
 <7bee9860-2d2a-067b-adea-04012516095c@amd.com>
 <20230602065438.GB620383@hirez.programming.kicks-ass.net>
 <bd083d8d-023a-698e-701b-725f1b15766e@amd.com>
 <20230613082536.GI83892@hirez.programming.kicks-ass.net>
 <f212f491-cd3f-6eee-20d7-8f9ab8937902@amd.com>
 <20230705115702.GY4253@hirez.programming.kicks-ass.net>
 <ZKlh1u2kkHzHY/nB@chenyu5-mobl2> <ZK7groqlP3S7r8vt@chenyu5-mobl2>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZK7groqlP3S7r8vt@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::26) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|SJ0PR12MB5675:EE_
X-MS-Office365-Filtering-Correlation-Id: e41b636c-8221-4f5c-eb5f-08db835358f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7430akorZdybRz4z2ie7Mwnx0UF/bXXc6NnjOf3nu2AYW2DCBfm5V47k1IuGOEhI8A0AH774TLQ9+ardwg+9CjdRxj3xwXQvbkOlXTPnAiFLsX8aFIgYrk0gKAbcbYgO8vgdcuojA84JTDkKy3zeYOND3RaBxJRFmvR53m8GyIReEJ1T6oiQFxtYZaXygXvmuuzy9Nt8do73BqYsmp9hV8KoLFR2Po1sqfmtgBz/0KuTXKfWBrt6sBtIsLGlf0KCiH+BOlTan8y0OEHHAVh/DtGUZR5SzGJkiloMT66WImzReLO6GsC7nS4k204mviUlwXs1BkBfwQln20NA79MGCYQfAucvmE7VeGh+xC6pOtA3Y0LZJPhCqq9pXSyf6yUO46eVUZ9T4TxeAT7/5k/b8X+Gp7LiOEZ0s463wn4XYZFcPwpIuBHoVsc3iPKqjN/fEuWGc21GoEblZScofFgMCPlPbOxCumJLE3eLiSFDQJeWruKOkemnQua4A9tgKpzWiAdn+oGCWJ2YSBv0RGoWRtlo9A69m1mKgiSgtUknWqDsrz/gZkbA+XDIxEn+qgwG9bjG6oAQgI7lcX+t0dglR/4fvc1UMS1YUV5gyG3z3RLYaz5d+hI/3eGBCNx1papxyg38+Zg/x25QN8GacBSueGTce12K44GJMeLaVhACOzM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199021)(30864003)(41300700001)(31686004)(5660300002)(110136005)(54906003)(8936002)(316002)(8676002)(2906002)(6486002)(4326008)(66476007)(66556008)(66946007)(6512007)(478600001)(966005)(6666004)(86362001)(186003)(31696002)(2616005)(38100700002)(36756003)(53546011)(26005)(83380400001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVo1ZnZhSXpjSDIwcm9JUW41WVFCT01uSVpTYmRnYk5Vc1g5ME05R3lKdFp3?=
 =?utf-8?B?RVNZZW1VTm5GeDl5Z0U5UGpNa2Uza2pEdHRvU1dFY3JLZTZvNUFaak9SZFUz?=
 =?utf-8?B?ZGpWR050UlJrRlViQitKNW45cDFzamt3T3FrdFZEL2RDRXozNk9HbkRoV2Zz?=
 =?utf-8?B?Z3d0ZTVVcEp6clhZTUJhcU5sUm5HbmFVL2tiUFhXMHdsUTVCOFRJRUVJQkVC?=
 =?utf-8?B?WVM4aGd1dlY2cHZhUXhDVEF4MkpjMFBEY3czTG81SmxSc0hlR0ZWbldlcUZy?=
 =?utf-8?B?eXBQM0lDQ2N6eVNXRVRRVGsrVFlRWjFBR2grSFBiN1hwT2dOZVVkZmZUVVpU?=
 =?utf-8?B?VEQvWWc5K1FKUk5Id2ZrZElEVTVVVTZjeTNvbTc4Qy9Nc0E2cndCTnpoY3lP?=
 =?utf-8?B?RkQ2VkYwbTNZK1FZaTBkSXpMdHpmMEhuNFZnZU9NbkRaT25uMDVXRzk5clkv?=
 =?utf-8?B?Z1hRejJZYWJNWjh6Y2t4b1IyMms0NXZIb0ZPcnFUOEUydldocEYzSTY0cjBG?=
 =?utf-8?B?Wnd3YXZ1MFgvVURzY3owRzVVL3RsK2ZmZENKMXBPWXMvazEwUEsrNmRVeENV?=
 =?utf-8?B?OVdsZVo5R2pCcitKakFDNWdONWJWNmxkNDg4c0VnZHY4bGhDcmgxMU1Sd2tq?=
 =?utf-8?B?UGdRV01IS0FIQzlMMzVvY3RxdU5lc0lYVE41RnQxZ1UwYzZ0UklQYzJSbnhH?=
 =?utf-8?B?aWNGaUhYM1hCcnBkVitNQ3RFUEI0S0Zrd2tMYkROMWl3dWxuL3dweGo3ZURt?=
 =?utf-8?B?dlkzVFZDdDBrTlIxazlWdVVaa2VzQXRqR3lKVTZMSGg4WWI0ZTNsbnd1K25a?=
 =?utf-8?B?L0hVTTFHTjQwZTZMbkg0Y0dGRUdMK3dWVFF2ZUhjOEQxdmhSdkJwUUVGM3VM?=
 =?utf-8?B?bnpKTDRPT2M0djJTNDdTdXk4OWVLYWJ1VjBxeWdRUWZDYWhlRGRUeDVTTlVy?=
 =?utf-8?B?amYxbnExZDFJM0ZadVRVTDlKbnErRm1wdktmR1NaYk5Pc1d4bWVRY3J6RTBu?=
 =?utf-8?B?ajNzbGRocWZiU0U2Ymg4S3EwUFNrcXZPQ2ZseXFBQUVaRmpyY1VBTm5nYTQ4?=
 =?utf-8?B?cTRYRlBTemE2UUJ3dko0S3VOMFNoKzRZWmhEbkpJWVE2bkszMUZsU0NnVGJB?=
 =?utf-8?B?c3VXWG9kSmRsMHdrQTNJUTg0c0k3NHpsWFNCcTJLV0N5WGpQdFErWVZ3SUJt?=
 =?utf-8?B?N0VVOERSNW9OWFVqQUpNVFNQTlJYLzZLdkRXenVqZGVqTmU1czlEZjdpbXVI?=
 =?utf-8?B?b1crdTlHdkNaTTM4NWJWd3ZXRjZrYUQxVGhrZmRLTWw4VkJ5Q2t6N3FQZ3NG?=
 =?utf-8?B?QjJmTXRWN0pKSGRrSTYwYVFZRXpuY0RobE5BRDFhZHNKZUo1VllvSDBZaU1y?=
 =?utf-8?B?Y1JKZXFtSjYzNHAvS25id0JQMTVTYTRBOXJCL3Z3MEZUMXIyYXdmY2M5M0ND?=
 =?utf-8?B?RU5tU0NrWnZrbXQ2MUw3Q045OUY0VThnRWxnWGVST0NhNWNtZXRFYVdiZFBI?=
 =?utf-8?B?SWcwcXRaRitUN0lUQzkyWWxXT0JCVUtmWmowM3Fxeml1ajhtN3VLTFdXeGFE?=
 =?utf-8?B?dzRBT3Y1RmFGQXQ2dFR4YUNudFc2NGhDR0V2ZUJseW9ud2F0a1hDYXF1V0Zo?=
 =?utf-8?B?UU1BdXhWcG5jS0tPMFROY1lsc1c1SERIM0V1TFBrY1Y0RFJDNkZZTS9nRkE4?=
 =?utf-8?B?L056Yk5OUFFkYzczcktyUzdSTDg1a2lKdGwrUTVvYUFDeXQ1S25FczdRZGVl?=
 =?utf-8?B?RkhlSHdISlcyVWwrSE9HcFo3NkhjZWNQdkU0elZialN3aUF0RzVnRzg5ZHQ1?=
 =?utf-8?B?alRkdXJLRWdBcUZLTm5wUUpFVjlUL2hFRkgveG1jS2hTamt2b25aQkR3TjZw?=
 =?utf-8?B?N3p4Skt0OWhEd3lYN0FwR0tmeWFObjMvaVlvNTdjZS85N0FzQTFLQ3pPcWYx?=
 =?utf-8?B?WUVQVG5zemg5QUg0UU95UnBsM1VsZlc1WEtZSTczTXBidzdBc2J6WmtBYkt1?=
 =?utf-8?B?alk2M3NBaVNlZFVWK1BGUWVIbUdiOGtyOXY3andXZ0xEckNUWmFRQlk1dGFL?=
 =?utf-8?B?TjlxTk9yZVZYaXQvZ3AxL0xab2hoYlZnVW1RUWx6VkM5RzZmQVN6YXRiRDE2?=
 =?utf-8?Q?8aoxAotfBDm1wAx1/uoJVJvNu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41b636c-8221-4f5c-eb5f-08db835358f2
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 03:43:40.5447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IANcZkwMl3OUdF+EyuyaNbbjjqoMg27MLxjFmqp3bSNbkPpgloa2osYDt4d6HqP2k4bQZvbObS2uDqXrVYOCew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5675
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

On 7/12/2023 10:49 PM, Chen Yu wrote:
> On 2023-07-08 at 21:17:10 +0800, Chen Yu wrote:
>> On 2023-07-05 at 13:57:02 +0200, Peter Zijlstra wrote:
>>> On Fri, Jun 16, 2023 at 12:04:48PM +0530, K Prateek Nayak wrote:
>>>
>>> --- a/arch/x86/kernel/smpboot.c
>>> +++ b/arch/x86/kernel/smpboot.c
>>> @@ -596,7 +596,7 @@ static inline int x86_sched_itmt_flags(v
>>>  #ifdef CONFIG_SCHED_MC
>>>  static int x86_core_flags(void)
>>>  {
>>> -	return cpu_core_flags() | x86_sched_itmt_flags();
>>> +	return cpu_core_flags() | x86_sched_itmt_flags() | SD_IDLE_SIBLING;
>>>  }
>> I guess this flag might need to be added into the valid mask:
>>
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index d3a3b2646ec4..4a563e9f7b10 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -1540,6 +1540,7 @@ static struct cpumask		***sched_domains_numa_masks;
>>  #define TOPOLOGY_SD_FLAGS		\
>>  	(SD_SHARE_CPUCAPACITY	|	\
>>  	 SD_SHARE_PKG_RESOURCES |	\
>> +	 SD_IDLE_SIBLING	|	\
>>  	 SD_NUMA		|	\
>>  	 SD_ASYM_PACKING)
>>>  #endif
>>>  #ifdef CONFIG_SCHED_SMT
>>> --- a/include/linux/sched/sd_flags.h
>>> +++ b/include/linux/sched/sd_flags.h
>>> @@ -161,3 +161,10 @@ SD_FLAG(SD_OVERLAP, SDF_SHARED_PARENT |
>>>   * NEEDS_GROUPS: No point in preserving domain if it has a single group.
>>>   */
>>>  SD_FLAG(SD_NUMA, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
>>> +
>>> +/*
>>> + * Search for idle CPUs in sibling groups
>>> + *
>>> + * NEEDS_GROUPS: Load balancing flag.
>>> + */
>>> +SD_FLAG(SD_IDLE_SIBLING, SDF_NEEDS_GROUPS)
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -7046,6 +7046,38 @@ static int select_idle_cpu(struct task_s
>>>  }
>>>  
>>>  /*
>>> + * For the multiple-LLC per node case, make sure to try the other LLC's if the
>>> + * local LLC comes up empty.
>>> + */
>>> +static int
>>> +select_idle_node(struct task_struct *p, struct sched_domain *sd, int target)
>>> +{
>>> +	struct sched_domain *parent = sd->parent;
>>> +	struct sched_group *sg;
>>> +
>>> +	/* Make sure to not cross nodes. */
>>> +	if (!parent || parent->flags & SD_NUMA)
>>> +		return -1;
>>> +
>>> +	sg = parent->groups;
>>> +	do {
>>> +		int cpu = cpumask_first(sched_group_span(sg));
>>> +		struct sched_domain *sd_child = per_cpu(sd_llc, cpu);
>>>
>> I wonder if we can use rcu_dereference() in case the cpu hotplug
>> changes the content sd_llc points to. (I'm still thinking of the
>> symptom you described here:)
>> https://lore.kernel.org/lkml/20230605190746.GX83892@hirez.programming.kicks-ass.net/
>>
>> I'll launch some tests with this version on Sapphire Rapids(and with/without LLC-split hack patch).
> 
> Tested on Sapphire Rapids, which has 2 x 56C/112T and 224 CPUs in total. C-states
> deeper than C1E are disabled. Turbo is disabled. CPU frequency governor is performance.
> 
> The baseline is v6.4-rc1 tip:sched/core, on top of
> commit 637c9509f3db ("sched/core: Avoid multiple calling update_rq_clock() in __cfsb_csd_unthrottle()")
> 
> patch0: this SD_IDLE_SIBLING patch with above change to TOPOLOGY_SD_FLAGS
> patch1: hack patch to split 1 LLC domain into 4 smaller LLC domains(with some fixes on top of
>         https://lore.kernel.org/lkml/ZJKjvx%2FNxooM5z1Y@chenyu5-mobl2.ccr.corp.intel.com/)
>         The test data in above link is invalid due to bugs in the hack patch, fixed in this version)
> 
> 
> Baseline vs Baseline+patch0:
> There is no much difference between the two, and it is expected because Sapphire Rapids
> does not have multiple LLC domains within 1 Numa node(also consider the run to run variation):
> 
> hackbench
> =========
> case            	load    	baseline(std%)	compare%( std%)
> process-pipe    	1-groups	 1.00 (  2.66)	+13.84 ( 12.80)
> process-pipe    	2-groups	 1.00 (  3.67)	 -8.37 (  2.33)
> process-pipe    	4-groups	 1.00 (  6.45)	 +4.17 (  6.36)
> process-pipe    	8-groups	 1.00 (  1.69)	 +2.28 (  1.72)
> process-sockets 	1-groups	 1.00 (  1.73)	 +0.61 (  0.69)
> process-sockets 	2-groups	 1.00 (  2.68)	 -2.20 (  0.55)
> process-sockets 	4-groups	 1.00 (  0.03)	 -0.34 (  0.17)
> process-sockets 	8-groups	 1.00 (  0.09)	 -0.28 (  0.09)
> threads-pipe    	1-groups	 1.00 (  2.42)	 +6.95 (  3.86)
> threads-pipe    	2-groups	 1.00 (  2.26)	 +2.68 (  6.56)
> threads-pipe    	4-groups	 1.00 (  5.08)	 +3.57 (  4.61)
> threads-pipe    	8-groups	 1.00 (  7.89)	 -2.52 (  3.45)
> threads-sockets 	1-groups	 1.00 (  1.15)	 +0.87 (  3.13)
> threads-sockets 	2-groups	 1.00 (  0.63)	 -0.02 (  1.27)
> threads-sockets 	4-groups	 1.00 (  0.27)	 +0.29 (  0.17)
> threads-sockets 	8-groups	 1.00 (  0.07)	 -0.42 (  0.40)
> 
> netperf
> =======
> case            	load    	baseline(std%)	compare%( std%)
> TCP_RR          	56-threads	 1.00 (  2.56)	 -0.25 (  3.27)
> TCP_RR          	112-threads	 1.00 (  2.26)	 +0.04 (  2.18)
> TCP_RR          	168-threads	 1.00 (  0.81)	 +0.01 (  0.74)
> TCP_RR          	224-threads	 1.00 (  0.65)	 +0.04 (  0.66)
> TCP_RR          	280-threads	 1.00 ( 64.56)	+69.47 ( 56.78)
> TCP_RR          	336-threads	 1.00 ( 20.39)	 +0.08 ( 19.58)
> TCP_RR          	392-threads	 1.00 ( 31.63)	 +0.17 ( 31.08)
> TCP_RR          	448-threads	 1.00 ( 39.72)	 -0.14 ( 39.14)
> UDP_RR          	56-threads	 1.00 (  8.94)	 -0.71 ( 12.03)
> UDP_RR          	112-threads	 1.00 ( 18.72)	 +0.78 ( 16.71)
> UDP_RR          	168-threads	 1.00 ( 11.39)	 -0.18 (  8.34)
> UDP_RR          	224-threads	 1.00 (  9.02)	 +0.81 ( 11.47)
> UDP_RR          	280-threads	 1.00 ( 15.87)	 -0.12 ( 12.87)
> UDP_RR          	336-threads	 1.00 ( 39.89)	 +2.25 ( 32.35)
> UDP_RR          	392-threads	 1.00 ( 28.17)	 +3.47 ( 25.99)
> UDP_RR          	448-threads	 1.00 ( 58.68)	 +0.35 ( 56.16)
> 
> tbench
> ======
> case            	load    	baseline(std%)	compare%( std%)
> loopback        	56-threads	 1.00 (  0.94)	 +0.24 (  0.69)
> loopback        	112-threads	 1.00 (  0.19)	 +0.18 (  0.25)
> loopback        	168-threads	 1.00 ( 52.17)	 -1.42 ( 50.95)
> loopback        	224-threads	 1.00 (  0.86)	 -0.38 (  0.19)
> loopback        	280-threads	 1.00 (  0.12)	 -0.28 (  0.17)
> loopback        	336-threads	 1.00 (  0.10)	 -0.33 (  0.19)
> loopback        	392-threads	 1.00 (  0.27)	 -0.49 (  0.26)
> loopback        	448-threads	 1.00 (  0.06)	 -0.88 (  0.59)
> 
> schbench
> ========
> case            	load    	baseline(std%)	compare%( std%)
> normal          	1-mthreads	 1.00 (  0.72)	 -1.47 (  0.41)
> normal          	2-mthreads	 1.00 (  1.66)	 +1.18 (  2.63)
> normal          	4-mthreads	 1.00 (  1.12)	 +1.20 (  4.52)
> normal          	8-mthreads	 1.00 ( 11.03)	 -3.87 (  5.14)
> 
> 
> Baseline+patch1    vs    Baseline+patch0+patch1:
> 
> With multiple LLC domains in 1 Numa node, SD_IDLE_SIBLING brings improvement
> to hackbench/schbench, while brings downgrading to netperf/tbench. This is aligned
> with what was observed previously, if the waker and wakee wakes up each other
> frequently, they would like to be put together for cache locality. While for
> other tasks do not have shared resource, always choosing an idle CPU is better.
> Maybe in the future we can look back at SIS_SHORT and terminates scan in
> select_idle_node() if the waker and wakee have close relationship with
> each other.

Gautham and I were discussing this and realized that when calling
ttwu_queue_wakelist(), in a simulated split-LLC case, ttwu_queue_cond()
will recommend using the wakelist and send an IPI despite the
groups of the DIE domain sharing the cache in your case.

Can you check if the following change helps the regression?
(Note: Completely untested and there may be other such cases lurking
around that we've not yet considered)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a68d1276bab0..a8cab1c81aca 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3929,7 +3929,7 @@ static inline bool ttwu_queue_cond(struct task_struct *p, int cpu)
 	 * If the CPU does not share cache, then queue the task on the
 	 * remote rqs wakelist to avoid accessing remote data.
 	 */
-	if (!cpus_share_cache(smp_processor_id(), cpu))
+	if (cpu_to_node(smp_processor_id()) !=  cpu_to_node(cpu))
 		return true;
 
 	if (cpu == smp_processor_id())
--

> 
> 
> hackbench
> =========
> case            	load    	baseline(std%)	compare%( std%)
> process-pipe    	1-groups	 1.00 (  0.25)	+31.65 (  6.77)
> process-pipe    	2-groups	 1.00 (  0.28)	+29.50 (  5.35)
> process-pipe    	4-groups	 1.00 (  0.08)	+16.77 (  1.30)
> process-pipe    	8-groups	 1.00 (  0.20)	 -5.18 (  0.04)
> process-sockets 	1-groups	 1.00 (  0.23)	+13.68 (  1.28)
> process-sockets 	2-groups	 1.00 (  0.16)	+11.18 (  1.87)
> process-sockets 	4-groups	 1.00 (  0.23)	 -0.06 (  0.21)
> process-sockets 	8-groups	 1.00 (  0.36)	 +2.34 (  0.15)
> threads-pipe    	1-groups	 1.00 (  5.23)	+16.38 ( 12.10)
> threads-pipe    	2-groups	 1.00 (  1.63)	+28.52 (  5.17)
> threads-pipe    	4-groups	 1.00 (  0.77)	+23.28 (  2.42)
> threads-pipe    	8-groups	 1.00 (  2.27)	 +2.35 (  5.75)
> threads-sockets 	1-groups	 1.00 (  2.31)	 +0.42 (  1.68)
> threads-sockets 	2-groups	 1.00 (  0.56)	 +3.98 (  0.65)
> threads-sockets 	4-groups	 1.00 (  0.12)	 +0.29 (  0.32)
> threads-sockets 	8-groups	 1.00 (  0.86)	 +1.92 (  0.27)
> 
> netperf
> =======
> case            	load    	baseline(std%)	compare%( std%)
> TCP_RR          	56-threads	 1.00 ( 12.46)	 -1.62 ( 12.14)
> TCP_RR          	112-threads	 1.00 (  1.34)	 -0.16 (  1.42)
> TCP_RR          	168-threads	 1.00 (  6.26)	 -0.88 (  6.08)
> TCP_RR          	224-threads	 1.00 (  2.19)	-90.18 (  6.12)
> TCP_RR          	280-threads	 1.00 ( 12.27)	-63.81 ( 74.25)
> TCP_RR          	336-threads	 1.00 ( 29.28)	 -6.21 ( 18.48)
> TCP_RR          	392-threads	 1.00 ( 39.39)	 -3.87 ( 26.63)
> TCP_RR          	448-threads	 1.00 ( 47.45)	 -2.34 ( 32.37)
> UDP_RR          	56-threads	 1.00 (  3.28)	 -0.31 (  2.81)
> UDP_RR          	112-threads	 1.00 (  7.03)	 +0.55 (  7.03)
> UDP_RR          	168-threads	 1.00 ( 17.42)	 -0.51 ( 15.63)
> UDP_RR          	224-threads	 1.00 ( 20.79)	-68.28 ( 14.32)
> UDP_RR          	280-threads	 1.00 ( 26.23)	-68.58 ( 18.60)
> UDP_RR          	336-threads	 1.00 ( 38.99)	 -0.55 ( 21.19)
> UDP_RR          	392-threads	 1.00 ( 44.22)	 -1.91 ( 27.44)
> UDP_RR          	448-threads	 1.00 ( 55.11)	 -2.74 ( 38.55)
> 
> tbench
> ======
> case            	load    	baseline(std%)	compare%( std%)
> loopback        	56-threads	 1.00 (  2.69)	 -2.30 (  2.69)
> loopback        	112-threads	 1.00 (  1.92)	 +0.62 (  1.46)
> loopback        	168-threads	 1.00 (  0.97)	-67.69 (  0.06)
> loopback        	224-threads	 1.00 (  0.24)	 -6.79 (  8.81)
> loopback        	280-threads	 1.00 (  0.10)	 +0.47 (  0.62)
> loopback        	336-threads	 1.00 (  0.85)	 -0.05 (  0.05)
> loopback        	392-threads	 1.00 (  0.62)	 +0.77 (  0.50)
> loopback        	448-threads	 1.00 (  0.36)	 +0.77 (  0.77)
> 
> schbench
> ========
> case            	load    	baseline(std%)	compare%( std%)
> normal          	1-mthreads	 1.00 (  0.82)	 +1.44 (  1.24)
> normal          	2-mthreads	 1.00 (  2.13)	 +1.16 (  0.41)
> normal          	4-mthreads	 1.00 (  3.82)	 -0.30 (  1.48)
> normal          	8-mthreads	 1.00 (  4.80)	+22.43 ( 13.03)
> 
> But since the multiple LLC is just a simulation on Intel platform for now,
> the patch is ok and:
> 
> Tested-by: Chen Yu <yu.c.chen@intel.com>
> 
> thanks,
> Chenyu

--
Thanks and Regards,
Prateek
