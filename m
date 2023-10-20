Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783947D099A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376433AbjJTHhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 03:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376317AbjJTHhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:37:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6176293
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 00:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697787420; x=1729323420;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Q9+FNTLklopeYkwzy10s1fVRii+9tOrXPk0tGsscNZY=;
  b=XKXLbpCguVKtv5beYUNova7aB/8Bt/c6z6ByvazcgHf59LcPHOdNcFEa
   VSo4nqglfxGpvVeSPbuDOD1Xe6fr3jcrrAOhMO9o2/UmIBA+DjDPLb8nF
   NhPKfQQtJtHFxDjRULCynqb1N+D5z8P/V8jks2OlOBbwqlt5HOovftek9
   pqboUa/eeGvbLhGlTSi++m5ysQk530VjymxTVw0zq3YQEKXSB1G03mDtr
   U/ORgyCRxjw5+CFF5sSQtdeamhtCB2r7hxYxERM75yRTamb2CKv07RXW2
   qu1YVFbekjk0UpVO5dFi3CQsCc3+MrprUYvaEbqGHm/whvuftKmIjq43N
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="452927003"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="452927003"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 00:36:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="848006894"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="848006894"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 00:36:47 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 00:36:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 00:36:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 00:36:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d73rpuAeXPySyl8EiX+40O9/bOj+00AfsRz6wu8K9bjtGndv8ROxQmuSP+RiZIj2qcWnwESfkcc4xvBEMeAa+tpv2T/m5L9DVPw9jOGOU0wpKt55x/KoUhFJqQ510DkUKrgZRIf0B4XeRLnh5H+uVTzNESyF2itgpcm0VOJ1T2Jr0gNYVAzXI7YZvR8XDOA6mqC74aFGCK6ZqDKNELHzO/QhgXY/Iw8VkTvJDgjbdsQjlD5MO77bLNUqHrZVDjNQM00xpe6ze1EQKp6uxBv7v2KGQPbKR09BiiMFsZ7U5eb7Tw6gnbGXcKBbeJZgDW1o7JHGxVIqnVpiAYZTFDzkTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WEiyzpjifscOSydA/YEWrb/GlT2c9PD9jY7IXog28k=;
 b=CdHavWGxznLGMpIo6LEY4Rm4RKPzNTSIhQfOGY+g8vbVJ6kCEXG2GWpvHkx1LP+GDv8AXv94eS1aRKINXbwrAguR/SnvCESgXzjlJiSYQ97+WV5KhmVTps8Q6fBteJVJ2grWTtqembRiAtiLjVnlkclHy7vElpni/zrDvoY7sbB4hkU1dQ6ElRap+9oVOCxeY8e6qbO6hZB//PKNV2GqBqL6cjcvD7H+eIEcO9vjdJpYe6bFWhq1LUoNTSXkqVS7BIHgm22j963l4Dk95VkT5KBSyGsLRHL/1XLMOy3Yo2HmS+bK07jOzNmnzW6Swtntwc2vsGm8XyAlVk2cme7FWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SA2PR11MB5116.namprd11.prod.outlook.com (2603:10b6:806:fa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 07:36:45 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%5]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 07:36:44 +0000
Date:   Fri, 20 Oct 2023 15:36:28 +0800
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
        <wuyun.abel@bytedance.com>
Subject: Re: [PATCH v11 3/3] sched/fair: Use candidate prev/recent_used CPU
 if scanning failed for cluster wakeup
Message-ID: <ZTIt/GGYtohNYx7f@chenyu5-mobl2.ccr.corp.intel.com>
References: <20231019033323.54147-1-yangyicong@huawei.com>
 <20231019033323.54147-4-yangyicong@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231019033323.54147-4-yangyicong@huawei.com>
X-ClientProxiedBy: KL1PR01CA0121.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::13) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SA2PR11MB5116:EE_
X-MS-Office365-Filtering-Correlation-Id: f124d79d-543f-4a0c-81bc-08dbd13f4ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 80Nsodqq5PBPvcfDEOxMrybomfWKaSCHiwMH6a9T5tmrqa1/+3VrbC9VIuqbk4lz1SUzcQE9WO67NEbb+fYmGTn/cDCzN/RW1gJiJNWFFf+siQKd9PuqE2IT/vDsFMUrYrofGDDz7IkyNSzQ5XgKX6MZ8t8rxVHeDeiEAU8BGX6PCo1Pj5R8RGThGNCvcOIH2XnSzA2O8+Tp+ktQ4b/HCjHIy0TbhbSzhKABd8w6uyULWUJAs0K/S12o7GiG2I3+yKWgZRJguq3WjCq/I8PXA624snp3gnLr+jgEzf3gjWkNkYiexY2qdLbBr54gfoCmJv29QkMMxcGkqJwevAizmIghH6EznBsoQsu1EfDbsrAeBaQZQDv2UIcJyoT3SXtVitEr8YxvLmN0dcTEjvCTQhwt6S3u7NylifaJpOImLzUYDnp87iW/V0amVnljuTD5+DBKk6iKKGEgQo3rHYiYAScPnt4liuoal2d9fYWWkTiwMzJz8+YdqIZxgPc2RiW7BFLLIeplwNbEY8CXPurTXMmA1cZgkOs153e6f5u3Xujww/c1pNJ5XljrmgIwgSQ+BMODjfgh/BslZ6WZOyX1yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(41300700001)(8676002)(8936002)(4326008)(5660300002)(2906002)(7416002)(4001150100001)(86362001)(6506007)(53546011)(6486002)(966005)(83380400001)(6512007)(478600001)(38100700002)(6916009)(316002)(6666004)(26005)(82960400001)(66946007)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EiGfGoCJzyRij58HbYUhj76nwvLRvDrg8bzoHD2Dut46VOCYiiAMIvQm1dN1?=
 =?us-ascii?Q?PVfwl5XeCU102y9wAsbnfSRbzeuqv/+ZyrlQSH3DktqBnp7mS+cH+DfWOMQN?=
 =?us-ascii?Q?IXheqcoq7Y/jyo3/BjBLK4vX1XMl3Ly3PERaiDPDLDSBDlFD5QUNTmtY/3Bq?=
 =?us-ascii?Q?oAm0nZ2XuRZkXx9FGRaF33Smw2axNzJ4SSeLVAgBOVpVMRBTM8WSUa9AAIgN?=
 =?us-ascii?Q?Amh2u3Wp7rEuSfKmf/BGoeJeqBJBSHACrA13XK8xHqm1K1Pe3GRR23U66Vxp?=
 =?us-ascii?Q?MS1Yzf7Zq/isUJ8Ii8zP6EB0azwWlzPzWFYsm3oEwHUjzhZ4kng6HM2hh2CO?=
 =?us-ascii?Q?PboMyiCPuKBsNDzm5RLmNd4Fc5KSpYw3ZIhL+Cc3N7OJFTylIUAO2JIFvsVM?=
 =?us-ascii?Q?XCKcfPUI1GR1dT87S31dEVfpgik2f0vteb0IXsagq5fhTwaMnlGTtVIEjSGI?=
 =?us-ascii?Q?Fw4QvpUi3T52rFOqCrPnylNewUZuy83082WyiCL7c7HqpPnZqduudmFLhX5k?=
 =?us-ascii?Q?8PL2MtEV4l5CUxc0o0txVT/Yjl05+QpjUIffU9faZWE8INrucm7upwU3dgr0?=
 =?us-ascii?Q?4HlxyEta2T13FMFBAnv3x8gmb6c904/nDWZTeq+OgkJe1hRNcJRMccaMn6Hr?=
 =?us-ascii?Q?m74SBgfn7g2Vj7b2R7BJ5Xvx7TdC1B8p/z8ifny2kTgdKiGZVcSQcMUR/y2h?=
 =?us-ascii?Q?TL2uqv6KvCZYjNGCgfbyssx83SCnJHY7xeLXSFjmUyA04zDwJx1w/VPJDMXQ?=
 =?us-ascii?Q?HadaAbUEnayYvlNqChQ/QLpM21N3k7R529cBpYXf2UjpYLTvsLYoeK3xdfeF?=
 =?us-ascii?Q?qbbDD9xUax1c6FEHPzdqHAuHkUrNs9oF/+YrM6ta9dpOzSXL66cGPHeCXPP8?=
 =?us-ascii?Q?R6Y0ekBng6zx+zPFmFDpB0Ne6DJUf9A2OTSr52Poy1C8//XKxTynnEJqrBPc?=
 =?us-ascii?Q?tc0pocvDhEU1q1+OczbtTx3lLcVDL3PMunofgxdbrEQJQydotmnEEGnNQkvv?=
 =?us-ascii?Q?+qFgdHDfjD/+o+NrDKOmgPZa/LWECQoumzJJ7YcbFvNg/B4a5KTof1tRs0Lo?=
 =?us-ascii?Q?6MdnbmScw94xOgHyygUIBv/igEWvbyUprarm5xKUZY+Pa2PSKt53JaEJUs16?=
 =?us-ascii?Q?/DtJ+Kr5cIArFbj2kpROJwreTUjUt71m9s0D/LCKhKjmX7TbX7OEVvPifmKz?=
 =?us-ascii?Q?bydRubido3Inhdja3AhgTqtCO0ubpfc9kAyQFMPBWC/H3l2rFbTxPkphUk5K?=
 =?us-ascii?Q?8GSh3Ju4kY5QMBJPiPFCbTnTSsvisfGP/mVDYqAYE9+iLwk7O4xaO2xAJArk?=
 =?us-ascii?Q?X5xENVRkm5+i4B2gyunVM9QEY1aiWj+rg0KZscmOyZRreCDTEcu/lxdKgYUb?=
 =?us-ascii?Q?u/q+9d46Pbb/IN/bSBDeTULGWbHApg51V7PB9275vawsBSTtkA/blaqNPZVl?=
 =?us-ascii?Q?4IMq+z1kq2Mpnk3700UfwCI2AS21kupGVX+beirW44kGiUHDrKkjWFD6lNNr?=
 =?us-ascii?Q?e4dC7hvFOj4MRHf2bbImMwrW8t1HwbWMN0ZdOCO1xwRQaCDZ6f623yIWwwQV?=
 =?us-ascii?Q?8fcyqUuK26erDcKOxKbTkflOuam9JFYRKZ03qyXK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f124d79d-543f-4a0c-81bc-08dbd13f4ee1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 07:36:44.1061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWcsPUVaNpSzO2Krb22mdnFRVn+I5AMZ1laOnHzVhzEUjMnPZWClZK02noP/+Hwv/QMgg8u6opXMYffqC83L9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5116
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

On 2023-10-19 at 11:33:23 +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Chen Yu reports a hackbench regression of cluster wakeup when
> hackbench threads equal to the CPU number [1]. Analysis shows
> it's because we wake up more on the target CPU even if the
> prev_cpu is a good wakeup candidate and leads to the decrease
> of the CPU utilization.
> 
> Generally if the task's prev_cpu is idle we'll wake up the task
> on it without scanning. On cluster machines we'll try to wake up
> the task in the same cluster of the target for better cache
> affinity, so if the prev_cpu is idle but not sharing the same
> cluster with the target we'll still try to find an idle CPU within
> the cluster. This will improve the performance at low loads on
> cluster machines. But in the issue above, if the prev_cpu is idle
> but not in the cluster with the target CPU, we'll try to scan an
> idle one in the cluster. But since the system is busy, we're
> likely to fail the scanning and use target instead, even if
> the prev_cpu is idle. Then leads to the regression.
> 
> This patch solves this in 2 steps:
> o record the prev_cpu/recent_used_cpu if they're good wakeup
>   candidates but not sharing the cluster with the target.
> o on scanning failure use the prev_cpu/recent_used_cpu if
>   they're recorded as idle
> 
> [1] https://lore.kernel.org/all/ZGzDLuVaHR1PAYDt@chenyu5-mobl1/
> 
> Reported-by: Chen Yu <yu.c.chen@intel.com>
> Closes: https://lore.kernel.org/all/ZGsLy83wPIpamy6x@chenyu5-mobl1/
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>

Tested on 24 CPUs Jacobsville machine, 4 CPUs in one cluster sharing L2 Cache.
The baseline is sched/core on top of 
commit a36e5741bdc5 ("sched: Fix stop_one_cpu_nowait() vs hotplug"),
and compared with the whole patch set applied. I did not see any regression but
improvement on hackbench, please feel free to add:

Tested-and-reviewed-by: Chen Yu <yu.c.chen@intel.com>


hackbench
=========
case            	load    	baseline(std%)	compare%( std%)
process-pipe    	1-groups	 1.00 (  0.26)	 +6.02 (  1.53)
process-pipe    	2-groups	 1.00 (  1.03)	 +1.97 (  0.70)
process-pipe    	4-groups	 1.00 (  0.26)	 +1.80 (  3.27)
process-sockets 	1-groups	 1.00 (  0.29)	 +1.63 (  0.86)
process-sockets 	2-groups	 1.00 (  1.17)	 +2.59 (  0.35)
process-sockets 	4-groups	 1.00 (  1.07)	 +3.86 (  0.51)
threads-pipe    	1-groups	 1.00 (  0.79)	 +8.17 (  0.48)
threads-pipe    	2-groups	 1.00 (  0.65)	 +6.34 (  0.23)
threads-pipe    	4-groups	 1.00 (  0.38)	 +4.61 (  1.04)
threads-sockets 	1-groups	 1.00 (  0.73)	 +0.80 (  0.35)
threads-sockets 	2-groups	 1.00 (  1.09)	 +2.81 (  1.18)
threads-sockets 	4-groups	 1.00 (  0.67)	 +2.30 (  0.20)

netperf
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	6-threads	 1.00 (  0.48)	 +3.97 (  0.50)
TCP_RR          	12-threads	 1.00 (  0.11)	 +3.83 (  0.15)
TCP_RR          	18-threads	 1.00 (  0.18)	 +7.53 (  0.18)
TCP_RR          	24-threads	 1.00 (  0.34)	 +2.40 (  0.77)
TCP_RR          	30-threads	 1.00 ( 10.39)	 +2.22 ( 11.51)
TCP_RR          	36-threads	 1.00 ( 10.87)	 +2.06 ( 16.71)
TCP_RR          	42-threads	 1.00 ( 14.04)	 +2.10 ( 12.86)
TCP_RR          	48-threads	 1.00 (  5.89)	 +2.15 (  5.54)
UDP_RR          	6-threads	 1.00 (  0.20)	 +2.99 (  0.55)
UDP_RR          	12-threads	 1.00 (  0.18)	 +3.65 (  0.27)
UDP_RR          	18-threads	 1.00 (  0.34)	 +6.62 (  0.23)
UDP_RR          	24-threads	 1.00 (  0.60)	 -1.73 ( 12.54)
UDP_RR          	30-threads	 1.00 (  9.70)	 -0.62 ( 14.34)
UDP_RR          	36-threads	 1.00 ( 11.80)	 -0.05 ( 12.27)
UDP_RR          	42-threads	 1.00 ( 15.35)	 -0.05 ( 12.26)
UDP_RR          	48-threads	 1.00 (  5.58)	 -0.12 (  5.73)

tbench
======
case            	load    	baseline(std%)	compare%( std%)
loopback        	6-threads	 1.00 (  0.29)	 +2.51 (  0.24)
loopback        	12-threads	 1.00 (  0.08)	 +2.90 (  0.47)
loopback        	18-threads	 1.00 (  0.06)	 +6.85 (  0.07)
loopback        	24-threads	 1.00 (  0.20)	 +1.85 (  0.14)
loopback        	30-threads	 1.00 (  0.15)	 +1.37 (  0.07)
loopback        	36-threads	 1.00 (  0.12)	 +1.34 (  0.07)
loopback        	42-threads	 1.00 (  0.09)	 +0.91 (  0.04)
loopback        	48-threads	 1.00 (  0.11)	 +0.88 (  0.05)

schbench
========
case            	load    	baseline(std%)	compare%( std%)
normal          	1-mthreads	 1.00 (  2.67)	 -1.89 (  0.00)
normal          	2-mthreads	 1.00 (  0.00)	 +0.00 (  0.00)
normal          	4-mthreads	 1.00 (  8.08)	+12.86 (  2.32)

thanks,
Chenyu
