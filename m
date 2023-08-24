Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3C77869B3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240548AbjHXIKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240555AbjHXIKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:10:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F1219B2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692864594; x=1724400594;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=81+Uxvt4VZ74ac7CUR8Cos7BjhFL7AWX+cXlr7kS1kQ=;
  b=esS/dVl4Fz+jaTHSmTNLj9YaYCqqDeUzzGy/X5Y/P98HnYw6PRM0jGaB
   BnNvVXFpRuqXFJdjV60KgHUr312Gl0nCcbsf5+3HHAV4PwEgzhiqBMExJ
   8qxfXIMYwqHO47CTBT741kTvQNDjn5AKgn4M5s0477VxnRimgeGs2mfR5
   b6lAl4ABO1C4PtKWTnQ+oqeIXYLQ+UIHG7z2+mm+5ggF0s54DKOsSzjUK
   woD81/WMRpjaYkMNUYsPc7rKchAqDHQjL5jJFI8IpgtSgG4mY3iOnWAdA
   m+k3I3AItb/KmoGcDworzXYutY5vKMJ/3W6JPVOa4D4Tk5Rj8g18Rn95P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="405378530"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="405378530"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 01:02:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="827035380"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="827035380"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Aug 2023 01:02:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 01:02:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 01:02:00 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 01:01:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdZP8THSZaxavDJyKz9FGPXDphyHvU9C2SXgvmZ8E7Bs6MkYISQrFsz8qatHpMFmDpV37DmOUii+o63BJxaiCL8kxnt2JMkes5Tu7TZTDm7nVJFzVAu3BfbyAFaLXAdowIoG/kHtZ7TABjp6LPo7ZeGX3B8ufqVKFWCmST8lNCZ4+7hq8JsCBd5KD+TDRcpuzAlS2ecvBvcBROANtoQsGKEz1kGWNS1g1DeuQ/+wQUuQSZ48+iklYmGMRjNPiEt86O13/zAMFpiDj4CsEpluxzT8uiY7F7Y5GCkZNpzIA8TxgBc66gw32wDKO4AKV0TLOcPiGXfrAB9uO90k8fZSXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKSx5CZX8YdKbf1RahNsPAYP+uq3hYn3T7d5Ox5JaHg=;
 b=A/W6J8737NtA8rbpVas9OOJGhvF8rlTKGBXSOQhJD2og/SzcAua1ZqoZryzH6oaEleixffpMiPvyeIla1jImKxRetHh4B7npAgeDguv3nSPzK73ZbGIsJLi6m7vKKBVKgUQ2BeaQwn/AmIvD1F7CqACZZLR+IPq53cK5xhk3uZl8B16CH0ETLMM8SXPvM/gd+wOnVuKVf3OiPptpaYXj/+XoTXvHzrFfbiDtuYrUsDf1mOblxnKXO5J1HQdqn2HVTXv8YNEiNSEROKwmYKglFFWSFgtSwoiF+JKKBBgxksD4t+oTWZ7m7DFKDTIIS4yWhXqRKZdvQvNEpEmDjvmxDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3060.namprd11.prod.outlook.com (2603:10b6:208:72::24)
 by PH8PR11MB6949.namprd11.prod.outlook.com (2603:10b6:510:227::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Thu, 24 Aug
 2023 08:01:57 +0000
Received: from BL0PR11MB3060.namprd11.prod.outlook.com
 ([fe80::b41e:473a:b81d:ce62]) by BL0PR11MB3060.namprd11.prod.outlook.com
 ([fe80::b41e:473a:b81d:ce62%3]) with mapi id 15.20.6699.022; Thu, 24 Aug 2023
 08:01:56 +0000
Date:   Thu, 24 Aug 2023 16:01:42 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>,
        Deng Pan <pan.deng@intel.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        David Vernet <void@manifault.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] sched/fair: ratelimit update to tg->load_avg
Message-ID: <20230824080142.GB459974@ziqianlu-dell>
References: <20230823060832.454842-1-aaron.lu@intel.com>
 <20230823060832.454842-2-aaron.lu@intel.com>
 <fd568884-9df4-2990-7b81-655fc7f63a4a@efficios.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd568884-9df4-2990-7b81-655fc7f63a4a@efficios.com>
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To BL0PR11MB3060.namprd11.prod.outlook.com
 (2603:10b6:208:72::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3060:EE_|PH8PR11MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b3617d-e03e-41cb-4389-08dba47862c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZpdRp+JbS9LxsgS4HzCrO259EY0XxNFBrU3qAtbZdrygLQLEc1E50CsuKgqAthgMxCARmkxd869qEx+6P+2/cR3nXI6vjqiII5+1h6x4rprGFM7/IMzdud//lxAsUcmzSqEFP+L4aLlgoY0eb+c5+MzR9zWcYsMZN6Ge+A3/VL9SIWfRtj5/WDaDx7RD6kSrhQyqs56wXyYBsMXL8nnNSYMEnSWIoUjqUgJbSThKuwfdcrJrzzz7sZKmyEAwzECHSuzFyp41Q1nGE90SKnquyzOhMThDR/okuRFFfe3iHB4NHTByfN/jxOnsUp/bRjjHF4YrgYeXS0X9VZI/D3KnKtOtsHsbiGPQ5ojJa1Db6mQM1Dj6MQP7Jz3ubH0HjbjmNXXylyteHa+h6EPaeMM5bt8BB6LNylWQ9pLOBVvEy91b1YzjMMu1Dfd540nnwMOzVlkVv/Z1cgo81P1HroqeibCIxQ5vtTXmkn1GJ/k8OlvK2EwMtNuWejsp4CT/CX+xRwtPa144BGPq9k+H0ZLVgS1BNIDOYjCEqfRwjoOdZo0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3060.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(39860400002)(346002)(136003)(396003)(186009)(1800799009)(451199024)(966005)(6486002)(6666004)(478600001)(1076003)(6506007)(9686003)(6512007)(2906002)(8936002)(7416002)(53546011)(33716001)(316002)(8676002)(5660300002)(54906003)(66946007)(6916009)(4326008)(41300700001)(86362001)(66476007)(66556008)(44832011)(26005)(33656002)(82960400001)(38100700002)(15650500001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+g3LHN/+wK2l5fTJhErKLdQTDdLVco3sfjpAq6fh/zdV0pQvAuZJInF35K?=
 =?iso-8859-1?Q?EkRpCdXQzV7z6sOPlyv7xxxUrKfparKTpjsFaHhuTkZfhRuomtDzYT3Opp?=
 =?iso-8859-1?Q?QgZm+VUoirC42pszYnNGx4PU349U9GI1RrH2gdaAv9TdO3TFp9GiRhk58Z?=
 =?iso-8859-1?Q?QwNcN/Rd44EpKwrdQh9fj0fPLb01udaTWdFSp22xlcD15B6H8P5qkCQA5C?=
 =?iso-8859-1?Q?ZSzn8ZqFH9Hk+JPmw3+N/MIQTA2EILMgvvz5Wrr9pz/OvIavkWKrhEuNc5?=
 =?iso-8859-1?Q?f/mIOWOdLkNWBjpfunMKB8Q2vwG6zf39b/ij2uvVn7lpqgPwrWC3gm0op7?=
 =?iso-8859-1?Q?csCQhW7EOQy8kiR4U08XomeniLzuGNEXaQNDjObi/HZV/fd9bCLjQb6GaB?=
 =?iso-8859-1?Q?iHNsWfbt52efV8aQe6bGIWpRucIgx14to/VZC1xoVM5leT7F1d0nboL97t?=
 =?iso-8859-1?Q?7Cx76VvyCOW5aF+ZSaZplPzHx5uIdaQkfFgRmr+wHPylqUQ5aqPb8hkWI3?=
 =?iso-8859-1?Q?ybyDiA5LUBO71K0nam6t2/ekZQBY/wg3+0Gc7HQD0qyqCPS2qYOqoWkrBU?=
 =?iso-8859-1?Q?9CQgIiTyTSw4gL/tNNRTgM6xB8sgQCOol55wPP6nhcgSYyaG3lZV+a9A7Q?=
 =?iso-8859-1?Q?3mOAQjvMXf0/y+ahFVJaATaeUaxKpyI5+lmEVJyJThko6x1z5oJZ2f56Ev?=
 =?iso-8859-1?Q?HkS97inEWnrOrpocVgtOQe4C+S6Bs3NR8Lk+/WLrbyLa7Psqoa8EKtbcAD?=
 =?iso-8859-1?Q?e9CG1KuzkYWGvkmoWneaJTIdQmuT/uBrkz8nSti55DniMwdxe/MXwuMGT2?=
 =?iso-8859-1?Q?RvMyQWeTzoLwEcLEO4pELMIvejPzPzYBMm/Hp7xGvHCUAU1HxZJGtfaIXC?=
 =?iso-8859-1?Q?LtWIJA2SkQxqXNu3xVdJJpcdfOptoB2pwYXPtrDcKGJ3RybXKVoMcR4MDm?=
 =?iso-8859-1?Q?ZeSvuw2x51cqzrccnQKrYB54DTZI/37Rq/pWtad5W/fEQC94KL85zwu98b?=
 =?iso-8859-1?Q?8Hpxcssd5U4nWNlGxvAJml9FQfI6Al773+ZSSzrM+wuw3hbUXReGEMMifX?=
 =?iso-8859-1?Q?4xzDVFsdQqygf2RU3kq/FvlPqnLwMk5so9iXvp/TN6+3VVU0UBELm8QoSc?=
 =?iso-8859-1?Q?pD/VXI/Kfay4uK8HgjTZdmVk1uAHW7mdi9dUeaJ+WIfGSImGtXoJuqvmLo?=
 =?iso-8859-1?Q?k8Rr1lhlnWkR4y8tXNLmOxJTMzt1ujqlsDc03jGhSAASO6nP7OVEYADNpB?=
 =?iso-8859-1?Q?GFWNj8DoANHrE8cfd1LrqeC4tTx7C5dou6VEX8CroAFvPnrPaHe1WjawFA?=
 =?iso-8859-1?Q?2A2osoRWr0ewdnYxJHommLIM1YCTBnxG7DPQi1SylhbehOLPyhV5sEPr8K?=
 =?iso-8859-1?Q?TFYDuFQptUGn71wzCMC6OcA/DzwmIp2Ds7hia/0a+x0sBy6igTk2ls++ML?=
 =?iso-8859-1?Q?SgM7zb61Em7z6SKONPZ8CfuW8fDg6ciHyslOXQpE18SBACGeGjD5hemM78?=
 =?iso-8859-1?Q?t9lNJjF6P9NYsrNVZQGzGB3ClKWhvQ67FI7ybu7IWjIdjS2RfXrS0l/dsL?=
 =?iso-8859-1?Q?lS+1WDLJ9etuZxMid9aNWiEjltEQ3QXggv8LPblh7ss6ye0oCbXsgAUtG7?=
 =?iso-8859-1?Q?c5zGzZM7PzE+GAi8PBOspwqJ3Ec+npQpkY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b3617d-e03e-41cb-4389-08dba47862c8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3060.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 08:01:56.7014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMdWDFsf/lxcezAZ9meGwLnLyV/qEziTpk2ku2EIcA+M0JtpheliUd3ABRxhueuNF7WSdUJYuZOAkLFWJgQ39Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6949
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

On Wed, Aug 23, 2023 at 10:05:31AM -0400, Mathieu Desnoyers wrote:
> On 8/23/23 02:08, Aaron Lu wrote:
> > When using sysbench to benchmark Postgres in a single docker instance
> > with sysbench's nr_threads set to nr_cpu, it is observed there are times
> > update_cfs_group() and update_load_avg() shows noticeable overhead on
> > a 2sockets/112core/224cpu Intel Sapphire Rapids(SPR):
> > 
> >      13.75%    13.74%  [kernel.vmlinux]           [k] update_cfs_group
> >      10.63%    10.04%  [kernel.vmlinux]           [k] update_load_avg
> > 
> > Annotate shows the cycles are mostly spent on accessing tg->load_avg
> > with update_load_avg() being the write side and update_cfs_group() being
> > the read side. tg->load_avg is per task group and when different tasks
> > of the same taskgroup running on different CPUs frequently access
> > tg->load_avg, it can be heavily contended.
> > 
> > E.g. when running postgres_sysbench on a 2sockets/112cores/224cpus Intel
> > Sappire Rapids, during a 5s window, the wakeup number is 14millions and
> > migration number is 11millions and with each migration, the task's load
> > will transfer from src cfs_rq to target cfs_rq and each change involves
> > an update to tg->load_avg. Since the workload can trigger as many wakeups
> > and migrations, the access(both read and write) to tg->load_avg can be
> > unbound. As a result, the two mentioned functions showed noticeable
> > overhead. With netperf/nr_client=nr_cpu/UDP_RR, the problem is worse:
> > during a 5s window, wakeup number is 21millions and migration number is
> > 14millions; update_cfs_group() costs ~25% and update_load_avg() costs ~16%.
> > 
> > Reduce the overhead by limiting updates to tg->load_avg to at most once
> > per ms. After this change, the cost of accessing tg->load_avg is greatly
> > reduced and performance improved. Detailed test results below.
> 
> By applying your patch on top of my patchset at:
> 
> https://lore.kernel.org/lkml/20230822113133.643238-1-mathieu.desnoyers@efficios.com/
> 
> The combined hackbench results look very promising:
> 
> (hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100)
> (192 cores AMD EPYC 9654 96-Core Processor (over 2 sockets), with hyperthreading)
> 
> Baseline:                                       49s
> With L2-ttwu-queue-skip:                        34s (30% speedup)
> With L2-ttwu-queue-skip + ratelimit-load-avg:   26s (46% speedup)
> 
> Feel free to apply my:
> 
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Tested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks a lot for running this and reviewing the patch.                                                                 
I'll add your number and tag in the changelog when sending a new                                                       
version.

Regards,
Aaron
 
> > 
> > ==============================
> > postgres_sysbench on SPR:
> > 25%
> > base:   42382±19.8%
> > patch:  50174±9.5%  (noise)
> > 
> > 50%
> > base:   67626±1.3%
> > patch:  67365±3.1%  (noise)
> > 
> > 75%
> > base:   100216±1.2%
> > patch:  112470±0.1% +12.2%
> > 
> > 100%
> > base:    93671±0.4%
> > patch:  113563±0.2% +21.2%
> > 
> > ==============================
> > hackbench on ICL:
> > group=1
> > base:    114912±5.2%
> > patch:   117857±2.5%  (noise)
> > 
> > group=4
> > base:    359902±1.6%
> > patch:   361685±2.7%  (noise)
> > 
> > group=8
> > base:    461070±0.8%
> > patch:   491713±0.3% +6.6%
> > 
> > group=16
> > base:    309032±5.0%
> > patch:   378337±1.3% +22.4%
> > 
> > =============================
> > hackbench on SPR:
> > group=1
> > base:    100768±2.9%
> > patch:   103134±2.9%  (noise)
> > 
> > group=4
> > base:    413830±12.5%
> > patch:   378660±16.6% (noise)
> > 
> > group=8
> > base:    436124±0.6%
> > patch:   490787±3.2% +12.5%
> > 
> > group=16
> > base:    457730±3.2%
> > patch:   680452±1.3% +48.8%
> > 
> > ============================
> > netperf/udp_rr on ICL
> > 25%
> > base:    114413±0.1%
> > patch:   115111±0.0% +0.6%
> > 
> > 50%
> > base:    86803±0.5%
> > patch:   86611±0.0%  (noise)
> > 
> > 75%
> > base:    35959±5.3%
> > patch:   49801±0.6% +38.5%
> > 
> > 100%
> > base:    61951±6.4%
> > patch:   70224±0.8% +13.4%
> > 
> > ===========================
> > netperf/udp_rr on SPR
> > 25%
> > base:   104954±1.3%
> > patch:  107312±2.8%  (noise)
> > 
> > 50%
> > base:    55394±4.6%
> > patch:   54940±7.4%  (noise)
> > 
> > 75%
> > base:    13779±3.1%
> > patch:   36105±1.1% +162%
> > 
> > 100%
> > base:     9703±3.7%
> > patch:   28011±0.2% +189%
> > 
> > ==============================================
> > netperf/tcp_stream on ICL (all in noise range)
> > 25%
> > base:    43092±0.1%
> > patch:   42891±0.5%
> > 
> > 50%
> > base:    19278±14.9%
> > patch:   22369±7.2%
> > 
> > 75%
> > base:    16822±3.0%
> > patch:   17086±2.3%
> > 
> > 100%
> > base:    18216±0.6%
> > patch:   18078±2.9%
> > 
> > ===============================================
> > netperf/tcp_stream on SPR (all in noise range)
> > 25%
> > base:    34491±0.3%
> > patch:   34886±0.5%
> > 
> > 50%
> > base:    19278±14.9%
> > patch:   22369±7.2%
> > 
> > 75%
> > base:    16822±3.0%
> > patch:   17086±2.3%
> > 
> > 100%
> > base:    18216±0.6%
> > patch:   18078±2.9%
> > 
> > Reported-by: Nitin Tekchandani <nitin.tekchandani@intel.com>
> > Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> > Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   kernel/sched/fair.c  | 13 ++++++++++++-
> >   kernel/sched/sched.h |  1 +
> >   2 files changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index c28206499a3d..a5462d1fcc48 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3664,7 +3664,8 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> >    */
> >   static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
> >   {
> > -	long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> > +	long delta;
> > +	u64 now;
> >   	/*
> >   	 * No need to update load_avg for root_task_group as it is not used.
> > @@ -3672,9 +3673,19 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
> >   	if (cfs_rq->tg == &root_task_group)
> >   		return;
> > +	/*
> > +	 * For migration heavy workload, access to tg->load_avg can be
> > +	 * unbound. Limit the update rate to at most once per ms.
> > +	 */
> > +	now = sched_clock_cpu(cpu_of(rq_of(cfs_rq)));
> > +	if (now - cfs_rq->last_update_tg_load_avg < NSEC_PER_MSEC)
> > +		return;
> > +
> > +	delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> >   	if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
> >   		atomic_long_add(delta, &cfs_rq->tg->load_avg);
> >   		cfs_rq->tg_load_avg_contrib = cfs_rq->avg.load_avg;
> > +		cfs_rq->last_update_tg_load_avg = now;
> >   	}
> >   }
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 6a8b7b9ed089..52ee7027def9 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -593,6 +593,7 @@ struct cfs_rq {
> >   	} removed;
> >   #ifdef CONFIG_FAIR_GROUP_SCHED
> > +	u64			last_update_tg_load_avg;
> >   	unsigned long		tg_load_avg_contrib;
> >   	long			propagate;
> >   	long			prop_runnable_sum;
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 
