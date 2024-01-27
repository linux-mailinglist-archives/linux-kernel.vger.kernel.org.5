Return-Path: <linux-kernel+bounces-41384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8800D83EFDB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2BA284E0D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527502E847;
	Sat, 27 Jan 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsvsX7Sq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1026F2E832
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706385220; cv=none; b=UVp/vo8JcdChruKbVf+aL8aks4EGeoRqYya/EqbdVPGau4ZaRKKermQaliFVbtr1laMDga2gdRL7hH6L0yhmwrlok6f5TFdmMvSMJ4n0XxDgba30sHBphSonH2FygyB3c9yWgfBIQ+jGTCfCiS+iC5W9S9azozLXzfd1QODrx1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706385220; c=relaxed/simple;
	bh=j4v/A1mVl/hwvoSbJrZBrn3tRpELbeqOdvJi4/jO23g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0PDZx4CqAa895jyLXjGoVFBKACdzEEc1hFwHhQtYaTdfLZ/dfKkeaOq2autqBbO9m8MnFc3jrraqs3VudLPVebh5GuBy1MyVJSpMvNTy8mzptp9XfZrCj4ASdpFXw93R15MWX40Qse8W01wkL4NI/WXs0iWSr1p502fDL6acvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsvsX7Sq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67C6C433A6
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 19:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706385219;
	bh=j4v/A1mVl/hwvoSbJrZBrn3tRpELbeqOdvJi4/jO23g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WsvsX7SqptqpMAej4Bp7s9AzIAZxR3l8kX5WmRmq8vnHR3et5xOaxsNFeeYJrqfeD
	 RQhuLIOZCJZmDfshbh7NG7UJnZ4zNRVh7pVKK1EAwGtvvipzIfAh5kHdlXtK7GnrH0
	 20UmyA5Om2Zv6CfC92wl8D/emcGB4WWCoOVJ3Cde3zivgKi3wKVQD72DzQABJXihz4
	 i4PhNIUrYONQ/rPO/Lh0A6P1pFC5xQW+aNfnfYAdDGoQ63Z18z0O/fbxMZ5z0qaNDO
	 Xwzzypds7HkndR5XrjK4Z2mzb8jOzhBlXnabCykv8hdkb+7YsAogBnarfs5eHFh2AW
	 5SIQzKJX3CPzA==
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7bfd527d443so41779539f.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 11:53:39 -0800 (PST)
X-Gm-Message-State: AOJu0YwxnIqZy82fxq7mIUT/fQyDKZ+/DpbnEVY6YUPfy1hLrJMqHnoI
	otRyaYXrXnx/xum8Hd8Cyw2GLD327guBaEHw5qUTcreR+KWd1w+VPxR3ukw804HT/6pJ29r0Whh
	/K/Tmgmi8hi4bQr48TFwX5qcdaYMkMves2A1G
X-Google-Smtp-Source: AGHT+IF3ZQJGVFjO++UPAapLuUsvIr+PTimeHPUMgG4n+YWKlAAJv21BsS5duQuHg0u49EwyXSXlOsoTakOgsl2o8YM=
X-Received: by 2002:a05:6e02:1a4a:b0:361:a7a2:9daf with SMTP id
 u10-20020a056e021a4a00b00361a7a29dafmr3982711ilv.27.1706385219049; Sat, 27
 Jan 2024 11:53:39 -0800 (PST)
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
Date: Sat, 27 Jan 2024 11:53:26 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNDH4zVoLXJEVQLa0u5f=B0vHodrDZbUdoS+rug+wessw@mail.gmail.com>
Message-ID: <CAF8kJuNDH4zVoLXJEVQLa0u5f=B0vHodrDZbUdoS+rug+wessw@mail.gmail.com>
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

Instead of returning "bool", the pte_range_check() can return the
start of the swap entry of the large folio.
That will save some of the later code needed to get the start of the
large folio.

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

This function name seems to suggest it will perform the range swap.
That is not what it is doing.
Suggest change to some other name reflecting that it is only a
condition test without actual swap action.
I am not very good at naming functions. Just think it out loud: e.g.
pte_range_swap_check, pte_test_range_swap. You can come up with
something better.


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

This suggests the pte argument needs to point to the beginning of the
large folio equivalent of swap entry(not sure what to call it. Let me
call it "large folio swap" here.).
We might want to unify the terms for that.
Any way, might want to document this requirement, otherwise the caller
might consider passing the current pte that generates the fault. From
the function name it is not obvious which pte should pass it.

> +
> +       type =3D swp_type(entry);
> +       for (i =3D 1; i < nr_pages; i++) {

You might want to test the last page backwards, because if the entry
is not the large folio swap, most likely it will have the last entry
invalid.  Some of the beginning swap entries might match due to batch
allocation etc. The SSD likes to group the nearby swap entry write out
together on the disk.



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

This function can call pte_range_swap() twice(), one here, another one
in folio_test_large().
Consider caching the result so it does not need to walk the pte range
swap twice.

I think alloc_anon_folio should either be told what is the
size(prefered) or just figure out the right size. I don't think it
needs to pass in the checking function as function callbacks. There
are two call sites of alloc_anon_folio, they are all within this
function. The call back seems a bit overkill here. Also duplicate the
range swap walk.

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
Here is the first place place we roll up the start offset with folio size

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

Here is the second place we roll up the folio size.
Maybe we can cache results and avoid repetition?

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

One question I have in mind is that the swap device is locked. We
can't change the swap slot allocations.
It does not stop the pte entry getting changed right? Then we can have
someone in the user pace racing to change the PTE vs we checking the
pte there.

> +               if (pte_range_swap(pte_t, nr)) {

After this pte_range_swap() check, some of the PTE entries get changed
and now we don't have the full large page swap any more?
At least I can't conclude this possibility can't happen yet, please
enlighten me.

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

If we make pte_range_swap() return the entry, we can avoid refetching
the swap entry here.

> +                               page =3D &folio->page;
> +                       }
> +               } else if (nr_pages > 1) { /* ptes have changed for case =
1 */
> +                       goto out_nomap;
> +               }
> +       }
> +
I rewrote the above to make the code indentation matching the execution flo=
w.
I did not add any functional change. Just rearrange the code to be a
bit more streamlined. Get rid of the "else if goto".
               if (!pte_range_swap(pte_t, nr)) {
                        if (nr_pages > 1)  /* ptes have changed for case 1 =
*/
                                goto out_nomap;
                        goto check_pte;
                }

                start_address =3D addr;
                start_pte =3D pte_t;
                if (unlikely(folio =3D=3D swapcache)) {
                        /*
                         * the below has been done before swap_read_folio()
                         * for case 1
                         */
                        nr_pages =3D nr;
                        entry =3D pte_to_swp_entry(ptep_get(start_pte));
                        page =3D &folio->page;
                }
        }

check_pte:

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

About this patch context we have the following comments in the source code.
        /*
         * Find the highest order where the aligned range is completely
         * pte_none(). Note that all remaining orders will be completely
         * pte_none().
         */
>         order =3D highest_order(orders);
>         while (orders) {
>                 addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> -               if (pte_range_none(pte + pte_index(addr), 1 << order))
> +               if (pte_range_check(pte + pte_index(addr), 1 << order))

Again, I don't think we need to pass in the pte_range_check() as call
back functions.
There are only two call sites, all within this file. This will totally
invalide the above comments about pte_none(). In the worst case, just
make it accept one argument: it is checking swap range or none range
or not. Depending on the argument, do check none or swap range.
We should make it blend in with alloc_anon_folio better. My gut
feeling is that there should be a better way to make the range check
blend in with alloc_anon_folio better. e.g. Maybe store some of the
large swap context in the vmf and pass to different places etc. I need
to spend more time thinking about it to come up with happier
solutions.

Chris

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

