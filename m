Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6567E72C6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345161AbjKIU2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjKIU2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:28:34 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B9744B6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:28:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lP7aILYWvHHp/z3Yc/WK+64tfvOSmKWtmTtd6EEc7RRnmyLTCWjBmKKHlUBbhmrluG3kA8Xo3YHucueuoUUJZVrcUs45/DuQZ06d+0Naz6xvUn5v6h9Mz9qNzlGbDYwyGc/32IlF3/cxIisir4excZOVJw/39dBXjedxJz0Z87W0a05AAzxskm90LGUrpddpNcpvOtwkDRF7smozC1Y0BZWJjhZ/ln8A5VodxipSu5dmJ4V+36RYJp2V0SdUYHSgp2hPY5tn96wYBtGn5R9qoqNNiQLVlFtHoGSIzAKgMOXskx1gU4zCLCLHTx6F7ztp/Q5VHP8U7FQT0D9Q1JOkBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=As8o5m4X1ji30ARXAZyvGO9J41/KkhMs3mHZ+rRYBKI=;
 b=XoGCxqQky+/zcF1Kl3F/jdev35PgOuYu9grPNDgnfcj7COHCI3r8RR2Ay424sZtg+V8k0MC8aEucYhfsQVnxJ8sHx450v8ZME9MpJh+Fcxk9oyfqSY4nb22n0Lf39BgIG4R+exbY5IMDIEM5Q7rZ6iw+QMI1aM4JRQK21biQC0NQYpPGUUc482nB0qqz7EEk4rlTzKQTxIWac0Ze8UlCkH4OfgS+RmweMhM9BdVigYo8Uaw/RjmTrgmFOeeeRCYsWQFpai+AjPAt1rodNQvMHei4RYwSiODSk1rpzqyNEX5QMBXTg4dZhyHJWAAR2GEQs5nJpO5NvGz3KcbNlTNdGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=As8o5m4X1ji30ARXAZyvGO9J41/KkhMs3mHZ+rRYBKI=;
 b=KuKu6qSHNOulAvBQ/vI/lb42Lxb/wJx42442OddPDG3Udq9VBWUD4SIyQ8fV0RbFZ/u/NB9HUgjpQ4aiQuLiCHJ4IDAL9ZPLo4zoKiHbBwotZfiChbkQ/IzxTWNA4as2MFY8R4g2bJkaKp68UdLY+BvfhK5GVRjm0L1vZ9j/MvU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 20:28:27 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 20:28:26 +0000
Message-ID: <5fe8fc52-c1fd-4977-be92-901752ce8ec2@amd.com>
Date:   Thu, 9 Nov 2023 14:28:23 -0600
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v7 02/24] x86/resctrl: kfree() rmid_ptrs from
 rdtgroup_exit()
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
 <20231025180345.28061-3-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231025180345.28061-3-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0166.namprd04.prod.outlook.com
 (2603:10b6:806:125::21) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cfbe43b-d6bc-4063-5ad1-08dbe1626da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pKjEfz3X/f0fV88B6ZhxDolt41JDdXj4+EqZ0FwUSTqjG8+fKDwIf1RXXFVoaAn26iAHb6leTtgEmKSKt+hWE8+YtjbPLhPk1ZNJmooh9NJIXXPgHkJOMaokbi88p50Es2XMSI6vLGhKAPK/cBiz/e18caywNApEYB5aaWHaYkZz+nPR6tthDhF4ohN0s3xpv7P57OojDqVZeGxHn+ir9vWgctbsgjKpi05lBAp5wYvDQ5Mw6zUDSSFFAK1OlXabLTMhGHKlWZ3tRRPQu1G8Zsy7EANDe10vsM24ZnPYPN1FHNPz3EfZGS+CSo7NLoUeqXPNUmNpdVrLTQJB2F5mw8mD67+1kE08YmcyQfCXhcyQMAHGM7/+HWGnduqq7D46jVWRoWZCNVMh4UImwCdSkCFZagLUySziH+jkXgYoDGxUnya1FORwbxMDJcM/C7CUIUk8mEm5mpsSw+kGiCNBQlKIScHO0XQef1faOcNH/cU/SkMJ9hswg/u9TceRr6i9NzQGQDMaA5W3BOs6IXinK1Rj1wlceyiBP/LlxLv2ZA2mlnafAYAfm6NviaF62i1j1g1CfNKKbG957W6NlmQoO/AIZwqWkY0h99c9fqAKb1hxL917a6RBzlx4MDRZQ2NqcF4GOT7QWhUSs1Jhd5y4qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(53546011)(26005)(6486002)(478600001)(7416002)(66556008)(66946007)(2906002)(66476007)(316002)(2616005)(6512007)(6506007)(8936002)(6666004)(8676002)(4326008)(5660300002)(3450700001)(54906003)(41300700001)(36756003)(31696002)(86362001)(38100700002)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3pkZWFGdVNrRDZIVnhncHFQYkpyeE1PV29DUXRKU1oyR0ZoZjdXa2EzYzhM?=
 =?utf-8?B?U1k2cXNrcVJFdjNRTGFKSGpGR0JOTVBoaWU2Umt6aVhlM2xwY1RINk8vRDFD?=
 =?utf-8?B?WDBxeUtvQUdUUDl0Y3pIRnlaL21QVGZMWlV1cW5TM0JlMS9zVTIvY1JteUdq?=
 =?utf-8?B?NXRGeWtQOUdIV29MaXRDK3NoNWxuYkhocU5CU0pXeHRCOEIyVG9LM0l3MUVD?=
 =?utf-8?B?Y1Y2STM2M3Z5WHdXNDlwemJrenFrSHlPWTlpK3VvTEh2UGQvZkRadjlkeFFN?=
 =?utf-8?B?RjVzS2JsSnliT0hLblhxaDdrY0cyeHp6UlJ3TEJ0bWo1dmRydUYwQVBhSzFK?=
 =?utf-8?B?ekFtS013RlFmb0ZQeXRzQnYvSENEUTVCaEVKbFVKT25jNVFnamxyUUdBNFY2?=
 =?utf-8?B?aVdIaEJmaFBoM2lhVWwzTG9ZTUZzTnppMldWVlJMb3ZWL0NySFhOTHRNdDVQ?=
 =?utf-8?B?dDRGVUEyckJuMW5ZdndTc0tZMkpSZjZkd3Q1ZUdqVFVGTGJvalk1U0Vqc0Fk?=
 =?utf-8?B?bWE4Uno4MXowQXlEQ0pCY2ZuNVJHakRaSnZpeUI2WW9wTUtxcXk3REg3WXN4?=
 =?utf-8?B?dnpYeEdXa3p6bUhpUkJZLzA1aUdUQnU5VStYRmVVTklJVERJeHdFL2doMFgy?=
 =?utf-8?B?Z1JCUkdKeDl2cHZXTEk2Y2oxdTFBUVhQYmtSWW5Ubi9oZXZWNzlZdzlSTDN3?=
 =?utf-8?B?TXpwSUJXTmlqTWIxcnRmaWhLNHVBOWdwRXRJam1mYXZKRlpPMTBVYTExOWFT?=
 =?utf-8?B?U08yS25IVTRDang1YnUrUjc1KzNtMDRHV0JYZUNwU1hGTngxbStZWUNPbkdE?=
 =?utf-8?B?ZkNCL3cyZ1ozTG5UZ1R4ZHk3QU9xTkkyQ09jT2RPbE1TekVRdjJsbnVndWxF?=
 =?utf-8?B?U1ZHODVnMDBrUytqcGtIUHE0YzZNaGZWVTcvT3lKV2gycG1UcjZDM3pwTHls?=
 =?utf-8?B?OWNLcmJpTmh2UUxjK21FcjdMS2JzMzQ3TlBoR2hUUnd0L2wzVVU0bjMvNm8r?=
 =?utf-8?B?cGZBYkErNFcyRUhZOStPdVlxOHBYZGNhZENkNnU2TTlFODlLYkVjMUZRdXZu?=
 =?utf-8?B?L2NvSi8zTDdJcUlEaiszelcycHkwQXd5cjRJbG13ZHVQUUJNZ1h0dGJDMlAw?=
 =?utf-8?B?cnpzTm9DZlNVajFnT3UrZ3kxMnR2RCt4TGQrenJ6YzdITmlxZjVmVkE5SFVW?=
 =?utf-8?B?K09yS1JwRmZLOTA0MnFyVnR6M2xjenZxcWU4TFRDZFp5VkRDUEtkdlZJaHNS?=
 =?utf-8?B?SGVqVVFVNVFoVnlVaUZzTGdWTHI2NVFLVW16V1RWd1JSZ1kxekZqMEViY0dU?=
 =?utf-8?B?UU5ZcTZucnkrYzVmVUJMQmU5Z25hRFc1MjM4SWRsTGd2R00zWEJZYy9BVmUr?=
 =?utf-8?B?eUgzM1V2Zkt5MVRvVEVqbmhWNVQzZGZ6a3h4cEUvU21nUEpUMFlEcnM5NWJw?=
 =?utf-8?B?dm9YKzRCQ1B5blkzMXZ4QmVka1IyTEMyK01iVEhySVE4R2VkcnRrU3VGVUEz?=
 =?utf-8?B?ek9meTNXblBvM0drR2UvNHdqam5VcjgvazdJOWQveGJlbkpnQnFYell1dENP?=
 =?utf-8?B?MDVTSFJla2laeHVLUk1mUDFQV0NLMnNtQlZRald6U1FMSmk0UWFvM0d2MTEx?=
 =?utf-8?B?a3pocVU2TEExSWxHMjhVL2c0QlRKaWcrUlB4SWlIcWFYM2xwZzQxVElDaGdm?=
 =?utf-8?B?WTAvNUIwRUZvMDZjT0MxT3FERCt4bUtzZksxWnRRTyt5RFJGQmtTSzdtcDdz?=
 =?utf-8?B?bzkzWnZBekFidzZ4VG1mMEp3UU5tdm1sZWFMT1BRWnNQZ0dZeDNkcVVHVVlP?=
 =?utf-8?B?cDJ1Sm05MjNDZytMeWtySWIvOHJvWTZVcTRBaExURUFTSVFvd2lONDVyWjBr?=
 =?utf-8?B?OEdZU3luR3BaWGV6MmcvUEVxTzVQZWZRbVJBbkswYU1vaWQ3ajUxM2o4Yjh1?=
 =?utf-8?B?WDJObUd2NnVTaVBNNGVSQVAxOGY5VVVqUU9iRmFyQnFWYWZRMTQ2ZGJkTVQ1?=
 =?utf-8?B?SlRjNUhGdE5hTjI4bVp6RDA5clExRHBvV0NFNXBIUldvNEdaTkxPbm9mdWdJ?=
 =?utf-8?B?cDBuSmFvcVR0Zm1NUE9pVXZPckVxRG94cjZEeUxqT2o1bGk5alM4ek4zNDRw?=
 =?utf-8?Q?g9sw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfbe43b-d6bc-4063-5ad1-08dbe1626da6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:28:26.7743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tJIq6wtbDFZ3P8q1JHSrsgGV8jc4dMN/t+6yqoimuTfOIBWGrc0waD3p0G8UWae
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/25/23 13:03, James Morse wrote:
> rmid_ptrs[] is allocated from dom_data_init() but never free()d.
> 
> While the exit text ends up in the linker script's DISCARD section,
> the direction of travel is for resctrl to be/have loadable modules.
> 
> Add resctrl_exit_mon_l3_config() to cleanup any memory allocated
> by rdt_get_mon_l3_config().
> 
> There is no reason to backport this to a stable kernel.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>


> ---
> Changes since v5:
>  * This patch is new
> 
> Changes since v6:
>  * Removed struct rdt_resource argument, added __exit markers to match the
>    only caller.
>  * Adedd a whole stack of functions to maintain symmetry.
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     |  6 ++++++
>  arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 15 +++++++++++++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 19e0681f0435..0056c9962a44 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -992,7 +992,13 @@ late_initcall(resctrl_late_init);
>  
>  static void __exit resctrl_exit(void)
>  {
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +
>  	cpuhp_remove_state(rdt_online);
> +
> +	if (r->mon_capable)
> +		rdt_put_mon_l3_config(r);
> +
>  	rdtgroup_exit();
>  }
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index a4f1aa15f0a2..f68c6aecfa66 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -546,6 +546,7 @@ void closid_free(int closid);
>  int alloc_rmid(void);
>  void free_rmid(u32 rmid);
>  int rdt_get_mon_l3_config(struct rdt_resource *r);
> +void __exit rdt_put_mon_l3_config(struct rdt_resource *r);
>  bool __init rdt_cpu_has(int flag);
>  void mon_event_count(void *info);
>  int rdtgroup_mondata_show(struct seq_file *m, void *arg);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index f136ac046851..5d9864919f1c 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -741,6 +741,16 @@ static int dom_data_init(struct rdt_resource *r)
>  	return 0;
>  }
>  
> +static void __exit dom_data_exit(struct rdt_resource *r)
> +{
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	kfree(rmid_ptrs);
> +	rmid_ptrs = NULL;
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +}
> +
>  static struct mon_evt llc_occupancy_event = {
>  	.name		= "llc_occupancy",
>  	.evtid		= QOS_L3_OCCUP_EVENT_ID,
> @@ -830,6 +840,11 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  	return 0;
>  }
>  
> +void __exit rdt_put_mon_l3_config(struct rdt_resource *r)
> +{
> +	dom_data_exit(r);
> +}
> +
>  void __init intel_rdt_mbm_apply_quirk(void)
>  {
>  	int cf_index;

-- 
Thanks
Babu Moger
