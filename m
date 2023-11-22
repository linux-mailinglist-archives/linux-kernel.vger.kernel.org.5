Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDF97F4E77
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbjKVRdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjKVRds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:33:48 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAE11B1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:33:38 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c5056059e0so246031fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700674416; x=1701279216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UoCjknw8mm8pTdU3G2BJeKy6q863gsbJT26LTMpWUGM=;
        b=dxEyWzULSC/i1nZUhLW9VR7QRcHyjwv/wTItrqDb+z74k8iIgAOtYMSHch8ktleCdP
         VDP4lg5wqyZt0+rZ+Lehr6z2c8HAwUFeowRvRzTNdTvZ1wcaL5w7Abcc82PMKmU0/3Ih
         Yf0sxR5/vpK8g83qMCgKTmh66Yta8ORXS/TkwXZd2BCE5XUybJjG1b+KS595ONoIV667
         +Gv7Rk0ALfjgpwYu1ZttMnBHMMCCvIjjFSWJ4SNjnWn8KVaGKTQxbff7pRCvmtrK6Ovp
         OH0Viy6+xpDMjG6ffsRmFeiyjMc6I0dU+1tW5twTjqnA8Aczaf2/8UHgcHtaTonmQUXq
         H1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700674416; x=1701279216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UoCjknw8mm8pTdU3G2BJeKy6q863gsbJT26LTMpWUGM=;
        b=BAPP/3fkLG25LTJeHcj5tYDyGxPXNijuincjWJjDBI2z0lnMUg9wJyTzYgYkO6t3mp
         58+XBv+CWQykyaD/yrusY4a/wAAoqJL0s9svRZwykRLtkB1yvMXIDpRbUIuCbe7ailx0
         XkWR3jysSZYRjvDMWRAgeZW5NY/LKMWke33fXOG/EGSyERzOeCbuYdL9xXH1UN3iS3g4
         A4ZGRgI9dCppvAbUvQDwf51i6v7k4aIVeoiQjP7KKbt7za+mU2HhOyPden8naFF5wtn5
         6lAlPdI576pKl/87i3BkE8beVdLro6E3WbSvrUiTL7sN9lTlW9Vc1Dvm6kZ8I5HxpETT
         oL3Q==
X-Gm-Message-State: AOJu0YzvOsEU9YIqTKVmwYcBWKYZfPjnQSip8XLcnZPqEjYfeT57WXXF
        ck5jKNiextVItf1k0N9pusfl5AFajshKqAiHrBc=
X-Google-Smtp-Source: AGHT+IHVJENGYb/oNMrpiGCF5JMK04qM6dApbvtvdLQxgcro63ZrVS1v0coxcVLYp7AbjDqGC4nyiBkP9LGSZInqhFg=
X-Received: by 2002:a2e:88da:0:b0:2c5:1915:9824 with SMTP id
 a26-20020a2e88da000000b002c519159824mr2357825ljk.9.1700674415875; Wed, 22 Nov
 2023 09:33:35 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-4-ryncsn@gmail.com>
 <CAF8kJuP3OyJ3e2ttiDrqJ4Ucs8BbysaDtuUY3STaJUC8oVkZkQ@mail.gmail.com>
In-Reply-To: <CAF8kJuP3OyJ3e2ttiDrqJ4Ucs8BbysaDtuUY3STaJUC8oVkZkQ@mail.gmail.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Thu, 23 Nov 2023 01:33:17 +0800
Message-ID: <CAMgjq7COk3TXrHJmpWbu-DY8ZZWcRehot+rD87kG0_Z6Z3XuSg@mail.gmail.com>
Subject: Re: [PATCH 03/24] mm/swap: move no readahead swapin code to a stand
 alone helper
To:     Chris Li <chrisl@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
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

Chris Li <chrisl@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8821=E6=97=A5=
=E5=91=A8=E4=BA=8C 13:35=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Nov 19, 2023 at 11:48=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > No feature change, simply move the routine to a standalone function to
> > be used later. The error path handling is copied from the "out_page"
> > label, to make the code change minimized for easier reviewing.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/memory.c     | 33 +++++----------------------------
> >  mm/swap.h       |  2 ++
> >  mm/swap_state.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 55 insertions(+), 28 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 70ffa867b1be..fba4a5229163 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3794,7 +3794,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >         swp_entry_t entry;
> >         pte_t pte;
> >         vm_fault_t ret =3D 0;
> > -       void *shadow =3D NULL;
> >
> >         if (!pte_unmap_same(vmf))
> >                 goto out;
> > @@ -3858,33 +3857,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >         if (!folio) {
> >                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> >                     __swap_count(entry) =3D=3D 1) {
> > -                       /* skip swapcache */
> > -                       folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE,=
 0,
> > -                                               vma, vmf->address, fals=
e);
> > -                       if (folio) {
> > -                               __folio_set_locked(folio);
> > -                               __folio_set_swapbacked(folio);
> > -
> > -                               if (mem_cgroup_swapin_charge_folio(foli=
o,
> > -                                                       vma->vm_mm, GFP=
_KERNEL,
> > -                                                       entry)) {
> > -                                       ret =3D VM_FAULT_OOM;
> > -                                       goto out_page;
> > -                               }
> > -                               mem_cgroup_swapin_uncharge_swap(entry);
> > -
> > -                               shadow =3D get_shadow_from_swap_cache(e=
ntry);
> > -                               if (shadow)
> > -                                       workingset_refault(folio, shado=
w);
> > -
> > -                               folio_add_lru(folio);
> > -                               page =3D &folio->page;
> > -
> > -                               /* To provide entry to swap_readpage() =
*/
> > -                               folio->swap =3D entry;
> > -                               swap_readpage(page, true, NULL);
> > -                               folio->private =3D NULL;
> > -                       }
> > +                       /* skip swapcache and readahead */
> > +                       page =3D swapin_no_readahead(entry, GFP_HIGHUSE=
R_MOVABLE,
> > +                                               vmf);
>
> A minor point,  swapin_no_readahead() is expressed in negative words.
>
> Better use positive words to express what the function does rather
> than what the function does not do.
> I am terrible at naming functions myself. I can think of something
> along the lines of:
> swapin_direct (no cache).
> swapin_minimal?
> swapin_entry_only?
>
> Please suggest better names for basic, bare minimum.

Thanks for the suggestions, I prefer swapin_direct here, will update
with this name and also make it return a folio directly.
