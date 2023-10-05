Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED9F7BA5DE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242257AbjJEQUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241150AbjJEQQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:16:01 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADE326392
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:30:47 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231005120508euoutp011813bba641769f4c1ef26e5b84b39020~LNJcsW1A40560205602euoutp01I
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 12:05:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231005120508euoutp011813bba641769f4c1ef26e5b84b39020~LNJcsW1A40560205602euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696507508;
        bh=g70Lsfcx58xx4yQLw7MqOmgu5Aej+T3QmNQnuS3Tm5M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=qGi7O08v3DrhsDRP86gj4pN9Sg1Q7x5sXxuIO5mBegT1+ya7Z6GcFPE5mvns8J3+J
         QYxZXnS3FuqaRzEDY4VCskQjztgzHdouIbfw1f/N1p9vzoxDnKfTa+fpdjtHOvf7nt
         X6JES9bJo0Hj57xIk1dip9RVxYSsjAgMT1NxNCRo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231005120507eucas1p246d2b3e8a6cb8b0f18123a8238f9ee9d~LNJcLZtIU1275512755eucas1p2r;
        Thu,  5 Oct 2023 12:05:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F2.69.42423.376AE156; Thu,  5
        Oct 2023 13:05:07 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231005120507eucas1p13f50fa99f52808818840ee7db194e12e~LNJbrsOfh0995709957eucas1p1_;
        Thu,  5 Oct 2023 12:05:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231005120507eusmtrp2b25805c6c38702a06a991a49940457ea~LNJbpk6UV3246132461eusmtrp2S;
        Thu,  5 Oct 2023 12:05:07 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-f9-651ea673bd09
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 41.FC.25043.376AE156; Thu,  5
        Oct 2023 13:05:07 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231005120507eusmtip11fe3478ca24d0e416d97f3dfd140ed38~LNJbbAYrq2811928119eusmtip1c;
        Thu,  5 Oct 2023 12:05:07 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Thu, 5 Oct 2023 13:05:06 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Thu, 5 Oct
        2023 13:05:06 +0100
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
Thread-Index: AQHZ94QtqHgx5j+4/ESVMKx2qfqGCA==
Date:   Thu, 5 Oct 2023 12:05:05 +0000
Message-ID: <20231005120305.vf4oxniflrfiavqf@sarkhan>
In-Reply-To: <20230929114421.3761121-6-ryan.roberts@arm.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.103]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2549D03FF7ED7B46B62C27C5993275A7@scsc.local>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf1CTZRz32fvufV92wr2MKU9EZNMjkwXsjO7JI+vK9PU4kSK7Kytc8LZZ
        /PA2J2J1QqgJoRGV4oY4hxHKi8hM49eBrgTmNEkY2NCd4HAHytQB5xodxvaat/8+3+fz+X4/
        n+/3HgoT64goanPuVladq8iWEiL8bNc/V17U1MawiX9NylFVI0egjp5MdK+2DKDpRh+G+q13
        BWjUsx9HRZ4qgJpGjST621WFI9OtASHqa60ikIN7JETXykcB2nOsSYDK2n4CyNBTA5C+aD9A
        M945iUX3A47c5VNCpL/gIF9fwHDVHGBadDdIxmDSMqfrljE17WMCxnSihGBMngqS6amcwZlq
        y9vM6WM7mX3FboK512EjmEuGP0hm0hSTFvaBKDmLzd68jVUnrNwkUpnu7iW29KZsn67vJQtB
        a3IpoChIvwTNblkpEFFiug7A4XMlRCkImSumANR7lvDEJICOS27MT/gbRipPCXjRLwAWlTz7
        ROS77hXyhRXAAz1m7Mnc6j8HSX8LQb8AOywm0k9IaIsQDj06GFBh9HkAv979UOhXRdDvQltf
        E+7HEnoDbG7oFfrTSuh46N4j9T/j9BL42677AXkonQSN3quBfCF0MizUuwKtgH4Gjhz3BYwx
        OhLanUcE/A7h0Khvf7zPQjjbOkzwWAYvDzoBjxPhmZ87cB5L4b97jwJ+jgwa2jwEj1+BxouG
        xzgO1h69g/F5wqHlkBP37wXpKREcPTJJ8NdeBevblvMzI+B4969kOZDpguLpgix0QRa6IAtd
        kIUBCE+ASFaryVGyGnkumx+vUeRotLnK+My8HBOY+77W2W5PMzg8/iDeDAQUMANIYVJJqLIw
        mhWHZikKdrDqvAy1NpvVmMHTFC6NDI171ZIpppWKreznLLuFVf/PCqiQqELB/I3lEakHhEkr
        hq4MO+W+ZtfKsZvR03gE21f3I/lJwqoJ6zdv3FlxSDu19sP8gc7V3dVnHL97JuTmk8+HLU5g
        KtJTk6wqx3iJ94tdH7/csDB9Yt7ilHrbZZ39u/z5XPPNjHBbRWz67OoFX36r7OxWJ775IGZ3
        1w7Xtqfc3Mnjs2tSwny3JXn3t48Zbzw8uGiAc7RfNS7v5966Jd20Dl7fsN7OtbSlFUTbiNjz
        xcWVkYPvvyabic56zv5RZ1NsGWZn+13vxLWPfU+tA7e/OtdQOmNRKZe+V9ey89RG8Tz5eMun
        lQXa9RfTRjLWcheGnGtyolRLuyRD1Nlw6+HGa4u8eOtnNalSXKNSyJdhao3iPy754MYtBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0xTVxTHc9vX16IreWAJN9gR9yQzMHm0tcXbBZEl/vGWJYtsGhMNKR08
        wYxS0h8bamA4QaAyVuwWsVRXfgZqF2wBZ6l2jo3RAmZmWp1suilFwSEMJo6Bcyt9LOG/zznn
        +z33nJsj4Ma24wmCQ8UGRlesLiLxddjIi6G7qfqOREbi6YpBtm4njnz+PDTbUQfQQvcSF90c
        meagifl6DB2btwHkmmjhozuPbBhyj9/ioRv9Nhzdc/7LQz+ZJwA60ebioDrv5wDZ/a0ANR2r
        B2h5MSwJWC0YmjE/5aGmwXv8rDjaec4JaI/1Lp+2u410T2cK3Xp5ikO7HbU47Z4/xaf9jcsY
        fS6QTfe0fUR/cnwGp2d9QZwetX/Hp/90J+6O3k9l6LRGA7OpUKs37CAPSJGMkioRJZMrKem2
        7TmvyxRkWmZGPlN06ANGl5aZSxW6p2vwkutvlS6cv86vAP0ZJhAlgIQcPmi8wDGBdYJYoh3A
        j73dOFsQQ9fTII/lDfD5LRPOiuYArBwd5bPBCIAea9dq0Angp2MnwYoFJ5KhL+COFEREgAdv
        z92P+LnE1wAG+5qxFdUGYg8M3nBFWETshVd+WQiLBGGm4MwJciWNEUnwq8o/InMICQVsWfyR
        u8KxhAZ2mycj+SgiA1Y0PYq0AcTL8EHXEn+FuUQ8HAt9wWF3IGDb5R+4LMfBqfEXq7tthddu
        hwDLEtjX7sNYJuHzmmbA9tkK7d55nGUlbBm2r/JrsKP5dy47WwwMnAlhZiC2rnnausZuXWO3
        rrFb19jtgOcAIsao1xRo9DJKr9bojcUFVJ5W4wbhe734/d+9l0DX4zlqAHAEYABAAZcUCQsq
        xEysMF99+Aij06p0xiJGPwAU4b9r4CbE5WnDB19sUEnTJQqpPF0pUSjTt5HxwjdLatSxRIHa
        wLzPMCWM7n8fRxCVUME5LY+Lmix/srNB/O4OTpXtt4mjOZKN+B1eclnV0VxluZIHysnkN+w1
        0RS566XaqY36V1Xnr6mq/a7cLX6zpnzQIqGYZF1iDWHp/Uf6sCp1vWIiSfHhAcfCk/r491pi
        Sq/2Tx0JnE27+sy5uGn92RwvKDvlGZoWkReCu8dqtT2pWUnu7sGst7f0ZgejLPyDs8LGZ+aY
        6snAEO4qvdh/szzl4MOfD+eExJ3t1WpkGpfIMoGv2kEbrux5R1WZn7r0Wekr3y7vJAtzZ8ep
        lGCfI2v4uCq98XRoIHqmztOg1KjLsF2z9+Wm4c2PqbR9X36zfWrzSYvX6oj+9a9Lk/tas0lM
        X6iWpnB1evV/afjSPTgEAAA=
X-CMS-MailID: 20231005120507eucas1p13f50fa99f52808818840ee7db194e12e
X-Msg-Generator: CA
X-RootMTR: 20231005120507eucas1p13f50fa99f52808818840ee7db194e12e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231005120507eucas1p13f50fa99f52808818840ee7db194e12e
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
        <20230929114421.3761121-6-ryan.roberts@arm.com>
        <CGME20231005120507eucas1p13f50fa99f52808818840ee7db194e12e@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 12:44:16PM +0100, Ryan Roberts wrote:

Hi Ryan,
> Introduce the logic to allow THP to be configured (through the new
> anon_orders interface we just added) to allocate large folios to back
> anonymous memory, which are smaller than PMD-size (for example order-2,
> order-3, order-4, etc).
>
> These THPs continue to be PTE-mapped, but in many cases can still
> provide similar benefits to traditional PMD-sized THP: Page faults are
> significantly reduced (by a factor of e.g. 4, 8, 16, etc. depending on
> the configured order), but latency spikes are much less prominent
> because the size of each page isn't as huge as the PMD-sized variant and
> there is less memory to clear in each page fault. The number of per-page
> operations (e.g. ref counting, rmap management, lru list management) are
> also significantly reduced since those ops now become per-folio.
>
> Some architectures also employ TLB compression mechanisms to squeeze
> more entries in when a set of PTEs are virtually and physically
> contiguous and approporiately aligned. In this case, TLB misses will
> occur less often.
>
> The new behaviour is disabled by default because the anon_orders
> defaults to only enabling PMD-order, but can be enabled at runtime by
> writing to anon_orders (see documentation in previous commit). The long
> term aim is to default anon_orders to include suitable lower orders, but
> there are some risks around internal fragmentation that need to be
> better understood first.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst |   9 +-
>  include/linux/huge_mm.h                    |   6 +-
>  mm/memory.c                                | 108 +++++++++++++++++++--
>  3 files changed, 111 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index 9f954e73a4ca..732c3b2f4ba8 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -353,7 +353,9 @@ anonymous transparent huge pages, it is necessary to =
read
>  ``/proc/PID/smaps`` and count the AnonHugePages and AnonHugePteMap
>  fields for each mapping. Note that in both cases, AnonHugePages refers
>  only to PMD-mapped THPs. AnonHugePteMap refers to THPs that are mapped
> -using PTEs.
> +using PTEs. This includes all THPs whose order is smaller than
> +PMD-order, as well as any PMD-order THPs that happen to be PTE-mapped
> +for other reasons.
>
>  The number of file transparent huge pages mapped to userspace is availab=
le
>  by reading ShmemPmdMapped and ShmemHugePages fields in ``/proc/meminfo``=
.
> @@ -367,6 +369,11 @@ frequently will incur overhead.
>  There are a number of counters in ``/proc/vmstat`` that may be used to
>  monitor how successfully the system is providing huge pages for use.
>
> +.. note::
> +   Currently the below counters only record events relating to
> +   PMD-order THPs. Events relating to smaller order THPs are not
> +   included.
> +
>  thp_fault_alloc
>  	is incremented every time a huge page is successfully
>  	allocated to handle a page fault.
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 2e7c338229a6..c4860476a1f5 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -68,9 +68,11 @@ extern struct kobj_attribute shmem_enabled_attr;
>  #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
>
>  /*
> - * Mask of all large folio orders supported for anonymous THP.
> + * Mask of all large folio orders supported for anonymous THP; all order=
s up to
> + * and including PMD_ORDER, except order-0 (which is not "huge") and ord=
er-1
> + * (which is a limitation of the THP implementation).
>   */
> -#define THP_ORDERS_ALL_ANON	BIT(PMD_ORDER)
> +#define THP_ORDERS_ALL_ANON	((BIT(PMD_ORDER + 1) - 1) & ~(BIT(0) | BIT(1=
)))
>
>  /*
>   * Mask of all large folio orders supported for file THP.
> diff --git a/mm/memory.c b/mm/memory.c
> index b5b82fc8e164..92ed9c782dc9 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4059,6 +4059,87 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	return ret;
>  }
>
> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
> +{
> +	int i;
> +
> +	if (nr_pages =3D=3D 1)
> +		return vmf_pte_changed(vmf);
> +
> +	for (i =3D 0; i < nr_pages; i++) {
> +		if (!pte_none(ptep_get_lockless(vmf->pte + i)))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static struct folio *alloc_anon_folio(struct vm_fault *vmf)
> +{
> +	gfp_t gfp;
> +	pte_t *pte;
> +	unsigned long addr;
> +	struct folio *folio;
> +	struct vm_area_struct *vma =3D vmf->vma;
> +	unsigned int orders;
> +	int order;
> +
> +	/*
> +	 * If uffd is active for the vma we need per-page fault fidelity to
> +	 * maintain the uffd semantics.
> +	 */
> +	if (userfaultfd_armed(vma))
> +		goto fallback;
> +
> +	/*
> +	 * Get a list of all the (large) orders below PMD_ORDER that are enable=
d
> +	 * for this vma. Then filter out the orders that can't be allocated ove=
r
> +	 * the faulting address and still be fully contained in the vma.
> +	 */
> +	orders =3D hugepage_vma_check(vma, vma->vm_flags, false, true, true,
> +				    BIT(PMD_ORDER) - 1);
> +	orders =3D transhuge_vma_suitable(vma, vmf->address, orders);
> +
> +	if (!orders)
> +		goto fallback;
> +
> +	pte =3D pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
> +	if (!pte)
> +		return ERR_PTR(-EAGAIN);
> +
> +	order =3D first_order(orders);
> +	while (orders) {
> +		addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> +		vmf->pte =3D pte + pte_index(addr);
> +		if (!vmf_pte_range_changed(vmf, 1 << order))
> +			break;
> +		order =3D next_order(&orders, order);
> +	}
> +
> +	vmf->pte =3D NULL;
> +	pte_unmap(pte);
> +
> +	gfp =3D vma_thp_gfp_mask(vma);
> +
> +	while (orders) {
> +		addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> +		folio =3D vma_alloc_folio(gfp, order, vma, addr, true);

I was checking your series and noticed about the hugepage flag. I think
you've changed it from v1 -> v2 from being false to true when orders >=3D2
but I'm not sure about the reasoning. Is this because of your statement
in the cover letter [1]?

[1] cover letter snippet:

"to implement variable order, large folios for anonymous memory.
(previously called ..., but now exposed as an extension to THP;
"small-order THP")"

Thanks,
Daniel

> +		if (folio) {
> +			clear_huge_page(&folio->page, addr, 1 << order);
> +			return folio;
> +		}
> +		order =3D next_order(&orders, order);
> +	}
> +
> +fallback:
> +	return vma_alloc_zeroed_movable_folio(vma, vmf->address);
> +}
> +#else
> +#define alloc_anon_folio(vmf) \
> +		vma_alloc_zeroed_movable_folio((vmf)->vma, (vmf)->address)
> +#endif
> +
>  /*
>   * We enter with non-exclusive mmap_lock (to exclude vma changes,
>   * but allow concurrent faults), and pte mapped but not yet locked.
> @@ -4066,6 +4147,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   */
>  static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  {
> +	int i;
> +	int nr_pages =3D 1;
> +	unsigned long addr =3D vmf->address;
>  	bool uffd_wp =3D vmf_orig_pte_uffd_wp(vmf);
>  	struct vm_area_struct *vma =3D vmf->vma;
>  	struct folio *folio;
> @@ -4110,10 +4194,15 @@ static vm_fault_t do_anonymous_page(struct vm_fau=
lt *vmf)
>  	/* Allocate our own private page. */
>  	if (unlikely(anon_vma_prepare(vma)))
>  		goto oom;
> -	folio =3D vma_alloc_zeroed_movable_folio(vma, vmf->address);
> +	folio =3D alloc_anon_folio(vmf);
> +	if (IS_ERR(folio))
> +		return 0;
>  	if (!folio)
>  		goto oom;
>
> +	nr_pages =3D folio_nr_pages(folio);
> +	addr =3D ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
> +
>  	if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL))
>  		goto oom_free_page;
>  	folio_throttle_swaprate(folio, GFP_KERNEL);
> @@ -4130,12 +4219,12 @@ static vm_fault_t do_anonymous_page(struct vm_fau=
lt *vmf)
>  	if (vma->vm_flags & VM_WRITE)
>  		entry =3D pte_mkwrite(pte_mkdirty(entry), vma);
>
> -	vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
> -			&vmf->ptl);
> +	vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl)=
;
>  	if (!vmf->pte)
>  		goto release;
> -	if (vmf_pte_changed(vmf)) {
> -		update_mmu_tlb(vma, vmf->address, vmf->pte);
> +	if (vmf_pte_range_changed(vmf, nr_pages)) {
> +		for (i =3D 0; i < nr_pages; i++)
> +			update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
>  		goto release;
>  	}
>
> @@ -4150,16 +4239,17 @@ static vm_fault_t do_anonymous_page(struct vm_fau=
lt *vmf)
>  		return handle_userfault(vmf, VM_UFFD_MISSING);
>  	}
>
> -	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> -	folio_add_new_anon_rmap(folio, vma, vmf->address);
> +	folio_ref_add(folio, nr_pages - 1);
> +	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> +	folio_add_new_anon_rmap(folio, vma, addr);
>  	folio_add_lru_vma(folio, vma);
>  setpte:
>  	if (uffd_wp)
>  		entry =3D pte_mkuffd_wp(entry);
> -	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
> +	set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr_pages);
>
>  	/* No need to invalidate - it was non-present before */
> -	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
> +	update_mmu_cache_range(vmf, vma, addr, vmf->pte, nr_pages);
>  unlock:
>  	if (vmf->pte)
>  		pte_unmap_unlock(vmf->pte, vmf->ptl);
> --
> 2.25.1
>=
