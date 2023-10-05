Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B9F7BA2A3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjJEPnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbjJEPnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:43:16 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953D26CE20
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:59:42 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231005145941euoutp017c6ee15e9caedeb35006104be7855547~LPh2YidtU0696006960euoutp01K
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 14:59:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231005145941euoutp017c6ee15e9caedeb35006104be7855547~LPh2YidtU0696006960euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696517981;
        bh=kv1XbryM/4hyjT8ksqwMNLQDnKyVNj/mgAD4JrEfOcI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Xopd5OCLuaHs3u649w1Tf3P0ef2GtglTMjsu2sm3oZh1dtd/1oj+q79SVXqeBAcPw
         f0CdJniw7FlHpdumE9z/uOAFRvRVQmCw2OTWZF3onc7MZ26yN8Te7OscIF6v5vS+//
         0E4s1AV2413weh31wTcS5ZA018wp+tNeXVG1XcTU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231005145941eucas1p1fba8a4fa75c142e27e82f6eefc0dc9eb~LPh19XmP41452414524eucas1p1n;
        Thu,  5 Oct 2023 14:59:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 1E.2E.11320.C5FCE156; Thu,  5
        Oct 2023 15:59:40 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231005145940eucas1p12ce3ae9d5d22d43de53a3bbac23c8fb0~LPh1iSxiB3111231112eucas1p1p;
        Thu,  5 Oct 2023 14:59:40 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231005145940eusmtrp2b9c18572df9fe037205b349bf1e7f08c~LPh1hchxp0184101841eusmtrp2q;
        Thu,  5 Oct 2023 14:59:40 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-99-651ecf5ca237
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0C.CE.10549.C5FCE156; Thu,  5
        Oct 2023 15:59:40 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231005145940eusmtip1960070dfc27572727e0b1702a3c332a6~LPh1TJkjM2561825618eusmtip15;
        Thu,  5 Oct 2023 14:59:40 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Thu, 5 Oct 2023 15:59:39 +0100
Received: from CAMSVWEXC01.scsc.local ([::1]) by CAMSVWEXC01.scsc.local
        ([fe80::7d73:5123:34e0:4f73%13]) with mapi id 15.00.1497.012; Thu, 5 Oct
        2023 15:59:39 +0100
From:   Daniel Gomez <da.gomez@samsung.com>
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Yin Fengwei" <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        "Yu Zhao" <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 5/9] mm: thp: Extend THP to allocate anonymous large
 folios
Thread-Topic: [PATCH v6 5/9] mm: thp: Extend THP to allocate anonymous large
        folios
Thread-Index: AQHZ94QtqHgx5j+4/ESVMKx2qfqGCLA7FPcAgAAkVwA=
Date:   Thu, 5 Oct 2023 14:59:39 +0000
Message-ID: <20231005145934.mig3zb4jlirk64mw@sarkhan>
In-Reply-To: <7631d121-e207-4612-9e22-ce027c8414b7@arm.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.103]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E51BCD68B1A1174EA9D1FC5691DD55B2@scsc.local>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1DTdRjH+2zfXyznfZtDPicp3UISRKQu4iP2wyuPvpp5xcl5omULvqEF
        kzZn2lVueSnsJrcLTNzWGD9yiFOOgYK40EiSHTK6ZOD8gXOBCqk7xgwFZDG+VPvv9TzP+3m/
        n8/dh+KLjMQCartsJyuXSfMkhAA7/dtj57It3YvYZO3dV5Cxzkqg1o5s5DuqBehh3Tgf9XTe
        46FBfzGG1H4jQPWDlSRy3zFiyPZnL44utxgJ1G8N4uiKbhCg/dX1PKQ9ewggc0cVQAZ1MUAT
        j6YlDn0Jhh7oAjgytPeTqyIZq8kKmDP6GyRjtimZhpoEpso+xGNstUUEY/N/TzIdZRMYY3K8
        zzRU72UO7ntAML5WF8FcMl8gmVHbovfmZglezWHztu9i5ctf/0iwrVvrwQrUm3d3ndLiKtD7
        tgZEUJB+GY6dbyI0QECJ6BoArY5anCsCALqDTRhXjAL42GADGkDNrPi8b3B9C4AtVX3gP9H5
        Q4WzG50Alg2o/zfuOVZOhBIJOh62OmxkaCCmHTi8FjzMDxV8+hcAv/1uDA+p5tEboOtyPRZi
        MZ0Jm0/8jnOcBl3qUTLEGB0Lq4bKydBRQjoFNvu3htoR9Ep4v9s1EwbohdB7bHxGzqej4NWB
        ch737GdgpcHO53g+nGq5RXCcCLv6BgDHyfDUT60YxxI4WVgBOJ9EaD7rJzheAR0P+2Z5KTxa
        8deMp3Da33FkYHY3IIBn3FEcr4YenWc2ax4cvthI6kCiPuw8fViEPixCHxahD4swA7wWRLFK
        RX4uq3hJxn6RpJDmK5Sy3KTsHfk2MP2BO6cuBpqBZXgkqQ3wKNAGIMWXiIW5qmdZkTBHuudL
        Vr5jq1yZxyraQDSFSaKES19zZIvoXOlO9jOWLWDl/055VMQCFY/e5yv9+ZP7FG9ld/HGz3ct
        SXXCsiXkRMEPWc+do56us5tiN50rOnC789d1gxmxuzdYDr/jGVFZWkorU8XXg5ahD+W9T+L+
        qHlLr34UndKeGvygdsWF9P6ExuyYZWvviObD1bfj1uWsmrRniqJ1m58vDIr9quS4fEAFblXP
        mduQwp+83tF0ryfjZpZ/IjJe8um739zYaOiLSYg3HfAWte9XfUVjcWtGBBqNc2+OLP2JKTKt
        6KlAkBpvHr4GrlReKk1/szhx8RhYn+rxfly40B0vqphjNi1fnKV33nX9/TU+VXLyuKZEGchr
        bMv8sSdtU8wLdp+3a09pQ7/y5tr1zgz3iasSTLFN+mICX66Q/gP1PKOCLwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUybVRTHd/vytCXr9lgguyIi1mUqYtdCy24nAn7yWfYFxmYmTLGBh7JA
        W9KXhQ0WqEbHKjJkErWtXTtgMECgxTJ00Ck6oKukIVtBN4c6qAandJShlRJmXzDpt989Of//
        Of+bw6RyLmJJzONyNamUS6q4WBzNtTl598Vj7hSS3/VFEjIO9GHIMVWKfJeaAFobWKeiW64/
        Kcjrb6Yhrd8IkNV7kYF+/N1IQ7aFWTq6+ZURQ/N9j+johxYvQO91WCmo6WobQOapdoAM2maA
        goFQi1N/noaWWx7SkeH6PCMvkegz9QHiS/1dBmG2aYih7jSifXSJQth6zmKEzd/KIKY+CdII
        k7OAGOqoJz54ZxkjfA4PRnxv/o5BrNpS8ncU8bKVCo2aTK1QqNQvc4sFKIMnECNehlDME2Tu
        e2N/hoi7Nye7jKw6foJU7s15i1fhbvqFVq0trpm2N9EbwOyrOsBkQlwIffdydSCOycE7AXSN
        LtN0gBWqJ0PrQw89yvFwY1aHhZmDrwBoaNdE2QXgxHx5lLsBXHRRwozhz0OH08YImybgTjqc
        W/kVCz+o+DUAPXZLZEI8fhh6blojnIAfgWM/rWFR3g892lVGmGn4bti+dIER3pSNi+CIvyS6
        qYkC5/6+Felh4S/Bv9yeiBbgT8J7l9cjdSq+C95evECJJsBhx6ibGuVEuLSwuZUsHU7PLYIo
        86G907GVngs3Gi0g6pMOzVf9WJTF0Lk2t8UvwEuW+xFPNv4YdH66SGsByfqY0foYuT5Gro+R
        62PkZkDvAQmkRiWTylQCnkoiU2nkUl6pQmYDoWMdnvh3aASY/ljhjQMKE4wDyKRyE9jShmSS
        wy6TnDxFKhUlSk0VqRoHotDffUhNSixVhK5dri4RZPFFAmGWmC8SZ2Vyd7EPVDdKOLhUoiYr
        SbKaVP6vozBZSQ2U3jdZp3X67QdLzvniBJN1d44W1M2oBdOrAY61efL98ncfqPg3+lPvn0ew
        cDPQJeS3bWaXbbteOFxANww9JZzYoGSkq/ISTXLY9nluMW/wtDf+yo5nB6yHlSdRzZWx2Q5O
        3JQ3aM77xzj4Wn/dnqzyNEfhTPN2u6eySHTuEKNVm3OtvvXt+jzPsTb5z0/0Bmoq54+sc1h3
        3Pk7n9k9aPYNi0trJR+lfhs8mLLMeL3eahjnPR3oBNwHptuZlwsfP7De9bH3VK/0s982vs6f
        aQyeOTFZu2es4bmiR+Qocagot3vfGZfYZ5YtyA3b7HLLUZHFhvfUcs7e2FnbLxyhy1/5hktT
        VUgEaVSlSvIffSbpwjUEAAA=
X-CMS-MailID: 20231005145940eucas1p12ce3ae9d5d22d43de53a3bbac23c8fb0
X-Msg-Generator: CA
X-RootMTR: 20231005120507eucas1p13f50fa99f52808818840ee7db194e12e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231005120507eucas1p13f50fa99f52808818840ee7db194e12e
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
        <20230929114421.3761121-6-ryan.roberts@arm.com>
        <CGME20231005120507eucas1p13f50fa99f52808818840ee7db194e12e@eucas1p1.samsung.com>
        <20231005120305.vf4oxniflrfiavqf@sarkhan>
        <7631d121-e207-4612-9e22-ce027c8414b7@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 01:49:30PM +0100, Ryan Roberts wrote:
> On 05/10/2023 13:05, Daniel Gomez wrote:
> > On Fri, Sep 29, 2023 at 12:44:16PM +0100, Ryan Roberts wrote:
> >
> > Hi Ryan,
> >> Introduce the logic to allow THP to be configured (through the new
> >> anon_orders interface we just added) to allocate large folios to back
> >> anonymous memory, which are smaller than PMD-size (for example order-2=
,
> >> order-3, order-4, etc).
> >>
> >> These THPs continue to be PTE-mapped, but in many cases can still
> >> provide similar benefits to traditional PMD-sized THP: Page faults are
> >> significantly reduced (by a factor of e.g. 4, 8, 16, etc. depending on
> >> the configured order), but latency spikes are much less prominent
> >> because the size of each page isn't as huge as the PMD-sized variant a=
nd
> >> there is less memory to clear in each page fault. The number of per-pa=
ge
> >> operations (e.g. ref counting, rmap management, lru list management) a=
re
> >> also significantly reduced since those ops now become per-folio.
> >>
> >> Some architectures also employ TLB compression mechanisms to squeeze
> >> more entries in when a set of PTEs are virtually and physically
> >> contiguous and approporiately aligned. In this case, TLB misses will
> >> occur less often.
> >>
> >> The new behaviour is disabled by default because the anon_orders
> >> defaults to only enabling PMD-order, but can be enabled at runtime by
> >> writing to anon_orders (see documentation in previous commit). The lon=
g
> >> term aim is to default anon_orders to include suitable lower orders, b=
ut
> >> there are some risks around internal fragmentation that need to be
> >> better understood first.
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>  Documentation/admin-guide/mm/transhuge.rst |   9 +-
> >>  include/linux/huge_mm.h                    |   6 +-
> >>  mm/memory.c                                | 108 +++++++++++++++++++-=
-
> >>  3 files changed, 111 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentatio=
n/admin-guide/mm/transhuge.rst
> >> index 9f954e73a4ca..732c3b2f4ba8 100644
> >> --- a/Documentation/admin-guide/mm/transhuge.rst
> >> +++ b/Documentation/admin-guide/mm/transhuge.rst
> >> @@ -353,7 +353,9 @@ anonymous transparent huge pages, it is necessary =
to read
> >>  ``/proc/PID/smaps`` and count the AnonHugePages and AnonHugePteMap
> >>  fields for each mapping. Note that in both cases, AnonHugePages refer=
s
> >>  only to PMD-mapped THPs. AnonHugePteMap refers to THPs that are mappe=
d
> >> -using PTEs.
> >> +using PTEs. This includes all THPs whose order is smaller than
> >> +PMD-order, as well as any PMD-order THPs that happen to be PTE-mapped
> >> +for other reasons.
> >>
> >>  The number of file transparent huge pages mapped to userspace is avai=
lable
> >>  by reading ShmemPmdMapped and ShmemHugePages fields in ``/proc/meminf=
o``.
> >> @@ -367,6 +369,11 @@ frequently will incur overhead.
> >>  There are a number of counters in ``/proc/vmstat`` that may be used t=
o
> >>  monitor how successfully the system is providing huge pages for use.
> >>
> >> +.. note::
> >> +   Currently the below counters only record events relating to
> >> +   PMD-order THPs. Events relating to smaller order THPs are not
> >> +   included.
> >> +
> >>  thp_fault_alloc
> >>  	is incremented every time a huge page is successfully
> >>  	allocated to handle a page fault.
> >> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >> index 2e7c338229a6..c4860476a1f5 100644
> >> --- a/include/linux/huge_mm.h
> >> +++ b/include/linux/huge_mm.h
> >> @@ -68,9 +68,11 @@ extern struct kobj_attribute shmem_enabled_attr;
> >>  #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
> >>
> >>  /*
> >> - * Mask of all large folio orders supported for anonymous THP.
> >> + * Mask of all large folio orders supported for anonymous THP; all or=
ders up to
> >> + * and including PMD_ORDER, except order-0 (which is not "huge") and =
order-1
> >> + * (which is a limitation of the THP implementation).
> >>   */
> >> -#define THP_ORDERS_ALL_ANON	BIT(PMD_ORDER)
> >> +#define THP_ORDERS_ALL_ANON	((BIT(PMD_ORDER + 1) - 1) & ~(BIT(0) | BI=
T(1)))
> >>
> >>  /*
> >>   * Mask of all large folio orders supported for file THP.
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index b5b82fc8e164..92ed9c782dc9 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -4059,6 +4059,87 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>  	return ret;
> >>  }
> >>
> >> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
> >> +{
> >> +	int i;
> >> +
> >> +	if (nr_pages =3D=3D 1)
> >> +		return vmf_pte_changed(vmf);
> >> +
> >> +	for (i =3D 0; i < nr_pages; i++) {
> >> +		if (!pte_none(ptep_get_lockless(vmf->pte + i)))
> >> +			return true;
> >> +	}
> >> +
> >> +	return false;
> >> +}
> >> +
> >> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >> +static struct folio *alloc_anon_folio(struct vm_fault *vmf)
> >> +{
> >> +	gfp_t gfp;
> >> +	pte_t *pte;
> >> +	unsigned long addr;
> >> +	struct folio *folio;
> >> +	struct vm_area_struct *vma =3D vmf->vma;
> >> +	unsigned int orders;
> >> +	int order;
> >> +
> >> +	/*
> >> +	 * If uffd is active for the vma we need per-page fault fidelity to
> >> +	 * maintain the uffd semantics.
> >> +	 */
> >> +	if (userfaultfd_armed(vma))
> >> +		goto fallback;
> >> +
> >> +	/*
> >> +	 * Get a list of all the (large) orders below PMD_ORDER that are ena=
bled
> >> +	 * for this vma. Then filter out the orders that can't be allocated =
over
> >> +	 * the faulting address and still be fully contained in the vma.
> >> +	 */
> >> +	orders =3D hugepage_vma_check(vma, vma->vm_flags, false, true, true,
> >> +				    BIT(PMD_ORDER) - 1);
> >> +	orders =3D transhuge_vma_suitable(vma, vmf->address, orders);
> >> +
> >> +	if (!orders)
> >> +		goto fallback;
> >> +
> >> +	pte =3D pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
> >> +	if (!pte)
> >> +		return ERR_PTR(-EAGAIN);
> >> +
> >> +	order =3D first_order(orders);
> >> +	while (orders) {
> >> +		addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> >> +		vmf->pte =3D pte + pte_index(addr);
> >> +		if (!vmf_pte_range_changed(vmf, 1 << order))
> >> +			break;
> >> +		order =3D next_order(&orders, order);
> >> +	}
> >> +
> >> +	vmf->pte =3D NULL;
> >> +	pte_unmap(pte);
> >> +
> >> +	gfp =3D vma_thp_gfp_mask(vma);
> >> +
> >> +	while (orders) {
> >> +		addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> >> +		folio =3D vma_alloc_folio(gfp, order, vma, addr, true);
> >
> > I was checking your series and noticed about the hugepage flag. I think
> > you've changed it from v1 -> v2 from being false to true when orders >=
=3D2
> > but I'm not sure about the reasoning. Is this because of your statement
> > in the cover letter [1]?
>
> That hugepage flags is spec'ed as follows:
>
>  * @hugepage: For hugepages try only the preferred node if possible.
>
> The intent of passing true for orders higher than 0, is that we would pre=
fer to
> allocate a smaller order folio that is on the preferred node than a highe=
r order
> folio that is not on the preferred node. The assumption is that the on-go=
ing
> cost of accessing the memory on the non-preferred node will outweigh the =
benefit
> of allocating it as a high order folio.
>
> Thanks,
> Ryan

I think I'm confused about the @hugepage name. I guess activating that
for any order >=3D 2 doesn't imply you are in fact allocating a huge page
isn't? I can see order is passed from vma_alloc_folio -> __folio_alloc
-> __alloc_pages but I assumed (before reading your patch) you always
want this disabled except for HPAGE_PMD_ORDER allocation cases. But
order is not a limitation for the preferred node here, regardless this
is a huge page or not.

I see the motivation, thanks for sharing.
>
>
> >
> > [1] cover letter snippet:
> >
> > "to implement variable order, large folios for anonymous memory.
> > (previously called ..., but now exposed as an extension to THP;
> > "small-order THP")"
> >
> > Thanks,
> > Daniel
> >
> >> +		if (folio) {
> >> +			clear_huge_page(&folio->page, addr, 1 << order);
> >> +			return folio;
> >> +		}
> >> +		order =3D next_order(&orders, order);
> >> +	}
> >> +
> >> +fallback:
> >> +	return vma_alloc_zeroed_movable_folio(vma, vmf->address);
> >> +}
> >> +#else
> >> +#define alloc_anon_folio(vmf) \
> >> +		vma_alloc_zeroed_movable_folio((vmf)->vma, (vmf)->address)
> >> +#endif
> >> +
> >>  /*
> >>   * We enter with non-exclusive mmap_lock (to exclude vma changes,
> >>   * but allow concurrent faults), and pte mapped but not yet locked.
> >> @@ -4066,6 +4147,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>   */
> >>  static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
> >>  {
> >> +	int i;
> >> +	int nr_pages =3D 1;
> >> +	unsigned long addr =3D vmf->address;
> >>  	bool uffd_wp =3D vmf_orig_pte_uffd_wp(vmf);
> >>  	struct vm_area_struct *vma =3D vmf->vma;
> >>  	struct folio *folio;
> >> @@ -4110,10 +4194,15 @@ static vm_fault_t do_anonymous_page(struct vm_=
fault *vmf)
> >>  	/* Allocate our own private page. */
> >>  	if (unlikely(anon_vma_prepare(vma)))
> >>  		goto oom;
> >> -	folio =3D vma_alloc_zeroed_movable_folio(vma, vmf->address);
> >> +	folio =3D alloc_anon_folio(vmf);
> >> +	if (IS_ERR(folio))
> >> +		return 0;
> >>  	if (!folio)
> >>  		goto oom;
> >>
> >> +	nr_pages =3D folio_nr_pages(folio);
> >> +	addr =3D ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
> >> +
> >>  	if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL))
> >>  		goto oom_free_page;
> >>  	folio_throttle_swaprate(folio, GFP_KERNEL);
> >> @@ -4130,12 +4219,12 @@ static vm_fault_t do_anonymous_page(struct vm_=
fault *vmf)
> >>  	if (vma->vm_flags & VM_WRITE)
> >>  		entry =3D pte_mkwrite(pte_mkdirty(entry), vma);
> >>
> >> -	vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
> >> -			&vmf->ptl);
> >> +	vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->p=
tl);
> >>  	if (!vmf->pte)
> >>  		goto release;
> >> -	if (vmf_pte_changed(vmf)) {
> >> -		update_mmu_tlb(vma, vmf->address, vmf->pte);
> >> +	if (vmf_pte_range_changed(vmf, nr_pages)) {
> >> +		for (i =3D 0; i < nr_pages; i++)
> >> +			update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
> >>  		goto release;
> >>  	}
> >>
> >> @@ -4150,16 +4239,17 @@ static vm_fault_t do_anonymous_page(struct vm_=
fault *vmf)
> >>  		return handle_userfault(vmf, VM_UFFD_MISSING);
> >>  	}
> >>
> >> -	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> >> -	folio_add_new_anon_rmap(folio, vma, vmf->address);
> >> +	folio_ref_add(folio, nr_pages - 1);
> >> +	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> >> +	folio_add_new_anon_rmap(folio, vma, addr);
> >>  	folio_add_lru_vma(folio, vma);
> >>  setpte:
> >>  	if (uffd_wp)
> >>  		entry =3D pte_mkuffd_wp(entry);
> >> -	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
> >> +	set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr_pages);
> >>
> >>  	/* No need to invalidate - it was non-present before */
> >> -	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
> >> +	update_mmu_cache_range(vmf, vma, addr, vmf->pte, nr_pages);
> >>  unlock:
> >>  	if (vmf->pte)
> >>  		pte_unmap_unlock(vmf->pte, vmf->ptl);
> >> --
> >> 2.25.1
> >>
>=
