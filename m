Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF4C7E19C0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 06:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjKFFxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 00:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjKFFxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 00:53:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2B6FA
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 21:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699249989; x=1730785989;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5afkoVpCokWEibSy8ynTT5J9B0Qp95e6KcWGKkxkeNk=;
  b=ccbTOSXSqmHvEvh447XNVTHzqnLp2RjP5NFb2N3L4KbCNNSQBkKaDJ9d
   leZHy8rGymxTpZJU9hmaOYZbloOrOtlEo+AY+z5Nx7dWzFntCXqCM9Sn6
   MGc14CB0rq75TVMMh1WSbNtM4DFmE5UXgHFZPEIU/amXcm+dKaiG+6OwH
   hYFSUTm13Y/KqEhUendF0Y4cfvSpTSKxfkwyqgYZvlI9flDC6mE7kXCEo
   rLQf85djKb8OPZ2RMmTGoVgSZYH9JQaRaK1QDG+YQG6ru1ma6OujxLDj+
   v+d2c9gvaVXf0Id+HIByXBTcG1c5LpRxQm/q+aGe/rgM+mOykQKtt4HuR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="379604041"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="379604041"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 21:53:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="712104651"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="712104651"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Nov 2023 21:53:06 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 5 Nov 2023 21:53:06 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 5 Nov 2023 21:53:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 5 Nov 2023 21:53:05 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 5 Nov 2023 21:53:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcv5V+VRqgMn+FCrY3kQ5Pxgac4bKNTPnQrGw2FsVWRu/MpiKPn7QsEIu/ZjUHcsz5UWquZaYxtaFu8jEZFxqs/E2LUqX/0Ir34WMu+UfTjqGHJFbmolJUA+R9a06x38T2vytb2J5MsTDQGmboFep9Ek6GSYuNDWrXwAS5Hxz+MzN0/JZ4fDHQaTHyh9M8ra8La6rnrZopNXHOSipfqHWiLAvFUl/c+50Cfzqyv7CKFMZvzhKtdbZHx/f8rjclaCKHHgAQvfknCjTbWZeCLqtC6tm3FMehLEttmY3BGXFZISWkDp4QUwq/Zm9oznlf1xbcsJp3wrB2ofGpCgLj77oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IO33Cn4azVHpK5RhyAdQtzl46XwMMFKLxZ6C2CSqwE=;
 b=AphtEdZI3BTE6GVoZ4U5SWnxof2AVNDuFG2e6i8hY3wm0LhiEitDR+Gubah7bRiK69cOcvPfKHR4cK2SnQeBxk1jXcrAUBrXKUJb/2ZLg7CfNaGjZTuluBVtxAsGbS1RNriln4Xp1KNOm2WBwTdbytyg25vnZmKSl1S6D34M+MzERBBXC431uYcTnGYf9HVCZdF06wjqUz5OFVvHpLoz6Y5i4FgxwtMRF7OPjiR3qfP49NRCxyMVIjY8BqRDmfRr3NQCR1TYHUCfHsjBnYO9WvHrshmVcQajw9M9WwL7923WVpOLtQynyvpFdy+xWG0qg0WDJ6sgAcq41n5Gort8Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SN7PR11MB7044.namprd11.prod.outlook.com (2603:10b6:806:29b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 05:53:04 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::8c24:7666:7047:d99e]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::8c24:7666:7047:d99e%4]) with mapi id 15.20.6954.019; Mon, 6 Nov 2023
 05:53:04 +0000
Date:   Mon, 6 Nov 2023 13:52:44 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>,
        "Tim Chen" <tim.c.chen@intel.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, <x86@kernel.org>
Subject: Re: [RFC PATCH v2 0/2] sched/fair migration reduction features
Message-ID: <ZUh/LK4iy3ukVaCn@chenyu5-mobl2.ccr.corp.intel.com>
References: <20231019160523.1582101-1-mathieu.desnoyers@efficios.com>
 <85b710a9-5b26-b0df-8c21-c2768a21e182@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <85b710a9-5b26-b0df-8c21-c2768a21e182@amd.com>
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SN7PR11MB7044:EE_
X-MS-Office365-Filtering-Correlation-Id: 20508bee-64f3-4933-773c-08dbde8ca44b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gh0mrgD7j0Cqz+z87jjrzpnzNDBDAz0Tw7/S4TPQEmZqIuoiB7+FhyjuaLYrHLal7Jax0S+aE7amKoeddNxqT9zElu8NMOfGiPvKexbsm3hlmyiQPcrmp1RyV/bgRz8iu8ewz/poE5f4daqJd7AXaP8P4cB7k1BN1Zk6v2xmkdRP6oDDe0jf06Aay6+n2A3hRuUS/tZTs9abwG6RXd68T5ZvwCUKGmQU6R/4jIFPifOnfSEyDdNugiKGKmNHx1/0ovxqeaQkD/eWhJMw8L+1wDfL0uIQW05B+K9dHG4ltCnhzhkk+RNnTuA08YwqXYt1ZE3WQ3dAn5sWaKpy2Hq6ZYAqPxgKuPiw5fv6ZzAqy336jj+exatmlOTzeqpQ9ys7a4T2LcGgyCToR33JDRWlPTmkAO20dg1vq/pbRltNaABmcYDoaVnnHa1waB/9CRHP1cRM6KqOpEZETDEPTK4Xxv34k8Z/xIC2isgRl7m3WDfnsXkwwosVkj4dMR2umac14McBVmPeA46j7DcGDUJpx+pWv/vwCiE5mdpXRwLGIa/gV8plTxrTlTYOmpA5oWB+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(136003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6512007)(66899024)(82960400001)(26005)(6486002)(478600001)(66946007)(66476007)(66556008)(54906003)(316002)(110136005)(53546011)(6666004)(6506007)(5660300002)(8936002)(8676002)(4326008)(2906002)(4001150100001)(41300700001)(38100700002)(86362001)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fGnLARxo0Q6L5gEKloCWmQUla18wiRwmsqu6THmEb31qX5q0PYsOZYzlXbjp?=
 =?us-ascii?Q?WvBuqCV50RPw+VMIv10W62B7SxdlnC5m9wjMipE4TU0DrqCZEgZlIraBkHDO?=
 =?us-ascii?Q?UEMQFdjWuFk/mEE9NGXzH5O3HkgvzqcCCcvWS70xMiXCelLQ4BlaP/Tr2lJ7?=
 =?us-ascii?Q?4F+oyHIYwqxaA/3UVTvWFRexi9vOkYY3nNR8Jjix2a8Sr+3nyrSXxzSXf5xI?=
 =?us-ascii?Q?FZwT5GyL1OU5J9DX+kVhj+3PDwI7xD7Xprj5puZVkHBYYA2W+W9WLXqxCglF?=
 =?us-ascii?Q?Y43L7wWMpmMdIM4kSKjKwa/1IXdn3NYzZw6aNWzKqhTzhMFCuAQ3a1kYihC3?=
 =?us-ascii?Q?e13Pb39ZjQ460IRb/2iyRC3r8xFBGG98uL1gns0WUS8034n19HNiChL3Z9L0?=
 =?us-ascii?Q?ipi32U7oNyhiqRnaVrKNn8zuL9Kdchkctcitw3bzatRlB6h3TFayQXV8y3UV?=
 =?us-ascii?Q?hK+lvnTnFcwJNE81rm7oUNhidbHlfr3AKQCx1WMxRvgFB5nbLwvLjsAnSA5x?=
 =?us-ascii?Q?WvZ0Ile1+hML4yL0212nK1OAFlTrN6JZZ5jp+56mKJme+HvZCRDfvJiS9nrp?=
 =?us-ascii?Q?NNk9QlYOgS3lkcOfGHy2GYd9MDxJ7KeEHcF49pjGd4r7Lv5e2Th26iGHU8CT?=
 =?us-ascii?Q?G+T5VoCT2SL63yMP6MkI47zhF1LhOrRupZLDZVsY9X/nDTnK7H98gKrFpszL?=
 =?us-ascii?Q?huMkHE/+a3TSsdJgOdikl5ZV2izkA/vPhFXKjTveMacFTSCILLlEVKMNC07x?=
 =?us-ascii?Q?zS+aTaX2xaSGBRQOfCROOy0kA+tHv56iovrHsGwRibdZNUmrnFTKg6KW8Psf?=
 =?us-ascii?Q?/un3jaxh2AXtJIWwdoLDn2uEPRong+uw6UE8pMmuyZMjstNn+fIw/qa55Hf8?=
 =?us-ascii?Q?cDhzVfmr2147uoIf0m0kMixoa54MqmRjVvRm2BP8SPcWeIwdE/CRfsAIwOmM?=
 =?us-ascii?Q?rOwGMaXcT7l/OzG8q5dgV8MJuRzDYcL1y8rdlPh77KQdV2g8INcUeGdpOQUz?=
 =?us-ascii?Q?bouN+Rls8OEW2gu8ycpW6awOZgR9vmLaYQQj/s5SL1oyK2AKcQ57huh4bolF?=
 =?us-ascii?Q?EG6lvKBaAmQ9x90kX4xxz2gBLni0JhVBGkSGFYHv34SRDYdqjCPCgis3JaWu?=
 =?us-ascii?Q?GJB/1L/ZFUSgf/wTeV671hPoyQhEs15S+0P2XDTwBoGSbyyZsVmHXHkx00lP?=
 =?us-ascii?Q?3l8LTuHzzKI1656ylvuNIBzy3UqeUiDhuXfF1XR1cgYyBaiMwMyFMAGvVB6D?=
 =?us-ascii?Q?2ntoKvH2ifOUkQ9+sHFxp+KpCGeOyqJP+nE1jIDA2iSh+MoLwIHRHH2B80Fz?=
 =?us-ascii?Q?d4Hp+gi7ahAmYKB9pK/dnkBcwfniQqzGs8GMzw2OeZH0B3d8N7KPzg/OD6mv?=
 =?us-ascii?Q?c/7vLfwgf2Qylcs+dNAtRDPMj+71bJ5QJzG3Fyf9kxaI/Tq0jI5H6Qs/vlue?=
 =?us-ascii?Q?NQ7jh0M0kFoAN681PdKmWehGxA8xTlKza8BjFN2uoQgnuiP5vxlznSDJzE4V?=
 =?us-ascii?Q?d6OiYizvPZ5UHSi77bq7+0dchvRDelZ7Wai4z16xa8J56I8g70kJQbKtS+2/?=
 =?us-ascii?Q?Mswoz3HwpNvJQOLZvpaSG7SXyxLoiD9GiC9SN9Vd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20508bee-64f3-4933-773c-08dbde8ca44b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 05:53:03.9829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rh5VZmh4Grm4r2eXno6tnvwdBn74KgI7LiyNWvjH0TDJZzTraHSu4p/X1RAa+qDLnXs3ie5O5xzZwkxMYTEhfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7044
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-27 at 08:57:00 +0530, K Prateek Nayak wrote:
> Hello Mathieu,
> 
> On 10/19/2023 9:35 PM, Mathieu Desnoyers wrote:
> > Hi,
> > 
> > This series introduces two new scheduler features: UTIL_FITS_CAPACITY
> > and SELECT_BIAS_PREV. When used together, they achieve a 41% speedup of
> > a hackbench workload which leaves some idle CPU time on a 192-core AMD
> > EPYC.
> > 
> > The main metrics which are significantly improved are:
> > 
> > - cpu-migrations are reduced by 80%,
> > - CPU utilization is increased by 17%.
> > 
> > Feedback is welcome. I am especially interested to learn whether this
> > series has positive or detrimental effects on performance of other
> > workloads.
> 
> I got a chance to test this series on a dual socket 3rd Generation EPYC
> System (2 x 64C/128T). Following is a quick summary:
> 
> - stream and ycsb-mongodb don't see any changes.
> 
> - hackbench and DeathStarBench see a major improvement. Both are high
>   utilization workloads with CPUs being overloaded most of the time.
>   DeathStarBench is known to benefit from lower migration count. It was
>   discussed by Gautham at OSPM '23.
> 
> - tbench, netperf, and sch bench regresses. The former two when the
>   system is near fully loaded, and the latter for most cases.

Does it mean hackbench gets benefits when the system is overloaded, while
tbench/netperf do not get benefit when the system is underloaded?

>   All these benchmarks are client-server / messenger-worker oriented and is
>   known to perform better when client-server / messenger-worker are on
>   same CCX (LLC domain).

I thought hackbench should also be of client-server mode, because hackbench has
socket/pipe mode and exchanges datas between sender/receiver.

This reminds me of your proposal to provide user hint to the scheduler
to whether do task consolidation vs task spreading, and could this also
be applied to Mathieu's case? For task or task group with "consolidate"
flag set, tasks prefer to be woken up on target/previous CPU if the wakee
fits into that CPU. In this way we could bring benefit and not introduce
regress.

thanks,
Chenyu
