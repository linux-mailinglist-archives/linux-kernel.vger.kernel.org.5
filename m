Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E976B77C502
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbjHOBWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbjHOBWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:22:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B181B2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 18:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692062526; x=1723598526;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UJS8QPltZxLSF5qrjEno9hyhnbhzklqhOzetVp+va78=;
  b=Q8d2+AWR0sQs6Nm9+BK9r91DLDlyOEzf1gISPU8ZcvCv7MFrD+vdgtFj
   o+8QYgT4mFXd4v8Y2xBKwC2YEXZV3aq6ROwsShSNycSF1TKdGwdmLCbbI
   yLPHLcgTtR34D047oLCU5d1LSX0gLv/o2hQwZEFn+vCHPVBTkV3kBAghx
   Dz6Wa4zNf3mUCQw26o040aL1Poe2rxBuaiqj2SiXt33Z1m+M16m49ByY2
   vAKZinIKP5KmY9kS8qnPgwimiFB/aOLk+eVNRvqfQlgxJTz6/h98LLMHb
   sUysHHhoX3pReaRb8dCgXRxswH5e71lcRq1b7RXtXS+d3Bx1XKI6dsh6w
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="375907388"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="375907388"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 18:22:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="736728796"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="736728796"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 14 Aug 2023 18:22:04 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 18:22:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 18:22:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 18:22:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 18:22:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=id1kRXBxffOij5PMfKV9KR/SBb9ysWoPZiq9RdcDUUCq9sCJMx6v4w2GWjhwEdhgR+3xrYe2nFNWtBPElvvtnP//002bN4d/jGL7AVvCg6CFZA6XNNmbCpuFbH5qaGxoXbdCKViYAsoAucK8IbPia9rqge7Sp+KBbAVXPD5+LM1Rt36bzFmGCShGmml+OzxfFSlqPWvemEpeCsyaGg5FoyWmI1/aMfKThWopNMX9ZwCf2fGozRHTfiMqSLJHZOQR7wLlUhnSXeLEeT+orz+74KrNR8dDp5n1pPYYNF+DkmIZ0Uvuin2/0cTnPuuwlQWhU+IYwjkAV3d3zuBobjJy7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkEd+sfK121/uyZhCD2ZGcEt0zXJs5Yyo4r4Vu9HC8E=;
 b=TKu+F79Ziqou4GxqjJfrhHjgf5VYormV9u/8wfO7/0u3zy9mC7zV+ZRt/alvWbdjj9Dg8a/Gyw7ZvMoJYUeL8ppkTV338biQnJXSrho0ofHI9txEXHLoiBSeRCgqSBDPQinFZ+8T6C2JDsFhWO5SfLRR2pZoy2qY6u7GVdOitXQDxlW4ftOfCzRPkLgh2i9K4v11yx1ItU9l0UKFFUKYhsoseqh29QqJTpWD8Hkmx0BEusjPmi5hoVWb9zPAAkZTlaLqj8X/HbQBOf3NSDEVhbahFbUlo2lJsN1APgoHj/CGPpdzlZDVWgVS40q8b9z09mGgbhc1LKRqFdu0/oSCMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SN7PR11MB7708.namprd11.prod.outlook.com (2603:10b6:806:352::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 01:21:56 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 01:21:56 +0000
Message-ID: <87ddbc94-5141-9f2e-0003-4d1f2fa373af@intel.com>
Date:   Mon, 14 Aug 2023 18:22:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v5 05/24] x86/resctrl: Allow RMID allocation to be scoped
 by CLOSID
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
 <20230728164254.27562-6-james.morse@arm.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230728164254.27562-6-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::26) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SN7PR11MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b3923f-4910-4c48-e819-08db9d2e0397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AzLTZVO4HAfFTGCKqwMbtQFG64eegphF+qZNVJZs0FDHQEkhGLbxvdqgeYoF6qZsGmPRQWurgckvlStyMTKd6lhgXkzq76uCN7Q+zaDYiTYZqnuGAxDMRxyIvQdp9jTfYodliSnsacXD/B/kH6bvrREE+QHhN6fEbh62+9PTmIXajLpo3iiZGMJCB/4GZXMXyd58aXGIIOgqJAa/a5KpUxMru74BBRC9ozaJ+zxVhG6U/Uan54w6A7nMvTqf3vM/JRRyWzsuPf+5QObBXc/AyHn7t7mtZGNglj1zLgb5JdL6Nz3z2T2I/AT8Ujcc58SA6jz2UlajAsDuSu82NSG8jQUNOK0oo+6UaSPFD/t1sIirdehP7sGCvrmm8kgwWnnobkZ/g3DCgv3gI+VLZn39atobEKG8111c8mTFOe4RYKa2Ac5pylLBKqJhtH4wPLKe4MqRdA0tgX1kLwkoYTorEOSgowOzF8bH0dlygfBmwWCms0g4dPsDr+fRibxohVRQbsQlxCsj1jW0Bv6VUrR5c6EcENo5i3nrP7J1jR4BwX8x8WjyWkYNEoe3IIw2APT4gQ3W2uRb1xv57MorX97uXUFGSBr5V/AVPCllHRlC4J9+KQl9pCtGPb/TNQ+a9Iam/gzu3C29xn65JHgM2N1Jow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(366004)(136003)(396003)(186006)(1800799006)(451199021)(83380400001)(36756003)(31686004)(31696002)(86362001)(41300700001)(478600001)(66946007)(66476007)(54906003)(6512007)(66556008)(316002)(8676002)(5660300002)(4326008)(44832011)(8936002)(82960400001)(38100700002)(2616005)(26005)(6486002)(6666004)(2906002)(7416002)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUNvcFFwMkt3K2NLNld3dHFrK2gwbXhWckwxL2k0MlNMVHp6TFV5ZG9Oc0to?=
 =?utf-8?B?Q3Njcld3U01lODBsR0VUWjA5RlZYNjJhRDAxVm1rbG9TWTJ5eWdQWGVIdDhV?=
 =?utf-8?B?UHR2b1hWS2xnRnV6VUpNTHRROU9EZlduT09pNDlxbklDcFpLczlkVW1ycjJG?=
 =?utf-8?B?cWNzVzNNYVIyYnNYRlptNjBGS1FVazlpZURyYm9ubENKRW9mOU0yUGg1Q0ZO?=
 =?utf-8?B?TmRzUDhoZi9tdWpqaEpFZnNiWisya2k3OG5zSEEzRERwUkFYWndGaDVhOWV0?=
 =?utf-8?B?VzQzcFV4bXRYQmN2bFUxb0lmR0owY2t1VWNKYkVjS1JUZE5FUTcwdWFwaXJw?=
 =?utf-8?B?U1JmenZHTW92eVZ3YnVwL3dEM2lxdHN6TWcvblY2UXFVZE8rNU9nWksvcjFu?=
 =?utf-8?B?ZFgya3Vob0xFWGgvdDFwc0g2NkEwdys3U0wwUWNWa1EzcHhjNGcyZ2srOUkx?=
 =?utf-8?B?YlVZOXFPOVZHRDVSR3YvM0tCQnhET0xWZExyRXZiaEFmbFVLeHdJcnhNNCtB?=
 =?utf-8?B?ZW51dTJ2OHI5YzZPK3VLK2k2N3l6akJ4MnVkQkc2czhRMnJSVTlUTzFsTDJW?=
 =?utf-8?B?MmpOY3BGZ3N4S2E0akJIUDNCM3hrdDdFZ3BmQmNpVVJxa2xtc3ZyOWtGZ2ZX?=
 =?utf-8?B?S0VSbjNUTzdweDdoTS9DNWFCcmJLU3hxK1liMk9Va1ZwV29rb1NxdGxyenJ5?=
 =?utf-8?B?empZN2ZMbHdoNC9ST2xYUCs1dkM2NjJseitMMG8vdGcxUGxKYTNEalZPSktq?=
 =?utf-8?B?eHF6YzVXUUlreSs4TktNUXZCYndTeGpzN2p0bFFSVTBBRTdjcW5aTEp2VjVn?=
 =?utf-8?B?a0NXb2JKR2U2STdpU05nVjRlMDdoMHRHUjJvbHlqbWVLYURlNHhhaEZVRUZH?=
 =?utf-8?B?dms3bi9VOGxGcDEwTnlUVTZhV1J2V3NBWHNCaW5tZENIUEtwZTd1L1hKanJi?=
 =?utf-8?B?MkdlMmtyMC9NNGw4T253TEtoR3h2c2tScElrQ0lROXFpOVUzSXlIV0lWNExo?=
 =?utf-8?B?RkJLSy84WkRoNVEyNGdNc1JxT09aSjJmNXNHR1lySTN6MHh0c0hqd1RRemVv?=
 =?utf-8?B?TFJ3bWNZcUIwYVB3aFY3VmdMeFF2Rm5DMUlmdGJ6eUN6c01GYjEwalYzMnkz?=
 =?utf-8?B?ZituS0pwUi9mQkdmOEhEd2QzU0o5eDJPbW13NWFONFBTVXFORjhETW1KbFZK?=
 =?utf-8?B?T1psSUZCbnhVV1lSSnJpR2lPeVB3cGJ0YlZYSFBwV0ZQYnpCQkZLUFIyamJa?=
 =?utf-8?B?NjFhQVA3QlpjVnlGRGxpblFReng5S2V4cWh1eE5IeXIxMnI1TjFKYm04RGtV?=
 =?utf-8?B?WTh3N2tDQk5IK3J1VVpabmc5YTQyek9sWGRjWGpOY0tBV1FuOVFnT0ZWVE1x?=
 =?utf-8?B?aGVpUXp6VVZ6QlBycW1ubVJXcGgyL3BaRGNleE9OejZjTk16dlBQUTF1SU5v?=
 =?utf-8?B?S2hFbS9OOURKbmpteWFYZEV2VjhQV1hpTkhveUZyT1NtS0xodlNaNzdjQmlX?=
 =?utf-8?B?bm9PVTRseHJTMWJGaGhSQ1RPVkVOVnBCNHhXek1GNVZ4OEJYRlFEUXR0QTUr?=
 =?utf-8?B?RVJZTlBhNTBIQmE4QzdlWGpUR0ZrM3V2QjJDZmNJMThaakp3VURKWGFqK0pF?=
 =?utf-8?B?TXZXZDFIQXExWUZvamppbE1QYk9lRisxNnJZYmxlVXplN25hL0UraGRRY3N5?=
 =?utf-8?B?UTdQeXFZVjVmNkZ0d0tETUlRQWRqbWQ1RXNpSlc5VzBFTWlNS3NMNG1KZ1gy?=
 =?utf-8?B?NEFDNVljczNpMFJUNTZHeE14UHhTTUhTMFJRL3dib21DSXVHR0pRUExFeDJN?=
 =?utf-8?B?ekIwUTdkU2YzOCtoS1BMYW02Mzg4aklnSzlkVjhlTVBuN2VIOU1yS2J6QXE2?=
 =?utf-8?B?ODNxc0QwZ09WNXNLY2lpRk1rSW5VTVdnWkFFYnJ5blI1UE1RT1RlM3ZoS3li?=
 =?utf-8?B?NThPWk1ENTNua2V4Um9qVlJTY244MjAzbkllWndndk1iSUMvOU5nTFZXbjY1?=
 =?utf-8?B?RjlGUno2dWk2cjM0dWZKTWdmeGhVSE40OXJUZ29PcnFsa3dqcHN2bkdtNkZv?=
 =?utf-8?B?eXl1eHI1SHlpNHRoa0pjekEyeWZtT0ZHVkhrTmVObmlsN0huR2VSc0l2MmdI?=
 =?utf-8?Q?4px2VShB5nQbUsMMrGynlc4WW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b3923f-4910-4c48-e819-08db9d2e0397
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 01:21:56.3046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGeQC98/GT04zVQVhk/GZ/Qky7V3IJGGeICEkja4KOwCKRaPwygE9XzLJMnIPNCECYqjVtIkHxReWE62D4rLUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7708
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James,

On 7/28/23 09:42, James Morse wrote:
> MPAMs RMID values are not unique unless the CLOSID is considered as well.
> 
> alloc_rmid() expects the RMID to be an independent number.
> 
> Pass the CLOSID in to alloc_rmid(). Use this to compare indexes when
> allocating. If the CLOSID is not relevant to the index, this ends up
> comparing the free RMID with itself, and the first free entry will be
> used. With MPAM the CLOSID is included in the index, so this becomes a
> walk of the free RMID entries, until one that matches the supplied
> CLOSID is found.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v2;
>   * Rephrased comment in resctrl_find_free_rmid() to describe this in terms of
>     list_entry_first()
>   * Rephrased comment above alloc_rmid()
> 
> Changes since v3:
>   * Flipped conditions in alloc_rmid()
> 
> Changes since v4:
>   * Typo in comment
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
>   arch/x86/kernel/cpu/resctrl/monitor.c     | 51 +++++++++++++++++------
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  2 +-
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  2 +-
>   4 files changed, 41 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index b48715bb8762..94749ee950dd 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -535,7 +535,7 @@ void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
>   struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
>   int closids_supported(void);
>   void closid_free(int closid);
> -int alloc_rmid(void);
> +int alloc_rmid(u32 closid);
>   void free_rmid(u32 closid, u32 rmid);
>   int rdt_get_mon_l3_config(struct rdt_resource *r);
>   bool __init rdt_cpu_has(int flag);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index bd234b66dddf..de91ca781d9f 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -337,24 +337,49 @@ bool has_busy_rmid(struct rdt_domain *d)
>   	return find_first_bit(d->rmid_busy_llc, idx_limit) != idx_limit;
>   }
>   
> -/*
> - * As of now the RMIDs allocation is global.
> - * However we keep track of which packages the RMIDs
> - * are used to optimize the limbo list management.
> - */
> -int alloc_rmid(void)
> +static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
>   {
> -	struct rmid_entry *entry;
> -
> -	lockdep_assert_held(&rdtgroup_mutex);
> +	struct rmid_entry *itr;
> +	u32 itr_idx, cmp_idx;
>   
>   	if (list_empty(&rmid_free_lru))
> -		return rmid_limbo_count ? -EBUSY : -ENOSPC;
> +		return rmid_limbo_count ? ERR_PTR(-EBUSY) : ERR_PTR(-ENOSPC);
> +
> +	list_for_each_entry(itr, &rmid_free_lru, list) {
> +		/*
> +		 * Get the index of this free RMID, and the index it would need
> +		 * to be if it were used with this CLOSID.
> +		 * If the CLOSID is irrelevant on this architecture, these will
> +		 * always be the same meaning the compiler can reduce this loop
> +		 * to a single list_entry_first() call.

s/list_entry_first()/list_first_entry()/?

Seems the comment is not accurate because the loop is not really reduced 
to a single list_first_entry() call. Getting itr_idx and cmp_idx and 
comparing them are extra operations that list_first_entry() doesn't have.

Maybe change the second half comment to something like:

If the CLOSID is irrelevant on this architecture, the two index values 
are always same on every entry and thus the very first entry will be 
returned.

> +		 */
> +		itr_idx = resctrl_arch_rmid_idx_encode(itr->closid, itr->rmid);
> +		cmp_idx = resctrl_arch_rmid_idx_encode(closid, itr->rmid);
> +
> +		if (itr_idx == cmp_idx)
> +			return itr;
> +	}
> +
> +	return ERR_PTR(-ENOSPC);
> +}
> +
> +/*
> + * For MPAM the RMID value is not unique, and has to be considered with
> + * the CLOSID. The (CLOSID, RMID) pair is allocated on all domains, which
> + * allows all domains to be managed by a single limbo list.
> + * Each domain also has a rmid_busy_llc to reduce the work of the limbo handler.
> + */
> +int alloc_rmid(u32 closid)
> +{
> +	struct rmid_entry *entry;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	entry = resctrl_find_free_rmid(closid);
> +	if (IS_ERR(entry))
> +		return PTR_ERR(entry);
>   
> -	entry = list_first_entry(&rmid_free_lru,
> -				 struct rmid_entry, list);
>   	list_del(&entry->list);
> -
>   	return entry->rmid;
>   }
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index aeadaeb5df9a..5ebd6e54c7f2 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -763,7 +763,7 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
>   	int ret;
>   
>   	if (rdt_mon_capable) {
> -		ret = alloc_rmid();
> +		ret = alloc_rmid(rdtgrp->closid);
>   		if (ret < 0) {
>   			rdt_last_cmd_puts("Out of RMIDs\n");
>   			return ret;
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 7c5cfb373d03..b97e119dbe46 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3172,7 +3172,7 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
>   	if (!rdt_mon_capable)
>   		return 0;
>   
> -	ret = alloc_rmid();
> +	ret = alloc_rmid(rdtgrp->closid);
>   	if (ret < 0) {
>   		rdt_last_cmd_puts("Out of RMIDs\n");
>   		return ret;

Thanks.

-Fenghua
