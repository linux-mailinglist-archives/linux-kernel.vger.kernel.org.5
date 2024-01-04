Return-Path: <linux-kernel+bounces-16733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9A8824313
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9BBB1F24D35
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7245D225A5;
	Thu,  4 Jan 2024 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0ak6PmFo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C972224CB;
	Thu,  4 Jan 2024 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0bhFex97+hFlkjEi8JAdWrNYpAiGND7gyvDCw1kW3XQ+TMhG4SPt85q2gk2n2njzLVbhqvvZArSnO9azoA6Q2WdGOJWIL7+8zDLi+1vvzHtmfCzIUZVkJuLcuR5rh5VYjU+AN+cXyV8RKS5Nj1MMDpuft7CZ7I521/AlRty8bUXHk3vEb1GfEpG0xKOMWg0ZkEScmswCJoNxl2CUu0Kqcu5guH3mLQq8Gprcf7NzayjUIVdL/y5hp4TyTHi7zAZiDCSplOG2vJ1OncCGC/EXNxUn7GVKnYcJ2grw0RV7AB/SETWrD65r0ZK7jssYOHlkLtugNkWHVjq4XJ02a/ttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIL/IIcDIMf+C6aikgn6qGD0Ku52p1xgnVmr2j1eHJo=;
 b=XOxW4mZpSMbmr5pmdOlXJ67b4mTCtPHZ6rmaN+bXTvlMSVeXHJm4A5gN03I99YXOY1QcPV7sdcKyLMeRj7Uw6Kf+7nLlLxHRmnqAfXVhXzcFyY2d+GOtYsunMo5RyRRq7xDxVmdyLMFz6AXCB5bwB/FqZ6hcEYNTBh2OcExn5RdASggEf61/2/xrHzsTEPOFzam1f94lHYsmkY0vFdE7TYR8IjXpwj4ycdbdzxxBdwPsUiZUEREaFZwhjPu8wIzncjajBJr5fJ6j2v/iE6shUCgksl/lxOo9XQsBCP8nrmYSqZSzTMzhIhgi3mGE8IuBXMASvPMP1STMogjXIbFetw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIL/IIcDIMf+C6aikgn6qGD0Ku52p1xgnVmr2j1eHJo=;
 b=0ak6PmFo0HZ+X4nvnDEPgfRuLlHrwOtEcTC+g6/eJThWtkDaHbhL+YnUaSKoY5Sft9jmqNO9bJiZoBgRDJQZrBIZT1tFta6creO58dq/GJlr85xKVeVBy815QSN+aoSg/5to2Z/pGdjq0DcKRHGag1840U42AP7dkY2x1q0oXxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB7939.namprd12.prod.outlook.com (2603:10b6:510:278::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 13:48:57 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7159.015; Thu, 4 Jan 2024
 13:48:57 +0000
Message-ID: <0af3098d-e6d4-4b0f-94fa-4ebb1dd33618@amd.com>
Date: Thu, 4 Jan 2024 07:48:53 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 2/2] x86/resctrl: Remove hard-coded memory bandwidth
 event configuration
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, seanjc@google.com,
 kim.phillips@amd.com, jmattson@google.com, ilpo.jarvinen@linux.intel.com,
 jithu.joseph@intel.com, kan.liang@linux.intel.com, nikunj@amd.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
 rick.p.edgecombe@intel.com, rppt@kernel.org,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, peternewman@google.com,
 dhagiani@amd.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <170240414535.760665.1609957728181418569.stgit@bmoger-ubuntu>
 <d9f3d23d-aba7-4229-bddb-5d6801b22f27@intel.com>
 <978719d8-8492-47f8-afdf-09e7c997b0b3@amd.com>
 <ac9916a9-d83e-46e4-8dee-ecc15775e94c@intel.com>
 <0ac93544-106a-45a9-a3fe-acb107da798b@amd.com>
 <54c18d29-3925-4bb6-bf39-ec5cb6dfeedf@intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <54c18d29-3925-4bb6-bf39-ec5cb6dfeedf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0025.namprd11.prod.outlook.com
 (2603:10b6:806:6e::30) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 824db933-44ec-46dd-3829-08dc0d2be5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3dtf29y8biI0fGoUV69m9jv4IyceLdcC9enqbKqIsE2Jccw0FJe/veddPI9c7c4tMPkHR8bS6se1zOhPPZyPxEA11T+w7c1jf9YZRIj5mpxN7OPoRlLyC11EqNKLN4KLd8lE0yisNGIXIg0zJMwx5dAFOpBsVLOTI+hmSZInPX5aUPab1q9DR+25B2CAT7gE1iZUzZO+WOZcBZNBr5OXbcwrOPaXEdJbwA1doh9W0/wWg6yXmOUYO8ZYlQtF+yarTELqfDR2jCVMPbX9Lzi3du0+J6Mfkdw4k/eGjMr6ST/xD6Y8Xzpwqv0fRMjkwPmWEQLDW8z6RcIf6pRL8MBEigPYXUfZjdPERa/MmAfCOZ/pRAW9UUdHQbB0O7Jpl4e8NCmUOYdOxUDFzBhhmhISqi+jCHRpVRIw+1atpr34QGl1SsdDW3P3JTSPlzoEXtVKhh9l4rFz73zsXI8R6YJAQWbDQo8Nd6DlOlmId7FDghP6e46Sj0Bv5jPDwN9VVNCvh8JEYX8wNMADhbNoO8/6bd9ltSqVlCBPtrcOlwi8R7rRDXhwj0FwiwOpkitAHM1QCy60r9o6kwCcHaFzNDw4hqv3j7MdT2wJo/JSLcw9gjxwpmUX9glYwMlcuLsnuMq5aucd7yVbZDha7Kh2xnzQmA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(38100700002)(36756003)(86362001)(31696002)(2616005)(83380400001)(478600001)(6512007)(2906002)(53546011)(6666004)(26005)(7416002)(6486002)(6506007)(66556008)(316002)(66476007)(8676002)(41300700001)(4326008)(5660300002)(66946007)(8936002)(3450700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anhRRm1yWXZPaTdFdTJSTTRLY1ZpWklwVmNzbHZ1ZjdiVUNvUWRMY1hVQXkx?=
 =?utf-8?B?M2twT1BIVExHM3dXbzUvVUpCSWMycnVPMDR2ek5mZ2w3czd5Q2xxSjc0cDdG?=
 =?utf-8?B?aUlqUzZJcW13U1FRWk5pVXJSWjNQMWRBcXMxYVNRa2N3ay9KMXV6REZOTTRu?=
 =?utf-8?B?eE1Za1J5NXR0NDZua2dNUDJGTnY5bHpDcW4zSHIrNWdZcXFGRGJ5RmJzMWxN?=
 =?utf-8?B?UzcwZWlnQlFabkxTODgrZkMwWDczYU5aMUhrVnhSUmlmNmFjS0cyV2EydVJC?=
 =?utf-8?B?ekpTNEZzM1UrenVSYWdZMkJYZ25mYmhjZVRmMzFGQStQRlBFK0g4L09acDE1?=
 =?utf-8?B?ZE9YUm1rbzI1bHRKM3VjWDlVcWZUV1ZUTXhmbE9jSVI0Nk9IYllHTmlMOEFZ?=
 =?utf-8?B?Z3hsNXYzbnhFSEhNdDJMeXJ1bDNHYUc3dW05ZVdHZG5kOTF1RDUyMFQyUTZE?=
 =?utf-8?B?RkhydGY1Wmp0dmJjMUpjS2JWdzRFUnJacFZlRnFydFYrOWpoUVJMNHJYRith?=
 =?utf-8?B?YjAxeUh6bTN0ZE1DaDI2aUgvRjVmTkpuRm16aENRcFZYVXdyNG9oSEtoUkVl?=
 =?utf-8?B?T1MxajNTdUkvTjhIT0h0SytTSXFHK3kwSlV4QkZHVUtibUhoVC85UzZKakhp?=
 =?utf-8?B?ODU3V3ZsR080dGhOU3RzOFFtS0xBbFdXWk4yUG1renRFOVdxNXNIWHlGczRJ?=
 =?utf-8?B?Nm4wMFczd0d3ZzU0T3ZPMVdBY1dvNy82QTdPVXlBaG05VUh1WlBFOG9GMkJB?=
 =?utf-8?B?eE5pRXlUWjMzd0x2K1p0ZE5Hdk5SRmhFNjJDSXhnWjl6ZmdYa2VzNC8xVncr?=
 =?utf-8?B?N3RoSEY4TDh6NGtJOEZ4T2psckV4SUhsZStwZW9jR1gwbEJCNEJDSUZiUmNG?=
 =?utf-8?B?QmJWVnIwcUVyZmd4ME80VlRIZzNmV3FXS2tub3d2UWwwLzl2cTVvUlZmSmxB?=
 =?utf-8?B?L09JVlFuVVVVNVZRV3pjbk00bzlRc0ZkNVhMcUIzdWFUcVlFTzZXZnpIcEx4?=
 =?utf-8?B?UWk5Tmo2VlVlZmZLMVhoOXc5RytvSGU1SkE1dDBtckhUUE1OZVBUa0thY3NG?=
 =?utf-8?B?SHZEQy9TbGJoM1dJZUxtZlU1c2JTcWdJMWZzVVoxUFk3TmRPcGhRdHV3MFZS?=
 =?utf-8?B?ZkNlWEdGMTFSci9ncFFoZkNwS2VBVVFJd3dEZnpLYlZLdU1yS0dReXBxT1Mr?=
 =?utf-8?B?clZQb0YxeHpwS3pOaWU3Ni9JOC93NnNIQ29BSWhCSE1QdHMyVEc3VFZZMjB0?=
 =?utf-8?B?aXVQdlBxdFBSVlp2ZHZOM2JRdEhOYmtjdHVoRzBuSndQTmZTMHVLWTYvZCtl?=
 =?utf-8?B?aFB4OHdhdzBtUGEzRXFxVWFyaTQ4M1p2Wmd6dEVJbDM0bDRiZmdQQ3hvVUt3?=
 =?utf-8?B?WDVWRk1UMFJPTjBwSklkUXRleXdmNWdQNXNXM3k3bkkwcENvNWNTNUFyRWIr?=
 =?utf-8?B?TWRRanNKZzF1c1l1RHYyWndTTUVEQWl3QTlwNVVJb2ZtcitvLzJyRG1Mc1dL?=
 =?utf-8?B?bitKTUNDaUgxSjdXU2p1WGlXK3BZOWs1QXFJNUtHcUM1dElkbEFQMFgxWktx?=
 =?utf-8?B?bmJDN3JBZUdpWk1SQ1pqUHpMYWNMcXVYMWVwZ0dGLzJZUGxBSTRmT2o0TTcv?=
 =?utf-8?B?UVJlL3pSZVpyMjcwY0lPc0ZuMHhVZk1NVkRscktpZWEwM0gzdlRleERrYUwx?=
 =?utf-8?B?MFN0cnl1MHZ2Y25ldy9SZHI5Lzh3TDlRZ2FOSGxlMkdGaXloWlhPc1BPQTZU?=
 =?utf-8?B?QzU3TUF1WGZYTm5HL2QvNXFJb0tJSldxVzNvR05JVnp0NW5NampPNmhzSGhT?=
 =?utf-8?B?UFFtMTBPem9qTzdJT2RnejJMRGROVEFPMjVTUkR0NGhKd0pvcmY3czJzOUZW?=
 =?utf-8?B?Ui94MGZhZDNXUURORi9PRGl6VmxHVmppTEx3S09mem5mbW14bHUySTJvZFNM?=
 =?utf-8?B?bnYzYWw0SlUwaXp1eS9lY3JLaUpsT3VESWZiNGs1WDZTYVlaK2t2eHRwUXhY?=
 =?utf-8?B?NHhhQVpaZGw3RlVZcURmc0pueTFQZDVrME5PaVRuOFptVlNya0NNMy9HaEtp?=
 =?utf-8?B?WlV2WWtNalVlU0VkN25DaHhpc0d2V1Q2WW01WFdhYmt1ZDZjSUJiRmpjREtQ?=
 =?utf-8?Q?M4m4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824db933-44ec-46dd-3829-08dc0d2be5ee
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 13:48:57.4257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4GaMRhWC624lnbZSu77DceSlBtP90qzpUJQe0ykWESlaWTQMxcroHkxs0HyXgYK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7939

Hi Reinette,

On 1/3/24 15:40, Reinette Chatre wrote:
> Hi Babu,
> 
> On 1/3/2024 1:03 PM, Moger, Babu wrote:
>> On 1/3/24 12:38, Reinette Chatre wrote:
>>> On 1/2/2024 12:00 PM, Moger, Babu wrote:
>>>> On 12/14/23 19:24, Reinette Chatre wrote:
>>>>> On 12/12/2023 10:02 AM, Babu Moger wrote:
>>>
>>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>>>> index f136ac046851..30bf919edfda 100644
>>>>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>>>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>>>> @@ -813,6 +813,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>>>>>  		return ret;
>>>>>>  
>>>>>>  	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
>>>>>> +		u32 eax, ebx, ecx, edx;
>>>>>> +
>>>>>> +		/* Detect list of bandwidth sources that can be tracked */
>>>>>> +		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
>>>>>> +		hw_res->event_mask = ecx;
>>>>>> +
>>>>>
>>>>> This has the same issue as I mentioned in V1. Note that this treats
>>>>> reserved bits as valid values. I think this is a risky thing to do. For example
>>>>> when this code is run on future hardware the currently reserved bits may have
>>>>> values with different meaning than what this code uses it for.
>>>>
>>>> Sure. Will use the mask MAX_EVT_CONFIG_BITS.
>>>>               hw_res->mbm_cfg_mask = ecx &  MAX_EVT_CONFIG_BITS;
>>>>
>>>>>
>>>>>>  		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
>>>>>>  			mbm_total_event.configurable = true;
>>>>>>  			mbm_config_rftype_init("mbm_total_bytes_config");
>>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>>> index 69a1de92384a..8a1e9fdab974 100644
>>>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>>> @@ -1537,17 +1537,14 @@ static void mon_event_config_read(void *info)
>>>>>>  {
>>>>>>  	struct mon_config_info *mon_info = info;
>>>>>>  	unsigned int index;
>>>>>> -	u64 msrval;
>>>>>> +	u32 h;
>>>>>>  
>>>>>>  	index = mon_event_config_index_get(mon_info->evtid);
>>>>>>  	if (index == INVALID_CONFIG_INDEX) {
>>>>>>  		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
>>>>>>  		return;
>>>>>>  	}
>>>>>> -	rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
>>>>>> -
>>>>>> -	/* Report only the valid event configuration bits */
>>>>>> -	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
>>>>>> +	rdmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, h);
>>>>>
>>>>> I do not think this code needed to be changed. We do not want to treat
>>>>> reserved bits as valid values. 
>>>>
>>>> The logic is still the same. We don't have access to rdt_hw_resource in
>>>> this function. So, I just moved the masking to mbm_config_show while printing.
>>>
>>> Why do you need access to rdt_hw_resource? This comment is not about the bandwidth
>>> events supported by the device but instead the bits used to represent these events.
>>> This is the same issue as in rdt_get_mon_l3_config. The above change returns
>>> reserved bits as valid while the original code ensured that only bits used for
>>> field are returned (through the usage of MAX_EVT_CONFIG_BITS).
>>
>> We are already saving the valid bits in hw_res->mbm_cfg_mask during the init.
>>
>> hw_res->mbm_cfg_mask = ecx &  MAX_EVT_CONFIG_BITS;
>>
>> I thought we can use it here directly to mask any unsupported bits. So, I
>> re-arranged the code here.
> 
> I am not sure where you mean when you say "use it here" since mbm_cfg_mask is not
> used in mon_event_config_read(). My comment is related to mon_event_config_read()
> that can reasonably be expected to, and thus should, return the current "mon event
> config" value and nothing more. 
> 

Ok. Sure. Lets keep the same code as before.

-- 
Thanks
Babu Moger

