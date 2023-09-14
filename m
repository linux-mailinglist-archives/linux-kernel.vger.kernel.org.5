Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32167A0214
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjINLBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjINLBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:01:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8326E1BF8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694689306; x=1726225306;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=b6dtzBmyU/z4P0S1XBW8qvv/GlDyMG2mMWbT11s07WQ=;
  b=NWkj8YeSUwcbEeVuEDiKnJdBh40L0CxIJIVx7t6MKLWBRtULjv3TaQKB
   qGqPmTFbtM/HO/Dl7+bzFsuuwNxo5QWXMJs2Gza20ERzCeGl7M2NKtEcr
   i5jqs+wORAFM9/iv6zbSeo7Y+FZeETvLBtne2VgJ9+m9vGBiAf2F+mSCX
   k6hByKewGurbXKBCwUUWYpZlEGNrQk2mfjWN2N0IepSeR7QsoAk+SpWaP
   /5RJ83EmH+nC3gn98RXuhLsJ/Kmz8g7u7ZlynlvQNpeDuO0Gswp5viE8Z
   Pe4hsChhrUJqQLG6prluKI74jH3daxk6/ai6YWEzfjR5tQwXquGBWLPBZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="369191106"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="369191106"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 04:01:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="737882153"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="737882153"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 04:01:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 04:01:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 04:01:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 04:01:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 04:01:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efCo/4gFrcsxkdoDn+yBWWeMi5tkc3iFGL4Yh7pyANZlJGjHY2FSthkJ5rKn5t6CoxD+rJEPKXhZcWpAImAxTA6MVwmwY31R5a5hZs/WjtSNoBkDXvaFa5lfIyT5hAGtP1JDRL0utoEClsISCIeVfb+B2Bovk1TYYhyte4XilbBaIp4ILayE3cvRP1UXf73FkDZ9phFvCoVchjk3BKbeJohNWZO+EfHowbl0UIlUU1R3pfAllltcfaK3JsHu4g6l5q+MJX/+4xFkQS9LLzJ+8lkJqKjKlvzklJ+jYYvDt/YpNcunOQUfZA4MJK6prwj73yVDnSKPnY5TMtCTOeLwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOs3HFdjhBkzzzqzPz6x6ru7pGAgnLtpeHzxpnE9BUM=;
 b=Zn7+n/AUMCMzw9XdRvHik3YsmInG0GTdj9jiZMXro9ikzMS3Qq4AiQqycXlbY6Hfyi4435ueHit4zXKv7XWHuNWIS560eb1i2Qtehkqu/tEfFAGMsH/z/5xFqriulElRCedj//2l4RQTBWo3vDxBbgBGso24tMf8DNyM+cZwqaaWz6yfYSaww/8sp0+19KyBc7BOpIrgbrqMrpT04O1fHD1unMnKD2mVpa+8GVXzy8+JuOSBgV1DoiNT/eg5cy6a+5RzC4mBZF3MHHfhrLug9PuRrmPGRPZ9gGQxchp4H2spTtmPDNJI/jbFe8k8QSajtnfNOVohBxAZbtmvc1d1Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SA1PR11MB8523.namprd11.prod.outlook.com (2603:10b6:806:3b5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 11:01:41 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 11:01:40 +0000
Date:   Thu, 14 Sep 2023 19:01:21 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
CC:     Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC PATCH 2/2] sched/fair: skip the cache hot CPU in
 select_idle_cpu()
Message-ID: <ZQLoAQcQJDCrdOGd@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
 <31c910c2-717d-b86c-4e08-5c94383682e8@amd.com>
 <ZP7ptt70uF10wxlg@chenyu5-mobl2>
 <5b35ae2b-a401-2489-4b3a-a03e8284d138@amd.com>
 <ZQBaWRCmMOvIGmem@chenyu5-mobl2.ccr.corp.intel.com>
 <229069c1-3d61-53bb-fff7-691942c48d21@amd.com>
 <ZQElEM5GAn/Vq0tM@chenyu5-mobl2.ccr.corp.intel.com>
 <86f761a4-9805-c704-9c23-ec96065fa389@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86f761a4-9805-c704-9c23-ec96065fa389@amd.com>
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SA1PR11MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d5155f-ad26-48ba-f7bb-08dbb511f958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IwF8sTKTgdEFgDjkGzyX6lBpWk8U9cAhM9PwBirfeBW144aPsIeOaaR4p/6/OhmRQeoEvWCBiN+xWN0MrNqgbTjjJ7mv0sTZYihc/X33U2FhSvy0PztgpVGrm3XcudNKnyd4yxQDh3Znp5k5ceQDNSXKWkObvktpMg8kRmdcA6NU1oTXWfJk8Qtk5xEs1VDhTInyPeSvod5bv+HPPQU8KeUt38KQ6dZRAuRH1wY7wp/KBR+0skLKsyAO4pVOLesWDInEJQmpY+Lk+oxeI4umJ8OnZSs7ZkLKM/MAJOg6CLHzfjC0rGfQ2ALKVfw48mhXWmadK6l5F2XyWHrA76mtiDRZoahgRWuHAUC++vdNZKX7zvt8pTk13vdcSSrxIYy6ZngOkm6JAJFz4W0mmp3KYuf0JgZlTCP1kS31n+Oi0GFR6nGXCI/FwXbFBK142a/mfwgDZvhgRqBTzyPDxwRnUOtgprqvPV5cZ/JVMrUdV0pL412X8JpncpZH3sOu6ATbBRAwkHP060MbQvgTi09Tm8jOzIORcfAtiLzBRoTxTzwWpU2ksytbMlaBdZ1wC+Ir
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(39860400002)(366004)(1800799009)(186009)(451199024)(2906002)(83380400001)(30864003)(7416002)(82960400001)(6506007)(53546011)(6486002)(66476007)(66556008)(54906003)(6916009)(316002)(66946007)(478600001)(6666004)(26005)(5660300002)(41300700001)(6512007)(8676002)(4326008)(8936002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tGv8pN5ypJ6nu1odgfDg3TUzGqrskFaPJN12GVurtpxX41WxXcQI4AoV/04J?=
 =?us-ascii?Q?EAHx77qwvDPc9BY67pHYXFJ2PPfI08X4b2dfeOjMeTXErf+fbxxR1Wvv/cbV?=
 =?us-ascii?Q?24ZAUPPktFjYW8umVckYjkFZvrCQ2Ywrfk+ibOF1UwR2xQH3wb2eIY9jdJnA?=
 =?us-ascii?Q?EJQrJmBuQr4rAmP1OpLzDCRLV4YgK9pq2jvBNjSYDuVcS4p0l0ZeBePLjm0M?=
 =?us-ascii?Q?Szhc2U2Bk28FOd3z6Gt5WZKYU5y2TcWvQva+EXGI3cdOzGsW+EyBbeDiT4Z2?=
 =?us-ascii?Q?3BU3vC66Q+Tgil2gS4CXgm88yj5cNSrY3/iOsSEIx/u03XEqU+BrYpe8i5VS?=
 =?us-ascii?Q?3kSFR96P7kzhD+lOvFteOx0YjZILXMqADsrZYPnPkjXmvdnwgX9ynjvlifqL?=
 =?us-ascii?Q?x7rOlEDP5qtYpKXYnTm5BZ1zDgCMdecf9Qv/rVkrD9kcaGfLx82Wyu1yPo7g?=
 =?us-ascii?Q?jxyujzWiOQmqM1VroNn+GU+yUx2d3/jDPGBou11ZKBjVpt+ckaH0mvOL/C+J?=
 =?us-ascii?Q?oxmEl3c8TJeHpk21VSGvaOOZI4GqL8686AcZMXw6EAn5POI4+wjTJ2fZN58Y?=
 =?us-ascii?Q?4amRI7dmDUlXljdc/uamrt3CRyxoRjl3QMVgN93Mponm709l7oX/4zNpX1Gd?=
 =?us-ascii?Q?9Psc5Cz1Nd/5xBQAwfnOWtEWgsqGlemEkeB2oGanyNKqjKCPC3qk3L51UHtf?=
 =?us-ascii?Q?hPVoxH7QkozRDwqKUaeKEUEJY/uCIUuowsbYm0KYkaARuLZo3xizKvzFF8nE?=
 =?us-ascii?Q?BnECYcomRtWQ2pB5iAEBgei8Uqzs4KuAmYvIQDuViOpj5Sbw81vrKUijqKDh?=
 =?us-ascii?Q?Gwv7yD5WI66hezADLmaYCKGsv84eDgAY/wuwrM0NiHQSJ02GNz8c1n19As48?=
 =?us-ascii?Q?PpDbqus2JSEFVLB/16XSwYULb0qmocfq0zrSfrozhB5sS4/MzwLZw44VCcEg?=
 =?us-ascii?Q?psjoxuvvQRSFUGhUAq2jqTcNFAxmtR4NbPDJ8NL6n89boIw6yTbeG+YPyIND?=
 =?us-ascii?Q?kMfodglxBGMIcTiSPIEsBcTvUfCVWdiYz78L2MGIyh5FVoiyGsyiGX1f/u7T?=
 =?us-ascii?Q?UJL8RoGDo+jXbEYA7rHCmuVGXMVA3YQY5UyNSPuW8F1XaZHN/WliFtoQWT0I?=
 =?us-ascii?Q?iVMu/glAgpP2o4dxGeADK5FJ+HGYnqUR/ENA8w2AntPiwg9CpuPsMU8Se7sK?=
 =?us-ascii?Q?S6IL6G3Z5MFPD7KPgDG7sqcJq7n1pE9DxBkf86aYJ0WsssPWcXWX66MzFmTr?=
 =?us-ascii?Q?rfgqAAZZrVVG/XywDMVXQdx9yRe4URibaugk++UqFCN3u++ty3BTn1kX+ElV?=
 =?us-ascii?Q?+PepSw7JBNjZ1tRhj3052Hfl933PFinxtV9maT6w4/5UwPCJM6kTftCH5i3n?=
 =?us-ascii?Q?1Xmoe0k6kiY9yYEeBhoo5ZHT8phBYkr2IXesmm5eGb2yKOqLXGFuDo3A59TO?=
 =?us-ascii?Q?79JgKPNK5XzPPWL7NByD61/GvRGwgmkc6kdAi9XKbE5PevXwTp+Ywj9XivQ6?=
 =?us-ascii?Q?ePsmB25AJG9ziLmGbTwHeGr6tN7hX/5mTZNpIS2V/39YBIM2erczGymtQ693?=
 =?us-ascii?Q?caAjxQGFja8EPvxFNya9Cl0TIXSbSA5SQaT+Ywez?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d5155f-ad26-48ba-f7bb-08dbb511f958
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 11:01:40.8636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wj/W63Eyp1KamTqd9Y4AJGUeyrgmVsZn6ERgEjmtDQNiIhak2DdEy/S3+1rOf0ODTHvBKagG5ssvYFcnMoXlTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8523
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prateek,

thanks for the test,

On 2023-09-14 at 09:43:52 +0530, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> On 9/13/2023 8:27 AM, Chen Yu wrote:
> > On 2023-09-12 at 19:56:37 +0530, K Prateek Nayak wrote:
> >> Hello Chenyu,
> >>
> >> On 9/12/2023 6:02 PM, Chen Yu wrote:
> >>> [..snip..]
> >>>
> >>>>> If I understand correctly, WF_SYNC is to let the wakee to woken up
> >>>>> on the waker's CPU, rather than the wakee's previous CPU, because
> >>>>> the waker goes to sleep after wakeup. SIS_CACHE mainly cares about
> >>>>> wakee's previous CPU. We can only restrict that other wakee does not
> >>>>> occupy the previous CPU, but do not enhance the possibility that
> >>>>> wake_affine_idle() chooses the previous CPU.
> >>>>
> >>>> Correct me if I'm wrong here,
> >>>>
> >>>> Say a short sleeper, is always woken up using WF_SYNC flag. When the
> >>>> task is dequeued, we mark the previous  CPU where it ran as "cache-hot"
> >>>> and restrict any wakeup happening until the "cache_hot_timeout" is
> >>>> crossed. Let us assume a perfect world where the task wakes up before
> >>>> the "cache_hot_timeout" expires. Logically this CPU was reserved all
> >>>> this while for the short sleeper but since the wakeup bears WF_SYNC
> >>>> flag, the whole reservation is ignored and waker's LLC is explored.
> >>>>
> >>>
> >>> Ah, I see your point. Do you mean, because the waker has a WF_SYNC, wake_affine_idle()
> >>> forces the short sleeping wakee to be woken up on waker's CPU rather the
> >>> wakee's previous CPU, but wakee's previous has been marked as cache hot
> >>> for nothing?
> >>
> >> Precisely :)
> >>
> >>>
> >>>> Should the timeout be cleared if the wakeup decides to not target the
> >>>> previous CPU? (The default "sysctl_sched_migration_cost" is probably
> >>>> small enough to curb any side effect that could possibly show here but
> >>>> if a genuine use-case warrants setting "sysctl_sched_migration_cost" to
> >>>> a larger value, the wakeup path might be affected where lot of idle
> >>>> targets are overlooked since the CPUs are marked cache-hot forr longer
> >>>> duration)
> >>>>
> >>>> Let me know what you think.
> >>>>
> >>>
> >>> This makes sense. In theory the above logic can be added in
> >>> select_idle_sibling(), if target CPU is chosen rather than
> >>> the previous CPU, the previous CPU's cache hot flag should be
> >>> cleared.
> >>>
> >>> But this might bring overhead. Because we need to grab the rq
> >>> lock and write to other CPU's rq, which could be costly. It
> >>> seems to be a trade-off of current implementation.
> >>
> >> I agree, it will not be pretty. Maybe the other way is to have a
> >> history of the type of wakeup the task experiences (similar to
> >> wakee_flips but for sync and non-syn wakeups) and only reserve
> >> the CPU if the task wakes up more via non-sync wakeups? Thinking
> >> out loud here.
> >>
> > 
> > This looks good to consider the task's attribute, or maybe something
> > like this:
> > 
> > new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
> > if (new_cpu != prev_cpu)
> > 	p->burst_sleep_avg >>= 1;
> > So the duration of reservation could be shrinked.
> 
> That seems like a good approach.
> 
> Meanwhile, here is result for the current series without any
> modifications:
> 
> tl;dr
> 
> - There seems to be a noticeable increase in hackbench runtime with a
>   single group but big gains beyond that. The regression could possibly
>   be because of added searching but let me do some digging to confirm
>   that. 

Ah OK. May I have the command to run 1 group hackbench?

> 
> - Small regressions (~2%) noticed in ycsb-mongodb (medium utilization)
>   and DeathStarBench (High Utilization)
> 
> - Other benchmarks are more of less perf neutral with the changes.
> 
> More information below:
> 
> o System information
> 
>   - Dual socket 3rd Generation EPYC System (2 x 64C/128T)
>   - NPS1 mode (each socket is a NUMA node)
>   - Boost Enabled
>   - C2 disabled (MWAIT based C1 is still enabled)
> 
> 
> o Kernel information
> 
> base		:   tip:sched/core at commit b41bbb33cf75 ("Merge branch
> 		    'sched/eevdf' into sched/core")
> 		  + cheery-pick commit 63304558ba5d ("sched/eevdf: Curb
> 		    wakeup-preemption")
> 
> SIS_CACHE	:   base
> 		  + this series as is
> 
> 
> o Benchmark results
> 
> ==================================================================
> Test          : hackbench
> Units         : Normalized time in seconds
> Interpretation: Lower is better
> Statistic     : AMean
> ==================================================================
> Case:          base[pct imp](CV)     SIS_CACHE[pct imp](CV)
>  1-groups     1.00 [ -0.00]( 1.89)     1.10 [-10.28]( 2.03)
>  2-groups     1.00 [ -0.00]( 2.04)     0.98 [  1.57]( 2.04)
>  4-groups     1.00 [ -0.00]( 2.38)     0.95 [  4.70]( 0.88)
>  8-groups     1.00 [ -0.00]( 1.52)     0.93 [  7.18]( 0.76)
> 16-groups     1.00 [ -0.00]( 3.44)     0.90 [  9.76]( 1.04)
> 
> 
> ==================================================================
> Test          : tbench
> Units         : Normalized throughput
> Interpretation: Higher is better
> Statistic     : AMean
> ==================================================================
> Clients:          base[pct imp](CV)     SIS_CACHE[pct imp](CV)
>     1     1.00 [  0.00]( 0.18)     0.98 [ -1.61]( 0.27)
>     2     1.00 [  0.00]( 0.63)     0.98 [ -1.58]( 0.09)
>     4     1.00 [  0.00]( 0.86)     0.99 [ -0.52]( 0.42)
>     8     1.00 [  0.00]( 0.22)     0.98 [ -1.77]( 0.65)
>    16     1.00 [  0.00]( 1.99)     1.00 [ -0.10]( 1.55)
>    32     1.00 [  0.00]( 4.29)     0.98 [ -1.73]( 1.55)
>    64     1.00 [  0.00]( 1.71)     0.97 [ -2.77]( 3.74)
>   128     1.00 [  0.00]( 0.65)     1.00 [ -0.14]( 0.88)
>   256     1.00 [  0.00]( 0.19)     0.97 [ -2.65]( 0.49)
>   512     1.00 [  0.00]( 0.20)     0.99 [ -1.10]( 0.33)
>  1024     1.00 [  0.00]( 0.29)     0.99 [ -0.70]( 0.16)
> 
> 
> ==================================================================
> Test          : stream-10
> Units         : Normalized Bandwidth, MB/s
> Interpretation: Higher is better
> Statistic     : HMean
> ==================================================================
> Test:          base[pct imp](CV)     SIS_CACHE[pct imp](CV)
>  Copy     1.00 [  0.00]( 4.32)     0.90 [ -9.82](10.72)
> Scale     1.00 [  0.00]( 5.21)     1.01 [  0.59]( 1.83)
>   Add     1.00 [  0.00]( 6.25)     0.99 [ -0.91]( 4.49)
> Triad     1.00 [  0.00](10.74)     1.02 [  2.28]( 6.07)
> 
> 
> ==================================================================
> Test          : stream-100
> Units         : Normalized Bandwidth, MB/s
> Interpretation: Higher is better
> Statistic     : HMean
> ==================================================================
> Test:          base[pct imp](CV)     SIS_CACHE[pct imp](CV)
>  Copy     1.00 [  0.00]( 0.70)     0.98 [ -1.79]( 2.26)
> Scale     1.00 [  0.00]( 6.55)     1.03 [  2.80]( 0.74)
>   Add     1.00 [  0.00]( 6.53)     1.02 [  2.05]( 1.82)
> Triad     1.00 [  0.00]( 6.66)     1.04 [  3.54]( 1.04)
> 
> 
> ==================================================================
> Test          : netperf
> Units         : Normalized Througput
> Interpretation: Higher is better
> Statistic     : AMean
> ==================================================================
> Clients:          base[pct imp](CV)     SIS_CACHE[pct imp](CV)
>  1-clients     1.00 [  0.00]( 0.46)     0.99 [ -0.55]( 0.49)
>  2-clients     1.00 [  0.00]( 0.38)     0.99 [ -1.23]( 1.19)
>  4-clients     1.00 [  0.00]( 0.72)     0.98 [ -1.91]( 1.21)
>  8-clients     1.00 [  0.00]( 0.98)     0.98 [ -1.61]( 1.08)
> 16-clients     1.00 [  0.00]( 0.70)     0.98 [ -1.80]( 1.04)
> 32-clients     1.00 [  0.00]( 0.74)     0.98 [ -1.55]( 1.20)
> 64-clients     1.00 [  0.00]( 2.24)     1.00 [ -0.04]( 2.77)
> 128-clients    1.00 [  0.00]( 1.72)     1.03 [  3.22]( 1.99)
> 256-clients    1.00 [  0.00]( 4.44)     0.99 [ -1.33]( 4.71)
> 512-clients    1.00 [  0.00](52.42)     0.98 [ -1.61](52.72)
> 
> 
> ==================================================================
> Test          : schbench (old)
> Units         : Normalized 99th percentile latency in us
> Interpretation: Lower is better
> Statistic     : Median
> ==================================================================
> #workers:          base[pct imp](CV)     SIS_CACHE[pct imp](CV)
>   1     1.00 [ -0.00]( 2.28)     0.96 [  4.00](15.68)
>   2     1.00 [ -0.00]( 6.42)     1.00 [ -0.00](10.96)
>   4     1.00 [ -0.00]( 3.77)     0.97 [  3.33]( 7.61)
>   8     1.00 [ -0.00](13.83)     1.08 [ -7.89]( 2.86)
>  16     1.00 [ -0.00]( 4.37)     1.00 [ -0.00]( 2.13)
>  32     1.00 [ -0.00]( 8.69)     0.95 [  4.94]( 2.73)
>  64     1.00 [ -0.00]( 2.30)     1.05 [ -5.13]( 1.26)
> 128     1.00 [ -0.00](12.12)     1.03 [ -3.41]( 5.08)
> 256     1.00 [ -0.00](26.04)     0.91 [  8.88]( 2.59)
> 512     1.00 [ -0.00]( 5.62)     0.97 [  3.32]( 0.37)
> 
> 
> ==================================================================
> Test          : Unixbench
> Units         : Various, Throughput
> Interpretation: Higher is better
> Statistic     : AMean, Hmean (Specified)
> ==================================================================
> Metric		variant                      base		     SIS_CACHE
> Hmean     unixbench-dhry2reg-1            41248390.97 (   0.00%)    41485503.82 (   0.57%)
> Hmean     unixbench-dhry2reg-512        6239969914.15 (   0.00%)  6233919689.40 (  -0.10%)
> Amean     unixbench-syscall-1              2968518.27 (   0.00%)     2841236.43 *   4.29%*
> Amean     unixbench-syscall-512            7790656.20 (   0.00%)     7631558.00 *   2.04%*
> Hmean     unixbench-pipe-1                 2535689.01 (   0.00%)     2598208.16 *   2.47%*
> Hmean     unixbench-pipe-512             361385055.25 (   0.00%)   368566373.76 *   1.99%*
> Hmean     unixbench-spawn-1                   4506.26 (   0.00%)        4551.67 (   1.01%)
> Hmean     unixbench-spawn-512                69380.09 (   0.00%)       69264.30 (  -0.17%)
> Hmean     unixbench-execl-1                   3824.57 (   0.00%)        3822.67 (  -0.05%)
> Hmean     unixbench-execl-512                12288.64 (   0.00%)       11728.12 (  -4.56%)
> 
> 
> ==================================================================
> Test          : ycsb-mongodb
> Units         : Throughput
> Interpretation: Higher is better
> Statistic     : AMean
> ==================================================================
> base            : 309589.33 (var: 1.41%) 
> SIS_CACHE       : 304931.33 (var: 1.29%) [diff: -1.50%]
> 
> 
> ==================================================================
> Test          : DeathStarBench
> Units         : Normalized Throughput, relative to base
> Interpretation: Higher is better
> Statistic     : AMean
> ==================================================================
> Pinning         base     SIS_CACHE
> 1 CCD           100%      99.18% [%diff: -0.82%]
> 2 CCD           100%      97.46% [%diff: -2.54%]
> 4 CCD           100%      97.22% [%diff: -2.78%]
> 8 CCD           100%      99.01% [%diff: -0.99%]
> 
> --
> 
> Regression observed could either be because of the larger search time to
> find a non cache-hot idle CPU, or perhaps just the larger search time in
> general adding to utilization and curbing the SIS_UTIL limits further.

Yeah that is possible. And you also mentioned that we should consider the
cache-hot idle CPU if we can not find any cache-cold idle CPUs, that
might be a better choice than forcely putting the wakee on the current
CPU which brings task stacking.

> I'll go gather some stats to back my suspicion (particularly for
> hackbench).
>

Thanks!
Chenyu
