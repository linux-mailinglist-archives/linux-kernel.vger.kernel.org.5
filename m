Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587EE7CF5F4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjJSK5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbjJSK5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:57:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A97119
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697713059; x=1729249059;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wiML2zv/bTBRTEfyEKeYfUPAF8hkd583sG5Tb8/+sTM=;
  b=AB7OXSjB5IIciHBSCqv2Q86yqI8G2tdhWKFVm3oVdTYC+UGPvYrqmlnE
   GjIENwW91f/t5I7lsZoTAapVxpgaEaUqasQyQYk5n2qkqyoB+yunbOCjt
   GgdFrLeKCnYtPOAvcsLJq2wgPXkWRH3GultgrMA1zOWgbduGjBM2zjscv
   C/A2G7p4mfhWKv6Bp9w8ZVLyf+zAA3iGt399WqCh3J5jQUS7CYk+1idSW
   cSmIrrAxX+7goZL/cqMqOacuW+Ek1nC9OfTY7p/styfg2bNoMZZk3Q4EB
   P1F0O9uISwyl7jxn8FKrZSHmB/mD4XU4VICa67Bo8OxmT2ieXuEfAN8zB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="7777221"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="7777221"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 03:57:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="733525522"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="733525522"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 03:57:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 03:57:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 03:57:20 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 03:57:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHViqMxQIyxn7fTANvQNh9xXxwulYlGHMDSPYv3VCk98yBVaa9Z47GoeC6weEzwUQc1qrRaAaLXJl4885mru9IMrR/67tqXL0VwEFU/44zf1nGlLiOaqMvqG+O6kcTKFRhZHqGFC5/gQNJDuU85sM+7d3c1Ay58jRm6naybUrKYszdwkHw+n8ZL5ipHno3cMwJAfLCF5sIBNxjIGvQBVqH+Eai+782nlxi7sFy4U2opc0CpER+IRx8py3M6P48byH3/LJbeSq/kq+DR7VGXiUIJPM2fMRxLJV/b95FAod7Ufaz6aheA64bNh4JWAvIFgwJC2dwYdOVqgzC2zrJVeBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDxJQRXj3nDIo1O0aXZt2AxPdyzDfqvAU3tWFOr9YNA=;
 b=gxG/08m/4znqnh9+UI/ZAasQDQRGxzDIxsIhPQH8S0DBKTHRAuNV6FIT2E58h78XKCj4ecvjrN4Bg5DksszxwqSqjmv4UA84s2zrROUbl4b1ohMG/XnOdob7TJG3YbTyycW2nXIhNV1+8P+YbeQ/Uvvmge9yoZRgHVVu4rmqnCd2snJp1AraAcN0HfOmI5o1OtMxjJUUyr8sDRylJcX13/ByWC0jIG8ejfVLsnYPs81Y24aAiHMkXrHDPuLhcfSfHaZyG3kjAyfzZZnOS3T+yCyM7MYKkNGmk/25dUEfCxh9bqCUmdLNKb/CCUWvvjbzjVBpQkRVR1Vou18/xYedHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SA1PR11MB6917.namprd11.prod.outlook.com (2603:10b6:806:2bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 19 Oct
 2023 10:57:16 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%5]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 10:57:15 +0000
Date:   Thu, 19 Oct 2023 18:57:00 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Madadi Vineeth Reddy <vineethr@linux.ibm.com>
CC:     <cover.1695704179.git.yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
        <linux-kernel@vger.kernel.org>, Chen Yu <yu.chen.surf@gmail.com>,
        "Madadi Vineeth Reddy" <vineethr@linux.ibm.com>
Subject: Re: [PATCH 0/2] Introduce SIS_CACHE to choose previous CPU during
 task wakeup
Message-ID: <ZTELfNyUDAL0s36C@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1695704179.git.yu.c.chen@intel.com>
 <3f98806b-fd74-cfba-b48c-2526109d10a3@linux.ibm.com>
 <ZS5rhO5XysGOUn4M@chenyu5-mobl2.ccr.corp.intel.com>
 <eb45778d-3302-2ece-8d2e-319b1fcd071d@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <eb45778d-3302-2ece-8d2e-319b1fcd071d@linux.ibm.com>
X-ClientProxiedBy: KL1PR0401CA0008.apcprd04.prod.outlook.com
 (2603:1096:820:f::13) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SA1PR11MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef1da7f-2e85-428e-b1d6-08dbd0922768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KKKqK4AynMOwsOBN4tK/AjECJdQPGwVAyMySjyHFiS3vXtWSsMBRmXSOW2LOhUm6IUu90OVYdkWfUnPJcgErFNKrdVdc0ZJwxPear+mf1ZqZGW/oOh8pV7vhq56b4debNzrBeHjNh+ZMq70DgTKBvJloYUggFZqNEWzXH2csRENJyBeZVX7hLqHjfZiqh29MLmgLmaba0HRQhAL4i1xMJYQ4C8uWr2r6MQBrbC9a6UwVBWFBZ7hnprmnpGyl+tW+NjiCeZq8wj5V2RTLb6rL1GDrBmItXm9/ZTPiLhDaXWyDvkikQoE9K9q6gaTbggfw+I7IujtvoDPFd5oLbo8XeAMwQwJOiEjjNVbbJcAy8SGLAIqp+/780hCzjcHJmjasyGMOWMii6EVsdRHXtQFGfljPWHZkBF2LoAPwkBDPsFgGaZwwCXfOirQN1sOzU1fp66OBg9E0lLSl/FO2OF+B758dtCGf7TxuT8yGhSJiKxhWupRxQed1E5Ads7eYjCTL2F+UbRpctGH8k1fDZYAewgUmf39g/ePdckkCm14atPc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(366004)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6916009)(478600001)(316002)(6486002)(6666004)(6512007)(53546011)(6506007)(54906003)(66946007)(66476007)(66556008)(966005)(4326008)(41300700001)(5660300002)(8676002)(8936002)(7416002)(26005)(2906002)(38100700002)(4001150100001)(83380400001)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DNfyXpA75sGEdm67/LtcBEvSmQPeKWBu8tbwdvrLlwVRk/II5IUCsigefpf2?=
 =?us-ascii?Q?C48ojzW+aT9tFaSv3Nd1A9SvRGOuRR/6XTVJoByGzGNDOe5hrEQ+hOw7HGVi?=
 =?us-ascii?Q?v9ksauGdBgFHprI/bcvgQiz8vGDRYC2N0HWS4MEUB9qa/z+viChEaBwvSo+O?=
 =?us-ascii?Q?UzpRrLuo0bgKh8pHsU2nXgTD/KwomZXai+30G5UH7JAUBGsoXyL820X13xUX?=
 =?us-ascii?Q?YfcJ1Gkgb+NTJoEKjCCVBCz2WDiyjmruET7gLQzD8JU2Kle0L7Ql0trqleZ+?=
 =?us-ascii?Q?qeq4ru6jGVqvPpjg7j7NXfU/a9czyq5D5LseRwPVdsL1HvxSLM0WMvir1Pf4?=
 =?us-ascii?Q?oh+Tdp53Ouo8Kfcp7VLmgzOsULrpY5dAdVyrS0ELWyDAz9lW5A7ATCoy2gq7?=
 =?us-ascii?Q?Xp9EEWiOpl6CY/5RfaofTiION/eQUP5x2gKHG4opORe66dShHMdc5NtmbGnY?=
 =?us-ascii?Q?AA11hRI+zbMKlkmN6AmegwCbZBkTAvwCV5YmuLgsgQKvjjto6MVZ2aP5nFpS?=
 =?us-ascii?Q?F0l9VS29IA6DELt4HmSyyhIWIpc8UOkTfVBB6sTKuUgdL8eKIQA6/RzKb6UI?=
 =?us-ascii?Q?jSr60LQ7bpGEPmN/7i9nxWpU71yoHfAgHQ8RSjd5sjvfb3f5B7K2pGmMu6DN?=
 =?us-ascii?Q?5fW9hxpIODlu7kmIceOOBftZOT2bYMi+mykDsOZkkAdoGVibywxW67+kVUi5?=
 =?us-ascii?Q?lWp3+vw7mlsk10u5lHBsGkibqK3+4gNbxRsZ6gDbF9Oh3888mhh4Uv8flKlw?=
 =?us-ascii?Q?b09VjoRvPyCLyvNT+UUsTtE04hwVmub7UOx47lpeCTnm7VI3cAop1sjpfWfl?=
 =?us-ascii?Q?sKFaVCgt+dSil748RkS5QhdK76AQ8nSadh9ee4xjtbgyZWZkALSqz2X7WyXb?=
 =?us-ascii?Q?wrzrx0ACh6LsqxLhokveNUkn89lRQnxAhxWxTPXHxjpGY8Uw/MGbUT0lxtk5?=
 =?us-ascii?Q?kk6kwiSEqYM53YZj3c6uyu19YBctdewYLJZHni5qs1kLtJZVYw1yJjQiM5P+?=
 =?us-ascii?Q?21kFxeka1pv8ywBBVe11SJ5L3Hyp2FlHq0xpH789nHp43t6r7qyz8AEVYqbR?=
 =?us-ascii?Q?zSHqHbCB8TlJ6KmhrvAUSp4IsqXr6UE+hB0Xg43ky2WhE9ceAkFSfW5TebiD?=
 =?us-ascii?Q?WExIE9GYUrn3zY2++dLykiokwWSdUJLDK3mPufg6EwEb+Q1htOt8Wt54aEJC?=
 =?us-ascii?Q?dwC1RHaU4Mwd5iDbCrqtFkmUUxzKI3fKiAzpQq7W5o7hjr02yU/b6v/hVzU0?=
 =?us-ascii?Q?kt2ggI0zlDdwfgS7IWW44EnovYUTZI8BtXS4vmpIGj3IxpdsNScxE+n6kihT?=
 =?us-ascii?Q?6aSlBe16iS+AdSgQExXIpkSWW6iX9PKL20RhMnbviM//n/1OGTQOtQ9gcU2B?=
 =?us-ascii?Q?HDUv/d+nfYszgpoGY20FaPQKTFR3lBfMEBM8PgZ+B+w7j2o3+lS9aZwJ0vle?=
 =?us-ascii?Q?BwxGMx6CzUJvEDP3kwEETlXLUJyrPpRCYmUSaniCmKV3yAtv+QY2cyrXm6wc?=
 =?us-ascii?Q?BOh5F55JXdlewAzdCiNwEzxCmU6G2xMtQ/hUyTwv+Fm5p0kYy3CbfSvChs8K?=
 =?us-ascii?Q?lIgxuGY2DMtmyW05Csb46ePaqqCrHZS0k5lG60KE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef1da7f-2e85-428e-b1d6-08dbd0922768
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:57:15.2122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJfAJqXxduwuHDATeGEL7vrQjunb9g/tnDjtz29+xnSUU954KfGi3VXEmBz0AKupDAeB918R8YIX47co91J9nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6917
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-19 at 01:02:16 +0530, Madadi Vineeth Reddy wrote:
> Hi Chen Yu,
> On 17/10/23 16:39, Chen Yu wrote:
> > Hi Madadi,
> > 
> > On 2023-10-17 at 15:19:24 +0530, Madadi Vineeth Reddy wrote:
> >> Hi Chen Yu,
> >>
> >> On 26/09/23 10:40, Chen Yu wrote:
> >>> RFC -> v1:
> >>> - drop RFC
> >>> - Only record the short sleeping time for each task, to better honor the
> >>>   burst sleeping tasks. (Mathieu Desnoyers)
> >>> - Keep the forward movement monotonic for runqueue's cache-hot timeout value.
> >>>   (Mathieu Desnoyers, Aaron Lu)
> >>> - Introduce a new helper function cache_hot_cpu() that considers
> >>>   rq->cache_hot_timeout. (Aaron Lu)
> >>> - Add analysis of why inhibiting task migration could bring better throughput
> >>>   for some benchmarks. (Gautham R. Shenoy)
> >>> - Choose the first cache-hot CPU, if all idle CPUs are cache-hot in
> >>>   select_idle_cpu(). To avoid possible task stacking on the waker's CPU.
> >>>   (K Prateek Nayak)
> >>>
> >>> Thanks for your comments and review!
> >>>
> >>> ----------------------------------------------------------------------
> >>
> >> Regarding making the scan for finding an idle cpu longer vs cache benefits, 
> >> I ran some benchmarks.
> >>
> > 
> > Thanks very much for your interest and your time on the patch.
> > 
> >> Tested the patch on power system with 12 cores. Total of 96 CPU's.
> >> System has two NUMA nodes.
> >>
> >> Below are some of the benchmark results
> >>
> >> schbench 99.0th latency (lower is better)
> >> ========
> >> case            load        	baseline[pct imp](std%)       SIS_CACHE[pct imp]( std%)
> >> normal          1-mthreads      1.00 [ 0.00]( 3.66)            1.00 [  0.00]( 1.71)
> >> normal          2-mthreads      1.00 [ 0.00]( 4.55)            1.02 [ -2.00]( 3.00)
> >> normal          4-mthreads      1.00 [ 0.00]( 4.77)            0.96 [ +4.00]( 4.27)
> >> normal          6-mthreads      1.00 [ 0.00]( 60.37)           2.66 [ -166.00]( 23.67)
> >>
> >>
> >> schbench results are showing that there is not much impact in wakeup latencies due to more iterations 
> >> in search for an idle cpu in the select_idle_cpu code path and interestingly numbers are slightly better 
> >> for SIS_CACHE in case of 4-mthreads.
> > 
> > The 4% improvement is within std%, so I suppose we did not see much difference in 4 mthreads case.
> > 
> >> I think we can ignore the last case due to huge run to run variations.
> > 
> > Although the run-to-run variation is large, it seems that the decrease is within that range.
> > Prateek has also reported that when the system is overloaded there could be some regression
> > from schbench:
> > https://lore.kernel.org/lkml/27651e14-f441-c1e2-9b5b-b958d6aadc79@amd.com/
> > Could you also post the raw data printed by schbench? And maybe using the latest schbench could get the
> > latency in detail.
> >  
> 
> raw data by schbench(old) with 6-mthreads
> ======================
> 
> Baseline (5 runs)
> ========
> Latency percentiles (usec)                                                                                                                                                                                                                                  
>         50.0000th: 22
>         75.0000th: 29
>         90.0000th: 34
>         95.0000th: 37
>         *99.0000th: 981 
>         99.5000th: 4424
>         99.9000th: 9200
>         min=0, max=29497
> 
> Latency percentiles (usec)
>         50.0000th: 23
>         75.0000th: 29
>         90.0000th: 35
>         95.0000th: 38
>         *99.0000th: 495 
>         99.5000th: 3924
>         99.9000th: 9872
>         min=0, max=29997
> 
> Latency percentiles (usec)
>         50.0000th: 23
>         75.0000th: 30
>         90.0000th: 36
>         95.0000th: 39
>         *99.0000th: 1326
>         99.5000th: 4744
>         99.9000th: 10000
>         min=0, max=23394
> 
> Latency percentiles (usec)
>         50.0000th: 23
>         75.0000th: 29
>         90.0000th: 34
>         95.0000th: 37
>         *99.0000th: 55
>         99.5000th: 3292
>         99.9000th: 9104
>         min=0, max=25196
> 
> Latency percentiles (usec)
>         50.0000th: 23
>         75.0000th: 29
>         90.0000th: 34
>         95.0000th: 37
>         *99.0000th: 711 
>         99.5000th: 4600
>         99.9000th: 9424
>         min=0, max=19997
> 
> SIS_CACHE (5 runs)
> =========
> Latency percentiles (usec)                                                                                                                                                                                                                                                                                     
>         50.0000th: 23
>         75.0000th: 30
>         90.0000th: 35
>         95.0000th: 38
>         *99.0000th: 1894
>         99.5000th: 5464
>         99.9000th: 10000
>         min=0, max=19157
> 
> Latency percentiles (usec)
>         50.0000th: 22
>         75.0000th: 29
>         90.0000th: 34
>         95.0000th: 37
>         *99.0000th: 2396
>         99.5000th: 6664
>         99.9000th: 10000
>         min=0, max=24029
> 
> Latency percentiles (usec)
>         50.0000th: 22
>         75.0000th: 29
>         90.0000th: 34
>         95.0000th: 37
>         *99.0000th: 2132
>         99.5000th: 6296
>         99.9000th: 10000
>         min=0, max=25313
> 
> Latency percentiles (usec)
>         50.0000th: 22
>         75.0000th: 29
>         90.0000th: 34
>         95.0000th: 37
>         *99.0000th: 1090
>         99.5000th: 6232
>         99.9000th: 9744
>         min=0, max=27264
> 
> Latency percentiles (usec)
>         50.0000th: 22
>         75.0000th: 29
>         90.0000th: 34
>         95.0000th: 38
>         *99.0000th: 1786
>         99.5000th: 5240
>         99.9000th: 9968
>         min=0, max=24754
> 
> The above data as indicated has large run to run variation and in general, the latency is
> high in case of SIS_CACHE for the 99th %ile.
> 
> 
> schbench(new) with 6-mthreads
> =============
> 
> Baseline
> ========
> Wakeup Latencies percentiles (usec) runtime 30 (s) (209403 total samples)
> 	  50.0th: 8          (43672 samples)
> 	  90.0th: 13         (83908 samples)
> 	* 99.0th: 20         (18323 samples)
> 	  99.9th: 775        (1785 samples)
> 	  min=1, max=8400
> Request Latencies percentiles (usec) runtime 30 (s) (209543 total samples)
> 	  50.0th: 13648      (59873 samples)
> 	  90.0th: 14000      (82767 samples)
> 	* 99.0th: 14320      (16342 samples)
> 	  99.9th: 18720      (1670 samples)
> 	  min=5130, max=38334
> RPS percentiles (requests) runtime 30 (s) (31 total samples)
> 	  20.0th: 6968       (8 samples)
> 	* 50.0th: 6984       (23 samples)
> 	  90.0th: 6984       (0 samples)
> 	  min=6835, max=6991
> average rps: 6984.77
> 
> 
> SIS_CACHE
> =========
> Wakeup Latencies percentiles (usec) runtime 30 (s) (209295 total samples)
> 	  50.0th: 9          (49267 samples)
> 	  90.0th: 14         (86522 samples)
> 	* 99.0th: 21         (14091 samples)
> 	  99.9th: 1146       (1722 samples)
> 	  min=1, max=10427
> Request Latencies percentiles (usec) runtime 30 (s) (209432 total samples)
> 	  50.0th: 13616      (62838 samples)
> 	  90.0th: 14000      (85301 samples)
> 	* 99.0th: 14352      (16149 samples)
> 	  99.9th: 21408      (1660 samples)
> 	  min=5070, max=41866
> RPS percentiles (requests) runtime 30 (s) (31 total samples)
> 	  20.0th: 6968       (7 samples)
> 	* 50.0th: 6984       (21 samples)
> 	  90.0th: 6984       (0 samples)
> 	  min=6672, max=6996
> average rps: 6981.07
> 
> In new schbench, I didn't observe run to run variation and also there was no regression
> in case of SIS_CACHE for the 99th %ile.
>

Thanks for the test Madadi, in my opinion we can stick with the new schbench
in the future. I'll have a double check on my test machine.

thanks,
Chenyu
