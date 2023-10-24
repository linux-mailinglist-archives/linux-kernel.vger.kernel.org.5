Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6185C7D4734
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 08:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjJXGK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 02:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjJXGK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 02:10:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76CA139
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 23:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698127852; x=1729663852;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zloxMkV9BoUB/csQPio/P2wp2+Iveme2uyijxrZfG0I=;
  b=n0LCRAy7uUJpykRF8PBB2gIaXojLWtI6LXNneByhEjM5l77nkz5YBTNZ
   FxHpSkq+qap4Ku/jVnNy80uzBPl+lHvsJ9MnmjA30d9PanQyMncr2Lf/v
   t+vEx2M9uUQTQ+7MiluJKqcVDQH7sgq36BKjQIjyZkCUdWNR2AG9xF6zo
   YaLWF/ppu5dPIIm1aQ8oXEObpRpCn0cBfZbwia02iS9TGkH8g2OJO9MYn
   /7Emh3LWd8d3Q4xSRB19HxNAo5yOh5/n21VRgeHCvVG2I9oMRPqW1uZdh
   khzGU0d6MHzxYJhC9aTxuvLN67WY75Y51jaWMRBulxnKybqEodPHRQAjb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="367222098"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="367222098"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 23:10:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="793383567"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="793383567"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 23:10:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 23:10:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 23:10:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 23:10:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 23:10:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEqVd5tLLqvDpaMp/O1FQ0vyKIdhk+jbd7bk0VqYU1Lx4Tq/M/dkf7avCLIRY+6lD2B6KhHeqdJHdDWhn7NfpMml6Ol5hnhrW2EdI8xMrHAW+NMuy6PJuOswH52VLzZX2HuzQuJkGFwy0USuZPjwGKU41SnLfl+ATfX/Kr0bgTQIiG1B5wqXH8IjbrivXre8M23Ut/EXy6ssPRwscZrbLQ0xVLuld8wO+/hPq4fsCtJ/ZmPxhXoAC9hg4Lx4l5/ZXWYg5rVsIi4oAyvEXW2Z89zFr9hHJ5/QtIjTmrF114V4r4uxg89Rm9lEFHHrAUQ+qOzSM1LwVvTpytV8zMbbqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p77/GY1JUFQ3AXYLthHc6IGHSm8NRE2aOtpISuolIec=;
 b=Maqm7dUr+1LDStHZvQ9rvABye5a0uWn/BankH5guktM7YVYFUcMss+cXc0p7VHzuL1aP5SrvSiBCgLizhf/R2PdWjBhPkgHxUY7oXWxqWjEppsIDW9h52DsFz2wmGy3posm4JmT8Ti2y51iTNbvKEYiQuyFXGIZevydHR5+iYFLTX/qiaDg2N5CEBiY9dQFHkQEJ8mDPdtVB+uz/zkvowGgHTFCYtXTXhofHm/VGbqobU9xy9UzvqzfhxIr63G6iqtkcxID/E/Dvwi7mxIIRrBZvH3s0DfU6grL5yDX3HX8aUIgc143NP1rUkkKaVYH/3OjEOkBBjZ9aaYMm8Zwxew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB5184.namprd11.prod.outlook.com (2603:10b6:a03:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 06:10:44 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%5]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 06:10:43 +0000
Date:   Tue, 24 Oct 2023 14:10:27 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, <x86@kernel.org>
Subject: Re: [RFC PATCH v2 1/2] sched/fair: Introduce UTIL_FITS_CAPACITY
 feature (v2)
Message-ID: <ZTdf0529DL51pj8m@chenyu5-mobl2.ccr.corp.intel.com>
References: <20231019160523.1582101-1-mathieu.desnoyers@efficios.com>
 <20231019160523.1582101-2-mathieu.desnoyers@efficios.com>
 <f40522de-b71d-4848-8aa3-5b87d38bb847@arm.com>
 <c79ac631-61c7-4953-a657-74047a264029@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c79ac631-61c7-4953-a657-74047a264029@efficios.com>
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ0PR11MB5184:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cfd2ed6-dc45-4df2-2d0d-08dbd457f4a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rGHbx+BmQ2ZRSh5fwNDEEKSVnFpbELzwWPfzSCLAiZCT1X7bd0ca9G96GrAJycdFbLRQexAiqDJvHee2x9dRg26WqEzWcHSt9esuHoB5DIGi2nYV2RFAaBWAzVCOs7q6PlwUsChU6/5A/lXLcF59NLdEgM6EQtDj6TwTpsRSHA+UxG3lSec5nkLY4Qcc7e9XkAVsnmbUQMHFZTA1Z587vK6WU2qcMZD9QfFErSUHvsZ9BrpCUOyCCgPHPg3b17DUkvGda0CLMtoYUqK55eG+pXHChb7iI4hNLsTk0ykdg4rTp5OpcZ//+9SE/y7hazLobyWajWo0qZpCIPFeq7qxgeLd8DiwtkoXSw3hLrWGUfQHA2BM7k0alMAWDgWZptNqSkj2uIQMc4BWET5X94L1hj8pr8dE/XlN+2417aEw873LY2viBkyjrbITFJM/aFL6OpH+NV3pBv/B+M277vtuyaoDTwN9uMViKeiLSyQDYxNFRzsBAKq6TKT7fL1MM58khrtXC9OPv0adq6xyJ0C1WZW53M7j860eyi3BYfvBElclDyVH7by9M4joH8RnaKjI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(83380400001)(26005)(6666004)(6512007)(53546011)(38100700002)(86362001)(6506007)(82960400001)(6486002)(4326008)(8936002)(8676002)(478600001)(5660300002)(41300700001)(7416002)(2906002)(4001150100001)(66476007)(54906003)(316002)(66556008)(6916009)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k6Rv3eUAKV28ht6sK0ZzbED4EnMDD9L4btZQa9wEB9HKsE9wM7xLcSNHnoCF?=
 =?us-ascii?Q?vXgufHb7m5dmCxqMAhYg+FGI8V+Jcc1AsV3xKMAkLyVMtecjcxghgQD6SHB3?=
 =?us-ascii?Q?q8n1LvV8f8IKPY9PvlpJ5Bf+6iuV5ztq6zoWK0dMi98t1Dd9pHnDlkFfpr9o?=
 =?us-ascii?Q?cLceOf2GEh87wYtu7SkTRHXtXw4n/sjhPTQWS67RdXdTR6jzkFioQT2RmM5Y?=
 =?us-ascii?Q?0bphpHdKjshY2Ure65JXeQSA17w6bAlb6TWWFCqXozDxNoLNKGftoSInJD7v?=
 =?us-ascii?Q?4TUpLnDFtrO6UhvOrZCLn0GZR5aNA+14yZxxBRjfxafQzi3vuGNPLSoTOHSs?=
 =?us-ascii?Q?hDAJVlzcU9OROuzu33pGqbsUX7REtHgAIp5U/unYvBZJtNCaocMRpfX3C+DM?=
 =?us-ascii?Q?zHgzMT85VMiUfuW50tPOuOeOoF0v6JHSm1ocl/oLICPG93PoB/C8JS+KMYbQ?=
 =?us-ascii?Q?kMI/PlLrWaOic2I8Vj2QR/DyqTGC4V1iFsEpeyyqLLxQq2icBWQ30cFDJDgH?=
 =?us-ascii?Q?Io/DXqmVe461vDXAbwfheGDgWZJjD78mmtPsO0UUyLiiKUphoz5z2hEWfzKn?=
 =?us-ascii?Q?8F2T58sTliMq47hlx4ZqQT93EKRscsI67jS3zBZ7GGZWvldy2ta079oiGUXF?=
 =?us-ascii?Q?5ir726LiiZu/yfGbKLDcqz/pWH2RMx3hrjQBkxUXwafEpI+ICpjHxlQS0g5A?=
 =?us-ascii?Q?H+9YZdvUABOfYZjA1NZesL8giyNwGs1Lqsj6AYARaimR/bng89SzmfAaUbKg?=
 =?us-ascii?Q?w5tDahS/D0UXRRvd19LbeWQp8q2rNTmtGudlkR3lPEP6yzs2HUuOJT2n4TIU?=
 =?us-ascii?Q?/u3xOIDHzcrJ4nNIk+dZ1h92vmbtx0v/cvpxOeeJK+Ud26EbHX+xpBLPOHWo?=
 =?us-ascii?Q?EUt7PoA0EAH+Qg0o14/l5XuA09aOf7t9yAmfpUrFCp+z29TEjXratTbQktFX?=
 =?us-ascii?Q?A8lc9uoVRTILX8BRwZELmQ26cPrQTg5LOsGnTs7KFOd/iHZkqVgjEGPmg39y?=
 =?us-ascii?Q?HMlPb6mIbyh+pbAPFX+La51iAcBt6waR+Fa9x//6Juse0jQgxNhAJwwlgiVG?=
 =?us-ascii?Q?/se3DsjMmCWrc3FzWmlNTLgwjGXTuAgtXYZ3ONoRITR8v008u6DCiobPdTmy?=
 =?us-ascii?Q?suEMhlXXISqkRyBY7NzP4O3SNb38Ye+gJTmAjofDpquSfvaf52U+wCpOZveq?=
 =?us-ascii?Q?6++LMQirBqDIFOhPX1suVXHis0WJypdVcBz+o9mtzDdpqBS/4xWjfKIanSHO?=
 =?us-ascii?Q?QP/ruegdlq4NPWZe09IRSE8VD+WXM5V+/sgtOoT62HLSuSm8ZmsDyWAGSjIN?=
 =?us-ascii?Q?Hpt/tabaPZlgo0LTf+wFdhZ0AVkwE7Y91NrprEI1Lb4IKOXyeqDf3mCZ/BB7?=
 =?us-ascii?Q?rmvJ8JLhOHPrAftAX7jhABj3+auEvyZCAkFSefsuOxovS/NZidJUDHvrb4p8?=
 =?us-ascii?Q?VAgAJnGlQzZ1Nx6+puM2LlFUqLd4mSASYCPoJOlshf1dPqDzJD0hbS2txhce?=
 =?us-ascii?Q?CBJHoMK6zVla/G9RMVpSlTeaiIRBw9IRHPv0VSQRS0fSWj4KL8Nu0VKxEAE6?=
 =?us-ascii?Q?DPsvlCWjUFmfkjMOzEn081MqVoMo8ErVP+aMAIfD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfd2ed6-dc45-4df2-2d0d-08dbd457f4a9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 06:10:43.6825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9myWTHLGJ8sNGW4zZv+BwKA+oN5CZtJX/bXr7PvgyE5ZiXp3ABKLiyPXMbXViANLYp/WnkwwDeWh6iRXAdNW4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5184
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

On 2023-10-23 at 11:04:49 -0400, Mathieu Desnoyers wrote:
> On 2023-10-23 10:11, Dietmar Eggemann wrote:
> > On 19/10/2023 18:05, Mathieu Desnoyers wrote:
> 
> [...]
> > > +static unsigned long scale_rt_capacity(int cpu);
> > > +
> > > +/*
> > > + * Returns true if adding the task utilization to the estimated
> > > + * utilization of the runnable tasks on @cpu does not exceed the
> > > + * capacity of @cpu.
> > > + *
> > > + * This considers only the utilization of _runnable_ tasks on the @cpu
> > > + * runqueue, excluding blocked and sleeping tasks. This is achieved by
> > > + * using the runqueue util_est.enqueued.
> > > + */
> > > +static inline bool task_fits_remaining_cpu_capacity(unsigned long task_util,
> > > +						    int cpu)
> > 
> > Or like find_energy_efficient_cpu() (feec(), used in
> > Energy-Aware-Scheduling (EAS)) which uses cpu_util(cpu, p, cpu, 0) to get:
> > 
> >    max(util_avg(CPU + p), util_est(CPU + p))
> 
> I've tried using cpu_util(), but unfortunately anything that considers
> blocked/sleeping tasks in its utilization total does not work for my
> use-case.
> 
> From cpu_util():
> 
>  * CPU utilization is the sum of running time of runnable tasks plus the
>  * recent utilization of currently non-runnable tasks on that CPU.
>

I thought cpu_util() indicates the utilization decay sum of task that was once
"running" on this CPU, but will not sum up the "util/load" of the blocked/sleeping
task?

accumulate_sum()
    /* only the running task's util will be sum up */
    if (running)
       sa->util_sum += contrib << SCHED_CAPACITY_SHIFT;

WRITE_ONCE(sa->util_avg, sa->util_sum / divider);

thanks,
Chenyu
