Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74BB75B16E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjGTOmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjGTOmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:42:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00294C6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689864170; x=1721400170;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nDt67ebTeT/+X0nqhMinJXi/H+9xq74/T7u9ginGR74=;
  b=Muq5D2uN03V2x7io4rfZ3+gM1/SDoEtiK5Z+qYlgBSA0YCW7zj9Dml8u
   q5SQEJYnZx3dft79GHCmRbW3OajaJM22TKaHcdTRh3TLNU/mgsbc/ZpGZ
   mDOaoSZ7ZBDP8QqKbIG2JefEUmDHLWcaBHz5U+5gATXeFbKDX0YeTOD1L
   hnVXHvUnJMvpuuN1JntQnPec8yV4hVVko6eY8/eRrOmMEyC4T2VLQC2ZP
   qBSTeWybspGLpWnikSZZn+/wc+i4TI2edaAJqvn7eNUvKea0IaKLMCo5v
   ssUK4gcQcPgBqpFopRmpGdrpj3no7rRO5kswTng5DT8OcaZLn+J3Y5HXo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="346348037"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="346348037"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 07:42:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="724410578"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="724410578"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 20 Jul 2023 07:42:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 07:42:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 07:42:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 07:42:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 07:42:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQBPXbEqY/d85uT2euipL5nnV/qJNX/ES0iCx6+cshyy0wVtTovH+ew7t2BSteNIwP8Q66kn9le1Er9NI6t8eioakJgOIJZbHSiF0Rzt4Yh1S9RaQOmeSwWJU1OdojeXDP9FsOpG9RW+ZPSnDP+z0zeH6ZGh+5x7lQMjEBkivYpoWa7U0Uwm0cdju59RM362lkxZ76UD4JHuhAaVd+72mAghusWQlOnZq7kDVbP0/WbWeNUjfvJj6Tfkzb/q0bs3/AxiTx9Mzj/Dja1kOxIvSlAAntEtKDUwN/OFn4yrAk8SsPq8yEHT6MRGHaWu0S0d9vkGe4SDMpMQktfVtFK77A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCTWLvIhen0V5EfNvoTyoE1pFCZY+O058ptWTbpGEQA=;
 b=H/5jwwJFT7HVggpi1z9SK3JALtarx0aKBeqSUFE+V4FnGtPzXzgkJ4PjboWceo+Oixq6J4Wz4L7AjuU1IfwB9Hn4VLjqKTxnbTNTAKy7NP7drEwXfOex8cyNN++sWBME+WJayTeziE7j9Gqgd/wuLfrMvOdpYf5N2PiYXobItPYcYmOjooEII1Gt1NV4CguJ8iYA+iawdiP4ffpm6OtkOXe44mWfa3MsI07y5ucAh4ybFMcygnQIpOVAi4NoKw7HMDl3WAWQT16QJIkmD0VCm44P4Tzzsp7DG6si56IFIyGX1dcQELg8B2ZULJQji5Lym5ufD2BFwSa21oZtSERaUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SA1PR11MB7061.namprd11.prod.outlook.com (2603:10b6:806:2ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Thu, 20 Jul
 2023 14:42:46 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::104:1dc4:6843:e372]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::104:1dc4:6843:e372%6]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 14:42:46 +0000
Date:   Thu, 20 Jul 2023 22:42:33 +0800
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
Message-ID: <20230720144233.GA185317@ziqianlu-dell>
References: <20230718134120.81199-1-aaron.lu@intel.com>
 <20230718134120.81199-4-aaron.lu@intel.com>
 <CAKfTPtAu33AN6=X82T=yOgm40S8OXi+sPcF0QyD-bYRPV=xPEg@mail.gmail.com>
 <20230719051826.GB84059@ziqianlu-dell>
 <20230719080105.GA90441@ziqianlu-dell>
 <CAKfTPtCnvOehfrz1OSW+rmkKW+28bdGw8fU+AvVrZTxkHibL_g@mail.gmail.com>
 <20230719132914.GA91858@ziqianlu-dell>
 <CAKfTPtAqpAo8Y9BdWZ-fmnyYgA8PEtFbObqWJxc-hs2Ktqkt3Q@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKfTPtAqpAo8Y9BdWZ-fmnyYgA8PEtFbObqWJxc-hs2Ktqkt3Q@mail.gmail.com>
X-ClientProxiedBy: SG2PR06CA0199.apcprd06.prod.outlook.com (2603:1096:4:1::31)
 To BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SA1PR11MB7061:EE_
X-MS-Office365-Filtering-Correlation-Id: e6205fb6-48f3-496d-1afd-08db892f952b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c38diXXm93Sfs72/yqkbVYR7qQjw/uaFu3m2ZePOxjUM/ynDhKLfHp2GwIZbQs8v0JzhW/JA4780/bZfDmeTT9LerlhD6QnDRKsN85/+OiPtW2wBiKaplo7NX4Am8RTHnmhJPEY/Xjf0AzHY6zUOzXCQK10KAZJTxWfIsT/qW1k4b2MnhKqcIaxLDN59aa2WNbZpw7obYNFmd8Hfz6vfCVdqb+uS/YXMt/yuOpbuPW5+fCIGt5/6PXi9tx0WiGNKHImK5FV/LcnFoJRYYsYlQeJMw/WZNemBqWNgPvybOJr9SO81QpcrRGUcK2q4/r50CeFzSQ4wJTX6mQWJnl7v+uL+i44u01ErN6kEZkt4NP/yDdJrhGOrm/mlExguIwMuCuKsOlhryErSkXPaBmukELGMXyu+2+bEv34sSES80z33CPi098OsLgVU4qup6FavTQ4/fPMB3FXXHaA1iHxWqsLo/S/Y+fOGEaUZtaO2Mx83i6KH6boB2BWlL7Ju6Gsx/TI5AZfOrNlGSpUzObr9iQNOpa9ApPZFRagK26zEm1wLhuuh9Qj+sSILtAgBpJhj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199021)(6666004)(6486002)(9686003)(6512007)(38100700002)(186003)(26005)(33656002)(53546011)(1076003)(82960400001)(86362001)(83380400001)(33716001)(6506007)(4326008)(15650500001)(54906003)(66476007)(66946007)(66556008)(7416002)(44832011)(316002)(6916009)(8936002)(478600001)(2906002)(8676002)(5660300002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SgWTWKBzyFbO46CTQLH1LBc/ntbjkO/vFhvc4NAawFbs+05IdogqS+E73rKO?=
 =?us-ascii?Q?+KT6anvYhUEcoaQjGlJ6yPXdcDGVx5pyuooYhPU3xo5SztzW5VUYhQ0YLPGW?=
 =?us-ascii?Q?A+ShXPMi2SnEF0JsqeIZ6fUu5Y8MhaPeI7twrI9aq4uzHY9bZ1yxY8w6LUmG?=
 =?us-ascii?Q?JXS7MV9XVDIVnvIJvu27BCqMGvPmVM2RXff+gkHFMP9dpufPX+PA/AyVyuRI?=
 =?us-ascii?Q?ZgzRJV9yccyA23y4bI3ujzymjkZop+uQ1plD3RIS453EzDfeFEaa8soYHBdq?=
 =?us-ascii?Q?GSXl+Xtlpjeurm3SOEHL58QYEu8J72xCWaeO17+vpGGIDEps2+kza5/T9PS4?=
 =?us-ascii?Q?hT3cNZCMAH13NUXeLYQnB5p7JA8/amRwWH+upOuIN02NSXpGDVY9bQEL1gtC?=
 =?us-ascii?Q?WExu5r/iLMxKYoCKBmI22BpN+mGbzRUEkIs/7xp20xZUW9WUKHq0rG2YQGIY?=
 =?us-ascii?Q?/s6dRq8iWBE/sB44N7iovhacmNP4rYm8Z7pqicozkNzrhPM4pbBImssdbdVc?=
 =?us-ascii?Q?FqKBmrDYrf9Y7kC9OvxEUakYTLW58Ubgb7P4lmCwcMzjavmZt4MfUdEq9vMc?=
 =?us-ascii?Q?qAuEF9XRM0tra0aCjTUbM3V0T3T5PXiOg7fYfYEO4/WafhuH9B2Zzf2PhiXu?=
 =?us-ascii?Q?amy0fEnl8f6SHd5VyliigENVm6RiUD6X6K4r0VTSo/rEwsmY0VxlzTjvLFF7?=
 =?us-ascii?Q?XEVez2ml2SeCwQAIBGdccpNQHmf9RCuh7Vo4UgXjDR9Z02B39furry+e9S+U?=
 =?us-ascii?Q?ehqFyKhokxBVCjbgYuqk85Kv8Z4gVwJFRUt/DPUKzlop9FFppGxi48bQRWoQ?=
 =?us-ascii?Q?E+uJiFydFCD1zWbpcRrpbQpzjhZCZFD5iZDPnFlKZGmCHcmMz99DApYk3rtG?=
 =?us-ascii?Q?0LpWvX/7w4YVujGLPrqxYv+0DhoZn/oy+a6bbDbdBeSwShoT23UhoKKNWP5R?=
 =?us-ascii?Q?ySviHPgs3hmUMO9XLoJHYmdMvkacZXzrF1X25h1U5E2ZzP/dfCD5tADuIUEs?=
 =?us-ascii?Q?1flEF2x4UVAaHIWN14mDTdoe2VjTL1EMdCtj3Ik7NY+rGbEUBQPW/UfSzIXL?=
 =?us-ascii?Q?rYMk5lTHyvmpYmEEcsR4rMZSXnjmdF8b7V7SdR9Nqe0mu5Swqb/UxLMkF/m7?=
 =?us-ascii?Q?OippEJot6XbqFC/6cnMOyRV+SQUCIvjTT5mUOrJDsPmXEnKQFsWfbiwrHxSg?=
 =?us-ascii?Q?Q8gWMLX+RyIUbGrP98dmcOn5FSDl1IgJoNtxKsltlDqlQTrUKubSfS8Rby3R?=
 =?us-ascii?Q?CXhaF+EsP4mkxxHnq69uX56chkX6zV93cxgxrH4YG8e57r0tseftGRaPRi77?=
 =?us-ascii?Q?ncFMZn6fWEc0IVZfFjqloy2h7WfVKyFoTK3p/1/qnqdFL/rjRsEiqhc5RBj9?=
 =?us-ascii?Q?5IRvVD7NK1OwQqFOmIpUhxOQmxbENZr39Fj2r3K2DJQF7nSk+6JZUidU9Yxz?=
 =?us-ascii?Q?tsyUFHWW/htTK2tBZK3cj9Cy4z1sYXgK5SW7C/3Tda+OrmMNjEq9TBi+H8/N?=
 =?us-ascii?Q?hopRyuskroklsfEe2heWebgOmQBSRpKXTPVHZcMXuMWMpG0mqMl+iwJ63e0y?=
 =?us-ascii?Q?65j2m/OR8HiYYlHhIVSem0mJa7hkVmOZi5N18EHi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6205fb6-48f3-496d-1afd-08db892f952b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 14:42:46.5175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EukZhck+GhPGs7QOc0bpHVACUWsDVMFxeHz+aNb/dguzDjIBBSITm77+HqV8zDQVRqCMiODpYJIFds9H3W8zdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7061
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 03:10:30PM +0200, Vincent Guittot wrote:
> On Wed, 19 Jul 2023 at 15:29, Aaron Lu <aaron.lu@intel.com> wrote:
> >
> > On Wed, Jul 19, 2023 at 11:47:06AM +0200, Vincent Guittot wrote:
> > > On Wed, 19 Jul 2023 at 10:01, Aaron Lu <aaron.lu@intel.com> wrote:
> > > >
> > > > On Wed, Jul 19, 2023 at 01:18:26PM +0800, Aaron Lu wrote:
> > > > > Alternatively, I can remove some callsites of update_tg_load_avg() like
> > > > > you suggested below and only call update_tg_load_avg() when cfs_rq is
> > > > > decayed(really just decayed, not when it detected it has removed load
> > > > > pending or load propagated from its children). This way it would give us
> > > > > similar result as above(roughly once per ms).
> > > >
> > > > Something like this: (I think this is better since it removed those
> > > > unnecessary calls to update_tg_load_avg(), although it is inline but
> > > > still)
> > > >
> > > >
> > > > From bc749aaefa6bed36aa946921a4006b3dddb69b77 Mon Sep 17 00:00:00 2001
> > > > From: Aaron Lu <aaron.lu@intel.com>
> > > > Date: Wed, 19 Jul 2023 13:54:48 +0800
> > > > Subject: [PATCH] sched/fair: only update_tg_load_avg() when cfs_rq decayed
> > > >
> > > > ---
> > > >  kernel/sched/fair.c | 22 +++++++---------------
> > > >  1 file changed, 7 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index a80a73909dc2..7d5b7352b8b5 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -3913,16 +3913,16 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
> > > >  }
> > > >
> > > >  /* Update task and its cfs_rq load average */
> > > > -static inline int propagate_entity_load_avg(struct sched_entity *se)
> > > > +static inline void propagate_entity_load_avg(struct sched_entity *se)
> > > >  {
> > > >         struct cfs_rq *cfs_rq, *gcfs_rq;
> > > >
> > > >         if (entity_is_task(se))
> > > > -               return 0;
> > > > +               return;
> > > >
> > > >         gcfs_rq = group_cfs_rq(se);
> > > >         if (!gcfs_rq->propagate)
> > > > -               return 0;
> > > > +               return;
> > > >
> > > >         gcfs_rq->propagate = 0;
> > > >
> > > > @@ -3936,8 +3936,6 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
> > > >
> > > >         trace_pelt_cfs_tp(cfs_rq);
> > > >         trace_pelt_se_tp(se);
> > > > -
> > > > -       return 1;
> > > >  }
> > > >
> > > >  /*
> > > > @@ -3974,9 +3972,8 @@ static inline bool skip_blocked_update(struct sched_entity *se)
> > > >
> > > >  static inline void update_tg_load_avg(struct cfs_rq *cfs_rq) {}
> > > >
> > > > -static inline int propagate_entity_load_avg(struct sched_entity *se)
> > > > +static inline void propagate_entity_load_avg(struct sched_entity *se)
> > > >  {
> > > > -       return 0;
> > > >  }
> > > >
> > > >  static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum) {}
> > > > @@ -4086,7 +4083,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
> > > >  {
> > > >         unsigned long removed_load = 0, removed_util = 0, removed_runnable = 0;
> > > >         struct sched_avg *sa = &cfs_rq->avg;
> > > > -       int decayed = 0;
> > > > +       int decayed;
> > > >
> > > >         if (cfs_rq->removed.nr) {
> > > >                 unsigned long r;
> > > > @@ -4134,11 +4131,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
> > > >                  */
> > > >                 add_tg_cfs_propagate(cfs_rq,
> > > >                         -(long)(removed_runnable * divider) >> SCHED_CAPACITY_SHIFT);
> > > > -
> > > > -               decayed = 1;
> > > >         }
> > > >
> > > > -       decayed |= __update_load_avg_cfs_rq(now, cfs_rq);
> > > > +       decayed = __update_load_avg_cfs_rq(now, cfs_rq);
> > > >         u64_u32_store_copy(sa->last_update_time,
> > > >                            cfs_rq->last_update_time_copy,
> > > >                            sa->last_update_time);
> > > > @@ -4252,7 +4247,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> > > >                 __update_load_avg_se(now, cfs_rq, se);
> > > >
> > > >         decayed  = update_cfs_rq_load_avg(now, cfs_rq);
> > > > -       decayed |= propagate_entity_load_avg(se);
> > > > +       propagate_entity_load_avg(se);
> > >
> > > but then you  also skip the call to cfs_rq_util_change()
> >
> > Ah right, I missed that, thanks for catching this.
> >
> > Updated:
> >
> > From 09a649f8111cfca656b7b735da975ef607b00956 Mon Sep 17 00:00:00 2001
> > From: Aaron Lu <aaron.lu@intel.com>
> > Date: Wed, 19 Jul 2023 13:54:48 +0800
> > Subject: [PATCH] sched/fair: only update_tg_load_avg() when cfs_rq decayed
> >
> > ---
> >  kernel/sched/fair.c | 17 ++++++-----------
> >  1 file changed, 6 insertions(+), 11 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index a80a73909dc2..8d4b9e0a19b6 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4086,7 +4086,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
> >  {
> >         unsigned long removed_load = 0, removed_util = 0, removed_runnable = 0;
> >         struct sched_avg *sa = &cfs_rq->avg;
> > -       int decayed = 0;
> > +       int decayed;
> >
> >         if (cfs_rq->removed.nr) {
> >                 unsigned long r;
> > @@ -4134,11 +4134,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
> >                  */
> >                 add_tg_cfs_propagate(cfs_rq,
> >                         -(long)(removed_runnable * divider) >> SCHED_CAPACITY_SHIFT);
> > -
> > -               decayed = 1;
> 
> We need this to propagate the change in other place like cpufreq

Ah, I just made the same mistake again, sorry.

So there are three cases for a cfs_rq: load decayed, load removed and
load propagated. For all three cases, cfs_rq_util_change() needs to be
called and only for decayed, update_tg_load_avg() needs to be called.

I'll update the patch accordingly.

> >         }
> >
> > -       decayed |= __update_load_avg_cfs_rq(now, cfs_rq);
> > +       decayed = __update_load_avg_cfs_rq(now, cfs_rq);
> >         u64_u32_store_copy(sa->last_update_time,
> >                            cfs_rq->last_update_time_copy,
> >                            sa->last_update_time);
> > @@ -4242,7 +4240,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >  static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >  {
> >         u64 now = cfs_rq_clock_pelt(cfs_rq);
> > -       int decayed;
> > +       int decayed, propagated;
> >
> >         /*
> >          * Track task load average for carrying it to new CPU after migrated, and
> > @@ -4252,7 +4250,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >                 __update_load_avg_se(now, cfs_rq, se);
> >
> >         decayed  = update_cfs_rq_load_avg(now, cfs_rq);
> > -       decayed |= propagate_entity_load_avg(se);
> > +       propagated = propagate_entity_load_avg(se);
> >
> >         if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
> >
> > @@ -4264,19 +4262,16 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
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
> > -       } else if (decayed) {
> > +       } else if (decayed || propagated) {
> >                 cfs_rq_util_change(cfs_rq, 0);
> >
> > -               if (flags & UPDATE_TG)
> > +               if (decayed && (flags & UPDATE_TG))
> 
> It would be simpler and more readable to clear UPDATE_TG or not set it
> from the beginning

Do you mean something like this?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8d4b9e0a19b6..084d63371355 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4249,7 +4249,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
 		__update_load_avg_se(now, cfs_rq, se);
 
-	decayed  = update_cfs_rq_load_avg(now, cfs_rq);
+	decayed  = update_cfs_rq_load_avg(now, cfs_rq) && (flags & UPDATE_TG);
 	propagated = propagate_entity_load_avg(se);
 
 	if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
@@ -4271,7 +4271,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	} else if (decayed || propagated) {
 		cfs_rq_util_change(cfs_rq, 0);
 
-		if (decayed && (flags & UPDATE_TG))
+		if (decayed)
 			update_tg_load_avg(cfs_rq);
 	}
 }

> IIUC, you rely on the fact that a decay happens every 1024 us of the
> cfs_rq_clock_pelt() which is scaled by frequency and cpu compute
> capacity. So you can end up with a cfs_rq_clock_pelt() that is far
> slower than real clock and the 1ms can easily be extended to dozens of
> ms

Thanks for the info. I'm not familiar with this clock scale part and will
need to take a closer look.

As you know, the intent is to make the unbound update to tg->load_avg
become bound for those wakeup migration heavy workloads and the way this
change does to achieve it is to remove the update to tg->load_avg on
attach and detach path, just leave the update on load decay path. And if
the current implementation makes load decay longer than 1024us, that
shouldn't be a problem for this change. I don't see an immediate problem
if update to tg->load_avg happens less often than once per ms but please
let me know if I missed something, thanks.

> 
> >                         update_tg_load_avg(cfs_rq);
> >         }
> >  }
> > --
> > 2.41.0
> >
> >
> > > >
> > > >         if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
> > > >
> > > > @@ -4264,15 +4259,12 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> > > >                  * IOW we're enqueueing a task on a new CPU.
> > > >                  */
> > > >                 attach_entity_load_avg(cfs_rq, se);
> > > > -               update_tg_load_avg(cfs_rq);
> > > > -
> > > >         } else if (flags & DO_DETACH) {
> > > >                 /*
> > > >                  * DO_DETACH means we're here from dequeue_entity()
> > > >                  * and we are migrating task out of the CPU.
> > > >                  */
> > > >                 detach_entity_load_avg(cfs_rq, se);
> > > > -               update_tg_load_avg(cfs_rq);
> > > >         } else if (decayed) {
> > > >                 cfs_rq_util_change(cfs_rq, 0);
> > > >
> > > > --
> > > > 2.41.0
> > > >
