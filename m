Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3686D782340
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 07:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjHUFmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 01:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjHUFmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 01:42:17 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2044.outbound.protection.outlook.com [40.107.6.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA498A3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 22:42:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJRhDIGzahWlkMopGhCL+ylo+809/4WF1yyMvU5DZsB78GhfK/lAalgncqaOqWIlDY3ldGiZWZlGIlo/Frt5bktWLT+wXzRHcp1OsTD9bjrE9ddVu82rRFjUxmTEhd1z+mZHmgdwGvwWtipqUzpGhcLcID09DQNJqOKCSWv1VzTDFpePD32FGwvfw3LfOU8vtcO2Q8SudyIC7vKPar/+ae7BPyYgHAwKYdj/wuX2WNJvWNP9z5sALf2Ra4cRDOfl1D/n87W0+ZSEPT6k8/V9XVV4Un4Kz5GEcBPROCqoKmB+UDKIzDH8aO9sCHaNiIBvfKrfgb+cz3G6PApUYWEfKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRFj+vQpri6tK5JAJSMapDkhQGvk6yqtKvKztYRvUHU=;
 b=kQPsqGUN7As8F0bi//DTyTECsR94yVzbAA+uZWZdNHZ2dhKZh0BXLT1CSbYMDyUe5vz0EE9+XBFEJ9oGyT0m2AHmpiqqHRG1PCato3WLybNJpQjPJ+cTgFh8StmXYFom8i0CZ6GYdyH7PZZ1M7MDx+AAww1lqeLHK9lK35RgHZdUgt3Ra7eYhxbiwmTknCXQOP3qkRGyW880gVkJkUSCvyzpgliUNPy6Kzt/MzWZ8b39+us3BckPWiQSuegnGkX8aV1p8HvOMFTaKQkq/MiKvWijH0dJ8m3C2Mvx6xyBOJqJm0LHIrzBLtuSw6cTJ5U5HsVutgKud8taT931EN+icA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRFj+vQpri6tK5JAJSMapDkhQGvk6yqtKvKztYRvUHU=;
 b=d7eyjxQJbq0Pgv/PZzQ4r9x5INlgABoAMt5ufgYZVXLKd4Sr9uWg/C9ux+7lDimbxhmZShjSbGE2H/AOWezxDuIax9cJ7En0OxUkvKTCz2eYUerB0n02ve/NuN7AVVPvNilcr4SSvLwuiw0b5oPzvTZgQsCT8KIMnVqyR/W8DGlZmCZubgAaHKK5jGR61DH8qMcAFdXa3wsTvInSmCnKwrnHY10UNAX69c23WneYfbQ5bQJCvXOcDKSyeenO1So/suMMtfZ7kc7PgOSxE65mLWm28A733Sj3wpW+cM9XDV8ZogaHPjKy+MSgqgzZbymsc12JhH/YXgir1zpAGKEx7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by DU2PR04MB8712.eurprd04.prod.outlook.com (2603:10a6:10:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 05:42:13 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 05:42:13 +0000
Message-ID: <35c7815e-4212-2c14-1515-bd10e9e649db@suse.com>
Date:   Mon, 21 Aug 2023 08:42:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/22] x86/srso: Set CPUID feature bits independently of
 bug or mitigation status
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <caf4d0a1233ccc1c33f4ff8d3fe302c9289f4bea.1692580085.git.jpoimboe@kernel.org>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <caf4d0a1233ccc1c33f4ff8d3fe302c9289f4bea.1692580085.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0268.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::35) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|DU2PR04MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7a2ce2-c22f-41aa-07ba-08dba2095e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7FFEUxMbGvREf0vLIAcU7B278vDkXkAaTsR0ehM4CpRnnboM+LivL4iHFUVDGchYZ4AKGxBb34lJF9NCDbT3+8PGY5HzBQt79FZtxrdNwBVGZRDf7Ag4vULZlXGyipRY5+yVJ8aPEeFcXHthPS6KXZCBC3Ig8TdpzkzcnSTpLJ6cLJfTSXcSBK0l9BHbmMQceUE849k/5TJzYrtfRoEZEJ2S6ydNTi+1Tn1LA82c1h6fVUOjG2CrWPQiqXuLR8EMQPKYmZKmRTClgKl/EPGeJBxfGNKBUwyfl44UuxC0WukwF9zMCw/RRM4teJF/ZsYlYSGI5oLnS0aNdOyMjHDIod0tEgcpou+BSNvIXA2S17dI9WWcwZANXA6MyLMmlQoKb1j1lngHPlnfiIvtPT2SE7qHxhfMayOm2ySX4LUGvOBQV0vNvKU456i1GxSCxmI66O4jXQlN7QGv7qAAGOLmJmpvsyY/oc8MPBZuejL74ZhtseTkmHTFqPTVLJqkV2pDUpXGbxBLYrXXCBBd8Ap/lvTkzGpoL22L55VIFdCQHkkdM80dZqKBAxJMl60nX5Ig9Sf0ViN/2WQ5EWuXS5QZk2uZaWanW7QPLvPi0JpNIewPxYMP9QIB2Zo5m+gO2a6BqJK8hgTlKi6ZLx6nYJ/OkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39850400004)(346002)(366004)(186009)(1800799009)(451199024)(54906003)(66476007)(66556008)(66946007)(316002)(6512007)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(478600001)(6666004)(38100700002)(6506007)(6486002)(2906002)(7416002)(83380400001)(86362001)(31686004)(31696002)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWJDNGRwMmthNzlCUStydHF0MkE4Q0NBdUZWZ3lMd2M5TlNOTG5nN1N2QTBE?=
 =?utf-8?B?eUhGV2FyTkNjVFdwRm5ya1lOTEFma2dzckJnWVJWQWluV25JamtOM0ovTHFh?=
 =?utf-8?B?Y3l1Y1d0c2o0ZnNMZ2lEUVRkajJzN2FMbkxwWnRGK3lLTGpwNFVBd2hEQ1Aw?=
 =?utf-8?B?UktXVUU4SGFoOERGMGpUVW5qd2dxcjBlaVArVDJZZ05VNmlualhUK1A3OXVM?=
 =?utf-8?B?T1R4UG5sVVFhU1M1YUxxQzcwdkNaWEF3d2s2cFNiTXVsRlVEQXFGS3U4TTFJ?=
 =?utf-8?B?SnJTV0lSRzQ1dXMvNjlhMm10Y2V4QWo1OHlmL2pNUDlTeTJvaW1xZTdxWEhk?=
 =?utf-8?B?aytzRUNNV1lEQ3dTOG0ybWo2UlJBazErUVdOazVBQlRJUHc1ZTdaSnJleE9P?=
 =?utf-8?B?YmFQMDZWU2ZCdy9ibjRsc1M4dVRFNVlFVlR3YTF1YnpvbUw1MkdGRWdTanc1?=
 =?utf-8?B?TkUxSDVsZHh3ZzQ5SHY1V1BxTS8wQW9nMk56WHorYkoyd0d5YmtWUTczUG15?=
 =?utf-8?B?bGtnajNzTnA0Vm80dGthRUtTM0lHVjZiWFd3eUlUcFVVSHpiM1puc0xYMUh4?=
 =?utf-8?B?MWk1SUdTcGgzbis4eTNnU005bHBxUG1XeWxpV2pUZ1FUQnZoMDJ5ekFuMlV6?=
 =?utf-8?B?eU9JcUZRQWxJZ1dqWVZKYkl4cmN5MTlBVW5oWTJBQ1J5OGdYQS9KNFVHQzdl?=
 =?utf-8?B?RHJHMmhHYXBEWHBtQllEUHBWOW1ZKzZZZ1FBeTQ2Y0ZTMGNyQkloWFZja09z?=
 =?utf-8?B?MjhmeHg3cEVCd0dJaXlQZDVmazdDaXJvNFUwakw2MTdUbkRuNkxVVVRhOHZZ?=
 =?utf-8?B?UGJObSs3K0hnNHNtWDVjWitRcUdlSHFzMlFjakwrMFFmVXJFT29uSGtvQmcz?=
 =?utf-8?B?Y0tQazdHZHk2cnpOWXdiT0dwbUdsK1ZQS25oV3lNU0J1V0FQaDM5TWc1NmNI?=
 =?utf-8?B?TmQvVE5OVTRNbnJuSkdVQ1FRQis0cFpkWE1NRUVKRDdLQlMra004UjRuWk5T?=
 =?utf-8?B?MFY4S3kvZE81UE5PUTEzRjN1RkdnUzk4SnhoRUQybVBEVDhIVHlIb1UxdVJy?=
 =?utf-8?B?dDRjZHdRSzAvMGZOYm4yVW15Y1JKc1VrQzhOdEdReDhBa3dvdGJoaFVjSUV1?=
 =?utf-8?B?UUE2MTZ6NjR5QVpjWTNrOUVOUFl5Qk1YUG04U25pZC95Z1VLbGpIbWlEZVJm?=
 =?utf-8?B?SjNhNXIzZDB3RzQ0bUpUOXZJZmZhYkNhc1g1UHJiM2JYZVJTWlQxZEVQS3Vo?=
 =?utf-8?B?RE5aV1FZNk1ueWYwUGdWUlpiR0JMNXlxTHhUaE9veXVDQVJOaXoxdFBLRWNJ?=
 =?utf-8?B?dmtBMHhVTVV5azRvZDJ0aWhxVG5NL1VvUHM4bU1sSzNMSDM1TkpZL2R2RVBw?=
 =?utf-8?B?ZGd2bk0rQnNaNXFpbmtFeFRQdVZTZkhrVXdpdWFMVTR0dElYa1FRRmdQUy9G?=
 =?utf-8?B?aUU2T2V5TmFQVGpibFdTMUdtL09pOWhWOFZWUi9qVHkwN25TRUhNd1VrNzF1?=
 =?utf-8?B?c1FyZDMyV3NEd3hvak9ISXZxeWxWS3h5c0JCeTFIQlkvOEUwdVIzcXBtUHdr?=
 =?utf-8?B?bVlmSFAzTXZiREZNalQrajFPd2tUMFV4cnJJcDltTFBsNHdmalJDYW91VjhU?=
 =?utf-8?B?YnlLR1RpREZ5aHZqVGhjbzhsS1crb2NJa1R2OVZKUlQvRGU4dis5RmVwZmlu?=
 =?utf-8?B?YU9qY3Q2alFyTHZUMm1ENEY2bDBoZVhUSEI5VkNiaU51aHI4bm1rYnJ5Y2No?=
 =?utf-8?B?MU1iUlBZUTNCODM3MVhwNUtRQ3p4dzBUblkzSzZHcnZaVzROSGhRTkkvVWJC?=
 =?utf-8?B?UkZTZ1NkSkE0SmJCWURMakFxcWRaK3BaN0FOSFovM2NrRWl5NEpnNmZGcHly?=
 =?utf-8?B?RkNvYlRYL0dIT3Z2SmtlNzZhMEczOGhYaThFQy9CN05QVERvSHR1ME9iUVJM?=
 =?utf-8?B?MnlaVmFlT1F5V1lrYUwveUVJYTI2bFV6U2lhOWltd3JSN3JkeGRVUElMenBL?=
 =?utf-8?B?NFRmNlgxSll5Rm50czU3cnVXZE5IbG5mdVVabXpYOXgycHNwMWRoU2NWME92?=
 =?utf-8?B?d2lJekhZTUE1ZVRacW9lS3NlY2lsNkZoMEs4KytBb2FSVjN1cmRtYkhhcFdm?=
 =?utf-8?Q?zym9sAp+jxeUhOMIv+NeUG1uW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7a2ce2-c22f-41aa-07ba-08dba2095e91
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 05:42:12.9299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QohzByVkx/JcAH0bEicAZCS2mO4UV6802mnQs+F/VBTmHvhjRFeK58v7LklAARWEuuuPakGwfFfCLIllaRzbrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8712
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.08.23 г. 4:18 ч., Josh Poimboeuf wrote:
> Booting with mitigations=off incorrectly prevents the
> X86_FEATURE_{IBPB_BRTYPE,SBPB} CPUID bits from getting set.
> 
> Also, future CPUs without X86_BUG_SRSO might still have IBPB with branch
> type prediction flushing, in which case SBPB should be used instead of
> IBPB.  The current code doesn't allow for that.
> 
> Also, cpu_has_ibpb_brtype_microcode() has some surprising side effects
> and the setting of these feature bits really doesn't belong in the
> mitigation code anyway.  Move it to earlier.
> 
> Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

LGTM and it's a lot more clear when IBPB_TYPE can actually be set.

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>


> ---
>   arch/x86/include/asm/processor.h |  2 --
>   arch/x86/kernel/cpu/amd.c        | 28 +++++++++-------------------
>   arch/x86/kernel/cpu/bugs.c       | 13 +------------
>   3 files changed, 10 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index fd750247ca89..9e26294e415c 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -676,12 +676,10 @@ extern u16 get_llc_id(unsigned int cpu);
>   #ifdef CONFIG_CPU_SUP_AMD
>   extern u32 amd_get_nodes_per_socket(void);
>   extern u32 amd_get_highest_perf(void);
> -extern bool cpu_has_ibpb_brtype_microcode(void);
>   extern void amd_clear_divider(void);
>   #else
>   static inline u32 amd_get_nodes_per_socket(void)	{ return 0; }
>   static inline u32 amd_get_highest_perf(void)		{ return 0; }
> -static inline bool cpu_has_ibpb_brtype_microcode(void)	{ return false; }
>   static inline void amd_clear_divider(void)		{ }
>   #endif
>   
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 7eca6a8abbb1..b08af929135d 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -766,6 +766,15 @@ static void early_init_amd(struct cpuinfo_x86 *c)
>   
>   	if (cpu_has(c, X86_FEATURE_TOPOEXT))
>   		smp_num_siblings = ((cpuid_ebx(0x8000001e) >> 8) & 0xff) + 1;
> +
> +	if (!cpu_has(c, X86_FEATURE_IBPB_BRTYPE)) {

The only way this check can be true is if this kernel is running as a 
guest and KVM has synthesized this flag already, right?

> +		if (c->x86 == 0x17 && boot_cpu_has(X86_FEATURE_AMD_IBPB))
> +			setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
> +		else if (c->x86 >= 0x19 && !wrmsrl_safe(MSR_IA32_PRED_CMD, PRED_CMD_SBPB)) {
> +			setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
> +			setup_force_cpu_cap(X86_FEATURE_SBPB);
> +		}
> +	}
>   }
>   
>   static void init_amd_k8(struct cpuinfo_x86 *c)

<snip>
