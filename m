Return-Path: <linux-kernel+bounces-6385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A569B81982E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B509288729
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC7D11C88;
	Wed, 20 Dec 2023 05:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ltsZjCnt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B089711715
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 05:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZlbFA9c3NafmDjNOI2dFg1XaXQ+4TguUBDOxEtby18E69aTSHtp/L1sXbFMiAruRBPFNnSXCXRihuYTLdB4rnPk11gLQmMxdn2ZyQY2j+0pIX0uT0x2uG6Uoc6tjutgosnNZADggsPUD2sNhsamESXCw50jZ2XvOwe7CryGpu/qUwpqk1sFH8UDa5JSaln9TofslKDK5KmPpGFzoxvJIQIPWNYeoNSxz4Z8uo5ToNIQyHhtbg9nwtXTjTGY4/0RZNMETCldbwXtanD37YOWDb1XyXqILC31NBkcbSMMwKsM8yFp8bgcJG51/cUDgiF9J4yqWt2AL+OYapOuSBcqGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+jymMTMIwdw354GyElHZ6IXnQ7aTXhvJg1hhm3Dkpc=;
 b=GqpTaHDudgjJNOapgs4lwJEAlaQU0UNYPk7Hzmy9ftVa/MzB7hK7c1kBdJuoIg8fnlIQjnYImtjwgjnA06uwqlhV1K3DGb5hYUuZ7NzMNUBFTZa6faT10N+NLdHIbmse3EdhQiRBGYIkgepmrQJ2qqLagvPF6/YVNHcVJP/od8WdIHg3TS9tJgg2dwKn78GVf4AktLhgz9G988alhCki5Y/JYUtiRRzGGP8s2ydwyvWFc7Ub1j995raH17MxvKoGJYXRhhktuXp5cXC+1/nS1MCESYz4WwM9UQPKHb82WTd1at2TkhQ+5POzGWL520uqh02Lcd7jXp89/1UZxqoZNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+jymMTMIwdw354GyElHZ6IXnQ7aTXhvJg1hhm3Dkpc=;
 b=ltsZjCntqqdcvYBckqnVvWlli9Gj+yGxmmvNFmXDDrODuchUvZw3b0W2OrLLYRlsviYP0ffYpJupaJFfnIkeIT2KHm9Hez7cA2a5j0NiVmY9igcj8ArZLmGgUGBJI4jwniv/WwAG7bkW6vOdllfaAttVmVNHapogpZ4NOSLvoSx0LCOlg/LxkjbF8Qoy2oH7LqVWGWlvJ7ch37vC7/+sGdLu1qWJK+BwmHq8uZSdtFCi9x5xSZHt0A/2UDk5AgYUrNjhd0gQLfaCGq4h3M8XT7AlnbzcyEKTls0inbo02s+qKlaaeCAAFHsjADNk4om7Pv+kGM4as5Aus0o+ZgPDSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18)
 by SN7PR12MB7417.namprd12.prod.outlook.com (2603:10b6:806:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 05:32:33 +0000
Received: from DM6PR12MB3179.namprd12.prod.outlook.com
 ([fe80::5fef:7167:36e:76cd]) by DM6PR12MB3179.namprd12.prod.outlook.com
 ([fe80::5fef:7167:36e:76cd%4]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 05:32:33 +0000
References: <20231218105100.172635-1-ryan.roberts@arm.com>
 <20231218105100.172635-17-ryan.roberts@arm.com>
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
Subject: Re: [PATCH v4 16/16] arm64/mm: Implement clear_ptes() to optimize
 exit, munmap, dontneed
Date: Wed, 20 Dec 2023 16:28:25 +1100
In-reply-to: <20231218105100.172635-17-ryan.roberts@arm.com>
Message-ID: <87v88tzbfe.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0025.ausprd01.prod.outlook.com
 (2603:10c6:10:1f9::10) To MN2PR12MB3181.namprd12.prod.outlook.com
 (2603:10b6:208:ae::27)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3179:EE_|SN7PR12MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: f9c30a7b-efff-4061-4a65-08dc011d1077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4Dl54NS20/+dbgTZbQ2+LgmfuEOsKLDHpt5dljkZhPuYMZtwLAWr628TQDUDMcHxuf+/mp07VWssz43fCaTzXu2/8zurEHZCkYpz76GjZxKWCq7QqSm4/wEkc4Vrj8UuAEObJQZ+gmpGceuvQ21Xpo80r4jlUUbFv7IsHXQ2SKmagDSXpt8oZACa0duKAYzS8ameJvNdMkfT8iLPzD464qN+B49w7jzLqfQDrGWxpfKZKlxs3ZgW/HQ9aKs70mRZfKnniUKUG9XmhVF1wr+4siwzAZS1+TINYylhbMl1w70JJodIqDuAU/Vz+wmVt0u0r+HzpT2WrXF/F9QtZuvzZG7XGhjsbMCridWR/i8lNSaIb994pA/6Bx+Av4GQObPIxlbpOgXmhLz598WgoD2s9AjnvrOLFNPVmrAKJ1q1nj6sttt2j7Bligv9jpZ2pharhwGHnbh89plH8l1HpeW9Z01PdSDUH4Yx2rjJM0aegSBIXqB4B1xG5Wls7Aqw0vCyyvfVI4rSVNsfWk1tn6+gJRBkYWcWNlL+BsqRNYtpsQArk0yT67JBkteaxJTn58D0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(66556008)(66946007)(83380400001)(6916009)(316002)(7416002)(54906003)(66476007)(2906002)(8936002)(8676002)(9686003)(5660300002)(4326008)(38100700002)(6512007)(6666004)(6486002)(6506007)(86362001)(478600001)(26005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ac3KOXQKyn9tT27Y95HwPTJKIounIu8+wfi4Ev6TTwjFWwurc4jnYzj3rw1L?=
 =?us-ascii?Q?Qbij8Lu+NQLbtxjQSQkjGQiifJ1SyFKyxuovSweeO7kjkcx9EFGPEn8/lukg?=
 =?us-ascii?Q?ko47iBV4kSRD3bWzj70DKdxXgb5UtjMu08KgMgyG1b4XsCoJJ8lEFo7TvGmh?=
 =?us-ascii?Q?J+WC5NoSmcZpCN3udKL6QCHR/LRnrEyBbY4ODCZPBlagK5bKhquxWxQsOXYB?=
 =?us-ascii?Q?48vYl2pHvJpMJZowzwS1/91oHLQlQzHVQgHsVWQxnliYCReb3iWuCELBZ/QZ?=
 =?us-ascii?Q?nWYgad7iwwNzo3T/atb72pTSDWYZuwaXIOsHmQXWdChHb9duoVAEKq5RAsmi?=
 =?us-ascii?Q?hXYOUZp3IrC+pgXNq5Ps7O6aGrNcAWyxFXJa5GDpB9tLYsabONJf7vDNSXyx?=
 =?us-ascii?Q?brTEd7TWiAVbM1Y80oZ5U1N4I65l/F/oV8lzki0n+T1OVat1AVwmdRgJkgY7?=
 =?us-ascii?Q?EufTKJyDx8iaQo64SdnczmfMxGxqnt6ugvkqV4WWJnYTfKGqs+5WMjZv4avV?=
 =?us-ascii?Q?kWcHi47Cb1kSacxgY6FTvcEfqwmq7B5d4MAk8B8K8h5LBWB0teYhfmO83WLZ?=
 =?us-ascii?Q?FBO6uQOUDH5xs6IkKXmBOORPoYwjTUrDn93INCaMfZ/HXuiKwPXZl/SBtZkc?=
 =?us-ascii?Q?1UuTQV1IbZiWwtg7owpkayoovbguiftoz1acdh5+eNSz7yCx3rE6wkqi6Nog?=
 =?us-ascii?Q?ju4ENYJWaNsYjxQsUfR6VS5WKFi4ZxRkt5D0U54mv0Lg1JCa92HPjeAjdHt0?=
 =?us-ascii?Q?Uq6DUz1n87HMjQgauUOwlRzYDZbPFL1h1jckZznofmL0K/k6CSESrCFmxmNl?=
 =?us-ascii?Q?eGD1kALbrr8Hu/wua8qnG3byrp9TwrfkaltoMnrcc+q30lsVlowtfC7nA5Df?=
 =?us-ascii?Q?UEsG+J5lz6ewbObiiHAtK5764Eefzuc7x57XIclrBAHUnOFljI7pyr9v4FGT?=
 =?us-ascii?Q?JdfmzjYlrNwYI0apYFoXf/rceEWqr8+kWCxV/8F6ycb/AQA6ncI+snMUkeU+?=
 =?us-ascii?Q?HWbG2QYyrYgFkjlnprLFWJ1kEZgpQe9Viw3KnO6EYCWCElH9+aR6Z8rPQiFP?=
 =?us-ascii?Q?zCYwuU14uHE80m4rQfigcHF4ku9B2WvOvlpmpWcmZfmOyO/krIF03ft/XFtq?=
 =?us-ascii?Q?d9tAP77i71znxHhtLVxGTstCGOjKw3XOPSoEDXkpfA1fLfXhmcQtuKpT43FJ?=
 =?us-ascii?Q?6YWKQu3gfwiWD2MQDSO0q2sbFSMnU/nxPrA0q7SXCygW2xno3IhuqgHizL2D?=
 =?us-ascii?Q?IyAFnr0y+MZqUkHvoQLLYLdAzdJgkRGbdVzc+Tmu5VIGwtY4Px+vMc0hLaJm?=
 =?us-ascii?Q?pXdKO0znLFZQ6+mQq0fnH825N1eM2kzeAJ1amYriSwqm8olhl7AD5Tn3gLDd?=
 =?us-ascii?Q?QkIPNtRq8OQV43ZFsqsexILl3/HhPcOWpojp7hIAERAHAaPRIu/Au+eBGgDO?=
 =?us-ascii?Q?q6fBVbr4SkRy/aa2II3SUUWgVa+2/1e9Eapc4qDp+tDbYb6VM1ymrkMhGBMq?=
 =?us-ascii?Q?JqztOgnjYiwEBZJ+KtdSGC70AK1nywVu1YuUlz04PeMUa92i+NEsa5n4o6d3?=
 =?us-ascii?Q?pfIGzUGOe5J02Kh80GB67oUgnFvgE6ZOrelZMz4o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c30a7b-efff-4061-4a65-08dc011d1077
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 05:32:33.1930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZXqpmekV10ZX05O0JUDlcIPlMbcK6vojMmw8fBVLDa/xU9Hs4ytaJGDtyzUaL60f5N2SPusN7/OC5kYQFjy5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7417


Ryan Roberts <ryan.roberts@arm.com> writes:

> With the core-mm changes in place to batch-clear ptes during
> zap_pte_range(), we can take advantage of this in arm64 to greatly
> reduce the number of tlbis we have to issue, and recover the lost
> performance in exit, munmap and madvise(DONTNEED) incured when adding
> support for transparent contiguous ptes.
>
> If we are clearing a whole contpte range, we can elide first unfolding
> that range and save the tlbis. We just clear the whole range.
>
> The following microbenchmark results demonstate the effect of this
> change on madvise(DONTNEED) performance for large pte-mapped folios.
> madvise(dontneed) is called for each page of a 1G populated mapping and
> the total time is measured. 100 iterations per run, 8 runs performed on
> both Apple M2 (VM) and Ampere Altra (bare metal). Tests performed for
> case where 1G memory is comprised of pte-mapped order-9 folios. Negative
> is faster, positive is slower, compared to baseline upon which the
> series is based:
>
> | dontneed      |    Apple M2 VM    |    Ampere Altra   |
> | order-9       |-------------------|-------------------|
> | (pte-map)     |    mean |   stdev |    mean |   stdev |
> |---------------|---------|---------|---------|---------|
> | baseline      |    0.0% |    7.9% |    0.0% |    0.0% |
> | before-change |   -1.3% |    7.0% |   13.0% |    0.0% |
> | after-change  |   -9.9% |    0.9% |   14.1% |    0.0% |
>
> The memory is initially all contpte-mapped and has to be unfolded (which
> requires tlbi for the whole block) when the first page is touched (since
> the test is madvise-ing 1 page at a time). Ampere Altra has high cost
> for tlbi; this is why cost increases there.
>
> The following microbenchmark results demonstate the recovery (and
> overall improvement) of munmap performance for large pte-mapped folios.
> munmap is called for a 1G populated mapping and the function runtime is
> measured. 100 iterations per run, 8 runs performed on both Apple M2 (VM)
> and Ampere Altra (bare metal). Tests performed for case where 1G memory
> is comprised of pte-mapped order-9 folios. Negative is faster, positive
> is slower, compared to baseline upon which the series is based:
>
> | munmap        |    Apple M2 VM    |    Ampere Altra   |
> | order-9       |-------------------|-------------------|
> | (pte-map)     |    mean |   stdev |    mean |   stdev |
> |---------------|---------|---------|---------|---------|
> | baseline      |    0.0% |    6.4% |    0.0% |    0.1% |
> | before-change |   43.3% |    1.9% |  375.2% |    0.0% |
> | after-change  |   -6.0% |    1.4% |   -0.6% |    0.2% |
>
> Tested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 42 +++++++++++++++++++++++++++++
>  arch/arm64/mm/contpte.c          | 45 ++++++++++++++++++++++++++++++++
>  2 files changed, 87 insertions(+)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index d4805f73b9db..f5bf059291c3 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -953,6 +953,29 @@ static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
>  	return pte;
>  }
>  
> +static inline pte_t __clear_ptes(struct mm_struct *mm,
> +				 unsigned long address, pte_t *ptep,
> +				 unsigned int nr, int full)

Ping on my previous comment - why not just use the generic version
defined in patch 3 which is basically identical to this?

> +{
> +	pte_t orig_pte = __ptep_get_and_clear(mm, address, ptep);
> +	unsigned int i;
> +	pte_t pte;
> +
> +	for (i = 1; i < nr; i++) {
> +		address += PAGE_SIZE;
> +		ptep++;
> +		pte = __ptep_get_and_clear(mm, address, ptep);
> +
> +		if (pte_dirty(pte))
> +			orig_pte = pte_mkdirty(orig_pte);
> +
> +		if (pte_young(pte))
> +			orig_pte = pte_mkyoung(orig_pte);
> +	}
> +
> +	return orig_pte;
> +}
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
>  static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
> @@ -1151,6 +1174,8 @@ extern pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte);
>  extern pte_t contpte_ptep_get_lockless(pte_t *orig_ptep);
>  extern void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
>  				pte_t *ptep, pte_t pte, unsigned int nr);
> +extern pte_t contpte_clear_ptes(struct mm_struct *mm, unsigned long addr,
> +				pte_t *ptep, unsigned int nr, int full);
>  extern int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
>  				unsigned long addr, pte_t *ptep);
>  extern int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
> @@ -1279,6 +1304,22 @@ static inline void pte_clear(struct mm_struct *mm,
>  	__pte_clear(mm, addr, ptep);
>  }
>  
> +#define clear_ptes clear_ptes
> +static inline pte_t clear_ptes(struct mm_struct *mm,
> +				unsigned long addr, pte_t *ptep,
> +				unsigned int nr, int full)
> +{
> +	pte_t pte;
> +
> +	if (nr == 1) {
> +		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
> +		pte = __ptep_get_and_clear(mm, addr, ptep);
> +	} else
> +		pte = contpte_clear_ptes(mm, addr, ptep, nr, full);
> +
> +	return pte;
> +}
> +
>  #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>  				unsigned long addr, pte_t *ptep)
> @@ -1366,6 +1407,7 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
>  #define set_pte					__set_pte
>  #define set_ptes				__set_ptes
>  #define pte_clear				__pte_clear
> +#define clear_ptes				__clear_ptes
>  #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
>  #define ptep_get_and_clear			__ptep_get_and_clear
>  #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> index 72e672024785..6f2a15ac5163 100644
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -293,6 +293,51 @@ void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
>  }
>  EXPORT_SYMBOL(contpte_set_ptes);
>  
> +pte_t contpte_clear_ptes(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
> +					unsigned int nr, int full)
> +{
> +	/*
> +	 * If we cover a partial contpte block at the beginning or end of the
> +	 * batch, unfold if currently folded. This makes it safe to clear some
> +	 * of the entries while keeping others. contpte blocks in the middle of
> +	 * the range, which are fully covered don't need to be unfolded because
> +	 * we will clear the full block.
> +	 */
> +
> +	unsigned int i;
> +	pte_t pte;
> +	pte_t tail;
> +
> +	if (!mm_is_user(mm))
> +		return __clear_ptes(mm, addr, ptep, nr, full);
> +
> +	if (ptep != contpte_align_down(ptep) || nr < CONT_PTES)
> +		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
> +
> +	if (ptep + nr != contpte_align_down(ptep + nr))
> +		contpte_try_unfold(mm, addr + PAGE_SIZE * (nr - 1),
> +				   ptep + nr - 1,
> +				   __ptep_get(ptep + nr - 1));
> +
> +	pte = __ptep_get_and_clear(mm, addr, ptep);
> +
> +	for (i = 1; i < nr; i++) {
> +		addr += PAGE_SIZE;
> +		ptep++;
> +
> +		tail = __ptep_get_and_clear(mm, addr, ptep);
> +
> +		if (pte_dirty(tail))
> +			pte = pte_mkdirty(pte);
> +
> +		if (pte_young(tail))
> +			pte = pte_mkyoung(pte);
> +	}
> +
> +	return pte;
> +}
> +EXPORT_SYMBOL(contpte_clear_ptes);
> +
>  int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
>  					unsigned long addr, pte_t *ptep)
>  {


