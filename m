Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD5F79DE8C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 05:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbjIMDUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 23:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjIMDUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 23:20:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EC910CC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 20:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694575241; x=1726111241;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=xAyFvZrGVF34l/hmV0ZtEwH9oAaOlz+FeRVpPuZQdpM=;
  b=E8TY82XTI6nHvu3a13ZGlqKkElxPTI3l6F2OuQYLUvraiJQSMT0wDsLe
   Hqi6VGgN6al0HAE16ak+LRqFWywvmb7D40vQZyPTodMcNzOfGmCdr2qNL
   44bctwMK6HbaG6+aK6oBaMbkhHLY6tJoTMgykqfmgFM+3rYyYQX2ugHLE
   84u+tU80Qs4xKYksA8uNzJ3JUbp/f1vJyz66Ncn1gDTarPFbtXOUnlZ2a
   Z0hliR3YI99YW2FbcLxds5Ky87FobHJ5DOMDnyhBI+YjOBguv3SSonaYz
   JXHtt492MhUIYo4g8vIiKXBwN3oz2RhD9mDzoaFHxYl3fwPiXxBvKmuc2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="357983603"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="357983603"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 20:20:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="834148707"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="834148707"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 20:20:40 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 20:20:40 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 20:20:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 20:20:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 20:20:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y39w3/va6xxuNuMh+zh8GZn2MyTyCxaXOe3fn6mgToZYIWPYS5mpUkbypWP5/OKnD2TJPJEgTBb8k8Id5m3RRpsBokk6p/wZHa8PncqKOx41KuBGysDm8bvglB8DLagrjc4bRBbCs2zJYv/3JQfRzO00N5Gc2lPCntoZFKbDKAuIeh90ICYngBggFuHq5DQx4jdijJIRsto7rPCzlfqaZYoe3cVDGhn6cA106ZtJhby+2UbACtp4pycDmvtV/dec76x8Sta2N+XUNFaGHe337P0ohULuwzwFr/ganga+BjbemsynfZE/HWrMZnpbogqQKkICScLCrteNO/CRccBY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oc0dZrq5GcBveKsYJ/9VHj57OJQlPfidZ0x/bYwvT1g=;
 b=g2nPGJQLoeEo0pGs6AKnGKSISsbwmzvTkGX8WoIHNOTZOP2neke8SPnyhTrgRrWydpVpD452387ThfJa1j/IdybjdnIsQdD1yjep8Cqwjk4zAkKLpCqnMi8jT19XR7E9STp5M4OaL31MrAbH3hXOV/zpDm1CiC6Tlnw9zDVTaBWuCALows0MeTtSlL2SAjdIyPKEj8YIfPc+zSX8XkPRvVak5vtXDJvhpjXtF2hxHTQxNUhjn2u4gBTYutgKRUK3gCUGy6PbyXXChRgSehnMw/9YGdtA9e80eh0KfqJL9YUWC6RhrMqBha+0hpg69UQfLMmVbBQ7VLDW68vQVejv8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SN7PR11MB7639.namprd11.prod.outlook.com (2603:10b6:806:32a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Wed, 13 Sep
 2023 03:20:37 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 03:20:37 +0000
Date:   Wed, 13 Sep 2023 11:20:23 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Aaron Lu <aaron.lu@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        David Vernet <void@manifault.com>,
        "Nitin Tekchandani" <nitin.tekchandani@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] sched/fair: ratelimit update to tg->load_avg
Message-ID: <ZQEqd6bNOOF9SoWI@chenyu5-mobl2.ccr.corp.intel.com>
References: <20230912065808.2530-1-aaron.lu@intel.com>
 <20230912065808.2530-2-aaron.lu@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912065808.2530-2-aaron.lu@intel.com>
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SN7PR11MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 825b21cf-105b-4da2-2eed-08dbb40865ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KDlc2D2ANnSrO1rjgrQnSXsTi2dyZ55Zc+MmGkBSKEuTn4S+hxD1gPwZ8YksEWpK/6AArFypuSBoh9R7Zg5gN3aUGjvRvCyFh9e8qz+RhZSvRbClUVlSM/F6C0MedVvdnn0GmZ7sd2n3381mAjqkvCLWf3HADjW55Ie4+1p03GqDX6eucKeuiT6oEwST0jdWGq4O5QeINsoyuDb52g2g5T0jv2CwMuJTnLRgzcikgWGk2oBFhz+cyHM3OLE2hi29c29aUB6f/oLCcqoefl3Jko+1dIIQsgExBZHPFOCok59SNNqCU3MGAVrkiQsUN5IIVytSe5xkNgadQXiQ/sEMLHTs6F4fIpwiZZwHTycSNe+7EFiQobwjpTQ0MVWO4pJK/+tI3hlo0Syykqn2QmnE8DEYeLYLh/AoaPJhguXABhtMLRpHnDLrGLbec5twF+Atkecbaf3O3voZWfdhSYN0dVpixXwe+7Sz6RuUwlHZzux0pkAq/SiCWgYdpq6et7YsshTcoBn9YSH9RQcLKs63O3PsWgD+E2Zf3gG0D0ZzP85Gufqx1C4F7/XW929NwoGX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(396003)(136003)(1800799009)(186009)(451199024)(5660300002)(6636002)(316002)(66946007)(66476007)(54906003)(66556008)(6862004)(4326008)(8676002)(8936002)(7416002)(41300700001)(53546011)(2906002)(15650500001)(6512007)(6486002)(26005)(6506007)(6666004)(38100700002)(82960400001)(478600001)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?p7kXXUic9C8iuicB0QTHhwQMbBOSdIjXUydfT0tg/mt6HN0rDrX4sCQZ7l?=
 =?iso-8859-1?Q?bqP6qAQhUJgE0LGqd+9e5msTxGq8svJZHpR0mHGuc/1I8Fksow21Kj5ywB?=
 =?iso-8859-1?Q?27Z2NT6Pa+QumLhtRl+fg7aloDIfmCN85B/OJFtEvr7X4E8Vw3Cw0gFV7B?=
 =?iso-8859-1?Q?fxdUxmKKb/37lWclOm6Ir/moChY+e8QS1fG7amKJp3vgrnjpk4E9PUI9Nq?=
 =?iso-8859-1?Q?pObnAsBcHhxcHcXJuXieo6uC/iQBcI2O6q6k9evC+rKmiTkI/8vn34du3c?=
 =?iso-8859-1?Q?pNTJVXYPOpV9GVak9uo1NNTXkH5NnsyCMfF2c3koTKDrrKE8M+R2RWs3xD?=
 =?iso-8859-1?Q?mr3UPoDjCXVBwuqHKBsD2zomrSyA6pFjUebR0bSakTFjP4t04iuYGPEyOF?=
 =?iso-8859-1?Q?iFJIpW2G9jHY3LKIL7zz1RwXeU+ssmYtDSANXEgLOH/+fu8bra9bTn25OU?=
 =?iso-8859-1?Q?K89UBS/l+TfcBK0nGEkNcZG51/xqYcf0IglePoVLBVXcrGpFAUyvKSXhYx?=
 =?iso-8859-1?Q?Lcl0ndF7AfXXb8Yaow/lx7oFLqvi2IbTzg7C0wnJ5ij+BZeGl/PH9+BaZl?=
 =?iso-8859-1?Q?xnGuzp+r5x5Bb/YjEC3sDeedbHONi+OVYv1tpAkw9l0GnPgVomdeWTJCgs?=
 =?iso-8859-1?Q?huPBLT2ZEnr5k9tR5R04Xtt6pv/yShcsanFXVH58fJpbZN1xc6EB2p0s5F?=
 =?iso-8859-1?Q?48IrmMOTtjBlHnbLKgEUM9jdWbfHpkSPT37F932zrtoU2zqctRkl2ChpmP?=
 =?iso-8859-1?Q?/hhUW05kPkENm8QBw44oq5Zyi7881j6hveVfUyN1E+OTqb4q49UBRaXZzZ?=
 =?iso-8859-1?Q?PnWfXmq1xlh/al8oVdOsd5xwl2EvnP177sN2UnFmAmg1RqSNJwxWHJavr4?=
 =?iso-8859-1?Q?Qxlgr3SyF0Ng9t5nh2/zGWC8bIwwpU/355z9Oep8YWGkWnPgRGOUcnYiW0?=
 =?iso-8859-1?Q?/ZPfBpGLhiw0cBtKWK5wMTa+TG5uWIYZwuGScmnmgCS1qs0tXNoIQGIjRO?=
 =?iso-8859-1?Q?c3gf/y9P68iCqfn23ZPMJhmt8bKhM22EG/XDjiWvy01HEg+sShjNquwbI/?=
 =?iso-8859-1?Q?I6oLdq9mgG+3P1yt+Yd6dWTZ0/ZqBewJ3r8yg6Z4Ux0+891UIsSlyqUfZ4?=
 =?iso-8859-1?Q?At11SJU2+oNXuKqS1JQQ1EtnqT7upOaMPpKL47nZefHmz81FsxKDjaTW2w?=
 =?iso-8859-1?Q?YaL+0CmDyooQkE25RczoUa8/WZDV0bz+rHx4gG9WunRYlmRlnCBidjc/a+?=
 =?iso-8859-1?Q?cnMSrmHvsCX+ZbT2jVwgBd31PS9dAH9dlX+xNR3aZt6M1HIHAdKKL5NOZu?=
 =?iso-8859-1?Q?RgGiWq1NryTCydIqtNcSX5sWRbLzMFlaOJk8WayglmMwRfXyrz70gMcjEQ?=
 =?iso-8859-1?Q?DOWyemVwz4whdF4FqthgM7IKkqfqEyPRdENvGY8T1ubQ0kIwMzRcxZ3pyf?=
 =?iso-8859-1?Q?B3TgCHzfBb54SB8a64KLa1N6JsqTyQuIMx+yAc2R4BahgE72BdbQv5KY2/?=
 =?iso-8859-1?Q?TWucoDm4E2DGkvbMihqE1Bhc7jx/h4V9f6N2IhOmlHF7WRvBLa453cu61i?=
 =?iso-8859-1?Q?EwCYn1BHhF2V4jEzolAh2+uUgLQsJr1e+eyodkeS4C6dPbMG2AeZF6D+tM?=
 =?iso-8859-1?Q?ohW1KSd/29qPpR11drUI+L3sjxHuJ5YJDg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 825b21cf-105b-4da2-2eed-08dbb40865ff
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 03:20:36.9412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +MEtcWt4lpDTODpPQdLm4M8pWyCS5kpmqRPPLrsUrE5Rh7RsGS7wxyQq8l/Zh5RLh9ysF6bs8HpNykT7KASLPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7639
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-12 at 14:58:08 +0800, Aaron Lu wrote:
> When using sysbench to benchmark Postgres in a single docker instance
> with sysbench's nr_threads set to nr_cpu, it is observed there are times
> update_cfs_group() and update_load_avg() shows noticeable overhead on
> a 2sockets/112core/224cpu Intel Sapphire Rapids(SPR):
> 
>     13.75%    13.74%  [kernel.vmlinux]           [k] update_cfs_group
>     10.63%    10.04%  [kernel.vmlinux]           [k] update_load_avg
> 
> Annotate shows the cycles are mostly spent on accessing tg->load_avg
> with update_load_avg() being the write side and update_cfs_group() being
> the read side. tg->load_avg is per task group and when different tasks
> of the same taskgroup running on different CPUs frequently access
> tg->load_avg, it can be heavily contended.
> 
> E.g. when running postgres_sysbench on a 2sockets/112cores/224cpus Intel
> Sappire Rapids, during a 5s window, the wakeup number is 14millions and
> migration number is 11millions and with each migration, the task's load
> will transfer from src cfs_rq to target cfs_rq and each change involves
> an update to tg->load_avg. Since the workload can trigger as many wakeups
> and migrations, the access(both read and write) to tg->load_avg can be
> unbound. As a result, the two mentioned functions showed noticeable
> overhead. With netperf/nr_client=nr_cpu/UDP_RR, the problem is worse:
> during a 5s window, wakeup number is 21millions and migration number is
> 14millions; update_cfs_group() costs ~25% and update_load_avg() costs ~16%.
> 
> Reduce the overhead by limiting updates to tg->load_avg to at most once
> per ms. The update frequency is a tradeoff between tracking accuracy and
> overhead. 1ms is chosen because PELT window is roughly 1ms and it
> delivered good results for the tests that I've done. After this change,
> the cost of accessing tg->load_avg is greatly reduced and performance
> improved. Detailed test results below.
> 
> ==============================
> postgres_sysbench on SPR:
> 25%
> base:   42382±19.8%
> patch:  50174±9.5%  (noise)
> 
> 50%
> base:   67626±1.3%
> patch:  67365±3.1%  (noise)
> 
> 75%
> base:   100216±1.2%
> patch:  112470±0.1% +12.2%
> 
> 100%
> base:    93671±0.4%
> patch:  113563±0.2% +21.2%
> 
> ==============================
> hackbench on ICL:
> group=1
> base:    114912±5.2%
> patch:   117857±2.5%  (noise)
> 
> group=4
> base:    359902±1.6%
> patch:   361685±2.7%  (noise)
> 
> group=8
> base:    461070±0.8%
> patch:   491713±0.3% +6.6%
> 
> group=16
> base:    309032±5.0%
> patch:   378337±1.3% +22.4%
> 
> =============================
> hackbench on SPR:
> group=1
> base:    100768±2.9%
> patch:   103134±2.9%  (noise)
> 
> group=4
> base:    413830±12.5%
> patch:   378660±16.6% (noise)
> 
> group=8
> base:    436124±0.6%
> patch:   490787±3.2% +12.5%
> 
> group=16
> base:    457730±3.2%
> patch:   680452±1.3% +48.8%
> 
> ============================
> netperf/udp_rr on ICL
> 25%
> base:    114413±0.1%
> patch:   115111±0.0% +0.6%
> 
> 50%
> base:    86803±0.5%
> patch:   86611±0.0%  (noise)
> 
> 75%
> base:    35959±5.3%
> patch:   49801±0.6% +38.5%
> 
> 100%
> base:    61951±6.4%
> patch:   70224±0.8% +13.4%
> 
> ===========================
> netperf/udp_rr on SPR
> 25%
> base:   104954±1.3%
> patch:  107312±2.8%  (noise)
> 
> 50%
> base:    55394±4.6%
> patch:   54940±7.4%  (noise)
> 
> 75%
> base:    13779±3.1%
> patch:   36105±1.1% +162%
> 
> 100%
> base:     9703±3.7%
> patch:   28011±0.2% +189%
> 
> ==============================================
> netperf/tcp_stream on ICL (all in noise range)
> 25%
> base:    43092±0.1%
> patch:   42891±0.5%
> 
> 50%
> base:    19278±14.9%
> patch:   22369±7.2%
> 
> 75%
> base:    16822±3.0%
> patch:   17086±2.3%
> 
> 100%
> base:    18216±0.6%
> patch:   18078±2.9%
> 
> ===============================================
> netperf/tcp_stream on SPR (all in noise range)
> 25%
> base:    34491±0.3%
> patch:   34886±0.5%
> 
> 50%
> base:    19278±14.9%
> patch:   22369±7.2%
> 
> 75%
> base:    16822±3.0%
> patch:   17086±2.3%
> 
> 100%
> base:    18216±0.6%
> patch:   18078±2.9%
> 
> Reported-by: Nitin Tekchandani <nitin.tekchandani@intel.com>
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Tested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Reviewed-by: David Vernet <void@manifault.com>
> Tested-by: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
> ---
>

Since we know that this patch brings good improvement for netperf,
hackbench, I did some further verification on tbench/schbench on Ice Lake
Xeon Platinum 8360Y, and it reports good result too:

schbench
========
case            	load    	baseline(std%)	compare%( std%)
normal          	1-mthreads	 1.00 (  1.70)	 +0.00 (  0.00)
normal          	2-mthreads	 1.00 (  2.32)	 -0.62 (  5.24)
normal          	4-mthreads	 1.00 (  3.17)	 -1.86 (  3.11)

tbench
======
case            	load    	baseline(std%)	compare%( std%)
loopback        	36-threads	 1.00 (  2.80)	 +1.85 (  0.45)
loopback        	72-threads	 1.00 (  0.27)	 -0.20 (  0.51)
loopback        	108-threads	 1.00 (  0.06)	+21.92 (  0.10)
loopback        	144-threads	 1.00 (  1.47)	+28.42 (  0.11)

Tested-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu
