Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6DD79D410
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjILOwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbjILOwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:52:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E18B1BB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694530339; x=1726066339;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a4XZ78Nf7oI7fUma1q7pXQMFp1AElgt6LiTPu2kTTaU=;
  b=QZJfNqMyWwgwItaAIlM+gi7gu2WpGY5ZATXdyx8SNfAG28JO4itzemfe
   AXqEuEYan8sV6dxRYdpRoIoR+IAaYWCE2bkq1s4LVEMCEkYzvI7+sYUVd
   v4wpwIb9hiJcsJZKeOoHeVKDngd3QjAPX9c1u9SqvNk76C78ypCwXABIW
   D5reM1CZnnJhPeEhwdidJxbr2KFDtPKSo6XEpoHcLj3BSTLsN6MBS7Gmu
   eFZrLUVe27IY8w8KQemahxfn+EeWz/ewpLIPrs7kSs12oMpRQQsjtBVpV
   Hp5Jdbfc5ermBVhgiqT+YWnx5hqx2b+3G+wjsTXnORRlhQinePRSkYfdv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="442410401"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="442410401"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 07:52:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="886964729"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="886964729"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 07:51:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 07:52:17 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 07:52:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 07:52:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 07:52:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9fjo6XkIl2bEK48tSP4kOw7S7HR3jPgIjoOfFKZ9saYH08BtxQuK5XcY+T5JXSwqMeqSdVZyVeUAKuo/U5SB/Zsl8k/DiSLsID2w/9Y9BVOqLSLDFtaBjupOzfghZaXjpzeVF877bwNqHPnEBkH9BGZGYzuyskz5zU1HdIS9Y4YvdYSEY70iQvCZYqSvj3wqjPR+eelnQFSAEJMfNB6lKemqWltKbhbgbSlXTLlOOxoQ2V/a/ixTvwa7UQ/wBZsr2qdcp6KJGTnZz+5W9IUbLVU9hBtwebsnfwVBNxTgsUQjPxMHSFxlY6je24UpkqpvJaOVZjxLVlnfwxItwkqdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZW2n/Qy5wqDQdU99QJmKZslJpaYRQnsIaCrwwOgK9A=;
 b=nFqM3Jh9XtFAnEPhl6bY83YRggFgYZh0yO4sHJemog/f0Pgx/5jhyIleX9IIw2BPF7vQZfFvX5niA+CqBtm3A6Y7ct+z6KGxput7kV2/0ecVNdhJmPUksbz+3fuC9s6sRpL2zQtk37abj9UjwoeehJZYw7Zh7BiicNLS9Wsjrk2q1xRqob11I++PNBsEjaNnUU/4aVLZtIuB6Wa93UDZCLKNDp0+/n5kIikdAubrzXbRHHnSwr7B/Mw+O4dHzNoOM1ocYExFJCR/v0JwSrWdNA0IAbyWJKuF5dN0LLmuzeusLcG2OQ5VmgLBH58KFyTzjACzV6aeWrnZjoUyO6pPzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CH3PR11MB8361.namprd11.prod.outlook.com (2603:10b6:610:172::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Tue, 12 Sep
 2023 14:52:15 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 14:52:15 +0000
Date:   Tue, 12 Sep 2023 22:51:57 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Mike Galbraith <efault@gmx.de>
CC:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC PATCH 2/2] sched/fair: skip the cache hot CPU in
 select_idle_cpu()
Message-ID: <ZQB7DWSuUmzql8/D@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
 <31c910c2-717d-b86c-4e08-5c94383682e8@amd.com>
 <ZP7ptt70uF10wxlg@chenyu5-mobl2>
 <a8c1b296a4ed444b9cab166a5a39aa11836903a8.camel@gmx.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a8c1b296a4ed444b9cab166a5a39aa11836903a8.camel@gmx.de>
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CH3PR11MB8361:EE_
X-MS-Office365-Filtering-Correlation-Id: c1294e81-cc30-4a50-568a-08dbb39fda8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kg/mH5YYSMX59AEXqHkFpCzNhbGRLPBrgwxU5qEvu+GPJJCxx5B5hZxvKNkjaz2QAJnlWTlQ0/X+90D8HJp4AL8F75LBxfIAImIb2UVYlUyJN6qah8CSN3Tbj3iZoB4xKT0OtcchgxXMtVxcPcDrgZ8+nmW14cFOZZFTeCkJE+UOxNgNCHoaOKA7kfZ9LP2XlT8YwHJ8w3uUlAGyCzwaDFyepV7TiEzYvP2I4roVLNdM0ZjVMEqNSbNkl6zwV6Md7pyPE9kT2E+v0qTPW3LORp8jlQoZirY7iGoYGUu25oR3miXUl65ov4PWXAa3Tymbr1Nvvufwob1kHaOITp+9mqiNbq6p+g3W2AdPxoCWcvqGvhZarJ5NWzvFTCv7SXSM8Y2KxyLcq5LgskeZLUYspU1OahCNhQL5k3FJ8Gp1ccJioE3Ryqm6arO3okLB8ZE9g6zp10z2Q8iWvlmb/dnRpmHaLeCeCQ4RpyqLjvKPGNP3wsq84b9yjfX/Z5MPJVvIkxlCsmAvK5LkB2mJwOmUUh0MDzGl4zgLVFAMm1z2IfocP+1aNhkBOUDrJnGhxhbx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(396003)(346002)(186009)(1800799009)(451199024)(6486002)(6666004)(66476007)(66556008)(6916009)(66946007)(54906003)(83380400001)(53546011)(6506007)(41300700001)(6512007)(316002)(478600001)(26005)(4326008)(8676002)(8936002)(5660300002)(38100700002)(82960400001)(2906002)(7416002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?onyEsKueWA8o3Xpd6+bBM8KBnmGYBwpFOyT3eSFEki4vHlpxRM1Pwy2GxCW7?=
 =?us-ascii?Q?LlzRTrjKjWLvSxxIZ4WwCiakv/txn3AWxxCd+4YfFUa9gYsyJMtvLRucn8rS?=
 =?us-ascii?Q?Rv+GKgsC2OinM7REjyS63SAtkGB9zMZFNIHXHefOpC/96+T6CEK5p5Vb4W5l?=
 =?us-ascii?Q?JP6ik7SkyY90RxGmZXgADtgd4EZBuWeDzjEKRJUfuAAGJyroRMLsfwHrkbzM?=
 =?us-ascii?Q?KL63UXgVnAy67NZgXPXoj6bhIgyDL/aoGn+Rt8VpPhWMXdvAEPq3dbFFp2CI?=
 =?us-ascii?Q?FNxSM/KK+6morQpS8gzzttf9OYZiaw61Sbn27ko/6cmGVDUBOwYbULu20DSg?=
 =?us-ascii?Q?PC5qDZWDODIpaEDb8I1EHMjTpoZdIbcgHW4nn0HyLk/FzY5iyAQH2wo2N9dx?=
 =?us-ascii?Q?uRzuZVomsGorq7VHl91eB/VcNDuGPSLDwIEDAMywlncE6eXGfoMF0kpMGSGs?=
 =?us-ascii?Q?eqcxTPLbgw3rha+3yBGwKcsAPjTGwYWg/uEDuWeUjt7XvYgO/XqVHYegB7fq?=
 =?us-ascii?Q?2Kt7tItbmzwte8Jy20Qpju0Gq1nUL5XY/IEK0X9wRUhq8phD1eqDyL67vr3u?=
 =?us-ascii?Q?a23ISAeB2ozFLJ0YAa9gUXZ7a7tr4STcsRA+vWgPJS/lTKqwqa6elNIGO6Aw?=
 =?us-ascii?Q?Pt9fBz1gfN0MwJW3Ts+lN38ImnQMzA7TQDmMqUV9oxyFPKXdNdRWtmYmrKsU?=
 =?us-ascii?Q?JZpMW8xFdl+SDH25n3kOmPkwJJIRPwpfdMm6ceR2eqTsEVExd8d3DzJ7tDI6?=
 =?us-ascii?Q?67tF/g71TFzOTaJzaxlE4pgmiyjAK05cBmYZJNt1eOEJnAXMpfqWqOVNMl+O?=
 =?us-ascii?Q?GmCIp/M7o/noNUWN30itlaBEtkxueLbhndnbSNEVWirqtni5F466JDH5CV5g?=
 =?us-ascii?Q?MhbeiFCBeuj4XbjeZAuLNXTzNZl+zn/JV/0148KHYH++vtoEVkejaVJSO7VI?=
 =?us-ascii?Q?n4VMgrDh11cwE/ikTOcbDEztlz8ZLlGrwWVG1V527bblEc/UvY5v6CvhHDYx?=
 =?us-ascii?Q?3hO052Ew7WJMx/mDluYidyWNlUrM8fCSYmP7UgCaMhJyT2az4gj38OyCPJoI?=
 =?us-ascii?Q?0FTXnaWuNAVGSjFzYZHep+CD6glKpGI8cAgmHa1i36fAL0sqRr66hNHLpzXo?=
 =?us-ascii?Q?gFm7T5yJFdx1Gq2Tw6eit/BFlXuOY2UN/8iyzYFJTbQR3srqdKmxq0H0FD0E?=
 =?us-ascii?Q?0rK7291TIZGoaK26Lw1tfk83f7XWpJzdg4vLy9LneSlgFPftMHZeeHCbyOQO?=
 =?us-ascii?Q?poPLTVti5HgEBEH3HbRKajHp0n/NeTV7mQCf4rDXxYtRGHImkbL+mnx1BmRh?=
 =?us-ascii?Q?+KDbwgpnsYexbaNt60hx9twlSbpAETNauKPqkhmabov6PS6NrNveTMxdh4G5?=
 =?us-ascii?Q?Fsmdtd7gQHz16/7wej6tcOfzJsmn9ImpfOO4bavLpKqYdzS2PA34m1vDo0NA?=
 =?us-ascii?Q?8BJpXpPzaw+dLY+favn8MhxvxvJbs0dJGPpPyYBHYkvqHgfTHmQbLVCf5BSM?=
 =?us-ascii?Q?EMgglS951Mjluz8LeHCqTaQWVw5QMFKDF6iEK6GRwmDw5favRNgMerMd5Tn4?=
 =?us-ascii?Q?7q8zptmGLiUCHY8K+qxLrelAVmd7yHnlXnK1Ej/K?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1294e81-cc30-4a50-568a-08dbb39fda8c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 14:52:15.3009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymZ8loOrUbq2GvWhLljQ9jhHwRdmEdNnikoXLXIXWQKbfIortLJd+QeYbTvpflFohq9FskhU8rfj3JfW0DP4LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8361
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

thanks for taking a look,

On 2023-09-12 at 11:39:55 +0200, Mike Galbraith wrote:
> On Mon, 2023-09-11 at 18:19 +0800, Chen Yu wrote:
> >
> > > Speaking of cache-hot idle CPU, is netperf actually more happy with
> > > piling on current CPU?
> >
> > Yes. Per my previous test, netperf of TCP_RR/UDP_RR really likes to
> > put the waker and wakee together.
> 
> Hm, seems there's at least one shared L2 case where that's untrue by
> more than a tiny margin, which surprised me rather a lot.
> 

Yes, the task stacking is in theory against the work conservation of the
scheduler, and it depends on how much the resource(l1/l2 cache, dsb) locallity
is, and it is workload and hardware specific.

> For grins, I tested netperf on my dinky rpi4b, and while its RR numbers
> seem kinda odd, they're also seemingly repeatable (ergo showing them).
> I measured a very modest cross-core win on a shared L2 Intel CPU some
> years ago (when Q6600 was shiny/new) but nothing close to these deltas.
> 

This is interesting, I have a Jacobsville which also has shared L2, I'll
run some tests to check what the difference between task stacking vs spreading task
on that platform. But I guess that is another topic because current patch
avoids stacking tasks.

thanks,
Chenyu

> Makes me wonder what (a tad beefier) Bulldog RR numbers look like.
> 
> root@rpi4:~# ONLY=TCP_RR netperf.sh
> TCP_RR-1        unbound    Avg:  29611  Sum:    29611
> TCP_RR-1        stacked    Avg:  22540  Sum:    22540
> TCP_RR-1        cross-core Avg:  30181  Sum:    30181
> 
> root@rpi4:~# netperf.sh
> TCP_SENDFILE-1  unbound    Avg:  15572  Sum:    15572
> TCP_SENDFILE-1  stacked    Avg:  11533  Sum:    11533
> TCP_SENDFILE-1  cross-core Avg:  15751  Sum:    15751
> 
> TCP_STREAM-1    unbound    Avg:   6331  Sum:     6331
> TCP_STREAM-1    stacked    Avg:   6031  Sum:     6031
> TCP_STREAM-1    cross-core Avg:   6211  Sum:     6211
> 
> TCP_MAERTS-1    unbound    Avg:   6306  Sum:     6306
> TCP_MAERTS-1    stacked    Avg:   6094  Sum:     6094
> TCP_MAERTS-1    cross-core Avg:   9393  Sum:     9393
> 
> UDP_STREAM-1    unbound    Avg:  22277  Sum:    22277
> UDP_STREAM-1    stacked    Avg:  18844  Sum:    18844
> UDP_STREAM-1    cross-core Avg:  24749  Sum:    24749
> 
> TCP_RR-1        unbound    Avg:  29674  Sum:    29674
> TCP_RR-1        stacked    Avg:  22267  Sum:    22267
> TCP_RR-1        cross-core Avg:  30237  Sum:    30237
> 
> UDP_RR-1        unbound    Avg:  36189  Sum:    36189
> UDP_RR-1        stacked    Avg:  27129  Sum:    27129
> UDP_RR-1        cross-core Avg:  37033  Sum:    37033
