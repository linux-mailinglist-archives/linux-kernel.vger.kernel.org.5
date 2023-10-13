Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF2F7C8B61
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjJMQV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjJMQVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:21:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BC31709
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697214031; x=1728750031;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GbpOXpiMrfWjRazvBWNI6m1cF9fA+B2Hv8Gz1P1d+X4=;
  b=Rclo7A0wge7F9qYVHOj96deZKL/YdSImTGSxfTL/0QXGFYe0gi/1PD5y
   qQSlk61TiCTsens/BB0DMX2Q3MT5yfiO/PYfUNtJ3vQcowTbfKlRHkA4T
   VqHiOVit6KQkT8kLqt0/h+ZOd1EHOf3EBCWCuNYLyAO/p7UYO5B9LtMUW
   SfCtggxwW6Wc2rhnQxf68D0GGRIDomk/f0LZ9PaDme+F3u1shK/wIlvgW
   xvE0h1+u0QO6HbdB9dIxqVxD5y5HvZJsktvyt255YteSB2EvHBH/Q6ZFZ
   76trO1kHvLnAEOoBHF+ENtplu754IZxa+3aYl8ewSHVjshXeMZyE0+jX9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="365473805"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="365473805"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 09:20:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="898617284"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="898617284"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 09:18:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 09:20:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 09:20:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 09:20:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 09:20:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYCOUK7mprIVQDi5uUJv+vXx2x8jmpH3M7RPBurgTCqGR14yOocj99HLP77T++W8q6g4I9lY0q3eEAaw+VIJuA0PBeUnn1skitL9k/ZwFTNcQELXVrQ16OTS/RNI0hkH4n4eyIrMPxfS2UcvNnPRwT8WiH4MtBL1apdfnGAsJtjFVZxmUm1pvO0XRQx203cNq2U4jnk8hsGZ/dUgAYtuxMPI9fUVSc3d8SBgOLl0FNNFPGkUIwOKlmZDdyz2DqilyYcyABoN0tmG9M4Dk24g4m/4dzZwi3QqfZonPZ9oQXJdlExKOvhAln2//o1nIb2qNCMeTM0h8mogD20sxPWJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ea5Zu8C9QP8mTN0YzHYaE6rTWIafqJIFYd099r7UpHQ=;
 b=JBnp9DILnLY84WAks+lRjR7DTHtt9YPXFbFehul9ghfsEWSUjZjUyXXdlBEZTT2o/O+uWsDhAdEqd3yV/YT0Z3b5qt7iUCaP5LsWOPlWa/jZo8NkeyHJBtdcGhkiAMfSHZikrc/3V6lOz87ee7KN8PRu/9ThVgSRW+vcDaA1pS3t8a+fSC0yBKA/Dfihw/Rh9YIQGLbIUhD29BSaJGtMajHM4FJjHW+4iDoXrkWpVUlZcXOSvAtj8pyhJbmF0A63LlWIb/BeSPak9Zf/YGB9LT5nwDqltd5AqzcnS9QrkocM1Ivg1hsAO3TGmf/qH92wPq+dm4KP9sh0lXcF2tRyHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 16:20:27 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%5]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 16:20:27 +0000
Date:   Sat, 14 Oct 2023 00:20:10 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Yicong Yang <yangyicong@huawei.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <dietmar.eggemann@arm.com>, <tim.c.chen@linux.intel.com>,
        <gautham.shenoy@amd.com>, <mgorman@suse.de>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        <jonathan.cameron@huawei.com>, <ego@linux.vnet.ibm.com>,
        <srikar@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <21cnbao@gmail.com>, <kprateek.nayak@amd.com>,
        <wuyun.abel@bytedance.com>
Subject: Re: [PATCH v10 3/3] sched/fair: Use candidate prev/recent_used CPU
 if scanning failed for cluster wakeup
Message-ID: <ZSluOlEbnrrNj2LV@chenyu5-mobl2.ccr.corp.intel.com>
References: <20231012121707.51368-1-yangyicong@huawei.com>
 <20231012121707.51368-4-yangyicong@huawei.com>
 <CAKfTPtAdtjZobtrf846kDzscAZTrFxw21SQJbbHU0Cw35vggEQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKfTPtAdtjZobtrf846kDzscAZTrFxw21SQJbbHU0Cw35vggEQ@mail.gmail.com>
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|MW4PR11MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 23340c1b-5baf-4324-89fa-08dbcc084fef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gbSLVC03K8IiQlaeoX2pZgNs9/Aq5jViaRSPSxaCcN29JrFhqG9CWecfEEtMWaq8x0TEQSdbeGWzKFXEtN59oF9BQoxvHMVBPfEaG4mjnINhLvqB+7/2ZuEEzojPJqt1xfPauAoKehGVwqLDjhUFvXEnuesP9bGKqK+MVS37W0X6lmA2SWdAWsKZ06sxJuBZLgEmxhvhEBA106SHRo/M1X1ort1ImKEXnpbe45NbjtdK+k3fzO5SNQ5lT4Mdij/tpJ40g75tFgAEADKUr6ilOTKR3EoU+4Tm9L+MzQkJKWxrl02bNKWgrfk5m5VyXRMWRgGlJ9ET/x2jiY1D0IQrRFKwSr6SrT0MY9V1BqrUTUfQ0DsbjibHun09AAhEnGQ9XT6kbsQpe3Z+KM/e0o7kaSgU9682kcp5m9IRdjQmAkz8YLESugFYyOcMXUY9W05oQTRtO+4JD55pR28GxwzuOxdLVF5JMMESaBhCijW4tGy5+YkWX4KGcUWtOkneyg69nSAsYTgAKLAEVTo4xFuotXSEbEfcAjnz3vdaZUVlrU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(366004)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(83380400001)(66946007)(41300700001)(5660300002)(82960400001)(4326008)(316002)(6916009)(966005)(66476007)(7416002)(26005)(4001150100001)(2906002)(66556008)(8676002)(8936002)(6506007)(6512007)(53546011)(38100700002)(6666004)(478600001)(86362001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bTBhq+75AZABRBovmC12+RqUef+rF7jcPCZv8Kti20ixR7E/Z2lczD2Atx1G?=
 =?us-ascii?Q?k3LWql8nCNbG0g04C5d1lTN1HP/4O/ZZ5T5hC6Hw4FlfF5FzjQtqj7oZEb6X?=
 =?us-ascii?Q?u8PAqZb3e9bsAh8AWm+a58AJEYQyLGSvjTGL0hPLQo1FWTDrZHNriKN5Rn3x?=
 =?us-ascii?Q?7FJQSezSstYo+d9IAvEC/A5CmnssjUrZ+BT1gADhqTFCgNgFEZ6AHPeLEr58?=
 =?us-ascii?Q?S5tBUw0w9ycXrPjgjleCsgGoYDOGa9c4QCVG6196BOppl6kgepc4+vlzLor3?=
 =?us-ascii?Q?v16R2jRAgYTsQKZG2ckFpGTmGAVIvGa+8n+z5ES8cb9DKiq1AT+xKJvNFw6C?=
 =?us-ascii?Q?vyCzuHYmxl7I7A0lsLhJte3DU7fzUCtqa3QbiK1hYuDXXmmV8dlyBzp856SC?=
 =?us-ascii?Q?UBL0LRFxcaw5cBUX3/79R5SUtU7r4qU8rGjSQ//UAklyz8iMYCBFXIE02sJJ?=
 =?us-ascii?Q?2X5KzyB7zae9baVwq6MwHRuJBwd7KZHMV3WcXXp7uPR0dioLO50zvudNxdi1?=
 =?us-ascii?Q?hPajYJGb8rXsed/Psgd1qChf+r8pAhWWXwtoMCEbkl2raz3Vy3/L0k4PNz4h?=
 =?us-ascii?Q?UQBskfSFwxBBRRqPDRajlEE8hqpGYlrcUsdfGQOmkqWBQoeGCm6WbGv90pAf?=
 =?us-ascii?Q?Ok5yAPBXmUSRVbUnGBKN6YlUNLZmMBEpaWdUQXttHzfSINn6Yq0F866EM/tK?=
 =?us-ascii?Q?wqwtEx74Br11TR9pYn5JuAFFGsC3Zx4tV+5G6ZBJ0pd3RLT2qvkLVYWROjKA?=
 =?us-ascii?Q?W//Y+U2VT5zLNew6W7XSfqiKHn3ouIwS9XPeCKk86XDxJBwhbC5dV7A6zKoV?=
 =?us-ascii?Q?nHe+qBPak8qmxgZ5GQ29ENEkd0SCeFbXBUXBPzirK1M6ZpoWCdLqgTunrRcY?=
 =?us-ascii?Q?C2reyUz3Rtg2HtQQKVJ+tZ7bR/J9M84W6jJ4NEYndRyL5HJXtr0tw55Q6PCw?=
 =?us-ascii?Q?GrJ902Fzr0D44vvI+Q7ByKrVgAScAjOZfIsOXFSLnwe7iofiV4Km5LIOKgbp?=
 =?us-ascii?Q?Yigh0yF9LlOOhnWqw7qm0IvP3GeQdW82+kztzsODGEfzwwfzS2PiJbFNu51E?=
 =?us-ascii?Q?tyWsf9F5KSdLrHWoiGpqETF6XvNm/2vr18c01FcWswRHQbmnD2hsI4m46OYE?=
 =?us-ascii?Q?S3LxS0FtLsw7NcBrtfLd6CnSdgyNFbjsJRE8GlC1tVPm9mTOzklkeaVtzVKZ?=
 =?us-ascii?Q?vgmjB/zGbbqJVVzTno/iUlED5WpM7H018U0Raq/TihW7mGTjXKgn6ZqIMRlQ?=
 =?us-ascii?Q?pbEVuAfp7B7cCQlBSFCvUS0ICpQ92FFS4fDo+rQiI/YksY8EE9u8LvvJ5yDT?=
 =?us-ascii?Q?WMr/ZU08dSu4X/aj4UKzeQhs416rzWS2OaJW/PLJQgMpIhNTPF8eFmt8dHi7?=
 =?us-ascii?Q?6qcjtiK0xcaW5tV6pvfQjbQb4+oGjsm/VKxsXZQg9PHKZ2Yko/NWP+K2dnEm?=
 =?us-ascii?Q?H9TGJmYzgpyxyBkx3cG3NvbQ831nEUuOCYp9/2ODOfTLl3RnEu0PB6IraTVz?=
 =?us-ascii?Q?tKWQ1HY5iTsMSCMiVFUmRQ104tbvgQd82PkFFNDqlfNPg2q8k3xuBDAmshpK?=
 =?us-ascii?Q?Znvn9+X/hUXqB/1gMuCLxbKw1O46yKwlqFg1UxiK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23340c1b-5baf-4324-89fa-08dbcc084fef
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 16:20:27.7988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9KUN7wamQU0soo1jQ4jgvGvwEbzY7u/qRZ5InwwDCLhqWDR/5dGyUJxkSOgQDeuNCZSgT1hACz929mwcD7pjhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7125
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-13 at 17:04:32 +0200, Vincent Guittot wrote:
> On Thu, 12 Oct 2023 at 14:19, Yicong Yang <yangyicong@huawei.com> wrote:
> >
> > From: Yicong Yang <yangyicong@hisilicon.com>
> >
> > Chen Yu reports a hackbench regression of cluster wakeup when
> > hackbench threads equal to the CPU number [1]. Analysis shows
> > it's because we wake up more on the target CPU even if the
> > prev_cpu is a good wakeup candidate and leads to the decrease
> > of the CPU utilization.
> >
> > Generally if the task's prev_cpu is idle we'll wake up the task
> > on it without scanning. On cluster machines we'll try to wake up
> > the task in the same cluster of the target for better cache
> > affinity, so if the prev_cpu is idle but not sharing the same
> > cluster with the target we'll still try to find an idle CPU within
> > the cluster. This will improve the performance at low loads on
> > cluster machines. But in the issue above, if the prev_cpu is idle
> > but not in the cluster with the target CPU, we'll try to scan an
> > idle one in the cluster. But since the system is busy, we're
> > likely to fail the scanning and use target instead, even if
> > the prev_cpu is idle. Then leads to the regression.
> >
> > This patch solves this in 2 steps:
> > o record the prev_cpu/recent_used_cpu if they're good wakeup
> >   candidates but not sharing the cluster with the target.
> > o on scanning failure use the prev_cpu/recent_used_cpu if
> >   they're still idle
> >
> > [1] https://lore.kernel.org/all/ZGzDLuVaHR1PAYDt@chenyu5-mobl1/
> > Reported-by: Chen Yu <yu.c.chen@intel.com>
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > ---
> >  kernel/sched/fair.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 4039f9b348ec..f1d94668bd71 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7392,7 +7392,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >         bool has_idle_core = false;
> >         struct sched_domain *sd;
> >         unsigned long task_util, util_min, util_max;
> > -       int i, recent_used_cpu;
> > +       int i, recent_used_cpu, prev_aff = -1;
> >
> >         /*
> >          * On asymmetric system, update task utilization because we will check
> > @@ -7425,6 +7425,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >
> >                 if (cpus_share_resources(prev, target))
> >                         return prev;
> > +
> > +               prev_aff = prev;
> >         }
> >
> >         /*
> > @@ -7457,6 +7459,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >
> >                 if (cpus_share_resources(recent_used_cpu, target))
> >                         return recent_used_cpu;
> > +       } else {
> > +               recent_used_cpu = -1;
> >         }
> >
> >         /*
> > @@ -7497,6 +7501,19 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >         if ((unsigned)i < nr_cpumask_bits)
> >                 return i;
> >
> > +       /*
> > +        * For cluster machines which have lower sharing cache like L2 or
> > +        * LLC Tag, we tend to find an idle CPU in the target's cluster
> > +        * first. But prev_cpu or recent_used_cpu may also be a good candidate,
> > +        * use them if possible when no idle CPU found in select_idle_cpu().
> > +        */
> > +       if ((unsigned int)prev_aff < nr_cpumask_bits &&
> > +           (available_idle_cpu(prev_aff) || sched_idle_cpu(prev_aff)))
> 
> Hasn't prev_aff (i.e. prev) been already tested as idle ?
>

It aims to shrink the race window that the prev idle CPU becomes non-idle during above
select_idle_cpu() scan(maybe time consuming). And it wants to make a double check.

thanks,
Chenyu
 
> > +               return prev_aff;
> > +       if ((unsigned int)recent_used_cpu < nr_cpumask_bits &&
> > +           (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)))
> > +               return recent_used_cpu;
> 
> same here
> 
> 
> > +
> >         return target;
> >  }
> >
> > --
> > 2.24.0
> >
