Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712037AF2F2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbjIZS3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbjIZS2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:28:54 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A08E10DA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:28:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pkl/GMAhSqK4jvqMG1kgxzAPzvlmExc2JU3Lu+NbmU4lOmx6qmV5bR5T4npI/60hDaMBV/12fM10nqyPLrQzMTVuRF2oxczwoGYmnLqVezg32/c2Shn7R504XRadsq93bfQucywnrEr1rSCzcMQWzUySGzilINN3Kw8lcfho9ipiEKNUHGwlviyMJjuu4cexJHbnoDLSe1WmPdzqo84CILqgyj32bwjBAaBb1Ri+vSOvneCwf2tXtg0rEnG4Wznl1mtZ+0Wh1PbratilhNk7uADBX0YnIxqVpGJSD0Vm4hRvAyu1abUuhSPJC0aKK9ckrh3dfSOR56kjmJ3ZEFiL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubAQOMEUx4BG1QsqAaSDoD90QFff7DxJDWQlhmXIqp8=;
 b=b/hlI1RkAUO10vwBamsFHe6UfpCWXJ8wRP940Cp/FTthTjALwWtJ8zQLDwgCXminQgTVyLvoIb89LvHSbGkVWqG7jrkhYzotODnjtJkWuqqvDfJ5JY1Du+uqBCMR2KGEPsIIo9fTLp7rLRISEBApSkTnanNHBteogRLvr9ZpEeptmOpZD/lI2fjYrpxbmon72Bg0P4suH3XEM6t6c+3hI0mEpPFoTvFWdBXY8+imn/WhAujrLZz3UepWTcoob7Rsn1Dz4UqeQoEuqsFsdgpEZNNE3kMkiJzQcbOad88eAjg/lTdGHKJJBtpvx/z6h1Ym+I1m8FmZsTRM+XqUGwcRJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubAQOMEUx4BG1QsqAaSDoD90QFff7DxJDWQlhmXIqp8=;
 b=DIFgWnD5HaUtRCcBlH2dqyZ5mygR7d6OjXfgWpfLPdv+xzhbQyaJOnwnm5Oz91/7Hw52WNIo9bEWTOYe9clLN6dYTDq9yuS2S3C+r9MrpDbYH2WnQVCcW6RfDtk2qbOGxFfJG/7ew1DJHTcKvBuyTkPucubgVKskrEoMgViseNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by IA1PR12MB6353.namprd12.prod.outlook.com (2603:10b6:208:3e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 18:28:29 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2b54:7ddf:9e2e:751c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2b54:7ddf:9e2e:751c%3]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 18:28:27 +0000
Message-ID: <5358f872-f606-e5b6-3e34-4daead5218dc@amd.com>
Date:   Tue, 26 Sep 2023 13:28:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH kernel v2] x86/compressed/64: reduce #VC nesting for
 intercepted CPUID for SEV-SNP guest
Content-Language: en-US
To:     Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>
References: <20230926040526.957240-1-aik@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230926040526.957240-1-aik@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0218.namprd04.prod.outlook.com
 (2603:10b6:806:127::13) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|IA1PR12MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d7fb52-80da-4f86-a746-08dbbebe5fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e0UVg2HqqaaDH6e2QX7JNrYgjJUEjn9xendYZU0Sef5ZP7yznugVhvtRLQNTzqnUW3Q8jDnnQUzRPFnJLX03WvFcAcPNRvUR79SR7z5NYYKUBFDAmgOr+j5Wg+DSk5ugWMJ2rJcrkfQRI/z8oyW+8WASqMoRTvClcZyl/kmf8v88qfI+lEpocoD6zWHlikakbmlWxZY+1LJwsyiPqXK7BdUPGrzycyd0Rfu8e2d5hcWtNB+5kCM6P+Sqb9+7uEfV54KxrgPxLp1lFTE0g84dxUaLx7NxhAEu5QFa7PpmkICzIxL1kpAsfU2IqoXYAWSnBewhkj9pOfJiXNPdI1RC0EGHtRiY4FVZuRmspGSftQgFh0SsX5pjYvKV/BdCzhaV84H9VkmlAEddRpGUswcTO4HBPEqoC4VHX1+iqLMQeZD34at/jPsOoLXNlQ36LFwRvAaNc9Wi9ZT+jml33aMKZ42MPyUS5Ob0Y5UTrO1huGmF6f3yX1WBvTWSidNVb4nJEqH0P6OdqWUIVgANnbdPC05v+G1HAQcQPhIGE0JrzZIFOS/xdXsqJ7z2loaJeuoEtSPeuhpRzCp0YrmFssK+5Oo4emlwSQ9lZtzSDTiNgfTJ/Mc1CfHET01i2AsguxKHzzEM5plpUP86DWq7zyA2wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(186009)(451199024)(1800799009)(6512007)(38100700002)(6486002)(54906003)(83380400001)(6666004)(66946007)(31696002)(6506007)(2616005)(478600001)(86362001)(26005)(66556008)(966005)(316002)(4326008)(41300700001)(5660300002)(2906002)(8676002)(36756003)(8936002)(66476007)(53546011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2dkSjEwZ0hPaUpSUUtVNktVMFVEM1BXNFVBU0VlNGNXYjBxRTA0MXpwMVVz?=
 =?utf-8?B?bGM3Yk4zem16emp1US9zdUhtUXpYNEhhNWFKU1ZWVld0Q3RrMVFaU3pvbW5B?=
 =?utf-8?B?eHE5TXpLYmRiMEF0NFNGYSsxUjJJdm9uQ3hGYWpkOHlJQnNibGhMZ21HK1lj?=
 =?utf-8?B?VGVtMHNORU1xbVF4RERxRnZkZTVONk8rVUYreFo5SG5JUDRodGJjYXBSV1hF?=
 =?utf-8?B?eGRkRk1ScENvK3N4OVhBa2RlVCsxN2wxVnVKeEdJMGttMlg3aWJ0Y0RwMC8y?=
 =?utf-8?B?bnk5Uzgwa1hXV203TU1ZeTd6ejcwckRhVldHOUVkT1Z4Rm5xSzlacXEvb25u?=
 =?utf-8?B?ZytOL0ZrWVJVVCtTaFhPdFcrM3lmZnUxVElodjFTcEV2NW51RjlOUU41K0U3?=
 =?utf-8?B?SFBTbXlGZzVZNFRLZkdFcU9wdUFSYmtJUHB5TlhmbERiSi85SnIyNnZXK2dT?=
 =?utf-8?B?amY1ZG1OSk44NlVPSkNLRmFLdkc3aFRTZ1pKajZkTG5GbmJVdjJyL1A3c096?=
 =?utf-8?B?eHpVZ0w4SUVLbWh3QWxGbXpTaitycFhRdnNEQXN0Z1pkNVJLZDJmUmFZV20y?=
 =?utf-8?B?enBvWTdiekh2YnRyT2dRRXVaZXdCRGx3MlFsNVU0VkNvZWR6ait1UTNlR0xa?=
 =?utf-8?B?a0xzYzlRVDluRE1RZ2VuYTV5NlhuVDJMWFIyblFpSEI0Y1hGeDQ1djZvRnBZ?=
 =?utf-8?B?bUdDdFlGQ1UrU29kZG1scUd3U2ROeDBNWFM0a1lUdXBHK01hZVphOWxPL05C?=
 =?utf-8?B?WG9ldHlnWFI1ajN1S0k2OWFWZUF3WGdtQzlYUzllMzRoTFBDSVhJY2hZbjBP?=
 =?utf-8?B?RkxTZ2pXcU5zR0wzME0rdUdSWDZtejBMWis2MjVqQm9wdlZvVFlDeGwyRGRa?=
 =?utf-8?B?K2d6YXFxNGFCa1lKV24vU2JTM3JDTk9BbWNsKzJkbURVVnlDL1gvN2tLeXVM?=
 =?utf-8?B?S1BGTkI1RjFyKyt3OWQ2SVVjL0lNTGF2RVZ4MCtBRTdQdEN3Y1o4V1BsNTdj?=
 =?utf-8?B?QTVWNDIwOG9SRnVtRXd0MVNieFl1UGhnZUR1ZHNKN2t4VWpienNHREVHZ1hv?=
 =?utf-8?B?UVd2MmxFZis0WHZjMVlxK0FWSnpyQk5oYTk4K2ZYdnlYR3FYd0RtdlZpSHU0?=
 =?utf-8?B?WlByazhpOEVQVDU1R1B2by94OXVsUG0wRFBYaitzVGhrY3FzenJvUjFwa0F0?=
 =?utf-8?B?R1VMcFp2aXhFZVhPblVuUWVLMVRSNjY5azBzL24wMU1TUjBJZWthOU1QVE1r?=
 =?utf-8?B?ZkxBTmFDcG84N2hFa2loQVBmQVJXZFRhTFV4REo5UDNabFJBT1cxaEh5eFRH?=
 =?utf-8?B?THNWKzhsTzFRYm9nanFncTI4WGk5eFlUNlNHN2tIckg2OGk1ZFg2endHNlp6?=
 =?utf-8?B?SkR2RUxZKzlVMjIyZWlxemlBbVJYMHV6dXNCTTE1M1Foc0ZlWDIwVVB2Uiti?=
 =?utf-8?B?U0VFdG5HdlZTRDRPWmFNcDBrQ2NKMEJEM0U5T1JjV3VMOCtKRkZvNlRjaC9U?=
 =?utf-8?B?cE5RbmZ0cHBJV2R0eE4zYllOWThPZEcxaGZmNWR3REJ2ZVhkSmlUdWVsZEVa?=
 =?utf-8?B?Y3RYOGhvZ2drQUlhK3J6UEN6YVdmSlVLL3FGOEhVRDRyQktTTkx3cEkxTWxW?=
 =?utf-8?B?UmFnRk0rSkt6SURSWnpHZ0JnY3FxVUhtejNPajIxakJpWlBkL1k2VWpFd0Fa?=
 =?utf-8?B?Y3Y2T21DWnJPQlJvYUQzRFZlVGt2THpHeTF3S1IvSGpPb3d2dnRCOG4vRTkw?=
 =?utf-8?B?N1o0dTBucEl0OStLb2tnLzRmalA0bHlYWHUzT2RDQVpqOWlWUjIwS0IwcG0r?=
 =?utf-8?B?NXoxaWVIc3I5b3FoZkpxbU5GWHdQcUgydTI0Q1NLcHJZWXNYMXRIa2h2aXNX?=
 =?utf-8?B?bUEwK2tGMEtuRjlyMFlaOHFJMWNTM09jYzdxT3NncVFESER2eEN1RCsybG5s?=
 =?utf-8?B?b0tOZ3dHTDIvakFVRlBjaTE2dmUyMlZTbmNJTGtFRHZxYTJJam1YWmRxV013?=
 =?utf-8?B?NGxvN1l6WHpHbk40MUtyVXZ0L2dFNDN1Z0prZ1Brb1h1ZzdhTGxRSC8vSG9w?=
 =?utf-8?B?b3A4bWJyajY4V05UMCtOU1dyeHIycXV0QXdpVW11amQvMDh3VzdhcExVVjJ6?=
 =?utf-8?Q?mVqCfJ/FzFA7kbxQ3DgPmZKIu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d7fb52-80da-4f86-a746-08dbbebe5fc4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 18:28:26.9163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBIhjCMLDxkoCYh25RSePMj/NrkofAlBNQt0VsWjYjjpzut5xEQhQjCUOtRYVyJC/aHHNfn91eQu3RiM85Q8Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6353
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/23 23:05, Alexey Kardashevskiy wrote:
> For certain intercepts an SNP guest uses the GHCB protocol to talk to
> the hypervisor from the #VC handler. The protocol requires a shared page so
> there is one per vCPU. In case NMI arrives in a middle of #VC or the NMI
> handler triggers a #VC, there is another "backup" GHCB page which stores
> the content of the first one while SVM_VMGEXIT_NMI_COMPLETE is sent.
> The vc_raw_handle_exception() handler manages main and backup GHCB pages
> via __sev_get_ghcb/__sev_put_ghcb.
> 
> This works fine for #VC and occasional NMIs. This does not work so fine if
> the #VC handler causes intercept + another #VC, if NMI arrives during
> the second #VC, there are no more pages for SVM_VMGEXIT_NMI_COMPLETE.
> The problem place is the #VC CPUID handler. Running perf in the SNP guest
> crashes with:
> 
> Kernel panic - not syncing: Unable to handle #VC exception! GHCB and Backup GHCB are already in use
> 
> vc_raw_handle_exception #1: exit_code 72 (CPUID) eax d ecx 1
> We lock the main GHCB and while it is locked we get to
> snp_cpuid_postprocess() which executes "rdmsr" of MSR_IA32_XSS==0xda0 which
> triggers:
> 
> vc_raw_handle_exception #2: exit_code 7c (MSR) ecx da0
> Here we lock the backup ghcb.
> 
> And then PMC NMI comes which cannot complete as there is no GHCB page left
> to use:
> 
> CPU: 5 PID: 566 Comm: touch Not tainted 6.5.0-rc2-aik-ad9c-g7413e71d3dcf-dirty #27
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown unknown
> Call Trace:
>   <NMI>
>   dump_stack_lvl+0x44/0x60
>   panic+0x222/0x310
>   ____sev_get_ghcb+0x21e/0x220
>   __sev_es_nmi_complete+0x28/0xf0
>   exc_nmi+0x1ac/0x1c0
>   end_repeat_nmi+0x16/0x67
> ...
>   </NMI>
>   <TASK>
>   vc_raw_handle_exception+0x9e/0x2c0
>   kernel_exc_vmm_communication+0x4d/0xa0
>   asm_exc_vmm_communication+0x31/0x60
> RIP: 0010:snp_cpuid+0x2ad/0x420
> 
> Add a helper similar to rdmsr_safe() for making a direct hypercall in the SEV-ES
> environment. Use the new helper instead of the raw "rdmsr" to avoid the extra
> #VC event.
> 
> Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers")
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
> 
> This is made on top of (which has the "efi/unaccepted: Make sure unaccepted table is mapped"
> fix for booting SNP):
> b996cbe1203c (tip/master) 15 hours ago Ingo Molnar Merge branch into tip/master: 'x86/tdx'
> 
> plus:
> https://lore.kernel.org/lkml/a5856fa1ebe3879de91a8f6298b6bbd901c61881.1690578565.git.thomas.lendacky@amd.com/
> 
> 
> rdmsr_safe_GHCB() is in arch/x86/include/asm/svm.h as this is where
> the ghcb struct is defined.
> 
> 
> ---
> Changes:
> v2:
> * de-uglify by defining rdmsr_safe_GHCB()
> ---
>   arch/x86/include/asm/svm.h   | 14 ++++++++++++++
>   arch/x86/kernel/sev-shared.c |  5 +++--
>   2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index fb8366af59da..866ef7d6b7a9 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -673,4 +673,18 @@ DEFINE_GHCB_ACCESSORS(sw_exit_info_2)
>   DEFINE_GHCB_ACCESSORS(sw_scratch)
>   DEFINE_GHCB_ACCESSORS(xcr0)
>   
> +/* Paravirt SEV-ES rdmsr which avoids extra #VC event */
> +#define rdmsr_safe_GHCB(msr, low, high, ghcb, ctxt) ({				\
> +	int __ret;								\
> +										\
> +	ghcb_set_rcx((ghcb), (msr));						\
> +	__ret = sev_es_ghcb_hv_call((ghcb), (ctxt), SVM_EXIT_MSR, 0, 0);	\
> +	if (__ret == ES_OK) {							\
> +		low  = (ghcb)->save.rax;					\
> +		high = (ghcb)->save.rdx;					\
> +		/* Invalidate qwords for likely another following GHCB call */	\
> +		vc_ghcb_invalidate(ghcb);					\
> +	}									\
> +	__ret; })
> +
>   #endif
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index e73c90c9cc5b..b3fb9d0a07c6 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -479,8 +479,9 @@ static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
>   			if (leaf->eax & BIT(3)) {
>   				unsigned long lo, hi;
>   
> -				asm volatile("rdmsr" : "=a" (lo), "=d" (hi)
> -						     : "c" (MSR_IA32_XSS));
> +				if (rdmsr_safe_GHCB(MSR_IA32_XSS, lo, hi, ghcb, ctxt) != ES_OK)
> +					return -EINVAL;
> +
>   				xss = (hi << 32) | lo;
>   			}
>   
