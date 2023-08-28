Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156EA78A57F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 08:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjH1GHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 02:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjH1GH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 02:07:26 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204AEEC
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 23:07:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLkL4JprUjCyGUTDd+tRh3S0ZOpTUOhhCFTF9xE25VSSEBrQPjvNeTzXqTfrY1oKAmr0stS/oWmr3HoQ/2/HUrwhKiDLJgObRh5rUUsrAv5Pe83K8ILwODTjDPihjf/QEPZ4153kvzNyBTb5QBu/qtnRYmQMT50VlRSWMVpIC1rrD0zB8cxED9MXvmXiWhLyTWyZYNEySM048tYNRJn0WD8jBxEIS05tKCCvsxgBgTJQDv1plGQrlpwGyAwoogJavTlYV2MD3urniC0izTyzA6iuzfHWeCs+/kVZfdWDZ/5XYy9gn5FBjp9wJZmCSjD4Fu78doZW0M2udCtZhG/5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0q9eJiHx3/cGbuu3AHXBq9X/vyVumb34CxyqUJl4gY=;
 b=BZjCV91RpqAn/cBT16TB9lPzmqvtDKWSYWk6KOwg3Nmz+DsiRqe0pOpMD0sskzFsCGuB6hEyfJzoFLVoFAl0fx7d3Wv41KKjwm83WGsKwSCptx70vzIvWRsLhvjOtl89lctOV12wgOakPlWqcAh6nF+wtmJKJpCw8WnJKkvZy3tdLaU+SxlHn5NjQeh+CFrOTNa4pdWKfN+boHAJfNpDtZHol6mM6ho3lpW5YxsgDA2j4nQ0hDxRmEtdRnQRjXxhGrXgupBlEZ+K32VT7oohR28r8GXZYqydE22+vvJpsFyTmNOU9avrGpPxMdJV0WiTi9q95cdUyZOE+iLr5H6xlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0q9eJiHx3/cGbuu3AHXBq9X/vyVumb34CxyqUJl4gY=;
 b=Fj34zwQNeRk7Txeqwjx70wcARFuM41CS/6+VmhoO8o03v5/NM2M3KokiewARb5/mq69l0JM4kOi7xgtDQmEK+PklXKJmaUsJEjyCXTF1Ze4OZwL+hTr82sBHjpQ1RYjoWqwwcRr6U6XF5bevm4Ty1f+w3TDzVXLlmQWba+4q6kM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by SN7PR12MB8003.namprd12.prod.outlook.com (2603:10b6:806:32a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 06:07:21 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 06:07:21 +0000
Message-ID: <934072fe-eca2-44df-94e7-9fed1dc8b502@amd.com>
Date:   Mon, 28 Aug 2023 11:37:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [patch V4 24/41] x86/cpu: Provide cpu_init/parse_topology()
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>
References: <20230814085006.593997112@linutronix.de>
 <20230814085113.471353147@linutronix.de>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230814085113.471353147@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::8) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|SN7PR12MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b76862b-a9ce-4cf3-4ec6-08dba78d09eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KZSEXWl63KFZxpIemE5VGAUDClUQap5lcyQocuizWUZHhMXyA9Z0FXrlI/2nVe/V5XdufLLqPP5XQwUYeGY0tjwDRpwYmC8ZCXhP6WWfDaItHsRot+s3LRmMRh9db0wQ4wWzHBRPouW9SDBpmXtORXN62f0902zwBm6RXktLh/P8gK9cp9sghobycCSSuht/xLt53eaRm4oZhXkGwEaIgo9VRUCIyUY/iuVRmdPFvrgSdmSVI5F1J6ThV4SfoGNu7AVZm8HXOoQgO/HzhntgOstYFwh6wgiU6gd8rYohTIfzOzDfYGfloO/DccFJnJ7xSOd72rPaFgedRI6Ru+igiGGfOKKd4rTFWtaFUfRQcO3+O7+aSYnGFR1pzqZiehXOage7xD2UFQqv0SSy2ummD4asc3If4qUMp7cN2DqvvVjD34/ljB/qctSVlMC83kYT0jo9Q7xEL7h6LGCnXiU6fvLzplAATc3PwXLcQEZjRtePKGGRKBRVARHRcNUIIdHotFe6dnxMullm55SMju13zOSB2sowtLJ7BXffUhESuSnBHjprvMRtHLPceMMeF3Mq9FnDpdlRe1FNCflO5I2FIIWVFPvUJA+Lz3ZFTkW1ITCaKLhISfPqjfxHmPB5KoCiWnLH3gsI++tNZaMo5jNUqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(396003)(376002)(186009)(1800799009)(451199024)(31696002)(6666004)(53546011)(6506007)(6486002)(2616005)(6512007)(38100700002)(7416002)(86362001)(5660300002)(2906002)(54906003)(8936002)(8676002)(66476007)(66556008)(36756003)(4326008)(110136005)(41300700001)(66946007)(316002)(45080400002)(478600001)(83380400001)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3BmVjlYN2VpMWhUNE5jb09mSzhLNnNkdmhnYjJ4SGZibTY2UVRvcC9UTlda?=
 =?utf-8?B?UkNJM3NSaXFBNUxiekFubkJZczBWSXR4TmpocjhtSFJ2SVZ4OEZBN2hBcUhz?=
 =?utf-8?B?ZnlNSU5ybklDME1UcFkveU9qaVFQSTBmeGNHVm5vUCs1NzVrTzNKbVpRcWRL?=
 =?utf-8?B?RjM3dzdTWnNoQVhJblM5ekhtZEpPVHQ3ekNpbzhXamE4QUtTbCtxNjRrL3dQ?=
 =?utf-8?B?NWxCRXJFeklTZmZKSmFjdEptM3A1K3E5TDg1UGpyMGp6OFF5bnE0MFkvOFhH?=
 =?utf-8?B?TDZTYVR3VXBZaDJwYm9OUmVEaHBWZGdsdERwdzBqSHJSeDFqNy96bXljaGdn?=
 =?utf-8?B?RUlySUxZVTlGR1RzSkNWOHM5czYyMmpIKy9yWERzbzFEeE9ybnVUWTNBRHlW?=
 =?utf-8?B?OXdpWG5IVjIrTVdmZzFUSVNaa3VhZTVGcC9rTVhwZ0F5dnIwVGN1Z1lPaE1t?=
 =?utf-8?B?NG10WVJ2a3hEY3VTVk1YNlhZT3VlZDhabThkV2k2Uk5lTkdQNTRKVTNnKzI5?=
 =?utf-8?B?WURwQ2JtVGdhTWNlOTZXMi93U2tzaFBvbDRFUHZwakVXNGJTVmMrV1AxSDBZ?=
 =?utf-8?B?WlNkNDNqZVQwS1hKQ1VFdG04NjVNdmJMM1lxMHliUHBvNkRLeVkraDh0SVND?=
 =?utf-8?B?cnNZZnh4OWM1S0ZCd0RnYzNCYmZxZGpDZklGc0Y1UDRLakRZaUFSNUJkbDRo?=
 =?utf-8?B?dm5GL0JpRHJ0YlIxcEJQd05kQzRHN2xMcmtpWEhSV2R5djhDUTNGemNIcWVY?=
 =?utf-8?B?Y2NKKzNTZFNFWFFoYVJhM2FLL2drZisxQzhPdG1CMHZhWkViRmZTMGxkVGlq?=
 =?utf-8?B?Vk50azBJL1U3eXYyeG1ndmUxRXE4YUQreWJ0K25XOFEwNXNtdGh4bDFOM3hW?=
 =?utf-8?B?MVowL2JVMncyby9WbFRNQi9hdzA1M0FuQTJxZGZmSFk2ZndvaXVIL3d6VEZV?=
 =?utf-8?B?L3k3Q2ROOVRDMDhscmhuSkFYelFWQ3R4WFVjcmxTNjB3S25hZmdSN3E4eUlM?=
 =?utf-8?B?dWZUQnhUMmM0blRLTWhvelJCVUVsSGJlTGVoY0NvRDFpRVNtak5oY2lTV0JG?=
 =?utf-8?B?SzhDSDVVeGZmbkVBaU9yTDlTbFg2SXYrbkpaSEl4N0o5WmlhbG9DdDhYR1h1?=
 =?utf-8?B?UkV6WjBVT3QzVkluYzQ4ODgxNVpGM3ZzR01GZXNRWlJOa1M0Z0FWRENyMXlR?=
 =?utf-8?B?TDRuUTZ3U3NKNENJVzlxMExMR2I2VmkzQ05tOVF6ZTc0TVZuWTFSSk5xM1Y0?=
 =?utf-8?B?YTV4TzFwNFFUem1kNEJoWEhoc1RaS0x1aWsrVkxvQVQyOHBETG9qcURHVWJK?=
 =?utf-8?B?bDdxdlpMTCtXNFVSZ3BwY3FpeXhmY3A2cDZvVUIwSE8vUXBrT1dKMS9ZNHFN?=
 =?utf-8?B?NzlrQUJTR0IwUW9oOWtxZXp0cUtRMkZzMk5IdVkxSWJXcjN1Z1BPSjFUNSth?=
 =?utf-8?B?S213OTFjZi83amtPY1dWajVySkI2eEZmL293NUdEczVXYzB5TUluQ1pQNy9O?=
 =?utf-8?B?QmtueHJHSCsvVFVidS9mUFNPclZQNTdFWmdHWG81VnovMXVZMUlMajVETG9o?=
 =?utf-8?B?b1dYSlFEM0E3Tm5ZZzRnL01HWm54RnpNcG5WU0U3K1lHdCs0NXZWczAvS3dp?=
 =?utf-8?B?dHc1a2pFOVE2RVBFRHNsbzlUeGRNU0hmRDhRWVBrUDJLd0ZBdzAwRTVvUUdF?=
 =?utf-8?B?UjI4cE9DNmd4M0ZvM2NCWVdnczRHRVRJOGF0bDFpT3JYN3BPMGRwdStaTDN0?=
 =?utf-8?B?U1ZUcGY5N1FMVW9RL1VrVENIWFJBNk8vdVFnaDZwZFRVaG1wZllsUHpWb0VP?=
 =?utf-8?B?Ymh4azVFV2xWd3VkejczeVVRSm95OFNDOWZhVnlBVXhnaFNLU0o4Qi83N0Mw?=
 =?utf-8?B?US9ra1VHUVVqall1Z3EyUGV5WElvMXUvTnFNUmlNR3dqdXhjMG9ReXVTTExE?=
 =?utf-8?B?N0Vob3ovaDZkRmprQXNSSm1lQit2Wms3ZUlEQ2pQdGd3YjRlUDBheVUrWkZE?=
 =?utf-8?B?RXFVaFEyWW1rdmIwRzJTZTZ4UHc2VjdLcDlWNUdpYlhhZHd0eHFLdWtmTGdP?=
 =?utf-8?B?ZFZXSEtsUW9yTjVGYkRzUUZ3V0lWL0lobUZYVFoyUkRoNGZIeERSVzNxR1J5?=
 =?utf-8?Q?4S8IeQqERag5BxiDNHICFwP6S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b76862b-a9ce-4cf3-4ec6-08dba78d09eb
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 06:07:20.5680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCYTUQuxaO4Ujvhd6/ws+1gbch2y6ovVUgvqwnXvrlKDEHhm4KpUKcYYXDUzyvV7KjcA4pSUNbFyHaxTxi4OWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8003
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 8/14/2023 2:24 PM, Thomas Gleixner wrote:
> Topology evaluation is a complete disaster and impenetrable mess. It's
> scattered all over the place with some vendor implementations doing early
> evaluation and some not. The most horrific part is the permanent
> overwriting of smt_max_siblings and __max_die_per_package, instead of
> establishing them once on the boot CPU and validating the result on the
> APs.
> 
> The goals are:
> 
>   - One topology evaluation entry point
> 
>   - Proper sharing of pointlessly duplicated code
> 
>   - Proper structuring of the evaluation logic and preferences.
> 
>   - Evaluating important system wide information only once on the boot CPU
> 
>   - Making the 0xb/0x1f leaf parsing less convoluted and actually fixing
>     the short comings of leaf 0x1f evaluation.
> 
> Start to consolidate the topology evaluation code by providing the entry
> points for the early boot CPU evaluation and for the final parsing on the
> boot CPU and the APs.
> 
> Move the trivial pieces into that new code:
> 
>    - The initialization of cpuinfo_x86::topo
> 
>    - The evaluation of CPUID leaf 1, which presets topo::initial_apicid
> 
>    - topo_apicid is set to topo::initial_apicid when invoked from early
>      boot. When invoked for the final evaluation on the boot CPU it reads
>      the actual APIC ID, which makes apic_get_initial_apicid() obsolete
>      once everything is converted over.
> 
> Provide a temporary helper function topo_converted() which shields off the
> not yet converted CPU vendors from invoking code which would break them.
> This shielding covers all vendor CPUs which support SMP, but not the
> historical pure UP ones as they only need the topology info init and
> eventually the initial APIC initialization.
> 
> Provide two new members in cpuinfo_x86::topo to store the maximum number of
> SMT siblings and the number of dies per package and add them to the debugfs
> readout. These two members will be used to populate this information on the
> boot CPU and to validate the APs against it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Juergen Gross <jgross@suse.com>
> Tested-by: Sohil Mehta <sohil.mehta@intel.com>
> Tested-by: Michael Kelley <mikelley@microsoft.com>
> 
> ---
> V2: Make core ID package relativ not relative to the next level - Rui
> ---
>  arch/x86/include/asm/topology.h       |   19 +++
>  arch/x86/kernel/cpu/Makefile          |    3 
>  arch/x86/kernel/cpu/common.c          |   23 +---
>  arch/x86/kernel/cpu/cpu.h             |    6 +
>  arch/x86/kernel/cpu/debugfs.c         |   37 ++++++
>  arch/x86/kernel/cpu/topology.h        |   36 ++++++
>  arch/x86/kernel/cpu/topology_common.c |  188 ++++++++++++++++++++++++++++++++++
>  7 files changed, 295 insertions(+), 17 deletions(-)
> 
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -102,6 +102,25 @@ static inline void setup_node_to_cpumask
>  
>  #include <asm-generic/topology.h>
>  
> +/* Topology information */
> +enum x86_topology_domains {
> +	TOPO_SMT_DOMAIN,
> +	TOPO_CORE_DOMAIN,
> +	TOPO_MODULE_DOMAIN,
> +	TOPO_TILE_DOMAIN,
> +	TOPO_DIE_DOMAIN,
> +	TOPO_PKG_DOMAIN,
> +	TOPO_ROOT_DOMAIN,
> +	TOPO_MAX_DOMAIN,
> +};

Since these enums come from the description of level type of CPUID leaf
0x1f, can we have a short description clarifying what each signify. This
will also help clarify the mappings for AMD's extended CPUID leaf
0x80000026 (specifically for CCX and CCD level types). I had following
in my mind:

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index a95fb8b2c612..132a392a0f0c 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -104,12 +104,48 @@ static inline void setup_node_to_cpumask_map(void) { }
 
 /* Topology information */
 enum x86_topology_domains {
+	/* Represents group of threads within a core */
 	TOPO_SMT_DOMAIN,
+	/*
+	 * Represents group of cores within an instance of
+	 * the next domain
+	 */
 	TOPO_CORE_DOMAIN,
+	/*
+	 * If exists, represents a group of modules within
+	 * an instance of the next domain
+	 */
 	TOPO_MODULE_DOMAIN,
+	/*
+	 * If exists, represents a group of tiles within
+	 * an instance of the next domain
+	 *
+	 * On Intel: This level contains a group of Tile
+	 * type as described by CPUID leaf 0x1f
+	 *
+	 * On AMD: This is the group of "Complex" type
+	 * instances as described by CPUID leaf
+	 * 0x8000_0026
+	 */
 	TOPO_TILE_DOMAIN,
+	/*
+	 * If exists, represents a group of dies within an
+	 * instance of the next domain
+	 *
+	 * On Intel: This level contains group of Die
+	 * type as described by CPUID leaf 0x1f
+	 *
+	 * On AMD: This is the group of "CCD (Die)"
+	 * type instances as described by CPUID leaf
+	 * 0x8000_0026
+	 */
 	TOPO_DIE_DOMAIN,
+	/*
+	 * If exists, represents a group of packages
+	 * within the root domain
+	 */
 	TOPO_PKG_DOMAIN,
+	/* Topmost domain with a singular instance */
 	TOPO_ROOT_DOMAIN,
 	TOPO_MAX_DOMAIN,
 };
--

>
> [..snip..] 
> 

--
Thanks and Regards,
Prateek
