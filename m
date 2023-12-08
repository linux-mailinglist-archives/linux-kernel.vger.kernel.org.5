Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9228096DA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjLHAAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHAAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:00:23 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A3C1716
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:00:28 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-464754e1120so482766137.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701993627; x=1702598427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlnJWHSSLeyHnhaU7JOqxzY1KDfAFZV5s1/3N5/ws/o=;
        b=GKJM0KjK/a0EsPLTbet3bXg3ISMRpAGWai95mjBgFFbN7JGuh0CyoudKjPiiQ5GpRj
         9P7St0QDyH6PnS+gP5sTURGJvfhYcRL31UVbz9E6pQofNT4YUlchDhm+B+FzPwMECpnA
         ijiz09mQCRMAgAFtI9vWiYCB9K9XXriz+Dyxl33Bsy/+rv8Skdax6Bmw/4I7aLAf65gG
         N4X2RXC+SwlFBgxUi6ojc1y84sOFIfLylqj+n2GDw1n1vksB9YtuUbFSyU0ua/fvmgfu
         0gPlhRnP72zzi3Xz7EkN8czs5dK+qrfviOFE/VKVvqEVmFNg25iQo/MJEm3mP8cTPLfw
         39cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701993627; x=1702598427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlnJWHSSLeyHnhaU7JOqxzY1KDfAFZV5s1/3N5/ws/o=;
        b=lV8M56bzMbMrHLUDsD/0w73+las4KV0NQQGXp1NAH3Ns1HbisrGR2Fek0adQeOILMA
         piBuFdRHWLAPuTrNWwVJv+CRyzHGB4sCTNrxdhgXq+LgCFddp8aoKEF/0DG/r8kdlZuu
         30Ngfr5svyF+86ogZN8vmeIU5JtfV/pEj4a/RnkrYZku9TxKIIXBetrEXAdQkEwhuaPo
         wMOkoZuxZRMuGmGX727q3JoMF9eNpP2R1CkC3x5DOAP37R90F79C0R0Igay1AfIH2IIQ
         1Wo/5ygVCYmSxJWBy0RkDjEYT7nn0jn6hktqMYamaE4SaxFQ5LBRbN2t1vpO8xznM0Jx
         2t7Q==
X-Gm-Message-State: AOJu0YyomOIAFtbT5UpwTc9fZgXAP61YMAFXdIeUnlg5LzE17iAtxde5
        UFZ3At5nHuhrtJ91j25wtq04iGGATkw9DjVDrD0=
X-Google-Smtp-Source: AGHT+IFvFhu/aXaxifAYsgST4W9l6OWnNSKj54mm6ebeXA9gjRJixSzvRtn4LJyuW5YOo6Iyt4DGPoombQoJx1G28Kg=
X-Received: by 2002:a05:6102:5489:b0:464:44e0:8f9 with SMTP id
 bk9-20020a056102548900b0046444e008f9mr4223136vsb.35.1701993627086; Thu, 07
 Dec 2023 16:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20231114014313.67232-1-v-songbaohua@oppo.com> <CAGsJ_4wsWzhosZJWegOb8ggoON3KdiH1mO-8mFZd7kWcn6diuw@mail.gmail.com>
 <CAGsJ_4w4VgpO02YUVEn4pbKThg+SszD_bDpBGbKC9d2G90MpGA@mail.gmail.com>
 <8c7f1a2f-57d2-4f20-abb2-394c7980008e@redhat.com> <CAGsJ_4zqAehJSY9aAQEKkp9+JvuxtJuF1c7OBCxmaG8ZeEze_Q@mail.gmail.com>
 <e1e6dba5-8702-457e-b149-30b2e43156cf@redhat.com> <fb34d312-1049-4932-8f2b-d7f33cfc297c@arm.com>
 <CAGsJ_4zNOCa-bLkBdGXmOAGSZkJQZ0dTe-YWBubkdHmOyOimWg@mail.gmail.com>
 <5de66ff5-b6c8-4ffc-acd9-59aec4604ca4@redhat.com> <bab848b8-edd3-4c57-9a96-f17a33e030d0@arm.com>
 <71c4b8b2-512a-4e50-9160-6ee77a5ec0a4@arm.com> <CAGsJ_4yoYowJLm+cC8i-HujLcNJKGut+G-NnjRhg2eGkYvXz8Q@mail.gmail.com>
 <679a144a-db47-4d05-bbf7-b6a0514f5ed0@arm.com> <c5c82611-3153-4d56-b799-a1df3c953efe@redhat.com>
 <8aa8f095-1840-4a2e-ad06-3f375282ab6a@arm.com> <7065bbd3-64b3-4cd6-a2cd-146c556aac66@redhat.com>
 <CAGsJ_4xR9HsXU-Sib6LF_KRJHpU38g8Xu33HGgogPAVbb=BKbg@mail.gmail.com> <1dcd6985-aa29-4df7-a7cb-ef57ae658861@redhat.com>
In-Reply-To: <1dcd6985-aa29-4df7-a7cb-ef57ae658861@redhat.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 8 Dec 2023 13:00:15 +1300
Message-ID: <CAGsJ_4zLhmOPwjwuC4Sk=ZkWdxvpDsU5gE6PfWoxXH3WBwB_hQ@mail.gmail.com>
Subject: Re: [RFC V3 PATCH] arm64: mm: swap: save and restore mte tags for
 large folios
To:     David Hildenbrand <david@redhat.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Steven Price <steven.price@arm.com>, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        shy828301@gmail.com, v-songbaohua@oppo.com,
        wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org,
        ying.huang@intel.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 11:04=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> >>
> >>> not per-folio? I'm also not sure what it buys us - instead of reading=
 a per-page
> >>> flag we now have to read 128 bytes of tag for each page and check its=
 zero.
> >>
> >> My point is, if that is the corner case, we might not care about that.
> >
> > Hi David,
>
> Hi!
>
> > my understanding is that this is NOT a corner. Alternatively, it is
> > really a common case.
>
> If it happens with < 1% of all large folios on swapout/swapin, it's not
> the common case. Even if some scenarios you point out below can and will
> happen.
>

Fair enough. If we define "corner case" based on the percentage of those fo=
lios
which can get partial MTE tags set or get partial MTE tags invalidated, I a=
gree
this is a corner case. I thought  that a corner case was a case which
could rarely
happen.

> >
> > 1. a large folio can be partially unmapped when it is in swapche and
> > after it is swapped out
> > in all cases, its tags can be partially invalidated. I don't think
> > this is a corner case, as long
> > as userspaces are still working at the granularity of basepages, this
> > is always going to
> > happen. For example, userspace libc such as jemalloc can identify
> > PAGESIZE, and use
> > madvise(DONTNEED) to return memory to the kernel. Heap management is
> > still working
> > at the granularity of the basepage.
> >
> > 2. mprotect on a part of a large folio as Steven pointed out.
> >
> > 3.long term, we are working to swap-in large folios as a whole[1] just
> > like swapping out large
> > folios as a whole. for those ptes which are still contiguous swap
> > entries, i mean, which
> > are not unmapped by userspace after the large folios are swapped out
> > to swap devices,
> > we have a chance to swap in a whole large folio, we do have a chance
> > to restore tags
> > for the large folio without early-exit. but we still have a good
> > chance to fall back to base
> > page if we fail to allocate large folio, in this case, do_swap_page()
> > still works at the
> > granularity of basepage. and do_swap_page() will call swap_free(entry),=
  tags of
> >
> > this particular page can be invalidated as a result.
>
> I don't immediately see how that relates. You get a fresh small folio
> and simply load that tag from the internal datastructure. No messing
> with large folios required, because you don't have a large folio. So no
> considerations about large folio batch MTE tag restore apply.

right. I was thinking the original large folio was partially
swapped-in and forgot
the new allocated page was actually one folio with only one page :-)

Indeed, in that case, it is still restoring the MTE tag for the whole
folio with one
page.

>
> >
> > 4. too many early-exit might be negative to performance.
> >
> >
> > So I am thinking that in the future, we need two helpers,
> > 1. void __arch_swap_restore(swp_entry_t entry, struct page *page);
> > this is always needed to support page-level tag restore.
> >
> > 2.  void arch_swap_restore(swp_entry_t entry, struct folio *folio);
> > this can be a helper when we are able to swap in a whole folio. two
> > conditions must be met
> > (a). PTEs entries are still contiguous swap entries just as when large
> > folios were swapped
> > out.
> > (b). we succeed in the allocation of a large folio in do_swap_page.
> >
> > For this moment, we only need 1; we will add 2 in swap-in large folio s=
eries.
> >
> > What do you think?
>
> I agree that it's better to keep it simple for now.
>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry
