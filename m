Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A357648E0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjG0Him (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjG0Hi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:38:27 -0400
Received: from mgamail.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE12C4231
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690442881; x=1721978881;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8RRRzQ6u8fy4v2lnMKrfxZ9XbIMjEttM6zeoI5lPhOY=;
  b=jZbPtcysjE5tt3xPw9BkaVeiwInPclpu8pZxqgruoBCa3R49y2FoU95i
   6IdplRaRaWRXiHpxr478ZKqBQY96AugNagAh06XxEQGb34cej1KJei1E6
   LehEpPHYB2HxTVSQtF6yII2gBZG2OclBbWm42PUx7KBLtQekIUp3KiVZm
   BKLvMbvCnl1JedyE9Gt9oQrk66hl6lSyWx/00vZnEJckoTQJJSuflhp3D
   zihB8mKyTJ7i+kZ47iXIpUqG8yQd3/FmzROC87PS2JvZASyrST09J6UI+
   JgQiN15GSoF2KxGw3sWgfJgOzMUo9VV5IrgEANJmk96ueCApFDQRCRp+N
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="367107444"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="367107444"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 00:25:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="870229151"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jul 2023 00:25:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 00:25:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 00:25:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 00:25:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aq8oPSPp1arsNNQ/xqt8TGEegnK0LAEyfY3qpSuegF1jc818Pv7zJTOzhPSpDBJIrOKX+KMKgBTWX7KUxtX5V8+qaPY104bIGT1mULLO/slBAyzUu4AZWf6hhkZ+WssXLx01NvJr3ECso203iXqWDcNvWvGpN6+RNJh9VLc7fAPOmWvfnpY8VsFJ0qWSFSQXNsb0oYxBmEOh9jMNXBfEdb/HjWW/HM9uQGCSO7OiVSo92q7aeBvmAYYEGQuEcez3cu9D3rtAGF8PuRfft+ixmmRHRuS7wMDesN5XEeTrD0WnEI8/C/fQvRmfj7L9Ime+Iri2I9V+E0seDzNO2owryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DchdcEGE87kGWYeupPdM15DGfqan/y/1BPWvc1QjAA=;
 b=IpcjXG40y49oF0GerNLqHvBxWnU/LD6aoZs298aD+ALAJgudi3zqWbKRORsQsN80XcS/M59u2Tloqy8TSppLYUsrSTPF8+SNrWi5V/OkpG8Dtity+bmQMp9sLnVMLn0xfjycKokpKjFfG65UM8sSBsw5vXKLa9EZdLX4evJBCY8OA4preOkqFSezHAFHvXuQxYqJWiNyu+yfx8kYDlkXALjALn2pCG1M0G9ayUEjLM33B2ACjX9y0sntg/Q4gRCc3WU5qPvulC3RdfnMXh06pLJ9hFvnDcfuYGLCIYgcDko9Wqgol6tGXGc/FPvAN1synoenAC7S22i7sv+qs/UtYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by MW4PR11MB7101.namprd11.prod.outlook.com (2603:10b6:303:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:25:47 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:25:47 +0000
Date:   Thu, 27 Jul 2023 15:25:29 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
CC:     <peterz@infradead.org>, <vincent.guittot@linaro.org>,
        <srikar@linux.vnet.ibm.com>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <dietmar.eggemann@arm.com>, <mgorman@suse.de>,
        <rui.zhang@intel.com>, <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH] sched/fair: Skip idle CPU search on busy system
Message-ID: <ZMIb6TYMrtzLHSBb@chenyu5-mobl2>
References: <20230726093612.1882644-1-sshegde@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230726093612.1882644-1-sshegde@linux.vnet.ibm.com>
X-ClientProxiedBy: SG2PR06CA0194.apcprd06.prod.outlook.com (2603:1096:4:1::26)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|MW4PR11MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: 124ee34f-a856-4990-83c1-08db8e72b1f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p0uPVjl2qNRW4uMwvxlixxsnNFiKnjK6F73OxDOEVY7urZJ5Ryq1cdVVqaR5AK4y2j3luoZK20z9wPJIF7ekHnWu/mhhZQvdWFyEomW2D5vl91V7LVkI/P3XTyuYvJ+XC+IakGI73lpZWiPeAuQn3JzmS3LBSyv0Ifq3DaITiJNWu21MEQPHg3/c708AJgoz05M8s/L7nsomzg+Zr2F+w5y4GBDiBcVRXHSrKxDiIquHZWQZqnpUQ8hNTjwLwe9sJuOdhY+mDb0ERFA9wdmsCzmk386Ytk1QV7BkAPbUwXqe6VubhwEvOvnxFJ0HXS9qLPzlf8gEtSLYCGyNEvdF825HnVSukiS78BP8mVbwp84NDNDVXDJft2uWIiMU9tFxEBp3clCOWHtWeMqLXRarkXycfKImdBkw9JQTvttncpdaG/vwrCVV1Hw5g9qjxhIbbuR7ZJkebbG4kEXKcEk+R6nfCPBoTtWXRL4PXuj+AaNCweX/b2ZS//h/MUPYDyN3fXapGZHsjMh0NEzgXrdjFcV8axQYFarXMkf9bsfxcRE6GnJ0GcV3PHcQ1iUCTodM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199021)(26005)(6506007)(478600001)(82960400001)(107886003)(53546011)(186003)(6666004)(6486002)(66476007)(4326008)(6916009)(6512007)(9686003)(83380400001)(66556008)(38100700002)(66946007)(5660300002)(41300700001)(33716001)(316002)(2906002)(8936002)(8676002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GOp9fZBj3jU259eEw5+WNzMgW1gn4MKx5YoIVHa5JVfxzHa15PIEvMyhDR73?=
 =?us-ascii?Q?kegFrfn9Hw3IlGkvgAxLtIuw0ONvMzgXf9l9BMQc1laUTEq8MEEeLQsjyPaf?=
 =?us-ascii?Q?UsfzNQh9MqxIBHTJzLZwKJzjah9fUWfgTWC6iWSpIZrMlWq79MfWbUf1b5/+?=
 =?us-ascii?Q?70/kA6lLgRsJ3xdz3YnzNU0qAWdJWUDRS/qQIjsEONrr+cIVNJf4CmQRj5xf?=
 =?us-ascii?Q?SeTYqocesAFkn7t4ZJpYB8FjT2TzX7Wgj/RTSVQbmkhyFvuMhVyxP88Zliii?=
 =?us-ascii?Q?dm0FUUT4ZRGYLUaKnf1uUm6en/+rGrFOrHE2yWYL6lCTuOkq1tVYme5XEYlB?=
 =?us-ascii?Q?ISvhw9qTONvv9XOhGM1GHjibC0U0WFCVOYO21sepJsPzRbYjpXCLQrXp5LCL?=
 =?us-ascii?Q?pyD3BmTOQaRgFbn0k26Lbo1toCX3c4yV64na6uLhacVuRMbr0iqAUIvlwB56?=
 =?us-ascii?Q?ohyRCvzKEk/DNmWAvCz34p5nnHHuH6wKRv3+DUMtF0f3zCB8rFzTaaxi6Gb5?=
 =?us-ascii?Q?Mv1sTJVsL+ETWOLyvdRma+Tq2lPFL1GXNYkTmoXtgMPyZnJ7tK2Ql0K/kDiL?=
 =?us-ascii?Q?fGCqb7yQqLBE6nuTEjLtXOzlBwmHLSoRO9U5xT1YhPLv0BfegNiRQ/IxFpjD?=
 =?us-ascii?Q?Vc+nRn/+K2pmF5RD+aol7yhN6cdLjf6EXyvNag+dFxLIAnL5t5KMxDvwJH3M?=
 =?us-ascii?Q?ky5ayXI5g/vJmfR3nJvT8NyIVo8rmuDVwrTpj+bjCYy6fLNgnCWeb0A3gbFc?=
 =?us-ascii?Q?hqpDBD1B0csmyeTUp6ZNeqyeSPdFDcNXakQekBPJfYPXiH6edbBdR56ma6/d?=
 =?us-ascii?Q?Hhyuj+Qegy8aOvs1hLHknvTZDUFNWDOh2x5RE7HoDQYxx54glN/h7Grtp/3/?=
 =?us-ascii?Q?t7cP67eNldczhiSjNMl/mpeALPRAeQveZHah1J4Z8mGcSswSqzoORu09FDfh?=
 =?us-ascii?Q?UVz8wKa0U4GPLCaQj6/0GoS2JR/BLhSzJEFxPlTcs8qF8LuYgB2BLj9qWYNi?=
 =?us-ascii?Q?VGcHcexejP2iNm1wR+k2YjbV9wtQqrN8qKab0OIR5LDOeXhqVzaETEo0L98Z?=
 =?us-ascii?Q?38ncumqcstNb8LEIIIDf6maU+RylDs5158HF/09f5o74eULEFpuZI3Fafu2v?=
 =?us-ascii?Q?ZFu335M6y2u4rH+57tDgHji3uhdmT3Ly20B0e+ISfkFgaQ4C3Fm7OQejpJrI?=
 =?us-ascii?Q?sQGS43+cMzaKiR75oQo79jmqKpaww0XYPl5D92HuxNbeYyvOF06MCnQmGWdR?=
 =?us-ascii?Q?AAG2ZTOzJ2EEJu+SmodeWgBRBQfuwvSp5ajbRcHR/LugE/KuGf6Vhly/GDZQ?=
 =?us-ascii?Q?Czmut7XPdK0xs8nugqnXZdPywA8TZMx3MuR/wFtCVDL3mqmETbMZ7yg5dr6w?=
 =?us-ascii?Q?7MJhZiWPHIWhEmHPzCUbhxuBaTCp3dDHxc2HZ6NlHXpwaXmMYjZHJX1lXN/b?=
 =?us-ascii?Q?Th0U9U0GdAWEq/DTa2X4TSG8788EziV/vdH9KLLDGZsDUrBDycda80Hx9hJu?=
 =?us-ascii?Q?yf+8EJxguWLUd0DwU9HzXyeTZGcMSRxExgZmOy5Pdbh+At0d1ZzD18lbq3lV?=
 =?us-ascii?Q?XNGROav7cVA2CSJyKrGrPnOf+k1ePpbYzi5H2wAT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 124ee34f-a856-4990-83c1-08db8e72b1f7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:25:46.8287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miOcI1PwST8/iVGwHLCLIF/Kr/BlajTsRjzVDnqXkO/LD1+No/jt7XPNl8ckr46UQpkJAFnGRui+ZXl94OAD2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7101
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-26 at 15:06:12 +0530, Shrikanth Hegde wrote:
> When the system is fully busy, there will not be any idle CPU's.
> In that case, load_balance will be called mainly with CPU_NOT_IDLE
> type. In should_we_balance its currently checking for an idle CPU if
> one exist. When system is 100% busy, there will not be an idle CPU and
> these idle_cpu checks can be skipped. This would avoid fetching those rq
> structures.
>

Yes, I guess this could help reducing the cost if the sched group
has many CPUs. 

> This is a minor optimization for a specific case of 100% utilization.
> 
> .....
> Coming to the current implementation. It is a very basic approach to the
> issue. It may not be the best/perfect way to this.  It works only in
> case of CONFIG_NO_HZ_COMMON. nohz.nr_cpus is a global info available which
> tracks idle CPU's. AFAIU there isn't any other. If there is such info, we
> can use that instead. nohz.nr_cpus is atomic, which might be costly too.
>
> Alternative way would be to add a new attribute to sched_domain and update
> it in cpu idle entry/exit path per CPU. Advantage is, check can be per
> env->sd instead of global. Slightly complicated, but maybe better. there
> could other advantage at wake up to limit the scan etc.
> 

When checking the code, I found that there is per domain nr_busy_cpus.
However that variable is only for LLC domain. Maybe extend the sd_share
for domains under NUMA is applicable IMO.

thanks,
Chenyu

> Your feedback would really help. Does this optimization makes sense?
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
> ---
>  kernel/sched/fair.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 373ff5f55884..903d59b5290c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10713,6 +10713,12 @@ static int should_we_balance(struct lb_env *env)
>  		return 1;
>  	}
> 
> +#ifdef CONFIG_NO_HZ_COMMON
> +	/* If the system is fully busy, its better to skip the idle checks */
> +	if (env->idle == CPU_NOT_IDLE && atomic_read(&nohz.nr_cpus) == 0)
> +		return group_balance_cpu(sg) == env->dst_cpu;
> +#endif
> +
>  	/* Try to find first idle CPU */
>  	for_each_cpu_and(cpu, group_balance_mask(sg), env->cpus) {
>  		if (!idle_cpu(cpu))
> --
> 2.31.1
> 
