Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D392D7EF785
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 19:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjKQSll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 13:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQSlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 13:41:40 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF52593
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 10:41:36 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7bb3e55c120so827053241.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 10:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700246496; x=1700851296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxkQtyANA6jEMk/z4doQOumnQ7XYlHV3YMgX4dWRIZY=;
        b=bCHmHnqscHA62bzbyXQdcC5cY2hi4J7w1/JA//lVVRyUbVNW6EW56OYBM8KFXKpwlW
         bGK3m3Qn2ThH/6eSb/xyfljNzlMerx0Mn5YSCe/6tRo4Z0o0kHwp2ykNHTPHxX7Zo4KX
         cxUp6sceymJu8xni97BYA2UFgSAcnNKKJ6HvpkVJumUqrIfg8p8YDH8jOoDpv/KFVP3g
         Mf3YY+eeE+zq9Vw8R5mokWXlkFxIx2FvaLKPH/51R238XN6ajQtkO76Zcnnh3ItleI60
         FpsKGnNg6yaT1XGomwf4rfpPf3D+Rw6gDMKYp2wtx5LxMoxxbr511Jyhcg62ZvRCzaph
         UMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700246496; x=1700851296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxkQtyANA6jEMk/z4doQOumnQ7XYlHV3YMgX4dWRIZY=;
        b=ZYPPbAWWbw+PsNKeq5o7zZ58oQqwSRxA7LWaUzb5wAK+lvrZmp9Xyu0Lqj2ok3vKos
         DOQ1Ts1CmA0dHLUBBYtRtJ76ISOKJbz/vq/8wCjJURZ6n9wkBgf1jX8/tKDGeXnqZqza
         19uMq/7uf37fFIwQQfQb2XNRR3Ny/vifVWiTXNOHjyj/FwbF5EZ+AfnmAywa0bgaUMDi
         H9LmCfkcWqg5PQrofOgw44h+dOyT9w5KiCEYZI6qyDrT+apNAZF4FOUpIg3MBSTXyG/l
         NZWAAM/yqg818jQZdhzFv+wxuqedkKDLTiElr3Y50NuzLOapDRb0fHVH8yOdJxOePt4z
         zphg==
X-Gm-Message-State: AOJu0YzyYQdgNkCrK2PNjhBWZZoMtCu8xU8BDf84UzFr4e5mWIvtmlSc
        aqnTwCF3SW4qOtfNWORtQm/U2svjcb8T+22IgVU=
X-Google-Smtp-Source: AGHT+IE71nMn1BTfvDu89B2Auj7yAh6uPj2dZw/e4xI95okTO3dQsH5oMDqy618Fd/sVOwntoZekMu/D2qr5DD0whGg=
X-Received: by 2002:a05:6102:3441:b0:45d:aa3e:a78 with SMTP id
 o1-20020a056102344100b0045daa3e0a78mr270518vsj.10.1700246495545; Fri, 17 Nov
 2023 10:41:35 -0800 (PST)
MIME-Version: 1.0
References: <20231114014313.67232-1-v-songbaohua@oppo.com> <d8fd421e-00f3-453e-9665-df3fdcc239eb@redhat.com>
 <CAGsJ_4wD9Ug=CLi6Cdw3Ve5q8-1u7MmipLtEGQTfWmU9BJFJOQ@mail.gmail.com>
 <864489b3-5d85-4145-b5bb-5d8a74b9b92d@redhat.com> <CAGsJ_4wsWzhosZJWegOb8ggoON3KdiH1mO-8mFZd7kWcn6diuw@mail.gmail.com>
 <CAGsJ_4w4VgpO02YUVEn4pbKThg+SszD_bDpBGbKC9d2G90MpGA@mail.gmail.com> <8c7f1a2f-57d2-4f20-abb2-394c7980008e@redhat.com>
In-Reply-To: <8c7f1a2f-57d2-4f20-abb2-394c7980008e@redhat.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sat, 18 Nov 2023 02:41:23 +0800
Message-ID: <CAGsJ_4zqAehJSY9aAQEKkp9+JvuxtJuF1c7OBCxmaG8ZeEze_Q@mail.gmail.com>
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

On Fri, Nov 17, 2023 at 7:28=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 17.11.23 01:15, Barry Song wrote:
> > On Fri, Nov 17, 2023 at 7:47=E2=80=AFAM Barry Song <21cnbao@gmail.com> =
wrote:
> >>
> >> On Thu, Nov 16, 2023 at 5:36=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>>
> >>> On 15.11.23 21:49, Barry Song wrote:
> >>>> On Wed, Nov 15, 2023 at 11:16=E2=80=AFPM David Hildenbrand <david@re=
dhat.com> wrote:
> >>>>>
> >>>>> On 14.11.23 02:43, Barry Song wrote:
> >>>>>> This patch makes MTE tags saving and restoring support large folio=
s,
> >>>>>> then we don't need to split them into base pages for swapping out
> >>>>>> on ARM64 SoCs with MTE.
> >>>>>>
> >>>>>> arch_prepare_to_swap() should take folio rather than page as param=
eter
> >>>>>> because we support THP swap-out as a whole.
> >>>>>>
> >>>>>> Meanwhile, arch_swap_restore() should use page parameter rather th=
an
> >>>>>> folio as swap-in always works at the granularity of base pages rig=
ht
> >>>>>> now.
> >>>>>
> >>>>> ... but then we always have order-0 folios and can pass a folio, or=
 what
> >>>>> am I missing?
> >>>>
> >>>> Hi David,
> >>>> you missed the discussion here:
> >>>>
> >>>> https://lore.kernel.org/lkml/CAGsJ_4yXjex8txgEGt7+WMKp4uDQTn-fR06ijv=
4Ac68MkhjMDw@mail.gmail.com/
> >>>> https://lore.kernel.org/lkml/CAGsJ_4xmBAcApyK8NgVQeX_Znp5e8D4fbbhGgu=
OkNzmh1Veocg@mail.gmail.com/
> >>>
> >>> Okay, so you want to handle the refault-from-swapcache case where you=
 get a
> >>> large folio.
> >>>
> >>> I was mislead by your "folio as swap-in always works at the granulari=
ty of
> >>> base pages right now" comment.
> >>>
> >>> What you actually wanted to say is "While we always swap in small fol=
ios, we
> >>> might refault large folios from the swapcache, and we only want to re=
store
> >>> the tags for the page of the large folio we are faulting on."
> >>>
> >>> But, I do if we can't simply restore the tags for the whole thing at =
once
> >>> at make the interface page-free?
> >>>
> >>> Let me elaborate:
> >>>
> >>> IIRC, if we have a large folio in the swapcache, the swap entries/off=
set are
> >>> contiguous. If you know you are faulting on page[1] of the folio with=
 a
> >>> given swap offset, you can calculate the swap offset for page[0] simp=
ly by
> >>> subtracting from the offset.
> >>>
> >>> See page_swap_entry() on how we perform this calculation.
> >>>
> >>>
> >>> So you can simply pass the large folio and the swap entry correspondi=
ng
> >>> to the first page of the large folio, and restore all tags at once.
> >>>
> >>> So the interface would be
> >>>
> >>> arch_prepare_to_swap(struct folio *folio);
> >>> void arch_swap_restore(struct page *folio, swp_entry_t start_entry);
> >>>
> >>> I'm sorry if that was also already discussed.
> >>
> >> This has been discussed. Steven, Ryan and I all don't think this is a =
good
> >> option. in case we have a large folio with 16 basepages, as do_swap_pa=
ge
> >> can only map one base page for each page fault, that means we have
> >> to restore 16(tags we restore in each page fault) * 16(the times of pa=
ge faults)
> >> for this large folio.
> >>
> >> and still the worst thing is the page fault in the Nth PTE of large fo=
lio
> >> might free swap entry as that swap has been in.
> >> do_swap_page()
> >> {
> >>     /*
> >>      * Remove the swap entry and conditionally try to free up the swap=
cache.
> >>      * We're already holding a reference on the page but haven't mappe=
d it
> >>      * yet.
> >>      */
> >>      swap_free(entry);
> >> }
> >>
> >> So in the page faults other than N, I mean 0~N-1 and N+1 to 15, you mi=
ght access
> >> a freed tag.
> >
> > And David, one more information is that to keep the parameter of
> > arch_swap_restore() unchanged as folio,
> > i actually tried an ugly approach in rfc v2:
> >
> > +void arch_swap_restore(swp_entry_t entry, struct folio *folio)
> > +{
> > + if (system_supports_mte()) {
> > +      /*
> > +       * We don't support large folios swap in as whole yet, but
> > +       * we can hit a large folio which is still in swapcache
> > +       * after those related processes' PTEs have been unmapped
> > +       * but before the swapcache folio  is dropped, in this case,
> > +       * we need to find the exact page which "entry" is mapping
> > +       * to. If we are not hitting swapcache, this folio won't be
> > +       * large
> > +     */
> > + struct page *page =3D folio_file_page(folio, swp_offset(entry));
> > + mte_restore_tags(entry, page);
> > + }
> > +}
> >
> > And obviously everybody in the discussion hated it :-)
> >
>
> I can relate :D
>
> > i feel the only way to keep API unchanged using folio is that we
> > support restoring PTEs
> > all together for the whole large folio and we support the swap-in of
> > large folios. This is
> > in my list to do, I will send a patchset based on Ryan's large anon
> > folios series after a
> > while. till that is really done, it seems using page rather than folio
> > is a better choice.
>
> I think just restoring all tags and remembering for a large folio that
> they have been restored might be the low hanging fruit. But as always,
> devil is in the detail :)

Hi David,
thanks for all your suggestions though my feeling is this is too complex an=
d
is not worth it for at least  three reasons.

1. In multi-thread and particularly multi-processes, we need some locks to
protect and help know if one process is the first one to restore tags and i=
f
someone else is restoring tags when one process wants to restore. there
is not this kind of fine-grained lock at all.

2. folios are not always large, in many cases, they have just one base page
and there is no tail to remember. and it seems pretty ugly if we turn out h=
ave
to use different ways to remember restoring state for small folios and
large folios.

3. there is nothing wrong to use page to restore tags since right now swap-=
in
is page. restoring tags and swapping-in become harmonious with each other
after this patch. I would argue what is really wrong is the current mainlin=
e.

If eventually we are able to do_swap_page() for the whole large folio, we
move to folios for MTE tags as well. These two behaviours make a new
harmonious picture again.

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry
