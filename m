Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BB27E72FD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345189AbjKIUjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjKIUjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:39:23 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6636E182
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:39:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GK7yIaGAGMPKWZrUHYXldT239YvMIyN+QPu36hObrnP9oVs2e8aHsVMFcWaiRjgO9KE322CgsdIrTgcIiOpGM6Bj05YPv7bpCbAVsqpzj32yB5w/lG4XE0XADlMalGDi+zsXghhvUzulDpyWTRdTXSCVTLyl6AfmFuhCRHB8Wf36B9e3fhwNejZUBjU9aBJ/VhH/A+XGZYoqwFU2EUEMlznWBh9IhiOaFu6vHs/UBd7By4e+VRgmpZs7fUrJ42zswmu2nH+5j3aSgSL/HuHfYg2++Q1JmIEFKPaVbSYm7XONnKeV26l35NXBaKMio0HO3ARp3VIVOCF/7arc8gmdTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3mJAW1OuO9eVa2qNa0gQZ1c3eBe57exzveCAeItYU0=;
 b=ExULzWE6kTjWJ6jvqz7o48VV+Y61eZH/6NoAvCLkEfraDHHhirAyuDQo48GPWTKi7xq1BxbqfytIMiVy04j0MLIS/4YoQKptYj2YTg2DGLwUTqyPJO8eVIGmXDS13FU/tEGY8QLIkSaVIP/f3OewVItIkn5MrrxlR/4nLlDaL1k1eqOZhFJmUaZ7+bvTXfdL0MNtWF3CeLPNLy64qIRmSkj+kL1A1kjKsFJ7Zgl6NR9bMObrZQIxRcuvnO+NL/zukK95rKu2TaAslBYy90Ktr+NLmXij9y04liHNXRDJc1PsRjEhwUY0qCn2gRTLA70UB8mcfB1W7vfCEJEVgL9q5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3mJAW1OuO9eVa2qNa0gQZ1c3eBe57exzveCAeItYU0=;
 b=xWUSmBdxLDlKrGsTwvwfgwHQXnHDlspvspMXh9sFDpRi1RqlH/j2Doa91yk5cx9HaF5NGJps5rU51i4dSPHKra/lPUgx/nBhL8SnrnHgoSGZby1W4LBSGmfWJYIaHddOjqsJVKFDs15uhsTeEOrW65/8d6esbYHGSdmf+c4xEA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 20:39:18 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 20:39:18 +0000
Message-ID: <7e401723-4cb6-43c4-ad4c-8e3a28639718@amd.com>
Date:   Thu, 9 Nov 2023 14:39:16 -0600
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v7 10/24] x86/resctrl: Allocate the cleanest CLOSID by
 searching closid_num_dirty_rmid
Reply-To: babu.moger@amd.com
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-11-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231025180345.28061-11-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0029.prod.exchangelabs.com (2603:10b6:805:b6::42)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: e25c70e1-4d3a-42d1-f6a4-08dbe163f235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WvgszdyZkY/gVQX2EFkmt5A1uynTPPC0LK/06g+lmPoFT0moRR99cSoT7nJEh65ZSEnw3oCj9USNGhE8H09o6Oa0TFETVa6WWZD5ehIDpk1yfdt6MlUAH3E8q29ar5K+Co3xwJz/WYF84AUoldrL7sAiiQmrJ/kuoDAQG/LdAsoQRq9hmmGP8cC02YLh9Bjun2vP87jlOX7eliOJjB3j3H1IRUPg3IhfaGMgiFl2ogiMt5JyKam0c5rIeju6qs48bW2JsGNwmDBVuzWhns5ohVvQf3ewCvtynGxmyB5iIrERN7qdgVxWKcondF9mGgmgFGtRqUO1k2wu6lrcmO2zt3RsYESsBJXCtaC7q2UdhYtxBtPG8FeW9dt/ANjR3nO4vkBaCKf+cyfNw03TGoRqbaV6993kRgWW6rSfgQ7Zd/1NLsXiR6MfLzuCU80XdvScvRLQ8eAY9I8mYT+Fmf84N2defYSk5mSOHuGRBI4QvAYR0ALDnLO4dTJnu/Y1tigCBZng4glynew3Tip2UlqBmhvfvBAKM+TVnyAXmBTwSyxGeMB46n7WAXKuchBSvL3FEerNeJOqpAiWtpC1/tlhzsxGsDXNsLaVZehe0MKt2wON3Zz0ieFkPqw+26KEvimfMm19kjvg73+C+nJQd6qepxaWBSfglC0SZAQ/eFy+8s0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(31686004)(2616005)(53546011)(6512007)(66556008)(478600001)(6486002)(6506007)(2906002)(54906003)(38100700002)(316002)(36756003)(5660300002)(31696002)(86362001)(41300700001)(3450700001)(66946007)(26005)(8676002)(7416002)(83380400001)(66476007)(4326008)(8936002)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUUva2FtNXplTkcyd0hxaG5Nc0k3S1RCUlc3WHFFSjdGc1NYZWFxTXpaZWlS?=
 =?utf-8?B?R0JUNjMzRVdWclpUb0lWQStyTU9OZ3RuWUdVK2pVZGJ1dUE1amVRYlZnZ3Bt?=
 =?utf-8?B?NmszQitwdnJCVEp3R0pua2FPbEowZ1Q1SzdxSHVEaEdvbThzR3pjbHJPMXl4?=
 =?utf-8?B?TFhxWkhWVnA5QXdyUWVCU0VJTW44bTNjQ1Vud3ZXN0kvdGZlYU5NczNRMDVI?=
 =?utf-8?B?LzlKSHg0aXZuakEveVhBeVQwejZ4d0lXREF2eEtXNlFVSCsyYUxMYW1xK2lD?=
 =?utf-8?B?VTFiQnU4cy9KK29RczIwYk5SRSt3N25rNUV3bkoveDhwTlF4RStiYjZKSW56?=
 =?utf-8?B?YVF1WHZsNmExTHRraXR3WTZnSkNzbXIvWTNKOS9HMlBMUWF4NlVFQTd4d2Iy?=
 =?utf-8?B?SEY0QUdzZW9uRTdJemVjS1NPNE11VHd1d0pSTVRkc2xnZ21DY04vaWJqTTk1?=
 =?utf-8?B?TTlhR1crbk1rMTNzUFJ2SWUwTWxKK2M5cVlKeEFRZXBheE5Wb1habVhYQ2pl?=
 =?utf-8?B?WTdreC9jWklXMmUwKzJzNldRVFE5RTFPdWpLMmZkRWFmdVpsSjB2NE5lUXBY?=
 =?utf-8?B?QzgxQ0JDMkFHT0I2Znk5VEhGTHJnQVhWOG90alpMM0xVSExpbzM3NTlyOGdj?=
 =?utf-8?B?NW5xWmNJUzNQRHZGd2dKeG1HNytES0R5Znk2MEs3bG1JK2JlTlFnSDhrYnM0?=
 =?utf-8?B?a08rOGs1T1psSGdIYkZLYXJEZC9iclNUUmNGR0hZVys0ZER4OTVsQ0NpMTVT?=
 =?utf-8?B?MmwzYVM2S3lmS2FPYXdUZUJHOWlCTnQ3djMwOFl0Tm1waUpzQ3kzNnhtRk1i?=
 =?utf-8?B?TlBWMm50ZWtPWU5pN2x1c3FCTFNlckR6ZDE3NndDM2Q3Yk11VkZrajllb3lm?=
 =?utf-8?B?b0lmK2JxTGl6a3lFODFESUQ3SlhzWGpkTklHMHNNd05CR3hpM01RQjlCMkFl?=
 =?utf-8?B?d0ZMS3VRZkRBWW0zRHFjckQ5R1JieFhJcUI3Y24yRlJHMlA5eExwc3ppakdx?=
 =?utf-8?B?UGU4ZE5HMCtuQittbEF1VGM1M3hBVTAzQzBJRjFnVC9hbXdqbFFOK2lmU1JB?=
 =?utf-8?B?ampaNkhRSnB6cWNBRUpuUWk4cGIremxCbmZHY0RycXFvZU8xby9HVFNobWtW?=
 =?utf-8?B?ME1rSTdyOG5XbHVTZmhwZlZRdVNhSnVHODMwNmRrejNickxZRXRaV2lOeUhU?=
 =?utf-8?B?RWJjbjNRK2FUd1I3MkNWb2hJUS8wRDZSazY5bVBaZlBHWUhVMVpRT1A2SnRD?=
 =?utf-8?B?MnVEdjVPcG1VU1lQRkpLek9JdnZraEZlclJTc2pYdVltM1M5c0syTTRBSUtw?=
 =?utf-8?B?UXRHbnQ4aHgrN0lWRGdIMFV4TEJSR3AwK2U2NEJLaWp5MUdONU1RS3h3NGJM?=
 =?utf-8?B?R1NXbW05WXFRWTlKU1d6SUl6enQrOW5DQmlrblhjWWxnYkY0UGYzUVBaRU1D?=
 =?utf-8?B?YTJQcm5NUTZBMTNCdytxN1U0L3ZQdVlyclRwa01VQjRXYjRWSzFOWkc4VkJs?=
 =?utf-8?B?K2syK3VGbVIvK2RmaUx5SXUrOWFJSDVrZ0NSanRNY25vUVozSGhjdFAwZzFY?=
 =?utf-8?B?WU4vdFBVT0dJS0xDLzlRVzd6S0JId3pSTU96bHZ0NWNJV1RubzJhWDhWWUF4?=
 =?utf-8?B?ancxNzNEVmRyOGpKM2hoak5reFpka1h4Tm5VeVJvV3loeDdSdTVsWjJRZGxx?=
 =?utf-8?B?UUdHV3l0akdQUHkyckNxNkpOb3VKZGdad2hneTN5SFhRTUVqUzhBNDVGVnZN?=
 =?utf-8?B?K3NaMFJwaDVOU0NwRyszS3I1dmlJVGcxcHpqdTF5MmEyRTBKQUlaUzFpTUpC?=
 =?utf-8?B?V1ZyYmwwWVBUOUN0b3p6RlpYZ2R2ZHB5UEhDRTlwazd2MXREaWJFaEdtL3Zz?=
 =?utf-8?B?UFk2QTJiR0dINE9PeWtBaDFYZGMxT1M4blRQRTBZdUZNL1FZZk1XYmRUaUo0?=
 =?utf-8?B?eXdTL25hTzhHNk1xOGJ5eEJmQ0dnS05pSGlWbXBGdjFSTHVuVmZuNTNTR2Zt?=
 =?utf-8?B?eCtucWQ5ZDJvWGUxdkk1OHlmd3hRVUJzMVlsV2kwUG11VjFremRjNUExZ3lL?=
 =?utf-8?B?ejdOclh0bHVNemVYK1UzMEJ0Wmh1bmxJSnNxdFdJNExlZEc0dWM2Vk9qamFm?=
 =?utf-8?Q?czfY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25c70e1-4d3a-42d1-f6a4-08dbe163f235
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:39:18.5844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbzUoQA7GcCo0qPeuGVJQQBbsMQY01GvdScdb/M9Kp5/WXk+0agWQiVjBcK6/xTH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/25/23 13:03, James Morse wrote:
> MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
> used for different control groups.
> 
> This means once a CLOSID is allocated, all its monitoring ids may still be
> dirty, and held in limbo.
> 
> Instead of allocating the first free CLOSID, on architectures where
> CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is enabled, search
> closid_num_dirty_rmid[] to find the cleanest CLOSID.
> 
> The CLOSID found is returned to closid_alloc() for the free list
> to be updated.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>

> ---
> Changes since v4:
>  * Dropped stale section from comment
> 
> Changes since v5:
>  * Renamed some variables.
> 
> No changes since v6
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 45 ++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 ++++++++---
>  3 files changed, 61 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 2f1d4f141dab..521afa016b05 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -568,5 +568,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>  void __init thread_throttle_mode_init(void);
>  void __init mbm_config_rftype_init(const char *config);
>  void rdt_staged_configs_clear(void);
> +bool closid_allocated(unsigned int closid);
> +int resctrl_find_cleanest_closid(void);
>  
>  #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 9a07707d3eb4..cf512d4d383e 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -386,6 +386,51 @@ static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
>  	return ERR_PTR(-ENOSPC);
>  }
>  
> +/**
> + * resctrl_find_cleanest_closid() - Find a CLOSID where all the associated
> + *                                  RMID are clean, or the CLOSID that has
> + *                                  the most clean RMID.
> + *
> + * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocated CLOSID
> + * may not be able to allocate clean RMID. To avoid this the allocator will
> + * choose the CLOSID with the most clean RMID.
> + *
> + * When the CLOSID and RMID are independent numbers, the first free CLOSID will
> + * be returned.
> + */
> +int resctrl_find_cleanest_closid(void)
> +{
> +	u32 cleanest_closid = ~0;
> +	int i = 0;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> +		return -EIO;
> +
> +	for (i = 0; i < closids_supported(); i++) {
> +		int num_dirty;
> +
> +		if (closid_allocated(i))
> +			continue;
> +
> +		num_dirty = closid_num_dirty_rmid[i];
> +		if (num_dirty == 0)
> +			return i;
> +
> +		if (cleanest_closid == ~0)
> +			cleanest_closid = i;
> +
> +		if (num_dirty < closid_num_dirty_rmid[cleanest_closid])
> +			cleanest_closid = i;
> +	}
> +
> +	if (cleanest_closid == ~0)
> +		return -ENOSPC;
> +
> +	return cleanest_closid;
> +}
> +
>  /*
>   * For MPAM the RMID value is not unique, and has to be considered with
>   * the CLOSID. The (CLOSID, RMID) pair is allocated on all domains, which
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index f6051a3e7262..0b9bd5f0f60d 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -137,13 +137,22 @@ static void closid_init(void)
>  
>  static int closid_alloc(void)
>  {
> -	u32 closid = ffs(closid_free_map);
> +	int cleanest_closid;
> +	u32 closid;
>  
>  	lockdep_assert_held(&rdtgroup_mutex);
>  
> -	if (closid == 0)
> -		return -ENOSPC;
> -	closid--;
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> +		cleanest_closid = resctrl_find_cleanest_closid();
> +		if (cleanest_closid < 0)
> +			return cleanest_closid;
> +		closid = cleanest_closid;
> +	} else {
> +		closid = ffs(closid_free_map);
> +		if (closid == 0)
> +			return -ENOSPC;
> +		closid--;
> +	}
>  	__clear_bit(closid, &closid_free_map);
>  
>  	return closid;
> @@ -163,7 +172,7 @@ void closid_free(int closid)
>   * Return: true if @closid is currently associated with a resource group,
>   * false if @closid is free
>   */
> -static bool closid_allocated(unsigned int closid)
> +bool closid_allocated(unsigned int closid)
>  {
>  	lockdep_assert_held(&rdtgroup_mutex);
>  

-- 
Thanks
Babu Moger
