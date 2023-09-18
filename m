Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07457A55D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 00:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjIRWe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 18:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjIRWe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 18:34:26 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D45F8F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 15:34:20 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c1ff5b741cso47205725ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 15:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695076459; x=1695681259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUkr9LfbTyv6vcIyDNWH9tCnMEz/oCqap7Wj4eBnscg=;
        b=QMtQ0lN9aIOV7s4+A5gcGejPrVGNmnBvC/v/PAz/Tl2RtD8EIDDQ7dC7qTTS4GiE+n
         rDJPGgujswf4zTjRipsoh8Q99BSzWxNJi1vgShDdlwbAV8n4oTNtbJGJKy8v6drg8zgu
         b2vO5fTKpDd4un2PJ/Z7jIZKzNnuqdH9F9d+j2oaC7cBKNd/TG5BBLn8nTNx4pmqZY5M
         Wbb5JYuzQ4ZvOlOGMRrWCX7d9omO386yHLnkPwHtSdSLovN7rViCkiY9CGsgUeH/d3NX
         eoOg7WXy+bp4hAH/wqyFYpfn68MhvUJXd58oLZRcT8o74e5tWu2TOTOg8V30yWe449Zj
         5XYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695076459; x=1695681259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUkr9LfbTyv6vcIyDNWH9tCnMEz/oCqap7Wj4eBnscg=;
        b=LzDVdVu6s6p+qjRgIC+AFga/KAXWTzQ2XpCyNQHR+/e7ju7JinDilSXH0fm0OanrLU
         B2Et2J3DaFwIo4b/JJOJnnxd1WdDhoz+TYNG5l/ykhxd+YQcXdV+EBpVZ9ccP1jXbO1X
         GP3ksjKBoBran9LtlxSwSTjJDcotcf0nT2admQ5eO8q991HZHdHQKQJFYSJzfBqhOBiD
         bS7HCPf1EDM+1ATg0jZooIPuIPpbIKb5vju6jWYjJV6aTp7UO3XGDraZHd8UPW8aD4c9
         sOlgT/BOm0LpnLwKN5GMWjoXpfqaY6iOVVjnAWHmJ86zV9x4alS/gUmMtG3lAaX2usmM
         ThBQ==
X-Gm-Message-State: AOJu0YwSo6x9QjuquqhGtoz1/9X+zmiPeIKkxu+SVC5fcWHLiYNsSaAY
        9GHikwQyRLiJxlbEBGMHo7gC16hDaFPglGzwtU0=
X-Google-Smtp-Source: AGHT+IERwUsdgGtGHFijFTCaNFIQcY3kmqKnVFV3mJUyG7jPZiDE692wFuWpaLlq/Sd9yDM8aCIYWhbaSKA9viF97bo=
X-Received: by 2002:a17:902:ce82:b0:1c3:e40d:ffec with SMTP id
 f2-20020a170902ce8200b001c3e40dffecmr12296801plg.47.1695076459592; Mon, 18
 Sep 2023 15:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <ZP/3hgDCXeceE9uU@casper.infradead.org> <ZQB76G/6NxVgoE9u@casper.infradead.org>
 <CAJuCfpGEa504z1pgqR9KtCWQPESTcRcu8xoyxcNOv=6t4R+ong@mail.gmail.com>
 <CAJuCfpHYNbH0WmfDnpX6eqL3f3Z632iQrcw6oqPXtB0_QjaiiQ@mail.gmail.com>
 <CAJuCfpF4j6fKpk853tXu155jbfk1z_PbWXjf4bypYwDRf78-iw@mail.gmail.com>
 <CAJuCfpETZr56WD5j7aQY-dY84ciur=QTZYxuShmjEG+fZFhDsw@mail.gmail.com>
 <CAJuCfpECwpQ8wHnwhkLztvvxZmP9rH+aW3A39BSzkZ9t2JK6dQ@mail.gmail.com>
 <ZQNaT/3xPxATKJVR@casper.infradead.org> <CAJuCfpEAZbtUrwrfqd+PWJv9efVy1HRbqrLUYAP4rYRvk0vWug@mail.gmail.com>
 <CAJuCfpGp2CwGJmmwzK7WdudOyL1CCWVaERRK9qTtNA8SZ365SA@mail.gmail.com>
 <ZQN58hFWfgn+OfvG@casper.infradead.org> <CAJuCfpGRSJhBBZop_L-UubuveUWBca4YtyPBzM2KZGEx7iwhXg@mail.gmail.com>
 <da13f5a-b87f-d776-e58a-d492fa2773f9@google.com> <CAHbLzkrmTaqBRmHVdE2kyW57Uoghqd_E+jAXC9cB5ofkhL-uvw@mail.gmail.com>
 <fc874e32-2a69-50ae-b1c9-5a982f16e1f1@google.com>
In-Reply-To: <fc874e32-2a69-50ae-b1c9-5a982f16e1f1@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 18 Sep 2023 15:34:07 -0700
Message-ID: <CAHbLzkoQV_1LzxtdEazfPmSEh+CgRLpED6nxdTZ1D=2D1HwV4g@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in vma_replace_policy
To:     Hugh Dickins <hughd@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        syzbot <syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 8:57=E2=80=AFPM Hugh Dickins <hughd@google.com> wro=
te:
>
> On Fri, 15 Sep 2023, Yang Shi wrote:
> >
> > Hi Suren and Hugh,
> >
> > Thanks for figuring this out. The mbind behavior is a little bit messy
> > and hard to follow. I tried my best to recall all the changes.
>
> Messy and confusing yes; and for every particular behavior, I suspect
> that by now there exists some release which has done it that way.
>
> >
> > IIUC, mbind did break the vma iteration early in the first place, then
> > commit 6f4576e3687b ("mempolicy: apply page table walker on
> > queue_pages_range()") changed the behavior (didn't break vma iteration
> > early for some cases anymore), but it messed up the return value and
> > caused some test cases failure, also violated the manual. The return
> > value issue was fixed by commit a7f40cfe3b7a ("mm: mempolicy: make
> > mbind() return -EIO when MPOL_MF_STRICT is specified"), this commit
> > also restored the oldest behavior (break loop early). But it also
> > breaks the loop early when MPOL_MF_MOVE|MOVEALL is set, kernel should
> > actually continue the loop to try to migrate all existing pages per
> > the manual.
>
> Oh, I missed that aspect in my description: yes, I think that's the
> worst of it: MPOL_MF_STRICT alone could break out early because it had
> nothing more to learn by going further, but it was simply a mistake for
> the MOVEs to break out early (and arguable what MOVE|STRICT should do).
>
> I thought you and I were going to have a debate about this, but we
> appear to be in agreement.  And I'm not sure whether I agree with
> myself about whether do_mbind() should apply the mbind_range()s
> when STRICT queue_pages_range() found an unmovable - there are
> consistency and regression arguments both ways.

They will not be added into the migration list in the first place. Why
waste time to try to migrate the unmovable?

>
> (I've been repeatedly puzzled by your comment in queue_folios_pte_range()
>                 if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
>                         /* MPOL_MF_STRICT must be specified if we get her=
e */
>                         if (!vma_migratable(vma)) {
> Does that commment about MPOL_MF_STRICT actually belong inside the
> !vma_migratable(vma) block?  Sometimes I think so, but sometimes I
> remember that the interaction of those flags, and the skipping arranged
> by queue_pages_test_walk(), is subtler than I imagine.)

It is because the below code snippet from queue_pages_test_walk():

if (!vma_migratable(vma) &&
    !(flags & MPOL_MF_STRICT))
return 1;

When queue_pages_test_walk() returns 1, queue_folios_pte_range() will
be skipped. So if queue_folios_pte_range() sees unmigratable vma, it
means MPOL_MF_STRICT must be set.

>
> > It sounds like a regression. I will take a look at it.
>
> Thanks! Please do, I don't have the time for it.
>
> >
> > So the logic should conceptually look like:
> >
> > if (MPOL_MF_MOVE|MOVEALL)
> >     continue;
> > if (MPOL_MF_STRICT)
> >     break;
> >
> > So it is still possible that some VMAs are not locked if only
> > MPOL_MF_STRICT is set.
>
> Conditionally, I'll agree; but it's too easy for me to agree in the
> course of trying to get an email out, but on later reflection come
> to disagree.  STRICT|MOVE behavior arguable.

I thought the code should conceptually do:

if (MPOL_MF_MOVE|MOVEALL)
    scan all vmas
    try to migrate the existing pages
    return success
else if (MPOL_MF_MOVE* | MPOL_MF_STRICT)
    scan all vmas
    try to migrate the existing pages
    return -EIO if unmovable or migration failed
else /* MPOL_MF_STRICT alone */
    break early if meets unmovable and don't call mbind_range() at all

So the vma scan will just be skipped when MPOL_MF_STRICT alone is
specified and mbind_range() won't be called in this case. So Suren's
fix may not be needed.

>
> I think the best I can do is send you (privately) my approx-v5.2 patch
> for this (which I never got time to put into even a Google-internal
> kernel, though an earlier version was there).  In part because I did
> more research back then, and its commit message cites several even
> older commits than you cite above, which might help to shed more light
> on the history (or might just be wrong).  And in part because it may
> give you some more ideas of what needs doing: notably qp->nr_failed,
> because "man 2 migrate_pages" says "On success migrate_pages() returns
> the number of pages that could not be moved", but we seem to have
> lost sight of that (from which one may conclude that it's not very
> important, but I did find it useful when testing); but of course
> the usual doubts about the right way to count a page when compound.
>
> I'll check how easily that patch applies to a known base such as
> v5.2, maybe trim it to fit better, then send it off to you.

I'm thinking about the below fix (build test against the latest
mm-unstable only):

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 42b5567e3773..c9b768a042a8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -426,6 +426,7 @@ struct queue_pages {
  unsigned long start;
  unsigned long end;
  struct vm_area_struct *first;
+ bool has_unmovable;
 };

 /*
@@ -446,9 +447,8 @@ static inline bool queue_folio_required(struct folio *f=
olio,
 /*
  * queue_folios_pmd() has three possible return values:
  * 0 - folios are placed on the right node or queued successfully, or
- *     special page is met, i.e. huge zero page.
- * 1 - there is unmovable folio, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
- *     specified.
+ *     special page is met, i.e. zero page, or unmovable page is found
+ *     but continue walking (indicated by queue_pages.has_unmovable).
  * -EIO - is migration entry or only MPOL_MF_STRICT was specified and an
  *        existing folio was already on a node that does not follow the
  *        policy.
@@ -479,7 +479,7 @@ static int queue_folios_pmd(pmd_t *pmd, spinlock_t
*ptl, unsigned long addr,
  if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
  if (!vma_migratable(walk->vma) ||
      migrate_folio_add(folio, qp->pagelist, flags)) {
- ret =3D 1;
+ qp->has_unmovable |=3D 1;
  goto unlock;
  }
  } else
@@ -495,9 +495,8 @@ static int queue_folios_pmd(pmd_t *pmd, spinlock_t
*ptl, unsigned long addr,
  *
  * queue_folios_pte_range() has three possible return values:
  * 0 - folios are placed on the right node or queued successfully, or
- *     special page is met, i.e. zero page.
- * 1 - there is unmovable folio, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
- *     specified.
+ *     special page is met, i.e. zero page, or unmovable page is found
+ *     but continue walking (indicated by queue_pages.has_unmovable).
  * -EIO - only MPOL_MF_STRICT was specified and an existing folio was alre=
ady
  *        on a node that does not follow the policy.
  */
@@ -538,10 +537,13 @@ static int queue_folios_pte_range(pmd_t *pmd,
unsigned long addr,
  if (!queue_folio_required(folio, qp))
  continue;
  if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
- /* MPOL_MF_STRICT must be specified if we get here */
+ /*
+ * MPOL_MF_STRICT must be specified if we get here.
+ * Continue walking vmas due to MPOL_MF_MOVE* flags.
+ */
  if (!vma_migratable(vma)) {
- has_unmovable =3D true;
- break;
+ qp->has_unmovable |=3D 1;
+ continue;
  }

  /*
@@ -550,16 +552,13 @@ static int queue_folios_pte_range(pmd_t *pmd,
unsigned long addr,
  * need migrate other LRU pages.
  */
  if (migrate_folio_add(folio, qp->pagelist, flags))
- has_unmovable =3D true;
+ has_unmovable |=3D 1;
  } else
  break;
  }
  pte_unmap_unlock(mapped_pte, ptl);
  cond_resched();

- if (has_unmovable)
- return 1;
-
  return addr !=3D end ? -EIO : 0;
 }

@@ -599,7 +598,7 @@ static int queue_folios_hugetlb(pte_t *pte,
unsigned long hmask,
  * Detecting misplaced folio but allow migrating folios which
  * have been queued.
  */
- ret =3D 1;
+ qp->has_unmovable |=3D 1;
  goto unlock;
  }

@@ -620,7 +619,7 @@ static int queue_folios_hugetlb(pte_t *pte,
unsigned long hmask,
  * Failed to isolate folio but allow migrating pages
  * which have been queued.
  */
- ret =3D 1;
+ qp->has_unmovable |=3D 1;
  }
 unlock:
  spin_unlock(ptl);
@@ -756,12 +755,15 @@ queue_pages_range(struct mm_struct *mm, unsigned
long start, unsigned long end,
  .start =3D start,
  .end =3D end,
  .first =3D NULL,
+ .has_unmovable =3D false,
  };
  const struct mm_walk_ops *ops =3D lock_vma ?
  &queue_pages_lock_vma_walk_ops : &queue_pages_walk_ops;

  err =3D walk_page_range(mm, start, end, ops, &qp);

+ if (qp.has_unmovable)
+ err =3D 1;
  if (!qp.first)
  /* whole range in hole */
  err =3D -EFAULT;
@@ -1358,7 +1360,7 @@ static long do_mbind(unsigned long start,
unsigned long len,
  putback_movable_pages(&pagelist);
  }

- if ((ret > 0) || (nr_failed && (flags & MPOL_MF_STRICT)))
+ if (((ret > 0) || nr_failed) && (flags & MPOL_MF_STRICT))
  err =3D -EIO;
  } else {
 up_out:

>
> Hugh
