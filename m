Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DB87C5003
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345779AbjJKKYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345930AbjJKKXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:23:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A77DE
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697019830; x=1728555830;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=N6GqotiyF95xmjcExrilBC0INWl6Bh7kCz9uC7SD5n8=;
  b=OF40dFltfs6vEahJpDpKpUyf/nkTx2D0mEmtd44eLCCQOeYXOPICPcK/
   5DhusJcNI9fAgnsB+loK4U2ktHEJYN435J2vFIJJsJhqFCUeAvu2uupXH
   ohPBDjSlJrAlrwArWejpGbDMWsVtJYKwIpGUOj93Mqr3eKcJ5GtdX8lwg
   mIDCGLDiV/zwPKUlZ6Dt2imyV9S62jCSYwenR/5kl7sHU7WEQx/o6pnF2
   +4UZVap4RsaDPZ5pdPtAwI6NJ+4c0FKUEZGoGDTD+ncmcxw9/eVat6I3y
   VrJsnupO3hAiV3Zg3qAp3BK2O4KtTV10ghHTrhUZSJ2ECq7efM15QHwNN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="451119055"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="451119055"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:23:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="788948435"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="788948435"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 03:23:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 03:23:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 03:23:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 03:23:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 03:23:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVd2K7CcVKayfUm1WMX8AQjGqRLd2+fljg85rvLKL3Wxle+2z38dnZUWFCsIzaDm4/c5KSeQkyeoZzZpjE7tZml9bQRCv5JHzavsrfb/IaJo74Y4Nb2MlP6Jt622OQYi4WT53bq99r6Vt+L6W9roMbgCH2B8Vt3cdgZkoa8JJZi6tO6lX+sne9w4qnmjqac09VzMAya8KXaXeAiRPF/FdBsw8FIH8nL8usxspNW6WJcePArbK6UEqczEtHms5P4MYMizA7sAOJ1OYi3And7BPQH8pLID/ypiC6fnwaXXXYMZ5TQW3sf0iJix1q98y0bpdekxeToonSxPMLI/P4c8Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAELR0tFutZgcE39bm/QTNBbw/i7gq5UeajG379SGQc=;
 b=f2GZTPAK/HQPvDgPwj6/E5CsIpt/uwVB9CgxvyZbtl2TC7AJIIqXOVsHGhJ478TvtWFUavsr/l4IjPJ3f82IiUCeKdIcTwXb3SQVtw2Z9Yo2dWzdJAu8Tbg/bs5m6f0AzouANG3OqqL3Gp2NNEfQhKyzesMhIppWQyk9GsnrB8LQ8rOH5uO8Q+s5brsp1K7xG8fo/3azzCoo7WwZUpKuM0xvGTeJABuy49mKLHvfiqpveHaOkTU7TH40Y8ypXJGNJSl7YtA5Pgy1amxY2M7uZX6O1mi8+zAxt+DdQaYF0pRweLLGWAtnjPlGVOwSWOQUSOsSHGxcriaYPuXYpVNucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by BL1PR11MB5287.namprd11.prod.outlook.com (2603:10b6:208:31b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 10:23:45 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%5]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 10:23:45 +0000
Date:   Wed, 11 Oct 2023 18:23:30 +0800
From:   Chen Yu <yu.c.chen@intel.com>
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
        Aaron Lu <aaron.lu@intel.com>, Tim Chen <tim.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, <x86@kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Bias runqueue selection towards almost
 idle prev CPU
Message-ID: <ZSZ3otWxbXWwmOGh@chenyu5-mobl2.ccr.corp.intel.com>
References: <20230929183350.239721-1-mathieu.desnoyers@efficios.com>
 <ZRfKKxBzfu+kf0tM@chenyu5-mobl2.ccr.corp.intel.com>
 <0f3cfff3-0df4-3cb7-95cb-ea378517e13b@efficios.com>
 <ZSORUczD6tp2fbe7@chenyu5-mobl2.ccr.corp.intel.com>
 <54d3a982-86e2-4317-a08f-a4eec0374227@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <54d3a982-86e2-4317-a08f-a4eec0374227@efficios.com>
X-ClientProxiedBy: SGBP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::36)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|BL1PR11MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: b55f321e-51f0-4bc7-b16d-08dbca44266e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6XjVDese4fNMhZ/Ur21yPy7gFptJ8qvUcaCOHRSCUDdmRC81+69pAQmz/X/czm/r6Uv2pljqInL6Qcc0CZK6x5DEd3cw9gLqwj1CpU+qVtvJIHMehMjizFUBUU+COeyKQMEEyvfIbiO0moVgtqaRYSSv/BhPQTIyvNoNVG7VwRPv9wFtbLEk/uqeqDn+ErEmkDOvXyE0xED3huOX/6qZOCUFjFEuucKYq4VCTn0kynTAyjRZqG3ObW4dYiaCNG56uU5p7QjnNgGRaHIIACImNdulsqjJ9fWaM0RvIKpLhEL2S6PuwB8yxr3qj+3TU9Am3E9OBTl4YJ/HtZqLTkWXzOC4d4HXMC7vPfP/DHjVdHw4l3aibWRBWadpcWySmSDb/E4BXna8Hro8HyiaO/Oxz3DPvhR3NUTH9YMBoOhfJLo/AguVYb2MPxiVKwM9k0lXezaAOVlzonbtgnDiE3oJzvwqXlFZX8lea/3EkIf6tMFF0xyS6qLYQbmmIAzW3zjbW0KlXx0tP4OKkt+miKE0sIveTU5NoaOCqFR5PlBWFnUashmHhfPVNiw0OnUuYQ8V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(66899024)(53546011)(6512007)(86362001)(38100700002)(26005)(7416002)(66556008)(4001150100001)(83380400001)(6666004)(6486002)(478600001)(8936002)(82960400001)(6506007)(8676002)(316002)(4326008)(41300700001)(6916009)(2906002)(66946007)(5660300002)(54906003)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dhXt7BPmh1o4rjIrBdeaM8h0WU8+62jpCr2nqfEy4T5AbJchfktI1dymLcjA?=
 =?us-ascii?Q?CireN2VC67nj4i/gxqhRQvzMkmdJFyGzeMPAnlIhkzPWcuao2OnbazR2WQHf?=
 =?us-ascii?Q?oHErjAk90ClIQp27aBbrX4dE6Mt8rTHTHFk4sGO3T+TfGP3EFKLrtmoB3YYM?=
 =?us-ascii?Q?lGgVE7bcoPGkiksFLpzqsNp5wbO7+0hN4yTOyErMxd0y+DUNa7gPaHiX5Vzp?=
 =?us-ascii?Q?Jg/XUAoNjGrdAqbSjxQ+kx7qFM1m2QOCDDUyxR/XOhptSU76ZONBPRKGofZZ?=
 =?us-ascii?Q?/QmKfaHQa7cA2CWG/WAe84zy2DeT109/R9fxwU+0Be1/Cv47YXadfQSB7foV?=
 =?us-ascii?Q?vHgPN42gTUvIoE2tqfSAjcKZIEwMxQoYqGbeWGDQtyYFYfM3YH1PDXpJxNsd?=
 =?us-ascii?Q?63tkpfsqKQfMm0VhV+v5T+601gu8vkSyl+SK68ge2tC/9273V4SC3cnvEU/H?=
 =?us-ascii?Q?hx4B1mIrmhtLzOWJiyqEi7rZQTlvavS7mlFpmacoA5Sl6A2EQ+F/NBVc6cjw?=
 =?us-ascii?Q?7/9PcE93CKbm19yfjIoQH1dcObTicaXRQLBUY2naeWZLZJptRnFL/4QSVSWG?=
 =?us-ascii?Q?03qVyzMRJXwU9xvTfP3N1MijP6Htkv441Lro3fo6hBMmQuClkZieJVH9MJkj?=
 =?us-ascii?Q?/EH40JV5qvFf2c0gMp11gjdWCpioGgqay20jIRcgFa1TxQsyy+InM7MQrdeZ?=
 =?us-ascii?Q?AA5dXZal3A3/Olm1+LpBc6oE9TKdGwNbHQjKTyDsviOddhFMz22Izz+pLulJ?=
 =?us-ascii?Q?mrK0zKrMKIaA1LyiiIV5gy1qnqr1LApTgM2zoODCE57j1rclFzvBy/sL/a/a?=
 =?us-ascii?Q?xs20TFCS2D0tOZuJR7sZs8fpjLY0hsi9CT+cMVUOtZutgpJvlYN3jnhZnatm?=
 =?us-ascii?Q?Vi2JFYkgCGG1+7b28e+AwA4Z2D0gYjtpdMeO6JVmez88q2lhQoTg1FIPr0rZ?=
 =?us-ascii?Q?skGvSQZZX5JOcsVIZqHUDIAioTd5Y0JCk1OPPfPYw4Y+44w1S80ZVoCq7YMr?=
 =?us-ascii?Q?Y+fFRRwFLWKJPRrbaKGlcsmDRjXL27CmmYrN+n5XTVRAyh0KcgbpVkd5Zue7?=
 =?us-ascii?Q?80iAR2wkB1sif3THtpO8NdOCQK+KsnJ9iUSJFG9j4kruxrH0is6MjiAgCq4H?=
 =?us-ascii?Q?MJwvK7EvWyvTfDH4GqLkSv2XJoUVonk74IzXWjS1anyiXC7MHgo0XNsjjBPI?=
 =?us-ascii?Q?jAppyKb4M7ffKIiq4oVHk+k/5HWLPoB3fnWlFGlP5pwuOqqA2PG0X6ZPeEIY?=
 =?us-ascii?Q?6NCYzXaNTLBM96mNkSY9m4aAaLeZ3RZXcU+aYB9TiH3R+4Mpl8z5zDMZTcsU?=
 =?us-ascii?Q?9I9HJ/dfA9b/PJm54VF35XkyJBdXl4SVqi1WI/XAVtJrzaZPGr8kfsNmHd2B?=
 =?us-ascii?Q?KdureQpo149ntoxqfOu7nmj2EpX6geKt7+Xq8xKdmEgjOxJm0gX7JrOdYtLs?=
 =?us-ascii?Q?+/C5120VUDtSvYDteNy1LozxhhLFApPYl7/E4YNpzPYUDGNCKdGVaNTl6Irh?=
 =?us-ascii?Q?NmRt6fXkmwX6/SsZ5br+ZxjiDHW4oo7uQ7kJqfnwLmrFuHzJVesnY4XJCFCI?=
 =?us-ascii?Q?f0wQpPKFTk7ioS1LAL+SkKJLjaHXHmVXCiO/SThz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b55f321e-51f0-4bc7-b16d-08dbca44266e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 10:23:45.5383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zsCfee7hRCu99jx9XyjtcrDB2LZufl/fzfcbawVHpiIrN/HK6GMzLXIus27SiK3bL0bor6l/4QVB4YVWh9583Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5287
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-10 at 10:18:18 -0400, Mathieu Desnoyers wrote:
> On 2023-10-09 01:36, Chen Yu wrote:
> > On 2023-09-30 at 07:45:38 -0400, Mathieu Desnoyers wrote:
> > > On 9/30/23 03:11, Chen Yu wrote:
> > > > Hi Mathieu,
> > > > 
> > > > On 2023-09-29 at 14:33:50 -0400, Mathieu Desnoyers wrote:
> > > > > Introduce the WAKEUP_BIAS_PREV_IDLE scheduler feature. It biases
> > > > > select_task_rq towards the previous CPU if it was almost idle
> > > > > (avg_load <= 0.1%).
> > > > 
> > > > Yes, this is a promising direction IMO. One question is that,
> > > > can cfs_rq->avg.load_avg be used for percentage comparison?
> > > > If I understand correctly, load_avg reflects that more than
> > > > 1 tasks could have been running this runqueue, and the
> > > > load_avg is the direct proportion to the load_weight of that
> > > > cfs_rq. Besides, LOAD_AVG_MAX seems to not be the max value
> > > > that load_avg can reach, it is the sum of
> > > > 1024 * (y + y^1 + y^2 ... )
> > > > 
> > > > For example,
> > > > taskset -c 1 nice -n -20 stress -c 1
> > > > cat /sys/kernel/debug/sched/debug | grep 'cfs_rq\[1\]' -A 12 | grep "\.load_avg"
> > > >     .load_avg                      : 88763
> > > >     .load_avg                      : 1024
> > > > 
> > > > 88763 is higher than LOAD_AVG_MAX=47742
> > > 
> > > I would have expected the load_avg to be limited to LOAD_AVG_MAX somehow,
> > > but it appears that it does not happen in practice.
> > > 
> > > That being said, if the cutoff is really at 0.1% or 0.2% of the real max,
> > > does it really matter ?
> > > 
> > > > Maybe the util_avg can be used for precentage comparison I suppose?
> > > [...]
> > > > Or
> > > > return cpu_util_without(cpu_rq(cpu), p) * 1000 <= capacity_orig_of(cpu) ?
> > > 
> > > Unfortunately using util_avg does not seem to work based on my testing.
> > > Even at utilization thresholds at 0.1%, 1% and 10%.
> > > 
> > > Based on comments in fair.c:
> > > 
> > >   * CPU utilization is the sum of running time of runnable tasks plus the
> > >   * recent utilization of currently non-runnable tasks on that CPU.
> > > 
> > > I think we don't want to include currently non-runnable tasks in the
> > > statistics we use, because we are trying to figure out if the cpu is a
> > > idle-enough target based on the tasks which are currently running, for the
> > > purpose of runqueue selection when waking up a task which is considered at
> > > that point in time a non-runnable task on that cpu, and which is about to
> > > become runnable again.
> > > 
> > > 
> > 
> > Based on the discussion, another effort to inhit task migration is to make
> > WA_BIAS prefers previous CPU rather than the current CPU. However it did not
> > show much difference with/without this change applied. I think this is because
> > although wake_affine_weight() chooses the previous CPU, in select_idle_sibling()
> > it would still prefer the current CPU to the previous CPU if no idle CPU is detected.
> > Based on this I did the following changes in select_idle_sibling():
> > 
> > 1. When the system is underloaded, change the sequence of idle CPU checking.
> >     If both the target and previous CPU are idle, choose previous CPU first.
> 
> Are you suggesting that the patch below be used in combination with my
> "almost_idle" approach, or as a replacement ?
>

This patch is composed of two parts: the first one is to deal with underloaded
case, which is supposed to check if it could choose previous idle CPU over
an almost idle CPU. But according to your test, this does not have effect.
The second part is to deal with the overloaded case which I found that it
could bring benefit when the system is overloaded.
 
> I've tried my workload with only your patch, and the performances were close
> to the baseline (bad). With both patches combined, the performances are as
> good as with my almost_idle patch. This workload on my test machine has cpus
> at about 50% idle with the baseline.
> 

Yes, the benefit should come from the almost idle strategy.

> > 
> > 2. When the system is overloaded, and all CPUs are busy, choose the previous
> >     CPU over the target CPU.
> > 
> > hackbench -g 16 -f 20 -l 480000 -s 100
> > 
> > Before the patch:
> > Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
> > Each sender will pass 480000 messages of 100 bytes
> > Time: 81.076
> > 
> > After the patch:
> > Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
> > Each sender will pass 480000 messages of 100 bytes
> > Time: 77.527
> > 
> > track the task migration count in 10 seconds:
> > kretfunc:select_task_rq_fair
> > {
> >          $p = (struct task_struct *)args->p;
> >          if ($p->comm == "hackbench") {
> >                  if ($p->thread_info.cpu == retval) {
> >                          @wakeup_prev = count();
> >                  } else if (retval == cpu) {
> >                          @wakeup_curr = count();
> >                  } else {
> >                          @wakeup_migrate = count();
> >                  }
> >          }
> > }
> > 
> > Before the patch:
> > @wakeup_prev: 8369160
> > @wakeup_curr: 3624480
> > @wakeup_migrate: 523936
> > 
> > After the patch
> > @wakeup_prev: 15465952
> > @wakeup_curr: 214540
> > @wakeup_migrate: 65020
> > 
> > The percentage of wakeup on previous CPU has been increased from
> > 8369160 / (8369160 + 3624480 + 523936) = 66.85% to
> > 15465952 / (15465952 + 214540 + 65020) = 98.22%.
> 
> Those results are interesting. I wonder if this change negatively affects
> other workloads though.
>

I haven't tested other benchmarks yet and just to send this idea out. I could
launch more test to see if could bring other impact.
 
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e2a69af8be36..9131cb359723 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7264,18 +7264,20 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >   	 */
> >   	lockdep_assert_irqs_disabled();
> > -	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
> > -	    asym_fits_cpu(task_util, util_min, util_max, target))
> > -		return target;
> > -
> >   	/*
> >   	 * If the previous CPU is cache affine and idle, don't be stupid:
> > +	 * The previous CPU is checked prio to the target CPU to inhibit
> 
> prio -> prior
>

Thanks for pointing this out.

thanks,
Chenyu 
