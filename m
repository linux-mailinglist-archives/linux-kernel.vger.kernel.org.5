Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69B97E72FB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345181AbjKIUib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjKIUia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:38:30 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083B2182
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:38:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJf+BoYsyZftaZQZPqxrPECapXCiTsJ9jo6xc0F5i/gaY+DwjLY1+tI/VeIfNalagaZOQW6Oi8KAwUII95BbGRLDSjvjb0S359Q0+A+3cB5fnw+rwE5rbOkvldsoNeD6E1A/3hWNtZBTFg4KiYH8ZRVRv7+K4bohNWnGbQvy/G/BDp1sEYmVZXU0S4Jes3VBwaLY2+tMh22IAPi28cFXd3swWK7vjYBd0dpOns5AnpN1PjO5Q7lHVfs5HOkogxSnBjH5Hs+Pq6nseqFp3TwQsR2hQJT1P0Vccy14Q0piN9KjA7Bqgjw6O4s7o9SAapaXM4OIzdIGOtdqmwcRTvCDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3XXORfByD85XxNnSqZniko401E5uui/vO2fkwbsdiY=;
 b=aagHztSHqUi0RdypSOogTTpGGtP+IY2ipT0CGt9xiUy1oQhTn7HPO50kS+QjvP+CGrce1IKI2TsdP56ygGz9Y25YmzXMGS9rYBya+WIvp0FaM7PGAFVVLJyeZkqmO7Rcpz+CfZa0swnMLWNr8uGb7ElASiu4UGSRpVsW+U5nNrzeIIJDMw/hDdhGqOizJAATRadDvWfoxO5xgjy29gH5CvFhjFe6lpuNX1Jtt1FdkP3Lqt0THaAKbk1Ctya2JkPCAnCnlAFlj5iPengGttW8Vr4B49jozd8h6VfRrF+AFuzYL5+OBAQQi/sg75g1r2c0lRrTThYJGfSZHENYz8MjJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3XXORfByD85XxNnSqZniko401E5uui/vO2fkwbsdiY=;
 b=oEw+gb6+zH2SLtjiO8ysSPKaymQLpJdqz02gaxVU6zU9Jct/mE7gzZnjAdBac9g9LymkkQchYe87kNrrZZMTTYnsXAk6alhA+dYaXyxZZti9V4SQrjKn1sxf2NvbblIMkv15Zty7ZikcT6npkd1nuBChuUYF/2OC9rLCHziC9vg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 20:38:24 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 20:38:24 +0000
Message-ID: <17055477-d381-41e2-86a8-b27f871cba3e@amd.com>
Date:   Thu, 9 Nov 2023 14:38:21 -0600
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v7 08/24] x86/resctrl: Track the number of dirty RMID a
 CLOSID has
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
 <20231025180345.28061-9-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231025180345.28061-9-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0029.prod.exchangelabs.com (2603:10b6:805:b6::42)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a2ffffe-436b-4c10-143c-08dbe163d1f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XADy1d0CQxANx5bm1rAbxUkWuC66OoW8/siVx0sbjKBTR8v0KZxcNEkDkRyOm9FiSLDclEJdhdwfNMG6ckSfWYaweeLpGhBoxh68eV8X/SN7Q0NqycwI9WfRzUbDc5AQ563NMjAWOeYw+3cquU310ABOGvRHwYRPHmDNYn0e3f9bM7MBHTRwkpWxY5Gt+hEt7hQOD5vpZRlKjvvUzkLYqn214uk456E4ZBC3a7XLmiC4yqZW1rw/4lUZbPuZ/akQJS6QDoLGtFWsOxJ4PZ0DeRjSsSJjn2099CGrzFYQ2IIcpLcLHSVk0lSk6nrQyIMwnpCXdHXrBw2i/K6i4m7WjBRVypEl3fCJibjryFoooMdIikubIfVNtCxLeNnObRXq7SoiMq+ErN6qlLLqq8xjfUEk6P82FrE7NbdMG718BStJ9dzK0ZPEQ387QFE30RBx7TAbQKjTh0SJuLWTyKEtRAVKDsMv99rGQpcSLAjX/tFpLB2k8WyIZBhb2EVt7V4+wJVZHb98CV81OUEqtCpfUxlj1q9w3/YUFI1KnBC4MQy8J83kCPqkFnObQJlFeYvglXe0HGRohBJbnXBtSr6w8DVwiIk0RCg4RG7zz2gnK06aDOFqnq7vcgmj+ZyoPZt5urg9HzbFQxVL4vtrkSzAaDnex5MpQpAY40+Y5eDZS+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31686004)(4326008)(8676002)(83380400001)(7416002)(8936002)(5660300002)(3450700001)(6486002)(53546011)(31696002)(6666004)(2616005)(86362001)(316002)(478600001)(2906002)(26005)(66476007)(54906003)(36756003)(66556008)(66946007)(6506007)(41300700001)(38100700002)(6512007)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTVvL28xVCs4WWlOVGNYWUVHb29KS0J4K2RyQnkvS1YrWmtRNWFENkVwK2Ns?=
 =?utf-8?B?SXpiamUzcTBqVTI1ZTFjQ0s0akhqMG91UXMwVDZGNThYT1pma25YMnZtZ2p4?=
 =?utf-8?B?dlhzTkw1STRyWFJCNU9YTG9BUXhKZGpLUGg0aEZNTFlYYkdsRmN2YWpJN2xa?=
 =?utf-8?B?TTdIMGduS2xTZEhpeVkwalVXallUTkFrM2JxN1dOaVBIaXNiem9MdFRkaFQ0?=
 =?utf-8?B?RktmN3ZYU3p0YWp0dkxWMnNmTHdRcnBlVUZLMzFGN09rQklFQlk2Z1AvMHpL?=
 =?utf-8?B?d0Nma05JUlRPc1Yzanp1Q01UZVczV0IyVEs0OUc4NGlBaTcwRGZwbTRhbTB1?=
 =?utf-8?B?bml5MGxia2hTdkI1UStDbEF2ZHg1UitHSEdFVzlOaGZrRVhiZzlZc0cyVGN6?=
 =?utf-8?B?MHJkVHphVnhlM0hiOGZpNTlrakFuOEJJM0xvUFI1Y0M2cjE4czZjTHJZT1I5?=
 =?utf-8?B?U2NNMCszSHJvRFNtRS8xOTN1dCs2ZDUyV1BkZysyNTZKUXJiRVdiUkREV0Fn?=
 =?utf-8?B?YVJoeWNUV3JRVmNUVVNKMnI0cXNnb05TUnV5OTk1dG1IbktHSHVkMjNCRTht?=
 =?utf-8?B?SlBvUjFaZVF2bEJHcHdFYS9vNUxNSktRWG9xMDdnaDVGY2dVVTVmb2pZMTdG?=
 =?utf-8?B?UjB0bHUwMGozUEIyU2FvWnAzSEFpa21QenYxUE05Ukl5alB4blQ0b3JxaU1m?=
 =?utf-8?B?TDlLNDhhd3FqdDBTZjVRQ3lFbkFDTlZwTGVLZWhvTWhWZENoR1g3R09ZeklH?=
 =?utf-8?B?WE94WjZhOGhLVVJqR1ZmbFc0STFmT1orNWtzQVRsVHZ2REpReE1sQnRxOGEw?=
 =?utf-8?B?QVdhS21vVWQxd1o4aXhtL1p5S2RVMk40TjU5bVFNV2x6NHVEQkNpSjhwWjhq?=
 =?utf-8?B?MkpuWDhHcmxIUEZzNlQyRmRqeFFFb1pIdjdkRk9zQXl4ZGFMalVCVDd3TExx?=
 =?utf-8?B?SFZuM0d6VExzeU9CakxhcWFNSitJYzgybUJORHNvWDducExFZURWUUtzckQ4?=
 =?utf-8?B?NVErTGI5dzRINU5RUExYZk1nUytuMnpwMlVSbDIxbzZMNG05bTJJZWRKd1JT?=
 =?utf-8?B?Yk1VOTlBeUVFVE9NVi85N0tHWTJiY3ZyTlU0c3pBQ0g3YVVxbGt6Q1FuR0M3?=
 =?utf-8?B?Y1hlZXpPYm9EREdoRUdvNkdkN1hzeStmMTQyVVdaRDJXNUlmeStjNWNBUmhm?=
 =?utf-8?B?bmVobWcwUVNvSmF4TUdYRExzYXM4clQrQ1IyUFhOL0NQaGtvMENncDJTMkZ0?=
 =?utf-8?B?K0luUGQvZXM4SC90QWhsWTFpSnpZNk92aUYxcms3dVpRdkt4b2NBcStRMUVh?=
 =?utf-8?B?c2diWGt1bVF4NjMyVGkybXlRQ0JiM3QycnFPTkViRkIwUFQwc1NLdjA2R1lB?=
 =?utf-8?B?dHNrV1lNWEx1VjhVL3Z3Tm1NOExHTnRWU1hTWDVDVlRQcTgzVUlLTXNIRGtz?=
 =?utf-8?B?YzZtU2d0OU9LL0llc1NLd0FKSmZFN0E4MEY4V1BraDFaYzZJZEpYQ2tMRnB2?=
 =?utf-8?B?V3A1WEZER0ZiKzZnYitHVStSY1p0V0ptTzROV0QwUHYwdmZZQktoaVlZZldW?=
 =?utf-8?B?dnh6YUN6K1J6L1ZLOE1IcHQyK2xvWElFTjFrc2cxekY1T2c0K1lmbElLTkQ1?=
 =?utf-8?B?ZzRSTUFJRmg0eUlyWm5TOUNxdUV4THdzUE5PNm5Nalo2UlladlVSRUFXSlV1?=
 =?utf-8?B?d29kREJhUlF5eVVpQWF5KzFkc05Vbk5RSGhpUVBwbnFvM29yaVRmOExoQmEz?=
 =?utf-8?B?QTEvZHI4ZEVGMS9XTk1ybGNoVUgyTzBxcHRheFdMR2RTN3JRd0ZGa3dVT1Vr?=
 =?utf-8?B?ZkpEREhZNFJBZ1Jaa1VYUG51UHhZbktFcy8wc24yeVJ6TGJSY2Y5NU1qWmFr?=
 =?utf-8?B?eGpieU5YdTRDWDc5VjdXRkk4K2UwSXluNnNPMmVFK2ZscDFsdnNsTzlsVEZs?=
 =?utf-8?B?bk03STdzQ2hGM3RIdVVGR3A1bUhVN2hBc2d2WmtVWEU4UncyM2NmVXlXL2RU?=
 =?utf-8?B?UEx2dnBaSU9vNk5ydTR4SC9xTm9jVGdBdGZWOEd4MlRpeU8rV1EwNlorcnVh?=
 =?utf-8?B?bHJaT0htL1lvQmFUZldaVWNiL0hKZjFVWlptT3hDYXBralVIdndwbEw5QkZn?=
 =?utf-8?Q?A1J4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2ffffe-436b-4c10-143c-08dbe163d1f3
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:38:24.5009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvKY0ir1kErUEuEAr1isFvGYypS8WEC1PM8EJuHQ655n74f/N873YUUiQnzRG/yX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254
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
> Keep track of the number of RMID held in limbo each CLOSID has. This will
> allow a future helper to find the 'cleanest' CLOSID when allocating.
> 
> The array is only needed when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is
> defined. This will never be the case on x86.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
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
> ---
>  arch/x86/kernel/cpu/resctrl/monitor.c | 66 +++++++++++++++++++++++----
>  1 file changed, 56 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 3c9343dffdf7..9a07707d3eb4 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -50,6 +50,13 @@ struct rmid_entry {
>   */
>  static LIST_HEAD(rmid_free_lru);
>  
> +/*
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
> @@ -794,13 +815,30 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
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

Any reason tmp variable required here?


>  	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
> -	if (!rmid_ptrs)
> -		return -ENOMEM;
> +	if (!rmid_ptrs) {
> +		kfree(closid_num_dirty_rmid);

Should there be check here while feeing?

if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))


> +		err = -ENOMEM;
> +		goto out_unlock;
> +	}
>  
>  	for (i = 0; i < idx_limit; i++) {
>  		entry = &rmid_ptrs[i];
> @@ -819,13 +857,21 @@ static int dom_data_init(struct rdt_resource *r)
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
