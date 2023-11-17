Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E5B7EEA3E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 01:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbjKQAQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 19:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjKQAQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 19:16:04 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88880EA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 16:16:00 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-4ac023c8f82so538041e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 16:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700180159; x=1700784959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7513Wob2VysaWAdX86UezKQXmf9Eh2SoW7kpL5yRLdA=;
        b=SBTJ5hGGG3zD8IhflwsTuj6BnXj01TyvSIXCtH25fvpLb4/QckbBkjWrpnghO8Li1T
         Hsd0gcRDzxm2xgeUPE+VvgkU8YWbNZgTcaR04zY5tvnoXqhI46WCOeae185BvsElrUUZ
         sP8siHldkFQzhBsx1uJly/beukoFAkR2LtwEQvnYOUlMX/EmvO330nCWiWm/d1So2eDy
         ruzOxXv5kfCfLE2ajQPOdyK25ha4HeMeBHZf265OF0Cq7zJiaYxjtpTmKJCPQUHeP6GQ
         OUPCiSxhON3v3VlMz0PCRJWO/HFGQVB1y0MtkOICrzLsPlBkT6Irr9vad1M9IQoAtXz5
         f9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700180159; x=1700784959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7513Wob2VysaWAdX86UezKQXmf9Eh2SoW7kpL5yRLdA=;
        b=R+Yb6/e0EmVHLmww93lEy7wlKYk1R44upK0EBZLx/qG2PQ+v5nDopzDBDDkNUwOBfw
         fGxPVIw173kAliW5LsoamPFYjedZbdDT+FtzRPz/x1mxx7WA5Qw1m98a1gABYOGTmPZN
         GAs637qltwcB6TLwEOD/PeiNGDq3zdY4CDBA+K2kSO1Hfp5tpBKMwfj2lcC2Eo84Vbbn
         UnNoOOJ51bKQL2RasHZLCuBUxJqIwkoZmH5gzOCeQ883N9J87iRS7G2z5MDtEbFxA6Ai
         STrs/DJOxToxB0QWJTDlOyB54uLwq21HjBSa0NBwIZQ5c0KhANj+VyDhM0Np+KjIxy/v
         Srig==
X-Gm-Message-State: AOJu0Yy/XBC47itZ+cpRfChjiB5RId0cH1G40EjRb3lFii29iEfb/sxj
        hjX2eAjLESDuYTAKK64sJClznPTKdMrh8DNlTKY=
X-Google-Smtp-Source: AGHT+IF36h7M89Z7GqLUSnbnoxhiz8zShmvJBSeuDKk+cRhhYq/gX8udqytxDvOPsaGl4OlJFPlJdXl4w9af9houE18=
X-Received: by 2002:a1f:b204:0:b0:495:c464:a2fe with SMTP id
 b4-20020a1fb204000000b00495c464a2femr15945295vkf.2.1700180159393; Thu, 16 Nov
 2023 16:15:59 -0800 (PST)
MIME-Version: 1.0
References: <20231114014313.67232-1-v-songbaohua@oppo.com> <d8fd421e-00f3-453e-9665-df3fdcc239eb@redhat.com>
 <CAGsJ_4wD9Ug=CLi6Cdw3Ve5q8-1u7MmipLtEGQTfWmU9BJFJOQ@mail.gmail.com>
 <864489b3-5d85-4145-b5bb-5d8a74b9b92d@redhat.com> <CAGsJ_4wsWzhosZJWegOb8ggoON3KdiH1mO-8mFZd7kWcn6diuw@mail.gmail.com>
In-Reply-To: <CAGsJ_4wsWzhosZJWegOb8ggoON3KdiH1mO-8mFZd7kWcn6diuw@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 17 Nov 2023 08:15:48 +0800
Message-ID: <CAGsJ_4w4VgpO02YUVEn4pbKThg+SszD_bDpBGbKC9d2G90MpGA@mail.gmail.com>
Subject: Re: [RFC V3 PATCH] arm64: mm: swap: save and restore mte tags for
 large folios
To:     David Hildenbrand <david@redhat.com>
Cc:     steven.price@arm.com, akpm@linux-foundation.org,
        ryan.roberts@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        shy828301@gmail.com, v-songbaohua@oppo.com,
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

On Fri, Nov 17, 2023 at 7:47=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Thu, Nov 16, 2023 at 5:36=E2=80=AFPM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 15.11.23 21:49, Barry Song wrote:
> > > On Wed, Nov 15, 2023 at 11:16=E2=80=AFPM David Hildenbrand <david@red=
hat.com> wrote:
> > >>
> > >> On 14.11.23 02:43, Barry Song wrote:
> > >>> This patch makes MTE tags saving and restoring support large folios=
,
> > >>> then we don't need to split them into base pages for swapping out
> > >>> on ARM64 SoCs with MTE.
> > >>>
> > >>> arch_prepare_to_swap() should take folio rather than page as parame=
ter
> > >>> because we support THP swap-out as a whole.
> > >>>
> > >>> Meanwhile, arch_swap_restore() should use page parameter rather tha=
n
> > >>> folio as swap-in always works at the granularity of base pages righ=
t
> > >>> now.
> > >>
> > >> ... but then we always have order-0 folios and can pass a folio, or =
what
> > >> am I missing?
> > >
> > > Hi David,
> > > you missed the discussion here:
> > >
> > > https://lore.kernel.org/lkml/CAGsJ_4yXjex8txgEGt7+WMKp4uDQTn-fR06ijv4=
Ac68MkhjMDw@mail.gmail.com/
> > > https://lore.kernel.org/lkml/CAGsJ_4xmBAcApyK8NgVQeX_Znp5e8D4fbbhGguO=
kNzmh1Veocg@mail.gmail.com/
> >
> > Okay, so you want to handle the refault-from-swapcache case where you g=
et a
> > large folio.
> >
> > I was mislead by your "folio as swap-in always works at the granularity=
 of
> > base pages right now" comment.
> >
> > What you actually wanted to say is "While we always swap in small folio=
s, we
> > might refault large folios from the swapcache, and we only want to rest=
ore
> > the tags for the page of the large folio we are faulting on."
> >
> > But, I do if we can't simply restore the tags for the whole thing at on=
ce
> > at make the interface page-free?
> >
> > Let me elaborate:
> >
> > IIRC, if we have a large folio in the swapcache, the swap entries/offse=
t are
> > contiguous. If you know you are faulting on page[1] of the folio with a
> > given swap offset, you can calculate the swap offset for page[0] simply=
 by
> > subtracting from the offset.
> >
> > See page_swap_entry() on how we perform this calculation.
> >
> >
> > So you can simply pass the large folio and the swap entry corresponding
> > to the first page of the large folio, and restore all tags at once.
> >
> > So the interface would be
> >
> > arch_prepare_to_swap(struct folio *folio);
> > void arch_swap_restore(struct page *folio, swp_entry_t start_entry);
> >
> > I'm sorry if that was also already discussed.
>
> This has been discussed. Steven, Ryan and I all don't think this is a goo=
d
> option. in case we have a large folio with 16 basepages, as do_swap_page
> can only map one base page for each page fault, that means we have
> to restore 16(tags we restore in each page fault) * 16(the times of page =
faults)
> for this large folio.
>
> and still the worst thing is the page fault in the Nth PTE of large folio
> might free swap entry as that swap has been in.
> do_swap_page()
> {
>    /*
>     * Remove the swap entry and conditionally try to free up the swapcach=
e.
>     * We're already holding a reference on the page but haven't mapped it
>     * yet.
>     */
>     swap_free(entry);
> }
>
> So in the page faults other than N, I mean 0~N-1 and N+1 to 15, you might=
 access
> a freed tag.

And David, one more information is that to keep the parameter of
arch_swap_restore() unchanged as folio,
i actually tried an ugly approach in rfc v2:

+void arch_swap_restore(swp_entry_t entry, struct folio *folio)
+{
+ if (system_supports_mte()) {
+      /*
+       * We don't support large folios swap in as whole yet, but
+       * we can hit a large folio which is still in swapcache
+       * after those related processes' PTEs have been unmapped
+       * but before the swapcache folio  is dropped, in this case,
+       * we need to find the exact page which "entry" is mapping
+       * to. If we are not hitting swapcache, this folio won't be
+       * large
+     */
+ struct page *page =3D folio_file_page(folio, swp_offset(entry));
+ mte_restore_tags(entry, page);
+ }
+}

And obviously everybody in the discussion hated it :-)

i feel the only way to keep API unchanged using folio is that we
support restoring PTEs
all together for the whole large folio and we support the swap-in of
large folios. This is
in my list to do, I will send a patchset based on Ryan's large anon
folios series after a
while. till that is really done, it seems using page rather than folio
is a better choice.

>
> >
> > BUT, IIRC in the context of
> >
> > commit cfeed8ffe55b37fa10286aaaa1369da00cb88440
> > Author: David Hildenbrand <david@redhat.com>
> > Date:   Mon Aug 21 18:08:46 2023 +0200
> >
> >      mm/swap: stop using page->private on tail pages for THP_SWAP
> >
> >      Patch series "mm/swap: stop using page->private on tail pages for =
THP_SWAP
> >      + cleanups".
> >
> >      This series stops using page->private on tail pages for THP_SWAP, =
replaces
> >      folio->private by folio->swap for swapcache folios, and starts usi=
ng
> >      "new_folio" for tail pages that we are splitting to remove the usa=
ge of
> >      page->private for swapcache handling completely.
> >
> > As long as the folio is in the swapcache, we even do have the proper
> > swp_entry_t start_entry available as folio_swap_entry(folio).
> >
> > But now I am confused when we actually would have to pass
> > "swp_entry_t start_entry". We shouldn't if the folio is in the swapcach=
e ...
> >
>
> Nop, hitting swapcache doesn't necessarily mean tags have been restored.
> when A forks B,C,D,E,F. and A, B, C, D, E ,F share the swapslot.
> as we have two chances to hit swapcache:
> 1. swap out, unmap has been done but folios haven't been dropped
> 2. swap in, shared processes allocate folios and add to swapcache
>
> for 2, If A gets fault earlier than B, A will allocate folio and add
> it to swapcache.
> Then B will hit the swapcache. But If B's CPU is faster than A, B still m=
ight
> be the one mapping PTE earlier than A though A is the one which has
> added the page to swapcache. we have to make sure MTE is there when
> mapping is done.
>
> > --
> > Cheers,
> >
> > David / dhildenb

Thanks
Barry
