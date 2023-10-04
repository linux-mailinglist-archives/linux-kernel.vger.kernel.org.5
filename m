Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0BD7B8404
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbjJDPq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjJDPq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:46:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DDDE5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696434413; x=1727970413;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QuaijG74D3t7axJM9SINi4QYNRQ/U7vuY9mW5SNJPOM=;
  b=FXGNkUwZRHhA4bvhSduvXBUWeDXG0WD9TUqascpnWq3el//oCR18uLbf
   Pqu0OPTaqZfoyGyljyLtwl1EixNF83aMlp+fDpKXVoeTOx3hl6evflge3
   Ud4M6DnhMiuEohvwRRmzjBHfokBHvm6fS/LkYSFEy572fTI4ewPkVzXQ8
   KSAOf/N7bb2Cg0nX+BdzntYrTJCYOht8H8PYWX96t2c3yZKJwgg0t5+y7
   WEOsRWwT/tsxasYUm24SQawpE1g6cJhWOTkJEt0q/fpc0iq4pgy/2wNz1
   ybbOjpFQnJd6OlWlSAgQSnaSYMpkLA8uD1p0N2PBCdJXlDYPPrVVpw1kX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="362562126"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="362562126"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 08:46:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="728071894"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="728071894"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 08:46:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 08:46:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 08:46:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 08:46:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifU7rRH+wQlbD4K4kIEw+3vRkGHpfz/uRIp2+zYODsuxeAUb8sZw63b0X8jzAgtfo1Dm4MkCIOngtHYl8KIn5/7oaNjItH59Kvk/djvPY4icOO2O2ihLzLBjKdt02xGc4me3a+jFVzbUfZrqGpOXob+e8lSS6s6TfpymbA8fZIt5PJ9MDtl4GycTwjeBTO/WzjvKvy89LT6n6K5zrV/WyoQpLizw8LiGL2ED7eme/8yyqW+ZEyw/+F5x5XimCKxulFBe5iuDySEPtevIqd4Ddb8dsLlYavmT145HOypIE1egXSo0sRqA4cJEukqdD3mWhGsrMW5xjNcg+ugJEbWI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CPfz1BXTfkcLTQNVLZDHb5e6b8YlaTBwhQDPfbtX/U=;
 b=eoj9bI75/jTLHokdHgfUFU9LR3q6Efiq6eDtn3FPDtukegPUIisx9rcCv9Adc5vcEhy9FmGEUunLgSxTmmJ5+B+imCSEoAxNb8kmB7RlzSoDRy6fcTMbQY9CX7Qxy6HAqLtt2KUbcgOQqXCVJeMnQzYb9Xdc6HztKWaAoAvjuxsDP0TVIsMa5Oi/+J9YydXVWr8FKnjOjjGJZ1sh6AgrgxOgsQz8ZE35+slmuxvld1OTukHutovNeqL4TtZKitBvS2NpwT0fhfL+ncutOKMKi2mEiLIrZdj5oy30b7PpZiq5LO9rnl6rX+2yFhqeSXaoMf6oLzk//nBqIECpCsNCmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DS7PR11MB7808.namprd11.prod.outlook.com (2603:10b6:8:ee::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.34; Wed, 4 Oct 2023 15:46:47 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%5]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 15:46:46 +0000
Date:   Wed, 4 Oct 2023 23:46:21 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     <peterz@infradead.org>, <bristot@redhat.com>, <bsegall@google.com>,
        <chris.hyser@oracle.com>, <corbet@lwn.net>,
        <dietmar.eggemann@arm.com>, <efault@gmx.de>,
        <joel@joelfernandes.org>, <joshdon@google.com>,
        <juri.lelli@redhat.com>, <kprateek.nayak@amd.com>,
        <linux-kernel@vger.kernel.org>, <mgorman@suse.de>,
        <mingo@kernel.org>, <patrick.bellasi@matbug.net>, <pavel@ucw.cz>,
        <pjt@google.com>, <qperret@google.com>, <qyousef@layalina.io>,
        <rostedt@goodmis.org>, <tglx@linutronix.de>,
        <tim.c.chen@linux.intel.com>, <timj@gnu.org>,
        <vincent.guittot@linaro.org>, <youssefesmat@chromium.org>,
        <yu.chen.surf@gmail.com>
Subject: Re: [PATCH v2] sched/fair: Preserve PLACE_DEADLINE_INITIAL deadline
Message-ID: <ZR2IzepAXhxnsqLp@chenyu5-mobl2.ccr.corp.intel.com>
References: <20231004011737.188682-1-daniel.m.jordan@oracle.com>
 <20231004130908.238992-1-daniel.m.jordan@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231004130908.238992-1-daniel.m.jordan@oracle.com>
X-ClientProxiedBy: KL1PR01CA0120.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::36) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DS7PR11MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: efbc482a-f8b2-44a6-7e0c-08dbc4f11d5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b+2CYDjxU0UTymVae8lNTn+eAMK4Gc2uyzNUCu9uA1dy7AdURE1XdC44fJCtVE14XPDsmv90h+jIzEKKrzK6Qda48VB587gBghTOB+LvWmoIVxFQetjsvpaisQ2ZpvAS8vzWw7AaBIhUPkd5UQynbD7/AohCKGEjfb1E5gsBvYWfsgaa6gXeboAkD8OkiqykVcIZbPEhJRg6C5CtbQx5X7mT7M4k//WXZb1lp5tXB49XtRNVufcFcE6HucMRXimsPN26WsJkUqXOiaHhUCR1VZm6PgTJxmWL1c9bHhlmzBAHRUzLvYq0rfgYvXL+dVBjtgO6dxzravhjzHNvIR36Fagt7kD49GOx4oA14rj51trQvgCw2Qu5cudkYIC3oj+7BrtB4AJqpmtVo+NO1eR+9mBfyucNBEP3B2NT5jcXM5yLqCHHba6EcLoyCoqcY/Uq9+hMMF8hZiFm6G/27wz67yyCjEF58We0+IWq3m+RV15t/RiG9TCPTrofSxsnS4QGexu0o1OHbM1pyd6vTneQyKQQotbWHSi5QhSdQx+cfFzDZMAnJ8vhLKjrFxsrCbip
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(41300700001)(478600001)(6486002)(6506007)(316002)(53546011)(6512007)(66946007)(6916009)(66556008)(66476007)(8676002)(4326008)(6666004)(8936002)(5660300002)(26005)(7416002)(83380400001)(2906002)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ew0+BmjGpQq0q5rdxwRuxg2j8Y3UseD/cbr2FllXBXQ+bAvtC3GvexfND745?=
 =?us-ascii?Q?v5bVpuF5naUk8GDecvoNjfa9cK9tFlSOX5j7zrG8zLXsVexSDMl7Jd2TYnko?=
 =?us-ascii?Q?A0ULDMR+3/OdekUa35IBUfECAgNkITh2XkmicFhVExPVTjlzOtB/yBwF9YwK?=
 =?us-ascii?Q?VT5D2sbbufjln0b80TRgHqfj5GkRHnAGNwndohaYfnqSV/J0ciiFrADjW9a2?=
 =?us-ascii?Q?W1p+YsKaG6OXiZ3c/3zTHjtv2wxv2bAqFVh4pVfebk8aC6ewfYpI4/VnXAp3?=
 =?us-ascii?Q?fiq0V8K7uK7qbQAVYwzTVe/7PBhL6JtEnzl1TDQ/yj+PfS5mZUi+R+Cd6s+w?=
 =?us-ascii?Q?Mr6kASguLhZ9SNDKpKt+KXNV41+0UxK9umJMARV73Qrmp1AHp3dFURbfI9kR?=
 =?us-ascii?Q?k6N10bIhb2qxc6H0BLiOT8a7rNkl/DBoJ1br6umXMhlwHd4vkEmn6APC3Y5T?=
 =?us-ascii?Q?fkn/ZQpFYpgLKVJh0FYvvCqKtQsnDekYL4X18D0ZM7fnq8aeIRGmwIoTMO8g?=
 =?us-ascii?Q?a6/JR1oYuJ5UDvof95Qol6QnDj8fLBJJdahbSi/UYBJym55sJwxNZUk/XjH3?=
 =?us-ascii?Q?n1yzthmKbOvCXiAdcKB+9yQDPXYOgPfZS5Hm/cpj2NWbuISjaL6ai7ejjyzy?=
 =?us-ascii?Q?B5vAoWkJ+WXfsM1a+C9NTpppvyrthjxcpTvabmbW7jK0kzc43wB/r9AWfHA5?=
 =?us-ascii?Q?y6A9Hz7YdTIjQK9zgQeQ4cltfapa+xWfG/RzskoIuZtd37c5Z0gdJLszjey1?=
 =?us-ascii?Q?cnZkRVXLIGPU9oP9X4FSHNNW7pDE0+h4qiZTvmn1CinLPQHTYXU9zb/YGKan?=
 =?us-ascii?Q?AuRy2XV+yVuapCXHsFRISizhSWk+KYe8t/Dv0xrqPxcHF3gweyfMQzue6GrP?=
 =?us-ascii?Q?F5FfIn9IZ1CpmLfRMNi9Rli7SxJvQ1DtY95MG9wGutNK9nshi8q1pV2QniHk?=
 =?us-ascii?Q?tDkmKgBT0JkXMBSnt0X4elNwVJl5jlqn01VuZQNGlNJHf/UdfsoNEl1LLV5w?=
 =?us-ascii?Q?SByIYnOYIWCWHudStvnwManK5IRTRvc5NuDuBi7Tcv/FVFCikRI15t2oaP4w?=
 =?us-ascii?Q?dw9IPfy2NbAVGzpl1u72iYKyIms8cm+5hzfmt/NNBfuraUeV0FW3ldWe7fk7?=
 =?us-ascii?Q?I1MqFi6i5EgW7pmndVv/2OH7tN3fpa6SIxZRwuM8oKyYIXna5wSuJR53FYoy?=
 =?us-ascii?Q?Htx3D6xkUcBoGc5ZDL3Zx0RKizFLkUs7NyMT9O76ng76H6hRBXksDmpgbnuz?=
 =?us-ascii?Q?qh3D67W4NHLumIEzAb+LA9IgFebTaUXgH6iKS8Ld5c0EAO3WneyH0YytxxrH?=
 =?us-ascii?Q?+c5wxfoaf1hP1ZWlpp8hkkjIevfsKoEBKN40MAC9JMaYg60YbxUjtg7yceZS?=
 =?us-ascii?Q?pbQDDqJfqnyWH8UW/CH/Y/yqAV0Wd2tE1ahcpuEHfB5OEmabofWUuvtv03pG?=
 =?us-ascii?Q?kNoJZENJVrzA0Xr1VfNdqML9/Pz+6tRIQwYBmbcNMq2F6LIF2BaEq89JOQ1N?=
 =?us-ascii?Q?xfi93mlbW9UD568VwIl8RW+/EKkv+P/kPTeYVzbXemLq+iJJaHRfo/V/of+t?=
 =?us-ascii?Q?TATDYnFCNcmOOSN9kgFF72mwACsYUcYjsP7BqBzP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efbc482a-f8b2-44a6-7e0c-08dbc4f11d5f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 15:46:46.4156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHj5yMklLxw6ixXZD9Puv03UuzMJCfpVrOEIjinSfoGf/BFOprwYBHuQHFDZVjH4yODbFYFXs7DgvxwS+Wy6oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7808
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 2023-10-04 at 09:09:08 -0400, Daniel Jordan wrote:
> An entity is supposed to get an earlier deadline with
> PLACE_DEADLINE_INITIAL when it's forked, but the deadline gets
> overwritten soon after in enqueue_entity() the first time a forked
> entity is woken so that PLACE_DEADLINE_INITIAL is effectively a no-op.
> 
> Placing in task_fork_fair() seems unnecessary since none of the values
> that get set (slice, vruntime, deadline) are used before they're set
> again at enqueue time, so get rid of that (and with it all of
> task_fork_fair()) and just pass ENQUEUE_INITIAL to enqueue_entity() via
> wake_up_new_task().
> 
> Fixes: e8f331bcc270 ("sched/smp: Use lag to simplify cross-runqueue placement")
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> ---
> 
> v2
>  - place_entity() seems like the only reason for task_fork_fair() to exist
>    after the recent removal of sysctl_sched_child_runs_first, so take out
>    the whole function.

At first glance I thought if we remove task_fork_fair(), do we lose one chance to
update the parent task's statistic in update_curr()?  We might get out-of-date
parent task's deadline and make preemption decision based on the stale data in
wake_up_new_task() -> wakeup_preempt() -> pick_eevdf(). But after a second thought,
I found that wake_up_new_task() -> enqueue_entity() itself would invoke update_curr(),
so this should not be a problem.

Then I was wondering why can't we just skip place_entity() in enqueue_entity()
if ENQUEUE_WAKEUP is not set, just like the code before e8f331bcc270? In this
way the new fork task's deadline will not be overwritten by wake_up_new_task()->
enqueue_entity(). Then I realized that, after e8f331bcc270, the task's vruntime
and deadline are all calculated by place_entity() rather than being renormalised
to cfs_rq->min_vruntime in enqueue_entity(), so we can not simply skip place_entity()
in enqueue_entity().

Per my understanding, this patch looks good,

Reviewed-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu
