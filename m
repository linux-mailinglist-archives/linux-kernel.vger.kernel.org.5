Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BDD78AEAB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjH1LU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjH1LUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:20:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EA4BF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693221609; x=1724757609;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VCJBGsnJrE/BHqqSeRVGGmkT549J4PTRcgcWwmVcV7c=;
  b=TDNQVyLsC7cRyVy7O7xxleWB/qm01jkr3k1imZQ//onAcqpwxV2vZPdP
   AM0MrBUSwU7DRBfvhW7p/s5RxoqqSCWrFVebTHda+tAQwvIIZeJVGbLKt
   c40Nd5G6Z/Pq8X9Ff5DYUwZThvOUGc+E6/K1bGBD8Su6tGMKfo320HxYp
   t16u8DLgpQGydJcAam5lbCIxpCpihhbRSi6G9IfTUabv48sohYSrGrTQh
   epYs4LBa5v6F1FdrTj/WFiXIewNQM77Ss7IIuueB01DF0Wnvdo5HR9vqO
   4qTKoKdcvEPsSWNye5FS8DfSqWqUMZ0t0LHpHr7t67PcohI4ctxwtcIND
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="354599051"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="354599051"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 04:20:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="767629436"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="767629436"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 28 Aug 2023 04:20:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 04:20:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 04:20:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 04:20:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1q5ByrixRHOMU6N6/vNqlTtVmjo4IOFsn2IWDrIDNcRd3qeAgSA6aZBO+wsxK7bDC6Svd+VvxGIrUxdwSxSvr2A/NgV6wDaasuqTa6QJghK3fybc3f5U9u9r+/vVVZonoscNvuIb0lx/1US8Tp7EUlZgq0Vd9DM29YlryPPiusnMsD5R16AQaGxcfezA2j8J46ktHzKDa1Wd+a03ag0Y3lKQ6dbawdRAmGhX3KWcsh0N+Rbpbkafv+bT5DXYL+z+y3aT4c1XY2rmruMSErJxZFWvf/gPCa6c0Th2FfYb08UBbQKsi/XKXP9+j74z1PMexdUHY1UWC4x6fVYlj8vBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwLKDRagf8kyNfjSsm5VvFLK27liTWQhq/zHvtrNrjM=;
 b=cdb8zsb2L0y3BLlOD5BETP6yAmRD8A1yoZyAR2lKosL6pgAEaD7I0T87YlDk9+wTFNQpQwnVzoa0c+0XqKF3vghE9d7zMEVkUvtX+tRtgJVCBGV0toTD06innY3cXMMfAG/PZjeaM/BhLNxkgBVK3DHJ5RV9tBY55MWU8I5PCfoFJntyXe/DZhdq1d2fbPuQmrSC83bqFcd0RJGKAspkSUcJ52nqydpOkBrQgntFLu3A9ojS9dyd/Vu2ZJrdt7i3N29RdKBppS6KApIhvLIsoLWCSNspGd0MaTq83SlsWnsd1gWqry8hCyqywqLK4BwoeoDy42miptUPtZbpPkekkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SA3PR11MB7414.namprd11.prod.outlook.com (2603:10b6:806:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 11:19:56 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9a8d:9d34:4af2:f2e5]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9a8d:9d34:4af2:f2e5%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 11:19:56 +0000
Date:   Mon, 28 Aug 2023 19:19:45 +0800
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
Message-ID: <20230828111945.GA504382@ziqianlu-dell>
References: <20230822113133.643238-1-mathieu.desnoyers@efficios.com>
 <20230822113133.643238-3-mathieu.desnoyers@efficios.com>
 <04be42cb-0e8b-25f7-a34b-41b2873f39d4@efficios.com>
 <c7fe33f9-51bd-80e8-cb0e-1cefb20a61b9@efficios.com>
 <20230824075208.GA459974@ziqianlu-dell>
 <6e5ff343-0c4f-526c-eb53-890afb773563@efficios.com>
 <20230825064929.GC464990@ziqianlu-dell>
 <73d2be82-b4da-f87e-a1e3-5c187a268e69@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <73d2be82-b4da-f87e-a1e3-5c187a268e69@efficios.com>
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SA3PR11MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 91527db5-0413-4d5b-8b40-08dba7b8b526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C2+TJUI/O8phQE2AWL1+9SHIrOAfnazJdjqM/BK4FU9DQUBB+3Z2HfVmKlqVDRE/pWwAyImLKKlzvIWBdmut0oyziqskU1u/s+OJalURFCIUgf+Z14CEEFe7P32ssz5jDYkKfvOfGNyDj9/AeVjxeJ7cqJf29C3sF0VdZ4leJT2eWrHtRK6sYg9525ptQ0LZP70LPhUzZifbPmZShAgAlmTtii+rYdl/Jevn/jJnyEGZHQPf+2LsyiUV3dbrCcy/Db0oaMg6CVc19gB3BAqKJ7T4HdQE4C5HAF1YnaVbPrIgLj0L0QMJKI1AyKDrn5BY/FleszbiDKdDHepP60h1h5G7L8ollJ2e/mD0IjhjqOMEOYZruwmL5Zl7tHML48KxjgImM8vNikhVimFgFMkmuynDBhyspQkdcl45skQ0AOyvqNJcAiJtQBYJsXbUjYCJMZV6s31mcVXHCibMYB6N8nmtjW87Ot3B+NJvc94p61RwN+/0XVoj7SlAKlUn3QFF5l7CHyzyMLZQeT/Os5K7SKND8k7dVZL6u3DyIqAOIT80qj7YQhTZY1RLy2T0PdOs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(366004)(396003)(39860400002)(376002)(186009)(1800799009)(451199024)(41300700001)(7416002)(33716001)(38100700002)(6666004)(86362001)(82960400001)(478600001)(83380400001)(26005)(9686003)(1076003)(6512007)(53546011)(6486002)(6506007)(5660300002)(66946007)(6916009)(54906003)(316002)(2906002)(66476007)(66556008)(33656002)(8676002)(4326008)(8936002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4pNzlR5ZQKSPjCf1MM/DVRa7H3GCxUuwGdtV/DkuE1UyoX1IdechrFTnxWi9?=
 =?us-ascii?Q?bvUe/3pDWr49rAmZBI6tWslFvQJzSbs2y+V52RviugNU8CByYy92+IPobS52?=
 =?us-ascii?Q?MEnOyTPcOifecqBS1p81KZEYM8ApjdU4S/byLhci9I2r1yjSke7hG2cJWKsu?=
 =?us-ascii?Q?fneiM0CglXK3+i2dTUFw9tp2Tto9qzEJcFcSGQRQSqQ+0ydCGMrLXwQBb4Se?=
 =?us-ascii?Q?AaOsqVQTY9cDkhWFftCLoDMXHrsxH/5cmuuptJW15upmGllAhHSE1tXJocba?=
 =?us-ascii?Q?Cnte9lprUP5PQBAnZzaa3FkCMb0yHiMV72P36wjpb0Gf+kJ6r4e8XFLTYYYD?=
 =?us-ascii?Q?vEeddEMhIvEiJmzm8mfTlnTywrZi2jNIHeAN2FPyWqe65pg7KN/gTo5wzkCw?=
 =?us-ascii?Q?AJ/3Tn/YA5KOEp8nngKIBwFp7+IefzL+gVmDL2RdrPgs3gD5zFumLqAG/euo?=
 =?us-ascii?Q?Jn6IljirMDFCAjf2VwYs/wR/GbrQCMr3iqj/g6YDmiB0Uw8a0kWIemZEenD0?=
 =?us-ascii?Q?1de57V74ghKTEiZDME1q6v3Vc8u9nNAM4pTKPW8sTgViNHrYI2duE8uJm5V3?=
 =?us-ascii?Q?lbaSOkYuk7acbb/0rBOJsYZcDXfslB0lmyNtRM96oqb/nOeFl5Wucx4Yd/5c?=
 =?us-ascii?Q?svQ6E/svqhRBX+Cqi8kmWhuDoLGIlsuP4mpCnDYZEiX8BYlFnrzT0WD9UpHm?=
 =?us-ascii?Q?21Im5/tkkLAoAaWTDNgNduYgqrefnmh+DMIvaRU7yrrcLCsUVifGB5S1ht2F?=
 =?us-ascii?Q?0MH+OwmenudLKu4HOc9mcnZlGq8eiMn/mg4H7nZ7jBbI5CcahJ6LJ/wbWx/K?=
 =?us-ascii?Q?EFWvPNuo9Rcrkn5GeKIG4ifXKTyGOOfuwZxYdb3P57X08giOEbPJPDuVS5vt?=
 =?us-ascii?Q?nErXui81hzWwgdb7vsNY3iIqt9E2InSaMxRPPbYz9iKZwfOMW0A24nP0EIwh?=
 =?us-ascii?Q?pB90fkhdhmbS43VBYPik+cYb4CbnyTVUja31ET31H/QezKC3CMAqbrtWQxQj?=
 =?us-ascii?Q?zkFx2CR+pMN8lOX72AfJW6v0ybQyEs9Xg1qUfqyGPHDGZiU1vVN8tZ6nysWl?=
 =?us-ascii?Q?JW9wUdoIDtDrS8ai0GHni0Mxzru4u/cIZv5IeFsLIbVE3wu97z8V+iu8EfwL?=
 =?us-ascii?Q?KoSwAAGxAS7EAY6bGBjgacrpoJ1geGE9L0FRi581NYVAJY1IInzsVb55hofD?=
 =?us-ascii?Q?Si3d2zdRdnV8KatZIngVvPpRAjExqTU94hp5bB4vSx1f9x7gR2GBLLOOLnNA?=
 =?us-ascii?Q?lge0HOi66eW1plgVvy26YA0M18q/SchppGKRtcmy18PithrGVyEk/K/jx710?=
 =?us-ascii?Q?4I2tNNSqgZD3GBSizEnECbeoBncPAUqSe+0JQtbiDBYIdCftlvTkCAI5xfYL?=
 =?us-ascii?Q?X/HayWTnj4TPLY7RHcv2yEt+2ztgFjswUjQQ9RmPYqXOowuLvzwSriqFZQuA?=
 =?us-ascii?Q?ynEgk5hSaWG1u3LoXdIsmsRO9kSvbAerB4IRaH/D2d/ZeefhQjgLObZnXqfu?=
 =?us-ascii?Q?7Ep5CyR7mdW9ikTOaLqOqAJq4EmbMtPB4gf1+Pootjmj8WLjVCey240JGwth?=
 =?us-ascii?Q?8xXw9VlQBLD2StXDnQxtp6sUHsT8lKqHAmdDZl85?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91527db5-0413-4d5b-8b40-08dba7b8b526
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 11:19:56.1342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1OdeOCkuHMrgkPQvo0OrMQggENgWG9jVlbKe6FV6fXrGXvnrtxttBHN80CO/N1pkWXWyG34Pf1bxf5hzp95hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7414
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

On Fri, Aug 25, 2023 at 09:51:19AM -0400, Mathieu Desnoyers wrote:
> On 8/25/23 02:49, Aaron Lu wrote:
> > On Thu, Aug 24, 2023 at 10:40:45AM -0400, Mathieu Desnoyers wrote:
> [...]
> > > > - task migrations dropped with this series for nr_group=20 and 32
> > > >     according to 'perf stat'. migration number didn't drop for nr_group=10
> > > >     but the two update functions' cost dropped which means fewer access to
> > > >     tg->load_avg and thus, fewer task migrations. This is contradictory
> > > >     and I can not explain yet;
> > > 
> > > Neither can I.
> > > 
> 
> [...]
> 
> > > 
> > > > It's not clear to me why this series can reduce task migrations. I doubt
> > > > it has something to do with more wakelist style wakeup becasue for this
> > > > test machine, only a single core with two SMT threads share L2 so more
> > > > wakeups are through wakelist. In wakelist style wakeup, the target rq's
> > > > ttwu_pending is set and that will make the target cpu as !idle_cpu();
> > > > This is faster than grabbing the target rq's lock and then increase
> > > > target rq's nr_running or set target rq's curr to something else than
> > > > idle. So wakelist style wakeup can make target cpu appear as non idle
> > > > faster, but I can't connect this with reduced migration yet, I just feel
> > > > this might be the reason why task migration reduced.
> > > 
> > 
> [...]
> > > I've tried adding checks for rq->ttwu_pending in those code paths on top of
> > > my patch and I'm still observing the reduction in number of migrations, so
> > > it's unclear to me how doing more queued wakeups can reduce migrations the
> > > way it does.
> > 
> > An interesting puzzle.
> 
> One metric that can help understand the impact of my patch: comparing
> hackbench from a baseline where only your load_avg patch is applied
> to a kernel with my l2c patch applied, I notice that the goidle
> schedstat is cut in half. For a given CPU (they are pretty much alike),
> it goes from 650456 to 353487.
> 
> So could it be that by doing queued wakeups, we end up batching
> execution of the woken up tasks for a given CPU, rather than going
> back and forth between idle and non-idle ? One important thing that
> this changes is to reduce the number of newidle balance triggered.

I noticed the majority(>99%) migrations are from wakeup path on this
Intel SPR when running hackbench: ttwu() -> set_task_cpu() ->
migrate_task_rq_fair(), so while I think it's a good finding that
newidle balance dropped, it's probably not the reason why migration
number dropped...

Thanks,
Aaron
