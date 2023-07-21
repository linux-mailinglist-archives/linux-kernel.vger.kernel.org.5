Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADEA75BC08
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 03:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjGUB5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 21:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGUB52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 21:57:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC95D270B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 18:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689904647; x=1721440647;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=G2bKCmDaUIUDbV7wE8oWP/9jlbRKtEDGL3NgOz8iWQM=;
  b=iX8Ks/6NLRRJPl/8MqBovMuk4GOKB05wTGnM/aiCESXHKzJktnCmGXIW
   OFZDOUUvkO7g38WX30A9vMvEc4khrCzPPIeOJbcjRFGJ08mEX6lc04B+I
   GKyieEAtEBFoUV2PUzoJT8PzBSzn/XO0bI8euxFB3ve4GK+6cdqgsbnEg
   ABGrgxRJ+kzDSyDBuL7F++PtbzaOY4t9CJ+fKfrGtjuJizZcv12bFjxU0
   RSg28zFkrHaeSOhG7rP9L7nemEZ4ZWwvSeSY8uu/TmgGLdxsaZj+Lrk7a
   IBAPLQOYpDzzLMHV8RZiounOgCZHb+fI67rhRNJloOyEZpTZgyGIjDaNu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="430711211"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="430711211"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 18:57:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="674881185"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="674881185"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 20 Jul 2023 18:57:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 18:57:24 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 18:57:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 18:57:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 18:57:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNqZ0+33PtofpYpZwSI0DwEimgUT4WRB0OPchG5eabtjScB8Jyee+hQjXRY/ptQ5RO2Ujk1vni9hvIb2rFl43zNDRqkklws7Zim17UpBZb7e5WbiH5VxQxxtVXfo5BCuFPULSZ3oaRyoFJl/xJvw3JA6oLpkQCTmOTTYtPKQHU5bSxwG2r0fG+n/41Nn9ZBrNmJ0prNoQEW6Uuxm90bGMJZWUbnxD32yEhk+p+1GfQ9fikuo4aubdUOCxslefleG64W6CrnIMgl9T/miyZnVvogu//LnCBZknK068z6L/ULB83/jIAS8zUemUzHNF250OlpEwCUVXalfXooPTM8H1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJ0l6d8N4VUoX0Z8mn2q006/B3wSmem4hL99wPg9yo4=;
 b=UtdF1CLU7Tn85WCbchMp3r5PPnXXfs6IjlT9AZBZ/xzqe6Mafa6+Kn94F6OR5pcORZvvLkjtbu9JACkKs9i5Qd8S4PTXpzq4yeGdS6YdpSwvZPxyuWPlIX5fAr7asyid9C6ip13QrlSsbFIgyAsCdZ+noLkSzrfvsJtPmQ+WSQ2hZjpogrl1mBuS/N3aOnAYHWOjB+VoS1WwQLVA8CbNpw4qJG0YnTGnZi4E8+e3CJoDOkzxGHvovDJpENN/xLOOVbp2PSUJYVDjLzrxgthuTbPrP5bP30t1dPRTvtdOvScfon3ribGYBBFVB6OAuHeGJ3llcCMH80JQ/XvgiM8TmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DM4PR11MB6017.namprd11.prod.outlook.com (2603:10b6:8:5c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Fri, 21 Jul
 2023 01:57:16 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::104:1dc4:6843:e372]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::104:1dc4:6843:e372%6]) with mapi id 15.20.6609.024; Fri, 21 Jul 2023
 01:57:16 +0000
Date:   Fri, 21 Jul 2023 09:57:04 +0800
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
Message-ID: <20230721015704.GA212678@ziqianlu-dell>
References: <20230718134120.81199-1-aaron.lu@intel.com>
 <20230718134120.81199-4-aaron.lu@intel.com>
 <CAKfTPtAu33AN6=X82T=yOgm40S8OXi+sPcF0QyD-bYRPV=xPEg@mail.gmail.com>
 <20230719051826.GB84059@ziqianlu-dell>
 <20230719080105.GA90441@ziqianlu-dell>
 <CAKfTPtCnvOehfrz1OSW+rmkKW+28bdGw8fU+AvVrZTxkHibL_g@mail.gmail.com>
 <20230719132914.GA91858@ziqianlu-dell>
 <CAKfTPtAqpAo8Y9BdWZ-fmnyYgA8PEtFbObqWJxc-hs2Ktqkt3Q@mail.gmail.com>
 <20230720144233.GA185317@ziqianlu-dell>
 <CAKfTPtANqtEQjv2UThb5s0TPCS2adhC_14Gfv5ayAOva9Mib8g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKfTPtANqtEQjv2UThb5s0TPCS2adhC_14Gfv5ayAOva9Mib8g@mail.gmail.com>
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|DM4PR11MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 4451628e-c4f9-4c07-9c4b-08db898dcf30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9thIYzoXaMi2LvQuIcyuull/INovTsfoDb1N4Z218sWMRWA1zbzIHcD2y8mps7KHMLCb6gxULIAy3zAVeGz/wNtxdGEnrupG38zvZwxopG3ZXwIABoFUszAna5UFjfJLmbKHFpYQ8lCQK2tCCB92e688DbzEnzLOPxR3J0Y4w8bwUQQOSdNJFhlDkQIajmPTop2kxIAQP4YeYii8yCJCalq7AMAct81uITiW/tdRHSxsDO7+bwQlNxppdd+BEKwLcR+m/gtY+5QPxl6WCueslomzVgjF4OhqJLh2xa6uX2TD6CoB4M96Ua24/L7sA5corPFNLQpcChgF51tlmb/bku13GDwyFg0fGi0k85LO8MQJztf0YlYq+3FPm7LMtMPniZgooHiuD7zRWLh+SUJT8fPdtrmM+JCH45ZBAopksHSPPX5fpmigRFfaowLaeQdwaQxyyVui20f0bW7IUJ4CUS9PrYxj+GbzGVFASAMYv02RLGi6ltjczklTgjAgW/N424D+PKp2aZ9t4T011fzg78yWNTqQIex84S0IUiQdqoUoNqR7Y1PeDcdUgnMKS9gX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199021)(66476007)(66556008)(54906003)(7416002)(86362001)(6916009)(4326008)(66946007)(44832011)(41300700001)(478600001)(316002)(6512007)(9686003)(6666004)(6486002)(186003)(8676002)(8936002)(1076003)(5660300002)(2906002)(33716001)(82960400001)(83380400001)(6506007)(26005)(38100700002)(33656002)(15650500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M8di6pmblHNq1nGugen37NVhvcOp24Ph4LhDnvQfS8T5cRwCBFTellMSubaQ?=
 =?us-ascii?Q?jO7Xh9B3Gcjbzv3Gh6wmBxnrf1GVG3hHbE4q5AlZKysG6ZSasor5zUz1iBUY?=
 =?us-ascii?Q?Gd8wF9mcCbyxE+1dns6YJpyKfSTYhiJS54xf7e6X/TlCkti53iR04a8VKJf2?=
 =?us-ascii?Q?dyyikTr6YKpp1st4trP8pZZpHXiuGlqfTDXq3/unsbRP+15u2jPh10LQEO4o?=
 =?us-ascii?Q?+5vI4oQgIkTv2Oi5tC8Ypzmoue+aKXr6fEI8n50cCZMxS8D/pkECrEwjN5jN?=
 =?us-ascii?Q?DrWEcDGxt62KF3ae3g3CAHK3GyNkk5hNVGt3FHXeZrOIBH6P7MFNmcmGLRs2?=
 =?us-ascii?Q?ixCO40lrF1iHTDVRE0G5OXkCdC08PUI16ApjPq+rnVPKRKZU14Aos+whmY+W?=
 =?us-ascii?Q?tMAH1OJXXoeq7s94v40YVe07MTMwIT8YGameJktjn57GZbshrfZlt1QU33uc?=
 =?us-ascii?Q?XaVV1O99FSQIwCpb8DqEma6d13pwnmwwm2i1zpgw/b2JPJ19ER9JduXYpUzz?=
 =?us-ascii?Q?HNJmoofZCaBBj9PNdhK6DN5fVVLT15Yw/p7yEUirbD12tBqB50zB8rI+Tb0z?=
 =?us-ascii?Q?EmRIn/tTXckoOqDzYGKTWrnkGY6hr5JXnkYKCqoxdTl+WBumLwDq59uWPDcy?=
 =?us-ascii?Q?wJo4i8CJlOPYARG5EMhnHnuFfqx20OB5kQZEmvK9gBBAnFK4vfvSvXb4I6Q7?=
 =?us-ascii?Q?exypkXWFnDauNAE4+StU5MRL3qDqu0oyh1p6Rc4eeEceJd8sURWCUjsmW4z4?=
 =?us-ascii?Q?/ZxDZa79mEKUjsjBvhGol3kuB+05JkfHliOcuBxDkQLYFHq8z7yHVxpLGctT?=
 =?us-ascii?Q?2acbxGoC1HXhSRnz4crTal19D1MHHshibqsFkw+PEUWFwsePFXvmcZJmMe6W?=
 =?us-ascii?Q?EaV2hatZK3YZ0mQ24N+FJizsZGqoBPHp890tUFiuiXxGrHYhqqyoA6/KUxMl?=
 =?us-ascii?Q?2N+kpQr12dVHGeMZMBcaUsn2erQlA4T0OeFAOaaS1S5Emq20ua6+tasHLPCy?=
 =?us-ascii?Q?+di+qS4FZf/OngZZ1wSEey5NtrZG0vzX34vvAHQqwfdvgFsgkZS5JT3P8vgv?=
 =?us-ascii?Q?6J+oqqmmijDVOHgMQZo0ePp8yIp8Pk21fs4l7mpRzq7hsVsXV52dO+jYbXtW?=
 =?us-ascii?Q?SIMq7a7IAjLdpUpqbXLtVmgaGP5pi+0cY+//PFURHEfyoXDyjk4gQkNAgPEY?=
 =?us-ascii?Q?ZDtsd38JK1QE1fxobojPClh67v8+u2ZmKexDe73/sfxWatsMT0JtxGkaM64D?=
 =?us-ascii?Q?3R4A2YrKyK1lCYLLpcqRuzIUAZ2GHPSNHm902kSrITlfIKJTDidobByBJIo1?=
 =?us-ascii?Q?GwfhkCA51je8PFtrxoK5GE8p0WQfudQ7JMO2qXyoSuNZvctwmJXsJ663d02v?=
 =?us-ascii?Q?rL7+A+/+5Twuk2e+jn6Sa5GrDmYNiaw5u7G0bmWsScc6WK1wx9FURh4p2Atr?=
 =?us-ascii?Q?By+mGJ2RwVTK97m5+iOjIrmqN7LmEuABqeQQxZ1Y11o/DHYl9uftCtHNc4xr?=
 =?us-ascii?Q?PntNCJqpGCt0fAfqVRMzdHDpagWPXt/8jz0lFnHMvaYn6Jo7Vss+ObFQfQBB?=
 =?us-ascii?Q?bh1H1Q7URk+cVqzTmgtE64MBmjMImTaz56ZYv38O?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4451628e-c4f9-4c07-9c4b-08db898dcf30
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 01:57:16.5317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1SGg9CfRDoNU0wEPLWbM5bTrHxh4aqrGTaKpO1QndBm/WXnOlzg5kkvyUPOcOSRpslJwPdLrH9cuqwRVsAJXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6017
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

On Thu, Jul 20, 2023 at 05:02:32PM +0200, Vincent Guittot wrote:
>
> What was wrong with your proposal to limit the update inside
> update_tg_load_avg()  ? except maybe s/1000000/NSEC_PER_MSEC/ and
> computing delta after testing the time since last update

I was thinking it might be better to align the update_tg_load_avg() with
cfs_rq's decay point but that's just my feeling.

Absolutely nothing wrong with the below approach, it's straightforward
and effective. I'll fix the use of cfs_rq_clock_pelt() and collect
some data and then send out v2.

Thank you Vincent for all your comments, they're very useful to me.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a80a73909dc2..e48fd0e6982d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3665,6 +3665,7 @@ static inline bool cfs_rq_is_decayed(struct
> cfs_rq *cfs_rq)
>  static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
>  {
>         long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> +       u64 now = cfs_rq_clock_pelt(cfs_rq);
> 
>         /*
>          * No need to update load_avg for root_task_group as it is not used.
> @@ -3672,9 +3673,11 @@ static inline void update_tg_load_avg(struct
> cfs_rq *cfs_rq)
>         if (cfs_rq->tg == &root_task_group)
>                 return;
> 
> -       if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
> +       if ((now - cfs_rq->last_update_tg_load_avg > 1000000) &&
> +           abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
>                 atomic_long_add(delta, &cfs_rq->tg->load_avg);
>                 cfs_rq->tg_load_avg_contrib = cfs_rq->avg.load_avg;
> +               cfs_rq->last_update_tg_load_avg = now;
>         }
>  }
