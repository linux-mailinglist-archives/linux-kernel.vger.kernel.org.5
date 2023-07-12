Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EF7750F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjGLRVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjGLRVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:21:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A861980;
        Wed, 12 Jul 2023 10:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689182469; x=1720718469;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GXH3lCzDHqSqE0Q4fA3YMZUNS5sMOd6bc1jLGU8BUCA=;
  b=aY9LQWJyH4v8q8BEe1TnE7+9g5j9KvBX+7LBqVZE1z4hSzGPch5fFv+R
   2FFALdlDRJkDWtcnlFdLPuclmhq762VXeYLAcPFD3d75l/a4x4BGYxpfM
   V53vJK7StO5/Ss8T62pKSMgamttbAiqspUgkxuKNXBcFS3Zq+vWkcnttq
   F/RpBHvLh2UlumUhrz3qQBDLaBm4PHnqgucaIOtV24/JxreigAhghBKWG
   CwdVIZ4ZjxxfsK3/HybmNozYZdfm51m5zCK0C9lI9YXGLB0Jgw+TmwQm4
   Fmx4hgugrMn6luMw5IOBe5NUZ07OWLYVOC4K7xCDknwN6BsDG/xy9ER25
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="431090917"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="431090917"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 10:19:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="751237952"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="751237952"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 12 Jul 2023 10:19:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 10:19:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 10:19:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 10:19:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 10:19:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1twmPhq2tEAe8ImxdTUie5cQfbTiuB1VWOwZ19FuoyIt6C8U7klrcXHrX8unFcQwPI9FVj/VcMsONl/nq9PKNSMtzfrIexvUdIjoPfdHgS+jUt+4/LZLS6f+DPvypnqGWG7NFHZne4cifsRwue3T0Reh0TvtZRds3Xf4PqdHv/aUy5Bj9RHgzDUCC64hmM9HJ9tAd1RdoEA3pitEC3AjTQYAFksfHifUofwfPjQtNFmtPxIhWj9FSAzdjkEemMlasTR0wBLObZb2phM3gfZMeETLY7TIQdFu7rpEBsutNoaIkJret9luPIQOIa9DpeA65otjOfkY3uCi9nadnD2UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LvADt8ftovT4ilDRYoIO+UFRJaoaXwHVlBo3cJQskQ=;
 b=avHvAbnP32COMCncm94z7HcNKdCBlz3dClMjJcEfmh5QYx6hP9o6TyBCQnL9//ZiLRiCTH6PJ7EFzkMAKdm8/ebxiseGcoieu6rN9hCku2WsWeJ4ymOycmRiFhbnLRdxWEN31Wwn5VttVsc/wSqJPjMh0A6Z3M7GyTJ6ZH0v8ny6ZVbrzrm/hAm38FsGberPTyVxpfcpQCASrcnjsAh48DkoqY7Nbk4wN8FLStP+3p3YyQnFBWyh1AiVLoWZf19CJFDnmnrF00j1qARLzYRMEO6k5NzIAKsdBuBO+rVNnnJY3KfP0bbIDrUrBuvjA6zYdfmyzVlVJ9vNjqpUqxXD9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SA1PR11MB6823.namprd11.prod.outlook.com (2603:10b6:806:2b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 12 Jul
 2023 17:19:54 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 17:19:54 +0000
Date:   Thu, 13 Jul 2023 01:19:42 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     K Prateek Nayak <kprateek.nayak@amd.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-tip-commits@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>, <x86@kernel.org>,
        Gautham Shenoy <gautham.shenoy@amd.com>
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Message-ID: <ZK7groqlP3S7r8vt@chenyu5-mobl2>
References: <20230601115643.GX4253@hirez.programming.kicks-ass.net>
 <20230601120001.GJ38236@hirez.programming.kicks-ass.net>
 <20230601144706.GA559454@hirez.programming.kicks-ass.net>
 <7bee9860-2d2a-067b-adea-04012516095c@amd.com>
 <20230602065438.GB620383@hirez.programming.kicks-ass.net>
 <bd083d8d-023a-698e-701b-725f1b15766e@amd.com>
 <20230613082536.GI83892@hirez.programming.kicks-ass.net>
 <f212f491-cd3f-6eee-20d7-8f9ab8937902@amd.com>
 <20230705115702.GY4253@hirez.programming.kicks-ass.net>
 <ZKlh1u2kkHzHY/nB@chenyu5-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZKlh1u2kkHzHY/nB@chenyu5-mobl2>
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SA1PR11MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: 684cc790-1096-413e-a5e6-08db82fc3539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c60c3zPzB4vGVvg2kxXu56Uv8BLz1sOs6oHTH+P7Mde2Ss2G50B64o8dXyiU3erKSLdM0/g6dIRJxHB68U3DurIfkSoEYiYxuFNiw2HmnxqTZwf+CV5491UKcjNgqpCiPzEQL4hiHGiYH05mDPn3AAU+zcWdFbUhL/R/+We1drigSwKG24Yz4kuJ/KmYNXll+8RndDRgRUkksG2wLimkPEGJcZROGVmnqgQwgIOzVBdbvj4RNhpX/sj2CtmeYmPy9K7qDW2Ao/9GH5G1e/G/pPjG0jVup6lPx58OOy8PUFmbU/9T4aUITNpA599eMy2rWzC4dcl7TX8kInomoHdVaUrhTQ4StUVm2Yf56KD9ETH4/pGv7h4C8HDH3aZwC2Mjfdx2Crle4xLaH+C7kL3X9cg9C5F5azg7KaBwmSIlw+ebdgDmnY+/EWop7hj4rtdV/3mjcsw8EE8mjDaXXy+BmyIX1NVCyQaYdXYGAMe7x4EAzJtf7/Jox4XP66irpptL4gf2TTgOWE7Dd2mV4TAxjnMs2OaI1hzhzr32Vx13awH9SWLZiFzWEVUXhrrGpLVBl9OzhIWuFvnJspXvhzzU8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(316002)(33716001)(53546011)(26005)(186003)(6506007)(41300700001)(478600001)(38100700002)(6916009)(82960400001)(4326008)(66556008)(54906003)(66946007)(66476007)(9686003)(966005)(6512007)(6486002)(2906002)(86362001)(5660300002)(83380400001)(6666004)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/0/a0e6cWPZw/h5naF6zWFjdJ+kszC2CBmJSNoLs3FEAvjixW1wGvSMpsz3x?=
 =?us-ascii?Q?g6iwYEnMgVI9FaKZOlQRqKCBMFm6ismDVb2VKp9Wnz4BQ/ixWrTjZxNm7Uxh?=
 =?us-ascii?Q?wv1RY0BuUyrI71MySUoYZaD45gtTBEJ6v3pbmDtv0xCKnMhDxlqe5oSPfNr2?=
 =?us-ascii?Q?SQ2PLzpxEA7+aeIZLaD9A36hMQRUol4cHBz1b5sz/oD9WcS9f/7ixYEaSCrZ?=
 =?us-ascii?Q?XsCoLcljvyXzJXd6rP3uZHv6OtaJ+mE/cv3u7CxKPSE3Lcu6vv+hQG3Jy25+?=
 =?us-ascii?Q?CZi9u9bP+DXGg5nbUpCQ47lTkcbxQd6S0BUAeeQIkG3x6E1A5z5uXUSVh0Bm?=
 =?us-ascii?Q?aI1h2m6O4YPM5Ii8hFksR880uUufsRUUBYOSc94MMuxE9V0L3WXkC9kv5LJc?=
 =?us-ascii?Q?nRo53I/mlfJxx9zxjK18qgDt2IdkpVRhX0NAfo18ZShQ454fwhmchaxuT2g2?=
 =?us-ascii?Q?aSmXdg0kpLlkSQXTmIsmSsrkPXx4g1Q70Msn0OnBh0BMJhtfe/3XusHsc5RL?=
 =?us-ascii?Q?FzAftpTa46vAeU63ZxoqWyKSxhnCMELCrQOkRxl8f9XqvdUDdQGoZSw3JXwR?=
 =?us-ascii?Q?hdNWJxISWHtvJnxKYxLrE7QYDdpxY8kVLF96gGZJme5euuuupWp90Z3sFy+I?=
 =?us-ascii?Q?IaKwdIZ/RG+XbGluFON/wv53JSrENdKuYyHwWyQ5gGpcc7zMhJgwXo7ZizhL?=
 =?us-ascii?Q?5cCjqkwiBZb21+nA+QqFNVf71aCYPkOOD2WZEOOSDGuLZ27TjUBM9TNgo8Sy?=
 =?us-ascii?Q?vDJP4X18VGVXwUWzfSZ0QazIYchwbI1q4BdJ4Z1RfzypL3v2YZp9AOS7TYnc?=
 =?us-ascii?Q?POG8uUSRGSqnfYyeq2/QqffN9239uUM/LDbrmRarZ3zv+JtaiAXbxpoPd+bH?=
 =?us-ascii?Q?v4SpdRYc2xK73G2gysXNB/MTB2CzNgTruDEeKPLecX5BC1gbSnPsZhaoKgzn?=
 =?us-ascii?Q?jQ7PC6LWOL4H7z30P6V/HjKxc9l13NTikj0WhQyez4r+cxmDmnsdhLz/xtQx?=
 =?us-ascii?Q?lSjC3IfMqz29hUD3Z5t9Csa4pj+FKkbrPedZ5+a4/5kLq9CLnFAYy/SkfyTg?=
 =?us-ascii?Q?4iTXOWBfc98UIPPQjoc4zxRgo0skN3s7wK36WZbcAIgYxzS93Osg00lu7dIV?=
 =?us-ascii?Q?fVtmL8Ad3WcKy1Y7ambABV+Hb9kko7NgBdxUj5Zb0d172yAS9Q+z08szibkz?=
 =?us-ascii?Q?uyInGaxB75V4mb3fWcHjMQa9h6xwNgXfKwe59OaQRPR/acNCHJyFnr6miowd?=
 =?us-ascii?Q?qp/cXhf0tYc5iE9QeJLua8V6uhqcAgGqbXa7nSl9h3Dl1b7kz6HyM5WGdx9i?=
 =?us-ascii?Q?7YKw6vPDc0W+KJcCgrrW4/8w9U1sHOuvGNbwMnqYUUogqfOiqGaKJ6n6Tplj?=
 =?us-ascii?Q?gRJBIJilsXxcB9VAvyVi+FVys2+f2zRg14MUMtwQCrbk7pHNJz1sgCWpkYBj?=
 =?us-ascii?Q?IxQiIcUTOsTmF4cnS40yQ0gj/NhXB1+NGUwPac3pVcFycnpqzqQPl6NR91Np?=
 =?us-ascii?Q?4ONGUnXL0pb4aC+Rjg5wHxErp1kiDcLjppFvEOZar/uD1CLW6OfKxmB0wegy?=
 =?us-ascii?Q?kU0S5Zy/mD/I9r6tc/EK6Up7zOzylD4RRMabCASh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 684cc790-1096-413e-a5e6-08db82fc3539
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:19:54.3358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLFLMNMBOsLrBp3KDmE/dv9hT9+1pJ6cHxM2Y9vMt5E+vgBMy5wYZr6emGnJNXMOHaaRw9jN6Nzh5QlUlYXnjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6823
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-08 at 21:17:10 +0800, Chen Yu wrote:
> On 2023-07-05 at 13:57:02 +0200, Peter Zijlstra wrote:
> > On Fri, Jun 16, 2023 at 12:04:48PM +0530, K Prateek Nayak wrote:
> > 
> > --- a/arch/x86/kernel/smpboot.c
> > +++ b/arch/x86/kernel/smpboot.c
> > @@ -596,7 +596,7 @@ static inline int x86_sched_itmt_flags(v
> >  #ifdef CONFIG_SCHED_MC
> >  static int x86_core_flags(void)
> >  {
> > -	return cpu_core_flags() | x86_sched_itmt_flags();
> > +	return cpu_core_flags() | x86_sched_itmt_flags() | SD_IDLE_SIBLING;
> >  }
> I guess this flag might need to be added into the valid mask:
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index d3a3b2646ec4..4a563e9f7b10 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1540,6 +1540,7 @@ static struct cpumask		***sched_domains_numa_masks;
>  #define TOPOLOGY_SD_FLAGS		\
>  	(SD_SHARE_CPUCAPACITY	|	\
>  	 SD_SHARE_PKG_RESOURCES |	\
> +	 SD_IDLE_SIBLING	|	\
>  	 SD_NUMA		|	\
>  	 SD_ASYM_PACKING)
> >  #endif
> >  #ifdef CONFIG_SCHED_SMT
> > --- a/include/linux/sched/sd_flags.h
> > +++ b/include/linux/sched/sd_flags.h
> > @@ -161,3 +161,10 @@ SD_FLAG(SD_OVERLAP, SDF_SHARED_PARENT |
> >   * NEEDS_GROUPS: No point in preserving domain if it has a single group.
> >   */
> >  SD_FLAG(SD_NUMA, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
> > +
> > +/*
> > + * Search for idle CPUs in sibling groups
> > + *
> > + * NEEDS_GROUPS: Load balancing flag.
> > + */
> > +SD_FLAG(SD_IDLE_SIBLING, SDF_NEEDS_GROUPS)
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7046,6 +7046,38 @@ static int select_idle_cpu(struct task_s
> >  }
> >  
> >  /*
> > + * For the multiple-LLC per node case, make sure to try the other LLC's if the
> > + * local LLC comes up empty.
> > + */
> > +static int
> > +select_idle_node(struct task_struct *p, struct sched_domain *sd, int target)
> > +{
> > +	struct sched_domain *parent = sd->parent;
> > +	struct sched_group *sg;
> > +
> > +	/* Make sure to not cross nodes. */
> > +	if (!parent || parent->flags & SD_NUMA)
> > +		return -1;
> > +
> > +	sg = parent->groups;
> > +	do {
> > +		int cpu = cpumask_first(sched_group_span(sg));
> > +		struct sched_domain *sd_child = per_cpu(sd_llc, cpu);
> >
> I wonder if we can use rcu_dereference() in case the cpu hotplug
> changes the content sd_llc points to. (I'm still thinking of the
> symptom you described here:)
> https://lore.kernel.org/lkml/20230605190746.GX83892@hirez.programming.kicks-ass.net/
> 
> I'll launch some tests with this version on Sapphire Rapids(and with/without LLC-split hack patch).

Tested on Sapphire Rapids, which has 2 x 56C/112T and 224 CPUs in total. C-states
deeper than C1E are disabled. Turbo is disabled. CPU frequency governor is performance.

The baseline is v6.4-rc1 tip:sched/core, on top of
commit 637c9509f3db ("sched/core: Avoid multiple calling update_rq_clock() in __cfsb_csd_unthrottle()")

patch0: this SD_IDLE_SIBLING patch with above change to TOPOLOGY_SD_FLAGS
patch1: hack patch to split 1 LLC domain into 4 smaller LLC domains(with some fixes on top of
        https://lore.kernel.org/lkml/ZJKjvx%2FNxooM5z1Y@chenyu5-mobl2.ccr.corp.intel.com/)
        The test data in above link is invalid due to bugs in the hack patch, fixed in this version)


Baseline vs Baseline+patch0:
There is no much difference between the two, and it is expected because Sapphire Rapids
does not have multiple LLC domains within 1 Numa node(also consider the run to run variation):

hackbench
=========
case            	load    	baseline(std%)	compare%( std%)
process-pipe    	1-groups	 1.00 (  2.66)	+13.84 ( 12.80)
process-pipe    	2-groups	 1.00 (  3.67)	 -8.37 (  2.33)
process-pipe    	4-groups	 1.00 (  6.45)	 +4.17 (  6.36)
process-pipe    	8-groups	 1.00 (  1.69)	 +2.28 (  1.72)
process-sockets 	1-groups	 1.00 (  1.73)	 +0.61 (  0.69)
process-sockets 	2-groups	 1.00 (  2.68)	 -2.20 (  0.55)
process-sockets 	4-groups	 1.00 (  0.03)	 -0.34 (  0.17)
process-sockets 	8-groups	 1.00 (  0.09)	 -0.28 (  0.09)
threads-pipe    	1-groups	 1.00 (  2.42)	 +6.95 (  3.86)
threads-pipe    	2-groups	 1.00 (  2.26)	 +2.68 (  6.56)
threads-pipe    	4-groups	 1.00 (  5.08)	 +3.57 (  4.61)
threads-pipe    	8-groups	 1.00 (  7.89)	 -2.52 (  3.45)
threads-sockets 	1-groups	 1.00 (  1.15)	 +0.87 (  3.13)
threads-sockets 	2-groups	 1.00 (  0.63)	 -0.02 (  1.27)
threads-sockets 	4-groups	 1.00 (  0.27)	 +0.29 (  0.17)
threads-sockets 	8-groups	 1.00 (  0.07)	 -0.42 (  0.40)

netperf
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	56-threads	 1.00 (  2.56)	 -0.25 (  3.27)
TCP_RR          	112-threads	 1.00 (  2.26)	 +0.04 (  2.18)
TCP_RR          	168-threads	 1.00 (  0.81)	 +0.01 (  0.74)
TCP_RR          	224-threads	 1.00 (  0.65)	 +0.04 (  0.66)
TCP_RR          	280-threads	 1.00 ( 64.56)	+69.47 ( 56.78)
TCP_RR          	336-threads	 1.00 ( 20.39)	 +0.08 ( 19.58)
TCP_RR          	392-threads	 1.00 ( 31.63)	 +0.17 ( 31.08)
TCP_RR          	448-threads	 1.00 ( 39.72)	 -0.14 ( 39.14)
UDP_RR          	56-threads	 1.00 (  8.94)	 -0.71 ( 12.03)
UDP_RR          	112-threads	 1.00 ( 18.72)	 +0.78 ( 16.71)
UDP_RR          	168-threads	 1.00 ( 11.39)	 -0.18 (  8.34)
UDP_RR          	224-threads	 1.00 (  9.02)	 +0.81 ( 11.47)
UDP_RR          	280-threads	 1.00 ( 15.87)	 -0.12 ( 12.87)
UDP_RR          	336-threads	 1.00 ( 39.89)	 +2.25 ( 32.35)
UDP_RR          	392-threads	 1.00 ( 28.17)	 +3.47 ( 25.99)
UDP_RR          	448-threads	 1.00 ( 58.68)	 +0.35 ( 56.16)

tbench
======
case            	load    	baseline(std%)	compare%( std%)
loopback        	56-threads	 1.00 (  0.94)	 +0.24 (  0.69)
loopback        	112-threads	 1.00 (  0.19)	 +0.18 (  0.25)
loopback        	168-threads	 1.00 ( 52.17)	 -1.42 ( 50.95)
loopback        	224-threads	 1.00 (  0.86)	 -0.38 (  0.19)
loopback        	280-threads	 1.00 (  0.12)	 -0.28 (  0.17)
loopback        	336-threads	 1.00 (  0.10)	 -0.33 (  0.19)
loopback        	392-threads	 1.00 (  0.27)	 -0.49 (  0.26)
loopback        	448-threads	 1.00 (  0.06)	 -0.88 (  0.59)

schbench
========
case            	load    	baseline(std%)	compare%( std%)
normal          	1-mthreads	 1.00 (  0.72)	 -1.47 (  0.41)
normal          	2-mthreads	 1.00 (  1.66)	 +1.18 (  2.63)
normal          	4-mthreads	 1.00 (  1.12)	 +1.20 (  4.52)
normal          	8-mthreads	 1.00 ( 11.03)	 -3.87 (  5.14)


Baseline+patch1    vs    Baseline+patch0+patch1:

With multiple LLC domains in 1 Numa node, SD_IDLE_SIBLING brings improvement
to hackbench/schbench, while brings downgrading to netperf/tbench. This is aligned
with what was observed previously, if the waker and wakee wakes up each other
frequently, they would like to be put together for cache locality. While for
other tasks do not have shared resource, always choosing an idle CPU is better.
Maybe in the future we can look back at SIS_SHORT and terminates scan in
select_idle_node() if the waker and wakee have close relationship with
each other.


hackbench
=========
case            	load    	baseline(std%)	compare%( std%)
process-pipe    	1-groups	 1.00 (  0.25)	+31.65 (  6.77)
process-pipe    	2-groups	 1.00 (  0.28)	+29.50 (  5.35)
process-pipe    	4-groups	 1.00 (  0.08)	+16.77 (  1.30)
process-pipe    	8-groups	 1.00 (  0.20)	 -5.18 (  0.04)
process-sockets 	1-groups	 1.00 (  0.23)	+13.68 (  1.28)
process-sockets 	2-groups	 1.00 (  0.16)	+11.18 (  1.87)
process-sockets 	4-groups	 1.00 (  0.23)	 -0.06 (  0.21)
process-sockets 	8-groups	 1.00 (  0.36)	 +2.34 (  0.15)
threads-pipe    	1-groups	 1.00 (  5.23)	+16.38 ( 12.10)
threads-pipe    	2-groups	 1.00 (  1.63)	+28.52 (  5.17)
threads-pipe    	4-groups	 1.00 (  0.77)	+23.28 (  2.42)
threads-pipe    	8-groups	 1.00 (  2.27)	 +2.35 (  5.75)
threads-sockets 	1-groups	 1.00 (  2.31)	 +0.42 (  1.68)
threads-sockets 	2-groups	 1.00 (  0.56)	 +3.98 (  0.65)
threads-sockets 	4-groups	 1.00 (  0.12)	 +0.29 (  0.32)
threads-sockets 	8-groups	 1.00 (  0.86)	 +1.92 (  0.27)

netperf
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	56-threads	 1.00 ( 12.46)	 -1.62 ( 12.14)
TCP_RR          	112-threads	 1.00 (  1.34)	 -0.16 (  1.42)
TCP_RR          	168-threads	 1.00 (  6.26)	 -0.88 (  6.08)
TCP_RR          	224-threads	 1.00 (  2.19)	-90.18 (  6.12)
TCP_RR          	280-threads	 1.00 ( 12.27)	-63.81 ( 74.25)
TCP_RR          	336-threads	 1.00 ( 29.28)	 -6.21 ( 18.48)
TCP_RR          	392-threads	 1.00 ( 39.39)	 -3.87 ( 26.63)
TCP_RR          	448-threads	 1.00 ( 47.45)	 -2.34 ( 32.37)
UDP_RR          	56-threads	 1.00 (  3.28)	 -0.31 (  2.81)
UDP_RR          	112-threads	 1.00 (  7.03)	 +0.55 (  7.03)
UDP_RR          	168-threads	 1.00 ( 17.42)	 -0.51 ( 15.63)
UDP_RR          	224-threads	 1.00 ( 20.79)	-68.28 ( 14.32)
UDP_RR          	280-threads	 1.00 ( 26.23)	-68.58 ( 18.60)
UDP_RR          	336-threads	 1.00 ( 38.99)	 -0.55 ( 21.19)
UDP_RR          	392-threads	 1.00 ( 44.22)	 -1.91 ( 27.44)
UDP_RR          	448-threads	 1.00 ( 55.11)	 -2.74 ( 38.55)

tbench
======
case            	load    	baseline(std%)	compare%( std%)
loopback        	56-threads	 1.00 (  2.69)	 -2.30 (  2.69)
loopback        	112-threads	 1.00 (  1.92)	 +0.62 (  1.46)
loopback        	168-threads	 1.00 (  0.97)	-67.69 (  0.06)
loopback        	224-threads	 1.00 (  0.24)	 -6.79 (  8.81)
loopback        	280-threads	 1.00 (  0.10)	 +0.47 (  0.62)
loopback        	336-threads	 1.00 (  0.85)	 -0.05 (  0.05)
loopback        	392-threads	 1.00 (  0.62)	 +0.77 (  0.50)
loopback        	448-threads	 1.00 (  0.36)	 +0.77 (  0.77)

schbench
========
case            	load    	baseline(std%)	compare%( std%)
normal          	1-mthreads	 1.00 (  0.82)	 +1.44 (  1.24)
normal          	2-mthreads	 1.00 (  2.13)	 +1.16 (  0.41)
normal          	4-mthreads	 1.00 (  3.82)	 -0.30 (  1.48)
normal          	8-mthreads	 1.00 (  4.80)	+22.43 ( 13.03)

But since the multiple LLC is just a simulation on Intel platform for now,
the patch is ok and:

Tested-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu
