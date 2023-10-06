Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3D57BBA28
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjJFOYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjJFOYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:24:16 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E3CC5
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:24:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ue8F8tMypz+Ovt7jaEO8vb9370SdAskbgcM9uFyRkwx23p23/l1McMD23yxd4pbPUF4mGSuxJ9QLQ3V/zfpFLcTvPQlbG0jv5aC+2JhGEN18W1H2Rf9oTd73+1XouST1y3NVJLsoyKWhFEv8/BP6u8Fy5ZDiU0bH8oxBHGdtyTe1iuItGckmLVhqIZimz45P50N4naE68AjY/RVsDzzmwG3uzezSUamx0ip5dm6CS3TZNI4UhHmrhDdLyGgxFtmtN2Iig3726EvsO8eq2rCa/H9zGuufrOyuM6FXfrrXKxQSz0y/5NvMcbnuXl3cH1NIX05oWUa9RT0gJ1uYYwcZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HswAlbILiz0bxGNKtOUnW8WL+iciwxLzbqfdba+7JtU=;
 b=lxWl6i3MJWyb2Dds14GCtK74uhEewLL+GGB9vtEV7IKgAA2B7mV7sYk7GOeYEqsyHRj4zcbaS0A12A+LaZad1dADZ8GBxS5qRQsNyCZiAmt6IqS1YYnm+dkI0MEkunlDfUBxvclAfptPXz8/wC8+h8dDw5i68bDfCxFBh7hl2QvM7oSLUeKKhFgj41jmeKJS2aUmO3wVNGIlEHtEXTytj9YYGPQ53E2FPX1AmjLE/aRNlyG2g8WzDSdixyvAwaaHuL5Vey1M2WEAECfzczBiBYrS0af+B4AzY5MXhlgz2IqKmsQTp1UmokWERBg8No2tp1Ss13qtfAXoRzewHHfvjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HswAlbILiz0bxGNKtOUnW8WL+iciwxLzbqfdba+7JtU=;
 b=ItCk0oe22TeWx+yqkS8o2bcBgT2cDrqe19R0J7T7812HIFu5GbSA4tDQQHaJ0p2gUznv0nT4wC+N3gEEBf/uLhRQxdtNEh1icU7gUzMomk3eX0xamTS8hrU3og/ux8StDm/dJm5ZGlWN8nOSJqwQANybtvwubrF8hGCi0T9h7ow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB8904.namprd12.prod.outlook.com (2603:10b6:610:167::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Fri, 6 Oct
 2023 14:24:10 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6838.039; Fri, 6 Oct 2023
 14:24:10 +0000
Message-ID: <bf9eced6-52ed-fc0f-ad72-73a4bde9f67c@amd.com>
Date:   Fri, 6 Oct 2023 09:24:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 2/4] x86/resctrl: Enable non-contiguous CBMs in Intel
 CAT
Content-Language: en-US
To:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Peter Newman <peternewman@google.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <cover.1696493034.git.maciej.wieczor-retman@intel.com>
 <bf80d39fe4faa58e3ab661fc2fce7bd1bd9285a5.1696493034.git.maciej.wieczor-retman@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <bf80d39fe4faa58e3ab661fc2fce7bd1bd9285a5.1696493034.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:806:20::26) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: 786b3374-7cfa-4888-6a23-08dbc677e82f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LA2mKIeomTj6uaIGlV+sFP0tnVVJ85miAPk1es7q+THfNoIYL33Cp1KXdJnEBX9bVe2/lYsCB3h4o81iTm2BpIhz64ToKH0ZEmTNt3N5eK/z0ch1uzoCHX56kTMlm7NxWLT9imdyPXR7zJSy/qOhZFhV0GgcmKeO5M4G1ALDn4PD0BggIuVLrJZXvOqZHxSRw0uO/kmvM8g01oD7fnFlWJA9nARaGS5w5Jc65pM6NSGfIWI4qKT1/pCuWllcyiE0MPSrJUQctp3pZkjE1tPNRKDXmPeCo+/BlQm2eamhnZHjdCs4UAEeXsCBYUM4pAt/nPHGdOcBKpRVtB+TgeRrs7G6/7fe6tDv+mdrcvKweQTS/WmR0CVkMf2pDX4KCYyy7y5os0LkotIaC2bK5lN+Gfth3fRC65cjWN2XlotqaAkZLDf/ve1uZXYFB23Fw6tzrqbMncnl1Bs5H25dYtVxLB4MwxUCp+Dz1nrEZmyF6khti3vALnRcXU/Xx7kkTGCzAbtew9b5nKZx9scKajZd8KYYmPp3R+AAuYjn7+ppAGTWMxMgN7t19bQ0O+o8bNvY7XWMDPmi7yUcX4tCfMuKE/GxBZ72dSk+KpBQoZ4wbxAyEcRRWHjxKIjz6bAtQdEjdgJu6gAtoefqHkhhASDaAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(5660300002)(110136005)(83380400001)(2906002)(7416002)(53546011)(6512007)(6506007)(6666004)(38100700002)(316002)(41300700001)(54906003)(66476007)(66556008)(66946007)(8676002)(8936002)(4326008)(31696002)(66574015)(26005)(478600001)(6486002)(2616005)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFY0bmZUMFdRR3JFOXoyaW9rNkxla2ViZXY1MnNnS0FubTlya3NJUnMwQ2pr?=
 =?utf-8?B?ejV0NEVOdU5KOFk2NU9YUmxURDdXSFI2U2lOV3JuTVd6RktlOGF5Q3BCdU50?=
 =?utf-8?B?NG5CdmxQWEUrWkY5L1AzOE1LNXpHeEw5MjhOZWRVd2lOVU5wUTFhNWpuWXEy?=
 =?utf-8?B?WVVoeHhJQ29oSkV4OHpxdEtzQllVR0NiVllzd2ZLRmxhRFBIZG9wV2hZVXhP?=
 =?utf-8?B?Mi93dVd5MkZ3Y2VSZjFjbC9laFdUeklGSXZJTFpTekM1YmtZdE9sNHVpWkdG?=
 =?utf-8?B?aVphTVBiai9CSDVibnJKZnZaQTBjaXIrZHFJa0hCZW9rZmZVdkpLTWhFT05r?=
 =?utf-8?B?Yi83WDYwTElMUjV4WUdkdzdYVVQwY2MxZHEzRjZLTGt5blQ2ZUVnYVJEeS9q?=
 =?utf-8?B?MStoTVV0enlzN3lRU2ZNMXdqYVRVNUc2aVdBL25NcnRkWTBFV2J0U0thcHlJ?=
 =?utf-8?B?OWI1VS9vM21wblFoS2dPbWcvNWJtckNDTlk3ai9Ud1c1aXE5UCtDS0d0T0Nr?=
 =?utf-8?B?YXNUMWJoVVdSWWFUK0Y2RnZ1M0ljamRhOG1vMllNVHM1cTk4T2JEVCtFVDJI?=
 =?utf-8?B?eDhic0UvVWdONDlRcUtRQThhMnFka214eUpNNHdmNnkxYzlBYXBUemdyWDBr?=
 =?utf-8?B?SDgwU2dJQ05pdW0ydlhVaWlQT1hwRVhqZjdJS2dBSE9EOWdyUjlOOGVtcUZq?=
 =?utf-8?B?QVplSHVsaVZ2ZThwSjRlclVINFBqdElmYjFnYTR4VHFlVW42S0RWb3pBRGVT?=
 =?utf-8?B?ckRCU0FRY1ZFYVVxQmZ2NUVHWHFmVm1DQ0hJcFRGZEVySzAyNTV5Y2dZVlBB?=
 =?utf-8?B?TU1jM0l4aUJzSkFyY1lveGJxSVAzY2lVT0RnOWlyVVhkc0Y4ZDhFdmRUalI2?=
 =?utf-8?B?Yno2NUE5ZE1wdGtub1oyNzZYSTN6aUZubExLV3VjanZPY2s4UHIwcWY4b0tu?=
 =?utf-8?B?bnJSVUh5YVFkUnlsc0hMbFlLWXE0OTUwVENhTFQzdHhPYXFla2NKRzVtMGRD?=
 =?utf-8?B?dFFWU2RZZzVFei9sN0p4WTlFeHRkZkxvVCthRGh1UHFWb0pZWkZDOENWRHls?=
 =?utf-8?B?UXRKWGhjM21IMnBWRjRDTFo2Y0lhTEo5WW5LYmIvRXdlNnhUeEJIY2JaVHM5?=
 =?utf-8?B?ZFV4dmM1Skk4cDh5QXRQQkpTMTl0NWxYSHFVK2g1R2JOWSt5a2FpNWFSdDFz?=
 =?utf-8?B?R0Z6RjBTcHJXZlc5bVFvdEpxMmpvUHdUUnhjdmgxZG9YZk1WNUwrampxSW5T?=
 =?utf-8?B?TE43YjZ2Q2MzTjZDM2NxSEVrMk9Na0cwYTg3UUtOQU1SMHp5Y3pnZW85Q3Fm?=
 =?utf-8?B?ME42dkxvU3hvVTVmOTY1cnJaUitWNXpRcGZLV09veEU2VUFrNWtXNU51Wk1C?=
 =?utf-8?B?d3E3Mi8vSnplSElxRzNUZHZqZGxhaVpuWms0Nk5xNjdOQU5tRG5CUWx1WHhr?=
 =?utf-8?B?UU1Ec1FKUjNma0NUSDZvRDBERnRhRmFUWmo4L0g1N0VWbG1zTVV4cGx2b3Vh?=
 =?utf-8?B?YU13S0VuVVJkbWdUVjdMc1dXNVJRWlhhbTNMc3FvWHlnWWhUaXI2dlQ3ZjJ4?=
 =?utf-8?B?QllaMnMrOHZFYk9ic2hyUm1rUWNRRzNiRWE5WWw0Q0dYRHBacExFZm4zbFk4?=
 =?utf-8?B?cUZyVW12NmIyandnWGNxY2dHZU5HUDFwS3VzQWFZTk5uTXBPbWNIbDlVVys4?=
 =?utf-8?B?SCtKTTl1aWZIeGpiUHVIM1NqVXVob2ZVbVpxM0ZKeG9iVm11RVdtQmd4UVVH?=
 =?utf-8?B?YUwxckdsQ3drNW9VNTZ6WFhOT0V4QSttMU5MVFd0R1ljVm5SR1VjVkZsb1o2?=
 =?utf-8?B?Z3pHeEQyeGFBc0I5OHk0OTBBRFlOUWpsRFJDaUJIYWhVOEFSSDVXNUlsWmpD?=
 =?utf-8?B?V1MyZGlMSHMxQW1FT0JpQ2RYQ2pJeVdiSmJQYm1GakxmUlVuT1dDcW5oWUdz?=
 =?utf-8?B?dWdzdGVsbk9FUUE1RTRXSFZUNGtWVXk0R2ZNM2JWd1VYem4wdUhGSzRSV3Qx?=
 =?utf-8?B?VEQ2NHBmYWFhdzZFcEd6bkJ2T1lQMzAxU0ZEdXJZcFBjMHVoV3hEM0F0UjRs?=
 =?utf-8?B?Wmh5d2w1WGgwNUtZTlVLbG02L1VrVk1SajN2eGs5WnhWQ2Q3b2ZkVGVydGgx?=
 =?utf-8?Q?ixEjvofKfQclf+Y4y4a+ZCXLf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786b3374-7cfa-4888-6a23-08dbc677e82f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 14:24:10.3988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkrcBspmnVsvR3wU7WxrMy/M2BR6G0jAf5J9+yqHYH/h6oI/2dDilGHboRa69B+l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8904
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/5/2023 3:15 AM, Maciej Wieczor-Retman wrote:
> The setting for non-contiguous 1s support in Intel CAT is
> hardcoded to false. On these systems, writing non-contiguous
> 1s into the schemata file will fail before resctrl passes
> the value to the hardware.
>
> In Intel CAT CPUID.0x10.1:ECX[3] and CPUID.0x10.2:ECX[3] stopped
> being reserved and now carry information about non-contiguous 1s
> value support for L3 and L2 cache respectively. The CAT
> capacity bitmask (CBM) supports a non-contiguous 1s value if
> the bit is set.
>
> Replace the hardcoded non-contiguous support value with
> the support learned from the hardware. Add hardcoded non-contiguous
> support value to Haswell probe since it can't make use of CPUID for
> Cache allocation.
>
> Originally-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
> ---
> Changelog v4:
> - Add Ilpo's reviewed-by tag.
> - Add Reinette's reviewed-by tag.
>
> Changelog v3:
> - Add Peter's tested-by and reviewed-by tags.
> - Change patch subject to mention CBMs. (Babu)
>
> Changelog v2:
> - Rewrite part of a comment concerning Haswell. (Reinette)
>
>   arch/x86/kernel/cpu/resctrl/core.c        |  9 ++++++---
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 10 ++++++----
>   arch/x86/kernel/cpu/resctrl/internal.h    |  9 +++++++++
>   3 files changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index c09e4fdded3c..19e0681f0435 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -152,6 +152,7 @@ static inline void cache_alloc_hsw_probe(void)
>   	r->cache.cbm_len = 20;
>   	r->cache.shareable_bits = 0xc0000;
>   	r->cache.min_cbm_bits = 2;
> +	r->cache.arch_has_sparse_bitmasks = false;
>   	r->alloc_capable = true;
>   
>   	rdt_alloc_capable = true;
> @@ -267,15 +268,18 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
>   {
>   	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>   	union cpuid_0x10_1_eax eax;
> +	union cpuid_0x10_x_ecx ecx;
>   	union cpuid_0x10_x_edx edx;
> -	u32 ebx, ecx;
> +	u32 ebx;
>   
> -	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx, &edx.full);
> +	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx.full, &edx.full);
>   	hw_res->num_closid = edx.split.cos_max + 1;
>   	r->cache.cbm_len = eax.split.cbm_len + 1;
>   	r->default_ctrl = BIT_MASK(eax.split.cbm_len + 1) - 1;
>   	r->cache.shareable_bits = ebx & r->default_ctrl;
>   	r->data_width = (r->cache.cbm_len + 3) / 4;
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> +		r->cache.arch_has_sparse_bitmasks = ecx.split.noncont;
>   	r->alloc_capable = true;
>   }
>   
> @@ -872,7 +876,6 @@ static __init void rdt_init_res_defs_intel(void)
>   
>   		if (r->rid == RDT_RESOURCE_L3 ||
>   		    r->rid == RDT_RESOURCE_L2) {
> -			r->cache.arch_has_sparse_bitmasks = false;
>   			r->cache.arch_has_per_cpu_cfg = false;
>   			r->cache.min_cbm_bits = 1;
>   		} else if (r->rid == RDT_RESOURCE_MBA) {
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index ab45012288bb..beccb0e87ba7 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -87,10 +87,12 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
>   
>   /*
>    * Check whether a cache bit mask is valid.
> - * For Intel the SDM says:
> - *	Please note that all (and only) contiguous '1' combinations
> - *	are allowed (e.g. FFFFH, 0FF0H, 003CH, etc.).
> - * Additionally Haswell requires at least two bits set.
> + * On Intel CPUs, non-contiguous 1s value support is indicated by CPUID:
> + *   - CPUID.0x10.1:ECX[3]: L3 non-contiguous 1s value supported if 1
> + *   - CPUID.0x10.2:ECX[3]: L2 non-contiguous 1s value supported if 1
> + *
> + * Haswell does not support a non-contiguous 1s value and additionally
> + * requires at least two bits set.
>    * AMD allows non-contiguous bitmasks.
>    */
>   static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 85ceaf9a31ac..c47ef2f13e8e 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -492,6 +492,15 @@ union cpuid_0x10_3_eax {
>   	unsigned int full;
>   };
>   
> +/* CPUID.(EAX=10H, ECX=ResID).ECX */
> +union cpuid_0x10_x_ecx {
> +	struct {
> +		unsigned int reserved:3;
> +		unsigned int noncont:1;
> +	} split;
> +	unsigned int full;
> +};
> +
>   /* CPUID.(EAX=10H, ECX=ResID).EDX */
>   union cpuid_0x10_x_edx {
>   	struct {
