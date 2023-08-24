Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2226F7868F3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbjHXHxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjHXHwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:52:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8FB1703
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692863561; x=1724399561;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=gvBCg+7RyrywKcbN8AHih/7zIRexIWxDjefGTL+MCgA=;
  b=QbJiWxJikceXlehWDAUKrKIKId0dUooD9+MRZm/A96fkHW4+237fSJ4X
   Bhwke5RSWzn7UCcf5ZU5pgcLIYQpR0G2/AjnhmBnpboC+n0L3aPxBeaH6
   nju4XOrA8LbX/G6rb2pVxSq/YijuwV3VOvzF4pMbk/Y0INBg2agiVs1aO
   MU2B9O9W1b6XoCLYhJqFRy/6QWtKzoi12hYGe55UF4cL1JUUP853kaU+q
   EVFZNiaAwhFS6zNaA2RndTfuMVv8GJFxWitT0/yZDgZQXMzwYqzkm43CV
   LpDic5+ygNZ+NaAUYPM57SwMoTdZg5yr9CgKv8/egzzIoxZwNzUPT4FqG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="440721021"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="440721021"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 00:52:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="983604638"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="983604638"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 24 Aug 2023 00:52:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 00:52:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 00:52:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 00:52:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 00:52:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIOuKg+xpWKlueSs45JkmJj5tUCkHprZNKgsSEfhqhsu/E69xjE9zUuvcqn2tnAdLPtfyay5b0x3asIU5r4mQi9cRM+F+l9zLLJK5veWaxfrzBikGme4QxCV/JQdCDdUlOpCNP4RBRzYJgqIZgzB8LxHNq1SZAKHT0b0BdKJwJK0wANgd/K1/F/IJStnLRCSd0fNFxM7cEQ96z1NFIzG7CYs0GRKEEwqnIxsVClaGqAtBdNXgBJJzz1ib17MQYr+E/a9A8pRHhgsnv57uX7cfRYNNIOlmiibHfamObznB7qPDBMT/7aZ++F2/73g1N9JAjISCDs+JKfDzTg5zshV2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftfnhyM8SHRUzSk+9P/Nwh9lOjeGR1Eq4QsFGoeXEIk=;
 b=KGKij2XhD2u+xkCRundUkemqhPpzBgtgwKKc8H2/Q+AMi0GvaEr3aSLIAIEmmgVLM+OsTwJLmZlgQ/CAIWQcVB09BHoGh8nPcg/oYGDaTWlVN8zcg0t306i2S6VqkLNYoriFPuBI9AMipXFdrYwSyD6d0Q3TF9f6kC8mqRpaahYSs8crV8EcJCb0X+K8pDZKC8YvUjQNp9tQF1f6094OI8wEjeY6Od82k+dBVAo9cjx8RmriuQPvY1HK+lAngEB3IDTzy90qpw166W8Yke11QSo+fyWvxvCG5J0L9yeyLfW5r/0tma8h/b9W6pt8ja+XR3T6UFzP4fdBd2dqiY9e/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3060.namprd11.prod.outlook.com (2603:10b6:208:72::24)
 by PH8PR11MB6949.namprd11.prod.outlook.com (2603:10b6:510:227::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Thu, 24 Aug
 2023 07:52:24 +0000
Received: from BL0PR11MB3060.namprd11.prod.outlook.com
 ([fe80::b41e:473a:b81d:ce62]) by BL0PR11MB3060.namprd11.prod.outlook.com
 ([fe80::b41e:473a:b81d:ce62%3]) with mapi id 15.20.6699.022; Thu, 24 Aug 2023
 07:52:23 +0000
Date:   Thu, 24 Aug 2023 15:52:08 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        "Julien Desfossez" <jdesfossez@digitalocean.com>, <x86@kernel.org>
Subject: Re: [RFC PATCH v3 2/3] sched: Introduce cpus_share_l2c
Message-ID: <20230824075208.GA459974@ziqianlu-dell>
References: <20230822113133.643238-1-mathieu.desnoyers@efficios.com>
 <20230822113133.643238-3-mathieu.desnoyers@efficios.com>
 <04be42cb-0e8b-25f7-a34b-41b2873f39d4@efficios.com>
 <c7fe33f9-51bd-80e8-cb0e-1cefb20a61b9@efficios.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7fe33f9-51bd-80e8-cb0e-1cefb20a61b9@efficios.com>
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To BL0PR11MB3060.namprd11.prod.outlook.com
 (2603:10b6:208:72::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3060:EE_|PH8PR11MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: 56236431-5777-4830-aeb1-08dba4770ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: diJWOKz5qHnUKExbrM5nXXWSg7SV+8sqsUpFUpBAKOsU5REMzUTmpkgqkm+02KpiIL025L/lEEuhJVRqVlK4EMRA1Q8xB1M8Z06RUvlPpwDTOC+V8c0zYY6qJ6ubpCAAJ8DZqO9+d1QJaNM0vRbgd+RvPbttgyJjbmwRNNYGayeoFShDQas/ryXDhffrO3W21UvwcJDT/DzP9IDFSJEraX8Jn+qOzO7Wj4mCiF+lqsswtzi6acqN0swAd9ML8r/mra139wt2hOtbeuIEjL0rYj+VqJatZgTHrHg1fX1dh44UyvqEmVfYwYNI2zsBAWLa+pbQfukDzt42cRFzi6+V/85gjReQnyT4RZV8/jV5HQp5Qvk2SuzZa7uQ/lJVS46IONwdeRFSnH5lQX2Lqn58KNbut5rRfocN/ZX5ReCBnBG6tn2jnLxU4blkhRYLlG0nBtURuTkEbANzWRtw4YmAgVoBLaFva9OuVKLViirNTvlQwnBm0PgCXUtCLygdLkhqMsr2y39A8tCdoAa4r2c8k7xnUa4K5gLJTCiRVf22qAdtOkMFehGApeCjrYWFupTy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3060.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(39860400002)(346002)(136003)(396003)(186009)(1800799009)(451199024)(6486002)(6666004)(478600001)(1076003)(6506007)(9686003)(6512007)(2906002)(8936002)(7416002)(53546011)(33716001)(316002)(8676002)(5660300002)(54906003)(66946007)(6916009)(4326008)(41300700001)(86362001)(66476007)(66556008)(44832011)(26005)(33656002)(82960400001)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?q94TqMlE3vfhd4g+aLf+78woe8njccs+NAQxp882kt70gW0fgQSuLrO7FH?=
 =?iso-8859-1?Q?qLHRpJMczpKjPJjpL+eq2H9fW7WOZtRg4wsXIIpg01He+ymPIgAOkrizA/?=
 =?iso-8859-1?Q?9JfshbVmjFr7goHI9Nc9jIRR9BZHDXS3TQpFEaKLbvb+Ov/XXwGpQhfzUH?=
 =?iso-8859-1?Q?BHNUm4W8t3mdZQinJ1YnDi0/q5M0zHdxZ3Qet1jafIq4MohVdKQidIrKU/?=
 =?iso-8859-1?Q?e9Y7JMhU2IIgFOCg6uqu7D+6QCkSNnrOS6YRYxFhbc4tRhH05BRdtnxCiK?=
 =?iso-8859-1?Q?Z/NWwb13H1pKNET6P6F+dqWRNjLOYLjsZMHtlf8bzXZBbbG8qlgsRMAG7s?=
 =?iso-8859-1?Q?k1xq+sT6/Q5mKjLTb72VMVI8hGaAvkxppCKhpEPS82zLksjBue8xhmXqdJ?=
 =?iso-8859-1?Q?ei8M7pj9zkdabvy5D7Xv+u/8DHKNOzPA6FJk/847CzNQ6gQ9lygEURoojN?=
 =?iso-8859-1?Q?lGSPe5YDA97/s2uItB0Za4zaKbzyIyyI3HK+gNKJbdmSHgr9Ya0t1cf8Yp?=
 =?iso-8859-1?Q?VRz7tsCuLvOd04puvsIs15sBmrTgsSid0Y4fLpb+HKiW97uk5Vo5Y1qxSB?=
 =?iso-8859-1?Q?cdABzOyal9O/mubmOVcZSOIzYQlK2/fcjR5SQGF1tAJdSxYkdl8w/wYK6/?=
 =?iso-8859-1?Q?FzGFFv0HI9yC27InWb7DnUL2J3IOiUY8goBm2WHztGl5IozOPsNAQb/pvl?=
 =?iso-8859-1?Q?l6fJ65UIIJIUOmQJAPBqoID1YF87mrRiG7yJWCpetWGvH7LZbqkOdpP4RN?=
 =?iso-8859-1?Q?ymwKY8OHwQ+a/Va6TS2LJlrVK62oSWFHUtkvwTo3WV8h/pjb6pW9gOKvL+?=
 =?iso-8859-1?Q?N4P1/UV159D6ERL1ahu0JfRnONg3KO6fbVf7nvy8pVb2AGqFmF2351xQgF?=
 =?iso-8859-1?Q?PDcV3K55TRBH4ljzVUfxtkXO5J+icuD+HiZENQdBrXqbK0iEsprYgmIV6A?=
 =?iso-8859-1?Q?ecBvym0fP33tD6x1PyPR3YKR6D069Jw1qdhvbi1k+fS7sL/qG4UTVWVJjf?=
 =?iso-8859-1?Q?JERwvIGzxQH3vs2y+FQPmtBLKib3rH3s05ZhEFjdMybR8Mi27i2sfSD3LA?=
 =?iso-8859-1?Q?VKkfwtSnp5FwOnnKIVhtrmD7vpbidBiVPOVOMdhi9EMd30E/sjkzb0JMS5?=
 =?iso-8859-1?Q?1XinhMmBT1oJntzuIClk5Da8NbHCF3jxvpnBx09/LKiY9cW7jf24UpSz8K?=
 =?iso-8859-1?Q?o3qHKopasT2evT0hI0dNeCkuk8t3oKqtBz3dNNiTPEAZCda8L2rTYWeCrn?=
 =?iso-8859-1?Q?C69oXsAY+iyW+kuOraU2xlCe2A13ql464uOc0TVu7Hw8Uaig+7C9K02s/S?=
 =?iso-8859-1?Q?5zgumqlgxl3iwC3xzCpTXJwWT0n+Xc/IOn4NKkBIvNp0GI5tROtoMZujGl?=
 =?iso-8859-1?Q?qsdAki8NpSxgSrOfYauI7aO+sAjEit+xQ1VZidJCWaVKGTj4hyJyKixmjd?=
 =?iso-8859-1?Q?xsDbq2G0sG0CHu3FPXVPNxVO/cBXaEwvXy7Rd7fjeZWzbPxBkiXx9lgFrh?=
 =?iso-8859-1?Q?v7gljFkCvsXFfgB4jkabfAI3kARazyVM+4/qINNR6J+E5UKW5Gc8Rkl05Z?=
 =?iso-8859-1?Q?/8PES1fUmETmwpDMFmWGuFYC0Ed2tnpWBeM5HUJVfQC72EZLRCdZzQpB4t?=
 =?iso-8859-1?Q?0yvLNNyoDivxyo7ykQOgmd0AMNizWnHzTH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56236431-5777-4830-aeb1-08dba4770ce3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3060.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 07:52:23.7470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANGB89h9mu9Oy2QHfJP6A/ifg7QhK7lvMBFmaLZ5junZM3hWjFRWCrkWIM1fx78FtQBlpHnPCSgP12uX3T1fjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6949
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 02:52:17PM -0400, Mathieu Desnoyers wrote:
> On 8/23/23 11:26, Mathieu Desnoyers wrote:
> > On 8/22/23 07:31, Mathieu Desnoyers wrote:
> > > Introduce cpus_share_l2c to allow querying whether two logical CPUs
> > > share a common L2 cache.
> > > 
> > > Considering a system like the AMD EPYC 9654 96-Core Processor, the L1
> > > cache has a latency of 4-5 cycles, the L2 cache has a latency of at
> > > least 14ns, whereas the L3 cache has a latency of 50ns [1]. Compared to
> > > this, I measured the RAM accesses to a latency around 120ns on my
> > > system [2]. So L3 really is only 2.4x faster than RAM accesses.
> > > Therefore, with this relatively slow access speed compared to L2, the
> > > scheduler will benefit from only considering CPUs sharing an L2 cache
> > > for the purpose of using remote runqueue locking rather than queued
> > > wakeups.
> > 
> > So I did some more benchmarking to figure out whether the reason for
> > this speedup is the latency delta between L2 and L3, or is due to the
> > number of hw threads contending on the rq locks.
> > 
> > I tried to force grouping of those "skip ttwu queue" groups by a subset
> > of the LLC id, basically by taking the LLC id and adding the cpu number
> > modulo N, where N is chosen based on my machine topology.
> > 
> > The end result is that I have similar numbers for groups of 1, 2, 4 HW
> > threads (which use rq locks and skip queued ttwu within the group).
> > Starting with group of size 8, the performance starts to degrade.
> > 
> > So I wonder: do machines with more than 4 HW threads per L2 cache exist?
> > If it's the case, there we should think about grouping not only by L2
> > cache, but also sub-divide this group so the number of hw threads per
> > group is at most 4.
> > 
> > Here are my results with the hackbench test-case:
> > 
> > Group cpus by 16 hw threads:
> > 
> > Time: 49s
> > 
> > - group cpus by 8 hw threads: (llc_id + cpu modulo 2)
> > 
> > Time: 39s
> > 
> > - group cpus by 4 hw threads: (llc_id + cpu modulo 4)
> > 
> > Time: 34s
> > 
> > - group cpus by 2 hw threads: (llc_id + cpu modulo 8)
> > (expect same as L2 grouping on this machine)
> > 
> > Time: 34s
> > 
> > - group cpus by 1 hw threads: (cpu)
> > 
> > Time: 33s
> 
> One more interesting data point: I tried modifying the grouping
> so that I would explicitly group by hw threads which sit in different
> L3, and even on different NUMA nodes for some
> (group id = cpu_id % 192). This is expected to generate really _bad_
> cache locality for the runqueue locks within a group.
> 
> The result for these groups of 3 HW threads is about 33s with the
> hackbench benchmark, which seems to confirm that the cause of the
> speedup is reduction of the contention on the rq locks by making the
> groups smaller, and therefore reducing the likelihood of contention for the
> rq locks, rather than by improving cache locality from L3 to L2.

In addition to reduced rq lock contention, I think another reason this
improves performance is because it reduced task migration. Not sure if
it is the case on your test system, but on my test machine(Intel SPR),
task migration number dropped.

Hackbench on Intel SPR(2sockets/112cores/224threads) test summary:
- performance improved for all three cases; the more tasks(groups), the
  more performance gain;
- task migrations dropped with this series for nr_group=20 and 32
  according to 'perf stat'. migration number didn't drop for nr_group=10
  but the two update functions' cost dropped which means fewer access to
  tg->load_avg and thus, fewer task migrations. This is contradictory
  and I can not explain yet;
- rq lock contention dropped for all three cases and it dropped the most
  under more overloaded case: nr_group=32.

It's not clear to me why this series can reduce task migrations. I doubt
it has something to do with more wakelist style wakeup becasue for this
test machine, only a single core with two SMT threads share L2 so more
wakeups are through wakelist. In wakelist style wakeup, the target rq's
ttwu_pending is set and that will make the target cpu as !idle_cpu();
This is faster than grabbing the target rq's lock and then increase
target rq's nr_running or set target rq's curr to something else than
idle. So wakelist style wakeup can make target cpu appear as non idle
faster, but I can't connect this with reduced migration yet, I just feel
this might be the reason why task migration reduced.

Below are detailed test data.
Base: 6.5-rc1.
rq_spin%: The percent of raw_spin_rq_lock_nested() as reported by
          perf/events=cycles:pp
migration: cpu-migrations reported by "perf stat -a -- sleep 5"

The cmdline used is:
hackbench -g $nr_group -f 20 --pipe --threads -l 480000 -s 100

nr_group=10:
            time  rq_spin%  update_cfs_group%  update_load_avg% migration
base         46s    1.32%        20.06%             10.78%      10.227 K/sec
this_series  37s    0.57%        15.08%              7.05%      10.722 K/sec

nr_group=20:
            time  rq_spin%  update_cfs_group%  update_load_avg% migration
base         69s    2.57%        19.68%             10.74%      12.098 K/sec
this_series  41s    0.62%        12.11%              5.78%       8.617 K/sec

nr_group=32:
            time  rq_spin%  update_cfs_group%  update_load_avg% migration
base     192s±25%  15.12%        25.83%             9.33%       12.141 K/sec
this_series  71s    0.47%        10.98%             4.58%        8.198 K/sec

I also tested applying my "ratelimit update to tg->load_avg" patch and
the test summary is:
- performance improved noticeably for nr_group=20 and slightly for
  nr_group=10 case; nr_group=32's performance is roughly the same.
- task migrations dropped for all three cases; nr_group=20 saw the
  biggest drop.
- rq lock contention dropped for all three cases and again, nr_group=32
  saw the biggest drop.

Below are detailed data.
Base: peter's sched/core branch with my "ratelimit" patch.
this_series: apply this patchset on top of base.

nr_group=10:
            time  rq_spin%  update_cfs_group%  update_load_avg% migration
base         36s    0.55%        0.46%              1.43%       15.034 K/sec
this_series  35s    0.56%        0.52%              1.53%       13.751 K/sec

nr_group=20:
            time  rq_spin%  update_cfs_group%  update_load_avg% migration
base         47s    1.28%        0.73%              2.33%       21.217 K/sec
this_series  42s    0.60%        0.69%              1.69%       14.130 K/sec

nr_group=32:
            time  rq_spin%  update_cfs_group%  update_load_avg% migration
base         70s    2.38%        0.60%              2.19%       17.855 K/sec
this_series  70s    0.58%        0.63%              1.77%       12.331 K/sec

Thanks,
Aaron
