Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5357558F8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 03:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjGQBJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 21:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjGQBJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 21:09:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FE91B4;
        Sun, 16 Jul 2023 18:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689556179; x=1721092179;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VMYttp+OsKD42PIdqaXkxOwWLWULv3BDQ5DaFXpoEBk=;
  b=Y8jh4zh7+lWKYzDIPFJYUt05a4f4sAd7hgn7z6yU5mw3qlkf22kqflvA
   gE/L2Tqlc+d8IRrSD10c+XbdbvK/bq4adxKYJ2P0IVKmMqCS7JfwDxeNY
   qjCiGRflLzlTbgjpUtte+cGHiyP9BUv4Ksek2b/bBd142TDhqqgSfYGNc
   pMW00+c5LgdmyA6hKe1cKneMkat15FmTFGXsbHogNrvlTV3FzvbWWiISL
   VRvREaGaWpWtzo65d/mJ19cBHh86ejEnwOpMkiJnFf9ZcTzbq0R6etnBn
   BbnP3DuxWdN/WDAcqkAxtSe4AebvUOgiovtPovOdFkCRTfpqEhGD/a+fJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="365860304"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="365860304"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 18:09:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="847106120"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="847106120"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 16 Jul 2023 18:09:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 16 Jul 2023 18:09:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 16 Jul 2023 18:09:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 16 Jul 2023 18:09:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 16 Jul 2023 18:09:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjOUgALtOFzeV7XjMZ6Q3gQIheKTGp9lq7roSlWTj+CxxlOTOJDZ0oyutCSw3MXY5Y2bvbnGXvsnk//R28v6So2Z48/GrE8YEnjHTNMv6/59JgKdjK21Slgyna9Y1/tBPhLampFD4tzVc1w2kBrciuDV1nukIYBBN5vThRTLc4jtmpiyhvrIGrlUoRa33qy6YE9nfJndltNEsWjkbEtmrAQ3wsoXSMBntuFttaiL+6Ks23jjH4ZSQ40Gbc3m6DWz1PxnjWsh6D45pAkpOZvWT3WP3ukd1jurREz87wDsRibThjfJN/AD3bhf53tB+ek9agbyNZr08lN+QR7d028udw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9wboGPtbgUP4kPS5pTlGr7T+ABRSfyUaI9U/QJsnsY=;
 b=GG9M0/PV1xJJvfWH2X+wZyDV1pCxgB1xQ653Xp+EQaWYpO6reRdncenNbcgebwkTsDyL0G7A69QLlr5ksms8QgpCB0vhyZdKgAxuMA1WUclmLx4Hbnqt8794opy1Me+LTnWqUEtXHIMKVHXU5h4RntEg4LKiZOhGYN6OfziXRF34e754kHOLf+LHMugcaER/LYWmHyXDTOCTxn89fi/NcCwdTidjfkt4CoNvR/fgDN3Nsynjyro3e/VQxVEOgUrXTmMFscb1fun81VI9nY+pn1aWebVLKdi/U721mZxpa+NFDI5Yeyzo4DH1CkD+h3Cry0UvmouW/uq36TUFLZ9eZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 01:09:29 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 01:09:29 +0000
Date:   Mon, 17 Jul 2023 09:09:12 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-tip-commits@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>, <x86@kernel.org>,
        Gautham Shenoy <gautham.shenoy@amd.com>
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Message-ID: <ZLSUuEdwDQ2lbR/Z@chenyu5-mobl2>
References: <20230601144706.GA559454@hirez.programming.kicks-ass.net>
 <7bee9860-2d2a-067b-adea-04012516095c@amd.com>
 <20230602065438.GB620383@hirez.programming.kicks-ass.net>
 <bd083d8d-023a-698e-701b-725f1b15766e@amd.com>
 <20230613082536.GI83892@hirez.programming.kicks-ass.net>
 <f212f491-cd3f-6eee-20d7-8f9ab8937902@amd.com>
 <20230705115702.GY4253@hirez.programming.kicks-ass.net>
 <ZKlh1u2kkHzHY/nB@chenyu5-mobl2>
 <ZK7groqlP3S7r8vt@chenyu5-mobl2>
 <8702a92f-317e-c38f-48ec-5ac373ba5072@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8702a92f-317e-c38f-48ec-5ac373ba5072@amd.com>
X-ClientProxiedBy: SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CH0PR11MB5299:EE_
X-MS-Office365-Filtering-Correlation-Id: da40eebf-a71c-42be-56cc-08db8662785b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FONn0If7un/2W5WYThp9byRYr6d0Rmhh/Bc5XqtHBDTErC1vbIAEWoXxZD8K3mG7lcWqzJhS06WAXQS/OPoBOIhRZ71U8Nwlq10xXXqD+ImHqioK0wcbkj+Bq5JfsAlwr0+zj/0aIPnT8sNpCzDhDo4gTG896/ZBc+a5g4mSfBIT+WqTuA6FCfqpgKM6Cc8NAQefSH5sWYdPXgnIEDExq+m915MHCTyOUQGahwTLcy1kP9raqzhKoXR2oo5LI7qid8TmXquP7gdNt1VtRvud+UbCBTXZyS21UNuSl5qSXJqdKADzP1LNaM8mzF2VUE9qsWFDG/TxW92oCmUF+7Bb9/P6OTZEwi/8Z/F2aA6qX3SlyU6Prpsro8x2bYpS8ewHvGCSJHH2Wze8mDLetJYfVGCbl75JLxf08zMZ9F1PwzandyrhbxQTTZ9CSltfSrohZNDIpJVb0UjzYKjXxexeLVniAXYAoT8aBOdVm20v9zG9CFwyiu7PvuhsyMDsixytIkr+KV5VvF3ALgLEQ7XoJF9J8z/VeoTfEXsCknpzT/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(54906003)(6666004)(82960400001)(38100700002)(6486002)(478600001)(41300700001)(8676002)(5660300002)(8936002)(66556008)(316002)(66946007)(66476007)(6916009)(4326008)(186003)(83380400001)(6512007)(966005)(53546011)(9686003)(26005)(6506007)(86362001)(33716001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yvTr6bitgYkafYbYPOolJB85UCGHRfCsudpRkeHPFwSHfi7ey8JpzcPUKi1O?=
 =?us-ascii?Q?GXmES/CEkMlpk775kCajPgq/QebfBPx8drxKmKuGhX8+aVdMNRXeXYTLfnlX?=
 =?us-ascii?Q?v5nZvHbRzvQZ33UA00oFt0AJYmZY6zub0BgcXULPkUQp16rnbL1myr9fB85W?=
 =?us-ascii?Q?TIeBv/4SOI+lNgytMYq/Du/LXGzOqw8lRWo7KeopbM4Dv6JwK2pb1gNBN4UJ?=
 =?us-ascii?Q?59NWSGMpj59eoXFqsasRCpqF8LEbkMS8XGjx6vccPBaZLyz9yp1EyDS1ggZv?=
 =?us-ascii?Q?RAmfX109d7xa2DrBbxAzjRPjT59lMM+Mj+4Dly3rIhcQXLl29y2OVEfUzifP?=
 =?us-ascii?Q?Fxl3bmNyRzRB7o2DwNJeJ9z6g64HDBE/XVyyYLiByCe6XtZFk5jr9GYyqkOy?=
 =?us-ascii?Q?pTYOawfqObc+d0HsxCbZELRad2yphegLUuwM2soPWENZ/HYd+edL1D778ceK?=
 =?us-ascii?Q?fnn22unBXL5qNRdI9LTpNQZ18Dug5OMDbb5CHlLKwzsh6uVVDgSa6NQXNCf7?=
 =?us-ascii?Q?3qdPmB1qascgqmmu65cQpcGwTvt0y+Y2cupZAB5gtJCzHJlDAc2pG2GHEtDe?=
 =?us-ascii?Q?DWXWYa8cL5ybWOHBeDBLeV/iyzT0+Qe3YuC1BrvnC+CRD3zuLQepxp4CkXvm?=
 =?us-ascii?Q?MN7xfrHE0Ir2kzfKG+37D8OlJAnOtmIr96HP6gy0SnaP7H4KkYP8X1AlWPNP?=
 =?us-ascii?Q?FRf9YefCiBEAAEWESo96dbuN9/F0EDEfzAN1EP1AAKcrqtVcJ2ckJtnNAUua?=
 =?us-ascii?Q?z/7vzCbva1DJhdtZ/zQPgj80PQB01XTTlu7GZs19gNziVYW7WI6AQByIwMGD?=
 =?us-ascii?Q?vPmPSP3h/+4EANCaotXS+cQuVt4M30XXIMAeNr4Q+rf4ubQQz71mdrXjgLnh?=
 =?us-ascii?Q?I2xknxZHm29j2+bKDwaONzck8bjDAXSP/GOVAMPrXAqTtt1sXP9UgcVM+RF2?=
 =?us-ascii?Q?aRHE3vsAM6tU+bgo+STcTaqdaKMPfqmPAMItW6haBqtfKQSERBhbsu32MnA9?=
 =?us-ascii?Q?d26quQq0Qwh71dwUoyfDP/vCiSYg4mAuKqiV9dbmghZccJGFjfrcoP/ZYIwF?=
 =?us-ascii?Q?B1EoADt+G5KhCJZWkbSFWrW1J+WJGLh6mK234T0KdZxgW+SE2KwzDCODwDkR?=
 =?us-ascii?Q?hXvj3uP2zY0Yebo9Vf8NRBPCmAs5jSlqTIuvr+QRKFZfVHtggfsFT9gPIS8N?=
 =?us-ascii?Q?QGxuYqP0e410TlRHqCO3qZFaZFZ4G+iOwyQ/+onkAvSFRxWP2dJhJJBx75/K?=
 =?us-ascii?Q?JP7vTgtcas+Vccm47jPPstUHy3i8YPcLZ4ZN3ou3hp5TXC80EDDzgW2kf8Q9?=
 =?us-ascii?Q?mXMniBM8uv7gZu+l+Pmg6Aj1UnnTMSFKSOdbrcZbobg0KWjlu4I3mZJNbk2n?=
 =?us-ascii?Q?Lo6rTKwqIl+6kqZD3NF7vNe+DagX8Qp2JXOeQQ909EENNRGfTto7cd58XhEU?=
 =?us-ascii?Q?1MIPnf8aePW547nAcGHtCBmqR3dWnx1FnLRb2ZV07gNWC3f9/wnDNcZ5Qs+3?=
 =?us-ascii?Q?8pQQk2tAGzuteTpw8ktrZ0icnQhZEejFPM8GDc5jeOvW3APfDC+o6JVoInjN?=
 =?us-ascii?Q?s3VkYhx0pCoW/4mfDF/5hjMmFGuaeQIzg3dCOvMO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da40eebf-a71c-42be-56cc-08db8662785b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 01:09:28.9073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0LNK1Vba+H1PaChIgDFNusVYyH1+YXHbuWjZeIG2EmU7r8aZkrW+FZcfse6P4tpA7eTv56Q2ycLZDFKwCII27g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5299
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prateek,

On 2023-07-13 at 09:13:29 +0530, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> > 
> > Tested on Sapphire Rapids, which has 2 x 56C/112T and 224 CPUs in total. C-states
> > deeper than C1E are disabled. Turbo is disabled. CPU frequency governor is performance.
> > 
> > The baseline is v6.4-rc1 tip:sched/core, on top of
> > commit 637c9509f3db ("sched/core: Avoid multiple calling update_rq_clock() in __cfsb_csd_unthrottle()")
> > 
> > patch0: this SD_IDLE_SIBLING patch with above change to TOPOLOGY_SD_FLAGS
> > patch1: hack patch to split 1 LLC domain into 4 smaller LLC domains(with some fixes on top of
> >         https://lore.kernel.org/lkml/ZJKjvx%2FNxooM5z1Y@chenyu5-mobl2.ccr.corp.intel.com/)
> >         The test data in above link is invalid due to bugs in the hack patch, fixed in this version)
> > 
> > 
> > Baseline vs Baseline+patch0:
> > There is no much difference between the two, and it is expected because Sapphire Rapids
> > does not have multiple LLC domains within 1 Numa node(also consider the run to run variation):
> >

[snip] 

> > 
> > Baseline+patch1    vs    Baseline+patch0+patch1:
> > 
> > With multiple LLC domains in 1 Numa node, SD_IDLE_SIBLING brings improvement
> > to hackbench/schbench, while brings downgrading to netperf/tbench. This is aligned
> > with what was observed previously, if the waker and wakee wakes up each other
> > frequently, they would like to be put together for cache locality. While for
> > other tasks do not have shared resource, always choosing an idle CPU is better.
> > Maybe in the future we can look back at SIS_SHORT and terminates scan in
> > select_idle_node() if the waker and wakee have close relationship with
> > each other.
> 
> Gautham and I were discussing this and realized that when calling
> ttwu_queue_wakelist(), in a simulated split-LLC case, ttwu_queue_cond()
> will recommend using the wakelist and send an IPI despite the
> groups of the DIE domain sharing the cache in your case.
> 
> Can you check if the following change helps the regression?
> (Note: Completely untested and there may be other such cases lurking
> around that we've not yet considered)
> 

Good point. There are quite some cpus_share_cache() in the code, and it
could behave differently if simulated split-LLC is enabled. For example,
the chance to choose a previous CPU, or a recent_used_cpu is lower in
select_idle_sibling(), because the range of cpus_share_cache() shrinks.

I launched netperf(224 threads) and hackbench (2 groups) with below patch
applied, it seems there was no much difference(consider the run-to-run variation)

patch2: the cpus_share_cache() change below.


Baseline+patch1    vs    Baseline+patch0+patch1+patch2:


netperf
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	224-threads	 1.00 (  2.36)	 -0.19 (  2.30)

hackbench
=========
case            	load    	baseline(std%)	compare%( std%)
process-pipe    	2-groups	 1.00 (  4.78)	 -6.28 (  9.42)

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a68d1276bab0..a8cab1c81aca 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3929,7 +3929,7 @@ static inline bool ttwu_queue_cond(struct task_struct *p, int cpu)
>  	 * If the CPU does not share cache, then queue the task on the
>  	 * remote rqs wakelist to avoid accessing remote data.
>  	 */
> -	if (!cpus_share_cache(smp_processor_id(), cpu))
> +	if (cpu_to_node(smp_processor_id()) !=  cpu_to_node(cpu))
>  		return true;
>  
>  	if (cpu == smp_processor_id())
> --
>

Then I did a hack patch3 in select_idle_node(), to put C/S 1:1 wakeup workloads together.
For netperf, it is a 1:1 waker/wakee relationship, for hackbench, it is 1:16 waker/wakee
by default(verified by bpftrace).


patch3:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5904da690f59..3bdfbd546f14 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7161,6 +7161,11 @@ select_idle_node(struct task_struct *p, struct sched_domain *sd, int target)
 	if (!parent || parent->flags & SD_NUMA)
 		return -1;
 
+	/* Tasks pair should be put on local LLC as much as possible. */
+	if (current->last_wakee == p && p->last_wakee == current &&
+	    !current->wakee_flips && !p->wakee_flips)
+		return -1;
+
 	sg = parent->groups;
 	do {
 		int cpu = cpumask_first(sched_group_span(sg));
-- 
2.25.1

Baseline+patch1    vs    Baseline+patch0+patch1+patch3:

netperf
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	224-threads	 1.00 (  2.36)	+804.31 (  2.88)


hackbench
=========
case            	load    	baseline(std%)	compare%( std%)
process-pipe    	2-groups	 1.00 (  4.78)	 -6.28 (  6.69)


It brings the performance of netperf back, while more or less keeps the improvment
of hackbench(consider the run-run variance).

thanks,
Chenyu
