Return-Path: <linux-kernel+bounces-19859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60759827586
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6291F23AB2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1536E54BC2;
	Mon,  8 Jan 2024 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kodWOQ1f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9186A5476B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ca87ZuIBRsCUFXjgD36vVg6uXwW1tpWWD8tCO69DhUrCELxJ88KiwRLKBcp3mvYN0sbmLbnVWZlmFuUAzkQvToto22P0SR0ubjowSZljatxcsoX/h70YzUOPl5OT2oXrlBJ6MdC0mmqaGAvs9kLjPHEL2WPQRAPoO3b1I4AVi7l4DWDNiBxPGLwAKV/N7Q3d+VMdwBlP8IgeUp40eING9TetVYIriKz1QxL0Hy14KRKfL4WWVliKJRyrP0q/vhFMfqmynRrgfKkq3n0WnebDoRYQnGee1OZNasKYXt1wJO8NOYgxIaaGckI+Lwv/VqSrtKBmr3TJ4dfgYlcFxnkKxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1d611aTg7KkRV40zILUJNDh9D2eF20vVPjtZEraFKY=;
 b=VOVEjFRjWmPUhQrSbuCUAPfIHtGHpzT8kMIquKof/iihz+bVjyGbaEn1eJ99mlMxkBRim5Sg8YNiGW6+4clYVs7ofWzdVUqL/WbecPgKPW51fKALZAD2XgB+6bsC78v2MJ3LqQXrDW/GN7KV/6EtM6/NZv/dYvZGZHz0wb9D3ZXqAYEQeHdpov9H8W0tBQCFPL2y+dFNKRLUDxt1jrPg+ipORlDGIo+vAxFRp4LftxA0VU1wNroLC40hIXIzDMp1DlzCi+FXGQE1k+uWo6RLx04ziHC43b+feuGdXq8gngNE8IlaxAVT5Q6M7xtL5RSlUnuB6N3UnUC2IHis7QGiDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1d611aTg7KkRV40zILUJNDh9D2eF20vVPjtZEraFKY=;
 b=kodWOQ1fyaSoOBb44FluibDZ/ssnPYhSr7tVQ1hU//SqpgEv+B0Xfa33nw+Y3B6pV5BPPTfdxODyvAzJF5ixsGDF+xfoH6xkNJwT6QIVLOJXatKooqNOqH0V07AG16aoYjTS67VOTN+dL7t2/GuNec4D+FneUIFHZW9UGoafAic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by IA1PR12MB6281.namprd12.prod.outlook.com (2603:10b6:208:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 16:40:12 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43%6]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 16:40:12 +0000
Message-ID: <9c435137-08af-4f32-9abb-e2b73c40ae5a@amd.com>
Date: Mon, 8 Jan 2024 10:40:11 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Harden #VC insn emulation somewhat
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240105101407.11694-1-bp@alien8.de>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <20240105101407.11694-1-bp@alien8.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0002.namprd11.prod.outlook.com
 (2603:10b6:806:6e::7) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|IA1PR12MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 8794237e-d2ae-4abf-f485-08dc10687c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TOw9taO3v9hj3pVIPvsCKuVQPzb1vyjYiW3/hjj5eiE7EMw3GBG0sB9v9oVsveGi7CCupgCvKTkqWjy7umkvHPlvikKmpAAW/juKrWazeqORwpk2/y2+vBrNlU+C7/n3w2z6Y17fVU4aNftAzeWdB/m8uLJGWQ5/gV1Mi6Qn/LCZP375OBRAFyvD5FumK2IVxCPd5tKeijGRauMqpZW53kUp2GtSyi3/6BDLBFkLo+Ly4Ft0ypWGfYvaw97WW1usUynyjht+880km5TMENtECGHx6y+EO8dfWzMvHKpHc4I9S3N13+pbS3uoaPSJKF4LFmRmaJmvfQ6RDwhPbJiQYt5N4GP6imCEIgfSNP/kFCbU8gB2QSEayw5gqb5pK0sa8xzKp49tJ7RE0+cPUdXVF+FlWmpMFaqhGnnzfjRCFhAs5l1+W1BWB3QCa34zvUvqL2hQb+S8i3WpPK3nTyYE5Nd2gtJHy5XGCALbAivqK/hiWiekYClHEwrs7G5vMRSO8Gv7mCNVPUzMjt2eQIgJesr6XM88migx+cYukC/6EIKCenoiMBV09YkivLCISydQVBbZ+CRNdIAej4PrMOcfBeUqFUYuI81uCvxkgwtAuzARD/eJ4W789SV4uNvkHnNFNlsx/lRDuJDzYQllwT+XIg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6512007)(38100700002)(26005)(53546011)(2616005)(478600001)(6486002)(6506007)(83380400001)(66556008)(5660300002)(2906002)(41300700001)(4326008)(66476007)(316002)(110136005)(8676002)(8936002)(66946007)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHZGRmNEUFgwTGc1K0pPSmlpUzNDRGJiMjBicFY5K3dKYnFoR1dGcFl2M3NE?=
 =?utf-8?B?eVZ5UzEyRkNTdlgyeitwQVJRVGFLRW5FUUxhZkVqV3FTRm5BRTN6cHp5Qjh3?=
 =?utf-8?B?QnRUc2xEak1ENGtBRFl3cEIvaVdLK0ZPQW9LaG9WNTlQUVI3UHluaGN4VGpX?=
 =?utf-8?B?eXNqekRoc1N6M0ppSElZaHZ2Si9BZ2pEdDdxdkJrM0NJZ05ZUG9WbFRLUjli?=
 =?utf-8?B?WkRNV0ZDdlJEckF4ZlU3SjB0bC9rM3I5dXJGTzVqbjIrNlFveTkvWk15V2p4?=
 =?utf-8?B?UUZsSXI4YTNQRnNiUE91VlFyVHZwSDJSWHhWdE9JTE5QT1NXTzRuVlczcTJa?=
 =?utf-8?B?aDR3TDg1L2gzRXNTT2NyOG94a2FuSTFIWjVjQWdZVXoyN2c4akNTZ0RBeGF2?=
 =?utf-8?B?akljQ1FTWWlxbHVtQkNBYVV6U0FkTkVKUmNid2VYTHNtektxM21SdlJZdE1v?=
 =?utf-8?B?UlFlV25wOXVFYThBc0hjeDRscm5OUHhVY3N0dTlwVTk1YlRqWEtlUitwUlVB?=
 =?utf-8?B?M3hwMitkbnlQZW9CYzR5TDFFcmpGdWMxNjRETjA3enZUaVNLV1pOY2NSWkJx?=
 =?utf-8?B?bmJHZFBoUjRGSGpGUXNTaVJLKzNNanpOV2FKOVJYNE9MRWNlT3JXZkJwaE1S?=
 =?utf-8?B?S2wvSXhreFpQc3ZkK05QL3Fod2U3ZnIrM2JCdW9RYkxtTlkrZjZBZU5VbzRW?=
 =?utf-8?B?cVNUUkxzMFByQ3crT3FEdWU1Q0MzVnZvZWxleUVHenFKTUo5anNYQStSTnVt?=
 =?utf-8?B?dFhCZllncmsxb3NSdkR5cE1MTnVEU0xxa05CYm9HcTN2RGk1cWFoTTBGRElV?=
 =?utf-8?B?aUxGQ2lENkN6K3g1cm0zQzZtNE9ZLzNUSzVWWkhLdG5kUU51ME5VbHRvejFZ?=
 =?utf-8?B?TFNJdXNBbjMrekRFRUt4cmttSGdpVUpQQ1FYVUw0dG9YUmFoM0poS3oxTWR6?=
 =?utf-8?B?NGd2Y1dXNzlRSjJMS0NmRDJ2UFFlc2JTUTRoMW9VTWw4bkNGNGJZY0tqYmU3?=
 =?utf-8?B?TXNMOEx3Rmw2ZEJiR3d0UzE4NGY4dWMvd0FQNDZaYStJN3dpM3QvU21IWk9T?=
 =?utf-8?B?U285djlzbmtvc2pXZmlEcDJtOVJCSWJwbU0rMDZ0eUMwUGovVjVkNkFubUtD?=
 =?utf-8?B?MlhaNDR5a3pGcmdnalE4aGdnMnZjb2NWcXF3dHE0ZjNXZ2RMVlpJcWkrdCtH?=
 =?utf-8?B?dlVTTDZBditncG9IaHR6cklVK2cwQ0ZtL0o5UzdMckxSWVRvZi9maTJQTGNX?=
 =?utf-8?B?NjRraC9MTkdtMmM2Mm0wTDRCTkNOQzN0NGdSbjZpQkVUSGhYUkxHWG93bFZp?=
 =?utf-8?B?SGVLU1hZNTBJZUl4bjllK1RQb1hlSlQxOWhlZWUzQ0VVTzVRS0p6QXlWbWFG?=
 =?utf-8?B?SjFSZHdlS2JkT012SU0za3QwM2F5dldrdU1MemkybFRUcmdlaUhSNER1S3l6?=
 =?utf-8?B?SHNWRytLM3pySllWY1ZxRXg0M2QyRUhkUDRPNlVyTE5vNXlmOTZlRU56UnZI?=
 =?utf-8?B?WVJWc2ppbmlNa2xhT2k3aUhSRnl5UDY1NW82bkhoR3lBazdJbHdEblRYbHBO?=
 =?utf-8?B?N1BhTC9lbzBQdnlZWXRFZUFIRHVqNEdZOFhSS3NZU2UwenU3K1B4RHhVbVV2?=
 =?utf-8?B?NEJqMWNSQjA1M1dnNGY3T3BteldqVGxDVVE3aDE1d2x4OWt5TEVHK2MxK3Rx?=
 =?utf-8?B?Mm4wVXdsZUhMUFVaNExSZ3cyY0NWelNKdjI4RWd5b0txR3ZlM2pQVnMyRGFv?=
 =?utf-8?B?OWZBUHg5SVJOUm5Xb3FnL0w0SFZlVDRzcjZoMDhYYVh4SjJsYXhoZkZBVDBh?=
 =?utf-8?B?bTZMUUNOZ2doMVNqL29jam5LKzM2eEZmZ0dxbmNnTGJpOExjaVNzbGR5Ymda?=
 =?utf-8?B?c2pKaTBlSzZUclc3RXhBVHA4bzVIOTlQY2VYb016Rm1ialdDTkp4ZDExNFlQ?=
 =?utf-8?B?dU42TWwydEVoQjdoR0N0RTNQZU5yZWIyZGRzYVRoTkk4YmNNZzc1VllQcjhD?=
 =?utf-8?B?YUF3bkRDR3IzNlErSmt0N3d0c2VMWEl1bmpuMTlmakh6K2MrNWw0emYyb2Jw?=
 =?utf-8?B?TW9KSXFrcWwwMTdtVGlKazlPeS85UC8yd3djWEpOelB0OHVYRDJTSTRweS80?=
 =?utf-8?Q?krSUsPqEpp7oUJxuNyki9VbBh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8794237e-d2ae-4abf-f485-08dc10687c3b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 16:40:12.8335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qh1uhmISkxijQSRUc3ZLDhV8h6EgvVcM3O8iU6O20g/Ks9JxNvPChclxPPDup0d9rkaAXAbFb++EnYwy3evDoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6281

On 1/5/24 04:14, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Compare the opcode bytes at rIP for each #VC exit reason to verify the
> instruction which raised the #VC exception is actually the right one.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

One minor comment below that is up to you. Either way:

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   arch/x86/boot/compressed/sev.c |   4 ++
>   arch/x86/kernel/sev-shared.c   | 102 ++++++++++++++++++++++++++++++++-
>   arch/x86/kernel/sev.c          |   9 ++-
>   3 files changed, 108 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 454acd7a2daf..073291832f44 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -304,6 +304,10 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
>   	if (result != ES_OK)
>   		goto finish;
>   
> +	result = vc_check_opcode_bytes(&ctxt, exit_code);
> +	if (result != ES_OK)
> +		goto finish;
> +
>   	switch (exit_code) {
>   	case SVM_EXIT_RDTSC:
>   	case SVM_EXIT_RDTSCP:
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index ccb0915e84e1..ec17931bf3cd 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -10,11 +10,15 @@
>    */
>   
>   #ifndef __BOOT_COMPRESSED
> -#define error(v)	pr_err(v)
> -#define has_cpuflag(f)	boot_cpu_has(f)
> +#define error(v)			pr_err(v)
> +#define has_cpuflag(f)			boot_cpu_has(f)
> +#define sev_printk(fmt, ...)		printk(fmt, ##__VA_ARGS__)
> +#define sev_printk_rtl(fmt, ...)	printk_ratelimited(fmt, ##__VA_ARGS__)
>   #else
>   #undef WARN
>   #define WARN(condition, format...) (!!(condition))
> +#define sev_printk(fmt, ...)
> +#define sev_printk_rtl(fmt, ...)
>   #endif
>   
>   /* I/O parameters for CPUID-related helpers */
> @@ -574,6 +578,7 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
>   {
>   	unsigned int subfn = lower_bits(regs->cx, 32);
>   	unsigned int fn = lower_bits(regs->ax, 32);
> +	u16 opcode = *(unsigned short *)regs->ip;
>   	struct cpuid_leaf leaf;
>   	int ret;
>   
> @@ -581,6 +586,10 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
>   	if (exit_code != SVM_EXIT_CPUID)
>   		goto fail;
>   
> +	/* Is it really a CPUID insn? */
> +	if (opcode != 0xa20f)
> +		goto fail;
> +
>   	leaf.fn = fn;
>   	leaf.subfn = subfn;
>   
> @@ -1170,3 +1179,92 @@ static int vmgexit_psc(struct ghcb *ghcb, struct snp_psc_desc *desc)
>   out:
>   	return ret;
>   }
> +
> +static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
> +					    unsigned long exit_code)
> +{
> +	unsigned int opcode = (unsigned int)ctxt->insn.opcode.value;
> +	u8 modrm = ctxt->insn.modrm.value;
> +
> +	switch (exit_code) {
> +
> +	case SVM_EXIT_IOIO:
> +	case SVM_EXIT_NPF:
> +		/* handled separately */
> +		return ES_OK;
> +
> +	case SVM_EXIT_CPUID:
> +		if (opcode == 0xa20f)
> +			return ES_OK;
> +		break;
> +
> +	case SVM_EXIT_INVD:
> +		sev_printk_rtl(KERN_ERR "#VC exception for INVD??? Seriously???\n");
> +		return ES_UNSUPPORTED;

I think you should actually check the opcode here like the other 
instructions, so that this function is consistent and prints out the error 
message below if it doesn't match.

Then you can just leave the check in vc_handle_exitcode() as originally 
specified.

Thanks,
Tom

> +		break;
> +
> +	case SVM_EXIT_MONITOR:
> +		if (opcode == 0x010f && modrm == 0xc8)
> +			return ES_OK;
> +		break;
> +
> +	case SVM_EXIT_MWAIT:
> +		if (opcode == 0x010f && modrm == 0xc9)
> +			return ES_OK;
> +		break;
> +
> +	case SVM_EXIT_MSR:
> +		/* RDMSR */
> +		if (opcode == 0x320f ||
> +		/* WRMSR */
> +		    opcode == 0x300f)
> +			return ES_OK;
> +		break;
> +
> +	case SVM_EXIT_RDPMC:
> +		if (opcode == 0x330f)
> +			return ES_OK;
> +		break;
> +
> +	case SVM_EXIT_RDTSC:
> +		if (opcode == 0x310f)
> +			return ES_OK;
> +		break;
> +
> +	case SVM_EXIT_RDTSCP:
> +		if (opcode == 0x010f && modrm == 0xf9)
> +			return ES_OK;
> +		break;
> +
> +	case SVM_EXIT_READ_DR7:
> +		if (opcode == 0x210f &&
> +		    X86_MODRM_REG(ctxt->insn.modrm.value) == 7)
> +			return ES_OK;
> +		break;
> +
> +	case SVM_EXIT_VMMCALL:
> +		if (opcode == 0x010f && modrm == 0xd9)
> +			return ES_OK;
> +
> +		break;
> +
> +	case SVM_EXIT_WRITE_DR7:
> +		if (opcode == 0x230f &&
> +		    X86_MODRM_REG(ctxt->insn.modrm.value) == 7)
> +			return ES_OK;
> +		break;
> +
> +	case SVM_EXIT_WBINVD:
> +		if (opcode == 0x90f)
> +			return ES_OK;
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	sev_printk(KERN_ERR "Wrong/unhandled opcode bytes: 0x%x, exit_code: 0x%lx, rIP: 0x%lx\n",
> +		   opcode, exit_code, ctxt->regs->ip);
> +
> +	return ES_UNSUPPORTED;
> +}
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index c67285824e82..541a1f87b4f1 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -1752,7 +1752,10 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
>   					 struct ghcb *ghcb,
>   					 unsigned long exit_code)
>   {
> -	enum es_result result;
> +	enum es_result result = vc_check_opcode_bytes(ctxt, exit_code);
> +
> +	if (result != ES_OK)
> +		return result;
>   
>   	switch (exit_code) {
>   	case SVM_EXIT_READ_DR7:
> @@ -1771,10 +1774,6 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
>   	case SVM_EXIT_RDPMC:
>   		result = vc_handle_rdpmc(ghcb, ctxt);
>   		break;
> -	case SVM_EXIT_INVD:
> -		pr_err_ratelimited("#VC exception for INVD??? Seriously???\n");
> -		result = ES_UNSUPPORTED;
> -		break;
>   	case SVM_EXIT_CPUID:
>   		result = vc_handle_cpuid(ghcb, ctxt);
>   		break;

