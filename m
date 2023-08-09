Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2055A776C59
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjHIWjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjHIWj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:39:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2185D2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691620766; x=1723156766;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1UJ4rW1c4qWUqh1beT4Gpex+xrjgEvgsgxY55cgeuHM=;
  b=iFoJU/EPcFbiv5lUnGhejkitH9d5eT/xBF/Hb9mxqPYygY9Gi3v0bGtI
   iyasufcZwSMsigrTcEUuC6oKPCJ474HahL87acs+UDIreV2kgkUPKyitu
   IltxaZm8I1TOH3KKNY1HFGMO2y9ahcYXRuyCNh5tnQfv86+bCfVjZOL+8
   lPib4JdTbJLmJI1OGiEKi7a9rr1FyikKdpKGCl6aceerDaLRmSYSu1oq8
   MsJYk/SjN9k0vBdP+Yima8hFzus8WQJcvvwuzZmM+KHTmCuJBgCbont/u
   bqE/K/xRmjpBX0/phm0LxRMNf7TkmZvfR0LGxz3jq0Q1a7zrPoxP9kn2Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="368706388"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="368706388"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 15:39:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="978565861"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="978565861"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 09 Aug 2023 15:39:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 15:38:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 15:38:59 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 15:38:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NA/h8WhqtjxDjjN2XfMiWcO616EjHaR9P7CBS2lLUJcwf2U1K9pWiWo4ZkU8ZxHj8Tutn7kiUtEXM0Mu3X+dN7HhbxwmUvbpEghxmAWVgEaDZKr9WEHFJj7q6jFv0ZdataJOVWFQN6PqP2CI1UKZPiD6xAFSfD9zi3DbtUV5EsQ5EPvYJq6N7oMW9kE+FwkYM3TShCDgr4bQ36mi6r8YANg2Xyiv+3Eo/BOph61/SSK7J6Qk1k14Evou7Maz0XfSlpI4u94dyFG3gmaQhRwVBJYnV6sd39kIBMtBV0hZNJJKSt6xyyr8/1Rid3xDjHlyHc2G5DWjLkk8jypjSiR7uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bb5XFqXu0Msf4LBOkSGyO//SxZlSD6b3rBg6xOPluxs=;
 b=WOH7Nt8Udq6ZfVVLLnwDuL7we4hdftC18GCZTYow+SY3L6NY1qRTh6aC2bCfm8cuZJj2qwTMFe+/1pksrClrv31eFBQtcCquxt/jQoJuiC2+NVzmZrYwy++YeR6PHG9mpZz42Og3HNmhv0JAbE6tPXU1IfxgNv2LBdAy2fMaKeD7jvApT9//MlppX5s1B6S0OmIigDa6fgLefeEeAB1IUu804397cfhpwVKLKJXidv37/lv1uIZk9NL5/lX1A6y0mqgLZ3twdCkmegcyZlmz4CZACjvXtkKLkKs4OvD2fworjZjT2o1VHGb2eXifrbmcSA3pzPGiobbccJImcmCcjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7549.namprd11.prod.outlook.com (2603:10b6:510:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Wed, 9 Aug
 2023 22:38:57 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 22:38:56 +0000
Message-ID: <b8103525-83d7-b8f1-105a-178625b89da4@intel.com>
Date:   Wed, 9 Aug 2023 15:38:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v5 21/24] x86/resctrl: Allow overflow/limbo handlers to be
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
        <dfustini@baylibre.com>
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-22-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230728164254.27562-22-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2d97ed-5a28-453d-7e25-08db99296aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ruEEBKf/8tU2YXL1eP+faGKTmdbDHPl3QyX5mXQiccHd3ESHe+jPPSVeM3JnoCfZFS6AJxpgTpEZjBNt8xJnyawPE8fPuieykTF8+FMBkZ2Uqly9vnp9uwuUMGkqye7MLR8nVVKg1uKtAyah/MIOh5aquvQsyDBIt0uH7VpNmVSTAoVArczs871tvS/vs8d1OilwfA926teB9ceX2XyMcYvpqTUdVAjRjvLv+5+f28cb5xDD9/lYBgUvPNRw/HELUAeC2oRb0ysMhEsGAgpVXJsXOMxVZ/bKdEFFNsB5o8yycDs2BaOGrq4SKhT1aiNhBgs0AzzFOVbqr33VBZOszrAe/ltwQkMohsUWFJBoz7sVSS3UoCNU0aqQ4oDHUYfYKO2UG57EQ7OIaC9ZYFgrNgJnH7PRkMllE7VQdYFMq7ti2W9brUzUh5DOrhka6IC7vOx9zIjWDXpHgkJmAMXmSx5oLFajcAvFLsguIwt5LBaG3LaU4QXxfntiHFi23ISHQaHQtI267eqvj2dm1k42hwi8h1IxVB+JOU3I1ymT/qODpJ7MzcUAI3EWZGFlPex55LM2fajLao+jhKQx/b+aKd8ob/5Qpii9vYN0/RDR6X0DrR+Rop52JuIirGlQHJ5Qel5+2CbFoYZHW5hDk3I4OQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(186006)(1800799006)(2616005)(53546011)(6506007)(36756003)(6512007)(4326008)(316002)(82960400001)(86362001)(478600001)(38100700002)(66946007)(54906003)(31696002)(66476007)(66556008)(6486002)(26005)(8936002)(41300700001)(8676002)(2906002)(7416002)(44832011)(83380400001)(31686004)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVBkR1BXejlDWE1TQ2dSVlFFZGhPem1XRVlyamxSdW93ZVlkMUFSWUFRK0xW?=
 =?utf-8?B?QnRnWUcyQmVhdnpuZk9udFlSZEkrWERLNExFUTVvaDJVcnV5Z09DanRGR2x5?=
 =?utf-8?B?aGpvdmVhb09WeklKSDVsS0J6KzVVaWNoS2FwZlNJU0N2eWFiMlNrekF5eVkw?=
 =?utf-8?B?Z3o3Wkt0Mkk4M1NDckNNRnh3MlR4bnIzWUM0WFNLTmNYSUlUL3BYVndvR1lU?=
 =?utf-8?B?RTlXb1RzOGlOL2hCeWdnQzVYbnN4eWM2QWViSmlMQWdRL2hkVTVPa3ZTdnJj?=
 =?utf-8?B?RTBaSXA1ZVVlNmFFMms3VVlRQVVtdnhzK2JTd2cwR0VpM3p5am55bktpRm1a?=
 =?utf-8?B?dXB3c2x4Zm9TZFJYYlczcEM1N1oreEZwYnBicnBWRlNmUll0VTZMRFV5NDRv?=
 =?utf-8?B?d2FoL1h0cjh4ak9td0VpNFl0TW1hMnd2czJpbE9sQ0hqM2FsRzJnRU1KTU5E?=
 =?utf-8?B?RnhVTU1xM3JKVTlSQ1dUK0E4aHdEV3labkZybDVnREFKYTd4bHhaRm0rOTdo?=
 =?utf-8?B?dHdITzQ1VTFNNjhzRGtkdDRxRzRXcmtVSmdHbmFYbXIzV0srcWd1MTR2L21F?=
 =?utf-8?B?b0dKd2IvZnU2Qit6cmxycTRwLzFmUUVFbWd0dHVIZ1o0dHUwTXBINFlyZC9W?=
 =?utf-8?B?UTRaNmxMY0I3K3F3L1g0Y1BnS3FtV1E5MWdvYUJvaFptaVB2eDRQcGRYOTZZ?=
 =?utf-8?B?WHNTRzZ3SGJyR0JyR0tNY1ZBd1N4MDdKS3QxREkydC9HSXdMMkM5Wk5yTENR?=
 =?utf-8?B?TllOc0hSTWc0NHhYbDkwM2FHbUVuUDdaZXpPaWhyU2Rad0l1L0NQdW12RUZR?=
 =?utf-8?B?U2p0bVh0SVlNOHNYdURpRHgwc1FPcENYdW4wTjN0VEpacTNxRWJ5OTJJUXZE?=
 =?utf-8?B?VVNVNkV6RTVMV3MvVk55VjBraWVlZGJVVmxhblEzcnB0U0s5cEE2K3pSaGNz?=
 =?utf-8?B?S2VuRWNrZUI0endmeXJRUkNlbS9zRm5mQ0RXVEo1b1NzZGN4QS9GODROL3pz?=
 =?utf-8?B?eHhPK1BvSmtDR3JTc0lLb01HUU9wSmxnOXFOKzZQRTNYWVgyWmY4TWhWSFlo?=
 =?utf-8?B?ZEtCUEZzQmR0MzBjYWJxeE11dk0vdnU5Zisvb2RqbHNJdGYwZ29NdFhNVlo4?=
 =?utf-8?B?dzlUWWk1VVUyUUNuTjVVMlpkRCsrcEpQK2hlZkhtaDVZM3VsRms5MEhuQnk2?=
 =?utf-8?B?QzlrVDI1NnBEOFozUFNKYlZ6dUZhMEowejh3T2pnSWowajkwZlgyeStXbUF0?=
 =?utf-8?B?cURTYU1EU1Nqc0FZczdLc0tmSGZuR2ZKUTMwbmFhTGtrWEppQ0FYU3ZYcC9U?=
 =?utf-8?B?bnAxTFlRemV1Z25PNzNDdHVuQnN1QWl0c0NCcUZFQjJ0UmdVZzQ3bnZURG93?=
 =?utf-8?B?eE12N3VIdXplSWphcGZGb2xKNjZsZkhXTWQ4UU1Ha2pobGlVYXVNeEgxVW9G?=
 =?utf-8?B?OWVnN2U1MERPY0JzOGFqei9DeVZtUU45OVFzMithcjhXK2s3aDdrOE8yaExK?=
 =?utf-8?B?aW9UVVlOZFltRW9xRlZoeTg3Y25lMlBBQitiejJMbFB3M0ZybTJJZWxtTVM4?=
 =?utf-8?B?L0RhTGJDTnJWbjNoeCtqdElyUkpLczk5T3ljcjFlRnBKWkNtWEdvTE1FaGZn?=
 =?utf-8?B?MFlBNWRwb2phMEFZVkxUTlIrYmc1Zmg3R3h1eCtRUi9RcHRhbEF6ejc4Y3BD?=
 =?utf-8?B?Y25MWWl4YWRWM0hTVmNVdDVEYlFWcW1FTjBlY3M5ZmdNb1RxU1RoUUdBZG5H?=
 =?utf-8?B?OGhrTnpNRnJ5akpUY1lKKzl4bldvNC9ZMXR3Mk9PM1JVekFxVjhUZElsb1BN?=
 =?utf-8?B?V255V0ZnTzMxcVpRQVM3K05udG5vcFo2SXdBSUhJSUpuZDhTNTJGNitSMlVJ?=
 =?utf-8?B?dzhnbGdZVmZNU2RlQUd6MktlWVEra0kwdktpYUdOek9wV2cyQmZybytEb1Zr?=
 =?utf-8?B?T3ZUVEZ6KzVrRVRhKzQyRlMwK091N1cvRnAwbWg5MTQ2d1VXelZxNG54cmRq?=
 =?utf-8?B?WjR6UzRaMjdIc3cvQ091SFBVY2E3YjQxTkg1RzRCRHJXTUJvdS9QYjhTWW5X?=
 =?utf-8?B?cUpRendqOUJwTGcxYVh1bTVxRVdJQnVQYStRYjBleEJyWUZDSC9vYUtpZzkx?=
 =?utf-8?B?N3M4bXFYUmJ5TUYyekVTOXhTckJzRVkxQ1VodjJ1VlBrNExDY1prY3dhNktQ?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2d97ed-5a28-453d-7e25-08db99296aa4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 22:38:56.6702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlKN1LKsRjztdJDLgzq1/XO4SE9ZcfEiUMuhMMWkX+kXVSprlS0o20uIDfH79Ik1qbmI4/TQdxVBRYY1CkEyBXfCa1yNOzE269TqSHQ3wuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7549
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 7/28/2023 9:42 AM, James Morse wrote:
> When a CPU is taken offline resctrl may need to move the overflow or
> limbo handlers to run on a different CPU.
> 
> Once the offline callbacks have been split, cqm_setup_limbo_handler()
> will be called while the CPU that is going offline is still present
> in the cpu_mask.
> 
> Pass the CPU to exclude to cqm_setup_limbo_handler() and
> mbm_setup_overflow_handler(). These functions can use a variant of
> cpumask_any_but() when selecting the CPU. -1 is used to indicate no CPUs
> need excluding.
> 
> A subsequent patch moves these calls to be before CPUs have been removed,
> so this exclude_cpus behaviour is temporary.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v2:
>  * Rephrased a comment to avoid a two letter bad-word. (we)
>  * Avoid assigning mbm_work_cpu if the domain is going to be free()d
>  * Added cpumask_any_housekeeping_but(), I dislike the name
> 
> Changes since v3:
>  * Marked an explanatory comment as temporary as the subsequent patch is
>    no longer adjacent.
> 
> Changes since v4:
>  * Check against RESCTRL_PICK_ANY_CPU instead of -1.
>  * Leave cqm_work_cpu as nr_cpu_ids when no CPU is available.
>  * Made cpumask_any_housekeeping_but() more readable.
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     |  8 +++--
>  arch/x86/kernel/cpu/resctrl/internal.h | 36 ++++++++++++++++++++--
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 42 +++++++++++++++++++++-----
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  6 ++--
>  include/linux/resctrl.h                |  2 ++
>  5 files changed, 81 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index a694563d3929..d39572a0a3cd 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -582,12 +582,16 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
>  		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
>  			cancel_delayed_work(&d->mbm_over);
> -			mbm_setup_overflow_handler(d, 0);
> +			/*
> +			 * temporary: exclude_cpu=-1 as this CPU has already
> +			 * been removed by cpumask_clear_cpu()d
> +			 */
> +			mbm_setup_overflow_handler(d, 0, RESCTRL_PICK_ANY_CPU);
>  		}
>  		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
>  		    has_busy_rmid(d)) {
>  			cancel_delayed_work(&d->cqm_limbo);
> -			cqm_setup_limbo_handler(d, 0);
> +			cqm_setup_limbo_handler(d, 0, RESCTRL_PICK_ANY_CPU);
>  		}
>  	}
>  }
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index f99e0a1f39c8..655418c23c0e 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -79,6 +79,36 @@ static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
>  	return cpu;
>  }
>  
> +/**
> + * cpumask_any_housekeeping_but() - Chose any cpu in @mask, preferring those

cpu -> CPU

> + *			            that aren't marked nohz_full, excluding
> + *				    the provided CPU
> + * @mask:	The mask to pick a CPU from.
> + * @exclude_cpu:The CPU to avoid picking.
> + *
> + * Returns a CPU from @mask, but not @exclude_cpus. If there are housekeeping

exclude_cpus -> exclude_cpu

> + * CPUs that don't use nohz_full, these are preferred.
> + * Returns >= nr_cpu_ids if no CPUs are available.
> + */
> +static inline unsigned int
> +cpumask_any_housekeeping_but(const struct cpumask *mask, int exclude_cpu)
> +{
> +	unsigned int cpu, hk_cpu;
> +
> +	cpu = cpumask_any_but(mask, exclude_cpu);
> +	if (!tick_nohz_full_cpu(cpu))
> +		return cpu;
> +
> +	hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
> +	if  (hk_cpu == exclude_cpu)
> +		hk_cpu = cpumask_nth_andnot(1, mask, tick_nohz_full_mask);
> +
> +	if (hk_cpu < nr_cpu_ids)
> +		cpu = hk_cpu;
> +
> +	return cpu;
> +}
> +
>  struct rdt_fs_context {
>  	struct kernfs_fs_context	kfc;
>  	bool				enable_cdpl2;
> @@ -564,11 +594,13 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
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
> index c0b1ad8d8f6d..471cdc4e4eae 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -493,7 +493,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  		 * setup up the limbo worker.
>  		 */
>  		if (!has_busy_rmid(d))
> -			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL);
> +			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL,
> +						RESCTRL_PICK_ANY_CPU);
>  		set_bit(idx, d->rmid_busy_llc);
>  		entry->busy++;
>  	}
> @@ -816,15 +817,28 @@ void cqm_handle_limbo(struct work_struct *work)
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
> +void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms,
> +			     int exclude_cpu)
>  {
>  	unsigned long delay = msecs_to_jiffies(delay_ms);
>  	int cpu;
>  
> -	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
> +	if (exclude_cpu == RESCTRL_PICK_ANY_CPU)
> +		cpu = cpumask_any_housekeeping(&dom->cpu_mask);
> +	else
> +		cpu = cpumask_any_housekeeping_but(&dom->cpu_mask,
> +						   exclude_cpu);

Having callers need to do this checking seems unnecessary and makes the
code complicated. Can cpumask_any_housekeeping_but() instead be made
slightly smarter to handle the case where exclude_cpu == RESCTRL_PICK_ANY_CPU ?

Looks like there is a bit of duplication between 
cpumask_any_housekeeping() and cpumask_any_housekeeping_but().

>  	dom->cqm_work_cpu = cpu;
>  
> -	schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
> +	if (cpu < nr_cpu_ids)
> +		schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
>  }
>  
>  void mbm_handle_overflow(struct work_struct *work)
> @@ -870,7 +884,15 @@ void mbm_handle_overflow(struct work_struct *work)
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
> +void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms,
> +				int exclude_cpu)
>  {
>  	unsigned long delay = msecs_to_jiffies(delay_ms);
>  	int cpu;
> @@ -881,9 +903,15 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>  	 */
>  	if (!resctrl_mounted || !resctrl_arch_mon_capable())
>  		return;
> -	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
> +	if (exclude_cpu == RESCTRL_PICK_ANY_CPU)
> +		cpu = cpumask_any_housekeeping(&dom->cpu_mask);
> +	else
> +		cpu = cpumask_any_housekeeping_but(&dom->cpu_mask,
> +						   exclude_cpu);
>  	dom->mbm_work_cpu = cpu;
> -	schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
> +
> +	if (cpu < nr_cpu_ids)
> +		schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
>  }
>  

Reinette

