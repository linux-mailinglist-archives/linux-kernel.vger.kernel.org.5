Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA087E72E3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345125AbjKIUcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjKIUca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:32:30 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77D24697
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:32:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9kxsTzTpn5hYZV/TZWOinTsppqOCtHtrzDKJwWMQHhgNi2y16wQkxvWdksa0IJfht0mXcVQRguHWdQGDh82JiWx4D7ZpLStvYI1m28stJszt+aqxPCy5Sbtc0rMnrfgU7P/SdL0TVxhD1ekRHDYo3Hme76Rbtgk0aXLO1Z/lihLhZIZROQ3n/eplWD6HCka13t8h9Wm9Otj27S7yhMfFHz5bd+iavyNR9ZOE6rr9OjqZ5/VCXWn8cw4XZCVDIUytF+4Aghs0N4t6ZX6WmIKzF2QxPhzG6GL7ZM6JwOtCyFFQBnwmIf+N6EcdWWfks6jlxe9mr95yxKAxlKt8OHSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpW/ycPRs0pouePNs9E1wPrYmUTws1bR57K44w5kIx8=;
 b=VDorK/5uFr5++8B0f/HdjV1tr0sXMLOHQYHqxVYmN6WG4hW2xOv93scpH9v3dz3/7ZQDs6g3eztOtriyRlaVEOdigGXWuYUGGoZH1LvzjK6y7W2pD0xX/A8VE/UJiortSu79REUJmDsKuB8AZFjGSc2qFnGE8CRiRDXV9THDCyhQM91tfLlZeFSE4DT4jOCj4ohFQIbzniO86hwBdX+aAJyXQ9NomcK1ffGN1Y7Rt/i2XldEHUzooH1Rqrcw5xq8udoqS8Dyqo4ouS2S6rtTB7wLf06iHnTROR4LMs+No6HVfr16EY+g4IXqnrYFJhCMSs+HvaaQQFfS/ojCkLZrsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpW/ycPRs0pouePNs9E1wPrYmUTws1bR57K44w5kIx8=;
 b=D6MENboRfcJCvFlaA2WyA1fZMNf64Q+M6SDNhEmXG3noG64Yg6ex+A9uXCYNZRxe/bjSS3u0jrupbDGAOgaeU2hbuC157P5cUoGN4bPyExjb5NmwGJ0gP+cOm0yhGzYDSbi2zKiT4yRqLIxHdtyERZ/uG0MoVDUeqLW6v8pamgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 20:32:25 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 20:32:25 +0000
Message-ID: <8f5708f0-ecc1-4de6-9053-f7639d297643@amd.com>
Date:   Thu, 9 Nov 2023 14:32:23 -0600
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v7 06/24] x86/resctrl: Access per-rmid structures by index
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
 <20231025180345.28061-7-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231025180345.28061-7-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0086.namprd05.prod.outlook.com (2603:10b6:8:56::7)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b136ad-d58c-474a-8d52-08dbe162fbd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xHY3sjbdPWllW+T7AwDpTKNpwvaLd50XXZINPGDS0SPPj64qNVpCkqGlPcdpyEtMhOs8XE0S2DlmMMnb1EqvpTpPxFC5j9/AykehMCy+9aw5sGpT0RF3+1lNGeKfonGKXOLukOMEspPatlOGT5gYZjS7bLtwqWQphiTvdkzOGu516KXBt7G79k7IOR6iSDZeWD2BXuWLb9EsFhiF1k68/LyjcMwrmTi+Ug2FVonwdfgcYxUcWMyhRCIUoUmD0C3IAAQA6xcjZX53oEbXYUCOEVWmQOfOU0OE1bGHQgDlOHay1S65mZCO7q1ZAqHtI8NrILbLNBY7fik6qk/3+xCcmPfBt3iOo7mcrw2/SBKCdS27XPJuGrPQSYYwCTGRU4IJv4OIO2QrDYYEJ7c+xYPpiCKLcbnfnkbuYPNAOJkog7IzrA2gwqQIfi5Vv/QRSPyzWew4qzTY6Bc5yeEWkU7gkA7L3qPQqog7CRWuiC+LMdDz83uCDN6Q8vSu2JoD6IbNJ0jX3X7i4Pu+Vr/fe2jFydPw/LkvVmtEDVSbHXkwGt9BYyzNY78wufFUoGrJjkFU2Z8G/BPMjQP1FpsokBOIzDsALEnWj/EnSinio3kBnxwaxb8NatjX05/5XqbIt0Wep5KGwxPz3ah9E2s5Z+SPCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(53546011)(26005)(6486002)(478600001)(7416002)(66556008)(66946007)(2906002)(66476007)(316002)(2616005)(6512007)(6506007)(8936002)(8676002)(4326008)(5660300002)(3450700001)(30864003)(54906003)(41300700001)(36756003)(31696002)(86362001)(38100700002)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmNHdTc1WlpoV3FtK2NJVWdBS1hVTkVRUnBuSUhRYWRSVjRwZU1Qd2t1QUFD?=
 =?utf-8?B?azhiMzBPT2JIU0QxcVhwcE9vQ1FOLy9CZCtOS3NOSXpQdlFoelhQKzRYdWZY?=
 =?utf-8?B?OHorZGxEenVndFI5UjNJWHl1TVZWNUE5N1cwUlhIVnloWk11aGJiTlhGQTBE?=
 =?utf-8?B?OWhQQjNKSzlrUHFxVFA1eVZnMW9Wa2dBeVUzMnhycU1ZQXhGdEFsS1Y4WkxT?=
 =?utf-8?B?UjNFMlNvVXlzdVJnRTJsZWRDdkxJQWM1ZGM0WUVHYkZpUUpJQmNudEZEYmtX?=
 =?utf-8?B?REhhN0J1MUErbEt6NVg0bHMxUFpOb2dGOGpQazRYbU5wNTNudzRNRE9aamtR?=
 =?utf-8?B?SjV6WmhuT1RUZlVQeDZKbE5QY3VNNW1Kb1ZYcUJJMG9xWkNCWmcrVTdRNEdE?=
 =?utf-8?B?N2xsWmx4a2hPc0x1MUpzUzl6QUpqU1loMFVxWEoySjJWcjlSNGNUeUNmSEI1?=
 =?utf-8?B?cFJ0TVZvVk5FOTdXYXBxaHVvMkkzZFRqbEJLOGdmWnZZUGY3SGhjUVZwcFRC?=
 =?utf-8?B?cVR3TThLZ1dTL2VVcE5WRVlKRUswNnUwWUFPL0EveDZESkJVWEJUWjMyZ0RY?=
 =?utf-8?B?TldvUHJqRmRrUHVYTnlZNjNLWFgrK1NENHdOZkhKTk8ycEZ1Y2hLdXQrbU1C?=
 =?utf-8?B?NVUwL2I0NS9IYUxJU1h1NWtZTjRwVDhwMUlyZW1uQ29sTFI2aHVFNWpBL0Zk?=
 =?utf-8?B?QnljbklacnZSUjh3N0IzNWg3V1NDRFRZcURIYzhIc2ppWEMrV2JLMk9taFpX?=
 =?utf-8?B?NExEQnZEb1FKWVdqdExUVlVpbXI0NStma3ZDTWlrNlR6WW9xbkRaNjNrT1hk?=
 =?utf-8?B?VU9hSzlnMWJlRHlIWnpVVlR6cm51bHdMWkplZGk5dHdQdHBpU1VvUTlQQlp1?=
 =?utf-8?B?MGQzNmZWdTlRaWxNUlJwZlRVc0hqVmllWko1UmsyM05qVUlyaytXZWRwVmVD?=
 =?utf-8?B?NkZwNEM1REtKNHQxU1E2M0U3VTMrQnFwZUt6TXNVNXRxV09wSDRwelNVRUNj?=
 =?utf-8?B?S1BjZ2lnNEFzS291NFEyQlJpbjYydnVRMDRJaEtpb0xPQVErdU5CSm9PNzg1?=
 =?utf-8?B?VXZGWm8xWUtPM2RXMmtFMmFUOGtsaFE2NkNJUFUyU3MwOFZZd0NsMWlYKzZP?=
 =?utf-8?B?d2xPaHNvNWZsMnhucUUyWTRqVGhQSW9PUkpOZ3RWV1g4MlB6TFRpYzc1MW5i?=
 =?utf-8?B?aHZNaGFmR21JMHJ6a2dsNWphbmdCaEwyNURtYWJ0OE53dHBLelJTQWU3VDZN?=
 =?utf-8?B?cXMvQkhnQ1ZLS0x6OFc1NGd2VWZEeFVONThXd2x3ZDRncmQvcTVwN2kzM1lP?=
 =?utf-8?B?SWdZMDBOMVJHVVJpOVBzd3lSZWRUOEljYjNVUHJlWDViWk9PVUVVNEZpUWJ2?=
 =?utf-8?B?d09vMVc4bVlneG9BY2x0RDYyQ2wvWFJxdUNHU3VBUFN5RDkzQThSOS9OOTZH?=
 =?utf-8?B?NzBNUlRzbitLR1BmemViazNUTm1GSDJMTlVoTWxPNEo4b3RWNkd2d0Mvdk12?=
 =?utf-8?B?UjA4QTdzM1A0dnRuMlZoRHNVNS9VZTVqdkZTOWV0V0phbysxa21xMW85bjZ0?=
 =?utf-8?B?SmZma1ZmTVNlMHdsV3VhQUVQcXNhcy9aTGRJTzBYOWxweE4xV3FVUkd3aUVt?=
 =?utf-8?B?dG9sZTgrckduWDJFY3B6TzYzWlBPZXpveVUwMDI0Y1U2VDhDeC92K2kvdTdm?=
 =?utf-8?B?Z01HNkE5ZTl4NDZDM3RhTkhPQWYram16dW5IbHptQXVGeDdRSk5zbm8yNmJ6?=
 =?utf-8?B?THV4OEJxUjU5RWgrbHBpRXE2U0UwK3VhMXpHNjZnZlpyYTMrUUd1SkNGWnBW?=
 =?utf-8?B?TXBHc1ZCUnF2VXlLYUx3V1NKRENWbUkxa0VvV0ZmM21hLzF4eTJ6ZVErWUNm?=
 =?utf-8?B?RVpGNFI3dksvVlV3K1UxZmV5cmhlNE5QdytTM3RtRDJFa2IxUi80eXJ0NXNY?=
 =?utf-8?B?WU1Nc3pQOEJReGpyTUxGQndKZ1REblp6bDFFek1xNVpEcVo4anVzUjN0S3RQ?=
 =?utf-8?B?QnB4SzRObHlYcUl6NjBnNUlHVndGaXRNV1JENmhvYWxWMStBV0FtYmtLWlJ6?=
 =?utf-8?B?bWlCOURxelpiSjJFek1jOXVuK2xlbFpVdUV4T1QveWxXK1VJbS9QSDk3ODNo?=
 =?utf-8?Q?j3xQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b136ad-d58c-474a-8d52-08dbe162fbd8
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:32:25.2607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXyYXoMd+cT8K9SRtJ837GAWK71dUWaFESaq4n/whuX4luGoYcWNPtNQYb5gN1gK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/25/23 13:03, James Morse wrote:
> x86 systems identify traffic using the CLOSID and RMID. The CLOSID is
> used to lookup the control policy, the RMID is used for monitoring. For
> x86 these are independent numbers.
> Arm's MPAM has equivalent features PARTID and PMG, where the PARTID is
> used to lookup the control policy. The PMG in contrast is a small number
> of bits that are used to subdivide PARTID when monitoring. The
> cache-occupancy monitors require the PARTID to be specified when
> monitoring.
> 
> This means MPAM's PMG field is not unique. There are multiple PMG-0, one
> per allocated CLOSID/PARTID. If PMG is treated as equivalent to RMID, it
> cannot be allocated as an independent number. Bitmaps like rmid_busy_llc
> need to be sized by the number of unique entries for this resource.
> 
> Treat the combined CLOSID and RMID as an index, and provide architecture
> helpers to pack and unpack an index. This makes the MPAM values unique.
> The domain's rmid_busy_llc and rmid_ptrs[] are then sized by index, as
> are domain mbm_local[] and mbm_total[].
> 
> x86 can ignore the CLOSID field when packing and unpacking an index, and
> report as many indexes as RMID.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>

> ---
> Changes since v1:
>  * Added X86_BAD_CLOSID macro to make it clear what this value means
>  * Added second WARN_ON() for closid checking, and made both _ONCE()
> 
> Changes since v2:
>  * Added RESCTRL_RESERVED_CLOSID
>  * Removed a newline
>  * Repharsed some comments
>  * Renamed a variable 'ignore'd
>  * Moved X86_RESCTRL_BAD_CLOSID to a previous patch
> 
> Changes since v3:
>  * Changed a variable name
>  * Fixed various typos
> 
> Changes since v4:
>  * Removed resource parameter from has_busy_rmid()
>  * Rewrote commit message
> 
> Changes since v5:
>  * Used RESCTRL_RESERVED_RMID in clear_closid_rmid().
>  * Added comment against free_rmid()s index comparison tricks.
> 
> Changes since v6:
>  * Added a newline between some #includes.
>  * Juggled some plurals in a comment.
> ---
>  arch/x86/include/asm/resctrl.h         | 17 +++++
>  arch/x86/kernel/cpu/resctrl/core.c     |  5 +-
>  arch/x86/kernel/cpu/resctrl/internal.h |  4 +-
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 96 ++++++++++++++++++--------
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  9 +--
>  5 files changed, 94 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index cc6e1bce7b1a..db4c84dde2d5 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -101,6 +101,23 @@ static inline void resctrl_sched_in(struct task_struct *tsk)
>  		__resctrl_sched_in(tsk);
>  }
>  
> +static inline u32 resctrl_arch_system_num_rmid_idx(void)
> +{
> +	/* RMID are independent numbers for x86. num_rmid_idx == num_rmid */
> +	return boot_cpu_data.x86_cache_max_rmid + 1;
> +}
> +
> +static inline void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
> +{
> +	*rmid = idx;
> +	*closid = X86_RESCTRL_EMPTY_CLOSID;
> +}
> +
> +static inline u32 resctrl_arch_rmid_idx_encode(u32 ignored, u32 rmid)
> +{
> +	return rmid;
> +}
> +
>  void resctrl_cpu_detect(struct cpuinfo_x86 *c);
>  
>  #else
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 0056c9962a44..fc70a2650729 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -589,7 +589,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  			mbm_setup_overflow_handler(d, 0);
>  		}
>  		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
> -		    has_busy_rmid(r, d)) {
> +		    has_busy_rmid(d)) {
>  			cancel_delayed_work(&d->cqm_limbo);
>  			cqm_setup_limbo_handler(d, 0);
>  		}
> @@ -604,7 +604,8 @@ static void clear_closid_rmid(int cpu)
>  	state->default_rmid = 0;
>  	state->cur_closid = 0;
>  	state->cur_rmid = 0;
> -	wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
> +	wrmsr(MSR_IA32_PQR_ASSOC, RESCTRL_RESERVED_RMID,
> +	      RESCTRL_RESERVED_CLOSID);
>  }
>  
>  static int resctrl_online_cpu(unsigned int cpu)
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index c836e3294e12..97ec24f91ac4 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -8,6 +8,8 @@
>  #include <linux/fs_context.h>
>  #include <linux/jump_label.h>
>  
> +#include <asm/resctrl.h>
> +
>  #define L3_QOS_CDP_ENABLE		0x01ULL
>  
>  #define L2_QOS_CDP_ENABLE		0x01ULL
> @@ -560,7 +562,7 @@ void __init intel_rdt_mbm_apply_quirk(void);
>  bool is_mba_sc(struct rdt_resource *r);
>  void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
>  void cqm_handle_limbo(struct work_struct *work);
> -bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
> +bool has_busy_rmid(struct rdt_domain *d);
>  void __check_limbo(struct rdt_domain *d, bool force_free);
>  void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>  void __init thread_throttle_mode_init(void);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 2a0233cd0bc9..c02cf32cd17c 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -149,12 +149,29 @@ static inline u64 get_corrected_mbm_count(u32 rmid, unsigned long val)
>  	return val;
>  }
>  
> -static inline struct rmid_entry *__rmid_entry(u32 closid, u32 rmid)
> +/*
> + * x86 and arm64 differ in their handling of monitoring.
> + * x86's RMID are independent numbers, there is only one source of traffic
> + * with an RMID value of '1'.
> + * arm64's PMG extends the PARTID/CLOSID space, there are multiple sources of
> + * traffic with a PMG value of '1', one for each CLOSID, meaning the RMID
> + * value is no longer unique.
> + * To account for this, resctrl uses an index. On x86 this is just the RMID,
> + * on arm64 it encodes the CLOSID and RMID. This gives a unique number.
> + *
> + * The domain's rmid_busy_llc and rmid_ptrs[] are sized by index. The arch code
> + * must accept an attempt to read every index.
> + */
> +static inline struct rmid_entry *__rmid_entry(u32 idx)
>  {
>  	struct rmid_entry *entry;
> +	u32 closid, rmid;
>  
> -	entry = &rmid_ptrs[rmid];
> -	WARN_ON(entry->rmid != rmid);
> +	entry = &rmid_ptrs[idx];
> +	resctrl_arch_rmid_idx_decode(idx, &closid, &rmid);
> +
> +	WARN_ON_ONCE(entry->closid != closid);
> +	WARN_ON_ONCE(entry->rmid != rmid);
>  
>  	return entry;
>  }
> @@ -284,8 +301,9 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  void __check_limbo(struct rdt_domain *d, bool force_free)
>  {
>  	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>  	struct rmid_entry *entry;
> -	u32 crmid = 1, nrmid;
> +	u32 idx, cur_idx = 1;
>  	bool rmid_dirty;
>  	u64 val = 0;
>  
> @@ -296,12 +314,11 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>  	 * RMID and move it to the free list when the counter reaches 0.
>  	 */
>  	for (;;) {
> -		nrmid = find_next_bit(d->rmid_busy_llc, r->num_rmid, crmid);
> -		if (nrmid >= r->num_rmid)
> +		idx = find_next_bit(d->rmid_busy_llc, idx_limit, cur_idx);
> +		if (idx >= idx_limit)
>  			break;
>  
> -		entry = __rmid_entry(X86_RESCTRL_EMPTY_CLOSID, nrmid);// temporary
> -
> +		entry = __rmid_entry(idx);
>  		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
>  					   QOS_L3_OCCUP_EVENT_ID, &val)) {
>  			rmid_dirty = true;
> @@ -310,19 +327,21 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>  		}
>  
>  		if (force_free || !rmid_dirty) {
> -			clear_bit(entry->rmid, d->rmid_busy_llc);
> +			clear_bit(idx, d->rmid_busy_llc);
>  			if (!--entry->busy) {
>  				rmid_limbo_count--;
>  				list_add_tail(&entry->list, &rmid_free_lru);
>  			}
>  		}
> -		crmid = nrmid + 1;
> +		cur_idx = idx + 1;
>  	}
>  }
>  
> -bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d)
> +bool has_busy_rmid(struct rdt_domain *d)
>  {
> -	return find_first_bit(d->rmid_busy_llc, r->num_rmid) != r->num_rmid;
> +	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
> +
> +	return find_first_bit(d->rmid_busy_llc, idx_limit) != idx_limit;
>  }
>  
>  /*
> @@ -352,6 +371,9 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  	struct rdt_domain *d;
>  	int cpu, err;
>  	u64 val = 0;
> +	u32 idx;
> +
> +	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
>  
>  	entry->busy = 0;
>  	cpu = get_cpu();
> @@ -369,9 +391,9 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  		 * For the first limbo RMID in the domain,
>  		 * setup up the limbo worker.
>  		 */
> -		if (!has_busy_rmid(r, d))
> +		if (!has_busy_rmid(d))
>  			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL);
> -		set_bit(entry->rmid, d->rmid_busy_llc);
> +		set_bit(idx, d->rmid_busy_llc);
>  		entry->busy++;
>  	}
>  	put_cpu();
> @@ -384,14 +406,21 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  
>  void free_rmid(u32 closid, u32 rmid)
>  {
> +	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
>  	struct rmid_entry *entry;
>  
> -	if (!rmid)
> -		return;
> -
>  	lockdep_assert_held(&rdtgroup_mutex);
>  
> -	entry = __rmid_entry(closid, rmid);
> +	/*
> +	 * Do not allow the default rmid to be free'd. Comparing by index
> +	 * allows architectures that ignore the closid parameter to avoid an
> +	 * unnecessary check.
> +	 */
> +	if (idx == resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
> +						RESCTRL_RESERVED_RMID))
> +		return;
> +
> +	entry = __rmid_entry(idx);
>  
>  	if (is_llc_occupancy_enabled())
>  		add_rmid_to_limbo(entry);
> @@ -402,11 +431,13 @@ void free_rmid(u32 closid, u32 rmid)
>  static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 closid,
>  				       u32 rmid, enum resctrl_event_id evtid)
>  {
> +	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
> +
>  	switch (evtid) {
>  	case QOS_L3_MBM_TOTAL_EVENT_ID:
> -		return &d->mbm_total[rmid];
> +		return &d->mbm_total[idx];
>  	case QOS_L3_MBM_LOCAL_EVENT_ID:
> -		return &d->mbm_local[rmid];
> +		return &d->mbm_local[idx];
>  	default:
>  		return NULL;
>  	}
> @@ -449,7 +480,8 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
>   */
>  static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
>  {
> -	struct mbm_state *m = &rr->d->mbm_local[rmid];
> +	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
> +	struct mbm_state *m = &rr->d->mbm_local[idx];
>  	u64 cur_bw, bytes, cur_bytes;
>  
>  	cur_bytes = rr->val;
> @@ -539,7 +571,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>  {
>  	u32 closid, rmid, cur_msr_val, new_msr_val;
>  	struct mbm_state *pmbm_data, *cmbm_data;
> -	u32 cur_bw, delta_bw, user_bw;
> +	u32 cur_bw, delta_bw, user_bw, idx;
>  	struct rdt_resource *r_mba;
>  	struct rdt_domain *dom_mba;
>  	struct list_head *head;
> @@ -552,7 +584,8 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>  
>  	closid = rgrp->closid;
>  	rmid = rgrp->mon.rmid;
> -	pmbm_data = &dom_mbm->mbm_local[rmid];
> +	idx = resctrl_arch_rmid_idx_encode(closid, rmid);
> +	pmbm_data = &dom_mbm->mbm_local[idx];
>  
>  	dom_mba = get_domain_from_cpu(smp_processor_id(), r_mba);
>  	if (!dom_mba) {
> @@ -670,7 +703,7 @@ void cqm_handle_limbo(struct work_struct *work)
>  
>  	__check_limbo(d, false);
>  
> -	if (has_busy_rmid(r, d))
> +	if (has_busy_rmid(d))
>  		schedule_delayed_work_on(cpu, &d->cqm_limbo, delay);
>  
>  	mutex_unlock(&rdtgroup_mutex);
> @@ -735,19 +768,20 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>  
>  static int dom_data_init(struct rdt_resource *r)
>  {
> +	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>  	struct rmid_entry *entry = NULL;
> -	int i, nr_rmids;
> +	u32 idx;
> +	int i;
>  
> -	nr_rmids = r->num_rmid;
> -	rmid_ptrs = kcalloc(nr_rmids, sizeof(struct rmid_entry), GFP_KERNEL);
> +	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
>  	if (!rmid_ptrs)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < nr_rmids; i++) {
> +	for (i = 0; i < idx_limit; i++) {
>  		entry = &rmid_ptrs[i];
>  		INIT_LIST_HEAD(&entry->list);
>  
> -		entry->rmid = i;
> +		resctrl_arch_rmid_idx_decode(i, &entry->closid, &entry->rmid);
>  		list_add_tail(&entry->list, &rmid_free_lru);
>  	}
>  
> @@ -755,7 +789,9 @@ static int dom_data_init(struct rdt_resource *r)
>  	* These are used for rdtgroup_default control group, which will be
>  	* setup later in rdtgroup_init().
>  	*/
> -	entry = __rmid_entry(RESCTRL_RESERVED_CLOSID, RESCTRL_RESERVED_RMID);
> +	idx = resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
> +					   RESCTRL_RESERVED_RMID);
> +	entry = __rmid_entry(idx);
>  	list_del(&entry->list);
>  
>  	return 0;
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index f64c13fe22d7..22dbdfe569a1 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3894,7 +3894,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
>  
>  	if (is_mbm_enabled())
>  		cancel_delayed_work(&d->mbm_over);
> -	if (is_llc_occupancy_enabled() && has_busy_rmid(r, d)) {
> +	if (is_llc_occupancy_enabled() && has_busy_rmid(d)) {
>  		/*
>  		 * When a package is going down, forcefully
>  		 * decrement rmid->ebusy. There is no way to know
> @@ -3912,16 +3912,17 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
>  
>  static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
>  {
> +	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>  	size_t tsize;
>  
>  	if (is_llc_occupancy_enabled()) {
> -		d->rmid_busy_llc = bitmap_zalloc(r->num_rmid, GFP_KERNEL);
> +		d->rmid_busy_llc = bitmap_zalloc(idx_limit, GFP_KERNEL);
>  		if (!d->rmid_busy_llc)
>  			return -ENOMEM;
>  	}
>  	if (is_mbm_total_enabled()) {
>  		tsize = sizeof(*d->mbm_total);
> -		d->mbm_total = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
> +		d->mbm_total = kcalloc(idx_limit, tsize, GFP_KERNEL);
>  		if (!d->mbm_total) {
>  			bitmap_free(d->rmid_busy_llc);
>  			return -ENOMEM;
> @@ -3929,7 +3930,7 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
>  	}
>  	if (is_mbm_local_enabled()) {
>  		tsize = sizeof(*d->mbm_local);
> -		d->mbm_local = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
> +		d->mbm_local = kcalloc(idx_limit, tsize, GFP_KERNEL);
>  		if (!d->mbm_local) {
>  			bitmap_free(d->rmid_busy_llc);
>  			kfree(d->mbm_total);

-- 
Thanks
Babu Moger
