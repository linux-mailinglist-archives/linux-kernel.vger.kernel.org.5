Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980667A6A55
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjISR7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjISR7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:59:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F1F8F;
        Tue, 19 Sep 2023 10:59:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUe1o6khAKdZIpBIQAjFi6qOk1X9wYvBReY+PSFEDsyo1b1ciJQ+jYri/9xf1ciEjz9CRjZu2gHQ2Cs8yacvIyz9J0MXXQ1VVWKZklgRCGg96yxQsQvY7vw3n9n2oe6V5YmZdW1ZhfKB0eqdtiKz449g0ZzvvDCdLPzw2z8x4StqeHd2W/qvSDhzVHIOj4pFwCfkfTgpNnWYxWgw5GP2fMZvzCB3IOkzkCUZIJlF+yV1ZsUaHzOHMWzR2f9w1KFt6uurtcBgz70XVkCPFlFZ6dJEhGlb0FcAynYaINOvDMQG7PQLAkwaFRoRIW8owQPCjdGKqJ2WPU5SmbU7GfIn5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqRWDPPOTw4wWILbxcg8mrULLa1jJrj9ucJQnZF3PIY=;
 b=Ek8lTU+A+wyLLXfFPnX5u4JKotmh+nrgWQYXn0PZyfzwZSXr5sNtPyrvB3KkPksPH5UttAHw7R/peU2h1slR6MKJG9l3qbnTGSr81B0jd0axoWhDhY3+10XTlJvaJHAh/kEY0rrDbNu2e7jsv2cBWHsshnF2HvqVfVS5YuBdO3rbIvY1t4bf25HWK5apNYTzrcd6RVjPw0jmeUkMdaD0oJbEhzrFJXp4Z9ZYQ0SdvccqwC/1W2WZNw+CsGJG5IpnKBIuPAsqqdLU1MZ8ZGabIt4q43e3SqTegQua8bVwSlLnR+ppjx2hTJHVigdjBxj1X534t42izEBOrQuKbr5buA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqRWDPPOTw4wWILbxcg8mrULLa1jJrj9ucJQnZF3PIY=;
 b=Jkx5jEkut8RtzmH7GFvPOKHYHt3Cay9/pAv6zX3CqUZ+DIIKQoErXbjTMYghpx3ZjOBu7FNSpX3H6X/wzPoD30FCP6Sa5VERBRJEPZVZ9K9UGpsj9VDNcm16Myt5pG96v9kuPHMDt1VTXcHzPq3jFXX2AtPYjLOMiNgX+ypiO5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 17:59:14 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3043:e5d2:42f4:a231]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3043:e5d2:42f4:a231%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 17:59:14 +0000
Message-ID: <6ae4df67-ba0b-4b50-8c1d-a5d382105ad2@amd.com>
Date:   Tue, 19 Sep 2023 13:59:11 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v7 3/3] x86/mce: Handle Intel threshold interrupt storms
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
References: <20230616182744.17632-1-tony.luck@intel.com>
 <20230718210813.291190-1-tony.luck@intel.com>
 <20230718210813.291190-4-tony.luck@intel.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230718210813.291190-4-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0931.namprd03.prod.outlook.com
 (2603:10b6:408:108::6) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|IA1PR12MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: f988666f-d4c7-4164-6a97-08dbb93a2260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/nBZqkJX7gMncFBH1BuCneVSHqZnVaaAoJVZBVSQ/TlWLJrNHxl49chk4loFcSKBNgtejUAd+KqZGXbckOKG3TWTFKVnhT6iF9bxQPb4h85B3ESDZJACGbVbMtFZArcyrbgymqK5x2JIcj35rw5OyQcp32HeDS7N1JpOMHBYIYkjCYQ4MNio3WJZE7RU1HIIqEzSjtOT6PeZ5bfjkw3uojzmpziPT6YdgJdH6ROBVkgb2mfawgtUI2Z5Kpg1z2rsfHWdJgseEDNotDXMT4LPhwLG10cJng0+JfmohH0i7gPwaNGOA+u8im0O/r5YxATGaypFSOWTrc9Vq6QmtAwJM/9GSUcgqdkdamjJtB2SmGl0zbEssdxcqupB/HAP+CNBsiRDZvVcNnMz1O4YHM3z/Rluez/+mbQh7zPiKL9JkHpDeSEzdNfaBBPlGiFjN1KnhH7tgYtAyWudlaikkFQN/LBw2frBiR4jd7Ko3ThM5JrA/PhK8muQQS/8UPF2h5pWxD9hxIWMpwTtWklEDVVxZj+P0S5P8q+FoHJd65GXJeqRc78d6Nm5VVhdaE4GD0IZevyabo11O1e7c2c7BHRRyUw+EQMVp/sSM/nDS4ZbQDM59FOCwpyqzUv+sBMnO59VRZBrwMKz0kDcdUauaYfaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(136003)(376002)(186009)(1800799009)(451199024)(2616005)(26005)(6486002)(6506007)(53546011)(6512007)(86362001)(36756003)(31696002)(38100700002)(83380400001)(44832011)(5660300002)(478600001)(30864003)(41300700001)(66946007)(66556008)(66476007)(110136005)(316002)(4326008)(8676002)(8936002)(31686004)(6666004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWJKRjkzUlZYM25jSWszZW1jN0xIZFRuSS9ZN3hvZzNweXc2YzgwTS9PMmdF?=
 =?utf-8?B?d1RUbTZpdWNJTElRZGlpaHZNQ3hzaC82a1hydGx1aUdva1dKdXZwblFpQ3hH?=
 =?utf-8?B?cXY2YnFEbkhpZlNqU2FRVUdURjI3NGNZQ2ZhbElmc3NOOEp3ekFoR1RUMC8w?=
 =?utf-8?B?emxreUxjcm1IODdkQXNvREllcGRmMldwWFlQWnBCbFhGU24wQklybkhyNitI?=
 =?utf-8?B?RDJzNzh6TGUxQjJkU3ZHK0FOelNxY1NBQU53OTQzcm1ISzJFVWlmdFVpT0VR?=
 =?utf-8?B?dkN5UVY4S0NjK08yRENpWE0rUUF4M2p1KzZKVTBoNzlCY3VuT1gvUDFONUp4?=
 =?utf-8?B?cWZvSVBKbFd1Z2lDRGVLSkNWblpEYWlaNUdvdCsxUERsbXZKWUhubTQvZUZC?=
 =?utf-8?B?OG5ib0dTQkJVZVBtNS8vN0FPS2M4NWlFdUxmclBmQXR2Z2NNYkgyWDQ0Y2Fm?=
 =?utf-8?B?WE55akhsQm40enVwQjdEM2ZZS1NiYzYrdG9lS3NEYnExcGYzMVBLQ093K01S?=
 =?utf-8?B?Y05xcFVneE1Pak9jQ3VrVWI0b1R4R3YxMEtKUGdoek1OSzhzQTdaZDJBakQy?=
 =?utf-8?B?SDZseU9UY1Vzb1JjU0VSN0RLckRpZGZEZkVyWThiRVlYcGY2bGc3Uys1Ykty?=
 =?utf-8?B?QUorMFkweGs2NVQxNXNneVZEZGV1ZUk5Z3RiMmViK2t6U3o1ZWpXUEJ3ZVRN?=
 =?utf-8?B?WXlZeTVZU2JzNVVFVzZYQmNzQ1FnMVluNkd2K0hwdXFBMlNmQUZob3RZOExU?=
 =?utf-8?B?RVVXNmY0clBKTU00c2JrSUtPa0lSRHpEbTk4MFJpYi8rdDliTTN2bHZpTWV3?=
 =?utf-8?B?QWE5TUN0NWp3Rk4vTGZxM2NpQWlyTXBWR0pZdFJiSkRRNUJrZVd2SkdYd3FZ?=
 =?utf-8?B?SEpvdHJQdGh6dXZZa1c1cUVGdVAyL2NiM09VZWNTNm80S2QrZ0JhbHo0ZEg0?=
 =?utf-8?B?TkV1TEZtdEU2aU1mVU51N21JMllhV0NBZDZNdk5YeXZHVmhhcENMaHVmbnc1?=
 =?utf-8?B?b1M4LzBCeVRJQmpYeUdCZ05zdkdzL0ZkOUs5MmRwUmdhNCtvaVFaVXB6STRy?=
 =?utf-8?B?c0hNbmFLL3NmaDJFRlR6SkJqRU55K3laSFlPRC90a1NHcEdua1ErOW9oQW94?=
 =?utf-8?B?Q3ZnSzViRDlPT1hNRmtJVDFJWXlxR2hyY21RMnJiZ21JeWJPbzRrdHNlVFdI?=
 =?utf-8?B?QlVCTVdjVXoyTzRscFkzQ2t2ZFRwVlZrcXFvNFZudnNKekkwelljNUZkbUNM?=
 =?utf-8?B?QWV3VGlKL2ZZdk1HRUQ4Sm5oUDFtWWIzRnZqbE1tdWVOSHhtaTB2TWFucHhO?=
 =?utf-8?B?dFk0WnFDbzl4OGkxaTNlUVBMdzhaZDdoVDcyNDhmdmdTL1NFZTdRdzEraUE1?=
 =?utf-8?B?WGJKOWM3QkozVHY0UGkrMG1uL1NxWWdvdTViQmc1bGhvUUxySUhPUkgwZXhv?=
 =?utf-8?B?V2RSeDFBN2JOUE9YaVdaMHF2bVJKRUJLT3QzaHA0WTZRd21BZDEvcGxjamI2?=
 =?utf-8?B?ZW8zSEQyVS9JUHBuVjJDTkRUQThCcWRhNU5lZlR0U0l6ekpjb0JtQjh2dTFp?=
 =?utf-8?B?bWJHS3NHWllIdEtyN2NqR2FSSVcvajg4eHBmbU1tVlhHOThaREJMd255clFM?=
 =?utf-8?B?V0IrRTFrNjdBTzNaYWJYd0d5QTFyYy9Mb2k4dWpzUkZwL0JFb09ic2hqZWFW?=
 =?utf-8?B?VUtHdXpDM2FXZmpuN3hJb1ltb2QzMnBQVk05YW43MTg2alRGaWM0dmlDdEhL?=
 =?utf-8?B?Y3VrUVZtbkZwYUdpblY0bjYxQzFKL3JxcXJ2YWRSZGRaY2RacnNJVWtBZG5F?=
 =?utf-8?B?QVZiUjVCY3Q2SUU5S0pSbkVud2k4b3QyVW55ZVE5eUtFTW90QzFVaVhpKzRs?=
 =?utf-8?B?L2g0OHdMcExQQ1BDOHpQSzZNZXArM2I1Zk9aa2FNZmhRRWdnWE9KdlUzY1VL?=
 =?utf-8?B?VVRVaWMvYzA2ZzFXcDNnM3Y0M1pFbUlIcHpSZFFlSEIwdzZhamRqWHNPU0JP?=
 =?utf-8?B?a2JET1JEcHZjaDBZcVNoOFFqdnRPZCt6dUUzM2cyRm9WRmNqT2wwMUhkRW1Y?=
 =?utf-8?B?NnNxUUNsd1RrdGZLWHh3UXNraXlWbEFQMGNwV21JbzFhVUw0aHNVczRoVHZQ?=
 =?utf-8?Q?ic2jX3hqXf55eTUjFwZ7CYZC9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f988666f-d4c7-4164-6a97-08dbb93a2260
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 17:59:14.1053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POjH0lpZkktTl/RbL4vGbo7u/2yZ2e48VlyFD4geR/5oyIFimuG0Ao5DUREJG1ODyFK54da+undF6OR0Ov1Cjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 5:08 PM, Tony Luck wrote:
> Add an Intel specific hook into machine_check_poll() to keep track
> of per-CPU, per-bank corrected error logs (with a stub for the
> CONFIG_MCE_INTEL=n case).
> 
> When a storm is observed the Rate of interrupts is reduced by setting

Rate -> rate

> a large threshold value for this bank in IA32_MCi_CTL2. This bank is
> added to the bitmap of banks for this CPU to poll. The polling rate
> is increased to once per second.
> 
> When a storm ends reset the

Spurious newline?

> threshold in IA32_MCi_CTL2 back to 1, removes the bank from the bitmap

removes -> remove

> for polling, and changes the polling rate back to the default.

changes -> change

> 
> If a CPU with banks in storm mode is taken offline, the new CPU
> that inherits ownership of those banks takes over management of
> storm(s) in the inherited bank(s).
> 
> The cmci_discover() function was already very large. These changes
> pushed it well over the top. Refactor with three helper functions
> to braing it back under control.

braing -> bring

> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/mce/internal.h |   2 +
>  arch/x86/kernel/cpu/mce/core.c     |   3 +
>  arch/x86/kernel/cpu/mce/intel.c    | 202 +++++++++++++++++++++--------
>  3 files changed, 156 insertions(+), 51 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
> index da790d13d010..e641c991beb1 100644
> --- a/arch/x86/kernel/cpu/mce/internal.h
> +++ b/arch/x86/kernel/cpu/mce/internal.h
> @@ -41,12 +41,14 @@ struct dentry *mce_get_debugfs_dir(void);
>  extern mce_banks_t mce_banks_ce_disabled;
>  
>  #ifdef CONFIG_X86_MCE_INTEL
> +void mce_intel_handle_storm(int bank, bool on);
>  void cmci_disable_bank(int bank);
>  void intel_init_cmci(void);
>  void intel_init_lmce(void);
>  void intel_clear_lmce(void);
>  bool intel_filter_mce(struct mce *m);
>  #else
> +static inline void mce_intel_handle_storm(int bank, bool on) { }
>  static inline void cmci_disable_bank(int bank) { }
>  static inline void intel_init_cmci(void) { }
>  static inline void intel_init_lmce(void) { }
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 6a44e15d74fe..0a287998e62f 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -2054,6 +2054,9 @@ static void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c)
>  void mce_handle_storm(int bank, bool on)
>  {
>  	switch (boot_cpu_data.x86_vendor) {
> +	case X86_VENDOR_INTEL:
> +		mce_intel_handle_storm(bank, on);
> +		break;
>  	}
>  }
>  
> diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
> index 052bf2708391..55643c5944e1 100644
> --- a/arch/x86/kernel/cpu/mce/intel.c
> +++ b/arch/x86/kernel/cpu/mce/intel.c
> @@ -47,8 +47,27 @@ static DEFINE_PER_CPU(mce_banks_t, mce_banks_owned);
>   */
>  static DEFINE_RAW_SPINLOCK(cmci_discover_lock);
>  
> +/* Linux non-storm CMCI threshold (may be overridden by BIOS) */
>  #define CMCI_THRESHOLD		1

Just curious, but why use '1' for the default? We have a lot of code to
hide corrected errors. So why not just use the maximum limit? This would
effectively hide the corrected errors. And if not the maximum, maybe some
other intermediate value?

>  
> +/*
> + * MCi_CTL2 threshold for each bank when there is no storm.
> + * Default value for each bank may have been set by BIOS.
> + */
> +static int cmci_threshold[MAX_NR_BANKS];

Can this be a 'u16', since the max threshold for Intel is 0x7FFF?

> +
> +/*
> + * High threshold to limit CMCI rate during storms. Max supported is
> + * 0x7FFF. Use this slightly smaller value so it has a distinctive
> + * signature when some asks "Why am I not seeing all corrected errors?"

Maybe this answers my question above.

> + * A high threshold is used instead of just disabling CMCI for a
> + * bank because both corrected and uncorrected errors may be logged
> + * in the same bank and signalled with CMCI. The threshold only applies
> + * to corrected errors, so keeping CMCI enabled means that uncorrected
> + * errors will still be processed in a timely fashion.
> + */
> +#define CMCI_STORM_THRESHOLD	32749
> +
>  static int cmci_supported(int *banks)
>  {
>  	u64 cap;
> @@ -103,6 +122,31 @@ static bool lmce_supported(void)
>  	return tmp & FEAT_CTL_LMCE_ENABLED;
>  }
>  
> +/*
> + * Set a new CMCI threshold value. Preserve the state of the
> + * MCI_CTL2_CMCI_EN bit in case this happens during a
> + * cmci_rediscover() operation.
> + */
> +static void cmci_set_threshold(int bank, int thresh)
> +{
> +	unsigned long flags;
> +	u64 val;
> +
> +	raw_spin_lock_irqsave(&cmci_discover_lock, flags);
> +	rdmsrl(MSR_IA32_MCx_CTL2(bank), val);
> +	val &= ~MCI_CTL2_CMCI_THRESHOLD_MASK;
> +	wrmsrl(MSR_IA32_MCx_CTL2(bank), val | thresh);
> +	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
> +}
> +
> +void mce_intel_handle_storm(int bank, bool on)
> +{
> +	if (on)
> +		cmci_set_threshold(bank, CMCI_STORM_THRESHOLD);
> +	else
> +		cmci_set_threshold(bank, cmci_threshold[bank]);
> +}
> +
>  /*
>   * The interrupt handler. This is called on every event.
>   * Just call the poller directly to log any events.
> @@ -114,72 +158,126 @@ static void intel_threshold_interrupt(void)
>  	machine_check_poll(MCP_TIMESTAMP, this_cpu_ptr(&mce_banks_owned));
>  }
>  
> +/*
> + * Check all the reasons why current CPU cannot claim
> + * ownership of a bank.
> + * 1: CPU already owns this bank
> + * 2: BIOS owns this bank
> + * 3: Some other CPU owns this bank
> + */
> +static bool cmci_skip_bank(int bank, u64 *val)
> +{
> +	unsigned long *owned = (void *)this_cpu_ptr(&mce_banks_owned);
> +
> +	if (test_bit(bank, owned))
> +		return true;
> +
> +	/* Skip banks in firmware first mode */
> +	if (test_bit(bank, mce_banks_ce_disabled))
> +		return true;
> +
> +	rdmsrl(MSR_IA32_MCx_CTL2(bank), *val);
> +
> +	/* Already owned by someone else? */
> +	if (*val & MCI_CTL2_CMCI_EN) {
> +		clear_bit(bank, owned);
> +		__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +/*
> + * Decide which CMCI interrupt threshold to use:
> + * 1: If this bank is in storm mode from whichever CPU was
> + *    the previous owner, stay in storm mode.
> + * 2: If ignoring any threshold set by BIOS, set Linux default
> + * 3: Try to honor BIOS threshold (unless buggy BIOS set it at zero).
> + */
> +static u64 cmci_pick_threshold(u64 val, int *bios_zero_thresh)
> +{
> +	if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD)
> +		return val;
> +
> +	if (!mca_cfg.bios_cmci_threshold) {

Are there many users of this option? Maybe this is something we should
also include in the AMD threshold code. But I don't think anyone has
asked me about it yet.

> +		val &= ~MCI_CTL2_CMCI_THRESHOLD_MASK;
> +		val |= CMCI_THRESHOLD;
> +	} else if (!(val & MCI_CTL2_CMCI_THRESHOLD_MASK)) {
> +		/*
> +		 * If bios_cmci_threshold boot option was specified
> +		 * but the threshold is zero, we'll try to initialize
> +		 * it to 1.
> +		 */
> +		*bios_zero_thresh = 1;
> +		val |= CMCI_THRESHOLD;
> +	}
> +
> +	return val;
> +}
> +
> +/*
> + * Try to claim ownership of a bank.
> + */
> +static void cmci_claim_bank(int bank, u64 val, int bios_zero_thresh, int *bios_wrong_thresh)
> +{
> +	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
> +
> +	val |= MCI_CTL2_CMCI_EN;
> +	wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
> +	rdmsrl(MSR_IA32_MCx_CTL2(bank), val);
> +
> +	/* Did the enable bit stick? -- the bank supports CMCI */
> +	if (val & MCI_CTL2_CMCI_EN) {
> +		set_bit(bank, (void *)this_cpu_ptr(&mce_banks_owned));

Newline here, please.

> +		if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD) {
> +			pr_notice("CPU%d BANK%d CMCI inherited storm\n", smp_processor_id(), bank);
> +			storm->banks[bank].history = ~0ull;
> +			storm->banks[bank].timestamp = jiffies;
> +			cmci_storm_begin(bank);
> +		} else {
> +			__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
> +		}

Newline here, please.

> +		/*
> +		 * We are able to set thresholds for some banks that
> +		 * had a threshold of 0. This means the BIOS has not
> +		 * set the thresholds properly or does not work with
> +		 * this boot option. Note down now and report later.
> +		 */
> +		if (mca_cfg.bios_cmci_threshold && bios_zero_thresh &&
> +		    (val & MCI_CTL2_CMCI_THRESHOLD_MASK))
> +			*bios_wrong_thresh = 1;
> +
> +		/* Save default threshold for each bank */
> +		if (cmci_threshold[bank] == 0)
> +			cmci_threshold[bank] = val & MCI_CTL2_CMCI_THRESHOLD_MASK;
> +	} else {
> +		WARN_ON(!test_bit(bank, this_cpu_ptr(mce_poll_banks)));

Could you invert the "MCI_CTL2_CMCI_EN" check and WARN/return early?
This could save an indentation level.

> +	}
> +}
> +
>  /*
>   * Enable CMCI (Corrected Machine Check Interrupt) for available MCE banks
>   * on this CPU. Use the algorithm recommended in the SDM to discover shared
> - * banks.
> + * banks. Called during initial bootstrap, and also for hotplug CPU operations
> + * to rediscover/reassign machine check banks.
>   */
>  static void cmci_discover(int banks)
>  {
> -	unsigned long *owned = (void *)this_cpu_ptr(&mce_banks_owned);
> -	unsigned long flags;
> -	int i;
>  	int bios_wrong_thresh = 0;
> +	unsigned long flags;
> +	int i;
>  
>  	raw_spin_lock_irqsave(&cmci_discover_lock, flags);
>  	for (i = 0; i < banks; i++) {
>  		u64 val;
>  		int bios_zero_thresh = 0;
>  
> -		if (test_bit(i, owned))
> +		if (cmci_skip_bank(i, &val))
>  			continue;
>  
> -		/* Skip banks in firmware first mode */
> -		if (test_bit(i, mce_banks_ce_disabled))
> -			continue;
> -
> -		rdmsrl(MSR_IA32_MCx_CTL2(i), val);
> -
> -		/* Already owned by someone else? */
> -		if (val & MCI_CTL2_CMCI_EN) {
> -			clear_bit(i, owned);
> -			__clear_bit(i, this_cpu_ptr(mce_poll_banks));
> -			continue;
> -		}
> -
> -		if (!mca_cfg.bios_cmci_threshold) {
> -			val &= ~MCI_CTL2_CMCI_THRESHOLD_MASK;
> -			val |= CMCI_THRESHOLD;
> -		} else if (!(val & MCI_CTL2_CMCI_THRESHOLD_MASK)) {
> -			/*
> -			 * If bios_cmci_threshold boot option was specified
> -			 * but the threshold is zero, we'll try to initialize
> -			 * it to 1.
> -			 */
> -			bios_zero_thresh = 1;
> -			val |= CMCI_THRESHOLD;
> -		}
> -
> -		val |= MCI_CTL2_CMCI_EN;
> -		wrmsrl(MSR_IA32_MCx_CTL2(i), val);
> -		rdmsrl(MSR_IA32_MCx_CTL2(i), val);
> -
> -		/* Did the enable bit stick? -- the bank supports CMCI */
> -		if (val & MCI_CTL2_CMCI_EN) {
> -			set_bit(i, owned);
> -			__clear_bit(i, this_cpu_ptr(mce_poll_banks));
> -			/*
> -			 * We are able to set thresholds for some banks that
> -			 * had a threshold of 0. This means the BIOS has not
> -			 * set the thresholds properly or does not work with
> -			 * this boot option. Note down now and report later.
> -			 */
> -			if (mca_cfg.bios_cmci_threshold && bios_zero_thresh &&
> -					(val & MCI_CTL2_CMCI_THRESHOLD_MASK))
> -				bios_wrong_thresh = 1;
> -		} else {
> -			WARN_ON(!test_bit(i, this_cpu_ptr(mce_poll_banks)));
> -		}
> +		val = cmci_pick_threshold(val, &bios_zero_thresh);
> +		cmci_claim_bank(i, val, bios_zero_thresh, &bios_wrong_thresh);
>  	}
>  	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
>  	if (mca_cfg.bios_cmci_threshold && bios_wrong_thresh) {
> @@ -218,6 +316,8 @@ static void __cmci_disable_bank(int bank)
>  	val &= ~MCI_CTL2_CMCI_EN;
>  	wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
>  	__clear_bit(bank, this_cpu_ptr(mce_banks_owned));

Newline here, please.

> +	if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD)
> +		cmci_storm_end(bank);
>  }
>  
>  /*

Thanks,
Yazen
