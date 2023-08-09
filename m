Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D599775674
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjHIJb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjHIJb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:31:28 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CF51FD7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 02:31:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjAJL33ifBll+4vx42cqS2jJwH0wWtkft5p4vmiQvqHzepSviFm60qQPeiAzUnoMpALQQrJKNEeNj9MmAGc9M4nOvCQ58Qg7LQICKnK0vKPz6FnEckaJd6zj3V+7wpNDoHMbhxWAIOOC+ifvVD1M675ALwagTJsO7Caeky9UxlFI5BZ1XBZRBhgEoMOEwNojlnqtEjPHfqdP2nF+lMoQ7PumFC3wP+azSs+NWfUIz+UMRSbEB5Xu+il/CYo60eybZ9Cm0cfA1SzLyV8TC0/Z542EydOpd88PDOBcdXFMSrcQy4G8doUHFbHMZhxOkcpcz07WhdSoushaGFG1j8wSOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJ7oQNXonMw30eGHqaC2INb8XNISsp59XXbIM4DBlAA=;
 b=nG/vpJP9Esg/qbwzSIhoF4dEIBwlV0vvVFAj7slLN7rIFrthFtE8r7VNCth4DA+qEA/LRRungYsUfxNzSMIt5SinuYBQKjp5+JG7TjUeaaoPLjVSpvD+oR1BXiBI7Bx/CcB/6hYAz+rKcQkh+KDVK+MVpuqHd3qNQaeqSENSIpWXpBQUaWSMMRkzZimInn6w4DKYgvkOlRaeVd6Uwjt1AXOtJSaJdBlWUSktI0m5f7HehQybD5b7gh9X26+lki3F3hAcZpHpqCICqczCMrdV7j/FjrXLgL8rJNB6vtBNSXDt4nRYxvdQdRCBbvEFLSD4Tj+jF87J6UlAhb9eDLnByQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJ7oQNXonMw30eGHqaC2INb8XNISsp59XXbIM4DBlAA=;
 b=SfRi5nQPJpp6t+EfCdiEK7V74DFx3mrIvS1QnWVAKUfnnvi5pz6j3hAzPdvAWCfWLPj10usew9/c0+GvORsWWyiK/ekPh7gC5f9rWV6/upC3DpU42s2aG+ZNIUo8RHVBFw8Jz2N+CwmgVf336/ael6Gk9mOvSrRY4SEEo+ftYVu9D+qDNuBlTKQFzuVNL24e4I8TlMiZBx7V4vgmMZ1NYa3Pvid1qEbjFDE0kynwCeTZ23RdJgWjUAe+r7ShvDmDI3x10qx5xHlW/gVQfIKuigcS3XHzSASDv9Tyx+vELpyAAUnxwb2BW0bW57QF5uGXF4JDcRMkQKR+upTN0SNs5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AM8PR04MB7249.eurprd04.prod.outlook.com (2603:10a6:20b:1d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 09:31:24 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 09:31:24 +0000
Message-ID: <527ecc24-dc4e-2a64-5a66-d7d9cbdd3bb1@suse.com>
Date:   Wed, 9 Aug 2023 12:31:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC][PATCH 01/17] x86/alternative: Unconditional custom return
 thunk
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org
References: <20230809071218.000335006@infradead.org>
 <20230809072200.450404700@infradead.org>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20230809072200.450404700@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0051.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::28) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AM8PR04MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc9fe44-bd31-4c7e-0b44-08db98bb6647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cnA2mYagFwoqMDbUaB8NdKZMPn3FCnefvjD65GceAGx86z2ohvumZPkEC+jEFtvok64o7Lgok+YJHteGQVh5Q4TdFAw9Lk0pmxDwM4fuqW0w8Ijg4yT1GLEJO9zcDP5dQ00r2ShYHxtJ9X0Zw36vRkMlm+hMZLR4F+nkSdWwumk/0blpiru0BhdNR6DCc5NFn2Q5fJwWEbWgnhcc+Bza6nV8eC8B6owVVFYB33HNolwy6jJa5VETJV2ttW+TXw6vSbg6zzZfruiYMh9TBHTR0N2nLrVoOG1YAmumBTEsG4Pum+uK8GbqVp4TB1wGF+nGXn9b/V6LUcBf/G9khbZNlYzdhnC/j/pKoi8PfXPcPoTn7/zLsjOHXfLn61z6p3tA8BmKLJP0djmJhu/8/MmusuSv8J8VLv03cIc3FS+Kv8Z8x/PgCqwtwx2iQJafwsSk1aiX4ARvuFXpjkAn/EsThwj9W4qxutDsTzTDIsZn9aOhY7/z4O7kCrYFF1RTvdLweMujVdtw2iFWHUZdsacsNu2p+1sapKKLZp57P7cK3i9NnwjbM3xrP957HfGKBuMN4EI56Le0xJ3ZXy1BLTUCCdcwzvbHf67i+FJdbYihD9WSHKpCC3bNGeJ643mQ6/Om+41nlWwj/JbbjubN97Liqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(376002)(136003)(396003)(186006)(451199021)(1800799006)(6506007)(26005)(31686004)(36756003)(6512007)(6666004)(86362001)(31696002)(6486002)(478600001)(2616005)(83380400001)(41300700001)(66946007)(66476007)(66556008)(316002)(4326008)(5660300002)(8936002)(38100700002)(8676002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDh6amEvSVdnc05jWlhHUjFwUFUyTitaOENRQ044dktFRWRLa0xBdnpFWjU1?=
 =?utf-8?B?MUNuanFVT2tZdmJodmU2MkNrZzgxR1ovaERvSEFZWGVUQkxBK04xMndUVFpZ?=
 =?utf-8?B?dHgxbGovUE1UOGYwS2I0bS85TzlBNnRXWnZSUG9pZ3d5bGp5ZnUxVndsdTZN?=
 =?utf-8?B?QTBvb2ZzUmMvZzRUK3VhQ2FHSkZmajJlV3VSQW1RLy9mYldJQ2V3YWJUaytS?=
 =?utf-8?B?bGlLU29OTzFpSVFvcUVPL29LeGFNMFhMVzlua1l5ZzhsWWh5Z3pqZHpFOEpp?=
 =?utf-8?B?UTRHTG8rMVVzZ2JyNUNuMTVQc3lwSzZKWWdGa21EdDNRQnRZTVZMeGZTWDZP?=
 =?utf-8?B?RHcwdFB5UGZWdUN3UDdVQTlyalJqNnZIcjl6UGhxRWRmUXV1TDdVZ0JKdzVx?=
 =?utf-8?B?ckJvUjNYUHNZejNCcmYxeWsyVkhrOEs1V2Z1ekFMeS9SMmR0RXhFa2ZBbElj?=
 =?utf-8?B?aDNNZWViTG9Wb1NwT09NcXhSb3dhUTN1OXN4SlVxd2hoTDFTUFdkVXN4TDI1?=
 =?utf-8?B?RkkvRC8wNU5iZXZWRVZmb0FFd080NXVxSVVoUitsYkJWS1ArMGhwaDZOMjJs?=
 =?utf-8?B?dDhxcnV3MDhVSmJxWXU1bjZtL2sxVWdUZGpkbjA1YVZoZXdROGRYT1V2RUht?=
 =?utf-8?B?Sm1ySkVPQ0U1S2JabVlpeitiRHI3cWhjRVM2ZGZiejZqbFpDM0dGSVZ5SFh0?=
 =?utf-8?B?ajE3MVJ2UlhrdHYyQzlpbVVKRnZqMHJCSkU3VTdlVTBKQkludSszb0tvNWhY?=
 =?utf-8?B?VitQc0ZmR1FxTTd4aldaOHNQUEoxWS9GVFNMNlVnT0dvOUFYbjdJUUlZK0ty?=
 =?utf-8?B?MWFjTHdEZXpXQmNYd2l5K0I3cGhDVCt6Vi9jMHY1enJLeERHTytpTUJHcDd0?=
 =?utf-8?B?b2dFdTNVSDRQQXFPQlNXZkVudzV1bit3NTNBOWdqakJDdDdQUVNScnpwOU5D?=
 =?utf-8?B?aW1EdHZyKys4NmFtT3lKT0RRdUw2S1JSSEtlWUlBYzg2VCt2K2hzUVM3WThL?=
 =?utf-8?B?Nm5xK3VYVVBEb29lQkRzaENSbkZGRFE2ZUR1aVZHekU1RzZKS1FNZjNGUGYy?=
 =?utf-8?B?L0VuNDNiWHZxbCtrS3lVK254bEttR3RaR1c3ekVENHZ5eUR1MVpsTWlxTi9B?=
 =?utf-8?B?NHcwT2JyU0FMRkwycFQ1T3I4blV0TGhoRzhHSXFKd1B5S3hucEZiRWM1QnQw?=
 =?utf-8?B?Lzc1V2ZxcjdpL0dMOTRGWjVOZ0VJOWdkSWFJMkcvZEg1eEFqMTBEeHJISUJH?=
 =?utf-8?B?dE9oZGNRNU11YVBxRCtwK0VrQWtJVFlaQUJTWDZWTHhTSzRoejVIVGViYmUr?=
 =?utf-8?B?QTM2ckE5SVU2bHVMWTB6b2NPMDhWR3RiUkZ2cGs4NXc5MUVtL243cVFudk9O?=
 =?utf-8?B?WUVwWmtKN1lNSUZJTDV5VkE0bXplVGlsWkRYN0lHalFaTlNOdDZhLzljVmEv?=
 =?utf-8?B?Mk91bm1QZFloV04yL2tUYVhpNTdmWFhEd252b2YyeEk4S3U4MmxnRUZoWjZ5?=
 =?utf-8?B?SHFiYVhIakd0ZTZrUkJvMytKK0czd2tjemlpN3BpR1VPVUkwWFNSbkpqLzNa?=
 =?utf-8?B?OUZWT0JPaFR4aWpoRE9MdUFlcGloUVJCUDd2NS9YY2xpQXBiK25EVXZTVERR?=
 =?utf-8?B?bnBwR05vSjRzeHRZeGJveUNLTUlMaUQ3MG5mcWJwMElkc3hOOElzVkNzdk9k?=
 =?utf-8?B?dFQ3Y3NDZ2ZJYmE3TFF2Smpyb1hIbEUrV2N4QmJMaU5KQ1R0emZJNHhYenF4?=
 =?utf-8?B?ZmFiOHY4MGVsdmx5RXkyaVJpUFBOSlZYWmJIQ0FmTis2M3JhOWNkblJGTDBW?=
 =?utf-8?B?RnBzaFVuWkY0L0orZFJkNFg4dlFEVW15eWhPVkJGZmx2Z1Fqc2ZYM3VjTHQx?=
 =?utf-8?B?dTdJREdTdGdhckcxYzdETmdSdDc3UjFSck5KbUR1dHBWUTAzSVdwTEhVSTVI?=
 =?utf-8?B?OXFielFTVFNvenJ6Mm44bzJ0OElwK1FPMHc5KzhvbDAvbGNVdlBMbTBtcmZQ?=
 =?utf-8?B?SVQ5M0pRVGNzY1llbUVNSGl0Rmh1NzJxR29tdVdnZHFwTXFuYVdZTDFkTzhV?=
 =?utf-8?B?QnF3L1UrN25wcU9SMFg5SGozY1dIMnU1S3FXVElUbmUwRnFxZTY4OGFtUlVy?=
 =?utf-8?Q?wO/Rnufx0bvuHrgZqKqtAajyr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc9fe44-bd31-4c7e-0b44-08db98bb6647
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 09:31:24.7773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VoG9Pe8FqQDyddD4k4+fp0Gnrx7vQp2UtusnsZNS4aPQouJARc33ZEcZ+llucxLVzMp/c0WaYawWMEb960Tmdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7249
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.08.23 г. 10:12 ч., Peter Zijlstra wrote:
> There is infrastructure to rewrite return thunks to point to any
> random thunk one desires, unwrap that from CALL_THUNKS, which up to
> now was the sole user of that.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   arch/x86/include/asm/nospec-branch.h |    4 ----
>   arch/x86/kernel/alternative.c        |    2 --
>   2 files changed, 6 deletions(-)
> 
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -347,11 +347,7 @@ extern void srso_untrain_ret(void);
>   extern void srso_untrain_ret_alias(void);
>   extern void entry_ibpb(void);
>   
> -#ifdef CONFIG_CALL_THUNKS
>   extern void (*x86_return_thunk)(void);
> -#else
> -#define x86_return_thunk	(&__x86_return_thunk)
> -#endif
>   
>   #ifdef CONFIG_CALL_DEPTH_TRACKING
>   extern void __x86_return_skl(void);
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -698,9 +698,7 @@ void __init_or_module noinline apply_ret
>   
>   #ifdef CONFIG_RETHUNK
>   
> -#ifdef CONFIG_CALL_THUNKS
>   void (*x86_return_thunk)(void) __ro_after_init = &__x86_return_thunk;
> -#endif
>   
>   /*
>    * Rewrite the compiler generated return thunk tail-calls.
> 
> 


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
