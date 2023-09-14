Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56D97A01E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjINKnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjINKnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:43:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0141BFB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694688213; x=1726224213;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yCgQntZ4PzV6I+cnKCnbXx6Wi1ABkwdqzvpmvrOuV64=;
  b=mnLmO7wWwRSp1SNiMWn/EMxEwlg1jJsUS8iAMtNxcNhcyJaOMLnfPLcw
   2myBKtIn7ajt6fbPLbLW0avuvoQJOcc2d9lxfsFzQlqIbn+7gKqZxHkDP
   3dbXrBVUYZetaZsb1+oyu3n7FPoW17CvL/3X8MQvxVJ+J0vCWrdbEDyZ8
   vzJc9tyJF7Tx5gqPcphwMHveSKFp2QvNxB4SRbugUESn5WX6CnGkYBmSe
   OPD30Nc8xFbQOX8qcgizA1j5SLjt81mGMMNVYjqB3b56pjTdQLahJP7tP
   gRP2rfeqb8tVg27LrkwuLU2cJeh8fqUO0zjzu0rWDOLVhGFTrxRaR6bUR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="359177561"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="359177561"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 03:43:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="694198985"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="694198985"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 03:43:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 03:43:27 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 03:43:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 03:43:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 03:43:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPfNm6B2kdQziWJqY3gGewNFXv+AfgZmFC1/YRzmriYMCDG/uSoqVvKfEN87KiedM6jVmpAhiijYOXTYARKyadFVVAHuaA3x6Uao9QabhoU3WQDC9XR1GOC2HCpcJDCX0BSAbh3cmrMRQi+KYu4dlb69aTzHhCalfbE+QTXSzhOQbqVGcp607MucdvoANfvuqZgDmXOJZW+R/nH+3sXxGebzK27XvVj87lhZ60sw24s0tWz6BRS93RM44fHf+AAtJ8W6XsgTGTcn9WNX9lY6FS8NXkr6YRk/n06I70ECxMr+ExPCRCYRerNO2toHXQBX3IXQAjHom72XobhP2FUdVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CIRfujQS5USoXwmVx6xahd9y5c3/TT83qSIOSrqFnk=;
 b=XjcGuKAab8JOdp9GhX1nipULQ5qzKAjGbwKJmgkEpJ6BTTqsrMIxi66c43tzU1NfEF5iMcaG8TA8Ce3OPoIvWrh4B6Mr/TNLQpqhDJOKQKz/dbQjJHpfCRWK79yKYltuyDVWR8dSomB5RClUtGo+6GNgy/0NqiZENhSGuqIGShvwP+e2+u/HcsdkMc2XTsqjTDpWBcmuZJAyfVeLEB8wQGedJCJm3HMlUtv7tOAOKnQjszugoIZtNOtcOdEWlLFjLSHRWK3GBgqyHE1kEgpqykGKHuOemhdW/bHfcqRMM4nz8dvtl3xs3f3sbDdcgqbBJnmbzURCyxLu8kLdW8DNpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by MW4PR11MB5910.namprd11.prod.outlook.com (2603:10b6:303:189::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Thu, 14 Sep
 2023 10:43:19 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 10:43:18 +0000
Date:   Thu, 14 Sep 2023 18:43:01 +0800
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
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH 2/2] sched/fair: skip the cache hot CPU in
 select_idle_cpu()
Message-ID: <ZQLjtV9TbM2KFGsF@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
 <09a7a5cb-dde5-122e-a086-5802df993433@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <09a7a5cb-dde5-122e-a086-5802df993433@amd.com>
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|MW4PR11MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ae9ff5-9b34-414a-b4fc-08dbb50f6873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sG9CqrrNLpJQ6kzqXR/NsUf/2MAIxrlcPxLsNzNAsmk59x6GVY9mvnvTqVe7IVSeGD7Nshm1NkSFBkFBYTs3C39I094dSPBktCJTEpJYubdyPBoTSRIyG0Tgu3Je+WRdojdcuEkNHe8kNbCRXWALj9kXoIT7XNeZoLCd15KRGWkWpZ8e5g8cAbMt3uinxgeDfhp2us0/0UkiXqbaVaF7s3eaDCXPWpN8ztcwz2jjj1NMTEUC74vvQScFkt+Jllod6f9GK2/wl2L76YrjOXdmIlvs7hVrdoDcDW1NgCVXFrlm3jXB+TdWeiJg3yL61KKcAeFrpSAprwxWsi/JQf1AVQZsWC+1+/vE8Qf/abqZ44ihlDjG9IjC1U+gOM99kpYNxql3iTpSa4Uf5wtnDblDnK2ZZKmTXvve4pYAPQ5nwqH//RLjt/RRGlGxdg71m7h0ArFjIzIiJzu6HXwJ/a+Q/BjkbnoO4aXCPnXcvZN+WKGT20gIeuTAGxlCeo2mOqdz5W8a9Zicc8b2ZKc1dHpqsa8o0ViezcdojMI4JI9BFqGuLl1iPBo3gyc7qW3Uzh/e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(186009)(451199024)(1800799009)(6486002)(53546011)(6506007)(6666004)(38100700002)(86362001)(82960400001)(478600001)(4326008)(2906002)(83380400001)(6512007)(8936002)(66946007)(5660300002)(7416002)(8676002)(41300700001)(316002)(66476007)(26005)(66556008)(6916009)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C84dSigUo8u7iGnTmP4cFbbrSQKjIlvYrvLDAHWQdCqHoAAB+yksE3Sl8vjF?=
 =?us-ascii?Q?0BzvH5YOB1dfmS+d+2UnjUseIjgABIlC3JInYGpE9ijlb6wI7+Y/owrLZr4W?=
 =?us-ascii?Q?39wagUrvpheN0snVkelBRsNbutTCvMCmqkXBwi60uzFCvDytEYRW3g9fpUgj?=
 =?us-ascii?Q?/koYIsqq4RAan+BIfPf9R5GzQbCGMIbCk5XXMVY5WQz1t7q/6jUsQ10cBItc?=
 =?us-ascii?Q?AQvKsopJ4i1j7+7RAN+G/MetBnIhJ/bbRblKivq7ULE8VgHKvtChlVw0gKaR?=
 =?us-ascii?Q?IfOZCDS3y8nTrZfmE0KyDABZURHAAaMDFYVlpHxGTr7XU+Hy1xFHQBMYEzVK?=
 =?us-ascii?Q?Vf2DzMN1Hg3pdLXQoLMCkOUxFIiFSDfuXpDJ9ckV1dXqbsxxRVEc0Uwptyw+?=
 =?us-ascii?Q?jqCiN4dbJmjFi9zbCD6c2ploBP4GKh8SW51aMhSpizSbr/c1xgbqiLZAtKZ9?=
 =?us-ascii?Q?RoUg89h847JpfuB/mFrdnTlnVZhsmSMA1lfdKktwcWdanBzK3/Ke9bM34Vu9?=
 =?us-ascii?Q?kAwJEbs9kYw+4JA1A1DYK1LcymlxHSTESBIc+lTXW0U/bHxlCd8L4xhyePgD?=
 =?us-ascii?Q?/I4INl4K5iPEDOiFDmUGTgoiyz2TYDC3ZNl+FrINsN10yZXJvOKUsxD3q4bs?=
 =?us-ascii?Q?twhVFXiMfdawmH/YzZSbapHLOLKjB49LKfYAwosEB4o/Lq+XfdApUByfM90/?=
 =?us-ascii?Q?WUBHZKvrPSd0vK1y41nWfRMwuXCwgFJkRUQJgs8Gckk6Kwajsqm13vLETZYv?=
 =?us-ascii?Q?m15wmJNZ4LVwUNDFM+rSx/Qw69KOUqsZsUr1yQRQMQgbcJHfZMBLAh2RjBw5?=
 =?us-ascii?Q?w98DvWwrOG0Pza1GY7XXLyd+NyWvO0szZ4yahfHX87x95z6LbdO0Rx7u0GA4?=
 =?us-ascii?Q?5Hb3i+WpUWSQE5dkGNzYDz7kRroSjgm+dC1gN9yYNV90UmBXvFItLSs0Q2sp?=
 =?us-ascii?Q?x/ftC//QJ1yoPUu4SO6+TcOPfdi+ZWFcfZZdU9XYQnzc4sljNlVlcz1BYOKz?=
 =?us-ascii?Q?L4JvvJYhtyJhiuGsUORJ7AHH6elamLz5c4+GeoZLVART/1Xvde2vQEsnsrWe?=
 =?us-ascii?Q?cwz2jGafan9G7KRirEkBngpNR3+c0drc6vrIivAtqookF+jc0PGnA7Dl+EJ2?=
 =?us-ascii?Q?m7ceN/K1f1Z3rkvN03zSxD+kxuMVwJahdZT3pU9Q6oEU7E1kLw1/nED9BqXs?=
 =?us-ascii?Q?5dqMssOt49U2xXseqUhkjG8MyBDyOrBS8upumethK+2lkKqvN9pweUY4/1JQ?=
 =?us-ascii?Q?zdPYHHt+zjqNVNQGbBp22Gcmj16JBDSmRaMz7lQkuZb53PhAXZJIi4il0qSz?=
 =?us-ascii?Q?HQc93OJR+Q+tILbXg4kizlRV03I9xMl/KCU5ZE2d2XvQDTM5AdrcgJUd2k+O?=
 =?us-ascii?Q?YvNBUMWt2IVTrrWFM4BMbsCYXJ2j/hDp+HZEAxquGonMI4yYfQK0Ssyg8/Ru?=
 =?us-ascii?Q?S6B3y47zpbcsfeTxeHX+qscoFfw6F1PspHZ375vXYiq3PCjWoNhbOi6pw6aa?=
 =?us-ascii?Q?ZArCDxhPlHdRsoDZjcvhL70w7CW1lyxEvZqIDUN8XRtziWm37XwMuux5+1l2?=
 =?us-ascii?Q?A1CaNq5K1IuJBY06C9Db4g/rG90aCdhcHqnMVKZb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ae9ff5-9b34-414a-b4fc-08dbb50f6873
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 10:43:18.5934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NTcUxdajJhbOSUqrNkvokZB3R+XN5wEhaBv2N3Vcw53uwpM+daEfYJD8+2nna7bryU+zCbFOFrWXpS4b3bx8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5910
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prateek,

On 2023-09-14 at 11:00:02 +0530, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> One question ...
> 
> On 9/11/2023 8:20 AM, Chen Yu wrote:
> > [..snip..]
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e20f50726ab8..fe3b760c9654 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > [..more snip..]
> > @@ -7052,10 +7072,14 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
> >  	int cpu;
> >  
> >  	for_each_cpu(cpu, cpu_smt_mask(core)) {
> > -		if (!available_idle_cpu(cpu)) {
> > +		bool cache_hot = sched_feat(SIS_CACHE) ?
> > +			sched_clock_cpu(cpu) < cpu_rq(cpu)->cache_hot_timeout : false;
> > +
> > +		if (!available_idle_cpu(cpu) || cache_hot) {
> >  			idle = false;
> >  			if (*idle_cpu == -1) {
> > -				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
> > +				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr) &&
> > +				    !cache_hot) {
> 
> Here, the CPU is running a SCHED_IDLE task ...
> 
> >  					*idle_cpu = cpu;
> >  					break;
> >  				}
> 
> ... but just below this, there are following lines to cache the idle_cpu:
> 
> 		}
> 		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
> 			*idle_cpu = cpu;
> 
> Would it make sense to also add the same "cache_hot" check here when we
> come across an idle CPU during the search for an idle core? Something
> like:
> 
> -		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))

When we reached above code, the following condition should be true:
 (available_idle_cpu(cpu) && !cache_hot)
because the previous 'if' statement is false. So I guess we already
has !cache_hot ?

> +		if (*idle_cpu == -1 && !cache_hot && cpumask_test_cpu(cpu, p->cpus_ptr))
> 			*idle_cpu = cpu;
> 
> Implications with the above change:
> 
> If the entire core is idle, "select_idle_core()" will return the core
> and the search will bail out in "select_idle_cpu()". Otherwise, the
> cache-hot idle CPUs encountered during the search for idle core will be
> ignored now and if "idle_cpu" is not -1, it contains an idle CPU that is
> not cache-hot.
> 
> Thoughts?
> 

Yes, agree, we want to skip the cache-hot idle CPU if that entire core is not idle
in your case.

thanks,
Chenyu
