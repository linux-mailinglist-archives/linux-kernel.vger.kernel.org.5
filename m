Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EFF7D624E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjJYHUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjJYHUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:20:39 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 00:20:36 PDT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF40E5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698218436; x=1729754436;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fhK024+zTujFSCZGZu6z/SqShCT9pffTG/fhymv1UWw=;
  b=jXhGB7D0YkvNcDoE+AuTyhCTJDdtoVZLC37eWZXewhjpgECxUtqlNsFS
   8r9qTKBSRYMpRRpXfEF+R+9y496GHbNrkm/RA4Rne7f/WwcTlvBvuzaqH
   s4erAaM3G7fF2bf9A0rrk5sVRqKNZUdvKJ87TXw61tF7HZ0DfY5d87L1J
   1NIae2CYeDJSNp7X+/irEonfDGDwmIylZcH8u4mGAOH5R5nz3X5PiQXgP
   Ec0G+7Ph5eAWuAcDWcKS6Q8stw2pGVu1kHafXQDZy4fdmQdSuDYOPKOw6
   yIgDLK7Naj6cKE52hQvscseqgal+Quj2ewL4dZnymvo67g6/cJjW6C4rS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="15722"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="15722"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 00:19:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="6436694"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 00:18:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 00:19:30 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 00:19:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 00:19:30 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 00:19:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8tSGjHhv1T7HQA6WyEk+tzEWOSiQbwka5bM6JXMS1WPnbBp75pnHrFX4b8stqJpBFXw3tnWQf/HJsHL67vXiE2X9QRFS8TJIVS4RjzYfm2vF6NpGqRdThJESed5HutDHzgcPhLuHJ9YPlWXS5Y+Brx6jxMafUaTT0k4MS4qnMAKInijiMvfbjtQVJoT92ERI18QWqGKwUmIqjN0XBUNxU5FklC1Y3RGqnUXvfI3GWbZbwbDkhpAoPS/TlImHmiDimnolQmTFvpgBtGpzczSzlIuN1GUeQZN6tmAENsIPxESfkj7hUWT6rXGLQDR6e6Ml1htX2/v5fTGsQGuPr5O5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPJtLxPAELKhgFcPMn5qaPbHE5J5aJjuRHDR6wYFmjU=;
 b=IUw6OlsOLApqZCixg6RUCNuTQJyCWAPTlO8EaeltmP7ibAoHSNiRKZjaxixtZUPDQxnKY8Nr/cxITOygyv0vz+RZ53sl6z6TxiatXTv5kuAESRlvRP4k+LhExuDatY0j7gLNOyvjgJVehHrq+1lFRs4Y2u09t5MhjOYfYtgJQ2gP5BysHSj11Sypba0tUZm9hBIrNQW+wHTEYRJxXY1HPyRi3PPcMNW88P+GkR2Ugi3LbrKbK2ioVTIHiRbSZMFLk2JAGJOF/snZxDDvHPd9p203jOCwmszU1gIWQkJdXCroMT/7/LyQdowLCKTLKSDartSwqK1BdO+l16IiSRUfUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SA3PR11MB7626.namprd11.prod.outlook.com (2603:10b6:806:307::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 07:19:27 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%5]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 07:19:27 +0000
Date:   Wed, 25 Oct 2023 15:19:10 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>,
        "Tim Chen" <tim.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, <x86@kernel.org>
Subject: Re: [RFC PATCH v2 1/2] sched/fair: Introduce UTIL_FITS_CAPACITY
 feature (v2)
Message-ID: <ZTjBbgiSXj6bWE2O@chenyu5-mobl2.ccr.corp.intel.com>
References: <20231019160523.1582101-1-mathieu.desnoyers@efficios.com>
 <20231019160523.1582101-2-mathieu.desnoyers@efficios.com>
 <f40522de-b71d-4848-8aa3-5b87d38bb847@arm.com>
 <c79ac631-61c7-4953-a657-74047a264029@efficios.com>
 <ZTdf0529DL51pj8m@chenyu5-mobl2.ccr.corp.intel.com>
 <ae8412cb-fd78-4e3e-b51a-ee290fd076bd@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ae8412cb-fd78-4e3e-b51a-ee290fd076bd@efficios.com>
X-ClientProxiedBy: KL1PR0401CA0027.apcprd04.prod.outlook.com
 (2603:1096:820:e::14) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SA3PR11MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: a613e7b1-98b8-49c8-9a84-08dbd52ab91f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jzLB6ATjT0ih6TSWf2uVm177n8xuQBGsJipzjI1In99TT5ugOedPZE1ZSNzTySYT89azsBetvEy97rLiRciArnZiWacCS5U13AZ//jcQfeSTUYJy8o+96uFdQIM1d48EQjRVCZLu1PpI3m5BHnHlWvkJeiM+jOwcvpd4kv7TUDPNPHCcypaBrResOxsVwopt03ef4B7/s66XFgIH5ZiRzVQOHfLWU1WyTUkUOJc2/ubMXb4rGN2sovTAFuvIzsIepAgdjSzbOv7OJb/+aacUFJjMYiqFYCvC+QpDpKQXsKA5puXoVX7vUgmMCx3kk4JQtx0O2Ac4XxSTOAgnv7GZijhaT6mXPVqyWaGk6QQ8OwgHZQwW4VuGuB/CrauHTKdX25ngnV8mYZK1ZgjZmwo59w5guNa0L1aVixrCkMI1b1yh9MFtt0D5F7HJEARbElr6aXLg5l+ATzoZtv1blC3U30gUG+rxfbiAnt7FhS8DezCPrLwxcd3bqcfh5obvBcqWYlXnJs0fi+VuS0RuLXAeuYnscvQI6ELH7qu0bBzLhzlXIsQquXfglswQyf48F7If
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2906002)(38100700002)(66946007)(66476007)(54906003)(316002)(6916009)(66556008)(6666004)(6506007)(82960400001)(478600001)(6512007)(6486002)(53546011)(83380400001)(5660300002)(86362001)(7416002)(4326008)(8676002)(41300700001)(8936002)(26005)(4001150100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fTFtaiggM1Igw4xF8opyNZamWnwa3639+v4FJ6zOaz9xgCZC6G+GCx43y3cC?=
 =?us-ascii?Q?EW/HEYTsNDCunPy/KpeM2Pq9m1Aqf9V63YF94gcKRa7IGNtLQyqzdBevOCrP?=
 =?us-ascii?Q?91c9cyXPmSO8cQTKJJg1OV6UDjabQ2E+ICpJdb5uAapVEt2Ofe/HT+tfXGaj?=
 =?us-ascii?Q?GqzABIHXgIdxfK8m4Ixdkr4kJ3z1SfypGmKo7cOiRdXWAPZI2sR3wn9lOq3d?=
 =?us-ascii?Q?75exMREVRhdYqi2erhZdDXbhx0G70H3t5LZ0wBE7zVwUGNUzruRFHaCW/wTT?=
 =?us-ascii?Q?14/pPfTGLEnqI/qw/kKibL2Bh5a3Dg4fhYu93ON++CHbgQeiYZXM1Df18XIl?=
 =?us-ascii?Q?+2OM6XZZxZQLpYjEIklJyrAYBNjgTLVuZuj6xFL1bpdxbboKm2XuWTBkrS9P?=
 =?us-ascii?Q?Bfb2Q2z4MA8Rf40GCaWrOsg4zVlQgenBCAHTRbgbaK519dZYAyT+5d6BQdKz?=
 =?us-ascii?Q?Cef/iV+RNumc1dkiFtYUtpl0gXnbOVwMkG/+1YcZjYN8xJxZiuf3zUrZD/6R?=
 =?us-ascii?Q?+qCA4Ckrlj/7FBDK0wQoWVrtzD92RNQ1rACsG5WI1mkezANBgUHNlG0pqfHa?=
 =?us-ascii?Q?eYmW4RofDN9Ho75Nu+qdoqwULbOIc5cQRyaqQsiuKzl/zkW+tPYAiVO6EFSh?=
 =?us-ascii?Q?qWe5jIAH+bZeGVkIx6sfNRsuHhKOdAGcb4I4ZEoIB5T3pxChLtGwAeJj0lQm?=
 =?us-ascii?Q?q1ZnhS4BSdhDT2c4dOA2cAe7g/0ANB38HLV9ch0rdsBBD0uKdQCcPPeYMe8z?=
 =?us-ascii?Q?/rH6VxysqS8vjil2w8LPxuyS9x0wqvQUUPmRF0CydzVQagZdlfYeZ1ihGysv?=
 =?us-ascii?Q?USv2PQbJoP1FJ87VZ1VGg1tL0fD3rigP1gANBVTLDW8ZaFPjd1oM5zXz9yYr?=
 =?us-ascii?Q?q2felvj1LhDwI3sJleFaFHaQYMkUdrgt48zeeL3YJqv8WmJXX70EaRqs2num?=
 =?us-ascii?Q?9UnSiCejZ9JPA+kaFCablbBWTVy89n+Cecv2Peq/LwBHlKK203B2EIgFMExw?=
 =?us-ascii?Q?sbP2IxGC54LJ91No+aD/mZRiyVfpzN6TL5Skdj/kThiS+fLxerWAm13BI2/n?=
 =?us-ascii?Q?SYh9W/QsQ/sXfu/yO/9Khh27xjiRp86JKMbEf7LGX4hD0s36cQl0rea+xMdU?=
 =?us-ascii?Q?CTVhqgd/FiHBBce9yuIlIdQ95DWg95/vLCTM5U303MJeX3pzkE2YoUbuC9GG?=
 =?us-ascii?Q?ASrMwPv+8g04itoSIZEMvt59GZKMR97knM+cNsu402R/vmZpz7z6S9qR3JnC?=
 =?us-ascii?Q?RPzdw0H4yVwwnyfdyNL1+TTSPVoTqjZpsI6fnQSMqwLAnqbxzpxmFfNnVGhb?=
 =?us-ascii?Q?SB3nnUXKPqtEdje7YrzORj6wjes+qHYKxUEA6vQfMBGONyFTIgoAUDjDa3y6?=
 =?us-ascii?Q?hMzj1MLcK84hBpvlmpXQiYv7QQAqAzxfmf11fzaIwzNopCH0NKFCT3TaWmGG?=
 =?us-ascii?Q?eWrqkYnLPUTFS/WYKKWeQRbCZguOuG52dMho3wEcBUpzIRvJ603j8f6XWvCN?=
 =?us-ascii?Q?oMMRw7clILh497X/+pF958TS+xR/zIXy1GPKv6G951gjJNcHV8KMtgd9dt2z?=
 =?us-ascii?Q?lGzpZO1Yghhf1orFiLylhu86inJd+KXoMp7CpdPF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a613e7b1-98b8-49c8-9a84-08dbd52ab91f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 07:19:27.6182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmSskxZpTBwFkkqRxHtUB8ihEtKTRHP2ljGtFS5DvuxC1jge31AfPHGic3CBgAv1qJ5JbIzPKH3qevChDiFDXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7626
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

On 2023-10-24 at 10:49:37 -0400, Mathieu Desnoyers wrote:
> On 2023-10-24 02:10, Chen Yu wrote:
> > On 2023-10-23 at 11:04:49 -0400, Mathieu Desnoyers wrote:
> > > On 2023-10-23 10:11, Dietmar Eggemann wrote:
> > > > On 19/10/2023 18:05, Mathieu Desnoyers wrote:
> > > 
> > > [...]
> > > > > +static unsigned long scale_rt_capacity(int cpu);
> > > > > +
> > > > > +/*
> > > > > + * Returns true if adding the task utilization to the estimated
> > > > > + * utilization of the runnable tasks on @cpu does not exceed the
> > > > > + * capacity of @cpu.
> > > > > + *
> > > > > + * This considers only the utilization of _runnable_ tasks on the @cpu
> > > > > + * runqueue, excluding blocked and sleeping tasks. This is achieved by
> > > > > + * using the runqueue util_est.enqueued.
> > > > > + */
> > > > > +static inline bool task_fits_remaining_cpu_capacity(unsigned long task_util,
> > > > > +						    int cpu)
> > > > 
> > > > Or like find_energy_efficient_cpu() (feec(), used in
> > > > Energy-Aware-Scheduling (EAS)) which uses cpu_util(cpu, p, cpu, 0) to get:
> > > > 
> > > >     max(util_avg(CPU + p), util_est(CPU + p))
> > > 
> > > I've tried using cpu_util(), but unfortunately anything that considers
> > > blocked/sleeping tasks in its utilization total does not work for my
> > > use-case.
> > > 
> > >  From cpu_util():
> > > 
> > >   * CPU utilization is the sum of running time of runnable tasks plus the
> > >   * recent utilization of currently non-runnable tasks on that CPU.
> > > 
> > 
> > I thought cpu_util() indicates the utilization decay sum of task that was once
> > "running" on this CPU, but will not sum up the "util/load" of the blocked/sleeping
> > task?
> > 
> > accumulate_sum()
> >      /* only the running task's util will be sum up */
> >      if (running)
> >         sa->util_sum += contrib << SCHED_CAPACITY_SHIFT;
> > 
> > WRITE_ONCE(sa->util_avg, sa->util_sum / divider);
> 
> The accumulation into the cfs_rq->avg.util_sum indeed only happens when the task
> is running, which means that the task does not actively contribute to increment
> the util_sum when it is blocked/sleeping.
> 
> However, when the task is blocked/sleeping, the task is still attached to the
> runqueue, and therefore its historic util_sum still contributes to the cfs_rq
> util_sum/util_avg. This completely differs from what happens when the task is
> migrated to a different runqueue, in which case its util_sum contribution is
> entirely removed from the cfs_rq util_sum:
> 
> static void
> enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> {
> [...]
>         update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH)
> [...]
> 
> static void
> dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> {
> [...]
>         if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
>                 action |= DO_DETACH;
> [...]
> 
> static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> {
> [...]
>         if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
> 
>                 /*
>                  * DO_ATTACH means we're here from enqueue_entity().
>                  * !last_update_time means we've passed through
>                  * migrate_task_rq_fair() indicating we migrated.
>                  *
>                  * IOW we're enqueueing a task on a new CPU.
>                  */
>                 attach_entity_load_avg(cfs_rq, se);
>                 update_tg_load_avg(cfs_rq);
> 
>         } else if (flags & DO_DETACH) {
>                 /*
>                  * DO_DETACH means we're here from dequeue_entity()
>                  * and we are migrating task out of the CPU.
>                  */
>                 detach_entity_load_avg(cfs_rq, se);
>                 update_tg_load_avg(cfs_rq);
> [...]
> 
> In comparison, util_est_enqueue()/util_est_dequeue() are called from enqueue_task_fair()
> and dequeue_task_fair(), which include blocked/sleeping tasks scenarios. Therefore, util_est
> only considers runnable tasks in its cfs_rq->avg.util_est.enqueued.
>
> The current rq utilization total used for rq selection should not include historic
> utilization of all blocked/sleeping tasks, because we are taking a decision to bring
> back a recently blocked/sleeping task onto a runqueue at that point. Considering
> the historic util_sum from the set of other blocked/sleeping tasks still attached to that
> runqueue in the current utilization mistakenly makes the rq selection think that the rq is
> busier than it really is.
> 

Thanks for the description in detail, it is very helpful! Now I understand that using cpu_util()
could overestimate the busyness of the CPU in UTIL_FITS_CAPACITY.

> I suspect that cpu_util_without() is an half-successful attempt at solving this by removing
> the task p from the considered utilization, but it does not take into account scenarios where many
> other tasks happen to be blocked/sleeping as well.

Agree, those non-migrated tasks could contribute to cfs_rq's util_avg.

thanks,
Chenyu
