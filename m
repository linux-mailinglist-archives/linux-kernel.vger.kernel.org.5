Return-Path: <linux-kernel+bounces-15927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 717C18235C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D087AB215AE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77CF1DA37;
	Wed,  3 Jan 2024 19:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pvYkAlUS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBA91DA30
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 19:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YM8H3tl+qHScrT/L7/h0qzuInKqK7eGJT18SCRsC6TY6k1NrXGdRfaOTFoq6pyQv/o5wWcW4Ub4xQeOMBls2wHe0usMs6BO0T4nUQPDgh0U4/OGNvzfN2ET2+Gw72nUfuW8/i04xRpIrkpeYte/98PtsfFJj7VQicl0cW37b6VfvfyZ3XQgNK0dTwoV4dcc5wjZtesaPJN5xPFKdXRrKlpen3OrSd1ODcKKDrw21+MBnyYJBfCZLXswJ6DHYYQvuaRO5sX6/pFgxGsEQQgD6WErlOAFbjeRxHHyribGEOJXB5oHs5Z8PosSH+pfm42m5PY9GqQFNUalg/O8FEYsQFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SJK0LPpfb+6/mFmn7Q+GF+qD41zGXArSYEPG7uPJJY=;
 b=EE8PjGOcM+UbIp1C9j1kgfF0nk4KqMCDYjnIRNcgKaISmD9NmaLPuSmawCMeiz3rE/odaHgkaN54DAdP2dN0nQTI3zmkUeSs7588Jx5V9zyQJXPCCAa3jw7rvgaZmyYAXv+pqRm4eTcwwGBVSIdruLkAT9KUbf3gnhQ8YIewHOee8Tt03jaWyLDO3/M9us+Zp/Xkw5dJdrCuEIpHmiPIX+2ehf2LMVFZNsmPZmImoBAKvDmNsYCsLqhUy8wtT+zGfJFxyvQW57opPNv9tQ0KRVZlckgwjGAv4tVYXUtkqBBMMrXCmNdsicynu6SAct2FS3R2q10nCW6NVXk3J39umw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SJK0LPpfb+6/mFmn7Q+GF+qD41zGXArSYEPG7uPJJY=;
 b=pvYkAlUS6rh6KXTg9R4pq2BfY+C/sTOsdO1YM96+uR967+JIPxunkCRfDE+sbdKZzFZL/JQahpmWfHThp+tgItCRoNoMQz8JxxIBgO8aGkqMFAJUMKbAUXwlzxx0Feuj2nks8DVqVEtk1FDQ7o14irmmc8LtuUQavyEQptzWhQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 19:43:30 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7135.026; Wed, 3 Jan 2024
 19:43:30 +0000
Message-ID: <290d6066-236d-4681-8dc5-8a380c878aeb@amd.com>
Date: Wed, 3 Jan 2024 13:43:28 -0600
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v8 14/24] x86/resctrl: Allow resctrl_arch_rmid_read() to
 sleep
Reply-To: babu.moger@amd.com
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com
References: <20231215174343.13872-1-james.morse@arm.com>
 <20231215174343.13872-15-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231215174343.13872-15-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0078.namprd12.prod.outlook.com
 (2603:10b6:802:20::49) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: a25f6e5c-1a08-49e6-b059-08dc0c944358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+D8krM1TnFz7wi1D5k8XqwY81oP2/mrfLUQX9MZ9T7D2M99AphAF4kOabJtuhbyyi0bZmn6XpN/mO4mA4/7nI/7rYS55oUq9ncp3R6mVAFGkFTaM82Icm2cu4sWm8As0O9z5aEXVAG32f+EP+vN9vVWYRUuBcH5Jmev3KhfyIxesQeTYriwG+PYyUQ+jUkdSaEv7CAFCQe15MMKnCjq71xASdcxTEgBMKj6/UdmSHcBZNRqbwf/+luYkDy7XQDspnksLSTf+scSvURXtiO7Hr3d0e1Lj50GTXgXeFKYSkVOZXUzVYySDhmNThPMMw7oRCJQqGlhHQ+jEfb6QnaYGiwOiOkTo4wx6THB3eGonETbXB6B6gw4xaZHyvHcwrUhTqP3epmHZcxtjY8M8nHGQmxW2HT2qdD0JjO0a5CtyxXTMIKYPDJ0qZ6DopMY/rXRRqHk3lmPwGZgV7V8Qk1FWGhGQb/SRjwuLKeUg6Y/U/AeBLZ0fWLVAjFO5qG5zEEHmMJt+cKiQ0LB+N5SPSZ0fgbknj9H3FYIay8IkVtPx7HKNHpiJt6VMK55k6L3ofjrzFanEUQ4aFdKCxATjc/n+DKDg28Iu3PYgvQ/CxpEAZFpKl2fE5xLvWrWnVkWEGcf4uDfYIF2hesRFNiYwD2Uv4Wt4NGo8yCy5a5cs0mw4SmMYU33AunUdzweL2Jmu4dNr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(346002)(376002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(4326008)(66476007)(66946007)(66556008)(6486002)(8676002)(54906003)(478600001)(316002)(8936002)(83380400001)(6506007)(53546011)(6512007)(26005)(2616005)(7416002)(3450700001)(5660300002)(2906002)(41300700001)(36756003)(38100700002)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S09wT3JkdWg2V3d0WHVVOEJIbXpPMkoxV21NajdlQ3d5b0VJTUZwRGRJR2Ur?=
 =?utf-8?B?OWhreFc0KzVnQmpwYWd5d2FrYXEyK253cWhrMk0vdGFxOXhiZ1AvOUwwVW94?=
 =?utf-8?B?ZkVnb05CNVpDU1NZbStvbXVWZHpraGxycXVXSjNLNW5tOGJyN0FnTzlwVEpv?=
 =?utf-8?B?aWxFbjM1QnR5eWkrbCtwSHJtTy8vWktsMkRGVk54cCs5TDVkdlhoYUpBeGd0?=
 =?utf-8?B?aWlCRW5jRWxCOUdlcXIwN3dGQUV2MG05OFVEOGVLNG5Cc2hSZDN4dnpEdWtR?=
 =?utf-8?B?YmowY0p1Y3Brck03RXFXdmRrSVFaWVlvbnB3YnN3MVhZenYxU2hWMU9xbUdS?=
 =?utf-8?B?QWYwRlduV0wxVjU5N0p5eFcyWXVoLzgwKzhaQXVMbnNrN3FSRXR0bmtvNW9J?=
 =?utf-8?B?UEpMZlphdVBWREx6THNRYVRuL2pIZnlJKytDOC9OREJkZ05xbnJWOUR3RDBS?=
 =?utf-8?B?NnJBSFpPOVdSbFMwQzNld3IxUzB2TVJLQkYwU2FwVXZkODMzQjUvNVZVRGRW?=
 =?utf-8?B?bzJ2YkcrS0F4YmloV2FCMldSQjNVaGNZUFJCZk9ud3ltTEpNR0pic1ErOTIx?=
 =?utf-8?B?T2Z0cnJFbHhTbWRoSWh1VDlrdi9paGpYQTNFa0pkc0lDRCt4UGFoUHo5cHcw?=
 =?utf-8?B?SDNmbGtXYTVHVEpibGtJT2xoNnN3YndaazFMNWlXT2xISUZLUkowUHdVa0FI?=
 =?utf-8?B?bHFuUnF2UXlBV0R6bzdkWmRpT0tyZXo2aWFrSFJzNmtTK1dYREdXYmlPcXJX?=
 =?utf-8?B?QmtVWUk4WEJEN3ppcWtjc2RFQjVsSWh6ZjcxbldFS0V2MDhmdEV1UFUrK0c0?=
 =?utf-8?B?Mm5hV3c4a3VCZW56NHI3WE5QVldJdHdVaDN0MHlONjBsRTRoZVprMC9BTDNp?=
 =?utf-8?B?b0RiMXQ4NnpqdktIQ281Z2xzWVdHNzdES0FsalFNTVZIRXRCRC9tcUpYdG5z?=
 =?utf-8?B?MjNaRDhLSXBqY3J4dVBhNHg2WVJPNmd1ZnVvRVMxWEEvR3RVMDByZ1VHbHBi?=
 =?utf-8?B?ck5iNGhIVUpoYnl2SGw5MkRhWXFpeFZQZ1VGZStKTm54bldVS3FjU3VNSFpK?=
 =?utf-8?B?R1A5N0kva0ZwZUZqQmZCQVF3Vy9KdDRFdnZjdXBIUWNlRHA0NHI5a0dqc3hC?=
 =?utf-8?B?eGJ1UlM0R2gxTVNiMmtPVDV5dXZUeGlPUFd3OWJDTWdvTFlEb2FTWE5QK2Ev?=
 =?utf-8?B?SUprZmRTb3NRYkxYZ0NESnk2SEtxcVU2VmNaOGtHcFM1cGVEWjlpYllUc2xW?=
 =?utf-8?B?eFVDYlk2dE9vV3I4VVJSOG5RbW02U2xlS0pRTDNEU3FMamt5Mll0UFAzV1BQ?=
 =?utf-8?B?M1IvSmVUL2RCMitsSXpYMlNhNVdIZ0hBQW5jMkFrMktlU1NWekhuU3J4TFVB?=
 =?utf-8?B?cW9UV1U2WU93OGRlY1ZueDNwekZyOVEwSGhjdzRLWWM3YkFOcklOa2lwU1JD?=
 =?utf-8?B?cDFZRUVOd244QkNORG8wMFQyMUxoZFhlQ3h0WnV3VkpQcTJKUHFvelRvQkRG?=
 =?utf-8?B?cVNDZ0phM1llVzFMaHIvOWpSU0pEbXdqbHM4ZkkxOWR3OThiS2lNR29oUnJZ?=
 =?utf-8?B?ekZQekRZWXl6TExRanJFTDgvWEdFRDc0VDZtREtWSlEzUW1xZk9iTE5XMTdY?=
 =?utf-8?B?K3JmTGtiS0ZXR3NucGdmd0gzQ0QyNVRNV1NtWi9mSlVucytyaEJUUi95Ui8z?=
 =?utf-8?B?amMzbDQyVStERGsxRkZBTmcvRWY2NUJ6Y3hOSENFNk0zenArYVFLRDFnejUr?=
 =?utf-8?B?TVY3OTFUTDkrdUMrdmwzaUhLTWRJMjlsbHl6SU9ZUjdveXdRVmtPZjZaS01a?=
 =?utf-8?B?SWFNQStqQng3bEhIWjg4TnZYR2Rjc3FlSWNpbDlHc1F3aE9kbVEzV2lGdTlW?=
 =?utf-8?B?YmFZMDdqbWFRdHgyN2VMTXRtcHh0eVpGUElWY1Z3WHVrWDFqRjdWSnBlOCti?=
 =?utf-8?B?NDhCSWd5dGMrZmxUNzR6bzZQeGV2RnBhZitOSkk5L0JlbkJlSFNWeWdOQVY1?=
 =?utf-8?B?OW9PeDN6VG9CT2pjb0VNS05Wa2V5VWJ0bWI4YWlpaDBXM3duVnVuQkhSWVpI?=
 =?utf-8?B?ZnBkNCtqa3JoTVVIWnRFUHA5bmc3ZEVTQnVYYzJOS01ZT1JTT2Z3YytFWlpn?=
 =?utf-8?Q?RWPg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25f6e5c-1a08-49e6-b059-08dc0c944358
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 19:43:30.5737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5JKPtdmgpbXLo48zZPLWNcw/8UKEuc1xaYV0vIKl3Ca8G8G4BrKoNqbFTqI1FNj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813



On 12/15/23 11:43, James Morse wrote:
> MPAM's cache occupancy counters can take a little while to settle once
> the monitor has been configured. The maximum settling time is described
> to the driver via a firmware table. The value could be large enough
> that it makes sense to sleep. To avoid exposing this to resctrl, it
> should be hidden behind MPAM's resctrl_arch_rmid_read().
> 
> resctrl_arch_rmid_read() may be called via IPI meaning it is unable
> to sleep. In this case resctrl_arch_rmid_read() should return an error
> if it needs to sleep. This will only affect MPAM platforms where
> the cache occupancy counter isn't available immediately, nohz_full is
> in use, and there are no housekeeping CPUs in the necessary domain.
> 
> There are three callers of resctrl_arch_rmid_read():
> __mon_event_count() and __check_limbo() are both called from a
> non-migrateable context. mon_event_read() invokes __mon_event_count()
> using smp_call_on_cpu(), which adds work to the target CPUs workqueue.
> rdtgroup_mutex() is held, meaning this cannot race with the resctrl
> cpuhp callback. __check_limbo() is invoked via schedule_delayed_work_on()
> also adds work to a per-cpu workqueue.
> 
> The remaining call is add_rmid_to_limbo() which is called in response
> to a user-space syscall that frees an RMID. This opportunistically
> reads the LLC occupancy counter on the current domain to see if the
> RMID is over the dirty threshold. This has to disable preemption to
> avoid reading the wrong domain's value. Disabling pre-emption here
> prevents resctrl_arch_rmid_read() from sleeping.
> 
> add_rmid_to_limbo() walks each domain, but only reads the counter
> on one domain. If the system has more than one domain, the RMID will
> always be added to the limbo list. If the RMIDs usage was not over the
> threshold, it will be removed from the list when __check_limbo() runs.
> Make this the default behaviour. Free RMIDs are always added to the
> limbo list for each domain.
> 
> The user visible effect of this is that a clean RMID is not available
> for re-allocation immediately after 'rmdir()' completes, this behaviour
> was never portable as it never happened on a machine with multiple
> domains.
> 
> Removing this path allows resctrl_arch_rmid_read() to sleep if its called
> with interrupts unmasked. Document this is the expected behaviour, and
> add a might_sleep() annotation to catch changes that won't work on arm64.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>


> ---
> The previous version allowed resctrl_arch_rmid_read() to be called on the
> wrong CPUs, but now that this needs to take nohz_full and housekeeping into
> account, its too complex.
> 
> Changes since v3:
>  * Removed error handling for smp_call_function_any(), this can't race
>    with the cpuhp callbacks as both hold rdtgroup_mutex.
>  * Switched to the alternative of removing the counter read, this simplifies
>    things dramatically.
> 
> Changes since v4:
>  * Messed with capitalisation.
>  * Removed some dead code now that entry->busy will never be zero in
>    add_rmid_to_limbo().
>  * Rephrased the comment above resctrl_arch_rmid_read_context_check().
> 
> Changes since v5:
>  * Really rephrased the comment above resctrl_arch_rmid_read_context_check().
> ---
>  arch/x86/kernel/cpu/resctrl/monitor.c | 25 +++++--------------------
>  include/linux/resctrl.h               | 23 ++++++++++++++++++++++-
>  2 files changed, 27 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 7e81268137b0..2785a2a4ea33 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -277,6 +277,8 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  	u64 msr_val, chunks;
>  	int ret;
>  
> +	resctrl_arch_rmid_read_context_check();
> +
>  	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
>  		return -EINVAL;
>  
> @@ -455,8 +457,6 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  {
>  	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>  	struct rdt_domain *d;
> -	int cpu, err;
> -	u64 val = 0;
>  	u32 idx;
>  
>  	lockdep_assert_held(&rdtgroup_mutex);
> @@ -464,17 +464,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
>  
>  	entry->busy = 0;
> -	cpu = get_cpu();
>  	list_for_each_entry(d, &r->domains, list) {
> -		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
> -			err = resctrl_arch_rmid_read(r, d, entry->closid,
> -						     entry->rmid,
> -						     QOS_L3_OCCUP_EVENT_ID,
> -						     &val);
> -			if (err || val <= resctrl_rmid_realloc_threshold)
> -				continue;
> -		}
> -
>  		/*
>  		 * For the first limbo RMID in the domain,
>  		 * setup up the limbo worker.
> @@ -484,15 +474,10 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  		set_bit(idx, d->rmid_busy_llc);
>  		entry->busy++;
>  	}
> -	put_cpu();
>  
> -	if (entry->busy) {
> -		rmid_limbo_count++;
> -		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> -			closid_num_dirty_rmid[entry->closid]++;
> -	} else {
> -		list_add_tail(&entry->list, &rmid_free_lru);
> -	}
> +	rmid_limbo_count++;
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> +		closid_num_dirty_rmid[entry->closid]++;
>  }
>  
>  void free_rmid(u32 closid, u32 rmid)
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index bd4ec22b5a96..8649fc84aac2 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -236,7 +236,12 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>   * @eventid:		eventid to read, e.g. L3 occupancy.
>   * @val:		result of the counter read in bytes.
>   *
> - * Call from process context on a CPU that belongs to domain @d.
> + * Some architectures need to sleep when first programming some of the counters.
> + * (specifically: arm64's MPAM cache occupancy counters can return 'not ready'
> + *  for a short period of time). Call from a non-migrateable process context on
> + * a CPU that belongs to domain @d. e.g. use smp_call_on_cpu() or
> + * schedule_work_on(). This function can be called with interrupts masked,
> + * e.g. using smp_call_function_any(), but may consistently return an error.
>   *
>   * Return:
>   * 0 on success, or -EIO, -EINVAL etc on error.
> @@ -245,6 +250,22 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
>  			   u64 *val);
>  
> +/**
> + * resctrl_arch_rmid_read_context_check()  - warn about invalid contexts
> + *
> + * When built with CONFIG_DEBUG_ATOMIC_SLEEP generate a warning when
> + * resctrl_arch_rmid_read() is called with preemption disabled.
> + *
> + * The contract with resctrl_arch_rmid_read() is that if interrupts
> + * are unmasked, it can sleep. This allows NOHZ_FULL systems to use an
> + * IPI, (and fail if the call needed to sleep), while most of the time
> + * the work is scheduled, allowing the call to sleep.
> + */
> +static inline void resctrl_arch_rmid_read_context_check(void)
> +{
> +	if (!irqs_disabled())
> +		might_sleep();
> +}
>  
>  /**
>   * resctrl_arch_reset_rmid() - Reset any private state associated with rmid

-- 
Thanks
Babu Moger

