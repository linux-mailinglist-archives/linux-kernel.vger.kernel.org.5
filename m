Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF28E7A5D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjISJCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjISJCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:02:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CE5114
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695114119; x=1726650119;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vSi/dd2lEL0DStaH81pi59SVbnSwo4RV1iJuWYZSKj8=;
  b=IR7/BGEBw0fAAfmNUZAceQ5XKPLOTr/AX7PKbXACz/yxLMHW26ij3t4N
   F2PU6t26BLKtrHrrrWzQu3ZkJlwrZFI4nNlCH+VETEWrLwlhSBtR0p9na
   xfKYyI8+wWmImcqcJKB+T7TkU8XzaJYEfipTLB/S2Be5pV5yV/eDyQNNv
   mvgLHzxjw9His7D/4mN6grAnwwb6pQTjF47X4zyeIPKSvqom4SHVG6RDU
   Y2UgQ+mIX4QED6ta42TpM5xk6DotmcBE1rNe8r6NT1Dj4lh1nhhKEhW+u
   5mX/fDDXNoAJ1KBbTPGf8SNW7AK/WUvThvCQBQJHTnFZISye53yDMtKU2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="377201186"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="377201186"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 02:01:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="695833360"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="695833360"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2023 02:01:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 02:01:58 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 02:01:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 19 Sep 2023 02:01:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 19 Sep 2023 02:01:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCfsQF/iMfoN2sZGqCNcSAbtFOJFgAv28P4jua7TxUnCfBonXx6SFqLYUzmDmYxC8HZmumEHYfJnd700cdpKZcXcL9DvnD9RvD/TK5hkF1oW2bZcyQY7fPGJQZPwAIpID4zjjFc9mjqTsdjl6WFvn28l0ADID5VVbXOvTQOAKhjo87Rj8gmoeSifznNHFZPWZ+XqYMS7gisWvMeDEsotIn9K3hrht8eWV0WuUT8DJHlnBnypdxq5qf7XRD8IkrwbD0np+ANTzLPbQs6Ek932WH4/aI7ba1fu+5KAcjypLcAVfhS+FonYTpFL9fKqJ0CNOPLJI7cqdr9YuaJ/5vDFbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WK7h/0SjDEGmZKx420Kza0whaCV5QjeGNAFOBpwa6cc=;
 b=MzQCWFG0gd0h8TWsgK0IFdvUMok3UGeHQL93bnFJVByrSad29RWaJrdc1HJ6Iy1L303QV7me0RcDwxgVJP2EXXE8X9l02J+U6UIz1H8YglE04fa247Ai7VOn/vCW53YNh2lN+uLfyz6wxNjJRh/VnYC3Z/t2rAaPyQsaAZ1dnG8SFYn4eWAN+mA5ohX1wLs8YVOl+P7xDpW5ykoYqRzQ/46u2yilSgOyHTPlZrm1+tZrAFFnhs67RevRkcyHUbQBs1hGo7BfUrQTmQHCfGFrMnlXh1hOEdSor11e1Btt6AXzT5MR/e2UAY1AOUvDLjO+eWOYDoPYgjYaooJA/fhlGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH0PR11MB5660.namprd11.prod.outlook.com (2603:10b6:510:d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 09:01:55 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 09:01:55 +0000
Date:   Tue, 19 Sep 2023 17:01:38 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
CC:     Aaron Lu <aaron.lu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "K Prateek Nayak" <kprateek.nayak@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] sched/fair: skip the cache hot CPU in
 select_idle_cpu()
Message-ID: <ZQljcps+nrRxSLh4@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
 <20230911072629.GA298322@ziqianlu-dell>
 <ZP7SYu+gxlc/YjHu@chenyu5-mobl2>
 <ZQFVFv4GcPOU+X7N@BLR-5CG11610CF.amd.com>
 <ZQFj2hk4i1QAWEQp@chenyu5-mobl2.ccr.corp.intel.com>
 <ZQKw+W7k+XNweKBu@BLR-5CG11610CF.amd.com>
 <ZQL39qpKQncZWs94@chenyu5-mobl2.ccr.corp.intel.com>
 <ZQR1tovjkTZ0VcP6@BLR-5CG11610CF.amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZQR1tovjkTZ0VcP6@BLR-5CG11610CF.amd.com>
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH0PR11MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af063f3-3ce0-4161-d426-08dbb8ef11f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MQm+9aEuQR+H9juQKYbZ9sTboxwZKIuTAfgd4kyyuxl8MGfkzWl/98IU+7u+6jNJRHT94pHwqStX2tTOHo+AMm5XFRGC/+K2fIYZn6luzC9MHyUe/xSzTgsIpPjsVPVZv7DaQlKZb8LlMw76jN4RYA71RTSMuNujHBPRksLXSO3wpclecKf5AZvhVkJ3+kOr0RVo81nUk00Saut0wvLqphX0pFeY3nd2OAR+pGvnnspz0hSaquvdSRGyazUXRMzjmxXuseQ1slPU7NyCZnLZza8NfSQOhOHGhMQWDGLp/IvdXk46mQFJiVlAYHDJDNIJ6vH574ZgNdTcH0MmHqq16D3H15QtuzwL3l5znTwWSz+uDBHXk8Qtg21mNagxn/m0sqk2mXXz5sv9vlym5Rnbm/o97y83ZoL7BhqD+DzYTboDlhAB9eaP1j6xAUT9g26i3kiSLo9PYwdL9Kz/Hr49Pc4MSbd4XraBj1vdMAkgBRHlGlJ05KEgu8Kb4vTZqFOb07k0SSxlPrw3h++ReonNMaqVhuWDCC9hCWqBtlyFm+Bbqk0gCSaqOsO45P9jnh5Z/0XjJwuM9l0k38mNCJn3DXoG8U2srFxfQcCfsyGAWk0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(1800799009)(451199024)(186009)(7416002)(2906002)(66476007)(54906003)(66556008)(66946007)(86362001)(966005)(83380400001)(478600001)(6512007)(6506007)(6666004)(6486002)(8936002)(8676002)(5660300002)(41300700001)(4326008)(6916009)(316002)(53546011)(38100700002)(26005)(82960400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BYi25fU7iVqifA8egIzdg6CPoBKziQARdzK6j1Gt8enwIaXw8nymU9f+uQTL?=
 =?us-ascii?Q?7RMHbkdwdTbXO6OeAFIlSDbO309vfcsvQIHIrHRnaYkRbRWT75p8X3mgmRVF?=
 =?us-ascii?Q?Qb67AdIMRxtjIVAN6CP2Nf4ka1BD++QR5tIuqYeQbovWSMyLk39WLXNM5TzI?=
 =?us-ascii?Q?UDytXTqJbGLQ/VsipfYMgJGkl/Q3tNJDLjCWSsn8lfgEnkrY8vpnh8QTao1H?=
 =?us-ascii?Q?GCN6qSMqQyMWZX89d2w2+lPdnPWng5AV0aR/DfKbKtOCzzCywMuT/SLgtEwk?=
 =?us-ascii?Q?qWPgAjia8vi4mQ9o1DvRstdqTe6wsFyMAwUtSuMX8qD8lXTbzDxoCdSe+gW6?=
 =?us-ascii?Q?1qSkxtvoWYwO+xp0FOTPgTPGCVgkXS9und8z9cJQKgOGQISqwhLrMSgLEGid?=
 =?us-ascii?Q?+pSfXrIkftgIUwU4ZZFFE+FhMchjScjynsJN3v2QcN7bGJZThB98tGDw/ZCI?=
 =?us-ascii?Q?lOYeCfp3UbxW3pmHFsm2HVY53mOTXdfO971cL2PSkheYXikXaQ5QE9u4Lzhb?=
 =?us-ascii?Q?SiWsP4Ko779itkoE/Ile8sU8hC62X9kR4jqwU4FSc5NjjoxPr7vzL6sHDc31?=
 =?us-ascii?Q?pkT0fHA3tJnKDUAv2duJEKtN9/H4S1nI99wRxgy0S1Uk8W0+ivULTgLn6/DG?=
 =?us-ascii?Q?k5d6Z8nqHt6KhxzpZZb6mwRKLTag1GQxT4bMvJChZBtqCEnjfLm5U2uNcqVo?=
 =?us-ascii?Q?n0JGDRgwIdy9NhHcchMDX3RSOt6MsUNLa+AVg5UV3XKnfHJNUTD3Jlg1Suhh?=
 =?us-ascii?Q?8HIF6/tto7Hzm/FWQQUd+TKFBc/+l+I+QsMAGjKEBxzGUfqYgc8+z5Cfo93H?=
 =?us-ascii?Q?Fwri0iyLmxtbtnZn60v10Fs6hud03/+i2nEdTEfeRijUIscSA45w5ZchO8mp?=
 =?us-ascii?Q?Y5xMqlFr2xi5fKlSR3DM7JzJG+58IhBqbkD/lZV1oDkOGfFNFn3LxfGqyEXw?=
 =?us-ascii?Q?vHeE/iYbFeJ7Zm95SFNDUE2tdWW0va4vjx6mOOgr8dwi5WlEX5vU2wyolvU+?=
 =?us-ascii?Q?ASzbQIlzQ8vXEhQqCVmqGNEBjdRMKm/93xVsOLmNZx5/cemBJi2U9BeUR7WH?=
 =?us-ascii?Q?pNC8i1y6r0EhmlkVIcL8JnyXCmz2qqYq0gzUqsUzJu3OYvLXmZ6+QpM9eLP3?=
 =?us-ascii?Q?WJpsVCLTj/5glATPggrRn3Gj2AKBOnLlQGm6a5p9Idi6ZMXX7uapXKuVBuM5?=
 =?us-ascii?Q?hZzfVTprm4+5kueUEmPmO+QSj62Xujb/7fVblWD6nG3EFkdv9eX6QCbvJePY?=
 =?us-ascii?Q?/0iCM8gZOh9Fy3f/L1OfPCOYRYV2gGofpU4qs2QcYafotw987Rrllf8Z6EHG?=
 =?us-ascii?Q?kCANgodOV/VhWi64UWC17HkEdy0WISL/xnahfdqmNmTc3ciwhbBYRoF2bIph?=
 =?us-ascii?Q?ZPExufI57afJBdNArAiTpN/LgSjVmAm+NRJ9Ajw3MFMFZJng5erUvxgfgMj0?=
 =?us-ascii?Q?E0baw5U/6VphjaCJFyn7t4kTRCYgVzOSZhef4/aLE7ZLcuHElL7LTEALNh2O?=
 =?us-ascii?Q?YD2vG4FXunIL/DJsdS/P6Cg3Z371ffT2pbeOx4EO07GZSMokgGWVQKIyOK1p?=
 =?us-ascii?Q?edA+Z1uR91L/z0SjMy8mFDC6JM7RBENaTmT4N2Hf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af063f3-3ce0-4161-d426-08dbb8ef11f2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 09:01:54.3206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oJENrNAv0z420iAe2nGb2Bau73bM+aU4u3vA/j3rYCxtd2kB1GyY8qZQedUcMKDQmCYLtHxM7KOpz7Xhhhasg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5660
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gautham,

Sorry for late reply,

On 2023-09-15 at 20:48:14 +0530, Gautham R. Shenoy wrote:
> Hello Chen Yu,
> 
> On Thu, Sep 14, 2023 at 08:09:26PM +0800, Chen Yu wrote:
> [..snip..]
> 
> > > 
> > > So despite "reserving" the CPU for p1, which is likely to have its
> > > data still hot in the case, we would have scheduled p1', thus
> > > defeating the whole purpose of reservation.
> > > 
> > 
> > I see. So you mean, although we reserve the CPU for the wakee,
> > the wakee might not choose its previous CPU, which is against our
> > goal.
> 
> 
> Yes, but only because some other task could have run on the previous
> CPU. That other task could be something that was woken up on that CPU
> due to:
> 
> 1) wake-affine choosing that CPU 
> 2) newidle-balance pulling the other task on that CPU
> 3) !wake-affine && that CPU was also the other task's previous CPU
> 
> It could also be due to this wakee task being woken up on the waker
> CPU due to wake-affine.
> 
> > 
> > The reason to prevent the wakee choosing its previous CPU could be:
> > 1. wake_affine() choose the waker's CPU rather the wakee's previous CPU, or
> > 2. the wakee's CPU has already been taken by someone else, via newidle_balance().
> >
> 
> 
> > For 1, I think Prateek has expressed the concern. One mitigation method could be
> > that, we give penalty to that wakee, if it decides not to choose its previous CPU:
> 
> We would be penalizing the task for something that the scheduler
> decides :-)
> 
> As you point out below, in the presence of the WF_SYNC flag,
> wake_affine_idle() prefer the waker CPU over the previous CPU when
> they are on different LLCs and when the waker is the only task.
> 
> This strategy makes sense for two reasons:
> 
> 1) The wakee may be consuming the data produced by the waker.
> 2) Since the wakeup will happen on the local CPU, there is no risk of
>    task-stacking, exactly what your SIS_CURRENT patchset was
>    attempting.
> 
> But this strategy would also result in increased task-migration. Which
> both Mattieu and you have found is not so beneficial for workloads
> such as hackbench. Is it only because task's data is still hot in the
> previous CPU's cache ? Or is there more to it ?
> 
> 
> It would be good to confirm if this is why lower migration is better
> for these kinds of workloads.
>

Right. According to the previous hackbench test for shared runqueue, higher
migration brings higher DSB miss rate [1]. I'll collect some statistics with
this patch applied to confirm.

https://lore.kernel.org/lkml/ZO7e5YaS71cXVxQN@chenyu5-mobl2/
> > 
> > "
> > new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
> > if (new_cpu != prev_cpu)
> > 	p->burst_sleep_avg >>= 1;
> > So the duration of reservation could be shrinked.
> > "
> > 
> > For 2, maybe inhit the newidle balance, something in my mind:
> > 
> > 
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -12022,6 +12022,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> >  	u64 t0, t1, curr_cost = 0;
> >  	struct sched_domain *sd;
> >  	int pulled_task = 0;
> > +	bool cache_hot = false;
> >  
> >  	update_misfit_status(NULL, this_rq);
> >  
> > @@ -12055,8 +12056,19 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> >  	rcu_read_lock();
> >  	sd = rcu_dereference_check_sched_domain(this_rq->sd);
> >  
> > +	if (sched_feat(SIS_CACHE)) {
> > +		s64 delta = this_rq->cache_hot_timeout - sched_clock_cpu(this_cpu);
> > +
> > +		/*
> > +		 * If a short time later, a short sleeping task will be woken up
> > +		 * on this idle CPU, do not launch the newidle balance.
> > +		 */
> > +		if (delta > 0 && delta < this_rq->max_idle_balance_cost)
> > +			cache_hot = true;
> > +	}
> > +
> >  	if (!READ_ONCE(this_rq->rd->overload) ||
> > -	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
> > +	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost) || cache_hot) {
> 
> >  
> >  		if (sd)
> >  			update_next_balance(sd, &next_balance);
> 
> If the benefit that the workload obtains is really due to the data
> being hot near its previous CPU, then this seems a sensible thing to
> do.
> 
> It would be good to confirm this. Let me get some IBS data for
> hackbench which is the workload which likes a sticky wakeup.
> 

I'll collect the statistics too. Thanks for your time.

thanks,
Chenyu
