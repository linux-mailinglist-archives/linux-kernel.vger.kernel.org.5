Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F3375BF0D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjGUGmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGUGmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:42:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1081A113
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 23:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689921754; x=1721457754;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kXXxc1Ikwe1AR8CQ5qOT4Ib1wZzDJ5xd7FWsKIUeMDw=;
  b=QQ1hqe7HEFzr1mnDzGFr+HrT2OQ4uMFm3qHCezNdwKTSSI57upTDXiD6
   8tlMiHEuVeNkXkTebv3CZAhNly/lsP+EscO0ej7JFbs+p0o6URCe+Oi9X
   1Njg1goeriXdd07HpcHPR4d17d+wqv3oeD41fjNBZPlU3aterFAugvvt7
   kbDOJWFHreiLU90ej7n5AL3YMCDVoIAqI6lRxdCoMub38LjCnPzzMFdRu
   aGDIo24W32VQ3+JzJUyCAdCrho7uYLtBZ8bL42++f3eCnHAi0MXKnv/cz
   q4wtR/K2Dyp41yyvkTCxdsSnOiYkJ+8T8urDI76f+8qM0XZ5Gu975jV0M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="369622161"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="369622161"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 23:42:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="701927052"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="701927052"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 20 Jul 2023 23:42:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 23:42:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 23:42:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 23:42:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mw+AAfXBFUK0xRuJGQ/PZXXrkkO40q92Hy7rXOGJ0yAMw4PW9IsCFeajngrKcq6r3tBKCyaeOZAkvqZ5i7pRZsbz4Y+jWOxNNUTXWd7ow+Wjw3ELzXf69yeYvEyu+fhkz10kXZqNyBi3IzG1SI5bRZC3rfd3PsSU5CU19SOxPr3LlPTxZAYOv36ieUDTtdXm5a7QkJZRk6t/4oF/snK/Rogf+Q74KRS6ZGUZ43JfrA5H9oymlItMF01pvkGCEoNsWQDB8Zy0wKBSPiNXWghIC0gy3P3EAwGPbYCu0oZuKUeVP1OmwLibFuIlmUzjBrsjagrX4fGmufsJNG4sGDdwuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEqtSK0RfdSH5I88/Wk0QFT5F199tT6hUQcs5ncut/M=;
 b=TpY9YBIPpAThHIwS3nKcVxvzNxExCsamFpPqJM2rADNmCK7Kb46OJELHWc9R3PgndmqT6M3wopZgbDJmkg0kJUuFiad9HpSjyYLxqM+LSGcAESy+8OxSiqzFSAh3catJ5hIfh62jMnYMym2k1EeWwS7eVugtnp+V8Tg8cRrgJuDpo2q4s8lCpeWf1nkbO40Rg/YSoC0GJ41vrkXanXdOL8Q9exk0eEV0tcQnur63ZLoriz6CHF0pSSnPYvoU2q1+ttxUO4F9tAue0hCpA6c27ITWsjB+LLA0uSvX8r+uMpvcFQlHJimOIk/UfCtd6vjSFpYhF2gxefY9PEMHHmVzow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 06:42:30 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::104:1dc4:6843:e372]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::104:1dc4:6843:e372%6]) with mapi id 15.20.6609.024; Fri, 21 Jul 2023
 06:42:30 +0000
Date:   Fri, 21 Jul 2023 14:42:17 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Valentin Schneider" <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Nitin Tekchandani" <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/4] sched/fair: delay update_tg_load_avg() for
 cfs_rq's removed load
Message-ID: <20230721064217.GA225030@ziqianlu-dell>
References: <20230718134120.81199-4-aaron.lu@intel.com>
 <CAKfTPtAu33AN6=X82T=yOgm40S8OXi+sPcF0QyD-bYRPV=xPEg@mail.gmail.com>
 <20230719051826.GB84059@ziqianlu-dell>
 <20230719080105.GA90441@ziqianlu-dell>
 <CAKfTPtCnvOehfrz1OSW+rmkKW+28bdGw8fU+AvVrZTxkHibL_g@mail.gmail.com>
 <20230719132914.GA91858@ziqianlu-dell>
 <CAKfTPtAqpAo8Y9BdWZ-fmnyYgA8PEtFbObqWJxc-hs2Ktqkt3Q@mail.gmail.com>
 <20230720144233.GA185317@ziqianlu-dell>
 <CAKfTPtANqtEQjv2UThb5s0TPCS2adhC_14Gfv5ayAOva9Mib8g@mail.gmail.com>
 <96efae1a-37f6-c8da-5cdb-07b460307d6b@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <96efae1a-37f6-c8da-5cdb-07b460307d6b@arm.com>
X-ClientProxiedBy: SG2P153CA0038.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::7)
 To BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SJ2PR11MB8587:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9cf1fb-7262-466e-45a8-08db89b5a73e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dhr1J6j3D1SGIps2jTT6RHx67gex+b5Z0tNfYh0GLlvWqszR253s/5fzeWb0M1XN999u81M6QmARUrXMRfIyxKoF8d94+fXjcGbB+G3Mkkv+r/FIVnSdXxyDn7l8hQ2GH0vOPJlYCfYYJJ26/jPYF8UAD0HESoRvOVtmNaB4FpiCsLtGaLI1TYhdNn7H+eZHNzkOsgtNsLiJtFd6f0AJqDl+Vb8Xty0gXh2UgWnhvXEBAD4Jr3Tee+VJEvwYVLwnqaXegBghC/gyitgJhd4xdnegLi/ZuRdi9XzY+DJ0UGKRQT0dnFHCM7hnXdDw5D0q5BhQDspI2xVgJB6wBgcu2YKEb4FIgUb6qKMm+2dp2fkJEx0fHEV3qNhW5NCQ9jyrlDhEBp8JeaNITOUSFBRFFAsD8qMnWzjlEyuXerphbO03LwGHzbSwkWy1aCo46FvqQbOJ4h7NDsmIJWBB0uIj32Sp3jyyYIMdn8ThBF/YCQKBRafjL7fe5ASCA9E7HBrjOoGuFgItfposPgS+KqsG08wh4wG9Yhd44MMmgU/0D06lfgmGKvFOJwEfvrxP159e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199021)(54906003)(186003)(33716001)(83380400001)(53546011)(1076003)(6506007)(86362001)(26005)(6666004)(82960400001)(6486002)(2906002)(41300700001)(316002)(38100700002)(478600001)(4326008)(6916009)(66946007)(66556008)(66476007)(15650500001)(44832011)(7416002)(5660300002)(8936002)(8676002)(6512007)(33656002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q8PlgsaWHEk5ZTol3+3EJ3R+6bxfFTdX3MsG5m+efBPIUGbIsmlQQE9EOwyK?=
 =?us-ascii?Q?fOrygFM/PUgLpQlFthQ5wAmnN0XbVXsPMPEsJ7hyYvz+1Ju3Ju9IQCokTVSc?=
 =?us-ascii?Q?9od/Ef6bxtBdmlVYz37te1E+s4ohju9F3BXyzG4tZ1pJIzD/VDcJXHtshzRZ?=
 =?us-ascii?Q?avmHGq2emydyppnqjInmNsOpewAn8GxpkRP4vIK25Cd3Vd0MRvwD9CgVtbNJ?=
 =?us-ascii?Q?z2Vl5OY3vSsDt0UIvE2iZFNNW7RfYTOnNfGvaKKDqlmUeYbUabAGxdLA2MJ2?=
 =?us-ascii?Q?QAOIfghZtR3UgIaNynXqdIpnWUzEv6xlPLhV8y9pj9eRcbSYwUevrs6P6ctO?=
 =?us-ascii?Q?GxZRCwamvAWXtuhcZEpoXAtcQ6bQADs2G2d2Kn5rYCGsLLAXusKf8al2nOTs?=
 =?us-ascii?Q?m8MUndGNspOsHBU00J3vByX36X0YLdMhLZt5WKClc3ENzXChyAqNi3kmXchX?=
 =?us-ascii?Q?9bIA5sjCQviIWhi+jnyM3im3KN+WJtEjGxvAIiff4tre070U0Z9PjnrkTKCI?=
 =?us-ascii?Q?/O5IARMZduBkXQQBhGn7mldR/sXq7QGzcxqyUEgyCqZ1kM5bKuQt0T5Qhwi3?=
 =?us-ascii?Q?NYvA5o8219PFnoMXQi+8FYmwsWS3XhTnr1rSB8mN/CyJ4SAFlrySVIagfLhu?=
 =?us-ascii?Q?BaPEC4j9K0BfhZn3BUKIMlxsglPViN9Lqxilj0GpNsiqjvi4cvrpBmmjwe8+?=
 =?us-ascii?Q?BC9ZIyTLsEGQR9dliGneShVfkJYFRBqHK6h8ra+YR2MeS3Wzav42egudc0/3?=
 =?us-ascii?Q?7GZ9jcqWWD62g1PsJtJ8JQVrFRRtIQ8DXeWBWtRS8ZdRgc7p0WYCVWY5wl7U?=
 =?us-ascii?Q?bHFNoM5hMh1XYatiepqsH8kuFib4VTtLsgqIakCGpiQ8MchJRStY9dtUuUGj?=
 =?us-ascii?Q?5Bt1GSepPV2BKhR/DDiDEcsG5e/kdwfRK/5nOcbUDIgupegSN/o6usj4/0Lr?=
 =?us-ascii?Q?Yab4W1JdpzK3qs5qAiFOjLIa5q4rdXityhFmwu6RAfo2fLDYyfxtsphmLyXM?=
 =?us-ascii?Q?jrGX6fTO9TN8AcvCJeMe8LUwgk7Y60UZT7vzspW1YGw2a/lgRs+ccQ198Akn?=
 =?us-ascii?Q?EtZ6YKPCx9+rKlxWM5trKIWdUrAI/WOFGfFAJOJ7vBC8teQ9XXqu+Mx/pF5m?=
 =?us-ascii?Q?ntTnOCI7ba6PQu9fUXCXXBYLt6heEfFUjBvsFqIztR4hyEgnQyi4nQ0szRrs?=
 =?us-ascii?Q?xOxRIVvQAZ5/S7sM8JUyharWwRBDYPl91vvst6NSAzTByKj8RBO4RkjOHbl1?=
 =?us-ascii?Q?72OuXU74Zk/y0qUjZpkW1zyG4PVJYHyh/TuuB+DbIMmQZq4JUjFC8H2kY31C?=
 =?us-ascii?Q?hwemXE/mridh/XJ2rpgTN0EdDPaga7e7xqLqRigCWDiOSFaGxFcNrS48vwRG?=
 =?us-ascii?Q?U6s4sheVi1lonisc/Pu4HNdXMFl8UvxIjH1EJVqVvy/OzHlrkSyybekXhi+b?=
 =?us-ascii?Q?3be5B5VIYoFw9h84E8y8i3jFvguTx/TqgH3k0PVMFVjhFLEfMcnfZelUoac9?=
 =?us-ascii?Q?SJ4vltY1P4Huj2Zc0opmFC5QwXG6guHzn7L945qZHy1wO4YObLMPS1X+Pnrf?=
 =?us-ascii?Q?okwatF8YBR6HNXB/9jvGsGWzy3N5K8whSYxNBp+6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9cf1fb-7262-466e-45a8-08db89b5a73e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 06:42:30.0452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRSsiAGvq3YdjTQYSFzpdfigPo9296lr9jfos1GunuW+Eku+3VQ7itT8wRGUxbZVuBeWHcIhHUO9M3Co5U7+zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8587
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

On Thu, Jul 20, 2023 at 05:22:26PM +0200, Dietmar Eggemann wrote:
> On 20/07/2023 17:02, Vincent Guittot wrote:
> > On Thu, 20 Jul 2023 at 16:42, Aaron Lu <aaron.lu@intel.com> wrote:
> >>
> >> On Thu, Jul 20, 2023 at 03:10:30PM +0200, Vincent Guittot wrote:
> >>> On Wed, 19 Jul 2023 at 15:29, Aaron Lu <aaron.lu@intel.com> wrote:
> >>>>
> >>>> On Wed, Jul 19, 2023 at 11:47:06AM +0200, Vincent Guittot wrote:
> >>>>> On Wed, 19 Jul 2023 at 10:01, Aaron Lu <aaron.lu@intel.com> wrote:
> >>>>>>
> >>>>>> On Wed, Jul 19, 2023 at 01:18:26PM +0800, Aaron Lu wrote:
> 
> [...]
> 
> > What was wrong with your proposal to limit the update inside
> > update_tg_load_avg()  ? except maybe s/1000000/NSEC_PER_MSEC/ and
> > computing delta after testing the time since last update
> > 
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
> 
> Could this be `u64 now = sched_clock_cpu()` like in
> migrate_se_pelt_lag() or newidle_balance() to avoid the time morphing
> due to PELT's frequency and uArch invariance?

Yes, will use sched_clock_cpu() instead of cfs_rq_clock_pelt().
Thanks.

> > 
> >         /*
> >          * No need to update load_avg for root_task_group as it is not used.
> 
> [...]
> 
