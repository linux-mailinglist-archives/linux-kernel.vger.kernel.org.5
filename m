Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFD7758CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjGSFSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGSFSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:18:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A60119
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 22:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689743930; x=1721279930;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=q8a89aEgyBuCgNlkbl2vw95vCENqGBL4+XqEuOnOkx8=;
  b=ITGpB3Lf6lNLOPrrDfCow7tz+MBWou9LQBsAxi8AMp/+HohBzTWIOaHQ
   oVvhMKxXOPqmeuHLf4ci6TQ7FWAZM5crq9PtoQHud5Ko5VhsCeci7uPQ8
   fWNved7jVTWgOJLxtoKjV45/m6XzjwL/joiaoRjsN8FkZ0SU/9hX2n30l
   c1xxDWYfEXYGjZKSHB+xBnMaznoC/ya/M3Eh3fNrsIX3N7xXW6GQ7TxZ3
   ujmaeieEuLWIuza1b35SLFuUjBmAx5a4P2B2aiIJz+9QITS2+H4qcB+OE
   NCgiwI4UlH24tEzsdQml+gI7JhpFYHX0ZdBZYl32sEH6FDUdjl7RWC/0u
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="430139757"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="430139757"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 22:18:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="674158472"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="674158472"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 18 Jul 2023 22:18:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 22:18:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 22:18:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 22:18:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJHMQnLttMcDW7SUzcOGwCnhjzWT7PPFYNvvoTKIkPxynxZSAPXE/U5hnnUhdzdmwczWlkjS0gKylLrmxGNRjVWEcKIBX/5k3sHk8J1ejMLItTDkvXe9Aj4v0/WpNtQ4avYYy2ymq7lThO9BZljYQocCYZ4TNhdghdNITlzQgSamQBy+NGVz+2iYjRrjS/ODwFh+gIYr8qxOvWBIclhjUqaG2r+wbhctLL+gKlmSn3sCzheWJj3bVrR7osHtHRoSo2didvzTpynoywoDzsL/1FsRENbSzfn5f1G7MMUu6zIiotleBx2kUOXo09EF3WbqC5SuwVb4NGfoe0yiZLP0UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axx6xzAYr2Pk60tw3nsAdyY+LVXHGs68j98z1LhW/cs=;
 b=L78HlLGSeYfGnHhHA3x7Kh9qjpGL88FNUeEGgc6Gk9oRSuJKdcFAd75U0Rc7IMeKOhJFntD13XVzvoZ1u1rPwqgHjWzI+piBrR573yeXQxFWl6D0ybPIb25EpkKYEeua7ngWnyo0+hVoQJ9pWNePXiL4CrxQ2tIwGs5anyBivFJE5MutWWqvngyi0OWh8/aWy+8GZQ7sQqtb+lufDHlY7TXhTicNtJnkphtZJrvN4AFn2ZszLSMMyS0IXC1YznBDn0U640eB/zds17QHGrUUW2MB8N2uYBQDLc2aEmXJIvWYXkmlDzqzrADoBi8JobTP3YpdNy2vEJ+zwDtAMvOSNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by CO1PR11MB5107.namprd11.prod.outlook.com (2603:10b6:303:97::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 05:18:40 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::104:1dc4:6843:e372]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::104:1dc4:6843:e372%6]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 05:18:40 +0000
Date:   Wed, 19 Jul 2023 13:18:26 +0800
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
Message-ID: <20230719051826.GB84059@ziqianlu-dell>
References: <20230718134120.81199-1-aaron.lu@intel.com>
 <20230718134120.81199-4-aaron.lu@intel.com>
 <CAKfTPtAu33AN6=X82T=yOgm40S8OXi+sPcF0QyD-bYRPV=xPEg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKfTPtAu33AN6=X82T=yOgm40S8OXi+sPcF0QyD-bYRPV=xPEg@mail.gmail.com>
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|CO1PR11MB5107:EE_
X-MS-Office365-Filtering-Correlation-Id: b08de587-1457-494b-399c-08db88179c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YM1AwCxcbKjCF2YjzzY4N5rgMs2Yi5jBJ4yhMYNgLPeh0rRfjacAIOok84xRos69wiGyKZCxQMU3w5UpnEFq1VY1Kio1VBPjlAqgSgiVqDxaMS3FOhXyy5bSe+ik9gt4EDw5rUpO3Qd0nnJRqbzEpjFroGoitf6GdZm5oFSdZ7dnyU52V9yAUmalfSbfnEJKdS9SE/WM0Sa0NPngSAArDF3e7M5eYNJVzF/fh7xbKeeo+Regge3qrxh7mTeyusqKQPHmZ8pS1Yb4M9oa/GX3ehMXpQqhyvPssnqrX20rqvQ9eKjq9+SN00PvUl1fGq5tlIl0gQTal+CSHBiI+bJgG7DYRv+jsjNKkucCQQfKM29Ql0GlH3dHcKg5cRFHpWgOlHLwzsbOYD/9WOJzB7dN1NS1jDgzgLgHjEApivr5kQztOLMSdDRQkJiJW61TAM9N7LZCBIROTf8bFeCK5m1g/BVeO4LhV7ioNuQHsEwCDqCwM8Rdyru8sDe7g4JaIx5upeEgk9KAib6rOtXsKFDb5qWznxVShxALtGLdojTPJOCwpisMJUpOUW8KikprGWWV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199021)(66946007)(6916009)(66556008)(83380400001)(66476007)(4326008)(6486002)(316002)(6512007)(9686003)(54906003)(1076003)(478600001)(6506007)(26005)(186003)(15650500001)(2906002)(33716001)(33656002)(86362001)(82960400001)(41300700001)(5660300002)(44832011)(8676002)(6666004)(38100700002)(8936002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mUvbDN2GhEQCjc+LCYB3suUstazgAiRj+I97zolSQeJMSxm7XHHKGyRA8/OJ?=
 =?us-ascii?Q?JiMmmwtVcHyytmK3aI4ghZbL/vA8DsS5zaLcn1wc0lNVIer+suRxTo0qR5cN?=
 =?us-ascii?Q?/mkROYlT3oFo1yS5I8YZtI5WDomNHOW/+pc3pkHUgslahvWybKzyOuBjLWlg?=
 =?us-ascii?Q?0FrfOPKhMM9vZrck3tjBMmoFB6g1QRG/7NedmLQ8vDdjs6A5eUNuYkaDFuM2?=
 =?us-ascii?Q?JX0y6HRjJ83Dh4nKpjyn+BVDX8U7Xx9V5pqiDwcbKnruNmFgIHB1HpENZEZX?=
 =?us-ascii?Q?BsS94MhLd+cxEbXA05vi3XA4ZWna1GprGq50IL3d2dIymOwUf5qKV0K/W1ve?=
 =?us-ascii?Q?KBUd5f4Y3IfdTQk0EesNoatyCczD4gXW+DFAXnDcPKVMZQm4pkTyN8HT73IA?=
 =?us-ascii?Q?g87rBO23hHxbUcRAHjeRc7iXiKFYv/i/wC9PRBbiODUUz600SyJ/iLVt5G4Y?=
 =?us-ascii?Q?s+yAVpskj9W0pucfm1wj7IWdBn24LXzJRREVwYCs8ev2ZL8bVW4ixlvGcbum?=
 =?us-ascii?Q?7WnOzKvJgvYBLPMoE5UpQs0+EOzdrGQaPyimUAZ00vGl74rBIgAfdWDrvkLO?=
 =?us-ascii?Q?YV0tHic8Dkx/lunl4VaXIVbGSIak6BVu0uNYx2+gm5p9t1HLw+Us93BfEynm?=
 =?us-ascii?Q?/ltJe67DS2T9ECMDJcH2vRdLcNPDRLJl/YarxZBAuGftyes4G8JL9gUHuBYI?=
 =?us-ascii?Q?6cuPyc7ReVc40rWJSiEXwV+oB1cds2EqvqzZBVIAI5zUUuyg4dh9oOaYwAlF?=
 =?us-ascii?Q?0s0ptOARFnSDp3DcHrB5BfpB6oc9Mb9B9LVLxi9mL2KgD2ke4AW/cr9GlfJs?=
 =?us-ascii?Q?XYteRQoW3PdwWFSAa9Hc1sfQeisjFJsbS+VeZOB4OTaQlesJs/F9l/QA1h/H?=
 =?us-ascii?Q?ohGM7ZNIHPsbgL2FOvotmjjKLJ/89sikegvuWfLAD1Rd/VFp91h9ezE3Zqlp?=
 =?us-ascii?Q?7TmNJMdAiAoKjxjaiPbVVH1RmiUMQ6phdj39Ye+IOeGiFkdOsLf9NBaKNWO8?=
 =?us-ascii?Q?+9Dn8T3zdW+MYUHSvrCXr0yD+uQ2RpBAOi03ZJ6/K/09ImtF5rVfNkc9GJOo?=
 =?us-ascii?Q?Hlw+OXaPxQirX3srqsHNKFS/qtBoj3ffz7myvYCYiZC6SM512DbeYNJ19hPv?=
 =?us-ascii?Q?cmvt1ogKecvn9/3vik32EenCw7BANNNouAQunbsI/itC+W5+Sqt+LIDmRIdp?=
 =?us-ascii?Q?vCAVqEWa+x9ZleKjYh7THG4X6IGlCMiyxXlsX+rsa9FAUwSLe3nZxzW9Fq7/?=
 =?us-ascii?Q?YnQXo0tu4Sehjl3F5YpjBSP7zS8MLrO49QgnYlLQzMILPTVAaFkCAntnm1kN?=
 =?us-ascii?Q?mlLid66ZatAdE5b+Oo12yH3MLZ6qcOfuHP1yqpdeR+O1o464qrk8XI1LrBVo?=
 =?us-ascii?Q?G3zPswgswjsL4o6tz8SxcgPNayq40/OcLqgAv/LKI4TrF5ZiFQpti7HXhsyH?=
 =?us-ascii?Q?/hqWiJAulxSLfzHX80CfaJnt4i3yMCReenJjFqhwmnEsZPBtFIEJEf06aZub?=
 =?us-ascii?Q?DGyNapYd69IqTOWlaOOv4MxR3/RpHIUKNJQ/l16/mTbqnZE9epF1QRveEXyF?=
 =?us-ascii?Q?57HBVvJh8D6yFhlZX/rr2frARxgYrwTTA+anxfCC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b08de587-1457-494b-399c-08db88179c61
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 05:18:39.5868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9wb+q+w/sv5QvpS05lkEJva5uVe1iCM1JKAlFDadPsZJJbPz0KW32wUHpuqnxeTyIvIk5Kl3Vzfru59SIqo8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5107
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 06:01:51PM +0200, Vincent Guittot wrote:
> On Tue, 18 Jul 2023 at 15:41, Aaron Lu <aaron.lu@intel.com> wrote:
> >
> > When a workload involves many wake time task migrations, tg->load_avg
> > can be heavily contended among CPUs because every migration involves
> > removing the task's load from its src cfs_rq and attach that load to
> > its new cfs_rq. Both the remove and attach requires an update to
> > tg->load_avg as well as propagating the change up the hierarchy.
> >
> > E.g. when running postgres_sysbench on a 2sockets/112cores/224cpus Intel
> > Sappire Rapids, during a 5s window, the wakeup number is 14millions and
> > migration number is 11millions. Since the workload can trigger many
> > wakeups and migrations, the access(both read and write) to tg->load_avg
> > can be unbound. For the above said workload, the profile shows
> > update_cfs_group() costs ~13% and update_load_avg() costs ~10%. With
> > netperf/nr_client=nr_cpu/UDP_RR, the wakeup number is 21millions and
> > migration number is 14millions; update_cfs_group() costs ~25% and
> > update_load_avg() costs ~16%.
> >
> > This patch is an attempt to reduce the cost of accessing tg->load_avg.
> 
> here you mention tg->load_avg which is updated with update_tg_load_avg()
> 
> but your patch below modifies the local update of cfs's util_avg,
> runnable_avg  and load_avg which need to be maintained up to date

Yes, since it delayed propagating the removed load, the upper cfs_rqs'
*_avg could be updated later than current code.

> You should be better to delay or rate limit the call to
> update_tg_load_avg() or calc_group_shares()/update_cfs_group() which
> access tg->load_avg and are the culprit instead of modifying other
> place.

Thanks for the suggestion and I think it makes perfect sense.

I tried below to rate limit the update to tg->load_avg at most once per
ms in update_tg_load_avg():

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a80a73909dc2..e48fd0e6982d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3665,6 +3665,7 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 {
 	long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
+	u64 now = cfs_rq_clock_pelt(cfs_rq);
 
 	/*
 	 * No need to update load_avg for root_task_group as it is not used.
@@ -3672,9 +3673,11 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 	if (cfs_rq->tg == &root_task_group)
 		return;
 
-	if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
+	if ((now - cfs_rq->last_update_tg_load_avg > 1000000) &&
+	    abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
 		atomic_long_add(delta, &cfs_rq->tg->load_avg);
 		cfs_rq->tg_load_avg_contrib = cfs_rq->avg.load_avg;
+		cfs_rq->last_update_tg_load_avg = now;
 	}
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 14dfaafb3a8f..b5201d44d820 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -594,6 +594,7 @@ struct cfs_rq {
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	unsigned long		tg_load_avg_contrib;
+	u64			last_update_tg_load_avg;
 	long			propagate;
 	long			prop_runnable_sum;
 
From some quick tests using postgres_sysbench and netperf/UDP_RR on SPR,
this alone already delivers good results. For postgres_sysbench, the two
functions cost dropped to 1%-2% each; and for netperf/UDP_RR, the two
functions cost dropped to ~2% and ~4%. Togerther with some more rate
limiting on the read side, I think the end result will be better. Does
the above look reasonable to you?

Alternatively, I can remove some callsites of update_tg_load_avg() like
you suggested below and only call update_tg_load_avg() when cfs_rq is
decayed(really just decayed, not when it detected it has removed load
pending or load propagated from its children). This way it would give us
similar result as above(roughly once per ms).

> 
> Have you tried to remove update_cfs_group() from enqueue/dequeue and
> only let the tick update the share periodically ?

patch4 kind of did that :-)

> 
> Have you tried to make update_tg_load_avg() return early ? the change
> of cfs' load_avg is written in the tg->load_avg only when the change
> is bigger than 1.5%. maybe increase it to 6% ?

Yes, increase the delta is also a good way to limit the update to
tg->load_avg. Will try that too.

> 
> Or like for update_cfs_group, remove it from attach/detach entity and
> let the periodic update to propagate the change
> 
> But please don't touch local update of *_avg

OK I see.

Thanks again for the comments, they are very helpful.
