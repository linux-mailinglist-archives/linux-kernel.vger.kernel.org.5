Return-Path: <linux-kernel+bounces-26199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E259582DCA8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63911C21D74
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9011775E;
	Mon, 15 Jan 2024 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TFtqzmcv"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76C017981
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zvqe4hM2bFz2scNbGbv6MYGzUaLfx3UbRYW+MaYIF0Ti30aLCPh0gRXWW3B2wn2OzPdcSA/Zf2nYRZBDRnh1Qi3M9TqkAIQAhS58jMzvKgAepjyVwAc4njLYaZ4Flcm94QhofDQY9zwTOMsxRs42UYR9SNEOKXJX7fzQ9NTEyIvPofPfV+J+WLwpzdrAy1M7AkrrdA1D+Cq1eCl52kIvVTDTQuxstoDgnzyloq1EYDkbE3LcxLJmZn5aWcLfwBdUZ2sEGubUVRw62waVISLEAaZJdQ6MWgjkL6li1KE+a02Jth+o08Pt2xZOevRY4eWBNSWWKuEmSfjy2Il8QgFYwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7ToI7yasIe5JU/xf2NAgZGlc5B10Iyp4ldIJrBnD/k=;
 b=ZyBko1eVYfSJwtTe2OizzWYRTUsVA5dTlGRV7rbpu6LRtl97uriOFNS8lBWYwkb8SLksQ5g35xTYgKBHAKdFqWM47whEFhfZ0N5t4p7DjoO4PhNfSQlOiLZGvTVKSX5VYE1zJ29n8VistThqbGORMNpildFF7Zc/3yKRVrQIcDtLfQ+KkDeW6RQxKxC4j5HvtE1W9wMxSLQyia7pF5fO5wkjOLS5M/sBufKhACUKwRqxg/MkPUIJWwt1SsOZk0kL8pplEk/4+Mg/ZW8NzpeiEvX65L+3EOC4lRjV4QHcZokxSFwvazS7bT7vp7hlarkF7WyJ6dmSZt2fh6zmCXRBwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7ToI7yasIe5JU/xf2NAgZGlc5B10Iyp4ldIJrBnD/k=;
 b=TFtqzmcvbbFIHL+qXzNvl7ILc6GOeIIAGKz4q31ZSnTBU0Wo0deXGBwX+CZt9mvM+UxQJa56V0BpPLwg5vWUmkRXnHsh554sPYKg3waLObdOMDeDD8y7dKpUw+5DlNeyOg0vOWnAQ4W1IP5mSIZ2gIy0Bp/CV5F8c8b5OmpMSEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 15:53:30 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c%3]) with mapi id 15.20.7181.018; Mon, 15 Jan 2024
 15:53:30 +0000
Message-ID: <7144c0d5-8fb4-8d83-a854-ed597296c68f@amd.com>
Date: Mon, 15 Jan 2024 09:53:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2] x86/sev: enforce RIP-relative accesses in early
 SEV/SME code
Content-Language: en-US
To: Kevin Loughlin <kevinloughlin@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Michael Kelley <mikelley@microsoft.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Arnd Bergmann <arnd@arndb.de>, Steve Rutherford <srutherford@google.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Hou Wenlong <houwenlong.hwl@antgroup.com>,
 Vegard Nossum <vegard.nossum@oracle.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Yuntao Wang <ytcoode@gmail.com>,
 Wang Jinchao <wangjinchao@xfusion.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Brian Gerst <brgerst@gmail.com>, Hugh Dickins <hughd@google.com>,
 Ard Biesheuvel <ardb@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Dionna Glaze <dionnaglaze@google.com>, Brijesh Singh
 <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-coco@lists.linux.dev, Ashish Kalra <ashish.kalra@amd.com>,
 Andi Kleen <ak@linux.intel.com>
Cc: Adam Dunlap <acdunlap@google.com>, Peter Gonda <pgonda@google.com>,
 Jacob Xu <jacobhxu@google.com>, Sidharth Telang <sidtelang@google.com>
References: <ZZ7YuEexYSaZYmLK@tassilo>
 <20240111223650.3502633-1-kevinloughlin@google.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240111223650.3502633-1-kevinloughlin@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0068.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::27) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DS7PR12MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: a94119ce-d092-4dd3-3264-08dc15e21ed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o2fqlVMRCi86acvK71UZWZ6BJflp0c1XFDGOYJzYcXIzi64A3xG69drukXzetm9GKsdhJYadhFFUvdAQgGUumvv48PZScMOdz37dpY5Vz9NcDo1qGdpXfkSoy+BYsk2qhGjaiGrNo9HIFAvYq03LkwgsEDaNsBe7L29nO5Q1FdlJEdRVZVDx2FKM9JrFwR+WTc/qZNYzh8tY+kZdiDBwRUtJQinpANsPetdLdz2n3AZevtFDSuGip0ABiJOu8KWy8KP7Vb2xhtR70ToLmli90cznS+Omk6aJhaQZKYKrEEAlDo1Hp3d7rPl1FVFVZmA7j/SjfEk9qbWtLfBLp2kTaAHqGRg0+3pLACLbjzMxKrSTTPR/XV4E1TQ+SXc/Kr5/0NSLNysXTAGgZWpB49JgXbXvo6Dz4GJCJ4UZWnlTRsnRlubHcc7GaM1hgKM00AUtJfTQGvKGob+3jK+Ht8OjRIYirpfhgVSoygD2TUDGiDwWIsZCfe/lzxSztuNGmbR61xaeDtLJr0gZWsSUHr3QQrXOBTt7e+qzkNwM/MrX/YyXBuO67rVDFpFNOAuHGpoGoEbOpKM2DcWyb/8oQYQ1e5nL0hcutGDWbCfuAZb22mr7RPQsqB1e8lywa14Yf66biFacy7briN0WSqZtC5b5arcY8OY9113AcmWjX0XcoLeZ/NxeudC3pbctuBk+7tXQg/iF5EhnWuTawV8gHPBRVg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(186009)(451199024)(1800799012)(921011)(41300700001)(31686004)(36756003)(2906002)(6506007)(6666004)(2616005)(26005)(83380400001)(478600001)(6512007)(38100700002)(53546011)(6486002)(66946007)(5660300002)(110136005)(66476007)(316002)(30864003)(54906003)(66556008)(86362001)(31696002)(8936002)(7406005)(7416002)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2E1bkRLdnFwcFg5dVgrY1Jha3lzWk1RVjhvMW9uNWhMOHBqelhETCticnZY?=
 =?utf-8?B?YnFVYkZlemhwTTR2RkJyNHhDWlNKTm0wOFhFTHY5M0lQOXJiTGlMOUVqUTMw?=
 =?utf-8?B?bjNwQ0c1ZHZOcS9WdDdYWEVmWU9OVmZ1Q29KbjNhZ1JIRGJ6WmJ0N3NUSXhP?=
 =?utf-8?B?VlJiY2lDNEtORFpZNmVmMlpQN29MRm80N3ZFSk5VbUpaRFZFMzZhMDlvTHBz?=
 =?utf-8?B?N2tKV2dEWk54dkVKYnFRQ1FvOXJHSVlrbmpwdGwzNE1uWURPVzZ5Ni9IWC96?=
 =?utf-8?B?NnJRcGdBdUNpL1FkemN5d0o3RkJtdG5ROFk5YXl2TnNqYUFxc09nRDJ2Snpq?=
 =?utf-8?B?TUhTQzZFVlkvZDJvVURqazR3eVQ1bG5YR1VVZ1VRaXkyT3laZTVaSzk1R0Yy?=
 =?utf-8?B?OXJZUVQyMTNtNWgzeDdvZnF0bmtIeW95WjlCUThFYStJbW0zbTUvN2tkODRZ?=
 =?utf-8?B?QWp1OVFwSHJGYzA0YmlYSHdtei9wWkd6LzBFKzE1SjdDMU9IZUE2Y012cXhU?=
 =?utf-8?B?cjZIUlh1VmZkZEtNSVdMeWtqTUhIdGNBQTZpQ3U1QlQ3bkVlV1RUTzc0dVAw?=
 =?utf-8?B?UCtsUlcvWTA4LzZIcStWeWJrakFISUFFMGUwTWxZN3RsbGFDckFyRENDc0tz?=
 =?utf-8?B?bUNhWTN6ZWo1a0VzU2dNMFlTZDFEZnJrNnhta2F1Q3RVczN3UDRkWE1iNHNT?=
 =?utf-8?B?Um5SZEpiS3RtMC9mdm9kRjMzVGJacTlpblNqc3ZFN25vTE1YeE5MSUN2cUtC?=
 =?utf-8?B?bHMvZjZ2RzdlYlA5ZW9wYTF6L2ovUnQxakR2UkZOblVvb2pxdW83RjhyYVJu?=
 =?utf-8?B?aFM4YmxBb0hRT09UZTFrbk9wZitJYlFVcFpaTnpRQWJZSDUxMlNONUNmZW9n?=
 =?utf-8?B?VEVtOTRNVExyUlJSMXR0SDVydDJPaXNabjY0TmovOFpxQ2MvQlNxNUxFeXY3?=
 =?utf-8?B?VjZhTjdaZ0JteUNLb2JnbHhjU04vMHRWcDFCNTRqNWVKSy81RXkwMU14eE82?=
 =?utf-8?B?RXcvRHgwUGk0VHlHYloybWMzRlhJZ2pMcVFXalZ3anBuTmZkWFFpTkpESk5z?=
 =?utf-8?B?RGJMZk9ES3pzTGxWZVJEaWtINExQd3kyZXYwaVVwMjhSNmtoVkswd21KSlVF?=
 =?utf-8?B?VEdQL2YxL3B1L2VzTVZtdVZLUVZMUTdORHIwNzllQ2VoNW9ETytDdTRoUjU2?=
 =?utf-8?B?MjR4cFJhWDR0TERTNG5GUkp0L2hjK00xZ1BhMktoMFh3T3V1czdLakdUdUt3?=
 =?utf-8?B?MEdVSjR2Q1J5VG03RlBhcDJ2MnBudlFrWUFJeE8yVUVTTmozaUdsQ2ZXZDk0?=
 =?utf-8?B?N3F0UGtsb21LV0RBNHAvZWJjamc2Nk85eWdjUzlMSmNIV0ozNEYwbEltcnMx?=
 =?utf-8?B?TCtlY0JLSjdCaDkwTXd3K0RqdUhGN1poeGJOU2c5aDNxWVkxTmFUZWJyeEZy?=
 =?utf-8?B?c1lKMEZabXkrbm5uamlYZEl6YnNpSUpCZ1ZEaVY1N3phbmdmaVRGSmZHd3NF?=
 =?utf-8?B?aGtNbXpaUUxSTXFoaGNZM0R4UUtmcWNpYjBvTUFSWk9NckoxT0NQaXJSMllF?=
 =?utf-8?B?V2ZtazdvdWxTdTJ6WUpmUGcvSjNZY1dpSTI2cnlQemk5SmQyUWNNSDJBWXQv?=
 =?utf-8?B?dFptenYxQWFoclIrcFp2ZHFxRXVWWlNsUGRPYngzemFnQldFUHNoVVREMHkz?=
 =?utf-8?B?UUNoMjc5Y3Y0LzZmZUtwd1Vld3BzdG5KM0xwMG0zZFNocDQrSEo5VXhjT0RP?=
 =?utf-8?B?NzNMUkh6QVUvSkFXRCs2K2QwTmJIWG9aVnJFNU9hZ1U5SHdkTzE0Q09ITWRx?=
 =?utf-8?B?TEMrck4zWm5QMGtNN3phUXBWK1F6a01IZE5naC91eWVtVjdsVEYxa0hOQmNC?=
 =?utf-8?B?VVNqSS9lbEpXMmlIN2xHdVpMaERMTDExWFZWTmdrMkg2OGVSZUJ6RjRvMDJM?=
 =?utf-8?B?aUh5Z01GTzcvN2xsQ1pwK0duZXRLcGdUNGZuLzhVYXh5bUVpc0JHWllmVnp3?=
 =?utf-8?B?TDBMcXh1RVE4Sk5YVHFPMkF6UTFqVEp0VXZuMG4vejJUR1pZdzUyTHdLSk1q?=
 =?utf-8?B?MTJIamtCLzBqZHAvd2V6ZkhSZU5WdFFTR2J3K3A2Y0VXUDFCQXNMM0c2aE0y?=
 =?utf-8?Q?RIZHwkyrbdVyxDu3x/IMmitND?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94119ce-d092-4dd3-3264-08dc15e21ed5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 15:53:30.5803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGpASrmbd35k6HkQzm47FWvO2ovpxd+M3dO65uGYX/AlzDjgelRDLMvxhgo+Ja/N3qQpwVjs28zrXp06exxINQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885

On 1/11/24 16:36, Kevin Loughlin wrote:
> SEV/SME code can execute prior to page table fixups for kernel
> relocation. However, as with global variables accessed in
> __startup_64(), the compiler is not required to generate RIP-relative
> accesses for SEV/SME global variables, causing certain flavors of SEV
> hosts and guests built with clang to crash during boot.
> 
> While an attempt was made to force RIP-relative addressing for certain
> global SEV/SME variables via inline assembly (see snp_cpuid_get_table()
> for example), RIP-relative addressing must be pervasively-enforced for
> SEV/SME global variables when accessed prior to page table fixups.
> 
> __startup_64() already handles this issue for select non-SEV/SME global
> variables using fixup_pointer(), which adjusts the pointer relative to
> a `physaddr` argument. To avoid having to pass around this `physaddr`
> argument across all functions needing to apply pointer fixups, this
> patch introduces the macro GET_RIP_RELATIVE_PTR() (an abstraction of
> the existing snp_cpuid_get_table()), which generates an RIP-relative
> pointer to a passed variable. Similarly, PTR_TO_RIP_RELATIVE_PTR() is
> introduced to fixup an existing pointer value with RIP-relative logic.
> 
> Applying these macros to early SEV/SME code (alongside Adam Dunlap's
> necessary "[PATCH v2] x86/asm: Force native_apic_mem_read to use mov")
> enables previously-failing boots of clang builds to succeed, while
> preserving successful boot of gcc builds. Tested with and without SEV,
> SEV-ES, SEV-SNP enabled in guests built via both gcc and clang.
> 
> Fixes: 95d33bfaa3e1 ("x86/sev: Register GHCB memory when SEV-SNP is active")
> Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers")
> Fixes: 1cd9c22fee3a ("x86/mm/encrypt: Move page table helpers into separate translation unit")
> Fixes: c9f09539e16e ("x86/head/64: Check SEV encryption before switching to kernel page-table")
> Fixes: b577f542f93c ("x86/coco: Add API to handle encryption mask")
> Tested-by: Kevin Loughlin <kevinloughlin@google.com>
> Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
> ---
>   arch/x86/coco/core.c               | 22 +++++++----
>   arch/x86/include/asm/mem_encrypt.h | 37 +++++++++++++++++-
>   arch/x86/kernel/head64.c           | 22 ++++++-----
>   arch/x86/kernel/head_64.S          |  4 +-
>   arch/x86/kernel/sev-shared.c       | 63 ++++++++++++++++--------------
>   arch/x86/kernel/sev.c              | 15 +++++--
>   arch/x86/mm/mem_encrypt_identity.c | 50 ++++++++++++------------
>   7 files changed, 136 insertions(+), 77 deletions(-)
> 
> diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
> index eeec9986570e..8c45b5643f48 100644
> --- a/arch/x86/coco/core.c
> +++ b/arch/x86/coco/core.c
> @@ -5,6 +5,11 @@
>    * Copyright (C) 2021 Advanced Micro Devices, Inc.
>    *
>    * Author: Tom Lendacky <thomas.lendacky@amd.com>
> + *
> + * WARNING!!
> + * Select functions in this file can execute prior to page table fixups and thus
> + * require pointer fixups for global variable accesses. See WARNING in
> + * arch/x86/kernel/head64.c.
>    */
>   
>   #include <linux/export.h>
> @@ -61,33 +66,34 @@ static __maybe_unused __always_inline bool amd_cc_platform_vtom(enum cc_attr att
>   static bool noinstr amd_cc_platform_has(enum cc_attr attr)
>   {
>   #ifdef CONFIG_AMD_MEM_ENCRYPT
> +	const u64 sev_status_fixed_up = sev_get_status_fixup();

Why not also have a variable for sme_me_mask?

>   
> -	if (sev_status & MSR_AMD64_SNP_VTOM)
> +	if (sev_status_fixed_up & MSR_AMD64_SNP_VTOM)
>   		return amd_cc_platform_vtom(attr);
>   
>   	switch (attr) {
>   	case CC_ATTR_MEM_ENCRYPT:
> -		return sme_me_mask;
> +		return sme_get_me_mask_fixup();
>   
>   	case CC_ATTR_HOST_MEM_ENCRYPT:
> -		return sme_me_mask && !(sev_status & MSR_AMD64_SEV_ENABLED);
> +		return sme_get_me_mask_fixup() && !(sev_status_fixed_up & MSR_AMD64_SEV_ENABLED);
>   
>   	case CC_ATTR_GUEST_MEM_ENCRYPT:
> -		return sev_status & MSR_AMD64_SEV_ENABLED;
> +		return sev_status_fixed_up & MSR_AMD64_SEV_ENABLED;
>   
>   	case CC_ATTR_GUEST_STATE_ENCRYPT:
> -		return sev_status & MSR_AMD64_SEV_ES_ENABLED;
> +		return sev_status_fixed_up & MSR_AMD64_SEV_ES_ENABLED;
>   
>   	/*
>   	 * With SEV, the rep string I/O instructions need to be unrolled
>   	 * but SEV-ES supports them through the #VC handler.
>   	 */
>   	case CC_ATTR_GUEST_UNROLL_STRING_IO:
> -		return (sev_status & MSR_AMD64_SEV_ENABLED) &&
> -			!(sev_status & MSR_AMD64_SEV_ES_ENABLED);
> +		return (sev_status_fixed_up & MSR_AMD64_SEV_ENABLED) &&
> +			!(sev_status_fixed_up & MSR_AMD64_SEV_ES_ENABLED);
>   
>   	case CC_ATTR_GUEST_SEV_SNP:
> -		return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
> +		return sev_status_fixed_up & MSR_AMD64_SEV_SNP_ENABLED;
>   
>   	default:
>   		return false;
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index 359ada486fa9..d007050a0edc 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -17,6 +17,34 @@
>   
>   #include <asm/bootparam.h>
>   
> +/*
> + * Generates an RIP-relative pointer to a data variable "var".
> + * This macro can be used to safely access global data variables prior to kernel
> + * relocation, similar to fixup_pointer() in arch/x86/kernel/head64.c.
> + */
> +#define GET_RIP_RELATIVE_PTR(var)	\
> +({					\
> +	void *rip_rel_ptr;		\
> +	asm ("lea "#var"(%%rip), %0"	\
> +		: "=r" (rip_rel_ptr)	\
> +		: "p" (&var));		\
> +	rip_rel_ptr;			\
> +})
> +
> +/*
> + * Converts an existing pointer "ptr" to an RIP-relative pointer.
> + * This macro can be used to safely access global pointers prior to kernel
> + * relocation, similar to fixup_pointer() in arch/x86/kernel/head64.c.
> + */
> +#define PTR_TO_RIP_RELATIVE_PTR(ptr)	\
> +({					\
> +	void *rip_rel_ptr;		\
> +	asm ("lea "#ptr"(%%rip), %0"	\
> +		: "=r" (rip_rel_ptr)	\
> +		: "p" (ptr));		\
> +	rip_rel_ptr;			\
> +})
> +
>   #ifdef CONFIG_X86_MEM_ENCRYPT
>   void __init mem_encrypt_init(void);
>   void __init mem_encrypt_setup_arch(void);
> @@ -106,9 +134,14 @@ void add_encrypt_protection_map(void);
>   
>   extern char __start_bss_decrypted[], __end_bss_decrypted[], __start_bss_decrypted_unused[];
>   
> -static inline u64 sme_get_me_mask(void)
> +static inline u64 sme_get_me_mask_fixup(void)
> +{
> +	return *((u64 *) GET_RIP_RELATIVE_PTR(sme_me_mask));
> +}
> +
> +static inline u64 sev_get_status_fixup(void)
>   {
> -	return sme_me_mask;
> +	return *((u64 *) GET_RIP_RELATIVE_PTR(sev_status));
>   }
>   
>   #endif	/* __ASSEMBLY__ */
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index dc0956067944..8df7a198094d 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -130,6 +130,7 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
>   {
>   	unsigned long vaddr, vaddr_end;
>   	int i;
> +	const u64 sme_me_mask_fixed_up = sme_get_me_mask_fixup();

Should be the first variable listed given the length of the line.

>   
>   	/* Encrypt the kernel and related (if SME is active) */
>   	sme_encrypt_kernel(bp);
> @@ -140,7 +141,7 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
>   	 * there is no need to zero it after changing the memory encryption
>   	 * attribute.
>   	 */
> -	if (sme_get_me_mask()) {
> +	if (sme_me_mask_fixed_up) {
>   		vaddr = (unsigned long)__start_bss_decrypted;
>   		vaddr_end = (unsigned long)__end_bss_decrypted;
>   
> @@ -158,7 +159,7 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
>   			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
>   
>   			i = pmd_index(vaddr);
> -			pmd[i] -= sme_get_me_mask();
> +			pmd[i] -= sme_me_mask_fixed_up;
>   		}
>   	}
>   
> @@ -166,14 +167,16 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
>   	 * Return the SME encryption mask (if SME is active) to be used as a
>   	 * modifier for the initial pgdir entry programmed into CR3.
>   	 */
> -	return sme_get_me_mask();
> +	return sme_me_mask_fixed_up;
>   }
>   
> -/* Code in __startup_64() can be relocated during execution, but the compiler
> +/*
> + * WARNING!!
> + * Code in __startup_64() can be relocated during execution, but the compiler
>    * doesn't have to generate PC-relative relocations when accessing globals from
>    * that function. Clang actually does not generate them, which leads to
>    * boot-time crashes. To work around this problem, every global pointer must
> - * be adjusted using fixup_pointer().
> + * be adjusted using fixup_pointer() or GET_RIP_RELATIVE_PTR().
>    */
>   unsigned long __head __startup_64(unsigned long physaddr,
>   				  struct boot_params *bp)
> @@ -188,6 +191,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
>   	bool la57;
>   	int i;
>   	unsigned int *next_pgt_ptr;
> +	const u64 sme_me_mask_fixed_up = sme_get_me_mask_fixup();

Ditto, here, this should be higher in the variable list.

>   
>   	la57 = check_la57_support(physaddr);
>   
> @@ -206,7 +210,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
>   		for (;;);
>   
>   	/* Include the SME encryption mask in the fixup value */
> -	load_delta += sme_get_me_mask();
> +	load_delta += sme_me_mask_fixed_up;
>   
>   	/* Fixup the physical addresses in the page table */
>   
> @@ -242,7 +246,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
>   	pud = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], physaddr);
>   	pmd = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], physaddr);
>   
> -	pgtable_flags = _KERNPG_TABLE_NOENC + sme_get_me_mask();
> +	pgtable_flags = _KERNPG_TABLE_NOENC + sme_me_mask_fixed_up;
>   
>   	if (la57) {
>   		p4d = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++],
> @@ -269,7 +273,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
>   	/* Filter out unsupported __PAGE_KERNEL_* bits: */
>   	mask_ptr = fixup_pointer(&__supported_pte_mask, physaddr);
>   	pmd_entry &= *mask_ptr;
> -	pmd_entry += sme_get_me_mask();
> +	pmd_entry += sme_me_mask_fixed_up;
>   	pmd_entry +=  physaddr;
>   
>   	for (i = 0; i < DIV_ROUND_UP(_end - _text, PMD_SIZE); i++) {
> @@ -313,7 +317,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
>   	 * Fixup phys_base - remove the memory encryption mask to obtain
>   	 * the true physical address.
>   	 */
> -	*fixup_long(&phys_base, physaddr) += load_delta - sme_get_me_mask();
> +	*fixup_long(&phys_base, physaddr) += load_delta - sme_me_mask_fixed_up;
>   
>   	return sme_postprocess_startup(bp, pmd);
>   }
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index d4918d03efb4..b9e52cee6e00 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -176,9 +176,11 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>   	/*
>   	 * Retrieve the modifier (SME encryption mask if SME is active) to be
>   	 * added to the initial pgdir entry that will be programmed into CR3.
> +	 * Since we may have not completed page table fixups, use RIP-relative
> +	 * addressing for sme_me_mask.
>   	 */
>   #ifdef CONFIG_AMD_MEM_ENCRYPT
> -	movq	sme_me_mask, %rax
> +	movq	sme_me_mask(%rip), %rax
>   #else
>   	xorq	%rax, %rax
>   #endif
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 1d24ec679915..e71752c990ef 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -7,6 +7,11 @@
>    * This file is not compiled stand-alone. It contains code shared
>    * between the pre-decompression boot code and the running Linux kernel
>    * and is included directly into both code-bases.
> + *
> + * WARNING!!
> + * Select functions in this file can execute prior to page table fixups and thus
> + * require pointer fixups for global variable accesses. See WARNING in
> + * arch/x86/kernel/head64.c.
>    */
>   
>   #ifndef __BOOT_COMPRESSED
> @@ -110,8 +115,9 @@ static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
>   static u64 get_hv_features(void)
>   {
>   	u64 val;
> +	const u16 *ghcb_version_ptr = (const u16 *) GET_RIP_RELATIVE_PTR(ghcb_version);

Is this one really needed? The ghcb_version variable isn't referenced 
before fixup, right? It's referenced in both decompression and early boot, 
but I didn't think a fixup is needed.

Can you elaborate on the call tree/call time when this is needed?

>   
> -	if (ghcb_version < 2)
> +	if (*ghcb_version_ptr < 2)
>   		return 0;
>   
>   	sev_es_wr_ghcb_msr(GHCB_MSR_HV_FT_REQ);
> @@ -143,6 +149,7 @@ static void snp_register_ghcb_early(unsigned long paddr)
>   static bool sev_es_negotiate_protocol(void)
>   {
>   	u64 val;
> +	u16 *ghcb_version_ptr;
>   
>   	/* Do the GHCB protocol version negotiation */
>   	sev_es_wr_ghcb_msr(GHCB_MSR_SEV_INFO_REQ);
> @@ -156,7 +163,8 @@ static bool sev_es_negotiate_protocol(void)
>   	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTOCOL_MAX)
>   		return false;
>   
> -	ghcb_version = min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);
> +	ghcb_version_ptr = (u16 *) GET_RIP_RELATIVE_PTR(ghcb_version);
> +	*ghcb_version_ptr = min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);

Ditto here.

>   
>   	return true;
>   }
> @@ -318,23 +326,6 @@ static int sev_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid
>   		    : __sev_cpuid_hv_msr(leaf);
>   }
>   
> -/*
> - * This may be called early while still running on the initial identity
> - * mapping. Use RIP-relative addressing to obtain the correct address
> - * while running with the initial identity mapping as well as the
> - * switch-over to kernel virtual addresses later.
> - */
> -static const struct snp_cpuid_table *snp_cpuid_get_table(void)
> -{
> -	void *ptr;
> -
> -	asm ("lea cpuid_table_copy(%%rip), %0"
> -	     : "=r" (ptr)
> -	     : "p" (&cpuid_table_copy));
> -
> -	return ptr;
> -}
> -
>   /*
>    * The SNP Firmware ABI, Revision 0.9, Section 7.1, details the use of
>    * XCR0_IN and XSS_IN to encode multiple versions of 0xD subfunctions 0
> @@ -357,7 +348,8 @@ static const struct snp_cpuid_table *snp_cpuid_get_table(void)
>    */
>   static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
>   {
> -	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
> +	const struct snp_cpuid_table *cpuid_table = (const struct
> +		snp_cpuid_table *) GET_RIP_RELATIVE_PTR(cpuid_table_copy);

Can you use typeof in the macro to eliminate this casting? Right now the 
macro returns void * so the casting isn't really needed, too, right?

Otherwise, I say move the assignment out of the variable section.

>   	u64 xfeatures_found = 0;
>   	u32 xsave_size = 0x240;
>   	int i;
> @@ -394,7 +386,8 @@ static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
>   static bool
>   snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
>   {
> -	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
> +	const struct snp_cpuid_table *cpuid_table = (const struct
> +		snp_cpuid_table *) GET_RIP_RELATIVE_PTR(cpuid_table_copy);

Ditto here.

>   	int i;
>   
>   	for (i = 0; i < cpuid_table->count; i++) {
> @@ -530,7 +523,9 @@ static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
>    */
>   static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
>   {
> -	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
> +	const struct snp_cpuid_table *cpuid_table = (const struct
> +		snp_cpuid_table *) GET_RIP_RELATIVE_PTR(cpuid_table_copy);
> +	const u32 *cpuid_std_range_max_ptr, *cpuid_hyp_range_max_ptr, *cpuid_ext_range_max_ptr;

Move this to the top of the variable definitions.

>   
>   	if (!cpuid_table->count)
>   		return -EOPNOTSUPP;
> @@ -555,10 +550,14 @@ static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_le
>   		 */
>   		leaf->eax = leaf->ebx = leaf->ecx = leaf->edx = 0;
>   
> +		cpuid_std_range_max_ptr = (const u32 *) GET_RIP_RELATIVE_PTR(cpuid_std_range_max);
> +		cpuid_hyp_range_max_ptr = (const u32 *) GET_RIP_RELATIVE_PTR(cpuid_hyp_range_max);
> +		cpuid_ext_range_max_ptr = (const u32 *) GET_RIP_RELATIVE_PTR(cpuid_ext_range_max);
> +
>   		/* Skip post-processing for out-of-range zero leafs. */
> -		if (!(leaf->fn <= cpuid_std_range_max ||
> -		      (leaf->fn >= 0x40000000 && leaf->fn <= cpuid_hyp_range_max) ||
> -		      (leaf->fn >= 0x80000000 && leaf->fn <= cpuid_ext_range_max)))
> +		if (!(leaf->fn <= *cpuid_std_range_max_ptr ||
> +		      (leaf->fn >= 0x40000000 && leaf->fn <= *cpuid_hyp_range_max_ptr) ||
> +		      (leaf->fn >= 0x80000000 && leaf->fn <= *cpuid_ext_range_max_ptr)))
>   			return 0;
>   	}
>   
> @@ -1046,6 +1045,7 @@ static struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
>   static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
>   {
>   	const struct snp_cpuid_table *cpuid_table_fw, *cpuid_table;
> +	u32 *cpuid_std_range_max_ptr, *cpuid_hyp_range_max_ptr, *cpuid_ext_range_max_ptr;

Move this to the top of the variable definitions.

>   	int i;
>   
>   	if (!cc_info || !cc_info->cpuid_phys || cc_info->cpuid_len < PAGE_SIZE)
> @@ -1055,19 +1055,24 @@ static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
>   	if (!cpuid_table_fw->count || cpuid_table_fw->count > SNP_CPUID_COUNT_MAX)
>   		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
>   
> -	cpuid_table = snp_cpuid_get_table();
> +	cpuid_table = (const struct snp_cpuid_table *) GET_RIP_RELATIVE_PTR(
> +		cpuid_table_copy);

This can be a single line since the requirements are now 100 character 
line length.

>   	memcpy((void *)cpuid_table, cpuid_table_fw, sizeof(*cpuid_table));
>   
> +	cpuid_std_range_max_ptr = (u32 *) GET_RIP_RELATIVE_PTR(cpuid_std_range_max);
> +	cpuid_hyp_range_max_ptr = (u32 *) GET_RIP_RELATIVE_PTR(cpuid_hyp_range_max);
> +	cpuid_ext_range_max_ptr = (u32 *) GET_RIP_RELATIVE_PTR(cpuid_ext_range_max);
> +
>   	/* Initialize CPUID ranges for range-checking. */
>   	for (i = 0; i < cpuid_table->count; i++) {
>   		const struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
>   
>   		if (fn->eax_in == 0x0)
> -			cpuid_std_range_max = fn->eax;
> +			*cpuid_std_range_max_ptr = fn->eax;
>   		else if (fn->eax_in == 0x40000000)
> -			cpuid_hyp_range_max = fn->eax;
> +			*cpuid_hyp_range_max_ptr = fn->eax;
>   		else if (fn->eax_in == 0x80000000)
> -			cpuid_ext_range_max = fn->eax;
> +			*cpuid_ext_range_max_ptr = fn->eax;
>   	}
>   }
>   
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index c67285824e82..c966bc511949 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -5,6 +5,11 @@
>    * Copyright (C) 2019 SUSE
>    *
>    * Author: Joerg Roedel <jroedel@suse.de>
> + *
> + * WARNING!!
> + * Select functions in this file can execute prior to page table fixups and thus
> + * require pointer fixups for global variable accesses. See WARNING in
> + * arch/x86/kernel/head64.c.
>    */
>   
>   #define pr_fmt(fmt)	"SEV: " fmt
> @@ -748,7 +753,7 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
>   	 * This eliminates worries about jump tables or checking boot_cpu_data
>   	 * in the cc_platform_has() function.
>   	 */
> -	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
> +	if (!(sev_get_status_fixup() & MSR_AMD64_SEV_SNP_ENABLED))
>   		return;
>   
>   	 /*
> @@ -767,7 +772,7 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
>   	 * This eliminates worries about jump tables or checking boot_cpu_data
>   	 * in the cc_platform_has() function.
>   	 */
> -	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
> +	if (!(sev_get_status_fixup() & MSR_AMD64_SEV_SNP_ENABLED))
>   		return;
>   
>   	 /* Ask hypervisor to mark the memory pages shared in the RMP table. */
> @@ -2114,7 +2119,8 @@ void __init __noreturn snp_abort(void)
>   
>   static void dump_cpuid_table(void)
>   {
> -	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
> +	const struct snp_cpuid_table *cpuid_table = (const struct
> +		snp_cpuid_table *) GET_RIP_RELATIVE_PTR(cpuid_table_copy);

Same comment on the casting and placement.

>   	int i = 0;
>   
>   	pr_info("count=%d reserved=0x%x reserved2=0x%llx\n",
> @@ -2138,7 +2144,8 @@ static void dump_cpuid_table(void)
>    */
>   static int __init report_cpuid_table(void)
>   {
> -	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
> +	const struct snp_cpuid_table *cpuid_table = (const struct
> +		snp_cpuid_table *) GET_RIP_RELATIVE_PTR(cpuid_table_copy);

Ditto.

>   
>   	if (!cpuid_table->count)
>   		return 0;
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index d73aeb16417f..f4c864ea2468 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -5,6 +5,11 @@
>    * Copyright (C) 2016 Advanced Micro Devices, Inc.
>    *
>    * Author: Tom Lendacky <thomas.lendacky@amd.com>
> + *
> + * WARNING!!
> + * Select functions in this file can execute prior to page table fixups and thus
> + * require pointer fixups for global variable accesses. See WARNING in
> + * arch/x86/kernel/head64.c.
>    */
>   
>   #define DISABLE_BRANCH_PROFILING
> @@ -305,7 +310,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
>   	 * instrumentation or checking boot_cpu_data in the cc_platform_has()
>   	 * function.
>   	 */
> -	if (!sme_get_me_mask() || sev_status & MSR_AMD64_SEV_ENABLED)
> +	if (!sme_get_me_mask_fixup() || sev_get_status_fixup() & MSR_AMD64_SEV_ENABLED)
>   		return;
>   
>   	/*
> @@ -346,9 +351,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
>   	 * We're running identity mapped, so we must obtain the address to the
>   	 * SME encryption workarea using rip-relative addressing.
>   	 */
> -	asm ("lea sme_workarea(%%rip), %0"
> -	     : "=r" (workarea_start)
> -	     : "p" (sme_workarea));
> +	workarea_start = (unsigned long) PTR_TO_RIP_RELATIVE_PTR(sme_workarea);
>   
>   	/*
>   	 * Calculate required number of workarea bytes needed:
> @@ -511,7 +514,7 @@ void __init sme_enable(struct boot_params *bp)
>   	unsigned long me_mask;
>   	char buffer[16];
>   	bool snp;
> -	u64 msr;
> +	u64 msr, *sme_me_mask_ptr, *sev_status_ptr;

Move up in the variable definitions to maintain coding standards.

>   
>   	snp = snp_init(bp);
>   
> @@ -542,12 +545,14 @@ void __init sme_enable(struct boot_params *bp)
>   
>   	me_mask = 1UL << (ebx & 0x3f);
>   
> +	sev_status_ptr = (u64 *) GET_RIP_RELATIVE_PTR(sev_status);
> +
>   	/* Check the SEV MSR whether SEV or SME is enabled */
> -	sev_status   = __rdmsr(MSR_AMD64_SEV);
> -	feature_mask = (sev_status & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
> +	*sev_status_ptr   = __rdmsr(MSR_AMD64_SEV);

You can remove the extra spaces before the "=" now since there isn't any 
alignment to be done.

Thanks,
Tom

> +	feature_mask = (*sev_status_ptr & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
>   
>   	/* The SEV-SNP CC blob should never be present unless SEV-SNP is enabled. */
> -	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
> +	if (snp && !(*sev_status_ptr & MSR_AMD64_SEV_SNP_ENABLED))
>   		snp_abort();
>   
>   	/* Check if memory encryption is enabled */
> @@ -573,7 +578,8 @@ void __init sme_enable(struct boot_params *bp)
>   			return;
>   	} else {
>   		/* SEV state cannot be controlled by a command line option */
> -		sme_me_mask = me_mask;
> +		sme_me_mask_ptr = (u64 *) GET_RIP_RELATIVE_PTR(sme_me_mask);
> +		*sme_me_mask_ptr = me_mask;
>   		goto out;
>   	}
>   
> @@ -582,15 +588,9 @@ void __init sme_enable(struct boot_params *bp)
>   	 * identity mapped, so we must obtain the address to the SME command
>   	 * line argument data using rip-relative addressing.
>   	 */
> -	asm ("lea sme_cmdline_arg(%%rip), %0"
> -	     : "=r" (cmdline_arg)
> -	     : "p" (sme_cmdline_arg));
> -	asm ("lea sme_cmdline_on(%%rip), %0"
> -	     : "=r" (cmdline_on)
> -	     : "p" (sme_cmdline_on));
> -	asm ("lea sme_cmdline_off(%%rip), %0"
> -	     : "=r" (cmdline_off)
> -	     : "p" (sme_cmdline_off));
> +	cmdline_arg = (const char *) PTR_TO_RIP_RELATIVE_PTR(sme_cmdline_arg);
> +	cmdline_on = (const char *) PTR_TO_RIP_RELATIVE_PTR(sme_cmdline_on);
> +	cmdline_off = (const char *) PTR_TO_RIP_RELATIVE_PTR(sme_cmdline_off);
>   
>   	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT))
>   		active_by_default = true;
> @@ -603,16 +603,18 @@ void __init sme_enable(struct boot_params *bp)
>   	if (cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer)) < 0)
>   		return;
>   
> +	sme_me_mask_ptr = (u64 *) GET_RIP_RELATIVE_PTR(sme_me_mask);
> +
>   	if (!strncmp(buffer, cmdline_on, sizeof(buffer)))
> -		sme_me_mask = me_mask;
> +		*sme_me_mask_ptr = me_mask;
>   	else if (!strncmp(buffer, cmdline_off, sizeof(buffer)))
> -		sme_me_mask = 0;
> +		*sme_me_mask_ptr = 0;
>   	else
> -		sme_me_mask = active_by_default ? me_mask : 0;
> +		*sme_me_mask_ptr = active_by_default ? me_mask : 0;
>   out:
> -	if (sme_me_mask) {
> -		physical_mask &= ~sme_me_mask;
> +	if (*sme_me_mask_ptr) {
> +		physical_mask &= ~(*sme_me_mask_ptr);
>   		cc_vendor = CC_VENDOR_AMD;
> -		cc_set_mask(sme_me_mask);
> +		cc_set_mask(*sme_me_mask_ptr);
>   	}
>   }

