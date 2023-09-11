Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0920879BC58
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243341AbjIKV2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbjIKI3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:29:41 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7E6FB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:29:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDZ28ITReLJp+zVjkOhpke0YdrdMYFR48c+uRTSPLCQQGZ+Tr8+C6bCLcOqLSQmk6RAXXnU7LnWsd1KqazP1Ko1L5nYDuVQhXFjS0o7tH0E/NGCWA1BNm+j8p+39//xjw4qmfL3lPeMldDYnnoI6wgWWKvVSLlWOWl5UQCGkj4kGMjF4fXiAorJep7QogZyNTiFvZth2jkvDBosKQ49M3VaN8W+ewYzAtl9UNFj9fwNr0oq0x2PJfILkIFa1UuptwwpoNJeq3iSk+UAXk8luqeqr8uKge9pl3eGYbh/PB4r7xoHBRgr5JuHTKrS9OgCvrt8hdjS+WSBr1MwpFRieXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zp5ILFyeatUNblBjJGTq4JoieRBa9hJwLUzupn5ceKk=;
 b=AVsMpTYzrEXd7eyS9gdVKNoTpEVkGnDVLwxf0NYcjPd33j59vMWbfdaYF1UqcScYCdbO3O0ULUc/CKO+q37DBpi9GXiB4BEuVh0FnW1Wo+SbMyx9FQxTO4NerbFa5UArmJfBGOyjRl5aZyDOVIHc5FhG5fPZ+fuqAUMvhkSdJP2kQEq8/VCmKnrF/rVALMAm11mFmUQYk59XqsApbQoReMuTd9fDMaeQOpZepnFNo1jGCKQCsWpjJyPEQJROD3jEVMDX6bVq9jv0YGJq6U+cfza4dKh8IBM4cxqy9CdO/+usWEwef72cjjI3AbGR2jusZ1I01r3sFBop9a4rR/CIUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zp5ILFyeatUNblBjJGTq4JoieRBa9hJwLUzupn5ceKk=;
 b=uu9uYrxJmA6ZWT4k0nacJaRBoHjxBeOvD7NCWtZAUcAqjaCTlwQxjXV+49bSdy6SXIfoJoFXA9MmU8Y+0NA1vewKysbtEg97uIM9IQKyMZM6+3CeB874yHALVYpdfLdGRzYav9wuqK9CDpBpE1B3dx+iErEoTupeJWFp292LSUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 08:29:32 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 08:29:32 +0000
Message-ID: <31c910c2-717d-b86c-4e08-5c94383682e8@amd.com>
Date:   Mon, 11 Sep 2023 13:59:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH 2/2] sched/fair: skip the cache hot CPU in
 select_idle_cpu()
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::9) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b08a2ff-26d0-4230-72f2-08dbb2a138f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: civFYWm6TyRgXxgzzdTp+rRyj72XkAN9VVJpmJNW4boAy3utuAhZsACTCsxfeUE+4fYExcV/LItqopSGp1Q3kH/eNvtOSezo3ClTKtdepRT+PBT3rsQeXEAHLNXKA0X/BUZLAymrDFjEk4j57EBasx2A/+LjruJ+v7Pq07hjAIGU8h3XOGWODX8xs1j4XjZPdkqlu9XJCdXq37k6u/iB5MCimm6t/FWWG/W7khL5s+tce2/X2pjjzj10mNZ3jbNMXF3gol1ld1sGDsN+SoMNjWG0cl//cdit5TcU2BJKXp252wz7V//EstMBrDhqOZXA+RmT3Z/On6fkK1pONDccFyDIfO4Jx72jwXUupIJ39M/kWo+CzNzVPwDhpkd6ZPEUkAV/ogI7748PE+yPv8botXciOj3KQm2h5Cern6fFChe39rFEaqtTWgBR025uvz3MIOGnLiO+rVpBv1GceQmqUDuUdRitYjdlfSgd3FBq1yVFhMQFnxsy8UJ4+V/2EbkDgMD3O+OZ6OCQvq70W9ORRpCkQ4b7ym4z/18jxrK9VOzCToLH7qGlJYwoZ42XcI64AxHRK4hpUf5m347jLwiWBzkNSp3oEq7Yy23YFMBeCtjpx2jW1lUO0WUU7eBFOwm/OY6POiB2ZvW5sjnK/X2ukg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(1800799009)(186009)(451199024)(7416002)(2906002)(38100700002)(36756003)(86362001)(31696002)(6512007)(41300700001)(316002)(6486002)(6506007)(53546011)(54906003)(66556008)(2616005)(8936002)(66476007)(4326008)(8676002)(478600001)(66946007)(6666004)(31686004)(6916009)(83380400001)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzRrZXpHcUZ4WUx6WmpndjROTWpFcTBDSXU2UnJhWjVOVXlPQjNqME11Z3Bt?=
 =?utf-8?B?R1R4cmFaTjRCQ0JWOWd0TWw5NFlwUkNSUlNIR2ZSWkpoNk1ocEJOcmx3aHpa?=
 =?utf-8?B?OTVIZElyZlo5Q01KdDA3U212dzRaVk40OS9RYlpyM0FlWU5YOG92aEFVL3Nm?=
 =?utf-8?B?WGxtMVpXSVljYUlTNjRWZTBCS2tsLzVGRUJMQkpqcUxYUWU1dGdwK2w0Wk5y?=
 =?utf-8?B?WTgzZi9LejBCNXJJYmRoM3RvbmFWdTUzU2tUWTFyVlpvck5UaS9BZUpqUkxQ?=
 =?utf-8?B?bkFzTWtZWDhoQnBOcm5MRGEwcXVxOHB1SndVTkJrWjk3VkxBSmxoNlNuN2pw?=
 =?utf-8?B?ZExJMGRZZERJeUkrYUZwSUwxWDQ4ZHZkNjhQOGZkdktsaFI3djZjenIwanBt?=
 =?utf-8?B?bktEc1ViTER0bUYzV0NkbEt4OElBMlozNGFaVmtQZW1La0Zza2JZMlZnVWpN?=
 =?utf-8?B?SFBmSGRodytWemt4eWRlVHBYeHByVlFqUDB6MmFsS3ZxUENNemR0NHczRTlj?=
 =?utf-8?B?RElFclN1Tkl1N2xjakJtSHdvN2kwNlhJa0xDR203YXRlcG9TamttUXF0UjBR?=
 =?utf-8?B?amorKzdiTVI4Z0t3cytJdExYMG1IWXRVZDFNR293VHRTV3FrOU9YQmFwMHFk?=
 =?utf-8?B?bGxhM01KMS81Rlk1RHRBczZTY1JXNGVYMDkwanlFeGtiWld3dFB0bDNNRU1D?=
 =?utf-8?B?OFlUZUszZGJPQ0MwbDNLeXBvNDNmWWZXcFhWNTlKMTdCcVhyOGg0dHpVNmRG?=
 =?utf-8?B?cVk5QVpZVnYyM0F6Tyt1a1AzWFBoTWxpdDM3eEMvOWw0Nmk5bCt0elVGSksz?=
 =?utf-8?B?R0U0c0tSeVJzcEl4bkRGekZMZjBnaFgxVnpLVmxhK2UzYlpTcCtab0pLNEVO?=
 =?utf-8?B?M1N4aGUxMW50UVZaUE0xYXhwU0ladGkwRTAwOXJxMGwwUE4wVDBrbzJsazBM?=
 =?utf-8?B?WURJZXlKL2RZRTZIbWdzMTcxaTFkdG5YaGd0RmRNbmcrZEx0N3habysrME5T?=
 =?utf-8?B?c1dTNXdpYXVwempoaVBtd0VyZkJwYlMvQmNyTCtiaWNpTSswcTdBLzBjQVlH?=
 =?utf-8?B?T09yeWtUeGtPMG44Z2tYb2tZMVN2UzQ0TmZPMGRNTkJXVWdZSWRyWHpGbkJJ?=
 =?utf-8?B?TEhrbUo5QjErRnVWZUh1S1pnbXZBZFFPRktMY1hPK1VBamc0eW5KbHUzZlVk?=
 =?utf-8?B?VmYwRHorejJXT2JoWGh1eFBmbzlIcjc3MndJZ1lYSGFZM29kUHFOaFl4bTdI?=
 =?utf-8?B?bWNoU2hQdGxoeGdhQ3ZFZUVDRUFySWtwNVRWZFI1WlJyRGJ3TW52dFczOElI?=
 =?utf-8?B?SlRmcmRPRWl0NHlyTnFiaTUzUmt4dGhhM2NkaGphZ09GZVNxZ2lBSjV4MmRE?=
 =?utf-8?B?ekc3WTNYaUZ1RnJ5ckNCREk1TVpDTS9DUUVNMHN0Z3BHUmkxK2Qza21sZVN5?=
 =?utf-8?B?TS8zVFNEQmRrV0dzKzhranFaL1BzZDJGQnIwT2dDQjRIR2VoT2owTTlCRDRt?=
 =?utf-8?B?WEdxaHhGdTdzUnhldHRJaWhmNnNpMXZMQnZnM0p1VFJNZFIxT0lINnpaQWlx?=
 =?utf-8?B?TW8vYjRadVh5ZUYyTWd0SitYaG5UK0loR0hKeFBER2ZMV09PMkFkMVpmYWVv?=
 =?utf-8?B?VjNnWk1yQ0xacDdZZ1dlQTZjREp4dmhCL1RTS3dGRHhWeHc2Z0Iraml0T0Fr?=
 =?utf-8?B?WlNwTHNPRjJtN2tCdTh6V21nMVNpKy9MenNoK0MvMUlDRGxZbkVZTTNSc0RD?=
 =?utf-8?B?Z3lCbEl2UkpOSkJPc1d3b3FmVGZlMXRTMjBCQjYzM0xuTll6QnVmby9RUnlE?=
 =?utf-8?B?STBETjl3N29zakx0UVQyYnVOQnBjTVpXVE9FdlZ5Z3loVEdBUlRHb213VVJy?=
 =?utf-8?B?Ny95Tkd0Y0lrSGM1VE9ROFNuMmFWSzAwWmFRcHYrUHcwUUJONndSLzhCa05v?=
 =?utf-8?B?dGQ3ekplYzgwMWg4UEptZWNPcVgxdnYrcHdTTmltRDlPcDAxVnNJSVkwVmZv?=
 =?utf-8?B?U1ovTDdmMlBvL3IyVHQ0M3FYeEF5OHBjQ05XS1VmdWNML0dQdGFkV0FSb1JD?=
 =?utf-8?B?OGxsdnRRMStKcU9DMGtPMVIrRFI2SkhvQ1lRNC9PVFltVDJwMlV2S2JtTjZT?=
 =?utf-8?Q?XrDqgfc9GyQRGYp4/GkIkBA4k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b08a2ff-26d0-4230-72f2-08dbb2a138f0
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 08:29:32.1388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ysIkzx2JQRr9ngNU3c8FsEmcRF3dW50KxLoFqIjPb13OpoR2oFxEorZtj3QGhzdKQHSSZ7DzGg0zsu4MFWJcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

On 9/11/2023 8:20 AM, Chen Yu wrote:
>  [..snip..]
>  kernel/sched/fair.c     | 30 +++++++++++++++++++++++++++---
>  kernel/sched/features.h |  1 +
>  kernel/sched/sched.h    |  1 +
>  3 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e20f50726ab8..fe3b760c9654 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6629,6 +6629,21 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	hrtick_update(rq);
>  	now = sched_clock_cpu(cpu_of(rq));
>  	p->se.prev_sleep_time = task_sleep ? now : 0;
> +#ifdef CONFIG_SMP
> +	/*
> +	 * If this rq will become idle, and dequeued task is
> +	 * a short sleeping one, check if we can reserve
> +	 * this idle CPU for that task for a short while.
> +	 * During this reservation period, other wakees will
> +	 * skip this 'idle' CPU in select_idle_cpu(), and this
> +	 * short sleeping task can pick its previous CPU in
> +	 * select_idle_sibling(), which brings better cache
> +	 * locality.
> +	 */
> +	if (sched_feat(SIS_CACHE) && task_sleep && !rq->nr_running &&
> +	    p->se.sleep_avg && p->se.sleep_avg < sysctl_sched_migration_cost)
> +		rq->cache_hot_timeout = now + p->se.sleep_avg;
> +#endif
>  }
>  
>  #ifdef CONFIG_SMP
> @@ -6982,8 +6997,13 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
>  static inline int __select_idle_cpu(int cpu, struct task_struct *p)
>  {
>  	if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
> -	    sched_cpu_cookie_match(cpu_rq(cpu), p))
> +	    sched_cpu_cookie_match(cpu_rq(cpu), p)) {
> +		if (sched_feat(SIS_CACHE) &&
> +		    sched_clock_cpu(cpu) < cpu_rq(cpu)->cache_hot_timeout)
> +			return -1;

Just wondering,

Similar to how select_idle_core() caches the "idle_cpu" if it ends up
finding one in its search for an idle core, would returning a "cache-hot
idle CPU" be better than returning previous CPU / current CPU if all
idle CPUs found during the search in select_idle_cpu() are marked
cache-hot?

Speaking of cache-hot idle CPU, is netperf actually more happy with
piling on current CPU? I ask this because the logic seems to be
reserving the previous CPU for a task that dislikes migration but I
do not see anything in the wake_affine_idle() path that would make the
short sleeper proactively choose the previous CPU when the wakeup is
marked with the WF_SYNC flag. Let me know if I'm missing something?

To confirm this can you look at the trend in migration count with and
without the series? Also the ratio of cache-hot idle CPUs to number
of CPUs searched can help estimate overheads of additional search - I
presume SIS_UTIL is efficient at curbing the additional search in
a busy system.

In the meantime, I'll queue this series for testing on my end too.

> +
>  		return cpu;
> +	}
>  
>  	return -1;
>  }
> [..snip..]


--
Thanks and Regards,
Prateek
