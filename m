Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC0078236A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 08:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjHUGGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 02:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbjHUGGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 02:06:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D59A7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692598002; x=1724134002;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=UPEmGcnGKQXS1FwxaG3Jy+z+y1W1VjK8xKipPme933w=;
  b=NHpjx73wfjdsRiaBf1FrP3Q49DhnFKO7o/0thGpZ6QiTJkJDc+ycNC3O
   ySxIl1dWk1VbTdwIwQT7ywzwo3g8FcysGxDeOGzVAteU7QIqzRcMz6ltK
   y4nlqvEFg1BlVgBQHC+CKtkLIR9QeiE/wGIG62v+H3tsT+y5dn84enAt4
   0j/DX/rNIuxKCVL2k1oovQbWTS5IRYEefW/mSyQH1J1YtscbP9wsZltec
   Xd5K56ReY+g7wVE4jx5GPQvl5a1a9M9KMv3/XdKtDCNOUEqjajc7hL9v/
   674fO0a4InbtubsESFxN+DRb091PvCkZu8fJJzIhokMeNDZTVaW1MEtyw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="372403887"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="372403887"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2023 23:06:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="685538343"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="685538343"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 20 Aug 2023 23:06:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 20 Aug 2023 23:06:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 20 Aug 2023 23:06:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 20 Aug 2023 23:06:37 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 20 Aug 2023 23:06:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjbJEsEriqA20pqfBEqBgK+bEt4N4vdX816QS6c6IjS/0OXAh91RMtlIkKtRUwr/tCs9qS4M+01yMKB6lXP/V2vga6qP/51Ndf3wEV6K6z0eC/iHnvGB+/7n0SestX8V51MGkgU9S2wo+9tMIT8eFpfz4atZVsNPy+ZszK3f6SnvrFC3GsWUEX909fSMkaWneWoZUPFRhaL9OGJwjj7SK7rRwqnRrcFaQnzmm3vhEdlMGSOhHrOEBNA8rAA4hnwqplI8fWF6FRWfkeDn8xEG3ZfzzpAa6J8SSn7xWVr4JTqC6i6fiWuWepK7qjRIq34qCHDUGh4b7iI+lHUD3pSSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bb3mFH4BOvjFkwDhsy3JB9zGLxsWBYXljhwMqIhaHcw=;
 b=cNQlXMbgV9b5H/vBRe7kv2DVGEm0iC4ldmbIOBp9fl5MY+nUIMuoKgJccbEu/6NPtNi/goM7Kgwm9wMBzD/fAgRr8cr/AN2YGJHXVYhArSDSj7q1XwheFeJx+aIn7fgSXW/vUZq9UQA4j3BNfyDISk3ojmfRsRu2q5nhVQQFRj/ATb8CGe24oQvz0hFFvpWqyO6olgSqRMD3uwNHqf1Xjl1a95z5rCZk1NwL7MyWOPEnvGgvJT5atbW9DZIDihJ0LUKtAiQiyxby19e4TdKzqoIWV+BXfk8kx/yIyKZiD3n2RnqPl22d/9v8bdccQfe+oAp6BVaJnMvyboP5H26ZgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by CH3PR11MB8435.namprd11.prod.outlook.com (2603:10b6:610:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 06:06:31 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9a8d:9d34:4af2:f2e5]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9a8d:9d34:4af2:f2e5%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 06:06:31 +0000
Date:   Mon, 21 Aug 2023 14:06:18 +0800
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
        Deng Pan <pan.deng@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/1] sched/fair: ratelimit update to tg->load_avg
Message-ID: <20230821060618.GA72709@ziqianlu-dell>
References: <20230816024831.682107-1-aaron.lu@intel.com>
 <20230816024831.682107-2-aaron.lu@intel.com>
 <CAKfTPtB6sGva9eZPo2RjW1ZuzUxmKcO-9wBBJ3PJuGT9WtqwsQ@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtB6sGva9eZPo2RjW1ZuzUxmKcO-9wBBJ3PJuGT9WtqwsQ@mail.gmail.com>
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|CH3PR11MB8435:EE_
X-MS-Office365-Filtering-Correlation-Id: ff411db7-fc88-44ce-6732-08dba20cc3ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8HN1FQhTGLT+d6sVWOq5TCTjbrba9u54x69Ut/HKQvugNkcZP4NcZ6vk3iaPNZbGo0mB9ir3C9aRgH4AOL4gGvJFUTUWM3ozeyYEWhw/S69QE9yTTHjnMRDXrNFL/QaX4bm8VLDZViufZswaPWkFmyCI/FdvmsCl58IF7sIdefyna3/EF9jAu3Czlbvd0dKD5yZxi4eTAbeaYmOBpGFJWM+IadMonydRwCfhO4zoK/VJftujuRg/okW0HTgQc3DN0y7MBxPCGXDwdMK8BXH/D80q7+1FR2JLCIpdKWr9v7l1U0+JU7YEqAogTOe1/BRM2/NGeHU4E7WesubjpcL/4Na9lNI/RBLZccEt2hUiKnCoxcut2B4HThKA5AGSm4h8lELxzAA2bj6Slk2aO/IUYvaPqcRByCOK6lvTlVDkM8+TqZXbinieZlDwk2qEp1o23MXalc7fkW9rnDNoDsPsCuxmluTmnGiF6XxRw25Lt6x6+kL5WKNUBVb0b3Fd4NoVo5hkyPGpOYmzBTAscMWSI3Z0U2NXu9FguCsDfpeX6v0qMyIPIGQLc2UbgDrA4/6U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199024)(186009)(1800799009)(2906002)(83380400001)(7416002)(38100700002)(6506007)(6486002)(15650500001)(5660300002)(44832011)(33656002)(26005)(86362001)(8676002)(8936002)(4326008)(316002)(9686003)(6512007)(66946007)(6916009)(54906003)(66556008)(66476007)(82960400001)(478600001)(6666004)(41300700001)(33716001)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AgckJdJpUuPfzxeSEFcFO3dH025saor9T/ML5TParEkVjZiBCtrmkNHuZb?=
 =?iso-8859-1?Q?21rsgLNMrkx7h6OdS7w3DfwbM6vWK+uslk6ju2GEZov5loibhXi2Hq0Th2?=
 =?iso-8859-1?Q?/fu2qU03r/F7fEeNtYE0sAU5ykg8E/DBoUjEu945hmSrmqIAuAXbixOE/R?=
 =?iso-8859-1?Q?juOKmzxUXus8SkW7vrmtZDjLU8RyaR8yWfUOES7hK104GD3LiIJFBw6nmS?=
 =?iso-8859-1?Q?76j9TqHAbAysF8tSdDtI74g5O9aT3yBB4BOSM9Px0QcBUw6dkVmYcNUiFH?=
 =?iso-8859-1?Q?CNYYSWettyNt9Vp8t2JIG0h+yxmQTptDGTPa5bAc0NyGxuI9A+aD2r84MD?=
 =?iso-8859-1?Q?gLT3fDgfVkFLeChQ7JWxcsTMEof9utsj9G5r93vrJtQCr1wCWlxxAgBgeX?=
 =?iso-8859-1?Q?knA0rf576oLz3xW7VXDA8tkBeqC8U80/2orqHYWPM0UNhR7Sk8aWf7RfES?=
 =?iso-8859-1?Q?sTXxDQ/O2874kd99+kgx4QpsgpJk76/a72F15hiOJzjvkskHJjoa96wmlc?=
 =?iso-8859-1?Q?eMADAvJj/5XLIYgqfqopK8BWT9YUdAl5Cu7uXiXimWNSBq6cUgDNbgXn6E?=
 =?iso-8859-1?Q?q4RUvmN5xQ1PHo0Emu7bKXkyifXtSNd4+5dmQyE7fILTfPgjYFEzTXp0yc?=
 =?iso-8859-1?Q?PNqvD6rgTwQ1THCBqx7YYssonnCJhTW/MnN0Ga5Ehiz0BoLzN26ku/Mxw6?=
 =?iso-8859-1?Q?VgN/740wBEa7RjI3hl7wNRxnrkeq9x4PmnhmB3ZL6AiYON2llndwDJYlgK?=
 =?iso-8859-1?Q?Z/HfxWGsRxJKIZq75spHRC+DJ6CQ9xP7bnqol+6NJTRO2iksT9pvXd6DNH?=
 =?iso-8859-1?Q?UuEaqhvlrVdKlRfaPJrAIr6Zw4d65jZDnhBElQl7SlV7RUAhIAv5Oo8SV5?=
 =?iso-8859-1?Q?ApaDoEcqsW6W/jMNhmwl9MiRiAGLwGBHFcgioMDngQ3NeYhtN+A5ATSl6m?=
 =?iso-8859-1?Q?ZEJA/teoh/mKYsk4mw049B5J/ZhvjuI3qVuC5LkLkzwnUVx5exROjo/Meu?=
 =?iso-8859-1?Q?7+BhSn1YzRDDM0eixT52SdsUJirdCKTN6UdEtC9OnmgFqHPvC5sSv6s2e4?=
 =?iso-8859-1?Q?/enYCHIL9J9ouffyMjuceL+ohyYkPCX+8c5G/5MrI7VoWV8obaGf92ybj0?=
 =?iso-8859-1?Q?SVBSJDUs/X9Eu/Z2ZJaUQ2CUHNwUkfVkCXQlvs0+RS9eKvunFiRb2wi5zl?=
 =?iso-8859-1?Q?kXXF/jcPC+uIlBjk2mWrmNJwGbjIciAQtvpbGHKJkv+BaXKhhybI3t4Xz0?=
 =?iso-8859-1?Q?Iy85HTWGIC+NwtrbXdsud2COoRs4MK83TLjk+9N6E94T11pTSRIVasPtmC?=
 =?iso-8859-1?Q?G2Nbc+uVn4RBzU5CUFhqRO6iiVzUNydUGkH7p06sngB7wy3Yadg0rUkiOz?=
 =?iso-8859-1?Q?8R9CVCq2AjtNjHz16bobD+fSx2qEosZR3uosOWVDrab0gbp9XqUTlJRHpM?=
 =?iso-8859-1?Q?xIYRWR9EOEnxBZy54pG5KNxZF9dHPqa8xK4rsnMlEx0P6Uj6h5u26/D/KP?=
 =?iso-8859-1?Q?SxQxw3q6nk1eosYWkT7vscggtN3rk1YlAI16C6wdLKTNZyrAGlHaN2LNB6?=
 =?iso-8859-1?Q?zxhzh4PPEGGRxqkJk9AjLA/mQX0H5ommjDhO6pcvNbMIvwShvWNweOWnwn?=
 =?iso-8859-1?Q?OzV6edwB8xOKpeAsLuVT6K5h6jYWfyqGGS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff411db7-fc88-44ce-6732-08dba20cc3ac
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 06:06:31.1103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ua8hSH799A4RYO3y0SBbwbGQSMTioz9epttm5Y1NLy2QUIGWSDOUnT4zm9TrMmLab/oWuTfzxoZUpKy7BjOkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8435
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 02:56:00PM +0200, Vincent Guittot wrote:
> On Wed, 16 Aug 2023 at 04:48, Aaron Lu <aaron.lu@intel.com> wrote:
> >
> > When using sysbench to benchmark Postgres in a single docker instance
> > with sysbench's nr_threads set to nr_cpu, it is observed there are times
> > update_cfs_group() and update_load_avg() shows noticeable overhead on
> > a 2sockets/112core/224cpu Intel Sapphire Rapids(SPR):
> >
> >     13.75%    13.74%  [kernel.vmlinux]           [k] update_cfs_group
> >     10.63%    10.04%  [kernel.vmlinux]           [k] update_load_avg
> >
> > Annotate shows the cycles are mostly spent on accessing tg->load_avg
> > with update_load_avg() being the write side and update_cfs_group() being
> > the read side. tg->load_avg is per task group and when different tasks
> > of the same taskgroup running on different CPUs frequently access
> > tg->load_avg, it can be heavily contended.
> >
> > The frequent access to tg->load_avg is due to task migration on wakeup
> > path, e.g. when running postgres_sysbench on a 2sockets/112cores/224cpus
> > Intel Sappire Rapids, during a 5s window, the wakeup number is 14millions
> > and migration number is 11millions and with each migration, the task's
> > load will transfer from src cfs_rq to target cfs_rq and each change
> > involves an update to tg->load_avg. Since the workload can trigger as many
> > wakeups and migrations, the access(both read and write) to tg->load_avg
> > can be unbound. As a result, the two mentioned functions showed noticeable
> > overhead. With netperf/nr_client=nr_cpu/UDP_RR, the problem is worse:
> > during a 5s window, wakeup number is 21millions and migration number is
> > 14millions; update_cfs_group() costs ~25% and update_load_avg() costs ~16%.
> >
> > Reduce the overhead by limiting updates to tg->load_avg to at most once
> > per ms. After this change, the cost of accessing tg->load_avg is greatly
> > reduced and performance improved. Detailed test results below.
> >
> > ==============================
> > postgres_sysbench on SPR:
> > 25%
> > base:   42382±19.8%
> > patch:  50174±9.5%  (noise)
> >
> > 50%
> > base:   67626±1.3%
> > patch:  67365±3.1%  (noise)
> >
> > 75%
> > base:   100216±1.2%
> > patch:  112470±0.1% +12.2%
> >
> > 100%
> > base:    93671±0.4%
> > patch:  113563±0.2% +21.2%
> >
> > ==============================
> > hackbench on ICL:
> > group=1
> > base:    114912±5.2%
> > patch:   117857±2.5%  (noise)
> >
> > group=4
> > base:    359902±1.6%
> > patch:   361685±2.7%  (noise)
> >
> > group=8
> > base:    461070±0.8%
> > patch:   491713±0.3% +6.6%
> >
> > group=16
> > base:    309032±5.0%
> > patch:   378337±1.3% +22.4%
> >
> > =============================
> > hackbench on SPR:
> > group=1
> > base:    100768±2.9%
> > patch:   103134±2.9%  (noise)
> >
> > group=4
> > base:    413830±12.5%
> > patch:   378660±16.6% (noise)
> >
> > group=8
> > base:    436124±0.6%
> > patch:   490787±3.2% +12.5%
> >
> > group=16
> > base:    457730±3.2%
> > patch:   680452±1.3% +48.8%
> >
> > ============================
> > netperf/udp_rr on ICL
> > 25%
> > base:    114413±0.1%
> > patch:   115111±0.0% +0.6%
> >
> > 50%
> > base:    86803±0.5%
> > patch:   86611±0.0%  (noise)
> >
> > 75%
> > base:    35959±5.3%
> > patch:   49801±0.6% +38.5%
> >
> > 100%
> > base:    61951±6.4%
> > patch:   70224±0.8% +13.4%
> >
> > ===========================
> > netperf/udp_rr on SPR
> > 25%
> > base:   104954±1.3%
> > patch:  107312±2.8%  (noise)
> >
> > 50%
> > base:    55394±4.6%
> > patch:   54940±7.4%  (noise)
> >
> > 75%
> > base:    13779±3.1%
> > patch:   36105±1.1% +162%
> >
> > 100%
> > base:     9703±3.7%
> > patch:   28011±0.2% +189%
> >
> > ==============================================
> > netperf/tcp_stream on ICL (all in noise range)
> > 25%
> > base:    43092±0.1%
> > patch:   42891±0.5%
> >
> > 50%
> > base:    19278±14.9%
> > patch:   22369±7.2%
> >
> > 75%
> > base:    16822±3.0%
> > patch:   17086±2.3%
> >
> > 100%
> > base:    18216±0.6%
> > patch:   18078±2.9%
> >
> > ===============================================
> > netperf/tcp_stream on SPR (all in noise range)
> > 25%
> > base:    34491±0.3%
> > patch:   34886±0.5%
> >
> > 50%
> > base:    19278±14.9%
> > patch:   22369±7.2%
> >
> > 75%
> > base:    16822±3.0%
> > patch:   17086±2.3%
> >
> > 100%
> > base:    18216±0.6%
> > patch:   18078±2.9%
> >
> > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> > ---
> >  kernel/sched/fair.c  | 13 ++++++++++++-
> >  kernel/sched/sched.h |  1 +
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 6e79de26a25d..ab055c72cc64 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3664,7 +3664,8 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> >   */
> >  static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
> >  {
> > -       long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> > +       long delta;
> > +       u64 now;
> >
> >         /*
> >          * No need to update load_avg for root_task_group as it is not used.
> > @@ -3672,9 +3673,19 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
> >         if (cfs_rq->tg == &root_task_group)
> >                 return;
> >
> > +       /*
> > +        * For migration heavy workload, access to tg->load_avg can be
> > +        * unbound. Limit the update rate to at most once per ms.
> > +        */
> > +       now = sched_clock_cpu(cpu_of(rq_of(cfs_rq)));
> > +       if (now - cfs_rq->last_update_tg_load_avg < NSEC_PER_MSEC)
> > +               return;
> > +
> > +       delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> >         if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
> >                 atomic_long_add(delta, &cfs_rq->tg->load_avg);
> >                 cfs_rq->tg_load_avg_contrib = cfs_rq->avg.load_avg;
> > +               cfs_rq->last_update_tg_load_avg = now;
> >         }
> >  }
> >
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 19af1766df2d..228a298bf3b5 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -594,6 +594,7 @@ struct cfs_rq {
> >
> >  #ifdef CONFIG_FAIR_GROUP_SCHED
> >         unsigned long           tg_load_avg_contrib;
> > +       u64                     last_update_tg_load_avg;
> 
> Moving last_update_tg_load_avg before tg_load_avg_contrib should
> minimize the padding on 32bits arch as long is only 4 Bytes

Got it. That would be:

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6a8b7b9ed089..52ee7027def9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -593,6 +593,7 @@ struct cfs_rq {
 	} removed;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
+	u64			last_update_tg_load_avg;
 	unsigned long		tg_load_avg_contrib;
 	long			propagate;
 	long			prop_runnable_sum;
-- 
2.41.0

> 
> Apart from this, looks good to me

Thanks a lot for your review!
Can I add your reviewed-by in my next update with the above change?

Regards,
Aaron

> >         long                    propagate;
> >         long                    prop_runnable_sum;
> >
> > --
> > 2.41.0
> >
