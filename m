Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6583676B837
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjHAPHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjHAPHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:07:12 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA69E65
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 08:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690902431; x=1722438431;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5LLhmuPswEsOHXjhLQZZaPsAmaCoKuZWSxX5hxgkmXU=;
  b=BefDvqWWkSA1Hj6xDMmnrsZ4EIFjariWinKXiJu56wkfWQC2Hqx6Daks
   IyVVIHgTubqaOEbueZgTq+uShpuR8J6qT8Pwexk8EBGFzlfTdqHMAIgbl
   RISQETHXPx7RH9/bOfN8wlo3HEBuj143Krd3O4pNh+8Tlmt+WwIiQEdeb
   AOoHdgWoMj5rvYXmz3vmBFl72iL7aeUOeIsIJsizXTCpwXcbacwMd+Hfw
   zGuq6V4w1bqvQW8106dPtHv7l6RT3xJuaHd54yTU1kbTXP9klvXTQgmCC
   443wmd/+yx4/W0NQu4ISLgzJm63QV3oXNgXhxe2lSBNC4gMWsP1aY8Tvg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="368217631"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="368217631"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 08:04:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="678696324"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="678696324"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 01 Aug 2023 08:04:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 08:04:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 08:04:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 08:04:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 08:04:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkPMB6mb+H73tbV3Y4LY8ESYdJmrTPPwkXp2E2UV6RUKzU9RQQLspo7EoFopOQiARsjW1YP+Ak2/wSo7m3ouGWnOmLdFAPJ4/a91g2goitij4sFPywPg7mZJExtl0VkfA4aZL4EDgMwSC6BHLQbcv6sjzH7RaRoeasPorkawsFgxDMQQIPLvNtmpNHrqjArF6GSaHJwBp8BZmLt8JERfaIdqZ45KtFhzSw9JRh5PIZFL14LzcrG9WYQkWcT0nlF4BzgTSFKe8/L/JBBN7HieAeQrvon9kNVdkz7TS2jrQyQBMMnaotGqHpucLN/KrkUVOOSSWd1z6rB01bxvH5+lPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TImk0S6n7O6Klm5vWnmIEXolEPdgkU12vq/GO0YA4RI=;
 b=S6/K0ith+/Zy9QM8CrCpAzcCbzdXhlIv354gQ2ehxrsrtPxaSzCHe8jvJbfr6m4I+ViNio/uj57OeWgom8+r5CmVfO8+HpaKwUD99j5vk2LlSODjaBuflASSeB8BULRqocndbmGv1SnxJD9l4bD0i0SG/SgWjhz3scNUEkVI3crfvN/dTQJUm3TPSZfxDC9A7d0yoMenrphfD2j1lnIxUyiU6M3UayMfPZlEBA2xwzJRzfiWSpDhTFDUVluXQaRJuEy+r7VhDP77YzR1l45qx9D5PjzYTsNCcQvbvAAzAKXmgO34XuIy63CbrwAp3gPo856LrMjO25F7aMpq9FvWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SA1PR11MB6688.namprd11.prod.outlook.com (2603:10b6:806:25b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 15:04:15 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 15:04:15 +0000
Date:   Tue, 1 Aug 2023 23:03:57 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Aaron Lu <aaron.lu@intel.com>
CC:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>, <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/1] sched: Extend cpu idle state for 1ms
Message-ID: <ZMke3RuZzkyR64Lg@chenyu5-mobl2>
References: <20230725193048.124796-1-mathieu.desnoyers@efficios.com>
 <69076f8e-191b-2e3e-d810-ea72d8ff18bb@linux.vnet.ibm.com>
 <79fa8a62-a74e-2623-9f03-1f1af85b6c07@efficios.com>
 <cab82676-27fd-b4e1-2cd8-3d8d26b44aa0@linux.vnet.ibm.com>
 <447f756c-9c79-f801-8257-a97cc8256efe@efficios.com>
 <20230801072403.GA20269@ziqianlu-dell>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230801072403.GA20269@ziqianlu-dell>
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SA1PR11MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: fefef80f-f26a-4cfd-82da-08db92a091d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OnneD1Snpqzq339Dz+mpZmsxi7SGQEM4nf1O8oT7cwEZjLbOtl6B7LYEem8GArUU8+gUx/NvyMEvavihui02nw6t8Y4O2FfmukST0RPFu/+ZyFvWNCQjoSmvYauCvInql7YbKkpa1Cyb0wt2lNK3WNKeO7o3P69VLaUVVcDgHp4JkgJ8su7fRC3XJ/cOrwcXPa+iiqlQHnNyfxIeCZDui2Q6gcLGgd83CcHuJ/poLY71PozZY4Z2XIwQgTOSYZtGtBkVImLELM9+c2ogYyV675XP+Wlh+MphI1RtolKp8EqDWUInRUXTt2aNNcWpSbVZULfwhk98g54a6LyeTPKppga0BWw41gL8lMEX/9iXOGfnJJiUk2NQ60emhYK5/8/fbMBYVeZjIGQF62QMFB5wOzirQbNwl3TrNesV65UihuOsHxSwIYuZjTh9YBC1L88lIECqA6qwKWfjeU/R/69Jln3FmY2B0j855LB1ih0qlQR4WrjL6O/1r6HNuwGx3qq2EXUFF2olZ99CYzkoasN76JCAMEL86nZGq2JISvXM/Gs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(966005)(9686003)(6512007)(6486002)(53546011)(26005)(6506007)(83380400001)(186003)(66946007)(66556008)(7416002)(54906003)(33716001)(41300700001)(82960400001)(86362001)(38100700002)(66476007)(5660300002)(6636002)(4326008)(8676002)(8936002)(6862004)(316002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jH65KhchWUV4ERVuKjLZvId188wFfPV40TXxM4ly2S32wk74C59ZIji5Xyzd?=
 =?us-ascii?Q?fo4cCvjmzriZ3K+/wvM2rHCKRAK9EBoQnqpLFtBZpom/iaJMp6fn0VTat0+n?=
 =?us-ascii?Q?OwKy6ofrQuW4BcVbFbxPlm+w3P+cE+WEoqVmFBHgC02qikraWLUkHdvA9VQp?=
 =?us-ascii?Q?G0oVcZnbggcc8dRPjek5mQ7g8B02NZYoPkuz4qMkYokq4Lm8k6mMDJmILLgH?=
 =?us-ascii?Q?KAtgUM3aLfKwpFSP4rI+OFN0So9eUWTU9QpWymTfj1eH2btaKe0QYLyx4MIQ?=
 =?us-ascii?Q?uZlPzilFsCHxjooeZHmDJDYkiieIjdqau7UGxb6uXSTABLj9qtPn97/z/sum?=
 =?us-ascii?Q?O6t8qL1yp467aPKAffSYNPT56lSO5Nv7hEXTpgQn3mKsTmClpCrbkBvwXLQF?=
 =?us-ascii?Q?k6yJKyDtpSv+p1W4fxIsjFHWPoOytTQM2rramAZYu9TX6cudPQnCZtfa8iRx?=
 =?us-ascii?Q?qUPAWLFC5MI/DxYimpoPF5iT1N1QHTi3wo1c/67jWmc2H0Qr0H/X8TduhKYg?=
 =?us-ascii?Q?fVqfXSBWUtTJDScvz3iK8zMxIr8ieE7hCjQlr2IjzUV/rlAlpetXEpNnUM1y?=
 =?us-ascii?Q?H/5KW2kWC9qzAAOvzA1KPxjJS8zaGxvadac1xjVVK2AhiFcKhsCRwL6uVvNO?=
 =?us-ascii?Q?ew2TgfUPW6Z7bQ3alR5k0M/czrQO+sO3UTD1u+0dzRQfNwYMPZZqb9PUdcmq?=
 =?us-ascii?Q?IiGX/G5hFM9lzjVF6o3ionV6PywKNlORkMUYkT5GJfbBazegrBovXuRvs5OP?=
 =?us-ascii?Q?gYbcamv4QzaWAVyDacmyMfA3gIhiVAJF9ckTPsK/+YiW6+c/LsXAfwlyOU5m?=
 =?us-ascii?Q?pG3ppYx0DdhlGrBYIBR/gHMIa24AdZ5a2vPdHZtQv7ayGKe5W2YC0kb16NmY?=
 =?us-ascii?Q?KAWmmbzlfGs7+Eb9cl1H3zLrUrOqqvpT2BguN05eSOXAuTHCyFrmyfUkk7Xn?=
 =?us-ascii?Q?n9e29ZLJfJm12PQr1afVFWN5sPAKlUbxPI5foycx2gk0pNfm1S/TAkKXc0ma?=
 =?us-ascii?Q?sVqcgT3cy9U/AIeddilAAjekm97n5FOm4mUI19gkUvq+jnk+KErRir2zVe2L?=
 =?us-ascii?Q?30AQ0ZFTJBtooaMc7ArXciCQdxjKESAf2lf4IO+HlbMpiExA4+sV2v7kvOBi?=
 =?us-ascii?Q?poZw4ic4hn7EbV6WNSUcGG6nNyjS1WiYcNBgqgT7sXgvnq6RXEu8DhnBfeln?=
 =?us-ascii?Q?ZhuGV72InwgGQZku4FuvdcdRzPEiCE3t0sU2qGEg7iFogWQRF3RCYu/5JCl/?=
 =?us-ascii?Q?hYIEBFpaJFOwt/gnP7MtvOtz7zfrS/Hy69Hf2DlMyJHm3PoLbixcnyPz7oo3?=
 =?us-ascii?Q?3E/6wNoLJVtF/GfnTCUHbbE+FL1gsLtZDqn1wt8KFMQj0hC9Nj7WMYa9do+l?=
 =?us-ascii?Q?tlc+pWLEMlMFCSYpCmbn+rO+skyDX5jBnu00QNfWMZNcI3uuQiFZ4NHZ2VM0?=
 =?us-ascii?Q?ubEQto3uWREt0sGCj5QpKYaPR1W+OEkKeX9e83Wm83MtolfAda0Ro3NZuxiJ?=
 =?us-ascii?Q?ZEtNVqTaKWU0kn5kqxnxO9cpChK0MwCd5MDJQaB+aAxj0DJqCviJdMSkpMHC?=
 =?us-ascii?Q?UuryO76zHAzBEvLGr06cWWBCQleqjzRAQ3hp6fa1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fefef80f-f26a-4cfd-82da-08db92a091d5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 15:04:14.9155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBYCI8McFpfgXlDWEfHMvXlZ0wrjlm1ZNvhYXQQKiKN5lz0XIz9khQmZ/k9I6YAzHIVdicTrv6AWJ8NVpGgIXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6688
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

On 2023-08-01 at 15:24:03 +0800, Aaron Lu wrote:
> On Wed, Jul 26, 2023 at 02:56:19PM -0400, Mathieu Desnoyers wrote:
> 
> ... ...
> 
> > The updated patch:
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index a68d1276bab0..1c7d5bd2968b 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -7300,6 +7300,10 @@ int idle_cpu(int cpu)
> >  {
> >  	struct rq *rq = cpu_rq(cpu);
> > +	if (READ_ONCE(rq->nr_running) <= IDLE_CPU_DELAY_MAX_RUNNING &&
> > +	    sched_clock_cpu(cpu_of(rq)) < READ_ONCE(rq->clock_idle) + IDLE_CPU_DELAY_NS)
> > +		return 1;
> > +
> >  	if (rq->curr != rq->idle)
> >  		return 0;
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 81ac605b9cd5..57a49a5524f0 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -97,6 +97,9 @@
> >  # define SCHED_WARN_ON(x)      ({ (void)(x), 0; })
> >  #endif
> > +#define IDLE_CPU_DELAY_NS		1000000		/* 1ms */
> > +#define IDLE_CPU_DELAY_MAX_RUNNING	4
> > +
> >  struct rq;
> >  struct cpuidle_state;
> >
> 
> I gave this patch a run on Intel SPR(2 sockets/112cores/224cpus) and I
> also noticed huge improvement when running hackbench, especially for
> group=32/fds=20 case:
> 
> when group=10/fds=20(400 tasks):
>             time   wakeups/migration  tg->load_avg%
> base:        43s  27874246/13953871      25%
> this patch:  32s  33200766/244457         2%
> my patch:    37s  29186608/16307254       2%
> 
> when group=20/fds=20(800 tasks):
>             time   wakeups/migrations tg->load_avg%
> base:        65s  27108751/16238701      27%
> this patch:  45s  35718552/1691220        3%
> my patch:    48s  37506974/24797284       2%
> 
> when group=32/fds=20(1280 tasks):
>             time   wakeups/migrations tg->load_avg%
> base:       150s  36902527/16423914      36%
> this patch:  57s  30536830/6035346        6%
> my patch:    73s  45264605/21595791       3%
> 
> One thing I noticed is, after this patch, the migration on wakeup path
> has dramatically reduced(see above wakeups/migrations, the number were
> captured for 5s during the run). I think this makes sense because now a
> cpu is more likely to be considered idle so a wakeup task will more
> likely stay on its prev_cpu. And when migrations is reduced, the cost of
> accessing tg->load_avg is also reduced(tg->load_avg% is the sum of
> update_cfs_group()% + update_load_avg()% as reported by perf). I think
> this is part of the reason why performance improved on this machine.
> 
> Since I've been working on reducing the cost of accessing tg->load_avg[1],
> I also gave my patch a run. According to the result, even when the cost
> of accessing tg->load_avg is smaller for my patch, Mathieu's patch is
> still faster. It's not clear to me why, maybe it has something to do
> with cache reuse since my patch doesn't inhibit migration? I suppose ipc
> could reflect this?
>
Yeah, probably. I'm thinking that, since in hackbench the sender send the
data to the receiver, and the receiver reads it, if the cache is still hot
for the wakee(receiver) during every wakeup, it could improve performance.
Maybe increase the default transfer data size 100 bytes could evict the
L1/L2 more offen for each data send/receive to figure out if it is related
to cache locallity.

thanks,
Chenyu
> [1]: https://lore.kernel.org/lkml/20230718134120.81199-1-aaron.lu@intel.com/
> 
> Thanks,
> Aaron
