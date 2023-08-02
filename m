Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB97D76C840
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbjHBISX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbjHBISS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:18:18 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A140610D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690964295; x=1722500295;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bevE71xwPz+n+m/yN+pDzi/f/076y0yTrAezT5IcJAU=;
  b=R9hApmYXOgHb9vQ7Ez09XHszUaAS/XSfFzl3op4chok5+jLKLQE0sdqe
   L62LKY60v/OUhGzZFJK/Xr03rqPT1mquR4GGDhj74MxQZ14jsT1qwt8tA
   rPpzKK7Qyz/EDHETWD352l1P+Vi9Oq1uQsWx1TGbhOvKe5rNf8uz4Jw4A
   VxKdckW21DGr036QmMjWlvkCBmqcLNr82BdIHLKkJNGhPMlf2Emfrdcok
   putJFNOp9UIjFv5VZYYwMcJffPe9VvQ/atX4VTlNqkATTy4qBUjTnVIaB
   ANnu07z1MUtUvmY0ipc6jOWMRWUNW5xi7AEW6uelJYK7d+dhtw5qOHBy5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="368414507"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="368414507"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 01:18:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="732294538"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="732294538"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 02 Aug 2023 01:18:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 01:18:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 01:18:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 01:18:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzmgWRcicifDAosHC8P3vqC4Wk0PRJEiOk8ACPcvpXMQy/GjN2YFsUzqafuApJ7k4jlb6n5hueHm9s8imTD1Keuf5ntNRvmdrYRMhQfYUc0VV59Y1i5ScF2hfuICHJDUOFXsZNcku8aPVPQvuxsGRX4wtt3UpGc40RCSq1h08A7dGVmdLZTiiw274esE4B9O3vKJIAMYHVYGat9Q2bfEfGY7gFwj23+M6TOGU5jZNnIeVQsB9PTpr8FQrdFdJqSceq6fQGI6q3Pb27BRc2wbE3/ta783PRposzjlUPOWPYPlckbyOKhUS8MsnHaEAFmKz09wzgU+C/vsP6CsXoLD6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEZwhBgh1sNAiBYZUA9o5jUowU4WMvIRz/5dFkvqvNA=;
 b=EPvfOFXQrOjd6wrW+RXMlzgsEJNEidy8XI35s/51Q6/Bchm0A67KQhg63iBbbikDSGsMFjTQ/6fzl816c0oZRC2NtHySXtpXIGlik2kbhZ7ls686u35TkdGvCU0LTOlCXwJWxiC2pzseP+ZQ2SHsAKif2CR61gUJNtWUpsmhuq2nacI+Og/4d9Yi79CrR3/EB7lc2WlVHqMfL1F4JocSPCloKE3XMc8ZS3QHMev8rIrD8nCG8Gze6qAqV6BW4r4j0XZiMhMUDWN+cNQuiyv4TQNbijOURZbg7SQbwhhmhaNzztAX7sfDTzd5H0VzgLKPQyTfhMsxmVXUvOBuYg/gSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Wed, 2 Aug
 2023 08:18:11 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 08:18:11 +0000
Date:   Wed, 2 Aug 2023 16:17:55 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Aaron Lu <aaron.lu@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Valentin Schneider" <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Nitin Tekchandani" <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] sched/fair: free allocated memory on error in
 alloc_fair_sched_group()
Message-ID: <ZMoRM42aloCNhXpU@chenyu5-mobl2>
References: <20230718134120.81199-1-aaron.lu@intel.com>
 <20230718134120.81199-2-aaron.lu@intel.com>
 <ZLasCKO4KA5Pgvdd@chenyu5-mobl2>
 <20230719021355.GA84059@ziqianlu-dell>
 <20230802070105.GA26783@ziqianlu-dell>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230802070105.GA26783@ziqianlu-dell>
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ0PR11MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: 4941e683-e93c-4aee-b88f-08db93310295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hLz/kvZn4afIC9/0Pym7AfEOTS7d0cDK928stlL9uhZOb4ZQ29+fZftzcmJIYNnzaxnkg6CwxNFnY4aoXpzSWaWnm1nbsHg4B7Qb7ReDaoA6Pc4hF9NrOj/nF4Df9i902KZXEdVQPpOOxx7MPrNKXRMPd0HQOIDrxMgYet6HxhDf9fLaC45/zC2BJrc1X3VYknUEMDX5IcOZc//0vwK8Qdd8dVQ1DCNFDwEVXoOb849s20ZQqrY1rHDsDXJ0KRx0V0ER8Ozxe3Ov3vEVJtQDZ2gemHcYudgC36/PIl4iTuWXlpvi/PyRbugu5MgYjVN30+I+FaP3t70srbCEiekJ2fOYruhSsygTZk5G6NRb3SCSMzUSiP8qRIBsPlg34fj0t6MsiIIKgUDUmxFwmZk9cWKjtGBG1mNK+dDjHbXgbBKnJTnC/MAla2K2sq7YJUA28u2pZ0fFEfCKsj3QUlPvToOjwUEmTaWI+bx6OLfc6n99YRRsNrTr/ZViVLmXOefeF+3BMEu2AGR9PF5RaVJcxrgky70q5SpsFq5W8sukWuRhzJKwhBdG4jkKdO+jabkt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199021)(82960400001)(54906003)(9686003)(6512007)(6506007)(26005)(6486002)(6666004)(8676002)(6862004)(66946007)(8936002)(5660300002)(66556008)(66476007)(53546011)(6636002)(4326008)(33716001)(2906002)(83380400001)(41300700001)(7416002)(38100700002)(86362001)(186003)(478600001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/skZiDML3p2R7ZAg5pfnOFtwak4eTERk7tgixCErPTWxXRCRYnG9SEglH8SF?=
 =?us-ascii?Q?L9EP0ikaguV0j2VwJrdFSrJ+syb21hJBGV00FqDJATfOtM6433qTO+H366Yx?=
 =?us-ascii?Q?Txg4OSkd41V/7133qUyZFx1BbBWzXyS2YIhI818YhHcsvoA1HdTsL7WVnMkf?=
 =?us-ascii?Q?qE9iCOy/QlQMBEykq7qjw0ZiOv8QxmGyLQf/jcWJQz/6eC3asE5V0HVzORYg?=
 =?us-ascii?Q?NgkwAA2YaiC0eyMjxl1LUSMLNL4D6xJvMe1pLSRIvdVMkuc1UZjNWPbNPQw2?=
 =?us-ascii?Q?+hndoAZinuUBrw6h4AqT8HiAc4T4lVSGOIg3/KiuFL//EQTGQgXJpmzGFDWM?=
 =?us-ascii?Q?9KzBpyOaOXe6KTp8+v4AeCc3J9y3ZSTcF6IubHQbLH59XdB+kVlqTqjnQIBX?=
 =?us-ascii?Q?Q2pQ80g0eNV6HjTuO1QvA3AfhTVCiKYm+6d0iCBBQ6RJAUBm0kLNDxFze6fM?=
 =?us-ascii?Q?cLT1efwlHeBKnr5NR9yThAvInb8I9E97fF23PSN0TfGDmqnJkrmmYxX01Pfv?=
 =?us-ascii?Q?RlYzNp2UFWgT33lqQFRHhQPIpwKhPmhkxBhaHYI4kBPcSkc5xhAIIBHk1uPq?=
 =?us-ascii?Q?VDECgV61WgLWPd6H2uA3F8u1KY3xZ9HEzJRkusUF0XgFaAlHhDXzIbqP6uVf?=
 =?us-ascii?Q?SAv36oEtlnyTLdVLIbI2ZfXWh1LMx3T62qOzGNmJaRZjA6Qudcyyz3JI1tha?=
 =?us-ascii?Q?J2gq/g2SA6TXVhOapkBpTvdEgt1L5G4Ux11coOwu7FRkrQ81IK6NRqqw6LNg?=
 =?us-ascii?Q?T5GVIk9UXZ0ImgnWr4pDjjBHll1ywlkrBAF77NmPt7CWxlsYBqS/2OaMz5cM?=
 =?us-ascii?Q?FSUcXG9Kny3TsD/uiHxvBzhuYS2betEGQT1MhSkzeWTlJBbwxV8F8PgebWRI?=
 =?us-ascii?Q?f/YqR93z8wtUjcae37SRantg5bBVs0KYBRxmulSTLG3lTBlFQEAaYtwWwhz1?=
 =?us-ascii?Q?K2Oqfb+WiG/7jXcEsAUT4mUffrU+UTk2YeZjBYZ0A0HuxdPe5Cf4DeSb556E?=
 =?us-ascii?Q?iWjzM8Mrbfup8byTpJi6lXv+rIuc6GPJoMkfZKKSy46xHtKElCveFpIMaYzW?=
 =?us-ascii?Q?gQ9RzWuwlzRFrCjcU96LLMfIVLEqJ/TJHWDHGc7IfGvpQqWloA+PDMIOvaBc?=
 =?us-ascii?Q?sRbDioKeP7QDiyRv+VxlgQZVBAzRPfWXczRCO/J4fMx+0XuOAX3gYFYSr7hM?=
 =?us-ascii?Q?PiG4/kBNH5yIUKgbacjz0N5Ejq7bYmTiIMFF/9x04hB/dKxiOYY9omB9erZk?=
 =?us-ascii?Q?XQwRBQ8Q1yh6wchMQiTrqomED+yUAdNPI3hy0Jl0afm/XUxyPe9hUrNCfJ49?=
 =?us-ascii?Q?rVlNvxnBMeIROW4gXEm/DZRyNIuB7sw/Xsv3+84xW4PeWN3bDpdKE7fBfJYp?=
 =?us-ascii?Q?ubs/fpit5sA8CtP/LuuS73dIX3U5wfFdURi19MbRX0aoYErsjelA/Z8KD80L?=
 =?us-ascii?Q?U8CkmQgOSsiC4u7GulwvPEGH07Zkmwnbu4tjrJ/vLzQhH1i8QBZGGHC24S57?=
 =?us-ascii?Q?kvPeBkma074tdoUp4vbq2l77hw3TBcIjLUjIQFrKnawFPVb5jxLXZwfP9bFu?=
 =?us-ascii?Q?NH07brnxebR5qqQKqeDlo5b6oNvtm/8FeseizK1C?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4941e683-e93c-4aee-b88f-08db93310295
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 08:18:11.0920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FftdylP/EPiiOTVDuQ6vmOZUxPBLUc1W4r+7+Lb79yn//WJNuBLuoq6y3B8ancsu5ASHlpD1+GKS2bCf3rNvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6622
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

On 2023-08-02 at 15:01:05 +0800, Aaron Lu wrote:
> On Wed, Jul 19, 2023 at 10:13:55AM +0800, Aaron Lu wrote:
> > On Tue, Jul 18, 2023 at 11:13:12PM +0800, Chen Yu wrote:
> > > On 2023-07-18 at 21:41:17 +0800, Aaron Lu wrote:
> > > > There is one struct cfs_rq and one struct se on each cpu for a taskgroup
> > > > and when allocation for tg->cfs_rq[X] failed, the already allocated
> > > > tg->cfs_rq[0]..tg->cfs_rq[X-1] should be freed. The same for tg->se.
> > > > 
> > > > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> > > > ---
> > > >  kernel/sched/fair.c | 23 ++++++++++++++++-------
> > > >  1 file changed, 16 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index a80a73909dc2..0f913487928d 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -12443,10 +12443,10 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
> > > >  
> > > >  	tg->cfs_rq = kcalloc(nr_cpu_ids, sizeof(cfs_rq), GFP_KERNEL);
> > > >  	if (!tg->cfs_rq)
> > > > -		goto err;
> > > > +		return 0;
> > > >  	tg->se = kcalloc(nr_cpu_ids, sizeof(se), GFP_KERNEL);
> > > >  	if (!tg->se)
> > > > -		goto err;
> > > > +		goto err_free_rq_pointer;
> > > >  
> > > >  	tg->shares = NICE_0_LOAD;
> > > >  
> > > > @@ -12456,12 +12456,12 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
> > > >  		cfs_rq = kzalloc_node(sizeof(struct cfs_rq),
> > > >  				      GFP_KERNEL, cpu_to_node(i));
> > > >  		if (!cfs_rq)
> > > > -			goto err;
> > > > +			goto err_free;
> > > >  
> > > >  		se = kzalloc_node(sizeof(struct sched_entity_stats),
> > > >  				  GFP_KERNEL, cpu_to_node(i));
> > > >  		if (!se)
> > > > -			goto err_free_rq;
> > > > +			goto err_free;
> > > >  
> > > >  		init_cfs_rq(cfs_rq);
> > > >  		init_tg_cfs_entry(tg, cfs_rq, se, i, parent->se[i]);
> > > > @@ -12470,9 +12470,18 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
> > > >  
> > > >  	return 1;
> > > >  
> > > > -err_free_rq:
> > > > -	kfree(cfs_rq);
> > > > -err:
> > > > +err_free:
> > > > +	for_each_possible_cpu(i) {
> > > > +		kfree(tg->cfs_rq[i]);
> > > > +		kfree(tg->se[i]);
> > > > +
> > > > +		if (!tg->cfs_rq[i] && !tg->se[i])
> > > > +			break;
> > > > +	}
> > > > +	kfree(tg->se);
> > > > +err_free_rq_pointer:
> > > > +	kfree(tg->cfs_rq);
> > > > +
> > > Not sure if I overlooked, if alloc_fair_sched_group() fails in sched_create_group(),
> > > would sched_free_group()->free_fair_sched_group() do the cleanup?
> > 
> > You are right, I overlooked... Thanks for pointing this out.
> 
> While preparing v2, one thing still looks strange in the existing code:
> 
> int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
> {
> 	... ...
> 
> 	for_each_possible_cpu(i) {
> 		cfs_rq = kzalloc_node(sizeof(struct cfs_rq),
> 				      GFP_KERNEL, cpu_to_node(i));
> 		if (!cfs_rq)
> 			goto err;
> 
> 		se = kzalloc_node(sizeof(struct sched_entity_stats),
> 				  GFP_KERNEL, cpu_to_node(i));
> 		if (!se)
> 			goto err_free_rq;
> 			~~~~~~~~~~~~~~~~
> 
> Since free_fair_sched_group() will take care freeing these memories on
> error path, it looks unnecessary to do this free for a random cfs_rq
> here. Or do I miss something again...?
> 
> 		init_cfs_rq(cfs_rq);
> 		init_tg_cfs_entry(tg, cfs_rq, se, i, parent->se[i]);
> 		init_entity_runnable_average(se);
> 	}
> 
> 	return 1;
> 
> err_free_rq:
> 	kfree(cfs_rq);
> err:
> 	return 0;
> }
> 
> I plan to change it to this:
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a80a73909dc2..ef2618ad26eb 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12461,7 +12461,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
>  		se = kzalloc_node(sizeof(struct sched_entity_stats),
>  				  GFP_KERNEL, cpu_to_node(i));
>  		if (!se)
> -			goto err_free_rq;
> +			goto err;
>  
>  		init_cfs_rq(cfs_rq);
>  		init_tg_cfs_entry(tg, cfs_rq, se, i, parent->se[i]);
> @@ -12470,8 +12470,6 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
>  
>  	return 1;
>  
> -err_free_rq:
> -	kfree(cfs_rq);
>  err:
>  	return 0;
>  }

It seems that the err_free_rq was introduced in
Commit dfc12eb26a28 ("sched: Fix memory leak in two error corner cases")
The memory leak was detected by the static tool, while that tools is
unaware of free_fair_sched_group() which will take care of this.
Not sure if a self-maintained function is preferred, or let other function
to take care of that. For now it seems to be a duplicated free. And
alloc_rt_sched_group() has the same issue.

thanks,
Chenyu
