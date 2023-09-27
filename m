Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D5C7B0EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjI0Wen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjI0Wem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:34:42 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC5711D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMPjE+GbjVDc/ERrEz0y3eKp/KOeJQrR6MbXX9iEtT0C2opN8GGGDjQcW0FuPd5r9zmXsuKyJqEjyF0DTQ0uB9x+3vtQhMlFkGte9x5r4QDxRQ3Hy06qCZT2hCNUljXftUpNWKvtbPSb6WV/6/gyU1P5Py0oshBvbUkpKNkh2cAOaMDTpV+bYxtQdP1N2W65nzjRguurkoJz5B0BvURumiSSaQ4zlPL9AKfQGXe1oKQ3DP5wnsx6Kbiz1UrewIWPUlLkEb0MKMQzZmDKGEsnxr8rFp+2IX6Y9BdKg0F3kUimu7UqwuQZXLShrG+R3gTKYEOCSHDXC6U9YkEOoPnKlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZ11qCKZPOUHb+cqKPcmAs1depuF9+3vD+l1euBmKD0=;
 b=aqY0Xm43HVw1CbNXYbKmBvwnrBYO/gd8MjudbpzplVQkcYYt5q9PtbjPM0NMLkVKunZY48Z6n77vi8ZACDpE7nzORX4aYpWTea/kEugbZmVSVuvbg+ZqKZFv1LJem1S1n951nY9wElooEMzX2FH/3o1+aQok/N4cdMTBVnjnTqaDMPArkUm8l4Q7L6xDA0JCuuwT9r4I2+KZRfLFWkVcM8UfXUCyE1YqNqEn8wdKOSVJ2JbIY+jxs76UcUDHy/PwFvgRu8qOdkd5u1DJVsc0V4HxEgGB8Tcz9bFYrRFSFmSlQ3jNOvVron6xGmTLtrPWs16zrD0QHvu+1w5U1VRbIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZ11qCKZPOUHb+cqKPcmAs1depuF9+3vD+l1euBmKD0=;
 b=P6I2FtD5n1PyEFwM1DXxkshDn/lYO0xnWm8YOKbUUcPLKZZZUy2yDyZ5fGuTYPQ/nnWWpCx5HTABOFtgHozGox8rnpw+w5YwYuioFi5SnlgyUVF118/mZki/4XHAy+LjfPEhi14NAspfNg99/qUphUVt1mQd1TTnrEvgvOe7Z7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 27 Sep
 2023 22:34:30 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 22:34:30 +0000
Message-ID: <9751cbaf-8653-d32a-6058-13c251c59b3d@amd.com>
Date:   Wed, 27 Sep 2023 17:34:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 1/4] x86/resctrl: Enable non-contiguous bits in Intel
 CAT
Content-Language: en-US
To:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org
References: <cover.1695371055.git.maciej.wieczor-retman@intel.com>
 <918e147601697b1d4b8f8589f5751e05d6ceccdf.1695371055.git.maciej.wieczor-retman@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <918e147601697b1d4b8f8589f5751e05d6ceccdf.1695371055.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::22) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ1PR12MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: ea993d47-6015-4f6e-dd54-08dbbfa9ea0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PR4PbXrPHuLMdIf1v8JRu4GzE6TSyRlyAUjcaM0eH0oiOYUg7Y1rJSHzCrQAemHJSI4xXOdzxvYPw8G+XJx2WotJprWuvEaM0DHMdTw/oJhLur3J+HuL56nvFGjtbjSp0UcCyJh5pApPlWJLd6g0mi+PFm8LkGm0POHSisLTxYI1MCFwd+WaqjAFfqlKjkFIosV+8wk1I+SaVBHvbFAnkED4VWSp1PIYDXT+4JGAxl2sQWAf3btvK3JceY0vXffSExOx/9XhN4JVrYbPt/6OxU1DAcK4oOlIMHBbiXdxMfpnA1WJ08/tllju0rDwpQ7GYWF5te2jmusyfqAB9OqrgYvCG2SpX5WPPHjIy8hM1Xhgo01NXw+pv4yftjVGi7TZMaKsjPMnQmL5tgCJXgpwci193DKRb1R6aRJs9ZvzwK98wtS28dTnKDXei8a1oCteT1VbSE4Yq+e4OBeXjGo71MlQ6so9eLI0zflgxDhtamxIACGdQV+rbUDQj5EKZJX/x8AnJwmQgtfCiKSe2b7DFLXjESOykvzobhlW3Q0Pu5BZPQwucWTQDkslAdbOJsLnMwKZM40+A4BIGL4xoqKf1ecP9achbLZuJa8eydU4+hkPcNCQx/df8sVl84uf0Pfna2i1VleUqynWkpxd+r378A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(36756003)(6512007)(110136005)(66946007)(316002)(38100700002)(41300700001)(66556008)(66476007)(478600001)(53546011)(26005)(6506007)(2616005)(6486002)(7416002)(6666004)(2906002)(83380400001)(31686004)(31696002)(8936002)(5660300002)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEFDWkdORWE3WVVjcU9kKzZKL3JqdlpQSGJxRURUaWljNXdXZVQva2FDUm5J?=
 =?utf-8?B?dzYxU1pDWFovdFdGeHU2SXRjb0dLYklObjVMT3h3cjF6QUlUYzVwdEh0M25G?=
 =?utf-8?B?V3NCQjlhQVJmNS94aGlPL0F2REw3VFViYmpJZldYeVM4Z09paEcyRUNxYVRT?=
 =?utf-8?B?b3hnRk5JMDhRS0kveDZFbitIT1M3cmpyUHFISGJNK3lIVVVOTFl1Z2FMUVo1?=
 =?utf-8?B?SytYL0pmaWJ2ZHdiZW9GTjJkNzNTL05JSXdSRko0aFloNWpnMzA0Wi9pNG1m?=
 =?utf-8?B?UFJlalhxMXFEemhBYk1JKzRyMGwweHNJUm1VVXJNeHpHclltR1FnbStIc0lE?=
 =?utf-8?B?TVBnaloyOVJWRmFWS3dJT3ArM0dWeXVvWkVCaG9FZWdvNnZDM2cvbVdrNjFE?=
 =?utf-8?B?QlJqeTBhRCs4c0dIYzlRTGZzNFk2ckNjMG9GbnI3d2pRa3d0RCtmWG00UUs1?=
 =?utf-8?B?bTRWcjBwOG53V2E4ajliWi9neUQ5V2hRQzY5MWV5c3ZadXhpM1FLY0RjMUtO?=
 =?utf-8?B?R1hyQ0ZCSHFPMzhmVEEwbTRzV0V1M3RrTU5MUkQxM1Y5QzJoaUg1Y3RlZ0RO?=
 =?utf-8?B?Mmd1akVlQ2pnZ3RwQzJoZW9uemFRNUlTNW1PTG4wWlR4K1VLTHd0a3E2MExv?=
 =?utf-8?B?dHp5Q2tSNFVRMkF0TmpDaVVhWmpWK29LQlZKa2htVXppcW5tNkt2bEZLaDlC?=
 =?utf-8?B?U3pKbi9GcjN0dWhPejR3KzJLK3hnMmZzbCtZajhuVCs0bGpveVF3N2RNNkVQ?=
 =?utf-8?B?ekxIc0lacW1FT2VPblZ0dDF1UGFHS1llV1U4VFFiTkEvUGlHbGFGVkFEdi9F?=
 =?utf-8?B?TEpqa0ZFaUptMTZEaXI4SUJEbWFVcFVJS3ROemgvZXpaTUtwaGdRY0llZ29S?=
 =?utf-8?B?UU5QVTVsaC9ZeHRDL0QzTWRsVnhJeGJKS011aUNremU2d2N6OW9rK3U2d1NH?=
 =?utf-8?B?UHVkRjFIWDRjblVtMXFpYVpCTnZvcWFZRzhhUFB3ck9WeWhQVk5aeXV3N3Vu?=
 =?utf-8?B?WUpEbjdTa2IvamFTZnBqbzRxSnEyb3pMOVkvZFBFa1BsbWp4bzJIQXhHelNJ?=
 =?utf-8?B?bCtUeTd1NXQwbjczTjc0L3Uza0RHSXlUL0dYSVhORGl5WHdsR3VidEVXRTZY?=
 =?utf-8?B?NEJ6WHA1eVUvUkxydVR4UWNvalVhMW9UbjRRdEdZL2pRbXoxeW53SFo3dk1N?=
 =?utf-8?B?QnI3RkNzalRoVnU0cXk5aDMwNFNZZTEzb2VYRy80V3JtMDhHYWNsL0xoazZj?=
 =?utf-8?B?WlFTeW5KRlhUZElvSDZBcHR5VzJXUzF3dEUwZEdwQ0R5R0NWMytuTDRqUXpG?=
 =?utf-8?B?OEhyd1o5OVVJS0tlRWZWeFd6eVZVWnlzeGZVaUQvMGM2ZjBua1pYb1VZZC9P?=
 =?utf-8?B?NDRhNm9jbmMyZUNFcXIzOXlKTHpvOENMaEMzbjRWV1dnM20rTC9qbTQ2V2J5?=
 =?utf-8?B?dnFRQWxlNGFKUFFlRDMwb3hlR1ZFYXJNdG5nMERhRkE1OW5oaWU4MnFzRkJv?=
 =?utf-8?B?UmdZdjhPRi9FaXBlc1RQUXNmR3lJcTB2NWV6TG0yTkIzYkZMQjJyM3RoZWY1?=
 =?utf-8?B?bDRFcy9LdVZWYTcvanZZVSswTHVEdHhZWWY1OFRPcHBSMjRWVlNEWTNlc0hK?=
 =?utf-8?B?ZGxwc0JTNWMzVWJ1cGU3QkswQkRUOHdFYXpOWkZzb0xaRWVyS0VkaEZFZ0kv?=
 =?utf-8?B?NVE2Rm5MYk91VWlXcC9KcWNKMDBVaWRxVE50eXlxOTJoRDEwVS9md0pxUzZJ?=
 =?utf-8?B?QUpxekVGbEptMlNnQU9wdDJVYTFXSWQreVRCeUw3UEFPSHFSdER6QW85WTRR?=
 =?utf-8?B?NFEvTlZZckNweU4xNWtxS2ZydDlrYXQvK1NUMVpQVVMwR2w2WWEvdzRobnFL?=
 =?utf-8?B?dVJ5ZnFvS2MwTC9HWXZ5S28xQjRnR1JtMDJXRStaYUxUS3RUZVRJeGVPSllV?=
 =?utf-8?B?bmxsSXU2dklyM1MvU3RFRjNveG9CSVUzMGs1cXo1R2xFMGtWRE1VTm5rQUx1?=
 =?utf-8?B?ekhnajdEbHVFdVRDYlFEN2htUFRBTjJTSHozM3M5Q3AxWHdrTnVTeGlpc3pX?=
 =?utf-8?B?NnhVU09ZNmRXOW1WQmVacmpWRVNiRFFHQzluOGZzYVg5RUJGYWJya2FMUTZY?=
 =?utf-8?Q?/uBwjVaG6uwVZNHBM+vZ2cG7Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea993d47-6015-4f6e-dd54-08dbbfa9ea0b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 22:34:30.8700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80hx7Fdfjjbjbd72GnWaeBjEh+xgbsRTNhTguPLjgpvFdlIpnJeSjLwjRMEpkhrH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

How about this subject line?

x86/resctrl: Enable non-contiguous CBMs on Intel CAT

On 9/22/2023 3:48 AM, Maciej Wieczor-Retman wrote:
> The setting for non-contiguous 1s support in Intel CAT is

> hardcoded to false. On these systems, writing non-contiguous
> 1s into the schemata file will fail before resctrl passes
> the value to the hardware.
>
> In Intel CAT CPUID.0x10.1:ECX[3] and CPUID.0x10.2:ECX[3] stopped
> being reserved and now carry information about non-contiguous 1s
> value support for L3 and L2 cache respectively. The CAT
> capacity bitmask (CBM) supports a non-contiguous 1s value if
> the bit is set.
>
> Replace the hardcoded non-contiguous support value with
> the support learned from the hardware. Add hardcoded non-contiguous
> support value to Haswell probe since it can't make use of CPUID for
> Cache allocation.
>
> Originally-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v2:
> - Rewrite part of a comment concerning Haswell. (Reinette)
>
>   arch/x86/kernel/cpu/resctrl/core.c        |  9 ++++++---
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 10 ++++++----
>   arch/x86/kernel/cpu/resctrl/internal.h    |  9 +++++++++
>   3 files changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 030d3b409768..c783a873147c 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -152,6 +152,7 @@ static inline void cache_alloc_hsw_probe(void)
>   	r->cache.cbm_len = 20;
>   	r->cache.shareable_bits = 0xc0000;
>   	r->cache.min_cbm_bits = 2;
> +	r->cache.arch_has_sparse_bitmaps = false;

Is this change required?

This is always set to false in rdt_init_res_defs_intel().

>   	r->alloc_capable = true;
>   
>   	rdt_alloc_capable = true;
> @@ -267,15 +268,18 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
>   {
>   	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>   	union cpuid_0x10_1_eax eax;
> +	union cpuid_0x10_x_ecx ecx;
>   	union cpuid_0x10_x_edx edx;
> -	u32 ebx, ecx;
> +	u32 ebx;
>   
> -	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx, &edx.full);
> +	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx.full, &edx.full);
>   	hw_res->num_closid = edx.split.cos_max + 1;
>   	r->cache.cbm_len = eax.split.cbm_len + 1;
>   	r->default_ctrl = BIT_MASK(eax.split.cbm_len + 1) - 1;
>   	r->cache.shareable_bits = ebx & r->default_ctrl;
>   	r->data_width = (r->cache.cbm_len + 3) / 4;
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> +		r->cache.arch_has_sparse_bitmaps = ecx.split.noncont;
>   	r->alloc_capable = true;
>   }
>   
> @@ -872,7 +876,6 @@ static __init void rdt_init_res_defs_intel(void)
>   
>   		if (r->rid == RDT_RESOURCE_L3 ||
>   		    r->rid == RDT_RESOURCE_L2) {
> -			r->cache.arch_has_sparse_bitmaps = false;

Why do you have to remove this one here?   This seems like a right place 
to initialize.

Thanks

Babu


>   			r->cache.arch_has_per_cpu_cfg = false;
>   			r->cache.min_cbm_bits = 1;
>   		} else if (r->rid == RDT_RESOURCE_MBA) {
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index b44c487727d4..f076f12cf8e8 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -87,10 +87,12 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
>   
>   /*
>    * Check whether a cache bit mask is valid.
> - * For Intel the SDM says:
> - *	Please note that all (and only) contiguous '1' combinations
> - *	are allowed (e.g. FFFFH, 0FF0H, 003CH, etc.).
> - * Additionally Haswell requires at least two bits set.
> + * On Intel CPUs, non-contiguous 1s value support is indicated by CPUID:
> + *   - CPUID.0x10.1:ECX[3]: L3 non-contiguous 1s value supported if 1
> + *   - CPUID.0x10.2:ECX[3]: L2 non-contiguous 1s value supported if 1
> + *
> + * Haswell does not support a non-contiguous 1s value and additionally
> + * requires at least two bits set.
>    * AMD allows non-contiguous bitmasks.
>    */
>   static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 85ceaf9a31ac..c47ef2f13e8e 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -492,6 +492,15 @@ union cpuid_0x10_3_eax {
>   	unsigned int full;
>   };
>   
> +/* CPUID.(EAX=10H, ECX=ResID).ECX */
> +union cpuid_0x10_x_ecx {
> +	struct {
> +		unsigned int reserved:3;
> +		unsigned int noncont:1;
> +	} split;
> +	unsigned int full;
> +};
> +
>   /* CPUID.(EAX=10H, ECX=ResID).EDX */
>   union cpuid_0x10_x_edx {
>   	struct {
