Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9167756BD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjHIJ4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjHIJ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:56:40 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4D71FCA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 02:56:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChNWEHO0ekgNVrTq7ohlKtJFNlUwJcVDyinuO+STYrsOzRAlIZvUPbhFQMuv23T3x46vF+nkQxqHYVXIWJLkmfpWDBE6OvZnQcjhAFsm5Kjilj7c6LxhDOM9k1P/3ggFpemA7qE4xzI6g4FAOnXZya6lzLL4Zi++HcIgHmvQ/Y5FmGgKmRz5tyeE8KypijLaYml+e68g7Ua1Giq8hZCnKyEQrOsX9v8RLJBL5JhWb57rMA4RfzyqEa68SvyeBIb8Jla0YRkWiA72q00HHdLb4mKbmH+e7RvQPzgkyL7gAn+YDvWxvMM8yNn/NzDRRvTGE4DUTatBw5cMS/AlJrRQmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3264RpyNlN08ny1ixCn+gNnFIf99RAL+rkFj9DNbMOI=;
 b=d7E0vkUXYhOTI6M42CcwYjXRWlmTWwxE3JY27XCkNFmRqWW7BpD410oxzppZJwDu64fDMhOgjGAgLF4yRPADecTe4knjjg5U5tv7h6gNkpfYe45hC611LCgDvYwLccZ+Lc9iTRcvMVkgzwSFWOctywVmA7+/05BDyJBnaxdSScUphYK5suQWMurAfBMZrDl30TeZCYCAnvtwiPwFuX6RU7IO5Z4pfnTFLxRgq7NnTG9/rdyfN+nBZiw/Y27/gPdu9H5mlJVJnjMEj1H1rnPrRmtOW8V59hylG++PYPqQqrqtZ8VorCU4ANbYONaunaneqIA9IE2bPO5+ueOyC/681g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3264RpyNlN08ny1ixCn+gNnFIf99RAL+rkFj9DNbMOI=;
 b=LvrMrOGFcjQ70ZxuQCFI1VS0LxJg5marMZW7h9sb65aMjjRkg+6RFqrGE7uK0LuZGPULyRpxRKMrRNUs+JkLe7QDeHq1f9rVQRMk5Hx6BZcGC9A1z2CDAlsMnqkWIrlPjRx3lwCyR7l3KTgqtfMRIoZLg8LMLkO+jVW0gCm9oeWmSVvxqO44K9R13AV9nAFNgTYbGuE+dxH2WO3lTu5w0EIouk/95NVfZyySSRDTvfndZmc9AkYPxjgE/7U6d++XGCnPjJnWyR/ExTYvSvfGQVxXrqmNvYRR8DSwKQd9aolCw6hoPlUkf1Ba+hlG4ukL531kKqoco1yIMD8PGNiekQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by PAXPR04MB8458.eurprd04.prod.outlook.com (2603:10a6:102:1d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 09:56:37 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 09:56:37 +0000
Message-ID: <9ab1abd1-4f00-8412-a926-7ef617af80e7@suse.com>
Date:   Wed, 9 Aug 2023 12:56:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC][PATCH 13/17] objtool/x86: Add arch_is_offset_insn()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org
References: <20230809071218.000335006@infradead.org>
 <20230809072201.326960605@infradead.org>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20230809072201.326960605@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0216.eurprd08.prod.outlook.com
 (2603:10a6:802:15::25) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|PAXPR04MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bcb5b40-b100-44e2-f64f-08db98beebbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yWIKMgeSn/V9JhF76FG9xKG4BEVPEFtdxUKzi9yBtbRFMiz+SD/dKunfi2N01wcPjWImJUkKhEqweezsmf1t5/XBcnzFWyeSDTcPEBc//pFCM+B/IQGKP36HFOnPG+VlDU6yEGt/+kkgVPCJkpu3V4w/mHziuF/BqC0s4Vhb/tpAH3EUwzwMa6WdvLsDCz1IqN0KxMLURrRWCtY0AXWl5CuyLNhFTufaw/wMQTXRHOgUYxZO2g8wRTolLfL8tvuueboqvxwZGglk2XA2uBDsDpCeb7kH2iPJRylQcDq7tMX/lenN5zb3zIxlGIUe8xjmNpkDTyh1+9GrxM537r1j409CP1XD42+oD0gJpjXIRrXOAMiwi4OqnjDKrbhtCx5yGGqKfGHQL8/Edin/A31Bm59QfH3DH10UFg1iB2HsWz4zeVYthJz1iS+sYjGFd49zk57v9ZNSpeTrN8aRcKag14GWuAloyef7zxnmi7v1apQzpTxk5Unm4yKrHf0edff6lRn7D5M/PkWA47M3YrOTfCrQ6tBvg7ylaXZwkUXIK8vSnyyk8QiGnaf/XM8m4vHrfzwMAFio1F/DyFqDuMgKzrTHWB2ud6KQvKuddu70QXV4qfSB6/QXAJRpf9J2vHapq+J8K2iwCHKP+oyg9yAVlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(136003)(376002)(396003)(1800799006)(186006)(451199021)(31686004)(6506007)(26005)(38100700002)(478600001)(31696002)(5660300002)(8676002)(4326008)(66556008)(8936002)(66946007)(66476007)(316002)(6512007)(86362001)(6666004)(41300700001)(6486002)(2616005)(36756003)(2906002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDk2cUsvS1V0VFJzYUV0MmxETFAyeE1SNmtjRXZyeHVmZHgxajEyeHR5OVJ4?=
 =?utf-8?B?UmwwdjVaVHhNRk56Nlc0cDJsbEJHK1AyWWR4NFRxSEwxWkExazBiOHh3NFQy?=
 =?utf-8?B?SkFnRjM0TCt0Uk1ibE5HSHBSSGtVNmNPa1V2ODZacnB3ZnZkUUdzVEVoUk5S?=
 =?utf-8?B?LzhTbzA2NEl6NDhqaCtpTzNkVHVrOVBJOHdVVGs1THhkVzFkOE9qZWVKMUdp?=
 =?utf-8?B?SDVaU0lCeHc1c0JTU1Y2SkErNGk1Mk95WXJHMHU5TWx5aXNhOHpHYjVnUWJh?=
 =?utf-8?B?eFJYbzNxTDVJRXVwL3hiSW5BUkpFL3IrQWtXU2NYR3Y2QWM3aFRvSWdqb1ZX?=
 =?utf-8?B?R1Z4MWQxaHRHVlc2NFg1dVA5cFE5YzVJT0RlVmVSNXRBbkt6R3BYK1VvMWFL?=
 =?utf-8?B?dDdiZnlCUTFnNERrTG1RMW5XYitoSG1yZStrYSsyc280eEVFZ2xOZzdSZlJo?=
 =?utf-8?B?eGV6RjRzemJHNEM1QkN6K1ZnL0NKcS9rZ2FUeDFwejBoN0ZOdStwSmtZVnll?=
 =?utf-8?B?enp6OWNuRFNHUGVPZjJaWHFDcG91ODdtSDZjQUNhQXIyYkRsM1NRdFA0UjNV?=
 =?utf-8?B?bWliajZMbUl0V0ZDYUFPSUdvakV1alVna3ZmaC9Va2VJS1FJaGI4emZlK3dN?=
 =?utf-8?B?MVBYekY1K3JCRnJtdmptU3lJRnR2N0k3S1Nkc3lTU2ttZk5jOHVVUGErd1Vj?=
 =?utf-8?B?VXQ0bWtDRm5QWlJkZ3BDeElaV0VVbGxFb3Z2dVdUMUJ2cnJNVEhYak1WUFVh?=
 =?utf-8?B?UjFWNUxLT29McHpkRnI1TzJGYkxlTHVKdUpxcFBUVHJZcEhoRkZSbC93bDE5?=
 =?utf-8?B?NENGTzdvRUZKMm5jVmhSQXNoZE81dzdWbnhUcGpNS0dORlZGbnRraWFuZ0Yz?=
 =?utf-8?B?aWgvSzFLSmt0RHNkR0Z5akIzaklCTThEbnBXS2pKREtvd0c0U1VVVy9uRUw2?=
 =?utf-8?B?cENOWEcwTEx3OWdLa3h5aHJ4Wmh0RHEvN201dmdtZ1FNTGU5N1BhNEk4and6?=
 =?utf-8?B?d3RBYTFhZGgyemdXSW9QcGs5ZDdabkNMYVNTdzVaRmp1WjF1Zml2a3RRRStX?=
 =?utf-8?B?MnZWeVl4dmlwaExkWmFabkk4Z3Vjanhvck1JdndKVnlzN0I1U3AwOER5UnY2?=
 =?utf-8?B?OXExT2pLVGoxR21WM3RwZnJSQ21kOU9tbTczQTlTRDVBMUtiRkhSWFZXdklB?=
 =?utf-8?B?MUJiOHZlK2pObEtyR1piSVRnUDR6SjVCSzJ1TStBUDUrWGNOallTWUhyUFdH?=
 =?utf-8?B?WEJuclpUcWMzaEdqOGI1Mm1rZTVtTDRoT0padUFpeXI1cFVLS2g0NUpYZ2Qx?=
 =?utf-8?B?UHpBN0VIWjV1TE1MWElmVzVXNkpkRG5pSFBaTk9HQlZmTUVVanNMOS9iVDFQ?=
 =?utf-8?B?TnhxT0ptKzYyYzYxcE1jMDRRMDRaVGdXL1Z1Z3o4T2RJQzFUUjRnQmdBVU01?=
 =?utf-8?B?NGkrQm5aU1RNekNUVEpoSDg1RUpsWUxTSFJ0cEtKcy9xTHVZSUJMRzNvTXI5?=
 =?utf-8?B?d1Boc1puKzg4YmtuZ2NXN3p0eG5IYnVTVWE0VHZ1VFdLb0hsVC9hbmVnL0hQ?=
 =?utf-8?B?N2dzQnZBOERqVUR6cjNkRk5LWW5RbEdFWWZzYXB2aURRVmNjdVk2Ry8wV3ZI?=
 =?utf-8?B?NG1ENEdOUENUV3IxY1g4eExiUm84TkVFbGErRG95SFpSWXJMcVNIdnAvY1Qr?=
 =?utf-8?B?WERaRjR1RWRrL2Fmb0YrSE0wU1lBOWNhbjdRUCsxRC94YlpmaUZ4SmJ2WXp4?=
 =?utf-8?B?RG5yL2NlN0UrK1dCeUluZlQ1MDVwK0Z5bHU3RGs0K0prUlk2ZlRPMVQvOEhV?=
 =?utf-8?B?c1JYcFY0ZSthNjM0Y3pXV3g4eVJMTFlnYWxiM1VWMkRyYVh1NWhMTWxqL1Mv?=
 =?utf-8?B?OVI5a2NxcEUwcFNPUXpWLzlxWDNaZmkzeE0wa25rai84OWJGbXdHRzVuUE0r?=
 =?utf-8?B?aURSbGozOXRJMUdmN0t3dzA2VkNwUkNFcEp4clZjWGpxNEVSa004NU93OWVO?=
 =?utf-8?B?blczTU8zay9SNVZ0WVdnZS83UkQvQ2RQTFVrM1FQcWpsenh2Wmc1T1E2UHpw?=
 =?utf-8?B?THcwSXRrVEdYUEQ2OENoZk8rN1JGZEtTck1zUlBiQVBsRW4wNnhDRnFwenhN?=
 =?utf-8?Q?Xxowk1L/4UkGN/oPCrJLnoi7k?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcb5b40-b100-44e2-f64f-08db98beebbf
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 09:56:37.0515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hwYTXocxLJ622xV5TeudfxA/tUTi9Hdo8qMUS4W9a8EQY/fAWOIV4NGoymo4eB2j9o6RJA+M2rMDqbJxFxEmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8458
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
> Add a little wrappery to identify the magic symbols that are actually
> inside another instruction -- yay for variable length instruction
> encoding.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   tools/objtool/arch/x86/decode.c      |    6 ++++++
>   tools/objtool/check.c                |   13 ++++++++++---
>   tools/objtool/include/objtool/arch.h |    1 +
>   tools/objtool/include/objtool/elf.h  |    1 +
>   4 files changed, 18 insertions(+), 3 deletions(-)
> 
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -826,3 +826,9 @@ bool arch_is_rethunk(struct symbol *sym)
>   {
>   	return !strcmp(sym->name, "__x86_return_thunk");
>   }
> +
> +bool arch_is_offset_insn(struct symbol *sym)
> +{
> +	return !strcmp(sym->name, "zen_return_thunk") ||
> +	       !strcmp(sym->name, "srso_safe_ret");
> +}
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -459,8 +459,7 @@ static int decode_instructions(struct ob
>   			 * Both zen_return_thunk() and srso_safe_ret() are embedded inside
>   			 * another instruction and objtool doesn't grok that. Skip validating them.
>   			 */
> -			if (!strcmp(func->name, "zen_return_thunk") ||
> -			    !strcmp(func->name, "srso_safe_ret") || func->alias != func)
> +			if (func->offset_insn || func->alias != func)
>   				continue;
>   
>   			if (!find_insn(file, sec, func->offset)) {
> @@ -1303,6 +1302,11 @@ __weak bool arch_is_rethunk(struct symbo
>   	return false;
>   }
>   
> +__weak bool arch_is_offset_insn(struct symbol *sym)
> +{
> +	return false;
> +}
> +
>   static struct reloc *insn_reloc(struct objtool_file *file, struct instruction *insn)
>   {
>   	struct reloc *reloc;
> @@ -1588,7 +1592,7 @@ static int add_jump_destinations(struct
>   			 * middle of another instruction.  Objtool only
>   			 * knows about the outer instruction.
>   			 */
> -			if (sym && !strcmp(sym->name, "zen_return_thunk")) {
> +			if (sym && sym->offset_insn) {
>   				add_return_call(file, insn, false);
>   				continue;
>   			}
> @@ -2507,6 +2511,9 @@ static int classify_symbols(struct objto
>   		if (arch_is_rethunk(func))
>   			func->return_thunk = true;
>   
> +		if (arch_is_offset_insn(func))
> +			func->offset_insn = true;
> +
>   		if (arch_ftrace_match(func->name))
>   			func->fentry = true;

nit: Why go through this if when one can simply do:

func->foo = arch_is_foo(bar) ?

>   
> --- a/tools/objtool/include/objtool/arch.h
> +++ b/tools/objtool/include/objtool/arch.h
> @@ -90,6 +90,7 @@ int arch_decode_hint_reg(u8 sp_reg, int
>   
>   bool arch_is_retpoline(struct symbol *sym);
>   bool arch_is_rethunk(struct symbol *sym);
> +bool arch_is_offset_insn(struct symbol *sym);
>   
>   int arch_rewrite_retpolines(struct objtool_file *file);
>   
> --- a/tools/objtool/include/objtool/elf.h
> +++ b/tools/objtool/include/objtool/elf.h
> @@ -66,6 +66,7 @@ struct symbol {
>   	u8 fentry            : 1;
>   	u8 profiling_func    : 1;
>   	u8 warned	     : 1;
> +	u8 offset_insn       : 1;
>   	struct list_head pv_target;
>   	struct reloc *relocs;
>   };
> 
> 
