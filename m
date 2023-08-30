Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CFE78D346
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 08:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239115AbjH3GSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 02:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241208AbjH3GRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:17:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C102CE8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 23:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693376262; x=1724912262;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nP9dRD+djrVP2BcznzKWxFXej0f3ztVYXXvciKo7rxQ=;
  b=J10gDo7g1AlH+9xh8qZPB8GW0gzajd/0UJNrhGASxgoLAmJk3dFStswJ
   G1cK9TkldDY8vVmdOqOnm0ZSbaADFJa+VMeXZ3MXKXbWYHegBmh7M+4I4
   +sI3AiQceKnWYtNCEMsQMIF+LvJvy7lcXjg/3px1JGiVaAwORnQE3Vbmm
   mAgEiZtXI7ZfrJUNdlDiKN5l6X6F9Tvkq0W4S/uvdre+D9TPfGZiVUquF
   kG9gUuyyTtBKowgGSdJbF6OMsM1HBQF0XcmFv43G3q9joBSNLlwxXyL7S
   3+5aOXIPdd6jA6GedmWPXvUhBfsJI9SWrQT06NkKHbZyarmHmp9dU7r3U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="365762974"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="365762974"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 23:17:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="829110235"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="829110235"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Aug 2023 23:17:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 23:17:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 23:17:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 23:17:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 23:17:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmgBk7x78SrgM3Ax7jCnkR2ZcaEdJeOs1EbeX3HceNjPeOkmSseGm9/9I3tPAAAR8Vip481CSQMcacPTbO6+DxecP1Mi7Ed+LdX3k+e7dZ3bEE8AiLc4LOC3EvTTH+slWWWRXy1gC9deK45LYfOHckGmjiEaJw6PHusNUYypx5vX6jXBGanbjlXNwSTo0LSb2wkp9gSz4YuAo7W5Bt4KK6eGZecl5yaD46SuoqTflTsb+mOO6uq1OcdpvQpUTRM3mb5lzu4Hd1g1CFW/hvwjN4ljM/S2rEcEwOuErUAR4v0E76F/LkKIf4DKnGZOE+OEn7Stgz6CdxMysewNQmcbnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OD247yNr+NwFE/xGzLd+l5qrTAtV6XRcF/QBgdXea28=;
 b=NHNieyE+GlSwh43SjbnlusbRd0hfw2yOiMPdteOEWEHXaJRyxYHRvrIMixWx6l+vasDMw13XMzNf2Y8dVBE3ekafTueTMjTiX1vdnH0yZ2dvQTKCUdcn9CRqJ8W9/j6xgLry0N1y9bIFB0AZFSfjq41swurD09MSAFTrfb0KWqaUwG7rSaog62mtj+vv5AjuUz1aKIDlnyGhD3XnXQTNyMc6Sz1Fz6sNCFIw/PZ93UYcV4TtV5fsb0r/FkZmmn66nWhbDBTdllqF1HzZxRxJIe2I10QyXuwuSuWww6WLquYd+sxkfK0loBpGP5755HYhS3sHTgdftvflHwdzzj+9Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH7PR11MB6769.namprd11.prod.outlook.com (2603:10b6:510:1af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Wed, 30 Aug
 2023 06:17:29 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 06:17:28 +0000
Date:   Wed, 30 Aug 2023 14:17:09 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     David Vernet <void@manifault.com>
CC:     <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>, <tj@kernel.org>,
        <roman.gushchin@linux.dev>, <gautham.shenoy@amd.com>,
        <kprateek.nayak@amd.com>, <aaron.lu@intel.com>,
        <wuyun.abel@bytedance.com>, <kernel-team@meta.com>,
        <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 7/7] sched: Shard per-LLC shared runqueues
Message-ID: <ZO7e5YaS71cXVxQN@chenyu5-mobl2>
References: <20230809221218.163894-1-void@manifault.com>
 <20230809221218.163894-8-void@manifault.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809221218.163894-8-void@manifault.com>
X-ClientProxiedBy: SGXP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::30)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH7PR11MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e62d7f-269a-448a-4d17-08dba920c8da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZNVWbfqBwzL1ubnrdzbIjhwvMi7L/jC++4pbEL4aoRiFBwyMmxIo5Q6fgFMiX8VOr5vBTHMiWNOYJOaL++sHAN+pg9pRaC10GCyh9+qTrYbJgwBXfa5eSKhsC4FuRVPX6t5p86tJDTO1R8zyn563T1WlnpsFgMrvedIvC1ix4Eeo08oA2LdU5oWMb6baBxkt4hzft/uacTNtTs+NdvG73Lh3Exb3aaBcTlt++ZPIQVm+yj32wnRnHKhgZQNvjwIjIKbGlPEWq9IuTeLSNs7ajgt3XkFeZVnnO1xGeV/1Ags5+UTJqR2Qz7LptLPqpKDHWMJJbbPEmdRv8uBCK7U8Vo9RKCYKImlYt1ObBlRem9A+DKZLB2PnKJlBldocFbVNyTIrlIJJwcZpcS90/IlC9+BznumK+pPi5W7IPM0rEwMTzy99H9TqUbTqGrDcakcos6RBtA5g9x6+bgXSO/sFKIf8BW6SGL/LLJsVA9oUFTJWoHBGYCioEw2M3E/i12qB122JQivhFfnVNzO11ZwfrD9mBvg88nLnc7Zv0lQ28rI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(366004)(396003)(346002)(136003)(186009)(1800799009)(451199024)(66946007)(66476007)(66556008)(86362001)(9686003)(6512007)(53546011)(107886003)(26005)(478600001)(6486002)(16799955002)(6666004)(6506007)(966005)(38100700002)(82960400001)(83380400001)(33716001)(7416002)(8676002)(4326008)(8936002)(5660300002)(41300700001)(2906002)(6916009)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VQxQ93uoDU/rDBAcLOUjhWPKE/XbK3DC1T4euN3YE8ORiY5jU9IWTArdq9jg?=
 =?us-ascii?Q?u6Uwr2hVuJsqoSTPvBZ06p7Zr0TaoTgoyVIkLEAL+ZO+iuvStLjAT+UsdtYf?=
 =?us-ascii?Q?7doXM6dlu0yTOqOi+xpC1Nbfc9822LfdEzWassm5oSelxAt1zeKuJ5ZvbxJG?=
 =?us-ascii?Q?qwBih39fnohsJhbFt0d+bHk/SCGjA4NxI209SJ+zfblxQEXBFdKqv/RfC3v5?=
 =?us-ascii?Q?+iJsAs0RFkWwGzwHdvUUVlC4yUhl9B+VHsm/mat7f30X0NC9NsuDOHRcswiY?=
 =?us-ascii?Q?dGTeCJ3RVdUukdqBBYwJqkAicaGaz4Z0W2KwPVDwAvPMyCwNQH/2+1QXmvo2?=
 =?us-ascii?Q?/hQpei3x8M1Nvg4b/mEABJzkkVvzPHlKytHiub9c6fKCVFZYdUW/zSHZMaU4?=
 =?us-ascii?Q?wamv+k3UJz0nCrBey5VOLEIz702mEhab41ngOw9t7CD4FETg+S5onX7zwQIx?=
 =?us-ascii?Q?P7VmTPFQmkgQTbknKI13Nn0ubOOO6IxDBSAMYaNLkj2i3tHQV8jBV15bAs1N?=
 =?us-ascii?Q?aFKW5W0RaYWHhon7dFlNS/jq87TQzjJo4qpgej/XGZOzwpw9qU4kbUGPEkep?=
 =?us-ascii?Q?AS0uTrw/GqKCkGrFhrx1D13NOYjbGg/6U3C1PVuKaDbk84Ht+Ci5rUIjeBzq?=
 =?us-ascii?Q?8kA0bPP6fqlv815AnKYhAxBF1+m9Hef2JuH0gkT5wZ8PwLNNR62EDzIrH7Sy?=
 =?us-ascii?Q?LDIhf1IKIa1ovjYH0VnpXrXsUlBzSqAOk4Pu58yrmS+zCF7CBqkvFTK2zIVh?=
 =?us-ascii?Q?AX9MfkTAP0FDZGL1Uv6/KXasGsgJ9zlXGt2Ddl1U3scqiXxBclLMTSPsUf/8?=
 =?us-ascii?Q?/iQykEEmMM6BccmuZjoc/RI9b53NadlsmcskvmvTZpKyDieDnXd+LL2XIu8m?=
 =?us-ascii?Q?4lFxSkKPL2pF+hAdlrI1bKm8Ip4lB0ATNI1oNpM5niVhGjPl4xWlV12IDKUI?=
 =?us-ascii?Q?w5+OUwb//1WLB1KRZ125UCMB9xnSXJMcJhZMBd5f3LoGXFihwHTfvqeQ0WmP?=
 =?us-ascii?Q?Sx0GZqPgk1Qtt3IZXtHgnvGdo71yormzYxCBjJUc5BPH+4arwqcIlKasmYQz?=
 =?us-ascii?Q?kSONfgWMfO2y1/ec58EWkY2zgg1pqeS8iG7589diD56CdrgIWPcf4nBr1mmE?=
 =?us-ascii?Q?Q6YhcT/BSy0zt1dqYAvmPo9R21+qjJODI1j0IBQwos9/Kfocct88l+fTeNVQ?=
 =?us-ascii?Q?YApQOcHm54eoiw5B9bxXBYWBMTZFqQYsDhRp/d+m0rzaZZTwOy+o0NgT8z/D?=
 =?us-ascii?Q?TesFVW3376pdbZjZ3ym8LPhk2eu7IvhIlyOj7v4x0bTwS/5xMfZk4yNESYJ9?=
 =?us-ascii?Q?X//OmUBg53lzDiljNjv49ibqPYiyj0UTpMvwX/561Xkh0L0v1USF9MWKIzB8?=
 =?us-ascii?Q?BuNOqMX0aeNxoB5tYwrepXh2Gz39C59DTQxSHvNNJd+DGge7NQVWQrTkGUAc?=
 =?us-ascii?Q?K4PA/gVKHGVMoB3+b/i9jXXSl4PsZNCEyYT22r0BLOsxAUk/M1Ly1M7SBQr8?=
 =?us-ascii?Q?ZQunDVf8/D9yApASIU3h1SKy2SAMY0b2eJ6TaGFnW3whOI/FJ9HovEGSBFll?=
 =?us-ascii?Q?3Z4CposoqA4GRff6y+7QQ3djzX5BgnloDSXKO3du?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e62d7f-269a-448a-4d17-08dba920c8da
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 06:17:27.9839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h64uDt3rxXAkHB+B4SlVBl282OCj+SIUT8sKsQvCskdzHhQNZ5qmRzNC68UvEfNVyfJyW4aUi5PI77ccGTDzRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6769
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 2023-08-09 at 17:12:18 -0500, David Vernet wrote:
> The SHARED_RUNQ scheduler feature creates a FIFO queue per LLC that
> tasks are put into on enqueue, and pulled from when a core in that LLC
> would otherwise go idle. For CPUs with large LLCs, this can sometimes
> cause significant contention, as illustrated in [0].
> 
> [0]: https://lore.kernel.org/all/c8419d9b-2b31-2190-3058-3625bdbcb13d@meta.com/
> 
> So as to try and mitigate this contention, we can instead shard the
> per-LLC runqueue into multiple per-LLC shards.
> 
> While this doesn't outright prevent all contention, it does somewhat mitigate it.
>
 
Thanks for this proposal to make idle load balance more efficient. As we
dicussed previously, I launched hackbench on Intel Sapphire Rapids
and I have some findings.

This platform has 2 sockets, each socket has 56C/112T. To avoid the
run-run variance, only 1 socket is online, the cpufreq govenor is set to
performance, the turbo is disabled, and C-states deeper than C1 are disabled.

hackbench
=========
case                    load            baseline(std%)  compare%( std%)
process-pipe            1-groups         1.00 (  1.09)   +0.55 (  0.20)
process-pipe            2-groups         1.00 (  0.60)   +3.57 (  0.28)
process-pipe            4-groups         1.00 (  0.30)   +5.22 (  0.26)
process-pipe            8-groups         1.00 (  0.10)  +43.96 (  0.26)
process-sockets         1-groups         1.00 (  0.18)   -1.56 (  0.34)
process-sockets         2-groups         1.00 (  1.06)  -12.37 (  0.11)
process-sockets         4-groups         1.00 (  0.29)   +0.21 (  0.19)
process-sockets         8-groups         1.00 (  0.06)   +3.59 (  0.39)

The 8 groups pipe mode has an impressive improvement, while the 2 groups sockets
mode did see some regressions.

The possible reason to cause the regression is at the end of this reply, in
case you want to see the conclusion directly : )

To investigate the regression, I did slight hack on the hackbench, by renaming
the workload to sender and receiver.

When it is in 2 groups mode, there would be 2 groups of senders and receivers.
Each group has 14 senders and 14 receivers. So there are totally 56 tasks running
on 112 CPUs. In each group, sender_i sends package to receiver_j  ( i, j belong to [1,14] )


1. Firstly use 'top' to monitor the CPU utilization:

   When shared_runqueue is disabled, many CPUs are 100%, while the other
   CPUs remain 0%.
   When shared_runqueue is enabled, most CPUs are busy and the utilization is
   in 40%~60%.

   This means that shared_runqueue works as expected.

2. Then the bpf wakeup latency is monitored:

tracepoint:sched:sched_wakeup,
tracepoint:sched:sched_wakeup_new
{
        if (args->comm == "sender") {
                @qstime[args->pid] = nsecs;
        }
        if (args->comm == "receiver") {
                @qrtime[args->pid] = nsecs;
        }
}

tracepoint:sched:sched_switch
{
        if (args->next_comm == "sender") {
                $ns = @qstime[args->next_pid];
                if ($ns) {
                        @sender_wakeup_lat = hist((nsecs - $ns) / 1000);
                        delete(@qstime[args->next_pid]);
                }
        }
        if (args->next_comm == "receiver") {
                $ns = @qrtime[args->next_pid];
                if ($ns) {
                        @receiver_wakeup_lat = hist((nsecs - $ns) / 1000);
                        delete(@qstime[args->next_pid]);
                }
        }
}


It shows that, the wakeup latency of the receiver has been increased a little
bit. But consider that this symptom is the same when the hackbench is in pipe mode,
and there is no regression in pipe mode, the wakeup latency overhead might not be
the cause of the regression.

3. Then FlameGraph is used to compare the bottleneck.
There is still no obvious difference noticed. One obvious bottleneck is the atomic
write to a memory cgroup page count(and runqueue lock contention is not observed).
The backtrace:

obj_cgroup_charge_pages;obj_cgroup_charge;__kmem_cache_alloc_node;
__kmalloc_node_track_caller;kmalloc_reserve;__alloc_skb;
alloc_skb_with_frags;sock_alloc_send_pskb;unix_stream_sendmsg

However there is no obvious ratio difference between with/without shared runqueue
enabled. So this one might not be the cause.

4. Check the wakeup task migration count

Borrow the script from Aaron:
kretfunc:select_task_rq_fair
{
        $p = (struct task_struct *)args->p;
        if ($p->comm == "sender") {
                if ($p->thread_info.cpu != retval) {
                        @wakeup_migrate_sender = count();
                } else {
                        @wakeup_prev_sender = count();
                }
        }
        if ($p->comm == "receiver") {
                if ($p->thread_info.cpu != retval) {
                        @wakeup_migrate_receiver = count();
                } else {
                        @wakeup_prev_receiver = count();
                }
        }
}

Without shared_runqueue enabled, the wakee task are mostly woken up on it
previous running CPUs.
With shared_runqueue disabled, the wakee task are mostly woken up on a
completely different idle CPUs.

This reminds me that, is it possible the regression was caused by the broken
cache locallity?


5. Check the L2 cache miss rate.
perf stat -e l2_rqsts.references,l2_request.miss sleep 10
The results show that the L2 cache miss rate is nearly the same with/without
shared_runqueue enabled.

I did not check the L3 miss rate, because:
   3.1 there is only 1 socket of CPUs online
   3.2 the working set the hackbench is 56 * 100 * 300000, which is nearly
       the same as LLC cache size.

6. As mentioned in step 3, the bottleneck is a atomic write to a global
   variable. Then use perf c2c to check if there is any false/true sharing.

   According to the result, the total number and average cycles of local HITM
   is low.So this might indicate that this is not a false sharing or true
   sharing issue.


7. Then use perf topdown to dig into the detail. The methodology is at
   https://perf.wiki.kernel.org/index.php/Top-Down_Analysis


   When shared runqueue is disabled:

    #     65.2 %  tma_backend_bound
    #      2.9 %  tma_bad_speculation
    #     13.1 %  tma_frontend_bound
    #     18.7 %  tma_retiring



   When shared runqueue is enabled:

    #     52.4 %  tma_backend_bound
    #      3.3 %  tma_bad_speculation
    #     20.5 %  tma_frontend_bound
    #     23.8 %  tma_retiring
    

We can see that, the ratio of frontend_bound has increased from 13.1% to
20.5%.  As a comparison, this ratio does not increase when the hackbench
is in pipe mode.

Then further dig into the deeper level of frontend_bound:

When shared runqueue is disabled:
#      6.9 %  tma_fetch_latency   ---->  #      7.3 %  tma_ms_switches
                                  |
                                  ---->  #      7.1 %  tma_dsb_switches


When shared runqueue is enabled:
#     11.6 %  tma_fetch_latency   ----> #      6.7 %  tma_ms_switches
                                  |
                                  ----> #      7.8 %  tma_dsb_switches


1. The DSB(Decode Stream Buffer) switches count increases
   from 13.1% * 6.9% * 7.1% to 20.5% * 11.6% * 7.8%

2. The MS(Microcode Sequencer) switches count increases
   from 13.1% * 6.9% * 7.3% to 20.5% * 11.6% * 6.7%

DSB is the cached decoded uops, which is similar to L1 icache,
except that icache has the original instructions, while DSB has the
decoded one. DSB reflects the instruction footprint. The increase
of DSB switches mean that, the cached buffer has been thrashed a lot.

MS is to decode the complex instructions, the increase of MS switch counter
usually means that the workload is running some complex instruction.
that the workload is running complex instructions.

In summary:

So the scenario to cause this issue I'm thinking of is:
Task migration increases the DSB switches count. With shared_runqueue enabled,
the task could be migrated to different CPUs more offen. And it has to fill its
new uops into the DSB, but that DSB has already been filled by the old task's
uops. So DSB switches is triggered to decode the new macro ops. This is usually
not a problem if the workload runs some simple instructions. However if
this workload's instruction footprint increases, task migration might break
the DSB uops locality, which is similar to L1/L2 cache locality.

I wonder, if SHARED_RUNQ can consider that, if a task is a long duration one,
say, p->avg_runtime >= sysctl_migration_cost, maybe we should not put such task
on the per-LLC shared runqueue? In this way it will not be migrated too offen
so as to keep its locality(both in terms of L1/L2 cache and DSB).

thanks,
Chenyu
