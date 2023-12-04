Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3681D804258
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbjLDXFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbjLDXFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:05:12 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D8B1A7;
        Mon,  4 Dec 2023 15:05:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTJAwI37IoF86/KBoqw713y8o+zsIlTn/h4QQWoCiERgFlSz9TILCUyO8B7HPebBylXxvF+aGVAOT1QzxlhlKwjhu1p89/fB3xp+sIddwnd+SoZz62nVs6eB//XfCeE5O7hrZmf+WXaFbgyF3lZp34M4Y8g05Xd4/oGlJcf2UMl7qqNy9cUFaDr+RPxh+v1KggXGvld2PMmRsJen0LGjRHH4Vxv2SG0duvi5YhnBewLGiP9W8mDg9kKVXXcTN1Yn5X8glSduGYFLBv4ilkzDUAcKWnl0HByKfEMYhK1xA8lO72oZy+BhxHcIxzRvDn7aQDfTBefpZSp4TgCIVZCrrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TksUqQtaZbhzqcxZtN5IYrhPOt5NRTI9hDbY/b1FcEc=;
 b=cEtzjgNCyypc+qIIUfDs8XD+CxMMoYVxtNIVXPF7K0eWJ92tdHGLn5GCv2fS1SprDUn+D8DHakVZuWTKaWkLecAfM8RDr1Lo1V5QDfr5A8K3g18g17UmEC23bE0oKxTydBtkXr6qqgUttxFPXBYtUiPI3g3r0jZvHDxIvt9glRp2Uw+GNPtbt0WW+IWr5K/Fs4vfATqxdskPR47/7WfBdW3w3DJtwHRs8RosazT+YUz3jGhPS/LGVgLiVN8bd8woP1cR5WkoUZnbVoKkRzzp0jzN4wECrN07c/T/IYulWulDd5Bg2iarIUhL8w32b/AJmh7Ooa7CT6ZrjUIGanmVlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TksUqQtaZbhzqcxZtN5IYrhPOt5NRTI9hDbY/b1FcEc=;
 b=fDJr3Zu5fEEz21TeYk2gJvkgn04U5a77CWoP1QOyPimfpWWf3DpHm/rzp5yiX3JN++ZMQWgn0KhWEhp9Kb7bu3a0jRDsz7k1g/cA/5ts3s6ZA9QVnqFTVjiwNxpnUxxLI20+Kl9eEq0eX4dyBoB+ZvXfLUT45JpNHUY+J5AX9bE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 23:04:27 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 23:04:27 +0000
Message-ID: <51f9027c-62f9-1dfc-9c67-522e00aafad3@amd.com>
Date:   Mon, 4 Dec 2023 17:04:25 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   "Moger, Babu" <bmoger@amd.com>
Subject: Re: [PATCH v13 7/8] x86/resctrl: Sub NUMA Cluster detection and
 enable
Reply-To: babu.moger@amd.com
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20231130003418.89964-1-tony.luck@intel.com>
 <20231204185357.120501-1-tony.luck@intel.com>
 <20231204185357.120501-8-tony.luck@intel.com>
Content-Language: en-US
In-Reply-To: <20231204185357.120501-8-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0171.namprd05.prod.outlook.com
 (2603:10b6:a03:339::26) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: a3189bd2-8e12-4b77-f023-08dbf51d5da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GcqXDCWD8c+xl5oE99KlZPr2w3ENSDS3TALsjPN8MQk1af+zppoi1oGlrIvDhJKV7YasmYNndJUrQmIyB2M6gYeUR2O8DmwODvpgL7mwhJVfoy6eS8ZHvI0aTybPPFTOE69EVrVPUWi9SZAD0tMWPT2LMz9BT89+usLIzdyDFYNaMNNevqJ//Cdv5XgjBvzAquUX4MIXSuydbCwZX0tU+N0WeACX3n53hDh+r6dtTOWS1BDbdDSb30uDuQAJPumfxw+ShdJW04Ytg+vHhpjdoQWcjn01oL7UFZZoIvC2pM992416ICsnHBjtAK1IJoxDRjuZrd/oTpdSsamApXb5Zgz5YrvtUC5ZUi2E+SkuCUCBy5IyeBf2I1cLSJ1wGPlCJ12QoY33pvAT0Hr6JDN2iCwbo85AMSL5sl3btxH/pVfIdV9e3yNq+GdGd0h5ErcglerqeTa4YXG4HziSwicnNSosniRfBw80d4mdcoXGYxPjP8H4uTHrtTA/vffGJMwH78t+eKW6d+/+qT4DRJ5vxjSOjyzCz+0etxOhUisS4Mw4OejIrBPmbBNbAQrbN5RrAw3NmHT5vAWT0OnhK72sCFolmIPVatJszi8z+na0mc6PWe7PxTDAH2raJmogHEXAMVKiTaYFtIedVPhje5VuqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(38100700002)(36756003)(31696002)(2906002)(83380400001)(5660300002)(7416002)(26005)(2616005)(31686004)(53546011)(6512007)(478600001)(6486002)(6506007)(4326008)(8936002)(66556008)(66476007)(110136005)(8676002)(316002)(66946007)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmlBZlpOWlZ5SWF6Q2pST3dUZ0M1Zzd2WWtoVVJZZmxNM3B5b1NzN2ZESHV4?=
 =?utf-8?B?N3VHNkc5M3JBKzFCb2NsQnI0b2lkVFBYR1lIdXBMcmdDY0xlT1ZBR2FRaitn?=
 =?utf-8?B?c1JHVllvQ1dyVURtQjU3T3RtRDNid2c1ejJWTlMzRmgwdlhoWWJtNk9wcEE2?=
 =?utf-8?B?czE5SFNEU1lidkVFS0ZPaUhqb0pXYjdnYlBLYmRPbnZFd0xWbElpcHZvZTVH?=
 =?utf-8?B?WUs4TGxjQU05bXBWOVpFc2JIUy9ZMS9vUkVuQWFHenVoQ0NNWWJ6Ylc4NUZJ?=
 =?utf-8?B?OFhkWndveEZmdzNYN1JEekEwdmpRaHNSeTF5aXRJTEprb1VvZkExa3hPWndo?=
 =?utf-8?B?MlpPRUxnODZweC9mQU1qR2I1c0NUbThkRzhuVnZSU29RU2FsQlhkZGNXRnNP?=
 =?utf-8?B?YkZWU2dBK0FHR2JweFpxTGx0S3F4MGE5SVZlODhhQ0NzQ3lUamEvbWxrVDZm?=
 =?utf-8?B?OHNIM3pCVkl0SjFwcG9OUnl5MlJZM3ByaHZkOXN1ZEZIYTlubzZWMkhiZEJD?=
 =?utf-8?B?ZjB1SVppd3UwdEpNMjRWREJRSXhQVXZQT3dvOFl3NS9zWlFUWThKT3ZROVNM?=
 =?utf-8?B?UG1ZeHprYjlzR2NJdHVhcmhSWlN3UHMwNUxmVlExYVVnMkdBSVNrM2FzQnRT?=
 =?utf-8?B?L09CeU9WS205WVArbHBxSEpSeEpnVEhacTdjVXlzRENHTDFueE5zQTlucWNl?=
 =?utf-8?B?b3RuRm1GYTB6VXNHcEZsQk5PcWpWeDBMQXJUeTZRYWhacDVHYUE5am1rVG0r?=
 =?utf-8?B?Ziszc28rVFliU1hVQzFFdVY5TDA5SGFNSGFOMlY2eUxtSEdESm0yK3N0aDQz?=
 =?utf-8?B?QWFGYStJbG12Q2tYQkx1aHArZlJ4djhyYVUzZVpHUG5RSVladXJYZDVpZTk5?=
 =?utf-8?B?Vm9QV3hqSTArYmFHeGRvSjkzRXN1ZGVsa3o5UUxMT29ISzM4ak04T0pkY254?=
 =?utf-8?B?RUhXczdjMTM1Z05wS0xHZ25pSldKWTFqajlVQjJMcFFhWm95bkZsY3l3UUda?=
 =?utf-8?B?WTdsZ0h0bkFDcDhkRlhLSEs4OUU1SHRxRmNvME55RmZpK054a2JtVFNLNUli?=
 =?utf-8?B?TGhxcEpkQVNZY1gyTFFqWWYrZ2p5Y2o3SXl3YStXMnVCcUJReHVjWS9WWVpU?=
 =?utf-8?B?SkNRUnEvdnNEdWhCdmgzb3gyQnJtc25USTc3cnZrRmlRamo0SFJEZTFSQ1Zy?=
 =?utf-8?B?WWxoTFVvM3BGbkxJTkYvOEtObzh5WnJwc1E3K3djRmQzQStqNkd5bHdrVUFF?=
 =?utf-8?B?cDBmOXZmRXVEeTl6aHBkZnFBYUxpRzQ2YXREd0hhVFVQS2dBOEhMNmliSVM3?=
 =?utf-8?B?NDVjVlpsVHpkeHRCWGNuRnRab3VzTGpGOFhxdkhUaytaZ1Z5ZWs1bjd2ZjNU?=
 =?utf-8?B?d2dYSlVwenkraDlyaG1PMjNnRGdoczZQOU9ORGlKakV1SWlKWVJDZjQwYkYy?=
 =?utf-8?B?cTlkZXEvRHFGcUlCdUJzc1VMcis2K3NTTlVwRFA2Mm8yUitSMUJPbFZDcmtl?=
 =?utf-8?B?QkNkcWpkdWdPeTlMd1lBY0ZQbTVDZ0RoSDBpVlRFemU5eDhUZ2huR0NiMnZ3?=
 =?utf-8?B?RmVzR2ZxTDJUbFFMRnlxQjhTN3VKclVUOFJmcWs3V2hnR2IwenppQUd6OE5R?=
 =?utf-8?B?UGdiVXI1djBGTzhjUUhEdnJjQXh5SEE1OFUvWWFocSt3YThmc0ZUeEVMRDFW?=
 =?utf-8?B?SWFXVG8wcHhKNU4vSy9XWFFzUzJ4YUJ2SVdLTU43elJYaEF5SzBsZ3ltWmVV?=
 =?utf-8?B?aTJVSHd5NG9JVzN1RmtEeU9tcU5JbWxHYzRrbzFiMWM4b2xxMU1hV1AvLzN1?=
 =?utf-8?B?bk5SNXNidWYyKy9KOXN6c1JmTzA3b2tGKzB0dDQ2a0dGRDRza3Vyd3BVTEhG?=
 =?utf-8?B?TXV0OFdFN05uSVBNdXN1S2VPOW80bWNpczd0ZVVTMmhjbCtQamFDbkhoZXEz?=
 =?utf-8?B?anNDNnlqbmdtc0hSQ1NYRXpkbm5YYW91Y011M292N1g1K25UU25qWUdMVnVP?=
 =?utf-8?B?VlYvSE00SEN0RkZWak9RRjVNYWd1ME4zZGEzTlE3Rmk1eHdxQkZzQ1FWTUQ3?=
 =?utf-8?B?bDVOSGFzQm1uVzN0REJnUlVNYkRWdzFyZFUrM1lMSlQ0T0hadWZNOTFLSnFw?=
 =?utf-8?Q?Vj7XeLH2Rc+BqMlMYXLoryaZV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3189bd2-8e12-4b77-f023-08dbf51d5da9
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 23:04:27.8362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7I5ZCyaWWaiavn3GeF9XCtB6/vwsWaNZdXaJmEBqnMmQKhy34/Ldoi5nojdpoBV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/4/2023 12:53 PM, Tony Luck wrote:
> There isn't a simple hardware bit that indicates whether a CPU is
> running in Sub NUMA Cluster (SNC) mode. Infer the state by comparing
> the ratio of NUMA nodes to L3 cache instances.
>
> When SNC mode is detected, reconfigure the RMID counters by updating
> the MSR_RMID_SNC_CONFIG MSR on each socket as CPUs are seen.
>
> Clearing bit zero of the MSR divides the RMIDs and renumbers the ones
> on the second SNC node to start from zero.
>
> Signed-off-by: Tony Luck<tony.luck@intel.com>
> Tested-by: Shaopeng Tan<tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Peter Newman<peternewman@google.com>
> Reviewed-by: Reinette Chatre<reinette.chatre@intel.com>
> Reviewed-by: Shaopeng Tan<tan.shaopeng@jp.fujitsu.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>


> ---
>   arch/x86/include/asm/msr-index.h   |   1 +
>   arch/x86/kernel/cpu/resctrl/core.c | 118 +++++++++++++++++++++++++++++
>   2 files changed, 119 insertions(+)
>
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 1d51e1850ed0..94d29d81e6db 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1111,6 +1111,7 @@
>   #define MSR_IA32_QM_CTR			0xc8e
>   #define MSR_IA32_PQR_ASSOC		0xc8f
>   #define MSR_IA32_L3_CBM_BASE		0xc90
> +#define MSR_RMID_SNC_CONFIG		0xca0
>   #define MSR_IA32_L2_CBM_BASE		0xd10
>   #define MSR_IA32_MBA_THRTL_BASE		0xd50
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index cf5aba8a74bf..1de1c4499b7d 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -16,11 +16,14 @@
>   
>   #define pr_fmt(fmt)	"resctrl: " fmt
>   
> +#include <linux/cpu.h>
>   #include <linux/slab.h>
>   #include <linux/err.h>
>   #include <linux/cacheinfo.h>
>   #include <linux/cpuhotplug.h>
> +#include <linux/mod_devicetable.h>
>   
> +#include <asm/cpu_device_id.h>
>   #include <asm/intel-family.h>
>   #include <asm/resctrl.h>
>   #include "internal.h"
> @@ -740,11 +743,42 @@ static void clear_closid_rmid(int cpu)
>   	wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
>   }
>   
> +/*
> + * The power-on reset value of MSR_RMID_SNC_CONFIG is 0x1
> + * which indicates that RMIDs are configured in legacy mode.
> + * This mode is incompatible with Linux resctrl semantics
> + * as RMIDs are partitioned between SNC nodes, which requires
> + * a user to know which RMID is allocated to a task.
> + * Clearing bit 0 reconfigures the RMID counters for use
> + * in Sub NUMA Cluster mode. This mode is better for Linux.
> + * The RMID space is divided between all SNC nodes with the
> + * RMIDs renumbered to start from zero in each node when
> + * couning operations from tasks. Code to read the counters
> + * must adjust RMID counter numbers based on SNC node. See
> + * __rmid_read() for code that does this.
> + */
> +static void snc_remap_rmids(int cpu)
> +{
> +	u64 val;
> +
> +	/* Only need to enable once per package. */
> +	if (cpumask_first(topology_core_cpumask(cpu)) != cpu)
> +		return;
> +
> +	rdmsrl(MSR_RMID_SNC_CONFIG, val);
> +	val &= ~BIT_ULL(0);
> +	wrmsrl(MSR_RMID_SNC_CONFIG, val);
> +}
> +
>   static int resctrl_online_cpu(unsigned int cpu)
>   {
>   	struct rdt_resource *r;
>   
>   	mutex_lock(&rdtgroup_mutex);
> +
> +	if (snc_nodes_per_l3_cache > 1)
> +		snc_remap_rmids(cpu);
> +
>   	for_each_capable_rdt_resource(r)
>   		domain_add_cpu(cpu, r);
>   	/* The cpu is set in default rdtgroup after online. */
> @@ -999,11 +1033,95 @@ static __init bool get_rdt_resources(void)
>   	return (rdt_mon_capable || rdt_alloc_capable);
>   }
>   
> +/* CPU models that support MSR_RMID_SNC_CONFIG */
> +static const struct x86_cpu_id snc_cpu_ids[] __initconst = {
> +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X, 0),
> +	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, 0),
> +	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, 0),
> +	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X, 0),
> +	{}
> +};
> +
> +/*
> + * There isn't a simple hardware bit that indicates whether a CPU is running
> + * in Sub NUMA Cluster (SNC) mode. Infer the state by comparing the
> + * ratio of NUMA nodes to L3 cache instances.
> + * It is not possible to accurately determine SNC state if the system is
> + * booted with a maxcpus=N parameter. That distorts the ratio of SNC nodes
> + * to L3 caches. It will be OK if system is booted with hyperthreading
> + * disabled (since this doesn't affect the ratio).
> + */
> +static __init int snc_get_config(void)
> +{
> +	unsigned long *node_caches;
> +	int mem_only_nodes = 0;
> +	int cpu, node, ret;
> +	int num_l3_caches;
> +	int cache_id;
> +
> +	if (!x86_match_cpu(snc_cpu_ids))
> +		return 1;
> +
> +	node_caches = bitmap_zalloc(num_possible_cpus(), GFP_KERNEL);
> +	if (!node_caches)
> +		return 1;
> +
> +	cpus_read_lock();
> +
> +	if (num_online_cpus() != num_present_cpus())
> +		pr_warn("Some CPUs offline, SNC detection may be incorrect\n");
> +
> +	for_each_node(node) {
> +		cpu = cpumask_first(cpumask_of_node(node));
> +		if (cpu < nr_cpu_ids) {
> +			cache_id = get_cpu_cacheinfo_id(cpu, 3);
> +			if (cache_id != -1)
> +				set_bit(cache_id, node_caches);
> +		} else {
> +			mem_only_nodes++;
> +		}
> +	}
> +	cpus_read_unlock();
> +
> +	num_l3_caches = bitmap_weight(node_caches, num_possible_cpus());
> +	kfree(node_caches);
> +
> +	if (!num_l3_caches)
> +		goto insane;
> +
> +	/* sanity check #1: Number of CPU nodes must be multiple of num_l3_caches */
> +	if ((nr_node_ids - mem_only_nodes) % num_l3_caches)
> +		goto insane;
> +
> +	ret = (nr_node_ids - mem_only_nodes) / num_l3_caches;
> +
> +	/* sanity check #2: Only valid results are 1, 2, 3, 4 */
> +	switch (ret) {
> +	case 1:
> +		break;
> +	case 2:
> +	case 3:
> +	case 4:
> +		rdt_resources_all[RDT_RESOURCE_L3].r_resctrl.mon_scope = RESCTRL_NODE;
> +		break;
> +	default:
> +		goto insane;
> +	}
> +
> +	return ret;
> +insane:
> +	pr_warn("SNC insanity: CPU nodes = %d num_l3_caches = %d\n",
> +		(nr_node_ids - mem_only_nodes), num_l3_caches);
> +	return 1;
> +}
> +
>   static __init void rdt_init_res_defs_intel(void)
>   {
>   	struct rdt_hw_resource *hw_res;
>   	struct rdt_resource *r;
>   
> +	snc_nodes_per_l3_cache = snc_get_config();
> +
>   	for_each_rdt_resource(r) {
>   		hw_res = resctrl_to_arch_res(r);
>   
