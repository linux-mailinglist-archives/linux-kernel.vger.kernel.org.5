Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403AE7B3EC5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 09:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjI3HML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 03:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjI3HMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 03:12:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865E8FA
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 00:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696057922; x=1727593922;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3qpHjAb1kaVXdWVUQnWnJrrK4D1NSLXDKpAsv7FFD+Y=;
  b=DznoQI5nXC+PVupj7s8EhOoqGSowRBCN3OBJz6i0Be+KGSviZNmxiwv4
   gfzropJYqB25PpbCYII/+9krWxTwJbDHdXwn8U56EfMB1gq+rdN5rJGeE
   nEx9xJGgN6fhnPBt6mX7V146MlqcICpOcEL5Yzpm4jp1kbDA3wR0FhDDp
   udzYP9vaD7iK7cBLVxGO1XGa2oLEl1GIBfcUagCtAkKF8B7ILMiRoE//t
   585TUzzmHYnS4C2yXWWaN5NHvYLTTvVZAJ4527j5FFHTwrO+L7/7tHbYb
   y9TFMYlyKrBqdu0p5+jbzFcsds91xFdtExFyPbkPNAVsDgFgM3g9RhdrT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="468707059"
X-IronPort-AV: E=Sophos;i="6.03,189,1694761200"; 
   d="scan'208";a="468707059"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 00:12:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="923783141"
X-IronPort-AV: E=Sophos;i="6.03,189,1694761200"; 
   d="scan'208";a="923783141"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2023 00:12:01 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 30 Sep 2023 00:12:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sat, 30 Sep 2023 00:12:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sat, 30 Sep 2023 00:12:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYt1mxwNJVNv8VKWGiOjPEgOJauCePnVL0R5mhOn6K8uthyWSgv15CgC/Z2VyPFmSbSZpTPMgGmzgVp9cu45ka7X4TjKQ5OCv54FyV9OJbQ78fXELR029nCK17ekA8LLYwnEkHqweDTJeUba7SP5OAHang4u7DxS/dfaxYyR/7UUsNyMZTWh7MLB+2LHG9dg58k/U+St1w30Bv9D+wFlpvGqtivvNr5flq8+rwUCPsIHEdqTSNAgtvs+OTtVJOzOrUqC48oQKdmYjXCQvt7Lwg19xSyn4vfrLHT3r9byA++hG73/vBp/OCw0bQonPssKNvS0OpWp/OjvDh3Ax2kgaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJMDxLNFZ9mKkyo7i/wxcdllqjXgWfz+f/Dx02s7toc=;
 b=Bj5Uocn4/Jfnck15sWnnOhCA6nixhzrIOppUCBkmEFTDHv5yVTI76bFXo3aE9rEi+LKuVzm2SS50laOs1oM0k+yI9WqYDAqX7pFCmWz1l7/BY6ZRmqDLX2bcaYBEiMracktYL100l8P+d9PIENm8F7FNoZeZU1NDdk9hGuQQ1Z9/56Q94ag7q3Bc+ytkd8eh7gRUTjeeiBPkOji/tKqXQxG8lXy6mdeNZ6DHgWOf6xhKFhlIxX1LmpZ6MLhJLiXAiRAU6Uqm4KXiP9DpY5ufS0nzKm8qJV9DI2lcX1Ib7w0Z7Xh0guDe4GPBr5gMxMFeEzFx8NaYgva+mSgIUqKRwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by BL1PR11MB5224.namprd11.prod.outlook.com (2603:10b6:208:30a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Sat, 30 Sep
 2023 07:11:58 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%4]) with mapi id 15.20.6813.017; Sat, 30 Sep 2023
 07:11:58 +0000
Date:   Sat, 30 Sep 2023 15:11:39 +0800
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
Message-ID: <ZRfKKxBzfu+kf0tM@chenyu5-mobl2.ccr.corp.intel.com>
References: <20230929183350.239721-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230929183350.239721-1-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: SG2P153CA0026.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::13)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|BL1PR11MB5224:EE_
X-MS-Office365-Filtering-Correlation-Id: f0dedc22-33a3-401f-7e74-08dbc18487d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0MZWGMS1sK+7O968wgEcuBzeOL/kbHGMEfwTw9Zh03popCxP2+fqrk449uoxruhqlDooqM+/+FXU+cKkwxHGaCmPPXUQKPgOpP0WgpFsN07uTh8twbuyyNvikGd6KuReC6yuwAhLiOlLpZW4O3TZqdUWQrdXPGVo+yReC6RTFz1aZAeBjI1GFj5AmXpJEuYWzmHHOWwkhdxlvvWpkfhtLK7NoG4BfPWAqAih4u+pQMvRw70jETIoZnFSNKNq3TiyBG8oa83HLoK3jCqDhPQilSYM8bf5uIG1wb4b2HKdnbFODJOxpsWlyI/SaHMl/9IoXRN3BCFhmoDWNfNu6GXfi/3z/eKD5dtGapRmVAwIgR/+AyVx3Q/y05UPFTYOc3zXeh5nHj5Qn0FRAYlE+OyrJ2/U4wc9A4p5qIzxDZr7ym/21h/bZV/1R5dvgz4XnwB02K6OJ84KvCn8veW/KuUCqSifptYtecPOonlfZ+4w1f+dbE7oUcxY6z/spSGqUIYv+iS2PCj071fSqNBIg93CZ2ZdspaCKbJaVi+KIQjACDd5Y/Z84zjKzfwwi7xJDjIdd4+fHcQjhQJe9YGP+F0AikrZjRjA8W//FigXTucXCcZzPzDWMLGdRV08colrcO8KVNjmi4Xwapd6QeTWpkeDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(66899024)(26005)(82960400001)(38100700002)(86362001)(83380400001)(316002)(54906003)(6916009)(8936002)(8676002)(4326008)(5660300002)(41300700001)(66946007)(66476007)(66556008)(2906002)(7416002)(6506007)(53546011)(6666004)(6512007)(6486002)(966005)(478600001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A9U+AEC0XEjhaeLdFOuASM3nmW/EbmHC24fZPZFj6NdlX/LtkmcBnarSExHX?=
 =?us-ascii?Q?mIYKHeL+C0YV9zMg09ceihDeHl1/P7n+Ghpc3Z7HIbDQbdYc2m1IthdQf4PH?=
 =?us-ascii?Q?gI+smkN/Ki3g3MmgBUzkRkMPaMKvz2X8vVxCxlK8G8r9tuIE+LMueKEny5KN?=
 =?us-ascii?Q?1HY+WiyEoUKvWZ8efFbj+dPN92PaATcYiSAvUHVThBanVNMZHYBPzGBzauQQ?=
 =?us-ascii?Q?/CNLup41MyodKRfKCcNDRXYtYw5g4xVJBDJxOw1Kw502y8LZu8BCW0bFoTtx?=
 =?us-ascii?Q?LJvADvgY3r+XSx4V+tQd+/Zq6ZTp+u7yEXx5J8r7heMZ02HwJfsFIwwRZIYh?=
 =?us-ascii?Q?UK8gKjfc9s92+zx3EnaCJuHP7SqVQuuPgOAaOq+OaMFQqhQdlTqg5O0UwdwK?=
 =?us-ascii?Q?ncSxCjxIjbzYX4TAP/YIRIyep6PwaJvYHQR1fhZPF5jIhGKVBZQoviQwkl5c?=
 =?us-ascii?Q?Mq8MRQtWhle5AG/Gh3zSQl2ybC4dIMXHs8YoDr+hevky2Keu1FYqW/nrdfGI?=
 =?us-ascii?Q?x/l7D970ifcmDI6GjtrLdkWOTODHbe5YL644xOCuZuoQgRm1J5lBJsTYedCw?=
 =?us-ascii?Q?fnAY96zejQNR7B34o/uAmbDRoOgtGIKCgYbOX/GmFEfJnRs7xoHkjstvjeQU?=
 =?us-ascii?Q?eZamKFM+/CBC3tTsZsoyJT6FoWRFLbX/xMfjs7Sb1JUtdtfXHfM6crLjbOIB?=
 =?us-ascii?Q?/i6lIVpxZ7akT5GuvcOWAAKFtgJXIdoJs+Mw91EeHWOddYjF8rwnTV7txVhb?=
 =?us-ascii?Q?E2SE2EpyPTOzVzSs23QgXvRo60/lRubMONV/D8l6lMAQmMWfgAYjwzsRoE7o?=
 =?us-ascii?Q?J+1YT16TyPy5hcNOnTLn9veNixh2j9fLPA8hWUVcU7wwYa4V5WUDqhbpu5va?=
 =?us-ascii?Q?oaC+YeOeq3PlMqi8FkM+jPzWC848YXEHJ9Ba5AwJ4GwZmUR5dXRZpQc0S619?=
 =?us-ascii?Q?8z3bQc2VH6IUi3Gl84uGQ0MSVkBg9OvqEJbp1XJjJjP0ZWvGxgFvQgLD71My?=
 =?us-ascii?Q?MtrTWKA0owWyudgZ/pIgRZ2xNC5HSj4vFqt/E36UkQhjEq63+3P4ceAkQwZE?=
 =?us-ascii?Q?iKvS2NtWuvJBbkiBgb4AW8hTPoGM/6A233NKZWcT+mWVKfGHzJg7+35Jj/wp?=
 =?us-ascii?Q?SQGSv41baDqcklDnwfZ1GMA8lHO9PHj72tI+RL6+n0pON3oF8+rrpmiN/2SP?=
 =?us-ascii?Q?8qStQEXeNYYlUWeNTV5Sv1Yls0N70RsYQTfys5HAlrL6VleDQ4ROV8K6oBFf?=
 =?us-ascii?Q?UG8r/UPHQ7BtsCM1eNf3o9oGZvB/HcMTgjBa0agx4aRoA3w+0S/dolQ7a1T8?=
 =?us-ascii?Q?xQb1oVkJcDntoI5g3gtvVYsWsyImFBNtw4y0n1PsFIZAcQJ5HUoHlEumeork?=
 =?us-ascii?Q?1H6+Kqlu2C9czjp0OU5/LdJjf6aZOvPkoRH8s9rCw4ABjL29pbhl1/DBUBWn?=
 =?us-ascii?Q?I/R11qSeoKbHqpjEAO/mTaO3zTRVBOKOkNmHY7eqDrD6wjtLj3KV+I/3AH9r?=
 =?us-ascii?Q?eG657z/pEY0v9tkHNgarHd6EwN8ir8qHjTv++4WVnt8iCFCdMLVvMurP5h5+?=
 =?us-ascii?Q?KLWVRLHSVD8egu7fGhcuE69hd/5c5BR6CYKvvgEl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0dedc22-33a3-401f-7e74-08dbc18487d0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2023 07:11:57.1557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQg+UKSfaygwoxCy74lLa5+aa4aeXq8AX3CMZIIxPC1Y9uQBqsolRw5RKV6bSfWlfwhl4ABa5Bu2IXb4vm4CRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5224
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

Hi Mathieu,

On 2023-09-29 at 14:33:50 -0400, Mathieu Desnoyers wrote:
> Introduce the WAKEUP_BIAS_PREV_IDLE scheduler feature. It biases
> select_task_rq towards the previous CPU if it was almost idle
> (avg_load <= 0.1%).

Yes, this is a promising direction IMO. One question is that,
can cfs_rq->avg.load_avg be used for percentage comparison?
If I understand correctly, load_avg reflects that more than
1 tasks could have been running this runqueue, and the
load_avg is the direct proportion to the load_weight of that
cfs_rq. Besides, LOAD_AVG_MAX seems to not be the max value
that load_avg can reach, it is the sum of
1024 * (y + y^1 + y^2 ... )

For example,
taskset -c 1 nice -n -20 stress -c 1
cat /sys/kernel/debug/sched/debug | grep 'cfs_rq\[1\]' -A 12 | grep "\.load_avg"
  .load_avg                      : 88763
  .load_avg                      : 1024

88763 is higher than LOAD_AVG_MAX=47742
Maybe the util_avg can be used for precentage comparison I suppose?

> It eliminates frequent task migrations from almost
> idle CPU to completely idle CPUs. This is achieved by using the CPU
> load of the previously used CPU as "almost idle" criterion in
> wake_affine_idle() and select_idle_sibling().
> 
> The following benchmarks are performed on a v6.5.5 kernel with
> mitigations=off.
> 
> This speeds up the following hackbench workload on a 192 cores AMD EPYC
> 9654 96-Core Processor (over 2 sockets):
> 
> hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100
> 
> from 49s to 32s. (34% speedup)
> 
> We can observe that the number of migrations is reduced significantly
> (-94%) with this patch, which may explain the speedup:
> 
> Baseline:      118M cpu-migrations  (9.286 K/sec)
> With patch:      7M cpu-migrations  (0.709 K/sec)
> 
> As a consequence, the stalled-cycles-backend are reduced:
> 
> Baseline:     8.16% backend cycles idle
> With patch:   6.70% backend cycles idle
> 
> Interestingly, the rate of context switch increases with the patch, but
> it does not appear to be an issue performance-wise:
> 
> Baseline:     454M context-switches (35.677 K/sec)
> With patch:   654M context-switches (62.290 K/sec)
> 
> This was developed as part of the investigation into a weird regression
> reported by AMD where adding a raw spinlock in the scheduler context
> switch accelerated hackbench. It turned out that changing this raw
> spinlock for a loop of 10000x cpu_relax within do_idle() had similar
> benefits.
> 
> This patch achieves a similar effect without the busy-waiting by
> allowing select_task_rq to favor almost idle previously used CPUs based
> on the CPU load of that CPU. The threshold of 0.1% avg_load for almost
> idle CPU load has been identified empirically using the hackbench
> workload.
> 
> Feedback is welcome. I am especially interested to learn whether this
> patch has positive or detrimental effects on performance of other
> workloads.
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
>  kernel/sched/fair.c     | 18 +++++++++++++-----
>  kernel/sched/features.h |  6 ++++++
>  2 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1d9c2482c5a3..65a7d923ea61 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6599,6 +6599,14 @@ static int wake_wide(struct task_struct *p)
>  	return 1;
>  }
>  
> +static bool
> +almost_idle_cpu(int cpu, struct task_struct *p)
> +{
> +	if (!sched_feat(WAKEUP_BIAS_PREV_IDLE))
> +		return false;
> +	return cpu_load_without(cpu_rq(cpu), p) <= LOAD_AVG_MAX / 1000;

Or
return cpu_util_without(cpu_rq(cpu), p) * 1000 <= capacity_orig_of(cpu) ?

thanks,
Chenyu
