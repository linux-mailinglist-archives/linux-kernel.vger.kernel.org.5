Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8CB7FF7B6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346033AbjK3RFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjK3RFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:05:14 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE307D7D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:05:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfZhqFHcdslflnGJuzAiSOiqavEer80BDjhb1vzQ0tVBD+OySRvhHwZgRnQ0QX5A+LTAGNuOdDr4ID6sNS4H4wGrIpNZS+rz+/AByCFqN92Gnn4ZhfmG2G8diUtOVNzacYnifVEKMvtWy0LxaBP1yCYJl00i9hvkXGny5i8hpSM2pDpiMEiuxUOTTgGfvGSO5lDi5ye9RldICVct8vVOWokpKii69EM481zzYb+WMdaWNLO56aK9XyTvNzBM2sd+OCGym4fBhtdi8IUbfeQptVQ10RuyuwZmYeXHHsvjHgof6Wqrx56szCibF7ky9CH1FUAi63kRYw8wZlT4Bl+Msg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShZNjl+8nzsOAYH+L2jB2u0DLGXj3N4FA8cmLl+4HU8=;
 b=PclpMvW31nfpno+YNlqRb7jWmjJgvXEvT0CT0t+x7PbDCr6kpIwlHZ5wyQf8pXELKV2isQNCMVvPhoJ5E7Zsn67WERlqgstG/AS3mBqf269x4jSjchOxD15bd7wXji+405qAsKGPCqwIffQeY/JC/22RRMCnO9qHWJ31VhjjoEDk5bJUcKwGbSUQsPtheO8QpYmqGgsKbQFVxy7p3n9gGQoBM9TmXnjf94fRzCUQ+gfT5oR0zdVWscdTTEqgFX5/B3VyeJCl7va0rIMH3514y2NpfemgQL2GBUOes2ZTalHpBGR9vPgX5U8pDjb36kdYeid4Kg/vvRvuF8QY6+AEeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShZNjl+8nzsOAYH+L2jB2u0DLGXj3N4FA8cmLl+4HU8=;
 b=4tKq7Sc8pRPKv6F0obn+rdZY672DV++eyGGQgALhfuGMzekdFDWEApehv00Jo4trxjsmvKyEx+oTR6q4w9h49nDQ9OlcpYIa/Jr41ybao5bccn4V765ysUjLnyGBGJzZOVJ+TjHxFwVjkMucAj09XuOzlXl3vyu/DALojPFKVxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 17:05:16 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43%6]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 17:05:16 +0000
Message-ID: <dc3835e3-0731-4230-bbb9-336bbe3d042b@amd.com>
Date:   Thu, 30 Nov 2023 11:05:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] x86/CPU/AMD: Add ZenX generations flags
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20231120104152.13740-1-bp@alien8.de>
 <20231120104152.13740-2-bp@alien8.de>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 1NhFSLKvfA==
In-Reply-To: <20231120104152.13740-2-bp@alien8.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0042.namprd05.prod.outlook.com
 (2603:10b6:803:41::19) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: a71642c9-6935-42f5-b71f-08dbf1c68677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tGiamGkHpDpj1OVqFxkjxC8K6ZJ6mPGZlykGJqXNJ4TxSXVDTS/piKi6iH3zJy6cmCSBGIlrXpX2vJ93Yw7r0yryiyme31FtfUq8Tw/ZW4Df7bM4aYellk+L+iJI+WEzfuRoH/562IP7N5E5jS2qsbuWOcNEllK/jctc++/kP6FFnxkO415Vv1IRTCIrp6cOtesw1A052ck62kNSI+ywftx4ob8GS6k3DNWvnhxPgatAcNc/jUCN1xTtwZ1MTbpRU6yKfFbBiYnKF4039ZVORu7jI2vb/tbgLeJJCR5hbgJaZj3LVO2yTaKrcDxQxySFDYJVJqROsAA2xKEQ6A0p+B07QpUFf8bmxvAlAsGNxis8VZASkgAp49Nad5QPczVbBvKsMu7dcIYJKeBFy6LZhvHB+cY/GSJD679UEokyIdpWRrIjJm/gl/Tt+oN3RrQq89BkmSlX/ZR4DM00QsoNQhcI3pyRqEaPU1Lc4b+LUNPbqqjTq64ofJbt0IgdMdYSOQZTEjpotwOnU0V736m6SxB0+TCpeKwqmlOWcIxIYhXAAzlPxL46KnrnKVOx4LWC3iUe2GfPYHeJxh+jjJ043rxl0M7koVpAaSkDziNzoK2xNP48LqmfCqqGKvK+qVqOlLWGyOcArsvkEfaFhOz/Qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(396003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6512007)(26005)(6506007)(83380400001)(2616005)(53546011)(4326008)(8676002)(8936002)(41300700001)(5660300002)(2906002)(6486002)(110136005)(478600001)(66556008)(316002)(66476007)(66946007)(31696002)(86362001)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3hJbVRYMFQzNWs3OC9FdUdjWlh0RU1IVklOcE5pcFZxYnozMWpqWVJaNVo5?=
 =?utf-8?B?a29Udm9CTTByQ3Rtc3JyS0krQXJwSVN3UE1qblZIbm4xYklObVZuS0c3QnJu?=
 =?utf-8?B?TDRTT3crY0krMTR6UDBOaHVzWEhEcUxaYko2VjBxNDhMaXdZOXJOcGgxU0xZ?=
 =?utf-8?B?OEEybjluSlpwcTZWZ055TFN0Rjc0dEdPRVFaLzJ2L1lxK0NiNkpoVWE0b0pL?=
 =?utf-8?B?Z1V3RkxRZEQyM0VWU2xVUUJKbng3VmlDZ3lZOHV6RytJWDBVdzFYUzZMWVBz?=
 =?utf-8?B?ZnhBYkg3QTN5eVBLOEwrbDF0YUdZMmV4czUwTkZTbmpXdXoyOGszd2EyUTBV?=
 =?utf-8?B?dUhmNU1vbWJLeWhnOG4rVytoSGZMWER1RGxnNTRTbTFpenZzSWNMNU5sQ05k?=
 =?utf-8?B?VjNaM3ZBZzhpMTFHRDZqZExWNlowWklZcWttNTVad3R6R2Q1UDA2TEM1eVkw?=
 =?utf-8?B?V1VNNEt6VjlLcVpheUZiekhoQURUYUVHWDJVZENncWdwY0wvK0JjbFNzcDhH?=
 =?utf-8?B?THZmQXdRdVJycjhxUG5nelI4L3N4bnhXKzdvOWdtSkt5aUVkT3Q0TDdWcmh3?=
 =?utf-8?B?ZGVROE5reEM4RGdHbnUwWlFQaWNyblJIYXRIeU1XYy92MExwUjQ4aC9qRHd5?=
 =?utf-8?B?czVrUXg0NEN3dFMyWWYyWkRRY0JZNkQ5YVJrRGlhS2NpRlBvdmhJK2ZBNVI5?=
 =?utf-8?B?RkNCM2s2cU9EMWVENzJVWFlCV0VhcXF4amJNY1JUTmMzVzM1V0FPLzNTYlZK?=
 =?utf-8?B?Qk55d3NDK2ZMeWxtQnlPNE1VdGhPS05MWFl0aURuNnlXWjF1NlJ4NjVMcDNp?=
 =?utf-8?B?Y0lGaHZRZ3FIQlI5d01HOXY5MjExSW8wZ0hvV0Zjald3RFh0b3NQZUNJallC?=
 =?utf-8?B?SFhXSVZvaHMrNDVTMy9XNXFnUU1xcG1XcE5qby9nWEtTeWxLNC9DZ09pakpT?=
 =?utf-8?B?Zi84dHc5WGlHcDNhWGlnN3lyUVd3b3ZwQS9DMFR3ZHkraDB5czhnQjZMUU8v?=
 =?utf-8?B?dFRveGpMVEpYQzRia285bENxalBabU9PaVpCeHc2aUdiWERDMjZBaWFlRGNV?=
 =?utf-8?B?UEcwVzBoeWJCSE1oelBFTDhqdEtFbFJ1OXZGRVpPd1ZPMFJFbXhJQXY5N3N3?=
 =?utf-8?B?SkU0S2tCcXJpempheXFmcEZPcHpQTGZ5TE0wdkF5SkwrU3I5dzhURy9VMW1P?=
 =?utf-8?B?MzRkVGI2d005RzJrMmZ5UHV0ZkFDRlNUaDIxeWRPbEZaMFNkZXFEalRKWnFo?=
 =?utf-8?B?bStzMmVGYlBYZm9YVkZ4NTZXZW9qNEFDcllyU2F3MUV1K21KT0M2Z21lQVEy?=
 =?utf-8?B?K3NvMVNVSVMxYUphdEJzcEM5YUg2UVVwVHZteU1aTE5CT3dqbXpJMjFxQXNB?=
 =?utf-8?B?S0dkWmkwTVp1RFJFRG5CQU8zWjZjT0xoRlc4cE1xSE04RWFyRDludTRvL2s1?=
 =?utf-8?B?bmtLc082SnVjMGZJSVEvUWllYythWlhIUlFmNlp3SG1nZDd0bWhpeXlESUtV?=
 =?utf-8?B?b05ock4wQ3FsQzR2MHhHTklDYWswZXUyNWYzVzk3TFB6bzg5V0dLWGgvN2Jv?=
 =?utf-8?B?eFNObVNROWlXN3Y1MCtYYkY2dTFKd2xUMDJjdDJsK202UmhDcDdSYmpLLzdk?=
 =?utf-8?B?NXlDYXhtSE1nYmVIZmlZVXd3UmxBeit3eHo2b2xMUFMxdmxwQzhHaWREQzIv?=
 =?utf-8?B?R0N4S3ErYVpLQm5GSUgxV3VscTdBVDQ4RUZmbHlBQ1ZVdzk4eTkxdFFrclkx?=
 =?utf-8?B?YVVxVGtXZE5XK09VNW1MS2o2SGYyWE42UzBweUFkZ0p0MUJhdzJ1TElsckg1?=
 =?utf-8?B?TGdBVm15bzRiTEdMQk5QeTF3ZVFFU2xkL0hMdlBBOWw2R1BjU1hxeW5Cdkkv?=
 =?utf-8?B?UEExVTVPT05neWtlU25pY0o3WUx6ZzNPSkJaT2VCbVR6NEhuQTV2eVlwM1lh?=
 =?utf-8?B?dUpnY25NN1JHVFRxaVNLcTdnTTFzdERLemltb2ZlR3dEMUpWcGdpdFBGRk9a?=
 =?utf-8?B?T1B6SmhsUU9Oby9TdjFxMXo5d0JpdVBpckNuRngwNER1L3J5bEhKM1FnTlpY?=
 =?utf-8?B?UlY2cElBbWpMN1BqNVNkME9uNmZpRjdiZ0xHWXB1cUgyUDYveGF2djFSUjF2?=
 =?utf-8?Q?upxnSEzYRk9H5tVFsq4MyDAUa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71642c9-6935-42f5-b71f-08dbf1c68677
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 17:05:16.6091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jhbPW0vnOQw/+vDd7/RKtIavcDVC54lwWyl+M0qQRxUDD4Tk5vaM7GYprvD0dywsawZtkUza6pcncjCf+SXUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/23 04:41, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Add X86_FEATURE flags for each Zen generation. They should be used from
> now on instead of checking f/m/s.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>   arch/x86/include/asm/cpufeatures.h |  6 ++-
>   arch/x86/kernel/cpu/amd.c          | 70 +++++++++++++++++++++++++++++-
>   2 files changed, 72 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 4af140cf5719..6f6cf49e9891 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -218,7 +218,7 @@
>   #define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Speculation */
>   #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
>   #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
> -#define X86_FEATURE_ZEN			(7*32+28) /* "" CPU based on Zen microarchitecture */
> +#define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU based on Zen microarchitecture */
>   #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
>   #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
>   #define X86_FEATURE_MSR_IA32_FEAT_CTL	( 7*32+31) /* "" MSR IA32_FEAT_CTL configured */
> @@ -308,10 +308,12 @@
>   #define X86_FEATURE_SMBA		(11*32+21) /* "" Slow Memory Bandwidth Allocation */
>   #define X86_FEATURE_BMEC		(11*32+22) /* "" Bandwidth Monitoring Event Configuration */
>   #define X86_FEATURE_USER_SHSTK		(11*32+23) /* Shadow stack support for user mode applications */
> -
>   #define X86_FEATURE_SRSO		(11*32+24) /* "" AMD BTB untrain RETs */
>   #define X86_FEATURE_SRSO_ALIAS		(11*32+25) /* "" AMD BTB untrain RETs through aliasing */
>   #define X86_FEATURE_IBPB_ON_VMEXIT	(11*32+26) /* "" Issue an IBPB only on VMEXIT */
> +#define X86_FEATURE_ZEN2		(11*32+27) /* "" CPU based on Zen2 microarchitecture */
> +#define X86_FEATURE_ZEN3		(11*32+28) /* "" CPU based on Zen3 microarchitecture */
> +#define X86_FEATURE_ZEN4		(11*32+29) /* "" CPU based on Zen4 microarchitecture */
>   
>   /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
>   #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index a7eab05e5f29..fa6ba63ca7e2 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -616,6 +616,49 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
>   	}
>   
>   	resctrl_cpu_detect(c);
> +
> +	/* Figure out Zen generations: */
> +	switch (c->x86) {
> +	case 0x17: {
> +		switch (c->x86_model) {
> +		case 0x00 ... 0x2f:
> +		case 0x50 ... 0x5f:
> +			setup_force_cpu_cap(X86_FEATURE_ZEN);
> +			break;
> +		case 0x30 ... 0x4f:
> +		case 0x60 ... 0x7f:
> +		case 0x90 ... 0x91:
> +		case 0xa0 ... 0xaf:
> +			setup_force_cpu_cap(X86_FEATURE_ZEN2);
> +			break;
> +		default:
> +			goto warn;

Previously just being family 17h or 19h would get X86_FEATURE_ZEN set. 
With this, if the model check doesn't match, you won't get any 
X86_FEATURE_ZEN* set. Should you do set X86_FEATURE_ZEN here, e.g. lowest 
common denominator for the family?

> +		}
> +		break;
> +	}
> +	case 0x19: {
> +		switch (c->x86_model) {
> +		case 0x00 ... 0x0f:
> +		case 0x20 ... 0x5f:
> +			setup_force_cpu_cap(X86_FEATURE_ZEN3);
> +			break;
> +		case 0x10 ... 0x1f:
> +		case 0x60 ... 0xaf:
> +			setup_force_cpu_cap(X86_FEATURE_ZEN4);
> +			break;
> +		default:

Ditto here to set X86_FEATURE_ZEN3?

Thanks,
Tom

> +			goto warn;
> +		}
> +		break;
> +	}
> +	default:
> +		break;
> +	}
> +
> +	return;
> +
> +warn:
> +	WARN_ONCE(1, "Family 0x%x, model: 0x%x??\n", c->x86, c->x86_model);
>   }
>   
>   static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
> @@ -974,8 +1017,6 @@ void init_spectral_chicken(struct cpuinfo_x86 *c)
>   
>   static void init_amd_zn(struct cpuinfo_x86 *c)
>   {
> -	set_cpu_cap(c, X86_FEATURE_ZEN);
> -
>   #ifdef CONFIG_NUMA
>   	node_reclaim_distance = 32;
>   #endif
> @@ -997,6 +1038,22 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
>   	}
>   }
>   
> +static void init_amd_zen(struct cpuinfo_x86 *c)
> +{
> +}
> +
> +static void init_amd_zen2(struct cpuinfo_x86 *c)
> +{
> +}
> +
> +static void init_amd_zen3(struct cpuinfo_x86 *c)
> +{
> +}
> +
> +static void init_amd_zen4(struct cpuinfo_x86 *c)
> +{
> +}
> +
>   static bool cpu_has_zenbleed_microcode(void)
>   {
>   	u32 good_rev = 0;
> @@ -1077,6 +1134,15 @@ static void init_amd(struct cpuinfo_x86 *c)
>   	case 0x19: init_amd_zn(c); break;
>   	}
>   
> +	if (boot_cpu_has(X86_FEATURE_ZEN))
> +		init_amd_zen(c);
> +	else if (boot_cpu_has(X86_FEATURE_ZEN2))
> +		init_amd_zen2(c);
> +	else if (boot_cpu_has(X86_FEATURE_ZEN3))
> +		init_amd_zen3(c);
> +	else if (boot_cpu_has(X86_FEATURE_ZEN4))
> +		init_amd_zen4(c);
> +
>   	/*
>   	 * Enable workaround for FXSAVE leak on CPUs
>   	 * without a XSaveErPtr feature
