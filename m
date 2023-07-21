Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8250175C3C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjGUJym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjGUJyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:54:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD1C3C1F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689933225; x=1721469225;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=y51TIFha70H6D8vnY/j3oyLnxlCRBwrrPT5jGSMO16M=;
  b=K7P0jqQAYlv+unJHQDwIAf4ShAxkfXLVocU6CY1lQ+NzyEOUPfLiJHUX
   8X/B1ggpuF2/G69QNdbXVldPl1zVBbq+GbtpC59h4/B7mrzP6Rr+cLdhV
   YJxlrxKg7IfRotaUVce7hmNCuOF0gUAbjDmEq1i7JYDzYdlIcSLwZGF/u
   5d4O2RwYSuaBgIOuCQrNuS99P5Qzwh5G47XJVgCH8xql52+RaVlguVI8a
   tl+bRFDb7QyCxWFOUGRGRvovqEIDISRkcIAiBVfxJn/lveHfBbfdqDTrU
   ufwJawLiNDi1azPqjCK0mcvilmVkRzVN1M+zGnOlsZddg/cprk7eUDN9m
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="365876893"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="365876893"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 02:53:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="701984577"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="701984577"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 21 Jul 2023 02:53:08 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 02:53:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 02:53:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 02:53:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mf6s7P4SoRHMQq5ktBW1WX670LY+s7Po9XCw647DXNkpDc5HjjHdiVCqbNG8ekdkwoIemA0kRi5ef5lrOy+O2EYvL/uwf63YfaFgALgfBitqKAyD7chGZMBovfwomEC5ECgwtQZzZ2mSOwNIs74g8LCsmZ+OiHOKm/7GX578VslmBkgoC+0LoGkEH6ZbOGmle1TqdhBcoX+PTOMCHnA3vhwIP+fxKQ9UtSnj4AnqtvSqtSORIQKjoYOwWQ9n8++PAxIb83d2KUJkU1gePqqqbAdjoEdcMedUht83xiy9agpS5lUXufNQKHtA8wLSHmsojwnY9b6SElHMujsflmZv8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8w9go+lXtxfRGKeLVRpXSPyVzsaTM0Q1wZmv6637AY=;
 b=lZY6PDdmoQkDQUgZBhqOysdoP1D6UxnH970f/tQBr7REK27lEoB/ElVmLhFQDvAGjEzpkaezGIWkeX9w797K2g8WPijuefr+WmmD7CgvkdNx4hqYjccw6YaMmZmsxP+BfA1UA0J2cwXwqNxpPmPwOdMK7fkZcqKUB2KUqk0ZfcRqyNpnC6/M0CS9xjppSIw7FOOEmTJDx3I8yAi7F4NpZhTq5ad+PNbpArd14+xmDZ0ofSG//N/0krKdN0+yRSqQhv1O3Ir959LekaSnQNOTe9XqGoheclZvCSNjYBp4sk20mCp8L4DJzVqlLqihPFv/M8weXp36PYwGP0ybLuu9WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH0PR11MB5926.namprd11.prod.outlook.com (2603:10b6:510:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 09:53:01 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 09:53:00 +0000
Date:   Fri, 21 Jul 2023 17:52:38 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <tim.c.chen@linux.intel.com>,
        <gautham.shenoy@amd.com>, <mgorman@suse.de>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        <jonathan.cameron@huawei.com>, <ego@linux.vnet.ibm.com>,
        <srikar@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <21cnbao@gmail.com>, <kprateek.nayak@amd.com>,
        <wuyun.abel@bytedance.com>, Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v9 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
Message-ID: <ZLpVZmI8FrQtsfRH@chenyu5-mobl2>
References: <20230719092838.2302-1-yangyicong@huawei.com>
 <20230719092838.2302-3-yangyicong@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230719092838.2302-3-yangyicong@huawei.com>
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH0PR11MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: 841e969d-5ebc-4666-a133-08db89d04506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YhWWuW/t7uoC/n5claTch96mhtFrlXnbSfKoi5epXcz0eR1gVR3GPmZgMHtZJftzDCpwMFM65mhHUUd8Kbb0+IxUbm6mEhHNBdleVIzicbeuxbjxUrcl52vfBzQzFIXH0mNm5126h5obgg0pTrp+2ocPsHyWTP5o0X5MpSt0PISxdYX5nc30ZPL/fegfdco9ZvvQDBqmLjpjEHKne2Tfb4/Z/3U/O51cCvQj4/H/+1WU5rrGd0X5Gt/R9AxLVPml19lgWrwwlnk5P1j26UU9lcMgDcW0aVRDproGEIPGgS0JNvEmBW9rsUPvVhP6x3FGJ65qGhBKNPzLL4latEMMNPd/QBqawSmNBePaDNdDpXeeguLTEGiFfVNNVW25vte94vAUnHt35/lbZ66rLG0LhFHJr4lYTb1IWfr+Nulm2kdT8E2LxpxoZTnjyraOG7/Tt9v4DA5wPwN2y0+b++e/WviWyl7zci3fllGEVSQoDC+SuUwcArFrVS8qG+4z6/qWc+TEWjy89FW3rr9Rpn6lFdSGzjPZqTP3vw/kg0cN2QY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199021)(83380400001)(66476007)(2906002)(8936002)(7416002)(478600001)(8676002)(66946007)(41300700001)(66556008)(6916009)(316002)(4326008)(5660300002)(9686003)(6506007)(26005)(186003)(53546011)(6486002)(6666004)(6512007)(86362001)(33716001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JimuokITMiQrZHIGTOHCuu/T/m+hJh3x+kKcI+ECo2P7TWoOl7ZcHLh8hG7G?=
 =?us-ascii?Q?+t0Iahp6UDHSObmjWhxiU1t5YJR7t1vPZkXn1ghCXrZfke44743ZnqJOpgxY?=
 =?us-ascii?Q?dqfm8sQOOvcGaKT4FuKeVeseL+c42FUoRi33PVzJ0US7b8yCF221a/xj+FeV?=
 =?us-ascii?Q?Z5vZVeYywjZjD5Ug8LnihAl12AjRK92jf1DTPnw0FksSg2m5hhH+KVlxttoa?=
 =?us-ascii?Q?AJlDkG23AkjiWUuS/FKRebPFyvqvJ/5yrxZjy2WxfC3Vc1Wust1xT9DHjBDm?=
 =?us-ascii?Q?l64gRj3HFgKC0i2uLgjOZH5VglW7JzGKkUgRH4vsS4miCb/Rs1CjqHu6ttL8?=
 =?us-ascii?Q?iKJq9EyG0fGO38D5swHtMv5oHHuz74bTybPf/M9BSFqyl3PyNKGRiM4YMWQI?=
 =?us-ascii?Q?9vs/L6wI80suExESQl/zkDr+F11oZo7QuOcq6Si2aIjW0yhzGycPiD5N2XD6?=
 =?us-ascii?Q?x5g/vJEiijpP/9H2RQSh1dc93dBTLRSAuAyl2XSIZARQ+BWQBPZCOmWTJ7yz?=
 =?us-ascii?Q?IsoTnl+CQ/ti/T/sI1V7pys4EAkL52liaQ/3+taw/FJEgBV0WfD3lI+u/mHx?=
 =?us-ascii?Q?HDap1Q+muUllXctEzCOEKcwg7RTdGBfHoDMqiOMYPhLWxzKL0MgoqnjFL4VV?=
 =?us-ascii?Q?ZEXKmTb6sqF9GnsH3GWBsVuMnEs5IAXQbSsOqjFYaWzWICGha569VCO2bu3q?=
 =?us-ascii?Q?ye9KTvuJqmvO0MO57HqiHkyPNg00OBejzXqfLzfbc6vHXbDhP32FmDLBy98l?=
 =?us-ascii?Q?9IM6HObYzhcS24/jfLPYY2AThhc6p/S2zMSsaNxCRvWILWne7RLfAaoSOh5I?=
 =?us-ascii?Q?dnm3K+XeRahFths6+m1lBKpMiV3lzivEMPAn+meVbJGN9DOo8MY/9pW7ymjj?=
 =?us-ascii?Q?kMxH6AnZMMTEsECRWrV8WILwLQsqs8fQ8JGv2VSE9wiH+vckmAfncnKajgTP?=
 =?us-ascii?Q?ECSTZPHBVVvEyzg0s19DP5klnzmLXENKmgubWTODGnbvSUdO/yZVKmKnIEUb?=
 =?us-ascii?Q?d9l39Ja6FrK3KDMQEYr1gkdY6+zakBXkzpFE6uNxd8KA+eOH5x08Om7Fm1+o?=
 =?us-ascii?Q?9VnzBoj+J7WxWOW4ceR8dXNkA41i1DH+XqKu8QhSIeWVSPlyEzNe3noru5wA?=
 =?us-ascii?Q?NLFZKHOXXKZuMSpMDzenYwgto/QHfKyh54hlkGWKaB/H6PKMGj9PC6tLQxpQ?=
 =?us-ascii?Q?nkoRfLOiK0ACvX8YJnRTgJcdlM7T0bsQUMuEBGFlTrrSpo8tKIdGrbAZFhN3?=
 =?us-ascii?Q?fsrCi6WLHRxdHluYXiP/o8kDo4n75XLL360SrfIcMIzywz5d6dbSZwHPq8DU?=
 =?us-ascii?Q?TcB6MZ0F2EZAxm+ajFmv8R0rVnQToXs27lIHJUYdqukYlkBis+nUm1F0oKQo?=
 =?us-ascii?Q?k2kjaDwd2WrtSfhDR3rv/uiLcMEWYhXmwGyS7zzq4aMt3oddEq3X2PoxE0gV?=
 =?us-ascii?Q?FW5XsKq1H9L8XNYwSkhG+iWTRa05guBhJ3vpU5/HXQKwwCAhAWKyzeXJ2Nau?=
 =?us-ascii?Q?XlUXprgYTb7l8OCcrTxjz22fY4pyVRu0fgmdu5Kn1txwTkeWYXgDJkJKwV8o?=
 =?us-ascii?Q?tgfEdjBXh6DeVqs/gcL29Z/PVQiDSJH9uajbiceb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 841e969d-5ebc-4666-a133-08db89d04506
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:53:00.9245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcSbhmAN7pIjbTd7yTsPZSTz89ETjxWUF1LrwoybVoxUQPUVOuXYzeF2y+dL4IWRiR2BRvRKQyiYJ6fSh2h0Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5926
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yicong,

Thanks for sending this version!

On 2023-07-19 at 17:28:38 +0800, Yicong Yang wrote:
> From: Barry Song <song.bao.hua@hisilicon.com>
> 
> For platforms having clusters like Kunpeng920, CPUs within the same cluster
> have lower latency when synchronizing and accessing shared resources like
> cache. Thus, this patch tries to find an idle cpu within the cluster of the
> target CPU before scanning the whole LLC to gain lower latency. This
> will be implemented in 3 steps in select_idle_sibling():
> 1. When the prev_cpu/recent_used_cpu are good wakeup candidates, use them
>    if they're sharing cluster with the target CPU. Otherwise record them
>    and do the scanning first.
> 2. Scanning the cluster prior to the LLC of the target CPU for an
>    idle CPU to wakeup.
> 3. If no idle CPU found after scanning and the prev_cpu/recent_used_cpu
>    can be used, use them.
> 
> Testing has been done on Kunpeng920 by pinning tasks to one numa and two
> numa. On Kunpeng920, Each numa has 8 clusters and each cluster has 4 CPUs.
> 
> With this patch, We noticed enhancement on tbench and netperf within one
> numa or cross two numa on 6.5-rc1:
> tbench results (node 0):
>              baseline                    patched
>   1:        325.9673        378.9117 (   16.24%)
>   4:       1311.9667       1501.5033 (   14.45%)
>   8:       2629.4667       2961.9100 (   12.64%)
>  16:       5259.1633       5928.0833 (   12.72%)
>  32:      10368.6333      10566.8667 (    1.91%)
>  64:       7868.7700       8182.0100 (    3.98%)
> 128:       6528.5733       6801.8000 (    4.19%)
> tbench results (node 0-1):
>               vanilla                    patched
>   1:        329.2757        380.8907 (   15.68%)
>   4:       1327.7900       1494.5300 (   12.56%)
>   8:       2627.2133       2917.1233 (   11.03%)
>  16:       5201.3367       5835.9233 (   12.20%)
>  32:       8811.8500      11154.2000 (   26.58%)
>  64:      15832.4000      19643.7667 (   24.07%)
> 128:      12605.5667      14639.5667 (   16.14%)
> netperf results TCP_RR (node 0):
>              baseline                    patched
>   1:      77302.8667      92172.2100 (   19.24%)
>   4:      78724.9200      91581.3100 (   16.33%)
>   8:      79168.1296      91091.7942 (   15.06%)
>  16:      81079.4200      90546.5225 (   11.68%)
>  32:      82201.5799      78910.4982 (   -4.00%)
>  64:      29539.3509      29131.4698 (   -1.38%)
> 128:      12082.7522      11956.7705 (   -1.04%)
> netperf results TCP_RR (node 0-1):
>              baseline                    patched
>   1:      78340.5233      92101.8733 (   17.57%)
>   4:      79644.2483      91326.7517 (   14.67%)
>   8:      79557.4313      90737.8096 (   14.05%)
>  16:      79215.5304      90568.4542 (   14.33%)
>  32:      78999.3983      85460.6044 (    8.18%)
>  64:      74198.9494      74325.4361 (    0.17%)
> 128:      27397.4810      27757.5471 (    1.31%)
> netperf results UDP_RR (node 0):
>              baseline                    patched
>   1:      95721.9367     111546.1367 (   16.53%)
>   4:      96384.2250     110036.1408 (   14.16%)
>   8:      97460.6546     109968.0883 (   12.83%)
>  16:      98876.1687     109387.8065 (   10.63%)
>  32:     104364.6417     105241.6767 (    0.84%)
>  64:      37502.6246      37451.1204 (   -0.14%)
> 128:      14496.1780      14610.5538 (    0.79%)
> netperf results UDP_RR (node 0-1):
>              baseline                    patched
>   1:      96176.1633     111397.5333 (   15.83%)
>   4:      94758.5575     105681.7833 (   11.53%)
>   8:      94340.2200     104138.3613 (   10.39%)
>  16:      95208.5285     106714.0396 (   12.08%)
>  32:      74745.9028     100713.8764 (   34.74%)
>  64:      59351.4977      73536.1434 (   23.90%)
> 128:      23755.4971      26648.7413 (   12.18%)
> 
> Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so the SMT branch
> in the code has not been tested but it supposed to work.
> 
> Chen Yu also noticed this will improve the performance of tbench and
> netperf on a 24 CPUs Jacobsville machine, there are 4 CPUs in one
> cluster sharing L2 Cache.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> [https://lore.kernel.org/lkml/Ytfjs+m1kUs0ScSn@worktop.programming.kicks-ass.net]
> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/sched/fair.c     | 59 +++++++++++++++++++++++++++++++++++++----
>  kernel/sched/sched.h    |  1 +
>  kernel/sched/topology.c | 12 +++++++++
>  3 files changed, 67 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b3e25be58e2b..d91bf64f81f5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7012,6 +7012,30 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  		}
>  	}
>  
> +	if (static_branch_unlikely(&sched_cluster_active)) {
> +		struct sched_group *sg = sd->groups;
> +
> +		if (sg->flags & SD_CLUSTER) {
> +			for_each_cpu_wrap(cpu, sched_group_span(sg), target + 1) {
> +				if (!cpumask_test_cpu(cpu, cpus))
> +					continue;
> +
> +				if (has_idle_core) {
> +					i = select_idle_core(p, cpu, cpus, &idle_cpu);
> +					if ((unsigned int)i < nr_cpumask_bits)
> +						return i;
> +				} else {
> +					if (--nr <= 0)
> +						return -1;
> +					idle_cpu = __select_idle_cpu(cpu, p);
> +					if ((unsigned int)idle_cpu < nr_cpumask_bits)
> +						return idle_cpu;
> +				}
> +			}
> +			cpumask_andnot(cpus, cpus, sched_group_span(sg));
> +		}
> +	}
> +
>  	for_each_cpu_wrap(cpu, cpus, target + 1) {
>  		if (has_idle_core) {
>  			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> @@ -7019,7 +7043,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  				return i;
>  
>  		} else {
> -			if (!--nr)
> +			if (--nr <= 0)
>  				return -1;
>  			idle_cpu = __select_idle_cpu(cpu, p);
>  			if ((unsigned int)idle_cpu < nr_cpumask_bits)
> @@ -7121,7 +7145,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	bool has_idle_core = false;
>  	struct sched_domain *sd;
>  	unsigned long task_util, util_min, util_max;
> -	int i, recent_used_cpu;
> +	int i, recent_used_cpu, prev_aff = -1;
>  
>  	/*
>  	 * On asymmetric system, update task utilization because we will check
> @@ -7148,8 +7172,14 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	 */
>  	if (prev != target && cpus_share_cache(prev, target) &&
>  	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> -	    asym_fits_cpu(task_util, util_min, util_max, prev))
> -		return prev;
> +	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
> +		if (!static_branch_unlikely(&sched_cluster_active))
> +			return prev;
> +
> +		if (cpus_share_resources(prev, target))
> +			return prev;

I have one minor question, previously Peter mentioned that he wants to get rid of the
percpu sd_share_id, not sure if he means that not using it in select_idle_cpu()
or remove that variable completely to not introduce extra space? 
Hi Peter, could you please give us more hints on this? thanks.

If we wants to get rid of this variable, would this work?

	if ((sd->groups->flags & SD_CLUSTER) &&
	    cpumask_test_cpu(prev, sched_group_span(sd->groups))
		return prev

Anyway, I'll queue a test job on top of your version and see what the result is.


thanks,
Chenyu
