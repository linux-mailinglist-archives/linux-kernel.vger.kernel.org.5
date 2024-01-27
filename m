Return-Path: <linux-kernel+bounces-41387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7122F83EFEA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 21:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A79283C73
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D3F2E645;
	Sat, 27 Jan 2024 20:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8r7Z3z+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6115F2E634
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706385989; cv=none; b=sXzJR5hfC0iI35y7/9ooq2UV8qrMJFPbbXFAF30KZpLNLqOPQtndtRBJW8pjZaCBA146akjm1oCQbnqyxMd7wUN+NDFZ7oLjDVkis1KldrzvTGAJbegmH+JjpeWajAHsiptsbBnrwC2fxggIwXdWWj3TSi05/m1MpLuJk57vhOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706385989; c=relaxed/simple;
	bh=/ouN77yAzTyDbZ/Cwi1vFLpuPXyxFrLFyfiSTYYF+L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOkEhjUoPPAl6tC442T3dsWgq7xpSkU4iZBKfDdirnquw50MNNGHKYVynpt+PbF1P0vVgLDM4qQ2t+f9gY3jpT8WWGmRUVVCypsi0rvteen6lcwGcullusKzE6HSb5WdNbOz828RRF3j0K33rYS0Pb/9/+wfqDX4mpqe5xQg1PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8r7Z3z+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE07C433C7
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 20:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706385988;
	bh=/ouN77yAzTyDbZ/Cwi1vFLpuPXyxFrLFyfiSTYYF+L8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F8r7Z3z+L+a3NVZ7EpxkqXzA4JBBoHq3V2mODXfbUFMOKSHo/lPbAdKMWOJNcqyD1
	 r0Zgf7ESVC6YCLw41n5TWmeIVW49/+3ovh0P7ZbU0FqPVkLcjsHsIp31YUoygTs0yN
	 kc0ldqtTKLyPmyICNSWNMd2JAlkeB1cA2kQQyFYuyG6y1RYIkGvpt4l4ZR15UHChp7
	 gC12eWOCEiI6CVrIhQ2CGtILg5nVoPgTUkH5ehEzCvxw5iDLtFV0wM1aG6OrbIFdZq
	 goInMLEB7NBLjxOzFFxDWV1nX1Pz4u3MdB9A2gHlCijFj6H/Os/X3PitVVwnElkJn9
	 S4XjhN561drzA==
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bc32b0fdadso63597339f.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 12:06:28 -0800 (PST)
X-Gm-Message-State: AOJu0YzzWlwLFdT8pZupd0MlbYd0myZfwYAt0i8CT/Klqg5wrceunZPt
	dBcPyXiThoMs5dDcKDoWWCR17ORSVkKihKtLoP09o9DsWVjUIn8HZ2sooCdPNPZN5Xcjd2P5XHi
	9VStTgfmzADZTvvAr3SFBzn2fWOD6ngAfu6Lk
X-Google-Smtp-Source: AGHT+IHuZaW96e6+26+CeIrNUaxeWP89iOCxy62GzSsBbZEO4mU2xm8nJnm4CEeNp+W00utnZhjU+sbX1aElYltwpo4=
X-Received: by 2002:a92:d2ce:0:b0:361:94d8:b89a with SMTP id
 w14-20020a92d2ce000000b0036194d8b89amr2171886ilg.4.1706385987991; Sat, 27 Jan
 2024 12:06:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-1-ryan.roberts@arm.com> <20240118111036.72641-1-21cnbao@gmail.com>
 <20240118111036.72641-5-21cnbao@gmail.com>
In-Reply-To: <20240118111036.72641-5-21cnbao@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 27 Jan 2024 12:06:16 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNVFq_jWFM3h0fLaUu+kVwa7zWvD3A_AJ1PxR+0Yyw_Dw@mail.gmail.com>
Message-ID: <CAF8kJuNVFq_jWFM3h0fLaUu+kVwa7zWvD3A_AJ1PxR+0Yyw_Dw@mail.gmail.com>
Subject: Re: [PATCH RFC 4/6] mm: support large folios swapin as a whole
To: Barry Song <21cnbao@gmail.com>
Cc: ryan.roberts@arm.com, akpm@linux-foundation.org, david@redhat.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	shy828301@gmail.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com, surenb@google.com, 
	steven.price@arm.com, Chuanhua Han <hanchuanhua@oppo.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 3:12=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Chuanhua Han <hanchuanhua@oppo.com>
>
> On an embedded system like Android, more than half of anon memory is actu=
ally
> in swap devices such as zRAM. For example, while an app is switched to ba=
ck-
> ground, its most memory might be swapped-out.
>
> Now we have mTHP features, unfortunately, if we don't support large folio=
s
> swap-in, once those large folios are swapped-out, we immediately lose the
> performance gain we can get through large folios and hardware optimizatio=
n
> such as CONT-PTE.
>
> This patch brings up mTHP swap-in support. Right now, we limit mTHP swap-=
in
> to those contiguous swaps which were likely swapped out from mTHP as a wh=
ole.
>
> On the other hand, the current implementation only covers the SWAP_SYCHRO=
NOUS
> case. It doesn't support swapin_readahead as large folios yet.
>
> Right now, we are re-faulting large folios which are still in swapcache a=
s a
> whole, this can effectively decrease extra loops and early-exitings which=
 we
> have increased in arch_swap_restore() while supporting MTE restore for fo=
lios
> rather than page.
>
> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/memory.c | 108 +++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 94 insertions(+), 14 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index f61a48929ba7..928b3f542932 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -107,6 +107,8 @@ EXPORT_SYMBOL(mem_map);
>  static vm_fault_t do_fault(struct vm_fault *vmf);
>  static vm_fault_t do_anonymous_page(struct vm_fault *vmf);
>  static bool vmf_pte_changed(struct vm_fault *vmf);
> +static struct folio *alloc_anon_folio(struct vm_fault *vmf,
> +                                     bool (*pte_range_check)(pte_t *, in=
t));
>
>  /*
>   * Return true if the original pte was a uffd-wp pte marker (so the pte =
was
> @@ -3784,6 +3786,34 @@ static vm_fault_t handle_pte_marker(struct vm_faul=
t *vmf)
>         return VM_FAULT_SIGBUS;
>  }
>
> +static bool pte_range_swap(pte_t *pte, int nr_pages)
> +{
> +       int i;
> +       swp_entry_t entry;
> +       unsigned type;
> +       pgoff_t start_offset;
> +
> +       entry =3D pte_to_swp_entry(ptep_get_lockless(pte));
> +       if (non_swap_entry(entry))
> +               return false;
> +       start_offset =3D swp_offset(entry);
> +       if (start_offset % nr_pages)
> +               return false;
> +
> +       type =3D swp_type(entry);
> +       for (i =3D 1; i < nr_pages; i++) {
> +               entry =3D pte_to_swp_entry(ptep_get_lockless(pte + i));
> +               if (non_swap_entry(entry))
> +                       return false;
> +               if (swp_offset(entry) !=3D start_offset + i)
> +                       return false;
> +               if (swp_type(entry) !=3D type)
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
>  /*
>   * We enter with non-exclusive mmap_lock (to exclude vma changes,
>   * but allow concurrent faults), and pte mapped but not yet locked.
> @@ -3804,6 +3834,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         pte_t pte;
>         vm_fault_t ret =3D 0;
>         void *shadow =3D NULL;
> +       int nr_pages =3D 1;
> +       unsigned long start_address;
> +       pte_t *start_pte;
>
>         if (!pte_unmap_same(vmf))
>                 goto out;
> @@ -3868,13 +3901,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>                     __swap_count(entry) =3D=3D 1) {
>                         /* skip swapcache */
> -                       folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0=
,
> -                                               vma, vmf->address, false)=
;
> +                       folio =3D alloc_anon_folio(vmf, pte_range_swap);
>                         page =3D &folio->page;
>                         if (folio) {
>                                 __folio_set_locked(folio);
>                                 __folio_set_swapbacked(folio);
>
> +                               if (folio_test_large(folio)) {
> +                                       unsigned long start_offset;
> +
> +                                       nr_pages =3D folio_nr_pages(folio=
);
> +                                       start_offset =3D swp_offset(entry=
) & ~(nr_pages - 1);
> +                                       entry =3D swp_entry(swp_type(entr=
y), start_offset);
> +                               }
> +
>                                 if (mem_cgroup_swapin_charge_folio(folio,
>                                                         vma->vm_mm, GFP_K=
ERNEL,
>                                                         entry)) {
> @@ -3980,6 +4020,39 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>          */
>         vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->addre=
ss,
>                         &vmf->ptl);
> +
> +       start_address =3D vmf->address;
> +       start_pte =3D vmf->pte;
> +       if (folio_test_large(folio)) {
> +               unsigned long nr =3D folio_nr_pages(folio);
> +               unsigned long addr =3D ALIGN_DOWN(vmf->address, nr * PAGE=
_SIZE);
> +               pte_t *pte_t =3D vmf->pte - (vmf->address - addr) / PAGE_=
SIZE;

I forgot about one comment here.
Please change the variable name other than "pte_t", it is a bit
strange to use the typedef name as variable name here.

Chris

> +
> +               /*
> +                * case 1: we are allocating large_folio, try to map it a=
s a whole
> +                * iff the swap entries are still entirely mapped;
> +                * case 2: we hit a large folio in swapcache, and all swa=
p entries
> +                * are still entirely mapped, try to map a large folio as=
 a whole.
> +                * otherwise, map only the faulting page within the large=
 folio
> +                * which is swapcache
> +                */
> +               if (pte_range_swap(pte_t, nr)) {
> +                       start_address =3D addr;
> +                       start_pte =3D pte_t;
> +                       if (unlikely(folio =3D=3D swapcache)) {
> +                               /*
> +                                * the below has been done before swap_re=
ad_folio()
> +                                * for case 1
> +                                */
> +                               nr_pages =3D nr;
> +                               entry =3D pte_to_swp_entry(ptep_get(start=
_pte));
> +                               page =3D &folio->page;
> +                       }
> +               } else if (nr_pages > 1) { /* ptes have changed for case =
1 */
> +                       goto out_nomap;
> +               }
> +       }
> +
>         if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig=
_pte)))
>                 goto out_nomap;
>
> @@ -4047,12 +4120,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>          * We're already holding a reference on the page but haven't mapp=
ed it
>          * yet.
>          */
> -       swap_free(entry);
> +       swap_nr_free(entry, nr_pages);
>         if (should_try_to_free_swap(folio, vma, vmf->flags))
>                 folio_free_swap(folio);
>
> -       inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> -       dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> +       folio_ref_add(folio, nr_pages - 1);
> +       add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> +       add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
> +
>         pte =3D mk_pte(page, vma->vm_page_prot);
>
>         /*
> @@ -4062,14 +4137,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>          * exclusivity.
>          */
>         if (!folio_test_ksm(folio) &&
> -           (exclusive || folio_ref_count(folio) =3D=3D 1)) {
> +           (exclusive || folio_ref_count(folio) =3D=3D nr_pages)) {
>                 if (vmf->flags & FAULT_FLAG_WRITE) {
>                         pte =3D maybe_mkwrite(pte_mkdirty(pte), vma);
>                         vmf->flags &=3D ~FAULT_FLAG_WRITE;
>                 }
>                 rmap_flags |=3D RMAP_EXCLUSIVE;
>         }
> -       flush_icache_page(vma, page);
> +       flush_icache_pages(vma, page, nr_pages);
>         if (pte_swp_soft_dirty(vmf->orig_pte))
>                 pte =3D pte_mksoft_dirty(pte);
>         if (pte_swp_uffd_wp(vmf->orig_pte))
> @@ -4081,14 +4156,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 folio_add_new_anon_rmap(folio, vma, vmf->address);
>                 folio_add_lru_vma(folio, vma);
>         } else {
> -               folio_add_anon_rmap_pte(folio, page, vma, vmf->address,
> +               folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, star=
t_address,
>                                         rmap_flags);
>         }
>
>         VM_BUG_ON(!folio_test_anon(folio) ||
>                         (pte_write(pte) && !PageAnonExclusive(page)));
> -       set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
> -       arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_p=
te);
> +       set_ptes(vma->vm_mm, start_address, start_pte, pte, nr_pages);
> +
> +       arch_do_swap_page(vma->vm_mm, vma, start_address, pte, vmf->orig_=
pte);
>
>         folio_unlock(folio);
>         if (folio !=3D swapcache && swapcache) {
> @@ -4105,6 +4181,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         }
>
>         if (vmf->flags & FAULT_FLAG_WRITE) {
> +               if (folio_test_large(folio) && nr_pages > 1)
> +                       vmf->orig_pte =3D ptep_get(vmf->pte);
> +
>                 ret |=3D do_wp_page(vmf);
>                 if (ret & VM_FAULT_ERROR)
>                         ret &=3D VM_FAULT_ERROR;
> @@ -4112,7 +4191,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         }
>
>         /* No need to invalidate - it was non-present before */
> -       update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
> +       update_mmu_cache_range(vmf, vma, start_address, start_pte, nr_pag=
es);
>  unlock:
>         if (vmf->pte)
>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
> @@ -4148,7 +4227,8 @@ static bool pte_range_none(pte_t *pte, int nr_pages=
)
>         return true;
>  }
>
> -static struct folio *alloc_anon_folio(struct vm_fault *vmf)
> +static struct folio *alloc_anon_folio(struct vm_fault *vmf,
> +                                     bool (*pte_range_check)(pte_t *, in=
t))
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         struct vm_area_struct *vma =3D vmf->vma;
> @@ -4190,7 +4270,7 @@ static struct folio *alloc_anon_folio(struct vm_fau=
lt *vmf)
>         order =3D highest_order(orders);
>         while (orders) {
>                 addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> -               if (pte_range_none(pte + pte_index(addr), 1 << order))
> +               if (pte_range_check(pte + pte_index(addr), 1 << order))
>                         break;
>                 order =3D next_order(&orders, order);
>         }
> @@ -4269,7 +4349,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault=
 *vmf)
>         if (unlikely(anon_vma_prepare(vma)))
>                 goto oom;
>         /* Returns NULL on OOM or ERR_PTR(-EAGAIN) if we must retry the f=
ault */
> -       folio =3D alloc_anon_folio(vmf);
> +       folio =3D alloc_anon_folio(vmf, pte_range_none);
>         if (IS_ERR(folio))
>                 return 0;
>         if (!folio)
> --
> 2.34.1
>
>

