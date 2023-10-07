Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2217BC417
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 04:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjJGCKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 22:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjJGCKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 22:10:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03FDBD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 19:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696644647; x=1728180647;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ekakJqJQ8Rc/Db+uBcvIIMQHppqb46j1KBLdTNx3jIY=;
  b=oJNrFNw6kcO1DFjPYxo4LubVZllceQC9UO4ANngnTQF1I+xcrziKaJ7q
   jJmOyiOA9HzuJRd9e2tTqB8zcvhG3/O8+bjcUQQRhfh6rSA+HeD4v/CSK
   E+BG6X4Yh/PshPh54EJ+nInGG+XHHwF8KTGthQLfLPGOPMR5kyidrGc9V
   Q4slKiDXly/3BeoxVKgYytonQ9uibaPcmb4dOpsKpZz5LJ2E4vgtaiL2U
   yE67S2icVw8Hq3adSjvGOLGdHmtWKO4wiWBd8pCuIClF1AB5HpBDnXcHe
   rh8AdgCTp3JojjVZhPa3CIhwsYkvaRa6W1NsVjDfdqjS3GuQDHINrp+xs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="364160494"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="364160494"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 19:10:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="926160484"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="926160484"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2023 19:10:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 19:10:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 6 Oct 2023 19:10:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 6 Oct 2023 19:10:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYs3dibLxxsboGQT0FWFZdhYn+fUUHOcFm1xOzXE05I+yd76te/4xkLf3vQZnrKdJ6sT63bMFfSHTmbIkygHgx943eH8MwjJ5jRHm6ZvfiBUUlSCTMtIlYcA0FlMhh9R/7s3ZYfFrsf9hvvy707tkExEA1Se8QCt2EwWDTyIsrm0fBLAHNvY/qR7xB44EjL2BoX70nv1KbLnYY7ALdDaPtlRGj0X+bTwcn5LchUEH9jLQ5OJJg6bqAM3LdD64aLA2huGoX25kyIKWvesKT8OVh4MLWTihXyADP44nvyfcU4yBErZN/CBfHndpOEJxt541kBbvNtEX5HD5WsmtKn3uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gXv7KxLY+T+xryLiKm8bpJwYe9g7nyCdALjzzmRSMk=;
 b=V75bLKWPsNtR6cRlsugE1DIPFqhoeMmCgYOEa0n+9DFWuRYUfN5lw2XlrkqU0hhAUP/3JL3TUW/hLzDwoRUab9F/4Zbeo/fNxZsflfuyiEl9GUD6+qxPNLUkMMNE92LB90JLDr/ELgbaAOT58XFxR1kEsUh+avwudYNdBohTY4a74tCbhL0iP9g8hHQCwgFAL4C0APn5U5Nh6ke9kG/7BTHsl50k0RrdiykoLnwpdkut3gOZxIU8GOoNVqWh1RcYN63sAY8K2UkGtr61ONKe5N3UhmbRlKBkHUFx2meDSRmXvfd1EhFmAwFAXQgkQkgWnRD63Adtn2eBniDzslkbjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB5918.namprd11.prod.outlook.com (2603:10b6:a03:42c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Sat, 7 Oct
 2023 02:10:44 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%5]) with mapi id 15.20.6838.033; Sat, 7 Oct 2023
 02:10:44 +0000
Date:   Sat, 7 Oct 2023 10:10:28 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     David Vernet <void@manifault.com>
CC:     K Prateek Nayak <kprateek.nayak@amd.com>,
        <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>, <tj@kernel.org>,
        <roman.gushchin@linux.dev>, <gautham.shenoy@amd.com>,
        <aaron.lu@intel.com>, <wuyun.abel@bytedance.com>,
        <kernel-team@meta.com>
Subject: Re: [RFC PATCH 3/3] sched/fair: Add a per-shard overload flag
Message-ID: <ZSC+FLLbia6YpSLt@chenyu5-mobl2.ccr.corp.intel.com>
References: <31aeb639-1d66-2d12-1673-c19fed0ab33a@amd.com>
 <20230831104508.7619-1-kprateek.nayak@amd.com>
 <20230831104508.7619-4-kprateek.nayak@amd.com>
 <20230831191103.GC531917@maniforge>
 <258c9412-445a-04f5-dd0d-1f6699a257b6@amd.com>
 <ZRPS0cQo0/XcbkOj@chenyu5-mobl2.ccr.corp.intel.com>
 <20231003210511.GB30978@maniforge>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231003210511.GB30978@maniforge>
X-ClientProxiedBy: KL1PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::32) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ0PR11MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb732b0-e5cc-4ab6-e788-08dbc6da9cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EsxnJUD7ZYzf57Ks9W82GvRfL1bd6DLsIBI1yJni/eNXSEAnmFpvDVTr6FExwobm/lloW4Tii/5/t1Sm9KjPbTuGvih2AuAHu1RS+j41eY6YBPFxf90wHHdYtnYcLSn1zrHjCNnk3/091xBqNaIOdUCJU4UImmYc5FkDKWTd78NhSYQtxeXvNpVbn98FQz7EmLKvI7TvFba+WkHXEKJmiUnA5okseVcqijJF0NIZizTxnREgJ4264EqrXee0Y9oUR+wJP3+XWQ23b66uYf24HdiGoUg7V2HGmR4ARb7kup3itQ4rSD6jj6JBobNv8IEO4fFn216I0DCmqfa5gyz7F1Nj7SbYqzibdbqheo0Hm5ccGCwCjd28tzpCTgxr9KfzlL9j25MO2vi10tDLVC/Wu+nLISk8jV7EhOfCRWG7dcpZvGdhdFe+Ug1KHw61EmqgbCVprzWMfnEn5AxtUGY0CaZm9EAU4BeylwhC56b/ZeNQ6wcSH1BYO6bD+m6p2FddPrazfrIk/pWYi9HEjXzuvPq0aPtHzXL92CHucd/QOr0CQUlB0dhAJX81Cc8VMBri3IQUd1TJ+pllToYOnngojgExzZR0oZyHwtgtNsmvqSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(66476007)(66556008)(6916009)(66899024)(41300700001)(66946007)(53546011)(6512007)(6506007)(26005)(6666004)(6486002)(83380400001)(82960400001)(86362001)(38100700002)(478600001)(316002)(7416002)(4326008)(2906002)(8936002)(8676002)(5660300002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HQCjGD2F1YbIRtZ+kA8XKtI83LFIOZ3BQJdUKjxqvYqWM/kYJeclgZq3FKFL?=
 =?us-ascii?Q?cK6j3NFLRiifEdH1dfIaYguG32nIuuE5fHOq8EA1VFvPVN5AqOvIvF+MABYx?=
 =?us-ascii?Q?FPsQFTVg3SU7+hm07lcRCuQkMqV32Jtc0mBnJ5+aM5tJ84nxIOesiIj6kmNC?=
 =?us-ascii?Q?x6jYK4F3kKQr49sve658rDj+ZsoQH9/28J3F7gQTQvXDOYB2gGeqVpvM3sP4?=
 =?us-ascii?Q?LMpIh2krR3rHsmJ4gRfTfQsm2Q+iYIr72R/xDyf02Xgkd1iLtjBOrIGEImF2?=
 =?us-ascii?Q?gSxaCR8m+cQvfBl9Og6oA0dC6kUMxanJP2QAljYfVBUT2YxY/SbCy6VMuELu?=
 =?us-ascii?Q?4bok+2yLW/m77on+vekCqMc9lI/sxzH2pdeOs9OBg9XyXy7fKrewXw4ZVD8t?=
 =?us-ascii?Q?0etwsWnJFFj5uDyK1IAkPXiHG5bZw4GZAGJTvDQF8XQcABfLtncHGlIrISKq?=
 =?us-ascii?Q?S/MsMci6hR286C0mp9pq7h5mUd1vBCOm0ACoySLeBqf+AyfCGvvXEU2B30XI?=
 =?us-ascii?Q?KGx7XWQFKwPbqcfd3lEiuke2qnOdvTfSHFHEp/nHia9nH5FGrGzPNdjloPDT?=
 =?us-ascii?Q?b5mdwvGxiYsYzYgAG+eyrn7z5wx1Kr7aMA7JWEN6+Llq4D6IQb6TIUVIvp2c?=
 =?us-ascii?Q?FYZChyJqueohy0lN0qI97Pnsjl/ahF4bMK0MloNHoYffNRG/FscyyCiQus2g?=
 =?us-ascii?Q?RqUMb45ewmwm3NwmXKol5OVaW7NH7FpdJvdQ1pa9IlkwHK5Mq+3f9py1QE13?=
 =?us-ascii?Q?W8Ltm6zPnRvKxbf9h6tSFCK+KibAPKEwUbOvMKUQu+SHFL9oOoJuQoCnrPim?=
 =?us-ascii?Q?750eh+iafCpO7zcbtZJ9FfRUmASMDDCApG1vAh6iKGRP5STv5vs4QdF1KSuf?=
 =?us-ascii?Q?PaKldYkcIuC8JDGCHP/CJRyo1JlZUG2QGE9L6GqtMmwTCTwJ6vGK0zHUJtah?=
 =?us-ascii?Q?m94DFKVSGfXZXPtIwOcMLGpn9yAEO9WYadd2mXsOJAi+e0lRRHHrYqQ249ba?=
 =?us-ascii?Q?IHKOdNXfHVgMA9DGsmOa63IBcjCxDQgBeJCQ2OVQ5xTgFTYCaZVG0qlmnOvr?=
 =?us-ascii?Q?Qi3LUVzBh2qmrpc488sWCTMV72BCGSQkk7RtSNIo8OfrqqWRiCmqIegLMykJ?=
 =?us-ascii?Q?Zqb7S7KZiXPFcjW0cP1fNsdnqj/O+f4nRVNv0MK76inXkhSP2sKDsQ8R0yvB?=
 =?us-ascii?Q?H1YIYIylBofQ6siqztWhjAn/HY0lDp8vkcjkp+P0seJJWstsLdBjOUlqvmTT?=
 =?us-ascii?Q?KLxSMqFCIQ9K1UKUTsGXHCmXH6TEDqptEStAsYl/Y35jgHtzvoNUcNldjU00?=
 =?us-ascii?Q?7OBUNW1EiPyr/yHkVpRkWQrqeNve+Aeqj8956Aqg2a9Lt/vAE6OtNNVjHM//?=
 =?us-ascii?Q?N2MMUDaZi0/M/fhn7b0BQu2/jquq21Pg0OqNbzqOwSEoP7f2ztQ3xuo1YV4O?=
 =?us-ascii?Q?gKSdkXGAme8hXyIMvbmUjMzyEN4j9vKc6tvk84eLxfAtT2Fh/q43N6q8l/YR?=
 =?us-ascii?Q?iaBV9DRdFpe5XhgQJijC8OapuO4swGH3kdnoGnOrBAogwqIrawgSNXwgd1sd?=
 =?us-ascii?Q?mklcHFaG1CXWeA8v70nB3TwxGHC6e0vjlQ/5sYhs?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb732b0-e5cc-4ab6-e788-08dbc6da9cd1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 02:10:44.5162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIHe+9pjkhxThvWyinnBtswqId0+ssPdmmqshx42cZVySh2xmGixvJGqx858C5cSK2HKKV2rilRb1dJXZlL4Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5918
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

Hi David,

On 2023-10-03 at 16:05:11 -0500, David Vernet wrote:
> On Wed, Sep 27, 2023 at 02:59:29PM +0800, Chen Yu wrote:
> > Hi Prateek,
> 
> Hi Chenyu,
> 
> > On 2023-09-27 at 09:53:13 +0530, K Prateek Nayak wrote:
> > > Hello David,
> > > 
> > > Some more test results (although this might be slightly irrelevant with
> > > next version around the corner)
> > > 
> > > On 9/1/2023 12:41 AM, David Vernet wrote:
> > > > On Thu, Aug 31, 2023 at 04:15:08PM +0530, K Prateek Nayak wrote:
> > > > 
> > > -> With EEVDF
> > > 
> > > o tl;dr
> > > 
> > > - Same as what was observed without EEVDF  but shared_runq shows
> > >   serious regression with multiple more variants of tbench and
> > >   netperf now.
> > > 
> > > o Kernels
> > > 
> > > eevdf			: tip:sched/core at commit b41bbb33cf75 ("Merge branch 'sched/eevdf' into sched/core")
> > > shared_runq		: eevdf + correct time accounting with v3 of the series without any other changes
> > > shared_runq_idle_check	: shared_runq + move the rq->avg_idle check before peeking into the shared_runq
> > > 			  (the rd->overload check still remains below the shared_runq access)
> > >
> > 
> > I did not see any obvious regression on a Sapphire Rapids server and it seems that
> > the result on your platform suggests that C/S workload could be impacted
> > by shared_runq. Meanwhile some individual workloads like HHVM in David's environment
> > (no shared resource between tasks if I understand correctly) could benefit from
> 
> Correct, hhvmworkers are largely independent, though they do sometimes
> synchronize, and they also sometimes rely on I/O happening in other
> tasks.
> 
> > shared_runq a lot. This makes me wonder if we can let shared_runq skip the C/S tasks.
> 
> I'm also open to this possibility, but I worry that we'd be going down
> the same rabbit hole as what fair.c does already, which is use
> heuristics to determine when something should or shouldn't be migrated,
> etc. I really do feel that there's value in SHARED_RUNQ providing
> consistent and predictable work conservation behavior.
> 
> On the other hand, it's clear that there are things we can do to improve
> performance for some of these client/server workloads that hammer the
> runqueue on larger CCXs / sockets. If we can avoid those regressions
> while still having reasonably high confidence that work conservation
> won't disproportionately suffer, I'm open to us making some tradeoffs
> and/or adding a bit of complexity to avoid some of this unnecessary
> contention.
> 

Since I did not observe any regression(although I did not test hackbench
yet) on the latest version you sent to me, I'm OK with postponing the
client/server optimization to make the patchset simple, and Prateek
has other proposal to deal with the regression.

> I think it's probably about time for v4 to be sent out. What do you
> folks think about including:
>

It's OK for me and I can launch the test once the latest version is released.

thanks,
Chenyu
