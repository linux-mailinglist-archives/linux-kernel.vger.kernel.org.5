Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63353758B37
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjGSCON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGSCOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:14:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A56CFC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 19:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689732850; x=1721268850;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bCdPQfnFEEbjiaSyow3MDHTpIyWPm2QPUSEo3RtYcUQ=;
  b=kLmr3cEOhnPiUNp5dRxYvCDAnVle/E5JZhxZ5aEGqtkdlbr6H0l4miXJ
   EKSRecEtPYDw3rK9h38ju4Q4t/4p4Lu7aL551nRWaO0C7Q1pJGOPzn+In
   UF8o3ycKhbOwnBlRn34FWGSVi4cSVcvJkZlD1529Mt/fL8whbQnDkiPT3
   leHHQuL7EVhwlhFPZEEzz/O38FknQ5lHjIkLfNvCvxbwG5TIY3JfvX9Ye
   y+4Cy9w/RJCNZDKLcfuuBYGFiBdjcRncdzglEgBJNyT3ERI/ih6kTndwm
   rn1x89mxP5GW8KD1Hd1HWtAkhHdChdT+EBPUuc3xUWmke2KTW8SfsrCBH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="452732003"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="452732003"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 19:14:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="727154764"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="727154764"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jul 2023 19:14:09 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 19:14:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 19:14:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 19:14:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4KfCnaWIifk5yZNrw1xUI5v2wIClTKm/Z/W8sU4PXd5ZcYV0f0CuHYzsDKEr5yYD5DcawdbjTjjmZMpQ59Wk7z94qIYk3ZZNon69zJ409Po/83mL0XfxDAufaD1WpsN+6nXoS0TstmQQPI3C3fCO6VS5lCpju7OHdXSynRXgo2L73BgN6AwBn0sgsbk72kaasVvvGm9MMHRgxm7712coC7lpRIdVuTzmXXWaJvYr+cMV/cw3PfY0k0y2kh7Id7VVbz5J/90Bw6Zzo5FJE+VXAkmGJTd99ESlbLoF3m6UwtgX9HQsx3jqWeSsQRnges++JdWTplNfamV94YnS2GKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQ2EYYNaOIjwbyZbnYnykdSADE+Nq8KbUX3FNSe8rAI=;
 b=YpJ3HhUlqACtGFawQklhglRa5q3Cj3sbFkf4SmfRQWczxFzYf52A0UdU2RKgs0cLVUyJfJr2I3lsL+jk5rd2ZCFWIOEM8F8HJCgZB96kW6M1WnxLS1qBQ7lm9EJKz+lKkmvqsCM9L4Lr1b/uW1xpSq6wjjwqxv67diKu0pzLg8300xVIC7geWrCfyKbTp/nCFcNtR0Q2tGiKbDUeIqV7gPseVpNdAihC2YCeEZRlo4TAZOEQ3LUNjnBosjsd25iu4ahX1am6Lz5LF1ozfFDAc0DhtCpdrbPXLGvr+/gqM9DTGHH6BR3qlhg0D8V+qH4/B2Y9O01Kb5FbVBrmbGd6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SA3PR11MB7463.namprd11.prod.outlook.com (2603:10b6:806:304::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 02:14:08 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::104:1dc4:6843:e372]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::104:1dc4:6843:e372%6]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 02:14:08 +0000
Date:   Wed, 19 Jul 2023 10:13:55 +0800
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
Message-ID: <20230719021355.GA84059@ziqianlu-dell>
References: <20230718134120.81199-1-aaron.lu@intel.com>
 <20230718134120.81199-2-aaron.lu@intel.com>
 <ZLasCKO4KA5Pgvdd@chenyu5-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZLasCKO4KA5Pgvdd@chenyu5-mobl2>
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SA3PR11MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a24d0a5-cdb6-4c86-a703-08db87fdd540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: suK0iATZ+epKQPF4ybg/NC4oeh+10aU+M43a9fUdb7gXWNehWBelKbZp9FP/QX5/32pkmFZL+MJK5TiaOwKigLKOSNgBCMnVd8eFiYrJ6zxJ88shuMP8fqkHGXoNqx2efdPAakYexVF/gD/YBGxYRoN4GrEbF9z+Ddv0duc72QHbWs8dGw/Pz7IVcaMygoZcw5NQDCXanfjbWqr3pCWSDMUx+69NVTq+rxyQ5MfU5/n8CnyOtZh7Js4eJDJ3nmxBvpxF2WG178L5ijdAPSzpGnOqkTUsGFZFC8CMYPY0gsNHTuEr4mzg8PLjeN7w7urHx99lK8Sv2QoxlXANzv/XIz3sdPfRuAQnWl+1REEVRbj48lgch5NwknRB9EGaO7rD5cwvIHCrT6EPrqia4CUdQIOWfsyysfftU/k8EjiMBNslhf7MQmeSBSxYWosccmdnUbU9MaH5XnlAx+1CkL1QkYVtEq4v6NVg65iHlRFIlon1kk66ZUhq9gZImHX9lCVs3g9yWniZS1/fADQJcUhogvNFBfR5yVfTK0WkhbXNgCZuFTktKLMlYfsymvSrEjmb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(33716001)(2906002)(478600001)(6486002)(66476007)(6666004)(8936002)(8676002)(7416002)(44832011)(66556008)(54906003)(41300700001)(4326008)(66946007)(6636002)(316002)(82960400001)(83380400001)(86362001)(6512007)(9686003)(6862004)(53546011)(5660300002)(26005)(186003)(1076003)(33656002)(38100700002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DEtxvuB+ZkcOFehhqZJWrgmp+JLFNcigDTw0lC9xRgL48B0rh7hLPRHxLFz0?=
 =?us-ascii?Q?iTGo57dQ0/Xbaa2lbX9gCc7HlFqFzCKDcLyvPR5/3O9YXAxGgWgBlCQodFBy?=
 =?us-ascii?Q?254NUF0FZ+ntpPGGQpNdLW7NnVURftFXBpVckTVLcnECayDKknWqIyZFjcIr?=
 =?us-ascii?Q?ep4dEj6qO5TmhBX839BzeU1XwUbY8rgKGDOJVNeD3QK4fDws5fjs5EeHMXhc?=
 =?us-ascii?Q?tPzYU5t8XBEYmABgiOVpSIXgN4WHyzSyiR8xQMTFH7FFw3A5xiVqV4j5fEt1?=
 =?us-ascii?Q?8hHNwyEJsspBm1iaAsFxJDJ1htriAUyL9iNP8EX0sv/+NxtZe2pt5zr3/bFC?=
 =?us-ascii?Q?gc9DG8wJBGK5tUZQVWKyOM2SvpqWrR8c3PTUCMzIJf/sYO+Hvpj3I2jr0Pri?=
 =?us-ascii?Q?5oM4mIk1ka0w2Tz8LF5fjaU1fJegvGFeV31uFIZ1kuEeIUZNp2xcRzTcpNuO?=
 =?us-ascii?Q?aNTp9+4L0GXpeB1ZTsqhFV576RQ4ddjZpwTODqoEEOX5wWLPVfjf2Lm3I1LH?=
 =?us-ascii?Q?FNpcZLpQip2dPT4t0t/sCKMkLVI5u23IN49hzpvgv8t7GNDfbsiruW9tmoqJ?=
 =?us-ascii?Q?kfqPgMif4fmbBHBpS9W0P9FN1e5eeBuufrenQX7emdtI5cpLzct0KcgqN0Kq?=
 =?us-ascii?Q?Np7iXMpXqvVTHcO3nMb7uB1BbW4YZZMl9yOK7kJR3pqqs1XrgwEGF2C7ByZc?=
 =?us-ascii?Q?/DeKvyCw9liLU5viE+YjIKLkqqmEOzWl65TBaYXml1R7dXuPsTpqJLb91INa?=
 =?us-ascii?Q?Ii96nUfW0lKGBleSQsyZ8LzwSCY6cgyjLsuEPLc1r5AleI2GksLEcfH3mDfk?=
 =?us-ascii?Q?YE5oUOrjuSBKFY9N8HyN9phz64K8nDJ9SNorYGXZbodbPyU8HYJBN+AQHUW8?=
 =?us-ascii?Q?pcvGA5mgQG09U9aDIyGdtffTZR0YBEF3E93PoWxGdRwM1h/rd9IlFsMaYOe1?=
 =?us-ascii?Q?fBvC+OlrKMZWqaZC5/3XiA4QTW0eV6Ov5G9UocdEwPnqC4mEh/b/bfOFA6Ed?=
 =?us-ascii?Q?3evxGJxfsDvKvfxcU1i9aFcWy4eL2xpG44WvNNat1sabg+rTHZrsuTFi+iU9?=
 =?us-ascii?Q?oaHAXT0oNVI5tyUO6JHxX0vlOGuMfyqH5+QzUMHNFknI00JDuRVy2z9VT1Mi?=
 =?us-ascii?Q?fygeWAwdJlumEahOmk/l2cXe17kN5whnqwPSuwDH/jokT+Hu9LJuLOwoGqON?=
 =?us-ascii?Q?ZBb5SR9FT74ojNlnB5ZqhnilY4CaCwFzSoLoJdFzVHFQzHykC48q8lKQn5ec?=
 =?us-ascii?Q?D2LkWsSLJmvIon2S2DmmTqHWu03wl21u026xL/j5bpYyvW5AeLgcK8lmfyUH?=
 =?us-ascii?Q?Q/q/IhGW3WEkCs7sBGGbhqovVfmmpOXVzna6o6ewGn7q4WdaGYRqy9Lb6njN?=
 =?us-ascii?Q?s8ewgKhXB4U/thPgVxZLnoZFHunOsPkWbf4zvEgAQgbB939RB8+0Dsj0YREX?=
 =?us-ascii?Q?gu5p/rTyU+kKQ0yR1MlNquS98khs/6gch9hVNSeF+576ywkQQoeconMB0Ute?=
 =?us-ascii?Q?X9gQRnZJjm5KY4lsXTZhmvdl5c4QiamAeALrO7JixcY0J6klpuYqnMI8xnXL?=
 =?us-ascii?Q?HhOV0JxsDAvPT8tCeyK72N8EtTCfHG5cBgNRYaE7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a24d0a5-cdb6-4c86-a703-08db87fdd540
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 02:14:07.8949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Q6Lcah3dVKjoxh3PdUIIXK8cnKYcEJaOHOl9/7rsRT0fBXXBwIHYP/f5spsSLKPmir1MKgLL/YFcS8+y0mFDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7463
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 11:13:12PM +0800, Chen Yu wrote:
> On 2023-07-18 at 21:41:17 +0800, Aaron Lu wrote:
> > There is one struct cfs_rq and one struct se on each cpu for a taskgroup
> > and when allocation for tg->cfs_rq[X] failed, the already allocated
> > tg->cfs_rq[0]..tg->cfs_rq[X-1] should be freed. The same for tg->se.
> > 
> > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> > ---
> >  kernel/sched/fair.c | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index a80a73909dc2..0f913487928d 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -12443,10 +12443,10 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
> >  
> >  	tg->cfs_rq = kcalloc(nr_cpu_ids, sizeof(cfs_rq), GFP_KERNEL);
> >  	if (!tg->cfs_rq)
> > -		goto err;
> > +		return 0;
> >  	tg->se = kcalloc(nr_cpu_ids, sizeof(se), GFP_KERNEL);
> >  	if (!tg->se)
> > -		goto err;
> > +		goto err_free_rq_pointer;
> >  
> >  	tg->shares = NICE_0_LOAD;
> >  
> > @@ -12456,12 +12456,12 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
> >  		cfs_rq = kzalloc_node(sizeof(struct cfs_rq),
> >  				      GFP_KERNEL, cpu_to_node(i));
> >  		if (!cfs_rq)
> > -			goto err;
> > +			goto err_free;
> >  
> >  		se = kzalloc_node(sizeof(struct sched_entity_stats),
> >  				  GFP_KERNEL, cpu_to_node(i));
> >  		if (!se)
> > -			goto err_free_rq;
> > +			goto err_free;
> >  
> >  		init_cfs_rq(cfs_rq);
> >  		init_tg_cfs_entry(tg, cfs_rq, se, i, parent->se[i]);
> > @@ -12470,9 +12470,18 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
> >  
> >  	return 1;
> >  
> > -err_free_rq:
> > -	kfree(cfs_rq);
> > -err:
> > +err_free:
> > +	for_each_possible_cpu(i) {
> > +		kfree(tg->cfs_rq[i]);
> > +		kfree(tg->se[i]);
> > +
> > +		if (!tg->cfs_rq[i] && !tg->se[i])
> > +			break;
> > +	}
> > +	kfree(tg->se);
> > +err_free_rq_pointer:
> > +	kfree(tg->cfs_rq);
> > +
> Not sure if I overlooked, if alloc_fair_sched_group() fails in sched_create_group(),
> would sched_free_group()->free_fair_sched_group() do the cleanup?

You are right, I overlooked... Thanks for pointing this out.
