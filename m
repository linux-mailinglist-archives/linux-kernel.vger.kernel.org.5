Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFBC7CF6F5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345355AbjJSLgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjJSLgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:36:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1978FBE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697715359; x=1729251359;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jMNbdPAYWba9g9lDstVW0zr4zQk6UafGPqsjNizH3WE=;
  b=gSqMS4ywM+5wVHT4k7szJOcG+7i9asWVpg+qYfvXxMMtxaVup0fv+fE6
   8dEh3Cb5QyPXRGzU0ZhEAa7ibeTogI/+GL6XKerXzK/Jvik96dfBlVIvw
   /M8hWCwU0RYdmZFS8d8GMOf9xM0KTadjldfkAZOUSd1piiX4c2kgGew2S
   K8OmhkoWN3V8MYPm514BmdyYSNe9X0K/pErtvi180ECVb1FPo228l1sKx
   Q9DJ9+KQY5RIubotIrUpnurzeqfqBxgZ2edcJ8TaxNMhgF+Wlicp+SLCM
   ZauAaLOO3UI5Gq7nJuJGbCE2xObn72hKyky5DYQuLE/pr4nJOiW94HwQ1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="417341823"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="417341823"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 04:35:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="900709278"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="900709278"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 04:33:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 04:35:57 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 04:35:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 04:35:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 04:35:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLdvMjbCWcWEZD47j0DbmRrtj4KfiuAxESRPZrK3iW5yrx6690PmjyDfCrnCMNdLvV9OGhvuOkRYTurnv68rL/nyr6IT0pNtgXofVbBi6H9lxVm819q14Sct9cqPkrd6HbwPoBkAx+OPbYHNMxBd0MrfRWhXmdwRn2NX79miWAsEYegl5gJYUZYJC2/7I2HuahnVsRnWI7LpCB8tXW6vPXKExNKgO+pPnmm7b48c5qGr8rIE29KLHYgP+qtRsZq/iffz3QVVniUR6/SLO2GWBXPJiaGMHca+7SdnKbpxLp/qoKZyJeRHFkXs2m/c6ABbASjPM7ReIk02+9KrVgnO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5gAS4/GOiuQQ7DWX2NuGrzOX9vTF/OH1PjQMYyyESY=;
 b=SXUmE7zUsH5u7D9410v0bMX9I+F081teL4Lvu14w/BodRj3LohkRmmYspbVZvVVvX9MU6lV1FD/MZQbVTcq+U5B/ERmxv3V8OTw9s+k29fBxgU5C80tfvelmdRwBgeZlSqNXUawQdJ+ZgrT9odN7sl1ShGVcxhNJz5GwrTunu5xa7jPTB/I6873SCBkkcVaiCsFAr8efPvTymmD8hGedSLKCet5rlwreRpGLAs1o5caEnk/fjSG7820WO2rWo9TZ04H0iYWCmByKvT9AoTY7Sg37UMz0sfIRfgKLkt1ei1WrkEBiL5jlxMEV5M5R18+SPj3AAtOc4i3hF/GKaa/bMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CY8PR11MB7267.namprd11.prod.outlook.com (2603:10b6:930:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Thu, 19 Oct
 2023 11:35:54 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%5]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 11:35:54 +0000
Date:   Thu, 19 Oct 2023 19:35:40 +0800
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
Subject: Re: [RFC PATCH 1/2] sched/fair: Introduce UTIL_FITS_CAPACITY feature
Message-ID: <ZTEUjBgthYhz7NXm@chenyu5-mobl2.ccr.corp.intel.com>
References: <20231018204511.1563390-1-mathieu.desnoyers@efficios.com>
 <20231018204511.1563390-2-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231018204511.1563390-2-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CY8PR11MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: bd0b1e08-f748-4cc8-087d-08dbd0978e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+dYNycLl2j2kzESQCrm+VdcyMReboIzYtPwkCz5zEEWXrolNuLP2k2C29mGnuMh+DVq75IhJSMonqm9elFoeShnaFEiVWTh9nCPLToYf7tgD/noy2GER6LJnvFtjVvzZYsXI4AH6EhmR/vq9UTIXGAq2eIuGax3Zt33pRZ19jR2WiI371FhZAXyELFc8s5UvhRcQNhJj2HPfCPlbVVvac8wBajxupo41rhBwa4MLGlI5me3I5f2aT78nd0X93sN/T9c29g6yQ/YdFPsf3D2Ez6cMLrcfhfkla3KxlDutdcMIzIUkVSHmHpMnWyxUEkmloITtSxC+Mac7VSroXNbuontHAe7RgWY+WrWKq38PqZJtUvYCur93o+Mhxz0bmdt1etcBBdfm29b1ZyQJFnOvi1zx6lR2cVlJFhm9htOHMyb58PcJYTiH7MlQ8yyRcBhM2SBoJmpN0+2rU9QP2zGNEQmrtdm+5VGi1cL3og/VNIN6ZyGcJrILd+xizcL6yZBs/1c0SiZntu3ZDSegOdsTw8fk9zATZjOx4b/NAqEBxVswONWQregPUzgeKomHNggAdQat2Z7qn5n79Y936tczA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(346002)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6512007)(66556008)(54906003)(38100700002)(66476007)(6916009)(86362001)(6506007)(82960400001)(66946007)(316002)(53546011)(478600001)(966005)(83380400001)(8936002)(26005)(4001150100001)(6666004)(6486002)(7416002)(41300700001)(2906002)(8676002)(4326008)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TunmnI9HTj8mt5sIQKZSa2H/JivygLhzq3neSe4rj6F5rG15RZMvrjYx2WL2?=
 =?us-ascii?Q?QmVp4Utpenmp/s0Ju7NrA5oFvZLZP+IwhFnIUgOi2oyCj3/J/WFBB1CE2+9J?=
 =?us-ascii?Q?DlbTKNzZqHMqXDTNvtxUxj20KY2zn/7oNzbtjF5QwVLKpmnjm4+hOBSjLDRN?=
 =?us-ascii?Q?HHQ4h63sHJZE6EB5KFdQcZYGtzDzokiBegX81nXQqlqtE0AoNavbOprwjK0a?=
 =?us-ascii?Q?WwU4wnPWbP8/gMsP3xCvrzdDFrmLL/crei0zVnyK57BQYVxIIRG4PjdCGaa4?=
 =?us-ascii?Q?AIgnS7u4pSLog19AUwJsQWa7yEjcBFnm88n3MKdai3mGIj8GrUSXVHfLTHEg?=
 =?us-ascii?Q?lqbGnMyATsIZGhcrUhG45s64wg4p6qzpXxLrJAN0GHnW6KSZRS9Zqq1hAqN2?=
 =?us-ascii?Q?oACNdGwRR6LLUvtvb2LGAU4brUm48vfvuwb94+13c//4RDXS/BX3rzAj1hZ9?=
 =?us-ascii?Q?fKCQVv9irjYJR1W+VZA1RZPtUeVqm9sEjweQgfy6NRf+hnf005rj72nUa4VJ?=
 =?us-ascii?Q?xY6sQ0XeK7r929oNTNpvCn1Geiq3eR3hPhRqa8Z4Wfstu9Q/3xHEtSvXOV5G?=
 =?us-ascii?Q?YjQMei45sSDUu0Q8s1ZRtmvdMDSrDPTNQFAn+PzMZmx79j0Z/Mfd0sO+52SC?=
 =?us-ascii?Q?SqJQgjc6YpdhkeV4hQeLV5J4atILB7sDMciSps2W4gVWUXtZcINcNihdaS9q?=
 =?us-ascii?Q?zRAFlBhX3DHnvBABfuJLszMmeMMpbj6+jyq4txu6nB7MvfgGPRz9OnPpXLlf?=
 =?us-ascii?Q?P0dZpsSDeT/PZhG9QIyW28sfWiNcZcKNy0hgYzsnnsfe04xJaTR9yPgl8gy0?=
 =?us-ascii?Q?o4LraqJnw8EoYJbU/lw6BuEiwFUmArr8+3LOlqFr27JvSRVr4h/c6n+cj68H?=
 =?us-ascii?Q?QVimCkgHeavWkRqOaZ+nORk4hrrArMVTXCY9dgwxsaxfGVhB7++914vJy4jc?=
 =?us-ascii?Q?XyvKyFSYVISpWrurxqrBQEaU8kZo8MJECm9ESxDbL8yr8+twAZ7nls5q1pPo?=
 =?us-ascii?Q?BEUNM+YNUSpXxkXHlxRZ3yGr/GUsY6b6usx8EAgCuQDsyySisxs29VAf8CRI?=
 =?us-ascii?Q?ZmPwQTtsT8oQdRYWFaOg/KoHc9Et5w1ayKcOhmHsyNOMFsQDtdeVLia8s1U4?=
 =?us-ascii?Q?ckBxCMTKKOvJJCcrSIlcltbyCESe6SuVhC9Rgl7fz/pTv0t0wuUgu6AGl1xZ?=
 =?us-ascii?Q?K4YDa1k/hftSyfadIjk/h59IfteCPLYmt7p0UgJSo0hsrIdio/jgG+rq6eGg?=
 =?us-ascii?Q?uIks/5Fal7UKqi7Wc0obpNIfCczAYZqrPyHz4z1Tcg57CdmZMXFFU0vh/UJz?=
 =?us-ascii?Q?tOw7po2k94T+++tG1xYbw5hg8s0DZqvQnltf8tXHfICFBqBhUXeUbXoRN6Ff?=
 =?us-ascii?Q?zTNdoKxOJRH+MGhBg9F8eXwaneojLuCO3RK5M5ZlxTzAQ+w4Wnk9rorvwRCF?=
 =?us-ascii?Q?JI0KRc/o1xxMnN+38KEWTNNcT6rXyjw7Ojgg8QEig200HkeY9NzKGclRZoI1?=
 =?us-ascii?Q?tgIi7j42pPxZJstsB2qWAVBX9iXOyS8aCj/pbxGXED6SoBUkxpbmpFo2J8Ok?=
 =?us-ascii?Q?SqT5OlVaju1byIFlb0vlS4xDab7BX+sICOyjX819?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0b1e08-f748-4cc8-087d-08dbd0978e04
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 11:35:54.5808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLu231/pybgc79CVuXEEo+A2+p3vmpQe/vV3hyLb/50119j+qEr1iFCG/yRi5m4utcxWMDFnDPvbWkQSqnr2lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7267
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-18 at 16:45:10 -0400, Mathieu Desnoyers wrote:
> Introduce the UTIL_FITS_CAPACITY scheduler feature. The runqueue
> selection picks the previous, target, or recent runqueues if they have
> enough remaining capacity to enqueue the task before scanning for an
> idle cpu.
> 
> This feature is introduced in preparation for the SELECT_BIAS_PREV
> scheduler feature. Its performance benefits are noticeable when combined
> with the SELECT_BIAS_PREV feature.
> 
> The following benchmarks only cover the UTIL_FITS_CAPACITY feature.
> Those are performed on a v6.5.5 kernel with mitigations=off.
> 
> The following hackbench workload on a 192 cores AMD EPYC 9654 96-Core
> Processor (over 2 sockets) keeps relatively the same wall time (49s).
> 
> hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100
> 
> We can observe that the number of migrations is reduced significantly
> with this patch (improvement):
> 
> Baseline:      117M cpu-migrations  (9.355 K/sec)
> With patch:     67M cpu-migrations  (5.470 K/sec)
> 
> The task-clock utilization is reduced (degradation):
> 
> Baseline:      253.275 CPUs utilized
> With patch:    223.130 CPUs utilized
> 
> The number of context-switches is increased (degradation):
> 
> Baseline:      445M context-switches (35.516 K/sec)
> With patch:    581M context-switches (47.548 K/sec)
> 
> So the improvement due to reduction of migrations is countered by the
> degradation in CPU utilization and context-switches. The following
> SELECT_BIAS_PREV feature will address this.
> 
> Link: https://lore.kernel.org/r/09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com
> Link: https://lore.kernel.org/lkml/20230725193048.124796-1-mathieu.desnoyers@efficios.com/
> Link: https://lore.kernel.org/lkml/20230810140635.75296-1-mathieu.desnoyers@efficios.com/
> Link: https://lore.kernel.org/lkml/20230810140635.75296-1-mathieu.desnoyers@efficios.com/
> Link: https://lore.kernel.org/lkml/f6dc1652-bc39-0b12-4b6b-29a2f9cd8484@amd.com/
> Link: https://lore.kernel.org/lkml/20230822113133.643238-1-mathieu.desnoyers@efficios.com/
> Link: https://lore.kernel.org/lkml/20230823060832.454842-1-aaron.lu@intel.com/
> Link: https://lore.kernel.org/lkml/20230905171105.1005672-1-mathieu.desnoyers@efficios.com/
> Link: https://lore.kernel.org/lkml/cover.1695704179.git.yu.c.chen@intel.com/
> Link: https://lore.kernel.org/lkml/20230929183350.239721-1-mathieu.desnoyers@efficios.com/
> Link: https://lore.kernel.org/lkml/20231012203626.1298944-1-mathieu.desnoyers@efficios.com/
> Link: https://lore.kernel.org/lkml/20231017221204.1535774-1-mathieu.desnoyers@efficios.com/
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
> Cc: Aaron Lu <aaron.lu@intel.com>
> Cc: Chen Yu <yu.c.chen@intel.com>
> Cc: Tim Chen <tim.c.chen@intel.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Cc: Gautham R . Shenoy <gautham.shenoy@amd.com>
> Cc: x86@kernel.org
> ---
>  kernel/sched/fair.c     | 49 ++++++++++++++++++++++++++++++++++++-----
>  kernel/sched/features.h |  6 +++++
>  kernel/sched/sched.h    |  5 +++++
>  3 files changed, 54 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1d9c2482c5a3..8058058afb11 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4497,6 +4497,37 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>  	trace_sched_util_est_se_tp(&p->se);
>  }
>  
> +/*
> + * Returns true if adding the task utilization to the estimated
> + * utilization of the runnable tasks on @cpu does not exceed the
> + * capacity of @cpu.
> + *
> + * This considers only the utilization of _runnable_ tasks on the @cpu
> + * runqueue, excluding blocked and sleeping tasks. This is achieved by
> + * using the runqueue util_est.enqueued, and by estimating the capacity
> + * of @cpu based on arch_scale_cpu_capacity and arch_scale_thermal_pressure
> + * rather than capacity_of() because capacity_of() considers
> + * blocked/sleeping tasks in other scheduler classes.
> + *
> + * The utilization vs capacity comparison is done without the margin
> + * provided by fits_capacity(), because fits_capacity() is used to
> + * validate whether the utilization of a task fits within the overall
> + * capacity of a cpu, whereas this function validates whether the task
> + * utilization fits within the _remaining_ capacity of the cpu, which is
> + * more precise.
> + */
> +static inline bool task_fits_remaining_cpu_capacity(unsigned long task_util,
> +						    int cpu)
> +{
> +	unsigned long total_util, capacity;
> +
> +	if (!sched_util_fits_capacity_active())
> +		return false;
> +	total_util = READ_ONCE(cpu_rq(cpu)->cfs.avg.util_est.enqueued) + task_util;
> +	capacity = arch_scale_cpu_capacity(cpu) - arch_scale_thermal_pressure(cpu);

scale_rt_capacity(cpu) could provide the remaining cpu capacity after substracted by
the side activity(rt tasks/thermal pressure/irq time), maybe it would be more accurate?

> +	return total_util <= capacity;
> +}
> +
>  static inline int util_fits_cpu(unsigned long util,
>  				unsigned long uclamp_min,
>  				unsigned long uclamp_max,
> @@ -7124,12 +7155,15 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	int i, recent_used_cpu;
>  
>  	/*
> -	 * On asymmetric system, update task utilization because we will check
> -	 * that the task fits with cpu's capacity.
> +	 * With the UTIL_FITS_CAPACITY feature and on asymmetric system,
> +	 * update task utilization because we will check that the task
> +	 * fits with cpu's capacity.
>  	 */
> -	if (sched_asym_cpucap_active()) {
> +	if (sched_util_fits_capacity_active() || sched_asym_cpucap_active()) {
>  		sync_entity_load_avg(&p->se);
>  		task_util = task_util_est(p);
> +	}
> +	if (sched_asym_cpucap_active()) {
>  		util_min = uclamp_eff_value(p, UCLAMP_MIN);
>  		util_max = uclamp_eff_value(p, UCLAMP_MAX);
>  	}
> @@ -7139,7 +7173,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	 */
>  	lockdep_assert_irqs_disabled();
>  
> -	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
> +	if ((available_idle_cpu(target) || sched_idle_cpu(target) ||
> +	    task_fits_remaining_cpu_capacity(task_util, target)) &&

Compared to the previous version posted here[1], when the cpu's util_est is lower than 25% of CPU
capacity we choose the previous CPU, current version seems to be more aggressive.
it is possible that a short running task is queued on the near 100% busy cpu while there
is still an idle cpu in the system.

https://lore.kernel.org/lkml/20231017221204.1535774-1-mathieu.desnoyers@efficios.com/

thanks,
Chenyu
