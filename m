Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378227596CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjGSN3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjGSN3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:29:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E3DCD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689773371; x=1721309371;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XujwsP95GspwZHmo7lV3w/cwKqbJ+wMLrKYyflOAzrs=;
  b=X9p3yRgQcWW8Of7JhlsURdeeu5Kt8Vn9S5TGKeZC/5hipKDc1ZuGnEBq
   jDtW3BupQpOuBapcvvyMsvKkE3nSsRvv4v5123PCO5zrbsbi7F54fpXsz
   WgRfeWQB6Um314zOTsnvekz4tW9LV2J7DlwreWhtLQ7Pcy+eSt/Tuc8Xl
   CXH3NoVXjnp/dgvBsryJQhPHEN8IVBoiBiMVqBrIY4hF2eBnsBPF2K8aK
   lfzchCoDW2tkhiKXv11geHB3d39BZWemoh7OXJSTLb2yboxgH9MppfIuo
   9/JKmibMAVnZy9YzX+dzqwbWLNNXZ0ArXSIleK6SMfaeLhRf+py+bN2Ny
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="397322064"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="397322064"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 06:29:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="848054222"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="848054222"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 19 Jul 2023 06:29:30 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 06:29:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 19 Jul 2023 06:29:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 19 Jul 2023 06:29:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TugQwG7z9JLiQxDYgC83PjQsmN0vijyKlyE86im92q28NPuKu8ivrSvTHDpWX3bGBmUqGHUFV63H3+065q6wcLFiuOhkD42UDU44aSLw5V5tE7pbtyPPurevIwNlJQOmsismlYXTvVd+vvqZk5rMmE5vWL3OESCFmcQTM3CeOx07C3yEmWtixw71/Nlv7kIQOG6d17SSGKXR6E0zRiqfa7784c8aKJMJtUEwrFpQdPjdD+9CFzVnKQg23qmAWmNpWURXidtUkl0aLmS6LbN/BiB6eYlEpiX61Pz2QyRRML9pyODteYVdAErT1BvPGwQ+fU5zLwuRT+Wyb2WrltUtSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVyWHSVMXiRzagvCf7viK9KSxz8UiTJ5hpKEESIV+jI=;
 b=EKyAC8pB7L7pSWmO0DeRY0FzCmWmhRvydPR4ak9lgeoKAOVDZxAoF308ewgR7vaZrzMpe80zoOoM6wEavDmkHfgbiaGPxwFReEXs4XkzIYSQJH0GT32aZF0vd4auMCB9Ty1ImvqI6PMWtjr8H9YKQ1jjIBUYH1j/ttl+TgC2ldBtz9A69emImLbJ+LccvQlT7/jgg68/YBfxIAa9CJHqQIkbLtWesGJ5I/D7JVm2OzQPRw39YnLv7itrvA6bdmUOvz9+fUuTAr/AubSPJC0CQeqBV7zQr0PtJ3NbgT2Mnre25n+71x6qHNf9Dj/xs/HI/pZ/O1OLAK+H/01kdsdQEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3060.namprd11.prod.outlook.com (2603:10b6:208:72::24)
 by PH0PR11MB5143.namprd11.prod.outlook.com (2603:10b6:510:3f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 13:29:28 +0000
Received: from BL0PR11MB3060.namprd11.prod.outlook.com
 ([fe80::7196:1728:580c:9eec]) by BL0PR11MB3060.namprd11.prod.outlook.com
 ([fe80::7196:1728:580c:9eec%5]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 13:29:27 +0000
Date:   Wed, 19 Jul 2023 21:29:14 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/4] sched/fair: delay update_tg_load_avg() for
 cfs_rq's removed load
Message-ID: <20230719132914.GA91858@ziqianlu-dell>
References: <20230718134120.81199-1-aaron.lu@intel.com>
 <20230718134120.81199-4-aaron.lu@intel.com>
 <CAKfTPtAu33AN6=X82T=yOgm40S8OXi+sPcF0QyD-bYRPV=xPEg@mail.gmail.com>
 <20230719051826.GB84059@ziqianlu-dell>
 <20230719080105.GA90441@ziqianlu-dell>
 <CAKfTPtCnvOehfrz1OSW+rmkKW+28bdGw8fU+AvVrZTxkHibL_g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKfTPtCnvOehfrz1OSW+rmkKW+28bdGw8fU+AvVrZTxkHibL_g@mail.gmail.com>
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To BL0PR11MB3060.namprd11.prod.outlook.com
 (2603:10b6:208:72::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3060:EE_|PH0PR11MB5143:EE_
X-MS-Office365-Filtering-Correlation-Id: fd7194f4-6395-40fd-be5f-08db885c2cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMWoqUdnF4fycgJ2JgBFDp7f75Gw/+Hh9z5I9iqb19IDtSDWOY8gSzDVr3ZD0Jeuw76F+MULTwDcBJARCI2+22tkgUg4y5It+SiLVsSO1z3CLmvCnKwmeuI5Lf5Bg4Hshj9dPNUW+5YcF4M6EAfd27GjE3/IuZhKp6GVVjUHCS85N821mQGCLUwcXI8UWQEKqzkBCjq8ikjhvvf7Dr8El+IDZ5gVbBNoF9KDU2RHowVrcg2QviX0Vmr2XbqWu+B9adlDB131uhLucpIKWN6sh8NBGFXIYUdwa0mQqCJlHAKRUvKINrFgj5Naj0p8b/KmKNxjBIZwxOXo9NOPV/RHV1PLjl81tBQjVygtWS/bpWtH6zp2QpmI68Fq8JDV2cwSLHR93Gj+CKd9T1dZdsJHcKs4TCrCeSZHyA7XYd7ZPTc4j+Z1kXUha9CnV6g0no7w7IF6ApnFCMGmHtwG3fkeS8O8XR3QzhHaFXGDD6FYp5dMwws4qALuPsq9YjHIUvOGksvEFPAkgzb6DAvoNfL6Hh5uqo4sJYnu77uDVDK0KQWOd7hmVc0shH73vk+0N+WS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3060.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199021)(6916009)(33716001)(66946007)(4326008)(316002)(86362001)(38100700002)(9686003)(82960400001)(6512007)(6666004)(478600001)(54906003)(8936002)(44832011)(41300700001)(66556008)(7416002)(8676002)(66476007)(5660300002)(1076003)(53546011)(26005)(6506007)(186003)(33656002)(2906002)(83380400001)(6486002)(15650500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sjVO/ioq0wwsmvAtKnaEDFs9SKg8Q2d5Gw75eqJIhdAgqmkoeZJTeZhhco+/?=
 =?us-ascii?Q?cg3YUyvi8nwWAk0E0IMOJydHIr5DND2KjAExHMRWftrufcoveGyf5v0MIr1U?=
 =?us-ascii?Q?KAP1KMAk4vudLabUhjZTUTkD5Zr/Q2y+meGxUxTHDhGnauKdjObncbrjUq21?=
 =?us-ascii?Q?jsYqpq4bMVqrkPdH/xYxampXB6eDShOof01fwBqj6wzbPdxbvzcw4TkwfVpf?=
 =?us-ascii?Q?wuvO3OUTdERw8zpsUDaCULYnx3la/RSdr9Cf+fP3tMFktnOUePhy2CkkGIyc?=
 =?us-ascii?Q?vHg1L7X5EzAfjtqBfOldseUj/BE0QXT6Ax6yIXrjSPv8dXu05BSQiXBcRucx?=
 =?us-ascii?Q?5JeByZgGHDWUB0mWc1EcxTFR39WDJN135GQ09b2bzZQFJQQ6m7YHGb+vgN9c?=
 =?us-ascii?Q?X8fjyiRRs1Ur+Vz67m3MtcVZjtwiLdkH2TH1R8WxqoJnTeIVLFAGax4XNvqa?=
 =?us-ascii?Q?BX1UJvple8EhMxC1VKIU24VqvQ1wBi+MpvT7LstxOaImcTOCpu5gD1G7/eYx?=
 =?us-ascii?Q?YEoSlBj+4bTemRA7eSd8ySrVc/Cw7Ui02s4PdLeQvMC9F5ojR+Cw+UjC1ArV?=
 =?us-ascii?Q?cmJY49T8FoTQjSml+2TzAXyZBcueKPWUSjrfOHY+VqaMv/OEQ5P+ETqmuCR+?=
 =?us-ascii?Q?pekh/xi+jtxyMFrdkVTmVsraNqZZ+0eHkdI4YxEXX7f5HbN53fHrMKz3mahk?=
 =?us-ascii?Q?lnLTzJpteHhAPxbP0dDuUfTF/t3LGIzsVX3uoowz5VjYNyKWkChBD+dN8Xds?=
 =?us-ascii?Q?R2FUL70SCW8HnTmYckmJZxFxSf0cj5IsQ8tczSFDjHNom4S1z2fnxi5IKjC6?=
 =?us-ascii?Q?GbDMbbiuCY2X+tiyUG7ZU4kHy9G/9gEepW9Z+51PA2qULibaiFumkNp8ULef?=
 =?us-ascii?Q?F+sE7J2iiCrNbYnb4KHTv77pBWWD6gMkGEXqJFMPmmcHQpiLkIgz5DF4TEKS?=
 =?us-ascii?Q?CskVAdsHsTcXIdnF+pBKWSHfaQytt/BVqrFqNxcZu7HjZWpxGgXDlKIHflrQ?=
 =?us-ascii?Q?MeJbt9VKq0HFT1wNVwlS5xpRqbVBnJDcbaOZal//97ZtMOFGokfc27zrKvvF?=
 =?us-ascii?Q?adB3w5XM0AOdH1LY0ZR9pEdvoh2iWTM1T4TfAGs07T11nl+tA3Zw3mAl8Lds?=
 =?us-ascii?Q?LUJ9Fw/RYOzMKSdENZrIiAcifXdaurzZGakZl+IqlWbZqu1VaO4yHXYcbXLY?=
 =?us-ascii?Q?mAHWKWpy+zCneKAocDeh/q54dMgrvZ+vfFLUZnvbBKJ4pE+TSvwJIt3fAZCJ?=
 =?us-ascii?Q?D36qhcr0r8+ywAaS6eG9bo8dFLvSw1rgx414uiIsaUqZ3KeJWewIbhxZ52Ea?=
 =?us-ascii?Q?dF9i+Ds6lYSN2Aq9YccgXUkcdFE+d0T/FsayGQF1oAirHXywxSoeeGQetIXJ?=
 =?us-ascii?Q?IpCpe+YkqG12iWDIM7acorPYVVlKtjbd1tLxvzSUvzQSSABa3lYyt5K7greY?=
 =?us-ascii?Q?yjrTw8j9ZkcuPtZN7h+LkLM+Nyz0i+hueq0m2iqEsZ+XX3CYS/kovHFRLNik?=
 =?us-ascii?Q?8kvF2bwb2vfX7qXbRVOvnlUW/euIIpozcBwVRhWBtkRyi3M/7D0QyjI1hPFr?=
 =?us-ascii?Q?8/HKu+Od2rYG4Djw1M0VaBJuo+8LCptvQHIidH2D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7194f4-6395-40fd-be5f-08db885c2cd9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3060.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 13:29:27.8155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tKnqH79/fofWlheTO59me2q3FNilaYD9LRubHmx6WWAFQ4QLIjj8Q/HtMPYG/xLqZtgx4I4i6KjfdVKg2hLiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5143
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 11:47:06AM +0200, Vincent Guittot wrote:
> On Wed, 19 Jul 2023 at 10:01, Aaron Lu <aaron.lu@intel.com> wrote:
> >
> > On Wed, Jul 19, 2023 at 01:18:26PM +0800, Aaron Lu wrote:
> > > Alternatively, I can remove some callsites of update_tg_load_avg() like
> > > you suggested below and only call update_tg_load_avg() when cfs_rq is
> > > decayed(really just decayed, not when it detected it has removed load
> > > pending or load propagated from its children). This way it would give us
> > > similar result as above(roughly once per ms).
> >
> > Something like this: (I think this is better since it removed those
> > unnecessary calls to update_tg_load_avg(), although it is inline but
> > still)
> >
> >
> > From bc749aaefa6bed36aa946921a4006b3dddb69b77 Mon Sep 17 00:00:00 2001
> > From: Aaron Lu <aaron.lu@intel.com>
> > Date: Wed, 19 Jul 2023 13:54:48 +0800
> > Subject: [PATCH] sched/fair: only update_tg_load_avg() when cfs_rq decayed
> >
> > ---
> >  kernel/sched/fair.c | 22 +++++++---------------
> >  1 file changed, 7 insertions(+), 15 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index a80a73909dc2..7d5b7352b8b5 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3913,16 +3913,16 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
> >  }
> >
> >  /* Update task and its cfs_rq load average */
> > -static inline int propagate_entity_load_avg(struct sched_entity *se)
> > +static inline void propagate_entity_load_avg(struct sched_entity *se)
> >  {
> >         struct cfs_rq *cfs_rq, *gcfs_rq;
> >
> >         if (entity_is_task(se))
> > -               return 0;
> > +               return;
> >
> >         gcfs_rq = group_cfs_rq(se);
> >         if (!gcfs_rq->propagate)
> > -               return 0;
> > +               return;
> >
> >         gcfs_rq->propagate = 0;
> >
> > @@ -3936,8 +3936,6 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
> >
> >         trace_pelt_cfs_tp(cfs_rq);
> >         trace_pelt_se_tp(se);
> > -
> > -       return 1;
> >  }
> >
> >  /*
> > @@ -3974,9 +3972,8 @@ static inline bool skip_blocked_update(struct sched_entity *se)
> >
> >  static inline void update_tg_load_avg(struct cfs_rq *cfs_rq) {}
> >
> > -static inline int propagate_entity_load_avg(struct sched_entity *se)
> > +static inline void propagate_entity_load_avg(struct sched_entity *se)
> >  {
> > -       return 0;
> >  }
> >
> >  static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum) {}
> > @@ -4086,7 +4083,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
> >  {
> >         unsigned long removed_load = 0, removed_util = 0, removed_runnable = 0;
> >         struct sched_avg *sa = &cfs_rq->avg;
> > -       int decayed = 0;
> > +       int decayed;
> >
> >         if (cfs_rq->removed.nr) {
> >                 unsigned long r;
> > @@ -4134,11 +4131,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
> >                  */
> >                 add_tg_cfs_propagate(cfs_rq,
> >                         -(long)(removed_runnable * divider) >> SCHED_CAPACITY_SHIFT);
> > -
> > -               decayed = 1;
> >         }
> >
> > -       decayed |= __update_load_avg_cfs_rq(now, cfs_rq);
> > +       decayed = __update_load_avg_cfs_rq(now, cfs_rq);
> >         u64_u32_store_copy(sa->last_update_time,
> >                            cfs_rq->last_update_time_copy,
> >                            sa->last_update_time);
> > @@ -4252,7 +4247,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >                 __update_load_avg_se(now, cfs_rq, se);
> >
> >         decayed  = update_cfs_rq_load_avg(now, cfs_rq);
> > -       decayed |= propagate_entity_load_avg(se);
> > +       propagate_entity_load_avg(se);
> 
> but then you  also skip the call to cfs_rq_util_change()

Ah right, I missed that, thanks for catching this.

Updated:

From 09a649f8111cfca656b7b735da975ef607b00956 Mon Sep 17 00:00:00 2001
From: Aaron Lu <aaron.lu@intel.com>
Date: Wed, 19 Jul 2023 13:54:48 +0800
Subject: [PATCH] sched/fair: only update_tg_load_avg() when cfs_rq decayed

---
 kernel/sched/fair.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a80a73909dc2..8d4b9e0a19b6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4086,7 +4086,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 {
 	unsigned long removed_load = 0, removed_util = 0, removed_runnable = 0;
 	struct sched_avg *sa = &cfs_rq->avg;
-	int decayed = 0;
+	int decayed;
 
 	if (cfs_rq->removed.nr) {
 		unsigned long r;
@@ -4134,11 +4134,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 		 */
 		add_tg_cfs_propagate(cfs_rq,
 			-(long)(removed_runnable * divider) >> SCHED_CAPACITY_SHIFT);
-
-		decayed = 1;
 	}
 
-	decayed |= __update_load_avg_cfs_rq(now, cfs_rq);
+	decayed = __update_load_avg_cfs_rq(now, cfs_rq);
 	u64_u32_store_copy(sa->last_update_time,
 			   cfs_rq->last_update_time_copy,
 			   sa->last_update_time);
@@ -4242,7 +4240,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	u64 now = cfs_rq_clock_pelt(cfs_rq);
-	int decayed;
+	int decayed, propagated;
 
 	/*
 	 * Track task load average for carrying it to new CPU after migrated, and
@@ -4252,7 +4250,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		__update_load_avg_se(now, cfs_rq, se);
 
 	decayed  = update_cfs_rq_load_avg(now, cfs_rq);
-	decayed |= propagate_entity_load_avg(se);
+	propagated = propagate_entity_load_avg(se);
 
 	if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
 
@@ -4264,19 +4262,16 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		 * IOW we're enqueueing a task on a new CPU.
 		 */
 		attach_entity_load_avg(cfs_rq, se);
-		update_tg_load_avg(cfs_rq);
-
 	} else if (flags & DO_DETACH) {
 		/*
 		 * DO_DETACH means we're here from dequeue_entity()
 		 * and we are migrating task out of the CPU.
 		 */
 		detach_entity_load_avg(cfs_rq, se);
-		update_tg_load_avg(cfs_rq);
-	} else if (decayed) {
+	} else if (decayed || propagated) {
 		cfs_rq_util_change(cfs_rq, 0);
 
-		if (flags & UPDATE_TG)
+		if (decayed && (flags & UPDATE_TG))
 			update_tg_load_avg(cfs_rq);
 	}
 }
-- 
2.41.0


> >
> >         if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
> >
> > @@ -4264,15 +4259,12 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >                  * IOW we're enqueueing a task on a new CPU.
> >                  */
> >                 attach_entity_load_avg(cfs_rq, se);
> > -               update_tg_load_avg(cfs_rq);
> > -
> >         } else if (flags & DO_DETACH) {
> >                 /*
> >                  * DO_DETACH means we're here from dequeue_entity()
> >                  * and we are migrating task out of the CPU.
> >                  */
> >                 detach_entity_load_avg(cfs_rq, se);
> > -               update_tg_load_avg(cfs_rq);
> >         } else if (decayed) {
> >                 cfs_rq_util_change(cfs_rq, 0);
> >
> > --
> > 2.41.0
> >
