Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AF7763D14
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjGZQ6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjGZQ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:58:20 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B532129
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:58:04 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40550136e54so10791cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690390683; x=1690995483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzfvgCS/BNqD6Bo4MX9shcAhoORyxOu7oJZa5Qf3hpo=;
        b=ue6aYiTs7fERCUiActO7TSbwPWas0LVREjRNP/593EaG/LrzvrxWKvwcP3YMAQrBUd
         rUMd5beDqfMm9mNl7mos80QtZWUkdlbXH0kJs3hRUkasqjMfgkxMN7MnXL0IEw9WaUu7
         6Of4uYc7kZMeEJFpy3JTA+LsnkOFrKBic4bjxpNRAtnOxDnTWz0npNb1Vs0M0v9Dm29E
         31R/MvuaElaHV86uOF8RSbv4fPl3I7s5a8D+DqRf0jiRljLg7DBjfSTLmR1JtrQZqtfZ
         lQRb3r4Bapn+8QAiZIz3VWOoZks8jDjwpEIZ7SknmEFPhb+qwLg4F9ySgxcolV7l0HcY
         djqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690390683; x=1690995483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzfvgCS/BNqD6Bo4MX9shcAhoORyxOu7oJZa5Qf3hpo=;
        b=itYD1DpGol2H9yZhrsTaACKtHgd0bNZruoCy9WyZKapTRndeZGVdHcjCeAEYRBxt//
         ayycGqsZkgqBS+1ekME8jQ4F8q+0tG7llhy77vwd7b6DdoysWvg9oDp5arAVKlVyOiUT
         sYr/GGqjDhOuUXAjJ1neBQaP+MknwNkdfoWIMG/fLEk5k2QdIcDkamNp/4FiA/tiVSxu
         LOXh4gLLQU5iOA68eliEsVOWcHpCBv9Xonyn+kUk/vJCgt6B5Y2ARz7HYSRaHOvKOFW6
         PjQ18+chTxlYdvQltRdFkanlIoiP4Us9DjOPDBtM8yrj2O+pfXvTUEkwjsJ/mJtpvznv
         5etA==
X-Gm-Message-State: ABy/qLY/bMCjEAa6G8YTAT1DbKJsL4IFvNzMD6qrAfqahnunq7kpxtcN
        Su5b/wxxrkKpsJSxoiWMWMg5zSjLam8dv3/5ZuFTgw==
X-Google-Smtp-Source: APBJJlH/1mslJPV6KdZSzJRuwAVV5vbX13JACKxHvE8/Yk0gTDpwGHT/JAwaCqfSP41uk2/gyoiPyZp9sdzLXNHe6BE=
X-Received: by 2002:a05:622a:144b:b0:3f0:af20:1a37 with SMTP id
 v11-20020a05622a144b00b003f0af201a37mr546183qtx.15.1690390683402; Wed, 26 Jul
 2023 09:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <20230712060144.3006358-4-fengwei.yin@intel.com> <CAOUHufYef--8MxFettL6fOGjVx2vyZHZQU6EEaTCoW0XBvuC8Q@mail.gmail.com>
 <CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com> <3bd7b290-91ad-347f-b1b5-5d45ac566f69@intel.com>
In-Reply-To: <3bd7b290-91ad-347f-b1b5-5d45ac566f69@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 26 Jul 2023 10:57:27 -0600
Message-ID: <CAOUHufY_b2skiEXSukpOLnpbzrifFiwxY8HA0W_z9aZbVome4Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] mm: mlock: update mlock_pte_range to handle
 large folio
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
        ryan.roberts@arm.com, shy828301@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 6:49=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.com>=
 wrote:
>
>
>
> On 7/15/23 14:06, Yu Zhao wrote:
> > On Wed, Jul 12, 2023 at 12:31=E2=80=AFAM Yu Zhao <yuzhao@google.com> wr=
ote:
> >>
> >> On Wed, Jul 12, 2023 at 12:02=E2=80=AFAM Yin Fengwei <fengwei.yin@inte=
l.com> wrote:
> >>>
> >>> Current kernel only lock base size folio during mlock syscall.
> >>> Add large folio support with following rules:
> >>>   - Only mlock large folio when it's in VM_LOCKED VMA range
> >>>
> >>>   - If there is cow folio, mlock the cow folio as cow folio
> >>>     is also in VM_LOCKED VMA range.
> >>>
> >>>   - munlock will apply to the large folio which is in VMA range
> >>>     or cross the VMA boundary.
> >>>
> >>> The last rule is used to handle the case that the large folio is
> >>> mlocked, later the VMA is split in the middle of large folio
> >>> and this large folio become cross VMA boundary.
> >>>
> >>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> >>> ---
> >>>  mm/mlock.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++-=
--
> >>>  1 file changed, 99 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/mm/mlock.c b/mm/mlock.c
> >>> index 0a0c996c5c214..f49e079066870 100644
> >>> --- a/mm/mlock.c
> >>> +++ b/mm/mlock.c
> >>> @@ -305,6 +305,95 @@ void munlock_folio(struct folio *folio)
> >>>         local_unlock(&mlock_fbatch.lock);
> >>>  }
> >>>
> >>> +static inline bool should_mlock_folio(struct folio *folio,
> >>> +                                       struct vm_area_struct *vma)
> >>> +{
> >>> +       if (vma->vm_flags & VM_LOCKED)
> >>> +               return (!folio_test_large(folio) ||
> >>> +                               folio_within_vma(folio, vma));
> >>> +
> >>> +       /*
> >>> +        * For unlock, allow munlock large folio which is partially
> >>> +        * mapped to VMA. As it's possible that large folio is
> >>> +        * mlocked and VMA is split later.
> >>> +        *
> >>> +        * During memory pressure, such kind of large folio can
> >>> +        * be split. And the pages are not in VM_LOCKed VMA
> >>> +        * can be reclaimed.
> >>> +        */
> >>> +
> >>> +       return true;
> >>
> >> Looks good, or just
> >>
> >> should_mlock_folio() // or whatever name you see fit, can_mlock_folio(=
)?
> >> {
> >>   return !(vma->vm_flags & VM_LOCKED) || folio_within_vma();
> >> }
> >>
> >>> +}
> >>> +
> >>> +static inline unsigned int get_folio_mlock_step(struct folio *folio,
> >>> +                       pte_t pte, unsigned long addr, unsigned long =
end)
> >>> +{
> >>> +       unsigned int nr;
> >>> +
> >>> +       nr =3D folio_pfn(folio) + folio_nr_pages(folio) - pte_pfn(pte=
);
> >>> +       return min_t(unsigned int, nr, (end - addr) >> PAGE_SHIFT);
> >>> +}
> >>> +
> >>> +void mlock_folio_range(struct folio *folio, struct vm_area_struct *v=
ma,
> >>> +               pte_t *pte, unsigned long addr, unsigned int nr)
> >>> +{
> >>> +       struct folio *cow_folio;
> >>> +       unsigned int step =3D 1;
> >>> +
> >>> +       mlock_folio(folio);
> >>> +       if (nr =3D=3D 1)
> >>> +               return;
> >>> +
> >>> +       for (; nr > 0; pte +=3D step, addr +=3D (step << PAGE_SHIFT),=
 nr -=3D step) {
> >>> +               pte_t ptent;
> >>> +
> >>> +               step =3D 1;
> >>> +               ptent =3D ptep_get(pte);
> >>> +
> >>> +               if (!pte_present(ptent))
> >>> +                       continue;
> >>> +
> >>> +               cow_folio =3D vm_normal_folio(vma, addr, ptent);
> >>> +               if (!cow_folio || cow_folio =3D=3D folio) {
> >>> +                       continue;
> >>> +               }
> >>> +
> >>> +               mlock_folio(cow_folio);
> >>> +               step =3D get_folio_mlock_step(folio, ptent,
> >>> +                               addr, addr + (nr << PAGE_SHIFT));
> >>> +       }
> >>> +}
> >>> +
> >>> +void munlock_folio_range(struct folio *folio, struct vm_area_struct =
*vma,
> >>> +               pte_t *pte, unsigned long addr, unsigned int nr)
> >>> +{
> >>> +       struct folio *cow_folio;
> >>> +       unsigned int step =3D 1;
> >>> +
> >>> +       munlock_folio(folio);
> >>> +       if (nr =3D=3D 1)
> >>> +               return;
> >>> +
> >>> +       for (; nr > 0; pte +=3D step, addr +=3D (step << PAGE_SHIFT),=
 nr -=3D step) {
> >>> +               pte_t ptent;
> >>> +
> >>> +               step =3D 1;
> >>> +               ptent =3D ptep_get(pte);
> >>> +
> >>> +               if (!pte_present(ptent))
> >>> +                       continue;
> >>> +
> >>> +               cow_folio =3D vm_normal_folio(vma, addr, ptent);
> >>> +               if (!cow_folio || cow_folio =3D=3D folio) {
> >>> +                       continue;
> >>> +               }
> >>> +
> >>> +               munlock_folio(cow_folio);
> >>> +               step =3D get_folio_mlock_step(folio, ptent,
> >>> +                               addr, addr + (nr << PAGE_SHIFT));
> >>> +       }
> >>> +}
> >>
> >> I'll finish the above later.
> >
> > There is a problem here that I didn't have the time to elaborate: we
> > can't mlock() a folio that is within the range but not fully mapped
> > because this folio can be on the deferred split queue. When the split
> > happens, those unmapped folios (not mapped by this vma but are mapped
> > into other vmas) will be stranded on the unevictable lru.
> Checked remap case in past few days, I agree we shouldn't treat a folio
> in the range but not fully mapped as in_range folio.
>
> As for remap case, it's possible that the folio is not in deferred split
> queue. But part of folio is mapped to VM_LOCKED vma and other part of
> folio is mapped to none VM_LOCKED vma. In this case, page can't be split
> as it's not in deferred split queue. So page reclaim should be allowed to
> pick this folio up, split it and reclaim the pages in none VM_LOCKED vma.
> So we can't mlock such kind of folio.
>
> The same thing can happen with madvise_cold_or_pageout_pte_range().
> I will update folio_in_vma() to check the PTE also.

Thanks, and I think we should move forward with this series and fix
the potential mlock race problem separately since it's not caused by
this series.

WDYT?
