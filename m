Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8277B7344
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241222AbjJCVXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjJCVXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:23:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8790883
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696368181; x=1727904181;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GCdeSec/E6r2BViYY7Gy1WSmqRB5jZUhgBB2jz0Ys2c=;
  b=ncVKiwtUMfuj9LSUsjrm+AolLnax9N+A7v7fI1ARh/O3GF+e15dGLjKf
   l1rwIKcaiJFLYyMG7RfS+94v9ejagFJ6kTf4fIM+YhK92Wi8pEH4neoji
   XI6lVpYIe6WPba4NvZ+ndsAjrw6m6eDyCoUnX6l/K93lWIutyzyH1I+jD
   IjX1dnikzhSTcvsvYDWBXR+Rc32w7tJ9DTYLOrTmqxUhcWtEWPnVjfoCQ
   QBQXElMgmPurwV321WqduB5eC2nApn0yk1/ZOmhqT3Bc7BqCjgY5djlUv
   SOqK/qbdJb/oIQqWYlQOXqfWOOBzJjBMQrfHFQ3uSau5ztm/W6kNWACum
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="385800753"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="385800753"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 14:22:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="786239159"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="786239159"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 14:22:51 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:22:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 14:22:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 14:22:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZudlGpRdRr6bB0t0py6HBFO20QEDuZSdTdtzHX9D+D4AmR7hYa/JjNyNwBCcg4tOuqMt6oYxTghBdjCdXOQLeO3faOKoRQKaY8Px01wc9UNTNHyrhoTq+QJFJK9Ct59tCDc+10WaIQKLIBwMbU33ZIno4Skc7dnqbzw4pfTpogLvfySJo2gQW6U4cPuQg8asABsa7QggUVUTszE+Cn1YhGZD2eA26dk4c3KTcS0uk4jiMFGXElVr/TuonEzmMc4B7qML0PlhUK28nLUK21nIo9szM9XDe+dpS79ihXl7dpwlvIMO6prF+CXaTR2ZWg6wnUhjddKtbtUg757MxV8sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYGtMEn4OVWYuOZ05DyJ3hj0Z+lWvXvu1sENRbwPxxI=;
 b=PVwu30tPm4pPckwNFttMxH7Sz/FCjPI4AjK2TmpnAQkQkmgWIPDeYuLNo2G96nw+hCyqphK1gom+rVxq2gaiR373rbk7DGGI6zSpRMTQqNTfwiOr7xe127TvLpMKzcF4o653i22UUJWwapIz1/WKT8sYIh3OSSJrRi4EcOdEovNMDTrpQHRlZbDvHmSRYxi6jQCYuwXZ00BKH3cP+JcvU1jiLMpHR08TiXBHmZHMybDcZ5rKQ4LVsm3xgeoGHdvctt3hWxNNHZQanEPFKOAIa0/KX/VSMm0HS/XuzzFd7mpAeG0rQrufjbjc8ELUivfwY65yPdgPomW0724hxpNoxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7603.namprd11.prod.outlook.com (2603:10b6:806:32b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.32; Tue, 3 Oct
 2023 21:22:48 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:22:47 +0000
Message-ID: <a7b99b15-5c26-3a73-b41d-c64b59126f8e@intel.com>
Date:   Tue, 3 Oct 2023 14:22:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6 21/24] x86/resctrl: Allow overflow/limbo handlers to be
 scheduled on any-but cpu
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-22-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230914172138.11977-22-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0331.namprd04.prod.outlook.com
 (2603:10b6:303:8a::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c3a2bc-be51-4708-cec3-08dbc456e431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Y6XtrvD2OON70FwEUq09v6WyRNMc4gn56oiwyDvZMoj4fc4i1NaSb0OxTEmADqWI7yQxoAPXGpIGL8jAQq96rojC+Gfj45ak9vxKDL/E4FJFQZjdI85qqY1Jl9fruFGKli0mDdhwKzZE2hJfqU//49PJEglSfGeYfi9XSEykLdw5ht10eTEhOt6+uIUgAigmgP2LGbR7x3TdL5spzV4Ais/yFJpclHzr1h5/SEdTUR6otr1ouoFtKsOFPlIK7nX15NRu8Ifbzle6WjfdvKCeEUGxM7Y3UelLhJDE3i2g40qc7SZ8cKUdTgzAKUfTBAQ1rs9GNY9nXuQIpXTWfBuA17gIDAdY+bewtKPksCnYivLUJP9mfezTah4kOR3e/avMiomjhnly1GnYLNf0r6H9ynNhHWFgnM7e7o+tvlavNFr2rK1uQkAGODW6YpvNlQ2cnIeG43PqsxDd3QkB+6kfYuD/LjEwy1LwImYhWi861m4Rpy7+m8M4X3Ii6MO2mQ9iuNahnTIVAS0lDMYNSu5+T5KhtX0PNrWQDtd/G6sY2ylj/BuszlL8DP21ZxcJIys8tgdIK+dxxmFfxb8OkgCn/Du4hfnD3Njm4QesHkqjA8tudMKQMUsrWkHHBYlQZg775o2QiSNchedC9k51wZpxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(31686004)(6486002)(6512007)(6506007)(53546011)(2616005)(83380400001)(38100700002)(36756003)(82960400001)(86362001)(31696002)(2906002)(7416002)(6666004)(26005)(4326008)(5660300002)(66946007)(41300700001)(478600001)(8936002)(66476007)(66556008)(44832011)(54906003)(316002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnNta0U0VWdjUHl4V3o0Kys4UjFPUHBVNUhrZmdFVGliUHRoQ21wU1hIVUpY?=
 =?utf-8?B?bWJIRTZrYzllWTVnalg2ek11TXRHbndXM1N2VFk5b3JCZkdmcVMvQlZaYVdq?=
 =?utf-8?B?dGd1QVQ4TGRiVGRhYlRZT0xJR2pmaktBMnlZUlI0bEdVYjZvc2U2elhnNXYy?=
 =?utf-8?B?WjA4d0dxQUZNbjhCYXBKMGRoS0tIaC9ta0R0T28wNm5ab3l0ZlREaHh0WndJ?=
 =?utf-8?B?QkxpZ2pGSVl4TTJ4a1VWM3AwREdlb0tncnNRMWo0eWp0bW80ZGcvR2RmaFhL?=
 =?utf-8?B?RndKR0J2bWRNL3BOaEIxL2QxRmpxUlEybEF1YnZBRDQzZFBQYUlJTTFZeE8r?=
 =?utf-8?B?QU4yV09wd0ZuTlp2OVRvaysxaFpiSzBDcTVjWld0dWRwZjBYNGlUUzNCYlhz?=
 =?utf-8?B?SGJlUWVLdXoydkRTcjJ4WHQzcDVEZmI4bHBtbmRQcStDd0wyWG9lSllxOUxj?=
 =?utf-8?B?bzFtRFNxQnN5TTl3S0pBbzBjYWJrS2NocVNNR084QkJMUjRFNjg1NU9SU3Qw?=
 =?utf-8?B?NlhTbHJsZklXeHFNVmVoTlBkcGM2LzFFQU1rU0IzaWx2QktyQ1hFd3dCYXcx?=
 =?utf-8?B?VDNjNEVsdUE4OSs4Si80NmdROVQydFVyUDFHMEZpNlZ5OXBsOVdyMzFMV1A5?=
 =?utf-8?B?MWlCZ2diem9IbjUxbmhEbGU0UHZmYjR5RlYvRXlCbmYwVGN5VlYzWk14S1ZY?=
 =?utf-8?B?UkZmeWgxM3dnOTZOcTRwSDJYN2QyZkM3bCtwNy9GVVFkRDRJcGtWcDJONUl3?=
 =?utf-8?B?bnZ0d1ZLS0ZBQTkwaHl5d0psNjhVbG5xZ0VNUVVhZW5RRXlhWkRUM0JWVGp5?=
 =?utf-8?B?ajJhc3Z1ZjI1SGFrZDNrVlpzS1c4NnhGZWlRT1dYWGxEaDZ0cFY5TnZuQW9E?=
 =?utf-8?B?eDhMSEpuWlF4dlV3Ym9PYmRFeWVNWHU5Z1BUM0ZEK3dGbG95NkpaMDFsQnJX?=
 =?utf-8?B?c0lYK1FMWVhZNCtaYWRuWTVYRkl6d1ZjMzVaSVZzZ2RJek5BajU5NnNvL1BQ?=
 =?utf-8?B?cWZZS1Rrblc1R1ppUVRjOXVBSVR3ZndXczdGaCt5R1NWa0FsZzY3NUpDbnpq?=
 =?utf-8?B?a0JXZ0xLNjJVNGdGOFBtbDczZmpDZlpiVnFIaWNyZzVVZGxmMWZ4UHUzdzZG?=
 =?utf-8?B?TUNRd3V0MFRZTmZSUUVsTW5kS0dVRU0wTmV0dmlWNUF6Qk9pNWYyN1IrTUdu?=
 =?utf-8?B?NjVyeXYwb3B3SHVPQ010TkNlR3oxYThFbnFnendCNGFXV2ltRk1mQWwrdExH?=
 =?utf-8?B?V2hNL29tME1tYUhQbzh5RUZTN055NHhZTHY4RUV4eVR4L2d4dVlXVzdZSWo0?=
 =?utf-8?B?YXhsYXpFS3ZLdTVCRHZIVGpRejJvM1Nleml3SE55dU82YjV0OVNFTmk0allq?=
 =?utf-8?B?TVdSRkxVbEtXbnJCMS82VUxIdzBSa0xrS1E0KzZMNGZSZlZLcFZFRHJjM1BZ?=
 =?utf-8?B?bE56MTZBTlZlaWNkWnZ1eENSeHplYy9IWVluSm9WbVJqREZuR1Zhd0NrUkk2?=
 =?utf-8?B?eXFQRloxaEcwRURQWGI3UnplbVhuZmFjM1BRZHVsb3NCRDNNVDcvQkpuWkhM?=
 =?utf-8?B?dHRRSmFhWlI2dWJSQU9WTEhwQUxMUnJ5SXdBdlB6WUxaUzB4QUN2bFJCTTd1?=
 =?utf-8?B?c0N2THFQYms4SFdidjRGbTZBS25PZEhtZVRIaGE1bmtFRm4wdCtkcFRQbERk?=
 =?utf-8?B?U1U2TjdkQTl2N29BVSt0T2dsU2VuTlB4WEFhcytBUUlSbTQyMEFDV243V0Zv?=
 =?utf-8?B?MC9GZys2T0FPbC9FMjIxenpJY1BqNnNlVjJaNUNKOVF1YzluTEUzbFFqYjlS?=
 =?utf-8?B?U0xNMDdleDZOOTMySFJHTXJLb2dZTHUyV2xCZXZoa05oOTRwNTU1bHFlbWhz?=
 =?utf-8?B?REtLSnJvOU5FbzVGVGhrM21ZLzMza2U1cm5rZ2lKUnpiQ2NQNmlrbTFRaDV4?=
 =?utf-8?B?YXdxZmZOaWpFZGFqRkVYbTRubWdjOEdQN3lHV3U0eitWRHFrWlE2d2VwR0Nv?=
 =?utf-8?B?RWRSeG1jTWxUOUMrRWpFWEt5Vjkzci9naURYWmNYZ3hGSVVvUGp2enFNbWMz?=
 =?utf-8?B?Snc2R2E4L2pxazlHTGw1amtnVTJyL3VycmZVaWxCK3k0Y0ZZam9vVzB5RWlR?=
 =?utf-8?B?UEhEYmZyMFY3Tlllam5RSXNpOUp6UGNVMUJrN2tyb2N1QlQyR01vcmlXMU1a?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c3a2bc-be51-4708-cec3-08dbc456e431
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:22:47.8964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjokSAnQN5F2X5BPYfIb62Bsv6IfgR3YH23AjpRMwUvfo/GTlu/IY5x/+yiUia1HoL5gE6OYHG+tXMF34dhP1TeKuke8EP1AoHD4mBOn0m0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7603
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/2023 10:21 AM, James Morse wrote:

...

> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index c54fa86e4ef9..bd7f60bf49fe 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -60,11 +60,15 @@
>   * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
>   *			        aren't marked nohz_full
>   * @mask:	The mask to pick a CPU from.
> + * @exclude_cpu:The CPU to avoid picking.
>   *
> - * Returns a CPU in @mask. If there are housekeeping CPUs that don't use
> - * nohz_full, these are preferred.
> + * Returns a CPU from @mask, but not @exclude_cpu. If there are housekeeping
> + * CPUs that don't use nohz_full, these are preferred. Pass
> + * RESCTRL_PICK_ANY_CPU to avoid excluding any CPUs.
> + * Returns >= nr_cpu_ids if no CPUs are available.

It may be helpful to add that the function can only fail if exclude_cpu is
*not* RESCTRL_PICK_ANY_CPU. That helps to understand the sparse error checking.

>   */
> -static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
> +static inline unsigned int
> +cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
>  {
>  	unsigned int cpu, hk_cpu;
>  
> @@ -73,6 +77,9 @@ static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
>  		return cpu;
>  

It is not obvious from this hunk but I cannot see how this would work
on a system without any nohz_full CPUs.

At this point the function looks like:

	cpu = cpumask_any(mask);
	if (!tick_nohz_full_cpu(cpu))
		return cpu;

I expected exclude_cpu to be taken into account. If I understand correctly
exclude_cpu can be picked by cpumask_any() and as long as it is not
a nohz_full CPU it would be returned.


>  	hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
> +	if (hk_cpu == exclude_cpu)
> +		hk_cpu = cpumask_nth_andnot(1, mask, tick_nohz_full_mask);
> +
>  	if (hk_cpu < nr_cpu_ids)
>  		cpu = hk_cpu;
>  
> @@ -565,11 +572,13 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
>  		    int evtid, int first);
>  void mbm_setup_overflow_handler(struct rdt_domain *dom,
> -				unsigned long delay_ms);
> +				unsigned long delay_ms,
> +				int exclude_cpu);
>  void mbm_handle_overflow(struct work_struct *work);
>  void __init intel_rdt_mbm_apply_quirk(void);
>  bool is_mba_sc(struct rdt_resource *r);
> -void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
> +void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms,
> +			     int exclude_cpu);
>  void cqm_handle_limbo(struct work_struct *work);
>  bool has_busy_rmid(struct rdt_domain *d);
>  void __check_limbo(struct rdt_domain *d, bool force_free);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 9c6d4b0970e2..208e46ba7368 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -480,7 +480,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  		 * setup up the limbo worker.
>  		 */
>  		if (!has_busy_rmid(d))
> -			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL);
> +			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL,
> +						RESCTRL_PICK_ANY_CPU);
>  		set_bit(idx, d->rmid_busy_llc);
>  		entry->busy++;
>  	}
> @@ -807,22 +808,31 @@ void cqm_handle_limbo(struct work_struct *work)
>  	__check_limbo(d, false);
>  
>  	if (has_busy_rmid(d)) {
> -		cpu = cpumask_any_housekeeping(&d->cpu_mask);
> +		cpu = cpumask_any_housekeeping(&d->cpu_mask, RESCTRL_PICK_ANY_CPU);
>  		schedule_delayed_work_on(cpu, &d->cqm_limbo, delay);
>  	}
>  
>  	mutex_unlock(&rdtgroup_mutex);
>  }
>  
> -void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
> +/**
> + * cqm_setup_limbo_handler() - Schedule the limbo handler to run for this
> + *                             domain.
> + * @delay_ms:      How far in the future the handler should run.
> + * @exclude_cpu:   Which CPU the handler should not run on,
> + *		   RESCTRL_PICK_ANY_CPU to pick any CPU.
> + */

arch/x86/kernel/cpu/resctrl/monitor.c:824: info: Scanning doc for function cqm_setup_limbo_handler
arch/x86/kernel/cpu/resctrl/monitor.c:832: warning: Function parameter or member 'dom' not described in 'cqm_setup_limbo_handler'


> +void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms,
> +			     int exclude_cpu)
>  {
>  	unsigned long delay = msecs_to_jiffies(delay_ms);
>  	int cpu;
>  
> -	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
> +	cpu = cpumask_any_housekeeping(&dom->cpu_mask, exclude_cpu);
>  	dom->cqm_work_cpu = cpu;
>  
> -	schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
> +	if (cpu < nr_cpu_ids)
> +		schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
>  }
>  
>  void mbm_handle_overflow(struct work_struct *work)
> @@ -861,14 +871,22 @@ void mbm_handle_overflow(struct work_struct *work)
>  	 * Re-check for housekeeping CPUs. This allows the overflow handler to
>  	 * move off a nohz_full CPU quickly.
>  	 */
> -	cpu = cpumask_any_housekeeping(&d->cpu_mask);
> +	cpu = cpumask_any_housekeeping(&d->cpu_mask, RESCTRL_PICK_ANY_CPU);
>  	schedule_delayed_work_on(cpu, &d->mbm_over, delay);
>  
>  out_unlock:
>  	mutex_unlock(&rdtgroup_mutex);
>  }
>  
> -void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
> +/**
> + * mbm_setup_overflow_handler() - Schedule the overflow handler to run for this
> + *                                domain.
> + * @delay_ms:      How far in the future the handler should run.
> + * @exclude_cpu:   Which CPU the handler should not run on,
> + *		   RESCTRL_PICK_ANY_CPU to pick any CPU.
> + */

arch/x86/kernel/cpu/resctrl/monitor.c:887: info: Scanning doc for function mbm_setup_overflow_handler
arch/x86/kernel/cpu/resctrl/monitor.c:895: warning: Function parameter or member 'dom' not described in 'mbm_setup_overflow_handler'


> +void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms,
> +				int exclude_cpu)
>  {
>  	unsigned long delay = msecs_to_jiffies(delay_ms);
>  	int cpu;
> @@ -879,9 +897,11 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>  	 */
>  	if (!resctrl_mounted || !resctrl_arch_mon_capable())
>  		return;
> -	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
> +	cpu = cpumask_any_housekeeping(&dom->cpu_mask, exclude_cpu);
>  	dom->mbm_work_cpu = cpu;
> -	schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
> +
> +	if (cpu < nr_cpu_ids)
> +		schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
>  }
>  
>  static int dom_data_init(struct rdt_resource *r)
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 0c609cdfe7e5..49f100c73838 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2552,7 +2552,8 @@ static int rdt_get_tree(struct fs_context *fc)
>  	if (is_mbm_enabled()) {
>  		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>  		list_for_each_entry(dom, &r->domains, list)
> -			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
> +			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
> +						   RESCTRL_PICK_ANY_CPU);
>  	}
>  
>  	goto out;
> @@ -3850,7 +3851,8 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>  
>  	if (is_mbm_enabled()) {
>  		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
> -		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL);
> +		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL,
> +					   RESCTRL_PICK_ANY_CPU);
>  	}
>  
>  	if (is_llc_occupancy_enabled())
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 9d5f75a4e192..0888d1975161 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -10,6 +10,8 @@
>  #define RESCTRL_RESERVED_CLOSID		0
>  #define RESCTRL_RESERVED_RMID		0
>  
> +#define RESCTRL_PICK_ANY_CPU		-1
> +
>  #ifdef CONFIG_PROC_CPU_RESCTRL
>  
>  int proc_resctrl_show(struct seq_file *m,

Reinette
