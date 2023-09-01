Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F06C78FE8F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjIANqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244180AbjIANqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:46:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84F6199F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693575953; x=1725111953;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cDNuASRGQxXQAJm3vxGA8pliWEcSaNfEAaH3hJoGrXM=;
  b=C9P9i1wVWwAPH7BLYSZS/0tvaXTsktgep0oZpc05fsel3V4nzwCz2qit
   vwzhznljZ0Hugh/ewj+SwmFWSW5S9BuLfSdPYPGpHH6SDJxYw0VMTKpby
   j7wqXlyqZQ4JxDUQSaH1I6J5MaMsWVW+DDD+Ow88jg3GIFpFBsRC06l2d
   Umraqlm3vGKGUkSlYgni4xuLuHLhovfdwGRVsqIuTWhKBjkkP1J9CxblK
   70DTUsgjpP5NAqHZQ7vOXbiexnBImvWOE2Lq2QPK2+8IzdluMLyG41+qq
   RapWRPHwvABX5CZQDN2+7yr/HjgY2ms2J3v2Hy/eo6YzF84FtOiPh74VB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="361247830"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="361247830"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 06:45:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="733532559"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="733532559"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2023 06:45:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 06:45:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 1 Sep 2023 06:45:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 1 Sep 2023 06:45:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3ObJh29/lSNx5NnysusQYyRmWXi68ZLF9IAl5RM9O8wtyl2Lm9qEzm5GY3v7LCTk72zsSwIuP0gfNaMYQI1gTKxGEyy0BfoNtslAO1kxnGXvEtrRsHWUIgbiiXPM3X78EUq6fIj8IaPVvY4l6LqZnUhCxyLC42jbTpagKrTt2lR2eBIDGvHllXHTyKrZsGrD5bSxFiWEFjLbjKbxZIyd1d0bcr3OEkKz/cRsI1tq4w0PcAHVYBjyTOKJ0himq+SJD9zkOcf8HW/PIjyUUG1N/JIxBDPJu7qSxnc8fOig0YRohl/UAXgKpo0rYUvhVH8twWfG22A0GAVkrD9/M8qQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IylgQ2xE91gnSHcEpmdRErtYxbWXvTov+06B8kr7oig=;
 b=LwfAZLzt3IEA9b+R8ZStEuSIFXxlDUvFduXrQlRy6WoPJIFj7xo8VdDD2h1gQq2z4nRM1pWIyWfzibS9LqMaSAqaeJ7PB7ai1UESiDiPiIGlUOaUQGyyDYA73H6ouHsTkfMAMAxrzSMLIpHBYqHjYfEapyRYdKr2MrOQdMHJsC2EDxNjehJwcdcwYlrz50B4yUzKfbJOQoGhw2hV9zIq64sKVmt0dllFP4fl+1uUbIPV6Hug7o5rrQZ4z9rdeBmksumnw7ZgbGJNlTlMKR/KPEIYHbYG3uHt34fnOawN6aKO0VJ+uS2OQFD4HtAwWG5FNTV54YjSUxoK0hg/ytZUzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SN7PR11MB7065.namprd11.prod.outlook.com (2603:10b6:806:298::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.26; Fri, 1 Sep
 2023 13:45:42 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::d0db:d23:1d85:ed85]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::d0db:d23:1d85:ed85%4]) with mapi id 15.20.6745.020; Fri, 1 Sep 2023
 13:45:42 +0000
Date:   Fri, 1 Sep 2023 21:45:28 +0800
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
Message-ID: <20230901134528.GA46365@ziqianlu-dell>
References: <20230822113133.643238-1-mathieu.desnoyers@efficios.com>
 <20230822113133.643238-3-mathieu.desnoyers@efficios.com>
 <04be42cb-0e8b-25f7-a34b-41b2873f39d4@efficios.com>
 <c7fe33f9-51bd-80e8-cb0e-1cefb20a61b9@efficios.com>
 <20230824075208.GA459974@ziqianlu-dell>
 <6e5ff343-0c4f-526c-eb53-890afb773563@efficios.com>
 <20230825064929.GC464990@ziqianlu-dell>
 <73d2be82-b4da-f87e-a1e3-5c187a268e69@efficios.com>
 <20230828111945.GA504382@ziqianlu-dell>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230828111945.GA504382@ziqianlu-dell>
X-ClientProxiedBy: KL1PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:820::18) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SN7PR11MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6a1ce4-443a-49cc-e526-08dbaaf1bbf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EDC6ea85WgyGsHPMZ5DKVNc1C6rqOjr6yv21gDMc4TbutHMpFVijGHCqs4kYRHzKp4wZdY40jMcuHh2CbPKNde/1A/xCGdhNfcYEsHfL9vdtGa6SdRfCacZZeV0dC6Vz/KolIADa+dR6YP2x6SKpKmrHoQnrbiO3NXNZCOstF6chKsaAe2qBqMuwMQt/TI3HeXLq4+phbXVYAcT29UyReKVuuJUhI6t3V9fgM+2DTgh0g74Zx+DUf88gruEgOahq3t1nkDltpzmQGBM6G5+VqrzYQaBh+pq1FBBQmaPKzuuFfMJLfRCJhU2hVzoDvMwqVyFByw+hllqhVkGn+a5FtF/D3Rjz09c0jVbqs7oXOdH1wSBB98h272HDXKihzyXR/RlXPlJSIN2LlaopqkNL+fhLStZWMd8Gtjp8XBZoIckWjY8MGyELAxlhpKPWy/xgI45xtiiTh7fx7pRUaCTQqQx8g9876/M30qf/CqaAwAjtmfKpVwzyovENbYbf3VWDXJa9Fs9y8c246Vt8gvx/ypNEdRrduY30nLEgBsNwG25XzoZzkIBaG6QbQc2gJQgn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199024)(1800799009)(186009)(33656002)(4326008)(8936002)(8676002)(44832011)(6916009)(86362001)(6506007)(6486002)(66556008)(66946007)(54906003)(66476007)(6512007)(6666004)(9686003)(478600001)(41300700001)(83380400001)(53546011)(316002)(26005)(38100700002)(5660300002)(2906002)(7416002)(82960400001)(33716001)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Eb9tX+lC3kbSbGjAfUwx2N6E72KlBhjRaKTh6vc6dxxrQOUT2f7crbpE8L/v?=
 =?us-ascii?Q?Tdmb4/zEOe/tTG0LTn3VyqAuDvS1BYqeOV9B2Y2MSl96GHvNicJ8cnbDgg20?=
 =?us-ascii?Q?hO2OGMzr3Zco2/eRdXKf4uOEmlwjrVdXglD+ZwC3xBRUyv8ZiA0p/cngHtGC?=
 =?us-ascii?Q?9L4ilOIkKKlCjEqGeFYTie5ptY3z85P2H1GlAiAXh+McK4wE9A/smMmhm09X?=
 =?us-ascii?Q?jHZAiwMgHfZxQhqHvvsHZCDzQ1lai8Qv5ri57FoQM5gqCzAzAPl9VgYX3BOb?=
 =?us-ascii?Q?Ao2NUODoYdDUie0esESqv26ZinD1+/u72EPSgAolifjPeOtczK3e/JqUGjjr?=
 =?us-ascii?Q?vSFImcqzZpblh8qOz2qygUzxpb9oWc1BS7aDCxCcqNnLfXq19HqA80flodma?=
 =?us-ascii?Q?SAcizU1PETRfhsskCNdMS2kxUuxMjiFVot2q7QAtb9dsYhkvAbVjQYNd+J4+?=
 =?us-ascii?Q?lj7fxdi6t5lXaz+8WDCGMaExIeMM0M1L6edA1xp7EfGcWfRtV1mH7utKT7tt?=
 =?us-ascii?Q?wYxxIQ8IkNXp8Itt0NV53IWel4l74Xm+rDtahjMlYi73uu/x7shqmyxGe+o7?=
 =?us-ascii?Q?b9YmODwYRQhTyCrQJ7lWjnqY1CHkTQ0/Ctpharxg82cETuytPf/olY8bwHYL?=
 =?us-ascii?Q?KrL0s/AFysECG3COIZCiZtZpR6pxTrxoJrxetPWEV5W42sKq7nq6vf2YxwZB?=
 =?us-ascii?Q?u4oQxW5q0MBbhC6LP/wOXmE1qY5iSslWf7T84HJEX8ICNNRQLRL7ux8HevYT?=
 =?us-ascii?Q?EDZAeRXqZ/kollw0UVM0durxvBF2cejD/beuy4l1OcqBX6CzMIZ9yIH/YUwm?=
 =?us-ascii?Q?3hwcgr27WJZy9AiSMzw/zLX2mSDbYrUXyOG1K+jXIgCHB4ihLnlnDaWY2vbM?=
 =?us-ascii?Q?3+CMRRSnDlzrJdHx2m831lT7Tat0WKLI1jCQLcHBQxedOrKnBbRn1C1M0CiQ?=
 =?us-ascii?Q?X41328ts/OQZ7MjXfQhBpaDOV2qRXv2oEP7uqnE1c/Y1Zek6L8z0LzDrl2GU?=
 =?us-ascii?Q?8xFwxlkYIPKWAjSzkbOT6j+dB4ZZecRW7vM6TWVJC7cBygKbECDbDmIm+fes?=
 =?us-ascii?Q?GMzumE2UhJaKm6sAa38jIpBt6dYuccfLrvLQ6mOj9J6xtb0EzuI5JfaCHxx2?=
 =?us-ascii?Q?Yk7KMTwdycm2oDJqNKvPVXXs+OwIIynv0jIlnPFZWgfDa94t+a4/LQbumpLn?=
 =?us-ascii?Q?9DRMOvWao/McK5X32f5or0t+f2nGonDMQlnt+pxW68KJ2+i+kY0Xs44qsdnc?=
 =?us-ascii?Q?e92uSYZjo7M3iF1DeXaLZENn3f8DTtT2A0yyYSocnEirVZ/fGh/V4L38Uuu9?=
 =?us-ascii?Q?VNpDKexZON8EQb3Qfy5uu/uMdSRFcndopxn7YPEhHx6WSSUzxnZ2jJcRWfva?=
 =?us-ascii?Q?J2bTK+Yrvoc33mjxZRj6sO/gECTdBcxh+OHCEu/CPVAFrHGlleGqdm3cmeCp?=
 =?us-ascii?Q?JodDLu02pHR4pW2pZ1j1HVa/hlKYDN0tePrs0R06kxr9CPGPHMC6odm7MwYB?=
 =?us-ascii?Q?kN0i2DKWYagRyE9A/z2HiD91jYkMgwKf4RMZ+KOu066FUGh3AjNI9674xu/8?=
 =?us-ascii?Q?38k0cGFgMfjabYVZp+uW07QjVxmYYw6hin5slre6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6a1ce4-443a-49cc-e526-08dbaaf1bbf4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 13:45:42.8269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dvDQNsXjOkHJO/ffwfGcjlKpIht7sNbA1w6+eYnsYjEXJV6Qx8c7Aw4wv/6bxRaqUXuBEDFZL4KaNzz76tV0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7065
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 07:19:45PM +0800, Aaron Lu wrote:
> On Fri, Aug 25, 2023 at 09:51:19AM -0400, Mathieu Desnoyers wrote:
> > On 8/25/23 02:49, Aaron Lu wrote:
> > > On Thu, Aug 24, 2023 at 10:40:45AM -0400, Mathieu Desnoyers wrote:
> > [...]
> > > > > - task migrations dropped with this series for nr_group=20 and 32
> > > > >     according to 'perf stat'. migration number didn't drop for nr_group=10
> > > > >     but the two update functions' cost dropped which means fewer access to
> > > > >     tg->load_avg and thus, fewer task migrations. This is contradictory
> > > > >     and I can not explain yet;
> > > > 
> > > > Neither can I.
> > > > 
> > 
> > [...]
> > 
> > > > 
> > > > > It's not clear to me why this series can reduce task migrations. I doubt
> > > > > it has something to do with more wakelist style wakeup becasue for this
> > > > > test machine, only a single core with two SMT threads share L2 so more
> > > > > wakeups are through wakelist. In wakelist style wakeup, the target rq's
> > > > > ttwu_pending is set and that will make the target cpu as !idle_cpu();
> > > > > This is faster than grabbing the target rq's lock and then increase
> > > > > target rq's nr_running or set target rq's curr to something else than
> > > > > idle. So wakelist style wakeup can make target cpu appear as non idle
> > > > > faster, but I can't connect this with reduced migration yet, I just feel
> > > > > this might be the reason why task migration reduced.
> > > > 
> > > 
> > [...]
> > > > I've tried adding checks for rq->ttwu_pending in those code paths on top of
> > > > my patch and I'm still observing the reduction in number of migrations, so
> > > > it's unclear to me how doing more queued wakeups can reduce migrations the
> > > > way it does.
> > > 
> > > An interesting puzzle.
> > 
> > One metric that can help understand the impact of my patch: comparing
> > hackbench from a baseline where only your load_avg patch is applied
> > to a kernel with my l2c patch applied, I notice that the goidle
> > schedstat is cut in half. For a given CPU (they are pretty much alike),
> > it goes from 650456 to 353487.
> > 
> > So could it be that by doing queued wakeups, we end up batching
> > execution of the woken up tasks for a given CPU, rather than going
> > back and forth between idle and non-idle ? One important thing that
> > this changes is to reduce the number of newidle balance triggered.
> 
> I noticed the majority(>99%) migrations are from wakeup path on this
> Intel SPR when running hackbench: ttwu() -> set_task_cpu() ->
> migrate_task_rq_fair(), so while I think it's a good finding that
> newidle balance dropped, it's probably not the reason why migration
> number dropped...

I profiled select_idle_sibling() and found that with this series,
select_idle_cpu() tends to fail more and select_idle_sibling() fallbacks
to use target in the end, which equals to prev_cpu very often.

Initially I think the reason why select_idle_cpu() failed more with this
series is because "wake_list style enqueue" can make the target cpu appear
as busy earlier and thus, it will be harder for select_idle_cpu() to
find an idle cpu overall. But I also suspect SIS_UTIL makes a difference
here: in vanilla kernel, the idle% is 8% and with this series, the idle%
is only 2% and SIS_UTIL may simply skip doing any search for idle cpu.
Anyway, I think I'll also need to profile select_idle_cpu() to see
what's going on there too.

The above profile was done with below workload on a 2 sockets Intel SPR:
hackbench -g 20 -f 20 --pipe --threads -l 480000 -s 100

Thanks,
Aaron
