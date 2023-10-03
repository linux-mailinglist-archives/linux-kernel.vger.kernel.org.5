Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670597B6F98
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjJCRVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjJCRVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:21:16 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F969B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 10:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4bLOR+kNlRN8YJu7GmOChIw99NmfO7Poe9+/bec+0eknEfF8l1vaK2jBHU16/Lgrq059IwsZObtWQjrRZevpacXJgUI9Qrdv1MunpeUab0NyTLnl6gJK0sojj4v2VyJHFfnWDv2cfE3r5ycYOVk75PVAZ5tsB6GCtpRVVz6FTVCDlPEx88h9wR6p84Z3A3G02UHGKLXECMiZOLLf/cnxWCvtHmEgpZKE/3hDVeBWfSSYt9cqqWHg6JfiDaSOiTgPgrSWL64LCoWeSH+e9XRSMYKBFzN65ulIcifKIWimk8j/tfyphyXmaBA2wiueiX8At67XzzV4unzmpuSeUbusw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Reh76MlQq8ZQsiJ6vglZvZvWR0Q2s+VQBdPo5ofCPc=;
 b=UxyAt/Oq1k4HVfq8PpcAAK0+9oR4ql5RhLzbHzurAEA7s/nrAJN/5Xqy7zPr16wWtos0mtZdLOfGJ6Arn5b3Xemb2vxnlIyoiSEt3noViCr5hAnVieMzB4MjztH26oT176EAyvfTf6z2Re89cEMXCsaDeIyAs1LmV3y+y4GHcYqvp8gffG0dLycPjxdM1EacM7DFUeD71yktHsPrXcsMqwzd/a2GBV1/wKP+Atc3+nZBrfIG3Y6MDwjV8lRlxrktLX0AfhZpeyXJTCOmnTCXtaHvy8HKtEZwRE5HNeqNq0QQBAA0cuF8yCvIuxGbWnBbW2j8lZMx8e/jtQumsr6HGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Reh76MlQq8ZQsiJ6vglZvZvWR0Q2s+VQBdPo5ofCPc=;
 b=xaYT0K3tGfYGKuFmIMXS9o9HsZJnv+wIlxPsUyxALnz0QUHrL4Qy4v1A17ZVgMQg1LOLOdBMU+7+phg4ZGsMszCmcB3wqztzOWU4scQ+P1trRfwlAMasOv9xq8V+BriwOAY1TZ4orlItTOreoj9bSdY3ZsaYlLmZbwKOJbRWZGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DS7PR12MB5814.namprd12.prod.outlook.com (2603:10b6:8:76::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.26; Tue, 3 Oct 2023 17:21:07 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2b54:7ddf:9e2e:751c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2b54:7ddf:9e2e:751c%3]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 17:21:07 +0000
Message-ID: <32c0080f-1bd1-32c4-2bfa-910537a50ca8@amd.com>
Date:   Tue, 3 Oct 2023 12:21:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH kernel v3] x86/compressed/64: reduce #VC nesting for
 intercepted CPUID for SEV-SNP guest
Content-Language: en-US
To:     Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>
References: <20231003073123.1763564-1-aik@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20231003073123.1763564-1-aik@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::15) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DS7PR12MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: 09586c05-8fcf-4ff2-0be4-08dbc4352136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+Wkolgnh2PvELfbmTqCKSIAQSp98xlbAC2QS3NsPdgx+8rjAqzdkQl69cUF4t6GIlIDUPjC1RJ382MEi6a4is1UsAqVRj+xfzzitYTz37g1KpO9dYBvXMdE12ta96lod9x+zAiXxa9AL01OjkIVVz7N3E2QwH7enlhhFkdxYE5NzKJ5q4zQKKmV8PrA2vLhYZzYR83fWF1LIDmXR46VjU+yig7reKsVJ2ZJrEVAEEbIBW1HTygoNf+yD97biNq2eujJZWijwRr8Rxsrb/jxCzKq1k+gSkxmcuEFQelcEIH8+b0Wzkz9BMpOtTlT0RSgLfoX5Nz3bpWcgdOIWLbKvyYJ+U3crHZaSThp0fyEZ6Z/Wos2nXH4DwMQaiIDLhWXBY0Hl+4o66PZbuOpzxbA1IKVu0kN0n2qZQCDcEysXNvsJYA7+iihr14eSI6tddeBA+SE1HQGh28ASTudvAcSGnTM9HaeAjpV0z5oBkro8tg1ElpZsYv9L1UMeHpgIv6V/PaG+6oE5yQGVubTExjx90x2GQMZJFAP+1/9kL5lw5oD7EKBsa2JX8wPSth0V8r0g9hM7W699QbBPmlxkmssugzKlf7ppgxtCyRMrJGW+GvYnUxdpqmTOPm7oM5Huk7/OJZmS5Yg4m7+1IJ/YKYObQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(8936002)(2906002)(31686004)(5660300002)(4326008)(26005)(36756003)(8676002)(2616005)(316002)(41300700001)(66556008)(54906003)(478600001)(66946007)(66476007)(6506007)(86362001)(6486002)(83380400001)(966005)(53546011)(6512007)(31696002)(6666004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGpWNkFITHB2bGE0Um9KVFVoSC9jQ1pjRDBpRmlxSVc4TnJrM0Z0KzUvVS9Z?=
 =?utf-8?B?dXByZExTR3lrUGk5VlhUSFJ0ak5nZ0sxellaMDhXS1djTkhDV3F0NWdTcyt5?=
 =?utf-8?B?R1RQNnlqNzJ5cUpoNmFBdHRNWlNaRVBMc0VEVW13dXlGbzNibTlhZlB5NmRF?=
 =?utf-8?B?V0NPZmZncy9oRy90SWhyLzBYMmNwaDJTTGlJejRvRFdaa1UvZENZcWJ5UGt0?=
 =?utf-8?B?OGJ5eThmZHdodkJQbk1mMFNSV3Z5UHdRMDRNU3Fpa3Bpano5NW04TXJ4d2ti?=
 =?utf-8?B?UlcwUWZMSFBYeFJtY0c2VS96b2l5V1hvZDZFc2hGdnpWRmhOWm9rQXFpS1FG?=
 =?utf-8?B?VFlaM2Y0VlZLWUYrblFucitydndXOElDVGxVNU5vaGFBNnh2SUlDaWcrUHBQ?=
 =?utf-8?B?RGlCWDRFVWxWYXovMHAzU21HQ1lqdkdIMnY4VDBuc3hRUUMxWEFFdzVIVllR?=
 =?utf-8?B?akYyeSt1RHJjY3RoaVNQQks5SU90YW5pd1JhTkRyUVowMk13RjZwaW1TdzA3?=
 =?utf-8?B?dUJycDk0SGtoV1oxNmV2eHFuRktDYU9wd1Q5NjJHQnZScnlHOTgyTXNFaHVt?=
 =?utf-8?B?UWF4bXRxZTAwMkpLTWMvR2pRME02am80SkdjL1Z2dHY5c1V3T2NQUW02OTFC?=
 =?utf-8?B?NFVHczh2SFloQ25ZcG1LYnhDUDAvaXVZdFRXZlBtVnpkRGkzWnRwVWhFS3JC?=
 =?utf-8?B?T1RLSmx3V2d5WWJnamdIV3JDOHptRUU1UExPZnBoN2dTYmdYeGszNXNrRmJJ?=
 =?utf-8?B?MGdpU3kwYnRaeUd6VnFPUFFnTDN0em81R2JkTTJwYmV0L0ZYL2tMTC9sbVhM?=
 =?utf-8?B?UVE1Zmt5aEsxSjRoRmxBUHVQTDI0ajBwQVV2VFd2RFM4c25NRytEUWlGdHBT?=
 =?utf-8?B?MmtFQW02RGxzVHYzdSsvUnRoTi92WjRzWERCc1RNbHBjenlSWWN5QUF0SnBx?=
 =?utf-8?B?MHNRZTRZTzBJZEs4WFk3ZnFuZ2FiRVpEYVVkVm9lMGJPdlJ6R1gwSGJxNFEz?=
 =?utf-8?B?UUZvQ3l0ZDYvdk9zbzk1MndqN1VXSmU1ZGt0b3BIYUpQSFV3aHVoYjlwL2J3?=
 =?utf-8?B?RGRuTHNsa3FhRUsweEdjTGFYVkZ1NWE4QlRjRXluM0xnQUVvVGxaM3ZLNWU2?=
 =?utf-8?B?aHpqd01Qek5HWVB1QjJHSE5oS0lRMGxKR1N4TzVZZklielA4UDJqTFpwbVVh?=
 =?utf-8?B?NHJQdElBbFNhTnV3Zk9xVXR6MkljZ1lDSjMzSFB3cU5NemtoVTFPWlMrY3dN?=
 =?utf-8?B?aGhEbXdhbEJUMklBa0pQbG1kdWhwNmFqeWpIb0NYdzNCaHBWTXBkTlcxeEZF?=
 =?utf-8?B?aWVHRngyZUUzand0c1NWTnRRRVdmbjQ2MmpjUjBPUk9iQkJ2am1KZFozblVa?=
 =?utf-8?B?MEd5QU90RVR1QTBDMDBhTkFDNEFNcGM1OHhJVlQ2UTc0WGFudnY1OGFvL01R?=
 =?utf-8?B?dURRWlpQY3BBTWtFMlI5ZVgyejd4Z1FTMDNGRnRIbE5ERWpyVkJPOTl0SUU1?=
 =?utf-8?B?WGd2R2FlTDl4d2pPR2JHcXk3ZWN3VnB2QkpxN05abWNicVNNYVg5ZE5SL0pU?=
 =?utf-8?B?ZHIzbU5lN21EUXJPRU5Gam9kMUdWdzExeS9UZnNJZW9JY1dkenh4OXhMaThQ?=
 =?utf-8?B?cGx3ZjV4M2wwbDlLL2l0bnVST2xERi8xemsrSk92blpQdFVGbWdsclZQWUtS?=
 =?utf-8?B?dHNSR0Jaei9mM3I3Z1JJeGRoZHZKSkhjYTF3dFVsdXFzMUNTby9xZzRtM2ts?=
 =?utf-8?B?RHltMUtESUszZnBNS0gwNk93bDViQ0VhN3ZyUC9taVlTbGkwRzBHNjdJZmhI?=
 =?utf-8?B?QVU2ZU54OGhnejBTZ3Vwb0h6d2ZUZVFmZEwxMWlvbEJXaDFlMDhDQ29nRERa?=
 =?utf-8?B?cGx0RWJSUEVBVFd5bkxleDZ3bUhlUS9vdkNFdTNXMFM3R2RQaElCVGNOM0tP?=
 =?utf-8?B?eks0UitVUW9xYmpBZklJVy90ZFM1NHNrd0NKSEJkMWV5TDc5Tkg4VnRUdDdQ?=
 =?utf-8?B?cG1SNU5UY1FIY0R2aTYzVmkzSGUvSkIvN3VTeGZYcWMycXlxRDFJSnoxdHZ5?=
 =?utf-8?B?d25LRnM4UXk3QTQyWTVuZE5KaDFBUWJLbTVpSTNTZGx2OHhUWlNjOXplS3RQ?=
 =?utf-8?Q?koJEZo1O481DuGtWXa9+Q5mTH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09586c05-8fcf-4ff2-0be4-08dbc4352136
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 17:21:07.4628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8fMw/hKlQjYua3ygkUUluiISrotjLn+3nnluLLSslGqET3kUv2UHZ0BA5hW8x8r6XSmV0+ypVAcLUJQB2dE9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5814
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/23 02:31, Alexey Kardashevskiy wrote:
> For certain intercepts an SNP guest uses the GHCB protocol to talk to
> the hypervisor from the #VC handler. The protocol requires a shared page so
> there is one per vCPU. In case NMI arrives in a middle of #VC or the NMI
> handler triggers a #VC, there is another "backup" GHCB page which stores
> the content of the first one while SVM_VMGEXIT_NMI_COMPLETE is sent.
> The vc_raw_handle_exception() handler manages main and backup GHCB pages
> via __sev_get_ghcb/__sev_put_ghcb.
> 
> This works fine for #VC and occasional NMIs but not so fine when the #VC
> handler causes intercept + another #VC. If NMI arrives during
> the second #VC, there are no more pages for SVM_VMGEXIT_NMI_COMPLETE.
> The problem place is the #VC CPUID handler which reads an MSR which
> triggers another #VC and if "perf" was running, panic happens:
> 
> Kernel panic - not syncing: Unable to handle #VC exception! GHCB and Backup GHCB are already in use
> 
> Add a helper similar to native_read_msr_safe() for making a direct hypercall
> in the SEV-ES environment. Use the new helper instead of the raw "rdmsr" to
> avoid the extra #VC event.
> 
> Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers")
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> ---
> 
> Based on:
> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-urgent
> which top at the time was:
> 62d5e970d022 "x86/sev: Change npages to unsigned long in snp_accept_memory()"
> 
> ---
> Changes:
> v3:
> * made it a function, mimic native_read_msr_safe() which 1) returns value 2) returns an error
> * removed debug backtraces the commit log as these were added for debugging and never
> appear with actual kernels
> 
> 
> v2:
> * de-uglify by defining rdmsr_safe_GHCB()
> ---
>   arch/x86/kernel/sev-shared.c | 27 +++++++++++++++++---
>   1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index dcf325b7b022..494d92a71986 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -241,6 +241,25 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
>   	return verify_exception_info(ghcb, ctxt);
>   }
>   
> +
> +/* Paravirt SEV-ES rdmsr which avoids extra #VC event */
> +static unsigned long long ghcb_prot_read_msr(unsigned int msr, struct ghcb *ghcb,
> +					     struct es_em_ctxt *ctxt, int *err)

Alternatively you could return enum es_result and take xss as a 
parameter... six of one, half dozen of another I guess.

> +{
> +	unsigned long long ret = 0;
> +
> +	ghcb_set_rcx(ghcb, msr);
> +
> +	*err = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, 0, 0);
> +	if (*err == ES_OK)
> +		ret = (ghcb->save.rdx << 32) | ghcb->save.rax;

You should check ghcb_rax_is_valid(ghcb) and ghcb_rdx_is_valid(ghcb) 
before using the values.

> +
> +	/* Invalidate qwords for likely another following GHCB call */
> +	vc_ghcb_invalidate(ghcb);

We should probably call this on entry to the function, too, right? Not 
sure it really matters though.

Thanks,
Tom

> +
> +	return ret;
> +}
> +
>   static int __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
>   {
>   	u64 val;
> @@ -477,11 +496,11 @@ static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
>   		if (leaf->subfn == 1) {
>   			/* Get XSS value if XSAVES is enabled. */
>   			if (leaf->eax & BIT(3)) {
> -				unsigned long lo, hi;
> +				int err = 0;
>   
> -				asm volatile("rdmsr" : "=a" (lo), "=d" (hi)
> -						     : "c" (MSR_IA32_XSS));
> -				xss = (hi << 32) | lo;
> +				xss = ghcb_prot_read_msr(MSR_IA32_XSS, ghcb, ctxt, &err);
> +				if (err != ES_OK)
> +					return -EINVAL;
>   			}
>   
>   			/*
