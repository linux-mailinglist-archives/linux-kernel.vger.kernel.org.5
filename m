Return-Path: <linux-kernel+bounces-18431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B50825D54
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 01:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58AD11F245AB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 00:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF2E15C3;
	Sat,  6 Jan 2024 00:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u6d5Dn3b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB55215AB;
	Sat,  6 Jan 2024 00:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YA98FYblabk50uRJd/ux2zeBn8al8ArHimrFlValtNCpkNqiI+K870hLA0iB8RA7HVV0213nl5lQYSayWCnFGLFRYGHe9s2rYPUJ30ZERQ6o37mgQCdliPCL7zURl1rMtVJNs04P4o3s9HTko7nGejcnQJobGqTRsGanV/pY9yhDGFTCBDRb4e6PR2SPEHTiW0KFia0ysMbwn4t/fPqWP6auIto3Tx/3SDmEHLSBC6rVJldeRtN/kqspr0qI2T8MtMBsy8KxqJ/ERb27wtPYXgfW/XliwKlmZBlBNW62rQmJNgaKxmvrrfYYzhphkt8Llcmx7myz90XIkZ5hZ0HbpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HG9etoi9ScNNMRSZhsDcp0b/zclLiW3AVEvp/hs8SU=;
 b=D4DUHgLV60WDM1X2t1BpRJXTMBVSk5VA5iMWWq2FCupRCBOYAZPyE/jOBjlCFLQjRCt32DqTyw3fDs+6GnFiTwCZprFrJz7bN0X7kwHb1l+VbsaNE6gFYLUrkgnKSyR3cF0FTm/wRjfySopBq7j8PxOi9mbtJco2tJ8ezfCPy6bxXKQgpNvPvldIMmTFMoUPtAwOG8YlV5sNBd8cRTtesl+/QSFlqiUciPEjw5nbTJFJ0XldzBKJR8w0GxvXst5ip1780TpIblUIRIfcuJtHuNUYc5N+YXuFAk0R8iqN6K38ZshaLLb+w10+AhccLliu17DigEQ7jtSi2wh3dLgNKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HG9etoi9ScNNMRSZhsDcp0b/zclLiW3AVEvp/hs8SU=;
 b=u6d5Dn3bXX8bqF655f593Ryh9js4+5E0R60W7cgBYZcpJlkwYKzHD7FeZSUtB+9Wz8UKe0kNfBmRkf7urmcKSRFid2P8oA8iQPw4Ky5qzTWi4BKJFavGOQORrUGLYMropFse+jTnH/mOw90QXCPh4ITPeIrMDg5JciRh/xIwEWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Sat, 6 Jan
 2024 00:13:21 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7159.015; Sat, 6 Jan 2024
 00:13:21 +0000
Message-ID: <964d9751-0b9a-4394-9b04-95d693ac9518@amd.com>
Date: Fri, 5 Jan 2024 18:13:16 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 2/2] x86/resctrl: Remove hard-coded memory bandwidth
 event configuration
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
 <20240104212130.209490-2-babu.moger@amd.com>
 <e25ef699-7b6c-4731-b62a-39a90dd888e7@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <e25ef699-7b6c-4731-b62a-39a90dd888e7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:806:f2::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BN9PR12MB5324:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a743a4-7a91-409c-d837-08dc0e4c4a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HTnrwNuT94QrUiIeN2IZXnBIBrqIxR96O5nUBJW7P/mEWnIoioCieBhPZkTOgjx4ZkJLUFdltAsjxMjypxvVpDuNEC/NiO8DTj5fSseYGlxs8d/wqY45ut9jE6RjKmJPksOvl1sCuohUJwu+eF/1xZJYf7LlBGXaxuemGm4IgCtf+z89uiPKTuLFmiIoCz/W+1ojxDZkGJnTgjEs4uxTWE+RlFsdTEUuxmG89jaPN6t3IGFZlHBqSLE2rdDNGTh+M6V8O3BJ5tH26bB8SYtP6I9xXrbl3xVvbG95NhyQvZD6CGpTS4PxPDFEW/sDVL1WhDGGTFu4+2oO4LS6K+ON1gfv/mtIJe/qd8YeeVWySq92w47g+c6cW2HdwjalfjjJcrDPbYylI7WpXwtT4k/DMMCRmxTwB8B2uv6ccANMk/3vcm7MLSwohTxz98S0CeQEDdzFQWI6AVS8GsgTqs6hDExEkNUbP19fPr5YCT5wp/6fue/MG/BmNMqD+/RAmaqow/jPG5T1sQ5q9cFsPhL5eA8SNfJQ0qkKYIE2hYFCa3n9sNnKRqG2uHFDaFjjAmwH+jj9u+tYwFps7cJJ03eq8o6jmCoXnW9lMKA6fX/oehifznpqIPyINBK4SKNQ9+O4pwNkOTzKgDWj8uxMsEdq8A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(346002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66946007)(66556008)(66476007)(38100700002)(31686004)(31696002)(6506007)(6512007)(6666004)(53546011)(83380400001)(2616005)(26005)(36756003)(5660300002)(2906002)(7416002)(478600001)(966005)(6486002)(4326008)(110136005)(316002)(8936002)(8676002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3dxeE91WlhVRHdXck1Gcnk4UjFHTkZWZGdLaGYxc1ZaUCtwOHJ3YklhY3dO?=
 =?utf-8?B?aGhYTTh0d3FlNlpNYnpCKzE0Mlp4RGsrNmVzYWdha2NEbXpyWk9VTFBMSE9U?=
 =?utf-8?B?T2FPNkhsanJCRUJ6b1RmNTBGRVpFZDNlVTdDWVpJdlRXdWxER1Yrc08rYitu?=
 =?utf-8?B?ODlodkoyN3Q0NlRJVmZ3VEtSOXNsNlVsNmVnSmcwc0EzMStheXRSRERPdVI3?=
 =?utf-8?B?YXpnWDJvSnJCZzBseXRuWk1SMmJQQjh6TTczeFpwNXdMRG44akJZTkZaRTZH?=
 =?utf-8?B?Y09MSjA2YUcrYit2VkxZa3ByQk5IQ28xZ0E2V3hYQjdBdmc0aHRsL0dxRG5n?=
 =?utf-8?B?MC9sbjYrNG5ja0k4WFhEOHhTT2xvOGdmeWFGUEV1dDQzL1hRWlBzYjlackEz?=
 =?utf-8?B?c0FNOFRPdHp2ZkxOZXl0UXFjelJwOWdLaXVCS2REZ1JpVnU0VUhNS3Vwb0lS?=
 =?utf-8?B?YzFEL3h6VEROcUpsWUs2cVFZSXE0RU5lMFN4ZHpWbXFBaExwNHJUTWFQaDJS?=
 =?utf-8?B?T3RDY01oZnlNVnhaaHlhRUg2NDJ3eEl3cGdSSXd3dS8rYlBzc2JVN1Fody9H?=
 =?utf-8?B?aEVCR0t1VVRGelU3am43QUh5RnJPS3NlNHljajNGVTZXWGxFYXNIQlovcHNL?=
 =?utf-8?B?WWI1K1dUT2c0eENZOXNkck1PZ3BFMHpEVlVrYllVc3lSSG05OVFUeHpHUmls?=
 =?utf-8?B?UERIL1lWY2VnUm9Vc1pXZWpESDRVTnFONWZFQS90ajR4dDZSWXBORFprWElu?=
 =?utf-8?B?ejl5WWY1WlU3emdTOEI3c05qV3gyUFl3UXh5aXhGV3A5SDRkV04ycEs1VjNB?=
 =?utf-8?B?bWVFVGhuR3ZyZm9TK1hub282cDJvSFUwc0tMeTJWMGJFYVFySGQ4eGorWTJ4?=
 =?utf-8?B?Vysvd24xSzMwL0ZqWUlQcUVQOHNVbWNJK2JQSFJSY3pZN2JENTRpQUZnUE9W?=
 =?utf-8?B?R3NoMUdZTHFpVW5mT0h1MUFwZ010bE8yOVhRVUFnZ1hJU25Oa1RuV2NmRFdi?=
 =?utf-8?B?cVRoV3p1UUxYb3RDNzB3dDAzSmFTMVhxRUJ2V29Rdit0a3hBd0ZFcUhDUEFm?=
 =?utf-8?B?TER0Z1VqcjZlWHlvUG5iMFhabHI5cVBJeE1HMjF6Q20xbTZsNHlLMW5qU2RO?=
 =?utf-8?B?UGJLSC9xR2RKeHJNWDVwWVRLWGxkYU1ZRWQ0NXByVTM2b0pMQkVnUEVGdFdY?=
 =?utf-8?B?b3BiaWNlaXhnUDZkVHRWTi9oR2tQM2EyWUFDNDFZdFowczJCaHgxZ05vZVN5?=
 =?utf-8?B?L2FSWEptQ0phRURBQWRwTHlUOEJJRk9QUHZRRkFkT2FvQzhKeTZiRlZPSG1h?=
 =?utf-8?B?SFlDekt3WGxiZTFQQTRqTXZkNmhwcXJFWDMrTXNIMUZGb0ZvdTJ4VmlmK0Zy?=
 =?utf-8?B?a3hHcFE0Q25MRnhhUnZ4REptWEozdkc3WlJhT0lNMjd4Y0dKTTVveDNwVUNM?=
 =?utf-8?B?Q1NpTkJyZ1pTNjdobXpnSng4bDJCTVY0OGlSbUpsejA4aWZpWm5EN0dLalRB?=
 =?utf-8?B?OFlSRk1rdmg5RzNtMlRGQjFOTGEvUXk4aUlJN2l0dERTb3M5NVdLY29SM3dM?=
 =?utf-8?B?bDc4QUlScDR0aW5NMDJjZ04yYmxyRHh3cmNPQlMrdXlRejBEYXpYRTVWQkhs?=
 =?utf-8?B?eW4wWEZweUxIR25JdGdrd2tLYlJpVFFMd0tRNU1SY1dXR3NQNWtPRkZYTXV5?=
 =?utf-8?B?eU1ic0p0R3QvN0lrd09wTmM2d2VKWDl6TlRkblRGQXEzTmd2a2MzSmg5SXVa?=
 =?utf-8?B?NzR1WWZtMVFNYUNPbkJxblVXdkRyM01FVzVLeCtORTZHcnZ1WVdOa3NXbEFV?=
 =?utf-8?B?QjJkS2FNdDVsM3pMM0hiSWVoLzJ0QXVYWlFRbGlTb2JzQ0pnY0ptRHBVUEVW?=
 =?utf-8?B?aFh1T1BMeDU4QUZ6eWxrVk9LUzhYcUdVNWVpTUxzQ2sxQVZpa0Fsb1FPcGND?=
 =?utf-8?B?cWxsZ2htWTBPNHpTbnc0TVZUeGtHSDdrNzBHaEhTNTl2LzZwSVcrdkpwK2JT?=
 =?utf-8?B?VkFzbDVxa0NITi94dlpJRnh2QWRVNVRvZXBlU25RVnB1dEllSjBrRkRqV1V4?=
 =?utf-8?B?Njh3SEpmc1hjWUN1TVlCUnRLLzVYUWV5QWk2WlhUOEhjcGQ1YUgwMi9CU25L?=
 =?utf-8?Q?XBgLGLijdox4jUOV5Y87VWAZS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a743a4-7a91-409c-d837-08dc0e4c4a84
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 00:13:21.2504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgKccsiCMWYUbcNx/OLHyoElaPb+BIjaiqJpQO97PV72KVMOHmTH2HrEgPB6IODQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5324

Hi Reinette,

On 1/5/2024 3:18 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 1/4/2024 1:21 PM, Babu Moger wrote:
>> If the BMEC (Bandwidth Monitoring Event Configuration) feature is
>> supported, the bandwidth events can be configured. The maximum supported
>> bandwidth bitmask can be determined by following CPUID command.
>>
>> CPUID_Fn80000020_ECX_x03 [Platform QoS Monitoring Bandwidth Event
>> Configuration] Read-only. Reset: 0000_007Fh.
>> Bits    Description
>> 31:7    Reserved
>>   6:0    Identifies the bandwidth sources that can be tracked.
>>
>> The bandwidth sources can change with the processor generations.
>> Remove the hard-coded value and detect using CPUID command. Also,
> I do not think "Remove the hard-coded value" is accurate anymore.

Will change it to.

"Read the supported bandwidth sources using CPUID command. Also,"

Also I need to update the subject line.

>
>> print the valid bitmask when the user tries to configure invalid value.
>>
>> The CPUID details are documentation in the PPR listed below [1].
> "are documentation" -> "are documented"
Sure.
>
>> [1] Processor Programming Reference (PPR) Vol 1.1 for AMD Family 19h Model
>> 11h B1 - 55901 Rev 0.25.
>>
>> Fixes: dc2a3e857981 ("x86/resctrl: Add interface to read mbm_total_bytes_config")
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Same comment about "Link:" as for patch 1/2.
Sure.
>
>> ---
>> v3: Changed the event_mask name to mbm_cfg_mask. Added comments about the field.
>>      Reverted the masking of event configuration to original code.
>>      Few minor comment changes.
>>
>> v2: Earlier sent as a part of ABMC feature.
>>      https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/
>>      But this is not related to ABMC. Sending it separate now.
>>      Removed the global resctrl_max_evt_bitmask. Added event_mask as part of
>>      the resource.
>> ---
>>   arch/x86/kernel/cpu/resctrl/internal.h | 3 +++
>>   arch/x86/kernel/cpu/resctrl/monitor.c  | 6 ++++++
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 ++++--
>>   3 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index d2979748fae4..e3dc35a00a19 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -394,6 +394,8 @@ struct rdt_parse_data {
>>    * @msr_update:		Function pointer to update QOS MSRs
>>    * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
>>    * @mbm_width:		Monitor width, to detect and correct for overflow.
>> + * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
>> + *			Monitoring Event Configuration (BMEC) is supported.
>>    * @cdp_enabled:	CDP state of this resource
>>    *
>>    * Members of this structure are either private to the architecture
>> @@ -408,6 +410,7 @@ struct rdt_hw_resource {
>>   				 struct rdt_resource *r);
>>   	unsigned int		mon_scale;
>>   	unsigned int		mbm_width;
>> +	unsigned int		mbm_cfg_mask;
>>   	bool			cdp_enabled;
>>   };
>>   
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index f136ac046851..acca577e2b06 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -813,6 +813,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>   		return ret;
>>   
>>   	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
>> +		u32 eax, ebx, ecx, edx;
>> +
>> +		/* Detect list of bandwidth sources that can be tracked */
>> +		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
>> +		hw_res->mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
>> +
>>   		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
>>   			mbm_total_event.configurable = true;
>>   			mbm_config_rftype_init("mbm_total_bytes_config");
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 69a1de92384a..5b5a8f0ffb2f 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1617,12 +1617,14 @@ static void mon_event_config_write(void *info)
>>   static int mbm_config_write_domain(struct rdt_resource *r,
>>   				   struct rdt_domain *d, u32 evtid, u32 val)
> Not specific to this patch, but since the valid mask is per resource I do not think
> it is necessary to check user provided value for every domain. The user provided value
> can be checked earlier and only once in mon_config_write() before iterating over all
> domains to write the value.
Yes. Agree.
>
>>   {
>> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>   	struct mon_config_info mon_info = {0};
>>   	int ret = 0;
>>   
>>   	/* mon_config cannot be more than the supported set of events */
>> -	if (val > MAX_EVT_CONFIG_BITS) {
>> -		rdt_last_cmd_puts("Invalid event configuration\n");
>> +	if ((val & hw_res->mbm_cfg_mask) != val) {
>> +		rdt_last_cmd_printf("Invalid input: The maximum valid bitmask is 0x%02x\n",
>> +				    hw_res->mbm_cfg_mask);
> I think keeping "Invalid event configuration" is useful to create a detailed message of:
> "Invalid event configuration: maximum valid bitmask is 0x%02x"

Sure.

Thanks

Babu


