Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E9B7E730D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345226AbjKIUsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345186AbjKIUsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:48:15 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD05C4239
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:48:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LD7n/KnYp/wuw+wgwTRWxQYvOiJzhttUDanr1lDaAiZcLT62WLgDXooOEB+nvWCKWi8rqXQDER8uQ9ed0WlYaFQRb/Xiv2eALHvldxsrOErTfL4rMPp6IUH/5Gvqq4+fAn/ez4qO7LQY2aUosvo19cLWJzvLDffqVZ+VtFhHZy+kaC2MRcTGUTSOEDjvQJSxJqwtD8kQMMBp4xWi+RUcTx2R7xqmb9/LdSMwGZL67t29Ysm/Lpf9tiFjaE7esYxjzTT3k8JtuEfej/8O1Fh1Uv+rV5JmSbf2UvsWYz4OcTBrs6UuwYcOeCI6ezEbFIq5nUXkzNrTs+qpXIpQwY0jWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojVSQRQU4wju4nVlu89PADEDW7mFoa+O75kVlbZirZU=;
 b=N4rijXRTVwKaliDIuT85hkYa0dJWBkQTbyOyRcb40FtnFAXvZn9Obhh2kyirOeLCvM1aQlAHGMeKezggQg3MU8eEddqd1bHkUpfuWJxS4t1HdjJ8Vvc/+gP7P4aSnVBUP8XeY2/D6xIqbH3BuT3hnVLfKgc+3KvPYvDVWhslL3nfMKUvzMu+G7wEDPO+Tfq5w9ei8MZtgBlTM3Q1zrCJHNAph2guW8mVr0YrYGHSwx3cYgnzNmKgKuIs/VrAvJaqFDJxV5ljPm3cY/iZwGXS9tMy7OYrjCSFYDmulPmMfXfXrqpqUi07poXlLdTJAdCcxTmX6qldY46vbPN7TPdKNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojVSQRQU4wju4nVlu89PADEDW7mFoa+O75kVlbZirZU=;
 b=IMNFexJkUERDaesAFHeyYfQPXRgZof4NoD9VxH8MQDKYkydEVfNjBTsmcvKP9EXyIxCo5sRKb7j4yVCEBKcR+9ABdVg46LNC5G9i49OdlrbXRzrggudFELRc5mLtfnuC6yPPg6ebyeOisu+mG4BJ1VEkjekXEP9LwG1eFU/wINY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 20:48:09 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 20:48:09 +0000
Message-ID: <4153b90c-5b1d-42f3-8647-5711809781a2@amd.com>
Date:   Thu, 9 Nov 2023 14:48:07 -0600
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v7 17/24] x86/resctrl: Move alloc/mon static keys into
 helpers
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
 <20231025180345.28061-18-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231025180345.28061-18-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: bbb8930b-83c1-4550-cd4c-08dbe1652e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tB+p9RHlCmxlysgcz9NbGOjXRCU+m2Clboht+/G0cbATtE5k8rpwsgNEKoDUzLLJh1HJnuut9IqBmwkyvtN0TNKSA2ipQDrZvrNLJi5NA3RQhnsSXNv8aSo0XdRt+neP9kuep8odxNZ3ynshMj7nonCpsFvvt549eD7H6G2qtDESdzbUyEVBJ0aAsaamDstgGBzaBtNSyZ0o19Bnyssj1PDEEQa9h4T6hiYVWUw4zqvEPUp5eaxG/paG2qWRtBKwCuQIlYLF4B2ZNHcOawHDFsr8/QsR9y9dw4k83dsVYb18i0UujzdllhU3GutRJ6BD58DH1T1KHyyS44rVWUkF/aJxWO6lQ1jsMABpKTEbaRZuKtEMGTtIc2TNMSEdxVUGb5IN/KBXLod4WyYnhOZVMymZG+jc9DUOu7u2A0EOFJQ7oiCBuICc3Aj/ygcSc/GMS//k+OPIZZo4isIGjB37A4kVC8zqJZNDSCxRTqk78OsdjzRPwr+4yA+YZqgmEUcrief8fvIyJXYJ4VGAmQB6q8XGv1p4pimoEsk81gMRlkUvImdEvSq8UNnjAFKWdcuKKCFrSq3FrD3zxjVgLd8CUyn5uDXEAHQ0vZJ7/TWEjlTcvAk20LXXdzRBc9+4lwWt0GlfIEFg04ZqK5B65PzneQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(86362001)(6506007)(478600001)(6486002)(53546011)(316002)(6512007)(26005)(66476007)(66946007)(2616005)(41300700001)(8676002)(8936002)(3450700001)(66556008)(54906003)(4326008)(7416002)(5660300002)(31696002)(36756003)(83380400001)(38100700002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFN5dGovdUlleVl1OHMrcVFJMXBGRkdsTVVKdVlISkd4VDZaUG1lMHB0ZEwy?=
 =?utf-8?B?cWpOZXMvK3RnanV1WldaTG1mbXQvVVVDTk9wRWxsSi9UczhVT211VmVpVkx0?=
 =?utf-8?B?dWRWamVnSnRzaE9oSjRicWZkb3JGMU1hRy8zQ3o1ZjdQOTVDQmJzQkN3WXNN?=
 =?utf-8?B?cUpNSGFmZnVDSjZKRnVkWHR0VUxxcnpTVURnK1hzYmF3elBBOVZGZjFMdmNN?=
 =?utf-8?B?dFUyWTU1S1BWcE9pa1ZoenU4Z28vN1I5VlkzZ3luY2JpKzJqYzJheHFwRG04?=
 =?utf-8?B?TlF5dTNJMXFPaTdMQVdtbUdEbU1HZGhwYmJIUFhUMG1lcVFuMUlCVis1NGlL?=
 =?utf-8?B?QnV5RlB3cnlwMUNGOHUyTFZOSGtjdklGZktDa3lnK3U5YzlnakZ2cG9tL1dO?=
 =?utf-8?B?ck9YdmdBWEZpaEVYSzZuVGRxYldpakg3ZmRHVHBrWWJHYlp6TE5qQU1JVXo1?=
 =?utf-8?B?M1B6ajh1NnZnMGRvckhsSlJuNm9kendSRmU3UmZOcVNGc1RBb0dlVTBKY1c0?=
 =?utf-8?B?b1BoSHFXcG14R3oyZHFJMzZlZExlcWg1S29CT1lqL0dWTDFXWmZoc3VVR0dv?=
 =?utf-8?B?ZzNaeXNUbjFCaXVVeFJscmtlenpMTis4UXA3TDRUVVpnS2xzZTk4SGd0a2xZ?=
 =?utf-8?B?TTgrWUtqK3ltWEU5NVV4TjN1SFVzbGpLS3BFWG1ETjRwd0lVNGlicU81MUIz?=
 =?utf-8?B?UFE2bElqc25kUk5RVGJMYzNVUFUzVFVoSnJyNzBqUXhvTDR3cW5NcHY0SkVK?=
 =?utf-8?B?ZzhLakxHOXNUTHY5VWZEUkpWY1RnV0NmU1grY3MzL3Q3WmU4V0dJcy9sL0p4?=
 =?utf-8?B?anhqTCsvOXZyb3JmSzRWdmJ0ejRuVlVtcStlcS80VzltdFlhMzBYVC9RbU9W?=
 =?utf-8?B?U1lxMFZNamFxSFNkaHlQS2UyRmV2RURlYXhzbmNlNWFaRVhYanQzWncySnh5?=
 =?utf-8?B?YzluS0tEbzNWcXNTSHVhN2NERWJEQ1lXaUZmQ25DUkdBaFpoNk9VRWdiTDVT?=
 =?utf-8?B?NlB5ek9NTzUwS2NVRFZ3M1pGdnJ3K25ud1VxUEZCai8rejBvbHdqS2M4dFlX?=
 =?utf-8?B?T0J4SHJVRmpDNDR0eXFUTVVOYmFwRGJzUDhUMXl5MkU3MEJEeGRkc0NWTzB5?=
 =?utf-8?B?T1JIQWp2K2U3ZHhWdUNJZ2JuQXIzWW9mb05IK3FOTWM1Ylc3MThuSktwbk1Z?=
 =?utf-8?B?Qk5nSHhlMGtwOW1aMWF5c04zZHlNVllFWEI3TGNsaVF3SWFQY0huRG9EdTZ4?=
 =?utf-8?B?dHBsdzhoaGRzenVLQ255L0lVbG5JWjVsaGt1TkpmeUtMUTlMMlBYWG9XS3pT?=
 =?utf-8?B?SzQvSk0rR2xDbXovTEs5UnFGUlF0bTVndGtDUzh2K3p5eGJtaXJ5TXdUSHJL?=
 =?utf-8?B?TjdUMk4rT09OeTNyTHVzVzRDNndqdTd5SG4xNlpFL29IWk1PN0VRdDVmeXlO?=
 =?utf-8?B?ZUh3c3F4bG5mZzRrVkd3dzJEb1Y0eHVHcTRJVURaMVlUdVIwcVd3VGlkaFN0?=
 =?utf-8?B?eXYrYUhmQXM5VVU3SnRnRGovaFFjdmQ5bHI2NnpvbUgzZFl4WFMyRlYzNGpl?=
 =?utf-8?B?b0tvWFhYY2FSa2NkckFBM1FLcGpaZmpOQnNsV1lRUkRvaml2WWV4S1dsUUZU?=
 =?utf-8?B?TU5rcGs5cnptNDF1ZDlwZlhvK0ZBa2RQM1ZvL253SEk3dlZ0RVlhUVExNmRl?=
 =?utf-8?B?T3R1WllPMU41NEk2N3NhSmdoMkR5K0pmazJ2TEd3bUUrcUxyQkxmMWQ5QVJy?=
 =?utf-8?B?aHBYUkwvVE9iM21XZU9jQm1sVGg3V1dQSWtmcmRhQ3l1NFlCZzcvNE1TRzRj?=
 =?utf-8?B?YlY5TTgwd0U3Y1NNNDJLWWZYaGwxU1lCRTUzVnhPcFp5a25iZHVxdzM5TUNl?=
 =?utf-8?B?OURVMXRtRFV5YXlBQ1VQc2N5enpuKzdFYkV2bFNiYThpNVpobUF3Wm1IT0Zm?=
 =?utf-8?B?Y1N0NUh4SC9ZcGdZckxtaFhpNmRBQ2ZNbHNSanJJV01EMlpSQlMzenYrVTNl?=
 =?utf-8?B?amU2cnZWMjhLMXpmcEZMbTA1VWQ5bnNyelVhT2Z0ZWNYOXBMaE5DekgyQkdO?=
 =?utf-8?B?QVFZRTlXR0FaSFhseWNHTThUa0xSWFV3alZ1c3lGb0loL1FnTDFCYWFvWk9R?=
 =?utf-8?Q?LkcU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb8930b-83c1-4550-cd4c-08dbe1652e7b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:48:09.2372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Axhbd4kxPfD4o+hON/EvvHMgL/0jzQzb+9pJikufEwqehGrSOD6WMyHSs9qI2dCC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/23 13:03, James Morse wrote:
> resctrl enables three static keys depending on the features it has enabled.
> Another architecture's context switch code may look different, any
> static keys that control it should be buried behind helpers.
> 
> Move the alloc/mon logic into arch-specific helpers as a preparatory step
> for making the rdt_enable_key's status something the arch code decides.
> 
> This means other architectures don't have to mirror the static keys.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>

> ---
> No changes since v6
> 
>  arch/x86/include/asm/resctrl.h         | 20 ++++++++++++++++++++
>  arch/x86/kernel/cpu/resctrl/internal.h |  5 -----
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  8 ++++----
>  3 files changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index 29c4cc343787..3c9137b6ad4f 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -42,6 +42,26 @@ DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
>  DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
>  DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>  
> +static inline void resctrl_arch_enable_alloc(void)
> +{
> +	static_branch_enable_cpuslocked(&rdt_alloc_enable_key);
> +}
> +
> +static inline void resctrl_arch_disable_alloc(void)
> +{
> +	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
> +}
> +
> +static inline void resctrl_arch_enable_mon(void)
> +{
> +	static_branch_enable_cpuslocked(&rdt_mon_enable_key);
> +}
> +
> +static inline void resctrl_arch_disable_mon(void)
> +{
> +	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
> +}
> +
>  /*
>   * __resctrl_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
>   *
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 5ce49503fcd8..68b9beed8e42 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -95,9 +95,6 @@ static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
>  	return container_of(kfc, struct rdt_fs_context, kfc);
>  }
>  
> -DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
> -DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
> -
>  /**
>   * struct mon_evt - Entry in the event list of a resource
>   * @evtid:		event id
> @@ -454,8 +451,6 @@ extern struct mutex rdtgroup_mutex;
>  
>  extern struct rdt_hw_resource rdt_resources_all[];
>  extern struct rdtgroup rdtgroup_default;
> -DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
> -
>  extern struct dentry *debugfs_resctrl;
>  
>  enum resctrl_res_level {
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 9ce1f981c8e1..48418857b685 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2673,9 +2673,9 @@ static int rdt_get_tree(struct fs_context *fc)
>  		goto out_psl;
>  
>  	if (rdt_alloc_capable)
> -		static_branch_enable_cpuslocked(&rdt_alloc_enable_key);
> +		resctrl_arch_enable_alloc();
>  	if (rdt_mon_capable)
> -		static_branch_enable_cpuslocked(&rdt_mon_enable_key);
> +		resctrl_arch_enable_mon();
>  
>  	if (rdt_alloc_capable || rdt_mon_capable) {
>  		static_branch_enable_cpuslocked(&rdt_enable_key);
> @@ -2951,8 +2951,8 @@ static void rdt_kill_sb(struct super_block *sb)
>  	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
>  	schemata_list_destroy();
>  	rdtgroup_destroy_root();
> -	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
> -	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
> +	resctrl_arch_disable_alloc();
> +	resctrl_arch_disable_mon();
>  	static_branch_disable_cpuslocked(&rdt_enable_key);
>  	resctrl_mounted = false;
>  	kernfs_kill_sb(sb);

-- 
Thanks
Babu Moger
