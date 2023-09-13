Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8478279DE72
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 05:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjIMDCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 23:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjIMDCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 23:02:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5AC1719
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 20:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694574152; x=1726110152;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1CSis5LcZjL2WO/8w/JrLfbTsmAue/C1FUCi69LcqI4=;
  b=n1g+rnH4rEfe0b0Jus7c3A1nMyKFIlc2XUxpDl9iTGBudhhbkLmum5kM
   w7iEiyQAR0f5EusjPw1ltAUid4izw/yBYaw6WXiSLnUkOCnSpUHwsxJNC
   XPpjT1aw31VtBg2l3tD/vjFmqG8kl/0YgO1pHQwR3CSPL1oxASf0/36rS
   xmzjHVP1JC1YlsfYrShUtDl4bZtmH43i51P8CYBBls25VnG8/DAU0iK+W
   l4WM8aFEKac1RvDSHE23sy/N00eiovzljRMRSVF5MrOMTfeISHcy/4keY
   am/ey8ayPs10Iw1bEc3Vb8TNYjOKhjpOt+tDkKjP/W5TyhkiPRO8M8V3g
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="381250494"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="381250494"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 20:02:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="747137358"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="747137358"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 20:02:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 20:02:30 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 20:02:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 20:02:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 20:02:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsMpBy4lEcrAZHeQrbwvJ7NBo8BCjmPlh4pSYkJfOu3rj3jWTtZ4QULM/pdpGS/toRTpZA/gVvv7NOoQv3RSQjiJ+pDDcETswqgDlU3+HvpbRWix7SnIO7TVZyUNpX2gaFJ5rdF90ryCzzb3468vy/NbQvs/9FOxBrST4chX5nsRge4JLr+/RLRUM2FxUOe50rKJvBoDVUxo2fXEaDsyie0LleSWCQ2AJJjhio0vFdFu3YJN0ZkDq8oCnGBD2WSjsNDFdpBx5W9MeaBcUiqHIxPQYDeppM57yH2jdOQqwMHjcYglLg/uFv8L7fFBVdY4DlID2dXjxHpFdS7mp8UE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmI/AAxAjE9J6eAaeq+SN6a0DflTEa+knNl+obUs28Y=;
 b=gA3h0Ll24uOhecAi8j31h43jpFP5YdprPQs18gaAK6KTu+Z6N0fX+sXteGQfiqSn8oH3P9GzKWBi20ewy1xJhnSmcbFZSu4FHilEIdQCyuTDjzPc9N6At2zkjiFMVpLXWwTJigX7Xp7pQxXvtknfuQhfDqqkZCfGEMVIGTfxzZ44yKuXPc5eIfxOSohOYEHH1Zvbc789oT35BNMsTmxAvGnbFgEpSmtSpzgdVSDzw3+ry2xUSoG8C/gwPuY8W/V44qKtQF6DgYiZFBXf09aRHPCZ/kl6/xQ+EvNDl2uFU2TvYjnloXov1USJD8rKWWOl7SUdi+2dh1sY98zSFmcVYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by BN9PR11MB5450.namprd11.prod.outlook.com (2603:10b6:408:11f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 03:02:28 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 03:02:28 +0000
Date:   Wed, 13 Sep 2023 11:02:13 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Valentin Schneider" <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] sched/fair: skip the cache hot CPU in
 select_idle_cpu()
Message-ID: <ZQEmNWe2iiU1/O+L@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1694397335.git.yu.c.chen@intel.com>
 <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
 <30a7ff14-3f48-e8cf-333f-cbb7499656e3@efficios.com>
 <db8fa2ae-317b-1c5a-e23f-9d3396165c45@efficios.com>
 <ZQBRIUYT8PE/UbZe@chenyu5-mobl2.ccr.corp.intel.com>
 <244ff1b9-c51e-be9b-0755-757f969b36e1@efficios.com>
 <ZQByY4rDvjejRRs5@chenyu5-mobl2.ccr.corp.intel.com>
 <2a47ae82-b8cd-95db-9f48-82b3df0730f3@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2a47ae82-b8cd-95db-9f48-82b3df0730f3@efficios.com>
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|BN9PR11MB5450:EE_
X-MS-Office365-Filtering-Correlation-Id: bf47b5dd-31ac-4f51-a499-08dbb405dd27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ao5Wtv0EOFvePbMBWjd9C5zctGOAT0AB/VOMWn8ipabQgKJIgT1PkN4ThvTkYjh3QnsDZ5lKpuNX08iOxUZ5qUMYjug/6IUIjxJoizNAVrv3l2aDNOaq5hCCfzubMmISCg9r/p2quMSlix4mrQegvHduDFm1bOoCOPyoPN957SxiSNEAhvt/A1i/T2CxV1gx80cyVLjKZor0Gr93L2MgBlkGxeqtxsf6ItSKOyKlG6MNfYHDImylzDAd39yWdPI6+dIEhhrPIJjvz0j75jOdZydf7n/Icqt/objmWYN7iFQSL5zX2sSrZNy9ephuLhpZ53M2A7ENq6LUMuNEQaTOEMK4pGGkfzuWG7bba3Av+lISzmL2pnWhHC7RMOohiEaxU1vIfJyhkDZ8VxkxzDSMG8vBpgFxbFS7xpZEgrs4lCP6iAobz+K+hi9Q/Vw5MfYmCHhFqEvZh4XPSX6JsHtigIGj2hv5/W+mipg9ifDZg3rePcyAkQLyQZheHnctQmdeRTZecYHxilb1R6q/7pbRymo96IMbPTsr3oJNzXQzzIQr8k7PRj1Ap7Y3mSMxd2y81fNWb63b8I13EC5hY3a6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(136003)(366004)(186009)(1800799009)(451199024)(6486002)(53546011)(6512007)(6506007)(38100700002)(82960400001)(83380400001)(6666004)(41300700001)(478600001)(26005)(966005)(66476007)(6916009)(66556008)(54906003)(66946007)(316002)(7416002)(5660300002)(4326008)(8676002)(86362001)(8936002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+oKVjPtzlWZioFTx5cfIiD6UmCkMNZp5Sv03VP14RLkgrTM+HHjUEeC6iNYW?=
 =?us-ascii?Q?bVIx00DU0T/zCuBN927RM7oV6UP69Mu4OylSZjHmpykETtxbxP/lPn6Vt3rA?=
 =?us-ascii?Q?huUQdRb1RxCXr++lPyVzy9JTUg/F4PVU86Yse0sdYO8FvWhcF3C6WdVp8Xa5?=
 =?us-ascii?Q?xSTzi+CaobTBVR2DUX+F5zv1GKy51JHkkEN3fLLQyLoqBStLxklOAs78fd6y?=
 =?us-ascii?Q?LImV0QaX+lb55r3kj9DebP+nxNUFoh6HWepadmzt0e5UMW79moGjsMSoNKt7?=
 =?us-ascii?Q?YgtD3zrAQfcpnkaAj26KWfho2XozCYL44IQ2Xo6vRfVf2ux8qTEhn0SQZtfi?=
 =?us-ascii?Q?0xuoTHoghrbjJOPgBlynZpYp8CVfFp2ezGwjW3Ag/5rmfPGiYpBmtREvfcIm?=
 =?us-ascii?Q?KOtyL95jso2zL8krKnjvwY/du1Ik8PKcdEWUaUGeZgfK+rdMrTN1oIcq64mD?=
 =?us-ascii?Q?uXaTnZnl//Yo59UNWDHj+6n5F5SQqLl90f11j/37PTJaVjaDCF8pEN8ANvhz?=
 =?us-ascii?Q?UBtkEcN2hzBg0dnjmo9kgLxRVYQBpkZensZKUm8XXg5M6ekhONiKN18ArjoU?=
 =?us-ascii?Q?VX+hvUjeCnDwyk/8CKkZJoblh2BUSQhTsG590JnST/HAZhL029gSDuhCsmdZ?=
 =?us-ascii?Q?zN9zxbKevAzDAmH7TJbtbcE5qTJAGJBUIlHkL8y6Sb0V2OQcPzr0Crvze04n?=
 =?us-ascii?Q?ZCXvH5agCeoFASYbT7naTf+F+PJx/T6803OWyQX3Mluc5YUKfR8uT2A5Qwfk?=
 =?us-ascii?Q?1dTXObOE7mDoyuacXPdbkVezMnt5/A4JUZQhOZOh3y8TcF4GiuwL/lmMzBvx?=
 =?us-ascii?Q?FfLBKCZOqGNkW8fRui5IhfOJ9Isi4MGAnVhNYRGWa+LDUOlk/33Rvdo2zH6w?=
 =?us-ascii?Q?/xcAOPdmTKUi689daJjkZmvH6ak5jECYeQT5sWKbDsv/z9ya8wh9aQAXstms?=
 =?us-ascii?Q?MDheoNmCIAIKZRiXhtIQ3Q1D6I9u5I1xS6PefLgBrQ0PZXqs/Ws8v17ww1WV?=
 =?us-ascii?Q?QBPbVvfahaBPDjN5KukfootjVRm2k5An549SI/d+u5RxW+VPdMeEdSNhS5yL?=
 =?us-ascii?Q?1oNHf4P+TXDz7chTzZxhcQRGDNxY4hKisD+6fsxHliQPMVyXyeyOUt3oF7db?=
 =?us-ascii?Q?Dzk9OcpR0uzIjGIHOxww4BEMcb2lr7wvjZhThNFPQ+1YSYotdSd1iYuABGEx?=
 =?us-ascii?Q?se5V2SVFZyacszDrrFR8FnzJq5ZbLeWSUz8rwZPBpR3hCu9FLyS3abNJ4sZS?=
 =?us-ascii?Q?CZ6l7W+4c2PkyCda9huR9xecnjg+giqR7jqkCD5xgBnQjkh7LmcWbduAUVtz?=
 =?us-ascii?Q?rWi79sZl7A9CCJOsJLqyFSAk8/Wtk/h34/mHpQsh57XU77hVPLt/TeWXJPCH?=
 =?us-ascii?Q?ce/kV6C8k1bVfBTfgklycfvB+WAYd4++3EPGshaGmv/VBFQ8bU7m8kaynWWO?=
 =?us-ascii?Q?cgezrsBaUfreUvJn6Q/DZ9tTvLfmnN4nqWHR7VDS8F0IXJfYePyCwGEcZFx7?=
 =?us-ascii?Q?Q9OjwDbGBCQLr0vaRzJnrCVz78VC/Bw9tguZQ4yOJwn/iNTu62IljpgzjQ44?=
 =?us-ascii?Q?OiND9InWRN16YVAgdrm2Gcn6laD9UqFfxLuhbNuz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf47b5dd-31ac-4f51-a499-08dbb405dd27
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 03:02:28.2507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuG1gQpxvoKDD/SxREF3aT9Kd62eOh2l3DCOnpR0k2MxTwoEH+h/U1bQ+RKvwlcijH6ZTOiE/Icz26SlqxDX3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5450
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-12 at 11:18:33 -0400, Mathieu Desnoyers wrote:
> On 9/12/23 10:14, Chen Yu wrote:
> > On 2023-09-12 at 10:06:27 -0400, Mathieu Desnoyers wrote:
> [...]
> > > 
> > > One more tweak: given that more than one task can update the cache_hot_timeout forward
> > > one after another, and given that some tasks have larger burst_sleep_avg values than
> > > others, I suspect we want to keep the forward movement monotonic with something like:
> > > 
> > > if (sched_feat(SIS_CACHE) && task_sleep && !rq->nr_running && p->se.burst_sleep_avg &&
> > >      rq->cache_hot_timeout < now + p->se.burst_sleep_avg)
> > > 	rq->cache_hot_timeout = now + p->se.burst_sleep_avg;
> > > 
> > 
> > Yeah, Aaron has mentioned this too:
> > https://lore.kernel.org/lkml/ZP7SYu+gxlc%2FYjHu@chenyu5-mobl2/
> > May I know the benefit of keeping forward movement monotonic?
> > I thought that, should we only honor the latest dequeued task's burst_sleep_avg?
> > Because we don't know whether the old deuqued task's cache has been scribbled by the latest
> > dequeued task or not, does it still make sense to wake up the old dequeued task on its
> > previous CPU?
> 
> Here is my reasoning:
> 
> If a second task is scheduled after the first dequeued task (a
> task with large burst_sleep_avg) is dequeued, that second task (with
> small burst_sleep_avg) would need to entirely scribble the other task's
> cache lines within the time given by sysctl_sched_migration_cost, which
> I suspect is typically not very large. So I doubt that the second task
> can entirely kick out the first task cache lines within that time frame,
> and therefore that second task should not move the cache_hot_timeout
> value backwards.
> 
> But perhaps I'm missing something ?
>

You are right, the reservation time itself is not very long, unless someone
enlarges sysctl_sched_migration_cost in user space. Keeping the reservation
time moving forward could help the first dequeued task to be put on its previous
CPU easier(if the second dequeued task has not been woken up yet). I'll modify it
according to your suggestion and to see the results.

thanks,
Chenyu
 
> Thanks,
> 
> Mathieu
> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 
