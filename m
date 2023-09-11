Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF08379A466
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjIKH1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjIKH1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:27:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42E8109
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694417214; x=1725953214;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hDrI4iOxsOirKbtNfEckLPyh/kfiY08VXBIchUzB8mo=;
  b=FIcR+42u+YiuSNA2+LPbS0PM3xUO0tXERShSPpwP7SagBHDgZ9rvZxEC
   V3sGDus7GhMD11KXAh1X7ZSDP3lQ9ZEClrvVz8xkUP2bllx/kewo7/rFx
   r5y7ocMFqfPN/SD1QBNKafXX3fKf+oB+aDBxovoYGxh+pw9J7NS/7h8o+
   BFX76Ub1mX3hdwNojcK0u1XggTnHFb0l/i45Pf6J9VE1IoubCRzPm105l
   iIrZnO6DJfXaTn9EDQNh5tDe9ijAQgQesSu3CNSw2+Ejw8PJP+Eir5Nsm
   +6XKKLHphtDNbH/sF3cykTa8P4N7tWeQbA5X9BksFEsu1+CXfAzi9k5Zf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="357459950"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="357459950"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 00:26:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="813267858"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="813267858"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 00:26:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 00:26:45 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 00:26:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 00:26:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 00:26:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFv0ye0b9gnNsFFiwCo2uQS3+2lZ+nKA1TVqPkaJ1Wv2ltPH3nLFuucmb6p1aJgUag8bRD75XQLLoRYczO7sv3/ufiiSJ+4uxlEkFNp9H8a/6yDn8OfyLi1xa8Cp6gvZd+wgOht4tIcR65fkQvFP19jl28Ofean/0ddWW4rvxgCmreZl7WRy2SCzPopRQmdsbkbYs1Y/xdJbVuzNudn+IfCisdBj7cnA5XYrJ523dLEMpThPKQwJD2IdIIvzZcaJRH7VamVja/gBWOo3CeWq2HsJpDFCGBaTUn8Rj81cOfPwKlkPBW5nbri6AsmmlQmHfVKV/kHgi8aQpn/OWO3TPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsS6Y4Z5PGWCkp0vGiXOybm/F4HnKncCgqWcFpUbSGs=;
 b=axAfgZd2F1whIrZrSPlsuhpdOlbHH7LHGyweucrs2RdwHFEx4FlhgERFUkPBr4JvG3Fo63HbIzm41MHEhZCoyBadCLt+W28GmhSC/Ui0Gn+bedeEHpfxWR+i70Pm4XDqPYKIrhEhBYHrOYwS5j10+kaQLZMN6k7OPxF3+xnqpgqIm9nuY+gAtms/mVMVwqcvUogJtty8dhicPNMCGpJt5Zywzk8+jz9xrCvrxV8yRrgSXvDO5cyTjk/G152Uf/g99XKzUQxx6LI2tFIkntfBnu+dAUfXKYOltOZs0d3zwZw3nc8d+E6nHfLv72d6D2kpCt3e5v9IGMvu8018RHgJ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by IA0PR11MB7933.namprd11.prod.outlook.com (2603:10b6:208:407::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Mon, 11 Sep
 2023 07:26:43 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::d0db:d23:1d85:ed85]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::d0db:d23:1d85:ed85%4]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 07:26:42 +0000
Date:   Mon, 11 Sep 2023 15:26:29 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "K Prateek Nayak" <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] sched/fair: skip the cache hot CPU in
 select_idle_cpu()
Message-ID: <20230911072629.GA298322@ziqianlu-dell>
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
X-ClientProxiedBy: SG2PR04CA0190.apcprd04.prod.outlook.com
 (2603:1096:4:14::28) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|IA0PR11MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: e9546dc9-bc7b-4128-7329-08dbb2987232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uubUVYe9OkkAEoGCluFc1oXWAZCjDrgpCK9z8/xHlbTG2O9NxyB+dACv8TF8P4xDPO3M24H4eTnVNG3/F8yYGgiDdCX2EPFsd0GWS/o5eMMTUMMdrE23qMdpSbP7KXgUnKtFCckFYXH2K3WKSvta3ZDpCTiv9N3Q55iQXQt3YN9WAKGvuETsiYmJrmDWBiA+CK86jAFVu5/RH7rhc9SrP89JHHo9KuTGQVRtnafiQtZaA6ektGNDY9OBFpbxYBHFE0pUyVtBgdtSlH9BgVtb6xwM+2j2PVL3qKf4xvVAwqqwEj6BQSc3xq+lFsKDbinOR4NX9usZvbTnwcWv4hHf6uEl+/82WYf+lqwkDKE9lu3EqAqPEz7A2UdEgIPMowf5E6WrUU+3gW//Q60O+sWXYnN1AEAH/b492cKpSRdk7gfTtUKD8rNrQAj10f7bHFFdFUKUxiXfXNFunOIVqM1STLXCtluByazmacrrqiM8aB8GX2Vapjps9SyEBDnXdFFIlwdGSr8+Xaoj1eDTke/qAnMPyeekVn0F5zVI5wqWNk0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(136003)(39860400002)(366004)(396003)(186009)(451199024)(1800799009)(6486002)(6506007)(6512007)(9686003)(6666004)(83380400001)(33716001)(86362001)(82960400001)(33656002)(38100700002)(1076003)(26005)(316002)(6636002)(7416002)(41300700001)(8936002)(2906002)(8676002)(6862004)(66556008)(54906003)(4326008)(966005)(66476007)(66946007)(44832011)(5660300002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lEjgfKAKKMfl6ggu3VfucihLUVRBq3442UDBy7GupT5acMiz/8z9QZhTZDQh?=
 =?us-ascii?Q?mHvP4Kl1S4wvv3q0FDY26Ui2otWq4n2x0smmAlCDzTd7cpSnOyNjOVjD78Fn?=
 =?us-ascii?Q?ItNpa3KjgRVhhsm9AYqMncpVUqJowfusUsf7c0jDcChEqZ5nfvrryJu+Bpih?=
 =?us-ascii?Q?ZXNnM3ESlB9QXsakjkudYe26RfL3Bj2hzApLyZ/Xk7Rs2CUGdKabZozlosH0?=
 =?us-ascii?Q?0jVhJbpyN2GFKd3NBoMwL51dGBgZ/0c7duESZliv07BHirHQP00g+FzaCSwA?=
 =?us-ascii?Q?BrNF5IBoGrGm2Q6tJPVHklYTXq7+X15tiOR2VEOuBdSMDbMmy6D0dMYsO0ip?=
 =?us-ascii?Q?BiXeQuCRpdyplxDeMGov2ejHo9b4I1T0w6AeTwKUtNoyZzs5AQUJaMAOVta9?=
 =?us-ascii?Q?euggq9GBRZs1GIIG7cP2O+Mklu4SdgvIV19LHzXPmSScOPTQ3G7f4kt9trXz?=
 =?us-ascii?Q?sxzjKVwpi9ixQ5NciXciNubQlTx5wdW60mM+2I3mujbAUBCp6SIUe8qfRs/f?=
 =?us-ascii?Q?s4VZFE6Qv6UonzQuI96YTumh0aPSKdxqIbTh4eHx2U2CqBnMduI3OXjDaau5?=
 =?us-ascii?Q?jrgdTT2BSnBWf4ChxAj/ounSj++xOrXWfQUJPZVe1GFJjXR0itXNntWG+44i?=
 =?us-ascii?Q?m0jUfwYVAXWWTUAZO5ID7X94bDWGOFG6mkTYMCnvgCXRx+NGinOl+D66rmXp?=
 =?us-ascii?Q?4EYFX8YkTy2cGegSixuJsQmY2flg9HtDqUQOLLZBhVQqOvqIe8kNUlFuS8mf?=
 =?us-ascii?Q?9ZG+Cg8QAEtZA+ryTh3pkSu27bz0muWYwvx/6WNtyqjczSg/Ug5UDJC1ODyY?=
 =?us-ascii?Q?S9Rm37QzWMP0ocw2hholLu+uqccAWhfMNOjJ8JmiQ0HieljZ2aYoopIFPdop?=
 =?us-ascii?Q?0QX0FKLZdIEPtsV8MIQ1Dpj6PrPd3Z+pYvyaCBU/Y8XTbJ8bkuqdV6yHzl3b?=
 =?us-ascii?Q?LgIS4KCmz44vAwD6u6dj1RBepELqLMVlPPfzxYGlkbnbzB8PfpaJxdSzCe0T?=
 =?us-ascii?Q?InV+y5ubzAuNDQYeadq3Y59JuudpwmaRAj5sTIoVGfT7ioYfh9p7E/JHDcSx?=
 =?us-ascii?Q?BuQ1G46I86oWwzQcpXydzCwPuu9ScpCQW2WkX6eSyluVgoVhL0jspusU0gLO?=
 =?us-ascii?Q?wGGcT+zSeA5YKODcvZ6zo7WmmtACj4i+ibPp/eFnj3QQKhSRJrsT/XSjdvIa?=
 =?us-ascii?Q?sbE9gQPZ5RrRDJFDLAblAL68VhfpLWNiHXztrYrZI/jE2FJU2eVimU9iPUD3?=
 =?us-ascii?Q?v0BcxAu7SqU+Dzz+hr01GwhVuU5HOsL5DUuAX52sPp5IxRud9BbfU4WD1T0W?=
 =?us-ascii?Q?jV5DGohLLrzt1/TMwpsw/bKjHJTwpA+vbbWa0dUyf7qvXAETG6p9qGfHeC8b?=
 =?us-ascii?Q?jhakb7Ak+6br+YhcK8/nRCMX8f3t0nhvYog19bYJQum1yPGG47P0YJcgBbuR?=
 =?us-ascii?Q?YeRuHYScry59Abowy6OMyE3VUzaGYfvSMkkGeQEDpbtg+6lM3agAGtCOXY2d?=
 =?us-ascii?Q?e5jOH1JQnve/xf89alq97GtvXio3Gg+yInoBnqfckgiCUfdZAQzFn+uqemuY?=
 =?us-ascii?Q?BitFj0J/2uC6MIrDSOFT4hx2yIrHyqDRfG3T017S?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9546dc9-bc7b-4128-7329-08dbb2987232
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 07:26:42.5798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SMbW4NPMG+/zQr0H/9FSJo+WVUJ4tjbAxThu4TwMbPtPHyv7l3lMerl39FeI6lY0RizVnPQ+EfPuZFCZPwW0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7933
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 10:50:00AM +0800, Chen Yu wrote:
> When task p is woken up, the scheduler leverages select_idle_sibling()
> to find an idle CPU for it. p's previous CPU is usually a preference
> because it can improve cache locality. However in many cases the
> previous CPU has already been taken by other wakees, thus p has to
> find another idle CPU.
> 
> Inspired by Mathieu's idea[1], consider the sleep time of the task.
> If that task is a short sleeping one, keep p's previous CPU idle
> for a short while. Later when p is woken up, it can choose its
> previous CPU in select_idle_sibling(). When p's previous CPU is reserved,
> other wakee is not allowed to choose this CPU in select_idle_idle().
> The reservation period is set to the task's average sleep time. That
> is to say, if p is a short sleeping task, there is no need to migrate
> p to another idle CPU.
> 
> This does not break the work conservation of the scheduler,
> because wakee will still try its best to find an idle CPU.
> The difference is that, different idle CPUs might have different
> priorities. On the other hand, in theory this extra check could
> increase the failure ratio of select_idle_cpu(), but per the
> initial test result, no regression is detected.
> 
> Baseline: tip/sched/core, on top of:
> Commit 3f4feb58037a ("sched: Misc cleanups")
> 
> Benchmark results on Intel Sapphire Rapids, 112 CPUs/socket, 2 sockets.
> cpufreq governor is performance, turbo boost is disabled, C-states deeper
> than C1 are disabled, Numa balancing is disabled.
> 
> netperf
> =======
> case                    load            baseline(std%)  compare%( std%)
> UDP_RR                  56-threads       1.00 (  1.34)   +1.05 (  1.04)
> UDP_RR                  112-threads      1.00 (  7.94)   -0.68 ( 14.42)
> UDP_RR                  168-threads      1.00 ( 33.17)  +49.63 (  5.96)
> UDP_RR                  224-threads      1.00 ( 13.52)  +122.53 ( 18.50)
> 
> Noticeable improvements of netperf is observed in 168 and 224 threads
> cases.
> 
> hackbench
> =========
> case                    load            baseline(std%)  compare%( std%)
> process-pipe            1-groups         1.00 (  5.61)   -4.69 (  1.48)
> process-pipe            2-groups         1.00 (  8.74)   -0.24 (  3.10)
> process-pipe            4-groups         1.00 (  3.52)   +1.61 (  4.41)
> process-sockets         1-groups         1.00 (  4.73)   +2.32 (  0.95)
> process-sockets         2-groups         1.00 (  1.27)   -3.29 (  0.97)
> process-sockets         4-groups         1.00 (  0.09)   +0.24 (  0.09)
> threads-pipe            1-groups         1.00 ( 10.44)   -5.88 (  1.49)
> threads-pipe            2-groups         1.00 ( 19.15)   +5.31 ( 12.90)
> threads-pipe            4-groups         1.00 (  1.74)   -5.01 (  6.44)
> threads-sockets         1-groups         1.00 (  1.58)   -1.79 (  0.43)
> threads-sockets         2-groups         1.00 (  1.19)   -8.43 (  6.91)
> threads-sockets         4-groups         1.00 (  0.10)   -0.09 (  0.07)
> 
> schbench(old)
> ========
> case                    load            baseline(std%)  compare%( std%)
> normal                  1-mthreads       1.00 (  0.63)   +1.28 (  0.37)
> normal                  2-mthreads       1.00 (  8.33)   +1.58 (  2.83)
> normal                  4-mthreads       1.00 (  2.48)   -2.98 (  3.28)
> normal                  8-mthreads       1.00 (  3.97)   +5.01 (  1.28)
> 
> No much difference is observed in hackbench/schbench, due to the
> run-to-run variance.
> 
> Link: https://lore.kernel.org/lkml/20230905171105.1005672-2-mathieu.desnoyers@efficios.com/ #1
> Suggested-by: Tim Chen <tim.c.chen@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/sched/fair.c     | 30 +++++++++++++++++++++++++++---
>  kernel/sched/features.h |  1 +
>  kernel/sched/sched.h    |  1 +
>  3 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e20f50726ab8..fe3b760c9654 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6629,6 +6629,21 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	hrtick_update(rq);
>  	now = sched_clock_cpu(cpu_of(rq));
>  	p->se.prev_sleep_time = task_sleep ? now : 0;
> +#ifdef CONFIG_SMP
> +	/*
> +	 * If this rq will become idle, and dequeued task is
> +	 * a short sleeping one, check if we can reserve
> +	 * this idle CPU for that task for a short while.
> +	 * During this reservation period, other wakees will
> +	 * skip this 'idle' CPU in select_idle_cpu(), and this
> +	 * short sleeping task can pick its previous CPU in
> +	 * select_idle_sibling(), which brings better cache
> +	 * locality.
> +	 */
> +	if (sched_feat(SIS_CACHE) && task_sleep && !rq->nr_running &&
> +	    p->se.sleep_avg && p->se.sleep_avg < sysctl_sched_migration_cost)
> +		rq->cache_hot_timeout = now + p->se.sleep_avg;

Should this be written as:
		rq->cache_hot_timeout = max(rq->cache_hot_timeout, now + p->se.sleep_avg);
?

A even earlier task may have a bigger sleep_avg and overwriting
rq->cache_hot_timeout here with an earlier time may cause that task
migrate. Not sure how much impact this can have, just someting hit my
brain while reading this code.

> +#endif
>  }
>  
>  #ifdef CONFIG_SMP
> @@ -6982,8 +6997,13 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
>  static inline int __select_idle_cpu(int cpu, struct task_struct *p)
>  {
>  	if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
> -	    sched_cpu_cookie_match(cpu_rq(cpu), p))
> +	    sched_cpu_cookie_match(cpu_rq(cpu), p)) {
> +		if (sched_feat(SIS_CACHE) &&
> +		    sched_clock_cpu(cpu) < cpu_rq(cpu)->cache_hot_timeout)
> +			return -1;
> +

Maybe introduce a new function that also considers rq->cache_hot_timeout,
like available_idle_cpu_migrate() so that above and below logic can be
simplified a bit?

I was thinking to simply add that rq->cache_hot_timeout check to
available_idle_cpu() but then a long sleeping task could be forced to
migrate if its prev_cpu happens to just deschedule a task that sets rq's
cache_hot_timeout. I guess that's why you chose to only change the idle
semantic in select_idle_cpu() but not in select_idle_sibling()?

Thanks,
Aaron

>  		return cpu;
> +	}
>  
>  	return -1;
>  }
> @@ -7052,10 +7072,14 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
>  	int cpu;
>  
>  	for_each_cpu(cpu, cpu_smt_mask(core)) {
> -		if (!available_idle_cpu(cpu)) {
> +		bool cache_hot = sched_feat(SIS_CACHE) ?
> +			sched_clock_cpu(cpu) < cpu_rq(cpu)->cache_hot_timeout : false;
> +
> +		if (!available_idle_cpu(cpu) || cache_hot) {
>  			idle = false;
>  			if (*idle_cpu == -1) {
> -				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
> +				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr) &&
> +				    !cache_hot) {
>  					*idle_cpu = cpu;
>  					break;
>  				}
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index f770168230ae..04ed9fcf67f8 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -51,6 +51,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
>   */
>  SCHED_FEAT(SIS_PROP, false)
>  SCHED_FEAT(SIS_UTIL, true)
> +SCHED_FEAT(SIS_CACHE, true)
>  
>  /*
>   * Issue a WARN when we do multiple update_rq_clock() calls
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 62013c49c451..7a2c12c3b6d0 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1078,6 +1078,7 @@ struct rq {
>  #endif
>  	u64			idle_stamp;
>  	u64			avg_idle;
> +	u64			cache_hot_timeout;
>  
>  	unsigned long		wake_stamp;
>  	u64			wake_avg_idle;
> -- 
> 2.25.1
> 
