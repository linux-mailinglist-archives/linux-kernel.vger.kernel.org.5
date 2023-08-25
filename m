Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEDB787F90
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240971AbjHYGJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240728AbjHYGIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:08:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5971FE6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692943713; x=1724479713;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bmnAVV/MatXj4Y66/7El3tjMGZJEZU62lnpvoWer5XU=;
  b=i/JtWwAN48bY93iJ6pqetG8kixJW3PGibGMuT/D1MmQ66m7YR9sbHvFH
   a+47YyqMfx1MbaJ4xK93chHdim5fZGN3jRpXFwwWMklCK76/4sN1e0oSI
   NY2a/O+gN6WGno0goKj4KvxiVC9xG5Z/snVAlVQV3P07DldfMVdH41gdP
   3I0FJ4fADWsQzViURbHmHYtBhyVYUb8vlTqZ7sCc5E6QUmzXQJDr5U7E1
   39p/9T14vLAM7sWGxveOIqEeFhjJRR4Xiex5hnfG4oLd1uHrVPmoDh917
   xiMeAo8KECY4KeNkpymb6OS3L0CPef/HqcGCmd72iEoQPBDfF192njNag
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="354969807"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="354969807"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 23:08:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="851828405"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="851828405"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 24 Aug 2023 23:08:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 23:08:31 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 23:08:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 23:08:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 23:08:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYb1iIh36rV7D5xKzQkmZdgIZGtA/aCOvZ9w+cPeYIj4ROGSajSTkZy7M9C8daLRZSclMwpFJ9FMWu5hUbJ46xW7sDDGzv+FK5qcVDIeFgC+guM9Zq1P9jQzaNlLpNqENOOCbatfnaBaugMoPyW6zQIIqOW37yngTklk8/2l/SGDnxU5n3uhijurKLk+HWCOLZGloehs46UI68D67h3p5IF4wjbSTYat6pyXZb76K9TmGaKwOdv4e/VtLqKXyTEJjU7L440pifJ9Yn4HIqxZmHtpBjjaZ42nDiM3vNVPA8AZSahvAIScR/ttXexqNrF62sOmBAqUnYplrSHTzOjlAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMG9UyE5WZVs3y4GSrfXKzqsHuxWYLMBuTY38tRXQYE=;
 b=MVfvQkeiw9Ouvd8i16Xj8aN6i+YfBNL0DBzczikclm1Z6Tt9nE8xOIT6EJYkdtf/ixIZdE4bcUypq2CelyHlx/vI3zcamPTdlMD8jls6LtHKqc7OIz+jYhG9NiV6HmWDG2taMISFZ+ZXH/Eh5deaEJR3WgjdEz5kjx5EuGXh9eIl8H7nesGugNGc6/HSlUqBtjSU5Sr3QZWZ8V9bej5L8XKHuVq69xP6dT4ZHPibiqZ+SUZizJuhVPkDff0JYYLEmY+n2sfLuMyL2V1Obzm4Ks01UjQMVACvX/BjHUsUfvKOwnAKPjMX2Xt2fKPh6gIK3rSbDuYn8G8zvy9jJadkXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DS7PR11MB6125.namprd11.prod.outlook.com (2603:10b6:8:9f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 06:08:23 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9a8d:9d34:4af2:f2e5]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9a8d:9d34:4af2:f2e5%7]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 06:08:23 +0000
Date:   Fri, 25 Aug 2023 14:08:10 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>,
        Deng Pan <pan.deng@intel.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        David Vernet <void@manifault.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] sched/fair: ratelimit update to tg->load_avg
Message-ID: <20230825060810.GA464990@ziqianlu-dell>
References: <20230823060832.454842-1-aaron.lu@intel.com>
 <20230823060832.454842-2-aaron.lu@intel.com>
 <fd568884-9df4-2990-7b81-655fc7f63a4a@efficios.com>
 <20230824080142.GB459974@ziqianlu-dell>
 <2192e838-48d1-9dec-5769-74a4a048f3c2@efficios.com>
 <CAKfTPtDSjWCyrKpf6ftQtBi9zZC=zQn0tx7e1_eLRMi0M02FpA@mail.gmail.com>
 <0b5ead16-d09b-2670-5692-092959c780dc@efficios.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b5ead16-d09b-2670-5692-092959c780dc@efficios.com>
X-ClientProxiedBy: SG2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:3:18::36) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|DS7PR11MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c36946-7a32-4cd6-c0ba-08dba531b010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qgdo0Mirfgbgr+yFyFdPRzIvzSsrCYdOlWWfXpg1ZnAeQHbX8PGPKQmbIkizwMQWYnRnvNJ5h7u1mO6s1MUJYWfXsUpmXhgYkJ94/k1XZNwQlOqTjQ7OBq4NHTI3LGOCCp4zsZq1ywV8t43Pq5PcOuoPUIBRV2MiP5RELUKE3gmCBIZqN9xUehvj/FnQxUZuRfMMnkUr8wEJtGF7lnb4+IRtFJm5ngx9e9jm83ANjo5UGk31Yk3COnua1vL+1U8L6KWfjz5zsnKd0+ou5uyDb/f4Mm40musq19ZCX72oMCbCz2/q93bCDCp9aXoeY7jRSEh78/efFv1d4SV+KDQB1DJ1X1QxXErAHtHuPWsaMUACGL//4q5gcSK2H5BWzLoI26vDbGbX/88w8/5/irMPnVrp4T/wQ9HYNAvDO5oZ7VEEyfovuHz9U3JExzioCzGrYBIGfz+D3P+H7K7Cfj3ADZkaHGaYS+FRf/EsxdazmFjGRvq3IvIDukYh8P161/cMYSQdZjjIEDS1iRHGaXuEAn8oQLMUWIGhfbnmibwkKpo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(39860400002)(136003)(346002)(396003)(186009)(1800799009)(451199024)(1076003)(5660300002)(4326008)(8676002)(8936002)(30864003)(15650500001)(83380400001)(7416002)(33656002)(44832011)(26005)(38100700002)(6666004)(82960400001)(6916009)(66556008)(66946007)(66476007)(54906003)(33716001)(6506007)(316002)(478600001)(966005)(53546011)(41300700001)(2906002)(6512007)(9686003)(86362001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?aMWJZKTEMHftuSJMp7bDw/YfEUKUYPsy2RH4VrEOd6rdsB5cezRVwhxThO?=
 =?iso-8859-1?Q?0c+grtZpWJunaVGR6UzWb+vJRFS8El5Rk9IPeIJKURy82cHWoDZaY10lkD?=
 =?iso-8859-1?Q?MDQMFvKGuchlRSnGxLMYXKusU6KVMTy14KqKptJAblLu/6Wc9DvwBWHvGi?=
 =?iso-8859-1?Q?zHnt8WZ5mG4cuaPam2eDsi/JAUPwo76yGgaoX2Ye+jlnr/VFNEy4kN0wFL?=
 =?iso-8859-1?Q?KxYO7h59/CZAsUIluRsRi2n0gtW0hmp30ysFZAe54D7zJEqD8nzTwwZhHv?=
 =?iso-8859-1?Q?oQBdLnvSXGutX4zhRmLZYltdHuJiwBT/NMvEoozwSo/dubxVqurNBF9MNf?=
 =?iso-8859-1?Q?Sb1cCVxukkwj7CU1jLVvUzHQoqYyrAetsHvVbN6eelK2Oz7a85q+zzFhrY?=
 =?iso-8859-1?Q?SCX/arQXkckP0OaRpsJhg776JueC+y+gPVwohBvsSFVW9753p+8/au6pXZ?=
 =?iso-8859-1?Q?hTC1j3JrCF7t4P8E0K7nmotXmITKeYbyEFHDwIvnCOQe8ZXIjKp91HXsmC?=
 =?iso-8859-1?Q?NS8L9O/buN1rsFu0aP9+pr6OtXulcyjEodaudCj6009HacFalaMUky2rDS?=
 =?iso-8859-1?Q?kyRkeiQnpARSp8dftcRc9J7E3Pj7QY1WhpSujq80l8FVEd/sUR7Wl/pPey?=
 =?iso-8859-1?Q?SPDVzLRjTdJa5oFEcb6vHZqI3AQw+MDBY/AulJavdx4jxGLUvwrdWe8JT5?=
 =?iso-8859-1?Q?ok2lNUowjqSqdv5ntx244cWiDeihm3guyAYHFgOPOrQXAbOjE3JR+XHtTE?=
 =?iso-8859-1?Q?Xc3/OBTmSc8Jyz2uNs2rLtuW4JBGDCjXULdBrIr71l7ArQCMroZGmjSTXm?=
 =?iso-8859-1?Q?HU1thI/Fkt5/GSmHXMDcyKgM0yFV3/zdfPR12kKG6I6cMdYDf5apcSS4Sf?=
 =?iso-8859-1?Q?I7hA+H7sy0DCNp0y4Zr8gGsxLmvBsSQONtnW4UAL3ELlLXryMo6Dc2zQpv?=
 =?iso-8859-1?Q?DZVMQYLnoLJRFWxWBKL54JNpDNOmS750YAQdEAWhfUSiihgrXW7ywUbMLU?=
 =?iso-8859-1?Q?7PVSNRI751vVEpznn+eeizv9CYwysdLHHWlQyIcNnaC5OElwmZJIJLZahI?=
 =?iso-8859-1?Q?AnZbsWWQ1y9coMoBhhAvb0/snlwYKSGvUzXZSuk1hQP6WMjOTQXzTjQrjj?=
 =?iso-8859-1?Q?K39Bw6+ZrIQ4JhLsKCtVAdSr2OeXVyeZyy9eGnPVKKAIwmV7WJVqZB7YyJ?=
 =?iso-8859-1?Q?todPFLqgkl1Rf0W0sHWEXZD1t8WknL94TwbDi8jO3FfC6it6PpRNR7Eixz?=
 =?iso-8859-1?Q?wteWYzF8YRB0/Q7dC7wAyMxh6wPiqQdTgiXvH5BRqZ3ERRtOiEJNlhqZcG?=
 =?iso-8859-1?Q?XUYbivjgaJUq+S/QJGZW+f2cTla+rlpKM8FMOh2bn9a2swmuvIGPk/p1nV?=
 =?iso-8859-1?Q?XpOT9RZq8ezIN/Q7UrIiBJ3VNlup8Lab4sY/dh6sM3bJAKghExyqUhVb/n?=
 =?iso-8859-1?Q?hKdJ7BPPvVXA6dxmK45x6ri1l284SqIVmAaEkWqXr/nz25RkZK2FBYCx+6?=
 =?iso-8859-1?Q?mvrIQiFXF8LC2+8pLQJe3rXUjOu1xEt2a0xa3rImbtJlYEN1daaaj0LTJD?=
 =?iso-8859-1?Q?qLvBnLJhBVS2yLqEEFI/USoYK62mLJVv2pl7M3UYJDELWm/Ty4AAYfi2Ff?=
 =?iso-8859-1?Q?7JNZXNZpUTQkL38v1zsgnOKMP6vkHnc6GC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c36946-7a32-4cd6-c0ba-08dba531b010
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 06:08:23.1344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRxwnulOEV5zYkTnTNjfsh4a5DSCH0CvUNo30gVfSVAOWBePht0tagnRplR5YgTteBY+W4RFFefcPMpCTRrKpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6125
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

On Thu, Aug 24, 2023 at 09:08:43AM -0400, Mathieu Desnoyers wrote:
> On 8/24/23 09:03, Vincent Guittot wrote:
> > On Thu, 24 Aug 2023 at 14:55, Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> > > 
> > > On 8/24/23 04:01, Aaron Lu wrote:
> > > > On Wed, Aug 23, 2023 at 10:05:31AM -0400, Mathieu Desnoyers wrote:
> > > > > On 8/23/23 02:08, Aaron Lu wrote:
> > > > > > When using sysbench to benchmark Postgres in a single docker instance
> > > > > > with sysbench's nr_threads set to nr_cpu, it is observed there are times
> > > > > > update_cfs_group() and update_load_avg() shows noticeable overhead on
> > > > > > a 2sockets/112core/224cpu Intel Sapphire Rapids(SPR):
> > > > > > 
> > > > > >        13.75%    13.74%  [kernel.vmlinux]           [k] update_cfs_group
> > > > > >        10.63%    10.04%  [kernel.vmlinux]           [k] update_load_avg
> > > > > > 
> > > > > > Annotate shows the cycles are mostly spent on accessing tg->load_avg
> > > > > > with update_load_avg() being the write side and update_cfs_group() being
> > > > > > the read side. tg->load_avg is per task group and when different tasks
> > > > > > of the same taskgroup running on different CPUs frequently access
> > > > > > tg->load_avg, it can be heavily contended.
> > > > > > 
> > > > > > E.g. when running postgres_sysbench on a 2sockets/112cores/224cpus Intel
> > > > > > Sappire Rapids, during a 5s window, the wakeup number is 14millions and
> > > > > > migration number is 11millions and with each migration, the task's load
> > > > > > will transfer from src cfs_rq to target cfs_rq and each change involves
> > > > > > an update to tg->load_avg. Since the workload can trigger as many wakeups
> > > > > > and migrations, the access(both read and write) to tg->load_avg can be
> > > > > > unbound. As a result, the two mentioned functions showed noticeable
> > > > > > overhead. With netperf/nr_client=nr_cpu/UDP_RR, the problem is worse:
> > > > > > during a 5s window, wakeup number is 21millions and migration number is
> > > > > > 14millions; update_cfs_group() costs ~25% and update_load_avg() costs ~16%.
> > > > > > 
> > > > > > Reduce the overhead by limiting updates to tg->load_avg to at most once
> > > > > > per ms. After this change, the cost of accessing tg->load_avg is greatly
> > > > > > reduced and performance improved. Detailed test results below.
> > > > > 
> > > > > By applying your patch on top of my patchset at:
> > > > > 
> > > > > https://lore.kernel.org/lkml/20230822113133.643238-1-mathieu.desnoyers@efficios.com/
> > > > > 
> > > > > The combined hackbench results look very promising:
> > > > > 
> > > > > (hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100)
> > > > > (192 cores AMD EPYC 9654 96-Core Processor (over 2 sockets), with hyperthreading)
> > > > > 
> > > > > Baseline:                                       49s
> > > > > With L2-ttwu-queue-skip:                        34s (30% speedup)
> > > > > With L2-ttwu-queue-skip + ratelimit-load-avg:   26s (46% speedup)
> > > > > 
> > > > > Feel free to apply my:
> > > > > 
> > > > > Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > > Tested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > 
> > > > Thanks a lot for running this and reviewing the patch.
> > > > I'll add your number and tag in the changelog when sending a new
> > > > version.
> > > 
> > > Now that I come to think of it, I have comment: why use
> > > sched_clock_cpu() rather than just read the jiffies value ? AFAIR,
> > > sched_clock can be slower than needed when read from a "remote" cpu on
> > > architectures that have an unsynchronized tsc.
> > > 
> > > Considering that you only need a time reference more or less accurate at
> > > the millisecond level, I suspect that jiffies is what you are looking
> > > for here. This is what the NUMA balance code and rseq mm_cid use to
> > > execute work every N milliseconds.
> > 
> > tick can 4ms or even 10ms which means a rate limit up between 10ms to
> > 20ms in the latter case
> 
> Fair enough, so just to confirm: is the 1ms a target period which has been
> empirically determined to be optimal (lower having too much overhead, and
> higher not being precise enough) ?

I chose 1ms because pelt window is roughly 1ms.

And during my tests, ratelimit to once per 1ms delivers good performance
and no regressions for the workloads that I tested so far so I didn't try
other values.

I can't say 1ms is the optimal value, but it appears to work good enough
for now.

Thanks,
Aaron

> > > 
> > > Thanks,
> > > 
> > > Mathieu
> > > 
> > > > 
> > > > Regards,
> > > > Aaron
> > > > 
> > > > > > 
> > > > > > ==============================
> > > > > > postgres_sysbench on SPR:
> > > > > > 25%
> > > > > > base:   42382±19.8%
> > > > > > patch:  50174±9.5%  (noise)
> > > > > > 
> > > > > > 50%
> > > > > > base:   67626±1.3%
> > > > > > patch:  67365±3.1%  (noise)
> > > > > > 
> > > > > > 75%
> > > > > > base:   100216±1.2%
> > > > > > patch:  112470±0.1% +12.2%
> > > > > > 
> > > > > > 100%
> > > > > > base:    93671±0.4%
> > > > > > patch:  113563±0.2% +21.2%
> > > > > > 
> > > > > > ==============================
> > > > > > hackbench on ICL:
> > > > > > group=1
> > > > > > base:    114912±5.2%
> > > > > > patch:   117857±2.5%  (noise)
> > > > > > 
> > > > > > group=4
> > > > > > base:    359902±1.6%
> > > > > > patch:   361685±2.7%  (noise)
> > > > > > 
> > > > > > group=8
> > > > > > base:    461070±0.8%
> > > > > > patch:   491713±0.3% +6.6%
> > > > > > 
> > > > > > group=16
> > > > > > base:    309032±5.0%
> > > > > > patch:   378337±1.3% +22.4%
> > > > > > 
> > > > > > =============================
> > > > > > hackbench on SPR:
> > > > > > group=1
> > > > > > base:    100768±2.9%
> > > > > > patch:   103134±2.9%  (noise)
> > > > > > 
> > > > > > group=4
> > > > > > base:    413830±12.5%
> > > > > > patch:   378660±16.6% (noise)
> > > > > > 
> > > > > > group=8
> > > > > > base:    436124±0.6%
> > > > > > patch:   490787±3.2% +12.5%
> > > > > > 
> > > > > > group=16
> > > > > > base:    457730±3.2%
> > > > > > patch:   680452±1.3% +48.8%
> > > > > > 
> > > > > > ============================
> > > > > > netperf/udp_rr on ICL
> > > > > > 25%
> > > > > > base:    114413±0.1%
> > > > > > patch:   115111±0.0% +0.6%
> > > > > > 
> > > > > > 50%
> > > > > > base:    86803±0.5%
> > > > > > patch:   86611±0.0%  (noise)
> > > > > > 
> > > > > > 75%
> > > > > > base:    35959±5.3%
> > > > > > patch:   49801±0.6% +38.5%
> > > > > > 
> > > > > > 100%
> > > > > > base:    61951±6.4%
> > > > > > patch:   70224±0.8% +13.4%
> > > > > > 
> > > > > > ===========================
> > > > > > netperf/udp_rr on SPR
> > > > > > 25%
> > > > > > base:   104954±1.3%
> > > > > > patch:  107312±2.8%  (noise)
> > > > > > 
> > > > > > 50%
> > > > > > base:    55394±4.6%
> > > > > > patch:   54940±7.4%  (noise)
> > > > > > 
> > > > > > 75%
> > > > > > base:    13779±3.1%
> > > > > > patch:   36105±1.1% +162%
> > > > > > 
> > > > > > 100%
> > > > > > base:     9703±3.7%
> > > > > > patch:   28011±0.2% +189%
> > > > > > 
> > > > > > ==============================================
> > > > > > netperf/tcp_stream on ICL (all in noise range)
> > > > > > 25%
> > > > > > base:    43092±0.1%
> > > > > > patch:   42891±0.5%
> > > > > > 
> > > > > > 50%
> > > > > > base:    19278±14.9%
> > > > > > patch:   22369±7.2%
> > > > > > 
> > > > > > 75%
> > > > > > base:    16822±3.0%
> > > > > > patch:   17086±2.3%
> > > > > > 
> > > > > > 100%
> > > > > > base:    18216±0.6%
> > > > > > patch:   18078±2.9%
> > > > > > 
> > > > > > ===============================================
> > > > > > netperf/tcp_stream on SPR (all in noise range)
> > > > > > 25%
> > > > > > base:    34491±0.3%
> > > > > > patch:   34886±0.5%
> > > > > > 
> > > > > > 50%
> > > > > > base:    19278±14.9%
> > > > > > patch:   22369±7.2%
> > > > > > 
> > > > > > 75%
> > > > > > base:    16822±3.0%
> > > > > > patch:   17086±2.3%
> > > > > > 
> > > > > > 100%
> > > > > > base:    18216±0.6%
> > > > > > patch:   18078±2.9%
> > > > > > 
> > > > > > Reported-by: Nitin Tekchandani <nitin.tekchandani@intel.com>
> > > > > > Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> > > > > > Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > > ---
> > > > > >     kernel/sched/fair.c  | 13 ++++++++++++-
> > > > > >     kernel/sched/sched.h |  1 +
> > > > > >     2 files changed, 13 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > > > index c28206499a3d..a5462d1fcc48 100644
> > > > > > --- a/kernel/sched/fair.c
> > > > > > +++ b/kernel/sched/fair.c
> > > > > > @@ -3664,7 +3664,8 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> > > > > >      */
> > > > > >     static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
> > > > > >     {
> > > > > > -   long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> > > > > > +   long delta;
> > > > > > +   u64 now;
> > > > > >      /*
> > > > > >       * No need to update load_avg for root_task_group as it is not used.
> > > > > > @@ -3672,9 +3673,19 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
> > > > > >      if (cfs_rq->tg == &root_task_group)
> > > > > >              return;
> > > > > > +   /*
> > > > > > +    * For migration heavy workload, access to tg->load_avg can be
> > > > > > +    * unbound. Limit the update rate to at most once per ms.
> > > > > > +    */
> > > > > > +   now = sched_clock_cpu(cpu_of(rq_of(cfs_rq)));
> > > > > > +   if (now - cfs_rq->last_update_tg_load_avg < NSEC_PER_MSEC)
> > > > > > +           return;
> > > > > > +
> > > > > > +   delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> > > > > >      if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
> > > > > >              atomic_long_add(delta, &cfs_rq->tg->load_avg);
> > > > > >              cfs_rq->tg_load_avg_contrib = cfs_rq->avg.load_avg;
> > > > > > +           cfs_rq->last_update_tg_load_avg = now;
> > > > > >      }
> > > > > >     }
> > > > > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > > > > index 6a8b7b9ed089..52ee7027def9 100644
> > > > > > --- a/kernel/sched/sched.h
> > > > > > +++ b/kernel/sched/sched.h
> > > > > > @@ -593,6 +593,7 @@ struct cfs_rq {
> > > > > >      } removed;
> > > > > >     #ifdef CONFIG_FAIR_GROUP_SCHED
> > > > > > +   u64                     last_update_tg_load_avg;
> > > > > >      unsigned long           tg_load_avg_contrib;
> > > > > >      long                    propagate;
> > > > > >      long                    prop_runnable_sum;
> > > > > 
> > > > > --
> > > > > Mathieu Desnoyers
> > > > > EfficiOS Inc.
> > > > > https://www.efficios.com
> > > > > 
> > > 
> > > --
> > > Mathieu Desnoyers
> > > EfficiOS Inc.
> > > https://www.efficios.com
> > > 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 
