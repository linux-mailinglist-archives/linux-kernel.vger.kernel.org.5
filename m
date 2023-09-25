Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC827ADD5F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjIYQqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYQqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:46:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D1D9F;
        Mon, 25 Sep 2023 09:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695660370; x=1727196370;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F4qD+IpOK3VIwGIKVhLunQdTKw8JDhDq/eVL4amPK20=;
  b=CKAYEdB7JBMolWwHaKmPJ1kbRiwg15DqSITL/hPH5CSnquEdS4RvMeUP
   Hj/KWOlcCJpX245Vl39P+pGiG+I3zeSAXSoSLhFmny/EWyJ5D3cpDDNzi
   qCK2HXn5BTCHq+WqWiLUaV0n3VupCgKnnOVeFjePOssOlvxwqSf7pbPbH
   cdGNYeFxMsBOuN7e4JzI2vyNIun29aqWeGm8u89DeB3koNTivcU3hGWVQ
   KAuTxEPz/myWFA+ON6DbN1TZ02NHRBS7ZPt238dCUEcJzzmbj8z9lvYNV
   SlW4qFNOp5SCkcZ0FP62zymDaLtxuDYrQLpn/2/BAF3O2s5SQkXQx0Ev5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="378584647"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="378584647"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 09:46:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="838620316"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="838620316"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 09:46:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 09:46:05 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 09:46:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 09:46:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 09:46:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXrl9WNmzA/+VppuYWsCskyXuOGUYW9lNC6vSKNpZyGoJ4TJCpF6G5uRP/qgkO4/D3aSpOKGnJxooGARFZhZTnyD1b3pcHw+uPAezngi7gB35aB+P3N6n2aa+xORm4cMJ7W3ZIKvG/Hsas0FvBpOLuNzXK2Xa+4rffYN3IIgMRUjJZQjduY/s2Bct0iBkWMyDGh8FHijmI7fCFr1F0JgIoVY++uyBb2IId4CfrxMHMC3m8j2R7lhDUkYIVhI4DM/RicatiuHfHptIr0lhv6T1iTygNYg/6gpKE2oUT13nIxGwf0er2FZsKPPlqI0KH8TRsjIa+ZXV4GciKdH/SLDaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTU7hgzxCRz4Z/bt25vaHKZgjPM9LlPDUsTFiDfUtYc=;
 b=nJtMitnqjRC4/xvWwNsyQnqAWvklyn/zoTEJOws74AcYPvOclGP0/UVu9X2IKs/DVzXrxQrgUc8FOZFiP6XUG1EcDf2RP0D9vk3M/kpuoRNUUxKzMKDxOqFZu7pPFI3OwxpIJUTaa+zy6m6RVnIom6BVhJyn9+nsWKu4d+VEgpTiArk9uD9mVnttGCGmhsCNS6o1TII4At6onzN3md1LyyE6zTykl4T7Zn8WLKRIR3o52WZ4OIph+zjk/SIsYQafkIcWoto+hU/xiOWpfUNp/5/0z9KnsIi+K3P3G3EwzOMteG+I4smczXxhU6wj0w4IomYRjcI+GFqetGJ8lRATDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SN7PR11MB7510.namprd11.prod.outlook.com (2603:10b6:806:349::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 16:46:02 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%4]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 16:46:02 +0000
Date:   Tue, 26 Sep 2023 00:45:47 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Mike Galbraith <efault@gmx.de>,
        <linux-tip-commits@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH] sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER
 tasks
Message-ID: <ZRG5O93PFsxzF2BQ@chenyu5-mobl2.ccr.corp.intel.com>
References: <ZQljoiSBhZLEFI/G@gmail.com>
 <202309221758.d655aa5b-oliver.sang@intel.com>
 <ZRFp3EO2JUXtK6XB@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZRFp3EO2JUXtK6XB@gmail.com>
X-ClientProxiedBy: SI2P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::19) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SN7PR11MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f85243b-c7f8-46f2-0380-08dbbde6e6a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rHhOJRgmbD6jniXYbAyJjfqPUx8Ijy4ZoV+JBNH0+PIobRmc0gI/AfCAbeT/OhTRnkwvK6KZI4jeRqSjplK0ATi2V6IfiQrKLZleqwyqVyjikRFeesKLitRh/tzU4caSUUEDIYln/cHJjAtj5b7c5Rul4iHB+RM5bn0y3jfShIU4KxrqULiS7Gkf/OTQiVpXafor7oMpiDjB1WBgKyJ0qYQtYAImRyw3bTObJDfy8n4sCYHHngATu1U31aZz0Qcg8WoXqzWzwaI42pE3tnK1n3vC2xXkSKmh1saV3wBhbPG2Z4H/kKBKV/yHZtlguaB2cppOXjeSkXUIiy/Uxs3nNpEsKf6yBXUazDAQbZZfQcWmGoMuBR9OUKDW++Ov1KxIez8yxxRP6AEAgCEC1LC7Xe1SSk7xdoh8JEGQgojMxmDYwqC+xWnx/GWsrJUV4WD9QDGgz8sSUUhIce1j4SM2hw1EHWFPxd540SN5AcP4BxAaELFxhcTUSGh9A3td4XghGwktM2RM1uLJjc27skKG9NhXe8XUpGTf4/pvX1kVq1dC3/T0MzbhkJHjoIBjeXmj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(376002)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(26005)(6666004)(478600001)(83380400001)(86362001)(82960400001)(5660300002)(6486002)(53546011)(6506007)(38100700002)(6512007)(4326008)(2906002)(8936002)(8676002)(41300700001)(54906003)(316002)(6916009)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?erCZuqm/XI7gm1u5KEVAlWGDrnsHdDaEWoFv7S3XsVXyl5KxqoilWStvj67o?=
 =?us-ascii?Q?I52zXYNL7fF1mC+tb6Y8h/96u9Vm31WQuuxdxc26is24AL07Sr+AvEiiyy8D?=
 =?us-ascii?Q?66uDUmKnEVTFCjoyxPE38pTh3Fs/cF6ZHgpdB8BPZGKJ6twTKA7+DXyr7y+K?=
 =?us-ascii?Q?9pLN3DyQzfxgss8gfj4zzYB0DfxxFcvKH8j/mtnSXN1+YzLdWRurVNjTejnQ?=
 =?us-ascii?Q?ewJ6rxRE/hgrH9Ahg/ttLr1CCJyqza/PQ8uHckLxdDBVAsc6NhlDOKio8L9w?=
 =?us-ascii?Q?OaNIsfNZpj8sG+M0Hz1VPfyNIHysMMGtfCLqt1hm7iv8i6Hmgs1CmtJMmOYM?=
 =?us-ascii?Q?5hhkqy+GayQ2Ds8j63wX5Wr1Zw5BT4Nw2sW/YKhSB6rIRhtHFbRBZ8SZIWIA?=
 =?us-ascii?Q?K41o799TnYPoF8OE05l0JxqA/ZXbmd6sgX1mnqkWZqO/ta2briFWG70zg44o?=
 =?us-ascii?Q?OPd3BoViy9NWhBlYaAP2lX2uvnLGpYvlMS7zOvZmNxCXgZCVOzC7TZ8wjktt?=
 =?us-ascii?Q?zuTI3k7IheJgvtrGeezSg+zvHxS9/KrLI1ISL7LAKjXZAyd1A+h2Oq0gXXCe?=
 =?us-ascii?Q?cNFbm7v88uSz634sf5gbJSDjkWZ4CjDcGVBiH0fiqGZm+PRIlzbRjLolgSfz?=
 =?us-ascii?Q?dCpXFChoCInElBr2P/7iPpclhbNX/t5EskN7VYdUFwjnZme4ueaBhCXAdwwf?=
 =?us-ascii?Q?HnVoIg8xckpIbmP2kBxRyTCjWNW5cHtDUHPKxLOhKrHEVyBKSphO7zAPHYji?=
 =?us-ascii?Q?q3wMnpJCu7Euta/lI5V+1UN3s7T6oKcKS3ANWH7SjbYrAUkXFaIzsk4w+chg?=
 =?us-ascii?Q?LV8JpjaHvOduIQAIh1t3IaAWZWBhuTSN1TwUyAQSjX+DK07oUblkE9UZBure?=
 =?us-ascii?Q?KwdZfBhqtuAGpzgpIgj5My1L/XGwf2Yrc5kqXObhJB9eCbR3qqnSlL9BedNz?=
 =?us-ascii?Q?PoTZWuzs2xCC1PY3WToeAAZOhiWp4cuHqpgYblgTt4J3u1sTEApajFBunAhN?=
 =?us-ascii?Q?NiP6NysvRXk3eFQaUMkeXHPb8XZMP12s+BlDHMSG2CpsrJ7T28fMloR9HBKP?=
 =?us-ascii?Q?xswbVX0LlwH0lYKsfFVrtgdA/FDXCMMD/pow5lHe/cs/CQBZmKcGsHP5RbLq?=
 =?us-ascii?Q?A/+9mjYOoayUYCck9d3JQnBNDwbQL0l6ggoMnabfuSJeW2tu5DYbnrN4zJQL?=
 =?us-ascii?Q?1Bswp4v91ANsE8TJhE9B6rcLbzq49s/nc39Jgexh0+thBPMJkUajX1Ek4l1D?=
 =?us-ascii?Q?CFzlSKFZRSSkstr4U1yRt7SgNPsajNXSfa705VkrydUidNAV/kYdME831aQg?=
 =?us-ascii?Q?4uxIHZMv+sJus7BQsHHRhW2svY35rlZvOv/sutkVAT2SzJVFWtNveVj4nriy?=
 =?us-ascii?Q?UNC0S4m4vKWi+flatBRgG7EJ5aWMpYO4mSFvFVQNLxOnyaghqQIMssbOpuHk?=
 =?us-ascii?Q?ODjc9cAV63ETtKl55bL4go1NfZPuD3t1o9MJiFL0JrfALuFchKDB6DqQ21LO?=
 =?us-ascii?Q?pDGzTs6y3ak3wmZFi/FXJCGGSQGTYJmHlZ3MX8hx+U+NJsPyFe6MD7ZRKqf0?=
 =?us-ascii?Q?6pPQr/Xk3ADH0k+Pzh5MduiXULPR9pC1UvkPRdL2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f85243b-c7f8-46f2-0380-08dbbde6e6a7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 16:46:01.5112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNvjIlX/mlrfBWbNiWdw6btBYjfg39KKQJ/jKfqx603X+Mpiyxy7kGZupTZ9Rq8s9uTGWin0vDGqdbAFui/aQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7510
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

Hi Ingo,

On 2023-09-25 at 13:07:08 +0200, Ingo Molnar wrote:
> 
> Anyway, it's clear from these results that while many workloads hurt
> from our notion of wake-preemption, there's several ones that benefit
> from it, especially generic ones like phoronix-test-suite - which have
> no good way to turn off wakeup preemption (SCHED_BATCH might help though).
> 
> One way to approach this would be to instead of always doing
> wakeup-preemption (our current default), we could turn it around and
> only use it when it is clearly beneficial - such as signal delivery,
> or exec().
>
> The canonical way to solve this would be give *userspace* a way to
> signal that it's beneficial to preempt immediately, ie. yield(),
> but right now that interface is hurting tasks that only want to
> give other tasks a chance to run, without necessarily giving up
> their own right to run:
> 
>         se->deadline += calc_delta_fair(se->slice, se);
>

Do you mean we want to give hint to the scheduler that, in most cases
the tasks do not want to be wakeup-preempted, but some other tasks
want to keep current wakeup-preempt strategy?

If we want the current task to be preempted easier, we have to shrink
the current task's slice, which gives up its own right to run. If this
is the case, how about introducing negative se->slice, tasks has a
negative slice indicates that it wants to be wakeup-preempted,
and its real slice is the absolute value of se->slice.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f7c0d9cad6e0..019576da9737 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8120,7 +8120,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	 * Batch and idle tasks do not preempt non-idle tasks (their preemption
 	 * is driven by the tick):
 	 */
-	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
+	if (unlikely(p->policy != SCHED_NORMAL) || || se->slice > 0 || !sched_feat(WAKEUP_PREEMPTION))
 		return;
 
 	find_matching_se(&se, &pse);

thanks,
Chenyu
