Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40817F9D8B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbjK0K3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjK0K3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:29:01 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F4A10E6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:29:02 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7c46d224b45so926014241.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701080941; x=1701685741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shZQ+S7x4tTu8+8gjD68J2xWVVR//+1g56EcTBBB4d0=;
        b=YPCMJx6KLFo/b+EPZZ0EBCTEwk+FgBCtQnf9j1eJhqXDVISNYrk/e6a88c3flwz2E2
         HPXEg6Fjk/1kuYKWeU+gMs20xMGrMJrXzyCHZouHO+IrplXaZBVLV0+QZ7pmFbJSe0zk
         yQCiiDmmcOVktOLziArhvAEqdFczrvBzmAZ3PaqD7ddUgcPMGVuvtYgNzF0DKenSrHHD
         1j7Ss/JIRHLsb8B91MrwehyFEIttOZKgLR+uL9xsZpZJg7oqGSoZI/xSdwv+2sztXXGn
         rQB2f9CE+HcMjmrmZWa/ETcHw/rYQn3lNUVNYPcZnG4oW+BT8OUZ17OzNGpRuKr7kXyp
         9l/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701080941; x=1701685741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shZQ+S7x4tTu8+8gjD68J2xWVVR//+1g56EcTBBB4d0=;
        b=PecKbONihrj8Ci5/mRHvXOrPbMabFjbnNSx/2dmPlYub+RH3ljl4/hgrafGdGhFuL5
         YeOasD68xmWyuu028PDmIdOHmqzMIpu69b1x/W8py5Y5gNT49IxEE8np0YjButQBmEB6
         XmA2wvCLfXscH0LMpHp8MZxMpBQjfozk8gAdo7OP1o584rCXby8CqunEq2sUBHqU4zY4
         /yBNHZVdFtgWurhcPrZzZDHKWoYu4ewHVeRZ6iimHUfu8aB8SpG9p9TiqqehY5eScNaF
         wWKu/ueqntEGKLnI/TgtpNY3wTl6K77N12XWxWBizIz3p0bxvz/Jc/DoQkd16+/Aed5A
         gvGw==
X-Gm-Message-State: AOJu0YyRRHT9wkV6fZqphRBKt4TPLvDd7NHw8s3Hwwgwi7OwIFKKBvWP
        jWUK8QsYGruUiCAhFWhrmQdHONhioB7QJUz0zXo=
X-Google-Smtp-Source: AGHT+IFBDA6vCKUQacA5Dijs0r8dEmG6MgJxt9NqpRTxprHkakZ7PCzpRZI60+9ydCphoOz/Uk+sV8qY9FDo8OuiZ0I=
X-Received: by 2002:a67:bd1a:0:b0:462:71ee:5ef6 with SMTP id
 y26-20020a67bd1a000000b0046271ee5ef6mr5438891vsq.17.1701080941077; Mon, 27
 Nov 2023 02:29:01 -0800 (PST)
MIME-Version: 1.0
References: <271f1e98-6217-4b40-bae0-0ac9fe5851cb@redhat.com>
 <20231127084217.13110-1-v-songbaohua@oppo.com> <bfebd80b-b60d-48e2-b350-7c0ac0299cda@arm.com>
 <CAGsJ_4zMwxNw76bweq-23x5ibpWnERCCwg_kz3zn1pjzeY0qXw@mail.gmail.com> <c359a8a6-8221-4d83-a945-580039042056@arm.com>
In-Reply-To: <c359a8a6-8221-4d83-a945-580039042056@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 27 Nov 2023 23:28:49 +1300
Message-ID: <CAGsJ_4zbB5QHu=x9U2-QNFi7SPJkw0hTE+jQoLPcq2rCMC9ArA@mail.gmail.com>
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

On Mon, Nov 27, 2023 at 11:11=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 27/11/2023 09:59, Barry Song wrote:
> > On Mon, Nov 27, 2023 at 10:35=E2=80=AFPM Ryan Roberts <ryan.roberts@arm=
.com> wrote:
> >>
> >> On 27/11/2023 08:42, Barry Song wrote:
> >>>>> +           for (i =3D 0; i < nr; i++, page++) {
> >>>>> +                   if (anon) {
> >>>>> +                           /*
> >>>>> +                            * If this page may have been pinned by=
 the
> >>>>> +                            * parent process, copy the page immedi=
ately for
> >>>>> +                            * the child so that we'll always guara=
ntee the
> >>>>> +                            * pinned page won't be randomly replac=
ed in the
> >>>>> +                            * future.
> >>>>> +                            */
> >>>>> +                           if (unlikely(page_try_dup_anon_rmap(
> >>>>> +                                           page, false, src_vma)))=
 {
> >>>>> +                                   if (i !=3D 0)
> >>>>> +                                           break;
> >>>>> +                                   /* Page may be pinned, we have =
to copy. */
> >>>>> +                                   return copy_present_page(
> >>>>> +                                           dst_vma, src_vma, dst_p=
te,
> >>>>> +                                           src_pte, addr, rss, pre=
alloc,
> >>>>> +                                           page);
> >>>>> +                           }
> >>>>> +                           rss[MM_ANONPAGES]++;
> >>>>> +                           VM_BUG_ON(PageAnonExclusive(page));
> >>>>> +                   } else {
> >>>>> +                           page_dup_file_rmap(page, false);
> >>>>> +                           rss[mm_counter_file(page)]++;
> >>>>> +                   }
> >>>>>             }
> >>>>> -           rss[MM_ANONPAGES]++;
> >>>>> -   } else if (page) {
> >>>>> -           folio_get(folio);
> >>>>> -           page_dup_file_rmap(page, false);
> >>>>> -           rss[mm_counter_file(page)]++;
> >>>>> +
> >>>>> +           nr =3D i;
> >>>>> +           folio_ref_add(folio, nr);
> >>>>
> >>>> You're changing the order of mapcount vs. refcount increment. Don't.
> >>>> Make sure your refcount >=3D mapcount.
> >>>>
> >>>> You can do that easily by doing the folio_ref_add(folio, nr) first a=
nd
> >>>> then decrementing in case of error accordingly. Errors due to pinned
> >>>> pages are the corner case.
> >>>>
> >>>> I'll note that it will make a lot of sense to have batch variants of
> >>>> page_try_dup_anon_rmap() and page_dup_file_rmap().
> >>>>
> >>>
> >>> i still don't understand why it is not a entire map+1, but an increme=
nt
> >>> in each basepage.
> >>
> >> Because we are PTE-mapping the folio, we have to account each individu=
al page.
> >> If we accounted the entire folio, where would we unaccount it? Each pa=
ge can be
> >> unmapped individually (e.g. munmap() part of the folio) so need to acc=
ount each
> >> page. When PMD mapping, the whole thing is either mapped or unmapped, =
and its
> >> atomic, so we can account the entire thing.
> >
> > Hi Ryan,
> >
> > There is no problem. for example, a large folio is entirely mapped in
> > process A with CONPTE,
> > and only page2 is mapped in process B.
> > then we will have
> >
> > entire_map =3D 0
> > page0.map =3D -1
> > page1.map =3D -1
> > page2.map =3D 0
> > page3.map =3D -1
> > ....
> >
> >>
> >>>
> >>> as long as it is a CONTPTE large folio, there is no much difference w=
ith
> >>> PMD-mapped large folio. it has all the chance to be DoubleMap and nee=
d
> >>> split.
> >>>
> >>> When A and B share a CONTPTE large folio, we do madvise(DONTNEED) or =
any
> >>> similar things on a part of the large folio in process A,
> >>>
> >>> this large folio will have partially mapped subpage in A (all CONTPE =
bits
> >>> in all subpages need to be removed though we only unmap a part of the
> >>> large folioas HW requires consistent CONTPTEs); and it has entire map=
 in
> >>> process B(all PTEs are still CONPTES in process B).
> >>>
> >>> isn't it more sensible for this large folios to have entire_map =3D 0=
(for
> >>> process B), and subpages which are still mapped in process A has map_=
count
> >>> =3D0? (start from -1).
> >>>
> >>>> Especially, the batch variant of page_try_dup_anon_rmap() would only
> >>>> check once if the folio maybe pinned, and in that case, you can simp=
ly
> >>>> drop all references again. So you either have all or no ptes to proc=
ess,
> >>>> which makes that code easier.
> >>
> >> I'm afraid this doesn't make sense to me. Perhaps I've misunderstood. =
But
> >> fundamentally you can only use entire_mapcount if its only possible to=
 map and
> >> unmap the whole folio atomically.
> >
> >
> >
> > My point is that CONTPEs should either all-set in all 16 PTEs or all ar=
e dropped
> > in 16 PTEs. if all PTEs have CONT, it is entirely mapped; otherwise,
> > it is partially
> > mapped. if a large folio is mapped in one processes with all CONTPTEs
> > and meanwhile in another process with partial mapping(w/o CONTPTE), it =
is
> > DoubleMapped.
>
> There are 2 problems with your proposal, as I see it;
>
> 1) the core-mm is not enlightened for CONTPTE mappings. As far as it is
> concerned, its just mapping a bunch of PTEs. So it has no hook to inc/dec
> entire_mapcount. The arch code is opportunistically and *transparently* m=
anaging
> the CONT_PTE bit.
>
> 2) There is nothing to say a folio isn't *bigger* than the contpte block;=
 it may
> be 128K and be mapped with 2 contpte blocks. Or even a PTE-mapped THP (2M=
) and
> be mapped with 32 contpte blocks. So you can't say it is entirely mapped
> unless/until ALL of those blocks are set up. And then of course each bloc=
k could
> be unmapped unatomically.
>
> For the PMD case there are actually 2 properties that allow using the
> entire_mapcount optimization; It's atomically mapped/unmapped through the=
 PMD
> and we know that the folio is exactly PMD sized (since it must be at leas=
t PMD
> sized to be able to map it with the PMD, and we don't allocate THPs any b=
igger
> than PMD size). So one PMD map or unmap operation corresponds to exactly =
one
> *entire* map or unmap. That is not true when we are PTE mapping.

well. Thanks for clarification. based on the above description, i agree the
current code might make more sense by always using mapcount in subpage.

I gave my proposals as  I thought we were always CONTPTE size for small-THP
then we could drop the loop to iterate 16 times rmap. if we do it
entirely, we only
need to do dup rmap once for all 16 PTEs by increasing entire_map.

BTW, I have concerns that a variable small-THP size will really work
as userspace
is probably friendly to only one fixed size. for example, userspace
heap management
might be optimized to a size for freeing memory to the kernel. it is
very difficult
for the heap to adapt to various sizes at the same time. frequent unmap/fre=
e
size not equal with, and particularly smaller than small-THP size will
defeat all
efforts to use small-THP.

>
> >
> > Since we always hold ptl to set or drop CONTPTE bits, set/drop is
> > still atomic in a
> > spinlock area.
> >
> >>
> >>>>
> >>>> But that can be added on top, and I'll happily do that.
> >>>>
> >>>> --
> >>>> Cheers,
> >>>>
> >>>> David / dhildenb
> >>>
> >

Thanks
Barry
