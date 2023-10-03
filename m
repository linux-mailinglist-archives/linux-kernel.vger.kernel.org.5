Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4207B71E3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240945AbjJCTkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjJCTk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:40:29 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB2AA1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:40:23 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-59bebd5bdadso16270287b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696362022; x=1696966822; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfr2egyOR1+C8mShorjIOzO6y7VY3Fj1mtMvJxoOK94=;
        b=PQQqyYd+6uXF9D80Z40ld/X+JOpKdDMrgI1lB1FVGEowbemslL8lvrbY+GZZV0u349
         LuktTORcUrE/PssAcwYuRPqB6Q6AJjUS33kg1bPX1ueikglwVACWevDjHgH3yDbn3fha
         VtxxRaIAKhoeLu7jIiYB6BBnAfIncsKEQXN7ktHutF4/R2BnvnUGk9uSVdlt2ZAAzdtg
         sqoDRgAO5qhazmggFZKDrNtm9z5hyrOt4ipbNRTlI8ZGXlPsxWXo3yTKMOlMsWtU92zi
         yzPUoxC6dMm06FPmg3yOzyIAj1li21u622jep2tUrcKYSb5JfvOc4ZZVgOI0Jr3HR5eO
         Q2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696362022; x=1696966822;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfr2egyOR1+C8mShorjIOzO6y7VY3Fj1mtMvJxoOK94=;
        b=a2NQ8m+i2XW/f6+sYiHC5wGbXy7o0u/YRZglkGoMvG4MXqGlJ4q7xcdhyL0HnVn/HL
         MFcphGhdrl9bCqJ6LptMM1pzfOMhlcn7wdkbb6Wq7VJCD0UbSrcruuLBKXV1TP5YLN+A
         gOrR74yimT1XwUeTJlvnvQ9rxzvmynZE0u2IR54UJU3K0iOizi1UTvUeGXu/Uv8B4QKm
         gg5aQbjQuld6aZ6iQDHkfGpMQby86DsXd+LRUtjl/diUUzoN79vLrEY7SM60+K5SlPnA
         iWShGdJ5nZJ7/vS5jSwuYVpvvigB5FqkLPTqjOFqKuAOlZ9kL/GB8RWhHe5O4ilRRrnT
         9oTw==
X-Gm-Message-State: AOJu0Yz/l4zMk+eTmLHe9Tn1JiJ6iDn+5Z9F7Nd8csqwUWIvObjTax7h
        VXkl7wOE+bcSKdzjWi25mIX3z2gfq6pKur46sDmxUA==
X-Google-Smtp-Source: AGHT+IHMRHSRLs+lH7EW8L10zxsOV/xPpBMFnE87yJyz8Bgq+zHVJ8yFa+IWyhMreU9et69QGkrqkHneSbi5sLXaf+4=
X-Received: by 2002:a0d:e001:0:b0:59e:7fc1:dba0 with SMTP id
 j1-20020a0de001000000b0059e7fc1dba0mr523083ywe.44.1696362022441; Tue, 03 Oct
 2023 12:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230929183041.2835469-1-Liam.Howlett@oracle.com>
 <20230929183041.2835469-3-Liam.Howlett@oracle.com> <CAJuCfpFx3zxv1ZgkLh4dkafOCHvL_674cysJiuQPQhKXX9BuzQ@mail.gmail.com>
 <20231003185149.brbzyu2ivn25tkeu@revolver>
In-Reply-To: <20231003185149.brbzyu2ivn25tkeu@revolver>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 3 Oct 2023 12:40:07 -0700
Message-ID: <CAJuCfpGh6pnX_bcV0ArdAdbE=Dkru0EKf=zLd_tAATcqyx6i2w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mmap: Fix error paths with dup_anon_vma()
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 11:51=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [231003 12:21]:
> > On Fri, Sep 29, 2023 at 11:30=E2=80=AFAM Liam R. Howlett
> > <Liam.Howlett@oracle.com> wrote:
> > >
> > > When the calling function fails after the dup_anon_vma(), the
> > > duplication of the anon_vma is not being undone.  Add the necessary
> > > unlink_anon_vma() call to the error paths that are missing them.
> > >
> > > This issue showed up during inspection of the error path in vma_merge=
()
> > > for an unrelated vma iterator issue.
> > >
> > > Users may experience increased memory usage, which may be problematic=
 as
> > > the failure would likely be caused by a low memory situation.
> > >
> > > Fixes: d4af56c5c7c6 ("mm: start tracking VMAs with maple tree")
> > > Cc: stable@vger.kernel.org
> > > Cc: Jann Horn <jannh@google.com>
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > ---
> > >  mm/mmap.c | 30 ++++++++++++++++++++++--------
> > >  1 file changed, 22 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index acb7dea49e23..f9f0a5fe4db4 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -583,11 +583,12 @@ static inline void vma_complete(struct vma_prep=
are *vp,
> > >   * dup_anon_vma() - Helper function to duplicate anon_vma
> > >   * @dst: The destination VMA
> > >   * @src: The source VMA
> > > + * @dup: Pointer to the destination VMA when successful.
> > >   *
> > >   * Returns: 0 on success.
> > >   */
> > >  static inline int dup_anon_vma(struct vm_area_struct *dst,
> > > -                              struct vm_area_struct *src)
> > > +               struct vm_area_struct *src, struct vm_area_struct **d=
up)
> > >  {
> > >         /*
> > >          * Easily overlooked: when mprotect shifts the boundary, make=
 sure the
> > > @@ -595,9 +596,15 @@ static inline int dup_anon_vma(struct vm_area_st=
ruct *dst,
> > >          * anon pages imported.
> > >          */
> > >         if (src->anon_vma && !dst->anon_vma) {
> > > +               int ret;
> > > +
> > >                 vma_assert_write_locked(dst);
> > >                 dst->anon_vma =3D src->anon_vma;
> > > -               return anon_vma_clone(dst, src);
> > > +               ret =3D anon_vma_clone(dst, src);
> > > +               if (ret)
> > > +                       return ret;
> > > +
> > > +               *dup =3D dst;
> > >         }
> > >
> > >         return 0;
> > > @@ -624,6 +631,7 @@ int vma_expand(struct vma_iterator *vmi, struct v=
m_area_struct *vma,
> > >                unsigned long start, unsigned long end, pgoff_t pgoff,
> > >                struct vm_area_struct *next)
> > >  {
> > > +       struct vm_area_struct *anon_dup =3D NULL;
> > >         bool remove_next =3D false;
> > >         struct vma_prepare vp;
> > >
> > > @@ -633,7 +641,7 @@ int vma_expand(struct vma_iterator *vmi, struct v=
m_area_struct *vma,
> > >
> > >                 remove_next =3D true;
> > >                 vma_start_write(next);
> > > -               ret =3D dup_anon_vma(vma, next);
> > > +               ret =3D dup_anon_vma(vma, next, &anon_dup);
> > >                 if (ret)
> > >                         return ret;
> >
> > Shouldn't the above be changed to a "goto nomem" instead of "return ret=
" ?
> >
> >
> > >         }
> > > @@ -661,6 +669,8 @@ int vma_expand(struct vma_iterator *vmi, struct v=
m_area_struct *vma,
> > >         return 0;
> > >
> > >  nomem:
> > > +       if (anon_dup)
> > > +               unlink_anon_vmas(anon_dup);
> > >         return -ENOMEM;
> > >  }
> > >
> > > @@ -860,6 +870,7 @@ struct vm_area_struct *vma_merge(struct vma_itera=
tor *vmi, struct mm_struct *mm,
> > >  {
> > >         struct vm_area_struct *curr, *next, *res;
> > >         struct vm_area_struct *vma, *adjust, *remove, *remove2;
> > > +       struct vm_area_struct *anon_dup =3D NULL;
> > >         struct vma_prepare vp;
> > >         pgoff_t vma_pgoff;
> > >         int err =3D 0;
> > > @@ -927,18 +938,18 @@ struct vm_area_struct *vma_merge(struct vma_ite=
rator *vmi, struct mm_struct *mm,
> > >                 vma_start_write(next);
> > >                 remove =3D next;                          /* case 1 *=
/
> > >                 vma_end =3D next->vm_end;
> > > -               err =3D dup_anon_vma(prev, next);
> > > +               err =3D dup_anon_vma(prev, next, &anon_dup);
> > >                 if (curr) {                             /* case 6 */
> > >                         vma_start_write(curr);
> > >                         remove =3D curr;
> > >                         remove2 =3D next;
> > >                         if (!next->anon_vma)
> > > -                               err =3D dup_anon_vma(prev, curr);
> > > +                               err =3D dup_anon_vma(prev, curr, &ano=
n_dup);
> > >                 }
> > >         } else if (merge_prev) {                        /* case 2 */
> > >                 if (curr) {
> > >                         vma_start_write(curr);
> > > -                       err =3D dup_anon_vma(prev, curr);
> > > +                       err =3D dup_anon_vma(prev, curr, &anon_dup);
> > >                         if (end =3D=3D curr->vm_end) {      /* case 7=
 */
> > >                                 remove =3D curr;
> > >                         } else {                        /* case 5 */
> > > @@ -954,7 +965,7 @@ struct vm_area_struct *vma_merge(struct vma_itera=
tor *vmi, struct mm_struct *mm,
> > >                         vma_end =3D addr;
> > >                         adjust =3D next;
> > >                         adj_start =3D -(prev->vm_end - addr);
> > > -                       err =3D dup_anon_vma(next, prev);
> > > +                       err =3D dup_anon_vma(next, prev, &anon_dup);
> > >                 } else {
> > >                         /*
> > >                          * Note that cases 3 and 8 are the ONLY ones =
where prev
> > > @@ -968,7 +979,7 @@ struct vm_area_struct *vma_merge(struct vma_itera=
tor *vmi, struct mm_struct *mm,
> > >                                 vma_pgoff =3D curr->vm_pgoff;
> > >                                 vma_start_write(curr);
> > >                                 remove =3D curr;
> > > -                               err =3D dup_anon_vma(next, curr);
> > > +                               err =3D dup_anon_vma(next, curr, &ano=
n_dup);
> > >                         }
> > >                 }
> > >         }
> > > @@ -1018,6 +1029,9 @@ struct vm_area_struct *vma_merge(struct vma_ite=
rator *vmi, struct mm_struct *mm,
> > >         return res;
> > >
> > >  prealloc_fail:
> > > +       if (anon_dup)
> > > +               unlink_anon_vmas(anon_dup);
> >
> > Maybe a stupid question, but why can't we do this unlinking inside
> > dup_anon_vma() itself when anon_vma_clone() fails? That would
> > eliminate the need for the out parameter in that function. I suspect
> > that there is a reason for that which I'm missing.
>
> It's too late.  This is to undo the link when the preallocation for the
> maple tree fails.  So we had memory to dup the anon vma, but not to put
> it in the tree.

Ah, I see what I missed now. Sorry for the noise.

>
> >
> > > +
> > >  anon_vma_fail:
> > >         vma_iter_set(vmi, addr);
> > >         vma_iter_load(vmi);
> > > --
> > > 2.40.1
> > >
