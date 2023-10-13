Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2387D7C88D7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjJMPhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjJMPhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:37:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE36BB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697211458; x=1728747458;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uqf5AOtrz0Hp1RUPVFbRhHcoEG3PBh3hr/05bijzzVg=;
  b=drA1OtMP3XwPZ4aic7XKtf9HgmxTT6KAC6HrxWUcqqB0z+OE3BvoaZLk
   5hL45K/upKur0ctZlqtyekRFbW9BnUrWDwZai4a/GcxabzEuTMi5eC9EP
   46KTNCDSVdfx8Gi+pN04VkZiFFZggK2hbMPeiPaOZU8a4x/rOX232ikFR
   63UCg6yQCoZwc1Ip+vFEPmIdMr+RBYNqZ1jfJVCbqOmwwR4/XMa5VSTJc
   F57Rympp/wmZ1UCfQYk5QGJINbEfSv5aKxqSVVlXThRzSFj6/UxgkveMC
   TRUbT6xwIBO2kNLmnSQAm99FFMF/pPY8+2Nnc26rHIWY1OIaKdsZ7faQp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="370273489"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="370273489"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 08:37:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="784206964"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="784206964"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 08:37:36 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 08:37:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 08:37:36 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 08:37:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIKK0Gj0p7ThUwyqjx9ER7pD+TUeu1PqFnGnDScoIRndoJlrLbdCdjPJjB3LKLRkPjWul0tjMAbd4aFqP0EwTfQ1LD+PghiJWyMxWpTGnmXv5obF5VhXmJurBk/ZzXBR+ldVXV5rdJgCq7WYiwBRDql/up9DtYVKwY4HnL/ziwdWJCzMMc41N3SAAng+8WYZN0KmhCzkvuYiWoKvjtUuISnbp/kaYMlxstYFABWK9PFKFBLXX3WuhtLHvrl8UYT2mJCeOCxC0a8mrz17UA+Lw0HoZC6pWKONFA/0ajF2nsewHdsNOazcK5Zp+8ktsnMGzU7xj9KF/O3IHtgtQb5DAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5G5SRfc+8qsu16KhGTZBNJ1No2Mokuj8MSfVnCyLLkg=;
 b=fVqxOMR/dLiG23Lct+OSR74UXApgqirxIPYsT0uCLVQIGHQCj5DCiFjbUJ/FGDI11BWaAMRS/AJpjEomg7KxMB2BTSVpYNiOaXQeaFJ9Rpmilzwx59Kp50Dd0qFUIWDLGP489VBDbhnLDX3TnfUm6nONhmIKJRjE6pkX7xHUcarJ+fO/TNDgpJAjzRFWZDmXYynxnKwf9jAd5XIB/CaUk/zKhuf3EY4AZk73GMeOCJf2eHSStgqOrrWbsfd7W8Nb65x1ucKsYnL7p53RK8y4KEm1gV3hgrGCJhGTqXodPZoCQDNVltFcTYHYZw0cC9/Y+gkia/KkvhRYjwU/iRza/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by MN2PR11MB4581.namprd11.prod.outlook.com (2603:10b6:208:26c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 15:37:34 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%5]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 15:37:34 +0000
Date:   Fri, 13 Oct 2023 23:37:18 +0800
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
Message-ID: <ZSlkLqa55j4C2rDl@chenyu5-mobl2.ccr.corp.intel.com>
References: <20230929183350.239721-1-mathieu.desnoyers@efficios.com>
 <ZRfKKxBzfu+kf0tM@chenyu5-mobl2.ccr.corp.intel.com>
 <0f3cfff3-0df4-3cb7-95cb-ea378517e13b@efficios.com>
 <ZSOMOhhkPIFmvz97@chenyu5-mobl2.ccr.corp.intel.com>
 <ebe4e40f-37df-40a9-9dfc-7f2a458151bd@efficios.com>
 <ZSZ2ERMysY7iEo+x@chenyu5-mobl2.ccr.corp.intel.com>
 <CAKfTPtCpMx9mHrWko6_hgbw+8HObcJJNkj3A6ZEP4C1PekcxMQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKfTPtCpMx9mHrWko6_hgbw+8HObcJJNkj3A6ZEP4C1PekcxMQ@mail.gmail.com>
X-ClientProxiedBy: SG2PR03CA0094.apcprd03.prod.outlook.com
 (2603:1096:4:7c::22) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|MN2PR11MB4581:EE_
X-MS-Office365-Filtering-Correlation-Id: 683ac26a-7e57-484d-1fec-08dbcc0251dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: boAvbw5fu1rVlrP8Ax0KOfHFmW6Ezj0ArotidPgj/rlNNQPTd+X+39NAl+6g3CjywL2YZVahZlfIxJQbkWDBha5YapSp9cH+uRlMsdZYX8DTQWb5ttlOwsPYlJv7iUPgmaDjM+BrzRqwMHcd5Xm993i3pY7ymGaQdbN00c9w/IxkLb8FqU+2WDoSOEbKUjM85QCHHFEMDR3XQ+KjPPslIBpkyBlctdu4A09FA8cVJstkTYovePD01/YyNrRpVYqKb5RnJT0ECWSL1odm5HlZSpEfys0elZ5E6hHqrXMMlmiHRbJcRC1fDScVWhEoe3JTr8p0N1v40lCXCdl74Ve3ZR8KariMBIHcUEt6Mr8J6LeAWHivYowosYzQf9LuyLoZLkRGdiL3ys/APke9mHoembwQqvy7YYfHKBFNBV3A2z6BzeycnVs63+TW3+KXrGJlsM5/k6+kIRjhUQFVsw1AF8SbnlvKZZxTE4uHF81i9ch3Ecxo0VBsUMmvI8XVbfnpjR3u46gEASa8jZdn7/7c8YoTHTQYl5pqYkA50tXl91eEyTtpmlv23qMsBPF1dN/A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(7416002)(53546011)(6506007)(6666004)(2906002)(41300700001)(66556008)(66476007)(66946007)(4326008)(478600001)(26005)(5660300002)(6486002)(4001150100001)(6512007)(83380400001)(316002)(6916009)(54906003)(38100700002)(8676002)(82960400001)(86362001)(40140700001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZN8GvuspeAUHtAxhlpQTO8w80DQKdaZNIm8K/zoHQorJ4KZvTWBPT7sDA8A5?=
 =?us-ascii?Q?CT5B8eOaDyIiHjZjQp8k9mDdBn+2bjilKnnF4dIysoRMcFuCrozyGhqh7nfR?=
 =?us-ascii?Q?s1a+hybK8Nc1VMrPpQyKWu34N3HsuNGKVgc7a903d7r1uAvGgBWCFmjvoU6a?=
 =?us-ascii?Q?KQFYl+iASyC4/v50Yli/Uyg6zLU019NhAxGa0hZTDa2jtNajK7inpSnHsfR5?=
 =?us-ascii?Q?bWocTTxiIlKgN4RNnHcwIXND93K0gZOPh9IwJhR6H95M0zSvWqcB6fWyMXOj?=
 =?us-ascii?Q?3mFyxL0mqhF/hGfixld/tNyjrggJo9n6goFnFK5ySzZDFItDuv7iirHQDn81?=
 =?us-ascii?Q?Q7ygdl4lFkIC5yqB5khPkHiUn2yQjP6SLCF2KwZrpusK+2AtgK2sHqv60a0t?=
 =?us-ascii?Q?k6IHFhWTUK592nagyrn9vIA8mYndONO1kPFjz6Xp3DLY1ENBb7FIM09brcue?=
 =?us-ascii?Q?vZSfAAhP8XvcSHKUf4W+wIhqmkFLLcL1A9q5Cx2de9tG8J7FsR5XS7Dffopo?=
 =?us-ascii?Q?2IRpCZLPVTIxXNmcG9NBKeKFw2hJJaEGvKePeHB25wJzVS4+rhe3MbjWl1v/?=
 =?us-ascii?Q?LHnzyS+QEHYTwENfOX043ckr7l5cIAvOJF8z6tFCJZZ4iirlfG7Ru1MkEBVY?=
 =?us-ascii?Q?hgC7Vq9Uj1E5zKXQP06fQSoEgcHD8ZUNUGb1NGSduGpBZmvOXyk+NClAEOBu?=
 =?us-ascii?Q?PNnSXPjddHhqvRklHyhrmJE32JKTyrsBTOn2csJNhpqqUeDep8hQkXgzGiLh?=
 =?us-ascii?Q?n+pP+oMYnOechLAzYl9GyrvImwdAvlyD5tkNR3Us3GR1W2U9uqrFR7/R9fmK?=
 =?us-ascii?Q?/Vk9bugDVpiY+jno1Ro2U0agISI1b2NAw9e0Tr/SZzwD94YrxW6q+5B3gg8Q?=
 =?us-ascii?Q?mbjuW5eUNFVFLOPm1CWK0gAki6IFF8ythzD0aYHs7DrlkWuNwyUhHf5DUtXQ?=
 =?us-ascii?Q?OoRDAfDN5lDn0LxS3GgyJHtExoSeYuQILK76hNDtziaohMB5QD7+P6dm0Mp8?=
 =?us-ascii?Q?IjB/6BbrXuxEBoDjp55x9cbSJLge9Ug25MdhGpbFJkerzoUeF6SVOQ3I2JNb?=
 =?us-ascii?Q?BDuU3FtpY0SlLSeH4C7cK54oG9eEjz5IMA9SxEtxmapVsG9M0Kx5TJoffxtq?=
 =?us-ascii?Q?Yx8aDCBs44JEPEEAsh+OFsjGn20VRBDq0d0qfcg1CTkvBVAWt4ClUMVoG/sX?=
 =?us-ascii?Q?rrChFNTGN5+nMP/B+eXVQyfYI+PUJedOISs5G2V9qh2IuLgb1XBz9Fx9XdNa?=
 =?us-ascii?Q?WwmoyrsYW+JqT/10GeQPbFufKS6/S1Gm8xCszNPsVUDLqiQhcRVr743FQutS?=
 =?us-ascii?Q?OuRvN9oEWhLdPXZfuH5+bLbrj/7V38cyCSggBYG4MTcWLdoJ5MKzmzyXrspl?=
 =?us-ascii?Q?yZTU3SV2DcGxm7tHzROGIC+t52mk2Q9GL65tqJGh94Bkk8EmbFFm+c24kYtf?=
 =?us-ascii?Q?kyq866kb72YS+X2ix4HCkhLcr/TE2hJ5B+4Nd0lhcy/a7yMiE9AvR5zmKji1?=
 =?us-ascii?Q?OL40IKIUgl0LD8iKO4Rgb6drglNGdns3IOcGyEhGDUCG3K1sfuEXiR5uDzLe?=
 =?us-ascii?Q?Av651im1cp6u/+ss5Qr03uNBP4v4zM8nu0hD0WGF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 683ac26a-7e57-484d-1fec-08dbcc0251dd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:37:34.1300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yn8KZjDjSGh5HJcbObfZdUXApQcETq3Diu5b2suc249p2E6f33AFw35CgGZpeuA7s/kqJGvEhMiRWbR51T+haw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4581
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-12 at 17:26:36 +0200, Vincent Guittot wrote:
> On Wed, 11 Oct 2023 at 12:17, Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > On 2023-10-10 at 09:49:54 -0400, Mathieu Desnoyers wrote:
> > > On 2023-10-09 01:14, Chen Yu wrote:
> > > > On 2023-09-30 at 07:45:38 -0400, Mathieu Desnoyers wrote:
> > > > > On 9/30/23 03:11, Chen Yu wrote:
> > > > > > Hi Mathieu,
> > > > > >
> > > > > > On 2023-09-29 at 14:33:50 -0400, Mathieu Desnoyers wrote:
> > > > > > > Introduce the WAKEUP_BIAS_PREV_IDLE scheduler feature. It biases
> > > > > > > select_task_rq towards the previous CPU if it was almost idle
> > > > > > > (avg_load <= 0.1%).
> > > > > >
> > > > > > Yes, this is a promising direction IMO. One question is that,
> > > > > > can cfs_rq->avg.load_avg be used for percentage comparison?
> > > > > > If I understand correctly, load_avg reflects that more than
> > > > > > 1 tasks could have been running this runqueue, and the
> > > > > > load_avg is the direct proportion to the load_weight of that
> > > > > > cfs_rq. Besides, LOAD_AVG_MAX seems to not be the max value
> > > > > > that load_avg can reach, it is the sum of
> > > > > > 1024 * (y + y^1 + y^2 ... )
> > > > > >
> > > > > > For example,
> > > > > > taskset -c 1 nice -n -20 stress -c 1
> > > > > > cat /sys/kernel/debug/sched/debug | grep 'cfs_rq\[1\]' -A 12 | grep "\.load_avg"
> > > > > >     .load_avg                      : 88763
> > > > > >     .load_avg                      : 1024
> > > > > >
> > > > > > 88763 is higher than LOAD_AVG_MAX=47742
> > > > >
> > > > > I would have expected the load_avg to be limited to LOAD_AVG_MAX somehow,
> > > > > but it appears that it does not happen in practice.
> > > > >
> > > > > That being said, if the cutoff is really at 0.1% or 0.2% of the real max,
> > > > > does it really matter ?
> > > > >
> > > > > > Maybe the util_avg can be used for precentage comparison I suppose?
> > > > > [...]
> > > > > > Or
> > > > > > return cpu_util_without(cpu_rq(cpu), p) * 1000 <= capacity_orig_of(cpu) ?
> > > > >
> > > > > Unfortunately using util_avg does not seem to work based on my testing.
> > > > > Even at utilization thresholds at 0.1%, 1% and 10%.
> > > > >
> > > > > Based on comments in fair.c:
> > > > >
> > > > >   * CPU utilization is the sum of running time of runnable tasks plus the
> > > > >   * recent utilization of currently non-runnable tasks on that CPU.
> > > > >
> > > > > I think we don't want to include currently non-runnable tasks in the
> > > > > statistics we use, because we are trying to figure out if the cpu is a
> > > > > idle-enough target based on the tasks which are currently running, for the
> > > > > purpose of runqueue selection when waking up a task which is considered at
> > > > > that point in time a non-runnable task on that cpu, and which is about to
> > > > > become runnable again.
> > > > >
> > > >
> > > > Although LOAD_AVG_MAX is not the max possible load_avg, we still want to find
> > > > a proper threshold to decide if the CPU is almost idle. The LOAD_AVG_MAX
> > > > based threshold is modified a little bit:
> > > >
> > > > The theory is, if there is only 1 task on the CPU, and that task has a nice
> > > > of 0, the task runs 50 us every 1000 us, then this CPU is regarded as almost
> > > > idle.
> > > >
> > > > The load_sum of the task is:
> > > > 50 * (1 + y + y^2 + ... + y^n)
> > > > The corresponding avg_load of the task is approximately
> > > > NICE_0_WEIGHT * load_sum / LOAD_AVG_MAX = 50.
> > > > So:
> > > >
> > > > /* which is close to LOAD_AVG_MAX/1000 = 47 */
> > > > #define ALMOST_IDLE_CPU_LOAD   50
> > >
> > > Sorry to be slow at understanding this concept, but this whole "load" value
> > > is still somewhat magic to me.
> > >
> > > Should it vary based on CONFIG_HZ_{100,250,300,1000}, or is it independent ?
> > > Where is it documented that the load is a value in "us" out of a window of
> > > 1000 us ?
> > >
> >
> > My understanding is that, the load_sum of a single task is a value in "us" out
> > of a window of 1000 us, while the load_avg of the task will multiply the weight
> 
> I'm not sure we can say this. We use a 1024us sampling rate for
> calculating weighted average but load_sum is in the range [0:47742]
> so what does it mean 47742us out of a window of 1000us ?
> 
> Beside this we have util_avg in the range [0:cpu capacity] which gives
> you the average running time of the cpu
>

Sorry I did not describe it accurately. Yes, it should be 1024us instead of 1000us.
And the load_sum is the decayed accumulated duration. util_avg was once used
previously and Mathieu found that it did not work. But in the latest version
it works again, I'll have a test on that version.

thanks,
Chenyu
