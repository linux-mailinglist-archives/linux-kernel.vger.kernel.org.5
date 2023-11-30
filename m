Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F217FF435
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346431AbjK3QAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346463AbjK3QAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:00:14 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2041.outbound.protection.outlook.com [40.107.7.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E09D90
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:00:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UebiB1w0t+iS4KmnCemAGmWztkpZOSWyy8jf2yf09UFvHwrphYixGaVeet9G+I12miRzIhF3KL7aIKYvWneGsttu+HqxHo4+NKvWTjBqzQMaqKkeqmfaVt7taOBGdMzQQ7Ox3/W2cEIVdRkMEejYPX06jw7QFvZT2XNCmm+DYS+gvUdcsZEQ/Dhp2JQfqzCtcxz8Z0oLP6YrTQueAU/11csGHaEJBamvPViA1mYhLxgUXx8cQ5cljxY2EVPe/mpRxmhYxiFs7Ql6mBzdfs4tqCfBiyR28j/MF3ZAFSt3T/DLkT0/44f3/NfO4YEdqyrto69crxj9CJNNjw/B5t/8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/aQi3HMSghPNdqzDfkeTjij54fYacivhcx/Uj66rjw=;
 b=FqaYgKtTtIo1oMloW++Vpy2INAzAQ3DGgRaoC1ejSJc9gDvTNoW07+VLkK6EUUJp8942ZhzcRUBTmYUEsf6MHhGvOEkr52o7rQ4tBI+KPLdoWjvRgyx0xRvid2w4DbCvYLDtalBQZ/OyXezJRuTsCs+sqryJ1S51yGMlnLkQ412wKEHSmtCWAQJuaR8tepUi5WF9PWaLUa0/px4IlkZxTeh/FNaSLDjyzWHlLAJkwqO8kWEyxf9LPbwGQgOkCLXL1WknaU+0fXJpsAa5iL3G1mGWU46csW3I1cNocvz3QNUpgenxvBbQi0GAuG1QhXp3FvUjkvJ1QiEhgRQPySnnRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/aQi3HMSghPNdqzDfkeTjij54fYacivhcx/Uj66rjw=;
 b=yQiRH+wnTnhluSTEvjRLEvtfd87UNMXUCxcDhm2Q0vCO+wnUr4FyquTCxfuadkuzEpsvEZtudTSFeIXuegL+UVt8VBFPNj29K0Gm1X5gLcK4GUH9QsewtbXAc3VB1qktgEj76dzM6a0m8AOR82j8+JV5NstbK/l3vStPMBVTh3NADE5ehzT3SjypWPn72ltn9WN+E970cMVpDVfMd0SLkPHPX8xrlwx/ugsxeQRJrTrcYlLkkLrBEvUxlidx484KaHAqLM2rKpEYzobVc80qX2CWL7dcOTH8tbEYKBV3tplgVYGo7v4i1KjbbocRIOZBixQ/lHjw9otO07nuJKWPmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by DB9PR04MB9819.eurprd04.prod.outlook.com (2603:10a6:10:4c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 16:00:17 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::e665:a062:c68b:dd17]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::e665:a062:c68b:dd17%3]) with mapi id 15.20.7068.008; Thu, 30 Nov 2023
 16:00:17 +0000
Message-ID: <e485409f-150d-4138-a030-c19041f0fc8f@suse.com>
Date:   Thu, 30 Nov 2023 18:00:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/ia32: State that IA32 emulation is disabled
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20231130155213.1407-1-bp@alien8.de>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20231130155213.1407-1-bp@alien8.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0271.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::38) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|DB9PR04MB9819:EE_
X-MS-Office365-Filtering-Correlation-Id: 593118f6-09a5-4167-cea7-08dbf1bd724a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: siw/F+SBupMhCfygvExvkcAppL7n/xdduAXSVjgXbX/Hfg17J+WtDXHSyHJqrT12ExXj9GKff05xS5kjO89aIFjKh+0+k9QV1t1cIUwUtU4sW2KSfSUGG9pCi+lrYGO2f2eMCgUiyx4Gm027XNG+GOxIcfUuo1yoO7td/TBVmVvtH+e2IJjeoCOEv/OCm9usw1+7F68clA4/VUPOBuhk+DMDbWDoQThVDnqf09/Ojtoi4u6yB14hmsrPpaTDWKlFaYcBvOZGWURQl/FY3XvqOlwphtScUJkiXanPR4bbFKkDLxedWJ8quuKt1LhvZ8H901CG5LNsEQNIx2wztI+OjYPw6GM8kY7Wu8g0bZjCbDeBF96KW1sg6bsTjcTkVhShvoBNtKCsli/kWoA9+1gjQX+22ra3Tymq49GLOReA0djzA1DaFoAYL6XGKu1Eggx3RJ7E6lAbKm8yCJER9c9ruM776HJW46Uw+tVlQF3wG6AZ9C/+CPCN5KccTQF3JHhHV/oEJy/eSMtaBvJLMJdKDuaxUK/1hoLw0rb8UJnYxnNl85lNpDSR3SbKe1t5WzgkJoJIzdhpY/acMSBwAu6If4lz8G2wu+WD+rYdehJmPDqEfzZ/Wln38FF6HZ/d0TPWqW+WBJxg5sDlHnlnF4udNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(2616005)(6512007)(478600001)(36756003)(38100700002)(31696002)(86362001)(5660300002)(2906002)(66556008)(66476007)(6506007)(316002)(8676002)(66946007)(6486002)(8936002)(4326008)(83380400001)(110136005)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG5MQlUvMk03MlN3ZE5xUkxnTmQ4SVl2VmsxMy9KQlcwY0pyeFhxV3V1Q0gy?=
 =?utf-8?B?ZUxmWjBWWXpkeUFsc1RMVW9INWJYUW5HVDdEekRuUjZodW1nSFppMUJKL0Yz?=
 =?utf-8?B?ZW9OTnV2cTkrZlFVUXh4NXNjQXg1TUZlNjBURjF4bVI0MnFHOHd2TjFwalJX?=
 =?utf-8?B?WTQyWDFBbVdiQ08vaU9DQnRYaEhSSVNoVzUvQUVBamdWUDF4NUxacE1HT1lP?=
 =?utf-8?B?ZlZ0QTJCZVlPd1NDdEVReFB5YTJKS0dSdU85ZmN6bURWZWEvWWNHTTFpaS9C?=
 =?utf-8?B?WDE2cWpoZFlMQXVIcVE5V3dRODFYTTRIK2NCcTRQS2NIS2dvTHc3WmthSmM2?=
 =?utf-8?B?ZFhUQWVsNHd3RktNSzEvVTViVU9aYlFaOUtWWFZDN3pYY0Njd21ISVNKVklk?=
 =?utf-8?B?Ky9EMzZzWlUvREhwVXMwMHZESTVKSDd1TU5oQ1BKTGVBdS8wbVA1d1E5VG5B?=
 =?utf-8?B?RDltVmNzZHpsTU9uUXVzZmIyZlVSdXVGVGpzU0xUVlVldzE4NHkyMExzRVRh?=
 =?utf-8?B?Yk95SkEwMHNUYzBSY3JCU1hQTXhCTmcyZ2dsV0I2SjRkVSt6L1VOTEFsSzRO?=
 =?utf-8?B?V0t3a3hoMUM0K3BWN3JpRDcyMnNRVFRZSyt4TkVMSnhMWnV3VE9rVGNJMi84?=
 =?utf-8?B?a2RKdFp0QVVBcEw3RDVXbURLMmFPdUI3ZHhZeStORjhPUDBMSEthVFVETWZR?=
 =?utf-8?B?T000Q3Joa0JGYzgrWWkzb2U1N2llSlkxWG9seURraFpOaUphcGgrTXdCd1hW?=
 =?utf-8?B?ZG8rUU9FZllIR2x4ZnlxTHE5dHlZT3RNZU1hQXMwM1IwM0Q3Y3cwR1pzVlpD?=
 =?utf-8?B?dWdsTVVxU21OVHJvZzN4T1ZETk4rSTdPckpGcUFTN2U4QWdsdzNvZ1BOSURu?=
 =?utf-8?B?M3NuTittbGVhNFo4STRLZHVQdHQzT2FHRXpRV1FiVitnRjJmWUZYZ2pVQmRZ?=
 =?utf-8?B?d0VvOFZud3F6T0JZejhnQ1JnZXNDVkkwbysxa2Q5UEU4cTl3UzBKRDVHcnVn?=
 =?utf-8?B?eThVUE5iYm5WcHdOZlh4T1NVbHZyU3VZZXFVaTJ0dE5pYnE5dE5YbnUydEt4?=
 =?utf-8?B?ekhXdGhqVTdwWUEraXNnV0diWTZ6TnFkcHIrMStmRm1nNWxPR2I3U2lnczlQ?=
 =?utf-8?B?VEY3K2s1cXpsTVhRdVJLWTVnNFBTWnh0SFRxNnYrdzBTU3UzTnlJaHI5Nlhw?=
 =?utf-8?B?ZHJub2hFKys4aUJJQkVtL1JRMVNWd3JCdlRhbkErYzBlcHZUOFAwNUNuUktP?=
 =?utf-8?B?TlZVckhRYUh0QXFUSHFxeFFlYTVPcmg3YXVqTTV6SzhBNW5RV3lheUhuYnJo?=
 =?utf-8?B?Ym9MckxrUlhkUFNwcnkyUjdTbHpLSVZSeTNOTXNMNDNZd2VXbFZPSStLYStL?=
 =?utf-8?B?dVlSREtRcTV5TlRrQzZ1ZGtCOU8xcFN5YjlnM0pYWlhOMVR3dk9aN2d1eEZS?=
 =?utf-8?B?YytEcEppL2hkREFyU2Uyakh6ZHRXZ05OY2xYVURHZUFZNytyQUw3SzZWTkI1?=
 =?utf-8?B?TU0yc05sSExEaHJUUU52KzY2K1Z4ZWdxUGdzSHBzMGVFNElGU2g1UWRCNkhY?=
 =?utf-8?B?Q01PMTdoanA0c2kxWVNPL24zekxOSWVKUVNUUGsrb3RvbC95WHA4OHhMNGZG?=
 =?utf-8?B?TnoycVdOa1NuNGlvYU4xTGJncGtDVTY3VE9rNzNNN042V1orVjJKbnlUNEdx?=
 =?utf-8?B?U2VBZnR1YTkwR2RvSm5NTXhpbnBOcU0ySkFjejJGN24rbnNDSXNCY2RRRC9n?=
 =?utf-8?B?WHBqTjVHZVpWL2g5cVFFUXB3YUhNa2hpb21vQ1R2QUhMS01QNUVDRzBvM3gx?=
 =?utf-8?B?amhNMzBjTW05RUxielU4cW81b1RTWTZaUWlCUzNRbGppVjV1KzdkMmtFL0Js?=
 =?utf-8?B?UWhUOFZ6SnBRR1VaYXk5MEE5cXFMNEQ4M25BY2tIQzd5akhtNVRLOE5OM0VE?=
 =?utf-8?B?VnJLOW9TOTNsdUpEdWV0bTUrWnlYdlFWL01FQ2F0WitVVjdETFplRUxGMW9R?=
 =?utf-8?B?dDdoQzZBanVENHRRSjd6LzNkWlZoMDBrdlFtbTc3UU1wTWFiMlpEeHBMTG4v?=
 =?utf-8?B?NU5oOEV6bFNNM3BhbDV3TzgxSGxlZ2J5dW1wMFRneHgyTE5FeVFXV1NTZ2dl?=
 =?utf-8?B?Wlh3L1VqWHV0SzVRd1U1dkFBbTkxbyt4dXFBVHc4WEQ2Syt2aFlxUTh6ckdE?=
 =?utf-8?Q?o6FfWUHUbpyDyG31qy+4i6S7fd9bFEvTpe5CsOPqFrWY?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593118f6-09a5-4167-cea7-08dbf1bd724a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 16:00:17.2584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpbVT+vgJPdymPDb1fzpLqSaK4BJK53lEPW7MhOOly0A2RmWvmRmiLNkshhmLv9Lbix0KCO43bpJFOyh5+toJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9819
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.11.23 г. 17:52 ч., Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Issue a short message once, on the first try to load a 32-bit process to
> save people time when wondering why it won't load and says:
> 
>    -bash: ./strsep32: cannot execute binary file: Exec format error
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: Nikolay Borisov <nik.borisov@suse.com>
> ---
>   arch/x86/include/asm/elf.h  | 2 +-
>   arch/x86/include/asm/ia32.h | 9 ++++++++-
>   2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> index a0234dfd1031..1e16bd5ac781 100644
> --- a/arch/x86/include/asm/elf.h
> +++ b/arch/x86/include/asm/elf.h
> @@ -150,7 +150,7 @@ do {						\
>   	((x)->e_machine == EM_X86_64)
>   
>   #define compat_elf_check_arch(x)					\
> -	((elf_check_arch_ia32(x) && ia32_enabled()) ||			\
> +	((elf_check_arch_ia32(x) && ia32_enabled_verbose()) ||		\
>   	 (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine == EM_X86_64))
>   
>   static inline void elf_common_init(struct thread_struct *t,
> diff --git a/arch/x86/include/asm/ia32.h b/arch/x86/include/asm/ia32.h
> index 5a2ae24b1204..43e02b52ad19 100644
> --- a/arch/x86/include/asm/ia32.h
> +++ b/arch/x86/include/asm/ia32.h
> @@ -2,7 +2,6 @@
>   #ifndef _ASM_X86_IA32_H
>   #define _ASM_X86_IA32_H
>   
> -
>   #ifdef CONFIG_IA32_EMULATION
>   
>   #include <linux/compat.h>
> @@ -84,4 +83,12 @@ static inline bool ia32_enabled(void)
>   
>   #endif
>   
> +static inline bool ia32_enabled_verbose(void)
> +{
> +#ifdef CONFIG_IA32_EMULATION

Hang on, this is wrong, it should be CONFIG_IA32_EMULATION_DEFAULT_DISABLED
> +	pr_notice_once("32-bit emulation disabled. You can reenable with ia32_emulation=on\n");
> +#endif
> +	return ia32_enabled();
> +}
> +
>   #endif /* _ASM_X86_IA32_H */
