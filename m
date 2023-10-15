Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA49A7C99D4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 17:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjJOPpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 11:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOPpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 11:45:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7305AB
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 08:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697384734; x=1728920734;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JRvuIM4taZiduvKiP9C7pzc85LGcpXgbR6lC7SC5m0g=;
  b=f7308omC/FEgmiu118HsuFmjV6vfMPl85iPPaVX2Xvj7VbtEAIjA0qM7
   rR61jpUIaACrrlauoPtAgxj24qY2EiZLUUe+sCVpmmbcJgFNhCX2M0Nt+
   xRG+XzoK8gPeisYjlisSgG+c4Vg59aH0S9nTpNTY7+g7KgIcFpzzwi9gi
   XOCiZS6n8Lh2PoLAExqpm8JmZWUDWG0VgItypVn8uIROT+zBuxtzku7vE
   1PNcGX+CcIfii0LycvKBT4UvGSsteORsQbb8AT2ZfijQDzmPSBaT/OXKO
   9KXX7BRGVKrVw5bmhwrhSmufQ10tPwS4K2l5kHYVo60j67j/GrL1ksz7l
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="451882590"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="451882590"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 08:45:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="821291573"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="821291573"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2023 08:45:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 15 Oct 2023 08:45:33 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 15 Oct 2023 08:45:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 15 Oct 2023 08:45:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 15 Oct 2023 08:44:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HW+Ap2XvR/DX8yAlBDTkEwwgWcEPcGaYIquY0etciOd1h/dT5fEptDryTJ4IBUJ0b39oIjcuox9q3RMSvqHWinbm1WX5uygS5OmDsjv8TDvYBir8cF5V+UKEWmiNOLq9K1GGqJj/0pA9w6i+wO5LyuIhH6agcaCaGcL+o60oyrxQWzA7O+f25PEsmIEAUIeNv8zUN8lPgZJr58cLcvOWdEG+RHQGtO3JjU3YnadbUwHa62TZPp4GB0zUUYksyrsREo4iobAv1WwRvrhDak5wOlfZLXUnWaKxc/i/NUWt28SE+J3rOpXt73s2RI0arsIkc6EA2LkBeheX6l3IWLQNuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8J6Jox8oXdIhfIGIrOvE4+nnaUM7DrkeSrSGtpIFWRw=;
 b=APOfGwBN/JwBXwaKJQrd86MICRb1MsPj6EVs9ua54fmY1/nBZlysgXhj92PbRfX+Xbw0whF/sPpAdUohkoiij52NyGuS0tC9GpEKw+cpx7VDPN22UQyYjPfCMUE8K1jJ6aBm1QMcUV1EFw3G0cFBbKTckYPl2GAT08pdyLlbZ4tjpcFa1/FVaD3J4fInIjuewvcmZcGIBKtLLIplSoinihwctRz0BoBQAvEf6QoNkNkVOmCyMEh0c5980HKjfuiISFI2aL25vQehyJescSjcIK8s2uutXIiSDDAKfhNOAMyJnZt6tgLW+xtC7OOULDcz2ZSt+0X2GgPCVuSydqfuHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SN7PR11MB7640.namprd11.prod.outlook.com (2603:10b6:806:341::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Sun, 15 Oct
 2023 15:44:52 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%5]) with mapi id 15.20.6863.046; Sun, 15 Oct 2023
 15:44:52 +0000
Date:   Sun, 15 Oct 2023 23:44:33 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, Tim Chen <tim.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, <x86@kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Introduce WAKEUP_BIAS_PREV_IDLE to
 reduce migrations
Message-ID: <ZSwI4UTrXLNEWwKM@chenyu5-mobl2.ccr.corp.intel.com>
References: <20231012203626.1298944-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231012203626.1298944-1-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: SG2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:3:18::23) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SN7PR11MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: b589cad1-6437-455e-a1f9-08dbcd95ab4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKcksucj9lXS7YcvneuryhboBLk/+qCGnWJzayv9hLCtkGmiKlPlWGPMCxe3g40mhJj4UByoZEuhDHR5zMyRu9awxGCGdUpI0BKALUklSLlnUCjaiwu7GYY7vpnwDwCGH4gYUpWqCVQm48nzP3yTTEbe2Nh2/zypk7d4bCxhYhmZES0+cNZwnE5QNugf9tHNfNxU4VVNQc8PX3k4vKvtKRu7CWdisafc9nAQmlSoLqXzzjbgJQByrnLuUJ2Y8jDKfn9nEn8Qgn30IyT6I7PkrlYLu+f9NLmCZ/KCOKCwCyQqiSbBs2sGIoZTSPmTyEPgm5jrmrz+r3tGswzQxYjK+nBvB88ubztyukTfOq7rDGBlOmuyLLG/uRXugP+89R0pT1uCw32Y/CcZ4jMFAGNBEHVJVxxO/8XDSB0vrgBycLbiPHERotQ5N7Zaf/0kbX19QwUjd0ZPknLyvlEBK1fXKxFgi5RqiGDJPGn95IqHqdtw8/hVuwxfaOJW3mKrVi/xQhOgJiiuA2hpoedNuwpaypZ/5e/pHPhFo5sn/Me/YHv2ZPiNbCVPKltclAekiInZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6486002)(82960400001)(7416002)(478600001)(53546011)(83380400001)(6506007)(2906002)(86362001)(4001150100001)(38100700002)(6512007)(6666004)(4744005)(26005)(54906003)(8936002)(8676002)(4326008)(66476007)(66556008)(66946007)(316002)(41300700001)(6916009)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z9yeQCMPue0nyG43VzzR65j7J3+hG8ejUTQq/d+iDBToBKEzQX7EjFhSuhDf?=
 =?us-ascii?Q?hyiIvHmDQqcRJs45qF4qqaaqt+GgwqrBxHiaraM/qdb05xmkc2MPUdy/GmJk?=
 =?us-ascii?Q?0ayi8gZs6FFq3sX1LG4ct6NQsTjBrS2qBEHvN6xDWs4zJbKtRwc3Xfbtz1Gp?=
 =?us-ascii?Q?NyWDBLEPNAWp1LHtJQaHKEsOtaiwJBZ2O7QlcMfh2uKsi5CLLV4HbDt4FxaY?=
 =?us-ascii?Q?jyXs2SKHXDOd8sAF8W1qZgSBjC9cJpDN6FGAL00Msx8R2B7bxG73katnjSJV?=
 =?us-ascii?Q?D3iz5/NQZBBzAXCHa2oOqdrfpqKu2GV5l6rlph1H1y93oPiBy8ROc7ToLovs?=
 =?us-ascii?Q?eQVK1mSQwG3lS+qQY6Mf7YeWRTwVr8ZCMiRQ0IB3WkEbi8Va/CE58WEqodnk?=
 =?us-ascii?Q?Qhl5F77q5SLLPWGz2atdY7sMzX2O5ZB8LbyJ71L9ffZDfXeq1ZkTcev4Zljy?=
 =?us-ascii?Q?4qLdC7iRxdZwUCD4gXMvJjPXELmFOvEuKXj7nuFdcfHK8oUN3nTEI0aFwWMY?=
 =?us-ascii?Q?qzMBjXgxp6ItHvUUylk52b9rDGh2XDTjH2gxgK0cpGVYLYLujtFxopa++L1T?=
 =?us-ascii?Q?EyJFu+l6hkELd0s0TztzGL9v6/rq5wkge8i6bs0Fmg63BAH7GDVyntUprAoG?=
 =?us-ascii?Q?aRSoH0BgjtL+IZli7xl1itkh6OxkZO7EMxJsLRZrryQxWN/SyPytamZS2K2C?=
 =?us-ascii?Q?xQEE3GT8hXS56jpkM0yn5ZXGCHyOUc0XIjKzlWBzMNeBgatPR0ZGJO7Ied8d?=
 =?us-ascii?Q?7bCHVDi5zb9aht0DS4AOYHAjo0tOiT623enPwkS18i1lAdy3vCvbjw46XepE?=
 =?us-ascii?Q?Y301cxRR7tFQIHv+vTCqTaI/O/YGIMoch255CShmBlb3UYskvQD/SYCqO+CP?=
 =?us-ascii?Q?G9pBkx4f5G9uN6uI1gQAaywCQrN5sKEwavMPGcVXfOerCMxYk1WcRSI54QCV?=
 =?us-ascii?Q?FrQ3WBVBw2vxaPaSUWmem61m7EoJg6kYjJhGNPKxPi+ChPwS9HM6NStWCBdX?=
 =?us-ascii?Q?fBsR7mvpfVfhv8RJgCiaRX6dS7ieDUi5Hjzg46f+OaiyGX+vsvzzsRfGafKE?=
 =?us-ascii?Q?k0ZBRxnZtByL9tuapWx9mVPcJsicupel44MqrlcN98LLjvgZ+EKFaaP8AvmV?=
 =?us-ascii?Q?PA6EynTiOgpckBxcEhg8jtfutylFaf9fe0FWUjY4pxN6d2bqYt1JAObmslkH?=
 =?us-ascii?Q?CXzffSGWKBS9XrAUtSghTsSfpAiHhnuEPFB78Q4DQWmP2HWO+x9vZrlqcuJW?=
 =?us-ascii?Q?cZnORqhNkT2azseszoDqisygnHfb2sZHy1PS3/v6dsWKjplPIz59EBrfgqF1?=
 =?us-ascii?Q?ZFfQHPDHrlvERn3Rg9TfuKFA3oKU3Au1h/Hidpu5O+WEOHgYMHBFS9Tj+q5Z?=
 =?us-ascii?Q?zqizIi4loQOcMr9jYtkbybLv2oj71hNwjfnqQTx27esmgqr/JHSpmHpC73ur?=
 =?us-ascii?Q?hojMxErMWUnLePOi0exnB4Z3B2EOK1zs/u3C2gKVryPdJzUplBVSUSNu+LbC?=
 =?us-ascii?Q?Eeb3IU/UjJoMwsSo4c5+oixrUhevflpx9XGG5go8hA6baHQI09YEr/xFmOyS?=
 =?us-ascii?Q?sKufv5zfOnezsfuaoQoK950KsQoPRPEr9GLsHD+J?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b589cad1-6437-455e-a1f9-08dbcd95ab4d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2023 15:44:51.3025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8UQroNRTuFd//8WvUoDo9uzlX3TC0qG7/qw1730/px+OniUjSuXCGEN7mJkPNAyDlfrFKdOvODAnBRc7xQVYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7640
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-12 at 16:36:26 -0400, Mathieu Desnoyers wrote:
> Introduce the WAKEUP_BIAS_PREV_IDLE scheduler feature to reduce the
> task migration rate.
> 
> For scenarios where the system is under-utilized (CPUs are partly idle),
> eliminate frequent task migrations from almost idle CPU to completely
> idle CPUs by introducing a bias towards the previous CPU if it is idle
> or almost idle in select_idle_sibling(). Use 1% of the CPU capacity
> of the previously used CPU as CPU utilization "almost idle" cutoff.
>
> +
> +/*
> + * A runqueue is considered almost idle if:
> + *
> + *   cpu_util_without(cpu, p) / 1024 <= 1% * capacity_of(cpu)

util_avg is in the range [0:1024], thus cpu_util_without(cpu, p) / 1024
is <= 1, and 1% * cap is 10, so 1 <= 10 is always true.
I suppose you want to compare:
 (cpu_util_without(cpu, p) / capacity_orig_of(cpu)) <= 1% ->
    cpu_util_without(cpu, p) * 100 <= capacity_orig_of(cpu) ?

thanks,
Chenyu
 

