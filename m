Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275D77FF455
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjK3QEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjK3QES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:04:18 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2076.outbound.protection.outlook.com [40.107.249.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB04090
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:04:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSscDOS5ux8AXZUtY57LG4G0dbQdv8Uq7/QPV6U6yaArpZW3NFFDJnQ7vF4vQCtJDlkni6bRn/sukgkiUOh+ggUMjS6hVU4nquSaHCxPThr3TLXIj3mtmqyhobaxMYs/lJ9S7fZSh6PNtZhaCsImOem5kAts6mEh5mCPtz/HA/ZkHlTekW2KHV0DR5QvlB3QTRfYZ1GhIEavsbGtFsBpZfDy6oL/QVRn+7Hy+WB/XVbTWHGfXB/nFgDox0b4l1B+UfZdNbCBrU9kXbj1iDYLttiO10YIebxdZY6A+bq9Vqj+SGWoUPCSlFppjPp/T2YfgsSy6TKYzigPpF8baR7j+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSOQje/71a44Glx47Wm9Vul4H8McqSKCyypSU1e3O3w=;
 b=duzkdFj1PeKIEMQV24PWtrgDDB2vIPppOvN3uIyVoH1pDRQMPM9rCGiDbCs2cjrGY2BiAldotGNFLHSNSu75mzjaclLRhzx/TQGL99zK7ZTTUbg4I/BtWhn8NcGMYzGBzXUVfKrTBThsqTzG4bmuJCt4vHURHu8mt/DB7QyZRe3b6HJDxjSP1oC5tQxlMFfiWgHgTSWyg8YZf+GDK/Qe03hXuB3m6tLEHxMUhISlijfCqf8vl/GmCCAMaV6P70uCjbR5s2r8UHs+GSQ4odslJNk4lFqJU7CedGm9fzwTW9rewDHgKUIShxFrCtNIoCjjJHEtARwpnF99A5cemq2k2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSOQje/71a44Glx47Wm9Vul4H8McqSKCyypSU1e3O3w=;
 b=cV9M0fZO95y4oSRdQtt+VFxlZTcl/kAn8lL2YhTb1zOiEV0knNcTZ49fkWB9xM6BaO2dbU2qw44AYcb4olW37KHpzZcLSGsDUQN8aE/kjVlvKT6JauoOTP47hpGJVe2fgI5YuwGlSkAhmoR5YQzziSFeQCT382KHppTCsOXdoeL6O6x/v852KOfC6rlli4hnGZTPB13sY8fsk33zymWC98DjadFjB41DAeP99EAu9AWYzfXC6zdc1lAtsR0J/8aChBArq0R/4GmT+yvOXjFP6WisXySNphX0nOVj9ribGRPVyKTWqrjDpYMcj/DA2g2dlq/JgGdC/Xy43TtHa8mqzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by PA4PR04MB7712.eurprd04.prod.outlook.com (2603:10a6:102:ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 16:04:21 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::e665:a062:c68b:dd17]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::e665:a062:c68b:dd17%3]) with mapi id 15.20.7068.008; Thu, 30 Nov 2023
 16:04:21 +0000
Message-ID: <6adeb081-33d9-47f5-b812-e867561e0ded@suse.com>
Date:   Thu, 30 Nov 2023 18:04:20 +0200
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
X-ClientProxiedBy: VI1PR07CA0255.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::22) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|PA4PR04MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf7cbfd-2703-406e-c30b-08dbf1be03f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGmzP+KXzPfAVjfZit2eIwWqpFg8QhKNP8xthgsZDhS4rln/qwu5b7yeds9FJnoG4+Iw9cNicEzhICVM8XUzKD4l1ahaPYA0gxU5cvkMWjljca1YGqn59l6tYbP6SDRLU8qA87onYVUQyCkTFxc7lH3qk14P4MtJDofeWGhhS053Y/5Fdwq5+GHvpPh8ywzyHJedXXD4amnk3RqdZcqdlSvElepBQjIlFgU3GxrNKRQZOORmm26rRqZWEm6S2Eu89QK7AA1cPF9OUAACCXJF5F9LvEWwZo7FjEqz0gsm2Uy9SNTrDWgoniSB86hrZYSz5i0UY/AxN3yNcgxzdngIlQ1BlPGq0eqgPYXsRuWHCiY0MBHiZ92N+fzReM1S3i3hSzauSKcIwEzQ3GdWKadP28QpI2Lhy4tScXQMZ62DvhwUP2LF7St9wn9MSDQKA7reaQ2WMVm2d5K0Uwrvx4SUUC7XzME4+14P3eiAUfbEDuI80LTZFlHsdmLZCs9CL/dZf+4y2C91PkpqxLqT+/S6/YXcnzFWMWlvpk/cNCIG5g+tEnnHVSkKTsl+zpxvbwmwmhCn35hvwTasvoTg7p0SeiIdFs5y//IPfsNp9J1y9dsRHEjJhy+JV5c19OY3TBByKenHru7AYXXYHMYvTMMjeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(396003)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(2616005)(31686004)(2906002)(86362001)(36756003)(6512007)(6506007)(38100700002)(5660300002)(41300700001)(110136005)(478600001)(8676002)(6486002)(316002)(66946007)(66556008)(4326008)(66476007)(31696002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXoyWkJXZU44akdHSjJGTmNhUEk2RUFJMG9WTWg4ZGdnNkFUUVExVUdxc2pi?=
 =?utf-8?B?YlZ4T3U2bnZnNjczQy9RYnluNTMzZnpUc3BsQkRVOFNsM0M5c1ZCNXFTL0ZT?=
 =?utf-8?B?VkI2SHhYZXY3MEhwV3A5bXhaaS80dnIvUjBOcFFlVUdKVS93WmNNckl1dmVF?=
 =?utf-8?B?dk01ci9pbnVucnh4ZmQvV051UnBCWlFwelRTb2FkOWh5N0dMYUE0b3d6d2Jl?=
 =?utf-8?B?dnk2QmxMR2lWSUZ6V01BYWNtOGdRRDBTMjlkdy84cjhSbWhRM09ULzNNMk9H?=
 =?utf-8?B?UDNyT2IxdXVWU1lubjlyT29STldwWFkyY0hoSEtwbjZuK1pvandSZjV2bXdN?=
 =?utf-8?B?QXdTbE9jUHN4REVlSjZRdU1HZ2xreDBRTFRMUWwvejU0RWlGTTJPeVI5Um1s?=
 =?utf-8?B?Y1NXbk5qK2lXUjdCT21vV1Z1U3lIQ0Nva1ZYaFVNQ3BUeXZVMFlxUFVlMlhW?=
 =?utf-8?B?NmZvWEZBMTcrRE92c1V1bXJ1QTVSU1pkazRONGFKWjJHZnFaZS9oUUQrNENi?=
 =?utf-8?B?VWJnRXNQU0pZK0NmUEU2V2c3Z0xkYmpnaVNUK2RXQWpJL0JrcGRtMWJYcHhn?=
 =?utf-8?B?TUpRMzc1clBQTndqU1BQMWw0ZkhpZXhnaWZ4Q2paMWtuT2ZBZ1lQd214YVhH?=
 =?utf-8?B?UUVLMUpKbGxoRk04OGFvbDdwTUhuUEEreDd4S0ZySTJrY1QwbFlqWll2M1NX?=
 =?utf-8?B?MEtQME5IUXhLem5FanZlc3VOcmpycGJQM3U2aHNNVWJSRFJ1bUNFOElqK1dO?=
 =?utf-8?B?TkZXT1h2eVlZQ0ZoTHVYVWx5Qk1CSE5BbVVQSWp3d0FsUTFMcm12bGlVQ09U?=
 =?utf-8?B?VkNsakRnN2h3SC9RWW1tZXJkUE1LNWdPOUZlVVFSdk5MRVc2d09FY1RLOVlK?=
 =?utf-8?B?d2FCYlB0alp2MmlxYWIyQVNHVEVZWkpEeTVGbkdRRVRHSXY0NHJmZG02bEF1?=
 =?utf-8?B?MEMyK0ZIRUFqNmwveHRuLzdJa0RXQWp2QXNlWnpYZnIrUTVpYWxvSm5CWXpP?=
 =?utf-8?B?WThYTE4vL0sxT2phb3NqWGZDK0ZlY2h3K29NS09SR2lzY0c5dVFtc05lS1h0?=
 =?utf-8?B?VWRHRTNsYUhhblFlZGJrVGdGcmZNTnk5M3JuMDViSkhVd0p3QzhCMm9uR2Rk?=
 =?utf-8?B?TnM3eWVwZVhNUW9ncm9VcjRtdEZEVW5PUCs0Zms3b3l4bHRLK05sMjQyZkxD?=
 =?utf-8?B?dmU0UUF6TkxVQ1pSelJoeThGbnl0dXpTZldZbktJY0NFYW1uNGZHMldLbCto?=
 =?utf-8?B?c0p4NVAzemJMaGJpRTlnTFRxQ2l1ekRPQmhDRlo3TFpEb3M2Y1l5Rk9mSDQw?=
 =?utf-8?B?MDBwZTVIcyttZFpZK0w2YU5mRWlpOHR3UWhadXBMWVlweWxiNW94NW1ld3ZR?=
 =?utf-8?B?enhzSG1CNmZvbzFyQ2VBL0JxbGFJNEpwLzVmZVRrMkY0TTZUbnZUK0tkTy9R?=
 =?utf-8?B?bmt2UjJtU3A5VnljdW9xRC9FUGVudGJtWWJER1pvQytzaWJhWUErdGYrdnlv?=
 =?utf-8?B?V0dnRHhIWldqZ1duSlp0VitsczNGNTRlbHZHeDJncDFsV2FESGxUd2d4Q0VV?=
 =?utf-8?B?OXgwQzdGQkF6K0ttbXhvWDlVWHJZYnlyWlFNNVEwc2ZOZTV4ODlReG0xS0gw?=
 =?utf-8?B?azVKY0ljNHZRM2k3THljeXNsamJ4TTBtNDY2bW52cHloNEk1TytMZVdHUHpW?=
 =?utf-8?B?QWxDOEtseG93Zml2TVgzSVBCejdPYVU1WkhwYjRwSzlQV0VqQTAyL3dGb1Qz?=
 =?utf-8?B?Ly9sRnR4bjR5bDFsdy9pektpQVNkRXhmMFMzSVBrYSsveHg3RVRnQzRvYm5q?=
 =?utf-8?B?YUFXSXFtZ09HZm9ORXRPanZSMFNEaFF5L2tianNLN0VDK2N1Y1E1bkVueWE4?=
 =?utf-8?B?Y0M0NEM1ZG5SL3VKdGtmUHVmMjhvOTNTN1lYS2R0VngvSFZmMlZnWFpCM2Ur?=
 =?utf-8?B?WTFVemtrbjVBT2toV002aWxKSEJUOHdaaCtLcXl2VVdrOG5zWkpXZzF4OEFY?=
 =?utf-8?B?aWhtSlpMVDhjSjFiVGNndnV3WmhTQlQzR3NOQ0IraFp2MDBxY0NDTDNsdHNF?=
 =?utf-8?B?QjBqdmlheExxTjQxMGFnSFlHMVFmTG1XWFhSSFpxRHFhUGxXZHMyK1J1Tkdo?=
 =?utf-8?B?S3ZuQ2V5VXdqaWk3SzhHdTZRSVBZT0lPcGxtNk5ETzFhaGZZOXVUL3ErNnNn?=
 =?utf-8?Q?q/bTCbblzJeP0YUfMA5PW9Ydr30eSG1cOCDaYu/YHWUs?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf7cbfd-2703-406e-c30b-08dbf1be03f8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 16:04:21.6945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BaTqPFqbVS7m9jYve8HK9brn5ABKQR9J7IE8QLcOGJ79c0+Kg6FHDnujFkHqni6zQiXHJRgzsHmita+s9MgvQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7712
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
> +	pr_notice_once("32-bit emulation disabled. You can reenable with ia32_emulation=on\n");

	Actually this will result in a false-positive, even with the 
DEFAULT_DISABLED but booting with ia32_emulation = 0 so it's best if 
it's predicated on the output of ia32_enabled. This means we'll always 
pay the price of the branch even if it's disabled but removes a spurious 
notice in a certain case.

> +#endif
> +	return ia32_enabled();
> +}
> +
>   #endif /* _ASM_X86_IA32_H */
