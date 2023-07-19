Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325DE759741
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjGSNp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGSNp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:45:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3250D189
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689774323; x=1721310323;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XwKnQepFNLcWWpajhTwY0+ciWwZQoH1b9fBWE6w9+iE=;
  b=WQcjrO74E+bXBvE+DY78mtMnrKUDiI4V64LlJS0pJMlKBew8StSnCn97
   cRcEvfzOO+CebBcxTBb9Cdd/IhuT4KxDeRniB8OgcBzW+0vTSDnTQd0Da
   Ib5JZX3PKVXutkjT+8EbAiPJ0sHdkYyvot/CkRU59VFpBMvnrb/0FM90U
   qCxiMFCbW1woOmCS5bYlwO7ut19XSJph/yxHxVAIU3hcuFuvCtvBLDaPA
   0uCYfPYx1nb/OP4y9z0HEAHxi4H4NVhCpSDeFuToOwX8uk8ewtWnZIb/U
   /DYyVWHL2IQsg+ryPDF3RhgNo1mDq8Lp+QoeJlWX/PkYRsHECLNTMG6Xk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="365347281"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="365347281"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 06:45:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="789426185"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="789426185"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jul 2023 06:45:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 06:45:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 19 Jul 2023 06:45:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 19 Jul 2023 06:45:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQuQnRpcYUpFpy3L61slAJnIs+sv15aIQizZuxqhLV083TSxi1Ih2Tb11AR9ThxNMl1DgEfgjiwrehDTS12iR3laPJbzUwTlBhcBjt01jygvTtcGLgZYJJw2ssRw4Lw9CCPYpa865xM965PBGBZGkHnPy2b5ZRDecPxGUdlnnXNW3ljCi7T61CRg294khON8fjRIK/BOtg7KP2NwVhN/FA4EQspi77lVObCCh1TxSO5wJv+TMxJAFCpuBiyc+c0SxA01ndiu+GaSJ2AgesQyFCHXiZPEIWXki6OqcX46CzaWfoM1RMFvtgPlQDkxy87lvMAZggADHCTk5goM9PIAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2PSEyZMohB7EosphYjeqDhA7IiLCDvmh0osjtWch58=;
 b=Gsbl9guy5jD7iW7cPQJWGU72h0+sla2Czd0GmRI8xYvpv9Ewz2KtXJgV+tfkXcQ678AqzVdaG7Y5Z6pl01kgUdXCMPnxFDe1GFRXX7d7sJrQ8DcbTQOFgfPUymJNat0lMX/G9dF3Qa8jL/naHl0jEhiYB53iDLSfKhEWpQGhEvrFKZVo6hKBbLhbRX0lA6T0hxn3i1dmEOEqgpKwdcJ0Cgd6Cp/MtAlcbnJH0XuHFXMRruC+OUIvQlKj9LHvLvtsensubQBgGQ23VuElQGg0hAse/TTiyvNC20x6XAH2OSJV/ZMN2LpI5+yRGqO+Rvs0fmcNaR+2LGUwSC2YYa6JWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3060.namprd11.prod.outlook.com (2603:10b6:208:72::24)
 by DS7PR11MB6037.namprd11.prod.outlook.com (2603:10b6:8:74::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.28; Wed, 19 Jul 2023 13:45:17 +0000
Received: from BL0PR11MB3060.namprd11.prod.outlook.com
 ([fe80::7196:1728:580c:9eec]) by BL0PR11MB3060.namprd11.prod.outlook.com
 ([fe80::7196:1728:580c:9eec%5]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 13:45:17 +0000
Date:   Wed, 19 Jul 2023 21:45:00 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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
        <linux-kernel@vger.kernel.org>, <yury.norov@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <linux@rasmusvillemoes.dk>,
        <rppt@kernel.org>
Subject: Re: [RFC PATCH 2/4] sched/fair: Make tg->load_avg per node
Message-ID: <20230719134500.GB91858@ziqianlu-dell>
References: <20230718134120.81199-1-aaron.lu@intel.com>
 <20230718134120.81199-3-aaron.lu@intel.com>
 <20230719115358.GB3529734@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230719115358.GB3529734@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To BL0PR11MB3060.namprd11.prod.outlook.com
 (2603:10b6:208:72::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3060:EE_|DS7PR11MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa894c7-dcab-4c15-3a9c-08db885e6229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B5F9MQXeJlQyBZGa+ANGzZdxRMlauYJrKXjVMwNDS8s4A2bXgzZKchO5vd9OR5ZxuRcsxZSbFeCg9BbuYITYYo41HB63b77Eu40OEaC58i4AF2gS5/XeUBG567Lu3RIvBmSfegjnstGtbgup/ESnK7T86t6xTCJRIuk4KC2mOUcHUS2KLsSEY4Bup9rTBQIu1sijI7fAwc+K1HuvQE1yQNLG/eAPN5Rwj5LgRjcTLHxgzhJn/o6UqHDfSiJe3Piyo/GejsSzBzv033h36fBz6Y/AWeGYzTpB47DfnVJ6YtcN08QlIMDf9BeIw9jgDFgYXiBK+X5BzsllijpwalUl5zQ5+yGFgWATE/j6zdTxzTyFfMoIFh2txcotxcDtBbXEGqXGu801D3VVfdVXePViHQHs9aigY6KolHB67YQmZDkA53bwA5zrallfopR0lGYDkmJclkomiKUl6FEJXG8V9/8MUK8Qn8nirIqHKPBfKgFrdBVPTOSomofpi92A50+7RaNMbY2DhBuIFpXQhZSNBYMNJBEJaTim3DAYJqPHYEFcwnBY3pLIqC7Zn+iGzvqn5isNV0TeKPV/mr2mPETQ9dKfls+AGRNqn+xNB7ECtsQDRHafvKslf8MNDmAYGkI/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3060.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199021)(316002)(7416002)(2906002)(33716001)(33656002)(44832011)(86362001)(54906003)(1076003)(83380400001)(186003)(6506007)(9686003)(26005)(6512007)(66946007)(82960400001)(6486002)(6666004)(66476007)(4326008)(8936002)(66556008)(6916009)(38100700002)(5660300002)(41300700001)(8676002)(478600001)(357404004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NKtL09EwYtAcn6/AiiDJSYmTDcrKqu0a/D9vQNUpiiQmpNYW+RevXxr1aJjI?=
 =?us-ascii?Q?Zs3GpvxpdzIF28fm3ArkleI2jGzKieSW00xMVSF9C9SHwdeZwC9u3xMjSuV8?=
 =?us-ascii?Q?CxvfA2EJ3TGB6zrHdgqFLG8KN+fHMA6AP0UiYhG3QBiN7mIX+iFCYeuvY9GI?=
 =?us-ascii?Q?+2JqVfLObhA1wn9kAyJPiYUq0xJ/VGlLZK2c2xQlnyFJymKk5ricp06pXGoF?=
 =?us-ascii?Q?KjjmesCo2f6K56JjPmzYJX5+jXLUwKQsVCuox7RK/T2vUID9V+CSxkgHzYCz?=
 =?us-ascii?Q?USiGMxjgWWbMUMfEEkZUz2S1M7Ym68wy8Wwcvh1FUZIEwH/6tlu5GiOm4/Zy?=
 =?us-ascii?Q?nKRKoNALHhJFqAtM+i4ZqAWODvOIe0CL2ZzysqGjqOQyfxPXAYHgE3S7hsbq?=
 =?us-ascii?Q?vcxew9fMYubfbsWtZJ8eP1AOUk1VhbwBtNpjfzJH083gjQHkLwE+0yoRgJc6?=
 =?us-ascii?Q?JOf00PPZH+zfMaOVrUP4ZjPK46e6fPYkbjk207zf/mAmT2vaWZyhx+5ov5gG?=
 =?us-ascii?Q?pif8z73qwWQB/BWXKumoEjOlKk4WvFx/fXU4Gp8/CIbDZf+eTw+w46JJVmFT?=
 =?us-ascii?Q?Oq1DQ+yI2prphdILQcStAV7hufgs4hCmvArq5mIERYwXITX/r9/l4ZfGCw1Y?=
 =?us-ascii?Q?v1Mf2HZRDtcb2mjWCZCfYkbJ1E6s5z9ZbRk77cErFmW9jGiPIZCJLrLDgbz7?=
 =?us-ascii?Q?mevYZPCATd9sQQzEKwxs+ZdAq1sXPfkkRmkqj5zVch7gEf92mO2ZGzhOYbke?=
 =?us-ascii?Q?mpQn/0iQCOKWxxGkXZTzIQdNxS27aAf1kRTvtF90Rm4Mk+29mHXSbN3TBGz/?=
 =?us-ascii?Q?X8FuDHdQcSQiRkLN9gVKVQtBppvZskFYxFm3/PBaRXGqu6zcoe57QA7bIMNk?=
 =?us-ascii?Q?c4IT8x9vpkDe1y0vkWIqIwb2WKt3y9fLsgJL77csEWckLeZzWDDNHtaou1R9?=
 =?us-ascii?Q?sDi6Fa2NNX+ew2w65LwFFWVlbuekz+0xFIdETiqcrByFK2UK1xc08L7fhmOd?=
 =?us-ascii?Q?TS2ghQv1Rcar+gFCX1WoBvhBixjz4aMaWNIDpwo6E7oUg6gryE8jwbvLgtSG?=
 =?us-ascii?Q?W3CIjm+s2Bga1OCrpeKnytCDVCL2kvytJi3jVh9Rm/7oO8GanCB3iFuwJAEt?=
 =?us-ascii?Q?S/KyKWPfSigfjx0EpWQMV5ArSqSsjHuQBQjSacAoJ2MXVsvs/GgO+voh73EO?=
 =?us-ascii?Q?4JbgIFMf4mOMNzGGC6xz5GwYO3yAHRpnHgBl8dvSelzCo2ziVNCOXY9ID9dc?=
 =?us-ascii?Q?eLNTujWGpTbCF3zXz0MjLtF6fiwDJVZ81SSGl1FO04dquBhp7bv3rflZyeaS?=
 =?us-ascii?Q?kQqeaSN6INqAoH+l0GRpwLhJjenJcuWWKOmqTTanRJmvLk9FPH85olWeAoHz?=
 =?us-ascii?Q?XK4vQ6+tj6MeleFEsG7AIJFXTD2XKIT88QVFFY0ah8hDV1yY7D3PMFs3l5fE?=
 =?us-ascii?Q?7aJnToJyFUJ0y7AxAg58539ogDPo5SlyWSojJBs9disK7B3PqkcuzC4whZE4?=
 =?us-ascii?Q?89v5XBPNQyfmA3qPIOTRi8+hjlj+jC7LP0tDQX22ny8J4dYjmkk22d43BG3E?=
 =?us-ascii?Q?T9Ie5p2VIbKr1LWLCPaEfxYD0RQeVn2sSe3VU+OG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa894c7-dcab-4c15-3a9c-08db885e6229
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3060.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 13:45:16.8346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hg93QHYxhF+y4zFGF5CgeMAkjV73Y1kKaizcjO08gEwoxlW2l0l1fNUSDqIe33sfKcKdWcs9ZeN5YZ1pLmMF0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6037
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

On Wed, Jul 19, 2023 at 01:53:58PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 18, 2023 at 09:41:18PM +0800, Aaron Lu wrote:
> > +#if defined(CONFIG_FAIR_GROUP_SCHED) && defined(CONFIG_SMP)
> > +static inline long tg_load_avg(struct task_group *tg)
> > +{
> > +	long load_avg = 0;
> > +	int i;
> > +
> > +	/*
> > +	 * The only path that can give us a root_task_group
> > +	 * here is from print_cfs_rq() thus unlikely.
> > +	 */
> > +	if (unlikely(tg == &root_task_group))
> > +		return 0;
> > +
> > +	for_each_node(i)
> > +		load_avg += atomic_long_read(&tg->node_info[i]->load_avg);
> > +
> > +	return load_avg;
> > +}
> > +#endif
> 
> So I was working on something else numa and noticed that for_each_node()
> (and most of the nodemask stuff) is quite moronic, afaict we should do
> something like the below.
> 
> I now see Mike added the nr_node_ids thing fairly recent, but given
> distros have NODES_SHIFT=10 and actual machines typically only have <=4
> nodes, this would save a factor of 256 scanning.

Nice :-)

> 
> Specifically, your for_each_node() would scan the full 1024 bit bitmap
> looking for more bits that would never be there.

Yes indeed.
I'll rebase this per-node patch on top of below diff.

Thanks for the info.

> 
> ---
> 
> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> index 8d07116caaf1..c23c0889b8cf 100644
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -109,7 +109,7 @@ extern nodemask_t _unused_nodemask_arg_;
>  				__nodemask_pr_bits(maskp)
>  static inline unsigned int __nodemask_pr_numnodes(const nodemask_t *m)
>  {
> -	return m ? MAX_NUMNODES : 0;
> +	return m ? nr_node_ids : 0;
>  }
>  static inline const unsigned long *__nodemask_pr_bits(const nodemask_t *m)
>  {
> @@ -137,13 +137,13 @@ static inline void __node_clear(int node, volatile nodemask_t *dstp)
>  	clear_bit(node, dstp->bits);
>  }
>  
> -#define nodes_setall(dst) __nodes_setall(&(dst), MAX_NUMNODES)
> +#define nodes_setall(dst) __nodes_setall(&(dst), nr_node_ids)
>  static inline void __nodes_setall(nodemask_t *dstp, unsigned int nbits)
>  {
>  	bitmap_fill(dstp->bits, nbits);
>  }
>  
> -#define nodes_clear(dst) __nodes_clear(&(dst), MAX_NUMNODES)
> +#define nodes_clear(dst) __nodes_clear(&(dst), nr_node_ids)
>  static inline void __nodes_clear(nodemask_t *dstp, unsigned int nbits)
>  {
>  	bitmap_zero(dstp->bits, nbits);
> @@ -160,7 +160,7 @@ static inline bool __node_test_and_set(int node, nodemask_t *addr)
>  }
>  
>  #define nodes_and(dst, src1, src2) \
> -			__nodes_and(&(dst), &(src1), &(src2), MAX_NUMNODES)
> +			__nodes_and(&(dst), &(src1), &(src2), nr_node_ids)
>  static inline void __nodes_and(nodemask_t *dstp, const nodemask_t *src1p,
>  					const nodemask_t *src2p, unsigned int nbits)
>  {
> @@ -168,7 +168,7 @@ static inline void __nodes_and(nodemask_t *dstp, const nodemask_t *src1p,
>  }
>  
>  #define nodes_or(dst, src1, src2) \
> -			__nodes_or(&(dst), &(src1), &(src2), MAX_NUMNODES)
> +			__nodes_or(&(dst), &(src1), &(src2), nr_node_ids)
>  static inline void __nodes_or(nodemask_t *dstp, const nodemask_t *src1p,
>  					const nodemask_t *src2p, unsigned int nbits)
>  {
> @@ -176,7 +176,7 @@ static inline void __nodes_or(nodemask_t *dstp, const nodemask_t *src1p,
>  }
>  
>  #define nodes_xor(dst, src1, src2) \
> -			__nodes_xor(&(dst), &(src1), &(src2), MAX_NUMNODES)
> +			__nodes_xor(&(dst), &(src1), &(src2), nr_node_ids)
>  static inline void __nodes_xor(nodemask_t *dstp, const nodemask_t *src1p,
>  					const nodemask_t *src2p, unsigned int nbits)
>  {
> @@ -184,7 +184,7 @@ static inline void __nodes_xor(nodemask_t *dstp, const nodemask_t *src1p,
>  }
>  
>  #define nodes_andnot(dst, src1, src2) \
> -			__nodes_andnot(&(dst), &(src1), &(src2), MAX_NUMNODES)
> +			__nodes_andnot(&(dst), &(src1), &(src2), nr_node_ids)
>  static inline void __nodes_andnot(nodemask_t *dstp, const nodemask_t *src1p,
>  					const nodemask_t *src2p, unsigned int nbits)
>  {
> @@ -192,7 +192,7 @@ static inline void __nodes_andnot(nodemask_t *dstp, const nodemask_t *src1p,
>  }
>  
>  #define nodes_complement(dst, src) \
> -			__nodes_complement(&(dst), &(src), MAX_NUMNODES)
> +			__nodes_complement(&(dst), &(src), nr_node_ids)
>  static inline void __nodes_complement(nodemask_t *dstp,
>  					const nodemask_t *srcp, unsigned int nbits)
>  {
> @@ -200,7 +200,7 @@ static inline void __nodes_complement(nodemask_t *dstp,
>  }
>  
>  #define nodes_equal(src1, src2) \
> -			__nodes_equal(&(src1), &(src2), MAX_NUMNODES)
> +			__nodes_equal(&(src1), &(src2), nr_node_ids)
>  static inline bool __nodes_equal(const nodemask_t *src1p,
>  					const nodemask_t *src2p, unsigned int nbits)
>  {
> @@ -208,7 +208,7 @@ static inline bool __nodes_equal(const nodemask_t *src1p,
>  }
>  
>  #define nodes_intersects(src1, src2) \
> -			__nodes_intersects(&(src1), &(src2), MAX_NUMNODES)
> +			__nodes_intersects(&(src1), &(src2), nr_node_ids)
>  static inline bool __nodes_intersects(const nodemask_t *src1p,
>  					const nodemask_t *src2p, unsigned int nbits)
>  {
> @@ -216,33 +216,33 @@ static inline bool __nodes_intersects(const nodemask_t *src1p,
>  }
>  
>  #define nodes_subset(src1, src2) \
> -			__nodes_subset(&(src1), &(src2), MAX_NUMNODES)
> +			__nodes_subset(&(src1), &(src2), nr_node_ids)
>  static inline bool __nodes_subset(const nodemask_t *src1p,
>  					const nodemask_t *src2p, unsigned int nbits)
>  {
>  	return bitmap_subset(src1p->bits, src2p->bits, nbits);
>  }
>  
> -#define nodes_empty(src) __nodes_empty(&(src), MAX_NUMNODES)
> +#define nodes_empty(src) __nodes_empty(&(src), nr_node_ids)
>  static inline bool __nodes_empty(const nodemask_t *srcp, unsigned int nbits)
>  {
>  	return bitmap_empty(srcp->bits, nbits);
>  }
>  
> -#define nodes_full(nodemask) __nodes_full(&(nodemask), MAX_NUMNODES)
> +#define nodes_full(nodemask) __nodes_full(&(nodemask), nr_node_ids)
>  static inline bool __nodes_full(const nodemask_t *srcp, unsigned int nbits)
>  {
>  	return bitmap_full(srcp->bits, nbits);
>  }
>  
> -#define nodes_weight(nodemask) __nodes_weight(&(nodemask), MAX_NUMNODES)
> +#define nodes_weight(nodemask) __nodes_weight(&(nodemask), nr_node_ids)
>  static inline int __nodes_weight(const nodemask_t *srcp, unsigned int nbits)
>  {
>  	return bitmap_weight(srcp->bits, nbits);
>  }
>  
>  #define nodes_shift_right(dst, src, n) \
> -			__nodes_shift_right(&(dst), &(src), (n), MAX_NUMNODES)
> +			__nodes_shift_right(&(dst), &(src), (n), nr_node_ids)
>  static inline void __nodes_shift_right(nodemask_t *dstp,
>  					const nodemask_t *srcp, int n, int nbits)
>  {
> @@ -250,7 +250,7 @@ static inline void __nodes_shift_right(nodemask_t *dstp,
>  }
>  
>  #define nodes_shift_left(dst, src, n) \
> -			__nodes_shift_left(&(dst), &(src), (n), MAX_NUMNODES)
> +			__nodes_shift_left(&(dst), &(src), (n), nr_node_ids)
>  static inline void __nodes_shift_left(nodemask_t *dstp,
>  					const nodemask_t *srcp, int n, int nbits)
>  {
> @@ -385,7 +385,7 @@ static inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
>  #if MAX_NUMNODES > 1
>  #define for_each_node_mask(node, mask)				    \
>  	for ((node) = first_node(mask);				    \
> -	     (node) < MAX_NUMNODES;				    \
> +	     (node) < nr_node_ids;				    \
>  	     (node) = next_node((node), (mask)))
>  #else /* MAX_NUMNODES == 1 */
>  #define for_each_node_mask(node, mask)                                  \
