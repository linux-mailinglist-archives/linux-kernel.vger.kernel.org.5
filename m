Return-Path: <linux-kernel+bounces-14789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909A682225F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24CE028474B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292551640A;
	Tue,  2 Jan 2024 20:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1GRMpiSX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D77F16400;
	Tue,  2 Jan 2024 20:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uxx3rn1NwOstL1+64m7wLOfGe5prhN2bjxKswaWCPslXc7a0e3atZhKHsYVihBJfcWdx4qa0nCENIaY5jjhB2MdjPdia6DhWw5ER5vcVZ04UHLG7clHHyt0lxa74Srp0TjGy7sMFI/qhrf/39q03PEKekHnAMFgizQ5uTJEl1agA1nlQGtSY6/as8+yZQ4VW0YlJtS4k1/IyLypsqEXJIJBoXs8AG2uB3ku2UYlh8D5idOTTT0QZqjo2Yufwk60AhfnHR3cix4zgg2whILZ3DWOeVl3gdQAZX5e42s/GUUpRdWDbGwRkprWa+zwCmP5utXZajGcXnIP4i+S03bataA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnI/JPjUibh8SwGpBtrG+8mCnycq7ZVQR2idCUagzuM=;
 b=jU4SswQGUY+MIp3deBVLUBJRiSki0jsaXukqpAddUs/9a/kJZpgtx/+BM7QRnYY9mASwtfKn7tz/ykjNB2u6RE41PbxKag4EplAgjsTLScDXMNkmJvz/6q5IIDTmo1jor/OGMmRBDuTMq0Sprmxq6oILClGgwmC0oOaXhoGTYFeLe7/4sB6V1KLsOpclBFHnCJj81X8lOH07hbhAGB8wM3ICFHHMFl2iIE+Fb0DRpNEMecbQTM7S+VavKjsZRMsbnEEvRPhK+R943uBdvdVg/1kqQXxx1tKD8swLmoXGdfieKZS51wiwqTgvfehTa1TzyoNYyXiKVpOh82Nebi7+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnI/JPjUibh8SwGpBtrG+8mCnycq7ZVQR2idCUagzuM=;
 b=1GRMpiSXPmdvmLbeGzHJBqxoe5m7x6/W50kc2wlakIk2L9JLkqXK6lXyz0zrnA0CK5QZzH5SmBYZ99W3vSZzhtlGuZLFbVk7lH/KPDPGKXzAKwvPQc9xR3wvVAu8beLvrDkdHauoIzw1O11Kv8toSAv8//UQaEiBiEPbsQhxS9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 20:01:00 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7135.026; Tue, 2 Jan 2024
 20:00:59 +0000
Message-ID: <978719d8-8492-47f8-afdf-09e7c997b0b3@amd.com>
Date: Tue, 2 Jan 2024 14:00:56 -0600
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
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <d9f3d23d-aba7-4229-bddb-5d6801b22f27@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0086.namprd05.prod.outlook.com (2603:10b6:8:56::7)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CO6PR12MB5460:EE_
X-MS-Office365-Filtering-Correlation-Id: 8029bbda-f912-4c87-6e38-08dc0bcd8a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VsNpidebJSoS6jKF4SZtFFntkx6jYWyjfb2IcjH1f7TAnrARmJfgW1gaRoqikQVj3hR0DqDrAYwg8QCW/XYYTLZedvAg2C6Hj4MhVeEWmD00lnLmuUYi9qtuJsEdbDK6mKOPh6Cc8LjbB/f3hCHv4Uc4e+GNjSUviN9SLc/NpAU1Ijbkers4g9Eo98WENucjmHgzwisUurafS/e5FCHpBGoA7TVjwqNtXwyuE9gAXXdycW/C1S+n7eo1t0R5XGj8RB7N6xvi18DkAoCevJZoR1imQ7uMWHAHsQx6MQfDZF57eZHgeUhF86S53MpSvzjtxxth+4udkqZAKybvzf05OMc54wfI4nxB4bbVZKEUMmsi5pP+KhfWxY7p3KK75VA7fNoH3W6LCVxjWSSCLmH0gyEtK1mn5/yoRqYXSPiiXr7taciJWd0o/f2pxe3PJ1jCUDbO8z0KyKPdGeoonm2YvGACFNVyAgpzAhQbxVS6fYqeKfVd9PMCctWAbJafwzeRlhSUG1QZ9MzFDtugAwzeUUKQFXl1fj9YsCpbZGKcr4Xy/Xjli0eH4H9MA7CdLhvlnuoGLgRtYyyzUJ+VXJaP04AQ0/vYupNPkydJQr9vyx2IHQoVjHGbjOcgGdsUFdW65E6EkCsDlzKGOprPi2Tt+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6506007)(26005)(2616005)(83380400001)(6512007)(6666004)(53546011)(5660300002)(7416002)(4326008)(41300700001)(3450700001)(478600001)(2906002)(66946007)(966005)(6486002)(316002)(8676002)(8936002)(66476007)(66556008)(86362001)(31696002)(38100700002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3pxakpsZy84ZWtqWjhJd2dhTmpYdWRDWTR3aFZHNXhnNlQxRzM1Zmc0RFZt?=
 =?utf-8?B?RHJNN1dNWXJRZmM1OHV4YmI0NTdQK042bXRrb21ad2libVY0Z3E2bStkMk9y?=
 =?utf-8?B?dXNhUEJTZFp4NXVwSHJ0WG0wblhsZFBVczh4OHFsQmtXVnczamJ5cjR5V056?=
 =?utf-8?B?UEd0MlN1azBxdDRVcWQ0TkRLVGxqRHEzYUlCRGkzSXdJcGd0RWtBY0tLSHVn?=
 =?utf-8?B?K2Q1MlFWc0lDL1c5OEUzRWJrWVQ1K0NtMjFKSVlwY1RPQnBCeEJUV3NJMWtz?=
 =?utf-8?B?eGhjQzAycmtPMEdacU96SnBLRGZabE9ZK3dBT1lkNHNmUjMvU0dlNTg1aGY3?=
 =?utf-8?B?dUZPUENNUm1uWGxma2FDbjc3NmFxN2tlZ0MzdUdvUFVnL0Jzd0syUkNkRWpU?=
 =?utf-8?B?ZVJMNWViVmlxQkkzQWZvSTc1QlpYUkJxdm9hUzJPbTdEeG9kSW5TY1RTVTI5?=
 =?utf-8?B?ZTVaUkxOYjNjMVdBd3JYOExvWklaRDBXVVFEa0MxcFhFR1p1S0VzSXZEWEFm?=
 =?utf-8?B?NUJlR0tsOEIwUDBRM2FlTkhsQmFXaTRON2prdk9kMkxMKy9EY0FDOENWVWo4?=
 =?utf-8?B?L2R2NFNZRGNrZ25uSnRMbXdoN3pQUmtJWlVOOGFhekx1aStZTnozemZRNlJk?=
 =?utf-8?B?S0NjNTRxTGlweERQTHFkTlNySHMrN1pNVm1SdUt1K3RWaXFWT0hsT2FoQlR1?=
 =?utf-8?B?YUx0VFpLRWZHSDA5OHd1blc4eEZtTUpBT0FsV0RLMXBKUWhtRUpmc1k1Y3BF?=
 =?utf-8?B?YU5XdG5mdi9hQmhFYXdUeHEwMllzUGl4aEVmZzlvcS9PbVJPdjB2LzNhb0lW?=
 =?utf-8?B?dE5kTU8zY3R0eUdVZGhETkhxSXRnNXY1NzR3UmJxekIvaFQvMllSaW0wMEhq?=
 =?utf-8?B?UWcxeXQvQmFCaFQxNzF5QU03eFJDQU4xQTFlL2g5NzdMTzBpSXprcUNWNXdZ?=
 =?utf-8?B?SVZjbjE4MmliT09DZXJkNlNCcENqc2NwaHIyY1VBZEl0eDZTVnRlYU15eTZ5?=
 =?utf-8?B?UUd1UHNrRHp5dkQ3UU9HQ3ZBYTUrS29IUUJiMWg4VlFMV2JZWWpLa3crUTRE?=
 =?utf-8?B?YjMzUnVVZzBSUVZOUm5mL2pvb3RVZm1aQ3M0NGlXT0hGQ21hMkpCY2RPbXBo?=
 =?utf-8?B?eEE5UUZiSW1QWmk3Z1EwcVBqUWZiSlROZjVaVkkxWUVjOUpBSU5Wdm12eXB5?=
 =?utf-8?B?RGp5UzlRR0VRQ0tTajFBSEhmT2FmeUVwRlRZT2QraGYveWpNQ3h6c0FjZjUv?=
 =?utf-8?B?Qm1DQ3pzcEpwR2I3OWZnY0lpdnoyZ09sTXlWZ01oWERCcTdtekpTbk01L2pq?=
 =?utf-8?B?cStjalNMT3U5VnBmVjBrWHF6TW8zRDhCRGgxTTFMM1FuMXVUMmJsRFpqSDlY?=
 =?utf-8?B?NWh5WStoUkJISzFZOC93OHhnRGhOdGZuSmI0OEFQZEpNNGMvSUh3UFdmMHVw?=
 =?utf-8?B?VGhRVDdTSVV3Ti9aSUYyM0ZKTVRoU2xYOG9lZUJLSGovemFGY0dPRkxCdXND?=
 =?utf-8?B?TCtrNzdmbmFwL1FSYmRmMXhCdlBGRVY0NHdFTk1TYjV0MEJJR0xQWFhmaVF1?=
 =?utf-8?B?cThPeEdvcFB2c256VGxqRitqOEJkeUoxV1FVWlVQaVVtUUxyWmxzbUc3TllS?=
 =?utf-8?B?UzJ2MnBSSGV0NmZ3YlBuWkhRbDNWT3RtZUpWYnRkTi9QaTNiNWcwQW1PajNM?=
 =?utf-8?B?aDZUUUxCeStwcWJpOEo0T1hGYVk5UXpWcEZwRFV1MlBudDh3Y0N4WjVYcllh?=
 =?utf-8?B?QTVnT3JrYXptMlVueTZqWE5zeVdKZkF2L05XTkFQMVNxN1Z0a2VhQkZ1NGJ5?=
 =?utf-8?B?aHN5OW1iZVYwckVGWWwvVnFyaTNIalZNM1N0dHYyM0IvcVhBQVc3WnNzK2w0?=
 =?utf-8?B?U0NYaWNhcEJPVzVSN21rWE1VMXY5OFF5encwZmhkTUhPTEpwM3BTRkE1cVVQ?=
 =?utf-8?B?aWptaTlFa0F4RkdQbXh6NjdpSzZxdmh0ODhmVTM4WGRIN2VQOHY0RVZoaVU2?=
 =?utf-8?B?bHVLMzd4VjdyZlgzYko0NmNpc1NnTVVmNFZqWGY0RjBGSGpONXBuRXhRYklI?=
 =?utf-8?B?SHlZU0FGc2dOMFF5c1E3L2dxcmd5MnJyb2U3Z3A4N2tFdlIxcjZ3bzJqMDI0?=
 =?utf-8?Q?mpCI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8029bbda-f912-4c87-6e38-08dc0bcd8a5b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 20:00:59.9140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ac40uE/swvDowo9qoBYJimOirIJcmoPqRenzQ4/RB1B5marHCyDWeuty19ysT9gJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460

Hi Reinette,

Sorry for late response. I was out of office for couple of weeks.

On 12/14/23 19:24, Reinette Chatre wrote:
> Hi Babu,
> 
> On 12/12/2023 10:02 AM, Babu Moger wrote:
>> If the BMEC (Bandwidth Monitoring Event Configuration) feature is
>> supported, the bandwidth events can be configured. The maximum supported
>> bandwidth bitmask can be determined by following CPUID command.
>>
>> CPUID_Fn80000020_ECX_x03 [Platform QoS Monitoring Bandwidth Event
>> Configuration] Read-only. Reset: 0000_007Fh.
>> Bits	Description
>> 31:7	Reserved
>>  6:0	Identifies the bandwidth sources that can be tracked.
>>
>> The bandwidth sources can change with the processor generations.
>> Currently, this information is hard-coded. Remove the hard-coded value
>> and detect using CPUID command. Also print the valid bitmask when the
>> user tries to configure invalid value.
>>
>> The CPUID details are documentation in the PPR listed below [1].
>> [1] Processor Programming Reference (PPR) Vol 1.1 for AMD Family 19h Model
>> 11h B1 - 55901 Rev 0.25.
>>
>> Fixes: dc2a3e857981 ("x86/resctrl: Add interface to read mbm_total_bytes_config")
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>
>> ---
>> v2: Earlier Sent as a part of ABMC feature.
>>     https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/
>>     But this is not related to ABMC. Sending it separate now.
>>     Removed the global resctrl_max_evt_bitmask. Added event_mask as part of
>>     the resource.
>> ---
>>  arch/x86/kernel/cpu/resctrl/internal.h |    5 ++---
>>  arch/x86/kernel/cpu/resctrl/monitor.c  |    6 ++++++
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   18 ++++++++++--------
>>  3 files changed, 18 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index d2979748fae4..3e2f505614d8 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -50,9 +50,6 @@
>>  /* Dirty Victims to All Types of Memory */
>>  #define DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)
>>  
>> -/* Max event bits supported */
>> -#define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
>> -
>>  struct rdt_fs_context {
>>  	struct kernfs_fs_context	kfc;
>>  	bool				enable_cdpl2;
>> @@ -394,6 +391,7 @@ struct rdt_parse_data {
>>   * @msr_update:		Function pointer to update QOS MSRs
>>   * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
>>   * @mbm_width:		Monitor width, to detect and correct for overflow.
>> + * @event_mask:		Max supported event bitmask.
> 
> This is a very generic name and description for this feature. Note that in
> resctrl monitoring an "event" is already clear (see members of enum resctrl_event_id)
> so a generic type of "event_mask" can easily cause confusion with existing
> concept of events. How about "mbm_cfg_mask"? Please also make the description

That should be fine.

> more detailed - it could include that this is unique to BMEC. 

Sure.

> 
>>   * @cdp_enabled:	CDP state of this resource
>>   *
>>   * Members of this structure are either private to the architecture
>> @@ -408,6 +406,7 @@ struct rdt_hw_resource {
>>  				 struct rdt_resource *r);
>>  	unsigned int		mon_scale;
>>  	unsigned int		mbm_width;
>> +	unsigned int		event_mask;
>>  	bool			cdp_enabled;
>>  };
>>  
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index f136ac046851..30bf919edfda 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -813,6 +813,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>  		return ret;
>>  
>>  	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
>> +		u32 eax, ebx, ecx, edx;
>> +
>> +		/* Detect list of bandwidth sources that can be tracked */
>> +		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
>> +		hw_res->event_mask = ecx;
>> +
> 
> This has the same issue as I mentioned in V1. Note that this treats
> reserved bits as valid values. I think this is a risky thing to do. For example
> when this code is run on future hardware the currently reserved bits may have
> values with different meaning than what this code uses it for.

Sure. Will use the mask MAX_EVT_CONFIG_BITS.
              hw_res->mbm_cfg_mask = ecx &  MAX_EVT_CONFIG_BITS;

> 
>>  		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
>>  			mbm_total_event.configurable = true;
>>  			mbm_config_rftype_init("mbm_total_bytes_config");
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 69a1de92384a..8a1e9fdab974 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1537,17 +1537,14 @@ static void mon_event_config_read(void *info)
>>  {
>>  	struct mon_config_info *mon_info = info;
>>  	unsigned int index;
>> -	u64 msrval;
>> +	u32 h;
>>  
>>  	index = mon_event_config_index_get(mon_info->evtid);
>>  	if (index == INVALID_CONFIG_INDEX) {
>>  		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
>>  		return;
>>  	}
>> -	rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
>> -
>> -	/* Report only the valid event configuration bits */
>> -	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
>> +	rdmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, h);
> 
> I do not think this code needed to be changed. We do not want to treat
> reserved bits as valid values. 

The logic is still the same. We don't have access to rdt_hw_resource in
this function. So, I just moved the masking to mbm_config_show while printing.

Thanks
Babu

> 
>>  }
>>  
>>  static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
>> @@ -1557,6 +1554,7 @@ static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mo
>>  
>>  static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
>>  {
>> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>  	struct mon_config_info mon_info = {0};
>>  	struct rdt_domain *dom;
>>  	bool sep = false;
>> @@ -1571,7 +1569,9 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
>>  		mon_info.evtid = evtid;
>>  		mondata_config_read(dom, &mon_info);
>>  
>> -		seq_printf(s, "%d=0x%02x", dom->id, mon_info.mon_config);
>> +		/* Report only the valid event configuration bits */
>> +		seq_printf(s, "%d=0x%02x", dom->id,
>> +			   mon_info.mon_config & hw_res->event_mask);
>>  		sep = true;
>>  	}
>>  	seq_puts(s, "\n");
>> @@ -1617,12 +1617,14 @@ static void mon_event_config_write(void *info)
>>  static int mbm_config_write_domain(struct rdt_resource *r,
>>  				   struct rdt_domain *d, u32 evtid, u32 val)
>>  {
>> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>  	struct mon_config_info mon_info = {0};
>>  	int ret = 0;
>>  
>>  	/* mon_config cannot be more than the supported set of events */
>> -	if (val > MAX_EVT_CONFIG_BITS) {
>> -		rdt_last_cmd_puts("Invalid event configuration\n");
>> +	if ((val & hw_res->event_mask) != val) {
>> +		rdt_last_cmd_printf("Invalid input: The maximum valid bitmask is 0x%02x\n",
>> +				    hw_res->event_mask);
>>  		return -EINVAL;
>>  	}
>>  
>>
>>
> 
> Reinette

-- 
Thanks
Babu Moger

