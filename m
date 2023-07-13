Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FB6751AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjGMIAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjGMIA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:00:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36993A8F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689235166; x=1720771166;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7rd4LMy2k2LqGQia4jhCZ5Eaq3463sQzbvvRb++1VkE=;
  b=eaCUqAQjONc/BXkYJxRk9sfLXpDAhpyBc5no+18jfDDidkfBJN8m84ef
   /dbVDFCH/fsxj2l5o7XXuy1z0meoQgo9WIZ70IFnY4rucVyoI+VTuxPce
   oBr1J12xTaDdGgDu97Th6J2LE9qxjyJxQW7wUhMa9/HaQSYnyibMIRzI0
   6uF2l73twmnmO9KKvY/Rie9tDIodKgRGf4eajxwgE3LvrChesEV5glceL
   mkuQQAteKqVHWApUh04sAQgvmBdGs6cfJixPbQCx2FQNucyL7UnFGkWvM
   Jr95gRhoTeWag2jCo+2ZhqSP8jAszfF8lCxquPGxPQk03exvm1sJUB8Kr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="365153569"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="365153569"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 00:58:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="725207819"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="725207819"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jul 2023 00:58:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 00:58:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 00:58:46 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 00:58:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPEprPl05Dqew0HQi4VpXYnfc0FGWS8GMELEHNogo99TvdBgvBfpu0Ta32+zF0WiYpRV6llKX3laRkao1B4JnRFfuoThoXKbwjYToCNw+/L3ItPk5fvGxNDSSSRSC0DppVEx/t3LhZ9Q22/WVMHK1/+rfot9dsxcl/M2Mt38l6E1cYPGI83iIRmxB2pVnu8ufRoNDAJwdXyLlLwFEcDD8Ugv/O57tuujiWqeDqXUfHLxanMLykMm8oMY6Dk8bMPvFfORxxSokwPdipA3B2S4TlaKt3pqDmBQgarRm8SZy4Svl1OsXE1tZ06wCiLPg6BxKzlDi5Y70WX5Nnlk5VE2qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wf0thsQ5mdInCCTPUB3uya/SV7rFNxiuUwIbgYg/5IE=;
 b=BVIQA2KjZZf4M9+pktUviJdrQhxMgn9WTImcq2ILtqlLINIkiJTViGPoRp9dhaoOzu3KM8DP5P3JjRiO9rjjEBrNcaCiLEZIgXtU43emV0TuGZLUEdURAu6lQY/qavI+WbzMuEss3IsN5lEvz/QFruY7R4AQ4S5IIZNX3LF0LybCpMrewg4+EBls+xLxrLmMnYP32g6glfcmUTdnJJHw/7ViFwkUTgzx70aAklCVZNt/OTnOA3uToxgwUxgwbTy3udKH8ICmEDa7DGCpo7TPwI4rboP+pxCPUqlNV8f10vNQiOhQTOT2hNhmozmIwWZSpCt0JGOGR6LBrwEU/hLObA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3060.namprd11.prod.outlook.com (2603:10b6:208:72::24)
 by PH8PR11MB7000.namprd11.prod.outlook.com (2603:10b6:510:220::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 07:58:37 +0000
Received: from BL0PR11MB3060.namprd11.prod.outlook.com
 ([fe80::db99:965e:7f58:a552]) by BL0PR11MB3060.namprd11.prod.outlook.com
 ([fe80::db99:965e:7f58:a552%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 07:58:30 +0000
Date:   Thu, 13 Jul 2023 15:58:09 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     David Vernet <void@manifault.com>
CC:     <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>,
        <gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <clm@meta.com>,
        <tj@kernel.org>, <roman.gushchin@linux.dev>, <kernel-team@meta.com>
Subject: Re: [PATCH v2 5/7] sched: Implement shared runqueue in CFS
Message-ID: <20230713075809.GA24959@ziqianlu-dell>
References: <20230710200342.358255-1-void@manifault.com>
 <20230710200342.358255-6-void@manifault.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230710200342.358255-6-void@manifault.com>
X-ClientProxiedBy: SG2PR04CA0208.apcprd04.prod.outlook.com
 (2603:1096:4:187::10) To BL0PR11MB3060.namprd11.prod.outlook.com
 (2603:10b6:208:72::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3060:EE_|PH8PR11MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ff335e-7f85-47c2-f4a4-08db8376efd8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0hxR5VBr8/X6BWxdCsov9JmT6fBGW+V3qiFh+9Ie6utgUGiXd9xyrsL1V0tXL3QcpK/W6zdIeIC51I/l2fxWp4LcbnBk+sD33iTKcjl8eKJTVym9WwJKGsSuMscCz3ZAwz9gFdW0S1VuTWEHsrcA/DXg8q/DXPJqxryxB5CYtkUjPYIQgjgq3DbZ1QwL2K/aACzYKpZu82T+0p+wsVIf6t7cPPTRwFT1XCN581wP5cYAVpInuTI3j9hBH2D4UM9MqjkOLhLUsojl5+YcEtz4Ldc7rkz3aFx3hM2fLUo9LGEfIveuxXLBLCmm0DBjtcRKTArbzYpmOcQUXnJz4SL7+F0u7Rj64ukbVFVZCPB9Kf8yBqcbKbu+U4arJxQzI+52IZ4kR21wuhlZ8+Mawd7h0Fq9LY1tCxSbu5kY8yUPNuVkCRP+bQsv6MYlpPb133nvFAKGNAyc6VqYhWUWfO5giAbFF5/kOiQ4vXpMmUZ3VwlTfTtg7umKIk4nIun3qBcfvqeFwxYOIZl9LmrMZwCCYLCZge4YqeJniQOqiC8+op4sBVUHYGA0b10KKb8u0fz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3060.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(86362001)(8676002)(8936002)(33656002)(186003)(4744005)(2906002)(5660300002)(7416002)(44832011)(1076003)(26005)(9686003)(6506007)(82960400001)(33716001)(38100700002)(6666004)(66556008)(6486002)(83380400001)(6916009)(66476007)(66946007)(4326008)(478600001)(316002)(41300700001)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DtLT+mW+zMjTyHoLg5Xg0yXqynP7uRSJrlvqKd/4Y19JpAtwyFSyn2SKwUhq?=
 =?us-ascii?Q?vUddQtlF79s1bgEg0kaW8Eb2MhuEykDjIn17a0rW+v1K7hFhzCu4oOZBv0bC?=
 =?us-ascii?Q?oBYC0dCTkbbfnaPVx26mHmWMpP7GBoF0eJZ15e+IphY06noz+Dd0LbKxj2d0?=
 =?us-ascii?Q?kjdWcatoVEEXM0ceENe9WaYC1x+xOh8+ASvuRAZRsYNdCjqh8cIMwiFzI4vI?=
 =?us-ascii?Q?KZBrJbnbh+Gigk86mf3JsTvicLzCXn0kGlMuj+ZoIdYI2Aqa8tyJ8zduRQDp?=
 =?us-ascii?Q?tjd5QbvDxAIRAY5yzVXixn0RJCr0wXZ09oQ48pSVO/oACfykQi8jDr+s3CYY?=
 =?us-ascii?Q?x8EjOM87N9Jze+lAqLkGWpH6PrjM9NgT/6YY93tuZqD8cOEpeQbd0doTsyer?=
 =?us-ascii?Q?CqAS+9RrzIiQF41pz/rm0y8RIOsRLph5HeeKeKdzSJQ8wRdV/HI2JH6QMh3Q?=
 =?us-ascii?Q?JynjNdVZ+iDSy0tNEMLqWbI5F1sPocRLRmGjzjlxyt4arDwN6fzZFScA3S8V?=
 =?us-ascii?Q?Qa2HL2dx4ICrWjggrEfNVxxakG1CKW+p7YXEtl1PouepnOxikFaPLsNK3MgY?=
 =?us-ascii?Q?hTtHmjR0fgpZIjWiHMsC4SjvP1ddKikrU1wCWVppz8GqmglXVe6z1nSbHl/g?=
 =?us-ascii?Q?ts+oQWXTe1KJJpSZxQaWqx/HKfsW9A9qI2bOjNkSqdYNp0wL9BH1QNfcgjwx?=
 =?us-ascii?Q?93XmOZ0JcsiH79rx9+VHNbOWbiRowWv2Y8fwHD5OkOvcbhIs7Ue/etCx4nZq?=
 =?us-ascii?Q?MmRnT6kg47yHpLT8ZDMrNAJV7F6leqLJ8c6DNLkT3i0lr8OeaprMr0jYiYXn?=
 =?us-ascii?Q?p4cEke2cSk2pkdYbpHuKp2cWHHgc6sQGVPEefzUUINnGDzcxY5yVQwZblnA9?=
 =?us-ascii?Q?hdEtPeKnS8vSYIpIvvFGca7v1dmxAKkhELd3vLTnRkXRUBm0RF/vdhH6MMUO?=
 =?us-ascii?Q?C9sBYLj2lGaQ0BF8SyL5IwNPKGXQ7XBz2WQfPfGrq4r9TxjkXvZ4KOyvMdLb?=
 =?us-ascii?Q?A9mDdn4XBeJcPGaJJ05cswXTKor8UjcC4LVHH7Sdfe6vJntDjRiIKgLAe9bD?=
 =?us-ascii?Q?ju2bFtXtUaNxc7iayOnqnCOuzeKMKLmvFWUAuR5IYQ/GT3S4BBScrnvus3L+?=
 =?us-ascii?Q?2foIjeiIR+4alUBaQJ6dXCI6DgwQePfjES8H0tHqXEhjG3E8PHxE9k172/Fd?=
 =?us-ascii?Q?0SqU4YeAs4eIxcRL1+JQkDlwtIqbhBr8yIunwX3+T+6OYyzRGdAYcRg0d368?=
 =?us-ascii?Q?/Z03hNbJtxhLJlFim1jzggttXLmfnhfH9/3OJPNfy3oCp39QrC76NbooWue7?=
 =?us-ascii?Q?ND8vv6dkkvNeIUD6kZFmFqXvnK20Pvc5O6GZUxdBmUjSoc7ZxWZwOLB8igIf?=
 =?us-ascii?Q?K5R0mHR/APe76PlPsXrQXT4WuAHpyMUOiXu+T7JSU9QhCTcK0Y8l5eV4jh6v?=
 =?us-ascii?Q?xotlVPZbllzx/i7/baP2Y8QI6O0B2NX2saalybIbVbkVfVgw/K7R60vftI++?=
 =?us-ascii?Q?b+6qjHCh1/TGCt85IUiv+qOid046L/CCw1mR0TKFHoJCzjxNObuddjkIYrKW?=
 =?us-ascii?Q?FEVesP/KpeKT/WycxANpX90ee5p1WqGoV1IeluKS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ff335e-7f85-47c2-f4a4-08db8376efd8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3060.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 07:58:30.1544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qlXI0w0eaUJFWuch8YwK/JmRrZNnBEa3xJ9m5oVQytVGoDmZa87A6LK1IeVFdax+L8XI5tUK5PfU6Tx3wrhxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7000
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 03:03:40PM -0500, David Vernet wrote:
>  static void shared_runq_dequeue_task(struct task_struct *p)
> -{}
> +{
> +	unsigned long flags;
> +	struct shared_runq *shared_runq;
> +
> +	if (!list_empty(&p->shared_runq_node)) {
> +		shared_runq = rq_shared_runq(task_rq(p));
> +		spin_lock_irqsave(&shared_runq->lock, flags);

After taking the lock, p may have been poped by another newidle cpu.
Running list_del_init() doesn't seem hurt, but is this intended?

> +		list_del_init(&p->shared_runq_node);
> +		spin_unlock_irqrestore(&shared_runq->lock, flags);
> +	}
> +}
