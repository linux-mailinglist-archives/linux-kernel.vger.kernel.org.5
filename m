Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CC878DF96
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245379AbjH3TQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245533AbjH3P1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:27:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7766983
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693409238; x=1724945238;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XSEorfSNMLDjmbc/Z+jBU61T5GXgIaoP9CoOBQ1EpI8=;
  b=LQAPNEuY7xif/2NuRaxUH5MjZubx2JnpvMGW4p5jRTPJ/p9YMhslwGMY
   UZNuh+fTQUMfcK2r9hOhynfcVHQbnqGV7m0yAStg3jrEBrKOMjQYkqJMu
   GbQ0Cx8e2yVJDV9HJ/lVFKRHf3/3Xqz9PgayNxZzKad9BXI4kAEr1UEzq
   yiKFMcsgeW1/CsJdxKCb2e4pi3C1RwlCz8MY5o7ketVv8IegEynxz6MeI
   FjwBTeHwKQi7NO5VOVPfqo/CDp6dSPEIU/ur4Ys/xUarW32uGWxeDtaKB
   gs92ShONGPwMUEx8H44YvSh2bpur7tQS8i/XNQjc3GgnWHRz9fIQoLybD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="375628157"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="375628157"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 08:27:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="853769123"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="853769123"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 30 Aug 2023 08:27:17 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 08:27:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 08:27:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 08:27:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClcnTfTTKVwLUAI6xvYEOTMMT1H4xaQTnT2Ta5L9SxHiyYxgF185c8dIzXU/guNq0uTlR/Cs7brWyr2nKuwmkCxy6FRH/l6tDB9uSAvxZWraOcnsf8+ChJb/Ztfcb13T/hgt2O2BbbyAGjRDGEUotfKYM4ZBzAXE5iMpcJW0Z5EzhGJbqw9VDzU8KpOGiSc8Uy86SiT2F6oGv46KqKsV/SJCvpt213xsg6V49B/LneYTCakFV9O1a8SZoK+Bm7XoXilUDEuNygLbhtAmEks57y6FKxQnQ6sGpXuhiF92dzae9YkpkiP7qsrHTwOlR49Aas+CLxO9XiT94hCe2sOhvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95VGNGxcpo3qBCGF3gqq4f+5E6r7uJ8JgH183OZ+Pj8=;
 b=ewCuk+DgLSbmBCGv5dNoGbI4ta60Hrxd2j5708bIybsSrmyFOTClCzO4VPQdWkwWB7iUsnzculBv32Ni/jZ0rRVxDhw6ZC6Xi9xP5hVWoOnPYU2l4y8iJ6BphZIY95iqXmdo91HvUDd35R6guMParZh4zHhiRlfECbmUN1hqewcWZ0WeqScrLm6wIlJiPa/6WDB22uDOeRLn52yBxTU2MsUhGLavwSSGa3WTuygE9gWl8wUa6FADUUj5niDqG9x9teHdC1NGyrbojnuZ2Vtejt5X9ODic210K92KEh3N1vvECtIaw9AAq5hGTYxIOZQVG0Ai2cznX30UmyNUbcgxFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by MN0PR11MB6035.namprd11.prod.outlook.com (2603:10b6:208:376::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 15:27:13 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 15:27:13 +0000
Date:   Wed, 30 Aug 2023 23:26:54 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
CC:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        "Tim Chen" <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        "Chen Yu" <yu.chen.surf@gmail.com>, Aaron Lu <aaron.lu@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH 0/7] Optimization to reduce the cost of newidle
 balance
Message-ID: <ZO9fvgovn/MtLVzZ@chenyu5-mobl2>
References: <cover.1690273854.git.yu.c.chen@intel.com>
 <8561f192-ccd0-c2e3-3115-8cf09a7d3e55@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8561f192-ccd0-c2e3-3115-8cf09a7d3e55@linux.vnet.ibm.com>
X-ClientProxiedBy: SG2PR01CA0153.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::33) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|MN0PR11MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: 07844090-05a1-4407-0e78-08dba96d958c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DCejgL2XVyh0a6wmKGUlkoZ9BjUhJovyVKeMcgS4k3grn/OXAsJvJfBVTTy1/ylSlE6xduxfWhFvnoDRbCpxVnuotFcmT1VxUpTpGJsoESBt6vIOTmUB5XDrKRrNU0my32vYglQQhNZhjQBw6GAN3fL4IBSxnXsDa+Yxej+d1MxrArjRl5BSnKNqRKCeBCO5gjRHe+HsCeaXObj0Rexg/yGuX8lbB9aEe65riVXaz0lrPRU6joYQxPF7P/y6V4khgdkaxGLNgqoZpBB/AZin1mTEWW8tuH9Z4Ur3ayjcXW7qfCZi8OOmOL5boAtvUZgfhBFwLH09Rwip40p6Kq+wZ+kx4XiOYSB3/ise5PXzbnTcsEKQU35zUoP7DHnDR7wxQNrVvI6OPCoW223gFcnCRSoNke7OsfqIn8ev6LWpleorsVcFwHDU6eI0q9aDuS+yA6ODkCCutiyYQmdeuD6iU4jd0oXGxadXEq/I7wHJxOS2fJIGzY+5GVVNIPw4IlMF3/L93zPLfiK3T476iSUDWwrd2hTbRBrU9XuEornwJWiiL45z2BWsSMuO0AIXA9Zd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(396003)(136003)(39860400002)(366004)(186009)(451199024)(1800799009)(33716001)(83380400001)(4326008)(86362001)(7416002)(41300700001)(5660300002)(8676002)(8936002)(53546011)(26005)(6506007)(6486002)(6666004)(6512007)(9686003)(478600001)(38100700002)(2906002)(54906003)(66476007)(66946007)(66556008)(82960400001)(316002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yBSBT6bfJup7bnO3W/quFtGL9fK9jMgu6rk1eqN5MhtkhwkM5LFDhQ1Tw5wt?=
 =?us-ascii?Q?IzEA6/O2GTRGK2NjpIt7GZ/VVCku1VMfjNQs3DQUtVJ9mtniSZCSk07rswS4?=
 =?us-ascii?Q?IA/dWR/XzU65D+DgQJr1ctmoUrCSxXJgHXJ0zaaZLrNsA3fmbWl1qe0q0Mze?=
 =?us-ascii?Q?ErmMjJlWVjLrckeuB6uKj2i2CGgpR6wx3uD0yPIcpbNJALMU1u9k3RC4gt+A?=
 =?us-ascii?Q?d2n9PRuPsPfjYw+3zvqwgKb3ebVEVopehki7diDG/DmmLMu9syhzdLcth8yF?=
 =?us-ascii?Q?LgrbljsxKYuW2yl3xoXFDtWE3hlQTfbohnXPLT6g42jyAh9P1wClkmVX1LA3?=
 =?us-ascii?Q?OcnNvGLbEepL7JW6rMDYkI7doFmHF9nA8psf0UzD7iURaYgBiqR8pSoN6Rm3?=
 =?us-ascii?Q?ioSW56CyM6t+SoGyo9USSOb7RWi+iIgi77ABh/5FcMl3YmfmQ0nrot+YdwlI?=
 =?us-ascii?Q?A2biDrBZ1nOclp8MG4qQ037OG7YdyeBChRQQJ50Ks7cPcT2dxztc2ItDCRuB?=
 =?us-ascii?Q?aAoC0iPovtUGeQBYp+Yo4BJ4ldEgtqKZ3AMSdfpq0vGanLdjagVVS1p09aed?=
 =?us-ascii?Q?LpAUhr+Bh0rfzNGTXQ3DQrsEjYc6ck1GNH3e35sI/F62kyrpQdxY1DWunWov?=
 =?us-ascii?Q?meunvT1c5hOkHECOOR0suRRe8orHWNoVfKOvbGrU5/oyjvrxgVymxxfcdVi3?=
 =?us-ascii?Q?3xPciUv0jaf3d8JTaREODYIDycaG8l9pHnLwUWDSBJyBijMqH6nDpJooTodS?=
 =?us-ascii?Q?206FGHsVJUm9RjWZJWRbsYjYy55gkcU74lVA6h7KeWYBZg46u5r5IuG2hSbF?=
 =?us-ascii?Q?qgqnBasxvIpFqfDPB7DPAYcgX03+rOyZIMNQLDFidjHb6EAR1evQmzkMK2Qo?=
 =?us-ascii?Q?bLfJIOBr09NOJOxhhobxeY8ppAKfHXz8p3YCq81iUTS0aRPuoRdA5LvHQBKu?=
 =?us-ascii?Q?EnsQOxo3dqfQA/Od6XgRKfBGzTXywsZN+DTYLG4pW3brkpxMRqJ4Ncux3Sn1?=
 =?us-ascii?Q?kXof1fvIhVkjb7w4k1bXfmC4598xENGxTEFXA2PGsv+0GncrrDsvdOrAobij?=
 =?us-ascii?Q?hQw+gJLb53cuKy9uoIah1Fv9SH6MPulnuWM4xqYhiIvM6e8SKDn9zS4Qec8g?=
 =?us-ascii?Q?6YtKKGr/B8ozQ1EvDQaOoA4okMaUznF7jUIvlMZnFbwWShKmpCIzrpsDeCNR?=
 =?us-ascii?Q?lGq14A3PJE4KfPj6iuSxrM1XmztuWDNU0iyeMz2v8sQ62LOkKTmtEUaVdgAm?=
 =?us-ascii?Q?5Jjx6B+pu09ifiVtnBR9VXR3zRIVsLruQz8rSv2EZI1dvMPGjLrVNS63XVa4?=
 =?us-ascii?Q?Snk1aagTqWBGVOvv1BMHat0ocIrvn1pfZJAS8KjRGIPHNZOYEeQGmJ2z3rBd?=
 =?us-ascii?Q?z1eJDKp8vUDJ4C5D4ueN1R9836oFm+w3wROmk0ckw9hYN8eAjGmuUDdqg3gF?=
 =?us-ascii?Q?k/4v9hQ9RcDHPmAdeQUN/bafiArVwDMJ0mTDZXbOui9++31OZqSY/29V8rJ1?=
 =?us-ascii?Q?+Q6yN60y7Z9GtuioWsNDLi2V1V7y1M0Lbb88hZcn4rnAiNyGwD9DJ/i5UsKf?=
 =?us-ascii?Q?rN8tuieXDBudPS/V0xM71PRNhVyNnESnAqjKtFxM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07844090-05a1-4407-0e78-08dba96d958c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 15:27:13.0898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMK1A7S3UyG/0rotlXzrWQNYXz3yTDHXAXu8+HoMRJoXOLFHCShW9Rc1rYmSiPcyq4+/OwjZhSdvi/yDVIwETg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6035
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shrikanth,

On 2023-08-25 at 13:18:56 +0530, Shrikanth Hegde wrote:
> 
> On 7/27/23 8:03 PM, Chen Yu wrote:
> 
> Hi Chen. It is a nice patch series in effort to reduce the newidle cost. 
> This gives the idea of making use of calculations done in load_balance to used 
> among different idle types. 
>

Thanks for taking a look at this patch set.
 
> It was interesting to see how this would work on Power Systems. The reason being we have 
> large core count and LLC size is small. i.e at small core level (llc_weight=4). This would
> mean quite frequest access sd_share at different level which would reside on the first_cpu of 
> the sched domain, which might result in more cache-misses. But perf stats didnt show the same.
>

Do you mean 1 large domain(Die domain?) has many LLC sched domains as its children,
and accessing the large domain's sd_share field would cross different LLCs and the
latency is high? Yes, this could be a problem and it depends on the hardware that how
fast differet LLCs snoop the data with each other.
On the other hand, the periodic load balance is the writer of sd_share, and the
interval is based on the cpu_weight of that domain. So the write might be less frequent
on large domains, and most access to sd_share would be the read issued by newidle balance,
which is less costly.
 
> Another concern on more number of sched  groups at DIE level, which might take a hit if 
> the balancing takes longer for the system to stabilize. 

Do you mean, if newidle balance does not pull tasks hard enough, the imbalance between groups
would last longer? Yes, Prateek has mentioned this point, the ILB_UTIL has this problem, I'll
think more about it. We want to find a way in newidle balance to do less scan, but still pulls
tasks as hard as before.

> 
> tl;dr
> 
> Tested with micro-benchmarks on system with 96 Cores with SMT=8. Total of 768 CPU's. There is some amount 

May I know the sched domain hierarchy of this platform?
grep . /sys/kernel/debug/sched/domains/cpu0/domain*/*
cat /proc/schedstat  | grep cpu0 -A 4  (4 domains?)

> of regression with hackbench and schbench. haven't looked into why. Any pointers to check would be helpful.

May I know what is the command to run hackbench and schbench below? For example
the fd number, package size and the loop number of hackbench, and
number of message thread and worker thread of schbench, etc. I assume
you are using the old schbench? As the latest schbench would track other metrics
besides tail latency.


> Did a test with more real case workload that we have called daytrader. Its is DB workload which gives total
> transcations done per second. That doesn't show any regression.
> 
> Its true that all benchmarks will not be happy.
> Maybe in below cases, newidle may not be that costly. Do you have any specific benchmark to be tried? 
> 

Previously I tested schbench/hackbench/netperf/tbench/sqlite, and also I'm planning
to try an OLTP.

> -----------------------------------------------------------------------------------------------------
> 					6.5.rc4			6.5.rc4 + PATCH_V2 		gain					
> Daytrader:				55049				55378			0.59%
> 
> -----------------------------------------------------------------------------------------------------
> hackbench(50 iterations):			   6.5.rc4	6.5.rc4 + PATCH_V2(gain%)
> 
> 
> Process 10 groups                    :       0.19,       0.19(0.00)             
> Process 20 groups                    :       0.23,       0.24(-4.35)            
> Process 30 groups                    :       0.28,       0.30(-7.14)            
> Process 40 groups                    :       0.38,       0.40(-5.26)            
> Process 50 groups                    :       0.43,       0.45(-4.65)            
> Process 60 groups                    :       0.51,       0.51(0.00)             
> thread 10 Time                       :       0.21,       0.22(-4.76)            
> thread 20 Time                       :       0.27,       0.32(-18.52)           
> Process(Pipe) 10 Time                :       0.17,       0.17(0.00)             
> Process(Pipe) 20 Time                :       0.23,       0.23(0.00)             
> Process(Pipe) 30 Time                :       0.28,       0.28(0.00)             
> Process(Pipe) 40 Time                :       0.33,       0.32(3.03)             
> Process(Pipe) 50 Time                :       0.38,       0.36(5.26)             
> Process(Pipe) 60 Time                :       0.40,       0.39(2.50)             
> thread(Pipe) 10 Time                 :       0.14,       0.14(0.00)             
> thread(Pipe) 20 Time                 :       0.20,       0.19(5.00) 
> 
> Observation: lower is better. socket based runs show regression quite a bit, 
> pipe shows slight improvement. 
> 
> 
> -----------------------------------------------------------------------------------------------------
> Unixbench(10 iterations):			   6.5.rc4	6.5.rc4 + PATCH_V2(gain%)
> 
> 1 X Execl Throughput                  :    4280.15,    4398.30(2.76)           
> 4 X Execl Throughput                  :    8171.60,    8061.60(-1.35)            
> 1 X Pipe-based Context Switching      :  172455.50,  174586.60(1.24)           
> 4 X Pipe-based Context Switching      :  633708.35,  664659.85(4.88)           
> 1 X Process Creation                  :    6891.20,    7056.85(2.40)           
> 4 X Process Creation                  :    8826.20,    8996.25(1.93)           
> 1 X Shell Scripts (1 concurrent)      :    9272.05,    9456.10(1.98)           
> 4 X Shell Scripts (1 concurrent)      :   27919.60,   25319.75(-9.31)            
> 1 X Shell Scripts (8 concurrent)      :    4462.70,    4392.75(-1.57)            
> 4 X Shell Scripts (8 concurrent)      :   11852.30,   10820.70(-8.70) 
> 
> Observation: higher is better. Results are somewhat mixed.  
> 
> 
> -----------------------------------------------------------------------------------------------------
> schbench(10 iterations)			 6.5.rc4	6.5.rc4 + PATCH_V2(gain%)
> 
> 1 Threads                                                                       
> 50.0th:                                   8.00,       7.00(12.50)               
> 75.0th:                                   8.00,       7.60(5.00)                
> 90.0th:                                   8.80,       8.00(9.09)                
> 95.0th:                                  10.20,       8.20(19.61)               
> 99.0th:                                  13.60,      11.00(19.12)               
> 99.5th:                                  14.00,      12.80(8.57)                
> 99.9th:                                  15.80,      35.00(-121.52)             
> 2 Threads                                                                       
> 50.0th:                                   8.40,       8.20(2.38)                
> 75.0th:                                   9.00,       8.60(4.44)                
> 90.0th:                                  10.20,       9.60(5.88)                
> 95.0th:                                  11.20,      10.20(8.93)                
> 99.0th:                                  14.40,      11.40(20.83)               
> 99.5th:                                  14.80,      12.80(13.51)               
> 99.9th:                                  17.60,      14.80(15.91)               
> 4 Threads                                                                       
> 50.0th:                                  10.60,      10.40(1.89)                
> 75.0th:                                  12.20,      11.60(4.92)                
> 90.0th:                                  13.60,      12.60(7.35)                
> 95.0th:                                  14.40,      13.00(9.72)                
> 99.0th:                                  16.40,      15.60(4.88)                
> 99.5th:                                  16.80,      16.60(1.19)                
> 99.9th:                                  22.00,      29.00(-31.82)              
> 8 Threads                                                                       
> 50.0th:                                  12.00,      11.80(1.67)                
> 75.0th:                                  14.40,      14.40(0.00)                
> 90.0th:                                  17.00,      18.00(-5.88)               
> 95.0th:                                  19.20,      19.80(-3.13)               
> 99.0th:                                  23.00,      24.20(-5.22)               
> 99.5th:                                  26.80,      29.20(-8.96)               
> 99.9th:                                  68.00,      97.20(-42.94)  
> 16 Threads                                                                      
> 50.0th:                                  18.00,      18.20(-1.11)               
> 75.0th:                                  23.20,      23.60(-1.72)               
> 90.0th:                                  28.00,      27.40(2.14)                
> 95.0th:                                  31.20,      30.40(2.56)                
> 99.0th:                                  38.60,      38.20(1.04)                
> 99.5th:                                  50.60,      50.40(0.40)                
> 99.9th:                                 122.80,     108.00(12.05)               
> 32 Threads                                                                      
> 50.0th:                                  30.00,      30.20(-0.67)               
> 75.0th:                                  42.20,      42.60(-0.95)               
> 90.0th:                                  52.60,      55.40(-5.32)               
> 95.0th:                                  58.60,      63.00(-7.51)               
> 99.0th:                                  69.60,      78.20(-12.36)              
> 99.5th:                                  79.20,     103.80(-31.06)              
> 99.9th:                                 171.80,     209.60(-22.00)
> 
> Observation: lower is better. tail latencies seem to go up. schbench also has run to run variations.
> 
> -----------------------------------------------------------------------------------------------------
> stress-ng(20 iterations)	   6.5.rc4	6.5.rc4 + PATCH_V2(gain%)
> 	 ( 100000 cpu-ops)
> 
> --cpu=768 Time               :       1.58,       1.53(3.16)                     
> --cpu=384 Time               :       1.66,       1.63(1.81)                     
> --cpu=192 Time               :       2.67,       2.77(-3.75)                    
> --cpu=96 Time                :       3.70,       3.69(0.27)                     
> --cpu=48 Time                :       5.73,       5.69(0.70)                     
> --cpu=24 Time                :       7.27,       7.26(0.14)                     
> --cpu=12 Time                :      14.25,      14.24(0.07)                     
> --cpu=6 Time                 :       28.42,      28.40(0.07)                    
> --cpu=3 Time                 :      56.81,      56.68(0.23)                     
> --cpu=768 -util=10 Time      :       3.69,       3.70(-0.27)                    
> --cpu=768 -util=20 Time      :       5.67,       5.70(-0.53)                    
> --cpu=768 -util=30 Time      :       7.08,       7.12(-0.56)                    
> --cpu=768 -util=40 Time      :       8.23,       8.27(-0.49)                    
> --cpu=768 -util=50 Time      :       9.22,       9.26(-0.43)                    
> --cpu=768 -util=60 Time      :      10.09,      10.15(-0.59)                    
> --cpu=768 -util=70 Time      :      10.93,      10.98(-0.46)                    
> --cpu=768 -util=80 Time      :      11.79,      11.79(0.00)                     
> --cpu=768 -util=90 Time      :      12.63,      12.60(0.24) 
> 
> 
> Observation: lower is better. Almost no difference.

I'll try to run the same tests of hackbench/schbench on my machine, to
see if I could find any clue for the regression.


thanks,
Chenyu
