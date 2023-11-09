Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AD47E731B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345212AbjKIUvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbjKIUvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:51:53 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD2F44BA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:51:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsm5lfTb983St/mOh+6DZ76nIPtUobSI9S7JiENOTU7Qe8WS79cSQ5GCTGSDfM0zKp65mxf9UqLzOfrCL2/ToY+EvWozHucWx/wTgrhb7tdKWUmJyIDrcjtsDp4Jq7xhpDo1XWRJ/HnCSYrGFv875G2iCi9Maymb7e1EJe/Ix/L46Ula3nk5OKq2no7BiH39DrKrLm2q1LQYC7f1mKMqEIjZfUESUCyONEJNFlHVGqCeMsAbJMBzXtVoViWUpSie5o1nrpTsarOGq89NbP/rTQYXutZPMOL+ClcYaetSoTMJFkKIJgHE8dvMtdUrLdWNlgu+wcVvHg+l3z1wfahv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqiEQzDOnfO/A3E4fg7IFeFIT3dD8NlFbvfN/mLvZPA=;
 b=D4iHuvxHPm0ItmtWydBfN+H+IEVQlKDyxdJ8WsgKY495iAcz3AGK9Cos9CSnlF7zELK9+1wv3bCY478Wc7nX54r+EUzxDdhWY2BDGKiCJL01efT5vOjZZWAX8dw19yKS7i32iMs8h/fk++KVmhI8J1loK2CwBNBe3Qv3lHy5pFWPXCGCux5ZO2Pp8YnLMXmsHQFCYh1WH2TCbs3d762P77IMaxirw/OcdCY+B6EAze8P44mmTe11EOBQsFvIABOJROecATEHGOQP4y+WwDL4jcqV6fe4ggAeATFGZOJGxYc54dehqBIzJXnfSc6msZD1S04sgQLBMGBLJCFlPySLpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqiEQzDOnfO/A3E4fg7IFeFIT3dD8NlFbvfN/mLvZPA=;
 b=Vf7MToOObNADlAaREk3iLQIrVGsABvswhwKViZzGsqPRQPmfo69vsNeqNTeHEdQ8UIXHhmP8Zvp2KouuB8jgFQNexGI3gh9+EsjNm0gog2BwxfrLmbPdClDmTjqbBUuXeO27q1kC7tdiTr4eQTzGjgYsSpRayAmzQ7SZGvhUjO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 20:51:48 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 20:51:48 +0000
Message-ID: <a8725d37-e3f5-4fd4-a426-b03b143a3b26@amd.com>
Date:   Thu, 9 Nov 2023 14:51:46 -0600
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v7 20/24] x86/resctrl: Add CPU online callback for resctrl
 work
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
 <20231025180345.28061-21-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231025180345.28061-21-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0090.namprd12.prod.outlook.com
 (2603:10b6:802:21::25) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bdd7fbd-305e-4e21-57d1-08dbe165b11a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /FIY5GgyfuDZg9ZRcgI0N/ptsvttDuMWG50GO/fXGCjP0JovG+K2yVLwaushchuXgn7xdW2aDfsdi51FqdXHEWRACWkQnMY+EszDhMO67eOps8JPvPaaaXu4lLh53sX//cZXs7mHhJtXn/j5uwqbhNXphW1DwYgqdWJ8Ua5Z8E4G3Fpapp5CZuzFSipUFT4YPmG+ZjxC682tiUt47yzBULYVjKkT6jpLOAm5jaO6h8kJFZi/ZoklXRUp9H26FFq1ZCWspDhxF0Pl4b876TWGM35ecvfFI/1QJ0e9mA/uTAAhHqYe4fNyYWSIdqEEybMOJ0x0GKy03fuLbW7DkAYB1ScKGMJVqhJ88hNk4VdS2tqi3XN3bcOJ9AcJsQm/r/jfDQVxuQPg18WCqsEHwGpCtT7xU5OCxuIqSLYQZTKmmpxq/OtYtj2mgn2iCc2gSlzSjn0gfsMRy1x4JaeUBUdoRiJKHlUk9jil1fxgpR3oOKbiuJULDXZCRjvAi0gm3gIdYxkeqzQkyWAS42Rq1bA2gzM6iesdQtysFVBWYjRUM+H3s3+Zn9Sw38H9lT/oH3Ye8qmbCTxv4PwJgMJ8ZfGTCqWTVuna4OhfYAMUnINJKLlRae7tjfMz10v2fNiOxrEL0Q2X+u+Oa6+XjIAiacrxVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66556008)(66476007)(54906003)(66946007)(53546011)(31696002)(26005)(36756003)(2616005)(6512007)(316002)(38100700002)(83380400001)(6506007)(86362001)(6486002)(478600001)(4326008)(2906002)(8676002)(8936002)(41300700001)(5660300002)(7416002)(3450700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGdzdnJIQnE2TXZZU2hvU0FPWUgwTEx4TjlZTkVPeW9YTzAxalZoczFGN202?=
 =?utf-8?B?WFJQSEZFZ0cwRHE1Q3pWL2dJOHBhSklFWVdZdlRtSnhUVndPYjZDOVV5b0R0?=
 =?utf-8?B?S3JXb2ovT3diOC92aEkybXM4bWVIdWxGeEtNOUlXdld2R3o4TlhGM09yNmV6?=
 =?utf-8?B?OWdQMUdPa1BCVWVuREc3di9GSXBYdFdjTXJ3aGJIT1ZncXdYVzcyY1I0YVUv?=
 =?utf-8?B?SnhvMmp3MGFmY1I4Sm40OTdockNvMU10WVk5ZHpHRnRZeHRJRE9NUncvZlR3?=
 =?utf-8?B?Z0FyMkFjSDE5ajRQNjExYTA3QmludTVRRkhQcDJoNVZXOEdleXg5OHBneWxH?=
 =?utf-8?B?czZmUm5SZk5SRDJKN0JrUDJEOUl1cFFJWUlvUWF5ZjVwTDRIeGpaV21XSHlN?=
 =?utf-8?B?UmIrbU0yRlBtRWEreDZOL3k0VGR0RldGcVpsbGY0ckNNY09LVWE5VHZhS2Zo?=
 =?utf-8?B?M2FpYytiUHpsa2NMUXZVTzRZRG55aGVLRG1FZXoyRmRKMmhQdXkrU2ltUXRn?=
 =?utf-8?B?M3ZGY0trN0VpT2RrZGZmc1Fkei9qaXlFRnpNVEttci9uL3ZndWNTa1dyc0Y3?=
 =?utf-8?B?V2JmTHRlWFlDRnFnMzczVGkzUjNLS1N4T3Z0d1VnZ1hnYmtsNDdCZE9sbm9I?=
 =?utf-8?B?UTVBYlBKVmNCdnFvRUkyYWs5NDBYSHRDS0Y0ak1BT04za1FJS3IvOHlvWTB4?=
 =?utf-8?B?S2FqNmwzMWNLaWhWSU9HZEljdHlhd2FqdUtGV0xrZVhMaGx0QjI2WjlPeVRC?=
 =?utf-8?B?aWxTYXR2QWlZS25INldPNDlKODJCMlVqOGl0RmtITitHdUIrczM1TlVBVjJ1?=
 =?utf-8?B?TDM4THF2cGdYbFpoR2RKS2xjUVVEbHlmV0VWdCtNaElMb0dNQm93YUZjSUEx?=
 =?utf-8?B?Q09oSVFZYS9nc1pNZCtKN0x5N0x6MnY2ZkpGM0NyZUs2ZnR2QWZ1UXB2SDgw?=
 =?utf-8?B?bUY4QmUrZ3RVYmRUdU9Yd3A3cVhDbmJZbWlqelFtdzNTSE02OU9uUG9QRlBT?=
 =?utf-8?B?VmFaMHc2UVllZWZiVklNRUF5a1Y3OEpHenIvaXhKa0thSHhWTzlZTUtMQ1Y5?=
 =?utf-8?B?SHo2SHpMbmNob05MbS9CWXZZMmg0WXVzRmpNeHZjMzNsbk94aVpXNDR4MEhM?=
 =?utf-8?B?WFhtUmZjZlpLeDRucnRvbDV3SjlsWEozcVFuVUxBWEJLYVZIaDFFTDlsVW5O?=
 =?utf-8?B?VlgxNm1sNjNlbGRxY3FzU3l5b2RFTktJdzh6ejB4eG9FRmpvWkRxQStUVHRG?=
 =?utf-8?B?ZVFBWE5XUmVuNjRaLzI2cHQ5MVcxaDlPZmNkcGV5Z1VybVZ5VzZyRTduclJz?=
 =?utf-8?B?eWxtU3pKNU9aL1JqVWpQaGhKWnBrQnB4MThCMi9FOXlzMWlSdVlLRE84NG5J?=
 =?utf-8?B?Ri9QS2NqWUJ2dDR5QisrQ1RxY3VodkZtNncxdGVLNTd4QXovL0g2OFdVQ2kr?=
 =?utf-8?B?aVFXQXVhck4vanR1MFdTTjFrbzlZWUMzeC9ZVWZta2NJSzU0RTlIMnNoSkRl?=
 =?utf-8?B?cUhOZ0dnRzUvTlF6UWNTUDBKK0FGcXhDZnhwM3IyNmxMK2RTWXF1MGVVRnBC?=
 =?utf-8?B?Zm5vMWJyNHNxeEJoRVBhbC9HQ1ZkRkRxZ3doTU4wNTIwQ04vQ2lMaVF0MTd2?=
 =?utf-8?B?RGExVElvYmNTSEVvdENRbW96RXdTYUZ5d2xmdCtPUmJ2QkhPa00wSWYwU09S?=
 =?utf-8?B?UU8wSlovbXE3SVEvYm5TbzdpSGljUG1DSDZzQzMwWUJVK21zM3dybEk5Y0hp?=
 =?utf-8?B?dW56TWRBd1ljWVowQ2JNWmNPN0QwN1luYkhCYktHMVVyekdNWHlxRUc5M3RQ?=
 =?utf-8?B?V3VFYjNMZ2lsUkVKZitxeWs3K2JWUnJuWEhmQXhKRG9Oa1JxWDVZUVFvbHZm?=
 =?utf-8?B?T2ZISzQ0OEJORy9xNmZwVjExOSt0WXNQZzJ0S05LdXZTVStlbm5qUFVvcXRS?=
 =?utf-8?B?K25UcGh1M0FwWnY2eXVXU3JYRTNxVDFKMDlBZGxtWmtLdTcyL1N2R3lRQ1cr?=
 =?utf-8?B?bEJCVWY5ZUFDUGJLbmtBNzFjY0k0RTNYTzlaQUt4S0VGeHh1OWg0Yy8zcXZ1?=
 =?utf-8?B?UGxKTkVXMzkzRTU4dTR6Vk10Tm9PUjJsWkVLL0ZTRU9uK0RIS3NaOHl6ZE9J?=
 =?utf-8?Q?5KF0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdd7fbd-305e-4e21-57d1-08dbe165b11a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:51:48.3671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZSyJ3K4cac1+fb7ncSrEWN4E6uYUEW4m0sVlLPRsxCAxTU5Klj6MHfUI2peVGvh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/23 13:03, James Morse wrote:
> The resctrl architecture specific code may need to create a domain when
> a CPU comes online, it also needs to reset the CPUs PQR_ASSOC register.
> The resctrl filesystem code needs to update the rdtgroup_default CPU
> mask when CPUs are brought online.
> 
> Currently this is all done in one function, resctrl_online_cpu().
> This will need to be split into architecture and filesystem parts
> before resctrl can be moved to /fs/.
> 
> Pull the rdtgroup_default update work out as a filesystem specific
> cpu_online helper. resctrl_online_cpu() is the obvious name for this,
> which means the version in core.c needs renaming.
> 
> resctrl_online_cpu() is called by the arch code once it has done the
> work to add the new CPU to any domains.
> 
> In future patches, resctrl_online_cpu() will take the rdtgroup_mutex
> itself.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>

> ---
> Changes since v3:
>  * Renamed err to ret
> 
> Changes since v4:
>  * Changes in capitalisation.
> 
> Changes since v5:
>  * More changes in capitalisation.
>  * Made resctrl_online_cpu() return void.
> 
> No changes since v6
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     | 8 ++++----
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 ++++++++
>  include/linux/resctrl.h                | 1 +
>  3 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index fc70a2650729..1a74e9c47416 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -608,16 +608,16 @@ static void clear_closid_rmid(int cpu)
>  	      RESCTRL_RESERVED_CLOSID);
>  }
>  
> -static int resctrl_online_cpu(unsigned int cpu)
> +static int resctrl_arch_online_cpu(unsigned int cpu)
>  {
>  	struct rdt_resource *r;
>  
>  	mutex_lock(&rdtgroup_mutex);
>  	for_each_capable_rdt_resource(r)
>  		domain_add_cpu(cpu, r);
> -	/* The cpu is set in default rdtgroup after online. */
> -	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
>  	clear_closid_rmid(cpu);
> +
> +	resctrl_online_cpu(cpu);
>  	mutex_unlock(&rdtgroup_mutex);
>  
>  	return 0;
> @@ -969,7 +969,7 @@ static int __init resctrl_late_init(void)
>  
>  	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
>  				  "x86/resctrl/cat:online:",
> -				  resctrl_online_cpu, resctrl_offline_cpu);
> +				  resctrl_arch_online_cpu, resctrl_offline_cpu);
>  	if (state < 0)
>  		return state;
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index bd4d1c8a9b4f..ab9db7ce706f 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -4012,6 +4012,14 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>  	return 0;
>  }
>  
> +void resctrl_online_cpu(unsigned int cpu)
> +{
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	/* The CPU is set in default rdtgroup after online. */
> +	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
> +}
> +
>  /*
>   * rdtgroup_init - rdtgroup initialization
>   *
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index bf460c912bf5..4c4bad3c34e4 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -223,6 +223,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
>  			    u32 closid, enum resctrl_conf_type type);
>  int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
>  void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
> +void resctrl_online_cpu(unsigned int cpu);
>  
>  /**
>   * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid

-- 
Thanks
Babu Moger
