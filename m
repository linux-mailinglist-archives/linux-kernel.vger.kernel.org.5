Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8A277B8A5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjHNMbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjHNMau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:30:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A7BE52
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692016247; x=1723552247;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qjONu5uyknzYgtRLT7gGqqNiTNIVvVfek5+T5KH13G0=;
  b=QLE4J4qB7ViCeYAvZraxzhotePk/sVN92F0xzRy04Z4eRIcVw4E13MLd
   zi1aaZPU7e6jEpA5FF+qKq6gtCJRv8Uo28TIqgiiA9yQ93ttEi+bC/GB6
   CaxwuyU7JRWuaSBCsIjWZW6PQeshIttSXAIW8M+PD1+pRgMKHnH2yaPsh
   KT+AJnPRtub3rngNuFQA12vEtTqeX2D0EIg5VALCV9qdI+QnEmRffOOIT
   CcfA7O8joqlg7lKCUtsgfvKANcbHm5SjRlqjhshUYE1yvYzazGf4ASvp4
   5JRxwKQRed0Xga4u6/S2fJbxRAo/xTORTRRr1JjQWNCG0PIoUntN/aZv/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="352353882"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="352353882"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 05:30:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="823435427"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="823435427"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Aug 2023 05:30:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 05:30:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 05:30:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 05:30:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjCEaTMS19SWHIe9WQ4X0dyUfQU+0FRdgWj7JehPitjkkt+1mOAHEJc2/tDI8mR2E//eW6BWdiiL7OMaPqYuUPMcPJML+ROsn85TduO+QjzCTRPQWVrwXn2csxpIofVUon35Dd0GBDdJtQowe0g4WIlKzpf1gTvK+DI0GRO3ABeLr8zTk+TFGe75tAd4/9G1pmaRJfEQ7P1BTNXRwC/XI20egj1IoBN85zVXG5wTmoLGPUYyiMtFlUNQ4DM0vxpit9kUUhH8E0O8oQN83LCs9sMIiNt1Ny19WMY8kNDHEUqHy9G2l+zK5/OLmvfJevoM8wbgF7ZlzWXigUyT7bMJow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieDUi26L7s2OZb/iSbSstV7G6SYOqBnXvnmSBu3F+8g=;
 b=BoQD5r2iEZmMCEWbhGb7N5840E8hAWqa/ejPU/8he5xrxjKUgWNFa+VFf0h43yf6FcdJZnY0NPGX6VyTXrQXBaUzF+krGKxlLSVUWv9vxcsTXptG8nzwIgDEQjyEsqSxuLQYp4VlTvfpBOy46q71pAFBY8VCUXBgVMNbMj/kR0NrVJBMMlN0pC/3fLZBfnj9L5S4eGZlwZroqAjQoSvFqcvb3WMr9d5XUZavwC2ZkIYc1f3lSm2jF+6zGfvEP2rMgZ9MH02K8EcRGAj5pIGRfofXpBS6hJRPYT3VGYXvWcbLBx8oBGDK77ywbQhrRXpvQKdPfHrPq6zx2KUzICGQ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DM8PR11MB5605.namprd11.prod.outlook.com (2603:10b6:8:26::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 12:30:42 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 12:30:42 +0000
Date:   Mon, 14 Aug 2023 20:30:20 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Chris Mason <clm@meta.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        David Vernet <void@manifault.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        <gautham.shenoy@amd.com>
Subject: Re: schbench v1.0
Message-ID: <ZNoeXISDHERwXx5l@chenyu5-mobl2>
References: <bc85a40c-1ea0-9b57-6ba3-b920c436a02c@meta.com>
 <20230420150537.GC4253@hirez.programming.kicks-ass.net>
 <1bd3bb9c-581e-2e18-aa41-ecf000e3686e@meta.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1bd3bb9c-581e-2e18-aa41-ecf000e3686e@meta.com>
X-ClientProxiedBy: KL1PR0401CA0010.apcprd04.prod.outlook.com
 (2603:1096:820:f::15) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DM8PR11MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a4729f-d2b0-44b8-8720-08db9cc245f1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /9M0FunrCy61UeGa7yvEOip6KZMazH6J0Mv5qR1+unMbT0O7xDjInHG0aZza8yFIQ/jhr1nA9+IRvjKweIl1eeMjsSIuYpZXszVVroBOc8zkDeO78Og4FIH5n2231SlduaGqQupsOQjYuJCNDeM3bliAfCHr7HjD9q3Ma7r3lRTGlGMNr0/5qhJuxUaeVc5c7KFC0kDBBDwXYUifzjwSX+ntspkH129gkpqSOl6/9EurAgfqXPjlL/HKhVik3PW7OoJhwg9kpRg1Qa3SEv7zTtMRbr4e4wQOKYma7/2GeemSByEx92guuta3qWzMFfvPPkvzQeeVs9otn64wdNKqvznKNpE0tiSiKsdxNbteITkLayNK5nk70qOtTIpb2LQDGQKbnt+1DCtRw7j02zvyF3wWl79Bg1YchkphOOmdz/uim+phnn8nQE3A6FcYHVmAARZDqLyIPHTSL03gejmuF/tja9Rnhok2FsbXkUIWXyuogdr8HBU27TVYCgGM0JGt83sRAfSI+b7vVId4sLRsBFaEtubEqqAIpWDPvcR2wCw0dYUzZr1T7Q3VnPTuDNXe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(1800799006)(186006)(38100700002)(54906003)(66899021)(6486002)(6666004)(478600001)(82960400001)(5660300002)(2906002)(86362001)(33716001)(6916009)(4326008)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(53546011)(6506007)(26005)(83380400001)(9686003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2TQGSruNinNRvPd8q/6MPucqEjgpVwvfNUTXRCielhVorptJgRw3JVajFMp/?=
 =?us-ascii?Q?nfcFerPJ53VRWA1h5r+k3uSOBF/3a40Ss6OeDoawNoFuRHXgD4sldCH4oGxi?=
 =?us-ascii?Q?vDUj+tB566PZpZSktRfC+dhrQEjtNfAlcuGBH97MF1qDIqq990ASFQHWg/3A?=
 =?us-ascii?Q?pSm/7PCGWKRtcNIXOSEHK9vFftCNWKxZvI0wBE2XwBFHpHQH1AZfkRahGUNG?=
 =?us-ascii?Q?NRiz1lojASrbDbGS9h00C0JQhTD1FQXqatNf+J771kAAej08lDMwm8jwsIeK?=
 =?us-ascii?Q?2r8p4pUiZX5BVzXD+F0UqJFVSM+pPpPhfdut4uRw+J/rUTUqtQMmuD/yyIq4?=
 =?us-ascii?Q?SgjLMlI6GSTBexHTO/qBt51h3jN4235M97xdVdplsAc3kQSWaFfjt8MJ8LWg?=
 =?us-ascii?Q?sn2FUFR4Kxa82Tlp2/5iEk+yxMFrUo+IWTM/uVOUIFfFmhLQLHztJXp0ISQa?=
 =?us-ascii?Q?uaglJ205kPI8l+U85IcFRNLkE4j8fEXBXFURv5pKltPvLeiKuMqIUJhLODaF?=
 =?us-ascii?Q?YkILnapnO5hkbH8gDh5pjY75I+ZQkZzNwNsydZfoCqH3joQEZpjzZhjjhT3W?=
 =?us-ascii?Q?uLTNc4kJwRTvTMYo52l4WEG0GEF6tvSKEXQgxCjHIMhJfDZv8z9tByxvfyXO?=
 =?us-ascii?Q?8ZmJp1iP2yGU+fPZGIgq5crXPXSYaHyTiIZEFB3sNmjuoYshrYrV08i9Su8m?=
 =?us-ascii?Q?Obn54Or4nKUTEI5QWAwP6Hw/hhFkcuB1BPAmLOtTGX3Z82higEvTZ1g1V+91?=
 =?us-ascii?Q?QMiDg5CzhZYNWiTS1tB0TnO3mLFCZKklhKa1XGfQp5d5hq4raX4dy5SSbblw?=
 =?us-ascii?Q?DEXonrg/ns6zF3pZZmQEXK+J5yfjLMbMMwoGJRICX8sbzL88PgfpvEXM4bSm?=
 =?us-ascii?Q?s6R2bDUJTeVf90vFt7C/42Phgu2RPLX16Ta1z67SL9Wa3lKXFXj6DfPoMsp1?=
 =?us-ascii?Q?k73q+VOlPe3qd8PuxYMA9u9G5Lf+fyHfpTZYwpSHI1gTDaIvfmwQOIslD4QT?=
 =?us-ascii?Q?iDH5s9uSrD3a1+ziBMIB5pg43+5b26fq6UcqZ+f1YP5xwls/6WaQJYlsuy2a?=
 =?us-ascii?Q?b1T7gKs9MQSTdqisonQWlCP7KUSMwvVz22hayJ35GLN6Z2gT1NjkqIbWpOts?=
 =?us-ascii?Q?a5PdhNoNryUK+PFCUtC8Ivw5g4JBKrtTe0LpeMrWFnvWA2iYtQMln0whgim8?=
 =?us-ascii?Q?1rpPE1RkIEqjcL8hFiRVzUabwgHEnByPm1yX2fQipETvedlUKRgOe1R2jPMc?=
 =?us-ascii?Q?UXJLHD9Lz8JcOFzZXIViauTIKXoDF5zKjb1O2cSJVRSPRYDTmPo1Dg6tUes9?=
 =?us-ascii?Q?Jcx6chlsSYnPryb1hCEskyYJibJOQULZB8zbVlXnko5yZUtwyz75p3SBeyDN?=
 =?us-ascii?Q?gVeCdFLSeWnOAZVd+e5GvziEkDoRquOLkujiF2KJikIbtGh4W1QNytxCL7ZO?=
 =?us-ascii?Q?vJ+lpZD6ntP6C/9dkykwY3rUDnGlrPEs0JO7hsHhyOS6jVIt8WOGrvfgOSuL?=
 =?us-ascii?Q?AxzlW0s/WsVTnMs+7PYceMOO3l2nlQ9cwrdItycsWzNqoC31obeBRWXa50IO?=
 =?us-ascii?Q?OjyfqtxfvltXw0Y7SZzOVmS3vyorJll6wyJ2Srkn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a4729f-d2b0-44b8-8720-08db9cc245f1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 12:30:41.9564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BaugYzxyPLMAUAsDXN0DAGFQMyH0QbJQMXPP4c82AtJ2dK3Yf/5qDN1cD0SEQfYkxPAg/4PGloqgKlU3QOV5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5605
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

Hi Chris,

On 2023-04-21 at 14:14:10 -0400, Chris Mason wrote:
> On 4/20/23 11:05 AM, Peter Zijlstra wrote:
> > On Mon, Apr 17, 2023 at 10:10:25AM +0200, Chris Mason wrote:
> > 
> >> F128 N10                EEVDF    Linus
> >> Wakeup  (usec): 99.0th: 755      1,266
> >> Request (usec): 99.0th: 25,632   22,304
> >> RPS    (count): 50.0th: 4,280    4,376
> >>
> >> F128 N10 no-locking     EEVDF    Linus
> >> Wakeup  (usec): 99.0th: 823      1,118
> >> Request (usec): 99.0th: 17,184   14,192
> >> RPS    (count): 50.0th: 4,440    4,456
> > 
> > With the below fixlet (against queue/sched/eevdf) on my measly IVB-EP
> > (2*10*2):
> > 
> > ./schbench -F128 -n10 -C
> > 
> > Request Latencies percentiles (usec) runtime 30 (s) (153800 total samples)
> > 	  90.0th: 6376       (35699 samples)
> > 	* 99.0th: 6440       (9055 samples)
> > 	  99.9th: 7048       (1345 samples)
> > 
> > CFS
> > 
> > schbench -m2 -F128 -n10	-r90	OTHER	BATCH
> > Wakeup  (usec): 99.0th:		6600	6328
> > Request (usec): 99.0th:		35904	14640
> > RPS    (count): 50.0th:		5368	6104
> > 
> 
> Peter and I went back and forth a bit and now schbench git has a few fixes:
> 
> - README.md updated
> 
> - warmup time defaults to zero (disabling warmup).  This was causing the
> stats inconsistency Peter noticed below.
> 
> - RPS calculated more often.  Every second instead of every reporting
> interval.
> 
> - thread count scaled to CPU count when -m is used.  The thread count is
> per messenge thread, so when you use -m2 like Peter did in these runs,
> he was ending up with 2xNUM_CPUs workers.  That's why his wakeup
> latencies are so high, he had double the work that I did.
> 
> I'll experiment with some of the suggestions he made too.
> 

Sorry for popping up, while we are doing some eevdf tests and encountered
an issue using the latest schbench, we found this thread. It seems that
there is a minor corner case to be dealt with. Could you help take a look
if the following change make sense?

thanks,
Chenyu

From e84f7634ab611a560a866c887438a4ebd79935ed Mon Sep 17 00:00:00 2001
From: Chen Yu <yu.c.chen@intel.com>
Date: Mon, 14 Aug 2023 05:00:06 -0700
Subject: [PATCH] schbench: fix per-cpu spin lock

On a system with 1 socket offline, the CPU ids might not
be continuous. The per_cpu_locks is allocated based on the
number of online CPUs but not accessed continuously:

CPU(s):                          224
On-line CPU(s) list:             0-55,112-167
Off-line CPU(s) list:            56-111,168-223

The per_cpu_locks is allocated for 112 elements, but be
accessed beyond an index of 112. This could bring unexpected
deadlock during the test.

Fix this by allocating the per_cpu_locks by the number of
possible CPUs, although there could be some waste of space.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 schbench.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/schbench.c b/schbench.c
index 937f1f2..3eaf1a4 100644
--- a/schbench.c
+++ b/schbench.c
@@ -1359,7 +1359,7 @@ int main(int ac, char **av)
 
 	matrix_size = sqrt(cache_footprint_kb * 1024 / 3 / sizeof(unsigned long));
 
-	num_cpu_locks = get_nprocs();
+	num_cpu_locks = get_nprocs_conf();
 	per_cpu_locks = calloc(num_cpu_locks, sizeof(struct per_cpu_lock));
 	if (!per_cpu_locks) {
 		perror("unable to allocate memory for per cpu locks\n");
-- 
2.25.1

> -chris
> 
