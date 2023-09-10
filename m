Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6C2799CE2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 09:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346371AbjIJHEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 03:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbjIJHD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 03:03:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9F61B8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 00:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694329434; x=1725865434;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=f8U57jURurzrR0igDNyBH9TY162eQy/AWmpHa3TETxM=;
  b=XaKrJfG3pXUca3DPAZeQxgIsdRgx+KtvFr5KPcvQWMEKZgIsYiF2h334
   DAeI5cPjZaMnHDRVX1a3i9PoG0fHIcRxuAvxEqbDhd2iZRBUb+lyaPyJ6
   GqaB97at53/+Cis75IJEyzaFsENQCRHYgeE2vQScnlFLNlwCVnVyftQBc
   S2LiSqQCCDldSm5wz99EktevDCc98n44k2A0F/ZF8PaT0QWg/bC0qdtSD
   REn0axMnjPysvMcEKrWPwHTyOsJU8iBAOQNo+DgMx5UGb63vykI0P2eex
   ppBCFGpghkQSi9/P4xHxTKGToHFVnUQERmaOmTTrTh36WpjJz3CmDRObX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="357339654"
X-IronPort-AV: E=Sophos;i="6.02,241,1688454000"; 
   d="scan'208";a="357339654"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 00:03:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="989712878"
X-IronPort-AV: E=Sophos;i="6.02,241,1688454000"; 
   d="scan'208";a="989712878"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2023 00:03:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 10 Sep 2023 00:03:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 10 Sep 2023 00:03:52 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 10 Sep 2023 00:03:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHhKLrzJehnGoz48aAfrl65VaelAJi/TRJS0OiJH/qzg7tJS8gSYs6bY4RXBkYyB0akY70jO+E4gwczzSllRe1gMkYA07SIuobTWnDtlLDM4EpyMV6dISh2v2Of/PGMWMpyIygsYBTWUbndpbP8cWOgsn9SYIRspNCyVyJeTq6D9oSGnoIxgWBwLInpRUxMpH8LgsQ+pkV3fYLxV+UlOHi/2SrIYTyVwswYQkNeJTh6C6sOhZoB6fLQp7FVMP1sRc916tM2TsOE2sbJb4yD4Jcx2EHsZQGUzOdkowtk3f0IKpLlwCKGbi/P5uVVYS6Y9VJ3OIEEd3PpF4aP0DCDiYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kN4PdtA2Q8u3DhID7m7PxsqpOBT0t6DI7iFAXmu3kak=;
 b=dVnK8xw6GJ/3Jp49yQNjt8+nZXuTVspKo3YOJpQWZ6wlecN82vGvNHKoo/Tq58+dFhlb6WD+Ag9YzY69aRXB/2sQ7lghwlu3CcKPEMr2z2nNmiXUqZzwfPBALtnrTARA138ws26ecQrSseMh++3fLFXgVLB0TXXxp3sxp0XEjYjUP9b6sp/3VtX67PaN+sxnbcV3rAFUxOB3RdIcRNoJjGaQcE8nkVH8ELV7X5n/PIiSoDpmD+zFIc0UuYnTR0h1oo08cWP9yTqeDBF5aYqUEPRZF2nbR5ahbO7+oPh4SN6oCoP5K3YVDSos3MXGvZO2d3WCDk+A81eRb7fc4wZjaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by MN6PR11MB8194.namprd11.prod.outlook.com (2603:10b6:208:477::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Sun, 10 Sep
 2023 07:03:50 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6768.029; Sun, 10 Sep 2023
 07:03:50 +0000
Date:   Sun, 10 Sep 2023 15:03:30 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        <x86@kernel.org>
Subject: Re: [RFC PATCH 1/2] sched: Rate limit migrations to 1 per 2ms per
 task
Message-ID: <ZP1qQjCLubr7J8us@chenyu5-mobl2>
References: <20230905171105.1005672-1-mathieu.desnoyers@efficios.com>
 <20230905171105.1005672-2-mathieu.desnoyers@efficios.com>
 <20230906084145.GC38741@noisy.programming.kicks-ass.net>
 <c0728f14-7373-1e19-1655-1944411290b2@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c0728f14-7373-1e19-1655-1944411290b2@efficios.com>
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|MN6PR11MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 20271064-a89b-4a6d-8077-08dbb1cc1584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQ/mBXRC2m0Zqf9mNo/kIYPuFxY/9cBGvf9FvwBvIKuHsNTHM73UgdX9GH/vs+3JtKDHE4ob1UybcLn5GX7jwadaHKJbiQCLBAMDlIwaR/EIUfDMxkZz2/T0c0wfdfjmp5sB+vaPdwHg/0vOCmYJgomTZ4+CLnrkcTIMaYVe85BVCKjt3ZmuitCeRNupx1KB82/Ij9/0PJmEozLwww8FbCOKTx5d4rkTOGgjR3IC/Jdi2w35+7eFqlKQNP/BolofjQUPJAXiOim+GQS4el/x9jRTXicUvjlb4ckR6iSU5aCJdlO/a6gxMkjxYieg/PILjoYnqSb0maYEQLtv1h1P0vDveEROkqHUY9yvEMbSLodk5D8p4XPVWJU8bYr01JAoK7AExtgoUIp1i24C+/5iML5OFtQiI1X5YCsvjs3nheKovv+/Hpxa4L/d0FD7+Fl90JfnaxC4NdGbeSk9O57VLJrxfOHL/swRRqZmuYZEkYOOl2f3hIck5Q4rn2fx6olHFMSsWCJJ/OLkfkRxm3Le0WxxrkP3lbRVVW10zI+5bD+SMl0vn9teIfHENZoub00QyiyTMU73UKAyLvwZvFuFWoLOaJcsV0ZkfKHH0krynXg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199024)(186009)(1800799009)(83380400001)(6512007)(53546011)(82960400001)(9686003)(86362001)(6666004)(478600001)(6506007)(38100700002)(6486002)(26005)(4326008)(8936002)(316002)(6916009)(66476007)(66946007)(66556008)(54906003)(41300700001)(8676002)(7416002)(2906002)(5660300002)(33716001)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q8OOlvRO31QB9gCJQWFVDD9fv3JijlO4/0peXwK/w2coCSmYlhnnaRgx/DrV?=
 =?us-ascii?Q?4CnOzCPzG721jIqQyD009zQdOXemU32t/ASBRNVgzfa9Oxl0TdpowNXHwK+4?=
 =?us-ascii?Q?mrSkeXoHtuzMlgY7M9QCxh3C9QPI8ZKLxZdOfsXA+aSuSCVcYGBh7cL2tD0D?=
 =?us-ascii?Q?bni6R9CVyOK5hPmutNuVSk94SCOZIinpp5TcoSdXe1S26QrzVEi24T5yI1pB?=
 =?us-ascii?Q?Z6UDOh2xtpum6OJvRekZniOIhCBUq7+TK63lxcGRMR5z/Bz8TQsbx/9SRXLe?=
 =?us-ascii?Q?ux6PLgftXVZMj7yiLSguKqdPWr6oVhbY1E118bkNdvVIilRY0pLWFG+RC8Qx?=
 =?us-ascii?Q?QXmnjc41Mi3PD4lBuXKCdUF0ul0HPWvTnr6UiCjtXVZnX1R/BkiwghHxvg3X?=
 =?us-ascii?Q?jWYW6GkT0BrUtVNN3CLVyQnfWFfoH7bn9sBrap3+XvlNsPBNkWVw+UKBElnV?=
 =?us-ascii?Q?hXrAv30AdgcJu3NADecIi+JBb3LrxNbsNstFN23RmmfHtGfDmFWmm0oxpHAf?=
 =?us-ascii?Q?B4bwL2RnOc0jXmG07h/TrSPfdICxUQ0Au+CiNmT2+EbyTN2pify/hGdbb5AM?=
 =?us-ascii?Q?NL3XfifiEJfjfMcSYjHSVoJGw6PYpfIzcFV0Ytu0Wo8RmzA8Ha4swpeyra6p?=
 =?us-ascii?Q?OArkYWHb83OhR4SsfGfQuFnZ2WkG6oqTXEkYeaTJS5q1oJBST02ywu03esg3?=
 =?us-ascii?Q?rTHQiuvQNAa5x0NX3V49H85v04ebt7aCAuU5w/FLqnD7wWxGNccAK/ET+Evv?=
 =?us-ascii?Q?CecBGEcZxlQ/IuqO1ZIuQQCTlMV2cPo0Prl0p/ZRo78BbnZ0EF1PQSvi+2O7?=
 =?us-ascii?Q?f6c837kcAq0c5SrALl3eELMGOacA1pguib+MTzqtfevdwf7WEHZwjk7bA5cl?=
 =?us-ascii?Q?kmwNsDq/WISltfiUTdGTVCskuwL6xKJoGwGrakf3KN+x1JHenHzSTOORWZfw?=
 =?us-ascii?Q?A/kch4uSCOk03a6lQ5Pfbr17Xn8Gfm5B1rZcH3es4AX2VKO7iRbRXGaQhIAD?=
 =?us-ascii?Q?2T2wFx13IUEnvFnU/AKz0tz9qQN8+FDKokLnVCfK89cNLPLGVg+3Ur1Fjg70?=
 =?us-ascii?Q?EIMgaL0y+Z3J912uVgdaFie0qxwIGEKGwtv/naGR/ma8RX5vV8y0ZR1ee9G+?=
 =?us-ascii?Q?wrctsLejeaagMfmHB95927YT14EGWucC0tLZJRfliQL0YGdPFVS1iRcm5RAO?=
 =?us-ascii?Q?irEeGxa/04TXsE5d4P4wJyv5WRaPtwQ4zfxOszeo8GVr+rOfbdYuldMhihbS?=
 =?us-ascii?Q?l938kRg0G9dV9zZNe7V2cYK/hq6RmvjVfJJSj7fLDysVatn3vU4HSet4KT4b?=
 =?us-ascii?Q?NCsQzrYeInAAAOogxUem1BD/4HXj387txEFsXs12UIEasXSJDVkgU+v9PCBj?=
 =?us-ascii?Q?DlK2P5W4E6Q7vXWB/O6QJJ71QHaEyxNtF5rtxBRYzmmcEkQHrDEfIr8bXoRI?=
 =?us-ascii?Q?VuiBelYknmAS9EP8zhOK7fFRC7ycW27MF+IHJrQaGc8QnlrDOoYoJG2Q/xcP?=
 =?us-ascii?Q?CWsswSMn6kLhheai5On+pM2KvzmClLOwyRLd5ULAVJzZgkM564L+KJYFY8P9?=
 =?us-ascii?Q?3uHgXOaM2p8k66pmbjl2ByBV1ihJ2FEDlFLGugih?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20271064-a89b-4a6d-8077-08dbb1cc1584
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2023 07:03:49.8858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhYAgpzLtD2Th/wlM07QIYlX620Q+XxQXsxF0AOnWSO6Kvz+mymvQuSh5S8g6A+nd8qASUKoGn6FJfqBCfssiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8194
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-06 at 09:57:04 -0400, Mathieu Desnoyers wrote:
> On 9/6/23 04:41, Peter Zijlstra wrote:
> > On Tue, Sep 05, 2023 at 01:11:04PM -0400, Mathieu Desnoyers wrote:
> > > Rate limit migrations to 1 migration per 2 milliseconds per task. On a
> > > kernel with EEVDF scheduler (commit b97d64c722598ffed42ece814a2cb791336c6679),
> > 
> > This is not in any way related to the actual eevdf part, perhaps just
> > call it fair.
> 
> Good point.
> 
> > 
> > 
> > >   include/linux/sched.h |  2 ++
> > >   kernel/sched/core.c   |  1 +
> > >   kernel/sched/fair.c   | 14 ++++++++++++++
> > >   kernel/sched/sched.h  |  2 ++
> > >   4 files changed, 19 insertions(+)
> > > 
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index 177b3f3676ef..1111d04255cc 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -564,6 +564,8 @@ struct sched_entity {
> > >   	u64				nr_migrations;
> > > +	u64				next_migration_time;
> > > +
> > >   #ifdef CONFIG_FAIR_GROUP_SCHED
> > >   	int				depth;
> > >   	struct sched_entity		*parent;
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 479db611f46e..0d294fce261d 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -4510,6 +4510,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
> > >   	p->se.vruntime			= 0;
> > >   	p->se.vlag			= 0;
> > >   	p->se.slice			= sysctl_sched_base_slice;
> > > +	p->se.next_migration_time	= 0;
> > >   	INIT_LIST_HEAD(&p->se.group_node);
> > >   #ifdef CONFIG_FAIR_GROUP_SCHED
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index d92da2d78774..24ac69913005 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -960,6 +960,14 @@ int sched_update_scaling(void)
> > >   static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
> > > +static bool should_migrate_task(struct task_struct *p, int prev_cpu)
> > > +{
> > > +	/* Rate limit task migration. */
> > > +	if (sched_clock_cpu(prev_cpu) < p->se.next_migration_time)
> > > +	       return false;
> > > +	return true;
> > > +}
> > > +
> > >   /*
> > >    * XXX: strictly: vd_i += N*r_i/w_i such that: vd_i > ve_i
> > >    * this is probably good enough.
> > > @@ -7897,6 +7905,9 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
> > >   		want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
> > >   	}
> > > +	if (want_affine && !should_migrate_task(p, prev_cpu))
> > > +		return prev_cpu;
> > > +
> > >   	rcu_read_lock();
> > >   	for_each_domain(cpu, tmp) {
> > >   		/*
> > > @@ -7944,6 +7955,9 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
> > >   {
> > >   	struct sched_entity *se = &p->se;
> > > +	/* Rate limit task migration. */
> > > +	se->next_migration_time = sched_clock_cpu(new_cpu) + SCHED_MIGRATION_RATELIMIT_WINDOW;
> > > +
> > >   	if (!task_on_rq_migrating(p)) {
> > >   		remove_entity_load_avg(se);
> > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > index cf54fe338e23..c9b1a5976761 100644
> > > --- a/kernel/sched/sched.h
> > > +++ b/kernel/sched/sched.h
> > > @@ -104,6 +104,8 @@ struct cpuidle_state;
> > >   #define TASK_ON_RQ_QUEUED	1
> > >   #define TASK_ON_RQ_MIGRATING	2
> > > +#define SCHED_MIGRATION_RATELIMIT_WINDOW	2000000		/* 2 ms */
> > > +
> > >   extern __read_mostly int scheduler_running;
> > >   extern unsigned long calc_load_update;
> > 
> > Urgh... so we already have much of this around task_hot() /
> > can_migrate_task(). And I would much rather see we extend those things
> > to this wakeup migration path, rather than build a whole new parallel
> > thing.
> 
> Yes, good point.
> 
> > 
> > Also:
> > 
> > > I have noticed that in order to observe the speedup, the workload needs
> > > to keep the CPUs sufficiently busy to cause runqueue lock contention,
> > > but not so busy that they don't go idle.
> > 
> > This would suggest inhibiting pulling tasks based on rq statistics,
> > instead of tasks stats. It doesn't matter when the task migrated last,
> > what matter is that this rq doesn't want new tasks at this point.
> > 
> > Them not the same thing.
> 
> I suspect we could try something like this then:
> 
> When a cpu enters idle state, it could grab a sched_clock() timestamp
> and store it into this_rq()->enter_idle_time. Then, when it exits
> idle and reenters idle again, it could save rq->enter_idle_time to
> rq->prev_enter_idle_time, and sample enter_idle_time again.
> 
> When considering the CPU as a target for task migration, if it is
> idle but the delta between sched_clock_cpu(cpu_of(rq)) and that
> prev_enter_idle_time is below a threshold (e.g. a few ms), this means
> the CPU got out of idle and went back to idle pretty quickly, which
> means it's not a good target for pulling tasks for a short while.
> 

Do you mean inhit the newidle balance? Currently the newidle balance
checks if the average idle duration of that rq is below the total cost
to do a load balance:
   this_rq->avg_idle < sd->max_newidle_lb_cost

> I'll try something along these lines and see how it goes.
>

Consider the sleep time looks like a good idea! What you suggests that
inspires me that, maybe we could consider the task's sleep duration,
and decide whether to migrate it or not in the next wakeup.

Say, if a task p sleeps and woken up quickly, can we reserve its previous
CPU as idle for a short while? So other tasks can not choose p's previous
CPU during their wakeup. A short while later, when p is woken up, it finds
that its previous CPU is still idle and chooses that.

I created a draft patch based on that, and it shows some improvements on
a 224 CPUs system. I'll post the draft patch and Cc you.

thanks,
Chenyu
