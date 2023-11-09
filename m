Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B1A7E731D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345242AbjKIUwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjKIUwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:52:04 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F19A449E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:52:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cA9UsOypjGS1alc1Pmw0vfpnoPG+H9GdEMi/PalfGqBNbYmI0UTVxQgDpLas8gEzc9Z8Ij5QdEUAu+HvlssiDxf5zLwxQwcPTh776z4dk2hWL4uNhhpnJXwbDNhYUu5ctDcP6YJT7XhaFcBq2stFFdiVFHKPS1DeZXBfX+xp21JwoxIwwyGOjGp5o9qbhayTqJ/NGQv1qoHJzomw13Kh7xHjqM+T15Trs2KdbpgwsU4+FyqCuynv25sALdt9bjkAjuSPzk2gz9CtjWq0/sZwtzK+I13XZG5uwbBOwqHA8Z3n3K8Jsqn+1nstcPaPLGxa6LyGHtFLM+O9sb6GiDnutQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4CjQd2rvdVFM9yXV5+CrPvavmpCFU97rOl14rrkQNo=;
 b=N4KKqbi39ay5Kjv1LpgIYiuE5roMVRMvhf0PV6gBLxNSWV4ZBP6KakzK67TifrkAceh+gUJJkKDuoTcWsCnnT/jEoRrXfwRKchAcHIO2vZUikKXWuxlkFOkdVLxcu8vhS3AsqRIk0+sBHGxnH213jTtH71TcPk42N0kvGjBiWZjZAaH4VWiqgVS3i72esPBsc2u5MwGjbDgP0ptT2p2hmt/9QPsPej6NsueIAVUzmGBVNO7CxNpg6rGV7uk9AZ0vs5i/NO3oVcH+m/wyp8y+pm8U4pglF2A7QfINat1c+1ljwrLievqbPwry+xh1yssxGerXMBHR4mBx/ZvAdWHfTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4CjQd2rvdVFM9yXV5+CrPvavmpCFU97rOl14rrkQNo=;
 b=o26OPexb6/cf1dNYeToaniKnvBcGaaBXYjYAmV/yqV/hwr0MFbcYsHS/8f8MSeWFcYbEgnOwFzeRADBzHp2Yy457bpQYu8cafQF1npVxOkdgpQkqmIIw03EBpeWtrCnflmehS44KVRcnOiw6t+WydO0Xxv87IDv0DPmAV1nAeJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 20:51:59 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 20:51:59 +0000
Message-ID: <6f90a9c6-d474-4173-9f74-a51675b10e6f@amd.com>
Date:   Thu, 9 Nov 2023 14:51:57 -0600
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v7 21/24] x86/resctrl: Allow overflow/limbo handlers to be
 scheduled on any-but cpu
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
 <20231025180345.28061-22-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231025180345.28061-22-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0090.namprd12.prod.outlook.com
 (2603:10b6:802:21::25) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c64e751-aa81-458f-5d50-08dbe165b7b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 37PoEzxbbPnmQOkNpNsgsTjE7w0VvH6txdii5xZENBnW7LVTWqkUqRUBLJt5NNgozI8eAZPooocDmIeYQpxGPg6bbpCXHdKvDgvmBi/3KeNQrxl1hIk4p5xrxjZKvlMu5cxJCEzym0dTFSdvRtUMj7kRVAIut62B9TIMMa9KbjxgRLcIZdVeOgMwMov0OejYjhJiZ+gZMGcYz4FK6g6qvuKaiBxu7M9nKQXVz7AfdUNSv6p0hcZbHe7Uz5LYA22CRDFgHCZjiGpWIbACaMATPXW8UtuLYrRg3NrgNvCkLeodaFgnNv1OWkpkXVD1rJrD3mKo/mMbePFgZvaGENka/xx3BKRsvm4iiSwy2yg4K0pSf5xBe9ZpfZFDsVXlVcyzcfYrJyGAfxnaCLsCKxR0P/Q3FafhNfWD8mdCBBWkIRAwFHBr6aqrIlqd+kP7zcyNCXkYAjVszia518TXRcjQzd1+jb6QyqrgMBSQBOh8m9xh6TV2RH+Wqug7KxfF9iwikvTBWhMNnWboZgZh1bCqSS9qu1VYv8ukpmVKKhPrueS8g/I9EMPgPqhvCjWEAEsErDeByf92QiGs7Ho0r0OXhQPjGm6sSHmJUIRgKsNzLHTIEbWlThOkqPLN+bZxyk8S3b8FOm9RX6hFX+kHJE7TRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66556008)(66476007)(54906003)(66946007)(53546011)(31696002)(26005)(36756003)(2616005)(6512007)(316002)(38100700002)(83380400001)(6506007)(86362001)(6486002)(478600001)(4326008)(2906002)(8676002)(8936002)(30864003)(41300700001)(5660300002)(7416002)(3450700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3ZFalJDR3AyQlZ2WU9ScnhrTmdhdVEzSVJkdVVMdysyeExnVm9rZzI2NEVo?=
 =?utf-8?B?QkRBVXovT0tvakxuQUFocUNiVnNNRWZDTm11MGlzZjRmM2RFRERCQkFsd1lX?=
 =?utf-8?B?QlYwMExkMEFBMVdNQmNRaDhEb3ZYc2N0UldSbUhDa3hnbG5xWHJadzdjS2lo?=
 =?utf-8?B?czhrQm40eVd6WTV1cjB0R2ZkOGdrVTl5TTB5ZmpsRU1nTE10WEovb3Y5V2w4?=
 =?utf-8?B?dVhtVk1JT0pmdmc3YXdnYndFTG51citlZm1wNFpFZmRpNVJCQlA1NVNRR25C?=
 =?utf-8?B?WE1hLzN5MzJZaGpVMkRGNUREN3prR0QvaEwzSnpHSnpkbVlQdGpSTVU0MUtw?=
 =?utf-8?B?OGhScytxZHBvR1VmNXhtR2RYd0ZWWERjRXhQaTU5OVV3c3JKSmRUelZRVita?=
 =?utf-8?B?cUZzaFRIZ3Vnd21aQnRGQkdtMExZRXZlSUVOampQTWlBZHVydCtoWnVFaFMw?=
 =?utf-8?B?OWZtbHkvOTEwYVdtc3VzeEdtbTRWNGVXZ0Q5LzlFSEg4R2V1WEZDZFQ2R0wz?=
 =?utf-8?B?RFpNMC9MNkRzMExhMkovUUNLSmlKaFdrd3FvOUZKMkpLSS9nODJuLzhvbkVo?=
 =?utf-8?B?NnU1QUI4MHc2YTVSaDVjN3FjU2IxOUVHZ1poSTNiWFN3RGFlRzZMOFdnQ2ti?=
 =?utf-8?B?MlhwbHhFalVoQ3FOOXZQeGhoVElhTVRMOEZjN0QzQ0xoaEdGelluK3NGdHNp?=
 =?utf-8?B?REZwZHlndnZxMktseDR6WTVSYXZTZVUyc0VNVjlUZnZKcWNRTHkvNkk3NTdZ?=
 =?utf-8?B?bHE5VUpaNUxhbEprekJJd2JjV0cwdytOcTFySy9GL2J0NHh4aGRnL0YwRStY?=
 =?utf-8?B?eDRDcm41WVBHSlR6SjY2dW1xZjE2bFY4YWFHY3N4STBjQkcwb3QwY21Od3lG?=
 =?utf-8?B?NmdHMnpCQ2JDOEluOHhud0x1T2wvalBkTTFQNVgrZXF5UFE2d25nTG1mVlRw?=
 =?utf-8?B?ZzNlQkxJK0xUb1BYN2Y0V1Q3elhLalJOaE1YZ1pWWExWVFdTakFyRnAydmdK?=
 =?utf-8?B?dUdUM1o5RUEwYnljWk95SlN0NzVSeTg4NWV2VzFjaWtuUUR2SG9MNlhMY2R4?=
 =?utf-8?B?QmFPVHpqdUpWSTFLdVl1Vm5EdlJYMk5hUGFWbXh6WE9samJ0aFdHNDZ1K3Yv?=
 =?utf-8?B?K3oyL2ovTUp2UzdHYmlJMzBIaGpDa2VoakxTYXNaaW1Iby9sNE10L1l1M3BV?=
 =?utf-8?B?UFl1eFFLajdFcUNHQlFFYzhEWXNxSWhuS0c0aEdUUGx5VkJRNnpCQ0dxT25x?=
 =?utf-8?B?aDFxeHlCK1RucTVvZ0MyOFladTRQS3ZVbDR6ejU0blRxT3BhT2MvN1VYTEN4?=
 =?utf-8?B?ZXRCc3ByRlBKdXhtUENPbDJkcjZld2dXN1UvNVlWWThzRWt0YUlCSDJybU1q?=
 =?utf-8?B?MzYySlZEYWNPQUZsUkoxVHY1UklCSFpxTTBnZE1xSEpQemFjTjJEamVPUC9m?=
 =?utf-8?B?K1J1K1YrSHR3ZVM1OXBDRGZ1TUphTStMdHd5OXE4dnNadTJ6dFgvb2FQTzVM?=
 =?utf-8?B?czBpVlE3SWN1QzNTL21EUkc0blRPemVUSVI3NytteTJlZ2pDV2hQUVNGOVh0?=
 =?utf-8?B?UGdCQVltbCs3aXBhT0h3MzQwelJzY1ErVHVkNEF0bmdUN0Vjc3pDS3NXa3E5?=
 =?utf-8?B?VDc0dmVpUWFaR0JwODFHREpBL04xZ0pQWkthRHdkcjNXSnptNXFJbStJQk1D?=
 =?utf-8?B?YjRTTlR3Z25lQ2NUNEdQSVBMSit4ZDcwOW5RRVhFYW9nTjJjYUIvTUZvVHht?=
 =?utf-8?B?THN6alZiZnNzUFhxOEt2dGFBVGpMQllVNitzR2Uza2ZsT3RHSmg2ZEdHWUdi?=
 =?utf-8?B?VDJsZUFsZjJiaEduSm85aEh4dlZHbnpSQ0VGQVZlb3RDdVBhaVNlcUhuNXZL?=
 =?utf-8?B?d3hoVG9xdGtOZXJQNVlFb2xIOGJ6SU1pTVp3ajA5U0hmWW4vSGZiZ2s5S0h4?=
 =?utf-8?B?UEV1UEVJOEgyVE51RDNvaWNPM043OG9OZFRtVE8xRTVaekcvWDloSFNIY0F0?=
 =?utf-8?B?cURvOWtVYm80cVZwcjVoKzdzVERpcTJXQ1NKZUgwY3o2WUJYOVR2cEN3dzhO?=
 =?utf-8?B?N1JqNEU3bzV3OXFheElkWERnUDZteEgrLzNHWTlvWkRoYVhuL1NyNUh2MXhr?=
 =?utf-8?Q?P5gM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c64e751-aa81-458f-5d50-08dbe165b7b2
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:51:59.4264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LmJLAryzLP1scQac9FJ5pOQRi0ULx1wXwFuYGLjp55Ubj34/ZRMYPYLUTI53VV58
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/23 13:03, James Morse wrote:
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
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>

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
> 
> Changes since v5:
>  * Changes in captialisation, and a typo.
>  * Merged cpumask helpers.
> 
> Changes since v6:
>  * Added the missing dom parameter to some kernel doc.
>  * Re-added use of cpumask_any_but(),
>  * Expanded comment above cpumask_any_housekeeping(),
>  * Added some more comments for good measure.
>  * Added explicit IS_ENABLED() check as gcc-12 doesn't seem to work this out.
> ---
>  arch/x86/kernel/cpu/resctrl/core.c        |  8 +++--
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
>  arch/x86/kernel/cpu/resctrl/internal.h    | 33 ++++++++++++++----
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 42 ++++++++++++++++++-----
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  6 ++--
>  include/linux/resctrl.h                   |  2 ++
>  6 files changed, 72 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 1a74e9c47416..7e44f2c40897 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -586,12 +586,16 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
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
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index a033e8e32108..64db51455df3 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -552,7 +552,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  		return;
>  	}
>  
> -	cpu = cpumask_any_housekeeping(&d->cpu_mask);
> +	cpu = cpumask_any_housekeeping(&d->cpu_mask, RESCTRL_PICK_ANY_CPU);
>  
>  	/*
>  	 * cpumask_any_housekeeping() prefers housekeeping CPUs, but
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index c4c1e1909058..f5fff2f0d866 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -61,19 +61,36 @@
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
> + *
> + * When a CPU is excluded, returns >= nr_cpu_ids if no CPUs are available.
>   */
> -static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
> +static inline unsigned int
> +cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
>  {
>  	unsigned int cpu, hk_cpu;
>  
> -	cpu = cpumask_any(mask);
> -	if (!tick_nohz_full_cpu(cpu))
> +	if (exclude_cpu == RESCTRL_PICK_ANY_CPU)
> +		cpu = cpumask_any(mask);
> +	else
> +		cpu = cpumask_any_but(mask, exclude_cpu);
> +
> +	if (!IS_ENABLED(CONFIG_NO_HZ_FULL))
> +		return cpu;
> +
> +	/* If the CPU picked isn't marked nohz_full, we're done */
> +	if (cpu <= nr_cpu_ids && !tick_nohz_full_cpu(cpu))
>  		return cpu;
>  
> +	/* Try to find a CPU that isn't nohz_full to use in preference */
>  	hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
> +	if (hk_cpu == exclude_cpu)
> +		hk_cpu = cpumask_nth_andnot(1, mask, tick_nohz_full_mask);
> +
>  	if (hk_cpu < nr_cpu_ids)
>  		cpu = hk_cpu;
>  
> @@ -575,11 +592,13 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
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
> index 87379d2a339c..241b3dd8646c 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -481,7 +481,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  		 * setup up the limbo worker.
>  		 */
>  		if (!has_busy_rmid(d))
> -			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL);
> +			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL,
> +						RESCTRL_PICK_ANY_CPU);
>  		set_bit(idx, d->rmid_busy_llc);
>  		entry->busy++;
>  	}
> @@ -808,7 +809,8 @@ void cqm_handle_limbo(struct work_struct *work)
>  	__check_limbo(d, false);
>  
>  	if (has_busy_rmid(d)) {
> -		d->cqm_work_cpu = cpumask_any_housekeeping(&d->cpu_mask);
> +		d->cqm_work_cpu = cpumask_any_housekeeping(&d->cpu_mask,
> +							   RESCTRL_PICK_ANY_CPU);
>  		schedule_delayed_work_on(d->cqm_work_cpu, &d->cqm_limbo,
>  					 delay);
>  	}
> @@ -816,15 +818,25 @@ void cqm_handle_limbo(struct work_struct *work)
>  	mutex_unlock(&rdtgroup_mutex);
>  }
>  
> -void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
> +/**
> + * cqm_setup_limbo_handler() - Schedule the limbo handler to run for this
> + *                             domain.
> + * @dom:           The domain the limbo handler should run for.
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
> +	cpu = cpumask_any_housekeeping(&dom->cpu_mask, exclude_cpu);
>  	dom->cqm_work_cpu = cpu;
>  
> -	schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
> +	if (cpu < nr_cpu_ids)
> +		schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
>  }
>  
>  void mbm_handle_overflow(struct work_struct *work)
> @@ -862,14 +874,24 @@ void mbm_handle_overflow(struct work_struct *work)
>  	 * Re-check for housekeeping CPUs. This allows the overflow handler to
>  	 * move off a nohz_full CPU quickly.
>  	 */
> -	d->mbm_work_cpu = cpumask_any_housekeeping(&d->cpu_mask);
> +	d->mbm_work_cpu = cpumask_any_housekeeping(&d->cpu_mask,
> +						   RESCTRL_PICK_ANY_CPU);
>  	schedule_delayed_work_on(d->mbm_work_cpu, &d->mbm_over, delay);
>  
>  out_unlock:
>  	mutex_unlock(&rdtgroup_mutex);
>  }
>  
> -void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
> +/**
> + * mbm_setup_overflow_handler() - Schedule the overflow handler to run for this
> + *                                domain.
> + * @dom:           The domain the overflow handler should run for.
> + * @delay_ms:      How far in the future the handler should run.
> + * @exclude_cpu:   Which CPU the handler should not run on,
> + *		   RESCTRL_PICK_ANY_CPU to pick any CPU.
> + */
> +void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms,
> +				int exclude_cpu)
>  {
>  	unsigned long delay = msecs_to_jiffies(delay_ms);
>  	int cpu;
> @@ -880,9 +902,11 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
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
> index ab9db7ce706f..e22e0f6adeb3 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2683,7 +2683,8 @@ static int rdt_get_tree(struct fs_context *fc)
>  	if (is_mbm_enabled()) {
>  		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>  		list_for_each_entry(dom, &r->domains, list)
> -			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
> +			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
> +						   RESCTRL_PICK_ANY_CPU);
>  	}
>  
>  	goto out;
> @@ -3994,7 +3995,8 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
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
> index 4c4bad3c34e4..ccbbbe5d18d3 100644
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

-- 
Thanks
Babu Moger
