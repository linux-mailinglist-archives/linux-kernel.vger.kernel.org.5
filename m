Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D6F7BADA2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjJEVdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 17:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjJEVdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:33:10 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F5C95
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 14:33:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNbtZx1vaL74lLmY0T44zcoamHYn9G14of/91ykNQSJB+U8O/yrZKmYfjt0d0Gua9xAXk0c2MNKDSAudHz7W7cxJPZuxRIPx1Z7aYHSqbdK2r+bl5FSXQBNOyJ8AacfOx2oWGCBEabQwWAEWF3ah2dRTBWOrBNU1amB/oQITFYknJ/E8+pqwM6eoJvZe8D84dECJS5W7LADspDDbULm2VDM+36rxxsa3R7C9Dxsl54EOyztFj1HodiH2ZfKymtLQ0YdJKiHR3xwObKnkN86E7aE2dYMn42TiRm0oSat/0j8KJ0w9297T7wIw3IUqsjaDWD82vcw89t57VfFibFtlbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQFOz40chl5i4NUObEdbD4rJ9aPyhY+jBmtInapFcU4=;
 b=TlXv9wKhSNI98fBS4yDK27sjFOBmzYonSkFM7wLjz1isl/dyKWIfknsoLYG4jGYHY9oXgKh/3/hcbRYsI7jJzaaucxU3Ncvv+DgBF09InDD60gZ/LL6JqtUA9krJY+mdrha/xctFK0n246Z3TIDLRIc+jEtHwLlbHC1+jQoVYyBW0TH+KHXmZH5GfygpOv5ddEvzqkWiy3RC5m12QIEeVByL3PXWTTQ9vDrvermwnC7d58aTnvjWjiEFzQ80GP7k6UfeE8ogWwDTN7WaH9QU7NXUTSNVgYhmg42+mVgbu6lEARAwuIToR1CbcoECLkdW46P+spA6MhUjBg7btdvyIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQFOz40chl5i4NUObEdbD4rJ9aPyhY+jBmtInapFcU4=;
 b=SFpwYWhydOihEHlsrPm0Cmh+VerO8tuO0hr+uG06pv2qBLrnaRkJO7OhNKvyzgsj2zwv0wK8agBNlyCRi45iSVmiI0t4JqFkZlUHq+rNe/fPAQYBSGfTTGzr9xQlqnn1nq01ZRWle6wW6pKKMfBVhXM1fcm6GDsl2MtlDeavE44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW6PR12MB8735.namprd12.prod.outlook.com (2603:10b6:303:245::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Thu, 5 Oct
 2023 21:33:04 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 21:33:04 +0000
Message-ID: <435fd495-9c3d-3c53-5c6e-441308ab18d3@amd.com>
Date:   Thu, 5 Oct 2023 16:33:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 14/24] x86/resctrl: Allow resctrl_arch_rmid_read() to
 sleep
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-15-james.morse@arm.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <20230914172138.11977-15-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW6PR12MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: 52eda0e9-0a00-4a66-fbe3-08dbc5eaa89d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ygAFZ7pQHLMr9B0GoM2e3OQAnSn/8+Fx/8Dw98pRQXA2K8o+MvM6gYWCaczo8Pw3wktsaiW2b1fHBo43bp6klum6r9hLeYvpe5L09krUwyWHxHIe9gHqQ+pD2vrKLlYW0INeNAjWCO8DMclTMDOYBPuaoDbkpKuyUCgbpUvmnHltEkH+cmndhDB0TEDA5gq8PGeRkebdxWT5YrT/M6qXd7NU3Z1IbbTGQ+q6uDjICSSWa7WmvrE64CxIT9L9kZeqPceUQx6FhHhCGI16MDWLBKq9Sa+17rqn1KSHm5FuIdpGLuHDKQVhPIHLNZvW8vY8NTVPOtxjdRuPzAea5LjVMoU1maDgNASJE7OHWK/f2L06f9NlPL6Ap2L1Fche1osEKNf77KhcHG+afYx3joSYMR1ci7nco4ByQB8OhTAgAkt99PceRjXwIJtqWKGdvhcLWc76gJ63hZ6tMxdB7iFzHJ+AFl8Dl1rLWokGRaEo//k0OZS4OkMuMVirhGYzHQmWy/JY8k2dOFpwKVd5ac7QiZwXP1X/COJEK6HeLC1FGOci4ri0Jtjxdq9l4K2rpgwUCdurqpdkmE3KTHq003mAgm6ORfCm3OMO0V6M+BDEOEg0AFHrHgWcVS/MQ11HL0i7GDLDHMtxKAWKk5aznyxOxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31686004)(316002)(8676002)(8936002)(4326008)(7416002)(5660300002)(41300700001)(38100700002)(54906003)(66946007)(66556008)(66476007)(478600001)(6486002)(31696002)(2906002)(6666004)(2616005)(6512007)(53546011)(26005)(6506007)(36756003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REkxaVorYzV0VHdZS3pvR0owOHdIRmZidHhrVEJlQUxVQXNraDE4TGdxK2Qr?=
 =?utf-8?B?WVJXelBNa3RoeEtla3VBbEhLR0E2VUwwVWxFWU92NjgvSGhITnU2T2pGTkhL?=
 =?utf-8?B?QU5ORnRjeEtCY05tLzdLYWY0NzE0RGNJdWV4cURkUU5sekF6Tit6eTFNR1RI?=
 =?utf-8?B?bHVHRkIybFE1SFY5RDh5dVVZREJKempDa3pyaXhKZkZTQWQ0M0IrQnl1WVF2?=
 =?utf-8?B?dnFZY0s0dGJEcDltM0RGNE4yaXl3RDJWOFV2YWhMQ1VPaXhOQmxlTGRUL0Ny?=
 =?utf-8?B?VnhVR3Z1aG9jOWE5R1JJa05RaEk4UnVobzc2MW5MNUs4aytvakRGeHFMajll?=
 =?utf-8?B?Zk1sYkNpbHY2QVJCSzE1bVNWb0c0MVNlY096alAxSUpQczVOTG5NZlhHSkx3?=
 =?utf-8?B?cDlDWEt4VDhVeURMb3FPdVVpRkNmeDhGc1IwaEY4Nmc0RldYWmExT3VCa054?=
 =?utf-8?B?dk1zeXlEMmdaRE8xS0N6K3pEU043MVZGYXhmTm91bE5ycWUvdjlReUIzMmRV?=
 =?utf-8?B?RDFHczRsWDlLRmNRb0NpOFo3VXNoYS81M0IxNDFYOS9oRGR0RndyMkQ3akJP?=
 =?utf-8?B?UHNibVQvK0krMGcyaHhrQnNaaFNxQ3FYTWRTRFZwNmZjMlpwVTh0N2FZaUhK?=
 =?utf-8?B?d0FyRWx1Y2NMYjExaHZjdk5YUGFrRlg4UVZyUkRlRzBkQ2gvREgyMWZSVk5M?=
 =?utf-8?B?ZHRjVWxvblFFM3JCbCtXYm1JbU9VRU5nMzlyWXc5UWErbWR2ZkpSUjFzZUt2?=
 =?utf-8?B?ekxqSTNZMEtXVW9DTjlqODQ4a3l4Q3U5Rk51cGRIcFNMYUFpcmdPRnM3MitC?=
 =?utf-8?B?eVBRSWhHWTJBQVVDSUNDY0VXb20rL1VwalpNSWtxZ2U5REhSaTRKY0RidTVx?=
 =?utf-8?B?M2xEcVp6c3lGZ1R5OEJZYXpLUHZteDdFM002WlJ4NFF5b1Y4MkhlVFVEVmJ4?=
 =?utf-8?B?d05STlJYaXB0aXVzOEcxUlFzQWMveFNvVHJwWFBEUDZyRHdCelRPSUlNRE9F?=
 =?utf-8?B?Z0tObVZtaTFuR0o4Sm50WGpnNWljbGFCdEIwYUxBQ2Z2V2dEK1VlYzJaUExH?=
 =?utf-8?B?T240UDZaMnYxTVF3dncwVmxqbGR4OHY3c2xzT1FJMkhqdUxPOFBxV2IzMEF5?=
 =?utf-8?B?dnoyS2MyWHlVSGdhWjcrQ01EZGJKb0NqQWRTY1FhQWxoajFyTFp6WlZUSGVU?=
 =?utf-8?B?bDdRUjUwcVd1R1pkV1Fyc2ZMMWFxdUZYOXJSWHBCTlhLYXJVRTBBK1VtR2lR?=
 =?utf-8?B?WjN0LzJEalE4NUU0U0NkcXZzVURINGU5ekJ3VEw2ZnNoMFVuV1RISkJKSGRz?=
 =?utf-8?B?ZHVBeEx2LzZ0dG9DNStzOFFRVklDODg4YmlCSmRwenFKa3orUlZxUVA5dlVi?=
 =?utf-8?B?Y1QxaThQNmJSYU42UDBsS29SRFNuRDZ3OTBTV1RUMkx2RGx2d2E4a1BSUlhG?=
 =?utf-8?B?Qm8rb3hVNld3VDBRY294TTFiTUY3M0pDa0hZSUZrOVJqSnZRK2pxLzdrVi96?=
 =?utf-8?B?ZXk0VTh0WGJJTTZZVlpEZExSRUx4bW5mdW9JRTRzU2xGYWVZR2xZcHc2cm1G?=
 =?utf-8?B?WHJTMnIvMGFpVHd6MWcvU1JDbGJibnQ0MG4vYVFndEg4aXNBUzRkUFZTOFk3?=
 =?utf-8?B?QU5peENNTk5IcVorRzVMTXlFSEp6d2xFcmUwWXpYZS9KSHgvV3FUeGkwckZx?=
 =?utf-8?B?N0d3VjIvTzM5aUtyS2lwbjc0RFFBOFgwcElwTzFsa3l4ajNvdzRKY095azhI?=
 =?utf-8?B?eUZTYUhiY3NKcVRPaHgrRGlsZzhGNGhzWUUwNGdlZkZvdllmU25QdEplVUsz?=
 =?utf-8?B?c1oxR0E5dHRVZzRIcGl5ZG16OHBPZGNNZXFWQ05KZEpHaFVRTlBoTnFCQ0N6?=
 =?utf-8?B?TWZ4UnYrVzZnTlB2ekFUNWUxYUlSR2V4L1kwQm9LdE52R1dRdXdOR1JsRkRS?=
 =?utf-8?B?QTEvTEFwWno2cUUveWcxU0cvQTc1eENzRklybzlXbTRHOHYxNFRLMHJncFZ0?=
 =?utf-8?B?dHZwWUlVZUlDaGlINHNUYVU1b0xUckdRbS9CbGtJQWkzMEsvOUhubndkdGRN?=
 =?utf-8?B?YjFIcFBzM3Naa0dORjcxY0RzZWM5OTBJWkhPOXZrclNXVHVFL3RxTHl1amVE?=
 =?utf-8?Q?DcRg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52eda0e9-0a00-4a66-fbe3-08dbc5eaa89d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 21:33:04.6642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6FeHmjvngilDjvy5lnntwGlWlF8AIp69MPAkIsrrqSYXhRBDV7/mkdp7IrDQU3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8735
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/2023 12:21 PM, James Morse wrote:
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
> in use, and there are there are no housekeeping CPUs in the necessary

:%s/there are there are/there are/

Thanks

Babu

> domain.
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
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-By: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> The previous version allowed resctrl_arch_rmid_read() to be called on the
> wrong CPUs, but now that this needs to take nohz_full and housekeeping into
> account, its too complex.
>
> Changes since v3:
>   * Removed error handling for smp_call_function_any(), this can't race
>     with the cpuhp callbacks as both hold rdtgroup_mutex.
>   * Switched to the alternative of removing the counter read, this simplifies
>     things dramatically.
>
> Changes since v4:
>   * Messed with capitalisation.
>   * Removed some dead code now that entry->busy will never be zero in
>     add_rmid_to_limbo().
>   * Rephrased the comment above resctrl_arch_rmid_read_context_check().
> ---
>   arch/x86/kernel/cpu/resctrl/monitor.c | 25 +++++--------------------
>   include/linux/resctrl.h               | 18 +++++++++++++++++-
>   2 files changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 7749e6569a4a..05d949ec94f1 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -278,6 +278,8 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>   	u64 msr_val, chunks;
>   	int ret;
>   
> +	resctrl_arch_rmid_read_context_check();
> +
>   	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
>   		return -EINVAL;
>   
> @@ -454,8 +456,6 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>   {
>   	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>   	struct rdt_domain *d;
> -	int cpu, err;
> -	u64 val = 0;
>   	u32 idx;
>   
>   	lockdep_assert_held(&rdtgroup_mutex);
> @@ -463,17 +463,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>   	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
>   
>   	entry->busy = 0;
> -	cpu = get_cpu();
>   	list_for_each_entry(d, &r->domains, list) {
> -		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
> -			err = resctrl_arch_rmid_read(r, d, entry->closid,
> -						     entry->rmid,
> -						     QOS_L3_OCCUP_EVENT_ID,
> -						     &val);
> -			if (err || val <= resctrl_rmid_realloc_threshold)
> -				continue;
> -		}
> -
>   		/*
>   		 * For the first limbo RMID in the domain,
>   		 * setup up the limbo worker.
> @@ -483,15 +473,10 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>   		set_bit(idx, d->rmid_busy_llc);
>   		entry->busy++;
>   	}
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
>   }
>   
>   void free_rmid(u32 closid, u32 rmid)
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 660752406174..f7311102e94c 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -236,7 +236,12 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>    * @eventid:		eventid to read, e.g. L3 occupancy.
>    * @val:		result of the counter read in bytes.
>    *
> - * Call from process context on a CPU that belongs to domain @d.
> + * Some architectures need to sleep when first programming some of the counters.
> + * (specifically: arm64's MPAM cache occupancy counters can return 'not ready'
> + *  for a short period of time). Call from a non-migrateable process context on
> + * a CPU that belongs to domain @d. e.g. use smp_call_on_cpu() or
> + * schedule_work_on(). This function can be called with interrupts masked,
> + * e.g. using smp_call_function_any(), but may consistently return an error.
>    *
>    * Return:
>    * 0 on success, or -EIO, -EINVAL etc on error.
> @@ -245,6 +250,17 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>   			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
>   			   u64 *val);
>   
> +/**
> + * resctrl_arch_rmid_read_context_check()  - warn about invalid contexts
> + *
> + * When built with CONFIG_DEBUG_ATOMIC_SLEEP generate a warning when
> + * resctrl_arch_rmid_read() is called with preemption disabled.
> + */
> +static inline void resctrl_arch_rmid_read_context_check(void)
> +{
> +	if (!irqs_disabled())
> +		might_sleep();
> +}
>   
>   /**
>    * resctrl_arch_reset_rmid() - Reset any private state associated with rmid
