Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471107E7321
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbjKIUwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345256AbjKIUwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:52:34 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520324692
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:52:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cH53fAA6RdemKE/aFAiN1vY0IPxKeJkQgJAINMEbECg6osXkQ0uCRqFH6ivdiLD2ohf8Eka0s2se4WrELr42npoL/oEOaLV8lQar9n+RMq3iMRZxNZFJeSqqbO7NcQp8QXRKMRTsCLXncMROEH70zKS58wSAeeq5Cpbf7Kmo/K8zTaIbbXr4UX4soe9TxUmDVNoct7OgBsPMWMGK/t57juLpNPDlKzjHsQazVX9w8kqIG4h1Xa6f4SFt0cvsVkD9UsnX0a1ZNaoNc6tb/VFcjjD+HFuwYky2/a99px4JlawQsLOFz529XdqjOUZioFxuhiIm4F3qOft5VsXMzJl9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrOLDX3fGXjoMeT+Oos6oPIHP/q92y1fyrm62ZsXo4A=;
 b=fO1ys5Up0Pyt+uMIqSGDkOXvuusHQRryb3t/Q/UuC1zd5flzf8hesrLSXPAO9UVL/2TfL9SGlfk/3h1wLoeVqJwt/wkt3OT+mO0858zzxKm+slMD3fZvjPYNxSbwE5J5J1LibqAG2ip6zVxSzVmZR8ABGCO4MXPQnyBsapI85GdUU5WnQ5B68cqgyL+6naGtA/yZEpB3rMtZzOwPlnuJ1EqCAemvv479yEElKaRZBfKXFQvaaTUL1CNVYCk6jbdizI0GT1/Vbp+WU7SCsDxP7rOugMbJryRcwtoumyLUaYJiniXvVOK0bKdWeiFtPn0/iHnB7DXcA9JlJuA0avf6wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrOLDX3fGXjoMeT+Oos6oPIHP/q92y1fyrm62ZsXo4A=;
 b=E9w/7WKVcg2x+HqdT1vhF4mezFDsQyZJ27Z4iNyQek7I5b3h8lTnQboOjNnaPXtXINtmX+a0BaJytk6YhXcUtoUCvYz0CtBid7CTyLTasigQbONTJ586L4T4aPy16UmqiW9lnoJXvo6HmX29+1tj3tvrFbBKXUTgG0X+7xMqlZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 20:52:28 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 20:52:28 +0000
Message-ID: <9fae4348-7a1e-48ba-a5f4-c1b2ad3f0644@amd.com>
Date:   Thu, 9 Nov 2023 14:52:26 -0600
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v7 24/24] x86/resctrl: Separate arch and fs resctrl locks
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
 <20231025180345.28061-25-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231025180345.28061-25-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0090.namprd12.prod.outlook.com
 (2603:10b6:802:21::25) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f98875e-525c-402e-0e52-08dbe165c937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CsoLsBbpujfnq2OHK+TsxrY8mkJza9PsaEKgi0+imTEpFTu2yc00KshC6VidB40+v5OxJOzbZQVT2uL8Cl7MOL+rGSrYn/aiFO2/sNUqO8P9iTtomT8329i2aHJ4EkFkWb0jApck0MPFwDz4DMfYP3dOu5aw1XVIcsSwfuIiBzZgvU3f4hCdkkwTGByZIKxdl9PjyqFEoPk40cx+oYt9v/Iwzj5CIcJEGMhtsDqpdLLZn5/++/rrdEQaIBhTMHkNXGaixcKT5PtvxMswXbjkEB3v4Mb0uCeVQplsARSykMnz9icD47i+baj7oAW9hyBvb1PIZoxfk+WzEpP6t0fJH/LC3PuN4nyndI3m3arXGYiAkb+TBjWoE1YMPLM6XhNQdT8+nFFXizVM+ap/2ta2MryWZRn2dUO/Z3mqFNMJeu1+a33iHEABmWBM/qNUKTHPicC2zg2srSWsvoP7beCAyzQC68sHULeYkV0AnKQ2CEufH+G8SPIG8CdCdTObEToQzUcJYzFU4SMabwulJAt/JqXtqziO1ydik7dlkzpru9aR+vn8iii9u7NN3EGutp5A8h1ZGVk7X89WiERrSKO0hf4EMuCNrTedPHS1UonHPEuxMCvFt2x3JXZH6yhZ2fHPEYqKufsYtzG2aJrcXfq8ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66556008)(66476007)(66899024)(54906003)(66946007)(53546011)(31696002)(26005)(36756003)(2616005)(6512007)(316002)(38100700002)(83380400001)(6506007)(86362001)(6486002)(478600001)(4326008)(2906002)(8676002)(8936002)(30864003)(41300700001)(5660300002)(7416002)(3450700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTRIZ09XOWFOc3FkNmhrOVhQTGlJYjBMMCtoYlJnRlllRXZJRHA0d3o1RnZu?=
 =?utf-8?B?S0l6UjZSeDVRMFFhUldWZVp5UzZ0ZlJWejNveCtqVUxvWEt1eUdVRU9JRFY2?=
 =?utf-8?B?bTFId25FZzVSZ2tKOGF1WDk1aEdocFdxMTg1bGdYOHQzNzdWaGhKVUJFRVho?=
 =?utf-8?B?azZkMEErUzFoaGRadnhHMnlhNXpISHRRak83R0ZyVlhTRFVxalZaL3QvS1ZV?=
 =?utf-8?B?VmpSZ3lHRHpKRUhJVmJxL3Z6V0NSTzd2Tkszb1l6aEtGVE03UTBNM2QvNFhH?=
 =?utf-8?B?MVdmNHR3bk9IVG5IeWo2K0g4bU03a1dVaEFlQ3dOOGNFaVhOaEMwL1g5WU5s?=
 =?utf-8?B?SHRxQmx0RXZXMGZNQmVveVVyWXBCeUgxRjQ4dVhxbmpMZFZ3N0FnNVZ1VmlR?=
 =?utf-8?B?MkYwTHlQc0ZYT1VOYmIrOGVIc0o3TFVaWTZuM2NZSndvU2I1V2NYeGZuNDlO?=
 =?utf-8?B?V3NtYnJWdHgvOE83RXZsVjM3bTNIaXIyR3ZuODlIZXVjSjJMM3YwWDlyME9i?=
 =?utf-8?B?dVRCb1pLK0tQTUI2RWlDL3pSM1h0QnZwUG9Gc3BXamhPc3J2QTVDTG9tNGlX?=
 =?utf-8?B?RnJsbEpjKzVGYURQejBmWVg1UWdJbHJUY1lMcTk1dVVTelhUczIxekZFV0Zu?=
 =?utf-8?B?NkJjOUpoaTd6OXhQY0hEUVlVV002RlBmSHREKzlYejJaenl3cVQyVjkwK3Q2?=
 =?utf-8?B?RzNsd05nUFFURFQ5U0dUY28rVkxNbXJodEJJbzZsRk5mMm92cFh3OXpqODhE?=
 =?utf-8?B?amR2UVM2V1ZNOXhtR3pyNGhUYnhucVh3eko5dlVlRFpweHJBSU82alFlaHIx?=
 =?utf-8?B?eE1hZGtBdjhQTmtqOFQ3TGNBbzNFdStLUlNJLzBOdEIxRC9LR0pUeFZQZ1FF?=
 =?utf-8?B?WmJZY2l2MlpleUlxaVg5ZkxoWmtBTFJEMW12NW91cWZzWU8zY3BZNDZGemMz?=
 =?utf-8?B?YjBiNHZQbDVOUjhhS2R3WGdlam9ocS9TeVJOQTBxelRIclV1WW14VWUwb0Z6?=
 =?utf-8?B?QkVYNFA4Z2J3MTMvODJaTU1KaTNoSm9qeG5WbDY5V241amtNS0tCcFRrS1g0?=
 =?utf-8?B?L3NMeUR6S0tHR3UzN0ZINnNMSkRUMHV6YUhYS2tjSFBYVll3K0xRSDNMS0g5?=
 =?utf-8?B?dnRJczZ2YXB1ZC8wT3lqL2NkeFJUNzJWazN1RW1jQ2lTYVpvYzRFempscjhy?=
 =?utf-8?B?bUs3WThiaytmTWRYQ2k1VVgyTHdFYmx1VjJoSXp2dDl2dzR5YVo5WlBOSnli?=
 =?utf-8?B?T21WaWRHbXdsbVF3Z1I1Q0o3ZWJmOTBYNnJJWjlLb0FoRXhYaTRhaFZXOUMy?=
 =?utf-8?B?NHdYQjZYdytoK1p1K2liN0Z6M0J1aGxvaUFZU0IwUnBEKzVYSzB4dTBTK251?=
 =?utf-8?B?TnBLOFhNVjdEdXByK2oyc2duREJ5REc5RHEzeHZ5SDlzMHpZSFFkbHIvM1ph?=
 =?utf-8?B?dUNmMzhhR0hwUHZkUzg2WlE0Mk1KcE5mMDkySDFIS0tQTnFPbE1kVmVJTHI4?=
 =?utf-8?B?WkM0QkQwR29BbjFrQUE5QWdpdXMwSWFmaFBpVDVWelRySnp2dnU2VXpIUnEr?=
 =?utf-8?B?SzhzbFg5L0pHSWhLQVNrdE10SE5VUTI4czhQSmZISTdzcStTZ3oySVBnU0Nu?=
 =?utf-8?B?a2N1WWpoTW1ETURHM0FXcWpyNGRSajJ6MDJ2VnUxUlFHYnRvU1pPM0ZxMmp0?=
 =?utf-8?B?Q1NFdW1sMnJJajlVNlY1dnBocWlCMW5KeVpTeVFmOGhrcVhQbVBTK0xKMndr?=
 =?utf-8?B?T0pUR0U0a1FEZENFYXN1bzZCWlRyU0NKeGJKOHVTZURXRE1ONjRyUURyQ29t?=
 =?utf-8?B?ejBsYm5ZMU1JUklxT1BHNGpEaHJFT0ZBY3RYT08zeWVRd2lsZ0JVRlpvT3FX?=
 =?utf-8?B?eWNMVmh2aDNQZm94QXBNSEFZSFhucVFua2h1UWlDY3BWemVXaUc5ZkRySmM0?=
 =?utf-8?B?NzBVdkdyK29iZXJENDZGVUxDMnNJWkRlOXpFdFBZbW9XbDZSK3lndWVzS3h0?=
 =?utf-8?B?NGFSZExKQjI4dzdhd2xWSDhIdHhEbERpMlcxQmlTTGpvT1F2UXZlaERkakU2?=
 =?utf-8?B?clc4K1NCREc3R25kdEJOM0ZQZ1pRdFBlZTQ2dXRBdGVxUEszSmFUOTY4V21k?=
 =?utf-8?Q?vhpk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f98875e-525c-402e-0e52-08dbe165c937
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:52:28.7865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3To2h2OYhyvEuCk3Glq+U5THNCO+uQ3Pl7/LXqAYDShF+UWTcg8Wsszho5JXerBY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/23 13:03, James Morse wrote:
> resctrl has one mutex that is taken by the architecture specific code,
> and the filesystem parts. The two interact via cpuhp, where the
> architecture code updates the domain list. Filesystem handlers that
> walk the domains list should not run concurrently with the cpuhp
> callback modifying the list.
> 
> Exposing a lock from the filesystem code means the interface is not
> cleanly defined, and creates the possibility of cross-architecture
> lock ordering headaches. The interaction only exists so that certain
> filesystem paths are serialised against CPU hotplug. The CPU hotplug
> code already has a mechanism to do this using cpus_read_lock().
> 
> MPAM's monitors have an overflow interrupt, so it needs to be possible
> to walk the domains list in irq context. RCU is ideal for this,
> but some paths need to be able to sleep to allocate memory.
> 
> Because resctrl_{on,off}line_cpu() take the rdtgroup_mutex as part
> of a cpuhp callback, cpus_read_lock() must always be taken first.
> rdtgroup_schemata_write() already does this.
> 
> Most of the filesystem code's domain list walkers are currently
> protected by the rdtgroup_mutex taken in rdtgroup_kn_lock_live().
> The exceptions are rdt_bit_usage_show() and the mon_config helpers
> which take the lock directly.
> 
> Make the domain list protected by RCU. An architecture-specific
> lock prevents concurrent writers. rdt_bit_usage_show() could
> walk the domain list using RCU, but to keep all the filesystem
> operations the same, this is changed to call cpus_read_lock().
> The mon_config helpers send multiple IPIs, take the cpus_read_lock()
> in these cases.
> 
> The other filesystem list walkers need to be able to sleep.
> Add cpus_read_lock() to rdtgroup_kn_lock_live() so that the
> cpuhp callbacks can't be invoked when file system operations are
> occurring.
> 
> Add lockdep_assert_cpus_held() in the cases where the
> rdtgroup_kn_lock_live() call isn't obvious.
> 
> Resctrl's domain online/offline calls now need to take the
> rdtgroup_mutex themselves.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>

> ---
> Changes since v2:
>  * Reworded a comment,
>  * Added a lockdep assertion
>  * Moved clear_closid_rmid() outside the locked region of cpu
>    online/offline
> 
> Changes since v3:
>  * Added a header include
> 
> Changes since v5:
>  * Made rdt_bit_usage_show() take the cpus_read_lock() instead of using
>    RCU.
> 
> Changes since v6:
>  * Added lockdep_is_cpus_held() to get_domain_from_cpu().
>  * Added cpus_read_lock() around overflow and limbo handlers.
> ---
>  arch/x86/kernel/cpu/resctrl/core.c        | 44 +++++++++++----
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 15 ++++-
>  arch/x86/kernel/cpu/resctrl/monitor.c     |  8 +++
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  3 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 68 ++++++++++++++++++-----
>  include/linux/resctrl.h                   |  2 +-
>  6 files changed, 112 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index a90a07a5c876..b6c907aa2043 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -16,6 +16,7 @@
>  
>  #define pr_fmt(fmt)	"resctrl: " fmt
>  
> +#include <linux/cpu.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/cacheinfo.h>
> @@ -25,8 +26,15 @@
>  #include <asm/resctrl.h>
>  #include "internal.h"
>  
> -/* Mutex to protect rdtgroup access. */
> -DEFINE_MUTEX(rdtgroup_mutex);
> +/*
> + * rdt_domain structures are kfree()d when their last CPU goes offline,
> + * and allocated when the first CPU in a new domain comes online.
> + * The rdt_resource's domain list is updated when this happens. Readers of
> + * the domain list must either take cpus_read_lock(), or rely on an RCU
> + * read-side critical section, to avoid observing concurrent modification.
> + * All writers take this mutex:
> + */
> +static DEFINE_MUTEX(domain_list_lock);
>  
>  /*
>   * The cached resctrl_pqr_state is strictly per CPU and can never be
> @@ -356,6 +364,15 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
>  {
>  	struct rdt_domain *d;
>  
> +	/*
> +	 * Walking r->domains, ensure it can't race with cpuhp.
> +	 * Because this is called via IPI by rdt_ctrl_update(), assertions
> +	 * about locks this thread holds will lead to false positives. Check
> +	 * someone is holding the CPUs lock.
> +	 */
> +	if (IS_ENABLED(CONFIG_LOCKDEP))
> +		lockdep_is_cpus_held();
> +
>  	list_for_each_entry(d, &r->domains, list) {
>  		/* Find the domain that contains this CPU */
>  		if (cpumask_test_cpu(cpu, &d->cpu_mask))
> @@ -512,6 +529,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  	struct rdt_domain *d;
>  	int err;
>  
> +	lockdep_assert_held(&domain_list_lock);
> +
>  	d = rdt_find_domain(r, id, &add_pos);
>  	if (IS_ERR(d)) {
>  		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> @@ -545,11 +564,12 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  		return;
>  	}
>  
> -	list_add_tail(&d->list, add_pos);
> +	list_add_tail_rcu(&d->list, add_pos);
>  
>  	err = resctrl_online_domain(r, d);
>  	if (err) {
> -		list_del(&d->list);
> +		list_del_rcu(&d->list);
> +		synchronize_rcu();
>  		domain_free(hw_dom);
>  	}
>  }
> @@ -560,6 +580,8 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  	struct rdt_hw_domain *hw_dom;
>  	struct rdt_domain *d;
>  
> +	lockdep_assert_held(&domain_list_lock);
> +
>  	d = rdt_find_domain(r, id, NULL);
>  	if (IS_ERR_OR_NULL(d)) {
>  		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> @@ -570,7 +592,8 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  	cpumask_clear_cpu(cpu, &d->cpu_mask);
>  	if (cpumask_empty(&d->cpu_mask)) {
>  		resctrl_offline_domain(r, d);
> -		list_del(&d->list);
> +		list_del_rcu(&d->list);
> +		synchronize_rcu();
>  
>  		/*
>  		 * rdt_domain "d" is going to be freed below, so clear
> @@ -600,13 +623,13 @@ static int resctrl_arch_online_cpu(unsigned int cpu)
>  {
>  	struct rdt_resource *r;
>  
> -	mutex_lock(&rdtgroup_mutex);
> +	mutex_lock(&domain_list_lock);
>  	for_each_capable_rdt_resource(r)
>  		domain_add_cpu(cpu, r);
> -	clear_closid_rmid(cpu);
> +	mutex_unlock(&domain_list_lock);
>  
> +	clear_closid_rmid(cpu);
>  	resctrl_online_cpu(cpu);
> -	mutex_unlock(&rdtgroup_mutex);
>  
>  	return 0;
>  }
> @@ -615,13 +638,14 @@ static int resctrl_arch_offline_cpu(unsigned int cpu)
>  {
>  	struct rdt_resource *r;
>  
> -	mutex_lock(&rdtgroup_mutex);
>  	resctrl_offline_cpu(cpu);
>  
> +	mutex_lock(&domain_list_lock);
>  	for_each_capable_rdt_resource(r)
>  		domain_remove_cpu(cpu, r);
> +	mutex_unlock(&domain_list_lock);
> +
>  	clear_closid_rmid(cpu);
> -	mutex_unlock(&rdtgroup_mutex);
>  
>  	return 0;
>  }
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 64db51455df3..dc59643498bf 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -212,6 +212,9 @@ static int parse_line(char *line, struct resctrl_schema *s,
>  	struct rdt_domain *d;
>  	unsigned long dom_id;
>  
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>  	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
>  	    (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)) {
>  		rdt_last_cmd_puts("Cannot pseudo-lock MBA resource\n");
> @@ -316,6 +319,9 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
>  	struct rdt_domain *d;
>  	u32 idx;
>  
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>  	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
>  		return -ENOMEM;
>  
> @@ -381,11 +387,9 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>  		return -EINVAL;
>  	buf[nbytes - 1] = '\0';
>  
> -	cpus_read_lock();
>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>  	if (!rdtgrp) {
>  		rdtgroup_kn_unlock(of->kn);
> -		cpus_read_unlock();
>  		return -ENOENT;
>  	}
>  	rdt_last_cmd_clear();
> @@ -447,7 +451,6 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>  out:
>  	rdt_staged_configs_clear();
>  	rdtgroup_kn_unlock(of->kn);
> -	cpus_read_unlock();
>  	return ret ?: nbytes;
>  }
>  
> @@ -467,6 +470,9 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
>  	bool sep = false;
>  	u32 ctrl_val;
>  
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>  	seq_printf(s, "%*s:", max_name_width, schema->name);
>  	list_for_each_entry(dom, &r->domains, list) {
>  		if (sep)
> @@ -537,6 +543,9 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  {
>  	int cpu;
>  
> +	/* When picking a CPU from cpu_mask, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>  	/*
>  	 * Setup the parameters to pass to mon_event_count() to read the data.
>  	 */
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 241b3dd8646c..4688eb9f0b8c 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -15,6 +15,7 @@
>   * Software Developer Manual June 2016, volume 3, section 17.17.
>   */
>  
> +#include <linux/cpu.h>
>  #include <linux/module.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> @@ -472,6 +473,9 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  
>  	lockdep_assert_held(&rdtgroup_mutex);
>  
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>  	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
>  
>  	entry->busy = 0;
> @@ -801,6 +805,7 @@ void cqm_handle_limbo(struct work_struct *work)
>  	struct rdt_resource *r;
>  	struct rdt_domain *d;
>  
> +	cpus_read_lock();
>  	mutex_lock(&rdtgroup_mutex);
>  
>  	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> @@ -816,6 +821,7 @@ void cqm_handle_limbo(struct work_struct *work)
>  	}
>  
>  	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
>  }
>  
>  /**
> @@ -847,6 +853,7 @@ void mbm_handle_overflow(struct work_struct *work)
>  	struct rdt_resource *r;
>  	struct rdt_domain *d;
>  
> +	cpus_read_lock();
>  	mutex_lock(&rdtgroup_mutex);
>  
>  	/*
> @@ -880,6 +887,7 @@ void mbm_handle_overflow(struct work_struct *work)
>  
>  out_unlock:
>  	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
>  }
>  
>  /**
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 8056bed033cc..884b88e25141 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -844,6 +844,9 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
>  	struct rdt_domain *d_i;
>  	bool ret = false;
>  
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>  	if (!zalloc_cpumask_var(&cpu_with_psl, GFP_KERNEL))
>  		return true;
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index d38b2fe6e3ca..3cfa206c06cf 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -35,6 +35,10 @@
>  DEFINE_STATIC_KEY_FALSE(rdt_enable_key);
>  DEFINE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>  DEFINE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
> +
> +/* Mutex to protect rdtgroup access. */
> +DEFINE_MUTEX(rdtgroup_mutex);
> +
>  static struct kernfs_root *rdt_root;
>  struct rdtgroup rdtgroup_default;
>  LIST_HEAD(rdt_all_groups);
> @@ -1014,6 +1018,7 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
>  	bool sep = false;
>  	u32 ctrl_val;
>  
> +	cpus_read_lock();
>  	mutex_lock(&rdtgroup_mutex);
>  	hw_shareable = r->cache.shareable_bits;
>  	list_for_each_entry(dom, &r->domains, list) {
> @@ -1074,6 +1079,7 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
>  	}
>  	seq_putc(seq, '\n');
>  	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
>  	return 0;
>  }
>  
> @@ -1329,6 +1335,9 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
>  	struct rdt_domain *d;
>  	u32 ctrl;
>  
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>  	list_for_each_entry(s, &resctrl_schema_all, list) {
>  		r = s->res;
>  		if (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)
> @@ -1593,6 +1602,7 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
>  	struct rdt_domain *dom;
>  	bool sep = false;
>  
> +	cpus_read_lock();
>  	mutex_lock(&rdtgroup_mutex);
>  
>  	list_for_each_entry(dom, &r->domains, list) {
> @@ -1609,6 +1619,7 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
>  	seq_puts(s, "\n");
>  
>  	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
>  
>  	return 0;
>  }
> @@ -1700,6 +1711,9 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
>  	struct rdt_domain *d;
>  	int ret = 0;
>  
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>  next:
>  	if (!tok || tok[0] == '\0')
>  		return 0;
> @@ -1741,6 +1755,7 @@ static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,
>  	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>  		return -EINVAL;
>  
> +	cpus_read_lock();
>  	mutex_lock(&rdtgroup_mutex);
>  
>  	rdt_last_cmd_clear();
> @@ -1750,6 +1765,7 @@ static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,
>  	ret = mon_config_write(r, buf, QOS_L3_MBM_TOTAL_EVENT_ID);
>  
>  	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
>  
>  	return ret ?: nbytes;
>  }
> @@ -1765,6 +1781,7 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
>  	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>  		return -EINVAL;
>  
> +	cpus_read_lock();
>  	mutex_lock(&rdtgroup_mutex);
>  
>  	rdt_last_cmd_clear();
> @@ -1774,6 +1791,7 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
>  	ret = mon_config_write(r, buf, QOS_L3_MBM_LOCAL_EVENT_ID);
>  
>  	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
>  
>  	return ret ?: nbytes;
>  }
> @@ -2250,6 +2268,9 @@ static int set_cache_qos_cfg(int level, bool enable)
>  	struct rdt_domain *d;
>  	int cpu;
>  
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>  	if (level == RDT_RESOURCE_L3)
>  		update = l3_qos_cfg_update;
>  	else if (level == RDT_RESOURCE_L2)
> @@ -2449,6 +2470,7 @@ struct rdtgroup *rdtgroup_kn_lock_live(struct kernfs_node *kn)
>  
>  	rdtgroup_kn_get(rdtgrp, kn);
>  
> +	cpus_read_lock();
>  	mutex_lock(&rdtgroup_mutex);
>  
>  	/* Was this group deleted while we waited? */
> @@ -2466,6 +2488,8 @@ void rdtgroup_kn_unlock(struct kernfs_node *kn)
>  		return;
>  
>  	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
>  	rdtgroup_kn_put(rdtgrp, kn);
>  }
>  
> @@ -2798,6 +2822,9 @@ static int reset_all_ctrls(struct rdt_resource *r)
>  	struct rdt_domain *d;
>  	int i;
>  
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>  	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
>  		return -ENOMEM;
>  
> @@ -3082,6 +3109,9 @@ static int mkdir_mondata_subdir_alldom(struct kernfs_node *parent_kn,
>  	struct rdt_domain *dom;
>  	int ret;
>  
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>  	list_for_each_entry(dom, &r->domains, list) {
>  		ret = mkdir_mondata_subdir(parent_kn, dom, r, prgrp);
>  		if (ret)
> @@ -3912,13 +3942,13 @@ static void domain_destroy_mon_state(struct rdt_domain *d)
>  
>  void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
>  {
> -	lockdep_assert_held(&rdtgroup_mutex);
> +	mutex_lock(&rdtgroup_mutex);
>  
>  	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
>  		mba_sc_domain_destroy(r, d);
>  
>  	if (!r->mon_capable)
> -		return;
> +		goto out_unlock;
>  
>  	/*
>  	 * If resctrl is mounted, remove all the
> @@ -3943,6 +3973,9 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
>  	}
>  
>  	domain_destroy_mon_state(d);
> +
> +out_unlock:
> +	mutex_unlock(&rdtgroup_mutex);
>  }
>  
>  static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
> @@ -3978,20 +4011,22 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
>  
>  int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>  {
> -	int err;
> +	int err = 0;
>  
> -	lockdep_assert_held(&rdtgroup_mutex);
> +	mutex_lock(&rdtgroup_mutex);
>  
> -	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
> +	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA) {
>  		/* RDT_RESOURCE_MBA is never mon_capable */
> -		return mba_sc_domain_allocate(r, d);
> +		err = mba_sc_domain_allocate(r, d);
> +		goto out_unlock;
> +	}
>  
>  	if (!r->mon_capable)
> -		return 0;
> +		goto out_unlock;
>  
>  	err = domain_setup_mon_state(r, d);
>  	if (err)
> -		return err;
> +		goto out_unlock;
>  
>  	if (is_mbm_enabled()) {
>  		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
> @@ -4011,15 +4046,18 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>  	if (resctrl_mounted && resctrl_arch_mon_capable())
>  		mkdir_mondata_subdir_allrdtgrp(r, d);
>  
> -	return 0;
> +out_unlock:
> +	mutex_unlock(&rdtgroup_mutex);
> +
> +	return err;
>  }
>  
>  void resctrl_online_cpu(unsigned int cpu)
>  {
> -	lockdep_assert_held(&rdtgroup_mutex);
> -
> +	mutex_lock(&rdtgroup_mutex);
>  	/* The CPU is set in default rdtgroup after online. */
>  	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
> +	mutex_unlock(&rdtgroup_mutex);
>  }
>  
>  static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
> @@ -4038,8 +4076,7 @@ void resctrl_offline_cpu(unsigned int cpu)
>  	struct rdtgroup *rdtgrp;
>  	struct rdt_domain *d;
>  
> -	lockdep_assert_held(&rdtgroup_mutex);
> -
> +	mutex_lock(&rdtgroup_mutex);
>  	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
>  		if (cpumask_test_and_clear_cpu(cpu, &rdtgrp->cpu_mask)) {
>  			clear_childcpus(rdtgrp, cpu);
> @@ -4048,7 +4085,7 @@ void resctrl_offline_cpu(unsigned int cpu)
>  	}
>  
>  	if (!l3->mon_capable)
> -		return;
> +		goto out_unlock;
>  
>  	d = get_domain_from_cpu(cpu, l3);
>  	if (d) {
> @@ -4062,6 +4099,9 @@ void resctrl_offline_cpu(unsigned int cpu)
>  			cqm_setup_limbo_handler(d, 0, cpu);
>  		}
>  	}
> +
> +out_unlock:
> +	mutex_unlock(&rdtgroup_mutex);
>  }
>  
>  /*
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 270ff1d5c051..a365f67131ec 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -159,7 +159,7 @@ struct resctrl_schema;
>   * @cache_level:	Which cache level defines scope of this resource
>   * @cache:		Cache allocation related data
>   * @membw:		If the component has bandwidth controls, their properties.
> - * @domains:		All domains for this resource
> + * @domains:		RCU list of all domains for this resource
>   * @name:		Name to use in "schemata" file.
>   * @data_width:		Character width of data when displaying
>   * @default_ctrl:	Specifies default cache cbm or memory B/W percent.

-- 
Thanks
Babu Moger
