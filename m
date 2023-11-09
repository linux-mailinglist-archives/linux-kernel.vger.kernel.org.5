Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D867E730F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345235AbjKIUs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345242AbjKIUsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:48:24 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CE544AF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:48:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VU2ygWyf4wZGWccPPWFvpcaBpC+U59cKkblpzEkP1jMIxmHoQ1anbMnfNzoMoQpP6XS8wNflMHbGySGQ3q4Rcp9aTTClGr6AWsZ3jufrlzTBHq6iDJFKAzslOv8L3CtCYhi+A4L57s1V9016UEgbHaYjn9Anat7AWRYMN/k3WdtZV9WXHVUYLgvCWD923yQj3Snlj0HSkE1c23J7h4vPyYQDqMvffm3DT5THWL/qeeOE8t64wx2SxoctBXzK/InGWSA3DBWyYRUVrKaZYO2Hm5ZFPrVGqg9OMtTO6SddkLxEsnLav1OjR3aVDVjBFstJJwHE3aQiBFbtedNHYcf06g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tucpwfh8r3ox0zwcHf17SIIvN7onLW254UsYcMWT5Fs=;
 b=BxbC9rC5zPu3SEln2R+tlbxox54Ubkb6m4p5XoNzwZoiRktvMSEGsXykcP1eD+Cj728Sm2JQtMplzguZNUTbYvYspPwdCWizJZ3hI36wZs4KL6hJ/eeH+C8QPOkBCsky05nY2ZC1ReUXMrv7mNXeMxPnQV6Jlyh3Cwa+gDDNyURRRWyaygJcOq0TtNJtpB04Kd5IZG9D2phX9SXHoh4qNLs3F9oeSHAZnC5x/o/jCWOtsoaa+sTzNtyVcrZ+yO++Xz/loF0EdMn3uoJNsHYw3xjWXMVB/oxm7dS+5+hxWcVArv6fyohk554zndwW4fuq1sbqlLdf4DKqUPYTWrGTqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tucpwfh8r3ox0zwcHf17SIIvN7onLW254UsYcMWT5Fs=;
 b=KOrm83DCWdbtU+oKx9d+d2gAIHPyl4m+iJKTGGOOWOTDvxyjzP0+liN2Ocr80St2HFvRZRgh2hzbh6etn+c6mMtuq9c+2IzqcHdk54PHupPUdrK/d+6UNUIp9IJRLZWDo2MoZt1jv+PTCVaBp05PyvPykikRgcVU1GskrTchYTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 20:48:19 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 20:48:19 +0000
Message-ID: <b9131e12-e8dc-45ea-80e3-30281fd7222a@amd.com>
Date:   Thu, 9 Nov 2023 14:48:17 -0600
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v7 18/24] x86/resctrl: Make rdt_enable_key the arch's
 decision to switch
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
 <20231025180345.28061-19-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231025180345.28061-19-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: be8dc686-2f46-4db2-d807-08dbe1653497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DEGOcGgjOIA1JWtgZJXDHQoGIxaFmfFJN0yNQMrwOkOqD5398ifBJDhrEi+jH/ygsXIP4ryFa2aRBz8RbD6afSr7Uuh/qGrzM2bUbOzgbK5nYasd3MeSdpNS24NDP6pS+Wn1sgujt8bbENuS8W6usF/hdxUxcoaoKPxcjcjie1DyYhN8nWI8pdTy1ildQStuGCK6VMfb8edXx+4ouyLPqNgoq4YkK6tK+DJVkDh7+jRuWfAwR4vjKznESGMyA46UQQ8CGpXxGjQy2AF4JTl55rIjc3YdlMy/p/bq9wH+phreZwo+1y3zInweiC6md5YrA5SS2FqaidciZnI0fvFHazCiw4RhmgkMOCbX9x8sF+BUYQLKfSRrumTrFerwlu3a/+G0vpm0IJuVNar5dHjCuqoZ1fAsI9ZiPZDjrl+i7Ep9DnhOH1lHV04X0fYwOSUCy9puEtjL5r9QCuEQnCsruEI1T1uh6Kh/MzvA3TibITZie+5VuIWBPc5dr/vSPAhbA7tnUWZeatNnEZOLul7sODvF1ZwTf94Ig/6Q3INMIyJh0MyreYcF7fcHYunr2+Hz2Zhh557AFVzOWiILnRyKKbNA4qWFAb4HTwjUP4YmV1stvqUPhkeIIsGylFpVGQ50WN8O5ZFTyf90aCz8drobjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(86362001)(6506007)(478600001)(6486002)(53546011)(316002)(6512007)(26005)(66476007)(66946007)(2616005)(41300700001)(8676002)(8936002)(3450700001)(66556008)(54906003)(4326008)(7416002)(5660300002)(31696002)(36756003)(83380400001)(38100700002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVFqKzZTMVhNL1Q2dDREM292T1M4T0drdTdMVFMxRmQySUVXdWN6bVhuUHov?=
 =?utf-8?B?SFBOM0ViU3dXR2t3Wkl2b25NZEhBSU1qdzBramtNckpwZTg2VWRERnN4ci9V?=
 =?utf-8?B?ZTZzVGxINTROUGRNQy9WV1F4LzdyUTIxZVhJcEtPdVliYndvOTAyZHlPWTlu?=
 =?utf-8?B?SkhUSWVPaTdVQkhqL2FraXdXN2ViMmdETFlsWmRETjF4TGFtVFVJVDZoZXZW?=
 =?utf-8?B?dDMxQ21EV216SXVDSjhmcHFxL0IrNEdNRXhpNVhieElySGFINVdZK3REdGpD?=
 =?utf-8?B?L1NTRVk0SXVtVzNOTmk0anY0cUVZanNkWkdXeTgwT0lqZnFpS0VybHFkQ1Bz?=
 =?utf-8?B?NldteDNST1dIUVBkZU8zdWE3NHpuanI4SDFjRmFRNlc2VXFCZG5tS0hCT2Nx?=
 =?utf-8?B?Q04ybXhUOU1nK2N4RGl4N1BSSzdVWUpTQVpPdjlNQ2I4b3hJdjJncGxqbUdo?=
 =?utf-8?B?SkQ5bUZybEdZZTBYeU1OcmhBVXdmQmpZeUpvWW1WUVIrelJLRUFkZHdUU29S?=
 =?utf-8?B?Nll0bTJPaXJPTTJSMHBqWG5RdGZZUUF3SHF5d3lyQzJXNFYvMitOMGtCbith?=
 =?utf-8?B?VEFGdlp6RW1BdjVocGl0RU1OOVFFVXpCSlNjaHRuQmhuYVNOOERzQi9sZy92?=
 =?utf-8?B?c3phajhhMGhqcmZMUUc1Q1N3RDBISkVUUnlYVFc2dUhsamV1T1M5bVFvMUs3?=
 =?utf-8?B?R2JVVDVKZDFKQTN3c0V0cHdya2tWbkVGVkJ1TTFWSXY0dHdaT2ExRkRKQStC?=
 =?utf-8?B?bThxQkFvTlM5YlBOMTcyYkFPdEV4a05nK29IYnp5Qjhrd2hWektvNEZuLzli?=
 =?utf-8?B?dlJoWDVuVEloSHVnUU5wSU5hVlhqQWxXUUVVVCtud2tTTE02MHFtU0F6WnJN?=
 =?utf-8?B?UjgvUTZhMGdScHpYbDZNeGRPWHpBK0pSbFQvTDYweG1BYnZNK29MNXlHZ3Iy?=
 =?utf-8?B?UTNlbVBiNGQ2cmpMU2xjeDd1SUpXdnJuSkFOeWx3bjJ3d3dMSTF0RFZxM3pJ?=
 =?utf-8?B?QWxtU3VqK25Bb1UwNGVIVmp3aXJvYW5TSDBYU0pjYVRaVEQzYUc4WHJSbU5z?=
 =?utf-8?B?cENvZHlTSjF4NkZjZ0hiVTVOSlY0bU56cXUyaVNFOEErWnE4WUtXOGpiRTJz?=
 =?utf-8?B?VjRhaUxidFhiSkR1ZkswRUxkZ0VwejBVd3JFNklvdXZXZ2YzcFdXY08rdTZ0?=
 =?utf-8?B?cDVYNGw1UGhadFVPb080aHpGb24yenp1VjNhRitrdGk5MlBTWDM4UnIxU3ph?=
 =?utf-8?B?T3BvTUViUlR5T1B3ZnV6VUJ5YTBxTWJyWnR4Um5zNFpGdEpNdEJHMmcvN2RW?=
 =?utf-8?B?ZlJqdTdkbWpDYmNQTmYvVzNDVlJBbTF1U20vQ2orc2s4VHBrN0ptZllHZ1Fj?=
 =?utf-8?B?R0lGandKck9RbE9vYmwrRElSMW53cHhtamVORWE0d2xFNDBpTUlXYlljNnhF?=
 =?utf-8?B?T1RIYjluLzFQcCsxZk94M083SktxaWx2c2Y2cUFIT2E3dnQ5T2M2QzFnSEdK?=
 =?utf-8?B?Lzhjb3lYL3FpQUdEVGlDb1pkUjJFZzY0U3FNL2RqOGIxUk1UdmY5QmZGNCtZ?=
 =?utf-8?B?clU0N1IyYXNzbFYrc0xtRFlPZ3B4cTloQ2cwUnVkQjdSMndlUVhLSVZHK09V?=
 =?utf-8?B?TFZ2WThkNHFyVnQzSkU0UTRqNkJGckxEMi9pblVRMFEwZy90aU1qaHdxKytO?=
 =?utf-8?B?dGFONU9JMEE1M3ljeHRmc3NDM0tuQjQ0QnlZVUVpbFhPaVVEZ0lXb1dMb2Vu?=
 =?utf-8?B?TVZ3UXR1R2RsMWhWN0Y0MGYyR2pLdzhBMFplNVFnNU5Ibkl2bDNXenAzM2lC?=
 =?utf-8?B?eWZsaENYUktSNXN2RXdPbGtSa0xlVzh4SVJhNkVEOXpncVlEK0c4U3BJbW1B?=
 =?utf-8?B?Tmx3QUU1eG1zOFp2TndVSDlZUFJVM2VMVk93OXdha2VQTitDTHZkUnhtTTU4?=
 =?utf-8?B?YTYzM21SeHZUc0tJQ29SbTNGdVh5bFJRenp3UEtKcnhYNVB3LzZhdmZBK2lE?=
 =?utf-8?B?QmhBT1cwdjFvOHB3SytsTEErVFRFbCtITzlSVnp0b0JyVEZxaHpDOUhHK0Ix?=
 =?utf-8?B?VWZNb3ZIeE5aOUJSOWMxZGhPWERnbkwwR0dCQWZpaExFVnB5b3BtUFZvQ0F0?=
 =?utf-8?Q?U9Co=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8dc686-2f46-4db2-d807-08dbe1653497
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:48:19.4563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7+HkqTtUGSDnxBgzLha/FVU6xfvmJeAj6rOJ2ADe+2ECUuPm504dgUkKgBzLE2j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/23 13:03, James Morse wrote:
> rdt_enable_key is switched when resctrl is mounted. It was also previously
> used to prevent a second mount of the filesystem.
> 
> Any other architecture that wants to support resctrl has to provide
> identical static keys.
> 
> Now that there are helpers for enabling and disabling the alloc/mon keys,
> resctrl doesn't need to switch this extra key, it can be done by the arch
> code. Use the static-key increment and decrement helpers, and change
> resctrl to ensure the calls are balanced.
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
>  arch/x86/include/asm/resctrl.h         |  4 ++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 11 +++++------
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index 3c9137b6ad4f..b74aa34dc9e8 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -45,21 +45,25 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>  static inline void resctrl_arch_enable_alloc(void)
>  {
>  	static_branch_enable_cpuslocked(&rdt_alloc_enable_key);
> +	static_branch_inc_cpuslocked(&rdt_enable_key);
>  }
>  
>  static inline void resctrl_arch_disable_alloc(void)
>  {
>  	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
> +	static_branch_dec_cpuslocked(&rdt_enable_key);
>  }
>  
>  static inline void resctrl_arch_enable_mon(void)
>  {
>  	static_branch_enable_cpuslocked(&rdt_mon_enable_key);
> +	static_branch_inc_cpuslocked(&rdt_enable_key);
>  }
>  
>  static inline void resctrl_arch_disable_mon(void)
>  {
>  	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
> +	static_branch_dec_cpuslocked(&rdt_enable_key);
>  }
>  
>  /*
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 48418857b685..edfb37680046 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2677,10 +2677,8 @@ static int rdt_get_tree(struct fs_context *fc)
>  	if (rdt_mon_capable)
>  		resctrl_arch_enable_mon();
>  
> -	if (rdt_alloc_capable || rdt_mon_capable) {
> -		static_branch_enable_cpuslocked(&rdt_enable_key);
> +	if (rdt_alloc_capable || rdt_mon_capable)
>  		resctrl_mounted = true;
> -	}
>  
>  	if (is_mbm_enabled()) {
>  		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> @@ -2951,9 +2949,10 @@ static void rdt_kill_sb(struct super_block *sb)
>  	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
>  	schemata_list_destroy();
>  	rdtgroup_destroy_root();
> -	resctrl_arch_disable_alloc();
> -	resctrl_arch_disable_mon();
> -	static_branch_disable_cpuslocked(&rdt_enable_key);
> +	if (rdt_alloc_capable)
> +		resctrl_arch_disable_alloc();
> +	if (rdt_mon_capable)
> +		resctrl_arch_disable_mon();
>  	resctrl_mounted = false;
>  	kernfs_kill_sb(sb);
>  	mutex_unlock(&rdtgroup_mutex);

-- 
Thanks
Babu Moger
