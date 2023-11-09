Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EE17E731F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjKIUw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345241AbjKIUw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:52:26 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F23F44BD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:52:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWAGZ9vQQcNnEDGD/YPe6Y/xcVfF08jiWsRPpvQt3Kp2BpML+mTaqGt7SRpedTbZfdaa8bwTXbAyoalgNZ7YJgG+gXBTaQAm2vFwaZ6wTCaE8QM/BEb5eBCi+DEBqV1DrxmR0bKiilWkbkLYFBRH+9ar+DMitYIgDTAAhMtsxakoStYashDDNoRVRvXEBJgKFvcIouPVW3gMIDcnnC4KM78DtBNwFWARPkY7AxAXgphKzXol+UBaV3b5NTxLrouOJ6GDJIiEVSCJK4SeYbdnbdrW9EkfBn9K7JQ9bRi2mhc0221lVhJjk7PSywIXFZaNM0kngR2j6vXhkwj0GQvyTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4qa2LjN4MtelGJIexBSW+PDoauJKWTDdXBGCp/WTFs=;
 b=U2AxRi2lO+si98NjKa0Pv0PMKeld42ZNBhvSAGhiKaBBg3joAtdviv1E/3JsbKPISmTbtPrvvrJLNByk7deO8IJAULhC9j4yGSftH3yv/5MucV13eK6Brz3pb4fXHpWcAF1dbyj7v5RQYukI4dSp3fysb1I+OBLSanUUA4kik2hvSaR+QtqyUK+htmJ0GWQk4xTPUs+nmYJuxBhFatNIWfmeictxDnbko0T8jKTo+7Jb6pSXUoJgMzalDghJII3R5HvQo1//9MwJAcRJc4AI+WWAxX0hAuk336alfFP71PpV+AOxIh7JYXXjXWzM4Iag/qaSuejif/o8bHeXDawAlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4qa2LjN4MtelGJIexBSW+PDoauJKWTDdXBGCp/WTFs=;
 b=qvB4TgMBKbCCVeLryDBE06OFj54UuAL0X6DdozuI08daIPzBuoz4199r4+jRtldkoIvTjeMckKHjnmSR1HThG8XW62srW1e7xEn9hjzmSMhpWYa3UlNuXR/Jz9qiw3nJCFNkMrUd1TL7Yi5bdhT7/u2pAb4lU+0ek3gjbOk/pAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 20:52:17 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 20:52:17 +0000
Message-ID: <7b962474-fea4-4947-8241-b46aa3b09bf2@amd.com>
Date:   Thu, 9 Nov 2023 14:52:15 -0600
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v7 23/24] x86/resctrl: Move domain helper migration into
 resctrl_offline_cpu()
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
 <20231025180345.28061-24-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231025180345.28061-24-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0090.namprd12.prod.outlook.com
 (2603:10b6:802:21::25) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f35d9e-88d2-4890-9850-08dbe165c22c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WbuxeiP6fM7bZXVWeiBgQyEAnxxtnov0dnHpZ/VQzajlVx9SjZXTlBLIMRAx1aW4u6CZufkWpmWpfDmqQhb9mylro7dggr8kyEiHgPha2kwwurvtVoarwQy6g86acE8DdwKZsjwFilwfBkr2rxZizKM2iMVvQsh8Z1OsgVrImyrTb2Bife4x9jHJNunFdi/rcjSp80l6r7xRd25zKwJpbddNhWmglxiREkUrqivPCqKJFrogZq5ytKyQjG4ZsB32cgjP+MQrOUu9ekd2iRJ6qXTRVJYSBcoTH+n/MVxOhwKZZOZJSeppgWhd3P7d9AdxKrEKdJqXN4uCTSFPUjWfJYXJE4MS2tw4pLMA5lJlyvATl+i9v6euAuaqI/8ZYLWUx+nClVND95/bIz3X2lSBPBjsnZYSTLiGzzmXYArMLoOwFO/iuW6PmkNqIz2z4iNfIHZwdRduDlN6vAEzBRt0fv2gO97KuvCupD8WSG2hDY29J5g60hVp37KlBE2FG5RNLRJwWkRn6D0GyaJmpcqcS2xir6PVJ7+/sj5hxmlmrutQLjWa3yQ30Mz0Ml57N6NAy/rRShU36eelL6rQ6RwYMlPRUWOua3xrRP9AC7Fw7YnEm75m3HVNHPTDeGCfybX1a2eSGcko00l6UtPivdhPuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66556008)(66476007)(54906003)(66946007)(53546011)(31696002)(26005)(36756003)(2616005)(6512007)(316002)(38100700002)(83380400001)(6506007)(86362001)(6486002)(478600001)(4326008)(2906002)(8676002)(8936002)(41300700001)(5660300002)(7416002)(3450700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVppOEM1TE9IYnVydjNrQk5ibzBCc1ZXam9EK2gwQXZtZzN2TS9GVk5KZEZz?=
 =?utf-8?B?b09GcFh1Wkp3V2ZpL25yOVRCbHdvQ0Z2VHhQUmJ3V2xpYnBXcmY5TDR6OHEv?=
 =?utf-8?B?Z2N0SjZqK2FTREQ3RDdDWm1Gd01ZVUJFdTRHWTYxbGt3ZTdaMDdydjFZTTVX?=
 =?utf-8?B?TU5OSXJlMUZiTVA4KzFTTE91RnE0bFozTmpZeEhOQ2xnakZHTlcwVnBqT3Uz?=
 =?utf-8?B?WGV6c2NpSWtEUW9Qb2JXQjZxU2RsM0V2SnByS2tvYnNUNGFnaWxQeWxhbVky?=
 =?utf-8?B?M0crUUE4OVltN3R4WXBsbUo3UU5zUkVMRUQ3NG04TWJLSWpRcGxiaVJGT0pD?=
 =?utf-8?B?aXpwcWJxZzM2TjM2RU9KTGdscjlJVHVHVUtQd01ERHN3ZmRhbFlrNXNWOXg1?=
 =?utf-8?B?OVFJOUVoWDFSVVg3Rkpsa2Noam9vbXJQdHg3aHZWWkd6WUg0QkxnNWRURWVJ?=
 =?utf-8?B?WFc4NkFxcGVTNzN3UjBPc1ljMTROSTFleVZ2dHdTcE92M1RpbWE0d1hnazhz?=
 =?utf-8?B?M0lrdWtDdi9ZMkFqSTZhbXlLZXRVcFN0c3lKWXljc2hCR0VoKzkrRE1mSW50?=
 =?utf-8?B?bFBkM2pqQ1ZyMk1GdXJuTi80SUhoM2pwNTRyKy9YNVk5Ti8wWmh3cUx4UFVQ?=
 =?utf-8?B?Mm1JdGRmSUZvOGNrbmd5QnJmVkFCbW9aV1BNdEpJM0lvdmpOdUdJVSt3N2Qz?=
 =?utf-8?B?SW9td2lSVmw3NWg3azd4aTd6Nk85djJMNldSeFFvaGU3b1dHSUZJdDAvOElp?=
 =?utf-8?B?M3QzZGIwQTlXNU5HNjA3NG40eEYvQkZjVENRYzM0eXI4b1U1eUdUVmE4VWNS?=
 =?utf-8?B?RWkzT01ISFB3Y1N2MkRRV2dWcDBoWnY5bitLZnN0L3JIVGpqVmpTeWdBQnVU?=
 =?utf-8?B?Mk5kT0NCaUNiMFVZK2FiUzI5YVI5Zi9qT0Myc0FzbG1xZU9XY3RvcjUwS2dp?=
 =?utf-8?B?L1o3bkg5QmMwelZvQlFQbGxnRU5qd3l1cXlkclBPbzYySSsrNGdVSXU1bWUr?=
 =?utf-8?B?akpyZ3BFZjYxN1RoU3lNaTRab0RTUEkyaU5halI4dTNRN3FKS0tUNElPYldM?=
 =?utf-8?B?Vm5FVmJ2WHFVYi8yN1pRQlpRcjAzenppdVBMalI1MXJpL3BRNWR0SXRPengy?=
 =?utf-8?B?N1dPamJTT1FHVmZmaDhzSXJaa3BmNWtTdjlCVGlqZjFrVTRubU1pYTNQQ201?=
 =?utf-8?B?VHlXWE8wQ2dSZ003NVNzeG84S3gvTC9aelpBOE1veEg2ZUFOaHNhc3dKNmI1?=
 =?utf-8?B?N3dQUmwvdDdsNDRNOFpVR1JSYVFUbjZ1NHJ3azMvRVk0SGNwWXdPUUdscjJY?=
 =?utf-8?B?UGgzZ2g4RWhmeTFreVlxbzRTQUgxQVltdWNKNzBZUFpJU0Z3VmpBN1JGOEhB?=
 =?utf-8?B?TlNiZkwvVm5tMnJvTytJVlAyd3l4TEVpNEp6STQ1R1EzUUp1VUd0Y29ubmh3?=
 =?utf-8?B?dVlQdzAwR3NJdTZJcjFIeG5wNFlsK0tZcWdVamxoWVREK2dKSGVjcFFybjdJ?=
 =?utf-8?B?b3gxZDVUZEY1cnhtMityV0Z1NWx6a01COCtjSzViZ3pQMEdCNktYWU81anVa?=
 =?utf-8?B?RUZhd3A5aVhQY0o2b3lqZ3dTV1dMbm9hdWFmM3Z0NkNOTjl3WmR1cXJpeTg2?=
 =?utf-8?B?VWRLUmtEWWR1Z0RsRjRaSEJHbE5wSGlPMzJTdGdiS2pMUlUrVEpYZ05vWTJZ?=
 =?utf-8?B?RURJbmFmRDQySDVvM0poQnl5N0pQVHdxK2tmeWtFTGZxT00zbzZETDFtQk5z?=
 =?utf-8?B?dlI3K0pld2dVSU05R0UvT05DdHFWcVJTdC9USjMzalhrM2R2VitIZXR3MUZN?=
 =?utf-8?B?cXhaWjE1azhtZzArampYSGIrRjJndnJ3dEpLVmx5WWswMTg2SE9nMEh1TkVw?=
 =?utf-8?B?OXJUOXFpN1djVVJPdzhNa3ltRzFuN0tMSUtyR25jeUE2SHhoZHVQWDdGejN0?=
 =?utf-8?B?RVA4c1dmSzU0bTRXbVB2K3N6YXNwKzd3N01hWG5kUTdPTHpVaUo0Zk4wUjRR?=
 =?utf-8?B?TWgvZU8zL1B5OE9vb1lENW5XREVNM1ZESWZVNWhGQ1Y4WSt5UFBXdGtsbWZD?=
 =?utf-8?B?TGhjK3F5NlBzNm5iVHFCMUhjZE9tSnN4UkN1NVR0NWx4c3JwRy9RM3E3dDJ0?=
 =?utf-8?Q?gItM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f35d9e-88d2-4890-9850-08dbe165c22c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:52:16.9865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHmFX3t/ulW8S7UqiLlBT0+xqr8br9OvcQBYu4XI3UyKjxFRb+W0WdmqW+Je/OhS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/23 13:03, James Morse wrote:
> When a CPU is taken offline the resctrl filesystem code needs to check
> if it was the CPU nominated to perform the periodic overflow and limbo
> work. If so, another CPU needs to be chosen to do this work.
> 
> This is currently done in core.c, mixed in with the code that removes
> the CPU from the domain's mask, and potentially free()s the domain.
> 
> Move the migration of the overflow and limbo helpers into the filesystem
> code, into resctrl_offline_cpu(). As resctrl_offline_cpu() runs before
> the architecture code has removed the CPU from the domain mask, the
> callers need to be told which CPU is being removed, to avoid picking
> it as the new CPU. This uses the exclude_cpu feature previously
> added.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>

> ---
> Changes since v5:
>  * Changed fir tree order of variables.
>  * Added mon-capable check for cpu offline.
> 
> No changes since v6
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     | 16 ----------------
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++++++++
>  2 files changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 7d09b8d7c653..a90a07a5c876 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -582,22 +582,6 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  
>  		return;
>  	}
> -
> -	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
> -		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
> -			cancel_delayed_work(&d->mbm_over);
> -			/*
> -			 * temporary: exclude_cpu=-1 as this CPU has already
> -			 * been removed by cpumask_clear_cpu()d
> -			 */
> -			mbm_setup_overflow_handler(d, 0, RESCTRL_PICK_ANY_CPU);
> -		}
> -		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
> -		    has_busy_rmid(d)) {
> -			cancel_delayed_work(&d->cqm_limbo);
> -			cqm_setup_limbo_handler(d, 0, RESCTRL_PICK_ANY_CPU);
> -		}
> -	}
>  }
>  
>  static void clear_closid_rmid(int cpu)
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 971a8397e243..d38b2fe6e3ca 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -4034,7 +4034,9 @@ static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
>  
>  void resctrl_offline_cpu(unsigned int cpu)
>  {
> +	struct rdt_resource *l3 = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>  	struct rdtgroup *rdtgrp;
> +	struct rdt_domain *d;
>  
>  	lockdep_assert_held(&rdtgroup_mutex);
>  
> @@ -4044,6 +4046,22 @@ void resctrl_offline_cpu(unsigned int cpu)
>  			break;
>  		}
>  	}
> +
> +	if (!l3->mon_capable)
> +		return;
> +
> +	d = get_domain_from_cpu(cpu, l3);
> +	if (d) {
> +		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
> +			cancel_delayed_work(&d->mbm_over);
> +			mbm_setup_overflow_handler(d, 0, cpu);
> +		}
> +		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
> +		    has_busy_rmid(d)) {
> +			cancel_delayed_work(&d->cqm_limbo);
> +			cqm_setup_limbo_handler(d, 0, cpu);
> +		}
> +	}
>  }
>  
>  /*

-- 
Thanks
Babu Moger
