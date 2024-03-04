Return-Path: <linux-kernel+bounces-89965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B39AF86F850
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DA0280F11
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 01:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D73A1362;
	Mon,  4 Mar 2024 01:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZgKJLeJ"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7751A31
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 01:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709516089; cv=none; b=oxvK9tGPJUnA0SeSwKSASiX5JtDRHHZpSXnQa/KN5Dx9hRYVXzCHDRZB18XDUBuVYh4VxmBot292LoTzUKVS4YcDjX7flwycGZMsNMaq4ZMk5+n2P3ZGWNMAtSEE3dMmL9i5BHNmlDqjCvQZDj1auBjBo31JML8TxCSXVH0DLd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709516089; c=relaxed/simple;
	bh=rcja4eI+QaGiSOLnuzncrNe3ZpG1TWQpPxxdlLY5vLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C85LLmevGB5bA/IMs7efMVzWtmO4aUFBnulk81zd0yu2oJ8zh2Ou3HOKNY+7rOM+HBjpYvzZml+oVqyaj4Teu86INtoLbcD4SDtoCTrJmEtq45ptwG0p7i2Jfu+Krd3qPrifXHEY5Fz9Re5lHHE6NckK4AQ/N0EFbjKkDba/+VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZgKJLeJ; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7d130979108so2118207241.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 17:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709516086; x=1710120886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3ZJFjWKIT8PetZOSNxgmgcBQfMtQhvUeTILh6K2Cbs=;
        b=lZgKJLeJUPI3z0N28fBJTANRUT4Xx9LzpL+/2eVIpor09D/kIvwBsInCNXV6NTd5q0
         2Y6Pc/EmkhBCFoBP6qtjfe5upweC/GZxDPGzuT1vYmWTi0tMGUaczn52DSv1fylgNvH9
         NdOOLU8x+I26b0Pub/C2GI6DhmsjdOSoetNgf5arQSYQ6XRALyCAZvBhgMg0I8lgiMsV
         2e5KBGdt6P6NeSybBR5tLwV9NSdYi+9R6JVHlnkYEfIIcXmmIKtipJeK8y4o1iDXTV9b
         nb2+Bnm/51gWlvO89jWMuxzA8JmipLkJmLOmW8nOWT+8sx9TvO5ft+xUlz+6IHw/8oME
         prJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709516086; x=1710120886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3ZJFjWKIT8PetZOSNxgmgcBQfMtQhvUeTILh6K2Cbs=;
        b=CDuCwf2posJEMjpXlw+QKKRL/DJiAoUVShp/dzLa2yu94WrsjvEBxId9m70phod7Iy
         b+c1dgtxqLz/O0HZ0ZuyLQxviMSRxRmBVY+MFMdNTFB7lyXlR11mMnZiVhU5gmP8pnUL
         W4Cojg85P2R2hKSs8HYHMfKzbdPNdDwtk6t1xzdqcJQYOiSevLqD64vuKDIxaAShmCXu
         RTraDdofnmf5cINVq59AAtRat/jdVN/TcWogN6dy3whByCRMeFzDd0OorNvaizOZZI0Z
         xbIXgMJO/7HLMvfY1n2rDNd3gWnOUhziCzFOLEt5OCKy3gC+LygIRMFJjij0vudlRUcl
         Umnw==
X-Gm-Message-State: AOJu0Yxtu26eKAEiAJfJo0Ixn4xGzMPk7cC5P0OWgrTooamnFK3ZTc8q
	+4Ot4W/LdOJbSo+Fxli1cvQM39qOdjhSd6bvQuQecekVuzoUZSJl/ARcq6D6m9JkhV5Q4kd3Nph
	0R3ibYXFkejjUjHZ3Nyuzr+5YKk4C/IteU1RSdA==
X-Google-Smtp-Source: AGHT+IERh+PiA1Qd89wFK4G8QOMOMLkCJxsc4FQYkX5UiHnEJiFUUG2AxIaYWctZuBMcA60K8efoMjkOoas2FK6bPbc=
X-Received: by 2002:a05:6102:3754:b0:472:c09e:66a4 with SMTP id
 u20-20020a056102375400b00472c09e66a4mr1076216vst.18.1709516086551; Sun, 03
 Mar 2024 17:34:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229003753.134193-1-21cnbao@gmail.com> <20240229003753.134193-6-21cnbao@gmail.com>
In-Reply-To: <20240229003753.134193-6-21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 4 Mar 2024 14:34:35 +1300
Message-ID: <CAGsJ_4yrpSQ+BN_VtUUx7SVLqNzOSyJoLrqs6rHZHoDvFPGVEw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/5] mm: support large folios swapin as a whole
To: akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org, 
	ryan.roberts@arm.com, chrisl@kernel.org
Cc: linux-kernel@vger.kernel.org, mhocko@suse.com, shy828301@gmail.com, 
	steven.price@arm.com, surenb@google.com, wangkefeng.wang@huawei.com, 
	willy@infradead.org, xiang@kernel.org, ying.huang@intel.com, 
	yuzhao@google.com, kasong@tencent.com, yosryahmed@google.com, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-arm-kernel@lists.infradead.org, Chuanhua Han <hanchuanhua@oppo.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 1:39=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
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
> rather than page. On the other hand, it can also decrease do_swap_page as=
 PTEs
> used to be set one by one even we hit a large folio in swapcache.
>
> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/memory.c | 191 ++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 157 insertions(+), 34 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 90b08b7cbaac..471689ce4e91 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -104,9 +104,16 @@ struct page *mem_map;
>  EXPORT_SYMBOL(mem_map);
>  #endif
>
> +/* A choice of behaviors for alloc_anon_folio() */
> +enum behavior {
> +       DO_SWAP_PAGE,
> +       DO_ANON_PAGE,
> +};
> +
>  static vm_fault_t do_fault(struct vm_fault *vmf);
>  static vm_fault_t do_anonymous_page(struct vm_fault *vmf);
>  static bool vmf_pte_changed(struct vm_fault *vmf);
> +static struct folio *alloc_anon_folio(struct vm_fault *vmf, enum behavio=
r behavior);
>
>  /*
>   * Return true if the original pte was a uffd-wp pte marker (so the pte =
was
> @@ -3974,6 +3981,52 @@ static vm_fault_t handle_pte_marker(struct vm_faul=
t *vmf)
>         return VM_FAULT_SIGBUS;
>  }
>
> +/*
> + * check a range of PTEs are completely swap entries with
> + * contiguous swap offsets and the same SWAP_HAS_CACHE.
> + * pte must be first one in the range
> + */
> +static bool is_pte_range_contig_swap(pte_t *pte, int nr_pages)
> +{
> +       int i;
> +       struct swap_info_struct *si;
> +       swp_entry_t entry;
> +       unsigned type;
> +       pgoff_t start_offset;
> +       char has_cache;
> +
> +       entry =3D pte_to_swp_entry(ptep_get_lockless(pte));
> +       if (non_swap_entry(entry))
> +               return false;
> +       start_offset =3D swp_offset(entry);
> +       if (start_offset % nr_pages)
> +               return false;
> +
> +       si =3D swp_swap_info(entry);
> +       type =3D swp_type(entry);
> +       has_cache =3D si->swap_map[start_offset] & SWAP_HAS_CACHE;
> +       for (i =3D 1; i < nr_pages; i++) {
> +               entry =3D pte_to_swp_entry(ptep_get_lockless(pte + i));
> +               if (non_swap_entry(entry))
> +                       return false;
> +               if (swp_offset(entry) !=3D start_offset + i)
> +                       return false;
> +               if (swp_type(entry) !=3D type)
> +                       return false;
> +               /*
> +                * while allocating a large folio and doing swap_read_fol=
io for the
> +                * SWP_SYNCHRONOUS_IO path, which is the case the being f=
aulted pte
> +                * doesn't have swapcache. We need to ensure all PTEs hav=
e no cache
> +                * as well, otherwise, we might go to swap devices while =
the content
> +                * is in swapcache
> +                */
> +               if ((si->swap_map[start_offset + i] & SWAP_HAS_CACHE) !=
=3D has_cache)
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
>  /*
>   * We enter with non-exclusive mmap_lock (to exclude vma changes,
>   * but allow concurrent faults), and pte mapped but not yet locked.
> @@ -3995,6 +4048,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         pte_t pte;
>         vm_fault_t ret =3D 0;
>         void *shadow =3D NULL;
> +       int nr_pages =3D 1;
> +       unsigned long start_address;
> +       pte_t *start_pte;
>
>         if (!pte_unmap_same(vmf))
>                 goto out;
> @@ -4058,28 +4114,32 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         if (!folio) {
>                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>                     __swap_count(entry) =3D=3D 1) {
> -                       /*
> -                        * Prevent parallel swapin from proceeding with
> -                        * the cache flag. Otherwise, another thread may
> -                        * finish swapin first, free the entry, and swapo=
ut
> -                        * reusing the same entry. It's undetectable as
> -                        * pte_same() returns true due to entry reuse.
> -                        */
> -                       if (swapcache_prepare(entry)) {
> -                               /* Relax a bit to prevent rapid repeated =
page faults */
> -                               schedule_timeout_uninterruptible(1);
> -                               goto out;
> -                       }
> -                       need_clear_cache =3D true;
> -
>                         /* skip swapcache */
> -                       folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0=
,
> -                                               vma, vmf->address, false)=
;
> +                       folio =3D alloc_anon_folio(vmf, DO_SWAP_PAGE);
>                         page =3D &folio->page;
>                         if (folio) {
>                                 __folio_set_locked(folio);
>                                 __folio_set_swapbacked(folio);
>
> +                               if (folio_test_large(folio)) {
> +                                       nr_pages =3D folio_nr_pages(folio=
);
> +                                       entry.val =3D ALIGN_DOWN(entry.va=
l, nr_pages);
> +                               }
> +
> +                               /*
> +                                * Prevent parallel swapin from proceedin=
g with
> +                                * the cache flag. Otherwise, another thr=
ead may
> +                                * finish swapin first, free the entry, a=
nd swapout
> +                                * reusing the same entry. It's undetecta=
ble as
> +                                * pte_same() returns true due to entry r=
euse.
> +                                */
> +                               if (swapcache_prepare_nr(entry, nr_pages)=
) {
> +                                       /* Relax a bit to prevent rapid r=
epeated page faults */
> +                                       schedule_timeout_uninterruptible(=
1);
> +                                       goto out;
> +                               }
> +                               need_clear_cache =3D true;
> +
>                                 if (mem_cgroup_swapin_charge_folio(folio,
>                                                         vma->vm_mm, GFP_K=
ERNEL,
>                                                         entry)) {
> @@ -4185,6 +4245,42 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
> +               pte_t *aligned_pte =3D vmf->pte - (vmf->address - addr) /=
 PAGE_SIZE;
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
> +               if (!is_pte_range_contig_swap(aligned_pte, nr)) {
> +                       if (nr_pages > 1) /* ptes have changed for case 1=
 */
> +                               goto out_nomap;
> +                       goto check_pte;
> +               }
> +
> +               start_address =3D addr;
> +               start_pte =3D aligned_pte;
> +               /*
> +                * the below has been done before swap_read_folio()
> +                * for case 1
> +                */
> +               if (unlikely(folio =3D=3D swapcache)) {
> +                       nr_pages =3D nr;
> +                       entry.val =3D ALIGN_DOWN(entry.val, nr_pages);
> +                       page =3D &folio->page;
> +               }
> +       }
> +
> +check_pte:
>         if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig=
_pte)))
>                 goto out_nomap;
>
> @@ -4252,12 +4348,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
> @@ -4267,14 +4365,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
> @@ -4283,17 +4381,19 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>
>         /* ksm created a completely new copy */
>         if (unlikely(folio !=3D swapcache && swapcache)) {
> -               folio_add_new_anon_rmap(folio, vma, vmf->address);
> +               folio_add_new_anon_rmap(folio, vma, start_address);
>                 folio_add_lru_vma(folio, vma);
> +       } else if (!folio_test_anon(folio)) {
> +               folio_add_new_anon_rmap(folio, vma, start_address);
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
> +       arch_do_swap_page(vma->vm_mm, vma, start_address, pte, vmf->orig_=
pte);
>
>         folio_unlock(folio);
>         if (folio !=3D swapcache && swapcache) {
> @@ -4310,6 +4410,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         }
>
>         if (vmf->flags & FAULT_FLAG_WRITE) {
> +               if (nr_pages > 1)
> +                       vmf->orig_pte =3D ptep_get(vmf->pte);
> +
>                 ret |=3D do_wp_page(vmf);
>                 if (ret & VM_FAULT_ERROR)
>                         ret &=3D VM_FAULT_ERROR;
> @@ -4317,14 +4420,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         }
>
>         /* No need to invalidate - it was non-present before */
> -       update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
> +       update_mmu_cache_range(vmf, vma, start_address, start_pte, nr_pag=
es);
>  unlock:
>         if (vmf->pte)
>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>  out:
>         /* Clear the swap cache pin for direct swapin after PTL unlock */
>         if (need_clear_cache)
> -               swapcache_clear(si, entry);
> +               swapcache_clear_nr(si, entry, nr_pages);
>         if (si)
>                 put_swap_device(si);
>         return ret;
> @@ -4340,7 +4443,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 folio_put(swapcache);
>         }
>         if (need_clear_cache)
> -               swapcache_clear(si, entry);
> +               swapcache_clear_nr(si, entry, nr_pages);
>         if (si)
>                 put_swap_device(si);
>         return ret;
> @@ -4358,7 +4461,7 @@ static bool pte_range_none(pte_t *pte, int nr_pages=
)
>         return true;
>  }
>
> -static struct folio *alloc_anon_folio(struct vm_fault *vmf)
> +static struct folio *alloc_anon_folio(struct vm_fault *vmf, enum behavio=
r behavior)
>  {
>         struct vm_area_struct *vma =3D vmf->vma;
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> @@ -4376,6 +4479,19 @@ static struct folio *alloc_anon_folio(struct vm_fa=
ult *vmf)
>         if (unlikely(userfaultfd_armed(vma)))
>                 goto fallback;
>
> +       /*
> +        * a large folio being swapped-in could be partially in
> +        * zswap and partially in swap devices, zswap doesn't
> +        * support large folios yet, we might get corrupted
> +        * zero-filled data by reading all subpages from swap
> +        * devices while some of them are actually in zswap
> +        */
> +       if (behavior =3D=3D DO_SWAP_PAGE && is_zswap_enabled())
> +               goto fallback;
> +
> +       if (unlikely(behavior !=3D DO_ANON_PAGE && behavior !=3D DO_SWAP_=
PAGE))
> +               return ERR_PTR(-EINVAL);
> +
>         /*
>          * Get a list of all the (large) orders below PMD_ORDER that are =
enabled
>          * for this vma. Then filter out the orders that can't be allocat=
ed over
> @@ -4393,15 +4509,22 @@ static struct folio *alloc_anon_folio(struct vm_f=
ault *vmf)
>                 return ERR_PTR(-EAGAIN);
>
>         /*
> -        * Find the highest order where the aligned range is completely
> -        * pte_none(). Note that all remaining orders will be completely
> +        * For do_anonymous_page, find the highest order where the aligne=
d range is
> +        * completely pte_none(). Note that all remaining orders will be =
completely
>          * pte_none().
> +        * For do_swap_page, find the highest order where the aligned ran=
ge is
> +        * completely swap entries with contiguous swap offsets.
>          */
>         order =3D highest_order(orders);
>         while (orders) {
>                 addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> -               if (pte_range_none(pte + pte_index(addr), 1 << order))
> -                       break;
> +               if (behavior =3D=3D DO_ANON_PAGE) {
> +                       if (pte_range_none(pte + pte_index(addr), 1 << or=
der))
> +                               break;
> +               } else  {
> +                       if (is_pte_range_contig_swap(pte + pte_index(addr=
), 1 << order))
> +                               break;
> +               }
>                 order =3D next_order(&orders, order);
>         }

We have a problem here.  alloc_anon_folio() is charging folio
        /* Try allocating the highest of the remaining orders. */
        gfp =3D vma_thp_gfp_mask(vma);
        while (orders) {
                addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
                folio =3D vma_alloc_folio(gfp, order, vma, addr, true);
                if (folio) {
                        if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
                                folio_put(folio);
                                goto next;
                        }
                        folio_throttle_swaprate(folio, gfp);
                        clear_huge_page(&folio->page, vmf->address, 1 << or=
der);
                        return folio;
                }
next:
                order =3D next_order(&orders, order);
        }
This is necessary for DO_ANON_PAGE. but for DO_SWAP_PAGE, this is
wrong.

because in do_swap_page, mem_cgroup_swapin_charge_folio() is done again.
                                if (mem_cgroup_swapin_charge_folio(folio,
                                                        vma->vm_mm, GFP_KER=
NEL,
                                                        entry)) {
                                        ret =3D VM_FAULT_OOM;
                                        goto out_page;
                                }

So in the do_swap_page() case, charging is done twice.
will get it fixed in v3.

This is also true for folio_prealloc() at the end of alloc_anon_folio()

>
> @@ -4485,7 +4608,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault=
 *vmf)
>         if (unlikely(anon_vma_prepare(vma)))
>                 goto oom;
>         /* Returns NULL on OOM or ERR_PTR(-EAGAIN) if we must retry the f=
ault */
> -       folio =3D alloc_anon_folio(vmf);
> +       folio =3D alloc_anon_folio(vmf, DO_ANON_PAGE);
>         if (IS_ERR(folio))
>                 return 0;
>         if (!folio)
> --
> 2.34.1
>

Thanks
Barry

