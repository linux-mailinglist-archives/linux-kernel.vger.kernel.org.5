Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066297AF3FD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbjIZTQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjIZTQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:16:41 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87183DE;
        Tue, 26 Sep 2023 12:16:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mR8IpkoXZEAqQ2nChhot/g2u9wUSllqmXNG8OoztvspYJHHOH/UCDX+MX93LbZAwMBK6iBvelRvIVhbnsK8lwcoHbSwldogL21naiWwELLwVasaQXhPJoqrOagFNIjhzCdITZrxiXSTmZGBXPEZi1QwbWi84Hl71ma7Hkp/rE+zxhJO09y/tDMYl/yeJNkHrwsxSfLibLj/ACSL/krZP1oyDGb3Xci6CBWe3qUtEwmYn8UTwxy+nJwF1A1yDTCcb1pWuUKgcFVKZCf6SH8QOxjXDB7I9uA9Q14ZErXvkpBLsDv6kAT9aOYavDfdlnq91ioDj/5tTbQ3CV6BF92iSGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiRHeb21xzOmXAaLCzKgP/BaR61WpO3oq/M1cUjgd98=;
 b=AqWUj/elD2J2eqHhqlJqCuawyvzSFifGmIvcPjD6NKpTIKETGr8zWiaQJ3deI2c4AiDz7tMFycE9D3pWfonbXIr0rlQC/VNwdfqR8VANCyRXurBoNCOS8CFqmxcK3SOHF+uykOPfKxeruB+i72/429XLSku8jNh57/uWnkF+xPgsceXdZ2dkGPjTAr9MD0Q5mRg/yKaVmvBBosAMGTlecQPHk+IZiF90I3gWxsfiw8/GIMk6HRtOWPf9ET1ORf0Emcbj2ttL3I1Lw7MA2M3pwdJfkeBAEn4RjVDGBq/ANv9B67lFbsKyj7VLW+SFkWO+nY/k4b3uOAUI9mxg1oKlrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiRHeb21xzOmXAaLCzKgP/BaR61WpO3oq/M1cUjgd98=;
 b=ylUm8rUuN/eySA4WberS1lm8AkGL7JdU2BdWC8YQpH8Jzct1D9+ZaNTqLq3HDALYgE0H6Z3EyxxizanXO2tf1BTU7uoiEWeu9i8YB2dJEGu+LjdOiS35HwMOoMC/BDgzB5uL5roDI3HzyWPknEhelLjrBqSCK3m3UVGhVHXFSvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB6610.namprd12.prod.outlook.com (2603:10b6:510:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 19:16:28 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 19:16:28 +0000
Message-ID: <ceff3d3a-92a2-2e67-76a1-da5639f91162@amd.com>
Date:   Tue, 26 Sep 2023 14:16:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 6/8] x86/resctrl: Sub NUMA Cluster detection and enable
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-7-tony.luck@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20230829234426.64421-7-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0008.namprd12.prod.outlook.com
 (2603:10b6:806:6f::13) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: 01776349-d7d5-471e-9abd-08dbbec51563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1fNzk2Q9jKq7c97UwxZieqZIfxQRNSNrN1JbsNS1b25HBe87NJmWX+0z0JH2DB0NxZq0/yGLj2yepNDtb2CFDdb5n4poVdkDcMspvllzYP4sBUaLcOgrcg6tKvm1bdWGBcdcLcyYxSkAlTY0ecOXit3+/PzKTVP/YG3Z/ZQeVdYg1iVpPT48bESHcLVXC6TfermlDEDfKAXh2DqdT5RNC+NeAyMTGp9aXQV5e+I+QAEcIG6F9lixY6DDkEs6KW8huGyZT3JoBGGgOU6NdFU26YCJeeWa9s5Q0b+hLUGxSXtKyLLjQ932nWHOMBNNpk9YRh6Yk2xm9Uvi4Sz8HGo+uTReaJuQ19ahra+v8u5bGJNgkEhlaRSVqjkaImoCt+ioRtPRJd2TlZtceNv/hGxExNtc+4cJ2OWiJWE5umcdajqMwkcpEwjA2g2kWf3Js7vg5t5hlCbDGlITCbscZ3wjk2BoqtmWRY04Ctn7qZ9CcCCha2wtBK/dXxVq9yK2XjNDIKOxsTPsCAwxVMABC07cdYgiZRHugUvy+G07sb5vthxhtgmeZd09K6DgCHu7RK0p1kA9hq8GLnQj4/JSuq71E9fspAVJQwsF0RBeP6P8fy5y8aUBzjpU7tqrgvlpR+UfSxsejD+z33owbDhMfvMSBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(366004)(346002)(230922051799003)(186009)(451199024)(1800799009)(8936002)(4326008)(8676002)(110136005)(5660300002)(31686004)(7416002)(41300700001)(83380400001)(66476007)(53546011)(26005)(316002)(66556008)(54906003)(6512007)(66946007)(38100700002)(6666004)(2616005)(6506007)(36756003)(31696002)(6486002)(2906002)(478600001)(3450700001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHgzUDM2b2NhbjI0VnJSQjdvY0s5S2NtZU12NmdrME1wVzdqTTJRUDhQeGhy?=
 =?utf-8?B?YXg3SjlONUVwVytWc3ViWWJkU1Vyb0p4Zk91SHpGK1pyNk9UeDZxMVJnajgr?=
 =?utf-8?B?TFpPY1RZeHZaVFg2N2VCZHRTRm1DK1JrYjNOQmlvUGxnNGZDVXV1U0F2YlF0?=
 =?utf-8?B?eU82L1NLQzkybjlpL0VmZnhnSExKRnUyTytTNDlMR0ZnNnhaeU94VHBkNXhx?=
 =?utf-8?B?SGF0RlRNN2Y3QlMvdmJITnNjUEhFN0xyTHVGN3ZlTytmdldNVDRybjZGbHQ1?=
 =?utf-8?B?MlNRLzhZZVhtTmtDalc2Y3doRFJ2ZjUrZFNkcC9DTGlXaURlaGYwRS9zV0U5?=
 =?utf-8?B?NkpNb0paMkNBYmVCRjc0eVpYMVF2VjhDY20wWUZjNnN5NnFiazQ4TjFpOGpT?=
 =?utf-8?B?TWxCQk5Bbm9xMU1OM1FnV05ZK3lkdnEydlp3S001QVVJMEhYclNWTTVMMWpG?=
 =?utf-8?B?aW51ZmFvTlJtTkhrNzNsKzc3cklqT3FDNWJkbk1ObmhUNVJ1anpWM1VsT0hi?=
 =?utf-8?B?T1A5SUdROXFNbmRUTjZ1TzY3V3BJejIyeGZ5MlArZDFMTFNWdGJwcUx1N0tB?=
 =?utf-8?B?QjVtREl0RE9TK1Z3dHhPajBiM0hDRUNlQlc4WGNTRTh2aFU1RHRFYWs3N29q?=
 =?utf-8?B?TWxlZVJ4amYyc1p2eHlGL2RPWWRqT2JjclVyWlh3MEpxOGxnNk9mc3ZtOEVv?=
 =?utf-8?B?aUxDUjNld05zS1RlUTFURXFhaFJOK2swTER1NjQ1eDBrUGEzZXV5Y2lubFFt?=
 =?utf-8?B?RnZBOVpFRWMzUkcvVmVFZ3lRNHI3MDFuTTRWOERXZWxaYjNINjIwNFFPNVEv?=
 =?utf-8?B?dFVldUlIenNFN0gwMTIvaGRqd2VTLzFxd1Jla3B4YTNXYU0vY0J2a1FvSENm?=
 =?utf-8?B?SWNMWFBaa1JpL2FzaHc1dk5mSGh3eE1lUmd0azh2dFkvYzJsbStwQ1FrcmdM?=
 =?utf-8?B?SUJaQlU3ZTlNSWtRaVYxUnpDVEhZRCtyR1hZWFZjMWp4M25aQXdSWkMwYU40?=
 =?utf-8?B?TjB3STlaTE41dmlpdjkrTU5zSnJHL3l5UDFzeFVQWmFMT1Rxb3lZVnNCVDRo?=
 =?utf-8?B?RzJ2UUtUUDlqT20xMHIyYmJlZ0k4emJ1NmRRbGtIb2s1bWt3UnJidVZLcC9l?=
 =?utf-8?B?NEhQaE5CMWJjVkpBZUt6bmxBQkozT0p4VnZNeks3ejdFYzdhWVhGeTdtVFRn?=
 =?utf-8?B?MEQ5Mzh0d3duNGhxQjIwY3p3dXVwK2pta3pZRzdYTlhFaEkzK0hOSDVrNnBX?=
 =?utf-8?B?MkdOcGFJOTREKzJ1cGNnWnJkcW5LSlNHbFhrUXY2NFpVTFRJRlFDUTZyMWlO?=
 =?utf-8?B?ZGNhSTZrWHFmalRNSGxYbFZmbkpvK1J2MmgwVDBMalBGVDRiZk9Wd2Y1R0Jw?=
 =?utf-8?B?enRlUFpnTjJjOVdvWldUVTFlZ3lxdjlGTmpiMkwvZzc3WStzOWVzZ2xHK0p6?=
 =?utf-8?B?amNDQWhkVG04Um5kTzdXQzYzakJpSGU0NnBsZXhVY2RHeThGSjJlNE42aTFh?=
 =?utf-8?B?dy9ndDlWQUlDQ2dSSC83VXZaK0phTy9US0MrMHNLVGJPeWtBWm1kR2R1VXM0?=
 =?utf-8?B?Wm1XME1JNHhoSENzOENCM012R2h2a05KMk13Yy9meCtsck9IQnAycGJDOTdZ?=
 =?utf-8?B?YnFSNlllSFV4d3BldnV3M3FBTWVlZlpNWDVCSmkzRkIvWDA0TnZ1NTJBS3Z0?=
 =?utf-8?B?Q3NyL05ZemNMQWVRNVhxTlhCYXlOL0N3WHNuc1JQbElPT1BCTDR0VzNKeVpH?=
 =?utf-8?B?ZXI1c0tkdUoxd25TUytxQXdHaGJyTHZKTW43UUx0dHBialhuQXhVQXpHalNE?=
 =?utf-8?B?VS9BZWQ4VDhlaHJlMWFYaGV5UkFmRHhGREFINGxNZVB1eVFGclJPY1NHMGdz?=
 =?utf-8?B?SEZwa1UzUXorVW5teXg0VU1rbjhkMFZXL0Y0NjBFdk5UanNNbjZCbXFhanJz?=
 =?utf-8?B?TzJ6YmdlTDFqcWN5WTd0aGhjRkloNmphRjQxbWxiVVVWaDZIRE9aendFb2tl?=
 =?utf-8?B?aDFWWTFXWnc2eXlzVGxBVEozUDREWitQS3RzRXJzc2RKUU5PTlRnR25BOGkz?=
 =?utf-8?B?VGI3MW1INTRvc2wzTVJYa1g0QVdpWkdTa3BXajJXK1RSdWNraWdCRTZ1d3h6?=
 =?utf-8?Q?mMfM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01776349-d7d5-471e-9abd-08dbbec51563
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 19:16:28.1077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbZPKOCH7kBQlfsK7Wm3xvHyVs5fU1oN5wnCnuhBAuGJcsbmbJSyzSQSeX4Ay9rc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6610
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 8/29/23 18:44, Tony Luck wrote:
> There isn't a simple h/w bit that indicates whether a CPU is
> running in Sub NUMA Cluster mode. Infer the state by comparing
> the ratio of NUMA nodes to L3 cache instances.
> 
> When SNC mode is detected, reconfigure the RMID counters by updating
> the MSR_RMID_SNC_CONFIG MSR on each socket as CPUs are seen.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/include/asm/msr-index.h   |  1 +
>  arch/x86/kernel/cpu/resctrl/core.c | 68 ++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 1d111350197f..393d1b047617 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1100,6 +1100,7 @@
>  #define MSR_IA32_QM_CTR			0xc8e
>  #define MSR_IA32_PQR_ASSOC		0xc8f
>  #define MSR_IA32_L3_CBM_BASE		0xc90
> +#define MSR_RMID_SNC_CONFIG		0xca0
>  #define MSR_IA32_L2_CBM_BASE		0xd10
>  #define MSR_IA32_MBA_THRTL_BASE		0xd50
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index ed4f55b3e5e4..9f0ac9721fab 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -16,11 +16,14 @@
>  
>  #define pr_fmt(fmt)	"resctrl: " fmt
>  
> +#include <linux/cpu.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/cacheinfo.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/mod_devicetable.h>

I didnt see the need for this include.
>  
> +#include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
>  #include <asm/resctrl.h>
>  #include "internal.h"
> @@ -724,11 +727,34 @@ static void clear_closid_rmid(int cpu)
>  	wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
>  }
>  
> +/*
> + * The power-on reset value of MSR_RMID_SNC_CONFIG is 0x1
> + * which indicates that RMIDs are configured in legacy mode.
> + * Clearing bit 0 reconfigures the RMID counters for use
> + * in Sub NUMA Cluster mode.
> + */
> +static void snc_remap_rmids(int cpu)

While adding the new functions, i see that new function names start with
resctrl_ prefix.  However, we are all not very consistent. Can ypu rename
this function to resctrl_snc_remap_rmids?


> +{
> +	u64 val;
> +
> +	/* Only need to enable once per package */
> +	if (cpumask_first(topology_core_cpumask(cpu)) != cpu)
> +		return;
> +
> +	rdmsrl(MSR_RMID_SNC_CONFIG, val);
> +	val &= ~BIT_ULL(0);
> +	wrmsrl(MSR_RMID_SNC_CONFIG, val);
> +}
> +
>  static int resctrl_online_cpu(unsigned int cpu)
>  {
>  	struct rdt_resource *r;
>  
>  	mutex_lock(&rdtgroup_mutex);
> +
> +	if (snc_nodes_per_l3_cache > 1)
> +		snc_remap_rmids(cpu);
> +
>  	for_each_capable_rdt_resource(r)
>  		domain_add_cpu(cpu, r);
>  	/* The cpu is set in default rdtgroup after online. */
> @@ -983,11 +1009,53 @@ static __init bool get_rdt_resources(void)
>  	return (rdt_mon_capable || rdt_alloc_capable);
>  }
>  
> +/* CPU models that support MSR_RMID_SNC_CONFIG */
> +static const struct x86_cpu_id snc_cpu_ids[] __initconst = {
> +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X, 0),
> +	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, 0),
> +	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, 0),
> +	{}
> +};
> +
> +static __init int get_snc_config(void)

Same comment as above.

> +{
> +	unsigned long *node_caches;
> +	int mem_only_nodes = 0;
> +	int cpu, node, ret;
> +
> +	if (!x86_match_cpu(snc_cpu_ids))
> +		return 1;
> +
> +	node_caches = kcalloc(BITS_TO_LONGS(nr_node_ids), sizeof(*node_caches), GFP_KERNEL);
> +	if (!node_caches)
> +		return 1;
> +
> +	cpus_read_lock();
> +	for_each_node(node) {
> +		cpu = cpumask_first(cpumask_of_node(node));
> +		if (cpu < nr_cpu_ids)
> +			set_bit(get_cpu_cacheinfo_id(cpu, 3), node_caches);
> +		else
> +			mem_only_nodes++;
> +	}
> +	cpus_read_unlock();
> +
> +	ret = (nr_node_ids - mem_only_nodes) / bitmap_weight(node_caches, nr_node_ids);
> +	kfree(node_caches);
> +
> +	if (ret > 1)
> +		rdt_resources_all[RDT_RESOURCE_L3].r_resctrl.mon_scope = RESCTRL_NODE;
> +
> +	return ret;
> +}
> +
>  static __init void rdt_init_res_defs_intel(void)
>  {
>  	struct rdt_hw_resource *hw_res;
>  	struct rdt_resource *r;
>  
> +	snc_nodes_per_l3_cache = get_snc_config();
> +
>  	for_each_rdt_resource(r) {
>  		hw_res = resctrl_to_arch_res(r);
>  

-- 
Thanks
Babu Moger
