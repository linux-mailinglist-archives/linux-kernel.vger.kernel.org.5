Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D15478DE6B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241625AbjH3TCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241254AbjH3Gqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:46:39 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F3819A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 23:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsxcvf2uGCEGCEYI0jcKxYxeVMI+CYze5n924m9SIpJat1ui7TK9L/24G6WgwnD2eM1h4MYmHMZS8jioI8T6dqDULzwxmJrMf4jrl3BPamNqdRv5kDEaZDDSfGv9RbAD7pazzLNVVbDiYyrHefrP73C5EuEqA9dLgTv0JzNStdQV0JCOPMYnoA6tbIjnN+d5YJssf+4q1BoiPYMd/hHF3cqDa6XXmTgSpnKSNWuhLFKCPTAXSjQDKYeUNzXKJO/TtsApRJzosBsCv/hDA21qDYiHUxte83vlP9PfRawtBOztMLPTM529XBwMDbzTiEp37zkQuHOstr5H02ifCEQfHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxgJi0Txq8w31QC2E4t31qXvhsuSj0edgnTtVt/WrVo=;
 b=P8GLdWypY8degicjspbrKr8L8/VYvsYt3oZaomekg4LiKZxxgEhdXm2hBODhAfPhg7uHm0dX8Xmooe+lqXPxCjDWATYfquxnOUoUoBg2bODhmCaAd5EV79sb4lX4zl4u6D0lPurVMVqmdYVCRUohU7ztGXDbyyiBURZsE2cHv2z5V+lE5K4b58F8gGoMibf1+iuebN1hBMU4UD023ie3YJe+QqnZxd8RHfq1sm9Wn40uSwvYK+rb953ObruAqbKm/Na+tqRVyhlkZapIlsz/BLxXULnij1kmWNI3BQz2y40kgT7Evp1uXMN//Lhv1c2QBKS2DuklgF/szLafqYNUZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxgJi0Txq8w31QC2E4t31qXvhsuSj0edgnTtVt/WrVo=;
 b=h3l9v/nm4a8i+/0+uSkuYX2IMSuhp3YAe6O+gOnNEPpEwDltTHBfdsnmx5ayLtvJy9/DhvNEUffRBr4CxO7jupICh/d92BiSmBhRioh8qipuoC2kNo2xahFxPJIetEgfuX7WE4sngZjLEIfsO7flzpuSGwkwkOT/q55oANwnxU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by CH2PR12MB4891.namprd12.prod.outlook.com (2603:10b6:610:36::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 06:46:32 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 06:46:32 +0000
Message-ID: <3e32bec6-5e59-c66a-7676-7d15df2c961c@amd.com>
Date:   Wed, 30 Aug 2023 12:16:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 6/7] sched: Implement shared runqueue in CFS
Content-Language: en-US
To:     David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        aaron.lu@intel.com, wuyun.abel@bytedance.com, kernel-team@meta.com
References: <20230809221218.163894-1-void@manifault.com>
 <20230809221218.163894-7-void@manifault.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230809221218.163894-7-void@manifault.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::23) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|CH2PR12MB4891:EE_
X-MS-Office365-Filtering-Correlation-Id: db3bee68-d165-423b-6cda-08dba924d890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gi3sgzX8pah5v9FUvT8oU+UbdvCR76NJu4iy/Sd2nLdGe4nA35yJfC2KMu/d2js2Hy/PmLICkj4v/Ke4ydryJ9G957hMG0lrw423tBuIeNejQiewWxWuKleSHqRZ3GZLLr/Qzyat+VAbAmz7cayOWYBbViVNIFJAy1LrWbyObqt7rZrkEudWYWv0wvbIVZnrlhZ09Je7Osyf+ns/OPLejz9Gt8TC4RNpfkujGyTDHnIAOVddYTuSnVc6o5hXYxh9aPgCiF1Jn0G2ZFr0fBtYl3ddK9pQ7zl0pCHFQWBTBnmNDnxv0vRmwJZkShpGfS5VIVVD5bvUPS3boUPmdUOISGfjv9A+qNMXhA8QTTV8KZxZd4Ohwlowz9VmsEnCNcPZO4gNCZQ/9Dq27ib6Kl/b0TWKqmI3mBCNtI5tDVIKaZUNLOGvYC9cBgL5R1Nsf5z3RTyPsvDcwGBPwqOilrqbtG7wB3ng6ejwaNb1Sg58rovc7JmiHENmFwtMOsF71ABEUV2IAsj8XypnKmjMgcqV/lZkaWiyb6EO7TbbzGHQ+StKeapYYZZ22j0ncMPOsBRytyeJ2N2yz9R4tH7LkppEBfRUZYaXAyFeBtEtDFjihewtiTP3WZzRpujk2rYRU6XPcd8AvaxKYFBQv3XO+IGD3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199024)(1800799009)(186009)(36756003)(31686004)(83380400001)(86362001)(31696002)(7416002)(5660300002)(41300700001)(4326008)(8936002)(8676002)(53546011)(26005)(6506007)(6486002)(6666004)(2616005)(6512007)(478600001)(2906002)(30864003)(38100700002)(66556008)(66946007)(316002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjNobFBXS1F6VDhFZ0ZnZEJkM29pM045dDdON0FSSmR1U3plcDNrMVFRdEZO?=
 =?utf-8?B?RW0zbW1oQmE3bGRndVhRYmw3dThRYWp3TjZJQ2xlTzFwcG4vOUQ0b2lXVVZj?=
 =?utf-8?B?U1JzLzZVZWRBZ3VTYWFabHlEZ3lYTWJtckNvUEl6MXhMTGRTVnZ4aXQ3aHlx?=
 =?utf-8?B?cWMwcFZDelFVbFhrMHNWc3VoSnA2aVhOckE3Skh4L3JTK1VzN3Nrc0VoM3U4?=
 =?utf-8?B?V3BMWFVCMFlWbXdKOTJ5bnVZNVhnWWpqR3NoeVpvTjVxS3hTUWI5UFhsZExl?=
 =?utf-8?B?bmdpWEJMc1RKdzlHY2ZzU3dnZUdQWnNLNkNPODlua0c1a0FhS01hUjVIKzZL?=
 =?utf-8?B?WUgxOHFLUHpvZExDREhVbW1Hemhmak1yU1EybGJuZWNwbm05RGNabjVhVlV3?=
 =?utf-8?B?YXR2cDMwOWs3SUVzdE51RFVocGZRZzllQXFXYXBObVcxUkJjd0JqdkFiSnpL?=
 =?utf-8?B?bW9HZ0E5YlJNK2I2QWdqa2w3ZFdBZUVMaFVKNDZwcUR2USt2SFIrQjM0UjJn?=
 =?utf-8?B?Qy9PbHJCZGZ1c0gwVGp0TXQ2aU9SVFU3SmJ1bFlsTUhKa29wZzczV25oZ3N2?=
 =?utf-8?B?dGtqVEVPUExnWnZNK1JTMFl5a2ltYVNCMitSWFBRbTE0WmtrQmpuZEJjU0dw?=
 =?utf-8?B?SHRQS0c0aWRjYjVKa0F5WFZQRVBLZlRKcURBZDVFU21lbkhBNXhFZGRQazdB?=
 =?utf-8?B?VEVUWGozcWJWSmZURW5XbzVFZDROV3RmTEdVVkc1ZWdZdXlwVVBZL3ZxSGVT?=
 =?utf-8?B?RllwaW90eEJrRFRadkN6OVlmL0xPdWtZdnJkQkVFOGxQNTM4b1ovZld2eFRi?=
 =?utf-8?B?aDNNZEZBREd2TEpzYzljb2U0VEl4UzFWU1VvUUtQZWY2cTQ1MS9vQ09kRmhn?=
 =?utf-8?B?VHJGQ1NRRUZDQ3BWMzdJUFRSQVpsTjNBL2ZuTDhKT2x0aUtQZHhlaHJWelNL?=
 =?utf-8?B?M3YrdUk0SUEwaHRIWTkzWmZzVTNacjIzK1pqSE90U3lTR2ttK1FPSEJjR25r?=
 =?utf-8?B?emJISjFMS2NDZjFZZklGYmFUbFVyNExVZ1BPZDdhUUN4VEE0dU5SUmVXS05R?=
 =?utf-8?B?ZGtXZlJxTHhNeVRwR1R2QjdYRWZiem41SnEzMzdoNjJicUlnTzAwcnVxcWRO?=
 =?utf-8?B?LzNwcy9zWnE1NDFvSjhVcnY0RmFMd1laV0NsN1pYcWFlQ1hYeGJsQmJseVBu?=
 =?utf-8?B?bVE4VG1zTSt1ZTZ6MXVqNm9tWmtSOFFoSGQ3dEVDR211WU04TFRZa2hHWWxw?=
 =?utf-8?B?czM1a1NPaUVNYjViMFdRNExwTThTQjRtc1U1S2hlejlYQnYxK09tSkVkYkJY?=
 =?utf-8?B?RS9KMVRLbTdsZ2xhb3JBZ2t5WWpoY2JrSXlDZ2g5Zm85a1N3bEJVWitvQWht?=
 =?utf-8?B?bGVaMEdsVGFnWERVcG1VT0t0MEZUNTRGV0EvNFFrZHVqWUt0c1JZRkdLUFgr?=
 =?utf-8?B?cG16cGZiN1FCakpKaVNyWlFrMlB3Znc5UFY5Rkcvakc2b3l0S2pvdDNpd3ls?=
 =?utf-8?B?dUMxUVpZL1dZTS82NTMvYWFHSXFvWEliMW9wMGtJSzVSdWowdTlIMTYzY2Vv?=
 =?utf-8?B?ZU0xcDFJRk4vc3RVam1rcVZLa3V1WHFoeHV4a05CSEhPZVZERXFxNzBzRklu?=
 =?utf-8?B?VGR0TStTbnliZ2RNOW1FZ3djd0RSZlNJMnVFeFYwU0dzQlcxTGNGODNZR0FK?=
 =?utf-8?B?Ukp4dVFTRWdELzFhR1ZwbkVJS3RJZ0pUS29zWVI4V01NeTErdGJMb01PVzZX?=
 =?utf-8?B?d0NpSlhmN1JhMGo5UVhYd2doeWFpakFaQzE3YUtCNnRSZlprbjF1TmVXeXFl?=
 =?utf-8?B?Nm00NDVsZGx0SDRMQ1R4VzJBSWh3ZHRmdFI5OEtrd2VKSXQ4a084ZEh6R3lJ?=
 =?utf-8?B?SVgrZWhWV05xNFNRY0xoRkN2ZDhSdmR4TU9uNTh0UFgyT091d3VnUkFXb05q?=
 =?utf-8?B?aGF1ZEtWbFZzeERVTmNEM1ZxdmtwVVpXajdydzJZdVdoMmx6Ym1FTEQzZy8r?=
 =?utf-8?B?ZEJxdXFaODNoc1VjOU5pSjRiS0dPV05EbFppTVZZR3RLeXRBKzFvZ05OVURm?=
 =?utf-8?B?OSs0OVRHd0pFYmg3Rkt3TUtaWFg2R3p2QlJlMjN3RE9ZL1BSbGlSR0lIVDk1?=
 =?utf-8?Q?dSJfDS09jxg8AVet281Jvz2A3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3bee68-d165-423b-6cda-08dba924d890
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 06:46:32.4179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eajXr4rZnx7qj/2OmRX9Tyhw2FoUozUwgvuE6OLrj7Hh8TrcC/9m0V0NqC+MrKPCu42tseOTfhNMegUmxP0Z8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4891
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        LOTS_OF_MONEY,MONEY_NOHTML,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On 8/10/2023 3:42 AM, David Vernet wrote:
> [..snip..]
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 2aab7be46f7e..8238069fd852 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -769,6 +769,8 @@ struct task_struct {
>  	unsigned long			wakee_flip_decay_ts;
>  	struct task_struct		*last_wakee;
>  
> +	struct list_head		shared_runq_node;
> +
>  	/*
>  	 * recent_used_cpu is initially set as the last CPU used by a task
>  	 * that wakes affine another task. Waker/wakee relationships can
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 385c565da87f..fb7e71d3dc0a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4529,6 +4529,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
>  #ifdef CONFIG_SMP
>  	p->wake_entry.u_flags = CSD_TYPE_TTWU;
>  	p->migration_pending = NULL;
> +	INIT_LIST_HEAD(&p->shared_runq_node);
>  #endif
>  	init_sched_mm_cid(p);
>  }
> @@ -9764,6 +9765,18 @@ int sched_cpu_deactivate(unsigned int cpu)
>  	return 0;
>  }
>  
> +void sched_update_domains(void)
> +{
> +	const struct sched_class *class;
> +
> +	update_sched_domain_debugfs();
> +
> +	for_each_class(class) {
> +		if (class->update_domains)
> +			class->update_domains();
> +	}
> +}
> +
>  static void sched_rq_cpu_starting(unsigned int cpu)
>  {
>  	struct rq *rq = cpu_rq(cpu);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9c23e3b948fc..6e740f8da578 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -139,20 +139,235 @@ static int __init setup_sched_thermal_decay_shift(char *str)
>  }
>  __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
>  
> +/**
> + * struct shared_runq - Per-LLC queue structure for enqueuing and migrating
> + * runnable tasks within an LLC.
> + *
> + * WHAT
> + * ====
> + *
> + * This structure enables the scheduler to be more aggressively work
> + * conserving, by placing waking tasks on a per-LLC FIFO queue that can then be
> + * pulled from when another core in the LLC is going to go idle.
> + *
> + * struct rq stores a pointer to its LLC's shared_runq via struct cfs_rq.
> + * Waking tasks are enqueued in the calling CPU's struct shared_runq in
> + * __enqueue_entity(), and are opportunistically pulled from the shared_runq
> + * in newidle_balance(). Tasks enqueued in a shared_runq may be scheduled prior
> + * to being pulled from the shared_runq, in which case they're simply dequeued
> + * from the shared_runq in __dequeue_entity().
> + *
> + * There is currently no task-stealing between shared_runqs in different LLCs,
> + * which means that shared_runq is not fully work conserving. This could be
> + * added at a later time, with tasks likely only being stolen across
> + * shared_runqs on the same NUMA node to avoid violating NUMA affinities.
> + *
> + * HOW
> + * ===
> + *
> + * A shared_runq is comprised of a list, and a spinlock for synchronization.
> + * Given that the critical section for a shared_runq is typically a fast list
> + * operation, and that the shared_runq is localized to a single LLC, the
> + * spinlock will typically only be contended on workloads that do little else
> + * other than hammer the runqueue.
> + *
> + * WHY
> + * ===
> + *
> + * As mentioned above, the main benefit of shared_runq is that it enables more
> + * aggressive work conservation in the scheduler. This can benefit workloads
> + * that benefit more from CPU utilization than from L1/L2 cache locality.
> + *
> + * shared_runqs are segmented across LLCs both to avoid contention on the
> + * shared_runq spinlock by minimizing the number of CPUs that could contend on
> + * it, as well as to strike a balance between work conservation, and L3 cache
> + * locality.
> + */
> +struct shared_runq {
> +	struct list_head list;
> +	raw_spinlock_t lock;
> +} ____cacheline_aligned;
> +
>  #ifdef CONFIG_SMP
> +
> +static DEFINE_PER_CPU(struct shared_runq, shared_runqs);
> +
> +static struct shared_runq *rq_shared_runq(struct rq *rq)
> +{
> +	return rq->cfs.shared_runq;
> +}
> +
> +static void shared_runq_reassign_domains(void)
> +{
> +	int i;
> +	struct shared_runq *shared_runq;
> +	struct rq *rq;
> +	struct rq_flags rf;
> +
> +	for_each_possible_cpu(i) {
> +		rq = cpu_rq(i);
> +		shared_runq = &per_cpu(shared_runqs, per_cpu(sd_llc_id, i));
> +
> +		rq_lock(rq, &rf);
> +		rq->cfs.shared_runq = shared_runq;
> +		rq_unlock(rq, &rf);
> +	}
> +}
> +
> +static void __shared_runq_drain(struct shared_runq *shared_runq)
> +{
> +	struct task_struct *p, *tmp;
> +
> +	raw_spin_lock(&shared_runq->lock);
> +	list_for_each_entry_safe(p, tmp, &shared_runq->list, shared_runq_node)
> +		list_del_init(&p->shared_runq_node);
> +	raw_spin_unlock(&shared_runq->lock);
> +}
> +
> +static void update_domains_fair(void)
> +{
> +	int i;
> +	struct shared_runq *shared_runq;
> +
> +	/* Avoid racing with SHARED_RUNQ enable / disable. */
> +	lockdep_assert_cpus_held();
> +
> +	shared_runq_reassign_domains();
> +
> +	/* Ensure every core sees its updated shared_runq pointers. */
> +	synchronize_rcu();
> +
> +	/*
> +	 * Drain all tasks from all shared_runq's to ensure there are no stale
> +	 * tasks in any prior domain runq. This can cause us to drain live
> +	 * tasks that would otherwise have been safe to schedule, but this
> +	 * isn't a practical problem given how infrequently domains are
> +	 * rebuilt.
> +	 */
> +	for_each_possible_cpu(i) {
> +		shared_runq = &per_cpu(shared_runqs, i);
> +		__shared_runq_drain(shared_runq);
> +	}
> +}
> +
>  void shared_runq_toggle(bool enabling)
> -{}
> +{
> +	int cpu;
> +
> +	if (enabling)
> +		return;
> +
> +	/* Avoid racing with hotplug. */
> +	lockdep_assert_cpus_held();
> +
> +	/* Ensure all cores have stopped enqueueing / dequeuing tasks. */
> +	synchronize_rcu();
> +
> +	for_each_possible_cpu(cpu) {
> +		int sd_id;
> +
> +		sd_id = per_cpu(sd_llc_id, cpu);
> +		if (cpu == sd_id)
> +			__shared_runq_drain(rq_shared_runq(cpu_rq(cpu)));
> +	}
> +}
> +
> +static struct task_struct *shared_runq_pop_task(struct rq *rq)
> +{
> +	struct task_struct *p;
> +	struct shared_runq *shared_runq;
> +
> +	shared_runq = rq_shared_runq(rq);
> +	if (list_empty(&shared_runq->list))
> +		return NULL;
> +
> +	raw_spin_lock(&shared_runq->lock);
> +	p = list_first_entry_or_null(&shared_runq->list, struct task_struct,
> +				     shared_runq_node);
> +	if (p && is_cpu_allowed(p, cpu_of(rq)))
> +		list_del_init(&p->shared_runq_node);

I wonder if we should remove the task from the list if
"is_cpu_allowed()" return false.

Consider the following scenario: A task that does not sleep, is pinned
to single CPU. Since this is now at the head of the list, and cannot be
moved, we leave it there, but since the task also never sleeps, it'll
stay there, thus preventing the queue from doing its job.

Further implication ...  

> +	else
> +		p = NULL;
> +	raw_spin_unlock(&shared_runq->lock);
> +
> +	return p;
> +}
> +
> +static void shared_runq_push_task(struct rq *rq, struct task_struct *p)
> +{
> +	struct shared_runq *shared_runq;
> +
> +	shared_runq = rq_shared_runq(rq);
> +	raw_spin_lock(&shared_runq->lock);
> +	list_add_tail(&p->shared_runq_node, &shared_runq->list);
> +	raw_spin_unlock(&shared_runq->lock);
> +}
>  
>  static void shared_runq_enqueue_task(struct rq *rq, struct task_struct *p)
> -{}
> +{
> +	/*
> +	 * Only enqueue the task in the shared runqueue if:
> +	 *
> +	 * - SHARED_RUNQ is enabled
> +	 * - The task isn't pinned to a specific CPU
> +	 */
> +	if (p->nr_cpus_allowed == 1)
> +		return;
> +
> +	shared_runq_push_task(rq, p);
> +}
>  
>  static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
>  {
> -	return 0;
> +	struct task_struct *p = NULL;
> +	struct rq *src_rq;
> +	struct rq_flags src_rf;
> +	int ret = -1;
> +
> +	p = shared_runq_pop_task(rq);
> +	if (!p)
> +		return 0;

...

Since we return 0 here in such a scenario, we'll take the old
newidle_balance() path but ...

> +
> +	rq_unpin_lock(rq, rf);
> +	raw_spin_rq_unlock(rq);
> +
> +	src_rq = task_rq_lock(p, &src_rf);
> +
> +	if (task_on_rq_queued(p) && !task_on_cpu(src_rq, p)) {
> +		update_rq_clock(src_rq);
> +		src_rq = move_queued_task(src_rq, &src_rf, p, cpu_of(rq));
> +		ret = 1;
> +	}
> +
> +	if (src_rq != rq) {
> +		task_rq_unlock(src_rq, p, &src_rf);
> +		raw_spin_rq_lock(rq);
> +	} else {
> +		rq_unpin_lock(rq, &src_rf);
> +		raw_spin_unlock_irqrestore(&p->pi_lock, src_rf.flags);
> +	}
> +	rq_repin_lock(rq, rf);
> +
> +	return ret;
>  }
>  
>  static void shared_runq_dequeue_task(struct task_struct *p)
> -{}
> +{
> +	struct shared_runq *shared_runq;
> +
> +	if (!list_empty(&p->shared_runq_node)) {
> +		shared_runq = rq_shared_runq(task_rq(p));
> +		raw_spin_lock(&shared_runq->lock);
> +		/*
> +		 * Need to double-check for the list being empty to avoid
> +		 * racing with the list being drained on the domain recreation
> +		 * or SHARED_RUNQ feature enable / disable path.
> +		 */
> +		if (likely(!list_empty(&p->shared_runq_node)))
> +			list_del_init(&p->shared_runq_node);
> +		raw_spin_unlock(&shared_runq->lock);
> +	}
> +}
>  
>  /*
>   * For asym packing, by default the lower numbered CPU has higher priority.
> @@ -12093,6 +12308,16 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  	rcu_read_lock();
>  	sd = rcu_dereference_check_sched_domain(this_rq->sd);
>  
> +	/*
> +	 * Skip <= LLC domains as they likely won't have any tasks if the
> +	 * shared runq is empty.
> +	 */

... now we skip all the way ahead of MC domain, overlooking any
imbalance that might still exist within the SMT and MC groups
since shared runq is not exactly empty.

Let me know if I've got something wrong!

> +	if (sched_feat(SHARED_RUNQ)) {
> +		sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
> +		if (likely(sd))
> +			sd = sd->parent;
> +	}

Speaking of skipping ahead of MC domain, I don't think this actually
works since the domain traversal uses the "for_each_domain" macro
which is defined as:

#define for_each_domain(cpu, __sd) \
	for (__sd = rcu_dereference_check_sched_domain(cpu_rq(cpu)->sd); \
			__sd; __sd = __sd->parent)

The traversal starts from rq->sd overwriting your initialized value
here. This is why we see "load_balance count on cpu newly idle" in
Gautham's first report
(https://lore.kernel.org/lkml/ZN3dW5Gvcb0LFWjs@BLR-5CG11610CF.amd.com/)
to be non-zero.

One way to do this would be as follows:

static int newidle_balance() {

	...
	for_each_domain(this_cpu, sd) {

		...
		/* Skip balancing until LLc domain */
		if (sched_feat(SHARED_RUNQ) &&
		    (sd->flags & SD_SHARE_PKG_RESOURCES))
			continue;

		...
	}
	...
}

With this I see the newidle balance count for SMT and MC domain
to be zero:

< ----------------------------------------  Category:  newidle (SMT)  ---------------------------------------- >
load_balance cnt on cpu newly idle                         :          0    $      0.000 $    [    0.00000 ]
--
< ----------------------------------------  Category:  newidle (MC)   ---------------------------------------- >
load_balance cnt on cpu newly idle                         :          0    $      0.000 $    [    0.00000 ]
--
< ----------------------------------------  Category:  newidle (DIE)  ---------------------------------------- >
load_balance cnt on cpu newly idle                         :       2170    $      9.319 $    [   17.42832 ]
--
< ----------------------------------------  Category:  newidle (NUMA) ---------------------------------------- >
load_balance cnt on cpu newly idle                         :         30    $    674.067 $    [    0.24094 ]
--

Let me know if I'm missing something here :)

Note: The lb counts for DIE and NUMA are down since I'm experimenting
with the implementation currently. I'll update of any new findings on
the thread.

> +
>  	if (!READ_ONCE(this_rq->rd->overload) ||
>  	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
>  
> [..snip..]
 
--
Thanks and Regards,
Prateek
