Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80927FABA3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjK0UfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjK0UfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:35:01 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B1093
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 12:35:06 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-58d9a4e9464so496890eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 12:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701117306; x=1701722106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAT+KI7L37nKb5nBTmkN0+Mjps+SgZWObSn68xDWyQo=;
        b=DMcGBckOxZMUjnOCy4AxiDQL8doWltFEDTKdaVYrsnA4SJUYhBVGyflh8PyK4StVv2
         C7Iu214ogfdSh91hCwY/UzOLRs4nApwtIPIcSysjoqj1PUF970/0bW3ij4mQInanjKkF
         orsq5/mmpNFh6kzmEns+8nrncZsG+LhpAue8oZjoAl6cDHjJ+xUPfrX702WvqMXIa3vf
         tOT+uKw2P+wSUI/sOsBJxpT0hsQvcPm7VfNk0mErmIT7tQx5hqznBSVUAEnMrASx7zr8
         j4D2t5dylwXtTcc0Bp77C4PCUrSrDa89/j3R9pB1GdUV5iJINblqj7mAXahlWKO75iGL
         /cEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701117306; x=1701722106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAT+KI7L37nKb5nBTmkN0+Mjps+SgZWObSn68xDWyQo=;
        b=tJpgnxbJgTjl5Tu/UxtQyb55z2xAPSn4yQjknQvV8hrbeAFj/eSlvaPysplbd/frL+
         BNg21cLNQlP2h+y/l/0/tWTbpogGFIqHw0WBpTfJQDpC29dRyc0i+buT1g5mk50bpi0y
         ccO2VJpVOH9rhUhUMjlopiVzTOgUjPFwI0+0Wujdsv7YtE3EQi7r/8jNIgm0BhyLTgdL
         ab8IpJ9VWbjN6o0hpcZNFyBhPEkyshmNUuLDoTDppu+HQ/9QJHITpYp+2a0vXXpvUDcU
         yCW9P0nWamMvZqvx+FOOOkS/ziTOWeo0fjH/Z40gftf1ev/Xokwp13jpu7tVxD5DZZrL
         eEzw==
X-Gm-Message-State: AOJu0Ywuojv9aXS2o1RQKxMhi7Q5rX+WX6HfE+xygFRXg8cpt85fhtRy
        83Mkx2k1fjTRJup9ri/cy/z0Zc+ue9vFEjc3i6M=
X-Google-Smtp-Source: AGHT+IG2hGw8Rvq1p6qW1RHA3s3gDhuFkhJYbEZ9PQMLsIMmnGSNGeuz7mDqyEuIk15rV0kiJgaizQSP+QxK0xq6gEg=
X-Received: by 2002:a05:6358:524d:b0:16d:f924:caed with SMTP id
 c13-20020a056358524d00b0016df924caedmr8593556rwa.21.1701117305843; Mon, 27
 Nov 2023 12:35:05 -0800 (PST)
MIME-Version: 1.0
References: <271f1e98-6217-4b40-bae0-0ac9fe5851cb@redhat.com>
 <20231127084217.13110-1-v-songbaohua@oppo.com> <bfebd80b-b60d-48e2-b350-7c0ac0299cda@arm.com>
 <CAGsJ_4zMwxNw76bweq-23x5ibpWnERCCwg_kz3zn1pjzeY0qXw@mail.gmail.com>
 <c359a8a6-8221-4d83-a945-580039042056@arm.com> <CAGsJ_4zbB5QHu=x9U2-QNFi7SPJkw0hTE+jQoLPcq2rCMC9ArA@mail.gmail.com>
 <d55e534d-c822-448e-92e0-a4e43122ce88@arm.com>
In-Reply-To: <d55e534d-c822-448e-92e0-a4e43122ce88@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 28 Nov 2023 09:34:54 +1300
Message-ID: <CAGsJ_4yto+q=PmzOVTu=ELPQjMAcjVi3qvg=1K3++nbSpcK+XQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] mm: Batch-copy PTE ranges during fork()
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     david@redhat.com, akpm@linux-foundation.org, andreyknvl@gmail.com,
        anshuman.khandual@arm.com, ardb@kernel.org,
        catalin.marinas@arm.com, dvyukov@google.com, glider@google.com,
        james.morse@arm.com, jhubbard@nvidia.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mark.rutland@arm.com, maz@kernel.org,
        oliver.upton@linux.dev, ryabinin.a.a@gmail.com,
        suzuki.poulose@arm.com, vincenzo.frascino@arm.com,
        wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org,
        yuzenghui@huawei.com, yuzhao@google.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 12:07=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 27/11/2023 10:28, Barry Song wrote:
> > On Mon, Nov 27, 2023 at 11:11=E2=80=AFPM Ryan Roberts <ryan.roberts@arm=
.com> wrote:
> >>
> >> On 27/11/2023 09:59, Barry Song wrote:
> >>> On Mon, Nov 27, 2023 at 10:35=E2=80=AFPM Ryan Roberts <ryan.roberts@a=
rm.com> wrote:
> >>>>
> >>>> On 27/11/2023 08:42, Barry Song wrote:
> >>>>>>> +           for (i =3D 0; i < nr; i++, page++) {
> >>>>>>> +                   if (anon) {
> >>>>>>> +                           /*
> >>>>>>> +                            * If this page may have been pinned =
by the
> >>>>>>> +                            * parent process, copy the page imme=
diately for
> >>>>>>> +                            * the child so that we'll always gua=
rantee the
> >>>>>>> +                            * pinned page won't be randomly repl=
aced in the
> >>>>>>> +                            * future.
> >>>>>>> +                            */
> >>>>>>> +                           if (unlikely(page_try_dup_anon_rmap(
> >>>>>>> +                                           page, false, src_vma)=
)) {
> >>>>>>> +                                   if (i !=3D 0)
> >>>>>>> +                                           break;
> >>>>>>> +                                   /* Page may be pinned, we hav=
e to copy. */
> >>>>>>> +                                   return copy_present_page(
> >>>>>>> +                                           dst_vma, src_vma, dst=
_pte,
> >>>>>>> +                                           src_pte, addr, rss, p=
realloc,
> >>>>>>> +                                           page);
> >>>>>>> +                           }
> >>>>>>> +                           rss[MM_ANONPAGES]++;
> >>>>>>> +                           VM_BUG_ON(PageAnonExclusive(page));
> >>>>>>> +                   } else {
> >>>>>>> +                           page_dup_file_rmap(page, false);
> >>>>>>> +                           rss[mm_counter_file(page)]++;
> >>>>>>> +                   }
> >>>>>>>             }
> >>>>>>> -           rss[MM_ANONPAGES]++;
> >>>>>>> -   } else if (page) {
> >>>>>>> -           folio_get(folio);
> >>>>>>> -           page_dup_file_rmap(page, false);
> >>>>>>> -           rss[mm_counter_file(page)]++;
> >>>>>>> +
> >>>>>>> +           nr =3D i;
> >>>>>>> +           folio_ref_add(folio, nr);
> >>>>>>
> >>>>>> You're changing the order of mapcount vs. refcount increment. Don'=
t.
> >>>>>> Make sure your refcount >=3D mapcount.
> >>>>>>
> >>>>>> You can do that easily by doing the folio_ref_add(folio, nr) first=
 and
> >>>>>> then decrementing in case of error accordingly. Errors due to pinn=
ed
> >>>>>> pages are the corner case.
> >>>>>>
> >>>>>> I'll note that it will make a lot of sense to have batch variants =
of
> >>>>>> page_try_dup_anon_rmap() and page_dup_file_rmap().
> >>>>>>
> >>>>>
> >>>>> i still don't understand why it is not a entire map+1, but an incre=
ment
> >>>>> in each basepage.
> >>>>
> >>>> Because we are PTE-mapping the folio, we have to account each indivi=
dual page.
> >>>> If we accounted the entire folio, where would we unaccount it? Each =
page can be
> >>>> unmapped individually (e.g. munmap() part of the folio) so need to a=
ccount each
> >>>> page. When PMD mapping, the whole thing is either mapped or unmapped=
, and its
> >>>> atomic, so we can account the entire thing.
> >>>
> >>> Hi Ryan,
> >>>
> >>> There is no problem. for example, a large folio is entirely mapped in
> >>> process A with CONPTE,
> >>> and only page2 is mapped in process B.
> >>> then we will have
> >>>
> >>> entire_map =3D 0
> >>> page0.map =3D -1
> >>> page1.map =3D -1
> >>> page2.map =3D 0
> >>> page3.map =3D -1
> >>> ....
> >>>
> >>>>
> >>>>>
> >>>>> as long as it is a CONTPTE large folio, there is no much difference=
 with
> >>>>> PMD-mapped large folio. it has all the chance to be DoubleMap and n=
eed
> >>>>> split.
> >>>>>
> >>>>> When A and B share a CONTPTE large folio, we do madvise(DONTNEED) o=
r any
> >>>>> similar things on a part of the large folio in process A,
> >>>>>
> >>>>> this large folio will have partially mapped subpage in A (all CONTP=
E bits
> >>>>> in all subpages need to be removed though we only unmap a part of t=
he
> >>>>> large folioas HW requires consistent CONTPTEs); and it has entire m=
ap in
> >>>>> process B(all PTEs are still CONPTES in process B).
> >>>>>
> >>>>> isn't it more sensible for this large folios to have entire_map =3D=
 0(for
> >>>>> process B), and subpages which are still mapped in process A has ma=
p_count
> >>>>> =3D0? (start from -1).
> >>>>>
> >>>>>> Especially, the batch variant of page_try_dup_anon_rmap() would on=
ly
> >>>>>> check once if the folio maybe pinned, and in that case, you can si=
mply
> >>>>>> drop all references again. So you either have all or no ptes to pr=
ocess,
> >>>>>> which makes that code easier.
> >>>>
> >>>> I'm afraid this doesn't make sense to me. Perhaps I've misunderstood=
. But
> >>>> fundamentally you can only use entire_mapcount if its only possible =
to map and
> >>>> unmap the whole folio atomically.
> >>>
> >>>
> >>>
> >>> My point is that CONTPEs should either all-set in all 16 PTEs or all =
are dropped
> >>> in 16 PTEs. if all PTEs have CONT, it is entirely mapped; otherwise,
> >>> it is partially
> >>> mapped. if a large folio is mapped in one processes with all CONTPTEs
> >>> and meanwhile in another process with partial mapping(w/o CONTPTE), i=
t is
> >>> DoubleMapped.
> >>
> >> There are 2 problems with your proposal, as I see it;
> >>
> >> 1) the core-mm is not enlightened for CONTPTE mappings. As far as it i=
s
> >> concerned, its just mapping a bunch of PTEs. So it has no hook to inc/=
dec
> >> entire_mapcount. The arch code is opportunistically and *transparently=
* managing
> >> the CONT_PTE bit.
> >>
> >> 2) There is nothing to say a folio isn't *bigger* than the contpte blo=
ck; it may
> >> be 128K and be mapped with 2 contpte blocks. Or even a PTE-mapped THP =
(2M) and
> >> be mapped with 32 contpte blocks. So you can't say it is entirely mapp=
ed
> >> unless/until ALL of those blocks are set up. And then of course each b=
lock could
> >> be unmapped unatomically.
> >>
> >> For the PMD case there are actually 2 properties that allow using the
> >> entire_mapcount optimization; It's atomically mapped/unmapped through =
the PMD
> >> and we know that the folio is exactly PMD sized (since it must be at l=
east PMD
> >> sized to be able to map it with the PMD, and we don't allocate THPs an=
y bigger
> >> than PMD size). So one PMD map or unmap operation corresponds to exact=
ly one
> >> *entire* map or unmap. That is not true when we are PTE mapping.
> >
> > well. Thanks for clarification. based on the above description, i agree=
 the
> > current code might make more sense by always using mapcount in subpage.
> >
> > I gave my proposals as  I thought we were always CONTPTE size for small=
-THP
> > then we could drop the loop to iterate 16 times rmap. if we do it
> > entirely, we only
> > need to do dup rmap once for all 16 PTEs by increasing entire_map.
>
> Well its always good to have the discussion - so thanks for the ideas. I =
think
> there is a bigger question lurking here; should we be exposing the concep=
t of
> contpte mappings to the core-mm rather than burying it in the arm64 arch =
code?
> I'm confident that would be a huge amount of effort and the end result wo=
uld be
> similar performace to what this approach gives. One potential benefit of =
letting
> core-mm control it is that it would also give control to core-mm over the
> granularity of access/dirty reporting (my approach implicitly ties it to =
the
> folio). Having sub-folio access tracking _could_ potentially help with fu=
ture
> work to make THP size selection automatic, but we are not there yet, and =
I think
> there are other (simpler) ways to achieve the same thing. So my view is t=
hat
> _not_ exposing it to core-mm is the right way for now.

Hi Ryan,

We(OPPO) started a similar project like you even before folio was imported =
to
mainline, we have deployed the dynamic hugepage(that is how we name it)
on millions of mobile phones on real products and kernels before 5.16,  mak=
ing
a huge success on performance improvement. for example, you may
find the out-of-tree 5.15 source code here

https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/tree/oneplus/sm=
8550_u_14.0.0_oneplus11

Our modification might not be so clean and has lots of workarounds
just for the stability of products

We mainly have

1. https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/oneplus=
/sm8550_u_14.0.0_oneplus11/mm/cont_pte_hugepage.c

some CONTPTE helpers

2.https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/oneplus/=
sm8550_u_14.0.0_oneplus11/include/linux/mm.h

some Dynamic Hugepage APIs

3. https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/oneplus=
/sm8550_u_14.0.0_oneplus11/mm/memory.c

modified all page faults to support
     (1). allocation of hugepage of 64KB in do_anon_page
     (2). CoW hugepage in do_wp_page
     (3). copy CONPTEs in copy_pte_range
     (4). allocate and swap-in Hugepage as a whole in do_swap_page

4. https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/oneplus=
/sm8550_u_14.0.0_oneplus11/mm/vmscan.c
https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/oneplus/sm=
8550_u_14.0.0_oneplus11/mm/rmap.c

reclaim hugepage as a whole and LRU optimization for 64KB dynamic hugepage.

So we are 100% interested in your patchset and hope it can find a way
to land on the
mainline, thus decreasing all the cost we have to maintain out-of-tree
code from a
kernel to another kernel version which we have done on a couple of
kernel versions
before 5.16. Firmly, we are 100% supportive of large anon folios
things you are leading.

A big pain was we found lots of races especially on CONTPTE unfolding
and especially a part
of basepages ran away from the 16 CONPTEs group since userspace is
always working
on basepages, having no idea of small-THP.  We ran our code on millions of
real phones, and now we have got them fixed (or maybe "can't reproduce"),
no outstanding issue.

Particularly for the rmap issue we are discussing, our out-of-tree is
using the entire_map for
CONTPTE in the way I sent to you. But I guess we can learn from you to deco=
uple
CONTPTE from mm-core.

We are doing this in mm/memory.c

copy_present_cont_pte(struct vm_area_struct *dst_vma, struct
vm_area_struct *src_vma,
pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
struct page **prealloc)
{
      struct mm_struct *src_mm =3D src_vma->vm_mm;
      unsigned long vm_flags =3D src_vma->vm_flags;
      pte_t pte =3D *src_pte;
      struct page *page;

       page =3D vm_normal_page(src_vma, addr, pte);
      ...

     get_page(page);
     page_dup_rmap(page, true);   // an entire dup_rmap as you can
see.............
     rss[mm_counter(page)] +=3D HPAGE_CONT_PTE_NR;
}

and we have a split in mm/cont_pte_hugepage.c to handle partially unmap,

static void __split_huge_cont_pte_locked(struct vm_area_struct *vma, pte_t =
*pte,
unsigned long haddr, bool freeze)
{
...
           if (compound_mapcount(head) > 1 && !TestSetPageDoubleMap(head)) =
{
                  for (i =3D 0; i < HPAGE_CONT_PTE_NR; i++)
                           atomic_inc(&head[i]._mapcount);
                 atomic_long_inc(&cont_pte_double_map_count);
           }


            if (atomic_add_negative(-1, compound_mapcount_ptr(head))) {
              ...
}

I am not selling our solution any more, but just showing you some differenc=
es we
have :-)

>
> >
> > BTW, I have concerns that a variable small-THP size will really work
> > as userspace
> > is probably friendly to only one fixed size. for example, userspace
> > heap management
> > might be optimized to a size for freeing memory to the kernel. it is
> > very difficult
> > for the heap to adapt to various sizes at the same time. frequent unmap=
/free
> > size not equal with, and particularly smaller than small-THP size will
> > defeat all
> > efforts to use small-THP.
>
> I'll admit to not knowing a huge amount about user space allocators. But =
I will
> say that as currently defined, the small-sized THP interface to user spac=
e
> allows a sysadmin to specifically enable the set of sizes that they want;=
 so a
> single size can be enabled. I'm diliberately punting that decision away f=
rom the
> kernel for now.

Basically, userspace heap library has a PAGESIZE setting and allows users
to allocate/free all kinds of small objects such as 16,32,64,128,256,512 et=
c.
The default size is for sure equal to the basepage SIZE. once some objects =
are
freed by free() and libc get a free "page", userspace heap libraries might =
free
the PAGESIZE page to kernel by things like MADV_DONTNEED, then zap_pte_rang=
e().
it is quite similar with kernel slab.

so imagine we have small-THP now, but userspace libraries have *NO*
idea at all,  so it can frequently cause unfolding.

>
> FWIW, My experience with the Speedometer/JavaScript use case is that perf=
ormance
> is a little bit better when enabling 64+32+16K vs just 64K THP.
>
> Functionally, it will not matter if the allocator is not enlightened for =
the THP
> size; it can continue to free, and if a partial folio is unmapped it is p=
ut on
> the deferred split list, then under memory pressure it is split and the u=
nused
> pages are reclaimed. I guess this is the bit you are concerned about havi=
ng a
> performance impact?

right. If this is happening on the majority of small-THP folios, we
don't have performance
improvement, and probably regression instead. This is really true on
real workloads!!

So that is why we really love a per-VMA hint to enable small-THP but
obviously you
have already supported it now by
mm: thp: Introduce per-size thp sysfs interface
https://lore.kernel.org/linux-mm/20231122162950.3854897-4-ryan.roberts@arm.=
com/

we can use MADVISE rather than ALWAYS and set fixed size like 64KB, so user=
space
can set the VMA flag when it is quite sure this VMA is working with
the alignment
of 64KB?

>
> Regardless, it would be good to move this conversation to the small-sized=
 THP
> patch series since this is all independent of contpte mappings.
>
> >
> >>
> >>>
> >>> Since we always hold ptl to set or drop CONTPTE bits, set/drop is
> >>> still atomic in a
> >>> spinlock area.
> >>>
> >>>>
> >>>>>>
> >>>>>> But that can be added on top, and I'll happily do that.
> >>>>>>
> >>>>>> --
> >>>>>> Cheers,
> >>>>>>
> >>>>>> David / dhildenb
> >>>>>
> >>>
> >

Thanks
Barry
