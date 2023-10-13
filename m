Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE8D7C8AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjJMQMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjJMQMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:12:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC33D479E
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697213495; x=1728749495;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wJFVdE99iDZ6ADLhVUYL8t7JZ8ilpPLktfhSuXRkoqQ=;
  b=aGlfd9hr0++JFf9Bp27bIaxDBYBijyZLyj7zIujBjXPHrNb72FY/7DKH
   A7Sug7lkZBua9A+Ro9+dnjmym8MJNL+aDgGJjaS/e91cnG4Cujhy3bbmQ
   n97RCnylNl8hY+6NJN4enun1LqrhffYHAgM2UTaXku0VrDu5ZBjTs0FvR
   KG+G0+qVci01cs6we9dIPgFqUSQP+FcKjE3dldD6h6I55jvheUa25vFYC
   7TTB9YAOCUkbNMNo4SFbzwJGAC3e2Ce9GYDUO9mDjZRGAtEL1mpZaXqzD
   yfRl7l7asXWAmbNav7ZQUuFyrYRqOpXVsTh8inoLHWpXKk/2hEKSR3FyY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="384080367"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="384080367"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 09:07:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="704697602"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="704697602"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 09:07:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 09:07:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 09:07:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 09:07:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mv3R7wHKdwP1raISYEqvHaEYx+Xy5KWpBAo4zts3XJQtm1kFPyIeoWs9xFD8gswUfJi58eu3JLica2vPZdXmpCkPVwM6oJoqaqzAYa56boHMRiyKCi0CJ15hKjzaWmUoRtexI5s3vyXDAINO9dwueZMBoWJIZJUipPkPwx2Wty3tsVBsnMluKt26E8aMavA022ow7eiDyRV8p7MyDA/LqeVgvjLYHzDEAkpxnfNKHKrWMqxmZBkVafCTc+5cLfMcR+8MXzhYntVCfzqo5qsaY3qWIEM52bRxeJpLx5IUJW6N8yAkqmPBY53Q77hwQexiKTGcmPi1ffXiG/dm/xyOcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGg2cBJvsdJE4jNe/oxHx8ZehErxcXAP2KJw0VXtuGA=;
 b=WZcKoX205or1MKKoIXfsC60sEUB6nUjzq6JDGVXb9X/pApoIelAexH60w6gsbb+4sB53oqQbAR9wUAlDXCHjuA4UXfhCrcfZ0EFjYi6Mq7eO5aVFucqDOh0/G7xHVCc714B4wvYR9+rQ3c0PK+O+G06eNtnAlWpL//GBmJUOEdHh3s1yEp1CTNiWsC3e4m4zH46IKMqLixu65IA6edysWZ4bjqqr808m+COiTqsRDKo7kQWUFP+i1W6CGf4SUebWRMgBiCoxqz12Kq0zAm62sOCcDcEAmB61PmjHoxSgQdp7bTvoLYNI3Yy6ZGVzQ70CXYdGrEPni34UUl2tDZrM4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CY8PR11MB7106.namprd11.prod.outlook.com (2603:10b6:930:52::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Fri, 13 Oct
 2023 16:07:33 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%5]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 16:07:33 +0000
Date:   Sat, 14 Oct 2023 00:07:19 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        "Aaron Lu" <aaron.lu@intel.com>, Tim Chen <tim.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, <x86@kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Bias runqueue selection towards almost
 idle prev CPU
Message-ID: <ZSlrN5zD0W5b48/6@chenyu5-mobl2.ccr.corp.intel.com>
References: <20230929183350.239721-1-mathieu.desnoyers@efficios.com>
 <ZRfKKxBzfu+kf0tM@chenyu5-mobl2.ccr.corp.intel.com>
 <0f3cfff3-0df4-3cb7-95cb-ea378517e13b@efficios.com>
 <ZSOMOhhkPIFmvz97@chenyu5-mobl2.ccr.corp.intel.com>
 <ebe4e40f-37df-40a9-9dfc-7f2a458151bd@efficios.com>
 <ZSZ2ERMysY7iEo+x@chenyu5-mobl2.ccr.corp.intel.com>
 <1ae6290c-843f-4e50-9c81-7146d3597ed3@efficios.com>
 <CAKfTPtA2cCy13DqL86PXcRh2P1xtSLWm1ap+uM0S8RnXc-fjRA@mail.gmail.com>
 <15be1d39-7901-4ffd-8f70-4be0e0f6339b@efficios.com>
 <CAKfTPtB__O8e2Skp6pFy+0E9bxmaS+bb06X7BMD2x9dP13b2LA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKfTPtB__O8e2Skp6pFy+0E9bxmaS+bb06X7BMD2x9dP13b2LA@mail.gmail.com>
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CY8PR11MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: 714563ea-eac7-4478-1718-08dbcc068278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kEmDWeyB0LYUJu1ogZS3cwLd9BC530pNkbm/Rwq98nkqqIz12xlwbdoOh7eGo6Qqg6GjtapLV6VhUTfR5HATfn7osinW+vvGvfLyTHuLvt5uyV7TbURWesL0bgzUgVW6e0agpobXce62Cr+HbzsYBuMl02ktHUI2ROb4bYyMz0gy9OsXbRifpJ5wuAgMbukZY6NXJxqY9LDvsYXE+kBbeXkzTMIod3TAqJRecqo2G5X2rOIQuMVvFJnVlgZkbv3+m9qMRUetxJt9zfEw2vWz03tJnW4e8N00sTw6feMPCTx8xcFsjPLPjlfyRl7cWBIPazGhWmGB2wJKtk87U5YVE4u44gl3yt4S6IKTLi//eleKlnst6liM0Zv0l8WZLYhUGI6anL3zS8AEBzDThD7qSQyFiuIOIImt3HvXGneGr5+/5+D07fGZsNtAmKy5JzPAMmj16BlVuHWIoGj63+kEimMR6pvFaKc9w/XYz5YdkcchXRhxZzozbCf346vm2wtKfPrIYhS5bJKOmKRwF9ADN9TtennVZWX7fyftpVWme0bJNKruxN/fAm+llJSg1rv3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(376002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6512007)(53546011)(6506007)(316002)(41300700001)(478600001)(6916009)(7416002)(2906002)(8676002)(66556008)(54906003)(6486002)(66946007)(5660300002)(4326008)(83380400001)(4001150100001)(26005)(8936002)(40140700001)(82960400001)(66476007)(38100700002)(86362001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IQkEUBo/TkYttn/UGzf/Fm0eFs3vy5zAd5F4IPHNGhuAt4Q7XmYr43x/FDoG?=
 =?us-ascii?Q?hMdBKhNbGKmRjPmTzbIUSWLPKQxuX7P2Ch86SQImhExnTaMRcDJggzDo23uf?=
 =?us-ascii?Q?rsss/5RxJh5LgAu5P3EguqjcSewykouqzXn1Qewf6SDWkHm1y8NpbE9xpyf9?=
 =?us-ascii?Q?5I1RCHy3ixtjb+6DZ4Oi7Fk4lMUP7ycxtslt+0IFdcktd3OZx+M0xZ9aTZHI?=
 =?us-ascii?Q?cm1oNn53BupDmIcfTHNwsrV/2LsGzvJnzBDCzxQS+O7N2RHphUurC6p2YZxK?=
 =?us-ascii?Q?JdKBOsl1i1pDj5nS1w5g7Hpv0mQWZo8GkrZug89jCyTWlve6hJnIoUGQUdh8?=
 =?us-ascii?Q?bDF40t6mIbFHsxPMJKP8Z/SvEyE1yx0bH2xEHOoskoD33rLYmJ8EA4EMJgfk?=
 =?us-ascii?Q?08o73AGNj1vAN7KsBL2PqiAj6tFhGFLfGeMfKTh1YwPdT7P0UVN9uqAQxS7D?=
 =?us-ascii?Q?v2UxbfPQ9AQKbJkpeXLSHTodP/bwwSLeh1HZ1EBV+GPKFAfHbV7lju0kQpR1?=
 =?us-ascii?Q?sfOduz7x5ACIWHdDjwSwXT6P1CdkkkuQCXYAVjAZtawBAKBu1sbaZYzWeK3V?=
 =?us-ascii?Q?FM9oxRnei2TVBIQwJw0jqHAt9s8/VWQOJvE6ipPraBgCy3Rjbq3rI7dgnmfA?=
 =?us-ascii?Q?vPt4tKHlS08vgAydkuuUraRYeHzy2qyJbm1egsR+sDY5kHfX4RPhhtOWGNiD?=
 =?us-ascii?Q?Lnn8eQ64HA8zGwF6K+4H2MAZjuuJkGa2UNnZvUJvJbA9VtQbMwRZssUd0DRn?=
 =?us-ascii?Q?qbjDfNh15oi/3NUcgyM9rJ/nUYK5J+WECRuYdbGiozmVQGC3S4To+pTYnj9B?=
 =?us-ascii?Q?lnVwj7Df8Zz+29fKSW2MOzPNCe09JdOfKK4gTfB/TeiQmjEHG/y4RxubzhpE?=
 =?us-ascii?Q?I0044wGPpdTNHC0U8trhTLDGgsZzuP8ohp6tjtP9+TQwxuUpoaV1tJKJWF4S?=
 =?us-ascii?Q?2YvAC405t/0nb7PGogjFyN5eROjxD3M7fY9dgJPDKHODZo19boJZ3EMN5mwO?=
 =?us-ascii?Q?822lz6fRVsoVpgbcub5kSBBZRcmcdlYtaU/vqMj9PkvZEDs7UhSK+TaWUFc0?=
 =?us-ascii?Q?FKHRhLUb9YjbX7COoBBVCqXqAnMZke/LEtttM4+Es52cclHUt8CzvJQ38DQD?=
 =?us-ascii?Q?v/WUWy1b+ZYhSRYBP1XZiXp3woxLAPkBrdWhrlUGprHY/vPZZtG8fGEn+HSd?=
 =?us-ascii?Q?Qe2I79SjT8sQrxYbjfEvFyEQiMTxt8I5nEhif7GxS8BVVmnJUagDxL6s6DVv?=
 =?us-ascii?Q?YAWkxf/PHTNXZfKTrLi/pcN3ctNwwg/Y0jxcrmBpBJTWBA0s5EopmWLT1oG4?=
 =?us-ascii?Q?Skmh5tQY4truhfQREQPnPnMgM8xg40zvoKcovDL3M7CosR2Sul+gUe8esrhu?=
 =?us-ascii?Q?QAytWxxu05urEDAeWFXerZYNT3cTcjAuPo7KoHv/psCCGX73cbVxE00xI+WQ?=
 =?us-ascii?Q?2FWrPEnwWM+wx8e64r2746duIucqdvyiwnIU7eZ0ujRsePp17tq2/KOdOB4Z?=
 =?us-ascii?Q?xMwnh8Sl2Vtz/hC5NOO+WkHgyCH09rWgRztWhKIH4SGfolev6rQ2mMfdg04t?=
 =?us-ascii?Q?5wLPeAHChqvL89cy9aupBvIj8OZZtNVa54YxS9St?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 714563ea-eac7-4478-1718-08dbcc068278
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 16:07:33.6290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZS5quSGXwgSaqEOb+C0DZ/0xtU0FA78kXCUqZ6uffc/YpEhb/06xDPHpjKA24ZM3mTUhRjMT701ZaNGWQaKcPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7106
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

On 2023-10-12 at 18:24:11 +0200, Vincent Guittot wrote:
> On Thu, 12 Oct 2023 at 17:56, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> >
> > On 2023-10-12 11:01, Vincent Guittot wrote:
> > > On Thu, 12 Oct 2023 at 16:33, Mathieu Desnoyers
> > > <mathieu.desnoyers@efficios.com> wrote:
> > >>
> > >> On 2023-10-11 06:16, Chen Yu wrote:
> > >>> On 2023-10-10 at 09:49:54 -0400, Mathieu Desnoyers wrote:
> > >>>> On 2023-10-09 01:14, Chen Yu wrote:
> > >>>>> On 2023-09-30 at 07:45:38 -0400, Mathieu Desnoyers wrote:
> > >>>>>> On 9/30/23 03:11, Chen Yu wrote:
> > >>>>>>> Hi Mathieu,
> > >>>>>>>
> > >>>>>>> On 2023-09-29 at 14:33:50 -0400, Mathieu Desnoyers wrote:
> > >>>>>>>> Introduce the WAKEUP_BIAS_PREV_IDLE scheduler feature. It biases
> > >>>>>>>> select_task_rq towards the previous CPU if it was almost idle
> > >>>>>>>> (avg_load <= 0.1%).
> > >>>>>>>
> > >>>>>>> Yes, this is a promising direction IMO. One question is that,
> > >>>>>>> can cfs_rq->avg.load_avg be used for percentage comparison?
> > >>>>>>> If I understand correctly, load_avg reflects that more than
> > >>>>>>> 1 tasks could have been running this runqueue, and the
> > >>>>>>> load_avg is the direct proportion to the load_weight of that
> > >>>>>>> cfs_rq. Besides, LOAD_AVG_MAX seems to not be the max value
> > >>>>>>> that load_avg can reach, it is the sum of
> > >>>>>>> 1024 * (y + y^1 + y^2 ... )
> > >>>>>>>
> > >>>>>>> For example,
> > >>>>>>> taskset -c 1 nice -n -20 stress -c 1
> > >>>>>>> cat /sys/kernel/debug/sched/debug | grep 'cfs_rq\[1\]' -A 12 | grep "\.load_avg"
> > >>>>>>>       .load_avg                      : 88763
> > >>>>>>>       .load_avg                      : 1024
> > >>>>>>>
> > >>>>>>> 88763 is higher than LOAD_AVG_MAX=47742
> > >>>>>>
> > >>>>>> I would have expected the load_avg to be limited to LOAD_AVG_MAX somehow,
> > >>>>>> but it appears that it does not happen in practice.
> > >>>>>>
> > >>>>>> That being said, if the cutoff is really at 0.1% or 0.2% of the real max,
> > >>>>>> does it really matter ?
> > >>>>>>
> > >>>>>>> Maybe the util_avg can be used for precentage comparison I suppose?
> > >>>>>> [...]
> > >>>>>>> Or
> > >>>>>>> return cpu_util_without(cpu_rq(cpu), p) * 1000 <= capacity_orig_of(cpu) ?
> > >>>>>>
> > >>>>>> Unfortunately using util_avg does not seem to work based on my testing.
> > >>>>>> Even at utilization thresholds at 0.1%, 1% and 10%.
> > >>>>>>
> > >>>>>> Based on comments in fair.c:
> > >>>>>>
> > >>>>>>     * CPU utilization is the sum of running time of runnable tasks plus the
> > >>>>>>     * recent utilization of currently non-runnable tasks on that CPU.
> > >>>>>>
> > >>>>>> I think we don't want to include currently non-runnable tasks in the
> > >>>>>> statistics we use, because we are trying to figure out if the cpu is a
> > >>>>>> idle-enough target based on the tasks which are currently running, for the
> > >>>>>> purpose of runqueue selection when waking up a task which is considered at
> > >>>>>> that point in time a non-runnable task on that cpu, and which is about to
> > >>>>>> become runnable again.
> > >>>>>>
> > >>>>>
> > >>>>> Although LOAD_AVG_MAX is not the max possible load_avg, we still want to find
> > >>>>> a proper threshold to decide if the CPU is almost idle. The LOAD_AVG_MAX
> > >>>>> based threshold is modified a little bit:
> > >>>>>
> > >>>>> The theory is, if there is only 1 task on the CPU, and that task has a nice
> > >>>>> of 0, the task runs 50 us every 1000 us, then this CPU is regarded as almost
> > >>>>> idle.
> > >>>>>
> > >>>>> The load_sum of the task is:
> > >>>>> 50 * (1 + y + y^2 + ... + y^n)
> > >>>>> The corresponding avg_load of the task is approximately
> > >>>>> NICE_0_WEIGHT * load_sum / LOAD_AVG_MAX = 50.
> > >>>>> So:
> > >>>>>
> > >>>>> /* which is close to LOAD_AVG_MAX/1000 = 47 */
> > >>>>> #define ALMOST_IDLE_CPU_LOAD   50
> > >>>>
> > >>>> Sorry to be slow at understanding this concept, but this whole "load" value
> > >>>> is still somewhat magic to me.
> > >>>>
> > >>>> Should it vary based on CONFIG_HZ_{100,250,300,1000}, or is it independent ?
> > >>>> Where is it documented that the load is a value in "us" out of a window of
> > >>>> 1000 us ?
> > >>>>
> > >>>
> > >>> My understanding is that, the load_sum of a single task is a value in "us" out
> > >>> of a window of 1000 us, while the load_avg of the task will multiply the weight
> > >>> of the task. In this case a task with nice 0 is NICE_0_WEIGHT = 1024.
> > >>>
> > >>> __update_load_avg_se -> ___update_load_sum calculate the load_sum of a task(there
> > >>> is comments around ___update_load_sum to describe the pelt calculation),
> > >>> and ___update_load_avg() calculate the load_avg based on the task's weight.
> > >>
> > >> Thanks for your thorough explanation, now it makes sense.
> > >>
> > >> I understand as well that the cfs_rq->avg.load_sum is the result of summing
> > >> each task load_sum multiplied by their weight:
> > >
> > > Please don't use load_sum but only *_avg.
> > > As already said, util_avg or runnable_avg are better metrics for you
> >
> > I think I found out why using util_avg was not working for me.
> >
> > Considering this comment from cpu_util():
> >
> >   * CPU utilization is the sum of running time of runnable tasks plus the
> >   * recent utilization of currently non-runnable tasks on that CPU.
> >
> > I don't want to include the recent utilization of currently non-runnable
> > tasks on that CPU in order to choose that CPU to do task placement in a
> > context where many tasks were recently running on that cpu (but are
> > currently blocked). I do not want those blocked tasks to be part of the
> > avg.
> 
> But you have the exact same behavior with load_sum/avg.
> 
> >
> > So I think the issue here is that I was using the cpu_util() (and
> > cpu_util_without()) helpers which are considering max(util, runnable),
> > rather than just "util".
> 
> cpu_util_without() only use util_avg but not runnable_avg.
> Nevertheless, cpu_util_without ans cpu_util uses util_est which is
> used to predict the final utilization.
> 
> Let's take the example of task A running 20ms every 200ms on CPU0.
> The util_avg of the cpu will vary in the range [7:365]. When task A

It took me some time to find out where 7 and 365 comes from(Although
Dietmar has once told me about it, but I forgot, sorry :P ). If I understand
correctly, we are checking two scenarios. One scenario is that A runs
now and this has the least decayed running time(max). The other scenario is
that A has slept for a while in the latest 1024us window, thus the min value.

For a task running A ms every B ms,

scenario1:

                     now
                      ^
                      |
 ...|--------|--A ms--|
 ...|--------B ms-----| 

util_sum = 1024(y^0+...+y^(A-1) + y^B+...+y^(B+A-1) + ...)
util_avg = util_sum/(y^0+...+y^n)
         = 1024(1-y^A)/(1-y^B)

When A = 20, B = 200, util_avg is 365

scenario2:
                     now
                      ^
                      |
 ...|--A ms--|--------|
 ...|--------B ms-----|

util_sum = 1024(y^(B-A)+y^(B-A+1)+...+y^(B-1)+y^(2B-A)+y^(2B-A+1)+...y^(2B-1) +...)
         = 1024 y^(B-A)(y^0+...+y^(A-1) + y^B+...+y^(B+A-1) + ...)

util_avg = 1024 y^(B-A)(1-y^A)/(1-y^B)
When A = 20, B = 200, util_avg is 7.

Just wonder if there is any description for this in the kernel, and if not
does it make sense to put this description in it(either in the comments or
doc)? As it might be useful to estimate the util_avg based on the task's behavior.

> wakes up on CPU0, CPU0 util_avg = 7 (below 1%) but taskA will run for
> 20ms which is not really almost idle. On the other side, CPU0 util_est
> will be 365 as soon as task A is enqueued (which will be the value of
> CPU0 util_avg just before going idle)
>
> Let's now take a task B running 100us every 1024us
> The util_avg of the cpu should vary in the range [101:103] and once

May I know how we get 101, 103? I thought for task B, the util_sum
is 100 * (1+y+..y^n), and the util_avg is util_sum/(1+y+...+y^n), so it
is always 100? Am I missing something?

thanks,
Chenyu
