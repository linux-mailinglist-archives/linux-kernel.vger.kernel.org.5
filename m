Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFFD7E7303
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345192AbjKIUkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345194AbjKIUkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:40:40 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F607182
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:40:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/6L2LE+KODcY9rfKnNtRYV5v4VFAA0ypO+h+3UFQbphJh+M8iHphO0ixcNHfV/zIWBH1omJRIymAmIj7GglTGjvvu6y9OcYi8gcFH2lXlhlkna0/9l5xrV5qzv3BxK+eRg1PKXzk3nnmMX5NQ4An1bBxozSDPwYX0Fy5dOkc8mwUcu/tc0Kr2wDUavnnVVtnw4fcr/u5/ZGmG2f4ce77mYLPjcR+x04SGN7u/m8CbNJI97XRmDwSlOAxTeo21GNmfsjnieDNaRRBL3hTaBsHrqFI45WuALIrKmz3pl6Zf9fQuaxgLcik+ui+IzFOw4Av1kKsDi6ZVNZpJUq+ByEJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rh+BLGFJQth33CHJW4nxJgNRXuVBu/BmkFDn9ORHg6Q=;
 b=BTC88gP0sY/nTM/COMnp9bdu7o7sxFVlpnBdHSejieq/7R/KoeiSbfcOqq6TcLhAx2nb5OlnsUk9Uo68NVDfFbAfgiC5Xxcs0UPiLqgoJtyKo44307u/nMQ72yq71AerqINh/Y23IRqtAJaFu4G4J85KCamOjAjXS7CXPVpJtnEMfb6BYD5GW4Dhrw4CJ0OvxDXgcRIix+lKnEQhqmGMknOLqJwJD+5H1zKvpH8JmGXKjAY/NlDY7K4ol7x9tk9L26m8JHsDA1yVgyGqgyzobFcMxA+jKKMeY8yVQ8mBfPuxLTM5v8CNalV9/iovOe0Ppg5jChW8a+Av2/Z/ASQ8Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rh+BLGFJQth33CHJW4nxJgNRXuVBu/BmkFDn9ORHg6Q=;
 b=yEPPuWOVSiFwzbtEUKYQBUpAkU890eo+NdqctL40DGhdiVje8lyIWtXeTdR8D7IZUFJ3x4FvbQ7RWimXfGKLDA/E43MyvGzvFpR1i9Ktl+hTQlrTnwWFPgZSAHFwow5udVKH5b9kCGxi1p9pqyP4YTYBTTiukeKG+UnP8bA9Obs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 20:40:35 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 20:40:35 +0000
Message-ID: <c0cc5cfc-c22b-4a27-b512-75f2e27b59cb@amd.com>
Date:   Thu, 9 Nov 2023 14:40:33 -0600
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v7 13/24] x86/resctrl: Queue mon_event_read() instead of
 sending an IPI
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
 <20231025180345.28061-14-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231025180345.28061-14-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0029.prod.exchangelabs.com (2603:10b6:805:b6::42)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b26c7c-b137-401f-dae2-08dbe1642024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aSMWU+5IYqJ91kFx2nfjeclle+FQcP/a0DeULr7QFyb1DzrBUbuRlkmWg4TNelTJDqdZpZ3Ic5v33fg0N4x0Wutg9lPnMBDNkru4zdY023QrCNDb9poML6C3UEeEkLRAobDKy5TUrCF9NAAUyvGTF9tUWkFt2v53UV0M1flTwGP7QdolW33igCemAkhRub0aQp0Y9LXOIt8jScl7Oj/cvwwuU4ohOcz3y1zY/z0wBK9wDPiSDHROk3s/6YhuWAabH35/cAwNTY56yM/opFML1aCDIiElRRFZDKl7fPI3lgDI5P7iyyClhzies82PK3o2Anhb2hL45Dp51pDg8k5Uf1t9sqCNW0+MOd1B9b1d5dDwEo3F5sSSm2GvMFYvL5izI0EJDHjkntQb3NaRw2i0SIqPr7ubnr/U2qLxJL97NSJ03/7XB8NOID/Vz7JAV75893xRvXwVPF7SHW14JXeEELHGhJYVWKlczYcwK32rq0ziSx3FQhP3hqSzSchI5tgV0JtOpUO4NfBAeuUoeaslmplJx8vcBbQfWg867F8Uaxrs6YFFsjM0uHPUfbkUbX9ZbbGWn1EObVS3N7txrkUAZBXyeW0buOfpUcZgzPq22rBSoCIsS+UXwepRYdshRrWOS9aORWK+hUf+zHy7jI5PzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(31686004)(2616005)(53546011)(6512007)(66556008)(478600001)(6486002)(6506007)(2906002)(54906003)(38100700002)(316002)(36756003)(5660300002)(31696002)(86362001)(41300700001)(3450700001)(66946007)(26005)(8676002)(7416002)(83380400001)(66476007)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1dnOFBRcFkyRENJa3F1WFZPY2t3UExBaW1sODFWclhIK2p4SnVNdVF5NWZw?=
 =?utf-8?B?M0FQZHliUStXbXhzRkJvdndKL0FuZEI0Z1pnMHpLTXpPOE5mUjE2MjE0UFVR?=
 =?utf-8?B?RlVrZ2lRM0tlUWxjZnM1WjhJSzV4UVpYMTE4OVh1eFVlTmlKOWlIN3JUZ2Zl?=
 =?utf-8?B?Tmh3ZmVVMUpVbit3VkNvUkpTai9JbmV2K1Y5d2VybWZsT3BjREc5VTFNdFhY?=
 =?utf-8?B?NW04a0xqT0hJREFIU1hUcjRzbUlES05OMVhaR0JBUTNCOWxKam8xUE51MDdU?=
 =?utf-8?B?c1k1Nk9QU1lWS09WeTBtNWwrMjFROWR2MEw4dGJ6dGtRMEZndU1IK2NXYnhX?=
 =?utf-8?B?dHdPSnR3NEZPL1F5eWJJVVFhYWIzUWV0d3pYVnNtMjdKSUp3UDZKQXpUSks1?=
 =?utf-8?B?emJDa2FqdG1LMmkrSUs1M3hKTFp5ekNLVExuSWVRcXhQOXVteEptNnlaWkpJ?=
 =?utf-8?B?TU5KNkt3VktXUGRxejh1eEJ5UmFwMERORGhFOVk1MHVjb2ZHVUZYM1JXN1Ja?=
 =?utf-8?B?T2NUM1VEZXZHN0RNZ29QVWl5WGpleGIyQ1RObEdqSzZtSFA2RFZjY05kdWZv?=
 =?utf-8?B?N0JpZkRLaXk2VG1QZGplY3M2cUFlNzJ6NWxZRUpYeEhPdDFFWlN6Z2Vod0Er?=
 =?utf-8?B?dGw2OENoM3I1TFo2V3Z6cyt4Y0JRSEdDa3R1aGUvUVA5Ni8rV2xFbFhWbHBj?=
 =?utf-8?B?RFppbUFJYm02MWI4K1paeXY2aEtTZVZpU2JtcnFTcXIrOEs1K1JSSlJ3eDB0?=
 =?utf-8?B?Q29mckVRVUU3bkl0UkdqSG5zTGlScHBYNDBBRHozamRiaEYyenpCdjI4QmNz?=
 =?utf-8?B?Tzg4VzdvbU1QdFBHMjduN3JpSEdBQ0h0R1diTWh1Q05WeURZelpmelQySTE1?=
 =?utf-8?B?a0wvVWluWE0xa3lwUTV5U29hcUlNeFdGUXBQT2hzOEZmYXZUTUF4SDRzOHU0?=
 =?utf-8?B?U3pTaVc4d2NxNzZXWnUyUmZGemlRVE9NS2JxaExuVitKWTRSTVNqRnpwZ1pI?=
 =?utf-8?B?RnZEZnBMQ0VBcmlETjhBNHNHRnlTSTliNGgrR1QrZFV0eHE1ei9SUXhua1U5?=
 =?utf-8?B?RGQ2OHI1TmRmUVFOeXh0SklOTmk2REkrUVJUSkJsMkRsa3E3TDRTUEcraDFQ?=
 =?utf-8?B?cWxOUWlMRDZGUVlkNEduamdIN3JUaTZzNThsTEhzQlhlY2wrWFBvTEdIMy8w?=
 =?utf-8?B?RWdUOGVTL0FLWHVaOGNFcG1wWXVwdmZUNGNIL3dsY0hWaHlZZlBhWk9VdExD?=
 =?utf-8?B?UXlCUHpmMzN0cUdxT0xsWUdpOFhGSnVtOE5iTitCSGpkeStNakhPZTdNUVNt?=
 =?utf-8?B?NExpbjdWMjRuVUMyK1hZMjR4clM2NTM1ZE96T2RyL3IvL01TaE5EN0gwcnJ0?=
 =?utf-8?B?MnpVUmdwaXMrcEg5aGMzMXR1ODRtTWxnaTVhcVJoTVpHOVpuNGwvTVdTc1lH?=
 =?utf-8?B?c0Z3MW9pL3JobFZCOEdFcVhRSHlta25EckRRRGdlNGNpc0xHL1BTSFRrRzdo?=
 =?utf-8?B?b2t0Z3Y4dTBaOHE4YW9QcTc5Qm14V25VczR2b3dMOXdLMlZoWFNpUmZJQmp5?=
 =?utf-8?B?OElVK2VxZDhSMVA0ejFlVlpQSzVVOXNkcityTUQxazJ6dnJONXhoZUlZME9p?=
 =?utf-8?B?K3V5elJuVzdOQmNxUThCclUrSnc1VThaYzlvUkxTTzE5NjhwQkNORDArMzNs?=
 =?utf-8?B?K0xZcFFTcFhFc250OE9NMjZaWW40THdGOGpUbmFqK3NXL1Z3dGYzblFKcGFO?=
 =?utf-8?B?dTlhZXdIUWpnR1RhR3QwcitqZ2lISjltaTdIdjJONGtUNXpVTUxLNUE3UUhi?=
 =?utf-8?B?Wmd4dnNGcXF1eUNLVXBIQjJlbjl6VXhRTnZPNnBkN3JtUWNXYXZONmdwcVpa?=
 =?utf-8?B?U1NuUzBGSXdtb0FVRU9XcEx5N2JWMHJVRENIUXF5QmtYWU00WVZiemtla3Zz?=
 =?utf-8?B?NU9YTjg4MkJaSVV0WVllem1qZ1AwV1MrYXEwQjFCWGoxTWNkSjUwejMzd1hH?=
 =?utf-8?B?UG5LNmFFWk5zRi95bUhybWE3OHFwa0d5WlloY2MxSTNuRURBc2NhYnBaTEZM?=
 =?utf-8?B?dTFwZTQyUEtJQ3UwUmJua2VpMlNqMmJVbzhQcnRxQUo3dUVneUhWenorcTFr?=
 =?utf-8?Q?YyTg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b26c7c-b137-401f-dae2-08dbe1642024
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:40:35.6684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uF3nqMv6wBT7gQdvz7ZpGzNF9CCEp6Yw/Pe+3pMKnGnyamSXAsIX1IEL6M+onvDd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/25/23 13:03, James Morse wrote:
> Intel is blessed with an abundance of monitors, one per RMID, that can be
> read from any CPU in the domain. MPAMs monitors reside in the MMIO MSC,
> the number implemented is up to the manufacturer. This means when there are
> fewer monitors than needed, they need to be allocated and freed.
> 
> MPAM's CSU monitors are used to back the 'llc_occupancy' monitor file. The
> CSU counter is allowed to return 'not ready' for a small number of
> micro-seconds after programming. To allow one CSU hardware monitor to be
> used for multiple control or monitor groups, the CPU accessing the
> monitor needs to be able to block when configuring and reading the
> counter.
> 
> Worse, the domain may be broken up into slices, and the MMIO accesses
> for each slice may need performing from different CPUs.
> 
> These two details mean MPAMs monitor code needs to be able to sleep, and
> IPI another CPU in the domain to read from a resource that has been sliced.
> 
> mon_event_read() already invokes mon_event_count() via IPI, which means
> this isn't possible. On systems using nohz-full, some CPUs need to be
> interrupted to run kernel work as they otherwise stay in user-space
> running realtime workloads. Interrupting these CPUs should be avoided,
> and scheduling work on them may never complete.
> 
> Change mon_event_read() to pick a housekeeping CPU, (one that is not using
> nohz_full) and schedule mon_event_count() and wait. If all the CPUs
> in a domain are using nohz-full, then an IPI is used as the fallback.
> 
> This function is only used in response to a user-space filesystem request
> (not the timing sensitive overflow code).
> 
> This allows MPAM to hide the slice behaviour from resctrl, and to keep
> the monitor-allocation in monitor.c. When the IPI fallback is used on
> machines where MPAM needs to make an access on multiple CPUs, the counter
> read will always fail.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v2:
>  * Use cpumask_any_housekeeping() and fallback to an IPI if needed.
> 
> Changes since v3:
>  * Actually include the IPI fallback code.
> 
> Changes since v4:
>  * Tinkered with existing capitalisation.
> 
> Changes since v5:
>  * Added a newline.
> 
> Changes since v6:
>  * Moved lockdep annotations to a later patch.
> ---
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 26 +++++++++++++++++++++--
>  arch/x86/kernel/cpu/resctrl/monitor.c     |  2 +-
>  2 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index beccb0e87ba7..d07f99245851 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -19,6 +19,8 @@
>  #include <linux/kernfs.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
> +#include <linux/tick.h>
> +
>  #include "internal.h"
>  
>  /*
> @@ -522,12 +524,21 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> +static int smp_mon_event_count(void *arg)
> +{
> +	mon_event_count(arg);
> +
> +	return 0;
> +}

Shouldn't this function defined as "void" similar to mon_event_count?
Return code is not used anywhere.

> +
>  void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
>  		    int evtid, int first)
>  {
> +	int cpu;
> +
>  	/*
> -	 * setup the parameters to send to the IPI to read the data.
> +	 * Setup the parameters to pass to mon_event_count() to read the data.
>  	 */
>  	rr->rgrp = rdtgrp;
>  	rr->evtid = evtid;
> @@ -536,7 +547,18 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  	rr->val = 0;
>  	rr->first = first;
>  
> -	smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
> +	cpu = cpumask_any_housekeeping(&d->cpu_mask);
> +
> +	/*
> +	 * cpumask_any_housekeeping() prefers housekeeping CPUs, but
> +	 * are all the CPUs nohz_full? If yes, pick a CPU to IPI.
> +	 * MPAM's resctrl_arch_rmid_read() is unable to read the
> +	 * counters on some platforms if its called in irq context.
> +	 */
> +	if (tick_nohz_full_cpu(cpu))
> +		smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
> +	else
> +		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
>  }
>  
>  int rdtgroup_mondata_show(struct seq_file *m, void *arg)
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 718770aea2af..fa3319021881 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -588,7 +588,7 @@ static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
>  }
>  
>  /*
> - * This is called via IPI to read the CQM/MBM counters
> + * This is scheduled by mon_event_read() to read the CQM/MBM counters
>   * on a domain.
>   */
>  void mon_event_count(void *info)

-- 
Thanks
Babu Moger
