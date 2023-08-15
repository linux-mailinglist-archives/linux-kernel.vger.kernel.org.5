Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052E677C451
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbjHOAJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbjHOAJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:09:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79D6E51
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692058141; x=1723594141;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=906d4AdfdujwOjMcaC+nZ1H/TFJtvgsmxxjnXJtQh0Q=;
  b=B4+99Le1dN8H1Th3mIKAf5Z7u1b0R2NIxok7PEw2xJpNnNiA4+j7ItI9
   1Y4Us0yuM0TuuAkWSxaoUgmn0aUCp4YvckL0RHM6hzwO3UFUerm2ybRgR
   ZV1dAQU6YHUHeRTzbvw8wyTBvxCXWv17thegDEVEZJmOUJh4NyJhNBiKs
   fjPIMi7MBfWXIQQF+mZDk8FoyEl3lyIGy6//mucI55JBkaRhrG7KGiljU
   pMhcSHyJWVLL72BrGTbLqDVNCC9TH3RjmnZB0JHPooH5p50pcDzvp0qlN
   1I5ZDeCHrL/zPlpuaoU8N9y9FGTn7e33I6jFvSE+HS/1ucrUHe1fmuZme
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="357131575"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="357131575"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 17:09:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="1064258665"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="1064258665"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 14 Aug 2023 17:09:00 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 17:09:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 17:09:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 17:08:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gm9c2sWGa9RSZuHXASB3AFqJGkNQcNinnzeliNK/8whDohCOakpaYKtJRVmBhQ+Tki66SLl1BCAq/fHQPGAHct2/z35lUqTvOEaw6fk3TKrkXoAsZoPHp48Q0iFd9RtD7gpHP1CnaDJgGDeQwUKgutotGZrWL2XKTtIeDvr/3DHBW3/BrFv5RV/9NxkjP0I+GCcwrPuuHU3UWcwU5+E4+hLJnJIq/xEf2Dmi0E6R2NZ3RxwPLfJRGjOoYGu1xYKrti8+M2+2ZL9G73B6PBCJrRRm9aPGkdOjYQxaPE3QN9p8321CyntZgKHX5P91Qu5PkUCFRDCKK23SKXCdvp+0ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5/U4I1TZesvpn4d+ZLBlrlMEd3c1TtUfiJKfL4/aBs=;
 b=SCywd5mCCWTAenNUn+Ua3dv8lL9gOfPUQRJbwBIldlHgyray11uUks4PFvpyxEyDAQufKKPfAeBsaBR0SH4WaqyiCq/nPlpNJOqrEipcghug/txWTOmfGDEKcRi0Ebbyqrlmxw60FrskU1w842t4YOHhXEECeV077fYbpR0m1ej5g7Mbn5c4Dh4GyF5UjCWm+VdafWt64+Vnwyac0uNu+agBY9oMw0B+FG36OPIUu/mM58+aIMAXn7SSB7ugoWGUuAlYkrNv4rLzGtc2B5MQ54XbWjoAokEfKg+XSHVYA+8yTqVcXCaFSJ0S5Q+Emq5OXG9gTAHZKExPPvRpd8usyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA1PR11MB5876.namprd11.prod.outlook.com (2603:10b6:806:22a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 00:08:57 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 00:08:57 +0000
Message-ID: <465b91e7-df7e-c94f-881f-f09f21d74557@intel.com>
Date:   Mon, 14 Aug 2023 17:09:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v5 01/24] x86/resctrl: Track the closid with the rmid
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-2-james.morse@arm.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230728164254.27562-2-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::35) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SA1PR11MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 53910fe1-7abd-43ac-c5e9-08db9d23d1e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bpidCIbz14u4N15x3apsbiA9YWbayIxpsKlY6lJ7tN0wPdNIVV0FkHAzMwlUYmslKr6wwJI5eQ7eIObkW6tr4sSqQ0O39Lz01aAuTn0asYgXdn4a2B7wOdRoNPkW0f23mMSsnnVXGh+XkLaZR7kgV/eAFLSPLWcEwDPp1QRwsrtLIj9N8imt3qMfgf93OAY2GlwbNF+CtYTPJc55vFYl5TEakB7oDwn4UFFGTcQBdHjB/Xt6cOwey+89l3nEKgPJiYK4WCcxaljcXbgJmatbyv85doJ3kGGLGoDem6g495y9x0PS0eZ00OmouHZyZBlVv4GJmy24YYO14eq62R3E6BKS/H2Pqxplv8QGvyV6PVjq6UhQkdfJTLHaENZ3z8/JRsKSILGRvKktDFNaSKmI400hWv7sRnjshlFQRShuOccWgN9iWwOi9LnUmEbilEzP8oXWTzf+gmSua9oRAC9G2zGu/O96Zz4ZjeyFQCiC7ai2/7Y++W0A9v8ljtfPo98ZxZYhfvHw7H+UuLg7NlZe2A5qnNgbbl2/Pzch5rcZrl08GFYPX55ebzq0KTUbfgqcBILWDtt4YLWwGNbTRnz4adVgnZVUtJvdY9Rtrr+HwugqiyeRuk/z5+Gtq2pC5oubAXZO1JpPlWj3W4HXQaScgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(366004)(136003)(396003)(186006)(1800799006)(451199021)(83380400001)(36756003)(31686004)(31696002)(86362001)(41300700001)(478600001)(66946007)(66476007)(54906003)(6512007)(66556008)(316002)(8676002)(5660300002)(4326008)(44832011)(8936002)(82960400001)(38100700002)(2616005)(30864003)(26005)(6486002)(6666004)(2906002)(7416002)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXZPQjhRRkM1bGdCWTBVZFFGV2pxTDdZMEZPaWJ3NzlEZGk3WGU0WEwxcXBJ?=
 =?utf-8?B?OUUyM3NNazJJcmMzSW9abHEySXA3RU1WV3JxY1lveFB3U1NiSms5ZllBOXY1?=
 =?utf-8?B?UXN3RHZQUGlKMW05WC9hM096RFVJYnVkQVVPOGNHTXVtTzd2NDdqUzEyNFE1?=
 =?utf-8?B?ZWxtWDZRVWlhbWJlWUVxQ1hjMTlBcHZEL3pib2tlcnh3UlBmZmlDSEU2bjR2?=
 =?utf-8?B?NjA0UWc0eWo3OWlVclhhQ25tNWhac2h6eXZqeGpZVVphRVppZ1FKcHRtVjJz?=
 =?utf-8?B?VWgzNDU4bXhIeEZ6cVJMRGxDWlpHTy9Ba0xMMFhnWVlYZmd2WHJtWmtZUHJt?=
 =?utf-8?B?Zml2OGlNOEROZDZOdGFyL0pRUk42aWpNd2FCZTZiK0ZsVGFmU01vTzFrekZm?=
 =?utf-8?B?MWxhV0NaOVN3VjhOUWNsV1Y3TjRVWWwrM2gyMW1BWXpid2QxS1ZxVUVxTDZs?=
 =?utf-8?B?cWxOUVV1OGUreGZUV0tHVDdTTE9GQXRTMytGbGhHaDF6bEJ4WDk1TzQwd3RB?=
 =?utf-8?B?a2xvdy9nSHZCRlV1Q2x4UDBaSXlhaUo5WVVNSVZhVURQSnJGSGVZTXVZOHlS?=
 =?utf-8?B?R1gzNTduK1YzQS9lclNiaGZJRzk0ZmZycFhPaEY5aFpWZDRuaGpic2RhanZC?=
 =?utf-8?B?cFdWeGF6KzNyN3pkU0FlMUV2SHlsMjBJYjFTR1dvaU5GSkVTRDhQK3BEd2Ez?=
 =?utf-8?B?b0g4Q0YrRTNuRFl4RWVNbGlBVG8rUVVIZVBhY2lpam42M2d3REZ6UWs0aThi?=
 =?utf-8?B?UUYzcWUveTZnWW9xeXIrOHc2OVNCQm5kNjRnbkRWK3ZCVkIyazBURFlJVGpP?=
 =?utf-8?B?YkRsWUJadVUxTVQrZWk1QjdsY1JjYW5NY1VKK2xWUGVKbzdxL3JoaFN4S0pK?=
 =?utf-8?B?K0ZKWkhud1ZxYkpEbTViWjJnaW82djNMZklGckRIZDUwcXRQenIrZm9NUGs0?=
 =?utf-8?B?WitlZmlWQk9xUkpPQldYU05lR3BWbTJmNTNxdjduOW1BUUMyYXd2N3U5cUE0?=
 =?utf-8?B?UG4rYUh6MkZ6Qy80M0czMThkYWMrVmtKa3VQRTJRVlNkOEpmeFVzYVV4OVpN?=
 =?utf-8?B?NmRNRHhnSVNXNHRjVWExcXdnalhZNlhvM1ZRdFdRek5UbkZzb09IZlo2YU0w?=
 =?utf-8?B?WTRUS21JRTVOd0F0dEZEcndOOEdIMDZjc1c0S0VHMWtQRVljTzJyOWRBdHFy?=
 =?utf-8?B?MTREcloxRThRL05kOS9tYmpydFFtRldVY2huSVVKL1oyQkhubVV5MGo3U1U0?=
 =?utf-8?B?Qzd1RjJPcmlQSWd1QW14cjg2QUdOQStXVEJGMEdTU012dHgyWisweHR5T2JC?=
 =?utf-8?B?cENMQXpRdlZyZk9yNm1tNGpIQTRJRU1vUnFrUE15enB4THE1NlAvVk11YS9N?=
 =?utf-8?B?ek90MjMwNG8xUlNObFpqU0FsZUxGS0Y5aVFrcWVDcDNoTVBqcDk3Q1BaL0xX?=
 =?utf-8?B?YmNNbmo2TTRINDJWMVgxaEpJUWpvMDhsYUVBL2RtUjVMTENhelovNmw5Y3Qw?=
 =?utf-8?B?VUgyTWsrS1NKbkFRKzV1REp4UUxLcXBZYytZYVk4a08zVVNxbFRNMmFGa2VI?=
 =?utf-8?B?UHBpODA0bkZITStwRytCQnZ1S1VtcEV2andTdmxxcGN1RGRpMFc0Q0E0VWhR?=
 =?utf-8?B?TmM3ZDRvak12R2lUb3RLL2ZqbzFrS0RhS3QzOXJuQWZ2NTNaZUowVGJHdy9C?=
 =?utf-8?B?VHhJbjlYTXFWc3dkZVhsS1RtV0VUU3R1djZYVDNJMDVkNE13NGdvNjVKdGJZ?=
 =?utf-8?B?R05zQmJ5TDZqWitGUzU1V2QvQ0ZaU0RoUnBqVUU5N2FwQS93eFFPRVdsSmJI?=
 =?utf-8?B?c29iWmUrNlFLTzU3RUo1NXhoczc3UkQ4RC83WHFQZURDVytid1hvcmhqUk1Q?=
 =?utf-8?B?djdld3E3d3VneENWTVJhd1NXTXFLUHk1R3JGZHhBcG5RVEJFcElGakJsWVpE?=
 =?utf-8?B?ZmlZQ3BhVDhjSHBaWlF5OVZEM0xabC9VUFFPbGVGaFV5MWtHQXgxMEdING5w?=
 =?utf-8?B?eFpIeW13dGEwMnZ6TXhvYUdmdHlrM1lKZm9kekVScTc0NDFBNXdnNUhZdGNy?=
 =?utf-8?B?T1h1M3BHQ1FwMjZjeDdZcytteUNNRFlEUlNCUFhOS3BUMU1DQnphSk5CenhH?=
 =?utf-8?Q?VpYX/ITDQykWxoPE3gxmKm7/X?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53910fe1-7abd-43ac-c5e9-08db9d23d1e4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 00:08:57.6177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2lNVS5ALcVnjAqPXToYLZ6FCDqr1VLxdpZX8mficAJPVte04VprefARUwH/xQQv2kmJMtmb5C2CgdfyWu+U1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5876
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James,

On 7/28/23 09:42, James Morse wrote:
> x86's RMID are independent of the CLOSID. An RMID can be allocated,
> used and freed without considering the CLOSID.
> 
> MPAM's equivalent feature is PMG, which is not an independent number,
> it extends the CLOSID/PARTID space. For MPAM, only PMG-bits worth of
> 'RMID' can be allocated for a single CLOSID.
> i.e. if there is 1 bit of PMG space, then each CLOSID can have two
> monitor groups.
> 
> To allow resctrl to disambiguate RMID values for different CLOSID,
> everything in resctrl that keeps an RMID value needs to know the CLOSID
> too. This will always be ignored on x86.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Xin Hao <xhao@linux.alibaba.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---
> Is there a better term for 'the unique identifier for a monitor group'.
> Using RMID for that here may be confusing...
> 
> Changes since v1:
>   * Added comment in struct rmid_entry
> 
> Changes since v2:
>   * Moved X86_RESCTRL_BAD_CLOSID from a subsequent patch
> 
> Chances since v3:
>   * Renamed X86_RESCTRL_BAD_CLOSID to EMPTY
>   * Clarified a few comments and kernel-doc
> ---
>   arch/x86/include/asm/resctrl.h            |  7 +++
>   arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
>   arch/x86/kernel/cpu/resctrl/monitor.c     | 65 ++++++++++++++---------
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  4 +-
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 12 ++---
>   include/linux/resctrl.h                   | 12 ++++-
>   6 files changed, 65 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index 255a78d9d906..29999f52b461 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -7,6 +7,13 @@
>   #include <linux/sched.h>
>   #include <linux/jump_label.h>
>   
> +/*
> + * This value can never be a valid CLOSID, and is used when mapping a
> + * (closid, rmid) pair to an index and back. On x86 only the RMID is
> + * needed.
> + */

This value is not defined by x86 hw (not by ARM hw either, I guess). So 
I would add something in the comment like "It's a software defined value."

> +#define X86_RESCTRL_EMPTY_CLOSID         ((u32)~0)
> +
>   /**
>    * struct resctrl_pqr_state - State cache for the PQR MSR
>    * @cur_rmid:		The cached Resource Monitoring ID
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 85ceaf9a31ac..f2da908bb079 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -535,7 +535,7 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
>   int closids_supported(void);
>   void closid_free(int closid);
>   int alloc_rmid(void);
> -void free_rmid(u32 rmid);
> +void free_rmid(u32 closid, u32 rmid);
>   int rdt_get_mon_l3_config(struct rdt_resource *r);
>   bool __init rdt_cpu_has(int flag);
>   void mon_event_count(void *info);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index ded1fc7cb7cb..fa66029de41c 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -25,6 +25,12 @@
>   #include "internal.h"
>   
>   struct rmid_entry {
> +	/*
> +	 * Some architectures's resctrl_arch_rmid_read() needs the CLOSID value
> +	 * in order to access the correct monitor. This field provides the
> +	 * value to list walkers like __check_limbo(). On x86 this is ignored.
> +	 */
> +	u32				closid;
>   	u32				rmid;
>   	int				busy;
>   	struct list_head		list;
> @@ -136,7 +142,7 @@ static inline u64 get_corrected_mbm_count(u32 rmid, unsigned long val)
>   	return val;
>   }
>   
> -static inline struct rmid_entry *__rmid_entry(u32 rmid)
> +static inline struct rmid_entry *__rmid_entry(u32 closid, u32 rmid)
>   {
>   	struct rmid_entry *entry;
>   
> @@ -190,7 +196,8 @@ static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_domain *hw_dom,
>   }
>   
>   void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
> -			     u32 rmid, enum resctrl_event_id eventid)
> +			     u32 closid, u32 rmid,

"closid" is not used on x86. Usually it's named as "u32 unused" on x86 
so that it's clear for others that the parameter won't be used in this 
fucntion.

> +			     enum resctrl_event_id eventid)
>   {
>   	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>   	struct arch_mbm_state *am;
> @@ -230,7 +237,8 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
>   }
>   
>   int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
> -			   u32 rmid, enum resctrl_event_id eventid, u64 *val)
> +			   u32 closid, u32 rmid, enum resctrl_event_id eventid,

Ditto.

I would think all "closid" parameters in all related arch functions on 
x86 should be re-named as "unused" so that it's cleared to express its 
meaning. Otherwise, people may get confused why "closid" is tangled when 
monitoring.


> +			   u64 *val)
>   {
>   	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>   	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> @@ -285,9 +293,9 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>   		if (nrmid >= r->num_rmid)
>   			break;
>   
> -		entry = __rmid_entry(nrmid);
> +		entry = __rmid_entry(X86_RESCTRL_EMPTY_CLOSID, nrmid);// temporary
>   
> -		if (resctrl_arch_rmid_read(r, d, entry->rmid,
> +		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
>   					   QOS_L3_OCCUP_EVENT_ID, &val)) {
>   			rmid_dirty = true;
>   		} else {
> @@ -342,7 +350,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>   	cpu = get_cpu();
>   	list_for_each_entry(d, &r->domains, list) {
>   		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
> -			err = resctrl_arch_rmid_read(r, d, entry->rmid,
> +			err = resctrl_arch_rmid_read(r, d, entry->closid,
> +						     entry->rmid,
>   						     QOS_L3_OCCUP_EVENT_ID,
>   						     &val);
>   			if (err || val <= resctrl_rmid_realloc_threshold)
> @@ -366,7 +375,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>   		list_add_tail(&entry->list, &rmid_free_lru);
>   }
>   
> -void free_rmid(u32 rmid)
> +void free_rmid(u32 closid, u32 rmid)
>   {
>   	struct rmid_entry *entry;
>   
> @@ -375,7 +384,7 @@ void free_rmid(u32 rmid)
>   
>   	lockdep_assert_held(&rdtgroup_mutex);
>   
> -	entry = __rmid_entry(rmid);
> +	entry = __rmid_entry(closid, rmid);
>   
>   	if (is_llc_occupancy_enabled())
>   		add_rmid_to_limbo(entry);
> @@ -383,8 +392,8 @@ void free_rmid(u32 rmid)
>   		list_add_tail(&entry->list, &rmid_free_lru);
>   }
>   
> -static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 rmid,
> -				       enum resctrl_event_id evtid)
> +static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 closid,
> +				       u32 rmid, enum resctrl_event_id evtid)
>   {
>   	switch (evtid) {
>   	case QOS_L3_MBM_TOTAL_EVENT_ID:
> @@ -396,20 +405,21 @@ static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 rmid,
>   	}
>   }
>   
> -static int __mon_event_count(u32 rmid, struct rmid_read *rr)
> +static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
>   {
>   	struct mbm_state *m;
>   	u64 tval = 0;
>   
>   	if (rr->first) {
> -		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
> -		m = get_mbm_state(rr->d, rmid, rr->evtid);
> +		resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
> +		m = get_mbm_state(rr->d, closid, rmid, rr->evtid);
>   		if (m)
>   			memset(m, 0, sizeof(struct mbm_state));
>   		return 0;
>   	}
>   
> -	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, rmid, rr->evtid, &tval);
> +	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid, rr->evtid,
> +					 &tval);
>   	if (rr->err)
>   		return rr->err;
>   
> @@ -429,7 +439,7 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
>    * __mon_event_count() is compared with the chunks value from the previous
>    * invocation. This must be called once per second to maintain values in MBps.
>    */
> -static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
> +static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
>   {
>   	struct mbm_state *m = &rr->d->mbm_local[rmid];
>   	u64 cur_bw, bytes, cur_bytes;
> @@ -459,7 +469,7 @@ void mon_event_count(void *info)
>   
>   	rdtgrp = rr->rgrp;
>   
> -	ret = __mon_event_count(rdtgrp->mon.rmid, rr);
> +	ret = __mon_event_count(rdtgrp->closid, rdtgrp->mon.rmid, rr);
>   
>   	/*
>   	 * For Ctrl groups read data from child monitor groups and
> @@ -470,7 +480,8 @@ void mon_event_count(void *info)
>   
>   	if (rdtgrp->type == RDTCTRL_GROUP) {
>   		list_for_each_entry(entry, head, mon.crdtgrp_list) {
> -			if (__mon_event_count(entry->mon.rmid, rr) == 0)
> +			if (__mon_event_count(rdtgrp->closid, entry->mon.rmid,
> +					      rr) == 0)
>   				ret = 0;
>   		}
>   	}
> @@ -600,7 +611,8 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>   	}
>   }
>   
> -static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
> +static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
> +		       u32 closid, u32 rmid)
>   {
>   	struct rmid_read rr;
>   
> @@ -615,12 +627,12 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
>   	if (is_mbm_total_enabled()) {
>   		rr.evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
>   		rr.val = 0;
> -		__mon_event_count(rmid, &rr);
> +		__mon_event_count(closid, rmid, &rr);
>   	}
>   	if (is_mbm_local_enabled()) {
>   		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
>   		rr.val = 0;
> -		__mon_event_count(rmid, &rr);
> +		__mon_event_count(closid, rmid, &rr);
>   
>   		/*
>   		 * Call the MBA software controller only for the
> @@ -628,7 +640,7 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
>   		 * the software controller explicitly.
>   		 */
>   		if (is_mba_sc(NULL))
> -			mbm_bw_count(rmid, &rr);
> +			mbm_bw_count(closid, rmid, &rr);
>   	}
>   }
>   
> @@ -685,11 +697,11 @@ void mbm_handle_overflow(struct work_struct *work)
>   	d = container_of(work, struct rdt_domain, mbm_over.work);
>   
>   	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> -		mbm_update(r, d, prgrp->mon.rmid);
> +		mbm_update(r, d, prgrp->closid, prgrp->mon.rmid);
>   
>   		head = &prgrp->mon.crdtgrp_list;
>   		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
> -			mbm_update(r, d, crgrp->mon.rmid);
> +			mbm_update(r, d, crgrp->closid, crgrp->mon.rmid);
>   
>   		if (is_mba_sc(NULL))
>   			update_mba_bw(prgrp, d);
> @@ -732,10 +744,11 @@ static int dom_data_init(struct rdt_resource *r)
>   	}
>   
>   	/*
> -	 * RMID 0 is special and is always allocated. It's used for all
> -	 * tasks that are not monitored.
> +	 * CLOSID 0 and RMID 0 are special and are always allocated. These are
> +	 * used for rdtgroup_default control group, which will be setup later.
> +	 * See rdtgroup_setup_root().
>   	 */
> -	entry = __rmid_entry(0);
> +	entry = __rmid_entry(0, 0);
>   	list_del(&entry->list);
>   
>   	return 0;
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 458cb7419502..aeadaeb5df9a 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -738,7 +738,7 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
>   	 * anymore when this group would be used for pseudo-locking. This
>   	 * is safe to call on platforms not capable of monitoring.
>   	 */
> -	free_rmid(rdtgrp->mon.rmid);
> +	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>   
>   	ret = 0;
>   	goto out;
> @@ -773,7 +773,7 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
>   
>   	ret = rdtgroup_locksetup_user_restore(rdtgrp);
>   	if (ret) {
> -		free_rmid(rdtgrp->mon.rmid);
> +		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>   		return ret;
>   	}
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 725344048f85..f7fda4fc2c9e 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2714,7 +2714,7 @@ static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
>   
>   	head = &rdtgrp->mon.crdtgrp_list;
>   	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
> -		free_rmid(sentry->mon.rmid);
> +		free_rmid(sentry->closid, sentry->mon.rmid);
>   		list_del(&sentry->mon.crdtgrp_list);
>   
>   		if (atomic_read(&sentry->waitcount) != 0)
> @@ -2754,7 +2754,7 @@ static void rmdir_all_sub(void)
>   		cpumask_or(&rdtgroup_default.cpu_mask,
>   			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
>   
> -		free_rmid(rdtgrp->mon.rmid);
> +		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>   
>   		kernfs_remove(rdtgrp->kn);
>   		list_del(&rdtgrp->rdtgroup_list);
> @@ -3252,7 +3252,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>   	return 0;
>   
>   out_idfree:
> -	free_rmid(rdtgrp->mon.rmid);
> +	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>   out_destroy:
>   	kernfs_put(rdtgrp->kn);
>   	kernfs_remove(rdtgrp->kn);
> @@ -3266,7 +3266,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>   static void mkdir_rdt_prepare_clean(struct rdtgroup *rgrp)
>   {
>   	kernfs_remove(rgrp->kn);
> -	free_rmid(rgrp->mon.rmid);
> +	free_rmid(rgrp->closid, rgrp->mon.rmid);
>   	rdtgroup_remove(rgrp);
>   }
>   
> @@ -3415,7 +3415,7 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>   	update_closid_rmid(tmpmask, NULL);
>   
>   	rdtgrp->flags = RDT_DELETED;
> -	free_rmid(rdtgrp->mon.rmid);
> +	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>   
>   	/*
>   	 * Remove the rdtgrp from the parent ctrl_mon group's list
> @@ -3461,8 +3461,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>   	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
>   	update_closid_rmid(tmpmask, NULL);
>   
> +	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>   	closid_free(rdtgrp->closid);
> -	free_rmid(rdtgrp->mon.rmid);
>   
>   	rdtgroup_ctrl_remove(rdtgrp);
>   
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 8334eeacfec5..c413bb11d336 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -225,6 +225,9 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>    *			      for this resource and domain.
>    * @r:			resource that the counter should be read from.
>    * @d:			domain that the counter should be read from.
> + * @closid:		closid that matches the rmid. Depending on the architecture, the
> + *			counter may match traffic of both @closid and @rmid, or @rmid
> + *			only.
>    * @rmid:		rmid of the counter to read.
>    * @eventid:		eventid to read, e.g. L3 occupancy.
>    * @val:		result of the counter read in bytes.
> @@ -235,20 +238,25 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>    * 0 on success, or -EIO, -EINVAL etc on error.
>    */
>   int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
> -			   u32 rmid, enum resctrl_event_id eventid, u64 *val);
> +			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
> +			   u64 *val);
> +
>   
>   /**
>    * resctrl_arch_reset_rmid() - Reset any private state associated with rmid
>    *			       and eventid.
>    * @r:		The domain's resource.
>    * @d:		The rmid's domain.
> + * @closid:	closid that matches the rmid. Depending on the architecture, the
> + *		counter may match traffic of both @closid and @rmid, or @rmid only.
>    * @rmid:	The rmid whose counter values should be reset.
>    * @eventid:	The eventid whose counter values should be reset.
>    *
>    * This can be called from any CPU.
>    */
>   void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
> -			     u32 rmid, enum resctrl_event_id eventid);
> +			     u32 closid, u32 rmid,
> +			     enum resctrl_event_id eventid);
>   
>   /**
>    * resctrl_arch_reset_rmid_all() - Reset all private state associated with

Thanks.

-Fenghua
