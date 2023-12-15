Return-Path: <linux-kernel+bounces-427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 918D48140FF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287741F22F26
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0633D63A6;
	Fri, 15 Dec 2023 04:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W6rPB2Lj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C838D266
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 04:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Je9fMAFI5sEUuT/66I0siAj3Pg67rkDApFdt8G9cCIyyX6ImCjrEG/Wb+V6bPBtdl0BiwUFDLbLVCdn2DN5CWfLVce9e1BZpyaiwFY1c0uBM2A2GHWs5wVDYLsQmeI/V9IWkqZGf3uz6+YNarhWY9F+Sa4FPHRoR1089Cbs35rnUBDrs6sh+wG432+QdrDJO+d+6dyuMjlm5suuXsk3ehqoLUlbDqVbMkOVojwOuBbaZukuKyHZUmfEM9Q551m+hzBGdNf7vN8hX/65U79cRRMvuPJzDKIYu44HIxiQ57AaWv6/5K7p1IVjjsXSg0BrAI7yB2OP0n0M53Bl9inFhVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okj14Fdhyt++F6kbzW6rKwxp9MZ3gOZCrYYVwMs2nBs=;
 b=kyfuTI7p2q6mdrt/Q+V42z7TtgNcJ4gXyoXtR6gwcCXG7Yk5r+TOH/zROYC6m/7pxExiBIYZT7CmmfkAcyrjdgw9CAedm0tzTP3ya7Skz+LMdSGZdGkckQQxr4RvwadIc2SwAIovn7RTR1t2/1dykJkdi95P7nmprPxZHiTYXHqGzlPzB+sxzVzzetoMmg6umOSGbJWSwbj6+u8FEq6RFiCi8+INIxbPwAsVdlpDoOJ6Q5DQKJ8ZJt9w31DwFr1BgSV+T/wGNRDb1LGbSLFLFT6//IxuyFM7Hi9M50lFoR8dMepYTg+MOfyceK8E1RD3BYh8Wa6glt45LqPq+bo7vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okj14Fdhyt++F6kbzW6rKwxp9MZ3gOZCrYYVwMs2nBs=;
 b=W6rPB2LjzQMWA62ZulID275ZNzaJFUEBxs1mYPsrFQuP+OswZRpBDZVeh00KjRqR0g40qST1Qsgx/BxV9gOzDGdMrXmwpvuzXOTq0enq72N3hM7VJdN1J/+egQKqCTAeChcirNxnG961SGsHKJX5sDcISNp50LwqSKLa0S5lNXsLCOABCf7fqdMxfEFlN1h6CVzKCGXw+ARr/YXTQgxvusSK6rjbY9ukxfKgR0ic5+LWb5+NtgXXtQlKTNdHbvc633wJxU83kmsSz7jzPvwker6vF/7D0qkZx8xSO0umaJxekjh+5L27COXQpZizxOw5z24UTZ2VWhWuZaX54PQ/fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 04:35:52 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6%7]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 04:35:51 +0000
References: <20231204105440.61448-1-ryan.roberts@arm.com>
 <20231204105440.61448-15-ryan.roberts@arm.com>
 <87cyvha2xd.fsf@nvdebian.thelocal>
 <ecf129dd-000f-45be-95dc-1e8dad5a8c12@arm.com>
User-agent: mu4e 1.8.13; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier
 <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, James Morse
 <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui
 Yu <yuzenghui@huawei.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>, Andrey Konovalov
 <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo
 Frascino <vincenzo.frascino@arm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Matthew Wilcox <willy@infradead.org>, Yu Zhao
 <yuzhao@google.com>, Mark Rutland <mark.rutland@arm.com>, David
 Hildenbrand <david@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>, Barry Song
 <21cnbao@gmail.com>, Yang Shi <shy828301@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 14/15] arm64/mm: Implement ptep_set_wrprotects() to
 optimize fork()
Date: Fri, 15 Dec 2023 15:32:22 +1100
In-reply-to: <ecf129dd-000f-45be-95dc-1e8dad5a8c12@arm.com>
Message-ID: <87fs0413rx.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0071.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:247::18) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a26376f-8825-4311-eb6a-08dbfd27517a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	trt+lmntNsGCDOyNV6fIKGiAbk5wJxfbcP9kxISCfaPk2JtD5WILcW9/FO+FfglTCNrJBRKJWCsUYeZF4Ir5veYvONiEa9+sDCxfkw3WxwwBH59cy0z45WIDmodHnBdHTHMpJeiadM4K9b8kTTLnAmp7VeNiJtXICd7ynQSgUa/cEnsW6/hcuXb788rwz3OZAYAwL+UeJbYRTpCfkU04HGTafIPeIX3M0N0wiNNFqZRYMXavY5LoRK6d9EeEUl2dNqAc3acfaInvyeVnvb0b8LL7VOKkqC0kMwrI8TC9sbqSp/pfc3A7ApzLyj6KZ+ZLt9R9+TQcF21W4c/tQPZsj99UAxiOCNKl5XfmA+cu1OjPLGRCrWUKyA6wsqpmIUNjN0Y6QWKLCBawCrEVQRbGJDnd6lkswncpM60K/b1gyJ55M42IQ6yxzFZoJgZIpkJTrZVQz4xcPAo40a3SPpnwT5f4F1vr01Ahh64aweZbkoQAqDgIenSqaNQ5R7MFpGZiiVKXrbbO3JEwzFfvUgCVhGUNNIIS0750k5XIAf9YZ1NuoG537V9WCRGGzI8NH/MCQxQYsII1NehQk61/6ZlVa0ANDg9A71zUUreHfBxxqHE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(478600001)(6512007)(9686003)(26005)(6486002)(966005)(54906003)(6916009)(66476007)(66946007)(66556008)(38100700002)(6666004)(83380400001)(53546011)(6506007)(316002)(8676002)(4326008)(8936002)(86362001)(2906002)(7416002)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?COJnr7COUgjmc/JTYOKKkF6nIBvDmVm7u3tHnUcf5VBAw7/TU3gbI3AKVx+r?=
 =?us-ascii?Q?7j2eXg4FTuERgAe8/aV/gzU3p8rE4Z5mB99nViAh4scIDClbYi0BTeZ3L5pM?=
 =?us-ascii?Q?Uhr7Mkjf62OFL3i9fBaa5vhyQ5pTpN346z45dYFs4b+MfIm4Cr8hQy99ZATa?=
 =?us-ascii?Q?Px6atJXMpbz73vfQU29lTzHEsDn//YfA5vCUhwCHk2PC09vkFSc+EKdQyR50?=
 =?us-ascii?Q?VhFA9NTREIMCDYcdpJJljLD7ndjK/ZHlRoS9x4kXGHilDzhbDUQPJMBqII6y?=
 =?us-ascii?Q?8vwBlsTqB00KYpFzQKs9OcTFbtUwrcmOPTsKva5WvxvpwIU+bQyreMO3h40p?=
 =?us-ascii?Q?KUEzhG/1lKjMw2uFz1xSqBTx7kLG+h+Sz4y/zggLjypWLmBqO98KjWPRYE2A?=
 =?us-ascii?Q?j0gONkEmrhOS1C+wsZIyJBGerJv4z05DmYctHLwfzTjUFLTvfx875Zj/lnQK?=
 =?us-ascii?Q?2MYl49tON0okiszeEp+SPtDiyDSUSch/mNBBwu6qCoXpvDwwGe/pe/H2fq/O?=
 =?us-ascii?Q?+xyl5yjPZ7oTysCFnfN4dVpDnJ5DK9kGuQovx+A8D1f2aO6I5bqyBu+jIGvj?=
 =?us-ascii?Q?FK8p+v5z4MZTv3LW0EFtU85z99zqjqjnDS7eXMCD3cLgNeRQkwJVwqVy+t44?=
 =?us-ascii?Q?A8uU+5GyeRV6QYZ/RjSRbCx/SYHDAn3D7q6jVOBM+V4cyUHEPhbwGL0bj4DE?=
 =?us-ascii?Q?Xb+mUJwnsE6dR7ZTUd+/WBAHhhZm9WfL1bWeN2paXMuknnmQslLcAZxJmoEr?=
 =?us-ascii?Q?0adcHTw754ZU7apWjXcjLGoqyif3sQAArK0MLBpiB76AeJWaPVko5awpXoaG?=
 =?us-ascii?Q?c84LWWmGhgUSjbUNzpAXrnZh1EZUMYWEzaNPormyTmW79d5Qwdg1HpmKY0Qd?=
 =?us-ascii?Q?TIu+biBOkNQPd616C76EeLTkqRO1lJ+YZgIrK6mxmNnEvWnJhOpBW00Pou7C?=
 =?us-ascii?Q?swS/BMocmxAcgCnLIeAt7YyE6D1D9uqPZ9rGj0gi3m9NolfJPZi4D1FA4iP1?=
 =?us-ascii?Q?LcvcYQmb3fYRUloZtXz/7Y948LkA5VsYCb4QtKkiqzN2rlI0cvSceB/qJkRi?=
 =?us-ascii?Q?hFT/uIG6XhbSxGn2QzZHGY+/AFpHTluUkrkFPDPMSy/Q9DZDn2OvHbpfsSxT?=
 =?us-ascii?Q?JS5zwwVdeaz9h8VANXodvvVSeIOEfX2AAYwdl98uQpSi4V7E4tAswbqs6RdV?=
 =?us-ascii?Q?ijmD+hPWQEi/g2ga7B61+K8FqCz8MHpR0ZDiigTBVDq1Mxe3t47zLOAGLKYV?=
 =?us-ascii?Q?Hg/RDMBropEGa+qwYnlqz8AlKdLLqkiqnYqAgotuzcAo/9AbWdKDOjO5HBhf?=
 =?us-ascii?Q?51XeST5IrUdHAjHugMB4Pz/E3MTztNxxRey1mWfBWqmzR++xDdutdVPrR8/0?=
 =?us-ascii?Q?NHOkUAbe2i5Lvwxll0nZpMeQrGl8rEzpHdyPKA37PbUO6mtxbiUp00BDHOnH?=
 =?us-ascii?Q?MxXXttFtVchul2fP13OKBKWzxjtaoSR2kggApoRgBx+Dnnx0wviYzSTWzuzV?=
 =?us-ascii?Q?08S0Z6i7DrqCUsh6iyIBwzWRad2NfBq3tPgsnSX8MA+gVjRXnJLCv+3/pEKw?=
 =?us-ascii?Q?/O45PsN+aRrBzbrS7iFU/eZ4Uk4RII5NSwwZVJi6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a26376f-8825-4311-eb6a-08dbfd27517a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 04:35:51.7487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FC9VxVY2YK6zjTE9U8PbWdc1nvoUD63B0rBDjEuGHGGe0BP+MOyMuCDQwsusib0woje34y/w+DWqhxm3UmJxmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354


Ryan Roberts <ryan.roberts@arm.com> writes:

> On 08/12/2023 01:37, Alistair Popple wrote:
>> 
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>> 
>>> With the core-mm changes in place to batch-copy ptes during fork, we can
>>> take advantage of this in arm64 to greatly reduce the number of tlbis we
>>> have to issue, and recover the lost fork performance incured when adding
>>> support for transparent contiguous ptes.
>>>
>>> If we are write-protecting a whole contig range, we can apply the
>>> write-protection to the whole range and know that it won't change
>>> whether the range should have the contiguous bit set or not. For ranges
>>> smaller than the contig range, we will still have to unfold, apply the
>>> write-protection, then fold if the change now means the range is
>>> foldable.
>>>
>>> This optimization is possible thanks to the tightening of the Arm ARM in
>>> respect to the definition and behaviour when 'Misprogramming the
>>> Contiguous bit'. See section D21194 at
>>> https://developer.arm.com/documentation/102105/latest/
>>>
>>> Performance tested with the following test written for the will-it-scale
>>> framework:
>>>
>>> -------
>>>
>>> char *testcase_description = "fork and exit";
>>>
>>> void testcase(unsigned long long *iterations, unsigned long nr)
>>> {
>>> 	int pid;
>>> 	char *mem;
>>>
>>> 	mem = malloc(SZ_128M);
>>> 	assert(mem);
>>> 	memset(mem, 1, SZ_128M);
>>>
>>> 	while (1) {
>>> 		pid = fork();
>>> 		assert(pid >= 0);
>>>
>>> 		if (!pid)
>>> 			exit(0);
>>>
>>> 		waitpid(pid, NULL, 0);
>>>
>>> 		(*iterations)++;
>>> 	}
>>> }
>>>
>>> -------
>>>
>>> I see huge performance regression when PTE_CONT support was added, then
>>> the regression is mostly fixed with the addition of this change. The
>>> following shows regression relative to before PTE_CONT was enabled
>>> (bigger negative value is bigger regression):
>>>
>>> |   cpus |   before opt |   after opt |
>>> |-------:|-------------:|------------:|
>>> |      1 |       -10.4% |       -5.2% |
>>> |      8 |       -15.4% |       -3.5% |
>>> |     16 |       -38.7% |       -3.7% |
>>> |     24 |       -57.0% |       -4.4% |
>>> |     32 |       -65.8% |       -5.4% |
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>  arch/arm64/include/asm/pgtable.h | 30 ++++++++++++++++++++---
>>>  arch/arm64/mm/contpte.c          | 42 ++++++++++++++++++++++++++++++++
>>>  2 files changed, 69 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>>> index 15bc9cf1eef4..9bd2f57a9e11 100644
>>> --- a/arch/arm64/include/asm/pgtable.h
>>> +++ b/arch/arm64/include/asm/pgtable.h
>>> @@ -984,6 +984,16 @@ static inline void __ptep_set_wrprotect(struct mm_struct *mm,
>>>  	} while (pte_val(pte) != pte_val(old_pte));
>>>  }
>>>  
>>> +static inline void __ptep_set_wrprotects(struct mm_struct *mm,
>>> +					unsigned long address, pte_t *ptep,
>>> +					unsigned int nr)
>>> +{
>>> +	unsigned int i;
>>> +
>>> +	for (i = 0; i < nr; i++, address += PAGE_SIZE, ptep++)
>>> +		__ptep_set_wrprotect(mm, address, ptep);
>>> +}
>>> +
>>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>  #define __HAVE_ARCH_PMDP_SET_WRPROTECT
>>>  static inline void pmdp_set_wrprotect(struct mm_struct *mm,
>>> @@ -1139,6 +1149,8 @@ extern int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
>>>  				unsigned long addr, pte_t *ptep);
>>>  extern int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
>>>  				unsigned long addr, pte_t *ptep);
>>> +extern void contpte_set_wrprotects(struct mm_struct *mm, unsigned long addr,
>>> +				pte_t *ptep, unsigned int nr);
>>>  extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>>>  				unsigned long addr, pte_t *ptep,
>>>  				pte_t entry, int dirty);
>>> @@ -1290,13 +1302,25 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>>>  	return contpte_ptep_clear_flush_young(vma, addr, ptep);
>>>  }
>>>  
>>> +#define ptep_set_wrprotects ptep_set_wrprotects
>>> +static inline void ptep_set_wrprotects(struct mm_struct *mm, unsigned long addr,
>>> +				pte_t *ptep, unsigned int nr)
>>> +{
>>> +	if (!contpte_is_enabled(mm))
>>> +		__ptep_set_wrprotects(mm, addr, ptep, nr);
>>> +	else if (nr == 1) {
>> 
>> Why do we need the special case here? Couldn't we just call
>> contpte_set_wrprotects() with nr == 1?
>
> My intention is for this to be a fast path for ptep_set_wrprotect(). I'm having
> to work hard to prevent regressing the order-0 folios case.

This ends up calling three functions anyway so I'm curious - does
removing the one function call really make that much of difference?

Either way I think a comment justifying the special case (ie. that this
is simply a fast path for nr == 1) would be good.

Thanks.

>> 
>>> +		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
>>> +		__ptep_set_wrprotects(mm, addr, ptep, 1);
>>> +		contpte_try_fold(mm, addr, ptep, __ptep_get(ptep));
>>> +	} else
>>> +		contpte_set_wrprotects(mm, addr, ptep, nr);
>>> +}
>>> +
>>>  #define __HAVE_ARCH_PTEP_SET_WRPROTECT
>>>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
>>>  				unsigned long addr, pte_t *ptep)
>>>  {
>>> -	contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
>>> -	__ptep_set_wrprotect(mm, addr, ptep);
>>> -	contpte_try_fold(mm, addr, ptep, __ptep_get(ptep));
>>> +	ptep_set_wrprotects(mm, addr, ptep, 1);
>>>  }
>>>  
>>>  #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
>>> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
>>> index e079ec61d7d1..2a57df16bf58 100644
>>> --- a/arch/arm64/mm/contpte.c
>>> +++ b/arch/arm64/mm/contpte.c
>>> @@ -303,6 +303,48 @@ int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
>>>  }
>>>  EXPORT_SYMBOL(contpte_ptep_clear_flush_young);
>>>  
>>> +void contpte_set_wrprotects(struct mm_struct *mm, unsigned long addr,
>>> +					pte_t *ptep, unsigned int nr)
>>> +{
>>> +	unsigned long next;
>>> +	unsigned long end = addr + (nr << PAGE_SHIFT);
>>> +
>>> +	do {
>>> +		next = pte_cont_addr_end(addr, end);
>>> +		nr = (next - addr) >> PAGE_SHIFT;
>>> +
>>> +		/*
>>> +		 * If wrprotecting an entire contig range, we can avoid
>>> +		 * unfolding. Just set wrprotect and wait for the later
>>> +		 * mmu_gather flush to invalidate the tlb. Until the flush, the
>>> +		 * page may or may not be wrprotected. After the flush, it is
>>> +		 * guarranteed wrprotected. If its a partial range though, we
>>> +		 * must unfold, because we can't have a case where CONT_PTE is
>>> +		 * set but wrprotect applies to a subset of the PTEs; this would
>>> +		 * cause it to continue to be unpredictable after the flush.
>>> +		 */
>>> +		if (nr != CONT_PTES)
>>> +			contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
>>> +
>>> +		__ptep_set_wrprotects(mm, addr, ptep, nr);
>>> +
>>> +		addr = next;
>>> +		ptep += nr;
>>> +
>>> +		/*
>>> +		 * If applying to a partial contig range, the change could have
>>> +		 * made the range foldable. Use the last pte in the range we
>>> +		 * just set for comparison, since contpte_try_fold() only
>>> +		 * triggers when acting on the last pte in the contig range.
>>> +		 */
>>> +		if (nr != CONT_PTES)
>>> +			contpte_try_fold(mm, addr - PAGE_SIZE, ptep - 1,
>>> +					 __ptep_get(ptep - 1));
>>> +
>>> +	} while (addr != end);
>>> +}
>>> +EXPORT_SYMBOL(contpte_set_wrprotects);
>>> +
>>>  int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>>>  					unsigned long addr, pte_t *ptep,
>>>  					pte_t entry, int dirty)
>> 


