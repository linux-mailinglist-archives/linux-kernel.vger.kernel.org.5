Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE3B783A27
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjHVGtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjHVGtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:49:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C8119E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 23:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692686955; x=1724222955;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=t+AtwmgXjKWXDOlBYXmoWiMJtNK34R22GsozTamQWVI=;
  b=OCgeN0cymJDQ+58P9dp8bYR0RflwvERzPLDUw3JOtdnqVXIEffsvxoiD
   iBe3s8OPXR/cElf6y2FFIzEvPPSsQVqE8QMzW/4SuSEFiFDfwKrGSXOe9
   U+3/E0YmRezcLirZ9DAZNgaNkJZi4VpwfEGQRg8nuxtb8AHGFg1uwxOCS
   HVjP4NFiQYys9Fxi8XXBWiAyvqm1cqKuEUQWP7EhulKwCUjuJyNXjFEbD
   6HPbkapciy8kDmeLp3p8GGWh81p15EhPWWQL8n8NjEbKG2M9Nc3Pa5ItH
   FDBrKxFsCasB3JXcrRHUVjYAs/0MtF03A6bRCU+rsNbT4bBKMXzbi3iPu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="354126867"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="354126867"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 23:49:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="729696188"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="729696188"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 21 Aug 2023 23:49:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 23:49:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 23:49:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 21 Aug 2023 23:49:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 21 Aug 2023 23:49:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcIfgSx29ec0WbAFKwKB5AFAlYXtN3BF2q39eXywEYenpW7dE5/zdFMvVJwgGVntDe+MxgsqSpmtQUSuR7cliz0MEX1m/0Xtz48F5bplVcI2RDnskZPh5glveWkLt3sjQ31a18HxpPjMnXmWw6VBCe8bPXADn6x7bhHeROP/WAVQfAxc5sn6lpp8Kdxqp363rwMjogx/DJBU9hzecwl80wQxbw//Ezo4R2nfvPDpVoDDpDlweuDFOVFP6ZGIl1awpz912NUZ/vy6uOIwwlGtetC9Z+mXu0HZmkJO2kxwqzZZOoY54VcgjCPy/8S8YxrI+vvyceFpkLkGyC/A9KhOpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZuM9WZGrKbBlyr9XXz9qu0GNN6ax/6W+nEaEmEXwkY=;
 b=J87W6Arv9CbGC+fRQiWfeHbVLskHRAuFBny2Bj2Tc6mtXqdUOUsAyRW+JV05s088Gdv0B3ACguLCYBij98kAiGWSJ//y2Uu95UFGwIwMfrMuY+GuJvW3KU+u1pVVGPsGhkb1NT4465d7VvFNyjYObSQGeb6abDiBQg2F9hqY9fc8H6LZ7xUC4ayXDIRPBX/VrkJptuN+QDwrGWer4FlGWhA8DQcSQNwyOVH/iq6Q+q/NIF4j1FZGZpAPEBelp5K6exaANopxGISWIqgIWKj0OQcC9Ks4D7vOtBbNEQQfyUvzyae3vq7GJyb6DwJPyB9fBzUyOz2Z9zdw6dFcTpLjSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by BL3PR11MB6433.namprd11.prod.outlook.com (2603:10b6:208:3b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 06:49:07 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 06:49:06 +0000
Date:   Tue, 22 Aug 2023 14:48:50 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>
CC:     kernel test robot <oliver.sang@intel.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        "Ingo Molnar" <mingo@kernel.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Feng Tang" <feng.tang@intel.com>
Subject: Re: [tip:sched/eevdf] [sched/fair]  e0c2ff903c:
 phoronix-test-suite.blogbench.Write.final_score -34.8% regression
Message-ID: <ZORaUsd+So+tnyMV@chenyu5-mobl2>
References: <202308101628.7af4631a-oliver.sang@intel.com>
 <ZNWKuccyWnS3UJjK@chenyu5-mobl2.bbrouter>
 <ZNWgAeN/EVS/vOLi@chenyu5-mobl2.bbrouter>
 <20230814132935.GK776869@hirez.programming.kicks-ass.net>
 <bd96d883d0d1575ebbee4323f4396596adb0ad09.camel@gmail.com>
 <20230816123716.GI980931@hirez.programming.kicks-ass.net>
 <20230816134059.GC982867@hirez.programming.kicks-ass.net>
 <ZN7EyZ+BLfjEJTWJ@chenyu5-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZN7EyZ+BLfjEJTWJ@chenyu5-mobl2>
X-ClientProxiedBy: KL1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:820:c::23) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|BL3PR11MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f5ae848-cc86-435a-d6b7-08dba2dbe13c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ak1p3CM/3ZRzdVqAyxVhoGwfWrmUo4wP/WSIK8wrfsojtZCPSa99fgyKsI8/ijLnAfFZhBjwqiOzHnE6/XonUneioZIagle8m3CKeQL98WcCa1ey6m2cglKvdhT2kzZOwd1aZXWzzyXJ+WrO7sZqpKQocF9vq4QYa8ngq6GA1Y4zBD/uOKhlLvLWgpOaI9/0GkDK+NM4tIPOdpCyFEZvqWgSPyQAn+fSyWHFBlHb7TG1G3Jg8+yGfeubHKPD4ZH0NvaCGuBZ417Cic3ANRiR28IVwuYHaGnKOgnnXgu69O7TTDBDY/ZUtKAbghc0kye+1EXQdDwXBwz/FyY4jERd2MJhGgZV4Uxw7+AeCjDDJpBaylCBA3R+1AMJnoDIr4oeDSSY+QHLB4guOKVLPH/RZP0AHZgyvhjaZ98oW2f/DoZRgEnbEv1Y08ro+dpwqbTrQHEhR4L/KSqmcSCl2wYIrYZtyTlJ9mE1jaSpBrQLxbVzUkaPqrdlhv12/4+yhZ6wqqTi0NwGKxGMxyjWdZzCZWTtKPgFffxTxKGTc7z5Z4M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199024)(1800799009)(186009)(2906002)(53546011)(38100700002)(6486002)(6506007)(83380400001)(5660300002)(26005)(86362001)(8676002)(8936002)(4326008)(107886003)(316002)(9686003)(6512007)(66946007)(54906003)(66556008)(66476007)(110136005)(82960400001)(966005)(478600001)(6666004)(41300700001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3pSI93zJ7I6CGSXvx9anoPamy63rBZtlmWt1xZWGVwqv+85zj3vg/BcusyxL?=
 =?us-ascii?Q?7FBjtqahsEzSM8w82MaNzX45xFmXtNeRQFqS4h/InbMZuNWI2nt7rhg4lEjy?=
 =?us-ascii?Q?GHOf2aOGakYwufmL6LJJNPU8q9iqfzq00BUU4v7p3fSliLWbXfciBRia2qA5?=
 =?us-ascii?Q?p8w1mDvDs99eL7/trEuMxlZWGnXjOZLxTQZrzVvavBhRgC6YIKHlWqZeqBcZ?=
 =?us-ascii?Q?zeMHSpdyUCl6c2G8iU4WVxo5AstqO0rq9/gKGcUq640imG3E9VwVB+DyiltS?=
 =?us-ascii?Q?AuUBYzonphruKjY6j/0/qwWVKe/rVQxJ6Uo7+ojQPR2GcM8j3SMDNItuN/tm?=
 =?us-ascii?Q?nludqNFkhiq46RTtFgtKwN7d0eU3Q8rYlnso6qIMoK7upNha98eSEBQ5Z8zu?=
 =?us-ascii?Q?tFjW5t+YXyZ+cVyqKzpArmFQlHmOBdGgnrjzTmr+MXMNR7ehrL9VqrmUD3rK?=
 =?us-ascii?Q?cc5C/I1LOFLqnDocpEF3M0QU59ob6VbyjSDsqZWqM6/jeZw2TMbhdzbl54h/?=
 =?us-ascii?Q?JAJrVF5ClGSJUY0bTLTvsY57jDaVkJF9PQE2ti+l7tU3AmjV9C/4LDrwfrcE?=
 =?us-ascii?Q?OIFO7vuvBW1Z65EkE97uFhrCmc4Xq8KZScfLsuw+dS8NOo8bd+VB5/fhNzqW?=
 =?us-ascii?Q?dib5c7d2kaFxpbEIKj/5F2hVzqwNfYUiehC2xzrgsRPw38PsrD/wznEqCP85?=
 =?us-ascii?Q?WJIpyltn4MJWFOUFCI2mrnA0U4aOf/doe8rQXdcoJQFuBfrYF3M5poRahDVE?=
 =?us-ascii?Q?mN8dIE0Kmk1xtHriy2OW8fzYSbQ/4E1XDM49SXq6Z43ZqtoMwXcW6iskok4p?=
 =?us-ascii?Q?srIQ4Z4kFWFTHPV4g6VulMOKvwjce3/vrAkSEbG8hgzxfitCwuvYNpESqHg5?=
 =?us-ascii?Q?1tTjqVj/FNmVvqVZRN13gjI5iIk84DTZiYMogruL3msF/VhoK9RBURHKIIam?=
 =?us-ascii?Q?e1I1c77mgsXU6hHLVqOVOMY/2f3EI7nH9kN+Y8dp+Htoiqe1EbjM1e6GsZGa?=
 =?us-ascii?Q?/yKZHBJ4iOaRsvC+l1Yy9cxhnQZdojxn0/e3XxXUXrQ405uoqygw7Zf2an21?=
 =?us-ascii?Q?1wzGX/eAbrv66yNWedK+jF5fmdFJCfByyfJ+mu/nR9ln/tn39SsvUjq9PCou?=
 =?us-ascii?Q?jo6WgGxJwDePWzjXH9AAPbGXNXE+mlY27J/5xFIjY9aoBOXlKvu2HBssLA3d?=
 =?us-ascii?Q?zWi3dqveB78EKBvuNWdGS6kUTTEr2P2SrjFio0Nxg4AJyy+yTXxufYdC8vW/?=
 =?us-ascii?Q?zLsyMmQ5gLtfphfmsYTfopfXV4uzAP7I/eBlSCeXacaJHMf0fcdpqUNrAY40?=
 =?us-ascii?Q?b3PNhanLC7GLWYydanacDRGZaIEB2eP7c7Aov6z+8KKHcm+lmQiatV8VcBQ5?=
 =?us-ascii?Q?rFfi59ss22Em96cXZqLr7e3B1/ykmrAhPLdNhyBprupeclFJIqyxWLtuDeFe?=
 =?us-ascii?Q?3n5TPHKZ8XbqUGhBi7kPQryz7YpsbicZ8FHapOxAgbycdTHOXjn9YtCiQc7n?=
 =?us-ascii?Q?kDk6JTDlVsRoarV+7jsCUD2qUSAJ5dtoLsTrbwdzba3NJoiVdoej8YtD6WyD?=
 =?us-ascii?Q?oK7DghleP2U+V9uPG45O0A/PXBymD+Sj/yPosb4D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5ae848-cc86-435a-d6b7-08dba2dbe13c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 06:49:06.7024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jAcpilxp7SSaSVyiqgImrGZVxJJdMBmYIWRoRnqaxQp6yGbR7X1gL8mDi02vTt/A6rLF26Myzpr86qtg3knZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6433
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

Hi Peter, Mike,

On 2023-08-18 at 09:09:29 +0800, Chen Yu wrote:
> On 2023-08-16 at 15:40:59 +0200, Peter Zijlstra wrote:
> > On Wed, Aug 16, 2023 at 02:37:16PM +0200, Peter Zijlstra wrote:
> > > On Mon, Aug 14, 2023 at 08:32:55PM +0200, Mike Galbraith wrote:
> > > 
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -875,6 +875,12 @@ static struct sched_entity *pick_eevdf(s
> > > >  	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
> > > >  		curr = NULL;
> > > >  
> > > > +	/*
> > > > +	 * Once selected, run the task to parity to avoid overscheduling.
> > > > +	 */
> > > > +	if (sched_feat(RUN_TO_PARITY) && curr)
> > > > +		return curr;
> > > > +
> > > >  	while (node) {
> > > >  		struct sched_entity *se = __node_2_se(node);
> > > >  
> > > 
> > > So I read it wrong last night... but I rather like this idea. But
> > > there's something missing. When curr starts a new slice it should
> > > probably do a full repick and not stick with it.
> > > 
> > > Let me poke at this a bit.. nice
> > 
> > Something like so.. it shouldn't matter much now, but might make a
> > difference once we start mixing different slice lengths.
> > 
> > ---
> >  kernel/sched/fair.c     | 12 ++++++++++++
> >  kernel/sched/features.h |  1 +
> >  2 files changed, 13 insertions(+)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index fe5be91c71c7..128a78f3f264 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -873,6 +873,13 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
> >  	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
> >  		curr = NULL;
> >  
> > +	/*
> > +	 * Once selected, run a task until it either becomes non-eligible or
> > +	 * until it gets a new slice. See the HACK in set_next_entity().
> > +	 */
> > +	if (sched_feat(RUN_TO_PARITY) && curr && curr->vlag == curr->deadline)
> > +		return curr;
> > +
> >  	while (node) {
> >  		struct sched_entity *se = __node_2_se(node);
> >  
> > @@ -5168,6 +5175,11 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >  		update_stats_wait_end_fair(cfs_rq, se);
> >  		__dequeue_entity(cfs_rq, se);
> >  		update_load_avg(cfs_rq, se, UPDATE_TG);
> > +		/*
> > +		 * HACK, stash a copy of deadline at the point of pick in vlag,
> > +		 * which isn't used until dequeue.
> > +		 */
> > +		se->vlag = se->deadline;
> >  	}
> >  
> >  	update_stats_curr_start(cfs_rq, se);
> > diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> > index 61bcbf5e46a4..f770168230ae 100644
> > --- a/kernel/sched/features.h
> > +++ b/kernel/sched/features.h
> > @@ -6,6 +6,7 @@
> >   */
> >  SCHED_FEAT(PLACE_LAG, true)
> >  SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
> > +SCHED_FEAT(RUN_TO_PARITY, true)
> >  
> >  /*
> >   * Prefer to schedule the task we woke last (assuming it failed
> 
> I had a test on top of this, and it restored some performance:
> 
> uname -r
> 6.5.0-rc2-mixed-slice-run-parity
> 
> echo NO_RUN_TO_PARITY > /sys/kernel/debug/sched/features 
> hackbench -g 112 -f 20 --threads -l 30000 -s 100
> Running in threaded mode with 112 groups using 40 file descriptors each (== 4480 tasks)
> Each sender will pass 30000 messages of 100 bytes
> Time: 118.220  <---
> 
> 
> echo RUN_TO_PARITY > /sys/kernel/debug/sched/features 
> hackbench -g 112 -f 20 --threads -l 30000 -s 100
> Running in threaded mode with 112 groups using 40 file descriptors each (== 4480 tasks)
> Each sender will pass 30000 messages of 100 bytes
> Time: 100.873  <---
> 
> Then I switched to the first commit of EEVDF, that is to
> introduce the avg_runtime for cfs_rq(but not use it yet)
> It seems that there is still 50% performance to restored:
> 
> uname -r
> 6.5.0-rc2-add-cfs-avruntime
> 
> hackbench -g 112 -f 20 --threads -l 30000 -s 100
> Running in threaded mode with 112 groups using 40 file descriptors each (== 4480 tasks)
> Each sender will pass 30000 messages of 100 bytes
> Time: 52.569  <---
> 
> I'll collect the statistic to check what's remainning there.
> 
> [Besides, with the $subject benchmark, I tested it with PLACE_DEADLINE_INITIAL
> diabled, and it did not show much difference. I'll work with lkp
> to test it with RUN_TO_PARITY enabled.]
> 
>

To figure out the remainning hackbench performance gap, I pulled the
tip/sched/core and launched Flamegraph to track the perf profile.
The bottleneck according to flamegraph profile is as followed:

Baseline:
"sched/fair: Add cfs_rq::avg_vruntime"
unix_stream_sendmsg() -> slab_alloc_node() -> memcg_slab_pre_alloc_hook()
                      -> obj_cgroup_charge_pages() -> atomic_add()
The per memory cgroup counter atomic write is the bottleneck[1]

Compare:
"sched/eevdf: Curb wakeup-preemption"
unix_stream_sendmsg() -> slab_alloc_node() -> ___slab_alloc()
                      -> get_partial()  -> get_partial_node()
                      -> spinlock_irq()
The per kmem_cache_node's list_lock spinlock is the bottleneck[2]

In theory the negative impact of atomic write should be less than the
spinlock, because the latter would increase the busy wait time a lot.
And this might be the reason why we saw lower throughput with EEVDF.

Since EEVDF does not change any code in mm, I've no idea why the bottleneck
switches from atomic write to spinlock. One reason I can guess is the timing.
Before EEVDF, tasks enter spinlock critical section in difference time
slots, while after EEVDF, tasks enter the critical section at the same
time.

Reducing the spinlock contention could help improve the situation.
Feng Tang told me that there is a discussion on the LKML related to high
slub spinlock contention[2]. And Feng provides a hack patch which
enlarges the slab percpu partial list order so as to reduce the lock
contention on the node(if I understand the patch correctly)

With this patch applied, the spinlock contention has been reduced a lot[3],
and the performance has been improved to:

hackbench -g 112 -f 20 --threads -l 30000 -s 100
Running in threaded mode with 112 groups using 40 file descriptors each (== 4480 tasks)
Each sender will pass 30000 messages of 100 bytes
Time: 71.838

I guess if we enlarge the percpu slab partial list further, it can reduce the
spinlock contention further, and get more improvement. Meanwhile I'm still
wondering what the reason to cause multiple tasks enter the spinlock section
at the same time.

BTW, with RUN_TO_PARITY enabled, the blogbench has also restored some
of its performance.


[1] https://raw.githubusercontent.com/yu-chen-surf/schedtests/master/results/eevdf/flamegraph_add_avg_runtime.svg
[2] https://raw.githubusercontent.com/yu-chen-surf/schedtests/master/results/eevdf/flamegraph_eevdf_parity.svg
[3] https://raw.githubusercontent.com/yu-chen-surf/schedtests/master/results/eevdf/flamegraph_slab_enlarge_order_eevdf_parity.svg

thanks,
Chenyu

