Return-Path: <linux-kernel+bounces-15924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA128235BD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5E71C242DF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614BB1D555;
	Wed,  3 Jan 2024 19:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="baeYSrCJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158411D54D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=br1i40Og6Tp5+0IahbgdBi8BpM7pnCxg1NWlaSiDHt0Y1vOXqw3Ojn2xzyIWQIe9HOtmmH0b7kLPw5nYE6mr6yzoxKSjy9wLEc7GpyBhwMuYZHhaG8KS5SYI2ILAqCFuiX2KMTdbxiEg1f0QDfd7IdLl1m4xJjFXere3qBCmf1go1/5Tl+lyJpG6bzfly19UKtmOlH38WxFmNPBZO9Cc9yVBK8SNzs+bh0GFiJqZP8+Q+Mvl/3bBMK3x1gfjBG5AdELKL3vOUm0M4sYFhFDCHAOLv8RvVcnWG7Ow+IOgePGI6WLGOb3tbHNiabPN3lCchJvbsYqyqEULyaXLQ1fL8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wx9V1Na8a9AQ/uzhKpibm8d/6oDHJtw84wqEj27tbmU=;
 b=QasZhsJTfDSwgp+4MfjSCijuxPqW/ObWllfM1Rtti33Efx6I0ASwAymZ4nHK6Rmn8bRKl3FWYpTt9T8MIQxWyn933jOEITpSjeH7l2f1+ZLlreC7cDWe8Bd2XlMaaDVflcWx5W4yyCNHw0KCkwpPCwC0x79kusM6/sAXIhryDcu0YA2ZzNYbOjxm0YlrWLoOPR0WjXm+jI6WmJKCi9rUz2fSSKr00moaxuKPw6wXbGXLCJhLmPk9CRfoBP3otKXRoc6CMwN+3ir/GvWzS15k6mabI4lrfpI2Jm8YBOiUfMHxq1XimOPBpboEVFzb8g+fqM5Wh8cdxiHmdq1C07Ugiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wx9V1Na8a9AQ/uzhKpibm8d/6oDHJtw84wqEj27tbmU=;
 b=baeYSrCJ7AMMECtOdzz2+HB6BLDJENrE5IHzQ3vYkrW7eTT7JSKV6taR2L+m4EMeTrn6gUe9o4IK8tvq44724FafMtWLb1HzzY7+daLSRoN+FZvnGFDO+z2lwlWjshHdgZcRpFDBgVofhxQ3axmn4+DnyfhbnMaCC7eirK0qOXs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 19:43:04 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7135.026; Wed, 3 Jan 2024
 19:43:03 +0000
Message-ID: <286216a9-d586-42dc-9f1a-8909364bd7bd@amd.com>
Date: Wed, 3 Jan 2024 13:43:01 -0600
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v8 08/24] x86/resctrl: Track the number of dirty RMID a
 CLOSID has
Reply-To: babu.moger@amd.com
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com
References: <20231215174343.13872-1-james.morse@arm.com>
 <20231215174343.13872-9-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231215174343.13872-9-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0078.namprd12.prod.outlook.com
 (2603:10b6:802:20::49) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cdef16f-007d-42e0-c1e7-08dc0c94335f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hp8ATpBKwJmzC8g66nvMmXKmFJH9SZu3Heigp2rbLQEMu48e+/5Gdd0dqX3/PBAuk2AMW+tRSMRHeaJGmTDyVLJGzPEosy+MeNZNDtpBzvCQp7NJjJS5Md0G2BW4b4ro5HxWotFQRYGe/BFKHfrubB9L9/TLrMDMGHB3W46B9N5yB7iRtouWiPqSuh/waUFhybzSIAfhYjV6nrF5E2D7WgJEex3gsXwYcwDzeftoXvRTl1qp4v+7G1yV4GRA70+M3c7tVJn0d1PYezkSsYsR3r94NdpkGkWvN2CaNHtwORoseEs0Q/PVd3wGuKD2z1gvuA12H25/wA/d7iEKUUVJWlh9gySTrLqZ94AsWKNHj7DEeKUJ9MYbu2SKxpoxaHbjjyXAqCViADX62Bb0p8wvcdlpnfGvnHUkDmyB3hlivH4PnMB4xzxS/Js8vLyRFCiuaMj1p3n9L9E9tTLb7Pvg8Av8Np/2JdkKtQ8VVf7ru3V/2uoo1Y3bOAfftN4I4xryjH7JDtdR+094Ss9Ezz0jedilDtXbDiD7tKr/MjOXNmyyqSgeNn/9VJk/EgKYyYiMrCjHWvVO+5XxcIypS/sLkot1eXLE3aj3phczPoIRdmvuEwDvt7ouWURTDNtMqDPhQIR639mvxhOgTAox0jQHN0jnWWj845kKJVzZgryD3E8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(4326008)(66476007)(66946007)(66556008)(6486002)(8676002)(54906003)(478600001)(316002)(8936002)(83380400001)(6506007)(53546011)(6512007)(26005)(2616005)(7416002)(3450700001)(5660300002)(2906002)(41300700001)(36756003)(38100700002)(86362001)(31696002)(31686004)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnJhMElndlVsd2VWem5iUCtBNHY1UGw0bXQvcVFUVXNKQ3dIeithRllTZy81?=
 =?utf-8?B?eTlwR3pZYUU5Si9Yc2NwK2pPWlUweFJiR29EM1NZUnY0SzdJODd4MTFYeklh?=
 =?utf-8?B?cGtZOTg3RkdCVTlLN2hWVUNvcFBrUUY2eXBRUHB0aUZqaFRHdUN4VW4xWkUz?=
 =?utf-8?B?NW9DczRTRFFuOFIzeWwxNEc2RTBUcTR2Wld4MDZzWUN5RmZWV2RJYXBQR2M2?=
 =?utf-8?B?aWcydTJSUU9Wak1WaXdNa1lkL0c2SGRWWHJMcVV1WTZLcGpORVZtQm5GOVY4?=
 =?utf-8?B?TzN6WjArekw5cyszenA1TEJ3bDVOUFhBOFNBdEVLRlZmeEZJTTJmME43YjVt?=
 =?utf-8?B?NHNQa21OU0wzM1ZQV0t0cXloaVpQNk15Qm44dEhhd2trRUtZYnZmK3ZMZDI0?=
 =?utf-8?B?QWhJRWdGNnBZVWlISjJTc1Y4MjJQQ0dPcVp2d1V5TUZBZ0lKdHZWd3dEUkRE?=
 =?utf-8?B?Wk5EYzBLUUJ3bnVlcFFGdHV2cU0vZDNnQk8wejg3Q01TVUN5SEJvZklubGhw?=
 =?utf-8?B?RmtxRkRYY3dyemppQitxcmdOODhuakViOXJUdnBRVG95ckJBc2pyUkRqaEo1?=
 =?utf-8?B?N3YzMm5LSkpFaVllRnRXRy9uSFpOMkx2dEYzYlpVQlhwSWtCcFRESWphclpn?=
 =?utf-8?B?cXhPVERkYWpqZWhhRyszZVhCaUhFNnhnelhuaW9tSWhtTXlnYWZTL3hEbzRT?=
 =?utf-8?B?VEtab29SZ3VCS0lHdjB1Q1lab2libnB1aVg1Nm9xTUpiRjVmeDJiVzgwVmJH?=
 =?utf-8?B?b2pDSUpKY3Eyb2xoUCtDOWtvQ1FibDM3VjVSMGw1RnY3UjhwNDRSYVo1ejFa?=
 =?utf-8?B?SDZHRGZXOFFNak12aFhmb0FZNjhFU3RuTjNxZVA4ZTZNYnlzcU1UL01uU3hH?=
 =?utf-8?B?OXQzTUU2ZWxWQ0ZNZk4vMGlaTDYyUEN2WSs1b3VUa2JZU242eEg5ZTRqR3h0?=
 =?utf-8?B?KzBST0hKVVdob0sva0k2d205ZVZ1bjc3d1pTaURaTG85bThpREJzUFhkRmtH?=
 =?utf-8?B?S04zd3B1bGJBVHBXTnFmMTlLeEJIcGVqTDQ4TnYxYkVJZFpYNFo3VlpnUklx?=
 =?utf-8?B?Ny9JWnlHbmg2VjhUY1VVemtkRzdKcG1lQzNQdWplN1BUL09HWFJUQnJoNnpD?=
 =?utf-8?B?d0l0b1RGeFAvZkZYbGZmOTdSNS85NWJacHlUSE9YSjU4YklMNzg0Wk1teFhL?=
 =?utf-8?B?VitTZ1QwSFV3cFpucWI1dUkxQkZ1SlVRRkNUMjVuMmxPQnEyQTdMSlovQmxC?=
 =?utf-8?B?cmdUNVBSNU1TQ2RvRk1lNmQ4b3N6a1hVUXczamJrRkovb3cvbXV4ZEZXZGF2?=
 =?utf-8?B?NFZwZDgvOFFycVEvYkFFSUI4eFhuSzAyMWg3dFhSRTlwTk1PL2tjeDk2NkVj?=
 =?utf-8?B?RzRRaUk2Rmd4eGJGanpQeEc3aVZjUElVQ1FuNUdmSTQyOS84cVNWOE8yZXVh?=
 =?utf-8?B?endTOTVySFF3akw0M3dQa3pjandxOTg1QnpjRVZtT2VycDVpUmFHMHRZRi9R?=
 =?utf-8?B?Ynd3aDNtMXk0TlRsQ3FONGN1RlNkNFNjay9OeW5qQXhzMUI2Vk1pTDRXSmhj?=
 =?utf-8?B?NlI4MDlPS3FVYnlObmtGc05wN1AwSERsQ1BuVzU5cWR5V3JzY3g5M2xUR0ZB?=
 =?utf-8?B?dENyREM0SjYrcnplQThESm4wN1A5UkxPdWhkVE0yRW9CbjNDVVJrT0JZRUFU?=
 =?utf-8?B?TFd2OG50eU4vR1I1bmd0alFsQ3d1blZGYW11cnRIeUtJWTNWK3NTNUY5SEVx?=
 =?utf-8?B?d2JMSVBtVXFaeFB2OCtaZkY5MTFhRThyL1VFNzJBYTVYM2JOMC93V3I5RXA2?=
 =?utf-8?B?NmJQYUwvb0tGRGdUZHlnT3BHd0k3Z1hrd2M3SjRxUm5IYklQYUhsSnBSRXlk?=
 =?utf-8?B?YmxrSFVkWUpFTFV6aHg5S0xlVTllcStCcmxUcTZCQXFPZ1YwczVxazlPTVdE?=
 =?utf-8?B?d2IvMStIZm95VmFXa2IrbTN6cEs4YW5qWUdmajFXZWg5NnBDSWJyWDZ0UnRD?=
 =?utf-8?B?RFczYnYwTFB3ZTk2czB2ZTJUNlJoQ2dUME91L25uM2kyTmNtUGlXeGZhRDZR?=
 =?utf-8?B?ajhXMWVtWTc1VjVpUGkrUDhQbXNueGd3MGY4bS9Xc3JaUC85TE00T3ZOeG8y?=
 =?utf-8?Q?MkqE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cdef16f-007d-42e0-c1e7-08dc0c94335f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 19:43:03.7549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bWy/R4Dk7cyQstzXrouMJMaMEz1tdANmrILKfevpWNa5EL4hTuAKSK2yCehrUGi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813



On 12/15/23 11:43, James Morse wrote:
> MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
> used for different control groups.
> 
> This means once a CLOSID is allocated, all its monitoring ids may still be
> dirty, and held in limbo.
> 
> Keep track of the number of RMID held in limbo each CLOSID has. This will
> allow a future helper to find the 'cleanest' CLOSID when allocating.
> 
> The array is only needed when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is
> defined. This will never be the case on x86.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>

> ---
> Changes since v4:
>  * Moved closid_num_dirty_rmid[] update under entry->busy check
>  * Take the mutex in dom_data_init() as the caller doesn't.
> 
> Changes since v5:
>  * Added braces after an else.
>  * Made closid_num_dirty_rmid an unsigned int.
>  * Moved mutex_lock() in dom_data_init() to cover the whole function.
> 
> Changes since v6:
>  * Made closid_num_dirty_rmid[] and associated tmp variables u32.
> 
> Changes since v7:
>  * Clobber kfree()d variable with NULL.
>  * Guard the use of closid_num_dirty_rmid with IS_ENABLED() so it can be
>    optimised out on x86.
> ---
>  arch/x86/kernel/cpu/resctrl/monitor.c | 69 +++++++++++++++++++++++----
>  1 file changed, 59 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 1f371b108a74..6dfc68c800c8 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -50,6 +50,13 @@ struct rmid_entry {
>   */
>  static LIST_HEAD(rmid_free_lru);
>  
> +/**
> + * @closid_num_dirty_rmid    The number of dirty RMID each CLOSID has.
> + *     Only allocated when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is defined.
> + *     Indexed by CLOSID. Protected by rdtgroup_mutex.
> + */
> +static u32 *closid_num_dirty_rmid;
> +
>  /*
>   * @rmid_limbo_count - count of currently unused but (potentially)
>   *     dirty RMIDs.
> @@ -292,6 +299,17 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  	return 0;
>  }
>  
> +static void limbo_release_entry(struct rmid_entry *entry)
> +{
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	rmid_limbo_count--;
> +	list_add_tail(&entry->list, &rmid_free_lru);
> +
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> +		closid_num_dirty_rmid[entry->closid]--;
> +}
> +
>  /*
>   * Check the RMIDs that are marked as busy for this domain. If the
>   * reported LLC occupancy is below the threshold clear the busy bit and
> @@ -328,10 +346,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>  
>  		if (force_free || !rmid_dirty) {
>  			clear_bit(idx, d->rmid_busy_llc);
> -			if (!--entry->busy) {
> -				rmid_limbo_count--;
> -				list_add_tail(&entry->list, &rmid_free_lru);
> -			}
> +			if (!--entry->busy)
> +				limbo_release_entry(entry);
>  		}
>  		cur_idx = idx + 1;
>  	}
> @@ -398,6 +414,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  	u64 val = 0;
>  	u32 idx;
>  
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
>  	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
>  
>  	entry->busy = 0;
> @@ -423,10 +441,13 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  	}
>  	put_cpu();
>  
> -	if (entry->busy)
> +	if (entry->busy) {
>  		rmid_limbo_count++;
> -	else
> +		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> +			closid_num_dirty_rmid[entry->closid]++;
> +	} else {
>  		list_add_tail(&entry->list, &rmid_free_lru);
> +	}
>  }
>  
>  void free_rmid(u32 closid, u32 rmid)
> @@ -792,13 +813,33 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>  static int dom_data_init(struct rdt_resource *r)
>  {
>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
> +	u32 num_closid = resctrl_arch_get_num_closid(r);
>  	struct rmid_entry *entry = NULL;
> +	int err = 0, i;
>  	u32 idx;
> -	int i;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> +		u32 *tmp;
> +
> +		tmp = kcalloc(num_closid, sizeof(*tmp), GFP_KERNEL);
> +		if (!tmp) {
> +			err = -ENOMEM;
> +			goto out_unlock;
> +		}
> +
> +		closid_num_dirty_rmid = tmp;
> +	}
>  
>  	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
> -	if (!rmid_ptrs)
> -		return -ENOMEM;
> +	if (!rmid_ptrs) {
> +		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> +			kfree(closid_num_dirty_rmid);
> +			closid_num_dirty_rmid = NULL;
> +		}
> +		err = -ENOMEM;
> +		goto out_unlock;
> +	}
>  
>  	for (i = 0; i < idx_limit; i++) {
>  		entry = &rmid_ptrs[i];
> @@ -818,13 +859,21 @@ static int dom_data_init(struct rdt_resource *r)
>  	entry = __rmid_entry(idx);
>  	list_del(&entry->list);
>  
> -	return 0;
> +out_unlock:
> +	mutex_unlock(&rdtgroup_mutex);
> +
> +	return err;
>  }
>  
>  static void __exit dom_data_exit(struct rdt_resource *r)
>  {
>  	mutex_lock(&rdtgroup_mutex);
>  
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> +		kfree(closid_num_dirty_rmid);
> +		closid_num_dirty_rmid = NULL;
> +	}
> +
>  	kfree(rmid_ptrs);
>  	rmid_ptrs = NULL;
>  

-- 
Thanks
Babu Moger

