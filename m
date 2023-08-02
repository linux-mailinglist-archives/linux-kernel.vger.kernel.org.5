Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA2A76C604
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjHBHB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjHBHBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:01:25 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7141FFA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690959680; x=1722495680;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GYruOKtLQyGHSQTWZ30gWUqAX7ktyT00gHjPI7JkVxA=;
  b=P/JWwRISjfIZ3dFg69eYO2+vfIr1nzLo3UiKtwlq7YxkV4SAhYEC4jNn
   dPYo3X09edE2bxEAzdRqRQfHbSSl2I22w2GtN5KllZOuJcBaBiv7nyr3s
   yfQ8hs6QA53TAnBw7Vzj6hkiUQWaNjrooqttSmUTgGX4ygvn6dANkL4xP
   bIdDxA0y8NbH4GBQLEv8ccbDDT/0QWJF9/+jQwyR7A2nnOgEUrXG6DgCG
   LTM9N51Cfv9qn9owRiMbW7Dx7rTAQdZrhHsIvVB5II/BRq5J3e4pXLX5W
   srdn66NAOy/y7pXwjxlznZbPZkQPgtRS+AzIiNzv/E5CjDQaEUEzDPZL3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="366963104"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="366963104"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 00:01:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="1059714964"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="1059714964"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 02 Aug 2023 00:01:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 00:01:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 00:01:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 00:01:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 00:01:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETpr2Ex8i1NUb6u4MD4OG1khwnWyJZGovFXYKh3OyrwASA0LUSEeURWTQZ8nbThf4awpaiznjIwXL8Ooc1+NqRgfkf/KFsWOs3fWxi+nrzCUipNbuheL1A970tB53rnCPpCZvndRGzXdaNH9hTpRqtYqgkocfb8SWyFGXTf7viILTWeeQ9RSq11ye3FP6Mzsb+zJaCXLIChiIT2Mtr7/R3E1KB0PjO+AoNYv3DHYOq6c/FCvl6WXXk9YP7mUcgnR9Po++Mxz+a4JP8xZ2wowX9Awfq8TuLpYb6tAg7HFSZmWBSQPJcLBm97Thg9mbqSN41ngKYMAPfGEut16SQ6d5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E39qowhjVshSVK2DIO4RZgT8sA1rukP6pDUtnd7E2Co=;
 b=dzRGrC/U0rGYl3w3CZ8BugRFKD7l2uCb70IVWdVgRiE3qIAer6AHsLyGsFkmmR3aZ7QpqpgDSHOQaTywCtBhycKHyXgU0/CuovSWaVHkhklD84tT+YNKguS0dfnXg8KnNsgzHap+PIqcwdAkPZCi8sfYaqo14n/xhYmTzTRq6iXXRWUE//bvU2qNggSwvNOR2b/22+sdsxdeVVLkTdZgiWd3K6WEBp+G95fHW57ccJrkE9z2jyVMtyILfjv4QYaI5Tr2B2T9puVZ4p6b3tjB+TNlLD2Ag3guCt27N1RJP68wkuaqif397qXME3K3JccnFlDnZwfyvzL49QU5S8LxLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Wed, 2 Aug
 2023 07:01:17 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::7afe:52f8:2d9e:4934]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::7afe:52f8:2d9e:4934%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 07:01:17 +0000
Date:   Wed, 2 Aug 2023 15:01:05 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
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
Message-ID: <20230802070105.GA26783@ziqianlu-dell>
References: <20230718134120.81199-1-aaron.lu@intel.com>
 <20230718134120.81199-2-aaron.lu@intel.com>
 <ZLasCKO4KA5Pgvdd@chenyu5-mobl2>
 <20230719021355.GA84059@ziqianlu-dell>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230719021355.GA84059@ziqianlu-dell>
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|CH0PR11MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 590fa11f-51d9-4544-d5b5-08db9326448f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nClZyeZq8ObmvTbi9IemueEWcKZTCN1gZis7cFuiAs3sR02dWWpReFeOcbZRxtBap9RjB7p4UUtE+x/wPafR5p04TcfXqArDT5o6tYg7rd2ZE4RrsZ3ZaaFFY79qAeS89ybbVis63goL2rOD9yawb7q98UJRBRKfD1pUtFhF9gcRfFAneBqbY8v1TjiJQyIJyGEWlqh/P65/HBgMBLuPfHe+KdL7Ugw5uFmyUsar/Fh3wwhR70rkLag0fHSqMtPpzLbbXvo08AXnom913e3g7XfRBQN02pOutzn1kwI+78F7klwu7tm8J2yvz8MCUHkGkm5utwsC80LKiVOeewtVp6dmo0GOIybrk/pMm8TM/rjlLrVsWs0QuqfFfzeVsPxLz5EF4ZSlqOQd+jfm26b/+91fJFwLGT014V5ZDdrFgv0gn+31611PDgMDVL2jvfJQniwbCgnnztknq6yqsFsVoxAkmzGG0PQA6cV/Xc6zhxtptgSgBN2rIHXl9TjpGsEYavSFd2AuQ0ZWRVOtKi7XhELdmCom8tSfOkWL357HHQ/k9GOQquUuOzEA8fJa6SZv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199021)(38100700002)(66476007)(86362001)(316002)(6862004)(8676002)(8936002)(6636002)(5660300002)(4326008)(54906003)(33716001)(41300700001)(7416002)(33656002)(66946007)(66556008)(82960400001)(478600001)(2906002)(6666004)(44832011)(6512007)(9686003)(6486002)(1076003)(6506007)(26005)(83380400001)(186003)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?embJWe+pjGphIwVgR/IITcuIBoHAxBBRwIYWwh6x/gSKzrN1ktHgK9RWyJk1?=
 =?us-ascii?Q?9T1ESRZs1Zef5zHamvu14N7tKhih8IB0R/+6oO0mGD36uWEhUNGWuVXnrA2A?=
 =?us-ascii?Q?drBeojC2Un7G+Q3kEM3f/4wYX+6PQ5bTMkBq44oDacIdVSPr7/CG7HhjyX2s?=
 =?us-ascii?Q?uhnwF6e6cJIREYgpiLrfE8sXixCguZTdELxV1tvCPoINUjOdXOWCgs1GcDp8?=
 =?us-ascii?Q?CkNxyo1lRXfLtmWBRn0UizwDyu1BqPeQrfegfhRXZj3emSM2wWBT4XyzQhu4?=
 =?us-ascii?Q?+KtU+cIDIk0mutoLGVDkytQpG5pe+xRQ9SGHtOH/ZPDBTVls8kCnT1o4Me7I?=
 =?us-ascii?Q?DY8w7MLQh1G1Mk+xFidzK/MbeGsPNogngNCm7zBq/yDYOIAmFsmreTaLdMg8?=
 =?us-ascii?Q?DspEAXTQGdlnHRYGdGbh7ajsYNNl1nx0nDNEXvy/aPh1JGJnww4H08g3TqKr?=
 =?us-ascii?Q?1PRbi5HsCcWyGcUHrZJDrrkknlJ7fwe+m46plae6M0GaqbYtWDlIW1+TzC40?=
 =?us-ascii?Q?HofYy3D5e9AEn0ZDSs4BDJx5qCCVE4qqzedLtfntUtGCCNKiuUXmTZChVa4k?=
 =?us-ascii?Q?tuuPfqY1jIsRXCTqwbQPldj1X/eUmrA19KvFKHN2JNZNq6leyBffaflgX1+b?=
 =?us-ascii?Q?V9VlPt4Y6UJbZZ4bV6Lj5fXy490+pcD2iMMDAsPYbPqHF+wk2Q/qrMs5aUDe?=
 =?us-ascii?Q?JH7CnWebHO23vXtuNyECOQObRmjRwskrYsEUT1olUqqq436QoqJinzy5sTGV?=
 =?us-ascii?Q?xHxrjiNOfLnduxYPZPhhzHM+hawScyfpgfJ1F5GG3E1pmqzCd+3uDbFtLiHo?=
 =?us-ascii?Q?1woIZiM8jNa0vWdwF4iR3gBTc/Q9ewi784ubdzhDyeHDSDNWYgCugddk6GXi?=
 =?us-ascii?Q?wNMQEzJkNKW27uQwGZnlh1o574Mo2zBJjgrYvFu5i7Nm+Frf9xFXNiijWIEC?=
 =?us-ascii?Q?1Wa/vj/77jQk8+kbQFMnd/Cr5kyZKvyuE7mbF1gLYi5397Ibpr/I4mQpnA3Z?=
 =?us-ascii?Q?1WSuTdvVGuDtDM0zSZOLy/Nh4XGWyVrfe0pi7x9JOi4Ej6kX6UkxCtDn/xjU?=
 =?us-ascii?Q?c2ENqVskc33I9u1bwGDx+DgDhwXUQsAy4p64cVPRjpqdOeUdGl/sS+cbajmu?=
 =?us-ascii?Q?74tjCRolhHUo6vsqARJLX+gyR7TUHzeHc7UyIpMmq5tWrN1ZN0g5PZrkcrKc?=
 =?us-ascii?Q?3WdtN1daBzS/+BYecFOH38+Q9BHHwODpJhbe3bmTzBr02OAs4VgDYAMwzSAB?=
 =?us-ascii?Q?vVgGqtBI7Ik1PCT25h8oDz7iEEsbkCuNOwBfAemFDPDjgQ0p3L8dwhmLSB+v?=
 =?us-ascii?Q?myabxCH6T2IxHDbVIBrUXiSdj7Sz7xF0fcn+UFFZ3i6yK98lc+ckKZ39nxBD?=
 =?us-ascii?Q?S4jgmyqWNq/YMSCY6/pwXo+QUQlW5uadOcgI0rfAV/UGIqsEQNJfAZ8JemeL?=
 =?us-ascii?Q?BcwSqi6igdPnWIyC0I3B9SONbi6IAb2n+uNPScF53wh3gIc8j2MPw53P7wYA?=
 =?us-ascii?Q?0L1veBsVcSHXYwX1dIKrOOxql9N8t1U32rNgrLp+He7MmF7a4p8vMY8s1n4/?=
 =?us-ascii?Q?CBEJvnCANPECgi6XOpcRN+MJvnWoZ5RLV9Yw0Eb4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 590fa11f-51d9-4544-d5b5-08db9326448f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 07:01:17.3415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fbMzwe/8Fw7HSKFGpizRI7s6u4VzK1yEDxP5Yaqoc/PSwCdnVk5DvVx7rx5I6V87h39vVclObV77sWMFTMQyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8086
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

On Wed, Jul 19, 2023 at 10:13:55AM +0800, Aaron Lu wrote:
> On Tue, Jul 18, 2023 at 11:13:12PM +0800, Chen Yu wrote:
> > On 2023-07-18 at 21:41:17 +0800, Aaron Lu wrote:
> > > There is one struct cfs_rq and one struct se on each cpu for a taskgroup
> > > and when allocation for tg->cfs_rq[X] failed, the already allocated
> > > tg->cfs_rq[0]..tg->cfs_rq[X-1] should be freed. The same for tg->se.
> > > 
> > > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> > > ---
> > >  kernel/sched/fair.c | 23 ++++++++++++++++-------
> > >  1 file changed, 16 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index a80a73909dc2..0f913487928d 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -12443,10 +12443,10 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
> > >  
> > >  	tg->cfs_rq = kcalloc(nr_cpu_ids, sizeof(cfs_rq), GFP_KERNEL);
> > >  	if (!tg->cfs_rq)
> > > -		goto err;
> > > +		return 0;
> > >  	tg->se = kcalloc(nr_cpu_ids, sizeof(se), GFP_KERNEL);
> > >  	if (!tg->se)
> > > -		goto err;
> > > +		goto err_free_rq_pointer;
> > >  
> > >  	tg->shares = NICE_0_LOAD;
> > >  
> > > @@ -12456,12 +12456,12 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
> > >  		cfs_rq = kzalloc_node(sizeof(struct cfs_rq),
> > >  				      GFP_KERNEL, cpu_to_node(i));
> > >  		if (!cfs_rq)
> > > -			goto err;
> > > +			goto err_free;
> > >  
> > >  		se = kzalloc_node(sizeof(struct sched_entity_stats),
> > >  				  GFP_KERNEL, cpu_to_node(i));
> > >  		if (!se)
> > > -			goto err_free_rq;
> > > +			goto err_free;
> > >  
> > >  		init_cfs_rq(cfs_rq);
> > >  		init_tg_cfs_entry(tg, cfs_rq, se, i, parent->se[i]);
> > > @@ -12470,9 +12470,18 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
> > >  
> > >  	return 1;
> > >  
> > > -err_free_rq:
> > > -	kfree(cfs_rq);
> > > -err:
> > > +err_free:
> > > +	for_each_possible_cpu(i) {
> > > +		kfree(tg->cfs_rq[i]);
> > > +		kfree(tg->se[i]);
> > > +
> > > +		if (!tg->cfs_rq[i] && !tg->se[i])
> > > +			break;
> > > +	}
> > > +	kfree(tg->se);
> > > +err_free_rq_pointer:
> > > +	kfree(tg->cfs_rq);
> > > +
> > Not sure if I overlooked, if alloc_fair_sched_group() fails in sched_create_group(),
> > would sched_free_group()->free_fair_sched_group() do the cleanup?
> 
> You are right, I overlooked... Thanks for pointing this out.

While preparing v2, one thing still looks strange in the existing code:

int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
{
	... ...

	for_each_possible_cpu(i) {
		cfs_rq = kzalloc_node(sizeof(struct cfs_rq),
				      GFP_KERNEL, cpu_to_node(i));
		if (!cfs_rq)
			goto err;

		se = kzalloc_node(sizeof(struct sched_entity_stats),
				  GFP_KERNEL, cpu_to_node(i));
		if (!se)
			goto err_free_rq;
			~~~~~~~~~~~~~~~~

Since free_fair_sched_group() will take care freeing these memories on
error path, it looks unnecessary to do this free for a random cfs_rq
here. Or do I miss something again...?

		init_cfs_rq(cfs_rq);
		init_tg_cfs_entry(tg, cfs_rq, se, i, parent->se[i]);
		init_entity_runnable_average(se);
	}

	return 1;

err_free_rq:
	kfree(cfs_rq);
err:
	return 0;
}

I plan to change it to this:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a80a73909dc2..ef2618ad26eb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12461,7 +12461,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 		se = kzalloc_node(sizeof(struct sched_entity_stats),
 				  GFP_KERNEL, cpu_to_node(i));
 		if (!se)
-			goto err_free_rq;
+			goto err;
 
 		init_cfs_rq(cfs_rq);
 		init_tg_cfs_entry(tg, cfs_rq, se, i, parent->se[i]);
@@ -12470,8 +12470,6 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 
 	return 1;
 
-err_free_rq:
-	kfree(cfs_rq);
 err:
 	return 0;
 }
