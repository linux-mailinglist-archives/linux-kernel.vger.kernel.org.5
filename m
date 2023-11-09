Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F407E7306
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345203AbjKIUmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345186AbjKIUmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:42:18 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83E04239
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:42:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxmCU7jFY3nyFAs27NRQQIfaBkpWAHmkzQVLtaiE6NY9lRg3k/iX3RY3WXja/MToxF+9Z2hedszYHdpMeIzaTOFUE+1RgfPrTFKv4928MfdL+Zj+VWk0x0xXt+m9FcDb+Dgcesph+TtbBjEfQYqwKInXy+9zS0FPE+7MQJsdtt7ph2tfpV4qdUXtjFbxr8na46PAk49hPb3TfvmWAcLhOp/tAK2m6K7ANfO/MeHP6dbVMblmZkZWiL8OYmLwwDJ/y00k433H8aslob7Jk3rZ4LKPxIikGpP7zzliDGTQdeSZZ98FJm9nabg+Pxv4H7WeYb3i1OQ11iVT7io3YFAamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+XZfkevk1ZNMc+UcKAPyHwm0Shr/Sfcx14mC7dMA+o=;
 b=VYrl+CYHeC3x1MhP9RizwMy9OdkFJSpFtTr6hTpWz61u32t4Wz1K/3SGADQy8/lc1e34IO6RH99E0clk8o5HBy1K6PtnoK9butF5fEH50PG10Wx10Iy8rXhQ3AzZ3ROmUvri6x28bl6RaGFdjU6J6Au2OBTBYcaJIBl4ZGh1Kci4e1keH2eStporZyA3M1MA1dIu1XvpkKjxa0yOnetxPt/lb0F8ZAT8hE1nhfBiSUJiDPrBHolw4ZusKg6701CHjSr/EXVu7vY+R8fNkGqRDg4+q05w06pIy8bW7n5LM6NIMX4mlYIrabRhE2ZKBt4iKFYi+gwEi35ulHordTru2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+XZfkevk1ZNMc+UcKAPyHwm0Shr/Sfcx14mC7dMA+o=;
 b=QG1rgAV+ue09Gdp622l5SrcsB7hzppK9vUxJaSl+2QkeFDGPqG4Uj0yHLdChzUTjzLan62cQ1pQenN3uAPADW5LR25MxK8ZeiExdlLrv+YEPgtuqIQ9zU4ni16cZirS/Xw/MfwnMqRgbAd9NcteLsawOgh7ePp2XdntzWUeY658=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 20:42:13 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 20:42:13 +0000
Message-ID: <1d28db1a-196d-4aaf-922a-12ce31d71aa2@amd.com>
Date:   Thu, 9 Nov 2023 14:42:11 -0600
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v7 14/24] x86/resctrl: Allow resctrl_arch_rmid_read() to
 sleep
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
 <20231025180345.28061-15-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231025180345.28061-15-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0029.prod.exchangelabs.com (2603:10b6:805:b6::42)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e51f77-8f7d-479d-8746-08dbe1645a36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nt2M9wR2r8dfQ7I47SFi1tvQaS1z7YQJ+JlkEdksvYHj3+EGXfXLqXPT6cq9ObRejPLqxm4GLXNn2UktOVv6B/w8OaXAkPqLW9nz5Z77gEP8D4j64HFLwMY8WuBtRUhCr6caQTe42Q2qXG2+zRcDxRqRxdARfMh56VxpSG/5wkZ+a0uOgNgDJeCNV6xNH1CAxM4GcFPLwoAQuwToXpZrOOO7ztCKZJsGI/U6LM9mzIypt0KT3Pfybcht3hqnuyrSCGxpnduyCpza3N4+krUlddiLLScEIDm/ko7PbKkys39Cu0HQHZcPkmGxUxSN+ceE21Zg7sS1XZPQxQX7VFsj1cXrw5LYV/4+unpHQJzaFnYFs/jFyJHXFCjmYPkR7xU/GNupxst6cxRXVkHpUhOi9hms0MzS1/tLPfHV8Dx3DFtwRCOomuCoUmYi2Dc/lkY+f0t2sqAxkOw3Dcfa/NuMPb0YbyYBNzNDVtZ+3SHDwxl966qLGoJetHp9obY+NABEr07f0Z7UwyEgsO1lmiw8P/2/CrB67snN0aogIbkXK0SX8nkLIyqh82N4FA8xUzfbTR/kYqhldK46gRP7xiUKd33srHYOx8hCKNHsPkMENpcptis0ObYzs0PvCF9Z0P4fHCSoog5GvOME3SO13XqOFodc6t7TpGi+bCZY0NG2LCXkS8TwnfWdSio39BPQ/BhG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(230173577357003)(230273577357003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(31686004)(2616005)(53546011)(6512007)(66556008)(478600001)(6486002)(6506007)(2906002)(54906003)(38100700002)(316002)(36756003)(5660300002)(31696002)(86362001)(41300700001)(3450700001)(66946007)(26005)(8676002)(7416002)(83380400001)(66476007)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEZHZTVDa2tYVHJQN1MrVUZ3c0NGdlllRC9GbFltRHJqVkV3QXIrNjI1YTBa?=
 =?utf-8?B?OG96MGxCYmt1R3loN291a2Jtd1FJYi9sbzdnaVp0bDlpZmxZbTBtcEJBc3RZ?=
 =?utf-8?B?QktjUVdJRGdtNGtMWldEUmVCc244YXU5ZGZxKzBDWjFNMDYzZmZpam1IY083?=
 =?utf-8?B?VUprcldqRk5UaSsrRHpEcjZGUEVtUitUWjZXeTh3MVh5N01JNC9hbml5RHl5?=
 =?utf-8?B?aE9icFNCNGZwd2wvcE9UL1haT01vOTdkQUxFVUhEVFRoNEhjNHV1YWlPYnd6?=
 =?utf-8?B?NUtmVXZEd0lQNURjUFBXaFV0d2QrMDdUNitxUjJHNlR2VU5iR1h4d3Noblk3?=
 =?utf-8?B?cVg2RWc1NytCTnE1c3MwY1JYeGgxbHJOYjZEMVdYK0dhTCtoUTNuV1N0TnNr?=
 =?utf-8?B?K21DR2libmJUdmlabWN6S2hYZ29ZMkdpQkd5aHZUTXZBakdIdy9mS1RBMm5j?=
 =?utf-8?B?U3lUQXlCdFZHenBBUWdXZDV5MjNORWd4VUhQNTlNVDZ6U0NwUGlWTEc4RHN1?=
 =?utf-8?B?QlBUQWRJcjRNSDhZRys1eTNWMlR0TEtZQnNudXA3N0dzS2xHZTF3aXVabUJE?=
 =?utf-8?B?azJabGlaemFlNDc2ejZMT3lic2doaWg1YkRFTWxUMmJyR3RmWU5TOTl5U1dB?=
 =?utf-8?B?Y1JoTnlhWmc2WW1QODB0dzlieUNrU3BESUM5MG9RVFNHZzNvTzlRS1d3a3pJ?=
 =?utf-8?B?VnZaR3VpNHJyUWNRVHBuVXBFa1Ftbm00R21wYzlSWU5LUzV6THNoK2hxWUtP?=
 =?utf-8?B?Tit5MTNZNWdUbWpXU3EwRk9NL2JCLzVoUVpPK0U0cUtBMG5FMENGYjA4N3Vn?=
 =?utf-8?B?Z1lCeFFYQmhHNCtscjBpeERuSHlLYzRLeGJEWHYyck9VRmpCOSt1cDlXTGZh?=
 =?utf-8?B?alhCNkozZGF4OUZLbHFHZlozdnhwc2dqVTdqR0JJbmpSWllmdDN1ZTdONlZN?=
 =?utf-8?B?MndmQXRLY1NTTjBlZVl0cll1d0RWaFNJUDExdW5sbndJYnlaRjV2SUhIVnRi?=
 =?utf-8?B?bVp3TmVsVFVJMkxja1lNSThldWNsRlVVdm14R05zSXg0SUxzWFg3VmlXZlJz?=
 =?utf-8?B?bFl1bnF0aFl2Wi9ZU0NEYjhKQUpWMDQxYVB5R2VzTXZvV29vYWxScnZOQ3Bp?=
 =?utf-8?B?aFVmVmM5dmFiSFk5LzdieEhrQ3pXTERETU1Vc0t5eEZBVEl6SzJuaHFlUThZ?=
 =?utf-8?B?SDBpQXNlUGYwMEJkMUZUTFNkaXdNWlVRcTgvczk2NGZwMGEvUFdQODhIT0RW?=
 =?utf-8?B?dlloc0R1R3dUcWsxUU9XSkdpajhhTDcxbm5zYTZ6Vk1XKzFmNlo2ZVNDQmVL?=
 =?utf-8?B?Mi9DMC91SDl1b3JOMU0xMW9iMVd1c0ltN2NoRlc1RWdhR0pQWS9SNFRxMUt4?=
 =?utf-8?B?dW96NTI5ejlxVElzNkJFZUN6SndxM3oyZUdJYkgralRya3lVWGs1VzZTRFNB?=
 =?utf-8?B?RHhoaXRYVGJlS0UvRUdBY05Wc3FnMTkxL1RYVmRDNDNpTkY0cU9peDd3eUZC?=
 =?utf-8?B?T05uZEZJajBML1E1bzB5WGg2QzZtZmNwK2VkUFQyMEpMMTE5cGM2M21lVzhQ?=
 =?utf-8?B?T3M0eEFITHkvVGlJMUl2Wld3S2tiVkJzSFdldTlnSTZvMUxUcHppcGhTQVV5?=
 =?utf-8?B?Y0dKYVNnaTNKaDFacUdsa0NaQlVKREgxNjk2R1VHVDkxOWVaemVwRUJTNmVF?=
 =?utf-8?B?d0pMTi9nVEZUNml6bXlvTG9ISkVyalJBT2I3QnRKKzArL2dpR3dLQ2tHcmV6?=
 =?utf-8?B?SmFuNVJwdDJCOEpHckU4VFYyQ0x3RnFMMklQOWVEZ2FKaVh5MGg5Q096RHcr?=
 =?utf-8?B?bFZBWTFlMCttVjg2WDcxTk5lajB0K3c5OUhucW85aExlMTFOak5GVWJ4RndU?=
 =?utf-8?B?aDZBSFRtMHAyYnZwQ1JzRXpQMitmNXczWFE4b2RWOWxORzVRRUQybzYwbThS?=
 =?utf-8?B?K0hZbVBHeThJdFl5d2p4NVNjdmEzcFVCT2dVWG1KeVl4c2ZsaUdTamUvQWMv?=
 =?utf-8?B?NHpidnRFeDgveHA1UHp5ZS8xT1FZc1M1aTJ5L2ZveTZkUGFkQ1pSSzZpOHZ4?=
 =?utf-8?B?RDhLTFdFSHhPRFB5QVpaRElVSElaSDdOM1IvWjQyWW9oYVRmUU50UjhUTHFZ?=
 =?utf-8?Q?JCPU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e51f77-8f7d-479d-8746-08dbe1645a36
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:42:13.0851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOgcwB36oDzKUumhumcDDEDiVOQnOMa9yi0BYoqRO5hy5LMxFTy4/ehgPf5lUCiW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/25/23 13:03, James Morse wrote:
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

I dont know what did you mean by "This has to disable preemption to
avoid reading the wrong domain's value."

Who is disabling the preemption here? Is that specific to ARM?
Can you please make that clear? Or Am i missing something?

Thanks
Babu

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
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
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
> 
> No changes since v6
> ---
>  arch/x86/kernel/cpu/resctrl/monitor.c | 25 +++++--------------------
>  include/linux/resctrl.h               | 23 ++++++++++++++++++++++-
>  2 files changed, 27 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index fa3319021881..409817b0ae2c 100644
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
