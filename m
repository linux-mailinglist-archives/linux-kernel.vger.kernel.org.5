Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5957789B0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbjHKJ23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbjHKJ22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:28:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A8826B2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691746107; x=1723282107;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=VM+oMhZA3L6GNzEa4hv5xGz4SO6aN04Nurf1O+AfVsE=;
  b=aJKUUob1dJoli00O7i4ra/713GCE6FhWZtquJm5kc8cVH1VLucrBcoL5
   7SPiXD2q5E4zaxGtA/O7udXCvarxZWLK2f/95s6sA5msEB+ZHwG/Ydb3O
   TlUxAbEEsWvfDY/hnb0zFB55n4kQJO+2way8BTDBjKL6qDw2OTSb3J5TS
   n4/HBlGYyRyMeuRRzYtQbK+PR0hZG6IYVPIsDOi1OghkhUG5Eb37dhIna
   6dxt7UgPAxb+F72F5NA/c/nOyF6h9zfFz0uUw3ihHDitFjh6ZgjHfjtd2
   9GP0OjNVULd9jy1IUq3ZQIaM8SrXk7b3p7fCMhsJAxKjvnQQJIhbEhD77
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="369108968"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="369108968"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 02:28:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="802604027"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="802604027"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2023 02:28:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 02:28:25 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 02:28:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 02:28:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 02:28:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjKTvzcLFNuI/pYzWJzXCu2ktKGKSPfww2RqDOknut1gpsRjAuYM8qffA63/XUA0FB9CPUaxzavD/KSHUrAQyBx/87/L3O076VSlGYx9uFjMTXZDlqHJneAIu85K1mk8gpbF1dQclcG1cYYhuvwnMmGAcyVeszeuWzxAxG/dzrYNlT88QWxhY8JvKKzC5ZqCdC59dGHi9SE3LCRmlKOkjFDosTQuPcJTzL4L+LsbEE6Xzc7b50hbW74KBo11yXeycgZaUE2J62sWcX14Q10guldre+DUg7A0A/nrnBUKwBk0/6RdOu9rUPvKm2YZoOluvD8fr0J2s2vKrYf4qNbU7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43xm+x0lqABF7kcgEnM0UOB+GCnck+AD1Hr3STlIC34=;
 b=dvpdnifxiWuzyzAFnh4+L3wPOedRpIQ8AlMK2GlIB11XchKCFhTiV8tm5mVgNxCZ0Yw5oWMWs2YF1ltnBI8O/sambNmoyJS4GHDXpZJ7X7QcU3Ufxy1REQ+79hUZxZeHaN/PAeIGEsZv0ipRgh35DsTXyU1IXWs3YSlaEcpfKp/0CsBpsCVf7W06Gzp1FCXQs0aWuFdSphWy4fOPJiCkcXWY/9sdO38HtWAQKw1KH9g2PfC531suv7rJYD0y2WQ00UYdRcJpR/Tr+Gf8VZ9Z8KgPPrpnnr24bjrx2LiuPkAtxQ25xWd3NcyQKiiDyulKV8r9qe8x10stAyXg6LzIwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by MN6PR11MB8196.namprd11.prod.outlook.com (2603:10b6:208:47b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 09:28:23 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::a551:9922:da09:ba24]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::a551:9922:da09:ba24%3]) with mapi id 15.20.6652.026; Fri, 11 Aug 2023
 09:28:23 +0000
Date:   Fri, 11 Aug 2023 17:28:11 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
CC:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/4] sched/fair: delay update_tg_load_avg() for
 cfs_rq's removed load
Message-ID: <20230811092811.GA399195@ziqianlu-dell>
References: <20230718134120.81199-4-aaron.lu@intel.com>
 <CAKfTPtAu33AN6=X82T=yOgm40S8OXi+sPcF0QyD-bYRPV=xPEg@mail.gmail.com>
 <20230719051826.GB84059@ziqianlu-dell>
 <20230719080105.GA90441@ziqianlu-dell>
 <CAKfTPtCnvOehfrz1OSW+rmkKW+28bdGw8fU+AvVrZTxkHibL_g@mail.gmail.com>
 <20230719132914.GA91858@ziqianlu-dell>
 <CAKfTPtAqpAo8Y9BdWZ-fmnyYgA8PEtFbObqWJxc-hs2Ktqkt3Q@mail.gmail.com>
 <20230720144233.GA185317@ziqianlu-dell>
 <CAKfTPtANqtEQjv2UThb5s0TPCS2adhC_14Gfv5ayAOva9Mib8g@mail.gmail.com>
 <20230721015704.GA212678@ziqianlu-dell>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230721015704.GA212678@ziqianlu-dell>
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|MN6PR11MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: 7230e7c3-a70a-437a-ac19-08db9a4d4ebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g5ybPs71zwlISKqNLhGirRkMGZHNLHX+DlgqljFkj9Lo07y6ZQrxmU2h+tXGTKoDssA/+yO3Tjq0vEyqHAK8B0EJ/IxC4dx90fTUo81/F7a9YdY2B4CDVLOdadQCxivQDOSZFSEW1FglcRSSLYYIK7vVPrAPrmv7nILeQSuT3l4dsEbvN33x2UBWBYV/0LS3A1jwyiiHNXaBTqoU44jFwAOYDAKDlAlu82ke37tIoEcu5wVshkeT4/jLqQ8mswMlewgeo6sitjagfWmYwy3LPFJWMc5TaJfqNmkZrH5ZQmu5Q5EsDQH8643NKRI8s93l6NbV28JPs/o5qaXPPY+Nloue/4NTFeRHa6HjUdf8zhm1nKD73VDgbSs7ec9zvc8QVODrCQuT3noYIr/LWwug8PIh80U5BHIyZo+xjpfsTKag86DvJ2yCRs2JXhICrc56ih+JJmoJphdulm5WwMf8ChDd2x7Mbcuay6chNNrUPhNY5ONqBXx56CK6UrQ57HlGevJpY/c5PaWuOEutQyAx0+mZf0P+AOrvBCDJyOVQT8q+f1e84EV+C58F5cX6/yiW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(136003)(39860400002)(346002)(366004)(396003)(1800799006)(451199021)(186006)(5660300002)(8676002)(8936002)(6506007)(26005)(1076003)(41300700001)(33656002)(2906002)(83380400001)(82960400001)(15650500001)(38100700002)(33716001)(86362001)(44832011)(7416002)(66476007)(66946007)(66556008)(9686003)(6512007)(4326008)(54906003)(110136005)(6486002)(478600001)(6666004)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?qzX9744fftNG72U0qleF2G69uyz3pL+RmwRF8HDiJy4Fx/AbGDCzgK1k13?=
 =?iso-8859-1?Q?R0ImGUG6ttdG7PlQ7r5ykE7gnPB0vgMOCxvoeUhVGjTw/FIaq8c3a2VOpy?=
 =?iso-8859-1?Q?P2wmrxL6YI9zcnilymKbOduqlcARaktLJHs3AeNXgmWK5T94ltoxuTCsHn?=
 =?iso-8859-1?Q?wWjegNkaatrMrc2qtLwGXAN8FIR291LRRA2BJJ8pkZO5oinWtO2i+JYCsu?=
 =?iso-8859-1?Q?zUrVwigRbYOdtHXrF8YA6fNR1GWsRnsE5NXgq9y4mtN5zy1WGBoNhK6QOl?=
 =?iso-8859-1?Q?oyEBdxCvJE7FfLqW7qETGuknhXAnyXEJh627CueDXVch2gr0Ewzp5ViPnN?=
 =?iso-8859-1?Q?naQcvbN/DcuW+SeC6NujOrgkuMS1DUr9XIjRZFejYZ951d57QInuW/QNrg?=
 =?iso-8859-1?Q?s8k780i1isi0qqpOVmrAwCx8kWaJgtueHrr6WgJwBvb93SfSgGhluM3hxE?=
 =?iso-8859-1?Q?IQLDcifShLfD23spIzEvjZogZeJq4dc1sT/vzEIp/G4H9nw+XEpKobZcBC?=
 =?iso-8859-1?Q?cio6Htn5iWpPPunQWc/xI8WGeTeh0MwFWyyBVdPsnaXynjV+ck8e5nqjtY?=
 =?iso-8859-1?Q?GbPlGYFWE+EdmEBJ0svzNEXxyOManCcN31UeAy0aWDQArRvuJ/oAJ9KsQd?=
 =?iso-8859-1?Q?W/fYmrq63wMgl0rFghFnPkmvoyw2W+tlVxGy9SxEH0uvYm6u/4nggb8wKE?=
 =?iso-8859-1?Q?LEwPYFjD0NoRYxac3G5vZSHRj56PJFMp8ZCYAFeyr9z8jINwpyrL7NM2pZ?=
 =?iso-8859-1?Q?5jUpE1YUULeTQaK7Ri9gnQ76CFUUtypuRkyYHMDElvn6yVjF3ROeAhu2gy?=
 =?iso-8859-1?Q?EjbzSaqmwgZrabjQFsaw1zJkxhzQ/2QnxqZ6DHrHr1uI7lJizkvg0nnfas?=
 =?iso-8859-1?Q?DO+9S+UQVAc4Tif35v1RoKxNigUhpRUFvO8MFue6TmNBrBnFLWCcdEq3TO?=
 =?iso-8859-1?Q?sEf+n2xeT1TTzThjxbM+G0+u0Q0ZcRj257RS5HmUVh2utshCUj9ZNs+NXB?=
 =?iso-8859-1?Q?Aj1LYPKX7W3qUvlKlcE/3g6lf+36JHbY8nlzEFjSSB0q3V7rh6tZlCVvJg?=
 =?iso-8859-1?Q?rnfeFIPtpyHSkpOtHDSUGm9WMyXzxO2/U5Y58DDjjx4+D/kUIaiyAH/CJx?=
 =?iso-8859-1?Q?jzJImfj2DJnxYylRyZtICdnck/ViiFMghEqR3GPZ3Yx+njXKBMaxY2LjUC?=
 =?iso-8859-1?Q?qYMIeuyfVo/PhiQi8VdQ9jM85fvh3bEA+cGMidaaQ4NtxdgJPI2fDQujtc?=
 =?iso-8859-1?Q?Ko5ACJBMUYgBN6DdED0/7Wb0iXiVG41c6fyipSLGmZSCM3sl+QQiSa+l/v?=
 =?iso-8859-1?Q?cEAyDmBkq0+UPkTyD7nWlwHU/Ni6jtvyullvOFEZmUXm/CtG8Mrf/x2GV+?=
 =?iso-8859-1?Q?ItpaXHtIS29OlFfcQhswXdrNLTpez183KCcn7ZC1QgdiQF6YOjCahUtE0F?=
 =?iso-8859-1?Q?l9h4URSeM/xJzfIWJjm6/WBAKpDvjTxGHBarSfdjCHVKKL2mfjAi8MH6sP?=
 =?iso-8859-1?Q?TD678J4rs+NH8yVEDJXBObVF+kzAbtcc9anAT5BqSfAWZH2rgRz8UKVxTu?=
 =?iso-8859-1?Q?cb2oA2IRaMMM4ShW2IQBJjYp0wyDR5+KxuSIgvgHV4/2Lrt0gWcr+OwjSQ?=
 =?iso-8859-1?Q?teQxxDmqBFgRQBTLrY2c7VykqUogHiJKdv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7230e7c3-a70a-437a-ac19-08db9a4d4ebc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 09:28:22.9657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5yACeZTZsl+gU0gfIeuw75rRz0/iqbPaFoH4AxvCA6DeWTWguV1+/LBQd5uugqOjLzRLA5W8mLCUzKDypAvjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8196
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 09:57:04AM +0800, Aaron Lu wrote:
> On Thu, Jul 20, 2023 at 05:02:32PM +0200, Vincent Guittot wrote:
> >
> > What was wrong with your proposal to limit the update inside
> > update_tg_load_avg()  ? except maybe s/1000000/NSEC_PER_MSEC/ and
> > computing delta after testing the time since last update
> 
> I was thinking it might be better to align the update_tg_load_avg() with
> cfs_rq's decay point but that's just my feeling.
> 
> Absolutely nothing wrong with the below approach, it's straightforward
> and effective. I'll fix the use of cfs_rq_clock_pelt() and collect
> some data and then send out v2.
> 
> Thank you Vincent for all your comments, they're very useful to me.
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index a80a73909dc2..e48fd0e6982d 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3665,6 +3665,7 @@ static inline bool cfs_rq_is_decayed(struct
> > cfs_rq *cfs_rq)
> >  static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
> >  {
> >         long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> > +       u64 now = cfs_rq_clock_pelt(cfs_rq);
> > 
> >         /*
> >          * No need to update load_avg for root_task_group as it is not used.
> > @@ -3672,9 +3673,11 @@ static inline void update_tg_load_avg(struct
> > cfs_rq *cfs_rq)
> >         if (cfs_rq->tg == &root_task_group)
> >                 return;
> > 
> > -       if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
> > +       if ((now - cfs_rq->last_update_tg_load_avg > 1000000) &&
> > +           abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
> >                 atomic_long_add(delta, &cfs_rq->tg->load_avg);
> >                 cfs_rq->tg_load_avg_contrib = cfs_rq->avg.load_avg;
> > +               cfs_rq->last_update_tg_load_avg = now;
> >         }
> >  }

While collecting data for v2, I find that with this "rate limit updates
to tg->load_avg to at most once per ms", the other two optimizations:
"skip some update_cfs_group() on en/dequeue_entity()" and "Make
tg->load_avg per node" doesn't matter anymore, i.e. as long as
"ratelimit" patch is there, adding those two other optimizations doesn't
improve performance further.

I think this is reasonable, since this "ratelimit" patch reduced updates
to tg->load_avg so much like from some 10 millions during a 5s window to
~25k, the overhead of accessing tg->load_avg is dropped greatly and
improving it by reducing the read side calls and making the counter
per-node doesn't matter anymore.

So I think for v2, I'll go with this "ratelimit" patch alone, but let me
know if you think otherwise.

The tests I've run are listed below.
1 postgres_sysbench with nr_thread=25%/50%/75%/100% on a 2 sockets, 112
cores, 224 threads Intel Sapphire Rapids(SPR);
2 hackbench with group=1/4/8/16, pipe, thread mode on a 2 sockets, 64
cores, 128 threads Intel Skylake(ICL) and another 2 sockets, 112 cores,
224 threads Intel SPR;
3 netperf with tcp_stream and udp_rr modes. For each mode, nr_client is
set to 25%/50%/75%/100%. Tested on the same ICL and SPR as in 2).

The test summary is:

postgres_sysbench on SPR
- when nr_thread=25% and 50%, results are in noise range;
- when nr_thread=75% and 100%, "ratelimit" patch can improve transaction
  by 12.2% and 21.2%.

hackbench:
- when nr_group=1 and 4, results are in noise range for both ICL and SPR;
- when nr_group=8 and 16, "ratelimit" patch can improve throughput by
  6.6% and 22.4% on ICL. For SPR, the improvement is 12.5% and 48.8%.

netperf:
- for tcp_stream mode test, all test results are in noise range for ICL
  and SPR;
- for udp_rr mode test, when nr_client=25% and 50% of nr_cpu, test results
  are in noise range; when nr_client=75% and 100% of nr_cpu, on ICL,
  "ratelimit" patch can improve throughput by 38.5% and 13.4%; on SPR,
  the improvement is 162% and 189%.

Full test results are listed below.

base: peterz's sched/core branch with commit e8d5ff8258bf7("sched/fair: 
Block nohz tick_stop when cfs bandwidth in use") as head.
rate: the patch that rate limit updates to tg->load_avg to at most once
per ms; applied on top of "base".
skip: the patch "sched/fair: skip some update_cfs_group() on
en/dequeue_entity()" as in this v1 series; applied on top of "rate".
node: the patch "sched/fair: Make tg->load_avg per node" as in this v1
series + peterz's numa optimizations; applied on top of "skip".

All improvement percents are against "base".

postgres_sysbench on SPR:

25%  (all in noise range)
base:   42382±19.8%
rate:   50174±9.5%
skip:   46311±12.0%
node:   48690±13.9%

50%  (all in noise range)
base:   67626±1.3%
rate:   67365±3.1%
skip:   68218±4.9%
node:   66878±3.3%

75%
base:  100216±1.2%
rate:  112470±0.1% +12.2%
skip:  113345±0.3% +13.1%
node:  112962±0.1% +12.7%

100%
base:   93671±0.4%
rate:  113563±0.2% +21.2%
skip:  113741±0.2% +21.4%
node:  112793±0.2% +20.4%

hackbench on ICL:
group=1 (all in noise range)
base:   114912±5.2%
rate:   117857±2.5%
skip:   118501±4.3%
node:   119240±7.0%

group=4 (all in noise range)
base:   359902±1.6%
rate:   361685±2.7%
skip:   356354±1.6%
node:   358744±1.7%

group=8
base:   461070±0.8%
rate:   491713±0.3% +6.6%
skip:   490183±1.4% +6.3%
node:   490864±0.5% +6.5%

group=16
base:   309032±5.0%
rate:   378337±1.3% +22.4%
skip:   385637±1.4% +24.8%
node:   375087±0.9% +21.4%

hackbench on SPR:
group=1 (all in noise range)
base:   100768±2.9%
rate:   103134±2.9%
skip:    99642±1.7%
node:   104251±2.5%

group=4 (all in noise range)
base:   413830±12.5%
rate:   378660±16.6%
skip:   367234±13.1%
node:   372122±14.4%

group=8
base:   436124±0.6%
rate:   490787±3.2% +12.5%
skip:   493097±1.0% +13.0%
node:   497336±1.8% +14.0%

group=16
base:   457730±3.2%
rate:   680452±1.3% +48.8%
skip:   679271±0.9% +48.4%
node:   672365±0.5% +46.9%

netperf/udp_rr on ICL
25%
base:   114413±0.1%
rate:   115111±0.0%  +0.6%
skip:   115546±0.2%  +1.0%
node:   115214±0.3%  +0.7%

50%  (all in noise range)
base:   86803±0.5%
rate:   86611±0.0%
skip:   86986±0.5%
node:   87466±0.8%

75%
base:   35959±5.3%
rate:   49801±0.6% +38.5%
skip:   50745±1.5% +41.1%
node:   50457±1.5% +40.3%

100%
base:   61951±6.4%
rate:   70224±0.8% +13.4%
skip:   67321±4.3%  +8.7%
node:   70591±2.3% +13.9%

netperf/udp_rr on SPR
25%  (all in noise range)
base:   104954±1.3%
rate:   107312±2.8%
skip:   107688±1.7%
node:   106024±1.8%

50%  (all in noise range)
base:   55394±4.6%
rate:   54940±7.4%
skip:   57829±1.8%
node:   57144±6.4%

75%
base:   13779±3.1%
rate:   36105±1.1% +162%
skip:   35319±6.3% +156%
node:   36764±3.5% +167%

100%
base:   9703±3.7%
rate:  28011±0.2% +189%
skip:  27087±1.3% +179%
node:  27337±2.2% +182%

netperf/tcp_stream on ICL
25%  (all in noise range)
base:   43092±0.1%
rate:   42891±0.5%
skip:   43208±0.4%
node:   43044±0.6%

50%  (all in noise range)
base:   19278±14.9%
rate:   22369±7.2%
skip:   19375±16.0%
node:   21312±8.2%

75%  (all in noise range)
base:   16822±3.0%
rate:   17086±2.3%
skip:   17571±1.8%
node:   16801±2.4%

100%  (all in noise range)
base:   18216±0.6%
rate:   18078±2.9%
skip:   18040±1.0%
node:   18064±1.6%

netperf/tcp_stream on SPR
25%  (all in noise range)
base:   34491±0.3%
rate:   34886±0.5%
skip:   34894±0.9%
node:   34692±0.6%

50%  (all in noise range)
base:   19278±14.9%
rate:   22369±7.2%
skip:   19375±16.0%
node:   21312±8.2%

75%  (all in noise range)
base:   16822±3.0%
rate:   17086±2.3%
skip:   17571±1.8%
node:   16801±2.4%

100%  (all in noise range)
base:   18216±0.6%
rate:   18078±2.9%
skip:   18040±0.1%
node:   18064±1.6%

Thanks,
Aaron
