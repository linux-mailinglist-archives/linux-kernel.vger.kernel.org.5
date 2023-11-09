Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE727E730C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345217AbjKIUsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345212AbjKIUsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:48:02 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EDB44A6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:48:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdGFJEZqfzE5/K0EAnPx39ScTnmhHehBp6rLYoBvjB/SuVTVzxuXm9+Sy8WEC3GVQsDY9FnLLJl+vtgeacj4FKtv5FFp2mdJEq1/IwXx+2ckk6hV2Wx2ZhscXf7UoG42kE8jYs/TpnCXp7r63YWPaVgcI1di4s9wQnldSFEL+JbAFcLgoRIAlMESLnzlfP2erYd5E3OTEVeeik/EjS5eExDZxc4fy6heIbt/anDrmhyNveXyql9BrYRx/eg2vvvsF0DDhhyMWyddx4hN3IhFkTcpjyEZ8RiVadwuDWz/Sz1SCwMc3MW6O0xXFYwJumuqbtaKnrVcWHvp2+4ZGiq7pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Uvil+pIEHAYN2gP5rg8Fyo3HiZ6YPItbGA4iwEQMrk=;
 b=ItCwwQRyt1v/ge6rbealh6UhTj0Wasx5DTfly9yWasMz1Kozm5yW9zUf+F7gIFvPxP4yIfDwIpQAFv03JhlaY3+rmuvXs1DOuG6gvHbUnS8yjoQt1tiXP/yb57OIpE8b5G8Ovf6Un2NgawIrCg5SPe152dCV9P47fy0pgDTPZH1hyAem56a1pOxLwE4VtrrcpVWTQjUNqnZAgWu4QXdMxMwcuvcCyjAKH3eMmPJL5JCbFXPSOLJ316ysj9Hc4pouHh6YSgzDILS5m6KQuuLEBrak1ekQ2TKTzztsEY928jpCWjJTm9RkCvd4BDLf/f9wuOtYAVgRJOco0ApEuVxvGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Uvil+pIEHAYN2gP5rg8Fyo3HiZ6YPItbGA4iwEQMrk=;
 b=tYGlWvrXGkpFtwjPZWGU0HC4bvWCrMAj88mV+BK5SDYYJJH66JW6R01mWZ9MnJT69s9lIM3pDXzwfjDkdWs820T0DS50t5FGYPAfhZobr43SfU5vjDjw8RZtYWRKi2bR87oqoKP/ulaLsg4cKg6amOKMBOfimjFvhatU6MeV1Yo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 20:47:57 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 20:47:56 +0000
Message-ID: <7e611640-9e7a-42a1-b0d7-f8b76999e9b2@amd.com>
Date:   Thu, 9 Nov 2023 14:47:55 -0600
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v7 16/24] x86/resctrl: Make resctrl_mounted checks
 explicit
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
 <20231025180345.28061-17-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231025180345.28061-17-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d1c278-fbc3-4269-e334-08dbe165271d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zYSfjp8Qo48pnhadXvUtrInFU9cy3lba2jRMvZyv1ikE4CeE/ZjyQsfxyaNlekA5MnwNMxyAYibAuT8gs1IMCgMG0RH4Qf/ZjHMl2wNDFyB4NkaozXVWR9TFwPJ9W4N7w9DKst8mX2pDyn4VbZcQAIQxS+DloOzGn6RhgL/UavTNIriC3wz9mMfnY1aQZDcqMe6S3IdhYhFPiKGqhuC8P6YR34Z7LeThqkBWPpNv+zevge02szxOtqKAH+xxcW7KE8O7kQAQcWlrbsWsF5uhfuuE+rxYVfND87+/FoRHMJo4EoMxyLM9AlobR2KqtCY8RkHPM6v+sJp9R2jx8fM4Bi5RO0DBh7jo0sctH3wxpzVrhwF9falmWeQpKnVYsz2Lys2Uub8zaaEP6IyDiuCQp30OEvYY2Gu4PYmMh4IKThjPA/LQV++Wo7cVTIxC0QGNMfsSVh6bs1y4BrzsQi6B81unWVomphZZe3PjcXdUtqsW24hnKoyJE6/NGZSgO6q3amwkYB2oLyncu4rECS4KqpB5ky2C0EAXus8zK0qROhLVguS47SYvOe0HnvS7PGBYwcroyp7CnWzq9o16EulTTwMR3Hqrsx82wiPc5TkUOVNNB9HsbS19fYUfA35ux1cU+J1qI3ZQJUhgo2UBNnQfZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(5660300002)(6486002)(31686004)(26005)(41300700001)(53546011)(6512007)(6506007)(36756003)(2616005)(31696002)(3450700001)(38100700002)(86362001)(7416002)(2906002)(316002)(8676002)(83380400001)(8936002)(4326008)(54906003)(478600001)(66556008)(66946007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjBoU2NvYXh5czZoU3BxUndGT0NncVB1cUw0RW9jNTE3cnhUSDFjazg4akJY?=
 =?utf-8?B?ZEZnYXpuUjVJVUxxMzE1S2FHRE5XYTg1MGkwVGE4cFpRSUxId1B2ZkdKMlgv?=
 =?utf-8?B?dFVPTHlULzN3SHFzaFpnY0dYd2tSd0RpUEExaU1FRFQ2ZzZrTmVzdi91bVNR?=
 =?utf-8?B?Snl1eC9MTlFFWnZDT0IyNExqQmxBd2MwVDFLNHJpbzQvcWV1VG9vNkwrSFlo?=
 =?utf-8?B?eEZaSHVaam1MdXU2bFVDOGVlVk9LeWQ3V3phWGh3UnJtTFg2SU8rTGpvRS81?=
 =?utf-8?B?by85Ym1Fa3MyOC9NbWVMVGdXSFRmbm8xR21mTW1ySW5PajhQRjdubXV4VFRC?=
 =?utf-8?B?cWZJblhuMlJ5L3RQMkxIL2ZUVFpqakgyN1VFNVZjUFVCZCs0QkhGenBnM1Bi?=
 =?utf-8?B?RXgwQ0lQalBXbDE2ZkRQMmZ2WUl3bGVFb0hZRWEyNTlrUnRscURGQUlQdk5w?=
 =?utf-8?B?NnFlSFlHR3NsWVBjTllkdlQ3N21EWWJIa2dUUkhzZDR3Yk05Vk5WRHpibklJ?=
 =?utf-8?B?bVJjemlOMUtjU29OUnNmZXB2QmlRREhLRis1U2prOWo1OW5RNWdOdU5WZ2Na?=
 =?utf-8?B?MktPTUh1a3F6bWE4RGU5UXkvTk9lb2JaeFJIeWE4TlNHVzdiaHg0NjQ0UU5z?=
 =?utf-8?B?R1NMWWZobHBQOFVSQ05aT3J2dXJESmR1VWh6VzVUUkF3andVSjlicUZTZUh2?=
 =?utf-8?B?cU04NFh3NTIwS3h3Rnc2OEpLWkhXOWtHYWg1WGhuNjFUT3JsWDgrWFJuOEFs?=
 =?utf-8?B?ZVpzNGtpaWl3UUxCTGdRTzM5ejlCdmlYWTQ4dXoreTVDTEIvZitodHNGMDhp?=
 =?utf-8?B?bTc4VHg1bkdqZHlxR1hTQm1TLzNKWGY0TEtxa1hkOFRSckY3cmt2b0RQWmRG?=
 =?utf-8?B?blJQSEw4RXBXUlBoRGlpK2YxQXZiK2xLWGlRTWw2cmpuNlZ0bkR6RUFQQ3Iv?=
 =?utf-8?B?OFB4cTRVSnU3TDdSVlFLMHVzNTVNdGxWNWFTb0h2ZmFQUWhydEtVMHdZNkFy?=
 =?utf-8?B?VGVvUTFsQXJubE9KVysrNVBWQytibnpJK1FpYnNVUEtlVDQ4cmlVejBGQW00?=
 =?utf-8?B?S0tFSWZPQmdGWW9nVGhTSE5sNTJSZHZlQTlLYVhTbXZ5OG12MVlBMyt3UXVN?=
 =?utf-8?B?RW9tWDBodi9OUEJrUzZiTmdMemNETXVDNU52THk3QzRFZ29CQnczRlJ0N01O?=
 =?utf-8?B?QXNVNTFNMkJFRGcvc09oMC9oTUgzUkFBYThwS2l5Uy9VS0xyUVhZRFJ5UXRK?=
 =?utf-8?B?dDF2TUs2azZTanhqc1Zjek42eFVCeHZiSTBQNTNtRUNqRUV5WTc2RG9XRCth?=
 =?utf-8?B?NitWOWIzNVYvYmVTeHFwS3RZT2NhMXVWM0s2N0R3Q3c2MWVuMGxyUmh0VnFU?=
 =?utf-8?B?RWdQSnM3L1VOYXlaL0pWSndxdHBSWVF3MHJKYStLdmJldDRWRUUvTS9RWU5u?=
 =?utf-8?B?S243TE15RnIraS9nMGNlUUN3MnFzWjU5RGRiUE5CbWUrWGVCVmF6RVV4VUNB?=
 =?utf-8?B?TituR0hGWGpPV3oxcG5iOHhVTHlPS1BzUC9HaWU3ZDJUcDU1b3NZQ0trdmUy?=
 =?utf-8?B?V0JIQkJ1ekpySHZxNU9UTXQzbEVyQWgybUlQNHBCMmkrZzBMb0NlU2MvVjJw?=
 =?utf-8?B?Q1FRY1Bzc2RWOXAxT1V1SG42bFVHTUxCVUptbU1IeDZIQ01oNGZZazRkOGl2?=
 =?utf-8?B?WTNKOVcxdnFKMytzL3p2RHRUUVE0bnJMOTJHNmpiajA3elFGbUF4VzJPQmps?=
 =?utf-8?B?STFuTTZpZ0FCK0JockRkUSt2WkJwUDhJQ3MzQlY2TTJTaHFXN285RVZiTTIv?=
 =?utf-8?B?clUxUFVaRTJhUGRrQVJrOXpyOGprVjVCTHB5WURpU2pVNnJwWXRFeVg1S3RV?=
 =?utf-8?B?cGVKWUg2NlhqcWhNcEhsRjZhOERhQXJuNUZUckx0WXlIUEQrQVBSUDNVUUE0?=
 =?utf-8?B?T3p3M3B6bVdpT09xenlBb1k4NFJiZDZUT3JLR2pPa1hnQmJYMDEyQ21qQWkx?=
 =?utf-8?B?Rk0vNUhlaTJSY05Id3VvdUNTN2IwN0c1b0YrMnVzUUh6U3lpa2RCMTFVcml3?=
 =?utf-8?B?MFlnVWgvV1p2OUxmY0NaVWtOd1FiNkN5ZkVDL2VVcExmY0tCSnBwTGxJTUlB?=
 =?utf-8?Q?67ys=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d1c278-fbc3-4269-e334-08dbe165271d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:47:56.8328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b6vlbrn1zgwzMXxU5guJ3mrP/yPJ5g9yNNNpa9R45xRHEeE4TJyGiUJrKJjmElyS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/23 13:03, James Morse wrote:
> The rdt_enable_key is switched when resctrl is mounted, and used to
> prevent a second mount of the filesystem. It also enables the
> architecture's context switch code.
> 
> This requires another architecture to have the same set of static-keys,
> as resctrl depends on them too. The existing users of these static-keys
> are implicitly also checking if the filesystem is mounted.
> 
> Make the resctrl_mounted checks explicit: resctrl can keep track of
> whether it has been mounted once. This doesn't need to be combined with
> whether the arch code is context switching the CLOSID.
> 
> rdt_mon_enable_key is never used just to test that resctrl is mounted,
> but does also have this implication. Add a resctrl_mounted to all uses
> of rdt_mon_enable_key. This will allow rdt_mon_enable_key to be swapped
> with a helper in a subsequent patch.
> 
> This will allow the static-key changing to be moved behind resctrl_arch_
> calls.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>
> 
> ---
> Changes since v3:
>  * Removed a newline.
>  * Rephrased commit message
> 
> Changes since v4:
>  * Rephrased comment.
> 
> No changes since v6
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 12 ++++++++++--
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 23 +++++++++++++++++------
>  3 files changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index bb07b9b01e36..5ce49503fcd8 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -145,6 +145,7 @@ extern bool rdt_alloc_capable;
>  extern bool rdt_mon_capable;
>  extern unsigned int rdt_mon_features;
>  extern struct list_head resctrl_schema_all;
> +extern bool resctrl_mounted;
>  
>  enum rdt_group_type {
>  	RDTCTRL_GROUP = 0,
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 1ca8db8c82cc..843df6f64e0e 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -837,7 +837,11 @@ void mbm_handle_overflow(struct work_struct *work)
>  
>  	mutex_lock(&rdtgroup_mutex);
>  
> -	if (!static_branch_likely(&rdt_mon_enable_key))
> +	/*
> +	 * If the filesystem has been unmounted this work no longer needs to
> +	 * run.
> +	 */
> +	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
>  		goto out_unlock;
>  
>  	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> @@ -870,7 +874,11 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>  	unsigned long delay = msecs_to_jiffies(delay_ms);
>  	int cpu;
>  
> -	if (!static_branch_likely(&rdt_mon_enable_key))
> +	/*
> +	 * When a domain comes online there is no guarantee the filesystem is
> +	 * mounted. If not, there is no need to catch counter overflow.
> +	 */
> +	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
>  		return;
>  	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
>  	dom->mbm_work_cpu = cpu;
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index fe6dfea471f2..9ce1f981c8e1 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -42,6 +42,9 @@ LIST_HEAD(rdt_all_groups);
>  /* list of entries for the schemata file */
>  LIST_HEAD(resctrl_schema_all);
>  
> +/* The filesystem can only be mounted once. */
> +bool resctrl_mounted;
> +
>  /* Kernel fs node for "info" directory under root */
>  static struct kernfs_node *kn_info;
>  
> @@ -881,7 +884,7 @@ int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
>  	mutex_lock(&rdtgroup_mutex);
>  
>  	/* Return empty if resctrl has not been mounted. */
> -	if (!static_branch_unlikely(&rdt_enable_key)) {
> +	if (!resctrl_mounted) {
>  		seq_puts(s, "res:\nmon:\n");
>  		goto unlock;
>  	}
> @@ -2613,7 +2616,7 @@ static int rdt_get_tree(struct fs_context *fc)
>  	/*
>  	 * resctrl file system can only be mounted once.
>  	 */
> -	if (static_branch_unlikely(&rdt_enable_key)) {
> +	if (resctrl_mounted) {
>  		ret = -EBUSY;
>  		goto out;
>  	}
> @@ -2674,8 +2677,10 @@ static int rdt_get_tree(struct fs_context *fc)
>  	if (rdt_mon_capable)
>  		static_branch_enable_cpuslocked(&rdt_mon_enable_key);
>  
> -	if (rdt_alloc_capable || rdt_mon_capable)
> +	if (rdt_alloc_capable || rdt_mon_capable) {
>  		static_branch_enable_cpuslocked(&rdt_enable_key);
> +		resctrl_mounted = true;
> +	}
>  
>  	if (is_mbm_enabled()) {
>  		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> @@ -2949,6 +2954,7 @@ static void rdt_kill_sb(struct super_block *sb)
>  	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
>  	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
>  	static_branch_disable_cpuslocked(&rdt_enable_key);
> +	resctrl_mounted = false;
>  	kernfs_kill_sb(sb);
>  	mutex_unlock(&rdtgroup_mutex);
>  	cpus_read_unlock();
> @@ -3918,7 +3924,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
>  	 * If resctrl is mounted, remove all the
>  	 * per domain monitor data directories.
>  	 */
> -	if (static_branch_unlikely(&rdt_mon_enable_key))
> +	if (resctrl_mounted && static_branch_unlikely(&rdt_mon_enable_key))
>  		rmdir_mondata_subdir_allrdtgrp(r, d->id);
>  
>  	if (is_mbm_enabled())
> @@ -3995,8 +4001,13 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>  	if (is_llc_occupancy_enabled())
>  		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
>  
> -	/* If resctrl is mounted, add per domain monitor data directories. */
> -	if (static_branch_unlikely(&rdt_mon_enable_key))
> +	/*
> +	 * If the filesystem is not mounted then only the default resource group
> +	 * exists. Creation of its directories is deferred until mount time
> +	 * by rdt_get_tree() calling mkdir_mondata_all().
> +	 * If resctrl is mounted, add per domain monitor data directories.
> +	 */
> +	if (resctrl_mounted && static_branch_unlikely(&rdt_mon_enable_key))
>  		mkdir_mondata_subdir_allrdtgrp(r, d);
>  
>  	return 0;

-- 
Thanks
Babu Moger
