Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A9F79FAD3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 07:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbjINFa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 01:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbjINFaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 01:30:25 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3D48E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 22:30:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRVAnmYKC0d1TOJhbKMxX4oPZ9ag72yuApoyeP+Hl9gtifu/xJSNxsTbsiahNKLFJ5+OcedAvGJ7fmlvGyWQF+L8JuV9EBrLvcc3WQdkwq/51PgTIbXXNCiljQO3eBSHBHg7OJIatS7d27rixfyCR1YjLS1jpUvSgiV6ZPcuhd5KOjz1wbGAFLa5jd4ZFC8MGrtwbqCNeaJZ812NgaT1bIAICcSOBtVOvBNvTQsgus2cFN3jPgCPiYUztiZ3G6XwTt+ayTZk291Pnn62h5DdzL3oHrJEn7pm/jxA4mIq76bX1+XRjqXvxYmFLC78aSWfjH747vgzGYKXlNonmyUmqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Py53MNec4OZuoMzcvutPHMinQISmkWwhy77wuUzr0VM=;
 b=M5e/pxxNPAWvYPyME7l908My1pP4pEZhcLoK2FgVM/5DV2nMRr9jsg6z9F/g5A6qPejgH4FTZ8TE2RHikgNMlIoBAhmqrxMVn24slMT8gjoi+8oQZX45Wp8yhBtxQmGENWKuYEPpmIrYvuLssRD6RYzKvRty0wdCYdsFzD+aTIK6rbw46D1inDBZcOW/v0zcBG4ufm5JNhwwRnaT9xnXyQJq/F2XgOaPDPmafVqbQOhYR+3odaxDR5RPEm4ofgCeGrwFedVpj1xeHkwQqSo6ULpZ5yMoiy3quKXIos5gjthB8KpsHlkr4nB4PtIxJwQZQurOLqmzBBpIVojB1U4otA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Py53MNec4OZuoMzcvutPHMinQISmkWwhy77wuUzr0VM=;
 b=M+qnmvhdM8B5p63F21RrfDiRWP1NC7rQ6eN/6BhakEpALLA+U4S9yEr8aJ7dy4Uy0wPJP7+4r78w1h2ydc/4nOFdNAwSBcVmwr3IdaWhjqrbz5WpJKWZcHsyZVXcacbIDRM60jgiff+TpVvadqqiYjh1jccT7/KJGHwK9IbqsQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Thu, 14 Sep
 2023 05:30:17 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6768.036; Thu, 14 Sep 2023
 05:30:17 +0000
Message-ID: <09a7a5cb-dde5-122e-a086-5802df993433@amd.com>
Date:   Thu, 14 Sep 2023 11:00:02 +0530
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
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::23) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|SA0PR12MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 26560771-bf50-41b6-c771-08dbb4e3ad9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJhPfX0jWvk551hUlGQrPcIM4LkZUnxyqgHireQwX7ek5QcDFg8WkYQp4q2IwK7V17+R7dJmBdh7nKRi9SpJb04WuNUqHFWCIsg28D27YHtM0WFxseGemHK4+sy3ufJxjUALkSblCz6krGrGfD47c1pw2SBkR5veC+nmrJZLkZcUWECKBcMAETVJq9BR1xC75ztgt+iw0Fjbw1Jl8R7I47WNvjP9Fvxf6Y/dArs9dWeVXncSBWnfysBjPzsO5kV8SSThVeWwcrq7mPDLBOD8hmZov+9dBcWNGXpO9CnKiwIkIPlzPHd6aTXPHAOg20nx6cUxPkM6iVQyrVFxbOSf2N/hES7pnS/aFAbVklv6KjAlWEim9ig2BeQYj8cmqlX3uwdcwMcz7IuN0lmTyhZHfqqi2u+AEVRtYpQlaqPMYYjtXxU4on8OdccuTsxv2ELUokYGqvGOqQ+kWRqNJbAkT4ETiAtk9W2f98UKQP8ZP0PyHgSR+fQxAvDtsImXSvSaB8E/zWA9pf32/S/3aHb1mrNz3uzIl4P80JxXv9nqH52aWYboxRgQiPO3I0dLpmSHMP2Xq3+Qeardsb4NxvC7nCT8K4suVGHjRK/nIcOkjgwCBX//5rEozOW27M0sMvCqiYMfhUwNJgWQsExyNK9hhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199024)(186009)(1800799009)(86362001)(478600001)(31686004)(5660300002)(54906003)(66556008)(6916009)(66946007)(66476007)(26005)(38100700002)(316002)(31696002)(2616005)(41300700001)(36756003)(8936002)(6512007)(6506007)(8676002)(83380400001)(4326008)(53546011)(6486002)(7416002)(6666004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGIwQzNnbGZZaDEyb1hBQ29iclViNVFxQmJOai9MYXpWUFVIc1FXRWVSWUYx?=
 =?utf-8?B?K1ZBenc3ay8rNCtDZHZsby9JRGU5WDVLYkN3ODIzNUM2eC9qajBvay9sTGVI?=
 =?utf-8?B?Q1VxNVc3dlJiL1VzM2tQbTMrMkZneTRDMGdTYkg5M0EydE9pS08wejk1R0hV?=
 =?utf-8?B?SDFFdUxsZGdzMlJORmlQY2p0dHRnSE4rU1F5Z0lhYzgwdWxLaDFHVndqMnFN?=
 =?utf-8?B?Ymg3UE5MQnpwamE3OWtzK3lZZ3JndEJidEVPdEllVTVXUjM0WHI3aWZuNnRz?=
 =?utf-8?B?bVcxd3RERklqUTFESWQ1QWtzN2ZVbVZaZExQc0JMbkFURTdXTnROL2VoSXli?=
 =?utf-8?B?YzRjZ1Z4a2pCM09IeUYxZzhZZUJvOGl5Zks3cHc5emdydVdYVVhXSlRwYlJz?=
 =?utf-8?B?eks2S2VYUVRwem8wejVwbDlhU0lMaTRGdkYzcVJtSGVGT0lYRkpUNUdzcTVV?=
 =?utf-8?B?L1JNalpvb21pMEJDUXI0RVowN0lCWXZjYnB0TWN0VnRKUWNIMXJRVlQ0bGU4?=
 =?utf-8?B?RzVqMkRJQmV0ZzVQVnA2amNsQXZGMGJZMlBFVEF6bW5TdW94em9jRVBwcDE5?=
 =?utf-8?B?QnI3TEtWMkhMTFZoZTFEMEoyclFXR0pMbm9NQUZ3MDJNQ3IrR2U4ZkRidE1p?=
 =?utf-8?B?NFpjR1M3R3FuVWJWcC90UWNsYWFGdjNka0NGbkJFcDJJTkkzS2V4QytER2xt?=
 =?utf-8?B?K1dndDRObU15U0RxK0RBKzUrTjJZNmRSZkZrVGJHWWdCMnVJOGdMTlUwZVJ5?=
 =?utf-8?B?bDI0a1RzeG9vY09nUXVnMk5USG95elZ3b3VXNUZ0NFNEcWMwZmlhVTBtOXcx?=
 =?utf-8?B?RGNoMy8rbGsvSXJWQnZHSXRmQjBNNkZab1lQWkh6S1RraVo0b25lNnU2VVBR?=
 =?utf-8?B?YWZsaVlRUEx5ejJYRkFWbjk1ZGJqMTkvaWJIQUJRUmNqNWM1eVhwTU0zOCtn?=
 =?utf-8?B?ZFZNWGVKYk45bWttRzdKakxuSUZTRDdaZTNQQVFFbGxRNmdQREd2bmZMbkds?=
 =?utf-8?B?cXYxTHhrbHhwbEk1Y01sanN2dEE5L2dvTnlNWHh2aEtEaHc5VWFseERsQ2FJ?=
 =?utf-8?B?YmQ3bzg3a3AyeHQ4clFGL3BHL1VZNjZISVNOdVlMcWJzdm9jSS9WUk1LQXZt?=
 =?utf-8?B?MHgvMXh5S1MwVVZPbFFjYU5qNlk1MUZQM2l3eWJjZEF4aTF0R0ljSzRVSXM1?=
 =?utf-8?B?eFNWUGRCdkpxdU1mZnNsWTA1K1pnaU1Yb0crQVN2Vm1YaFRVVGRrOHJOb0Er?=
 =?utf-8?B?dlhtOFlleWJ2QlExQTJ0cS9hdkplUlprbkxocHVXUEhncUZ4SUcxZ2hIRjds?=
 =?utf-8?B?RkVHekhqbnFNTVEweXIzalRxTHozNHdFNDRTZnJGWG5rbnE2cElJcDFLcmxG?=
 =?utf-8?B?ZFp6d1piSUJsQnJVckVXbFpzK2xhSERQWmp1eVBaZ2pHUDRlTmQvRmFhbFE2?=
 =?utf-8?B?SU5mS2pLamorRmNKZmMrbVNseVBoaForbXBhSUFsWFBWaWVrYkJ0WVpiNlp3?=
 =?utf-8?B?Y0VpU1RHZml6RjRXbVIwMWlMVFJBQkh4V0VtQmVmMVBYUGMrTE1Yb2hPUTlq?=
 =?utf-8?B?WHFZWGN0UDJ6c3NJWUFxVnRmbWd5UnlVTll4WHBFdUkyU0xMbkhqVkZwT3hm?=
 =?utf-8?B?K3JyVjNseVJ0WG04bFRiVjNYUHhFMnFKWFFvOW04cjZ5aWN4Q1FFc2x5OUJR?=
 =?utf-8?B?bHRIc1BtVjlST0MxT0ZJRUNTbi9rZFFTSnYvazZvaThrVUhyNnc0Q3Q2bU1W?=
 =?utf-8?B?YWpNZWtwekJYNzk2WjlHYzRxNFhCUUViUHM5K1hZZGhBcmc1U1I2UklpWWNt?=
 =?utf-8?B?cjdMMVY0U2lGbE4rcVpSMzhCMW9iL21MK1ZqTzluZjhzMk5RV2pVcytqWXdG?=
 =?utf-8?B?bzREQzNuZklyZ2FiRnBpdjRycVNCcDZZTlJTM1JNdXppTGltL1JmaEVqTGNo?=
 =?utf-8?B?Z2ZBSzNkbmpnNXJWVHNzRmdiV0tqQlJsR0pyRUpWUFoxUHFWQU1Za0xFWHFE?=
 =?utf-8?B?VXJFTVJKYWUxdzRpZ0FPY2U1M1piMHZMYndJK1loVE5JLzI3bmtzT3oyNng0?=
 =?utf-8?B?NWJpRGJLRzhPZEZYZERMcCtwVm5rSnNlUnE2YjJ0VjVCMTVvNlpKVHdwTFFr?=
 =?utf-8?Q?LeuVasQ6V1jt6UTw0+JLiFXbZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26560771-bf50-41b6-c771-08dbb4e3ad9a
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 05:30:17.2435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9CN291+Tz4EyAV3ugvKIJvuPdV3x6OXKR+VUZQuYa+VZ0mQ9kZbxgu4QCgL5ogiIhPI/lHIvNeZoK8nOLoIExA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

One question ...

On 9/11/2023 8:20 AM, Chen Yu wrote:
> [..snip..]
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e20f50726ab8..fe3b760c9654 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> [..more snip..]
> @@ -7052,10 +7072,14 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
>  	int cpu;
>  
>  	for_each_cpu(cpu, cpu_smt_mask(core)) {
> -		if (!available_idle_cpu(cpu)) {
> +		bool cache_hot = sched_feat(SIS_CACHE) ?
> +			sched_clock_cpu(cpu) < cpu_rq(cpu)->cache_hot_timeout : false;
> +
> +		if (!available_idle_cpu(cpu) || cache_hot) {
>  			idle = false;
>  			if (*idle_cpu == -1) {
> -				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
> +				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr) &&
> +				    !cache_hot) {

Here, the CPU is running a SCHED_IDLE task ...

>  					*idle_cpu = cpu;
>  					break;
>  				}

... but just below this, there are following lines to cache the idle_cpu:

		}
		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
			*idle_cpu = cpu;

Would it make sense to also add the same "cache_hot" check here when we
come across an idle CPU during the search for an idle core? Something
like:

-		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
+		if (*idle_cpu == -1 && !cache_hot && cpumask_test_cpu(cpu, p->cpus_ptr))
			*idle_cpu = cpu;

Implications with the above change:

If the entire core is idle, "select_idle_core()" will return the core
and the search will bail out in "select_idle_cpu()". Otherwise, the
cache-hot idle CPUs encountered during the search for idle core will be
ignored now and if "idle_cpu" is not -1, it contains an idle CPU that is
not cache-hot.

Thoughts?

> [..snip..]

--
Thanks and Regards,
Prateek
