Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56117FB646
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343836AbjK1Jtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjK1Jtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:49:41 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD9EDA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:49:45 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7ba962d534eso1527167241.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701164984; x=1701769784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEDpKKqx295lSXgX2fNkWzZkSkBqQvkhbXkIuPTvSWQ=;
        b=MM7JpKax80SJlB+9dv/yh4G86Sp9szLst4myNH0wv0J2cas+yiSmBTHId4m4q9VoAa
         QpkP8yk1r3mv61lfj53NeVGEqoPpSNtemAk+FaUCVxuyzMCA9AwjP1x/bAFbT3qT/W9n
         ERmmwjwUzvUL/Y+hDLxmbgoU5yb+qfiLA8LxgrgNL6dLECRNgFdKTkiDpWiWr3C0Z0Q0
         gox4V9hUJQ6n6Al3s8FfPK4+rCqidJl4sCOtZG1I2pGvD35d3ONoN/ile6XYmHvM31d6
         BfsKvGPpBEhT17X/CtvfvdhiKEYP9DC/zHxE6FEvzdsDBtCcPLohfGfgRHMm6TvQTjcy
         P1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701164984; x=1701769784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEDpKKqx295lSXgX2fNkWzZkSkBqQvkhbXkIuPTvSWQ=;
        b=oknxiErhK/ahI1uxo+7Dloox73hiMnbcuj7PdOXwLJufQmjyrYLj+97X4pU++HeNmC
         z/F6fIYs27n0jS3jmhEKThMYrQ3WfzQzoA2voJWU4BlYbsfyVR+/RyLAd+bpCfCUaERE
         Ob67pEqyLudNm55mbfqKwv5uge8Eb10A63NFDiLHNPnruj0RS5SZ7PXnU9Xwe3pIg8ki
         zg6QR4IPgaxOVVfdnYX/0F/pfxFcbGHGn7gAwPzRpQJThHQ1t0T+GL12hBXMHasGBvMd
         VGVTRKbK2lBIPd4SpDCVTjJlhexp+CMGA+RiV5l+r3W3N+0WDOKOKy8ZlbNouoqCH/Td
         qJJA==
X-Gm-Message-State: AOJu0YwoAOzqGbOBWks06KawnG7pYS17iRSzci8Aa5GWRYzoZYTNMkNJ
        sbF6eILyu/08D8JXqngkbSLGDN8V3ffemENCsqk=
X-Google-Smtp-Source: AGHT+IEQtYJvd64KMW40rsGgptDAPd+COjgxVQvxGy7gUCOJqBScwnmKU9/amdibhjfHt65dtZPq2aFsEpwpb6WEXUA=
X-Received: by 2002:a67:eb90:0:b0:45b:64f8:86a4 with SMTP id
 e16-20020a67eb90000000b0045b64f886a4mr14512958vso.14.1701164984491; Tue, 28
 Nov 2023 01:49:44 -0800 (PST)
MIME-Version: 1.0
References: <271f1e98-6217-4b40-bae0-0ac9fe5851cb@redhat.com>
 <20231127084217.13110-1-v-songbaohua@oppo.com> <bfebd80b-b60d-48e2-b350-7c0ac0299cda@arm.com>
 <CAGsJ_4zMwxNw76bweq-23x5ibpWnERCCwg_kz3zn1pjzeY0qXw@mail.gmail.com>
 <c359a8a6-8221-4d83-a945-580039042056@arm.com> <CAGsJ_4zbB5QHu=x9U2-QNFi7SPJkw0hTE+jQoLPcq2rCMC9ArA@mail.gmail.com>
 <d55e534d-c822-448e-92e0-a4e43122ce88@arm.com> <CAGsJ_4yto+q=PmzOVTu=ELPQjMAcjVi3qvg=1K3++nbSpcK+XQ@mail.gmail.com>
 <7c4c8ab2-8eb2-472d-ad8d-9d6c20b2191c@arm.com>
In-Reply-To: <7c4c8ab2-8eb2-472d-ad8d-9d6c20b2191c@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 28 Nov 2023 22:49:33 +1300
Message-ID: <CAGsJ_4xfsifqD2sDHO_9fVJEicHqK5j7QZv73UToUjadA0J5-w@mail.gmail.com>
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

On Tue, Nov 28, 2023 at 10:14=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 27/11/2023 20:34, Barry Song wrote:
> > On Tue, Nov 28, 2023 at 12:07=E2=80=AFAM Ryan Roberts <ryan.roberts@arm=
.com> wrote:
> >>
> >> On 27/11/2023 10:28, Barry Song wrote:
> >>> On Mon, Nov 27, 2023 at 11:11=E2=80=AFPM Ryan Roberts <ryan.roberts@a=
rm.com> wrote:
> >>>>
> >>>> On 27/11/2023 09:59, Barry Song wrote:
> >>>>> On Mon, Nov 27, 2023 at 10:35=E2=80=AFPM Ryan Roberts <ryan.roberts=
@arm.com> wrote:
> >>>>>>
> >>>>>> On 27/11/2023 08:42, Barry Song wrote:
> >>>>>>>>> +           for (i =3D 0; i < nr; i++, page++) {
> >>>>>>>>> +                   if (anon) {
> >>>>>>>>> +                           /*
> >>>>>>>>> +                            * If this page may have been pinne=
d by the
> >>>>>>>>> +                            * parent process, copy the page im=
mediately for
> >>>>>>>>> +                            * the child so that we'll always g=
uarantee the
> >>>>>>>>> +                            * pinned page won't be randomly re=
placed in the
> >>>>>>>>> +                            * future.
> >>>>>>>>> +                            */
> >>>>>>>>> +                           if (unlikely(page_try_dup_anon_rmap=
(
> >>>>>>>>> +                                           page, false, src_vm=
a))) {
> >>>>>>>>> +                                   if (i !=3D 0)
> >>>>>>>>> +                                           break;
> >>>>>>>>> +                                   /* Page may be pinned, we h=
ave to copy. */
> >>>>>>>>> +                                   return copy_present_page(
> >>>>>>>>> +                                           dst_vma, src_vma, d=
st_pte,
> >>>>>>>>> +                                           src_pte, addr, rss,=
 prealloc,
> >>>>>>>>> +                                           page);
> >>>>>>>>> +                           }
> >>>>>>>>> +                           rss[MM_ANONPAGES]++;
> >>>>>>>>> +                           VM_BUG_ON(PageAnonExclusive(page));
> >>>>>>>>> +                   } else {
> >>>>>>>>> +                           page_dup_file_rmap(page, false);
> >>>>>>>>> +                           rss[mm_counter_file(page)]++;
> >>>>>>>>> +                   }
> >>>>>>>>>             }
> >>>>>>>>> -           rss[MM_ANONPAGES]++;
> >>>>>>>>> -   } else if (page) {
> >>>>>>>>> -           folio_get(folio);
> >>>>>>>>> -           page_dup_file_rmap(page, false);
> >>>>>>>>> -           rss[mm_counter_file(page)]++;
> >>>>>>>>> +
> >>>>>>>>> +           nr =3D i;
> >>>>>>>>> +           folio_ref_add(folio, nr);
> >>>>>>>>
> >>>>>>>> You're changing the order of mapcount vs. refcount increment. Do=
n't.
> >>>>>>>> Make sure your refcount >=3D mapcount.
> >>>>>>>>
> >>>>>>>> You can do that easily by doing the folio_ref_add(folio, nr) fir=
st and
> >>>>>>>> then decrementing in case of error accordingly. Errors due to pi=
nned
> >>>>>>>> pages are the corner case.
> >>>>>>>>
> >>>>>>>> I'll note that it will make a lot of sense to have batch variant=
s of
> >>>>>>>> page_try_dup_anon_rmap() and page_dup_file_rmap().
> >>>>>>>>
> >>>>>>>
> >>>>>>> i still don't understand why it is not a entire map+1, but an inc=
rement
> >>>>>>> in each basepage.
> >>>>>>
> >>>>>> Because we are PTE-mapping the folio, we have to account each indi=
vidual page.
> >>>>>> If we accounted the entire folio, where would we unaccount it? Eac=
h page can be
> >>>>>> unmapped individually (e.g. munmap() part of the folio) so need to=
 account each
> >>>>>> page. When PMD mapping, the whole thing is either mapped or unmapp=
ed, and its
> >>>>>> atomic, so we can account the entire thing.
> >>>>>
> >>>>> Hi Ryan,
> >>>>>
> >>>>> There is no problem. for example, a large folio is entirely mapped =
in
> >>>>> process A with CONPTE,
> >>>>> and only page2 is mapped in process B.
> >>>>> then we will have
> >>>>>
> >>>>> entire_map =3D 0
> >>>>> page0.map =3D -1
> >>>>> page1.map =3D -1
> >>>>> page2.map =3D 0
> >>>>> page3.map =3D -1
> >>>>> ....
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> as long as it is a CONTPTE large folio, there is no much differen=
ce with
> >>>>>>> PMD-mapped large folio. it has all the chance to be DoubleMap and=
 need
> >>>>>>> split.
> >>>>>>>
> >>>>>>> When A and B share a CONTPTE large folio, we do madvise(DONTNEED)=
 or any
> >>>>>>> similar things on a part of the large folio in process A,
> >>>>>>>
> >>>>>>> this large folio will have partially mapped subpage in A (all CON=
TPE bits
> >>>>>>> in all subpages need to be removed though we only unmap a part of=
 the
> >>>>>>> large folioas HW requires consistent CONTPTEs); and it has entire=
 map in
> >>>>>>> process B(all PTEs are still CONPTES in process B).
> >>>>>>>
> >>>>>>> isn't it more sensible for this large folios to have entire_map =
=3D 0(for
> >>>>>>> process B), and subpages which are still mapped in process A has =
map_count
> >>>>>>> =3D0? (start from -1).
> >>>>>>>
> >>>>>>>> Especially, the batch variant of page_try_dup_anon_rmap() would =
only
> >>>>>>>> check once if the folio maybe pinned, and in that case, you can =
simply
> >>>>>>>> drop all references again. So you either have all or no ptes to =
process,
> >>>>>>>> which makes that code easier.
> >>>>>>
> >>>>>> I'm afraid this doesn't make sense to me. Perhaps I've misundersto=
od. But
> >>>>>> fundamentally you can only use entire_mapcount if its only possibl=
e to map and
> >>>>>> unmap the whole folio atomically.
> >>>>>
> >>>>>
> >>>>>
> >>>>> My point is that CONTPEs should either all-set in all 16 PTEs or al=
l are dropped
> >>>>> in 16 PTEs. if all PTEs have CONT, it is entirely mapped; otherwise=
,
> >>>>> it is partially
> >>>>> mapped. if a large folio is mapped in one processes with all CONTPT=
Es
> >>>>> and meanwhile in another process with partial mapping(w/o CONTPTE),=
 it is
> >>>>> DoubleMapped.
> >>>>
> >>>> There are 2 problems with your proposal, as I see it;
> >>>>
> >>>> 1) the core-mm is not enlightened for CONTPTE mappings. As far as it=
 is
> >>>> concerned, its just mapping a bunch of PTEs. So it has no hook to in=
c/dec
> >>>> entire_mapcount. The arch code is opportunistically and *transparent=
ly* managing
> >>>> the CONT_PTE bit.
> >>>>
> >>>> 2) There is nothing to say a folio isn't *bigger* than the contpte b=
lock; it may
> >>>> be 128K and be mapped with 2 contpte blocks. Or even a PTE-mapped TH=
P (2M) and
> >>>> be mapped with 32 contpte blocks. So you can't say it is entirely ma=
pped
> >>>> unless/until ALL of those blocks are set up. And then of course each=
 block could
> >>>> be unmapped unatomically.
> >>>>
> >>>> For the PMD case there are actually 2 properties that allow using th=
e
> >>>> entire_mapcount optimization; It's atomically mapped/unmapped throug=
h the PMD
> >>>> and we know that the folio is exactly PMD sized (since it must be at=
 least PMD
> >>>> sized to be able to map it with the PMD, and we don't allocate THPs =
any bigger
> >>>> than PMD size). So one PMD map or unmap operation corresponds to exa=
ctly one
> >>>> *entire* map or unmap. That is not true when we are PTE mapping.
> >>>
> >>> well. Thanks for clarification. based on the above description, i agr=
ee the
> >>> current code might make more sense by always using mapcount in subpag=
e.
> >>>
> >>> I gave my proposals as  I thought we were always CONTPTE size for sma=
ll-THP
> >>> then we could drop the loop to iterate 16 times rmap. if we do it
> >>> entirely, we only
> >>> need to do dup rmap once for all 16 PTEs by increasing entire_map.
> >>
> >> Well its always good to have the discussion - so thanks for the ideas.=
 I think
> >> there is a bigger question lurking here; should we be exposing the con=
cept of
> >> contpte mappings to the core-mm rather than burying it in the arm64 ar=
ch code?
> >> I'm confident that would be a huge amount of effort and the end result=
 would be
> >> similar performace to what this approach gives. One potential benefit =
of letting
> >> core-mm control it is that it would also give control to core-mm over =
the
> >> granularity of access/dirty reporting (my approach implicitly ties it =
to the
> >> folio). Having sub-folio access tracking _could_ potentially help with=
 future
> >> work to make THP size selection automatic, but we are not there yet, a=
nd I think
> >> there are other (simpler) ways to achieve the same thing. So my view i=
s that
> >> _not_ exposing it to core-mm is the right way for now.
> >
> > Hi Ryan,
> >
> > We(OPPO) started a similar project like you even before folio was impor=
ted to
> > mainline, we have deployed the dynamic hugepage(that is how we name it)
> > on millions of mobile phones on real products and kernels before 5.16, =
 making
> > a huge success on performance improvement. for example, you may
> > find the out-of-tree 5.15 source code here
>
> Oh wow, thanks for reaching out and explaining this - I have to admit I f=
eel
> embarrassed that I clearly didn't do enough research on the prior art bec=
ause I
> wasn't aware of your work. So sorry about that.
>
> I sensed that you had a different model for how this should work vs what =
I've
> implemented and now I understand why :). I'll review your stuff and I'm s=
ure
> I'll have questions. I'm sure each solution has pros and cons.
>
>
> >
> > https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/tree/oneplu=
s/sm8550_u_14.0.0_oneplus11
> >
> > Our modification might not be so clean and has lots of workarounds
> > just for the stability of products
> >
> > We mainly have
> >
> > 1. https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/one=
plus/sm8550_u_14.0.0_oneplus11/mm/cont_pte_hugepage.c
> >
> > some CONTPTE helpers
> >
> > 2.https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/onep=
lus/sm8550_u_14.0.0_oneplus11/include/linux/mm.h
> >
> > some Dynamic Hugepage APIs
> >
> > 3. https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/one=
plus/sm8550_u_14.0.0_oneplus11/mm/memory.c
> >
> > modified all page faults to support
> >      (1). allocation of hugepage of 64KB in do_anon_page
>
> My Small-Sized THP patch set is handling the equivalent of this.

right, the only difference is that we did a huge-zeropage for reading
in do_anon_page.
mapping all large folios to CONTPTE to zero page.

>
> >      (2). CoW hugepage in do_wp_page
>
> This isn't handled yet in my patch set; the original RFC implemented it b=
ut I
> removed it in order to strip back to the essential complexity for the ini=
tial
> submission. DavidH has been working on a precise shared vs exclusive map
> tracking mechanism - if that goes in, it will make CoWing large folios si=
mpler.
> Out of interest, what workloads benefit most from this?

as a phone, Android has a design almost all processes are forked from zygot=
e.
thus, CoW happens quite often to all apps.

>
> >      (3). copy CONPTEs in copy_pte_range
>
> As discussed this is done as part of the contpte patch set, but its not j=
ust a
> simple copy; the arch code will notice and set the CONT_PTE bit as needed=
.

right, i have read all your unfold and fold stuff today, now i understand y=
our
approach seems quite nice!


>
> >      (4). allocate and swap-in Hugepage as a whole in do_swap_page
>
> This is going to be a problem but I haven't even looked at this properly =
yet.
> The advice so far has been to continue to swap-in small pages only, but i=
mprove
> khugepaged to collapse to small-sized THP. I'll take a look at your code =
to
> understand how you did this.

this is also crucial to android phone as swap is always happening
on an embedded device. if we don't support large folios in swapin,
our large folios will never come back after it is swapped-out.

and i hated the collapse solution from the first beginning as there is
never a guarantee to succeed and its overhead is unacceptable to user UI,
so we supported hugepage allocation in do_swap_page from the first beginnin=
g.

>
> >
> > 4. https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/one=
plus/sm8550_u_14.0.0_oneplus11/mm/vmscan.c
> > https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/oneplu=
s/sm8550_u_14.0.0_oneplus11/mm/rmap.c
> >
> > reclaim hugepage as a whole and LRU optimization for 64KB dynamic hugep=
age.
>
> I think this is all naturally handled by the folio code that exists in mo=
dern
> kernels?

We had a CONTPTE hugepage pool, if the pool is very limited, we let LRU
reclaim large folios to the pool. as phones are running lots of apps
and drivers, and the memory is very limited, after a couple of hours,
it will become very hard to allocate large folios in the original buddy. th=
us,
large folios totally disappeared after running the phone for some time
if we didn't have the pool.

>
> >
> > So we are 100% interested in your patchset and hope it can find a way
> > to land on the
> > mainline, thus decreasing all the cost we have to maintain out-of-tree
> > code from a
> > kernel to another kernel version which we have done on a couple of
> > kernel versions
> > before 5.16. Firmly, we are 100% supportive of large anon folios
> > things you are leading.
>
> That's great to hear! Of course Reviewed-By's and Tested-By's will all he=
lp move
> it closer :). If you had any ability to do any A/B performance testing, i=
t would
> be very interesting to see how this stacks up against your solution - if =
there
> are gaps it would be good to know where and develop a plan to plug the ga=
p.
>

sure.

> >
> > A big pain was we found lots of races especially on CONTPTE unfolding
> > and especially a part
> > of basepages ran away from the 16 CONPTEs group since userspace is
> > always working
> > on basepages, having no idea of small-THP.  We ran our code on millions=
 of
> > real phones, and now we have got them fixed (or maybe "can't reproduce"=
),
> > no outstanding issue.
>
> I'm going to be brave and say that my solution shouldn't suffer from thes=
e
> problems; but of course the proof is only in the testing. I did a lot of =
work
> with our architecture group and micro architects to determine exactly wha=
t is
> and isn't safe; We even tightened the Arm ARM spec very subtlely to allow=
 the
> optimization in patch 13 (see the commit log for details). Of course this=
 has
> all been checked with partners and we are confident that all existing
> implementations conform to the modified wording.

cool. I like your try_unfold/fold code. it seems your code is setting/dropp=
ing
CONT automatically based on ALIGHMENT, Page number etc. Alternatively,
our code is always stupidly checking some conditions before setting and dro=
pping
CONT everywhere.

>
> >
> > Particularly for the rmap issue we are discussing, our out-of-tree is
> > using the entire_map for
> > CONTPTE in the way I sent to you. But I guess we can learn from you to =
decouple
> > CONTPTE from mm-core.
> >
> > We are doing this in mm/memory.c
> >
> > copy_present_cont_pte(struct vm_area_struct *dst_vma, struct
> > vm_area_struct *src_vma,
> > pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
> > struct page **prealloc)
> > {
> >       struct mm_struct *src_mm =3D src_vma->vm_mm;
> >       unsigned long vm_flags =3D src_vma->vm_flags;
> >       pte_t pte =3D *src_pte;
> >       struct page *page;
> >
> >        page =3D vm_normal_page(src_vma, addr, pte);
> >       ...
> >
> >      get_page(page);
> >      page_dup_rmap(page, true);   // an entire dup_rmap as you can
> > see.............
> >      rss[mm_counter(page)] +=3D HPAGE_CONT_PTE_NR;
> > }
> >
> > and we have a split in mm/cont_pte_hugepage.c to handle partially unmap=
,
> >
> > static void __split_huge_cont_pte_locked(struct vm_area_struct *vma, pt=
e_t *pte,
> > unsigned long haddr, bool freeze)
> > {
> > ...
> >            if (compound_mapcount(head) > 1 && !TestSetPageDoubleMap(hea=
d)) {
> >                   for (i =3D 0; i < HPAGE_CONT_PTE_NR; i++)
> >                            atomic_inc(&head[i]._mapcount);
> >                  atomic_long_inc(&cont_pte_double_map_count);
> >            }
> >
> >
> >             if (atomic_add_negative(-1, compound_mapcount_ptr(head))) {
> >               ...
> > }
> >
> > I am not selling our solution any more, but just showing you some diffe=
rences we
> > have :-)
>
> OK, I understand what you were saying now. I'm currently struggling to se=
e how
> this could fit into my model. Do you have any workloads and numbers on pe=
rf
> improvement of using entire_mapcount?

TBH, I don't have any data on this as from the first beginning, we were usi=
ng
entire_map. So I have no comparison at all.

>
> >
> >>
> >>>
> >>> BTW, I have concerns that a variable small-THP size will really work
> >>> as userspace
> >>> is probably friendly to only one fixed size. for example, userspace
> >>> heap management
> >>> might be optimized to a size for freeing memory to the kernel. it is
> >>> very difficult
> >>> for the heap to adapt to various sizes at the same time. frequent unm=
ap/free
> >>> size not equal with, and particularly smaller than small-THP size wil=
l
> >>> defeat all
> >>> efforts to use small-THP.
> >>
> >> I'll admit to not knowing a huge amount about user space allocators. B=
ut I will
> >> say that as currently defined, the small-sized THP interface to user s=
pace
> >> allows a sysadmin to specifically enable the set of sizes that they wa=
nt; so a
> >> single size can be enabled. I'm diliberately punting that decision awa=
y from the
> >> kernel for now.
> >
> > Basically, userspace heap library has a PAGESIZE setting and allows use=
rs
> > to allocate/free all kinds of small objects such as 16,32,64,128,256,51=
2 etc.
> > The default size is for sure equal to the basepage SIZE. once some obje=
cts are
> > freed by free() and libc get a free "page", userspace heap libraries mi=
ght free
> > the PAGESIZE page to kernel by things like MADV_DONTNEED, then zap_pte_=
range().
> > it is quite similar with kernel slab.
> >
> > so imagine we have small-THP now, but userspace libraries have *NO*
> > idea at all,  so it can frequently cause unfolding.
> >
> >>
> >> FWIW, My experience with the Speedometer/JavaScript use case is that p=
erformance
> >> is a little bit better when enabling 64+32+16K vs just 64K THP.
> >>
> >> Functionally, it will not matter if the allocator is not enlightened f=
or the THP
> >> size; it can continue to free, and if a partial folio is unmapped it i=
s put on
> >> the deferred split list, then under memory pressure it is split and th=
e unused
> >> pages are reclaimed. I guess this is the bit you are concerned about h=
aving a
> >> performance impact?
> >
> > right. If this is happening on the majority of small-THP folios, we
> > don't have performance
> > improvement, and probably regression instead. This is really true on
> > real workloads!!
> >
> > So that is why we really love a per-VMA hint to enable small-THP but
> > obviously you
> > have already supported it now by
> > mm: thp: Introduce per-size thp sysfs interface
> > https://lore.kernel.org/linux-mm/20231122162950.3854897-4-ryan.roberts@=
arm.com/
> >
> > we can use MADVISE rather than ALWAYS and set fixed size like 64KB, so =
userspace
> > can set the VMA flag when it is quite sure this VMA is working with
> > the alignment
> > of 64KB?
>
> Yes, that all exists in the series today. We have also discussed the poss=
ibility
> of adding a new madvise_process() call that would take the set of THP siz=
es that
> should be considered. Then you can set different VMAs to use different si=
zes;
> the plan was to layer that on top if/when a workload was identified. Soun=
ds like
> you might be able to help there?

i'm not quite sure as on phones, we are using fixed-size CONTPTE. so we ask
for either 64KB or 4KB. If we think one VMA is all good to use CONTPTE, we
set a flag in this VMA and try to allocate 64KB.

But I will try to understand this requirement to madvise THPs size on a spe=
cific
VMA.

>
> >
> >>
> >> Regardless, it would be good to move this conversation to the small-si=
zed THP
> >> patch series since this is all independent of contpte mappings.
> >>
> >>>
> >>>>
> >>>>>
> >>>>> Since we always hold ptl to set or drop CONTPTE bits, set/drop is
> >>>>> still atomic in a
> >>>>> spinlock area.
> >>>>>
> >>>>>>
> >>>>>>>>
> >>>>>>>> But that can be added on top, and I'll happily do that.
> >>>>>>>>
> >>>>>>>> --
> >>>>>>>> Cheers,
> >>>>>>>>
> >>>>>>>> David / dhildenb
> >>>>>>>
> >>>>>
> >>>

Thanks
Barry
