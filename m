Return-Path: <linux-kernel+bounces-22818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 565BD82A350
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6391F23999
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9344F88B;
	Wed, 10 Jan 2024 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BhtImvQM"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED534F881
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTevLgT0Tjn/oG9b8y5EC3Pmsfq3bvRSkUSZCtIQv3ssigGtWFnwbsvQvjPlXrEtOrFR+TWoiuXcSJh2fYOvI/eLxWbogrJy86xsrQPoSHpMtNZZBmh1xDBg1FQhRrNhdncLBLHa4hiER8mbZNcYKEOaxFTrlMB6yEBk5ykkYzm5I0h9zLMPEwWKGYI9yAMA0PtVyPpbld09H+kZccsAXoR2vmbuRxdHiua1qDEY5TnEeuwakeNIL0GPJtMC7dISmCf0/J+xkOCINRW3cfL/fSFIacuziK9nVCbujLokstAhurKkNTm1nS70vFfwr0fXFAFlpGQh4CDr2dcV/rls6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EdtsvJBJxu4SP4qGgDY4CjgRKodlKU5nFLkP8ZWXLA=;
 b=jQXrbfjn/vdqFZ+gWR9At5EnCiI3k5bUrng963/CWQCoJd/q/wB6k5sLIvw7MnD35t8QLBeAZu/DrwMZm0cg2hCejA+Mj0PylDO2oCaMW8JHn1WtqZabsT+alIEnQanXvJbTZCAA4ZJxMsnyqn6E+QTkUEkUIRJ3xoyLPQvqzPNeQF5ajDcpixq2VsVi0PFlmAi/276D7i1bPh/O+9b1KUX8vzRODQn71TUUm5nKPb2WvozSJ7VlBJG0CV9t9THbGUeysRAER1svrheyAjWrVlImKxQdsI2nln3N3BUCNmtpPjFnILRMSsWesty7Ova/jckMTMyuRjKhEeG+IvEKuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EdtsvJBJxu4SP4qGgDY4CjgRKodlKU5nFLkP8ZWXLA=;
 b=BhtImvQMy5nID0MfTxklFrCttVEiAJTHajsSUiTYxAlZXbG08PgWSr91kj5zchWidZM2JclPpepq0zB8QvjfXwnATE3oRfMHo5KmnFeKCGnXXuG+KfdCWcNwpznEYsfQNXdZ22A+DgKwipA5+XPqFK+jMS5WWq97gSoKsNbda40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CH3PR12MB7569.namprd12.prod.outlook.com (2603:10b6:610:146::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.25; Wed, 10 Jan
 2024 21:33:15 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c%3]) with mapi id 15.20.7181.018; Wed, 10 Jan 2024
 21:33:15 +0000
Message-ID: <8d443374-1b3b-4099-a306-5f9e0fac7851@amd.com>
Date: Wed, 10 Jan 2024 15:33:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm: Fix memory encryption features advertisement
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
 Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
References: <20240110193514.15620-1-kirill.shutemov@linux.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <20240110193514.15620-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR18CA0008.namprd18.prod.outlook.com
 (2603:10b6:5:15b::21) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CH3PR12MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d66f9b2-fc3b-4a68-7eb5-08dc1223c111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SxOK9Q2kgTEgTA7MIhqFQjUotwTQqgNh2WnQd2/O1OpiQhpi1aBhBV/8zUmIkXBut88CtHz48eHmAAUQ18JABmRDmawefD/Y+j1x7cegh+0bDn2cO6pvbevhRcrVtOaEV8QqlM4PAtKOKIYNhqTe3k3Ui7sFsdS9JpZbW9V9unUidc3nwUMoYO2wj44YZLvQ3uNVPBvm/NujpMIWANU3AGi02iGJ+bFrO/8TefkVOp3M1xYPzPeAGOem+g1/j6kmJ3Gy5ENjfhF67UgZMhiPjwGPqsfZFyYNNKt0++VSco4v8aksAvGycWuk+EMkJiVuRVVpggW748O7DHO4s3g27nZBFV393xvDrhTmyLok2p9/FfgVEroPyQcZU0NS5JT2bDUHMlN4kEOMoxfuB5VSd0wIMWQobdIGsx5ZYUgCUDSTwmvEoN6c12BZUy4qHBwt18DqcuAvqJi5SbBabEbjy04/KftTGKmYMeh4ZzaNzNMo9RW8zpU2R7D/tf+Y7TLMBaL8nOsUuoybC3sRJ2YhMcDfDB5JKeiWqyTAv2Uj6iLleS0i/jafFkBS6Gao6KaDbf3CgAz3aJJcDp7+tbM/WoazPBRQx1em7uSnH6yvyPr5rHkmIBzM5lASQClGciXLtvf74A5dGHKitVTZ8kwFxw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(7416002)(478600001)(5660300002)(8676002)(6486002)(31696002)(6512007)(45080400002)(86362001)(6506007)(2616005)(53546011)(316002)(66476007)(38100700002)(66946007)(41300700001)(110136005)(54906003)(66556008)(36756003)(8936002)(26005)(83380400001)(4326008)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWNXK3RXWnJLK2RrLzBxV0hnK1QydXJVc3RIRjhjQ3hkNCt1U0NKSWp6dFJs?=
 =?utf-8?B?R01OQ2N2L29aT04zUFl2bStVS3Z2SEJsZkVhN3NlSjdEYm1IUG5qaVB3QWc1?=
 =?utf-8?B?aHhQK25jRXFxWEVDSUkyeGxEekxYKzNGb3Z5ZXBCc2NjNlRyZ2NXNXJCbVo4?=
 =?utf-8?B?TVRZeEs0NHdHd1ZjQkR3NW8vQVNIc0pzT3poYTRRdkxxWk83MWlaZUJISDRV?=
 =?utf-8?B?dTZWN242TGxMcStYdGIxZkRUWFlXRG5pTE9rTnFUaDkwUUVwejBGc0Rubk02?=
 =?utf-8?B?ejY5ZGdSaDRKQXZkT1U5NHdZby9EMHJBRVhHdUQvamZSbnNodExOazI5SmVL?=
 =?utf-8?B?V0pmd0NxeG1TYmV6VzZDbjYySjBtZUtmZUg4bXJnbGYrdGgxZjdRZTlnMGZk?=
 =?utf-8?B?bWNPS2dEOGlWL1QvNlR2RzVzbk84dkRCRlMyd0J4NEI0UllLcmg0NWtBdlNm?=
 =?utf-8?B?THN3U04wSHNleERuOThIa05GMjJYeUU2L2pDeDhHSFhIdE4zU25YenFEOEt4?=
 =?utf-8?B?ajhnWjB1OXNnWm83bTRzV2Z6ZzF5c3RUUEFDNW51V0hNZEMvMDB5OFNzWXlB?=
 =?utf-8?B?d3oyOXZ2WFZhREZuSDQ2ZnpnMVR3dkF6c3plYnBhUGpTS0ZHa0RLTmhvQ0d6?=
 =?utf-8?B?WEFkQWRxaHEycHozT2RrbmNwWEcxUUtNUzJxbUdkNGpOTjZXMEpmazFmRnZF?=
 =?utf-8?B?cW9ROS9Zcm1iaWtyaGVwb1g0WldPdWZuZVpnY050aFdKL1RpS0cxSTNRU2Qv?=
 =?utf-8?B?azRGUWpjSWtPUjRzcDFSOEgxaHdqcFRRTWVhUVk2SUVnQW4xSFNvUks5c1o0?=
 =?utf-8?B?OFlSWExVN2RrV2VuWmhNb0d0M0hJaTMrZURXS0NBcDhseDVHMEZ2Rk5xcExC?=
 =?utf-8?B?NEhZWmk1QXA4cWZPcTIwMllwSnZYODVIMkRYNmhjN0JubUFEZHRGQWsxVEVN?=
 =?utf-8?B?SmJFT242bzZrdjFXU2E3SkJsMUoyZnU4dGRvZlBJK3hadjZHWFZLSmpIbERG?=
 =?utf-8?B?bHFPb1A0RjZLTHVvM2dNenc5R0t4d1ZDUUMrOXZ3Szl3NUgxSVJZTFc2TnZV?=
 =?utf-8?B?Zyt1cXFabXhXZk04ZG5iSU5DSFNYdEZzdHpkSWovUHJQTGRySWFBOEgwV0F0?=
 =?utf-8?B?R09DdnZHc0xFVmtXMk5nNlM3czRMQkdXOWpXcVYzTndHMWlBZm5aY2JPcGpN?=
 =?utf-8?B?L0ZrVjNLM29MTTJQeDA2YnpEdUozMW8wbjA3OWUvTjIvMFg4OE5MMFd0N25u?=
 =?utf-8?B?bC91Rm1Bem4yVUhHRFo1Qlh5YXVaSWJ3Uk5KYXBWSnRYbHhud0VlOUxrS3Zn?=
 =?utf-8?B?aXN4elNyTXFmdVFYYXhpcGVwSmZrR1VVL2hUR1h4NEt2SWowVGVaUDl5dTYv?=
 =?utf-8?B?Qm5uWEtJelJ2VUZxaTJUL0dDb3dtY0tGamxHdWZBMCswV21FV3Q4TmYrb1FB?=
 =?utf-8?B?Zm9vSHdtSXpKNXZyU0hxSlY1d0FuQ3FjYjU2d20vVTFjQ3FEQzlWNWFmZ3lX?=
 =?utf-8?B?QlZmU3ZoREdIRldwd2hkRXZkNGVEMzg5Rk40ZnhkQ3QydWE5SHVkMWZVNWZt?=
 =?utf-8?B?R0RjSFAxRDNkRldLSjBtemxTRVpRQ3owWGNlQSsyK1ZTa1g1WUY5Q1V5ZGYv?=
 =?utf-8?B?ODgyYzViSzhkYWdISnMrYTRtZUtZalJnT2FFb2xZcUJrZUJuQjFWZEZHcUNa?=
 =?utf-8?B?eUtiL1NtTGFkbVZkMzdET0NnbUpheXBSSkg1c21uaDduMlhTVUNabHpWL3VL?=
 =?utf-8?B?T3RYbVZLYjZxd3VuaW9FL05XcGYzM01GaHRPTTNpc0lER3ZGZkRRUWFmdHR0?=
 =?utf-8?B?L004M1BTQkNUbWkrOXROZEd3SDVPU0F4a3FVbG9KQ2RBZXI5UVNpMnRUSWFz?=
 =?utf-8?B?YjIzQ3VVMkFQd1J3UTJSTUR4TmEwakZadkw2M1UyM1g0YzB6ZXZnTG5hbHlt?=
 =?utf-8?B?Kys0Y1piMDdnUTRPNEo0a3pqd3ppenF5RWdlRUt2aHZ6V1NWWWdUQWJzanV4?=
 =?utf-8?B?Z1U4MkhKSVcwSW5PVU90b1pZejhwU21jeTRTZVd3NG05d0RocUhGMnROTzRM?=
 =?utf-8?B?NVYvZVpCbkFBQjhOUU5ER3hja2RTdjFpVFloNjlQbitGMXBjVGg4aUV1eEJQ?=
 =?utf-8?Q?Zva5pHbhgin7yGMyXF28ARYlS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d66f9b2-fc3b-4a68-7eb5-08dc1223c111
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:33:15.3403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4T9KztKN5KULTsERTQVTAO6Vz4qL40IBbJxsS/+JzqIC++3qRuiwYIZWSv8s4oateMOLssGi8PchyLxtlA7dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7569

On 1/10/24 13:35, Kirill A. Shutemov wrote:
> When memory encryption is enabled, the kernel prints the encryption
> flavor that the system supports.
> 
> The check assumes that everything is AMD SME/SEV if it has the TDX CPU

s/if it has/if it doesn't have/

> feature set.
> 
> To avoid confusion, check the cc_vendor directly.

Is this because of the setting of cc_vendor in hv_vtom_init() without 
setting the TDX feature and so "Intel TDX" isn't printed and instead "AMD" 
is printed?

If so, the commit message should really have some info about how this 
relates to Hyper-V isolation VMs.

Thanks,
Tom

> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   arch/x86/mm/mem_encrypt.c | 56 +++++++++++++++++++++------------------
>   1 file changed, 30 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index c290c55b632b..d035bce3a2b0 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -42,38 +42,42 @@ bool force_dma_unencrypted(struct device *dev)
>   
>   static void print_mem_encrypt_feature_info(void)
>   {
> -	pr_info("Memory Encryption Features active:");
> +	pr_info("Memory Encryption Features active: ");
>   
> -	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
> -		pr_cont(" Intel TDX\n");
> -		return;
> -	}
> +	switch (cc_vendor) {
> +	case CC_VENDOR_INTEL:
> +		pr_cont("Intel TDX\n");
> +		break;
> +	case CC_VENDOR_AMD:
> +		pr_cont("AMD");
>   
> -	pr_cont(" AMD");
> -
> -	/* Secure Memory Encryption */
> -	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
> +		/* Secure Memory Encryption */
> +		if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
>   		/*
>   		 * SME is mutually exclusive with any of the SEV
>   		 * features below.
> -		 */
> -		pr_cont(" SME\n");
> -		return;
> +		*/
> +			pr_cont(" SME\n");
> +			return;
> +		}
> +
> +		/* Secure Encrypted Virtualization */
> +		if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +			pr_cont(" SEV");
> +
> +		/* Encrypted Register State */
> +		if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
> +			pr_cont(" SEV-ES");
> +
> +		/* Secure Nested Paging */
> +		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> +			pr_cont(" SEV-SNP");
> +
> +		pr_cont("\n");
> +		break;
> +	default:
> +		pr_cont("Unknown\n");
>   	}
> -
> -	/* Secure Encrypted Virtualization */
> -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> -		pr_cont(" SEV");
> -
> -	/* Encrypted Register State */
> -	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
> -		pr_cont(" SEV-ES");
> -
> -	/* Secure Nested Paging */
> -	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> -		pr_cont(" SEV-SNP");
> -
> -	pr_cont("\n");
>   }
>   
>   /* Architecture __weak replacement functions */

