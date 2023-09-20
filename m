Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E008F7A8049
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbjITMf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235900AbjITMfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:35:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDD4AD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695213314; x=1726749314;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xtnS927xuqScwEBJg+82JKRURhwx9wRVLiQxu5ch2xQ=;
  b=exFpIRxR+hAxQ5t4/NxajUfRF4x3ISdh4uFXgMfO+QQiWRf3ItlMFYBP
   Us8rmV59fEWRc1+iAolQ+JsUoLhcz1WkEn8Tw3lUv2bcc/oUnxzmJ5rlp
   nwjhv4r9nxAwAPK17suAp2ImPfiOwUUfYRWicVoFExWRNhvpgkYp7hPrl
   6vVMuCuIKc0cR1szOhnLr2garY3M80lqQbvYmXorLy8qixmp1HwFWdRJt
   HZJ6wX2pVZs0SVyZQOy0SWECpXpaGOlvhZVxOnbne21m2OqkXWGtRKRxq
   tf2ebpsO8CZbSZ9HOH7dmUa7YvY9ATdPk477aDwgoed7isrPVnMrDqc84
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="446679184"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="446679184"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 05:35:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="696284747"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="696284747"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2023 05:35:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 05:35:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 05:35:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 05:35:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 05:35:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTWieBpoAevGCd/F/Or6xegkak9jAGOSKb8eEIclqgR3Scdn+bF474Li92UgkyikBlyDKv639x/nHlrtyZaloBoSTJHbu0qKJPTczWLWzEVVTOfMEzLME53bZsbEcpBB5DoT+C9uAzFyx2E2qKDKXz/jYjZlXeGjndg1YW45068fBbewvIkaQvE/l0ja46Fz2Sswq8mtThKcUYJnlMXIm4tPccEXUeLaTwD3bC8k0KQO5jZtPrJBVLlcL48qwr9KyrDt5Pr2zcTaN/Ez32Xoy0GvHdIMHSgDeikN9v2rSgtLwnSRqZDD7LCEMyQR3dOJyWslKTqKBlJ3wC3qbHFIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxzxYngdQBvyRU2IpZwAU/maiU6Nq2T8Qot7NOReva8=;
 b=LSnCSNsrhOGzye4EbpY0HiRfxcKSRPLiQMTEaKMC7FMlq0N6/eykVSR+AX7Fed0HYa9zLz5dG1zlwgqPsiSft1ku2RqYarv48l09BDKTEYVsdpjDi1VD9j5a8JAL92a3FBUYFyF2dc28qJJ6cJsp2PjcuIxi5ol6iez8w5wqBWpanxZSdC3qS2nRy+CsgFtehkm1qTM8gd09jR3LVtP9j/Rs7eFRGzGUt7SdYqiLRXkG5/Rzq7mZTXUH6k2+lnMdJlFmhiXX/gpQLf14griY5KrSfzvN93CqJCUwg1vsVfS20cH1CXRoBdwpyHG6IRdQxthkUWOeI4hSVWTEkeW9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ1PR11MB6276.namprd11.prod.outlook.com (2603:10b6:a03:455::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Wed, 20 Sep
 2023 12:35:08 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 12:35:07 +0000
Date:   Wed, 20 Sep 2023 20:34:49 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Valentin Schneider" <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] sched/fair: skip the cache hot CPU in
 select_idle_cpu()
Message-ID: <ZQrm6e9apSMwDh5E@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
 <30a7ff14-3f48-e8cf-333f-cbb7499656e3@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <30a7ff14-3f48-e8cf-333f-cbb7499656e3@efficios.com>
X-ClientProxiedBy: SG2PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:54::21) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ1PR11MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: 075fc09a-45b1-4b3a-bf2b-08dbb9d6056e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/9QAZmEFvpwphz/pjttrQKfqRY4s+FQVSe+jJ7uL30DGatg3x+iEtVf3ipHd1sDWPaeoPKQ101HfpHZQ5cFQPwwZ/eAQ4BPkdOCdKjwjiqcALX4vElnS2KDc5ac5d1vlsg/rpo9PAUCdCOcrjlqiaIIEzChZbJCkMgpJrkMfT7U78hG88UzVQgLSBYTmqu6e6wIpbUgqxefDZ3y/c9L6WERzRiQ8KXA6Z8C9KFHF4x7DmLtjHzzF604SC7dJJdc+ybjMOoiqfeLGd2Vz8SO/AB1ZqPxtlUHlwo0h9Y9KgmgUfwbwPa5NqNYoWS3Bmea0yijzUFX817NHRlEJcMVWw5xBsIEFeRun50BybTluaipHTT0UEciSmTcdX+PAqsAl+Y/P5VUKTSv4xaIvpSy9VfL5zFZEgAy11l8n7pCzloWihy9cZlGflbknAFsxGZuyzU4Y0qrVuH5FJOz5x1RknLJxHbQSCF2FZLGqkFVoEJuvbALm9QCRcVSSBfeOTQgbWjd3CJtjzqZlHfWggvo/EcUw0D9svMsn6frymLPwbw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199024)(1800799009)(186009)(86362001)(6512007)(53546011)(6486002)(6666004)(6506007)(66946007)(966005)(478600001)(83380400001)(26005)(2906002)(8936002)(66556008)(66476007)(54906003)(6916009)(8676002)(4326008)(41300700001)(316002)(7416002)(5660300002)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?meHuRvI8hRGHl78jLH82F1wAVL9DV8nxs06Yb830/Hnj2ZQ9e+wHDQGHrLb+?=
 =?us-ascii?Q?gbIbs96A4z6veRG4jXVHZTRmcfsweO/0YtoTak7AdjEnIU3C0fRgiuIYv8Vl?=
 =?us-ascii?Q?8qig2wz5gL4gGEQPfUOm9gFyOYO1ytrTmDP5nbc6yGZE+7G9hkeFGO4ZfjA6?=
 =?us-ascii?Q?ijPBrnK6VnF3MqUAF7/yzsQW/sIEkm9G91jZWHZqeH93lAI84SQrFdpvvoOE?=
 =?us-ascii?Q?4tKdaM3jwuiSMxMYqqsb4R8giXOyBgEna/xNGmEhKHjGq/bDZIWUZWx//1q5?=
 =?us-ascii?Q?bi7PdYNp8IV297go5FIXDuix1iynoxoLhCTk25cKtTOXOQKNnlIt/iwK15Cp?=
 =?us-ascii?Q?vB8a5eaxDYrxTaFid86LxmB2cgYwaI1ruPNgzqklKaCgSNmEmJnyP2zt1c8H?=
 =?us-ascii?Q?ystzOvagLI2BhAkzmIgGFAyRfxuc905piifzs5AOA3wkCCmSe7hWmH2eQTcY?=
 =?us-ascii?Q?i8IYh/+3vibsC17kkmRYK+C42rWEOAH/treaSumzJuQtFbeIoisaEVIrgeZ5?=
 =?us-ascii?Q?zVOsvCCJ9tg18udeQnpTwaD3IZizWleT85zJ+9ZEDwcHHvekVWHHTR15PV6F?=
 =?us-ascii?Q?VbRb6DQn/Z6eEs20gPRAlUn/DlFfymmNVtAmyZ+ghhMPfx8VczC9SSsMaOlw?=
 =?us-ascii?Q?opaiEZy4GvEGE9Gpq4xYo6hMShASvx7kAelN4Q/WcQYV6Ru4Zb9z2kD8aouz?=
 =?us-ascii?Q?Et8JRST+LKT5nxFBOLeJ7uqRcYbtS3vwtynlIX9KGYnQW2wM72W3cjYBkddy?=
 =?us-ascii?Q?ZO92MpzpzCsB0zUZSc/NxbnzjuqoZVcO9oNnB7PBjQxicH4thl2p8Ul30dD9?=
 =?us-ascii?Q?ZEX/VecdyVnxyH6+x5vtyXVle9iDzH4l+EGgBU2Gj3IYAtyC6CT0tYpNSK9H?=
 =?us-ascii?Q?LYrLjpc43S/kjBjf+pt9XX0zMvMVf2bYwl77BV4+P9CUyfPK0l8WwPyJow9T?=
 =?us-ascii?Q?qxPGSkKM6+rJyZncHOEFc8gbJyriqdTrm6CDWngdwX5aQRd8mztUy42hIbTm?=
 =?us-ascii?Q?eX4jNErFSi5Nwg7ebfcM69DUwFvp6XJsullgIyQTK9skTiifiYLVU4yfu8e2?=
 =?us-ascii?Q?Fe4vxg9EzK8RJuUeQbdZkA8DSTG1vSvStXgwgmRJ/VW5cMz6H5W0DHnXrnf+?=
 =?us-ascii?Q?FWsgCk/OS4EUDKl96x07zn4twu1AFggauvW4hN8YwnpC3zwu1u8+Gcii83fM?=
 =?us-ascii?Q?3ndYLBXWdD5NAaddF0POrqOg110mXpdam8HPOMlVEIuuz1K77YnVR1rGLCK4?=
 =?us-ascii?Q?7KePS7CVfqrreUC9v/qPYVZ1ViKqg25w1jtzL96gxnnZw3XTObMNiynAqKIg?=
 =?us-ascii?Q?/t+MpKSH8cD49YqkmawMbhipYTkGFL64VzLBGFnZ1IEaluSfKFTLbT0J8MKs?=
 =?us-ascii?Q?jo3rVP9e8qa9tubZITa2DOqe2KuXOc3qfCDp7TzbXvYo3SrpH4/OFnXEuCYD?=
 =?us-ascii?Q?bOYgoh/gLgL2/jDJiuPDWCoKgBzX2RpSx99GflVCmYkKjq6rnNazwIYhxts+?=
 =?us-ascii?Q?4mef8f49pLitJvSl3pJ2QPMfwSlLwN3Lu8blhHX8rFPAt50xSsBF9RzCvUzz?=
 =?us-ascii?Q?kKi4tMNrgdNaXvrla1o57S737jpq7bJdN+1d12ZR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 075fc09a-45b1-4b3a-bf2b-08dbb9d6056e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 12:35:07.2306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsDvq6Y1TLFAlhZr+0+QsqgMldYzoFsT8cyDNZEmhgDP/sPY/bugliXMhErEcmSjdAtDZt9KCiEkmOYwhBw6qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6276
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

Hi Mathieu,

On 2023-09-11 at 11:26:50 -0400, Mathieu Desnoyers wrote:
> On 9/10/23 22:50, Chen Yu wrote:
> > When task p is woken up, the scheduler leverages select_idle_sibling()
> > to find an idle CPU for it. p's previous CPU is usually a preference
> > because it can improve cache locality. However in many cases the
> > previous CPU has already been taken by other wakees, thus p has to
> > find another idle CPU.
> > 
> > Inspired by Mathieu's idea[1], consider the sleep time of the task.
> > If that task is a short sleeping one, keep p's previous CPU idle
> > for a short while. Later when p is woken up, it can choose its
> > previous CPU in select_idle_sibling(). When p's previous CPU is reserved,
> > other wakee is not allowed to choose this CPU in select_idle_idle().
> > The reservation period is set to the task's average sleep time. That
> > is to say, if p is a short sleeping task, there is no need to migrate
> > p to another idle CPU.
> > 
> > This does not break the work conservation of the scheduler,
> > because wakee will still try its best to find an idle CPU.
> > The difference is that, different idle CPUs might have different
> > priorities. On the other hand, in theory this extra check could
> > increase the failure ratio of select_idle_cpu(), but per the
> > initial test result, no regression is detected.
> > 
> > Baseline: tip/sched/core, on top of:
> > Commit 3f4feb58037a ("sched: Misc cleanups")
> > 
> > Benchmark results on Intel Sapphire Rapids, 112 CPUs/socket, 2 sockets.
> > cpufreq governor is performance, turbo boost is disabled, C-states deeper
> > than C1 are disabled, Numa balancing is disabled.
> > 
> > netperf
> > =======
> > case                    load            baseline(std%)  compare%( std%)
> > UDP_RR                  56-threads       1.00 (  1.34)   +1.05 (  1.04)
> > UDP_RR                  112-threads      1.00 (  7.94)   -0.68 ( 14.42)
> > UDP_RR                  168-threads      1.00 ( 33.17)  +49.63 (  5.96)
> > UDP_RR                  224-threads      1.00 ( 13.52)  +122.53 ( 18.50)
> > 
> > Noticeable improvements of netperf is observed in 168 and 224 threads
> > cases.
> > 
> > hackbench
> > =========
> > case                    load            baseline(std%)  compare%( std%)
> > process-pipe            1-groups         1.00 (  5.61)   -4.69 (  1.48)
> > process-pipe            2-groups         1.00 (  8.74)   -0.24 (  3.10)
> > process-pipe            4-groups         1.00 (  3.52)   +1.61 (  4.41)
> > process-sockets         1-groups         1.00 (  4.73)   +2.32 (  0.95)
> > process-sockets         2-groups         1.00 (  1.27)   -3.29 (  0.97)
> > process-sockets         4-groups         1.00 (  0.09)   +0.24 (  0.09)
> > threads-pipe            1-groups         1.00 ( 10.44)   -5.88 (  1.49)
> > threads-pipe            2-groups         1.00 ( 19.15)   +5.31 ( 12.90)
> > threads-pipe            4-groups         1.00 (  1.74)   -5.01 (  6.44)
> > threads-sockets         1-groups         1.00 (  1.58)   -1.79 (  0.43)
> > threads-sockets         2-groups         1.00 (  1.19)   -8.43 (  6.91)
> > threads-sockets         4-groups         1.00 (  0.10)   -0.09 (  0.07)
> > 
> > schbench(old)
> > ========
> > case                    load            baseline(std%)  compare%( std%)
> > normal                  1-mthreads       1.00 (  0.63)   +1.28 (  0.37)
> > normal                  2-mthreads       1.00 (  8.33)   +1.58 (  2.83)
> > normal                  4-mthreads       1.00 (  2.48)   -2.98 (  3.28)
> > normal                  8-mthreads       1.00 (  3.97)   +5.01 (  1.28)
> > 
> > No much difference is observed in hackbench/schbench, due to the
> > run-to-run variance.
> > 
> > Link: https://lore.kernel.org/lkml/20230905171105.1005672-2-mathieu.desnoyers@efficios.com/ #1
> > Suggested-by: Tim Chen <tim.c.chen@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >   kernel/sched/fair.c     | 30 +++++++++++++++++++++++++++---
> >   kernel/sched/features.h |  1 +
> >   kernel/sched/sched.h    |  1 +
> >   3 files changed, 29 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e20f50726ab8..fe3b760c9654 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6629,6 +6629,21 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >   	hrtick_update(rq);
> >   	now = sched_clock_cpu(cpu_of(rq));
> >   	p->se.prev_sleep_time = task_sleep ? now : 0;
> > +#ifdef CONFIG_SMP
> > +	/*
> > +	 * If this rq will become idle, and dequeued task is
> > +	 * a short sleeping one, check if we can reserve
> > +	 * this idle CPU for that task for a short while.
> > +	 * During this reservation period, other wakees will
> > +	 * skip this 'idle' CPU in select_idle_cpu(), and this
> > +	 * short sleeping task can pick its previous CPU in
> > +	 * select_idle_sibling(), which brings better cache
> > +	 * locality.
> > +	 */
> > +	if (sched_feat(SIS_CACHE) && task_sleep && !rq->nr_running &&
> > +	    p->se.sleep_avg && p->se.sleep_avg < sysctl_sched_migration_cost)
> > +		rq->cache_hot_timeout = now + p->se.sleep_avg;
> 
> This is really cool!
> 
> There is one scenario that worries me with this approach: workloads
> that sleep for a long time and then have short blocked periods.
> Those bursts will likely bring the average to values too high
> to stay below sysctl_sched_migration_cost.
> 
> I wonder if changing the code above for the following would help ?
> 
> if (sched_feat(SIS_CACHE) && task_sleep && !rq->nr_running && p->se.sleep_avg)
> 	rq->cache_hot_timeout = now + min(sysctl_sched_migration_cost, p->se.sleep_avg);
> 
> For tasks that have a large sleep_avg, it would activate this rq
> "appear as not idle for rq selection" scheme for a window of
> sysctl_sched_migration_cost. If the sleep ends up being a long one,
> preventing other tasks from being migrated to this rq for a tiny
> window should not matter performance-wise. I would expect that it
> could help workloads that come in bursts.
>

After a revist, I thought maybe above approach is better. Because
this method considers all the historic data rather than only the short
sleeping duration:

if ((flags & ENQUEUE_WAKEUP) && last_sleep && cpu_online(task_cpu(p)) &&
     now > last_sleep && now - last_sleep < sysctl_sched_migration_cost)
	update_avg(&p->se.burst_sleep_avg, now - last_sleep);

Say, if a task sleeps for 1 ms, and in all the subsequent context switch
it will sleep much longer than 1 ms, then the burst_avg_sleep will remain
1 ms which does not reflect the behavior of this task.

update_avg() is actually (Exponentially Weighted Moving-Average) of

new_avg = 0.875 * old_avg + 0.125 * lastest_sleep_duration

which approximately reflects the latest 1/0.125 = 8 sample data. I guess
the 8 is small enought to capture the burst sleep duration.

Unless we want to capture the scenario that, during the latest 8 sleep
events, there are 1 small sleeps, and 7 large sleep behavior and
we still want to honor that 1 small sleep and reserve the idle CPU.
Then either we can use the method you proposed to use the min logic, or
use the logic you proposed in another reply, but enhance it by clearing
that burst avergae sleep duration if there is a continious 8 long sleep
event, which looks a little overkilled. Anyway, I can get some data based
on this.

thanks,
Chenyu


