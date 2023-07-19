Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD98758FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjGSIBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjGSIBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:01:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59040BE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689753698; x=1721289698;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KmY4KXsB96iARN1tzDH8pGfVYLxgjHtleNcNjxtF5iE=;
  b=I6dTxPbI5+b0DhHYUxAEyDRXMYBURv3ZKkJ5SB+ybE+13b0OGOWafLy7
   oDPKC81gvYBfHZOmvs9NX8OrBuSTkpVkeO3Lp63PaoYUXSNI2xwtWQSKR
   6GKE3+CkBkZTwm1BNVbSWbiXwE9PYln2VyzHga15Phfyax5+f0Gl0GxBh
   iphUIT2dzxZcMTy1mJaV5ZgFyrEaeT/I3TauxtiBw+PRfSq2TUoNX8Yy0
   junWwKhsRkGGwZDMwb/SB9iOnCuA2y3mOtm5f10EVd95TuN8s+1WZBkXj
   7wmS7cc0+lO4Lsh+s+0Bp+UAMSdLGFWYX5owUEC7hXaDYDeRjKg0bPZr9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="397251946"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="397251946"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 01:01:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="814046594"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="814046594"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2023 01:01:19 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 01:01:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 19 Jul 2023 01:01:19 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 19 Jul 2023 01:01:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ER7QAgTEDZw6B+MkRI/BQ9vvKAyRnhR280iX7YXrQ1oNFwbiVrISoRw6YjT+YGO5JZgunsdvHZyuzIqqHy8YuKzQ6zFTW/uF++r0OsbkmCxt60esnUKY38dkdxfAzm9pN2qtpohVJ64haVtuEc6O5NFK6xH9nuWDAfSSSFS3fuY1LZaxK8iRw9ICIjmerNlQDZlZL1HXX3S5x6ku9ZnQeSm4JkQBh2MWODS+3MVNKfCR4C4Epm2kcUtga9UoTnSOXQxolIqZS6lj8iHyJNp6SUlrGaUDClxVFn/VPwPtWCkLGD4dvxs6X+SCY3bxxHvFMxI6fb3J0dBRuM3Uu4E5zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjTGQFatc+3jlZ3QNRbwuJNovctkiBUsGIQH4oOjiKw=;
 b=STKWOQfidtJX56Tw3fj202idPiro7FTyKnLoDmoucb4YoNaBEnpf7JLUsqqX/MB1FoZFaelQeNyjSXtDXSSx/8weDOnMqNGNAG0VqVjOmL4S6glp3xy2uTFvEw8+vA8BQlc0jJACWCSpDn213Xa7a7mRCiuAbfD4wNqa/2vJKjG0eWVmGPUbOR02RhP9sIHK3rX2xJq6GjAfIUTmleP4IzmD7JVCGFj5BDlHCE+KQrsOBeexr2uIR1lo7XqICPcRj3MV/OeV3AlXggrYxPMOMmOnqG6mCk0+fsjKUOomOmIRO0qMOuDGEKeFTzkdA75qFO2zfmfPuc/tSmpKKb9XDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DM3PR11MB8682.namprd11.prod.outlook.com (2603:10b6:8:1ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 08:01:17 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::104:1dc4:6843:e372]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::104:1dc4:6843:e372%6]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 08:01:17 +0000
Date:   Wed, 19 Jul 2023 16:01:05 +0800
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
Message-ID: <20230719080105.GA90441@ziqianlu-dell>
References: <20230718134120.81199-1-aaron.lu@intel.com>
 <20230718134120.81199-4-aaron.lu@intel.com>
 <CAKfTPtAu33AN6=X82T=yOgm40S8OXi+sPcF0QyD-bYRPV=xPEg@mail.gmail.com>
 <20230719051826.GB84059@ziqianlu-dell>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230719051826.GB84059@ziqianlu-dell>
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|DM3PR11MB8682:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf58eb9-a91f-4900-4f0c-08db882e545c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: inu9APsAh0YmA8buuDxb0ol2EAuvktMt7ZgUISdBw/CM6ZaOP3lO3oO2f9MoMiworEvQO+mp+YULeZbn8UhIjzdVGcXgYv4wwIygCvEz2795jJ5uxCZ+HE3xN52Y0a3P8r5QdoqJzI+DJPZST6IugGk30kiDLlUM/SjMzkhMAIMs6/yuX2gSkxk3MxZ6fLveKQTRLaW3EwZH/6CpWRNylMtXXr3N0Pzh9MmzyXupl5sQ/t3ef4aoqL0ghrNKa9ymKrwTR7yvGTfEsAwqvNMIrqTkA55QAcM8S7UTyb0BaffZjhFhz+mw0YTcCz5Jov9lXDq60vTy3e1OhmQTM3nZdX/VNtYyXSR+TqS8ru5IuuCZgJKrblYrt2FNud7HbvzTYbuHVbXJD/pcAev5Z9h43noMEPqa+b9TIlOXgLY+1HyEPX2NeTBVUGTRMtYB0ozEq8FjqqZBU9xvFMduiabdP/FdiTsI/M+qoVbBhpZKpgwbG7p814qOzXhPsHpAeUyNc1DrChZBZXxnUydkCWlGurrT8yRW+IIqVbGH9azCJt0o1afz+9MBk9+qR1176ORu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(2906002)(33716001)(86362001)(6512007)(9686003)(82960400001)(83380400001)(186003)(26005)(1076003)(33656002)(38100700002)(6506007)(53546011)(5660300002)(8676002)(66556008)(54906003)(15650500001)(7416002)(44832011)(8936002)(6486002)(478600001)(66476007)(6666004)(41300700001)(316002)(66946007)(6916009)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yeuXaK8MSAPaXoZmPygITx/hVIRijhFUN4o0144mKLSrgjdk+4WCA9ridldx?=
 =?us-ascii?Q?IC1B7Iv9WHBIELAn4GR4bEsLC4xqjMA+1X5LFf78W30gLKYLNaFmFCUifC7x?=
 =?us-ascii?Q?O0r//ozfZsCXX3mScVkhn0dhyVCSWuDCrQh+HKEQyQ62+3Ii+qx6a0nB0ngr?=
 =?us-ascii?Q?tefNnzhWXhAu+ptp7ihwDB7IhnP21aWrhubRh0DCXsoqdzfq0vVftvCY3hY6?=
 =?us-ascii?Q?p5uLbiB+sEUJg9fc2TIpkbRtqhBcPVngDir6PZLGUSNlgZX1v0wqUbYHfSJr?=
 =?us-ascii?Q?5Rv/+s/jxmj4GDZS2IxRrsasJ7PxkmgbDXtl823wLqw+ch90wc+D5Lh5ZL0I?=
 =?us-ascii?Q?Y8OD8CgNyVsElA8art3FYbO3m1BLTToBELo/WIk7T9lQXP5leFGOj/QIsGAS?=
 =?us-ascii?Q?6dd3osjKpGnX5dwBgJR4FgHJoYyYC70FyXpacwtegCv6nJpEMqui3LzS6nXK?=
 =?us-ascii?Q?P1WxdMWkJx72JzN6sy9598ltQMO+UM327L7CagN3ESqIAMmGBSpJVxGmMG+y?=
 =?us-ascii?Q?3oNncRZ58w/yMuTqAOHk7dA5hh+AB8On3UtXL8l2LrGCRk8972UB3zLt9gV9?=
 =?us-ascii?Q?1Q+aIsAG06xdstp/1iZmeKMNxrZ+Hro0qL4hIuRbOfdz0hzsqStL+yZNcI8a?=
 =?us-ascii?Q?4PKPtqVZBZ54UaFf/ItoVsAjdIlEa9yGf/Snjqfd9O8IwShBqb4CJF8LpoRp?=
 =?us-ascii?Q?ArkE7F0t6V1mT/CK1UmFVFBAzQQ2f+3pxpJhnEFuNfBexOskLMb3QYRu8+nd?=
 =?us-ascii?Q?2w6VFreE0qrFlooA2JPtIyaTYbguElZUgdL88bLsdek+dSFWYVhHSfo+9CqW?=
 =?us-ascii?Q?LMIr9VwRf/Q7tdyHsqoDteNiC98EXRQfdweE4FO1jORQ5PLWY76el4pea9Vi?=
 =?us-ascii?Q?UXPYXICiYSxqb1jveHteVeRLzuw7bmK7L5enKgE1FE59gxR8I6fb5a+uMc23?=
 =?us-ascii?Q?+KDtMASV6Zi28O73pcqK83doCBUqLPYOik6+GIDMw+JhKb+etcmySniETQTk?=
 =?us-ascii?Q?6eNbm7w0VXXDidFlDiDDnjGEN5yDmTRQLuDHTmZKloOoT3TaxL35ZsxfNXL9?=
 =?us-ascii?Q?7y8nDD7DEcF7Zgfwe2QhQw0qWxbAWbciQCnscZmqUIE5A2AkECUS9DzL3hEh?=
 =?us-ascii?Q?TtpicfnqeVh2U9a+DoI0yB1q49TCephKZCTlhZAX4craolOtVm0AAAaLRFpS?=
 =?us-ascii?Q?GzNEpxgx9gQgtSv4dAEhekIo8xDia9h3QqD8/J3fvT3BZ7k2ZgYpq56HTfRC?=
 =?us-ascii?Q?oeHQT1YmyCOQfZM4upcY3Zo7l2x6pEf//kBNRUjaY4Be9pl67uibQiIZdSyA?=
 =?us-ascii?Q?wzZYNDgQOaz0SuZskSNdKjemlvLoqo4FvJYfnYPyNfyFRuO3waxpPY5V2Tyk?=
 =?us-ascii?Q?Qb8FWqxfOxKI/9r5ywxMxN2q825hOPZp5A+cbBfg6CcjYp124lsQYgqefqdW?=
 =?us-ascii?Q?sgeJvxgTYZ9415bkSmTGaEoET2ym1PHxztfuGLNuZubAn6I9fJAosZfmYbFI?=
 =?us-ascii?Q?ZsfeWE1MY6aA+lblcE7ZAwhNz0QnMSRRf0KLXEjzoIAkLO3trs1vO/RKNhX6?=
 =?us-ascii?Q?Pz3t4jMeDNuftQPRpj0SxpcoE/2bbjiYF0Nv1tTo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf58eb9-a91f-4900-4f0c-08db882e545c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 08:01:16.9886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPtk8CcvGy12etEr8FrsThkedRjdS1U4c1M7bCAUQIEJZN9BGdlVlCWgM6GbHJIF/xuFU9GrSZpcZOCbG9Zrog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8682
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

On Wed, Jul 19, 2023 at 01:18:26PM +0800, Aaron Lu wrote:
> Alternatively, I can remove some callsites of update_tg_load_avg() like
> you suggested below and only call update_tg_load_avg() when cfs_rq is
> decayed(really just decayed, not when it detected it has removed load
> pending or load propagated from its children). This way it would give us
> similar result as above(roughly once per ms).

Something like this: (I think this is better since it removed those
unnecessary calls to update_tg_load_avg(), although it is inline but
still)


From bc749aaefa6bed36aa946921a4006b3dddb69b77 Mon Sep 17 00:00:00 2001
From: Aaron Lu <aaron.lu@intel.com>
Date: Wed, 19 Jul 2023 13:54:48 +0800
Subject: [PATCH] sched/fair: only update_tg_load_avg() when cfs_rq decayed

---
 kernel/sched/fair.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a80a73909dc2..7d5b7352b8b5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3913,16 +3913,16 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
 }
 
 /* Update task and its cfs_rq load average */
-static inline int propagate_entity_load_avg(struct sched_entity *se)
+static inline void propagate_entity_load_avg(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq, *gcfs_rq;
 
 	if (entity_is_task(se))
-		return 0;
+		return;
 
 	gcfs_rq = group_cfs_rq(se);
 	if (!gcfs_rq->propagate)
-		return 0;
+		return;
 
 	gcfs_rq->propagate = 0;
 
@@ -3936,8 +3936,6 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
 
 	trace_pelt_cfs_tp(cfs_rq);
 	trace_pelt_se_tp(se);
-
-	return 1;
 }
 
 /*
@@ -3974,9 +3972,8 @@ static inline bool skip_blocked_update(struct sched_entity *se)
 
 static inline void update_tg_load_avg(struct cfs_rq *cfs_rq) {}
 
-static inline int propagate_entity_load_avg(struct sched_entity *se)
+static inline void propagate_entity_load_avg(struct sched_entity *se)
 {
-	return 0;
 }
 
 static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum) {}
@@ -4086,7 +4083,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 {
 	unsigned long removed_load = 0, removed_util = 0, removed_runnable = 0;
 	struct sched_avg *sa = &cfs_rq->avg;
-	int decayed = 0;
+	int decayed;
 
 	if (cfs_rq->removed.nr) {
 		unsigned long r;
@@ -4134,11 +4131,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
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
@@ -4252,7 +4247,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		__update_load_avg_se(now, cfs_rq, se);
 
 	decayed  = update_cfs_rq_load_avg(now, cfs_rq);
-	decayed |= propagate_entity_load_avg(se);
+	propagate_entity_load_avg(se);
 
 	if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
 
@@ -4264,15 +4259,12 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
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
 	} else if (decayed) {
 		cfs_rq_util_change(cfs_rq, 0);
 
-- 
2.41.0

