Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CBE7F6A2D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 02:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjKXBfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 20:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjKXBfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 20:35:15 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53405120
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:35:18 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-462abe45730so468623137.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700789717; x=1701394517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wG1ZuaRbCPBv0+UAInoHXoinm1O34IZTOsjDEN9VpmI=;
        b=QMSR8lQJx9JiF0xfBZa7967dAX79xgMp4S2U7UXvAIAqswkXRtGuCyFoj8XJNo9Ftd
         EKcZ9DFkcs6pgWge8qjAIsmh6cdzBus3qM60Bqkb07+jSY/hSbwA1eAXQjBPg17iUAXe
         Uzvg7XukKhLa/qcwG0bJjY3lk9GzgfjhGKK1hj/DuhoXe/4IPDQULqDWwRP0v7LEQtVv
         DfeFwmT9d8YHDTEZwQVU8tlXvFvNWxn3FFESAC0p0zf2YtSqXwsi36q4Dkc4AJxnwIS2
         AugDTS8mNNr/qc6bkVgDZ6gnouP+1LOrLbiJg2kncGP6eCF9UDd+T/cZZ93IrgHjMkAs
         ysxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700789717; x=1701394517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wG1ZuaRbCPBv0+UAInoHXoinm1O34IZTOsjDEN9VpmI=;
        b=Kb5vTKCvrMi/satvFXh2dF0GEVNhDPXuz0RqmbdLTXVt+SUmERtYc8Z1VTiMzG7mV4
         LGEk44loByyzJSZom0UzOybu3TEwl2YqUcZ2eDka+pgDXbH3AK4mV6TwfxS9htgptVJf
         qV6Z5HjSTw/G9lmiWROMznq/ouMQBWWVGCA6deBhvpxn8wRq+ELBk1Z1U/q2UUkTW0NM
         tQkVAwcOzHx29jnFduNkW7AWCsGY5FZo16a7JyUfwb0uu19ftOAjBLKNpL/6NEA8QRuV
         y4+Zme8tAzLtb8naKUfw7zIS2JGAPt3h+zNRdhxjdTn95tEIr7c4JVdhyGYyaU8FZuvS
         Rkgw==
X-Gm-Message-State: AOJu0YxjvHxTSaKTTilf/1fjgvKOnUkGcwf42YT9Aqx11r8bXOhY37M9
        nKGoCYI6L0UwAz8EQEcOErjGnYWuixARLbfBRnk=
X-Google-Smtp-Source: AGHT+IFrFnFyALVSXBM657DQOsFzWG1PiI+L20o9Ck02MKBjcqSeZVZiCVh2b4opqse0rECIInlYosUnm8ldmV4dA2U=
X-Received: by 2002:a67:eb0b:0:b0:45e:8fd7:1ae0 with SMTP id
 a11-20020a67eb0b000000b0045e8fd71ae0mr1093082vso.8.1700789717296; Thu, 23 Nov
 2023 17:35:17 -0800 (PST)
MIME-Version: 1.0
References: <20231114014313.67232-1-v-songbaohua@oppo.com> <d8fd421e-00f3-453e-9665-df3fdcc239eb@redhat.com>
 <CAGsJ_4wD9Ug=CLi6Cdw3Ve5q8-1u7MmipLtEGQTfWmU9BJFJOQ@mail.gmail.com>
 <864489b3-5d85-4145-b5bb-5d8a74b9b92d@redhat.com> <CAGsJ_4wsWzhosZJWegOb8ggoON3KdiH1mO-8mFZd7kWcn6diuw@mail.gmail.com>
 <CAGsJ_4w4VgpO02YUVEn4pbKThg+SszD_bDpBGbKC9d2G90MpGA@mail.gmail.com>
 <8c7f1a2f-57d2-4f20-abb2-394c7980008e@redhat.com> <CAGsJ_4zqAehJSY9aAQEKkp9+JvuxtJuF1c7OBCxmaG8ZeEze_Q@mail.gmail.com>
 <e1e6dba5-8702-457e-b149-30b2e43156cf@redhat.com> <fb34d312-1049-4932-8f2b-d7f33cfc297c@arm.com>
In-Reply-To: <fb34d312-1049-4932-8f2b-d7f33cfc297c@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 24 Nov 2023 14:35:06 +1300
Message-ID: <CAGsJ_4zNOCa-bLkBdGXmOAGSZkJQZ0dTe-YWBubkdHmOyOimWg@mail.gmail.com>
Subject: Re: [RFC V3 PATCH] arm64: mm: swap: save and restore mte tags for
 large folios
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     David Hildenbrand <david@redhat.com>, steven.price@arm.com,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        will@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@suse.com, shy828301@gmail.com, v-songbaohua@oppo.com,
        wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org,
        ying.huang@intel.com, yuzhao@google.com
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

On Mon, Nov 20, 2023 at 11:57=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 20/11/2023 09:11, David Hildenbrand wrote:
> > On 17.11.23 19:41, Barry Song wrote:
> >> On Fri, Nov 17, 2023 at 7:28=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>>
> >>> On 17.11.23 01:15, Barry Song wrote:
> >>>> On Fri, Nov 17, 2023 at 7:47=E2=80=AFAM Barry Song <21cnbao@gmail.co=
m> wrote:
> >>>>>
> >>>>> On Thu, Nov 16, 2023 at 5:36=E2=80=AFPM David Hildenbrand <david@re=
dhat.com> wrote:
> >>>>>>
> >>>>>> On 15.11.23 21:49, Barry Song wrote:
> >>>>>>> On Wed, Nov 15, 2023 at 11:16=E2=80=AFPM David Hildenbrand <david=
@redhat.com> wrote:
> >>>>>>>>
> >>>>>>>> On 14.11.23 02:43, Barry Song wrote:
> >>>>>>>>> This patch makes MTE tags saving and restoring support large fo=
lios,
> >>>>>>>>> then we don't need to split them into base pages for swapping o=
ut
> >>>>>>>>> on ARM64 SoCs with MTE.
> >>>>>>>>>
> >>>>>>>>> arch_prepare_to_swap() should take folio rather than page as pa=
rameter
> >>>>>>>>> because we support THP swap-out as a whole.
> >>>>>>>>>
> >>>>>>>>> Meanwhile, arch_swap_restore() should use page parameter rather=
 than
> >>>>>>>>> folio as swap-in always works at the granularity of base pages =
right
> >>>>>>>>> now.
> >>>>>>>>
> >>>>>>>> ... but then we always have order-0 folios and can pass a folio,=
 or what
> >>>>>>>> am I missing?
> >>>>>>>
> >>>>>>> Hi David,
> >>>>>>> you missed the discussion here:
> >>>>>>>
> >>>>>>> https://lore.kernel.org/lkml/CAGsJ_4yXjex8txgEGt7+WMKp4uDQTn-fR06=
ijv4Ac68MkhjMDw@mail.gmail.com/
> >>>>>>> https://lore.kernel.org/lkml/CAGsJ_4xmBAcApyK8NgVQeX_Znp5e8D4fbbh=
GguOkNzmh1Veocg@mail.gmail.com/
> >>>>>>
> >>>>>> Okay, so you want to handle the refault-from-swapcache case where =
you get a
> >>>>>> large folio.
> >>>>>>
> >>>>>> I was mislead by your "folio as swap-in always works at the granul=
arity of
> >>>>>> base pages right now" comment.
> >>>>>>
> >>>>>> What you actually wanted to say is "While we always swap in small =
folios, we
> >>>>>> might refault large folios from the swapcache, and we only want to=
 restore
> >>>>>> the tags for the page of the large folio we are faulting on."
> >>>>>>
> >>>>>> But, I do if we can't simply restore the tags for the whole thing =
at once
> >>>>>> at make the interface page-free?
> >>>>>>
> >>>>>> Let me elaborate:
> >>>>>>
> >>>>>> IIRC, if we have a large folio in the swapcache, the swap entries/=
offset are
> >>>>>> contiguous. If you know you are faulting on page[1] of the folio w=
ith a
> >>>>>> given swap offset, you can calculate the swap offset for page[0] s=
imply by
> >>>>>> subtracting from the offset.
> >>>>>>
> >>>>>> See page_swap_entry() on how we perform this calculation.
> >>>>>>
> >>>>>>
> >>>>>> So you can simply pass the large folio and the swap entry correspo=
nding
> >>>>>> to the first page of the large folio, and restore all tags at once=
.
> >>>>>>
> >>>>>> So the interface would be
> >>>>>>
> >>>>>> arch_prepare_to_swap(struct folio *folio);
> >>>>>> void arch_swap_restore(struct page *folio, swp_entry_t start_entry=
);
> >>>>>>
> >>>>>> I'm sorry if that was also already discussed.
> >>>>>
> >>>>> This has been discussed. Steven, Ryan and I all don't think this is=
 a good
> >>>>> option. in case we have a large folio with 16 basepages, as do_swap=
_page
> >>>>> can only map one base page for each page fault, that means we have
> >>>>> to restore 16(tags we restore in each page fault) * 16(the times of=
 page
> >>>>> faults)
> >>>>> for this large folio.
> >>>>>
> >>>>> and still the worst thing is the page fault in the Nth PTE of large=
 folio
> >>>>> might free swap entry as that swap has been in.
> >>>>> do_swap_page()
> >>>>> {
> >>>>>      /*
> >>>>>       * Remove the swap entry and conditionally try to free up the =
swapcache.
> >>>>>       * We're already holding a reference on the page but haven't m=
apped it
> >>>>>       * yet.
> >>>>>       */
> >>>>>       swap_free(entry);
> >>>>> }
> >>>>>
> >>>>> So in the page faults other than N, I mean 0~N-1 and N+1 to 15, you=
 might
> >>>>> access
> >>>>> a freed tag.
> >>>>
> >>>> And David, one more information is that to keep the parameter of
> >>>> arch_swap_restore() unchanged as folio,
> >>>> i actually tried an ugly approach in rfc v2:
> >>>>
> >>>> +void arch_swap_restore(swp_entry_t entry, struct folio *folio)
> >>>> +{
> >>>> + if (system_supports_mte()) {
> >>>> +      /*
> >>>> +       * We don't support large folios swap in as whole yet, but
> >>>> +       * we can hit a large folio which is still in swapcache
> >>>> +       * after those related processes' PTEs have been unmapped
> >>>> +       * but before the swapcache folio  is dropped, in this case,
> >>>> +       * we need to find the exact page which "entry" is mapping
> >>>> +       * to. If we are not hitting swapcache, this folio won't be
> >>>> +       * large
> >>>> +     */
> >>>> + struct page *page =3D folio_file_page(folio, swp_offset(entry));
> >>>> + mte_restore_tags(entry, page);
> >>>> + }
> >>>> +}
> >>>>
> >>>> And obviously everybody in the discussion hated it :-)
> >>>>
> >>>
> >>> I can relate :D
> >>>
> >>>> i feel the only way to keep API unchanged using folio is that we
> >>>> support restoring PTEs
> >>>> all together for the whole large folio and we support the swap-in of
> >>>> large folios. This is
> >>>> in my list to do, I will send a patchset based on Ryan's large anon
> >>>> folios series after a
> >>>> while. till that is really done, it seems using page rather than fol=
io
> >>>> is a better choice.
> >>>
> >>> I think just restoring all tags and remembering for a large folio tha=
t
> >>> they have been restored might be the low hanging fruit. But as always=
,
> >>> devil is in the detail :)
> >>
> >> Hi David,
> >> thanks for all your suggestions though my feeling is this is too compl=
ex and
> >> is not worth it for at least  three reasons.
> >
> > Fair enough.
> >
> >>
> >> 1. In multi-thread and particularly multi-processes, we need some lock=
s to
> >> protect and help know if one process is the first one to restore tags =
and if
> >> someone else is restoring tags when one process wants to restore. ther=
e
> >> is not this kind of fine-grained lock at all.
> >
> > We surely always hold the folio lock on swapin/swapout, no? So when the=
se
> > functions are called.
> >
> > So that might just work already -- unless I am missing something import=
ant.
>
> We already have a page flag that we use to mark the page as having had it=
s mte
> state associated; PG_mte_tagged. This is currently per-page (and IIUC, Ma=
tthew
> has been working to remove as many per-page flags as possible). Couldn't =
we just
> make arch_swap_restore() take a folio, restore the tags for *all* the pag=
es and
> repurpose that flag to be per-folio (so head page only)? It looks like th=
e the
> mte code already manages all the serialization requirements too. Then
> arch_swap_restore() can just exit early if it sees the flag is already se=
t on
> the folio.
>
> One (probably nonsense) concern that just sprung to mind about having MTE=
 work
> with large folios in general; is it possible that user space could cause =
a large
> anon folio to be allocated (THP), then later mark *part* of it to be tagg=
ed with
> MTE? In this case you would need to apply tags to part of the folio only.
> Although I have a vague recollection that any MTE areas have to be marked=
 at
> mmap time and therefore this type of thing is impossible?

right, we might need to consider only a part of folio needs to be
mapped and restored MTE tags.
do_swap_page() can have a chance to hit a large folio but it only
needs to fault-in a page.

A case can be quite simple as below,

1. anon folio shared by process A and B
2. add_to_swap() as a large folio;
3. try to unmap A and B;
4. after A is unmapped(ptes become swap entries), we do a
MADV_DONTNEED on a part of the folio. this can
happen very easily as userspace is still working in 4KB level;
userspace heap management can free an
basepage area by MADV_DONTNEED;
madvise(address, MADV_DONTNEED, 4KB);
5. A refault on address + 8KB, we will hit large folio in
do_swap_page() but we will only need to map
one basepage, we will never need this DONTNEEDed in process A.

another more complicated case can be mprotect and munmap a part of
large folios. since userspace
has no idea of large folios in their mind, they can do all strange
things. are we sure in all cases,
large folios have been splitted into small folios?

>
> Thanks,
> Ryan
>
>
>
> >
> >>
> >> 2. folios are not always large, in many cases, they have just one base=
 page
> >> and there is no tail to remember. and it seems pretty ugly if we turn =
out have
> >> to use different ways to remember restoring state for small folios and
> >> large folios.
> >
> > if (folio_test_large(folio)) {
> >
> > } else {
> >
> > }
> >
> > Easy ;)
> >
> > Seriously, it's not that complicated and/or ugly.
> >
> >>
> >> 3. there is nothing wrong to use page to restore tags since right now =
swap-in
> >> is page. restoring tags and swapping-in become harmonious with each ot=
her
> >> after this patch. I would argue what is really wrong is the current ma=
inline.
> >>
> >> If eventually we are able to do_swap_page() for the whole large folio,=
 we
> >> move to folios for MTE tags as well. These two behaviours make a new
> >> harmonious picture again.
> >>
> >
> > Just making both functions consume folios is much cleaner and also more=
 future
> > proof.
> >
> > Consuming now a page where we used to consume a folio is a step backwar=
ds.
> >
>

Thanks
Barry
