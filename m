Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049267D63D2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjJYHqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbjJYHpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:45:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66722D73
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698219269; x=1729755269;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=c4dOxrtBIuE8Sf8DO2urQNCz1Xuiu1+r/zaWUCQRkkE=;
  b=N5EKgeld1pwnjgvf1SNOO3ZfGhgTJqIk/24MD3kkwvRF1mwWezHB0r8n
   vXo7cpZkvK1sf/9pHiItmFKv33Tcn5WZ9NLpqyNazGlQGRgVTXrCXgZD4
   5ZAlfCIpGN6bc4e0fBBsIQJbDqAdub5syf3xJ/gIQDxerYZE59XeEX0bL
   UpJfRlCDAUJuAHKAhHo+U1iAx70Yr17Ye2hhN2AD53ReMaVl4hFXGBRlM
   +GJYY8VPo6lWgIeagK/wgBRz650JX403/Mn1ILzhdEdrIQv/YaQRVReSN
   WYgg12VNVANpBYqu8WEpNPfjtdry3JgvtItpx2QcfLAmxDICtyvuwd/+4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="453728064"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="453728064"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 00:34:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="752248074"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="752248074"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 00:34:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 00:34:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 00:34:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 25 Oct 2023 00:34:25 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 00:34:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+NVx/SWqEjKL9hbjt5vIAUhvprq9WQmUwls1HkvKl/trZvuVQNmF0FFnU7dltZslu2ZXRfUKRizpLl6CQYJzpgGkh9fuNHkk8fhU66IzrLY86zsf37OFTWFD+apJGDaRNytka1V0VIr4HcixzGteVVeEVTqlOYWx8FJHigMZWW8dEuKdwxGNSMdkW1+ZOfxUN+cSi8mdh2k4uvKBmTDAu3b0NncjH1QVNk3RXdQWWhDeWXp4PImmIWsAadBihQK6YrqqEr7bQP/8JkFHSAZpscsR6/Lipf3D1LhT7pdKd0zBB9B9vBpdrviGIQb1DIzJXduoox4Kj1htvvVl+SzyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/z5JjzmyCtkHdbM2yMmBvhw3Yv4ph7FvRj0ceJvZ96o=;
 b=VPMPD4xo7L3iQAQdZ3dg3phl8nXYC/McYHgyk2eiqApJ8XTvz82ncfNWeuYdyTe1BTcugHfg1yset9uPRB+r6RL0F7MOSgu4DbrnaUsH6dEx92dGxato9nrrTCvFe1Nl58tbMaQUv8PQpWekyoyNIObYWEqDqKQKei1jRGD3kL20QgoX6IdZBcmjMCah26TAUcDu1O/3X2aXyTNIVAbMg8m5sSA+BvSI2E5R7BwExdfJb1f49aPjsQBAV/b23FjUhBvtSnbtOIMe/msMj9SQRwb1CINe+18D/xIKpNOjES8eM7EXEMvO/c5swMQUx00+sAZGpsuUu/9yUE3OKofKvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by LV8PR11MB8608.namprd11.prod.outlook.com (2603:10b6:408:1f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 25 Oct
 2023 07:34:19 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%5]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 07:34:19 +0000
Date:   Wed, 25 Oct 2023 15:34:02 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
CC:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Message-ID: <ZTjE6ofbjhsMcLVP@chenyu5-mobl2.ccr.corp.intel.com>
References: <20231019160523.1582101-1-mathieu.desnoyers@efficios.com>
 <20231019160523.1582101-2-mathieu.desnoyers@efficios.com>
 <f40522de-b71d-4848-8aa3-5b87d38bb847@arm.com>
 <c79ac631-61c7-4953-a657-74047a264029@efficios.com>
 <ZTdf0529DL51pj8m@chenyu5-mobl2.ccr.corp.intel.com>
 <14ab201e-0170-4dd7-a1ec-7587fe27385a@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <14ab201e-0170-4dd7-a1ec-7587fe27385a@arm.com>
X-ClientProxiedBy: SG2PR02CA0110.apcprd02.prod.outlook.com
 (2603:1096:4:92::26) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|LV8PR11MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d5cd51-957f-4b43-6283-08dbd52ccc15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qgEX7pB0mBkeKhsIsl7DFij/dCb9xDqr+rMvye4kfOdCKs8R5ie+BbByi3SbCfeM7m8tCXXe8xXa1G833r8eWxENEn3oL8x07Di6JY5hy+1sArFBonlYzGk7unA89UjXNyWF8vt566+ohcnwXKMX8ex5YBxpGKeg2wkNJs9kC5WGDIZ0Txxm54PDS+Z9qwsyy0Tgt5vmNRLyI11AOXGceT8fK94Mx7jfSPbeQdwWA9ibw2qXJqlch9fQaqxyX2ZSLjX42n0UxdfuyDcCmTxtopySd+GxrpA9b3FAcwIANXFWmMMrs3KEs4F5qPw10ATAjOri6m4nZMFFJaMtap93cEKn4ouYW5ssM377oWYGLbe1KXOCSbIhCbtZoYnC5KUNC4AyPpl83iMhDLlRKQJ1I0CgC9l8E1eqP0LkA+PLstyma45obSmjsBMIRTuufvRhgUpuNN2DaxubqsrAR/hY8aFzLy6bfMj+k1ZJisoj7uSTtmo2p/OBKZ8yhv6ICteIVCO5Rw7m7KAX9eigOgSUeJ9/EqQPQEEiRmfq00r44SBcLqDZsW7l+zjEXJ2lRcJq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6512007)(7416002)(53546011)(6506007)(82960400001)(38100700002)(83380400001)(5660300002)(26005)(6666004)(478600001)(54906003)(66556008)(66946007)(4326008)(41300700001)(8676002)(4001150100001)(316002)(6486002)(2906002)(86362001)(6916009)(8936002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?THT6llqn88doZfWY8fW2MNlvI3yIVUYmKWpAc/GXyuNoODTQznvUT7Cw2PRm?=
 =?us-ascii?Q?27EF4X5dlpLfLjBssSGMplQiTKS1blS0nTjtQ2IW61DxyXfqWFc3JEsji9pW?=
 =?us-ascii?Q?rJgLynsMWq2bSsFZ5B8z50ZG9/br1n6zXv87ihz6RC2+ylMWV+wG6/qg7d1r?=
 =?us-ascii?Q?wO8RwwVoKosipBbqBG0IngP15MUVwUivR+223s9XQ3R/g5KuQslakOFZdFn7?=
 =?us-ascii?Q?B979/RYw/A7jMKg3iZglbEtzE5uroN+wGuSEaUcSLkVXzyMAiDseAwrGcQtH?=
 =?us-ascii?Q?lHWn424yCJsoTTAhe9vGmeJXG4QpacrzviT7RmJuzA5N2vNrgA2cvqrqN2ZX?=
 =?us-ascii?Q?1nH2oIXUoA2e60JqYCeU5sugqHVPpy24JyKBxnbZRLf6cgNQnMgYqJhCH6kE?=
 =?us-ascii?Q?71nmUzWDZceeFgCiI02V+BwkwhOVivStf9mq7wHecU5HvIgFU3ySe9i1jViJ?=
 =?us-ascii?Q?jCBcC6ZwKK1zgVtuUenFizZmsxiAMlxSDagaoceJ1C790PvvvyCc8Z/F/wRn?=
 =?us-ascii?Q?l7OOjtyPvIf0LQV6dDBTE9DXPfOaXgTn3bsxls9DUWGuI0TUy5uZxNpzPLYA?=
 =?us-ascii?Q?bXyvYceEMeJ80lsSW13dveTXGHnB7jJMGMcXevadOL+Hh18Eao4uj2/nAW/U?=
 =?us-ascii?Q?B7en75gfzjn1ZYX+v2y55P3apl7vPS2JFZozop/fhgRHCDJjEppOiKmJmpOk?=
 =?us-ascii?Q?SFAmFUIihs1V/4areDiyJJWXPgq0HJwTmF7/8AuZoLDD+JskXlOeuyNv201p?=
 =?us-ascii?Q?Gzy4KVYJnB0EmEe5PbykYndTOKsjbd8bsmHuKOSXl+G378F6hbeLuGMQbha0?=
 =?us-ascii?Q?qQRj+M6EKdJeF7ubTADVHk5+OhiiN2NVvDu6OIGESS7E/mrb2T9+LPMT5E1Y?=
 =?us-ascii?Q?PpOKlKbFdBXrXIUfZdvbbYRVeehnTyWvmLqFmn00ISXGA7/rv0dFtUSN79Xe?=
 =?us-ascii?Q?h+ljnQjwObi5cAG9wpndMGYy+NY/JwonXHCWc5q+JTuJmTIIls73QBbYpoSp?=
 =?us-ascii?Q?OvmHWsxpS/DU5pyO7MD2PrzLZCZjfXGzQ31Q+n6RgVg6umfBeUjpHPrAdxqo?=
 =?us-ascii?Q?Wc++YbOF9pM69i5mlfFThyniTFN1SL4BR6uig7y3oGj5lQla3TyS776TR7CY?=
 =?us-ascii?Q?vLdcAnkpcVeIsBHLHP8NOOFONDKVLs0HT4YMauw42H93ZVWyegIHVdp54+Hk?=
 =?us-ascii?Q?FuHarDe+HY61z9whxikc3Iv4h8AnNfvmUY98ST/ARxdGo8nwr97L2FxmC4Lg?=
 =?us-ascii?Q?41lUT/+8/iYy9+qTb8lfFN87ATD/Vik+RJeMrDvkv65UzuCEIKjUK0F9Dtxu?=
 =?us-ascii?Q?OEAo6SJv9e7B2e7hnt+2W1FVCYz6pnTYpKoFYwqJzKQn8jUMtdSGvsxSdDK1?=
 =?us-ascii?Q?kn6jVv6HqgeZWbLfI1I5/kR0iyy09OnsmFCkCw+nD6BdwMCqiJVIIcZMqwop?=
 =?us-ascii?Q?a0T+Lso/dyIZ+XakV8WHa/jEOR9TljVf0wYDvW7cd8ugqAITwJVfPm2DE6Fr?=
 =?us-ascii?Q?mFSp3HNdDsdzpDBQ4JkCqd2GTSt8Q5nOaMNlAq+4nour4lp5Avr+bRmqF62g?=
 =?us-ascii?Q?ddhzxnEYhpzuIg0SOPtl5+Za16uDgVsHzgKvt3SQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d5cd51-957f-4b43-6283-08dbd52ccc15
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 07:34:18.5546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LXG5FXib+bNv7pmvd/KIefKvuTBG8SbBEwA6C5xliALVqQHTApkpjRIt9OucHEs5QXN2Nl9KgsVA5Z2te2xoBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8608
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-24 at 17:03:25 +0200, Dietmar Eggemann wrote:
> On 24/10/2023 08:10, Chen Yu wrote:
> > On 2023-10-23 at 11:04:49 -0400, Mathieu Desnoyers wrote:
> >> On 2023-10-23 10:11, Dietmar Eggemann wrote:
> >>> On 19/10/2023 18:05, Mathieu Desnoyers wrote:
> 
> [...]
> 
> >>> Or like find_energy_efficient_cpu() (feec(), used in
> >>> Energy-Aware-Scheduling (EAS)) which uses cpu_util(cpu, p, cpu, 0) to get:
> >>>
> >>>    max(util_avg(CPU + p), util_est(CPU + p))
> >>
> >> I've tried using cpu_util(), but unfortunately anything that considers
> >> blocked/sleeping tasks in its utilization total does not work for my
> >> use-case.
> >>
> >> From cpu_util():
> >>
> >>  * CPU utilization is the sum of running time of runnable tasks plus the
> >>  * recent utilization of currently non-runnable tasks on that CPU.
> >>
> > 
> > I thought cpu_util() indicates the utilization decay sum of task that was once
> > "running" on this CPU, but will not sum up the "util/load" of the blocked/sleeping
> > task?
> 
> cpu_util() here refers to:
> 
>     cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
> 
> which when called with (cpu, p, cpu, 0) and task_cpu(p) != cpu returns:
> 
>     max(util_avg(CPU + p), util_est(CPU + p))
> 
> The term `CPU utilization` in cpu_util()'s header stands for
> cfs_rq->avg.util_avg.
> 
> It does not sum up the utilization of blocked tasks but it can contain
> it. They have to be a blocked tasks and not tasks which were running in
> cfs_rq since we subtract utilization of tasks which are migrating away
> from the cfs_rq (cfs_rq->removed.util_avg in remove_entity_load_avg()
> and update_cfs_rq_load_avg()).

Thanks for this description in detail, Dietmar. Yes, I just realized that,
if the blocked tasks once ran on this cfs_rq and not being migrated away,
the cfs_rq's util_avg will contain those utils.

thanks,
Chenyu

> > accumulate_sum()
> >     /* only the running task's util will be sum up */
> >     if (running)
> >        sa->util_sum += contrib << SCHED_CAPACITY_SHIFT;
> > 
> > WRITE_ONCE(sa->util_avg, sa->util_sum / divider);
> 
> __update_load_avg_cfs_rq()
> 
>   ___update_load_sum(..., cfs_rq->curr != NULL
>                           ^^^^^^^^^^^^^^^^^^^^
>                           running
>     accumulate_sum()
> 
>       if (periods)
>         /* decay _sum */
>         sa->util_sum = decay_load(sa->util_sum, ...)
> 
>         if (load)
>           /* decay and accrue _sum */
>           contrib = __accumulate_pelt_segments(...)
> 
> When crossing periods we decay the old _sum and when additionally load
> != 0 we decay and accrue the new _sum as well.
