Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719C97E72E2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345170AbjKIUcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjKIUbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:31:50 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9794786
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:31:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ng7m4F0peoUSzWgqdYQuJ1a2tFXSRmn1c7z2h9IJ1lLnxoiZkBStBvcG+JCfs07LQ8GIj88FDVhr1LSkBvB8RAZjHNm7Z3JRXaM1SyyQGWABNYybY9kmCAUS2JEVGLAECaU8u1+cawjHo26wvdJ8sCcBcL+a9bZ+hVZfSWRH4ENpED+emQqtCXLrp/xPNCDjEz9XhZUmSe6nVtuV9UKys7+qoJiEl3VOnhut77UKhTignRPsumRDduNQU5sgyeesEzG2R95K2xMwlHXryI6aGzTGOIkgGMjrk0eYdzfL6VIcLXWNxufGXLFIhU8iIyGtUJik5ExxZgG2yMVBJlR29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uvSQh8vNZ3kYujwneeIXG5KRsHLF2xGBy8YLJF6b4U=;
 b=UYZc5cf+97HZGN5XFIxMGj/XiPORyrDH60uQBgBmuxiQKxBlzbLzwyAU9sAQMJX/3GEy8FT9/TypNi/ek6vftPOjfiGj7XhJ8Mr/h2r9xakeh2/2FhXBeSPIr8gv6kuZ1/AkVZXG+BuPQU8ekl8aI/BPRR8iiczQ/C9LvvGTp4iXzDo32ssK7lWLq++NEq6gjPA9I2N2024w1Ss/5zr2hKXbpaG89ZENXHoXim3hs3i3C9vvRfNA41mejpnlg/ymJbYraxlDMhacySTeyhOP5lNv6741amUd3DN8QEp2Blt1AArVQGMIm1DJV764z8FlEs11cyHck2kXJfClV4tRvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uvSQh8vNZ3kYujwneeIXG5KRsHLF2xGBy8YLJF6b4U=;
 b=L5JpL+91aLp9uNkxnaYts2hAQusspaBvoXA5zFI+Mx2BzYY0ujweX+FRs5mTyE6wyfUTN+FiaOM98YdVC1TscvUPODtUG+H1wGVU+muKTU7u27J7jSFRMBdiugbD8Wu/Qrcx/MQX0takfYPLNXJyUDpMN43KqFcfVkgnQxHEMkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN0PR12MB6150.namprd12.prod.outlook.com (2603:10b6:208:3c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 20:31:40 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 20:31:40 +0000
Message-ID: <77d92d3e-7259-418f-8b3a-e245dbc3d259@amd.com>
Date:   Thu, 9 Nov 2023 14:31:37 -0600
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v7 05/24] x86/resctrl: Track the closid with the rmid
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
 <20231025180345.28061-6-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231025180345.28061-6-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0086.namprd05.prod.outlook.com (2603:10b6:8:56::7)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN0PR12MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f9818c-ff34-4035-f223-08dbe162e111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RxAgFBx3YZI52RF2lCXHh9Z/TNkrGbR0Ut5rgNRxAEXD7SisKXG9gqO8PFWWVHSPFvpohFZAjZodPAPi/YPHzIyFUiKX7M60/7io60fwWai7Re4W9Jjuj3v0scG3JdE0Pi214NOnH5NwTNM5uPaMvh+/MB6Fh2fTgpkaFC4nmmQrUwoDzMPVetqa718UyJPsOj5Aw5q8VQyiggeAL2tJy77NZceALWZ1joLYc9Vw59+3HvTNQQnWhLpP5NhnDMyQ64iDA30OexaxduZKP/OihO1rV/zrstbUEMII2j1Tj7kgKct23ruNpkSmMVqoWzi6Sz8dKywfO8wm25VeWOiVPVqgY+xQXtlru7O1gNnVrfQLnDUMDe9i7E2tShbfZxGCtbNardNSSMTAIpZU6rT2vGaLUlm+EXl161T/X0gmR3Rocc3FQrlAtoOlHH3AswlTg0IScN5PzUqRBkaYKX8mv5tTENVuGqGNOe7JYdbTG9uy0OKTeIFrSjzxFppxDZtaQUgH4f4Qheh0Fq/J65QDdxckDt0aKbHL77huHz0EMfVq8hE9vKBDI6+Q0k9X0iGaI6rbci1nMMXWbYjUjMowoWYKQSjMYOEcFchEnayTDgIhbE6te5FBtws5XYW6++o3qn9hdSH1Ker3cfIFwFiDMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(7416002)(5660300002)(8936002)(4326008)(66556008)(41300700001)(54906003)(66946007)(3450700001)(6486002)(478600001)(6666004)(31686004)(2906002)(316002)(8676002)(53546011)(6512007)(6506007)(66476007)(26005)(2616005)(83380400001)(86362001)(36756003)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDdQMzZZL1BZaitWUmh2SDl3ZjB6MGVZamE5OXpWNFRNRTAxU2hXSlNJQ1B5?=
 =?utf-8?B?YTQzcmZTYTNubWhMV2lhUG03STdCajEvUktFb21SV0tsVjNnc1dxWkJEVHVJ?=
 =?utf-8?B?OXpqTkF3ZVp5MGRoVFByV3FiSVp2QmhscUtVTHJ1d05hUVVJbjVBcG16NTMx?=
 =?utf-8?B?SDhjQ0NVNUFuN0FTS2RiNUVmajhxZms2TkN1ajRudS8yVDI1SVdXeFBpNHlG?=
 =?utf-8?B?d2pZdGZpWGRNbWtrZXpMVU5mMG5JU2IvNzFMOFhwNllTVkV0bGpWbUVEUTlI?=
 =?utf-8?B?T081YSt6aml6cTJBTmFmQUNyOXl3Mk9oVjFSQ1N1YVpjMGN4RE9OV29BMnR1?=
 =?utf-8?B?M1hHbzBaMGkyU1J1K255a1BDUEZJeVhpMGVsOWdIOUg5ekpEWFVGNzNYZVR3?=
 =?utf-8?B?aGg2UVBKOFV2RFZpYWhGUzVRVk9rUkNyTzRoUzdGS3pDV1N5UTc4RXAySHFa?=
 =?utf-8?B?T2x5M3pGMGdFODByRjhlMFdBUFdSOUI0c2w4UnRNU3kvUUlET2FiKy9OSnB5?=
 =?utf-8?B?T3Y5eWdETGhqQUgvaEU4VE11a0xVWU5rSGM1T3J5WEM4Vm9MYVdrVVJuTEJB?=
 =?utf-8?B?QVhQbFllNjEyeVIwOWhUd0FmZ3B6RjhwZ0NwSXcrZ2dpODR3eEV2SGxxZVJl?=
 =?utf-8?B?V2NYVENIVDhjclJKT0dwRDRKL0owQXJUdDdva2Q4RlVsNXl5Rk1qWGNESXVm?=
 =?utf-8?B?Sk9QYzJPSWg3TjcwSzF0NTZVR0x5ZXQrdjE3MVJJMEhXMVVGTmY0cGlFTkkv?=
 =?utf-8?B?dlhYSTVSRXZrNEJXYUJuUXFQTElKZXpXZ0ZTNHRxb2gyUDFodGhTdWwwbENV?=
 =?utf-8?B?TU9VaEZ2bGtqKzJkK3lCbnlXSU54bm1SSjlkYzdiVUdxK1hxRys4QkVDY1hW?=
 =?utf-8?B?N0gvYjhuWU13MUVxTmZFNy9FV2JQTG14elBSUWw4UFZyYm11UWhlOXRqKzZk?=
 =?utf-8?B?a045R3hPTjVEcU5QN1BmUkhKVG5YOXNGN2dMb2xLRG12bmVYYzZ6N2Yyenlj?=
 =?utf-8?B?N2JkdnMvSXExcGhSb3RtU0c3bGJsZDBvYXRyVTM0SHhkNHVVU2I1SWtlUEl1?=
 =?utf-8?B?OGVRV3VqNmVEa1dzenVTck9PL2tTUzZtR1FpRFAvTDJraGg5Y1k3citwWE9X?=
 =?utf-8?B?S1IrTEVtQmlZNHhDNVk1RVI1S3J4Y3A5TUdmeithVXB1UE53czFrakJvcVVN?=
 =?utf-8?B?QXVwWTZTT2h3RElsTXVxZUlTa3c4OFBSekkzQWU0cTcwNTcxNzl5N2g4UnhZ?=
 =?utf-8?B?Nms5TDF3dW0vQjRMdWN6RTF1VGZ3czF0d1NEVGZRMjFodndrQlNBOE9BT3JK?=
 =?utf-8?B?ZSt4bHlLZHUrRXllMWhaMzN2Y0NqUk56My9QeGNIVGtaQW5LaTM1bkFkSUJX?=
 =?utf-8?B?a1FxbElrcXovb29sbThmRnpVZkVMeTdLUENxczUweUFSaXBIYzYyWjdaS2E4?=
 =?utf-8?B?UVZ0ZGl6Z0plWFo0VlAyNFliMEYzSHpJbUZYWStvd1oxYUwrSm13WUJxaWgy?=
 =?utf-8?B?SXE5dkFaLzZXWDdValowMnd4TEZnbmVXcytYVE13S0NLWGt5VEVxZVVUZzlF?=
 =?utf-8?B?WldSWGJsTWhpMzFPQTJObGVFTnJ6enBSQTJDR2lxL1IzckZRYlJMOThwSld0?=
 =?utf-8?B?dnVNQjhxTmJkb1RRZjNVOElDQWp4QkZ0TE5wZGpxOWQycEM4TU1UdG9rUjVy?=
 =?utf-8?B?ejcrbW9EMGNPKzNITmJycHFoNkN1UWRSU2hXMzRDaTQySVh3VVB5TUtSVTMy?=
 =?utf-8?B?KzhoQlgxV0J3Y1habjVqRkM1RzAxMWdCM21aT3p1NVlLYVhQSkEzSEpyMkJX?=
 =?utf-8?B?VWhJRksrbW03S1FEUGdoUHA5cVI0OVR1cTNFN2pubTFpb3gxaDVkSGNqenJm?=
 =?utf-8?B?cVBPNjZqRFl4UTl6eHlaY1k0ckdrUXVla1JtaGRSN2JRdldVOVYyRGsxRHZT?=
 =?utf-8?B?bjdJUUUvK2ExRmxZWGFMMVp2aFZoSjl6Z0NJQm1QVXZMNHJJaG1FaFJINXNV?=
 =?utf-8?B?QTJBeXQ1VmhqTjR4V2RoUWtxa2dQWjNFTmY1UHoyc2JhU2dGTVd6UGZPWkt1?=
 =?utf-8?B?SUNHTlFDb0hkTnozandIZjdqZ3dUcHhrRDRUQk43NHp5a3JWZy9zV1gzTkRP?=
 =?utf-8?Q?NwK0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f9818c-ff34-4035-f223-08dbe162e111
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:31:40.3476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIGVVrsGdAaFwkdw7KSKL1olZKX0Igx2S2rUIMcJJ3uRvE236zK4DiDK6cKU/5IT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/25/23 13:03, James Morse wrote:
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
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Xin Hao <xhao@linux.alibaba.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---
> Is there a better term for 'the unique identifier for a monitor group'.
> Using RMID for that here may be confusing...
> 
> Changes since v1:
>  * Added comment in struct rmid_entry
> 
> Changes since v2:
>  * Moved X86_RESCTRL_BAD_CLOSID from a subsequent patch
> 
> Chances since v3:
>  * Renamed X86_RESCTRL_BAD_CLOSID to EMPTY
>  * Clarified a few comments and kernel-doc
> 
> Changes since v5:
>  * Use entry->closid from the iterator, instead of the parent control group.
>  * Move the reserved defines into this patch to reduce the churn.
>  * Added some kernel doc.
>  * Renamed some arch closid parameters as 'unused'.
> 
> Changes since v6:
>  * Changes to comments.
> ---
>  arch/x86/include/asm/resctrl.h            |  7 +++
>  arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 74 ++++++++++++++---------
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  4 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 12 ++--
>  include/linux/resctrl.h                   | 16 ++++-
>  6 files changed, 77 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index 255a78d9d906..cc6e1bce7b1a 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -7,6 +7,13 @@
>  #include <linux/sched.h>
>  #include <linux/jump_label.h>
>  
> +/*
> + * This value can never be a valid CLOSID, and is used when mapping a
> + * (closid, rmid) pair to an index and back. On x86 only the RMID is
> + * needed. The index is a software defined value.
> + */
> +#define X86_RESCTRL_EMPTY_CLOSID         ((u32)~0)
> +
>  /**
>   * struct resctrl_pqr_state - State cache for the PQR MSR
>   * @cur_rmid:		The cached Resource Monitoring ID
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index f68c6aecfa66..c836e3294e12 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -544,7 +544,7 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
>  int closids_supported(void);
>  void closid_free(int closid);
>  int alloc_rmid(void);
> -void free_rmid(u32 rmid);
> +void free_rmid(u32 closid, u32 rmid);
>  int rdt_get_mon_l3_config(struct rdt_resource *r);
>  void __exit rdt_put_mon_l3_config(struct rdt_resource *r);
>  bool __init rdt_cpu_has(int flag);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 5d9864919f1c..2a0233cd0bc9 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -24,7 +24,20 @@
>  
>  #include "internal.h"
>  
> +/**
> + * struct rmid_entry - dirty tracking for all RMID.
> + * @closid:	The CLOSID for this entry.
> + * @rmid:	The RMID for this entry.
> + * @busy:	The number of domains with cached data using this RMID.
> + * @list:	Member of the rmid_free_lru list when busy == 0.
> + *
> + * Depending on the architecture the correct monitor is accessed using
> + * both @closid and @rmid, or @rmid only.
> + *
> + * Take the rdtgroup_mutex when accessing.
> + */
>  struct rmid_entry {
> +	u32				closid;
>  	u32				rmid;
>  	int				busy;
>  	struct list_head		list;
> @@ -136,7 +149,7 @@ static inline u64 get_corrected_mbm_count(u32 rmid, unsigned long val)
>  	return val;
>  }
>  
> -static inline struct rmid_entry *__rmid_entry(u32 rmid)
> +static inline struct rmid_entry *__rmid_entry(u32 closid, u32 rmid)
>  {
>  	struct rmid_entry *entry;
>  
> @@ -190,7 +203,8 @@ static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_domain *hw_dom,
>  }
>  
>  void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
> -			     u32 rmid, enum resctrl_event_id eventid)
> +			     u32 unused, u32 rmid,
> +			     enum resctrl_event_id eventid)
>  {
>  	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>  	struct arch_mbm_state *am;
> @@ -230,7 +244,8 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
>  }
>  
>  int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
> -			   u32 rmid, enum resctrl_event_id eventid, u64 *val)
> +			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
> +			   u64 *val)
>  {
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> @@ -285,9 +300,9 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>  		if (nrmid >= r->num_rmid)
>  			break;
>  
> -		entry = __rmid_entry(nrmid);
> +		entry = __rmid_entry(X86_RESCTRL_EMPTY_CLOSID, nrmid);// temporary

What is temporary means here? Can you please elaborate(or remove)?

Thanks
Babu Moger
