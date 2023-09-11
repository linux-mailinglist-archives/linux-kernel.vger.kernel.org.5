Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BDE79B51E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355537AbjIKWAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbjIKLmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:42:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEBFCDD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694432554; x=1725968554;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=EDGaWVeGxT/N7EWZ29K5dGP0L8Z0oEw+kRJs7jaF91c=;
  b=gy9vfbev5izhx1Izlb1nbN0yq0HosmyA2rxiaa3UOweqY7w4NwoJaIB1
   tXP8GC5AxyxXemtSJ+/bhVEG+KJpb7F+LKFKETaC0mOmICSyest+0tIBz
   8M/ZZ8YfdjgELs5gzZyVgV9WyjAQe95Wi91fqq5lQkx4SlZe5x5xcS7Rz
   XjNIEbA94edyu3ZEkyZGjqShCmWMOiWdEi4quFb3b/1AqXWZGBv2exnx+
   VCBUoc0B8vk4OoPnZjYzeQTxWsUEgulSJIOQ74LkR+q7FqyIpMB57nllZ
   XzCyPoElkO3Ru1d6dCoEbYGSX+C8hfEYECN/jQWaG6UFgYFzklKSAvjhG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="376970824"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="376970824"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 04:42:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="886492675"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="886492675"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 04:42:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 04:42:32 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 04:42:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 04:42:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 04:42:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9zVtu1tytspSgrULt2p6Sjaau6bUjSR9SpDKE8DwZPOUXIiywIvAUm6lGt8rCYkxdsHIIxo91VpRFvPJucDV8WeJWTQCBoRQXKXJZ1LwmDeRwugt5AfjZofPwzsANqtArhOht/ahkza7OiQhjxTAKjEiC3VjD0KLKEsTYwdgK/V5pdZY+eZvhRWh1oie7juz2DFK7NN9n/U988Zx59YaBmIWHCoesq83RmQDlR/JDc9pEgBbyZdlyqP6ZQNn7Yi7BpOM52lpMTV3DgLyeM6tVMsq/lfWXZ1NvOMmgD6A4cCDw068y95L2LK+NmLiWOLCNDtd/894Wurh05nFuMKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5ArGaq1DSQ21v4YVao9qO2BokPrRB3IPugElW3LHlo=;
 b=SmvuX6dxRchChwLx2SN7SCTYOu+lFFrLCSYOCdqn65ApQrV6p4rxaoEoX1ceNQAJ7YEGEq3aCHglgi24OwSRgzCiXKYxHhS2YtygAKUlidcvpHZutOdsPZDngsaQdKau/P23UUeHNxBfvVGXRkk+JjhTfShPDN/EIoP8BI3UMgoJ7h9E9m82V98jHRa+9nOW333C1uNhb2BwmlBWRjWUpH6cNwWApNNOwfAGobO7cvAVfD8w7Ch2flL4kuJ6HJluAy00Q5/JMwtiNXLrGNh9ywDr13u2sKPQEGlmQsM2Yx1LLElvxCAPWXSQ/c0AUFEG1yfMqi5DU2mZqs+0yhs5jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DM4PR11MB5566.namprd11.prod.outlook.com (2603:10b6:5:39c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 11:42:30 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::d0db:d23:1d85:ed85]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::d0db:d23:1d85:ed85%4]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 11:42:30 +0000
Date:   Mon, 11 Sep 2023 19:42:18 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Pierre Gondois <pierre.gondois@arm.com>
CC:     "Zhang, Rui" <rui.zhang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "tj@kernel.org" <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH] sched/fair: Skip cpus with no sched domain attached
 during NOHZ idle balance
Message-ID: <20230911114218.GA334545@ziqianlu-dell>
References: <20230804090858.7605-1-rui.zhang@intel.com>
 <20230814031432.GA574314@ziqianlu-dell>
 <cb305abedea24980c93ce2b436e64039d3796812.camel@intel.com>
 <b886a9af-6c90-c12a-f700-1a9141e25e7a@arm.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b886a9af-6c90-c12a-f700-1a9141e25e7a@arm.com>
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|DM4PR11MB5566:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4d5329-dde6-4f5f-db82-08dbb2bc2dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKusHlrRPIRVkjYLVlP6WyuUyqSt7z8HLHRPl7Vt9zcagn5kcQhNGAH8LVhJj2ZSQXbVYzYsLv5yEkN8Woi1sstwf+6+lB5jdMSZNnseGvitgL0c5UuNASL3rKeAQs6/MGE2owhrfxzdB4EWVRrHmyqJ8h6ZN5AAsl8MRFDBVwszxZV8BcFuyNOwnHCUatTDU8XtKzRHaOz1TbvhhkYYrYJbxh59rYX32kt+I8q34Jv936m1WIWNNDg7paZRwmBRd3G0ZPOzJ3Fa4R/H/jCaHc8OyRcIp38ETpBhqCBK7/9Hj1q8i0Q4TsYgQ183ryLCCrNAyGH7pDD6js3U8TUl72tFlg6YlW9jVQYp11kTtP+tL0WRBSTrzrUgUsU+b3M/87qgKN0S6Z1w/fNLQk7Qg+M0ZBn6x5oS4+/Cmrlm/agTQNwenvG2bZ1bsMKZwlnXITI9gC6yuV8dpfZrF2SDgQ9KjnyH+kZXvNTKuKLZS+BrZRYb4QJVzaF/Bac/TdQVXilIeF3VoTKVxfhZIA9Y4kyPZdiTVoWZgnQmySvB3sLSRi5x4KA9cv6JUnZlAIot
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(396003)(376002)(346002)(136003)(186009)(451199024)(1800799009)(6506007)(53546011)(6486002)(6666004)(6512007)(9686003)(478600001)(83380400001)(26005)(1076003)(2906002)(33716001)(54906003)(44832011)(66476007)(66556008)(66946007)(6916009)(316002)(41300700001)(5660300002)(4326008)(8676002)(8936002)(86362001)(82960400001)(33656002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?LDKz6ZSNV0t6au1z2MXKGF1HiieWjKcWGXVr5q8l/zpJ2v8muxYs+pJP34?=
 =?iso-8859-1?Q?w87eu3+ziw9gbkC/LainT+byYbn9dzap8CGSUWGcquopXGj3/2YamrdGqn?=
 =?iso-8859-1?Q?DBB8qmXjHp9cTmcOeKRpQ7OL6Nj1KeZ/2A1X4mRAvBoan3REVhuiVYd015?=
 =?iso-8859-1?Q?IsXkSjicnnrSGa8OpZxCqb5BQZ1izW+Ug8dMNyyTt5dEMUPQeBqYxcy/Hf?=
 =?iso-8859-1?Q?VU6MW62mJWdXJ2R2r29vEsk1FyZaZK2flzZLVMyp+JSLYeRXrtLDweGOim?=
 =?iso-8859-1?Q?iTdOkHsxHEUZZ/nvsFegeIoBcI4hnSMPDAkPvIkckAPclLNYRIUeB9K9HU?=
 =?iso-8859-1?Q?oY8+JibooTeFsGuOWyM9+gL55Km9H+SZakgOQuWOGV39+brSiY5DUW5jJp?=
 =?iso-8859-1?Q?eHWoJH13379vRpVS0NBCqFpIPJ7HFwJDFhSzmBDN/eWMTKTJ3Le2du31ux?=
 =?iso-8859-1?Q?XVhqq0A0NJtSAXcgcxVPsx0LA/tj0fL4tpBBDUz2OToA+DaqSdVpnc7lPc?=
 =?iso-8859-1?Q?B4V7jv2zos4Q5E/Af9fewgZ/jVp5m8A2XHe2YQJMP8DQCgq+ZV0rFj4d6Q?=
 =?iso-8859-1?Q?zhqjjtYoBNqpxxCcsWzc01nlDHBfx/uNXWd5VLTuwgpO442HyS1HiYKKtu?=
 =?iso-8859-1?Q?6LYnHAxBk4M8ofwVAcd6WIMVld8pYXV7Ieb0Q8wsNd6QIGufEVzr69tnFg?=
 =?iso-8859-1?Q?zXpyYbFYD9sOtkWQgIzClHikXPanz9vz1rRgUEZIcvdvsQv74QumoSrjjp?=
 =?iso-8859-1?Q?ohqsvEKK76lcavhLyM3lycX5rHSmJDImRIATEaHSB3Gq+bziQvIECevXAY?=
 =?iso-8859-1?Q?fLXusB4Qqru0R09K0b2vhRQqyFk2QorMqS4yC7dMAbgNmx5gRUvR2tDsrl?=
 =?iso-8859-1?Q?QURSYhkYsocUgfr797Lk/w66rvL45Z9TCsLhb86RV0fPLBuQKQF/VZu/xN?=
 =?iso-8859-1?Q?400uA7veOwIDwRra4xPsQcxzi/2JgDURqDAH9YHHiuM7wMnFv44uj2p1g8?=
 =?iso-8859-1?Q?wKIT3GnFVzemXRfrvLmky67mMlUn0y0e0dJS7h2mK3DL4oqAn+Yid7RiGq?=
 =?iso-8859-1?Q?J62dWmo6HZjqMlUyrCj+pfo1ihWH4A/gkO9c0nIt/a7sYHAdUqwEv6ihvJ?=
 =?iso-8859-1?Q?21HdCUW+vqAij7IWc6IZQmNDhJG1yDPV91e3pGlu17P1Z9XRNWVxVuM2Vz?=
 =?iso-8859-1?Q?OBjjFo3018oSPxbaSJDUg6ipygqjM/BYg8EAd8s0cvbFR09L+7wuscfrW0?=
 =?iso-8859-1?Q?/s1+vD1piS0WpAdKEbkXQms2ReZbJq4WisDPr7rje/p6jyvFlP8fIlMnEP?=
 =?iso-8859-1?Q?3YHYb1XLxlZZKkjxw3DjS5+YjCNoljv6samNutUHInX9t12qsOLWOFnS5Y?=
 =?iso-8859-1?Q?8/omOrwjK2zrAyxjvai+3dLKmxBt1ja0NjwnbzVgnI/hCffLC0fDt3/NDq?=
 =?iso-8859-1?Q?daG34jNeLN9FVfvb2KWIkPJ7EGlULTwtb21damG7EDk0HQLF9etPXPA8FD?=
 =?iso-8859-1?Q?XB4fG54wx8VLvuBritvTdXtai0yUHGeRd6KL4N5yoLeLaQuvyEWy5Akqy5?=
 =?iso-8859-1?Q?d1iYtvGThGCAyR7sAkl+CP3lLH1dn0VPSDq60iFJr9q51buGtOdgpyr9WE?=
 =?iso-8859-1?Q?9SKZnkwcnXWw/vzG2NrGlMEif/rKA+bBoN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4d5329-dde6-4f5f-db82-08dbb2bc2dec
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 11:42:29.9874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /v9H+CMaNFbSHjgXNrSA46wUU49LERUBH/zYjxkv4l5dUQeRCkQxY2IB0oU0HjBUYfbuccwD2jJGXYv8VECDaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5566
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

Hi Pierre,

On Fri, Sep 08, 2023 at 11:43:50AM +0200, Pierre Gondois wrote:
> Hello Rui,
> 
> On 8/14/23 10:30, Zhang, Rui wrote:
> > On Mon, 2023-08-14 at 11:14 +0800, Aaron Lu wrote:
> > > Hi Rui,
> > > 
> > > On Fri, Aug 04, 2023 at 05:08:58PM +0800, Zhang Rui wrote:
> > > > Problem statement
> > > > -----------------
> > > > When using cgroup isolated partition to isolate cpus including
> > > > cpu0, it
> > > > is observed that cpu0 is woken up frequenctly but doing nothing.
> > > > This is
> > > > not good for power efficiency.
> > > > 
> > > > <idle>-0     [000]   616.491602: hrtimer_cancel:
> > > > hrtimer=0xffff8e8fdf623c10
> > > > <idle>-0     [000]   616.491608: hrtimer_start:
> > > > hrtimer=0xffff8e8fdf623c10 function=tick_sched_timer/0x0
> > > > expires=615996000000 softexpires=615996000000
> > > > <idle>-0     [000]   616.491616: rcu_utilization:      Start
> > > > context switch
> > > > <idle>-0     [000]   616.491618: rcu_utilization:      End context
> > > > switch
> > > > <idle>-0     [000]   616.491637: tick_stop:            success=1
> > > > dependency=NONE
> > > > <idle>-0     [000]   616.491637: hrtimer_cancel:
> > > > hrtimer=0xffff8e8fdf623c10
> > > > <idle>-0     [000]   616.491638: hrtimer_start:
> > > > hrtimer=0xffff8e8fdf623c10 function=tick_sched_timer/0x0
> > > > expires=616420000000 softexpires=616420000000
> > > > 
> > > > The above pattern repeats every one or multiple ticks, results in
> > > > total
> > > > 2000+ wakeups on cpu0 in 60 seconds, when running workload on the
> > > > cpus that are not in the isolated partition.
> > > > 
> > > > Rootcause
> > > > ---------
> > > > In NOHZ mode, an active cpu either sends an IPI or touches the idle
> > > > cpu's polling flag to wake it up, so that the idle cpu can pull
> > > > tasks
> > > > from the busy cpu. The logic for selecting the target cpu is to use
> > > > the
> > > > first idle cpu that presents in both nohz.idle_cpus_mask and
> > > > housekeeping_cpumask.
> > > > 
> > > > In the above scenario, when cpu0 is in the cgroup isolated
> > > > partition,
> > > > its sched domain is deteched, but it is still available in both of
> > > > the
> > > > above cpumasks. As a result, cpu0
> > > 
> > > I saw in nohz_balance_enter_idle(), if a cpu is isolated, it will not
> > > set itself in nohz.idle_cpus_mask and thus should not be chosen as
> > > ilb_cpu. I wonder what's stopping this from working?
> > 
> > One thing I forgot to mention is that the problem is gone if we offline
> > and re-online those cpus. In that case, the isolated cpus are removed
> > from the nohz.idle_cpus_mask in sched_cpu_deactivate() and are never
> > added back.
> > 
> > At runtime, the cpus can be removed from the nohz.idle_cpus_mask in
> > below case only
> > 	trigger_load_balance()
> > 	        if (unlikely(on_null_domain(rq) || !cpu_active(cpu_of(rq))))
> > 	                return;
> > 	        nohz_balancer_kick(rq);
> > 			nohz_balance_exit_idle()
> > 
> > My understanding is that if a cpu is in nohz.idle_cpus_mask when it is
> > isolated, there is no chance to remove it from that mask later, so the
> > check in nohz_balance_enter_idle() does not help.
> 
> 
> As you mentioned, once a CPU is isolated, its rq->nohz_tick_stopped is
> never updated. Instead of avoiding isolated CPUs at each find_new_ilb() call
> as this patch does, maybe it would be better to permanently remove these CPUs
> from nohz.idle_cpus_mask. This would lower the number of checks done.

I agree.

> This could be done with something like:
> @@ -11576,6 +11586,20 @@ void nohz_balance_enter_idle(int cpu)
>           */
>          rq->has_blocked_load = 1;
> +       /* If we're a completely isolated CPU, we don't play: */
> +       if (on_null_domain(rq)) {
> +               if (cpumask_test_cpu(rq->cpu, nohz.idle_cpus_mask)) {
> +                       cpumask_clear_cpu(rq->cpu, nohz.idle_cpus_mask);
> +                       atomic_dec(&nohz.nr_cpus);
> +               }
> +


> +               /*
> +                * Set nohz_tick_stopped on isolated CPUs to avoid keeping the
> +                * value that was stored when rebuild_sched_domains() was called.
> +                */
> +               rq->nohz_tick_stopped = 1;

It's not immediately clear to me what the above comment and code mean,
maybe that's because I know very little about sched domain related code.
Other than this, your change looks good to me.

Thanks,
Aaron

> +       }
> +
>          /*
>           * The tick is still stopped but load could have been added in the
>           * meantime. We set the nohz.has_blocked flag to trig a check of the
> @@ -11585,10 +11609,6 @@ void nohz_balance_enter_idle(int cpu)
>          if (rq->nohz_tick_stopped)
>                  goto out;
> -       /* If we're a completely isolated CPU, we don't play: */
> -       if (on_null_domain(rq))
> -               return;
> -
>          rq->nohz_tick_stopped = 1;
>          cpumask_set_cpu(cpu, nohz.idle_cpus_mask);
> 
> Otherwise I could reproduce the issue and the patch was solving it, so:
> Tested-by: Pierre Gondois <pierre.gondois@arm.com>
> 
> 
> 
> 
> 
> Also, your patch doesn't aim to solve that, but I think there is an issue
> when updating cpuset.cpus when an isolated partition was already created:
> 
> // Create an isolated partition containing CPU0
> # mkdir cgroup
> # mount -t cgroup2 none cgroup/
> # mkdir cgroup/Testing
> # echo "+cpuset" > cgroup/cgroup.subtree_control
> # echo "+cpuset" > cgroup/Testing/cgroup.subtree_control
> # echo 0 > cgroup/Testing/cpuset.cpus
> # echo isolated > cgroup/Testing/cpuset.cpus.partition
> 
> // CPU0's sched domain is detached:
> # ls /sys/kernel/debug/sched/domains/cpu0/
> # ls /sys/kernel/debug/sched/domains/cpu1/
> domain0  domain1
> 
> // Change the isolated partition to be CPU1
> # echo 1 > cgroup/Testing/cpuset.cpus
> 
> // CPU[0-1] sched domains are not updated:
> # ls /sys/kernel/debug/sched/domains/cpu0/
> # ls /sys/kernel/debug/sched/domains/cpu1/
> domain0  domain1
> 
> Regards,
> Pierre
> 
