Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E7B7FC89F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376321AbjK1VGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346563AbjK1VGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:06:18 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2214F5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:06:22 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b845ba9ba9so3705621b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701205582; x=1701810382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEsAIMvxIwQMWMlVTCeCB2Ta92NOvAscN8kG65aUKP4=;
        b=NSIGXzzSnZ8IE+lzsc4zQ9QUWsBay8cgO9wHTzjplDbepMksMCAmWTlstTNWfoPEPt
         IarUPZgrfeIHntpIKiDVBRFy+m+RyvmbsYe78AaZ3bVjuY2ynwgmgL898o72EJ6Cq/yQ
         S3XEMBcWkszLDNOGKnRgsKfIm8aScrYRdvRxZhwq5eLpCgiNY8j4xw3Xnvu/vWOsm+O+
         9q1aAI9SGaALHwvmijVGqvJKOWsZE8wv6wQJ7pV2Vu+3GT19VZrG/t7hxTnmcFZrmd3M
         P+aSqilGLVdJ7mc0UJSfb+7MeNhRpD05WmurA13L8L/DvUlCDleF3j30nQO+aIDf3j2v
         G6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701205582; x=1701810382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEsAIMvxIwQMWMlVTCeCB2Ta92NOvAscN8kG65aUKP4=;
        b=RA0RREiiZm+SAWpMfHs+n7QeMl/k6J6Ud5TCSRVrsI7PxlA7TI34MHKUrerTK69o/x
         wZ64LuezZDjY8IkOC2gd3AVP04Z+RCZt2YZZN0QXS5dNhTQEbNOb40i1zFJ8Zdaczbyr
         vJ+RsIciiYxhYAYDqETu1Oah79EuawLEk0sUO0qlIYO4Wil9drpHzxCOwUMCfc7j7+2u
         1+oo/8Vxt623K45GcXMhWFLOmQ4xt4yMt7rFH6XaHREsrfswVEyouz9jEHv56yFcCE1D
         a2KtuspNNKdEB+RMW9ayb0O2Ml+qM2Cc40O+Mwid7pYakTQVrrBNeMn59jBh9SWJcQCN
         eStA==
X-Gm-Message-State: AOJu0Yw1Zy017pkX1ft966wgWBq/GEOdki8PG/w+rnvT9pyDD1kf1iaU
        eC88vXgJlXK8KmIiP6nmUhnQau2/MhAnUbFnGqQ=
X-Google-Smtp-Source: AGHT+IGdC1zAK/P4KW8wni51weOoutBqs41LAIg5LFRzEDzK/A/+OzD+Z9ZUOyDZw9wbTz9G9DgPyKpLJZpQB+jHe/E=
X-Received: by 2002:a05:6358:7245:b0:16d:a0d3:d285 with SMTP id
 i5-20020a056358724500b0016da0d3d285mr20055205rwa.18.1701205581729; Tue, 28
 Nov 2023 13:06:21 -0800 (PST)
MIME-Version: 1.0
References: <271f1e98-6217-4b40-bae0-0ac9fe5851cb@redhat.com>
 <20231127084217.13110-1-v-songbaohua@oppo.com> <bfebd80b-b60d-48e2-b350-7c0ac0299cda@arm.com>
 <CAGsJ_4zMwxNw76bweq-23x5ibpWnERCCwg_kz3zn1pjzeY0qXw@mail.gmail.com>
 <c359a8a6-8221-4d83-a945-580039042056@arm.com> <CAGsJ_4zbB5QHu=x9U2-QNFi7SPJkw0hTE+jQoLPcq2rCMC9ArA@mail.gmail.com>
 <d55e534d-c822-448e-92e0-a4e43122ce88@arm.com> <CAGsJ_4yto+q=PmzOVTu=ELPQjMAcjVi3qvg=1K3++nbSpcK+XQ@mail.gmail.com>
 <7c4c8ab2-8eb2-472d-ad8d-9d6c20b2191c@arm.com> <CAGsJ_4xfsifqD2sDHO_9fVJEicHqK5j7QZv73UToUjadA0J5-w@mail.gmail.com>
 <974feb64-d056-4f3c-9166-9b116bea1318@arm.com>
In-Reply-To: <974feb64-d056-4f3c-9166-9b116bea1318@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 29 Nov 2023 10:06:10 +1300
Message-ID: <CAGsJ_4yh3Pzd38FihpC7-O2=1uy-MBcgey1o=19=NUrfLTjZAA@mail.gmail.com>
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

On Tue, Nov 28, 2023 at 11:49=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 28/11/2023 09:49, Barry Song wrote:
> > On Tue, Nov 28, 2023 at 10:14=E2=80=AFPM Ryan Roberts <ryan.roberts@arm=
.com> wrote:
> >>
> >> On 27/11/2023 20:34, Barry Song wrote:
> >>> On Tue, Nov 28, 2023 at 12:07=E2=80=AFAM Ryan Roberts <ryan.roberts@a=
rm.com> wrote:
> >>>>
> >>>> On 27/11/2023 10:28, Barry Song wrote:
> >>>>> On Mon, Nov 27, 2023 at 11:11=E2=80=AFPM Ryan Roberts <ryan.roberts=
@arm.com> wrote:
> >>>>>>
> >>>>>> On 27/11/2023 09:59, Barry Song wrote:
> >>>>>>> On Mon, Nov 27, 2023 at 10:35=E2=80=AFPM Ryan Roberts <ryan.rober=
ts@arm.com> wrote:
> >>>>>>>>
> >>>>>>>> On 27/11/2023 08:42, Barry Song wrote:
> >>>>>>>>>>> +           for (i =3D 0; i < nr; i++, page++) {
> >>>>>>>>>>> +                   if (anon) {
> >>>>>>>>>>> +                           /*
> >>>>>>>>>>> +                            * If this page may have been pin=
ned by the
> >>>>>>>>>>> +                            * parent process, copy the page =
immediately for
> >>>>>>>>>>> +                            * the child so that we'll always=
 guarantee the
> >>>>>>>>>>> +                            * pinned page won't be randomly =
replaced in the
> >>>>>>>>>>> +                            * future.
> >>>>>>>>>>> +                            */
> >>>>>>>>>>> +                           if (unlikely(page_try_dup_anon_rm=
ap(
> >>>>>>>>>>> +                                           page, false, src_=
vma))) {
> >>>>>>>>>>> +                                   if (i !=3D 0)
> >>>>>>>>>>> +                                           break;
> >>>>>>>>>>> +                                   /* Page may be pinned, we=
 have to copy. */
> >>>>>>>>>>> +                                   return copy_present_page(
> >>>>>>>>>>> +                                           dst_vma, src_vma,=
 dst_pte,
> >>>>>>>>>>> +                                           src_pte, addr, rs=
s, prealloc,
> >>>>>>>>>>> +                                           page);
> >>>>>>>>>>> +                           }
> >>>>>>>>>>> +                           rss[MM_ANONPAGES]++;
> >>>>>>>>>>> +                           VM_BUG_ON(PageAnonExclusive(page)=
);
> >>>>>>>>>>> +                   } else {
> >>>>>>>>>>> +                           page_dup_file_rmap(page, false);
> >>>>>>>>>>> +                           rss[mm_counter_file(page)]++;
> >>>>>>>>>>> +                   }
> >>>>>>>>>>>             }
> >>>>>>>>>>> -           rss[MM_ANONPAGES]++;
> >>>>>>>>>>> -   } else if (page) {
> >>>>>>>>>>> -           folio_get(folio);
> >>>>>>>>>>> -           page_dup_file_rmap(page, false);
> >>>>>>>>>>> -           rss[mm_counter_file(page)]++;
> >>>>>>>>>>> +
> >>>>>>>>>>> +           nr =3D i;
> >>>>>>>>>>> +           folio_ref_add(folio, nr);
> >>>>>>>>>>
> >>>>>>>>>> You're changing the order of mapcount vs. refcount increment. =
Don't.
> >>>>>>>>>> Make sure your refcount >=3D mapcount.
> >>>>>>>>>>
> >>>>>>>>>> You can do that easily by doing the folio_ref_add(folio, nr) f=
irst and
> >>>>>>>>>> then decrementing in case of error accordingly. Errors due to =
pinned
> >>>>>>>>>> pages are the corner case.
> >>>>>>>>>>
> >>>>>>>>>> I'll note that it will make a lot of sense to have batch varia=
nts of
> >>>>>>>>>> page_try_dup_anon_rmap() and page_dup_file_rmap().
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> i still don't understand why it is not a entire map+1, but an i=
ncrement
> >>>>>>>>> in each basepage.
> >>>>>>>>
> >>>>>>>> Because we are PTE-mapping the folio, we have to account each in=
dividual page.
> >>>>>>>> If we accounted the entire folio, where would we unaccount it? E=
ach page can be
> >>>>>>>> unmapped individually (e.g. munmap() part of the folio) so need =
to account each
> >>>>>>>> page. When PMD mapping, the whole thing is either mapped or unma=
pped, and its
> >>>>>>>> atomic, so we can account the entire thing.
> >>>>>>>
> >>>>>>> Hi Ryan,
> >>>>>>>
> >>>>>>> There is no problem. for example, a large folio is entirely mappe=
d in
> >>>>>>> process A with CONPTE,
> >>>>>>> and only page2 is mapped in process B.
> >>>>>>> then we will have
> >>>>>>>
> >>>>>>> entire_map =3D 0
> >>>>>>> page0.map =3D -1
> >>>>>>> page1.map =3D -1
> >>>>>>> page2.map =3D 0
> >>>>>>> page3.map =3D -1
> >>>>>>> ....
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> as long as it is a CONTPTE large folio, there is no much differ=
ence with
> >>>>>>>>> PMD-mapped large folio. it has all the chance to be DoubleMap a=
nd need
> >>>>>>>>> split.
> >>>>>>>>>
> >>>>>>>>> When A and B share a CONTPTE large folio, we do madvise(DONTNEE=
D) or any
> >>>>>>>>> similar things on a part of the large folio in process A,
> >>>>>>>>>
> >>>>>>>>> this large folio will have partially mapped subpage in A (all C=
ONTPE bits
> >>>>>>>>> in all subpages need to be removed though we only unmap a part =
of the
> >>>>>>>>> large folioas HW requires consistent CONTPTEs); and it has enti=
re map in
> >>>>>>>>> process B(all PTEs are still CONPTES in process B).
> >>>>>>>>>
> >>>>>>>>> isn't it more sensible for this large folios to have entire_map=
 =3D 0(for
> >>>>>>>>> process B), and subpages which are still mapped in process A ha=
s map_count
> >>>>>>>>> =3D0? (start from -1).
> >>>>>>>>>
> >>>>>>>>>> Especially, the batch variant of page_try_dup_anon_rmap() woul=
d only
> >>>>>>>>>> check once if the folio maybe pinned, and in that case, you ca=
n simply
> >>>>>>>>>> drop all references again. So you either have all or no ptes t=
o process,
> >>>>>>>>>> which makes that code easier.
> >>>>>>>>
> >>>>>>>> I'm afraid this doesn't make sense to me. Perhaps I've misunders=
tood. But
> >>>>>>>> fundamentally you can only use entire_mapcount if its only possi=
ble to map and
> >>>>>>>> unmap the whole folio atomically.
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> My point is that CONTPEs should either all-set in all 16 PTEs or =
all are dropped
> >>>>>>> in 16 PTEs. if all PTEs have CONT, it is entirely mapped; otherwi=
se,
> >>>>>>> it is partially
> >>>>>>> mapped. if a large folio is mapped in one processes with all CONT=
PTEs
> >>>>>>> and meanwhile in another process with partial mapping(w/o CONTPTE=
), it is
> >>>>>>> DoubleMapped.
> >>>>>>
> >>>>>> There are 2 problems with your proposal, as I see it;
> >>>>>>
> >>>>>> 1) the core-mm is not enlightened for CONTPTE mappings. As far as =
it is
> >>>>>> concerned, its just mapping a bunch of PTEs. So it has no hook to =
inc/dec
> >>>>>> entire_mapcount. The arch code is opportunistically and *transpare=
ntly* managing
> >>>>>> the CONT_PTE bit.
> >>>>>>
> >>>>>> 2) There is nothing to say a folio isn't *bigger* than the contpte=
 block; it may
> >>>>>> be 128K and be mapped with 2 contpte blocks. Or even a PTE-mapped =
THP (2M) and
> >>>>>> be mapped with 32 contpte blocks. So you can't say it is entirely =
mapped
> >>>>>> unless/until ALL of those blocks are set up. And then of course ea=
ch block could
> >>>>>> be unmapped unatomically.
> >>>>>>
> >>>>>> For the PMD case there are actually 2 properties that allow using =
the
> >>>>>> entire_mapcount optimization; It's atomically mapped/unmapped thro=
ugh the PMD
> >>>>>> and we know that the folio is exactly PMD sized (since it must be =
at least PMD
> >>>>>> sized to be able to map it with the PMD, and we don't allocate THP=
s any bigger
> >>>>>> than PMD size). So one PMD map or unmap operation corresponds to e=
xactly one
> >>>>>> *entire* map or unmap. That is not true when we are PTE mapping.
> >>>>>
> >>>>> well. Thanks for clarification. based on the above description, i a=
gree the
> >>>>> current code might make more sense by always using mapcount in subp=
age.
> >>>>>
> >>>>> I gave my proposals as  I thought we were always CONTPTE size for s=
mall-THP
> >>>>> then we could drop the loop to iterate 16 times rmap. if we do it
> >>>>> entirely, we only
> >>>>> need to do dup rmap once for all 16 PTEs by increasing entire_map.
> >>>>
> >>>> Well its always good to have the discussion - so thanks for the idea=
s. I think
> >>>> there is a bigger question lurking here; should we be exposing the c=
oncept of
> >>>> contpte mappings to the core-mm rather than burying it in the arm64 =
arch code?
> >>>> I'm confident that would be a huge amount of effort and the end resu=
lt would be
> >>>> similar performace to what this approach gives. One potential benefi=
t of letting
> >>>> core-mm control it is that it would also give control to core-mm ove=
r the
> >>>> granularity of access/dirty reporting (my approach implicitly ties i=
t to the
> >>>> folio). Having sub-folio access tracking _could_ potentially help wi=
th future
> >>>> work to make THP size selection automatic, but we are not there yet,=
 and I think
> >>>> there are other (simpler) ways to achieve the same thing. So my view=
 is that
> >>>> _not_ exposing it to core-mm is the right way for now.
> >>>
> >>> Hi Ryan,
> >>>
> >>> We(OPPO) started a similar project like you even before folio was imp=
orted to
> >>> mainline, we have deployed the dynamic hugepage(that is how we name i=
t)
> >>> on millions of mobile phones on real products and kernels before 5.16=
,  making
> >>> a huge success on performance improvement. for example, you may
> >>> find the out-of-tree 5.15 source code here
> >>
> >> Oh wow, thanks for reaching out and explaining this - I have to admit =
I feel
> >> embarrassed that I clearly didn't do enough research on the prior art =
because I
> >> wasn't aware of your work. So sorry about that.
> >>
> >> I sensed that you had a different model for how this should work vs wh=
at I've
> >> implemented and now I understand why :). I'll review your stuff and I'=
m sure
> >> I'll have questions. I'm sure each solution has pros and cons.
> >>
> >>
> >>>
> >>> https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/tree/onep=
lus/sm8550_u_14.0.0_oneplus11
> >>>
> >>> Our modification might not be so clean and has lots of workarounds
> >>> just for the stability of products
> >>>
> >>> We mainly have
> >>>
> >>> 1. https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/o=
neplus/sm8550_u_14.0.0_oneplus11/mm/cont_pte_hugepage.c
> >>>
> >>> some CONTPTE helpers
> >>>
> >>> 2.https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/on=
eplus/sm8550_u_14.0.0_oneplus11/include/linux/mm.h
> >>>
> >>> some Dynamic Hugepage APIs
> >>>
> >>> 3. https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/o=
neplus/sm8550_u_14.0.0_oneplus11/mm/memory.c
> >>>
> >>> modified all page faults to support
> >>>      (1). allocation of hugepage of 64KB in do_anon_page
> >>
> >> My Small-Sized THP patch set is handling the equivalent of this.
> >
> > right, the only difference is that we did a huge-zeropage for reading
> > in do_anon_page.
> > mapping all large folios to CONTPTE to zero page.
>
> FWIW, I took a slightly different approach in my original RFC for the zer=
o page
> - although I ripped it all out to simplify for the initial series. I foun=
d that
> it was pretty rare for user space to read multiple consecutive pages with=
out
> ever interleving any writes, so I kept the zero page as a base page, but =
at CoW,
> I would expand the allocation to an approprately sized THP. But for the c=
ouple
> of workloads that I've gone deep with, I found that it made barely any de=
nt on
> the amount of memory that ended up contpte-mapped; the vast majority was =
from
> write allocation in do_anonymous_page().

the problem is even if there is only one page read in 16 ptes, you
will map the page to
zero basepage. then while you write another page in these 16 ptes, you
lose the chance
to become large folio as pte_range_none() becomes false.

if we map these 16ptes to contpte zero page, in do_wp_page, we have a
good chance
to CoW and get a large anon folio.

>
> >
> >>
> >>>      (2). CoW hugepage in do_wp_page
> >>
> >> This isn't handled yet in my patch set; the original RFC implemented i=
t but I
> >> removed it in order to strip back to the essential complexity for the =
initial
> >> submission. DavidH has been working on a precise shared vs exclusive m=
ap
> >> tracking mechanism - if that goes in, it will make CoWing large folios=
 simpler.
> >> Out of interest, what workloads benefit most from this?
> >
> > as a phone, Android has a design almost all processes are forked from z=
ygote.
> > thus, CoW happens quite often to all apps.
>
> Sure. But in my analysis I concluded that most of the memory mapped in zy=
gote is
> file-backed and mostly RO so therefore doing THP CoW doesn't help much. P=
erhaps
> there are cases where that conclusion is wrong.

CoW is much less than do_anon_page on my phone which is running dynamic
hugepage for a couple of hours:

OP52D1L1:/ # cat /proc/cont_pte_hugepage/stat
...
thp_cow 34669                           ---- CoW a large folio
thp_do_anon_pages 1032362     -----  a large folio in do_anon_page
...

so it is around 34669/1032362 =3D 3.35%.

>
> >
> >>
> >>>      (3). copy CONPTEs in copy_pte_range
> >>
> >> As discussed this is done as part of the contpte patch set, but its no=
t just a
> >> simple copy; the arch code will notice and set the CONT_PTE bit as nee=
ded.
> >
> > right, i have read all your unfold and fold stuff today, now i understa=
nd your
> > approach seems quite nice!
>
> Great - thanks!
>
> >
> >
> >>
> >>>      (4). allocate and swap-in Hugepage as a whole in do_swap_page
> >>
> >> This is going to be a problem but I haven't even looked at this proper=
ly yet.
> >> The advice so far has been to continue to swap-in small pages only, bu=
t improve
> >> khugepaged to collapse to small-sized THP. I'll take a look at your co=
de to
> >> understand how you did this.
> >
> > this is also crucial to android phone as swap is always happening
> > on an embedded device. if we don't support large folios in swapin,
> > our large folios will never come back after it is swapped-out.
> >
> > and i hated the collapse solution from the first beginning as there is
> > never a guarantee to succeed and its overhead is unacceptable to user U=
I,
> > so we supported hugepage allocation in do_swap_page from the first begi=
nning.
>
> Understood. I agree it would be nice to preserve large folios across swap=
. I
> think this can be layered on top of the current work though.

This will be my first priority to use your large folio code on phones.
We need a patchset
on top of yours :-)

without it, we will likely fail. Typically, one phone can have a 4~8GB
zRAM to compress
a lot of anon pages, if the compression ratio is 1:4, that means
uncompressed anon
pages are much much more. Thus, while the background app is switched back
to foreground, we need those swapped-out large folios back rather than gett=
ing
small basepages replacement. swap-in basepage is definitely not going to
work well on a phone, neither does THP collapse.

>
> >
> >>
> >>>
> >>> 4. https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/o=
neplus/sm8550_u_14.0.0_oneplus11/mm/vmscan.c
> >>> https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/onep=
lus/sm8550_u_14.0.0_oneplus11/mm/rmap.c
> >>>
> >>> reclaim hugepage as a whole and LRU optimization for 64KB dynamic hug=
epage.
> >>
> >> I think this is all naturally handled by the folio code that exists in=
 modern
> >> kernels?
> >
> > We had a CONTPTE hugepage pool, if the pool is very limited, we let LRU
> > reclaim large folios to the pool. as phones are running lots of apps
> > and drivers, and the memory is very limited, after a couple of hours,
> > it will become very hard to allocate large folios in the original buddy=
. thus,
> > large folios totally disappeared after running the phone for some time
> > if we didn't have the pool.
> >
> >>
> >>>
> >>> So we are 100% interested in your patchset and hope it can find a way
> >>> to land on the
> >>> mainline, thus decreasing all the cost we have to maintain out-of-tre=
e
> >>> code from a
> >>> kernel to another kernel version which we have done on a couple of
> >>> kernel versions
> >>> before 5.16. Firmly, we are 100% supportive of large anon folios
> >>> things you are leading.
> >>
> >> That's great to hear! Of course Reviewed-By's and Tested-By's will all=
 help move
> >> it closer :). If you had any ability to do any A/B performance testing=
, it would
> >> be very interesting to see how this stacks up against your solution - =
if there
> >> are gaps it would be good to know where and develop a plan to plug the=
 gap.
> >>
> >
> > sure.
> >
> >>>
> >>> A big pain was we found lots of races especially on CONTPTE unfolding
> >>> and especially a part
> >>> of basepages ran away from the 16 CONPTEs group since userspace is
> >>> always working
> >>> on basepages, having no idea of small-THP.  We ran our code on millio=
ns of
> >>> real phones, and now we have got them fixed (or maybe "can't reproduc=
e"),
> >>> no outstanding issue.
> >>
> >> I'm going to be brave and say that my solution shouldn't suffer from t=
hese
> >> problems; but of course the proof is only in the testing. I did a lot =
of work
> >> with our architecture group and micro architects to determine exactly =
what is
> >> and isn't safe; We even tightened the Arm ARM spec very subtlely to al=
low the
> >> optimization in patch 13 (see the commit log for details). Of course t=
his has
> >> all been checked with partners and we are confident that all existing
> >> implementations conform to the modified wording.
> >
> > cool. I like your try_unfold/fold code. it seems your code is setting/d=
ropping
> > CONT automatically based on ALIGHMENT, Page number etc. Alternatively,
> > our code is always stupidly checking some conditions before setting and=
 dropping
> > CONT everywhere.
> >
> >>
> >>>
> >>> Particularly for the rmap issue we are discussing, our out-of-tree is
> >>> using the entire_map for
> >>> CONTPTE in the way I sent to you. But I guess we can learn from you t=
o decouple
> >>> CONTPTE from mm-core.
> >>>
> >>> We are doing this in mm/memory.c
> >>>
> >>> copy_present_cont_pte(struct vm_area_struct *dst_vma, struct
> >>> vm_area_struct *src_vma,
> >>> pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
> >>> struct page **prealloc)
> >>> {
> >>>       struct mm_struct *src_mm =3D src_vma->vm_mm;
> >>>       unsigned long vm_flags =3D src_vma->vm_flags;
> >>>       pte_t pte =3D *src_pte;
> >>>       struct page *page;
> >>>
> >>>        page =3D vm_normal_page(src_vma, addr, pte);
> >>>       ...
> >>>
> >>>      get_page(page);
> >>>      page_dup_rmap(page, true);   // an entire dup_rmap as you can
> >>> see.............
> >>>      rss[mm_counter(page)] +=3D HPAGE_CONT_PTE_NR;
> >>> }
> >>>
> >>> and we have a split in mm/cont_pte_hugepage.c to handle partially unm=
ap,
> >>>
> >>> static void __split_huge_cont_pte_locked(struct vm_area_struct *vma, =
pte_t *pte,
> >>> unsigned long haddr, bool freeze)
> >>> {
> >>> ...
> >>>            if (compound_mapcount(head) > 1 && !TestSetPageDoubleMap(h=
ead)) {
> >>>                   for (i =3D 0; i < HPAGE_CONT_PTE_NR; i++)
> >>>                            atomic_inc(&head[i]._mapcount);
> >>>                  atomic_long_inc(&cont_pte_double_map_count);
> >>>            }
> >>>
> >>>
> >>>             if (atomic_add_negative(-1, compound_mapcount_ptr(head)))=
 {
> >>>               ...
> >>> }
> >>>
> >>> I am not selling our solution any more, but just showing you some dif=
ferences we
> >>> have :-)
> >>
> >> OK, I understand what you were saying now. I'm currently struggling to=
 see how
> >> this could fit into my model. Do you have any workloads and numbers on=
 perf
> >> improvement of using entire_mapcount?
> >
> > TBH, I don't have any data on this as from the first beginning, we were=
 using
> > entire_map. So I have no comparison at all.
> >
> >>
> >>>
> >>>>
> >>>>>
> >>>>> BTW, I have concerns that a variable small-THP size will really wor=
k
> >>>>> as userspace
> >>>>> is probably friendly to only one fixed size. for example, userspace
> >>>>> heap management
> >>>>> might be optimized to a size for freeing memory to the kernel. it i=
s
> >>>>> very difficult
> >>>>> for the heap to adapt to various sizes at the same time. frequent u=
nmap/free
> >>>>> size not equal with, and particularly smaller than small-THP size w=
ill
> >>>>> defeat all
> >>>>> efforts to use small-THP.
> >>>>
> >>>> I'll admit to not knowing a huge amount about user space allocators.=
 But I will
> >>>> say that as currently defined, the small-sized THP interface to user=
 space
> >>>> allows a sysadmin to specifically enable the set of sizes that they =
want; so a
> >>>> single size can be enabled. I'm diliberately punting that decision a=
way from the
> >>>> kernel for now.
> >>>
> >>> Basically, userspace heap library has a PAGESIZE setting and allows u=
sers
> >>> to allocate/free all kinds of small objects such as 16,32,64,128,256,=
512 etc.
> >>> The default size is for sure equal to the basepage SIZE. once some ob=
jects are
> >>> freed by free() and libc get a free "page", userspace heap libraries =
might free
> >>> the PAGESIZE page to kernel by things like MADV_DONTNEED, then zap_pt=
e_range().
> >>> it is quite similar with kernel slab.
> >>>
> >>> so imagine we have small-THP now, but userspace libraries have *NO*
> >>> idea at all,  so it can frequently cause unfolding.
> >>>
> >>>>
> >>>> FWIW, My experience with the Speedometer/JavaScript use case is that=
 performance
> >>>> is a little bit better when enabling 64+32+16K vs just 64K THP.
> >>>>
> >>>> Functionally, it will not matter if the allocator is not enlightened=
 for the THP
> >>>> size; it can continue to free, and if a partial folio is unmapped it=
 is put on
> >>>> the deferred split list, then under memory pressure it is split and =
the unused
> >>>> pages are reclaimed. I guess this is the bit you are concerned about=
 having a

> >>>> performance impact?
> >>>
> >>> right. If this is happening on the majority of small-THP folios, we
> >>> don't have performance
> >>> improvement, and probably regression instead. This is really true on
> >>> real workloads!!
> >>>
> >>> So that is why we really love a per-VMA hint to enable small-THP but
> >>> obviously you
> >>> have already supported it now by
> >>> mm: thp: Introduce per-size thp sysfs interface
> >>> https://lore.kernel.org/linux-mm/20231122162950.3854897-4-ryan.robert=
s@arm.com/
> >>>
> >>> we can use MADVISE rather than ALWAYS and set fixed size like 64KB, s=
o userspace
> >>> can set the VMA flag when it is quite sure this VMA is working with
> >>> the alignment
> >>> of 64KB?
> >>
> >> Yes, that all exists in the series today. We have also discussed the p=
ossibility
> >> of adding a new madvise_process() call that would take the set of THP =
sizes that
> >> should be considered. Then you can set different VMAs to use different=
 sizes;
> >> the plan was to layer that on top if/when a workload was identified. S=
ounds like
> >> you might be able to help there?
> >
> > i'm not quite sure as on phones, we are using fixed-size CONTPTE. so we=
 ask
> > for either 64KB or 4KB. If we think one VMA is all good to use CONTPTE,=
 we
> > set a flag in this VMA and try to allocate 64KB.
>
> When you say "we set a flag" do you mean user space? Or is there some heu=
ristic
> in the kernel?

we are using a field extended by the android kernel in vma struct to
mark this vma
is all good to use CONTPTE. With the upstream solution you are providing, w=
e can
remove this dirty code[1].
static inline bool vma_is_chp_anonymous(struct vm_area_struct *vma)
{
            return vma->android_kabi_reserved2 =3D=3D THP_SWAP_PRIO_MAGIC;
}

[1] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/oneplu=
s/sm8550_u_14.0.0_oneplus11/include/linux/mm.h#L4031

Thanks
Barry
