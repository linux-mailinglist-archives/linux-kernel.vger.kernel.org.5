Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C217BC45B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 05:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbjJGDXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 23:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjJGDXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 23:23:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8128BE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 20:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696649010; x=1728185010;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F1W8mCqGW323T8Eo4wRqNx07IhCHH4ZQ08bQ/3LF89w=;
  b=h+jjPUtnoyIkD2J79uALDtV99V28ok64ILV+kdPYZ4HMfcqxLqjDEIUI
   oIiIUnk+WFoi2TB4Y5D5m5YWhE0sVcr3+5JNT+3/2g5N2NjeQEhrVlEoX
   prdQmwCbNbmqfqmhI7DibP2rsB3eOXP90iuG87QWZXGG4OhuhW/R+94yd
   WN1H8wV4n4I5ZAMmvHe3pI45/gpkWobUQJUIFTYPQRrOnRPu7Xq13b6ZY
   /5ne0z6eVk6LP8nI6ewTGvh0jcr5ws9SkUZet+wWqpvlwYJMJHkiihhXw
   DVk0wz8mWDTAR6/CNBX9jn2ziwUYHPAt22idJAzW1vpAn395BPm+e/fdG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="374219192"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="374219192"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 20:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="1083697533"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="1083697533"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2023 20:23:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 20:23:29 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 20:23:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 6 Oct 2023 20:23:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 6 Oct 2023 20:23:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3AnpQayT+v23h8Xikb/uYkztV9FGCPdbewO33cE6nD2C3bJitA2PAaRRleUCcdqluGZzMixG/Ni4bZvZs8G4zOvpzRtxToaVg0CqB4YpsZU1SlSR4L3SlGw35RXDrK2y81wd+EOULJqZfOWgeczOzdqhzAfyX4fb31+GfAjGb+JIXeAWbAat7B+5VfwKxmgBWDOqrqS9p9dZeXZ9O5i9CKQ+YUfqIk+FRHPg6F8MDxOd2owlKTOk/GTXpRbx9vn95GSgUqzFzPzT+r2A5xki5OVxYcXq2olqKY0Y06tdyT5VxJ0I3AE04JTTO4Ol4NAGO3RESIHyFHCX3qhz740Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=721FmB/mGTZE+diDcglGK4TXWSTK+aAxqnJF6PDzYeQ=;
 b=dcrZ06Exxg9u5Iq/ucgiYsAwp7X5So6JU67RG8I4yTBUlxZCYOC3QAVi0JbME4n3e/XrjjT2jWmWqbdetdKIyfTn/DRzinHdaJWAzWuF3s0qi1J/1wbupy6qvb2ApyvVeD3F4ysR7RoxUEZinozVPof33UOAOPl1IV7QApadLuwx5fOgjo5lq+WBvxNKxE3yaVEjhcgufWGCdl9AC7pULQBDFGTBmqGFJW2yk97hK7FuA0rY7IdpqYDJLQ7YcSAPxYvO8b6wOqcWAE52b1ONA29nhYmEHCfip6KskzrMCav9XxErWz6U+EQmtPpRzYuVauAEAX7EJSYnElestkktuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH7PR11MB7963.namprd11.prod.outlook.com (2603:10b6:510:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sat, 7 Oct
 2023 03:23:26 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%5]) with mapi id 15.20.6838.033; Sat, 7 Oct 2023
 03:23:25 +0000
Date:   Sat, 7 Oct 2023 11:23:06 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        <linux-kernel@vger.kernel.org>, Chen Yu <yu.chen.surf@gmail.com>
Subject: Re: [PATCH 0/2] Introduce SIS_CACHE to choose previous CPU during
 task wakeup
Message-ID: <ZSDPGjO+hkD0AjJ/@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1695704179.git.yu.c.chen@intel.com>
 <27651e14-f441-c1e2-9b5b-b958d6aadc79@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <27651e14-f441-c1e2-9b5b-b958d6aadc79@amd.com>
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH7PR11MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c6b54b-58f2-4a0d-23aa-08dbc6e4c414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +KnTbyiG+jAju4vYBBnJDeSchntxNjzd9zhVJST7M6zKKcw6Yfxu2EgewApDyT6SLChGceDaTJDG8V7GPLwmX8vnl93u9mrD1eymUGk13JeIuP1N74X+im3OWeqld4Pd67zquqEoiLfEz944JTDKC2pD0aGT4phk8/VFiY6ILTCF5LRXIge9duep0Q7odJjtHA7dT812zXcebSXssltGhPeHn3s1Ss3tZaPXvp5TD5wsiOfGqY56ny+sXgj62jI43cJfgNNQ+CFv6hzBCKN7rAB6AbeaJF9tKjAsZ6xQNf9zA4AX3REXQfx316su8ekhu8SpIQfhPWC/32T+UHXZ3f6gIut63+5RlKF22FoZMBdXarzQV0GpfuQz8sjUuAkpHGuuBkPfqdEg2DpomGilIRa9ZzNqbgNeNgNNeXkatGmutLFhEbfbwqK7v1MfnuKem9vUS75vVlmOX3k1JLQu1vU9e1+nbQ60iv1lxmrF3ey2MePVfCnPwmv7VIwi4uMnxfPevOJjOWPTBMkjH6/TA5uH/N99kj+vjKsjIOTsA12L+wUTcytiH2ZZ+H5jnrI9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(346002)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(66946007)(66556008)(66476007)(316002)(54906003)(6916009)(7416002)(6512007)(26005)(53546011)(2906002)(41300700001)(4326008)(6486002)(6506007)(6666004)(5660300002)(8676002)(8936002)(478600001)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/LQyGmyzk7NAk3d6tk/n+On0U2yBsIbwkWRR+8F27AIyGjZjzbrgt6yCmVh7?=
 =?us-ascii?Q?NUkCzZcm/5GGiaBIwnBeZFJta1lYA5tr4yMC8zwyLNUazBNnvnEKbqyiKOqQ?=
 =?us-ascii?Q?gpzSRzAwGdKnpL00BIV3hEuzMrrbEr4qy5KONqia55fxDrfUOmJG9SyPLCLB?=
 =?us-ascii?Q?46d26YsA0VV1L49qbf1+AtjiqEf0emb2QlTTRMWoQKWw05BXQJkBcJzaS195?=
 =?us-ascii?Q?sR4uRRYNY4AOs1KHR/OnAkLuCHryhWE2yhKO7KtEm56OjUWQ2K0pFCUiE71R?=
 =?us-ascii?Q?VVbEBtb/CGXsPEy9wqafDuC9fyJTT/z915CLn85xSjBrwbP5F8sdhBn1xq3q?=
 =?us-ascii?Q?GYtZlTSVkzfn3vQLnfU2VVBdGm2IEEfRMN7nB5HfkZIQxtDfjY7BzrjDqefl?=
 =?us-ascii?Q?qEJCDmOjyV63zS3Dn7iHreyFGUKO662Nk4GarhzkNt2sydt2ePKqvDlL+6Iz?=
 =?us-ascii?Q?G5EGchHB5tmeyy0lk55qJFCm85w+3jYGoUtMUYC5vc3jUX8AqZRfcidmBPcE?=
 =?us-ascii?Q?lp2pq9I4t+fgLTGnuS8UN/OZaZ9CSXY060p6pPRn01ruVF19dupMUobn0D1u?=
 =?us-ascii?Q?9yChw+V391bVn5c9u2KymM3ol3Jro3MCYRKLyJ3fRsUDISDn0UCLi3aMTpuv?=
 =?us-ascii?Q?JyoL1pesol7mQf1w9mYLIPPx0FTWgl967OHprgqEuzE7sBp0+4zoXJ+tpGWw?=
 =?us-ascii?Q?Jdg80lci8/L+Zj1rYC/T/o9JqUVyl2SoDX5WbCfopJ0LVoRL7Uzp8J3kdr9W?=
 =?us-ascii?Q?jRA6rDwPMDF/riSIFxzFzvbVqbGITwqHdxGVe6U/TwlP/QqT8i9Gr6197w39?=
 =?us-ascii?Q?1JL0QXp0G9eLWMpDOGxkw5KrJ+tj5QRLQSrrXmclG/TZs2CCKFN6Uicslfrr?=
 =?us-ascii?Q?LZJdRNI/KFdP81jJJmJ3j6K+cnNCZ23IEzQwKMhB9tGy0d07L9jYgm4RCYE9?=
 =?us-ascii?Q?Plm1K/y2RXSiANzEjNZfh4p/U8S6oxKLBt0N9Ri6NAH/2VWIR66ODotcfSP1?=
 =?us-ascii?Q?XO/DNh03+8bnph8XEggGIUtMRcyPOnLSIOvEHyU0v4DFr/dTvWMIoM8ZR13b?=
 =?us-ascii?Q?AlQZcXP8FnWM36EP0FksIymArFFYJV/18lWrHX3kWYPze86uImyJh9sqJOn5?=
 =?us-ascii?Q?9PrrBYpS4V7K97/dDXW3TY7O7mYMsdvRvpTVhYnx0finMC+aXR8QVG2WWAqx?=
 =?us-ascii?Q?Sz55HT6QlTsmbI14XqMMPRS0yxym294m53RDScrWsIEIvXpSQ/Lbs95bYwPL?=
 =?us-ascii?Q?/eOda/wN00XI/it6s6VTmjyeUwOzn7sFHjDrzNXaX6k45vQVPl2t7oXq9398?=
 =?us-ascii?Q?fR5BHkAP8xv7fWQJWPknxCbO4uThT3RKi+Q9+lLXbvi3qAjr5z8csCVOxURR?=
 =?us-ascii?Q?rsFbgYBfFMST3+44f+HJVzz2k1hB9xDmCypQJ1izrETOhxasR1hHBUxjogrj?=
 =?us-ascii?Q?Qgrne6aiVDAOyet1D3ov4p4Fb0HIXc35Dk2eIaHuMH6l1lN+vYQZA9oyHAxr?=
 =?us-ascii?Q?Arv4td5YAr7AK3ZaJPKfaKVtH849M/XHkrHZHR7K3Do/Q7kWMsriZf6AGFgp?=
 =?us-ascii?Q?2GlQIAveG4/eHvB/juwr2gQBBe4pjKfFv26MhPNe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c6b54b-58f2-4a0d-23aa-08dbc6e4c414
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 03:23:25.3014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVEDMHf08Oco/a216T4nuLJ2A4TyY5YcklJGFtd4ehe/2+dMuk39XR2VAIBJISQ2v+nJN79st/xUXaYc6ksi6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7963
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prateek,

On 2023-10-05 at 11:52:13 +0530, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> On 9/26/2023 10:40 AM, Chen Yu wrote:
> > RFC -> v1:
> > - drop RFC
> > - Only record the short sleeping time for each task, to better honor the
> >   burst sleeping tasks. (Mathieu Desnoyers)
> > - Keep the forward movement monotonic for runqueue's cache-hot timeout value.
> >   (Mathieu Desnoyers, Aaron Lu)
> > - Introduce a new helper function cache_hot_cpu() that considers
> >   rq->cache_hot_timeout. (Aaron Lu)
> > - Add analysis of why inhibiting task migration could bring better throughput
> >   for some benchmarks. (Gautham R. Shenoy)
> > - Choose the first cache-hot CPU, if all idle CPUs are cache-hot in
> >   select_idle_cpu(). To avoid possible task stacking on the waker's CPU.
> >   (K Prateek Nayak)
> > 
> > Thanks for your comments and review!
> 
> Sorry for the delay! I'll leave the test results from a 3rd Generation
> EPYC system below.
> 
> tl;dr
> 
> - Small regression in tbench and netperf possible due to more searching
>   for an idle CPU.
> 
> - Small regression in schbench (old) at 256 workers albeit with large
>   run to run variance.
> 
> - Other benchmarks are more or less same.
> 
> Test          : schbench
> Units         : Normalized 99th percentile latency in us
> Interpretation: Lower is better
> Statistic     : Median
> ==================================================================
> #workers:  tip[pct imp](CV)     SIS_CACHE[pct imp](CV)
>   1     1.00 [ -0.00]( 3.95)     0.97 [  2.56](10.42)
>   2     1.00 [ -0.00]( 5.89)     0.83 [ 16.67](22.56)
>   4     1.00 [ -0.00](14.28)     1.00 [ -0.00](14.75)
>   8     1.00 [ -0.00]( 4.90)     0.84 [ 15.69]( 6.01)
>  16     1.00 [ -0.00]( 4.15)     1.00 [ -0.00]( 4.41)
>  32     1.00 [ -0.00]( 5.10)     1.01 [ -1.10]( 3.44)
>  64     1.00 [ -0.00]( 2.69)     1.04 [ -3.72]( 2.57)
> 128     1.00 [ -0.00]( 2.63)     0.94 [  6.29]( 2.55)
> 256     1.00 [ -0.00](26.75)     1.51 [-50.57](11.40)

Thanks for the testing. So the latency regression from schbench is
quite obvious, and as you mentioned, it is possible due to longer
scan time during select_idle_cpu(). I'll run the same test with split
LLC to see if I can reproduce the issue or not.
I'm also working with Mathieu on another direction to choose previous CPU
over current CPU when the system is overloaded, and that should be
more moderate and I'll post the test result later.

thanks,
Chenyu
