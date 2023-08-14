Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A298E77AFEB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjHNDPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 23:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjHNDO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 23:14:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A05E73
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 20:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691982897; x=1723518897;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=R1X3m98LDPGIuqulDEzV8AyKx5iz1WzdA+/v284QvUg=;
  b=DE6VyMXu7qfN/c9Qswtzzu+Y4bTCUr7cD85FHOgpW+vxxL5441O98fJC
   tERjabZW2ayd148nzktc53/4s4pb9B8IpCssAoY78iO1aSLaT4g/VipTE
   GPolUy5+8OW/w015X10JCHJr1JoD9o5Wyzdh9rHAcOhgb6FITthXeTA0D
   1vvKMgEeJ7l6BvPBFljCpS69NAixro2nku3QzP8Eam96YN6MCW1VsZg2M
   bql4CLtVs5QFn9si5wckwh4E54I/XFX9hJImE9cFuZYPfbhhOte0zwEPK
   sUAvXF7C+wYJL//Y3IrCPjiwfj/wKVBU1IjsI3Nw3olD3X9iQqGpGJtN8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="370852344"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="370852344"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 20:14:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="803314209"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="803314209"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 13 Aug 2023 20:14:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 13 Aug 2023 20:14:47 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 13 Aug 2023 20:14:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 13 Aug 2023 20:14:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 13 Aug 2023 20:14:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZC1rryfN4Xhz7muYBmxYtuaD+yzz/N8F0BGz61pxiCjIt7WOJqJQAfm5Sn5xNbtEe+jGyo+om6kuMie6TyTF89W9URXb/mYpsZ8xOF9Fc0oInhkI6/Vseimo03IDh/2zmxH8OzPLyAVL4dH/4nV2jO5PdrwOUQ4BOPQgRn3VyvWUc6GxXZHB081cX35Pv6dWsCAUSGHxLUBl+zogJEQ0AERFDB5hGbbeE3DiNo6IovxZ8sjINRMTi6dCXeZmY2LyWynSMlV9h4JCesaeA/grwZ0ty35eWcsQ72TgaAEBM/cS6rKPsCJQmEsyQEb4f6RhoY9sKvK8nxpHZ/CfbRi6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LjRtnqxYT/Xtjq6//cL/ZO4DD5X2cDzEcRBKAcFinY=;
 b=Qw0ZEULa02RBmDxZo1BB3bWXhk/RPAg4Bcpco85ouf7JicyKp4kYrCk+3FDKXM9CReRY7IT52qeLeFX/4eYYGcFPTLrWHoCPNKKekGh0Qr4LszZTxy2lxLMK2a3i3OaEaO6CzglpgVXnGRTf4Wpkhg+r+lR8Is1g8AFnWrKX78WWOLkfwhQe28qgmLuAuixmfe/0H4CsN9f2eGbbG9Njr7J17Aaa4dxqH3TsodPP9f5W/1YwotYgXptYmPWVrP4lnrP1SblX/VvYSQoAnJOzf34H+KOi4Bj3jvIFw2MV9y8RMJ+ujB/pT414V6KVshgo7MgCiFj4+HI2K0pzQPFc+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by CH3PR11MB8364.namprd11.prod.outlook.com (2603:10b6:610:174::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 03:14:44 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9a8d:9d34:4af2:f2e5]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9a8d:9d34:4af2:f2e5%6]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 03:14:44 +0000
Date:   Mon, 14 Aug 2023 11:14:32 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Zhang Rui <rui.zhang@intel.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>,
        <tj@kernel.org>, <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH] sched/fair: Skip cpus with no sched domain attached
 during NOHZ idle balance
Message-ID: <20230814031432.GA574314@ziqianlu-dell>
References: <20230804090858.7605-1-rui.zhang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230804090858.7605-1-rui.zhang@intel.com>
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|CH3PR11MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a764ceb-9d50-4407-c299-08db9c749b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TEY5QkEKyJ9yGWQhL0dNs1/qu212BBMDP0TTFYH/nAnMfrfZ1CZaXIdZTw9NN5n6+6/2ovbH+0b2kqMbLBGNBvspiF2Rbd3kMeoLGudqLahRK+QIXYyBvQWTuU+b2z6LlVc1tcZiAdHT++Vw+s9MepQvwVkKJkh5VFD4gtulRLAp3sPiD6ioXhgcbjM9wgjNbQWCvwlMlg3HyyyWcXBnLvmlVltIMxQA4ytMLoIYLyFT99jTiRhvzKEtgw2kv6vR1RzPKM1AQ3YVucBdXaxF5ROWWlgDYjmrhSMoeeR2I0u9ZIHZOg1X6HS0ykb28Lb0H2cyuKdkwxpfw5/MmFBkf9f2zAckBFQE7/2jUBepdH/SUXxzX1YKarvqT2af/xeX9YASBsiScBuhvaLoOOtoYyyFgTBN0+bGeR8mHRNXo8hg/2RWkUwkTrApplkWtYRUJh8Bl15A00AoR0cxGyuByqkydZYzOBjCghBBV5IwZuJk0+NqZAE9Kv5GVHQ68ypNalbPo8dn4geZpCXg4VAffA2U5g1Q98u7lmAmFihFYR9xL1fo9sz9Mq0YPhty4eI/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(186006)(1800799006)(86362001)(9686003)(6512007)(107886003)(6666004)(6486002)(6506007)(38100700002)(33656002)(33716001)(82960400001)(26005)(1076003)(83380400001)(6636002)(66946007)(2906002)(8676002)(8936002)(41300700001)(4326008)(6862004)(316002)(5660300002)(66476007)(66556008)(44832011)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xblB2yaUIndIUjDB3LMpT+tV8yodCtU14hQFVzcP5/462tF3tnqewW7euAHv?=
 =?us-ascii?Q?CJTbGIteKgJzp/k524DG4Kft3W/l9uA8Bq4fRbhKgOq/bV1cDrBXk/yAn164?=
 =?us-ascii?Q?vFGMnGycCYmM9FjvMVFQi0kJfs25wqybMXmbOrxJEIIGkdwtDIY9nrCsuBJt?=
 =?us-ascii?Q?BxAigga22zwFE0Kgk5sOQLQmofJ3FCssjZRkWChMGy8JaBUWVXoxdGgBN4hA?=
 =?us-ascii?Q?1dOCTJ8+4jWkCxmpQSJT7gg4+CI3w+oj/qBMYBWXgeI0LKIOv4zFJ/GFVpra?=
 =?us-ascii?Q?2c1bRz5/PQK7EjsWoPboixWBwxRBKAuIMi8oNfaeTGIds+iTGIDSkGoLyjWz?=
 =?us-ascii?Q?qFCMYsRuICly5FjzO29UcI7QT+lHZZWrEtqhJ+vvGPjdMTDt4r91qR73cEfs?=
 =?us-ascii?Q?fEcc4lOuy7meBHQdIjH2hc9bN0p3GBEDpkLJLzUZiQT+S/z/mpk+HBcsDJaN?=
 =?us-ascii?Q?woES4I3d/yk90bAZFvYKrsfdFORKg9XdQb4HAlZ+dhsIhtEVyflp0t9RsnXj?=
 =?us-ascii?Q?4uEa0QZHfJ1l57hLXdLUhtM6Hj9/6h6Dct3f1eCG84Q+LnRXNMXkYoYdnROQ?=
 =?us-ascii?Q?mIl25uMVnqn7arJKWq1vvechuTh5s00aLw7VMSvplkl9ShVnN+GCBqw5Kxl3?=
 =?us-ascii?Q?yG4Eph4KU+bzJs2CbEC+LSj9wh/x5jVaTKBpt5V/AvIKsCcI2MPRWOAgKnBZ?=
 =?us-ascii?Q?Hdqka5WsJXtwq6L6sAumgkT/smUGHople18iXkBer+K4KU4WaQVchCfrkMSP?=
 =?us-ascii?Q?kj5obKTk3Q/uWeaaTD6rKEYKAkbZYpH7gws2obZdZ99yd6oiBw17kmtOYaI+?=
 =?us-ascii?Q?urpXm6GxPqJYt7JuMvkTYd3MiSlIeD0cOWWSbrCbGq4b/NFFko6A7HWY/+JU?=
 =?us-ascii?Q?9UzqJIx4n6UFA+nwqXihS0GOcnVE8+IjVK0DK2X7p1YKcbXaqENG5yYzmJjc?=
 =?us-ascii?Q?+/7e9S8C+yfbz9wZkdyvrW09AJF4rkMcBDX+txwazpyLdpbPNy54IrIraF3M?=
 =?us-ascii?Q?7mn42N24PUdkJVG+oMm0vPVzdAVYM4iH9vm8rBwoylGP7yUEuQzJfckBjzKh?=
 =?us-ascii?Q?mTmuyYa2n+EcrjA/qffa5kHHHUfwf48YmFCuljg3pZG5OkCDIDJhMC0IrKfT?=
 =?us-ascii?Q?IGVnZpo2Hv/DUyErn+C5m6/mrh0acFhByVex3cVQymfqaKPt3cklSJJopdAZ?=
 =?us-ascii?Q?cmqY5EWPpz/0OCTFUYW+iXwstg/5MpT8WRDsZdre6wyXmzc/6moYK9RClOkU?=
 =?us-ascii?Q?Vzco3JenLA1pqADnojLWGF5FerN8ri4/L1IMX48Ti7eqxxMLMaEQgT5B9air?=
 =?us-ascii?Q?ECG73tHnWtWUseJTwLSGOWA5FIKIt5PpbWuGbImPyErVYN1Vh2bPBjveEO19?=
 =?us-ascii?Q?cjNmYZb6GzRbtT7FTRx6ZuasEayPKMb0JE1NIBIfhiNUWC64Pxn/Ou/A0snA?=
 =?us-ascii?Q?IwdXav40G0mHYGDxfHITnAC+8zk+p+29H534l/IehYZ87/gf/9vIEN3QAUBg?=
 =?us-ascii?Q?R1Q+WOP1IflUYGXJ1g7Tbc9eLDwgetl5JO+EwhZj8aj7fE2wMG2ppvi8Bpxz?=
 =?us-ascii?Q?cOccNOUWG1GYk+Eh6/9o5lMSRUvjrI3PJKy25rZk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a764ceb-9d50-4407-c299-08db9c749b17
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 03:14:43.9571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9yG8xf4LjDR9BIXAo3gV72yQaYikrbE2YGq0gNv05gfBk6MeBYLCWChxxjpDSs3OfLd8sai6eDGlN4bwND51Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8364
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

Hi Rui,

On Fri, Aug 04, 2023 at 05:08:58PM +0800, Zhang Rui wrote:
> Problem statement
> -----------------
> When using cgroup isolated partition to isolate cpus including cpu0, it
> is observed that cpu0 is woken up frequenctly but doing nothing. This is
> not good for power efficiency.
> 
> <idle>-0     [000]   616.491602: hrtimer_cancel:       hrtimer=0xffff8e8fdf623c10
> <idle>-0     [000]   616.491608: hrtimer_start:        hrtimer=0xffff8e8fdf623c10 function=tick_sched_timer/0x0 expires=615996000000 softexpires=615996000000
> <idle>-0     [000]   616.491616: rcu_utilization:      Start context switch
> <idle>-0     [000]   616.491618: rcu_utilization:      End context switch
> <idle>-0     [000]   616.491637: tick_stop:            success=1 dependency=NONE
> <idle>-0     [000]   616.491637: hrtimer_cancel:       hrtimer=0xffff8e8fdf623c10
> <idle>-0     [000]   616.491638: hrtimer_start:        hrtimer=0xffff8e8fdf623c10 function=tick_sched_timer/0x0 expires=616420000000 softexpires=616420000000
> 
> The above pattern repeats every one or multiple ticks, results in total
> 2000+ wakeups on cpu0 in 60 seconds, when running workload on the
> cpus that are not in the isolated partition.
> 
> Rootcause
> ---------
> In NOHZ mode, an active cpu either sends an IPI or touches the idle
> cpu's polling flag to wake it up, so that the idle cpu can pull tasks
> from the busy cpu. The logic for selecting the target cpu is to use the
> first idle cpu that presents in both nohz.idle_cpus_mask and
> housekeeping_cpumask.
> 
> In the above scenario, when cpu0 is in the cgroup isolated partition,
> its sched domain is deteched, but it is still available in both of the
> above cpumasks. As a result, cpu0

I saw in nohz_balance_enter_idle(), if a cpu is isolated, it will not
set itself in nohz.idle_cpus_mask and thus should not be chosen as
ilb_cpu. I wonder what's stopping this from working?

> 1. is always selected when kicking idle load balance
> 2. is woken up from the idle loop
> 3. calls __schedule() but cannot find any task to pull because it is not
>    in any sched_domain, thus it does nothing and reenters idle.
> 
> Solution
> --------
> Fix the problem by skipping cpus with no sched domain attached during
> NOHZ idle balance.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  kernel/sched/fair.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b3e25be58e2b..ea3185a46962 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11340,6 +11340,9 @@ static inline int find_new_ilb(void)
>  		if (ilb == smp_processor_id())
>  			continue;
>  
> +		if (unlikely(on_null_domain(cpu_rq(ilb))))
> +			continue;
> +
>  		if (idle_cpu(ilb))
>  			return ilb;
>  	}
> -- 
> 2.34.1
> 
