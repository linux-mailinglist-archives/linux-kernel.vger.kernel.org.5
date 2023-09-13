Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D177A79E0C5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbjIMHZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjIMHZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:25:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1FE1727
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 00:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694589942; x=1726125942;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zJUBea4r/mZIWJI4R0Sn4y1yidoZYJbkGdCjCIXmwf0=;
  b=WEQ5ctmN5hlcR2y/lTMDWZH2jM65J6eunW+YyZ4PwMi9LX6+MdbqYICY
   krJVdyQ4P+jlaYf/TQT3KttWZMM5Qj/PCNeKo3DMM2t2YlsImaA51I/72
   xJLuNnge2E9xk352alPpCRw89CUZ964VEiQlHgGbLgOVGOWp7jfn58TuM
   cSAwwzlzZ796poNdz1+4z67oJRzqEUqw2JefsjLfxxB/UQ6CtmnS32taD
   2xL2LzVqXUP0oDsTyNyN5FoWx14Z8pb8cV7HaePkFy/VKYH5WG37RRgf2
   6uWRkKvU4+DFFk5BQk/pp7bh12t+uBxgz7KKwtWxw7SUAe13KB1zDpUv3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="409535972"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="409535972"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 00:25:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="744012583"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="744012583"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 00:25:36 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 00:25:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 00:25:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 00:25:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zv6CJa05R/3PjaPqMzPDUtgUdaiCSJVGEkELLEi8yNfTx1WGsxdZm/Q325ZTICv+OX1U+4SfD0Pnlxo9EOnbiIZJCqZmBgnZiSTsZXuXjdswL/JteKoe16QiNacCpdepKG55JaorPCiJXtSdwvvtbZbmOY1c6b+4BonDw+/DZR8jKq2Zislnkc7SY+56+7RtwWMXHphZwwyX5CMDfjv8OtJVfGaiygPV2QZYMUIs1jpY8s4Z0mkUhI2+6CQlD1N7vpZsYRF+h6/2+qcMAjLeZommVgQLAfWAHsJaA1m34o+z2NbnnmT43QOJAafO5GbuImuJ+HfTHmGskAh4t2HZqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRpHCmgeMZCLhAuKU7vfYxuJhwAnuQ2yXX6bPdB1jWI=;
 b=kBs769eupURgawmjBRXKAhId3MK8ky7PG4SF1zmHF76IqKpCWW55E9tfTDjYXExM7NSo59sOE/WpaYqthPClG5ykSP3oy1K+i5at2ePNAjfLofy0yuIqDwed25ejFkCG8aZJrAMpGlKzV+En/UWA2gLTlp6lTd9ruTKRKUa5s8Szo005THmFP0uG1ogsQgYQx8Nq7w2wW4QtN1pON+htnVr73T1AY3nPF5l3zwbVyfMg/pjVm5/GQT/KM93wCxwBZnmtrIaUMbaSJ2E8dEGgzUoZwTMoTM1qUCB+E6xzwSdOCI2ICIsEN8KQ4QJPRhcY8xad37PmSumtnTc8ww64oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH0PR11MB5189.namprd11.prod.outlook.com (2603:10b6:510:3d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Wed, 13 Sep
 2023 07:25:32 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 07:25:31 +0000
Date:   Wed, 13 Sep 2023 15:25:14 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
CC:     Aaron Lu <aaron.lu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "K Prateek Nayak" <kprateek.nayak@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] sched/fair: skip the cache hot CPU in
 select_idle_cpu()
Message-ID: <ZQFj2hk4i1QAWEQp@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
 <20230911072629.GA298322@ziqianlu-dell>
 <ZP7SYu+gxlc/YjHu@chenyu5-mobl2>
 <ZQFVFv4GcPOU+X7N@BLR-5CG11610CF.amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZQFVFv4GcPOU+X7N@BLR-5CG11610CF.amd.com>
X-ClientProxiedBy: SG2PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:4:91::24) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH0PR11MB5189:EE_
X-MS-Office365-Filtering-Correlation-Id: 62c5c4fd-4098-4a9c-cf09-08dbb42a9cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QuWawHU0sb3pPQvD6Rtx5IcmouJTNeiGIi9pyn9K+T9pZa97Jcya++MczXD5dikl/8AzWjKXlgZWDrHPf8ywE23v+F6G8Hq/sAHo6/quQDuGY4fQvIMFao82MQX1/0kU2uGAqBGeVdIzULXPy93hxbBeKJ1TfsEvnyFo7hOn81NJgh07wAWuRVNr8fDSWtpuN27V8bGuxnhVngqM5ehEykdGic+hwDAPRFK7o20lrSCsn9+rKeC5Lvks9Bmx6Uh8W1i8rnsa+vtK8J6zRo2VVcc8E4ga9cxggnn2o/OlIFIdxDWSqXcBqi0WiMiFLmVIahRoZ+JaSeSXRs9nhfPRJnZRPCrG5OKW2jm4e0275qywOHTmxZJVGz1GPdrSg1/yj/QG8NqbP4ABUozfus3jnShanAK8+420fXiODC5MoAHVKugHgz75qgLYyz7+zVW0+521NipWGbiX6nrl1RLfH1j5C846XCbl7vAar6ZMbcS/v9gL9Z/5TNqE2BSbirFntT1fkEbxCBu9dYdcpYOo6BsVPazShCWea1BSJfiFqTA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(41300700001)(66476007)(66946007)(66899024)(66556008)(54906003)(316002)(478600001)(6916009)(82960400001)(966005)(38100700002)(7416002)(86362001)(2906002)(5660300002)(4326008)(8936002)(26005)(53546011)(8676002)(6486002)(6512007)(83380400001)(6506007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L5yGedfPHhtOF71w5pDcoW7M6y7XfRgnkNBgrnLqksaWzUzId24WprS3EIXL?=
 =?us-ascii?Q?geaZCkXg18JQhBNqM+lPfNfROcO7CITRuZwLbsT3PvJbtgCPEq9mQHwt60rA?=
 =?us-ascii?Q?ksNxKt3CYRsdl8hXnWoeIQ9o0UDPQ1LySMKSqPT0dgePOJ5VZW//Qy1dy/4e?=
 =?us-ascii?Q?vp/AeHsO4WKBFbUEUjAfawA6DEUjcql5V4KSbOOtOcNOXFCFirrIu0vSI4LR?=
 =?us-ascii?Q?UgiWOhEmtZBCFbRVeUWn9q/jSYs+jPlL+bnkI+sZKmjN1ltL1b/rca0oRHZt?=
 =?us-ascii?Q?JaB+9wIm6K75wnpofu8+IF84IP9WfYMqC8jzDunyMvWh5jIKIPPDR7b2aUTu?=
 =?us-ascii?Q?PqzDnqo3dsYxnFqqxaQ1Aa4aM6ubKBNqP3fbZXBoOoMDf/9H6NopaMQGpuaq?=
 =?us-ascii?Q?/RwFAmdE6Ezco/lIBoeq8p+xvXLKqZeGmJLw4j0yfDFCxutMZllUgD69SxMO?=
 =?us-ascii?Q?LSEmv/r30tEL0reW6Fi2ung5ZR817bv7PYNIYAVhZ17pRE47lW+PAqM+n7Jw?=
 =?us-ascii?Q?5RYUaFu8KMioWyv9hzC3rhmlS3s8PuPl1wDZUSbHRsLSTvY9g2g3MnPT23Kv?=
 =?us-ascii?Q?GYelw9ucqk+ACHt2BfpH8ppwO9Uy0j67fE6HoVLEntRLNwWkdSmRXClrRpA2?=
 =?us-ascii?Q?iG5LMdkzGh8e5gGRqb9r0GiA0gCXBXpm/1cQzl5An7bsUSXRY7iCscqcdjid?=
 =?us-ascii?Q?CxwAcHJP0lcAVo/JusltT+pPng4+LBPe2/RfehT/cbHTnGUXDayc96EV2vti?=
 =?us-ascii?Q?hQjy3cZ5RcaX2iIXVKKIJG7ak8H12Kqd191xK2dFdjrkbiHl25JF/yfKin2c?=
 =?us-ascii?Q?fjK3vMPG1JOGa4osDhGO5boWGq07Ead/9SNQzhgLebbeTka2jo5wuKMWggO3?=
 =?us-ascii?Q?05yWc+D4b/hCjeJduct+SCjGSf1C+t0Rsb04qrdfqDkITCkXpo/yeSRTTeKp?=
 =?us-ascii?Q?z95IsxP6e8Y46726j68Qo9tv3NG7ab7Zq6CIKwNDzFL97DUuUog4bAAlbpy5?=
 =?us-ascii?Q?+ZRuCGGxVhNhtIR8zs1iKz9Guw1NplXkN9j4o05d+7mXtl4vvC0+x/pxLZ03?=
 =?us-ascii?Q?9b1ttnFM6b0VGj3u3SAnbzFM32nGXhZaz/Y/vmnidG4o4GPpHOfvKFUCu2yl?=
 =?us-ascii?Q?3FvZyq+DnPtvVbu7sFAPVETjY3/no63RkwTZxKD4ryydTaWZ1u84GI0mv+7p?=
 =?us-ascii?Q?O//H38lu9mpjnFyod5FTe9PPilMgThfaJhgnzCuelmm+3lR0Fb0IEQ59Ockl?=
 =?us-ascii?Q?tXCa2Flm08xMBaONEDwumxw6x7jKymEJjMMDbfoskMq/iifEG368KL6qXcO9?=
 =?us-ascii?Q?wnfUg7lk81OFDZjzh0xvL0+zVVfC3II9/3HO6n+RwNcnf9SCsFlkHMCVZUN1?=
 =?us-ascii?Q?oEajKo86jmIlCqpmYGDcBgc+3kbsGWlEW4nxAEM5BklNApC0PPRDECf5GBhc?=
 =?us-ascii?Q?B8STq2vEo2yplqnT7kKAa3eihwGZR95bczG+apH0DFdnCgW+6rjh/UhNL0E2?=
 =?us-ascii?Q?xStSq56bZ/MpR9nuShKeclYqDnzPDP1IvbQ7KWmks+PGWYci3A61FNOb1602?=
 =?us-ascii?Q?/vd3MkanAndHynwcn71kEqcupqY7LhtOY4tORvpz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c5c4fd-4098-4a9c-cf09-08dbb42a9cd2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 07:25:31.7789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOJvPdbi45Xk50lyt2KJWmQKCEPnSEQB3lBE1/Mh4AmH4T+b8PLBnQQZpYhBAR0P9VPmFPrS4p6aYeLdTVO6iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5189
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gautham,

thanks for the review,

On 2023-09-13 at 11:52:14 +0530, Gautham R. Shenoy wrote:
> On Mon, Sep 11, 2023 at 04:40:02PM +0800, Chen Yu wrote:
> > Hi Aaron,
> > 
> > thanks for the review,
> > 
> > On 2023-09-11 at 15:26:29 +0800, Aaron Lu wrote:
> 
> [..snip..]
> 
> > > > @@ -6982,8 +6997,13 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
> > > >  static inline int __select_idle_cpu(int cpu, struct task_struct *p)
> > > >  {
> > > >  	if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
> > > > -	    sched_cpu_cookie_match(cpu_rq(cpu), p))
> > > > +	    sched_cpu_cookie_match(cpu_rq(cpu), p)) {
> > > > +		if (sched_feat(SIS_CACHE) &&
> > > > +		    sched_clock_cpu(cpu) < cpu_rq(cpu)->cache_hot_timeout)
> > > > +			return -1;
> > > > +
> > > 
> > > Maybe introduce a new function that also considers rq->cache_hot_timeout,
> > > like available_idle_cpu_migrate() so that above and below logic can be
> > > simplified a bit?
> > > 
> > 
> > Yes, that would be simpler, I'll do in next version.
> > 
> > > I was thinking to simply add that rq->cache_hot_timeout check to
> > > available_idle_cpu() but then a long sleeping task could be forced to
> > > migrate if its prev_cpu happens to just deschedule a task that sets rq's
> > > cache_hot_timeout. I guess that's why you chose to only change the idle
> > > semantic in select_idle_cpu() but not in select_idle_sibling()?
> > >
> > 
> > Yes, sort of. And the reason I did not put this cache hot check in available_idle_cpu()
> > or idle_cpu() was mainly because these APIs are generic and could be invoked by select_idle_sibling().
> > If the task fall asleep and woken up quickly, its previous idle CPU will also be skipped,
> > thus no one could use this CPU within the cache hot period, including the cache-hot task
> > itself.
> 
> This happens even with this patch right? It is possible for a task p1
> whose avg sleep time is "t" to go to sleep which causes its CPU to go
> idle. When it wakes up after a time t' < t, the logic above skips the
> idle CPU because it is still cache-hot, despite the fact that it is
> cache hot for p1!
> 
Not sure if I understand correctly, in select_idle_sibling() p1's previous
CPU will be checked first, and that check does not involve cache-hot. So if
p1's previous CPU is idle, it will be picked, no?

        if (prev != target && cpus_share_cache(prev, target) &&
            (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
            asym_fits_cpu(task_util, util_min, util_max, prev))
                return prev;

Or do you mean, in select_idle_cpu(), we will re-check p1's previous
CPU but it is skipped due to cache-hot?

> Have you considered recording p1's identity in the
> rq->cache_hot_sleeper so that in select_task_rq_fair(), we can simply
> return the previous CPU if it is cache hot and the wakee is
> rq->cache_hot_sleeper, thus avoiding the whole select_idle_sibling
> scan.
> 

Yes this seems to be donable, and one problem would be, if there are
more than 2 dequeued tasks prefer the same (previous) CPU, which task
should be the rq->cache_hot_sleeper. And per Mathieu's feedback[1], we
want to deal with multiple dequeued tasks. If we record all of them,
it might be costly.

[1] https://lore.kernel.org/lkml/2a47ae82-b8cd-95db-9f48-82b3df0730f3@efficios.com/

thanks,
Chenyu
