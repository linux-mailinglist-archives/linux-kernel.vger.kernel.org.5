Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554E37F3DD3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbjKVGDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjKVGD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:03:29 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44EF10C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 22:03:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TariAfuUSpYzVB4OtkjsiqmKfnxIiMco+EAwgZohI5QOHetw4ZYTDIFxv0sNBlvcg4S+TKz3M6UrOUBdyDtIbkWYX4nYzhATxNG8ZVkpRWpxl9X120LL63LrypFYYNRwR9U+QZBt7HOc1/SnvslHsBoQz/HL43l0Ti3UQTGApH58vlwQkheCZpYiu9eils+XtkctPPaMl2d1ltVQCV7PrvvCVXbHOVwf+9zafoddy52krkAjMLlhTphmAJIgIFlZsYPdz9Hs8ppk8zzzLCwOr4JAfiVQb8RVuAO79ULxtDfVNqBn5bUwe4MtjVThs3T24Olc65vpIoA3ID/uNUM24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2NaTXqkDd4+TO4BPbBavhg6dqkr1zzKs9DUo0Umv2E=;
 b=Apiy6OHPYx4tfF72wztH3B5X6yXAKIAQyl4hXD7tI3/IRm4eQNGwLS8GDH1hJnIlfxCU9pCzJuoiNIWogHrAN/qxturcspEiBCkDyRxUJBEDOG/WfBh+p+IFchhKDuG7hbP2fkZkSkHSlttQHSVb5tlWovsIaSMyvvNqdCC8BVYHNjvjJuUfIDTOaHEOSXXAPW/D6WgKGTOMaD1BMGhuuPDFz9FPukERbtnTXN+6AOsHZJWaA3wDEaQcKVZfFTZC0lSY5f+gffZB9f832JtwTHh7HvfAKMvczL9tbh1tW6X7OFqmSZjVzWlGJcl14U93o8PFnuW932fzIg2sQv4LTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2NaTXqkDd4+TO4BPbBavhg6dqkr1zzKs9DUo0Umv2E=;
 b=R1MQ2ktP5oHuulZh9ZFSiVXK4AKvC9x+1XJPr64okZxt6bKURfbDpKDfLD6hGkmvvl2wOcy+TnvNImefFmdU0NHKVVKGwCOv8ycVFQolb2Ip5ALQ96Gu//+CAHZIDieBl2Nc9o0P9n73TomqXsaWVe0v+zkl3OfNtGw1Jj/sXFe7oewNYm6LUwGmTy/FZYqtFhQcyQyyyQ1tUP5+VNV9TiUrvWbUX5+FOQvKGGr02aNppqtekQBqFZBZwSEFOiYF0Vkqu3rbzPWY0RZHcx55lCXu3jkHMY3DLYwH0EZAm4+gWBk+I+ZayM0Y8y9GxLPZ19aJ9EA4ZyN5V3x3bDMtsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SA1PR12MB8598.namprd12.prod.outlook.com (2603:10b6:806:253::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 06:03:21 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::fb09:9679:bd22:6bcb]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::fb09:9679:bd22:6bcb%7]) with mapi id 15.20.7002.027; Wed, 22 Nov 2023
 06:03:21 +0000
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231115163018.1303287-13-ryan.roberts@arm.com>
 <87v89vmjus.fsf@nvdebian.thelocal>
 <bc49d4df-5d64-4eaf-951c-37dc5d4389d4@arm.com>
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
Subject: Re: [PATCH v2 12/14] arm64/mm: Wire up PTE_CONT for user mappings
Date:   Wed, 22 Nov 2023 17:01:05 +1100
In-reply-to: <bc49d4df-5d64-4eaf-951c-37dc5d4389d4@arm.com>
Message-ID: <87il5umijf.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY0PR01CA0012.ausprd01.prod.outlook.com
 (2603:10c6:10:1bb::20) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|SA1PR12MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: 673b7530-1b79-4103-9367-08dbeb20bace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6YZI0SvxukN0Kl2svv+X8ogbc47hNrtMrQ2rXS3TgnJjiLsBNrBudNgUY0MV0iWK2qhQCi4bYU4AarEGhOTD8fodZb0jdmiFSaT814UMxK7cvZdLs0bbXV3GGzR6lAjUfa3dsHaSTkhEUrJJGXKXmDtweDP5bIXGEuhkiiQKXljWR7F3hZUmPsLvKU69nYvzMPWOT8ODkOPOlH4G8fnzd7EW9MjQ1/ahEPTlOVNIBPNL2xhBCxJLO3SGdbKIE67eNqkSimDXwqycLCTffGG/+Jw8VxGpKqRFlTInUW6ij8P8YMeBOFC/qOCVK0wym4vAUVzgO+rtFCVoU8oaTiySgB1YO0sMEKtpz1uIlY3gDbO6Juij2QI4dHsgV8WO3oG0fLrkTXn6OAlwjN6JOkY5vRljMaspp+3szgSCepdc3VU0g2AamMDr3IV+QOFw396XI89yu8njAQ7mn6rIg0lCGkXBQvllS1pdPtNxrSaD+WwkUGm+VWtD+DCMXvCUp2Y83iNayXUTvEmj9vSSD14/3NMXRrKco7TWisc9iOPWwLlHSKBeHulnTB1CK72FULE0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66899024)(83380400001)(38100700002)(86362001)(66946007)(66476007)(41300700001)(8676002)(54906003)(66556008)(4326008)(8936002)(316002)(7416002)(5660300002)(2906002)(26005)(53546011)(6512007)(6916009)(6486002)(6666004)(478600001)(9686003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+JEGGdd4VRDsE3xNcx186aptY6DB7aNDzz54OM384tQ2kUH2efguVEyzndAb?=
 =?us-ascii?Q?cxKIUgI+1vIB1jen9sgweaWy097Lw9iV9g9zlMX9p75zIihg3XeQZ0U6PwA1?=
 =?us-ascii?Q?3iB65LkUXBHVsl+nyw7QfuWwKvIiw1rsLEprkNf2zbDSN+VJWPC/4ofcbrgO?=
 =?us-ascii?Q?GVbUOdji+lHfUv/0z+IZMnOEwnopqfW8nDbgXVgPr02UJT2pqIVA7mjPuYZ3?=
 =?us-ascii?Q?AS39nj/kG87nvFhZo2fyVytI7yLoAurAefZPkn41diOpNPVWnvA720KDpDoY?=
 =?us-ascii?Q?cv+SZVpcrn4/aekqqzkUSyzJzEL/bXD+uqmBO2s3p18Iv9Clqr1BvCNR7H5/?=
 =?us-ascii?Q?d8jCCE9UjYjEiB9M2SpAF/QfyasYlei+LCIze3yTijcnBIAWzkZUd0bTAwJQ?=
 =?us-ascii?Q?7OCEOV1qK3zEjUWZgSBOBXAj6UAhvJLx8esegISXqOW2RvVZUCy8cik/xtKZ?=
 =?us-ascii?Q?Mua30bvIQJXGeN+PLvAP/GPMe3EZEw4WUJFcT5OS8IZwEQJY0AyaKwrmYL+F?=
 =?us-ascii?Q?yvAX9/2kVbNCyHRNyzVQ+lugAqlmYVsxLm234TaO7nA0vNWVVUah6Cmk8j6L?=
 =?us-ascii?Q?nCKuDIqVtTzk1evksxVQz49ZriCtNJqSCuVM3V4PGksB1J3JDA/IhL3QcQ2M?=
 =?us-ascii?Q?9nDC1Uj/AsaQBk1YRI1pG9wGdqKt3H0R99lFdsty+WGb4JuQ7DDQZE5qewfh?=
 =?us-ascii?Q?dXWool6O6bAi1I1HNLWYcEsPPBhPRwhAGSB1dSk5fV250ju+M8Tp503wIsCR?=
 =?us-ascii?Q?udWzVox9Nj1haIKHRC9vsc0gCwS/Esury/EG+VoEBxrkqouWLHlj1hJsbcVB?=
 =?us-ascii?Q?Gusl1mdmZmy4w9zBoZRIZnLHOuNijxk3X6O/7202bAPCHrUXaBJxeDjswUYc?=
 =?us-ascii?Q?kZ2juHy4ZRzSiSdSE6SKBHLdvOpwyBKnklmZYYKEMizDzHuQ+wf1TQdhpsBm?=
 =?us-ascii?Q?Kz38pRQ5inqSIAdJjXbLa9EWl+q29Aiy/QpfLt06ED6oAKD6eQj14/Cr2RiQ?=
 =?us-ascii?Q?NjgeY5yirXevPrF2f9B3EbWTqoTBkWAdbNoNjLHtbA2xhhKw2dZ+GzVtA+bv?=
 =?us-ascii?Q?yjquDnWbI6hCmYJq9JYKPDhJCMpMHR9XdaAflqSPOTJOQ4xwgOdioBiT2Z2j?=
 =?us-ascii?Q?4E0oqsJDbl4h7dxCYlXTcxyJPSEurjfFw7swPvXcgmtNLjcwY29b8yoqtZqE?=
 =?us-ascii?Q?+YyT0l8MlXVQSdSe5YT7g8dlW5j55H/GttdNzAYISeBf/cztx6A1xK30Oi4j?=
 =?us-ascii?Q?tN6L9dVspVkLwtuEidzcZAqZmy3yKiCBauLTJmDqZThHtUbb3wZI6oAUt6Cl?=
 =?us-ascii?Q?/m2L+NIixnIkBrGu2v+dbyOOHMyFtjAlRalNIo9tm4SOsAtn2iKHuImyZRlr?=
 =?us-ascii?Q?8WUl+edIHyPm4JbxwcXZWBTpwkn/7UFu8jEQyNWP7djR4q7XuaZdRavQJGA0?=
 =?us-ascii?Q?SlHeIwliwF6VyRkCUp7QxUNJ5nv37Fw8pZWE9/d+1n7gd3+hTyTy3Hn8X7wM?=
 =?us-ascii?Q?2+XHotF5WlW9sKTFmk1XW4CUOeQor6CuU3jdKlK1hbwoDNHKx1fcHl2c5Xbm?=
 =?us-ascii?Q?VB44z9gD+lrI9GU/pDCG4XLHu2t2eKfmNc7Wg1Mq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673b7530-1b79-4103-9367-08dbeb20bace
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 06:03:21.0585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIUJ95lEVRKOKrr0SL55q4b+rvbs1TG7luEA718kl6aYG8L013JRu7UMcxZ8Cso8lWnNrO5EYIpHSrKOaBCtOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8598
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ryan Roberts <ryan.roberts@arm.com> writes:

> On 21/11/2023 11:22, Alistair Popple wrote:
>> 
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>> 
>> [...]
>> 
>>> +static void contpte_fold(struct mm_struct *mm, unsigned long addr,
>>> +			pte_t *ptep, pte_t pte, bool fold)
>>> +{
>>> +	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
>>> +	unsigned long start_addr;
>>> +	pte_t *start_ptep;
>>> +	int i;
>>> +
>>> +	start_ptep = ptep = contpte_align_down(ptep);
>>> +	start_addr = addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
>>> +	pte = pfn_pte(ALIGN_DOWN(pte_pfn(pte), CONT_PTES), pte_pgprot(pte));
>>> +	pte = fold ? pte_mkcont(pte) : pte_mknoncont(pte);
>>> +
>>> +	for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE) {
>>> +		pte_t ptent = __ptep_get_and_clear(mm, addr, ptep);
>>> +
>>> +		if (pte_dirty(ptent))
>>> +			pte = pte_mkdirty(pte);
>>> +
>>> +		if (pte_young(ptent))
>>> +			pte = pte_mkyoung(pte);
>>> +	}
>>> +
>>> +	__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
>>> +
>>> +	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
>>> +}
>>> +
>>> +void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
>>> +			pte_t *ptep, pte_t pte)
>>> +{
>>> +	/*
>>> +	 * We have already checked that the virtual and pysical addresses are
>>> +	 * correctly aligned for a contpte mapping in contpte_try_fold() so the
>>> +	 * remaining checks are to ensure that the contpte range is fully
>>> +	 * covered by a single folio, and ensure that all the ptes are valid
>>> +	 * with contiguous PFNs and matching prots. We ignore the state of the
>>> +	 * access and dirty bits for the purpose of deciding if its a contiguous
>>> +	 * range; the folding process will generate a single contpte entry which
>>> +	 * has a single access and dirty bit. Those 2 bits are the logical OR of
>>> +	 * their respective bits in the constituent pte entries. In order to
>>> +	 * ensure the contpte range is covered by a single folio, we must
>>> +	 * recover the folio from the pfn, but special mappings don't have a
>>> +	 * folio backing them. Fortunately contpte_try_fold() already checked
>>> +	 * that the pte is not special - we never try to fold special mappings.
>>> +	 * Note we can't use vm_normal_page() for this since we don't have the
>>> +	 * vma.
>>> +	 */
>>> +
>>> +	struct page *page = pte_page(pte);
>>> +	struct folio *folio = page_folio(page);
>>> +	unsigned long folio_saddr = addr - (page - &folio->page) * PAGE_SIZE;
>>> +	unsigned long folio_eaddr = folio_saddr + folio_nr_pages(folio) * PAGE_SIZE;
>>> +	unsigned long cont_saddr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
>>> +	unsigned long cont_eaddr = cont_saddr + CONT_PTE_SIZE;
>>> +	unsigned long pfn;
>>> +	pgprot_t prot;
>>> +	pte_t subpte;
>>> +	pte_t *orig_ptep;
>>> +	int i;
>>> +
>>> +	if (folio_saddr > cont_saddr || folio_eaddr < cont_eaddr)
>>> +		return;
>>> +
>>> +	pfn = pte_pfn(pte) - ((addr - cont_saddr) >> PAGE_SHIFT);
>>> +	prot = pte_pgprot(pte_mkold(pte_mkclean(pte)));
>>> +	orig_ptep = ptep;
>>> +	ptep = contpte_align_down(ptep);
>>> +
>>> +	for (i = 0; i < CONT_PTES; i++, ptep++, pfn++) {
>>> +		subpte = __ptep_get(ptep);
>>> +		subpte = pte_mkold(pte_mkclean(subpte));
>>> +
>>> +		if (!pte_valid(subpte) ||
>>> +		    pte_pfn(subpte) != pfn ||
>>> +		    pgprot_val(pte_pgprot(subpte)) != pgprot_val(prot))
>>> +			return;
>>> +	}
>>> +
>>> +	contpte_fold(mm, addr, orig_ptep, pte, true);
>>> +}
>>> +EXPORT_SYMBOL(__contpte_try_fold);
>>> +
>>> +void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
>>> +			pte_t *ptep, pte_t pte)
>>> +{
>>> +	/*
>>> +	 * We have already checked that the ptes are contiguous in
>>> +	 * contpte_try_unfold(), so we can unfold unconditionally here.
>>> +	 */
>>> +
>>> +	contpte_fold(mm, addr, ptep, pte, false);
>> 
>> I'm still working my way through the series but 
>
> Thanks for taking the time to review!
>
>> calling a fold during an
>> unfold stood out as it seemed wrong. Obviously further reading revealed
>> the boolean flag that changes the functions meaning but I think it would
>> be better to refactor that.
>
> Yes that sounds reasonable.
>
>> 
>> We could easily rename contpte_fold() to eg. set_cont_ptes() and factor
>> the pte calculation loop into a separate helper
>> (eg. calculate_contpte_dirty_young() or some hopefully better name)
>> called further up the stack. That has an added benefit of providing a
>> spot to add the nice comment for young/dirty rules you provided in the
>> patch description ;-)
>> 
>> In other words we'd have something like:
>> 
>> void __contpte_try_unfold() {
>>      pte = calculate_contpte_dirty_young(mm, addr, ptep, pte);
>>      pte = pte_mknoncont(pte);
>>      set_cont_ptes(mm, addr, ptep, pte);
>> }
>
> My concern with this approach is that calculate_contpte_dirty_young() has side
> effects; it has to clear each PTE as it loops through it prevent a race between
> our reading access/dirty and another thread causing access/dirty to be set. So
> its not just a "calculation", its the teardown portion of the process too. I
> guess its a taste thing, so happy for it to be argued the other way, but I would
> prefer to keep it all together in one function.
>
> How about renaming contpte_fold() to contpte_convert() or contpte_repaint()
> (other suggestions welcome), and extracting the pte_mkcont()/pte_mknoncont()
> part (so we can remove the bool param):
>
> void __contpte_try_unfold() {
> 	pte = pte_mknoncont(pte);
> 	contpte_convert(mm, addr, ptep, pte);
> }

Thanks. That works for me, although sadly I don't have any better ideas
for names atm.

 - Alistair

> Thanks,
> Ryan
>
>> 
>> Which IMHO is more immediately understandable.
>> 
>>  - Alistair
>> 

