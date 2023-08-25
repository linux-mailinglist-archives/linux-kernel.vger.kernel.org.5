Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1F7788F68
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjHYTvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjHYTvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:51:18 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2045.outbound.protection.outlook.com [40.107.241.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A912689
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:51:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgQZ/z7uEXSO6VfauSCzqZHJiiSge3hYe6h8wFOK3U2MS2prlm0ZWo7L2Q9pciiHE9vCFhYqv2Ep2CYHub18Dndox75dcaprGdpoZPl+HR9TjdTiO8ZmEI6rMpfBwq0ZoSZmeWLSln7ib3R29139gcT1CwwBB/s+G7MHzrE90w+Q2SaRyikI52Mvg1wqYGakCqXO47jcDDPxDkroI1zKJpfHMwNUmgTMEVeq0l3AdmTf59nMfthgoQmKT/7ZMQFMd0OqhcrXDLD6yiBbBwRJW6AftMXX6UmVGP0kUkZ1FFg9oXPeQ1YYT2V2/bIQTgut17opMCEabrQIzeM51xDGfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iMLuuQlRwhrC0W6VF7Mg6vEZ/76OjRRqSg4SwMJUNk=;
 b=KElxL150GEeunQDn7mfDra4/gaC41qNYZ4SlrFdsv2rCL5zO1wqEcj6eUf5jq028IgBO41GciaKsXMzdZ3p5qIufepbLboAxRyJLmdMIjSkFjYrHf97VqZf+rQlSXQqZ1uj9q6sedix/wstNyV2YVY+WXjEW6sQcm2T/+QK8zOTEKbVMDhPXRILwa3l0F/u+ZU+N0GgXT/i0ScUHKfahfcwMwVa8bzPn5WAtSI/WK9nFjApaU7wbhyoWr4sbE1dwXDeo5qGvy9+GAG1Kv5Nqp0vksiOee4dhtYQ27/RYZ51naLOiwm2vkRhEwgQz764Wermnw4YgiDyALxAM4sGxEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iMLuuQlRwhrC0W6VF7Mg6vEZ/76OjRRqSg4SwMJUNk=;
 b=sVI02CDc/PC3RGagTd4mexTR3y+Z4f2ehRdeIGIpnfuonyR5ayq8JUc/ouypaJKSL/QB4CCxRdseI0FUzSbC9YwpUbpfIaZknsA5owY2VEtWIwtC9PkOhFar2sG2hZnzsCtrSqV+/ZwyxeE6EQY7G/EqVY1jsJkxohIxs0KYmFYFAYL8uopHqtsvHPYLw2Bz//x1tJSTfxD8VjmivfIG1kZmYB2CpKGgqYbt2LbfTBOsiV6PKgLEXwN65yLrKd6RXg7cqOfjac23T20ER8hXZCs5dpMB5KbZnVRQYBV5UHaEc6WQQd8TxvI1atuddaJ3F4E724r9cJcLO3Ds+0V/RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AS8PR04MB8023.eurprd04.prod.outlook.com (2603:10a6:20b:2a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 19:51:07 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 19:51:07 +0000
Message-ID: <ef77446f-0b9b-ea5e-61b4-da6b747f9892@suse.com>
Date:   Fri, 25 Aug 2023 22:51:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 15/23] x86/srso: Remove 'pred_cmd' label
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
References: <cover.1692919072.git.jpoimboe@kernel.org>
 <ec18b04787fc21874303f29746a49847751eddd6.1692919072.git.jpoimboe@kernel.org>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <ec18b04787fc21874303f29746a49847751eddd6.1692919072.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::6) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AS8PR04MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd2840f-2f31-4c22-edab-08dba5a49f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1dbd9W7d07ZiYEJnjfSxWy/kebN8g9OArAFebliaUHioa6H0566SxRUQfaodgoI+sxuq93vFvUWK6rjLsegyJJAKD8lCytQfBd9p2G7ee+71ZaVVfOZbLPH6/xOpnCdThwgeXRNuJErIKx3eJN1wpjRViXsM3Ptp6fhRfbqyTbankFNNjDbLs4djg9AM0iVBQNMsrXDH6f6t67cYGapEu7jy+1odgqMp+Y8bFXyRQuaO3HpONtUogSoobOdScwiJ6tPUYMh1TQJkDafC6Z+2fU7QLqDGgmrQmupJJhtqBgvTBsnvqzRWvwKT5TnLdhQk+cMHti8695y/TMitZM9WBUso00Xfv8fyBbEVitjTNQ+px9hNgXp0rNzvtoJIbdcvsfqSl4a7k/C58Kmj6IpONXvei+Qs6YNj5meaXbyP8Vbb07nTgsdk9wAkKyzm03ikwDNl1EwZSCQQm2Ecy/nEAX8IKeSuG3GgHiJEpQ94gPS0cIO/iHawPMrbmIIPBzdPbczJDwQ0TOIgZ4YkPS9LnSigGZ1Ae16O/xEmeKN60Efhu1UGCtfynvPO5y2NJ3kPlTNAQkZRjKk4de3JqS1eMm4fUDdZW027EIXVLn2s5w/uz8uzI8JvktRMMN4XdkJCkfo0zEQLc5YiJGl8MOrV+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(1800799009)(186009)(451199024)(38100700002)(66899024)(4326008)(8676002)(8936002)(54906003)(31696002)(41300700001)(36756003)(6486002)(6506007)(316002)(6666004)(66946007)(86362001)(66556008)(66476007)(6512007)(478600001)(26005)(7416002)(83380400001)(31686004)(2906002)(2616005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHpwZFd2NWMxRDU4T1NXNHZmaVU1dHhva29NRnRvdmtwUmhrZGpGZU1qVGx0?=
 =?utf-8?B?RDhZOHB6ci8vZ2NoWCtHZjUxakpXVDZGcjV6aWhDQUhSYzBBSDhqYkVQSmdp?=
 =?utf-8?B?T0VzcC9rY3FLZWR5K1VTaE1mNW9FREliSmFlT3daRkk3cU9lTmJBTDNZTncw?=
 =?utf-8?B?MzRINW9TRGRDaXRSck5TRGZ6aThxVTdsQ2Z4cnpzUzI2NlVKdDE5WWVadUZO?=
 =?utf-8?B?cmFuNjQzRXowREFuOTMrTkx5Z0VuTFZIbGt3Wk5uaXE3anp1T0xKMGxDVVlH?=
 =?utf-8?B?b1N0UzBBU1BERjhPYitRTjR5dTNSN25ibUpHQlc2dHJockNOQllycHExWnZL?=
 =?utf-8?B?WkpVTXRGMEVyalgyTmRvTDhiM1R6TVpWTjJRZnc1VjF0YThHVHhxWjdXYk1Q?=
 =?utf-8?B?Qk5hVGxWL1ZOSlJ2QVBRRTJ1WWw3ZGhyb0t3VmxIdjZSWE5NT29DMGx3ejRB?=
 =?utf-8?B?YktDWGMwN0l6RWY1QzliN2YwK0pIRENNUGt5ZlkyaHBTWFc5N0pxN2UwUmhh?=
 =?utf-8?B?WTgyVmp4aU9qb3lBSk9iRThQUGp3TVVPMVM4eklmbGI1ckF6ODdwb1ladlMy?=
 =?utf-8?B?dXpBQ2pIcitiZUVRdHczSG9MbzdoUVVONTFiemw2bGJVUEM1NmdZWVRrNmo5?=
 =?utf-8?B?cFUwdFpjYnFrQXExUE1lYWJDUE1KcDhsNGQyY0FCOGZtbVdEaFZLSFR0M2FC?=
 =?utf-8?B?K291M2ZhdDJhNnFYcWVhV2svSmZBOG1vdmZnbzVOY1VsbnRaQkhRR1dnZFhG?=
 =?utf-8?B?UkgwbzBrUVl5cVVNRmxZeFNTczJWUWozYkNSRnVNdWxIc3dsb0RQZjJMaFc1?=
 =?utf-8?B?UCszNU9kM21NdXRhRFdjUGNNbVF0ZWxuNTZrRXNmT3FoTzV3VmdzTjJ4Q3Vz?=
 =?utf-8?B?RzlxMm1IanA1elY4UGUyWkZHdlY3N3Z0b2xWOUp0bGlYQXkvdGJJUXZEWG5L?=
 =?utf-8?B?aEJOZmt0d1ErOXk5aDF6NlNpNjBmRWxvZHhnQ1dhWFFzak5LYXgwZk81dkpI?=
 =?utf-8?B?RG9iQWpnRlJMVjRKbWc3Wk1lOUdDc0tIRndGK0NOeGtzQU9qcEJmVkhIMDBy?=
 =?utf-8?B?WmJzMURHcVJlK3N3dmptb1c3MktRV1ZudU4vdWZlN0xJWU5sVUlaY0gxdDdX?=
 =?utf-8?B?REwwN0o3S3ZPUFNBbnRqNHBtTEpjaHJaMUZYL2ZQWUNoR2s0MTZWdHJEdmhp?=
 =?utf-8?B?V1h1MVp4R0xHaElBeGtOdUdYQzFDd1pjMEMvSll5NkRhNHdpNFIzc1YzeDA3?=
 =?utf-8?B?ZncrMWdYTlVPS1pZS1ZtelJZMFJOK2Myd281b0V0ak9XUVJTWG5PTnpDNnBD?=
 =?utf-8?B?d2FDQkVHenVpdmF3eXV4bnFZRTJ5L3JuKzh3Q2FDQ2g1UG9nL00xYVJnRUNH?=
 =?utf-8?B?elhZZWtxOHR0ZlE5YmhYdGNpRVZRYlJQdUV2WjlPd2JxQ3ZJcTJHK3F0YTdq?=
 =?utf-8?B?Z1J4cG5UampkcnlGQjZmWm1tRCtxZjlkWjRLS25YbldSNUh2QVdXb2xreFlS?=
 =?utf-8?B?Q2E4bGRFN1hFRWJhbS95QkpmS3ZPT3hKZmVFakVLb09YU2FETHJiN3RTdEFO?=
 =?utf-8?B?Tzg2VzlWRFJVYjBJcE5wWitaZ1gxbVpjM2ZoUE56OXlCQjh4ZnkyaU9wV1R2?=
 =?utf-8?B?TGszWVFPZFZ6OTlIYjhUSExPd1VnRkxVNE1uUkhSTyt4YVBEdGswbHZkOEpq?=
 =?utf-8?B?WVo0NjRGUWZpTzRYV1dNaDlsMFI4WXpKYklsZkliYlZMcW9zTDlXSEdRQ3lu?=
 =?utf-8?B?Z0NmZmZXaE9HcW1QYlZZU2NIWGt5N2ZyVEtuNlBzbjQyaVpadTQrdUhYb3RO?=
 =?utf-8?B?ZU9EcTFIWWZGcVlWNmpmQzFHdTF2MEZzRWwyUFplOFVWV1YzUWFJUWk1MEx2?=
 =?utf-8?B?NERKZUs1WXhQN1I2TlVXWlJiby9zZndreXNmc2Y0WXpjRGRXRURuOWxFMXBi?=
 =?utf-8?B?M3ZkRGg4ak9Zb0NibzRYQ0U4VVNRSUh3ejlLaUhkYzhyQmVuaUNyOHhBTm5F?=
 =?utf-8?B?YTgrR1ZVbGJCOTArMXdOM0V3a1hLc0t2RnZOZ1BzNXRBd1E1WTVuRHdwcVRH?=
 =?utf-8?B?YzViYU02WThXV0hXaFl5RUVTS1BjTzFLcHlCS0FVZW54cS9seGR4QzhCZklV?=
 =?utf-8?Q?/xty46VAwxJX/f4bjBpWJ6UqB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd2840f-2f31-4c22-edab-08dba5a49f50
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 19:51:07.0703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbSDq9LmWK/ZAE+ouLZTY12/TfGXVmu9k3zyHzIOc2Sl4dWS5W5GqK8DSJmdGIt4zt3RzbLIojMzvuF/ZnnseA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8023
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.08.23 г. 10:01 ч., Josh Poimboeuf wrote:
> SBPB is only enabled in two distinct cases:
> 
> 1) when SRSO has been disabled with srso=off
> 
> 2) when SRSO has been fixed (in future HW)
> 
> Simplify the control flow by getting rid of the 'pred_cmd' label and
> moving the SBPB enablement check to the two corresponding code sites.
> This makes it more clear when exactly SBPB gets enabled.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>


I think it never was explained why SBPB should be used when SRSO is 
off/hw is not affected? There's nothing in AMD's whitepape and there's 
nothing in the original patch introducing SRSO_NO. This patch deals with 
the "when", but what about the "Why" ? Can you put this in the changelog 
(if I'm the only one missing this detail)?
> ---
>   arch/x86/kernel/cpu/bugs.c | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index d883d1c38f7f..3c7f634b6148 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -2410,13 +2410,21 @@ static void __init srso_select_mitigation(void)
>   {
>   	bool has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE);
>   
> -	if (!boot_cpu_has_bug(X86_BUG_SRSO) || cpu_mitigations_off())
> -		goto pred_cmd;
> +	if (cpu_mitigations_off())
> +		return;
> +
> +	if (!boot_cpu_has_bug(X86_BUG_SRSO)) {
> +		if (boot_cpu_has(X86_FEATURE_SBPB))
> +			x86_pred_cmd = PRED_CMD_SBPB;
> +		return;
> +	}
>   
>   	if (has_microcode) {
>   		/*
>   		 * Zen1/2 with SMT off aren't vulnerable after the right
>   		 * IBPB microcode has been applied.
> +		 *
> +		 * Zen1/2 don't have SBPB, no need to try to enable it here.
>   		 */
>   		if (boot_cpu_data.x86 < 0x19 && !cpu_smt_possible()) {
>   			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
> @@ -2439,7 +2447,9 @@ static void __init srso_select_mitigation(void)
>   
>   	switch (srso_cmd) {
>   	case SRSO_CMD_OFF:
> -		goto pred_cmd;
> +		if (boot_cpu_has(X86_FEATURE_SBPB))
> +			x86_pred_cmd = PRED_CMD_SBPB;
> +		return;
>   
>   	case SRSO_CMD_MICROCODE:
>   		if (has_microcode) {
> @@ -2501,11 +2511,6 @@ static void __init srso_select_mitigation(void)
>   
>   out:
>   	pr_info("%s%s\n", srso_strings[srso_mitigation], has_microcode ? "" : ", no microcode");
> -
> -pred_cmd:
> -	if ((!boot_cpu_has_bug(X86_BUG_SRSO) || srso_cmd == SRSO_CMD_OFF) &&
> -	     boot_cpu_has(X86_FEATURE_SBPB))
> -		x86_pred_cmd = PRED_CMD_SBPB;
>   }
>   
>   #undef pr_fmt
