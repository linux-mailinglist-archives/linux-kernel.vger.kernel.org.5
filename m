Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0079E7546FA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 08:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjGOGHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 02:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOGHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 02:07:17 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B237D30DE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 23:07:15 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-403b622101bso103121cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 23:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689401235; x=1691993235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfySVCw+dpSTsc2B4oZPue0u3zK7+gWWCOiPp0wEcv4=;
        b=FjpzhPEP83eaD5w6Z6mPAwSFgtQ/CSnpow4tvOH87Li3FnGeF8BbVB7frhWkwJHzCa
         vehXELES21VPBnrYq/800TmG7L6GNqAtfplXqWCJnGvzuqRBYnyWoOsUM1ED5OWMnJbR
         n8kWVM66vx6J9HIk9c98Cnf79Ls02VE5TcRUh7UwU6tzIfWUfTQ8GuLuyqmW/rMaXruP
         ONdPTNsFs5qyhE8vsmV8TRXuOqKP/aEFtbbfwcoGlI8hzM1LgjPITxIgw6SDX+5IofEd
         i2TUxPkw6izO03Y+4LYq9fUFWDlrSzjnbquk1lEbfRDlfxLMfXzqBV92nBynl8kJ78BS
         pfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689401235; x=1691993235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfySVCw+dpSTsc2B4oZPue0u3zK7+gWWCOiPp0wEcv4=;
        b=IxTV2LkX/pzF+ZJe/Jx7RJ0Fb3w/a8t8mhFBd8pvd7N3y9qmwb6yiP/yTa64VApvWc
         HBAbom3hnw43ULnLH7qvATRuyJvBFzno4ODcAysmrveI2u2FDrbV1uZ/mc0mGnnTKafc
         gTcujxru0QOoaerri4vVUezfsnRtuUOpu/qnchIrTGKlHh/3si0ElEzQgwofraHJuvrN
         ESrC2SZaZegeeWUq66HBCvrDLY6u/29pZILY9V28s/LrAw/1Tw2TV10FBSYEpCmq43tb
         35cNoLuFFSYPAHUbehTdkk8o07WokMmH4y+huiLxFg2MdO0B57H/+CVHeQ/nuHKV+gAh
         P/tA==
X-Gm-Message-State: ABy/qLZPkYPsbDpm0lbA+fwfeGsCZnbjhbnWw/9iOaZm7bxmRj4/+ZJQ
        jr9QORySxQIEXcS0KtpVCl4zmqfMgNCc5FTS7yXRZA==
X-Google-Smtp-Source: APBJJlEN3scYa9/MXXc3sIsMXw+QEoBrMEBa9G2/rGleo/rVI4DffDqmiXH4E7i9LoBBSPrF9tdqCFEumTzco4s7Q9g=
X-Received: by 2002:ac8:5814:0:b0:3ef:404a:b291 with SMTP id
 g20-20020ac85814000000b003ef404ab291mr991086qtg.7.1689401234707; Fri, 14 Jul
 2023 23:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <20230712060144.3006358-4-fengwei.yin@intel.com> <CAOUHufYef--8MxFettL6fOGjVx2vyZHZQU6EEaTCoW0XBvuC8Q@mail.gmail.com>
In-Reply-To: <CAOUHufYef--8MxFettL6fOGjVx2vyZHZQU6EEaTCoW0XBvuC8Q@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sat, 15 Jul 2023 00:06:38 -0600
Message-ID: <CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com>
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

On Wed, Jul 12, 2023 at 12:31=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Jul 12, 2023 at 12:02=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.c=
om> wrote:
> >
> > Current kernel only lock base size folio during mlock syscall.
> > Add large folio support with following rules:
> >   - Only mlock large folio when it's in VM_LOCKED VMA range
> >
> >   - If there is cow folio, mlock the cow folio as cow folio
> >     is also in VM_LOCKED VMA range.
> >
> >   - munlock will apply to the large folio which is in VMA range
> >     or cross the VMA boundary.
> >
> > The last rule is used to handle the case that the large folio is
> > mlocked, later the VMA is split in the middle of large folio
> > and this large folio become cross VMA boundary.
> >
> > Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> > ---
> >  mm/mlock.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 99 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/mlock.c b/mm/mlock.c
> > index 0a0c996c5c214..f49e079066870 100644
> > --- a/mm/mlock.c
> > +++ b/mm/mlock.c
> > @@ -305,6 +305,95 @@ void munlock_folio(struct folio *folio)
> >         local_unlock(&mlock_fbatch.lock);
> >  }
> >
> > +static inline bool should_mlock_folio(struct folio *folio,
> > +                                       struct vm_area_struct *vma)
> > +{
> > +       if (vma->vm_flags & VM_LOCKED)
> > +               return (!folio_test_large(folio) ||
> > +                               folio_within_vma(folio, vma));
> > +
> > +       /*
> > +        * For unlock, allow munlock large folio which is partially
> > +        * mapped to VMA. As it's possible that large folio is
> > +        * mlocked and VMA is split later.
> > +        *
> > +        * During memory pressure, such kind of large folio can
> > +        * be split. And the pages are not in VM_LOCKed VMA
> > +        * can be reclaimed.
> > +        */
> > +
> > +       return true;
>
> Looks good, or just
>
> should_mlock_folio() // or whatever name you see fit, can_mlock_folio()?
> {
>   return !(vma->vm_flags & VM_LOCKED) || folio_within_vma();
> }
>
> > +}
> > +
> > +static inline unsigned int get_folio_mlock_step(struct folio *folio,
> > +                       pte_t pte, unsigned long addr, unsigned long en=
d)
> > +{
> > +       unsigned int nr;
> > +
> > +       nr =3D folio_pfn(folio) + folio_nr_pages(folio) - pte_pfn(pte);
> > +       return min_t(unsigned int, nr, (end - addr) >> PAGE_SHIFT);
> > +}
> > +
> > +void mlock_folio_range(struct folio *folio, struct vm_area_struct *vma=
,
> > +               pte_t *pte, unsigned long addr, unsigned int nr)
> > +{
> > +       struct folio *cow_folio;
> > +       unsigned int step =3D 1;
> > +
> > +       mlock_folio(folio);
> > +       if (nr =3D=3D 1)
> > +               return;
> > +
> > +       for (; nr > 0; pte +=3D step, addr +=3D (step << PAGE_SHIFT), n=
r -=3D step) {
> > +               pte_t ptent;
> > +
> > +               step =3D 1;
> > +               ptent =3D ptep_get(pte);
> > +
> > +               if (!pte_present(ptent))
> > +                       continue;
> > +
> > +               cow_folio =3D vm_normal_folio(vma, addr, ptent);
> > +               if (!cow_folio || cow_folio =3D=3D folio) {
> > +                       continue;
> > +               }
> > +
> > +               mlock_folio(cow_folio);
> > +               step =3D get_folio_mlock_step(folio, ptent,
> > +                               addr, addr + (nr << PAGE_SHIFT));
> > +       }
> > +}
> > +
> > +void munlock_folio_range(struct folio *folio, struct vm_area_struct *v=
ma,
> > +               pte_t *pte, unsigned long addr, unsigned int nr)
> > +{
> > +       struct folio *cow_folio;
> > +       unsigned int step =3D 1;
> > +
> > +       munlock_folio(folio);
> > +       if (nr =3D=3D 1)
> > +               return;
> > +
> > +       for (; nr > 0; pte +=3D step, addr +=3D (step << PAGE_SHIFT), n=
r -=3D step) {
> > +               pte_t ptent;
> > +
> > +               step =3D 1;
> > +               ptent =3D ptep_get(pte);
> > +
> > +               if (!pte_present(ptent))
> > +                       continue;
> > +
> > +               cow_folio =3D vm_normal_folio(vma, addr, ptent);
> > +               if (!cow_folio || cow_folio =3D=3D folio) {
> > +                       continue;
> > +               }
> > +
> > +               munlock_folio(cow_folio);
> > +               step =3D get_folio_mlock_step(folio, ptent,
> > +                               addr, addr + (nr << PAGE_SHIFT));
> > +       }
> > +}
>
> I'll finish the above later.

There is a problem here that I didn't have the time to elaborate: we
can't mlock() a folio that is within the range but not fully mapped
because this folio can be on the deferred split queue. When the split
happens, those unmapped folios (not mapped by this vma but are mapped
into other vmas) will be stranded on the unevictable lru.

For that matter, we can't mlock any large folios that are being
shared, unless you want to overengineer it by checking whether all
sharing vmas are also mlocked -- mlock is cleared during fork. So the
condition for mlocking large anon folios is 1) within range 2) fully
mapped 3) not shared (mapcount is 1). The final patch should look like
something like this:

-  if (folio_test_large(folio))
+  if (folio_pfn(folio) !=3D pte_pfn(ptent))
+    continue;
+  if (!the_aforementioned_condition())

There is another corner case I forgot to mention: for example, what if
a folio spans two (the only two) adjacent mlocked vmas? No need to
worry about this since it's not worth optimizing.
