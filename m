Return-Path: <linux-kernel+bounces-15928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A30B8235C4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D522875C8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505BC1DA5B;
	Wed,  3 Jan 2024 19:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IjxFIwkH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42541DA4A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bal1GnlrkLUXq0GM1UQ/xeUgb9JOK4kiHlmBbwxq0+9ZeZvMjwos4+aLd+Ut9M/Qi98MzlU2jif2FuxmUwyhjnC258M0rCY5+cMKvRxhPVYrKwzLHTdX+fwIP5as5D3WD+iE1DMhHu+u/i3zv8bgf1AUwWOjlymRgEyGbCsL88Z0ZKelIm7JZlkCyz0y1PmkhFYAT6pIDSjqHVSIOngLhwiTqdCEDtNsaGI5EhkBpC47gBftc6lJCu2aURUFi1YOtsiYBX0dKbz6w7vyIfrCrPfBJQAq2H3SLEGq5t81V42NLWKvexauO+fWHWQvBrnadQZMspLmWnGNpWcSElQk6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmL9NTM8c9c3jmk4ESf+2qiBhL4H4lgECpvGT1Wo/Es=;
 b=cM9Wg0AFzYA7TASbZ16jbLfMqaAIgUxhSvnxM5QvETou0eisNEaxyr6fagqHzFECRJWEN1No9ZRRFSc5d8DhLH5NPdMmpPkR2jnjwGo7yxmOuKMEVHAGt/2j8ptoRKkHvmKE6yC4o1WlnnXkbCamsTbBUV8M5Zpxa3bBOYOxS8VsrzYVk1Iqby1H8wTl5k+I3aWDLcX34xYkVG+WzJMOJ6l2V7/NImO18+jtxW07ztM+0XcLa4m05+GWfxbj0ZRFISKz2d7jgldkwc0l0tDOKLJsNVp8+LMy7jA8UBKhO0Mps2/lQPC9uSTED5Znicz7iWZmCEdlQiINiLQc82UtcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmL9NTM8c9c3jmk4ESf+2qiBhL4H4lgECpvGT1Wo/Es=;
 b=IjxFIwkHZzIJLQ5S3JkSkrtEkeiWxQJriZeFc8VvAuL6TFH/XN2PmBbFcuVyW0L80oXXy7DKQ0Bz7ydQHQrbiSgCX8U5PqulxQ+RVPXFi3TmWuc60pfrWYPxlfHc9PX8F7yJHMS9e5VBWJfVkCqNQbNm1+1OWfH3yZ+km0z5a5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 19:43:42 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7135.026; Wed, 3 Jan 2024
 19:43:42 +0000
Message-ID: <4283c1e1-5f3b-4e55-a40c-1a46b3d8e067@amd.com>
Date: Wed, 3 Jan 2024 13:43:40 -0600
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v8 19/24] x86/resctrl: Add helpers for system wide
 mon/alloc capable
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
 <20231215174343.13872-20-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231215174343.13872-20-james.morse@arm.com>
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
X-MS-Office365-Filtering-Correlation-Id: c64c30f4-a3dc-43af-621f-08dc0c944a7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KTAr0rfZylDLfoRKdh/GjmLnxue/9++kHoo1Nb4D3H3NWq1vwn+CaLTDbPAVvOb7F1S5e2MiaTGTa2xJ3Y6TbhElnFDHe3TNt8mpduPqE0ioFlHhRtIREjVw2CqUXZZdG2sMzS321JgN+p8rDdweKoS6njjaFSjqE7VycY4xl3QH7q1GiDbnWhY7FQt6odEiLJyDdGp7xyqe2KgdeipfRBv040zbPwWjzO37ucScmBtXnH58McNjllbqD6O1jvSZthtCPTe1wU/jEH1iVGxt5/FHc/0cpMQG04++9yhwXLJQo/M3AFj6/zdiQEBJw1Xjgw3YAFH/eGYBl6jUXMA8Vg/zlkfneVyj6mS7WNXyPnKnUhyDKBfxIWEo2lfNa9PL3OoDDxY/nBa4NzJ28x1pNRhxFhSOI6NWsXkeuW8x+S6xJDueiTe3pUAXal1XrIMsUQqN/lWGs0Yz/x7feiPpTIt0x0auSN2jYyzcEgYMcnwazZn/1NXIkoahrwitdssD/RD9qLl6c/ycIYZQCKKxSTDOnWst+PJtRmfE2AIqWq42Cf+w3SzSrlvI3YIK/9GKarabU2qpzjX4XpghJiwiiED9NmLkoJakinjIGnkj4RzZGa7Q1zwCZKpwqbWaRm/1cDVoZXP1cAoMP6MOUw8feQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(4326008)(66476007)(66946007)(66556008)(6486002)(8676002)(54906003)(478600001)(316002)(8936002)(83380400001)(6506007)(53546011)(6512007)(26005)(2616005)(30864003)(7416002)(3450700001)(5660300002)(2906002)(41300700001)(36756003)(38100700002)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFlnUGRvUXhlMkNSRXlJQ0lST3RkaS9MYzZxSXNtdHF6NDhhNUh2Q21WeWNP?=
 =?utf-8?B?SU51ZGg5NmhpMjdjTExpU0E1TjlybTBPS3NKdllGUXVIS3lIZnpTV0crK0J3?=
 =?utf-8?B?cDV5VVBBSG4vaVBtN0FzTFJlWDlVenJ6THdmTFZldkFCOVdwTWNkZk92OVBZ?=
 =?utf-8?B?S2dKREs5WFVaRmNHd2FhR2tOV0hxWjEyK2JzdWhPN2tBT0x2cm9qN1hBTEpU?=
 =?utf-8?B?OXcxSXFRd3EweEdxang1UWtCL2MyMDl6WDNoQU9qMTkzbzdhZ1oydm5iMmZq?=
 =?utf-8?B?bndTV2srelYyeEdVSERqYXg2eGo1cExHQlBxc3piSVQzWjhXR0luT2xzQTVH?=
 =?utf-8?B?bnlFY0E1UGJvSGhHdUJqOVovSUc3dUVWUGc0UU9yeWdLdDhKdFpNenNwOUtn?=
 =?utf-8?B?aCsxQ3A5eWxQOTVXaXdJdUFtZFR4QnlORm92dFRtZXVnY3hkNEZLRXoxYTVD?=
 =?utf-8?B?dUxLWktYRml0TFB6b3hsV2JWNHc4UE83Z2I2dnY3cFJXd1d6aytZU2RLNTNo?=
 =?utf-8?B?aEl3aTRhZDlCWTd3b0J2eVU1Wm9manV0cmRwM1E1Qm9aUDFyblRqUlFLVUVC?=
 =?utf-8?B?VmZuK3hVNE03SHk2dHZmZm02ZmhEUlc2T2RKZ1FMUXFyckxPUy9pNitYazVR?=
 =?utf-8?B?eUdqYlMrNzNZZ0RnMmxvSDJiQ0drN09HZWZVNzk1VVMzWE5Uc0hrcmxXK0pq?=
 =?utf-8?B?bnUreEtXdldxaFFtNVJPRldsRzQrNTF6eUZodDkrNi9GdWo5REhvNW1mSmZS?=
 =?utf-8?B?d09uc1owQ1NOVTJNYjNtMEtSRjVMQnJ6Y1BoVkViMXQ5ZW9jcXphVkJQc0VR?=
 =?utf-8?B?R0podHk3emp1VzRNbnpiYjFOTHU4QjNRSjZSZjNTOXYwSWc2Mm5UVHJQemFD?=
 =?utf-8?B?Tm9IVjZvUHFPcVRmckRpVWYvL2ZCNXBqWGdtZVN2Mi9kMkRKSUNyaFVBSGhD?=
 =?utf-8?B?ZnpXOGQ2eWNMMFRNUS9MNHRxbzdrUVFpODR0MlZOVTlmQjJ4Q0FEUEpTc0Uz?=
 =?utf-8?B?S0YxR3Fzc0dScktScEdJNERrUW5MTVJoKzBFL0lCWDB6YkZrWUFsRFY5RlM1?=
 =?utf-8?B?NTJtSHRDdkk5dElkWlFCaGlieEthcXlNeWZnT2cxUVpVWkRCUFlOSHJzVUZq?=
 =?utf-8?B?eUtIeDNZKzUwSVYwRzdHanBXWGUreTFvN3M5b2w4Snl6OWJkalB4YjUvMkJl?=
 =?utf-8?B?UHphZC9RVENxRnAySDhiVGZmY01mVFR1UmJNUEhNWmM4cVNjbVI4QnN1S2p5?=
 =?utf-8?B?eDl0b3o1em5nRDgyaEtDSG9Qcy8zOGJTb2ozdGVCTitXNHNBblhzTlVON1Rs?=
 =?utf-8?B?M1JBVnRPeERPdnRmVGFhNStPZzF2L1pGRUgxWDBYM1dvb3R3aUN4REtlSHF1?=
 =?utf-8?B?NG93WDJKU2Y2c0FUY1pmY2xQeitjNm4wUWUrQm9QS2t5ZFp1U1M1Q1pwR2JR?=
 =?utf-8?B?d3c0Sk5QN1JRZWhpZFEvSVNwdW8rQ1RjcTRxbkJpdXdHSVBtTXI3ZWlzK3li?=
 =?utf-8?B?SDhNTFNJVWFVRFBJL2NUdmNQcmhmbktCSmppREhDL0NaaEJjenJ3VzhwaGRJ?=
 =?utf-8?B?dXB2R1hTaktOSXlsWjJDTlpBcEI1ZjZMeGRBS1E3MU5LK1ZOVWdaUi9EZjZ2?=
 =?utf-8?B?YXRxeURkNDI3ZTdWMnpvdW5uWCtuQ2pVR3Nka3REaDU2S3E3RFJKeDJucTZs?=
 =?utf-8?B?a2xUZGh4eEVyMjZubm5jRVU1Q0VHQ3RaVzU3V3k3S21BWHhLRUo5WllmdGlW?=
 =?utf-8?B?V2NsbGgzUytUOFJxR2R2UFVvQkJibzBjVXZpd1RnYUlnNlJPcXQ1dG9YU1Qx?=
 =?utf-8?B?Y1JucEo1bmQreXZtdUcwbUduVG5DaUZzMG1CM1M1dzgwWnNmV0NCTTEyUjhm?=
 =?utf-8?B?VTZETkxhV2p2UERyQXVnRk5HTVpGeTdXTzlsMmpZQVRrRVdEWXhCYWhaUTFQ?=
 =?utf-8?B?RnM0b0hQV0JxZWlpQkJrR0NpWVp1cmp4bGhtcHhBdzY2WEloaW54bVRzS2lH?=
 =?utf-8?B?YVFOdGFSYnZHeU1KVk5PM0RGUDVDSlA3MFJBNXJOb01abFp4RlJPQTN3UXk2?=
 =?utf-8?B?M0FjbHc0Q1VLM1V3MnkwaTl1S2lKZDNjT0xsSmVQUXFhSFZxY1lmOEtFc1V4?=
 =?utf-8?Q?ZK6s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c64c30f4-a3dc-43af-621f-08dc0c944a7d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 19:43:42.6348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: to7hgIX3CET7La/HraixZZ+Rvrrcf7z4WOjqHFKK+3K4GTlYJvN3Gw9qYLAgutMh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813



On 12/15/23 11:43, James Morse wrote:
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
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>

> ---
> Changes since v1:
>  * Added missing conversion in mkdir_rdt_prepare_rmid_free()
> 
> Changes since v3:
>  * Expanded the commit message.
> 
> Change since v7:
>  * Added a few missing resctrl_arch_mon_capable() that crept in during
>    a rebase.
> ---
>  arch/x86/include/asm/resctrl.h            | 13 ++++++++
>  arch/x86/kernel/cpu/resctrl/internal.h    |  2 --
>  arch/x86/kernel/cpu/resctrl/monitor.c     |  4 +--
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  6 ++--
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 38 +++++++++++------------
>  5 files changed, 37 insertions(+), 26 deletions(-)
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
> index e3e42736fb22..95020b113ee5 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -839,7 +839,7 @@ void mbm_handle_overflow(struct work_struct *work)
>  	 * If the filesystem has been unmounted this work no longer needs to
>  	 * run.
>  	 */
> -	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
> +	if (!resctrl_mounted || !resctrl_arch_mon_capable())
>  		goto out_unlock;
>  
>  	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> @@ -876,7 +876,7 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
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
> index 74a8494a0c91..89aef67588c0 100644
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
> @@ -2637,7 +2637,7 @@ static int rdt_get_tree(struct fs_context *fc)
>  
>  	closid_init();
>  
> -	if (rdt_mon_capable)
> +	if (resctrl_arch_mon_capable())
>  		flags |= RFTYPE_MON;
>  
>  	ret = rdtgroup_add_files(rdtgroup_default.kn, flags);
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
> @@ -3417,7 +3417,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  
>  	if (rtype == RDTCTRL_GROUP) {
>  		files = RFTYPE_BASE | RFTYPE_CTRL;
> -		if (rdt_mon_capable)
> +		if (resctrl_arch_mon_capable())
>  			files |= RFTYPE_MON;
>  	} else {
>  		files = RFTYPE_BASE | RFTYPE_MON;
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

