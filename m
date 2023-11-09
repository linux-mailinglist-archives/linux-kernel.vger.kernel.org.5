Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664BF7E7314
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjKIUvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjKIUvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:51:38 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398D43253
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:51:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmMAS1Z19Eyx+UIBCCjt7rvSaoH/1nETpXTLb8Ze1EZKmGI2Xg3yuasja6Y4Zxnd47YfHVey/hVnpwKNe/NLLZp8JetwLkFpH7JuuCmprfEfRNUgjS/63fnjKikT8cG1ooKzRUhNWN/ibF22XdrTFB4CsGFQXDQMMYF2EYllT5LEvG9/3JbanLYgTHTN89hmYdlDlE6e9KfcFqDqqd+69kO9xpSHI4zetuj2r67Q+Gwz2b3B7NsF+M0VvCuAu5K9J5IC7P8m1FfqNuxMa0WLK/HBqiRlqdvSqVIB7LNmdKgddzEjOCv4XusJNxTcdaAj6LmbsbR6cjWwIQHKQajjCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/g0M2e2afjW4IvXU9vk8sDiEP4w3jCprCkr6K9aJTWQ=;
 b=XcQLORLIJYTy6XadYGDVicySdfYvcVr7EnvsHaISV/ijFdNDmkuGFv6GuD7QkffAljnWGkMWFfPawRf2RI/ZK28xowpbijRjiEOmW6JMWlIdi953El4Aav996J82e6FU4LaJ0a1Kj4+oGpiMYLKJCuwJYxyf5LF59GLA+EN4+3Tebn8DBaI+vctn9OTuzRU1jG9XrP9rzrrwyWBjqK7fheEYwdzxsq+hTaxcH+vZK4HNo4IBXiZ7K9YodqXRDIVelnklJZynr/CybAnedomOKPcVgKUmV7Bz+aZSojajcWGCr9+JEd+DWxq+VO6/aOGYcHrWcLXN7ITpOGYiitHd3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/g0M2e2afjW4IvXU9vk8sDiEP4w3jCprCkr6K9aJTWQ=;
 b=fwOhG6LBg7FtHX7jiStqB/PI6kU8Jz4Z8TRkM9gcpwqFS88dCwpRj5WuiPu+qkUWHIAZ4RKxgScmQPhjLDshC14Trv4x1VZO3WrTLXbz89XUdr58+CR/0qDIPOiIVc46NJKHThWxGOYhKsqJ1o8p0MYkYmCH+CmoxWwQpAhGH54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 20:51:33 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 20:51:33 +0000
Message-ID: <5e3cc44f-5492-4dc0-a585-b58caa1e27d4@amd.com>
Date:   Thu, 9 Nov 2023 14:51:30 -0600
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v7 19/24] x86/resctrl: Add helpers for system wide
 mon/alloc capable
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
 <20231025180345.28061-20-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231025180345.28061-20-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0090.namprd12.prod.outlook.com
 (2603:10b6:802:21::25) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: a64b03c8-91d3-46b6-0a78-08dbe165a833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tcsNY3sZMEy4vIswQ9sLpHyzng8Sz4vq77s+kGHK8RRSSMJe7vxs9cagNeBpbkhyaEH6u1N3ahnd4lSipkcJzqSOoJgcGsZiRT6DGF8Lcbr3eivxdxSrjEd7pW+M4G0QQQivDxnMrV82lIb4nA3ohIyttbmx/7v/mgx6QQ4It2Bt3iWMqivkqWgZClDg9Oae6lImLfayQr1XFdvfsTpn2n4G5HgrOut2ivw2f8vEhs1g3+yLo0P9aYS0b40I0QusjecKyqSes0cb8y44BNgmT8+FDOGaWEA7qqLDGS14jqFIf08arPM2MZu0l9HYwGIaoJ8yggcBHan/diufI8NArH0/r+NpEdrEAOQ8Os1164QVx0hOI2cvMElCTauktwxEHQRaAbs+fqMSuMqSne0Q5ntIzc25atsWJPZSIvepGo9n52IsStiv6lN+QEBu/oIKxUUkYSeKvXmCM4hpELTVvQlYGLdSX4/KUlkVFi4wj8AGLEZEgYDgy8R32BLlFhd4yaCbgHoKudHiXJtKN/e4OhPvDIg7LZ3zTGLYpW5ngxYAKDb5fjCdZtvwRMWfkPpqqpXus4KU1nZGZZSQHJvob9fl7lm7iW6NBhj3hFDz08TU2o6FRTCxV8X/i0kCxGAuzEhpOg7/5s7J37QVrIDqbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66556008)(66476007)(54906003)(66946007)(53546011)(31696002)(26005)(36756003)(2616005)(6512007)(316002)(38100700002)(83380400001)(6506007)(86362001)(6486002)(478600001)(4326008)(2906002)(8676002)(8936002)(30864003)(41300700001)(5660300002)(7416002)(3450700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dy9TRkFqZW1vbzV2SGFMMzd4WW5ZZ28rTVRPSEhMNjJxcVlFN1RoZFl1Y1BK?=
 =?utf-8?B?LzQvUGk1dDFKdFUzbnBZTVBRVWxPNWxWU0Z4YlVlb2RiSVNRU25XVlNhUC9X?=
 =?utf-8?B?K3BLU2FiWHplcFdPb2Juc2xhZDdyQk12Q0E1TDJGNzRwT3NqUWtEa3NFM1VY?=
 =?utf-8?B?Uk1pbVpQSTVocHZkNHRVZjk2NTdHK0ZYZUgwajdXZFB5WHNlK0VubW1UQ3Zn?=
 =?utf-8?B?bjE2UEM1VGE0cjNYeEZzTlBDODByRnFTTnltTDJCcTVpbXdGVENnc1FIMGxU?=
 =?utf-8?B?UU9jNDNtdFk4SWVhb2cvNTk4OERIYXNFZk5Xd21LcHdrKzl3d1RmYWtlWGxL?=
 =?utf-8?B?cGpGY3lnZlIwb0VySGRxY09KVWRBZDFLUURxZ3hFWDBlZVZGZ04zRkkyV0lG?=
 =?utf-8?B?ZFFNa3VyZm94WnQvdWp1YWlRSUVROFVvUisvZkwwcS9tNjJ3c2t4dkhRRU9R?=
 =?utf-8?B?NkFydFhkSHpiVVBVSmpJc0FBS2lrdk1wU2draEdzNXBuRWVyUldXOTBqR1Bo?=
 =?utf-8?B?UHQvWkdGNVBWNjJiRkdvSTFaVFJpRTBCWWdsdW9DTGxhd0ZZRzZJdEUrVzQr?=
 =?utf-8?B?MzlYOGhCbE9hMDdJc0xrQ0Jjb2E1bGhuMDA0TndhS2lITzl6WlhyUkhKNUxT?=
 =?utf-8?B?OFlwcVpVM3Y0ZHFhb21laFcyVlhxTFpsb3JSZy9vWC9SWDFGR3JVYXRWeEwv?=
 =?utf-8?B?Y0krcWZJV3dxUmpmSk1pb0IvYVYwZTQzWlZrRDhZSG5RMjhPSVFlQ29qeklH?=
 =?utf-8?B?cnB4UHRuOWc4QUpDZU1JZ3UycHpoWXpWRTJHWU9OVnhJeVFrRVdiUXRQSWEw?=
 =?utf-8?B?b2tsR3p2Y1NGVWUxNmhvNkR5b1VvUVl4b3lwYjZ2YytsenpFaHhwTG1HcmVi?=
 =?utf-8?B?U1dmdUxscTFFVDJXSUFFK0tBcU1sY0JZcVBLdnUwVThKVm1QRnJWQVgwdVdX?=
 =?utf-8?B?TFZtS2ZaVldETjFvTFRwa1VJMTlEbTlvdmNzeVVwV1prS3Rqb1hvdXpVNVNj?=
 =?utf-8?B?WGpqR0FjUXJTQ2JDaFNPMUVQbHFFY293aXNwbVEvZVdlV0pFV2ptcTkyQkZl?=
 =?utf-8?B?ZkU5L01BL0NpR2phZ0VrdVZQeU5tTktqZnB4QjFZSks3ekNsUkdtRENPZ2pW?=
 =?utf-8?B?em9WUHUzS1ppcVRJWmpIekw4UWpRV2JXTGMybVVLSTF0RzJiM3FEckx0OStv?=
 =?utf-8?B?QisrSXNxNmlUMm5TWFlMNGNzc1ZZVTEyMDB4c3YyZDl5RCs4ZmZBeTJSSEU5?=
 =?utf-8?B?ZFA1a2JuVytIOVlyaDdzT1hxVkl2TjJMcUVxQnFyMTkxcmtSM3h0YnRSRVo1?=
 =?utf-8?B?RS9WNjVWTXVxNm9hL05oeFdROThCaVRxd25USVIreUNTVmhQM1lhNzZLVWV0?=
 =?utf-8?B?aXc3azVwdysvbmUzdDlNL1hzSXRDTDFNV3FWTTFsdGZiV3B5NDlQRzcyc2Zz?=
 =?utf-8?B?SE8zTk5LeU5VSW52MXk1citzTHFvdDhCYXp0Z21KdWpuRmFYcjZQakRhb0Jy?=
 =?utf-8?B?UW1FOTdtNGlUaWYvUUc5NGY1QncySFdxOUY0WDB4YkFBQzVDQVdIeUxLd2E5?=
 =?utf-8?B?anZzSExNcWREYWYvUjA3eVZjZkNCUlI2NDNRUFhLaEhqM3JVZFRLVDY5N1pI?=
 =?utf-8?B?SXVVMld1TEUvcUtMZ25DMllIMUJoQ3lOOWQxbjlYSHoyVjhRamdhaWhrYnFC?=
 =?utf-8?B?cFl2RHdaSG5PeU4yVFZPSEFTV3FRS2pZSTU0anFTeEpwRVR5cW42RFlkV0F4?=
 =?utf-8?B?cGNKcEloN09pNFRxSkVqV2ZaN3dlVjRyRGMvdkVzZzAzOWU0MTBjM3FWbU5S?=
 =?utf-8?B?aElXQ0xGMjNaKzFGa1MzQlJZckR2cVVKODBWbTA0aXlHVVlPaFQyZ0NJME8x?=
 =?utf-8?B?Rng0bmFGK3hEZXJjczhZTGRBUVVsdWVMYzg5OUl1cjQ2NjB4aU91VDBNR2tx?=
 =?utf-8?B?S1IxTmtLMGZ2MHlFeWRGWkFTMXoyNG9jdndvQlRKOGI2dXdwNk8xSDB5elc2?=
 =?utf-8?B?cUdhK3h5SEdxTCtvNlBGMEdQT2g5UkJKRVBUakh6Ykl2cWQ1amJ6VDRKemdE?=
 =?utf-8?B?c2EvcnpSeE1hbE5Xd21FNjF1RWxKTDlJeVRJd0phYlRDQzBpU0RYTzlxTTdl?=
 =?utf-8?Q?LMnI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64b03c8-91d3-46b6-0a78-08dbe165a833
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:51:33.4372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9JZf9P2cEBpRO4OUV3y/MrB60P0IvRVRLTbaDPthGmZoiW3PNnr6QO5PuJBzAZg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Thought you are replacing all rdt_mon_capable with
resctrl_arch_mon_capable. But, you missed few.

1 rdtgroup.c rdt_get_tree             2640 if (rdt_mon_capable)
2 rdtgroup.c mkdir_rdt_prepare        3420 if (rdt_mon_capable)

Any reason these are not replaced?

thanks
Babu


On 10/25/23 13:03, James Morse wrote:
> resctrl reads rdt_alloc_capable or rdt_mon_capable to determine
> whether any of the resources support the corresponding features.
> resctrl also uses the static-keys that affect the architecture's
> context-switch code to determine the same thing.
> 
> This forces another architecture to have the same static-keys.
> 
> As the static-key is enabled based on the capable flag, and none of
> the filesystem uses of these are in the scheduler path, move the
> capable flags behind helpers, and use these in the filesystem
> code instead of the static-key.
> 
> After this change, only the architecture code manages and uses
> the static-keys to ensure __resctrl_sched_in() does not need
> runtime checks.
> 
> This avoids multiple architectures having to define the same
> static-keys.
> 
> Cases where the static-key implicitly tested if the resctrl
> filesystem was mounted all have an explicit check added by a
> previous patch.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---
> Changes since v1:
>  * Added missing conversion in mkdir_rdt_prepare_rmid_free()
> 
> Changes since v3:
>  * Expanded the commit message.
> 
> No changes since v6
> ---
>  arch/x86/include/asm/resctrl.h            | 13 +++++++++
>  arch/x86/kernel/cpu/resctrl/internal.h    |  2 --
>  arch/x86/kernel/cpu/resctrl/monitor.c     |  4 +--
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  6 ++--
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 34 +++++++++++------------
>  5 files changed, 35 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index b74aa34dc9e8..12dbd2588ca7 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -38,10 +38,18 @@ struct resctrl_pqr_state {
>  
>  DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
>  
> +extern bool rdt_alloc_capable;
> +extern bool rdt_mon_capable;
> +
>  DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
>  DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
>  DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>  
> +static inline bool resctrl_arch_alloc_capable(void)
> +{
> +	return rdt_alloc_capable;
> +}
> +
>  static inline void resctrl_arch_enable_alloc(void)
>  {
>  	static_branch_enable_cpuslocked(&rdt_alloc_enable_key);
> @@ -54,6 +62,11 @@ static inline void resctrl_arch_disable_alloc(void)
>  	static_branch_dec_cpuslocked(&rdt_enable_key);
>  }
>  
> +static inline bool resctrl_arch_mon_capable(void)
> +{
> +	return rdt_mon_capable;
> +}
> +
>  static inline void resctrl_arch_enable_mon(void)
>  {
>  	static_branch_enable_cpuslocked(&rdt_mon_enable_key);
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 68b9beed8e42..c4c1e1909058 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -138,8 +138,6 @@ struct rmid_read {
>  	void			*arch_mon_ctx;
>  };
>  
> -extern bool rdt_alloc_capable;
> -extern bool rdt_mon_capable;
>  extern unsigned int rdt_mon_features;
>  extern struct list_head resctrl_schema_all;
>  extern bool resctrl_mounted;
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 843df6f64e0e..87379d2a339c 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -841,7 +841,7 @@ void mbm_handle_overflow(struct work_struct *work)
>  	 * If the filesystem has been unmounted this work no longer needs to
>  	 * run.
>  	 */
> -	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
> +	if (!resctrl_mounted || !resctrl_arch_mon_capable())
>  		goto out_unlock;
>  
>  	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> @@ -878,7 +878,7 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>  	 * When a domain comes online there is no guarantee the filesystem is
>  	 * mounted. If not, there is no need to catch counter overflow.
>  	 */
> -	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
> +	if (!resctrl_mounted || !resctrl_arch_mon_capable())
>  		return;
>  	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
>  	dom->mbm_work_cpu = cpu;
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index d8f44113ed1f..8056bed033cc 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -581,7 +581,7 @@ static int rdtgroup_locksetup_user_restrict(struct rdtgroup *rdtgrp)
>  	if (ret)
>  		goto err_cpus;
>  
> -	if (rdt_mon_capable) {
> +	if (resctrl_arch_mon_capable()) {
>  		ret = rdtgroup_kn_mode_restrict(rdtgrp, "mon_groups");
>  		if (ret)
>  			goto err_cpus_list;
> @@ -628,7 +628,7 @@ static int rdtgroup_locksetup_user_restore(struct rdtgroup *rdtgrp)
>  	if (ret)
>  		goto err_cpus;
>  
> -	if (rdt_mon_capable) {
> +	if (resctrl_arch_mon_capable()) {
>  		ret = rdtgroup_kn_mode_restore(rdtgrp, "mon_groups", 0777);
>  		if (ret)
>  			goto err_cpus_list;
> @@ -776,7 +776,7 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
>  {
>  	int ret;
>  
> -	if (rdt_mon_capable) {
> +	if (resctrl_arch_mon_capable()) {
>  		ret = alloc_rmid(rdtgrp->closid);
>  		if (ret < 0) {
>  			rdt_last_cmd_puts("Out of RMIDs\n");
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index edfb37680046..bd4d1c8a9b4f 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -641,13 +641,13 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
>  
>  static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
>  {
> -	return (rdt_alloc_capable && (r->type == RDTCTRL_GROUP) &&
> +	return (resctrl_arch_alloc_capable() && (r->type == RDTCTRL_GROUP) &&
>  		resctrl_arch_match_closid(t, r->closid));
>  }
>  
>  static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)
>  {
> -	return (rdt_mon_capable && (r->type == RDTMON_GROUP) &&
> +	return (resctrl_arch_mon_capable() && (r->type == RDTMON_GROUP) &&
>  		resctrl_arch_match_rmid(t, r->mon.parent->closid,
>  					r->mon.rmid));
>  }
> @@ -2650,7 +2650,7 @@ static int rdt_get_tree(struct fs_context *fc)
>  	if (ret < 0)
>  		goto out_schemata_free;
>  
> -	if (rdt_mon_capable) {
> +	if (resctrl_arch_mon_capable()) {
>  		ret = mongroup_create_dir(rdtgroup_default.kn,
>  					  &rdtgroup_default, "mon_groups",
>  					  &kn_mongrp);
> @@ -2672,12 +2672,12 @@ static int rdt_get_tree(struct fs_context *fc)
>  	if (ret < 0)
>  		goto out_psl;
>  
> -	if (rdt_alloc_capable)
> +	if (resctrl_arch_alloc_capable())
>  		resctrl_arch_enable_alloc();
> -	if (rdt_mon_capable)
> +	if (resctrl_arch_mon_capable())
>  		resctrl_arch_enable_mon();
>  
> -	if (rdt_alloc_capable || rdt_mon_capable)
> +	if (resctrl_arch_alloc_capable() || resctrl_arch_mon_capable())
>  		resctrl_mounted = true;
>  
>  	if (is_mbm_enabled()) {
> @@ -2691,10 +2691,10 @@ static int rdt_get_tree(struct fs_context *fc)
>  out_psl:
>  	rdt_pseudo_lock_release();
>  out_mondata:
> -	if (rdt_mon_capable)
> +	if (resctrl_arch_mon_capable())
>  		kernfs_remove(kn_mondata);
>  out_mongrp:
> -	if (rdt_mon_capable)
> +	if (resctrl_arch_mon_capable())
>  		kernfs_remove(kn_mongrp);
>  out_info:
>  	kernfs_remove(kn_info);
> @@ -2949,9 +2949,9 @@ static void rdt_kill_sb(struct super_block *sb)
>  	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
>  	schemata_list_destroy();
>  	rdtgroup_destroy_root();
> -	if (rdt_alloc_capable)
> +	if (resctrl_arch_alloc_capable())
>  		resctrl_arch_disable_alloc();
> -	if (rdt_mon_capable)
> +	if (resctrl_arch_mon_capable())
>  		resctrl_arch_disable_mon();
>  	resctrl_mounted = false;
>  	kernfs_kill_sb(sb);
> @@ -3331,7 +3331,7 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
>  {
>  	int ret;
>  
> -	if (!rdt_mon_capable)
> +	if (!resctrl_arch_mon_capable())
>  		return 0;
>  
>  	ret = alloc_rmid(rdtgrp->closid);
> @@ -3353,7 +3353,7 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
>  
>  static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
>  {
> -	if (rdt_mon_capable)
> +	if (resctrl_arch_mon_capable())
>  		free_rmid(rgrp->closid, rgrp->mon.rmid);
>  }
>  
> @@ -3526,7 +3526,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>  
>  	list_add(&rdtgrp->rdtgroup_list, &rdt_all_groups);
>  
> -	if (rdt_mon_capable) {
> +	if (resctrl_arch_mon_capable()) {
>  		/*
>  		 * Create an empty mon_groups directory to hold the subset
>  		 * of tasks and cpus to monitor.
> @@ -3581,14 +3581,14 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
>  	 * allocation is supported, add a control and monitoring
>  	 * subdirectory
>  	 */
> -	if (rdt_alloc_capable && parent_kn == rdtgroup_default.kn)
> +	if (resctrl_arch_alloc_capable() && parent_kn == rdtgroup_default.kn)
>  		return rdtgroup_mkdir_ctrl_mon(parent_kn, name, mode);
>  
>  	/*
>  	 * If RDT monitoring is supported and the parent directory is a valid
>  	 * "mon_groups" directory, add a monitoring subdirectory.
>  	 */
> -	if (rdt_mon_capable && is_mon_groups(parent_kn, name))
> +	if (resctrl_arch_mon_capable() && is_mon_groups(parent_kn, name))
>  		return rdtgroup_mkdir_mon(parent_kn, name, mode);
>  
>  	return -EPERM;
> @@ -3923,7 +3923,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
>  	 * If resctrl is mounted, remove all the
>  	 * per domain monitor data directories.
>  	 */
> -	if (resctrl_mounted && static_branch_unlikely(&rdt_mon_enable_key))
> +	if (resctrl_mounted && resctrl_arch_mon_capable())
>  		rmdir_mondata_subdir_allrdtgrp(r, d->id);
>  
>  	if (is_mbm_enabled())
> @@ -4006,7 +4006,7 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>  	 * by rdt_get_tree() calling mkdir_mondata_all().
>  	 * If resctrl is mounted, add per domain monitor data directories.
>  	 */
> -	if (resctrl_mounted && static_branch_unlikely(&rdt_mon_enable_key))
> +	if (resctrl_mounted && resctrl_arch_mon_capable())
>  		mkdir_mondata_subdir_allrdtgrp(r, d);
>  
>  	return 0;

-- 
Thanks
Babu Moger
