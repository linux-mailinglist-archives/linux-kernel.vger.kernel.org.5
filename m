Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45D07802E1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356803AbjHRBK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356797AbjHRBJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:09:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375913A8C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 18:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692320988; x=1723856988;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3EauyMaaeO80atCeYIwKxpQYc/uMEyV8NFZjzPNGMKQ=;
  b=CtPorsqWJ6bs9iI4nkzfwSWRIyf/FoxCs+jRmoCJHtu3ARVKMPYp8vx1
   COSulSBLwYTSmatCG4nH50cQYJvnJ09wdV75Rib//6xedtU44oY9rIog7
   uWAk/bvh8f73GX10Ed2ptp4e7XQSHO4VynGMWQ5XVa1kMVkQJXadIBZVM
   4B8KKT1njnKcSRzHLQJPomLSV5om6XN50wEw3nlXiOWbveni9berbAiS8
   udwfOq/uj+mVXzt1dwFJdfgFRTOfFZx1LjtT8s5irRaYiVTeMgTnrJB3s
   idBGkCBSa9raHMRy65GwNRSiriUvkAJsHsERAP1LnWMoA+09wzwKSPmFE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="376737330"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="376737330"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 18:09:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="981431536"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="981431536"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 17 Aug 2023 18:09:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 18:09:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 18:09:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 18:09:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTFrkn3dqD/5p3/ZRZhN2t05S4Amiaxchqged/w5+9uxY4sXs2HbUT7pWOvWk/iQTTHrf6SZG6mGscMuN+r44QoGefPgrX/65uKQVVR4D5IDB1rzeOO1QTUugmebQSYq7XJHUxCmmUUM807Gp+RUuMGTobjtx2WGXM+OOZnxk96rsSIy1e6KpcJNdgsD5qq8ZNirzkFWlx0eAZIeASxuNJThfEBFD6sn3oWEa5ZO5lLiq+hLuWPpZ5CTU3GpoqQOCR/txwxRxyQDNZ8tmUu+U/90aBf6U9G1Vi4OccBV2S7SwCOPwffqZ2oj28ODO/MaFkXlO8qsPg8YiGNorcHtQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAP+n09ao/+8cz0JoiyQN/8HJ168tr39FZzdIy6QWeM=;
 b=RA83ejQaaasZtvnC+1ba4F41C9Jt1fzM5dQoqFlF79bpdwGtgMWh+O2NpCMEPc9QVo551K/0VzZEb5FEc5CwFKbdPtxe6tZZexmAnCX95eHTG5KI5EZQIm5XZTNWNWuVBNtJRuxarhPNKFZ4wgBwRlXYjfKyHneEOQtsmbhZ1+8AjRhZ5IzYX/NTKInKYC3zWS/8lRFoCiKxR9eefQsYh2Dafts+MmI1BxNCPk/VxfyJQmX/q5fpK2AtuKWnvX4vTgsHqvyCG2JOaYoGC8gveFdDkvH4xYRrr9d17loAyTR+dq01aoEgAr+6UCH/dFp2glRK34OvB0/wHpE08VyUdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by IA1PR11MB7856.namprd11.prod.outlook.com (2603:10b6:208:3f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 01:09:44 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 01:09:43 +0000
Date:   Fri, 18 Aug 2023 09:09:29 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Mike Galbraith <umgwanakikbuti@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [tip:sched/eevdf] [sched/fair]  e0c2ff903c:
 phoronix-test-suite.blogbench.Write.final_score -34.8% regression
Message-ID: <ZN7EyZ+BLfjEJTWJ@chenyu5-mobl2>
References: <202308101628.7af4631a-oliver.sang@intel.com>
 <ZNWKuccyWnS3UJjK@chenyu5-mobl2.bbrouter>
 <ZNWgAeN/EVS/vOLi@chenyu5-mobl2.bbrouter>
 <20230814132935.GK776869@hirez.programming.kicks-ass.net>
 <bd96d883d0d1575ebbee4323f4396596adb0ad09.camel@gmail.com>
 <20230816123716.GI980931@hirez.programming.kicks-ass.net>
 <20230816134059.GC982867@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230816134059.GC982867@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|IA1PR11MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: d8ede29b-a2ab-4124-c33f-08db9f87ce7c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Zvsv2IIrG5QlwGBst+YtkPCccyUBUQvWLU43VWnZEq8X0paD23OgH21vhG7lYn7pIzDP2uEAzaTfsQV0b1hEPJFwSDcgJvNeOb+TcZQDd8HJxWZxzxSCB7rhuQyGh8h8XinU17FK99SPhBBZDJwOyabWf63uOAAro8pElXvFbzzlFrqre+A1n8e7E1sMFMfLv4PmvHAOmF6/Pnp/VSQUJoQHN36KQkC06OvHfj8ppCZNc4Ff2OgDy0Hna3D0IAVHyJpysm+nHL1V9lSfiZRsmURmbe4+P02AZLjkHYVuJlMCvq/0UhW6AudkC9KO/ATLu+a3BE3IPpns0ZZXqDxIRBjw122h8ffWReo/B6aDGqGQQLeogTDiA9w8KI3wqQu5L/knKYTH0bqe3beUj7Z3vcSaHjl6kYyRV6g8gplwPsbPnJprpmImUFxp/Dh35XfTum6PhyhenE98r6DOTe1Jr7eFzMtohf0dchYZL7TvfXxBo9rU9hDSD1gU33RP8C/KvcOaTXsNjZildrGStEWLAOI3ljphI6WI7JEoI9B6siUJ9cbpN0ykuY0hc+IPD+jt38FC3p1l7d5Dr192x5g5UgnsoYMi5awb2gHSxKkmAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199024)(186009)(1800799009)(86362001)(33716001)(82960400001)(38100700002)(5660300002)(66946007)(66556008)(66476007)(478600001)(6666004)(6486002)(316002)(53546011)(6916009)(6506007)(54906003)(6512007)(9686003)(26005)(8676002)(4326008)(8936002)(41300700001)(2906002)(83380400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zof0Ywxat0UqOSKM9UGgxVHkDVkI5thJMz8hQrCL/5PQb+cyrT4pgxjp81gM?=
 =?us-ascii?Q?P7RXFC5xGmHNvSUujWmjZ4J0+/NDOSxlLzsXakwsOyvmXZjCvzzw34raehrE?=
 =?us-ascii?Q?q4fwVniaRsBa7nnBqBIkdcOBQblCrkhBVEmC0Tf2Kw0/rjHO++aG3+5Bd9FK?=
 =?us-ascii?Q?FTAwTDDkRNU+j63re3b2WJtvKRabJI+GsgYyphD+w0IGGi4rRkcb+yIrhWEv?=
 =?us-ascii?Q?zENll1himODQjggPYdO/+MVKZFc+evFvjfJnoonJrPUasHW7UCrmz4dzbmgJ?=
 =?us-ascii?Q?EGNgqb6EFYZyCtJZhyhvnRvFZWyePkkrx3d6uJj9bET9eatxNPjDOFCUUxgp?=
 =?us-ascii?Q?RogsXaPQbY3o8OanWHWOq3NUYcS4rGuVBsM+77XoP+mBZyEj+PWyTOzK7gfj?=
 =?us-ascii?Q?gWObvyWhcO7CCOlC3xFuJQoBzKb38IEs0R8lWmKKFkignMigjieG5g9E84sI?=
 =?us-ascii?Q?aByo9LeXOEIb7sjOF4Nw2EmQEajcj/NK+/cmfs0WwtsV5RB3uPGQIhBiYaDf?=
 =?us-ascii?Q?Alx090piBRIRxlSAgR+5GCPnTmOyYiuVVMJs4rXCxO0dMarXDKZw5pBYHlXy?=
 =?us-ascii?Q?mAroAYCRfrB3uzhQkh6CaNkMwFDn1vTvOKuA93AJh3v1Aks7LhPMrguDFDv3?=
 =?us-ascii?Q?+evSheg1DWystfQk8MP+wmMyW3Pv62ejgpEnvWj4j6N0UMcpog4XSQJ27Bqa?=
 =?us-ascii?Q?hzB7R3Q/IjMPXpOBW7keNBa6QuXolhAW5lGbnFpRpqfVRiDHH4MV6bE0lRLM?=
 =?us-ascii?Q?uvT7FjMfaruOcLvv//nuodifxRtuHp8s4knoVOv3Oo1GT/UbY4KPGo4ILvr2?=
 =?us-ascii?Q?dFWhDdLdezB0rR+a5Hoz0/i2pfFZUVkTUu+Tt/qpggd3UqNKFbRFnhhaNozM?=
 =?us-ascii?Q?3o+t07djYGKiUImJo8wUkMvO60t0nnSilVChsNNQdYPy0XYmNzso2VtLIF23?=
 =?us-ascii?Q?+TSHoag8f3NbfgsDBF6yb/Zpa1nB8J5HMl4IBLa/NWzXql7PcVv1KF9IStEk?=
 =?us-ascii?Q?spoSM3V5tR1UEGdxZz89wK+pEMmcbFQi5QcADPBXrEdqRwxE0PrnIfZN6gC/?=
 =?us-ascii?Q?/zzylTMU16CJ+QsPr2+ujGwOx/Zig688Nb58jBZrNW8bXDh2wpOO/Nq8k0Ne?=
 =?us-ascii?Q?wicx3R0m3ZL8Y376fgT2YFGEQ+Qf/iiO6bP1UTKGaRdQpfpa/EkVmqRCJ0rU?=
 =?us-ascii?Q?jMrxpFP05mkaJWrCFPZAOl54dY9d42Ar5qQf9WdTgAoQY0YLurrlm898EKM3?=
 =?us-ascii?Q?QRtYUDF7YmfG5zd+pQvBsrq3nCYfd5eyBWi47NFVotknhyDqAtfaipn5O1Qp?=
 =?us-ascii?Q?VPAAussP/9qa+TqVDQ3BOY1amEU/+WDPSuxqboIXnMMiP3GLC3QUXP6btxqi?=
 =?us-ascii?Q?yLmK+RYNtZF9Bw4Xqf26QTL42CIBuPV3MSkHjJ8EyVXuzop6HWoNZEekX61Z?=
 =?us-ascii?Q?rJsPZ5+4blKL0aRKvpssv1EPHuDwUi4ZphG+mxrK+nbg4tkLpfFRTSsftuKN?=
 =?us-ascii?Q?LM0v4mAX9jkM4b66qRVgFIBtKtsJIJk0Ec6bgyVSCSj2z4XaFPEwuCIah8OU?=
 =?us-ascii?Q?ckHjZibevoxmRHgGz2Ffppcwi2MAWKUpzYjyLsFz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ede29b-a2ab-4124-c33f-08db9f87ce7c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 01:09:43.8908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0GnB/6cjVuctSbLrXTHLEO3IU7cTUIUq4qMTVp4/z6Bn8PfwjlV+NpIiERSLwKNXNdSHLJBjLvHzeuYndVKLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7856
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-16 at 15:40:59 +0200, Peter Zijlstra wrote:
> On Wed, Aug 16, 2023 at 02:37:16PM +0200, Peter Zijlstra wrote:
> > On Mon, Aug 14, 2023 at 08:32:55PM +0200, Mike Galbraith wrote:
> > 
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -875,6 +875,12 @@ static struct sched_entity *pick_eevdf(s
> > >  	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
> > >  		curr = NULL;
> > >  
> > > +	/*
> > > +	 * Once selected, run the task to parity to avoid overscheduling.
> > > +	 */
> > > +	if (sched_feat(RUN_TO_PARITY) && curr)
> > > +		return curr;
> > > +
> > >  	while (node) {
> > >  		struct sched_entity *se = __node_2_se(node);
> > >  
> > 
> > So I read it wrong last night... but I rather like this idea. But
> > there's something missing. When curr starts a new slice it should
> > probably do a full repick and not stick with it.
> > 
> > Let me poke at this a bit.. nice
> 
> Something like so.. it shouldn't matter much now, but might make a
> difference once we start mixing different slice lengths.
> 
> ---
>  kernel/sched/fair.c     | 12 ++++++++++++
>  kernel/sched/features.h |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fe5be91c71c7..128a78f3f264 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -873,6 +873,13 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>  	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
>  		curr = NULL;
>  
> +	/*
> +	 * Once selected, run a task until it either becomes non-eligible or
> +	 * until it gets a new slice. See the HACK in set_next_entity().
> +	 */
> +	if (sched_feat(RUN_TO_PARITY) && curr && curr->vlag == curr->deadline)
> +		return curr;
> +
>  	while (node) {
>  		struct sched_entity *se = __node_2_se(node);
>  
> @@ -5168,6 +5175,11 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  		update_stats_wait_end_fair(cfs_rq, se);
>  		__dequeue_entity(cfs_rq, se);
>  		update_load_avg(cfs_rq, se, UPDATE_TG);
> +		/*
> +		 * HACK, stash a copy of deadline at the point of pick in vlag,
> +		 * which isn't used until dequeue.
> +		 */
> +		se->vlag = se->deadline;
>  	}
>  
>  	update_stats_curr_start(cfs_rq, se);
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 61bcbf5e46a4..f770168230ae 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -6,6 +6,7 @@
>   */
>  SCHED_FEAT(PLACE_LAG, true)
>  SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
> +SCHED_FEAT(RUN_TO_PARITY, true)
>  
>  /*
>   * Prefer to schedule the task we woke last (assuming it failed

I had a test on top of this, and it restored some performance:

uname -r
6.5.0-rc2-mixed-slice-run-parity

echo NO_RUN_TO_PARITY > /sys/kernel/debug/sched/features 
hackbench -g 112 -f 20 --threads -l 30000 -s 100
Running in threaded mode with 112 groups using 40 file descriptors each (== 4480 tasks)
Each sender will pass 30000 messages of 100 bytes
Time: 118.220  <---


echo RUN_TO_PARITY > /sys/kernel/debug/sched/features 
hackbench -g 112 -f 20 --threads -l 30000 -s 100
Running in threaded mode with 112 groups using 40 file descriptors each (== 4480 tasks)
Each sender will pass 30000 messages of 100 bytes
Time: 100.873  <---

Then I switched to the first commit of EEVDF, that is to
introduce the avg_runtime for cfs_rq(but not use it yet)
It seems that there is still 50% performance to restored:

uname -r
6.5.0-rc2-add-cfs-avruntime

hackbench -g 112 -f 20 --threads -l 30000 -s 100
Running in threaded mode with 112 groups using 40 file descriptors each (== 4480 tasks)
Each sender will pass 30000 messages of 100 bytes
Time: 52.569  <---

I'll collect the statistic to check what's remainning there.

[Besides, with the $subject benchmark, I tested it with PLACE_DEADLINE_INITIAL
diabled, and it did not show much difference. I'll work with lkp
to test it with RUN_TO_PARITY enabled.]

thanks,
Chenyu

thanks,
Chenyu



