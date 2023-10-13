Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B707C85EA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjJMMjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjJMMjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:39:11 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C62BF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:39:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gc4rOwU7Dewe1ZZEyhfAFjXIeBTICe1bBbWmkyWVosqvT3PjhGpVwpEV5p7k+BO/zwi15cuD9C0P5YwgcoVbQL275F6FgwCjH2l1Qsqvq/OV5TwgRxPQASgwR0osfeMJeKBP5IGTNlrkz9oRJVaT8Cl/OTABsVWcjZMKug/QpRd8WnZ7+k79W5RZWnOSM1F4JjCwCC/TN6NAyoOlNo98F/OqPnjys86zIDrRyCCYkgut0EaPfJiEdgfcFm9ni8gyR0QWx2dwbZEAlPGBzanRnX4mzK7WQ6bbpCDvh/m4JuXi+jc2wEB4ubn5p6Yy5G4nWIvB+66rv9iqHSQEUG3g3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvRWm6bY2DR4nnkZZEhnqypS5AoOX7Wh1Vqo1mjTKYo=;
 b=hD9sNbc6JzqvD3hFVs2J1UbTBN1WlddQlyvOerl67e4dVQ8jdOQsinwvrh0oerTGAWexmeXBgzFRzd/ZrvlE1QXsT+pHLeySODCXrBBvZpAsSMJIRtEOS1I4FAeCEmgKJspz92+5bERHMlH3kksS9HGVlpXBlWy2yQs5/agJ3vEqJvLGGx77cVXe8fnrBe6SRy9ZWu3jqS2QOxTdt8LVASQIBS2Knr3qXmI0Dvo/hfNzwBTmpASu0EIA8PMtoWuXolRnGq9GFQYdDhN6w+2Q9Aimh3nRFL+uryM4QOTcyGUgR/IvBvpfd2vku/4n6W3OjzqDKRuu0fUzyeqMyu46XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvRWm6bY2DR4nnkZZEhnqypS5AoOX7Wh1Vqo1mjTKYo=;
 b=y/tahZd/7TnapkaVXv0x4sP+laMsGiQMwOtBZ3o/bMX3yBI2ohyntKHaEAxtqvJvOsyK2kz+rx4Fwn1IWpS8RNaTeaMwoZtWVTkBZTMcqyqeyYGhr4QSsIPuB+cJktDJwQyeB/xrk0z+O9mp5LPcXjSw3wG7F1Esa+VWnik+SnBp3QdiTQzzbTRumSiOq8TQU1vB90xramllobS9ipz9XgP67QFFaH/Lpl+ty8ISwHOp6pypu0/y1R+kdYK8/gjssLEVQ4sop8QXeG6K6r3CC5kO9m7wxAc/4uz/jj9OpfBs9S17xPw4AgAEZgAo95ePy+yNZeeLF22pY6vs/97LeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AM8PR04MB7731.eurprd04.prod.outlook.com (2603:10a6:20b:249::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 12:39:06 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::edd3:f00:3088:6e61]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::edd3:f00:3088:6e61%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 12:39:06 +0000
Message-ID: <2df50490-a493-4e27-a8b1-15b094ab99d8@suse.com>
Date:   Fri, 13 Oct 2023 15:39:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] x86/entry/64: Convert SYSRET validation tests to C
Content-Language: en-US
To:     Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
References: <20231011224351.130935-1-brgerst@gmail.com>
 <20231011224351.130935-2-brgerst@gmail.com>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20231011224351.130935-2-brgerst@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0208.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::29) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AM8PR04MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1c3636-56cb-432d-b30c-08dbcbe963a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KLEn08BXCis0DZXwW/nx3ov/iOyS57X2RjAVR9cJ0vuQMMCfI+hoRoZF9oD8vha+lKR5elg6Q1NIVI8e0vmk5hFGwW2RcUvOgq7LHfaiJyadh2L9JS9YJ/VS5D6E6m6uyOXA94vokbzXrzSo+7TDd0LRhkeOVK/j/jU6yZK7RAuhT62FWxEkg/TjW/en6KALxyX/A9UfgWAvLtftOeJCz9Q2zkiP3GN7dOhKvKuN4zjuit5J0rUFHY125lcP85A7luC03US5eGLzUtKHADJNY3EpZkV/FQK8jq/zzrzRM5IqtBSetzrRCPuBSeeBNs39jV5QDpBYjayzSVj6YcbKvXxBiJOwjxZ6RX0i7YmD6hz87wTfX50JZQsFB5swa6wjGJ8BFHe2sUE8WP+tx3LS93bCdJF2ygPf/bs5MbPfr10lBCyh6Lq8kB7khvPptK28DcQxTI/gfhrodTeiae9tGvvXBHRjuEm1rpBhMubCeO0muUwGNb9Kd59QwkQKbCLerUZGIJVQJb49/sGKnp0C+BQoEUvJ5HdDyLIiEnjhj65dhjPLxwhWTMJaBSb9mH8RTUiYHgzC9f/UfgDRmJGbYlNLZWLL39MDd2uZtC9g2RSCVf9ptxdDgFU0gFgU+lNBgjarBZ/eBHjLWqrEPXo3zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(86362001)(31696002)(38100700002)(2616005)(66556008)(110136005)(54906003)(66946007)(66476007)(2906002)(8936002)(8676002)(4326008)(5660300002)(83380400001)(316002)(41300700001)(6506007)(6512007)(6666004)(36756003)(6486002)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXhBa1p6ODVtdm8zQTFIQVIzRUlERkUzNFYyNEIweStvRzVQaUVQbmZaUE9h?=
 =?utf-8?B?VG12M2ZKTTdyYjZqYk5wK0hMOWpaVFNpeDA1UlpiYU9tZCtXMmNLYXFROUts?=
 =?utf-8?B?RU9VNmpvODgyUTdwRjltVlV5SmhnMkU0aDVUNTl1OGJjZjdFMERaVm5aZXhV?=
 =?utf-8?B?UXFWVUJRTjFjQ0Fack9KZTdhN2QySWhBeUNKVklXdnBNSWZwNmhjRWV0TS9w?=
 =?utf-8?B?RWVwOGxueERVSkdEYyswaUZmdTZwQm5SazVFeTdQbVJ4R1BKVTFRREdWUXI0?=
 =?utf-8?B?Njc2N1NpOFZpUjBleWN3UGJyT2lWVE9CR2p6Z0Ftam1VSUtxcFJqWS9Oa3BS?=
 =?utf-8?B?TEwva2VQdzdDOGJIK1lmUSt0Rk9jQ2VYVnJFTjVaRnZkcGZNcEVFSTc1NUxr?=
 =?utf-8?B?VHhkMGphY3I4cldnYjhyWVNkTld2U0lyeXQyM1ZodEFNNmc4aUQwYUJNdnhl?=
 =?utf-8?B?N3NBRmpQK2VOUDRGbzVVK1hDK2xiWGMzM21WbXB0b0RRTmM0elZVVTdVeWtC?=
 =?utf-8?B?VUFIQURMT1hxbnZFR01MaUkvYkcwVGdzd2hGSmFlSVJhMkxaSFNPcmlkczBD?=
 =?utf-8?B?aTY0cEhrR0NSUHdxQ05HcmtWSDdwR09ySTErYkVnM2hQdm5sd05mVGw1R1Nz?=
 =?utf-8?B?UzVNNk5JZitOS2w1dW1OeEJpTVI5Q3FvMUdpOTh3eTMvSmM1R3NYaUlpMVVG?=
 =?utf-8?B?WXl6SFg3WFJTZTFNWi9relJhUURmbStSMmdqSThuVGxuQnUwYmw3a3NWZW84?=
 =?utf-8?B?QlJJdE1ybTJYMGpKZVk5RFJNK0NlNUc2d3c1dUxVS0w0WG9HdTRzZi9zTFdI?=
 =?utf-8?B?cEhuV3h3OHJMNFpIQWk4b2hTN01leWhPb21Oclp2cG4ybSt0VXZ1SHN3VFRj?=
 =?utf-8?B?VjRVVG16cFhBSExtUy8rN3VWNkFGUEhZWHpYVFRRYjA0c29tNk9Ob1VwTmYv?=
 =?utf-8?B?eTFaYUU1SEtGNzg4am9RMDJrYWJYd0FSNlV3blhIb0ZHa0MrTHR5di92OFl2?=
 =?utf-8?B?QWhVN2VWcmNtOUlMaVlOS2dFdnExamxPSXIrbitIOXJxemdoZ3BxZk5WOExN?=
 =?utf-8?B?bk16djdnYkZUeUkxVjN0NlVmTXIzcis2NStEUXJXMTh1R2JhYWpoRHhFRnky?=
 =?utf-8?B?eTYwbWxILzdCTTF2cnh0bVMrREFtRDdsTFpESjdDZ0J1S3RCaUVJYm91TlRI?=
 =?utf-8?B?aGJuQWYvTzNWcGphWnQ0b3M1Z1oxNERtSEFRVTFPZURNWUdBenBuU0dCTnBC?=
 =?utf-8?B?UE9pTVBkZTh5UEtlaGlIRUxDSmhGWlp1LzdZMUpQUFVDemJlSDhMc0Zlb0lY?=
 =?utf-8?B?aVI1d1d5cjU5d3huY1pNdzBZL1d2VDIyb1JYK0ZvSnhNMkdPOTlhU0tTcG9G?=
 =?utf-8?B?NzBPYW1iNXQrY0FFR2FzQWxZT0UrNER4QkIycWduQ0pFcmF4NmNBcy9NNWp2?=
 =?utf-8?B?NFRzb3Z3a3k5eWNMbHNzNnRYellmd2JKOG95c0VBTHNJY0ZSdktBUWtUeksy?=
 =?utf-8?B?Q2d1OW42Q0RCaDA0eThWZFN4VVJyclpCVUxBbnJaV08wVGI3bktwbDJ0ZytS?=
 =?utf-8?B?MnZmOTRNRHdzdUpZVkNWWFJRaDZOdEVhWkVXdEc2TkluaTR1c0o5c2hmUkMz?=
 =?utf-8?B?d3hSNlpzSFhuYkFWYldKN3ZJL3V0UnJkbko1eTJoeS9qZXB2Q3ljbXFpRTly?=
 =?utf-8?B?cW1MUmZkekFlT1RncG5iMVpGWmI4dmxFc3g3NzBRYms1VDg1QUdmMTVqU1Nz?=
 =?utf-8?B?R2JzTFY2ZTZaY2NLNG9qRmovZ004bGdmN2VKdEszN0w2bkIxOE9Ra25uR1RW?=
 =?utf-8?B?UXdPekdidlBYTElvR3lGNk95elFiandpK3B0L001UDkvUnhGem1kYmxPYytV?=
 =?utf-8?B?V1NQZDFWeTloNEhuZUdrRms3bzhwdEdmVHU4RFNvOEp2Lzk0Z1dNOHFpazVC?=
 =?utf-8?B?dEVXcTFSZEJPOVN2cmFJNHdxTHI3OHlJemVDWUhoUDlTd1Y4MlU1VU8vOGht?=
 =?utf-8?B?amRXU0J5YTBwWGdPaU1XVTV0cm0yZDh3dHpvejJZOFYrcFlGTmhJekpRR3VE?=
 =?utf-8?B?QWU4TWVsNUlzYVZUT0tpUzdQaUJweXlWMUcySlAybjdGQWR4OGpGODMxNnlV?=
 =?utf-8?B?SnRwMktZQUFkVkdsaStVRzEvK1ZTaVhtZ1c1TmVtR1ZpUVR3SjE0RW9hcUhy?=
 =?utf-8?Q?KGd4I221K9ZI7CXkMAiQr3uoDCw7L7hP5w1QUr++QkGr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1c3636-56cb-432d-b30c-08dbcbe963a3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 12:39:06.4525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1e4akhCEJiVMe1oC7NTqUBm4B0IQbdCetXqDFFMbIazmtH3TgKCWl3oWcqo/JmGg18JemwsndyXdFjnoJlNOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7731
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.10.23 г. 1:43 ч., Brian Gerst wrote:
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---
>   arch/x86/entry/common.c        | 43 ++++++++++++++++++++++++++-
>   arch/x86/entry/entry_64.S      | 53 ++--------------------------------
>   arch/x86/include/asm/syscall.h |  2 +-
>   3 files changed, 45 insertions(+), 53 deletions(-)
> 
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 0551bcb197fb..207149a0a9b3 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -71,7 +71,8 @@ static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
>   	return false;
>   }
>   
> -__visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
> +/* Returns true to return using SYSRET, or false to use IRET */
> +__visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
>   {
>   	add_random_kstack_offset();
>   	nr = syscall_enter_from_user_mode(regs, nr);
> @@ -85,6 +86,46 @@ __visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
>   
>   	instrumentation_end();
>   	syscall_exit_to_user_mode(regs);
> +
> +	/*
> +	 * Check that the register state is valid for using SYSRET to exit
> +	 * to userspace.  Otherwise use the slower but fully capable IRET
> +	 * exit path.
> +	 */
> +
> +	/* XEN PV guests always use IRET path */
> +	if (cpu_feature_enabled(X86_FEATURE_XENPV))
> +		return false;
> +
> +	/* SYSRET requires RCX == RIP and R11 == EFLAGS */
> +	if (unlikely(regs->cx != regs->ip || regs->r11 != regs->flags))
> +		return false;


Under what conditions do we expect this to not be true since we've come 
via the syscall which adheres to this layout? IOW isn't this always 
going to be true and we can simply eliminate it?

> +
> +	/* CS and SS must match the values set in MSR_STAR */
> +	if (unlikely(regs->cs != __USER_CS || regs->ss != __USER_DS))
> +		return false;
> +
> +	/*
> +	 * On Intel CPUs, SYSRET with non-canonical RCX/RIP will #GP
> +	 * in kernel space.  This essentially lets the user take over
> +	 * the kernel, since userspace controls RSP.
> +	 *
> +	 * Change top bits to match most significant bit (47th or 56th bit
> +	 * depending on paging mode) in the address.
> +	 */
> +	if (unlikely(!__is_canonical_address(regs->ip, __VIRTUAL_MASK_SHIFT + 1)))
> +		return false;
> +
> +	/*
> +	 * SYSRET cannot restore RF.  It can restore TF, but unlike IRET,
> +	 * restoring TF results in a trap from userspace immediately after
> +	 * SYSRET.
> +	 */
> +	if (unlikely(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF)))
> +		return false;
> +
> +	/* Use SYSRET to exit to userspace */
> +	return true;
>   }
>   #endif
>   
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 3bdc22d7e78f..de6469dffe3a 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -126,57 +126,8 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
>   	 * In the Xen PV case we must use iret anyway.
>   	 */
>   
> -	ALTERNATIVE "", "jmp	swapgs_restore_regs_and_return_to_usermode", \
> -		X86_FEATURE_XENPV
> -
> -	movq	RCX(%rsp), %rcx
> -	movq	RIP(%rsp), %r11
> -
> -	cmpq	%rcx, %r11	/* SYSRET requires RCX == RIP */
> -	jne	swapgs_restore_regs_and_return_to_usermode
> -
> -	/*
> -	 * On Intel CPUs, SYSRET with non-canonical RCX/RIP will #GP
> -	 * in kernel space.  This essentially lets the user take over
> -	 * the kernel, since userspace controls RSP.
> -	 *
> -	 * If width of "canonical tail" ever becomes variable, this will need
> -	 * to be updated to remain correct on both old and new CPUs.
> -	 *
> -	 * Change top bits to match most significant bit (47th or 56th bit
> -	 * depending on paging mode) in the address.
> -	 */
> -#ifdef CONFIG_X86_5LEVEL
> -	ALTERNATIVE "shl $(64 - 48), %rcx; sar $(64 - 48), %rcx", \
> -		"shl $(64 - 57), %rcx; sar $(64 - 57), %rcx", X86_FEATURE_LA57
> -#else
> -	shl	$(64 - (__VIRTUAL_MASK_SHIFT+1)), %rcx
> -	sar	$(64 - (__VIRTUAL_MASK_SHIFT+1)), %rcx
> -#endif
> -
> -	/* If this changed %rcx, it was not canonical */
> -	cmpq	%rcx, %r11
> -	jne	swapgs_restore_regs_and_return_to_usermode
> -
> -	cmpq	$__USER_CS, CS(%rsp)		/* CS must match SYSRET */
> -	jne	swapgs_restore_regs_and_return_to_usermode
> -
> -	movq	R11(%rsp), %r11
> -	cmpq	%r11, EFLAGS(%rsp)		/* R11 == RFLAGS */
> -	jne	swapgs_restore_regs_and_return_to_usermode
> -
> -	/*
> -	 * SYSRET cannot restore RF.  It can restore TF, but unlike IRET,
> -	 * restoring TF results in a trap from userspace immediately after
> -	 * SYSRET.
> -	 */
> -	testq	$(X86_EFLAGS_RF|X86_EFLAGS_TF), %r11
> -	jnz	swapgs_restore_regs_and_return_to_usermode
> -
> -	/* nothing to check for RSP */
> -
> -	cmpq	$__USER_DS, SS(%rsp)		/* SS must match SYSRET */
> -	jne	swapgs_restore_regs_and_return_to_usermode
> +	ALTERNATIVE "testb %al, %al; jz swapgs_restore_regs_and_return_to_usermode", \
> +		"jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
>   
>   	/*
>   	 * We win! This label is here just for ease of understanding
> diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
> index c7e25c940f1a..f44e2f9ab65d 100644
> --- a/arch/x86/include/asm/syscall.h
> +++ b/arch/x86/include/asm/syscall.h
> @@ -126,7 +126,7 @@ static inline int syscall_get_arch(struct task_struct *task)
>   		? AUDIT_ARCH_I386 : AUDIT_ARCH_X86_64;
>   }
>   
> -void do_syscall_64(struct pt_regs *regs, int nr);
> +bool do_syscall_64(struct pt_regs *regs, int nr);
>   
>   #endif	/* CONFIG_X86_32 */
>   
