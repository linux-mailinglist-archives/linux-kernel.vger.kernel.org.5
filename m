Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A2D7F699C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 00:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjKWXzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 18:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWXy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 18:54:59 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40445D6E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 15:55:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzIQz6aOtiwBdsudGa2L6vzcC9YhHI/zdSkzQNx1Q/oJ06IMu8+zJQaQy9xcrjwXtuPJufO13otZ7CIGViQsf7W3WjGNq9y6dHRc1EmD5v9ZlDDbPnSO+I4C3HPn2YXEx6RXH0NJCyOF63dppf6UPc3kBHnqZPLWAf2cFXOl4IOBq1IPLtnQvfZ+8N8x1dBRFCpDcooc6bmx2DX+vfpwd3u7d10siyHBBv8t1HxdX9DF2idZkcZnR92MPBj20HC19Xh6FaNGHWq35eHStMWPPccj3ZEJxLX4SJY0EftaF74YG5U35GTkNUUVuKH6ZP20L4FVIfj3hzcfwO+Gz89Kdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQkMydNkgpbcWXXUcak4FoTVZFEHXaKMFrvRdcLlh98=;
 b=eZ+quFbwkfmV/kmPnAyHnTSKjYbQ2Mx23qYn8WwNLlb3eK20r+IH0Dmzn8jY90yoIqiygSw/in2SvswdctKDQozlsLAe4Kx0iYkF/H2h0MMBKDDwJN79iMPDzhbl4U0zA1Y/MeWT07o4O4O8H/EfSbKe40ye4j/9nr89ZrfK92SJA+nHcaVLKb+QItOzdCLIdb79Z8z945/62pCLl3ub53GqzhvueXOt2eeTO6aHxh6Ah4/d6NKgjT4RF3SR6/n2qgNdr2BDBlo5VCNXhfvto4631Y8ir+5LRHqxfggv8GyWmaIV7U3Qlwsnov0rZ8awcTJ5p6AwiFH0osiJBM4ZMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQkMydNkgpbcWXXUcak4FoTVZFEHXaKMFrvRdcLlh98=;
 b=RMtSvr7sXOW0G/rGodFU37caCRyTCuhlKRhNYcROwU4HrxuHWHPOuIsqC02ic7mCxDMYmh6wtffye6zkI7nSEx66cnJli5Fov7+NtGBXkBq2VdACogBqnh0Kz2AeMTxE9y2S74tSaXjG4Rd+yExGlBtXeqahen5JoCZ881YH3Azw7RcZwmgEBGxQg8EZj8Zoyki6JAHQbRq8bSIjNTQj2F8jt2RK7c+cYWN5qCJV2mU0SfgJpZX/18sVXEhmqchILymmMxAsnrWWWvK9TrhVOVgtJCvgr/m1q6HiWukj5DU6rhLmWcpNHHI5v7vk+IEfwOZe3nJb2SQeSYdHn2JsdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by PH7PR12MB7260.namprd12.prod.outlook.com (2603:10b6:510:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Thu, 23 Nov
 2023 23:54:59 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 23:54:59 +0000
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231115163018.1303287-2-ryan.roberts@arm.com>
 <87jzq9xfdo.fsf@nvdebian.thelocal>
 <89bc7621-2264-4646-8836-2e2b9105e0b1@arm.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/14] mm: Batch-copy PTE ranges during fork()
Date:   Fri, 24 Nov 2023 10:50:24 +1100
In-reply-to: <89bc7621-2264-4646-8836-2e2b9105e0b1@arm.com>
Message-ID: <8734wwxbxt.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0110.ausprd01.prod.outlook.com
 (2603:10c6:10:1b8::15) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|PH7PR12MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b00f8a-dc8a-4cb7-e623-08dbec7f9956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CDPkOt5GG3mu6C7K0tGhwgQIqanEwir9Q84N+qKSrZ5T7rINK94+AKWBCgzccnDEcfrYVITrOHpCrdTMbnooiqMjwrRDu9AEYRum1jBqbw0ZT3YBoZ2Q5g+qnRq/5iJwQd4AtsFHx3wklCKFnr9uORIMwVjSI7hOl8C3YXqLeg11IPGa5UQH/CHMHM8hcnZXckeahf4dW40pKEF97tqn+Fnn5dGhn9ybgSoVtfW+X4tVwnKo6yjzGiIF+Ms3IidyIiq85JBDI6bG3bxKZ5DGS3s2MhS8sQaavO1ueQccwSPtGhlednpDt5b20Z71aYGKaYBuvCZTYMO3c/ii4oo77nqOmo3aR/H3ADxPw+tVtdmuc91IqvMUwCpKYCkCl01jbzGcaVuFsHDpDLK58VD9ndGOuaMdZwZSbhc7YbmSP7Och3Soi4sRkt4Ik/hKLGqB5Uda7A9eDNrPJauGoco4PUhvwXJ0lxCZZd2/boiCawyiVZzxg1oZaY01ZRfreVCPggNM0init6cjdSRNQZUiokB1H6i47nT1MHrZ4CNcIFerXsckB1cAVrOIFj5+98Ud
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(376002)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(5660300002)(41300700001)(83380400001)(2906002)(30864003)(9686003)(6512007)(26005)(86362001)(7416002)(6506007)(6666004)(66476007)(66946007)(66556008)(54906003)(6916009)(53546011)(478600001)(6486002)(38100700002)(8676002)(4326008)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IySYGU+3zzaQCvkr5nnxzNsYouocxhhw2xqCMv6Cawg6N1dLFkPDvPPE8QLS?=
 =?us-ascii?Q?c5T1KuDtbqTxgn15g2Lw9iaZYMcq87nakOx2RTB+WbRbqjLbXJezk6dqVM62?=
 =?us-ascii?Q?vqQL5VZ1Kivk0xVN3fsK9+zrG4mPU26LcGaXR2wQ6emLxRbPiAgxUcDbISOT?=
 =?us-ascii?Q?E7XbAzeu7UaRSmO8JMHrcDEoen/GcryiY47khVPOWy3KF4WgwcIkpHocZF+o?=
 =?us-ascii?Q?dItaCAwXoWuqm35OJ3sf6pN1prfbdY0jHF/a2jP5CWRgjWuzS9Z6bFf0dJKv?=
 =?us-ascii?Q?vruEyRqRiyZtFIHJqhZ0r5bUn1Fot3SC5xjBN3buBROlAdDkbtAseuKK+Iv+?=
 =?us-ascii?Q?a47fTyivHdjLTkWomA/plqBWykJkkHgDt5xtiIMGZmbkIPBQxJrRFMAQiAJl?=
 =?us-ascii?Q?SV0sM7QhYDBDtGrCHJPyv8V6XZd8Qm+ZUcAT3ZIvaOp/DGlmLBQ45lvC8tSF?=
 =?us-ascii?Q?3ul2cc407c8au7isP60BC93Ar+ZJssxsZAimFHQgX5tJ733tUMU9krC9IZ9U?=
 =?us-ascii?Q?8o0zSzpY2Oz4W9eR/wNciz3Tvob097RUsdyeatbzUVIq6Yfs2KGxCadmflxU?=
 =?us-ascii?Q?hUxn3Sn1yMY+N+CLKMtT9scyrJ1dbUSGzu5+SiNrz42Bduha6svg2qwM+nNw?=
 =?us-ascii?Q?1s4cZMCAU52Kk6a12m5evJy4JgBa046pZ/n7tazYSO1CPzFZo7rJpXD9um2W?=
 =?us-ascii?Q?e/SO7PFGPsDSbaHxQ/OR6e8RuQcWX/EfM6/53ITS9tZjCFeATP04bujrOU4P?=
 =?us-ascii?Q?wI87rvOx6NEiFREz+x32u4Ic9hzkKM0h7Yn5vXmYkKn4vd8yzgEhGacX+dYD?=
 =?us-ascii?Q?0MHm+m7XBUDJCxZUEphaW/HtOECvvz0VqWRMaZEC0T8dfm5luMg3PKJC9Dpo?=
 =?us-ascii?Q?XvRs1TMLb3z8K4jfLRu4/w0KbGxca3LOnx40WOWY5MuI/Vwe6scVKuZ3y78F?=
 =?us-ascii?Q?RFzY6qHziYXAHfnWX+uBx6G2n7snZXyjGKXubw8FY1UW7renXSIvnpNpbJa3?=
 =?us-ascii?Q?ruqA/ySX77mGyokBpF5CZEmWM/UqQLHZSaNN7R+cX73ocgaW0D3vFrSr6R+K?=
 =?us-ascii?Q?IX/esUjGFx2Ta4VKmU+Fyvssv78YGSoN8BX2FDd+1TDRaw+vIXL86zs1B3zC?=
 =?us-ascii?Q?f1/xEzD1XL10Nr2X74WVIN+7V5ztbTGXkCr0D+G1hoDy2cJUdsNRoC7E3BII?=
 =?us-ascii?Q?n1HQzmf6UXTR4b0GpARrc/YcS16hOhOqyME+ytfPM3hT8bWKDPje1XzG9KC9?=
 =?us-ascii?Q?DDWQQp8tqMgcrKKgIpYtGFPFh1RHB0Qd8Lz6umYRI5pt2U2uRukPs/VXSgrz?=
 =?us-ascii?Q?zjP2XwlCvvK43Wyx2ovFaPtkUnDR+OLSqB1PkOTWf9bNl/3tLeVshGfs3re1?=
 =?us-ascii?Q?jKXnAASSHLtZ5yP6GbviRx2FegEQYIiyj8OARAAkJzjLLLf6G222KkzZGOyh?=
 =?us-ascii?Q?ygLflzXLp2ieyQzAcPXKSKB6hAZ+uicaIIClygyXfwBajNrhlZrauIWB3BM7?=
 =?us-ascii?Q?FeuqU0ZrVtMHRnkIZlwxQhiuSMoqyd5wLD9DR19WVYp6Iu2fkgruZPad7HAv?=
 =?us-ascii?Q?4VVWPz7bcbrMRbLki1FnTumHwrkU8OyyonUmUopp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b00f8a-dc8a-4cb7-e623-08dbec7f9956
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 23:54:59.0447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwOoQZOc0x3RM78iTwgTs8kewgsUhvwzIcfhY99fqmUXGIDAfjEIqUH5MrydDQ1aRTnrxUIAbsE/pSWI0yIRNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7260
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ryan Roberts <ryan.roberts@arm.com> writes:

> On 23/11/2023 04:26, Alistair Popple wrote:
>> 
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>> 
>>> Convert copy_pte_range() to copy a set of ptes in a batch. A given batch
>>> maps a physically contiguous block of memory, all belonging to the same
>>> folio, with the same permissions, and for shared mappings, the same
>>> dirty state. This will likely improve performance by a tiny amount due
>>> to batching the folio reference count management and calling set_ptes()
>>> rather than making individual calls to set_pte_at().
>>>
>>> However, the primary motivation for this change is to reduce the number
>>> of tlb maintenance operations that the arm64 backend has to perform
>>> during fork, as it is about to add transparent support for the
>>> "contiguous bit" in its ptes. By write-protecting the parent using the
>>> new ptep_set_wrprotects() (note the 's' at the end) function, the
>>> backend can avoid having to unfold contig ranges of PTEs, which is
>>> expensive, when all ptes in the range are being write-protected.
>>> Similarly, by using set_ptes() rather than set_pte_at() to set up ptes
>>> in the child, the backend does not need to fold a contiguous range once
>>> they are all populated - they can be initially populated as a contiguous
>>> range in the first place.
>>>
>>> This change addresses the core-mm refactoring only, and introduces
>>> ptep_set_wrprotects() with a default implementation that calls
>>> ptep_set_wrprotect() for each pte in the range. A separate change will
>>> implement ptep_set_wrprotects() in the arm64 backend to realize the
>>> performance improvement as part of the work to enable contpte mappings.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>  include/linux/pgtable.h |  13 +++
>>>  mm/memory.c             | 175 +++++++++++++++++++++++++++++++---------
>>>  2 files changed, 150 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>> index af7639c3b0a3..1c50f8a0fdde 100644
>>> --- a/include/linux/pgtable.h
>>> +++ b/include/linux/pgtable.h
>>> @@ -622,6 +622,19 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
>>>  }
>>>  #endif
>>>  
>>> +#ifndef ptep_set_wrprotects
>>> +struct mm_struct;
>>> +static inline void ptep_set_wrprotects(struct mm_struct *mm,
>>> +				unsigned long address, pte_t *ptep,
>>> +				unsigned int nr)
>>> +{
>>> +	unsigned int i;
>>> +
>>> +	for (i = 0; i < nr; i++, address += PAGE_SIZE, ptep++)
>>> +		ptep_set_wrprotect(mm, address, ptep);
>>> +}
>>> +#endif
>>> +
>>>  /*
>>>   * On some architectures hardware does not set page access bit when accessing
>>>   * memory page, it is responsibility of software setting this bit. It brings
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 1f18ed4a5497..b7c8228883cf 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -921,46 +921,129 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
>>>  		/* Uffd-wp needs to be delivered to dest pte as well */
>>>  		pte = pte_mkuffd_wp(pte);
>>>  	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
>>> -	return 0;
>>> +	return 1;
>> 
>> We should update the function comment to indicate why we return 1 here
>> because it will become non-obvious in future. But perhaps it's better to
>> leave this as is and do the error check/return code calculation in
>> copy_present_ptes().
>
> OK, I'll return 0 for success and fix it up to 1 in copy_present_ptes().
>
>> 
>>> +}
>>> +
>>> +static inline unsigned long page_cont_mapped_vaddr(struct page *page,
>>> +				struct page *anchor, unsigned long anchor_vaddr)
>> 
>> It's likely I'm easily confused but the arguments here don't make much
>> sense to me. Something like this (noting that I've switch the argument
>> order) makes more sense to me at least:
>> 
>> static inline unsigned long page_cont_mapped_vaddr(struct page *page,
>>                             unsigned long page_vaddr, struct page *next_folio_page)
>
> I was originally using page_cont_mapped_vaddr() in more places than here and
> needed a more generic helper than just "what is the virtual address of the end
> of the folio, given a random page within the folio and its virtual address"; (I
> needed "what is the virtual address of a page given a different page and its
> virtual address and assuming the distance between the 2 pages is the same in
> physical and virtual space"). But given I don't need that generality anymore,
> yes, I agree I can simplify this significantly.

Thanks for the explaination, that explains my head scratching.

> I think I can remove the function entirely and replace with this in
> folio_nr_pages_cont_mapped():
>
> 	/*
> 	 * Loop either to `end` or to end of folio if its contiguously mapped,
> 	 * whichever is smaller.
> 	 */
> 	floops = (end - addr) >> PAGE_SHIFT;
> 	floops = min_t(int, floops,
> 		       folio_pfn(folio_next(folio)) - page_to_pfn(page));
>
> where `end` and `addr` are the parameters as passed into the function. What do
> you think?

Will admit by the end of the review I was wondering why we even needed
the extra function so looks good to me (the comment helps too!)

>> 
>>> +{
>>> +	unsigned long offset;
>>> +	unsigned long vaddr;
>>> +
>>> +	offset = (page_to_pfn(page) - page_to_pfn(anchor)) << PAGE_SHIFT;
>> 
>> Which IMHO makes this much more readable:
>> 
>> 	offset = (page_to_pfn(next_folio_page) - page_to_pfn(page)) << PAGE_SHIFT;
>> 
>>> +	vaddr = anchor_vaddr + offset;
>>> +
>>> +	if (anchor > page) {
>> 
>> And also highlights that I think this condition (page > folio_page_end)
>> is impossible to hit. Which is good ...
>> 
>>> +		if (vaddr > anchor_vaddr)
>>> +			return 0;
>> 
>> ... because I'm not sure returning 0 is valid as we would end up setting
>> floops = (0 - addr) >> PAGE_SHIFT which doesn't seem like it would end
>> particularly well :-)
>
> This was covering the more general case that I no longer need.
>
>> 
>>> +	} else {
>>> +		if (vaddr < anchor_vaddr)
>> 
>> Same here - isn't the vaddr of the next folio always going to be larger
>> than the vaddr for the current page? It seems this function is really
>> just calculating the virtual address of the next folio, or am I deeply
>> confused?
>
> This aims to protect against the corner case, where a page from a folio is
> mremap()ed very high in address space such that the extra pages from the anchor
> page to the end of the folio would actually wrap back to zero. But with the
> approach propsed above, this problem goes away, I think.
>
>> 
>>> +			return ULONG_MAX;
>>> +	}
>>> +
>>> +	return vaddr;
>>> +}
>>> +
>>> +static int folio_nr_pages_cont_mapped(struct folio *folio,
>>> +				      struct page *page, pte_t *pte,
>>> +				      unsigned long addr, unsigned long end,
>>> +				      pte_t ptent, bool *any_dirty)
>>> +{
>>> +	int floops;
>>> +	int i;
>>> +	unsigned long pfn;
>>> +	pgprot_t prot;
>>> +	struct page *folio_end;
>>> +
>>> +	if (!folio_test_large(folio))
>>> +		return 1;
>>> +
>>> +	folio_end = &folio->page + folio_nr_pages(folio);
>> 
>> I think you can replace this with:
>> 
>> folio_end = folio_next(folio)
>
> yep, done - thanks.
>
>> 
>> Although given this is only passed to page_cont_mapped_vaddr() perhaps
>> it's better to just pass the folio in and do the calculation there.
>> 
>>> +	end = min(page_cont_mapped_vaddr(folio_end, page, addr), end);
>>> +	floops = (end - addr) >> PAGE_SHIFT;
>>> +	pfn = page_to_pfn(page);
>>> +	prot = pte_pgprot(pte_mkold(pte_mkclean(ptent)));
>>> +
>>> +	*any_dirty = pte_dirty(ptent);
>>> +
>>> +	pfn++;
>>> +	pte++;
>>> +
>>> +	for (i = 1; i < floops; i++) {
>>> +		ptent = ptep_get(pte);
>>> +		ptent = pte_mkold(pte_mkclean(ptent));
>>> +
>>> +		if (!pte_present(ptent) || pte_pfn(ptent) != pfn ||
>>> +		    pgprot_val(pte_pgprot(ptent)) != pgprot_val(prot))
>>> +			break;
>>> +
>>> +		if (pte_dirty(ptent))
>>> +			*any_dirty = true;
>>> +
>>> +		pfn++;
>>> +		pte++;
>>> +	}
>>> +
>>> +	return i;
>>>  }
>>>  
>>>  /*
>>> - * Copy one pte.  Returns 0 if succeeded, or -EAGAIN if one preallocated page
>>> - * is required to copy this pte.
>>> + * Copy set of contiguous ptes.  Returns number of ptes copied if succeeded
>>> + * (always gte 1), or -EAGAIN if one preallocated page is required to copy the
>>> + * first pte.
>>>   */
>>>  static inline int
>>> -copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>>> -		 pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
>>> -		 struct folio **prealloc)
>>> +copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>>> +		  pte_t *dst_pte, pte_t *src_pte,
>>> +		  unsigned long addr, unsigned long end,
>>> +		  int *rss, struct folio **prealloc)
>>>  {
>>>  	struct mm_struct *src_mm = src_vma->vm_mm;
>>>  	unsigned long vm_flags = src_vma->vm_flags;
>>>  	pte_t pte = ptep_get(src_pte);
>>>  	struct page *page;
>>>  	struct folio *folio;
>>> +	int nr = 1;
>>> +	bool anon;
>>> +	bool any_dirty = pte_dirty(pte);
>>> +	int i;
>>>  
>>>  	page = vm_normal_page(src_vma, addr, pte);
>>> -	if (page)
>>> +	if (page) {
>>>  		folio = page_folio(page);
>>> -	if (page && folio_test_anon(folio)) {
>>> -		/*
>>> -		 * If this page may have been pinned by the parent process,
>>> -		 * copy the page immediately for the child so that we'll always
>>> -		 * guarantee the pinned page won't be randomly replaced in the
>>> -		 * future.
>>> -		 */
>>> -		folio_get(folio);
>>> -		if (unlikely(page_try_dup_anon_rmap(page, false, src_vma))) {
>>> -			/* Page may be pinned, we have to copy. */
>>> -			folio_put(folio);
>>> -			return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
>>> -						 addr, rss, prealloc, page);
>>> +		anon = folio_test_anon(folio);
>>> +		nr = folio_nr_pages_cont_mapped(folio, page, src_pte, addr,
>>> +						end, pte, &any_dirty);
>>> +
>>> +		for (i = 0; i < nr; i++, page++) {
>>> +			if (anon) {
>>> +				/*
>>> +				 * If this page may have been pinned by the
>>> +				 * parent process, copy the page immediately for
>>> +				 * the child so that we'll always guarantee the
>>> +				 * pinned page won't be randomly replaced in the
>>> +				 * future.
>>> +				 */
>>> +				if (unlikely(page_try_dup_anon_rmap(
>>> +						page, false, src_vma))) {
>>> +					if (i != 0)
>>> +						break;
>>> +					/* Page may be pinned, we have to copy. */
>>> +					return copy_present_page(
>>> +						dst_vma, src_vma, dst_pte,
>>> +						src_pte, addr, rss, prealloc,
>>> +						page);
>>> +				}
>>> +				rss[MM_ANONPAGES]++;
>>> +				VM_BUG_ON(PageAnonExclusive(page));
>>> +			} else {
>>> +				page_dup_file_rmap(page, false);
>>> +				rss[mm_counter_file(page)]++;
>>> +			}
>>>  		}
>>> -		rss[MM_ANONPAGES]++;
>>> -	} else if (page) {
>>> -		folio_get(folio);
>>> -		page_dup_file_rmap(page, false);
>>> -		rss[mm_counter_file(page)]++;
>>> +
>>> +		nr = i;
>>> +		folio_ref_add(folio, nr);
>>>  	}
>>>  
>>>  	/*
>>> @@ -968,24 +1051,28 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>>>  	 * in the parent and the child
>>>  	 */
>>>  	if (is_cow_mapping(vm_flags) && pte_write(pte)) {
>>> -		ptep_set_wrprotect(src_mm, addr, src_pte);
>>> +		ptep_set_wrprotects(src_mm, addr, src_pte, nr);
>>>  		pte = pte_wrprotect(pte);
>>>  	}
>>> -	VM_BUG_ON(page && folio_test_anon(folio) && PageAnonExclusive(page));
>>>  
>>>  	/*
>>> -	 * If it's a shared mapping, mark it clean in
>>> -	 * the child
>>> +	 * If it's a shared mapping, mark it clean in the child. If its a
>>> +	 * private mapping, mark it dirty in the child if _any_ of the parent
>>> +	 * mappings in the block were marked dirty. The contiguous block of
>>> +	 * mappings are all backed by the same folio, so if any are dirty then
>>> +	 * the whole folio is dirty. This allows us to determine the batch size
>>> +	 * without having to ever consider the dirty bit. See
>>> +	 * folio_nr_pages_cont_mapped().
>>>  	 */
>>> -	if (vm_flags & VM_SHARED)
>>> -		pte = pte_mkclean(pte);
>>> -	pte = pte_mkold(pte);
>>> +	pte = pte_mkold(pte_mkclean(pte));
>>> +	if (!(vm_flags & VM_SHARED) && any_dirty)
>>> +		pte = pte_mkdirty(pte);
>>>  
>>>  	if (!userfaultfd_wp(dst_vma))
>>>  		pte = pte_clear_uffd_wp(pte);
>>>  
>>> -	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
>>> -	return 0;
>>> +	set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
>>> +	return nr;
>>>  }
>>>  
>>>  static inline struct folio *page_copy_prealloc(struct mm_struct *src_mm,
>>> @@ -1087,15 +1174,28 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>>>  			 */
>>>  			WARN_ON_ONCE(ret != -ENOENT);
>>>  		}
>>> -		/* copy_present_pte() will clear `*prealloc' if consumed */
>>> -		ret = copy_present_pte(dst_vma, src_vma, dst_pte, src_pte,
>>> -				       addr, rss, &prealloc);
>>> +		/* copy_present_ptes() will clear `*prealloc' if consumed */
>>> +		ret = copy_present_ptes(dst_vma, src_vma, dst_pte, src_pte,
>>> +				       addr, end, rss, &prealloc);
>>> +
>>>  		/*
>>>  		 * If we need a pre-allocated page for this pte, drop the
>>>  		 * locks, allocate, and try again.
>>>  		 */
>>>  		if (unlikely(ret == -EAGAIN))
>>>  			break;
>>> +
>>> +		/*
>>> +		 * Positive return value is the number of ptes copied.
>>> +		 */
>>> +		VM_WARN_ON_ONCE(ret < 1);
>>> +		progress += 8 * ret;
>>> +		ret--;
>> 
>> Took me a second to figure out what was going on here. I think it would
>> be clearer to rename ret to nr_ptes ...
>> 
>>> +		dst_pte += ret;
>>> +		src_pte += ret;
>>> +		addr += ret << PAGE_SHIFT;
>>> +		ret = 0;
>>> +
>>>  		if (unlikely(prealloc)) {
>>>  			/*
>>>  			 * pre-alloc page cannot be reused by next time so as
>>> @@ -1106,7 +1206,6 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>>>  			folio_put(prealloc);
>>>  			prealloc = NULL;
>>>  		}
>>> -		progress += 8;
>>>  	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
>> 
>> ... and do dst_pte += nr_ptes, etc. here instead (noting of course that
>> the continue clauses will need nr_ptes == 1, but perhpas reset that at
>> the start of the loop).
>
> Yes, much cleaner! Implementing for v3...
>
> Thanks for the review!
>
> Thanks,
> Ryan
>
>> 
>>>  	arch_leave_lazy_mmu_mode();
>> 

